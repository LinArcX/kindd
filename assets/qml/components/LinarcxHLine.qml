import QtQuick 2.11
import QtQuick.Controls 2.2

Rectangle {
    property string header
    property string lineColor
    property string textColor
    property int lineWidth
    property int lineHeight
    property int textMargin
    property string imgPath
    property string qFont
    width: parent.width
    height: txtHeader.height + line.height
    color: "transparent"

    Image {
        source: imgPath
        visible: imgPath ? true : false
        anchors.bottom: line.top
        anchors.bottomMargin: textMargin ? textMargin : 5
        anchors.right: line.right
        sourceSize.width: txtHeader.height * 3 / 2
        sourceSize.height: txtHeader.height * 3 / 2
    }

    Text {
        id: txtHeader
        text: header ? header : ""
        anchors.bottom: line.top
        anchors.bottomMargin: textMargin ? textMargin : 5
        anchors.left: line.left
        anchors.leftMargin: 10
        color: textColor ? textColor : "#636363"
//        font.family: qFont ? qFont : ""
    }

    Rectangle {
        id: line
        width: lineWidth ? lineWidth : parent.width - 20
//        anchors.horizontalCenter: parent.horizontalCenter
        height: lineHeight ? lineHeight : 0.9
        color: lineColor ? lineColor : "#bfbfbf"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 10
    }
}
