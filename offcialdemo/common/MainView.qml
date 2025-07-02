// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

/*
 * MainView includes showing and hiding logic with zoom and opacity for all main
 * views like HomeView, MediaView and MyCarView. They use this component as
 * their root.
 */

import QtQuick

Item {
    id: rootItem

    property bool show: true
    property real showAnimated: show

    anchors.fill: parent
    scale: 0.9 + showAnimated * 0.1
    opacity: showAnimated
    visible: opacity > 0

    Behavior on showAnimated {
        NumberAnimation {
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }
}
