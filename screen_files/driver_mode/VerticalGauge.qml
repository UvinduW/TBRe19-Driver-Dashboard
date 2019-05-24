import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.12

Item {
    property color lowColour: "cyan"
    property color medColour: "#FD5F00"
    property color highColour: "red"
    property string barLabel: "LV"
    property string units: " °C"
    property int lowValue: 40
    property int highValue: 55
    property int displaySecondVal: 0
    property double value: 0.5
    property double secondValue: 0
    property double maxValue: 1
    property double minValue: 0
    property color backColour: "#181818"

    ColumnLayout {
        spacing: 10
//        anchors.fill: parent
        Text{
            text: displaySecondVal? Math.round(value*10)/10 + units + "; " + Math.round(secondValue*10)/10 + units : Math.round(value) + units
            Layout.alignment: Qt.AlignCenter
            width: outerBox.width
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.Fit
            font.pixelSize: displaySecondVal? 15: 20
            font.bold: true
            font.family: "Eurostile"
            color: "white"
        }

        Rectangle {
            id: outerBox
//            Layout.alignment: Qt.AlignCenter
            width: 100 //parent.parent.width
            height: parent.parent.height - txtBarLabel.height
            color: backColour
            border.color: value < lowValue? lowColour: value > highValue? highColour: medColour
            border.width: 1.5
            radius: 10
            RectangularGlow{
                anchors.fill: outerBox
                glowRadius: 10
                spread: 0.2
                color: value < lowValue? lowColour: value > highValue? highColour: medColour
                cornerRadius: outerBox.radius + glowRadius
                z: -1
            }

            Rectangle {
                id: innerBox
                width: parent.width
                height: value < maxValue? ((value-minValue)/(maxValue-minValue)) * parent.height: parent.height
                anchors.bottom: parent.bottom
                color: value < lowValue? lowColour: value > highValue? highColour: medColour
                radius: 10
            }
        }

        Text {
            id: txtBarLabel
            Layout.alignment: Qt.AlignCenter
            width: outerBox.width
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.Fit
            font.pixelSize: 20
            font.bold: true
            font.family: "Eurostile"
            color: "white"
            text: qsTr(barLabel)
        }
    }
}
