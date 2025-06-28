import QtQuick

Rectangle {
    id: root
    width: 400
    height: 400
    color: "blue"
    Image {
        width: parent.width
        height: parent.height
        // Image source can be a local file or a remote URL
        source: "https://yelog.org/img/avatar.jpg"
        anchors.centerIn: parent
        // Fills the area completely but may crop the image
        fillMode: Image.PreserveAspectCrop
    }
}

// actually this file is a qml document
