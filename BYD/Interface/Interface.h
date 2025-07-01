/*
 * 文件功能：定义一个接口类头文件，用于QML与C++交互
 * 作者：周德強
 * 创建日期：2024.9.1
 * 版本：V1.0
 * 本程序仅供学习使用，未经作者许可，不得用于其它任何用途
 * 版权所有，盗版必究。
 * Copyright(C) 周德強 2024-2034
 * All rights reserved
 */

#ifndef INTERFACE_H
#define INTERFACE_H

#include <QObject>
#include <QTimer>

#define INTERFACE (Interface::instance())

class Interface : public QObject
{
    Q_OBJECT
public:
    explicit Interface(QObject *parent = nullptr);
    static Interface* instance();


    // 功能界面
    const static int PAGE_MAIN = 0;         // 主界面
    const static int PAGE_HOME = 1;         // Home界面
    const static int PAGE_AC = 2;           // 空调界面
    const static int PAGE_APP = 3;          // 应用界面
    const static int PAGE_SETTINGS = 4;     // 设置界面
    const static int PAGE_CONTROL = 5;      // 控制中心界面

    QTimer *updateTimer;

    // 主页
    int pageIndex;                      // 界面索引
    int previousPageIndex;              // 上一个界面索引

    // 空调
    int acLeftTemperature;
    int acRightTemperature;
    int acFanLevel;

    // 设置
    int settingsFunctionValue;
    int settingsSteering;
    int settingsTrafficEnvironment;
    bool settingsParking;
    int settingsLampHeight;

    // 控制中心
    bool controlCenterWLANStatus;
    bool controlCenterBluetoothStatus;
    bool controlCenterPositionStatus;
    int controlCenterMediaVolume;


    int getPageIndex() const;
    void setPageIndex(int newPageIndex);

    int getPreviousPageIndex() const;
    void setPreviousPageIndex(int newPreviousPageIndex);


    static int getPAGE_MAIN();
    static int getPAGE_HOME();
    static int getPAGE_AC();
    static int getPAGE_APP();
    static int getPAGE_SETTINGS();
    static int getPAGE_CONTROL();

    int getAcLeftTemperature() const;
    void setAcLeftTemperature(int newAcLeftTemperature);
    int getAcRightTemperature() const;
    void setAcRightTemperature(int newAcRightTemperature);

    int getAcFanLevel() const;
    void setAcFanLevel(int newAcFanLevel);

    int getFunctionValue() const;
    void setFunctionValue(int newFunctionValue);

    int getSettingsFunctionValue() const;
    void setSettingsFunctionValue(int newSettingsFunctionValue);

    int getSettingsLampHeight() const;
    void setSettingsLampHeight(int newSettingsLampHeight);

    int getSettingsSteering() const;
    void setSettingsSteering(int newSettingsSteering);

    bool getSettingsParking() const;
    void setSettingsParking(bool newSettingsParking);

    int getSettingsTrafficEnvironment() const;
    void setSettingsTrafficEnvironment(int newSettingsTrafficEnvironment);

    bool getControlCenterWLANStatus() const;
    void setControlCenterWLANStatus(bool newControlCenterWLANStatus);

    bool getControlCenterBluetoothStatus() const;
    void setControlCenterBluetoothStatus(bool newControlCenterBluetoothStatus);

    bool getControlCenterPositionStatus() const;
    void setControlCenterPositionStatus(bool newControlCenterPositionStatus);

    int getControlCenterMediaVolume() const;
    void setControlCenterMediaVolume(int newControlCenterMediaVolume);

signals:
    void pageIndexChanged();
    void previousPageIndexChanged();
    void updateDateTime(QString date, QString time);

    void acLeftTemperatureChanged();
    void acRightTemperatureChanged();
    void acFanLevelChanged();

    void settingsFunctionValueChanged();
    void settingsLampHeightChanged();
    void settingsSteeringChanged();
    void settingsParkingChanged();
    void settingsTrafficEnvironmentChanged();

    void controlCenterWLANStatusChanged();
    void controlCenterBluetoothStatusChanged();
    void controlCenterPositionStatusChanged();
    void controlCenterMediaVolumeChanged();

public slots:
    void slotUpdateTimer();

private:
    Q_PROPERTY(int PAGE_MAIN READ getPAGE_MAIN CONSTANT FINAL)
    Q_PROPERTY(int PAGE_HOME READ getPAGE_HOME CONSTANT FINAL)
    Q_PROPERTY(int PAGE_AC READ getPAGE_AC CONSTANT FINAL)
    Q_PROPERTY(int PAGE_APP READ getPAGE_APP CONSTANT FINAL)
    Q_PROPERTY(int PAGE_SETTINGS READ getPAGE_SETTINGS CONSTANT FINAL)
    Q_PROPERTY(int PAGE_CONTROL READ getPAGE_CONTROL CONSTANT FINAL)

    Q_PROPERTY(int pageIndex READ getPageIndex WRITE setPageIndex NOTIFY pageIndexChanged FINAL)
    Q_PROPERTY(int previousPageIndex READ getPreviousPageIndex WRITE setPreviousPageIndex NOTIFY previousPageIndexChanged FINAL)

    Q_PROPERTY(int acLeftTemperature READ getAcLeftTemperature WRITE setAcLeftTemperature NOTIFY acLeftTemperatureChanged FINAL)
    Q_PROPERTY(int acRightTemperature READ getAcRightTemperature WRITE setAcRightTemperature NOTIFY acRightTemperatureChanged FINAL)
    Q_PROPERTY(int acFanLevel READ getAcFanLevel WRITE setAcFanLevel NOTIFY acFanLevelChanged FINAL)

    Q_PROPERTY(int settingsFunctionValue READ getSettingsFunctionValue WRITE setSettingsFunctionValue NOTIFY settingsFunctionValueChanged FINAL)
    Q_PROPERTY(int settingsLampHeight READ getSettingsLampHeight WRITE setSettingsLampHeight NOTIFY settingsLampHeightChanged FINAL)
    Q_PROPERTY(int settingsSteering READ getSettingsSteering WRITE setSettingsSteering NOTIFY settingsSteeringChanged FINAL)
    Q_PROPERTY(bool settingsParking READ getSettingsParking WRITE setSettingsParking NOTIFY settingsParkingChanged FINAL)
    Q_PROPERTY(int settingsTrafficEnvironment READ getSettingsTrafficEnvironment WRITE setSettingsTrafficEnvironment NOTIFY settingsTrafficEnvironmentChanged FINAL)

    Q_PROPERTY(bool controlCenterWLANStatus READ getControlCenterWLANStatus WRITE setControlCenterWLANStatus NOTIFY controlCenterWLANStatusChanged FINAL)
    Q_PROPERTY(bool controlCenterBluetoothStatus READ getControlCenterBluetoothStatus WRITE setControlCenterBluetoothStatus NOTIFY controlCenterBluetoothStatusChanged FINAL)
    Q_PROPERTY(bool controlCenterPositionStatus READ getControlCenterPositionStatus WRITE setControlCenterPositionStatus NOTIFY controlCenterPositionStatusChanged FINAL)
    Q_PROPERTY(int controlCenterMediaVolume READ getControlCenterMediaVolume WRITE setControlCenterMediaVolume NOTIFY controlCenterMediaVolumeChanged FINAL)
};

#endif // INTERFACE_H
