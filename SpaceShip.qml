import QtQuick 2.0
import Bacon2D 1.0
import QtMultimedia 5.0
import QtQuick.Particles 2.0
import "."

PhysicsEntity {
    property real angle : 0
    property var scene
    property url source: "images/viper_mark_ii.png"
    property color flameColor: "orange"

    property var rocketComponent
    property var explodeComponent

    id: root
    width: 50
    height: 100
    bodyType: Body.Static

    ParticleSystem {
        anchors.fill: parent

        ImageParticle {
            id: engine
            groups: ["engine"]
            source: "qrc:///particleresources/fuzzydot.png"
            color: root.flameColor
            colorVariation: 0.2
        }

        Emitter {
            group: "engine"
            emitRate: 100
            lifeSpan: 500
            size: 10
            endSize: 4
            sizeVariation: 4
            velocity: PointDirection { x: 0; y: -100; xVariation: 32 }
            height: 10
            x: (root.width - width) / 2
            y: -10
            width: 10
        }
    }

    function shoot() {
        console.log("BANG")
        var rocket = Common.rocketComponent.createObject(scene);
        var pt = toWorldPoint(Qt.point(width / 2, height + 10))
        rocket.x = pt.x;
        rocket.y = pt.y;
        var impulse = 20;
        var impulseAngle = angle + 90
        var impulseX = impulse * Math.cos(impulseAngle * Math.PI / 180);
        var impulseY = impulse * Math.sin(impulseAngle * Math.PI / 180);
        rocket.applyLinearImpulse(Qt.point(impulseX,impulseY), rocket.getWorldCenter());
        rocket.rotation = impulseAngle + 90 - 10
        console.log("angle", angle, impulseAngle, rocket.rotation, rocket.getWorldCenter())

//        var shotSound = shotSoundComponent.createObject()
//        shotSound.play();
    }

    Component
    {
        id: shotSoundComponent
        Audio {
            id: shotSound
            source: "sounds/explosion-02.wav"
            volume: 0.05
            onStopped: destroy()
        }
    }

    onAngleChanged: rotation = angle

    Behavior on rotation {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutQuad
        }
    }
    //    onAngleChanged: shipRotation.angle = angle
    //    transform: [
    //        Rotation {
    //            id: shipRotation
    //            origin.x: root.width / 2
    //            origin.y: root.height / 2
    //            Behavior on angle {
    //                NumberAnimation {
    //                    duration: 200
    //                    easing.type: Easing.OutQuad
    //                }
    //            }

    //        }
    //    ]

    fixtures: Box {
        width: target.width
        height: target.height
        friction: 1
        density: 1
        //        rotation: shipRotation.angle
    }

    Image {
        anchors.centerIn: parent
        source: root.source
    }
}

