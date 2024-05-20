
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/chdir:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a0c9                	j	10c4 <__start_main>

0000000000001004 <test_chdir>:
#include "stdio.h"
#include "stdlib.h"
#include "unistd.h"

static char buffer[30];
void test_chdir(void){
    1004:	1141                	addi	sp,sp,-16
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f0250513          	addi	a0,a0,-254 # 1f08 <__clone+0x2c>
void test_chdir(void){
    100e:	e406                	sd	ra,8(sp)
    1010:	e022                	sd	s0,0(sp)
    TEST_START(__func__);
    1012:	324000ef          	jal	1336 <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	fca50513          	addi	a0,a0,-54 # 1fe0 <__func__.0>
    101e:	318000ef          	jal	1336 <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	efe50513          	addi	a0,a0,-258 # 1f20 <__clone+0x44>
    102a:	30c000ef          	jal	1336 <puts>
    mkdir("test_chdir", 0666);
    102e:	1b600593          	li	a1,438
    1032:	00001517          	auipc	a0,0x1
    1036:	efe50513          	addi	a0,a0,-258 # 1f30 <__clone+0x54>
    103a:	63f000ef          	jal	1e78 <mkdir>
    int ret = chdir("test_chdir");
    103e:	00001517          	auipc	a0,0x1
    1042:	ef250513          	addi	a0,a0,-270 # 1f30 <__clone+0x54>
    1046:	627000ef          	jal	1e6c <chdir>
    104a:	842a                	mv	s0,a0
    printf("chdir ret: %d\n", ret);
    104c:	85aa                	mv	a1,a0
    104e:	00001517          	auipc	a0,0x1
    1052:	ef250513          	addi	a0,a0,-270 # 1f40 <__clone+0x64>
    1056:	302000ef          	jal	1358 <printf>
    assert(ret == 0);
    105a:	e431                	bnez	s0,10a6 <test_chdir+0xa2>
    getcwd(buffer, 30);
    105c:	45f9                	li	a1,30
    105e:	00001517          	auipc	a0,0x1
    1062:	f6250513          	addi	a0,a0,-158 # 1fc0 <buffer>
    1066:	5ff000ef          	jal	1e64 <getcwd>
    printf("  current working dir : %s\n", buffer);
    106a:	00001597          	auipc	a1,0x1
    106e:	f5658593          	addi	a1,a1,-170 # 1fc0 <buffer>
    1072:	00001517          	auipc	a0,0x1
    1076:	efe50513          	addi	a0,a0,-258 # 1f70 <__clone+0x94>
    107a:	2de000ef          	jal	1358 <printf>
    TEST_END(__func__);
    107e:	00001517          	auipc	a0,0x1
    1082:	f1250513          	addi	a0,a0,-238 # 1f90 <__clone+0xb4>
    1086:	2b0000ef          	jal	1336 <puts>
    108a:	00001517          	auipc	a0,0x1
    108e:	f5650513          	addi	a0,a0,-170 # 1fe0 <__func__.0>
    1092:	2a4000ef          	jal	1336 <puts>
}
    1096:	6402                	ld	s0,0(sp)
    1098:	60a2                	ld	ra,8(sp)
    TEST_END(__func__);
    109a:	00001517          	auipc	a0,0x1
    109e:	e8650513          	addi	a0,a0,-378 # 1f20 <__clone+0x44>
}
    10a2:	0141                	addi	sp,sp,16
    TEST_END(__func__);
    10a4:	ac49                	j	1336 <puts>
    assert(ret == 0);
    10a6:	00001517          	auipc	a0,0x1
    10aa:	eaa50513          	addi	a0,a0,-342 # 1f50 <__clone+0x74>
    10ae:	534000ef          	jal	15e2 <panic>
    10b2:	b76d                	j	105c <test_chdir+0x58>

00000000000010b4 <main>:

int main(void){
    10b4:	1141                	addi	sp,sp,-16
    10b6:	e406                	sd	ra,8(sp)
    test_chdir();
    10b8:	f4dff0ef          	jal	1004 <test_chdir>
    return 0;
}
    10bc:	60a2                	ld	ra,8(sp)
    10be:	4501                	li	a0,0
    10c0:	0141                	addi	sp,sp,16
    10c2:	8082                	ret

00000000000010c4 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10c4:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10c6:	4108                	lw	a0,0(a0)
{
    10c8:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10ca:	05a1                	addi	a1,a1,8
{
    10cc:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10ce:	fe7ff0ef          	jal	10b4 <main>
    10d2:	423000ef          	jal	1cf4 <exit>
	return 0;
}
    10d6:	60a2                	ld	ra,8(sp)
    10d8:	4501                	li	a0,0
    10da:	0141                	addi	sp,sp,16
    10dc:	8082                	ret

00000000000010de <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10de:	7179                	addi	sp,sp,-48
    10e0:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10e2:	12054b63          	bltz	a0,1218 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10e6:	02b577bb          	remuw	a5,a0,a1
    10ea:	00001617          	auipc	a2,0x1
    10ee:	f0660613          	addi	a2,a2,-250 # 1ff0 <digits>
    buf[16] = 0;
    10f2:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10f6:	0005871b          	sext.w	a4,a1
    10fa:	1782                	slli	a5,a5,0x20
    10fc:	9381                	srli	a5,a5,0x20
    10fe:	97b2                	add	a5,a5,a2
    1100:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1104:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1108:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    110c:	1cb56363          	bltu	a0,a1,12d2 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    1110:	45b9                	li	a1,14
    1112:	02e877bb          	remuw	a5,a6,a4
    1116:	1782                	slli	a5,a5,0x20
    1118:	9381                	srli	a5,a5,0x20
    111a:	97b2                	add	a5,a5,a2
    111c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1120:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    1124:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1128:	0ce86e63          	bltu	a6,a4,1204 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    112c:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1130:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    1134:	1582                	slli	a1,a1,0x20
    1136:	9181                	srli	a1,a1,0x20
    1138:	95b2                	add	a1,a1,a2
    113a:	0005c583          	lbu	a1,0(a1)
    113e:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    1142:	0007859b          	sext.w	a1,a5
    1146:	12e6ec63          	bltu	a3,a4,127e <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    114a:	02e7f6bb          	remuw	a3,a5,a4
    114e:	1682                	slli	a3,a3,0x20
    1150:	9281                	srli	a3,a3,0x20
    1152:	96b2                	add	a3,a3,a2
    1154:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1158:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    115c:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1160:	12e5e863          	bltu	a1,a4,1290 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    1164:	02e876bb          	remuw	a3,a6,a4
    1168:	1682                	slli	a3,a3,0x20
    116a:	9281                	srli	a3,a3,0x20
    116c:	96b2                	add	a3,a3,a2
    116e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1172:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1176:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    117a:	12e86463          	bltu	a6,a4,12a2 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    117e:	02e5f6bb          	remuw	a3,a1,a4
    1182:	1682                	slli	a3,a3,0x20
    1184:	9281                	srli	a3,a3,0x20
    1186:	96b2                	add	a3,a3,a2
    1188:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    118c:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1190:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    1194:	0ce5ec63          	bltu	a1,a4,126c <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    1198:	02e876bb          	remuw	a3,a6,a4
    119c:	1682                	slli	a3,a3,0x20
    119e:	9281                	srli	a3,a3,0x20
    11a0:	96b2                	add	a3,a3,a2
    11a2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11a6:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11aa:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11ae:	10e86963          	bltu	a6,a4,12c0 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11b2:	02e5f6bb          	remuw	a3,a1,a4
    11b6:	1682                	slli	a3,a3,0x20
    11b8:	9281                	srli	a3,a3,0x20
    11ba:	96b2                	add	a3,a3,a2
    11bc:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11c0:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11c4:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11c8:	10e5e763          	bltu	a1,a4,12d6 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11cc:	02e876bb          	remuw	a3,a6,a4
    11d0:	1682                	slli	a3,a3,0x20
    11d2:	9281                	srli	a3,a3,0x20
    11d4:	96b2                	add	a3,a3,a2
    11d6:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11da:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11de:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11e2:	10e86363          	bltu	a6,a4,12e8 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11e6:	1782                	slli	a5,a5,0x20
    11e8:	9381                	srli	a5,a5,0x20
    11ea:	97b2                	add	a5,a5,a2
    11ec:	0007c783          	lbu	a5,0(a5)
    11f0:	4599                	li	a1,6
    11f2:	00f10723          	sb	a5,14(sp)

    if (sign)
    11f6:	00055763          	bgez	a0,1204 <printint.constprop.0+0x126>
        buf[i--] = '-';
    11fa:	02d00793          	li	a5,45
    11fe:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    1202:	4595                	li	a1,5
    write(f, s, l);
    1204:	003c                	addi	a5,sp,8
    1206:	4641                	li	a2,16
    1208:	9e0d                	subw	a2,a2,a1
    120a:	4505                	li	a0,1
    120c:	95be                	add	a1,a1,a5
    120e:	297000ef          	jal	1ca4 <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1212:	70a2                	ld	ra,40(sp)
    1214:	6145                	addi	sp,sp,48
    1216:	8082                	ret
        x = -xx;
    1218:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    121c:	02b877bb          	remuw	a5,a6,a1
    1220:	00001617          	auipc	a2,0x1
    1224:	dd060613          	addi	a2,a2,-560 # 1ff0 <digits>
    buf[16] = 0;
    1228:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    122c:	0005871b          	sext.w	a4,a1
    1230:	1782                	slli	a5,a5,0x20
    1232:	9381                	srli	a5,a5,0x20
    1234:	97b2                	add	a5,a5,a2
    1236:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    123a:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    123e:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1242:	06b86963          	bltu	a6,a1,12b4 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1246:	02e8f7bb          	remuw	a5,a7,a4
    124a:	1782                	slli	a5,a5,0x20
    124c:	9381                	srli	a5,a5,0x20
    124e:	97b2                	add	a5,a5,a2
    1250:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1254:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1258:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    125c:	ece8f8e3          	bgeu	a7,a4,112c <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1260:	02d00793          	li	a5,45
    1264:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1268:	45b5                	li	a1,13
    126a:	bf69                	j	1204 <printint.constprop.0+0x126>
    126c:	45a9                	li	a1,10
    if (sign)
    126e:	f8055be3          	bgez	a0,1204 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1272:	02d00793          	li	a5,45
    1276:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    127a:	45a5                	li	a1,9
    127c:	b761                	j	1204 <printint.constprop.0+0x126>
    127e:	45b5                	li	a1,13
    if (sign)
    1280:	f80552e3          	bgez	a0,1204 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1284:	02d00793          	li	a5,45
    1288:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    128c:	45b1                	li	a1,12
    128e:	bf9d                	j	1204 <printint.constprop.0+0x126>
    1290:	45b1                	li	a1,12
    if (sign)
    1292:	f60559e3          	bgez	a0,1204 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1296:	02d00793          	li	a5,45
    129a:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    129e:	45ad                	li	a1,11
    12a0:	b795                	j	1204 <printint.constprop.0+0x126>
    12a2:	45ad                	li	a1,11
    if (sign)
    12a4:	f60550e3          	bgez	a0,1204 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12a8:	02d00793          	li	a5,45
    12ac:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12b0:	45a9                	li	a1,10
    12b2:	bf89                	j	1204 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b4:	02d00793          	li	a5,45
    12b8:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12bc:	45b9                	li	a1,14
    12be:	b799                	j	1204 <printint.constprop.0+0x126>
    12c0:	45a5                	li	a1,9
    if (sign)
    12c2:	f40551e3          	bgez	a0,1204 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c6:	02d00793          	li	a5,45
    12ca:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12ce:	45a1                	li	a1,8
    12d0:	bf15                	j	1204 <printint.constprop.0+0x126>
    i = 15;
    12d2:	45bd                	li	a1,15
    12d4:	bf05                	j	1204 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12d6:	45a1                	li	a1,8
    if (sign)
    12d8:	f20556e3          	bgez	a0,1204 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12dc:	02d00793          	li	a5,45
    12e0:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12e4:	459d                	li	a1,7
    12e6:	bf39                	j	1204 <printint.constprop.0+0x126>
    12e8:	459d                	li	a1,7
    if (sign)
    12ea:	f0055de3          	bgez	a0,1204 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12ee:	02d00793          	li	a5,45
    12f2:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12f6:	4599                	li	a1,6
    12f8:	b731                	j	1204 <printint.constprop.0+0x126>

00000000000012fa <getchar>:
{
    12fa:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12fc:	00f10593          	addi	a1,sp,15
    1300:	4605                	li	a2,1
    1302:	4501                	li	a0,0
{
    1304:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1306:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    130a:	191000ef          	jal	1c9a <read>
}
    130e:	60e2                	ld	ra,24(sp)
    1310:	00f14503          	lbu	a0,15(sp)
    1314:	6105                	addi	sp,sp,32
    1316:	8082                	ret

0000000000001318 <putchar>:
{
    1318:	1101                	addi	sp,sp,-32
    131a:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    131c:	00f10593          	addi	a1,sp,15
    1320:	4605                	li	a2,1
    1322:	4505                	li	a0,1
{
    1324:	ec06                	sd	ra,24(sp)
    char byte = c;
    1326:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    132a:	17b000ef          	jal	1ca4 <write>
}
    132e:	60e2                	ld	ra,24(sp)
    1330:	2501                	sext.w	a0,a0
    1332:	6105                	addi	sp,sp,32
    1334:	8082                	ret

0000000000001336 <puts>:
{
    1336:	1141                	addi	sp,sp,-16
    1338:	e406                	sd	ra,8(sp)
    133a:	e022                	sd	s0,0(sp)
    133c:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    133e:	582000ef          	jal	18c0 <strlen>
    1342:	862a                	mv	a2,a0
    1344:	85a2                	mv	a1,s0
    1346:	4505                	li	a0,1
    1348:	15d000ef          	jal	1ca4 <write>
}
    134c:	60a2                	ld	ra,8(sp)
    134e:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1350:	957d                	srai	a0,a0,0x3f
    return r;
    1352:	2501                	sext.w	a0,a0
}
    1354:	0141                	addi	sp,sp,16
    1356:	8082                	ret

0000000000001358 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1358:	7131                	addi	sp,sp,-192
    135a:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    135c:	013c                	addi	a5,sp,136
{
    135e:	f0ca                	sd	s2,96(sp)
    1360:	ecce                	sd	s3,88(sp)
    1362:	e8d2                	sd	s4,80(sp)
    1364:	e4d6                	sd	s5,72(sp)
    1366:	e0da                	sd	s6,64(sp)
    1368:	fc5e                	sd	s7,56(sp)
    136a:	fc86                	sd	ra,120(sp)
    136c:	f8a2                	sd	s0,112(sp)
    136e:	f4a6                	sd	s1,104(sp)
    1370:	e52e                	sd	a1,136(sp)
    1372:	e932                	sd	a2,144(sp)
    1374:	ed36                	sd	a3,152(sp)
    1376:	f13a                	sd	a4,160(sp)
    1378:	f942                	sd	a6,176(sp)
    137a:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    137c:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    137e:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    1382:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1386:	00001b97          	auipc	s7,0x1
    138a:	c1ab8b93          	addi	s7,s7,-998 # 1fa0 <__clone+0xc4>
        switch (s[1])
    138e:	07800a93          	li	s5,120
    1392:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1396:	00001997          	auipc	s3,0x1
    139a:	c5a98993          	addi	s3,s3,-934 # 1ff0 <digits>
        if (!*s)
    139e:	00054783          	lbu	a5,0(a0)
    13a2:	16078c63          	beqz	a5,151a <printf+0x1c2>
    13a6:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13a8:	19278463          	beq	a5,s2,1530 <printf+0x1d8>
    13ac:	00164783          	lbu	a5,1(a2)
    13b0:	0605                	addi	a2,a2,1
    13b2:	fbfd                	bnez	a5,13a8 <printf+0x50>
    13b4:	84b2                	mv	s1,a2
        l = z - a;
    13b6:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13ba:	85aa                	mv	a1,a0
    13bc:	8622                	mv	a2,s0
    13be:	4505                	li	a0,1
    13c0:	0e5000ef          	jal	1ca4 <write>
        if (l)
    13c4:	18041f63          	bnez	s0,1562 <printf+0x20a>
        if (s[1] == 0)
    13c8:	0014c783          	lbu	a5,1(s1)
    13cc:	14078763          	beqz	a5,151a <printf+0x1c2>
        switch (s[1])
    13d0:	1d478163          	beq	a5,s4,1592 <printf+0x23a>
    13d4:	18fa6963          	bltu	s4,a5,1566 <printf+0x20e>
    13d8:	1b678363          	beq	a5,s6,157e <printf+0x226>
    13dc:	07000713          	li	a4,112
    13e0:	1ce79c63          	bne	a5,a4,15b8 <printf+0x260>
            printptr(va_arg(ap, uint64));
    13e4:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13e6:	03000793          	li	a5,48
    13ea:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13ee:	631c                	ld	a5,0(a4)
    13f0:	0721                	addi	a4,a4,8
    13f2:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13f4:	00479f93          	slli	t6,a5,0x4
    13f8:	00879f13          	slli	t5,a5,0x8
    13fc:	00c79e93          	slli	t4,a5,0xc
    1400:	01079e13          	slli	t3,a5,0x10
    1404:	01479313          	slli	t1,a5,0x14
    1408:	01879893          	slli	a7,a5,0x18
    140c:	01c79713          	slli	a4,a5,0x1c
    1410:	02479813          	slli	a6,a5,0x24
    1414:	02879513          	slli	a0,a5,0x28
    1418:	02c79593          	slli	a1,a5,0x2c
    141c:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1420:	03c7d293          	srli	t0,a5,0x3c
    1424:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1428:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    142c:	03cfdf93          	srli	t6,t6,0x3c
    1430:	03cf5f13          	srli	t5,t5,0x3c
    1434:	03cede93          	srli	t4,t4,0x3c
    1438:	03ce5e13          	srli	t3,t3,0x3c
    143c:	03c35313          	srli	t1,t1,0x3c
    1440:	03c8d893          	srli	a7,a7,0x3c
    1444:	9371                	srli	a4,a4,0x3c
    1446:	03c85813          	srli	a6,a6,0x3c
    144a:	9171                	srli	a0,a0,0x3c
    144c:	91f1                	srli	a1,a1,0x3c
    144e:	9271                	srli	a2,a2,0x3c
    1450:	974e                	add	a4,a4,s3
    1452:	92f1                	srli	a3,a3,0x3c
    1454:	92ce                	add	t0,t0,s3
    1456:	9fce                	add	t6,t6,s3
    1458:	9f4e                	add	t5,t5,s3
    145a:	9ece                	add	t4,t4,s3
    145c:	9e4e                	add	t3,t3,s3
    145e:	934e                	add	t1,t1,s3
    1460:	98ce                	add	a7,a7,s3
    1462:	93ce                	add	t2,t2,s3
    1464:	984e                	add	a6,a6,s3
    1466:	954e                	add	a0,a0,s3
    1468:	95ce                	add	a1,a1,s3
    146a:	964e                	add	a2,a2,s3
    146c:	0002c283          	lbu	t0,0(t0)
    1470:	000fcf83          	lbu	t6,0(t6)
    1474:	000f4f03          	lbu	t5,0(t5)
    1478:	000ece83          	lbu	t4,0(t4)
    147c:	000e4e03          	lbu	t3,0(t3)
    1480:	00034303          	lbu	t1,0(t1)
    1484:	0008c883          	lbu	a7,0(a7)
    1488:	00074403          	lbu	s0,0(a4)
    148c:	0003c383          	lbu	t2,0(t2)
    1490:	00084803          	lbu	a6,0(a6)
    1494:	00054503          	lbu	a0,0(a0)
    1498:	0005c583          	lbu	a1,0(a1)
    149c:	00064603          	lbu	a2,0(a2)
    14a0:	00d98733          	add	a4,s3,a3
    14a4:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14a8:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ac:	9371                	srli	a4,a4,0x3c
    14ae:	8bbd                	andi	a5,a5,15
    14b0:	00510523          	sb	t0,10(sp)
    14b4:	01f105a3          	sb	t6,11(sp)
    14b8:	01e10623          	sb	t5,12(sp)
    14bc:	01d106a3          	sb	t4,13(sp)
    14c0:	01c10723          	sb	t3,14(sp)
    14c4:	006107a3          	sb	t1,15(sp)
    14c8:	01110823          	sb	a7,16(sp)
    14cc:	00710923          	sb	t2,18(sp)
    14d0:	010109a3          	sb	a6,19(sp)
    14d4:	00a10a23          	sb	a0,20(sp)
    14d8:	00b10aa3          	sb	a1,21(sp)
    14dc:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14e0:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14e4:	008108a3          	sb	s0,17(sp)
    14e8:	974e                	add	a4,a4,s3
    14ea:	97ce                	add	a5,a5,s3
    14ec:	00d10ba3          	sb	a3,23(sp)
    14f0:	00074703          	lbu	a4,0(a4)
    14f4:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14f8:	4649                	li	a2,18
    14fa:	002c                	addi	a1,sp,8
    14fc:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14fe:	00e10c23          	sb	a4,24(sp)
    1502:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1506:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    150a:	79a000ef          	jal	1ca4 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    150e:	00248513          	addi	a0,s1,2
        if (!*s)
    1512:	00054783          	lbu	a5,0(a0)
    1516:	e80798e3          	bnez	a5,13a6 <printf+0x4e>
    }
    va_end(ap);
}
    151a:	70e6                	ld	ra,120(sp)
    151c:	7446                	ld	s0,112(sp)
    151e:	74a6                	ld	s1,104(sp)
    1520:	7906                	ld	s2,96(sp)
    1522:	69e6                	ld	s3,88(sp)
    1524:	6a46                	ld	s4,80(sp)
    1526:	6aa6                	ld	s5,72(sp)
    1528:	6b06                	ld	s6,64(sp)
    152a:	7be2                	ld	s7,56(sp)
    152c:	6129                	addi	sp,sp,192
    152e:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1530:	00064783          	lbu	a5,0(a2)
    1534:	84b2                	mv	s1,a2
    1536:	01278963          	beq	a5,s2,1548 <printf+0x1f0>
    153a:	bdb5                	j	13b6 <printf+0x5e>
    153c:	0024c783          	lbu	a5,2(s1)
    1540:	0605                	addi	a2,a2,1
    1542:	0489                	addi	s1,s1,2
    1544:	e72799e3          	bne	a5,s2,13b6 <printf+0x5e>
    1548:	0014c783          	lbu	a5,1(s1)
    154c:	ff2788e3          	beq	a5,s2,153c <printf+0x1e4>
        l = z - a;
    1550:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1554:	85aa                	mv	a1,a0
    1556:	8622                	mv	a2,s0
    1558:	4505                	li	a0,1
    155a:	74a000ef          	jal	1ca4 <write>
        if (l)
    155e:	e60405e3          	beqz	s0,13c8 <printf+0x70>
    1562:	8526                	mv	a0,s1
    1564:	bd2d                	j	139e <printf+0x46>
        switch (s[1])
    1566:	05579963          	bne	a5,s5,15b8 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    156a:	6782                	ld	a5,0(sp)
    156c:	45c1                	li	a1,16
    156e:	4388                	lw	a0,0(a5)
    1570:	07a1                	addi	a5,a5,8
    1572:	e03e                	sd	a5,0(sp)
    1574:	b6bff0ef          	jal	10de <printint.constprop.0>
        s += 2;
    1578:	00248513          	addi	a0,s1,2
    157c:	bf59                	j	1512 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    157e:	6782                	ld	a5,0(sp)
    1580:	45a9                	li	a1,10
    1582:	4388                	lw	a0,0(a5)
    1584:	07a1                	addi	a5,a5,8
    1586:	e03e                	sd	a5,0(sp)
    1588:	b57ff0ef          	jal	10de <printint.constprop.0>
        s += 2;
    158c:	00248513          	addi	a0,s1,2
    1590:	b749                	j	1512 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1592:	6782                	ld	a5,0(sp)
    1594:	6380                	ld	s0,0(a5)
    1596:	07a1                	addi	a5,a5,8
    1598:	e03e                	sd	a5,0(sp)
    159a:	c031                	beqz	s0,15de <printf+0x286>
            l = strnlen(a, 200);
    159c:	0c800593          	li	a1,200
    15a0:	8522                	mv	a0,s0
    15a2:	40a000ef          	jal	19ac <strnlen>
    write(f, s, l);
    15a6:	0005061b          	sext.w	a2,a0
    15aa:	85a2                	mv	a1,s0
    15ac:	4505                	li	a0,1
    15ae:	6f6000ef          	jal	1ca4 <write>
        s += 2;
    15b2:	00248513          	addi	a0,s1,2
    15b6:	bfb1                	j	1512 <printf+0x1ba>
    return write(stdout, &byte, 1);
    15b8:	4605                	li	a2,1
    15ba:	002c                	addi	a1,sp,8
    15bc:	4505                	li	a0,1
    char byte = c;
    15be:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15c2:	6e2000ef          	jal	1ca4 <write>
    char byte = c;
    15c6:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15ca:	4605                	li	a2,1
    15cc:	002c                	addi	a1,sp,8
    15ce:	4505                	li	a0,1
    char byte = c;
    15d0:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15d4:	6d0000ef          	jal	1ca4 <write>
        s += 2;
    15d8:	00248513          	addi	a0,s1,2
    15dc:	bf1d                	j	1512 <printf+0x1ba>
                a = "(null)";
    15de:	845e                	mv	s0,s7
    15e0:	bf75                	j	159c <printf+0x244>

00000000000015e2 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15e2:	1141                	addi	sp,sp,-16
    15e4:	e406                	sd	ra,8(sp)
    puts(m);
    15e6:	d51ff0ef          	jal	1336 <puts>
    exit(-100);
}
    15ea:	60a2                	ld	ra,8(sp)
    exit(-100);
    15ec:	f9c00513          	li	a0,-100
}
    15f0:	0141                	addi	sp,sp,16
    exit(-100);
    15f2:	a709                	j	1cf4 <exit>

00000000000015f4 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15f4:	02000793          	li	a5,32
    15f8:	00f50663          	beq	a0,a5,1604 <isspace+0x10>
    15fc:	355d                	addiw	a0,a0,-9
    15fe:	00553513          	sltiu	a0,a0,5
    1602:	8082                	ret
    1604:	4505                	li	a0,1
}
    1606:	8082                	ret

0000000000001608 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1608:	fd05051b          	addiw	a0,a0,-48
}
    160c:	00a53513          	sltiu	a0,a0,10
    1610:	8082                	ret

0000000000001612 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1612:	02000613          	li	a2,32
    1616:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1618:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    161c:	ff77069b          	addiw	a3,a4,-9
    1620:	04c70d63          	beq	a4,a2,167a <atoi+0x68>
    1624:	0007079b          	sext.w	a5,a4
    1628:	04d5f963          	bgeu	a1,a3,167a <atoi+0x68>
        s++;
    switch (*s)
    162c:	02b00693          	li	a3,43
    1630:	04d70a63          	beq	a4,a3,1684 <atoi+0x72>
    1634:	02d00693          	li	a3,45
    1638:	06d70463          	beq	a4,a3,16a0 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    163c:	fd07859b          	addiw	a1,a5,-48
    1640:	4625                	li	a2,9
    1642:	873e                	mv	a4,a5
    1644:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1646:	4e01                	li	t3,0
    while (isdigit(*s))
    1648:	04b66a63          	bltu	a2,a1,169c <atoi+0x8a>
    int n = 0, neg = 0;
    164c:	4501                	li	a0,0
    while (isdigit(*s))
    164e:	4825                	li	a6,9
    1650:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1654:	0025179b          	slliw	a5,a0,0x2
    1658:	9d3d                	addw	a0,a0,a5
    165a:	fd07031b          	addiw	t1,a4,-48
    165e:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1662:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1666:	0685                	addi	a3,a3,1
    1668:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    166c:	0006071b          	sext.w	a4,a2
    1670:	feb870e3          	bgeu	a6,a1,1650 <atoi+0x3e>
    return neg ? n : -n;
    1674:	000e0563          	beqz	t3,167e <atoi+0x6c>
}
    1678:	8082                	ret
        s++;
    167a:	0505                	addi	a0,a0,1
    167c:	bf71                	j	1618 <atoi+0x6>
    return neg ? n : -n;
    167e:	4113053b          	subw	a0,t1,a7
    1682:	8082                	ret
    while (isdigit(*s))
    1684:	00154783          	lbu	a5,1(a0)
    1688:	4625                	li	a2,9
        s++;
    168a:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    168e:	fd07859b          	addiw	a1,a5,-48
    1692:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1696:	4e01                	li	t3,0
    while (isdigit(*s))
    1698:	fab67ae3          	bgeu	a2,a1,164c <atoi+0x3a>
    169c:	4501                	li	a0,0
}
    169e:	8082                	ret
    while (isdigit(*s))
    16a0:	00154783          	lbu	a5,1(a0)
    16a4:	4625                	li	a2,9
        s++;
    16a6:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16aa:	fd07859b          	addiw	a1,a5,-48
    16ae:	0007871b          	sext.w	a4,a5
    16b2:	feb665e3          	bltu	a2,a1,169c <atoi+0x8a>
        neg = 1;
    16b6:	4e05                	li	t3,1
    16b8:	bf51                	j	164c <atoi+0x3a>

00000000000016ba <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16ba:	16060d63          	beqz	a2,1834 <memset+0x17a>
    16be:	40a007b3          	neg	a5,a0
    16c2:	8b9d                	andi	a5,a5,7
    16c4:	00778713          	addi	a4,a5,7
    16c8:	482d                	li	a6,11
    16ca:	0ff5f593          	zext.b	a1,a1
    16ce:	fff60693          	addi	a3,a2,-1
    16d2:	17076263          	bltu	a4,a6,1836 <memset+0x17c>
    16d6:	16e6ea63          	bltu	a3,a4,184a <memset+0x190>
    16da:	16078563          	beqz	a5,1844 <memset+0x18a>
    16de:	00b50023          	sb	a1,0(a0)
    16e2:	4705                	li	a4,1
    16e4:	00150e93          	addi	t4,a0,1
    16e8:	14e78c63          	beq	a5,a4,1840 <memset+0x186>
    16ec:	00b500a3          	sb	a1,1(a0)
    16f0:	4709                	li	a4,2
    16f2:	00250e93          	addi	t4,a0,2
    16f6:	14e78d63          	beq	a5,a4,1850 <memset+0x196>
    16fa:	00b50123          	sb	a1,2(a0)
    16fe:	470d                	li	a4,3
    1700:	00350e93          	addi	t4,a0,3
    1704:	12e78b63          	beq	a5,a4,183a <memset+0x180>
    1708:	00b501a3          	sb	a1,3(a0)
    170c:	4711                	li	a4,4
    170e:	00450e93          	addi	t4,a0,4
    1712:	14e78163          	beq	a5,a4,1854 <memset+0x19a>
    1716:	00b50223          	sb	a1,4(a0)
    171a:	4715                	li	a4,5
    171c:	00550e93          	addi	t4,a0,5
    1720:	12e78c63          	beq	a5,a4,1858 <memset+0x19e>
    1724:	00b502a3          	sb	a1,5(a0)
    1728:	471d                	li	a4,7
    172a:	00650e93          	addi	t4,a0,6
    172e:	12e79763          	bne	a5,a4,185c <memset+0x1a2>
    1732:	00750e93          	addi	t4,a0,7
    1736:	00b50323          	sb	a1,6(a0)
    173a:	4f1d                	li	t5,7
    173c:	00859713          	slli	a4,a1,0x8
    1740:	8f4d                	or	a4,a4,a1
    1742:	01059e13          	slli	t3,a1,0x10
    1746:	01c76e33          	or	t3,a4,t3
    174a:	01859313          	slli	t1,a1,0x18
    174e:	006e6333          	or	t1,t3,t1
    1752:	02059893          	slli	a7,a1,0x20
    1756:	011368b3          	or	a7,t1,a7
    175a:	02859813          	slli	a6,a1,0x28
    175e:	40f60333          	sub	t1,a2,a5
    1762:	0108e833          	or	a6,a7,a6
    1766:	03059693          	slli	a3,a1,0x30
    176a:	00d866b3          	or	a3,a6,a3
    176e:	03859713          	slli	a4,a1,0x38
    1772:	97aa                	add	a5,a5,a0
    1774:	ff837813          	andi	a6,t1,-8
    1778:	8f55                	or	a4,a4,a3
    177a:	00f806b3          	add	a3,a6,a5
    177e:	e398                	sd	a4,0(a5)
    1780:	07a1                	addi	a5,a5,8
    1782:	fed79ee3          	bne	a5,a3,177e <memset+0xc4>
    1786:	ff837693          	andi	a3,t1,-8
    178a:	00de87b3          	add	a5,t4,a3
    178e:	01e6873b          	addw	a4,a3,t5
    1792:	0ad30663          	beq	t1,a3,183e <memset+0x184>
    1796:	00b78023          	sb	a1,0(a5)
    179a:	0017069b          	addiw	a3,a4,1
    179e:	08c6fb63          	bgeu	a3,a2,1834 <memset+0x17a>
    17a2:	00b780a3          	sb	a1,1(a5)
    17a6:	0027069b          	addiw	a3,a4,2
    17aa:	08c6f563          	bgeu	a3,a2,1834 <memset+0x17a>
    17ae:	00b78123          	sb	a1,2(a5)
    17b2:	0037069b          	addiw	a3,a4,3
    17b6:	06c6ff63          	bgeu	a3,a2,1834 <memset+0x17a>
    17ba:	00b781a3          	sb	a1,3(a5)
    17be:	0047069b          	addiw	a3,a4,4
    17c2:	06c6f963          	bgeu	a3,a2,1834 <memset+0x17a>
    17c6:	00b78223          	sb	a1,4(a5)
    17ca:	0057069b          	addiw	a3,a4,5
    17ce:	06c6f363          	bgeu	a3,a2,1834 <memset+0x17a>
    17d2:	00b782a3          	sb	a1,5(a5)
    17d6:	0067069b          	addiw	a3,a4,6
    17da:	04c6fd63          	bgeu	a3,a2,1834 <memset+0x17a>
    17de:	00b78323          	sb	a1,6(a5)
    17e2:	0077069b          	addiw	a3,a4,7
    17e6:	04c6f763          	bgeu	a3,a2,1834 <memset+0x17a>
    17ea:	00b783a3          	sb	a1,7(a5)
    17ee:	0087069b          	addiw	a3,a4,8
    17f2:	04c6f163          	bgeu	a3,a2,1834 <memset+0x17a>
    17f6:	00b78423          	sb	a1,8(a5)
    17fa:	0097069b          	addiw	a3,a4,9
    17fe:	02c6fb63          	bgeu	a3,a2,1834 <memset+0x17a>
    1802:	00b784a3          	sb	a1,9(a5)
    1806:	00a7069b          	addiw	a3,a4,10
    180a:	02c6f563          	bgeu	a3,a2,1834 <memset+0x17a>
    180e:	00b78523          	sb	a1,10(a5)
    1812:	00b7069b          	addiw	a3,a4,11
    1816:	00c6ff63          	bgeu	a3,a2,1834 <memset+0x17a>
    181a:	00b785a3          	sb	a1,11(a5)
    181e:	00c7069b          	addiw	a3,a4,12
    1822:	00c6f963          	bgeu	a3,a2,1834 <memset+0x17a>
    1826:	00b78623          	sb	a1,12(a5)
    182a:	2735                	addiw	a4,a4,13
    182c:	00c77463          	bgeu	a4,a2,1834 <memset+0x17a>
    1830:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1834:	8082                	ret
    1836:	472d                	li	a4,11
    1838:	bd79                	j	16d6 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    183a:	4f0d                	li	t5,3
    183c:	b701                	j	173c <memset+0x82>
    183e:	8082                	ret
    1840:	4f05                	li	t5,1
    1842:	bded                	j	173c <memset+0x82>
    1844:	8eaa                	mv	t4,a0
    1846:	4f01                	li	t5,0
    1848:	bdd5                	j	173c <memset+0x82>
    184a:	87aa                	mv	a5,a0
    184c:	4701                	li	a4,0
    184e:	b7a1                	j	1796 <memset+0xdc>
    1850:	4f09                	li	t5,2
    1852:	b5ed                	j	173c <memset+0x82>
    1854:	4f11                	li	t5,4
    1856:	b5dd                	j	173c <memset+0x82>
    1858:	4f15                	li	t5,5
    185a:	b5cd                	j	173c <memset+0x82>
    185c:	4f19                	li	t5,6
    185e:	bdf9                	j	173c <memset+0x82>

0000000000001860 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1860:	00054783          	lbu	a5,0(a0)
    1864:	0005c703          	lbu	a4,0(a1)
    1868:	00e79863          	bne	a5,a4,1878 <strcmp+0x18>
    186c:	0505                	addi	a0,a0,1
    186e:	0585                	addi	a1,a1,1
    1870:	fbe5                	bnez	a5,1860 <strcmp>
    1872:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1874:	9d19                	subw	a0,a0,a4
    1876:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1878:	0007851b          	sext.w	a0,a5
    187c:	bfe5                	j	1874 <strcmp+0x14>

000000000000187e <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    187e:	ce05                	beqz	a2,18b6 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1880:	00054703          	lbu	a4,0(a0)
    1884:	0005c783          	lbu	a5,0(a1)
    1888:	cb0d                	beqz	a4,18ba <strncmp+0x3c>
    if (!n--)
    188a:	167d                	addi	a2,a2,-1
    188c:	00c506b3          	add	a3,a0,a2
    1890:	a819                	j	18a6 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1892:	00a68e63          	beq	a3,a0,18ae <strncmp+0x30>
    1896:	0505                	addi	a0,a0,1
    1898:	00e79b63          	bne	a5,a4,18ae <strncmp+0x30>
    189c:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18a0:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18a4:	cb19                	beqz	a4,18ba <strncmp+0x3c>
    18a6:	0005c783          	lbu	a5,0(a1)
    18aa:	0585                	addi	a1,a1,1
    18ac:	f3fd                	bnez	a5,1892 <strncmp+0x14>
    return *l - *r;
    18ae:	0007051b          	sext.w	a0,a4
    18b2:	9d1d                	subw	a0,a0,a5
    18b4:	8082                	ret
        return 0;
    18b6:	4501                	li	a0,0
}
    18b8:	8082                	ret
    18ba:	4501                	li	a0,0
    return *l - *r;
    18bc:	9d1d                	subw	a0,a0,a5
    18be:	8082                	ret

00000000000018c0 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18c0:	00757793          	andi	a5,a0,7
    18c4:	cf89                	beqz	a5,18de <strlen+0x1e>
    18c6:	87aa                	mv	a5,a0
    18c8:	a029                	j	18d2 <strlen+0x12>
    18ca:	0785                	addi	a5,a5,1
    18cc:	0077f713          	andi	a4,a5,7
    18d0:	cb01                	beqz	a4,18e0 <strlen+0x20>
        if (!*s)
    18d2:	0007c703          	lbu	a4,0(a5)
    18d6:	fb75                	bnez	a4,18ca <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18d8:	40a78533          	sub	a0,a5,a0
}
    18dc:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18de:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18e0:	6394                	ld	a3,0(a5)
    18e2:	00000597          	auipc	a1,0x0
    18e6:	6c65b583          	ld	a1,1734(a1) # 1fa8 <__clone+0xcc>
    18ea:	00000617          	auipc	a2,0x0
    18ee:	6c663603          	ld	a2,1734(a2) # 1fb0 <__clone+0xd4>
    18f2:	a019                	j	18f8 <strlen+0x38>
    18f4:	6794                	ld	a3,8(a5)
    18f6:	07a1                	addi	a5,a5,8
    18f8:	00b68733          	add	a4,a3,a1
    18fc:	fff6c693          	not	a3,a3
    1900:	8f75                	and	a4,a4,a3
    1902:	8f71                	and	a4,a4,a2
    1904:	db65                	beqz	a4,18f4 <strlen+0x34>
    for (; *s; s++)
    1906:	0007c703          	lbu	a4,0(a5)
    190a:	d779                	beqz	a4,18d8 <strlen+0x18>
    190c:	0017c703          	lbu	a4,1(a5)
    1910:	0785                	addi	a5,a5,1
    1912:	d379                	beqz	a4,18d8 <strlen+0x18>
    1914:	0017c703          	lbu	a4,1(a5)
    1918:	0785                	addi	a5,a5,1
    191a:	fb6d                	bnez	a4,190c <strlen+0x4c>
    191c:	bf75                	j	18d8 <strlen+0x18>

000000000000191e <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    191e:	00757713          	andi	a4,a0,7
{
    1922:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1924:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1928:	cb19                	beqz	a4,193e <memchr+0x20>
    192a:	ce25                	beqz	a2,19a2 <memchr+0x84>
    192c:	0007c703          	lbu	a4,0(a5)
    1930:	04b70e63          	beq	a4,a1,198c <memchr+0x6e>
    1934:	0785                	addi	a5,a5,1
    1936:	0077f713          	andi	a4,a5,7
    193a:	167d                	addi	a2,a2,-1
    193c:	f77d                	bnez	a4,192a <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    193e:	4501                	li	a0,0
    if (n && *s != c)
    1940:	c235                	beqz	a2,19a4 <memchr+0x86>
    1942:	0007c703          	lbu	a4,0(a5)
    1946:	04b70363          	beq	a4,a1,198c <memchr+0x6e>
        size_t k = ONES * c;
    194a:	00000517          	auipc	a0,0x0
    194e:	66e53503          	ld	a0,1646(a0) # 1fb8 <__clone+0xdc>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1952:	471d                	li	a4,7
        size_t k = ONES * c;
    1954:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1958:	02c77a63          	bgeu	a4,a2,198c <memchr+0x6e>
    195c:	00000897          	auipc	a7,0x0
    1960:	64c8b883          	ld	a7,1612(a7) # 1fa8 <__clone+0xcc>
    1964:	00000817          	auipc	a6,0x0
    1968:	64c83803          	ld	a6,1612(a6) # 1fb0 <__clone+0xd4>
    196c:	431d                	li	t1,7
    196e:	a029                	j	1978 <memchr+0x5a>
    1970:	1661                	addi	a2,a2,-8
    1972:	07a1                	addi	a5,a5,8
    1974:	02c37963          	bgeu	t1,a2,19a6 <memchr+0x88>
    1978:	6398                	ld	a4,0(a5)
    197a:	8f29                	xor	a4,a4,a0
    197c:	011706b3          	add	a3,a4,a7
    1980:	fff74713          	not	a4,a4
    1984:	8f75                	and	a4,a4,a3
    1986:	01077733          	and	a4,a4,a6
    198a:	d37d                	beqz	a4,1970 <memchr+0x52>
    198c:	853e                	mv	a0,a5
    198e:	97b2                	add	a5,a5,a2
    1990:	a021                	j	1998 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1992:	0505                	addi	a0,a0,1
    1994:	00f50763          	beq	a0,a5,19a2 <memchr+0x84>
    1998:	00054703          	lbu	a4,0(a0)
    199c:	feb71be3          	bne	a4,a1,1992 <memchr+0x74>
    19a0:	8082                	ret
    return n ? (void *)s : 0;
    19a2:	4501                	li	a0,0
}
    19a4:	8082                	ret
    return n ? (void *)s : 0;
    19a6:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19a8:	f275                	bnez	a2,198c <memchr+0x6e>
}
    19aa:	8082                	ret

00000000000019ac <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19ac:	1101                	addi	sp,sp,-32
    19ae:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19b0:	862e                	mv	a2,a1
{
    19b2:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19b4:	4581                	li	a1,0
{
    19b6:	e426                	sd	s1,8(sp)
    19b8:	ec06                	sd	ra,24(sp)
    19ba:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19bc:	f63ff0ef          	jal	191e <memchr>
    return p ? p - s : n;
    19c0:	c519                	beqz	a0,19ce <strnlen+0x22>
}
    19c2:	60e2                	ld	ra,24(sp)
    19c4:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19c6:	8d05                	sub	a0,a0,s1
}
    19c8:	64a2                	ld	s1,8(sp)
    19ca:	6105                	addi	sp,sp,32
    19cc:	8082                	ret
    19ce:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19d0:	8522                	mv	a0,s0
}
    19d2:	6442                	ld	s0,16(sp)
    19d4:	64a2                	ld	s1,8(sp)
    19d6:	6105                	addi	sp,sp,32
    19d8:	8082                	ret

00000000000019da <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19da:	00b547b3          	xor	a5,a0,a1
    19de:	8b9d                	andi	a5,a5,7
    19e0:	eb95                	bnez	a5,1a14 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19e2:	0075f793          	andi	a5,a1,7
    19e6:	e7b1                	bnez	a5,1a32 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19e8:	6198                	ld	a4,0(a1)
    19ea:	00000617          	auipc	a2,0x0
    19ee:	5be63603          	ld	a2,1470(a2) # 1fa8 <__clone+0xcc>
    19f2:	00000817          	auipc	a6,0x0
    19f6:	5be83803          	ld	a6,1470(a6) # 1fb0 <__clone+0xd4>
    19fa:	a029                	j	1a04 <strcpy+0x2a>
    19fc:	e118                	sd	a4,0(a0)
    19fe:	6598                	ld	a4,8(a1)
    1a00:	05a1                	addi	a1,a1,8
    1a02:	0521                	addi	a0,a0,8
    1a04:	00c707b3          	add	a5,a4,a2
    1a08:	fff74693          	not	a3,a4
    1a0c:	8ff5                	and	a5,a5,a3
    1a0e:	0107f7b3          	and	a5,a5,a6
    1a12:	d7ed                	beqz	a5,19fc <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a14:	0005c783          	lbu	a5,0(a1)
    1a18:	00f50023          	sb	a5,0(a0)
    1a1c:	c785                	beqz	a5,1a44 <strcpy+0x6a>
    1a1e:	0015c783          	lbu	a5,1(a1)
    1a22:	0505                	addi	a0,a0,1
    1a24:	0585                	addi	a1,a1,1
    1a26:	00f50023          	sb	a5,0(a0)
    1a2a:	fbf5                	bnez	a5,1a1e <strcpy+0x44>
        ;
    return d;
}
    1a2c:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a2e:	0505                	addi	a0,a0,1
    1a30:	df45                	beqz	a4,19e8 <strcpy+0xe>
            if (!(*d = *s))
    1a32:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a36:	0585                	addi	a1,a1,1
    1a38:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a3c:	00f50023          	sb	a5,0(a0)
    1a40:	f7fd                	bnez	a5,1a2e <strcpy+0x54>
}
    1a42:	8082                	ret
    1a44:	8082                	ret

0000000000001a46 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a46:	00b547b3          	xor	a5,a0,a1
    1a4a:	8b9d                	andi	a5,a5,7
    1a4c:	1a079863          	bnez	a5,1bfc <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a50:	0075f793          	andi	a5,a1,7
    1a54:	16078463          	beqz	a5,1bbc <strncpy+0x176>
    1a58:	ea01                	bnez	a2,1a68 <strncpy+0x22>
    1a5a:	a421                	j	1c62 <strncpy+0x21c>
    1a5c:	167d                	addi	a2,a2,-1
    1a5e:	0505                	addi	a0,a0,1
    1a60:	14070e63          	beqz	a4,1bbc <strncpy+0x176>
    1a64:	1a060863          	beqz	a2,1c14 <strncpy+0x1ce>
    1a68:	0005c783          	lbu	a5,0(a1)
    1a6c:	0585                	addi	a1,a1,1
    1a6e:	0075f713          	andi	a4,a1,7
    1a72:	00f50023          	sb	a5,0(a0)
    1a76:	f3fd                	bnez	a5,1a5c <strncpy+0x16>
    1a78:	4805                	li	a6,1
    1a7a:	1a061863          	bnez	a2,1c2a <strncpy+0x1e4>
    1a7e:	40a007b3          	neg	a5,a0
    1a82:	8b9d                	andi	a5,a5,7
    1a84:	4681                	li	a3,0
    1a86:	18061a63          	bnez	a2,1c1a <strncpy+0x1d4>
    1a8a:	00778713          	addi	a4,a5,7
    1a8e:	45ad                	li	a1,11
    1a90:	18b76363          	bltu	a4,a1,1c16 <strncpy+0x1d0>
    1a94:	1ae6eb63          	bltu	a3,a4,1c4a <strncpy+0x204>
    1a98:	1a078363          	beqz	a5,1c3e <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a9c:	00050023          	sb	zero,0(a0)
    1aa0:	4685                	li	a3,1
    1aa2:	00150713          	addi	a4,a0,1
    1aa6:	18d78f63          	beq	a5,a3,1c44 <strncpy+0x1fe>
    1aaa:	000500a3          	sb	zero,1(a0)
    1aae:	4689                	li	a3,2
    1ab0:	00250713          	addi	a4,a0,2
    1ab4:	18d78e63          	beq	a5,a3,1c50 <strncpy+0x20a>
    1ab8:	00050123          	sb	zero,2(a0)
    1abc:	468d                	li	a3,3
    1abe:	00350713          	addi	a4,a0,3
    1ac2:	16d78c63          	beq	a5,a3,1c3a <strncpy+0x1f4>
    1ac6:	000501a3          	sb	zero,3(a0)
    1aca:	4691                	li	a3,4
    1acc:	00450713          	addi	a4,a0,4
    1ad0:	18d78263          	beq	a5,a3,1c54 <strncpy+0x20e>
    1ad4:	00050223          	sb	zero,4(a0)
    1ad8:	4695                	li	a3,5
    1ada:	00550713          	addi	a4,a0,5
    1ade:	16d78d63          	beq	a5,a3,1c58 <strncpy+0x212>
    1ae2:	000502a3          	sb	zero,5(a0)
    1ae6:	469d                	li	a3,7
    1ae8:	00650713          	addi	a4,a0,6
    1aec:	16d79863          	bne	a5,a3,1c5c <strncpy+0x216>
    1af0:	00750713          	addi	a4,a0,7
    1af4:	00050323          	sb	zero,6(a0)
    1af8:	40f80833          	sub	a6,a6,a5
    1afc:	ff887593          	andi	a1,a6,-8
    1b00:	97aa                	add	a5,a5,a0
    1b02:	95be                	add	a1,a1,a5
    1b04:	0007b023          	sd	zero,0(a5)
    1b08:	07a1                	addi	a5,a5,8
    1b0a:	feb79de3          	bne	a5,a1,1b04 <strncpy+0xbe>
    1b0e:	ff887593          	andi	a1,a6,-8
    1b12:	9ead                	addw	a3,a3,a1
    1b14:	00b707b3          	add	a5,a4,a1
    1b18:	12b80863          	beq	a6,a1,1c48 <strncpy+0x202>
    1b1c:	00078023          	sb	zero,0(a5)
    1b20:	0016871b          	addiw	a4,a3,1
    1b24:	0ec77863          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1b28:	000780a3          	sb	zero,1(a5)
    1b2c:	0026871b          	addiw	a4,a3,2
    1b30:	0ec77263          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1b34:	00078123          	sb	zero,2(a5)
    1b38:	0036871b          	addiw	a4,a3,3
    1b3c:	0cc77c63          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1b40:	000781a3          	sb	zero,3(a5)
    1b44:	0046871b          	addiw	a4,a3,4
    1b48:	0cc77663          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1b4c:	00078223          	sb	zero,4(a5)
    1b50:	0056871b          	addiw	a4,a3,5
    1b54:	0cc77063          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1b58:	000782a3          	sb	zero,5(a5)
    1b5c:	0066871b          	addiw	a4,a3,6
    1b60:	0ac77a63          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1b64:	00078323          	sb	zero,6(a5)
    1b68:	0076871b          	addiw	a4,a3,7
    1b6c:	0ac77463          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1b70:	000783a3          	sb	zero,7(a5)
    1b74:	0086871b          	addiw	a4,a3,8
    1b78:	08c77e63          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1b7c:	00078423          	sb	zero,8(a5)
    1b80:	0096871b          	addiw	a4,a3,9
    1b84:	08c77863          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1b88:	000784a3          	sb	zero,9(a5)
    1b8c:	00a6871b          	addiw	a4,a3,10
    1b90:	08c77263          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1b94:	00078523          	sb	zero,10(a5)
    1b98:	00b6871b          	addiw	a4,a3,11
    1b9c:	06c77c63          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1ba0:	000785a3          	sb	zero,11(a5)
    1ba4:	00c6871b          	addiw	a4,a3,12
    1ba8:	06c77663          	bgeu	a4,a2,1c14 <strncpy+0x1ce>
    1bac:	00078623          	sb	zero,12(a5)
    1bb0:	26b5                	addiw	a3,a3,13
    1bb2:	06c6f163          	bgeu	a3,a2,1c14 <strncpy+0x1ce>
    1bb6:	000786a3          	sb	zero,13(a5)
    1bba:	8082                	ret
            ;
        if (!n || !*s)
    1bbc:	c645                	beqz	a2,1c64 <strncpy+0x21e>
    1bbe:	0005c783          	lbu	a5,0(a1)
    1bc2:	ea078be3          	beqz	a5,1a78 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bc6:	479d                	li	a5,7
    1bc8:	02c7ff63          	bgeu	a5,a2,1c06 <strncpy+0x1c0>
    1bcc:	00000897          	auipc	a7,0x0
    1bd0:	3dc8b883          	ld	a7,988(a7) # 1fa8 <__clone+0xcc>
    1bd4:	00000817          	auipc	a6,0x0
    1bd8:	3dc83803          	ld	a6,988(a6) # 1fb0 <__clone+0xd4>
    1bdc:	431d                	li	t1,7
    1bde:	6198                	ld	a4,0(a1)
    1be0:	011707b3          	add	a5,a4,a7
    1be4:	fff74693          	not	a3,a4
    1be8:	8ff5                	and	a5,a5,a3
    1bea:	0107f7b3          	and	a5,a5,a6
    1bee:	ef81                	bnez	a5,1c06 <strncpy+0x1c0>
            *wd = *ws;
    1bf0:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bf2:	1661                	addi	a2,a2,-8
    1bf4:	05a1                	addi	a1,a1,8
    1bf6:	0521                	addi	a0,a0,8
    1bf8:	fec363e3          	bltu	t1,a2,1bde <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bfc:	e609                	bnez	a2,1c06 <strncpy+0x1c0>
    1bfe:	a08d                	j	1c60 <strncpy+0x21a>
    1c00:	167d                	addi	a2,a2,-1
    1c02:	0505                	addi	a0,a0,1
    1c04:	ca01                	beqz	a2,1c14 <strncpy+0x1ce>
    1c06:	0005c783          	lbu	a5,0(a1)
    1c0a:	0585                	addi	a1,a1,1
    1c0c:	00f50023          	sb	a5,0(a0)
    1c10:	fbe5                	bnez	a5,1c00 <strncpy+0x1ba>
        ;
tail:
    1c12:	b59d                	j	1a78 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c14:	8082                	ret
    1c16:	472d                	li	a4,11
    1c18:	bdb5                	j	1a94 <strncpy+0x4e>
    1c1a:	00778713          	addi	a4,a5,7
    1c1e:	45ad                	li	a1,11
    1c20:	fff60693          	addi	a3,a2,-1
    1c24:	e6b778e3          	bgeu	a4,a1,1a94 <strncpy+0x4e>
    1c28:	b7fd                	j	1c16 <strncpy+0x1d0>
    1c2a:	40a007b3          	neg	a5,a0
    1c2e:	8832                	mv	a6,a2
    1c30:	8b9d                	andi	a5,a5,7
    1c32:	4681                	li	a3,0
    1c34:	e4060be3          	beqz	a2,1a8a <strncpy+0x44>
    1c38:	b7cd                	j	1c1a <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c3a:	468d                	li	a3,3
    1c3c:	bd75                	j	1af8 <strncpy+0xb2>
    1c3e:	872a                	mv	a4,a0
    1c40:	4681                	li	a3,0
    1c42:	bd5d                	j	1af8 <strncpy+0xb2>
    1c44:	4685                	li	a3,1
    1c46:	bd4d                	j	1af8 <strncpy+0xb2>
    1c48:	8082                	ret
    1c4a:	87aa                	mv	a5,a0
    1c4c:	4681                	li	a3,0
    1c4e:	b5f9                	j	1b1c <strncpy+0xd6>
    1c50:	4689                	li	a3,2
    1c52:	b55d                	j	1af8 <strncpy+0xb2>
    1c54:	4691                	li	a3,4
    1c56:	b54d                	j	1af8 <strncpy+0xb2>
    1c58:	4695                	li	a3,5
    1c5a:	bd79                	j	1af8 <strncpy+0xb2>
    1c5c:	4699                	li	a3,6
    1c5e:	bd69                	j	1af8 <strncpy+0xb2>
    1c60:	8082                	ret
    1c62:	8082                	ret
    1c64:	8082                	ret

0000000000001c66 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c66:	87aa                	mv	a5,a0
    1c68:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c6a:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c6e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c72:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c74:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c76:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c7a:	2501                	sext.w	a0,a0
    1c7c:	8082                	ret

0000000000001c7e <openat>:
    register long a7 __asm__("a7") = n;
    1c7e:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c82:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c86:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c8a:	2501                	sext.w	a0,a0
    1c8c:	8082                	ret

0000000000001c8e <close>:
    register long a7 __asm__("a7") = n;
    1c8e:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c92:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c96:	2501                	sext.w	a0,a0
    1c98:	8082                	ret

0000000000001c9a <read>:
    register long a7 __asm__("a7") = n;
    1c9a:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c9e:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1ca2:	8082                	ret

0000000000001ca4 <write>:
    register long a7 __asm__("a7") = n;
    1ca4:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ca8:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cac:	8082                	ret

0000000000001cae <getpid>:
    register long a7 __asm__("a7") = n;
    1cae:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cb2:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cb6:	2501                	sext.w	a0,a0
    1cb8:	8082                	ret

0000000000001cba <getppid>:
    register long a7 __asm__("a7") = n;
    1cba:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cbe:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cc2:	2501                	sext.w	a0,a0
    1cc4:	8082                	ret

0000000000001cc6 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cc6:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cca:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cce:	2501                	sext.w	a0,a0
    1cd0:	8082                	ret

0000000000001cd2 <fork>:
    register long a7 __asm__("a7") = n;
    1cd2:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cd6:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cd8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cda:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cde:	2501                	sext.w	a0,a0
    1ce0:	8082                	ret

0000000000001ce2 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1ce2:	85b2                	mv	a1,a2
    1ce4:	863a                	mv	a2,a4
    if (stack)
    1ce6:	c191                	beqz	a1,1cea <clone+0x8>
	stack += stack_size;
    1ce8:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cea:	4781                	li	a5,0
    1cec:	4701                	li	a4,0
    1cee:	4681                	li	a3,0
    1cf0:	2601                	sext.w	a2,a2
    1cf2:	a2ed                	j	1edc <__clone>

0000000000001cf4 <exit>:
    register long a7 __asm__("a7") = n;
    1cf4:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cf8:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cfc:	8082                	ret

0000000000001cfe <waitpid>:
    register long a7 __asm__("a7") = n;
    1cfe:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d02:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d04:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d08:	2501                	sext.w	a0,a0
    1d0a:	8082                	ret

0000000000001d0c <exec>:
    register long a7 __asm__("a7") = n;
    1d0c:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d10:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d14:	2501                	sext.w	a0,a0
    1d16:	8082                	ret

0000000000001d18 <execve>:
    register long a7 __asm__("a7") = n;
    1d18:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d1c:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d20:	2501                	sext.w	a0,a0
    1d22:	8082                	ret

0000000000001d24 <times>:
    register long a7 __asm__("a7") = n;
    1d24:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d28:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d2c:	2501                	sext.w	a0,a0
    1d2e:	8082                	ret

0000000000001d30 <get_time>:

int64 get_time()
{
    1d30:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d32:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d36:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d38:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d3a:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d3e:	2501                	sext.w	a0,a0
    1d40:	ed09                	bnez	a0,1d5a <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d42:	67a2                	ld	a5,8(sp)
    1d44:	3e800713          	li	a4,1000
    1d48:	00015503          	lhu	a0,0(sp)
    1d4c:	02e7d7b3          	divu	a5,a5,a4
    1d50:	02e50533          	mul	a0,a0,a4
    1d54:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d56:	0141                	addi	sp,sp,16
    1d58:	8082                	ret
        return -1;
    1d5a:	557d                	li	a0,-1
    1d5c:	bfed                	j	1d56 <get_time+0x26>

0000000000001d5e <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d5e:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d62:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d66:	2501                	sext.w	a0,a0
    1d68:	8082                	ret

0000000000001d6a <time>:
    register long a7 __asm__("a7") = n;
    1d6a:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d6e:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d72:	2501                	sext.w	a0,a0
    1d74:	8082                	ret

0000000000001d76 <sleep>:

int sleep(unsigned long long time)
{
    1d76:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d78:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d7a:	850a                	mv	a0,sp
    1d7c:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d7e:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d82:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d84:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d88:	e501                	bnez	a0,1d90 <sleep+0x1a>
    return 0;
    1d8a:	4501                	li	a0,0
}
    1d8c:	0141                	addi	sp,sp,16
    1d8e:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d90:	4502                	lw	a0,0(sp)
}
    1d92:	0141                	addi	sp,sp,16
    1d94:	8082                	ret

0000000000001d96 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d96:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d9a:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d9e:	2501                	sext.w	a0,a0
    1da0:	8082                	ret

0000000000001da2 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1da2:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1da6:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1daa:	8082                	ret

0000000000001dac <munmap>:
    register long a7 __asm__("a7") = n;
    1dac:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db0:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1db4:	2501                	sext.w	a0,a0
    1db6:	8082                	ret

0000000000001db8 <wait>:

int wait(int *code)
{
    1db8:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dba:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1dbe:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1dc0:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dc2:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dc4:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dc8:	2501                	sext.w	a0,a0
    1dca:	8082                	ret

0000000000001dcc <spawn>:
    register long a7 __asm__("a7") = n;
    1dcc:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dd0:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dd4:	2501                	sext.w	a0,a0
    1dd6:	8082                	ret

0000000000001dd8 <mailread>:
    register long a7 __asm__("a7") = n;
    1dd8:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ddc:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1de0:	2501                	sext.w	a0,a0
    1de2:	8082                	ret

0000000000001de4 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1de4:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1de8:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dec:	2501                	sext.w	a0,a0
    1dee:	8082                	ret

0000000000001df0 <fstat>:
    register long a7 __asm__("a7") = n;
    1df0:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1df4:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1df8:	2501                	sext.w	a0,a0
    1dfa:	8082                	ret

0000000000001dfc <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dfc:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dfe:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e02:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e04:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e08:	2501                	sext.w	a0,a0
    1e0a:	8082                	ret

0000000000001e0c <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e0c:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e0e:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e12:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e14:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e18:	2501                	sext.w	a0,a0
    1e1a:	8082                	ret

0000000000001e1c <link>:

int link(char *old_path, char *new_path)
{
    1e1c:	87aa                	mv	a5,a0
    1e1e:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e20:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e24:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e28:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e2a:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e2e:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e30:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e34:	2501                	sext.w	a0,a0
    1e36:	8082                	ret

0000000000001e38 <unlink>:

int unlink(char *path)
{
    1e38:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e3a:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e3e:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e42:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e44:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e48:	2501                	sext.w	a0,a0
    1e4a:	8082                	ret

0000000000001e4c <uname>:
    register long a7 __asm__("a7") = n;
    1e4c:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e50:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e54:	2501                	sext.w	a0,a0
    1e56:	8082                	ret

0000000000001e58 <brk>:
    register long a7 __asm__("a7") = n;
    1e58:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e5c:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e60:	2501                	sext.w	a0,a0
    1e62:	8082                	ret

0000000000001e64 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e64:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e66:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e6a:	8082                	ret

0000000000001e6c <chdir>:
    register long a7 __asm__("a7") = n;
    1e6c:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e70:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e74:	2501                	sext.w	a0,a0
    1e76:	8082                	ret

0000000000001e78 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e78:	862e                	mv	a2,a1
    1e7a:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e7c:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e7e:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e82:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e86:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e88:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e8a:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e8e:	2501                	sext.w	a0,a0
    1e90:	8082                	ret

0000000000001e92 <getdents>:
    register long a7 __asm__("a7") = n;
    1e92:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e96:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e9a:	2501                	sext.w	a0,a0
    1e9c:	8082                	ret

0000000000001e9e <pipe>:
    register long a7 __asm__("a7") = n;
    1e9e:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ea2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ea4:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1ea8:	2501                	sext.w	a0,a0
    1eaa:	8082                	ret

0000000000001eac <dup>:
    register long a7 __asm__("a7") = n;
    1eac:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1eae:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1eb2:	2501                	sext.w	a0,a0
    1eb4:	8082                	ret

0000000000001eb6 <dup2>:
    register long a7 __asm__("a7") = n;
    1eb6:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1eb8:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eba:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ebe:	2501                	sext.w	a0,a0
    1ec0:	8082                	ret

0000000000001ec2 <mount>:
    register long a7 __asm__("a7") = n;
    1ec2:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ec6:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1eca:	2501                	sext.w	a0,a0
    1ecc:	8082                	ret

0000000000001ece <umount>:
    register long a7 __asm__("a7") = n;
    1ece:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ed2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ed4:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ed8:	2501                	sext.w	a0,a0
    1eda:	8082                	ret

0000000000001edc <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1edc:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ede:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ee0:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ee2:	8532                	mv	a0,a2
	mv a2, a4
    1ee4:	863a                	mv	a2,a4
	mv a3, a5
    1ee6:	86be                	mv	a3,a5
	mv a4, a6
    1ee8:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1eea:	0dc00893          	li	a7,220
	ecall
    1eee:	00000073          	ecall

	beqz a0, 1f
    1ef2:	c111                	beqz	a0,1ef6 <__clone+0x1a>
	# Parent
	ret
    1ef4:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ef6:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ef8:	6522                	ld	a0,8(sp)
	jalr a1
    1efa:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1efc:	05d00893          	li	a7,93
	ecall
    1f00:	00000073          	ecall
