import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Window 2.2

import "qrc:/strings/CoreStrings.js" as CStr

Window {
    id: splashScreen
    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen // Qt.FramelessWindowHint
    color: "transparent"
    width: 300
    height: 300

    FontLoader {
        id: mFont
        source: CStr.fontCaviarDreams
    }

    Rectangle {
        id: splashRect
        anchors.fill: parent
        color: "transparent"

        Image {
            id: qSplashImage
            source: "qrc:/images/gnulium.svg"
            sourceSize.width: parent.width - 40
            sourceSize.height: parent.height - 40
            anchors.top: parent.top
        }

        Text {
            id: qSplashIntro
            text: "Gnulium"
            anchors.top: qSplashImage.bottom
            anchors.horizontalCenter: qSplashImage.horizontalCenter
            font.pixelSize: 40
            font.italic: true
            font.bold: true
            color: "white"
            font.family: mFont.name
        }
    }

    Component.onCompleted: visible = true
}
