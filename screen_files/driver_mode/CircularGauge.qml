import QtQuick 2.0
import QtCharts 2.2
import QtQuick.Shapes 1.0
// This file creates a speed gauge using a Pie Chart generated with ChartView function

Item {
    property int gauge_value: 100     // Variable to hold the current speed;
    property int max_value: 130 // Variable to hold the maximum possible speed
    property color gauge_colour: "red"
    property bool regenEnabled: false
    property int startPosition: regen? 240 : 180
    ChartView {
        // Create a pie chart to show the speed
        id: speedChart
        width: parent.width
        height: parent.width
        legend.visible:false
        antialiasing: true
        backgroundColor: "transparent"
        PieSeries {
            // This PieSeries is used to draw the outermost thin ring
            id: outerRing
            size: 1         // Sets the relative size; 1 is the maximum; Size is relative to the size of the ChartView
            holeSize: 0.95  // Hole in the middle to make it a donut; difference between size & holeSize is 0.05, making it very thin
            startAngle: startPosition // Set start to be at the bottom (which is 180 position)
            endAngle: regenEnabled? 180: startPosition + 360   // Set end angle to be a full circle from start angle
            PieSlice { id: speedsliceOuter; value: gauge_value; color: gauge_colour; borderColor: "transparent"; } // Fills the appropriate area with cyan colour
            PieSlice { id: blackOuter; value: max_value - gauge_value; color: "black"; borderColor: "transparent" } // Fills the remainder of the circle with black
        }

        PieSeries {
            // This PieSeries is used to draw the thick middle ring
            id: middleRing
            size: 0.9       // Relative size set to be slightly smaller than outerRing in order to leave a gap
            holeSize: 0.7   // Hole in the middle to make it a donut; difference between size & holeSize is 0.2, making it thicker
            startAngle: startPosition // Set start to be at the bottom (which is 180 position)
            endAngle: regenEnabled? 180: startPosition + 360   // Set end angle to be a full circle from start angle
            PieSlice { id: speedslice; value: gauge_value; color: gauge_colour; borderColor: "transparent"; } // Fills the appropriate area with cyan colour
            PieSlice { id: black; value: max_value - gauge_value; color: "black"; borderColor: "transparent" } // Fills the remainder of the circle with black
        }

        PieSeries{
            // This PieSeries is used to draw the inner thin ring
            id: innerRing
            size: 0.65      // Relative size is even smaller
            holeSize:0.6    // Hole in the middle to make it a donut; difference between size & holeSize is 0.05, making it very thin
            startAngle: startPosition // Set start to be at the bottom (which is 180 position)
            endAngle: regenEnabled? 180: startPosition + 360   // Set end angle to be a full circle from start angle
            PieSlice { id: speedsliceInner; value: gauge_value; color: gauge_colour; borderColor: "transparent"; } // Fills the appropriate area with cyan colour
            PieSlice { id: blackInner; value: max_value - gauge_value; color: "black"; borderColor: "transparent" } // Fills the remainder of the circle with black
        }
    }

    Shape {
        // Draw a circle with parts of its colour made transparent with an animation
        // such that it appears to be a pulsating ring
        id: glowCircle
        width: 100
        height: 100
        anchors.centerIn: parent
        property real rad: 80
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
                property real pos: 0.3

                centerX: glowCircle.width/2
                centerY: glowCircle.height/2
                centerRadius: glowCircle.rad*1.3
                focalX: centerX; focalY: centerY
                GradientStop { position: 0; color: "transparent" }
                //GradientStop { position: 0.2; color: gauge_colour }
                GradientStop { position: 0.65; color: "transparent" }
                GradientStop { position: gradient.pos - 0.1; color: "transparent" }
                GradientStop { position: gradient.pos; color: gauge_colour }
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

        PropertyAnimation {
            // Changes the value of gradient pos to make it pulsate (incrementing pos value)
            id: gradAnimationUp
            target: gradient
            property: "pos"
            from: 0.8
            to: 0.9
            duration: 1500//200000*(1/speed)
            loops: 1
            easing.type: Easing.OutCubic
            running: true
            onStarted: {
                // Pause decrement when this animation is active
                gradAnimationDown.pause()
            }

            onStopped:{
                // Start decrement once this animation has finished
                gradAnimationDown.resume()

            }
        }
        PropertyAnimation {
            // Changes the value of gradient pos to make it pulsate (decrementing pos value)
            id: gradAnimationDown
            target: gradient
            property: "pos"
            from: 0.9
            to: 0.8
            duration: 1500//200000*(1/speed)
            loops: 1
            easing.type: Easing.InCubic
            running: true
            onStopped:{
                // When this animation finishes, restart it and also start increment.
                // Increment object will pause this animation, so restart is okay to do here
                gradAnimationDown.restart()
                gradAnimationUp.start()
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
            color: Qt.lighter(gauge_colour, shade_amount)    // Make value a lighter colour than the rings
            text: Math.round(gauge_value)
        }
        PropertyAnimation {
            // Changes the value of text shading (incrementing shade_amount value)
            id: textAnimateUp
            target: txtValue
            property: "shade_amount"
            from: 0.9
            to: 1.7
            duration: 1500//200000*(1/speed)
            loops: 1
            easing.type: Easing.OutCubic
            running: true
            onStarted: {
                // Pause decrement when this animation is active
                textAnimateDown.pause()
            }

            onStopped:{
                // Start decrement once this animation has finished
                textAnimateDown.resume()

            }
        }
        PropertyAnimation {
            // Changes the value of text shading (decrementing shade_amount value)
            id: textAnimateDown
            target: txtValue
            property: "shade_amount"
            from: 1.7
            to: 0.9
            duration: 1500//200000*(1/speed)
            loops: 1
            easing.type: Easing.InCubic
            running: true
            onStopped:{
                // When this animation finishes, restart it and also start increment.
                // Increment object will pause this animation, so restart is okay to do here
                textAnimateDown.restart()
                textAnimateUp.start()
            }
        }
    }

}
