import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.12

Item {
    property color lowColour: "red"
    property color medColour: "orange"
    property color highColour: "#00FF00"
    property color backColour: "#181818"
    property double value: 2
    property color litColour: value > 1 ? highColour : value > 0 ? medColour : lowColour
    ColumnLayout {
        //        anchors.centerIn: parent
        spacing: 30
        Text {
            id: txtAIRStatus
            Layout.alignment: Qt.AlignCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
            font.bold: true
            font.family: "Eurostile"
            color: "white"
            text: qsTr("AIR Status")
        }
        Rectangle {
            id: airStatus
            Layout.alignment: Qt.AlignLeft
            width: 210
            height: 50
            radius: 20
            color: backColour //"#FD5F00"
            RowLayout {
                anchors.fill: parent
                spacing: 0
                Rectangle {
                    height: airStatus.height
                    width: airStatus.width / 4
                    radius: 20
                    color: backColour
                    RectangularGlow {
                        height: airStatus.height
                        width: airStatus.width / 4
                        glowRadius: 20
                        color: value == 0 ? litColour : "transparent"
                        z: -1
                    }
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 20
                        font.bold: true
                        font.family: "Eurostile"
                        color: value == 0 ? "white" : Qt.lighter(backColour, 1.5)
                        text: qsTr("0")
                    }
                }
                Rectangle {
                    height: airStatus.height
                    width: airStatus.width / 4
                    radius: 20
                    color: value > 0 ? backColour : "transparent"
                    RectangularGlow {
                        height: airStatus.height
                        width: airStatus.width / 4
                        glowRadius: 20
                        color: value == 1 ? litColour : "transparent"
                        z: -1
                    }
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 20
                        font.bold: true
                        font.family: "Eurostile"
                        color: value == 1 ? "white" : Qt.lighter(backColour, 1.5)
                        text: qsTr("1")
                    }
                }
                Rectangle {
                    height: airStatus.height
                    width: airStatus.width / 4
                    radius: 20
                    color: value > 1 ? backColour: "transparent"
                    RectangularGlow {
                        height: airStatus.height
                        width: airStatus.width / 4
                        glowRadius: 20
                        color: value == 2 ? litColour : "transparent"
                        z: -1
                    }
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 20
                        font.bold: true
                        font.family: "Eurostile"
                        color: value == 2 ? "white" : Qt.lighter(backColour, 1.5)
                        text: qsTr("2")
                    }
                }
            }
        }
    }
}
