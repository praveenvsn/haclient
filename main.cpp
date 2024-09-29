#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QNetworkAccessManager>

#include "DeviceManager.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QScopedPointer<DeviceManager> singletonprocessor(new DeviceManager);
    qmlRegisterSingletonInstance("com.sweethome.devicemanager", 1, 0, "DeviceManager", singletonprocessor.get()); //register our singleton

    bool internetConnected=false;
    int attempts=0;

    do
    {
        internetConnected = singletonprocessor.get()->isConnectedToNetwork();
        attempts++;
    }
    while(!internetConnected && attempts <= 5);

    if(!internetConnected)
    {
        qDebug() << "No internet connection found. Attempts :" << attempts;
    }
    else
    {
        qDebug() << "Internet connected";
    }

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("haclient", "Main");

    return app.exec();
}
