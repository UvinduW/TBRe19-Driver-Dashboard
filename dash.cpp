#include "dash.h"
#include <QThread>
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
    #endif
    this->m_timer = new QTimer(this);
    this->m_timer->setInterval(1);
    connect(this->m_timer,&QTimer::timeout,this,&dash::testActivity);
    this->m_timer->start();
}

void dash::testActivity()
{
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
        if (digitalRead(0) == HIGH)
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

        }
        else
        {
//            m_vehicleMode = 3;
//            emit vehicleModeChanged();
            digitalWrite(1, LOW);
            qDebug()<<"Switch Off";
            this->m_timer->setInterval(1);
        }
    #endif

}
