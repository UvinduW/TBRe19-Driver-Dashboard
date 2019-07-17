import QtQuick 2.0

Item {
    id: animator
    property int leftOffset: 0
    property int rightOffset: 0
    property int imageGlow: 0
    property double imageOpacity: 1
    property int leftBegin: 22
    property int rightBegin: 0
    property int leftCircle: 20
    property int rightCircle: 20
    property int glowDuration: 1000
    property int moveDuration: 250
    property int pauseDuration: 500
    property int circleDuration: 500
    property int fadeDUration: 1000//1000
    property int colourDuration: 3000
    property color startupSpeedColour: "#005dab"
    property color normalSpeedColour: "cyan"
    property color speedColour: "#005dab"
    property color startupPowerColour: "#ffc423"
    property color normalPowerColour: "#00ff00"
    property color powerColour: "#ffc423"
    property int startupMode: 0
    property int pauseCounter: 0
    onStartupModeChanged: {
        if (startupMode==1)
        {
            imageOpacity = 1
            leftOffset = 0
            rightOffset = 0
            leftCircle = leftBegin
            rightCircle = rightBegin
            speedColour = "#005dab"
            powerColour = "#ffc423"
            animGlow.start()
        }
    }

    PropertyAnimation {
        id: animGlow
        target: animator
        property: "imageGlow"
        from: 0
        to: 10
        duration: glowDuration
        loops: 1
        running: false
        onStopped: {
            animPause.start()
        }
    }
    PropertyAnimation {
        id: animPause
        target: animator
        property: "pauseCounter"
        from: 0
        to: 1000
        duration: pauseDuration
        easing.type: Easing.OutQuint
        loops: 1
        running: false
        onStopped: {
            animLeftOffset.start()
            animRightOffset.start()
            animDeGlow.start()
        }
    }

    PropertyAnimation {
        id: animLeftOffset
        target: animator
        property: "leftOffset"
        from: 0
        to: -255
        duration: moveDuration
        loops: 1
        running: false
        onStopped: {
            animLeftCircle.start()
            animRightCircle.start()
        }
    }
    PropertyAnimation {
        id: animRightOffset
        target: animator
        property: "rightOffset"
        from: 0
        to: 245
        duration: moveDuration
        loops: 1
        running: false
    }
    PropertyAnimation{
        id: animDeGlow
        target: animator
        property: "imageGlow"
        from: 10
        to: 0
        duration: glowDuration * 0.8
        loops: 1
        running: false
    }

    PropertyAnimation {
        id: animLeftCircle
        target: animator
        property: "leftCircle"
        from: leftBegin
        to: 220
        duration: circleDuration
        loops: 1
        running: false
        onStopped: {
            animOpacity.start()
        }
    }
    PropertyAnimation {
        id: animRightCircle
        target: animator
        property: "rightCircle"
        from: rightBegin
        to: 220
        duration: circleDuration
        loops: 1
        running: false
    }

    PropertyAnimation {
        id: animOpacity
        target: animator
        property: "imageOpacity"
        from: 1
        to: 0
        duration: fadeDUration
        loops: 1
        running: false
        onStopped: {
            animSpeedColour.start()
            animPowerColour.start()
        }
    }
    ColorAnimation {
        id: animSpeedColour
        from: startupSpeedColour
        to: normalSpeedColour
        duration: colourDuration
        target: animator
        property: "speedColour"
        running: false
    }

    ColorAnimation {
        id: animPowerColour
        from: startupPowerColour
        to: normalPowerColour
        duration: colourDuration
        target: animator
        property: "powerColour"
        running: false

    }

}
