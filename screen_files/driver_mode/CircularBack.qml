import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    property color background: "#181818"
    property color glowColour: "red"
//    Rectangle{
//        visible: false
//        anchors.centerIn: circularBack
//        width: circularBack.width * 1.01
//        height: width
//        radius: width * 0.5
//        color: glowColour
//    }

    Rectangle{
        id: circularBack
        anchors.centerIn: parent
        width: parent.width*0.85
        height: width
        radius: width*0.5
        color: background
        visible: true

    }
    RectangularGlow{
        anchors.centerIn: circularBack
        width: parent.width*0.7
        height: width
        glowRadius: 10
        spread: 0.5
        color: glowColour
        cornerRadius: width * 0.5
        z: -1
    }
}
