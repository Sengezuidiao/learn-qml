// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

/*
 * SlideSelector is used in the settings for brighness and volume. It allows the
 * user to drag the slider, click the center icon and the side buttons.
 */

import QtQuick

Item {
    id: rootItem

    property alias icon: iconImage.source
    property real value: 0
    property bool iconIsClickable: false
    // Private
    property real mousePressX: 0
    property real mousePressY: 0
    property bool iconMaybePressed: false

    signal iconClicked

    function updateValueAt(posX) {
        var v = posX / width;
        v = Math.max(0, Math.min(1, v));
        rootItem.value = v;
    }

    width: 200 * px
    height: 54 * px
    opacity: rootItem.enabled ? 1 : 0.2

    Rectangle {
        anchors.fill: parent
        radius: rootItem.height / 2
        color: dStyle.slideSelectorColor
    }

    Item {
        height: parent.height
        width: rootItem.width * rootItem.value
        clip: true

        Rectangle {
            width: rootItem.width
            height: rootItem.height
            radius: rootItem.height / 2
            color: "#ffffff"
        }
    }

    Image {
        id: iconImage

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: 5 * px
        width: parent.height * 0.5
        height: width
        fillMode: Image.PreserveAspectFit
        mipmap: true
    }

    Text {
        id: valueTextItem

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 5 * px
        font.pixelSize: 16 * px
        font.bold: true
        text: (100 * rootItem.value).toFixed()
        color: "#808080"
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            mousePressX = mouseX;
            mousePressY = mouseY;
            // Check if press is on top of icon
            if (iconIsClickable && (mouseX / width) > 0.35 && (mouseX / width) < 0.48)
                iconMaybePressed = true;
            else
                rootItem.updateValueAt(mouseX);
        }
        onPositionChanged: {
            rootItem.updateValueAt(mouseX);
            const clickMargin = 10 * px;
            if (Math.abs(mouseX - mousePressX) > clickMargin)
                iconMaybePressed = false;
            if (Math.abs(mouseY - mousePressY) > clickMargin)
                iconMaybePressed = false;
        }
        onReleased: {
            if (iconMaybePressed)
                rootItem.iconClicked();
            iconMaybePressed = false;
        }
    }

    IconButton {
        anchors.left: parent.left
        anchors.leftMargin: 1 * px
        anchors.verticalCenter: parent.verticalCenter
        icon: "../images/icons/grey/arrow2-left.png"
        opacity: rootItem.value > 0 ? 1 : 0.4
        onClicked: {
            var v = Math.ceil(rootItem.value / 0.05) * 0.05 - 0.05;
            v = Math.max(0, v);
            rootItem.value = v;
        }
    }

    IconButton {
        anchors.right: parent.right
        anchors.rightMargin: 1 * px
        anchors.verticalCenter: parent.verticalCenter
        icon: "../images/icons/grey/arrow2-right.png"
        opacity: rootItem.value < 1 ? 1 : 0.4
        onClicked: {
            var v = Math.floor(rootItem.value / 0.05) * 0.05 + 0.05;
            v = Math.min(1, v);
            rootItem.value = v;
        }
    }
}
