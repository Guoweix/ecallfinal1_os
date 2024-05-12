	.section .text.entry
kernel_entry:
	.global kernel_entry
	la		t0, boot_page_table_sv39//获取我们构造的页表地址,由于此时PC在物理地址,la产生的地址也是相应偏移的物理地址,而非boot_page_table_sv39符号的虚拟地址
	srli	t0, t0, 12//转换成物理页框号
	li 		t1, 8ull<<60//SV39页表模式参数
	or		t0, t0, t1//用于设置到satp寄存器的参数
	csrw	satp, t0//启动虚拟内存管理
	sfence.vma//虚拟内存屏障,刷新页表翻译
	
	li t1,0xFFFFFFFF00000000
	la sp, boot_stack_top
	add sp,sp,t1
	la t0, main
	add t0,t0,t1
	jalr t0
	
	.section .bss.stack
	.align 12
boot_stack:
	.global boot_stack
	
	.zero 4096
	
boot_stack_top:
	.global boot_stack_top

	.section .data//声明为data段，因为我们需要载入我们预设的数据
	.align 12//对齐到4K,保证在一个页框内(注意先声明.section再对齐)
boot_page_table_sv39://启动页表的符号
	.global boot_page_table_sv39
	.quad 0//quad表示Uint64，设置为0即非法映射
	.quad 0
	.quad (0x80000ull<<10)|0xCF//将大页的第三个虚拟页映射到大页的第三个物理页,即自映射，用于保证启动汇编可以成功读取到
	.quad 0
	.zero 8*504
	.quad (0x00000ull<<10)|0xCF//这四行将最后4GB空间(0xFFFFFFFF00000000~0xFFFFFFFFFFFFFFFF)映射到最开始的4GB(0x00000000~0xFFFFFFFF)
	.quad (0x40000ull<<10)|0xCF
	.quad (0x80000ull<<10)|0xCF
	.quad (0xC0000ull<<10)|0xCF