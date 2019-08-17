import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    property color backgroundColour: "#181818"
    property int titleSize: 25
    property int itemSize: 20
    color: backgroundColour
    radius: 10
    ColumnLayout {
//        anchors.fill: parent
        spacing: 20
        anchors.centerIn: parent
        Text {
            id: txtInverter
            Layout.alignment: Qt.AlignCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: titleSize
            font.bold: true
            font.family: "Eurostile"
            color: "white"
            text: qsTr("Inverter Status")
        }
        ColumnLayout {
            id: statusGrid
            spacing: 10
            onHeightChanged: console.log(statusGrid.height)
            RowLayout{
                width: parent.width
                Text{
                    text: "Inverter Temp: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: dash.inverterTemp + " °C"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "Inverter Voltage: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: dash.inverterVoltage + " V"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "Inverter Current: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: dash.inverterCurrent + " A"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "Inverter Power: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: dash.inverterPower + " kW"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "Inverter Status: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: dash.inverterStatus
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
        }
    }
}
