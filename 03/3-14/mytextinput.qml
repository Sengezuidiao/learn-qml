import QtQuick

Rectangle {
    width: 200
    height: 200
    TextInput {
        id: textinput
        focus: true

        onTextEdited: {
            console.log(text);
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: textinput.clear();
    }
}
