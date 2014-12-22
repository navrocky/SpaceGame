import QtQuick 2.4
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2

Window {
    visible: true
    width: 1280
    height: 800
    color: "black"

    SpaceScene {
        anchors.fill: parent
    }

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
