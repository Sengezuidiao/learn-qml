// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

/*
 * Reusable button that displays both an icon and text. Has a "clicked" signal
 * to propagate that information it to the parent.
 */

import QtQuick

Item {
    id: rootItem

    property alias text: textItem.text
    property alias icon: iconImage.source
    property real pressOpacity: 1
    // When true, use highlight colors
    property bool highlighted: false
    // When true, use outlined mode
    property bool outlined: false

    signal clicked

    width: iconImage.width + textItem.width + 50 * px
    height: 30 * px

    SequentialAnimation {
        id: pressAnimation

        alwaysRunToEnd: true

        NumberAnimation {
            target: rootItem
            property: "pressOpacity"
            to: 0.5
            duration: 100
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: rootItem
            property: "pressOpacity"
            to: 1
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: 2 * px
        opacity: rootItem.enabled ? pressOpacity : 1
        color: {
            if (highlighted)
                return rootItem.enabled ? dStyle.highlightColor : dStyle.highlightColorDisabled;
            else if (outlined)
                return "transparent";
            else
                return rootItem.enabled ? dStyle.buttonColorNormal : dStyle.buttonColorDisabled;
        }
        border.color: "#808080"
        border.width: outlined ? 1 : 0
    }

    Item {
        anchors.fill: parent
        anchors.leftMargin: 15 * px
        anchors.rightMargin: 15 * px
        anchors.bottomMargin: 2 * px

        Image {
            id: iconImage

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height * 0.5
            width: height
            fillMode: Image.PreserveAspectFit
            mipmap: true
            visible: source != ""
        }

        Text {
            id: textItem

            anchors.centerIn: parent
            // When icon is not set, text is centered
            anchors.horizontalCenterOffset: iconImage.visible ? iconImage.width / 2 : 0
            font.pixelSize: 12 * px
            font.bold: true
            color: highlighted ? "#ffffff" : outlined ? dStyle.fontColor1 : "#000000"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            pressAnimation.restart();
            rootItem.clicked();
        }
    }
}
