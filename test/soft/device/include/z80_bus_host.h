#ifndef Z80_BUS_HOST_H
#define Z80_BUS_HOST_H

#include <Arduino.h>

class Z80BusHost {
 public:
  static const uint16_t kTraceSize = 128;

  enum class DataReadSource {
    kDataBus,
    kDoutBus,
  };

  struct Snapshot {
    uint16_t address;
    uint8_t data;
    uint8_t control;
    uint8_t ioPort;
    uint8_t ioValue;
  };

  struct WriteEvent {
    uint16_t address;
    uint8_t value;
    uint8_t flags;
  };

  struct IndexedDebug {
    uint16_t ix;
    uint16_t iy;
    uint16_t pendingAddr;
    uint8_t pendingOp;
    uint8_t prefix;
    uint8_t pending;
  };

  void begin();
  void setDataReadSource(DataReadSource source);
  void setHalfCycleUs(uint16_t value);

  void resetPulse();
  void stepHalfCycle();
  void stepCycles(uint32_t cycles);

  void clearMemory(uint8_t value);
  void loadMemory(uint16_t addr, const uint8_t* data, uint16_t len);
  uint8_t readMemory(uint16_t addr) const;

  Snapshot getSnapshot() const;
  void clearTrace();
  uint16_t getTraceCount() const;
  uint16_t getTraceAddress(uint16_t index) const;
  void clearWriteTrace();
  uint16_t getWriteTraceCount() const;
  WriteEvent getWriteTraceEvent(uint16_t index) const;
  IndexedDebug getIndexedDebug() const;

 private:
  static const uint16_t kPageSize = 256;
  static const uint8_t kMaxPages = 24;

  struct MemoryPage {
    bool used;
    bool locked;
    uint8_t tag;
    uint8_t data[kPageSize];
  };

  void setupPins();
  void sampleInputs();
  void commitWriteCapture(uint16_t currentAddress);
  uint16_t readAddressBus() const;
  uint8_t readDataPins() const;
  uint8_t readMemoryByte(uint16_t addr) const;
  void writeMemoryByte(uint16_t addr, uint8_t value);
  int8_t findPageIndex(uint8_t tag) const;
  uint8_t allocPage(uint8_t tag, bool lockPage);
  void setDataBusInput();
  void setDataBusOutput(uint8_t value);
  void releaseDataBus();

  MemoryPage pages_[kMaxPages];
  uint8_t defaultMemoryValue_;
  uint8_t nextEvictPage_;

  bool clkHigh_;
  mutable Snapshot snapshot_;
  uint16_t m1Trace_[kTraceSize];
  uint16_t m1TraceCount_;
  bool prevM1Low_;
  bool pendingDdFdCbWrite_;
  uint8_t pendingDdFdCbOp_;
  uint16_t pendingDdFdCbAddr_;
  uint8_t decodePrefix_;
  uint16_t ixReg_;
  uint16_t iyReg_;
  DataReadSource dataReadSource_;
  uint16_t halfCycleUs_;
  bool writeActive_;
  bool writeIsIo_;
  uint16_t writeAddress_;
  uint8_t writeHighMax_;
  uint8_t writeValue_;
  uint16_t writeSampleCount_;
  uint16_t writeBitHighCount_[8];
  bool writeSawNonZero_;
  uint8_t writeLastNonZero_;
  uint8_t writeOrValue_;

  static const uint16_t kWriteTraceSize = 128;
  WriteEvent writeTrace_[kWriteTraceSize];
  uint16_t writeTraceCount_;
  uint16_t writeTraceHead_;
};

#endif  // Z80_BUS_HOST_H
