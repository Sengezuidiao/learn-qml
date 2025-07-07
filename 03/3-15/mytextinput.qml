import QtQuick

Rectangle {
    width: 200
    height: 200
    TextInput {
        id: textinput
        text: "hello QT"
        selectByMouse: true
        selectedTextColor: "red"
        selectionColor: "green"
        focus: true
        onAccepted: {
            console.log(selectedText.toString());
            console.log(selectionStart);
            console.log(selectionEnd);
        }
    }
}
