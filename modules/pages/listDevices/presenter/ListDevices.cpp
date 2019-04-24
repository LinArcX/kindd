#include "modules/pages/listDevices/presenter/ListDevices.h"
#include "modules/pages/listDevices/presenter/ListDevicesMacro.h"
#include "util/cpp/utils.h"

#include <QString>

using namespace std;

ListDevices::ListDevices(QObject* parent)
{
}

void ListDevices::execListDevices()
{
    pListDevices = new QProcess(this);
    connect(pListDevices, &QProcess::readyReadStandardOutput, this, &ListDevices::returnDevices);
    pListDevices->start("sh", QStringList() << "-c" << LIST_OF_DEVICES);
}

void ListDevices::returnDevices()
{
    //    QString outPut = QString(pListDevices->readAllStandardOutput());
    //    QStringList list = outPut.split("\n");
    //    std::regex word_regex = Utils::getSimplePattern();
    //    QVariantList parent = Utils::performRegx(word_regex, list);
    //    emit modelReady(parent);

    QString outPut = QString(pListDevices->readAllStandardOutput());
    QStringList list = Utils::beautifyOutput(outPut);
    std::regex word_regex = Utils::getPattern();
    QVariantList parent = Utils::performRegx(word_regex, list);
    emit modelReady(parent);
}
