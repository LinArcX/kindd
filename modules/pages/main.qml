import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Window 2.3

import "qrc:/modules/"

ApplicationWindow {
    id: qWindow

//    minimumWidth: 700
//    minimumHeight: 500
    width: 700
    height: 600

    x: Screen.width / 2 - qWindow.minimumWidth / 2
    y: Screen.height / 2 - qWindow.minimumHeight / 2

     visible: true
    title: qsTr("Kindd")

    FontLoader {
        id: mFont
        source: "qrc:/fonts/Aller.ttf"
    }

    font.family: mFont.name

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        ListDevices {
        }
        CreateISO{
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: 1
        TabButton {
            text: qsTr("List Devices")
        }
        TabButton {
            text: qsTr("Create Bootable .iso")
        }
    }

//    Component.onCompleted: {
//        qWindow.minimumWidth = 700
//        qWindow.minimumHeight = 500
//        qWindow.maximumWidth = Screen.width
//        qWindow.maximumHeight = Screen.height

//        qWindow.x = Screen.width / 2 - qWindow.minimumWidth / 2
//        qWindow.y = Screen.height / 2 - qWindow.minimumHeight / 2
//        //pageLoader.source = CStr.dashBoardLink
//    }
}
