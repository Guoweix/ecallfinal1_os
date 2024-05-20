
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/dup:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a069                	j	108c <__start_main>

0000000000001004 <test_dup>:
/*
 * 测试通过时应输出：
 * "  new fd is 3."
 */

void test_dup(){
    1004:	1101                	addi	sp,sp,-32
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	eca50513          	addi	a0,a0,-310 # 1ed0 <__clone+0x2c>
void test_dup(){
    100e:	ec06                	sd	ra,24(sp)
	TEST_START(__func__);
    1010:	2ee000ef          	jal	12fe <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	f4c50513          	addi	a0,a0,-180 # 1f60 <__func__.0>
    101c:	2e2000ef          	jal	12fe <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ec850513          	addi	a0,a0,-312 # 1ee8 <__clone+0x44>
    1028:	2d6000ef          	jal	12fe <puts>
	int fd = dup(STDOUT);
    102c:	4505                	li	a0,1
    102e:	647000ef          	jal	1e74 <dup>
    1032:	85aa                	mv	a1,a0
	assert(fd >=0);
    1034:	02054b63          	bltz	a0,106a <test_dup+0x66>
	printf("  new fd is %d.\n", fd);
    1038:	00001517          	auipc	a0,0x1
    103c:	ee050513          	addi	a0,a0,-288 # 1f18 <__clone+0x74>
    1040:	2e0000ef          	jal	1320 <printf>
	TEST_END(__func__);
    1044:	00001517          	auipc	a0,0x1
    1048:	eec50513          	addi	a0,a0,-276 # 1f30 <__clone+0x8c>
    104c:	2b2000ef          	jal	12fe <puts>
    1050:	00001517          	auipc	a0,0x1
    1054:	f1050513          	addi	a0,a0,-240 # 1f60 <__func__.0>
    1058:	2a6000ef          	jal	12fe <puts>
}
    105c:	60e2                	ld	ra,24(sp)
	TEST_END(__func__);
    105e:	00001517          	auipc	a0,0x1
    1062:	e8a50513          	addi	a0,a0,-374 # 1ee8 <__clone+0x44>
}
    1066:	6105                	addi	sp,sp,32
	TEST_END(__func__);
    1068:	ac59                	j	12fe <puts>
    106a:	e42a                	sd	a0,8(sp)
	assert(fd >=0);
    106c:	00001517          	auipc	a0,0x1
    1070:	e8c50513          	addi	a0,a0,-372 # 1ef8 <__clone+0x54>
    1074:	536000ef          	jal	15aa <panic>
    1078:	65a2                	ld	a1,8(sp)
    107a:	bf7d                	j	1038 <test_dup+0x34>

000000000000107c <main>:

int main(void) {
    107c:	1141                	addi	sp,sp,-16
    107e:	e406                	sd	ra,8(sp)
	test_dup();
    1080:	f85ff0ef          	jal	1004 <test_dup>
	return 0;
}
    1084:	60a2                	ld	ra,8(sp)
    1086:	4501                	li	a0,0
    1088:	0141                	addi	sp,sp,16
    108a:	8082                	ret

000000000000108c <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    108c:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    108e:	4108                	lw	a0,0(a0)
{
    1090:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1092:	05a1                	addi	a1,a1,8
{
    1094:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    1096:	fe7ff0ef          	jal	107c <main>
    109a:	423000ef          	jal	1cbc <exit>
	return 0;
}
    109e:	60a2                	ld	ra,8(sp)
    10a0:	4501                	li	a0,0
    10a2:	0141                	addi	sp,sp,16
    10a4:	8082                	ret

00000000000010a6 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10a6:	7179                	addi	sp,sp,-48
    10a8:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10aa:	12054b63          	bltz	a0,11e0 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10ae:	02b577bb          	remuw	a5,a0,a1
    10b2:	00001617          	auipc	a2,0x1
    10b6:	ebe60613          	addi	a2,a2,-322 # 1f70 <digits>
    buf[16] = 0;
    10ba:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10be:	0005871b          	sext.w	a4,a1
    10c2:	1782                	slli	a5,a5,0x20
    10c4:	9381                	srli	a5,a5,0x20
    10c6:	97b2                	add	a5,a5,a2
    10c8:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10cc:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10d0:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10d4:	1cb56363          	bltu	a0,a1,129a <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    10d8:	45b9                	li	a1,14
    10da:	02e877bb          	remuw	a5,a6,a4
    10de:	1782                	slli	a5,a5,0x20
    10e0:	9381                	srli	a5,a5,0x20
    10e2:	97b2                	add	a5,a5,a2
    10e4:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10e8:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    10ec:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    10f0:	0ce86e63          	bltu	a6,a4,11cc <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    10f4:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    10f8:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    10fc:	1582                	slli	a1,a1,0x20
    10fe:	9181                	srli	a1,a1,0x20
    1100:	95b2                	add	a1,a1,a2
    1102:	0005c583          	lbu	a1,0(a1)
    1106:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    110a:	0007859b          	sext.w	a1,a5
    110e:	12e6ec63          	bltu	a3,a4,1246 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1112:	02e7f6bb          	remuw	a3,a5,a4
    1116:	1682                	slli	a3,a3,0x20
    1118:	9281                	srli	a3,a3,0x20
    111a:	96b2                	add	a3,a3,a2
    111c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1120:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1124:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1128:	12e5e863          	bltu	a1,a4,1258 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    112c:	02e876bb          	remuw	a3,a6,a4
    1130:	1682                	slli	a3,a3,0x20
    1132:	9281                	srli	a3,a3,0x20
    1134:	96b2                	add	a3,a3,a2
    1136:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    113a:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    113e:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1142:	12e86463          	bltu	a6,a4,126a <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1146:	02e5f6bb          	remuw	a3,a1,a4
    114a:	1682                	slli	a3,a3,0x20
    114c:	9281                	srli	a3,a3,0x20
    114e:	96b2                	add	a3,a3,a2
    1150:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1154:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1158:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    115c:	0ce5ec63          	bltu	a1,a4,1234 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    1160:	02e876bb          	remuw	a3,a6,a4
    1164:	1682                	slli	a3,a3,0x20
    1166:	9281                	srli	a3,a3,0x20
    1168:	96b2                	add	a3,a3,a2
    116a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    116e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1172:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    1176:	10e86963          	bltu	a6,a4,1288 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    117a:	02e5f6bb          	remuw	a3,a1,a4
    117e:	1682                	slli	a3,a3,0x20
    1180:	9281                	srli	a3,a3,0x20
    1182:	96b2                	add	a3,a3,a2
    1184:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1188:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    118c:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1190:	10e5e763          	bltu	a1,a4,129e <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    1194:	02e876bb          	remuw	a3,a6,a4
    1198:	1682                	slli	a3,a3,0x20
    119a:	9281                	srli	a3,a3,0x20
    119c:	96b2                	add	a3,a3,a2
    119e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11a2:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11a6:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11aa:	10e86363          	bltu	a6,a4,12b0 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11ae:	1782                	slli	a5,a5,0x20
    11b0:	9381                	srli	a5,a5,0x20
    11b2:	97b2                	add	a5,a5,a2
    11b4:	0007c783          	lbu	a5,0(a5)
    11b8:	4599                	li	a1,6
    11ba:	00f10723          	sb	a5,14(sp)

    if (sign)
    11be:	00055763          	bgez	a0,11cc <printint.constprop.0+0x126>
        buf[i--] = '-';
    11c2:	02d00793          	li	a5,45
    11c6:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11ca:	4595                	li	a1,5
    write(f, s, l);
    11cc:	003c                	addi	a5,sp,8
    11ce:	4641                	li	a2,16
    11d0:	9e0d                	subw	a2,a2,a1
    11d2:	4505                	li	a0,1
    11d4:	95be                	add	a1,a1,a5
    11d6:	297000ef          	jal	1c6c <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11da:	70a2                	ld	ra,40(sp)
    11dc:	6145                	addi	sp,sp,48
    11de:	8082                	ret
        x = -xx;
    11e0:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    11e4:	02b877bb          	remuw	a5,a6,a1
    11e8:	00001617          	auipc	a2,0x1
    11ec:	d8860613          	addi	a2,a2,-632 # 1f70 <digits>
    buf[16] = 0;
    11f0:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    11f4:	0005871b          	sext.w	a4,a1
    11f8:	1782                	slli	a5,a5,0x20
    11fa:	9381                	srli	a5,a5,0x20
    11fc:	97b2                	add	a5,a5,a2
    11fe:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1202:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1206:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    120a:	06b86963          	bltu	a6,a1,127c <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    120e:	02e8f7bb          	remuw	a5,a7,a4
    1212:	1782                	slli	a5,a5,0x20
    1214:	9381                	srli	a5,a5,0x20
    1216:	97b2                	add	a5,a5,a2
    1218:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    121c:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1220:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1224:	ece8f8e3          	bgeu	a7,a4,10f4 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1228:	02d00793          	li	a5,45
    122c:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1230:	45b5                	li	a1,13
    1232:	bf69                	j	11cc <printint.constprop.0+0x126>
    1234:	45a9                	li	a1,10
    if (sign)
    1236:	f8055be3          	bgez	a0,11cc <printint.constprop.0+0x126>
        buf[i--] = '-';
    123a:	02d00793          	li	a5,45
    123e:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1242:	45a5                	li	a1,9
    1244:	b761                	j	11cc <printint.constprop.0+0x126>
    1246:	45b5                	li	a1,13
    if (sign)
    1248:	f80552e3          	bgez	a0,11cc <printint.constprop.0+0x126>
        buf[i--] = '-';
    124c:	02d00793          	li	a5,45
    1250:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1254:	45b1                	li	a1,12
    1256:	bf9d                	j	11cc <printint.constprop.0+0x126>
    1258:	45b1                	li	a1,12
    if (sign)
    125a:	f60559e3          	bgez	a0,11cc <printint.constprop.0+0x126>
        buf[i--] = '-';
    125e:	02d00793          	li	a5,45
    1262:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    1266:	45ad                	li	a1,11
    1268:	b795                	j	11cc <printint.constprop.0+0x126>
    126a:	45ad                	li	a1,11
    if (sign)
    126c:	f60550e3          	bgez	a0,11cc <printint.constprop.0+0x126>
        buf[i--] = '-';
    1270:	02d00793          	li	a5,45
    1274:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    1278:	45a9                	li	a1,10
    127a:	bf89                	j	11cc <printint.constprop.0+0x126>
        buf[i--] = '-';
    127c:	02d00793          	li	a5,45
    1280:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1284:	45b9                	li	a1,14
    1286:	b799                	j	11cc <printint.constprop.0+0x126>
    1288:	45a5                	li	a1,9
    if (sign)
    128a:	f40551e3          	bgez	a0,11cc <printint.constprop.0+0x126>
        buf[i--] = '-';
    128e:	02d00793          	li	a5,45
    1292:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    1296:	45a1                	li	a1,8
    1298:	bf15                	j	11cc <printint.constprop.0+0x126>
    i = 15;
    129a:	45bd                	li	a1,15
    129c:	bf05                	j	11cc <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    129e:	45a1                	li	a1,8
    if (sign)
    12a0:	f20556e3          	bgez	a0,11cc <printint.constprop.0+0x126>
        buf[i--] = '-';
    12a4:	02d00793          	li	a5,45
    12a8:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12ac:	459d                	li	a1,7
    12ae:	bf39                	j	11cc <printint.constprop.0+0x126>
    12b0:	459d                	li	a1,7
    if (sign)
    12b2:	f0055de3          	bgez	a0,11cc <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b6:	02d00793          	li	a5,45
    12ba:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12be:	4599                	li	a1,6
    12c0:	b731                	j	11cc <printint.constprop.0+0x126>

00000000000012c2 <getchar>:
{
    12c2:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12c4:	00f10593          	addi	a1,sp,15
    12c8:	4605                	li	a2,1
    12ca:	4501                	li	a0,0
{
    12cc:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12ce:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12d2:	191000ef          	jal	1c62 <read>
}
    12d6:	60e2                	ld	ra,24(sp)
    12d8:	00f14503          	lbu	a0,15(sp)
    12dc:	6105                	addi	sp,sp,32
    12de:	8082                	ret

00000000000012e0 <putchar>:
{
    12e0:	1101                	addi	sp,sp,-32
    12e2:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    12e4:	00f10593          	addi	a1,sp,15
    12e8:	4605                	li	a2,1
    12ea:	4505                	li	a0,1
{
    12ec:	ec06                	sd	ra,24(sp)
    char byte = c;
    12ee:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12f2:	17b000ef          	jal	1c6c <write>
}
    12f6:	60e2                	ld	ra,24(sp)
    12f8:	2501                	sext.w	a0,a0
    12fa:	6105                	addi	sp,sp,32
    12fc:	8082                	ret

00000000000012fe <puts>:
{
    12fe:	1141                	addi	sp,sp,-16
    1300:	e406                	sd	ra,8(sp)
    1302:	e022                	sd	s0,0(sp)
    1304:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1306:	582000ef          	jal	1888 <strlen>
    130a:	862a                	mv	a2,a0
    130c:	85a2                	mv	a1,s0
    130e:	4505                	li	a0,1
    1310:	15d000ef          	jal	1c6c <write>
}
    1314:	60a2                	ld	ra,8(sp)
    1316:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1318:	957d                	srai	a0,a0,0x3f
    return r;
    131a:	2501                	sext.w	a0,a0
}
    131c:	0141                	addi	sp,sp,16
    131e:	8082                	ret

0000000000001320 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1320:	7131                	addi	sp,sp,-192
    1322:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1324:	013c                	addi	a5,sp,136
{
    1326:	f0ca                	sd	s2,96(sp)
    1328:	ecce                	sd	s3,88(sp)
    132a:	e8d2                	sd	s4,80(sp)
    132c:	e4d6                	sd	s5,72(sp)
    132e:	e0da                	sd	s6,64(sp)
    1330:	fc5e                	sd	s7,56(sp)
    1332:	fc86                	sd	ra,120(sp)
    1334:	f8a2                	sd	s0,112(sp)
    1336:	f4a6                	sd	s1,104(sp)
    1338:	e52e                	sd	a1,136(sp)
    133a:	e932                	sd	a2,144(sp)
    133c:	ed36                	sd	a3,152(sp)
    133e:	f13a                	sd	a4,160(sp)
    1340:	f942                	sd	a6,176(sp)
    1342:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1344:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1346:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    134a:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    134e:	00001b97          	auipc	s7,0x1
    1352:	bf2b8b93          	addi	s7,s7,-1038 # 1f40 <__clone+0x9c>
        switch (s[1])
    1356:	07800a93          	li	s5,120
    135a:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    135e:	00001997          	auipc	s3,0x1
    1362:	c1298993          	addi	s3,s3,-1006 # 1f70 <digits>
        if (!*s)
    1366:	00054783          	lbu	a5,0(a0)
    136a:	16078c63          	beqz	a5,14e2 <printf+0x1c2>
    136e:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1370:	19278463          	beq	a5,s2,14f8 <printf+0x1d8>
    1374:	00164783          	lbu	a5,1(a2)
    1378:	0605                	addi	a2,a2,1
    137a:	fbfd                	bnez	a5,1370 <printf+0x50>
    137c:	84b2                	mv	s1,a2
        l = z - a;
    137e:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1382:	85aa                	mv	a1,a0
    1384:	8622                	mv	a2,s0
    1386:	4505                	li	a0,1
    1388:	0e5000ef          	jal	1c6c <write>
        if (l)
    138c:	18041f63          	bnez	s0,152a <printf+0x20a>
        if (s[1] == 0)
    1390:	0014c783          	lbu	a5,1(s1)
    1394:	14078763          	beqz	a5,14e2 <printf+0x1c2>
        switch (s[1])
    1398:	1d478163          	beq	a5,s4,155a <printf+0x23a>
    139c:	18fa6963          	bltu	s4,a5,152e <printf+0x20e>
    13a0:	1b678363          	beq	a5,s6,1546 <printf+0x226>
    13a4:	07000713          	li	a4,112
    13a8:	1ce79c63          	bne	a5,a4,1580 <printf+0x260>
            printptr(va_arg(ap, uint64));
    13ac:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13ae:	03000793          	li	a5,48
    13b2:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13b6:	631c                	ld	a5,0(a4)
    13b8:	0721                	addi	a4,a4,8
    13ba:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13bc:	00479f93          	slli	t6,a5,0x4
    13c0:	00879f13          	slli	t5,a5,0x8
    13c4:	00c79e93          	slli	t4,a5,0xc
    13c8:	01079e13          	slli	t3,a5,0x10
    13cc:	01479313          	slli	t1,a5,0x14
    13d0:	01879893          	slli	a7,a5,0x18
    13d4:	01c79713          	slli	a4,a5,0x1c
    13d8:	02479813          	slli	a6,a5,0x24
    13dc:	02879513          	slli	a0,a5,0x28
    13e0:	02c79593          	slli	a1,a5,0x2c
    13e4:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13e8:	03c7d293          	srli	t0,a5,0x3c
    13ec:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13f0:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13f4:	03cfdf93          	srli	t6,t6,0x3c
    13f8:	03cf5f13          	srli	t5,t5,0x3c
    13fc:	03cede93          	srli	t4,t4,0x3c
    1400:	03ce5e13          	srli	t3,t3,0x3c
    1404:	03c35313          	srli	t1,t1,0x3c
    1408:	03c8d893          	srli	a7,a7,0x3c
    140c:	9371                	srli	a4,a4,0x3c
    140e:	03c85813          	srli	a6,a6,0x3c
    1412:	9171                	srli	a0,a0,0x3c
    1414:	91f1                	srli	a1,a1,0x3c
    1416:	9271                	srli	a2,a2,0x3c
    1418:	974e                	add	a4,a4,s3
    141a:	92f1                	srli	a3,a3,0x3c
    141c:	92ce                	add	t0,t0,s3
    141e:	9fce                	add	t6,t6,s3
    1420:	9f4e                	add	t5,t5,s3
    1422:	9ece                	add	t4,t4,s3
    1424:	9e4e                	add	t3,t3,s3
    1426:	934e                	add	t1,t1,s3
    1428:	98ce                	add	a7,a7,s3
    142a:	93ce                	add	t2,t2,s3
    142c:	984e                	add	a6,a6,s3
    142e:	954e                	add	a0,a0,s3
    1430:	95ce                	add	a1,a1,s3
    1432:	964e                	add	a2,a2,s3
    1434:	0002c283          	lbu	t0,0(t0)
    1438:	000fcf83          	lbu	t6,0(t6)
    143c:	000f4f03          	lbu	t5,0(t5)
    1440:	000ece83          	lbu	t4,0(t4)
    1444:	000e4e03          	lbu	t3,0(t3)
    1448:	00034303          	lbu	t1,0(t1)
    144c:	0008c883          	lbu	a7,0(a7)
    1450:	00074403          	lbu	s0,0(a4)
    1454:	0003c383          	lbu	t2,0(t2)
    1458:	00084803          	lbu	a6,0(a6)
    145c:	00054503          	lbu	a0,0(a0)
    1460:	0005c583          	lbu	a1,0(a1)
    1464:	00064603          	lbu	a2,0(a2)
    1468:	00d98733          	add	a4,s3,a3
    146c:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1470:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1474:	9371                	srli	a4,a4,0x3c
    1476:	8bbd                	andi	a5,a5,15
    1478:	00510523          	sb	t0,10(sp)
    147c:	01f105a3          	sb	t6,11(sp)
    1480:	01e10623          	sb	t5,12(sp)
    1484:	01d106a3          	sb	t4,13(sp)
    1488:	01c10723          	sb	t3,14(sp)
    148c:	006107a3          	sb	t1,15(sp)
    1490:	01110823          	sb	a7,16(sp)
    1494:	00710923          	sb	t2,18(sp)
    1498:	010109a3          	sb	a6,19(sp)
    149c:	00a10a23          	sb	a0,20(sp)
    14a0:	00b10aa3          	sb	a1,21(sp)
    14a4:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14a8:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ac:	008108a3          	sb	s0,17(sp)
    14b0:	974e                	add	a4,a4,s3
    14b2:	97ce                	add	a5,a5,s3
    14b4:	00d10ba3          	sb	a3,23(sp)
    14b8:	00074703          	lbu	a4,0(a4)
    14bc:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14c0:	4649                	li	a2,18
    14c2:	002c                	addi	a1,sp,8
    14c4:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14c6:	00e10c23          	sb	a4,24(sp)
    14ca:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14ce:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14d2:	79a000ef          	jal	1c6c <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14d6:	00248513          	addi	a0,s1,2
        if (!*s)
    14da:	00054783          	lbu	a5,0(a0)
    14de:	e80798e3          	bnez	a5,136e <printf+0x4e>
    }
    va_end(ap);
}
    14e2:	70e6                	ld	ra,120(sp)
    14e4:	7446                	ld	s0,112(sp)
    14e6:	74a6                	ld	s1,104(sp)
    14e8:	7906                	ld	s2,96(sp)
    14ea:	69e6                	ld	s3,88(sp)
    14ec:	6a46                	ld	s4,80(sp)
    14ee:	6aa6                	ld	s5,72(sp)
    14f0:	6b06                	ld	s6,64(sp)
    14f2:	7be2                	ld	s7,56(sp)
    14f4:	6129                	addi	sp,sp,192
    14f6:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14f8:	00064783          	lbu	a5,0(a2)
    14fc:	84b2                	mv	s1,a2
    14fe:	01278963          	beq	a5,s2,1510 <printf+0x1f0>
    1502:	bdb5                	j	137e <printf+0x5e>
    1504:	0024c783          	lbu	a5,2(s1)
    1508:	0605                	addi	a2,a2,1
    150a:	0489                	addi	s1,s1,2
    150c:	e72799e3          	bne	a5,s2,137e <printf+0x5e>
    1510:	0014c783          	lbu	a5,1(s1)
    1514:	ff2788e3          	beq	a5,s2,1504 <printf+0x1e4>
        l = z - a;
    1518:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    151c:	85aa                	mv	a1,a0
    151e:	8622                	mv	a2,s0
    1520:	4505                	li	a0,1
    1522:	74a000ef          	jal	1c6c <write>
        if (l)
    1526:	e60405e3          	beqz	s0,1390 <printf+0x70>
    152a:	8526                	mv	a0,s1
    152c:	bd2d                	j	1366 <printf+0x46>
        switch (s[1])
    152e:	05579963          	bne	a5,s5,1580 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1532:	6782                	ld	a5,0(sp)
    1534:	45c1                	li	a1,16
    1536:	4388                	lw	a0,0(a5)
    1538:	07a1                	addi	a5,a5,8
    153a:	e03e                	sd	a5,0(sp)
    153c:	b6bff0ef          	jal	10a6 <printint.constprop.0>
        s += 2;
    1540:	00248513          	addi	a0,s1,2
    1544:	bf59                	j	14da <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1546:	6782                	ld	a5,0(sp)
    1548:	45a9                	li	a1,10
    154a:	4388                	lw	a0,0(a5)
    154c:	07a1                	addi	a5,a5,8
    154e:	e03e                	sd	a5,0(sp)
    1550:	b57ff0ef          	jal	10a6 <printint.constprop.0>
        s += 2;
    1554:	00248513          	addi	a0,s1,2
    1558:	b749                	j	14da <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    155a:	6782                	ld	a5,0(sp)
    155c:	6380                	ld	s0,0(a5)
    155e:	07a1                	addi	a5,a5,8
    1560:	e03e                	sd	a5,0(sp)
    1562:	c031                	beqz	s0,15a6 <printf+0x286>
            l = strnlen(a, 200);
    1564:	0c800593          	li	a1,200
    1568:	8522                	mv	a0,s0
    156a:	40a000ef          	jal	1974 <strnlen>
    write(f, s, l);
    156e:	0005061b          	sext.w	a2,a0
    1572:	85a2                	mv	a1,s0
    1574:	4505                	li	a0,1
    1576:	6f6000ef          	jal	1c6c <write>
        s += 2;
    157a:	00248513          	addi	a0,s1,2
    157e:	bfb1                	j	14da <printf+0x1ba>
    return write(stdout, &byte, 1);
    1580:	4605                	li	a2,1
    1582:	002c                	addi	a1,sp,8
    1584:	4505                	li	a0,1
    char byte = c;
    1586:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    158a:	6e2000ef          	jal	1c6c <write>
    char byte = c;
    158e:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    1592:	4605                	li	a2,1
    1594:	002c                	addi	a1,sp,8
    1596:	4505                	li	a0,1
    char byte = c;
    1598:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    159c:	6d0000ef          	jal	1c6c <write>
        s += 2;
    15a0:	00248513          	addi	a0,s1,2
    15a4:	bf1d                	j	14da <printf+0x1ba>
                a = "(null)";
    15a6:	845e                	mv	s0,s7
    15a8:	bf75                	j	1564 <printf+0x244>

00000000000015aa <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15aa:	1141                	addi	sp,sp,-16
    15ac:	e406                	sd	ra,8(sp)
    puts(m);
    15ae:	d51ff0ef          	jal	12fe <puts>
    exit(-100);
}
    15b2:	60a2                	ld	ra,8(sp)
    exit(-100);
    15b4:	f9c00513          	li	a0,-100
}
    15b8:	0141                	addi	sp,sp,16
    exit(-100);
    15ba:	a709                	j	1cbc <exit>

00000000000015bc <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15bc:	02000793          	li	a5,32
    15c0:	00f50663          	beq	a0,a5,15cc <isspace+0x10>
    15c4:	355d                	addiw	a0,a0,-9
    15c6:	00553513          	sltiu	a0,a0,5
    15ca:	8082                	ret
    15cc:	4505                	li	a0,1
}
    15ce:	8082                	ret

00000000000015d0 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15d0:	fd05051b          	addiw	a0,a0,-48
}
    15d4:	00a53513          	sltiu	a0,a0,10
    15d8:	8082                	ret

00000000000015da <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15da:	02000613          	li	a2,32
    15de:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15e0:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15e4:	ff77069b          	addiw	a3,a4,-9
    15e8:	04c70d63          	beq	a4,a2,1642 <atoi+0x68>
    15ec:	0007079b          	sext.w	a5,a4
    15f0:	04d5f963          	bgeu	a1,a3,1642 <atoi+0x68>
        s++;
    switch (*s)
    15f4:	02b00693          	li	a3,43
    15f8:	04d70a63          	beq	a4,a3,164c <atoi+0x72>
    15fc:	02d00693          	li	a3,45
    1600:	06d70463          	beq	a4,a3,1668 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1604:	fd07859b          	addiw	a1,a5,-48
    1608:	4625                	li	a2,9
    160a:	873e                	mv	a4,a5
    160c:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    160e:	4e01                	li	t3,0
    while (isdigit(*s))
    1610:	04b66a63          	bltu	a2,a1,1664 <atoi+0x8a>
    int n = 0, neg = 0;
    1614:	4501                	li	a0,0
    while (isdigit(*s))
    1616:	4825                	li	a6,9
    1618:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    161c:	0025179b          	slliw	a5,a0,0x2
    1620:	9d3d                	addw	a0,a0,a5
    1622:	fd07031b          	addiw	t1,a4,-48
    1626:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    162a:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    162e:	0685                	addi	a3,a3,1
    1630:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1634:	0006071b          	sext.w	a4,a2
    1638:	feb870e3          	bgeu	a6,a1,1618 <atoi+0x3e>
    return neg ? n : -n;
    163c:	000e0563          	beqz	t3,1646 <atoi+0x6c>
}
    1640:	8082                	ret
        s++;
    1642:	0505                	addi	a0,a0,1
    1644:	bf71                	j	15e0 <atoi+0x6>
    return neg ? n : -n;
    1646:	4113053b          	subw	a0,t1,a7
    164a:	8082                	ret
    while (isdigit(*s))
    164c:	00154783          	lbu	a5,1(a0)
    1650:	4625                	li	a2,9
        s++;
    1652:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1656:	fd07859b          	addiw	a1,a5,-48
    165a:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    165e:	4e01                	li	t3,0
    while (isdigit(*s))
    1660:	fab67ae3          	bgeu	a2,a1,1614 <atoi+0x3a>
    1664:	4501                	li	a0,0
}
    1666:	8082                	ret
    while (isdigit(*s))
    1668:	00154783          	lbu	a5,1(a0)
    166c:	4625                	li	a2,9
        s++;
    166e:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1672:	fd07859b          	addiw	a1,a5,-48
    1676:	0007871b          	sext.w	a4,a5
    167a:	feb665e3          	bltu	a2,a1,1664 <atoi+0x8a>
        neg = 1;
    167e:	4e05                	li	t3,1
    1680:	bf51                	j	1614 <atoi+0x3a>

0000000000001682 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1682:	16060d63          	beqz	a2,17fc <memset+0x17a>
    1686:	40a007b3          	neg	a5,a0
    168a:	8b9d                	andi	a5,a5,7
    168c:	00778713          	addi	a4,a5,7
    1690:	482d                	li	a6,11
    1692:	0ff5f593          	zext.b	a1,a1
    1696:	fff60693          	addi	a3,a2,-1
    169a:	17076263          	bltu	a4,a6,17fe <memset+0x17c>
    169e:	16e6ea63          	bltu	a3,a4,1812 <memset+0x190>
    16a2:	16078563          	beqz	a5,180c <memset+0x18a>
    16a6:	00b50023          	sb	a1,0(a0)
    16aa:	4705                	li	a4,1
    16ac:	00150e93          	addi	t4,a0,1
    16b0:	14e78c63          	beq	a5,a4,1808 <memset+0x186>
    16b4:	00b500a3          	sb	a1,1(a0)
    16b8:	4709                	li	a4,2
    16ba:	00250e93          	addi	t4,a0,2
    16be:	14e78d63          	beq	a5,a4,1818 <memset+0x196>
    16c2:	00b50123          	sb	a1,2(a0)
    16c6:	470d                	li	a4,3
    16c8:	00350e93          	addi	t4,a0,3
    16cc:	12e78b63          	beq	a5,a4,1802 <memset+0x180>
    16d0:	00b501a3          	sb	a1,3(a0)
    16d4:	4711                	li	a4,4
    16d6:	00450e93          	addi	t4,a0,4
    16da:	14e78163          	beq	a5,a4,181c <memset+0x19a>
    16de:	00b50223          	sb	a1,4(a0)
    16e2:	4715                	li	a4,5
    16e4:	00550e93          	addi	t4,a0,5
    16e8:	12e78c63          	beq	a5,a4,1820 <memset+0x19e>
    16ec:	00b502a3          	sb	a1,5(a0)
    16f0:	471d                	li	a4,7
    16f2:	00650e93          	addi	t4,a0,6
    16f6:	12e79763          	bne	a5,a4,1824 <memset+0x1a2>
    16fa:	00750e93          	addi	t4,a0,7
    16fe:	00b50323          	sb	a1,6(a0)
    1702:	4f1d                	li	t5,7
    1704:	00859713          	slli	a4,a1,0x8
    1708:	8f4d                	or	a4,a4,a1
    170a:	01059e13          	slli	t3,a1,0x10
    170e:	01c76e33          	or	t3,a4,t3
    1712:	01859313          	slli	t1,a1,0x18
    1716:	006e6333          	or	t1,t3,t1
    171a:	02059893          	slli	a7,a1,0x20
    171e:	011368b3          	or	a7,t1,a7
    1722:	02859813          	slli	a6,a1,0x28
    1726:	40f60333          	sub	t1,a2,a5
    172a:	0108e833          	or	a6,a7,a6
    172e:	03059693          	slli	a3,a1,0x30
    1732:	00d866b3          	or	a3,a6,a3
    1736:	03859713          	slli	a4,a1,0x38
    173a:	97aa                	add	a5,a5,a0
    173c:	ff837813          	andi	a6,t1,-8
    1740:	8f55                	or	a4,a4,a3
    1742:	00f806b3          	add	a3,a6,a5
    1746:	e398                	sd	a4,0(a5)
    1748:	07a1                	addi	a5,a5,8
    174a:	fed79ee3          	bne	a5,a3,1746 <memset+0xc4>
    174e:	ff837693          	andi	a3,t1,-8
    1752:	00de87b3          	add	a5,t4,a3
    1756:	01e6873b          	addw	a4,a3,t5
    175a:	0ad30663          	beq	t1,a3,1806 <memset+0x184>
    175e:	00b78023          	sb	a1,0(a5)
    1762:	0017069b          	addiw	a3,a4,1
    1766:	08c6fb63          	bgeu	a3,a2,17fc <memset+0x17a>
    176a:	00b780a3          	sb	a1,1(a5)
    176e:	0027069b          	addiw	a3,a4,2
    1772:	08c6f563          	bgeu	a3,a2,17fc <memset+0x17a>
    1776:	00b78123          	sb	a1,2(a5)
    177a:	0037069b          	addiw	a3,a4,3
    177e:	06c6ff63          	bgeu	a3,a2,17fc <memset+0x17a>
    1782:	00b781a3          	sb	a1,3(a5)
    1786:	0047069b          	addiw	a3,a4,4
    178a:	06c6f963          	bgeu	a3,a2,17fc <memset+0x17a>
    178e:	00b78223          	sb	a1,4(a5)
    1792:	0057069b          	addiw	a3,a4,5
    1796:	06c6f363          	bgeu	a3,a2,17fc <memset+0x17a>
    179a:	00b782a3          	sb	a1,5(a5)
    179e:	0067069b          	addiw	a3,a4,6
    17a2:	04c6fd63          	bgeu	a3,a2,17fc <memset+0x17a>
    17a6:	00b78323          	sb	a1,6(a5)
    17aa:	0077069b          	addiw	a3,a4,7
    17ae:	04c6f763          	bgeu	a3,a2,17fc <memset+0x17a>
    17b2:	00b783a3          	sb	a1,7(a5)
    17b6:	0087069b          	addiw	a3,a4,8
    17ba:	04c6f163          	bgeu	a3,a2,17fc <memset+0x17a>
    17be:	00b78423          	sb	a1,8(a5)
    17c2:	0097069b          	addiw	a3,a4,9
    17c6:	02c6fb63          	bgeu	a3,a2,17fc <memset+0x17a>
    17ca:	00b784a3          	sb	a1,9(a5)
    17ce:	00a7069b          	addiw	a3,a4,10
    17d2:	02c6f563          	bgeu	a3,a2,17fc <memset+0x17a>
    17d6:	00b78523          	sb	a1,10(a5)
    17da:	00b7069b          	addiw	a3,a4,11
    17de:	00c6ff63          	bgeu	a3,a2,17fc <memset+0x17a>
    17e2:	00b785a3          	sb	a1,11(a5)
    17e6:	00c7069b          	addiw	a3,a4,12
    17ea:	00c6f963          	bgeu	a3,a2,17fc <memset+0x17a>
    17ee:	00b78623          	sb	a1,12(a5)
    17f2:	2735                	addiw	a4,a4,13
    17f4:	00c77463          	bgeu	a4,a2,17fc <memset+0x17a>
    17f8:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    17fc:	8082                	ret
    17fe:	472d                	li	a4,11
    1800:	bd79                	j	169e <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1802:	4f0d                	li	t5,3
    1804:	b701                	j	1704 <memset+0x82>
    1806:	8082                	ret
    1808:	4f05                	li	t5,1
    180a:	bded                	j	1704 <memset+0x82>
    180c:	8eaa                	mv	t4,a0
    180e:	4f01                	li	t5,0
    1810:	bdd5                	j	1704 <memset+0x82>
    1812:	87aa                	mv	a5,a0
    1814:	4701                	li	a4,0
    1816:	b7a1                	j	175e <memset+0xdc>
    1818:	4f09                	li	t5,2
    181a:	b5ed                	j	1704 <memset+0x82>
    181c:	4f11                	li	t5,4
    181e:	b5dd                	j	1704 <memset+0x82>
    1820:	4f15                	li	t5,5
    1822:	b5cd                	j	1704 <memset+0x82>
    1824:	4f19                	li	t5,6
    1826:	bdf9                	j	1704 <memset+0x82>

0000000000001828 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1828:	00054783          	lbu	a5,0(a0)
    182c:	0005c703          	lbu	a4,0(a1)
    1830:	00e79863          	bne	a5,a4,1840 <strcmp+0x18>
    1834:	0505                	addi	a0,a0,1
    1836:	0585                	addi	a1,a1,1
    1838:	fbe5                	bnez	a5,1828 <strcmp>
    183a:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    183c:	9d19                	subw	a0,a0,a4
    183e:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1840:	0007851b          	sext.w	a0,a5
    1844:	bfe5                	j	183c <strcmp+0x14>

0000000000001846 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1846:	ce05                	beqz	a2,187e <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1848:	00054703          	lbu	a4,0(a0)
    184c:	0005c783          	lbu	a5,0(a1)
    1850:	cb0d                	beqz	a4,1882 <strncmp+0x3c>
    if (!n--)
    1852:	167d                	addi	a2,a2,-1
    1854:	00c506b3          	add	a3,a0,a2
    1858:	a819                	j	186e <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    185a:	00a68e63          	beq	a3,a0,1876 <strncmp+0x30>
    185e:	0505                	addi	a0,a0,1
    1860:	00e79b63          	bne	a5,a4,1876 <strncmp+0x30>
    1864:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    1868:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    186c:	cb19                	beqz	a4,1882 <strncmp+0x3c>
    186e:	0005c783          	lbu	a5,0(a1)
    1872:	0585                	addi	a1,a1,1
    1874:	f3fd                	bnez	a5,185a <strncmp+0x14>
    return *l - *r;
    1876:	0007051b          	sext.w	a0,a4
    187a:	9d1d                	subw	a0,a0,a5
    187c:	8082                	ret
        return 0;
    187e:	4501                	li	a0,0
}
    1880:	8082                	ret
    1882:	4501                	li	a0,0
    return *l - *r;
    1884:	9d1d                	subw	a0,a0,a5
    1886:	8082                	ret

0000000000001888 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    1888:	00757793          	andi	a5,a0,7
    188c:	cf89                	beqz	a5,18a6 <strlen+0x1e>
    188e:	87aa                	mv	a5,a0
    1890:	a029                	j	189a <strlen+0x12>
    1892:	0785                	addi	a5,a5,1
    1894:	0077f713          	andi	a4,a5,7
    1898:	cb01                	beqz	a4,18a8 <strlen+0x20>
        if (!*s)
    189a:	0007c703          	lbu	a4,0(a5)
    189e:	fb75                	bnez	a4,1892 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18a0:	40a78533          	sub	a0,a5,a0
}
    18a4:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18a6:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18a8:	6394                	ld	a3,0(a5)
    18aa:	00000597          	auipc	a1,0x0
    18ae:	69e5b583          	ld	a1,1694(a1) # 1f48 <__clone+0xa4>
    18b2:	00000617          	auipc	a2,0x0
    18b6:	69e63603          	ld	a2,1694(a2) # 1f50 <__clone+0xac>
    18ba:	a019                	j	18c0 <strlen+0x38>
    18bc:	6794                	ld	a3,8(a5)
    18be:	07a1                	addi	a5,a5,8
    18c0:	00b68733          	add	a4,a3,a1
    18c4:	fff6c693          	not	a3,a3
    18c8:	8f75                	and	a4,a4,a3
    18ca:	8f71                	and	a4,a4,a2
    18cc:	db65                	beqz	a4,18bc <strlen+0x34>
    for (; *s; s++)
    18ce:	0007c703          	lbu	a4,0(a5)
    18d2:	d779                	beqz	a4,18a0 <strlen+0x18>
    18d4:	0017c703          	lbu	a4,1(a5)
    18d8:	0785                	addi	a5,a5,1
    18da:	d379                	beqz	a4,18a0 <strlen+0x18>
    18dc:	0017c703          	lbu	a4,1(a5)
    18e0:	0785                	addi	a5,a5,1
    18e2:	fb6d                	bnez	a4,18d4 <strlen+0x4c>
    18e4:	bf75                	j	18a0 <strlen+0x18>

00000000000018e6 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18e6:	00757713          	andi	a4,a0,7
{
    18ea:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18ec:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18f0:	cb19                	beqz	a4,1906 <memchr+0x20>
    18f2:	ce25                	beqz	a2,196a <memchr+0x84>
    18f4:	0007c703          	lbu	a4,0(a5)
    18f8:	04b70e63          	beq	a4,a1,1954 <memchr+0x6e>
    18fc:	0785                	addi	a5,a5,1
    18fe:	0077f713          	andi	a4,a5,7
    1902:	167d                	addi	a2,a2,-1
    1904:	f77d                	bnez	a4,18f2 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1906:	4501                	li	a0,0
    if (n && *s != c)
    1908:	c235                	beqz	a2,196c <memchr+0x86>
    190a:	0007c703          	lbu	a4,0(a5)
    190e:	04b70363          	beq	a4,a1,1954 <memchr+0x6e>
        size_t k = ONES * c;
    1912:	00000517          	auipc	a0,0x0
    1916:	64653503          	ld	a0,1606(a0) # 1f58 <__clone+0xb4>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    191a:	471d                	li	a4,7
        size_t k = ONES * c;
    191c:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1920:	02c77a63          	bgeu	a4,a2,1954 <memchr+0x6e>
    1924:	00000897          	auipc	a7,0x0
    1928:	6248b883          	ld	a7,1572(a7) # 1f48 <__clone+0xa4>
    192c:	00000817          	auipc	a6,0x0
    1930:	62483803          	ld	a6,1572(a6) # 1f50 <__clone+0xac>
    1934:	431d                	li	t1,7
    1936:	a029                	j	1940 <memchr+0x5a>
    1938:	1661                	addi	a2,a2,-8
    193a:	07a1                	addi	a5,a5,8
    193c:	02c37963          	bgeu	t1,a2,196e <memchr+0x88>
    1940:	6398                	ld	a4,0(a5)
    1942:	8f29                	xor	a4,a4,a0
    1944:	011706b3          	add	a3,a4,a7
    1948:	fff74713          	not	a4,a4
    194c:	8f75                	and	a4,a4,a3
    194e:	01077733          	and	a4,a4,a6
    1952:	d37d                	beqz	a4,1938 <memchr+0x52>
    1954:	853e                	mv	a0,a5
    1956:	97b2                	add	a5,a5,a2
    1958:	a021                	j	1960 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    195a:	0505                	addi	a0,a0,1
    195c:	00f50763          	beq	a0,a5,196a <memchr+0x84>
    1960:	00054703          	lbu	a4,0(a0)
    1964:	feb71be3          	bne	a4,a1,195a <memchr+0x74>
    1968:	8082                	ret
    return n ? (void *)s : 0;
    196a:	4501                	li	a0,0
}
    196c:	8082                	ret
    return n ? (void *)s : 0;
    196e:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1970:	f275                	bnez	a2,1954 <memchr+0x6e>
}
    1972:	8082                	ret

0000000000001974 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1974:	1101                	addi	sp,sp,-32
    1976:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1978:	862e                	mv	a2,a1
{
    197a:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    197c:	4581                	li	a1,0
{
    197e:	e426                	sd	s1,8(sp)
    1980:	ec06                	sd	ra,24(sp)
    1982:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1984:	f63ff0ef          	jal	18e6 <memchr>
    return p ? p - s : n;
    1988:	c519                	beqz	a0,1996 <strnlen+0x22>
}
    198a:	60e2                	ld	ra,24(sp)
    198c:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    198e:	8d05                	sub	a0,a0,s1
}
    1990:	64a2                	ld	s1,8(sp)
    1992:	6105                	addi	sp,sp,32
    1994:	8082                	ret
    1996:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1998:	8522                	mv	a0,s0
}
    199a:	6442                	ld	s0,16(sp)
    199c:	64a2                	ld	s1,8(sp)
    199e:	6105                	addi	sp,sp,32
    19a0:	8082                	ret

00000000000019a2 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19a2:	00b547b3          	xor	a5,a0,a1
    19a6:	8b9d                	andi	a5,a5,7
    19a8:	eb95                	bnez	a5,19dc <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19aa:	0075f793          	andi	a5,a1,7
    19ae:	e7b1                	bnez	a5,19fa <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19b0:	6198                	ld	a4,0(a1)
    19b2:	00000617          	auipc	a2,0x0
    19b6:	59663603          	ld	a2,1430(a2) # 1f48 <__clone+0xa4>
    19ba:	00000817          	auipc	a6,0x0
    19be:	59683803          	ld	a6,1430(a6) # 1f50 <__clone+0xac>
    19c2:	a029                	j	19cc <strcpy+0x2a>
    19c4:	e118                	sd	a4,0(a0)
    19c6:	6598                	ld	a4,8(a1)
    19c8:	05a1                	addi	a1,a1,8
    19ca:	0521                	addi	a0,a0,8
    19cc:	00c707b3          	add	a5,a4,a2
    19d0:	fff74693          	not	a3,a4
    19d4:	8ff5                	and	a5,a5,a3
    19d6:	0107f7b3          	and	a5,a5,a6
    19da:	d7ed                	beqz	a5,19c4 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19dc:	0005c783          	lbu	a5,0(a1)
    19e0:	00f50023          	sb	a5,0(a0)
    19e4:	c785                	beqz	a5,1a0c <strcpy+0x6a>
    19e6:	0015c783          	lbu	a5,1(a1)
    19ea:	0505                	addi	a0,a0,1
    19ec:	0585                	addi	a1,a1,1
    19ee:	00f50023          	sb	a5,0(a0)
    19f2:	fbf5                	bnez	a5,19e6 <strcpy+0x44>
        ;
    return d;
}
    19f4:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    19f6:	0505                	addi	a0,a0,1
    19f8:	df45                	beqz	a4,19b0 <strcpy+0xe>
            if (!(*d = *s))
    19fa:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    19fe:	0585                	addi	a1,a1,1
    1a00:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a04:	00f50023          	sb	a5,0(a0)
    1a08:	f7fd                	bnez	a5,19f6 <strcpy+0x54>
}
    1a0a:	8082                	ret
    1a0c:	8082                	ret

0000000000001a0e <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a0e:	00b547b3          	xor	a5,a0,a1
    1a12:	8b9d                	andi	a5,a5,7
    1a14:	1a079863          	bnez	a5,1bc4 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a18:	0075f793          	andi	a5,a1,7
    1a1c:	16078463          	beqz	a5,1b84 <strncpy+0x176>
    1a20:	ea01                	bnez	a2,1a30 <strncpy+0x22>
    1a22:	a421                	j	1c2a <strncpy+0x21c>
    1a24:	167d                	addi	a2,a2,-1
    1a26:	0505                	addi	a0,a0,1
    1a28:	14070e63          	beqz	a4,1b84 <strncpy+0x176>
    1a2c:	1a060863          	beqz	a2,1bdc <strncpy+0x1ce>
    1a30:	0005c783          	lbu	a5,0(a1)
    1a34:	0585                	addi	a1,a1,1
    1a36:	0075f713          	andi	a4,a1,7
    1a3a:	00f50023          	sb	a5,0(a0)
    1a3e:	f3fd                	bnez	a5,1a24 <strncpy+0x16>
    1a40:	4805                	li	a6,1
    1a42:	1a061863          	bnez	a2,1bf2 <strncpy+0x1e4>
    1a46:	40a007b3          	neg	a5,a0
    1a4a:	8b9d                	andi	a5,a5,7
    1a4c:	4681                	li	a3,0
    1a4e:	18061a63          	bnez	a2,1be2 <strncpy+0x1d4>
    1a52:	00778713          	addi	a4,a5,7
    1a56:	45ad                	li	a1,11
    1a58:	18b76363          	bltu	a4,a1,1bde <strncpy+0x1d0>
    1a5c:	1ae6eb63          	bltu	a3,a4,1c12 <strncpy+0x204>
    1a60:	1a078363          	beqz	a5,1c06 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a64:	00050023          	sb	zero,0(a0)
    1a68:	4685                	li	a3,1
    1a6a:	00150713          	addi	a4,a0,1
    1a6e:	18d78f63          	beq	a5,a3,1c0c <strncpy+0x1fe>
    1a72:	000500a3          	sb	zero,1(a0)
    1a76:	4689                	li	a3,2
    1a78:	00250713          	addi	a4,a0,2
    1a7c:	18d78e63          	beq	a5,a3,1c18 <strncpy+0x20a>
    1a80:	00050123          	sb	zero,2(a0)
    1a84:	468d                	li	a3,3
    1a86:	00350713          	addi	a4,a0,3
    1a8a:	16d78c63          	beq	a5,a3,1c02 <strncpy+0x1f4>
    1a8e:	000501a3          	sb	zero,3(a0)
    1a92:	4691                	li	a3,4
    1a94:	00450713          	addi	a4,a0,4
    1a98:	18d78263          	beq	a5,a3,1c1c <strncpy+0x20e>
    1a9c:	00050223          	sb	zero,4(a0)
    1aa0:	4695                	li	a3,5
    1aa2:	00550713          	addi	a4,a0,5
    1aa6:	16d78d63          	beq	a5,a3,1c20 <strncpy+0x212>
    1aaa:	000502a3          	sb	zero,5(a0)
    1aae:	469d                	li	a3,7
    1ab0:	00650713          	addi	a4,a0,6
    1ab4:	16d79863          	bne	a5,a3,1c24 <strncpy+0x216>
    1ab8:	00750713          	addi	a4,a0,7
    1abc:	00050323          	sb	zero,6(a0)
    1ac0:	40f80833          	sub	a6,a6,a5
    1ac4:	ff887593          	andi	a1,a6,-8
    1ac8:	97aa                	add	a5,a5,a0
    1aca:	95be                	add	a1,a1,a5
    1acc:	0007b023          	sd	zero,0(a5)
    1ad0:	07a1                	addi	a5,a5,8
    1ad2:	feb79de3          	bne	a5,a1,1acc <strncpy+0xbe>
    1ad6:	ff887593          	andi	a1,a6,-8
    1ada:	9ead                	addw	a3,a3,a1
    1adc:	00b707b3          	add	a5,a4,a1
    1ae0:	12b80863          	beq	a6,a1,1c10 <strncpy+0x202>
    1ae4:	00078023          	sb	zero,0(a5)
    1ae8:	0016871b          	addiw	a4,a3,1
    1aec:	0ec77863          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1af0:	000780a3          	sb	zero,1(a5)
    1af4:	0026871b          	addiw	a4,a3,2
    1af8:	0ec77263          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1afc:	00078123          	sb	zero,2(a5)
    1b00:	0036871b          	addiw	a4,a3,3
    1b04:	0cc77c63          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1b08:	000781a3          	sb	zero,3(a5)
    1b0c:	0046871b          	addiw	a4,a3,4
    1b10:	0cc77663          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1b14:	00078223          	sb	zero,4(a5)
    1b18:	0056871b          	addiw	a4,a3,5
    1b1c:	0cc77063          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1b20:	000782a3          	sb	zero,5(a5)
    1b24:	0066871b          	addiw	a4,a3,6
    1b28:	0ac77a63          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1b2c:	00078323          	sb	zero,6(a5)
    1b30:	0076871b          	addiw	a4,a3,7
    1b34:	0ac77463          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1b38:	000783a3          	sb	zero,7(a5)
    1b3c:	0086871b          	addiw	a4,a3,8
    1b40:	08c77e63          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1b44:	00078423          	sb	zero,8(a5)
    1b48:	0096871b          	addiw	a4,a3,9
    1b4c:	08c77863          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1b50:	000784a3          	sb	zero,9(a5)
    1b54:	00a6871b          	addiw	a4,a3,10
    1b58:	08c77263          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1b5c:	00078523          	sb	zero,10(a5)
    1b60:	00b6871b          	addiw	a4,a3,11
    1b64:	06c77c63          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1b68:	000785a3          	sb	zero,11(a5)
    1b6c:	00c6871b          	addiw	a4,a3,12
    1b70:	06c77663          	bgeu	a4,a2,1bdc <strncpy+0x1ce>
    1b74:	00078623          	sb	zero,12(a5)
    1b78:	26b5                	addiw	a3,a3,13
    1b7a:	06c6f163          	bgeu	a3,a2,1bdc <strncpy+0x1ce>
    1b7e:	000786a3          	sb	zero,13(a5)
    1b82:	8082                	ret
            ;
        if (!n || !*s)
    1b84:	c645                	beqz	a2,1c2c <strncpy+0x21e>
    1b86:	0005c783          	lbu	a5,0(a1)
    1b8a:	ea078be3          	beqz	a5,1a40 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b8e:	479d                	li	a5,7
    1b90:	02c7ff63          	bgeu	a5,a2,1bce <strncpy+0x1c0>
    1b94:	00000897          	auipc	a7,0x0
    1b98:	3b48b883          	ld	a7,948(a7) # 1f48 <__clone+0xa4>
    1b9c:	00000817          	auipc	a6,0x0
    1ba0:	3b483803          	ld	a6,948(a6) # 1f50 <__clone+0xac>
    1ba4:	431d                	li	t1,7
    1ba6:	6198                	ld	a4,0(a1)
    1ba8:	011707b3          	add	a5,a4,a7
    1bac:	fff74693          	not	a3,a4
    1bb0:	8ff5                	and	a5,a5,a3
    1bb2:	0107f7b3          	and	a5,a5,a6
    1bb6:	ef81                	bnez	a5,1bce <strncpy+0x1c0>
            *wd = *ws;
    1bb8:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bba:	1661                	addi	a2,a2,-8
    1bbc:	05a1                	addi	a1,a1,8
    1bbe:	0521                	addi	a0,a0,8
    1bc0:	fec363e3          	bltu	t1,a2,1ba6 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bc4:	e609                	bnez	a2,1bce <strncpy+0x1c0>
    1bc6:	a08d                	j	1c28 <strncpy+0x21a>
    1bc8:	167d                	addi	a2,a2,-1
    1bca:	0505                	addi	a0,a0,1
    1bcc:	ca01                	beqz	a2,1bdc <strncpy+0x1ce>
    1bce:	0005c783          	lbu	a5,0(a1)
    1bd2:	0585                	addi	a1,a1,1
    1bd4:	00f50023          	sb	a5,0(a0)
    1bd8:	fbe5                	bnez	a5,1bc8 <strncpy+0x1ba>
        ;
tail:
    1bda:	b59d                	j	1a40 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bdc:	8082                	ret
    1bde:	472d                	li	a4,11
    1be0:	bdb5                	j	1a5c <strncpy+0x4e>
    1be2:	00778713          	addi	a4,a5,7
    1be6:	45ad                	li	a1,11
    1be8:	fff60693          	addi	a3,a2,-1
    1bec:	e6b778e3          	bgeu	a4,a1,1a5c <strncpy+0x4e>
    1bf0:	b7fd                	j	1bde <strncpy+0x1d0>
    1bf2:	40a007b3          	neg	a5,a0
    1bf6:	8832                	mv	a6,a2
    1bf8:	8b9d                	andi	a5,a5,7
    1bfa:	4681                	li	a3,0
    1bfc:	e4060be3          	beqz	a2,1a52 <strncpy+0x44>
    1c00:	b7cd                	j	1be2 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c02:	468d                	li	a3,3
    1c04:	bd75                	j	1ac0 <strncpy+0xb2>
    1c06:	872a                	mv	a4,a0
    1c08:	4681                	li	a3,0
    1c0a:	bd5d                	j	1ac0 <strncpy+0xb2>
    1c0c:	4685                	li	a3,1
    1c0e:	bd4d                	j	1ac0 <strncpy+0xb2>
    1c10:	8082                	ret
    1c12:	87aa                	mv	a5,a0
    1c14:	4681                	li	a3,0
    1c16:	b5f9                	j	1ae4 <strncpy+0xd6>
    1c18:	4689                	li	a3,2
    1c1a:	b55d                	j	1ac0 <strncpy+0xb2>
    1c1c:	4691                	li	a3,4
    1c1e:	b54d                	j	1ac0 <strncpy+0xb2>
    1c20:	4695                	li	a3,5
    1c22:	bd79                	j	1ac0 <strncpy+0xb2>
    1c24:	4699                	li	a3,6
    1c26:	bd69                	j	1ac0 <strncpy+0xb2>
    1c28:	8082                	ret
    1c2a:	8082                	ret
    1c2c:	8082                	ret

0000000000001c2e <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c2e:	87aa                	mv	a5,a0
    1c30:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c32:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c36:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c3a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c3c:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c3e:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c42:	2501                	sext.w	a0,a0
    1c44:	8082                	ret

0000000000001c46 <openat>:
    register long a7 __asm__("a7") = n;
    1c46:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c4a:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c4e:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c52:	2501                	sext.w	a0,a0
    1c54:	8082                	ret

0000000000001c56 <close>:
    register long a7 __asm__("a7") = n;
    1c56:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c5a:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c5e:	2501                	sext.w	a0,a0
    1c60:	8082                	ret

0000000000001c62 <read>:
    register long a7 __asm__("a7") = n;
    1c62:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c66:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c6a:	8082                	ret

0000000000001c6c <write>:
    register long a7 __asm__("a7") = n;
    1c6c:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c70:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c74:	8082                	ret

0000000000001c76 <getpid>:
    register long a7 __asm__("a7") = n;
    1c76:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c7a:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c7e:	2501                	sext.w	a0,a0
    1c80:	8082                	ret

0000000000001c82 <getppid>:
    register long a7 __asm__("a7") = n;
    1c82:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c86:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c8a:	2501                	sext.w	a0,a0
    1c8c:	8082                	ret

0000000000001c8e <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c8e:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c92:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c96:	2501                	sext.w	a0,a0
    1c98:	8082                	ret

0000000000001c9a <fork>:
    register long a7 __asm__("a7") = n;
    1c9a:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1c9e:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1ca0:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ca2:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1ca6:	2501                	sext.w	a0,a0
    1ca8:	8082                	ret

0000000000001caa <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1caa:	85b2                	mv	a1,a2
    1cac:	863a                	mv	a2,a4
    if (stack)
    1cae:	c191                	beqz	a1,1cb2 <clone+0x8>
	stack += stack_size;
    1cb0:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cb2:	4781                	li	a5,0
    1cb4:	4701                	li	a4,0
    1cb6:	4681                	li	a3,0
    1cb8:	2601                	sext.w	a2,a2
    1cba:	a2ed                	j	1ea4 <__clone>

0000000000001cbc <exit>:
    register long a7 __asm__("a7") = n;
    1cbc:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cc0:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cc4:	8082                	ret

0000000000001cc6 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cc6:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cca:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ccc:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cd0:	2501                	sext.w	a0,a0
    1cd2:	8082                	ret

0000000000001cd4 <exec>:
    register long a7 __asm__("a7") = n;
    1cd4:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cd8:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cdc:	2501                	sext.w	a0,a0
    1cde:	8082                	ret

0000000000001ce0 <execve>:
    register long a7 __asm__("a7") = n;
    1ce0:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ce4:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1ce8:	2501                	sext.w	a0,a0
    1cea:	8082                	ret

0000000000001cec <times>:
    register long a7 __asm__("a7") = n;
    1cec:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1cf0:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1cf4:	2501                	sext.w	a0,a0
    1cf6:	8082                	ret

0000000000001cf8 <get_time>:

int64 get_time()
{
    1cf8:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1cfa:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1cfe:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d00:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d02:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d06:	2501                	sext.w	a0,a0
    1d08:	ed09                	bnez	a0,1d22 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d0a:	67a2                	ld	a5,8(sp)
    1d0c:	3e800713          	li	a4,1000
    1d10:	00015503          	lhu	a0,0(sp)
    1d14:	02e7d7b3          	divu	a5,a5,a4
    1d18:	02e50533          	mul	a0,a0,a4
    1d1c:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d1e:	0141                	addi	sp,sp,16
    1d20:	8082                	ret
        return -1;
    1d22:	557d                	li	a0,-1
    1d24:	bfed                	j	1d1e <get_time+0x26>

0000000000001d26 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d26:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d2a:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d2e:	2501                	sext.w	a0,a0
    1d30:	8082                	ret

0000000000001d32 <time>:
    register long a7 __asm__("a7") = n;
    1d32:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d36:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d3a:	2501                	sext.w	a0,a0
    1d3c:	8082                	ret

0000000000001d3e <sleep>:

int sleep(unsigned long long time)
{
    1d3e:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d40:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d42:	850a                	mv	a0,sp
    1d44:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d46:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d4a:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d4c:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d50:	e501                	bnez	a0,1d58 <sleep+0x1a>
    return 0;
    1d52:	4501                	li	a0,0
}
    1d54:	0141                	addi	sp,sp,16
    1d56:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d58:	4502                	lw	a0,0(sp)
}
    1d5a:	0141                	addi	sp,sp,16
    1d5c:	8082                	ret

0000000000001d5e <set_priority>:
    register long a7 __asm__("a7") = n;
    1d5e:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d62:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d66:	2501                	sext.w	a0,a0
    1d68:	8082                	ret

0000000000001d6a <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d6a:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d6e:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d72:	8082                	ret

0000000000001d74 <munmap>:
    register long a7 __asm__("a7") = n;
    1d74:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d78:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d7c:	2501                	sext.w	a0,a0
    1d7e:	8082                	ret

0000000000001d80 <wait>:

int wait(int *code)
{
    1d80:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d82:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d86:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d88:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d8a:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d8c:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1d90:	2501                	sext.w	a0,a0
    1d92:	8082                	ret

0000000000001d94 <spawn>:
    register long a7 __asm__("a7") = n;
    1d94:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1d98:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1d9c:	2501                	sext.w	a0,a0
    1d9e:	8082                	ret

0000000000001da0 <mailread>:
    register long a7 __asm__("a7") = n;
    1da0:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1da4:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1da8:	2501                	sext.w	a0,a0
    1daa:	8082                	ret

0000000000001dac <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dac:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1db0:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1db4:	2501                	sext.w	a0,a0
    1db6:	8082                	ret

0000000000001db8 <fstat>:
    register long a7 __asm__("a7") = n;
    1db8:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dbc:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dc0:	2501                	sext.w	a0,a0
    1dc2:	8082                	ret

0000000000001dc4 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dc4:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dc6:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dca:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dcc:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1dd0:	2501                	sext.w	a0,a0
    1dd2:	8082                	ret

0000000000001dd4 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1dd4:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1dd6:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1dda:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ddc:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1de0:	2501                	sext.w	a0,a0
    1de2:	8082                	ret

0000000000001de4 <link>:

int link(char *old_path, char *new_path)
{
    1de4:	87aa                	mv	a5,a0
    1de6:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1de8:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1dec:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1df0:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1df2:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1df6:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1df8:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1dfc:	2501                	sext.w	a0,a0
    1dfe:	8082                	ret

0000000000001e00 <unlink>:

int unlink(char *path)
{
    1e00:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e02:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e06:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e0a:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e0c:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e10:	2501                	sext.w	a0,a0
    1e12:	8082                	ret

0000000000001e14 <uname>:
    register long a7 __asm__("a7") = n;
    1e14:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e18:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e1c:	2501                	sext.w	a0,a0
    1e1e:	8082                	ret

0000000000001e20 <brk>:
    register long a7 __asm__("a7") = n;
    1e20:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e24:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e28:	2501                	sext.w	a0,a0
    1e2a:	8082                	ret

0000000000001e2c <getcwd>:
    register long a7 __asm__("a7") = n;
    1e2c:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e2e:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e32:	8082                	ret

0000000000001e34 <chdir>:
    register long a7 __asm__("a7") = n;
    1e34:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e38:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e3c:	2501                	sext.w	a0,a0
    1e3e:	8082                	ret

0000000000001e40 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e40:	862e                	mv	a2,a1
    1e42:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e44:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e46:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e4a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e4e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e50:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e52:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e56:	2501                	sext.w	a0,a0
    1e58:	8082                	ret

0000000000001e5a <getdents>:
    register long a7 __asm__("a7") = n;
    1e5a:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e5e:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e62:	2501                	sext.w	a0,a0
    1e64:	8082                	ret

0000000000001e66 <pipe>:
    register long a7 __asm__("a7") = n;
    1e66:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e6a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e6c:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e70:	2501                	sext.w	a0,a0
    1e72:	8082                	ret

0000000000001e74 <dup>:
    register long a7 __asm__("a7") = n;
    1e74:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e76:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e7a:	2501                	sext.w	a0,a0
    1e7c:	8082                	ret

0000000000001e7e <dup2>:
    register long a7 __asm__("a7") = n;
    1e7e:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e80:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e82:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e86:	2501                	sext.w	a0,a0
    1e88:	8082                	ret

0000000000001e8a <mount>:
    register long a7 __asm__("a7") = n;
    1e8a:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e8e:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1e92:	2501                	sext.w	a0,a0
    1e94:	8082                	ret

0000000000001e96 <umount>:
    register long a7 __asm__("a7") = n;
    1e96:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1e9a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e9c:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ea0:	2501                	sext.w	a0,a0
    1ea2:	8082                	ret

0000000000001ea4 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ea4:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ea6:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ea8:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1eaa:	8532                	mv	a0,a2
	mv a2, a4
    1eac:	863a                	mv	a2,a4
	mv a3, a5
    1eae:	86be                	mv	a3,a5
	mv a4, a6
    1eb0:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1eb2:	0dc00893          	li	a7,220
	ecall
    1eb6:	00000073          	ecall

	beqz a0, 1f
    1eba:	c111                	beqz	a0,1ebe <__clone+0x1a>
	# Parent
	ret
    1ebc:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ebe:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ec0:	6522                	ld	a0,8(sp)
	jalr a1
    1ec2:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ec4:	05d00893          	li	a7,93
	ecall
    1ec8:	00000073          	ecall
