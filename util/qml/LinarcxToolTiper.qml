import QtQuick 2.9

Item {
    id: mtooltiper
    anchors.fill: parent
    property string toolTip
    property bool showToolTip: false

    property variant mItem
    property color enterColor
    property color exitColor

    property variant clickFunc

    Rectangle {
        id: toolTipRectangle
        width: toolTipText.width + 4
        height: toolTipText.height + 4
        anchors.top: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        z: 2
        color: "#ffffaa"
        border.color: "#0a0a0a"
        opacity: toolTip != "" && showToolTip ? 1 : 0

        Text {
            id: toolTipText
            text: toolTip
            color: "black"
            anchors.centerIn: parent
        }
        Behavior on opacity {
            PropertyAnimation {
                easing.type: Easing.InOutQuad
                duration: 250
            }
        }
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent

        onEntered: {
            showTimer.start()
            if (typeof mItem != 'undefined') {
                mItem.color = enterColor
            }
        }

        onExited: {
            showToolTip = false
            showTimer.stop()
            if (typeof mItem != 'undefined') {
                mItem.color = exitColor
            }
        }

        onClicked: clickFunc
    }

    Timer {
        id: showTimer
        interval: 250
        onTriggered: {
            showToolTip = true
        }
    }
}
