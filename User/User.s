
../Img/User.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <main>:
  800020:	1101                	addi	sp,sp,-32
  800022:	ec22                	sd	s0,24(sp)
  800024:	1000                	addi	s0,sp,32
  800026:	67e1                	lui	a5,0x18
  800028:	6a078793          	addi	a5,a5,1696 # 186a0 <main-0x7e7980>
  80002c:	fef42623          	sw	a5,-20(s0)
  800030:	fec42783          	lw	a5,-20(s0)
  800034:	2781                	sext.w	a5,a5
  800036:	c799                	beqz	a5,800044 <main+0x24>
  800038:	fec42783          	lw	a5,-20(s0)
  80003c:	37fd                	addiw	a5,a5,-1
  80003e:	fef42623          	sw	a5,-20(s0)
  800042:	b7fd                	j	800030 <main+0x10>
  800044:	05800513          	li	a0,88
  800048:	4581                	li	a1,0
  80004a:	4601                	li	a2,0
  80004c:	4681                	li	a3,0
  80004e:	4701                	li	a4,0
  800050:	4781                	li	a5,0
  800052:	4801                	li	a6,0
  800054:	4885                	li	a7,1
  800056:	00000073          	ecall
  80005a:	b7f1                	j	800026 <main+0x6>
