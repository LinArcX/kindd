import QtQuick 2.0
import QtQuick.Controls 1.4 as OldControls
import QtQuick.Controls 2.2
import Qt.labs.folderlistmodel 2.11
import QtQuick.Window 2.0

Dialog {
    id: picker
    property var nameFilters
    property bool isHidden: false
    property bool showHidden: false
    property bool showDirsFirst: true
    property bool showDotAndDotDot: false
    property string mFolder: "file:///sdcard/"

    readonly property real textmargin: dp(Screen.pixelDensity, 8)
    readonly property real textSize: dp(Screen.pixelDensity, 10)
    readonly property real headerTextSize: dp(Screen.pixelDensity, 12)
    readonly property real buttonHeight: dp(Screen.pixelDensity, 24)
    readonly property real rowHeight: dp(Screen.pixelDensity, 36)
    readonly property real toolbarHeight: dp(Screen.pixelDensity, 48)

    signal fileSelected(string fileName)
    signal pickSelected(string folderName)

    onShowHiddenChanged: {
        if (true)
            folderListModel.showHidden = true
        else
            folderListModel.showHidden = false
    }

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    modal: true
    focus: true

    width: parent.width / 7 * 6
    height: parent.height / 7 * 6

    header: Rectangle {
        width: parent.width
        height: 1
    }
    footer: Rectangle {
        width: parent.width
        height: 1
    }

    Keys.onBackPressed: {
        if (canMoveUp) {
            folderListModel.folder = folderListModel.parentFolder
        }
    }

    function dp(pixelDensity, x) {
        return (pixelDensity * 25.4 < 120) ? x : x * (pixelDensity * 25.4 / 160)
    }

    function baseColor() {
        return "#f26e35"
    }

    function primaryColor() {
        return "#d04828"
    }

    function textColor() {
        return "#434f4d"
    }

    function textAltColor() {
        return "#a6aaa2"
    }

    function backgroundColor() {
        return "#e7e8e9"
    }

    function backgroundAltColor() {
        return "#ffefde"
    }

    function currentFolder() {
        return folderListModel.folder
    }

    function isFolder(fileName) {
        return folderListModel.isFolder(
                    folderListModel.indexOf(
                        folderListModel.folder + "/" + fileName))
    }
    function canMoveUp() {
        return folderListModel.folder.toString() !== "file:///"
    }

    function onItemClick(fileName) {
        if (!isFolder(fileName)) {
            fileSelected(fileName)
            return
        }
        if (fileName === ".." && canMoveUp()) {
            folderListModel.folder = folderListModel.parentFolder
        } else if (fileName !== ".") {
            if (folderListModel.folder.toString() === "file:///") {
                folderListModel.folder += fileName
            } else {
                folderListModel.folder += "/" + fileName
            }
        }
    }

    Rectangle {
        id: toolbar
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        height: toolbarHeight
        color: backgroundColor()

        LinarcxImageToolTiper {
            id: btnClose
            qImg: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgNDU1LjExMSA0NTUuMTExIiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA0NTUuMTExIDQ1NS4xMTE7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxjaXJjbGUgc3R5bGU9ImZpbGw6I0UyNEM0QjsiIGN4PSIyMjcuNTU2IiBjeT0iMjI3LjU1NiIgcj0iMjI3LjU1NiIvPg0KPHBhdGggc3R5bGU9ImZpbGw6I0QxNDAzRjsiIGQ9Ik00NTUuMTExLDIyNy41NTZjMCwxMjUuMTU2LTEwMi40LDIyNy41NTYtMjI3LjU1NiwyMjcuNTU2Yy03Mi41MzMsMC0xMzYuNTMzLTMyLjcxMS0xNzcuNzc4LTg1LjMzMw0KCWMzOC40LDMxLjI4OSw4OC4xNzgsNDkuNzc4LDE0Mi4yMjIsNDkuNzc4YzEyNS4xNTYsMCwyMjcuNTU2LTEwMi40LDIyNy41NTYtMjI3LjU1NmMwLTU0LjA0NC0xOC40ODktMTAzLjgyMi00OS43NzgtMTQyLjIyMg0KCUM0MjIuNCw5MS4wMjIsNDU1LjExMSwxNTUuMDIyLDQ1NS4xMTEsMjI3LjU1NnoiLz4NCjxwYXRoIHN0eWxlPSJmaWxsOiNGRkZGRkY7IiBkPSJNMzMxLjM3OCwzMzEuMzc4Yy04LjUzMyw4LjUzMy0yMi43NTYsOC41MzMtMzEuMjg5LDBsLTcyLjUzMy03Mi41MzNsLTcyLjUzMyw3Mi41MzMNCgljLTguNTMzLDguNTMzLTIyLjc1Niw4LjUzMy0zMS4yODksMGMtOC41MzMtOC41MzMtOC41MzMtMjIuNzU2LDAtMzEuMjg5bDcyLjUzMy03Mi41MzNsLTcyLjUzMy03Mi41MzMNCgljLTguNTMzLTguNTMzLTguNTMzLTIyLjc1NiwwLTMxLjI4OWM4LjUzMy04LjUzMywyMi43NTYtOC41MzMsMzEuMjg5LDBsNzIuNTMzLDcyLjUzM2w3Mi41MzMtNzIuNTMzDQoJYzguNTMzLTguNTMzLDIyLjc1Ni04LjUzMywzMS4yODksMGM4LjUzMyw4LjUzMyw4LjUzMywyMi43NTYsMCwzMS4yODlsLTcyLjUzMyw3Mi41MzNsNzIuNTMzLDcyLjUzMw0KCUMzMzkuOTExLDMwOC42MjIsMzM5LjkxMSwzMjIuODQ0LDMzMS4zNzgsMzMxLjM3OHoiLz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjwvc3ZnPg0K"
            qTitle: "Close"
            sourceSize.width: 30
            sourceSize.height: 30
            anchors.right: parent.right
            anchors.rightMargin: buttonHeight
            anchors.verticalCenter: parent.verticalCenter
            enabled: true
            onImageClicked: {
                //                    picker.destroy()
                picker.close()
            }
        }

        LinarcxImageToolTiper {
            id: buttonPick
            qImg: "data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjQyNXB0IiB2aWV3Qm94PSIwIC0xMCA0MjUuNDk5NTEgNDI1IiB3aWR0aD0iNDI1cHQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHBhdGggZD0ibTQxOC41IDM2Mi4yNTc4MTItMzYuNDI5Njg4IDM2LjQzMzU5NC0yOS4xNDA2MjQtMjkuMTUyMzQ0LTYwLjAzMTI1LTYwLjAzMTI1LTIwLjI1IDM0LjM5MDYyNi0xMC43ODkwNjMtNTEuNDQ5MjE5LTEzLjM1OTM3NS02My43Njk1MzEgNjMuNzY5NTMxIDEzLjM3MTA5MyA1MS40NDkyMTkgMTAuNzc3MzQ0LTM0LjM5MDYyNSAyMC4yNSA1Ny41ODIwMzEgNTcuNTg5ODQ0em0wIDAiIGZpbGw9IiM2ZmUzZmYiLz48cGF0aCBkPSJtMzg3IDE0OS42OTkyMTl2MTc4LjIxODc1YzAgLjkyMTg3NS0uMDMxMjUgMS44Mzk4NDMtLjA4OTg0NCAyLjc1bC01Ny41ODIwMzEtNTcuNTg5ODQ0IDM0LjM5MDYyNS0yMC4yNS01MS40NDkyMTktMTAuNzc3MzQ0LTYzLjc2OTUzMS0xMy4zNzEwOTMgMTMuMzU5Mzc1IDYzLjc2OTUzMSAxMC43ODkwNjMgNTEuNDQ5MjE5IDIwLjI1LTM0LjM5MDYyNiA2MC4wMzEyNSA2MC4wMzEyNWMtMi43NjE3MTkuNTU4NTk0LTUuNTc0MjE5LjgzNTkzOC04LjM5MDYyNi44MzIwMzJoLTI5MC42MDkzNzRjMjMuNDQ5MjE4LjAwMzkwNiA0Mi40NjA5MzctMTkuMDAzOTA2IDQyLjQ2MDkzNy00Mi40NTMxMjV2LTE3OC4yMTg3NWMtLjAwMzkwNi0yMy40NDUzMTMgMTkuMDAzOTA2LTQyLjQ1MzEyNSA0Mi40NDkyMTktNDIuNDQ5MjE5aDIwNS42OTkyMThjMjMuNDQ5MjE5LS4wMDM5MDYgNDIuNDYwOTM4IDE5IDQyLjQ2MDkzOCA0Mi40NDkyMTl6bTAgMCIgZmlsbD0iI2U0OGU2NiIvPjxwYXRoIGQ9Im0zMzQuOTI5Njg4IDk4LjYwMTU2MnY4LjY0ODQzOGgtMTk2LjA4OTg0NGMtMjMuNDQ1MzEzLS4wMDM5MDYtNDIuNDUzMTI1IDE5LjAwMzkwNi00Mi40NDkyMTkgNDIuNDQ5MjE5djE3OC4yMTg3NWMwIDIzLjQ0OTIxOS0xOS4wMTE3MTkgNDIuNDU3MDMxLTQyLjQ2MDkzNyA0Mi40NTMxMjVoLTQuNDY4NzVjLTIzLjQ0OTIxOS4wMDM5MDYtNDIuNDYwOTM4LTE5LjAwMzkwNi00Mi40NjA5MzgtNDIuNDUzMTI1di0yNzguMjE4NzVjMC0yMy40NDkyMTkgMTkuMDExNzE5LTQyLjQ1MzEyNSA0Mi40NjA5MzgtNDIuNDQ5MjE5aDk1LjI1YzExLjkyMTg3NCAwIDIzLjI5Mjk2OCA1LjAxMTcxOSAzMS4zMzk4NDMgMTMuODA4NTk0bDI4LjkxMDE1NyAzMS42MzI4MTJjMi4wMTE3MTggMi4xOTkyMTkgNC44NTU0NjggMy40NTcwMzIgNy44Mzk4NDMgMy40NTcwMzJoNzkuNjY3OTY5YzIzLjQ0OTIxOS0uMDAzOTA3IDQyLjQ2MDkzOCAxOS4wMDM5MDYgNDIuNDYwOTM4IDQyLjQ1MzEyNHptMCAwIiBmaWxsPSIjZjhlYzdkIi8+PHBhdGggZD0ibTI5Mi40Njg3NSA0OS4xNDg0MzhoLTc5LjY2Nzk2OWMtMS4wMTk1MzEgMC0xLjk4ODI4MS0uNDI5Njg4LTIuNjcxODc1LTEuMTc5Njg4bC0yOC45MTAxNTYtMzEuNjMyODEyYy05LjM3ODkwNi0xMC4yMzgyODItMjIuNjI1LTE2LjA3NDIxOS0zNi41MDc4MTItMTYuMDg1OTM4aC05NS4yNWMtMjcuMzAwNzgyLjAyNzM0NC00OS40MjU3ODE4IDIyLjE0ODQzOC00OS40NjA5MzggNDkuNDQ5MjE5djI3OC4yMTg3NWMuMDM1MTU2MiAyNy4zMDA3ODEgMjIuMTYwMTU2IDQ5LjQyMTg3NSA0OS40NjA5MzggNDkuNDUzMTI1aDI5NS4wNzgxMjRjMS45ODgyODItLjAwMzkwNiAzLjk3MjY1Ny0uMTI4OTA2IDUuOTQ1MzEzLS4zNzEwOTRsMjYuNjMyODEzIDI2LjY0MDYyNWMxLjMxNjQwNiAxLjMxMjUgMy4wOTM3NSAyLjA1MDc4MSA0Ljk1MzEyNCAyLjA1MDc4MSAxLjg1NTQ2OSAwIDMuNjM2NzE5LS43MzgyODEgNC45NDkyMTktMi4wNTA3ODFsMzYuNDI5Njg4LTM2LjQyOTY4N2MyLjczNDM3NS0yLjczNDM3NiAyLjczNDM3NS03LjE2Nzk2OSAwLTkuOTAyMzQ0bC0yOS40NDkyMTktMjkuNDUzMTI1di0xNzguMTU2MjVjLS4wMzUxNTYtMjcuMzAwNzgxLTIyLjE2MDE1Ni00OS40MjE4NzUtNDkuNDYwOTM4LTQ5LjQ0OTIxOWgtMi42MDkzNzR2LTEuNjQ4NDM4Yy0uMDM1MTU3LTI3LjMwMDc4MS0yMi4xNjAxNTctNDkuNDIxODc0LTQ5LjQ2MDkzOC00OS40NTMxMjR6bS0yNDMuMDA3ODEyIDMxNC4yMjI2NTZjLTE5LjU3MDMxMy0uMDIzNDM4LTM1LjQzMzU5NC0xNS44Nzg5MDYtMzUuNDYwOTM4LTM1LjQ1MzEyNXYtMjc4LjIxODc1Yy4wMjczNDQtMTkuNTcwMzEzIDE1Ljg5MDYyNS0zNS40MjU3ODEgMzUuNDYwOTM4LTM1LjQ0OTIxOWg5NS4yNWM5Ljk1MzEyNC4wMDc4MTIgMTkuNDQ5MjE4IDQuMTkxNDA2IDI2LjE3MTg3NCAxMS41MzEyNWwyOC45MTAxNTcgMzEuNjI4OTA2YzMuMzM5ODQzIDMuNjUyMzQ0IDguMDU4NTkzIDUuNzM0Mzc1IDEzLjAwNzgxMiA1LjczODI4Mmg3OS42Njc5NjljMTkuNTcwMzEyLjAyMzQzNyAzNS40MzM1OTQgMTUuODc4OTA2IDM1LjQ2MDkzOCAzNS40NTMxMjR2MS42NDg0MzhoLTE4OS4wODk4NDRjLTI3LjI5Njg3NS4wMzEyNS00OS40MTc5NjkgMjIuMTUyMzQ0LTQ5LjQ0OTIxOSA0OS40NDkyMTl2MTc4LjIxODc1Yy0uMDI3MzQ0IDE5LjU3NDIxOS0xNS44OTA2MjUgMzUuNDI5Njg3LTM1LjQ2MDkzNyAzNS40NTMxMjV6bTMzMi42MDkzNzQgMjUuNDE3OTY4LTg0LjIxODc1LTg0LjIzMDQ2OGMtMS4zMTI1LTEuMzEyNS0zLjA5Mzc1LTIuMDUwNzgyLTQuOTUzMTI0LTIuMDUwNzgyLS4yOTI5NjkuMDAzOTA3LS41ODk4NDQuMDE5NTMyLS44ODI4MTMuMDU4NTk0LTIuMTQ4NDM3LjI3MzQzOC00LjA0Njg3NSAxLjUyMzQzOC01LjE0ODQzNyAzLjM5MDYyNWwtMTEuMDc4MTI2IDE4LjgxMjUtMTguMjM4MjgxLTg3LjAzOTA2MiA4Ny4wMzUxNTcgMTguMjM4MjgxLTE4LjgwODU5NCAxMS4wNzQyMTljLTEuODY3MTg4IDEuMTAxNTYyLTMuMTE3MTg4IDMtMy4zOTQ1MzIgNS4xNDg0MzctLjI3MzQzNyAyLjE0ODQzOC40NjQ4NDQgNC4zMDQ2ODggMS45OTYwOTQgNS44MzU5MzhsNTcuNTc4MTI1IDU3LjU4OTg0NCAyNi42NDA2MjUgMjYuNjM2NzE4em0tMzcuNTMxMjUtMjc0LjUzOTA2MmMxOS41NzAzMTMuMDIzNDM4IDM1LjQzMzU5NCAxNS44Nzg5MDYgMzUuNDYwOTM4IDM1LjQ0OTIxOXYxNjQuMTU2MjVsLTM5LjMyODEyNS0zOS4zMzIwMzEgMjYuNjAxNTYzLTE1LjY2MDE1N2MyLjQ5MjE4Ny0xLjQ2ODc1IDMuODI0MjE4LTQuMzE2NDA2IDMuMzU1NDY4LTcuMTY3OTY5LS40Njg3NS0yLjg1MTU2Mi0yLjY0MDYyNS01LjEyNS01LjQ3MjY1Ni01LjcxNDg0M2wtMTE1LjIxODc1LTI0LjE1MjM0NGMtMi4zMTI1LS40ODQzNzUtNC43MTQ4NDQuMjMwNDY5LTYuMzg2NzE5IDEuOTAyMzQ0cy0yLjM4NjcxOSA0LjA3MDMxMi0xLjkwMjM0MyA2LjM4NjcxOWwyNC4xNTIzNDMgMTE1LjIxODc1Yy41OTM3NSAyLjgyODEyNCAyLjg2MzI4MSA1LjAwMzkwNiA1LjcxNDg0NCA1LjQ2ODc1IDIuODU1NDY5LjQ2ODc1IDUuNjk5MjE5LS44NjMyODIgNy4xNjc5NjktMy4zNTU0NjlsMTUuNjYwMTU2LTI2LjU5NzY1NyA0Mi41MTE3MTkgNDIuNTE5NTMyaC0yNDguNDkyMTg4YzkuNjA5Mzc1LTkuMjkyOTY5IDE1LjAzMTI1LTIyLjA4NTkzOCAxNS4wMjczNDQtMzUuNDUzMTI1di0xNzguMjE4NzVjLjAyMzQzNy0xOS41NzAzMTMgMTUuODc4OTA2LTM1LjQyNTc4MSAzNS40NDkyMTktMzUuNDQ5MjE5em0wIDAiIGZpbGw9IiM2MzMxNmQiLz48L3N2Zz4="
            qTitle: "Select"
            sourceSize.height: 30
            sourceSize.width: 30
            anchors.right: btnClose.left
            anchors.rightMargin: buttonHeight
            anchors.verticalCenter: parent.verticalCenter
            enabled: true
            onImageClicked: {
                console.log(folderListModel.folder.toString())
                pickSelected(folderListModel.folder.toString())
                picker.close()
            }
        }

        LinarcxImageToolTiper {
            id: btnUp
            qImg: "data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjQyNHB0IiB2aWV3Qm94PSIwIC0xNSA0MjQuMDU3NTMgNDI0IiB3aWR0aD0iNDI0cHQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHBhdGggZD0ibTIxNy42OTE0MDYgMzUxLjAzOTA2MmMyLjIxODc1LTIxLjkyOTY4NyAxMS4yNTc4MTMtNTMuMjMwNDY4IDQxLjcxODc1LTc4LjQ0OTIxOC44NTkzNzUtLjg1OTM3NSAyMi44MjgxMjUtMjEuMTAxNTYzIDcwLjY0MDYyNS0yMS4xMDE1NjNoMS4zMDA3ODF2LTUxLjI1NzgxMmwzNS4zMjAzMTMgMzUuMTM2NzE5IDUwLjM4NjcxOSA1MC4xNDA2MjQtODUuNzA3MDMyIDg2LjE1MjM0NHYtNTIuMTIxMDk0Yy0xMy4zNjMyODEtMi4xNDg0MzctNjYuNzczNDM3LTYuMDMxMjUtMTA2LjQwMjM0MyA1OS44NzEwOTRsLTUuMTYwMTU3IDguNjE3MTg4LTEuNzMwNDY4LTkuOTEwMTU2Yy0xLjI0NjA5NC04Ljk3NjU2My0xLjM3MTA5NC0xOC4wNzAzMTMtLjM2NzE4OC0yNy4wNzgxMjZ6bTAgMCIgZmlsbD0iIzZmZTNmZiIvPjxwYXRoIGQ9Im0zNjcgMTQxLjk4ODI4MXY5My4wNTA3ODFsLS4zMjgxMjUuMzI4MTI2LTM1LjMyMDMxMy0zNS4xMzY3MTl2NTEuMjU3ODEyaC0xLjMwMDc4MWMtNDcuODEyNSAwLTY5Ljc4MTI1IDIwLjI0MjE4OC03MC42NDA2MjUgMjEuMTAxNTYzLTMwLjQ2MDkzNyAyNS4yMTg3NS0zOS41IDU2LjUxOTUzMS00MS43MTg3NSA3OC40NDkyMThoLTE2Ni4yNDIxODdjMjIuMjE4NzUuMDAzOTA3IDQwLjIzMDQ2OS0xOC4wMDM5MDYgNDAuMjMwNDY5LTQwLjIxODc1di0xNjguODMyMDMxYzAtMjIuMjE0ODQzIDE4LjAwNzgxMi00MC4yMjI2NTYgNDAuMjE4NzUtNDAuMjE4NzVoMTk0Ljg3MTA5M2MyMi4yMTg3NS0uMDA3ODEyIDQwLjIzMDQ2OSAxOC4wMDM5MDcgNDAuMjMwNDY5IDQwLjIxODc1em0wIDAiIGZpbGw9IiNlNDhlNjYiLz48cGF0aCBkPSJtMzE3LjY3MTg3NSA5My41NzgxMjV2OC4xOTE0MDZoLTE4NS43NzM0MzdjLTIyLjIxMDkzOC0uMDAzOTA2LTQwLjIxODc1IDE4LjAwMzkwNy00MC4yMTg3NSA0MC4yMTg3NXYxNjguODMyMDMxYzAgMjIuMjE0ODQ0LTE4LjAxMTcxOSA0MC4yMjI2NTctNDAuMjMwNDY5IDQwLjIxODc1aC00LjIzMDQ2OWMtMjIuMjE0ODQ0LjAwMzkwNy00MC4yMjI2NTYtMTguMDAzOTA2LTQwLjIxODc1LTQwLjIxODc1di0yNjMuNTcwMzEyYzAtMjIuMjE0ODQ0IDE4LjAwNzgxMi00MC4yMjI2NTYgNDAuMjE4NzUtNDAuMjIyNjU2aDkwLjI0MjE4OGMxMS4yOTI5NjguMDAzOTA2IDIyLjA3MDMxMiA0Ljc1MzkwNiAyOS42ODc1IDEzLjA4OTg0NGwyNy4zOTA2MjQgMjkuOTYwOTM3YzEuOTAyMzQ0IDIuMDg1OTM3IDQuNTk3NjU3IDMuMjczNDM3IDcuNDIxODc2IDMuMjY5NTMxaDc1LjQ4ODI4MWMyMi4yMTQ4NDMuMDAzOTA2IDQwLjIyMjY1NiAxOC4wMTU2MjUgNDAuMjIyNjU2IDQwLjIzMDQ2OXptMCAwIiBmaWxsPSIjZjhlYzdkIi8+PHBhdGggZD0ibTM3NCAyMzIuNzg5MDYydi05MC44MDA3ODFjLS4wMzEyNS0yNi4wNzAzMTItMjEuMTYwMTU2LTQ3LjE5NTMxMi00Ny4yMzA0NjktNDcuMjE4NzVoLTIuMDk3NjU2di0xLjE5MTQwNmMtLjAyNzM0NC0yNi4wNzAzMTMtMjEuMTUyMzQ0LTQ3LjE5OTIxOS00Ny4yMjI2NTYtNDcuMjMwNDY5aC03NS40ODgyODFjLS44NTkzNzYgMC0xLjY3NTc4Mi0uMzU5Mzc1LTIuMjUzOTA3LS45OTIxODdsLTI3LjM5MDYyNS0yOS45NTcwMzFjLTguOTUzMTI1LTkuNzgxMjUtMjEuNTk3NjU2LTE1LjM1NTQ2OTItMzQuODU1NDY4LTE1LjM3MTA5NDJoLTkwLjI0MjE4OGMtMjYuMDY2NDA2LjAzMTI1LTQ3LjE4NzUgMjEuMTU2MjUwMi00Ny4yMTg3NSA0Ny4yMjI2NTYydjI2My41NzAzMTJjLjAzMTI1IDI2LjA2NjQwNyAyMS4xNTIzNDQgNDcuMTg3NSA0Ny4yMTg3NSA0Ny4yMTg3NWgxNjIuOTU3MDMxYy0uMzM1OTM3IDYuOTc2NTYzLS4wMjczNDMgMTMuOTcyNjU3LjkyOTY4OCAyMC44OTQ1MzJsLjAwNzgxMi4wNjI1Yy4wMTU2MjUuMTA5Mzc1LjAzMTI1LjIxODc1LjA1MDc4MS4zMjQyMThsMS43MzA0NjkgOS45MTQwNjNjLjUwMzkwNyAyLjg3ODkwNiAyLjc0NjA5NCA1LjE0MDYyNSA1LjYxNzE4OCA1LjY3NTc4MSAyLjg3NS41MzEyNSA1Ljc4MTI1LS43NzczNDQgNy4yODEyNS0zLjI4NTE1Nmw1LjE1MjM0My04LjYwOTM3NWMzMi44MDA3ODItNTQuNTM1MTU2IDc0LjY3NTc4Mi01OC41OTM3NSA5My40MDIzNDQtNTcuMjM4MjgxdjQ1Ljg4MjgxMmMwIDIuODMyMDMyIDEuNzA3MDMyIDUuMzg2NzE5IDQuMzI4MTI1IDYuNDY4NzUgMi42MjEwOTQgMS4wODIwMzIgNS42MzI4MTMuNDc2NTYzIDcuNjMyODEzLTEuNTMxMjVsODUuNzEwOTM3LTg2LjE1MjM0NGMyLjcyNjU2My0yLjczODI4MSAyLjcxNDg0NC03LjE3MTg3NC0uMDIzNDM3LTkuODk4NDM3em0tMzI2Ljc4MTI1IDExMS4yNWMtMTguMzM1OTM4LS4wMTk1MzEtMzMuMTk5MjE5LTE0Ljg4MjgxMi0zMy4yMTg3NS0zMy4yMTg3NXYtMjYzLjU3MDMxMmMuMDE5NTMxLTE4LjMzOTg0NCAxNC44ODI4MTItMzMuMTk5MjE5IDMzLjIxODc1LTMzLjIyMjY1Nmg5MC4yNDIxODhjOS4zMjgxMjQuMDExNzE4IDE4LjIyMjY1NiAzLjkzMzU5NCAyNC41MjM0MzcgMTAuODEyNWwyNy4zNzUgMjkuOTQ5MjE4YzMuMjMwNDY5IDMuNTM5MDYzIDcuODA0Njg3IDUuNTU4NTk0IDEyLjYwMTU2MyA1LjU1ODU5NGg3NS40ODgyODFjMTguMzM5ODQzLjAyMzQzOCAzMy4yMDMxMjUgMTQuODkwNjI1IDMzLjIyMjY1NiAzMy4yMzA0Njl2MS4xOTE0MDZoLTE3OC43NzM0MzdjLTI2LjA2NjQwNy4wMjczNDQtNDcuMTg3NSAyMS4xNTIzNDQtNDcuMjE4NzUgNDcuMjE4NzV2MTY4LjgzMjAzMWMtLjAyMzQzOCAxOC4zMzk4NDQtMTQuODkwNjI2IDMzLjE5OTIxOS0zMy4yMzA0NjkgMzMuMjE4NzV6bTE2NC4zMDA3ODEgMGgtMTI2LjU0Mjk2OWM4Ljc4MTI1LTguODI0MjE4IDEzLjcwNzAzMi0yMC43Njk1MzEgMTMuNzAzMTI2LTMzLjIxODc1di0xNjguODMyMDMxYy4wMTk1MzEtMTguMzM1OTM3IDE0Ljg3ODkwNi0zMy4xOTkyMTkgMzMuMjE4NzUtMzMuMjE4NzVoMTk0Ljg3MTA5M2MxOC4zMzk4NDQuMDE1NjI1IDMzLjIwNzAzMSAxNC44Nzg5MDcgMzMuMjMwNDY5IDMzLjIxODc1djc2Ljg3MTA5NGwtMjMuNzEwOTM4LTIzLjU5Mzc1Yy0yLjAwMzkwNi0xLjk5MjE4Ny01LjAxNTYyNC0yLjU4NTkzNy03LjYyNS0xLjUtMi42MTMyODEgMS4wODU5MzctNC4zMTI1IDMuNjM2NzE5LTQuMzEyNSA2LjQ2NDg0NHY0NC4zNTE1NjJjLTQ0LjQ3MjY1NiAxLjQ3NjU2My02Ni40NTMxMjQgMTkuOTI1NzgxLTY5LjUxNTYyNCAyMi43MDcwMzEtMjMuNTQyOTY5IDE5LjI1MzkwNy0zOSA0Ni42NDQ1MzItNDMuMzE2NDA3IDc2Ljc1em0xMjYuODMyMDMxIDEwLjY2MDE1N3YtMzUuMTYwMTU3YzAtMy40Mzc1LTIuNDk2MDkzLTYuMzYzMjgxLTUuODg2NzE4LTYuOTEwMTU2LTE1Ljc0NjA5NC0yLjIzODI4MS0zMS44MDA3ODItLjYxNzE4Ny00Ni43NzczNDQgNC43MTg3NS0yNC4wMjczNDQgOC40MTc5NjktNDQuNjk1MzEyIDI1LjMyMDMxMy02MS41NTA3ODEgNTAuMzEyNS0uMTk5MjE5LTUuMzEyNS0uMDIzNDM4LTEwLjYyODkwNi41MTk1MzEtMTUuOTE3OTY4IDIuMDc4MTI1LTIwLjU1ODU5NCAxMC41NzQyMTktNTAuMDQyOTY5IDM5LjIxODc1LTczLjc2MTcxOS4xNDg0MzgtLjEyMTA5NC4yOTI5NjktLjI1LjQyOTY4OC0uMzg2NzE5LjE5OTIxOC0uMTkxNDA2IDIwLjU5NzY1Ni0xOS4xMDE1NjIgNjUuNzQ2MDkzLTE5LjEwMTU2MmgxLjMwMDc4MWMzLjg2MzI4MiAwIDctMy4xMzI4MTMgNy03di0zNC40MjU3ODJsMjMuMzc4OTA3IDIzLjI2MTcxOSA0NS40Mjk2ODcgNDUuMTk5MjE5em0wIDAiIGZpbGw9IiM2MzMxNmQiLz48L3N2Zz4="
            qTitle: "Back"
            sourceSize.height: 30
            sourceSize.width: 30
            anchors.right: buttonPick.left
            anchors.rightMargin: buttonHeight
            anchors.verticalCenter: parent.verticalCenter
            enabled: canMoveUp()
            onEnabledChanged: {
                if (btnUp.enabled)
                    btnUp.opacity = 1.0
                else
                    btnUp.opacity = 0.3
            }

            onImageClicked: {
                if (canMoveUp) {
                    folderListModel.folder = folderListModel.parentFolder
                }
            }
        }

//        LinarcxImageToolTiper {
//            id: btnShowHidden
//            qImg: "data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjQwMXB0IiB2aWV3Qm94PSIwIC0xMSA0MDEuOTIwMTEgNDAxIiB3aWR0aD0iNDAxcHQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHBhdGggZD0ibTM5NSAzMjAuOTI5Njg4Yy42ODM1OTQgMjMuNDM3NS0xNy43NjE3MTkgNDIuOTkyMTg3LTQxLjIwMzEyNSA0My42Nzk2ODdsLTI5MC40ODgyODEgOC41YzIzLjQzNzUtLjY4NzUgNDEuODgyODEyLTIwLjI0MjE4NyA0MS4xOTkyMTgtNDMuNjc5Njg3bC01LjIxMDkzNy0xNzguMTQwNjI2Yy0uNjg3NS0yMy40Mzc1IDE3Ljc1MzkwNi00Mi45OTYwOTMgNDEuMTkxNDA2LTQzLjY3OTY4N2wxOTYuMDExNzE5LTUuNzMwNDY5IDkuNTk3NjU2LS4yODEyNWMyMy40NDE0MDYtLjY4NzUgNDMuMDAzOTA2IDE3Ljc1NzgxMyA0My42OTE0MDYgNDEuMTk5MjE5em0wIDAiIGZpbGw9IiNlNDhlNjYiLz48cGF0aCBkPSJtMzM2LjI1IDkzLjIzODI4MS4yNSA4LjY0MDYyNS0xOTYuMDExNzE5IDUuNzMwNDY5Yy0yMy40Mzc1LjY4MzU5NC00MS44Nzg5MDYgMjAuMjQyMTg3LTQxLjE5MTQwNiA0My42Nzk2ODdsNS4yMTA5MzcgMTc4LjE0MDYyNmMuNjgzNTk0IDIzLjQzNzUtMTcuNzYxNzE4IDQyLjk5MjE4Ny00MS4xOTkyMTggNDMuNjc5Njg3bC00LjQ2ODc1LjEyODkwNmMtMjMuNDQxNDA2LjY4NzUtNDMtMTcuNzU3ODEyLTQzLjY4MzU5NC00MS4xOTkyMTlsLTguMTM2NzE5LTI3OC4wODk4NDNjLS42ODc1LTIzLjQ0MTQwNyAxNy43NTc4MTMtNDIuOTk2MDk0IDQxLjE5OTIxOS00My42Nzk2ODhsOTUuMjEwOTM4LTIuNzkyOTY5YzExLjkxNzk2OC0uMzQ3NjU2IDIzLjQzMzU5MyA0LjMyODEyNiAzMS43MjY1NjIgMTIuODkwNjI2bDI5LjgzMjAzMSAzMC43ODEyNWMyLjA3NDIxOSAyLjE0MDYyNCA0Ljk1MzEyNSAzLjMwODU5MyA3LjkyOTY4OCAzLjIxODc1bDc5LjY0ODQzNy0yLjMyODEyNmMyMy40Mzc1LS42Nzk2ODcgNDIuOTkyMTg4IDE3Ljc2MTcxOSA0My42ODM1OTQgNDEuMTk5MjE5em0wIDAiIGZpbGw9IiNmOGVjN2QiLz48ZyBmaWxsPSIjNjMzMTZkIj48cGF0aCBkPSJtMjIuMTU2MjUgMzMxLjgzOTg0NC0uODU1NDY5LTI5LjE5MTQwNmMtLjExMzI4MS0zLjg2MzI4Mi0zLjMzOTg0My02LjkwNjI1LTcuMjAzMTI1LTYuNzkyOTY5LTMuODYzMjgxLjExMzI4MS02LjkwNjI1IDMuMzM5ODQzLTYuNzkyOTY4IDcuMjAzMTI1bC44NTU0NjggMjkuMTg3NWMuMjM4MjgyIDguMTEzMjgxIDIuNDY0ODQ0IDE2LjAzOTA2MiA2LjQ4MDQ2OSAyMy4wODk4NDQgMS45MjE4NzUgMy4zNTU0NjggNi4xOTUzMTMgNC41MTk1MzEgOS41NTQ2ODcgMi42MDE1NjIgMy4zNTU0NjktMS45MTc5NjkgNC41MTk1MzItNi4xOTUzMTIgMi41OTc2NTctOS41NTA3ODEtMi44Nzg5MDctNS4wNTQ2ODgtNC40Njg3NS0xMC43MzQzNzUtNC42MzY3MTktMTYuNTQ2ODc1em0wIDAiLz48cGF0aCBkPSJtOTIuNjc5Njg4IDE1Ljk2ODc1YzMuODYzMjgxLS4xMTMyODEgNi45MDYyNS0zLjMzOTg0NCA2Ljc5Mjk2OC03LjIwMzEyNS0uMTEzMjgxLTMuODYzMjgxLTMuMzM5ODQ0LTYuOTA2MjUtNy4yMDMxMjUtNi43OTI5NjlsLTQ0LjI1NzgxMiAxLjMwMDc4MmMtMi4yMTg3NS4wNjY0MDYtNC40Mjk2ODguMjc3MzQzLTYuNjE3MTg4LjYzNjcxOC0zLjgxNjQwNi42MjUtNi40MDIzNDMgNC4yMjY1NjMtNS43NzczNDMgOC4wMzkwNjMuNjI1IDMuODE2NDA2IDQuMjI2NTYyIDYuNDAyMzQzIDguMDQyOTY4IDUuNzc3MzQzIDEuNTc0MjE5LS4yNTc4MTIgMy4xNjc5NjktLjQxNDA2MiA0Ljc2MTcxOS0uNDU3MDMxem0wIDAiLz48cGF0aCBkPSJtMTM3LjkxNzk2OSAxMDAuNzM4MjgxYy0xOS45NDkyMTkgMS40OTIxODgtMzcuMDE5NTMxIDE0Ljg5ODQzOC00My4xOTkyMTkgMzMuOTI5Njg4LTEuMjAzMTI1IDMuNjcxODc1LjgwNDY4OCA3LjYyNSA0LjQ3NjU2MiA4LjgyODEyNSAzLjY3NTc4MiAxLjE5OTIxOCA3LjYyODkwNy0uODA0Njg4IDguODI4MTI2LTQuNDgwNDY5IDQuNDI5Njg3LTEzLjYzNjcxOSAxNi42NjQwNjItMjMuMjQ2MDk0IDMwLjk2NDg0My0yNC4zMjAzMTMgMy44NTU0NjktLjI5Mjk2OCA2Ljc0MjE4OC0zLjY2MDE1NiA2LjQ0NTMxMy03LjUxMTcxOC0uMjk2ODc1LTMuODU1NDY5LTMuNjYwMTU2LTYuNzQyMTg4LTcuNTE1NjI1LTYuNDQ1MzEzem0wIDAiLz48cGF0aCBkPSJtMzE4LjE2Nzk2OSA5NS40MTAxNTYtNDkuOTc2NTYzIDEuNDYwOTM4Yy0zLjg2NzE4Ny4wNTQ2ODctNi45NTcwMzEgMy4yMzQzNzUtNi45MDIzNDQgNy4xMDE1NjIuMDU0Njg4IDMuODY3MTg4IDMuMjM0Mzc2IDYuOTUzMTI1IDcuMTAxNTYzIDYuODk4NDM4aC4yMDcwMzFsNDkuOTgwNDY5LTEuNDYwOTM4YzMuODU5Mzc1LS4xMTcxODcgNi44OTA2MjUtMy4zMzk4NDQgNi43NzczNDQtNy4xOTkyMTgtLjExMzI4MS0zLjg1OTM3Ni0zLjMyODEyNS02Ljg5ODQzOC03LjE4NzUtNi43OTI5Njl6bTAgMCIvPjxwYXRoIGQ9Im0xNzIuNzUzOTA2IDI3Ljk0NTMxMmMxLjczNDM3NSAxLjgzNTkzOCA0LjMxNjQwNiAyLjU5Mzc1IDYuNzY1NjI1IDEuOTg4MjgyIDIuNDQ5MjE5LS42MDE1NjMgNC4zODI4MTMtMi40NzY1NjMgNS4wNjI1LTQuOTA2MjUuNjc5Njg4LTIuNDI1NzgyLjAwMzkwNy01LjAzNTE1Ni0xLjc3MzQzNy02LjgyNDIxOWwtMi42MjUtMi43MDMxMjVjLTkuMzI4MTI1LTkuNTg5ODQ0LTIyLjEzMjgxMy0xNS4wMTE3MTktMzUuNTA3ODEzLTE1LjAzOTA2Mi0uNDg0Mzc1IDAtLjk2NDg0My4wMDc4MTItMS40NTMxMjUuMDE5NTMxbC0xMC45Njg3NS4zMjAzMTJjLTMuODY3MTg3LjExMzI4MS02LjkwNjI1IDMuMzM5ODQ0LTYuNzkyOTY4IDcuMjAzMTI1LjExMzI4MSAzLjg2MzI4MiAzLjMzNTkzNyA2LjkwNjI1IDcuMjAzMTI0IDYuNzkyOTY5bDEwLjk2MDkzOC0uMzIwMzEzYzkuOTQ5MjE5LS4yNjE3MTggMTkuNTU0Njg4IDMuNjQwNjI2IDI2LjUwNzgxMiAxMC43NjE3MTl6bTAgMCIvPjxwYXRoIGQ9Im0yOTMuMDA3ODEyIDM1OS4zODI4MTItNDkuOTgwNDY4IDEuNDY0ODQ0Yy0zLjg2MzI4Mi4wNTQ2ODgtNi45NTMxMjUgMy4yMzA0NjktNi44OTg0MzggNy4wOTc2NTYuMDU0Njg4IDMuODY3MTg4IDMuMjM0Mzc1IDYuOTU3MDMyIDcuMTAxNTYzIDYuOTAyMzQ0aC4yMDcwMzFsNDkuOTgwNDY5LTEuNDY0ODQ0YzMuODYzMjgxLS4xMTMyODEgNi45MDYyNS0zLjMzNTkzNyA2Ljc5Mjk2OS03LjIwMzEyNC0uMTEzMjgyLTMuODY3MTg4LTMuMzM1OTM4LTYuOTEwMTU3LTcuMjAzMTI2LTYuNzk2ODc2em0wIDAiLz48cGF0aCBkPSJtMjAzLjA0Mjk2OSAzNjIuMDE1NjI1LTQ5Ljk3NjU2MyAxLjQ2MDkzN2MtMy44NjcxODcuMDU4NTk0LTYuOTU3MDMxIDMuMjM0Mzc2LTYuOTAyMzQ0IDcuMTAxNTYzLjA1NDY4OCAzLjg2NzE4NyAzLjIzNDM3NiA2Ljk1NzAzMSA3LjEwMTU2MyA2Ljg5ODQzN2guMjA3MDMxbDQ5Ljk4MDQ2OS0xLjQ2MDkzN2MyLjUwMzkwNi0uMDY2NDA2IDQuNzc3MzQ0LTEuNDY4NzUgNS45Njg3NS0zLjY3MTg3NSAxLjE4NzUtMi4yMDMxMjUgMS4xMDkzNzUtNC44NzUtLjIwNzAzMS03LjAwMzkwNnMtMy42Njc5NjktMy4zOTQ1MzItNi4xNzE4NzUtMy4zMTY0MDZ6bTAgMCIvPjxwYXRoIGQ9Im05NS42NzE4NzUgMjY2Ljc2OTUzMSAxLjQ2MDkzNyA0OS45ODA0NjljLjExMzI4MiAzLjc4MTI1IDMuMjEwOTM4IDYuNzg5MDYyIDYuOTk2MDk0IDYuNzkyOTY5aC4yMDcwMzJjMy44NjMyODEtLjExMzI4MSA2LjkwNjI1LTMuMzM1OTM4IDYuNzkyOTY4LTcuMTk5MjE5bC0xLjQ2MDkzNy00OS45ODA0NjljLS4wNzAzMTMtMi41LTEuNDY4NzUtNC43NzczNDMtMy42NzE4NzUtNS45NjQ4NDMtMi4yMDMxMjUtMS4xOTE0MDctNC44NzUtMS4xMTMyODItNy4wMDM5MDYuMjAzMTI0LTIuMTMyODEzIDEuMzE2NDA3LTMuMzk4NDM4IDMuNjY3OTY5LTMuMzIwMzEzIDYuMTcxODc2em0wIDAiLz48cGF0aCBkPSJtMzc1Ljk2NDg0NCAzNDguODA4NTk0Yy02LjIwNzAzMiA1LjQ0NTMxMi0xNC4xMTcxODggOC41NTg1OTQtMjIuMzcxMDk0IDguNzk2ODc1bC0yMC42MDU0NjkuNjAxNTYyYy0zLjg2NzE4Ny4wNTQ2ODgtNi45NTcwMzEgMy4yMzQzNzUtNi45MDIzNDMgNy4xMDE1NjMuMDU0Njg3IDMuODYzMjgxIDMuMjM0Mzc0IDYuOTUzMTI1IDcuMTAxNTYyIDYuODk4NDM3aC4yMDcwMzFsMjAuNjAxNTYzLS42MDE1NjJjMTEuNTE1NjI1LS4zMzk4NDQgMjIuNTU0Njg3LTQuNjgzNTk0IDMxLjIxMDkzNy0xMi4yODkwNjMgMi45MDIzNDQtMi41NTQ2ODcgMy4xODc1LTYuOTc2NTYyLjYzMjgxMy05Ljg3ODkwNi0yLjU1NDY4OC0yLjkwMjM0NC02Ljk3NjU2My0zLjE4MzU5NC05Ljg3ODkwNi0uNjI4OTA2em0wIDAiLz48cGF0aCBkPSJtMzkzLjI1MzkwNiAyNjEuMjg1MTU2Yy0zLjg2MzI4MS4xMTMyODItNi45MDYyNSAzLjMzNTkzOC02Ljc5Mjk2OCA3LjE5OTIxOWwxLjQ2MDkzNyA0OS45ODA0NjljLjExMzI4MSAzLjc4MTI1IDMuMjEwOTM3IDYuNzkyOTY4IDYuOTk2MDk0IDYuNzkyOTY4aC4yMDcwMzFjMy44NjMyODEtLjExMzI4MSA2LjkwMjM0NC0zLjMzNTkzNyA2Ljc5Mjk2OS03LjE5OTIxOGwtMS40NjA5MzgtNDkuOTc2NTYzYy0uMTI1LTMuODU5Mzc1LTMuMzQzNzUtNi44OTQ1MzEtNy4yMDMxMjUtNi43OTY4NzV6bTAgMCIvPjxwYXRoIGQ9Im0xMTMuMDgyMDMxIDM2NC42NDg0MzgtMTUuNTI3MzQzLjQ1MzEyNGMxLjg1NTQ2OC0xLjkwMjM0MyAzLjU1MDc4MS0zLjk1MzEyNCA1LjA3NDIxOC02LjEzMjgxMiAxLjQ2NDg0NC0yLjA0Njg3NSAxLjcxNDg0NC00LjcyNjU2Mi42NTYyNS03LjAxMTcxOS0xLjA1ODU5NC0yLjI4MTI1LTMuMjY1NjI1LTMuODI0MjE5LTUuNzczNDM3LTQuMDMxMjUtMi41MDc4MTMtLjIwNzAzMS00LjkzNzUuOTQ1MzEzLTYuMzU5Mzc1IDMuMDIzNDM4LTYuMzc4OTA2IDkuMjMwNDY5LTE2Ljc4MTI1IDE0Ljg1OTM3NS0yOCAxNS4xNjAxNTZoLS4wNzAzMTNsLTQuNDQ5MjE5LjEyODkwNmMtMS42NTIzNDMuMDUwNzgxLTMuMzA0Njg3LS4wMTU2MjUtNC45NDUzMTItLjE5NTMxMi0zLjgxNjQwNi0uMzc1LTcuMjI2NTYyIDIuMzkwNjI1LTcuNjQ0NTMxIDYuMjA3MDMxLS40MTc5NjkgMy44MTI1IDIuMzEyNSA3LjI1IDYuMTIxMDkzIDcuNzEwOTM4IDEuNzkyOTY5LjE5OTIxOCAzLjU5NzY1Ny4yOTY4NzQgNS4zOTg0MzguMzAwNzgxLjQ5MjE4OCAwIC45ODgyODEtLjAwNzgxMyAxLjQ3NjU2Mi0uMDIzNDM4bDQuNDcyNjU3LS4xMjg5MDZoLjA1MDc4MWw0OS45MjU3ODEtMS40NjA5MzdjMy44NTkzNzUtLjEyMTA5NCA2Ljg5NDUzMS0zLjM0Mzc1IDYuNzgxMjUtNy4yMDMxMjYtLjExMzI4MS0zLjg1OTM3NC0zLjMyODEyNS02Ljg5ODQzNy03LjE4NzUtNi43OTI5Njh6bTAgMCIvPjxwYXRoIGQ9Im05OS44MzU5MzggMTY5LjYwNTQ2OWMtMy44NjcxODguMTEzMjgxLTYuOTA2MjUgMy4zMzU5MzctNi43OTI5NjkgNy4yMDMxMjVsMS40NjQ4NDMgNDkuOTgwNDY4Yy4xMDkzNzYgMy43ODEyNSAzLjIwNzAzMiA2Ljc5Mjk2OSA2Ljk5MjE4OCA2Ljc5Mjk2OWguMjEwOTM4YzMuODYzMjgxLS4xMTMyODEgNi45MDIzNDMtMy4zMzU5MzcgNi43OTI5NjgtNy4xOTkyMTlsLTEuNDY0ODQ0LTQ5Ljk3NjU2MmMtLjEyNS0zLjg2MzI4MS0zLjM0Mzc1LTYuODk4NDM4LTcuMjAzMTI0LTYuODAwNzgxem0wIDAiLz48cGF0aCBkPSJtMjI4LjIwNzAzMSA5OC4wMzkwNjItNDkuOTc2NTYyIDEuNDYwOTM4Yy0zLjg2NzE4OC4wNTQ2ODgtNi45NTcwMzEgMy4yMzA0NjktNi45MDIzNDQgNy4wOTc2NTYuMDU0Njg3IDMuODY3MTg4IDMuMjM0Mzc1IDYuOTU3MDMyIDcuMTAxNTYzIDYuOTAyMzQ0aC4yMDcwMzFsNDkuOTgwNDY5LTEuNDY0ODQ0YzMuODYzMjgxLS4xMDkzNzUgNi45MDYyNS0zLjMzNTkzNyA2Ljc5Mjk2OC03LjIwMzEyNS0uMTA5Mzc1LTMuODYzMjgxLTMuMzM1OTM3LTYuOTA2MjUtNy4yMDMxMjUtNi43OTI5Njl6bTAgMCIvPjxwYXRoIGQ9Im0zOTIuMjg1MTU2IDIzNS4zMDA3ODFoLjIwNzAzMmMzLjg2MzI4MS0uMTEzMjgxIDYuOTA2MjUtMy4zMzU5MzcgNi43OTI5NjgtNy4xOTkyMTlsLTEuNDYwOTM3LTQ5Ljk4MDQ2OGMtLjExMzI4MS0zLjg2MzI4Mi0zLjMzNTkzOC02LjkwMjM0NC03LjIwMzEyNS02Ljc5Mjk2OS0zLjg2MzI4Mi4xMTMyODEtNi45MDIzNDQgMy4zMzk4NDQtNi43ODkwNjMgNy4yMDMxMjVsMS40NjA5MzggNDkuOTgwNDY5Yy4xMTMyODEgMy43ODEyNSAzLjIxMDkzNyA2Ljc4NTE1NiA2Ljk5MjE4NyA2Ljc4OTA2MnptMCAwIi8+PHBhdGggZD0ibTM5MC4zNTU0NjkgMTQ1LjI5Mjk2OWMzLjgzMjAzMS0uNTE1NjI1IDYuNTIzNDM3LTQuMDM1MTU3IDYuMDA3ODEyLTcuODY3MTg4LTIuNjIxMDkzLTE5LjgzOTg0My0xNi45ODA0NjktMzYuMTIxMDkzLTM2LjMzNTkzNy00MS4xOTkyMTktMi40MjE4NzUtLjY1NjI1LTUuMDA3ODEzLjAzNTE1Ny02Ljc4MTI1IDEuODEyNS0xLjc3MzQzOCAxLjc3MzQzOC0yLjQ2MDkzOCA0LjM2MzI4Mi0xLjgwMDc4MiA2Ljc4NTE1Ny42NjQwNjMgMi40MjE4NzUgMi41NzAzMTMgNC4zMDQ2ODcgNSA0LjkzMzU5MyAxMy44NzEwOTQgMy42NDA2MjYgMjQuMTY0MDYzIDE1LjMxMjUgMjYuMDQyOTY5IDI5LjUzMTI1LjI0MjE4OCAxLjgzOTg0NCAxLjIxMDkzOCAzLjUwNzgxMyAyLjY4NzUgNC42MzY3MTkgMS40NzY1NjMgMS4xMjg5MDcgMy4zMzk4NDQgMS42MjEwOTQgNS4xNzk2ODggMS4zNzEwOTR6bTAgMCIvPjxwYXRoIGQ9Im0yOTUuMTY3OTY5IDQ1LjAzOTA2MmMtMi41MTk1MzEtLjA5NzY1Ni00Ljg5NDUzMSAxLjE2Nzk2OS02LjIxODc1IDMuMzA4NTk0LTEuMzI4MTI1IDIuMTQ0NTMyLTEuNDAyMzQ0IDQuODMyMDMyLS4xOTE0MDcgNy4wNDI5NjkgMS4yMTA5MzggMi4yMTA5MzcgMy41MTE3MTkgMy42MDE1NjMgNi4wMzUxNTcgMy42NDA2MjUgMTQuMzM1OTM3LjM2MzI4MSAyNy4wMzUxNTYgOS4zNTU0NjkgMzIuMTM2NzE5IDIyLjc1NzgxMiAxLjM5MDYyNCAzLjU5NzY1NyA1LjQyOTY4NyA1LjM4NjcxOSA5LjAzMTI1IDQuMDA3ODEzIDMuNjAxNTYyLTEuMzgyODEzIDUuNDA2MjUtNS40MTQwNjMgNC4wMzkwNjItOS4wMTk1MzEtNy4xMjEwOTQtMTguNjk1MzEzLTI0LjgzMjAzMS0zMS4yMzQzNzUtNDQuODMyMDMxLTMxLjczODI4MnptMCAwIi8+PHBhdGggZD0ibTcuODYzMjgxIDg5Ljk0NTMxMmguMjA3MDMxYzMuODYzMjgyLS4xMTMyODEgNi45MDYyNS0zLjMzNTkzNyA2Ljc5Mjk2OS03LjIwMzEyNGwtLjg0NzY1Ni0yOC45OTIxODhjLS4wMTE3MTktLjM1MTU2Mi0uMDE1NjI1LS43MDMxMjUtLjAxNTYyNS0xLjA1MDc4MS0uMDE1NjI1LTUuNTE1NjI1IDEuMjczNDM4LTEwLjk2MDkzOCAzLjc1NzgxMi0xNS44ODY3MTkgMS43MzQzNzYtMy40NTMxMjUuMzQzNzUtNy42NjAxNTYtMy4xMDkzNzQtOS4zOTg0MzgtMy40NTMxMjYtMS43MzQzNzQtNy42NjQwNjMtLjM0Mzc1LTkuMzk4NDM4IDMuMTA5Mzc2LTMuNDcyNjU2IDYuODc1LTUuMjY5NTMxMiAxNC40NzI2NTYtNS4yNSAyMi4xNzU3ODEgMCAuNDg0Mzc1LjAwNzgxMjUuOTY4NzUuMDE5NTMxMiAxLjQ1NzAzMWwuODUxNTYyOCAyOWMuMTEzMjgxIDMuNzgxMjUgMy4yMTA5MzcgNi43ODUxNTYgNi45OTIxODcgNi43ODkwNjJ6bTAgMCIvPjxwYXRoIGQ9Im0yMTIuNzE0ODQ0IDQ3LjM3MTA5NGgtLjExNzE4OGMtLjg2MzI4MSAwLTEuNzAzMTI1LS4zMTI1LTIuMzU1NDY4LS44Nzg5MDYtMS44Nzg5MDctMS42ODM1OTQtNC41MTk1MzItMi4yMjI2NTctNi45MTAxNTctMS40MTQwNjNzLTQuMTYwMTU2IDIuODM5ODQ0LTQuNjMyODEyIDUuMzIwMzEzYy0uNDcyNjU3IDIuNDc2NTYyLjQyNTc4MSA1LjAxOTUzMSAyLjM1MTU2MiA2LjY1MjM0MyAzLjE5OTIxOSAyLjc4NTE1NyA3LjMwNDY4OCA0LjMyMDMxMyAxMS41NDY4NzUgNC4zMjAzMTMuMTk1MzEzIDAgLjM4NjcxOSAwIC41MjczNDQtLjAwNzgxM2w0Mi4wNzQyMTktMS4yMzA0NjljMy44NTkzNzUtLjEyMTA5MyA2Ljg5NDUzMS0zLjM0Mzc1IDYuNzgxMjUtNy4yMDMxMjQtLjExMzI4MS0zLjg1OTM3Ni0zLjMyODEyNS02Ljg5ODQzOC03LjE4NzUtNi43OTI5Njl6bTAgMCIvPjxwYXRoIGQ9Im0xMy4xMjg5MDYgMjY5Ljg2NzE4OGguMjEwOTM4YzMuODYzMjgxLS4xMTMyODIgNi45MDIzNDQtMy4zMzU5MzggNi43ODkwNjItNy4xOTkyMTlsLTEuNDYwOTM3LTQ5Ljk4MDQ2OWMtLjExMzI4MS0zLjg2MzI4MS0zLjMzOTg0NC02LjkwNjI1LTcuMjAzMTI1LTYuNzkyOTY5LTMuODYzMjgyLjExMzI4MS02LjkwNjI1IDMuMzM5ODQ0LTYuNzkyOTY5IDcuMjAzMTI1bDEuNDY0ODQ0IDQ5Ljk4MDQ2OWMuMTEzMjgxIDMuNzgxMjUgMy4yMTA5MzcgNi43ODUxNTYgNi45OTIxODcgNi43ODkwNjN6bTAgMCIvPjxwYXRoIGQ9Im0xMC40OTYwOTQgMTc5LjkwNjI1aC4yMDcwMzFjMy44NjMyODEtLjExMzI4MSA2LjkwNjI1LTMuMzM1OTM4IDYuNzkyOTY5LTcuMjAzMTI1bC0xLjQ2MDkzOC00OS45NzY1NjNjLS4xMTMyODEtMy44NjMyODEtMy4zMzk4NDQtNi45MDYyNS03LjIwMzEyNS02Ljc5Mjk2OC0zLjg2MzI4MS4xMTMyODEtNi45MDYyNSAzLjMzOTg0NC02Ljc5Mjk2OSA3LjIwMzEyNWwxLjQ2ODc1IDQ5Ljk3MjY1NmMuMTA5Mzc2IDMuNzgxMjUgMy4yMDcwMzIgNi43ODkwNjMgNi45ODgyODIgNi43OTY4NzV6bTAgMCIvPjwvZz48L3N2Zz4="
//            qTitle: "Show hidden files"
//            sourceSize.width: 30
//            sourceSize.height: 30
//            anchors.right: btnUp.left
//            anchors.rightMargin: buttonHeight
//            anchors.verticalCenter: parent.verticalCenter
//            enabled: true
//            onImageClicked: {
//                if (isHidden) {
//                    folderListModel.showHidden = false
//                    isHidden = false
//                } else {
//                    folderListModel.showHidden = true
//                    isHidden = true
//                }
//            }
//        }

        Text {
            id: filePath
            text: folderListModel.folder.toString().replace("file:///",
                                                            " ► ").replace(
                      new RegExp("/", 'g'), " ► ")
            renderType: Text.NativeRendering
            elide: Text.ElideMiddle
            anchors.right: btnUp.left
            font.italic: true
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            anchors.leftMargin: buttonHeight
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            font.pixelSize: textSize
        }
    }

    FolderListModel {
        id: folderListModel
        showDotAndDotDot: picker.showDotAndDotDot
        showHidden: picker.showHidden
        showDirsFirst: picker.showDirsFirst
        folder: picker.mFolder ? picker.mFolder : "file:///"
        nameFilters: picker.nameFilters ? picker.nameFilters : "*.*"
    }

    OldControls.TableView {
        id: view
        anchors.top: toolbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        model: folderListModel
        headerDelegate: headerDelegate
        rowDelegate: Rectangle {
            height: rowHeight
        }

        OldControls.TableViewColumn {
            title: qsTr("Choose File")
            role: "fileName"
            resizable: true
            delegate: fileDelegate
        }

        Component {
            id: fileDelegate
            Item {
                height: rowHeight
                Rectangle {
                    anchors.fill: parent
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            onItemClick(fileNameText.text)
                        }
                    }
                    Text {
                        id: fileNameText
                        height: width
                        anchors.left: image.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        text: styleData.value !== undefined ? styleData.value : ""
                        verticalAlignment: Text.AlignVCenter
                    }
                    Image {
                        id: image
                        height: buttonHeight
                        width: height
                        anchors.left: parent.left
                        anchors.leftMargin: textmargin
                        anchors.verticalCenter: parent.verticalCenter
                        source: isFolder(
                                    fileNameText.text) ? "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgNDg0LjE5MSA0ODQuMTkxIiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA0ODQuMTkxIDQ4NC4xOTE7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxwYXRoIHN0eWxlPSJmaWxsOiNFRDY2NEM7IiBkPSJNMjcxLjU0NiwzNTEuMjQ2YzExLjEtMTEuMSwxOC0yNi40LDE4LTQzLjNjMC0zMy44LTI3LjUtNjEuMi02MS40LTYxLjJzLTYxLjQsMjcuNC02MS40LDYxLjINCglzMjcuNSw2MS4yLDYxLjQsNjEuMkMyNDUuMTQ2LDM2OS4xNDYsMjYwLjQ0NiwzNjIuMzQ2LDI3MS41NDYsMzUxLjI0NnogTTQ3NC4yNDYsMTk3LjQ0NmwtNDIuMSwyMzguN2gtMzc5LjVsLTQyLjYtMjM4LjdoNDAuN2gzNC40DQoJaDMxNGgzOC40SDQ3NC4yNDZ6Ii8+DQo8Zz4NCgk8cG9seWdvbiBzdHlsZT0iZmlsbDojRkRDNzVCOyIgcG9pbnRzPSI0MzcuNTQ2LDkxLjI0NiA0MzcuNTQ2LDE5Ny40NDYgMzk5LjE0NiwxOTcuNDQ2IDM5OS4xNDYsMTk3LjA0NiAzOTkuMTQ2LDEzMS4wNDYgDQoJCTg1LjE0NiwxMzEuMDQ2IDg1LjE0NiwxOTcuMDQ2IDg1LjE0NiwxOTcuNDQ2IDUwLjc0NiwxOTcuNDQ2IDQ1LjA0Niw0Ny44NDYgMTk4LjI0Niw0Ny44NDYgMjQyLjg0Niw5MS4yNDYgCSIvPg0KCTxwb2x5Z29uIHN0eWxlPSJmaWxsOiNGREM3NUI7IiBwb2ludHM9IjM5OS4xNDYsMTk3LjA0NiAzOTkuMTQ2LDE5Ny40NDYgODUuMTQ2LDE5Ny40NDYgODUuMTQ2LDE5Ny4wNDYgODUuMTQ2LDEzMS4wNDYgDQoJCTM5OS4xNDYsMTMxLjA0NiAJIi8+DQo8L2c+DQo8cGF0aCBzdHlsZT0iZmlsbDojRUQ2NjRDOyIgZD0iTTI3MS41NDYsMzUxLjI0NmMtMTEuMSwxMS0yNi40LDE3LjktNDMuMywxNy45Yy0zMy45LDAtNjEuNC0yNy40LTYxLjQtNjEuMnMyNy41LTYxLjIsNjEuNC02MS4yDQoJczYxLjQsMjcuNCw2MS40LDYxLjJDMjg5LjU0NiwzMjQuODQ2LDI4Mi42NDYsMzQwLjE0NiwyNzEuNTQ2LDM1MS4yNDZ6Ii8+DQo8cGF0aCBkPSJNNDc0LjI0NiwxODcuMDQ2aC0yNy4xdi05NS44YzAtNS41LTQuMS0xMC4yLTkuNi0xMC4yaC0xOTAuNmwtNDEuNy00MC4zYy0xLjktMS44LTQuNC0yLjctNy0yLjdoLTE1My4yYy0yLjcsMC01LjMsMS03LjIsMw0KCXMtMi45LDQuNC0yLjgsNy4xbDUuMywxMzguOWgtMzAuM2MtMywwLTUuOCwxLjUtNy43LDMuOGMtMS45LDIuMy0yLjcsNS40LTIuMiw4LjNsNDIuNiwyMzguOGMwLjksNC44LDUsOC4yLDkuOCw4LjJoMzc5LjYNCgljNC45LDAsOS0zLjQsOS44LTguMmw0Mi4xLTIzOC44YzAuNS0yLjktMC4zLTYuMS0yLjItOC4zQzQ3OS45NDYsMTg4LjU0Niw0NzcuMTQ2LDE4Ny4wNDYsNDc0LjI0NiwxODcuMDQ2eiBNNTUuNDQ2LDU4LjA0NmgxMzguOA0KCWw0MS43LDQwLjNjMS45LDEuOCw0LjQsMi43LDcsMi43aDE4NC4ydjg2aC0xOHYtNTZjMC01LjUtNC41LTEwLTEwLTEwaC0zMTRjLTUuNSwwLTEwLDQuNS0xMCwxMHY1NmgtMTQuN0w1NS40NDYsNTguMDQ2eg0KCSBNMzg5LjE0NiwxODcuMDQ2aC0yOTR2LTQ2aDI5NFYxODcuMDQ2eiBNNDIzLjc0Niw0MjYuMDQ2aC0zNjIuN2wtMzktMjE5aDQ0MC4zTDQyMy43NDYsNDI2LjA0NnoiLz4NCjxwYXRoIGQ9Ik0yODUuMjQ2LDM1MC43NDZjOS4zLTEyLjMsMTQuNC0yNy4yLDE0LjQtNDIuOGMwLTM5LjMtMzItNzEuMi03MS40LTcxLjJzLTcxLjQsMzEuOS03MS40LDcxLjJzMzIsNzEuMiw3MS40LDcxLjINCgljMTUuNywwLDMwLjUtNSw0Mi44LTE0LjJsMjkuNCwyOS4yYzIsMS45LDQuNSwyLjksNy4xLDIuOXM1LjEtMSw3LjEtMi45YzMuOS0zLjksMy45LTEwLjIsMC0xNC4xTDI4NS4yNDYsMzUwLjc0NnoNCgkgTTE3Ni44NDYsMzA3Ljk0NmMwLTI4LjIsMjMuMS01MS4yLDUxLjQtNTEuMnM1MS40LDIzLDUxLjQsNTEuMmMwLDEzLjQtNS4yLDI2LjEtMTQuNiwzNS43Yy0wLjIsMC4yLTAuNCwwLjMtMC42LDAuNQ0KCXMtMC4zLDAuNC0wLjUsMC42Yy05LjYsOS4zLTIyLjMsMTQuNC0zNS43LDE0LjRDMTk5Ljg0NiwzNTkuMTQ2LDE3Ni44NDYsMzM2LjE0NiwxNzYuODQ2LDMwNy45NDZ6Ii8+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8L3N2Zz4NCg==" : "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgNTggNTgiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDU4IDU4OyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8cmVjdCB4PSIxIiB5PSI3IiBzdHlsZT0iZmlsbDojQzNFMUVEO3N0cm9rZTojRTdFQ0VEO3N0cm9rZS13aWR0aDoyO3N0cm9rZS1taXRlcmxpbWl0OjEwOyIgd2lkdGg9IjU2IiBoZWlnaHQ9IjQ0Ii8+DQo8Y2lyY2xlIHN0eWxlPSJmaWxsOiNFRDhBMTk7IiBjeD0iMTYiIGN5PSIxNy41NjkiIHI9IjYuNTY5Ii8+DQo8cG9seWdvbiBzdHlsZT0iZmlsbDojMUE5MTcyOyIgcG9pbnRzPSI1NiwzNi4xMTEgNTUsMzUgNDMsMjQgMzIuNSwzNS41IDM3Ljk4Myw0MC45ODMgNDIsNDUgNTYsNDUgIi8+DQo8cG9seWdvbiBzdHlsZT0iZmlsbDojMUE5MTcyOyIgcG9pbnRzPSIyLDQ5IDI2LDQ5IDIxLjk4Myw0NC45ODMgMTEuMDE3LDM0LjAxNyAyLDQxLjk1NiAiLz4NCjxyZWN0IHg9IjIiIHk9IjQ1IiBzdHlsZT0iZmlsbDojNkI1QjRCOyIgd2lkdGg9IjU0IiBoZWlnaHQ9IjUiLz4NCjxwb2x5Z29uIHN0eWxlPSJmaWxsOiMyNUFFODg7IiBwb2ludHM9IjM3Ljk4Myw0MC45ODMgMjcuMDE3LDMwLjAxNyAxMCw0NSA0Miw0NSAiLz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjwvc3ZnPg0K"
                    }
                }
            }
        }
        Component {
            id: headerDelegate
            Rectangle {
                height: rowHeight
                color: textAltColor()
                border.color: textAltColor()
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: headerTextSize
                    font.bold: true
                    elide: Text.ElideMiddle
                    color: primaryColor()
                    text: styleData.value !== undefined ? styleData.value : ""
                }
            }
        }
    }
}
