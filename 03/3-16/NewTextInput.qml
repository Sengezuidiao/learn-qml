import QtQuick

Rectangle {
    property alias text: input.text

    width: input.contentWidth < 100 ? 100 : input.contentWidth + 10
    height: input.contentHeight + 10
    color: '#70C680'
    border.color: '#EB502B'
    TextInput {
        id: input
        anchors.fill: parent
        anchors.margins: 5
        focus: true
    }
}
