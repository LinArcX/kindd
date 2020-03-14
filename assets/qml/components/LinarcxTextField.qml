import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.impl 2.3
import QtQuick.Controls.Private 1.0
import QtQuick.Templates 2.3 as T

T.TextField {
    id: control
    color: control.palette.text

    selectByMouse: true
    selectionColor: control.palette.highlight
    selectedTextColor: control.palette.highlightedText

    topPadding: 0
    bottomPadding: 0
    leftPadding: 5
    rightPadding: imgClear.width + 10
    verticalAlignment: TextInput.AlignVCenter

    implicitWidth: Math.max(
                       background ? background.implicitWidth : 0,
                                    placeholderText ? placeholder.implicitWidth
                                                      + leftPadding + rightPadding : 0)
                   || contentWidth + leftPadding + rightPadding

    implicitHeight: Math.max(
                        contentHeight + topPadding + bottomPadding,
                        background ? background.implicitHeight : 0,
                                     placeholder.implicitHeight + topPadding + bottomPadding)

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.IBeamCursor
        acceptedButtons: Qt.RightButton
        onClicked: ctxTextField.popup()

        Menu {
            id: ctxTextField
            Action {
                text: "Clear"
                onTriggered: control.clear()
            }
        }
    }

    onTextChanged: {
        if (control.text.length) {
            imgClear.state = "IN"
        } else {
            imgClear.state = "OUT"
        }
    }

    Image {
        id: imgClear
        opacity: 0
        x: mRect.width - 2 * imgClear.width
        height: imgClear.width
        width: control.height / 3 * 2
        anchors.verticalCenter: control.verticalCenter

        states: [
            State {
                name: "IN"
                PropertyChanges {
                    target: imgClear
                    x: mRect.width - (imgClear.width + 5)
                }
                PropertyChanges {
                    target: imgClear
                    opacity: 1
                }
            },
            State {
                name: "OUT"
                PropertyChanges {
                    target: imgClear
                    x: mRect.width - 2 * imgClear.width
                }
                PropertyChanges {
                    target: imgClear
                    opacity: 0
                }
            }
        ]

        transitions: Transition {
            PropertyAnimation {
                property: "x"
                duration: 500
                easing.type: Easing.InCurve
            }
            PropertyAnimation {
                property: "opacity"
                duration: 500
                easing.type: Easing.InCurve
            }
        }

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onClicked: control.clear()
        }

        source: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgNTEyIDUxMiIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNTEyIDUxMjsiIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPGxpbmVhckdyYWRpZW50IGlkPSJTVkdJRF8xXyIgZ3JhZGllbnRVbml0cz0idXNlclNwYWNlT25Vc2UiIHgxPSIwIiB5MT0iMjU4IiB4Mj0iNTEyIiB5Mj0iMjU4IiBncmFkaWVudFRyYW5zZm9ybT0ibWF0cml4KDEgMCAwIC0xIDAgNTE0KSI+DQoJPHN0b3AgIG9mZnNldD0iMCIgc3R5bGU9InN0b3AtY29sb3I6IzgwRDhGRiIvPg0KCTxzdG9wICBvZmZzZXQ9IjAuMTYiIHN0eWxlPSJzdG9wLWNvbG9yOiM4OEQxRkYiLz4NCgk8c3RvcCAgb2Zmc2V0PSIwLjQxMyIgc3R5bGU9InN0b3AtY29sb3I6IzlGQkVGRSIvPg0KCTxzdG9wICBvZmZzZXQ9IjAuNzI1IiBzdHlsZT0ic3RvcC1jb2xvcjojQzRBMEZEIi8+DQoJPHN0b3AgIG9mZnNldD0iMSIgc3R5bGU9InN0b3AtY29sb3I6I0VBODBGQyIvPg0KPC9saW5lYXJHcmFkaWVudD4NCjxwYXRoIHN0eWxlPSJmaWxsOnVybCgjU1ZHSURfMV8pOyIgZD0iTTI1NiwwQzExNC41MDgsMCwwLDExNC40OTcsMCwyNTZjMCwxNDEuNDkzLDExNC40OTcsMjU2LDI1NiwyNTYNCgljMTQxLjQ5MiwwLDI1Ni0xMTQuNDk3LDI1Ni0yNTZDNTEyLDExNC41MDcsMzk3LjUwMywwLDI1NiwweiBNMjU2LDQ3MmMtMTE5LjM4NCwwLTIxNi05Ni42MDctMjE2LTIxNmMwLTExOS4zODUsOTYuNjA3LTIxNiwyMTYtMjE2DQoJYzExOS4zODQsMCwyMTYsOTYuNjA3LDIxNiwyMTZDNDcyLDM3NS4zODUsMzc1LjM5Myw0NzIsMjU2LDQ3MnogTTM0My41ODYsMTk2LjY5OEwyODQuMjg0LDI1Nmw1OS4zMDIsNTkuMzAyDQoJYzcuODExLDcuODExLDcuODEyLDIwLjQ3NCwwLjAwMSwyOC4yODRjLTcuODExLDcuODExLTIwLjQ3Niw3LjgxLTI4LjI4NCwwTDI1NiwyODQuMjg0bC01OS4zMDMsNTkuMzAyDQoJYy03LjgwOCw3LjgwOS0yMC40NzEsNy44MTItMjguMjg0LDBjLTcuODExLTcuODExLTcuODEtMjAuNDc0LDAuMDAxLTI4LjI4NEwyMjcuNzE2LDI1NmwtNTkuMzAyLTU5LjMwMg0KCWMtNy44MTEtNy44MTEtNy44MTItMjAuNDc0LTAuMDAxLTI4LjI4NHMyMC40NzYtNy44MTEsMjguMjg0LDBMMjU2LDIyNy43MTZsNTkuMzAzLTU5LjMwMmM3LjgxLTcuODEsMjAuNDczLTcuODExLDI4LjI4NCwwDQoJQzM1MS4zOTcsMTc2LjIyNSwzNTEuMzk2LDE4OC44ODgsMzQzLjU4NiwxOTYuNjk4eiIvPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPC9zdmc+DQo="
    }

    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        opacity: 0.5
        font: control.font
        elide: Text.ElideRight
        color: control.palette.text
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)
        text: control.placeholderText
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText
                 && (!control.activeFocus
                     || control.horizontalAlignment !== Qt.AlignHCenter)
    }

    background: Rectangle {
        id: mRect
        implicitWidth: 200
        implicitHeight: 40
        border.width: control.activeFocus ? 2 : 1
        color: control.palette.base
        border.color: control.activeFocus ? control.palette.highlight : control.palette.mid
    }
}
