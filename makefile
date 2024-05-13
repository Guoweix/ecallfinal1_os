SRC_DIR := Kernel
TARGET_DIR := Build
CPP_FILES := $(shell find $(SRC_DIR) -name "*.cpp")
ASM_FILES := $(shell find $(SRC_DIR) -name "*.S")

ELF_FILES := $(patsubst %.cpp,%.elf,$(CPP_FILES)) $(patsubst %.S,%.elf,$(ASM_FILES))
BUILD_ELF_FILES := $(patsubst %.cpp,$(TARGET_DIR)/%.elf,$(CPP_FILES)) $(patsubst %.S,$(TARGET_DIR)/%.elf,$(ASM_FILES))

CC := riscv64-unknown-elf-g++
FLAGS := -nostdlib -I"Include" -fno-exceptions -fno-rtti -mcmodel=medany -std=c++17 
LD := riscv64-unknown-elf-ld
OBJCOPY := riscv64-unknown-elf-objcopy
DRIVE := -drive file=SBI_BIN/udisk.img,if=none,format=raw,id=x0  -device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 
BIOS :=  -bios SBI_BIN/opensbi-qemu.elf
USERIMG := -initrd Img/User.img


# echo:
#	echo $(ELF_FILES)

Build/Kernel.elf:$(BUILD_ELF_FILES)
	$(LD) -o Build/Kernel.elf -T Linker/Kernel.ld $(BUILD_ELF_FILES)


run:Build/Kernel.elf
	qemu-system-riscv64 -machine virt -kernel Build/Kernel.elf -m 256M -nographic -smp 2 $(BIOS) $(DRIVE) $(USERIMG)


$(TARGET_DIR)/%.elf: %.cpp
	$(CC) $(FLAGS) -c $<  -o $@

$(TARGET_DIR)/%.elf: %.S
	$(CC) $(FLAGS) -c $<  -o $@

Img/User.o:User/User.cpp
	$(CC) $(FLAGS) -c $<  -o $@

Img/User.elf:Img/User.o
	$(LD)  -o $@ -T Linker/user.ld $<

Img/User.img:Img/User.elf
	$(OBJCOPY) $^ --strip-all -O binary $@

clear:
	find Build -type f -delete
