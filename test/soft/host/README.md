# Host Runner (Mega2560 + Z80)

This script drives the Mega2560 firmware over serial and runs text tests from `_test/tests_txt`.

## Setup

```bash
cd host
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Run

```bash
python run_tests.py --port /dev/ttyACM0 --tests ../_test/tests_txt --filter MEGA --data-src D --half-cycle-us 20 --cycles 300
```

## Make Targets

```bash
make run                 # default run
make test                # run all tests, save to log-test-all.txt
make expand              # run by category, save log25-*.txt
make debug               # focused IO/BIT run, save log34-*.txt
```

You can override serial port and options:

```bash
make test PORT=/dev/cu.usbserial-1140 RUN_OPTS="--half-cycle-us 100 --cycles 300"
```

## Notes

- Current runner evaluates `PC=` assertions via M1 trace and memory assertions via `(<addr>)=<value>`.
- Use `--strict-reg` to enforce register/flag assertions (`A..L`, `IX/IY/SP`, `F`, `FlagS/Z/H/PV/N/C`, `I`, `R`, `LHALT`) via firmware command `CAPREG`.
- Default mode keeps compatibility with previous behavior (memory + PC assertions), and does not fail tests when snapshot capture is unavailable.
- `IMFa`, `IMFb`, `IFF1`, `IFF2` are parsed but not enforced by default because they are not directly exposed by the current snapshot protocol.
- `--data-src` selects write-data input source (`D`=D bus default, `O`=Dout bus).
- `--half-cycle-us` controls bus speed; increase this if write/read sampling is unstable.

Debug write trace for `MEGA/LD (nn),HL write`:

```bash
python run_tests.py --port /dev/ttyACM0 --filter MEGA --debug-ldnnhl
```
