import QtQuick

Item {
    Rectangle {
        color: "red"
        width: 100
        height: 100
        z: 1
    }
    Rectangle {
        color: "blue"
        width: 100
        height: 100
        // z: 2
        z: 1
        focus: true
        MouseArea {
            onClicked: {
                console.log(childAt(0, 0));
            }
        }
        Rectangle {
            color: "yellow"
            width: 100
            height: 100
            // z: 2
            z: -1 // A child with a negative z value is drawn behind its parent
        }
    }
    // If the z values are equal, the later item in the code will be on top
    // The item with the highest z value will be on top
    // Items with higher z-values are rendered above those with lower z-values
    // When z-values are equal, the later-declared item is on top
}
