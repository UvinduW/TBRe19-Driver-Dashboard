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
    Q_PROPERTY(int cellVoltage READ cellVoltage NOTIFY cellVoltageChanged)
    //Q_PROPERTY(int displayMode READ displayMode NOTIFY displayModeChanged)

    int speed(){ return this -> m_speed;}
    int power(){ return this -> m_power;}
    int hvVoltage(){ return this -> m_hvVoltage;}
    int lvVoltage(){ return this -> m_lvVoltage;}
    int maxCellTemp(){ return this -> m_maxCellTemp;}
    int vehicleMode(){ return this -> m_vehicleMode;}
    int airStatus(){ return this -> m_airStatus;}
    int cellVoltage(){ return this -> m_cellVoltage;}
    int displayMode(){return this -> m_displayMode;}

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


private slots:
    void testActivity();

private:
    //Read-Only
    int m_speed =70;
    int m_power=40;
    double m_hvVoltage=399;
    double m_lvVoltage=27;
    double m_maxCellTemp=0;
    int m_vehicleMode=3;
    int m_airStatus=0;
    int m_displayMode = 0;
    double m_hvCurrent = 0;
    double m_cellVoltage = 3.8;

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
