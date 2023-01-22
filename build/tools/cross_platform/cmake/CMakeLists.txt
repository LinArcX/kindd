cmake_minimum_required(VERSION 3.12)

SET(NAME kindd)
project(${NAME} LANGUAGES CXX)
project(${NAME} VERSION 1.0.0)

SET(CMAKE_AUTOMOC ON)
SET(CMAKE_AUTORCC ON)
SET(CMAKE_C_STANDARD 11)
SET(CMAKE_CXX_STANDARD 17)
SET(CMAKE_INCLUDE_CURRENT_DIR ON)
SET(CMAKE_CXX_STANDARD_REQUIRED ON)
SET(CMAKE_EXPORT_COMPILE_COMMANDS ON)

FIND_PACKAGE(PkgConfig REQUIRED)
PKG_CHECK_MODULES(kindd REQUIRED Qt5Core Qt5Gui Qt5Widgets Qt5Quick Qt5QuickControls2 Qt5Qml Qt5Svg Qt5OpenGL Qt5Network)
find_package(Qt5 COMPONENTS Core Gui Widgets Quick QuickControls2 Qml Svg OpenGL Network REQUIRED)

#################################
add_library(
    utility
    ../../../../sources/utility/utility.hpp
    ../../../../sources/utility/utility.cpp
    ../../../../sources/utility/utility_macro.hpp
    ../../../../sources/utility/file_utility.hpp
    ../../../../sources/utility/file_utility.cpp
    ../../../../sources/utility/format_utility.hpp
    ../../../../sources/utility/format_utility.cpp
    ../../../../sources/utility/command_utility.hpp
    ../../../../sources/utility/command_utility.cpp
    ../../../../sources/utility/property_helper.hpp
    ../../../../sources/utility/kindd_global.hpp)
target_include_directories(utility PUBLIC ../../../../sources/utility/)
target_compile_definitions(utility PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(utility PRIVATE Qt5::Core Qt5::Quick Qt5::Qml)

#################################
add_library(
    qdevice_watcher
    ../../../../sources/qdevice_watcher/qdevice_watcher.hpp
    ../../../../sources/qdevice_watcher/qdevice_watcher.cpp
    ../../../../sources/qdevice_watcher/qdevice_watcher_p.hpp
    ../../../../sources/qdevice_watcher/qdevicewatcher_linux.cpp
    ../../../../sources/qdevice_watcher/qdevicewatcher_mac.cpp
    ../../../../sources/qdevice_watcher/qdevicewatcher_win32.cpp
    ../../../../sources/qdevice_watcher/qdevicewatcher_wince.cpp)
target_include_directories(qdevice_watcher PUBLIC ../../../../sources/qdevice_watcher/)
target_compile_definitions(qdevice_watcher PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(qdevice_watcher PRIVATE Qt5::Core Qt5::Quick Qt5::Network)

#################################
add_library(
    create_iso
    ../../../../sources/create_iso/create_iso.hpp
    ../../../../sources/create_iso/create_iso.cpp
    ../../../../sources/create_iso/create_iso_macro.hpp)
target_include_directories(create_iso PUBLIC ../../../../sources/create_iso/)
target_compile_definitions(create_iso PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(create_iso PRIVATE Qt5::Core Qt5::Quick )
target_link_libraries(create_iso PUBLIC qdevice_watcher)
target_link_libraries(create_iso PUBLIC utility)

#################################
add_library(
    settings
    ../../../../sources/settings/settings.hpp
    ../../../../sources/settings/settings.cpp
    ../../../../sources/settings/settings_macro.hpp)
target_include_directories(settings PUBLIC ../../../../sources/settings/)
target_compile_definitions(settings PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(settings PRIVATE Qt5::Core Qt5::Widgets Qt5::Quick Qt5::Qml Qt5::QuickControls2)
target_link_libraries(settings PUBLIC utility)
target_link_libraries(settings PUBLIC dispatcher)

#################################
add_library(
    dispatcher
    ../../../../sources/dispatcher/dispatcher.hpp
    ../../../../sources/dispatcher/dispatcher.cpp
    ../../../../sources/dispatcher/dispatcher_macro.hpp)
target_include_directories(dispatcher PUBLIC ../../../../sources/dispatcher/)
target_compile_definitions(dispatcher PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(dispatcher PRIVATE Qt5::Core Qt5::Quick Qt5::Qml)
target_link_libraries(dispatcher PUBLIC create_iso)
target_link_libraries(dispatcher PUBLIC settings)

#################################
add_executable(${NAME} ../../../../sources/main.cpp ../../../../assets/qml/qml.qrc)
target_compile_definitions(${NAME} PUBLIC $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${NAME} PUBLIC Qt5::Core Qt5::Widgets Qt5::Quick Qt5::QuickControls2 Qt5::Svg Qt5::Qml)

target_link_libraries(${NAME} PUBLIC utility)
target_link_libraries(${NAME} PUBLIC settings)
target_link_libraries(${NAME} PUBLIC dispatcher)
target_link_libraries(${NAME} PUBLIC qdevice_watcher)
target_link_libraries(${NAME} PUBLIC create_iso)

set_target_properties(${NAME} PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY_DEBUG   ../linux/debug
  RUNTIME_OUTPUT_DIRECTORY_RELEASE ../linux/release
)
