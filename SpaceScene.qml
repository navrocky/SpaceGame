import QtQuick 2.0
import Bacon2D 1.0
import QtMultimedia 5.0
import QtQuick.Controls 1.2
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0


FocusScope {

    Game {
        id: game
        anchors.fill: parent

        currentScene: scene

        property Item activeShip: spaceShip1
        Keys.onTabPressed: activeShip = activeShip == spaceShip1 ? spaceShip1 : spaceShip2

        Audio {
            id: backgroundMusic
            source: "music/werewolf-restless.mp3"
            volume: 0.5
            loops: Audio.Infinite
        }

        Component.onCompleted: {
            backgroundMusic.play()
            activeShip.focus = true
        }

        QtObject {
            id: d

        }



        Scene {
            id: scene

            visible: false

            property size sceneSize: Qt.size(1280, 800)
            property int scenePadding: 500

            width: sceneSize.width + scenePadding * 2
            height: sceneSize.height + scenePadding * 2

            physics: true
            running: true
            gravity: Qt.point(0,0)
            //        scale: 1
            debug: true

            //        Rectangle {
            //            id: backgroundFill
            //            color: Qt.rgba(1,1,1,0.2)
            //            width: scene.width
            //            height: scene.height
            //            z: 10
            //        }

            viewport: Viewport {
                id: viewPort
                animationDuration: 0

                property int xPos
                property int yPos

                xOffset: Math.min(xPos, scene.width - game.width)
                yOffset: Math.min(yPos, scene.height - game.height)
            }

            property bool scrollLeftPressed: false
            property bool scrollRightPressed: false
            property bool scrollUpPressed: false
            property bool scrollDownPressed: false
//            focus: true
            Keys.onPressed: {
                if (event.isAutoRepeat)
                    return
                if (event.key === Qt.Key_Right)
                    scrollRightPressed = true
                if (event.key === Qt.Key_Left)
                    scrollLeftPressed = true
                if (event.key === Qt.Key_Up)
                    scrollUpPressed = true
                if (event.key === Qt.Key_Down)
                    scrollDownPressed = true
            }
            Keys.onReleased: {
                if (event.isAutoRepeat)
                    return
                if (event.key === Qt.Key_Right)
                    scrollRightPressed = false
                if (event.key === Qt.Key_Left)
                    scrollLeftPressed = false
                if (event.key === Qt.Key_Up)
                    scrollUpPressed = false
                if (event.key === Qt.Key_Down)
                    scrollDownPressed = false
            }
            property real moveSpeed: 400
            NumberAnimation {
                id: rightAnimation
                target: viewPort
                properties: "xPos"
                duration: 1000000
                from: viewPort.xOffset
                to: viewPort.xOffset + scene.moveSpeed * 1000
                running: scene.scrollRightPressed && !scene.scrollLeftPressed
            }
            NumberAnimation {
                id: leftAnimation
                target: viewPort
                properties: "xPos"
                duration: 1000000
                from: viewPort.xOffset
                to: viewPort.xOffset - scene.moveSpeed * 1000
                running: scene.scrollLeftPressed && !scene.scrollRightPressed
            }
            NumberAnimation {
                id: upAnimation
                target: viewPort
                properties: "yPos"
                duration: 1000000
                from: viewPort.yOffset
                to: viewPort.yOffset - scene.moveSpeed * 1000
                running: scene.scrollUpPressed && !scene.scrollDownPressed
            }
            NumberAnimation {
                id: downAnimation
                target: viewPort
                properties: "yPos"
                duration: 1000000
                from: viewPort.yOffset
                to: viewPort.yOffset + scene.moveSpeed * 1000
                running: scene.scrollDownPressed && !scene.scrollUpPressed
            }

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

            Image {
                id: background
                source: "images/bg_1024.jpg"
                property int size: Math.max(scene.width, scene.height) * 1.5
                width: size
                height: size
                //            visible: false
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -(scene.width / 2 - viewPort.xOffset - game.width / 2) * 0.10
                anchors.verticalCenterOffset: -(scene.height / 2 - viewPort.yOffset - game.height / 2) * 0.10
                fillMode: Image.Tile
                NumberAnimation  {
                    target: background
                    properties: "rotation"
                    loops: Animation.Infinite
                    duration: 300000
                    from: 0
                    to: 360
                    running: true
                }
            }

            ParticleSystem {
                id: starParticles
                property int size: Math.max(scene.width, scene.height) * 1.5
                width: size
                height: size
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -(scene.width / 2 - viewPort.xOffset - game.width / 2) * 0.15
                anchors.verticalCenterOffset: -(scene.height / 2 - viewPort.yOffset - game.height / 2) * 0.15

                property real starsRotation: 0
                property real starsRotationVelocity: -30

                NumberAnimation  {
                    target: starParticles
                    properties: "rotation"
                    loops: Animation.Infinite
                    duration: 200000
                    from: 0
                    to: 360
                    running: true
                }

                NumberAnimation {
                    target: starParticles
                    properties: "starsRotation"
                    from: 0
                    to: 360 * (starParticles.starsRotationVelocity >= 0 ? 1 : -1)
                    duration: 1000 / Math.abs(starParticles.starsRotationVelocity / 360)
                    running: true
                    loops: Animation.Infinite
                }

                ImageParticle {
                    groups: ["stars"]
                    source: "images/star_particle.png"
                    color: "white"
                    colorVariation: 0.2
                    rotationVelocity: starParticles.starsRotationVelocity
                    entryEffect: ImageParticle.Fade
                    rotation: starParticles.starsRotation
                }

                Emitter {
                    group: "stars"
                    emitRate: 100
                    lifeSpan: 2000
                    size: 20
                    sizeVariation: 10
                    velocity: PointDirection { x: 0; y: 0; }
                    height: 10
                    anchors.fill: parent
                }
            }



            //        Image {
            //            id: stars
            //            source: "images/stars.png"
            //            x: Math.sin(scene.backgroundAngle) * 6 - 20
            //            y: Math.cos(scene.backgroundAngle) * 6 - 20
            //        }

            Planet {
                id: planet1
                x: 100 + scene.scenePadding
                y: 200 + scene.scenePadding
                radius: 70
                source: "images/planet1.png"
                imageScale: 0.9
            }

            SpaceShip {
                id: spaceShip1
                x: 1000
                y: 100
                scene: scene

                //            focus: game.activeShip == spaceShip1

                flameColor: "cyan"

                //                Keys.onLeftPressed: spaceShip1.angle -= 10
                //                Keys.onRightPressed: spaceShip1.angle += 10
                //                Keys.onSpacePressed: spaceShip1.shoot()
            }

            SpaceShip {
                id: spaceShip2
                source: "images/republic_gunship.png"
                x: 100
                y: 600
                scene: scene

                //            focus: game.activeShip == spaceShip2

                //            Timer {
                //                repeat: true
                //                running: true
                //                interval: 500
                //                onTriggered: {
                ////                    if (Math.random() > 0.8)
                ////                        spaceShip2.shoot();
                //                }

                //            }
            }

            //        PathAnimation {
            //            loops: Animation.Infinite
            //            duration: 50000
            //            target: spaceShip2
            //            path: Path {
            //                id: shipPath
            //                startX: 100; startY: 50

            //                PathCurve { x: 0; y: 200 }
            //                PathCurve { x: 100; y: 600 }
            //                PathCurve { x: 400; y: 300 }
            //                PathCurve { x: 600; y: 300 }
            //                PathCurve { x: 800; y: 600 }
            //                PathCurve { x: 400; y: 500 }
            //                PathCurve { x: 400; y: 200 }
            //                PathCurve { x: 100; y: 50 }
            //            }
            //            running: true
            //            orientation: PathAnimation.BottomFirst
            //        }

            //        Planet {
            //            id: planet1
            //            x: 100
            //            y: 200
            //            radius: 70
            //            source: "images/planet1.png"
            //            imageScale: 0.9
            //        }

            Planet {
                id: planet2
                x: 700
                y: 250
                radius: 100
                source: "images/planet2.png"
                imageScale: 1.35
            }

            Planet {
                id: planet3
                x: 1000
                y: 500
                radius: 70
                source: "images/planet3.png"
                imageScale: 0.93
            }

            Planet {
                id: planet4
                x: 300
                y: 600
                radius: 50
                source: "images/planet4.png"
                imageScale: 1.05
            }


            MouseArea {
                anchors.fill: parent
                //            onClicked: spaceShip.shoot()
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

    Desaturate {
        id: desaturate
        source: game
        desaturation: 0.5
        anchors.fill: game
        visible: false
    }

    FastBlur {
        source: desaturate
        radius: 40
        anchors.fill: game
    }

}
