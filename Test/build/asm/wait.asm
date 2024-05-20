
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/wait:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a0e1                	j	10ca <__start_main>

0000000000001004 <test_wait>:
#include "stdio.h"
#include "stdlib.h"
#include "unistd.h"

void test_wait(void){
    1004:	7179                	addi	sp,sp,-48
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f0a50513          	addi	a0,a0,-246 # 1f10 <__clone+0x2e>
void test_wait(void){
    100e:	f406                	sd	ra,40(sp)
    1010:	f022                	sd	s0,32(sp)
    1012:	ec26                	sd	s1,24(sp)
    TEST_START(__func__);
    1014:	328000ef          	jal	133c <puts>
    1018:	00001517          	auipc	a0,0x1
    101c:	fc850513          	addi	a0,a0,-56 # 1fe0 <__func__.0>
    1020:	31c000ef          	jal	133c <puts>
    1024:	00001517          	auipc	a0,0x1
    1028:	f0450513          	addi	a0,a0,-252 # 1f28 <__clone+0x46>
    102c:	310000ef          	jal	133c <puts>
    int cpid, wstatus;
    cpid = fork();
    1030:	4a9000ef          	jal	1cd8 <fork>
    if(cpid == 0){
    1034:	e129                	bnez	a0,1076 <test_wait+0x72>
	printf("This is child process\n");
    1036:	00001517          	auipc	a0,0x1
    103a:	f0250513          	addi	a0,a0,-254 # 1f38 <__clone+0x56>
    103e:	320000ef          	jal	135e <printf>
        exit(0);
    1042:	4501                	li	a0,0
    1044:	4b7000ef          	jal	1cfa <exit>
	if(ret == cpid)
	    printf("wait child success.\nwstatus: %d\n", wstatus);
	else
	    printf("wait child error.\n");
    }
    TEST_END(__func__);
    1048:	00001517          	auipc	a0,0x1
    104c:	f6850513          	addi	a0,a0,-152 # 1fb0 <__clone+0xce>
    1050:	2ec000ef          	jal	133c <puts>
    1054:	00001517          	auipc	a0,0x1
    1058:	f8c50513          	addi	a0,a0,-116 # 1fe0 <__func__.0>
    105c:	2e0000ef          	jal	133c <puts>
    1060:	00001517          	auipc	a0,0x1
    1064:	ec850513          	addi	a0,a0,-312 # 1f28 <__clone+0x46>
    1068:	2d4000ef          	jal	133c <puts>
}
    106c:	70a2                	ld	ra,40(sp)
    106e:	7402                	ld	s0,32(sp)
    1070:	64e2                	ld	s1,24(sp)
    1072:	6145                	addi	sp,sp,48
    1074:	8082                	ret
	pid_t ret = wait(&wstatus);
    1076:	842a                	mv	s0,a0
    1078:	0068                	addi	a0,sp,12
    107a:	545000ef          	jal	1dbe <wait>
	assert(ret != -1);
    107e:	57fd                	li	a5,-1
	pid_t ret = wait(&wstatus);
    1080:	84aa                	mv	s1,a0
	assert(ret != -1);
    1082:	02f50363          	beq	a0,a5,10a8 <test_wait+0xa4>
	if(ret == cpid)
    1086:	00940963          	beq	s0,s1,1098 <test_wait+0x94>
	    printf("wait child error.\n");
    108a:	00001517          	auipc	a0,0x1
    108e:	f0e50513          	addi	a0,a0,-242 # 1f98 <__clone+0xb6>
    1092:	2cc000ef          	jal	135e <printf>
    1096:	bf4d                	j	1048 <test_wait+0x44>
	    printf("wait child success.\nwstatus: %d\n", wstatus);
    1098:	45b2                	lw	a1,12(sp)
    109a:	00001517          	auipc	a0,0x1
    109e:	ed650513          	addi	a0,a0,-298 # 1f70 <__clone+0x8e>
    10a2:	2bc000ef          	jal	135e <printf>
    10a6:	b74d                	j	1048 <test_wait+0x44>
	assert(ret != -1);
    10a8:	00001517          	auipc	a0,0x1
    10ac:	ea850513          	addi	a0,a0,-344 # 1f50 <__clone+0x6e>
    10b0:	538000ef          	jal	15e8 <panic>
	if(ret == cpid)
    10b4:	fc941be3          	bne	s0,s1,108a <test_wait+0x86>
    10b8:	b7c5                	j	1098 <test_wait+0x94>

00000000000010ba <main>:

int main(void){
    10ba:	1141                	addi	sp,sp,-16
    10bc:	e406                	sd	ra,8(sp)
    test_wait();
    10be:	f47ff0ef          	jal	1004 <test_wait>
    return 0;
}
    10c2:	60a2                	ld	ra,8(sp)
    10c4:	4501                	li	a0,0
    10c6:	0141                	addi	sp,sp,16
    10c8:	8082                	ret

00000000000010ca <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10ca:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10cc:	4108                	lw	a0,0(a0)
{
    10ce:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10d0:	05a1                	addi	a1,a1,8
{
    10d2:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10d4:	fe7ff0ef          	jal	10ba <main>
    10d8:	423000ef          	jal	1cfa <exit>
	return 0;
}
    10dc:	60a2                	ld	ra,8(sp)
    10de:	4501                	li	a0,0
    10e0:	0141                	addi	sp,sp,16
    10e2:	8082                	ret

00000000000010e4 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10e4:	7179                	addi	sp,sp,-48
    10e6:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10e8:	12054b63          	bltz	a0,121e <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10ec:	02b577bb          	remuw	a5,a0,a1
    10f0:	00001617          	auipc	a2,0x1
    10f4:	f0060613          	addi	a2,a2,-256 # 1ff0 <digits>
    buf[16] = 0;
    10f8:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10fc:	0005871b          	sext.w	a4,a1
    1100:	1782                	slli	a5,a5,0x20
    1102:	9381                	srli	a5,a5,0x20
    1104:	97b2                	add	a5,a5,a2
    1106:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    110a:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    110e:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1112:	1cb56363          	bltu	a0,a1,12d8 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    1116:	45b9                	li	a1,14
    1118:	02e877bb          	remuw	a5,a6,a4
    111c:	1782                	slli	a5,a5,0x20
    111e:	9381                	srli	a5,a5,0x20
    1120:	97b2                	add	a5,a5,a2
    1122:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1126:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    112a:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    112e:	0ce86e63          	bltu	a6,a4,120a <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1132:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1136:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    113a:	1582                	slli	a1,a1,0x20
    113c:	9181                	srli	a1,a1,0x20
    113e:	95b2                	add	a1,a1,a2
    1140:	0005c583          	lbu	a1,0(a1)
    1144:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    1148:	0007859b          	sext.w	a1,a5
    114c:	12e6ec63          	bltu	a3,a4,1284 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1150:	02e7f6bb          	remuw	a3,a5,a4
    1154:	1682                	slli	a3,a3,0x20
    1156:	9281                	srli	a3,a3,0x20
    1158:	96b2                	add	a3,a3,a2
    115a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    115e:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1162:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1166:	12e5e863          	bltu	a1,a4,1296 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    116a:	02e876bb          	remuw	a3,a6,a4
    116e:	1682                	slli	a3,a3,0x20
    1170:	9281                	srli	a3,a3,0x20
    1172:	96b2                	add	a3,a3,a2
    1174:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1178:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    117c:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1180:	12e86463          	bltu	a6,a4,12a8 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1184:	02e5f6bb          	remuw	a3,a1,a4
    1188:	1682                	slli	a3,a3,0x20
    118a:	9281                	srli	a3,a3,0x20
    118c:	96b2                	add	a3,a3,a2
    118e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1192:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1196:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    119a:	0ce5ec63          	bltu	a1,a4,1272 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    119e:	02e876bb          	remuw	a3,a6,a4
    11a2:	1682                	slli	a3,a3,0x20
    11a4:	9281                	srli	a3,a3,0x20
    11a6:	96b2                	add	a3,a3,a2
    11a8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11ac:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11b0:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11b4:	10e86963          	bltu	a6,a4,12c6 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11b8:	02e5f6bb          	remuw	a3,a1,a4
    11bc:	1682                	slli	a3,a3,0x20
    11be:	9281                	srli	a3,a3,0x20
    11c0:	96b2                	add	a3,a3,a2
    11c2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11c6:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11ca:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11ce:	10e5e763          	bltu	a1,a4,12dc <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11d2:	02e876bb          	remuw	a3,a6,a4
    11d6:	1682                	slli	a3,a3,0x20
    11d8:	9281                	srli	a3,a3,0x20
    11da:	96b2                	add	a3,a3,a2
    11dc:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11e0:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11e4:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11e8:	10e86363          	bltu	a6,a4,12ee <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11ec:	1782                	slli	a5,a5,0x20
    11ee:	9381                	srli	a5,a5,0x20
    11f0:	97b2                	add	a5,a5,a2
    11f2:	0007c783          	lbu	a5,0(a5)
    11f6:	4599                	li	a1,6
    11f8:	00f10723          	sb	a5,14(sp)

    if (sign)
    11fc:	00055763          	bgez	a0,120a <printint.constprop.0+0x126>
        buf[i--] = '-';
    1200:	02d00793          	li	a5,45
    1204:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    1208:	4595                	li	a1,5
    write(f, s, l);
    120a:	003c                	addi	a5,sp,8
    120c:	4641                	li	a2,16
    120e:	9e0d                	subw	a2,a2,a1
    1210:	4505                	li	a0,1
    1212:	95be                	add	a1,a1,a5
    1214:	297000ef          	jal	1caa <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1218:	70a2                	ld	ra,40(sp)
    121a:	6145                	addi	sp,sp,48
    121c:	8082                	ret
        x = -xx;
    121e:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1222:	02b877bb          	remuw	a5,a6,a1
    1226:	00001617          	auipc	a2,0x1
    122a:	dca60613          	addi	a2,a2,-566 # 1ff0 <digits>
    buf[16] = 0;
    122e:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1232:	0005871b          	sext.w	a4,a1
    1236:	1782                	slli	a5,a5,0x20
    1238:	9381                	srli	a5,a5,0x20
    123a:	97b2                	add	a5,a5,a2
    123c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1240:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1244:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1248:	06b86963          	bltu	a6,a1,12ba <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    124c:	02e8f7bb          	remuw	a5,a7,a4
    1250:	1782                	slli	a5,a5,0x20
    1252:	9381                	srli	a5,a5,0x20
    1254:	97b2                	add	a5,a5,a2
    1256:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    125a:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    125e:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1262:	ece8f8e3          	bgeu	a7,a4,1132 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1266:	02d00793          	li	a5,45
    126a:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    126e:	45b5                	li	a1,13
    1270:	bf69                	j	120a <printint.constprop.0+0x126>
    1272:	45a9                	li	a1,10
    if (sign)
    1274:	f8055be3          	bgez	a0,120a <printint.constprop.0+0x126>
        buf[i--] = '-';
    1278:	02d00793          	li	a5,45
    127c:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1280:	45a5                	li	a1,9
    1282:	b761                	j	120a <printint.constprop.0+0x126>
    1284:	45b5                	li	a1,13
    if (sign)
    1286:	f80552e3          	bgez	a0,120a <printint.constprop.0+0x126>
        buf[i--] = '-';
    128a:	02d00793          	li	a5,45
    128e:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1292:	45b1                	li	a1,12
    1294:	bf9d                	j	120a <printint.constprop.0+0x126>
    1296:	45b1                	li	a1,12
    if (sign)
    1298:	f60559e3          	bgez	a0,120a <printint.constprop.0+0x126>
        buf[i--] = '-';
    129c:	02d00793          	li	a5,45
    12a0:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12a4:	45ad                	li	a1,11
    12a6:	b795                	j	120a <printint.constprop.0+0x126>
    12a8:	45ad                	li	a1,11
    if (sign)
    12aa:	f60550e3          	bgez	a0,120a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12ae:	02d00793          	li	a5,45
    12b2:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12b6:	45a9                	li	a1,10
    12b8:	bf89                	j	120a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12ba:	02d00793          	li	a5,45
    12be:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12c2:	45b9                	li	a1,14
    12c4:	b799                	j	120a <printint.constprop.0+0x126>
    12c6:	45a5                	li	a1,9
    if (sign)
    12c8:	f40551e3          	bgez	a0,120a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12cc:	02d00793          	li	a5,45
    12d0:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12d4:	45a1                	li	a1,8
    12d6:	bf15                	j	120a <printint.constprop.0+0x126>
    i = 15;
    12d8:	45bd                	li	a1,15
    12da:	bf05                	j	120a <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12dc:	45a1                	li	a1,8
    if (sign)
    12de:	f20556e3          	bgez	a0,120a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12e2:	02d00793          	li	a5,45
    12e6:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12ea:	459d                	li	a1,7
    12ec:	bf39                	j	120a <printint.constprop.0+0x126>
    12ee:	459d                	li	a1,7
    if (sign)
    12f0:	f0055de3          	bgez	a0,120a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12f4:	02d00793          	li	a5,45
    12f8:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12fc:	4599                	li	a1,6
    12fe:	b731                	j	120a <printint.constprop.0+0x126>

0000000000001300 <getchar>:
{
    1300:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1302:	00f10593          	addi	a1,sp,15
    1306:	4605                	li	a2,1
    1308:	4501                	li	a0,0
{
    130a:	ec06                	sd	ra,24(sp)
    char byte = 0;
    130c:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1310:	191000ef          	jal	1ca0 <read>
}
    1314:	60e2                	ld	ra,24(sp)
    1316:	00f14503          	lbu	a0,15(sp)
    131a:	6105                	addi	sp,sp,32
    131c:	8082                	ret

000000000000131e <putchar>:
{
    131e:	1101                	addi	sp,sp,-32
    1320:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1322:	00f10593          	addi	a1,sp,15
    1326:	4605                	li	a2,1
    1328:	4505                	li	a0,1
{
    132a:	ec06                	sd	ra,24(sp)
    char byte = c;
    132c:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1330:	17b000ef          	jal	1caa <write>
}
    1334:	60e2                	ld	ra,24(sp)
    1336:	2501                	sext.w	a0,a0
    1338:	6105                	addi	sp,sp,32
    133a:	8082                	ret

000000000000133c <puts>:
{
    133c:	1141                	addi	sp,sp,-16
    133e:	e406                	sd	ra,8(sp)
    1340:	e022                	sd	s0,0(sp)
    1342:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1344:	582000ef          	jal	18c6 <strlen>
    1348:	862a                	mv	a2,a0
    134a:	85a2                	mv	a1,s0
    134c:	4505                	li	a0,1
    134e:	15d000ef          	jal	1caa <write>
}
    1352:	60a2                	ld	ra,8(sp)
    1354:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1356:	957d                	srai	a0,a0,0x3f
    return r;
    1358:	2501                	sext.w	a0,a0
}
    135a:	0141                	addi	sp,sp,16
    135c:	8082                	ret

000000000000135e <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    135e:	7131                	addi	sp,sp,-192
    1360:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1362:	013c                	addi	a5,sp,136
{
    1364:	f0ca                	sd	s2,96(sp)
    1366:	ecce                	sd	s3,88(sp)
    1368:	e8d2                	sd	s4,80(sp)
    136a:	e4d6                	sd	s5,72(sp)
    136c:	e0da                	sd	s6,64(sp)
    136e:	fc5e                	sd	s7,56(sp)
    1370:	fc86                	sd	ra,120(sp)
    1372:	f8a2                	sd	s0,112(sp)
    1374:	f4a6                	sd	s1,104(sp)
    1376:	e52e                	sd	a1,136(sp)
    1378:	e932                	sd	a2,144(sp)
    137a:	ed36                	sd	a3,152(sp)
    137c:	f13a                	sd	a4,160(sp)
    137e:	f942                	sd	a6,176(sp)
    1380:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1382:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1384:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    1388:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    138c:	00001b97          	auipc	s7,0x1
    1390:	c34b8b93          	addi	s7,s7,-972 # 1fc0 <__clone+0xde>
        switch (s[1])
    1394:	07800a93          	li	s5,120
    1398:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    139c:	00001997          	auipc	s3,0x1
    13a0:	c5498993          	addi	s3,s3,-940 # 1ff0 <digits>
        if (!*s)
    13a4:	00054783          	lbu	a5,0(a0)
    13a8:	16078c63          	beqz	a5,1520 <printf+0x1c2>
    13ac:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13ae:	19278463          	beq	a5,s2,1536 <printf+0x1d8>
    13b2:	00164783          	lbu	a5,1(a2)
    13b6:	0605                	addi	a2,a2,1
    13b8:	fbfd                	bnez	a5,13ae <printf+0x50>
    13ba:	84b2                	mv	s1,a2
        l = z - a;
    13bc:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13c0:	85aa                	mv	a1,a0
    13c2:	8622                	mv	a2,s0
    13c4:	4505                	li	a0,1
    13c6:	0e5000ef          	jal	1caa <write>
        if (l)
    13ca:	18041f63          	bnez	s0,1568 <printf+0x20a>
        if (s[1] == 0)
    13ce:	0014c783          	lbu	a5,1(s1)
    13d2:	14078763          	beqz	a5,1520 <printf+0x1c2>
        switch (s[1])
    13d6:	1d478163          	beq	a5,s4,1598 <printf+0x23a>
    13da:	18fa6963          	bltu	s4,a5,156c <printf+0x20e>
    13de:	1b678363          	beq	a5,s6,1584 <printf+0x226>
    13e2:	07000713          	li	a4,112
    13e6:	1ce79c63          	bne	a5,a4,15be <printf+0x260>
            printptr(va_arg(ap, uint64));
    13ea:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13ec:	03000793          	li	a5,48
    13f0:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13f4:	631c                	ld	a5,0(a4)
    13f6:	0721                	addi	a4,a4,8
    13f8:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13fa:	00479f93          	slli	t6,a5,0x4
    13fe:	00879f13          	slli	t5,a5,0x8
    1402:	00c79e93          	slli	t4,a5,0xc
    1406:	01079e13          	slli	t3,a5,0x10
    140a:	01479313          	slli	t1,a5,0x14
    140e:	01879893          	slli	a7,a5,0x18
    1412:	01c79713          	slli	a4,a5,0x1c
    1416:	02479813          	slli	a6,a5,0x24
    141a:	02879513          	slli	a0,a5,0x28
    141e:	02c79593          	slli	a1,a5,0x2c
    1422:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1426:	03c7d293          	srli	t0,a5,0x3c
    142a:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    142e:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1432:	03cfdf93          	srli	t6,t6,0x3c
    1436:	03cf5f13          	srli	t5,t5,0x3c
    143a:	03cede93          	srli	t4,t4,0x3c
    143e:	03ce5e13          	srli	t3,t3,0x3c
    1442:	03c35313          	srli	t1,t1,0x3c
    1446:	03c8d893          	srli	a7,a7,0x3c
    144a:	9371                	srli	a4,a4,0x3c
    144c:	03c85813          	srli	a6,a6,0x3c
    1450:	9171                	srli	a0,a0,0x3c
    1452:	91f1                	srli	a1,a1,0x3c
    1454:	9271                	srli	a2,a2,0x3c
    1456:	974e                	add	a4,a4,s3
    1458:	92f1                	srli	a3,a3,0x3c
    145a:	92ce                	add	t0,t0,s3
    145c:	9fce                	add	t6,t6,s3
    145e:	9f4e                	add	t5,t5,s3
    1460:	9ece                	add	t4,t4,s3
    1462:	9e4e                	add	t3,t3,s3
    1464:	934e                	add	t1,t1,s3
    1466:	98ce                	add	a7,a7,s3
    1468:	93ce                	add	t2,t2,s3
    146a:	984e                	add	a6,a6,s3
    146c:	954e                	add	a0,a0,s3
    146e:	95ce                	add	a1,a1,s3
    1470:	964e                	add	a2,a2,s3
    1472:	0002c283          	lbu	t0,0(t0)
    1476:	000fcf83          	lbu	t6,0(t6)
    147a:	000f4f03          	lbu	t5,0(t5)
    147e:	000ece83          	lbu	t4,0(t4)
    1482:	000e4e03          	lbu	t3,0(t3)
    1486:	00034303          	lbu	t1,0(t1)
    148a:	0008c883          	lbu	a7,0(a7)
    148e:	00074403          	lbu	s0,0(a4)
    1492:	0003c383          	lbu	t2,0(t2)
    1496:	00084803          	lbu	a6,0(a6)
    149a:	00054503          	lbu	a0,0(a0)
    149e:	0005c583          	lbu	a1,0(a1)
    14a2:	00064603          	lbu	a2,0(a2)
    14a6:	00d98733          	add	a4,s3,a3
    14aa:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14ae:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14b2:	9371                	srli	a4,a4,0x3c
    14b4:	8bbd                	andi	a5,a5,15
    14b6:	00510523          	sb	t0,10(sp)
    14ba:	01f105a3          	sb	t6,11(sp)
    14be:	01e10623          	sb	t5,12(sp)
    14c2:	01d106a3          	sb	t4,13(sp)
    14c6:	01c10723          	sb	t3,14(sp)
    14ca:	006107a3          	sb	t1,15(sp)
    14ce:	01110823          	sb	a7,16(sp)
    14d2:	00710923          	sb	t2,18(sp)
    14d6:	010109a3          	sb	a6,19(sp)
    14da:	00a10a23          	sb	a0,20(sp)
    14de:	00b10aa3          	sb	a1,21(sp)
    14e2:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14e6:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ea:	008108a3          	sb	s0,17(sp)
    14ee:	974e                	add	a4,a4,s3
    14f0:	97ce                	add	a5,a5,s3
    14f2:	00d10ba3          	sb	a3,23(sp)
    14f6:	00074703          	lbu	a4,0(a4)
    14fa:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14fe:	4649                	li	a2,18
    1500:	002c                	addi	a1,sp,8
    1502:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1504:	00e10c23          	sb	a4,24(sp)
    1508:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    150c:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1510:	79a000ef          	jal	1caa <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    1514:	00248513          	addi	a0,s1,2
        if (!*s)
    1518:	00054783          	lbu	a5,0(a0)
    151c:	e80798e3          	bnez	a5,13ac <printf+0x4e>
    }
    va_end(ap);
}
    1520:	70e6                	ld	ra,120(sp)
    1522:	7446                	ld	s0,112(sp)
    1524:	74a6                	ld	s1,104(sp)
    1526:	7906                	ld	s2,96(sp)
    1528:	69e6                	ld	s3,88(sp)
    152a:	6a46                	ld	s4,80(sp)
    152c:	6aa6                	ld	s5,72(sp)
    152e:	6b06                	ld	s6,64(sp)
    1530:	7be2                	ld	s7,56(sp)
    1532:	6129                	addi	sp,sp,192
    1534:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1536:	00064783          	lbu	a5,0(a2)
    153a:	84b2                	mv	s1,a2
    153c:	01278963          	beq	a5,s2,154e <printf+0x1f0>
    1540:	bdb5                	j	13bc <printf+0x5e>
    1542:	0024c783          	lbu	a5,2(s1)
    1546:	0605                	addi	a2,a2,1
    1548:	0489                	addi	s1,s1,2
    154a:	e72799e3          	bne	a5,s2,13bc <printf+0x5e>
    154e:	0014c783          	lbu	a5,1(s1)
    1552:	ff2788e3          	beq	a5,s2,1542 <printf+0x1e4>
        l = z - a;
    1556:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    155a:	85aa                	mv	a1,a0
    155c:	8622                	mv	a2,s0
    155e:	4505                	li	a0,1
    1560:	74a000ef          	jal	1caa <write>
        if (l)
    1564:	e60405e3          	beqz	s0,13ce <printf+0x70>
    1568:	8526                	mv	a0,s1
    156a:	bd2d                	j	13a4 <printf+0x46>
        switch (s[1])
    156c:	05579963          	bne	a5,s5,15be <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1570:	6782                	ld	a5,0(sp)
    1572:	45c1                	li	a1,16
    1574:	4388                	lw	a0,0(a5)
    1576:	07a1                	addi	a5,a5,8
    1578:	e03e                	sd	a5,0(sp)
    157a:	b6bff0ef          	jal	10e4 <printint.constprop.0>
        s += 2;
    157e:	00248513          	addi	a0,s1,2
    1582:	bf59                	j	1518 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1584:	6782                	ld	a5,0(sp)
    1586:	45a9                	li	a1,10
    1588:	4388                	lw	a0,0(a5)
    158a:	07a1                	addi	a5,a5,8
    158c:	e03e                	sd	a5,0(sp)
    158e:	b57ff0ef          	jal	10e4 <printint.constprop.0>
        s += 2;
    1592:	00248513          	addi	a0,s1,2
    1596:	b749                	j	1518 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1598:	6782                	ld	a5,0(sp)
    159a:	6380                	ld	s0,0(a5)
    159c:	07a1                	addi	a5,a5,8
    159e:	e03e                	sd	a5,0(sp)
    15a0:	c031                	beqz	s0,15e4 <printf+0x286>
            l = strnlen(a, 200);
    15a2:	0c800593          	li	a1,200
    15a6:	8522                	mv	a0,s0
    15a8:	40a000ef          	jal	19b2 <strnlen>
    write(f, s, l);
    15ac:	0005061b          	sext.w	a2,a0
    15b0:	85a2                	mv	a1,s0
    15b2:	4505                	li	a0,1
    15b4:	6f6000ef          	jal	1caa <write>
        s += 2;
    15b8:	00248513          	addi	a0,s1,2
    15bc:	bfb1                	j	1518 <printf+0x1ba>
    return write(stdout, &byte, 1);
    15be:	4605                	li	a2,1
    15c0:	002c                	addi	a1,sp,8
    15c2:	4505                	li	a0,1
    char byte = c;
    15c4:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15c8:	6e2000ef          	jal	1caa <write>
    char byte = c;
    15cc:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15d0:	4605                	li	a2,1
    15d2:	002c                	addi	a1,sp,8
    15d4:	4505                	li	a0,1
    char byte = c;
    15d6:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15da:	6d0000ef          	jal	1caa <write>
        s += 2;
    15de:	00248513          	addi	a0,s1,2
    15e2:	bf1d                	j	1518 <printf+0x1ba>
                a = "(null)";
    15e4:	845e                	mv	s0,s7
    15e6:	bf75                	j	15a2 <printf+0x244>

00000000000015e8 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15e8:	1141                	addi	sp,sp,-16
    15ea:	e406                	sd	ra,8(sp)
    puts(m);
    15ec:	d51ff0ef          	jal	133c <puts>
    exit(-100);
}
    15f0:	60a2                	ld	ra,8(sp)
    exit(-100);
    15f2:	f9c00513          	li	a0,-100
}
    15f6:	0141                	addi	sp,sp,16
    exit(-100);
    15f8:	a709                	j	1cfa <exit>

00000000000015fa <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15fa:	02000793          	li	a5,32
    15fe:	00f50663          	beq	a0,a5,160a <isspace+0x10>
    1602:	355d                	addiw	a0,a0,-9
    1604:	00553513          	sltiu	a0,a0,5
    1608:	8082                	ret
    160a:	4505                	li	a0,1
}
    160c:	8082                	ret

000000000000160e <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    160e:	fd05051b          	addiw	a0,a0,-48
}
    1612:	00a53513          	sltiu	a0,a0,10
    1616:	8082                	ret

0000000000001618 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1618:	02000613          	li	a2,32
    161c:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    161e:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1622:	ff77069b          	addiw	a3,a4,-9
    1626:	04c70d63          	beq	a4,a2,1680 <atoi+0x68>
    162a:	0007079b          	sext.w	a5,a4
    162e:	04d5f963          	bgeu	a1,a3,1680 <atoi+0x68>
        s++;
    switch (*s)
    1632:	02b00693          	li	a3,43
    1636:	04d70a63          	beq	a4,a3,168a <atoi+0x72>
    163a:	02d00693          	li	a3,45
    163e:	06d70463          	beq	a4,a3,16a6 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1642:	fd07859b          	addiw	a1,a5,-48
    1646:	4625                	li	a2,9
    1648:	873e                	mv	a4,a5
    164a:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    164c:	4e01                	li	t3,0
    while (isdigit(*s))
    164e:	04b66a63          	bltu	a2,a1,16a2 <atoi+0x8a>
    int n = 0, neg = 0;
    1652:	4501                	li	a0,0
    while (isdigit(*s))
    1654:	4825                	li	a6,9
    1656:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    165a:	0025179b          	slliw	a5,a0,0x2
    165e:	9d3d                	addw	a0,a0,a5
    1660:	fd07031b          	addiw	t1,a4,-48
    1664:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1668:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    166c:	0685                	addi	a3,a3,1
    166e:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1672:	0006071b          	sext.w	a4,a2
    1676:	feb870e3          	bgeu	a6,a1,1656 <atoi+0x3e>
    return neg ? n : -n;
    167a:	000e0563          	beqz	t3,1684 <atoi+0x6c>
}
    167e:	8082                	ret
        s++;
    1680:	0505                	addi	a0,a0,1
    1682:	bf71                	j	161e <atoi+0x6>
    return neg ? n : -n;
    1684:	4113053b          	subw	a0,t1,a7
    1688:	8082                	ret
    while (isdigit(*s))
    168a:	00154783          	lbu	a5,1(a0)
    168e:	4625                	li	a2,9
        s++;
    1690:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1694:	fd07859b          	addiw	a1,a5,-48
    1698:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    169c:	4e01                	li	t3,0
    while (isdigit(*s))
    169e:	fab67ae3          	bgeu	a2,a1,1652 <atoi+0x3a>
    16a2:	4501                	li	a0,0
}
    16a4:	8082                	ret
    while (isdigit(*s))
    16a6:	00154783          	lbu	a5,1(a0)
    16aa:	4625                	li	a2,9
        s++;
    16ac:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16b0:	fd07859b          	addiw	a1,a5,-48
    16b4:	0007871b          	sext.w	a4,a5
    16b8:	feb665e3          	bltu	a2,a1,16a2 <atoi+0x8a>
        neg = 1;
    16bc:	4e05                	li	t3,1
    16be:	bf51                	j	1652 <atoi+0x3a>

00000000000016c0 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16c0:	16060d63          	beqz	a2,183a <memset+0x17a>
    16c4:	40a007b3          	neg	a5,a0
    16c8:	8b9d                	andi	a5,a5,7
    16ca:	00778713          	addi	a4,a5,7
    16ce:	482d                	li	a6,11
    16d0:	0ff5f593          	zext.b	a1,a1
    16d4:	fff60693          	addi	a3,a2,-1
    16d8:	17076263          	bltu	a4,a6,183c <memset+0x17c>
    16dc:	16e6ea63          	bltu	a3,a4,1850 <memset+0x190>
    16e0:	16078563          	beqz	a5,184a <memset+0x18a>
    16e4:	00b50023          	sb	a1,0(a0)
    16e8:	4705                	li	a4,1
    16ea:	00150e93          	addi	t4,a0,1
    16ee:	14e78c63          	beq	a5,a4,1846 <memset+0x186>
    16f2:	00b500a3          	sb	a1,1(a0)
    16f6:	4709                	li	a4,2
    16f8:	00250e93          	addi	t4,a0,2
    16fc:	14e78d63          	beq	a5,a4,1856 <memset+0x196>
    1700:	00b50123          	sb	a1,2(a0)
    1704:	470d                	li	a4,3
    1706:	00350e93          	addi	t4,a0,3
    170a:	12e78b63          	beq	a5,a4,1840 <memset+0x180>
    170e:	00b501a3          	sb	a1,3(a0)
    1712:	4711                	li	a4,4
    1714:	00450e93          	addi	t4,a0,4
    1718:	14e78163          	beq	a5,a4,185a <memset+0x19a>
    171c:	00b50223          	sb	a1,4(a0)
    1720:	4715                	li	a4,5
    1722:	00550e93          	addi	t4,a0,5
    1726:	12e78c63          	beq	a5,a4,185e <memset+0x19e>
    172a:	00b502a3          	sb	a1,5(a0)
    172e:	471d                	li	a4,7
    1730:	00650e93          	addi	t4,a0,6
    1734:	12e79763          	bne	a5,a4,1862 <memset+0x1a2>
    1738:	00750e93          	addi	t4,a0,7
    173c:	00b50323          	sb	a1,6(a0)
    1740:	4f1d                	li	t5,7
    1742:	00859713          	slli	a4,a1,0x8
    1746:	8f4d                	or	a4,a4,a1
    1748:	01059e13          	slli	t3,a1,0x10
    174c:	01c76e33          	or	t3,a4,t3
    1750:	01859313          	slli	t1,a1,0x18
    1754:	006e6333          	or	t1,t3,t1
    1758:	02059893          	slli	a7,a1,0x20
    175c:	011368b3          	or	a7,t1,a7
    1760:	02859813          	slli	a6,a1,0x28
    1764:	40f60333          	sub	t1,a2,a5
    1768:	0108e833          	or	a6,a7,a6
    176c:	03059693          	slli	a3,a1,0x30
    1770:	00d866b3          	or	a3,a6,a3
    1774:	03859713          	slli	a4,a1,0x38
    1778:	97aa                	add	a5,a5,a0
    177a:	ff837813          	andi	a6,t1,-8
    177e:	8f55                	or	a4,a4,a3
    1780:	00f806b3          	add	a3,a6,a5
    1784:	e398                	sd	a4,0(a5)
    1786:	07a1                	addi	a5,a5,8
    1788:	fed79ee3          	bne	a5,a3,1784 <memset+0xc4>
    178c:	ff837693          	andi	a3,t1,-8
    1790:	00de87b3          	add	a5,t4,a3
    1794:	01e6873b          	addw	a4,a3,t5
    1798:	0ad30663          	beq	t1,a3,1844 <memset+0x184>
    179c:	00b78023          	sb	a1,0(a5)
    17a0:	0017069b          	addiw	a3,a4,1
    17a4:	08c6fb63          	bgeu	a3,a2,183a <memset+0x17a>
    17a8:	00b780a3          	sb	a1,1(a5)
    17ac:	0027069b          	addiw	a3,a4,2
    17b0:	08c6f563          	bgeu	a3,a2,183a <memset+0x17a>
    17b4:	00b78123          	sb	a1,2(a5)
    17b8:	0037069b          	addiw	a3,a4,3
    17bc:	06c6ff63          	bgeu	a3,a2,183a <memset+0x17a>
    17c0:	00b781a3          	sb	a1,3(a5)
    17c4:	0047069b          	addiw	a3,a4,4
    17c8:	06c6f963          	bgeu	a3,a2,183a <memset+0x17a>
    17cc:	00b78223          	sb	a1,4(a5)
    17d0:	0057069b          	addiw	a3,a4,5
    17d4:	06c6f363          	bgeu	a3,a2,183a <memset+0x17a>
    17d8:	00b782a3          	sb	a1,5(a5)
    17dc:	0067069b          	addiw	a3,a4,6
    17e0:	04c6fd63          	bgeu	a3,a2,183a <memset+0x17a>
    17e4:	00b78323          	sb	a1,6(a5)
    17e8:	0077069b          	addiw	a3,a4,7
    17ec:	04c6f763          	bgeu	a3,a2,183a <memset+0x17a>
    17f0:	00b783a3          	sb	a1,7(a5)
    17f4:	0087069b          	addiw	a3,a4,8
    17f8:	04c6f163          	bgeu	a3,a2,183a <memset+0x17a>
    17fc:	00b78423          	sb	a1,8(a5)
    1800:	0097069b          	addiw	a3,a4,9
    1804:	02c6fb63          	bgeu	a3,a2,183a <memset+0x17a>
    1808:	00b784a3          	sb	a1,9(a5)
    180c:	00a7069b          	addiw	a3,a4,10
    1810:	02c6f563          	bgeu	a3,a2,183a <memset+0x17a>
    1814:	00b78523          	sb	a1,10(a5)
    1818:	00b7069b          	addiw	a3,a4,11
    181c:	00c6ff63          	bgeu	a3,a2,183a <memset+0x17a>
    1820:	00b785a3          	sb	a1,11(a5)
    1824:	00c7069b          	addiw	a3,a4,12
    1828:	00c6f963          	bgeu	a3,a2,183a <memset+0x17a>
    182c:	00b78623          	sb	a1,12(a5)
    1830:	2735                	addiw	a4,a4,13
    1832:	00c77463          	bgeu	a4,a2,183a <memset+0x17a>
    1836:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    183a:	8082                	ret
    183c:	472d                	li	a4,11
    183e:	bd79                	j	16dc <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1840:	4f0d                	li	t5,3
    1842:	b701                	j	1742 <memset+0x82>
    1844:	8082                	ret
    1846:	4f05                	li	t5,1
    1848:	bded                	j	1742 <memset+0x82>
    184a:	8eaa                	mv	t4,a0
    184c:	4f01                	li	t5,0
    184e:	bdd5                	j	1742 <memset+0x82>
    1850:	87aa                	mv	a5,a0
    1852:	4701                	li	a4,0
    1854:	b7a1                	j	179c <memset+0xdc>
    1856:	4f09                	li	t5,2
    1858:	b5ed                	j	1742 <memset+0x82>
    185a:	4f11                	li	t5,4
    185c:	b5dd                	j	1742 <memset+0x82>
    185e:	4f15                	li	t5,5
    1860:	b5cd                	j	1742 <memset+0x82>
    1862:	4f19                	li	t5,6
    1864:	bdf9                	j	1742 <memset+0x82>

0000000000001866 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1866:	00054783          	lbu	a5,0(a0)
    186a:	0005c703          	lbu	a4,0(a1)
    186e:	00e79863          	bne	a5,a4,187e <strcmp+0x18>
    1872:	0505                	addi	a0,a0,1
    1874:	0585                	addi	a1,a1,1
    1876:	fbe5                	bnez	a5,1866 <strcmp>
    1878:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    187a:	9d19                	subw	a0,a0,a4
    187c:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    187e:	0007851b          	sext.w	a0,a5
    1882:	bfe5                	j	187a <strcmp+0x14>

0000000000001884 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1884:	ce05                	beqz	a2,18bc <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1886:	00054703          	lbu	a4,0(a0)
    188a:	0005c783          	lbu	a5,0(a1)
    188e:	cb0d                	beqz	a4,18c0 <strncmp+0x3c>
    if (!n--)
    1890:	167d                	addi	a2,a2,-1
    1892:	00c506b3          	add	a3,a0,a2
    1896:	a819                	j	18ac <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1898:	00a68e63          	beq	a3,a0,18b4 <strncmp+0x30>
    189c:	0505                	addi	a0,a0,1
    189e:	00e79b63          	bne	a5,a4,18b4 <strncmp+0x30>
    18a2:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18a6:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18aa:	cb19                	beqz	a4,18c0 <strncmp+0x3c>
    18ac:	0005c783          	lbu	a5,0(a1)
    18b0:	0585                	addi	a1,a1,1
    18b2:	f3fd                	bnez	a5,1898 <strncmp+0x14>
    return *l - *r;
    18b4:	0007051b          	sext.w	a0,a4
    18b8:	9d1d                	subw	a0,a0,a5
    18ba:	8082                	ret
        return 0;
    18bc:	4501                	li	a0,0
}
    18be:	8082                	ret
    18c0:	4501                	li	a0,0
    return *l - *r;
    18c2:	9d1d                	subw	a0,a0,a5
    18c4:	8082                	ret

00000000000018c6 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18c6:	00757793          	andi	a5,a0,7
    18ca:	cf89                	beqz	a5,18e4 <strlen+0x1e>
    18cc:	87aa                	mv	a5,a0
    18ce:	a029                	j	18d8 <strlen+0x12>
    18d0:	0785                	addi	a5,a5,1
    18d2:	0077f713          	andi	a4,a5,7
    18d6:	cb01                	beqz	a4,18e6 <strlen+0x20>
        if (!*s)
    18d8:	0007c703          	lbu	a4,0(a5)
    18dc:	fb75                	bnez	a4,18d0 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18de:	40a78533          	sub	a0,a5,a0
}
    18e2:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18e4:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18e6:	6394                	ld	a3,0(a5)
    18e8:	00000597          	auipc	a1,0x0
    18ec:	6e05b583          	ld	a1,1760(a1) # 1fc8 <__clone+0xe6>
    18f0:	00000617          	auipc	a2,0x0
    18f4:	6e063603          	ld	a2,1760(a2) # 1fd0 <__clone+0xee>
    18f8:	a019                	j	18fe <strlen+0x38>
    18fa:	6794                	ld	a3,8(a5)
    18fc:	07a1                	addi	a5,a5,8
    18fe:	00b68733          	add	a4,a3,a1
    1902:	fff6c693          	not	a3,a3
    1906:	8f75                	and	a4,a4,a3
    1908:	8f71                	and	a4,a4,a2
    190a:	db65                	beqz	a4,18fa <strlen+0x34>
    for (; *s; s++)
    190c:	0007c703          	lbu	a4,0(a5)
    1910:	d779                	beqz	a4,18de <strlen+0x18>
    1912:	0017c703          	lbu	a4,1(a5)
    1916:	0785                	addi	a5,a5,1
    1918:	d379                	beqz	a4,18de <strlen+0x18>
    191a:	0017c703          	lbu	a4,1(a5)
    191e:	0785                	addi	a5,a5,1
    1920:	fb6d                	bnez	a4,1912 <strlen+0x4c>
    1922:	bf75                	j	18de <strlen+0x18>

0000000000001924 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1924:	00757713          	andi	a4,a0,7
{
    1928:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    192a:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    192e:	cb19                	beqz	a4,1944 <memchr+0x20>
    1930:	ce25                	beqz	a2,19a8 <memchr+0x84>
    1932:	0007c703          	lbu	a4,0(a5)
    1936:	04b70e63          	beq	a4,a1,1992 <memchr+0x6e>
    193a:	0785                	addi	a5,a5,1
    193c:	0077f713          	andi	a4,a5,7
    1940:	167d                	addi	a2,a2,-1
    1942:	f77d                	bnez	a4,1930 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1944:	4501                	li	a0,0
    if (n && *s != c)
    1946:	c235                	beqz	a2,19aa <memchr+0x86>
    1948:	0007c703          	lbu	a4,0(a5)
    194c:	04b70363          	beq	a4,a1,1992 <memchr+0x6e>
        size_t k = ONES * c;
    1950:	00000517          	auipc	a0,0x0
    1954:	68853503          	ld	a0,1672(a0) # 1fd8 <__clone+0xf6>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1958:	471d                	li	a4,7
        size_t k = ONES * c;
    195a:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    195e:	02c77a63          	bgeu	a4,a2,1992 <memchr+0x6e>
    1962:	00000897          	auipc	a7,0x0
    1966:	6668b883          	ld	a7,1638(a7) # 1fc8 <__clone+0xe6>
    196a:	00000817          	auipc	a6,0x0
    196e:	66683803          	ld	a6,1638(a6) # 1fd0 <__clone+0xee>
    1972:	431d                	li	t1,7
    1974:	a029                	j	197e <memchr+0x5a>
    1976:	1661                	addi	a2,a2,-8
    1978:	07a1                	addi	a5,a5,8
    197a:	02c37963          	bgeu	t1,a2,19ac <memchr+0x88>
    197e:	6398                	ld	a4,0(a5)
    1980:	8f29                	xor	a4,a4,a0
    1982:	011706b3          	add	a3,a4,a7
    1986:	fff74713          	not	a4,a4
    198a:	8f75                	and	a4,a4,a3
    198c:	01077733          	and	a4,a4,a6
    1990:	d37d                	beqz	a4,1976 <memchr+0x52>
    1992:	853e                	mv	a0,a5
    1994:	97b2                	add	a5,a5,a2
    1996:	a021                	j	199e <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1998:	0505                	addi	a0,a0,1
    199a:	00f50763          	beq	a0,a5,19a8 <memchr+0x84>
    199e:	00054703          	lbu	a4,0(a0)
    19a2:	feb71be3          	bne	a4,a1,1998 <memchr+0x74>
    19a6:	8082                	ret
    return n ? (void *)s : 0;
    19a8:	4501                	li	a0,0
}
    19aa:	8082                	ret
    return n ? (void *)s : 0;
    19ac:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19ae:	f275                	bnez	a2,1992 <memchr+0x6e>
}
    19b0:	8082                	ret

00000000000019b2 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19b2:	1101                	addi	sp,sp,-32
    19b4:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19b6:	862e                	mv	a2,a1
{
    19b8:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19ba:	4581                	li	a1,0
{
    19bc:	e426                	sd	s1,8(sp)
    19be:	ec06                	sd	ra,24(sp)
    19c0:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19c2:	f63ff0ef          	jal	1924 <memchr>
    return p ? p - s : n;
    19c6:	c519                	beqz	a0,19d4 <strnlen+0x22>
}
    19c8:	60e2                	ld	ra,24(sp)
    19ca:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19cc:	8d05                	sub	a0,a0,s1
}
    19ce:	64a2                	ld	s1,8(sp)
    19d0:	6105                	addi	sp,sp,32
    19d2:	8082                	ret
    19d4:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19d6:	8522                	mv	a0,s0
}
    19d8:	6442                	ld	s0,16(sp)
    19da:	64a2                	ld	s1,8(sp)
    19dc:	6105                	addi	sp,sp,32
    19de:	8082                	ret

00000000000019e0 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19e0:	00b547b3          	xor	a5,a0,a1
    19e4:	8b9d                	andi	a5,a5,7
    19e6:	eb95                	bnez	a5,1a1a <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19e8:	0075f793          	andi	a5,a1,7
    19ec:	e7b1                	bnez	a5,1a38 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19ee:	6198                	ld	a4,0(a1)
    19f0:	00000617          	auipc	a2,0x0
    19f4:	5d863603          	ld	a2,1496(a2) # 1fc8 <__clone+0xe6>
    19f8:	00000817          	auipc	a6,0x0
    19fc:	5d883803          	ld	a6,1496(a6) # 1fd0 <__clone+0xee>
    1a00:	a029                	j	1a0a <strcpy+0x2a>
    1a02:	e118                	sd	a4,0(a0)
    1a04:	6598                	ld	a4,8(a1)
    1a06:	05a1                	addi	a1,a1,8
    1a08:	0521                	addi	a0,a0,8
    1a0a:	00c707b3          	add	a5,a4,a2
    1a0e:	fff74693          	not	a3,a4
    1a12:	8ff5                	and	a5,a5,a3
    1a14:	0107f7b3          	and	a5,a5,a6
    1a18:	d7ed                	beqz	a5,1a02 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a1a:	0005c783          	lbu	a5,0(a1)
    1a1e:	00f50023          	sb	a5,0(a0)
    1a22:	c785                	beqz	a5,1a4a <strcpy+0x6a>
    1a24:	0015c783          	lbu	a5,1(a1)
    1a28:	0505                	addi	a0,a0,1
    1a2a:	0585                	addi	a1,a1,1
    1a2c:	00f50023          	sb	a5,0(a0)
    1a30:	fbf5                	bnez	a5,1a24 <strcpy+0x44>
        ;
    return d;
}
    1a32:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a34:	0505                	addi	a0,a0,1
    1a36:	df45                	beqz	a4,19ee <strcpy+0xe>
            if (!(*d = *s))
    1a38:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a3c:	0585                	addi	a1,a1,1
    1a3e:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a42:	00f50023          	sb	a5,0(a0)
    1a46:	f7fd                	bnez	a5,1a34 <strcpy+0x54>
}
    1a48:	8082                	ret
    1a4a:	8082                	ret

0000000000001a4c <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a4c:	00b547b3          	xor	a5,a0,a1
    1a50:	8b9d                	andi	a5,a5,7
    1a52:	1a079863          	bnez	a5,1c02 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a56:	0075f793          	andi	a5,a1,7
    1a5a:	16078463          	beqz	a5,1bc2 <strncpy+0x176>
    1a5e:	ea01                	bnez	a2,1a6e <strncpy+0x22>
    1a60:	a421                	j	1c68 <strncpy+0x21c>
    1a62:	167d                	addi	a2,a2,-1
    1a64:	0505                	addi	a0,a0,1
    1a66:	14070e63          	beqz	a4,1bc2 <strncpy+0x176>
    1a6a:	1a060863          	beqz	a2,1c1a <strncpy+0x1ce>
    1a6e:	0005c783          	lbu	a5,0(a1)
    1a72:	0585                	addi	a1,a1,1
    1a74:	0075f713          	andi	a4,a1,7
    1a78:	00f50023          	sb	a5,0(a0)
    1a7c:	f3fd                	bnez	a5,1a62 <strncpy+0x16>
    1a7e:	4805                	li	a6,1
    1a80:	1a061863          	bnez	a2,1c30 <strncpy+0x1e4>
    1a84:	40a007b3          	neg	a5,a0
    1a88:	8b9d                	andi	a5,a5,7
    1a8a:	4681                	li	a3,0
    1a8c:	18061a63          	bnez	a2,1c20 <strncpy+0x1d4>
    1a90:	00778713          	addi	a4,a5,7
    1a94:	45ad                	li	a1,11
    1a96:	18b76363          	bltu	a4,a1,1c1c <strncpy+0x1d0>
    1a9a:	1ae6eb63          	bltu	a3,a4,1c50 <strncpy+0x204>
    1a9e:	1a078363          	beqz	a5,1c44 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1aa2:	00050023          	sb	zero,0(a0)
    1aa6:	4685                	li	a3,1
    1aa8:	00150713          	addi	a4,a0,1
    1aac:	18d78f63          	beq	a5,a3,1c4a <strncpy+0x1fe>
    1ab0:	000500a3          	sb	zero,1(a0)
    1ab4:	4689                	li	a3,2
    1ab6:	00250713          	addi	a4,a0,2
    1aba:	18d78e63          	beq	a5,a3,1c56 <strncpy+0x20a>
    1abe:	00050123          	sb	zero,2(a0)
    1ac2:	468d                	li	a3,3
    1ac4:	00350713          	addi	a4,a0,3
    1ac8:	16d78c63          	beq	a5,a3,1c40 <strncpy+0x1f4>
    1acc:	000501a3          	sb	zero,3(a0)
    1ad0:	4691                	li	a3,4
    1ad2:	00450713          	addi	a4,a0,4
    1ad6:	18d78263          	beq	a5,a3,1c5a <strncpy+0x20e>
    1ada:	00050223          	sb	zero,4(a0)
    1ade:	4695                	li	a3,5
    1ae0:	00550713          	addi	a4,a0,5
    1ae4:	16d78d63          	beq	a5,a3,1c5e <strncpy+0x212>
    1ae8:	000502a3          	sb	zero,5(a0)
    1aec:	469d                	li	a3,7
    1aee:	00650713          	addi	a4,a0,6
    1af2:	16d79863          	bne	a5,a3,1c62 <strncpy+0x216>
    1af6:	00750713          	addi	a4,a0,7
    1afa:	00050323          	sb	zero,6(a0)
    1afe:	40f80833          	sub	a6,a6,a5
    1b02:	ff887593          	andi	a1,a6,-8
    1b06:	97aa                	add	a5,a5,a0
    1b08:	95be                	add	a1,a1,a5
    1b0a:	0007b023          	sd	zero,0(a5)
    1b0e:	07a1                	addi	a5,a5,8
    1b10:	feb79de3          	bne	a5,a1,1b0a <strncpy+0xbe>
    1b14:	ff887593          	andi	a1,a6,-8
    1b18:	9ead                	addw	a3,a3,a1
    1b1a:	00b707b3          	add	a5,a4,a1
    1b1e:	12b80863          	beq	a6,a1,1c4e <strncpy+0x202>
    1b22:	00078023          	sb	zero,0(a5)
    1b26:	0016871b          	addiw	a4,a3,1
    1b2a:	0ec77863          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1b2e:	000780a3          	sb	zero,1(a5)
    1b32:	0026871b          	addiw	a4,a3,2
    1b36:	0ec77263          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1b3a:	00078123          	sb	zero,2(a5)
    1b3e:	0036871b          	addiw	a4,a3,3
    1b42:	0cc77c63          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1b46:	000781a3          	sb	zero,3(a5)
    1b4a:	0046871b          	addiw	a4,a3,4
    1b4e:	0cc77663          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1b52:	00078223          	sb	zero,4(a5)
    1b56:	0056871b          	addiw	a4,a3,5
    1b5a:	0cc77063          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1b5e:	000782a3          	sb	zero,5(a5)
    1b62:	0066871b          	addiw	a4,a3,6
    1b66:	0ac77a63          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1b6a:	00078323          	sb	zero,6(a5)
    1b6e:	0076871b          	addiw	a4,a3,7
    1b72:	0ac77463          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1b76:	000783a3          	sb	zero,7(a5)
    1b7a:	0086871b          	addiw	a4,a3,8
    1b7e:	08c77e63          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1b82:	00078423          	sb	zero,8(a5)
    1b86:	0096871b          	addiw	a4,a3,9
    1b8a:	08c77863          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1b8e:	000784a3          	sb	zero,9(a5)
    1b92:	00a6871b          	addiw	a4,a3,10
    1b96:	08c77263          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1b9a:	00078523          	sb	zero,10(a5)
    1b9e:	00b6871b          	addiw	a4,a3,11
    1ba2:	06c77c63          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1ba6:	000785a3          	sb	zero,11(a5)
    1baa:	00c6871b          	addiw	a4,a3,12
    1bae:	06c77663          	bgeu	a4,a2,1c1a <strncpy+0x1ce>
    1bb2:	00078623          	sb	zero,12(a5)
    1bb6:	26b5                	addiw	a3,a3,13
    1bb8:	06c6f163          	bgeu	a3,a2,1c1a <strncpy+0x1ce>
    1bbc:	000786a3          	sb	zero,13(a5)
    1bc0:	8082                	ret
            ;
        if (!n || !*s)
    1bc2:	c645                	beqz	a2,1c6a <strncpy+0x21e>
    1bc4:	0005c783          	lbu	a5,0(a1)
    1bc8:	ea078be3          	beqz	a5,1a7e <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bcc:	479d                	li	a5,7
    1bce:	02c7ff63          	bgeu	a5,a2,1c0c <strncpy+0x1c0>
    1bd2:	00000897          	auipc	a7,0x0
    1bd6:	3f68b883          	ld	a7,1014(a7) # 1fc8 <__clone+0xe6>
    1bda:	00000817          	auipc	a6,0x0
    1bde:	3f683803          	ld	a6,1014(a6) # 1fd0 <__clone+0xee>
    1be2:	431d                	li	t1,7
    1be4:	6198                	ld	a4,0(a1)
    1be6:	011707b3          	add	a5,a4,a7
    1bea:	fff74693          	not	a3,a4
    1bee:	8ff5                	and	a5,a5,a3
    1bf0:	0107f7b3          	and	a5,a5,a6
    1bf4:	ef81                	bnez	a5,1c0c <strncpy+0x1c0>
            *wd = *ws;
    1bf6:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bf8:	1661                	addi	a2,a2,-8
    1bfa:	05a1                	addi	a1,a1,8
    1bfc:	0521                	addi	a0,a0,8
    1bfe:	fec363e3          	bltu	t1,a2,1be4 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c02:	e609                	bnez	a2,1c0c <strncpy+0x1c0>
    1c04:	a08d                	j	1c66 <strncpy+0x21a>
    1c06:	167d                	addi	a2,a2,-1
    1c08:	0505                	addi	a0,a0,1
    1c0a:	ca01                	beqz	a2,1c1a <strncpy+0x1ce>
    1c0c:	0005c783          	lbu	a5,0(a1)
    1c10:	0585                	addi	a1,a1,1
    1c12:	00f50023          	sb	a5,0(a0)
    1c16:	fbe5                	bnez	a5,1c06 <strncpy+0x1ba>
        ;
tail:
    1c18:	b59d                	j	1a7e <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c1a:	8082                	ret
    1c1c:	472d                	li	a4,11
    1c1e:	bdb5                	j	1a9a <strncpy+0x4e>
    1c20:	00778713          	addi	a4,a5,7
    1c24:	45ad                	li	a1,11
    1c26:	fff60693          	addi	a3,a2,-1
    1c2a:	e6b778e3          	bgeu	a4,a1,1a9a <strncpy+0x4e>
    1c2e:	b7fd                	j	1c1c <strncpy+0x1d0>
    1c30:	40a007b3          	neg	a5,a0
    1c34:	8832                	mv	a6,a2
    1c36:	8b9d                	andi	a5,a5,7
    1c38:	4681                	li	a3,0
    1c3a:	e4060be3          	beqz	a2,1a90 <strncpy+0x44>
    1c3e:	b7cd                	j	1c20 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c40:	468d                	li	a3,3
    1c42:	bd75                	j	1afe <strncpy+0xb2>
    1c44:	872a                	mv	a4,a0
    1c46:	4681                	li	a3,0
    1c48:	bd5d                	j	1afe <strncpy+0xb2>
    1c4a:	4685                	li	a3,1
    1c4c:	bd4d                	j	1afe <strncpy+0xb2>
    1c4e:	8082                	ret
    1c50:	87aa                	mv	a5,a0
    1c52:	4681                	li	a3,0
    1c54:	b5f9                	j	1b22 <strncpy+0xd6>
    1c56:	4689                	li	a3,2
    1c58:	b55d                	j	1afe <strncpy+0xb2>
    1c5a:	4691                	li	a3,4
    1c5c:	b54d                	j	1afe <strncpy+0xb2>
    1c5e:	4695                	li	a3,5
    1c60:	bd79                	j	1afe <strncpy+0xb2>
    1c62:	4699                	li	a3,6
    1c64:	bd69                	j	1afe <strncpy+0xb2>
    1c66:	8082                	ret
    1c68:	8082                	ret
    1c6a:	8082                	ret

0000000000001c6c <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c6c:	87aa                	mv	a5,a0
    1c6e:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c70:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c74:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c78:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c7a:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c7c:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c80:	2501                	sext.w	a0,a0
    1c82:	8082                	ret

0000000000001c84 <openat>:
    register long a7 __asm__("a7") = n;
    1c84:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c88:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c8c:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c90:	2501                	sext.w	a0,a0
    1c92:	8082                	ret

0000000000001c94 <close>:
    register long a7 __asm__("a7") = n;
    1c94:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c98:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c9c:	2501                	sext.w	a0,a0
    1c9e:	8082                	ret

0000000000001ca0 <read>:
    register long a7 __asm__("a7") = n;
    1ca0:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ca4:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1ca8:	8082                	ret

0000000000001caa <write>:
    register long a7 __asm__("a7") = n;
    1caa:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cae:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cb2:	8082                	ret

0000000000001cb4 <getpid>:
    register long a7 __asm__("a7") = n;
    1cb4:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cb8:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cbc:	2501                	sext.w	a0,a0
    1cbe:	8082                	ret

0000000000001cc0 <getppid>:
    register long a7 __asm__("a7") = n;
    1cc0:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cc4:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cc8:	2501                	sext.w	a0,a0
    1cca:	8082                	ret

0000000000001ccc <sched_yield>:
    register long a7 __asm__("a7") = n;
    1ccc:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cd0:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cd4:	2501                	sext.w	a0,a0
    1cd6:	8082                	ret

0000000000001cd8 <fork>:
    register long a7 __asm__("a7") = n;
    1cd8:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cdc:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cde:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ce0:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1ce4:	2501                	sext.w	a0,a0
    1ce6:	8082                	ret

0000000000001ce8 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1ce8:	85b2                	mv	a1,a2
    1cea:	863a                	mv	a2,a4
    if (stack)
    1cec:	c191                	beqz	a1,1cf0 <clone+0x8>
	stack += stack_size;
    1cee:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cf0:	4781                	li	a5,0
    1cf2:	4701                	li	a4,0
    1cf4:	4681                	li	a3,0
    1cf6:	2601                	sext.w	a2,a2
    1cf8:	a2ed                	j	1ee2 <__clone>

0000000000001cfa <exit>:
    register long a7 __asm__("a7") = n;
    1cfa:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cfe:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d02:	8082                	ret

0000000000001d04 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d04:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d08:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d0a:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d0e:	2501                	sext.w	a0,a0
    1d10:	8082                	ret

0000000000001d12 <exec>:
    register long a7 __asm__("a7") = n;
    1d12:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d16:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d1a:	2501                	sext.w	a0,a0
    1d1c:	8082                	ret

0000000000001d1e <execve>:
    register long a7 __asm__("a7") = n;
    1d1e:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d22:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d26:	2501                	sext.w	a0,a0
    1d28:	8082                	ret

0000000000001d2a <times>:
    register long a7 __asm__("a7") = n;
    1d2a:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d2e:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d32:	2501                	sext.w	a0,a0
    1d34:	8082                	ret

0000000000001d36 <get_time>:

int64 get_time()
{
    1d36:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d38:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d3c:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d3e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d40:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d44:	2501                	sext.w	a0,a0
    1d46:	ed09                	bnez	a0,1d60 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d48:	67a2                	ld	a5,8(sp)
    1d4a:	3e800713          	li	a4,1000
    1d4e:	00015503          	lhu	a0,0(sp)
    1d52:	02e7d7b3          	divu	a5,a5,a4
    1d56:	02e50533          	mul	a0,a0,a4
    1d5a:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d5c:	0141                	addi	sp,sp,16
    1d5e:	8082                	ret
        return -1;
    1d60:	557d                	li	a0,-1
    1d62:	bfed                	j	1d5c <get_time+0x26>

0000000000001d64 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d64:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d68:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d6c:	2501                	sext.w	a0,a0
    1d6e:	8082                	ret

0000000000001d70 <time>:
    register long a7 __asm__("a7") = n;
    1d70:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d74:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d78:	2501                	sext.w	a0,a0
    1d7a:	8082                	ret

0000000000001d7c <sleep>:

int sleep(unsigned long long time)
{
    1d7c:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d7e:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d80:	850a                	mv	a0,sp
    1d82:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d84:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d88:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d8a:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d8e:	e501                	bnez	a0,1d96 <sleep+0x1a>
    return 0;
    1d90:	4501                	li	a0,0
}
    1d92:	0141                	addi	sp,sp,16
    1d94:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d96:	4502                	lw	a0,0(sp)
}
    1d98:	0141                	addi	sp,sp,16
    1d9a:	8082                	ret

0000000000001d9c <set_priority>:
    register long a7 __asm__("a7") = n;
    1d9c:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1da0:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1da4:	2501                	sext.w	a0,a0
    1da6:	8082                	ret

0000000000001da8 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1da8:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1dac:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1db0:	8082                	ret

0000000000001db2 <munmap>:
    register long a7 __asm__("a7") = n;
    1db2:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db6:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1dba:	2501                	sext.w	a0,a0
    1dbc:	8082                	ret

0000000000001dbe <wait>:

int wait(int *code)
{
    1dbe:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dc0:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1dc4:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1dc6:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dc8:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dca:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dce:	2501                	sext.w	a0,a0
    1dd0:	8082                	ret

0000000000001dd2 <spawn>:
    register long a7 __asm__("a7") = n;
    1dd2:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dd6:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dda:	2501                	sext.w	a0,a0
    1ddc:	8082                	ret

0000000000001dde <mailread>:
    register long a7 __asm__("a7") = n;
    1dde:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1de2:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1de6:	2501                	sext.w	a0,a0
    1de8:	8082                	ret

0000000000001dea <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dea:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dee:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1df2:	2501                	sext.w	a0,a0
    1df4:	8082                	ret

0000000000001df6 <fstat>:
    register long a7 __asm__("a7") = n;
    1df6:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dfa:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dfe:	2501                	sext.w	a0,a0
    1e00:	8082                	ret

0000000000001e02 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e02:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e04:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e08:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e0a:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e0e:	2501                	sext.w	a0,a0
    1e10:	8082                	ret

0000000000001e12 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e12:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e14:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e18:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e1a:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e1e:	2501                	sext.w	a0,a0
    1e20:	8082                	ret

0000000000001e22 <link>:

int link(char *old_path, char *new_path)
{
    1e22:	87aa                	mv	a5,a0
    1e24:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e26:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e2a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e2e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e30:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e34:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e36:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e3a:	2501                	sext.w	a0,a0
    1e3c:	8082                	ret

0000000000001e3e <unlink>:

int unlink(char *path)
{
    1e3e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e40:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e44:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e48:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e4a:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e4e:	2501                	sext.w	a0,a0
    1e50:	8082                	ret

0000000000001e52 <uname>:
    register long a7 __asm__("a7") = n;
    1e52:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e56:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e5a:	2501                	sext.w	a0,a0
    1e5c:	8082                	ret

0000000000001e5e <brk>:
    register long a7 __asm__("a7") = n;
    1e5e:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e62:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e66:	2501                	sext.w	a0,a0
    1e68:	8082                	ret

0000000000001e6a <getcwd>:
    register long a7 __asm__("a7") = n;
    1e6a:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e6c:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e70:	8082                	ret

0000000000001e72 <chdir>:
    register long a7 __asm__("a7") = n;
    1e72:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e76:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e7a:	2501                	sext.w	a0,a0
    1e7c:	8082                	ret

0000000000001e7e <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e7e:	862e                	mv	a2,a1
    1e80:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e82:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e84:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e88:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e8c:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e8e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e90:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e94:	2501                	sext.w	a0,a0
    1e96:	8082                	ret

0000000000001e98 <getdents>:
    register long a7 __asm__("a7") = n;
    1e98:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e9c:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ea0:	2501                	sext.w	a0,a0
    1ea2:	8082                	ret

0000000000001ea4 <pipe>:
    register long a7 __asm__("a7") = n;
    1ea4:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ea8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eaa:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1eae:	2501                	sext.w	a0,a0
    1eb0:	8082                	ret

0000000000001eb2 <dup>:
    register long a7 __asm__("a7") = n;
    1eb2:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1eb4:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1eb8:	2501                	sext.w	a0,a0
    1eba:	8082                	ret

0000000000001ebc <dup2>:
    register long a7 __asm__("a7") = n;
    1ebc:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ebe:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ec0:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ec4:	2501                	sext.w	a0,a0
    1ec6:	8082                	ret

0000000000001ec8 <mount>:
    register long a7 __asm__("a7") = n;
    1ec8:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ecc:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ed0:	2501                	sext.w	a0,a0
    1ed2:	8082                	ret

0000000000001ed4 <umount>:
    register long a7 __asm__("a7") = n;
    1ed4:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ed8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eda:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ede:	2501                	sext.w	a0,a0
    1ee0:	8082                	ret

0000000000001ee2 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ee2:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ee4:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ee6:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ee8:	8532                	mv	a0,a2
	mv a2, a4
    1eea:	863a                	mv	a2,a4
	mv a3, a5
    1eec:	86be                	mv	a3,a5
	mv a4, a6
    1eee:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ef0:	0dc00893          	li	a7,220
	ecall
    1ef4:	00000073          	ecall

	beqz a0, 1f
    1ef8:	c111                	beqz	a0,1efc <__clone+0x1a>
	# Parent
	ret
    1efa:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1efc:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1efe:	6522                	ld	a0,8(sp)
	jalr a1
    1f00:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f02:	05d00893          	li	a7,93
	ecall
    1f06:	00000073          	ecall
