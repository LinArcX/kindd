import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Window 2.3

import "qrc:/pages/"
import "qrc:/components/qml/"

ApplicationWindow {
    id: qWindow
    height: 500
    visible: true
    title: qsTr("Kindd")
    x: Screen.width / 2 - qWindow.minimumWidth / 2
    y: Screen.height / 2 - qWindow.minimumHeight / 2

    StackView {
        id: qStackView
        width: parent.width - 50
        height: parent.height
        anchors.left: qMenu.right
    }

    Rectangle {
        id: qMenu
        width: 50
        height: parent.height
        color: "transparent"

        Rectangle {
            id: qProjects
            width: parent.width
            height: parent.height
            color: "#424242" //"#767676"
            z: 1

            LinarcxImageToolTiper {
                id: qCreateIso
                qImg: "qrc:/images/createISO.svg"
                qTitle: "Create Bootable .iso"
                sourceSize.height: 40
                sourceSize.width: 40
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.topMargin: 5
                onImageClicked: qStackView.push("qrc:/pages/CreateISO.qml")
            }

            LinarcxImageToolTiper {
                id: qSettings
                qImg: "qrc:/images/settings.svg"
                qTitle: "Settings"
                sourceSize.height: 40
                sourceSize.width: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 5
                onImageClicked: qStackView.push("qrc:/pages/Settings.qml")
            }
        }
    }

    Component.onCompleted: {
        qWindow.minimumWidth = 700
        qWindow.width = 700
        qWindow.maximumWidth = Screen.width
        qWindow.maximumHeight = Screen.height
        qStackView.push("qrc:/pages/CreateISO.qml")
        //        qWindow.x = Screen.width / 2 - qWindow.minimumWidth / 2
        //        qWindow.y = Screen.height / 2 - qWindow.minimumHeight / 2
    }
}
