import QtQuick

Item {
    width: 400
    height: 300
    Flickable {
        id: flick
        anchors.fill: parent
        contentWidth: edit.paintedWidth
        contentHeight: edit.paintedHeight
        clip: true
        function ensureVisible(r) {
            if (contentX >= r.x) {
                contentX = r.x;
            } else if (contentX + width <= r.x + r.width) {
                contentX = r.x + r.width - width;
            }
        }
    }

    TextEdit {
        id: edit
        width: flick.width
        textFormat: Text.RichText
        text: "<b>Hello</b> <i>World! </i>"
        font.family: "Helvetica"  // font
        // DPI-aware: scales on high-resolution displays
        // font.pointSize: 100
        // Fixed size: stays exactly 20 pixels regardless of screen DPI
        font.pixelSize: 100
        color: "blue"
        focus: true     // Recieve keyboard input

    }
}
