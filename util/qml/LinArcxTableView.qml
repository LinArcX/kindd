import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

Rectangle {
    id: root
    width: parent.parent.width
    height: parent.parent.height
    property alias mModel: qModel
    property string headerZero
    property string headerOne
    property string headerTwo
    property string headerThree
    property string headerFour
    property string headerFive
    property string headerSix
    property string headerSeven
    property string headerEight

    property string headerColor
    property string bodyColor
    property var headerHeight
    property var cellHeight
    property bool isHeaderVisible

    property int dataColumns
    property bool hasEditColumns
    property bool hasDeleteColumns

    property string gray: "#9E9E9E"
    property string orange: "#FF5722 "
    property string darkBlue: "#1976d2"
    property string white: "#FFFFFF"

    signal editCalled(var index, var obj)

    ListModel {
        id: qModel
    }

    ScrollView {
        width: parent.width - 5
        height: parent.height - 5
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded

        ListView {
            clip: true
            //anchors.top: parent.top
            //anchors.bottom: root.bottom
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            model: qModel

            header: Rectangle {
                id: mHeader
                width: root.width
                height: headerHeight ? headerHeight : 50
                visible: {
                    if (qModel.count > 0)
                        true
                    else
                        false
                }

                Rectangle {
                    id: hOne
                    width: root.width / 7
                    height: parent.height
                    anchors.left: parent.left
                    color: headerColor ? headerColor : darkBlue
                    visible: dataColumns >= 1 ? true : false

                    Label {
                        text: headerZero ? headerZero : "zero"
                        font.bold: true
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: hTwo
                    width: root.width / 7
                    height: parent.height
                    anchors.left: hOne.right
                    color: headerColor ? headerColor : darkBlue
                    visible: dataColumns >= 2 ? true : false

                    Label {
                        text: headerOne ? headerOne : "one"
                        font.bold: true
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: hThree
                    width: root.width / 7
                    height: parent.height
                    anchors.left: hTwo.right
                    color: headerColor ? headerColor : darkBlue
                    visible: dataColumns >= 3 ? true : false

                    Label {
                        text: headerTwo ? headerTwo : "two"
                        font.bold: true
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: hFour
                    width: root.width / 7
                    height: parent.height
                    anchors.left: hThree.right
                    color: headerColor ? headerColor : darkBlue
                    visible: dataColumns >= 4 ? true : false

                    Label {
                        text: headerThree ? headerThree : "three"
                        font.bold: true
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: hFive
                    width: root.width / 7
                    height: parent.height
                    anchors.left: hFour.right
                    color: headerColor ? headerColor : darkBlue
                    visible: dataColumns >= 5 ? true : false

                    Label {
                        text: headerFour ? headerFour : "four"
                        font.bold: true
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: hSix
                    width: root.width / 7
                    height: parent.height
                    anchors.left: hFive.right
                    color: headerColor ? headerColor : darkBlue
                    visible: dataColumns >= 6 ? true : false

                    Label {
                        text: headerFive ? headerFive : "five"
                        font.bold: true
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: hSeven
                    width: root.width / 7
                    height: parent.height
                    anchors.left: hSix.right
                    color: headerColor ? headerColor : darkBlue
                    visible: dataColumns >= 7 ? true : false

                    Label {
                        text: headerSix ? headerSix : "six"
                        font.bold: true
                        font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            delegate: ItemDelegate {
                id: mParent
                width: parent.width
                height: cellHeight ? cellHeight : 40

                Rectangle {
                    id: firstItem
                    anchors.left: parent.left
                    width: parent.width / 7
                    height: parent.height
                    color: bodyColor ? bodyColor : white
                    visible: dataColumns >= 1 ? true : false

                    Label {
                        text: dataColumns >= 1 ? zero : ""
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        width: parent.width
                        height: 1
                        anchors.bottom: parent.bottom
                        Rectangle {
                            anchors.fill: parent
                            color: gray
                        }
                    }
                }

                Rectangle {
                    id: secondItem
                    anchors.left: firstItem.right
                    width: parent.width / 7
                    height: parent.height
                    color: bodyColor ? bodyColor : white
                    visible: dataColumns >= 2 ? true : false

                    Label {
                        text: dataColumns >= 2 ? one : ""
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        width: parent.width
                        height: 1
                        anchors.bottom: parent.bottom
                        Rectangle {
                            anchors.fill: parent
                            color: gray
                        }
                    }
                }

                Rectangle {
                    id: thirdItem
                    anchors.left: secondItem.right
                    width: parent.width / 7
                    height: parent.height
                    color: bodyColor ? bodyColor : white
                    visible: dataColumns >= 3 ? true : false

                    Label {
                        text: dataColumns >= 3 ? two : ""
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        width: parent.width
                        height: 1
                        anchors.bottom: parent.bottom
                        Rectangle {
                            anchors.fill: parent
                            color: gray
                        }
                    }
                }

                Rectangle {
                    id: fourthItem
                    anchors.left: thirdItem.right
                    width: parent.width / 7
                    height: parent.height
                    color: bodyColor ? bodyColor : white
                    visible: dataColumns >= 4 ? true : false

                    Label {
                        enabled: dataColumns >= 4 ? true : false
                        text: dataColumns >= 4 ? three : ""
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        width: parent.width
                        height: 1
                        anchors.bottom: parent.bottom
                        Rectangle {
                            anchors.fill: parent
                            color: gray
                        }
                    }
                }

                Rectangle {
                    id: fifthItem
                    anchors.left: fourthItem.right
                    width: parent.width / 7
                    height: parent.height
                    color: bodyColor ? bodyColor : white
                    visible: dataColumns >= 5 ? true : false

                    Label {
                        enabled: dataColumns >= 5 ? true : false
                        text: dataColumns >= 5 ? four : ""
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        width: parent.width
                        height: 1
                        anchors.bottom: parent.bottom
                        Rectangle {
                            anchors.fill: parent
                            color: gray
                        }
                    }
                }

                Rectangle {
                    id: sixthItem
                    anchors.left: fifthItem.right
                    width: parent.width / 7
                    height: parent.height
                    color: bodyColor ? bodyColor : white
                    visible: dataColumns >= 6 ? true : false

                    Label {
                        enabled: dataColumns >= 6 ? true : false
                        text: dataColumns >= 6 ? five : ""
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        width: parent.width
                        height: 1
                        anchors.bottom: parent.bottom
                        Rectangle {
                            anchors.fill: parent
                            color: gray
                        }
                    }
                }

                Rectangle {
                    id: sevenItem
                    anchors.left: sixthItem.right
                    width: parent.width / 7
                    height: parent.height
                    color: bodyColor ? bodyColor : white
                    visible: dataColumns >= 7 ? true : false

                    Label {
                        enabled: dataColumns >= 7 ? true : false
                        text:{
                            if (dataColumns >= 7){
                                if(six != undefined)
                                    six
                                else
                                    ""
                            }else{
                                ""
                            }
                        }
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        width: parent.width
                        height: 1
                        anchors.bottom: parent.bottom
                        Rectangle {
                            anchors.fill: parent
                            color: gray
                        }
                    }
                }
            }
        }
    }
}
