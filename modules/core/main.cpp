#include "modules/core/dispatcher/dispatcher.h"
#include <QGuiApplication>

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    Dispatcher dispatcher(app);
    return app.exec();
}
