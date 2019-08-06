#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QString>
#include <QVariantList>
#include <QVariantMap>

#include "util/cpp/PropertyHelper.h"

class Settings : public QObject {
    Q_OBJECT

public:
    explicit Settings(QObject* parent = nullptr);

    Q_INVOKABLE void setSettings(QVariantMap);
    Q_INVOKABLE void resetSettings();
    Q_INVOKABLE static void restartApp();

    static void loadAppStyle();
    void loadFontFamily();
    static void loadFontSize();
    Q_INVOKABLE void loadBlockSize();

    QString appStyleName();
    Q_INVOKABLE QVariantList appStyles();
    Q_INVOKABLE int appStyleIndex();

    QString fontFamilyName();
    Q_INVOKABLE QVariantList fontFamilies();
    Q_INVOKABLE int fontFamilyIndex();

    QString fontSizeName();
    Q_INVOKABLE QVariantList fontSizes();
    Q_INVOKABLE int fontSizeIndex();

private:
signals:
    void blockSizeReady(QVariant blockSize);
};

#endif // SETTINGS_H
