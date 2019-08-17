#include "dash.h"
#include <QBitArray>
//#include "signallist.h"
#define _USE_MATH_DEFINES
#include <math.h>
#define PI 3.1415926536

#include <QThread>
//#include <QDateTime>
//#define PIMODE

#ifdef PIMODE
    #include <wiringPi.h>
#endif

// Setup the CAN IDs
// Standard
#define BMS_Feedback_1 0x100
#define BMS_Feedback_2 0x101
#define BMS_Feedback_3 0x102
#define VCU_1 0x503
#define VCU_HW_IO 0x701
#define VCU_Vehicle_Functionality 0x704
#define Shutdown_Data 0x705

//Extended
#define HD4_Debug_Temperatures_B 0x192BFF71
#define HS3_Temperature_Feedback 0x191AFF71
#define HS1_Torque_Feedback 0x1918FF71

//Shutdown message configuration
#define fault_active 1
#define fault_free 0


dash::dash(QObject *parent): QObject(parent)
{
    #ifdef PIMODE
        wiringPiSetup () ;
        pinMode(1, OUTPUT);
        pinMode(3, INPUT);
//        prevTime = QDateTime::currentMSecsSinceEpoch();
    #endif
    emit displayModeChanged();
    if(QCanBus::instance()->plugins().contains("socketcan"))
    {
        // Create CAN bus decice and connect to can0 via SocketCAN plugin
        this->device = QCanBus::instance()->createDevice("socketcan","can0");
        this->device->connectDevice();

        // Apply filters to CAN Bus device
        QList<QCanBusDevice::Filter> filterList;
        QCanBusDevice::Filter motorID;
        QCanBusDevice::Filter motorSpeed;
        QCanBusDevice::Filter inverterTemp;
//        filterList.append(setCanFilter(0x01A));
        filterList.append(setCanFilter(BMS_Feedback_1));
        filterList.append(setCanFilter(BMS_Feedback_2));
        filterList.append(setCanFilter(BMS_Feedback_3));
        filterList.append(setCanFilter(VCU_1));
        filterList.append(setCanFilter(VCU_HW_IO));
        filterList.append(setCanFilter(VCU_Vehicle_Functionality));
        filterList.append(setCanFilter(Shutdown_Data));
        inverterTemp.frameId = HD4_Debug_Temperatures_B;
        inverterTemp.format = QCanBusDevice::Filter::MatchBaseAndExtendedFormat;
        filterList.append(inverterTemp);
        motorID.frameId = HS3_Temperature_Feedback;
        motorID.format = QCanBusDevice::Filter::MatchBaseAndExtendedFormat;
        filterList.append(motorID);
        motorSpeed.frameId = HS1_Torque_Feedback;
        motorSpeed.format = QCanBusDevice::Filter::MatchBaseAndExtendedFormat;
        filterList.append(motorSpeed);


        this->device->setConfigurationParameter(QCanBusDevice::RawFilterKey, QVariant::fromValue(filterList));

//         Connect framesRecieved signal to slot function for reading frames.
        connect(this->device, &QCanBusDevice::framesReceived,this, &dash::readFrames);

        if (this->device->state() == QCanBusDevice::ConnectedState)
        {
            qDebug() << "CAN Connected";
        }
        else
        {
            qDebug() << "CAN Not Connected";
        }
    }
    this->m_timer = new QTimer(this);
    this->m_timer->setInterval(2000);
    connect(this->m_timer,&QTimer::timeout,this,&dash::readButton);
    this->m_timer->start();
}

void dash::readFrames()
{
    int value;

  //  qDebug() << "Got CANned";
    // Read frames
    while (device->framesAvailable() > 0)
    {
        // Retrieve frame
        QCanBusFrame frame = device->readFrame();
        const QByteArray payload = frame.payload();
        QBitArray shutdownBits(payload.count()*8);

        if(frame.isValid())
        {
//            qDebug() << frame.frameId();
            switch (frame.frameId())
            {
//                case 0x7DF:
//                    m_speed = decodeFrame(frame);
//                    emit speedChanged();
//                    qDebug() << m_speed;
//                    break;
                case VCU_1:
//                    payload = frame.payload();
                    value = payload[4] * pow(16,6) + payload[5] * pow(16,4) + payload[6] * pow(16,2) + payload[7];
                    m_speed = M_PI * 0.445 * 3600 / ( value * 20 * 1000 / 1000000);
//                    emit speedChanged();
                    break;

                case BMS_Feedback_1:
                    value = payload[1] * pow(16,2) + payload[0];
                    m_hvVoltage = value * 0.1;
//                  qDebug()<< "HV Voltage: " << m_hvVoltage;


                    value = payload[5] * pow(16,2) + payload[4];
                    m_hvCurrent = value * 0.1;
//                  qDebug()<< "HV Current: " << m_hvCurrent;

                    m_power = m_hvVoltage * m_hvCurrent / 1000;

                    emit hvVoltageChanged();
                    emit powerChanged();
                    break;

                case BMS_Feedback_2:
                    value = payload[1] * pow(16,2) + payload[0];
                    m_cellVoltage = value * 0.0001;
                    emit cellVoltageChanged();
                    break;

                case BMS_Feedback_3:
                    value = payload[1];
                    m_maxCellTemp = value;
                    emit maxCellTempChanged();
                    break;

                case VCU_HW_IO:
                    value = payload[3] * pow(16,2) + payload[2];
                    m_lvVoltage = value / 1000;
                    emit lvVoltageChanged();
                    break;

                case VCU_Vehicle_Functionality:
                    m_vehicleMode = payload[1];
                    emit vehicleModeChanged();
                    break;

                case Shutdown_Data:

                    // ByteArray to BitArray code from: https://wiki.qt.io/Working_with_Raw_Data
                    // Create a bit array of the appropriate size


                    // Convert from QByteArray to QBitArray
                    for(int i=0; i<payload.count(); ++i) {
                        for(int b=0; b<8;b++) {
                            shutdownBits.setBit( i*8+b, payload.at(i)&(1<<(7-b)) );
                        }
                    }

                    // Check for normal shutdowns first
                    m_shutdownFuse = shutdownBits[3] == fault_active;
                    m_shutdownPCB = shutdownBits[4] == fault_active;
                    m_shutdownBOTS = shutdownBits[5] == fault_active;
                    m_shutdownESTP = shutdownBits[6] == fault_active || payload[8] == fault_active;  // or
                    m_shutdownIntertia = shutdownBits[7] == fault_active;
                    m_shutdownTSMS = shutdownBits[9] == fault_active;
                    m_shutdownHVD = shutdownBits[10] == fault_active;
                    m_shutdownINTLK = shutdownBits[11] == fault_active;
                    m_shutdownECU = shutdownBits[12] == fault_active;
                    m_shutdownBMS = shutdownBits[13] == fault_active;
                    m_shutdownIMD = shutdownBits[14] == fault_active;
                    m_shutdownBSPD = shutdownBits[17] == fault_active;

                    // Now check for latching shutdowns
                    if (shutdownBits[18] == fault_active)
                    {
                        m_shutdownBMS = 2;
                    }
                    if (shutdownBits[19] == fault_active)
                    {
                        m_shutdownIMD = 2;
                    }
                    if (shutdownBits[20] == fault_active)
                    {
                        m_shutdownBSPD = 2;
                    }


                    emit shutdownFuseChanged();
                    emit shutdownPCBChanged();
                    emit shutdownBOTSChanged();
                    emit shutdownESTPChanged();
                    emit shutdownIntertiaChanged();
                    emit shutdownTSMSChanged();
                    emit shutdownHVDChanged();
                    emit shutdownINTLKChanged();
                    emit shutdownECUChanged();
                    emit shutdownBMSChanged();
                    emit shutdownIMDChanged();
                    emit shutdownBSPDChanged();

                    break;

                case HD4_Debug_Temperatures_B:
                    // Inverter temp
                    value = payload[3];
                    m_inverterTemp = value;
                    emit inverterTempChanged();
                    break;

                case HS1_Torque_Feedback:
                    value = payload[3] * pow(16,2) + payload[2];
                    // Account for the fact that the value is signed
                    value *= 1;
                    if (value >= 32768)
                    {
                        value -= 32768;
                    }
                    value = 32768 - value;
//                    qDebug() << "Raw motor speed: " << value;
                            m_speed = value * 0.02872;
                    if (m_speed <= 0){ m_speed = 0;}
                    if (m_speed > 200){ m_speed -= 941.1;} // Fix when reversing

                    emit speedChanged();
                    break;


                case HS3_Temperature_Feedback:
                    value = payload[3] * pow(16,2) + payload[2];
                    // Account for the fact that the value is signed
                    if (value >= 32768)
                    {
                        value -= 32768;
                    }
                    m_motorTemp = value;
//                    qDebug() << "Motor Temp: " << m_motorTemp;

                    value = payload[5] * pow(16,2) + payload[4];
                    if (value >= 32768)
                    {
                        value -= 32768;
                    }
                    value *= 0.0625;

                    emit motorTempChanged();
                    emit motorVoltageChanged();
                    break;



                default:
                    //qDebug() << "Unknown message ID: " << frame.frameId() << "  |  Data: " << decodeFrame(frame);
                    break;
            }
        }
    }
}

int dash::decodeFrame(const QCanBusFrame &frame)
{
    int value;
    const QByteArray payload = frame.payload();

    if(frame.isValid())
    {
        switch(frame.frameId())
        {
            case 0x7DF:
                value = payload[0];
                break;

            default:
                value = payload[0];
                break;
        }

        return value;
    }
    value = -2;
    return value;
}

QCanBusDevice::Filter dash::setCanFilter(const unsigned short &id)
{
    QCanBusDevice::Filter filter;

    filter.frameId = id;
    filter.frameIdMask = 0x7FFu; // Compare against all 11-bits of frame id.
    filter.format = QCanBusDevice::Filter::MatchBaseFormat;
    filter.type = QCanBusFrame::DataFrame;

    return filter;
}

void dash::readButton()
{

//    m_displayMode += 1;
//    if (m_displayMode > 2)
//    {
//        m_displayMode = 0;
//    }
//    emit displayModeChanged();
//    m_vehicleMode += 1;
//    if (m_vehicleMode > 3)
//    {
//        m_vehicleMode = 0;
//    }
//    emit vehicleModeChanged();
//    m_speed = 1 - m_speed;
//    emit speedChanged();
//    if (m_speed > 0)
//    {
//        #ifdef PIMODE
//        digitalWrite(1, HIGH);
//        #endif
//        qDebug()<<"Pin high";
//    }
//    else {
//        #ifdef PIMODE
//        digitalWrite(1, LOW);
//        #endif
//        qDebug()<<"Pin low";
//    }
//    m_displayMode += 1;
//    if (m_displayMode > 2)
//    {
//        m_displayMode = 0;
//    }
//    emit displayModeChanged();

    #ifdef PIMODE
        if (digitalRead(3) == HIGH && pressOnPreviousLoop == 0)
        {
            m_displayMode += 1;
            if (m_displayMode > 2)
            {
                m_displayMode = 0;
            }
            emit displayModeChanged();
            digitalWrite(1, HIGH);
            qDebug()<<"Switch On";
            this->m_timer->setInterval(250);
            pressOnPreviousLoop = 1;

        }
        else
        {
//            m_vehicleMode = 3;
//            emit vehicleModeChanged();
            if (m_displayMode != 2)
            {
                digitalWrite(1, LOW);
            }
            qDebug()<<"Switch Off";
            this->m_timer->setInterval(1);
            pressOnPreviousLoop = 0;
        }
    #endif

}
