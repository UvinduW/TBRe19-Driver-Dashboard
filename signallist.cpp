#include "signallist.h"

SignalList::SignalList()
{
    signalCount = 100;
    signal.resize(signalCount);

    for(int i =0; i < signalCount; i++)
    {
        signal.push_back(CANSignal());
    }

}
