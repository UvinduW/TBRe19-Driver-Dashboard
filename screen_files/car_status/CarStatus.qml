import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Item {
    property color backgroundColour: "#181818"
    property int boxHeight: 230
    property int boxWidth: 280
    Text {
        id: txtTitle
        text: qsTr("Did you see that ludicrous display last night")
        font.pixelSize: 20
        font.bold: true
        font.family: "Eurostile"
        color: "white"
    }

    Rectangle {
        id: carStatusContainer
        anchors.fill: parent
        color: backgroundColour
        Image {
            id: backIm
            source: "/screen_files/driver_mode/carbon_fiber.jpg"
            fillMode: Image.Tile
            anchors.fill: parent
            opacity: 0.06
            visible: true
        }
        ColumnLayout {
            anchors.centerIn: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            spacing: 40
            RowLayout {
                //            anchors.horizontalCenter: parent.horizontalCenter
                //            anchors.verticalCenter: parent.verticalCenter
//                anchors.centerIn: parent
                //            anchors.fill: parent
//                anchors.leftMargin: 10
//                anchors.rightMargin: 10
                spacing: 40
                Rectangle {
                    height: boxHeight
                    width: boxWidth
                    radius: 20
                    color: "transparent"
                    RectangularGlow {
                        anchors.fill: motor
                        glowRadius: 10
                        spread: 0.2
                        color: "cyan"
                    }
                    MotorStatus {
                        id: motor
                        anchors.fill: parent
                    }
                }
                Rectangle {
                    height: boxHeight
                    width: boxWidth
                    radius: 20
                    color: "transparent"
                    RectangularGlow {
                        anchors.fill: inverter
                        glowRadius: 10
                        spread: 0.2
                        color: "cyan"
                    }
                    InverterStatus {
                        id: inverter
                        anchors.fill: parent
                    }
                }
                Rectangle {
                    height: boxHeight
                    width: boxWidth
                    radius: 20
                    color: "transparent"
                    RectangularGlow {
                        anchors.fill: bms
                        glowRadius: 10
                        spread: 0.2
                        color: "cyan"
                    }
                    BMSStatus {
                        id: bms
                        anchors.fill: parent
                    }
                }
                Rectangle {
                    height: boxHeight
                    width: boxWidth * 2
                    radius: 20
                    color: "transparent"
                    RectangularGlow {
                        anchors.fill: cellStatus
                        glowRadius: 10
                        spread: 0.2
                        color: "cyan"
                    }
                    CellStatus {
                        id: cellStatus
                        anchors.fill: parent
                    }
                }
            }
            Rectangle {
                height: 100
                width: 650
                radius: 20
                color: "transparent"
                Layout.alignment: Qt.AlignCenter
                RectangularGlow {
                    anchors.fill: otherStatus
                    glowRadius: 10
                    spread: 0.2
                    color: "cyan"
                }
                OtherStatus {
                    id: otherStatus
                    anchors.fill: parent
                }
            }
        }
    }
}
/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

