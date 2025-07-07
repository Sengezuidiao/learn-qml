#include "common.h"
#include <cstdint>

// -------------------- 2. 常量表 --------------------
static const uint32_t k[64] = {
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1,
    0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786,
    0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147,
    0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b,
    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};



// -------------------- 4. 初始化函数 --------------------
void sa_sha256_init(SA_SHA256_CTX *ctx) {
  ctx->datalen = 0;
  ctx->bitlen = 0;
  ctx->state[0] = 0x6a09e667;
  ctx->state[1] = 0xbb67ae85;
  ctx->state[2] = 0x3c6ef372;
  ctx->state[3] = 0xa54ff53a;
  ctx->state[4] = 0x510e527f;
  ctx->state[5] = 0x9b05688c;
  ctx->state[6] = 0x1f83d9ab;
  ctx->state[7] = 0x5be0cd19;
}

// -------------------- 5. 主变换函数 --------------------
void sa_sha256_transform(SA_SHA256_CTX *ctx, const uint8_t data[]) {
  uint32_t a, b, c, d, e, f, g, h, t1, t2, w[64];

  // Step 1: 构建消息块（字）
  for (uint32_t i = 0, j = 0; i < 16; ++i, j += 4) {
    if (i < 14) {
      w[i] = data[j] | (data[j + 1] << 8) | (data[j + 2] << 16) |
             (data[j + 3] << 24);
    }
    // 特殊处理填充的长度
    if (i >= 14) {
      // 取低4字节
      w[14] = (uint32_t)(ctx->bitlen & 0xFFFFFFFF);
      // 取高4字节
      w[15] = (uint32_t)(ctx->bitlen >> 32);
    }
    // printf("w[%d] = %4x\n", i, w[i]);
  }
  for (uint32_t i = 16; i < 64; ++i) {
    w[i] = SIG1(w[i - 2]) + w[i - 7] + SIG0(w[i - 15]) + w[i - 16];
    // printf("w[%d] = %4x\n", i, w[i]);
  }

  // Step 2: 初始化工作变量
  a = ctx->state[0];
  b = ctx->state[1];
  c = ctx->state[2];
  d = ctx->state[3];
  e = ctx->state[4];
  f = ctx->state[5];
  g = ctx->state[6];
  h = ctx->state[7];

  // Step 3: 64轮迭代压缩
  for (uint32_t i = 0; i < 64; ++i) {
    t1 = h + EP1(e) + CH(e, f, g) + k[i] + w[i];
    t2 = EP0(a) + MAJ(a, b, c);
    h = g;
    g = f;
    f = e;
    e = d + t1;
    d = c;
    c = b;
    b = a;
    a = t1 + t2;
  }

  // Step 4: 累加到状态变量
  ctx->state[0] += a;
  ctx->state[1] += b;
  ctx->state[2] += c;
  ctx->state[3] += d;
  ctx->state[4] += e;
  ctx->state[5] += f;
  ctx->state[6] += g;
  ctx->state[7] += h;
}

// -------------------- 6. 数据输入 --------------------
void sa_sha256_update(SA_SHA256_CTX *ctx, const uint8_t data[], uint32_t len) {
  for (uint32_t i = 0; i < len; ++i) {
    ctx->data[ctx->datalen] = data[i];
    ctx->datalen++;
    if (ctx->datalen == 64) {
      sa_sha256_transform(ctx, ctx->data);
      ctx->bitlen += 512;
      ctx->datalen = 0;
    }
  }
}

// -------------------- 7. 填充与输出 --------------------
void sa_sha256_final(SA_SHA256_CTX *ctx, uint8_t hash[]) {
  uint32_t i = ctx->datalen;

  // Step 1: 添加末尾的 0x80
  ctx->data[i++] = 0x80;

  // Step 2: 填充 0 直到达到 56 字节
  if (i > 56) {
    while (i < 64)
      ctx->data[i++] = 0x00;
    sa_sha256_transform(ctx, ctx->data);
    i = 0;
  }
  while (i < 56)
    ctx->data[i++] = 0x00;

  // Step 3: 附加总长度（bit，64位）
  // 填充长度需-8
  ctx->bitlen += ctx->datalen * 8 - 8;
  // printf("ctx->bitlen = %016llX\n", ctx->bitlen);
  // 填充长度的字节需换顺序
  ctx->data[63] = ctx->bitlen;
  // printf("ctx->data[63] = %0x\n", ctx->data[63]);
  ctx->data[62] = ctx->bitlen >> 8;
  // printf("ctx->data[62] = %0x\n", ctx->data[62]);
  ctx->data[61] = ctx->bitlen >> 16;
  // printf("ctx->data[61] = %0x\n", ctx->data[61]);
  ctx->data[60] = ctx->bitlen >> 24;
  // printf("ctx->data[60] = %0x\n", ctx->data[60]);
  ctx->data[59] = ctx->bitlen >> 32;
  // printf("ctx->data[59] = %0x\n", ctx->data[59]);
  ctx->data[58] = ctx->bitlen >> 40;
  // printf("ctx->data[58] = %0x\n", ctx->data[58]);
  ctx->data[57] = ctx->bitlen >> 48;
  // printf("ctx->data[57] = %0x\n", ctx->data[57]);
  ctx->data[56] = ctx->bitlen >> 56;
  // printf("ctx->data[56] = %0x\n", ctx->data[56]);

  sa_sha256_transform(ctx, ctx->data);

  // Step 4: 输出哈希结果（按大端）
  for (i = 0; i < 4; ++i) {
    for (int j = 0; j < 8; ++j) {
      hash[i + j * 4] = (ctx->state[j] >> (24 - i * 8)) & 0xFF;
    }
  }
}

//------------ 十六进制串转字节串--------
unsigned char *hex_to_bytes(const char *hex, uint32_t *len) {
  uint32_t hex_len = strlen(hex);
  if (hex_len % 2 != 0) {
    return NULL; // 十六进制字符串长度必须为偶数
  }

  *len = hex_len / 2;
  unsigned char *bytes = (unsigned char *)malloc(*len);
  if (bytes == NULL) {
    return NULL;
  }

  for (uint32_t i = 0; i < *len; i++) {
    sscanf(hex + 2 * i, "%02hhX", &bytes[i]); // %02hhX 解析 2 个十六进制字符
  }

  return bytes;
}

// -------------------- 获取SK  --------------------
void get_sk(uint8_t *hash, uint8_t *sk) {
  sk[0] = (hash[1] & 0x0F) << 4 | (hash[2] & 0xF0) >> 4;
  sk[1] = (hash[4] & 0x0F) << 4 | (hash[5] & 0xF0) >> 4;
  sk[2] = hash[9] & 0xF0 | (hash[10] & 0xF0) >> 4;
  sk[3] = (hash[14] & 0x0F) << 4 | (hash[15] & 0xF0) >> 4;
  sk[4] = (hash[16] & 0x03) << 6 | (hash[17] & 0xFC) >> 2;
  sk[5] = hash[21] & 0x0F | hash[22] & 0xF0;
  sk[6] = (hash[24] & 0x0F) << 4 | (hash[25] & 0xF0) >> 4;
  sk[7] = (hash[28] & 0x0F) << 4 | hash[31] & 0x0F;
}


// get mask seed
uint8_t getmaxseed(const uint8_t *seed) {
  uint8_t maxseed = seed[0];
  for (int i = 0; i < 4; i++) {
    if (seed[i] > maxseed) {
      maxseed = seed[i];
    }
  }
  return maxseed;
}


void getSkTemp(uint8_t *sk_tmp, const uint8_t *sk, uint8_t max_seed) {
  // 定义一个静态的映射数组，包含每个 case 对应的索引
  static const uint8_t sk_map[16][4] = {
      {0, 1, 2, 3}, // case 0
      {4, 5, 3, 7}, // case 1
      {2, 3, 4, 5}, // case 2
      {3, 4, 5, 6}, // case 3
      {4, 5, 7, 1}, // case 4
      {5, 6, 1, 2}, // case 5
      {7, 3, 5, 1}, // case 6
      {4, 3, 2, 6}, // case 7
      {5, 3, 4, 7}, // case 8
      {4, 7, 3, 5}, // case 9
      {2, 1, 3, 5}, // case 10
      {4, 3, 0, 1}, // case 11
      {2, 5, 6, 3}, // case 12
      {3, 5, 7, 1}, // case 13
      {0, 3, 2, 6}, // case 14
      {5, 4, 0, 1}, // case 15
  };

  // 计算对应的索引，max_seed % 0x10 就是取 16 的余数
  uint8_t idx = max_seed % 0x10; // 等同于 max_seed % 16

  // 确保索引不超过 15
  if (idx < 16) {
    // 将 sk_map 中对应的值赋给 sk_tmp 数组
    for (int i = 0; i < 4; ++i) {
      sk_tmp[i] = sk[sk_map[idx][i]];
    }
  }
}


void cal_key(uint8_t* seed, uint8_t *sk)
{
  uint8_t max_seed;
  uint8_t sk_tmp[4];
  //----------------依据Seed动态信息动态摘取4个byte的SK---//
  max_seed = seed[0];
  for (int i = 1; i < 4; i++) {
    if (max_seed < seed[i]) {
      max_seed = seed[i];
    }
  }
  //-------------------------------------动态选择SK
  switch (max_seed % 0x10) {
  case 0:
    sk_tmp[0] = sk[0];
    sk_tmp[1] = sk[1];
    sk_tmp[2] = sk[2];
    sk_tmp[3] = sk[3];
    break;
  case 1:
    sk_tmp[0] = sk[4];
    sk_tmp[1] = sk[5];
    sk_tmp[2] = sk[3];
    sk_tmp[3] = sk[7];
    break;
  case 2:
    sk_tmp[0] = sk[2];
    sk_tmp[1] = sk[3];
    sk_tmp[2] = sk[4];
    sk_tmp[3] = sk[5];
    break;
  case 3:
    sk_tmp[0] = sk[3];
    sk_tmp[1] = sk[4];
    sk_tmp[2] = sk[5];
    sk_tmp[3] = sk[6];
    break;
  case 4:
    sk_tmp[0] = sk[4];
    sk_tmp[1] = sk[5];
    sk_tmp[2] = sk[7];
    sk_tmp[3] = sk[1];
    break;
  case 5:
    sk_tmp[0] = sk[5];
    sk_tmp[1] = sk[6];
    sk_tmp[2] = sk[1];
    sk_tmp[3] = sk[2];
    break;
  case 6:
    sk_tmp[0] = sk[7];
    sk_tmp[1] = sk[3];
    sk_tmp[2] = sk[5];
    sk_tmp[3] = sk[1];
    break;
  case 7:
    sk_tmp[0] = sk[4];
    sk_tmp[1] = sk[3];
    sk_tmp[2] = sk[2];
    sk_tmp[3] = sk[6];
    break;
  case 8:
    sk_tmp[0] = sk[5];
    sk_tmp[1] = sk[3];
    sk_tmp[2] = sk[4];
    sk_tmp[3] = sk[7];
    break;
  case 9:
    sk_tmp[0] = sk[4];
    sk_tmp[1] = sk[7];
    sk_tmp[2] = sk[3];
    sk_tmp[3] = sk[5];
    break;
  case 10:
    sk_tmp[0] = sk[2];
    sk_tmp[1] = sk[1];
    sk_tmp[2] = sk[3];
    sk_tmp[3] = sk[5];
    break;
  case 11:
    sk_tmp[0] = sk[4];
    sk_tmp[1] = sk[3];
    sk_tmp[2] = sk[0];
    sk_tmp[3] = sk[1];
    break;
  case 12:
    sk_tmp[0] = sk[2];
    sk_tmp[1] = sk[5];
    sk_tmp[2] = sk[6];
    sk_tmp[3] = sk[3];
    break;
  case 13:
    sk_tmp[0] = sk[3];
    sk_tmp[1] = sk[5];
    sk_tmp[2] = sk[7];
    sk_tmp[3] = sk[1];
    break;
  case 14:
    sk_tmp[0] = sk[0];
    sk_tmp[1] = sk[3];
    sk_tmp[2] = sk[2];
    sk_tmp[3] = sk[6];
    break;
  case 15:
    sk_tmp[0] = sk[5];
    sk_tmp[1] = sk[4];
    sk_tmp[2] = sk[0];
    sk_tmp[3] = sk[1];
    break;
  default:
    break;
  }

}
// 将 VIN 转换为字节序
void asscii_to_bytes(const char *assc, uint8_t *bytes, uint8_t len) {
    for (int i = 0; i < len; ++i) {
        bytes[i] = (uint8_t)assc[i]; // 按字符的 ASCII 值转换
    }
}
void show(uint8_t *a, uint8_t len) {
  for (int i = 0; i < len; i++) {
    printf("%x ", a[i]);
  }
}

