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
        anchors.centerIn: parent
        spacing: 20
        Text {
            id: txtOther
            Layout.alignment: Qt.AlignCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: titleSize
            font.bold: true
            font.family: "Eurostile"
            color: "white"
            text: qsTr("Other")
        }
        RowLayout {
            width: parent.width
            spacing: 30
            Text {
                text: "LV Voltage: " + dash.lvVoltage + " V"
                font.pixelSize: itemSize
                font.bold: true
                font.family: "Eurostile"
                color: "white"
            }
            Text {
                Layout.alignment: Qt.AlignRight
                text: "Insulation Strength: " + dash.imdInsulation + " kOhm"
                font.pixelSize: itemSize
                font.bold: true
                font.family: "Eurostile"
                color: "white"
            }
        }
    }
}
