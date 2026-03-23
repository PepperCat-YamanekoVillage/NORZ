# Device Firmware (PlatformIO)

Arduino Mega2560 firmware that hosts a Z80 bus cycle runner.

## Build

```bash
cd device
pio run
```

## Upload

```bash
cd device
pio run --target upload
pio device monitor --baud 115200
```

## Serial Commands

- `PING`
- `RESET`
- `DATA_SRC <D|O>`
- `CLK_US <halfCycleUs>`
- `CLEAR [byteHex]`
- `LOAD <addrHex> <b0> <b1> ...`
- `RUN <cyclesDec>`
- `STEP`
- `SNAP`
- `MEM <addrHex> <lenHex>`
- `TRACE`
- `WTRACE`

All responses are single-line ASCII.

`DATA_SRC` selects which bus is used when reading Z80 write data:
- `D`: read from D0-D7 pins (default)
- `O`: read from Dout0-Dout7 pins

`CLK_US` sets half-cycle length in microseconds (default: 20).
