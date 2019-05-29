import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0

//import "qrc:/components/qml/"
//import "qrc:/strings/CoreStrings.js" as CStr
//import "qrc:/strings/DashBoardStrings.js" as Str

Popup {
    id: mPopUp
    property variant mImage
    property variant mTitle
    property variant mBody
    property int titleSize

    modal: true
    focus: true
    x: (qWindow.width - width) / 2
    y: qWindow.height / 15
    width: Math.min(qWindow.width, qWindow.height) / 3 * 2
    height: qWindow.height / 4 * 3
    parent: Overlay.overlay

    enter: Transition {
        NumberAnimation {
            property: "y"
            from: y
            to: y + 20
            duration: 250
        }
    }
    exit: Transition {
        NumberAnimation {
            property: "y"
            from: y
            to: y - 20
            duration: 30
            easing.type: "InCirc"
        }
    }

    Image {
        id: imgClose
        x: -20
        y: -20
        sourceSize.width: 25
        sourceSize.height: 25
        z: 1

        states: [
            State {
                name: "scale"
                PropertyChanges {
                    target: imgClose
                    scale: 1.3
                }
            },
            State {
                name: "normal"
                PropertyChanges {
                    target: imgClose
                    scale: 1
                }
            }
        ]

        transitions: Transition {
            ScaleAnimator {
                duration: 100
            }
        }

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onClicked: mPopUp.close()
            onEntered: imgClose.state = "scale"
            onExited: imgClose.state = "normal"
        }

        source: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJMYXllcl8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCINCgkgdmlld0JveD0iMCAwIDUxMiA1MTIiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDUxMiA1MTI7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxjaXJjbGUgc3R5bGU9ImZpbGw6I0ZGNzU3QzsiIGN4PSIyNTYiIGN5PSIyNTYiIHI9IjI0NS44MDEiLz4NCjxwb2x5Z29uIHN0eWxlPSJmaWxsOiNGMkYyRjI7IiBwb2ludHM9IjM5NS41NjEsMTY0LjAzOCAzNDcuOTYxLDExNi40NCAyNTYsMjA4LjQwMSAxNjQuMDM5LDExNi40NCAxMTYuNDM5LDE2NC4wMzggMjA4LjQwMSwyNTYgDQoJMTE2LjQzOSwzNDcuOTYyIDE2NC4wMzksMzk1LjU2IDI1NiwzMDMuNTk5IDM0Ny45NjEsMzk1LjU2IDM5NS41NjEsMzQ3Ljk2MiAzMDMuNTk5LDI1NiAiLz4NCjxnPg0KCTxwYXRoIHN0eWxlPSJmaWxsOiM0RDRENEQ7IiBkPSJNMjU2LDUxMmMtNjguMzgsMC0xMzIuNjY3LTI2LjYyOC0xODEuMDItNzQuOThTMCwzMjQuMzgsMCwyNTZTMjYuNjI4LDEyMy4zMzMsNzQuOTgsNzQuOTgNCgkJUzE4Ny42MiwwLDI1NiwwczEzMi42NjcsMjYuNjI4LDE4MS4wMiw3NC45OFM1MTIsMTg3LjYyLDUxMiwyNTZzLTI2LjYyOCwxMzIuNjY3LTc0Ljk4LDE4MS4wMlMzMjQuMzgsNTEyLDI1Niw1MTJ6IE0yNTYsMjAuMzk4DQoJCUMxMjYuMDg5LDIwLjM5OCwyMC4zOTgsMTI2LjA4OSwyMC4zOTgsMjU2UzEyNi4wODksNDkxLjYwMiwyNTYsNDkxLjYwMlM0OTEuNjAyLDM4NS45MTEsNDkxLjYwMiwyNTZTMzg1LjkxMSwyMC4zOTgsMjU2LDIwLjM5OHoiDQoJCS8+DQoJPHBhdGggc3R5bGU9ImZpbGw6IzRENEQ0RDsiIGQ9Ik0zNDcuOTYyLDQwNS43NTljLTIuNjEsMC01LjIyMS0wLjk5Ni03LjIxMi0yLjk4N0wyNTYsMzE4LjAyMmwtODQuNzQ5LDg0Ljc1DQoJCWMtMy45ODMsMy45ODItMTAuNDQxLDMuOTgyLTE0LjQyNSwwbC00Ny41OTktNDcuNTk5Yy0zLjk4My0zLjk4My0zLjk4My0xMC40NDEsMC0xNC40MjVMMTkzLjk3OCwyNTZsLTg0Ljc1LTg0Ljc0OQ0KCQljLTMuOTgzLTMuOTgzLTMuOTgzLTEwLjQ0MSwwLTE0LjQyNWw0Ny41OTktNDcuNTk5YzMuOTgzLTMuOTgyLDEwLjQ0MS0zLjk4MiwxNC40MjUsMEwyNTYsMTkzLjk3OGw4NC43NDktODQuNzUNCgkJYzMuOTgzLTMuOTgyLDEwLjQ0MS0zLjk4MiwxNC40MjUsMGw0Ny41OTksNDcuNTk5YzMuOTgzLDMuOTgzLDMuOTgzLDEwLjQ0MSwwLDE0LjQyNUwzMTguMDIyLDI1Nmw4NC43NSw4NC43NDkNCgkJYzMuOTgzLDMuOTgzLDMuOTgzLDEwLjQ0MSwwLDE0LjQyNWwtNDcuNTk5LDQ3LjU5OUMzNTMuMTgyLDQwNC43NjQsMzUwLjU3Miw0MDUuNzU5LDM0Ny45NjIsNDA1Ljc1OXogTTI1NiwyOTMuMzk5DQoJCWMyLjYxLDAsNS4yMjEsMC45OTYsNy4yMTIsMi45ODdsODQuNzQ5LDg0Ljc1bDMzLjE3NS0zMy4xNzVsLTg0Ljc1LTg0Ljc0OWMtMy45ODMtMy45ODMtMy45ODMtMTAuNDQxLDAtMTQuNDI1bDg0Ljc1LTg0Ljc0OQ0KCQlsLTMzLjE3NS0zMy4xNzVsLTg0Ljc0OSw4NC43NWMtMy45ODMsMy45ODItMTAuNDQxLDMuOTgyLTE0LjQyNSwwbC04NC43NDktODQuNzVsLTMzLjE3NSwzMy4xNzVsODQuNzUsODQuNzQ5DQoJCWMzLjk4MywzLjk4MywzLjk4MywxMC40NDEsMCwxNC40MjVsLTg0Ljc1LDg0Ljc0OWwzMy4xNzUsMzMuMTc1bDg0Ljc0OS04NC43NUMyNTAuNzc5LDI5NC4zOTYsMjUzLjM5LDI5My4zOTksMjU2LDI5My4zOTl6Ii8+DQoJPHBhdGggc3R5bGU9ImZpbGw6IzRENEQ0RDsiIGQ9Ik00NTQuMzY5LDMzOC42MTZjLTEuMTYsMC0yLjMzOC0wLjE5OS0zLjQ5LTAuNjE5Yy01LjI5Mi0xLjkyOS04LjAyLTcuNzgyLTYuMDkyLTEzLjA3NA0KCQljOS43NDYtMjYuNzUzLDEzLjczNi01NS45NTcsMTEuNTM5LTg0LjQ1OGMtMC40MzMtNS42MTYsMy43NjktMTAuNTE5LDkuMzg1LTEwLjk1M2M1LjYyMi0wLjQ0OSwxMC41MTksMy43NjksMTAuOTUzLDkuMzg1DQoJCWMyLjQxOSwzMS4zODEtMS45NzcsNjMuNTQyLTEyLjcxMSw5My4wMDhDNDYyLjQ0NSwzMzYuMDQ0LDQ1OC41MzQsMzM4LjYxNiw0NTQuMzY5LDMzOC42MTZ6Ii8+DQoJPHBhdGggc3R5bGU9ImZpbGw6IzRENEQ0RDsiIGQ9Ik00NTkuNTY3LDIxMC4xMDZjLTQuNDc5LDAtOC41ODYtMi45NzMtOS44MjktNy41MDJjLTAuODAyLTIuOTE3LTEuNjgtNS44NTYtMi42MTMtOC43MzUNCgkJYy0xLjczNy01LjM1OCwxLjE5OS0xMS4xMSw2LjU1OC0xMi44NDdjNS4zNTYtMS43MzgsMTEuMTEsMS4xOTgsMTIuODQ3LDYuNTU4YzEuMDI4LDMuMTcxLDEuOTk3LDYuNDA4LDIuODc5LDkuNjIzDQoJCWMxLjQ5MSw1LjQzMi0xLjcwMiwxMS4wNDQtNy4xMzUsMTIuNTM2QzQ2MS4zNjksMjA5Ljk4Nyw0NjAuNDYsMjEwLjEwNiw0NTkuNTY3LDIxMC4xMDZ6Ii8+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8L3N2Zz4NCg=="
    }

    Rectangle {
        anchors.fill: parent

        Image {
            id: imgPopUp
            source: mImage
            sourceSize.width: 40
            sourceSize.height: 40
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 20
            antialiasing: true
        }

        Text {
            id: txtTitlePopUp
            text: mTitle
            font.pixelSize: titleSize ? titleSize : 15
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 20
            anchors.verticalCenter: imgPopUp.Center
        }

        Rectangle {
            id: spacer
            height: 3
            color: "#999"
            width: parent.width - 20
            anchors.top: imgPopUp.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: txtBodyPopUp
            text: mBody ? mBody : ""
            font.pixelSize: 14
            width: mPopUp.width - 60
            wrapMode: TextArea.Wrap
            anchors.top: spacer.bottom
            anchors.left: parent.left
            anchors.margins: 10
        }
    }
}
