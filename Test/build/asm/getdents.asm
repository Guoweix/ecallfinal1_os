
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/getdents:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a0cd                	j	10e4 <__start_main>

0000000000001004 <test_getdents>:
#include "stdio.h"
#include "stdlib.h"
#include "unistd.h"

char buf[512];
void test_getdents(void){
    1004:	1101                	addi	sp,sp,-32
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f2250513          	addi	a0,a0,-222 # 1f28 <__clone+0x2c>
void test_getdents(void){
    100e:	ec06                	sd	ra,24(sp)
    1010:	e822                	sd	s0,16(sp)
    1012:	e426                	sd	s1,8(sp)
    TEST_START(__func__);
    1014:	342000ef          	jal	1356 <puts>
    1018:	00001517          	auipc	a0,0x1
    101c:	1c850513          	addi	a0,a0,456 # 21e0 <__func__.0>
    1020:	336000ef          	jal	1356 <puts>
    1024:	00001517          	auipc	a0,0x1
    1028:	f1c50513          	addi	a0,a0,-228 # 1f40 <__clone+0x44>
    102c:	32a000ef          	jal	1356 <puts>
    int fd, nread;
    struct linux_dirent64 *dirp64;
    dirp64 = buf;
    //fd = open(".", O_DIRECTORY);
    fd = open(".", O_RDONLY);
    1030:	4581                	li	a1,0
    1032:	00001517          	auipc	a0,0x1
    1036:	f1e50513          	addi	a0,a0,-226 # 1f50 <__clone+0x54>
    103a:	44d000ef          	jal	1c86 <open>
    printf("open fd:%d\n", fd);
    103e:	85aa                	mv	a1,a0
    fd = open(".", O_RDONLY);
    1040:	842a                	mv	s0,a0
    printf("open fd:%d\n", fd);
    1042:	00001517          	auipc	a0,0x1
    1046:	f1650513          	addi	a0,a0,-234 # 1f58 <__clone+0x5c>
    104a:	32e000ef          	jal	1378 <printf>

	nread = getdents(fd, dirp64, 512);
    104e:	20000613          	li	a2,512
    1052:	00001597          	auipc	a1,0x1
    1056:	f8e58593          	addi	a1,a1,-114 # 1fe0 <buf>
    105a:	8522                	mv	a0,s0
    105c:	657000ef          	jal	1eb2 <getdents>
	printf("getdents fd:%d\n", nread);
    1060:	85aa                	mv	a1,a0
	nread = getdents(fd, dirp64, 512);
    1062:	84aa                	mv	s1,a0
	printf("getdents fd:%d\n", nread);
    1064:	00001517          	auipc	a0,0x1
    1068:	f0450513          	addi	a0,a0,-252 # 1f68 <__clone+0x6c>
    106c:	30c000ef          	jal	1378 <printf>
	assert(nread != -1);
    1070:	57fd                	li	a5,-1
    1072:	04f48a63          	beq	s1,a5,10c6 <test_getdents+0xc2>
	printf("getdents success.\n%s\n", dirp64->d_name);
    1076:	00001597          	auipc	a1,0x1
    107a:	f7d58593          	addi	a1,a1,-131 # 1ff3 <buf+0x13>
    107e:	00001517          	auipc	a0,0x1
    1082:	f1a50513          	addi	a0,a0,-230 # 1f98 <__clone+0x9c>
    1086:	2f2000ef          	jal	1378 <printf>
	    printf(  "%s\t", d->d_name);
	    bpos += d->d_reclen;
	}
	*/

    printf("\n");
    108a:	00001517          	auipc	a0,0x1
    108e:	f0650513          	addi	a0,a0,-250 # 1f90 <__clone+0x94>
    1092:	2e6000ef          	jal	1378 <printf>
    close(fd);
    1096:	8522                	mv	a0,s0
    1098:	417000ef          	jal	1cae <close>
    TEST_END(__func__);
    109c:	00001517          	auipc	a0,0x1
    10a0:	f1450513          	addi	a0,a0,-236 # 1fb0 <__clone+0xb4>
    10a4:	2b2000ef          	jal	1356 <puts>
    10a8:	00001517          	auipc	a0,0x1
    10ac:	13850513          	addi	a0,a0,312 # 21e0 <__func__.0>
    10b0:	2a6000ef          	jal	1356 <puts>
}
    10b4:	6442                	ld	s0,16(sp)
    10b6:	60e2                	ld	ra,24(sp)
    10b8:	64a2                	ld	s1,8(sp)
    TEST_END(__func__);
    10ba:	00001517          	auipc	a0,0x1
    10be:	e8650513          	addi	a0,a0,-378 # 1f40 <__clone+0x44>
}
    10c2:	6105                	addi	sp,sp,32
    TEST_END(__func__);
    10c4:	ac49                	j	1356 <puts>
	assert(nread != -1);
    10c6:	00001517          	auipc	a0,0x1
    10ca:	eb250513          	addi	a0,a0,-334 # 1f78 <__clone+0x7c>
    10ce:	534000ef          	jal	1602 <panic>
    10d2:	b755                	j	1076 <test_getdents+0x72>

00000000000010d4 <main>:

int main(void){
    10d4:	1141                	addi	sp,sp,-16
    10d6:	e406                	sd	ra,8(sp)
    test_getdents();
    10d8:	f2dff0ef          	jal	1004 <test_getdents>
    return 0;
}
    10dc:	60a2                	ld	ra,8(sp)
    10de:	4501                	li	a0,0
    10e0:	0141                	addi	sp,sp,16
    10e2:	8082                	ret

00000000000010e4 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10e4:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10e6:	4108                	lw	a0,0(a0)
{
    10e8:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10ea:	05a1                	addi	a1,a1,8
{
    10ec:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10ee:	fe7ff0ef          	jal	10d4 <main>
    10f2:	423000ef          	jal	1d14 <exit>
	return 0;
}
    10f6:	60a2                	ld	ra,8(sp)
    10f8:	4501                	li	a0,0
    10fa:	0141                	addi	sp,sp,16
    10fc:	8082                	ret

00000000000010fe <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10fe:	7179                	addi	sp,sp,-48
    1100:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    1102:	12054b63          	bltz	a0,1238 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    1106:	02b577bb          	remuw	a5,a0,a1
    110a:	00001617          	auipc	a2,0x1
    110e:	0e660613          	addi	a2,a2,230 # 21f0 <digits>
    buf[16] = 0;
    1112:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1116:	0005871b          	sext.w	a4,a1
    111a:	1782                	slli	a5,a5,0x20
    111c:	9381                	srli	a5,a5,0x20
    111e:	97b2                	add	a5,a5,a2
    1120:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1124:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1128:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    112c:	1cb56363          	bltu	a0,a1,12f2 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    1130:	45b9                	li	a1,14
    1132:	02e877bb          	remuw	a5,a6,a4
    1136:	1782                	slli	a5,a5,0x20
    1138:	9381                	srli	a5,a5,0x20
    113a:	97b2                	add	a5,a5,a2
    113c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1140:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    1144:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1148:	0ce86e63          	bltu	a6,a4,1224 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    114c:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1150:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    1154:	1582                	slli	a1,a1,0x20
    1156:	9181                	srli	a1,a1,0x20
    1158:	95b2                	add	a1,a1,a2
    115a:	0005c583          	lbu	a1,0(a1)
    115e:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    1162:	0007859b          	sext.w	a1,a5
    1166:	12e6ec63          	bltu	a3,a4,129e <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    116a:	02e7f6bb          	remuw	a3,a5,a4
    116e:	1682                	slli	a3,a3,0x20
    1170:	9281                	srli	a3,a3,0x20
    1172:	96b2                	add	a3,a3,a2
    1174:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1178:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    117c:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1180:	12e5e863          	bltu	a1,a4,12b0 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    1184:	02e876bb          	remuw	a3,a6,a4
    1188:	1682                	slli	a3,a3,0x20
    118a:	9281                	srli	a3,a3,0x20
    118c:	96b2                	add	a3,a3,a2
    118e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1192:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1196:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    119a:	12e86463          	bltu	a6,a4,12c2 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    119e:	02e5f6bb          	remuw	a3,a1,a4
    11a2:	1682                	slli	a3,a3,0x20
    11a4:	9281                	srli	a3,a3,0x20
    11a6:	96b2                	add	a3,a3,a2
    11a8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11ac:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11b0:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    11b4:	0ce5ec63          	bltu	a1,a4,128c <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    11b8:	02e876bb          	remuw	a3,a6,a4
    11bc:	1682                	slli	a3,a3,0x20
    11be:	9281                	srli	a3,a3,0x20
    11c0:	96b2                	add	a3,a3,a2
    11c2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11c6:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11ca:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11ce:	10e86963          	bltu	a6,a4,12e0 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11d2:	02e5f6bb          	remuw	a3,a1,a4
    11d6:	1682                	slli	a3,a3,0x20
    11d8:	9281                	srli	a3,a3,0x20
    11da:	96b2                	add	a3,a3,a2
    11dc:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11e0:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11e4:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11e8:	10e5e763          	bltu	a1,a4,12f6 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11ec:	02e876bb          	remuw	a3,a6,a4
    11f0:	1682                	slli	a3,a3,0x20
    11f2:	9281                	srli	a3,a3,0x20
    11f4:	96b2                	add	a3,a3,a2
    11f6:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11fa:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11fe:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    1202:	10e86363          	bltu	a6,a4,1308 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    1206:	1782                	slli	a5,a5,0x20
    1208:	9381                	srli	a5,a5,0x20
    120a:	97b2                	add	a5,a5,a2
    120c:	0007c783          	lbu	a5,0(a5)
    1210:	4599                	li	a1,6
    1212:	00f10723          	sb	a5,14(sp)

    if (sign)
    1216:	00055763          	bgez	a0,1224 <printint.constprop.0+0x126>
        buf[i--] = '-';
    121a:	02d00793          	li	a5,45
    121e:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    1222:	4595                	li	a1,5
    write(f, s, l);
    1224:	003c                	addi	a5,sp,8
    1226:	4641                	li	a2,16
    1228:	9e0d                	subw	a2,a2,a1
    122a:	4505                	li	a0,1
    122c:	95be                	add	a1,a1,a5
    122e:	297000ef          	jal	1cc4 <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1232:	70a2                	ld	ra,40(sp)
    1234:	6145                	addi	sp,sp,48
    1236:	8082                	ret
        x = -xx;
    1238:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    123c:	02b877bb          	remuw	a5,a6,a1
    1240:	00001617          	auipc	a2,0x1
    1244:	fb060613          	addi	a2,a2,-80 # 21f0 <digits>
    buf[16] = 0;
    1248:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    124c:	0005871b          	sext.w	a4,a1
    1250:	1782                	slli	a5,a5,0x20
    1252:	9381                	srli	a5,a5,0x20
    1254:	97b2                	add	a5,a5,a2
    1256:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    125a:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    125e:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1262:	06b86963          	bltu	a6,a1,12d4 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1266:	02e8f7bb          	remuw	a5,a7,a4
    126a:	1782                	slli	a5,a5,0x20
    126c:	9381                	srli	a5,a5,0x20
    126e:	97b2                	add	a5,a5,a2
    1270:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1274:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1278:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    127c:	ece8f8e3          	bgeu	a7,a4,114c <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1280:	02d00793          	li	a5,45
    1284:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1288:	45b5                	li	a1,13
    128a:	bf69                	j	1224 <printint.constprop.0+0x126>
    128c:	45a9                	li	a1,10
    if (sign)
    128e:	f8055be3          	bgez	a0,1224 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1292:	02d00793          	li	a5,45
    1296:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    129a:	45a5                	li	a1,9
    129c:	b761                	j	1224 <printint.constprop.0+0x126>
    129e:	45b5                	li	a1,13
    if (sign)
    12a0:	f80552e3          	bgez	a0,1224 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12a4:	02d00793          	li	a5,45
    12a8:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    12ac:	45b1                	li	a1,12
    12ae:	bf9d                	j	1224 <printint.constprop.0+0x126>
    12b0:	45b1                	li	a1,12
    if (sign)
    12b2:	f60559e3          	bgez	a0,1224 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b6:	02d00793          	li	a5,45
    12ba:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12be:	45ad                	li	a1,11
    12c0:	b795                	j	1224 <printint.constprop.0+0x126>
    12c2:	45ad                	li	a1,11
    if (sign)
    12c4:	f60550e3          	bgez	a0,1224 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c8:	02d00793          	li	a5,45
    12cc:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12d0:	45a9                	li	a1,10
    12d2:	bf89                	j	1224 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d4:	02d00793          	li	a5,45
    12d8:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12dc:	45b9                	li	a1,14
    12de:	b799                	j	1224 <printint.constprop.0+0x126>
    12e0:	45a5                	li	a1,9
    if (sign)
    12e2:	f40551e3          	bgez	a0,1224 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12e6:	02d00793          	li	a5,45
    12ea:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12ee:	45a1                	li	a1,8
    12f0:	bf15                	j	1224 <printint.constprop.0+0x126>
    i = 15;
    12f2:	45bd                	li	a1,15
    12f4:	bf05                	j	1224 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12f6:	45a1                	li	a1,8
    if (sign)
    12f8:	f20556e3          	bgez	a0,1224 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12fc:	02d00793          	li	a5,45
    1300:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    1304:	459d                	li	a1,7
    1306:	bf39                	j	1224 <printint.constprop.0+0x126>
    1308:	459d                	li	a1,7
    if (sign)
    130a:	f0055de3          	bgez	a0,1224 <printint.constprop.0+0x126>
        buf[i--] = '-';
    130e:	02d00793          	li	a5,45
    1312:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    1316:	4599                	li	a1,6
    1318:	b731                	j	1224 <printint.constprop.0+0x126>

000000000000131a <getchar>:
{
    131a:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    131c:	00f10593          	addi	a1,sp,15
    1320:	4605                	li	a2,1
    1322:	4501                	li	a0,0
{
    1324:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1326:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    132a:	191000ef          	jal	1cba <read>
}
    132e:	60e2                	ld	ra,24(sp)
    1330:	00f14503          	lbu	a0,15(sp)
    1334:	6105                	addi	sp,sp,32
    1336:	8082                	ret

0000000000001338 <putchar>:
{
    1338:	1101                	addi	sp,sp,-32
    133a:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    133c:	00f10593          	addi	a1,sp,15
    1340:	4605                	li	a2,1
    1342:	4505                	li	a0,1
{
    1344:	ec06                	sd	ra,24(sp)
    char byte = c;
    1346:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    134a:	17b000ef          	jal	1cc4 <write>
}
    134e:	60e2                	ld	ra,24(sp)
    1350:	2501                	sext.w	a0,a0
    1352:	6105                	addi	sp,sp,32
    1354:	8082                	ret

0000000000001356 <puts>:
{
    1356:	1141                	addi	sp,sp,-16
    1358:	e406                	sd	ra,8(sp)
    135a:	e022                	sd	s0,0(sp)
    135c:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    135e:	582000ef          	jal	18e0 <strlen>
    1362:	862a                	mv	a2,a0
    1364:	85a2                	mv	a1,s0
    1366:	4505                	li	a0,1
    1368:	15d000ef          	jal	1cc4 <write>
}
    136c:	60a2                	ld	ra,8(sp)
    136e:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1370:	957d                	srai	a0,a0,0x3f
    return r;
    1372:	2501                	sext.w	a0,a0
}
    1374:	0141                	addi	sp,sp,16
    1376:	8082                	ret

0000000000001378 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1378:	7131                	addi	sp,sp,-192
    137a:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    137c:	013c                	addi	a5,sp,136
{
    137e:	f0ca                	sd	s2,96(sp)
    1380:	ecce                	sd	s3,88(sp)
    1382:	e8d2                	sd	s4,80(sp)
    1384:	e4d6                	sd	s5,72(sp)
    1386:	e0da                	sd	s6,64(sp)
    1388:	fc5e                	sd	s7,56(sp)
    138a:	fc86                	sd	ra,120(sp)
    138c:	f8a2                	sd	s0,112(sp)
    138e:	f4a6                	sd	s1,104(sp)
    1390:	e52e                	sd	a1,136(sp)
    1392:	e932                	sd	a2,144(sp)
    1394:	ed36                	sd	a3,152(sp)
    1396:	f13a                	sd	a4,160(sp)
    1398:	f942                	sd	a6,176(sp)
    139a:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    139c:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    139e:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    13a2:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    13a6:	00001b97          	auipc	s7,0x1
    13aa:	c1ab8b93          	addi	s7,s7,-998 # 1fc0 <__clone+0xc4>
        switch (s[1])
    13ae:	07800a93          	li	s5,120
    13b2:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13b6:	00001997          	auipc	s3,0x1
    13ba:	e3a98993          	addi	s3,s3,-454 # 21f0 <digits>
        if (!*s)
    13be:	00054783          	lbu	a5,0(a0)
    13c2:	16078c63          	beqz	a5,153a <printf+0x1c2>
    13c6:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13c8:	19278463          	beq	a5,s2,1550 <printf+0x1d8>
    13cc:	00164783          	lbu	a5,1(a2)
    13d0:	0605                	addi	a2,a2,1
    13d2:	fbfd                	bnez	a5,13c8 <printf+0x50>
    13d4:	84b2                	mv	s1,a2
        l = z - a;
    13d6:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13da:	85aa                	mv	a1,a0
    13dc:	8622                	mv	a2,s0
    13de:	4505                	li	a0,1
    13e0:	0e5000ef          	jal	1cc4 <write>
        if (l)
    13e4:	18041f63          	bnez	s0,1582 <printf+0x20a>
        if (s[1] == 0)
    13e8:	0014c783          	lbu	a5,1(s1)
    13ec:	14078763          	beqz	a5,153a <printf+0x1c2>
        switch (s[1])
    13f0:	1d478163          	beq	a5,s4,15b2 <printf+0x23a>
    13f4:	18fa6963          	bltu	s4,a5,1586 <printf+0x20e>
    13f8:	1b678363          	beq	a5,s6,159e <printf+0x226>
    13fc:	07000713          	li	a4,112
    1400:	1ce79c63          	bne	a5,a4,15d8 <printf+0x260>
            printptr(va_arg(ap, uint64));
    1404:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    1406:	03000793          	li	a5,48
    140a:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    140e:	631c                	ld	a5,0(a4)
    1410:	0721                	addi	a4,a4,8
    1412:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1414:	00479f93          	slli	t6,a5,0x4
    1418:	00879f13          	slli	t5,a5,0x8
    141c:	00c79e93          	slli	t4,a5,0xc
    1420:	01079e13          	slli	t3,a5,0x10
    1424:	01479313          	slli	t1,a5,0x14
    1428:	01879893          	slli	a7,a5,0x18
    142c:	01c79713          	slli	a4,a5,0x1c
    1430:	02479813          	slli	a6,a5,0x24
    1434:	02879513          	slli	a0,a5,0x28
    1438:	02c79593          	slli	a1,a5,0x2c
    143c:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1440:	03c7d293          	srli	t0,a5,0x3c
    1444:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1448:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    144c:	03cfdf93          	srli	t6,t6,0x3c
    1450:	03cf5f13          	srli	t5,t5,0x3c
    1454:	03cede93          	srli	t4,t4,0x3c
    1458:	03ce5e13          	srli	t3,t3,0x3c
    145c:	03c35313          	srli	t1,t1,0x3c
    1460:	03c8d893          	srli	a7,a7,0x3c
    1464:	9371                	srli	a4,a4,0x3c
    1466:	03c85813          	srli	a6,a6,0x3c
    146a:	9171                	srli	a0,a0,0x3c
    146c:	91f1                	srli	a1,a1,0x3c
    146e:	9271                	srli	a2,a2,0x3c
    1470:	974e                	add	a4,a4,s3
    1472:	92f1                	srli	a3,a3,0x3c
    1474:	92ce                	add	t0,t0,s3
    1476:	9fce                	add	t6,t6,s3
    1478:	9f4e                	add	t5,t5,s3
    147a:	9ece                	add	t4,t4,s3
    147c:	9e4e                	add	t3,t3,s3
    147e:	934e                	add	t1,t1,s3
    1480:	98ce                	add	a7,a7,s3
    1482:	93ce                	add	t2,t2,s3
    1484:	984e                	add	a6,a6,s3
    1486:	954e                	add	a0,a0,s3
    1488:	95ce                	add	a1,a1,s3
    148a:	964e                	add	a2,a2,s3
    148c:	0002c283          	lbu	t0,0(t0)
    1490:	000fcf83          	lbu	t6,0(t6)
    1494:	000f4f03          	lbu	t5,0(t5)
    1498:	000ece83          	lbu	t4,0(t4)
    149c:	000e4e03          	lbu	t3,0(t3)
    14a0:	00034303          	lbu	t1,0(t1)
    14a4:	0008c883          	lbu	a7,0(a7)
    14a8:	00074403          	lbu	s0,0(a4)
    14ac:	0003c383          	lbu	t2,0(t2)
    14b0:	00084803          	lbu	a6,0(a6)
    14b4:	00054503          	lbu	a0,0(a0)
    14b8:	0005c583          	lbu	a1,0(a1)
    14bc:	00064603          	lbu	a2,0(a2)
    14c0:	00d98733          	add	a4,s3,a3
    14c4:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14c8:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14cc:	9371                	srli	a4,a4,0x3c
    14ce:	8bbd                	andi	a5,a5,15
    14d0:	00510523          	sb	t0,10(sp)
    14d4:	01f105a3          	sb	t6,11(sp)
    14d8:	01e10623          	sb	t5,12(sp)
    14dc:	01d106a3          	sb	t4,13(sp)
    14e0:	01c10723          	sb	t3,14(sp)
    14e4:	006107a3          	sb	t1,15(sp)
    14e8:	01110823          	sb	a7,16(sp)
    14ec:	00710923          	sb	t2,18(sp)
    14f0:	010109a3          	sb	a6,19(sp)
    14f4:	00a10a23          	sb	a0,20(sp)
    14f8:	00b10aa3          	sb	a1,21(sp)
    14fc:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    1500:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1504:	008108a3          	sb	s0,17(sp)
    1508:	974e                	add	a4,a4,s3
    150a:	97ce                	add	a5,a5,s3
    150c:	00d10ba3          	sb	a3,23(sp)
    1510:	00074703          	lbu	a4,0(a4)
    1514:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1518:	4649                	li	a2,18
    151a:	002c                	addi	a1,sp,8
    151c:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    151e:	00e10c23          	sb	a4,24(sp)
    1522:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1526:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    152a:	79a000ef          	jal	1cc4 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    152e:	00248513          	addi	a0,s1,2
        if (!*s)
    1532:	00054783          	lbu	a5,0(a0)
    1536:	e80798e3          	bnez	a5,13c6 <printf+0x4e>
    }
    va_end(ap);
}
    153a:	70e6                	ld	ra,120(sp)
    153c:	7446                	ld	s0,112(sp)
    153e:	74a6                	ld	s1,104(sp)
    1540:	7906                	ld	s2,96(sp)
    1542:	69e6                	ld	s3,88(sp)
    1544:	6a46                	ld	s4,80(sp)
    1546:	6aa6                	ld	s5,72(sp)
    1548:	6b06                	ld	s6,64(sp)
    154a:	7be2                	ld	s7,56(sp)
    154c:	6129                	addi	sp,sp,192
    154e:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1550:	00064783          	lbu	a5,0(a2)
    1554:	84b2                	mv	s1,a2
    1556:	01278963          	beq	a5,s2,1568 <printf+0x1f0>
    155a:	bdb5                	j	13d6 <printf+0x5e>
    155c:	0024c783          	lbu	a5,2(s1)
    1560:	0605                	addi	a2,a2,1
    1562:	0489                	addi	s1,s1,2
    1564:	e72799e3          	bne	a5,s2,13d6 <printf+0x5e>
    1568:	0014c783          	lbu	a5,1(s1)
    156c:	ff2788e3          	beq	a5,s2,155c <printf+0x1e4>
        l = z - a;
    1570:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1574:	85aa                	mv	a1,a0
    1576:	8622                	mv	a2,s0
    1578:	4505                	li	a0,1
    157a:	74a000ef          	jal	1cc4 <write>
        if (l)
    157e:	e60405e3          	beqz	s0,13e8 <printf+0x70>
    1582:	8526                	mv	a0,s1
    1584:	bd2d                	j	13be <printf+0x46>
        switch (s[1])
    1586:	05579963          	bne	a5,s5,15d8 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    158a:	6782                	ld	a5,0(sp)
    158c:	45c1                	li	a1,16
    158e:	4388                	lw	a0,0(a5)
    1590:	07a1                	addi	a5,a5,8
    1592:	e03e                	sd	a5,0(sp)
    1594:	b6bff0ef          	jal	10fe <printint.constprop.0>
        s += 2;
    1598:	00248513          	addi	a0,s1,2
    159c:	bf59                	j	1532 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    159e:	6782                	ld	a5,0(sp)
    15a0:	45a9                	li	a1,10
    15a2:	4388                	lw	a0,0(a5)
    15a4:	07a1                	addi	a5,a5,8
    15a6:	e03e                	sd	a5,0(sp)
    15a8:	b57ff0ef          	jal	10fe <printint.constprop.0>
        s += 2;
    15ac:	00248513          	addi	a0,s1,2
    15b0:	b749                	j	1532 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    15b2:	6782                	ld	a5,0(sp)
    15b4:	6380                	ld	s0,0(a5)
    15b6:	07a1                	addi	a5,a5,8
    15b8:	e03e                	sd	a5,0(sp)
    15ba:	c031                	beqz	s0,15fe <printf+0x286>
            l = strnlen(a, 200);
    15bc:	0c800593          	li	a1,200
    15c0:	8522                	mv	a0,s0
    15c2:	40a000ef          	jal	19cc <strnlen>
    write(f, s, l);
    15c6:	0005061b          	sext.w	a2,a0
    15ca:	85a2                	mv	a1,s0
    15cc:	4505                	li	a0,1
    15ce:	6f6000ef          	jal	1cc4 <write>
        s += 2;
    15d2:	00248513          	addi	a0,s1,2
    15d6:	bfb1                	j	1532 <printf+0x1ba>
    return write(stdout, &byte, 1);
    15d8:	4605                	li	a2,1
    15da:	002c                	addi	a1,sp,8
    15dc:	4505                	li	a0,1
    char byte = c;
    15de:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15e2:	6e2000ef          	jal	1cc4 <write>
    char byte = c;
    15e6:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15ea:	4605                	li	a2,1
    15ec:	002c                	addi	a1,sp,8
    15ee:	4505                	li	a0,1
    char byte = c;
    15f0:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15f4:	6d0000ef          	jal	1cc4 <write>
        s += 2;
    15f8:	00248513          	addi	a0,s1,2
    15fc:	bf1d                	j	1532 <printf+0x1ba>
                a = "(null)";
    15fe:	845e                	mv	s0,s7
    1600:	bf75                	j	15bc <printf+0x244>

0000000000001602 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    1602:	1141                	addi	sp,sp,-16
    1604:	e406                	sd	ra,8(sp)
    puts(m);
    1606:	d51ff0ef          	jal	1356 <puts>
    exit(-100);
}
    160a:	60a2                	ld	ra,8(sp)
    exit(-100);
    160c:	f9c00513          	li	a0,-100
}
    1610:	0141                	addi	sp,sp,16
    exit(-100);
    1612:	a709                	j	1d14 <exit>

0000000000001614 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1614:	02000793          	li	a5,32
    1618:	00f50663          	beq	a0,a5,1624 <isspace+0x10>
    161c:	355d                	addiw	a0,a0,-9
    161e:	00553513          	sltiu	a0,a0,5
    1622:	8082                	ret
    1624:	4505                	li	a0,1
}
    1626:	8082                	ret

0000000000001628 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1628:	fd05051b          	addiw	a0,a0,-48
}
    162c:	00a53513          	sltiu	a0,a0,10
    1630:	8082                	ret

0000000000001632 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1632:	02000613          	li	a2,32
    1636:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1638:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    163c:	ff77069b          	addiw	a3,a4,-9
    1640:	04c70d63          	beq	a4,a2,169a <atoi+0x68>
    1644:	0007079b          	sext.w	a5,a4
    1648:	04d5f963          	bgeu	a1,a3,169a <atoi+0x68>
        s++;
    switch (*s)
    164c:	02b00693          	li	a3,43
    1650:	04d70a63          	beq	a4,a3,16a4 <atoi+0x72>
    1654:	02d00693          	li	a3,45
    1658:	06d70463          	beq	a4,a3,16c0 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    165c:	fd07859b          	addiw	a1,a5,-48
    1660:	4625                	li	a2,9
    1662:	873e                	mv	a4,a5
    1664:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1666:	4e01                	li	t3,0
    while (isdigit(*s))
    1668:	04b66a63          	bltu	a2,a1,16bc <atoi+0x8a>
    int n = 0, neg = 0;
    166c:	4501                	li	a0,0
    while (isdigit(*s))
    166e:	4825                	li	a6,9
    1670:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1674:	0025179b          	slliw	a5,a0,0x2
    1678:	9d3d                	addw	a0,a0,a5
    167a:	fd07031b          	addiw	t1,a4,-48
    167e:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1682:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1686:	0685                	addi	a3,a3,1
    1688:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    168c:	0006071b          	sext.w	a4,a2
    1690:	feb870e3          	bgeu	a6,a1,1670 <atoi+0x3e>
    return neg ? n : -n;
    1694:	000e0563          	beqz	t3,169e <atoi+0x6c>
}
    1698:	8082                	ret
        s++;
    169a:	0505                	addi	a0,a0,1
    169c:	bf71                	j	1638 <atoi+0x6>
    return neg ? n : -n;
    169e:	4113053b          	subw	a0,t1,a7
    16a2:	8082                	ret
    while (isdigit(*s))
    16a4:	00154783          	lbu	a5,1(a0)
    16a8:	4625                	li	a2,9
        s++;
    16aa:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16ae:	fd07859b          	addiw	a1,a5,-48
    16b2:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16b6:	4e01                	li	t3,0
    while (isdigit(*s))
    16b8:	fab67ae3          	bgeu	a2,a1,166c <atoi+0x3a>
    16bc:	4501                	li	a0,0
}
    16be:	8082                	ret
    while (isdigit(*s))
    16c0:	00154783          	lbu	a5,1(a0)
    16c4:	4625                	li	a2,9
        s++;
    16c6:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16ca:	fd07859b          	addiw	a1,a5,-48
    16ce:	0007871b          	sext.w	a4,a5
    16d2:	feb665e3          	bltu	a2,a1,16bc <atoi+0x8a>
        neg = 1;
    16d6:	4e05                	li	t3,1
    16d8:	bf51                	j	166c <atoi+0x3a>

00000000000016da <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16da:	16060d63          	beqz	a2,1854 <memset+0x17a>
    16de:	40a007b3          	neg	a5,a0
    16e2:	8b9d                	andi	a5,a5,7
    16e4:	00778713          	addi	a4,a5,7
    16e8:	482d                	li	a6,11
    16ea:	0ff5f593          	zext.b	a1,a1
    16ee:	fff60693          	addi	a3,a2,-1
    16f2:	17076263          	bltu	a4,a6,1856 <memset+0x17c>
    16f6:	16e6ea63          	bltu	a3,a4,186a <memset+0x190>
    16fa:	16078563          	beqz	a5,1864 <memset+0x18a>
    16fe:	00b50023          	sb	a1,0(a0)
    1702:	4705                	li	a4,1
    1704:	00150e93          	addi	t4,a0,1
    1708:	14e78c63          	beq	a5,a4,1860 <memset+0x186>
    170c:	00b500a3          	sb	a1,1(a0)
    1710:	4709                	li	a4,2
    1712:	00250e93          	addi	t4,a0,2
    1716:	14e78d63          	beq	a5,a4,1870 <memset+0x196>
    171a:	00b50123          	sb	a1,2(a0)
    171e:	470d                	li	a4,3
    1720:	00350e93          	addi	t4,a0,3
    1724:	12e78b63          	beq	a5,a4,185a <memset+0x180>
    1728:	00b501a3          	sb	a1,3(a0)
    172c:	4711                	li	a4,4
    172e:	00450e93          	addi	t4,a0,4
    1732:	14e78163          	beq	a5,a4,1874 <memset+0x19a>
    1736:	00b50223          	sb	a1,4(a0)
    173a:	4715                	li	a4,5
    173c:	00550e93          	addi	t4,a0,5
    1740:	12e78c63          	beq	a5,a4,1878 <memset+0x19e>
    1744:	00b502a3          	sb	a1,5(a0)
    1748:	471d                	li	a4,7
    174a:	00650e93          	addi	t4,a0,6
    174e:	12e79763          	bne	a5,a4,187c <memset+0x1a2>
    1752:	00750e93          	addi	t4,a0,7
    1756:	00b50323          	sb	a1,6(a0)
    175a:	4f1d                	li	t5,7
    175c:	00859713          	slli	a4,a1,0x8
    1760:	8f4d                	or	a4,a4,a1
    1762:	01059e13          	slli	t3,a1,0x10
    1766:	01c76e33          	or	t3,a4,t3
    176a:	01859313          	slli	t1,a1,0x18
    176e:	006e6333          	or	t1,t3,t1
    1772:	02059893          	slli	a7,a1,0x20
    1776:	011368b3          	or	a7,t1,a7
    177a:	02859813          	slli	a6,a1,0x28
    177e:	40f60333          	sub	t1,a2,a5
    1782:	0108e833          	or	a6,a7,a6
    1786:	03059693          	slli	a3,a1,0x30
    178a:	00d866b3          	or	a3,a6,a3
    178e:	03859713          	slli	a4,a1,0x38
    1792:	97aa                	add	a5,a5,a0
    1794:	ff837813          	andi	a6,t1,-8
    1798:	8f55                	or	a4,a4,a3
    179a:	00f806b3          	add	a3,a6,a5
    179e:	e398                	sd	a4,0(a5)
    17a0:	07a1                	addi	a5,a5,8
    17a2:	fed79ee3          	bne	a5,a3,179e <memset+0xc4>
    17a6:	ff837693          	andi	a3,t1,-8
    17aa:	00de87b3          	add	a5,t4,a3
    17ae:	01e6873b          	addw	a4,a3,t5
    17b2:	0ad30663          	beq	t1,a3,185e <memset+0x184>
    17b6:	00b78023          	sb	a1,0(a5)
    17ba:	0017069b          	addiw	a3,a4,1
    17be:	08c6fb63          	bgeu	a3,a2,1854 <memset+0x17a>
    17c2:	00b780a3          	sb	a1,1(a5)
    17c6:	0027069b          	addiw	a3,a4,2
    17ca:	08c6f563          	bgeu	a3,a2,1854 <memset+0x17a>
    17ce:	00b78123          	sb	a1,2(a5)
    17d2:	0037069b          	addiw	a3,a4,3
    17d6:	06c6ff63          	bgeu	a3,a2,1854 <memset+0x17a>
    17da:	00b781a3          	sb	a1,3(a5)
    17de:	0047069b          	addiw	a3,a4,4
    17e2:	06c6f963          	bgeu	a3,a2,1854 <memset+0x17a>
    17e6:	00b78223          	sb	a1,4(a5)
    17ea:	0057069b          	addiw	a3,a4,5
    17ee:	06c6f363          	bgeu	a3,a2,1854 <memset+0x17a>
    17f2:	00b782a3          	sb	a1,5(a5)
    17f6:	0067069b          	addiw	a3,a4,6
    17fa:	04c6fd63          	bgeu	a3,a2,1854 <memset+0x17a>
    17fe:	00b78323          	sb	a1,6(a5)
    1802:	0077069b          	addiw	a3,a4,7
    1806:	04c6f763          	bgeu	a3,a2,1854 <memset+0x17a>
    180a:	00b783a3          	sb	a1,7(a5)
    180e:	0087069b          	addiw	a3,a4,8
    1812:	04c6f163          	bgeu	a3,a2,1854 <memset+0x17a>
    1816:	00b78423          	sb	a1,8(a5)
    181a:	0097069b          	addiw	a3,a4,9
    181e:	02c6fb63          	bgeu	a3,a2,1854 <memset+0x17a>
    1822:	00b784a3          	sb	a1,9(a5)
    1826:	00a7069b          	addiw	a3,a4,10
    182a:	02c6f563          	bgeu	a3,a2,1854 <memset+0x17a>
    182e:	00b78523          	sb	a1,10(a5)
    1832:	00b7069b          	addiw	a3,a4,11
    1836:	00c6ff63          	bgeu	a3,a2,1854 <memset+0x17a>
    183a:	00b785a3          	sb	a1,11(a5)
    183e:	00c7069b          	addiw	a3,a4,12
    1842:	00c6f963          	bgeu	a3,a2,1854 <memset+0x17a>
    1846:	00b78623          	sb	a1,12(a5)
    184a:	2735                	addiw	a4,a4,13
    184c:	00c77463          	bgeu	a4,a2,1854 <memset+0x17a>
    1850:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1854:	8082                	ret
    1856:	472d                	li	a4,11
    1858:	bd79                	j	16f6 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    185a:	4f0d                	li	t5,3
    185c:	b701                	j	175c <memset+0x82>
    185e:	8082                	ret
    1860:	4f05                	li	t5,1
    1862:	bded                	j	175c <memset+0x82>
    1864:	8eaa                	mv	t4,a0
    1866:	4f01                	li	t5,0
    1868:	bdd5                	j	175c <memset+0x82>
    186a:	87aa                	mv	a5,a0
    186c:	4701                	li	a4,0
    186e:	b7a1                	j	17b6 <memset+0xdc>
    1870:	4f09                	li	t5,2
    1872:	b5ed                	j	175c <memset+0x82>
    1874:	4f11                	li	t5,4
    1876:	b5dd                	j	175c <memset+0x82>
    1878:	4f15                	li	t5,5
    187a:	b5cd                	j	175c <memset+0x82>
    187c:	4f19                	li	t5,6
    187e:	bdf9                	j	175c <memset+0x82>

0000000000001880 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1880:	00054783          	lbu	a5,0(a0)
    1884:	0005c703          	lbu	a4,0(a1)
    1888:	00e79863          	bne	a5,a4,1898 <strcmp+0x18>
    188c:	0505                	addi	a0,a0,1
    188e:	0585                	addi	a1,a1,1
    1890:	fbe5                	bnez	a5,1880 <strcmp>
    1892:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1894:	9d19                	subw	a0,a0,a4
    1896:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1898:	0007851b          	sext.w	a0,a5
    189c:	bfe5                	j	1894 <strcmp+0x14>

000000000000189e <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    189e:	ce05                	beqz	a2,18d6 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18a0:	00054703          	lbu	a4,0(a0)
    18a4:	0005c783          	lbu	a5,0(a1)
    18a8:	cb0d                	beqz	a4,18da <strncmp+0x3c>
    if (!n--)
    18aa:	167d                	addi	a2,a2,-1
    18ac:	00c506b3          	add	a3,a0,a2
    18b0:	a819                	j	18c6 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18b2:	00a68e63          	beq	a3,a0,18ce <strncmp+0x30>
    18b6:	0505                	addi	a0,a0,1
    18b8:	00e79b63          	bne	a5,a4,18ce <strncmp+0x30>
    18bc:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18c0:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18c4:	cb19                	beqz	a4,18da <strncmp+0x3c>
    18c6:	0005c783          	lbu	a5,0(a1)
    18ca:	0585                	addi	a1,a1,1
    18cc:	f3fd                	bnez	a5,18b2 <strncmp+0x14>
    return *l - *r;
    18ce:	0007051b          	sext.w	a0,a4
    18d2:	9d1d                	subw	a0,a0,a5
    18d4:	8082                	ret
        return 0;
    18d6:	4501                	li	a0,0
}
    18d8:	8082                	ret
    18da:	4501                	li	a0,0
    return *l - *r;
    18dc:	9d1d                	subw	a0,a0,a5
    18de:	8082                	ret

00000000000018e0 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18e0:	00757793          	andi	a5,a0,7
    18e4:	cf89                	beqz	a5,18fe <strlen+0x1e>
    18e6:	87aa                	mv	a5,a0
    18e8:	a029                	j	18f2 <strlen+0x12>
    18ea:	0785                	addi	a5,a5,1
    18ec:	0077f713          	andi	a4,a5,7
    18f0:	cb01                	beqz	a4,1900 <strlen+0x20>
        if (!*s)
    18f2:	0007c703          	lbu	a4,0(a5)
    18f6:	fb75                	bnez	a4,18ea <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18f8:	40a78533          	sub	a0,a5,a0
}
    18fc:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18fe:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    1900:	6394                	ld	a3,0(a5)
    1902:	00000597          	auipc	a1,0x0
    1906:	6c65b583          	ld	a1,1734(a1) # 1fc8 <__clone+0xcc>
    190a:	00000617          	auipc	a2,0x0
    190e:	6c663603          	ld	a2,1734(a2) # 1fd0 <__clone+0xd4>
    1912:	a019                	j	1918 <strlen+0x38>
    1914:	6794                	ld	a3,8(a5)
    1916:	07a1                	addi	a5,a5,8
    1918:	00b68733          	add	a4,a3,a1
    191c:	fff6c693          	not	a3,a3
    1920:	8f75                	and	a4,a4,a3
    1922:	8f71                	and	a4,a4,a2
    1924:	db65                	beqz	a4,1914 <strlen+0x34>
    for (; *s; s++)
    1926:	0007c703          	lbu	a4,0(a5)
    192a:	d779                	beqz	a4,18f8 <strlen+0x18>
    192c:	0017c703          	lbu	a4,1(a5)
    1930:	0785                	addi	a5,a5,1
    1932:	d379                	beqz	a4,18f8 <strlen+0x18>
    1934:	0017c703          	lbu	a4,1(a5)
    1938:	0785                	addi	a5,a5,1
    193a:	fb6d                	bnez	a4,192c <strlen+0x4c>
    193c:	bf75                	j	18f8 <strlen+0x18>

000000000000193e <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    193e:	00757713          	andi	a4,a0,7
{
    1942:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1944:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1948:	cb19                	beqz	a4,195e <memchr+0x20>
    194a:	ce25                	beqz	a2,19c2 <memchr+0x84>
    194c:	0007c703          	lbu	a4,0(a5)
    1950:	04b70e63          	beq	a4,a1,19ac <memchr+0x6e>
    1954:	0785                	addi	a5,a5,1
    1956:	0077f713          	andi	a4,a5,7
    195a:	167d                	addi	a2,a2,-1
    195c:	f77d                	bnez	a4,194a <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    195e:	4501                	li	a0,0
    if (n && *s != c)
    1960:	c235                	beqz	a2,19c4 <memchr+0x86>
    1962:	0007c703          	lbu	a4,0(a5)
    1966:	04b70363          	beq	a4,a1,19ac <memchr+0x6e>
        size_t k = ONES * c;
    196a:	00000517          	auipc	a0,0x0
    196e:	66e53503          	ld	a0,1646(a0) # 1fd8 <__clone+0xdc>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1972:	471d                	li	a4,7
        size_t k = ONES * c;
    1974:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1978:	02c77a63          	bgeu	a4,a2,19ac <memchr+0x6e>
    197c:	00000897          	auipc	a7,0x0
    1980:	64c8b883          	ld	a7,1612(a7) # 1fc8 <__clone+0xcc>
    1984:	00000817          	auipc	a6,0x0
    1988:	64c83803          	ld	a6,1612(a6) # 1fd0 <__clone+0xd4>
    198c:	431d                	li	t1,7
    198e:	a029                	j	1998 <memchr+0x5a>
    1990:	1661                	addi	a2,a2,-8
    1992:	07a1                	addi	a5,a5,8
    1994:	02c37963          	bgeu	t1,a2,19c6 <memchr+0x88>
    1998:	6398                	ld	a4,0(a5)
    199a:	8f29                	xor	a4,a4,a0
    199c:	011706b3          	add	a3,a4,a7
    19a0:	fff74713          	not	a4,a4
    19a4:	8f75                	and	a4,a4,a3
    19a6:	01077733          	and	a4,a4,a6
    19aa:	d37d                	beqz	a4,1990 <memchr+0x52>
    19ac:	853e                	mv	a0,a5
    19ae:	97b2                	add	a5,a5,a2
    19b0:	a021                	j	19b8 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19b2:	0505                	addi	a0,a0,1
    19b4:	00f50763          	beq	a0,a5,19c2 <memchr+0x84>
    19b8:	00054703          	lbu	a4,0(a0)
    19bc:	feb71be3          	bne	a4,a1,19b2 <memchr+0x74>
    19c0:	8082                	ret
    return n ? (void *)s : 0;
    19c2:	4501                	li	a0,0
}
    19c4:	8082                	ret
    return n ? (void *)s : 0;
    19c6:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19c8:	f275                	bnez	a2,19ac <memchr+0x6e>
}
    19ca:	8082                	ret

00000000000019cc <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19cc:	1101                	addi	sp,sp,-32
    19ce:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19d0:	862e                	mv	a2,a1
{
    19d2:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19d4:	4581                	li	a1,0
{
    19d6:	e426                	sd	s1,8(sp)
    19d8:	ec06                	sd	ra,24(sp)
    19da:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19dc:	f63ff0ef          	jal	193e <memchr>
    return p ? p - s : n;
    19e0:	c519                	beqz	a0,19ee <strnlen+0x22>
}
    19e2:	60e2                	ld	ra,24(sp)
    19e4:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19e6:	8d05                	sub	a0,a0,s1
}
    19e8:	64a2                	ld	s1,8(sp)
    19ea:	6105                	addi	sp,sp,32
    19ec:	8082                	ret
    19ee:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19f0:	8522                	mv	a0,s0
}
    19f2:	6442                	ld	s0,16(sp)
    19f4:	64a2                	ld	s1,8(sp)
    19f6:	6105                	addi	sp,sp,32
    19f8:	8082                	ret

00000000000019fa <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19fa:	00b547b3          	xor	a5,a0,a1
    19fe:	8b9d                	andi	a5,a5,7
    1a00:	eb95                	bnez	a5,1a34 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    1a02:	0075f793          	andi	a5,a1,7
    1a06:	e7b1                	bnez	a5,1a52 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a08:	6198                	ld	a4,0(a1)
    1a0a:	00000617          	auipc	a2,0x0
    1a0e:	5be63603          	ld	a2,1470(a2) # 1fc8 <__clone+0xcc>
    1a12:	00000817          	auipc	a6,0x0
    1a16:	5be83803          	ld	a6,1470(a6) # 1fd0 <__clone+0xd4>
    1a1a:	a029                	j	1a24 <strcpy+0x2a>
    1a1c:	e118                	sd	a4,0(a0)
    1a1e:	6598                	ld	a4,8(a1)
    1a20:	05a1                	addi	a1,a1,8
    1a22:	0521                	addi	a0,a0,8
    1a24:	00c707b3          	add	a5,a4,a2
    1a28:	fff74693          	not	a3,a4
    1a2c:	8ff5                	and	a5,a5,a3
    1a2e:	0107f7b3          	and	a5,a5,a6
    1a32:	d7ed                	beqz	a5,1a1c <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a34:	0005c783          	lbu	a5,0(a1)
    1a38:	00f50023          	sb	a5,0(a0)
    1a3c:	c785                	beqz	a5,1a64 <strcpy+0x6a>
    1a3e:	0015c783          	lbu	a5,1(a1)
    1a42:	0505                	addi	a0,a0,1
    1a44:	0585                	addi	a1,a1,1
    1a46:	00f50023          	sb	a5,0(a0)
    1a4a:	fbf5                	bnez	a5,1a3e <strcpy+0x44>
        ;
    return d;
}
    1a4c:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a4e:	0505                	addi	a0,a0,1
    1a50:	df45                	beqz	a4,1a08 <strcpy+0xe>
            if (!(*d = *s))
    1a52:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a56:	0585                	addi	a1,a1,1
    1a58:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a5c:	00f50023          	sb	a5,0(a0)
    1a60:	f7fd                	bnez	a5,1a4e <strcpy+0x54>
}
    1a62:	8082                	ret
    1a64:	8082                	ret

0000000000001a66 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a66:	00b547b3          	xor	a5,a0,a1
    1a6a:	8b9d                	andi	a5,a5,7
    1a6c:	1a079863          	bnez	a5,1c1c <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a70:	0075f793          	andi	a5,a1,7
    1a74:	16078463          	beqz	a5,1bdc <strncpy+0x176>
    1a78:	ea01                	bnez	a2,1a88 <strncpy+0x22>
    1a7a:	a421                	j	1c82 <strncpy+0x21c>
    1a7c:	167d                	addi	a2,a2,-1
    1a7e:	0505                	addi	a0,a0,1
    1a80:	14070e63          	beqz	a4,1bdc <strncpy+0x176>
    1a84:	1a060863          	beqz	a2,1c34 <strncpy+0x1ce>
    1a88:	0005c783          	lbu	a5,0(a1)
    1a8c:	0585                	addi	a1,a1,1
    1a8e:	0075f713          	andi	a4,a1,7
    1a92:	00f50023          	sb	a5,0(a0)
    1a96:	f3fd                	bnez	a5,1a7c <strncpy+0x16>
    1a98:	4805                	li	a6,1
    1a9a:	1a061863          	bnez	a2,1c4a <strncpy+0x1e4>
    1a9e:	40a007b3          	neg	a5,a0
    1aa2:	8b9d                	andi	a5,a5,7
    1aa4:	4681                	li	a3,0
    1aa6:	18061a63          	bnez	a2,1c3a <strncpy+0x1d4>
    1aaa:	00778713          	addi	a4,a5,7
    1aae:	45ad                	li	a1,11
    1ab0:	18b76363          	bltu	a4,a1,1c36 <strncpy+0x1d0>
    1ab4:	1ae6eb63          	bltu	a3,a4,1c6a <strncpy+0x204>
    1ab8:	1a078363          	beqz	a5,1c5e <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1abc:	00050023          	sb	zero,0(a0)
    1ac0:	4685                	li	a3,1
    1ac2:	00150713          	addi	a4,a0,1
    1ac6:	18d78f63          	beq	a5,a3,1c64 <strncpy+0x1fe>
    1aca:	000500a3          	sb	zero,1(a0)
    1ace:	4689                	li	a3,2
    1ad0:	00250713          	addi	a4,a0,2
    1ad4:	18d78e63          	beq	a5,a3,1c70 <strncpy+0x20a>
    1ad8:	00050123          	sb	zero,2(a0)
    1adc:	468d                	li	a3,3
    1ade:	00350713          	addi	a4,a0,3
    1ae2:	16d78c63          	beq	a5,a3,1c5a <strncpy+0x1f4>
    1ae6:	000501a3          	sb	zero,3(a0)
    1aea:	4691                	li	a3,4
    1aec:	00450713          	addi	a4,a0,4
    1af0:	18d78263          	beq	a5,a3,1c74 <strncpy+0x20e>
    1af4:	00050223          	sb	zero,4(a0)
    1af8:	4695                	li	a3,5
    1afa:	00550713          	addi	a4,a0,5
    1afe:	16d78d63          	beq	a5,a3,1c78 <strncpy+0x212>
    1b02:	000502a3          	sb	zero,5(a0)
    1b06:	469d                	li	a3,7
    1b08:	00650713          	addi	a4,a0,6
    1b0c:	16d79863          	bne	a5,a3,1c7c <strncpy+0x216>
    1b10:	00750713          	addi	a4,a0,7
    1b14:	00050323          	sb	zero,6(a0)
    1b18:	40f80833          	sub	a6,a6,a5
    1b1c:	ff887593          	andi	a1,a6,-8
    1b20:	97aa                	add	a5,a5,a0
    1b22:	95be                	add	a1,a1,a5
    1b24:	0007b023          	sd	zero,0(a5)
    1b28:	07a1                	addi	a5,a5,8
    1b2a:	feb79de3          	bne	a5,a1,1b24 <strncpy+0xbe>
    1b2e:	ff887593          	andi	a1,a6,-8
    1b32:	9ead                	addw	a3,a3,a1
    1b34:	00b707b3          	add	a5,a4,a1
    1b38:	12b80863          	beq	a6,a1,1c68 <strncpy+0x202>
    1b3c:	00078023          	sb	zero,0(a5)
    1b40:	0016871b          	addiw	a4,a3,1
    1b44:	0ec77863          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1b48:	000780a3          	sb	zero,1(a5)
    1b4c:	0026871b          	addiw	a4,a3,2
    1b50:	0ec77263          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1b54:	00078123          	sb	zero,2(a5)
    1b58:	0036871b          	addiw	a4,a3,3
    1b5c:	0cc77c63          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1b60:	000781a3          	sb	zero,3(a5)
    1b64:	0046871b          	addiw	a4,a3,4
    1b68:	0cc77663          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1b6c:	00078223          	sb	zero,4(a5)
    1b70:	0056871b          	addiw	a4,a3,5
    1b74:	0cc77063          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1b78:	000782a3          	sb	zero,5(a5)
    1b7c:	0066871b          	addiw	a4,a3,6
    1b80:	0ac77a63          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1b84:	00078323          	sb	zero,6(a5)
    1b88:	0076871b          	addiw	a4,a3,7
    1b8c:	0ac77463          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1b90:	000783a3          	sb	zero,7(a5)
    1b94:	0086871b          	addiw	a4,a3,8
    1b98:	08c77e63          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1b9c:	00078423          	sb	zero,8(a5)
    1ba0:	0096871b          	addiw	a4,a3,9
    1ba4:	08c77863          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1ba8:	000784a3          	sb	zero,9(a5)
    1bac:	00a6871b          	addiw	a4,a3,10
    1bb0:	08c77263          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1bb4:	00078523          	sb	zero,10(a5)
    1bb8:	00b6871b          	addiw	a4,a3,11
    1bbc:	06c77c63          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1bc0:	000785a3          	sb	zero,11(a5)
    1bc4:	00c6871b          	addiw	a4,a3,12
    1bc8:	06c77663          	bgeu	a4,a2,1c34 <strncpy+0x1ce>
    1bcc:	00078623          	sb	zero,12(a5)
    1bd0:	26b5                	addiw	a3,a3,13
    1bd2:	06c6f163          	bgeu	a3,a2,1c34 <strncpy+0x1ce>
    1bd6:	000786a3          	sb	zero,13(a5)
    1bda:	8082                	ret
            ;
        if (!n || !*s)
    1bdc:	c645                	beqz	a2,1c84 <strncpy+0x21e>
    1bde:	0005c783          	lbu	a5,0(a1)
    1be2:	ea078be3          	beqz	a5,1a98 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1be6:	479d                	li	a5,7
    1be8:	02c7ff63          	bgeu	a5,a2,1c26 <strncpy+0x1c0>
    1bec:	00000897          	auipc	a7,0x0
    1bf0:	3dc8b883          	ld	a7,988(a7) # 1fc8 <__clone+0xcc>
    1bf4:	00000817          	auipc	a6,0x0
    1bf8:	3dc83803          	ld	a6,988(a6) # 1fd0 <__clone+0xd4>
    1bfc:	431d                	li	t1,7
    1bfe:	6198                	ld	a4,0(a1)
    1c00:	011707b3          	add	a5,a4,a7
    1c04:	fff74693          	not	a3,a4
    1c08:	8ff5                	and	a5,a5,a3
    1c0a:	0107f7b3          	and	a5,a5,a6
    1c0e:	ef81                	bnez	a5,1c26 <strncpy+0x1c0>
            *wd = *ws;
    1c10:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c12:	1661                	addi	a2,a2,-8
    1c14:	05a1                	addi	a1,a1,8
    1c16:	0521                	addi	a0,a0,8
    1c18:	fec363e3          	bltu	t1,a2,1bfe <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c1c:	e609                	bnez	a2,1c26 <strncpy+0x1c0>
    1c1e:	a08d                	j	1c80 <strncpy+0x21a>
    1c20:	167d                	addi	a2,a2,-1
    1c22:	0505                	addi	a0,a0,1
    1c24:	ca01                	beqz	a2,1c34 <strncpy+0x1ce>
    1c26:	0005c783          	lbu	a5,0(a1)
    1c2a:	0585                	addi	a1,a1,1
    1c2c:	00f50023          	sb	a5,0(a0)
    1c30:	fbe5                	bnez	a5,1c20 <strncpy+0x1ba>
        ;
tail:
    1c32:	b59d                	j	1a98 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c34:	8082                	ret
    1c36:	472d                	li	a4,11
    1c38:	bdb5                	j	1ab4 <strncpy+0x4e>
    1c3a:	00778713          	addi	a4,a5,7
    1c3e:	45ad                	li	a1,11
    1c40:	fff60693          	addi	a3,a2,-1
    1c44:	e6b778e3          	bgeu	a4,a1,1ab4 <strncpy+0x4e>
    1c48:	b7fd                	j	1c36 <strncpy+0x1d0>
    1c4a:	40a007b3          	neg	a5,a0
    1c4e:	8832                	mv	a6,a2
    1c50:	8b9d                	andi	a5,a5,7
    1c52:	4681                	li	a3,0
    1c54:	e4060be3          	beqz	a2,1aaa <strncpy+0x44>
    1c58:	b7cd                	j	1c3a <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c5a:	468d                	li	a3,3
    1c5c:	bd75                	j	1b18 <strncpy+0xb2>
    1c5e:	872a                	mv	a4,a0
    1c60:	4681                	li	a3,0
    1c62:	bd5d                	j	1b18 <strncpy+0xb2>
    1c64:	4685                	li	a3,1
    1c66:	bd4d                	j	1b18 <strncpy+0xb2>
    1c68:	8082                	ret
    1c6a:	87aa                	mv	a5,a0
    1c6c:	4681                	li	a3,0
    1c6e:	b5f9                	j	1b3c <strncpy+0xd6>
    1c70:	4689                	li	a3,2
    1c72:	b55d                	j	1b18 <strncpy+0xb2>
    1c74:	4691                	li	a3,4
    1c76:	b54d                	j	1b18 <strncpy+0xb2>
    1c78:	4695                	li	a3,5
    1c7a:	bd79                	j	1b18 <strncpy+0xb2>
    1c7c:	4699                	li	a3,6
    1c7e:	bd69                	j	1b18 <strncpy+0xb2>
    1c80:	8082                	ret
    1c82:	8082                	ret
    1c84:	8082                	ret

0000000000001c86 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c86:	87aa                	mv	a5,a0
    1c88:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c8a:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c8e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c92:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c94:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c96:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c9a:	2501                	sext.w	a0,a0
    1c9c:	8082                	ret

0000000000001c9e <openat>:
    register long a7 __asm__("a7") = n;
    1c9e:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1ca2:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ca6:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1caa:	2501                	sext.w	a0,a0
    1cac:	8082                	ret

0000000000001cae <close>:
    register long a7 __asm__("a7") = n;
    1cae:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cb2:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cb6:	2501                	sext.w	a0,a0
    1cb8:	8082                	ret

0000000000001cba <read>:
    register long a7 __asm__("a7") = n;
    1cba:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cbe:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cc2:	8082                	ret

0000000000001cc4 <write>:
    register long a7 __asm__("a7") = n;
    1cc4:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cc8:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1ccc:	8082                	ret

0000000000001cce <getpid>:
    register long a7 __asm__("a7") = n;
    1cce:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cd2:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cd6:	2501                	sext.w	a0,a0
    1cd8:	8082                	ret

0000000000001cda <getppid>:
    register long a7 __asm__("a7") = n;
    1cda:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cde:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1ce2:	2501                	sext.w	a0,a0
    1ce4:	8082                	ret

0000000000001ce6 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1ce6:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cea:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cee:	2501                	sext.w	a0,a0
    1cf0:	8082                	ret

0000000000001cf2 <fork>:
    register long a7 __asm__("a7") = n;
    1cf2:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cf6:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cf8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cfa:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cfe:	2501                	sext.w	a0,a0
    1d00:	8082                	ret

0000000000001d02 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1d02:	85b2                	mv	a1,a2
    1d04:	863a                	mv	a2,a4
    if (stack)
    1d06:	c191                	beqz	a1,1d0a <clone+0x8>
	stack += stack_size;
    1d08:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d0a:	4781                	li	a5,0
    1d0c:	4701                	li	a4,0
    1d0e:	4681                	li	a3,0
    1d10:	2601                	sext.w	a2,a2
    1d12:	a2ed                	j	1efc <__clone>

0000000000001d14 <exit>:
    register long a7 __asm__("a7") = n;
    1d14:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d18:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d1c:	8082                	ret

0000000000001d1e <waitpid>:
    register long a7 __asm__("a7") = n;
    1d1e:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d22:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d24:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d28:	2501                	sext.w	a0,a0
    1d2a:	8082                	ret

0000000000001d2c <exec>:
    register long a7 __asm__("a7") = n;
    1d2c:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d30:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d34:	2501                	sext.w	a0,a0
    1d36:	8082                	ret

0000000000001d38 <execve>:
    register long a7 __asm__("a7") = n;
    1d38:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d3c:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d40:	2501                	sext.w	a0,a0
    1d42:	8082                	ret

0000000000001d44 <times>:
    register long a7 __asm__("a7") = n;
    1d44:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d48:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d4c:	2501                	sext.w	a0,a0
    1d4e:	8082                	ret

0000000000001d50 <get_time>:

int64 get_time()
{
    1d50:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d52:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d56:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d58:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d5a:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d5e:	2501                	sext.w	a0,a0
    1d60:	ed09                	bnez	a0,1d7a <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d62:	67a2                	ld	a5,8(sp)
    1d64:	3e800713          	li	a4,1000
    1d68:	00015503          	lhu	a0,0(sp)
    1d6c:	02e7d7b3          	divu	a5,a5,a4
    1d70:	02e50533          	mul	a0,a0,a4
    1d74:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d76:	0141                	addi	sp,sp,16
    1d78:	8082                	ret
        return -1;
    1d7a:	557d                	li	a0,-1
    1d7c:	bfed                	j	1d76 <get_time+0x26>

0000000000001d7e <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d7e:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d82:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d86:	2501                	sext.w	a0,a0
    1d88:	8082                	ret

0000000000001d8a <time>:
    register long a7 __asm__("a7") = n;
    1d8a:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d8e:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d92:	2501                	sext.w	a0,a0
    1d94:	8082                	ret

0000000000001d96 <sleep>:

int sleep(unsigned long long time)
{
    1d96:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d98:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d9a:	850a                	mv	a0,sp
    1d9c:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d9e:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1da2:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1da4:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1da8:	e501                	bnez	a0,1db0 <sleep+0x1a>
    return 0;
    1daa:	4501                	li	a0,0
}
    1dac:	0141                	addi	sp,sp,16
    1dae:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1db0:	4502                	lw	a0,0(sp)
}
    1db2:	0141                	addi	sp,sp,16
    1db4:	8082                	ret

0000000000001db6 <set_priority>:
    register long a7 __asm__("a7") = n;
    1db6:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1dba:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1dbe:	2501                	sext.w	a0,a0
    1dc0:	8082                	ret

0000000000001dc2 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1dc2:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1dc6:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1dca:	8082                	ret

0000000000001dcc <munmap>:
    register long a7 __asm__("a7") = n;
    1dcc:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd0:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1dd4:	2501                	sext.w	a0,a0
    1dd6:	8082                	ret

0000000000001dd8 <wait>:

int wait(int *code)
{
    1dd8:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dda:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1dde:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1de0:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1de2:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1de4:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1de8:	2501                	sext.w	a0,a0
    1dea:	8082                	ret

0000000000001dec <spawn>:
    register long a7 __asm__("a7") = n;
    1dec:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1df0:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1df4:	2501                	sext.w	a0,a0
    1df6:	8082                	ret

0000000000001df8 <mailread>:
    register long a7 __asm__("a7") = n;
    1df8:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dfc:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1e00:	2501                	sext.w	a0,a0
    1e02:	8082                	ret

0000000000001e04 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1e04:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e08:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e0c:	2501                	sext.w	a0,a0
    1e0e:	8082                	ret

0000000000001e10 <fstat>:
    register long a7 __asm__("a7") = n;
    1e10:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e14:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e18:	2501                	sext.w	a0,a0
    1e1a:	8082                	ret

0000000000001e1c <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e1c:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e1e:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e22:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e24:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e28:	2501                	sext.w	a0,a0
    1e2a:	8082                	ret

0000000000001e2c <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e2c:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e2e:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e32:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e34:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e38:	2501                	sext.w	a0,a0
    1e3a:	8082                	ret

0000000000001e3c <link>:

int link(char *old_path, char *new_path)
{
    1e3c:	87aa                	mv	a5,a0
    1e3e:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e40:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e44:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e48:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e4a:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e4e:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e50:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e54:	2501                	sext.w	a0,a0
    1e56:	8082                	ret

0000000000001e58 <unlink>:

int unlink(char *path)
{
    1e58:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e5a:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e5e:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e62:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e64:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e68:	2501                	sext.w	a0,a0
    1e6a:	8082                	ret

0000000000001e6c <uname>:
    register long a7 __asm__("a7") = n;
    1e6c:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e70:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e74:	2501                	sext.w	a0,a0
    1e76:	8082                	ret

0000000000001e78 <brk>:
    register long a7 __asm__("a7") = n;
    1e78:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e7c:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e80:	2501                	sext.w	a0,a0
    1e82:	8082                	ret

0000000000001e84 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e84:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e86:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e8a:	8082                	ret

0000000000001e8c <chdir>:
    register long a7 __asm__("a7") = n;
    1e8c:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e90:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e94:	2501                	sext.w	a0,a0
    1e96:	8082                	ret

0000000000001e98 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e98:	862e                	mv	a2,a1
    1e9a:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e9c:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e9e:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1ea2:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1ea6:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1ea8:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eaa:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1eae:	2501                	sext.w	a0,a0
    1eb0:	8082                	ret

0000000000001eb2 <getdents>:
    register long a7 __asm__("a7") = n;
    1eb2:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eb6:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1eba:	2501                	sext.w	a0,a0
    1ebc:	8082                	ret

0000000000001ebe <pipe>:
    register long a7 __asm__("a7") = n;
    1ebe:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ec2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ec4:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1ec8:	2501                	sext.w	a0,a0
    1eca:	8082                	ret

0000000000001ecc <dup>:
    register long a7 __asm__("a7") = n;
    1ecc:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1ece:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1ed2:	2501                	sext.w	a0,a0
    1ed4:	8082                	ret

0000000000001ed6 <dup2>:
    register long a7 __asm__("a7") = n;
    1ed6:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ed8:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eda:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ede:	2501                	sext.w	a0,a0
    1ee0:	8082                	ret

0000000000001ee2 <mount>:
    register long a7 __asm__("a7") = n;
    1ee2:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ee6:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1eea:	2501                	sext.w	a0,a0
    1eec:	8082                	ret

0000000000001eee <umount>:
    register long a7 __asm__("a7") = n;
    1eee:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1ef2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ef4:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ef8:	2501                	sext.w	a0,a0
    1efa:	8082                	ret

0000000000001efc <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1efc:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1efe:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1f00:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1f02:	8532                	mv	a0,a2
	mv a2, a4
    1f04:	863a                	mv	a2,a4
	mv a3, a5
    1f06:	86be                	mv	a3,a5
	mv a4, a6
    1f08:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f0a:	0dc00893          	li	a7,220
	ecall
    1f0e:	00000073          	ecall

	beqz a0, 1f
    1f12:	c111                	beqz	a0,1f16 <__clone+0x1a>
	# Parent
	ret
    1f14:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f16:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f18:	6522                	ld	a0,8(sp)
	jalr a1
    1f1a:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f1c:	05d00893          	li	a7,93
	ecall
    1f20:	00000073          	ecall
