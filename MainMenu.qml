import QtQuick 2.4
import QtGraphicalEffects 1.0
import "."

FocusScope {
    focus: true

    property var menuModel : [
        {
            title: qsTr("Play game!"),
            exec: function () {
                Common.executeLevel(1);
            }
        },
        {
            title: "Help",
            exec: function () {

            }
        },
        {
            title: "Quit",
            exec: function () {
                Qt.quit()
            }
        }]

    id: root

    Component.onCompleted: {
        Common.backgroundMusic.play()

    }

//    Loader {

//    }

//    SpaceScene {
//        id: scene
//        anchors.fill: parent
//        focus: false
//        visible: false
//    }

//    Desaturate {
//        id: desaturate
//        source: scene
//        desaturation: 0.5
//        anchors.fill: scene
//        visible: false
//    }

//    FastBlur {
//        source: desaturate
//        radius: 40
//        anchors.fill: scene
//    }


    Item {
        anchors.fill: parent

        Column {
            anchors.centerIn: parent
            width: implicitWidth
            height: implicitHeight

            Item {
                id: titleBanner
                width: textHolder.width
                height: textHolder.height

                property real maxGlowRadius: 40

                Item {
                    id: textHolder
                    width: title.implicitWidth + titleBanner.maxGlowRadius * 2
                    height: title.implicitHeight + titleBanner.maxGlowRadius * 2
                    anchors.centerIn: parent
                    visible: false
                    Text {
                        anchors.centerIn: parent
                        id: title
                        text: qsTr("GRAVIWAR")
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "white"
                        font.pixelSize: 60
//                        font.bold: true
                        font.family: Common.baseFont.name
                        style: Text.Outline
                        styleColor: "black"
                    }
                }

                Glow {
                    id: glowEffect
                    source: textHolder
                    radius: 20
                    color: "cyan"
                    anchors.fill: textHolder
                    samples: 32
                }

                SequentialAnimation {
                    running: true
                    loops: Animation.Infinite
                    NumberAnimation {
                        target: glowEffect
                        properties: "radius"
                        easing.type: Easing.InOutCubic;
                        duration: 1000
                        to: titleBanner.maxGlowRadius
                    }
                    NumberAnimation {
                        target: glowEffect
                        properties: "radius"
                        easing.type: Easing.InOutCubic;
                        duration: 1000
                        to: 0
                    }
                }
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 20
                color: Qt.rgba(0,0,0,0.5)
                width: menu.width + 20
                height: menu.height + 20

                ListView {
                    id: menu
                    width: 200
                    x:10
                    y:10
                    focus: true
                    height: contentHeight
                    model: root.menuModel
                    highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                    delegate: FocusScope {
                        width: 200
                        height: text.implicitHeight + 20
                        property var modelItem: model.modelData
                        Text {
                            anchors.fill: parent
                            anchors.margins: 10
                            id: text
                            text: modelItem.title
                            color: "white"
                            font.pixelSize: 20
                            font.family: Common.baseFontName
                            style: Text.Outline
                            styleColor: "black"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: root.menuModel[menu.currentIndex].exec()
                        }
                    }
                    Keys.onReturnPressed: root.menuModel[menu.currentIndex].exec()
                }
            }
        }
    }
}
