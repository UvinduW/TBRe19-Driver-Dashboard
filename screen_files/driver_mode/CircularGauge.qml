import QtQuick 2.0
import QtCharts 2.2
import QtQuick.Shapes 1.0
// This file creates a speed gauge using a Pie Chart generated with ChartView function

Item {
    property int gauge_value: 100     // Variable to hold the current speed;
    property bool regenEnabled: false
    property int max_value: regenEnabled? 50: 157 // Variable to hold the maximum possible speed
    property color gaugeColour: "red"
    property int startPosition: regenEnabled? 240 : 180
    property int endPosition: regenEnabled? 80 : (startPosition + 360)
    property string units: "kph"
    property color backColour: "#181818"
    property int showMarkings: 1
    onRegenEnabledChanged: {
        if (regenEnabled)
        {
            max_value = 50
        }
        else
        {
            max_value = 130
        }

        //console.log("Regen: " + regenEnabled + "  |  End Pos: " + endPosition)
    }
    CircularBack{
        anchors.centerIn: speedChart
        width: speedChart.width
        background: backColour
        glowColour: gaugeColour
        visible: true
    }

    ChartView {
        // Create a pie chart to show the speed
        id: speedChart
        width: 400 //parent.width
        height: width
        legend.visible:false
        antialiasing: true
        backgroundColor: "transparent"
//        onWidthChanged: console.log(width)


        PieSeries {
            // This PieSeries is used to draw the outermost thin ring
            id: outerRing
            size: 1         // Sets the relative size; 1 is the maximum; Size is relative to the size of the ChartView
            holeSize: 0.8  // Hole in the middle to make it a donut; difference between size & holeSize is 0.05, making it very thin
            startAngle: startPosition // Set start to be at the bottom (which is 180 position)
            endAngle: endPosition   // Set end angle to be a full circle from start angle
            PieSlice { id: speedsliceOuter; value: gauge_value; color: gaugeColour; borderColor: "transparent"; } // Fills the appropriate area with cyan colour
            PieSlice { id: blackOuter; value: max_value - gauge_value; color: backColour; borderColor: "transparent" } // Fills the remainder of the circle with black
        }

        PieSeries {
            // This PieSeries is used to draw the thick middle ring
            id: middleRing
            size: Math.abs(gauge_value)>0? 0.81 : 1//0.9       // Relative size set to be slightly smaller than outerRing in order to leave a gap
            holeSize: 0.75 //0.7   // Hole in the middle to make it a donut; difference between size & holeSize is 0.2, making it thicker
            startAngle: startPosition // Set start to be at the bottom (which is 180 position)
            endAngle: endPosition   // Set end angle to be a full circle from start angle
            PieSlice { id: speedslice; value: max_value*0.005; color: gaugeColour; borderColor: "transparent"; } // Fills the appropriate area with cyan colour
            PieSlice { id: black; value: max_value*(1-0.01); color: backColour; borderColor: "transparent" } // Fills the remainder of the circle with black
        }
//        PieSeries {
//            // This PieSeries is used to draw the thick middle ring
//            id: borderRing
//            size: 1//0.9       // Relative size set to be slightly smaller than outerRing in order to leave a gap
//            holeSize: 0.998 //0.7   // Hole in the middle to make it a donut; difference between size & holeSize is 0.2, making it thicker
//            startAngle: 0 // Set start to be at the bottom (which is 180 position)
//            endAngle: 360   // Set end angle to be a full circle from start angle
//            PieSlice { id: borderlice; value: 360; color: gaugeColour; borderColor: "transparent"; } // Fills the appropriate area with cyan colour
//        }
    }

    Shape {
        // Draw a circle with parts of its colour made transparent with an animation
        // such that it appears to be a pulsating ring
        id: glowCircle
        width: 100
        height: 100
        z:5
        anchors.centerIn: parent
        property real rad: 90
        ShapePath {
            // Draw circle using PathArcs
            strokeWidth: 2
            strokeColor: "transparent"
            startX: glowCircle.width/2 - glowCircle.rad
            startY: glowCircle.height/2 - glowCircle.rad

            fillGradient: RadialGradient {
                // Makes parts of the circle coloured and parts of it transparent
                // This makes it look like a ring. Value of pos is varied to make pulsating ring

                id: gradient
                property real pos: (Math.abs(gauge_value)*0.4/max_value)+0.6 //0.3

                centerX: glowCircle.width/2
                centerY: glowCircle.height/2
                centerRadius: glowCircle.rad*1.3
                focalX: centerX; focalY: centerY
                GradientStop { position: 0; color: "transparent" }
                //GradientStop { position: 0.2; color: gauge_colour }
                //GradientStop { position: 0.65; color: "transparent" }
                GradientStop { position: gradient.pos - 0.1; color: "transparent" }
                GradientStop { position: gradient.pos; color: gaugeColour }
                GradientStop { position: gradient.pos + 0.1; color: "transparent" }
            }
            PathArc {
                // Defins first half of circle
                x: glowCircle.width/2 + glowCircle.rad
                y: glowCircle.height/2 + glowCircle.rad
                radiusX: glowCircle.rad
                radiusY: glowCircle.rad
                useLargeArc: true
            }
            PathArc {
                // Defines second half of circle
                x: glowCircle.width/2 - glowCircle.rad
                y: glowCircle.height/2 - glowCircle.rad
                radiusX: glowCircle.rad
                radiusY: glowCircle.rad
                useLargeArc: true
            }
        }

        Text{
            // Displays the value as text at the centre of the gauge
            property real shade_amount: 1.6
            id: txtValue
            anchors.centerIn: parent
            font.pixelSize: 60
            font.bold: true
            font.family: "Eurostile"
            color: Qt.lighter(gaugeColour, shade_amount)    // Make value a lighter colour than the rings
            text: Math.round(gauge_value)
            z:3
        }
        Text{
            // Displays the value as text at the centre of the gauge
            property real shade_amount: 1.6
            id: txtUnits
            anchors.top: txtValue.bottom
            anchors.horizontalCenter: txtValue.horizontalCenter
            font.pixelSize: 20
            font.bold: true
            font.family: "Eurostile"
            color: Qt.lighter(gaugeColour, shade_amount)    // Make value a lighter colour than the rings
            text: units
            z:3
        }
        InnerMarks{
            anchors.centerIn: parent
            width: 250
            height: 250
            z:2
            visible: showMarkings
        }

//        Image {
//            id: markings
//            source: "InnerMarks.png"
//            anchors.centerIn: parent
//            width: 250
//            height: 250
//            visible: true
//            z:2
//        }


    }
//    ColorOverlay{
//        anchors.fill: markings
//        source: markings
//        color: backColour
//    }
}
