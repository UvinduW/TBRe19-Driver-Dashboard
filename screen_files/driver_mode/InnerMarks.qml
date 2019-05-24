import QtQuick 2.0
import QtGraphicalEffects 1.12

Item {
    Image {
        id: markings
        source: "InnerMarks.png"
        anchors.centerIn: parent
        width: 250
        height: 250
        visible: true
    }

    ColorOverlay{
        anchors.fill: markings
        source: markings
        color: backColour
    }
}
