// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

/*
 * TabBarItem defines the tabs to use in TabBar.
 */

import QtQuick

Item {
    id: rootItem

    property alias text: textItem.text
    property alias icon: iconImage.source
    property real pressOpacity: 1
    property bool isSelected: false
    property real isSelectedAnimated: isSelected

    signal clicked

    width: textItem.width + iconImage.width + 30 * px
    height: 30 * px

    Item {
        anchors.fill: parent
        opacity: rootItem.enabled ? pressOpacity : 0.5

        Rectangle {
            anchors.fill: parent
            color: dStyle.tabColor
            radius: height / 2
            opacity: rootItem.isSelectedAnimated
            scale: 0.8 + 0.2 * isSelectedAnimated
        }

        Image {
            id: iconImage

            anchors.left: parent.left
            anchors.leftMargin: 8 * px
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height * 0.5
            width: height
            fillMode: Image.PreserveAspectFit
            opacity: 0.6 + isSelectedAnimated * 0.4
            mipmap: true
            visible: source != ""
        }

        Text {
            id: textItem

            anchors.centerIn: parent
            anchors.horizontalCenterOffset: iconImage.visible ? iconImage.width / 2 : 0
            font.pixelSize: 11 * px
            font.bold: true
            color: dStyle.fontColor1
            opacity: 0.7 + isSelectedAnimated * 0.3
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            rootItem.clicked();
        }
    }

    Behavior on isSelectedAnimated {
        NumberAnimation {
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }
}
