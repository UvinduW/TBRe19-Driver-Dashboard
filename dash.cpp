#include "dash.h"
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
#define VCU_Diagnostics 0x700
#define VCU_HW_IO 0x701
#define VCU_Vehicle_Functionality 0x704
#define Shutdown_Data 0x705

//Extended
#define HD4_Debug_Temperatures_B 0x192BFF71
#define HS3_Temperature_Feedback 0x191AFF71
#define HS1_Torque_Feedback 0x1918FF71
#define HS2_Status_Feedback 0x1919FF71

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
//        QBitArray shutdownBits(payload.count()*8);

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
                    m_bmsVoltage = value * 0.1;
//                  qDebug()<< "HV Voltage: " << m_bmsVoltage;


                    value = payload[5] * pow(16,2) + payload[4];
                    m_bmsCurrent = value * 0.1;
//                  qDebug()<< "HV Current: " << m_hvCurrent;

                    m_power = m_bmsVoltage * m_bmsCurrent / 1000;

                    emit bmsVoltageChanged();
                    emit powerChanged();
                    break;

                case BMS_Feedback_2:
                    // Min cell voltage
                    value = payload[1] * pow(16,2) + payload[0];
                    m_minCellVoltage = value * 0.0001;

                    // Max cell voltage
                    value = payload[3] * pow(16,2) + payload[2];
                    m_maxCellVoltage = value * 0.0001;

                    // Avg cell voltage
                    value = payload[5] * pow(16,2) + payload[4];
                    m_avgCellVoltage = value * 0.0001;

                    emit minCellVoltageChanged();
                    emit maxCellVoltageChanged();
                    emit avgCellVoltageChanged();
                    break;

                case BMS_Feedback_3:
                    // Max cell temp
                    value = payload[1];
                    m_maxCellTemp = value;

                    // Min cell temp
                    value = payload[2];
                    m_minCellTemp = value;

                    // Avg cell temp
                    value = payload[0];
                    m_avgCellTemp = value;

                    // BMS Heatsink Temp
                    value = payload[5];
                    m_bmsTemp = value;

                    emit maxCellTempChanged();
                    emit minCellTempChanged();
                    emit avgCellTempChanged();
                    emit bmsTempChanged();
                    break;

                case VCU_Diagnostics:
                    airByte = get_bits(payload[2], 8);
                    m_airStatus = airByte[4] + airByte[5];
                    emit airStatusChanged();
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

                    // Create an array of bits for each byte in the payload
                    shutdownByte0 = get_bits(payload[0], 8);
                    shutdownByte1 = get_bits(payload[1], 8);
                    shutdownByte2 = get_bits(payload[2], 8);

                    // Check for normal shutdowns first
                    m_shutdownFuse = shutdownByte0[3] == fault_active;
                    m_shutdownPCB = shutdownByte0[4] == fault_active;
                    m_shutdownBOTS = shutdownByte0[5] == fault_active;
                    m_shutdownESTP = (shutdownByte0[6] == fault_active) || (shutdownByte1[0] == fault_active);
                    m_shutdownIntertia = shutdownByte0[7] == fault_active;
                    m_shutdownTSMS = shutdownByte1[1] == fault_active;
                    m_shutdownHVD = shutdownByte1[2] == fault_active;
                    m_shutdownINTLK = shutdownByte1[3] == fault_active;
                    m_shutdownECU = shutdownByte1[4] == fault_active;
                    m_shutdownBMS = shutdownByte1[5] == fault_active;
                    m_shutdownIMD = shutdownByte1[6] == fault_active;
                    //m_shutdownBSPD = shutdownByte2[1] == fault_active;

                    // Now check for latching shutdowns
                    if (shutdownByte2[2] == fault_active)
                    {
                        m_shutdownBMS = 2;
                    }
                    if (shutdownByte2[3] == fault_active)
                    {
                        m_shutdownIMD = 2;
                    }
                    if (shutdownByte2[4] == fault_active)
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

                case HS2_Status_Feedback:
                    // Inverter status
                    value = payload[4];
                    m_inverterStatus = value;
                    emit inverterStatusChanged();
                    break;


                case HS1_Torque_Feedback:

                    // Get vehicle speed
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

                    // Get motor speed
                    m_motorSpeed = m_speed / 0.02872;


                    // Get motor torque
                    value = payload[1] * pow(16,2) + payload[0];
                    // Account for the fact that the value is signed
                    if (value >= 32768)
                    {
                        value -= 32768;
                    }
                    value *= 0.0625;
                    m_motorTorque = value;

                    // Calculate power from speed and torque
                    m_motorPower = m_motorSpeed * m_motorTorque / 9.5488;

                    // Get inverter current
                    value = payload[5] * pow(16,2) + payload[4];
                    // Account for the fact that the value is signed
                    if (value >= 32768)
                    {
                        value -= 32768;
                    }
                    m_inverterCurrent = value;

                    emit speedChanged();
                    emit motorSpeedChanged();
                    emit motorTorqueChanged();
                    emit inverterCurrentChange();
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
                    m_inverterVoltage = value;

                    // Calculate inverter power
                    m_inverterPower = m_inverterVoltage * m_inverterCurrent / 1000;

                    emit motorTempChanged();
                    emit inverterVoltageChanged();
                    emit inverterPowerChanged();
                    break;



                default:
                    //qDebug() << "Unknown message ID: " << frame.frameId() << "  |  Data: " << decodeFrame(frame);
                    break;
            }
        }
    }
}

int *dash::get_bits(int n, int bitswanted)
{
    // Code from: https://stackoverflow.com/questions/2249731/how-do-i-get-bit-by-bit-data-from-an-integer-value-in-c
    int *bits = (int*) malloc(sizeof(int) * bitswanted);

    int k;
    for(k=0; k<bitswanted; k++){
      int mask =  1 << k;
      int masked_n = n & mask;
      int thebit = masked_n >> k;
      bits[k] = thebit;
    }

    return bits;
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
