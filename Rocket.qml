import QtQuick 2.0
import Bacon2D 1.0
import QtQuick.Particles 2.0

PhysicsEntity {
    id: root
    width: 5
    height: 15
    bullet: true
    bodyType: Body.Dynamic

    property var explodeComponent

    fixtures: [
        Box {
            width: target.width
            height: target.height
            density: 10
            friction: 1
            restitution: 0.2
        },
        Box {
            width: target.width
            height: target.width
            y: -width
            sensor: true
            onBeginContact: {
                console.log("BOOM!")

                var explode = explodeComponent.createObject(root.parent);
                var pt = toWorldPoint(Qt.point(0, 0))
                explode.x = pt.x
                explode.y = pt.y
                explode.boom()
            }
        }
    ]
    Rectangle {
        anchors.fill: parent

        color: "red"
    }
    Rectangle {
        width: root.width
        height: root.width
        color: "white"
    }
}
