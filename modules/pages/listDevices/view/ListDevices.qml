import QtQuick 2.11
import QtQuick.Controls 2.4
import linarcx.kindd.ListDevices 1.0

import "qrc:/components/qml/"

Page {
    width: qWindow.width
    height: qWindow.height

    ListDevices{
       id: mListDevices
    }

    Component.onCompleted: {
        mListDevices.execListDevices()
    }

    LinArcxTableView {
        id: qTableBuildlings
        width: parent.width
        anchors.top: parent.top
        anchors.topMargin: 10
        headerColor: "#FF5722"

        dataColumns: 7
        headerZero: "name"
        headerOne: "maj/min"
        headerTwo: "RM"
        headerThree: "Size"
        headerFour: "RO"
        headerFive: "Type"
        headerSix: "MountPoint"

        Connections {
            target: qTableBuildlings
        }
    }

    Connections {
        target: mListDevices
        onModelReady: {
            for (var i = 0; i < model.length; i++) {
                qTableBuildlings.mModel.append({
                                                   "zero": model[i][0],
                                                   "one": model[i][1],
                                                   "two": model[i][2],
                                                   "three": model[i][3],
                                                   "four": model[i][4],
                                                   "five": model[i][5],
                                                   "six": model[i][6]
                                               })
            }
        }
    }
}
