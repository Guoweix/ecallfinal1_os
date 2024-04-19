#define REGBYTES 8//定义了下方要用的几个宏，便于移植时修改 
#define STORE sd
#define LOAD ld

	.macro SAVE_ALL//保存TrapFrame 
	csrw sscratch, sp//先把sp放到临时寄存器scratch里 
	addi sp, sp, -36 * REGBYTES //sp -36*8，即开辟大小为TrapFrame的空间  
	STORE x0,  (0*REGBYTES)(sp)//依次存储除sp外的各个寄存器，sp会在后面存储 
	STORE x1,  (1*REGBYTES)(sp)
	STORE x3,  (3*REGBYTES)(sp)
	STORE x4,  (4*REGBYTES)(sp)
	STORE x5,  (5*REGBYTES)(sp)
	STORE x6,  (6*REGBYTES)(sp)
	STORE x7,  (7*REGBYTES)(sp)
	STORE x8,  (8*REGBYTES)(sp)
	STORE x9,  (9*REGBYTES)(sp)
	STORE x10, (10*REGBYTES)(sp)
	STORE x11, (11*REGBYTES)(sp)
	STORE x12, (12*REGBYTES)(sp)
	STORE x13, (13*REGBYTES)(sp)
	STORE x14, (14*REGBYTES)(sp)
	STORE x15, (15*REGBYTES)(sp)
	STORE x16, (16*REGBYTES)(sp)
	STORE x17, (17*REGBYTES)(sp)
	STORE x18, (18*REGBYTES)(sp)
	STORE x19, (19*REGBYTES)(sp)
	STORE x20, (20*REGBYTES)(sp)
	STORE x21, (21*REGBYTES)(sp)
	STORE x22, (22*REGBYTES)(sp)
	STORE x23, (23*REGBYTES)(sp)
	STORE x24, (24*REGBYTES)(sp)
	STORE x25, (25*REGBYTES)(sp)
	STORE x26, (26*REGBYTES)(sp)
	STORE x27, (27*REGBYTES)(sp)
	STORE x28, (28*REGBYTES)(sp)
	STORE x29, (29*REGBYTES)(sp)
	STORE x30, (30*REGBYTES)(sp)
	STORE x31, (31*REGBYTES)(sp)
	
	csrrw s0, sscratch, x0//从scratch寄存器恢复sp到s0，并将scratch清空 
	csrr s1, sstatus//读取status、epc、tval、scause等寄存器到通用寄存器，因为这些寄存器无法直接写到内存 
	csrr s2, sepc
	csrr s3, stval
	csrr s4, scause
	STORE s0, 2*REGBYTES(sp)//存储一开始没修改过的sp寄存器
	STORE s1, 32*REGBYTES(sp)
	STORE s2, 33*REGBYTES(sp)
	STORE s3, 34*REGBYTES(sp)
	STORE s4, 35*REGBYTES(sp)
	.endm

	.macro RESTORE_ALL//恢复TrapFrame，此处基本上为与SAVE_ALL相反的操作 
	LOAD s1,  (32*REGBYTES)(sp)
	LOAD s2,  (33*REGBYTES)(sp)
	csrw sstatus, s1//tval和cause寄存器不是原来的执行状态，可以不恢复 
	csrw sepc, s2

	LOAD x1,  (1*REGBYTES)(sp)
	LOAD x3,  (3*REGBYTES)(sp)
	LOAD x4,  (4*REGBYTES)(sp)
	LOAD x5,  (5*REGBYTES)(sp)
	LOAD x6,  (6*REGBYTES)(sp)
	LOAD x7,  (7*REGBYTES)(sp)
	LOAD x8,  (8*REGBYTES)(sp)
	LOAD x9,  (9*REGBYTES)(sp)
	LOAD x10, (10*REGBYTES)(sp)
	LOAD x11, (11*REGBYTES)(sp)
	LOAD x12, (12*REGBYTES)(sp)
	LOAD x13, (13*REGBYTES)(sp)
	LOAD x14, (14*REGBYTES)(sp)
	LOAD x15, (15*REGBYTES)(sp)
	LOAD x16, (16*REGBYTES)(sp)
	LOAD x17, (17*REGBYTES)(sp)
	LOAD x18, (18*REGBYTES)(sp)
	LOAD x19, (19*REGBYTES)(sp)
	LOAD x20, (20*REGBYTES)(sp)
	LOAD x21, (21*REGBYTES)(sp)
	LOAD x22, (22*REGBYTES)(sp)
	LOAD x23, (23*REGBYTES)(sp)
	LOAD x24, (24*REGBYTES)(sp)
	LOAD x25, (25*REGBYTES)(sp)
	LOAD x26, (26*REGBYTES)(sp)
	LOAD x27, (27*REGBYTES)(sp)
	LOAD x28, (28*REGBYTES)(sp)
	LOAD x29, (29*REGBYTES)(sp)
	LOAD x30, (30*REGBYTES)(sp)
	LOAD x31, (31*REGBYTES)(sp)
	LOAD x2,  (2*REGBYTES)(sp)//最后恢复栈指针 
	.endm
	

	.align(2)
TrapEntry://Trap入口点 
	.globl TrapEntry
	SAVE_ALL//保存TrapFrame 
	move  a0, sp//将sp放到a0，此处sp即TrapFrame结构体的首地址，即进行了指针传递 
	jal Trap//跳转到Trap函数，执行完后继续执行下方的TrapRet 

TrapRet://Trap返回点 
	.globl TrapRet
	RESTORE_ALL//恢复TrapFrame 
	sret//从异常状态返回，恢复到异常前的执行流 
