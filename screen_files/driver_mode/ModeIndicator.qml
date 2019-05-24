import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.12
Item {
    id: modeIndicatorParent
    property int boxWidth: 80
    property int boxHeight: 40
    property int mode: 3
    property int activeFontSize: 30
    property int inactiveFontSize: 18
    property color backColour: "#181818"
    property color lightColour: mode == 0? "red": mode == 1? "#FD5F00": mode == 2? "#ffbf00": "#00FF00"
    onModeChanged: {
        activeFontSizeChanger.restart()
        //inactiveFontSizeChanger.restart()
    }
    PropertyAnimation{
        id: activeFontSizeChanger
        target: modeIndicatorParent
        property: "activeFontSize"
        from: 30*0.6
        to: 30
        duration: 250
        loops: 1
        easing.type: Easing.OutQuad
    }
    Rectangle{
        anchors.fill: parent
        color: backColour
        radius: 30
    }

    ColumnLayout{
        anchors.centerIn: parent
        anchors.fill: parent
        spacing: 10
        Rectangle{
            Layout.alignment: Qt.AlignCenter
            width: boxWidth
            height: boxHeight
            radius: 30
            color: mode == 0? backColour : backColour
            border.color: mode == 0? lightColour: backColour
            Text {
                id: txtErr
                anchors.centerIn: parent
                anchors.fill: parent
                font.pixelSize: mode == 0? activeFontSize : inactiveFontSize
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                //minimumPixelSize: fontSize
                font.bold: true
                font.family: "Eurostile"
                color:  mode == 0? lightColour: "grey"
                text: qsTr("ERR")
            }
        }
        Rectangle{
            Layout.alignment: Qt.AlignCenter
            width: boxWidth
            height: boxHeight
            radius: 30
            color: mode == 1? backColour : backColour
            border.color: mode == 1? lightColour: backColour
            Text {
                id: txtStb
                anchors.centerIn: parent
                anchors.fill: parent
                font.pixelSize: mode == 1? activeFontSize : inactiveFontSize
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Eurostile"
                color: mode == 1? lightColour: "grey"
                text: qsTr("STB")
            }
        }
        Rectangle{
            Layout.alignment: Qt.AlignCenter
            width: boxWidth
            height: boxHeight
            radius: 30
            color: mode == 2? backColour : backColour
            border.color: mode == 2? lightColour: backColour
            Text {
                id: txtBuz
                anchors.centerIn: parent
                anchors.fill: parent
                font.pixelSize: mode == 2? activeFontSize : inactiveFontSize
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Eurostile"
                color: mode == 2? lightColour : "grey"
                text: qsTr("BUZ")
            }
        }
        Rectangle{
            Layout.alignment: Qt.AlignCenter
            width: boxWidth
            height: boxHeight
            radius: 30
            color: mode == 3? backColour : backColour
            border.color: mode == 3? lightColour : backColour
            Text {
                id: txtRtd
                anchors.centerIn: parent
                anchors.fill: parent
                font.pixelSize: mode == 3? activeFontSize : inactiveFontSize
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Eurostile"
                color: mode == 3? lightColour : "grey"
                text: qsTr("RTD")
            }
        }
    }
}
