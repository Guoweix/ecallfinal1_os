# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.29

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
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build

# Include any dependencies generated for this target.
include CMakeFiles/test_echo.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/test_echo.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/test_echo.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/test_echo.dir/flags.make

CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.o: CMakeFiles/test_echo.dir/flags.make
CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.o: /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/src/oscomp/test_echo.c
CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.o: CMakeFiles/test_echo.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.o"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.o -MF CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.o.d -o CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.o -c /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/src/oscomp/test_echo.c

CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.i"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/src/oscomp/test_echo.c > CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.i

CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.s"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/src/oscomp/test_echo.c -o CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.s

# Object files for target test_echo
test_echo_OBJECTS = \
"CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.o"

# External object files for target test_echo
test_echo_EXTERNAL_OBJECTS =

riscv64/test_echo: CMakeFiles/test_echo.dir/src/oscomp/test_echo.c.o
riscv64/test_echo: CMakeFiles/test_echo.dir/build.make
riscv64/test_echo: libulib.a
riscv64/test_echo: CMakeFiles/test_echo.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable riscv64/test_echo"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test_echo.dir/link.txt --verbose=$(VERBOSE)
	mkdir -p asm
	riscv64-unknown-elf-objdump -d -S /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/test_echo > asm/test_echo.asm
	mkdir -p bin
	riscv64-unknown-elf-objcopy -O binary /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/test_echo bin/test_echo.bin --set-section-flags .bss=alloc,load,contents

# Rule to build all files generated by this target.
CMakeFiles/test_echo.dir/build: riscv64/test_echo
.PHONY : CMakeFiles/test_echo.dir/build

CMakeFiles/test_echo.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/test_echo.dir/cmake_clean.cmake
.PHONY : CMakeFiles/test_echo.dir/clean

CMakeFiles/test_echo.dir/depend:
	cd /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/CMakeFiles/test_echo.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/test_echo.dir/depend
