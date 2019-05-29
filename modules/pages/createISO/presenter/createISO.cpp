#include "modules/pages/createISO/presenter/createISO.h"
#include "libs/QDeviceWatcher/qdevicewatcher.h"
#include "modules/pages/createISO/presenter/createISOMacro.h"
#include "util/cpp/utils.h"
#include <QDebug>
#include <QString>
#include <QtCore/QThread>
#include <memory>

using namespace std;

CreateISO::CreateISO(QObject* parent)
{
    watcher = new QDeviceWatcher;
    watcher->appendEventReceiver(this);
    connect(watcher, SIGNAL(deviceAdded(QString)), this, SLOT(slotDeviceAdded(QString)), Qt::DirectConnection);
    connect(watcher, SIGNAL(deviceRemoved(QString)), this, SLOT(slotDeviceRemoved(QString)), Qt::DirectConnection);
    watcher->start();
}

void CreateISO::slotDeviceAdded(const QString& dev)
{
    if (!(dev.endsWith("1") || dev.endsWith("2"))) {
        if (!model.contains(dev)) {
            model.push_front(dev);
            emit modelChangedReady(model);
            emit deviceAdded(dev);
        }
    }
}

void CreateISO::slotDeviceRemoved(const QString& dev)
{
    if (!(dev.endsWith("1") || dev.endsWith("2"))) {
        if (!model.isEmpty()) {
            model.pop_front();
            emit modelChangedReady(model);
            emit deviceRemoved(dev);
        }
    }
}

void CreateISO::execListDevices()
{
    pListDevices = new QProcess(this);
    connect(pListDevices, &QProcess::readyReadStandardOutput, this, &CreateISO::returnDevices);
    pListDevices->start("sh", QStringList() << "-c" << LIST_OF_DEVICES);
}

void CreateISO::returnDevices()
{
    QString outPut = QString(pListDevices->readAllStandardOutput());
    if (outPut.contains("by-id/usb*")) {
        QList<QString> qv;
        emit modelReady(qv);
    } else {
        QStringList list = outPut.split("\n");
        list.removeLast();
        std::regex word_regex = Utils::getPattern();
        QList<QString> rawModel = list.toVector().toList();

        for (QString item : rawModel) {
            if (item.endsWith("1") || item.endsWith("2")) {
                // TODO
            } else {
                model.push_front(item);
                emit modelReady(model);
            }
        }
    }
}

void CreateISO::execCreateISO(QString isoPath, QString targetPath, QString blockSize, QString sizeType)
{
    QString finalIsoPath = isoPath.split("file://")[1];
    QString finalBlockSize = blockSize + sizeType;

    pCreateISO = new QProcess(this);

    QString ddCommand = "pkexec dd if=" + finalIsoPath + " of=" + targetPath + " bs=" + finalBlockSize + " oflag=sync status=progress";
    pCreateISO->start("sh", QStringList() << "-c" << ddCommand);

    connect(pCreateISO, &QProcess::bytesWritten, this, &CreateISO::returnBytes);
    connect(pCreateISO, &QProcess::readyReadStandardError, this, &CreateISO::returnError);
    connect(pCreateISO, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
        [=](int exitCode, QProcess::ExitStatus exitStatus) {
            QString outPut = QString(pCreateISO->readAllStandardOutput());
            qDebug() << outPut;
            emit CreateISO::finished(outPut);
        });
}

void CreateISO::returnBytes()
{
    QString outPut = QString(pCreateISO->readAllStandardOutput());
    qDebug() << outPut;
    emit dataReady(outPut);
}

void CreateISO::returnError()
{
    QString error = QString(pCreateISO->readAllStandardError());
    qDebug() << error;
    emit errorReady(error);
}

//    qInstallMessageHandler(MsgOuput);
//    connect(watcher, SIGNAL(deviceChanged(QString)), this, SLOT(slotDeviceChanged(QString)), Qt::DirectConnection);

//static CreateISO* gui = nullptr;

//#if QT_VERSION < QT_VERSION_CHECK(5, 0, 0)
//#define qInstallMessageHandler qInstallMsgHandler
//void MsgOuput(QtMsgType type, const char* msg)
//{
//#else
//void MsgOuput(QtMsgType type, const QMessageLogContext&, const QString& msg)
//{
//#endif
//    Q_UNUSED(type)
//    if (gui)
//        gui->appendMessage(msg);
//}

//void CreateISO::appendMessage(const QString& msg)
//{
//    qDebug() << msg;
//}

//    QProcess pListDevices;
//    connect(&pListDevices, &QProcess::readyReadStandardOutput, [&]() {
//        QString outPut = QString(pListDevices.readAllStandardOutput());
//        if (outPut.contains("by-id/usb*")) {
//            QList<QString> qv;
//            emit modelReady(qv);
//        } else {
//            QStringList list = outPut.split("\n");
//            list.removeLast();
//            std::regex word_regex = Utils::getPattern();
//            QList<QString> model = list.toVector().toList();
//            emit modelReady(model);
//        }
//    });
//    pListDevices.start("sh", QStringList() << "-c" << LIST_OF_DEVICES);
//    pListDevices.waitForFinished(2000);

//    connect(&pListDevices, &QProcess::readyReadStandardError, [=]() { plainTextEdit->appendPlainText(process.readAllStandardError()); });
//    connect(pListDevices, &QProcess::readyReadStandardOutput, this, [=] { returnDevices(pListDevices); });

//    qDebug("tid=%#x: add %s", (quintptr)QThread::currentThreadId(), qPrintable(dev));
//    std::cout << dev.toStdString() << endl;
//    state->setText("<font color=#0000ff>Add: </font>" + dev);
//    tray->showMessage(tr("New device"), dev);
