import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.12

Item {
    property color lowColour: "red"
    property color medColour: "orange"
    property color highColour: "#00FF00"
    property color backColour: "#181818"
    property int ecu: 0
    property int bms: 0
    property int inertia: 0
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
        Rectangle {
            id: vehicleStatus
            Layout.alignment: Qt.AlignLeft
            width: 210
            height: 50
            radius: 20
            color: backColour //"#FD5F00"
            RowLayout {
                anchors.fill: parent
                spacing: 0
                Rectangle {
                    height: vehicleStatus.height
                    width: vehicleStatus.width / 3
                    radius: 20
                    color: backColour
                    RectangularGlow {
                        height: vehicleStatus.height
                        width: vehicleStatus.width / 3
                        glowRadius: 20
                        color: bms == 0 ? highColour: lowColour
                        z: -1
                    }
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 15
                        font.bold: true
                        font.family: "Eurostile"
                        color: bms == 1 ? "white" : Qt.lighter(backColour, 1.5)
                        text: qsTr("BMS")
                    }
                }
                Rectangle {
                    height: vehicleStatus.height
                    width: vehicleStatus.width / 3
                    radius: 20
                    color: backColour
                    RectangularGlow {
                        height: vehicleStatus.height
                        width: vehicleStatus.width / 3
                        glowRadius: 20
                        color: ecu == 0 ? highColour: lowColour
                        z: -1
                    }
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 15
                        font.bold: true
                        font.family: "Eurostile"
                        color: ecu == 1 ? "white" : Qt.lighter(backColour, 1.5)
                        text: qsTr("ECU")
                    }
                }
            }
        }
    }
}
