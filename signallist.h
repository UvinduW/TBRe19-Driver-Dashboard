#ifndef SIGNALLIST_H
#define SIGNALLIST_H

#include "cansignal.h"
#include <vector>

class SignalList
{
public:
    SignalList();
    std::vector<CANSignal> signal;

private:
    int signalCount;
};

#endif // SIGNALLIST_H
