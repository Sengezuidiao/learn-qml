/*
 * 文件功能：实现一个接口类源文件，用于QML与C++交互
 * 作者：周德強
 * 创建日期：2024.9.1
 * 版本：V1.0
 * 本程序仅供学习使用，未经作者许可，不得用于其它任何用途
 * 版权所有，盗版必究。
 * Copyright(C) 周德強 2024-2034
 * All rights reserved
 */

#include "Interface.h"
#include <QDebug>
#include <QDateTime>

Q_GLOBAL_STATIC(Interface, interface)

Interface::Interface(QObject *parent)
    : QObject{parent}
{
    pageIndex = PAGE_HOME;
    previousPageIndex = pageIndex;

    acLeftTemperature = 26;
    acRightTemperature = 26;
    acFanLevel = 5;

    settingsFunctionValue = 0;
    settingsSteering = 1;
    settingsTrafficEnvironment = 1;
    settingsParking = true;
    settingsLampHeight = 7;

    controlCenterWLANStatus = true;
    controlCenterBluetoothStatus = true;
    controlCenterPositionStatus = true;
    controlCenterMediaVolume = 7;


    updateTimer = new QTimer();
    updateTimer->start(100);
    connect(updateTimer, SIGNAL(timeout()), this, SLOT(slotUpdateTimer()));

}

Interface *Interface::instance()
{
    return interface;
}

int Interface::getControlCenterMediaVolume() const
{
    return controlCenterMediaVolume;
}

void Interface::setControlCenterMediaVolume(int newControlCenterMediaVolume)
{
    if (controlCenterMediaVolume == newControlCenterMediaVolume)
        return;
    controlCenterMediaVolume = newControlCenterMediaVolume;
    emit controlCenterMediaVolumeChanged();
}

bool Interface::getControlCenterPositionStatus() const
{
    return controlCenterPositionStatus;
}

void Interface::setControlCenterPositionStatus(bool newControlCenterPositionStatus)
{
    if (controlCenterPositionStatus == newControlCenterPositionStatus)
        return;
    controlCenterPositionStatus = newControlCenterPositionStatus;
    emit controlCenterPositionStatusChanged();
}

bool Interface::getControlCenterBluetoothStatus() const
{
    return controlCenterBluetoothStatus;
}

void Interface::setControlCenterBluetoothStatus(bool newControlCenterBluetoothStatus)
{
    if (controlCenterBluetoothStatus == newControlCenterBluetoothStatus)
        return;
    controlCenterBluetoothStatus = newControlCenterBluetoothStatus;
    emit controlCenterBluetoothStatusChanged();
}

bool Interface::getControlCenterWLANStatus() const
{
    return controlCenterWLANStatus;
}

void Interface::setControlCenterWLANStatus(bool newControlCenterWLANStatus)
{
    if (controlCenterWLANStatus == newControlCenterWLANStatus)
        return;
    controlCenterWLANStatus = newControlCenterWLANStatus;
    emit controlCenterWLANStatusChanged();
}

int Interface::getSettingsTrafficEnvironment() const
{
    return settingsTrafficEnvironment;
}

void Interface::setSettingsTrafficEnvironment(int newSettingsTrafficEnvironment)
{
    if (settingsTrafficEnvironment == newSettingsTrafficEnvironment)
        return;
    settingsTrafficEnvironment = newSettingsTrafficEnvironment;
    emit settingsTrafficEnvironmentChanged();
}

bool Interface::getSettingsParking() const
{
    return settingsParking;
}

void Interface::setSettingsParking(bool newSettingsParking)
{
    if (settingsParking == newSettingsParking)
        return;
    settingsParking = newSettingsParking;
    emit settingsParkingChanged();
}

int Interface::getSettingsSteering() const
{
    return settingsSteering;
}

void Interface::setSettingsSteering(int newSettingsSteering)
{
    if (settingsSteering == newSettingsSteering)
        return;
    settingsSteering = newSettingsSteering;
    emit settingsSteeringChanged();
}

int Interface::getSettingsLampHeight() const
{
    return settingsLampHeight;
}

void Interface::setSettingsLampHeight(int newSettingsLampHeight)
{
    if (settingsLampHeight == newSettingsLampHeight)
        return;
    settingsLampHeight = newSettingsLampHeight;
    emit settingsLampHeightChanged();
}

int Interface::getSettingsFunctionValue() const
{
    return settingsFunctionValue;
}

void Interface::setSettingsFunctionValue(int newSettingsFunctionValue)
{
    if (settingsFunctionValue == newSettingsFunctionValue)
        return;
    settingsFunctionValue = newSettingsFunctionValue;
    emit settingsFunctionValueChanged();
}


int Interface::getAcFanLevel() const
{
    return acFanLevel;
}

void Interface::setAcFanLevel(int newAcFanLevel)
{
    if (acFanLevel == newAcFanLevel)
        return;
    acFanLevel = newAcFanLevel;
    emit acFanLevelChanged();
}


int Interface::getAcRightTemperature() const
{
    return acRightTemperature;
}

void Interface::setAcRightTemperature(int newAcRightTemperature)
{
    if (acRightTemperature == newAcRightTemperature)
        return;
    acRightTemperature = newAcRightTemperature;
    emit acRightTemperatureChanged();
}

int Interface::getAcLeftTemperature() const
{
    return acLeftTemperature;
}

void Interface::setAcLeftTemperature(int newAcLeftTemperature)
{
    if (acLeftTemperature == newAcLeftTemperature)
        return;
    acLeftTemperature = newAcLeftTemperature;
    emit acLeftTemperatureChanged();
}

int Interface::getPAGE_CONTROL()
{
    return PAGE_CONTROL;
}

void Interface::slotUpdateTimer()
{
    // 获取当前日期和时间
    QDateTime currentTime = QDateTime::currentDateTime();
    QTime currentTimeOnly = currentTime.time();
    QDate currentDateOnly = currentTime.date();


    QString time = currentTimeOnly.toString("HH:mm");
    QString date = currentDateOnly.toString("M月d日");
    int week = currentDateOnly.dayOfWeek();

    QString weekString;
    switch (week)
    {
        case Qt::Sunday: weekString = " 星期日"; break;
        case Qt::Monday: weekString = " 星期一"; break;
        case Qt::Tuesday: weekString = " 星期二"; break;
        case Qt::Wednesday: weekString = " 星期三"; break;
        case Qt::Thursday: weekString = " 星期四"; break;
        case Qt::Friday: weekString = " 星期五"; break;
        case Qt::Saturday: weekString = " 星期六"; break;
    }
    date.append(weekString);

    emit updateDateTime(date, time);
}

int Interface::getPAGE_SETTINGS()
{
    return PAGE_SETTINGS;
}

int Interface::getPAGE_APP()
{
    return PAGE_APP;
}

int Interface::getPAGE_AC()
{
    return PAGE_AC;
}

int Interface::getPAGE_HOME()
{
    return PAGE_HOME;
}

int Interface::getPAGE_MAIN()
{
    return PAGE_MAIN;
}

int Interface::getPreviousPageIndex() const
{
    return previousPageIndex;
}

void Interface::setPreviousPageIndex(int newPreviousPageIndex)
{
    if (previousPageIndex == newPreviousPageIndex)
        return;
    previousPageIndex = newPreviousPageIndex;
    emit previousPageIndexChanged();
}

int Interface::getPageIndex() const
{
    return pageIndex;
}

void Interface::setPageIndex(int newPageIndex)
{
    if(previousPageIndex != pageIndex)
    {
        previousPageIndex = pageIndex;
    }

    if (pageIndex == newPageIndex)
        return;
    pageIndex = newPageIndex;
    emit pageIndexChanged();
}


