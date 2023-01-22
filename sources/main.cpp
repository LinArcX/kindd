#include <QApplication>
#include "dispatcher/dispatcher.hpp"

int main(int argc, char* argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    Dispatcher dispatcher(app);
    return app.exec();
}
