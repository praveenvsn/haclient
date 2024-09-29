cmake_minimum_required(VERSION 3.16)

project(haclient VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick WebEngineQuick)
#target_link_libraries(apphaclient PRIVATE Qt6::WebEngineQuick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(apphaclient
    main.cpp
)

qt_add_qml_module(apphaclient
    URI haclient
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES DeviceManager.cpp
        SOURCES DeviceManager.h
        RESOURCES assets/power-button.png assets/reset-button.png
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(apphaclient PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.apphaclient
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(apphaclient
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS apphaclient
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
