#include <QDebug>
#include <QFont>
#include <QFontDatabase>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQuickControls2/QQuickStyle>
#include <QTranslator>
#include <create_iso/create_iso.h>
#include <settings/settings.h>

#include "dispatcher.h"
#include "dispatcher_macro.h"

Dispatcher::Dispatcher(QGuiApplication& mApp, QObject* parent)
    : QObject(parent)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    Settings& settings = *new Settings();
    settings.loadAppStyle();
    settings.loadFontFamily();
    settings.loadFontSize();
    settings.loadBlockSize();

    registerTypes();

    QQmlApplicationEngine* mEngine = getEngine();
    mEngine->load(QUrl(QLatin1String(MAIN_QML)));
    QQmlContext* mContext = getContext();

    mContext->setContextProperty(DISPATCHER, this);
    mContext->setContextProperty(APP, &mApp);
}

void Dispatcher::registerTypes()
{
    qmlRegisterType<CreateISO>("linarcx.kindd.CreateISO", 1, 0, "CreateISO");
    qmlRegisterType<Settings>("linarcx.kindd.Settings", 1, 0, "Settings");
}
