import QtQuick 2.11
import QtQuick.Controls 2.4

import "qrc:/strings/CoreStrings.js" as CStr

Rectangle {
    id: qRectItem
    anchors.verticalCenter: parent.verticalCenter

    property string mTitle
    property string mImage
    property bool isHeader
    property bool imageOnly

    Image {
        id: qImage
        source: mImage ? mImage : ""
        sourceSize.height: isHeader ? parent.parent.height / 3 * 2 : parent.parent.height / 3 * 1
        sourceSize.width: isHeader ? parent.parent.height / 3 * 2 : parent.parent.height / 3 * 1
        anchors.verticalCenter: parent.verticalCenter
        Component.onCompleted: {
            if (imageOnly) {
                qRectItem.anchors.horizontalCenter = parent.parent.horizontalCenter
                anchors.horizontalCenter = parent.horizontalCenter
            } else {
                anchors.left = parent.left
                anchors.leftMargin = isHeader ? 3 : 7
            }
        }
    }

    Text {
        color: "white"
        text: mTitle ? mTitle : "none"
        font.pixelSize: isHeader ? 10 : 9
        width: mScrollView.width - (qImage.width + 10)
        wrapMode: TextArea.Wrap
        anchors.left: qImage.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        visible: imageOnly ? false : true
    }

    //    ScrollView {
    //        id: mScrollVieww
    //        clip: true
    //        width: parent.parent.width - qImage.width
    //        height: parent.parent.height
    //        padding: 10
    //        anchors.left: qImage.right
    //        anchors.top: qImage.top
    //        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
    //        ScrollBar.horizontal.policy: ScrollBar.AsNeeded
    //        ScrollBar.horizontal.interactive: false
    //        ScrollBar.vertical.interactive: false
    //        // anchors.verticalCenter: parent.verticalCenter
    //        //anchors.leftMargin: 5
    //        //        ScrollBar.vertical.interactive: true
    //        //        ScrollBar.horizontal.interactive: true
    //    }
}
