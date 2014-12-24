import QtQuick 2.0
import QtQuick.Particles 2.0

ParticleSystem {
    property real time: 700
    property color color: "orange"

    width: 100
    height: 100

    id: root

    property real textAngle: 45
    property real textDistance: 50

    function boom() {
//        explodeEmitter.burst(100)
        timer.start()
        explodeTimer.start()
        textAngle = Math.random() * 90 - 45

        switch (Math.floor(Math.random() * 4))
        {
        case 0: text.text = qsTr("BAM!"); break;
        case 1: text.text = qsTr("BOOM!"); break;
        case 2: text.text = qsTr("BANG!"); break;
        case 3: text.text = qsTr("CRASH!"); break;
        }

        textAnimation.start()
        explodeEmitter.enabled = true
    }

    ImageParticle {
        groups: ["explode"]
        source: "qrc:///particleresources/fuzzydot.png"
//        source: "images/explode_particle.png"
        color: root.color
        colorVariation: 0.2
    }

    Timer {
        id: explodeTimer
        interval: 100
        onTriggered: explodeEmitter.enabled = false
    }

    Timer {
        id: timer
        interval: root.time
        onTriggered: {
            root.destroy()
        }
    }

    Text {
        id: text
        opacity: 0
        font.pixelSize: 40
        font.bold: true
        rotation: root.textAngle
        color: root.color
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
        lifeSpan: root.time - lifeSpanVariation
        lifeSpanVariation: 500
        emitRate: 1000
        size: 20
        endSize: 0
        sizeVariation: 4
        velocity: PointDirection { xVariation: 500; yVariation: 500 }
        enabled: false

    }
}

