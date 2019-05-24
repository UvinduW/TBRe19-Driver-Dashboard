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

    StaticValues{
        id: staticVals
    }

    Animator{
        id: animatedVals
        disabled: 1 - (dash.displayMode == 2)
        status: dash.displayMode
        onStatusChanged: {
            console.log(dash.displayMode)
            if (dash.displayMode == 1)
            {
                vehicleSpeed = staticVals.vehicleSpeed
                vehiclePower = staticVals.vehiclePower
                vehicleStatus = staticVals.vehicleStatus
                maxCellTemp = staticVals.maxCellTemp
                hvVoltage = staticVals.hvVoltage
                lvBars = staticVals.lvBars
                airStatus = staticVals.airStatus
                lvVoltage = staticVals.lvVoltage
                cellVoltage = staticVals.cellVoltage
                bspd = staticVals.bspd
                imd = staticVals.imd
                bms = staticVals.bms
                ecu = staticVals.ecu
                inertia = staticVals.inertia
                bots = staticVals.bots
                fuse = staticVals.fuse
                pcb = staticVals.pcb
                estop = staticVals.estop
                tsms = staticVals.tsms
                hvd = staticVals.hvd
                interlock = staticVals.interlock
                cellBars = staticVals.cellBars
            }
            else if (dash.displayMode == 0)
            {
                vehicleSpeed = 0
                vehiclePower = 0
                vehicleStatus = 1
                maxCellTemp = 0
                hvVoltage = 0
                lvBars = 1
                airStatus = 0
                lvVoltage = 0
                cellVoltage = 0
                bspd = 0
                imd = 0
                bms = 0
                ecu = 0
                inertia = 0
                bots = 0
                fuse = 0
                pcb = 0
                estop = 0
                tsms = 0
                hvd = 0
                interlock = 0
                cellBars = 1
            }
        }
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
            cellVoltage: animatedVals.cellVoltage
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
            cellBars: animatedVals.cellBars
        }
        focus: true
        Keys.enabled: true
        Keys.onPressed: Qt.quit()

    }


}
