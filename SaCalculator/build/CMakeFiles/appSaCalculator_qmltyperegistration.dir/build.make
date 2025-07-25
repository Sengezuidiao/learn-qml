# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 4.0

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/homebrew/bin/cmake

# The command to remove a file.
RM = /opt/homebrew/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/qinguansen/Documents/learn-qml/SaCalculator

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/qinguansen/Documents/learn-qml/SaCalculator/build

# Utility rule file for appSaCalculator_qmltyperegistration.

# Include any custom commands dependencies for this target.
include CMakeFiles/appSaCalculator_qmltyperegistration.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/appSaCalculator_qmltyperegistration.dir/progress.make

CMakeFiles/appSaCalculator_qmltyperegistration: appsacalculator_qmltyperegistrations.cpp
CMakeFiles/appSaCalculator_qmltyperegistration: SaCalculator/appSaCalculator.qmltypes

appsacalculator_qmltyperegistrations.cpp: qmltypes/appSaCalculator_foreign_types.txt
appsacalculator_qmltyperegistrations.cpp: meta_types/qt6appsacalculator_metatypes.json
appsacalculator_qmltyperegistrations.cpp: /opt/homebrew/share/qt/libexec/qmltyperegistrar
appsacalculator_qmltyperegistrations.cpp: /opt/homebrew/share/qt/metatypes/qt6core_release_metatypes.json
appsacalculator_qmltyperegistrations.cpp: /opt/homebrew/share/qt/metatypes/qt6qml_release_metatypes.json
appsacalculator_qmltyperegistrations.cpp: /opt/homebrew/share/qt/metatypes/qt6network_release_metatypes.json
appsacalculator_qmltyperegistrations.cpp: /opt/homebrew/share/qt/metatypes/qt6quick_release_metatypes.json
appsacalculator_qmltyperegistrations.cpp: /opt/homebrew/share/qt/metatypes/qt6gui_release_metatypes.json
appsacalculator_qmltyperegistrations.cpp: /opt/homebrew/share/qt/metatypes/qt6qmlmeta_release_metatypes.json
appsacalculator_qmltyperegistrations.cpp: /opt/homebrew/share/qt/metatypes/qt6qmlmodels_release_metatypes.json
appsacalculator_qmltyperegistrations.cpp: /opt/homebrew/share/qt/metatypes/qt6qmlworkerscript_release_metatypes.json
appsacalculator_qmltyperegistrations.cpp: /opt/homebrew/share/qt/metatypes/qt6opengl_release_metatypes.json
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Automatic QML type registration for target appSaCalculator"
	/opt/homebrew/share/qt/libexec/qmltyperegistrar --generate-qmltypes=/Users/qinguansen/Documents/learn-qml/SaCalculator/build/SaCalculator/appSaCalculator.qmltypes --import-name=SaCalculator --major-version=1 --minor-version=0 @/Users/qinguansen/Documents/learn-qml/SaCalculator/build/qmltypes/appSaCalculator_foreign_types.txt -o /Users/qinguansen/Documents/learn-qml/SaCalculator/build/appsacalculator_qmltyperegistrations.cpp /Users/qinguansen/Documents/learn-qml/SaCalculator/build/meta_types/qt6appsacalculator_metatypes.json
	/opt/homebrew/bin/cmake -E make_directory /Users/qinguansen/Documents/learn-qml/SaCalculator/build/.qt/qmltypes
	/opt/homebrew/bin/cmake -E touch /Users/qinguansen/Documents/learn-qml/SaCalculator/build/.qt/qmltypes/appSaCalculator.qmltypes

SaCalculator/appSaCalculator.qmltypes: appsacalculator_qmltyperegistrations.cpp
	@$(CMAKE_COMMAND) -E touch_nocreate SaCalculator/appSaCalculator.qmltypes

meta_types/qt6appsacalculator_metatypes.json: meta_types/qt6appsacalculator_metatypes.json.gen
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating meta_types/qt6appsacalculator_metatypes.json"
	/opt/homebrew/bin/cmake -E true

meta_types/qt6appsacalculator_metatypes.json.gen: /opt/homebrew/share/qt/libexec/moc
meta_types/qt6appsacalculator_metatypes.json.gen: meta_types/appSaCalculator_json_file_list.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Running moc --collect-json for target appSaCalculator"
	/opt/homebrew/share/qt/libexec/moc -o /Users/qinguansen/Documents/learn-qml/SaCalculator/build/meta_types/qt6appsacalculator_metatypes.json.gen --collect-json @/Users/qinguansen/Documents/learn-qml/SaCalculator/build/meta_types/appSaCalculator_json_file_list.txt
	/opt/homebrew/bin/cmake -E copy_if_different /Users/qinguansen/Documents/learn-qml/SaCalculator/build/meta_types/qt6appsacalculator_metatypes.json.gen /Users/qinguansen/Documents/learn-qml/SaCalculator/build/meta_types/qt6appsacalculator_metatypes.json

meta_types/appSaCalculator_json_file_list.txt: /opt/homebrew/share/qt/libexec/cmake_automoc_parser
meta_types/appSaCalculator_json_file_list.txt: appSaCalculator_autogen/timestamp
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Running AUTOMOC file extraction for target appSaCalculator"
	/opt/homebrew/share/qt/libexec/cmake_automoc_parser --cmake-autogen-cache-file /Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles/appSaCalculator_autogen.dir/ParseCache.txt --cmake-autogen-info-file /Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles/appSaCalculator_autogen.dir/AutogenInfo.json --output-file-path /Users/qinguansen/Documents/learn-qml/SaCalculator/build/meta_types/appSaCalculator_json_file_list.txt --timestamp-file-path /Users/qinguansen/Documents/learn-qml/SaCalculator/build/meta_types/appSaCalculator_json_file_list.txt.timestamp --cmake-autogen-include-dir-path /Users/qinguansen/Documents/learn-qml/SaCalculator/build/appSaCalculator_autogen/include

appSaCalculator_autogen/timestamp: /opt/homebrew/share/qt/libexec/moc
appSaCalculator_autogen/timestamp: CMakeFiles/appSaCalculator_qmltyperegistration.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Automatic MOC and UIC for target appSaCalculator"
	/opt/homebrew/bin/cmake -E cmake_autogen /Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles/appSaCalculator_autogen.dir/AutogenInfo.json ""
	/opt/homebrew/bin/cmake -E touch /Users/qinguansen/Documents/learn-qml/SaCalculator/build/appSaCalculator_autogen/timestamp

CMakeFiles/appSaCalculator_qmltyperegistration.dir/codegen:
.PHONY : CMakeFiles/appSaCalculator_qmltyperegistration.dir/codegen

appSaCalculator_qmltyperegistration: CMakeFiles/appSaCalculator_qmltyperegistration
appSaCalculator_qmltyperegistration: SaCalculator/appSaCalculator.qmltypes
appSaCalculator_qmltyperegistration: appSaCalculator_autogen/timestamp
appSaCalculator_qmltyperegistration: appsacalculator_qmltyperegistrations.cpp
appSaCalculator_qmltyperegistration: meta_types/appSaCalculator_json_file_list.txt
appSaCalculator_qmltyperegistration: meta_types/qt6appsacalculator_metatypes.json
appSaCalculator_qmltyperegistration: meta_types/qt6appsacalculator_metatypes.json.gen
appSaCalculator_qmltyperegistration: CMakeFiles/appSaCalculator_qmltyperegistration.dir/build.make
.PHONY : appSaCalculator_qmltyperegistration

# Rule to build all files generated by this target.
CMakeFiles/appSaCalculator_qmltyperegistration.dir/build: appSaCalculator_qmltyperegistration
.PHONY : CMakeFiles/appSaCalculator_qmltyperegistration.dir/build

CMakeFiles/appSaCalculator_qmltyperegistration.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/appSaCalculator_qmltyperegistration.dir/cmake_clean.cmake
.PHONY : CMakeFiles/appSaCalculator_qmltyperegistration.dir/clean

CMakeFiles/appSaCalculator_qmltyperegistration.dir/depend:
	cd /Users/qinguansen/Documents/learn-qml/SaCalculator/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/qinguansen/Documents/learn-qml/SaCalculator /Users/qinguansen/Documents/learn-qml/SaCalculator /Users/qinguansen/Documents/learn-qml/SaCalculator/build /Users/qinguansen/Documents/learn-qml/SaCalculator/build /Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles/appSaCalculator_qmltyperegistration.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/appSaCalculator_qmltyperegistration.dir/depend

