import QtQuick

Column {
    height: 100
    width: 100
    Text {
        width: 20
        anchors.centerIn: parent
        clip: true  // Clips the text if it exceeds the item's width
        text: "redtext"
        wrapMode: Text.Wrap // exceeds the length will be wrapped
        font.pointSize: 20
        color: "red"
    }
}
