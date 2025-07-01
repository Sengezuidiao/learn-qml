import QtQuick

Item {
    // On macOS, setting a parent's opacity will affect the children's opacity
    // On macOS, a parent's opacity multiplies with its children's opacity values
    Rectangle {
        color: "lightgray"
        width: 100
        height: 100
        opacity: 1
        Rectangle {
            color: "black"
            x: 50
            y: 50
            width: 100
            height: 100
            // This child's opacity will be combined with the parent's opacity (0.5 * 0.8 = 0.4)
            opacity: 0.8  //  This will be override by parent's opacity
        }
    }
}
