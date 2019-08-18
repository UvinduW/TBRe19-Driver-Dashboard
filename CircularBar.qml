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
            holeSize: 0.85  // Hole in the middle to make it a donut; difference between size & holeSize is 0.05, making it very thin
            startAngle: startPosition // Set start to be at the bottom (which is 180 position)
            endAngle: endPosition   // Set end angle to be a full circle from start angle
            PieSlice { id: speedsliceOuter; value: gauge_value; color: gaugeColour; borderColor: "transparent"; } // Fills the appropriate area with cyan colour
            PieSlice { id: blackOuter; value: max_value - gauge_value; color: "transparent"; borderColor: "transparent" } // Fills the remainder of the circle with black
        }
    }
}
