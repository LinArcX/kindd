import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import linarcx.kindd.Settings 1.0

import "qrc:/components/qml"
import "qrc:/components/js/ElementCreator.js" as JS
import "qrc:/strings/CoreStrings.js" as CStr
import "qrc:/strings/SettingsStrings.js" as Str

Page {
    id: mSettingsContent
    width: qWindow.width
    height: qWindow.height

    property variant mySettings: ({

                                  })
    Settings {
        id: mSettings
    }

    Component.onCompleted: {
        mSettings.loadBlockSize()
        pageSettingsCompleted(mSettingsContent.height)
        lblCurrentBlockSize.text = sldBlockSize.value
    }

    Connections {
        target: mSettings
        onBlockSizeReady: {
            sldBlockSize.value = blockSize
        }
    }

    Button {
        id: btnSave
        text: CStr.save
        width: btnDefaults.width

        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20

        onClicked: {
            mySettings.fontFamily = cbFontFamily.currentText
            mySettings.fontSize = cbFontSize.currentText
            mySettings.style = cbStyle.currentText
            mySettings.blockSize = sldBlockSize.value
            mSettings.setSettings(mySettings)

            var mDialog = mDialogChangeSettings.createObject(mSettingsContent)
            mDialog.open()
        }
    }

    Button {
        id: btnDefaults
        text: CStr.defaults
        anchors.left: btnSave.right
        anchors.bottom: btnSave.bottom
        anchors.leftMargin: 20
        onClicked: {
            var mDialog = mDialogResetSettings.createObject(mSettingsContent)
            mDialog.open()
        }
    }

    ScrollView {
        id: svSettings
        width: parent.width - 5
        //        height: paletteHeader.height + cbStyle.height
        //                + fontFamilyHeader.height + cbFontFamily.height + fontSizeHeader.height
        //                + cbFontSize.height
        anchors.top: btnDefaults.bottom
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded

        LinArcXHLine {
            id: paletteHeader
            header: "Style"
            anchors.top: parent.top
            anchors.topMargin: 20
            imgPath: CStr.imgPalette
            width: parent.width / 2 - 20
            lineWidth: parent.width / 2 - 20
        }

        ComboBox {
            id: cbStyle
            width: parent.width / 2 - 20
            anchors.margins: 5
            anchors.top: paletteHeader.bottom
            anchors.topMargin: 5
            anchors.left: parent.left
            z: -1
            Component.onCompleted: {
                JS.createCombo(mSettings.appStyles(),
                               mSettings.appStyleIndex(), svSettings, cbStyle)
            }
        }

        LinArcXHLine {
            id: fontFamilyHeader
            header: "Font Family"
            width: parent.width / 2 - 20
            lineWidth: parent.width / 2 - 20
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.left: paletteHeader.right
            anchors.leftMargin: 10
            imgPath: CStr.imgText
        }

        ComboBox {
            id: cbFontFamily
            anchors.margins: 5
            width: parent.width / 2 - 20
            anchors.left: fontFamilyHeader.left
            anchors.top: fontFamilyHeader.bottom
            anchors.topMargin: 5
            anchors.leftMargin: 10
            z: -1
            Component.onCompleted: {
                JS.createCombo(mSettings.fontFamilies(),
                               mSettings.fontFamilyIndex(), svSettings,
                               cbFontFamily)
            }
        }

        LinArcXHLine {
            id: fontSizeHeader
            header: "Font Size"
            anchors.top: cbStyle.bottom
            anchors.topMargin: 20
            imgPath: CStr.imgFontSize
            width: parent.width / 2 - 20
            lineWidth: parent.width / 2 - 20
        }

        ComboBox {
            id: cbFontSize
            width: parent.width / 2 - 20
            anchors.margins: 5
            anchors.left: parent.left
            anchors.top: fontSizeHeader.bottom
            anchors.topMargin: 5
            z: -1
            Component.onCompleted: {
                JS.createCombo(mSettings.fontSizes(),
                               mSettings.fontSizeIndex(), svSettings,
                               cbFontSize)
            }
        }

        LinArcXHLine {
            id: bsHeader
            header: "Block Size"
            anchors.top: cbFontFamily.bottom
            anchors.topMargin: 20
            anchors.left: fontFamilyHeader.left
            imgPath: CStr.imgBlockSize
            width: parent.width / 2 - 20
            lineWidth: parent.width / 2 - 20
        }

        Slider {
            id: sldBlockSize
            from: 1
            to: 100
            value: 10
            stepSize: 1
            width: parent.width / 2 - 20
            anchors.leftMargin: 10
            anchors.left: bsHeader.left
            anchors.top: bsHeader.bottom
            anchors.topMargin: 5
            onXChanged: lblCurrentBlockSize.x = sldBlockSize.visualPosition
                        * sldBlockSize.width + sldBlockSize.x
            onMoved: {
                lblCurrentBlockSize.text = sldBlockSize.value
                lblCurrentBlockSize.x = sldBlockSize.visualPosition
                        * sldBlockSize.width + sldBlockSize.x
            }
        }

        Text {
            id: lblCurrentBlockSize
            anchors.top: sldBlockSize.bottom
            anchors.topMargin: 5
        }
    }

    Component {
        id: mDialogChangeSettings
        Dialog {
            visible: true
            title: "Choose a date"
            standardButtons: StandardButton.Yes | StandardButton.No | StandardButton.Cancel

            onYes: mSettings.restartApp()
            onNo: console.log("no")
            onRejected: console.log("reject")

            Text {
                text: qsTr(Str.settingsDone)
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
            }
        }
    }

    Component {
        id: mDialogResetSettings
        Dialog {
            visible: true
            title: "Reset Settings!"
            standardButtons: StandardButton.Yes | StandardButton.No | StandardButton.Cancel

            onYes: {
                mSettings.resetSettings()
                mSettings.restartApp()
            }
            onNo: console.log("no")
            onRejected: console.log("reject")

            Text {
                text: qsTr(Str.settingsReset)
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
            }
        }
    }
}
