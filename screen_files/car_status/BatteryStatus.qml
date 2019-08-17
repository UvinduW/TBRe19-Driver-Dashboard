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
            id: txtBMS
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
                    text: "Pack Temp: "
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
                    text: "Max Cell Temp: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: "380 V"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "Min Cell Temp: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: "200 A"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "Max Cell Voltage: "
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
                Text{
                    Layout.alignment: Qt.AlignRight
                    text: "100 kW"
                    font.pixelSize: itemSize
                    font.bold: true
                    font.family: "Eurostile"
                    color: "white"
                }
            }
            RowLayout{
                width: parent.width
                Text{
                    text: "Delta: "
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
