#include <QDebug>
#include <QFont>
#include <QFontDatabase>
#include <QGuiApplication>
#include <QProcess>
#include <QSettings>
#include <QString>
#include <QStringList>
#include <QtQuickControls2/qquickstyle.h>
#include <sys/utsname.h>

#include "settings.h"
#include "settings_macro.h"
#include <dispatcher/dispatcher.h>

using namespace std;

Settings::Settings(QObject* parent)
{
}

void Settings::setSettings(QVariantMap mSettings)
{
    for (auto iter = mSettings.begin(); iter != mSettings.end(); ++iter) {
        QString mKey = iter.key();
        if (mKey == FONT_FAMILY) {
            QFont fontFamily(iter.value().toString());
            QSettings settings(COMPANY_NAME, APP_NAME);
            settings.beginGroup(FONT_GROUP);
            settings.setValue(FONT_FAMILY, fontFamily);
            settings.endGroup();
            loadFontFamily();
        } else if (mKey == FONT_SIZE) {
            int fontSize = iter.value().toInt();
            QSettings settings(COMPANY_NAME, APP_NAME);
            settings.beginGroup(FONT_GROUP);
            settings.setValue(FONT_SIZE, fontSize);
            settings.endGroup();
            loadFontSize();
        } else if (mKey == STYLE) {
            QString appStyle = iter.value().toString();
            QSettings settings(COMPANY_NAME, APP_NAME);
            settings.beginGroup(APP_GROUP);
            settings.setValue(STYLE, appStyle);
            settings.endGroup();
            loadAppStyle();
        } else if (mKey == BLOCK_SIZE) {
            QString blockSize = iter.value().toString();
            QSettings settings(COMPANY_NAME, APP_NAME);
            settings.beginGroup(APP_GROUP);
            settings.setValue(BLOCK_SIZE, blockSize);
            settings.endGroup();
            loadAppStyle();
        }
    }
}

void Settings::resetSettings()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.clear();
}

void Settings::restartApp()
{
    QProcess::startDetached(QGuiApplication::applicationFilePath());
    exit(12);
}

void Settings::loadAppStyle()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(APP_GROUP);
    QString mStyle = qvariant_cast<QString>(settings.value(STYLE, DEFAULT_STYLE));
    QQuickStyle::setStyle(mStyle);
    settings.endGroup();
}

void Settings::loadFontFamily()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(FONT_GROUP);
    QFont mFont = qvariant_cast<QFont>(settings.value(FONT_FAMILY, DEFAULT_FONT));
    int id = QFontDatabase::addApplicationFont(":/fonts/" + mFont.family() + ".ttf");
    QString family = QFontDatabase::applicationFontFamilies(id).at(0);
    QFont _font(family);
    qApp->setFont(_font);
    settings.endGroup();
}

void Settings::loadFontSize()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(FONT_GROUP);
    QFont mFont;
    mFont.setPixelSize(qvariant_cast<int>(settings.value(FONT_SIZE, 12)));
    QGuiApplication::setFont(mFont);
    settings.endGroup();
}

QString Settings::appStyleName()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(APP_GROUP);
    QString appStyle = qvariant_cast<QString>(settings.value(STYLE, DEFAULT_STYLE));
    settings.endGroup();
    return appStyle;
}

QVariantList Settings::appStyles()
{
    QVariantList appStyles;
    appStyles
        << "Default"
        << "Fusion"
        << "Imagine"
        << "Material"
        << "Universal";

    return appStyles;
}

int Settings::appStyleIndex()
{
    QString currentAppStyle = appStyleName();
    QVariant qv(currentAppStyle);
    return appStyles().indexOf(qv);
}

QString Settings::fontFamilyName()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(FONT_GROUP);
    QFont fontFamily = qvariant_cast<QFont>(settings.value(FONT_FAMILY, DEFAULT_FONT));
    settings.endGroup();
    return fontFamily.family();
}

QVariantList Settings::fontFamilies()
{
    QVariantList fontLists;
    fontLists
        << "Adele"
        << "AlexBrush"
        << "Aller"
        << "Amatic"
        << "BeautifulCreatures"
        << "CaviarDreams"
        << "Daywalker"
        << "RadioSpace"
        << "Shabnam"
        << "Titillium"
        << "Vazir"
        << "XmYekan";
    return fontLists;
}

int Settings::fontFamilyIndex()
{
    QString currentFontFamily = fontFamilyName();
    QVariant qv(currentFontFamily);
    return fontFamilies().indexOf(qv);
}

QString Settings::fontSizeName()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(FONT_GROUP);
    QString fontSize = qvariant_cast<QString>(settings.value(FONT_SIZE, 12));
    settings.endGroup();
    return fontSize;
}

QVariantList Settings::fontSizes()
{
    QVariantList fontLists;
    fontLists
        << "8"
        << "9"
        << "10"
        << "11"
        << "12"
        << "13"
        << "14"
        << "15"
        << "16"
        << "17"
        << "18";

    return fontLists;
}

int Settings::fontSizeIndex()
{
    QString fontSizeIndex = fontSizeName();
    QVariant qv(fontSizeIndex);
    return fontSizes().indexOf(qv);
}

void Settings::loadBlockSize()
{
    QSettings settings(COMPANY_NAME, APP_NAME);
    settings.beginGroup(APP_GROUP);
    QString bs = settings.value(BLOCK_SIZE, 5).toString();
    settings.endGroup();
    emit blockSizeReady(bs);
}
