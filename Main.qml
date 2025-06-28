/*
 * 文件功能：比亚迪中控屏例程
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
import QtQuick.Templates as PopupTemp

import "./HMI"
import "./Components"

Window {
    id: homePage
    width: 1520
    height: 856
    visible: true
    title: qsTr("BYD")

    // 界面索引
    property int pageIndex: ui.pageIndex
    property int previousPageIndex: 0

    Component.onCompleted: {
        ui.pageIndex = ui.PAGE_HOME
    }

    // 背景
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "qrc:/Images/Home/base.png"
        fillMode: Image.PreserveAspectCrop
    }

    // 导航栏
    Navigation {
        id: navigation
        // width: 108
        height: parent.height
        anchors.left: parent.left
        anchors.top: parent.top

        onBack: {
            controlCenterPage.hide()
        }

        onHome: {
            controlCenterPage.hide()
        }
    }

    // 界面加载器
    Loader {
        id: pageLoader
    }

    // 控制界面
    ControlCenter {
        id: controlCenterPage
        width: 1414
        height: 856
        x: 108
        y: -controlCenterPage.height
    }

    // 滑动区域
    Rectangle {
        width: 1292
        height: 60
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        color: "transparent"

        SwipeArea {
            id: controlSwipeArea
            anchors.fill: parent

            onSwipeDown: {
                downMoveAnimation.start()
                downOpacityAnimation.start()
            }
        }

        // 向下滑动透明度动画
        NumberAnimation {
            id: downOpacityAnimation
            target: controlCenterPage
            properties: "opacity"
            from: 0
            to: 1
            duration: 700
            easing {type: Easing.OutQuad}
        }

        // 向下显示动画
        NumberAnimation {
            id: downMoveAnimation
            target: controlCenterPage
            properties: "y"
            from: -controlCenterPage.height
            to: 0
            duration: 250
            easing {type: Easing.OutQuad}
        }
    }

    // 切换界面
    onPageIndexChanged: {
        console.log("pageIndex:" + pageIndex)
        console.log("previousPageIndex:" + previousPageIndex)

        switch(pageIndex)
        {
            case ui.PAGE_HOME:
            {
                pageLoader.source = "HMI/Home.qml"
            } break

            case ui.PAGE_AC:
            {
                pageLoader.source = "HMI/AC.qml"
            } break

            case ui.PAGE_APP:
            {
                pageLoader.source = "HMI/App.qml"
            } break

            case ui.PAGE_SETTINGS:
            {
                pageLoader.source = "HMI/Settings.qml"
            } break
        }
    }
}
