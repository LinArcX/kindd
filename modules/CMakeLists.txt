add_library(
    dispatcher
    SHARED
    dispatcher/dispatcher.h
    dispatcher/dispatcher.cpp
    dispatcher/dispatcher_macro.h)
target_include_directories(dispatcher PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/dispatcher")
target_compile_definitions(dispatcher PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(dispatcher PRIVATE Qt5::Core Qt5::Quick Qt5::Qml)

add_library(
    qdevice_watcher
    SHARED
    qdevice_watcher/qdevice_watcher.h
    qdevice_watcher/qdevice_watcher.cpp)
target_include_directories(qdevice_watcher PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/qdevice_watcher")
target_compile_definitions(qdevice_watcher PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(qdevice_watcher PRIVATE Qt5::Core Qt5::Quick )


add_library(
    create_iso
    SHARED
    create_iso/create_iso.h
    create_iso/create_iso.cpp
    create_iso/create_iso_macro.h)
target_include_directories(create_iso PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/create_iso")
target_compile_definitions(create_iso PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(create_iso PRIVATE Qt5::Core Qt5::Quick )

add_library(
    settings
    SHARED
    settings/settings.h
    settings/settings.cpp
    settings/settings_macro.h)
target_include_directories(settings PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/settings")
target_compile_definitions(settings PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(settings PRIVATE Qt5::Core Qt5::Widgets Qt5::Quick Qt5::Qml)

add_library(
    utility
    SHARED
    utility/utility.h
    utility/utility.cpp
    utility/utility_macro.h
    utility/file_utility.h
    utility/file_utility.cpp
    utility/format_utility.h
    utility/format_utility.cpp
    utility/command_utility.h
    utility/command_utility.cpp
    utility/property_helper.h
    utility/kindd_global.h)
target_include_directories(utility PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/utility")
target_compile_definitions(utility PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(utility PRIVATE Qt5::Core Qt5::Quick Qt5::Qml)
