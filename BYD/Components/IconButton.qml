/*
 * 文件功能：图标按钮IconButton
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

    property string source: ""
    property int sourceWidth: 10
    property int sourceHeight: 10
    property int spacing: 5

    property int textWidth: 10
    property int textHeight: 10
    property string text: ""
    property int fontPixelSize: 10
    property color textColor: "#FFFFFF"

    signal pressed
    signal released
    signal clicked

    Column {
        anchors.fill: parent
        spacing: root.spacing

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            hoverEnabled: false

            background: Image {
                width: sourceWidth
                height: sourceHeight
                anchors.centerIn: parent
                source: root.source
                fillMode: Image.PreserveAspectFit
                opacity: parent.down ? 0.6 : 1
            }

            onPressed: root.pressed()
            onReleased: root.released()
            onClicked: root.clicked()
        }

        Label {
            id: voiceTipsLabel
            width: root.textWidth
            height: root.textHeight
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: root.text
            color: textColor
            font.pixelSize: fontPixelSize
        }
    }

}
