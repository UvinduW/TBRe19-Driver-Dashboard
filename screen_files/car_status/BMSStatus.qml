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
            text: qsTr("BMS Status")
        }
        ColumnLayout {
            id: statusGrid
            spacing: 10
            onHeightChanged: console.log(statusGrid.height)
            RowLayout{
                width: parent.width
                Text{
                    text: "Heatsink Temp: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: dash.bmsTemp + " °C"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "BMS Voltage: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: dash.bmsVoltage + " V"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "BMS Current: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: dash.bmsCurrent + " A"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "BMS Power: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: dash.power + " kW"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "BMS Status: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: ""
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
        }
    }
}
