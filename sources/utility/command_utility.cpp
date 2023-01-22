#include "command_utility.hpp"

#include <QProcess>
#include <QTextStream>
#include <QStandardPaths>
#include <QDebug>

QString CommandUtil::sudoExec(const QString &cmd, QStringList args, QByteArray data)
{
    args.push_front(cmd);

    QString result("");

    try {
        result = CommandUtil::exec("pkexec", args, data);
    } catch (QString &ex) {
        qCritical() << ex;
    }

    return result;
}

QString CommandUtil::exec(const QString &cmd, QStringList args, QByteArray data)
{
    QProcess* process = new QProcess;

    process->start(cmd, args);

    if (! data.isEmpty()) {
        process->write(data);
        process->waitForBytesWritten();
        process->closeWriteChannel();
    }

    process->waitForFinished();

    QTextStream stdOut(process->readAllStandardOutput());

    QString err = process->errorString();

    process->kill();
    process->close();

    if (process->error() != QProcess::UnknownError)
        throw err;

    return stdOut.readAll().trimmed();
}

bool CommandUtil::isExecutable(const QString &cmd)
{
    return !QStandardPaths::findExecutable(cmd).isEmpty();
}
