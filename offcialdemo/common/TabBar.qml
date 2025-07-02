// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

/*
 * TabBar is a shared component for both the MediaView and MyCarView, which
 * allows them to choose between multiple tabs.
 */

import QtQuick

Item {
    id: rootItem

    property int currentIndex: 0
    property ListModel model

    height: 30 * px

    Rectangle {
        anchors.fill: tabsRow
        color: dStyle.backgroundColor1
        radius: height / 2
        opacity: 0.7
    }

    Row {
        id: tabsRow

        Repeater {
            id: repeater

            model: rootItem.model

            TabBarItem {
                height: rootItem.height
                text: model.name
                icon: dStyle.nightMode ? "../images/icons/white/" + model.icon : "../images/icons/" + model.icon
                isSelected: rootItem.currentIndex == model.index
                onClicked: {
                    rootItem.currentIndex = model.index;
                }
            }
        }
    }
}
