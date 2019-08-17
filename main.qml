import QtQuick 2.10
import QtQuick.Controls 2.2
//import QtQuick.VirtualKeyboard 2.4
import QtGraphicalEffects 1.0
import "screen_files/driver_mode"
import "screen_files/car_status"
import "screen_files"
//import QtMultimedia 5.8


ApplicationWindow {
    id: window
    property int dispMode: 0
    property int startup: 0

//    onDispModeChanged: {window.dispMode == 0? window.startup = 1: window.startup = 0}

    visible: true
    width: 1600
    height: 480
    title: qsTr("Dashing Boi 2: Return of the Dash")
    Rectangle{
        anchors.fill: parent
        color: "#181818"
    }
    Rectangle{
        id: stripes
        anchors.fill: parent
        color: "transparent"
        opacity: startupAnimation.imageOpacity
        Rectangle
        {
            id: whiteStripe
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 100
            color: "white"
        }
        Rectangle
        {
            id: blueStripe
            anchors.right: whiteStripe.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 200
            color: "#0033a0"
        }
    }

    Image {
        id: backIm
        source: "screen_files/driver_mode/carbon_fiber.jpg"
        fillMode: Image.Tile
        anchors.fill: parent
        opacity: 0.06
        visible: true
    }

    StartupAnimator{
        id: startupAnimation
        startupMode: dispMode == 0
    }

    Animator{
        id: animatedVals
        disabled: 0
        status: 0
        onStatusChanged: {
            console.log(dash.displayMode)
            vehicleSpeed = 0
            vehiclePower = 0
            vehicleStatus = 1
            maxCellTemp = 0
            bmsVoltage = 0
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

    SwipeView {
        id: swipeView
        property int viewIndex: dash.displayMode
        onViewIndexChanged: {
            setCurrentIndex(viewIndex);
            console.log(swipeView.currentIndex);
                             }
//        onHeightChanged: setCurrentIndex(2)
//        onCurrentIndexChanged: {console.log("swipeView.currentIndex")}
        anchors.fill: parent
        transform: Rotation {
        angle: 0
        origin.x: window.width / 2
        origin.y: window.height / 2

        }
        DriverMode {
            id:driver_mode
            opacity: dispMode==0? 1 - startupAnimation.imageOpacity: 1
            speed: dash.speed
            power: dash.power
            vehicleMode: dash.vehicleMode
//            maxCellTemp: animatedVals.maxCellTemp
            bmsVoltage: dash.bmsVoltage
            backgroundColour: "#181818"
//            lvBars: animatedVals.lvBars
//            airValue: animatedVals.airStatus
            lvVoltage: dash.lvVoltage
            cellVoltage: dash.avgCellVoltage
//            bspd: animatedVals.bspd
//            imd: animatedVals.imd
//            bms: animatedVals.bms
//            ecu: animatedVals.ecu
//            inertia: animatedVals.inertia
//            bots: animatedVals.bots
//            fuse: animatedVals.fuse
//            pcb: animatedVals.pcb
//            estop: animatedVals.estop
//            tsms: animatedVals.tsms
//            hvd: animatedVals.hvd
//            interlock: animatedVals.interlock
//            cellBars: animatedVals.cellBars
            powerColour: startupAnimation.powerColour
            speedColour: startupAnimation.speedColour
        }

        Rectangle{
            id: startupOverlay
            anchors.centerIn: driver_mode
            property double ratio: 0.72
            color: "transparent"
            width: 476 * ratio
            height: 534 * ratio
            visible: dispMode == 0
            CircularBar{
                id: leftCircular
                visible: true
                anchors.centerIn: leftBolt
                width: 400
                height: 400
                max_value: 360
                startPosition: startupAnimation.leftBegin
                endPosition: 320
                gauge_value: startupAnimation.leftCircle
                gaugeColour: "#005dab"
                opacity: startupAnimation.imageOpacity * 2
            }

            Image{
                id: leftBolt
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: startupAnimation.leftOffset
                source: "logo_left.png"
                scale: startupOverlay.ratio
                opacity: startupAnimation.imageOpacity
                visible: false
            }
            Glow {
                anchors.fill: leftBolt
                radius: startupAnimation.imageGlow
                samples: 15
                color: Qt.lighter("#005dab", 1.5)
                source: leftBolt
                scale: startupOverlay.ratio
                opacity: startupAnimation.imageOpacity * 2

            }
            CircularBar{
                id: rightCircular
                visible: true
                anchors.centerIn: rightBolt
                anchors.verticalCenterOffset: -3
                width: 400
                height: 400
                max_value: 360
                startPosition: 383
                endPosition: 90
                gauge_value: startupAnimation.rightCircle
                gaugeColour: "#ffc423"
                opacity: startupAnimation.imageOpacity
            }
            Image{
                id: rightBolt
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: startupAnimation.rightOffset
                source: "logo_right.png"
                scale: startupOverlay.ratio
                opacity: startupAnimation.imageOpacity
            }
            Glow {
                anchors.fill: rightBolt
                radius: startupAnimation.imageGlow
                samples: 15
                color: Qt.lighter("#ffc423", 1.5)
                source: rightBolt
                scale: startupOverlay.ratio
                opacity: startupAnimation.imageOpacity
            }
        }

        CarStatus{

        }


        focus: true
        Keys.enabled: true
//        Keys.onPressed: Qt.quit()

    }



}
