
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/write:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a851                	j	1096 <__start_main>

0000000000001004 <test_write>:
#include "unistd.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

void test_write(){
    1004:	1141                	addi	sp,sp,-16
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	ed250513          	addi	a0,a0,-302 # 1ed8 <__clone+0x2a>
void test_write(){
    100e:	e406                	sd	ra,8(sp)
    1010:	e022                	sd	s0,0(sp)
	TEST_START(__func__);
    1012:	2f6000ef          	jal	1308 <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	f6250513          	addi	a0,a0,-158 # 1f78 <__func__.0>
    101e:	2ea000ef          	jal	1308 <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	ece50513          	addi	a0,a0,-306 # 1ef0 <__clone+0x42>
    102a:	2de000ef          	jal	1308 <puts>
	const char *str = "Hello operating system contest.\n";
	int str_len = strlen(str);
    102e:	00001517          	auipc	a0,0x1
    1032:	ed250513          	addi	a0,a0,-302 # 1f00 <__clone+0x52>
    1036:	05d000ef          	jal	1892 <strlen>
    103a:	0005041b          	sext.w	s0,a0
	assert(write(STDOUT, str, str_len) == str_len);
    103e:	8622                	mv	a2,s0
    1040:	00001597          	auipc	a1,0x1
    1044:	ec058593          	addi	a1,a1,-320 # 1f00 <__clone+0x52>
    1048:	4505                	li	a0,1
    104a:	42d000ef          	jal	1c76 <write>
    104e:	00850863          	beq	a0,s0,105e <test_write+0x5a>
    1052:	00001517          	auipc	a0,0x1
    1056:	ed650513          	addi	a0,a0,-298 # 1f28 <__clone+0x7a>
    105a:	55a000ef          	jal	15b4 <panic>
	TEST_END(__func__);
    105e:	00001517          	auipc	a0,0x1
    1062:	eea50513          	addi	a0,a0,-278 # 1f48 <__clone+0x9a>
    1066:	2a2000ef          	jal	1308 <puts>
    106a:	00001517          	auipc	a0,0x1
    106e:	f0e50513          	addi	a0,a0,-242 # 1f78 <__func__.0>
    1072:	296000ef          	jal	1308 <puts>
}
    1076:	6402                	ld	s0,0(sp)
    1078:	60a2                	ld	ra,8(sp)
	TEST_END(__func__);
    107a:	00001517          	auipc	a0,0x1
    107e:	e7650513          	addi	a0,a0,-394 # 1ef0 <__clone+0x42>
}
    1082:	0141                	addi	sp,sp,16
	TEST_END(__func__);
    1084:	a451                	j	1308 <puts>

0000000000001086 <main>:

int main(void) {
    1086:	1141                	addi	sp,sp,-16
    1088:	e406                	sd	ra,8(sp)
	test_write();
    108a:	f7bff0ef          	jal	1004 <test_write>
	return 0;
}
    108e:	60a2                	ld	ra,8(sp)
    1090:	4501                	li	a0,0
    1092:	0141                	addi	sp,sp,16
    1094:	8082                	ret

0000000000001096 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    1096:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    1098:	4108                	lw	a0,0(a0)
{
    109a:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    109c:	05a1                	addi	a1,a1,8
{
    109e:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10a0:	fe7ff0ef          	jal	1086 <main>
    10a4:	423000ef          	jal	1cc6 <exit>
	return 0;
}
    10a8:	60a2                	ld	ra,8(sp)
    10aa:	4501                	li	a0,0
    10ac:	0141                	addi	sp,sp,16
    10ae:	8082                	ret

00000000000010b0 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10b0:	7179                	addi	sp,sp,-48
    10b2:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10b4:	12054b63          	bltz	a0,11ea <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10b8:	02b577bb          	remuw	a5,a0,a1
    10bc:	00001617          	auipc	a2,0x1
    10c0:	ecc60613          	addi	a2,a2,-308 # 1f88 <digits>
    buf[16] = 0;
    10c4:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10c8:	0005871b          	sext.w	a4,a1
    10cc:	1782                	slli	a5,a5,0x20
    10ce:	9381                	srli	a5,a5,0x20
    10d0:	97b2                	add	a5,a5,a2
    10d2:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10d6:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10da:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10de:	1cb56363          	bltu	a0,a1,12a4 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    10e2:	45b9                	li	a1,14
    10e4:	02e877bb          	remuw	a5,a6,a4
    10e8:	1782                	slli	a5,a5,0x20
    10ea:	9381                	srli	a5,a5,0x20
    10ec:	97b2                	add	a5,a5,a2
    10ee:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10f2:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    10f6:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    10fa:	0ce86e63          	bltu	a6,a4,11d6 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    10fe:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1102:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    1106:	1582                	slli	a1,a1,0x20
    1108:	9181                	srli	a1,a1,0x20
    110a:	95b2                	add	a1,a1,a2
    110c:	0005c583          	lbu	a1,0(a1)
    1110:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    1114:	0007859b          	sext.w	a1,a5
    1118:	12e6ec63          	bltu	a3,a4,1250 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    111c:	02e7f6bb          	remuw	a3,a5,a4
    1120:	1682                	slli	a3,a3,0x20
    1122:	9281                	srli	a3,a3,0x20
    1124:	96b2                	add	a3,a3,a2
    1126:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    112a:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    112e:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1132:	12e5e863          	bltu	a1,a4,1262 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    1136:	02e876bb          	remuw	a3,a6,a4
    113a:	1682                	slli	a3,a3,0x20
    113c:	9281                	srli	a3,a3,0x20
    113e:	96b2                	add	a3,a3,a2
    1140:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1144:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1148:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    114c:	12e86463          	bltu	a6,a4,1274 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1150:	02e5f6bb          	remuw	a3,a1,a4
    1154:	1682                	slli	a3,a3,0x20
    1156:	9281                	srli	a3,a3,0x20
    1158:	96b2                	add	a3,a3,a2
    115a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    115e:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1162:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    1166:	0ce5ec63          	bltu	a1,a4,123e <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    116a:	02e876bb          	remuw	a3,a6,a4
    116e:	1682                	slli	a3,a3,0x20
    1170:	9281                	srli	a3,a3,0x20
    1172:	96b2                	add	a3,a3,a2
    1174:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1178:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    117c:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    1180:	10e86963          	bltu	a6,a4,1292 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    1184:	02e5f6bb          	remuw	a3,a1,a4
    1188:	1682                	slli	a3,a3,0x20
    118a:	9281                	srli	a3,a3,0x20
    118c:	96b2                	add	a3,a3,a2
    118e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1192:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1196:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    119a:	10e5e763          	bltu	a1,a4,12a8 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    119e:	02e876bb          	remuw	a3,a6,a4
    11a2:	1682                	slli	a3,a3,0x20
    11a4:	9281                	srli	a3,a3,0x20
    11a6:	96b2                	add	a3,a3,a2
    11a8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11ac:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11b0:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11b4:	10e86363          	bltu	a6,a4,12ba <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11b8:	1782                	slli	a5,a5,0x20
    11ba:	9381                	srli	a5,a5,0x20
    11bc:	97b2                	add	a5,a5,a2
    11be:	0007c783          	lbu	a5,0(a5)
    11c2:	4599                	li	a1,6
    11c4:	00f10723          	sb	a5,14(sp)

    if (sign)
    11c8:	00055763          	bgez	a0,11d6 <printint.constprop.0+0x126>
        buf[i--] = '-';
    11cc:	02d00793          	li	a5,45
    11d0:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11d4:	4595                	li	a1,5
    write(f, s, l);
    11d6:	003c                	addi	a5,sp,8
    11d8:	4641                	li	a2,16
    11da:	9e0d                	subw	a2,a2,a1
    11dc:	4505                	li	a0,1
    11de:	95be                	add	a1,a1,a5
    11e0:	297000ef          	jal	1c76 <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11e4:	70a2                	ld	ra,40(sp)
    11e6:	6145                	addi	sp,sp,48
    11e8:	8082                	ret
        x = -xx;
    11ea:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    11ee:	02b877bb          	remuw	a5,a6,a1
    11f2:	00001617          	auipc	a2,0x1
    11f6:	d9660613          	addi	a2,a2,-618 # 1f88 <digits>
    buf[16] = 0;
    11fa:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    11fe:	0005871b          	sext.w	a4,a1
    1202:	1782                	slli	a5,a5,0x20
    1204:	9381                	srli	a5,a5,0x20
    1206:	97b2                	add	a5,a5,a2
    1208:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    120c:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1210:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1214:	06b86963          	bltu	a6,a1,1286 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1218:	02e8f7bb          	remuw	a5,a7,a4
    121c:	1782                	slli	a5,a5,0x20
    121e:	9381                	srli	a5,a5,0x20
    1220:	97b2                	add	a5,a5,a2
    1222:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1226:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    122a:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    122e:	ece8f8e3          	bgeu	a7,a4,10fe <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1232:	02d00793          	li	a5,45
    1236:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    123a:	45b5                	li	a1,13
    123c:	bf69                	j	11d6 <printint.constprop.0+0x126>
    123e:	45a9                	li	a1,10
    if (sign)
    1240:	f8055be3          	bgez	a0,11d6 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1244:	02d00793          	li	a5,45
    1248:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    124c:	45a5                	li	a1,9
    124e:	b761                	j	11d6 <printint.constprop.0+0x126>
    1250:	45b5                	li	a1,13
    if (sign)
    1252:	f80552e3          	bgez	a0,11d6 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1256:	02d00793          	li	a5,45
    125a:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    125e:	45b1                	li	a1,12
    1260:	bf9d                	j	11d6 <printint.constprop.0+0x126>
    1262:	45b1                	li	a1,12
    if (sign)
    1264:	f60559e3          	bgez	a0,11d6 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1268:	02d00793          	li	a5,45
    126c:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    1270:	45ad                	li	a1,11
    1272:	b795                	j	11d6 <printint.constprop.0+0x126>
    1274:	45ad                	li	a1,11
    if (sign)
    1276:	f60550e3          	bgez	a0,11d6 <printint.constprop.0+0x126>
        buf[i--] = '-';
    127a:	02d00793          	li	a5,45
    127e:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    1282:	45a9                	li	a1,10
    1284:	bf89                	j	11d6 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1286:	02d00793          	li	a5,45
    128a:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    128e:	45b9                	li	a1,14
    1290:	b799                	j	11d6 <printint.constprop.0+0x126>
    1292:	45a5                	li	a1,9
    if (sign)
    1294:	f40551e3          	bgez	a0,11d6 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1298:	02d00793          	li	a5,45
    129c:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12a0:	45a1                	li	a1,8
    12a2:	bf15                	j	11d6 <printint.constprop.0+0x126>
    i = 15;
    12a4:	45bd                	li	a1,15
    12a6:	bf05                	j	11d6 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12a8:	45a1                	li	a1,8
    if (sign)
    12aa:	f20556e3          	bgez	a0,11d6 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12ae:	02d00793          	li	a5,45
    12b2:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12b6:	459d                	li	a1,7
    12b8:	bf39                	j	11d6 <printint.constprop.0+0x126>
    12ba:	459d                	li	a1,7
    if (sign)
    12bc:	f0055de3          	bgez	a0,11d6 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c0:	02d00793          	li	a5,45
    12c4:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12c8:	4599                	li	a1,6
    12ca:	b731                	j	11d6 <printint.constprop.0+0x126>

00000000000012cc <getchar>:
{
    12cc:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12ce:	00f10593          	addi	a1,sp,15
    12d2:	4605                	li	a2,1
    12d4:	4501                	li	a0,0
{
    12d6:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12d8:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12dc:	191000ef          	jal	1c6c <read>
}
    12e0:	60e2                	ld	ra,24(sp)
    12e2:	00f14503          	lbu	a0,15(sp)
    12e6:	6105                	addi	sp,sp,32
    12e8:	8082                	ret

00000000000012ea <putchar>:
{
    12ea:	1101                	addi	sp,sp,-32
    12ec:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    12ee:	00f10593          	addi	a1,sp,15
    12f2:	4605                	li	a2,1
    12f4:	4505                	li	a0,1
{
    12f6:	ec06                	sd	ra,24(sp)
    char byte = c;
    12f8:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12fc:	17b000ef          	jal	1c76 <write>
}
    1300:	60e2                	ld	ra,24(sp)
    1302:	2501                	sext.w	a0,a0
    1304:	6105                	addi	sp,sp,32
    1306:	8082                	ret

0000000000001308 <puts>:
{
    1308:	1141                	addi	sp,sp,-16
    130a:	e406                	sd	ra,8(sp)
    130c:	e022                	sd	s0,0(sp)
    130e:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1310:	582000ef          	jal	1892 <strlen>
    1314:	862a                	mv	a2,a0
    1316:	85a2                	mv	a1,s0
    1318:	4505                	li	a0,1
    131a:	15d000ef          	jal	1c76 <write>
}
    131e:	60a2                	ld	ra,8(sp)
    1320:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1322:	957d                	srai	a0,a0,0x3f
    return r;
    1324:	2501                	sext.w	a0,a0
}
    1326:	0141                	addi	sp,sp,16
    1328:	8082                	ret

000000000000132a <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    132a:	7131                	addi	sp,sp,-192
    132c:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    132e:	013c                	addi	a5,sp,136
{
    1330:	f0ca                	sd	s2,96(sp)
    1332:	ecce                	sd	s3,88(sp)
    1334:	e8d2                	sd	s4,80(sp)
    1336:	e4d6                	sd	s5,72(sp)
    1338:	e0da                	sd	s6,64(sp)
    133a:	fc5e                	sd	s7,56(sp)
    133c:	fc86                	sd	ra,120(sp)
    133e:	f8a2                	sd	s0,112(sp)
    1340:	f4a6                	sd	s1,104(sp)
    1342:	e52e                	sd	a1,136(sp)
    1344:	e932                	sd	a2,144(sp)
    1346:	ed36                	sd	a3,152(sp)
    1348:	f13a                	sd	a4,160(sp)
    134a:	f942                	sd	a6,176(sp)
    134c:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    134e:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1350:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    1354:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1358:	00001b97          	auipc	s7,0x1
    135c:	c00b8b93          	addi	s7,s7,-1024 # 1f58 <__clone+0xaa>
        switch (s[1])
    1360:	07800a93          	li	s5,120
    1364:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1368:	00001997          	auipc	s3,0x1
    136c:	c2098993          	addi	s3,s3,-992 # 1f88 <digits>
        if (!*s)
    1370:	00054783          	lbu	a5,0(a0)
    1374:	16078c63          	beqz	a5,14ec <printf+0x1c2>
    1378:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    137a:	19278463          	beq	a5,s2,1502 <printf+0x1d8>
    137e:	00164783          	lbu	a5,1(a2)
    1382:	0605                	addi	a2,a2,1
    1384:	fbfd                	bnez	a5,137a <printf+0x50>
    1386:	84b2                	mv	s1,a2
        l = z - a;
    1388:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    138c:	85aa                	mv	a1,a0
    138e:	8622                	mv	a2,s0
    1390:	4505                	li	a0,1
    1392:	0e5000ef          	jal	1c76 <write>
        if (l)
    1396:	18041f63          	bnez	s0,1534 <printf+0x20a>
        if (s[1] == 0)
    139a:	0014c783          	lbu	a5,1(s1)
    139e:	14078763          	beqz	a5,14ec <printf+0x1c2>
        switch (s[1])
    13a2:	1d478163          	beq	a5,s4,1564 <printf+0x23a>
    13a6:	18fa6963          	bltu	s4,a5,1538 <printf+0x20e>
    13aa:	1b678363          	beq	a5,s6,1550 <printf+0x226>
    13ae:	07000713          	li	a4,112
    13b2:	1ce79c63          	bne	a5,a4,158a <printf+0x260>
            printptr(va_arg(ap, uint64));
    13b6:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13b8:	03000793          	li	a5,48
    13bc:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13c0:	631c                	ld	a5,0(a4)
    13c2:	0721                	addi	a4,a4,8
    13c4:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13c6:	00479f93          	slli	t6,a5,0x4
    13ca:	00879f13          	slli	t5,a5,0x8
    13ce:	00c79e93          	slli	t4,a5,0xc
    13d2:	01079e13          	slli	t3,a5,0x10
    13d6:	01479313          	slli	t1,a5,0x14
    13da:	01879893          	slli	a7,a5,0x18
    13de:	01c79713          	slli	a4,a5,0x1c
    13e2:	02479813          	slli	a6,a5,0x24
    13e6:	02879513          	slli	a0,a5,0x28
    13ea:	02c79593          	slli	a1,a5,0x2c
    13ee:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13f2:	03c7d293          	srli	t0,a5,0x3c
    13f6:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13fa:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13fe:	03cfdf93          	srli	t6,t6,0x3c
    1402:	03cf5f13          	srli	t5,t5,0x3c
    1406:	03cede93          	srli	t4,t4,0x3c
    140a:	03ce5e13          	srli	t3,t3,0x3c
    140e:	03c35313          	srli	t1,t1,0x3c
    1412:	03c8d893          	srli	a7,a7,0x3c
    1416:	9371                	srli	a4,a4,0x3c
    1418:	03c85813          	srli	a6,a6,0x3c
    141c:	9171                	srli	a0,a0,0x3c
    141e:	91f1                	srli	a1,a1,0x3c
    1420:	9271                	srli	a2,a2,0x3c
    1422:	974e                	add	a4,a4,s3
    1424:	92f1                	srli	a3,a3,0x3c
    1426:	92ce                	add	t0,t0,s3
    1428:	9fce                	add	t6,t6,s3
    142a:	9f4e                	add	t5,t5,s3
    142c:	9ece                	add	t4,t4,s3
    142e:	9e4e                	add	t3,t3,s3
    1430:	934e                	add	t1,t1,s3
    1432:	98ce                	add	a7,a7,s3
    1434:	93ce                	add	t2,t2,s3
    1436:	984e                	add	a6,a6,s3
    1438:	954e                	add	a0,a0,s3
    143a:	95ce                	add	a1,a1,s3
    143c:	964e                	add	a2,a2,s3
    143e:	0002c283          	lbu	t0,0(t0)
    1442:	000fcf83          	lbu	t6,0(t6)
    1446:	000f4f03          	lbu	t5,0(t5)
    144a:	000ece83          	lbu	t4,0(t4)
    144e:	000e4e03          	lbu	t3,0(t3)
    1452:	00034303          	lbu	t1,0(t1)
    1456:	0008c883          	lbu	a7,0(a7)
    145a:	00074403          	lbu	s0,0(a4)
    145e:	0003c383          	lbu	t2,0(t2)
    1462:	00084803          	lbu	a6,0(a6)
    1466:	00054503          	lbu	a0,0(a0)
    146a:	0005c583          	lbu	a1,0(a1)
    146e:	00064603          	lbu	a2,0(a2)
    1472:	00d98733          	add	a4,s3,a3
    1476:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    147a:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    147e:	9371                	srli	a4,a4,0x3c
    1480:	8bbd                	andi	a5,a5,15
    1482:	00510523          	sb	t0,10(sp)
    1486:	01f105a3          	sb	t6,11(sp)
    148a:	01e10623          	sb	t5,12(sp)
    148e:	01d106a3          	sb	t4,13(sp)
    1492:	01c10723          	sb	t3,14(sp)
    1496:	006107a3          	sb	t1,15(sp)
    149a:	01110823          	sb	a7,16(sp)
    149e:	00710923          	sb	t2,18(sp)
    14a2:	010109a3          	sb	a6,19(sp)
    14a6:	00a10a23          	sb	a0,20(sp)
    14aa:	00b10aa3          	sb	a1,21(sp)
    14ae:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14b2:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14b6:	008108a3          	sb	s0,17(sp)
    14ba:	974e                	add	a4,a4,s3
    14bc:	97ce                	add	a5,a5,s3
    14be:	00d10ba3          	sb	a3,23(sp)
    14c2:	00074703          	lbu	a4,0(a4)
    14c6:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14ca:	4649                	li	a2,18
    14cc:	002c                	addi	a1,sp,8
    14ce:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14d0:	00e10c23          	sb	a4,24(sp)
    14d4:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14d8:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14dc:	79a000ef          	jal	1c76 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14e0:	00248513          	addi	a0,s1,2
        if (!*s)
    14e4:	00054783          	lbu	a5,0(a0)
    14e8:	e80798e3          	bnez	a5,1378 <printf+0x4e>
    }
    va_end(ap);
}
    14ec:	70e6                	ld	ra,120(sp)
    14ee:	7446                	ld	s0,112(sp)
    14f0:	74a6                	ld	s1,104(sp)
    14f2:	7906                	ld	s2,96(sp)
    14f4:	69e6                	ld	s3,88(sp)
    14f6:	6a46                	ld	s4,80(sp)
    14f8:	6aa6                	ld	s5,72(sp)
    14fa:	6b06                	ld	s6,64(sp)
    14fc:	7be2                	ld	s7,56(sp)
    14fe:	6129                	addi	sp,sp,192
    1500:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1502:	00064783          	lbu	a5,0(a2)
    1506:	84b2                	mv	s1,a2
    1508:	01278963          	beq	a5,s2,151a <printf+0x1f0>
    150c:	bdb5                	j	1388 <printf+0x5e>
    150e:	0024c783          	lbu	a5,2(s1)
    1512:	0605                	addi	a2,a2,1
    1514:	0489                	addi	s1,s1,2
    1516:	e72799e3          	bne	a5,s2,1388 <printf+0x5e>
    151a:	0014c783          	lbu	a5,1(s1)
    151e:	ff2788e3          	beq	a5,s2,150e <printf+0x1e4>
        l = z - a;
    1522:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1526:	85aa                	mv	a1,a0
    1528:	8622                	mv	a2,s0
    152a:	4505                	li	a0,1
    152c:	74a000ef          	jal	1c76 <write>
        if (l)
    1530:	e60405e3          	beqz	s0,139a <printf+0x70>
    1534:	8526                	mv	a0,s1
    1536:	bd2d                	j	1370 <printf+0x46>
        switch (s[1])
    1538:	05579963          	bne	a5,s5,158a <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    153c:	6782                	ld	a5,0(sp)
    153e:	45c1                	li	a1,16
    1540:	4388                	lw	a0,0(a5)
    1542:	07a1                	addi	a5,a5,8
    1544:	e03e                	sd	a5,0(sp)
    1546:	b6bff0ef          	jal	10b0 <printint.constprop.0>
        s += 2;
    154a:	00248513          	addi	a0,s1,2
    154e:	bf59                	j	14e4 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1550:	6782                	ld	a5,0(sp)
    1552:	45a9                	li	a1,10
    1554:	4388                	lw	a0,0(a5)
    1556:	07a1                	addi	a5,a5,8
    1558:	e03e                	sd	a5,0(sp)
    155a:	b57ff0ef          	jal	10b0 <printint.constprop.0>
        s += 2;
    155e:	00248513          	addi	a0,s1,2
    1562:	b749                	j	14e4 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1564:	6782                	ld	a5,0(sp)
    1566:	6380                	ld	s0,0(a5)
    1568:	07a1                	addi	a5,a5,8
    156a:	e03e                	sd	a5,0(sp)
    156c:	c031                	beqz	s0,15b0 <printf+0x286>
            l = strnlen(a, 200);
    156e:	0c800593          	li	a1,200
    1572:	8522                	mv	a0,s0
    1574:	40a000ef          	jal	197e <strnlen>
    write(f, s, l);
    1578:	0005061b          	sext.w	a2,a0
    157c:	85a2                	mv	a1,s0
    157e:	4505                	li	a0,1
    1580:	6f6000ef          	jal	1c76 <write>
        s += 2;
    1584:	00248513          	addi	a0,s1,2
    1588:	bfb1                	j	14e4 <printf+0x1ba>
    return write(stdout, &byte, 1);
    158a:	4605                	li	a2,1
    158c:	002c                	addi	a1,sp,8
    158e:	4505                	li	a0,1
    char byte = c;
    1590:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    1594:	6e2000ef          	jal	1c76 <write>
    char byte = c;
    1598:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    159c:	4605                	li	a2,1
    159e:	002c                	addi	a1,sp,8
    15a0:	4505                	li	a0,1
    char byte = c;
    15a2:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15a6:	6d0000ef          	jal	1c76 <write>
        s += 2;
    15aa:	00248513          	addi	a0,s1,2
    15ae:	bf1d                	j	14e4 <printf+0x1ba>
                a = "(null)";
    15b0:	845e                	mv	s0,s7
    15b2:	bf75                	j	156e <printf+0x244>

00000000000015b4 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15b4:	1141                	addi	sp,sp,-16
    15b6:	e406                	sd	ra,8(sp)
    puts(m);
    15b8:	d51ff0ef          	jal	1308 <puts>
    exit(-100);
}
    15bc:	60a2                	ld	ra,8(sp)
    exit(-100);
    15be:	f9c00513          	li	a0,-100
}
    15c2:	0141                	addi	sp,sp,16
    exit(-100);
    15c4:	a709                	j	1cc6 <exit>

00000000000015c6 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15c6:	02000793          	li	a5,32
    15ca:	00f50663          	beq	a0,a5,15d6 <isspace+0x10>
    15ce:	355d                	addiw	a0,a0,-9
    15d0:	00553513          	sltiu	a0,a0,5
    15d4:	8082                	ret
    15d6:	4505                	li	a0,1
}
    15d8:	8082                	ret

00000000000015da <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15da:	fd05051b          	addiw	a0,a0,-48
}
    15de:	00a53513          	sltiu	a0,a0,10
    15e2:	8082                	ret

00000000000015e4 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15e4:	02000613          	li	a2,32
    15e8:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15ea:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15ee:	ff77069b          	addiw	a3,a4,-9
    15f2:	04c70d63          	beq	a4,a2,164c <atoi+0x68>
    15f6:	0007079b          	sext.w	a5,a4
    15fa:	04d5f963          	bgeu	a1,a3,164c <atoi+0x68>
        s++;
    switch (*s)
    15fe:	02b00693          	li	a3,43
    1602:	04d70a63          	beq	a4,a3,1656 <atoi+0x72>
    1606:	02d00693          	li	a3,45
    160a:	06d70463          	beq	a4,a3,1672 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    160e:	fd07859b          	addiw	a1,a5,-48
    1612:	4625                	li	a2,9
    1614:	873e                	mv	a4,a5
    1616:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1618:	4e01                	li	t3,0
    while (isdigit(*s))
    161a:	04b66a63          	bltu	a2,a1,166e <atoi+0x8a>
    int n = 0, neg = 0;
    161e:	4501                	li	a0,0
    while (isdigit(*s))
    1620:	4825                	li	a6,9
    1622:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1626:	0025179b          	slliw	a5,a0,0x2
    162a:	9d3d                	addw	a0,a0,a5
    162c:	fd07031b          	addiw	t1,a4,-48
    1630:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1634:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1638:	0685                	addi	a3,a3,1
    163a:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    163e:	0006071b          	sext.w	a4,a2
    1642:	feb870e3          	bgeu	a6,a1,1622 <atoi+0x3e>
    return neg ? n : -n;
    1646:	000e0563          	beqz	t3,1650 <atoi+0x6c>
}
    164a:	8082                	ret
        s++;
    164c:	0505                	addi	a0,a0,1
    164e:	bf71                	j	15ea <atoi+0x6>
    return neg ? n : -n;
    1650:	4113053b          	subw	a0,t1,a7
    1654:	8082                	ret
    while (isdigit(*s))
    1656:	00154783          	lbu	a5,1(a0)
    165a:	4625                	li	a2,9
        s++;
    165c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1660:	fd07859b          	addiw	a1,a5,-48
    1664:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1668:	4e01                	li	t3,0
    while (isdigit(*s))
    166a:	fab67ae3          	bgeu	a2,a1,161e <atoi+0x3a>
    166e:	4501                	li	a0,0
}
    1670:	8082                	ret
    while (isdigit(*s))
    1672:	00154783          	lbu	a5,1(a0)
    1676:	4625                	li	a2,9
        s++;
    1678:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    167c:	fd07859b          	addiw	a1,a5,-48
    1680:	0007871b          	sext.w	a4,a5
    1684:	feb665e3          	bltu	a2,a1,166e <atoi+0x8a>
        neg = 1;
    1688:	4e05                	li	t3,1
    168a:	bf51                	j	161e <atoi+0x3a>

000000000000168c <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    168c:	16060d63          	beqz	a2,1806 <memset+0x17a>
    1690:	40a007b3          	neg	a5,a0
    1694:	8b9d                	andi	a5,a5,7
    1696:	00778713          	addi	a4,a5,7
    169a:	482d                	li	a6,11
    169c:	0ff5f593          	zext.b	a1,a1
    16a0:	fff60693          	addi	a3,a2,-1
    16a4:	17076263          	bltu	a4,a6,1808 <memset+0x17c>
    16a8:	16e6ea63          	bltu	a3,a4,181c <memset+0x190>
    16ac:	16078563          	beqz	a5,1816 <memset+0x18a>
    16b0:	00b50023          	sb	a1,0(a0)
    16b4:	4705                	li	a4,1
    16b6:	00150e93          	addi	t4,a0,1
    16ba:	14e78c63          	beq	a5,a4,1812 <memset+0x186>
    16be:	00b500a3          	sb	a1,1(a0)
    16c2:	4709                	li	a4,2
    16c4:	00250e93          	addi	t4,a0,2
    16c8:	14e78d63          	beq	a5,a4,1822 <memset+0x196>
    16cc:	00b50123          	sb	a1,2(a0)
    16d0:	470d                	li	a4,3
    16d2:	00350e93          	addi	t4,a0,3
    16d6:	12e78b63          	beq	a5,a4,180c <memset+0x180>
    16da:	00b501a3          	sb	a1,3(a0)
    16de:	4711                	li	a4,4
    16e0:	00450e93          	addi	t4,a0,4
    16e4:	14e78163          	beq	a5,a4,1826 <memset+0x19a>
    16e8:	00b50223          	sb	a1,4(a0)
    16ec:	4715                	li	a4,5
    16ee:	00550e93          	addi	t4,a0,5
    16f2:	12e78c63          	beq	a5,a4,182a <memset+0x19e>
    16f6:	00b502a3          	sb	a1,5(a0)
    16fa:	471d                	li	a4,7
    16fc:	00650e93          	addi	t4,a0,6
    1700:	12e79763          	bne	a5,a4,182e <memset+0x1a2>
    1704:	00750e93          	addi	t4,a0,7
    1708:	00b50323          	sb	a1,6(a0)
    170c:	4f1d                	li	t5,7
    170e:	00859713          	slli	a4,a1,0x8
    1712:	8f4d                	or	a4,a4,a1
    1714:	01059e13          	slli	t3,a1,0x10
    1718:	01c76e33          	or	t3,a4,t3
    171c:	01859313          	slli	t1,a1,0x18
    1720:	006e6333          	or	t1,t3,t1
    1724:	02059893          	slli	a7,a1,0x20
    1728:	011368b3          	or	a7,t1,a7
    172c:	02859813          	slli	a6,a1,0x28
    1730:	40f60333          	sub	t1,a2,a5
    1734:	0108e833          	or	a6,a7,a6
    1738:	03059693          	slli	a3,a1,0x30
    173c:	00d866b3          	or	a3,a6,a3
    1740:	03859713          	slli	a4,a1,0x38
    1744:	97aa                	add	a5,a5,a0
    1746:	ff837813          	andi	a6,t1,-8
    174a:	8f55                	or	a4,a4,a3
    174c:	00f806b3          	add	a3,a6,a5
    1750:	e398                	sd	a4,0(a5)
    1752:	07a1                	addi	a5,a5,8
    1754:	fed79ee3          	bne	a5,a3,1750 <memset+0xc4>
    1758:	ff837693          	andi	a3,t1,-8
    175c:	00de87b3          	add	a5,t4,a3
    1760:	01e6873b          	addw	a4,a3,t5
    1764:	0ad30663          	beq	t1,a3,1810 <memset+0x184>
    1768:	00b78023          	sb	a1,0(a5)
    176c:	0017069b          	addiw	a3,a4,1
    1770:	08c6fb63          	bgeu	a3,a2,1806 <memset+0x17a>
    1774:	00b780a3          	sb	a1,1(a5)
    1778:	0027069b          	addiw	a3,a4,2
    177c:	08c6f563          	bgeu	a3,a2,1806 <memset+0x17a>
    1780:	00b78123          	sb	a1,2(a5)
    1784:	0037069b          	addiw	a3,a4,3
    1788:	06c6ff63          	bgeu	a3,a2,1806 <memset+0x17a>
    178c:	00b781a3          	sb	a1,3(a5)
    1790:	0047069b          	addiw	a3,a4,4
    1794:	06c6f963          	bgeu	a3,a2,1806 <memset+0x17a>
    1798:	00b78223          	sb	a1,4(a5)
    179c:	0057069b          	addiw	a3,a4,5
    17a0:	06c6f363          	bgeu	a3,a2,1806 <memset+0x17a>
    17a4:	00b782a3          	sb	a1,5(a5)
    17a8:	0067069b          	addiw	a3,a4,6
    17ac:	04c6fd63          	bgeu	a3,a2,1806 <memset+0x17a>
    17b0:	00b78323          	sb	a1,6(a5)
    17b4:	0077069b          	addiw	a3,a4,7
    17b8:	04c6f763          	bgeu	a3,a2,1806 <memset+0x17a>
    17bc:	00b783a3          	sb	a1,7(a5)
    17c0:	0087069b          	addiw	a3,a4,8
    17c4:	04c6f163          	bgeu	a3,a2,1806 <memset+0x17a>
    17c8:	00b78423          	sb	a1,8(a5)
    17cc:	0097069b          	addiw	a3,a4,9
    17d0:	02c6fb63          	bgeu	a3,a2,1806 <memset+0x17a>
    17d4:	00b784a3          	sb	a1,9(a5)
    17d8:	00a7069b          	addiw	a3,a4,10
    17dc:	02c6f563          	bgeu	a3,a2,1806 <memset+0x17a>
    17e0:	00b78523          	sb	a1,10(a5)
    17e4:	00b7069b          	addiw	a3,a4,11
    17e8:	00c6ff63          	bgeu	a3,a2,1806 <memset+0x17a>
    17ec:	00b785a3          	sb	a1,11(a5)
    17f0:	00c7069b          	addiw	a3,a4,12
    17f4:	00c6f963          	bgeu	a3,a2,1806 <memset+0x17a>
    17f8:	00b78623          	sb	a1,12(a5)
    17fc:	2735                	addiw	a4,a4,13
    17fe:	00c77463          	bgeu	a4,a2,1806 <memset+0x17a>
    1802:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1806:	8082                	ret
    1808:	472d                	li	a4,11
    180a:	bd79                	j	16a8 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    180c:	4f0d                	li	t5,3
    180e:	b701                	j	170e <memset+0x82>
    1810:	8082                	ret
    1812:	4f05                	li	t5,1
    1814:	bded                	j	170e <memset+0x82>
    1816:	8eaa                	mv	t4,a0
    1818:	4f01                	li	t5,0
    181a:	bdd5                	j	170e <memset+0x82>
    181c:	87aa                	mv	a5,a0
    181e:	4701                	li	a4,0
    1820:	b7a1                	j	1768 <memset+0xdc>
    1822:	4f09                	li	t5,2
    1824:	b5ed                	j	170e <memset+0x82>
    1826:	4f11                	li	t5,4
    1828:	b5dd                	j	170e <memset+0x82>
    182a:	4f15                	li	t5,5
    182c:	b5cd                	j	170e <memset+0x82>
    182e:	4f19                	li	t5,6
    1830:	bdf9                	j	170e <memset+0x82>

0000000000001832 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1832:	00054783          	lbu	a5,0(a0)
    1836:	0005c703          	lbu	a4,0(a1)
    183a:	00e79863          	bne	a5,a4,184a <strcmp+0x18>
    183e:	0505                	addi	a0,a0,1
    1840:	0585                	addi	a1,a1,1
    1842:	fbe5                	bnez	a5,1832 <strcmp>
    1844:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1846:	9d19                	subw	a0,a0,a4
    1848:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    184a:	0007851b          	sext.w	a0,a5
    184e:	bfe5                	j	1846 <strcmp+0x14>

0000000000001850 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1850:	ce05                	beqz	a2,1888 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1852:	00054703          	lbu	a4,0(a0)
    1856:	0005c783          	lbu	a5,0(a1)
    185a:	cb0d                	beqz	a4,188c <strncmp+0x3c>
    if (!n--)
    185c:	167d                	addi	a2,a2,-1
    185e:	00c506b3          	add	a3,a0,a2
    1862:	a819                	j	1878 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1864:	00a68e63          	beq	a3,a0,1880 <strncmp+0x30>
    1868:	0505                	addi	a0,a0,1
    186a:	00e79b63          	bne	a5,a4,1880 <strncmp+0x30>
    186e:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    1872:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1876:	cb19                	beqz	a4,188c <strncmp+0x3c>
    1878:	0005c783          	lbu	a5,0(a1)
    187c:	0585                	addi	a1,a1,1
    187e:	f3fd                	bnez	a5,1864 <strncmp+0x14>
    return *l - *r;
    1880:	0007051b          	sext.w	a0,a4
    1884:	9d1d                	subw	a0,a0,a5
    1886:	8082                	ret
        return 0;
    1888:	4501                	li	a0,0
}
    188a:	8082                	ret
    188c:	4501                	li	a0,0
    return *l - *r;
    188e:	9d1d                	subw	a0,a0,a5
    1890:	8082                	ret

0000000000001892 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    1892:	00757793          	andi	a5,a0,7
    1896:	cf89                	beqz	a5,18b0 <strlen+0x1e>
    1898:	87aa                	mv	a5,a0
    189a:	a029                	j	18a4 <strlen+0x12>
    189c:	0785                	addi	a5,a5,1
    189e:	0077f713          	andi	a4,a5,7
    18a2:	cb01                	beqz	a4,18b2 <strlen+0x20>
        if (!*s)
    18a4:	0007c703          	lbu	a4,0(a5)
    18a8:	fb75                	bnez	a4,189c <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18aa:	40a78533          	sub	a0,a5,a0
}
    18ae:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18b0:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18b2:	6394                	ld	a3,0(a5)
    18b4:	00000597          	auipc	a1,0x0
    18b8:	6ac5b583          	ld	a1,1708(a1) # 1f60 <__clone+0xb2>
    18bc:	00000617          	auipc	a2,0x0
    18c0:	6ac63603          	ld	a2,1708(a2) # 1f68 <__clone+0xba>
    18c4:	a019                	j	18ca <strlen+0x38>
    18c6:	6794                	ld	a3,8(a5)
    18c8:	07a1                	addi	a5,a5,8
    18ca:	00b68733          	add	a4,a3,a1
    18ce:	fff6c693          	not	a3,a3
    18d2:	8f75                	and	a4,a4,a3
    18d4:	8f71                	and	a4,a4,a2
    18d6:	db65                	beqz	a4,18c6 <strlen+0x34>
    for (; *s; s++)
    18d8:	0007c703          	lbu	a4,0(a5)
    18dc:	d779                	beqz	a4,18aa <strlen+0x18>
    18de:	0017c703          	lbu	a4,1(a5)
    18e2:	0785                	addi	a5,a5,1
    18e4:	d379                	beqz	a4,18aa <strlen+0x18>
    18e6:	0017c703          	lbu	a4,1(a5)
    18ea:	0785                	addi	a5,a5,1
    18ec:	fb6d                	bnez	a4,18de <strlen+0x4c>
    18ee:	bf75                	j	18aa <strlen+0x18>

00000000000018f0 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18f0:	00757713          	andi	a4,a0,7
{
    18f4:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18f6:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18fa:	cb19                	beqz	a4,1910 <memchr+0x20>
    18fc:	ce25                	beqz	a2,1974 <memchr+0x84>
    18fe:	0007c703          	lbu	a4,0(a5)
    1902:	04b70e63          	beq	a4,a1,195e <memchr+0x6e>
    1906:	0785                	addi	a5,a5,1
    1908:	0077f713          	andi	a4,a5,7
    190c:	167d                	addi	a2,a2,-1
    190e:	f77d                	bnez	a4,18fc <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1910:	4501                	li	a0,0
    if (n && *s != c)
    1912:	c235                	beqz	a2,1976 <memchr+0x86>
    1914:	0007c703          	lbu	a4,0(a5)
    1918:	04b70363          	beq	a4,a1,195e <memchr+0x6e>
        size_t k = ONES * c;
    191c:	00000517          	auipc	a0,0x0
    1920:	65453503          	ld	a0,1620(a0) # 1f70 <__clone+0xc2>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1924:	471d                	li	a4,7
        size_t k = ONES * c;
    1926:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    192a:	02c77a63          	bgeu	a4,a2,195e <memchr+0x6e>
    192e:	00000897          	auipc	a7,0x0
    1932:	6328b883          	ld	a7,1586(a7) # 1f60 <__clone+0xb2>
    1936:	00000817          	auipc	a6,0x0
    193a:	63283803          	ld	a6,1586(a6) # 1f68 <__clone+0xba>
    193e:	431d                	li	t1,7
    1940:	a029                	j	194a <memchr+0x5a>
    1942:	1661                	addi	a2,a2,-8
    1944:	07a1                	addi	a5,a5,8
    1946:	02c37963          	bgeu	t1,a2,1978 <memchr+0x88>
    194a:	6398                	ld	a4,0(a5)
    194c:	8f29                	xor	a4,a4,a0
    194e:	011706b3          	add	a3,a4,a7
    1952:	fff74713          	not	a4,a4
    1956:	8f75                	and	a4,a4,a3
    1958:	01077733          	and	a4,a4,a6
    195c:	d37d                	beqz	a4,1942 <memchr+0x52>
    195e:	853e                	mv	a0,a5
    1960:	97b2                	add	a5,a5,a2
    1962:	a021                	j	196a <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1964:	0505                	addi	a0,a0,1
    1966:	00f50763          	beq	a0,a5,1974 <memchr+0x84>
    196a:	00054703          	lbu	a4,0(a0)
    196e:	feb71be3          	bne	a4,a1,1964 <memchr+0x74>
    1972:	8082                	ret
    return n ? (void *)s : 0;
    1974:	4501                	li	a0,0
}
    1976:	8082                	ret
    return n ? (void *)s : 0;
    1978:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    197a:	f275                	bnez	a2,195e <memchr+0x6e>
}
    197c:	8082                	ret

000000000000197e <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    197e:	1101                	addi	sp,sp,-32
    1980:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1982:	862e                	mv	a2,a1
{
    1984:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1986:	4581                	li	a1,0
{
    1988:	e426                	sd	s1,8(sp)
    198a:	ec06                	sd	ra,24(sp)
    198c:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    198e:	f63ff0ef          	jal	18f0 <memchr>
    return p ? p - s : n;
    1992:	c519                	beqz	a0,19a0 <strnlen+0x22>
}
    1994:	60e2                	ld	ra,24(sp)
    1996:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1998:	8d05                	sub	a0,a0,s1
}
    199a:	64a2                	ld	s1,8(sp)
    199c:	6105                	addi	sp,sp,32
    199e:	8082                	ret
    19a0:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19a2:	8522                	mv	a0,s0
}
    19a4:	6442                	ld	s0,16(sp)
    19a6:	64a2                	ld	s1,8(sp)
    19a8:	6105                	addi	sp,sp,32
    19aa:	8082                	ret

00000000000019ac <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19ac:	00b547b3          	xor	a5,a0,a1
    19b0:	8b9d                	andi	a5,a5,7
    19b2:	eb95                	bnez	a5,19e6 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19b4:	0075f793          	andi	a5,a1,7
    19b8:	e7b1                	bnez	a5,1a04 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19ba:	6198                	ld	a4,0(a1)
    19bc:	00000617          	auipc	a2,0x0
    19c0:	5a463603          	ld	a2,1444(a2) # 1f60 <__clone+0xb2>
    19c4:	00000817          	auipc	a6,0x0
    19c8:	5a483803          	ld	a6,1444(a6) # 1f68 <__clone+0xba>
    19cc:	a029                	j	19d6 <strcpy+0x2a>
    19ce:	e118                	sd	a4,0(a0)
    19d0:	6598                	ld	a4,8(a1)
    19d2:	05a1                	addi	a1,a1,8
    19d4:	0521                	addi	a0,a0,8
    19d6:	00c707b3          	add	a5,a4,a2
    19da:	fff74693          	not	a3,a4
    19de:	8ff5                	and	a5,a5,a3
    19e0:	0107f7b3          	and	a5,a5,a6
    19e4:	d7ed                	beqz	a5,19ce <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19e6:	0005c783          	lbu	a5,0(a1)
    19ea:	00f50023          	sb	a5,0(a0)
    19ee:	c785                	beqz	a5,1a16 <strcpy+0x6a>
    19f0:	0015c783          	lbu	a5,1(a1)
    19f4:	0505                	addi	a0,a0,1
    19f6:	0585                	addi	a1,a1,1
    19f8:	00f50023          	sb	a5,0(a0)
    19fc:	fbf5                	bnez	a5,19f0 <strcpy+0x44>
        ;
    return d;
}
    19fe:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a00:	0505                	addi	a0,a0,1
    1a02:	df45                	beqz	a4,19ba <strcpy+0xe>
            if (!(*d = *s))
    1a04:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a08:	0585                	addi	a1,a1,1
    1a0a:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a0e:	00f50023          	sb	a5,0(a0)
    1a12:	f7fd                	bnez	a5,1a00 <strcpy+0x54>
}
    1a14:	8082                	ret
    1a16:	8082                	ret

0000000000001a18 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a18:	00b547b3          	xor	a5,a0,a1
    1a1c:	8b9d                	andi	a5,a5,7
    1a1e:	1a079863          	bnez	a5,1bce <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a22:	0075f793          	andi	a5,a1,7
    1a26:	16078463          	beqz	a5,1b8e <strncpy+0x176>
    1a2a:	ea01                	bnez	a2,1a3a <strncpy+0x22>
    1a2c:	a421                	j	1c34 <strncpy+0x21c>
    1a2e:	167d                	addi	a2,a2,-1
    1a30:	0505                	addi	a0,a0,1
    1a32:	14070e63          	beqz	a4,1b8e <strncpy+0x176>
    1a36:	1a060863          	beqz	a2,1be6 <strncpy+0x1ce>
    1a3a:	0005c783          	lbu	a5,0(a1)
    1a3e:	0585                	addi	a1,a1,1
    1a40:	0075f713          	andi	a4,a1,7
    1a44:	00f50023          	sb	a5,0(a0)
    1a48:	f3fd                	bnez	a5,1a2e <strncpy+0x16>
    1a4a:	4805                	li	a6,1
    1a4c:	1a061863          	bnez	a2,1bfc <strncpy+0x1e4>
    1a50:	40a007b3          	neg	a5,a0
    1a54:	8b9d                	andi	a5,a5,7
    1a56:	4681                	li	a3,0
    1a58:	18061a63          	bnez	a2,1bec <strncpy+0x1d4>
    1a5c:	00778713          	addi	a4,a5,7
    1a60:	45ad                	li	a1,11
    1a62:	18b76363          	bltu	a4,a1,1be8 <strncpy+0x1d0>
    1a66:	1ae6eb63          	bltu	a3,a4,1c1c <strncpy+0x204>
    1a6a:	1a078363          	beqz	a5,1c10 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a6e:	00050023          	sb	zero,0(a0)
    1a72:	4685                	li	a3,1
    1a74:	00150713          	addi	a4,a0,1
    1a78:	18d78f63          	beq	a5,a3,1c16 <strncpy+0x1fe>
    1a7c:	000500a3          	sb	zero,1(a0)
    1a80:	4689                	li	a3,2
    1a82:	00250713          	addi	a4,a0,2
    1a86:	18d78e63          	beq	a5,a3,1c22 <strncpy+0x20a>
    1a8a:	00050123          	sb	zero,2(a0)
    1a8e:	468d                	li	a3,3
    1a90:	00350713          	addi	a4,a0,3
    1a94:	16d78c63          	beq	a5,a3,1c0c <strncpy+0x1f4>
    1a98:	000501a3          	sb	zero,3(a0)
    1a9c:	4691                	li	a3,4
    1a9e:	00450713          	addi	a4,a0,4
    1aa2:	18d78263          	beq	a5,a3,1c26 <strncpy+0x20e>
    1aa6:	00050223          	sb	zero,4(a0)
    1aaa:	4695                	li	a3,5
    1aac:	00550713          	addi	a4,a0,5
    1ab0:	16d78d63          	beq	a5,a3,1c2a <strncpy+0x212>
    1ab4:	000502a3          	sb	zero,5(a0)
    1ab8:	469d                	li	a3,7
    1aba:	00650713          	addi	a4,a0,6
    1abe:	16d79863          	bne	a5,a3,1c2e <strncpy+0x216>
    1ac2:	00750713          	addi	a4,a0,7
    1ac6:	00050323          	sb	zero,6(a0)
    1aca:	40f80833          	sub	a6,a6,a5
    1ace:	ff887593          	andi	a1,a6,-8
    1ad2:	97aa                	add	a5,a5,a0
    1ad4:	95be                	add	a1,a1,a5
    1ad6:	0007b023          	sd	zero,0(a5)
    1ada:	07a1                	addi	a5,a5,8
    1adc:	feb79de3          	bne	a5,a1,1ad6 <strncpy+0xbe>
    1ae0:	ff887593          	andi	a1,a6,-8
    1ae4:	9ead                	addw	a3,a3,a1
    1ae6:	00b707b3          	add	a5,a4,a1
    1aea:	12b80863          	beq	a6,a1,1c1a <strncpy+0x202>
    1aee:	00078023          	sb	zero,0(a5)
    1af2:	0016871b          	addiw	a4,a3,1
    1af6:	0ec77863          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1afa:	000780a3          	sb	zero,1(a5)
    1afe:	0026871b          	addiw	a4,a3,2
    1b02:	0ec77263          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1b06:	00078123          	sb	zero,2(a5)
    1b0a:	0036871b          	addiw	a4,a3,3
    1b0e:	0cc77c63          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1b12:	000781a3          	sb	zero,3(a5)
    1b16:	0046871b          	addiw	a4,a3,4
    1b1a:	0cc77663          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1b1e:	00078223          	sb	zero,4(a5)
    1b22:	0056871b          	addiw	a4,a3,5
    1b26:	0cc77063          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1b2a:	000782a3          	sb	zero,5(a5)
    1b2e:	0066871b          	addiw	a4,a3,6
    1b32:	0ac77a63          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1b36:	00078323          	sb	zero,6(a5)
    1b3a:	0076871b          	addiw	a4,a3,7
    1b3e:	0ac77463          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1b42:	000783a3          	sb	zero,7(a5)
    1b46:	0086871b          	addiw	a4,a3,8
    1b4a:	08c77e63          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1b4e:	00078423          	sb	zero,8(a5)
    1b52:	0096871b          	addiw	a4,a3,9
    1b56:	08c77863          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1b5a:	000784a3          	sb	zero,9(a5)
    1b5e:	00a6871b          	addiw	a4,a3,10
    1b62:	08c77263          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1b66:	00078523          	sb	zero,10(a5)
    1b6a:	00b6871b          	addiw	a4,a3,11
    1b6e:	06c77c63          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1b72:	000785a3          	sb	zero,11(a5)
    1b76:	00c6871b          	addiw	a4,a3,12
    1b7a:	06c77663          	bgeu	a4,a2,1be6 <strncpy+0x1ce>
    1b7e:	00078623          	sb	zero,12(a5)
    1b82:	26b5                	addiw	a3,a3,13
    1b84:	06c6f163          	bgeu	a3,a2,1be6 <strncpy+0x1ce>
    1b88:	000786a3          	sb	zero,13(a5)
    1b8c:	8082                	ret
            ;
        if (!n || !*s)
    1b8e:	c645                	beqz	a2,1c36 <strncpy+0x21e>
    1b90:	0005c783          	lbu	a5,0(a1)
    1b94:	ea078be3          	beqz	a5,1a4a <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b98:	479d                	li	a5,7
    1b9a:	02c7ff63          	bgeu	a5,a2,1bd8 <strncpy+0x1c0>
    1b9e:	00000897          	auipc	a7,0x0
    1ba2:	3c28b883          	ld	a7,962(a7) # 1f60 <__clone+0xb2>
    1ba6:	00000817          	auipc	a6,0x0
    1baa:	3c283803          	ld	a6,962(a6) # 1f68 <__clone+0xba>
    1bae:	431d                	li	t1,7
    1bb0:	6198                	ld	a4,0(a1)
    1bb2:	011707b3          	add	a5,a4,a7
    1bb6:	fff74693          	not	a3,a4
    1bba:	8ff5                	and	a5,a5,a3
    1bbc:	0107f7b3          	and	a5,a5,a6
    1bc0:	ef81                	bnez	a5,1bd8 <strncpy+0x1c0>
            *wd = *ws;
    1bc2:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bc4:	1661                	addi	a2,a2,-8
    1bc6:	05a1                	addi	a1,a1,8
    1bc8:	0521                	addi	a0,a0,8
    1bca:	fec363e3          	bltu	t1,a2,1bb0 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bce:	e609                	bnez	a2,1bd8 <strncpy+0x1c0>
    1bd0:	a08d                	j	1c32 <strncpy+0x21a>
    1bd2:	167d                	addi	a2,a2,-1
    1bd4:	0505                	addi	a0,a0,1
    1bd6:	ca01                	beqz	a2,1be6 <strncpy+0x1ce>
    1bd8:	0005c783          	lbu	a5,0(a1)
    1bdc:	0585                	addi	a1,a1,1
    1bde:	00f50023          	sb	a5,0(a0)
    1be2:	fbe5                	bnez	a5,1bd2 <strncpy+0x1ba>
        ;
tail:
    1be4:	b59d                	j	1a4a <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1be6:	8082                	ret
    1be8:	472d                	li	a4,11
    1bea:	bdb5                	j	1a66 <strncpy+0x4e>
    1bec:	00778713          	addi	a4,a5,7
    1bf0:	45ad                	li	a1,11
    1bf2:	fff60693          	addi	a3,a2,-1
    1bf6:	e6b778e3          	bgeu	a4,a1,1a66 <strncpy+0x4e>
    1bfa:	b7fd                	j	1be8 <strncpy+0x1d0>
    1bfc:	40a007b3          	neg	a5,a0
    1c00:	8832                	mv	a6,a2
    1c02:	8b9d                	andi	a5,a5,7
    1c04:	4681                	li	a3,0
    1c06:	e4060be3          	beqz	a2,1a5c <strncpy+0x44>
    1c0a:	b7cd                	j	1bec <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c0c:	468d                	li	a3,3
    1c0e:	bd75                	j	1aca <strncpy+0xb2>
    1c10:	872a                	mv	a4,a0
    1c12:	4681                	li	a3,0
    1c14:	bd5d                	j	1aca <strncpy+0xb2>
    1c16:	4685                	li	a3,1
    1c18:	bd4d                	j	1aca <strncpy+0xb2>
    1c1a:	8082                	ret
    1c1c:	87aa                	mv	a5,a0
    1c1e:	4681                	li	a3,0
    1c20:	b5f9                	j	1aee <strncpy+0xd6>
    1c22:	4689                	li	a3,2
    1c24:	b55d                	j	1aca <strncpy+0xb2>
    1c26:	4691                	li	a3,4
    1c28:	b54d                	j	1aca <strncpy+0xb2>
    1c2a:	4695                	li	a3,5
    1c2c:	bd79                	j	1aca <strncpy+0xb2>
    1c2e:	4699                	li	a3,6
    1c30:	bd69                	j	1aca <strncpy+0xb2>
    1c32:	8082                	ret
    1c34:	8082                	ret
    1c36:	8082                	ret

0000000000001c38 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c38:	87aa                	mv	a5,a0
    1c3a:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c3c:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c40:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c44:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c46:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c48:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c4c:	2501                	sext.w	a0,a0
    1c4e:	8082                	ret

0000000000001c50 <openat>:
    register long a7 __asm__("a7") = n;
    1c50:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c54:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c58:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c5c:	2501                	sext.w	a0,a0
    1c5e:	8082                	ret

0000000000001c60 <close>:
    register long a7 __asm__("a7") = n;
    1c60:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c64:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c68:	2501                	sext.w	a0,a0
    1c6a:	8082                	ret

0000000000001c6c <read>:
    register long a7 __asm__("a7") = n;
    1c6c:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c70:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c74:	8082                	ret

0000000000001c76 <write>:
    register long a7 __asm__("a7") = n;
    1c76:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c7a:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c7e:	8082                	ret

0000000000001c80 <getpid>:
    register long a7 __asm__("a7") = n;
    1c80:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c84:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c88:	2501                	sext.w	a0,a0
    1c8a:	8082                	ret

0000000000001c8c <getppid>:
    register long a7 __asm__("a7") = n;
    1c8c:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c90:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c94:	2501                	sext.w	a0,a0
    1c96:	8082                	ret

0000000000001c98 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c98:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c9c:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1ca0:	2501                	sext.w	a0,a0
    1ca2:	8082                	ret

0000000000001ca4 <fork>:
    register long a7 __asm__("a7") = n;
    1ca4:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1ca8:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1caa:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cac:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cb0:	2501                	sext.w	a0,a0
    1cb2:	8082                	ret

0000000000001cb4 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cb4:	85b2                	mv	a1,a2
    1cb6:	863a                	mv	a2,a4
    if (stack)
    1cb8:	c191                	beqz	a1,1cbc <clone+0x8>
	stack += stack_size;
    1cba:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cbc:	4781                	li	a5,0
    1cbe:	4701                	li	a4,0
    1cc0:	4681                	li	a3,0
    1cc2:	2601                	sext.w	a2,a2
    1cc4:	a2ed                	j	1eae <__clone>

0000000000001cc6 <exit>:
    register long a7 __asm__("a7") = n;
    1cc6:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cca:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cce:	8082                	ret

0000000000001cd0 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cd0:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cd4:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cd6:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cda:	2501                	sext.w	a0,a0
    1cdc:	8082                	ret

0000000000001cde <exec>:
    register long a7 __asm__("a7") = n;
    1cde:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1ce2:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1ce6:	2501                	sext.w	a0,a0
    1ce8:	8082                	ret

0000000000001cea <execve>:
    register long a7 __asm__("a7") = n;
    1cea:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cee:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1cf2:	2501                	sext.w	a0,a0
    1cf4:	8082                	ret

0000000000001cf6 <times>:
    register long a7 __asm__("a7") = n;
    1cf6:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1cfa:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1cfe:	2501                	sext.w	a0,a0
    1d00:	8082                	ret

0000000000001d02 <get_time>:

int64 get_time()
{
    1d02:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d04:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d08:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d0a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d0c:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d10:	2501                	sext.w	a0,a0
    1d12:	ed09                	bnez	a0,1d2c <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d14:	67a2                	ld	a5,8(sp)
    1d16:	3e800713          	li	a4,1000
    1d1a:	00015503          	lhu	a0,0(sp)
    1d1e:	02e7d7b3          	divu	a5,a5,a4
    1d22:	02e50533          	mul	a0,a0,a4
    1d26:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d28:	0141                	addi	sp,sp,16
    1d2a:	8082                	ret
        return -1;
    1d2c:	557d                	li	a0,-1
    1d2e:	bfed                	j	1d28 <get_time+0x26>

0000000000001d30 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d30:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d34:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d38:	2501                	sext.w	a0,a0
    1d3a:	8082                	ret

0000000000001d3c <time>:
    register long a7 __asm__("a7") = n;
    1d3c:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d40:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d44:	2501                	sext.w	a0,a0
    1d46:	8082                	ret

0000000000001d48 <sleep>:

int sleep(unsigned long long time)
{
    1d48:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d4a:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d4c:	850a                	mv	a0,sp
    1d4e:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d50:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d54:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d56:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d5a:	e501                	bnez	a0,1d62 <sleep+0x1a>
    return 0;
    1d5c:	4501                	li	a0,0
}
    1d5e:	0141                	addi	sp,sp,16
    1d60:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d62:	4502                	lw	a0,0(sp)
}
    1d64:	0141                	addi	sp,sp,16
    1d66:	8082                	ret

0000000000001d68 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d68:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d6c:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d70:	2501                	sext.w	a0,a0
    1d72:	8082                	ret

0000000000001d74 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d74:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d78:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d7c:	8082                	ret

0000000000001d7e <munmap>:
    register long a7 __asm__("a7") = n;
    1d7e:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d82:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d86:	2501                	sext.w	a0,a0
    1d88:	8082                	ret

0000000000001d8a <wait>:

int wait(int *code)
{
    1d8a:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d8c:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d90:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d92:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d94:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d96:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1d9a:	2501                	sext.w	a0,a0
    1d9c:	8082                	ret

0000000000001d9e <spawn>:
    register long a7 __asm__("a7") = n;
    1d9e:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1da2:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1da6:	2501                	sext.w	a0,a0
    1da8:	8082                	ret

0000000000001daa <mailread>:
    register long a7 __asm__("a7") = n;
    1daa:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dae:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1db2:	2501                	sext.w	a0,a0
    1db4:	8082                	ret

0000000000001db6 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1db6:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dba:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dbe:	2501                	sext.w	a0,a0
    1dc0:	8082                	ret

0000000000001dc2 <fstat>:
    register long a7 __asm__("a7") = n;
    1dc2:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dc6:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dca:	2501                	sext.w	a0,a0
    1dcc:	8082                	ret

0000000000001dce <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dce:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dd0:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dd4:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dd6:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1dda:	2501                	sext.w	a0,a0
    1ddc:	8082                	ret

0000000000001dde <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1dde:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1de0:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1de4:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1de6:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1dea:	2501                	sext.w	a0,a0
    1dec:	8082                	ret

0000000000001dee <link>:

int link(char *old_path, char *new_path)
{
    1dee:	87aa                	mv	a5,a0
    1df0:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1df2:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1df6:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1dfa:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1dfc:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e00:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e02:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e06:	2501                	sext.w	a0,a0
    1e08:	8082                	ret

0000000000001e0a <unlink>:

int unlink(char *path)
{
    1e0a:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e0c:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e10:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e14:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e16:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e1a:	2501                	sext.w	a0,a0
    1e1c:	8082                	ret

0000000000001e1e <uname>:
    register long a7 __asm__("a7") = n;
    1e1e:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e22:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e26:	2501                	sext.w	a0,a0
    1e28:	8082                	ret

0000000000001e2a <brk>:
    register long a7 __asm__("a7") = n;
    1e2a:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e2e:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e32:	2501                	sext.w	a0,a0
    1e34:	8082                	ret

0000000000001e36 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e36:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e38:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e3c:	8082                	ret

0000000000001e3e <chdir>:
    register long a7 __asm__("a7") = n;
    1e3e:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e42:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e46:	2501                	sext.w	a0,a0
    1e48:	8082                	ret

0000000000001e4a <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e4a:	862e                	mv	a2,a1
    1e4c:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e4e:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e50:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e54:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e58:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e5a:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e5c:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e60:	2501                	sext.w	a0,a0
    1e62:	8082                	ret

0000000000001e64 <getdents>:
    register long a7 __asm__("a7") = n;
    1e64:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e68:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e6c:	2501                	sext.w	a0,a0
    1e6e:	8082                	ret

0000000000001e70 <pipe>:
    register long a7 __asm__("a7") = n;
    1e70:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e74:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e76:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e7a:	2501                	sext.w	a0,a0
    1e7c:	8082                	ret

0000000000001e7e <dup>:
    register long a7 __asm__("a7") = n;
    1e7e:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e80:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e84:	2501                	sext.w	a0,a0
    1e86:	8082                	ret

0000000000001e88 <dup2>:
    register long a7 __asm__("a7") = n;
    1e88:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e8a:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e8c:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e90:	2501                	sext.w	a0,a0
    1e92:	8082                	ret

0000000000001e94 <mount>:
    register long a7 __asm__("a7") = n;
    1e94:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e98:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1e9c:	2501                	sext.w	a0,a0
    1e9e:	8082                	ret

0000000000001ea0 <umount>:
    register long a7 __asm__("a7") = n;
    1ea0:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ea4:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ea6:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1eaa:	2501                	sext.w	a0,a0
    1eac:	8082                	ret

0000000000001eae <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1eae:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1eb0:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1eb2:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1eb4:	8532                	mv	a0,a2
	mv a2, a4
    1eb6:	863a                	mv	a2,a4
	mv a3, a5
    1eb8:	86be                	mv	a3,a5
	mv a4, a6
    1eba:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ebc:	0dc00893          	li	a7,220
	ecall
    1ec0:	00000073          	ecall

	beqz a0, 1f
    1ec4:	c111                	beqz	a0,1ec8 <__clone+0x1a>
	# Parent
	ret
    1ec6:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ec8:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1eca:	6522                	ld	a0,8(sp)
	jalr a1
    1ecc:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ece:	05d00893          	li	a7,93
	ecall
    1ed2:	00000073          	ecall
