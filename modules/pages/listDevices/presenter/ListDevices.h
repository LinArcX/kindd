#ifndef LISTDEVICES_H
#define LISTDEVICES_H

#include "util/cpp/PropertyHelper.h"

#include <QObject>
#include <QProcess>
#include <QString>
#include <QVariantList>

class ListDevices : public QObject {
    Q_OBJECT

public:
    explicit ListDevices(QObject* parent = nullptr);

    QProcess* pListDevices;

    Q_INVOKABLE void execListDevices();

    void returnDevices();

public slots:

signals:
    void modelReady(QVariantList model);
    void singleModelReady(QVariant singleModel);

private:
};

#endif // LISTDEVICES_H
