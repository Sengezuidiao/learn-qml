#pragma once
#include <QObject>
#include <QString>
#include <cstdint>

#define INTERFACE (Interface::instance())
class Interface : public QObject {
  Q_OBJECT
public:
  uint8_t *key;
  char *ecu;
  uint8_t ecu_len;
  const uint8_t *seed;
  uint8_t level;
  const uint8_t *mask;
  const char *vsn;
  const char *vin;

public:
  Q_PROPERTY(uint8_t *key READ getKey NOTIFY keyChanged FINAL)
  Q_PROPERTY(char *ecu READ getKey WRITE setEcu NOTIFY keyChanged FINAL)
  Q_PROPERTY(char *ecu READ getKey WRITE setEcu NOTIFY keyChanged FINAL)

signals:
  void keyChanged(QString key);

public slots:
  void slotCalKey(QString &result);
};
