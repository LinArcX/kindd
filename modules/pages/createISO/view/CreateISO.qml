import QtQuick 2.11
import QtQuick.Controls 2.4
import linarcx.kindd.CreateISO 1.0
import linarcx.kindd.Settings 1.0
import QtMultimedia 5.8

import "qrc:/components/qml/"
import "qrc:/components/js/Constants.js" as CONS

Page {
    id: qPageCreateIso
    property var isoPath
    property var outputPath
    property var dev

    CreateISO {
        id: mCreateISO
    }

    Settings {
        id: qSettings
    }

    FontLoader {
        id: mFont
        source: "qrc:/fonts/Amatic.ttf"
    }

    SoundEffect {
        id: sndPlug
        source: "qrc:/sounds/plug.wav"
    }

    SoundEffect {
        id: sndUnPlug
        source: "qrc:/sounds/unplug.wav"
    }

    //----------------- Popup ------------------//
    LinArcxPopUp {
        id: mPopUp
        mImage: "qrc:/images/warning.svg"
        mTitle: qsTr("Are you sure to continue?")

        Button {
            id: btnYes
            anchors.centerIn: parent
            text: "Yes, i'm sure"
            onClicked: {
                mPopUp.close()
                pgBar.visible = true
                txtProgress.visible = true
                btnCreateISO.enabled = false
                mCreateISO.execCreateISO(lblIsoPath.mText,
                                         cmbTargetPath.currentText,
                                         txtBlockSize.text,
                                         cmbSizeType.currentText)
            }
        }

        Button {
            anchors.top: btnYes.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: btnYes.horizontalCenter
            width: btnYes.width
            text: "No"
            onClicked: {
                mPopUp.close()
            }
        }
    }

    //----------------- File Chooser ------------------//
    LinArcxDialog {
        id: qIsoDialog
        parent: qWindow.overlay
        showHidden: false
        nameFilters: ["*.iso"]
        onFileSelected: {
            isoPath = currentFolder() + "/" + fileName
            lblIsoPath.mText = isoPath
            lblIsoPath.visible = true
            console.log("You choose: " + isoPath)
            qIsoDialog.close()
        }
        //        showDotAndDotDot: true
        // mFolder: shortcuts.pictures
        // QStandardPaths::writableLocation(QStandardPaths::PicturesLocation)
    }

    //----------------- Header ------------------//
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

    //----------------- Content ------------------//
    ScrollView {
        id: qScrollView
        width: parent.width
        anchors.top: imgKindd.bottom
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded

        LinArcXHLine {
            id: chooseByteSizeHeader
            header: "1. Choose Block Size"
            anchors.top: parent.top
            anchors.topMargin: 10
            qLeftMargin: 25
        }

        Image {
            id: qWarningBlockSize
            source: "qrc:/images/warning.svg"
            sourceSize.height: 15
            sourceSize.width: 15
            anchors.verticalCenter: txtBlockSize.verticalCenter
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            visible: false
        }

        TextField {
            id: txtBlockSize
            placeholderText: "Enter Block Size"
            anchors.left: qWarningBlockSize.right
            anchors.leftMargin: 5
            anchors.top: chooseByteSizeHeader.bottom
            anchors.topMargin: 10
            onTextChanged: {
                if (txtBlockSize.text == "")
                    qWarningBlockSize.visible = true
                else
                    qWarningBlockSize.visible = false
            }
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
            header: "2. Choose Input .iso file"
            anchors.top: txtBlockSize.bottom
            anchors.topMargin: 30
            qLeftMargin: 25
        }

        Image {
            id: qWarningOpenIso
            source: "qrc:/images/warning.svg"
            sourceSize.height: 15
            sourceSize.width: 15
            anchors.verticalCenter: qBtnOpenIsoDialog.verticalCenter
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            visible: true
        }

        Button {
            id: qBtnOpenIsoDialog
            text: "Input .iso file"
            anchors.top: chooseIso.bottom
            anchors.topMargin: 10
            anchors.left: qWarningBlockSize.right
            anchors.leftMargin: 5
            onClicked: qIsoDialog.open()
            width: txtBlockSize.width
        }

        LinarcxLabel {
            id: lblIsoPath
            visible: false
            anchors.top: qBtnOpenIsoDialog.bottom
            anchors.topMargin: 10
            anchors.left: qBtnOpenIsoDialog.left
            onVisibleChanged: {
                if (lblIsoPath.visible) {
                    qWarningOpenIso.visible = false
                } else {
                    qWarningOpenIso.visible = true
                }
            }
        }

        LinArcXHLine {
            id: chooseTargetPath
            header: "3. Choose Target Path"
            anchors.top: lblIsoPath.bottom
            anchors.topMargin: 10
            qLeftMargin: 25
        }

        Image {
            id: qWarningTargetPath
            source: "qrc:/images/warning.svg"
            sourceSize.height: 15
            sourceSize.width: 15
            anchors.verticalCenter: cmbTargetPath.verticalCenter
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            visible: false
        }

        ComboBox {
            id: cmbTargetPath
            anchors.top: chooseTargetPath.bottom
            anchors.topMargin: 10
            anchors.left: qWarningTargetPath.right
            anchors.leftMargin: 5
            width: txtBlockSize.width
            model: ListModel {
                id: model
            }

            Component.onCompleted: {
                if (cmbTargetPath.currentText == "") {
                    qWarningTargetPath.visible = true
                } else {
                    qWarningTargetPath.visible = false
                }
            }

            onCurrentTextChanged: {
                if (cmbTargetPath.currentText == "") {
                    qWarningTargetPath.visible = true
                } else {
                    qWarningTargetPath.visible = false
                }
            }
        }
    }

    Rectangle {
        id: qProcessDone
        color: CONS.green500
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 170
        height: 45
        radius: 15
        property int maxX: -20
        property int minX: -180

        visible: false

        Text {
            text: qsTr("Congratulation!")
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            font.pixelSize: 13
        }

        Image {
            source: "qrc:/images/done.svg"
            sourceSize.width: 30
            sourceSize.height: 30
            anchors.right: qProcessDone.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
        }

        SequentialAnimation on x {
            running: false
            id: seqAnimProcessDone
            NumberAnimation {
                from: qProcessDone.minX
                to: qProcessDone.maxX
                easing.type: Easing.OutExpo
                duration: 300
            }

            PauseAnimation {
                duration: 2000
            }

            NumberAnimation {
                from: qProcessDone.maxX
                to: qProcessDone.minX
                easing.type: Easing.OutQuad
                duration: 1000
            }
        }
    }

    Rectangle {
        id: qDeviceRemovedAlert
        color: CONS.orange400
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 170
        height: 45
        radius: 15
        property int maxX: -20
        property int minX: -180

        visible: false

        Text {
            text: qsTr(dev + " Removed!")
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            font.pixelSize: 13
        }

        Image {
            source: "qrc:/images/createISO.svg"
            sourceSize.width: 30
            sourceSize.height: 30
            anchors.right: qDeviceRemovedAlert.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
        }

        SequentialAnimation on x {
            running: false
            id: seqAnimDeviceRemoved

            NumberAnimation {
                from: qDeviceRemovedAlert.minX
                to: qDeviceRemovedAlert.maxX
                easing.type: Easing.OutExpo
                duration: 300
            }

            PauseAnimation {
                duration: 2000
            }

            NumberAnimation {
                from: qDeviceRemovedAlert.maxX
                to: qDeviceRemovedAlert.minX
                easing.type: Easing.OutQuad
                duration: 1000
            }
        }
    }

    Rectangle {
        id: qDeviceAddedAlert
        color: CONS.green500
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 170
        height: 45
        radius: 15
        property int maxX: -20
        property int minX: -180

        visible: false

        Text {
            text: qsTr(dev + " Added!")
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            font.pixelSize: 13
        }

        Image {
            source: "qrc:/images/createISO.svg"
            sourceSize.width: 30
            sourceSize.height: 30
            anchors.right: qDeviceAddedAlert.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
        }

        SequentialAnimation on x {
            running: false
            id: seqAnimDeviceAdded
            // Move from minHeight to maxHeight in 300ms, using the OutExpo easing function
            NumberAnimation {
                from: qDeviceAddedAlert.minX
                to: qDeviceAddedAlert.maxX
                easing.type: Easing.OutExpo
                duration: 300
            }

            // Then pause for 500ms
            PauseAnimation {
                duration: 2000
            }

            // Then move back to minHeight in 1 second, using the OutBounce easing function
            NumberAnimation {
                from: qDeviceAddedAlert.maxX
                to: qDeviceAddedAlert.minX
                easing.type: Easing.OutQuad
                duration: 1000
            }
        }
    }

    Rectangle {
        id: qActions
        anchors.bottom: parent.bottom
        width: parent.width
        height: txtProgress.height + pgBar.height + btnCreateISO.height + 20
        Component.onCompleted: qScrollView.height = qWindow.height - qActions.height

        Text {
            id: txtProgress
            anchors.bottom: pgBar.top
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }

        ProgressBar {
            id: pgBar
            indeterminate: true
            anchors.bottom: btnCreateISO.top
            anchors.bottomMargin: 10
            visible: false
            width: btnCreateISO.width / 2
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            id: btnCreateISO
            text: "Convert/Copy!"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: parent.width
            height: 40
            enabled: {
                !qWarningBlockSize.visible && !qWarningOpenIso.visible
                        && !qWarningTargetPath.visible ? true : false
            }
            onClicked: {
                mPopUp.open()
            }
        }
    }

    Connections {
        target: qSettings
        onBlockSizeReady: {
            txtBlockSize.text = blockSize
        }
    }

    Connections {
        target: mCreateISO
        onDataReady: {
            txtProgress.text = data
            console.log(data)
        }
        onErrorReady: {
            txtProgress.text = error
            console.log(error)
        }
        onFinished: {
            txtProgress.text = finished
            console.log(finished)
            txtProgress.visible = false
            pgBar.visible = false
            qProcessDone.visible = true
            seqAnimProcessDone.start()
        }
        onModelReady: {
            cmbTargetPath.model.clear()
            if (Object.keys(model).length == 0) {
                console.log("model is empty")
            } else {
                for (var i = 0; i < model.length; i++) {
                    cmbTargetPath.model.append({
                                                   "text": model[i]
                                               })
                }
                cmbTargetPath.currentIndex = 0
            }
        }

        onDeviceAdded: {
            dev = data
            qDeviceAddedAlert.visible = true
            seqAnimDeviceAdded.start()
            sndPlug.play()
        }

        onDeviceRemoved: {
            dev = data
            qDeviceRemovedAlert.visible = true
            seqAnimDeviceRemoved.start()
            sndUnPlug.play()
        }

        onModelChangedReady: {
            cmbTargetPath.model.clear()
            if (Object.keys(model).length == 0) {
                console.log("model is empty")
            } else {
                for (var i = 0; i < model.length; i++) {
                    cmbTargetPath.model.append({
                                                   "text": model[i]
                                               })
                }
                cmbTargetPath.currentIndex = 0
            }
        }
    }

    Component.onCompleted: {
        mCreateISO.execListDevices()
        qSettings.loadBlockSize()
    }
} //    LinarcxButton {//        id: btnDeviceAlert//        btnTxt: 'Device Added!'
//        qColor: CONS.green500
//        width: 150
//        height: 70
//        anchors.bottom: qActions.top
//        anchors.bottomMargin: 5
//        property int maxX: -10
//        property int minX: -150

//        SequentialAnimation on x {
//            running: false
//            id: seqAnimDeviceAdded
//            //            loops: Animation.Infinite
//            // Move from minHeight to maxHeight in 300ms, using the OutExpo easing function
//            NumberAnimation {
//                from: btnDeviceAlert.minX
//                to: btnDeviceAlert.maxX
//                easing.type: Easing.OutExpo
//                duration: 300
//            }

//            // Then pause for 500ms
//            PauseAnimation {
//                duration: 500
//            }

//            // Then move back to minHeight in 1 second, using the OutBounce easing function
//            NumberAnimation {
//                from: btnDeviceAlert.maxX
//                to: btnDeviceAlert.minX
//                easing.type: Easing.OutQuad
//                duration: 1000
//            }
//        }
//        //        iconFamily: Hack.family
//        //        iconName: Hack.nf_mdi_select
//        //        iconSize: 30
//    }

//    Rectangle {//        id: qTest//        //        anchors.top: parent.top//        //        anchors.left: parent.left//        //        z: 5//        width: 100//        height: 100//        color: "red"//        property int maxHeight: qWindow.width / 3
//        property int minHeight: -20

//        SequentialAnimation on x {
//            loops: Animation.Infinite

//            // Move from minHeight to maxHeight in 300ms, using the OutExpo easing function
//            NumberAnimation {
//                from: qTest.minHeight
//                to: qTest.maxHeight
//                easing.type: Easing.OutExpo
//                duration: 300
//            }

//            // Then move back to minHeight in 1 second, using the OutBounce easing function
//            NumberAnimation {
//                from: qTest.maxHeight
//                to: qTest.minHeight
//                easing.type: Easing.OutQuad
//                duration: 1000
//            }

//            // Then pause for 500ms
//            PauseAnimation {
//                duration: 500
//            }
//        }

//        //        states: State {
//        //            name: "moved"
//        //            PropertyChanges {
//        //                target: rect
//        //                x: 50
//        //            }
//        //        }

//        //        transitions: Transition {
//        //            PropertyAnimation {
//        //                properties: "x,y"
//        //                easing.type: Easing.InOutQuad
//        //            }
//        //        }

//        //        Behavior on x {
//        //            PropertyAnimation {
//        //            }
//        //        }

//        //        MouseArea {
//        //            anchors.fill: parent
//        //            onClicked: parent.x = 150
//        //        }
//    }

//                qDeviceAddAlert.state = "show"
//                qDeviceAddAlert.anchors.rightMargin = -10

//        states: [
//            State {
//                name: "show"
//                PropertyChanges {
//                    target: qDeviceAddAlert
//                    anchors.rightMargin: -10
//                }
//            },
//            State {
//                name: "hide"
//                PropertyChanges {
//                    target: qDeviceAddAlert
//                    anchors.rightMargin: -150
//                }
//            }
//        ]

//        transitions: Transition {
//            ScaleAnimator {
//                duration: 100
//            }
//        }

