import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.12

Item {
    property color lowColour: "red"
    property color medColour: "orange"
    property color highColour: "#00FF00"
    property color backColour: "#181818"
    property int bspd: 0
    property int bots: 0
    property int inertia: 0
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 30
        Text {
            id: txtShutdown
            Layout.alignment: Qt.AlignCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
            font.bold: true
            font.family: "Eurostile"
            color: "white"
            text: qsTr("Shutdown Status")
        }
        Rectangle {
            id: shutdownStatus
            Layout.alignment: Qt.AlignLeft
            width: 210
            height: 50
            radius: 20
            color: backColour //"#FD5F00"
            RowLayout {
                anchors.fill: parent
                spacing: 0
                Rectangle {
                    height: shutdownStatus.height
                    width: shutdownStatus.width / 4
                    radius: 20
                    color: backColour
                    RectangularGlow {
                        height: shutdownStatus.height
                        width: shutdownStatus.width / 4
                        glowRadius: 20
                        color: bots == 0 ? highColour: lowColour
                        z: -1
                    }
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 15
                        font.bold: true
                        font.family: "Eurostile"
                        color: bots == 1 ? "white" : Qt.lighter(backColour, 1.5)
                        text: qsTr("BOTS")
                    }
                }
                Rectangle {
                    height: shutdownStatus.height
                    width: shutdownStatus.width / 4
                    radius: 20
                    color: backColour
                    RectangularGlow {
                        height: shutdownStatus.height
                        width: shutdownStatus.width / 4
                        glowRadius: 20
                        color: bspd == 0 ? highColour: lowColour
                        z: -1
                    }
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 15
                        font.bold: true
                        font.family: "Eurostile"
                        color: bspd == 1 ? "white" : Qt.lighter(backColour, 1.5)
                        text: qsTr("BSPD")
                    }
                }
                Rectangle {
                    height: shutdownStatus.height
                    width: shutdownStatus.width / 4
                    radius: 20
                    color: backColour
                    RectangularGlow {
                        height: shutdownStatus.height
                        width: shutdownStatus.width / 4
                        glowRadius: 20
                        color: inertia == 0 ? highColour: lowColour
                        z: -1
                    }
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 15
                        font.bold: true
                        font.family: "Eurostile"
                        color: inertia == 1 ? "white" : Qt.lighter(backColour, 1.5)
                        text: qsTr("INRT")
                    }
                }
            }
        }
    }
}
