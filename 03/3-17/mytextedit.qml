import QtQuick

TextEdit {
    width: 240
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
