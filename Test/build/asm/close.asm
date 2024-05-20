
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/close:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a865                	j	10ba <__start_main>

0000000000001004 <test_close>:
 * "  close success."
 * 测试失败则输出：
 * "  close error."
 */

void test_close(void) {
    1004:	1141                	addi	sp,sp,-16
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	efa50513          	addi	a0,a0,-262 # 1f00 <__clone+0x2e>
void test_close(void) {
    100e:	e406                	sd	ra,8(sp)
    1010:	e022                	sd	s0,0(sp)
    TEST_START(__func__);
    1012:	31a000ef          	jal	132c <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	f9a50513          	addi	a0,a0,-102 # 1fb0 <__func__.0>
    101e:	30e000ef          	jal	132c <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	ef650513          	addi	a0,a0,-266 # 1f18 <__clone+0x46>
    102a:	302000ef          	jal	132c <puts>
    int fd = open("test_close.txt", O_CREATE | O_RDWR);
    102e:	04200593          	li	a1,66
    1032:	00001517          	auipc	a0,0x1
    1036:	ef650513          	addi	a0,a0,-266 # 1f28 <__clone+0x56>
    103a:	423000ef          	jal	1c5c <open>
    103e:	842a                	mv	s0,a0
    //assert(fd > 0);
    const char *str = "  close error.\n";
    int str_len = strlen(str);
    1040:	00001517          	auipc	a0,0x1
    1044:	ef850513          	addi	a0,a0,-264 # 1f38 <__clone+0x66>
    1048:	06f000ef          	jal	18b6 <strlen>
    //assert(write(fd, str, str_len) == str_len);
    write(fd, str, str_len);
    104c:	0005061b          	sext.w	a2,a0
    1050:	00001597          	auipc	a1,0x1
    1054:	ee858593          	addi	a1,a1,-280 # 1f38 <__clone+0x66>
    1058:	8522                	mv	a0,s0
    105a:	441000ef          	jal	1c9a <write>
    int rt = close(fd);	
    105e:	8522                	mv	a0,s0
    1060:	425000ef          	jal	1c84 <close>
    assert(rt == 0);
    1064:	ed05                	bnez	a0,109c <test_close+0x98>
    printf("  close %d success.\n", fd);
    1066:	85a2                	mv	a1,s0
    1068:	00001517          	auipc	a0,0x1
    106c:	f0050513          	addi	a0,a0,-256 # 1f68 <__clone+0x96>
    1070:	2de000ef          	jal	134e <printf>
	
    TEST_END(__func__);
    1074:	00001517          	auipc	a0,0x1
    1078:	f0c50513          	addi	a0,a0,-244 # 1f80 <__clone+0xae>
    107c:	2b0000ef          	jal	132c <puts>
    1080:	00001517          	auipc	a0,0x1
    1084:	f3050513          	addi	a0,a0,-208 # 1fb0 <__func__.0>
    1088:	2a4000ef          	jal	132c <puts>
}
    108c:	6402                	ld	s0,0(sp)
    108e:	60a2                	ld	ra,8(sp)
    TEST_END(__func__);
    1090:	00001517          	auipc	a0,0x1
    1094:	e8850513          	addi	a0,a0,-376 # 1f18 <__clone+0x46>
}
    1098:	0141                	addi	sp,sp,16
    TEST_END(__func__);
    109a:	ac49                	j	132c <puts>
    assert(rt == 0);
    109c:	00001517          	auipc	a0,0x1
    10a0:	eac50513          	addi	a0,a0,-340 # 1f48 <__clone+0x76>
    10a4:	534000ef          	jal	15d8 <panic>
    10a8:	bf7d                	j	1066 <test_close+0x62>

00000000000010aa <main>:

int main(void) {
    10aa:	1141                	addi	sp,sp,-16
    10ac:	e406                	sd	ra,8(sp)
    test_close();
    10ae:	f57ff0ef          	jal	1004 <test_close>
    return 0;
}
    10b2:	60a2                	ld	ra,8(sp)
    10b4:	4501                	li	a0,0
    10b6:	0141                	addi	sp,sp,16
    10b8:	8082                	ret

00000000000010ba <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10ba:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10bc:	4108                	lw	a0,0(a0)
{
    10be:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10c0:	05a1                	addi	a1,a1,8
{
    10c2:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10c4:	fe7ff0ef          	jal	10aa <main>
    10c8:	423000ef          	jal	1cea <exit>
	return 0;
}
    10cc:	60a2                	ld	ra,8(sp)
    10ce:	4501                	li	a0,0
    10d0:	0141                	addi	sp,sp,16
    10d2:	8082                	ret

00000000000010d4 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10d4:	7179                	addi	sp,sp,-48
    10d6:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10d8:	12054b63          	bltz	a0,120e <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10dc:	02b577bb          	remuw	a5,a0,a1
    10e0:	00001617          	auipc	a2,0x1
    10e4:	ee060613          	addi	a2,a2,-288 # 1fc0 <digits>
    buf[16] = 0;
    10e8:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10ec:	0005871b          	sext.w	a4,a1
    10f0:	1782                	slli	a5,a5,0x20
    10f2:	9381                	srli	a5,a5,0x20
    10f4:	97b2                	add	a5,a5,a2
    10f6:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10fa:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10fe:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1102:	1cb56363          	bltu	a0,a1,12c8 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    1106:	45b9                	li	a1,14
    1108:	02e877bb          	remuw	a5,a6,a4
    110c:	1782                	slli	a5,a5,0x20
    110e:	9381                	srli	a5,a5,0x20
    1110:	97b2                	add	a5,a5,a2
    1112:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1116:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    111a:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    111e:	0ce86e63          	bltu	a6,a4,11fa <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1122:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1126:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    112a:	1582                	slli	a1,a1,0x20
    112c:	9181                	srli	a1,a1,0x20
    112e:	95b2                	add	a1,a1,a2
    1130:	0005c583          	lbu	a1,0(a1)
    1134:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    1138:	0007859b          	sext.w	a1,a5
    113c:	12e6ec63          	bltu	a3,a4,1274 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1140:	02e7f6bb          	remuw	a3,a5,a4
    1144:	1682                	slli	a3,a3,0x20
    1146:	9281                	srli	a3,a3,0x20
    1148:	96b2                	add	a3,a3,a2
    114a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    114e:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1152:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1156:	12e5e863          	bltu	a1,a4,1286 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    115a:	02e876bb          	remuw	a3,a6,a4
    115e:	1682                	slli	a3,a3,0x20
    1160:	9281                	srli	a3,a3,0x20
    1162:	96b2                	add	a3,a3,a2
    1164:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1168:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    116c:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1170:	12e86463          	bltu	a6,a4,1298 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1174:	02e5f6bb          	remuw	a3,a1,a4
    1178:	1682                	slli	a3,a3,0x20
    117a:	9281                	srli	a3,a3,0x20
    117c:	96b2                	add	a3,a3,a2
    117e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1182:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1186:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    118a:	0ce5ec63          	bltu	a1,a4,1262 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    118e:	02e876bb          	remuw	a3,a6,a4
    1192:	1682                	slli	a3,a3,0x20
    1194:	9281                	srli	a3,a3,0x20
    1196:	96b2                	add	a3,a3,a2
    1198:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    119c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11a0:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11a4:	10e86963          	bltu	a6,a4,12b6 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11a8:	02e5f6bb          	remuw	a3,a1,a4
    11ac:	1682                	slli	a3,a3,0x20
    11ae:	9281                	srli	a3,a3,0x20
    11b0:	96b2                	add	a3,a3,a2
    11b2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11b6:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11ba:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11be:	10e5e763          	bltu	a1,a4,12cc <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11c2:	02e876bb          	remuw	a3,a6,a4
    11c6:	1682                	slli	a3,a3,0x20
    11c8:	9281                	srli	a3,a3,0x20
    11ca:	96b2                	add	a3,a3,a2
    11cc:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11d0:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11d4:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11d8:	10e86363          	bltu	a6,a4,12de <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11dc:	1782                	slli	a5,a5,0x20
    11de:	9381                	srli	a5,a5,0x20
    11e0:	97b2                	add	a5,a5,a2
    11e2:	0007c783          	lbu	a5,0(a5)
    11e6:	4599                	li	a1,6
    11e8:	00f10723          	sb	a5,14(sp)

    if (sign)
    11ec:	00055763          	bgez	a0,11fa <printint.constprop.0+0x126>
        buf[i--] = '-';
    11f0:	02d00793          	li	a5,45
    11f4:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11f8:	4595                	li	a1,5
    write(f, s, l);
    11fa:	003c                	addi	a5,sp,8
    11fc:	4641                	li	a2,16
    11fe:	9e0d                	subw	a2,a2,a1
    1200:	4505                	li	a0,1
    1202:	95be                	add	a1,a1,a5
    1204:	297000ef          	jal	1c9a <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1208:	70a2                	ld	ra,40(sp)
    120a:	6145                	addi	sp,sp,48
    120c:	8082                	ret
        x = -xx;
    120e:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1212:	02b877bb          	remuw	a5,a6,a1
    1216:	00001617          	auipc	a2,0x1
    121a:	daa60613          	addi	a2,a2,-598 # 1fc0 <digits>
    buf[16] = 0;
    121e:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1222:	0005871b          	sext.w	a4,a1
    1226:	1782                	slli	a5,a5,0x20
    1228:	9381                	srli	a5,a5,0x20
    122a:	97b2                	add	a5,a5,a2
    122c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1230:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1234:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1238:	06b86963          	bltu	a6,a1,12aa <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    123c:	02e8f7bb          	remuw	a5,a7,a4
    1240:	1782                	slli	a5,a5,0x20
    1242:	9381                	srli	a5,a5,0x20
    1244:	97b2                	add	a5,a5,a2
    1246:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    124a:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    124e:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1252:	ece8f8e3          	bgeu	a7,a4,1122 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1256:	02d00793          	li	a5,45
    125a:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    125e:	45b5                	li	a1,13
    1260:	bf69                	j	11fa <printint.constprop.0+0x126>
    1262:	45a9                	li	a1,10
    if (sign)
    1264:	f8055be3          	bgez	a0,11fa <printint.constprop.0+0x126>
        buf[i--] = '-';
    1268:	02d00793          	li	a5,45
    126c:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1270:	45a5                	li	a1,9
    1272:	b761                	j	11fa <printint.constprop.0+0x126>
    1274:	45b5                	li	a1,13
    if (sign)
    1276:	f80552e3          	bgez	a0,11fa <printint.constprop.0+0x126>
        buf[i--] = '-';
    127a:	02d00793          	li	a5,45
    127e:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1282:	45b1                	li	a1,12
    1284:	bf9d                	j	11fa <printint.constprop.0+0x126>
    1286:	45b1                	li	a1,12
    if (sign)
    1288:	f60559e3          	bgez	a0,11fa <printint.constprop.0+0x126>
        buf[i--] = '-';
    128c:	02d00793          	li	a5,45
    1290:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    1294:	45ad                	li	a1,11
    1296:	b795                	j	11fa <printint.constprop.0+0x126>
    1298:	45ad                	li	a1,11
    if (sign)
    129a:	f60550e3          	bgez	a0,11fa <printint.constprop.0+0x126>
        buf[i--] = '-';
    129e:	02d00793          	li	a5,45
    12a2:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12a6:	45a9                	li	a1,10
    12a8:	bf89                	j	11fa <printint.constprop.0+0x126>
        buf[i--] = '-';
    12aa:	02d00793          	li	a5,45
    12ae:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12b2:	45b9                	li	a1,14
    12b4:	b799                	j	11fa <printint.constprop.0+0x126>
    12b6:	45a5                	li	a1,9
    if (sign)
    12b8:	f40551e3          	bgez	a0,11fa <printint.constprop.0+0x126>
        buf[i--] = '-';
    12bc:	02d00793          	li	a5,45
    12c0:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12c4:	45a1                	li	a1,8
    12c6:	bf15                	j	11fa <printint.constprop.0+0x126>
    i = 15;
    12c8:	45bd                	li	a1,15
    12ca:	bf05                	j	11fa <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12cc:	45a1                	li	a1,8
    if (sign)
    12ce:	f20556e3          	bgez	a0,11fa <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d2:	02d00793          	li	a5,45
    12d6:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12da:	459d                	li	a1,7
    12dc:	bf39                	j	11fa <printint.constprop.0+0x126>
    12de:	459d                	li	a1,7
    if (sign)
    12e0:	f0055de3          	bgez	a0,11fa <printint.constprop.0+0x126>
        buf[i--] = '-';
    12e4:	02d00793          	li	a5,45
    12e8:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12ec:	4599                	li	a1,6
    12ee:	b731                	j	11fa <printint.constprop.0+0x126>

00000000000012f0 <getchar>:
{
    12f0:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12f2:	00f10593          	addi	a1,sp,15
    12f6:	4605                	li	a2,1
    12f8:	4501                	li	a0,0
{
    12fa:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12fc:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1300:	191000ef          	jal	1c90 <read>
}
    1304:	60e2                	ld	ra,24(sp)
    1306:	00f14503          	lbu	a0,15(sp)
    130a:	6105                	addi	sp,sp,32
    130c:	8082                	ret

000000000000130e <putchar>:
{
    130e:	1101                	addi	sp,sp,-32
    1310:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1312:	00f10593          	addi	a1,sp,15
    1316:	4605                	li	a2,1
    1318:	4505                	li	a0,1
{
    131a:	ec06                	sd	ra,24(sp)
    char byte = c;
    131c:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1320:	17b000ef          	jal	1c9a <write>
}
    1324:	60e2                	ld	ra,24(sp)
    1326:	2501                	sext.w	a0,a0
    1328:	6105                	addi	sp,sp,32
    132a:	8082                	ret

000000000000132c <puts>:
{
    132c:	1141                	addi	sp,sp,-16
    132e:	e406                	sd	ra,8(sp)
    1330:	e022                	sd	s0,0(sp)
    1332:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1334:	582000ef          	jal	18b6 <strlen>
    1338:	862a                	mv	a2,a0
    133a:	85a2                	mv	a1,s0
    133c:	4505                	li	a0,1
    133e:	15d000ef          	jal	1c9a <write>
}
    1342:	60a2                	ld	ra,8(sp)
    1344:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1346:	957d                	srai	a0,a0,0x3f
    return r;
    1348:	2501                	sext.w	a0,a0
}
    134a:	0141                	addi	sp,sp,16
    134c:	8082                	ret

000000000000134e <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    134e:	7131                	addi	sp,sp,-192
    1350:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1352:	013c                	addi	a5,sp,136
{
    1354:	f0ca                	sd	s2,96(sp)
    1356:	ecce                	sd	s3,88(sp)
    1358:	e8d2                	sd	s4,80(sp)
    135a:	e4d6                	sd	s5,72(sp)
    135c:	e0da                	sd	s6,64(sp)
    135e:	fc5e                	sd	s7,56(sp)
    1360:	fc86                	sd	ra,120(sp)
    1362:	f8a2                	sd	s0,112(sp)
    1364:	f4a6                	sd	s1,104(sp)
    1366:	e52e                	sd	a1,136(sp)
    1368:	e932                	sd	a2,144(sp)
    136a:	ed36                	sd	a3,152(sp)
    136c:	f13a                	sd	a4,160(sp)
    136e:	f942                	sd	a6,176(sp)
    1370:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1372:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1374:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    1378:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    137c:	00001b97          	auipc	s7,0x1
    1380:	c14b8b93          	addi	s7,s7,-1004 # 1f90 <__clone+0xbe>
        switch (s[1])
    1384:	07800a93          	li	s5,120
    1388:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    138c:	00001997          	auipc	s3,0x1
    1390:	c3498993          	addi	s3,s3,-972 # 1fc0 <digits>
        if (!*s)
    1394:	00054783          	lbu	a5,0(a0)
    1398:	16078c63          	beqz	a5,1510 <printf+0x1c2>
    139c:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    139e:	19278463          	beq	a5,s2,1526 <printf+0x1d8>
    13a2:	00164783          	lbu	a5,1(a2)
    13a6:	0605                	addi	a2,a2,1
    13a8:	fbfd                	bnez	a5,139e <printf+0x50>
    13aa:	84b2                	mv	s1,a2
        l = z - a;
    13ac:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13b0:	85aa                	mv	a1,a0
    13b2:	8622                	mv	a2,s0
    13b4:	4505                	li	a0,1
    13b6:	0e5000ef          	jal	1c9a <write>
        if (l)
    13ba:	18041f63          	bnez	s0,1558 <printf+0x20a>
        if (s[1] == 0)
    13be:	0014c783          	lbu	a5,1(s1)
    13c2:	14078763          	beqz	a5,1510 <printf+0x1c2>
        switch (s[1])
    13c6:	1d478163          	beq	a5,s4,1588 <printf+0x23a>
    13ca:	18fa6963          	bltu	s4,a5,155c <printf+0x20e>
    13ce:	1b678363          	beq	a5,s6,1574 <printf+0x226>
    13d2:	07000713          	li	a4,112
    13d6:	1ce79c63          	bne	a5,a4,15ae <printf+0x260>
            printptr(va_arg(ap, uint64));
    13da:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13dc:	03000793          	li	a5,48
    13e0:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13e4:	631c                	ld	a5,0(a4)
    13e6:	0721                	addi	a4,a4,8
    13e8:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13ea:	00479f93          	slli	t6,a5,0x4
    13ee:	00879f13          	slli	t5,a5,0x8
    13f2:	00c79e93          	slli	t4,a5,0xc
    13f6:	01079e13          	slli	t3,a5,0x10
    13fa:	01479313          	slli	t1,a5,0x14
    13fe:	01879893          	slli	a7,a5,0x18
    1402:	01c79713          	slli	a4,a5,0x1c
    1406:	02479813          	slli	a6,a5,0x24
    140a:	02879513          	slli	a0,a5,0x28
    140e:	02c79593          	slli	a1,a5,0x2c
    1412:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1416:	03c7d293          	srli	t0,a5,0x3c
    141a:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    141e:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1422:	03cfdf93          	srli	t6,t6,0x3c
    1426:	03cf5f13          	srli	t5,t5,0x3c
    142a:	03cede93          	srli	t4,t4,0x3c
    142e:	03ce5e13          	srli	t3,t3,0x3c
    1432:	03c35313          	srli	t1,t1,0x3c
    1436:	03c8d893          	srli	a7,a7,0x3c
    143a:	9371                	srli	a4,a4,0x3c
    143c:	03c85813          	srli	a6,a6,0x3c
    1440:	9171                	srli	a0,a0,0x3c
    1442:	91f1                	srli	a1,a1,0x3c
    1444:	9271                	srli	a2,a2,0x3c
    1446:	974e                	add	a4,a4,s3
    1448:	92f1                	srli	a3,a3,0x3c
    144a:	92ce                	add	t0,t0,s3
    144c:	9fce                	add	t6,t6,s3
    144e:	9f4e                	add	t5,t5,s3
    1450:	9ece                	add	t4,t4,s3
    1452:	9e4e                	add	t3,t3,s3
    1454:	934e                	add	t1,t1,s3
    1456:	98ce                	add	a7,a7,s3
    1458:	93ce                	add	t2,t2,s3
    145a:	984e                	add	a6,a6,s3
    145c:	954e                	add	a0,a0,s3
    145e:	95ce                	add	a1,a1,s3
    1460:	964e                	add	a2,a2,s3
    1462:	0002c283          	lbu	t0,0(t0)
    1466:	000fcf83          	lbu	t6,0(t6)
    146a:	000f4f03          	lbu	t5,0(t5)
    146e:	000ece83          	lbu	t4,0(t4)
    1472:	000e4e03          	lbu	t3,0(t3)
    1476:	00034303          	lbu	t1,0(t1)
    147a:	0008c883          	lbu	a7,0(a7)
    147e:	00074403          	lbu	s0,0(a4)
    1482:	0003c383          	lbu	t2,0(t2)
    1486:	00084803          	lbu	a6,0(a6)
    148a:	00054503          	lbu	a0,0(a0)
    148e:	0005c583          	lbu	a1,0(a1)
    1492:	00064603          	lbu	a2,0(a2)
    1496:	00d98733          	add	a4,s3,a3
    149a:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    149e:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14a2:	9371                	srli	a4,a4,0x3c
    14a4:	8bbd                	andi	a5,a5,15
    14a6:	00510523          	sb	t0,10(sp)
    14aa:	01f105a3          	sb	t6,11(sp)
    14ae:	01e10623          	sb	t5,12(sp)
    14b2:	01d106a3          	sb	t4,13(sp)
    14b6:	01c10723          	sb	t3,14(sp)
    14ba:	006107a3          	sb	t1,15(sp)
    14be:	01110823          	sb	a7,16(sp)
    14c2:	00710923          	sb	t2,18(sp)
    14c6:	010109a3          	sb	a6,19(sp)
    14ca:	00a10a23          	sb	a0,20(sp)
    14ce:	00b10aa3          	sb	a1,21(sp)
    14d2:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14d6:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14da:	008108a3          	sb	s0,17(sp)
    14de:	974e                	add	a4,a4,s3
    14e0:	97ce                	add	a5,a5,s3
    14e2:	00d10ba3          	sb	a3,23(sp)
    14e6:	00074703          	lbu	a4,0(a4)
    14ea:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14ee:	4649                	li	a2,18
    14f0:	002c                	addi	a1,sp,8
    14f2:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14f4:	00e10c23          	sb	a4,24(sp)
    14f8:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14fc:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1500:	79a000ef          	jal	1c9a <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    1504:	00248513          	addi	a0,s1,2
        if (!*s)
    1508:	00054783          	lbu	a5,0(a0)
    150c:	e80798e3          	bnez	a5,139c <printf+0x4e>
    }
    va_end(ap);
}
    1510:	70e6                	ld	ra,120(sp)
    1512:	7446                	ld	s0,112(sp)
    1514:	74a6                	ld	s1,104(sp)
    1516:	7906                	ld	s2,96(sp)
    1518:	69e6                	ld	s3,88(sp)
    151a:	6a46                	ld	s4,80(sp)
    151c:	6aa6                	ld	s5,72(sp)
    151e:	6b06                	ld	s6,64(sp)
    1520:	7be2                	ld	s7,56(sp)
    1522:	6129                	addi	sp,sp,192
    1524:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1526:	00064783          	lbu	a5,0(a2)
    152a:	84b2                	mv	s1,a2
    152c:	01278963          	beq	a5,s2,153e <printf+0x1f0>
    1530:	bdb5                	j	13ac <printf+0x5e>
    1532:	0024c783          	lbu	a5,2(s1)
    1536:	0605                	addi	a2,a2,1
    1538:	0489                	addi	s1,s1,2
    153a:	e72799e3          	bne	a5,s2,13ac <printf+0x5e>
    153e:	0014c783          	lbu	a5,1(s1)
    1542:	ff2788e3          	beq	a5,s2,1532 <printf+0x1e4>
        l = z - a;
    1546:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    154a:	85aa                	mv	a1,a0
    154c:	8622                	mv	a2,s0
    154e:	4505                	li	a0,1
    1550:	74a000ef          	jal	1c9a <write>
        if (l)
    1554:	e60405e3          	beqz	s0,13be <printf+0x70>
    1558:	8526                	mv	a0,s1
    155a:	bd2d                	j	1394 <printf+0x46>
        switch (s[1])
    155c:	05579963          	bne	a5,s5,15ae <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1560:	6782                	ld	a5,0(sp)
    1562:	45c1                	li	a1,16
    1564:	4388                	lw	a0,0(a5)
    1566:	07a1                	addi	a5,a5,8
    1568:	e03e                	sd	a5,0(sp)
    156a:	b6bff0ef          	jal	10d4 <printint.constprop.0>
        s += 2;
    156e:	00248513          	addi	a0,s1,2
    1572:	bf59                	j	1508 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1574:	6782                	ld	a5,0(sp)
    1576:	45a9                	li	a1,10
    1578:	4388                	lw	a0,0(a5)
    157a:	07a1                	addi	a5,a5,8
    157c:	e03e                	sd	a5,0(sp)
    157e:	b57ff0ef          	jal	10d4 <printint.constprop.0>
        s += 2;
    1582:	00248513          	addi	a0,s1,2
    1586:	b749                	j	1508 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1588:	6782                	ld	a5,0(sp)
    158a:	6380                	ld	s0,0(a5)
    158c:	07a1                	addi	a5,a5,8
    158e:	e03e                	sd	a5,0(sp)
    1590:	c031                	beqz	s0,15d4 <printf+0x286>
            l = strnlen(a, 200);
    1592:	0c800593          	li	a1,200
    1596:	8522                	mv	a0,s0
    1598:	40a000ef          	jal	19a2 <strnlen>
    write(f, s, l);
    159c:	0005061b          	sext.w	a2,a0
    15a0:	85a2                	mv	a1,s0
    15a2:	4505                	li	a0,1
    15a4:	6f6000ef          	jal	1c9a <write>
        s += 2;
    15a8:	00248513          	addi	a0,s1,2
    15ac:	bfb1                	j	1508 <printf+0x1ba>
    return write(stdout, &byte, 1);
    15ae:	4605                	li	a2,1
    15b0:	002c                	addi	a1,sp,8
    15b2:	4505                	li	a0,1
    char byte = c;
    15b4:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15b8:	6e2000ef          	jal	1c9a <write>
    char byte = c;
    15bc:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15c0:	4605                	li	a2,1
    15c2:	002c                	addi	a1,sp,8
    15c4:	4505                	li	a0,1
    char byte = c;
    15c6:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15ca:	6d0000ef          	jal	1c9a <write>
        s += 2;
    15ce:	00248513          	addi	a0,s1,2
    15d2:	bf1d                	j	1508 <printf+0x1ba>
                a = "(null)";
    15d4:	845e                	mv	s0,s7
    15d6:	bf75                	j	1592 <printf+0x244>

00000000000015d8 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15d8:	1141                	addi	sp,sp,-16
    15da:	e406                	sd	ra,8(sp)
    puts(m);
    15dc:	d51ff0ef          	jal	132c <puts>
    exit(-100);
}
    15e0:	60a2                	ld	ra,8(sp)
    exit(-100);
    15e2:	f9c00513          	li	a0,-100
}
    15e6:	0141                	addi	sp,sp,16
    exit(-100);
    15e8:	a709                	j	1cea <exit>

00000000000015ea <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15ea:	02000793          	li	a5,32
    15ee:	00f50663          	beq	a0,a5,15fa <isspace+0x10>
    15f2:	355d                	addiw	a0,a0,-9
    15f4:	00553513          	sltiu	a0,a0,5
    15f8:	8082                	ret
    15fa:	4505                	li	a0,1
}
    15fc:	8082                	ret

00000000000015fe <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15fe:	fd05051b          	addiw	a0,a0,-48
}
    1602:	00a53513          	sltiu	a0,a0,10
    1606:	8082                	ret

0000000000001608 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1608:	02000613          	li	a2,32
    160c:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    160e:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1612:	ff77069b          	addiw	a3,a4,-9
    1616:	04c70d63          	beq	a4,a2,1670 <atoi+0x68>
    161a:	0007079b          	sext.w	a5,a4
    161e:	04d5f963          	bgeu	a1,a3,1670 <atoi+0x68>
        s++;
    switch (*s)
    1622:	02b00693          	li	a3,43
    1626:	04d70a63          	beq	a4,a3,167a <atoi+0x72>
    162a:	02d00693          	li	a3,45
    162e:	06d70463          	beq	a4,a3,1696 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1632:	fd07859b          	addiw	a1,a5,-48
    1636:	4625                	li	a2,9
    1638:	873e                	mv	a4,a5
    163a:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    163c:	4e01                	li	t3,0
    while (isdigit(*s))
    163e:	04b66a63          	bltu	a2,a1,1692 <atoi+0x8a>
    int n = 0, neg = 0;
    1642:	4501                	li	a0,0
    while (isdigit(*s))
    1644:	4825                	li	a6,9
    1646:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    164a:	0025179b          	slliw	a5,a0,0x2
    164e:	9d3d                	addw	a0,a0,a5
    1650:	fd07031b          	addiw	t1,a4,-48
    1654:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1658:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    165c:	0685                	addi	a3,a3,1
    165e:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1662:	0006071b          	sext.w	a4,a2
    1666:	feb870e3          	bgeu	a6,a1,1646 <atoi+0x3e>
    return neg ? n : -n;
    166a:	000e0563          	beqz	t3,1674 <atoi+0x6c>
}
    166e:	8082                	ret
        s++;
    1670:	0505                	addi	a0,a0,1
    1672:	bf71                	j	160e <atoi+0x6>
    return neg ? n : -n;
    1674:	4113053b          	subw	a0,t1,a7
    1678:	8082                	ret
    while (isdigit(*s))
    167a:	00154783          	lbu	a5,1(a0)
    167e:	4625                	li	a2,9
        s++;
    1680:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1684:	fd07859b          	addiw	a1,a5,-48
    1688:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    168c:	4e01                	li	t3,0
    while (isdigit(*s))
    168e:	fab67ae3          	bgeu	a2,a1,1642 <atoi+0x3a>
    1692:	4501                	li	a0,0
}
    1694:	8082                	ret
    while (isdigit(*s))
    1696:	00154783          	lbu	a5,1(a0)
    169a:	4625                	li	a2,9
        s++;
    169c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16a0:	fd07859b          	addiw	a1,a5,-48
    16a4:	0007871b          	sext.w	a4,a5
    16a8:	feb665e3          	bltu	a2,a1,1692 <atoi+0x8a>
        neg = 1;
    16ac:	4e05                	li	t3,1
    16ae:	bf51                	j	1642 <atoi+0x3a>

00000000000016b0 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16b0:	16060d63          	beqz	a2,182a <memset+0x17a>
    16b4:	40a007b3          	neg	a5,a0
    16b8:	8b9d                	andi	a5,a5,7
    16ba:	00778713          	addi	a4,a5,7
    16be:	482d                	li	a6,11
    16c0:	0ff5f593          	zext.b	a1,a1
    16c4:	fff60693          	addi	a3,a2,-1
    16c8:	17076263          	bltu	a4,a6,182c <memset+0x17c>
    16cc:	16e6ea63          	bltu	a3,a4,1840 <memset+0x190>
    16d0:	16078563          	beqz	a5,183a <memset+0x18a>
    16d4:	00b50023          	sb	a1,0(a0)
    16d8:	4705                	li	a4,1
    16da:	00150e93          	addi	t4,a0,1
    16de:	14e78c63          	beq	a5,a4,1836 <memset+0x186>
    16e2:	00b500a3          	sb	a1,1(a0)
    16e6:	4709                	li	a4,2
    16e8:	00250e93          	addi	t4,a0,2
    16ec:	14e78d63          	beq	a5,a4,1846 <memset+0x196>
    16f0:	00b50123          	sb	a1,2(a0)
    16f4:	470d                	li	a4,3
    16f6:	00350e93          	addi	t4,a0,3
    16fa:	12e78b63          	beq	a5,a4,1830 <memset+0x180>
    16fe:	00b501a3          	sb	a1,3(a0)
    1702:	4711                	li	a4,4
    1704:	00450e93          	addi	t4,a0,4
    1708:	14e78163          	beq	a5,a4,184a <memset+0x19a>
    170c:	00b50223          	sb	a1,4(a0)
    1710:	4715                	li	a4,5
    1712:	00550e93          	addi	t4,a0,5
    1716:	12e78c63          	beq	a5,a4,184e <memset+0x19e>
    171a:	00b502a3          	sb	a1,5(a0)
    171e:	471d                	li	a4,7
    1720:	00650e93          	addi	t4,a0,6
    1724:	12e79763          	bne	a5,a4,1852 <memset+0x1a2>
    1728:	00750e93          	addi	t4,a0,7
    172c:	00b50323          	sb	a1,6(a0)
    1730:	4f1d                	li	t5,7
    1732:	00859713          	slli	a4,a1,0x8
    1736:	8f4d                	or	a4,a4,a1
    1738:	01059e13          	slli	t3,a1,0x10
    173c:	01c76e33          	or	t3,a4,t3
    1740:	01859313          	slli	t1,a1,0x18
    1744:	006e6333          	or	t1,t3,t1
    1748:	02059893          	slli	a7,a1,0x20
    174c:	011368b3          	or	a7,t1,a7
    1750:	02859813          	slli	a6,a1,0x28
    1754:	40f60333          	sub	t1,a2,a5
    1758:	0108e833          	or	a6,a7,a6
    175c:	03059693          	slli	a3,a1,0x30
    1760:	00d866b3          	or	a3,a6,a3
    1764:	03859713          	slli	a4,a1,0x38
    1768:	97aa                	add	a5,a5,a0
    176a:	ff837813          	andi	a6,t1,-8
    176e:	8f55                	or	a4,a4,a3
    1770:	00f806b3          	add	a3,a6,a5
    1774:	e398                	sd	a4,0(a5)
    1776:	07a1                	addi	a5,a5,8
    1778:	fed79ee3          	bne	a5,a3,1774 <memset+0xc4>
    177c:	ff837693          	andi	a3,t1,-8
    1780:	00de87b3          	add	a5,t4,a3
    1784:	01e6873b          	addw	a4,a3,t5
    1788:	0ad30663          	beq	t1,a3,1834 <memset+0x184>
    178c:	00b78023          	sb	a1,0(a5)
    1790:	0017069b          	addiw	a3,a4,1
    1794:	08c6fb63          	bgeu	a3,a2,182a <memset+0x17a>
    1798:	00b780a3          	sb	a1,1(a5)
    179c:	0027069b          	addiw	a3,a4,2
    17a0:	08c6f563          	bgeu	a3,a2,182a <memset+0x17a>
    17a4:	00b78123          	sb	a1,2(a5)
    17a8:	0037069b          	addiw	a3,a4,3
    17ac:	06c6ff63          	bgeu	a3,a2,182a <memset+0x17a>
    17b0:	00b781a3          	sb	a1,3(a5)
    17b4:	0047069b          	addiw	a3,a4,4
    17b8:	06c6f963          	bgeu	a3,a2,182a <memset+0x17a>
    17bc:	00b78223          	sb	a1,4(a5)
    17c0:	0057069b          	addiw	a3,a4,5
    17c4:	06c6f363          	bgeu	a3,a2,182a <memset+0x17a>
    17c8:	00b782a3          	sb	a1,5(a5)
    17cc:	0067069b          	addiw	a3,a4,6
    17d0:	04c6fd63          	bgeu	a3,a2,182a <memset+0x17a>
    17d4:	00b78323          	sb	a1,6(a5)
    17d8:	0077069b          	addiw	a3,a4,7
    17dc:	04c6f763          	bgeu	a3,a2,182a <memset+0x17a>
    17e0:	00b783a3          	sb	a1,7(a5)
    17e4:	0087069b          	addiw	a3,a4,8
    17e8:	04c6f163          	bgeu	a3,a2,182a <memset+0x17a>
    17ec:	00b78423          	sb	a1,8(a5)
    17f0:	0097069b          	addiw	a3,a4,9
    17f4:	02c6fb63          	bgeu	a3,a2,182a <memset+0x17a>
    17f8:	00b784a3          	sb	a1,9(a5)
    17fc:	00a7069b          	addiw	a3,a4,10
    1800:	02c6f563          	bgeu	a3,a2,182a <memset+0x17a>
    1804:	00b78523          	sb	a1,10(a5)
    1808:	00b7069b          	addiw	a3,a4,11
    180c:	00c6ff63          	bgeu	a3,a2,182a <memset+0x17a>
    1810:	00b785a3          	sb	a1,11(a5)
    1814:	00c7069b          	addiw	a3,a4,12
    1818:	00c6f963          	bgeu	a3,a2,182a <memset+0x17a>
    181c:	00b78623          	sb	a1,12(a5)
    1820:	2735                	addiw	a4,a4,13
    1822:	00c77463          	bgeu	a4,a2,182a <memset+0x17a>
    1826:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    182a:	8082                	ret
    182c:	472d                	li	a4,11
    182e:	bd79                	j	16cc <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1830:	4f0d                	li	t5,3
    1832:	b701                	j	1732 <memset+0x82>
    1834:	8082                	ret
    1836:	4f05                	li	t5,1
    1838:	bded                	j	1732 <memset+0x82>
    183a:	8eaa                	mv	t4,a0
    183c:	4f01                	li	t5,0
    183e:	bdd5                	j	1732 <memset+0x82>
    1840:	87aa                	mv	a5,a0
    1842:	4701                	li	a4,0
    1844:	b7a1                	j	178c <memset+0xdc>
    1846:	4f09                	li	t5,2
    1848:	b5ed                	j	1732 <memset+0x82>
    184a:	4f11                	li	t5,4
    184c:	b5dd                	j	1732 <memset+0x82>
    184e:	4f15                	li	t5,5
    1850:	b5cd                	j	1732 <memset+0x82>
    1852:	4f19                	li	t5,6
    1854:	bdf9                	j	1732 <memset+0x82>

0000000000001856 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1856:	00054783          	lbu	a5,0(a0)
    185a:	0005c703          	lbu	a4,0(a1)
    185e:	00e79863          	bne	a5,a4,186e <strcmp+0x18>
    1862:	0505                	addi	a0,a0,1
    1864:	0585                	addi	a1,a1,1
    1866:	fbe5                	bnez	a5,1856 <strcmp>
    1868:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    186a:	9d19                	subw	a0,a0,a4
    186c:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    186e:	0007851b          	sext.w	a0,a5
    1872:	bfe5                	j	186a <strcmp+0x14>

0000000000001874 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1874:	ce05                	beqz	a2,18ac <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1876:	00054703          	lbu	a4,0(a0)
    187a:	0005c783          	lbu	a5,0(a1)
    187e:	cb0d                	beqz	a4,18b0 <strncmp+0x3c>
    if (!n--)
    1880:	167d                	addi	a2,a2,-1
    1882:	00c506b3          	add	a3,a0,a2
    1886:	a819                	j	189c <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1888:	00a68e63          	beq	a3,a0,18a4 <strncmp+0x30>
    188c:	0505                	addi	a0,a0,1
    188e:	00e79b63          	bne	a5,a4,18a4 <strncmp+0x30>
    1892:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    1896:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    189a:	cb19                	beqz	a4,18b0 <strncmp+0x3c>
    189c:	0005c783          	lbu	a5,0(a1)
    18a0:	0585                	addi	a1,a1,1
    18a2:	f3fd                	bnez	a5,1888 <strncmp+0x14>
    return *l - *r;
    18a4:	0007051b          	sext.w	a0,a4
    18a8:	9d1d                	subw	a0,a0,a5
    18aa:	8082                	ret
        return 0;
    18ac:	4501                	li	a0,0
}
    18ae:	8082                	ret
    18b0:	4501                	li	a0,0
    return *l - *r;
    18b2:	9d1d                	subw	a0,a0,a5
    18b4:	8082                	ret

00000000000018b6 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18b6:	00757793          	andi	a5,a0,7
    18ba:	cf89                	beqz	a5,18d4 <strlen+0x1e>
    18bc:	87aa                	mv	a5,a0
    18be:	a029                	j	18c8 <strlen+0x12>
    18c0:	0785                	addi	a5,a5,1
    18c2:	0077f713          	andi	a4,a5,7
    18c6:	cb01                	beqz	a4,18d6 <strlen+0x20>
        if (!*s)
    18c8:	0007c703          	lbu	a4,0(a5)
    18cc:	fb75                	bnez	a4,18c0 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18ce:	40a78533          	sub	a0,a5,a0
}
    18d2:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18d4:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18d6:	6394                	ld	a3,0(a5)
    18d8:	00000597          	auipc	a1,0x0
    18dc:	6c05b583          	ld	a1,1728(a1) # 1f98 <__clone+0xc6>
    18e0:	00000617          	auipc	a2,0x0
    18e4:	6c063603          	ld	a2,1728(a2) # 1fa0 <__clone+0xce>
    18e8:	a019                	j	18ee <strlen+0x38>
    18ea:	6794                	ld	a3,8(a5)
    18ec:	07a1                	addi	a5,a5,8
    18ee:	00b68733          	add	a4,a3,a1
    18f2:	fff6c693          	not	a3,a3
    18f6:	8f75                	and	a4,a4,a3
    18f8:	8f71                	and	a4,a4,a2
    18fa:	db65                	beqz	a4,18ea <strlen+0x34>
    for (; *s; s++)
    18fc:	0007c703          	lbu	a4,0(a5)
    1900:	d779                	beqz	a4,18ce <strlen+0x18>
    1902:	0017c703          	lbu	a4,1(a5)
    1906:	0785                	addi	a5,a5,1
    1908:	d379                	beqz	a4,18ce <strlen+0x18>
    190a:	0017c703          	lbu	a4,1(a5)
    190e:	0785                	addi	a5,a5,1
    1910:	fb6d                	bnez	a4,1902 <strlen+0x4c>
    1912:	bf75                	j	18ce <strlen+0x18>

0000000000001914 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1914:	00757713          	andi	a4,a0,7
{
    1918:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    191a:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    191e:	cb19                	beqz	a4,1934 <memchr+0x20>
    1920:	ce25                	beqz	a2,1998 <memchr+0x84>
    1922:	0007c703          	lbu	a4,0(a5)
    1926:	04b70e63          	beq	a4,a1,1982 <memchr+0x6e>
    192a:	0785                	addi	a5,a5,1
    192c:	0077f713          	andi	a4,a5,7
    1930:	167d                	addi	a2,a2,-1
    1932:	f77d                	bnez	a4,1920 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1934:	4501                	li	a0,0
    if (n && *s != c)
    1936:	c235                	beqz	a2,199a <memchr+0x86>
    1938:	0007c703          	lbu	a4,0(a5)
    193c:	04b70363          	beq	a4,a1,1982 <memchr+0x6e>
        size_t k = ONES * c;
    1940:	00000517          	auipc	a0,0x0
    1944:	66853503          	ld	a0,1640(a0) # 1fa8 <__clone+0xd6>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1948:	471d                	li	a4,7
        size_t k = ONES * c;
    194a:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    194e:	02c77a63          	bgeu	a4,a2,1982 <memchr+0x6e>
    1952:	00000897          	auipc	a7,0x0
    1956:	6468b883          	ld	a7,1606(a7) # 1f98 <__clone+0xc6>
    195a:	00000817          	auipc	a6,0x0
    195e:	64683803          	ld	a6,1606(a6) # 1fa0 <__clone+0xce>
    1962:	431d                	li	t1,7
    1964:	a029                	j	196e <memchr+0x5a>
    1966:	1661                	addi	a2,a2,-8
    1968:	07a1                	addi	a5,a5,8
    196a:	02c37963          	bgeu	t1,a2,199c <memchr+0x88>
    196e:	6398                	ld	a4,0(a5)
    1970:	8f29                	xor	a4,a4,a0
    1972:	011706b3          	add	a3,a4,a7
    1976:	fff74713          	not	a4,a4
    197a:	8f75                	and	a4,a4,a3
    197c:	01077733          	and	a4,a4,a6
    1980:	d37d                	beqz	a4,1966 <memchr+0x52>
    1982:	853e                	mv	a0,a5
    1984:	97b2                	add	a5,a5,a2
    1986:	a021                	j	198e <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1988:	0505                	addi	a0,a0,1
    198a:	00f50763          	beq	a0,a5,1998 <memchr+0x84>
    198e:	00054703          	lbu	a4,0(a0)
    1992:	feb71be3          	bne	a4,a1,1988 <memchr+0x74>
    1996:	8082                	ret
    return n ? (void *)s : 0;
    1998:	4501                	li	a0,0
}
    199a:	8082                	ret
    return n ? (void *)s : 0;
    199c:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    199e:	f275                	bnez	a2,1982 <memchr+0x6e>
}
    19a0:	8082                	ret

00000000000019a2 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19a2:	1101                	addi	sp,sp,-32
    19a4:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19a6:	862e                	mv	a2,a1
{
    19a8:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19aa:	4581                	li	a1,0
{
    19ac:	e426                	sd	s1,8(sp)
    19ae:	ec06                	sd	ra,24(sp)
    19b0:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19b2:	f63ff0ef          	jal	1914 <memchr>
    return p ? p - s : n;
    19b6:	c519                	beqz	a0,19c4 <strnlen+0x22>
}
    19b8:	60e2                	ld	ra,24(sp)
    19ba:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19bc:	8d05                	sub	a0,a0,s1
}
    19be:	64a2                	ld	s1,8(sp)
    19c0:	6105                	addi	sp,sp,32
    19c2:	8082                	ret
    19c4:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19c6:	8522                	mv	a0,s0
}
    19c8:	6442                	ld	s0,16(sp)
    19ca:	64a2                	ld	s1,8(sp)
    19cc:	6105                	addi	sp,sp,32
    19ce:	8082                	ret

00000000000019d0 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19d0:	00b547b3          	xor	a5,a0,a1
    19d4:	8b9d                	andi	a5,a5,7
    19d6:	eb95                	bnez	a5,1a0a <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19d8:	0075f793          	andi	a5,a1,7
    19dc:	e7b1                	bnez	a5,1a28 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19de:	6198                	ld	a4,0(a1)
    19e0:	00000617          	auipc	a2,0x0
    19e4:	5b863603          	ld	a2,1464(a2) # 1f98 <__clone+0xc6>
    19e8:	00000817          	auipc	a6,0x0
    19ec:	5b883803          	ld	a6,1464(a6) # 1fa0 <__clone+0xce>
    19f0:	a029                	j	19fa <strcpy+0x2a>
    19f2:	e118                	sd	a4,0(a0)
    19f4:	6598                	ld	a4,8(a1)
    19f6:	05a1                	addi	a1,a1,8
    19f8:	0521                	addi	a0,a0,8
    19fa:	00c707b3          	add	a5,a4,a2
    19fe:	fff74693          	not	a3,a4
    1a02:	8ff5                	and	a5,a5,a3
    1a04:	0107f7b3          	and	a5,a5,a6
    1a08:	d7ed                	beqz	a5,19f2 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a0a:	0005c783          	lbu	a5,0(a1)
    1a0e:	00f50023          	sb	a5,0(a0)
    1a12:	c785                	beqz	a5,1a3a <strcpy+0x6a>
    1a14:	0015c783          	lbu	a5,1(a1)
    1a18:	0505                	addi	a0,a0,1
    1a1a:	0585                	addi	a1,a1,1
    1a1c:	00f50023          	sb	a5,0(a0)
    1a20:	fbf5                	bnez	a5,1a14 <strcpy+0x44>
        ;
    return d;
}
    1a22:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a24:	0505                	addi	a0,a0,1
    1a26:	df45                	beqz	a4,19de <strcpy+0xe>
            if (!(*d = *s))
    1a28:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a2c:	0585                	addi	a1,a1,1
    1a2e:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a32:	00f50023          	sb	a5,0(a0)
    1a36:	f7fd                	bnez	a5,1a24 <strcpy+0x54>
}
    1a38:	8082                	ret
    1a3a:	8082                	ret

0000000000001a3c <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a3c:	00b547b3          	xor	a5,a0,a1
    1a40:	8b9d                	andi	a5,a5,7
    1a42:	1a079863          	bnez	a5,1bf2 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a46:	0075f793          	andi	a5,a1,7
    1a4a:	16078463          	beqz	a5,1bb2 <strncpy+0x176>
    1a4e:	ea01                	bnez	a2,1a5e <strncpy+0x22>
    1a50:	a421                	j	1c58 <strncpy+0x21c>
    1a52:	167d                	addi	a2,a2,-1
    1a54:	0505                	addi	a0,a0,1
    1a56:	14070e63          	beqz	a4,1bb2 <strncpy+0x176>
    1a5a:	1a060863          	beqz	a2,1c0a <strncpy+0x1ce>
    1a5e:	0005c783          	lbu	a5,0(a1)
    1a62:	0585                	addi	a1,a1,1
    1a64:	0075f713          	andi	a4,a1,7
    1a68:	00f50023          	sb	a5,0(a0)
    1a6c:	f3fd                	bnez	a5,1a52 <strncpy+0x16>
    1a6e:	4805                	li	a6,1
    1a70:	1a061863          	bnez	a2,1c20 <strncpy+0x1e4>
    1a74:	40a007b3          	neg	a5,a0
    1a78:	8b9d                	andi	a5,a5,7
    1a7a:	4681                	li	a3,0
    1a7c:	18061a63          	bnez	a2,1c10 <strncpy+0x1d4>
    1a80:	00778713          	addi	a4,a5,7
    1a84:	45ad                	li	a1,11
    1a86:	18b76363          	bltu	a4,a1,1c0c <strncpy+0x1d0>
    1a8a:	1ae6eb63          	bltu	a3,a4,1c40 <strncpy+0x204>
    1a8e:	1a078363          	beqz	a5,1c34 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a92:	00050023          	sb	zero,0(a0)
    1a96:	4685                	li	a3,1
    1a98:	00150713          	addi	a4,a0,1
    1a9c:	18d78f63          	beq	a5,a3,1c3a <strncpy+0x1fe>
    1aa0:	000500a3          	sb	zero,1(a0)
    1aa4:	4689                	li	a3,2
    1aa6:	00250713          	addi	a4,a0,2
    1aaa:	18d78e63          	beq	a5,a3,1c46 <strncpy+0x20a>
    1aae:	00050123          	sb	zero,2(a0)
    1ab2:	468d                	li	a3,3
    1ab4:	00350713          	addi	a4,a0,3
    1ab8:	16d78c63          	beq	a5,a3,1c30 <strncpy+0x1f4>
    1abc:	000501a3          	sb	zero,3(a0)
    1ac0:	4691                	li	a3,4
    1ac2:	00450713          	addi	a4,a0,4
    1ac6:	18d78263          	beq	a5,a3,1c4a <strncpy+0x20e>
    1aca:	00050223          	sb	zero,4(a0)
    1ace:	4695                	li	a3,5
    1ad0:	00550713          	addi	a4,a0,5
    1ad4:	16d78d63          	beq	a5,a3,1c4e <strncpy+0x212>
    1ad8:	000502a3          	sb	zero,5(a0)
    1adc:	469d                	li	a3,7
    1ade:	00650713          	addi	a4,a0,6
    1ae2:	16d79863          	bne	a5,a3,1c52 <strncpy+0x216>
    1ae6:	00750713          	addi	a4,a0,7
    1aea:	00050323          	sb	zero,6(a0)
    1aee:	40f80833          	sub	a6,a6,a5
    1af2:	ff887593          	andi	a1,a6,-8
    1af6:	97aa                	add	a5,a5,a0
    1af8:	95be                	add	a1,a1,a5
    1afa:	0007b023          	sd	zero,0(a5)
    1afe:	07a1                	addi	a5,a5,8
    1b00:	feb79de3          	bne	a5,a1,1afa <strncpy+0xbe>
    1b04:	ff887593          	andi	a1,a6,-8
    1b08:	9ead                	addw	a3,a3,a1
    1b0a:	00b707b3          	add	a5,a4,a1
    1b0e:	12b80863          	beq	a6,a1,1c3e <strncpy+0x202>
    1b12:	00078023          	sb	zero,0(a5)
    1b16:	0016871b          	addiw	a4,a3,1
    1b1a:	0ec77863          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1b1e:	000780a3          	sb	zero,1(a5)
    1b22:	0026871b          	addiw	a4,a3,2
    1b26:	0ec77263          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1b2a:	00078123          	sb	zero,2(a5)
    1b2e:	0036871b          	addiw	a4,a3,3
    1b32:	0cc77c63          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1b36:	000781a3          	sb	zero,3(a5)
    1b3a:	0046871b          	addiw	a4,a3,4
    1b3e:	0cc77663          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1b42:	00078223          	sb	zero,4(a5)
    1b46:	0056871b          	addiw	a4,a3,5
    1b4a:	0cc77063          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1b4e:	000782a3          	sb	zero,5(a5)
    1b52:	0066871b          	addiw	a4,a3,6
    1b56:	0ac77a63          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1b5a:	00078323          	sb	zero,6(a5)
    1b5e:	0076871b          	addiw	a4,a3,7
    1b62:	0ac77463          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1b66:	000783a3          	sb	zero,7(a5)
    1b6a:	0086871b          	addiw	a4,a3,8
    1b6e:	08c77e63          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1b72:	00078423          	sb	zero,8(a5)
    1b76:	0096871b          	addiw	a4,a3,9
    1b7a:	08c77863          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1b7e:	000784a3          	sb	zero,9(a5)
    1b82:	00a6871b          	addiw	a4,a3,10
    1b86:	08c77263          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1b8a:	00078523          	sb	zero,10(a5)
    1b8e:	00b6871b          	addiw	a4,a3,11
    1b92:	06c77c63          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1b96:	000785a3          	sb	zero,11(a5)
    1b9a:	00c6871b          	addiw	a4,a3,12
    1b9e:	06c77663          	bgeu	a4,a2,1c0a <strncpy+0x1ce>
    1ba2:	00078623          	sb	zero,12(a5)
    1ba6:	26b5                	addiw	a3,a3,13
    1ba8:	06c6f163          	bgeu	a3,a2,1c0a <strncpy+0x1ce>
    1bac:	000786a3          	sb	zero,13(a5)
    1bb0:	8082                	ret
            ;
        if (!n || !*s)
    1bb2:	c645                	beqz	a2,1c5a <strncpy+0x21e>
    1bb4:	0005c783          	lbu	a5,0(a1)
    1bb8:	ea078be3          	beqz	a5,1a6e <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bbc:	479d                	li	a5,7
    1bbe:	02c7ff63          	bgeu	a5,a2,1bfc <strncpy+0x1c0>
    1bc2:	00000897          	auipc	a7,0x0
    1bc6:	3d68b883          	ld	a7,982(a7) # 1f98 <__clone+0xc6>
    1bca:	00000817          	auipc	a6,0x0
    1bce:	3d683803          	ld	a6,982(a6) # 1fa0 <__clone+0xce>
    1bd2:	431d                	li	t1,7
    1bd4:	6198                	ld	a4,0(a1)
    1bd6:	011707b3          	add	a5,a4,a7
    1bda:	fff74693          	not	a3,a4
    1bde:	8ff5                	and	a5,a5,a3
    1be0:	0107f7b3          	and	a5,a5,a6
    1be4:	ef81                	bnez	a5,1bfc <strncpy+0x1c0>
            *wd = *ws;
    1be6:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1be8:	1661                	addi	a2,a2,-8
    1bea:	05a1                	addi	a1,a1,8
    1bec:	0521                	addi	a0,a0,8
    1bee:	fec363e3          	bltu	t1,a2,1bd4 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bf2:	e609                	bnez	a2,1bfc <strncpy+0x1c0>
    1bf4:	a08d                	j	1c56 <strncpy+0x21a>
    1bf6:	167d                	addi	a2,a2,-1
    1bf8:	0505                	addi	a0,a0,1
    1bfa:	ca01                	beqz	a2,1c0a <strncpy+0x1ce>
    1bfc:	0005c783          	lbu	a5,0(a1)
    1c00:	0585                	addi	a1,a1,1
    1c02:	00f50023          	sb	a5,0(a0)
    1c06:	fbe5                	bnez	a5,1bf6 <strncpy+0x1ba>
        ;
tail:
    1c08:	b59d                	j	1a6e <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c0a:	8082                	ret
    1c0c:	472d                	li	a4,11
    1c0e:	bdb5                	j	1a8a <strncpy+0x4e>
    1c10:	00778713          	addi	a4,a5,7
    1c14:	45ad                	li	a1,11
    1c16:	fff60693          	addi	a3,a2,-1
    1c1a:	e6b778e3          	bgeu	a4,a1,1a8a <strncpy+0x4e>
    1c1e:	b7fd                	j	1c0c <strncpy+0x1d0>
    1c20:	40a007b3          	neg	a5,a0
    1c24:	8832                	mv	a6,a2
    1c26:	8b9d                	andi	a5,a5,7
    1c28:	4681                	li	a3,0
    1c2a:	e4060be3          	beqz	a2,1a80 <strncpy+0x44>
    1c2e:	b7cd                	j	1c10 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c30:	468d                	li	a3,3
    1c32:	bd75                	j	1aee <strncpy+0xb2>
    1c34:	872a                	mv	a4,a0
    1c36:	4681                	li	a3,0
    1c38:	bd5d                	j	1aee <strncpy+0xb2>
    1c3a:	4685                	li	a3,1
    1c3c:	bd4d                	j	1aee <strncpy+0xb2>
    1c3e:	8082                	ret
    1c40:	87aa                	mv	a5,a0
    1c42:	4681                	li	a3,0
    1c44:	b5f9                	j	1b12 <strncpy+0xd6>
    1c46:	4689                	li	a3,2
    1c48:	b55d                	j	1aee <strncpy+0xb2>
    1c4a:	4691                	li	a3,4
    1c4c:	b54d                	j	1aee <strncpy+0xb2>
    1c4e:	4695                	li	a3,5
    1c50:	bd79                	j	1aee <strncpy+0xb2>
    1c52:	4699                	li	a3,6
    1c54:	bd69                	j	1aee <strncpy+0xb2>
    1c56:	8082                	ret
    1c58:	8082                	ret
    1c5a:	8082                	ret

0000000000001c5c <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c5c:	87aa                	mv	a5,a0
    1c5e:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c60:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c64:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c68:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c6a:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c6c:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c70:	2501                	sext.w	a0,a0
    1c72:	8082                	ret

0000000000001c74 <openat>:
    register long a7 __asm__("a7") = n;
    1c74:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c78:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c7c:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c80:	2501                	sext.w	a0,a0
    1c82:	8082                	ret

0000000000001c84 <close>:
    register long a7 __asm__("a7") = n;
    1c84:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c88:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c8c:	2501                	sext.w	a0,a0
    1c8e:	8082                	ret

0000000000001c90 <read>:
    register long a7 __asm__("a7") = n;
    1c90:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c94:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c98:	8082                	ret

0000000000001c9a <write>:
    register long a7 __asm__("a7") = n;
    1c9a:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c9e:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1ca2:	8082                	ret

0000000000001ca4 <getpid>:
    register long a7 __asm__("a7") = n;
    1ca4:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1ca8:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cac:	2501                	sext.w	a0,a0
    1cae:	8082                	ret

0000000000001cb0 <getppid>:
    register long a7 __asm__("a7") = n;
    1cb0:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cb4:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cb8:	2501                	sext.w	a0,a0
    1cba:	8082                	ret

0000000000001cbc <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cbc:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cc0:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cc4:	2501                	sext.w	a0,a0
    1cc6:	8082                	ret

0000000000001cc8 <fork>:
    register long a7 __asm__("a7") = n;
    1cc8:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1ccc:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cce:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cd0:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cd4:	2501                	sext.w	a0,a0
    1cd6:	8082                	ret

0000000000001cd8 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cd8:	85b2                	mv	a1,a2
    1cda:	863a                	mv	a2,a4
    if (stack)
    1cdc:	c191                	beqz	a1,1ce0 <clone+0x8>
	stack += stack_size;
    1cde:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1ce0:	4781                	li	a5,0
    1ce2:	4701                	li	a4,0
    1ce4:	4681                	li	a3,0
    1ce6:	2601                	sext.w	a2,a2
    1ce8:	a2ed                	j	1ed2 <__clone>

0000000000001cea <exit>:
    register long a7 __asm__("a7") = n;
    1cea:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cee:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cf2:	8082                	ret

0000000000001cf4 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cf4:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cf8:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cfa:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cfe:	2501                	sext.w	a0,a0
    1d00:	8082                	ret

0000000000001d02 <exec>:
    register long a7 __asm__("a7") = n;
    1d02:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d06:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d0a:	2501                	sext.w	a0,a0
    1d0c:	8082                	ret

0000000000001d0e <execve>:
    register long a7 __asm__("a7") = n;
    1d0e:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d12:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d16:	2501                	sext.w	a0,a0
    1d18:	8082                	ret

0000000000001d1a <times>:
    register long a7 __asm__("a7") = n;
    1d1a:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d1e:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d22:	2501                	sext.w	a0,a0
    1d24:	8082                	ret

0000000000001d26 <get_time>:

int64 get_time()
{
    1d26:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d28:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d2c:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d2e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d30:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d34:	2501                	sext.w	a0,a0
    1d36:	ed09                	bnez	a0,1d50 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d38:	67a2                	ld	a5,8(sp)
    1d3a:	3e800713          	li	a4,1000
    1d3e:	00015503          	lhu	a0,0(sp)
    1d42:	02e7d7b3          	divu	a5,a5,a4
    1d46:	02e50533          	mul	a0,a0,a4
    1d4a:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d4c:	0141                	addi	sp,sp,16
    1d4e:	8082                	ret
        return -1;
    1d50:	557d                	li	a0,-1
    1d52:	bfed                	j	1d4c <get_time+0x26>

0000000000001d54 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d54:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d58:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d5c:	2501                	sext.w	a0,a0
    1d5e:	8082                	ret

0000000000001d60 <time>:
    register long a7 __asm__("a7") = n;
    1d60:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d64:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d68:	2501                	sext.w	a0,a0
    1d6a:	8082                	ret

0000000000001d6c <sleep>:

int sleep(unsigned long long time)
{
    1d6c:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d6e:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d70:	850a                	mv	a0,sp
    1d72:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d74:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d78:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d7a:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d7e:	e501                	bnez	a0,1d86 <sleep+0x1a>
    return 0;
    1d80:	4501                	li	a0,0
}
    1d82:	0141                	addi	sp,sp,16
    1d84:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d86:	4502                	lw	a0,0(sp)
}
    1d88:	0141                	addi	sp,sp,16
    1d8a:	8082                	ret

0000000000001d8c <set_priority>:
    register long a7 __asm__("a7") = n;
    1d8c:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d90:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d94:	2501                	sext.w	a0,a0
    1d96:	8082                	ret

0000000000001d98 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d98:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d9c:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1da0:	8082                	ret

0000000000001da2 <munmap>:
    register long a7 __asm__("a7") = n;
    1da2:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1da6:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1daa:	2501                	sext.w	a0,a0
    1dac:	8082                	ret

0000000000001dae <wait>:

int wait(int *code)
{
    1dae:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1db0:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1db4:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1db6:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1db8:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dba:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dbe:	2501                	sext.w	a0,a0
    1dc0:	8082                	ret

0000000000001dc2 <spawn>:
    register long a7 __asm__("a7") = n;
    1dc2:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dc6:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dca:	2501                	sext.w	a0,a0
    1dcc:	8082                	ret

0000000000001dce <mailread>:
    register long a7 __asm__("a7") = n;
    1dce:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd2:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dd6:	2501                	sext.w	a0,a0
    1dd8:	8082                	ret

0000000000001dda <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dda:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dde:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1de2:	2501                	sext.w	a0,a0
    1de4:	8082                	ret

0000000000001de6 <fstat>:
    register long a7 __asm__("a7") = n;
    1de6:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dea:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dee:	2501                	sext.w	a0,a0
    1df0:	8082                	ret

0000000000001df2 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1df2:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1df4:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1df8:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dfa:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1dfe:	2501                	sext.w	a0,a0
    1e00:	8082                	ret

0000000000001e02 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e02:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e04:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e08:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e0a:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e0e:	2501                	sext.w	a0,a0
    1e10:	8082                	ret

0000000000001e12 <link>:

int link(char *old_path, char *new_path)
{
    1e12:	87aa                	mv	a5,a0
    1e14:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e16:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e1a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e1e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e20:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e24:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e26:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e2a:	2501                	sext.w	a0,a0
    1e2c:	8082                	ret

0000000000001e2e <unlink>:

int unlink(char *path)
{
    1e2e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e30:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e34:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e38:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e3a:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e3e:	2501                	sext.w	a0,a0
    1e40:	8082                	ret

0000000000001e42 <uname>:
    register long a7 __asm__("a7") = n;
    1e42:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e46:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e4a:	2501                	sext.w	a0,a0
    1e4c:	8082                	ret

0000000000001e4e <brk>:
    register long a7 __asm__("a7") = n;
    1e4e:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e52:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e56:	2501                	sext.w	a0,a0
    1e58:	8082                	ret

0000000000001e5a <getcwd>:
    register long a7 __asm__("a7") = n;
    1e5a:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e5c:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e60:	8082                	ret

0000000000001e62 <chdir>:
    register long a7 __asm__("a7") = n;
    1e62:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e66:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e6a:	2501                	sext.w	a0,a0
    1e6c:	8082                	ret

0000000000001e6e <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e6e:	862e                	mv	a2,a1
    1e70:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e72:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e74:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e78:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e7c:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e7e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e80:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e84:	2501                	sext.w	a0,a0
    1e86:	8082                	ret

0000000000001e88 <getdents>:
    register long a7 __asm__("a7") = n;
    1e88:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e8c:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e90:	2501                	sext.w	a0,a0
    1e92:	8082                	ret

0000000000001e94 <pipe>:
    register long a7 __asm__("a7") = n;
    1e94:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e98:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e9a:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e9e:	2501                	sext.w	a0,a0
    1ea0:	8082                	ret

0000000000001ea2 <dup>:
    register long a7 __asm__("a7") = n;
    1ea2:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1ea4:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1ea8:	2501                	sext.w	a0,a0
    1eaa:	8082                	ret

0000000000001eac <dup2>:
    register long a7 __asm__("a7") = n;
    1eac:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1eae:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eb0:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1eb4:	2501                	sext.w	a0,a0
    1eb6:	8082                	ret

0000000000001eb8 <mount>:
    register long a7 __asm__("a7") = n;
    1eb8:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ebc:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ec0:	2501                	sext.w	a0,a0
    1ec2:	8082                	ret

0000000000001ec4 <umount>:
    register long a7 __asm__("a7") = n;
    1ec4:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ec8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eca:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ece:	2501                	sext.w	a0,a0
    1ed0:	8082                	ret

0000000000001ed2 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ed2:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ed4:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ed6:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ed8:	8532                	mv	a0,a2
	mv a2, a4
    1eda:	863a                	mv	a2,a4
	mv a3, a5
    1edc:	86be                	mv	a3,a5
	mv a4, a6
    1ede:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ee0:	0dc00893          	li	a7,220
	ecall
    1ee4:	00000073          	ecall

	beqz a0, 1f
    1ee8:	c111                	beqz	a0,1eec <__clone+0x1a>
	# Parent
	ret
    1eea:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1eec:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1eee:	6522                	ld	a0,8(sp)
	jalr a1
    1ef0:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ef2:	05d00893          	li	a7,93
	ecall
    1ef6:	00000073          	ecall
