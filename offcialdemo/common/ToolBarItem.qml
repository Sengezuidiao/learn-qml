// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

/*
 * ToolbarItem defines the buttons to show in the main tool bar.
 */

import QtQuick

Item {
    id: rootItem

    property alias text: textItem.text
    property int index: 0
    property bool selected: false

    height: parent.height

    Text {
        id: textItem

        anchors.centerIn: parent
        font.pixelSize: 14 * px
        font.bold: rootItem.selected
        color: dStyle.fontColor1
        opacity: rootItem.enabled ? 1 : 0.4
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            mainWindow.toolbarIndex = rootItem.index;
        }
    }
}
