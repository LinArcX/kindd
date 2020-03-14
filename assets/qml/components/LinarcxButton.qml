import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.impl 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Controls.Material.impl 2.4
import QtQuick.Templates 2.4 as T

T.Button {
    id: control

    property string iconFamily
    property string iconName
    property int iconSize
    property int textSize
    property string iconMargin
    property string btnTxt
    property string mTextMargin
    property string mTextSize
    property string qColor
    property string qTextColor

    leftPadding: padding + 2
    rightPadding: padding + 2
    implicitWidth: mContentItem.width + leftPadding + rightPadding
    implicitHeight: mContentItem.height + topPadding + bottomPadding

    Material.background: flat ? "transparent" : undefined
    Material.elevation: 3 // flat ? control.down || control.hovered ? 3 : 0 : control.down ? 8 : 2

    Rectangle {
        id: mParent
        anchors.fill: parent
        clip: true
        color: control.enabled ? qColor: control.Material.buttonDisabledColor
        opacity: control.enabled ? 1 : 0.5

        Rectangle {
            id: mContentItem
            anchors.centerIn: parent
            width: mText.width + mIcon.width + 20
            height: mText.height + 20
            color: qColor
            clip: true

            Text {
                id: mText
                anchors.right: mIcon.left
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: textSize ? textSize : 15
                color: qTextColor ? qTextColor : "white"
                text: btnTxt
                clip: true
            }

            Text {
                id: mIcon
                font.family: iconFamily
                text: iconName
                anchors.right: parent.right
                anchors.rightMargin: iconMargin ? iconMargin : 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: iconSize ? iconSize : 18
                color: qTextColor ? qTextColor : "white"
            }
        }
    }

    // The layer is disabled when the button color is transparent so you can do
    // Material.background: "transparent" and get a proper flat button without needing
    // to set Material.elevation as well
    layer.enabled: control.enabled && control.Material.buttonColor.a > 0
    layer.effect: ElevationEffect {
        elevation: control.Material.elevation
    }

    Ripple {
        clipRadius: 3
        width: mParent.width
        height: mParent.height
        pressed: control.pressed
        anchor: control
        active: control.down || control.visualFocus || control.hovered
        color: control.Material.rippleColor
    }
}
