import QtQuick

Column {
    spacing: 20
    Text {
        width: 200
        text: "Make the text not omit any exceeds parts in a single line"
        font.pointSize: 20
        color: "red"
    }
    Text {
        width: 200
        text: "Make the text exceeds parts in a single line elide on left"
        font.pointSize: 20
        elide: Text.ElideLeft
        color: "red"
    }
    Text {
        width: 200
        text: "Make the text exceeds parts in a single line elide on right"

        font.pointSize: 20
        elide: Text.ElideRight
        color: "red"
    }
    Text {
        width: 200
        text: "Make the text exceeds parts in a single line elide on middle"
        font.pointSize: 20
        elide: Text.ElideMiddle
        font.capitalization: Font.AllUppercase
        font.underline: true
        color: "red"
    }
    Text {
        width: 200
        text: "Make the text not omit any exceeds parts in a single line"
        font.pointSize: 20
        elide: Text.ElideNone
        color: "red"
    }
}
