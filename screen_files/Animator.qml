import QtQuick 2.0

Item {
    id: animator
//    property alias speed: vehicleSpeed
//    property alias power: vehiclePower
    property int vehicleSpeed: 0
    property int vehiclePower: 0
    property int vehicleStatus: 1
    property double bmsVoltage: 0
    property int maxCellTemp: 0
    property int lvBars: 1
    property int cellBars: 1
    property int airStatus: 0
    property double lvVoltage: 0
    property double cellVoltage: 0
    property int bspd: 0
    property int imd: 0
    property int bms: 0
    property int ecu: 0
    property int inertia: 0
    property int bots: 0
    property int fuse: 0
    property int pcb: 0
    property int estop: 0
    property int tsms: 0
    property int hvd: 0
    property int interlock: 0
    property int disabled: 0
    property int status: 0  //unused probs

    // Demo Animations
    PropertyAnimation {
        id: animSpeedUp
        target: animator
        property: "vehicleSpeed"
        from: 0
        to: 157
        duration: 10000
        loops: 1
        easing.type: Easing.OutQuad
        running: (1 - disabled)
        onStarted: {
            animSpeedDown.pause()
        }
        onStopped: {
            if (!disabled)
            {
                animSpeedDown.resume()
            }
        }
    }
    PropertyAnimation {
        id: animSpeedDown
        target: animator
        property: "vehicleSpeed"
        from: 157
        to: 0
        duration: 1500
        loops: 1
        easing.type: Easing.OutQuint
        running: (1 - disabled)
        onStopped: {
            if (!disabled)
            {
                animSpeedDown.restart()
                animSpeedUp.start()
            }
        }
    }
    PropertyAnimation {
        id: animPowerUp
        target: animator
        property: "vehiclePower"
        from: -50
        to: 100
        duration: 5000
        loops: 1
        easing.type: Easing.OutQuad
        running: (1 - disabled)
        onStarted: {
            animPowerDown.pause()
        }
        onStopped: {
            if (!disabled)
            {
                animPowerDown.resume()
            }
        }
    }
    PropertyAnimation {
        id: animPowerDown
        target: animator
        property: "vehiclePower"
        from: 100
        to: -50
        duration: 1500
        loops: 1
        easing.type: Easing.OutQuint
        running: (1 - disabled)
        onStopped: {
            if (!disabled)
            {
                animPowerDown.restart()
                animPowerUp.start()
            }
        }
    }
    PropertyAnimation {
        id: animVehicleStatus
        target: animator
        property: "vehicleStatus"
        from: 0
        to: 4
        duration: 2500
        loops: Animation.Infinite
        //easing.type: Easing.OutQuint
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animLVSoc
        target: animator
        property: "maxCellTemp"
        from: 0
        to: 100
        duration: 2200
        loops: Animation.Infinite
        //easing.type: Easing.OutQuint
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animHVSoc
        target: animator
        property: "bmsVoltage"
        from: 200
        to: 428.4
        duration: 2700
        loops: Animation.Infinite
        //easing.type: Easing.OutQuint
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animLVBars
        target: animator
        property: "lvBars"
        from: 1
        to: 4
        duration: 2700
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animAIRStatus
        target: animator
        property: "airStatus"
        from: 0
        to: 3
        duration: 2700
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animLVVoltage
        target: animator
        property: "lvVoltage"
        from: 20
        to: 28
        duration: 2700
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animCellVoltage
        target: animator
        property: "cellVoltage"
        from: 3
        to: 4.25
        duration: 2700
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animCellBars
        target: animator
        property: "cellBars"
        from: 1
        to: 4
        duration: 2700
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animBSPD
        target: animator
        property: "bspd"
        from: 0
        to: 3
        duration: 1900
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animIMD
        target: animator
        property: "imd"
        from: 0
        to: 3
        duration: 1800
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animBMS
        target: animator
        property: "bms"
        from: 0
        to: 3
        duration: 1700
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animECU
        target: animator
        property: "ecu"
        from: 0
        to: 3
        duration: 1400
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animInertia
        target: animator
        property: "inertia"
        from: 0
        to: 2
        duration: 1500
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animBOTS
        target: animator
        property: "bots"
        from: 0
        to: 2
        duration: 2200
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animFuse
        target: animator
        property: "fuse"
        from: 0
        to: 2
        duration: 2100
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animPCB
        target: animator
        property: "pcb"
        from: 0
        to: 2
        duration: 2000
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animEStop
        target: animator
        property: "estop"
        from: 0
        to: 2
        duration: 1900
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animTSMS
        target: animator
        property: "tsms"
        from: 0
        to: 2
        duration: 1800
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animHVD
        target: animator
        property: "hvd"
        from: 0
        to: 2
        duration: 1700
        loops: Animation.Infinite
        running: (1 - disabled)
    }
    PropertyAnimation {
        id: animInterlock
        target: animator
        property: "interlock"
        from: 0
        to: 2
        duration: 1600
        loops: Animation.Infinite
        running: (1 - disabled)
    }

}
