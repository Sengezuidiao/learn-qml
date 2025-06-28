/*
 * 文件功能：图标开关IconSwitch
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

    property string color: "#FFFFFF"

    property string sourceOn: ""
    property string sourceOff: ""
    property int sourceWidth: 100
    property int sourceHeight: 40
    property int spacing: 5

    property int textWidth: 10
    property int textHeight: 10
    property string text: ""
    property int fontPixelSize: 16
    property color onTextColor: "#000000"
    property color offTextColor: "#FFFFFF"

    property bool switchStatus: false

    signal pressed
    signal released
    signal clicked


    Rectangle {
        anchors.fill: parent
        color: switchStatus ? "#FFFFFF" : "#80000000"
        radius: 14

        Image {
            width: sourceWidth
            height: sourceHeight
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 25
            source: switchStatus ? root.sourceOff : root.sourceOn
            fillMode: Image.PreserveAspectFit
        }

        Label {
            width: root.textWidth
            height: root.textHeight
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 75
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: root.text
            color: switchStatus ? onTextColor : offTextColor
            font.pixelSize: fontPixelSize
        }

        MouseArea {
            anchors.fill: parent
            onPressed: root.pressed()
            onReleased: root.released()
            onClicked: {
                switchStatus = !switchStatus
                root.clicked()
            }
        }
    }
}
