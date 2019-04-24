import QtQuick 2.11
import QtQuick.Controls 2.4
import linarcx.kindd.CreateISO 1.0
import linarcx.kindd.ListDevices 1.0

import "qrc:/util/"

Page {
    width: qWindow.width
    height: qWindow.height

    property var isoPath
    property var outputPath

    ListDevices{
       id: mListDevices
    }

    CreateISO{
       id: mCreateISO
    }

    FontLoader {
        id: mFont
        source: "qrc:/fonts/Amatic.ttf"
    }

    FontLoader {
        id: qFont
        source: "qrc:/fonts/Aller.ttf"
    }

    Text {
        id: txtKindd
        text: qsTr("A Kindflul dd gui written in qt quick :)")
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 30
        font.family: mFont.name
        anchors.verticalCenter: imgKindd.verticalCenter
    }

    Image {
        id: imgKindd
        source: "qrc:/images/kindd.svg"
        sourceSize.width: 80
        sourceSize.height: 80
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: txtKindd.left
        anchors.rightMargin: 10
    }

    ScrollView {
        id: qScrollView
        width: parent.width - 5
        height: parent.height - 5
        anchors.top: imgKindd.bottom
        anchors.topMargin: 30
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded

        LinArcXHLine {
            id: chooseByteSizeHeader
            header: "1. Choose Byte Size"
            anchors.top: parent.top
            qFont: qFont.name
        }

        TextField {
            id: txtByteSize
            placeholderText: "Enter Byte Size"
            anchors.top: chooseByteSizeHeader.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
        }

        ComboBox {
            id: cmbSizeType
            model: ["K", "M"]
            anchors.left: txtByteSize.right
            anchors.leftMargin: 10
            anchors.top: txtByteSize.top
            currentIndex: 1
            width: txtByteSize.width
        }

        LinArcXHLine {
            id: chooseIso
            header: "2. Choose Input file(.iso, ...)"
            anchors.top: txtByteSize.bottom
            anchors.topMargin: 30
            qFont: qFont.name
        }

        Button {
            id: qBtnOpenIsoDialog
            text: "input file"
            anchors.top: chooseIso.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            onClicked: qIsoDialog.open()
            width: txtByteSize.width
        }

        Label{
            id: lblIsoPath
            visible: false
            anchors.verticalCenter: qBtnOpenIsoDialog.verticalCenter
            anchors.left: qBtnOpenIsoDialog.right
            anchors.leftMargin: 10
        }

        LinArcXHLine {
            id: chooseTargetPath
            header: "3. Choose Target Path"
            anchors.top: lblIsoPath.bottom
            anchors.topMargin: 30
            qFont: qFont.name
        }

        ComboBox {
            id: cmbTargetPath
            anchors.top: chooseTargetPath.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: txtByteSize.width
            model: ListModel {
              id: model
            }
        }
    }

    LinArcxDialog {
        id: qIsoDialog
        parent: qWindow.overlay
        showDotAndDotDot: true
        // mFolder: shortcuts.pictures
        // QStandardPaths::writableLocation(QStandardPaths::PicturesLocation)
        nameFilters: ["*.iso"]
        onFileSelected: {
            isoPath = currentFolder() + "/" + fileName
            lblIsoPath.text = isoPath
            lblIsoPath.visible = true
            console.log("You choose: " + isoPath)
            qIsoDialog.close()
        }
    }

    Component.onCompleted: {
        mListDevices.execListDevices()
    }

    Connections {
        target: mListDevices
        onModelReady: {
            model.reverse()
            for (var i = 0; i < model.length; i++) {
                cmbTargetPath.model.append({"text": model[i][0]})
            }
            cmbTargetPath.currentIndex = 0
        }
    }

    Connections{
        target: mCreateISO
        onDataReady: {
            txtProgress.text = data
            console.log(data)
        }
        onErrorReady: {
            txtProgress.text = error
            console.log(error)
        }
        onFinished:{
            txtProgress.text = finished
            console.log(finished)
            txtProgress.visible = false
            pgBar.visible = false
            imgDone.visible = true
            txtCong.visible = true
            lblIsoPath.text = ""
        }
    }

    Text {
        id: txtProgress
        anchors.bottom: pgBar.top
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
    }

    ProgressBar {
        id: pgBar
        indeterminate: true
        anchors.bottom: btnCreateISO.top
        anchors.bottomMargin: 20
        visible: false
        width: btnCreateISO.width
        anchors.horizontalCenter: parent.horizontalCenter
     }

    Image {
        id: imgDone
        source: "qrc:/images/done.svg"
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        sourceSize.width: 60
        sourceSize.height: 60
        anchors.bottom: txtCong.top
        anchors.bottomMargin: 5
        MouseArea{
            anchors.fill: parent
            onClicked: {
                //btnCreateISO.enabled = true
                imgDone.visible = false
                txtCong.visible = false
            }
        }
    }

    Text {
        id: txtCong
        text: qsTr("congratulation! To restart, click on 'done' button :)")
        anchors.bottom: btnCreateISO.top
        anchors.bottomMargin: 10
        font.pixelSize: 14
        visible: false
        font.family: qFont.name
        anchors.horizontalCenter: parent.horizontalCenter
        color: "green"
    }

    Button{
        id: btnCreateISO
        text: "Convert/Copy!"
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width / 3
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        enabled: lblIsoPath.text != "" && txtByteSize.text != "" ? true : false
        onClicked: {
            mPopUp.open()
        }
    }

    ////// Popup
    LinArcxPopUp {
        id: mPopUp
        mImage: "qrc:/images/warning.svg"
        mTitle: qsTr("Are you sure to continue?")

        Button{
            id: btnYes
            anchors.centerIn: parent
            text: "Yes, i'm sure"
            onClicked:{
                mPopUp.close()
                pgBar.visible = true
                txtProgress.visible = true
                btnCreateISO.enabled = false
                mCreateISO.execCreateISO(lblIsoPath.text, cmbTargetPath.currentText, txtByteSize.text, cmbSizeType.currentText)
            }
        }

        Button{
            anchors.top: btnYes.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: btnYes.horizontalCenter
            width: btnYes.width
            text: "No"
            onClicked:{
                mPopUp.close()
            }
        }
    }
}
