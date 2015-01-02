pragma Singleton
import QtQuick 2.0

QtObject {
    property Component explodeComponent : Qt.createComponent("Explode.qml")
    property Component rocketComponent: Qt.createComponent("Rocket.qml")

    // main app stack view
    property AppStackView appStackView

    function calculateForceForItem(item, mass) {
        var scene = item.game.currentScene
        var items = scene.gravityItems
        var selfPos = item.getWorldCenter()
        var G = 6.67545e-11

        var force = Qt.point(0, 0)
        for (var i = 0; i < items.length; i++) {
            var otherItem = items[i]

            if (otherItem === item)
                continue

            // calculate force
            var otherPos = otherItem.getWorldCenter()
            var distanceVector = Qt.point(otherPos.x - selfPos.x, otherPos.y - selfPos.y)
            var distance = Math.sqrt(Math.pow(distanceVector.x, 2) + Math.pow(distanceVector.y, 2))

            var f = G * (otherItem.gravityMass * mass) / Math.pow(distance, 2)
            var k = f / distance
            force.x += distanceVector.x * k
            force.y += distanceVector.y * k
        }
        return force
    }
}
