#ifndef DASH_H
#define DASH_H



#include <QObject>
#include <QTimer>
#include <QDebug>

class dash: public QObject
{
    Q_OBJECT
public:
    dash(QObject *parent = 0);
    Q_PROPERTY(double speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(int displayMode READ displayMode NOTIFY displayModeChanged)

    double speed(){ return this -> m_speed;}
    int displayMode(){return this -> m_displayMode;}

signals:
    void speedChanged();
    void displayModeChanged();

private slots:
    void testActivity();

private:
    //Read-Only
    double m_speed =1;
    int m_displayMode = 0;
    QTimer * m_timer;
};

#endif // DASH_H
