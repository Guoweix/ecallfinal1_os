SRC_DIR := Kernel
TARGET_DIR := Build
CPP_FILES := $(shell find $(SRC_DIR) -name "*.cpp")
C_FILES := $(shell find $(SRC_DIR) -name "*.c")
ASM_FILES := $(shell find $(SRC_DIR) -name "*.S")

ELF_FILES := $(patsubst %.cpp,%.elf,$(CPP_FILES)) $(patsubst %.S,%.elf,$(ASM_FILES)) $(patsubst %.c,%.elf,$(C_FILES))
BUILD_ELF_FILES := $(patsubst %.cpp,$(TARGET_DIR)/%.elf,$(CPP_FILES)) $(patsubst %.S,$(TARGET_DIR)/%.elf,$(ASM_FILES)) $(patsubst %.c,$(TARGET_DIR)/%.elf,$(C_FILES))


GCC := riscv64-unknown-elf-gcc
CC := riscv64-unknown-elf-g++
FLAGS := -nostdlib -I"Include" -I"Include/File/lwext4_include" -fno-exceptions -fno-rtti -mcmodel=medany -std=c++17 
C_FLAGS := -nostdlib -I"Include" -I"Include/File/lwext4_include" -fno-exceptions -mcmodel=medany 
LD := riscv64-unknown-elf-ld
OBJCOPY := riscv64-unknown-elf-objcopy
DRIVE := -drive file=Img/sdcard.img,if=none,format=raw,id=x0  -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 
# DRIVE := -drive file=Img/fat32_image.img,if=none,format=raw,id=x0  -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 
BIOS :=  -bios SBI_BIN/opensbi-qemu.elf
USERIMG := -initrd Img/User.img


kernel-qemu.bin:mkdir Build/Kernel.elf
	cp Build/Kernel.elf ./kernel-qemu
	riscv64-linux-gnu-objcopy -O binary ./kernel-qemu kernel-qemu.bin

Build/Kernel.elf:$(BUILD_ELF_FILES)
	 $(LD) -o Build/Kernel.elf -T Linker/Kernel.ld $(BUILD_ELF_FILES)

runQemu:mkdir Build/Kernel.elf
	qemu-system-riscv64 -machine virt -kernel Build/Kernel.elf -m 128M -nographic -smp 2 $(BIOS) $(DRIVE) $(USERIMG) 2>&1 | tee output.log

run:kernel-qemu.bin
	# sshpass -p 12345678 scp kernel-qemu.bin gwx@192.168.3.58:/home/gwx/windowsfiles/
	cp kernel-qemu.bin ../tftp
	sudo Script/startFive2_test.exp


$(TARGET_DIR)/%.elf: %.c
	$(GCC) $(C_FLAGS) -c $<  -o $@

$(TARGET_DIR)/%.elf: %.cpp
	$(CC) $(FLAGS) -c $<  -o $@

$(TARGET_DIR)/%.elf: %.S
	$(CC) $(FLAGS) -c $<  -o $@


#-----------------user part---------------------------------

Img/User.o:User/User.cpp
	$(CC) $(FLAGS) -c $<  -o $@

Img/UserStart.o:User/Library/UserStart.S
	$(CC) $(FLAGS) -c $< -o $@

Img/UserMain.o:User/Library/UserMain.cpp
	$(CC) $(FLAGS) -c $< -o $@

Img/User.elf:Img/User.o Img/UserStart.o Img/UserMain.o
	$(LD)  -o $@ -T Linker/user.ld Img/User.o Img/UserStart.o Img/UserMain.o

Img/User.img:Img/User.elf
	$(OBJCOPY) $^ --strip-all -O binary $@
#----------------func part---------------------------------

clear:
	find Build -type f -delete

mkdir:
	mkdir -p Build/Kernel/Boot
	mkdir -p Build/Kernel/Driver
	mkdir -p Build/Kernel/File
	mkdir -p Build/Kernel/File/lwext4
	mkdir -p Build/Kernel/Library
	mkdir -p Build/Kernel/Memory
	mkdir -p Build/Kernel/Process
	mkdir -p Build/Kernel/Synchronize
	mkdir -p Build/Kernel/Trap
	mkdir -p Build/Kernel/Trap/Syscall

	
## sdcard img
sdcard:
	sudo dd if=Img/sdcard.img of=/dev/sdb1 bs=4M status=progress
