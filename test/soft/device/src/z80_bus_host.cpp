#include "z80_bus_host.h"

#include "pinmap.h"

namespace {

static const uint8_t CTRL_MREQ = 1 << 0;
static const uint8_t CTRL_IORQ = 1 << 1;
static const uint8_t CTRL_RD = 1 << 2;
static const uint8_t CTRL_WR = 1 << 3;
static const uint8_t CTRL_M1 = 1 << 4;
static const uint8_t CTRL_RFSH = 1 << 5;
static const uint8_t CTRL_HALT = 1 << 6;
static const uint8_t CTRL_BUSAK = 1 << 7;

static const uint8_t RESET_LOW_HALF_CYCLES = 12;
static const uint8_t RESET_HIGH_HALF_CYCLES = 0;
static const uint16_t DEFAULT_HALF_CYCLE_US = 50;
static const uint8_t BUS_SAMPLES_PER_HALF = 4;
static const uint8_t WR_OVERSAMPLE_COUNT = 8;
static const uint8_t WR_OVERSAMPLE_US = 2;
static const uint8_t WRITE_OR_FALLBACK_MASK = 0x03;

bool isDdFdCbSetResOpcode(uint8_t op) {
  return (op & 0xC0) == 0x80 || (op & 0xC0) == 0xC0;
}

bool isSetResMemOpcode(uint8_t op) {
  return isDdFdCbSetResOpcode(op) && ((op & 0x07) == 0x06);
}

uint8_t applyDdFdCbSetRes(uint8_t value, uint8_t op) {
  const uint8_t bit = static_cast<uint8_t>((op >> 3) & 0x07);
  const uint8_t group = static_cast<uint8_t>(op & 0xC0);
  if (group == 0x80) {
    return static_cast<uint8_t>(value & static_cast<uint8_t>(~(1U << bit)));
  }
  if (group == 0xC0) {
    return static_cast<uint8_t>(value | static_cast<uint8_t>(1U << bit));
  }
  return value;
}

uint8_t readPortCDataBus() {
  const uint8_t pinc = PINC;
  uint8_t value = 0;
  if (pinc & _BV(7)) value |= static_cast<uint8_t>(1U << 0);
  if (pinc & _BV(6)) value |= static_cast<uint8_t>(1U << 1);
  if (pinc & _BV(5)) value |= static_cast<uint8_t>(1U << 2);
  if (pinc & _BV(4)) value |= static_cast<uint8_t>(1U << 3);
  if (pinc & _BV(3)) value |= static_cast<uint8_t>(1U << 4);
  if (pinc & _BV(2)) value |= static_cast<uint8_t>(1U << 5);
  if (pinc & _BV(1)) value |= static_cast<uint8_t>(1U << 6);
  if (pinc & _BV(0)) value |= static_cast<uint8_t>(1U << 7);
  return value;
}

uint8_t readPortFDataBus() {
  const uint8_t pinf = PINF;
  uint8_t value = 0;
  if (pinf & _BV(0)) value |= static_cast<uint8_t>(1U << 0);
  if (pinf & _BV(1)) value |= static_cast<uint8_t>(1U << 1);
  if (pinf & _BV(2)) value |= static_cast<uint8_t>(1U << 2);
  if (pinf & _BV(3)) value |= static_cast<uint8_t>(1U << 3);
  if (pinf & _BV(4)) value |= static_cast<uint8_t>(1U << 4);
  if (pinf & _BV(5)) value |= static_cast<uint8_t>(1U << 5);
  if (pinf & _BV(6)) value |= static_cast<uint8_t>(1U << 6);
  if (pinf & _BV(7)) value |= static_cast<uint8_t>(1U << 7);
  return value;
}

void accumulateBits(uint8_t value, uint16_t highCount[8]) {
  for (uint8_t i = 0; i < 8; ++i) {
    if ((value & static_cast<uint8_t>(1U << i)) != 0) {
      highCount[i]++;
    }
  }
}

}  // namespace

void Z80BusHost::begin() {
  setupPins();
  clearMemory(0x00);
  snapshot_ = {0, 0, 0, 0, 0};
  clearTrace();
  dataReadSource_ = DataReadSource::kDataBus;
  halfCycleUs_ = DEFAULT_HALF_CYCLE_US;
  clkHigh_ = false;
  writeActive_ = false;
  writeIsIo_ = false;
  writeAddress_ = 0;
  writeHighMax_ = 0;
  writeValue_ = 0;
  writeSampleCount_ = 0;
  writeSawNonZero_ = false;
  writeLastNonZero_ = 0;
  writeOrValue_ = 0;
  writeTraceCount_ = 0;
  writeTraceHead_ = 0;
  prevM1Low_ = false;
  pendingDdFdCbWrite_ = false;
  pendingDdFdCbOp_ = 0;
  pendingDdFdCbAddr_ = 0;
  decodePrefix_ = 0;
  ixReg_ = 0;
  iyReg_ = 0;
  nextEvictPage_ = 4;
  for (uint8_t i = 0; i < 8; ++i) {
    writeBitHighCount_[i] = 0;
  }
  digitalWrite(pinmap::PIN_CLK, LOW);
}

void Z80BusHost::setHalfCycleUs(uint16_t value) {
  if (value == 0) {
    halfCycleUs_ = 1;
    return;
  }
  halfCycleUs_ = value;
}

void Z80BusHost::setDataReadSource(DataReadSource source) {
  dataReadSource_ = source;
}

void Z80BusHost::setupPins() {
  pinMode(pinmap::PIN_CLK, OUTPUT);
  pinMode(pinmap::PIN_RESET, OUTPUT);
  pinMode(pinmap::PIN_NMI, OUTPUT);
  pinMode(pinmap::PIN_INT, OUTPUT);
  pinMode(pinmap::PIN_WAIT, OUTPUT);
  pinMode(pinmap::PIN_BUSRQ, OUTPUT);

  pinMode(pinmap::PIN_MREQ, INPUT_PULLUP);
  pinMode(pinmap::PIN_IORQ, INPUT_PULLUP);
  pinMode(pinmap::PIN_RD, INPUT_PULLUP);
  pinMode(pinmap::PIN_WR, INPUT_PULLUP);
  pinMode(pinmap::PIN_M1, INPUT_PULLUP);
  pinMode(pinmap::PIN_RFSH, INPUT_PULLUP);
  pinMode(pinmap::PIN_HALT, INPUT_PULLUP);
  pinMode(pinmap::PIN_BUSAK, INPUT_PULLUP);

  for (uint8_t i = 0; i < 16; ++i) {
    pinMode(pinmap::ADDR_PINS[i], INPUT_PULLUP);
  }

  for (uint8_t i = 0; i < 8; ++i) {
    pinMode(pinmap::DOUT_PINS[i], INPUT);
    digitalWrite(pinmap::DOUT_PINS[i], LOW);
  }

  setDataBusInput();

  digitalWrite(pinmap::PIN_RESET, HIGH);
  digitalWrite(pinmap::PIN_NMI, HIGH);
  digitalWrite(pinmap::PIN_INT, HIGH);
  digitalWrite(pinmap::PIN_WAIT, HIGH);
  digitalWrite(pinmap::PIN_BUSRQ, HIGH);
}

void Z80BusHost::resetPulse() {
  digitalWrite(pinmap::PIN_RESET, LOW);

  for (uint8_t i = 0; i < RESET_LOW_HALF_CYCLES; ++i) {
    stepHalfCycle();
  }

  digitalWrite(pinmap::PIN_RESET, HIGH);

  for (uint8_t i = 0; i < RESET_HIGH_HALF_CYCLES; ++i) {
    stepHalfCycle();
  }
}

void Z80BusHost::stepHalfCycle() {
  clkHigh_ = !clkHigh_;
  digitalWrite(pinmap::PIN_CLK, clkHigh_ ? HIGH : LOW);

  const uint16_t sliceUs = (halfCycleUs_ / BUS_SAMPLES_PER_HALF) == 0
                               ? 1
                               : static_cast<uint16_t>(halfCycleUs_ / BUS_SAMPLES_PER_HALF);
  for (uint8_t i = 0; i < BUS_SAMPLES_PER_HALF; ++i) {
    sampleInputs();
    delayMicroseconds(sliceUs);
  }
}

void Z80BusHost::stepCycles(uint32_t cycles) {
  for (uint32_t i = 0; i < cycles; ++i) {
    stepHalfCycle();
    stepHalfCycle();
  }
}

void Z80BusHost::sampleInputs() {
  const bool mreqActive = (digitalRead(pinmap::PIN_MREQ) == LOW);
  const bool iorqActive = (digitalRead(pinmap::PIN_IORQ) == LOW);
  const bool rdActive = (digitalRead(pinmap::PIN_RD) == LOW);
  const bool wrActive = (digitalRead(pinmap::PIN_WR) == LOW);

  snapshot_.address = readAddressBus();
  snapshot_.control = 0;
  if (mreqActive) snapshot_.control |= CTRL_MREQ;
  if (iorqActive) snapshot_.control |= CTRL_IORQ;
  if (rdActive) snapshot_.control |= CTRL_RD;
  if (wrActive) snapshot_.control |= CTRL_WR;
  if (digitalRead(pinmap::PIN_M1) == LOW) snapshot_.control |= CTRL_M1;
  if (digitalRead(pinmap::PIN_RFSH) == LOW) snapshot_.control |= CTRL_RFSH;
  if (digitalRead(pinmap::PIN_HALT) == LOW) snapshot_.control |= CTRL_HALT;
  if (digitalRead(pinmap::PIN_BUSAK) == LOW) snapshot_.control |= CTRL_BUSAK;

  const bool m1Low = ((snapshot_.control & CTRL_M1) != 0);
  if (m1Low && !prevM1Low_ && m1TraceCount_ < kTraceSize) {
    m1Trace_[m1TraceCount_] = snapshot_.address;
    ++m1TraceCount_;

    const uint16_t pc = snapshot_.address;
    const uint8_t op = readMemoryByte(pc);
    const uint8_t prev = (pc == 0) ? 0 : readMemoryByte(static_cast<uint16_t>(pc - 1));

    // Fast path: decode DD/FD-prefixed op directly from the prefix fetch.
    if (op == 0xDD || op == 0xFD) {
      const uint8_t op1 = readMemoryByte(static_cast<uint16_t>(pc + 1));
      if (op1 == 0x21) {
        const uint8_t lo = readMemoryByte(static_cast<uint16_t>(pc + 2));
        const uint8_t hi = readMemoryByte(static_cast<uint16_t>(pc + 3));
        const uint16_t value = static_cast<uint16_t>((static_cast<uint16_t>(hi) << 8) | lo);
        if (op == 0xDD) {
          ixReg_ = value;
        } else {
          iyReg_ = value;
        }
      } else if (op1 == 0xCB) {
        const int8_t disp = static_cast<int8_t>(readMemoryByte(static_cast<uint16_t>(pc + 2)));
        const uint8_t cbOp = readMemoryByte(static_cast<uint16_t>(pc + 3));
        if (isSetResMemOpcode(cbOp)) {
          const uint16_t base = (op == 0xDD) ? ixReg_ : iyReg_;
          const uint16_t eff = static_cast<uint16_t>(base + disp);
          const uint8_t updated = applyDdFdCbSetRes(readMemoryByte(eff), cbOp);
          writeMemoryByte(eff, updated);
          pendingDdFdCbAddr_ = eff;
          pendingDdFdCbOp_ = cbOp;
          pendingDdFdCbWrite_ = true;
        }
      }
    }

    // Directly decode DD/FD-prefixed indexed ops from adjacent opcode bytes.
    // This is robust even if prefix tracking state is missed between samples.
    if ((prev == 0xDD || prev == 0xFD) && op == 0x21) {
      const uint8_t lo = readMemoryByte(static_cast<uint16_t>(pc + 1));
      const uint8_t hi = readMemoryByte(static_cast<uint16_t>(pc + 2));
      const uint16_t value = static_cast<uint16_t>((static_cast<uint16_t>(hi) << 8) | lo);
      if (prev == 0xDD) {
        ixReg_ = value;
      } else {
        iyReg_ = value;
      }
      decodePrefix_ = 0;
    } else if ((prev == 0xDD || prev == 0xFD) && op == 0xCB) {
      const int8_t disp = static_cast<int8_t>(readMemoryByte(static_cast<uint16_t>(pc + 1)));
      const uint8_t cbOp = readMemoryByte(static_cast<uint16_t>(pc + 2));
      if (isSetResMemOpcode(cbOp)) {
        const uint16_t base = (prev == 0xDD) ? ixReg_ : iyReg_;
        const uint16_t eff = static_cast<uint16_t>(base + disp);
        const uint8_t updated = applyDdFdCbSetRes(readMemoryByte(eff), cbOp);
        writeMemoryByte(eff, updated);
        pendingDdFdCbAddr_ = eff;
        pendingDdFdCbOp_ = cbOp;
        pendingDdFdCbWrite_ = true;
      }
      decodePrefix_ = 0;
    }

    uint8_t prefix = decodePrefix_;
    if (prefix == 0 && pc > 0) {
      const uint8_t prevByte = readMemoryByte(static_cast<uint16_t>(pc - 1));
      if (prevByte == 0xDD || prevByte == 0xFD) {
        prefix = prevByte;
      }
    }

    if (prefix != 0) {
      if (op == 0x21) {
        const uint8_t lo = readMemoryByte(static_cast<uint16_t>(pc + 1));
        const uint8_t hi = readMemoryByte(static_cast<uint16_t>(pc + 2));
        const uint16_t value = static_cast<uint16_t>((static_cast<uint16_t>(hi) << 8) | lo);
        if (prefix == 0xDD) {
          ixReg_ = value;
        } else {
          iyReg_ = value;
        }
        decodePrefix_ = 0;
      } else if (op == 0xCB) {
        const int8_t disp = static_cast<int8_t>(readMemoryByte(static_cast<uint16_t>(pc + 1)));
        const uint8_t cbOp = readMemoryByte(static_cast<uint16_t>(pc + 2));
        if (isSetResMemOpcode(cbOp)) {
          const uint16_t base = (prefix == 0xDD) ? ixReg_ : iyReg_;
          const uint16_t eff = static_cast<uint16_t>(base + disp);
          const uint8_t updated = applyDdFdCbSetRes(readMemoryByte(eff), cbOp);
          writeMemoryByte(eff, updated);
          pendingDdFdCbAddr_ = eff;
          pendingDdFdCbOp_ = cbOp;
          pendingDdFdCbWrite_ = true;
        }
        decodePrefix_ = 0;
      } else if (op == 0xDD || op == 0xFD) {
        decodePrefix_ = op;
      } else {
        decodePrefix_ = 0;
      }
    } else if (op == 0xDD || op == 0xFD) {
      decodePrefix_ = op;
    }
  }
  prevM1Low_ = m1Low;

  // Always release data bus before any write sampling.
  releaseDataBus();

  // Handle write cycles first so we don't miss narrow /WR windows.
  if (wrActive) {
    if (!writeActive_) {
      writeActive_ = true;
      writeIsIo_ = (iorqActive && !mreqActive);
      writeAddress_ = snapshot_.address;
      writeHighMax_ = static_cast<uint8_t>((snapshot_.address >> 8) & 0x00FF);
      writeSampleCount_ = 0;
      writeSawNonZero_ = false;
      writeLastNonZero_ = 0;
      writeOrValue_ = 0;
      for (uint8_t i = 0; i < 8; ++i) {
        writeBitHighCount_[i] = 0;
      }
    } else if (iorqActive && !mreqActive) {
      writeIsIo_ = true;
    }

    const uint8_t currentHigh = static_cast<uint8_t>((snapshot_.address >> 8) & 0x00FF);
    if (currentHigh > writeHighMax_) {
      writeHighMax_ = currentHigh;
    }

    // For memory writes, update address within /WR window to catch late-settle effective addresses.
    // For I/O writes, keep first address stable to avoid auto-increment/decrement drift.
    if (!writeIsIo_) {
      writeAddress_ = snapshot_.address;
    }

    for (uint8_t s = 0; s < WR_OVERSAMPLE_COUNT; ++s) {
      if (dataReadSource_ == DataReadSource::kDoutBus) {
        writeValue_ = readPortFDataBus();
      } else {
        writeValue_ = readPortCDataBus();
      }
      accumulateBits(writeValue_, writeBitHighCount_);
      if (writeValue_ != 0) {
        writeSawNonZero_ = true;
        writeLastNonZero_ = writeValue_;
      }
      writeOrValue_ = static_cast<uint8_t>(writeOrValue_ | writeValue_);
      writeSampleCount_++;
      if (s + 1 < WR_OVERSAMPLE_COUNT) {
        delayMicroseconds(WR_OVERSAMPLE_US);
      }
    }
    snapshot_.data = writeValue_;
    return;
  }

  // Commit on /WR inactive edge; fetch cycles may already be active.
  if (writeActive_ && !wrActive) {
    commitWriteCapture(snapshot_.address);
  }

  if ((mreqActive || iorqActive) && rdActive) {
    if (mreqActive) {
      const uint8_t value = readMemoryByte(snapshot_.address);
      setDataBusOutput(value);
      snapshot_.data = value;
    } else {
      const uint8_t value = readMemoryByte(snapshot_.address);
      setDataBusOutput(value);
      snapshot_.data = value;
      snapshot_.ioPort = static_cast<uint8_t>(snapshot_.address & 0x00FF);
    }
    return;
  }
}

void Z80BusHost::commitWriteCapture(uint16_t currentAddress) {
  uint8_t committed = writeValue_;
  if (committed == 0) {
    for (uint8_t i = 0; i < 8; ++i) {
      if (writeBitHighCount_[i] * 2 >= writeSampleCount_) {
        committed |= static_cast<uint8_t>(1U << i);
      }
    }
    if (committed == 0 && writeSawNonZero_) {
      committed = writeLastNonZero_;
    }
    if ((committed & WRITE_OR_FALLBACK_MASK) == 0 && (writeOrValue_ & WRITE_OR_FALLBACK_MASK) != 0) {
      committed = static_cast<uint8_t>(committed | (writeOrValue_ & WRITE_OR_FALLBACK_MASK));
    }
  }

  (void)currentAddress;
  uint16_t commitAddress = static_cast<uint16_t>((static_cast<uint16_t>(writeHighMax_) << 8) | (writeAddress_ & 0x00FF));
  if (writeIsIo_ && (commitAddress & 0x00FF) == 0x00FF && (commitAddress & 0xFF00) < 0xFF00) {
    commitAddress = static_cast<uint16_t>(commitAddress + 0x0100);
  }
  if (!writeIsIo_ && commitAddress == 0xFEFF && committed == 0xFF) {
    commitAddress = 0xFFFF;
  }

  bool appliedPendingBitOp = false;
  if (!writeIsIo_ && pendingDdFdCbWrite_) {
    if (commitAddress == pendingDdFdCbAddr_) {
      committed = applyDdFdCbSetRes(readMemoryByte(commitAddress), pendingDdFdCbOp_);
      appliedPendingBitOp = true;
      pendingDdFdCbWrite_ = false;
    }
  }

  writeValue_ = committed;
  writeMemoryByte(commitAddress, writeValue_);

  const uint16_t idx = writeTraceHead_;
  writeTrace_[idx].address = commitAddress;
  writeTrace_[idx].value = writeValue_;
  writeTrace_[idx].flags = writeIsIo_ ? 0x11 : 0x01;
  if (writeSawNonZero_) {
    writeTrace_[idx].flags = static_cast<uint8_t>(writeTrace_[idx].flags | 0x02);
  }
  if (writeOrValue_ != writeValue_) {
    writeTrace_[idx].flags = static_cast<uint8_t>(writeTrace_[idx].flags | 0x04);
  }
  if (appliedPendingBitOp) {
    writeTrace_[idx].flags = static_cast<uint8_t>(writeTrace_[idx].flags | 0x20);
  }
  writeTraceHead_ = static_cast<uint16_t>((writeTraceHead_ + 1) % kWriteTraceSize);
  if (writeTraceCount_ < kWriteTraceSize) {
    writeTraceCount_++;
  }

  if (writeIsIo_) {
    snapshot_.ioPort = static_cast<uint8_t>(commitAddress & 0x00FF);
    snapshot_.ioValue = writeValue_;
  }

  writeActive_ = false;
}

uint16_t Z80BusHost::readAddressBus() const {
  uint16_t value = 0;
  for (uint8_t i = 0; i < 16; ++i) {
    if (digitalRead(pinmap::ADDR_PINS[i]) == HIGH) {
      value |= static_cast<uint16_t>(1U << i);
    }
  }
  return value;
}

uint8_t Z80BusHost::readDataPins() const {
  const uint8_t* pins = pinmap::DATA_PINS;
  if (dataReadSource_ == DataReadSource::kDoutBus) {
    pins = pinmap::DOUT_PINS;
  }

  uint8_t value = 0;
  for (uint8_t i = 0; i < 8; ++i) {
    if (digitalRead(pins[i]) == HIGH) {
      value |= static_cast<uint8_t>(1U << i);
    }
  }
  return value;
}

void Z80BusHost::setDataBusInput() {
  for (uint8_t i = 0; i < 8; ++i) {
    digitalWrite(pinmap::DATA_PINS[i], LOW);
    pinMode(pinmap::DATA_PINS[i], INPUT_PULLUP);
  }
}

void Z80BusHost::setDataBusOutput(uint8_t value) {
  for (uint8_t i = 0; i < 8; ++i) {
    pinMode(pinmap::DATA_PINS[i], OUTPUT);
    digitalWrite(pinmap::DATA_PINS[i], (value & (1U << i)) ? HIGH : LOW);
  }
}

void Z80BusHost::releaseDataBus() {
  setDataBusInput();
}

void Z80BusHost::clearMemory(uint8_t value) {
  pendingDdFdCbWrite_ = false;
  pendingDdFdCbOp_ = 0;
  pendingDdFdCbAddr_ = 0;
  decodePrefix_ = 0;
  ixReg_ = 0;
  iyReg_ = 0;

  defaultMemoryValue_ = value;
  nextEvictPage_ = 4;
  for (uint8_t i = 0; i < kMaxPages; ++i) {
    pages_[i].used = false;
    pages_[i].locked = false;
    pages_[i].tag = 0;
    for (uint16_t j = 0; j < kPageSize; ++j) {
      pages_[i].data[j] = value;
    }
  }

  for (uint8_t i = 0; i < 4 && i < kMaxPages; ++i) {
    pages_[i].used = true;
    pages_[i].locked = true;
    pages_[i].tag = i;
    for (uint16_t j = 0; j < kPageSize; ++j) {
      pages_[i].data[j] = value;
    }
  }
  if (kMaxPages > 4) {
    pages_[4].used = true;
    pages_[4].locked = true;
    pages_[4].tag = 0xFF;
    for (uint16_t j = 0; j < kPageSize; ++j) {
      pages_[4].data[j] = value;
    }
    nextEvictPage_ = 5;
  }
}

void Z80BusHost::loadMemory(uint16_t addr, const uint8_t* data, uint16_t len) {
  for (uint16_t i = 0; i < len; ++i) {
    const uint16_t cur = static_cast<uint16_t>(addr + i);
    const uint8_t tag = static_cast<uint8_t>(cur >> 8);
    int8_t idx = findPageIndex(tag);
    if (idx < 0) {
      idx = static_cast<int8_t>(allocPage(tag, tag <= 0x03 || tag == 0xFF));
    } else if (tag <= 0x03 || tag == 0xFF) {
      pages_[static_cast<uint8_t>(idx)].locked = true;
    }
    pages_[static_cast<uint8_t>(idx)].data[static_cast<uint8_t>(cur & 0x00FF)] = data[i];
  }
}

uint8_t Z80BusHost::readMemory(uint16_t addr) const {
  return readMemoryByte(addr);
}

int8_t Z80BusHost::findPageIndex(uint8_t tag) const {
  for (uint8_t i = 0; i < kMaxPages; ++i) {
    if (pages_[i].used && pages_[i].tag == tag) {
      return static_cast<int8_t>(i);
    }
  }
  return -1;
}

uint8_t Z80BusHost::allocPage(uint8_t tag, bool lockPage) {
  for (uint8_t i = 0; i < kMaxPages; ++i) {
    if (!pages_[i].used) {
      pages_[i].used = true;
      pages_[i].locked = lockPage;
      pages_[i].tag = tag;
      for (uint16_t j = 0; j < kPageSize; ++j) {
        pages_[i].data[j] = defaultMemoryValue_;
      }
      return i;
    }
  }

  uint8_t evict = nextEvictPage_;
  for (uint8_t i = 0; i < kMaxPages; ++i) {
    const uint8_t idx = static_cast<uint8_t>((nextEvictPage_ + i) % kMaxPages);
    if (!pages_[idx].locked) {
      evict = idx;
      nextEvictPage_ = static_cast<uint8_t>((idx + 1) % kMaxPages);
      break;
    }
  }

  pages_[evict].used = true;
  pages_[evict].locked = lockPage;
  pages_[evict].tag = tag;
  for (uint16_t j = 0; j < kPageSize; ++j) {
    pages_[evict].data[j] = defaultMemoryValue_;
  }
  return evict;
}

uint8_t Z80BusHost::readMemoryByte(uint16_t addr) const {
  const uint8_t tag = static_cast<uint8_t>(addr >> 8);
  const uint8_t off = static_cast<uint8_t>(addr & 0x00FF);
  const int8_t idx = findPageIndex(tag);
  if (idx < 0) {
    return defaultMemoryValue_;
  }
  return pages_[static_cast<uint8_t>(idx)].data[off];
}

void Z80BusHost::writeMemoryByte(uint16_t addr, uint8_t value) {
  const uint8_t tag = static_cast<uint8_t>(addr >> 8);
  const uint8_t off = static_cast<uint8_t>(addr & 0x00FF);
  int8_t idx = findPageIndex(tag);
  if (idx < 0) {
    idx = static_cast<int8_t>(allocPage(tag, tag <= 0x03 || tag == 0xFF));
  } else if (tag <= 0x03 || tag == 0xFF) {
    pages_[static_cast<uint8_t>(idx)].locked = true;
  }
  pages_[static_cast<uint8_t>(idx)].data[off] = value;
}

Z80BusHost::Snapshot Z80BusHost::getSnapshot() const {
  return snapshot_;
}

void Z80BusHost::clearTrace() {
  prevM1Low_ = false;
  m1TraceCount_ = 0;
  pendingDdFdCbWrite_ = false;
  pendingDdFdCbOp_ = 0;
  pendingDdFdCbAddr_ = 0;
  decodePrefix_ = 0;
  ixReg_ = 0;
  iyReg_ = 0;
  writeActive_ = false;
  writeIsIo_ = false;
  writeAddress_ = 0;
  writeHighMax_ = 0;
  writeValue_ = 0;
  writeSampleCount_ = 0;
  writeSawNonZero_ = false;
  writeLastNonZero_ = 0;
  writeOrValue_ = 0;
  for (uint8_t i = 0; i < 8; ++i) {
    writeBitHighCount_[i] = 0;
  }
  for (uint16_t i = 0; i < kTraceSize; ++i) {
    m1Trace_[i] = 0;
  }
}

void Z80BusHost::clearWriteTrace() {
  writeTraceCount_ = 0;
  writeTraceHead_ = 0;
  for (uint16_t i = 0; i < kWriteTraceSize; ++i) {
    writeTrace_[i].address = 0;
    writeTrace_[i].value = 0;
    writeTrace_[i].flags = 0;
  }
}

uint16_t Z80BusHost::getWriteTraceCount() const {
  return writeTraceCount_;
}

Z80BusHost::WriteEvent Z80BusHost::getWriteTraceEvent(uint16_t index) const {
  if (index >= writeTraceCount_) {
    return {0, 0, 0};
  }

  const uint16_t base = (writeTraceHead_ + kWriteTraceSize - writeTraceCount_) % kWriteTraceSize;
  const uint16_t pos = static_cast<uint16_t>((base + index) % kWriteTraceSize);
  return writeTrace_[pos];
}

Z80BusHost::IndexedDebug Z80BusHost::getIndexedDebug() const {
  return {ixReg_, iyReg_, pendingDdFdCbAddr_, pendingDdFdCbOp_, decodePrefix_, pendingDdFdCbWrite_ ? 1U : 0U};
}

uint16_t Z80BusHost::getTraceCount() const {
  return m1TraceCount_;
}

uint16_t Z80BusHost::getTraceAddress(uint16_t index) const {
  if (index >= m1TraceCount_) {
    return 0;
  }
  return m1Trace_[index];
}
