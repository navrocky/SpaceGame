import QtQuick 2.4
import QtQuick.Window 2.2
import "."

Window {
    visible: true
    color: "black"

    property bool fullScreenSystem : Qt.platform.os == "android" || Qt.platform.os == "ios"

    width: fullScreenSystem ? 0 : 1280
    height: fullScreenSystem ? 0 : 800
    contentOrientation: Qt.LandscapeOrientation
//    visibility: fullScreenSystem ? Window.FullScreen : Window.AutomaticVisibility
    visibility: Window.FullScreen

    onActiveFocusItemChanged: console.log("<416d36e3> Focused:", activeFocusItem)

    LoadingPage {
        id: loadingPage
        anchors.fill: parent
        Component.onDestruction: console.log("<ae48f9e0> loading page destroyed")
    }

    Timer {
        running: true
        interval: 1000
        onTriggered: appStackLoader.active = true
    }

    Loader {
        id: appStackLoader
        source: "AppStackView.qml"
        anchors.fill: parent
        active: false
        focus: true
        onLoaded: {
            Common.appStackView = item
            loadingPage.destroy()
        }
    }
}

