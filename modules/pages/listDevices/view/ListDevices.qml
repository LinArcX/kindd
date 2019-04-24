import QtQuick 2.11
import QtQuick.Controls 2.4
import linarcx.kindd.ListDevices 1.0

import "qrc:/util/"

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
        headerOne: "name"
        headerTwo: "maj/min"
        headerThree: "RM"
        headerFour: "Size"
        headerFive: "RO"
        headerSix: "Type"
        headerSeven: "MountPoint"

        Connections {
            target: qTableBuildlings
        }
    }

    Connections {
        target: mListDevices
        onModelReady: {
            for (var i = 0; i < model.length; i++) {
                qTableBuildlings.mModel.append({
                                                   "one": model[i][0],
                                                   "two": model[i][1],
                                                   "three": model[i][2],
                                                   "four": model[i][3],
                                                   "five": model[i][4],
                                                   "six": model[i][5],
                                                   "seven": model[i][6]
                                               })
            }
        }
    }
}
