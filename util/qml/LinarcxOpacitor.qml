import QtQuick 2.9

Item {
    anchors.fill: parent
    property variant mTarget
    property real initValue
    property real endValue

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            mTarget.opacity = endValue
        }
        onExited: {
            mTarget.opacity = initValue
        }
    }
}
