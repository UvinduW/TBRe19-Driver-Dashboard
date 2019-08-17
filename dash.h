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
    Q_PROPERTY(int displayMode READ displayMode NOTIFY displayModeChanged)
    Q_PROPERTY(int speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(int power READ power NOTIFY powerChanged)
    Q_PROPERTY(double bmsVoltage READ bmsVoltage NOTIFY bmsVoltageChanged)
    Q_PROPERTY(double bmsCurrent READ bmsCurrent NOTIFY bmsCurrentChanged)
    Q_PROPERTY(double lvVoltage READ lvVoltage NOTIFY lvVoltageChanged)
    Q_PROPERTY(int vehicleMode READ vehicleMode NOTIFY vehicleModeChanged)
    Q_PROPERTY(int airStatus READ airStatus NOTIFY airStatusChanged)

    Q_PROPERTY(double minCellVoltage READ minCellVoltage NOTIFY minCellVoltageChanged)
    Q_PROPERTY(double maxCellVoltage READ maxCellVoltage NOTIFY maxCellVoltageChanged)
    Q_PROPERTY(double avgCellVoltage READ avgCellVoltage NOTIFY avgCellVoltageChanged)

    Q_PROPERTY(double minCellTemp READ minCellTemp NOTIFY minCellTempChanged)
    Q_PROPERTY(double maxCellTemp READ maxCellTemp NOTIFY maxCellTempChanged)
    Q_PROPERTY(double avgCellTemp READ avgCellTemp NOTIFY avgCellTempChanged)

    Q_PROPERTY(int motorTemp READ motorTemp NOTIFY motorTempChanged)
    Q_PROPERTY(double inverterVoltage READ inverterVoltage NOTIFY inverterVoltageChanged)
    Q_PROPERTY(int inverterTemp READ inverterTemp NOTIFY inverterTempChanged)
    Q_PROPERTY(int bmsTemp READ bmsTemp NOTIFY bmsTempChanged)
    Q_PROPERTY(int motorSpeed READ motorSpeed NOTIFY motorSpeedChanged)
    Q_PROPERTY(int motorTorque READ motorTorque NOTIFY motorTorqueChanged)
    Q_PROPERTY(double motorPower READ motorPower NOTIFY motorPowerChanged)
    Q_PROPERTY(int inverterCurrent READ inverterCurrent NOTIFY inverterCurrentChange)
    Q_PROPERTY(double inverterPower READ inverterPower NOTIFY inverterPowerChanged)
    Q_PROPERTY(int inverterStatus READ inverterStatus NOTIFY inverterStatusChanged)
    Q_PROPERTY(int inverterReset READ inverterReset NOTIFY inverterResetChanged)    // Not yet read from CAN bus



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
    int bmsVoltage(){ return this -> m_bmsVoltage;}
    int bmsCurrent(){return this -> m_bmsCurrent;}
    int lvVoltage(){ return this -> m_lvVoltage;}

    double minCellVoltage(){ return this -> m_minCellVoltage;}
    double maxCellVoltage(){ return this -> m_maxCellVoltage;}
    double avgCellVoltage(){ return this -> m_avgCellVoltage;}

    double minCellTemp(){ return this -> m_minCellTemp;}
    double maxCellTemp(){ return this -> m_maxCellTemp;}
    double avgCellTemp(){ return this -> m_avgCellTemp;}

    int vehicleMode(){ return this -> m_vehicleMode;}
    int airStatus(){ return this -> m_airStatus;}
    int displayMode(){return this -> m_displayMode;}
    int motorTemp(){return this -> m_motorTemp;}
    double inverterVoltage(){return this -> m_inverterVoltage;}
    int inverterTemp(){return this -> m_inverterTemp;}
    int bmsTemp(){return this -> m_bmsTemp;}
    int motorSpeed(){return this -> m_motorSpeed;}
    int motorTorque(){return this -> m_motorTorque;}
    double motorPower(){return this -> m_motorPower;}
    int inverterCurrent(){return this -> m_inverterCurrent;}
    int inverterPower(){return this -> m_inverterPower;}
    int inverterStatus(){return this -> m_inverterStatus;}
    int inverterReset(){return this -> m_inverterReset;}

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
    void bmsVoltageChanged();
    void bmsCurrentChanged();
    void lvVoltageChanged();
    void vehicleModeChanged();
    void airStatusChanged();

    void minCellVoltageChanged();
    void maxCellVoltageChanged();
    void avgCellVoltageChanged();

    void minCellTempChanged();
    void maxCellTempChanged();
    void avgCellTempChanged();

    void displayModeChanged();
    void motorTempChanged();
    void inverterVoltageChanged();
    void inverterTempChanged();
    void bmsTempChanged();
    void motorSpeedChanged();
    void motorTorqueChanged();
    void motorPowerChanged();
    void inverterCurrentChange();
    void inverterPowerChanged();
    void inverterStatusChanged();
    void inverterResetChanged();


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
    int *get_bits(int n, int bitswanted);

private:
    //Read-Only
    int m_speed =69;
    int m_power=40;
    double m_bmsVoltage=399;
    double m_bmsCurrent = 0;
    double m_lvVoltage=27;
    int m_vehicleMode=0;
    int m_airStatus=0;
    int m_displayMode = 1;

    double m_minCellVoltage = 7.811;
    double m_maxCellVoltage = 9.811;
    double m_avgCellVoltage = 8.11;

    double m_minCellTemp = 7.71;
    double m_maxCellTemp = 9.71;
    double m_avgCellTemp = 8.22;


    int m_motorTemp = 0;
    double m_inverterVoltage = 0;
    int m_inverterTemp = 420;
    int m_bmsTemp = 520;
    int m_motorSpeed = 0;
    int m_motorTorque = 0;
    double m_motorPower = 0;
    int m_inverterCurrent = 0;
    int m_inverterPower = 0;
    int m_inverterStatus = -1;
    int m_inverterReset = 0;

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
    int m_shutdownIMD = 0;
    int m_shutdownBSPD = 2;

    int *airByte;

    int *shutdownByte0;
    int *shutdownByte1;
    int *shutdownByte2;

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
