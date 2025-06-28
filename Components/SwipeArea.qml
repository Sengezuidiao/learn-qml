/*
 * 文件功能：SwipeArea滑动区域
 * 作者：周德強
 * 创建日期：2024.9.1
 * 版本：V1.0
 * 本程序仅供学习使用，未经作者许可，不得用于其它任何用途
 * 版权所有，盗版必究。
 * Copyright(C) 周德強 2024-2034
 * All rights reserved
 */


import QtQuick


MouseArea {
    property point origin
    property bool ready: false
    property int threshold: 10
    property bool firstClick: false
    property int doubleClickDelay: 200

    signal move(int x, int y)
    signal swipe(string direction)
    signal swipeStarted(int x, int y)

    signal swipeUp()
    signal swipeDown()
    signal swipeLeft()
    signal swipeRight()
    signal doubleClicked()

    onPressed: {
        drag.axis = Drag.XAndYAxis
        origin = Qt.point(mouse.x, mouse.y)
    }

    onPositionChanged: {
        switch (drag.axis) {
        case Drag.XAndYAxis:
            if (Math.abs(mouse.x - origin.x) > threshold ) {
                drag.axis = Drag.XAxis
            }
            else if (Math.abs(mouse.y - origin.y) > threshold) {
                drag.axis = Drag.YAxis
            }

            if((Math.abs(mouse.x - origin.x) >= threshold) ||
               (Math.abs(mouse.y - origin.y) >= threshold))
            {
                swipeStarted(Math.abs(mouse.x - origin.x), Math.abs(mouse.y - origin.y))
            }

            // 上滑超过阈值就发送信号
            if((mouse.y < origin.y) &&
               (Math.abs(mouse.y - origin.y) >= (threshold)))
            {
                swipeUp()
            }

            // 下滑超过阈值就发送信号
            if((mouse.y > origin.y) &&
               (Math.abs(mouse.y - origin.y) >= (threshold)))
            {
                swipeDown()
            }

            // 左滑超过阈值就发送信号
            if((mouse.x < origin.x) &&
               (Math.abs(mouse.x - origin.x) >= (threshold)))
            {
                swipeLeft()
            }

            // 右滑超过阈值就发送信号
            if((mouse.x > origin.x) &&
               (Math.abs(mouse.x - origin.x) >= (threshold)))
            {
                swipeRight()
            }

            break
        case Drag.XAxis:
            move(mouse.x - origin.x, 0)
            break
        case Drag.YAxis:
            move(0, mouse.y - origin.y)
            break
        }
    }

    onReleased: {
        switch (drag.axis) {
        case Drag.XAndYAxis:
            canceled(mouse)
            break
        case Drag.XAxis:
            swipe(mouse.x - origin.x < 0 ? "left" : "right")
            break
        case Drag.YAxis:
            swipe(mouse.y - origin.y < 0 ? "up" : "down")
            break
        }
    }


    onClicked: {
        if(!timer.running)
        {
            timer.start(doubleClickDelay); // 设置双击事件的时间间隔，这里为200毫秒
            firstClick = true;
        }
        else
        {
            timer.stop();
            if(firstClick)
            {
                firstClick = false;
                doubleClicked()
            }
        }
    }

    Timer {
        id: timer
        interval: doubleClickDelay // 与 onClicked 中的值保持一致
        repeat: false
        onTriggered: {
            firstClick = false;
        }
    }
}
