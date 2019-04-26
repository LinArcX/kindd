import QtQuick 2.11
import QtQuick.Controls 2.4
import linarcx.kindd.CreateISO 1.0
import linarcx.kindd.ListDevices 1.0
import linarcx.kindd.Settings 1.0

import "qrc:/components/qml/"

Page {
    id: qPageCreateIso
    width: qWindow.width
    height: btnCreateISO.height + txtKindd.height + qScrollView.height + imgDone.height + txtCong.height + 40

    property var isoPath
    property var outputPath

    ListDevices{
       id: mListDevices
    }

    CreateISO{
       id: mCreateISO
    }

    Settings{
        id: qSettings
    }

    FontLoader {
        id: mFont
        source: "qrc:/fonts/Amatic.ttf"
    }

    Text {
        id: txtKindd
        text: qsTr("A Kindful dd gui written in qt quick :)")
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 25
        font.family: mFont.name
        anchors.verticalCenter: imgKindd.verticalCenter
    }

    Image {
        id: imgKindd
        source: "qrc:/images/kindd.svg"
        sourceSize.width: 60
        sourceSize.height: 60
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: txtKindd.left
        anchors.rightMargin: 5
    }

    ScrollView {
        id: qScrollView
        width: parent.width - 5
        height: chooseByteSizeHeader.height + txtBlockSize.height + cmbSizeType.height + chooseIso.height + qBtnOpenIsoDialog.height + chooseTargetPath.height + cmbTargetPath.height
        anchors.top: imgKindd.bottom
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded

        LinArcXHLine {
            id: chooseByteSizeHeader
            header: "1. Choose Block Size"
            anchors.top: parent.top
            anchors.topMargin: 10
        }

        TextField {
            id: txtBlockSize
            placeholderText: "Enter Block Size"
            anchors.top: chooseByteSizeHeader.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        ComboBox {
            id: cmbSizeType
            model: ["K", "M"]
            anchors.left: txtBlockSize.right
            anchors.leftMargin: 5
            anchors.top: txtBlockSize.top
            currentIndex: 1
            width: txtBlockSize.width
        }

        LinArcXHLine {
            id: chooseIso
            header: "2. Choose Input file(.iso, ...)"
            anchors.top: txtBlockSize.bottom
            anchors.topMargin: 20
        }

        Button {
            id: qBtnOpenIsoDialog
            text: "input file"
            anchors.top: chooseIso.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
            onClicked: qIsoDialog.open()
            width: txtBlockSize.width
        }

        Label{
            id: lblIsoPath
            visible: false
            anchors.verticalCenter: qBtnOpenIsoDialog.verticalCenter
            anchors.left: qBtnOpenIsoDialog.right
            anchors.leftMargin: 5
        }

        LinArcXHLine {
            id: chooseTargetPath
            header: "3. Choose Target Path"
            anchors.top: lblIsoPath.bottom
            anchors.topMargin: 20
        }

        ComboBox {
            id: cmbTargetPath
            anchors.top: chooseTargetPath.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
            width: txtBlockSize.width
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
        qSettings.loadBlockSize()
    }

    Connections{
        target: qSettings
        onBlockSizeReady:{
           txtBlockSize.text = blockSize
        }
    }

    Connections {
        target: mListDevices
        onModelReady: {
            model.reverse()
            for (var i = 0; i < model.length; i++) {
                if(model[i][6] != undefined)
                    cmbTargetPath.model.append({"text": model[i][0] + ": " + model[i][6]})
                else
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
        anchors.top: qScrollView.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
    }

    ProgressBar {
        id: pgBar
        indeterminate: true
        anchors.top: txtProgress.bottom
        anchors.topMargin: 20
        visible: false
        width: btnCreateISO.width
        anchors.horizontalCenter: parent.horizontalCenter
     }

    Image {
        id: imgDone
        anchors.top: qScrollView.bottom
        anchors.topMargin: 20
        source: "qrc:/images/done.svg"
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        sourceSize.width: 60
        sourceSize.height: 60
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
        anchors.top: imgDone.bottom
        anchors.topMargin: 10
        font.pixelSize: 14
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        color: "green"
    }

    Button{
        id: btnCreateISO
        text: "Convert/Copy!"
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width / 3
        anchors.top: pgBar.bottom
        anchors.topMargin: 10
        enabled: lblIsoPath.text != "" && txtBlockSize.text != "" ? true : false
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
                mCreateISO.execCreateISO(lblIsoPath.text, cmbTargetPath.currentText, txtBlockSize.text, cmbSizeType.currentText)
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
