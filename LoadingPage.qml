import QtQuick 2.4
import QtQuick.Controls 1.2

Image {
    width: 100
    height: 62
    source: "images/bg_1024.jpg"
    fillMode: Image.Tile

    Column {
        anchors.centerIn: parent
        Text {
            text: qsTr("Loading...")
            color: "white"
            font.pixelSize: 40
            font.bold: true
        }
    }
}
