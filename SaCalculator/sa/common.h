#pragma once
#ifdef __cplusplus
extern "C" {
#endif
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// -------------------- 1. 工具宏定义 --------------------
#define ROTRIGHT(word, bits) (((word) >> (bits)) | ((word) << (32 - (bits))))
#define CH(x, y, z) (((x) & (y)) ^ (~(x) & (z)))
#define MAJ(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
#define EP0(x) (ROTRIGHT(x, 2) ^ ROTRIGHT(x, 13) ^ ROTRIGHT(x, 22))
#define EP1(x) (ROTRIGHT(x, 6) ^ ROTRIGHT(x, 11) ^ ROTRIGHT(x, 25))
#define SIG0(x) (ROTRIGHT(x, 7) ^ ROTRIGHT(x, 18) ^ ((x) >> 3))
#define SIG1(x) (ROTRIGHT(x, 17) ^ ROTRIGHT(x, 19) ^ ((x) >> 10))

// -------------------- 3. 上下文结构体 --------------------
typedef struct {
  uint8_t data[64];  // 输入缓冲区（一个块）
  uint32_t datalen;  // 当前缓冲区长度
  uint64_t bitlen;   // 总位数（用于填充）
  uint32_t state[8]; // Hash状态值A~H
} SA_SHA256_CTX;

void sa_sha256_init(SA_SHA256_CTX *ctx);
void sa_sha256_transform(SA_SHA256_CTX *ctx, const uint8_t data[]);
void sa_sha256_update(SA_SHA256_CTX *ctx, const uint8_t data[], uint32_t len);
void sa_sha256_final(SA_SHA256_CTX *ctx, uint8_t hash[]);
unsigned char *hex_to_bytes(const char *hex, uint32_t *len);
void get_sk(uint8_t *hash, uint8_t *sk);
void show(uint8_t *a, uint8_t len);
void asscii_to_bytes(const char *assc, uint8_t *bytes, uint8_t len);
uint8_t getmaxseed(const uint8_t *seed);
void getSkTemp(uint8_t *sk_tmp, const uint8_t *sk, uint8_t max_seed);
#ifdef __cplusplus
}
#endif
