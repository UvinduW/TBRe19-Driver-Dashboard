#ifndef DASH_H
#define DASH_H



#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QCanBus>
#include <QCanBusDevice>
#include <QCanBusFrame>
#include <QVariant>



class dash: public QObject
{
    Q_OBJECT
public:
    dash(QObject *parent = 0);
    Q_PROPERTY(int speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(int power READ power NOTIFY powerChanged)
    Q_PROPERTY(double hvVoltage READ hvVoltage NOTIFY hvVoltageChanged)
    Q_PROPERTY(double lvVoltage READ lvVoltage NOTIFY lvVoltageChanged)
    Q_PROPERTY(double maxCellTemp READ maxCellTemp NOTIFY maxCellTempChanged)
    Q_PROPERTY(int vehicleMode READ vehicleMode NOTIFY vehicleModeChanged)
    Q_PROPERTY(int airStatus READ airStatus NOTIFY airStatusChanged)
    Q_PROPERTY(double cellVoltage READ cellVoltage NOTIFY cellVoltageChanged)
    Q_PROPERTY(int motorTemp READ motorTemp NOTIFY motorTempChanged)
    Q_PROPERTY(int motorVoltage READ motorVoltage NOTIFY motorVoltageChanged)
    Q_PROPERTY(int inverterTemp READ inverterTemp NOTIFY inverterTempChanged)
    Q_PROPERTY(int displayMode READ displayMode NOTIFY displayModeChanged)

    // Shutdowns
    Q_PROPERTY(int shutdownFuse READ shutdownFuse NOTIFY shutdownFuseChanged)
    Q_PROPERTY(int shutdownPCB READ shutdownPCB NOTIFY shutdownPCBChanged)
    Q_PROPERTY(int shutdownBOTS READ shutdownBOTS NOTIFY shutdownBOTSChanged)
    Q_PROPERTY(int shutdownESTP READ shutdownESTP NOTIFY shutdownESTPChanged)
    Q_PROPERTY(int shutdownIntertia READ shutdownIntertia NOTIFY shutdownIntertiaChanged)
    Q_PROPERTY(int shutdownTSMS READ shutdownTSMS NOTIFY shutdownTSMSChanged)
    Q_PROPERTY(int shutdownHVD READ shutdownHVD NOTIFY shutdownHVDChanged)
    Q_PROPERTY(int shutdownINTLK READ shutdownINTLK NOTIFY shutdownINTLKChanged)
    Q_PROPERTY(int shutdownECU READ shutdownECU NOTIFY shutdownECUChanged)
    Q_PROPERTY(int shutdownBMS READ shutdownBMS NOTIFY shutdownBMSChanged)
    Q_PROPERTY(int shutdownIMD READ shutdownIMD NOTIFY shutdownIMDChanged)
    Q_PROPERTY(int shutdownBSPD READ shutdownBSPD NOTIFY shutdownBSPDChanged)


    int speed(){ return this -> m_speed;}
    int power(){ return this -> m_power;}
    int hvVoltage(){ return this -> m_hvVoltage;}
    int lvVoltage(){ return this -> m_lvVoltage;}
    int maxCellTemp(){ return this -> m_maxCellTemp;}
    int vehicleMode(){ return this -> m_vehicleMode;}
    int airStatus(){ return this -> m_airStatus;}
    double cellVoltage(){ return this -> m_cellVoltage;}
    int displayMode(){return this -> m_displayMode;}
    int motorTemp(){return this -> m_motorTemp;}
    int motorVoltage(){return this -> m_motorVoltage;}
    int inverterTemp(){return this -> m_inverterTemp;}

    // Shutdowns
    int shutdownFuse(){return this -> m_shutdownFuse;}
    int shutdownPCB(){return this -> m_shutdownPCB;}
    int shutdownBOTS(){return this -> m_shutdownBOTS;}
    int shutdownESTP(){return this -> m_shutdownESTP;}
    int shutdownIntertia(){return this -> m_shutdownIntertia;}
    int shutdownTSMS(){return this -> m_shutdownTSMS;}
    int shutdownHVD(){return this -> m_shutdownHVD;}
    int shutdownINTLK(){return this -> m_shutdownINTLK;}
    int shutdownECU(){return this -> m_shutdownECU;}
    int shutdownBMS(){return this -> m_shutdownBMS;}
    int shutdownIMD(){return this -> m_shutdownIMD;}
    int shutdownBSPD(){return this -> m_shutdownBSPD;}




signals:
    void speedChanged();
    void powerChanged();
    void hvVoltageChanged();
    void lvVoltageChanged();
    void maxCellTempChanged();
    void vehicleModeChanged();
    void airStatusChanged();
    void cellVoltageChanged();
    void displayModeChanged();
    void motorTempChanged();
    void motorVoltageChanged();
    void inverterTempChanged();


    //Shutdowns
    void shutdownFuseChanged();
    void shutdownPCBChanged();
    void shutdownBOTSChanged();
    void shutdownESTPChanged();
    void shutdownIntertiaChanged();
    void shutdownTSMSChanged();
    void shutdownHVDChanged();
    void shutdownINTLKChanged();
    void shutdownECUChanged();
    void shutdownBMSChanged();
    void shutdownIMDChanged();
    void shutdownBSPDChanged();


private slots:
    void readButton();

private:
    //Read-Only
    int m_speed =69;
    int m_power=40;
    double m_hvVoltage=399;
    double m_lvVoltage=27;
    double m_maxCellTemp=2;
    int m_vehicleMode=0;
    int m_airStatus=0;
    int m_displayMode = 1;
    double m_hvCurrent = 0;
    double m_cellVoltage = 9.81;
    int m_motorTemp = 0;
    int m_motorVoltage = 0;
    int m_inverterTemp = 420;

    //Shutdowns
    int m_shutdownFuse = 1;
    int m_shutdownPCB = 1;
    int m_shutdownBOTS = 1;
    int m_shutdownESTP = 1;
    int m_shutdownIntertia = 1;
    int m_shutdownTSMS = 1;
    int m_shutdownHVD = 1;
    int m_shutdownINTLK = 1;
    int m_shutdownECU = 1;
    int m_shutdownBMS = 2;
    int m_shutdownIMD = 2;
    int m_shutdownBSPD = 2;

    double motor_speed = 0;
/*    double prevTime = 0;
    int timeSincePress = 9999999;
    int pressOnPreviousLoop = 0;*/
    QTimer * m_timer;
    QCanBusDevice *device;

    // CAN Bus functions
    int decodeFrame(const QCanBusFrame &frame);
    void readFrames();
    QCanBusDevice::Filter setCanFilter(const unsigned short &id);
};

#endif // DASH_H
