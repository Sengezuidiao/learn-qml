import QtQuick

Item {
    width: 240
    height: 50
    Column {
        Row {
            Text {
                text: "VIN:"
            }

            TextInput {
                id: input
                width: 240
                font.underline: true
                validator: RegularExpressionValidator {
                    regularExpression: /^[A-HJ-NPR-Z0-9]{0,17}$/
                }
                echoMode: TextInput.Password
                MouseArea {
                    onPressed: focus = true
                }
                onEditingFinished: {
                    console.log(input.text);
                    output.text = input.text;
                    input.focus = false;
                }
            }
        }
        Text {
            id: output
        }
    }
}
