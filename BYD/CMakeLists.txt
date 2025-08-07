cmake_minimum_required(VERSION 3.16)

project(
  BYD
  VERSION 0.1
  LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
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


target_link_libraries(appBYD PRIVATE Qt6::Quick)
