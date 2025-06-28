import QtQuick
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Label {
        id: label
        anchors.centerIn: parent
        font.pixelSize: 32
        font.bold: true
        color: "red"
        text: ui.count
    }
}
