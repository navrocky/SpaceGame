import QtQuick 2.0
import Bacon2D 1.0
import QtMultimedia 5.0
import QtQuick.Controls 1.2

Game {
    width: 100
    height: 100

    currentScene: scene

    focus: true

    Keys.onLeftPressed: spaceShip.angle -= 10
    Keys.onRightPressed: spaceShip.angle += 10
    Keys.onSpacePressed: spaceShip.shoot()

    Audio {
        id: backgroundMusic
        source: "music/werewolf-restless.mp3"
        volume: 0.5
        loops: Audio.Infinite
    }

    Component.onCompleted: {
        backgroundMusic.play()
    }

    QtObject {
        id: d

    }

    Scene {
        id: scene
        anchors.fill: parent
        physics: true
        running: true
        gravity: Qt.point(0,0)
        scale: 1
        debug: true


        property var gravityItems
        Component.onCompleted: updateGravityItems()
        function updateGravityItems() {
            gravityItems = []
            for (var i = 0; i < scene.children.length; i++) {
                var item = scene.children[i]
                if (item.gravityMass)
                    gravityItems.push(item)
            }

            console.log("Gravity items count", gravityItems.length)
        }

        property real backgroundAngle: spaceShip.angle / 360 * 2* Math.PI

        Image {
            id: background
            source: "images/space.jpg"
            x: Math.sin(scene.backgroundAngle) * 3 - 20
            y: Math.cos(scene.backgroundAngle) * 3 - 20
        }
        Image {
            id: stars
            source: "images/stars.png"
            x: Math.sin(scene.backgroundAngle) * 6 - 20
            y: Math.cos(scene.backgroundAngle) * 6 - 20
        }

        SpaceShip {
            id: spaceShip
            x: 1000
            y: 100
            scene: scene
            flameColor: "cyan"
        }

        SpaceShip {
            id: spaceShip2
            source: "images/republic_gunship.png"
            x: 100
            y: 600
            scene: scene

            Timer {
                repeat: true
                running: true
                interval: 500
                onTriggered: {
//                    if (Math.random() > 0.8)
//                        spaceShip2.shoot();
                }

            }
        }

        PathAnimation {
            loops: Animation.Infinite
            duration: 50000
            target: spaceShip2
            path: Path {
                id: shipPath
                startX: 100; startY: 50

                PathCurve { x: 0; y: 200 }
                PathCurve { x: 100; y: 600 }
                PathCurve { x: 400; y: 300 }
                PathCurve { x: 600; y: 300 }
                PathCurve { x: 800; y: 600 }
                PathCurve { x: 400; y: 500 }
                PathCurve { x: 400; y: 200 }
                PathCurve { x: 100; y: 50 }
            }
            running: true
            orientation: PathAnimation.BottomFirst
        }

        Planet {
            id: planet1
            x: 100
            y: 200
            radius: 70
            source: "images/jupiter.png"
            imageScale: 0.72
        }

        Planet {
            id: planet2
            x: 700
            y: 250
            radius: 50
            source: "images/saturn.png"
            imageScale: 0.69
            rotation: 50
        }

        Planet {
            id: planet3
            x: 1000
            y: 500
            radius: 70
            source: "images/jupiter.png"
            imageScale: 0.72
        }

        Planet {
            id: planet4
            x: 300
            y: 600
            radius: 50
            source: "images/saturn.png"
            imageScale: 0.69
        }


        MouseArea {
            anchors.fill: parent
            onClicked: spaceShip.shoot()
        }

        Button {
            text: "<"
            onClicked: spaceShip.angle -= 10
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
        }
        Button {
            text: ">"
            onClicked: spaceShip.angle += 10
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
        }
    }
}

