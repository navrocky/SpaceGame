import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    property real angle : 0
    property var scene

    function shoot() {
        console.log("BANG")

//        var angle = Math.abs(joint.getJointAngle());
//        var offsetX = 65 * Math.cos(angle * Math.PI / 180);
//        var offsetY = 65 * Math.sin(angle * Math.PI / 180);
        var rocket = Rocket.createObject(scene);
        newBall.x = 125 + offsetX;
        newBall.y = 500 - offsetY;
        var impulse = power.value;
        var impulseX = impulse * Math.cos(angle * Math.PI / 180);
        var impulseY = impulse * Math.sin(angle * Math.PI / 180);
        newBall.applyLinearImpulse(Qt.point(impulseX,-impulseY),newBall.getWorldCenter());
        shotSound.play();

    }



    width: 50
    height: 100
    transformOrigin: Item.Center

    id: root
    bodyType: Body.Static

    onAngleChanged: rotation = angle
    Behavior on rotation {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    fixtures: Box {
        width: target.width
        height: target.height
        friction: 1
        density: 1
    }

    Rectangle {
        anchors.fill: parent
        color: "blue"

        Rectangle {
            width: 10
            height: 40
            x: 20
            y: -30
            color: "green"
        }


    }
}

