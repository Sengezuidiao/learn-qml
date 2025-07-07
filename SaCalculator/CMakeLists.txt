cmake_minimum_required(VERSION 3.16)

project(
  SaCalculator
  VERSION 0.1
  LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

set(CMAKE_AUTORCC ON)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appSaCalculator main.cpp)

qt_add_qml_module(
  appSaCalculator
  URI
  SaCalculator
  VERSION
  1.0
  QML_FILES
  qml/Main.qml
  RESOURCES
  SOURCES
  sa/common.cpp
  sa/common.h
  sa/sa.cpp
  sa/sa.h
  Interface/Interface.cpp
  Interface/Interface.h
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1. If
# you are developing for iOS or macOS you should consider setting an explicit,
# fixed bundle identifier manually though.
set_target_properties(
  appSaCalculator
  PROPERTIES # MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appSaCalculator
             MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
             MACOSX_BUNDLE_SHORT_VERSION_STRING
             ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
             MACOSX_BUNDLE TRUE
             WIN32_EXECUTABLE TRUE)

target_link_libraries(appSaCalculator PRIVATE Qt6::Quick)

include(GNUInstallDirs)
install(
  TARGETS appSaCalculator
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
