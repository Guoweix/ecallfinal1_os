
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/dup2:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a871                	j	109e <__start_main>

0000000000001004 <test_dup2>:

/*
 * 测试通过时应输出：
 * "  from fd 100"
 */
void test_dup2(){
    1004:	1141                	addi	sp,sp,-16
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	eda50513          	addi	a0,a0,-294 # 1ee0 <__clone+0x2a>
void test_dup2(){
    100e:	e406                	sd	ra,8(sp)
	TEST_START(__func__);
    1010:	300000ef          	jal	1310 <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	f5450513          	addi	a0,a0,-172 # 1f68 <__func__.0>
    101c:	2f4000ef          	jal	1310 <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ed850513          	addi	a0,a0,-296 # 1ef8 <__clone+0x42>
    1028:	2e8000ef          	jal	1310 <puts>
	int fd = dup2(STDOUT, 100);
    102c:	06400593          	li	a1,100
    1030:	4505                	li	a0,1
    1032:	65f000ef          	jal	1e90 <dup2>
	assert(fd != -1);
    1036:	57fd                	li	a5,-1
    1038:	04f50463          	beq	a0,a5,1080 <test_dup2+0x7c>
	const char *str = "  from fd 100\n";
	write(100, str, strlen(str));
    103c:	00001517          	auipc	a0,0x1
    1040:	eec50513          	addi	a0,a0,-276 # 1f28 <__clone+0x72>
    1044:	057000ef          	jal	189a <strlen>
    1048:	862a                	mv	a2,a0
    104a:	00001597          	auipc	a1,0x1
    104e:	ede58593          	addi	a1,a1,-290 # 1f28 <__clone+0x72>
    1052:	06400513          	li	a0,100
    1056:	429000ef          	jal	1c7e <write>
	TEST_END(__func__);
    105a:	00001517          	auipc	a0,0x1
    105e:	ede50513          	addi	a0,a0,-290 # 1f38 <__clone+0x82>
    1062:	2ae000ef          	jal	1310 <puts>
    1066:	00001517          	auipc	a0,0x1
    106a:	f0250513          	addi	a0,a0,-254 # 1f68 <__func__.0>
    106e:	2a2000ef          	jal	1310 <puts>
}
    1072:	60a2                	ld	ra,8(sp)
	TEST_END(__func__);
    1074:	00001517          	auipc	a0,0x1
    1078:	e8450513          	addi	a0,a0,-380 # 1ef8 <__clone+0x42>
}
    107c:	0141                	addi	sp,sp,16
	TEST_END(__func__);
    107e:	ac49                	j	1310 <puts>
	assert(fd != -1);
    1080:	00001517          	auipc	a0,0x1
    1084:	e8850513          	addi	a0,a0,-376 # 1f08 <__clone+0x52>
    1088:	534000ef          	jal	15bc <panic>
    108c:	bf45                	j	103c <test_dup2+0x38>

000000000000108e <main>:

int main(void) {
    108e:	1141                	addi	sp,sp,-16
    1090:	e406                	sd	ra,8(sp)
	test_dup2();
    1092:	f73ff0ef          	jal	1004 <test_dup2>
	return 0;
}
    1096:	60a2                	ld	ra,8(sp)
    1098:	4501                	li	a0,0
    109a:	0141                	addi	sp,sp,16
    109c:	8082                	ret

000000000000109e <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    109e:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10a0:	4108                	lw	a0,0(a0)
{
    10a2:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10a4:	05a1                	addi	a1,a1,8
{
    10a6:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10a8:	fe7ff0ef          	jal	108e <main>
    10ac:	423000ef          	jal	1cce <exit>
	return 0;
}
    10b0:	60a2                	ld	ra,8(sp)
    10b2:	4501                	li	a0,0
    10b4:	0141                	addi	sp,sp,16
    10b6:	8082                	ret

00000000000010b8 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10b8:	7179                	addi	sp,sp,-48
    10ba:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10bc:	12054b63          	bltz	a0,11f2 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10c0:	02b577bb          	remuw	a5,a0,a1
    10c4:	00001617          	auipc	a2,0x1
    10c8:	eb460613          	addi	a2,a2,-332 # 1f78 <digits>
    buf[16] = 0;
    10cc:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10d0:	0005871b          	sext.w	a4,a1
    10d4:	1782                	slli	a5,a5,0x20
    10d6:	9381                	srli	a5,a5,0x20
    10d8:	97b2                	add	a5,a5,a2
    10da:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10de:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10e2:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10e6:	1cb56363          	bltu	a0,a1,12ac <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    10ea:	45b9                	li	a1,14
    10ec:	02e877bb          	remuw	a5,a6,a4
    10f0:	1782                	slli	a5,a5,0x20
    10f2:	9381                	srli	a5,a5,0x20
    10f4:	97b2                	add	a5,a5,a2
    10f6:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10fa:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    10fe:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1102:	0ce86e63          	bltu	a6,a4,11de <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1106:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    110a:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    110e:	1582                	slli	a1,a1,0x20
    1110:	9181                	srli	a1,a1,0x20
    1112:	95b2                	add	a1,a1,a2
    1114:	0005c583          	lbu	a1,0(a1)
    1118:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    111c:	0007859b          	sext.w	a1,a5
    1120:	12e6ec63          	bltu	a3,a4,1258 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1124:	02e7f6bb          	remuw	a3,a5,a4
    1128:	1682                	slli	a3,a3,0x20
    112a:	9281                	srli	a3,a3,0x20
    112c:	96b2                	add	a3,a3,a2
    112e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1132:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1136:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    113a:	12e5e863          	bltu	a1,a4,126a <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    113e:	02e876bb          	remuw	a3,a6,a4
    1142:	1682                	slli	a3,a3,0x20
    1144:	9281                	srli	a3,a3,0x20
    1146:	96b2                	add	a3,a3,a2
    1148:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    114c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1150:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1154:	12e86463          	bltu	a6,a4,127c <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1158:	02e5f6bb          	remuw	a3,a1,a4
    115c:	1682                	slli	a3,a3,0x20
    115e:	9281                	srli	a3,a3,0x20
    1160:	96b2                	add	a3,a3,a2
    1162:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1166:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    116a:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    116e:	0ce5ec63          	bltu	a1,a4,1246 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    1172:	02e876bb          	remuw	a3,a6,a4
    1176:	1682                	slli	a3,a3,0x20
    1178:	9281                	srli	a3,a3,0x20
    117a:	96b2                	add	a3,a3,a2
    117c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1180:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1184:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    1188:	10e86963          	bltu	a6,a4,129a <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    118c:	02e5f6bb          	remuw	a3,a1,a4
    1190:	1682                	slli	a3,a3,0x20
    1192:	9281                	srli	a3,a3,0x20
    1194:	96b2                	add	a3,a3,a2
    1196:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    119a:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    119e:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11a2:	10e5e763          	bltu	a1,a4,12b0 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11a6:	02e876bb          	remuw	a3,a6,a4
    11aa:	1682                	slli	a3,a3,0x20
    11ac:	9281                	srli	a3,a3,0x20
    11ae:	96b2                	add	a3,a3,a2
    11b0:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11b4:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11b8:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11bc:	10e86363          	bltu	a6,a4,12c2 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11c0:	1782                	slli	a5,a5,0x20
    11c2:	9381                	srli	a5,a5,0x20
    11c4:	97b2                	add	a5,a5,a2
    11c6:	0007c783          	lbu	a5,0(a5)
    11ca:	4599                	li	a1,6
    11cc:	00f10723          	sb	a5,14(sp)

    if (sign)
    11d0:	00055763          	bgez	a0,11de <printint.constprop.0+0x126>
        buf[i--] = '-';
    11d4:	02d00793          	li	a5,45
    11d8:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11dc:	4595                	li	a1,5
    write(f, s, l);
    11de:	003c                	addi	a5,sp,8
    11e0:	4641                	li	a2,16
    11e2:	9e0d                	subw	a2,a2,a1
    11e4:	4505                	li	a0,1
    11e6:	95be                	add	a1,a1,a5
    11e8:	297000ef          	jal	1c7e <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11ec:	70a2                	ld	ra,40(sp)
    11ee:	6145                	addi	sp,sp,48
    11f0:	8082                	ret
        x = -xx;
    11f2:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    11f6:	02b877bb          	remuw	a5,a6,a1
    11fa:	00001617          	auipc	a2,0x1
    11fe:	d7e60613          	addi	a2,a2,-642 # 1f78 <digits>
    buf[16] = 0;
    1202:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1206:	0005871b          	sext.w	a4,a1
    120a:	1782                	slli	a5,a5,0x20
    120c:	9381                	srli	a5,a5,0x20
    120e:	97b2                	add	a5,a5,a2
    1210:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1214:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1218:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    121c:	06b86963          	bltu	a6,a1,128e <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1220:	02e8f7bb          	remuw	a5,a7,a4
    1224:	1782                	slli	a5,a5,0x20
    1226:	9381                	srli	a5,a5,0x20
    1228:	97b2                	add	a5,a5,a2
    122a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    122e:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1232:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1236:	ece8f8e3          	bgeu	a7,a4,1106 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    123a:	02d00793          	li	a5,45
    123e:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1242:	45b5                	li	a1,13
    1244:	bf69                	j	11de <printint.constprop.0+0x126>
    1246:	45a9                	li	a1,10
    if (sign)
    1248:	f8055be3          	bgez	a0,11de <printint.constprop.0+0x126>
        buf[i--] = '-';
    124c:	02d00793          	li	a5,45
    1250:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1254:	45a5                	li	a1,9
    1256:	b761                	j	11de <printint.constprop.0+0x126>
    1258:	45b5                	li	a1,13
    if (sign)
    125a:	f80552e3          	bgez	a0,11de <printint.constprop.0+0x126>
        buf[i--] = '-';
    125e:	02d00793          	li	a5,45
    1262:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1266:	45b1                	li	a1,12
    1268:	bf9d                	j	11de <printint.constprop.0+0x126>
    126a:	45b1                	li	a1,12
    if (sign)
    126c:	f60559e3          	bgez	a0,11de <printint.constprop.0+0x126>
        buf[i--] = '-';
    1270:	02d00793          	li	a5,45
    1274:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    1278:	45ad                	li	a1,11
    127a:	b795                	j	11de <printint.constprop.0+0x126>
    127c:	45ad                	li	a1,11
    if (sign)
    127e:	f60550e3          	bgez	a0,11de <printint.constprop.0+0x126>
        buf[i--] = '-';
    1282:	02d00793          	li	a5,45
    1286:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    128a:	45a9                	li	a1,10
    128c:	bf89                	j	11de <printint.constprop.0+0x126>
        buf[i--] = '-';
    128e:	02d00793          	li	a5,45
    1292:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1296:	45b9                	li	a1,14
    1298:	b799                	j	11de <printint.constprop.0+0x126>
    129a:	45a5                	li	a1,9
    if (sign)
    129c:	f40551e3          	bgez	a0,11de <printint.constprop.0+0x126>
        buf[i--] = '-';
    12a0:	02d00793          	li	a5,45
    12a4:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12a8:	45a1                	li	a1,8
    12aa:	bf15                	j	11de <printint.constprop.0+0x126>
    i = 15;
    12ac:	45bd                	li	a1,15
    12ae:	bf05                	j	11de <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12b0:	45a1                	li	a1,8
    if (sign)
    12b2:	f20556e3          	bgez	a0,11de <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b6:	02d00793          	li	a5,45
    12ba:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12be:	459d                	li	a1,7
    12c0:	bf39                	j	11de <printint.constprop.0+0x126>
    12c2:	459d                	li	a1,7
    if (sign)
    12c4:	f0055de3          	bgez	a0,11de <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c8:	02d00793          	li	a5,45
    12cc:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12d0:	4599                	li	a1,6
    12d2:	b731                	j	11de <printint.constprop.0+0x126>

00000000000012d4 <getchar>:
{
    12d4:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12d6:	00f10593          	addi	a1,sp,15
    12da:	4605                	li	a2,1
    12dc:	4501                	li	a0,0
{
    12de:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12e0:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12e4:	191000ef          	jal	1c74 <read>
}
    12e8:	60e2                	ld	ra,24(sp)
    12ea:	00f14503          	lbu	a0,15(sp)
    12ee:	6105                	addi	sp,sp,32
    12f0:	8082                	ret

00000000000012f2 <putchar>:
{
    12f2:	1101                	addi	sp,sp,-32
    12f4:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    12f6:	00f10593          	addi	a1,sp,15
    12fa:	4605                	li	a2,1
    12fc:	4505                	li	a0,1
{
    12fe:	ec06                	sd	ra,24(sp)
    char byte = c;
    1300:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1304:	17b000ef          	jal	1c7e <write>
}
    1308:	60e2                	ld	ra,24(sp)
    130a:	2501                	sext.w	a0,a0
    130c:	6105                	addi	sp,sp,32
    130e:	8082                	ret

0000000000001310 <puts>:
{
    1310:	1141                	addi	sp,sp,-16
    1312:	e406                	sd	ra,8(sp)
    1314:	e022                	sd	s0,0(sp)
    1316:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1318:	582000ef          	jal	189a <strlen>
    131c:	862a                	mv	a2,a0
    131e:	85a2                	mv	a1,s0
    1320:	4505                	li	a0,1
    1322:	15d000ef          	jal	1c7e <write>
}
    1326:	60a2                	ld	ra,8(sp)
    1328:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    132a:	957d                	srai	a0,a0,0x3f
    return r;
    132c:	2501                	sext.w	a0,a0
}
    132e:	0141                	addi	sp,sp,16
    1330:	8082                	ret

0000000000001332 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1332:	7131                	addi	sp,sp,-192
    1334:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1336:	013c                	addi	a5,sp,136
{
    1338:	f0ca                	sd	s2,96(sp)
    133a:	ecce                	sd	s3,88(sp)
    133c:	e8d2                	sd	s4,80(sp)
    133e:	e4d6                	sd	s5,72(sp)
    1340:	e0da                	sd	s6,64(sp)
    1342:	fc5e                	sd	s7,56(sp)
    1344:	fc86                	sd	ra,120(sp)
    1346:	f8a2                	sd	s0,112(sp)
    1348:	f4a6                	sd	s1,104(sp)
    134a:	e52e                	sd	a1,136(sp)
    134c:	e932                	sd	a2,144(sp)
    134e:	ed36                	sd	a3,152(sp)
    1350:	f13a                	sd	a4,160(sp)
    1352:	f942                	sd	a6,176(sp)
    1354:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1356:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1358:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    135c:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1360:	00001b97          	auipc	s7,0x1
    1364:	be8b8b93          	addi	s7,s7,-1048 # 1f48 <__clone+0x92>
        switch (s[1])
    1368:	07800a93          	li	s5,120
    136c:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1370:	00001997          	auipc	s3,0x1
    1374:	c0898993          	addi	s3,s3,-1016 # 1f78 <digits>
        if (!*s)
    1378:	00054783          	lbu	a5,0(a0)
    137c:	16078c63          	beqz	a5,14f4 <printf+0x1c2>
    1380:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1382:	19278463          	beq	a5,s2,150a <printf+0x1d8>
    1386:	00164783          	lbu	a5,1(a2)
    138a:	0605                	addi	a2,a2,1
    138c:	fbfd                	bnez	a5,1382 <printf+0x50>
    138e:	84b2                	mv	s1,a2
        l = z - a;
    1390:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1394:	85aa                	mv	a1,a0
    1396:	8622                	mv	a2,s0
    1398:	4505                	li	a0,1
    139a:	0e5000ef          	jal	1c7e <write>
        if (l)
    139e:	18041f63          	bnez	s0,153c <printf+0x20a>
        if (s[1] == 0)
    13a2:	0014c783          	lbu	a5,1(s1)
    13a6:	14078763          	beqz	a5,14f4 <printf+0x1c2>
        switch (s[1])
    13aa:	1d478163          	beq	a5,s4,156c <printf+0x23a>
    13ae:	18fa6963          	bltu	s4,a5,1540 <printf+0x20e>
    13b2:	1b678363          	beq	a5,s6,1558 <printf+0x226>
    13b6:	07000713          	li	a4,112
    13ba:	1ce79c63          	bne	a5,a4,1592 <printf+0x260>
            printptr(va_arg(ap, uint64));
    13be:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13c0:	03000793          	li	a5,48
    13c4:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13c8:	631c                	ld	a5,0(a4)
    13ca:	0721                	addi	a4,a4,8
    13cc:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13ce:	00479f93          	slli	t6,a5,0x4
    13d2:	00879f13          	slli	t5,a5,0x8
    13d6:	00c79e93          	slli	t4,a5,0xc
    13da:	01079e13          	slli	t3,a5,0x10
    13de:	01479313          	slli	t1,a5,0x14
    13e2:	01879893          	slli	a7,a5,0x18
    13e6:	01c79713          	slli	a4,a5,0x1c
    13ea:	02479813          	slli	a6,a5,0x24
    13ee:	02879513          	slli	a0,a5,0x28
    13f2:	02c79593          	slli	a1,a5,0x2c
    13f6:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13fa:	03c7d293          	srli	t0,a5,0x3c
    13fe:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1402:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1406:	03cfdf93          	srli	t6,t6,0x3c
    140a:	03cf5f13          	srli	t5,t5,0x3c
    140e:	03cede93          	srli	t4,t4,0x3c
    1412:	03ce5e13          	srli	t3,t3,0x3c
    1416:	03c35313          	srli	t1,t1,0x3c
    141a:	03c8d893          	srli	a7,a7,0x3c
    141e:	9371                	srli	a4,a4,0x3c
    1420:	03c85813          	srli	a6,a6,0x3c
    1424:	9171                	srli	a0,a0,0x3c
    1426:	91f1                	srli	a1,a1,0x3c
    1428:	9271                	srli	a2,a2,0x3c
    142a:	974e                	add	a4,a4,s3
    142c:	92f1                	srli	a3,a3,0x3c
    142e:	92ce                	add	t0,t0,s3
    1430:	9fce                	add	t6,t6,s3
    1432:	9f4e                	add	t5,t5,s3
    1434:	9ece                	add	t4,t4,s3
    1436:	9e4e                	add	t3,t3,s3
    1438:	934e                	add	t1,t1,s3
    143a:	98ce                	add	a7,a7,s3
    143c:	93ce                	add	t2,t2,s3
    143e:	984e                	add	a6,a6,s3
    1440:	954e                	add	a0,a0,s3
    1442:	95ce                	add	a1,a1,s3
    1444:	964e                	add	a2,a2,s3
    1446:	0002c283          	lbu	t0,0(t0)
    144a:	000fcf83          	lbu	t6,0(t6)
    144e:	000f4f03          	lbu	t5,0(t5)
    1452:	000ece83          	lbu	t4,0(t4)
    1456:	000e4e03          	lbu	t3,0(t3)
    145a:	00034303          	lbu	t1,0(t1)
    145e:	0008c883          	lbu	a7,0(a7)
    1462:	00074403          	lbu	s0,0(a4)
    1466:	0003c383          	lbu	t2,0(t2)
    146a:	00084803          	lbu	a6,0(a6)
    146e:	00054503          	lbu	a0,0(a0)
    1472:	0005c583          	lbu	a1,0(a1)
    1476:	00064603          	lbu	a2,0(a2)
    147a:	00d98733          	add	a4,s3,a3
    147e:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1482:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1486:	9371                	srli	a4,a4,0x3c
    1488:	8bbd                	andi	a5,a5,15
    148a:	00510523          	sb	t0,10(sp)
    148e:	01f105a3          	sb	t6,11(sp)
    1492:	01e10623          	sb	t5,12(sp)
    1496:	01d106a3          	sb	t4,13(sp)
    149a:	01c10723          	sb	t3,14(sp)
    149e:	006107a3          	sb	t1,15(sp)
    14a2:	01110823          	sb	a7,16(sp)
    14a6:	00710923          	sb	t2,18(sp)
    14aa:	010109a3          	sb	a6,19(sp)
    14ae:	00a10a23          	sb	a0,20(sp)
    14b2:	00b10aa3          	sb	a1,21(sp)
    14b6:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14ba:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14be:	008108a3          	sb	s0,17(sp)
    14c2:	974e                	add	a4,a4,s3
    14c4:	97ce                	add	a5,a5,s3
    14c6:	00d10ba3          	sb	a3,23(sp)
    14ca:	00074703          	lbu	a4,0(a4)
    14ce:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14d2:	4649                	li	a2,18
    14d4:	002c                	addi	a1,sp,8
    14d6:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14d8:	00e10c23          	sb	a4,24(sp)
    14dc:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14e0:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14e4:	79a000ef          	jal	1c7e <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14e8:	00248513          	addi	a0,s1,2
        if (!*s)
    14ec:	00054783          	lbu	a5,0(a0)
    14f0:	e80798e3          	bnez	a5,1380 <printf+0x4e>
    }
    va_end(ap);
}
    14f4:	70e6                	ld	ra,120(sp)
    14f6:	7446                	ld	s0,112(sp)
    14f8:	74a6                	ld	s1,104(sp)
    14fa:	7906                	ld	s2,96(sp)
    14fc:	69e6                	ld	s3,88(sp)
    14fe:	6a46                	ld	s4,80(sp)
    1500:	6aa6                	ld	s5,72(sp)
    1502:	6b06                	ld	s6,64(sp)
    1504:	7be2                	ld	s7,56(sp)
    1506:	6129                	addi	sp,sp,192
    1508:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    150a:	00064783          	lbu	a5,0(a2)
    150e:	84b2                	mv	s1,a2
    1510:	01278963          	beq	a5,s2,1522 <printf+0x1f0>
    1514:	bdb5                	j	1390 <printf+0x5e>
    1516:	0024c783          	lbu	a5,2(s1)
    151a:	0605                	addi	a2,a2,1
    151c:	0489                	addi	s1,s1,2
    151e:	e72799e3          	bne	a5,s2,1390 <printf+0x5e>
    1522:	0014c783          	lbu	a5,1(s1)
    1526:	ff2788e3          	beq	a5,s2,1516 <printf+0x1e4>
        l = z - a;
    152a:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    152e:	85aa                	mv	a1,a0
    1530:	8622                	mv	a2,s0
    1532:	4505                	li	a0,1
    1534:	74a000ef          	jal	1c7e <write>
        if (l)
    1538:	e60405e3          	beqz	s0,13a2 <printf+0x70>
    153c:	8526                	mv	a0,s1
    153e:	bd2d                	j	1378 <printf+0x46>
        switch (s[1])
    1540:	05579963          	bne	a5,s5,1592 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1544:	6782                	ld	a5,0(sp)
    1546:	45c1                	li	a1,16
    1548:	4388                	lw	a0,0(a5)
    154a:	07a1                	addi	a5,a5,8
    154c:	e03e                	sd	a5,0(sp)
    154e:	b6bff0ef          	jal	10b8 <printint.constprop.0>
        s += 2;
    1552:	00248513          	addi	a0,s1,2
    1556:	bf59                	j	14ec <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1558:	6782                	ld	a5,0(sp)
    155a:	45a9                	li	a1,10
    155c:	4388                	lw	a0,0(a5)
    155e:	07a1                	addi	a5,a5,8
    1560:	e03e                	sd	a5,0(sp)
    1562:	b57ff0ef          	jal	10b8 <printint.constprop.0>
        s += 2;
    1566:	00248513          	addi	a0,s1,2
    156a:	b749                	j	14ec <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    156c:	6782                	ld	a5,0(sp)
    156e:	6380                	ld	s0,0(a5)
    1570:	07a1                	addi	a5,a5,8
    1572:	e03e                	sd	a5,0(sp)
    1574:	c031                	beqz	s0,15b8 <printf+0x286>
            l = strnlen(a, 200);
    1576:	0c800593          	li	a1,200
    157a:	8522                	mv	a0,s0
    157c:	40a000ef          	jal	1986 <strnlen>
    write(f, s, l);
    1580:	0005061b          	sext.w	a2,a0
    1584:	85a2                	mv	a1,s0
    1586:	4505                	li	a0,1
    1588:	6f6000ef          	jal	1c7e <write>
        s += 2;
    158c:	00248513          	addi	a0,s1,2
    1590:	bfb1                	j	14ec <printf+0x1ba>
    return write(stdout, &byte, 1);
    1592:	4605                	li	a2,1
    1594:	002c                	addi	a1,sp,8
    1596:	4505                	li	a0,1
    char byte = c;
    1598:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    159c:	6e2000ef          	jal	1c7e <write>
    char byte = c;
    15a0:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15a4:	4605                	li	a2,1
    15a6:	002c                	addi	a1,sp,8
    15a8:	4505                	li	a0,1
    char byte = c;
    15aa:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15ae:	6d0000ef          	jal	1c7e <write>
        s += 2;
    15b2:	00248513          	addi	a0,s1,2
    15b6:	bf1d                	j	14ec <printf+0x1ba>
                a = "(null)";
    15b8:	845e                	mv	s0,s7
    15ba:	bf75                	j	1576 <printf+0x244>

00000000000015bc <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15bc:	1141                	addi	sp,sp,-16
    15be:	e406                	sd	ra,8(sp)
    puts(m);
    15c0:	d51ff0ef          	jal	1310 <puts>
    exit(-100);
}
    15c4:	60a2                	ld	ra,8(sp)
    exit(-100);
    15c6:	f9c00513          	li	a0,-100
}
    15ca:	0141                	addi	sp,sp,16
    exit(-100);
    15cc:	a709                	j	1cce <exit>

00000000000015ce <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15ce:	02000793          	li	a5,32
    15d2:	00f50663          	beq	a0,a5,15de <isspace+0x10>
    15d6:	355d                	addiw	a0,a0,-9
    15d8:	00553513          	sltiu	a0,a0,5
    15dc:	8082                	ret
    15de:	4505                	li	a0,1
}
    15e0:	8082                	ret

00000000000015e2 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15e2:	fd05051b          	addiw	a0,a0,-48
}
    15e6:	00a53513          	sltiu	a0,a0,10
    15ea:	8082                	ret

00000000000015ec <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15ec:	02000613          	li	a2,32
    15f0:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15f2:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15f6:	ff77069b          	addiw	a3,a4,-9
    15fa:	04c70d63          	beq	a4,a2,1654 <atoi+0x68>
    15fe:	0007079b          	sext.w	a5,a4
    1602:	04d5f963          	bgeu	a1,a3,1654 <atoi+0x68>
        s++;
    switch (*s)
    1606:	02b00693          	li	a3,43
    160a:	04d70a63          	beq	a4,a3,165e <atoi+0x72>
    160e:	02d00693          	li	a3,45
    1612:	06d70463          	beq	a4,a3,167a <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1616:	fd07859b          	addiw	a1,a5,-48
    161a:	4625                	li	a2,9
    161c:	873e                	mv	a4,a5
    161e:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1620:	4e01                	li	t3,0
    while (isdigit(*s))
    1622:	04b66a63          	bltu	a2,a1,1676 <atoi+0x8a>
    int n = 0, neg = 0;
    1626:	4501                	li	a0,0
    while (isdigit(*s))
    1628:	4825                	li	a6,9
    162a:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    162e:	0025179b          	slliw	a5,a0,0x2
    1632:	9d3d                	addw	a0,a0,a5
    1634:	fd07031b          	addiw	t1,a4,-48
    1638:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    163c:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1640:	0685                	addi	a3,a3,1
    1642:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1646:	0006071b          	sext.w	a4,a2
    164a:	feb870e3          	bgeu	a6,a1,162a <atoi+0x3e>
    return neg ? n : -n;
    164e:	000e0563          	beqz	t3,1658 <atoi+0x6c>
}
    1652:	8082                	ret
        s++;
    1654:	0505                	addi	a0,a0,1
    1656:	bf71                	j	15f2 <atoi+0x6>
    return neg ? n : -n;
    1658:	4113053b          	subw	a0,t1,a7
    165c:	8082                	ret
    while (isdigit(*s))
    165e:	00154783          	lbu	a5,1(a0)
    1662:	4625                	li	a2,9
        s++;
    1664:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1668:	fd07859b          	addiw	a1,a5,-48
    166c:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1670:	4e01                	li	t3,0
    while (isdigit(*s))
    1672:	fab67ae3          	bgeu	a2,a1,1626 <atoi+0x3a>
    1676:	4501                	li	a0,0
}
    1678:	8082                	ret
    while (isdigit(*s))
    167a:	00154783          	lbu	a5,1(a0)
    167e:	4625                	li	a2,9
        s++;
    1680:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1684:	fd07859b          	addiw	a1,a5,-48
    1688:	0007871b          	sext.w	a4,a5
    168c:	feb665e3          	bltu	a2,a1,1676 <atoi+0x8a>
        neg = 1;
    1690:	4e05                	li	t3,1
    1692:	bf51                	j	1626 <atoi+0x3a>

0000000000001694 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1694:	16060d63          	beqz	a2,180e <memset+0x17a>
    1698:	40a007b3          	neg	a5,a0
    169c:	8b9d                	andi	a5,a5,7
    169e:	00778713          	addi	a4,a5,7
    16a2:	482d                	li	a6,11
    16a4:	0ff5f593          	zext.b	a1,a1
    16a8:	fff60693          	addi	a3,a2,-1
    16ac:	17076263          	bltu	a4,a6,1810 <memset+0x17c>
    16b0:	16e6ea63          	bltu	a3,a4,1824 <memset+0x190>
    16b4:	16078563          	beqz	a5,181e <memset+0x18a>
    16b8:	00b50023          	sb	a1,0(a0)
    16bc:	4705                	li	a4,1
    16be:	00150e93          	addi	t4,a0,1
    16c2:	14e78c63          	beq	a5,a4,181a <memset+0x186>
    16c6:	00b500a3          	sb	a1,1(a0)
    16ca:	4709                	li	a4,2
    16cc:	00250e93          	addi	t4,a0,2
    16d0:	14e78d63          	beq	a5,a4,182a <memset+0x196>
    16d4:	00b50123          	sb	a1,2(a0)
    16d8:	470d                	li	a4,3
    16da:	00350e93          	addi	t4,a0,3
    16de:	12e78b63          	beq	a5,a4,1814 <memset+0x180>
    16e2:	00b501a3          	sb	a1,3(a0)
    16e6:	4711                	li	a4,4
    16e8:	00450e93          	addi	t4,a0,4
    16ec:	14e78163          	beq	a5,a4,182e <memset+0x19a>
    16f0:	00b50223          	sb	a1,4(a0)
    16f4:	4715                	li	a4,5
    16f6:	00550e93          	addi	t4,a0,5
    16fa:	12e78c63          	beq	a5,a4,1832 <memset+0x19e>
    16fe:	00b502a3          	sb	a1,5(a0)
    1702:	471d                	li	a4,7
    1704:	00650e93          	addi	t4,a0,6
    1708:	12e79763          	bne	a5,a4,1836 <memset+0x1a2>
    170c:	00750e93          	addi	t4,a0,7
    1710:	00b50323          	sb	a1,6(a0)
    1714:	4f1d                	li	t5,7
    1716:	00859713          	slli	a4,a1,0x8
    171a:	8f4d                	or	a4,a4,a1
    171c:	01059e13          	slli	t3,a1,0x10
    1720:	01c76e33          	or	t3,a4,t3
    1724:	01859313          	slli	t1,a1,0x18
    1728:	006e6333          	or	t1,t3,t1
    172c:	02059893          	slli	a7,a1,0x20
    1730:	011368b3          	or	a7,t1,a7
    1734:	02859813          	slli	a6,a1,0x28
    1738:	40f60333          	sub	t1,a2,a5
    173c:	0108e833          	or	a6,a7,a6
    1740:	03059693          	slli	a3,a1,0x30
    1744:	00d866b3          	or	a3,a6,a3
    1748:	03859713          	slli	a4,a1,0x38
    174c:	97aa                	add	a5,a5,a0
    174e:	ff837813          	andi	a6,t1,-8
    1752:	8f55                	or	a4,a4,a3
    1754:	00f806b3          	add	a3,a6,a5
    1758:	e398                	sd	a4,0(a5)
    175a:	07a1                	addi	a5,a5,8
    175c:	fed79ee3          	bne	a5,a3,1758 <memset+0xc4>
    1760:	ff837693          	andi	a3,t1,-8
    1764:	00de87b3          	add	a5,t4,a3
    1768:	01e6873b          	addw	a4,a3,t5
    176c:	0ad30663          	beq	t1,a3,1818 <memset+0x184>
    1770:	00b78023          	sb	a1,0(a5)
    1774:	0017069b          	addiw	a3,a4,1
    1778:	08c6fb63          	bgeu	a3,a2,180e <memset+0x17a>
    177c:	00b780a3          	sb	a1,1(a5)
    1780:	0027069b          	addiw	a3,a4,2
    1784:	08c6f563          	bgeu	a3,a2,180e <memset+0x17a>
    1788:	00b78123          	sb	a1,2(a5)
    178c:	0037069b          	addiw	a3,a4,3
    1790:	06c6ff63          	bgeu	a3,a2,180e <memset+0x17a>
    1794:	00b781a3          	sb	a1,3(a5)
    1798:	0047069b          	addiw	a3,a4,4
    179c:	06c6f963          	bgeu	a3,a2,180e <memset+0x17a>
    17a0:	00b78223          	sb	a1,4(a5)
    17a4:	0057069b          	addiw	a3,a4,5
    17a8:	06c6f363          	bgeu	a3,a2,180e <memset+0x17a>
    17ac:	00b782a3          	sb	a1,5(a5)
    17b0:	0067069b          	addiw	a3,a4,6
    17b4:	04c6fd63          	bgeu	a3,a2,180e <memset+0x17a>
    17b8:	00b78323          	sb	a1,6(a5)
    17bc:	0077069b          	addiw	a3,a4,7
    17c0:	04c6f763          	bgeu	a3,a2,180e <memset+0x17a>
    17c4:	00b783a3          	sb	a1,7(a5)
    17c8:	0087069b          	addiw	a3,a4,8
    17cc:	04c6f163          	bgeu	a3,a2,180e <memset+0x17a>
    17d0:	00b78423          	sb	a1,8(a5)
    17d4:	0097069b          	addiw	a3,a4,9
    17d8:	02c6fb63          	bgeu	a3,a2,180e <memset+0x17a>
    17dc:	00b784a3          	sb	a1,9(a5)
    17e0:	00a7069b          	addiw	a3,a4,10
    17e4:	02c6f563          	bgeu	a3,a2,180e <memset+0x17a>
    17e8:	00b78523          	sb	a1,10(a5)
    17ec:	00b7069b          	addiw	a3,a4,11
    17f0:	00c6ff63          	bgeu	a3,a2,180e <memset+0x17a>
    17f4:	00b785a3          	sb	a1,11(a5)
    17f8:	00c7069b          	addiw	a3,a4,12
    17fc:	00c6f963          	bgeu	a3,a2,180e <memset+0x17a>
    1800:	00b78623          	sb	a1,12(a5)
    1804:	2735                	addiw	a4,a4,13
    1806:	00c77463          	bgeu	a4,a2,180e <memset+0x17a>
    180a:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    180e:	8082                	ret
    1810:	472d                	li	a4,11
    1812:	bd79                	j	16b0 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1814:	4f0d                	li	t5,3
    1816:	b701                	j	1716 <memset+0x82>
    1818:	8082                	ret
    181a:	4f05                	li	t5,1
    181c:	bded                	j	1716 <memset+0x82>
    181e:	8eaa                	mv	t4,a0
    1820:	4f01                	li	t5,0
    1822:	bdd5                	j	1716 <memset+0x82>
    1824:	87aa                	mv	a5,a0
    1826:	4701                	li	a4,0
    1828:	b7a1                	j	1770 <memset+0xdc>
    182a:	4f09                	li	t5,2
    182c:	b5ed                	j	1716 <memset+0x82>
    182e:	4f11                	li	t5,4
    1830:	b5dd                	j	1716 <memset+0x82>
    1832:	4f15                	li	t5,5
    1834:	b5cd                	j	1716 <memset+0x82>
    1836:	4f19                	li	t5,6
    1838:	bdf9                	j	1716 <memset+0x82>

000000000000183a <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    183a:	00054783          	lbu	a5,0(a0)
    183e:	0005c703          	lbu	a4,0(a1)
    1842:	00e79863          	bne	a5,a4,1852 <strcmp+0x18>
    1846:	0505                	addi	a0,a0,1
    1848:	0585                	addi	a1,a1,1
    184a:	fbe5                	bnez	a5,183a <strcmp>
    184c:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    184e:	9d19                	subw	a0,a0,a4
    1850:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1852:	0007851b          	sext.w	a0,a5
    1856:	bfe5                	j	184e <strcmp+0x14>

0000000000001858 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1858:	ce05                	beqz	a2,1890 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    185a:	00054703          	lbu	a4,0(a0)
    185e:	0005c783          	lbu	a5,0(a1)
    1862:	cb0d                	beqz	a4,1894 <strncmp+0x3c>
    if (!n--)
    1864:	167d                	addi	a2,a2,-1
    1866:	00c506b3          	add	a3,a0,a2
    186a:	a819                	j	1880 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    186c:	00a68e63          	beq	a3,a0,1888 <strncmp+0x30>
    1870:	0505                	addi	a0,a0,1
    1872:	00e79b63          	bne	a5,a4,1888 <strncmp+0x30>
    1876:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    187a:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    187e:	cb19                	beqz	a4,1894 <strncmp+0x3c>
    1880:	0005c783          	lbu	a5,0(a1)
    1884:	0585                	addi	a1,a1,1
    1886:	f3fd                	bnez	a5,186c <strncmp+0x14>
    return *l - *r;
    1888:	0007051b          	sext.w	a0,a4
    188c:	9d1d                	subw	a0,a0,a5
    188e:	8082                	ret
        return 0;
    1890:	4501                	li	a0,0
}
    1892:	8082                	ret
    1894:	4501                	li	a0,0
    return *l - *r;
    1896:	9d1d                	subw	a0,a0,a5
    1898:	8082                	ret

000000000000189a <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    189a:	00757793          	andi	a5,a0,7
    189e:	cf89                	beqz	a5,18b8 <strlen+0x1e>
    18a0:	87aa                	mv	a5,a0
    18a2:	a029                	j	18ac <strlen+0x12>
    18a4:	0785                	addi	a5,a5,1
    18a6:	0077f713          	andi	a4,a5,7
    18aa:	cb01                	beqz	a4,18ba <strlen+0x20>
        if (!*s)
    18ac:	0007c703          	lbu	a4,0(a5)
    18b0:	fb75                	bnez	a4,18a4 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18b2:	40a78533          	sub	a0,a5,a0
}
    18b6:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18b8:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18ba:	6394                	ld	a3,0(a5)
    18bc:	00000597          	auipc	a1,0x0
    18c0:	6945b583          	ld	a1,1684(a1) # 1f50 <__clone+0x9a>
    18c4:	00000617          	auipc	a2,0x0
    18c8:	69463603          	ld	a2,1684(a2) # 1f58 <__clone+0xa2>
    18cc:	a019                	j	18d2 <strlen+0x38>
    18ce:	6794                	ld	a3,8(a5)
    18d0:	07a1                	addi	a5,a5,8
    18d2:	00b68733          	add	a4,a3,a1
    18d6:	fff6c693          	not	a3,a3
    18da:	8f75                	and	a4,a4,a3
    18dc:	8f71                	and	a4,a4,a2
    18de:	db65                	beqz	a4,18ce <strlen+0x34>
    for (; *s; s++)
    18e0:	0007c703          	lbu	a4,0(a5)
    18e4:	d779                	beqz	a4,18b2 <strlen+0x18>
    18e6:	0017c703          	lbu	a4,1(a5)
    18ea:	0785                	addi	a5,a5,1
    18ec:	d379                	beqz	a4,18b2 <strlen+0x18>
    18ee:	0017c703          	lbu	a4,1(a5)
    18f2:	0785                	addi	a5,a5,1
    18f4:	fb6d                	bnez	a4,18e6 <strlen+0x4c>
    18f6:	bf75                	j	18b2 <strlen+0x18>

00000000000018f8 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18f8:	00757713          	andi	a4,a0,7
{
    18fc:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18fe:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1902:	cb19                	beqz	a4,1918 <memchr+0x20>
    1904:	ce25                	beqz	a2,197c <memchr+0x84>
    1906:	0007c703          	lbu	a4,0(a5)
    190a:	04b70e63          	beq	a4,a1,1966 <memchr+0x6e>
    190e:	0785                	addi	a5,a5,1
    1910:	0077f713          	andi	a4,a5,7
    1914:	167d                	addi	a2,a2,-1
    1916:	f77d                	bnez	a4,1904 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1918:	4501                	li	a0,0
    if (n && *s != c)
    191a:	c235                	beqz	a2,197e <memchr+0x86>
    191c:	0007c703          	lbu	a4,0(a5)
    1920:	04b70363          	beq	a4,a1,1966 <memchr+0x6e>
        size_t k = ONES * c;
    1924:	00000517          	auipc	a0,0x0
    1928:	63c53503          	ld	a0,1596(a0) # 1f60 <__clone+0xaa>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    192c:	471d                	li	a4,7
        size_t k = ONES * c;
    192e:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1932:	02c77a63          	bgeu	a4,a2,1966 <memchr+0x6e>
    1936:	00000897          	auipc	a7,0x0
    193a:	61a8b883          	ld	a7,1562(a7) # 1f50 <__clone+0x9a>
    193e:	00000817          	auipc	a6,0x0
    1942:	61a83803          	ld	a6,1562(a6) # 1f58 <__clone+0xa2>
    1946:	431d                	li	t1,7
    1948:	a029                	j	1952 <memchr+0x5a>
    194a:	1661                	addi	a2,a2,-8
    194c:	07a1                	addi	a5,a5,8
    194e:	02c37963          	bgeu	t1,a2,1980 <memchr+0x88>
    1952:	6398                	ld	a4,0(a5)
    1954:	8f29                	xor	a4,a4,a0
    1956:	011706b3          	add	a3,a4,a7
    195a:	fff74713          	not	a4,a4
    195e:	8f75                	and	a4,a4,a3
    1960:	01077733          	and	a4,a4,a6
    1964:	d37d                	beqz	a4,194a <memchr+0x52>
    1966:	853e                	mv	a0,a5
    1968:	97b2                	add	a5,a5,a2
    196a:	a021                	j	1972 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    196c:	0505                	addi	a0,a0,1
    196e:	00f50763          	beq	a0,a5,197c <memchr+0x84>
    1972:	00054703          	lbu	a4,0(a0)
    1976:	feb71be3          	bne	a4,a1,196c <memchr+0x74>
    197a:	8082                	ret
    return n ? (void *)s : 0;
    197c:	4501                	li	a0,0
}
    197e:	8082                	ret
    return n ? (void *)s : 0;
    1980:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1982:	f275                	bnez	a2,1966 <memchr+0x6e>
}
    1984:	8082                	ret

0000000000001986 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1986:	1101                	addi	sp,sp,-32
    1988:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    198a:	862e                	mv	a2,a1
{
    198c:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    198e:	4581                	li	a1,0
{
    1990:	e426                	sd	s1,8(sp)
    1992:	ec06                	sd	ra,24(sp)
    1994:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1996:	f63ff0ef          	jal	18f8 <memchr>
    return p ? p - s : n;
    199a:	c519                	beqz	a0,19a8 <strnlen+0x22>
}
    199c:	60e2                	ld	ra,24(sp)
    199e:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19a0:	8d05                	sub	a0,a0,s1
}
    19a2:	64a2                	ld	s1,8(sp)
    19a4:	6105                	addi	sp,sp,32
    19a6:	8082                	ret
    19a8:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19aa:	8522                	mv	a0,s0
}
    19ac:	6442                	ld	s0,16(sp)
    19ae:	64a2                	ld	s1,8(sp)
    19b0:	6105                	addi	sp,sp,32
    19b2:	8082                	ret

00000000000019b4 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19b4:	00b547b3          	xor	a5,a0,a1
    19b8:	8b9d                	andi	a5,a5,7
    19ba:	eb95                	bnez	a5,19ee <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19bc:	0075f793          	andi	a5,a1,7
    19c0:	e7b1                	bnez	a5,1a0c <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19c2:	6198                	ld	a4,0(a1)
    19c4:	00000617          	auipc	a2,0x0
    19c8:	58c63603          	ld	a2,1420(a2) # 1f50 <__clone+0x9a>
    19cc:	00000817          	auipc	a6,0x0
    19d0:	58c83803          	ld	a6,1420(a6) # 1f58 <__clone+0xa2>
    19d4:	a029                	j	19de <strcpy+0x2a>
    19d6:	e118                	sd	a4,0(a0)
    19d8:	6598                	ld	a4,8(a1)
    19da:	05a1                	addi	a1,a1,8
    19dc:	0521                	addi	a0,a0,8
    19de:	00c707b3          	add	a5,a4,a2
    19e2:	fff74693          	not	a3,a4
    19e6:	8ff5                	and	a5,a5,a3
    19e8:	0107f7b3          	and	a5,a5,a6
    19ec:	d7ed                	beqz	a5,19d6 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19ee:	0005c783          	lbu	a5,0(a1)
    19f2:	00f50023          	sb	a5,0(a0)
    19f6:	c785                	beqz	a5,1a1e <strcpy+0x6a>
    19f8:	0015c783          	lbu	a5,1(a1)
    19fc:	0505                	addi	a0,a0,1
    19fe:	0585                	addi	a1,a1,1
    1a00:	00f50023          	sb	a5,0(a0)
    1a04:	fbf5                	bnez	a5,19f8 <strcpy+0x44>
        ;
    return d;
}
    1a06:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a08:	0505                	addi	a0,a0,1
    1a0a:	df45                	beqz	a4,19c2 <strcpy+0xe>
            if (!(*d = *s))
    1a0c:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a10:	0585                	addi	a1,a1,1
    1a12:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a16:	00f50023          	sb	a5,0(a0)
    1a1a:	f7fd                	bnez	a5,1a08 <strcpy+0x54>
}
    1a1c:	8082                	ret
    1a1e:	8082                	ret

0000000000001a20 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a20:	00b547b3          	xor	a5,a0,a1
    1a24:	8b9d                	andi	a5,a5,7
    1a26:	1a079863          	bnez	a5,1bd6 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a2a:	0075f793          	andi	a5,a1,7
    1a2e:	16078463          	beqz	a5,1b96 <strncpy+0x176>
    1a32:	ea01                	bnez	a2,1a42 <strncpy+0x22>
    1a34:	a421                	j	1c3c <strncpy+0x21c>
    1a36:	167d                	addi	a2,a2,-1
    1a38:	0505                	addi	a0,a0,1
    1a3a:	14070e63          	beqz	a4,1b96 <strncpy+0x176>
    1a3e:	1a060863          	beqz	a2,1bee <strncpy+0x1ce>
    1a42:	0005c783          	lbu	a5,0(a1)
    1a46:	0585                	addi	a1,a1,1
    1a48:	0075f713          	andi	a4,a1,7
    1a4c:	00f50023          	sb	a5,0(a0)
    1a50:	f3fd                	bnez	a5,1a36 <strncpy+0x16>
    1a52:	4805                	li	a6,1
    1a54:	1a061863          	bnez	a2,1c04 <strncpy+0x1e4>
    1a58:	40a007b3          	neg	a5,a0
    1a5c:	8b9d                	andi	a5,a5,7
    1a5e:	4681                	li	a3,0
    1a60:	18061a63          	bnez	a2,1bf4 <strncpy+0x1d4>
    1a64:	00778713          	addi	a4,a5,7
    1a68:	45ad                	li	a1,11
    1a6a:	18b76363          	bltu	a4,a1,1bf0 <strncpy+0x1d0>
    1a6e:	1ae6eb63          	bltu	a3,a4,1c24 <strncpy+0x204>
    1a72:	1a078363          	beqz	a5,1c18 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a76:	00050023          	sb	zero,0(a0)
    1a7a:	4685                	li	a3,1
    1a7c:	00150713          	addi	a4,a0,1
    1a80:	18d78f63          	beq	a5,a3,1c1e <strncpy+0x1fe>
    1a84:	000500a3          	sb	zero,1(a0)
    1a88:	4689                	li	a3,2
    1a8a:	00250713          	addi	a4,a0,2
    1a8e:	18d78e63          	beq	a5,a3,1c2a <strncpy+0x20a>
    1a92:	00050123          	sb	zero,2(a0)
    1a96:	468d                	li	a3,3
    1a98:	00350713          	addi	a4,a0,3
    1a9c:	16d78c63          	beq	a5,a3,1c14 <strncpy+0x1f4>
    1aa0:	000501a3          	sb	zero,3(a0)
    1aa4:	4691                	li	a3,4
    1aa6:	00450713          	addi	a4,a0,4
    1aaa:	18d78263          	beq	a5,a3,1c2e <strncpy+0x20e>
    1aae:	00050223          	sb	zero,4(a0)
    1ab2:	4695                	li	a3,5
    1ab4:	00550713          	addi	a4,a0,5
    1ab8:	16d78d63          	beq	a5,a3,1c32 <strncpy+0x212>
    1abc:	000502a3          	sb	zero,5(a0)
    1ac0:	469d                	li	a3,7
    1ac2:	00650713          	addi	a4,a0,6
    1ac6:	16d79863          	bne	a5,a3,1c36 <strncpy+0x216>
    1aca:	00750713          	addi	a4,a0,7
    1ace:	00050323          	sb	zero,6(a0)
    1ad2:	40f80833          	sub	a6,a6,a5
    1ad6:	ff887593          	andi	a1,a6,-8
    1ada:	97aa                	add	a5,a5,a0
    1adc:	95be                	add	a1,a1,a5
    1ade:	0007b023          	sd	zero,0(a5)
    1ae2:	07a1                	addi	a5,a5,8
    1ae4:	feb79de3          	bne	a5,a1,1ade <strncpy+0xbe>
    1ae8:	ff887593          	andi	a1,a6,-8
    1aec:	9ead                	addw	a3,a3,a1
    1aee:	00b707b3          	add	a5,a4,a1
    1af2:	12b80863          	beq	a6,a1,1c22 <strncpy+0x202>
    1af6:	00078023          	sb	zero,0(a5)
    1afa:	0016871b          	addiw	a4,a3,1
    1afe:	0ec77863          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b02:	000780a3          	sb	zero,1(a5)
    1b06:	0026871b          	addiw	a4,a3,2
    1b0a:	0ec77263          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b0e:	00078123          	sb	zero,2(a5)
    1b12:	0036871b          	addiw	a4,a3,3
    1b16:	0cc77c63          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b1a:	000781a3          	sb	zero,3(a5)
    1b1e:	0046871b          	addiw	a4,a3,4
    1b22:	0cc77663          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b26:	00078223          	sb	zero,4(a5)
    1b2a:	0056871b          	addiw	a4,a3,5
    1b2e:	0cc77063          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b32:	000782a3          	sb	zero,5(a5)
    1b36:	0066871b          	addiw	a4,a3,6
    1b3a:	0ac77a63          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b3e:	00078323          	sb	zero,6(a5)
    1b42:	0076871b          	addiw	a4,a3,7
    1b46:	0ac77463          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b4a:	000783a3          	sb	zero,7(a5)
    1b4e:	0086871b          	addiw	a4,a3,8
    1b52:	08c77e63          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b56:	00078423          	sb	zero,8(a5)
    1b5a:	0096871b          	addiw	a4,a3,9
    1b5e:	08c77863          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b62:	000784a3          	sb	zero,9(a5)
    1b66:	00a6871b          	addiw	a4,a3,10
    1b6a:	08c77263          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b6e:	00078523          	sb	zero,10(a5)
    1b72:	00b6871b          	addiw	a4,a3,11
    1b76:	06c77c63          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b7a:	000785a3          	sb	zero,11(a5)
    1b7e:	00c6871b          	addiw	a4,a3,12
    1b82:	06c77663          	bgeu	a4,a2,1bee <strncpy+0x1ce>
    1b86:	00078623          	sb	zero,12(a5)
    1b8a:	26b5                	addiw	a3,a3,13
    1b8c:	06c6f163          	bgeu	a3,a2,1bee <strncpy+0x1ce>
    1b90:	000786a3          	sb	zero,13(a5)
    1b94:	8082                	ret
            ;
        if (!n || !*s)
    1b96:	c645                	beqz	a2,1c3e <strncpy+0x21e>
    1b98:	0005c783          	lbu	a5,0(a1)
    1b9c:	ea078be3          	beqz	a5,1a52 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1ba0:	479d                	li	a5,7
    1ba2:	02c7ff63          	bgeu	a5,a2,1be0 <strncpy+0x1c0>
    1ba6:	00000897          	auipc	a7,0x0
    1baa:	3aa8b883          	ld	a7,938(a7) # 1f50 <__clone+0x9a>
    1bae:	00000817          	auipc	a6,0x0
    1bb2:	3aa83803          	ld	a6,938(a6) # 1f58 <__clone+0xa2>
    1bb6:	431d                	li	t1,7
    1bb8:	6198                	ld	a4,0(a1)
    1bba:	011707b3          	add	a5,a4,a7
    1bbe:	fff74693          	not	a3,a4
    1bc2:	8ff5                	and	a5,a5,a3
    1bc4:	0107f7b3          	and	a5,a5,a6
    1bc8:	ef81                	bnez	a5,1be0 <strncpy+0x1c0>
            *wd = *ws;
    1bca:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bcc:	1661                	addi	a2,a2,-8
    1bce:	05a1                	addi	a1,a1,8
    1bd0:	0521                	addi	a0,a0,8
    1bd2:	fec363e3          	bltu	t1,a2,1bb8 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bd6:	e609                	bnez	a2,1be0 <strncpy+0x1c0>
    1bd8:	a08d                	j	1c3a <strncpy+0x21a>
    1bda:	167d                	addi	a2,a2,-1
    1bdc:	0505                	addi	a0,a0,1
    1bde:	ca01                	beqz	a2,1bee <strncpy+0x1ce>
    1be0:	0005c783          	lbu	a5,0(a1)
    1be4:	0585                	addi	a1,a1,1
    1be6:	00f50023          	sb	a5,0(a0)
    1bea:	fbe5                	bnez	a5,1bda <strncpy+0x1ba>
        ;
tail:
    1bec:	b59d                	j	1a52 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bee:	8082                	ret
    1bf0:	472d                	li	a4,11
    1bf2:	bdb5                	j	1a6e <strncpy+0x4e>
    1bf4:	00778713          	addi	a4,a5,7
    1bf8:	45ad                	li	a1,11
    1bfa:	fff60693          	addi	a3,a2,-1
    1bfe:	e6b778e3          	bgeu	a4,a1,1a6e <strncpy+0x4e>
    1c02:	b7fd                	j	1bf0 <strncpy+0x1d0>
    1c04:	40a007b3          	neg	a5,a0
    1c08:	8832                	mv	a6,a2
    1c0a:	8b9d                	andi	a5,a5,7
    1c0c:	4681                	li	a3,0
    1c0e:	e4060be3          	beqz	a2,1a64 <strncpy+0x44>
    1c12:	b7cd                	j	1bf4 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c14:	468d                	li	a3,3
    1c16:	bd75                	j	1ad2 <strncpy+0xb2>
    1c18:	872a                	mv	a4,a0
    1c1a:	4681                	li	a3,0
    1c1c:	bd5d                	j	1ad2 <strncpy+0xb2>
    1c1e:	4685                	li	a3,1
    1c20:	bd4d                	j	1ad2 <strncpy+0xb2>
    1c22:	8082                	ret
    1c24:	87aa                	mv	a5,a0
    1c26:	4681                	li	a3,0
    1c28:	b5f9                	j	1af6 <strncpy+0xd6>
    1c2a:	4689                	li	a3,2
    1c2c:	b55d                	j	1ad2 <strncpy+0xb2>
    1c2e:	4691                	li	a3,4
    1c30:	b54d                	j	1ad2 <strncpy+0xb2>
    1c32:	4695                	li	a3,5
    1c34:	bd79                	j	1ad2 <strncpy+0xb2>
    1c36:	4699                	li	a3,6
    1c38:	bd69                	j	1ad2 <strncpy+0xb2>
    1c3a:	8082                	ret
    1c3c:	8082                	ret
    1c3e:	8082                	ret

0000000000001c40 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c40:	87aa                	mv	a5,a0
    1c42:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c44:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c48:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c4c:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c4e:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c50:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c54:	2501                	sext.w	a0,a0
    1c56:	8082                	ret

0000000000001c58 <openat>:
    register long a7 __asm__("a7") = n;
    1c58:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c5c:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c60:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c64:	2501                	sext.w	a0,a0
    1c66:	8082                	ret

0000000000001c68 <close>:
    register long a7 __asm__("a7") = n;
    1c68:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c6c:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c70:	2501                	sext.w	a0,a0
    1c72:	8082                	ret

0000000000001c74 <read>:
    register long a7 __asm__("a7") = n;
    1c74:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c78:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c7c:	8082                	ret

0000000000001c7e <write>:
    register long a7 __asm__("a7") = n;
    1c7e:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c82:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c86:	8082                	ret

0000000000001c88 <getpid>:
    register long a7 __asm__("a7") = n;
    1c88:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c8c:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c90:	2501                	sext.w	a0,a0
    1c92:	8082                	ret

0000000000001c94 <getppid>:
    register long a7 __asm__("a7") = n;
    1c94:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c98:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c9c:	2501                	sext.w	a0,a0
    1c9e:	8082                	ret

0000000000001ca0 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1ca0:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1ca4:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1ca8:	2501                	sext.w	a0,a0
    1caa:	8082                	ret

0000000000001cac <fork>:
    register long a7 __asm__("a7") = n;
    1cac:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cb0:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cb2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cb4:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cb8:	2501                	sext.w	a0,a0
    1cba:	8082                	ret

0000000000001cbc <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cbc:	85b2                	mv	a1,a2
    1cbe:	863a                	mv	a2,a4
    if (stack)
    1cc0:	c191                	beqz	a1,1cc4 <clone+0x8>
	stack += stack_size;
    1cc2:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cc4:	4781                	li	a5,0
    1cc6:	4701                	li	a4,0
    1cc8:	4681                	li	a3,0
    1cca:	2601                	sext.w	a2,a2
    1ccc:	a2ed                	j	1eb6 <__clone>

0000000000001cce <exit>:
    register long a7 __asm__("a7") = n;
    1cce:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cd2:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cd6:	8082                	ret

0000000000001cd8 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cd8:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cdc:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cde:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1ce2:	2501                	sext.w	a0,a0
    1ce4:	8082                	ret

0000000000001ce6 <exec>:
    register long a7 __asm__("a7") = n;
    1ce6:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cea:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cee:	2501                	sext.w	a0,a0
    1cf0:	8082                	ret

0000000000001cf2 <execve>:
    register long a7 __asm__("a7") = n;
    1cf2:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cf6:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1cfa:	2501                	sext.w	a0,a0
    1cfc:	8082                	ret

0000000000001cfe <times>:
    register long a7 __asm__("a7") = n;
    1cfe:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d02:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d06:	2501                	sext.w	a0,a0
    1d08:	8082                	ret

0000000000001d0a <get_time>:

int64 get_time()
{
    1d0a:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d0c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d10:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d12:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d14:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d18:	2501                	sext.w	a0,a0
    1d1a:	ed09                	bnez	a0,1d34 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d1c:	67a2                	ld	a5,8(sp)
    1d1e:	3e800713          	li	a4,1000
    1d22:	00015503          	lhu	a0,0(sp)
    1d26:	02e7d7b3          	divu	a5,a5,a4
    1d2a:	02e50533          	mul	a0,a0,a4
    1d2e:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d30:	0141                	addi	sp,sp,16
    1d32:	8082                	ret
        return -1;
    1d34:	557d                	li	a0,-1
    1d36:	bfed                	j	1d30 <get_time+0x26>

0000000000001d38 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d38:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d3c:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d40:	2501                	sext.w	a0,a0
    1d42:	8082                	ret

0000000000001d44 <time>:
    register long a7 __asm__("a7") = n;
    1d44:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d48:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d4c:	2501                	sext.w	a0,a0
    1d4e:	8082                	ret

0000000000001d50 <sleep>:

int sleep(unsigned long long time)
{
    1d50:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d52:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d54:	850a                	mv	a0,sp
    1d56:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d58:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d5c:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d5e:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d62:	e501                	bnez	a0,1d6a <sleep+0x1a>
    return 0;
    1d64:	4501                	li	a0,0
}
    1d66:	0141                	addi	sp,sp,16
    1d68:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d6a:	4502                	lw	a0,0(sp)
}
    1d6c:	0141                	addi	sp,sp,16
    1d6e:	8082                	ret

0000000000001d70 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d70:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d74:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d78:	2501                	sext.w	a0,a0
    1d7a:	8082                	ret

0000000000001d7c <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d7c:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d80:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d84:	8082                	ret

0000000000001d86 <munmap>:
    register long a7 __asm__("a7") = n;
    1d86:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d8a:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d8e:	2501                	sext.w	a0,a0
    1d90:	8082                	ret

0000000000001d92 <wait>:

int wait(int *code)
{
    1d92:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d94:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d98:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d9a:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d9c:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d9e:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1da2:	2501                	sext.w	a0,a0
    1da4:	8082                	ret

0000000000001da6 <spawn>:
    register long a7 __asm__("a7") = n;
    1da6:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1daa:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dae:	2501                	sext.w	a0,a0
    1db0:	8082                	ret

0000000000001db2 <mailread>:
    register long a7 __asm__("a7") = n;
    1db2:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db6:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dba:	2501                	sext.w	a0,a0
    1dbc:	8082                	ret

0000000000001dbe <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dbe:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dc2:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dc6:	2501                	sext.w	a0,a0
    1dc8:	8082                	ret

0000000000001dca <fstat>:
    register long a7 __asm__("a7") = n;
    1dca:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dce:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dd2:	2501                	sext.w	a0,a0
    1dd4:	8082                	ret

0000000000001dd6 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dd6:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dd8:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1ddc:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dde:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1de2:	2501                	sext.w	a0,a0
    1de4:	8082                	ret

0000000000001de6 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1de6:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1de8:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1dec:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dee:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1df2:	2501                	sext.w	a0,a0
    1df4:	8082                	ret

0000000000001df6 <link>:

int link(char *old_path, char *new_path)
{
    1df6:	87aa                	mv	a5,a0
    1df8:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1dfa:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1dfe:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e02:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e04:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e08:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e0a:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e0e:	2501                	sext.w	a0,a0
    1e10:	8082                	ret

0000000000001e12 <unlink>:

int unlink(char *path)
{
    1e12:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e14:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e18:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e1c:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e1e:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e22:	2501                	sext.w	a0,a0
    1e24:	8082                	ret

0000000000001e26 <uname>:
    register long a7 __asm__("a7") = n;
    1e26:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e2a:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e2e:	2501                	sext.w	a0,a0
    1e30:	8082                	ret

0000000000001e32 <brk>:
    register long a7 __asm__("a7") = n;
    1e32:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e36:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e3a:	2501                	sext.w	a0,a0
    1e3c:	8082                	ret

0000000000001e3e <getcwd>:
    register long a7 __asm__("a7") = n;
    1e3e:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e40:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e44:	8082                	ret

0000000000001e46 <chdir>:
    register long a7 __asm__("a7") = n;
    1e46:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e4a:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e4e:	2501                	sext.w	a0,a0
    1e50:	8082                	ret

0000000000001e52 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e52:	862e                	mv	a2,a1
    1e54:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e56:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e58:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e5c:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e60:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e62:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e64:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e68:	2501                	sext.w	a0,a0
    1e6a:	8082                	ret

0000000000001e6c <getdents>:
    register long a7 __asm__("a7") = n;
    1e6c:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e70:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e74:	2501                	sext.w	a0,a0
    1e76:	8082                	ret

0000000000001e78 <pipe>:
    register long a7 __asm__("a7") = n;
    1e78:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e7c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e7e:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e82:	2501                	sext.w	a0,a0
    1e84:	8082                	ret

0000000000001e86 <dup>:
    register long a7 __asm__("a7") = n;
    1e86:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e88:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e8c:	2501                	sext.w	a0,a0
    1e8e:	8082                	ret

0000000000001e90 <dup2>:
    register long a7 __asm__("a7") = n;
    1e90:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e92:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e94:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e98:	2501                	sext.w	a0,a0
    1e9a:	8082                	ret

0000000000001e9c <mount>:
    register long a7 __asm__("a7") = n;
    1e9c:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ea0:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ea4:	2501                	sext.w	a0,a0
    1ea6:	8082                	ret

0000000000001ea8 <umount>:
    register long a7 __asm__("a7") = n;
    1ea8:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1eac:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eae:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1eb2:	2501                	sext.w	a0,a0
    1eb4:	8082                	ret

0000000000001eb6 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1eb6:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1eb8:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1eba:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ebc:	8532                	mv	a0,a2
	mv a2, a4
    1ebe:	863a                	mv	a2,a4
	mv a3, a5
    1ec0:	86be                	mv	a3,a5
	mv a4, a6
    1ec2:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ec4:	0dc00893          	li	a7,220
	ecall
    1ec8:	00000073          	ecall

	beqz a0, 1f
    1ecc:	c111                	beqz	a0,1ed0 <__clone+0x1a>
	# Parent
	ret
    1ece:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ed0:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ed2:	6522                	ld	a0,8(sp)
	jalr a1
    1ed4:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ed6:	05d00893          	li	a7,93
	ecall
    1eda:	00000073          	ecall
