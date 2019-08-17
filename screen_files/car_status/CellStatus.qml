import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    property color backgroundColour: "#181818"
    property int titleSize: 25
    property int itemSize: 20
    color: backgroundColour
    radius: 10
    ColumnLayout {
        spacing: 20
        anchors.centerIn: parent
        height: parent.height
        Text {
            id: txtInverter
            Layout.alignment: Qt.AlignCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: titleSize
            font.bold: true
            font.family: "Eurostile"
            color: "white"
            text: qsTr("Cell Status")
        }
        RowLayout {
            spacing: 60
            ColumnLayout {
                id: voltageStats
                spacing: 10
                RowLayout {
                    width: parent.width
                    Text {
                        text: "Max Voltage: "
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                    Text {
                        Layout.alignment: Qt.AlignRight
                        text: Math.round(dash.maxCellVoltage*100)/100 + " V"
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                }
                RowLayout {
                    width: parent.width
                    Text {
                        text: "Min Voltage: "
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                    Text {
                        Layout.alignment: Qt.AlignRight
                        text: Math.round(dash.minCellVoltage*100)/100 + " V"
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                }
                RowLayout {
                    width: parent.width
                    Text {
                        text: "Avg Voltage: "
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                    Text {
                        Layout.alignment: Qt.AlignRight
                        text: Math.round(dash.avgCellVoltage*100)/100 + " V"
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                }
                RowLayout {
                    width: parent.width
                    Text {
                        text: "Delta Voltage: "
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                    Text {
                        Layout.alignment: Qt.AlignRight
                        text: Math.round((dash.maxCellVoltage - dash.minCellVoltage)*100)/100 + " V"
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                }
            }

            ColumnLayout {
                id: tempStats
                spacing: 10
                Layout.alignment: Qt.AlignTop
                RowLayout {
                    width: parent.width
                    Text {
                        text: "Max Temp: "
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                    Text {
                        Layout.alignment: Qt.AlignRight
                        text: Math.round(dash.maxCellTemp*100)/100 + " °C"
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                }
                RowLayout {
                    width: parent.width
                    Text {
                        text: "Min Temp: "
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                    Text {
                        Layout.alignment: Qt.AlignRight
                        text: Math.round(dash.minCellTemp*100)/100 + " °C"
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                }
                RowLayout {
                    width: parent.width
                    Text {
                        text: "Avg Temp: "
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                    Text {
                        Layout.alignment: Qt.AlignRight
                        text: Math.round(dash.avgCellTemp*100)/100 + " °C"
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                }
                RowLayout {
                    width: parent.width
                    Text {
                        text: "Delta Temp: "
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                    Text {
                        Layout.alignment: Qt.AlignRight
                        text: Math.round((dash.maxCellTemp - dash.minCellTemp)*100)/100 + " °C"
                        font.pixelSize: itemSize
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                    }
                }
            }
        }
    }
}
