import QtQuick 2.0
import QtQuick.Controls 1.4 as OldControls
import QtQuick.Controls 2.2
import Qt.labs.folderlistmodel 2.11
import QtQuick.Window 2.0

Dialog {
    id: picker
    signal fileSelected(string fileName)
    signal pickSelected(string folderName)
    readonly property real textmargin: dp(Screen.pixelDensity, 8)
    readonly property real textSize: dp(Screen.pixelDensity, 10)
    readonly property real headerTextSize: dp(Screen.pixelDensity, 12)
    readonly property real buttonHeight: dp(Screen.pixelDensity, 24)
    readonly property real rowHeight: dp(Screen.pixelDensity, 36)
    readonly property real toolbarHeight: dp(Screen.pixelDensity, 48)
    property bool showDotAndDotDot: false
    property bool showHidden: true
    property bool showDirsFirst: true
    property string mFolder: "file:///sdcard/"
    property var nameFilters

    modal: true
    focus: true
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
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

        Image {
            id: btnClose
            source: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgNDU1LjExMSA0NTUuMTExIiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA0NTUuMTExIDQ1NS4xMTE7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxjaXJjbGUgc3R5bGU9ImZpbGw6I0UyNEM0QjsiIGN4PSIyMjcuNTU2IiBjeT0iMjI3LjU1NiIgcj0iMjI3LjU1NiIvPg0KPHBhdGggc3R5bGU9ImZpbGw6I0QxNDAzRjsiIGQ9Ik00NTUuMTExLDIyNy41NTZjMCwxMjUuMTU2LTEwMi40LDIyNy41NTYtMjI3LjU1NiwyMjcuNTU2Yy03Mi41MzMsMC0xMzYuNTMzLTMyLjcxMS0xNzcuNzc4LTg1LjMzMw0KCWMzOC40LDMxLjI4OSw4OC4xNzgsNDkuNzc4LDE0Mi4yMjIsNDkuNzc4YzEyNS4xNTYsMCwyMjcuNTU2LTEwMi40LDIyNy41NTYtMjI3LjU1NmMwLTU0LjA0NC0xOC40ODktMTAzLjgyMi00OS43NzgtMTQyLjIyMg0KCUM0MjIuNCw5MS4wMjIsNDU1LjExMSwxNTUuMDIyLDQ1NS4xMTEsMjI3LjU1NnoiLz4NCjxwYXRoIHN0eWxlPSJmaWxsOiNGRkZGRkY7IiBkPSJNMzMxLjM3OCwzMzEuMzc4Yy04LjUzMyw4LjUzMy0yMi43NTYsOC41MzMtMzEuMjg5LDBsLTcyLjUzMy03Mi41MzNsLTcyLjUzMyw3Mi41MzMNCgljLTguNTMzLDguNTMzLTIyLjc1Niw4LjUzMy0zMS4yODksMGMtOC41MzMtOC41MzMtOC41MzMtMjIuNzU2LDAtMzEuMjg5bDcyLjUzMy03Mi41MzNsLTcyLjUzMy03Mi41MzMNCgljLTguNTMzLTguNTMzLTguNTMzLTIyLjc1NiwwLTMxLjI4OWM4LjUzMy04LjUzMywyMi43NTYtOC41MzMsMzEuMjg5LDBsNzIuNTMzLDcyLjUzM2w3Mi41MzMtNzIuNTMzDQoJYzguNTMzLTguNTMzLDIyLjc1Ni04LjUzMywzMS4yODksMGM4LjUzMyw4LjUzMyw4LjUzMywyMi43NTYsMCwzMS4yODlsLTcyLjUzMyw3Mi41MzNsNzIuNTMzLDcyLjUzMw0KCUMzMzkuOTExLDMwOC42MjIsMzM5LjkxMSwzMjIuODQ0LDMzMS4zNzgsMzMxLjM3OHoiLz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjwvc3ZnPg0K"
            anchors.right: parent.right
            anchors.rightMargin: buttonHeight
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: 30
            sourceSize.height: 30
            enabled: true
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    //                    picker.destroy()
                    picker.close()
                }
            }
        }

        Image {
            id: buttonPick
            source: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJDYXBhXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgNDkwLjY2NyA0OTAuNjY3IiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA0OTAuNjY3IDQ5MC42Njc7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxwYXRoIHN0eWxlPSJmaWxsOiNGRkNDODA7IiBkPSJNNDA1LjMzMywxNDkuMzMzYy0xNy42NzMsMC0zMiwxNC4zMjctMzIsMzJWMTYwYzAtMTcuNjczLTE0LjMyNy0zMi0zMi0zMmMtMTcuNjczLDAtMzIsMTQuMzI3LTMyLDMyDQoJdi0yMS4zMzNjMC0xNy42NzMtMTQuMzI3LTMyLTMyLTMyYy0xNy42NzMsMC0zMiwxNC4zMjctMzIsMzJWMzJjMC0xNy42NzMtMTQuMzI3LTMyLTMyLTMycy0zMiwxNC4zMjctMzIsMzJ2MjY2LjY2N2wtNzQuMDY5LTM3LjAzNQ0KCWMtNy40MDUtMy43MDMtMTUuNTcxLTUuNjMxLTIzLjg1MS01LjYzMmMtMTYuNjEzLDAtMzAuMDgsMTMuNDY3LTMwLjA4LDMwLjA4djAuMTI4Yy0wLjAxNyw4LDMuMTU0LDE1LjY3Nyw4LjgxMSwyMS4zMzMNCglsMTM3Ljk0MSwxMzcuOTQxYzI4Ljk4MywyOC45NTQsNjguMjgxLDQ1LjIwNywxMDkuMjQ4LDQ1LjE4NGwwLDBjNzAuNjkyLDAsMTI4LTU3LjMwOCwxMjgtMTI4VjE4MS4zMzMNCglDNDM3LjMzMywxNjMuNjYsNDIzLjAwNywxNDkuMzMzLDQwNS4zMzMsMTQ5LjMzM3oiLz4NCjxnPg0KCTxwYXRoIHN0eWxlPSJmaWxsOiNGRkI3NEQ7IiBkPSJNMjU2LDExNC45ODd2MTE5LjY4YzAsNS44OTEtNC43NzYsMTAuNjY3LTEwLjY2NywxMC42NjdWMTM4LjY2Nw0KCQlDMjQ1LjI5MSwxMjkuNjAxLDI0OS4xODMsMTIwLjk2MiwyNTYsMTE0Ljk4N3oiLz4NCgk8cGF0aCBzdHlsZT0iZmlsbDojRkZCNzREOyIgZD0iTTMyMCwxMzYuMzJ2OTguMzQ3YzAsNS44OTEtNC43NzYsMTAuNjY3LTEwLjY2NywxMC42NjdWMTYwDQoJCUMzMDkuMjkxLDE1MC45MzQsMzEzLjE4MywxNDIuMjk2LDMyMCwxMzYuMzJ6Ii8+DQoJPHBhdGggc3R5bGU9ImZpbGw6I0ZGQjc0RDsiIGQ9Ik0zODQsMTU3LjY1M3Y3Ny4wMTNjMCw1Ljg5MS00Ljc3NiwxMC42NjctMTAuNjY3LDEwLjY2N3YtNjQNCgkJQzM3My4yOTEsMTcyLjI2OCwzNzcuMTgzLDE2My42MjksMzg0LDE1Ny42NTN6Ii8+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8L3N2Zz4NCg=="
            anchors.right: btnClose.left
            anchors.rightMargin: buttonHeight
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: 30
            sourceSize.height: 30
            enabled: true
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log(folderListModel.folder.toString())
                    pickSelected(folderListModel.folder.toString())
                    picker.close()
                }
            }
        }

        Image {
            id: btnUp
            source: "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pg0KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDE5LjAuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPg0KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJMYXllcl8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCINCgkgdmlld0JveD0iMCAwIDQ4OS42IDQ4OS42IiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA0ODkuNiA0ODkuNjsiIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPGc+DQoJPGc+DQoJCTxwYXRoIHN0eWxlPSJmaWxsOiMyQzJGMzM7IiBkPSJNMjQ0LjgsNDg5LjZjMTM1LDAsMjQ0LjgtMTA5LjgsMjQ0LjgtMjQ0LjhTMzc5LjgsMCwyNDQuOCwwUzAsMTA5LjgsMCwyNDQuOA0KCQkJUzEwOS44LDQ4OS42LDI0NC44LDQ4OS42eiBNMjQ0LjgsMTkuOGMxMjQuMSwwLDIyNSwxMDAuOSwyMjUsMjI1cy0xMDAuOSwyMjUtMjI1LDIyNXMtMjI1LTEwMC45LTIyNS0yMjVTMTIwLjcsMTkuOCwyNDQuOCwxOS44eiINCgkJCS8+DQoJCTxwYXRoIHN0eWxlPSJmaWxsOiMzQzkyQ0E7IiBkPSJNMjY1LjUsMzI2LjFjMS45LDEuOSw0LjUsMi45LDcsMi45czUuMS0xLDctMi45YzMuOS0zLjksMy45LTEwLjEsMC0xNGwtNjcuMy02Ny4zbDY3LjMtNjcuMw0KCQkJYzMuOS0zLjksMy45LTEwLjEsMC0xNHMtMTAuMS0zLjktMTQsMGwtNzQuMyw3NC4zYy0zLjksMy45LTMuOSwxMC4xLDAsMTRMMjY1LjUsMzI2LjF6Ii8+DQoJPC9nPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPGc+DQo8L2c+DQo8Zz4NCjwvZz4NCjxnPg0KPC9nPg0KPC9zdmc+DQo="
            anchors.right: buttonPick.left
            anchors.rightMargin: buttonHeight
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: 30
            sourceSize.height: 30
            enabled: canMoveUp()
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (canMoveUp) {
                        folderListModel.folder = folderListModel.parentFolder
                    }
                }
            }
        }



        Text {
            id: filePath
            text: folderListModel.folder.toString().replace("file:///",
                                                            "►").replace(
                      new RegExp("/", 'g'), "►")
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
