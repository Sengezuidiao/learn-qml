#include "sa.h"
#include "common.h"
#include <cstddef>
#include <cstring>
// 错误码定义
enum ErrorCode {
  SUCCESS = 0,
  INVALID_PARAM = -1,
  ECU_NAME_NOT_FOUND = -2,
  INVALID_SECURITY_LEVEL = -3,
};

void getLevelKey(uint8_t *key, const uint8_t *seed, uint8_t level,
                 uint8_t *sk_tmp) {
  int i;
  uint8_t buffer[4];

  switch (level) {
  case 0x1:
    for (i = 0; i < 4; i++) {
      buffer[i] = seed[i] ^ sk_tmp[i];
    }
    key[0] = ((buffer[0] & 0x1B) << 3) | ((buffer[3] & 0xA3) >> 2);
    key[1] = ((buffer[3] & 0x2C) << 4) | ((buffer[2] & 0xB1) >> 3);
    key[2] = ((buffer[1] & 0x0A) << 2) | (buffer[0] >> 3);
    key[3] = (buffer[2] & 0xF0) | ((buffer[1] & 0x27) >> 4);
    break;

  case 0x03:
    for (i = 0; i < 4; i++) {
      buffer[i] = seed[i] ^ sk_tmp[i];
    }
    key[0] = (buffer[3] & 0x0F) | ((buffer[2] & 0xF0) << 3);
    key[1] = ((buffer[0] & 0xC3) << 4) | ((buffer[1] & 0x1C) >> 2);
    key[2] = ((buffer[1] & 0x1B) >> 3) | ((buffer[0] & 0x27) << 4);
    key[3] = ((buffer[2] & 0x0F) << 2) | ((buffer[3] & 0xF3) >> 4);
    break;

  case 0x51:
    for (i = 0; i < 4; i++) {
      buffer[i] = seed[i] ^ sk_tmp[i];
    }
    key[0] = (buffer[3] & 0x0F) | (buffer[2] & 0xF0);
    key[1] = ((buffer[0] & 0xC3) << 4) | ((buffer[3] & 0x3C) >> 2);
    key[2] = ((buffer[2] & 0x2F) >> 3) | ((buffer[1] & 0x0F) << 4);
    key[3] = ((buffer[1] & 0x1F) << 2) | ((buffer[0] & 0xF0) >> 4);
    break;

  case 0x09:
    for (i = 0; i < 4; i++) {
      buffer[i] = (seed[i] >> 1) ^ (sk_tmp[i] << 1);
    }
    key[0] = ((buffer[3] & 0xF0) >> 2) | ((buffer[0] & 0x0F) << 2);
    key[1] = ((buffer[2] & 0x0F) << 5) | ((buffer[3] & 0x4A) >> 3);
    key[2] = ((buffer[1] & 0x1C) >> 2) | ((buffer[2] & 0xE1) << 4);
    key[3] = ((buffer[0] & 0x0F) >> 2) | ((buffer[1] & 0x5F) >> 4);
    break;
  }
}
// TBOX特殊处理
void tboxhandle(const char *ecu, uint8_t ecu_len, uint8_t *mask) {
  struct EcuMask {
    const char *name;
    const uint8_t mask[4];
  };
  static const uint8_t mask_init[4] = {0xEE, 0x77, 0x55, 0x33};

  static const struct EcuMask ecuMasks[] = {

      {"ABS", {0xEF, 0xBE, 0x47, 0x86}},      {"AC", {0xBF, 0x59, 0x7F, 0xC7}},
      {"ACCU", {0x4E, 0xD8, 0xAA, 0x4A}},     {"BCM", {0xE9, 0x09, 0xE9, 0xE3}},
      {"BMS", {0xBB, 0x67, 0xAE, 0x85}},      {"EHB", {0xA8, 0x1A, 0x66, 0x4B}},
      {"EPS", {0xE9, 0xB5, 0xDB, 0xA5}},      {"GSM", {0x8F, 0x72, 0x6E, 0xE7}},
      {"GW", {0xE1, 0xE2, 0xA8, 0xE6}},       {"HU", {0x83, 0xD5, 0x0F, 0x95}},
      {"IBCM", {0xE9, 0x09, 0xE9, 0xE3}},     {"IC", {0x87, 0xD7, 0xDF, 0xDC}},
      {"LAM", {0x7B, 0xD3, 0xE6, 0xA7}},      {"MCU", {0x6C, 0xF3, 0xCA, 0xD5}},
      {"OBC_DCDC", {0xBB, 0x4A, 0xF3, 0xC5}}, {"SDM", {0x76, 0xF9, 0x88, 0xDA}},
      {"TBOX", {0xD8, 0x07, 0xAA, 0x98}},     {"VCU", {0xA5, 0x4F, 0xF5, 0x3A}},
      {"HECU", {0xA5, 0x4F, 0xF5, 0x3A}}};

  for (uint32_t i = 0; i < sizeof(ecuMasks) / sizeof(ecuMasks[0]); ++i) {
    if (strncmp(ecu, ecuMasks[i].name, ecu_len) == 0) {
      memcpy(mask, ecuMasks[i].mask, 4);
      return;
    }
  }
  // 未匹配填默认值
  memcpy(mask, mask_init, 4);
}

// 支持ECU 列表
static const struct {
  const char *ecuName;
} ECUS[] = {"ABS", "AC",       "ACCU", "BCM",  "BMS", "EHB", "EPS",
            "GSM", "GW",       "HU",   "IBCM", "IC",  "LAM", "MCU",
            "OBC", "OBC_DCDC", "SDM",  "TBOX", "VCU", "HECU"};

int checkEcuName(const char *ecuName, unsigned short ecuNameSize) {
  int len = sizeof(ECUS) / sizeof(ECUS[0]);
  for (int i = 0; i < len; i++) {
    if (strncmp(ECUS[i].ecuName, ecuName, ecuNameSize) == 0) {
      return 0; // Found in the list
    }
  }
  return ECU_NAME_NOT_FOUND; // Not found in the list
}

int SeedToKey(Request *req) {

  // 空指针检查
  if (!req || !req->seed || !req->ecu || !req->key) {
    return INVALID_PARAM;
  }

  // 受支持的ECU检查
  if (checkEcuName(req->ecu, req->ecu_len) < 0) {
    return ECU_NAME_NOT_FOUND;
  }

  // 算法受支持的等级检查
  if (req->level != 0x1 && req->level != 0x9 && req->level != 0x3 &&
      req->level != 0x51) {
    return INVALID_SECURITY_LEVEL;
  }

  uint8_t sk[8];
  uint8_t maxseed;
  uint8_t sk_tmp[4];
  SA_SHA256_CTX ctx;
  uint8_t hash[32];
  uint8_t mask_tmp[4];

  // 输入vin(17) + vsn(20) + mask(4)
  uint8_t input[VIN_LEN + VSN_LEN + MASK_LEN] = {0};
  if (req->vin != NULL) {
    memcpy(input, req->vin, VIN_LEN);
  } else {
    memcpy(input, "WLXNY505088888888", VIN_LEN);
  }
  if (req->vsn != NULL) {
    memcpy(input + VIN_LEN, req->vsn, VSN_LEN);
  } else {
    memcpy(input + VIN_LEN, "GXA1030BEVD1        ", VSN_LEN);
  }

  // 为空就TBOX特殊处理，如果不是特殊处理范围使用默认值
  if (req->mask != NULL) {
    memcpy(input + VIN_LEN + VSN_LEN, req->mask, MASK_LEN);
  } else {
    tboxhandle(req->ecu, req->ecu_len, mask_tmp);
    memcpy(input + VIN_LEN + VSN_LEN, mask_tmp, MASK_LEN);
  }

  // printf("input\n");
  // show(input, 41);

  // 哈希运算sha256
  sa_sha256_init(&ctx);
  sa_sha256_update(&ctx, input, 41);
  sa_sha256_final(&ctx, hash);

  // // 求SK
  get_sk(hash, sk);
  // printf("\nsk\n");
  // show(sk, 8);

  // // 求maxseed
  maxseed = getmaxseed(req->seed);

  // // 动态选择SK
  getSkTemp(sk_tmp, sk, maxseed);
  // show(sk_tmp, 4);
  // printf("\n");
  // 求key
  getLevelKey(req->key, req->seed, req->level, sk_tmp);
  return 0;
}
