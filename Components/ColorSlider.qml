/*
 * 文件功能：彩色滑动条ColorSlider
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
    property string backgroundColor: "#80000000"
    property string startColor: "#0532FB"
    property string endColor: "#52E6FB"

    property string sourceOn: ""
    property string sourceOff: ""
    property int sourceWidth: 36
    property int sourceHeight: 30
    property int spacing: 5

    property int textWidth: 10
    property int textHeight: 10
    property string text: ""
    property int fontPixelSize: 20
    property int autoFontPixelSize: 14
    property color textColor: "#FFFFFF"
    property color autoTextColor: "#80FFFFFF"

    property bool switchStatus: false

    property int minValue: 0
    property int maxValue: 10
    property int value: 5
    property int stepSize: 1


    Rectangle {
        id: backroundRectangle
        anchors.fill: parent
        color: root.backgroundColor
        radius: 14

        Rectangle {
            id: innerRectangle
            width: getWidth()
            height: parent.height
            x: 0
            anchors.verticalCenter: parent.verticalCenter
            radius: 14

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: startColor }
                GradientStop { position: 1.0; color: endColor }
            }

            property real stepSize: backroundRectangle.width / (slider.to)

            function getWidth()
            {
                if(slider.value == slider.to)
                {
                    var width = (slider.value + 1) * stepSize
                    if(width >= backroundRectangle.width)
                    {
                        width = backroundRectangle.width
                    }

                    return width
                }
                else
                {
                    return slider.value * stepSize
                }
            }

            function getRadius()
            {
                switch(slider.value)
                {
                    case 1: return 2
                    case 2: return 4
                    case 3: return 6
                    case 4: return 8
                    case 5: return 10
                    case 6: return 12
                    default: return 14
                }
            }
        }

        Slider {
            id: slider
            anchors.fill: parent
            value: root.value
            from: minValue
            to: maxValue
            stepSize: root.stepSize
            focusPolicy: Qt.NoFocus

            background: Rectangle {
                implicitWidth: 0
                implicitHeight: parent.height
                color: "transparent"
            }

            handle: Rectangle {
                implicitWidth: 0
                implicitHeight: parent.height
                color: "transparent"
            }

            onValueChanged: {
                // console.log("### value: " + value)
                root.value = value
            }
        }
    }
}
