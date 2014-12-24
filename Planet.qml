import QtQuick 2.0
import Bacon2D 1.0
import "."

PhysicsEntity {

    property real gravityMass: 10e15

    property real radius: 100
    property color color: "red"
    property url source
    property real imageScale: 1.0

    id: root
    width: radius * 2
    height: radius * 2

    bodyType: Body.Dynamic

    fixtures: Circle {
        radius: root.radius
        density: 100

        //friction: 0.9
        //restitution: 0.2
    }
    Image {
        smooth: true
        anchors.centerIn: parent
        source: root.source
        width: sourceSize.width
        height: sourceSize.height
        scale: root.imageScale * root.radius / 100
    }


    behavior: ScriptBehavior {
        script: {
            var force = Common.calculateForceForItem(root, 10)
            applyForceToCenter(force)
        }
    }

}
