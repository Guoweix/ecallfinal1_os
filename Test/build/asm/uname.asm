
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/uname:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a86d                	j	10bc <__start_main>

0000000000001004 <test_uname>:
	char domainname[65];
};

struct utsname un;

void test_uname() {
    1004:	1141                	addi	sp,sp,-16
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	efa50513          	addi	a0,a0,-262 # 1f00 <__clone+0x2c>
void test_uname() {
    100e:	e406                	sd	ra,8(sp)
	TEST_START(__func__);
    1010:	31e000ef          	jal	132e <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	10c50513          	addi	a0,a0,268 # 2120 <__func__.0>
    101c:	312000ef          	jal	132e <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ef850513          	addi	a0,a0,-264 # 1f18 <__clone+0x44>
    1028:	306000ef          	jal	132e <puts>
	int test_ret = uname(&un);
    102c:	00001517          	auipc	a0,0x1
    1030:	f6c50513          	addi	a0,a0,-148 # 1f98 <un>
    1034:	611000ef          	jal	1e44 <uname>
	assert(test_ret >= 0);
    1038:	06054363          	bltz	a0,109e <test_uname+0x9a>

	printf("Uname: %s %s %s %s %s %s\n", 
    103c:	00001817          	auipc	a6,0x1
    1040:	0a180813          	addi	a6,a6,161 # 20dd <un+0x145>
    1044:	00001797          	auipc	a5,0x1
    1048:	05878793          	addi	a5,a5,88 # 209c <un+0x104>
    104c:	00001717          	auipc	a4,0x1
    1050:	00f70713          	addi	a4,a4,15 # 205b <un+0xc3>
    1054:	00001697          	auipc	a3,0x1
    1058:	fc668693          	addi	a3,a3,-58 # 201a <un+0x82>
    105c:	00001617          	auipc	a2,0x1
    1060:	f7d60613          	addi	a2,a2,-131 # 1fd9 <un+0x41>
    1064:	00001597          	auipc	a1,0x1
    1068:	f3458593          	addi	a1,a1,-204 # 1f98 <un>
    106c:	00001517          	auipc	a0,0x1
    1070:	edc50513          	addi	a0,a0,-292 # 1f48 <__clone+0x74>
    1074:	2dc000ef          	jal	1350 <printf>
		un.sysname, un.nodename, un.release, un.version, un.machine, un.domainname);

	TEST_END(__func__);
    1078:	00001517          	auipc	a0,0x1
    107c:	ef050513          	addi	a0,a0,-272 # 1f68 <__clone+0x94>
    1080:	2ae000ef          	jal	132e <puts>
    1084:	00001517          	auipc	a0,0x1
    1088:	09c50513          	addi	a0,a0,156 # 2120 <__func__.0>
    108c:	2a2000ef          	jal	132e <puts>
}
    1090:	60a2                	ld	ra,8(sp)
	TEST_END(__func__);
    1092:	00001517          	auipc	a0,0x1
    1096:	e8650513          	addi	a0,a0,-378 # 1f18 <__clone+0x44>
}
    109a:	0141                	addi	sp,sp,16
	TEST_END(__func__);
    109c:	ac49                	j	132e <puts>
	assert(test_ret >= 0);
    109e:	00001517          	auipc	a0,0x1
    10a2:	e8a50513          	addi	a0,a0,-374 # 1f28 <__clone+0x54>
    10a6:	534000ef          	jal	15da <panic>
    10aa:	bf49                	j	103c <test_uname+0x38>

00000000000010ac <main>:

int main(void) {
    10ac:	1141                	addi	sp,sp,-16
    10ae:	e406                	sd	ra,8(sp)
	test_uname();
    10b0:	f55ff0ef          	jal	1004 <test_uname>
	return 0;
}
    10b4:	60a2                	ld	ra,8(sp)
    10b6:	4501                	li	a0,0
    10b8:	0141                	addi	sp,sp,16
    10ba:	8082                	ret

00000000000010bc <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10bc:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10be:	4108                	lw	a0,0(a0)
{
    10c0:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10c2:	05a1                	addi	a1,a1,8
{
    10c4:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10c6:	fe7ff0ef          	jal	10ac <main>
    10ca:	423000ef          	jal	1cec <exit>
	return 0;
}
    10ce:	60a2                	ld	ra,8(sp)
    10d0:	4501                	li	a0,0
    10d2:	0141                	addi	sp,sp,16
    10d4:	8082                	ret

00000000000010d6 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10d6:	7179                	addi	sp,sp,-48
    10d8:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10da:	12054b63          	bltz	a0,1210 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10de:	02b577bb          	remuw	a5,a0,a1
    10e2:	00001617          	auipc	a2,0x1
    10e6:	04e60613          	addi	a2,a2,78 # 2130 <digits>
    buf[16] = 0;
    10ea:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10ee:	0005871b          	sext.w	a4,a1
    10f2:	1782                	slli	a5,a5,0x20
    10f4:	9381                	srli	a5,a5,0x20
    10f6:	97b2                	add	a5,a5,a2
    10f8:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10fc:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1100:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1104:	1cb56363          	bltu	a0,a1,12ca <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    1108:	45b9                	li	a1,14
    110a:	02e877bb          	remuw	a5,a6,a4
    110e:	1782                	slli	a5,a5,0x20
    1110:	9381                	srli	a5,a5,0x20
    1112:	97b2                	add	a5,a5,a2
    1114:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1118:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    111c:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1120:	0ce86e63          	bltu	a6,a4,11fc <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1124:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1128:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    112c:	1582                	slli	a1,a1,0x20
    112e:	9181                	srli	a1,a1,0x20
    1130:	95b2                	add	a1,a1,a2
    1132:	0005c583          	lbu	a1,0(a1)
    1136:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    113a:	0007859b          	sext.w	a1,a5
    113e:	12e6ec63          	bltu	a3,a4,1276 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1142:	02e7f6bb          	remuw	a3,a5,a4
    1146:	1682                	slli	a3,a3,0x20
    1148:	9281                	srli	a3,a3,0x20
    114a:	96b2                	add	a3,a3,a2
    114c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1150:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1154:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1158:	12e5e863          	bltu	a1,a4,1288 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    115c:	02e876bb          	remuw	a3,a6,a4
    1160:	1682                	slli	a3,a3,0x20
    1162:	9281                	srli	a3,a3,0x20
    1164:	96b2                	add	a3,a3,a2
    1166:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    116a:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    116e:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1172:	12e86463          	bltu	a6,a4,129a <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1176:	02e5f6bb          	remuw	a3,a1,a4
    117a:	1682                	slli	a3,a3,0x20
    117c:	9281                	srli	a3,a3,0x20
    117e:	96b2                	add	a3,a3,a2
    1180:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1184:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1188:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    118c:	0ce5ec63          	bltu	a1,a4,1264 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    1190:	02e876bb          	remuw	a3,a6,a4
    1194:	1682                	slli	a3,a3,0x20
    1196:	9281                	srli	a3,a3,0x20
    1198:	96b2                	add	a3,a3,a2
    119a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    119e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11a2:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11a6:	10e86963          	bltu	a6,a4,12b8 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11aa:	02e5f6bb          	remuw	a3,a1,a4
    11ae:	1682                	slli	a3,a3,0x20
    11b0:	9281                	srli	a3,a3,0x20
    11b2:	96b2                	add	a3,a3,a2
    11b4:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11b8:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11bc:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11c0:	10e5e763          	bltu	a1,a4,12ce <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11c4:	02e876bb          	remuw	a3,a6,a4
    11c8:	1682                	slli	a3,a3,0x20
    11ca:	9281                	srli	a3,a3,0x20
    11cc:	96b2                	add	a3,a3,a2
    11ce:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11d2:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11d6:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11da:	10e86363          	bltu	a6,a4,12e0 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11de:	1782                	slli	a5,a5,0x20
    11e0:	9381                	srli	a5,a5,0x20
    11e2:	97b2                	add	a5,a5,a2
    11e4:	0007c783          	lbu	a5,0(a5)
    11e8:	4599                	li	a1,6
    11ea:	00f10723          	sb	a5,14(sp)

    if (sign)
    11ee:	00055763          	bgez	a0,11fc <printint.constprop.0+0x126>
        buf[i--] = '-';
    11f2:	02d00793          	li	a5,45
    11f6:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11fa:	4595                	li	a1,5
    write(f, s, l);
    11fc:	003c                	addi	a5,sp,8
    11fe:	4641                	li	a2,16
    1200:	9e0d                	subw	a2,a2,a1
    1202:	4505                	li	a0,1
    1204:	95be                	add	a1,a1,a5
    1206:	297000ef          	jal	1c9c <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    120a:	70a2                	ld	ra,40(sp)
    120c:	6145                	addi	sp,sp,48
    120e:	8082                	ret
        x = -xx;
    1210:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1214:	02b877bb          	remuw	a5,a6,a1
    1218:	00001617          	auipc	a2,0x1
    121c:	f1860613          	addi	a2,a2,-232 # 2130 <digits>
    buf[16] = 0;
    1220:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1224:	0005871b          	sext.w	a4,a1
    1228:	1782                	slli	a5,a5,0x20
    122a:	9381                	srli	a5,a5,0x20
    122c:	97b2                	add	a5,a5,a2
    122e:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1232:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1236:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    123a:	06b86963          	bltu	a6,a1,12ac <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    123e:	02e8f7bb          	remuw	a5,a7,a4
    1242:	1782                	slli	a5,a5,0x20
    1244:	9381                	srli	a5,a5,0x20
    1246:	97b2                	add	a5,a5,a2
    1248:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    124c:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1250:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1254:	ece8f8e3          	bgeu	a7,a4,1124 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1258:	02d00793          	li	a5,45
    125c:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1260:	45b5                	li	a1,13
    1262:	bf69                	j	11fc <printint.constprop.0+0x126>
    1264:	45a9                	li	a1,10
    if (sign)
    1266:	f8055be3          	bgez	a0,11fc <printint.constprop.0+0x126>
        buf[i--] = '-';
    126a:	02d00793          	li	a5,45
    126e:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1272:	45a5                	li	a1,9
    1274:	b761                	j	11fc <printint.constprop.0+0x126>
    1276:	45b5                	li	a1,13
    if (sign)
    1278:	f80552e3          	bgez	a0,11fc <printint.constprop.0+0x126>
        buf[i--] = '-';
    127c:	02d00793          	li	a5,45
    1280:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1284:	45b1                	li	a1,12
    1286:	bf9d                	j	11fc <printint.constprop.0+0x126>
    1288:	45b1                	li	a1,12
    if (sign)
    128a:	f60559e3          	bgez	a0,11fc <printint.constprop.0+0x126>
        buf[i--] = '-';
    128e:	02d00793          	li	a5,45
    1292:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    1296:	45ad                	li	a1,11
    1298:	b795                	j	11fc <printint.constprop.0+0x126>
    129a:	45ad                	li	a1,11
    if (sign)
    129c:	f60550e3          	bgez	a0,11fc <printint.constprop.0+0x126>
        buf[i--] = '-';
    12a0:	02d00793          	li	a5,45
    12a4:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12a8:	45a9                	li	a1,10
    12aa:	bf89                	j	11fc <printint.constprop.0+0x126>
        buf[i--] = '-';
    12ac:	02d00793          	li	a5,45
    12b0:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12b4:	45b9                	li	a1,14
    12b6:	b799                	j	11fc <printint.constprop.0+0x126>
    12b8:	45a5                	li	a1,9
    if (sign)
    12ba:	f40551e3          	bgez	a0,11fc <printint.constprop.0+0x126>
        buf[i--] = '-';
    12be:	02d00793          	li	a5,45
    12c2:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12c6:	45a1                	li	a1,8
    12c8:	bf15                	j	11fc <printint.constprop.0+0x126>
    i = 15;
    12ca:	45bd                	li	a1,15
    12cc:	bf05                	j	11fc <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12ce:	45a1                	li	a1,8
    if (sign)
    12d0:	f20556e3          	bgez	a0,11fc <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d4:	02d00793          	li	a5,45
    12d8:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12dc:	459d                	li	a1,7
    12de:	bf39                	j	11fc <printint.constprop.0+0x126>
    12e0:	459d                	li	a1,7
    if (sign)
    12e2:	f0055de3          	bgez	a0,11fc <printint.constprop.0+0x126>
        buf[i--] = '-';
    12e6:	02d00793          	li	a5,45
    12ea:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12ee:	4599                	li	a1,6
    12f0:	b731                	j	11fc <printint.constprop.0+0x126>

00000000000012f2 <getchar>:
{
    12f2:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12f4:	00f10593          	addi	a1,sp,15
    12f8:	4605                	li	a2,1
    12fa:	4501                	li	a0,0
{
    12fc:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12fe:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1302:	191000ef          	jal	1c92 <read>
}
    1306:	60e2                	ld	ra,24(sp)
    1308:	00f14503          	lbu	a0,15(sp)
    130c:	6105                	addi	sp,sp,32
    130e:	8082                	ret

0000000000001310 <putchar>:
{
    1310:	1101                	addi	sp,sp,-32
    1312:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1314:	00f10593          	addi	a1,sp,15
    1318:	4605                	li	a2,1
    131a:	4505                	li	a0,1
{
    131c:	ec06                	sd	ra,24(sp)
    char byte = c;
    131e:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1322:	17b000ef          	jal	1c9c <write>
}
    1326:	60e2                	ld	ra,24(sp)
    1328:	2501                	sext.w	a0,a0
    132a:	6105                	addi	sp,sp,32
    132c:	8082                	ret

000000000000132e <puts>:
{
    132e:	1141                	addi	sp,sp,-16
    1330:	e406                	sd	ra,8(sp)
    1332:	e022                	sd	s0,0(sp)
    1334:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1336:	582000ef          	jal	18b8 <strlen>
    133a:	862a                	mv	a2,a0
    133c:	85a2                	mv	a1,s0
    133e:	4505                	li	a0,1
    1340:	15d000ef          	jal	1c9c <write>
}
    1344:	60a2                	ld	ra,8(sp)
    1346:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1348:	957d                	srai	a0,a0,0x3f
    return r;
    134a:	2501                	sext.w	a0,a0
}
    134c:	0141                	addi	sp,sp,16
    134e:	8082                	ret

0000000000001350 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1350:	7131                	addi	sp,sp,-192
    1352:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1354:	013c                	addi	a5,sp,136
{
    1356:	f0ca                	sd	s2,96(sp)
    1358:	ecce                	sd	s3,88(sp)
    135a:	e8d2                	sd	s4,80(sp)
    135c:	e4d6                	sd	s5,72(sp)
    135e:	e0da                	sd	s6,64(sp)
    1360:	fc5e                	sd	s7,56(sp)
    1362:	fc86                	sd	ra,120(sp)
    1364:	f8a2                	sd	s0,112(sp)
    1366:	f4a6                	sd	s1,104(sp)
    1368:	e52e                	sd	a1,136(sp)
    136a:	e932                	sd	a2,144(sp)
    136c:	ed36                	sd	a3,152(sp)
    136e:	f13a                	sd	a4,160(sp)
    1370:	f942                	sd	a6,176(sp)
    1372:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1374:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1376:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    137a:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    137e:	00001b97          	auipc	s7,0x1
    1382:	bfab8b93          	addi	s7,s7,-1030 # 1f78 <__clone+0xa4>
        switch (s[1])
    1386:	07800a93          	li	s5,120
    138a:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    138e:	00001997          	auipc	s3,0x1
    1392:	da298993          	addi	s3,s3,-606 # 2130 <digits>
        if (!*s)
    1396:	00054783          	lbu	a5,0(a0)
    139a:	16078c63          	beqz	a5,1512 <printf+0x1c2>
    139e:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13a0:	19278463          	beq	a5,s2,1528 <printf+0x1d8>
    13a4:	00164783          	lbu	a5,1(a2)
    13a8:	0605                	addi	a2,a2,1
    13aa:	fbfd                	bnez	a5,13a0 <printf+0x50>
    13ac:	84b2                	mv	s1,a2
        l = z - a;
    13ae:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13b2:	85aa                	mv	a1,a0
    13b4:	8622                	mv	a2,s0
    13b6:	4505                	li	a0,1
    13b8:	0e5000ef          	jal	1c9c <write>
        if (l)
    13bc:	18041f63          	bnez	s0,155a <printf+0x20a>
        if (s[1] == 0)
    13c0:	0014c783          	lbu	a5,1(s1)
    13c4:	14078763          	beqz	a5,1512 <printf+0x1c2>
        switch (s[1])
    13c8:	1d478163          	beq	a5,s4,158a <printf+0x23a>
    13cc:	18fa6963          	bltu	s4,a5,155e <printf+0x20e>
    13d0:	1b678363          	beq	a5,s6,1576 <printf+0x226>
    13d4:	07000713          	li	a4,112
    13d8:	1ce79c63          	bne	a5,a4,15b0 <printf+0x260>
            printptr(va_arg(ap, uint64));
    13dc:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13de:	03000793          	li	a5,48
    13e2:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13e6:	631c                	ld	a5,0(a4)
    13e8:	0721                	addi	a4,a4,8
    13ea:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13ec:	00479f93          	slli	t6,a5,0x4
    13f0:	00879f13          	slli	t5,a5,0x8
    13f4:	00c79e93          	slli	t4,a5,0xc
    13f8:	01079e13          	slli	t3,a5,0x10
    13fc:	01479313          	slli	t1,a5,0x14
    1400:	01879893          	slli	a7,a5,0x18
    1404:	01c79713          	slli	a4,a5,0x1c
    1408:	02479813          	slli	a6,a5,0x24
    140c:	02879513          	slli	a0,a5,0x28
    1410:	02c79593          	slli	a1,a5,0x2c
    1414:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1418:	03c7d293          	srli	t0,a5,0x3c
    141c:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1420:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1424:	03cfdf93          	srli	t6,t6,0x3c
    1428:	03cf5f13          	srli	t5,t5,0x3c
    142c:	03cede93          	srli	t4,t4,0x3c
    1430:	03ce5e13          	srli	t3,t3,0x3c
    1434:	03c35313          	srli	t1,t1,0x3c
    1438:	03c8d893          	srli	a7,a7,0x3c
    143c:	9371                	srli	a4,a4,0x3c
    143e:	03c85813          	srli	a6,a6,0x3c
    1442:	9171                	srli	a0,a0,0x3c
    1444:	91f1                	srli	a1,a1,0x3c
    1446:	9271                	srli	a2,a2,0x3c
    1448:	974e                	add	a4,a4,s3
    144a:	92f1                	srli	a3,a3,0x3c
    144c:	92ce                	add	t0,t0,s3
    144e:	9fce                	add	t6,t6,s3
    1450:	9f4e                	add	t5,t5,s3
    1452:	9ece                	add	t4,t4,s3
    1454:	9e4e                	add	t3,t3,s3
    1456:	934e                	add	t1,t1,s3
    1458:	98ce                	add	a7,a7,s3
    145a:	93ce                	add	t2,t2,s3
    145c:	984e                	add	a6,a6,s3
    145e:	954e                	add	a0,a0,s3
    1460:	95ce                	add	a1,a1,s3
    1462:	964e                	add	a2,a2,s3
    1464:	0002c283          	lbu	t0,0(t0)
    1468:	000fcf83          	lbu	t6,0(t6)
    146c:	000f4f03          	lbu	t5,0(t5)
    1470:	000ece83          	lbu	t4,0(t4)
    1474:	000e4e03          	lbu	t3,0(t3)
    1478:	00034303          	lbu	t1,0(t1)
    147c:	0008c883          	lbu	a7,0(a7)
    1480:	00074403          	lbu	s0,0(a4)
    1484:	0003c383          	lbu	t2,0(t2)
    1488:	00084803          	lbu	a6,0(a6)
    148c:	00054503          	lbu	a0,0(a0)
    1490:	0005c583          	lbu	a1,0(a1)
    1494:	00064603          	lbu	a2,0(a2)
    1498:	00d98733          	add	a4,s3,a3
    149c:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14a0:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14a4:	9371                	srli	a4,a4,0x3c
    14a6:	8bbd                	andi	a5,a5,15
    14a8:	00510523          	sb	t0,10(sp)
    14ac:	01f105a3          	sb	t6,11(sp)
    14b0:	01e10623          	sb	t5,12(sp)
    14b4:	01d106a3          	sb	t4,13(sp)
    14b8:	01c10723          	sb	t3,14(sp)
    14bc:	006107a3          	sb	t1,15(sp)
    14c0:	01110823          	sb	a7,16(sp)
    14c4:	00710923          	sb	t2,18(sp)
    14c8:	010109a3          	sb	a6,19(sp)
    14cc:	00a10a23          	sb	a0,20(sp)
    14d0:	00b10aa3          	sb	a1,21(sp)
    14d4:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14d8:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14dc:	008108a3          	sb	s0,17(sp)
    14e0:	974e                	add	a4,a4,s3
    14e2:	97ce                	add	a5,a5,s3
    14e4:	00d10ba3          	sb	a3,23(sp)
    14e8:	00074703          	lbu	a4,0(a4)
    14ec:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14f0:	4649                	li	a2,18
    14f2:	002c                	addi	a1,sp,8
    14f4:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14f6:	00e10c23          	sb	a4,24(sp)
    14fa:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14fe:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1502:	79a000ef          	jal	1c9c <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    1506:	00248513          	addi	a0,s1,2
        if (!*s)
    150a:	00054783          	lbu	a5,0(a0)
    150e:	e80798e3          	bnez	a5,139e <printf+0x4e>
    }
    va_end(ap);
}
    1512:	70e6                	ld	ra,120(sp)
    1514:	7446                	ld	s0,112(sp)
    1516:	74a6                	ld	s1,104(sp)
    1518:	7906                	ld	s2,96(sp)
    151a:	69e6                	ld	s3,88(sp)
    151c:	6a46                	ld	s4,80(sp)
    151e:	6aa6                	ld	s5,72(sp)
    1520:	6b06                	ld	s6,64(sp)
    1522:	7be2                	ld	s7,56(sp)
    1524:	6129                	addi	sp,sp,192
    1526:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1528:	00064783          	lbu	a5,0(a2)
    152c:	84b2                	mv	s1,a2
    152e:	01278963          	beq	a5,s2,1540 <printf+0x1f0>
    1532:	bdb5                	j	13ae <printf+0x5e>
    1534:	0024c783          	lbu	a5,2(s1)
    1538:	0605                	addi	a2,a2,1
    153a:	0489                	addi	s1,s1,2
    153c:	e72799e3          	bne	a5,s2,13ae <printf+0x5e>
    1540:	0014c783          	lbu	a5,1(s1)
    1544:	ff2788e3          	beq	a5,s2,1534 <printf+0x1e4>
        l = z - a;
    1548:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    154c:	85aa                	mv	a1,a0
    154e:	8622                	mv	a2,s0
    1550:	4505                	li	a0,1
    1552:	74a000ef          	jal	1c9c <write>
        if (l)
    1556:	e60405e3          	beqz	s0,13c0 <printf+0x70>
    155a:	8526                	mv	a0,s1
    155c:	bd2d                	j	1396 <printf+0x46>
        switch (s[1])
    155e:	05579963          	bne	a5,s5,15b0 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1562:	6782                	ld	a5,0(sp)
    1564:	45c1                	li	a1,16
    1566:	4388                	lw	a0,0(a5)
    1568:	07a1                	addi	a5,a5,8
    156a:	e03e                	sd	a5,0(sp)
    156c:	b6bff0ef          	jal	10d6 <printint.constprop.0>
        s += 2;
    1570:	00248513          	addi	a0,s1,2
    1574:	bf59                	j	150a <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1576:	6782                	ld	a5,0(sp)
    1578:	45a9                	li	a1,10
    157a:	4388                	lw	a0,0(a5)
    157c:	07a1                	addi	a5,a5,8
    157e:	e03e                	sd	a5,0(sp)
    1580:	b57ff0ef          	jal	10d6 <printint.constprop.0>
        s += 2;
    1584:	00248513          	addi	a0,s1,2
    1588:	b749                	j	150a <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    158a:	6782                	ld	a5,0(sp)
    158c:	6380                	ld	s0,0(a5)
    158e:	07a1                	addi	a5,a5,8
    1590:	e03e                	sd	a5,0(sp)
    1592:	c031                	beqz	s0,15d6 <printf+0x286>
            l = strnlen(a, 200);
    1594:	0c800593          	li	a1,200
    1598:	8522                	mv	a0,s0
    159a:	40a000ef          	jal	19a4 <strnlen>
    write(f, s, l);
    159e:	0005061b          	sext.w	a2,a0
    15a2:	85a2                	mv	a1,s0
    15a4:	4505                	li	a0,1
    15a6:	6f6000ef          	jal	1c9c <write>
        s += 2;
    15aa:	00248513          	addi	a0,s1,2
    15ae:	bfb1                	j	150a <printf+0x1ba>
    return write(stdout, &byte, 1);
    15b0:	4605                	li	a2,1
    15b2:	002c                	addi	a1,sp,8
    15b4:	4505                	li	a0,1
    char byte = c;
    15b6:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15ba:	6e2000ef          	jal	1c9c <write>
    char byte = c;
    15be:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15c2:	4605                	li	a2,1
    15c4:	002c                	addi	a1,sp,8
    15c6:	4505                	li	a0,1
    char byte = c;
    15c8:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15cc:	6d0000ef          	jal	1c9c <write>
        s += 2;
    15d0:	00248513          	addi	a0,s1,2
    15d4:	bf1d                	j	150a <printf+0x1ba>
                a = "(null)";
    15d6:	845e                	mv	s0,s7
    15d8:	bf75                	j	1594 <printf+0x244>

00000000000015da <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15da:	1141                	addi	sp,sp,-16
    15dc:	e406                	sd	ra,8(sp)
    puts(m);
    15de:	d51ff0ef          	jal	132e <puts>
    exit(-100);
}
    15e2:	60a2                	ld	ra,8(sp)
    exit(-100);
    15e4:	f9c00513          	li	a0,-100
}
    15e8:	0141                	addi	sp,sp,16
    exit(-100);
    15ea:	a709                	j	1cec <exit>

00000000000015ec <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15ec:	02000793          	li	a5,32
    15f0:	00f50663          	beq	a0,a5,15fc <isspace+0x10>
    15f4:	355d                	addiw	a0,a0,-9
    15f6:	00553513          	sltiu	a0,a0,5
    15fa:	8082                	ret
    15fc:	4505                	li	a0,1
}
    15fe:	8082                	ret

0000000000001600 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1600:	fd05051b          	addiw	a0,a0,-48
}
    1604:	00a53513          	sltiu	a0,a0,10
    1608:	8082                	ret

000000000000160a <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    160a:	02000613          	li	a2,32
    160e:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1610:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1614:	ff77069b          	addiw	a3,a4,-9
    1618:	04c70d63          	beq	a4,a2,1672 <atoi+0x68>
    161c:	0007079b          	sext.w	a5,a4
    1620:	04d5f963          	bgeu	a1,a3,1672 <atoi+0x68>
        s++;
    switch (*s)
    1624:	02b00693          	li	a3,43
    1628:	04d70a63          	beq	a4,a3,167c <atoi+0x72>
    162c:	02d00693          	li	a3,45
    1630:	06d70463          	beq	a4,a3,1698 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1634:	fd07859b          	addiw	a1,a5,-48
    1638:	4625                	li	a2,9
    163a:	873e                	mv	a4,a5
    163c:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    163e:	4e01                	li	t3,0
    while (isdigit(*s))
    1640:	04b66a63          	bltu	a2,a1,1694 <atoi+0x8a>
    int n = 0, neg = 0;
    1644:	4501                	li	a0,0
    while (isdigit(*s))
    1646:	4825                	li	a6,9
    1648:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    164c:	0025179b          	slliw	a5,a0,0x2
    1650:	9d3d                	addw	a0,a0,a5
    1652:	fd07031b          	addiw	t1,a4,-48
    1656:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    165a:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    165e:	0685                	addi	a3,a3,1
    1660:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1664:	0006071b          	sext.w	a4,a2
    1668:	feb870e3          	bgeu	a6,a1,1648 <atoi+0x3e>
    return neg ? n : -n;
    166c:	000e0563          	beqz	t3,1676 <atoi+0x6c>
}
    1670:	8082                	ret
        s++;
    1672:	0505                	addi	a0,a0,1
    1674:	bf71                	j	1610 <atoi+0x6>
    return neg ? n : -n;
    1676:	4113053b          	subw	a0,t1,a7
    167a:	8082                	ret
    while (isdigit(*s))
    167c:	00154783          	lbu	a5,1(a0)
    1680:	4625                	li	a2,9
        s++;
    1682:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1686:	fd07859b          	addiw	a1,a5,-48
    168a:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    168e:	4e01                	li	t3,0
    while (isdigit(*s))
    1690:	fab67ae3          	bgeu	a2,a1,1644 <atoi+0x3a>
    1694:	4501                	li	a0,0
}
    1696:	8082                	ret
    while (isdigit(*s))
    1698:	00154783          	lbu	a5,1(a0)
    169c:	4625                	li	a2,9
        s++;
    169e:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16a2:	fd07859b          	addiw	a1,a5,-48
    16a6:	0007871b          	sext.w	a4,a5
    16aa:	feb665e3          	bltu	a2,a1,1694 <atoi+0x8a>
        neg = 1;
    16ae:	4e05                	li	t3,1
    16b0:	bf51                	j	1644 <atoi+0x3a>

00000000000016b2 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16b2:	16060d63          	beqz	a2,182c <memset+0x17a>
    16b6:	40a007b3          	neg	a5,a0
    16ba:	8b9d                	andi	a5,a5,7
    16bc:	00778713          	addi	a4,a5,7
    16c0:	482d                	li	a6,11
    16c2:	0ff5f593          	zext.b	a1,a1
    16c6:	fff60693          	addi	a3,a2,-1
    16ca:	17076263          	bltu	a4,a6,182e <memset+0x17c>
    16ce:	16e6ea63          	bltu	a3,a4,1842 <memset+0x190>
    16d2:	16078563          	beqz	a5,183c <memset+0x18a>
    16d6:	00b50023          	sb	a1,0(a0)
    16da:	4705                	li	a4,1
    16dc:	00150e93          	addi	t4,a0,1
    16e0:	14e78c63          	beq	a5,a4,1838 <memset+0x186>
    16e4:	00b500a3          	sb	a1,1(a0)
    16e8:	4709                	li	a4,2
    16ea:	00250e93          	addi	t4,a0,2
    16ee:	14e78d63          	beq	a5,a4,1848 <memset+0x196>
    16f2:	00b50123          	sb	a1,2(a0)
    16f6:	470d                	li	a4,3
    16f8:	00350e93          	addi	t4,a0,3
    16fc:	12e78b63          	beq	a5,a4,1832 <memset+0x180>
    1700:	00b501a3          	sb	a1,3(a0)
    1704:	4711                	li	a4,4
    1706:	00450e93          	addi	t4,a0,4
    170a:	14e78163          	beq	a5,a4,184c <memset+0x19a>
    170e:	00b50223          	sb	a1,4(a0)
    1712:	4715                	li	a4,5
    1714:	00550e93          	addi	t4,a0,5
    1718:	12e78c63          	beq	a5,a4,1850 <memset+0x19e>
    171c:	00b502a3          	sb	a1,5(a0)
    1720:	471d                	li	a4,7
    1722:	00650e93          	addi	t4,a0,6
    1726:	12e79763          	bne	a5,a4,1854 <memset+0x1a2>
    172a:	00750e93          	addi	t4,a0,7
    172e:	00b50323          	sb	a1,6(a0)
    1732:	4f1d                	li	t5,7
    1734:	00859713          	slli	a4,a1,0x8
    1738:	8f4d                	or	a4,a4,a1
    173a:	01059e13          	slli	t3,a1,0x10
    173e:	01c76e33          	or	t3,a4,t3
    1742:	01859313          	slli	t1,a1,0x18
    1746:	006e6333          	or	t1,t3,t1
    174a:	02059893          	slli	a7,a1,0x20
    174e:	011368b3          	or	a7,t1,a7
    1752:	02859813          	slli	a6,a1,0x28
    1756:	40f60333          	sub	t1,a2,a5
    175a:	0108e833          	or	a6,a7,a6
    175e:	03059693          	slli	a3,a1,0x30
    1762:	00d866b3          	or	a3,a6,a3
    1766:	03859713          	slli	a4,a1,0x38
    176a:	97aa                	add	a5,a5,a0
    176c:	ff837813          	andi	a6,t1,-8
    1770:	8f55                	or	a4,a4,a3
    1772:	00f806b3          	add	a3,a6,a5
    1776:	e398                	sd	a4,0(a5)
    1778:	07a1                	addi	a5,a5,8
    177a:	fed79ee3          	bne	a5,a3,1776 <memset+0xc4>
    177e:	ff837693          	andi	a3,t1,-8
    1782:	00de87b3          	add	a5,t4,a3
    1786:	01e6873b          	addw	a4,a3,t5
    178a:	0ad30663          	beq	t1,a3,1836 <memset+0x184>
    178e:	00b78023          	sb	a1,0(a5)
    1792:	0017069b          	addiw	a3,a4,1
    1796:	08c6fb63          	bgeu	a3,a2,182c <memset+0x17a>
    179a:	00b780a3          	sb	a1,1(a5)
    179e:	0027069b          	addiw	a3,a4,2
    17a2:	08c6f563          	bgeu	a3,a2,182c <memset+0x17a>
    17a6:	00b78123          	sb	a1,2(a5)
    17aa:	0037069b          	addiw	a3,a4,3
    17ae:	06c6ff63          	bgeu	a3,a2,182c <memset+0x17a>
    17b2:	00b781a3          	sb	a1,3(a5)
    17b6:	0047069b          	addiw	a3,a4,4
    17ba:	06c6f963          	bgeu	a3,a2,182c <memset+0x17a>
    17be:	00b78223          	sb	a1,4(a5)
    17c2:	0057069b          	addiw	a3,a4,5
    17c6:	06c6f363          	bgeu	a3,a2,182c <memset+0x17a>
    17ca:	00b782a3          	sb	a1,5(a5)
    17ce:	0067069b          	addiw	a3,a4,6
    17d2:	04c6fd63          	bgeu	a3,a2,182c <memset+0x17a>
    17d6:	00b78323          	sb	a1,6(a5)
    17da:	0077069b          	addiw	a3,a4,7
    17de:	04c6f763          	bgeu	a3,a2,182c <memset+0x17a>
    17e2:	00b783a3          	sb	a1,7(a5)
    17e6:	0087069b          	addiw	a3,a4,8
    17ea:	04c6f163          	bgeu	a3,a2,182c <memset+0x17a>
    17ee:	00b78423          	sb	a1,8(a5)
    17f2:	0097069b          	addiw	a3,a4,9
    17f6:	02c6fb63          	bgeu	a3,a2,182c <memset+0x17a>
    17fa:	00b784a3          	sb	a1,9(a5)
    17fe:	00a7069b          	addiw	a3,a4,10
    1802:	02c6f563          	bgeu	a3,a2,182c <memset+0x17a>
    1806:	00b78523          	sb	a1,10(a5)
    180a:	00b7069b          	addiw	a3,a4,11
    180e:	00c6ff63          	bgeu	a3,a2,182c <memset+0x17a>
    1812:	00b785a3          	sb	a1,11(a5)
    1816:	00c7069b          	addiw	a3,a4,12
    181a:	00c6f963          	bgeu	a3,a2,182c <memset+0x17a>
    181e:	00b78623          	sb	a1,12(a5)
    1822:	2735                	addiw	a4,a4,13
    1824:	00c77463          	bgeu	a4,a2,182c <memset+0x17a>
    1828:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    182c:	8082                	ret
    182e:	472d                	li	a4,11
    1830:	bd79                	j	16ce <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1832:	4f0d                	li	t5,3
    1834:	b701                	j	1734 <memset+0x82>
    1836:	8082                	ret
    1838:	4f05                	li	t5,1
    183a:	bded                	j	1734 <memset+0x82>
    183c:	8eaa                	mv	t4,a0
    183e:	4f01                	li	t5,0
    1840:	bdd5                	j	1734 <memset+0x82>
    1842:	87aa                	mv	a5,a0
    1844:	4701                	li	a4,0
    1846:	b7a1                	j	178e <memset+0xdc>
    1848:	4f09                	li	t5,2
    184a:	b5ed                	j	1734 <memset+0x82>
    184c:	4f11                	li	t5,4
    184e:	b5dd                	j	1734 <memset+0x82>
    1850:	4f15                	li	t5,5
    1852:	b5cd                	j	1734 <memset+0x82>
    1854:	4f19                	li	t5,6
    1856:	bdf9                	j	1734 <memset+0x82>

0000000000001858 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1858:	00054783          	lbu	a5,0(a0)
    185c:	0005c703          	lbu	a4,0(a1)
    1860:	00e79863          	bne	a5,a4,1870 <strcmp+0x18>
    1864:	0505                	addi	a0,a0,1
    1866:	0585                	addi	a1,a1,1
    1868:	fbe5                	bnez	a5,1858 <strcmp>
    186a:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    186c:	9d19                	subw	a0,a0,a4
    186e:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1870:	0007851b          	sext.w	a0,a5
    1874:	bfe5                	j	186c <strcmp+0x14>

0000000000001876 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1876:	ce05                	beqz	a2,18ae <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1878:	00054703          	lbu	a4,0(a0)
    187c:	0005c783          	lbu	a5,0(a1)
    1880:	cb0d                	beqz	a4,18b2 <strncmp+0x3c>
    if (!n--)
    1882:	167d                	addi	a2,a2,-1
    1884:	00c506b3          	add	a3,a0,a2
    1888:	a819                	j	189e <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    188a:	00a68e63          	beq	a3,a0,18a6 <strncmp+0x30>
    188e:	0505                	addi	a0,a0,1
    1890:	00e79b63          	bne	a5,a4,18a6 <strncmp+0x30>
    1894:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    1898:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    189c:	cb19                	beqz	a4,18b2 <strncmp+0x3c>
    189e:	0005c783          	lbu	a5,0(a1)
    18a2:	0585                	addi	a1,a1,1
    18a4:	f3fd                	bnez	a5,188a <strncmp+0x14>
    return *l - *r;
    18a6:	0007051b          	sext.w	a0,a4
    18aa:	9d1d                	subw	a0,a0,a5
    18ac:	8082                	ret
        return 0;
    18ae:	4501                	li	a0,0
}
    18b0:	8082                	ret
    18b2:	4501                	li	a0,0
    return *l - *r;
    18b4:	9d1d                	subw	a0,a0,a5
    18b6:	8082                	ret

00000000000018b8 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18b8:	00757793          	andi	a5,a0,7
    18bc:	cf89                	beqz	a5,18d6 <strlen+0x1e>
    18be:	87aa                	mv	a5,a0
    18c0:	a029                	j	18ca <strlen+0x12>
    18c2:	0785                	addi	a5,a5,1
    18c4:	0077f713          	andi	a4,a5,7
    18c8:	cb01                	beqz	a4,18d8 <strlen+0x20>
        if (!*s)
    18ca:	0007c703          	lbu	a4,0(a5)
    18ce:	fb75                	bnez	a4,18c2 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18d0:	40a78533          	sub	a0,a5,a0
}
    18d4:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18d6:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18d8:	6394                	ld	a3,0(a5)
    18da:	00000597          	auipc	a1,0x0
    18de:	6a65b583          	ld	a1,1702(a1) # 1f80 <__clone+0xac>
    18e2:	00000617          	auipc	a2,0x0
    18e6:	6a663603          	ld	a2,1702(a2) # 1f88 <__clone+0xb4>
    18ea:	a019                	j	18f0 <strlen+0x38>
    18ec:	6794                	ld	a3,8(a5)
    18ee:	07a1                	addi	a5,a5,8
    18f0:	00b68733          	add	a4,a3,a1
    18f4:	fff6c693          	not	a3,a3
    18f8:	8f75                	and	a4,a4,a3
    18fa:	8f71                	and	a4,a4,a2
    18fc:	db65                	beqz	a4,18ec <strlen+0x34>
    for (; *s; s++)
    18fe:	0007c703          	lbu	a4,0(a5)
    1902:	d779                	beqz	a4,18d0 <strlen+0x18>
    1904:	0017c703          	lbu	a4,1(a5)
    1908:	0785                	addi	a5,a5,1
    190a:	d379                	beqz	a4,18d0 <strlen+0x18>
    190c:	0017c703          	lbu	a4,1(a5)
    1910:	0785                	addi	a5,a5,1
    1912:	fb6d                	bnez	a4,1904 <strlen+0x4c>
    1914:	bf75                	j	18d0 <strlen+0x18>

0000000000001916 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1916:	00757713          	andi	a4,a0,7
{
    191a:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    191c:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1920:	cb19                	beqz	a4,1936 <memchr+0x20>
    1922:	ce25                	beqz	a2,199a <memchr+0x84>
    1924:	0007c703          	lbu	a4,0(a5)
    1928:	04b70e63          	beq	a4,a1,1984 <memchr+0x6e>
    192c:	0785                	addi	a5,a5,1
    192e:	0077f713          	andi	a4,a5,7
    1932:	167d                	addi	a2,a2,-1
    1934:	f77d                	bnez	a4,1922 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1936:	4501                	li	a0,0
    if (n && *s != c)
    1938:	c235                	beqz	a2,199c <memchr+0x86>
    193a:	0007c703          	lbu	a4,0(a5)
    193e:	04b70363          	beq	a4,a1,1984 <memchr+0x6e>
        size_t k = ONES * c;
    1942:	00000517          	auipc	a0,0x0
    1946:	64e53503          	ld	a0,1614(a0) # 1f90 <__clone+0xbc>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    194a:	471d                	li	a4,7
        size_t k = ONES * c;
    194c:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1950:	02c77a63          	bgeu	a4,a2,1984 <memchr+0x6e>
    1954:	00000897          	auipc	a7,0x0
    1958:	62c8b883          	ld	a7,1580(a7) # 1f80 <__clone+0xac>
    195c:	00000817          	auipc	a6,0x0
    1960:	62c83803          	ld	a6,1580(a6) # 1f88 <__clone+0xb4>
    1964:	431d                	li	t1,7
    1966:	a029                	j	1970 <memchr+0x5a>
    1968:	1661                	addi	a2,a2,-8
    196a:	07a1                	addi	a5,a5,8
    196c:	02c37963          	bgeu	t1,a2,199e <memchr+0x88>
    1970:	6398                	ld	a4,0(a5)
    1972:	8f29                	xor	a4,a4,a0
    1974:	011706b3          	add	a3,a4,a7
    1978:	fff74713          	not	a4,a4
    197c:	8f75                	and	a4,a4,a3
    197e:	01077733          	and	a4,a4,a6
    1982:	d37d                	beqz	a4,1968 <memchr+0x52>
    1984:	853e                	mv	a0,a5
    1986:	97b2                	add	a5,a5,a2
    1988:	a021                	j	1990 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    198a:	0505                	addi	a0,a0,1
    198c:	00f50763          	beq	a0,a5,199a <memchr+0x84>
    1990:	00054703          	lbu	a4,0(a0)
    1994:	feb71be3          	bne	a4,a1,198a <memchr+0x74>
    1998:	8082                	ret
    return n ? (void *)s : 0;
    199a:	4501                	li	a0,0
}
    199c:	8082                	ret
    return n ? (void *)s : 0;
    199e:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19a0:	f275                	bnez	a2,1984 <memchr+0x6e>
}
    19a2:	8082                	ret

00000000000019a4 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19a4:	1101                	addi	sp,sp,-32
    19a6:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19a8:	862e                	mv	a2,a1
{
    19aa:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19ac:	4581                	li	a1,0
{
    19ae:	e426                	sd	s1,8(sp)
    19b0:	ec06                	sd	ra,24(sp)
    19b2:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19b4:	f63ff0ef          	jal	1916 <memchr>
    return p ? p - s : n;
    19b8:	c519                	beqz	a0,19c6 <strnlen+0x22>
}
    19ba:	60e2                	ld	ra,24(sp)
    19bc:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19be:	8d05                	sub	a0,a0,s1
}
    19c0:	64a2                	ld	s1,8(sp)
    19c2:	6105                	addi	sp,sp,32
    19c4:	8082                	ret
    19c6:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19c8:	8522                	mv	a0,s0
}
    19ca:	6442                	ld	s0,16(sp)
    19cc:	64a2                	ld	s1,8(sp)
    19ce:	6105                	addi	sp,sp,32
    19d0:	8082                	ret

00000000000019d2 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19d2:	00b547b3          	xor	a5,a0,a1
    19d6:	8b9d                	andi	a5,a5,7
    19d8:	eb95                	bnez	a5,1a0c <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19da:	0075f793          	andi	a5,a1,7
    19de:	e7b1                	bnez	a5,1a2a <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19e0:	6198                	ld	a4,0(a1)
    19e2:	00000617          	auipc	a2,0x0
    19e6:	59e63603          	ld	a2,1438(a2) # 1f80 <__clone+0xac>
    19ea:	00000817          	auipc	a6,0x0
    19ee:	59e83803          	ld	a6,1438(a6) # 1f88 <__clone+0xb4>
    19f2:	a029                	j	19fc <strcpy+0x2a>
    19f4:	e118                	sd	a4,0(a0)
    19f6:	6598                	ld	a4,8(a1)
    19f8:	05a1                	addi	a1,a1,8
    19fa:	0521                	addi	a0,a0,8
    19fc:	00c707b3          	add	a5,a4,a2
    1a00:	fff74693          	not	a3,a4
    1a04:	8ff5                	and	a5,a5,a3
    1a06:	0107f7b3          	and	a5,a5,a6
    1a0a:	d7ed                	beqz	a5,19f4 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a0c:	0005c783          	lbu	a5,0(a1)
    1a10:	00f50023          	sb	a5,0(a0)
    1a14:	c785                	beqz	a5,1a3c <strcpy+0x6a>
    1a16:	0015c783          	lbu	a5,1(a1)
    1a1a:	0505                	addi	a0,a0,1
    1a1c:	0585                	addi	a1,a1,1
    1a1e:	00f50023          	sb	a5,0(a0)
    1a22:	fbf5                	bnez	a5,1a16 <strcpy+0x44>
        ;
    return d;
}
    1a24:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a26:	0505                	addi	a0,a0,1
    1a28:	df45                	beqz	a4,19e0 <strcpy+0xe>
            if (!(*d = *s))
    1a2a:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a2e:	0585                	addi	a1,a1,1
    1a30:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a34:	00f50023          	sb	a5,0(a0)
    1a38:	f7fd                	bnez	a5,1a26 <strcpy+0x54>
}
    1a3a:	8082                	ret
    1a3c:	8082                	ret

0000000000001a3e <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a3e:	00b547b3          	xor	a5,a0,a1
    1a42:	8b9d                	andi	a5,a5,7
    1a44:	1a079863          	bnez	a5,1bf4 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a48:	0075f793          	andi	a5,a1,7
    1a4c:	16078463          	beqz	a5,1bb4 <strncpy+0x176>
    1a50:	ea01                	bnez	a2,1a60 <strncpy+0x22>
    1a52:	a421                	j	1c5a <strncpy+0x21c>
    1a54:	167d                	addi	a2,a2,-1
    1a56:	0505                	addi	a0,a0,1
    1a58:	14070e63          	beqz	a4,1bb4 <strncpy+0x176>
    1a5c:	1a060863          	beqz	a2,1c0c <strncpy+0x1ce>
    1a60:	0005c783          	lbu	a5,0(a1)
    1a64:	0585                	addi	a1,a1,1
    1a66:	0075f713          	andi	a4,a1,7
    1a6a:	00f50023          	sb	a5,0(a0)
    1a6e:	f3fd                	bnez	a5,1a54 <strncpy+0x16>
    1a70:	4805                	li	a6,1
    1a72:	1a061863          	bnez	a2,1c22 <strncpy+0x1e4>
    1a76:	40a007b3          	neg	a5,a0
    1a7a:	8b9d                	andi	a5,a5,7
    1a7c:	4681                	li	a3,0
    1a7e:	18061a63          	bnez	a2,1c12 <strncpy+0x1d4>
    1a82:	00778713          	addi	a4,a5,7
    1a86:	45ad                	li	a1,11
    1a88:	18b76363          	bltu	a4,a1,1c0e <strncpy+0x1d0>
    1a8c:	1ae6eb63          	bltu	a3,a4,1c42 <strncpy+0x204>
    1a90:	1a078363          	beqz	a5,1c36 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a94:	00050023          	sb	zero,0(a0)
    1a98:	4685                	li	a3,1
    1a9a:	00150713          	addi	a4,a0,1
    1a9e:	18d78f63          	beq	a5,a3,1c3c <strncpy+0x1fe>
    1aa2:	000500a3          	sb	zero,1(a0)
    1aa6:	4689                	li	a3,2
    1aa8:	00250713          	addi	a4,a0,2
    1aac:	18d78e63          	beq	a5,a3,1c48 <strncpy+0x20a>
    1ab0:	00050123          	sb	zero,2(a0)
    1ab4:	468d                	li	a3,3
    1ab6:	00350713          	addi	a4,a0,3
    1aba:	16d78c63          	beq	a5,a3,1c32 <strncpy+0x1f4>
    1abe:	000501a3          	sb	zero,3(a0)
    1ac2:	4691                	li	a3,4
    1ac4:	00450713          	addi	a4,a0,4
    1ac8:	18d78263          	beq	a5,a3,1c4c <strncpy+0x20e>
    1acc:	00050223          	sb	zero,4(a0)
    1ad0:	4695                	li	a3,5
    1ad2:	00550713          	addi	a4,a0,5
    1ad6:	16d78d63          	beq	a5,a3,1c50 <strncpy+0x212>
    1ada:	000502a3          	sb	zero,5(a0)
    1ade:	469d                	li	a3,7
    1ae0:	00650713          	addi	a4,a0,6
    1ae4:	16d79863          	bne	a5,a3,1c54 <strncpy+0x216>
    1ae8:	00750713          	addi	a4,a0,7
    1aec:	00050323          	sb	zero,6(a0)
    1af0:	40f80833          	sub	a6,a6,a5
    1af4:	ff887593          	andi	a1,a6,-8
    1af8:	97aa                	add	a5,a5,a0
    1afa:	95be                	add	a1,a1,a5
    1afc:	0007b023          	sd	zero,0(a5)
    1b00:	07a1                	addi	a5,a5,8
    1b02:	feb79de3          	bne	a5,a1,1afc <strncpy+0xbe>
    1b06:	ff887593          	andi	a1,a6,-8
    1b0a:	9ead                	addw	a3,a3,a1
    1b0c:	00b707b3          	add	a5,a4,a1
    1b10:	12b80863          	beq	a6,a1,1c40 <strncpy+0x202>
    1b14:	00078023          	sb	zero,0(a5)
    1b18:	0016871b          	addiw	a4,a3,1
    1b1c:	0ec77863          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1b20:	000780a3          	sb	zero,1(a5)
    1b24:	0026871b          	addiw	a4,a3,2
    1b28:	0ec77263          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1b2c:	00078123          	sb	zero,2(a5)
    1b30:	0036871b          	addiw	a4,a3,3
    1b34:	0cc77c63          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1b38:	000781a3          	sb	zero,3(a5)
    1b3c:	0046871b          	addiw	a4,a3,4
    1b40:	0cc77663          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1b44:	00078223          	sb	zero,4(a5)
    1b48:	0056871b          	addiw	a4,a3,5
    1b4c:	0cc77063          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1b50:	000782a3          	sb	zero,5(a5)
    1b54:	0066871b          	addiw	a4,a3,6
    1b58:	0ac77a63          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1b5c:	00078323          	sb	zero,6(a5)
    1b60:	0076871b          	addiw	a4,a3,7
    1b64:	0ac77463          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1b68:	000783a3          	sb	zero,7(a5)
    1b6c:	0086871b          	addiw	a4,a3,8
    1b70:	08c77e63          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1b74:	00078423          	sb	zero,8(a5)
    1b78:	0096871b          	addiw	a4,a3,9
    1b7c:	08c77863          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1b80:	000784a3          	sb	zero,9(a5)
    1b84:	00a6871b          	addiw	a4,a3,10
    1b88:	08c77263          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1b8c:	00078523          	sb	zero,10(a5)
    1b90:	00b6871b          	addiw	a4,a3,11
    1b94:	06c77c63          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1b98:	000785a3          	sb	zero,11(a5)
    1b9c:	00c6871b          	addiw	a4,a3,12
    1ba0:	06c77663          	bgeu	a4,a2,1c0c <strncpy+0x1ce>
    1ba4:	00078623          	sb	zero,12(a5)
    1ba8:	26b5                	addiw	a3,a3,13
    1baa:	06c6f163          	bgeu	a3,a2,1c0c <strncpy+0x1ce>
    1bae:	000786a3          	sb	zero,13(a5)
    1bb2:	8082                	ret
            ;
        if (!n || !*s)
    1bb4:	c645                	beqz	a2,1c5c <strncpy+0x21e>
    1bb6:	0005c783          	lbu	a5,0(a1)
    1bba:	ea078be3          	beqz	a5,1a70 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bbe:	479d                	li	a5,7
    1bc0:	02c7ff63          	bgeu	a5,a2,1bfe <strncpy+0x1c0>
    1bc4:	00000897          	auipc	a7,0x0
    1bc8:	3bc8b883          	ld	a7,956(a7) # 1f80 <__clone+0xac>
    1bcc:	00000817          	auipc	a6,0x0
    1bd0:	3bc83803          	ld	a6,956(a6) # 1f88 <__clone+0xb4>
    1bd4:	431d                	li	t1,7
    1bd6:	6198                	ld	a4,0(a1)
    1bd8:	011707b3          	add	a5,a4,a7
    1bdc:	fff74693          	not	a3,a4
    1be0:	8ff5                	and	a5,a5,a3
    1be2:	0107f7b3          	and	a5,a5,a6
    1be6:	ef81                	bnez	a5,1bfe <strncpy+0x1c0>
            *wd = *ws;
    1be8:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bea:	1661                	addi	a2,a2,-8
    1bec:	05a1                	addi	a1,a1,8
    1bee:	0521                	addi	a0,a0,8
    1bf0:	fec363e3          	bltu	t1,a2,1bd6 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bf4:	e609                	bnez	a2,1bfe <strncpy+0x1c0>
    1bf6:	a08d                	j	1c58 <strncpy+0x21a>
    1bf8:	167d                	addi	a2,a2,-1
    1bfa:	0505                	addi	a0,a0,1
    1bfc:	ca01                	beqz	a2,1c0c <strncpy+0x1ce>
    1bfe:	0005c783          	lbu	a5,0(a1)
    1c02:	0585                	addi	a1,a1,1
    1c04:	00f50023          	sb	a5,0(a0)
    1c08:	fbe5                	bnez	a5,1bf8 <strncpy+0x1ba>
        ;
tail:
    1c0a:	b59d                	j	1a70 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c0c:	8082                	ret
    1c0e:	472d                	li	a4,11
    1c10:	bdb5                	j	1a8c <strncpy+0x4e>
    1c12:	00778713          	addi	a4,a5,7
    1c16:	45ad                	li	a1,11
    1c18:	fff60693          	addi	a3,a2,-1
    1c1c:	e6b778e3          	bgeu	a4,a1,1a8c <strncpy+0x4e>
    1c20:	b7fd                	j	1c0e <strncpy+0x1d0>
    1c22:	40a007b3          	neg	a5,a0
    1c26:	8832                	mv	a6,a2
    1c28:	8b9d                	andi	a5,a5,7
    1c2a:	4681                	li	a3,0
    1c2c:	e4060be3          	beqz	a2,1a82 <strncpy+0x44>
    1c30:	b7cd                	j	1c12 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c32:	468d                	li	a3,3
    1c34:	bd75                	j	1af0 <strncpy+0xb2>
    1c36:	872a                	mv	a4,a0
    1c38:	4681                	li	a3,0
    1c3a:	bd5d                	j	1af0 <strncpy+0xb2>
    1c3c:	4685                	li	a3,1
    1c3e:	bd4d                	j	1af0 <strncpy+0xb2>
    1c40:	8082                	ret
    1c42:	87aa                	mv	a5,a0
    1c44:	4681                	li	a3,0
    1c46:	b5f9                	j	1b14 <strncpy+0xd6>
    1c48:	4689                	li	a3,2
    1c4a:	b55d                	j	1af0 <strncpy+0xb2>
    1c4c:	4691                	li	a3,4
    1c4e:	b54d                	j	1af0 <strncpy+0xb2>
    1c50:	4695                	li	a3,5
    1c52:	bd79                	j	1af0 <strncpy+0xb2>
    1c54:	4699                	li	a3,6
    1c56:	bd69                	j	1af0 <strncpy+0xb2>
    1c58:	8082                	ret
    1c5a:	8082                	ret
    1c5c:	8082                	ret

0000000000001c5e <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c5e:	87aa                	mv	a5,a0
    1c60:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c62:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c66:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c6a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c6c:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c6e:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c72:	2501                	sext.w	a0,a0
    1c74:	8082                	ret

0000000000001c76 <openat>:
    register long a7 __asm__("a7") = n;
    1c76:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c7a:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c7e:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c82:	2501                	sext.w	a0,a0
    1c84:	8082                	ret

0000000000001c86 <close>:
    register long a7 __asm__("a7") = n;
    1c86:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c8a:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c8e:	2501                	sext.w	a0,a0
    1c90:	8082                	ret

0000000000001c92 <read>:
    register long a7 __asm__("a7") = n;
    1c92:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c96:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c9a:	8082                	ret

0000000000001c9c <write>:
    register long a7 __asm__("a7") = n;
    1c9c:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ca0:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1ca4:	8082                	ret

0000000000001ca6 <getpid>:
    register long a7 __asm__("a7") = n;
    1ca6:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1caa:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cae:	2501                	sext.w	a0,a0
    1cb0:	8082                	ret

0000000000001cb2 <getppid>:
    register long a7 __asm__("a7") = n;
    1cb2:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cb6:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cba:	2501                	sext.w	a0,a0
    1cbc:	8082                	ret

0000000000001cbe <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cbe:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cc2:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cc6:	2501                	sext.w	a0,a0
    1cc8:	8082                	ret

0000000000001cca <fork>:
    register long a7 __asm__("a7") = n;
    1cca:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cce:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cd0:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cd2:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cd6:	2501                	sext.w	a0,a0
    1cd8:	8082                	ret

0000000000001cda <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cda:	85b2                	mv	a1,a2
    1cdc:	863a                	mv	a2,a4
    if (stack)
    1cde:	c191                	beqz	a1,1ce2 <clone+0x8>
	stack += stack_size;
    1ce0:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1ce2:	4781                	li	a5,0
    1ce4:	4701                	li	a4,0
    1ce6:	4681                	li	a3,0
    1ce8:	2601                	sext.w	a2,a2
    1cea:	a2ed                	j	1ed4 <__clone>

0000000000001cec <exit>:
    register long a7 __asm__("a7") = n;
    1cec:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cf0:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cf4:	8082                	ret

0000000000001cf6 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cf6:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cfa:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cfc:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d00:	2501                	sext.w	a0,a0
    1d02:	8082                	ret

0000000000001d04 <exec>:
    register long a7 __asm__("a7") = n;
    1d04:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d08:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d0c:	2501                	sext.w	a0,a0
    1d0e:	8082                	ret

0000000000001d10 <execve>:
    register long a7 __asm__("a7") = n;
    1d10:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d14:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d18:	2501                	sext.w	a0,a0
    1d1a:	8082                	ret

0000000000001d1c <times>:
    register long a7 __asm__("a7") = n;
    1d1c:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d20:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d24:	2501                	sext.w	a0,a0
    1d26:	8082                	ret

0000000000001d28 <get_time>:

int64 get_time()
{
    1d28:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d2a:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d2e:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d30:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d32:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d36:	2501                	sext.w	a0,a0
    1d38:	ed09                	bnez	a0,1d52 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d3a:	67a2                	ld	a5,8(sp)
    1d3c:	3e800713          	li	a4,1000
    1d40:	00015503          	lhu	a0,0(sp)
    1d44:	02e7d7b3          	divu	a5,a5,a4
    1d48:	02e50533          	mul	a0,a0,a4
    1d4c:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d4e:	0141                	addi	sp,sp,16
    1d50:	8082                	ret
        return -1;
    1d52:	557d                	li	a0,-1
    1d54:	bfed                	j	1d4e <get_time+0x26>

0000000000001d56 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d56:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d5a:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d5e:	2501                	sext.w	a0,a0
    1d60:	8082                	ret

0000000000001d62 <time>:
    register long a7 __asm__("a7") = n;
    1d62:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d66:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d6a:	2501                	sext.w	a0,a0
    1d6c:	8082                	ret

0000000000001d6e <sleep>:

int sleep(unsigned long long time)
{
    1d6e:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d70:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d72:	850a                	mv	a0,sp
    1d74:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d76:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d7a:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d7c:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d80:	e501                	bnez	a0,1d88 <sleep+0x1a>
    return 0;
    1d82:	4501                	li	a0,0
}
    1d84:	0141                	addi	sp,sp,16
    1d86:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d88:	4502                	lw	a0,0(sp)
}
    1d8a:	0141                	addi	sp,sp,16
    1d8c:	8082                	ret

0000000000001d8e <set_priority>:
    register long a7 __asm__("a7") = n;
    1d8e:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d92:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d96:	2501                	sext.w	a0,a0
    1d98:	8082                	ret

0000000000001d9a <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d9a:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d9e:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1da2:	8082                	ret

0000000000001da4 <munmap>:
    register long a7 __asm__("a7") = n;
    1da4:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1da8:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1dac:	2501                	sext.w	a0,a0
    1dae:	8082                	ret

0000000000001db0 <wait>:

int wait(int *code)
{
    1db0:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1db2:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1db6:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1db8:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dba:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dbc:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dc0:	2501                	sext.w	a0,a0
    1dc2:	8082                	ret

0000000000001dc4 <spawn>:
    register long a7 __asm__("a7") = n;
    1dc4:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dc8:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dcc:	2501                	sext.w	a0,a0
    1dce:	8082                	ret

0000000000001dd0 <mailread>:
    register long a7 __asm__("a7") = n;
    1dd0:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd4:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dd8:	2501                	sext.w	a0,a0
    1dda:	8082                	ret

0000000000001ddc <mailwrite>:
    register long a7 __asm__("a7") = n;
    1ddc:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1de0:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1de4:	2501                	sext.w	a0,a0
    1de6:	8082                	ret

0000000000001de8 <fstat>:
    register long a7 __asm__("a7") = n;
    1de8:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dec:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1df0:	2501                	sext.w	a0,a0
    1df2:	8082                	ret

0000000000001df4 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1df4:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1df6:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dfa:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dfc:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e00:	2501                	sext.w	a0,a0
    1e02:	8082                	ret

0000000000001e04 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e04:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e06:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e0a:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e0c:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e10:	2501                	sext.w	a0,a0
    1e12:	8082                	ret

0000000000001e14 <link>:

int link(char *old_path, char *new_path)
{
    1e14:	87aa                	mv	a5,a0
    1e16:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e18:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e1c:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e20:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e22:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e26:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e28:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e2c:	2501                	sext.w	a0,a0
    1e2e:	8082                	ret

0000000000001e30 <unlink>:

int unlink(char *path)
{
    1e30:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e32:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e36:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e3a:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e3c:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e40:	2501                	sext.w	a0,a0
    1e42:	8082                	ret

0000000000001e44 <uname>:
    register long a7 __asm__("a7") = n;
    1e44:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e48:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e4c:	2501                	sext.w	a0,a0
    1e4e:	8082                	ret

0000000000001e50 <brk>:
    register long a7 __asm__("a7") = n;
    1e50:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e54:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e58:	2501                	sext.w	a0,a0
    1e5a:	8082                	ret

0000000000001e5c <getcwd>:
    register long a7 __asm__("a7") = n;
    1e5c:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e5e:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e62:	8082                	ret

0000000000001e64 <chdir>:
    register long a7 __asm__("a7") = n;
    1e64:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e68:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e6c:	2501                	sext.w	a0,a0
    1e6e:	8082                	ret

0000000000001e70 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e70:	862e                	mv	a2,a1
    1e72:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e74:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e76:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e7a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e7e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e80:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e82:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e86:	2501                	sext.w	a0,a0
    1e88:	8082                	ret

0000000000001e8a <getdents>:
    register long a7 __asm__("a7") = n;
    1e8a:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e8e:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e92:	2501                	sext.w	a0,a0
    1e94:	8082                	ret

0000000000001e96 <pipe>:
    register long a7 __asm__("a7") = n;
    1e96:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e9a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e9c:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1ea0:	2501                	sext.w	a0,a0
    1ea2:	8082                	ret

0000000000001ea4 <dup>:
    register long a7 __asm__("a7") = n;
    1ea4:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1ea6:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1eaa:	2501                	sext.w	a0,a0
    1eac:	8082                	ret

0000000000001eae <dup2>:
    register long a7 __asm__("a7") = n;
    1eae:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1eb0:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eb2:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1eb6:	2501                	sext.w	a0,a0
    1eb8:	8082                	ret

0000000000001eba <mount>:
    register long a7 __asm__("a7") = n;
    1eba:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ebe:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ec2:	2501                	sext.w	a0,a0
    1ec4:	8082                	ret

0000000000001ec6 <umount>:
    register long a7 __asm__("a7") = n;
    1ec6:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1eca:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ecc:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ed0:	2501                	sext.w	a0,a0
    1ed2:	8082                	ret

0000000000001ed4 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ed4:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ed6:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ed8:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1eda:	8532                	mv	a0,a2
	mv a2, a4
    1edc:	863a                	mv	a2,a4
	mv a3, a5
    1ede:	86be                	mv	a3,a5
	mv a4, a6
    1ee0:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ee2:	0dc00893          	li	a7,220
	ecall
    1ee6:	00000073          	ecall

	beqz a0, 1f
    1eea:	c111                	beqz	a0,1eee <__clone+0x1a>
	# Parent
	ret
    1eec:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1eee:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ef0:	6522                	ld	a0,8(sp)
	jalr a1
    1ef2:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ef4:	05d00893          	li	a7,93
	ecall
    1ef8:	00000073          	ecall
