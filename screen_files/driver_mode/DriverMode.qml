import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0

Item {
    id: driverScreen
    property int power: 60
    property int speed: 100
    property bool regen: false
    property int regenPower: 10
    property int vehicleMode: dash.vehicleMode
    property double hvVoltage: 75
    property int maxCellTemp: dash.maxCellTemp
    property double lvVoltage: 20
    property int inverterTemp: dash.inverterTemp
    property double cellVoltage: 3.7
    property int cellBars: 1
    property color backgroundColour: "#181818"
    property int airValue: 0
    property int lvBars: 1
    property int bspd: dash.shutdownBSPD
    property int imd: dash.shutdownIMD
    property int bms: dash.shutdownBMS
    property int ecu: dash.shutdownECU
    property int inertia: dash.shutdownIntertia
    property int bots: dash.shutdownBOTS
    property int fuse: dash.shutdownFuse
    property int pcb: dash.shutdownPCB
    property int estop: dash.shutdownESTP
    property int tsms: dash.shutdownTSMS
    property int hvd: dash.shutdownHVD
    property int interlock: dash.shutdownINTLK
    property int tweak: 400
    property int danger: 0 //imd? 1: 0
    property int showInnerMarkings: 0
    property color startupSpeedColour: "#005dab"
    property color normalSpeedColour: "cyan"
    property color speedColour: "#005dab"
    property color startupPowerColour: "#ffc423"
    property color normalPowerColour: "#00ff00"
    property color powerColour: "#ffc423"

    onOpacityChanged: {
        if (driverScreen.opacity == 1)
        {
            showInnerMarkings = 1
        }
        else
        {
            showInnerMarkings = 0
        }
    }

    onPowerChanged: {
        //console.log(power)
        regenPower = power - 50

        if (power < 0) {
            regenPower = regenPower * -1
            regen = true
        } else {
            regen = false
        }
    }

    Rectangle {
        id: driverModeContainer
        anchors.fill: parent
        color: backgroundColour
        Image {
            id: backIm
            source: "carbon_fiber.jpg"
            fillMode: Image.Tile
            anchors.fill: parent
            opacity: 0.06
            visible: true
        }

//        RectangularGlow{
//            visible: danger
//            anchors.fill: parent
//            anchors.margins: 20
//            glowRadius: 50
//            spread: 0.2
//            color: "red"
//            cornerRadius: parent.radius + glowRadius
//            Rectangle{
//                anchors.fill: parent
//                color: backgroundColour
//            }
//        }

        MouseArea{
            id:mouseArea
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                if(mouseArea.pressedButtons & Qt.RightButton) {
                    tweak = tweak - 10;
                    console.log(tweak);
                } else {
                    tweak = tweak + 10;
                    console.log(tweak);
                }
            }
        }

        RowLayout {
            // 7 Sections of the screen segmented using RowLayout
//            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenterOffset: 0
            spacing: 35
            SystemStatus {
                id: sysStatus
                // Section 1
                //                Layout.alignment: Qt.AlignBottom
                width: 200
                height: 400
                bspd: driverScreen.bspd
                imd: driverScreen.imd
                bms: driverScreen.bms
                ecu: driverScreen.ecu
                inertia: driverScreen.inertia
                bots: driverScreen.bots
                fuse: driverScreen.fuse
                pcb: driverScreen.pcb
                estop: driverScreen.estop
                tsms: driverScreen.tsms
                hvd: driverScreen.hvd
                interlock: driverScreen.interlock
            }
            VerticalGauge {
                // Section 2
                id: lvBar
                //                Layout.alignment: Qt.AlignRight
                Layout.alignment: Qt.AlignVCenter
                width: 100
                height: 300
                value: maxCellTemp
                maxValue: 60

                backColour: backgroundColour
                barLabel: "Max Temp"
            }

            Rectangle{
                id: speedRectangle
                width: 330
                height: 400
                color: "transparent"
                CircularGauge {
                    // Section 3
                    id: speedGauge
                    anchors.centerIn: parent
                    height: 400
                    width: 400
                    startPosition: 240
                    endPosition: 520
                    regenEnabled: false
                    gaugeColour: speedColour//"cyan"
                    gauge_value: speed
                    backColour: backgroundColour
                    showMarkings: showInnerMarkings
                }
            }
            Rectangle {
                // Section 4
                id: centerSection
//                Layout.alignment: Qt.AlignHCenter
                width: 100
                height: 400
                color: backgroundColour
                RectangularGlow {
                    anchors.fill: centerIndicator
                    glowRadius: 10
                    spread: 0.2
                    color: centerIndicator.lightColour
                    cornerRadius: modeBorder.radius + glowRadius
                }
                ModeIndicator {
                    id: centerIndicator
                    width: 100
                    height: 400
                    mode: vehicleMode
                    backColour: backgroundColour
                    Rectangle {
                        id: modeBorder
                        anchors.fill: parent
                        border.color: centerIndicator.lightColour
                        border.width: 2
                        color: "transparent"
                        radius: 30
                    }
                }
            }
            Rectangle{
                width: 330
                height: 400
                color: "transparent"
                CircularGauge {
                    // Section 5
                    id: powerGauge
                    property color normalColour: "#ffc423"
                    anchors.centerIn: parent
                    height: 400
                    width: 400
                    max_value: 100
                    startPosition: 240
                    regenEnabled: regen
                    gaugeColour: regen ? "#FD5F00" : power < 80? powerColour: "red" //regen ? "#FD5F00" : power < 80? "#00ff00": "red"
                    gauge_value: power
                    units: "kW"
                    backColour: backgroundColour
                    showMarkings: showInnerMarkings
                }
            }

            VerticalGauge {
                // Section 6
                // HV SoC bar
                id: hvBar
                Layout.alignment: Qt.AlignVCenter
                width: 100
                height: 300
                highColour: "#FD5F00"
                medColour: "#FD5F00"
                lowColour: "red"
                barLabel: "HV"
                units: " V"
                value: hvVoltage
                secondValue: hvVoltage/100
                displaySecondVal:0
                maxValue: 428.4
                minValue: 200
                lowValue: 300
                backColour: backgroundColour
            }
            ColumnLayout {
                // Section 7
                id: rightIndicators
                spacing: 30
                width: 100
                CellStatus{
                    width: 210
                    height: 120
                    numberLit: cellVoltage < 3.42? 1 : cellVoltage < 3.83? 2 : 3
                    value: cellVoltage
                }

                InverterTemp {
                    width: 210
                    height: 120
                    numberLit: inverterTemp < 30? 1 : inverterTemp < 50? 2 : 3
                    value: inverterTemp
                }
                AIRStatus {
                    width: 210
                    height: 120
                    value: airValue
                }                
            }
        }
        Rectangle{
            id: dangerGlow
            anchors.fill: parent
            color: "transparent"
            visible: danger
            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "red" }
                    GradientStop { position: 0.08; color: "transparent" }
                }
            }
            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.92; color: "transparent" }
                    GradientStop { position: 1.0; color: "red" }
                }
            }
            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(parent.width, 0)
                gradient: Gradient {
                    GradientStop { position: 0.97; color: "transparent" }
                    GradientStop { position: 1.0; color: "red" }
                }
            }
            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(parent.width, 0)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "red" }
                    GradientStop { position: 0.03; color: "transparent" }
                }
            }

        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
