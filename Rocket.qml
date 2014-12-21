import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    width: 10
    height: 10
    bullet: true
    bodyType: Body.Dynamic

    fixtures: Circle {
        radius: 5
        density: 0.9
        friction: 0.9
        restitution: 0.2
    }
    Rectangle {
        anchors.fill: parent
        color: "red"
    }
}
