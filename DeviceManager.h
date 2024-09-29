#ifndef DEVICEMANAGER_H
#define DEVICEMANAGER_H


#include <qobject.h>
#include <qdebug.h>

class DeviceManager : public QObject
{
    Q_OBJECT
public:
    DeviceManager(QObject *parent = Q_NULLPTR);
    ~DeviceManager();
    Q_INVOKABLE bool postMessage(const QString &msg) {
        qDebug() << "Called the C++ method with" << msg;
        return true;
    }
    bool isConnectedToNetwork();
public Q_SLOTS:
    void reboot();
    void powerOff();
};

#endif // DEVICEMANAGER_H
