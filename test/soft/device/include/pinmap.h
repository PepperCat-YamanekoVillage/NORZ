#ifndef PINMAP_H
#define PINMAP_H

#include <Arduino.h>

namespace pinmap {

static const uint8_t PIN_IORQ = 22;
static const uint8_t PIN_MREQ = 23;
static const uint8_t PIN_HALT = 24;
static const uint8_t PIN_NMI = 25;
static const uint8_t PIN_INT = 26;
static const uint8_t PIN_CLK = 27;
static const uint8_t PIN_M1 = 28;
static const uint8_t PIN_RFSH = 29;

static const uint8_t DATA_PINS[8] = {
    30, 31, 32, 33, 34, 35, 36, 37
};

static const uint8_t DOUT_PINS[8] = {
    54, 55, 56, 57, 58, 59, 60, 61
};

static const uint8_t ADDR_PINS[16] = {
    62, 63, 64, 65, 66, 67, 68, 69,
    40, 41, 42, 43, 44, 45, 46, 47
};

static const uint8_t PIN_RD = 38;
static const uint8_t PIN_WR = 39;
static const uint8_t PIN_RESET = 14;
static const uint8_t PIN_BUSRQ = 15;
static const uint8_t PIN_WAIT = 16;
static const uint8_t PIN_BUSAK = 17;

}  // namespace pinmap

#endif  // PINMAP_H
