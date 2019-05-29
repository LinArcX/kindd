import QtQuick 2.9

Rectangle {
    id: qTooTip
    // Mandatory
    property var mother
    property int direction
    property string title

    // Optional
    property int mWidth
    property int mHeight
    property string mColor
    property bool isItalic
    property bool isBold
    property int mPixelSize

    visible: false
    color: mColor ? mColor : "#9E9E9E"
    width: mWidth ? mWidth : qTitleToolTip.width
    height: mHeight ? mHeight : qTitleToolTip.height

    Text {
        id: qTitleToolTip
        text: title ? title : "Title"
        font.pixelSize: mPixelSize ? mPixelSize : 12
        font.italic: isItalic ? isItalic : true
        font.bold: isBold ? isBold : false
    }

    Component.onCompleted: {
        if (direction == 0) { // top-left
            qTooTip.anchors.top = mother.top
            qTooTip.anchors.topMargin = -mother.height
            qTooTip.anchors.right = mother.right
            qTooTip.anchors.rightMargin = mother.width
        } else if (direction == 1) { // top
            qTooTip.anchors.top = mother.top
            qTooTip.anchors.topMargin = -mother.height
            qTooTip.anchors.horizontalCenter = mother.horizontalCenter
        } else if (direction == 2) { // top-right
            qTooTip.anchors.top = mother.top
            qTooTip.anchors.topMargin = -mother.height
            qTooTip.anchors.left = mother.left
            qTooTip.anchors.leftMargin = mother.width
        } else if (direction == 3) { // right
            qTooTip.anchors.right = mother.right
            qTooTip.anchors.rightMargin = -qTitleToolTip.width - 5
            qTooTip.anchors.verticalCenter = mother.verticalCenter
        } else if (direction == 4) { // right-bottom
            qTooTip.anchors.bottom = mother.bottom
            qTooTip.anchors.bottomMargin = -mother.height
            qTooTip.anchors.left = mother.left
            qTooTip.anchors.leftMargin = mother.width
        } else if (direction == 5) { // bottom

        } else if (direction == 6) { // bottom-left

        } else if (direction == 7) { // left
            qTooTip.anchors.left = mother.left
            qTooTip.anchors.leftMargin = -qTitleToolTip.width - 5
            qTooTip.anchors.verticalCenter = mother.verticalCenter
        }
    }
}
