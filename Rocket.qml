import QtQuick 2.0
import Bacon2D 1.0
import QtQuick.Particles 2.0
import "."

PhysicsEntity {
    id: root
    width: 10
    height: 20
    bullet: true
    bodyType: Body.Dynamic

    updateInterval: 10

    QtObject {
        id: d
    }

    fixtures: [
        Box {
            width: target.width
            height: target.height
            density: 10
            friction: 1
            restitution: 0
        },
        Box {
            width: target.width
            height: target.width
            y: -width
            sensor: true
//            density: 0

            onBeginContact: {
                console.log("BOOM!", Common.value)


                var explode = Common.explodeComponent.createObject(root.parent);
                var pt = toWorldPoint(Qt.point(0, 0))
                explode.x = pt.x
                explode.y = pt.y
                explode.boom()
                root.destroy()
            }
        }
    ]
    Image {
        anchors.centerIn: parent
        source: "images/rocket.png"
        scale: 0.3
    }

    behavior: ScriptBehavior {
        script: {
            var selfPos = getWorldCenter()
            // FIXME
            // delete himself if go out from the scene
            if (selfPos.x < -10000 || selfPos.x > 10000 || selfPos.y < -10000 || selfPos.y > 10000) {
                root.destroy()
                return
            }
            var force = Common.calculateForceForItem(root, 2)
            console.log("force ", force)
            applyForceToCenter(force)
        }
    }
}
