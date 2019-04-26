import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Window 2.3

import "qrc:/modules/"

ApplicationWindow {
    id: qWindow
    height: 500
    visible: true
    title: qsTr("Kindd")
    x: Screen.width / 2 - qWindow.minimumWidth / 2
    y: Screen.height / 2 - qWindow.minimumHeight / 2

    property int pageHeight
    signal pageSettingsCompleted(var qHeight)

//    FontLoader {
//        id: mFont
//        source: "qrc:/fonts/Aller.ttf"
//    }

    onPageSettingsCompleted: {
        qWindow.minimumHeight = qHeight
    }

//    font.family: mFont.name

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        Settings {
        }
        ListDevices {
        }
        CreateISO {
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: 2
        TabButton {
            text: qsTr("Settings")
        }
        TabButton {
            text: qsTr("List Devices")
        }
        TabButton {
            text: qsTr("Create Bootable .iso")
        }
    }

    Component.onCompleted: {
        qWindow.minimumWidth = 700
        qWindow.width = 700
        qWindow.maximumWidth = Screen.width
        qWindow.maximumHeight = Screen.height
        //        qWindow.x = Screen.width / 2 - qWindow.minimumWidth / 2
        //        qWindow.y = Screen.height / 2 - qWindow.minimumHeight / 2
    }
}
