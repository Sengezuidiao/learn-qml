/*
 * 文件功能：状态栏StatusBar
 * 作者：周德強
 * 创建日期：2024.9.1
 * 版本：V1.0
 * 本程序仅供学习使用，未经作者许可，不得用于其它任何用途
 * 版权所有，盗版必究。
 * Copyright(C) 周德強 2024-2034
 * All rights reserved
 */

import QtQuick
import QtQuick.Controls

Item {
    id: root

    property bool positionStatus: true
    property bool bluetoothStatus: true
    property bool signalStatus: true

    Rectangle {
        anchors.fill: parent
        color: "#80FF0000"
        visible: false
    }

    Connections {
        target: ui

        function onUpdateDateTime(date, time) {
            timeLabel.text = time
        }
    }

    // 背景
    Image {
        width: parent.width
        height: 40
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 4
        source: "qrc:/Images/StatusBar/status_bar_background.png"
        fillMode: Image.Stretch

        // 时间
        Label {
            id: timeLabel
            width: 220
            height: 26
            anchors.left: parent.left
            anchors.leftMargin: 1173
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("")
            color: "#FFFFFF"
            font.pixelSize: 16
        }

        Row {
            width: 108
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 1270
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20

            // 位置
            Image {
                id: positionImage
                width: 22
                height: 21
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/Images/StatusBar/position.png"
                fillMode: Image.PreserveAspectFit
                visible: positionStatus
            }

            // 蓝牙
            Image {
                id: bluetoothImage
                width: 17
                height: 22
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/Images/StatusBar/bluetooth.png"
                fillMode: Image.PreserveAspectFit
                visible: bluetoothStatus
            }

            // 信号
            Image {
                id: signalImage
                width: 30
                height: 28
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/Images/StatusBar/signal.png"
                fillMode: Image.PreserveAspectFit
                visible: signalStatus
            }
        }
    }

    // 消息按钮
    Button {
        id: messageButton
        width: 121
        height: 46
        anchors.left: parent.left
        anchors.top: parent.top
        hoverEnabled: false

        background: Image {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            source: "qrc:/Images/Home/message_background.png"
            fillMode: Image.PreserveAspectFit
            opacity: parent.down ? 0.6 : 1

            Image {
                width: 29
                height: 26
                anchors.centerIn: parent
                source: "qrc:/Images/Home/message.png"
                fillMode: Image.PreserveAspectFit
            }
        }
    }
}
