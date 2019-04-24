#pragma once

#include <QString>
#include <QVariant>
#include <functional>
#include <iostream>
#include <memory>
#include <regex>

//class QString;

//namespace Utils {
class Utils {
public:
    Utils();

    static std::regex getPattern();
    static std::regex getSimplePattern();
    static std::regex getHugePattern();
    static QStringList beautifyFirstLast(QString outPut);
    static QStringList beautifyLast(QString outPut);
    static QVariantList beautifer(QString outPut);
    static QStringList beautifyOutput(QString outPut);
    static QVariantList performRegx(std::regex word_regex, QStringList list);

    static void DestructorMsg(const QString value);
    static void DestructorMsg(const QObject* const object);
    template <typename T, typename... Args>
    static std::unique_ptr<T> make_unique(Args&&... args)
    {
        return std::unique_ptr<T>(new T(std::forward<Args>(args)...));
    }

private:
    explicit Utils(const Utils& rhs) = delete;
    Utils& operator=(const Utils& rhs) = delete;
};
//}
