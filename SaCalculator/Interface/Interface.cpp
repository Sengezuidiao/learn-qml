#include "CalcBridge.h"
#include "sa/sa.h"

void CalcBridge::calculateKey(const QString &ecu, int level,
                              const QString &seedHex, const QString &vin,
                              const QString &vsn, const QString &maskHex) {
  uint8_t seed[4], mask[4], key[4] = {};
  for (int i = 0; i < 4; ++i) {
    seed[i] = seedHex.mid(i * 2, 2).toUInt(nullptr, 16);
    mask[i] = maskHex.mid(i * 2, 2).toUInt(nullptr, 16);
  }

  Request req{.ecu = ecu.toUtf8().constData(),
              .ecu_len = static_cast<uint8_t>(ecu.length()),
              .seed = seed,
              .level = static_cast<uint8_t>(level),
              .key = key,
              .mask = mask,
              .vsn = vsn.toUtf8().constData(),
              .vin = vin.toUtf8().constData()};

  const char vin1[17] = {0x57, 0x4c, 0x58, 0x4e, 0x59, 0x35, 0x30, 0x35, 0x30,
                        0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38, 0x38};
  const char vsn1[20] = {0x47, 0x58, 0x41, 0x31, 0x30, 0x33, 0x30,
                        0x42, 0x45, 0x56, 0x44, 0x31, 0x20, 0x20,
                        0x20, 0x20, 0x20, 0x20, 0x20, 0x20};
  uint8_t seed1[4] = {0x21, 0x2a, 0x38, 0x46};
  uint8_t mask1[4] = {0xee, 0x77, 0x55, 0x33};

  req.ecu = "TBOX";
  req.ecu_len = 4;
  req.vin = vin1;
  req.vsn = vsn1;
  req.level = 0x3;
  req.key = key;
  req.seed = seed;
  req.mask = mask;
  SeedToKey(&req);

  QString keyStr;
  for (int i = 0; i < 4; ++i)
    keyStr += QString("%1").arg(key[i], 2, 16, QLatin1Char('0')).toUpper();

  emit keyReady(keyStr);
}
