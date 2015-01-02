import QtQuick 2.4
import QtQuick.Window 2.0
import "."
//import QtGraphicalEffects 1.0
//import QtQuick.Controls 1.2
//import Bacon2D 1.0

Window {
    visible: true
    width: 1280
    height: 800
    color: "black"

    LoadingPage {
        id: loadingPage
        anchors.fill: parent
//        Component.onDestruction: console.log("loading page destroyed")
    }

    Component.onCompleted: {
        appStackLoader.enabled = true
    }

    Timer {
        running: true
        interval: 1000
        onTriggered: appStackLoader.active = true
    }

    Loader {
        id: appStackLoader
        source: "AppStackView.qml"
        anchors.fill: parent
        active: false
        onLoaded: {
            Common.appStackView = item
            loadingPage.destroy()
            focus = true
        }
    }


//    SpaceScene {
//        anchors.fill: parent
//        focus: false
//    }

//    Text {
//        id: caption
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        anchors.rightMargin: 20
//        anchors.bottomMargin: 20
//        text: "Space Duel"
//        font.pixelSize: 40
//        font.bold: true
//        color: "white"
//        visible: false
//    }

//    DropShadow {
//        source: caption
//        anchors.fill: caption
//        radius: 20.0
//        color: "#80000000"
//        samples: 16
//    }
}

