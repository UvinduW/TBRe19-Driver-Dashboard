import QtQuick 2.0
import QtQuick.Layouts 1.11

Item {
    property int power: 60
    property int speed: 100
    property bool regen: false
    property int regenPower: 10
    onPowerChanged: {
        //console.log(power)
        regenPower = power - 50

        if (regenPower < 0)
        {
            regenPower = regenPower * -1
            regen = true
        }
        else
        {
            regen = false
        }
    }

    Rectangle{
        anchors.fill: parent
        color: "black"
        onHeightChanged: console.log(height)
        RowLayout{
            anchors.fill: parent
            anchors.centerIn: parent
            ColumnLayout{
                Layout.alignment: Qt.AlignRight
                spacing: 30
                Rectangle{
                    Layout.alignment: Qt.AlignRight
                    width: 200
                    height: 50
                    color: "cyan"
                }
                Rectangle{
                    Layout.alignment: Qt.AlignRight
                    width: 200
                    height: 50
                    color: "cyan"
                }
                Rectangle{
                    Layout.alignment: Qt.AlignRight
                    width: 200
                    height: 50
                    color: "cyan"
                }
            }
            ColumnLayout{
                Layout.alignment: Qt.AlignCenter

                RowLayout{
                    //anchors.centerIn: parent
                    Layout.alignment: Qt.AlignCenter
                    CircularGauge{
                        id: speedGauge
                        height: 400
                        width: 400
                        startPosition:180
                        regenEnabled: false
                        gauge_colour: "cyan"
                        gauge_value: speed
                    }
                    CircularGauge{
                        id: powerGauge
                        height: 400
                        width: 400
                        max_value: 100
                        startPosition: 240
                        regenEnabled: regen
                        gauge_colour: regen? "#00FF00" : "#FD5F00"
                        gauge_value:power
                    }
                }
                Rectangle
                {
                    Layout.alignment: Qt.AlignCenter
                    height: 50
                    width: 500
                    radius: 20

                    border.color: "#00FF00"
                    border.width: 2
                    color: "transparent"
                    Text {
                        id: driveState
                        anchors.centerIn: parent
                        font.pixelSize: 30
                        font.bold: true
                        font.family: "Eurostile"
                        color: "white"
                        text: qsTr("READY TO DRIVE")
                    }
                }
            }
            ColumnLayout{
                Layout.alignment: Qt.AlignLeft
                spacing: 30
                Rectangle{
                    Layout.alignment: Qt.AlignLeft
                    width: 200
                    height: 50
                    color: "#FD5F00"
                }
                Rectangle{
                    Layout.alignment: Qt.AlignLeft
                    width: 200
                    height: 50
                    color: "#FD5F00"
                }
                Rectangle{
                    Layout.alignment: Qt.AlignLeft
                    width: 200
                    height: 50
                    color: "#FD5F00"
                }
            }
        }
    }
}
