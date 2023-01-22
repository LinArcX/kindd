#include <QDebug>
#include <QString>
#include <QStringList>

#include <functional>
#include <iostream>
#include <iterator>
#include <regex>

#include "utility.hpp"
#include "utility_macro.hpp"

static QString DESTRUCTOR_MSG = QStringLiteral("Running the %1 destructor.");

void Utils::DestructorMsg(const QString value)
{
    qDebug() << DESTRUCTOR_MSG.arg(value);
}

void Utils::DestructorMsg(const QObject* const object)
{
    DestructorMsg(object->metaObject()->className());
}

std::regex Utils::getPattern()
{
    std::string spacer = "|";
    std::regex word_regex(BLENDED_NUBERS + spacer
            + DASH_SLASH_WORD + spacer
            + DISTINCT_WORD + spacer
            + DASH_WORD + spacer
            + SINGLE_WORD,
        std::regex_constants::ECMAScript);
    return word_regex;
}

std::regex Utils::getHugePattern()
{
    std::string spacer = "|";
    std::regex word_regex(FRACTIONAL_NUMBER + spacer
            + DASH_SLASH_WORD + spacer
            + DISTINCT_WORD + spacer
            + DASH_WORD + spacer
            + SINGLE_WORD,
        std::regex_constants::ECMAScript);
    return word_regex;
}

std::regex Utils::getSimplePattern()
{
    std::regex word_regex(DISTINCT_GENERAL_WORD, std::regex_constants::ECMAScript);
    return word_regex;
}

QStringList Utils::beautifyFirstLast(QString outPut)
{
    QStringList list = outPut.split("\n");
    list.removeFirst();
    list.removeLast();
    return list;
}

QStringList Utils::beautifyLast(QString outPut)
{
    QStringList list = outPut.split("\n");
    list.removeLast();
    return list;
}

QVariantList Utils::beautifer(QString outPut)
{
    QVariantList finalList;
    QStringList list = outPut.split("\n");
    list.removeLast();
    foreach (QString item, list) {
        QStringList splittedList = item.split("=");
        finalList.append(splittedList);
    }
    return finalList;
}

QStringList Utils::beautifyOutput(QString outPut)
{
    QStringList list = outPut.split("\n");
    list.removeFirst();
    list.removeLast();
    return list;
}

QVariantList Utils::performRegx(std::regex word_regex, QStringList list)
{
    QVariantList parent;
    foreach (QString var, list) {
        QVariantList items;
        std::string mVar = var.toUtf8().constData();

        auto words_begin = std::sregex_iterator(mVar.begin(), mVar.end(), word_regex);
        auto words_end = std::sregex_iterator();

        for (std::sregex_iterator i = words_begin; i != words_end; ++i) {
            std::smatch match = *i;
            std::string match_str = match.str();

            items << QString::fromStdString(match_str);
        }
        parent.insert(parent.size(), items);
    }
    return parent;
}
