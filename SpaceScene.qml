import QtQuick 2.0
import Bacon2D 1.0

Game {
    width: 100
    height: 100

    currentScene: scene

    focus: true

    Keys.onLeftPressed: spaceShip.angle -= 10
    Keys.onRightPressed: spaceShip.angle += 10
    Keys.onSpacePressed: spaceShip.shoot()

    Scene {
        id: scene
        anchors.fill: parent

        SpaceShip {
            id: spaceShip
            x: 100
            y: 100
        }
    }
}

