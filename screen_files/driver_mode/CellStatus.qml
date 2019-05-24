import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.12

Item {
    property color lowColour: "red"
    property color medColour: "orange"
    property color highColour: "#00FF00"
    property color backColour: "#181818"
    property double value: 25.7
    property int numberLit: 3
    property color litColour: numberLit > 2 ? highColour : numberLit > 1 ? medColour : lowColour
    ColumnLayout {
        //        anchors.centerIn: parent
        spacing: 30
        Text {
            id: txtCellVoltage
            Layout.alignment: Qt.AlignCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
            font.bold: true
            font.family: "Eurostile"
            color: "white"
            text: qsTr("Cell Voltage: " + Math.round(value*10)/10 + " V")
        }
        Rectangle {
            id: cellVoltage
            Layout.alignment: Qt.AlignLeft
            width: 210
            height: 50
            radius: 20
            color: backgroundColour //"#FD5F00"
            RowLayout {
                anchors.fill: parent
                spacing: 0
                Rectangle {
                    height: cellVoltage.height
                    width: cellVoltage.width / 4
                    radius: 20
                    color: numberLit == 1 ?backColour : "transparent"
                    RectangularGlow {
                        height: cellVoltage.height
                        width: cellVoltage.width / 4
                        glowRadius: 20
                        color: numberLit == 1 ? litColour : "transparent"
                        z: -1
                    }
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 20
                        font.bold: true
                        font.family: "Eurostile"
                        color: numberLit == 1 ? "white" : Qt.lighter(backColour, 1.5)
                        text: qsTr("L")
                    }
                }
                Rectangle {
                    height: cellVoltage.height
                    width: cellVoltage.width / 4
                    radius: 20
                    color: numberLit == 2 ?backColour : "transparent"
                    RectangularGlow {
                        height: cellVoltage.height
                        width: cellVoltage.width / 4
                        glowRadius: 20
                        color: numberLit == 2 ? litColour : "transparent"
                        z: -1
                    }
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 20
                        font.bold: true
                        font.family: "Eurostile"
                        color: numberLit == 2 ? "white" : Qt.lighter(backColour, 1.5)
                        text: qsTr("M")
                    }
                }
                Rectangle {
                    height: cellVoltage.height
                    width: cellVoltage.width / 4
                    radius: 20
                    color: numberLit == 3 ?backColour : "transparent"
                    RectangularGlow {
                        height: cellVoltage.height
                        width: cellVoltage.width / 4
                        glowRadius: 20
                        color: numberLit == 3 ? litColour : "transparent"
                        z: -1
                    }
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 20
                        font.bold: true
                        font.family: "Eurostile"
                        color: numberLit == 3 ? "white" : Qt.lighter(backColour, 1.5)
                        text: qsTr("H")
                    }
                }
            }
        }
    }
}
