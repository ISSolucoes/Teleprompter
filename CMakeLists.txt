cmake_minimum_required(VERSION 3.16)

project(Teleprompter VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)

set(CMAKE_INSTALL_LIBDIR "lib")

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appTeleprompter
    main.cpp Imagens.qrc Privacy_Policy.txt LICENSE.txt android/AndroidManifest.xml
)

qt_add_qml_module(appTeleprompter
    URI Teleprompter
    VERSION 1.0
    QML_FILES Main.qml Database.qml Teleprompter.qml Textos.qml PopUpCriarTextos.qml PopUpEditarTextos.qml
)

set_target_properties(appTeleprompter PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

set_property(TARGET appTeleprompter APPEND PROPERTY
    QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
)

target_link_libraries(appTeleprompter
    PRIVATE Qt6::Quick
)

install(TARGETS appTeleprompter
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
