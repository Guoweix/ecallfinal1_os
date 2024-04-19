SRC_DIR := Kernel
TARGET_DIR := Build
CPP_FILES := $(shell find $(SRC_DIR) -name "*.cpp")
ASM_FILES := $(shell find $(SRC_DIR) -name "*.S")

ELF_FILES := $(patsubst %.cpp,%.elf,$(CPP_FILES)) $(patsubst %.S,%.elf,$(ASM_FILES))
BUILD_ELF_FILES := $(patsubst %.cpp,$(TARGET_DIR)/%.elf,$(CPP_FILES)) $(patsubst %.S,$(TARGET_DIR)/%.elf,$(ASM_FILES))

CC := riscv64-unknown-elf-g++
FLAGS := -nostdlib -I"Include" -fno-exceptions -fno-rtti -mcmodel=medany -std=c++17 


# echo:
#	echo $(ELF_FILES)

Build/Kernel.elf:$(BUILD_ELF_FILES)
	riscv64-unknown-elf-ld -o Build/Kernel.elf -T Linker/Kernel.ld $(BUILD_ELF_FILES)


run:Build/Kernel.elf
	qemu-system-riscv64 -machine virt -kernel Build/Kernel.elf -m 128M -nographic -smp 2 -bios SBI_BIN/opensbi-qemu.elf -drive file=SBI_BIN/udisk.img,if=none,format=raw,id=x0  -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 


$(TARGET_DIR)/%.elf: %.cpp
	$(CC) $(FLAGS) -c $<  -o $@

$(TARGET_DIR)/%.elf: %.S
	$(CC) $(FLAGS) -c $<  -o $@

clear:
	find Build -type f -delete
