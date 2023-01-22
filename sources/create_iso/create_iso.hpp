#ifndef CREATEISO_H
#define CREATEISO_H

#include <property_helper.hpp>

#include <QObject>
#include <QProcess>
#include <QSharedPointer>
#include <QString>
#include <QVariantList>

class QDeviceWatcher;

class CreateISO : public QObject {
    Q_OBJECT

public:
    explicit CreateISO(QObject* parent = nullptr);

    QProcess* pListDevices;
    QProcess* pCreateISO;

    Q_INVOKABLE void execListDevices();
    Q_INVOKABLE void execCreateISO(QString isoPath, QString targetPath, QString byteSize, QString sizeType);

    void returnDevices();
    void returnBytes();
    void returnError();
    //    void appendMessage(const QString& msg);

public slots:
    void slotDeviceAdded(const QString& dev);
    void slotDeviceRemoved(const QString& dev);
    //    void slotDeviceChanged(const QString& dev);

signals:
    void modelReady(QList<QString> model);
    void modelChangedReady(QList<QString> model);
    void deviceAdded(QString data);
    void deviceRemoved(QString data);
    void singleModelReady(QVariant singleModel);
    void dataReady(QVariant data);
    void errorReady(QVariant error);
    void finished(QVariant finished);

private:
    QDeviceWatcher* watcher;
    QList<QString> model;
};

#endif // CREATEISO_H
