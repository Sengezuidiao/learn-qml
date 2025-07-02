// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

/*
 * HomeView contains a scrolling background in 3D, user name and image, quick
 * actions and an events list.
 */

import "../common"
import QtQuick
import QtQuick3D
import QtQuick3D.Helpers

MainView {
    id: rootItem

    Image {
        id: backgroundImage

        width: mainWindow.width
        height: mainWindow.height
        source: "../images/background2.png"
        opacity: 1 - dStyle.nightModeAnimated
        visible: opacity > 0
    }

    Image {
        id: backgroundImageNight

        width: mainWindow.width
        height: mainWindow.height
        source: "../images/background1.png"
        opacity: dStyle.nightModeAnimated
        visible: opacity > 0
    }

    View3D {
        id: view3D

        property real scenePosition: 0
        property real sceneSize: 7200

        width: mainWindow.width
        height: mainWindow.height
        environment: sceneEnvironment1

        SceneEnvironment {
            id: sceneEnvironment1

            antialiasingMode: SceneEnvironment.MSAA
            antialiasingQuality: SceneEnvironment.High
            backgroundMode: SceneEnvironment.Transparent
            lightProbe: probeTexture
            probeExposure: dData.cityMode ? 5 - 3 * dStyle.nightModeAnimated : 8 - 6 * dStyle.nightModeAnimated

            Texture {
                id: probeTexture

                source: "../images/block-gradient.hdr"
                mappingMode: Texture.LightProbe
            }
        }

        PerspectiveCamera {
            id: camera1

            fieldOfView: 60
            z: 20
            y: 200
            eulerRotation.y: dData.cityMode ? 0 : -10
        }

        DirectionalLight {
            id: lightDirectional

            eulerRotation.y: 180
            eulerRotation.x: -75
            eulerRotation.z: 180
            brightness: 1.1 + 2 * dStyle.nightModeAnimated
        }

        // Just a helper item to get syncronized with the animation triggers.
        // Consider custom C++ timer to get also elapsed time (so animations
        // move equally fast also with decreased fps).
        Item {
            width: 1
            height: 1
            onRotationChanged: {
                var newPosition = view3D.scenePosition + dData.homeSceneSpeed;
                if (newPosition > view3D.sceneSize)
                    newPosition -= view3D.sceneSize;
                view3D.scenePosition = newPosition;
            }

            NumberAnimation on rotation {
                running: dData.homeSceneSpeed > 0
                loops: Animation.Infinite
                from: 0
                to: 360
                duration: 1000
            }
        }

        // 2 terrains to get continuing view
        Terrain {
            id: terrain

            eulerRotation: Qt.vector3d(-80, 0, 90)
            scale: Qt.vector3d(0.18, 0.18, 0.18)
            x: 4000 - view3D.scenePosition
            d: 1 - dStyle.nightModeAnimated
        }

        Terrain {
            id: terrain2

            eulerRotation: Qt.vector3d(-80, 0, 90)
            scale: Qt.vector3d(0.18, 0.18, 0.18)
            x: 4000 - view3D.sceneSize - view3D.scenePosition
            d: 1 - dStyle.nightModeAnimated
        }
    }

    Item {
        id: contentArea

        /* ------------------------------------------------------
           ADAPTIVE UI FOR ANY SCREEN
           ------------------------------------------------------

           How to see this in action:

           1. Resize your browser window. See how the UI adapts to different screen sizes.

           Demonstrates how sizing and anchors adjust dynamically
           to different resolutions and aspect ratios. The px property
           ensures consistent scaling between small and large displays.
        */
        anchors.fill: parent
        anchors.margins: 10 * px
        anchors.bottomMargin: 20 * px

        Image {
            id: userImage

            anchors.left: parent.left
            anchors.leftMargin: 10 * px
            anchors.top: parent.top
            anchors.topMargin: 10 * px
            width: 120 * px
            height: width
            fillMode: Image.PreserveAspectFit
            source: "../images/user.png"
        }

        Item {
            anchors.left: userImage.right
            anchors.leftMargin: 20 * px
            anchors.verticalCenter: userImage.verticalCenter
            height: 60 * px

            Text {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 4 * px
                color: dStyle.fontColor1
                font.pixelSize: 20 * px
                font.bold: true
                text: dData.userName
            }

            Row {
                anchors.bottom: parent.bottom
                spacing: 4 * px

                Image {
                    width: 20 * px
                    height: width
                    fillMode: Image.PreserveAspectFit
                    source: "../images/" + dStyle.iconBluetooth
                }

                Text {
                    color: dStyle.fontColor1
                    font.pixelSize: 14 * px
                    text: "iPhone 16 Pro"
                }

                Item {
                    width: 10 * px
                    height: 1
                }

                Image {
                    width: 20 * px
                    height: width
                    fillMode: Image.PreserveAspectFit
                    source: "../images/" + dStyle.iconPhone
                }

                Text {
                    color: dStyle.fontColor1
                    font.pixelSize: 14 * px
                    text: dData.phoneCharge + " % charge"
                }
            }
        }

        ListView {
            id: eventsListView
            objectName: "#eventListView"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 0.4
            height: contentHeight
            model: eventsModel
            interactive: false

            delegate: Item {
                id: eventListItem

                width: eventsListView.width
                height: 40 * px

                Rectangle {
                    anchors.fill: parent
                    color: dStyle.backgroundColor1
                    opacity: 0.9
                }

                Image {
                    id: itemIconImage

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20 * px
                    height: parent.height * 0.4
                    width: height
                    source: "../images/icons/pink/calendar.png"
                    mipmap: true
                }

                Text {
                    id: itemTimeText

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: itemIconImage.right
                    anchors.leftMargin: 20 * px
                    text: model.time
                    font.pixelSize: 12 * px
                    font.bold: true
                    color: dStyle.fontColor1
                }

                Text {
                    id: itemEventText

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: itemTimeText.right
                    anchors.leftMargin: 20 * px
                    anchors.right: parent.right
                    anchors.rightMargin: 10 * px
                    elide: Text.ElideRight
                    text: model.text
                    font.pixelSize: 14 * px
                    color: dStyle.fontColor1
                }

                Rectangle {
                    visible: index != eventsModel.count - 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    width: parent.width - 10 * px
                    height: 1 * px
                    color: "#808080"
                    opacity: 0.2
                }

                MouseArea {

                    // TODO: Open the event

                    anchors.fill: parent
                    onClicked: {
                        clickAnimation.restart();
                    }
                }

                SequentialAnimation {
                    id: clickAnimation

                    NumberAnimation {
                        target: eventListItem
                        property: "opacity"
                        to: 0.5
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }

                    NumberAnimation {
                        target: eventListItem
                        property: "opacity"
                        to: 1
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        ListModel {
            id: eventsModel

            ListElement {
                time: "09:00 AM"
                text: "Project X daily meeting"
            }

            ListElement {
                time: "10:00 AM"
                text: "Project Y kick-off"
            }

            ListElement {
                time: "10:30 AM"
                text: "Catch-up coffee with Jeff at Starbucks"
            }
        }

        TextButton {
            id: quickActionsButton

            objectName: "#quickActions"
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            text: "Quick actions"
            icon: quickActions.show ? "../images/icons/white/arrow-down.png" : "../images/icons/white/arrow-up.png"
            highlighted: true
            onClicked: {
                quickActions.show = !quickActions.show;
            }
        }

        QuickActions {
            id: quickActions

            anchors.left: parent.left
            anchors.bottom: quickActionsButton.top
            anchors.bottomMargin: 10 * px
        }
    }

    DebugView {
        source: view3D
        visible: dData.debug
    }

    Item {
        id: __materialLibrary__
    }
}
