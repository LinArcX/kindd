#include "modules/pages/createISO/presenter/createISO.h"
#include "modules/pages/createISO/presenter/createISOMacro.h"
#include "util/cpp/utils.h"
#include <QDebug>

#include <QString>

using namespace std;

CreateISO::CreateISO(QObject* parent)
{
}

void CreateISO::execCreateISO(QString isoPath, QString targetPath, QString byteSiz, QString sizeType)
{
    QString finalIsoPath = isoPath.split("file://")[1];
    QString finalTargetPath = "/dev/" + targetPath;
    QString finalByteSize = byteSiz + sizeType;

    pCreateISO = new QProcess(this);

    QString ddCommand = "pkexec dd if=" + finalIsoPath + " of=" + finalTargetPath + " bs=" + finalByteSize + " oflag=sync status=progress";
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
