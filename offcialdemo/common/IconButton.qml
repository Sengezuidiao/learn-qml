// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

/*
 * Reusable button that only displays an icon. Has a "clicked" signal to
 * propagate that information it to the parent.
 */

import QtQuick

Item {
    id: rootItem

    property alias icon: iconImage.source
    property real iconSize: width * 0.4
    property alias pressed: mouseArea.containsPress

    signal clicked

    width: 60 * px
    height: width
    opacity: rootItem.enabled ? 1 : 0.2

    SequentialAnimation {
        id: pressAnimation

        alwaysRunToEnd: true

        NumberAnimation {
            target: iconImage
            property: "opacity"
            to: 0.5
            duration: 200
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: iconImage
            property: "opacity"
            to: 1
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    Image {
        id: iconImage

        anchors.centerIn: parent
        width: rootItem.iconSize
        height: width
        fillMode: Image.PreserveAspectFit
        mipmap: true
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: {
            pressAnimation.restart();
            rootItem.clicked();
        }
    }
}
