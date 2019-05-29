import QtQuick 2.9

Item {
    anchors.fill: parent
    property variant mTarget
    property real initValue
    property real endValue
    property real mDuration

    //    topPadding: 5
    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: mTarget
                scale: initValue
            }
        },
        State {
            name: "scale"
            PropertyChanges {
                target: mTarget
                scale: endValue
            }
        }
    ]

    transitions: Transition {
        //RotationAnimation { duration: 100; direction: RotationAnimation.Counterclockwise; }
        ScaleAnimator {
            duration: mDuration
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            mTarget.state = "scale"
            //console.log("scaled")
        }
        onExited: {
            mTarget.state = "normal"
            //console.log("normal")
        }
    }
}
