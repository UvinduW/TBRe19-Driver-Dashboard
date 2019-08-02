#include "dash.h"
#include "signallist.h"
#define _USE_MATH_DEFINES
#include <math.h>
#define PI 3.1415926536

#include <QThread>
//#include <QDateTime>
//#define PIMODE

#ifdef PIMODE
    #include <wiringPi.h>
#endif

dash::dash(QObject *parent): QObject(parent)
{
    #ifdef PIMODE
        wiringPiSetup () ;
        pinMode(1, OUTPUT);
        pinMode(0, INPUT);
//        prevTime = QDateTime::currentMSecsSinceEpoch();
    #endif
    if(QCanBus::instance()->plugins().contains("socketcan"))
    {
        // Create CAN bus decice and connect to can0 via SocketCAN plugin
        this->device = QCanBus::instance()->createDevice("socketcan","can0");
        this->device->connectDevice();

        // Apply filters to CAN Bus device
        QList<QCanBusDevice::Filter> filterList;
        filterList.append(setCanFilter(0x01A));        
        filterList.append(setCanFilter(0x100));
        filterList.append(setCanFilter(0x101));
        filterList.append(setCanFilter(0x503));
        filterList.append(setCanFilter(0x704));
        filterList.append(setCanFilter(0x701));

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
    connect(this->m_timer,&QTimer::timeout,this,&dash::testActivity);
    this->m_timer->start();
}

void dash::readFrames()
{
    int value;


    // Read frames
    while (device->framesAvailable() > 0)
    {
        // Retrieve frame
        QCanBusFrame frame = device->readFrame();
        const QByteArray payload = frame.payload();

        if(frame.isValid())
        {
            qDebug() << frame.frameId();
            switch (frame.frameId())
            {
//                case 0x7DF:
//                    m_speed = decodeFrame(frame);
//                    emit speedChanged();
//                    qDebug() << m_speed;
//                    break;
                case 0x503:
//                    payload = frame.payload();
                    value = payload[4] * pow(16,6) + payload[5] * pow(16,4) + payload[6] * pow(16,2) + payload[7];
                    m_speed = M_PI * 0.445 * 3600 / ( value * 20 * 1000 / 1000000);
                    emit speedChanged();
                    break;

                case 0x100:
                    value = payload[1] * pow(16,2) + payload[0];
                    m_hvVoltage = value * 0.1;

                    value = payload[5] * pow(16,2) + payload[4];
                    m_hvCurrent = value * 0.1;
                    m_power = m_hvVoltage * m_hvCurrent;

                    emit hvVoltageChanged();
                    emit powerChanged();
                    break;

                case 0x101:
                    value = value = payload[1] * pow(16,2) + payload[0];
                    m_cellVoltage = value * 0.0001;
                    emit cellVoltageChanged();
                    break;

                case 0x704:
                    m_vehicleMode = payload[1];
                    emit vehicleModeChanged();
                    break;


                case 0x701:
                    value = payload[3] * pow(16,2) + payload[2];
                    m_lvVoltage = value / 1000;
                    emit lvVoltageChanged();
                    break;

                default:
                    qDebug() << "Unknown message ID: " << frame.frameId() << "  |  Data: " << decodeFrame(frame);
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

void dash::testActivity()
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
    emit displayModeChanged();

    #ifdef PIMODE
        if (digitalRead(0) == HIGH && pressOnPreviousLoop == 0)
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
