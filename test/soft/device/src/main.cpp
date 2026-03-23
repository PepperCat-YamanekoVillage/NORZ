#include <Arduino.h>

#include "z80_bus_host.h"

namespace {

static const unsigned long SERIAL_BAUD = 115200;
static const uint16_t MAX_LINE = 320;

Z80BusHost g_bus;
char g_line[MAX_LINE];

uint16_t parseHex16(const char* s) {
  return static_cast<uint16_t>(strtoul(s, nullptr, 16));
}

uint8_t parseHex8(const char* s) {
  return static_cast<uint8_t>(strtoul(s, nullptr, 16));
}

void printHex8(uint8_t value) {
  if (value < 0x10) {
    Serial.print('0');
  }
  Serial.print(value, HEX);
}

void printHex16(uint16_t value) {
  if (value < 0x1000) Serial.print('0');
  if (value < 0x100) Serial.print('0');
  if (value < 0x10) Serial.print('0');
  Serial.print(value, HEX);
}

void cmdSnapshot() {
  const Z80BusHost::Snapshot s = g_bus.getSnapshot();
  Serial.print(F("SNAP addr="));
  printHex16(s.address);
  Serial.print(F(" data="));
  printHex8(s.data);
  Serial.print(F(" ctrl="));
  printHex8(s.control);
  Serial.print(F(" io_port="));
  printHex8(s.ioPort);
  Serial.print(F(" io_val="));
  printHex8(s.ioValue);
  Serial.println();
}

void cmdTrace() {
  const uint16_t count = g_bus.getTraceCount();
  Serial.print(F("TRACE count="));
  Serial.println(count);
  for (uint16_t i = 0; i < count; ++i) {
    Serial.print(F("M1["));
    Serial.print(i);
    Serial.print(F("]="));
    printHex16(g_bus.getTraceAddress(i));
    Serial.println();
  }
}

void cmdWriteTrace() {
  const uint16_t count = g_bus.getWriteTraceCount();
  Serial.print(F("WTRACE count="));
  Serial.println(count);
  for (uint16_t i = 0; i < count; ++i) {
    const Z80BusHost::WriteEvent e = g_bus.getWriteTraceEvent(i);
    Serial.print(F("W["));
    Serial.print(i);
    Serial.print(F("] addr="));
    printHex16(e.address);
    Serial.print(F(" val="));
    printHex8(e.value);
    Serial.print(F(" flg="));
    printHex8(e.flags);
    Serial.println();
  }
}

void cmdWriteProbe() {
  Serial.print(F("WPROBE "));
  for (uint8_t i = 0; i < 64; ++i) {
    uint8_t value = 0;
    const uint8_t pinc = PINC;
    if (pinc & _BV(7)) value |= static_cast<uint8_t>(1U << 0);
    if (pinc & _BV(6)) value |= static_cast<uint8_t>(1U << 1);
    if (pinc & _BV(5)) value |= static_cast<uint8_t>(1U << 2);
    if (pinc & _BV(4)) value |= static_cast<uint8_t>(1U << 3);
    if (pinc & _BV(3)) value |= static_cast<uint8_t>(1U << 4);
    if (pinc & _BV(2)) value |= static_cast<uint8_t>(1U << 5);
    if (pinc & _BV(1)) value |= static_cast<uint8_t>(1U << 6);
    if (pinc & _BV(0)) value |= static_cast<uint8_t>(1U << 7);
    printHex8(value);
    if (i + 1 != 64) {
      Serial.print(' ');
    }
    delayMicroseconds(2);
  }
  Serial.println();
}

void cmdCaptureRegs(const char* pcToken) {
  const uint16_t traceCount = g_bus.getTraceCount();
  if (traceCount == 0) {
    Serial.println(F("REGS ERR trace"));
    return;
  }

  static const uint16_t kRoutineAddr = 0x8000;
  static const uint16_t kDumpAddr = 0x8100;

  const uint16_t lastPc = g_bus.getTraceAddress(static_cast<uint16_t>(traceCount - 1));
  const Z80BusHost::Snapshot before = g_bus.getSnapshot();

  uint16_t candidates[12];
  uint8_t candidateCount = 0;

  if (pcToken != nullptr) {
    candidates[candidateCount++] = parseHex16(pcToken);
  } else {
    candidates[candidateCount++] = before.address;
    for (int32_t i = static_cast<int32_t>(traceCount) - 1; i >= 0 && candidateCount < 12; --i) {
      const uint16_t pc = g_bus.getTraceAddress(static_cast<uint16_t>(i));
      bool exists = false;
      for (uint8_t j = 0; j < candidateCount; ++j) {
        if (candidates[j] == pc) {
          exists = true;
          break;
        }
      }
      if (!exists) {
        candidates[candidateCount++] = pc;
      }
    }
  }

  uint8_t clearBuf[0x11];
  for (uint8_t i = 0; i < sizeof(clearBuf); ++i) {
    clearBuf[i] = 0x00;
  }
  g_bus.loadMemory(kDumpAddr, clearBuf, sizeof(clearBuf));

  const uint8_t routine[] = {
      0x22, static_cast<uint8_t>((kDumpAddr + 0x08) & 0xFF), static_cast<uint8_t>(((kDumpAddr + 0x08) >> 8) & 0xFF),
      0xED, 0x43, static_cast<uint8_t>((kDumpAddr + 0x04) & 0xFF), static_cast<uint8_t>(((kDumpAddr + 0x04) >> 8) & 0xFF),
      0xED, 0x53, static_cast<uint8_t>((kDumpAddr + 0x06) & 0xFF), static_cast<uint8_t>(((kDumpAddr + 0x06) >> 8) & 0xFF),
      0xDD, 0x22, static_cast<uint8_t>((kDumpAddr + 0x0A) & 0xFF), static_cast<uint8_t>(((kDumpAddr + 0x0A) >> 8) & 0xFF),
      0xFD, 0x22, static_cast<uint8_t>((kDumpAddr + 0x0C) & 0xFF), static_cast<uint8_t>(((kDumpAddr + 0x0C) >> 8) & 0xFF),
      0xED, 0x57,
      0x32, static_cast<uint8_t>((kDumpAddr + 0x0E) & 0xFF), static_cast<uint8_t>(((kDumpAddr + 0x0E) >> 8) & 0xFF),
      0xED, 0x5F,
      0x32, static_cast<uint8_t>((kDumpAddr + 0x0F) & 0xFF), static_cast<uint8_t>(((kDumpAddr + 0x0F) >> 8) & 0xFF),
      0xF5,
      0xE1,
      0x7D,
      0x32, static_cast<uint8_t>((kDumpAddr + 0x02) & 0xFF), static_cast<uint8_t>(((kDumpAddr + 0x02) >> 8) & 0xFF),
      0x7C,
      0x32, static_cast<uint8_t>((kDumpAddr + 0x03) & 0xFF), static_cast<uint8_t>(((kDumpAddr + 0x03) >> 8) & 0xFF),
      0x21, 0x00, 0x00,
      0x39,
      0x22, static_cast<uint8_t>(kDumpAddr & 0xFF), static_cast<uint8_t>((kDumpAddr >> 8) & 0xFF),
      0x3E, 0xA5,
      0x32, static_cast<uint8_t>((kDumpAddr + 0x10) & 0xFF), static_cast<uint8_t>(((kDumpAddr + 0x10) >> 8) & 0xFF),
      0x76,
  };
  g_bus.loadMemory(kRoutineAddr, routine, sizeof(routine));

  const uint8_t jp[3] = {0xC3, static_cast<uint8_t>(kRoutineAddr & 0xFF), static_cast<uint8_t>((kRoutineAddr >> 8) & 0xFF)};
  for (uint8_t i = 0; i < candidateCount; ++i) {
    g_bus.loadMemory(candidates[i], jp, 3);
  }

  g_bus.stepCycles(500);

  const uint8_t marker = g_bus.readMemory(static_cast<uint16_t>(kDumpAddr + 0x10));
  if (marker != 0xA5) {
    Serial.print(F("REGS ERR marker="));
    printHex8(marker);
    Serial.println();
    return;
  }

  const uint8_t spLo = g_bus.readMemory(kDumpAddr + 0x00);
  const uint8_t spHi = g_bus.readMemory(kDumpAddr + 0x01);
  const uint8_t f = g_bus.readMemory(kDumpAddr + 0x02);
  const uint8_t a = g_bus.readMemory(kDumpAddr + 0x03);
  const uint8_t c = g_bus.readMemory(kDumpAddr + 0x04);
  const uint8_t b = g_bus.readMemory(kDumpAddr + 0x05);
  const uint8_t e = g_bus.readMemory(kDumpAddr + 0x06);
  const uint8_t d = g_bus.readMemory(kDumpAddr + 0x07);
  const uint8_t l = g_bus.readMemory(kDumpAddr + 0x08);
  const uint8_t h = g_bus.readMemory(kDumpAddr + 0x09);
  const uint8_t ixLo = g_bus.readMemory(kDumpAddr + 0x0A);
  const uint8_t ixHi = g_bus.readMemory(kDumpAddr + 0x0B);
  const uint8_t iyLo = g_bus.readMemory(kDumpAddr + 0x0C);
  const uint8_t iyHi = g_bus.readMemory(kDumpAddr + 0x0D);
  const uint8_t iReg = g_bus.readMemory(kDumpAddr + 0x0E);
  const uint8_t rReg = g_bus.readMemory(kDumpAddr + 0x0F);

  const uint16_t sp = static_cast<uint16_t>((static_cast<uint16_t>(spHi) << 8) | spLo);
  const uint16_t ix = static_cast<uint16_t>((static_cast<uint16_t>(ixHi) << 8) | ixLo);
  const uint16_t iy = static_cast<uint16_t>((static_cast<uint16_t>(iyHi) << 8) | iyLo);
  const Z80BusHost::Snapshot after = g_bus.getSnapshot();
  const uint8_t lhalt = (after.control & (1U << 6)) ? 1 : 0;

  Serial.print(F("REGS A="));
  printHex8(a);
  Serial.print(F(" F="));
  printHex8(f);
  Serial.print(F(" B="));
  printHex8(b);
  Serial.print(F(" C="));
  printHex8(c);
  Serial.print(F(" D="));
  printHex8(d);
  Serial.print(F(" E="));
  printHex8(e);
  Serial.print(F(" H="));
  printHex8(h);
  Serial.print(F(" L="));
  printHex8(l);
  Serial.print(F(" IX="));
  printHex16(ix);
  Serial.print(F(" IY="));
  printHex16(iy);
  Serial.print(F(" SP="));
  printHex16(sp);
  Serial.print(F(" I="));
  printHex8(iReg);
  Serial.print(F(" R="));
  printHex8(rReg);
  Serial.print(F(" LHALT="));
  printHex8(lhalt);
  Serial.print(F(" PC="));
  printHex16(lastPc);
  Serial.println();
}

void cmdIdxDbg() {
  const Z80BusHost::IndexedDebug d = g_bus.getIndexedDebug();
  Serial.print(F("IDXDBG ix="));
  printHex16(d.ix);
  Serial.print(F(" iy="));
  printHex16(d.iy);
  Serial.print(F(" paddr="));
  printHex16(d.pendingAddr);
  Serial.print(F(" pop="));
  printHex8(d.pendingOp);
  Serial.print(F(" pre="));
  printHex8(d.prefix);
  Serial.print(F(" pend="));
  printHex8(d.pending);
  Serial.println();
}

void handleCommand(char* line) {
  char* cmd = strtok(line, " \t\r\n");
  if (cmd == nullptr) {
    return;
  }

  if (strcmp(cmd, "PING") == 0) {
    Serial.println(F("OK"));
    return;
  }

  if (strcmp(cmd, "RESET") == 0) {
    g_bus.resetPulse();
    g_bus.clearTrace();
    g_bus.clearWriteTrace();
    Serial.println(F("OK"));
    return;
  }

  if (strcmp(cmd, "DATA_SRC") == 0) {
    char* valueToken = strtok(nullptr, " \t\r\n");
    if (valueToken == nullptr) {
      Serial.println(F("ERR DATA_SRC usage: DATA_SRC D|O"));
      return;
    }
    if (strcmp(valueToken, "D") == 0) {
      g_bus.setDataReadSource(Z80BusHost::DataReadSource::kDataBus);
      Serial.println(F("OK"));
      return;
    }
    if (strcmp(valueToken, "O") == 0) {
      g_bus.setDataReadSource(Z80BusHost::DataReadSource::kDoutBus);
      Serial.println(F("OK"));
      return;
    }
    Serial.println(F("ERR DATA_SRC expected D or O"));
    return;
  }

  if (strcmp(cmd, "CLK_US") == 0) {
    char* valueToken = strtok(nullptr, " \t\r\n");
    if (valueToken == nullptr) {
      Serial.println(F("ERR CLK_US usage: CLK_US value"));
      return;
    }
    const uint16_t value = static_cast<uint16_t>(strtoul(valueToken, nullptr, 10));
    g_bus.setHalfCycleUs(value);
    Serial.println(F("OK"));
    return;
  }

  if (strcmp(cmd, "CLEAR") == 0) {
    char* valueToken = strtok(nullptr, " \t\r\n");
    const uint8_t value = (valueToken == nullptr) ? 0x00 : parseHex8(valueToken);
    g_bus.clearMemory(value);
    g_bus.clearWriteTrace();
    Serial.println(F("OK"));
    return;
  }

  if (strcmp(cmd, "LOAD") == 0) {
    char* addrToken = strtok(nullptr, " \t\r\n");
    if (addrToken == nullptr) {
      Serial.println(F("ERR LOAD missing address"));
      return;
    }

    uint16_t addr = parseHex16(addrToken);
    uint16_t loaded = 0;
    uint8_t byteValue = 0;
    uint8_t one[1];
    while (true) {
      char* dt = strtok(nullptr, " \t\r\n");
      if (dt == nullptr) {
        break;
      }
      byteValue = parseHex8(dt);
      one[0] = byteValue;
      g_bus.loadMemory(static_cast<uint16_t>(addr + loaded), one, 1);
      ++loaded;
    }

    Serial.print(F("OK loaded="));
    Serial.println(loaded);
    return;
  }

  if (strcmp(cmd, "RUN") == 0) {
    char* cyclesToken = strtok(nullptr, " \t\r\n");
    if (cyclesToken == nullptr) {
      Serial.println(F("ERR RUN missing cycles"));
      return;
    }
    const uint32_t cycles = strtoul(cyclesToken, nullptr, 10);
    g_bus.stepCycles(cycles);
    Serial.println(F("OK"));
    return;
  }

  if (strcmp(cmd, "STEP") == 0) {
    g_bus.stepHalfCycle();
    Serial.println(F("OK"));
    return;
  }

  if (strcmp(cmd, "SNAP") == 0) {
    cmdSnapshot();
    return;
  }

  if (strcmp(cmd, "MEM") == 0) {
    char* addrToken = strtok(nullptr, " \t\r\n");
    char* lenToken = strtok(nullptr, " \t\r\n");
    if (addrToken == nullptr || lenToken == nullptr) {
      Serial.println(F("ERR MEM usage: MEM addr len"));
      return;
    }
    const uint16_t addr = parseHex16(addrToken);
    const uint16_t len = parseHex16(lenToken);

    Serial.print(F("MEM "));
    printHex16(addr);
    Serial.print(F(" "));
    printHex16(len);
    Serial.print(F(" "));
    for (uint16_t i = 0; i < len; ++i) {
      printHex8(g_bus.readMemory(static_cast<uint16_t>(addr + i)));
      if (i + 1 != len) {
        Serial.print(' ');
      }
    }
    Serial.println();
    return;
  }

  if (strcmp(cmd, "TRACE") == 0) {
    cmdTrace();
    return;
  }

  if (strcmp(cmd, "WTRACE") == 0) {
    cmdWriteTrace();
    return;
  }

  if (strcmp(cmd, "WPROBE") == 0) {
    cmdWriteProbe();
    return;
  }

  if (strcmp(cmd, "IDXDBG") == 0) {
    cmdIdxDbg();
    return;
  }

  if (strcmp(cmd, "CAPREG") == 0) {
    char* pcToken = strtok(nullptr, " \t\r\n");
    cmdCaptureRegs(pcToken);
    return;
  }

  Serial.println(F("ERR unknown command"));
}

}  // namespace

void setup() {
  Serial.begin(SERIAL_BAUD);
  while (!Serial) {
  }

  g_bus.begin();
  g_bus.clearMemory(0x00);
  g_bus.resetPulse();
  g_bus.clearTrace();

  Serial.println(F("READY"));
}

void loop() {
  if (!Serial.available()) {
    return;
  }

  const size_t n = Serial.readBytesUntil('\n', g_line, MAX_LINE - 1);
  g_line[n] = '\0';
  handleCommand(g_line);
}
