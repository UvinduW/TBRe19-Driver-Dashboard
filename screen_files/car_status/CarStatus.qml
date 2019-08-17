import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Item {
    property color backgroundColour: "#181818"
    Text {
        id: txtTitle
        text: qsTr("Did you see that ludicrous display last night")
        font.pixelSize: 20
        font.bold: true
        font.family: "Eurostile"
        color: "white"
    }

    Rectangle{
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
        RowLayout{
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.verticalCenter: parent.verticalCenter
            anchors.centerIn: parent
//            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            spacing: 20
            Rectangle{
                height: 220
                width: 260
                color: "transparent"
                RectangularGlow{
                    anchors.fill: motor
                    glowRadius: 10
                    spread: 0.2
                    color: "cyan"
                }
                MotorStatus{
                    id: motor
                    anchors.fill: parent
                }
            }
            Rectangle{
                height: 220
                width: 260
                color: "transparent"
                RectangularGlow{
                    anchors.fill: inverter
                    glowRadius: 10
                    spread: 0.2
                    color: "cyan"
                }
                InverterStatus{
                    id: inverter
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
