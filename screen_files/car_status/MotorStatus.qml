import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    property color backgroundColour: "#181818"
    property int titleSize: 25
    property int itemSize: 20
    color: backgroundColour
    ColumnLayout {
//        anchors.fill: parent
        spacing: 20
        Text {
            id: txtMotor
            Layout.alignment: Qt.AlignCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: titleSize
            font.bold: true
            font.family: "Eurostile"
            color: "white"
            text: qsTr("Motor Status")
        }
        ColumnLayout {
            id: statusGrid
            spacing: 10
            onHeightChanged: console.log(statusGrid.height)
            RowLayout{
                width: parent.width
                Text{
                    text: "Motor Temp: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: dash.motorTemp + " °C"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "Motor Speed: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: "2300 RPM"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "Motor Torque: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: "100 Nm"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "Motor Power: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: "40 kW"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "Motor Status: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: "Good"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
        }
    }
}
