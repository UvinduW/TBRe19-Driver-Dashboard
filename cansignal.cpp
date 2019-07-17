#include "cansignal.h"

CANSignal::CANSignal()
{
    // Initialise all variables
    signalName = "";
    frameName = "";
    frameID = -1;
    byteNum = -1;
    bitNum = -1;
    length = -1;
    byteOrder = -1;
    scale = 1;
    offset = 0;
    rawValue = -1;
    processedValue = -1;
}
