import QtQuick 2.0
import QtQuick.Controls 1.2

StackView {
    id: stackView
    initialItem: mainMenu

    Component {
        id:  mainMenu
        MainMenu {
            focus: true
        }
    }
}
