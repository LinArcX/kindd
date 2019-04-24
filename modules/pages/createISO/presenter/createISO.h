#ifndef CREATEISO_H
#define CREATEISO_H

#include "util/cpp/PropertyHelper.h"

#include <QObject>
#include <QProcess>
#include <QString>
#include <QVariantList>

class CreateISO : public QObject {
    Q_OBJECT

public:
    explicit CreateISO(QObject* parent = nullptr);

    QProcess* pCreateISO;

    Q_INVOKABLE void execCreateISO(QString isoPath, QString targetPath, QString byteSize, QString sizeType);

    void returnBytes();
    void returnError();

public slots:

signals:
    void dataReady(QVariant data);
    void errorReady(QVariant error);
    void finished(QVariant finished);

private:
};

#endif // CREATEISO_H
