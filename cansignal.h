#ifndef CANSIGNAL_H
#define CANSIGNAL_H

#include <string>

class CANSignal
{
public:
    CANSignal();
    //CANSignal(std::string sigName, std::string frame, int frameID, int byteNum, int bitNum, int length, int byteOrder, float scale, float offset, double rawValue, double processedValue );
    std::string signalName;
    std::string frameName;
    int frameID;
    int byteNum;
    int bitNum;
    int length;
    int byteOrder;  // Intel or Motorolla (Big/Little Endian)
    float scale;
    float offset;
    double rawValue;
    double processedValue;  // = (scale x rawVal) + offset
};

#endif // CANSIGNAL_H
