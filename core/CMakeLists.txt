add_executable(${NAME} "main.cpp" "${CMAKE_SOURCE_DIR}/assets/qml/qml.qrc")

target_link_libraries(${NAME} PRIVATE create_iso)
target_link_libraries(${NAME} PRIVATE settings)
target_link_libraries(${NAME} PRIVATE utility)
target_link_libraries(${NAME} PRIVATE dispatcher)
target_link_libraries(${NAME} PRIVATE qdevice_watcher)
target_compile_definitions(${NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${NAME} PRIVATE Qt5::Core Qt5::Widgets Qt5::Quick Qt5::QuickControls2 Qt5::Svg Qt5::Qml)
