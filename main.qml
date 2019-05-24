import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.VirtualKeyboard 2.4
import "screen_files/driver_mode"
import "screen_files"
//import QtMultimedia 5.8


ApplicationWindow {
    id: window
    visible: true
    width: 1600
    height: 480
    title: qsTr("Dashing Boi 2: Return of the Dash")

    Animator{
        id: animatedVals
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        transform: Rotation {
        angle: 0
        origin.x: window.width / 2
        origin.y: window.height / 2
        }
        DriverMode {
            id:driver_mode
            speed: animatedVals.vehicleSpeed
            power: animatedVals.vehiclePower
            vehicleMode: animatedVals.vehicleStatus
            maxCellTemp: animatedVals.maxCellTemp
            hvVoltage: animatedVals.hvVoltage
            backgroundColour: "#181818"
            lvBars: animatedVals.lvBars
            airValue: animatedVals.airStatus
            lvVoltage: animatedVals.lvVoltage
            bspd: animatedVals.bspd
            imd: animatedVals.imd
            bms: animatedVals.bms
            ecu: animatedVals.ecu
            inertia: animatedVals.inertia
            bots: animatedVals.bots
            fuse: animatedVals.fuse
            pcb: animatedVals.pcb
            estop: animatedVals.estop
            tsms: animatedVals.tsms
            hvd: animatedVals.hvd
            interlock: animatedVals.interlock
        }
    }

}
