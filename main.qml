import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.VirtualKeyboard 2.4
import "screen_files/driver_mode"
import QtMultimedia 5.8


ApplicationWindow {
    id: window
    visible: true
    width: 1600
    height: 480
    title: qsTr("Dashing Boi 2: Return of the Dash")

    SwipeView {
        id: swipeView
        anchors.fill: parent

        DriverMode {
            id:driver_mode
        }



        // Demo Animations1
        PropertyAnimation {
            id: animSpeedUp
            target: driver_mode
            property: "speed"
            from: 0
            to: 130
            duration: 10000
            loops: 1
            easing.type: Easing.OutQuad
            running: true
            onStarted: {
                animSpeedDown.pause()
            }
            onStopped: {
                animSpeedDown.resume()
            }
        }
        PropertyAnimation {
            id: animSpeedDown
            target: driver_mode
            property: "speed"
            from: 130
            to: 0
            duration: 1500
            loops: 1
            easing.type: Easing.OutQuint
            running: true
            onStopped: {
                animSpeedDown.restart()
                animSpeedUp.start()
            }
        }
        PropertyAnimation {
            id: animPowerUp
            target: driver_mode
            property: "power"
            from: 0
            to: 100
            duration: 5000
            loops: 1
            easing.type: Easing.OutQuad
            running: true
            onStarted: {
                animPowerDown.pause()
            }
            onStopped: {
                animPowerDown.resume()
            }
        }
        PropertyAnimation {
            id: animPowerDown
            target: driver_mode
            property: "power"
            from: 100
            to: 0
            duration: 1500
            loops: 1
            easing.type: Easing.OutQuint
            running: true
            onStopped: {
                animPowerDown.restart()
                animPowerUp.start()
            }
        }
    }

}
