import QtQuick 2.0
import Bacon2D 1.0
import QtMultimedia 5.0

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
        source: "werewolf-restless.mp3"
        volume: 0.5
        loops: Audio.Infinite
    }

    Component.onCompleted: {
        backgroundMusic.play()
    }

    Scene {
        id: scene
        anchors.fill: parent
        physics: true
        running: true
        gravity: Qt.point(0,0)

        SpaceShip {
            id: spaceShip
            x: 100
            y: 100
            scene: scene
        }


    }
}

