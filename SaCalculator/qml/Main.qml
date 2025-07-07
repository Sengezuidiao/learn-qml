import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

ApplicationWindow {
    visible: true
    width: 500
    height: 600
    title: "Seed-Key Calculator"

    ColumnLayout {
        width: parent.width
        anchors.centerIn: parent
        spacing: 10

        // Input: SEED
        TextField {
            id: seedInput
            placeholderText: "Seed (8 hex digits, e.g. 1A2B3C4D)"
            Layout.fillWidth: true
        }

        // Input: VIN
        TextField {
            id: vinInput
            placeholderText: "VIN (17 characters)"
            Layout.fillWidth: true
            maximumLength: 17
        }

        // Input: MASK
        TextField {
            id: maskInput
            placeholderText: "Mask (8 hex digits)"
            Layout.fillWidth: true
        }

        // Input: VSN
        TextField {
            id: vsnInput
            placeholderText: "VSN (20 characters)"
            Layout.fillWidth: true
            maximumLength: 20
        }

        // Input: ECU name
        TextField {
            id: ecuInput
            placeholderText: "ECU name (e.g. TBOX)"
            Layout.fillWidth: true
        }

        // Input: Security Level
        SpinBox {
            id: levelSpin
            from: 0
            to: 255
            value: 1
            Layout.fillWidth: true
        }

        // Result: KEY
        TextField {
            id: keyOutput
            placeholderText: "Key (computed)"
            readOnly: true
            Layout.fillWidth: true
        }
        Text {
            id: keytext
            font.pointSize: 30
            text: "hello"
            Layout.fillWidth: parent
        }

        Button {
            text: "Calculate Key"
            Layout.fillWidth: true
            onClicked: {
                var seedHex = seedInput.text.trim()
                var maskHex = maskInput.text.trim()

                // if (seedHex.length !== 8 || maskHex.length !== 8
                //         || vinInput.text.length !== 17
                //         || vsnInput.text.length !== 20) {
                //     keyOutput.text = "Invalid input format"
                //     return
                // }

                // Call C++ function via signal or context property (set in main.cpp)
                calcBridge.calculateKey(ecuInput.text,
                                        parseInt(levelSpin.value), seedHex,
                                        vinInput.text, vsnInput.text, maskHex)
            }
        }
        Connections {
            target: calcBridge
            function onKeyReady(key) {
                keytext.text = "hello"
            }
        }
    }
}
