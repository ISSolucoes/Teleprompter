#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <qnativeinterface.h>

int main(int argc, char *argv[])
{
    QNativeInterface::QAndroidApplication::hideSplashScreen(3000);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Teleprompter", "Main");

    return app.exec();
}
