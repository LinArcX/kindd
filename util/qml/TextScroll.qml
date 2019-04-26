import QtQuick 2.9
import QtQuick.Controls 2.2


//    TextScroll{
//        mWidth: parent.width
//        mHeight: parent.height - imgSettings.height
//        mColor: CStr.transparent
//        mTop: imgSettings.bottom
//        mText: Str.settingsStrings
//    }
Rectangle {
    property int mWidth
    property int mHeight
    property variant mColor
    property variant mTop
    property variant mBottom
    property variant mRight
    property variant mLeft
    property string mText
    property variant mParent

    id: frame
    clip: true
    width: mWidth
    height: mHeight
    color: mColor
    anchors.top: mTop
    anchors.bottom: mBottom
    anchors.left: mLeft
    anchors.right: mRight

    Text {
        id: content
        padding: 10
        text: mText
        width: parent.width
        wrapMode: TextArea.Wrap
        font.pixelSize: 12
        x: -hbar.position * width
        y: -vbar.position * height
    }

    ScrollBar {
        id: vbar
        hoverEnabled: true
        active: hovered || pressed
        orientation: Qt.Vertical
        size: frame.height / content.height
        onHoveredChanged: active = true
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    ScrollBar {
        id: hbar
        hoverEnabled: true
        active: hovered || pressed
        orientation: Qt.Horizontal
        size: frame.width / content.width
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
}
