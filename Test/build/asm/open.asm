
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/open:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a07d                	j	10b0 <__start_main>

0000000000001004 <test_open>:
#include "unistd.h"
#include "stdio.h"
#include "stdlib.h"

void test_open() {
    1004:	716d                	addi	sp,sp,-272
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	eea50513          	addi	a0,a0,-278 # 1ef0 <__clone+0x28>
void test_open() {
    100e:	e606                	sd	ra,264(sp)
    1010:	e222                	sd	s0,256(sp)
	TEST_START(__func__);
    1012:	310000ef          	jal	1322 <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	f6250513          	addi	a0,a0,-158 # 1f78 <__func__.0>
    101e:	304000ef          	jal	1322 <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	ee650513          	addi	a0,a0,-282 # 1f08 <__clone+0x40>
    102a:	2f8000ef          	jal	1322 <puts>
	// O_RDONLY = 0, O_WRONLY = 1
	int fd = open("./text.txt", 0);
    102e:	4581                	li	a1,0
    1030:	00001517          	auipc	a0,0x1
    1034:	ee850513          	addi	a0,a0,-280 # 1f18 <__clone+0x50>
    1038:	41b000ef          	jal	1c52 <open>
    103c:	842a                	mv	s0,a0
	assert(fd >= 0);
    103e:	04054a63          	bltz	a0,1092 <test_open+0x8e>
	char buf[256];
	int size = read(fd, buf, 256);
    1042:	858a                	mv	a1,sp
    1044:	10000613          	li	a2,256
    1048:	8522                	mv	a0,s0
    104a:	43d000ef          	jal	1c86 <read>
    104e:	2501                	sext.w	a0,a0
	if (size < 0) {
		size = 0;
	}
	write(STDOUT, buf, size);
    1050:	fff54613          	not	a2,a0
    1054:	967d                	srai	a2,a2,0x3f
    1056:	8e69                	and	a2,a2,a0
    1058:	858a                	mv	a1,sp
    105a:	4505                	li	a0,1
    105c:	435000ef          	jal	1c90 <write>
	close(fd);
    1060:	8522                	mv	a0,s0
    1062:	419000ef          	jal	1c7a <close>
	TEST_END(__func__);
    1066:	00001517          	auipc	a0,0x1
    106a:	ee250513          	addi	a0,a0,-286 # 1f48 <__clone+0x80>
    106e:	2b4000ef          	jal	1322 <puts>
    1072:	00001517          	auipc	a0,0x1
    1076:	f0650513          	addi	a0,a0,-250 # 1f78 <__func__.0>
    107a:	2a8000ef          	jal	1322 <puts>
    107e:	00001517          	auipc	a0,0x1
    1082:	e8a50513          	addi	a0,a0,-374 # 1f08 <__clone+0x40>
    1086:	29c000ef          	jal	1322 <puts>
}
    108a:	60b2                	ld	ra,264(sp)
    108c:	6412                	ld	s0,256(sp)
    108e:	6151                	addi	sp,sp,272
    1090:	8082                	ret
	assert(fd >= 0);
    1092:	00001517          	auipc	a0,0x1
    1096:	e9650513          	addi	a0,a0,-362 # 1f28 <__clone+0x60>
    109a:	534000ef          	jal	15ce <panic>
    109e:	b755                	j	1042 <test_open+0x3e>

00000000000010a0 <main>:

int main(void) {
    10a0:	1141                	addi	sp,sp,-16
    10a2:	e406                	sd	ra,8(sp)
	test_open();
    10a4:	f61ff0ef          	jal	1004 <test_open>
	return 0;
}
    10a8:	60a2                	ld	ra,8(sp)
    10aa:	4501                	li	a0,0
    10ac:	0141                	addi	sp,sp,16
    10ae:	8082                	ret

00000000000010b0 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10b0:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10b2:	4108                	lw	a0,0(a0)
{
    10b4:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10b6:	05a1                	addi	a1,a1,8
{
    10b8:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10ba:	fe7ff0ef          	jal	10a0 <main>
    10be:	423000ef          	jal	1ce0 <exit>
	return 0;
}
    10c2:	60a2                	ld	ra,8(sp)
    10c4:	4501                	li	a0,0
    10c6:	0141                	addi	sp,sp,16
    10c8:	8082                	ret

00000000000010ca <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10ca:	7179                	addi	sp,sp,-48
    10cc:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10ce:	12054b63          	bltz	a0,1204 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10d2:	02b577bb          	remuw	a5,a0,a1
    10d6:	00001617          	auipc	a2,0x1
    10da:	eb260613          	addi	a2,a2,-334 # 1f88 <digits>
    buf[16] = 0;
    10de:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10e2:	0005871b          	sext.w	a4,a1
    10e6:	1782                	slli	a5,a5,0x20
    10e8:	9381                	srli	a5,a5,0x20
    10ea:	97b2                	add	a5,a5,a2
    10ec:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10f0:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10f4:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10f8:	1cb56363          	bltu	a0,a1,12be <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    10fc:	45b9                	li	a1,14
    10fe:	02e877bb          	remuw	a5,a6,a4
    1102:	1782                	slli	a5,a5,0x20
    1104:	9381                	srli	a5,a5,0x20
    1106:	97b2                	add	a5,a5,a2
    1108:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    110c:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    1110:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1114:	0ce86e63          	bltu	a6,a4,11f0 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1118:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    111c:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    1120:	1582                	slli	a1,a1,0x20
    1122:	9181                	srli	a1,a1,0x20
    1124:	95b2                	add	a1,a1,a2
    1126:	0005c583          	lbu	a1,0(a1)
    112a:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    112e:	0007859b          	sext.w	a1,a5
    1132:	12e6ec63          	bltu	a3,a4,126a <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1136:	02e7f6bb          	remuw	a3,a5,a4
    113a:	1682                	slli	a3,a3,0x20
    113c:	9281                	srli	a3,a3,0x20
    113e:	96b2                	add	a3,a3,a2
    1140:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1144:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1148:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    114c:	12e5e863          	bltu	a1,a4,127c <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    1150:	02e876bb          	remuw	a3,a6,a4
    1154:	1682                	slli	a3,a3,0x20
    1156:	9281                	srli	a3,a3,0x20
    1158:	96b2                	add	a3,a3,a2
    115a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    115e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1162:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1166:	12e86463          	bltu	a6,a4,128e <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    116a:	02e5f6bb          	remuw	a3,a1,a4
    116e:	1682                	slli	a3,a3,0x20
    1170:	9281                	srli	a3,a3,0x20
    1172:	96b2                	add	a3,a3,a2
    1174:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1178:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    117c:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    1180:	0ce5ec63          	bltu	a1,a4,1258 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    1184:	02e876bb          	remuw	a3,a6,a4
    1188:	1682                	slli	a3,a3,0x20
    118a:	9281                	srli	a3,a3,0x20
    118c:	96b2                	add	a3,a3,a2
    118e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1192:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1196:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    119a:	10e86963          	bltu	a6,a4,12ac <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    119e:	02e5f6bb          	remuw	a3,a1,a4
    11a2:	1682                	slli	a3,a3,0x20
    11a4:	9281                	srli	a3,a3,0x20
    11a6:	96b2                	add	a3,a3,a2
    11a8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11ac:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11b0:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11b4:	10e5e763          	bltu	a1,a4,12c2 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11b8:	02e876bb          	remuw	a3,a6,a4
    11bc:	1682                	slli	a3,a3,0x20
    11be:	9281                	srli	a3,a3,0x20
    11c0:	96b2                	add	a3,a3,a2
    11c2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11c6:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11ca:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11ce:	10e86363          	bltu	a6,a4,12d4 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11d2:	1782                	slli	a5,a5,0x20
    11d4:	9381                	srli	a5,a5,0x20
    11d6:	97b2                	add	a5,a5,a2
    11d8:	0007c783          	lbu	a5,0(a5)
    11dc:	4599                	li	a1,6
    11de:	00f10723          	sb	a5,14(sp)

    if (sign)
    11e2:	00055763          	bgez	a0,11f0 <printint.constprop.0+0x126>
        buf[i--] = '-';
    11e6:	02d00793          	li	a5,45
    11ea:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11ee:	4595                	li	a1,5
    write(f, s, l);
    11f0:	003c                	addi	a5,sp,8
    11f2:	4641                	li	a2,16
    11f4:	9e0d                	subw	a2,a2,a1
    11f6:	4505                	li	a0,1
    11f8:	95be                	add	a1,a1,a5
    11fa:	297000ef          	jal	1c90 <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11fe:	70a2                	ld	ra,40(sp)
    1200:	6145                	addi	sp,sp,48
    1202:	8082                	ret
        x = -xx;
    1204:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1208:	02b877bb          	remuw	a5,a6,a1
    120c:	00001617          	auipc	a2,0x1
    1210:	d7c60613          	addi	a2,a2,-644 # 1f88 <digits>
    buf[16] = 0;
    1214:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1218:	0005871b          	sext.w	a4,a1
    121c:	1782                	slli	a5,a5,0x20
    121e:	9381                	srli	a5,a5,0x20
    1220:	97b2                	add	a5,a5,a2
    1222:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1226:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    122a:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    122e:	06b86963          	bltu	a6,a1,12a0 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1232:	02e8f7bb          	remuw	a5,a7,a4
    1236:	1782                	slli	a5,a5,0x20
    1238:	9381                	srli	a5,a5,0x20
    123a:	97b2                	add	a5,a5,a2
    123c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1240:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1244:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1248:	ece8f8e3          	bgeu	a7,a4,1118 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    124c:	02d00793          	li	a5,45
    1250:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1254:	45b5                	li	a1,13
    1256:	bf69                	j	11f0 <printint.constprop.0+0x126>
    1258:	45a9                	li	a1,10
    if (sign)
    125a:	f8055be3          	bgez	a0,11f0 <printint.constprop.0+0x126>
        buf[i--] = '-';
    125e:	02d00793          	li	a5,45
    1262:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1266:	45a5                	li	a1,9
    1268:	b761                	j	11f0 <printint.constprop.0+0x126>
    126a:	45b5                	li	a1,13
    if (sign)
    126c:	f80552e3          	bgez	a0,11f0 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1270:	02d00793          	li	a5,45
    1274:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1278:	45b1                	li	a1,12
    127a:	bf9d                	j	11f0 <printint.constprop.0+0x126>
    127c:	45b1                	li	a1,12
    if (sign)
    127e:	f60559e3          	bgez	a0,11f0 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1282:	02d00793          	li	a5,45
    1286:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    128a:	45ad                	li	a1,11
    128c:	b795                	j	11f0 <printint.constprop.0+0x126>
    128e:	45ad                	li	a1,11
    if (sign)
    1290:	f60550e3          	bgez	a0,11f0 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1294:	02d00793          	li	a5,45
    1298:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    129c:	45a9                	li	a1,10
    129e:	bf89                	j	11f0 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12a0:	02d00793          	li	a5,45
    12a4:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12a8:	45b9                	li	a1,14
    12aa:	b799                	j	11f0 <printint.constprop.0+0x126>
    12ac:	45a5                	li	a1,9
    if (sign)
    12ae:	f40551e3          	bgez	a0,11f0 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b2:	02d00793          	li	a5,45
    12b6:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12ba:	45a1                	li	a1,8
    12bc:	bf15                	j	11f0 <printint.constprop.0+0x126>
    i = 15;
    12be:	45bd                	li	a1,15
    12c0:	bf05                	j	11f0 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12c2:	45a1                	li	a1,8
    if (sign)
    12c4:	f20556e3          	bgez	a0,11f0 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c8:	02d00793          	li	a5,45
    12cc:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12d0:	459d                	li	a1,7
    12d2:	bf39                	j	11f0 <printint.constprop.0+0x126>
    12d4:	459d                	li	a1,7
    if (sign)
    12d6:	f0055de3          	bgez	a0,11f0 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12da:	02d00793          	li	a5,45
    12de:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12e2:	4599                	li	a1,6
    12e4:	b731                	j	11f0 <printint.constprop.0+0x126>

00000000000012e6 <getchar>:
{
    12e6:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12e8:	00f10593          	addi	a1,sp,15
    12ec:	4605                	li	a2,1
    12ee:	4501                	li	a0,0
{
    12f0:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12f2:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12f6:	191000ef          	jal	1c86 <read>
}
    12fa:	60e2                	ld	ra,24(sp)
    12fc:	00f14503          	lbu	a0,15(sp)
    1300:	6105                	addi	sp,sp,32
    1302:	8082                	ret

0000000000001304 <putchar>:
{
    1304:	1101                	addi	sp,sp,-32
    1306:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1308:	00f10593          	addi	a1,sp,15
    130c:	4605                	li	a2,1
    130e:	4505                	li	a0,1
{
    1310:	ec06                	sd	ra,24(sp)
    char byte = c;
    1312:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1316:	17b000ef          	jal	1c90 <write>
}
    131a:	60e2                	ld	ra,24(sp)
    131c:	2501                	sext.w	a0,a0
    131e:	6105                	addi	sp,sp,32
    1320:	8082                	ret

0000000000001322 <puts>:
{
    1322:	1141                	addi	sp,sp,-16
    1324:	e406                	sd	ra,8(sp)
    1326:	e022                	sd	s0,0(sp)
    1328:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    132a:	582000ef          	jal	18ac <strlen>
    132e:	862a                	mv	a2,a0
    1330:	85a2                	mv	a1,s0
    1332:	4505                	li	a0,1
    1334:	15d000ef          	jal	1c90 <write>
}
    1338:	60a2                	ld	ra,8(sp)
    133a:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    133c:	957d                	srai	a0,a0,0x3f
    return r;
    133e:	2501                	sext.w	a0,a0
}
    1340:	0141                	addi	sp,sp,16
    1342:	8082                	ret

0000000000001344 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1344:	7131                	addi	sp,sp,-192
    1346:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1348:	013c                	addi	a5,sp,136
{
    134a:	f0ca                	sd	s2,96(sp)
    134c:	ecce                	sd	s3,88(sp)
    134e:	e8d2                	sd	s4,80(sp)
    1350:	e4d6                	sd	s5,72(sp)
    1352:	e0da                	sd	s6,64(sp)
    1354:	fc5e                	sd	s7,56(sp)
    1356:	fc86                	sd	ra,120(sp)
    1358:	f8a2                	sd	s0,112(sp)
    135a:	f4a6                	sd	s1,104(sp)
    135c:	e52e                	sd	a1,136(sp)
    135e:	e932                	sd	a2,144(sp)
    1360:	ed36                	sd	a3,152(sp)
    1362:	f13a                	sd	a4,160(sp)
    1364:	f942                	sd	a6,176(sp)
    1366:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1368:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    136a:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    136e:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1372:	00001b97          	auipc	s7,0x1
    1376:	be6b8b93          	addi	s7,s7,-1050 # 1f58 <__clone+0x90>
        switch (s[1])
    137a:	07800a93          	li	s5,120
    137e:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1382:	00001997          	auipc	s3,0x1
    1386:	c0698993          	addi	s3,s3,-1018 # 1f88 <digits>
        if (!*s)
    138a:	00054783          	lbu	a5,0(a0)
    138e:	16078c63          	beqz	a5,1506 <printf+0x1c2>
    1392:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1394:	19278463          	beq	a5,s2,151c <printf+0x1d8>
    1398:	00164783          	lbu	a5,1(a2)
    139c:	0605                	addi	a2,a2,1
    139e:	fbfd                	bnez	a5,1394 <printf+0x50>
    13a0:	84b2                	mv	s1,a2
        l = z - a;
    13a2:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13a6:	85aa                	mv	a1,a0
    13a8:	8622                	mv	a2,s0
    13aa:	4505                	li	a0,1
    13ac:	0e5000ef          	jal	1c90 <write>
        if (l)
    13b0:	18041f63          	bnez	s0,154e <printf+0x20a>
        if (s[1] == 0)
    13b4:	0014c783          	lbu	a5,1(s1)
    13b8:	14078763          	beqz	a5,1506 <printf+0x1c2>
        switch (s[1])
    13bc:	1d478163          	beq	a5,s4,157e <printf+0x23a>
    13c0:	18fa6963          	bltu	s4,a5,1552 <printf+0x20e>
    13c4:	1b678363          	beq	a5,s6,156a <printf+0x226>
    13c8:	07000713          	li	a4,112
    13cc:	1ce79c63          	bne	a5,a4,15a4 <printf+0x260>
            printptr(va_arg(ap, uint64));
    13d0:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13d2:	03000793          	li	a5,48
    13d6:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13da:	631c                	ld	a5,0(a4)
    13dc:	0721                	addi	a4,a4,8
    13de:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13e0:	00479f93          	slli	t6,a5,0x4
    13e4:	00879f13          	slli	t5,a5,0x8
    13e8:	00c79e93          	slli	t4,a5,0xc
    13ec:	01079e13          	slli	t3,a5,0x10
    13f0:	01479313          	slli	t1,a5,0x14
    13f4:	01879893          	slli	a7,a5,0x18
    13f8:	01c79713          	slli	a4,a5,0x1c
    13fc:	02479813          	slli	a6,a5,0x24
    1400:	02879513          	slli	a0,a5,0x28
    1404:	02c79593          	slli	a1,a5,0x2c
    1408:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    140c:	03c7d293          	srli	t0,a5,0x3c
    1410:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1414:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1418:	03cfdf93          	srli	t6,t6,0x3c
    141c:	03cf5f13          	srli	t5,t5,0x3c
    1420:	03cede93          	srli	t4,t4,0x3c
    1424:	03ce5e13          	srli	t3,t3,0x3c
    1428:	03c35313          	srli	t1,t1,0x3c
    142c:	03c8d893          	srli	a7,a7,0x3c
    1430:	9371                	srli	a4,a4,0x3c
    1432:	03c85813          	srli	a6,a6,0x3c
    1436:	9171                	srli	a0,a0,0x3c
    1438:	91f1                	srli	a1,a1,0x3c
    143a:	9271                	srli	a2,a2,0x3c
    143c:	974e                	add	a4,a4,s3
    143e:	92f1                	srli	a3,a3,0x3c
    1440:	92ce                	add	t0,t0,s3
    1442:	9fce                	add	t6,t6,s3
    1444:	9f4e                	add	t5,t5,s3
    1446:	9ece                	add	t4,t4,s3
    1448:	9e4e                	add	t3,t3,s3
    144a:	934e                	add	t1,t1,s3
    144c:	98ce                	add	a7,a7,s3
    144e:	93ce                	add	t2,t2,s3
    1450:	984e                	add	a6,a6,s3
    1452:	954e                	add	a0,a0,s3
    1454:	95ce                	add	a1,a1,s3
    1456:	964e                	add	a2,a2,s3
    1458:	0002c283          	lbu	t0,0(t0)
    145c:	000fcf83          	lbu	t6,0(t6)
    1460:	000f4f03          	lbu	t5,0(t5)
    1464:	000ece83          	lbu	t4,0(t4)
    1468:	000e4e03          	lbu	t3,0(t3)
    146c:	00034303          	lbu	t1,0(t1)
    1470:	0008c883          	lbu	a7,0(a7)
    1474:	00074403          	lbu	s0,0(a4)
    1478:	0003c383          	lbu	t2,0(t2)
    147c:	00084803          	lbu	a6,0(a6)
    1480:	00054503          	lbu	a0,0(a0)
    1484:	0005c583          	lbu	a1,0(a1)
    1488:	00064603          	lbu	a2,0(a2)
    148c:	00d98733          	add	a4,s3,a3
    1490:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1494:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1498:	9371                	srli	a4,a4,0x3c
    149a:	8bbd                	andi	a5,a5,15
    149c:	00510523          	sb	t0,10(sp)
    14a0:	01f105a3          	sb	t6,11(sp)
    14a4:	01e10623          	sb	t5,12(sp)
    14a8:	01d106a3          	sb	t4,13(sp)
    14ac:	01c10723          	sb	t3,14(sp)
    14b0:	006107a3          	sb	t1,15(sp)
    14b4:	01110823          	sb	a7,16(sp)
    14b8:	00710923          	sb	t2,18(sp)
    14bc:	010109a3          	sb	a6,19(sp)
    14c0:	00a10a23          	sb	a0,20(sp)
    14c4:	00b10aa3          	sb	a1,21(sp)
    14c8:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14cc:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14d0:	008108a3          	sb	s0,17(sp)
    14d4:	974e                	add	a4,a4,s3
    14d6:	97ce                	add	a5,a5,s3
    14d8:	00d10ba3          	sb	a3,23(sp)
    14dc:	00074703          	lbu	a4,0(a4)
    14e0:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14e4:	4649                	li	a2,18
    14e6:	002c                	addi	a1,sp,8
    14e8:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ea:	00e10c23          	sb	a4,24(sp)
    14ee:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14f2:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14f6:	79a000ef          	jal	1c90 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14fa:	00248513          	addi	a0,s1,2
        if (!*s)
    14fe:	00054783          	lbu	a5,0(a0)
    1502:	e80798e3          	bnez	a5,1392 <printf+0x4e>
    }
    va_end(ap);
}
    1506:	70e6                	ld	ra,120(sp)
    1508:	7446                	ld	s0,112(sp)
    150a:	74a6                	ld	s1,104(sp)
    150c:	7906                	ld	s2,96(sp)
    150e:	69e6                	ld	s3,88(sp)
    1510:	6a46                	ld	s4,80(sp)
    1512:	6aa6                	ld	s5,72(sp)
    1514:	6b06                	ld	s6,64(sp)
    1516:	7be2                	ld	s7,56(sp)
    1518:	6129                	addi	sp,sp,192
    151a:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    151c:	00064783          	lbu	a5,0(a2)
    1520:	84b2                	mv	s1,a2
    1522:	01278963          	beq	a5,s2,1534 <printf+0x1f0>
    1526:	bdb5                	j	13a2 <printf+0x5e>
    1528:	0024c783          	lbu	a5,2(s1)
    152c:	0605                	addi	a2,a2,1
    152e:	0489                	addi	s1,s1,2
    1530:	e72799e3          	bne	a5,s2,13a2 <printf+0x5e>
    1534:	0014c783          	lbu	a5,1(s1)
    1538:	ff2788e3          	beq	a5,s2,1528 <printf+0x1e4>
        l = z - a;
    153c:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1540:	85aa                	mv	a1,a0
    1542:	8622                	mv	a2,s0
    1544:	4505                	li	a0,1
    1546:	74a000ef          	jal	1c90 <write>
        if (l)
    154a:	e60405e3          	beqz	s0,13b4 <printf+0x70>
    154e:	8526                	mv	a0,s1
    1550:	bd2d                	j	138a <printf+0x46>
        switch (s[1])
    1552:	05579963          	bne	a5,s5,15a4 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1556:	6782                	ld	a5,0(sp)
    1558:	45c1                	li	a1,16
    155a:	4388                	lw	a0,0(a5)
    155c:	07a1                	addi	a5,a5,8
    155e:	e03e                	sd	a5,0(sp)
    1560:	b6bff0ef          	jal	10ca <printint.constprop.0>
        s += 2;
    1564:	00248513          	addi	a0,s1,2
    1568:	bf59                	j	14fe <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    156a:	6782                	ld	a5,0(sp)
    156c:	45a9                	li	a1,10
    156e:	4388                	lw	a0,0(a5)
    1570:	07a1                	addi	a5,a5,8
    1572:	e03e                	sd	a5,0(sp)
    1574:	b57ff0ef          	jal	10ca <printint.constprop.0>
        s += 2;
    1578:	00248513          	addi	a0,s1,2
    157c:	b749                	j	14fe <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    157e:	6782                	ld	a5,0(sp)
    1580:	6380                	ld	s0,0(a5)
    1582:	07a1                	addi	a5,a5,8
    1584:	e03e                	sd	a5,0(sp)
    1586:	c031                	beqz	s0,15ca <printf+0x286>
            l = strnlen(a, 200);
    1588:	0c800593          	li	a1,200
    158c:	8522                	mv	a0,s0
    158e:	40a000ef          	jal	1998 <strnlen>
    write(f, s, l);
    1592:	0005061b          	sext.w	a2,a0
    1596:	85a2                	mv	a1,s0
    1598:	4505                	li	a0,1
    159a:	6f6000ef          	jal	1c90 <write>
        s += 2;
    159e:	00248513          	addi	a0,s1,2
    15a2:	bfb1                	j	14fe <printf+0x1ba>
    return write(stdout, &byte, 1);
    15a4:	4605                	li	a2,1
    15a6:	002c                	addi	a1,sp,8
    15a8:	4505                	li	a0,1
    char byte = c;
    15aa:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15ae:	6e2000ef          	jal	1c90 <write>
    char byte = c;
    15b2:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15b6:	4605                	li	a2,1
    15b8:	002c                	addi	a1,sp,8
    15ba:	4505                	li	a0,1
    char byte = c;
    15bc:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15c0:	6d0000ef          	jal	1c90 <write>
        s += 2;
    15c4:	00248513          	addi	a0,s1,2
    15c8:	bf1d                	j	14fe <printf+0x1ba>
                a = "(null)";
    15ca:	845e                	mv	s0,s7
    15cc:	bf75                	j	1588 <printf+0x244>

00000000000015ce <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15ce:	1141                	addi	sp,sp,-16
    15d0:	e406                	sd	ra,8(sp)
    puts(m);
    15d2:	d51ff0ef          	jal	1322 <puts>
    exit(-100);
}
    15d6:	60a2                	ld	ra,8(sp)
    exit(-100);
    15d8:	f9c00513          	li	a0,-100
}
    15dc:	0141                	addi	sp,sp,16
    exit(-100);
    15de:	a709                	j	1ce0 <exit>

00000000000015e0 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15e0:	02000793          	li	a5,32
    15e4:	00f50663          	beq	a0,a5,15f0 <isspace+0x10>
    15e8:	355d                	addiw	a0,a0,-9
    15ea:	00553513          	sltiu	a0,a0,5
    15ee:	8082                	ret
    15f0:	4505                	li	a0,1
}
    15f2:	8082                	ret

00000000000015f4 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15f4:	fd05051b          	addiw	a0,a0,-48
}
    15f8:	00a53513          	sltiu	a0,a0,10
    15fc:	8082                	ret

00000000000015fe <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15fe:	02000613          	li	a2,32
    1602:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1604:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1608:	ff77069b          	addiw	a3,a4,-9
    160c:	04c70d63          	beq	a4,a2,1666 <atoi+0x68>
    1610:	0007079b          	sext.w	a5,a4
    1614:	04d5f963          	bgeu	a1,a3,1666 <atoi+0x68>
        s++;
    switch (*s)
    1618:	02b00693          	li	a3,43
    161c:	04d70a63          	beq	a4,a3,1670 <atoi+0x72>
    1620:	02d00693          	li	a3,45
    1624:	06d70463          	beq	a4,a3,168c <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1628:	fd07859b          	addiw	a1,a5,-48
    162c:	4625                	li	a2,9
    162e:	873e                	mv	a4,a5
    1630:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1632:	4e01                	li	t3,0
    while (isdigit(*s))
    1634:	04b66a63          	bltu	a2,a1,1688 <atoi+0x8a>
    int n = 0, neg = 0;
    1638:	4501                	li	a0,0
    while (isdigit(*s))
    163a:	4825                	li	a6,9
    163c:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1640:	0025179b          	slliw	a5,a0,0x2
    1644:	9d3d                	addw	a0,a0,a5
    1646:	fd07031b          	addiw	t1,a4,-48
    164a:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    164e:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1652:	0685                	addi	a3,a3,1
    1654:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1658:	0006071b          	sext.w	a4,a2
    165c:	feb870e3          	bgeu	a6,a1,163c <atoi+0x3e>
    return neg ? n : -n;
    1660:	000e0563          	beqz	t3,166a <atoi+0x6c>
}
    1664:	8082                	ret
        s++;
    1666:	0505                	addi	a0,a0,1
    1668:	bf71                	j	1604 <atoi+0x6>
    return neg ? n : -n;
    166a:	4113053b          	subw	a0,t1,a7
    166e:	8082                	ret
    while (isdigit(*s))
    1670:	00154783          	lbu	a5,1(a0)
    1674:	4625                	li	a2,9
        s++;
    1676:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    167a:	fd07859b          	addiw	a1,a5,-48
    167e:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1682:	4e01                	li	t3,0
    while (isdigit(*s))
    1684:	fab67ae3          	bgeu	a2,a1,1638 <atoi+0x3a>
    1688:	4501                	li	a0,0
}
    168a:	8082                	ret
    while (isdigit(*s))
    168c:	00154783          	lbu	a5,1(a0)
    1690:	4625                	li	a2,9
        s++;
    1692:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1696:	fd07859b          	addiw	a1,a5,-48
    169a:	0007871b          	sext.w	a4,a5
    169e:	feb665e3          	bltu	a2,a1,1688 <atoi+0x8a>
        neg = 1;
    16a2:	4e05                	li	t3,1
    16a4:	bf51                	j	1638 <atoi+0x3a>

00000000000016a6 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16a6:	16060d63          	beqz	a2,1820 <memset+0x17a>
    16aa:	40a007b3          	neg	a5,a0
    16ae:	8b9d                	andi	a5,a5,7
    16b0:	00778713          	addi	a4,a5,7
    16b4:	482d                	li	a6,11
    16b6:	0ff5f593          	zext.b	a1,a1
    16ba:	fff60693          	addi	a3,a2,-1
    16be:	17076263          	bltu	a4,a6,1822 <memset+0x17c>
    16c2:	16e6ea63          	bltu	a3,a4,1836 <memset+0x190>
    16c6:	16078563          	beqz	a5,1830 <memset+0x18a>
    16ca:	00b50023          	sb	a1,0(a0)
    16ce:	4705                	li	a4,1
    16d0:	00150e93          	addi	t4,a0,1
    16d4:	14e78c63          	beq	a5,a4,182c <memset+0x186>
    16d8:	00b500a3          	sb	a1,1(a0)
    16dc:	4709                	li	a4,2
    16de:	00250e93          	addi	t4,a0,2
    16e2:	14e78d63          	beq	a5,a4,183c <memset+0x196>
    16e6:	00b50123          	sb	a1,2(a0)
    16ea:	470d                	li	a4,3
    16ec:	00350e93          	addi	t4,a0,3
    16f0:	12e78b63          	beq	a5,a4,1826 <memset+0x180>
    16f4:	00b501a3          	sb	a1,3(a0)
    16f8:	4711                	li	a4,4
    16fa:	00450e93          	addi	t4,a0,4
    16fe:	14e78163          	beq	a5,a4,1840 <memset+0x19a>
    1702:	00b50223          	sb	a1,4(a0)
    1706:	4715                	li	a4,5
    1708:	00550e93          	addi	t4,a0,5
    170c:	12e78c63          	beq	a5,a4,1844 <memset+0x19e>
    1710:	00b502a3          	sb	a1,5(a0)
    1714:	471d                	li	a4,7
    1716:	00650e93          	addi	t4,a0,6
    171a:	12e79763          	bne	a5,a4,1848 <memset+0x1a2>
    171e:	00750e93          	addi	t4,a0,7
    1722:	00b50323          	sb	a1,6(a0)
    1726:	4f1d                	li	t5,7
    1728:	00859713          	slli	a4,a1,0x8
    172c:	8f4d                	or	a4,a4,a1
    172e:	01059e13          	slli	t3,a1,0x10
    1732:	01c76e33          	or	t3,a4,t3
    1736:	01859313          	slli	t1,a1,0x18
    173a:	006e6333          	or	t1,t3,t1
    173e:	02059893          	slli	a7,a1,0x20
    1742:	011368b3          	or	a7,t1,a7
    1746:	02859813          	slli	a6,a1,0x28
    174a:	40f60333          	sub	t1,a2,a5
    174e:	0108e833          	or	a6,a7,a6
    1752:	03059693          	slli	a3,a1,0x30
    1756:	00d866b3          	or	a3,a6,a3
    175a:	03859713          	slli	a4,a1,0x38
    175e:	97aa                	add	a5,a5,a0
    1760:	ff837813          	andi	a6,t1,-8
    1764:	8f55                	or	a4,a4,a3
    1766:	00f806b3          	add	a3,a6,a5
    176a:	e398                	sd	a4,0(a5)
    176c:	07a1                	addi	a5,a5,8
    176e:	fed79ee3          	bne	a5,a3,176a <memset+0xc4>
    1772:	ff837693          	andi	a3,t1,-8
    1776:	00de87b3          	add	a5,t4,a3
    177a:	01e6873b          	addw	a4,a3,t5
    177e:	0ad30663          	beq	t1,a3,182a <memset+0x184>
    1782:	00b78023          	sb	a1,0(a5)
    1786:	0017069b          	addiw	a3,a4,1
    178a:	08c6fb63          	bgeu	a3,a2,1820 <memset+0x17a>
    178e:	00b780a3          	sb	a1,1(a5)
    1792:	0027069b          	addiw	a3,a4,2
    1796:	08c6f563          	bgeu	a3,a2,1820 <memset+0x17a>
    179a:	00b78123          	sb	a1,2(a5)
    179e:	0037069b          	addiw	a3,a4,3
    17a2:	06c6ff63          	bgeu	a3,a2,1820 <memset+0x17a>
    17a6:	00b781a3          	sb	a1,3(a5)
    17aa:	0047069b          	addiw	a3,a4,4
    17ae:	06c6f963          	bgeu	a3,a2,1820 <memset+0x17a>
    17b2:	00b78223          	sb	a1,4(a5)
    17b6:	0057069b          	addiw	a3,a4,5
    17ba:	06c6f363          	bgeu	a3,a2,1820 <memset+0x17a>
    17be:	00b782a3          	sb	a1,5(a5)
    17c2:	0067069b          	addiw	a3,a4,6
    17c6:	04c6fd63          	bgeu	a3,a2,1820 <memset+0x17a>
    17ca:	00b78323          	sb	a1,6(a5)
    17ce:	0077069b          	addiw	a3,a4,7
    17d2:	04c6f763          	bgeu	a3,a2,1820 <memset+0x17a>
    17d6:	00b783a3          	sb	a1,7(a5)
    17da:	0087069b          	addiw	a3,a4,8
    17de:	04c6f163          	bgeu	a3,a2,1820 <memset+0x17a>
    17e2:	00b78423          	sb	a1,8(a5)
    17e6:	0097069b          	addiw	a3,a4,9
    17ea:	02c6fb63          	bgeu	a3,a2,1820 <memset+0x17a>
    17ee:	00b784a3          	sb	a1,9(a5)
    17f2:	00a7069b          	addiw	a3,a4,10
    17f6:	02c6f563          	bgeu	a3,a2,1820 <memset+0x17a>
    17fa:	00b78523          	sb	a1,10(a5)
    17fe:	00b7069b          	addiw	a3,a4,11
    1802:	00c6ff63          	bgeu	a3,a2,1820 <memset+0x17a>
    1806:	00b785a3          	sb	a1,11(a5)
    180a:	00c7069b          	addiw	a3,a4,12
    180e:	00c6f963          	bgeu	a3,a2,1820 <memset+0x17a>
    1812:	00b78623          	sb	a1,12(a5)
    1816:	2735                	addiw	a4,a4,13
    1818:	00c77463          	bgeu	a4,a2,1820 <memset+0x17a>
    181c:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1820:	8082                	ret
    1822:	472d                	li	a4,11
    1824:	bd79                	j	16c2 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1826:	4f0d                	li	t5,3
    1828:	b701                	j	1728 <memset+0x82>
    182a:	8082                	ret
    182c:	4f05                	li	t5,1
    182e:	bded                	j	1728 <memset+0x82>
    1830:	8eaa                	mv	t4,a0
    1832:	4f01                	li	t5,0
    1834:	bdd5                	j	1728 <memset+0x82>
    1836:	87aa                	mv	a5,a0
    1838:	4701                	li	a4,0
    183a:	b7a1                	j	1782 <memset+0xdc>
    183c:	4f09                	li	t5,2
    183e:	b5ed                	j	1728 <memset+0x82>
    1840:	4f11                	li	t5,4
    1842:	b5dd                	j	1728 <memset+0x82>
    1844:	4f15                	li	t5,5
    1846:	b5cd                	j	1728 <memset+0x82>
    1848:	4f19                	li	t5,6
    184a:	bdf9                	j	1728 <memset+0x82>

000000000000184c <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    184c:	00054783          	lbu	a5,0(a0)
    1850:	0005c703          	lbu	a4,0(a1)
    1854:	00e79863          	bne	a5,a4,1864 <strcmp+0x18>
    1858:	0505                	addi	a0,a0,1
    185a:	0585                	addi	a1,a1,1
    185c:	fbe5                	bnez	a5,184c <strcmp>
    185e:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1860:	9d19                	subw	a0,a0,a4
    1862:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1864:	0007851b          	sext.w	a0,a5
    1868:	bfe5                	j	1860 <strcmp+0x14>

000000000000186a <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    186a:	ce05                	beqz	a2,18a2 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    186c:	00054703          	lbu	a4,0(a0)
    1870:	0005c783          	lbu	a5,0(a1)
    1874:	cb0d                	beqz	a4,18a6 <strncmp+0x3c>
    if (!n--)
    1876:	167d                	addi	a2,a2,-1
    1878:	00c506b3          	add	a3,a0,a2
    187c:	a819                	j	1892 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    187e:	00a68e63          	beq	a3,a0,189a <strncmp+0x30>
    1882:	0505                	addi	a0,a0,1
    1884:	00e79b63          	bne	a5,a4,189a <strncmp+0x30>
    1888:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    188c:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1890:	cb19                	beqz	a4,18a6 <strncmp+0x3c>
    1892:	0005c783          	lbu	a5,0(a1)
    1896:	0585                	addi	a1,a1,1
    1898:	f3fd                	bnez	a5,187e <strncmp+0x14>
    return *l - *r;
    189a:	0007051b          	sext.w	a0,a4
    189e:	9d1d                	subw	a0,a0,a5
    18a0:	8082                	ret
        return 0;
    18a2:	4501                	li	a0,0
}
    18a4:	8082                	ret
    18a6:	4501                	li	a0,0
    return *l - *r;
    18a8:	9d1d                	subw	a0,a0,a5
    18aa:	8082                	ret

00000000000018ac <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18ac:	00757793          	andi	a5,a0,7
    18b0:	cf89                	beqz	a5,18ca <strlen+0x1e>
    18b2:	87aa                	mv	a5,a0
    18b4:	a029                	j	18be <strlen+0x12>
    18b6:	0785                	addi	a5,a5,1
    18b8:	0077f713          	andi	a4,a5,7
    18bc:	cb01                	beqz	a4,18cc <strlen+0x20>
        if (!*s)
    18be:	0007c703          	lbu	a4,0(a5)
    18c2:	fb75                	bnez	a4,18b6 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18c4:	40a78533          	sub	a0,a5,a0
}
    18c8:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18ca:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18cc:	6394                	ld	a3,0(a5)
    18ce:	00000597          	auipc	a1,0x0
    18d2:	6925b583          	ld	a1,1682(a1) # 1f60 <__clone+0x98>
    18d6:	00000617          	auipc	a2,0x0
    18da:	69263603          	ld	a2,1682(a2) # 1f68 <__clone+0xa0>
    18de:	a019                	j	18e4 <strlen+0x38>
    18e0:	6794                	ld	a3,8(a5)
    18e2:	07a1                	addi	a5,a5,8
    18e4:	00b68733          	add	a4,a3,a1
    18e8:	fff6c693          	not	a3,a3
    18ec:	8f75                	and	a4,a4,a3
    18ee:	8f71                	and	a4,a4,a2
    18f0:	db65                	beqz	a4,18e0 <strlen+0x34>
    for (; *s; s++)
    18f2:	0007c703          	lbu	a4,0(a5)
    18f6:	d779                	beqz	a4,18c4 <strlen+0x18>
    18f8:	0017c703          	lbu	a4,1(a5)
    18fc:	0785                	addi	a5,a5,1
    18fe:	d379                	beqz	a4,18c4 <strlen+0x18>
    1900:	0017c703          	lbu	a4,1(a5)
    1904:	0785                	addi	a5,a5,1
    1906:	fb6d                	bnez	a4,18f8 <strlen+0x4c>
    1908:	bf75                	j	18c4 <strlen+0x18>

000000000000190a <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    190a:	00757713          	andi	a4,a0,7
{
    190e:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1910:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1914:	cb19                	beqz	a4,192a <memchr+0x20>
    1916:	ce25                	beqz	a2,198e <memchr+0x84>
    1918:	0007c703          	lbu	a4,0(a5)
    191c:	04b70e63          	beq	a4,a1,1978 <memchr+0x6e>
    1920:	0785                	addi	a5,a5,1
    1922:	0077f713          	andi	a4,a5,7
    1926:	167d                	addi	a2,a2,-1
    1928:	f77d                	bnez	a4,1916 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    192a:	4501                	li	a0,0
    if (n && *s != c)
    192c:	c235                	beqz	a2,1990 <memchr+0x86>
    192e:	0007c703          	lbu	a4,0(a5)
    1932:	04b70363          	beq	a4,a1,1978 <memchr+0x6e>
        size_t k = ONES * c;
    1936:	00000517          	auipc	a0,0x0
    193a:	63a53503          	ld	a0,1594(a0) # 1f70 <__clone+0xa8>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    193e:	471d                	li	a4,7
        size_t k = ONES * c;
    1940:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1944:	02c77a63          	bgeu	a4,a2,1978 <memchr+0x6e>
    1948:	00000897          	auipc	a7,0x0
    194c:	6188b883          	ld	a7,1560(a7) # 1f60 <__clone+0x98>
    1950:	00000817          	auipc	a6,0x0
    1954:	61883803          	ld	a6,1560(a6) # 1f68 <__clone+0xa0>
    1958:	431d                	li	t1,7
    195a:	a029                	j	1964 <memchr+0x5a>
    195c:	1661                	addi	a2,a2,-8
    195e:	07a1                	addi	a5,a5,8
    1960:	02c37963          	bgeu	t1,a2,1992 <memchr+0x88>
    1964:	6398                	ld	a4,0(a5)
    1966:	8f29                	xor	a4,a4,a0
    1968:	011706b3          	add	a3,a4,a7
    196c:	fff74713          	not	a4,a4
    1970:	8f75                	and	a4,a4,a3
    1972:	01077733          	and	a4,a4,a6
    1976:	d37d                	beqz	a4,195c <memchr+0x52>
    1978:	853e                	mv	a0,a5
    197a:	97b2                	add	a5,a5,a2
    197c:	a021                	j	1984 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    197e:	0505                	addi	a0,a0,1
    1980:	00f50763          	beq	a0,a5,198e <memchr+0x84>
    1984:	00054703          	lbu	a4,0(a0)
    1988:	feb71be3          	bne	a4,a1,197e <memchr+0x74>
    198c:	8082                	ret
    return n ? (void *)s : 0;
    198e:	4501                	li	a0,0
}
    1990:	8082                	ret
    return n ? (void *)s : 0;
    1992:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1994:	f275                	bnez	a2,1978 <memchr+0x6e>
}
    1996:	8082                	ret

0000000000001998 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1998:	1101                	addi	sp,sp,-32
    199a:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    199c:	862e                	mv	a2,a1
{
    199e:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19a0:	4581                	li	a1,0
{
    19a2:	e426                	sd	s1,8(sp)
    19a4:	ec06                	sd	ra,24(sp)
    19a6:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19a8:	f63ff0ef          	jal	190a <memchr>
    return p ? p - s : n;
    19ac:	c519                	beqz	a0,19ba <strnlen+0x22>
}
    19ae:	60e2                	ld	ra,24(sp)
    19b0:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19b2:	8d05                	sub	a0,a0,s1
}
    19b4:	64a2                	ld	s1,8(sp)
    19b6:	6105                	addi	sp,sp,32
    19b8:	8082                	ret
    19ba:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19bc:	8522                	mv	a0,s0
}
    19be:	6442                	ld	s0,16(sp)
    19c0:	64a2                	ld	s1,8(sp)
    19c2:	6105                	addi	sp,sp,32
    19c4:	8082                	ret

00000000000019c6 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19c6:	00b547b3          	xor	a5,a0,a1
    19ca:	8b9d                	andi	a5,a5,7
    19cc:	eb95                	bnez	a5,1a00 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19ce:	0075f793          	andi	a5,a1,7
    19d2:	e7b1                	bnez	a5,1a1e <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19d4:	6198                	ld	a4,0(a1)
    19d6:	00000617          	auipc	a2,0x0
    19da:	58a63603          	ld	a2,1418(a2) # 1f60 <__clone+0x98>
    19de:	00000817          	auipc	a6,0x0
    19e2:	58a83803          	ld	a6,1418(a6) # 1f68 <__clone+0xa0>
    19e6:	a029                	j	19f0 <strcpy+0x2a>
    19e8:	e118                	sd	a4,0(a0)
    19ea:	6598                	ld	a4,8(a1)
    19ec:	05a1                	addi	a1,a1,8
    19ee:	0521                	addi	a0,a0,8
    19f0:	00c707b3          	add	a5,a4,a2
    19f4:	fff74693          	not	a3,a4
    19f8:	8ff5                	and	a5,a5,a3
    19fa:	0107f7b3          	and	a5,a5,a6
    19fe:	d7ed                	beqz	a5,19e8 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a00:	0005c783          	lbu	a5,0(a1)
    1a04:	00f50023          	sb	a5,0(a0)
    1a08:	c785                	beqz	a5,1a30 <strcpy+0x6a>
    1a0a:	0015c783          	lbu	a5,1(a1)
    1a0e:	0505                	addi	a0,a0,1
    1a10:	0585                	addi	a1,a1,1
    1a12:	00f50023          	sb	a5,0(a0)
    1a16:	fbf5                	bnez	a5,1a0a <strcpy+0x44>
        ;
    return d;
}
    1a18:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a1a:	0505                	addi	a0,a0,1
    1a1c:	df45                	beqz	a4,19d4 <strcpy+0xe>
            if (!(*d = *s))
    1a1e:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a22:	0585                	addi	a1,a1,1
    1a24:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a28:	00f50023          	sb	a5,0(a0)
    1a2c:	f7fd                	bnez	a5,1a1a <strcpy+0x54>
}
    1a2e:	8082                	ret
    1a30:	8082                	ret

0000000000001a32 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a32:	00b547b3          	xor	a5,a0,a1
    1a36:	8b9d                	andi	a5,a5,7
    1a38:	1a079863          	bnez	a5,1be8 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a3c:	0075f793          	andi	a5,a1,7
    1a40:	16078463          	beqz	a5,1ba8 <strncpy+0x176>
    1a44:	ea01                	bnez	a2,1a54 <strncpy+0x22>
    1a46:	a421                	j	1c4e <strncpy+0x21c>
    1a48:	167d                	addi	a2,a2,-1
    1a4a:	0505                	addi	a0,a0,1
    1a4c:	14070e63          	beqz	a4,1ba8 <strncpy+0x176>
    1a50:	1a060863          	beqz	a2,1c00 <strncpy+0x1ce>
    1a54:	0005c783          	lbu	a5,0(a1)
    1a58:	0585                	addi	a1,a1,1
    1a5a:	0075f713          	andi	a4,a1,7
    1a5e:	00f50023          	sb	a5,0(a0)
    1a62:	f3fd                	bnez	a5,1a48 <strncpy+0x16>
    1a64:	4805                	li	a6,1
    1a66:	1a061863          	bnez	a2,1c16 <strncpy+0x1e4>
    1a6a:	40a007b3          	neg	a5,a0
    1a6e:	8b9d                	andi	a5,a5,7
    1a70:	4681                	li	a3,0
    1a72:	18061a63          	bnez	a2,1c06 <strncpy+0x1d4>
    1a76:	00778713          	addi	a4,a5,7
    1a7a:	45ad                	li	a1,11
    1a7c:	18b76363          	bltu	a4,a1,1c02 <strncpy+0x1d0>
    1a80:	1ae6eb63          	bltu	a3,a4,1c36 <strncpy+0x204>
    1a84:	1a078363          	beqz	a5,1c2a <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a88:	00050023          	sb	zero,0(a0)
    1a8c:	4685                	li	a3,1
    1a8e:	00150713          	addi	a4,a0,1
    1a92:	18d78f63          	beq	a5,a3,1c30 <strncpy+0x1fe>
    1a96:	000500a3          	sb	zero,1(a0)
    1a9a:	4689                	li	a3,2
    1a9c:	00250713          	addi	a4,a0,2
    1aa0:	18d78e63          	beq	a5,a3,1c3c <strncpy+0x20a>
    1aa4:	00050123          	sb	zero,2(a0)
    1aa8:	468d                	li	a3,3
    1aaa:	00350713          	addi	a4,a0,3
    1aae:	16d78c63          	beq	a5,a3,1c26 <strncpy+0x1f4>
    1ab2:	000501a3          	sb	zero,3(a0)
    1ab6:	4691                	li	a3,4
    1ab8:	00450713          	addi	a4,a0,4
    1abc:	18d78263          	beq	a5,a3,1c40 <strncpy+0x20e>
    1ac0:	00050223          	sb	zero,4(a0)
    1ac4:	4695                	li	a3,5
    1ac6:	00550713          	addi	a4,a0,5
    1aca:	16d78d63          	beq	a5,a3,1c44 <strncpy+0x212>
    1ace:	000502a3          	sb	zero,5(a0)
    1ad2:	469d                	li	a3,7
    1ad4:	00650713          	addi	a4,a0,6
    1ad8:	16d79863          	bne	a5,a3,1c48 <strncpy+0x216>
    1adc:	00750713          	addi	a4,a0,7
    1ae0:	00050323          	sb	zero,6(a0)
    1ae4:	40f80833          	sub	a6,a6,a5
    1ae8:	ff887593          	andi	a1,a6,-8
    1aec:	97aa                	add	a5,a5,a0
    1aee:	95be                	add	a1,a1,a5
    1af0:	0007b023          	sd	zero,0(a5)
    1af4:	07a1                	addi	a5,a5,8
    1af6:	feb79de3          	bne	a5,a1,1af0 <strncpy+0xbe>
    1afa:	ff887593          	andi	a1,a6,-8
    1afe:	9ead                	addw	a3,a3,a1
    1b00:	00b707b3          	add	a5,a4,a1
    1b04:	12b80863          	beq	a6,a1,1c34 <strncpy+0x202>
    1b08:	00078023          	sb	zero,0(a5)
    1b0c:	0016871b          	addiw	a4,a3,1
    1b10:	0ec77863          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b14:	000780a3          	sb	zero,1(a5)
    1b18:	0026871b          	addiw	a4,a3,2
    1b1c:	0ec77263          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b20:	00078123          	sb	zero,2(a5)
    1b24:	0036871b          	addiw	a4,a3,3
    1b28:	0cc77c63          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b2c:	000781a3          	sb	zero,3(a5)
    1b30:	0046871b          	addiw	a4,a3,4
    1b34:	0cc77663          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b38:	00078223          	sb	zero,4(a5)
    1b3c:	0056871b          	addiw	a4,a3,5
    1b40:	0cc77063          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b44:	000782a3          	sb	zero,5(a5)
    1b48:	0066871b          	addiw	a4,a3,6
    1b4c:	0ac77a63          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b50:	00078323          	sb	zero,6(a5)
    1b54:	0076871b          	addiw	a4,a3,7
    1b58:	0ac77463          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b5c:	000783a3          	sb	zero,7(a5)
    1b60:	0086871b          	addiw	a4,a3,8
    1b64:	08c77e63          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b68:	00078423          	sb	zero,8(a5)
    1b6c:	0096871b          	addiw	a4,a3,9
    1b70:	08c77863          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b74:	000784a3          	sb	zero,9(a5)
    1b78:	00a6871b          	addiw	a4,a3,10
    1b7c:	08c77263          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b80:	00078523          	sb	zero,10(a5)
    1b84:	00b6871b          	addiw	a4,a3,11
    1b88:	06c77c63          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b8c:	000785a3          	sb	zero,11(a5)
    1b90:	00c6871b          	addiw	a4,a3,12
    1b94:	06c77663          	bgeu	a4,a2,1c00 <strncpy+0x1ce>
    1b98:	00078623          	sb	zero,12(a5)
    1b9c:	26b5                	addiw	a3,a3,13
    1b9e:	06c6f163          	bgeu	a3,a2,1c00 <strncpy+0x1ce>
    1ba2:	000786a3          	sb	zero,13(a5)
    1ba6:	8082                	ret
            ;
        if (!n || !*s)
    1ba8:	c645                	beqz	a2,1c50 <strncpy+0x21e>
    1baa:	0005c783          	lbu	a5,0(a1)
    1bae:	ea078be3          	beqz	a5,1a64 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bb2:	479d                	li	a5,7
    1bb4:	02c7ff63          	bgeu	a5,a2,1bf2 <strncpy+0x1c0>
    1bb8:	00000897          	auipc	a7,0x0
    1bbc:	3a88b883          	ld	a7,936(a7) # 1f60 <__clone+0x98>
    1bc0:	00000817          	auipc	a6,0x0
    1bc4:	3a883803          	ld	a6,936(a6) # 1f68 <__clone+0xa0>
    1bc8:	431d                	li	t1,7
    1bca:	6198                	ld	a4,0(a1)
    1bcc:	011707b3          	add	a5,a4,a7
    1bd0:	fff74693          	not	a3,a4
    1bd4:	8ff5                	and	a5,a5,a3
    1bd6:	0107f7b3          	and	a5,a5,a6
    1bda:	ef81                	bnez	a5,1bf2 <strncpy+0x1c0>
            *wd = *ws;
    1bdc:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bde:	1661                	addi	a2,a2,-8
    1be0:	05a1                	addi	a1,a1,8
    1be2:	0521                	addi	a0,a0,8
    1be4:	fec363e3          	bltu	t1,a2,1bca <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1be8:	e609                	bnez	a2,1bf2 <strncpy+0x1c0>
    1bea:	a08d                	j	1c4c <strncpy+0x21a>
    1bec:	167d                	addi	a2,a2,-1
    1bee:	0505                	addi	a0,a0,1
    1bf0:	ca01                	beqz	a2,1c00 <strncpy+0x1ce>
    1bf2:	0005c783          	lbu	a5,0(a1)
    1bf6:	0585                	addi	a1,a1,1
    1bf8:	00f50023          	sb	a5,0(a0)
    1bfc:	fbe5                	bnez	a5,1bec <strncpy+0x1ba>
        ;
tail:
    1bfe:	b59d                	j	1a64 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c00:	8082                	ret
    1c02:	472d                	li	a4,11
    1c04:	bdb5                	j	1a80 <strncpy+0x4e>
    1c06:	00778713          	addi	a4,a5,7
    1c0a:	45ad                	li	a1,11
    1c0c:	fff60693          	addi	a3,a2,-1
    1c10:	e6b778e3          	bgeu	a4,a1,1a80 <strncpy+0x4e>
    1c14:	b7fd                	j	1c02 <strncpy+0x1d0>
    1c16:	40a007b3          	neg	a5,a0
    1c1a:	8832                	mv	a6,a2
    1c1c:	8b9d                	andi	a5,a5,7
    1c1e:	4681                	li	a3,0
    1c20:	e4060be3          	beqz	a2,1a76 <strncpy+0x44>
    1c24:	b7cd                	j	1c06 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c26:	468d                	li	a3,3
    1c28:	bd75                	j	1ae4 <strncpy+0xb2>
    1c2a:	872a                	mv	a4,a0
    1c2c:	4681                	li	a3,0
    1c2e:	bd5d                	j	1ae4 <strncpy+0xb2>
    1c30:	4685                	li	a3,1
    1c32:	bd4d                	j	1ae4 <strncpy+0xb2>
    1c34:	8082                	ret
    1c36:	87aa                	mv	a5,a0
    1c38:	4681                	li	a3,0
    1c3a:	b5f9                	j	1b08 <strncpy+0xd6>
    1c3c:	4689                	li	a3,2
    1c3e:	b55d                	j	1ae4 <strncpy+0xb2>
    1c40:	4691                	li	a3,4
    1c42:	b54d                	j	1ae4 <strncpy+0xb2>
    1c44:	4695                	li	a3,5
    1c46:	bd79                	j	1ae4 <strncpy+0xb2>
    1c48:	4699                	li	a3,6
    1c4a:	bd69                	j	1ae4 <strncpy+0xb2>
    1c4c:	8082                	ret
    1c4e:	8082                	ret
    1c50:	8082                	ret

0000000000001c52 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c52:	87aa                	mv	a5,a0
    1c54:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c56:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c5a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c5e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c60:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c62:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c66:	2501                	sext.w	a0,a0
    1c68:	8082                	ret

0000000000001c6a <openat>:
    register long a7 __asm__("a7") = n;
    1c6a:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c6e:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c72:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c76:	2501                	sext.w	a0,a0
    1c78:	8082                	ret

0000000000001c7a <close>:
    register long a7 __asm__("a7") = n;
    1c7a:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c7e:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c82:	2501                	sext.w	a0,a0
    1c84:	8082                	ret

0000000000001c86 <read>:
    register long a7 __asm__("a7") = n;
    1c86:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c8a:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c8e:	8082                	ret

0000000000001c90 <write>:
    register long a7 __asm__("a7") = n;
    1c90:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c94:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c98:	8082                	ret

0000000000001c9a <getpid>:
    register long a7 __asm__("a7") = n;
    1c9a:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c9e:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1ca2:	2501                	sext.w	a0,a0
    1ca4:	8082                	ret

0000000000001ca6 <getppid>:
    register long a7 __asm__("a7") = n;
    1ca6:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1caa:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cae:	2501                	sext.w	a0,a0
    1cb0:	8082                	ret

0000000000001cb2 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cb2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cb6:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cba:	2501                	sext.w	a0,a0
    1cbc:	8082                	ret

0000000000001cbe <fork>:
    register long a7 __asm__("a7") = n;
    1cbe:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cc2:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cc4:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cc6:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cca:	2501                	sext.w	a0,a0
    1ccc:	8082                	ret

0000000000001cce <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cce:	85b2                	mv	a1,a2
    1cd0:	863a                	mv	a2,a4
    if (stack)
    1cd2:	c191                	beqz	a1,1cd6 <clone+0x8>
	stack += stack_size;
    1cd4:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cd6:	4781                	li	a5,0
    1cd8:	4701                	li	a4,0
    1cda:	4681                	li	a3,0
    1cdc:	2601                	sext.w	a2,a2
    1cde:	a2ed                	j	1ec8 <__clone>

0000000000001ce0 <exit>:
    register long a7 __asm__("a7") = n;
    1ce0:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1ce4:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1ce8:	8082                	ret

0000000000001cea <waitpid>:
    register long a7 __asm__("a7") = n;
    1cea:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cee:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cf0:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cf4:	2501                	sext.w	a0,a0
    1cf6:	8082                	ret

0000000000001cf8 <exec>:
    register long a7 __asm__("a7") = n;
    1cf8:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cfc:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d00:	2501                	sext.w	a0,a0
    1d02:	8082                	ret

0000000000001d04 <execve>:
    register long a7 __asm__("a7") = n;
    1d04:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d08:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d0c:	2501                	sext.w	a0,a0
    1d0e:	8082                	ret

0000000000001d10 <times>:
    register long a7 __asm__("a7") = n;
    1d10:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d14:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d18:	2501                	sext.w	a0,a0
    1d1a:	8082                	ret

0000000000001d1c <get_time>:

int64 get_time()
{
    1d1c:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d1e:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d22:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d24:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d26:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d2a:	2501                	sext.w	a0,a0
    1d2c:	ed09                	bnez	a0,1d46 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d2e:	67a2                	ld	a5,8(sp)
    1d30:	3e800713          	li	a4,1000
    1d34:	00015503          	lhu	a0,0(sp)
    1d38:	02e7d7b3          	divu	a5,a5,a4
    1d3c:	02e50533          	mul	a0,a0,a4
    1d40:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d42:	0141                	addi	sp,sp,16
    1d44:	8082                	ret
        return -1;
    1d46:	557d                	li	a0,-1
    1d48:	bfed                	j	1d42 <get_time+0x26>

0000000000001d4a <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d4a:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d4e:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d52:	2501                	sext.w	a0,a0
    1d54:	8082                	ret

0000000000001d56 <time>:
    register long a7 __asm__("a7") = n;
    1d56:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d5a:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d5e:	2501                	sext.w	a0,a0
    1d60:	8082                	ret

0000000000001d62 <sleep>:

int sleep(unsigned long long time)
{
    1d62:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d64:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d66:	850a                	mv	a0,sp
    1d68:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d6a:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d6e:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d70:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d74:	e501                	bnez	a0,1d7c <sleep+0x1a>
    return 0;
    1d76:	4501                	li	a0,0
}
    1d78:	0141                	addi	sp,sp,16
    1d7a:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d7c:	4502                	lw	a0,0(sp)
}
    1d7e:	0141                	addi	sp,sp,16
    1d80:	8082                	ret

0000000000001d82 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d82:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d86:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d8a:	2501                	sext.w	a0,a0
    1d8c:	8082                	ret

0000000000001d8e <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d8e:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d92:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d96:	8082                	ret

0000000000001d98 <munmap>:
    register long a7 __asm__("a7") = n;
    1d98:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d9c:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1da0:	2501                	sext.w	a0,a0
    1da2:	8082                	ret

0000000000001da4 <wait>:

int wait(int *code)
{
    1da4:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1da6:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1daa:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1dac:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dae:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1db0:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1db4:	2501                	sext.w	a0,a0
    1db6:	8082                	ret

0000000000001db8 <spawn>:
    register long a7 __asm__("a7") = n;
    1db8:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dbc:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dc0:	2501                	sext.w	a0,a0
    1dc2:	8082                	ret

0000000000001dc4 <mailread>:
    register long a7 __asm__("a7") = n;
    1dc4:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dc8:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dcc:	2501                	sext.w	a0,a0
    1dce:	8082                	ret

0000000000001dd0 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dd0:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dd4:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dd8:	2501                	sext.w	a0,a0
    1dda:	8082                	ret

0000000000001ddc <fstat>:
    register long a7 __asm__("a7") = n;
    1ddc:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1de0:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1de4:	2501                	sext.w	a0,a0
    1de6:	8082                	ret

0000000000001de8 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1de8:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dea:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dee:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1df0:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1df4:	2501                	sext.w	a0,a0
    1df6:	8082                	ret

0000000000001df8 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1df8:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1dfa:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1dfe:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e00:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e04:	2501                	sext.w	a0,a0
    1e06:	8082                	ret

0000000000001e08 <link>:

int link(char *old_path, char *new_path)
{
    1e08:	87aa                	mv	a5,a0
    1e0a:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e0c:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e10:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e14:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e16:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e1a:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e1c:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e20:	2501                	sext.w	a0,a0
    1e22:	8082                	ret

0000000000001e24 <unlink>:

int unlink(char *path)
{
    1e24:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e26:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e2a:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e2e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e30:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e34:	2501                	sext.w	a0,a0
    1e36:	8082                	ret

0000000000001e38 <uname>:
    register long a7 __asm__("a7") = n;
    1e38:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e3c:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e40:	2501                	sext.w	a0,a0
    1e42:	8082                	ret

0000000000001e44 <brk>:
    register long a7 __asm__("a7") = n;
    1e44:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e48:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e4c:	2501                	sext.w	a0,a0
    1e4e:	8082                	ret

0000000000001e50 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e50:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e52:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e56:	8082                	ret

0000000000001e58 <chdir>:
    register long a7 __asm__("a7") = n;
    1e58:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e5c:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e60:	2501                	sext.w	a0,a0
    1e62:	8082                	ret

0000000000001e64 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e64:	862e                	mv	a2,a1
    1e66:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e68:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e6a:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e6e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e72:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e74:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e76:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e7a:	2501                	sext.w	a0,a0
    1e7c:	8082                	ret

0000000000001e7e <getdents>:
    register long a7 __asm__("a7") = n;
    1e7e:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e82:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e86:	2501                	sext.w	a0,a0
    1e88:	8082                	ret

0000000000001e8a <pipe>:
    register long a7 __asm__("a7") = n;
    1e8a:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e8e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e90:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e94:	2501                	sext.w	a0,a0
    1e96:	8082                	ret

0000000000001e98 <dup>:
    register long a7 __asm__("a7") = n;
    1e98:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e9a:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e9e:	2501                	sext.w	a0,a0
    1ea0:	8082                	ret

0000000000001ea2 <dup2>:
    register long a7 __asm__("a7") = n;
    1ea2:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ea4:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ea6:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1eaa:	2501                	sext.w	a0,a0
    1eac:	8082                	ret

0000000000001eae <mount>:
    register long a7 __asm__("a7") = n;
    1eae:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1eb2:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1eb6:	2501                	sext.w	a0,a0
    1eb8:	8082                	ret

0000000000001eba <umount>:
    register long a7 __asm__("a7") = n;
    1eba:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ebe:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ec0:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ec4:	2501                	sext.w	a0,a0
    1ec6:	8082                	ret

0000000000001ec8 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ec8:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1eca:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ecc:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ece:	8532                	mv	a0,a2
	mv a2, a4
    1ed0:	863a                	mv	a2,a4
	mv a3, a5
    1ed2:	86be                	mv	a3,a5
	mv a4, a6
    1ed4:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ed6:	0dc00893          	li	a7,220
	ecall
    1eda:	00000073          	ecall

	beqz a0, 1f
    1ede:	c111                	beqz	a0,1ee2 <__clone+0x1a>
	# Parent
	ret
    1ee0:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ee2:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ee4:	6522                	ld	a0,8(sp)
	jalr a1
    1ee6:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ee8:	05d00893          	li	a7,93
	ecall
    1eec:	00000073          	ecall
