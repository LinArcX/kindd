import QtQuick 2.9
Item {
    anchors.fill: parent
    property variant mTarget
    property real initValue
    property real endValue
    //    topPadding: 5

    //    states: [
    //        State {
    //            name: "rotate"
    //            PropertyChanges { target: mTarget; scale: endValue }
    //        },
    //        State {
    //            name: "normal"
    //            PropertyChanges { target: mTarget; scale: initValue }
    //        }
    //    ]

    //    transitions: Transition {
    //        RotationAnimation { duration: 100; direction: RotationAnimation.Counterclockwise; }
    //    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            mTarget.opacity = endValue
            //mTarget.state = "rotate"
            //console.log("enter")
        }
        onExited:{
            mTarget.opacity = initValue
            //mTarget.state = "normal"
            //console.log("exit")
        }
    }
}
