// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

/*
 * QuickActions shows a popup list of buttons when the "show" property is set to
 * true by the HomeView.
 */

import QtQuick

Item {
    id: rootItem

    property bool show: false
    property real showAnimated: show

    width: parent.width * 0.4
    height: actionsListView.height
    opacity: showAnimated
    visible: opacity > 0
    scale: 0.6 + showAnimated * 0.4
    transformOrigin: Item.BottomLeft

    // Hider when user clicks outside the popup
    MouseArea {
        anchors.fill: parent
        anchors.margins: -2000
        z: -1
        onClicked: {
            rootItem.show = false;
        }
    }

    Rectangle {
        anchors.fill: actionsListView
        color: dStyle.backgroundColor1
    }

    ListView {
        id: actionsListView

        width: rootItem.width
        height: contentHeight
        model: actionsModel

        delegate: Item {
            id: actionListItem

            width: rootItem.width
            height: 40 * px

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20 * px
                anchors.right: itemIconImage.left
                anchors.rightMargin: 10 * px
                elide: Text.ElideRight
                text: model.text
                font.pixelSize: 14 * px
                color: dStyle.fontColor1
            }

            Image {
                id: itemIconImage

                readonly property string imagePath: dStyle.nightMode ? "../images/icons/white/" : "../images/icons/"

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 20 * px
                height: parent.height * 0.4
                width: height
                source: imagePath + model.icon
                mipmap: true
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 10 * px
                height: 1 * px
                color: "#808080"
                opacity: 0.2
                visible: model.index != 0
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    clickAnimation.restart();
                }
            }

            SequentialAnimation {
                id: clickAnimation

                NumberAnimation {
                    target: actionListItem
                    property: "opacity"
                    to: 0.5
                    duration: 200
                    easing.type: Easing.InOutQuad
                }

                NumberAnimation {
                    target: actionListItem
                    property: "opacity"
                    to: 1
                    duration: 200
                    easing.type: Easing.InOutQuad
                }

                ScriptAction {
                    script: {
                        rootItem.show = false;
                    }
                }
            }
        }
    }

    ListModel {
        id: actionsModel

        ListElement {
            text: "Navigate to <b>\"Home\"</b>"
            icon: "place.png"
        }

        ListElement {
            text: "Navigate to <b>\"Work\"</b>"
            icon: "place.png"
        }

        ListElement {
            text: "Play <b>\"Favorites\"</b>"
            icon: "music-note.png"
        }

        ListElement {
            text: "Play <b>\"Yle Radio Suomi\"</b>"
            icon: "radio.png"
        }

        ListElement {
            text: "Call <b>\"Amanda Marie Jennison\"</b>"
            icon: "call.png"
        }

        ListElement {
            text: "Call <b>\"Supervisor\"</b>"
            icon: "call.png"
        }
    }

    Behavior on showAnimated {
        NumberAnimation {
            duration: 400
            easing.type: Easing.InOutQuad
        }
    }
}
