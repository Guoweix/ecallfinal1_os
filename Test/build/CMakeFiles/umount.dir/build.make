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
include CMakeFiles/umount.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/umount.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/umount.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/umount.dir/flags.make

CMakeFiles/umount.dir/src/oscomp/umount.c.o: CMakeFiles/umount.dir/flags.make
CMakeFiles/umount.dir/src/oscomp/umount.c.o: /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/src/oscomp/umount.c
CMakeFiles/umount.dir/src/oscomp/umount.c.o: CMakeFiles/umount.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/umount.dir/src/oscomp/umount.c.o"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/umount.dir/src/oscomp/umount.c.o -MF CMakeFiles/umount.dir/src/oscomp/umount.c.o.d -o CMakeFiles/umount.dir/src/oscomp/umount.c.o -c /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/src/oscomp/umount.c

CMakeFiles/umount.dir/src/oscomp/umount.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/umount.dir/src/oscomp/umount.c.i"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/src/oscomp/umount.c > CMakeFiles/umount.dir/src/oscomp/umount.c.i

CMakeFiles/umount.dir/src/oscomp/umount.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/umount.dir/src/oscomp/umount.c.s"
	riscv64-unknown-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/src/oscomp/umount.c -o CMakeFiles/umount.dir/src/oscomp/umount.c.s

# Object files for target umount
umount_OBJECTS = \
"CMakeFiles/umount.dir/src/oscomp/umount.c.o"

# External object files for target umount
umount_EXTERNAL_OBJECTS =

riscv64/umount: CMakeFiles/umount.dir/src/oscomp/umount.c.o
riscv64/umount: CMakeFiles/umount.dir/build.make
riscv64/umount: libulib.a
riscv64/umount: CMakeFiles/umount.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable riscv64/umount"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/umount.dir/link.txt --verbose=$(VERBOSE)
	mkdir -p asm
	riscv64-unknown-elf-objdump -d -S /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/umount > asm/umount.asm
	mkdir -p bin
	riscv64-unknown-elf-objcopy -O binary /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/umount bin/umount.bin --set-section-flags .bss=alloc,load,contents

# Rule to build all files generated by this target.
CMakeFiles/umount.dir/build: riscv64/umount
.PHONY : CMakeFiles/umount.dir/build

CMakeFiles/umount.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/umount.dir/cmake_clean.cmake
.PHONY : CMakeFiles/umount.dir/clean

CMakeFiles/umount.dir/depend:
	cd /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build /home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/CMakeFiles/umount.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/umount.dir/depend

