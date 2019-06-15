############### General ###############
QT += core qml quick quickcontrols2
CONFIG += c++11

VERSION = $$system(git log --pretty=format:'%h' -n 1)
DEFINES += APP_VER=\\\"$$VERSION\\\"
DEFINES += QT_DEPRECATED_WARNINGS

############### Compiler Flgas ###############
QMAKE_CXXFLAGS_WARN_OFF -= -Wunused-parameter

############### Resources ###############
SOURCES += $$files(modules/*.cpp, true) \
           $$files(util/cpp/*.cpp, true) \
           $$files(libs/*.cpp, true)

HEADERS += $$files(modules/*.h, true) \
           $$files(util/cpp/*.h, true) \
           $$files(libs/*.h, true)

RESOURCES += qml.qrc

############### Other files ###############
OTHER_FILES += LICENSE\
            README.md\
            .gitignore

############### Deployment ###############
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

#release: DESTDIR = build/release
#debug:   DESTDIR = build/debug
#
#OBJECTS_DIR = $$DESTDIR/.obj
#MOC_DIR = $$DESTDIR/.moc
#RCC_DIR = $$DESTDIR/.qrc
#UI_DIR = $$DESTDIR/.ui

#CONFIG(debug, debug|release) {
#    DESTDIR = build/debug
#} else {
#    DESTDIR = build/release
#}

#Release:DESTDIR = release
#Release:OBJECTS_DIR = release/.obj
#Release:MOC_DIR = release/.moc
#Release:RCC_DIR = release/.rcc
#Release:UI_DIR = release/.ui
#
#Debug:DESTDIR = debug
#Debug:OBJECTS_DIR = debug/.obj
#Debug:MOC_DIR = debug/.moc
#Debug:RCC_DIR = debug/.rcc
#Debug:UI_DIR = debug/.ui

############### I18n ###############
#TRANSLATIONS = i18n/persian.ts

### Users can run the programme from file manager.
QMAKE_LFLAGS += -no-pie

