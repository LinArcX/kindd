import QtQuick 2.9
import QtQuick.Controls 2.3

import "qrc:/strings/CoreStrings.js" as CStr

Column {
    default property alias item: ld.sourceComponent
    property string qTitle
    property string qImage

    Rectangle {
        width: CStr.accordionWidth
        height: CStr.accordionHeight
        color: CStr.accordionBackGroundColor

        LinArcxAccordionItem {
            mTitle: qTitle ? qTitle : ""
            mImage: qImage ? qImage : "none"
            isHeader: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: info.show = !info.show
        }
    }

    Rectangle {
        id: info
        property bool show: false

        clip: true
        color: "#616161"
        width: CStr.accordionWidth
        height: show ? ld.height : 0
        Loader {
            id: ld
            y: info.height - height
            anchors.horizontalCenter: info.horizontalCenter
        }
        Behavior on height {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    }
}
