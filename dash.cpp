#include "dash.h"
#include "signallist.h"

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
        filterList.append(setCanFilter(0x019));

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
    // Read frames
    while (device->framesAvailable() > 0)
    {
        // Retrieve frame
        QCanBusFrame frame = device->readFrame();

        if(frame.isValid())
        {
            qDebug() << frame.frameId();
            switch (frame.frameId())
            {
                case 0x7DF:
                    m_speed = decodeFrame(frame);
                    emit speedChanged();
                    qDebug() << m_speed;
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
