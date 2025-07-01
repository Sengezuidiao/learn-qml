cmake_minimum_required(VERSION 3.16)

project(
  BYD
  VERSION 0.1
  LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

set(CMAKE_AUTORCC ON)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appBYD main.cpp)

qt_add_qml_module(
  appBYD
  URI
  BYD
  VERSION
  1.0
  QML_FILES
  Main.qml
  HMI/Home.qml
  HMI/AC.qml
  HMI/App.qml
  HMI/ControlCenter.qml
  HMI/Settings.qml
  Components/ACBar.qml
  Components/ACFan.qml
  Components/ACFunctionBar.qml
  Components/ColorSlider.qml
  Components/IconButton.qml
  Components/IconSwitch.qml
  Components/Navigation.qml
  Components/QuickSlider.qml
  Components/QuickTemperatureList.qml
  Components/StatusBar.qml
  Components/SwipeArea.qml
  Components/SettingsFunctionBar.qml
  Components/SettingsModeBar.qml
  Components/SettingsList.qml
  Components/QuickWind.qml
  Components/FunctionBar2.qml
  Components/FunctionBar3.qml
  RESOURCES
  resources.qrc
  SOURCES
  Interface/Interface.cpp
  Interface/Interface.h)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1. If
# you are developing for iOS or macOS you should consider setting an explicit,
# fixed bundle identifier manually though.
set_target_properties(
  appBYD
  PROPERTIES # MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appBYD
             MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
             MACOSX_BUNDLE_SHORT_VERSION_STRING
             ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
             MACOSX_BUNDLE TRUE
             WIN32_EXECUTABLE TRUE)

target_link_libraries(appBYD PRIVATE Qt6::Quick)

include(GNUInstallDirs)
install(
  TARGETS appBYD
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
