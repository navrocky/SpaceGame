import QtQuick 2.0
import QtQuick.Controls 1.2

StackView {
    id: stackView
    initialItem: mainMenu
    anchors.fill: parent

    onCurrentItemChanged: {
        if (currentItem)
            currentItem.focus = true
    }

    Component {
        id:  mainMenu
        Loader {
            objectName: "menuLoader"
            active: Stack.status == Stack.Active || Stack.status == Stack.Activating
            source: "MainMenu.qml"
//            focus: true
        }
    }
}
