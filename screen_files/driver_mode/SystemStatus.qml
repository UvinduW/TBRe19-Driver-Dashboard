import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    property color lowColour: "red"
    property color medColour: "orange"
    property color highColour: "transparent"
    property color backColour: "#181818"
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

    property double widthRatio: 4
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 30
        Rectangle {
            id: vehicleStatus
            Layout.alignment: Qt.AlignCenter
            width: 210
            height: 300
            radius: 20
            color: "transparent" //"#FD5F00"
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 30
                Text {
                    id: txtShutdown
                    Layout.alignment: Qt.AlignCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                    text: qsTr("Vehicle Status")
                }
                GridLayout {
                    id: statusGrid
//                    anchors.centerIn: parent
                    columns: 3
                    rowSpacing: 40
                    columnSpacing: 20
                    onHeightChanged: console.log(statusGrid.height)
                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / 4
                        radius: 20
                        color: backColour
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / 4
                            glowRadius: 20
                            color: bspd == 0 ? highColour : bspd == 1 ? medColour: lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: bspd >= 1 ? "white" : Qt.lighter(backColour,
                                                                    1.5)
                            text: qsTr("BSPD")
                        }
                    }
                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / 4
                        radius: 20
                        color: backColour
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / 4
                            glowRadius: 20
                            color: imd == 0 ? highColour : imd == 1 ? medColour: lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: imd >= 1 ? "white" : Qt.lighter(backColour,
                                                                   1.5)
                            text: qsTr("IMD")
                        }
                    }
                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / widthRatio
                        radius: 20
                        color: backColour
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / widthRatio
                            glowRadius: 20
                            color: bms == 0 ? highColour : bms == 1 ? medColour: lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: bms >= 1 ? "white" : Qt.lighter(backColour,
                                                                   1.5)
                            text: qsTr("BMS")
                        }
                    }
                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / widthRatio
                        radius: 20
                        color: backColour
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / widthRatio
                            glowRadius: 20
                            color: ecu == 0 ? highColour : ecu == 1 ? medColour: lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: ecu >= 1 ? "white" : Qt.lighter(backColour,
                                                                   1.5)
                            text: qsTr("ECU")
                        }
                    }
                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / 4
                        radius: 20
                        color: backColour
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / 4
                            glowRadius: 20
                            color: inertia == 0 ? highColour : lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: inertia >= 1 ? "white" : Qt.lighter(
                                                      backColour, 1.5)
                            text: qsTr("INRT")
                        }
                    }
                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / 4
                        radius: 20
                        color: backColour
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / 4
                            glowRadius: 20
                            color: bots == 0 ? highColour : lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: bots == 1 ? "white" : Qt.lighter(backColour,
                                                                    1.5)
                            text: qsTr("BOTS")
                        }
                    }
                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / 4
                        radius: 20
                        color: backColour
                        visible: true
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / 4
                            glowRadius: 20
                            color: fuse == 0 ? highColour : lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: fuse == 1 ? "white" : Qt.lighter(backColour,
                                                                    1.5)
                            text: qsTr("FUSE")
                        }
                    }

                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / 4
                        radius: 20
                        color: backColour
                        visible: true
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / 4
                            glowRadius: 20
                            color: pcb == 0 ? highColour : lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: pcb == 1 ? "white" : Qt.lighter(backColour,
                                                                   1.5)
                            text: qsTr("PCB")
                        }
                    }

                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / 4
                        radius: 20
                        color: backColour
                        visible: true
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / 4
                            glowRadius: 20
                            color: estop == 0 ? highColour : lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: estop == 1 ? "white" : Qt.lighter(
                                                    backColour, 1.5)
                            text: qsTr("E-STP")
                        }
                    }

                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / 4
                        radius: 20
                        color: backColour
                        visible: true
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / 4
                            glowRadius: 20
                            color: tsms == 0 ? highColour : lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: tsms == 1 ? "white" : Qt.lighter(backColour,
                                                                    1.5)
                            text: qsTr("TSMS")
                        }
                    }

                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / 4
                        radius: 20
                        color: backColour
                        visible: true
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / 4
                            glowRadius: 20
                            color: hvd == 0 ? highColour : lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: hvd == 1 ? "white" : Qt.lighter(backColour,
                                                                   1.5)
                            text: qsTr("HVD")
                        }
                    }

                    Rectangle {
                        height: 50
                        width: vehicleStatus.width / 4
                        radius: 20
                        color: backColour
                        visible: true
                        RectangularGlow {
                            height: parent.height
                            width: vehicleStatus.width / 4
                            glowRadius: 20
                            color: interlock == 0 ? highColour : lowColour
                            z: -1
                        }
                        Text {
                            anchors.centerIn: parent
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 15
                            font.bold: true
                            font.family: "Eurostile"
                            color: interlock == 1 ? "white" : Qt.lighter(
                                                        backColour, 1.5)
                            text: qsTr("INTLK")
                        }
                    }
                }
            }
        }
    }
}
