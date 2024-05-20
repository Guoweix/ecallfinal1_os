
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/read:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a06d                	j	10ac <__start_main>

0000000000001004 <test_read>:
#include "unistd.h"
#include "stdio.h"
#include "stdlib.h"

void test_read() {
    1004:	712d                	addi	sp,sp,-288
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	eea50513          	addi	a0,a0,-278 # 1ef0 <__clone+0x2c>
void test_read() {
    100e:	ee06                	sd	ra,280(sp)
    1010:	ea22                	sd	s0,272(sp)
	TEST_START(__func__);
    1012:	30c000ef          	jal	131e <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	f6250513          	addi	a0,a0,-158 # 1f78 <__func__.0>
    101e:	300000ef          	jal	131e <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	ee650513          	addi	a0,a0,-282 # 1f08 <__clone+0x44>
    102a:	2f4000ef          	jal	131e <puts>
	int fd = open("./text.txt", 0);
    102e:	4581                	li	a1,0
    1030:	00001517          	auipc	a0,0x1
    1034:	ee850513          	addi	a0,a0,-280 # 1f18 <__clone+0x54>
    1038:	417000ef          	jal	1c4e <open>
	char buf[256];
	int size = read(fd, buf, 256);
    103c:	10000613          	li	a2,256
    1040:	080c                	addi	a1,sp,16
	int fd = open("./text.txt", 0);
    1042:	842a                	mv	s0,a0
	int size = read(fd, buf, 256);
    1044:	43f000ef          	jal	1c82 <read>
    1048:	0005061b          	sext.w	a2,a0
	assert(size >= 0);
    104c:	02064f63          	bltz	a2,108a <test_read+0x86>

	write(STDOUT, buf, size);
    1050:	080c                	addi	a1,sp,16
    1052:	4505                	li	a0,1
    1054:	439000ef          	jal	1c8c <write>
	close(fd);
    1058:	8522                	mv	a0,s0
    105a:	41d000ef          	jal	1c76 <close>
	TEST_END(__func__);
    105e:	00001517          	auipc	a0,0x1
    1062:	eea50513          	addi	a0,a0,-278 # 1f48 <__clone+0x84>
    1066:	2b8000ef          	jal	131e <puts>
    106a:	00001517          	auipc	a0,0x1
    106e:	f0e50513          	addi	a0,a0,-242 # 1f78 <__func__.0>
    1072:	2ac000ef          	jal	131e <puts>
    1076:	00001517          	auipc	a0,0x1
    107a:	e9250513          	addi	a0,a0,-366 # 1f08 <__clone+0x44>
    107e:	2a0000ef          	jal	131e <puts>
}
    1082:	60f2                	ld	ra,280(sp)
    1084:	6452                	ld	s0,272(sp)
    1086:	6115                	addi	sp,sp,288
    1088:	8082                	ret
	assert(size >= 0);
    108a:	00001517          	auipc	a0,0x1
    108e:	e9e50513          	addi	a0,a0,-354 # 1f28 <__clone+0x64>
    1092:	e432                	sd	a2,8(sp)
    1094:	536000ef          	jal	15ca <panic>
    1098:	6622                	ld	a2,8(sp)
    109a:	bf5d                	j	1050 <test_read+0x4c>

000000000000109c <main>:

int main(void) {
    109c:	1141                	addi	sp,sp,-16
    109e:	e406                	sd	ra,8(sp)
	test_read();
    10a0:	f65ff0ef          	jal	1004 <test_read>
	return 0;
}
    10a4:	60a2                	ld	ra,8(sp)
    10a6:	4501                	li	a0,0
    10a8:	0141                	addi	sp,sp,16
    10aa:	8082                	ret

00000000000010ac <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10ac:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10ae:	4108                	lw	a0,0(a0)
{
    10b0:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10b2:	05a1                	addi	a1,a1,8
{
    10b4:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10b6:	fe7ff0ef          	jal	109c <main>
    10ba:	423000ef          	jal	1cdc <exit>
	return 0;
}
    10be:	60a2                	ld	ra,8(sp)
    10c0:	4501                	li	a0,0
    10c2:	0141                	addi	sp,sp,16
    10c4:	8082                	ret

00000000000010c6 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10c6:	7179                	addi	sp,sp,-48
    10c8:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10ca:	12054b63          	bltz	a0,1200 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10ce:	02b577bb          	remuw	a5,a0,a1
    10d2:	00001617          	auipc	a2,0x1
    10d6:	eb660613          	addi	a2,a2,-330 # 1f88 <digits>
    buf[16] = 0;
    10da:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10de:	0005871b          	sext.w	a4,a1
    10e2:	1782                	slli	a5,a5,0x20
    10e4:	9381                	srli	a5,a5,0x20
    10e6:	97b2                	add	a5,a5,a2
    10e8:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10ec:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10f0:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10f4:	1cb56363          	bltu	a0,a1,12ba <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    10f8:	45b9                	li	a1,14
    10fa:	02e877bb          	remuw	a5,a6,a4
    10fe:	1782                	slli	a5,a5,0x20
    1100:	9381                	srli	a5,a5,0x20
    1102:	97b2                	add	a5,a5,a2
    1104:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1108:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    110c:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1110:	0ce86e63          	bltu	a6,a4,11ec <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1114:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1118:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    111c:	1582                	slli	a1,a1,0x20
    111e:	9181                	srli	a1,a1,0x20
    1120:	95b2                	add	a1,a1,a2
    1122:	0005c583          	lbu	a1,0(a1)
    1126:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    112a:	0007859b          	sext.w	a1,a5
    112e:	12e6ec63          	bltu	a3,a4,1266 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1132:	02e7f6bb          	remuw	a3,a5,a4
    1136:	1682                	slli	a3,a3,0x20
    1138:	9281                	srli	a3,a3,0x20
    113a:	96b2                	add	a3,a3,a2
    113c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1140:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1144:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1148:	12e5e863          	bltu	a1,a4,1278 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    114c:	02e876bb          	remuw	a3,a6,a4
    1150:	1682                	slli	a3,a3,0x20
    1152:	9281                	srli	a3,a3,0x20
    1154:	96b2                	add	a3,a3,a2
    1156:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    115a:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    115e:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1162:	12e86463          	bltu	a6,a4,128a <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1166:	02e5f6bb          	remuw	a3,a1,a4
    116a:	1682                	slli	a3,a3,0x20
    116c:	9281                	srli	a3,a3,0x20
    116e:	96b2                	add	a3,a3,a2
    1170:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1174:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1178:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    117c:	0ce5ec63          	bltu	a1,a4,1254 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    1180:	02e876bb          	remuw	a3,a6,a4
    1184:	1682                	slli	a3,a3,0x20
    1186:	9281                	srli	a3,a3,0x20
    1188:	96b2                	add	a3,a3,a2
    118a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    118e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1192:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    1196:	10e86963          	bltu	a6,a4,12a8 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    119a:	02e5f6bb          	remuw	a3,a1,a4
    119e:	1682                	slli	a3,a3,0x20
    11a0:	9281                	srli	a3,a3,0x20
    11a2:	96b2                	add	a3,a3,a2
    11a4:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11a8:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11ac:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11b0:	10e5e763          	bltu	a1,a4,12be <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11b4:	02e876bb          	remuw	a3,a6,a4
    11b8:	1682                	slli	a3,a3,0x20
    11ba:	9281                	srli	a3,a3,0x20
    11bc:	96b2                	add	a3,a3,a2
    11be:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11c2:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11c6:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11ca:	10e86363          	bltu	a6,a4,12d0 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11ce:	1782                	slli	a5,a5,0x20
    11d0:	9381                	srli	a5,a5,0x20
    11d2:	97b2                	add	a5,a5,a2
    11d4:	0007c783          	lbu	a5,0(a5)
    11d8:	4599                	li	a1,6
    11da:	00f10723          	sb	a5,14(sp)

    if (sign)
    11de:	00055763          	bgez	a0,11ec <printint.constprop.0+0x126>
        buf[i--] = '-';
    11e2:	02d00793          	li	a5,45
    11e6:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11ea:	4595                	li	a1,5
    write(f, s, l);
    11ec:	003c                	addi	a5,sp,8
    11ee:	4641                	li	a2,16
    11f0:	9e0d                	subw	a2,a2,a1
    11f2:	4505                	li	a0,1
    11f4:	95be                	add	a1,a1,a5
    11f6:	297000ef          	jal	1c8c <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11fa:	70a2                	ld	ra,40(sp)
    11fc:	6145                	addi	sp,sp,48
    11fe:	8082                	ret
        x = -xx;
    1200:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1204:	02b877bb          	remuw	a5,a6,a1
    1208:	00001617          	auipc	a2,0x1
    120c:	d8060613          	addi	a2,a2,-640 # 1f88 <digits>
    buf[16] = 0;
    1210:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1214:	0005871b          	sext.w	a4,a1
    1218:	1782                	slli	a5,a5,0x20
    121a:	9381                	srli	a5,a5,0x20
    121c:	97b2                	add	a5,a5,a2
    121e:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1222:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1226:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    122a:	06b86963          	bltu	a6,a1,129c <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    122e:	02e8f7bb          	remuw	a5,a7,a4
    1232:	1782                	slli	a5,a5,0x20
    1234:	9381                	srli	a5,a5,0x20
    1236:	97b2                	add	a5,a5,a2
    1238:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    123c:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1240:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1244:	ece8f8e3          	bgeu	a7,a4,1114 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1248:	02d00793          	li	a5,45
    124c:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1250:	45b5                	li	a1,13
    1252:	bf69                	j	11ec <printint.constprop.0+0x126>
    1254:	45a9                	li	a1,10
    if (sign)
    1256:	f8055be3          	bgez	a0,11ec <printint.constprop.0+0x126>
        buf[i--] = '-';
    125a:	02d00793          	li	a5,45
    125e:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1262:	45a5                	li	a1,9
    1264:	b761                	j	11ec <printint.constprop.0+0x126>
    1266:	45b5                	li	a1,13
    if (sign)
    1268:	f80552e3          	bgez	a0,11ec <printint.constprop.0+0x126>
        buf[i--] = '-';
    126c:	02d00793          	li	a5,45
    1270:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1274:	45b1                	li	a1,12
    1276:	bf9d                	j	11ec <printint.constprop.0+0x126>
    1278:	45b1                	li	a1,12
    if (sign)
    127a:	f60559e3          	bgez	a0,11ec <printint.constprop.0+0x126>
        buf[i--] = '-';
    127e:	02d00793          	li	a5,45
    1282:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    1286:	45ad                	li	a1,11
    1288:	b795                	j	11ec <printint.constprop.0+0x126>
    128a:	45ad                	li	a1,11
    if (sign)
    128c:	f60550e3          	bgez	a0,11ec <printint.constprop.0+0x126>
        buf[i--] = '-';
    1290:	02d00793          	li	a5,45
    1294:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    1298:	45a9                	li	a1,10
    129a:	bf89                	j	11ec <printint.constprop.0+0x126>
        buf[i--] = '-';
    129c:	02d00793          	li	a5,45
    12a0:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12a4:	45b9                	li	a1,14
    12a6:	b799                	j	11ec <printint.constprop.0+0x126>
    12a8:	45a5                	li	a1,9
    if (sign)
    12aa:	f40551e3          	bgez	a0,11ec <printint.constprop.0+0x126>
        buf[i--] = '-';
    12ae:	02d00793          	li	a5,45
    12b2:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12b6:	45a1                	li	a1,8
    12b8:	bf15                	j	11ec <printint.constprop.0+0x126>
    i = 15;
    12ba:	45bd                	li	a1,15
    12bc:	bf05                	j	11ec <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12be:	45a1                	li	a1,8
    if (sign)
    12c0:	f20556e3          	bgez	a0,11ec <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c4:	02d00793          	li	a5,45
    12c8:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12cc:	459d                	li	a1,7
    12ce:	bf39                	j	11ec <printint.constprop.0+0x126>
    12d0:	459d                	li	a1,7
    if (sign)
    12d2:	f0055de3          	bgez	a0,11ec <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d6:	02d00793          	li	a5,45
    12da:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12de:	4599                	li	a1,6
    12e0:	b731                	j	11ec <printint.constprop.0+0x126>

00000000000012e2 <getchar>:
{
    12e2:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12e4:	00f10593          	addi	a1,sp,15
    12e8:	4605                	li	a2,1
    12ea:	4501                	li	a0,0
{
    12ec:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12ee:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12f2:	191000ef          	jal	1c82 <read>
}
    12f6:	60e2                	ld	ra,24(sp)
    12f8:	00f14503          	lbu	a0,15(sp)
    12fc:	6105                	addi	sp,sp,32
    12fe:	8082                	ret

0000000000001300 <putchar>:
{
    1300:	1101                	addi	sp,sp,-32
    1302:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1304:	00f10593          	addi	a1,sp,15
    1308:	4605                	li	a2,1
    130a:	4505                	li	a0,1
{
    130c:	ec06                	sd	ra,24(sp)
    char byte = c;
    130e:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1312:	17b000ef          	jal	1c8c <write>
}
    1316:	60e2                	ld	ra,24(sp)
    1318:	2501                	sext.w	a0,a0
    131a:	6105                	addi	sp,sp,32
    131c:	8082                	ret

000000000000131e <puts>:
{
    131e:	1141                	addi	sp,sp,-16
    1320:	e406                	sd	ra,8(sp)
    1322:	e022                	sd	s0,0(sp)
    1324:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1326:	582000ef          	jal	18a8 <strlen>
    132a:	862a                	mv	a2,a0
    132c:	85a2                	mv	a1,s0
    132e:	4505                	li	a0,1
    1330:	15d000ef          	jal	1c8c <write>
}
    1334:	60a2                	ld	ra,8(sp)
    1336:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1338:	957d                	srai	a0,a0,0x3f
    return r;
    133a:	2501                	sext.w	a0,a0
}
    133c:	0141                	addi	sp,sp,16
    133e:	8082                	ret

0000000000001340 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1340:	7131                	addi	sp,sp,-192
    1342:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1344:	013c                	addi	a5,sp,136
{
    1346:	f0ca                	sd	s2,96(sp)
    1348:	ecce                	sd	s3,88(sp)
    134a:	e8d2                	sd	s4,80(sp)
    134c:	e4d6                	sd	s5,72(sp)
    134e:	e0da                	sd	s6,64(sp)
    1350:	fc5e                	sd	s7,56(sp)
    1352:	fc86                	sd	ra,120(sp)
    1354:	f8a2                	sd	s0,112(sp)
    1356:	f4a6                	sd	s1,104(sp)
    1358:	e52e                	sd	a1,136(sp)
    135a:	e932                	sd	a2,144(sp)
    135c:	ed36                	sd	a3,152(sp)
    135e:	f13a                	sd	a4,160(sp)
    1360:	f942                	sd	a6,176(sp)
    1362:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1364:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1366:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    136a:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    136e:	00001b97          	auipc	s7,0x1
    1372:	beab8b93          	addi	s7,s7,-1046 # 1f58 <__clone+0x94>
        switch (s[1])
    1376:	07800a93          	li	s5,120
    137a:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    137e:	00001997          	auipc	s3,0x1
    1382:	c0a98993          	addi	s3,s3,-1014 # 1f88 <digits>
        if (!*s)
    1386:	00054783          	lbu	a5,0(a0)
    138a:	16078c63          	beqz	a5,1502 <printf+0x1c2>
    138e:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1390:	19278463          	beq	a5,s2,1518 <printf+0x1d8>
    1394:	00164783          	lbu	a5,1(a2)
    1398:	0605                	addi	a2,a2,1
    139a:	fbfd                	bnez	a5,1390 <printf+0x50>
    139c:	84b2                	mv	s1,a2
        l = z - a;
    139e:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13a2:	85aa                	mv	a1,a0
    13a4:	8622                	mv	a2,s0
    13a6:	4505                	li	a0,1
    13a8:	0e5000ef          	jal	1c8c <write>
        if (l)
    13ac:	18041f63          	bnez	s0,154a <printf+0x20a>
        if (s[1] == 0)
    13b0:	0014c783          	lbu	a5,1(s1)
    13b4:	14078763          	beqz	a5,1502 <printf+0x1c2>
        switch (s[1])
    13b8:	1d478163          	beq	a5,s4,157a <printf+0x23a>
    13bc:	18fa6963          	bltu	s4,a5,154e <printf+0x20e>
    13c0:	1b678363          	beq	a5,s6,1566 <printf+0x226>
    13c4:	07000713          	li	a4,112
    13c8:	1ce79c63          	bne	a5,a4,15a0 <printf+0x260>
            printptr(va_arg(ap, uint64));
    13cc:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13ce:	03000793          	li	a5,48
    13d2:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13d6:	631c                	ld	a5,0(a4)
    13d8:	0721                	addi	a4,a4,8
    13da:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13dc:	00479f93          	slli	t6,a5,0x4
    13e0:	00879f13          	slli	t5,a5,0x8
    13e4:	00c79e93          	slli	t4,a5,0xc
    13e8:	01079e13          	slli	t3,a5,0x10
    13ec:	01479313          	slli	t1,a5,0x14
    13f0:	01879893          	slli	a7,a5,0x18
    13f4:	01c79713          	slli	a4,a5,0x1c
    13f8:	02479813          	slli	a6,a5,0x24
    13fc:	02879513          	slli	a0,a5,0x28
    1400:	02c79593          	slli	a1,a5,0x2c
    1404:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1408:	03c7d293          	srli	t0,a5,0x3c
    140c:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1410:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1414:	03cfdf93          	srli	t6,t6,0x3c
    1418:	03cf5f13          	srli	t5,t5,0x3c
    141c:	03cede93          	srli	t4,t4,0x3c
    1420:	03ce5e13          	srli	t3,t3,0x3c
    1424:	03c35313          	srli	t1,t1,0x3c
    1428:	03c8d893          	srli	a7,a7,0x3c
    142c:	9371                	srli	a4,a4,0x3c
    142e:	03c85813          	srli	a6,a6,0x3c
    1432:	9171                	srli	a0,a0,0x3c
    1434:	91f1                	srli	a1,a1,0x3c
    1436:	9271                	srli	a2,a2,0x3c
    1438:	974e                	add	a4,a4,s3
    143a:	92f1                	srli	a3,a3,0x3c
    143c:	92ce                	add	t0,t0,s3
    143e:	9fce                	add	t6,t6,s3
    1440:	9f4e                	add	t5,t5,s3
    1442:	9ece                	add	t4,t4,s3
    1444:	9e4e                	add	t3,t3,s3
    1446:	934e                	add	t1,t1,s3
    1448:	98ce                	add	a7,a7,s3
    144a:	93ce                	add	t2,t2,s3
    144c:	984e                	add	a6,a6,s3
    144e:	954e                	add	a0,a0,s3
    1450:	95ce                	add	a1,a1,s3
    1452:	964e                	add	a2,a2,s3
    1454:	0002c283          	lbu	t0,0(t0)
    1458:	000fcf83          	lbu	t6,0(t6)
    145c:	000f4f03          	lbu	t5,0(t5)
    1460:	000ece83          	lbu	t4,0(t4)
    1464:	000e4e03          	lbu	t3,0(t3)
    1468:	00034303          	lbu	t1,0(t1)
    146c:	0008c883          	lbu	a7,0(a7)
    1470:	00074403          	lbu	s0,0(a4)
    1474:	0003c383          	lbu	t2,0(t2)
    1478:	00084803          	lbu	a6,0(a6)
    147c:	00054503          	lbu	a0,0(a0)
    1480:	0005c583          	lbu	a1,0(a1)
    1484:	00064603          	lbu	a2,0(a2)
    1488:	00d98733          	add	a4,s3,a3
    148c:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1490:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1494:	9371                	srli	a4,a4,0x3c
    1496:	8bbd                	andi	a5,a5,15
    1498:	00510523          	sb	t0,10(sp)
    149c:	01f105a3          	sb	t6,11(sp)
    14a0:	01e10623          	sb	t5,12(sp)
    14a4:	01d106a3          	sb	t4,13(sp)
    14a8:	01c10723          	sb	t3,14(sp)
    14ac:	006107a3          	sb	t1,15(sp)
    14b0:	01110823          	sb	a7,16(sp)
    14b4:	00710923          	sb	t2,18(sp)
    14b8:	010109a3          	sb	a6,19(sp)
    14bc:	00a10a23          	sb	a0,20(sp)
    14c0:	00b10aa3          	sb	a1,21(sp)
    14c4:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14c8:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14cc:	008108a3          	sb	s0,17(sp)
    14d0:	974e                	add	a4,a4,s3
    14d2:	97ce                	add	a5,a5,s3
    14d4:	00d10ba3          	sb	a3,23(sp)
    14d8:	00074703          	lbu	a4,0(a4)
    14dc:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14e0:	4649                	li	a2,18
    14e2:	002c                	addi	a1,sp,8
    14e4:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14e6:	00e10c23          	sb	a4,24(sp)
    14ea:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14ee:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14f2:	79a000ef          	jal	1c8c <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14f6:	00248513          	addi	a0,s1,2
        if (!*s)
    14fa:	00054783          	lbu	a5,0(a0)
    14fe:	e80798e3          	bnez	a5,138e <printf+0x4e>
    }
    va_end(ap);
}
    1502:	70e6                	ld	ra,120(sp)
    1504:	7446                	ld	s0,112(sp)
    1506:	74a6                	ld	s1,104(sp)
    1508:	7906                	ld	s2,96(sp)
    150a:	69e6                	ld	s3,88(sp)
    150c:	6a46                	ld	s4,80(sp)
    150e:	6aa6                	ld	s5,72(sp)
    1510:	6b06                	ld	s6,64(sp)
    1512:	7be2                	ld	s7,56(sp)
    1514:	6129                	addi	sp,sp,192
    1516:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1518:	00064783          	lbu	a5,0(a2)
    151c:	84b2                	mv	s1,a2
    151e:	01278963          	beq	a5,s2,1530 <printf+0x1f0>
    1522:	bdb5                	j	139e <printf+0x5e>
    1524:	0024c783          	lbu	a5,2(s1)
    1528:	0605                	addi	a2,a2,1
    152a:	0489                	addi	s1,s1,2
    152c:	e72799e3          	bne	a5,s2,139e <printf+0x5e>
    1530:	0014c783          	lbu	a5,1(s1)
    1534:	ff2788e3          	beq	a5,s2,1524 <printf+0x1e4>
        l = z - a;
    1538:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    153c:	85aa                	mv	a1,a0
    153e:	8622                	mv	a2,s0
    1540:	4505                	li	a0,1
    1542:	74a000ef          	jal	1c8c <write>
        if (l)
    1546:	e60405e3          	beqz	s0,13b0 <printf+0x70>
    154a:	8526                	mv	a0,s1
    154c:	bd2d                	j	1386 <printf+0x46>
        switch (s[1])
    154e:	05579963          	bne	a5,s5,15a0 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1552:	6782                	ld	a5,0(sp)
    1554:	45c1                	li	a1,16
    1556:	4388                	lw	a0,0(a5)
    1558:	07a1                	addi	a5,a5,8
    155a:	e03e                	sd	a5,0(sp)
    155c:	b6bff0ef          	jal	10c6 <printint.constprop.0>
        s += 2;
    1560:	00248513          	addi	a0,s1,2
    1564:	bf59                	j	14fa <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1566:	6782                	ld	a5,0(sp)
    1568:	45a9                	li	a1,10
    156a:	4388                	lw	a0,0(a5)
    156c:	07a1                	addi	a5,a5,8
    156e:	e03e                	sd	a5,0(sp)
    1570:	b57ff0ef          	jal	10c6 <printint.constprop.0>
        s += 2;
    1574:	00248513          	addi	a0,s1,2
    1578:	b749                	j	14fa <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    157a:	6782                	ld	a5,0(sp)
    157c:	6380                	ld	s0,0(a5)
    157e:	07a1                	addi	a5,a5,8
    1580:	e03e                	sd	a5,0(sp)
    1582:	c031                	beqz	s0,15c6 <printf+0x286>
            l = strnlen(a, 200);
    1584:	0c800593          	li	a1,200
    1588:	8522                	mv	a0,s0
    158a:	40a000ef          	jal	1994 <strnlen>
    write(f, s, l);
    158e:	0005061b          	sext.w	a2,a0
    1592:	85a2                	mv	a1,s0
    1594:	4505                	li	a0,1
    1596:	6f6000ef          	jal	1c8c <write>
        s += 2;
    159a:	00248513          	addi	a0,s1,2
    159e:	bfb1                	j	14fa <printf+0x1ba>
    return write(stdout, &byte, 1);
    15a0:	4605                	li	a2,1
    15a2:	002c                	addi	a1,sp,8
    15a4:	4505                	li	a0,1
    char byte = c;
    15a6:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15aa:	6e2000ef          	jal	1c8c <write>
    char byte = c;
    15ae:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15b2:	4605                	li	a2,1
    15b4:	002c                	addi	a1,sp,8
    15b6:	4505                	li	a0,1
    char byte = c;
    15b8:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15bc:	6d0000ef          	jal	1c8c <write>
        s += 2;
    15c0:	00248513          	addi	a0,s1,2
    15c4:	bf1d                	j	14fa <printf+0x1ba>
                a = "(null)";
    15c6:	845e                	mv	s0,s7
    15c8:	bf75                	j	1584 <printf+0x244>

00000000000015ca <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15ca:	1141                	addi	sp,sp,-16
    15cc:	e406                	sd	ra,8(sp)
    puts(m);
    15ce:	d51ff0ef          	jal	131e <puts>
    exit(-100);
}
    15d2:	60a2                	ld	ra,8(sp)
    exit(-100);
    15d4:	f9c00513          	li	a0,-100
}
    15d8:	0141                	addi	sp,sp,16
    exit(-100);
    15da:	a709                	j	1cdc <exit>

00000000000015dc <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15dc:	02000793          	li	a5,32
    15e0:	00f50663          	beq	a0,a5,15ec <isspace+0x10>
    15e4:	355d                	addiw	a0,a0,-9
    15e6:	00553513          	sltiu	a0,a0,5
    15ea:	8082                	ret
    15ec:	4505                	li	a0,1
}
    15ee:	8082                	ret

00000000000015f0 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15f0:	fd05051b          	addiw	a0,a0,-48
}
    15f4:	00a53513          	sltiu	a0,a0,10
    15f8:	8082                	ret

00000000000015fa <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15fa:	02000613          	li	a2,32
    15fe:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1600:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1604:	ff77069b          	addiw	a3,a4,-9
    1608:	04c70d63          	beq	a4,a2,1662 <atoi+0x68>
    160c:	0007079b          	sext.w	a5,a4
    1610:	04d5f963          	bgeu	a1,a3,1662 <atoi+0x68>
        s++;
    switch (*s)
    1614:	02b00693          	li	a3,43
    1618:	04d70a63          	beq	a4,a3,166c <atoi+0x72>
    161c:	02d00693          	li	a3,45
    1620:	06d70463          	beq	a4,a3,1688 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1624:	fd07859b          	addiw	a1,a5,-48
    1628:	4625                	li	a2,9
    162a:	873e                	mv	a4,a5
    162c:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    162e:	4e01                	li	t3,0
    while (isdigit(*s))
    1630:	04b66a63          	bltu	a2,a1,1684 <atoi+0x8a>
    int n = 0, neg = 0;
    1634:	4501                	li	a0,0
    while (isdigit(*s))
    1636:	4825                	li	a6,9
    1638:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    163c:	0025179b          	slliw	a5,a0,0x2
    1640:	9d3d                	addw	a0,a0,a5
    1642:	fd07031b          	addiw	t1,a4,-48
    1646:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    164a:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    164e:	0685                	addi	a3,a3,1
    1650:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1654:	0006071b          	sext.w	a4,a2
    1658:	feb870e3          	bgeu	a6,a1,1638 <atoi+0x3e>
    return neg ? n : -n;
    165c:	000e0563          	beqz	t3,1666 <atoi+0x6c>
}
    1660:	8082                	ret
        s++;
    1662:	0505                	addi	a0,a0,1
    1664:	bf71                	j	1600 <atoi+0x6>
    return neg ? n : -n;
    1666:	4113053b          	subw	a0,t1,a7
    166a:	8082                	ret
    while (isdigit(*s))
    166c:	00154783          	lbu	a5,1(a0)
    1670:	4625                	li	a2,9
        s++;
    1672:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1676:	fd07859b          	addiw	a1,a5,-48
    167a:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    167e:	4e01                	li	t3,0
    while (isdigit(*s))
    1680:	fab67ae3          	bgeu	a2,a1,1634 <atoi+0x3a>
    1684:	4501                	li	a0,0
}
    1686:	8082                	ret
    while (isdigit(*s))
    1688:	00154783          	lbu	a5,1(a0)
    168c:	4625                	li	a2,9
        s++;
    168e:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1692:	fd07859b          	addiw	a1,a5,-48
    1696:	0007871b          	sext.w	a4,a5
    169a:	feb665e3          	bltu	a2,a1,1684 <atoi+0x8a>
        neg = 1;
    169e:	4e05                	li	t3,1
    16a0:	bf51                	j	1634 <atoi+0x3a>

00000000000016a2 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16a2:	16060d63          	beqz	a2,181c <memset+0x17a>
    16a6:	40a007b3          	neg	a5,a0
    16aa:	8b9d                	andi	a5,a5,7
    16ac:	00778713          	addi	a4,a5,7
    16b0:	482d                	li	a6,11
    16b2:	0ff5f593          	zext.b	a1,a1
    16b6:	fff60693          	addi	a3,a2,-1
    16ba:	17076263          	bltu	a4,a6,181e <memset+0x17c>
    16be:	16e6ea63          	bltu	a3,a4,1832 <memset+0x190>
    16c2:	16078563          	beqz	a5,182c <memset+0x18a>
    16c6:	00b50023          	sb	a1,0(a0)
    16ca:	4705                	li	a4,1
    16cc:	00150e93          	addi	t4,a0,1
    16d0:	14e78c63          	beq	a5,a4,1828 <memset+0x186>
    16d4:	00b500a3          	sb	a1,1(a0)
    16d8:	4709                	li	a4,2
    16da:	00250e93          	addi	t4,a0,2
    16de:	14e78d63          	beq	a5,a4,1838 <memset+0x196>
    16e2:	00b50123          	sb	a1,2(a0)
    16e6:	470d                	li	a4,3
    16e8:	00350e93          	addi	t4,a0,3
    16ec:	12e78b63          	beq	a5,a4,1822 <memset+0x180>
    16f0:	00b501a3          	sb	a1,3(a0)
    16f4:	4711                	li	a4,4
    16f6:	00450e93          	addi	t4,a0,4
    16fa:	14e78163          	beq	a5,a4,183c <memset+0x19a>
    16fe:	00b50223          	sb	a1,4(a0)
    1702:	4715                	li	a4,5
    1704:	00550e93          	addi	t4,a0,5
    1708:	12e78c63          	beq	a5,a4,1840 <memset+0x19e>
    170c:	00b502a3          	sb	a1,5(a0)
    1710:	471d                	li	a4,7
    1712:	00650e93          	addi	t4,a0,6
    1716:	12e79763          	bne	a5,a4,1844 <memset+0x1a2>
    171a:	00750e93          	addi	t4,a0,7
    171e:	00b50323          	sb	a1,6(a0)
    1722:	4f1d                	li	t5,7
    1724:	00859713          	slli	a4,a1,0x8
    1728:	8f4d                	or	a4,a4,a1
    172a:	01059e13          	slli	t3,a1,0x10
    172e:	01c76e33          	or	t3,a4,t3
    1732:	01859313          	slli	t1,a1,0x18
    1736:	006e6333          	or	t1,t3,t1
    173a:	02059893          	slli	a7,a1,0x20
    173e:	011368b3          	or	a7,t1,a7
    1742:	02859813          	slli	a6,a1,0x28
    1746:	40f60333          	sub	t1,a2,a5
    174a:	0108e833          	or	a6,a7,a6
    174e:	03059693          	slli	a3,a1,0x30
    1752:	00d866b3          	or	a3,a6,a3
    1756:	03859713          	slli	a4,a1,0x38
    175a:	97aa                	add	a5,a5,a0
    175c:	ff837813          	andi	a6,t1,-8
    1760:	8f55                	or	a4,a4,a3
    1762:	00f806b3          	add	a3,a6,a5
    1766:	e398                	sd	a4,0(a5)
    1768:	07a1                	addi	a5,a5,8
    176a:	fed79ee3          	bne	a5,a3,1766 <memset+0xc4>
    176e:	ff837693          	andi	a3,t1,-8
    1772:	00de87b3          	add	a5,t4,a3
    1776:	01e6873b          	addw	a4,a3,t5
    177a:	0ad30663          	beq	t1,a3,1826 <memset+0x184>
    177e:	00b78023          	sb	a1,0(a5)
    1782:	0017069b          	addiw	a3,a4,1
    1786:	08c6fb63          	bgeu	a3,a2,181c <memset+0x17a>
    178a:	00b780a3          	sb	a1,1(a5)
    178e:	0027069b          	addiw	a3,a4,2
    1792:	08c6f563          	bgeu	a3,a2,181c <memset+0x17a>
    1796:	00b78123          	sb	a1,2(a5)
    179a:	0037069b          	addiw	a3,a4,3
    179e:	06c6ff63          	bgeu	a3,a2,181c <memset+0x17a>
    17a2:	00b781a3          	sb	a1,3(a5)
    17a6:	0047069b          	addiw	a3,a4,4
    17aa:	06c6f963          	bgeu	a3,a2,181c <memset+0x17a>
    17ae:	00b78223          	sb	a1,4(a5)
    17b2:	0057069b          	addiw	a3,a4,5
    17b6:	06c6f363          	bgeu	a3,a2,181c <memset+0x17a>
    17ba:	00b782a3          	sb	a1,5(a5)
    17be:	0067069b          	addiw	a3,a4,6
    17c2:	04c6fd63          	bgeu	a3,a2,181c <memset+0x17a>
    17c6:	00b78323          	sb	a1,6(a5)
    17ca:	0077069b          	addiw	a3,a4,7
    17ce:	04c6f763          	bgeu	a3,a2,181c <memset+0x17a>
    17d2:	00b783a3          	sb	a1,7(a5)
    17d6:	0087069b          	addiw	a3,a4,8
    17da:	04c6f163          	bgeu	a3,a2,181c <memset+0x17a>
    17de:	00b78423          	sb	a1,8(a5)
    17e2:	0097069b          	addiw	a3,a4,9
    17e6:	02c6fb63          	bgeu	a3,a2,181c <memset+0x17a>
    17ea:	00b784a3          	sb	a1,9(a5)
    17ee:	00a7069b          	addiw	a3,a4,10
    17f2:	02c6f563          	bgeu	a3,a2,181c <memset+0x17a>
    17f6:	00b78523          	sb	a1,10(a5)
    17fa:	00b7069b          	addiw	a3,a4,11
    17fe:	00c6ff63          	bgeu	a3,a2,181c <memset+0x17a>
    1802:	00b785a3          	sb	a1,11(a5)
    1806:	00c7069b          	addiw	a3,a4,12
    180a:	00c6f963          	bgeu	a3,a2,181c <memset+0x17a>
    180e:	00b78623          	sb	a1,12(a5)
    1812:	2735                	addiw	a4,a4,13
    1814:	00c77463          	bgeu	a4,a2,181c <memset+0x17a>
    1818:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    181c:	8082                	ret
    181e:	472d                	li	a4,11
    1820:	bd79                	j	16be <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1822:	4f0d                	li	t5,3
    1824:	b701                	j	1724 <memset+0x82>
    1826:	8082                	ret
    1828:	4f05                	li	t5,1
    182a:	bded                	j	1724 <memset+0x82>
    182c:	8eaa                	mv	t4,a0
    182e:	4f01                	li	t5,0
    1830:	bdd5                	j	1724 <memset+0x82>
    1832:	87aa                	mv	a5,a0
    1834:	4701                	li	a4,0
    1836:	b7a1                	j	177e <memset+0xdc>
    1838:	4f09                	li	t5,2
    183a:	b5ed                	j	1724 <memset+0x82>
    183c:	4f11                	li	t5,4
    183e:	b5dd                	j	1724 <memset+0x82>
    1840:	4f15                	li	t5,5
    1842:	b5cd                	j	1724 <memset+0x82>
    1844:	4f19                	li	t5,6
    1846:	bdf9                	j	1724 <memset+0x82>

0000000000001848 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1848:	00054783          	lbu	a5,0(a0)
    184c:	0005c703          	lbu	a4,0(a1)
    1850:	00e79863          	bne	a5,a4,1860 <strcmp+0x18>
    1854:	0505                	addi	a0,a0,1
    1856:	0585                	addi	a1,a1,1
    1858:	fbe5                	bnez	a5,1848 <strcmp>
    185a:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    185c:	9d19                	subw	a0,a0,a4
    185e:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1860:	0007851b          	sext.w	a0,a5
    1864:	bfe5                	j	185c <strcmp+0x14>

0000000000001866 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1866:	ce05                	beqz	a2,189e <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1868:	00054703          	lbu	a4,0(a0)
    186c:	0005c783          	lbu	a5,0(a1)
    1870:	cb0d                	beqz	a4,18a2 <strncmp+0x3c>
    if (!n--)
    1872:	167d                	addi	a2,a2,-1
    1874:	00c506b3          	add	a3,a0,a2
    1878:	a819                	j	188e <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    187a:	00a68e63          	beq	a3,a0,1896 <strncmp+0x30>
    187e:	0505                	addi	a0,a0,1
    1880:	00e79b63          	bne	a5,a4,1896 <strncmp+0x30>
    1884:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    1888:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    188c:	cb19                	beqz	a4,18a2 <strncmp+0x3c>
    188e:	0005c783          	lbu	a5,0(a1)
    1892:	0585                	addi	a1,a1,1
    1894:	f3fd                	bnez	a5,187a <strncmp+0x14>
    return *l - *r;
    1896:	0007051b          	sext.w	a0,a4
    189a:	9d1d                	subw	a0,a0,a5
    189c:	8082                	ret
        return 0;
    189e:	4501                	li	a0,0
}
    18a0:	8082                	ret
    18a2:	4501                	li	a0,0
    return *l - *r;
    18a4:	9d1d                	subw	a0,a0,a5
    18a6:	8082                	ret

00000000000018a8 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18a8:	00757793          	andi	a5,a0,7
    18ac:	cf89                	beqz	a5,18c6 <strlen+0x1e>
    18ae:	87aa                	mv	a5,a0
    18b0:	a029                	j	18ba <strlen+0x12>
    18b2:	0785                	addi	a5,a5,1
    18b4:	0077f713          	andi	a4,a5,7
    18b8:	cb01                	beqz	a4,18c8 <strlen+0x20>
        if (!*s)
    18ba:	0007c703          	lbu	a4,0(a5)
    18be:	fb75                	bnez	a4,18b2 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18c0:	40a78533          	sub	a0,a5,a0
}
    18c4:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18c6:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18c8:	6394                	ld	a3,0(a5)
    18ca:	00000597          	auipc	a1,0x0
    18ce:	6965b583          	ld	a1,1686(a1) # 1f60 <__clone+0x9c>
    18d2:	00000617          	auipc	a2,0x0
    18d6:	69663603          	ld	a2,1686(a2) # 1f68 <__clone+0xa4>
    18da:	a019                	j	18e0 <strlen+0x38>
    18dc:	6794                	ld	a3,8(a5)
    18de:	07a1                	addi	a5,a5,8
    18e0:	00b68733          	add	a4,a3,a1
    18e4:	fff6c693          	not	a3,a3
    18e8:	8f75                	and	a4,a4,a3
    18ea:	8f71                	and	a4,a4,a2
    18ec:	db65                	beqz	a4,18dc <strlen+0x34>
    for (; *s; s++)
    18ee:	0007c703          	lbu	a4,0(a5)
    18f2:	d779                	beqz	a4,18c0 <strlen+0x18>
    18f4:	0017c703          	lbu	a4,1(a5)
    18f8:	0785                	addi	a5,a5,1
    18fa:	d379                	beqz	a4,18c0 <strlen+0x18>
    18fc:	0017c703          	lbu	a4,1(a5)
    1900:	0785                	addi	a5,a5,1
    1902:	fb6d                	bnez	a4,18f4 <strlen+0x4c>
    1904:	bf75                	j	18c0 <strlen+0x18>

0000000000001906 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1906:	00757713          	andi	a4,a0,7
{
    190a:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    190c:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1910:	cb19                	beqz	a4,1926 <memchr+0x20>
    1912:	ce25                	beqz	a2,198a <memchr+0x84>
    1914:	0007c703          	lbu	a4,0(a5)
    1918:	04b70e63          	beq	a4,a1,1974 <memchr+0x6e>
    191c:	0785                	addi	a5,a5,1
    191e:	0077f713          	andi	a4,a5,7
    1922:	167d                	addi	a2,a2,-1
    1924:	f77d                	bnez	a4,1912 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1926:	4501                	li	a0,0
    if (n && *s != c)
    1928:	c235                	beqz	a2,198c <memchr+0x86>
    192a:	0007c703          	lbu	a4,0(a5)
    192e:	04b70363          	beq	a4,a1,1974 <memchr+0x6e>
        size_t k = ONES * c;
    1932:	00000517          	auipc	a0,0x0
    1936:	63e53503          	ld	a0,1598(a0) # 1f70 <__clone+0xac>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    193a:	471d                	li	a4,7
        size_t k = ONES * c;
    193c:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1940:	02c77a63          	bgeu	a4,a2,1974 <memchr+0x6e>
    1944:	00000897          	auipc	a7,0x0
    1948:	61c8b883          	ld	a7,1564(a7) # 1f60 <__clone+0x9c>
    194c:	00000817          	auipc	a6,0x0
    1950:	61c83803          	ld	a6,1564(a6) # 1f68 <__clone+0xa4>
    1954:	431d                	li	t1,7
    1956:	a029                	j	1960 <memchr+0x5a>
    1958:	1661                	addi	a2,a2,-8
    195a:	07a1                	addi	a5,a5,8
    195c:	02c37963          	bgeu	t1,a2,198e <memchr+0x88>
    1960:	6398                	ld	a4,0(a5)
    1962:	8f29                	xor	a4,a4,a0
    1964:	011706b3          	add	a3,a4,a7
    1968:	fff74713          	not	a4,a4
    196c:	8f75                	and	a4,a4,a3
    196e:	01077733          	and	a4,a4,a6
    1972:	d37d                	beqz	a4,1958 <memchr+0x52>
    1974:	853e                	mv	a0,a5
    1976:	97b2                	add	a5,a5,a2
    1978:	a021                	j	1980 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    197a:	0505                	addi	a0,a0,1
    197c:	00f50763          	beq	a0,a5,198a <memchr+0x84>
    1980:	00054703          	lbu	a4,0(a0)
    1984:	feb71be3          	bne	a4,a1,197a <memchr+0x74>
    1988:	8082                	ret
    return n ? (void *)s : 0;
    198a:	4501                	li	a0,0
}
    198c:	8082                	ret
    return n ? (void *)s : 0;
    198e:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1990:	f275                	bnez	a2,1974 <memchr+0x6e>
}
    1992:	8082                	ret

0000000000001994 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1994:	1101                	addi	sp,sp,-32
    1996:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1998:	862e                	mv	a2,a1
{
    199a:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    199c:	4581                	li	a1,0
{
    199e:	e426                	sd	s1,8(sp)
    19a0:	ec06                	sd	ra,24(sp)
    19a2:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19a4:	f63ff0ef          	jal	1906 <memchr>
    return p ? p - s : n;
    19a8:	c519                	beqz	a0,19b6 <strnlen+0x22>
}
    19aa:	60e2                	ld	ra,24(sp)
    19ac:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19ae:	8d05                	sub	a0,a0,s1
}
    19b0:	64a2                	ld	s1,8(sp)
    19b2:	6105                	addi	sp,sp,32
    19b4:	8082                	ret
    19b6:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19b8:	8522                	mv	a0,s0
}
    19ba:	6442                	ld	s0,16(sp)
    19bc:	64a2                	ld	s1,8(sp)
    19be:	6105                	addi	sp,sp,32
    19c0:	8082                	ret

00000000000019c2 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19c2:	00b547b3          	xor	a5,a0,a1
    19c6:	8b9d                	andi	a5,a5,7
    19c8:	eb95                	bnez	a5,19fc <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19ca:	0075f793          	andi	a5,a1,7
    19ce:	e7b1                	bnez	a5,1a1a <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19d0:	6198                	ld	a4,0(a1)
    19d2:	00000617          	auipc	a2,0x0
    19d6:	58e63603          	ld	a2,1422(a2) # 1f60 <__clone+0x9c>
    19da:	00000817          	auipc	a6,0x0
    19de:	58e83803          	ld	a6,1422(a6) # 1f68 <__clone+0xa4>
    19e2:	a029                	j	19ec <strcpy+0x2a>
    19e4:	e118                	sd	a4,0(a0)
    19e6:	6598                	ld	a4,8(a1)
    19e8:	05a1                	addi	a1,a1,8
    19ea:	0521                	addi	a0,a0,8
    19ec:	00c707b3          	add	a5,a4,a2
    19f0:	fff74693          	not	a3,a4
    19f4:	8ff5                	and	a5,a5,a3
    19f6:	0107f7b3          	and	a5,a5,a6
    19fa:	d7ed                	beqz	a5,19e4 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19fc:	0005c783          	lbu	a5,0(a1)
    1a00:	00f50023          	sb	a5,0(a0)
    1a04:	c785                	beqz	a5,1a2c <strcpy+0x6a>
    1a06:	0015c783          	lbu	a5,1(a1)
    1a0a:	0505                	addi	a0,a0,1
    1a0c:	0585                	addi	a1,a1,1
    1a0e:	00f50023          	sb	a5,0(a0)
    1a12:	fbf5                	bnez	a5,1a06 <strcpy+0x44>
        ;
    return d;
}
    1a14:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a16:	0505                	addi	a0,a0,1
    1a18:	df45                	beqz	a4,19d0 <strcpy+0xe>
            if (!(*d = *s))
    1a1a:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a1e:	0585                	addi	a1,a1,1
    1a20:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a24:	00f50023          	sb	a5,0(a0)
    1a28:	f7fd                	bnez	a5,1a16 <strcpy+0x54>
}
    1a2a:	8082                	ret
    1a2c:	8082                	ret

0000000000001a2e <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a2e:	00b547b3          	xor	a5,a0,a1
    1a32:	8b9d                	andi	a5,a5,7
    1a34:	1a079863          	bnez	a5,1be4 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a38:	0075f793          	andi	a5,a1,7
    1a3c:	16078463          	beqz	a5,1ba4 <strncpy+0x176>
    1a40:	ea01                	bnez	a2,1a50 <strncpy+0x22>
    1a42:	a421                	j	1c4a <strncpy+0x21c>
    1a44:	167d                	addi	a2,a2,-1
    1a46:	0505                	addi	a0,a0,1
    1a48:	14070e63          	beqz	a4,1ba4 <strncpy+0x176>
    1a4c:	1a060863          	beqz	a2,1bfc <strncpy+0x1ce>
    1a50:	0005c783          	lbu	a5,0(a1)
    1a54:	0585                	addi	a1,a1,1
    1a56:	0075f713          	andi	a4,a1,7
    1a5a:	00f50023          	sb	a5,0(a0)
    1a5e:	f3fd                	bnez	a5,1a44 <strncpy+0x16>
    1a60:	4805                	li	a6,1
    1a62:	1a061863          	bnez	a2,1c12 <strncpy+0x1e4>
    1a66:	40a007b3          	neg	a5,a0
    1a6a:	8b9d                	andi	a5,a5,7
    1a6c:	4681                	li	a3,0
    1a6e:	18061a63          	bnez	a2,1c02 <strncpy+0x1d4>
    1a72:	00778713          	addi	a4,a5,7
    1a76:	45ad                	li	a1,11
    1a78:	18b76363          	bltu	a4,a1,1bfe <strncpy+0x1d0>
    1a7c:	1ae6eb63          	bltu	a3,a4,1c32 <strncpy+0x204>
    1a80:	1a078363          	beqz	a5,1c26 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a84:	00050023          	sb	zero,0(a0)
    1a88:	4685                	li	a3,1
    1a8a:	00150713          	addi	a4,a0,1
    1a8e:	18d78f63          	beq	a5,a3,1c2c <strncpy+0x1fe>
    1a92:	000500a3          	sb	zero,1(a0)
    1a96:	4689                	li	a3,2
    1a98:	00250713          	addi	a4,a0,2
    1a9c:	18d78e63          	beq	a5,a3,1c38 <strncpy+0x20a>
    1aa0:	00050123          	sb	zero,2(a0)
    1aa4:	468d                	li	a3,3
    1aa6:	00350713          	addi	a4,a0,3
    1aaa:	16d78c63          	beq	a5,a3,1c22 <strncpy+0x1f4>
    1aae:	000501a3          	sb	zero,3(a0)
    1ab2:	4691                	li	a3,4
    1ab4:	00450713          	addi	a4,a0,4
    1ab8:	18d78263          	beq	a5,a3,1c3c <strncpy+0x20e>
    1abc:	00050223          	sb	zero,4(a0)
    1ac0:	4695                	li	a3,5
    1ac2:	00550713          	addi	a4,a0,5
    1ac6:	16d78d63          	beq	a5,a3,1c40 <strncpy+0x212>
    1aca:	000502a3          	sb	zero,5(a0)
    1ace:	469d                	li	a3,7
    1ad0:	00650713          	addi	a4,a0,6
    1ad4:	16d79863          	bne	a5,a3,1c44 <strncpy+0x216>
    1ad8:	00750713          	addi	a4,a0,7
    1adc:	00050323          	sb	zero,6(a0)
    1ae0:	40f80833          	sub	a6,a6,a5
    1ae4:	ff887593          	andi	a1,a6,-8
    1ae8:	97aa                	add	a5,a5,a0
    1aea:	95be                	add	a1,a1,a5
    1aec:	0007b023          	sd	zero,0(a5)
    1af0:	07a1                	addi	a5,a5,8
    1af2:	feb79de3          	bne	a5,a1,1aec <strncpy+0xbe>
    1af6:	ff887593          	andi	a1,a6,-8
    1afa:	9ead                	addw	a3,a3,a1
    1afc:	00b707b3          	add	a5,a4,a1
    1b00:	12b80863          	beq	a6,a1,1c30 <strncpy+0x202>
    1b04:	00078023          	sb	zero,0(a5)
    1b08:	0016871b          	addiw	a4,a3,1
    1b0c:	0ec77863          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b10:	000780a3          	sb	zero,1(a5)
    1b14:	0026871b          	addiw	a4,a3,2
    1b18:	0ec77263          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b1c:	00078123          	sb	zero,2(a5)
    1b20:	0036871b          	addiw	a4,a3,3
    1b24:	0cc77c63          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b28:	000781a3          	sb	zero,3(a5)
    1b2c:	0046871b          	addiw	a4,a3,4
    1b30:	0cc77663          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b34:	00078223          	sb	zero,4(a5)
    1b38:	0056871b          	addiw	a4,a3,5
    1b3c:	0cc77063          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b40:	000782a3          	sb	zero,5(a5)
    1b44:	0066871b          	addiw	a4,a3,6
    1b48:	0ac77a63          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b4c:	00078323          	sb	zero,6(a5)
    1b50:	0076871b          	addiw	a4,a3,7
    1b54:	0ac77463          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b58:	000783a3          	sb	zero,7(a5)
    1b5c:	0086871b          	addiw	a4,a3,8
    1b60:	08c77e63          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b64:	00078423          	sb	zero,8(a5)
    1b68:	0096871b          	addiw	a4,a3,9
    1b6c:	08c77863          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b70:	000784a3          	sb	zero,9(a5)
    1b74:	00a6871b          	addiw	a4,a3,10
    1b78:	08c77263          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b7c:	00078523          	sb	zero,10(a5)
    1b80:	00b6871b          	addiw	a4,a3,11
    1b84:	06c77c63          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b88:	000785a3          	sb	zero,11(a5)
    1b8c:	00c6871b          	addiw	a4,a3,12
    1b90:	06c77663          	bgeu	a4,a2,1bfc <strncpy+0x1ce>
    1b94:	00078623          	sb	zero,12(a5)
    1b98:	26b5                	addiw	a3,a3,13
    1b9a:	06c6f163          	bgeu	a3,a2,1bfc <strncpy+0x1ce>
    1b9e:	000786a3          	sb	zero,13(a5)
    1ba2:	8082                	ret
            ;
        if (!n || !*s)
    1ba4:	c645                	beqz	a2,1c4c <strncpy+0x21e>
    1ba6:	0005c783          	lbu	a5,0(a1)
    1baa:	ea078be3          	beqz	a5,1a60 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bae:	479d                	li	a5,7
    1bb0:	02c7ff63          	bgeu	a5,a2,1bee <strncpy+0x1c0>
    1bb4:	00000897          	auipc	a7,0x0
    1bb8:	3ac8b883          	ld	a7,940(a7) # 1f60 <__clone+0x9c>
    1bbc:	00000817          	auipc	a6,0x0
    1bc0:	3ac83803          	ld	a6,940(a6) # 1f68 <__clone+0xa4>
    1bc4:	431d                	li	t1,7
    1bc6:	6198                	ld	a4,0(a1)
    1bc8:	011707b3          	add	a5,a4,a7
    1bcc:	fff74693          	not	a3,a4
    1bd0:	8ff5                	and	a5,a5,a3
    1bd2:	0107f7b3          	and	a5,a5,a6
    1bd6:	ef81                	bnez	a5,1bee <strncpy+0x1c0>
            *wd = *ws;
    1bd8:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bda:	1661                	addi	a2,a2,-8
    1bdc:	05a1                	addi	a1,a1,8
    1bde:	0521                	addi	a0,a0,8
    1be0:	fec363e3          	bltu	t1,a2,1bc6 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1be4:	e609                	bnez	a2,1bee <strncpy+0x1c0>
    1be6:	a08d                	j	1c48 <strncpy+0x21a>
    1be8:	167d                	addi	a2,a2,-1
    1bea:	0505                	addi	a0,a0,1
    1bec:	ca01                	beqz	a2,1bfc <strncpy+0x1ce>
    1bee:	0005c783          	lbu	a5,0(a1)
    1bf2:	0585                	addi	a1,a1,1
    1bf4:	00f50023          	sb	a5,0(a0)
    1bf8:	fbe5                	bnez	a5,1be8 <strncpy+0x1ba>
        ;
tail:
    1bfa:	b59d                	j	1a60 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bfc:	8082                	ret
    1bfe:	472d                	li	a4,11
    1c00:	bdb5                	j	1a7c <strncpy+0x4e>
    1c02:	00778713          	addi	a4,a5,7
    1c06:	45ad                	li	a1,11
    1c08:	fff60693          	addi	a3,a2,-1
    1c0c:	e6b778e3          	bgeu	a4,a1,1a7c <strncpy+0x4e>
    1c10:	b7fd                	j	1bfe <strncpy+0x1d0>
    1c12:	40a007b3          	neg	a5,a0
    1c16:	8832                	mv	a6,a2
    1c18:	8b9d                	andi	a5,a5,7
    1c1a:	4681                	li	a3,0
    1c1c:	e4060be3          	beqz	a2,1a72 <strncpy+0x44>
    1c20:	b7cd                	j	1c02 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c22:	468d                	li	a3,3
    1c24:	bd75                	j	1ae0 <strncpy+0xb2>
    1c26:	872a                	mv	a4,a0
    1c28:	4681                	li	a3,0
    1c2a:	bd5d                	j	1ae0 <strncpy+0xb2>
    1c2c:	4685                	li	a3,1
    1c2e:	bd4d                	j	1ae0 <strncpy+0xb2>
    1c30:	8082                	ret
    1c32:	87aa                	mv	a5,a0
    1c34:	4681                	li	a3,0
    1c36:	b5f9                	j	1b04 <strncpy+0xd6>
    1c38:	4689                	li	a3,2
    1c3a:	b55d                	j	1ae0 <strncpy+0xb2>
    1c3c:	4691                	li	a3,4
    1c3e:	b54d                	j	1ae0 <strncpy+0xb2>
    1c40:	4695                	li	a3,5
    1c42:	bd79                	j	1ae0 <strncpy+0xb2>
    1c44:	4699                	li	a3,6
    1c46:	bd69                	j	1ae0 <strncpy+0xb2>
    1c48:	8082                	ret
    1c4a:	8082                	ret
    1c4c:	8082                	ret

0000000000001c4e <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c4e:	87aa                	mv	a5,a0
    1c50:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c52:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c56:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c5a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c5c:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c5e:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c62:	2501                	sext.w	a0,a0
    1c64:	8082                	ret

0000000000001c66 <openat>:
    register long a7 __asm__("a7") = n;
    1c66:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c6a:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c6e:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c72:	2501                	sext.w	a0,a0
    1c74:	8082                	ret

0000000000001c76 <close>:
    register long a7 __asm__("a7") = n;
    1c76:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c7a:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c7e:	2501                	sext.w	a0,a0
    1c80:	8082                	ret

0000000000001c82 <read>:
    register long a7 __asm__("a7") = n;
    1c82:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c86:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c8a:	8082                	ret

0000000000001c8c <write>:
    register long a7 __asm__("a7") = n;
    1c8c:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c90:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c94:	8082                	ret

0000000000001c96 <getpid>:
    register long a7 __asm__("a7") = n;
    1c96:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c9a:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c9e:	2501                	sext.w	a0,a0
    1ca0:	8082                	ret

0000000000001ca2 <getppid>:
    register long a7 __asm__("a7") = n;
    1ca2:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1ca6:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1caa:	2501                	sext.w	a0,a0
    1cac:	8082                	ret

0000000000001cae <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cae:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cb2:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cb6:	2501                	sext.w	a0,a0
    1cb8:	8082                	ret

0000000000001cba <fork>:
    register long a7 __asm__("a7") = n;
    1cba:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cbe:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cc0:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cc2:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cc6:	2501                	sext.w	a0,a0
    1cc8:	8082                	ret

0000000000001cca <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cca:	85b2                	mv	a1,a2
    1ccc:	863a                	mv	a2,a4
    if (stack)
    1cce:	c191                	beqz	a1,1cd2 <clone+0x8>
	stack += stack_size;
    1cd0:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cd2:	4781                	li	a5,0
    1cd4:	4701                	li	a4,0
    1cd6:	4681                	li	a3,0
    1cd8:	2601                	sext.w	a2,a2
    1cda:	a2ed                	j	1ec4 <__clone>

0000000000001cdc <exit>:
    register long a7 __asm__("a7") = n;
    1cdc:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1ce0:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1ce4:	8082                	ret

0000000000001ce6 <waitpid>:
    register long a7 __asm__("a7") = n;
    1ce6:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cea:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cec:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cf0:	2501                	sext.w	a0,a0
    1cf2:	8082                	ret

0000000000001cf4 <exec>:
    register long a7 __asm__("a7") = n;
    1cf4:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cf8:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cfc:	2501                	sext.w	a0,a0
    1cfe:	8082                	ret

0000000000001d00 <execve>:
    register long a7 __asm__("a7") = n;
    1d00:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d04:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d08:	2501                	sext.w	a0,a0
    1d0a:	8082                	ret

0000000000001d0c <times>:
    register long a7 __asm__("a7") = n;
    1d0c:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d10:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d14:	2501                	sext.w	a0,a0
    1d16:	8082                	ret

0000000000001d18 <get_time>:

int64 get_time()
{
    1d18:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d1a:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d1e:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d20:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d22:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d26:	2501                	sext.w	a0,a0
    1d28:	ed09                	bnez	a0,1d42 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d2a:	67a2                	ld	a5,8(sp)
    1d2c:	3e800713          	li	a4,1000
    1d30:	00015503          	lhu	a0,0(sp)
    1d34:	02e7d7b3          	divu	a5,a5,a4
    1d38:	02e50533          	mul	a0,a0,a4
    1d3c:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d3e:	0141                	addi	sp,sp,16
    1d40:	8082                	ret
        return -1;
    1d42:	557d                	li	a0,-1
    1d44:	bfed                	j	1d3e <get_time+0x26>

0000000000001d46 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d46:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d4a:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d4e:	2501                	sext.w	a0,a0
    1d50:	8082                	ret

0000000000001d52 <time>:
    register long a7 __asm__("a7") = n;
    1d52:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d56:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d5a:	2501                	sext.w	a0,a0
    1d5c:	8082                	ret

0000000000001d5e <sleep>:

int sleep(unsigned long long time)
{
    1d5e:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d60:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d62:	850a                	mv	a0,sp
    1d64:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d66:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d6a:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d6c:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d70:	e501                	bnez	a0,1d78 <sleep+0x1a>
    return 0;
    1d72:	4501                	li	a0,0
}
    1d74:	0141                	addi	sp,sp,16
    1d76:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d78:	4502                	lw	a0,0(sp)
}
    1d7a:	0141                	addi	sp,sp,16
    1d7c:	8082                	ret

0000000000001d7e <set_priority>:
    register long a7 __asm__("a7") = n;
    1d7e:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d82:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d86:	2501                	sext.w	a0,a0
    1d88:	8082                	ret

0000000000001d8a <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d8a:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d8e:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d92:	8082                	ret

0000000000001d94 <munmap>:
    register long a7 __asm__("a7") = n;
    1d94:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d98:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d9c:	2501                	sext.w	a0,a0
    1d9e:	8082                	ret

0000000000001da0 <wait>:

int wait(int *code)
{
    1da0:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1da2:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1da6:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1da8:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1daa:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dac:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1db0:	2501                	sext.w	a0,a0
    1db2:	8082                	ret

0000000000001db4 <spawn>:
    register long a7 __asm__("a7") = n;
    1db4:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1db8:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dbc:	2501                	sext.w	a0,a0
    1dbe:	8082                	ret

0000000000001dc0 <mailread>:
    register long a7 __asm__("a7") = n;
    1dc0:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dc4:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dc8:	2501                	sext.w	a0,a0
    1dca:	8082                	ret

0000000000001dcc <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dcc:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dd0:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dd4:	2501                	sext.w	a0,a0
    1dd6:	8082                	ret

0000000000001dd8 <fstat>:
    register long a7 __asm__("a7") = n;
    1dd8:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ddc:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1de0:	2501                	sext.w	a0,a0
    1de2:	8082                	ret

0000000000001de4 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1de4:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1de6:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dea:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dec:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1df0:	2501                	sext.w	a0,a0
    1df2:	8082                	ret

0000000000001df4 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1df4:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1df6:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1dfa:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dfc:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e00:	2501                	sext.w	a0,a0
    1e02:	8082                	ret

0000000000001e04 <link>:

int link(char *old_path, char *new_path)
{
    1e04:	87aa                	mv	a5,a0
    1e06:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e08:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e0c:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e10:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e12:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e16:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e18:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e1c:	2501                	sext.w	a0,a0
    1e1e:	8082                	ret

0000000000001e20 <unlink>:

int unlink(char *path)
{
    1e20:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e22:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e26:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e2a:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e2c:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e30:	2501                	sext.w	a0,a0
    1e32:	8082                	ret

0000000000001e34 <uname>:
    register long a7 __asm__("a7") = n;
    1e34:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e38:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e3c:	2501                	sext.w	a0,a0
    1e3e:	8082                	ret

0000000000001e40 <brk>:
    register long a7 __asm__("a7") = n;
    1e40:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e44:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e48:	2501                	sext.w	a0,a0
    1e4a:	8082                	ret

0000000000001e4c <getcwd>:
    register long a7 __asm__("a7") = n;
    1e4c:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e4e:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e52:	8082                	ret

0000000000001e54 <chdir>:
    register long a7 __asm__("a7") = n;
    1e54:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e58:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e5c:	2501                	sext.w	a0,a0
    1e5e:	8082                	ret

0000000000001e60 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e60:	862e                	mv	a2,a1
    1e62:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e64:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e66:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e6a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e6e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e70:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e72:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e76:	2501                	sext.w	a0,a0
    1e78:	8082                	ret

0000000000001e7a <getdents>:
    register long a7 __asm__("a7") = n;
    1e7a:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e7e:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e82:	2501                	sext.w	a0,a0
    1e84:	8082                	ret

0000000000001e86 <pipe>:
    register long a7 __asm__("a7") = n;
    1e86:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e8a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e8c:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e90:	2501                	sext.w	a0,a0
    1e92:	8082                	ret

0000000000001e94 <dup>:
    register long a7 __asm__("a7") = n;
    1e94:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e96:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e9a:	2501                	sext.w	a0,a0
    1e9c:	8082                	ret

0000000000001e9e <dup2>:
    register long a7 __asm__("a7") = n;
    1e9e:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ea0:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ea2:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ea6:	2501                	sext.w	a0,a0
    1ea8:	8082                	ret

0000000000001eaa <mount>:
    register long a7 __asm__("a7") = n;
    1eaa:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1eae:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1eb2:	2501                	sext.w	a0,a0
    1eb4:	8082                	ret

0000000000001eb6 <umount>:
    register long a7 __asm__("a7") = n;
    1eb6:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1eba:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ebc:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ec0:	2501                	sext.w	a0,a0
    1ec2:	8082                	ret

0000000000001ec4 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ec4:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ec6:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ec8:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1eca:	8532                	mv	a0,a2
	mv a2, a4
    1ecc:	863a                	mv	a2,a4
	mv a3, a5
    1ece:	86be                	mv	a3,a5
	mv a4, a6
    1ed0:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ed2:	0dc00893          	li	a7,220
	ecall
    1ed6:	00000073          	ecall

	beqz a0, 1f
    1eda:	c111                	beqz	a0,1ede <__clone+0x1a>
	# Parent
	ret
    1edc:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ede:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ee0:	6522                	ld	a0,8(sp)
	jalr a1
    1ee2:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ee4:	05d00893          	li	a7,93
	ecall
    1ee8:	00000073          	ecall
