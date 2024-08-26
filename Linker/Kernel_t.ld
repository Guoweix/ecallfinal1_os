OUTPUT_ARCH("riscv") /*指定输出的架构*/
OUTPUT_FORMAT("elf64-littleriscv") /*指定输出的大小端*/
ENTRY(kernel_entry) /*指定入口点*/

SECTIONS /*配置节表*/
{
	. = 0xFFFFFFFF80200000; /*.变量赋值为openSBI的入口地址0x80200000，.变量会随着后面节表的追加自动增加，即可以理解成.变量标识当前位置*/
	
	PROVIDE(kernelstart = .); /*创建变量并赋值(仅方便编程、可没有)*/
	
	.text : AT(0x80200000) /*配置代码节，代表内容存放的实际物理地址，但.自己也会跟着移动*/
	{
		textstart = .; /*创建变量并赋值(仅方便编程、可没有)*/
		*(.text.entry) /*将满足这些条件的节都放到这里来*/
		*(.text .stub .text.* .gnu.linkonce.t.*) /*将满足这些条件的节都放到这里来*/
		textend = .; /*创建变量并赋值(仅方便编程、可没有)*/
	}
	
	.rodata : /*配置只读数据节*/
	{
		rodatastart = .;
		*(.srodata .srodata.* .rodata .rodata.* .gnu.linkonce.r.*)
		rodataend = .;
	}
	
	. = ALIGN(0x1000);/*将.对齐到4KB*/
	
	.data : /*配置数据节*/
	{
		datastart = .;
		*(.data)
		*(.data.*)
		dataend = .;
	}
	
	. = ALIGN(0x1000);
	
	.bss : /*配置bss节*/
	{
		
	PROVIDE(bssstart = .); /*创建变量并赋值，并对外提供kernelend符号，即在C/C++中可以调用这个量*/
		*(.bss)
		*(.bss.*)
		*(.sbss*)
	PROVIDE(bssend = .); /*创建变量并赋值，并对外提供kernelend符号，即在C/C++中可以调用这个量*/
	}
	
	PROVIDE(kernel_end = .); /*创建变量并赋值，并对外提供kernelend符号，即在C/C++中可以调用这个量*/
	. = ALIGN(0x1000);
	PROVIDE(freememstart = .);
}