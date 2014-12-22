import QtQuick 2.0
import QtQuick.Particles 2.0

ParticleSystem {
    property real time: 600
    property color color: "yellow"

    width: 100
    height: 100

    id: root

    property real textAngle: 45
    property real textDistance: 50

    function boom() {
        console.log("<ed4b3909>")
        explodeEmitter.burst(100)
        timer.start()
        textAngle = Math.random() * 90 - 45

        switch (Math.floor(Math.random() * 4))
        {
        case 0: text.text = qsTr("BAM!"); break;
        case 1: text.text = qsTr("BOOM!"); break;
        case 2: text.text = qsTr("BANG!"); break;
        case 3: text.text = qsTr("CRASH!"); break;
        }

        textAnimation.start()
    }

    ImageParticle {
        groups: ["explode"]
        source: "images/explode_particle.png"
//        colorVariation: 0.2
    }

    Timer {
        id: timer
        interval: root.time
        onTriggered: {
//            explodeEmitter.enabled = false
            root.destroy()
        }
    }

    Text {
        id: text
        opacity: 0
        font.pixelSize: 40
        font.bold: true
        text: "BOOM!"
        rotation: root.textAngle
        color: "yellow"
    }

    ParallelAnimation {
        id: textAnimation
        PathAnimation {
            target: text
            duration: root.time
            easing.type: Easing.OutQuad
            path: Path {
                startX: 0; startY: 0
                PathCurve {
                    property real angle: (root.textAngle - 90) / 360 * 2 * Math.PI
                    x: Math.cos(angle) * root.textDistance
                    y: Math.sin(angle) * root.textDistance
                }
            }
        }
        NumberAnimation {
            target: text
            properties: "opacity"
            from: 1.0
            to: 0.0
            duration: root.time
        }
        NumberAnimation {
            target: text
            properties: "scale"
            from: 0.5
            to: 2
            duration: root.time
            easing.type: Easing.OutQuad
        }
    }

    Emitter {
        id: explodeEmitter
        group: "explode"
        lifeSpan: root.time
        lifeSpanVariation: 500
        size: 20
        endSize: 0
        sizeVariation: 4
        velocity: PointDirection { xVariation: 500; yVariation: 500 }
        enabled: false

    }
}

