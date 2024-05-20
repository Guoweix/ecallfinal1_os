
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/openat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a0e9                	j	10cc <__start_main>

0000000000001004 <test_openat>:
#include "unistd.h"
#include "stdio.h"
#include "stdlib.h"

void test_openat(void) {
    1004:	1141                	addi	sp,sp,-16
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f0a50513          	addi	a0,a0,-246 # 1f10 <__clone+0x2c>
void test_openat(void) {
    100e:	e406                	sd	ra,8(sp)
    1010:	e022                	sd	s0,0(sp)
    TEST_START(__func__);
    1012:	32c000ef          	jal	133e <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	fca50513          	addi	a0,a0,-54 # 1fe0 <__func__.0>
    101e:	320000ef          	jal	133e <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	f0650513          	addi	a0,a0,-250 # 1f28 <__clone+0x44>
    102a:	314000ef          	jal	133e <puts>
    //int fd_dir = open(".", O_RDONLY | O_CREATE);
    int fd_dir = open("./mnt", O_DIRECTORY);
    102e:	002005b7          	lui	a1,0x200
    1032:	00001517          	auipc	a0,0x1
    1036:	f0650513          	addi	a0,a0,-250 # 1f38 <__clone+0x54>
    103a:	435000ef          	jal	1c6e <open>
    103e:	842a                	mv	s0,a0
    printf("open dir fd: %d\n", fd_dir);
    1040:	85aa                	mv	a1,a0
    1042:	00001517          	auipc	a0,0x1
    1046:	efe50513          	addi	a0,a0,-258 # 1f40 <__clone+0x5c>
    104a:	316000ef          	jal	1360 <printf>
    int fd = openat(fd_dir, "test_openat.txt", O_CREATE | O_RDWR);
    104e:	00001597          	auipc	a1,0x1
    1052:	f0a58593          	addi	a1,a1,-246 # 1f58 <__clone+0x74>
    1056:	8522                	mv	a0,s0
    1058:	04200613          	li	a2,66
    105c:	42b000ef          	jal	1c86 <openat>
    1060:	842a                	mv	s0,a0
    printf("openat fd: %d\n", fd);
    1062:	85aa                	mv	a1,a0
    1064:	00001517          	auipc	a0,0x1
    1068:	f0450513          	addi	a0,a0,-252 # 1f68 <__clone+0x84>
    106c:	2f4000ef          	jal	1360 <printf>
    assert(fd > 0);
    1070:	02805f63          	blez	s0,10ae <test_openat+0xaa>
    printf("openat success.\n");
    1074:	00001517          	auipc	a0,0x1
    1078:	f2450513          	addi	a0,a0,-220 # 1f98 <__clone+0xb4>
    107c:	2e4000ef          	jal	1360 <printf>
    write(fd, buf, strlen(buf));
    int size = read(fd, buf, 256);
    if (size > 0) printf("  openat success.\n");
    else printf("  openat error.\n");
    */
    close(fd);	
    1080:	8522                	mv	a0,s0
    1082:	415000ef          	jal	1c96 <close>
	
    TEST_END(__func__);
    1086:	00001517          	auipc	a0,0x1
    108a:	f2a50513          	addi	a0,a0,-214 # 1fb0 <__clone+0xcc>
    108e:	2b0000ef          	jal	133e <puts>
    1092:	00001517          	auipc	a0,0x1
    1096:	f4e50513          	addi	a0,a0,-178 # 1fe0 <__func__.0>
    109a:	2a4000ef          	jal	133e <puts>
}
    109e:	6402                	ld	s0,0(sp)
    10a0:	60a2                	ld	ra,8(sp)
    TEST_END(__func__);
    10a2:	00001517          	auipc	a0,0x1
    10a6:	e8650513          	addi	a0,a0,-378 # 1f28 <__clone+0x44>
}
    10aa:	0141                	addi	sp,sp,16
    TEST_END(__func__);
    10ac:	ac49                	j	133e <puts>
    assert(fd > 0);
    10ae:	00001517          	auipc	a0,0x1
    10b2:	eca50513          	addi	a0,a0,-310 # 1f78 <__clone+0x94>
    10b6:	534000ef          	jal	15ea <panic>
    10ba:	bf6d                	j	1074 <test_openat+0x70>

00000000000010bc <main>:

int main(void) {
    10bc:	1141                	addi	sp,sp,-16
    10be:	e406                	sd	ra,8(sp)
    test_openat();
    10c0:	f45ff0ef          	jal	1004 <test_openat>
    return 0;
}
    10c4:	60a2                	ld	ra,8(sp)
    10c6:	4501                	li	a0,0
    10c8:	0141                	addi	sp,sp,16
    10ca:	8082                	ret

00000000000010cc <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10cc:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10ce:	4108                	lw	a0,0(a0)
{
    10d0:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10d2:	05a1                	addi	a1,a1,8
{
    10d4:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10d6:	fe7ff0ef          	jal	10bc <main>
    10da:	423000ef          	jal	1cfc <exit>
	return 0;
}
    10de:	60a2                	ld	ra,8(sp)
    10e0:	4501                	li	a0,0
    10e2:	0141                	addi	sp,sp,16
    10e4:	8082                	ret

00000000000010e6 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10e6:	7179                	addi	sp,sp,-48
    10e8:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10ea:	12054b63          	bltz	a0,1220 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10ee:	02b577bb          	remuw	a5,a0,a1
    10f2:	00001617          	auipc	a2,0x1
    10f6:	efe60613          	addi	a2,a2,-258 # 1ff0 <digits>
    buf[16] = 0;
    10fa:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10fe:	0005871b          	sext.w	a4,a1
    1102:	1782                	slli	a5,a5,0x20
    1104:	9381                	srli	a5,a5,0x20
    1106:	97b2                	add	a5,a5,a2
    1108:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    110c:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1110:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1114:	1cb56363          	bltu	a0,a1,12da <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    1118:	45b9                	li	a1,14
    111a:	02e877bb          	remuw	a5,a6,a4
    111e:	1782                	slli	a5,a5,0x20
    1120:	9381                	srli	a5,a5,0x20
    1122:	97b2                	add	a5,a5,a2
    1124:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1128:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    112c:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1130:	0ce86e63          	bltu	a6,a4,120c <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1134:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1138:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    113c:	1582                	slli	a1,a1,0x20
    113e:	9181                	srli	a1,a1,0x20
    1140:	95b2                	add	a1,a1,a2
    1142:	0005c583          	lbu	a1,0(a1)
    1146:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    114a:	0007859b          	sext.w	a1,a5
    114e:	12e6ec63          	bltu	a3,a4,1286 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1152:	02e7f6bb          	remuw	a3,a5,a4
    1156:	1682                	slli	a3,a3,0x20
    1158:	9281                	srli	a3,a3,0x20
    115a:	96b2                	add	a3,a3,a2
    115c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1160:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1164:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1168:	12e5e863          	bltu	a1,a4,1298 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    116c:	02e876bb          	remuw	a3,a6,a4
    1170:	1682                	slli	a3,a3,0x20
    1172:	9281                	srli	a3,a3,0x20
    1174:	96b2                	add	a3,a3,a2
    1176:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    117a:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    117e:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1182:	12e86463          	bltu	a6,a4,12aa <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1186:	02e5f6bb          	remuw	a3,a1,a4
    118a:	1682                	slli	a3,a3,0x20
    118c:	9281                	srli	a3,a3,0x20
    118e:	96b2                	add	a3,a3,a2
    1190:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1194:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1198:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    119c:	0ce5ec63          	bltu	a1,a4,1274 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    11a0:	02e876bb          	remuw	a3,a6,a4
    11a4:	1682                	slli	a3,a3,0x20
    11a6:	9281                	srli	a3,a3,0x20
    11a8:	96b2                	add	a3,a3,a2
    11aa:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11ae:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11b2:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11b6:	10e86963          	bltu	a6,a4,12c8 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11ba:	02e5f6bb          	remuw	a3,a1,a4
    11be:	1682                	slli	a3,a3,0x20
    11c0:	9281                	srli	a3,a3,0x20
    11c2:	96b2                	add	a3,a3,a2
    11c4:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11c8:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11cc:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11d0:	10e5e763          	bltu	a1,a4,12de <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11d4:	02e876bb          	remuw	a3,a6,a4
    11d8:	1682                	slli	a3,a3,0x20
    11da:	9281                	srli	a3,a3,0x20
    11dc:	96b2                	add	a3,a3,a2
    11de:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11e2:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11e6:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11ea:	10e86363          	bltu	a6,a4,12f0 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11ee:	1782                	slli	a5,a5,0x20
    11f0:	9381                	srli	a5,a5,0x20
    11f2:	97b2                	add	a5,a5,a2
    11f4:	0007c783          	lbu	a5,0(a5)
    11f8:	4599                	li	a1,6
    11fa:	00f10723          	sb	a5,14(sp)

    if (sign)
    11fe:	00055763          	bgez	a0,120c <printint.constprop.0+0x126>
        buf[i--] = '-';
    1202:	02d00793          	li	a5,45
    1206:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    120a:	4595                	li	a1,5
    write(f, s, l);
    120c:	003c                	addi	a5,sp,8
    120e:	4641                	li	a2,16
    1210:	9e0d                	subw	a2,a2,a1
    1212:	4505                	li	a0,1
    1214:	95be                	add	a1,a1,a5
    1216:	297000ef          	jal	1cac <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    121a:	70a2                	ld	ra,40(sp)
    121c:	6145                	addi	sp,sp,48
    121e:	8082                	ret
        x = -xx;
    1220:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1224:	02b877bb          	remuw	a5,a6,a1
    1228:	00001617          	auipc	a2,0x1
    122c:	dc860613          	addi	a2,a2,-568 # 1ff0 <digits>
    buf[16] = 0;
    1230:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1234:	0005871b          	sext.w	a4,a1
    1238:	1782                	slli	a5,a5,0x20
    123a:	9381                	srli	a5,a5,0x20
    123c:	97b2                	add	a5,a5,a2
    123e:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1242:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1246:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    124a:	06b86963          	bltu	a6,a1,12bc <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    124e:	02e8f7bb          	remuw	a5,a7,a4
    1252:	1782                	slli	a5,a5,0x20
    1254:	9381                	srli	a5,a5,0x20
    1256:	97b2                	add	a5,a5,a2
    1258:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    125c:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1260:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1264:	ece8f8e3          	bgeu	a7,a4,1134 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1268:	02d00793          	li	a5,45
    126c:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1270:	45b5                	li	a1,13
    1272:	bf69                	j	120c <printint.constprop.0+0x126>
    1274:	45a9                	li	a1,10
    if (sign)
    1276:	f8055be3          	bgez	a0,120c <printint.constprop.0+0x126>
        buf[i--] = '-';
    127a:	02d00793          	li	a5,45
    127e:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1282:	45a5                	li	a1,9
    1284:	b761                	j	120c <printint.constprop.0+0x126>
    1286:	45b5                	li	a1,13
    if (sign)
    1288:	f80552e3          	bgez	a0,120c <printint.constprop.0+0x126>
        buf[i--] = '-';
    128c:	02d00793          	li	a5,45
    1290:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1294:	45b1                	li	a1,12
    1296:	bf9d                	j	120c <printint.constprop.0+0x126>
    1298:	45b1                	li	a1,12
    if (sign)
    129a:	f60559e3          	bgez	a0,120c <printint.constprop.0+0x126>
        buf[i--] = '-';
    129e:	02d00793          	li	a5,45
    12a2:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12a6:	45ad                	li	a1,11
    12a8:	b795                	j	120c <printint.constprop.0+0x126>
    12aa:	45ad                	li	a1,11
    if (sign)
    12ac:	f60550e3          	bgez	a0,120c <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b0:	02d00793          	li	a5,45
    12b4:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12b8:	45a9                	li	a1,10
    12ba:	bf89                	j	120c <printint.constprop.0+0x126>
        buf[i--] = '-';
    12bc:	02d00793          	li	a5,45
    12c0:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12c4:	45b9                	li	a1,14
    12c6:	b799                	j	120c <printint.constprop.0+0x126>
    12c8:	45a5                	li	a1,9
    if (sign)
    12ca:	f40551e3          	bgez	a0,120c <printint.constprop.0+0x126>
        buf[i--] = '-';
    12ce:	02d00793          	li	a5,45
    12d2:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12d6:	45a1                	li	a1,8
    12d8:	bf15                	j	120c <printint.constprop.0+0x126>
    i = 15;
    12da:	45bd                	li	a1,15
    12dc:	bf05                	j	120c <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12de:	45a1                	li	a1,8
    if (sign)
    12e0:	f20556e3          	bgez	a0,120c <printint.constprop.0+0x126>
        buf[i--] = '-';
    12e4:	02d00793          	li	a5,45
    12e8:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12ec:	459d                	li	a1,7
    12ee:	bf39                	j	120c <printint.constprop.0+0x126>
    12f0:	459d                	li	a1,7
    if (sign)
    12f2:	f0055de3          	bgez	a0,120c <printint.constprop.0+0x126>
        buf[i--] = '-';
    12f6:	02d00793          	li	a5,45
    12fa:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12fe:	4599                	li	a1,6
    1300:	b731                	j	120c <printint.constprop.0+0x126>

0000000000001302 <getchar>:
{
    1302:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1304:	00f10593          	addi	a1,sp,15
    1308:	4605                	li	a2,1
    130a:	4501                	li	a0,0
{
    130c:	ec06                	sd	ra,24(sp)
    char byte = 0;
    130e:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1312:	191000ef          	jal	1ca2 <read>
}
    1316:	60e2                	ld	ra,24(sp)
    1318:	00f14503          	lbu	a0,15(sp)
    131c:	6105                	addi	sp,sp,32
    131e:	8082                	ret

0000000000001320 <putchar>:
{
    1320:	1101                	addi	sp,sp,-32
    1322:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1324:	00f10593          	addi	a1,sp,15
    1328:	4605                	li	a2,1
    132a:	4505                	li	a0,1
{
    132c:	ec06                	sd	ra,24(sp)
    char byte = c;
    132e:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1332:	17b000ef          	jal	1cac <write>
}
    1336:	60e2                	ld	ra,24(sp)
    1338:	2501                	sext.w	a0,a0
    133a:	6105                	addi	sp,sp,32
    133c:	8082                	ret

000000000000133e <puts>:
{
    133e:	1141                	addi	sp,sp,-16
    1340:	e406                	sd	ra,8(sp)
    1342:	e022                	sd	s0,0(sp)
    1344:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1346:	582000ef          	jal	18c8 <strlen>
    134a:	862a                	mv	a2,a0
    134c:	85a2                	mv	a1,s0
    134e:	4505                	li	a0,1
    1350:	15d000ef          	jal	1cac <write>
}
    1354:	60a2                	ld	ra,8(sp)
    1356:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1358:	957d                	srai	a0,a0,0x3f
    return r;
    135a:	2501                	sext.w	a0,a0
}
    135c:	0141                	addi	sp,sp,16
    135e:	8082                	ret

0000000000001360 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1360:	7131                	addi	sp,sp,-192
    1362:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1364:	013c                	addi	a5,sp,136
{
    1366:	f0ca                	sd	s2,96(sp)
    1368:	ecce                	sd	s3,88(sp)
    136a:	e8d2                	sd	s4,80(sp)
    136c:	e4d6                	sd	s5,72(sp)
    136e:	e0da                	sd	s6,64(sp)
    1370:	fc5e                	sd	s7,56(sp)
    1372:	fc86                	sd	ra,120(sp)
    1374:	f8a2                	sd	s0,112(sp)
    1376:	f4a6                	sd	s1,104(sp)
    1378:	e52e                	sd	a1,136(sp)
    137a:	e932                	sd	a2,144(sp)
    137c:	ed36                	sd	a3,152(sp)
    137e:	f13a                	sd	a4,160(sp)
    1380:	f942                	sd	a6,176(sp)
    1382:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1384:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1386:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    138a:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    138e:	00001b97          	auipc	s7,0x1
    1392:	c32b8b93          	addi	s7,s7,-974 # 1fc0 <__clone+0xdc>
        switch (s[1])
    1396:	07800a93          	li	s5,120
    139a:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    139e:	00001997          	auipc	s3,0x1
    13a2:	c5298993          	addi	s3,s3,-942 # 1ff0 <digits>
        if (!*s)
    13a6:	00054783          	lbu	a5,0(a0)
    13aa:	16078c63          	beqz	a5,1522 <printf+0x1c2>
    13ae:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13b0:	19278463          	beq	a5,s2,1538 <printf+0x1d8>
    13b4:	00164783          	lbu	a5,1(a2)
    13b8:	0605                	addi	a2,a2,1
    13ba:	fbfd                	bnez	a5,13b0 <printf+0x50>
    13bc:	84b2                	mv	s1,a2
        l = z - a;
    13be:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13c2:	85aa                	mv	a1,a0
    13c4:	8622                	mv	a2,s0
    13c6:	4505                	li	a0,1
    13c8:	0e5000ef          	jal	1cac <write>
        if (l)
    13cc:	18041f63          	bnez	s0,156a <printf+0x20a>
        if (s[1] == 0)
    13d0:	0014c783          	lbu	a5,1(s1)
    13d4:	14078763          	beqz	a5,1522 <printf+0x1c2>
        switch (s[1])
    13d8:	1d478163          	beq	a5,s4,159a <printf+0x23a>
    13dc:	18fa6963          	bltu	s4,a5,156e <printf+0x20e>
    13e0:	1b678363          	beq	a5,s6,1586 <printf+0x226>
    13e4:	07000713          	li	a4,112
    13e8:	1ce79c63          	bne	a5,a4,15c0 <printf+0x260>
            printptr(va_arg(ap, uint64));
    13ec:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13ee:	03000793          	li	a5,48
    13f2:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13f6:	631c                	ld	a5,0(a4)
    13f8:	0721                	addi	a4,a4,8
    13fa:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13fc:	00479f93          	slli	t6,a5,0x4
    1400:	00879f13          	slli	t5,a5,0x8
    1404:	00c79e93          	slli	t4,a5,0xc
    1408:	01079e13          	slli	t3,a5,0x10
    140c:	01479313          	slli	t1,a5,0x14
    1410:	01879893          	slli	a7,a5,0x18
    1414:	01c79713          	slli	a4,a5,0x1c
    1418:	02479813          	slli	a6,a5,0x24
    141c:	02879513          	slli	a0,a5,0x28
    1420:	02c79593          	slli	a1,a5,0x2c
    1424:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1428:	03c7d293          	srli	t0,a5,0x3c
    142c:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1430:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1434:	03cfdf93          	srli	t6,t6,0x3c
    1438:	03cf5f13          	srli	t5,t5,0x3c
    143c:	03cede93          	srli	t4,t4,0x3c
    1440:	03ce5e13          	srli	t3,t3,0x3c
    1444:	03c35313          	srli	t1,t1,0x3c
    1448:	03c8d893          	srli	a7,a7,0x3c
    144c:	9371                	srli	a4,a4,0x3c
    144e:	03c85813          	srli	a6,a6,0x3c
    1452:	9171                	srli	a0,a0,0x3c
    1454:	91f1                	srli	a1,a1,0x3c
    1456:	9271                	srli	a2,a2,0x3c
    1458:	974e                	add	a4,a4,s3
    145a:	92f1                	srli	a3,a3,0x3c
    145c:	92ce                	add	t0,t0,s3
    145e:	9fce                	add	t6,t6,s3
    1460:	9f4e                	add	t5,t5,s3
    1462:	9ece                	add	t4,t4,s3
    1464:	9e4e                	add	t3,t3,s3
    1466:	934e                	add	t1,t1,s3
    1468:	98ce                	add	a7,a7,s3
    146a:	93ce                	add	t2,t2,s3
    146c:	984e                	add	a6,a6,s3
    146e:	954e                	add	a0,a0,s3
    1470:	95ce                	add	a1,a1,s3
    1472:	964e                	add	a2,a2,s3
    1474:	0002c283          	lbu	t0,0(t0)
    1478:	000fcf83          	lbu	t6,0(t6)
    147c:	000f4f03          	lbu	t5,0(t5)
    1480:	000ece83          	lbu	t4,0(t4)
    1484:	000e4e03          	lbu	t3,0(t3)
    1488:	00034303          	lbu	t1,0(t1)
    148c:	0008c883          	lbu	a7,0(a7)
    1490:	00074403          	lbu	s0,0(a4)
    1494:	0003c383          	lbu	t2,0(t2)
    1498:	00084803          	lbu	a6,0(a6)
    149c:	00054503          	lbu	a0,0(a0)
    14a0:	0005c583          	lbu	a1,0(a1)
    14a4:	00064603          	lbu	a2,0(a2)
    14a8:	00d98733          	add	a4,s3,a3
    14ac:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14b0:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14b4:	9371                	srli	a4,a4,0x3c
    14b6:	8bbd                	andi	a5,a5,15
    14b8:	00510523          	sb	t0,10(sp)
    14bc:	01f105a3          	sb	t6,11(sp)
    14c0:	01e10623          	sb	t5,12(sp)
    14c4:	01d106a3          	sb	t4,13(sp)
    14c8:	01c10723          	sb	t3,14(sp)
    14cc:	006107a3          	sb	t1,15(sp)
    14d0:	01110823          	sb	a7,16(sp)
    14d4:	00710923          	sb	t2,18(sp)
    14d8:	010109a3          	sb	a6,19(sp)
    14dc:	00a10a23          	sb	a0,20(sp)
    14e0:	00b10aa3          	sb	a1,21(sp)
    14e4:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14e8:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ec:	008108a3          	sb	s0,17(sp)
    14f0:	974e                	add	a4,a4,s3
    14f2:	97ce                	add	a5,a5,s3
    14f4:	00d10ba3          	sb	a3,23(sp)
    14f8:	00074703          	lbu	a4,0(a4)
    14fc:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1500:	4649                	li	a2,18
    1502:	002c                	addi	a1,sp,8
    1504:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1506:	00e10c23          	sb	a4,24(sp)
    150a:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    150e:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1512:	79a000ef          	jal	1cac <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    1516:	00248513          	addi	a0,s1,2
        if (!*s)
    151a:	00054783          	lbu	a5,0(a0)
    151e:	e80798e3          	bnez	a5,13ae <printf+0x4e>
    }
    va_end(ap);
}
    1522:	70e6                	ld	ra,120(sp)
    1524:	7446                	ld	s0,112(sp)
    1526:	74a6                	ld	s1,104(sp)
    1528:	7906                	ld	s2,96(sp)
    152a:	69e6                	ld	s3,88(sp)
    152c:	6a46                	ld	s4,80(sp)
    152e:	6aa6                	ld	s5,72(sp)
    1530:	6b06                	ld	s6,64(sp)
    1532:	7be2                	ld	s7,56(sp)
    1534:	6129                	addi	sp,sp,192
    1536:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1538:	00064783          	lbu	a5,0(a2)
    153c:	84b2                	mv	s1,a2
    153e:	01278963          	beq	a5,s2,1550 <printf+0x1f0>
    1542:	bdb5                	j	13be <printf+0x5e>
    1544:	0024c783          	lbu	a5,2(s1)
    1548:	0605                	addi	a2,a2,1
    154a:	0489                	addi	s1,s1,2
    154c:	e72799e3          	bne	a5,s2,13be <printf+0x5e>
    1550:	0014c783          	lbu	a5,1(s1)
    1554:	ff2788e3          	beq	a5,s2,1544 <printf+0x1e4>
        l = z - a;
    1558:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    155c:	85aa                	mv	a1,a0
    155e:	8622                	mv	a2,s0
    1560:	4505                	li	a0,1
    1562:	74a000ef          	jal	1cac <write>
        if (l)
    1566:	e60405e3          	beqz	s0,13d0 <printf+0x70>
    156a:	8526                	mv	a0,s1
    156c:	bd2d                	j	13a6 <printf+0x46>
        switch (s[1])
    156e:	05579963          	bne	a5,s5,15c0 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1572:	6782                	ld	a5,0(sp)
    1574:	45c1                	li	a1,16
    1576:	4388                	lw	a0,0(a5)
    1578:	07a1                	addi	a5,a5,8
    157a:	e03e                	sd	a5,0(sp)
    157c:	b6bff0ef          	jal	10e6 <printint.constprop.0>
        s += 2;
    1580:	00248513          	addi	a0,s1,2
    1584:	bf59                	j	151a <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1586:	6782                	ld	a5,0(sp)
    1588:	45a9                	li	a1,10
    158a:	4388                	lw	a0,0(a5)
    158c:	07a1                	addi	a5,a5,8
    158e:	e03e                	sd	a5,0(sp)
    1590:	b57ff0ef          	jal	10e6 <printint.constprop.0>
        s += 2;
    1594:	00248513          	addi	a0,s1,2
    1598:	b749                	j	151a <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    159a:	6782                	ld	a5,0(sp)
    159c:	6380                	ld	s0,0(a5)
    159e:	07a1                	addi	a5,a5,8
    15a0:	e03e                	sd	a5,0(sp)
    15a2:	c031                	beqz	s0,15e6 <printf+0x286>
            l = strnlen(a, 200);
    15a4:	0c800593          	li	a1,200
    15a8:	8522                	mv	a0,s0
    15aa:	40a000ef          	jal	19b4 <strnlen>
    write(f, s, l);
    15ae:	0005061b          	sext.w	a2,a0
    15b2:	85a2                	mv	a1,s0
    15b4:	4505                	li	a0,1
    15b6:	6f6000ef          	jal	1cac <write>
        s += 2;
    15ba:	00248513          	addi	a0,s1,2
    15be:	bfb1                	j	151a <printf+0x1ba>
    return write(stdout, &byte, 1);
    15c0:	4605                	li	a2,1
    15c2:	002c                	addi	a1,sp,8
    15c4:	4505                	li	a0,1
    char byte = c;
    15c6:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15ca:	6e2000ef          	jal	1cac <write>
    char byte = c;
    15ce:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15d2:	4605                	li	a2,1
    15d4:	002c                	addi	a1,sp,8
    15d6:	4505                	li	a0,1
    char byte = c;
    15d8:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15dc:	6d0000ef          	jal	1cac <write>
        s += 2;
    15e0:	00248513          	addi	a0,s1,2
    15e4:	bf1d                	j	151a <printf+0x1ba>
                a = "(null)";
    15e6:	845e                	mv	s0,s7
    15e8:	bf75                	j	15a4 <printf+0x244>

00000000000015ea <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15ea:	1141                	addi	sp,sp,-16
    15ec:	e406                	sd	ra,8(sp)
    puts(m);
    15ee:	d51ff0ef          	jal	133e <puts>
    exit(-100);
}
    15f2:	60a2                	ld	ra,8(sp)
    exit(-100);
    15f4:	f9c00513          	li	a0,-100
}
    15f8:	0141                	addi	sp,sp,16
    exit(-100);
    15fa:	a709                	j	1cfc <exit>

00000000000015fc <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15fc:	02000793          	li	a5,32
    1600:	00f50663          	beq	a0,a5,160c <isspace+0x10>
    1604:	355d                	addiw	a0,a0,-9
    1606:	00553513          	sltiu	a0,a0,5
    160a:	8082                	ret
    160c:	4505                	li	a0,1
}
    160e:	8082                	ret

0000000000001610 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1610:	fd05051b          	addiw	a0,a0,-48
}
    1614:	00a53513          	sltiu	a0,a0,10
    1618:	8082                	ret

000000000000161a <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    161a:	02000613          	li	a2,32
    161e:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1620:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1624:	ff77069b          	addiw	a3,a4,-9
    1628:	04c70d63          	beq	a4,a2,1682 <atoi+0x68>
    162c:	0007079b          	sext.w	a5,a4
    1630:	04d5f963          	bgeu	a1,a3,1682 <atoi+0x68>
        s++;
    switch (*s)
    1634:	02b00693          	li	a3,43
    1638:	04d70a63          	beq	a4,a3,168c <atoi+0x72>
    163c:	02d00693          	li	a3,45
    1640:	06d70463          	beq	a4,a3,16a8 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1644:	fd07859b          	addiw	a1,a5,-48
    1648:	4625                	li	a2,9
    164a:	873e                	mv	a4,a5
    164c:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    164e:	4e01                	li	t3,0
    while (isdigit(*s))
    1650:	04b66a63          	bltu	a2,a1,16a4 <atoi+0x8a>
    int n = 0, neg = 0;
    1654:	4501                	li	a0,0
    while (isdigit(*s))
    1656:	4825                	li	a6,9
    1658:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    165c:	0025179b          	slliw	a5,a0,0x2
    1660:	9d3d                	addw	a0,a0,a5
    1662:	fd07031b          	addiw	t1,a4,-48
    1666:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    166a:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    166e:	0685                	addi	a3,a3,1
    1670:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1674:	0006071b          	sext.w	a4,a2
    1678:	feb870e3          	bgeu	a6,a1,1658 <atoi+0x3e>
    return neg ? n : -n;
    167c:	000e0563          	beqz	t3,1686 <atoi+0x6c>
}
    1680:	8082                	ret
        s++;
    1682:	0505                	addi	a0,a0,1
    1684:	bf71                	j	1620 <atoi+0x6>
    return neg ? n : -n;
    1686:	4113053b          	subw	a0,t1,a7
    168a:	8082                	ret
    while (isdigit(*s))
    168c:	00154783          	lbu	a5,1(a0)
    1690:	4625                	li	a2,9
        s++;
    1692:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1696:	fd07859b          	addiw	a1,a5,-48
    169a:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    169e:	4e01                	li	t3,0
    while (isdigit(*s))
    16a0:	fab67ae3          	bgeu	a2,a1,1654 <atoi+0x3a>
    16a4:	4501                	li	a0,0
}
    16a6:	8082                	ret
    while (isdigit(*s))
    16a8:	00154783          	lbu	a5,1(a0)
    16ac:	4625                	li	a2,9
        s++;
    16ae:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16b2:	fd07859b          	addiw	a1,a5,-48
    16b6:	0007871b          	sext.w	a4,a5
    16ba:	feb665e3          	bltu	a2,a1,16a4 <atoi+0x8a>
        neg = 1;
    16be:	4e05                	li	t3,1
    16c0:	bf51                	j	1654 <atoi+0x3a>

00000000000016c2 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16c2:	16060d63          	beqz	a2,183c <memset+0x17a>
    16c6:	40a007b3          	neg	a5,a0
    16ca:	8b9d                	andi	a5,a5,7
    16cc:	00778713          	addi	a4,a5,7
    16d0:	482d                	li	a6,11
    16d2:	0ff5f593          	zext.b	a1,a1
    16d6:	fff60693          	addi	a3,a2,-1
    16da:	17076263          	bltu	a4,a6,183e <memset+0x17c>
    16de:	16e6ea63          	bltu	a3,a4,1852 <memset+0x190>
    16e2:	16078563          	beqz	a5,184c <memset+0x18a>
    16e6:	00b50023          	sb	a1,0(a0)
    16ea:	4705                	li	a4,1
    16ec:	00150e93          	addi	t4,a0,1
    16f0:	14e78c63          	beq	a5,a4,1848 <memset+0x186>
    16f4:	00b500a3          	sb	a1,1(a0)
    16f8:	4709                	li	a4,2
    16fa:	00250e93          	addi	t4,a0,2
    16fe:	14e78d63          	beq	a5,a4,1858 <memset+0x196>
    1702:	00b50123          	sb	a1,2(a0)
    1706:	470d                	li	a4,3
    1708:	00350e93          	addi	t4,a0,3
    170c:	12e78b63          	beq	a5,a4,1842 <memset+0x180>
    1710:	00b501a3          	sb	a1,3(a0)
    1714:	4711                	li	a4,4
    1716:	00450e93          	addi	t4,a0,4
    171a:	14e78163          	beq	a5,a4,185c <memset+0x19a>
    171e:	00b50223          	sb	a1,4(a0)
    1722:	4715                	li	a4,5
    1724:	00550e93          	addi	t4,a0,5
    1728:	12e78c63          	beq	a5,a4,1860 <memset+0x19e>
    172c:	00b502a3          	sb	a1,5(a0)
    1730:	471d                	li	a4,7
    1732:	00650e93          	addi	t4,a0,6
    1736:	12e79763          	bne	a5,a4,1864 <memset+0x1a2>
    173a:	00750e93          	addi	t4,a0,7
    173e:	00b50323          	sb	a1,6(a0)
    1742:	4f1d                	li	t5,7
    1744:	00859713          	slli	a4,a1,0x8
    1748:	8f4d                	or	a4,a4,a1
    174a:	01059e13          	slli	t3,a1,0x10
    174e:	01c76e33          	or	t3,a4,t3
    1752:	01859313          	slli	t1,a1,0x18
    1756:	006e6333          	or	t1,t3,t1
    175a:	02059893          	slli	a7,a1,0x20
    175e:	011368b3          	or	a7,t1,a7
    1762:	02859813          	slli	a6,a1,0x28
    1766:	40f60333          	sub	t1,a2,a5
    176a:	0108e833          	or	a6,a7,a6
    176e:	03059693          	slli	a3,a1,0x30
    1772:	00d866b3          	or	a3,a6,a3
    1776:	03859713          	slli	a4,a1,0x38
    177a:	97aa                	add	a5,a5,a0
    177c:	ff837813          	andi	a6,t1,-8
    1780:	8f55                	or	a4,a4,a3
    1782:	00f806b3          	add	a3,a6,a5
    1786:	e398                	sd	a4,0(a5)
    1788:	07a1                	addi	a5,a5,8
    178a:	fed79ee3          	bne	a5,a3,1786 <memset+0xc4>
    178e:	ff837693          	andi	a3,t1,-8
    1792:	00de87b3          	add	a5,t4,a3
    1796:	01e6873b          	addw	a4,a3,t5
    179a:	0ad30663          	beq	t1,a3,1846 <memset+0x184>
    179e:	00b78023          	sb	a1,0(a5)
    17a2:	0017069b          	addiw	a3,a4,1
    17a6:	08c6fb63          	bgeu	a3,a2,183c <memset+0x17a>
    17aa:	00b780a3          	sb	a1,1(a5)
    17ae:	0027069b          	addiw	a3,a4,2
    17b2:	08c6f563          	bgeu	a3,a2,183c <memset+0x17a>
    17b6:	00b78123          	sb	a1,2(a5)
    17ba:	0037069b          	addiw	a3,a4,3
    17be:	06c6ff63          	bgeu	a3,a2,183c <memset+0x17a>
    17c2:	00b781a3          	sb	a1,3(a5)
    17c6:	0047069b          	addiw	a3,a4,4
    17ca:	06c6f963          	bgeu	a3,a2,183c <memset+0x17a>
    17ce:	00b78223          	sb	a1,4(a5)
    17d2:	0057069b          	addiw	a3,a4,5
    17d6:	06c6f363          	bgeu	a3,a2,183c <memset+0x17a>
    17da:	00b782a3          	sb	a1,5(a5)
    17de:	0067069b          	addiw	a3,a4,6
    17e2:	04c6fd63          	bgeu	a3,a2,183c <memset+0x17a>
    17e6:	00b78323          	sb	a1,6(a5)
    17ea:	0077069b          	addiw	a3,a4,7
    17ee:	04c6f763          	bgeu	a3,a2,183c <memset+0x17a>
    17f2:	00b783a3          	sb	a1,7(a5)
    17f6:	0087069b          	addiw	a3,a4,8
    17fa:	04c6f163          	bgeu	a3,a2,183c <memset+0x17a>
    17fe:	00b78423          	sb	a1,8(a5)
    1802:	0097069b          	addiw	a3,a4,9
    1806:	02c6fb63          	bgeu	a3,a2,183c <memset+0x17a>
    180a:	00b784a3          	sb	a1,9(a5)
    180e:	00a7069b          	addiw	a3,a4,10
    1812:	02c6f563          	bgeu	a3,a2,183c <memset+0x17a>
    1816:	00b78523          	sb	a1,10(a5)
    181a:	00b7069b          	addiw	a3,a4,11
    181e:	00c6ff63          	bgeu	a3,a2,183c <memset+0x17a>
    1822:	00b785a3          	sb	a1,11(a5)
    1826:	00c7069b          	addiw	a3,a4,12
    182a:	00c6f963          	bgeu	a3,a2,183c <memset+0x17a>
    182e:	00b78623          	sb	a1,12(a5)
    1832:	2735                	addiw	a4,a4,13
    1834:	00c77463          	bgeu	a4,a2,183c <memset+0x17a>
    1838:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    183c:	8082                	ret
    183e:	472d                	li	a4,11
    1840:	bd79                	j	16de <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1842:	4f0d                	li	t5,3
    1844:	b701                	j	1744 <memset+0x82>
    1846:	8082                	ret
    1848:	4f05                	li	t5,1
    184a:	bded                	j	1744 <memset+0x82>
    184c:	8eaa                	mv	t4,a0
    184e:	4f01                	li	t5,0
    1850:	bdd5                	j	1744 <memset+0x82>
    1852:	87aa                	mv	a5,a0
    1854:	4701                	li	a4,0
    1856:	b7a1                	j	179e <memset+0xdc>
    1858:	4f09                	li	t5,2
    185a:	b5ed                	j	1744 <memset+0x82>
    185c:	4f11                	li	t5,4
    185e:	b5dd                	j	1744 <memset+0x82>
    1860:	4f15                	li	t5,5
    1862:	b5cd                	j	1744 <memset+0x82>
    1864:	4f19                	li	t5,6
    1866:	bdf9                	j	1744 <memset+0x82>

0000000000001868 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1868:	00054783          	lbu	a5,0(a0)
    186c:	0005c703          	lbu	a4,0(a1)
    1870:	00e79863          	bne	a5,a4,1880 <strcmp+0x18>
    1874:	0505                	addi	a0,a0,1
    1876:	0585                	addi	a1,a1,1
    1878:	fbe5                	bnez	a5,1868 <strcmp>
    187a:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    187c:	9d19                	subw	a0,a0,a4
    187e:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1880:	0007851b          	sext.w	a0,a5
    1884:	bfe5                	j	187c <strcmp+0x14>

0000000000001886 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1886:	ce05                	beqz	a2,18be <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1888:	00054703          	lbu	a4,0(a0)
    188c:	0005c783          	lbu	a5,0(a1)
    1890:	cb0d                	beqz	a4,18c2 <strncmp+0x3c>
    if (!n--)
    1892:	167d                	addi	a2,a2,-1
    1894:	00c506b3          	add	a3,a0,a2
    1898:	a819                	j	18ae <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    189a:	00a68e63          	beq	a3,a0,18b6 <strncmp+0x30>
    189e:	0505                	addi	a0,a0,1
    18a0:	00e79b63          	bne	a5,a4,18b6 <strncmp+0x30>
    18a4:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18a8:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18ac:	cb19                	beqz	a4,18c2 <strncmp+0x3c>
    18ae:	0005c783          	lbu	a5,0(a1)
    18b2:	0585                	addi	a1,a1,1
    18b4:	f3fd                	bnez	a5,189a <strncmp+0x14>
    return *l - *r;
    18b6:	0007051b          	sext.w	a0,a4
    18ba:	9d1d                	subw	a0,a0,a5
    18bc:	8082                	ret
        return 0;
    18be:	4501                	li	a0,0
}
    18c0:	8082                	ret
    18c2:	4501                	li	a0,0
    return *l - *r;
    18c4:	9d1d                	subw	a0,a0,a5
    18c6:	8082                	ret

00000000000018c8 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18c8:	00757793          	andi	a5,a0,7
    18cc:	cf89                	beqz	a5,18e6 <strlen+0x1e>
    18ce:	87aa                	mv	a5,a0
    18d0:	a029                	j	18da <strlen+0x12>
    18d2:	0785                	addi	a5,a5,1
    18d4:	0077f713          	andi	a4,a5,7
    18d8:	cb01                	beqz	a4,18e8 <strlen+0x20>
        if (!*s)
    18da:	0007c703          	lbu	a4,0(a5)
    18de:	fb75                	bnez	a4,18d2 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18e0:	40a78533          	sub	a0,a5,a0
}
    18e4:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18e6:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18e8:	6394                	ld	a3,0(a5)
    18ea:	00000597          	auipc	a1,0x0
    18ee:	6de5b583          	ld	a1,1758(a1) # 1fc8 <__clone+0xe4>
    18f2:	00000617          	auipc	a2,0x0
    18f6:	6de63603          	ld	a2,1758(a2) # 1fd0 <__clone+0xec>
    18fa:	a019                	j	1900 <strlen+0x38>
    18fc:	6794                	ld	a3,8(a5)
    18fe:	07a1                	addi	a5,a5,8
    1900:	00b68733          	add	a4,a3,a1
    1904:	fff6c693          	not	a3,a3
    1908:	8f75                	and	a4,a4,a3
    190a:	8f71                	and	a4,a4,a2
    190c:	db65                	beqz	a4,18fc <strlen+0x34>
    for (; *s; s++)
    190e:	0007c703          	lbu	a4,0(a5)
    1912:	d779                	beqz	a4,18e0 <strlen+0x18>
    1914:	0017c703          	lbu	a4,1(a5)
    1918:	0785                	addi	a5,a5,1
    191a:	d379                	beqz	a4,18e0 <strlen+0x18>
    191c:	0017c703          	lbu	a4,1(a5)
    1920:	0785                	addi	a5,a5,1
    1922:	fb6d                	bnez	a4,1914 <strlen+0x4c>
    1924:	bf75                	j	18e0 <strlen+0x18>

0000000000001926 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1926:	00757713          	andi	a4,a0,7
{
    192a:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    192c:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1930:	cb19                	beqz	a4,1946 <memchr+0x20>
    1932:	ce25                	beqz	a2,19aa <memchr+0x84>
    1934:	0007c703          	lbu	a4,0(a5)
    1938:	04b70e63          	beq	a4,a1,1994 <memchr+0x6e>
    193c:	0785                	addi	a5,a5,1
    193e:	0077f713          	andi	a4,a5,7
    1942:	167d                	addi	a2,a2,-1
    1944:	f77d                	bnez	a4,1932 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1946:	4501                	li	a0,0
    if (n && *s != c)
    1948:	c235                	beqz	a2,19ac <memchr+0x86>
    194a:	0007c703          	lbu	a4,0(a5)
    194e:	04b70363          	beq	a4,a1,1994 <memchr+0x6e>
        size_t k = ONES * c;
    1952:	00000517          	auipc	a0,0x0
    1956:	68653503          	ld	a0,1670(a0) # 1fd8 <__clone+0xf4>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    195a:	471d                	li	a4,7
        size_t k = ONES * c;
    195c:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1960:	02c77a63          	bgeu	a4,a2,1994 <memchr+0x6e>
    1964:	00000897          	auipc	a7,0x0
    1968:	6648b883          	ld	a7,1636(a7) # 1fc8 <__clone+0xe4>
    196c:	00000817          	auipc	a6,0x0
    1970:	66483803          	ld	a6,1636(a6) # 1fd0 <__clone+0xec>
    1974:	431d                	li	t1,7
    1976:	a029                	j	1980 <memchr+0x5a>
    1978:	1661                	addi	a2,a2,-8
    197a:	07a1                	addi	a5,a5,8
    197c:	02c37963          	bgeu	t1,a2,19ae <memchr+0x88>
    1980:	6398                	ld	a4,0(a5)
    1982:	8f29                	xor	a4,a4,a0
    1984:	011706b3          	add	a3,a4,a7
    1988:	fff74713          	not	a4,a4
    198c:	8f75                	and	a4,a4,a3
    198e:	01077733          	and	a4,a4,a6
    1992:	d37d                	beqz	a4,1978 <memchr+0x52>
    1994:	853e                	mv	a0,a5
    1996:	97b2                	add	a5,a5,a2
    1998:	a021                	j	19a0 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    199a:	0505                	addi	a0,a0,1
    199c:	00f50763          	beq	a0,a5,19aa <memchr+0x84>
    19a0:	00054703          	lbu	a4,0(a0)
    19a4:	feb71be3          	bne	a4,a1,199a <memchr+0x74>
    19a8:	8082                	ret
    return n ? (void *)s : 0;
    19aa:	4501                	li	a0,0
}
    19ac:	8082                	ret
    return n ? (void *)s : 0;
    19ae:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19b0:	f275                	bnez	a2,1994 <memchr+0x6e>
}
    19b2:	8082                	ret

00000000000019b4 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19b4:	1101                	addi	sp,sp,-32
    19b6:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19b8:	862e                	mv	a2,a1
{
    19ba:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19bc:	4581                	li	a1,0
{
    19be:	e426                	sd	s1,8(sp)
    19c0:	ec06                	sd	ra,24(sp)
    19c2:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19c4:	f63ff0ef          	jal	1926 <memchr>
    return p ? p - s : n;
    19c8:	c519                	beqz	a0,19d6 <strnlen+0x22>
}
    19ca:	60e2                	ld	ra,24(sp)
    19cc:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19ce:	8d05                	sub	a0,a0,s1
}
    19d0:	64a2                	ld	s1,8(sp)
    19d2:	6105                	addi	sp,sp,32
    19d4:	8082                	ret
    19d6:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19d8:	8522                	mv	a0,s0
}
    19da:	6442                	ld	s0,16(sp)
    19dc:	64a2                	ld	s1,8(sp)
    19de:	6105                	addi	sp,sp,32
    19e0:	8082                	ret

00000000000019e2 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19e2:	00b547b3          	xor	a5,a0,a1
    19e6:	8b9d                	andi	a5,a5,7
    19e8:	eb95                	bnez	a5,1a1c <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19ea:	0075f793          	andi	a5,a1,7
    19ee:	e7b1                	bnez	a5,1a3a <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19f0:	6198                	ld	a4,0(a1)
    19f2:	00000617          	auipc	a2,0x0
    19f6:	5d663603          	ld	a2,1494(a2) # 1fc8 <__clone+0xe4>
    19fa:	00000817          	auipc	a6,0x0
    19fe:	5d683803          	ld	a6,1494(a6) # 1fd0 <__clone+0xec>
    1a02:	a029                	j	1a0c <strcpy+0x2a>
    1a04:	e118                	sd	a4,0(a0)
    1a06:	6598                	ld	a4,8(a1)
    1a08:	05a1                	addi	a1,a1,8
    1a0a:	0521                	addi	a0,a0,8
    1a0c:	00c707b3          	add	a5,a4,a2
    1a10:	fff74693          	not	a3,a4
    1a14:	8ff5                	and	a5,a5,a3
    1a16:	0107f7b3          	and	a5,a5,a6
    1a1a:	d7ed                	beqz	a5,1a04 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a1c:	0005c783          	lbu	a5,0(a1)
    1a20:	00f50023          	sb	a5,0(a0)
    1a24:	c785                	beqz	a5,1a4c <strcpy+0x6a>
    1a26:	0015c783          	lbu	a5,1(a1)
    1a2a:	0505                	addi	a0,a0,1
    1a2c:	0585                	addi	a1,a1,1
    1a2e:	00f50023          	sb	a5,0(a0)
    1a32:	fbf5                	bnez	a5,1a26 <strcpy+0x44>
        ;
    return d;
}
    1a34:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a36:	0505                	addi	a0,a0,1
    1a38:	df45                	beqz	a4,19f0 <strcpy+0xe>
            if (!(*d = *s))
    1a3a:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a3e:	0585                	addi	a1,a1,1
    1a40:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a44:	00f50023          	sb	a5,0(a0)
    1a48:	f7fd                	bnez	a5,1a36 <strcpy+0x54>
}
    1a4a:	8082                	ret
    1a4c:	8082                	ret

0000000000001a4e <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a4e:	00b547b3          	xor	a5,a0,a1
    1a52:	8b9d                	andi	a5,a5,7
    1a54:	1a079863          	bnez	a5,1c04 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a58:	0075f793          	andi	a5,a1,7
    1a5c:	16078463          	beqz	a5,1bc4 <strncpy+0x176>
    1a60:	ea01                	bnez	a2,1a70 <strncpy+0x22>
    1a62:	a421                	j	1c6a <strncpy+0x21c>
    1a64:	167d                	addi	a2,a2,-1
    1a66:	0505                	addi	a0,a0,1
    1a68:	14070e63          	beqz	a4,1bc4 <strncpy+0x176>
    1a6c:	1a060863          	beqz	a2,1c1c <strncpy+0x1ce>
    1a70:	0005c783          	lbu	a5,0(a1)
    1a74:	0585                	addi	a1,a1,1
    1a76:	0075f713          	andi	a4,a1,7
    1a7a:	00f50023          	sb	a5,0(a0)
    1a7e:	f3fd                	bnez	a5,1a64 <strncpy+0x16>
    1a80:	4805                	li	a6,1
    1a82:	1a061863          	bnez	a2,1c32 <strncpy+0x1e4>
    1a86:	40a007b3          	neg	a5,a0
    1a8a:	8b9d                	andi	a5,a5,7
    1a8c:	4681                	li	a3,0
    1a8e:	18061a63          	bnez	a2,1c22 <strncpy+0x1d4>
    1a92:	00778713          	addi	a4,a5,7
    1a96:	45ad                	li	a1,11
    1a98:	18b76363          	bltu	a4,a1,1c1e <strncpy+0x1d0>
    1a9c:	1ae6eb63          	bltu	a3,a4,1c52 <strncpy+0x204>
    1aa0:	1a078363          	beqz	a5,1c46 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1aa4:	00050023          	sb	zero,0(a0)
    1aa8:	4685                	li	a3,1
    1aaa:	00150713          	addi	a4,a0,1
    1aae:	18d78f63          	beq	a5,a3,1c4c <strncpy+0x1fe>
    1ab2:	000500a3          	sb	zero,1(a0)
    1ab6:	4689                	li	a3,2
    1ab8:	00250713          	addi	a4,a0,2
    1abc:	18d78e63          	beq	a5,a3,1c58 <strncpy+0x20a>
    1ac0:	00050123          	sb	zero,2(a0)
    1ac4:	468d                	li	a3,3
    1ac6:	00350713          	addi	a4,a0,3
    1aca:	16d78c63          	beq	a5,a3,1c42 <strncpy+0x1f4>
    1ace:	000501a3          	sb	zero,3(a0)
    1ad2:	4691                	li	a3,4
    1ad4:	00450713          	addi	a4,a0,4
    1ad8:	18d78263          	beq	a5,a3,1c5c <strncpy+0x20e>
    1adc:	00050223          	sb	zero,4(a0)
    1ae0:	4695                	li	a3,5
    1ae2:	00550713          	addi	a4,a0,5
    1ae6:	16d78d63          	beq	a5,a3,1c60 <strncpy+0x212>
    1aea:	000502a3          	sb	zero,5(a0)
    1aee:	469d                	li	a3,7
    1af0:	00650713          	addi	a4,a0,6
    1af4:	16d79863          	bne	a5,a3,1c64 <strncpy+0x216>
    1af8:	00750713          	addi	a4,a0,7
    1afc:	00050323          	sb	zero,6(a0)
    1b00:	40f80833          	sub	a6,a6,a5
    1b04:	ff887593          	andi	a1,a6,-8
    1b08:	97aa                	add	a5,a5,a0
    1b0a:	95be                	add	a1,a1,a5
    1b0c:	0007b023          	sd	zero,0(a5)
    1b10:	07a1                	addi	a5,a5,8
    1b12:	feb79de3          	bne	a5,a1,1b0c <strncpy+0xbe>
    1b16:	ff887593          	andi	a1,a6,-8
    1b1a:	9ead                	addw	a3,a3,a1
    1b1c:	00b707b3          	add	a5,a4,a1
    1b20:	12b80863          	beq	a6,a1,1c50 <strncpy+0x202>
    1b24:	00078023          	sb	zero,0(a5)
    1b28:	0016871b          	addiw	a4,a3,1
    1b2c:	0ec77863          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1b30:	000780a3          	sb	zero,1(a5)
    1b34:	0026871b          	addiw	a4,a3,2
    1b38:	0ec77263          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1b3c:	00078123          	sb	zero,2(a5)
    1b40:	0036871b          	addiw	a4,a3,3
    1b44:	0cc77c63          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1b48:	000781a3          	sb	zero,3(a5)
    1b4c:	0046871b          	addiw	a4,a3,4
    1b50:	0cc77663          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1b54:	00078223          	sb	zero,4(a5)
    1b58:	0056871b          	addiw	a4,a3,5
    1b5c:	0cc77063          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1b60:	000782a3          	sb	zero,5(a5)
    1b64:	0066871b          	addiw	a4,a3,6
    1b68:	0ac77a63          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1b6c:	00078323          	sb	zero,6(a5)
    1b70:	0076871b          	addiw	a4,a3,7
    1b74:	0ac77463          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1b78:	000783a3          	sb	zero,7(a5)
    1b7c:	0086871b          	addiw	a4,a3,8
    1b80:	08c77e63          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1b84:	00078423          	sb	zero,8(a5)
    1b88:	0096871b          	addiw	a4,a3,9
    1b8c:	08c77863          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1b90:	000784a3          	sb	zero,9(a5)
    1b94:	00a6871b          	addiw	a4,a3,10
    1b98:	08c77263          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1b9c:	00078523          	sb	zero,10(a5)
    1ba0:	00b6871b          	addiw	a4,a3,11
    1ba4:	06c77c63          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1ba8:	000785a3          	sb	zero,11(a5)
    1bac:	00c6871b          	addiw	a4,a3,12
    1bb0:	06c77663          	bgeu	a4,a2,1c1c <strncpy+0x1ce>
    1bb4:	00078623          	sb	zero,12(a5)
    1bb8:	26b5                	addiw	a3,a3,13
    1bba:	06c6f163          	bgeu	a3,a2,1c1c <strncpy+0x1ce>
    1bbe:	000786a3          	sb	zero,13(a5)
    1bc2:	8082                	ret
            ;
        if (!n || !*s)
    1bc4:	c645                	beqz	a2,1c6c <strncpy+0x21e>
    1bc6:	0005c783          	lbu	a5,0(a1)
    1bca:	ea078be3          	beqz	a5,1a80 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bce:	479d                	li	a5,7
    1bd0:	02c7ff63          	bgeu	a5,a2,1c0e <strncpy+0x1c0>
    1bd4:	00000897          	auipc	a7,0x0
    1bd8:	3f48b883          	ld	a7,1012(a7) # 1fc8 <__clone+0xe4>
    1bdc:	00000817          	auipc	a6,0x0
    1be0:	3f483803          	ld	a6,1012(a6) # 1fd0 <__clone+0xec>
    1be4:	431d                	li	t1,7
    1be6:	6198                	ld	a4,0(a1)
    1be8:	011707b3          	add	a5,a4,a7
    1bec:	fff74693          	not	a3,a4
    1bf0:	8ff5                	and	a5,a5,a3
    1bf2:	0107f7b3          	and	a5,a5,a6
    1bf6:	ef81                	bnez	a5,1c0e <strncpy+0x1c0>
            *wd = *ws;
    1bf8:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bfa:	1661                	addi	a2,a2,-8
    1bfc:	05a1                	addi	a1,a1,8
    1bfe:	0521                	addi	a0,a0,8
    1c00:	fec363e3          	bltu	t1,a2,1be6 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c04:	e609                	bnez	a2,1c0e <strncpy+0x1c0>
    1c06:	a08d                	j	1c68 <strncpy+0x21a>
    1c08:	167d                	addi	a2,a2,-1
    1c0a:	0505                	addi	a0,a0,1
    1c0c:	ca01                	beqz	a2,1c1c <strncpy+0x1ce>
    1c0e:	0005c783          	lbu	a5,0(a1)
    1c12:	0585                	addi	a1,a1,1
    1c14:	00f50023          	sb	a5,0(a0)
    1c18:	fbe5                	bnez	a5,1c08 <strncpy+0x1ba>
        ;
tail:
    1c1a:	b59d                	j	1a80 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c1c:	8082                	ret
    1c1e:	472d                	li	a4,11
    1c20:	bdb5                	j	1a9c <strncpy+0x4e>
    1c22:	00778713          	addi	a4,a5,7
    1c26:	45ad                	li	a1,11
    1c28:	fff60693          	addi	a3,a2,-1
    1c2c:	e6b778e3          	bgeu	a4,a1,1a9c <strncpy+0x4e>
    1c30:	b7fd                	j	1c1e <strncpy+0x1d0>
    1c32:	40a007b3          	neg	a5,a0
    1c36:	8832                	mv	a6,a2
    1c38:	8b9d                	andi	a5,a5,7
    1c3a:	4681                	li	a3,0
    1c3c:	e4060be3          	beqz	a2,1a92 <strncpy+0x44>
    1c40:	b7cd                	j	1c22 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c42:	468d                	li	a3,3
    1c44:	bd75                	j	1b00 <strncpy+0xb2>
    1c46:	872a                	mv	a4,a0
    1c48:	4681                	li	a3,0
    1c4a:	bd5d                	j	1b00 <strncpy+0xb2>
    1c4c:	4685                	li	a3,1
    1c4e:	bd4d                	j	1b00 <strncpy+0xb2>
    1c50:	8082                	ret
    1c52:	87aa                	mv	a5,a0
    1c54:	4681                	li	a3,0
    1c56:	b5f9                	j	1b24 <strncpy+0xd6>
    1c58:	4689                	li	a3,2
    1c5a:	b55d                	j	1b00 <strncpy+0xb2>
    1c5c:	4691                	li	a3,4
    1c5e:	b54d                	j	1b00 <strncpy+0xb2>
    1c60:	4695                	li	a3,5
    1c62:	bd79                	j	1b00 <strncpy+0xb2>
    1c64:	4699                	li	a3,6
    1c66:	bd69                	j	1b00 <strncpy+0xb2>
    1c68:	8082                	ret
    1c6a:	8082                	ret
    1c6c:	8082                	ret

0000000000001c6e <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c6e:	87aa                	mv	a5,a0
    1c70:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c72:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c76:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c7a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c7c:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c7e:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c82:	2501                	sext.w	a0,a0
    1c84:	8082                	ret

0000000000001c86 <openat>:
    register long a7 __asm__("a7") = n;
    1c86:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c8a:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c8e:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c92:	2501                	sext.w	a0,a0
    1c94:	8082                	ret

0000000000001c96 <close>:
    register long a7 __asm__("a7") = n;
    1c96:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c9a:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c9e:	2501                	sext.w	a0,a0
    1ca0:	8082                	ret

0000000000001ca2 <read>:
    register long a7 __asm__("a7") = n;
    1ca2:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ca6:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1caa:	8082                	ret

0000000000001cac <write>:
    register long a7 __asm__("a7") = n;
    1cac:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cb0:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cb4:	8082                	ret

0000000000001cb6 <getpid>:
    register long a7 __asm__("a7") = n;
    1cb6:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cba:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cbe:	2501                	sext.w	a0,a0
    1cc0:	8082                	ret

0000000000001cc2 <getppid>:
    register long a7 __asm__("a7") = n;
    1cc2:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cc6:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cca:	2501                	sext.w	a0,a0
    1ccc:	8082                	ret

0000000000001cce <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cce:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cd2:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cd6:	2501                	sext.w	a0,a0
    1cd8:	8082                	ret

0000000000001cda <fork>:
    register long a7 __asm__("a7") = n;
    1cda:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cde:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1ce0:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ce2:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1ce6:	2501                	sext.w	a0,a0
    1ce8:	8082                	ret

0000000000001cea <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cea:	85b2                	mv	a1,a2
    1cec:	863a                	mv	a2,a4
    if (stack)
    1cee:	c191                	beqz	a1,1cf2 <clone+0x8>
	stack += stack_size;
    1cf0:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cf2:	4781                	li	a5,0
    1cf4:	4701                	li	a4,0
    1cf6:	4681                	li	a3,0
    1cf8:	2601                	sext.w	a2,a2
    1cfa:	a2ed                	j	1ee4 <__clone>

0000000000001cfc <exit>:
    register long a7 __asm__("a7") = n;
    1cfc:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d00:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d04:	8082                	ret

0000000000001d06 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d06:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d0a:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d0c:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d10:	2501                	sext.w	a0,a0
    1d12:	8082                	ret

0000000000001d14 <exec>:
    register long a7 __asm__("a7") = n;
    1d14:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d18:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d1c:	2501                	sext.w	a0,a0
    1d1e:	8082                	ret

0000000000001d20 <execve>:
    register long a7 __asm__("a7") = n;
    1d20:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d24:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d28:	2501                	sext.w	a0,a0
    1d2a:	8082                	ret

0000000000001d2c <times>:
    register long a7 __asm__("a7") = n;
    1d2c:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d30:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d34:	2501                	sext.w	a0,a0
    1d36:	8082                	ret

0000000000001d38 <get_time>:

int64 get_time()
{
    1d38:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d3a:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d3e:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d40:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d42:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d46:	2501                	sext.w	a0,a0
    1d48:	ed09                	bnez	a0,1d62 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d4a:	67a2                	ld	a5,8(sp)
    1d4c:	3e800713          	li	a4,1000
    1d50:	00015503          	lhu	a0,0(sp)
    1d54:	02e7d7b3          	divu	a5,a5,a4
    1d58:	02e50533          	mul	a0,a0,a4
    1d5c:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d5e:	0141                	addi	sp,sp,16
    1d60:	8082                	ret
        return -1;
    1d62:	557d                	li	a0,-1
    1d64:	bfed                	j	1d5e <get_time+0x26>

0000000000001d66 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d66:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d6a:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d6e:	2501                	sext.w	a0,a0
    1d70:	8082                	ret

0000000000001d72 <time>:
    register long a7 __asm__("a7") = n;
    1d72:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d76:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d7a:	2501                	sext.w	a0,a0
    1d7c:	8082                	ret

0000000000001d7e <sleep>:

int sleep(unsigned long long time)
{
    1d7e:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d80:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d82:	850a                	mv	a0,sp
    1d84:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d86:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d8a:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d8c:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d90:	e501                	bnez	a0,1d98 <sleep+0x1a>
    return 0;
    1d92:	4501                	li	a0,0
}
    1d94:	0141                	addi	sp,sp,16
    1d96:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d98:	4502                	lw	a0,0(sp)
}
    1d9a:	0141                	addi	sp,sp,16
    1d9c:	8082                	ret

0000000000001d9e <set_priority>:
    register long a7 __asm__("a7") = n;
    1d9e:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1da2:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1da6:	2501                	sext.w	a0,a0
    1da8:	8082                	ret

0000000000001daa <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1daa:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1dae:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1db2:	8082                	ret

0000000000001db4 <munmap>:
    register long a7 __asm__("a7") = n;
    1db4:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db8:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1dbc:	2501                	sext.w	a0,a0
    1dbe:	8082                	ret

0000000000001dc0 <wait>:

int wait(int *code)
{
    1dc0:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dc2:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1dc6:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1dc8:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dca:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dcc:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dd0:	2501                	sext.w	a0,a0
    1dd2:	8082                	ret

0000000000001dd4 <spawn>:
    register long a7 __asm__("a7") = n;
    1dd4:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dd8:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1ddc:	2501                	sext.w	a0,a0
    1dde:	8082                	ret

0000000000001de0 <mailread>:
    register long a7 __asm__("a7") = n;
    1de0:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1de4:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1de8:	2501                	sext.w	a0,a0
    1dea:	8082                	ret

0000000000001dec <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dec:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1df0:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1df4:	2501                	sext.w	a0,a0
    1df6:	8082                	ret

0000000000001df8 <fstat>:
    register long a7 __asm__("a7") = n;
    1df8:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dfc:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e00:	2501                	sext.w	a0,a0
    1e02:	8082                	ret

0000000000001e04 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e04:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e06:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e0a:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e0c:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e10:	2501                	sext.w	a0,a0
    1e12:	8082                	ret

0000000000001e14 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e14:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e16:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e1a:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e1c:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e20:	2501                	sext.w	a0,a0
    1e22:	8082                	ret

0000000000001e24 <link>:

int link(char *old_path, char *new_path)
{
    1e24:	87aa                	mv	a5,a0
    1e26:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e28:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e2c:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e30:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e32:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e36:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e38:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e3c:	2501                	sext.w	a0,a0
    1e3e:	8082                	ret

0000000000001e40 <unlink>:

int unlink(char *path)
{
    1e40:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e42:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e46:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e4a:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e4c:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e50:	2501                	sext.w	a0,a0
    1e52:	8082                	ret

0000000000001e54 <uname>:
    register long a7 __asm__("a7") = n;
    1e54:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e58:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e5c:	2501                	sext.w	a0,a0
    1e5e:	8082                	ret

0000000000001e60 <brk>:
    register long a7 __asm__("a7") = n;
    1e60:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e64:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e68:	2501                	sext.w	a0,a0
    1e6a:	8082                	ret

0000000000001e6c <getcwd>:
    register long a7 __asm__("a7") = n;
    1e6c:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e6e:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e72:	8082                	ret

0000000000001e74 <chdir>:
    register long a7 __asm__("a7") = n;
    1e74:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e78:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e7c:	2501                	sext.w	a0,a0
    1e7e:	8082                	ret

0000000000001e80 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e80:	862e                	mv	a2,a1
    1e82:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e84:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e86:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e8a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e8e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e90:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e92:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e96:	2501                	sext.w	a0,a0
    1e98:	8082                	ret

0000000000001e9a <getdents>:
    register long a7 __asm__("a7") = n;
    1e9a:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e9e:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ea2:	2501                	sext.w	a0,a0
    1ea4:	8082                	ret

0000000000001ea6 <pipe>:
    register long a7 __asm__("a7") = n;
    1ea6:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1eaa:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eac:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1eb0:	2501                	sext.w	a0,a0
    1eb2:	8082                	ret

0000000000001eb4 <dup>:
    register long a7 __asm__("a7") = n;
    1eb4:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1eb6:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1eba:	2501                	sext.w	a0,a0
    1ebc:	8082                	ret

0000000000001ebe <dup2>:
    register long a7 __asm__("a7") = n;
    1ebe:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ec0:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ec2:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ec6:	2501                	sext.w	a0,a0
    1ec8:	8082                	ret

0000000000001eca <mount>:
    register long a7 __asm__("a7") = n;
    1eca:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ece:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ed2:	2501                	sext.w	a0,a0
    1ed4:	8082                	ret

0000000000001ed6 <umount>:
    register long a7 __asm__("a7") = n;
    1ed6:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1eda:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1edc:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ee0:	2501                	sext.w	a0,a0
    1ee2:	8082                	ret

0000000000001ee4 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ee4:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ee6:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ee8:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1eea:	8532                	mv	a0,a2
	mv a2, a4
    1eec:	863a                	mv	a2,a4
	mv a3, a5
    1eee:	86be                	mv	a3,a5
	mv a4, a6
    1ef0:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ef2:	0dc00893          	li	a7,220
	ecall
    1ef6:	00000073          	ecall

	beqz a0, 1f
    1efa:	c111                	beqz	a0,1efe <__clone+0x1a>
	# Parent
	ret
    1efc:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1efe:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f00:	6522                	ld	a0,8(sp)
	jalr a1
    1f02:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f04:	05d00893          	li	a7,93
	ecall
    1f08:	00000073          	ecall
