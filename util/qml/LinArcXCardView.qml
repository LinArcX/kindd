import QtQuick 2.11
import QtGraphicalEffects 1.0

Rectangle {
    property int widthOffset
    property int heightOffset
    property int mRadius
    property int borderWidth
    property variant borderColor
    property int shadowHOff
    property int shadowVOff
    property int shadowRadius

    width: widthOffset ? parent.width - widthOffset : parent.width - 20
    height: heightOffset ? parent.height / heightOffset : parent.height / 3
    radius: mRadius ? mRadius : 4
    antialiasing: true
    anchors.horizontalCenter: parent.horizontalCenter
    layer.enabled: true
    layer.effect: DropShadow {
        smooth: true
        radius: shadowRadius ? shadowRadius : 10.0
        color: "#80000000"
        transparentBorder: true
        horizontalOffset: shadowHOff ? shadowHOff : 4
        verticalOffset: shadowVOff ? shadowVOff : 4
        samples: 20
        cached: true
    }
    border {
        width: borderWidth ? borderWidth : 1
        color: borderColor ? borderColor : "#9E9E9E"
    }
}
