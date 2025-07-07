#pragma once
#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <string.h>
#define MASK_LEN 4
#define VSN_LEN  20
#define VIN_LEN  17
#define KEY_LEN  4

typedef struct {
  const char *ecu;
  uint8_t ecu_len;
  const uint8_t *seed;
  uint8_t level;
  uint8_t *key;
  const uint8_t* mask;
  const char *vsn;
  const char *vin;
} Request;

int SeedToKey(Request *req);

#ifdef __cplusplus
}
#endif
