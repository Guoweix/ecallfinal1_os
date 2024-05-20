
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/mkdir_:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a0f9                	j	10d0 <__start_main>

0000000000001004 <test_mkdir>:
#include "stdio.h"
#include "stdlib.h"
#include "unistd.h"

void test_mkdir(void){
    1004:	1141                	addi	sp,sp,-16
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f0a50513          	addi	a0,a0,-246 # 1f10 <__clone+0x28>
void test_mkdir(void){
    100e:	e406                	sd	ra,8(sp)
    1010:	e022                	sd	s0,0(sp)
    TEST_START(__func__);
    1012:	330000ef          	jal	1342 <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	fba50513          	addi	a0,a0,-70 # 1fd0 <__func__.0>
    101e:	324000ef          	jal	1342 <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	f0650513          	addi	a0,a0,-250 # 1f28 <__clone+0x40>
    102a:	318000ef          	jal	1342 <puts>
    int rt, fd;

    rt = mkdir("test_mkdir", 0666);
    102e:	1b600593          	li	a1,438
    1032:	00001517          	auipc	a0,0x1
    1036:	f0650513          	addi	a0,a0,-250 # 1f38 <__clone+0x50>
    103a:	64b000ef          	jal	1e84 <mkdir>
    printf("mkdir ret: %d\n", rt);
    103e:	85aa                	mv	a1,a0
    rt = mkdir("test_mkdir", 0666);
    1040:	842a                	mv	s0,a0
    printf("mkdir ret: %d\n", rt);
    1042:	00001517          	auipc	a0,0x1
    1046:	f0650513          	addi	a0,a0,-250 # 1f48 <__clone+0x60>
    104a:	31a000ef          	jal	1364 <printf>
    assert(rt != -1);
    104e:	57fd                	li	a5,-1
    1050:	06f40163          	beq	s0,a5,10b2 <test_mkdir+0xae>
    fd = open("test_mkdir", O_RDONLY | O_DIRECTORY);
    1054:	002005b7          	lui	a1,0x200
    1058:	00001517          	auipc	a0,0x1
    105c:	ee050513          	addi	a0,a0,-288 # 1f38 <__clone+0x50>
    1060:	413000ef          	jal	1c72 <open>
    1064:	842a                	mv	s0,a0
    if(fd > 0){
    1066:	02a05f63          	blez	a0,10a4 <test_mkdir+0xa0>
        printf("  mkdir success.\n");
    106a:	00001517          	auipc	a0,0x1
    106e:	f0e50513          	addi	a0,a0,-242 # 1f78 <__clone+0x90>
    1072:	2f2000ef          	jal	1364 <printf>
        close(fd);
    1076:	8522                	mv	a0,s0
    1078:	423000ef          	jal	1c9a <close>
    }
    else printf("  mkdir error.\n");
    TEST_END(__func__);
    107c:	00001517          	auipc	a0,0x1
    1080:	f2450513          	addi	a0,a0,-220 # 1fa0 <__clone+0xb8>
    1084:	2be000ef          	jal	1342 <puts>
    1088:	00001517          	auipc	a0,0x1
    108c:	f4850513          	addi	a0,a0,-184 # 1fd0 <__func__.0>
    1090:	2b2000ef          	jal	1342 <puts>
}
    1094:	6402                	ld	s0,0(sp)
    1096:	60a2                	ld	ra,8(sp)
    TEST_END(__func__);
    1098:	00001517          	auipc	a0,0x1
    109c:	e9050513          	addi	a0,a0,-368 # 1f28 <__clone+0x40>
}
    10a0:	0141                	addi	sp,sp,16
    TEST_END(__func__);
    10a2:	a445                	j	1342 <puts>
    else printf("  mkdir error.\n");
    10a4:	00001517          	auipc	a0,0x1
    10a8:	eec50513          	addi	a0,a0,-276 # 1f90 <__clone+0xa8>
    10ac:	2b8000ef          	jal	1364 <printf>
    10b0:	b7f1                	j	107c <test_mkdir+0x78>
    assert(rt != -1);
    10b2:	00001517          	auipc	a0,0x1
    10b6:	ea650513          	addi	a0,a0,-346 # 1f58 <__clone+0x70>
    10ba:	534000ef          	jal	15ee <panic>
    10be:	bf59                	j	1054 <test_mkdir+0x50>

00000000000010c0 <main>:

int main(void){
    10c0:	1141                	addi	sp,sp,-16
    10c2:	e406                	sd	ra,8(sp)
    test_mkdir();
    10c4:	f41ff0ef          	jal	1004 <test_mkdir>
    return 0;
}
    10c8:	60a2                	ld	ra,8(sp)
    10ca:	4501                	li	a0,0
    10cc:	0141                	addi	sp,sp,16
    10ce:	8082                	ret

00000000000010d0 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10d0:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10d2:	4108                	lw	a0,0(a0)
{
    10d4:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10d6:	05a1                	addi	a1,a1,8 # 200008 <digits+0x1fe028>
{
    10d8:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10da:	fe7ff0ef          	jal	10c0 <main>
    10de:	423000ef          	jal	1d00 <exit>
	return 0;
}
    10e2:	60a2                	ld	ra,8(sp)
    10e4:	4501                	li	a0,0
    10e6:	0141                	addi	sp,sp,16
    10e8:	8082                	ret

00000000000010ea <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10ea:	7179                	addi	sp,sp,-48
    10ec:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10ee:	12054b63          	bltz	a0,1224 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10f2:	02b577bb          	remuw	a5,a0,a1
    10f6:	00001617          	auipc	a2,0x1
    10fa:	eea60613          	addi	a2,a2,-278 # 1fe0 <digits>
    buf[16] = 0;
    10fe:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1102:	0005871b          	sext.w	a4,a1
    1106:	1782                	slli	a5,a5,0x20
    1108:	9381                	srli	a5,a5,0x20
    110a:	97b2                	add	a5,a5,a2
    110c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1110:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1114:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1118:	1cb56363          	bltu	a0,a1,12de <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    111c:	45b9                	li	a1,14
    111e:	02e877bb          	remuw	a5,a6,a4
    1122:	1782                	slli	a5,a5,0x20
    1124:	9381                	srli	a5,a5,0x20
    1126:	97b2                	add	a5,a5,a2
    1128:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    112c:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    1130:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1134:	0ce86e63          	bltu	a6,a4,1210 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1138:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    113c:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    1140:	1582                	slli	a1,a1,0x20
    1142:	9181                	srli	a1,a1,0x20
    1144:	95b2                	add	a1,a1,a2
    1146:	0005c583          	lbu	a1,0(a1)
    114a:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    114e:	0007859b          	sext.w	a1,a5
    1152:	12e6ec63          	bltu	a3,a4,128a <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1156:	02e7f6bb          	remuw	a3,a5,a4
    115a:	1682                	slli	a3,a3,0x20
    115c:	9281                	srli	a3,a3,0x20
    115e:	96b2                	add	a3,a3,a2
    1160:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1164:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1168:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    116c:	12e5e863          	bltu	a1,a4,129c <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    1170:	02e876bb          	remuw	a3,a6,a4
    1174:	1682                	slli	a3,a3,0x20
    1176:	9281                	srli	a3,a3,0x20
    1178:	96b2                	add	a3,a3,a2
    117a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    117e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1182:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1186:	12e86463          	bltu	a6,a4,12ae <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    118a:	02e5f6bb          	remuw	a3,a1,a4
    118e:	1682                	slli	a3,a3,0x20
    1190:	9281                	srli	a3,a3,0x20
    1192:	96b2                	add	a3,a3,a2
    1194:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1198:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    119c:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    11a0:	0ce5ec63          	bltu	a1,a4,1278 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    11a4:	02e876bb          	remuw	a3,a6,a4
    11a8:	1682                	slli	a3,a3,0x20
    11aa:	9281                	srli	a3,a3,0x20
    11ac:	96b2                	add	a3,a3,a2
    11ae:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11b2:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11b6:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11ba:	10e86963          	bltu	a6,a4,12cc <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11be:	02e5f6bb          	remuw	a3,a1,a4
    11c2:	1682                	slli	a3,a3,0x20
    11c4:	9281                	srli	a3,a3,0x20
    11c6:	96b2                	add	a3,a3,a2
    11c8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11cc:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11d0:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11d4:	10e5e763          	bltu	a1,a4,12e2 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11d8:	02e876bb          	remuw	a3,a6,a4
    11dc:	1682                	slli	a3,a3,0x20
    11de:	9281                	srli	a3,a3,0x20
    11e0:	96b2                	add	a3,a3,a2
    11e2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11e6:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11ea:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11ee:	10e86363          	bltu	a6,a4,12f4 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11f2:	1782                	slli	a5,a5,0x20
    11f4:	9381                	srli	a5,a5,0x20
    11f6:	97b2                	add	a5,a5,a2
    11f8:	0007c783          	lbu	a5,0(a5)
    11fc:	4599                	li	a1,6
    11fe:	00f10723          	sb	a5,14(sp)

    if (sign)
    1202:	00055763          	bgez	a0,1210 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1206:	02d00793          	li	a5,45
    120a:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    120e:	4595                	li	a1,5
    write(f, s, l);
    1210:	003c                	addi	a5,sp,8
    1212:	4641                	li	a2,16
    1214:	9e0d                	subw	a2,a2,a1
    1216:	4505                	li	a0,1
    1218:	95be                	add	a1,a1,a5
    121a:	297000ef          	jal	1cb0 <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    121e:	70a2                	ld	ra,40(sp)
    1220:	6145                	addi	sp,sp,48
    1222:	8082                	ret
        x = -xx;
    1224:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1228:	02b877bb          	remuw	a5,a6,a1
    122c:	00001617          	auipc	a2,0x1
    1230:	db460613          	addi	a2,a2,-588 # 1fe0 <digits>
    buf[16] = 0;
    1234:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1238:	0005871b          	sext.w	a4,a1
    123c:	1782                	slli	a5,a5,0x20
    123e:	9381                	srli	a5,a5,0x20
    1240:	97b2                	add	a5,a5,a2
    1242:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1246:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    124a:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    124e:	06b86963          	bltu	a6,a1,12c0 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1252:	02e8f7bb          	remuw	a5,a7,a4
    1256:	1782                	slli	a5,a5,0x20
    1258:	9381                	srli	a5,a5,0x20
    125a:	97b2                	add	a5,a5,a2
    125c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1260:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1264:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1268:	ece8f8e3          	bgeu	a7,a4,1138 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    126c:	02d00793          	li	a5,45
    1270:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1274:	45b5                	li	a1,13
    1276:	bf69                	j	1210 <printint.constprop.0+0x126>
    1278:	45a9                	li	a1,10
    if (sign)
    127a:	f8055be3          	bgez	a0,1210 <printint.constprop.0+0x126>
        buf[i--] = '-';
    127e:	02d00793          	li	a5,45
    1282:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1286:	45a5                	li	a1,9
    1288:	b761                	j	1210 <printint.constprop.0+0x126>
    128a:	45b5                	li	a1,13
    if (sign)
    128c:	f80552e3          	bgez	a0,1210 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1290:	02d00793          	li	a5,45
    1294:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1298:	45b1                	li	a1,12
    129a:	bf9d                	j	1210 <printint.constprop.0+0x126>
    129c:	45b1                	li	a1,12
    if (sign)
    129e:	f60559e3          	bgez	a0,1210 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12a2:	02d00793          	li	a5,45
    12a6:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12aa:	45ad                	li	a1,11
    12ac:	b795                	j	1210 <printint.constprop.0+0x126>
    12ae:	45ad                	li	a1,11
    if (sign)
    12b0:	f60550e3          	bgez	a0,1210 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b4:	02d00793          	li	a5,45
    12b8:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12bc:	45a9                	li	a1,10
    12be:	bf89                	j	1210 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c0:	02d00793          	li	a5,45
    12c4:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12c8:	45b9                	li	a1,14
    12ca:	b799                	j	1210 <printint.constprop.0+0x126>
    12cc:	45a5                	li	a1,9
    if (sign)
    12ce:	f40551e3          	bgez	a0,1210 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d2:	02d00793          	li	a5,45
    12d6:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12da:	45a1                	li	a1,8
    12dc:	bf15                	j	1210 <printint.constprop.0+0x126>
    i = 15;
    12de:	45bd                	li	a1,15
    12e0:	bf05                	j	1210 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12e2:	45a1                	li	a1,8
    if (sign)
    12e4:	f20556e3          	bgez	a0,1210 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12e8:	02d00793          	li	a5,45
    12ec:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12f0:	459d                	li	a1,7
    12f2:	bf39                	j	1210 <printint.constprop.0+0x126>
    12f4:	459d                	li	a1,7
    if (sign)
    12f6:	f0055de3          	bgez	a0,1210 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12fa:	02d00793          	li	a5,45
    12fe:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    1302:	4599                	li	a1,6
    1304:	b731                	j	1210 <printint.constprop.0+0x126>

0000000000001306 <getchar>:
{
    1306:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1308:	00f10593          	addi	a1,sp,15
    130c:	4605                	li	a2,1
    130e:	4501                	li	a0,0
{
    1310:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1312:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1316:	191000ef          	jal	1ca6 <read>
}
    131a:	60e2                	ld	ra,24(sp)
    131c:	00f14503          	lbu	a0,15(sp)
    1320:	6105                	addi	sp,sp,32
    1322:	8082                	ret

0000000000001324 <putchar>:
{
    1324:	1101                	addi	sp,sp,-32
    1326:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1328:	00f10593          	addi	a1,sp,15
    132c:	4605                	li	a2,1
    132e:	4505                	li	a0,1
{
    1330:	ec06                	sd	ra,24(sp)
    char byte = c;
    1332:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1336:	17b000ef          	jal	1cb0 <write>
}
    133a:	60e2                	ld	ra,24(sp)
    133c:	2501                	sext.w	a0,a0
    133e:	6105                	addi	sp,sp,32
    1340:	8082                	ret

0000000000001342 <puts>:
{
    1342:	1141                	addi	sp,sp,-16
    1344:	e406                	sd	ra,8(sp)
    1346:	e022                	sd	s0,0(sp)
    1348:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    134a:	582000ef          	jal	18cc <strlen>
    134e:	862a                	mv	a2,a0
    1350:	85a2                	mv	a1,s0
    1352:	4505                	li	a0,1
    1354:	15d000ef          	jal	1cb0 <write>
}
    1358:	60a2                	ld	ra,8(sp)
    135a:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    135c:	957d                	srai	a0,a0,0x3f
    return r;
    135e:	2501                	sext.w	a0,a0
}
    1360:	0141                	addi	sp,sp,16
    1362:	8082                	ret

0000000000001364 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1364:	7131                	addi	sp,sp,-192
    1366:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1368:	013c                	addi	a5,sp,136
{
    136a:	f0ca                	sd	s2,96(sp)
    136c:	ecce                	sd	s3,88(sp)
    136e:	e8d2                	sd	s4,80(sp)
    1370:	e4d6                	sd	s5,72(sp)
    1372:	e0da                	sd	s6,64(sp)
    1374:	fc5e                	sd	s7,56(sp)
    1376:	fc86                	sd	ra,120(sp)
    1378:	f8a2                	sd	s0,112(sp)
    137a:	f4a6                	sd	s1,104(sp)
    137c:	e52e                	sd	a1,136(sp)
    137e:	e932                	sd	a2,144(sp)
    1380:	ed36                	sd	a3,152(sp)
    1382:	f13a                	sd	a4,160(sp)
    1384:	f942                	sd	a6,176(sp)
    1386:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1388:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    138a:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    138e:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1392:	00001b97          	auipc	s7,0x1
    1396:	c1eb8b93          	addi	s7,s7,-994 # 1fb0 <__clone+0xc8>
        switch (s[1])
    139a:	07800a93          	li	s5,120
    139e:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13a2:	00001997          	auipc	s3,0x1
    13a6:	c3e98993          	addi	s3,s3,-962 # 1fe0 <digits>
        if (!*s)
    13aa:	00054783          	lbu	a5,0(a0)
    13ae:	16078c63          	beqz	a5,1526 <printf+0x1c2>
    13b2:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13b4:	19278463          	beq	a5,s2,153c <printf+0x1d8>
    13b8:	00164783          	lbu	a5,1(a2)
    13bc:	0605                	addi	a2,a2,1
    13be:	fbfd                	bnez	a5,13b4 <printf+0x50>
    13c0:	84b2                	mv	s1,a2
        l = z - a;
    13c2:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13c6:	85aa                	mv	a1,a0
    13c8:	8622                	mv	a2,s0
    13ca:	4505                	li	a0,1
    13cc:	0e5000ef          	jal	1cb0 <write>
        if (l)
    13d0:	18041f63          	bnez	s0,156e <printf+0x20a>
        if (s[1] == 0)
    13d4:	0014c783          	lbu	a5,1(s1)
    13d8:	14078763          	beqz	a5,1526 <printf+0x1c2>
        switch (s[1])
    13dc:	1d478163          	beq	a5,s4,159e <printf+0x23a>
    13e0:	18fa6963          	bltu	s4,a5,1572 <printf+0x20e>
    13e4:	1b678363          	beq	a5,s6,158a <printf+0x226>
    13e8:	07000713          	li	a4,112
    13ec:	1ce79c63          	bne	a5,a4,15c4 <printf+0x260>
            printptr(va_arg(ap, uint64));
    13f0:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13f2:	03000793          	li	a5,48
    13f6:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13fa:	631c                	ld	a5,0(a4)
    13fc:	0721                	addi	a4,a4,8
    13fe:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1400:	00479f93          	slli	t6,a5,0x4
    1404:	00879f13          	slli	t5,a5,0x8
    1408:	00c79e93          	slli	t4,a5,0xc
    140c:	01079e13          	slli	t3,a5,0x10
    1410:	01479313          	slli	t1,a5,0x14
    1414:	01879893          	slli	a7,a5,0x18
    1418:	01c79713          	slli	a4,a5,0x1c
    141c:	02479813          	slli	a6,a5,0x24
    1420:	02879513          	slli	a0,a5,0x28
    1424:	02c79593          	slli	a1,a5,0x2c
    1428:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    142c:	03c7d293          	srli	t0,a5,0x3c
    1430:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1434:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1438:	03cfdf93          	srli	t6,t6,0x3c
    143c:	03cf5f13          	srli	t5,t5,0x3c
    1440:	03cede93          	srli	t4,t4,0x3c
    1444:	03ce5e13          	srli	t3,t3,0x3c
    1448:	03c35313          	srli	t1,t1,0x3c
    144c:	03c8d893          	srli	a7,a7,0x3c
    1450:	9371                	srli	a4,a4,0x3c
    1452:	03c85813          	srli	a6,a6,0x3c
    1456:	9171                	srli	a0,a0,0x3c
    1458:	91f1                	srli	a1,a1,0x3c
    145a:	9271                	srli	a2,a2,0x3c
    145c:	974e                	add	a4,a4,s3
    145e:	92f1                	srli	a3,a3,0x3c
    1460:	92ce                	add	t0,t0,s3
    1462:	9fce                	add	t6,t6,s3
    1464:	9f4e                	add	t5,t5,s3
    1466:	9ece                	add	t4,t4,s3
    1468:	9e4e                	add	t3,t3,s3
    146a:	934e                	add	t1,t1,s3
    146c:	98ce                	add	a7,a7,s3
    146e:	93ce                	add	t2,t2,s3
    1470:	984e                	add	a6,a6,s3
    1472:	954e                	add	a0,a0,s3
    1474:	95ce                	add	a1,a1,s3
    1476:	964e                	add	a2,a2,s3
    1478:	0002c283          	lbu	t0,0(t0)
    147c:	000fcf83          	lbu	t6,0(t6)
    1480:	000f4f03          	lbu	t5,0(t5)
    1484:	000ece83          	lbu	t4,0(t4)
    1488:	000e4e03          	lbu	t3,0(t3)
    148c:	00034303          	lbu	t1,0(t1)
    1490:	0008c883          	lbu	a7,0(a7)
    1494:	00074403          	lbu	s0,0(a4)
    1498:	0003c383          	lbu	t2,0(t2)
    149c:	00084803          	lbu	a6,0(a6)
    14a0:	00054503          	lbu	a0,0(a0)
    14a4:	0005c583          	lbu	a1,0(a1)
    14a8:	00064603          	lbu	a2,0(a2)
    14ac:	00d98733          	add	a4,s3,a3
    14b0:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14b4:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14b8:	9371                	srli	a4,a4,0x3c
    14ba:	8bbd                	andi	a5,a5,15
    14bc:	00510523          	sb	t0,10(sp)
    14c0:	01f105a3          	sb	t6,11(sp)
    14c4:	01e10623          	sb	t5,12(sp)
    14c8:	01d106a3          	sb	t4,13(sp)
    14cc:	01c10723          	sb	t3,14(sp)
    14d0:	006107a3          	sb	t1,15(sp)
    14d4:	01110823          	sb	a7,16(sp)
    14d8:	00710923          	sb	t2,18(sp)
    14dc:	010109a3          	sb	a6,19(sp)
    14e0:	00a10a23          	sb	a0,20(sp)
    14e4:	00b10aa3          	sb	a1,21(sp)
    14e8:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14ec:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14f0:	008108a3          	sb	s0,17(sp)
    14f4:	974e                	add	a4,a4,s3
    14f6:	97ce                	add	a5,a5,s3
    14f8:	00d10ba3          	sb	a3,23(sp)
    14fc:	00074703          	lbu	a4,0(a4)
    1500:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1504:	4649                	li	a2,18
    1506:	002c                	addi	a1,sp,8
    1508:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    150a:	00e10c23          	sb	a4,24(sp)
    150e:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1512:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1516:	79a000ef          	jal	1cb0 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    151a:	00248513          	addi	a0,s1,2
        if (!*s)
    151e:	00054783          	lbu	a5,0(a0)
    1522:	e80798e3          	bnez	a5,13b2 <printf+0x4e>
    }
    va_end(ap);
}
    1526:	70e6                	ld	ra,120(sp)
    1528:	7446                	ld	s0,112(sp)
    152a:	74a6                	ld	s1,104(sp)
    152c:	7906                	ld	s2,96(sp)
    152e:	69e6                	ld	s3,88(sp)
    1530:	6a46                	ld	s4,80(sp)
    1532:	6aa6                	ld	s5,72(sp)
    1534:	6b06                	ld	s6,64(sp)
    1536:	7be2                	ld	s7,56(sp)
    1538:	6129                	addi	sp,sp,192
    153a:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    153c:	00064783          	lbu	a5,0(a2)
    1540:	84b2                	mv	s1,a2
    1542:	01278963          	beq	a5,s2,1554 <printf+0x1f0>
    1546:	bdb5                	j	13c2 <printf+0x5e>
    1548:	0024c783          	lbu	a5,2(s1)
    154c:	0605                	addi	a2,a2,1
    154e:	0489                	addi	s1,s1,2
    1550:	e72799e3          	bne	a5,s2,13c2 <printf+0x5e>
    1554:	0014c783          	lbu	a5,1(s1)
    1558:	ff2788e3          	beq	a5,s2,1548 <printf+0x1e4>
        l = z - a;
    155c:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1560:	85aa                	mv	a1,a0
    1562:	8622                	mv	a2,s0
    1564:	4505                	li	a0,1
    1566:	74a000ef          	jal	1cb0 <write>
        if (l)
    156a:	e60405e3          	beqz	s0,13d4 <printf+0x70>
    156e:	8526                	mv	a0,s1
    1570:	bd2d                	j	13aa <printf+0x46>
        switch (s[1])
    1572:	05579963          	bne	a5,s5,15c4 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1576:	6782                	ld	a5,0(sp)
    1578:	45c1                	li	a1,16
    157a:	4388                	lw	a0,0(a5)
    157c:	07a1                	addi	a5,a5,8
    157e:	e03e                	sd	a5,0(sp)
    1580:	b6bff0ef          	jal	10ea <printint.constprop.0>
        s += 2;
    1584:	00248513          	addi	a0,s1,2
    1588:	bf59                	j	151e <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    158a:	6782                	ld	a5,0(sp)
    158c:	45a9                	li	a1,10
    158e:	4388                	lw	a0,0(a5)
    1590:	07a1                	addi	a5,a5,8
    1592:	e03e                	sd	a5,0(sp)
    1594:	b57ff0ef          	jal	10ea <printint.constprop.0>
        s += 2;
    1598:	00248513          	addi	a0,s1,2
    159c:	b749                	j	151e <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    159e:	6782                	ld	a5,0(sp)
    15a0:	6380                	ld	s0,0(a5)
    15a2:	07a1                	addi	a5,a5,8
    15a4:	e03e                	sd	a5,0(sp)
    15a6:	c031                	beqz	s0,15ea <printf+0x286>
            l = strnlen(a, 200);
    15a8:	0c800593          	li	a1,200
    15ac:	8522                	mv	a0,s0
    15ae:	40a000ef          	jal	19b8 <strnlen>
    write(f, s, l);
    15b2:	0005061b          	sext.w	a2,a0
    15b6:	85a2                	mv	a1,s0
    15b8:	4505                	li	a0,1
    15ba:	6f6000ef          	jal	1cb0 <write>
        s += 2;
    15be:	00248513          	addi	a0,s1,2
    15c2:	bfb1                	j	151e <printf+0x1ba>
    return write(stdout, &byte, 1);
    15c4:	4605                	li	a2,1
    15c6:	002c                	addi	a1,sp,8
    15c8:	4505                	li	a0,1
    char byte = c;
    15ca:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15ce:	6e2000ef          	jal	1cb0 <write>
    char byte = c;
    15d2:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15d6:	4605                	li	a2,1
    15d8:	002c                	addi	a1,sp,8
    15da:	4505                	li	a0,1
    char byte = c;
    15dc:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15e0:	6d0000ef          	jal	1cb0 <write>
        s += 2;
    15e4:	00248513          	addi	a0,s1,2
    15e8:	bf1d                	j	151e <printf+0x1ba>
                a = "(null)";
    15ea:	845e                	mv	s0,s7
    15ec:	bf75                	j	15a8 <printf+0x244>

00000000000015ee <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15ee:	1141                	addi	sp,sp,-16
    15f0:	e406                	sd	ra,8(sp)
    puts(m);
    15f2:	d51ff0ef          	jal	1342 <puts>
    exit(-100);
}
    15f6:	60a2                	ld	ra,8(sp)
    exit(-100);
    15f8:	f9c00513          	li	a0,-100
}
    15fc:	0141                	addi	sp,sp,16
    exit(-100);
    15fe:	a709                	j	1d00 <exit>

0000000000001600 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1600:	02000793          	li	a5,32
    1604:	00f50663          	beq	a0,a5,1610 <isspace+0x10>
    1608:	355d                	addiw	a0,a0,-9
    160a:	00553513          	sltiu	a0,a0,5
    160e:	8082                	ret
    1610:	4505                	li	a0,1
}
    1612:	8082                	ret

0000000000001614 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1614:	fd05051b          	addiw	a0,a0,-48
}
    1618:	00a53513          	sltiu	a0,a0,10
    161c:	8082                	ret

000000000000161e <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    161e:	02000613          	li	a2,32
    1622:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1624:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1628:	ff77069b          	addiw	a3,a4,-9
    162c:	04c70d63          	beq	a4,a2,1686 <atoi+0x68>
    1630:	0007079b          	sext.w	a5,a4
    1634:	04d5f963          	bgeu	a1,a3,1686 <atoi+0x68>
        s++;
    switch (*s)
    1638:	02b00693          	li	a3,43
    163c:	04d70a63          	beq	a4,a3,1690 <atoi+0x72>
    1640:	02d00693          	li	a3,45
    1644:	06d70463          	beq	a4,a3,16ac <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1648:	fd07859b          	addiw	a1,a5,-48
    164c:	4625                	li	a2,9
    164e:	873e                	mv	a4,a5
    1650:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1652:	4e01                	li	t3,0
    while (isdigit(*s))
    1654:	04b66a63          	bltu	a2,a1,16a8 <atoi+0x8a>
    int n = 0, neg = 0;
    1658:	4501                	li	a0,0
    while (isdigit(*s))
    165a:	4825                	li	a6,9
    165c:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1660:	0025179b          	slliw	a5,a0,0x2
    1664:	9d3d                	addw	a0,a0,a5
    1666:	fd07031b          	addiw	t1,a4,-48
    166a:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    166e:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1672:	0685                	addi	a3,a3,1
    1674:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1678:	0006071b          	sext.w	a4,a2
    167c:	feb870e3          	bgeu	a6,a1,165c <atoi+0x3e>
    return neg ? n : -n;
    1680:	000e0563          	beqz	t3,168a <atoi+0x6c>
}
    1684:	8082                	ret
        s++;
    1686:	0505                	addi	a0,a0,1
    1688:	bf71                	j	1624 <atoi+0x6>
    return neg ? n : -n;
    168a:	4113053b          	subw	a0,t1,a7
    168e:	8082                	ret
    while (isdigit(*s))
    1690:	00154783          	lbu	a5,1(a0)
    1694:	4625                	li	a2,9
        s++;
    1696:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    169a:	fd07859b          	addiw	a1,a5,-48
    169e:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16a2:	4e01                	li	t3,0
    while (isdigit(*s))
    16a4:	fab67ae3          	bgeu	a2,a1,1658 <atoi+0x3a>
    16a8:	4501                	li	a0,0
}
    16aa:	8082                	ret
    while (isdigit(*s))
    16ac:	00154783          	lbu	a5,1(a0)
    16b0:	4625                	li	a2,9
        s++;
    16b2:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16b6:	fd07859b          	addiw	a1,a5,-48
    16ba:	0007871b          	sext.w	a4,a5
    16be:	feb665e3          	bltu	a2,a1,16a8 <atoi+0x8a>
        neg = 1;
    16c2:	4e05                	li	t3,1
    16c4:	bf51                	j	1658 <atoi+0x3a>

00000000000016c6 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16c6:	16060d63          	beqz	a2,1840 <memset+0x17a>
    16ca:	40a007b3          	neg	a5,a0
    16ce:	8b9d                	andi	a5,a5,7
    16d0:	00778713          	addi	a4,a5,7
    16d4:	482d                	li	a6,11
    16d6:	0ff5f593          	zext.b	a1,a1
    16da:	fff60693          	addi	a3,a2,-1
    16de:	17076263          	bltu	a4,a6,1842 <memset+0x17c>
    16e2:	16e6ea63          	bltu	a3,a4,1856 <memset+0x190>
    16e6:	16078563          	beqz	a5,1850 <memset+0x18a>
    16ea:	00b50023          	sb	a1,0(a0)
    16ee:	4705                	li	a4,1
    16f0:	00150e93          	addi	t4,a0,1
    16f4:	14e78c63          	beq	a5,a4,184c <memset+0x186>
    16f8:	00b500a3          	sb	a1,1(a0)
    16fc:	4709                	li	a4,2
    16fe:	00250e93          	addi	t4,a0,2
    1702:	14e78d63          	beq	a5,a4,185c <memset+0x196>
    1706:	00b50123          	sb	a1,2(a0)
    170a:	470d                	li	a4,3
    170c:	00350e93          	addi	t4,a0,3
    1710:	12e78b63          	beq	a5,a4,1846 <memset+0x180>
    1714:	00b501a3          	sb	a1,3(a0)
    1718:	4711                	li	a4,4
    171a:	00450e93          	addi	t4,a0,4
    171e:	14e78163          	beq	a5,a4,1860 <memset+0x19a>
    1722:	00b50223          	sb	a1,4(a0)
    1726:	4715                	li	a4,5
    1728:	00550e93          	addi	t4,a0,5
    172c:	12e78c63          	beq	a5,a4,1864 <memset+0x19e>
    1730:	00b502a3          	sb	a1,5(a0)
    1734:	471d                	li	a4,7
    1736:	00650e93          	addi	t4,a0,6
    173a:	12e79763          	bne	a5,a4,1868 <memset+0x1a2>
    173e:	00750e93          	addi	t4,a0,7
    1742:	00b50323          	sb	a1,6(a0)
    1746:	4f1d                	li	t5,7
    1748:	00859713          	slli	a4,a1,0x8
    174c:	8f4d                	or	a4,a4,a1
    174e:	01059e13          	slli	t3,a1,0x10
    1752:	01c76e33          	or	t3,a4,t3
    1756:	01859313          	slli	t1,a1,0x18
    175a:	006e6333          	or	t1,t3,t1
    175e:	02059893          	slli	a7,a1,0x20
    1762:	011368b3          	or	a7,t1,a7
    1766:	02859813          	slli	a6,a1,0x28
    176a:	40f60333          	sub	t1,a2,a5
    176e:	0108e833          	or	a6,a7,a6
    1772:	03059693          	slli	a3,a1,0x30
    1776:	00d866b3          	or	a3,a6,a3
    177a:	03859713          	slli	a4,a1,0x38
    177e:	97aa                	add	a5,a5,a0
    1780:	ff837813          	andi	a6,t1,-8
    1784:	8f55                	or	a4,a4,a3
    1786:	00f806b3          	add	a3,a6,a5
    178a:	e398                	sd	a4,0(a5)
    178c:	07a1                	addi	a5,a5,8
    178e:	fed79ee3          	bne	a5,a3,178a <memset+0xc4>
    1792:	ff837693          	andi	a3,t1,-8
    1796:	00de87b3          	add	a5,t4,a3
    179a:	01e6873b          	addw	a4,a3,t5
    179e:	0ad30663          	beq	t1,a3,184a <memset+0x184>
    17a2:	00b78023          	sb	a1,0(a5)
    17a6:	0017069b          	addiw	a3,a4,1
    17aa:	08c6fb63          	bgeu	a3,a2,1840 <memset+0x17a>
    17ae:	00b780a3          	sb	a1,1(a5)
    17b2:	0027069b          	addiw	a3,a4,2
    17b6:	08c6f563          	bgeu	a3,a2,1840 <memset+0x17a>
    17ba:	00b78123          	sb	a1,2(a5)
    17be:	0037069b          	addiw	a3,a4,3
    17c2:	06c6ff63          	bgeu	a3,a2,1840 <memset+0x17a>
    17c6:	00b781a3          	sb	a1,3(a5)
    17ca:	0047069b          	addiw	a3,a4,4
    17ce:	06c6f963          	bgeu	a3,a2,1840 <memset+0x17a>
    17d2:	00b78223          	sb	a1,4(a5)
    17d6:	0057069b          	addiw	a3,a4,5
    17da:	06c6f363          	bgeu	a3,a2,1840 <memset+0x17a>
    17de:	00b782a3          	sb	a1,5(a5)
    17e2:	0067069b          	addiw	a3,a4,6
    17e6:	04c6fd63          	bgeu	a3,a2,1840 <memset+0x17a>
    17ea:	00b78323          	sb	a1,6(a5)
    17ee:	0077069b          	addiw	a3,a4,7
    17f2:	04c6f763          	bgeu	a3,a2,1840 <memset+0x17a>
    17f6:	00b783a3          	sb	a1,7(a5)
    17fa:	0087069b          	addiw	a3,a4,8
    17fe:	04c6f163          	bgeu	a3,a2,1840 <memset+0x17a>
    1802:	00b78423          	sb	a1,8(a5)
    1806:	0097069b          	addiw	a3,a4,9
    180a:	02c6fb63          	bgeu	a3,a2,1840 <memset+0x17a>
    180e:	00b784a3          	sb	a1,9(a5)
    1812:	00a7069b          	addiw	a3,a4,10
    1816:	02c6f563          	bgeu	a3,a2,1840 <memset+0x17a>
    181a:	00b78523          	sb	a1,10(a5)
    181e:	00b7069b          	addiw	a3,a4,11
    1822:	00c6ff63          	bgeu	a3,a2,1840 <memset+0x17a>
    1826:	00b785a3          	sb	a1,11(a5)
    182a:	00c7069b          	addiw	a3,a4,12
    182e:	00c6f963          	bgeu	a3,a2,1840 <memset+0x17a>
    1832:	00b78623          	sb	a1,12(a5)
    1836:	2735                	addiw	a4,a4,13
    1838:	00c77463          	bgeu	a4,a2,1840 <memset+0x17a>
    183c:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1840:	8082                	ret
    1842:	472d                	li	a4,11
    1844:	bd79                	j	16e2 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1846:	4f0d                	li	t5,3
    1848:	b701                	j	1748 <memset+0x82>
    184a:	8082                	ret
    184c:	4f05                	li	t5,1
    184e:	bded                	j	1748 <memset+0x82>
    1850:	8eaa                	mv	t4,a0
    1852:	4f01                	li	t5,0
    1854:	bdd5                	j	1748 <memset+0x82>
    1856:	87aa                	mv	a5,a0
    1858:	4701                	li	a4,0
    185a:	b7a1                	j	17a2 <memset+0xdc>
    185c:	4f09                	li	t5,2
    185e:	b5ed                	j	1748 <memset+0x82>
    1860:	4f11                	li	t5,4
    1862:	b5dd                	j	1748 <memset+0x82>
    1864:	4f15                	li	t5,5
    1866:	b5cd                	j	1748 <memset+0x82>
    1868:	4f19                	li	t5,6
    186a:	bdf9                	j	1748 <memset+0x82>

000000000000186c <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    186c:	00054783          	lbu	a5,0(a0)
    1870:	0005c703          	lbu	a4,0(a1)
    1874:	00e79863          	bne	a5,a4,1884 <strcmp+0x18>
    1878:	0505                	addi	a0,a0,1
    187a:	0585                	addi	a1,a1,1
    187c:	fbe5                	bnez	a5,186c <strcmp>
    187e:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1880:	9d19                	subw	a0,a0,a4
    1882:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1884:	0007851b          	sext.w	a0,a5
    1888:	bfe5                	j	1880 <strcmp+0x14>

000000000000188a <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    188a:	ce05                	beqz	a2,18c2 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    188c:	00054703          	lbu	a4,0(a0)
    1890:	0005c783          	lbu	a5,0(a1)
    1894:	cb0d                	beqz	a4,18c6 <strncmp+0x3c>
    if (!n--)
    1896:	167d                	addi	a2,a2,-1
    1898:	00c506b3          	add	a3,a0,a2
    189c:	a819                	j	18b2 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    189e:	00a68e63          	beq	a3,a0,18ba <strncmp+0x30>
    18a2:	0505                	addi	a0,a0,1
    18a4:	00e79b63          	bne	a5,a4,18ba <strncmp+0x30>
    18a8:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18ac:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18b0:	cb19                	beqz	a4,18c6 <strncmp+0x3c>
    18b2:	0005c783          	lbu	a5,0(a1)
    18b6:	0585                	addi	a1,a1,1
    18b8:	f3fd                	bnez	a5,189e <strncmp+0x14>
    return *l - *r;
    18ba:	0007051b          	sext.w	a0,a4
    18be:	9d1d                	subw	a0,a0,a5
    18c0:	8082                	ret
        return 0;
    18c2:	4501                	li	a0,0
}
    18c4:	8082                	ret
    18c6:	4501                	li	a0,0
    return *l - *r;
    18c8:	9d1d                	subw	a0,a0,a5
    18ca:	8082                	ret

00000000000018cc <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18cc:	00757793          	andi	a5,a0,7
    18d0:	cf89                	beqz	a5,18ea <strlen+0x1e>
    18d2:	87aa                	mv	a5,a0
    18d4:	a029                	j	18de <strlen+0x12>
    18d6:	0785                	addi	a5,a5,1
    18d8:	0077f713          	andi	a4,a5,7
    18dc:	cb01                	beqz	a4,18ec <strlen+0x20>
        if (!*s)
    18de:	0007c703          	lbu	a4,0(a5)
    18e2:	fb75                	bnez	a4,18d6 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18e4:	40a78533          	sub	a0,a5,a0
}
    18e8:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18ea:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18ec:	6394                	ld	a3,0(a5)
    18ee:	00000597          	auipc	a1,0x0
    18f2:	6ca5b583          	ld	a1,1738(a1) # 1fb8 <__clone+0xd0>
    18f6:	00000617          	auipc	a2,0x0
    18fa:	6ca63603          	ld	a2,1738(a2) # 1fc0 <__clone+0xd8>
    18fe:	a019                	j	1904 <strlen+0x38>
    1900:	6794                	ld	a3,8(a5)
    1902:	07a1                	addi	a5,a5,8
    1904:	00b68733          	add	a4,a3,a1
    1908:	fff6c693          	not	a3,a3
    190c:	8f75                	and	a4,a4,a3
    190e:	8f71                	and	a4,a4,a2
    1910:	db65                	beqz	a4,1900 <strlen+0x34>
    for (; *s; s++)
    1912:	0007c703          	lbu	a4,0(a5)
    1916:	d779                	beqz	a4,18e4 <strlen+0x18>
    1918:	0017c703          	lbu	a4,1(a5)
    191c:	0785                	addi	a5,a5,1
    191e:	d379                	beqz	a4,18e4 <strlen+0x18>
    1920:	0017c703          	lbu	a4,1(a5)
    1924:	0785                	addi	a5,a5,1
    1926:	fb6d                	bnez	a4,1918 <strlen+0x4c>
    1928:	bf75                	j	18e4 <strlen+0x18>

000000000000192a <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    192a:	00757713          	andi	a4,a0,7
{
    192e:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1930:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1934:	cb19                	beqz	a4,194a <memchr+0x20>
    1936:	ce25                	beqz	a2,19ae <memchr+0x84>
    1938:	0007c703          	lbu	a4,0(a5)
    193c:	04b70e63          	beq	a4,a1,1998 <memchr+0x6e>
    1940:	0785                	addi	a5,a5,1
    1942:	0077f713          	andi	a4,a5,7
    1946:	167d                	addi	a2,a2,-1
    1948:	f77d                	bnez	a4,1936 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    194a:	4501                	li	a0,0
    if (n && *s != c)
    194c:	c235                	beqz	a2,19b0 <memchr+0x86>
    194e:	0007c703          	lbu	a4,0(a5)
    1952:	04b70363          	beq	a4,a1,1998 <memchr+0x6e>
        size_t k = ONES * c;
    1956:	00000517          	auipc	a0,0x0
    195a:	67253503          	ld	a0,1650(a0) # 1fc8 <__clone+0xe0>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    195e:	471d                	li	a4,7
        size_t k = ONES * c;
    1960:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1964:	02c77a63          	bgeu	a4,a2,1998 <memchr+0x6e>
    1968:	00000897          	auipc	a7,0x0
    196c:	6508b883          	ld	a7,1616(a7) # 1fb8 <__clone+0xd0>
    1970:	00000817          	auipc	a6,0x0
    1974:	65083803          	ld	a6,1616(a6) # 1fc0 <__clone+0xd8>
    1978:	431d                	li	t1,7
    197a:	a029                	j	1984 <memchr+0x5a>
    197c:	1661                	addi	a2,a2,-8
    197e:	07a1                	addi	a5,a5,8
    1980:	02c37963          	bgeu	t1,a2,19b2 <memchr+0x88>
    1984:	6398                	ld	a4,0(a5)
    1986:	8f29                	xor	a4,a4,a0
    1988:	011706b3          	add	a3,a4,a7
    198c:	fff74713          	not	a4,a4
    1990:	8f75                	and	a4,a4,a3
    1992:	01077733          	and	a4,a4,a6
    1996:	d37d                	beqz	a4,197c <memchr+0x52>
    1998:	853e                	mv	a0,a5
    199a:	97b2                	add	a5,a5,a2
    199c:	a021                	j	19a4 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    199e:	0505                	addi	a0,a0,1
    19a0:	00f50763          	beq	a0,a5,19ae <memchr+0x84>
    19a4:	00054703          	lbu	a4,0(a0)
    19a8:	feb71be3          	bne	a4,a1,199e <memchr+0x74>
    19ac:	8082                	ret
    return n ? (void *)s : 0;
    19ae:	4501                	li	a0,0
}
    19b0:	8082                	ret
    return n ? (void *)s : 0;
    19b2:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19b4:	f275                	bnez	a2,1998 <memchr+0x6e>
}
    19b6:	8082                	ret

00000000000019b8 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19b8:	1101                	addi	sp,sp,-32
    19ba:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19bc:	862e                	mv	a2,a1
{
    19be:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19c0:	4581                	li	a1,0
{
    19c2:	e426                	sd	s1,8(sp)
    19c4:	ec06                	sd	ra,24(sp)
    19c6:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19c8:	f63ff0ef          	jal	192a <memchr>
    return p ? p - s : n;
    19cc:	c519                	beqz	a0,19da <strnlen+0x22>
}
    19ce:	60e2                	ld	ra,24(sp)
    19d0:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19d2:	8d05                	sub	a0,a0,s1
}
    19d4:	64a2                	ld	s1,8(sp)
    19d6:	6105                	addi	sp,sp,32
    19d8:	8082                	ret
    19da:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19dc:	8522                	mv	a0,s0
}
    19de:	6442                	ld	s0,16(sp)
    19e0:	64a2                	ld	s1,8(sp)
    19e2:	6105                	addi	sp,sp,32
    19e4:	8082                	ret

00000000000019e6 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19e6:	00b547b3          	xor	a5,a0,a1
    19ea:	8b9d                	andi	a5,a5,7
    19ec:	eb95                	bnez	a5,1a20 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19ee:	0075f793          	andi	a5,a1,7
    19f2:	e7b1                	bnez	a5,1a3e <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19f4:	6198                	ld	a4,0(a1)
    19f6:	00000617          	auipc	a2,0x0
    19fa:	5c263603          	ld	a2,1474(a2) # 1fb8 <__clone+0xd0>
    19fe:	00000817          	auipc	a6,0x0
    1a02:	5c283803          	ld	a6,1474(a6) # 1fc0 <__clone+0xd8>
    1a06:	a029                	j	1a10 <strcpy+0x2a>
    1a08:	e118                	sd	a4,0(a0)
    1a0a:	6598                	ld	a4,8(a1)
    1a0c:	05a1                	addi	a1,a1,8
    1a0e:	0521                	addi	a0,a0,8
    1a10:	00c707b3          	add	a5,a4,a2
    1a14:	fff74693          	not	a3,a4
    1a18:	8ff5                	and	a5,a5,a3
    1a1a:	0107f7b3          	and	a5,a5,a6
    1a1e:	d7ed                	beqz	a5,1a08 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a20:	0005c783          	lbu	a5,0(a1)
    1a24:	00f50023          	sb	a5,0(a0)
    1a28:	c785                	beqz	a5,1a50 <strcpy+0x6a>
    1a2a:	0015c783          	lbu	a5,1(a1)
    1a2e:	0505                	addi	a0,a0,1
    1a30:	0585                	addi	a1,a1,1
    1a32:	00f50023          	sb	a5,0(a0)
    1a36:	fbf5                	bnez	a5,1a2a <strcpy+0x44>
        ;
    return d;
}
    1a38:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a3a:	0505                	addi	a0,a0,1
    1a3c:	df45                	beqz	a4,19f4 <strcpy+0xe>
            if (!(*d = *s))
    1a3e:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a42:	0585                	addi	a1,a1,1
    1a44:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a48:	00f50023          	sb	a5,0(a0)
    1a4c:	f7fd                	bnez	a5,1a3a <strcpy+0x54>
}
    1a4e:	8082                	ret
    1a50:	8082                	ret

0000000000001a52 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a52:	00b547b3          	xor	a5,a0,a1
    1a56:	8b9d                	andi	a5,a5,7
    1a58:	1a079863          	bnez	a5,1c08 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a5c:	0075f793          	andi	a5,a1,7
    1a60:	16078463          	beqz	a5,1bc8 <strncpy+0x176>
    1a64:	ea01                	bnez	a2,1a74 <strncpy+0x22>
    1a66:	a421                	j	1c6e <strncpy+0x21c>
    1a68:	167d                	addi	a2,a2,-1
    1a6a:	0505                	addi	a0,a0,1
    1a6c:	14070e63          	beqz	a4,1bc8 <strncpy+0x176>
    1a70:	1a060863          	beqz	a2,1c20 <strncpy+0x1ce>
    1a74:	0005c783          	lbu	a5,0(a1)
    1a78:	0585                	addi	a1,a1,1
    1a7a:	0075f713          	andi	a4,a1,7
    1a7e:	00f50023          	sb	a5,0(a0)
    1a82:	f3fd                	bnez	a5,1a68 <strncpy+0x16>
    1a84:	4805                	li	a6,1
    1a86:	1a061863          	bnez	a2,1c36 <strncpy+0x1e4>
    1a8a:	40a007b3          	neg	a5,a0
    1a8e:	8b9d                	andi	a5,a5,7
    1a90:	4681                	li	a3,0
    1a92:	18061a63          	bnez	a2,1c26 <strncpy+0x1d4>
    1a96:	00778713          	addi	a4,a5,7
    1a9a:	45ad                	li	a1,11
    1a9c:	18b76363          	bltu	a4,a1,1c22 <strncpy+0x1d0>
    1aa0:	1ae6eb63          	bltu	a3,a4,1c56 <strncpy+0x204>
    1aa4:	1a078363          	beqz	a5,1c4a <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1aa8:	00050023          	sb	zero,0(a0)
    1aac:	4685                	li	a3,1
    1aae:	00150713          	addi	a4,a0,1
    1ab2:	18d78f63          	beq	a5,a3,1c50 <strncpy+0x1fe>
    1ab6:	000500a3          	sb	zero,1(a0)
    1aba:	4689                	li	a3,2
    1abc:	00250713          	addi	a4,a0,2
    1ac0:	18d78e63          	beq	a5,a3,1c5c <strncpy+0x20a>
    1ac4:	00050123          	sb	zero,2(a0)
    1ac8:	468d                	li	a3,3
    1aca:	00350713          	addi	a4,a0,3
    1ace:	16d78c63          	beq	a5,a3,1c46 <strncpy+0x1f4>
    1ad2:	000501a3          	sb	zero,3(a0)
    1ad6:	4691                	li	a3,4
    1ad8:	00450713          	addi	a4,a0,4
    1adc:	18d78263          	beq	a5,a3,1c60 <strncpy+0x20e>
    1ae0:	00050223          	sb	zero,4(a0)
    1ae4:	4695                	li	a3,5
    1ae6:	00550713          	addi	a4,a0,5
    1aea:	16d78d63          	beq	a5,a3,1c64 <strncpy+0x212>
    1aee:	000502a3          	sb	zero,5(a0)
    1af2:	469d                	li	a3,7
    1af4:	00650713          	addi	a4,a0,6
    1af8:	16d79863          	bne	a5,a3,1c68 <strncpy+0x216>
    1afc:	00750713          	addi	a4,a0,7
    1b00:	00050323          	sb	zero,6(a0)
    1b04:	40f80833          	sub	a6,a6,a5
    1b08:	ff887593          	andi	a1,a6,-8
    1b0c:	97aa                	add	a5,a5,a0
    1b0e:	95be                	add	a1,a1,a5
    1b10:	0007b023          	sd	zero,0(a5)
    1b14:	07a1                	addi	a5,a5,8
    1b16:	feb79de3          	bne	a5,a1,1b10 <strncpy+0xbe>
    1b1a:	ff887593          	andi	a1,a6,-8
    1b1e:	9ead                	addw	a3,a3,a1
    1b20:	00b707b3          	add	a5,a4,a1
    1b24:	12b80863          	beq	a6,a1,1c54 <strncpy+0x202>
    1b28:	00078023          	sb	zero,0(a5)
    1b2c:	0016871b          	addiw	a4,a3,1
    1b30:	0ec77863          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1b34:	000780a3          	sb	zero,1(a5)
    1b38:	0026871b          	addiw	a4,a3,2
    1b3c:	0ec77263          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1b40:	00078123          	sb	zero,2(a5)
    1b44:	0036871b          	addiw	a4,a3,3
    1b48:	0cc77c63          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1b4c:	000781a3          	sb	zero,3(a5)
    1b50:	0046871b          	addiw	a4,a3,4
    1b54:	0cc77663          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1b58:	00078223          	sb	zero,4(a5)
    1b5c:	0056871b          	addiw	a4,a3,5
    1b60:	0cc77063          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1b64:	000782a3          	sb	zero,5(a5)
    1b68:	0066871b          	addiw	a4,a3,6
    1b6c:	0ac77a63          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1b70:	00078323          	sb	zero,6(a5)
    1b74:	0076871b          	addiw	a4,a3,7
    1b78:	0ac77463          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1b7c:	000783a3          	sb	zero,7(a5)
    1b80:	0086871b          	addiw	a4,a3,8
    1b84:	08c77e63          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1b88:	00078423          	sb	zero,8(a5)
    1b8c:	0096871b          	addiw	a4,a3,9
    1b90:	08c77863          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1b94:	000784a3          	sb	zero,9(a5)
    1b98:	00a6871b          	addiw	a4,a3,10
    1b9c:	08c77263          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1ba0:	00078523          	sb	zero,10(a5)
    1ba4:	00b6871b          	addiw	a4,a3,11
    1ba8:	06c77c63          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1bac:	000785a3          	sb	zero,11(a5)
    1bb0:	00c6871b          	addiw	a4,a3,12
    1bb4:	06c77663          	bgeu	a4,a2,1c20 <strncpy+0x1ce>
    1bb8:	00078623          	sb	zero,12(a5)
    1bbc:	26b5                	addiw	a3,a3,13
    1bbe:	06c6f163          	bgeu	a3,a2,1c20 <strncpy+0x1ce>
    1bc2:	000786a3          	sb	zero,13(a5)
    1bc6:	8082                	ret
            ;
        if (!n || !*s)
    1bc8:	c645                	beqz	a2,1c70 <strncpy+0x21e>
    1bca:	0005c783          	lbu	a5,0(a1)
    1bce:	ea078be3          	beqz	a5,1a84 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bd2:	479d                	li	a5,7
    1bd4:	02c7ff63          	bgeu	a5,a2,1c12 <strncpy+0x1c0>
    1bd8:	00000897          	auipc	a7,0x0
    1bdc:	3e08b883          	ld	a7,992(a7) # 1fb8 <__clone+0xd0>
    1be0:	00000817          	auipc	a6,0x0
    1be4:	3e083803          	ld	a6,992(a6) # 1fc0 <__clone+0xd8>
    1be8:	431d                	li	t1,7
    1bea:	6198                	ld	a4,0(a1)
    1bec:	011707b3          	add	a5,a4,a7
    1bf0:	fff74693          	not	a3,a4
    1bf4:	8ff5                	and	a5,a5,a3
    1bf6:	0107f7b3          	and	a5,a5,a6
    1bfa:	ef81                	bnez	a5,1c12 <strncpy+0x1c0>
            *wd = *ws;
    1bfc:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bfe:	1661                	addi	a2,a2,-8
    1c00:	05a1                	addi	a1,a1,8
    1c02:	0521                	addi	a0,a0,8
    1c04:	fec363e3          	bltu	t1,a2,1bea <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c08:	e609                	bnez	a2,1c12 <strncpy+0x1c0>
    1c0a:	a08d                	j	1c6c <strncpy+0x21a>
    1c0c:	167d                	addi	a2,a2,-1
    1c0e:	0505                	addi	a0,a0,1
    1c10:	ca01                	beqz	a2,1c20 <strncpy+0x1ce>
    1c12:	0005c783          	lbu	a5,0(a1)
    1c16:	0585                	addi	a1,a1,1
    1c18:	00f50023          	sb	a5,0(a0)
    1c1c:	fbe5                	bnez	a5,1c0c <strncpy+0x1ba>
        ;
tail:
    1c1e:	b59d                	j	1a84 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c20:	8082                	ret
    1c22:	472d                	li	a4,11
    1c24:	bdb5                	j	1aa0 <strncpy+0x4e>
    1c26:	00778713          	addi	a4,a5,7
    1c2a:	45ad                	li	a1,11
    1c2c:	fff60693          	addi	a3,a2,-1
    1c30:	e6b778e3          	bgeu	a4,a1,1aa0 <strncpy+0x4e>
    1c34:	b7fd                	j	1c22 <strncpy+0x1d0>
    1c36:	40a007b3          	neg	a5,a0
    1c3a:	8832                	mv	a6,a2
    1c3c:	8b9d                	andi	a5,a5,7
    1c3e:	4681                	li	a3,0
    1c40:	e4060be3          	beqz	a2,1a96 <strncpy+0x44>
    1c44:	b7cd                	j	1c26 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c46:	468d                	li	a3,3
    1c48:	bd75                	j	1b04 <strncpy+0xb2>
    1c4a:	872a                	mv	a4,a0
    1c4c:	4681                	li	a3,0
    1c4e:	bd5d                	j	1b04 <strncpy+0xb2>
    1c50:	4685                	li	a3,1
    1c52:	bd4d                	j	1b04 <strncpy+0xb2>
    1c54:	8082                	ret
    1c56:	87aa                	mv	a5,a0
    1c58:	4681                	li	a3,0
    1c5a:	b5f9                	j	1b28 <strncpy+0xd6>
    1c5c:	4689                	li	a3,2
    1c5e:	b55d                	j	1b04 <strncpy+0xb2>
    1c60:	4691                	li	a3,4
    1c62:	b54d                	j	1b04 <strncpy+0xb2>
    1c64:	4695                	li	a3,5
    1c66:	bd79                	j	1b04 <strncpy+0xb2>
    1c68:	4699                	li	a3,6
    1c6a:	bd69                	j	1b04 <strncpy+0xb2>
    1c6c:	8082                	ret
    1c6e:	8082                	ret
    1c70:	8082                	ret

0000000000001c72 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c72:	87aa                	mv	a5,a0
    1c74:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c76:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c7a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c7e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c80:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c82:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c86:	2501                	sext.w	a0,a0
    1c88:	8082                	ret

0000000000001c8a <openat>:
    register long a7 __asm__("a7") = n;
    1c8a:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c8e:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c92:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c96:	2501                	sext.w	a0,a0
    1c98:	8082                	ret

0000000000001c9a <close>:
    register long a7 __asm__("a7") = n;
    1c9a:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c9e:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1ca2:	2501                	sext.w	a0,a0
    1ca4:	8082                	ret

0000000000001ca6 <read>:
    register long a7 __asm__("a7") = n;
    1ca6:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1caa:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cae:	8082                	ret

0000000000001cb0 <write>:
    register long a7 __asm__("a7") = n;
    1cb0:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cb4:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cb8:	8082                	ret

0000000000001cba <getpid>:
    register long a7 __asm__("a7") = n;
    1cba:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cbe:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cc2:	2501                	sext.w	a0,a0
    1cc4:	8082                	ret

0000000000001cc6 <getppid>:
    register long a7 __asm__("a7") = n;
    1cc6:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cca:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cce:	2501                	sext.w	a0,a0
    1cd0:	8082                	ret

0000000000001cd2 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cd2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cd6:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cda:	2501                	sext.w	a0,a0
    1cdc:	8082                	ret

0000000000001cde <fork>:
    register long a7 __asm__("a7") = n;
    1cde:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1ce2:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1ce4:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ce6:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cea:	2501                	sext.w	a0,a0
    1cec:	8082                	ret

0000000000001cee <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cee:	85b2                	mv	a1,a2
    1cf0:	863a                	mv	a2,a4
    if (stack)
    1cf2:	c191                	beqz	a1,1cf6 <clone+0x8>
	stack += stack_size;
    1cf4:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cf6:	4781                	li	a5,0
    1cf8:	4701                	li	a4,0
    1cfa:	4681                	li	a3,0
    1cfc:	2601                	sext.w	a2,a2
    1cfe:	a2ed                	j	1ee8 <__clone>

0000000000001d00 <exit>:
    register long a7 __asm__("a7") = n;
    1d00:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d04:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d08:	8082                	ret

0000000000001d0a <waitpid>:
    register long a7 __asm__("a7") = n;
    1d0a:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d0e:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d10:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d14:	2501                	sext.w	a0,a0
    1d16:	8082                	ret

0000000000001d18 <exec>:
    register long a7 __asm__("a7") = n;
    1d18:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d1c:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d20:	2501                	sext.w	a0,a0
    1d22:	8082                	ret

0000000000001d24 <execve>:
    register long a7 __asm__("a7") = n;
    1d24:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d28:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d2c:	2501                	sext.w	a0,a0
    1d2e:	8082                	ret

0000000000001d30 <times>:
    register long a7 __asm__("a7") = n;
    1d30:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d34:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d38:	2501                	sext.w	a0,a0
    1d3a:	8082                	ret

0000000000001d3c <get_time>:

int64 get_time()
{
    1d3c:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d3e:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d42:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d44:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d46:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d4a:	2501                	sext.w	a0,a0
    1d4c:	ed09                	bnez	a0,1d66 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d4e:	67a2                	ld	a5,8(sp)
    1d50:	3e800713          	li	a4,1000
    1d54:	00015503          	lhu	a0,0(sp)
    1d58:	02e7d7b3          	divu	a5,a5,a4
    1d5c:	02e50533          	mul	a0,a0,a4
    1d60:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d62:	0141                	addi	sp,sp,16
    1d64:	8082                	ret
        return -1;
    1d66:	557d                	li	a0,-1
    1d68:	bfed                	j	1d62 <get_time+0x26>

0000000000001d6a <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d6a:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d6e:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d72:	2501                	sext.w	a0,a0
    1d74:	8082                	ret

0000000000001d76 <time>:
    register long a7 __asm__("a7") = n;
    1d76:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d7a:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d7e:	2501                	sext.w	a0,a0
    1d80:	8082                	ret

0000000000001d82 <sleep>:

int sleep(unsigned long long time)
{
    1d82:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d84:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d86:	850a                	mv	a0,sp
    1d88:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d8a:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d8e:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d90:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d94:	e501                	bnez	a0,1d9c <sleep+0x1a>
    return 0;
    1d96:	4501                	li	a0,0
}
    1d98:	0141                	addi	sp,sp,16
    1d9a:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d9c:	4502                	lw	a0,0(sp)
}
    1d9e:	0141                	addi	sp,sp,16
    1da0:	8082                	ret

0000000000001da2 <set_priority>:
    register long a7 __asm__("a7") = n;
    1da2:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1da6:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1daa:	2501                	sext.w	a0,a0
    1dac:	8082                	ret

0000000000001dae <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1dae:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1db2:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1db6:	8082                	ret

0000000000001db8 <munmap>:
    register long a7 __asm__("a7") = n;
    1db8:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dbc:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1dc0:	2501                	sext.w	a0,a0
    1dc2:	8082                	ret

0000000000001dc4 <wait>:

int wait(int *code)
{
    1dc4:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dc6:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1dca:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1dcc:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dce:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dd0:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dd4:	2501                	sext.w	a0,a0
    1dd6:	8082                	ret

0000000000001dd8 <spawn>:
    register long a7 __asm__("a7") = n;
    1dd8:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1ddc:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1de0:	2501                	sext.w	a0,a0
    1de2:	8082                	ret

0000000000001de4 <mailread>:
    register long a7 __asm__("a7") = n;
    1de4:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1de8:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dec:	2501                	sext.w	a0,a0
    1dee:	8082                	ret

0000000000001df0 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1df0:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1df4:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1df8:	2501                	sext.w	a0,a0
    1dfa:	8082                	ret

0000000000001dfc <fstat>:
    register long a7 __asm__("a7") = n;
    1dfc:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e00:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e04:	2501                	sext.w	a0,a0
    1e06:	8082                	ret

0000000000001e08 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e08:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e0a:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e0e:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e10:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e14:	2501                	sext.w	a0,a0
    1e16:	8082                	ret

0000000000001e18 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e18:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e1a:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e1e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e20:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e24:	2501                	sext.w	a0,a0
    1e26:	8082                	ret

0000000000001e28 <link>:

int link(char *old_path, char *new_path)
{
    1e28:	87aa                	mv	a5,a0
    1e2a:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e2c:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e30:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e34:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e36:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e3a:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e3c:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e40:	2501                	sext.w	a0,a0
    1e42:	8082                	ret

0000000000001e44 <unlink>:

int unlink(char *path)
{
    1e44:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e46:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e4a:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e4e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e50:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e54:	2501                	sext.w	a0,a0
    1e56:	8082                	ret

0000000000001e58 <uname>:
    register long a7 __asm__("a7") = n;
    1e58:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e5c:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e60:	2501                	sext.w	a0,a0
    1e62:	8082                	ret

0000000000001e64 <brk>:
    register long a7 __asm__("a7") = n;
    1e64:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e68:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e6c:	2501                	sext.w	a0,a0
    1e6e:	8082                	ret

0000000000001e70 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e70:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e72:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e76:	8082                	ret

0000000000001e78 <chdir>:
    register long a7 __asm__("a7") = n;
    1e78:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e7c:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e80:	2501                	sext.w	a0,a0
    1e82:	8082                	ret

0000000000001e84 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e84:	862e                	mv	a2,a1
    1e86:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e88:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e8a:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e8e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e92:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e94:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e96:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e9a:	2501                	sext.w	a0,a0
    1e9c:	8082                	ret

0000000000001e9e <getdents>:
    register long a7 __asm__("a7") = n;
    1e9e:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ea2:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ea6:	2501                	sext.w	a0,a0
    1ea8:	8082                	ret

0000000000001eaa <pipe>:
    register long a7 __asm__("a7") = n;
    1eaa:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1eae:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eb0:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1eb4:	2501                	sext.w	a0,a0
    1eb6:	8082                	ret

0000000000001eb8 <dup>:
    register long a7 __asm__("a7") = n;
    1eb8:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1eba:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1ebe:	2501                	sext.w	a0,a0
    1ec0:	8082                	ret

0000000000001ec2 <dup2>:
    register long a7 __asm__("a7") = n;
    1ec2:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ec4:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ec6:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1eca:	2501                	sext.w	a0,a0
    1ecc:	8082                	ret

0000000000001ece <mount>:
    register long a7 __asm__("a7") = n;
    1ece:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ed2:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ed6:	2501                	sext.w	a0,a0
    1ed8:	8082                	ret

0000000000001eda <umount>:
    register long a7 __asm__("a7") = n;
    1eda:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ede:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ee0:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ee4:	2501                	sext.w	a0,a0
    1ee6:	8082                	ret

0000000000001ee8 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ee8:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1eea:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1eec:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1eee:	8532                	mv	a0,a2
	mv a2, a4
    1ef0:	863a                	mv	a2,a4
	mv a3, a5
    1ef2:	86be                	mv	a3,a5
	mv a4, a6
    1ef4:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ef6:	0dc00893          	li	a7,220
	ecall
    1efa:	00000073          	ecall

	beqz a0, 1f
    1efe:	c111                	beqz	a0,1f02 <__clone+0x1a>
	# Parent
	ret
    1f00:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f02:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f04:	6522                	ld	a0,8(sp)
	jalr a1
    1f06:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f08:	05d00893          	li	a7,93
	ecall
    1f0c:	00000073          	ecall
