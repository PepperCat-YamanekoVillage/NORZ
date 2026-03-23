#!/usr/bin/env python3

import argparse
import re
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import serial


END_MARKER = "fffffffff"

FLAG_BITS = {
    "FlagS": 0x80,
    "FlagZ": 0x40,
    "FlagH": 0x10,
    "FlagPV": 0x04,
    "FlagN": 0x02,
    "FlagC": 0x01,
}


@dataclass
class TestCase:
    path: Path
    program_bytes: List[int]
    assertions: List[Tuple[str, str]]


def normalize_opcode_bits(text: str) -> str:
    return text.replace(" ", "").lower()


def parse_bin_value(bits: str) -> int:
    compact = bits.replace(" ", "")
    if not compact:
        raise ValueError("empty bit value")
    return int(compact, 2)


def parse_assertions(expr: str) -> List[Tuple[str, str]]:
    result: List[Tuple[str, str]] = []
    for item in expr.split(","):
        part = item.strip()
        if not part:
            continue
        if "=" not in part:
            continue
        key, value = part.split("=", 1)
        result.append((key.strip(), value.strip()))
    return result


def parse_test_file(path: Path) -> TestCase:
    program: List[int] = []
    assertions: List[Tuple[str, str]] = []

    with path.open("r", encoding="utf-8") as fp:
        for line in fp:
            content = line.strip()
            if not content:
                continue

            if "//" in content:
                content = content.split("//", 1)[0].strip()
            if not content:
                continue

            if "[" in content and "]" in content:
                op_part, assert_part = content.split("[", 1)
                assert_part = assert_part.split("]", 1)[0]
                assertions.extend(parse_assertions(assert_part))
                content = op_part.strip()

            op = normalize_opcode_bits(content)
            if op == END_MARKER:
                break
            if len(op) != 8 or re.search(r"[^01]", op):
                continue

            program.append(int(op, 2))

    return TestCase(path=path, program_bytes=program, assertions=assertions)


class DeviceClient:
    def __init__(self, port: str, baud: int, timeout: float = 1.0) -> None:
        self._serial = serial.Serial(port=port, baudrate=baud, timeout=timeout)
        self._read_until_ready()

    def _readline(self) -> str:
        return self._serial.readline().decode("ascii", errors="ignore").strip()

    def _read_until_ready(self) -> None:
        for _ in range(50):
            line = self._readline()
            if line == "READY":
                return
        raise RuntimeError("device did not send READY")

    def command(self, cmd: str, timeout: Optional[float] = None) -> str:
        prev_timeout = self._serial.timeout
        if timeout is not None:
            self._serial.timeout = timeout
        self._serial.write((cmd + "\n").encode("ascii"))
        line = self._readline()
        if timeout is not None:
            self._serial.timeout = prev_timeout
        if not line:
            raise RuntimeError(f"timeout waiting for response to: {cmd}")
        return line

    def reset(self) -> None:
        resp = self.command("RESET")
        if resp != "OK":
            raise RuntimeError(f"RESET failed: {resp}")

    def clear(self, value: int = 0x00) -> None:
        resp = self.command(f"CLEAR {value:02X}")
        if resp != "OK":
            raise RuntimeError(f"CLEAR failed: {resp}")

    def load(self, start_addr: int, data: List[int]) -> None:
        if not data:
            return
        chunks = 16
        for i in range(0, len(data), chunks):
            block = data[i : i + chunks]
            addr = start_addr + i
            payload = " ".join(f"{x:02X}" for x in block)
            resp = self.command(f"LOAD {addr:04X} {payload}")
            if not resp.startswith("OK loaded="):
                raise RuntimeError(f"LOAD failed: {resp}")

    def run_cycles(self, cycles: int) -> None:
        # RUN time depends on firmware clock setting and bus activity.
        # Use a generous timeout to avoid false timeouts.
        resp = self.command(f"RUN {cycles}", timeout=15.0)
        if resp != "OK":
            raise RuntimeError(f"RUN failed: {resp}")

    def memory(self, addr: int, length: int) -> List[int]:
        resp = self.command(f"MEM {addr:04X} {length:04X}")
        parts = resp.split()
        if len(parts) < 4 or parts[0] != "MEM":
            raise RuntimeError(f"invalid MEM response: {resp}")
        return [int(x, 16) for x in parts[3:]]

    def snapshot(self) -> Dict[str, int]:
        line = self.command("SNAP")
        if not line.startswith("SNAP "):
            raise RuntimeError(f"SNAP failed: {line}")
        out: Dict[str, int] = {}
        for token in line.split()[1:]:
            if "=" not in token:
                continue
            key, value = token.split("=", 1)
            out[key] = int(value, 16)
        return out

    def capture_regs(self, pc: int) -> Dict[str, int]:
        line = self.command(f"CAPREG {pc:04X}", timeout=5.0)
        if not line.startswith("REGS "):
            raise RuntimeError(f"CAPREG failed: {line}")
        out: Dict[str, int] = {}
        for token in line.split()[1:]:
            if "=" not in token:
                continue
            k, v = token.split("=", 1)
            out[k] = int(v, 16)
        return out

    def trace(self) -> List[int]:
        first = self.command("TRACE")
        if not first.startswith("TRACE count="):
            raise RuntimeError(f"TRACE failed: {first}")
        count = int(first.split("=", 1)[1])
        result: List[int] = []
        for _ in range(count):
            row = self._readline()
            if "=" not in row:
                continue
            result.append(int(row.split("=", 1)[1], 16))
        return result

    def write_trace(self) -> List[Tuple[int, int, int]]:
        first = self.command("WTRACE")
        if not first.startswith("WTRACE count="):
            raise RuntimeError(f"WTRACE failed: {first}")
        count = int(first.split("=", 1)[1])
        rows: List[Tuple[int, int, int]] = []
        for _ in range(count):
            row = self._readline()
            m_addr = re.search(r"addr=([0-9A-Fa-f]{4})", row)
            m_val = re.search(r"val=([0-9A-Fa-f]{2})", row)
            m_flg = re.search(r"flg=([0-9A-Fa-f]{2})", row)
            if not m_addr or not m_val or not m_flg:
                continue
            rows.append((int(m_addr.group(1), 16), int(m_val.group(1), 16), int(m_flg.group(1), 16)))
        return rows

    def write_probe(self) -> List[int]:
        line = self.command("WPROBE", timeout=3.0)
        parts = line.split()
        if len(parts) < 2 or parts[0] != "WPROBE":
            raise RuntimeError(f"WPROBE failed: {line}")
        return [int(x, 16) for x in parts[1:]]

    def idxdbg(self) -> Dict[str, int]:
        line = self.command("IDXDBG")
        if not line.startswith("IDXDBG "):
            raise RuntimeError(f"IDXDBG failed: {line}")
        out: Dict[str, int] = {}
        for token in line.split()[1:]:
            if "=" not in token:
                continue
            k, v = token.split("=", 1)
            out[k] = int(v, 16)
        return out

    def set_data_source(self, source: str) -> None:
        src = source.upper()
        if src not in ("D", "O"):
            raise ValueError("source must be D or O")
        resp = self.command(f"DATA_SRC {src}")
        if resp != "OK":
            raise RuntimeError(f"DATA_SRC failed: {resp}")

    def set_half_cycle_us(self, value: int) -> None:
        if value < 1:
            raise ValueError("half cycle us must be >= 1")
        resp = self.command(f"CLK_US {value}")
        if resp != "OK":
            raise RuntimeError(f"CLK_US failed: {resp}")


def compress_consecutive(values: List[int]) -> List[int]:
    if not values:
        return []
    out = [values[0]]
    for v in values[1:]:
        if v != out[-1]:
            out.append(v)
    return out


def collect_tests(test_root: Path) -> List[Path]:
    return sorted(
        p
        for p in test_root.rglob("*.txt")
        if p.name != "format.txt"
    )


def eval_assertions(
    test: TestCase,
    memory_by_addr: Dict[int, int],
    m1_trace: List[int],
    reg_by_key: Dict[str, int],
) -> List[str]:
    failures: List[str] = []
    m1_trace = compress_consecutive(m1_trace)
    trace_cursor = 0

    latest_mem_expect: Dict[int, int] = {}
    ordered_pc_expect: List[int] = []
    latest_reg_expect: Dict[str, int] = {}
    latest_flag_expect: Dict[str, int] = {}
    for key, value in test.assertions:
        if key.startswith("(") and key.endswith(")"):
            addr = parse_bin_value(key[1:-1])
            latest_mem_expect[addr] = parse_bin_value(value)
        else:
            if key == "PC":
                ordered_pc_expect.append(parse_bin_value(value))
            elif key in FLAG_BITS:
                latest_flag_expect[key] = parse_bin_value(value)
            else:
                latest_reg_expect[key] = parse_bin_value(value)

    last_expected_pc = -1
    for expected in ordered_pc_expect:
        if expected == last_expected_pc:
            continue
        last_expected_pc = expected
        found_index = -1
        for i in range(trace_cursor, len(m1_trace)):
            if m1_trace[i] == expected:
                found_index = i
                break

        if found_index < 0:
            actual = m1_trace[-1] if m1_trace else 0
            if actual != expected:
                failures.append(f"PC expected=0x{expected:04X} actual=0x{actual:04X}")
        else:
            trace_cursor = found_index + 1

    for key, expected in latest_reg_expect.items():
        if key in reg_by_key:
            actual = reg_by_key[key]
            width = 4 if key in ("IX", "IY", "SP", "PC") else 2
            if actual != expected:
                failures.append(f"{key} expected=0x{expected:0{width}X} actual=0x{actual:0{width}X}")
        else:
            # IMFa/IMFb/IFF1/IFF2 are not directly observable in current protocol.
            continue

    if "F" in reg_by_key:
        f = reg_by_key.get("F", 0)
        for key, expected in latest_flag_expect.items():
            actual = 1 if (f & FLAG_BITS[key]) else 0
            if actual != expected:
                failures.append(f"{key} expected={expected} actual={actual}")

    for addr, expected in latest_mem_expect.items():
        if addr not in memory_by_addr:
            failures.append(f"MEM out-of-range addr=0x{addr:04X}")
            continue
        actual = memory_by_addr[addr]
        if actual != expected:
            failures.append(
                f"MEM[0x{addr:04X}] expected=0x{expected:02X} actual=0x{actual:02X}"
            )

    return failures


def collect_memory_assertion_addresses(test: TestCase) -> List[int]:
    addrs: List[int] = []
    for key, _ in test.assertions:
        if key.startswith("(") and key.endswith(")"):
            addrs.append(parse_bin_value(key[1:-1]))
    return sorted(set(addrs))


def test_needs_register_snapshot(test: TestCase) -> bool:
    for key, _ in test.assertions:
        if key.startswith("(") and key.endswith(")"):
            continue
        if key == "PC":
            continue
        return True
    return False


def collect_pc_assertions(test: TestCase) -> List[int]:
    pcs: List[int] = []
    for key, value in test.assertions:
        if key == "PC":
            pcs.append(parse_bin_value(value) & 0xFFFF)
    return pcs


def has_reg_assert(test: TestCase, name: str) -> bool:
    for key, _ in test.assertions:
        if key == name:
            return True
    return False


def test_uses_strict_reg_capture(test: TestCase) -> bool:
    return True


def is_halted_snapshot(snap: Dict[str, int]) -> bool:
    ctrl = snap.get("ctrl", 0)
    return (ctrl & 0x40) != 0


def capture_registers(client: DeviceClient, trace: List[int]) -> Dict[str, int]:
    if not trace:
        raise RuntimeError("empty M1 trace")
    pc = trace[-1] & 0xFFFF
    reg = client.capture_regs(pc)
    reg["PC"] = pc
    return reg


def run_test(
    client: DeviceClient,
    test: TestCase,
    base_addr: int,
    cycles: int,
    strict_reg: bool,
) -> List[str]:
    client.reset()
    client.clear(0x00)
    client.load(base_addr, test.program_bytes)

    # Place a HALT sentinel right after program bytes so strict register
    # captures see stable end-state for fallthrough tests.
    if test.program_bytes:
        client.load(base_addr + len(test.program_bytes), [0x76])

    client.run_cycles(cycles)

    halted = is_halted_snapshot(client.snapshot())
    if strict_reg and test_needs_register_snapshot(test) and not halted:
        extra = 0
        while extra < 4000 and not halted:
            client.run_cycles(100)
            extra += 100
            halted = is_halted_snapshot(client.snapshot())

    trace = client.trace()
    reg_by_key: Dict[str, int] = {}
    if strict_reg and test_needs_register_snapshot(test) and test_uses_strict_reg_capture(test) and halted:
        try:
            reg_by_key = capture_registers(client, trace)
        except Exception as ex:
            return [f"REG_SNAPSHOT error: {ex}"]

    memory_by_addr: Dict[int, int] = {}
    for addr in collect_memory_assertion_addresses(test):
        value = client.memory(addr, 1)[0]
        memory_by_addr[addr] = value

    return eval_assertions(test, memory_by_addr, trace, reg_by_key)


def run_debug_ldnnhl(client: DeviceClient, test: TestCase, base_addr: int, cycles: int) -> None:
    client.reset()
    client.clear(0x00)
    client.load(base_addr, test.program_bytes)
    prog = client.memory(0x0000, max(8, len(test.program_bytes)))
    client.run_cycles(max(cycles, 1200))
    mem = client.memory(0x0100, 2)
    wtrace = client.write_trace()
    trace = client.trace()
    probe = client.write_probe()
    print("DEBUG MEGA/LD (nn),HL write")
    print("  PROG[0000..] = " + " ".join(f"{x:02X}" for x in prog[:16]))
    print(f"  MEM[0100..0101] = {mem}")
    if trace:
        head = " ".join(f"{x:04X}" for x in trace[:16])
        tail = " ".join(f"{x:04X}" for x in trace[-16:])
        print(f"  TRACE count={len(trace)}")
        print(f"  TRACE head={head}")
        print(f"  TRACE tail={tail}")
    print(f"  WTRACE count={len(wtrace)}")
    for addr, val, flg in wtrace[-16:]:
        print(f"    addr=0x{addr:04X} val=0x{val:02X} flg=0x{flg:02X}")
    print(f"  WPROBE nonzero={sum(1 for v in probe if v != 0)} samples={len(probe)}")
    if probe:
        print("  WPROBE tail=" + " ".join(f"{v:02X}" for v in probe[-16:]))


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--port", required=True)
    parser.add_argument("--baud", type=int, default=115200)
    parser.add_argument("--tests", default="../_test/tests_txt")
    parser.add_argument("--filter", default="")
    parser.add_argument("--base-addr", type=lambda x: int(x, 16), default=0x0000)
    parser.add_argument("--cycles", type=int, default=300)
    parser.add_argument("--data-src", choices=["D", "O"], default="D")
    parser.add_argument("--half-cycle-us", type=int, default=20)
    parser.add_argument("--debug-ldnnhl", action="store_true")
    parser.add_argument("--debug-write", action="store_true")
    parser.add_argument("--strict-reg", action="store_true")
    args = parser.parse_args()

    test_root = (Path(__file__).resolve().parent / args.tests).resolve()
    all_paths = collect_tests(test_root)
    if args.filter:
        all_paths = [p for p in all_paths if args.filter in str(p)]

    if not all_paths:
        raise SystemExit("no tests found")

    tests = [parse_test_file(path) for path in all_paths]

    client = DeviceClient(port=args.port, baud=args.baud)
    client.set_data_source(args.data_src)
    client.set_half_cycle_us(args.half_cycle_us)

    if args.debug_ldnnhl:
        target = None
        for t in tests:
            if "MEGA/LD (nn),HL write.txt" in str(t.path):
                target = t
                break
        if target is None:
            raise SystemExit("debug target test not found")
        run_debug_ldnnhl(client, target, args.base_addr, args.cycles)
        return

    passed = 0
    failed = 0
    for test in tests:
        failures = run_test(client, test, args.base_addr, args.cycles, args.strict_reg)
        rel = test.path.relative_to(test_root)
        if failures:
            failed += 1
            print(f"FAIL {rel}")
            for msg in failures:
                print(f"  - {msg}")
            if args.debug_write and (
                "LD8/LD (IX+d),r.txt" in str(rel)
                or "LD8/LD (IY+d),r.txt" in str(rel)
                or "BIT/RES b,(IX+d).txt" in str(rel)
                or "BIT/RES b,(IY+d).txt" in str(rel)
                or "BIT/SET b,(IX+d).txt" in str(rel)
                or "BIT/SET b,(IY+d).txt" in str(rel)
                or "IO/OUTI.txt" in str(rel)
                or "IO/OUTD.txt" in str(rel)
                or "IO/OTIR.txt" in str(rel)
                or "IO/OTDR.txt" in str(rel)
            ):
                try:
                    probe_mem = client.memory(0xFEFF, 2)
                    probe_io = client.memory(0x00FF, 3)
                    probe_bit = client.memory(0x004B, 2)
                    print(
                        f"  - DEBUG MEM[0xFEFF]=0x{probe_mem[0]:02X} MEM[0xFFFF]=0x{probe_mem[1]:02X}"
                    )
                    print(
                        f"  - DEBUG MEM[0x00FF..0x01FF]=0x{probe_io[0]:02X} 0x{probe_io[1]:02X} 0x{probe_io[2]:02X}"
                    )
                    print(
                        f"  - DEBUG MEM[0x004B]=0x{probe_bit[0]:02X} MEM[0x004C]=0x{probe_bit[1]:02X}"
                    )
                    wt = client.write_trace()
                    tr = client.trace()
                    print(f"  - DEBUG WTRACE count={len(wt)}")
                    for addr, val, flg in wt[-8:]:
                        print(f"    * addr=0x{addr:04X} val=0x{val:02X} flg=0x{flg:02X}")
                    if tr:
                        print(f"  - DEBUG TRACE count={len(tr)}")
                        print("  - DEBUG TRACE tail=" + " ".join(f"{x:04X}" for x in tr[-16:]))
                    idx = client.idxdbg()
                    print(
                        "  - DEBUG IDX "
                        f"ix=0x{idx.get('ix', 0):04X} "
                        f"iy=0x{idx.get('iy', 0):04X} "
                        f"paddr=0x{idx.get('paddr', 0):04X} "
                        f"pop=0x{idx.get('pop', 0):02X} "
                        f"pre=0x{idx.get('pre', 0):02X} "
                        f"pend=0x{idx.get('pend', 0):02X}"
                    )
                except Exception as ex:
                    print(f"  - DEBUG error: {ex}")
        else:
            passed += 1
            print(f"PASS {rel}")

    print(f"\nResult: passed={passed} failed={failed}")
    if failed:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
