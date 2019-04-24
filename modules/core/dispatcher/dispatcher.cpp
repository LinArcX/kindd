#include <QFont>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QTranslator>

#include "modules/core/dispatcher/dispatcher.h"
#include "modules/pages/createISO/presenter/createISO.h"
#include "modules/pages/listDevices/presenter/ListDevices.h"
#include <modules/core/dispatcher/dispatcherMacro.h>

Dispatcher::Dispatcher(QGuiApplication& mApp, QObject* parent)
    : QObject(parent)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QQuickStyle::setStyle("Imagine");

    registerTypes();

    // Load Splash Screen
    QQmlApplicationEngine* mEngine = getEngine();
    mEngine->load(QUrl(QLatin1String(MAIN_QML)));
    QQmlContext* mContext = getContext();

    mContext->setContextProperty(DISPATCHER, this);
    mContext->setContextProperty(APP, &mApp);
}

void Dispatcher::registerTypes()
{
    qmlRegisterType<CreateISO>("linarcx.kindd.CreateISO", 1, 0, "CreateISO");
    qmlRegisterType<ListDevices>("linarcx.kindd.ListDevices", 1, 0, "ListDevices");
}
