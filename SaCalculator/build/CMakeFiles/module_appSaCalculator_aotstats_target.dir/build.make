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

# Utility rule file for module_appSaCalculator_aotstats_target.

# Include any custom commands dependencies for this target.
include CMakeFiles/module_appSaCalculator_aotstats_target.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/module_appSaCalculator_aotstats_target.dir/progress.make

CMakeFiles/module_appSaCalculator_aotstats_target: .rcc/qmlcache/module_appSaCalculator.aotstats

.rcc/qmlcache/module_appSaCalculator.aotstats: .rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp.aotstats
.rcc/qmlcache/module_appSaCalculator.aotstats: .rcc/qmlcache/module_appSaCalculator.aotstatslist
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating .rcc/qmlcache/module_appSaCalculator.aotstats"
	/opt/homebrew/share/qt/libexec/qmlaotstats aggregate /Users/qinguansen/Documents/learn-qml/SaCalculator/build/.rcc/qmlcache/module_appSaCalculator.aotstatslist /Users/qinguansen/Documents/learn-qml/SaCalculator/build/.rcc/qmlcache/module_appSaCalculator.aotstats

.rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp: /opt/homebrew/share/qt/libexec/qmlcachegen
.rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp: /Users/qinguansen/Documents/learn-qml/SaCalculator/qml/Main.qml
.rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp: .qt/rcc/qmake_SaCalculator.qrc
.rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp: .qt/rcc/appSaCalculator_raw_qml_0.qrc
.rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp: SaCalculator/appSaCalculator.qmltypes
.rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp: SaCalculator/qmldir
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating .rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp, .rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp.aotstats"
	/opt/homebrew/bin/cmake -E make_directory /Users/qinguansen/Documents/learn-qml/SaCalculator/build/.rcc/qmlcache/appSaCalculator_qml
	/opt/homebrew/share/qt/libexec/qmlcachegen --bare --resource-path /qt/qml/SaCalculator/qml/Main.qml -I /Users/qinguansen/Documents/learn-qml/SaCalculator/build -I /opt/homebrew/share/qt/qml -i /Users/qinguansen/Documents/learn-qml/SaCalculator/build/SaCalculator/qmldir --resource /Users/qinguansen/Documents/learn-qml/SaCalculator/build/.qt/rcc/qmake_SaCalculator.qrc --resource /Users/qinguansen/Documents/learn-qml/SaCalculator/build/.qt/rcc/appSaCalculator_raw_qml_0.qrc --dump-aot-stats "--module-id=SaCalculator(appSaCalculator)" -o /Users/qinguansen/Documents/learn-qml/SaCalculator/build/.rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp /Users/qinguansen/Documents/learn-qml/SaCalculator/qml/Main.qml

.rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp.aotstats: .rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp
	@$(CMAKE_COMMAND) -E touch_nocreate .rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp.aotstats

CMakeFiles/module_appSaCalculator_aotstats_target.dir/codegen:
.PHONY : CMakeFiles/module_appSaCalculator_aotstats_target.dir/codegen

module_appSaCalculator_aotstats_target: .rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp
module_appSaCalculator_aotstats_target: .rcc/qmlcache/appSaCalculator_qml/Main_qml.cpp.aotstats
module_appSaCalculator_aotstats_target: .rcc/qmlcache/module_appSaCalculator.aotstats
module_appSaCalculator_aotstats_target: CMakeFiles/module_appSaCalculator_aotstats_target
module_appSaCalculator_aotstats_target: CMakeFiles/module_appSaCalculator_aotstats_target.dir/build.make
.PHONY : module_appSaCalculator_aotstats_target

# Rule to build all files generated by this target.
CMakeFiles/module_appSaCalculator_aotstats_target.dir/build: module_appSaCalculator_aotstats_target
.PHONY : CMakeFiles/module_appSaCalculator_aotstats_target.dir/build

CMakeFiles/module_appSaCalculator_aotstats_target.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/module_appSaCalculator_aotstats_target.dir/cmake_clean.cmake
.PHONY : CMakeFiles/module_appSaCalculator_aotstats_target.dir/clean

CMakeFiles/module_appSaCalculator_aotstats_target.dir/depend:
	cd /Users/qinguansen/Documents/learn-qml/SaCalculator/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/qinguansen/Documents/learn-qml/SaCalculator /Users/qinguansen/Documents/learn-qml/SaCalculator /Users/qinguansen/Documents/learn-qml/SaCalculator/build /Users/qinguansen/Documents/learn-qml/SaCalculator/build /Users/qinguansen/Documents/learn-qml/SaCalculator/build/CMakeFiles/module_appSaCalculator_aotstats_target.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/module_appSaCalculator_aotstats_target.dir/depend

