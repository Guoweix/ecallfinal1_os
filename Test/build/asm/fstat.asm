
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/fstat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a0f1                	j	10ce <__start_main>

0000000000001004 <test_fstat>:

#define AT_FDCWD (-100) //相对路径

//Stat *kst;
static struct kstat kst;
void test_fstat() {
    1004:	1101                	addi	sp,sp,-32
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f0a50513          	addi	a0,a0,-246 # 1f10 <__clone+0x2a>
void test_fstat() {
    100e:	ec06                	sd	ra,24(sp)
    1010:	e822                	sd	s0,16(sp)
	TEST_START(__func__);
    1012:	32e000ef          	jal	1340 <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	07250513          	addi	a0,a0,114 # 2088 <__func__.0>
    101e:	322000ef          	jal	1340 <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	f0650513          	addi	a0,a0,-250 # 1f28 <__clone+0x42>
    102a:	316000ef          	jal	1340 <puts>
	int fd = open("./text.txt", 0);
    102e:	4581                	li	a1,0
    1030:	00001517          	auipc	a0,0x1
    1034:	f0850513          	addi	a0,a0,-248 # 1f38 <__clone+0x52>
    1038:	439000ef          	jal	1c70 <open>
	int ret = fstat(fd, &kst);
    103c:	00001597          	auipc	a1,0x1
    1040:	fcc58593          	addi	a1,a1,-52 # 2008 <kst>
    1044:	5b7000ef          	jal	1dfa <fstat>
    1048:	842a                	mv	s0,a0
	printf("fstat ret: %d\n", ret);
    104a:	85aa                	mv	a1,a0
    104c:	00001517          	auipc	a0,0x1
    1050:	efc50513          	addi	a0,a0,-260 # 1f48 <__clone+0x62>
    1054:	30e000ef          	jal	1362 <printf>
	assert(ret >= 0);
    1058:	04044c63          	bltz	s0,10b0 <test_fstat+0xac>

	printf("fstat: dev: %d, inode: %d, mode: %d, nlink: %d, size: %d, atime: %d, mtime: %d, ctime: %d\n",
    105c:	00001597          	auipc	a1,0x1
    1060:	fac58593          	addi	a1,a1,-84 # 2008 <kst>
    1064:	0685b303          	ld	t1,104(a1)
    1068:	0585b883          	ld	a7,88(a1)
    106c:	0485b803          	ld	a6,72(a1)
    1070:	799c                	ld	a5,48(a1)
    1072:	49d8                	lw	a4,20(a1)
    1074:	4994                	lw	a3,16(a1)
    1076:	6590                	ld	a2,8(a1)
    1078:	618c                	ld	a1,0(a1)
    107a:	00001517          	auipc	a0,0x1
    107e:	efe50513          	addi	a0,a0,-258 # 1f78 <__clone+0x92>
    1082:	e01a                	sd	t1,0(sp)
    1084:	2de000ef          	jal	1362 <printf>
	      kst.st_dev, kst.st_ino, kst.st_mode, kst.st_nlink, kst.st_size, kst.st_atime_sec, kst.st_mtime_sec, kst.st_ctime_sec);

	TEST_END(__func__);
    1088:	00001517          	auipc	a0,0x1
    108c:	f5050513          	addi	a0,a0,-176 # 1fd8 <__clone+0xf2>
    1090:	2b0000ef          	jal	1340 <puts>
    1094:	00001517          	auipc	a0,0x1
    1098:	ff450513          	addi	a0,a0,-12 # 2088 <__func__.0>
    109c:	2a4000ef          	jal	1340 <puts>
}
    10a0:	6442                	ld	s0,16(sp)
    10a2:	60e2                	ld	ra,24(sp)
	TEST_END(__func__);
    10a4:	00001517          	auipc	a0,0x1
    10a8:	e8450513          	addi	a0,a0,-380 # 1f28 <__clone+0x42>
}
    10ac:	6105                	addi	sp,sp,32
	TEST_END(__func__);
    10ae:	ac49                	j	1340 <puts>
	assert(ret >= 0);
    10b0:	00001517          	auipc	a0,0x1
    10b4:	ea850513          	addi	a0,a0,-344 # 1f58 <__clone+0x72>
    10b8:	534000ef          	jal	15ec <panic>
    10bc:	b745                	j	105c <test_fstat+0x58>

00000000000010be <main>:

int main(void) {
    10be:	1141                	addi	sp,sp,-16
    10c0:	e406                	sd	ra,8(sp)
	test_fstat();
    10c2:	f43ff0ef          	jal	1004 <test_fstat>
	return 0;
}
    10c6:	60a2                	ld	ra,8(sp)
    10c8:	4501                	li	a0,0
    10ca:	0141                	addi	sp,sp,16
    10cc:	8082                	ret

00000000000010ce <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10ce:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10d0:	4108                	lw	a0,0(a0)
{
    10d2:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10d4:	05a1                	addi	a1,a1,8
{
    10d6:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10d8:	fe7ff0ef          	jal	10be <main>
    10dc:	423000ef          	jal	1cfe <exit>
	return 0;
}
    10e0:	60a2                	ld	ra,8(sp)
    10e2:	4501                	li	a0,0
    10e4:	0141                	addi	sp,sp,16
    10e6:	8082                	ret

00000000000010e8 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10e8:	7179                	addi	sp,sp,-48
    10ea:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10ec:	12054b63          	bltz	a0,1222 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10f0:	02b577bb          	remuw	a5,a0,a1
    10f4:	00001617          	auipc	a2,0x1
    10f8:	fa460613          	addi	a2,a2,-92 # 2098 <digits>
    buf[16] = 0;
    10fc:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1100:	0005871b          	sext.w	a4,a1
    1104:	1782                	slli	a5,a5,0x20
    1106:	9381                	srli	a5,a5,0x20
    1108:	97b2                	add	a5,a5,a2
    110a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    110e:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1112:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1116:	1cb56363          	bltu	a0,a1,12dc <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    111a:	45b9                	li	a1,14
    111c:	02e877bb          	remuw	a5,a6,a4
    1120:	1782                	slli	a5,a5,0x20
    1122:	9381                	srli	a5,a5,0x20
    1124:	97b2                	add	a5,a5,a2
    1126:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    112a:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    112e:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1132:	0ce86e63          	bltu	a6,a4,120e <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1136:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    113a:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    113e:	1582                	slli	a1,a1,0x20
    1140:	9181                	srli	a1,a1,0x20
    1142:	95b2                	add	a1,a1,a2
    1144:	0005c583          	lbu	a1,0(a1)
    1148:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    114c:	0007859b          	sext.w	a1,a5
    1150:	12e6ec63          	bltu	a3,a4,1288 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1154:	02e7f6bb          	remuw	a3,a5,a4
    1158:	1682                	slli	a3,a3,0x20
    115a:	9281                	srli	a3,a3,0x20
    115c:	96b2                	add	a3,a3,a2
    115e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1162:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1166:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    116a:	12e5e863          	bltu	a1,a4,129a <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    116e:	02e876bb          	remuw	a3,a6,a4
    1172:	1682                	slli	a3,a3,0x20
    1174:	9281                	srli	a3,a3,0x20
    1176:	96b2                	add	a3,a3,a2
    1178:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    117c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1180:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1184:	12e86463          	bltu	a6,a4,12ac <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1188:	02e5f6bb          	remuw	a3,a1,a4
    118c:	1682                	slli	a3,a3,0x20
    118e:	9281                	srli	a3,a3,0x20
    1190:	96b2                	add	a3,a3,a2
    1192:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1196:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    119a:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    119e:	0ce5ec63          	bltu	a1,a4,1276 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    11a2:	02e876bb          	remuw	a3,a6,a4
    11a6:	1682                	slli	a3,a3,0x20
    11a8:	9281                	srli	a3,a3,0x20
    11aa:	96b2                	add	a3,a3,a2
    11ac:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11b0:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11b4:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11b8:	10e86963          	bltu	a6,a4,12ca <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11bc:	02e5f6bb          	remuw	a3,a1,a4
    11c0:	1682                	slli	a3,a3,0x20
    11c2:	9281                	srli	a3,a3,0x20
    11c4:	96b2                	add	a3,a3,a2
    11c6:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11ca:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11ce:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11d2:	10e5e763          	bltu	a1,a4,12e0 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11d6:	02e876bb          	remuw	a3,a6,a4
    11da:	1682                	slli	a3,a3,0x20
    11dc:	9281                	srli	a3,a3,0x20
    11de:	96b2                	add	a3,a3,a2
    11e0:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11e4:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11e8:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11ec:	10e86363          	bltu	a6,a4,12f2 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11f0:	1782                	slli	a5,a5,0x20
    11f2:	9381                	srli	a5,a5,0x20
    11f4:	97b2                	add	a5,a5,a2
    11f6:	0007c783          	lbu	a5,0(a5)
    11fa:	4599                	li	a1,6
    11fc:	00f10723          	sb	a5,14(sp)

    if (sign)
    1200:	00055763          	bgez	a0,120e <printint.constprop.0+0x126>
        buf[i--] = '-';
    1204:	02d00793          	li	a5,45
    1208:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    120c:	4595                	li	a1,5
    write(f, s, l);
    120e:	003c                	addi	a5,sp,8
    1210:	4641                	li	a2,16
    1212:	9e0d                	subw	a2,a2,a1
    1214:	4505                	li	a0,1
    1216:	95be                	add	a1,a1,a5
    1218:	297000ef          	jal	1cae <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    121c:	70a2                	ld	ra,40(sp)
    121e:	6145                	addi	sp,sp,48
    1220:	8082                	ret
        x = -xx;
    1222:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1226:	02b877bb          	remuw	a5,a6,a1
    122a:	00001617          	auipc	a2,0x1
    122e:	e6e60613          	addi	a2,a2,-402 # 2098 <digits>
    buf[16] = 0;
    1232:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1236:	0005871b          	sext.w	a4,a1
    123a:	1782                	slli	a5,a5,0x20
    123c:	9381                	srli	a5,a5,0x20
    123e:	97b2                	add	a5,a5,a2
    1240:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1244:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1248:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    124c:	06b86963          	bltu	a6,a1,12be <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1250:	02e8f7bb          	remuw	a5,a7,a4
    1254:	1782                	slli	a5,a5,0x20
    1256:	9381                	srli	a5,a5,0x20
    1258:	97b2                	add	a5,a5,a2
    125a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    125e:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1262:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1266:	ece8f8e3          	bgeu	a7,a4,1136 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    126a:	02d00793          	li	a5,45
    126e:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1272:	45b5                	li	a1,13
    1274:	bf69                	j	120e <printint.constprop.0+0x126>
    1276:	45a9                	li	a1,10
    if (sign)
    1278:	f8055be3          	bgez	a0,120e <printint.constprop.0+0x126>
        buf[i--] = '-';
    127c:	02d00793          	li	a5,45
    1280:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1284:	45a5                	li	a1,9
    1286:	b761                	j	120e <printint.constprop.0+0x126>
    1288:	45b5                	li	a1,13
    if (sign)
    128a:	f80552e3          	bgez	a0,120e <printint.constprop.0+0x126>
        buf[i--] = '-';
    128e:	02d00793          	li	a5,45
    1292:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1296:	45b1                	li	a1,12
    1298:	bf9d                	j	120e <printint.constprop.0+0x126>
    129a:	45b1                	li	a1,12
    if (sign)
    129c:	f60559e3          	bgez	a0,120e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12a0:	02d00793          	li	a5,45
    12a4:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12a8:	45ad                	li	a1,11
    12aa:	b795                	j	120e <printint.constprop.0+0x126>
    12ac:	45ad                	li	a1,11
    if (sign)
    12ae:	f60550e3          	bgez	a0,120e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b2:	02d00793          	li	a5,45
    12b6:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12ba:	45a9                	li	a1,10
    12bc:	bf89                	j	120e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12be:	02d00793          	li	a5,45
    12c2:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12c6:	45b9                	li	a1,14
    12c8:	b799                	j	120e <printint.constprop.0+0x126>
    12ca:	45a5                	li	a1,9
    if (sign)
    12cc:	f40551e3          	bgez	a0,120e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d0:	02d00793          	li	a5,45
    12d4:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12d8:	45a1                	li	a1,8
    12da:	bf15                	j	120e <printint.constprop.0+0x126>
    i = 15;
    12dc:	45bd                	li	a1,15
    12de:	bf05                	j	120e <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12e0:	45a1                	li	a1,8
    if (sign)
    12e2:	f20556e3          	bgez	a0,120e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12e6:	02d00793          	li	a5,45
    12ea:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12ee:	459d                	li	a1,7
    12f0:	bf39                	j	120e <printint.constprop.0+0x126>
    12f2:	459d                	li	a1,7
    if (sign)
    12f4:	f0055de3          	bgez	a0,120e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12f8:	02d00793          	li	a5,45
    12fc:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    1300:	4599                	li	a1,6
    1302:	b731                	j	120e <printint.constprop.0+0x126>

0000000000001304 <getchar>:
{
    1304:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1306:	00f10593          	addi	a1,sp,15
    130a:	4605                	li	a2,1
    130c:	4501                	li	a0,0
{
    130e:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1310:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1314:	191000ef          	jal	1ca4 <read>
}
    1318:	60e2                	ld	ra,24(sp)
    131a:	00f14503          	lbu	a0,15(sp)
    131e:	6105                	addi	sp,sp,32
    1320:	8082                	ret

0000000000001322 <putchar>:
{
    1322:	1101                	addi	sp,sp,-32
    1324:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1326:	00f10593          	addi	a1,sp,15
    132a:	4605                	li	a2,1
    132c:	4505                	li	a0,1
{
    132e:	ec06                	sd	ra,24(sp)
    char byte = c;
    1330:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1334:	17b000ef          	jal	1cae <write>
}
    1338:	60e2                	ld	ra,24(sp)
    133a:	2501                	sext.w	a0,a0
    133c:	6105                	addi	sp,sp,32
    133e:	8082                	ret

0000000000001340 <puts>:
{
    1340:	1141                	addi	sp,sp,-16
    1342:	e406                	sd	ra,8(sp)
    1344:	e022                	sd	s0,0(sp)
    1346:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1348:	582000ef          	jal	18ca <strlen>
    134c:	862a                	mv	a2,a0
    134e:	85a2                	mv	a1,s0
    1350:	4505                	li	a0,1
    1352:	15d000ef          	jal	1cae <write>
}
    1356:	60a2                	ld	ra,8(sp)
    1358:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    135a:	957d                	srai	a0,a0,0x3f
    return r;
    135c:	2501                	sext.w	a0,a0
}
    135e:	0141                	addi	sp,sp,16
    1360:	8082                	ret

0000000000001362 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1362:	7131                	addi	sp,sp,-192
    1364:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1366:	013c                	addi	a5,sp,136
{
    1368:	f0ca                	sd	s2,96(sp)
    136a:	ecce                	sd	s3,88(sp)
    136c:	e8d2                	sd	s4,80(sp)
    136e:	e4d6                	sd	s5,72(sp)
    1370:	e0da                	sd	s6,64(sp)
    1372:	fc5e                	sd	s7,56(sp)
    1374:	fc86                	sd	ra,120(sp)
    1376:	f8a2                	sd	s0,112(sp)
    1378:	f4a6                	sd	s1,104(sp)
    137a:	e52e                	sd	a1,136(sp)
    137c:	e932                	sd	a2,144(sp)
    137e:	ed36                	sd	a3,152(sp)
    1380:	f13a                	sd	a4,160(sp)
    1382:	f942                	sd	a6,176(sp)
    1384:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1386:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1388:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    138c:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1390:	00001b97          	auipc	s7,0x1
    1394:	c58b8b93          	addi	s7,s7,-936 # 1fe8 <__clone+0x102>
        switch (s[1])
    1398:	07800a93          	li	s5,120
    139c:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13a0:	00001997          	auipc	s3,0x1
    13a4:	cf898993          	addi	s3,s3,-776 # 2098 <digits>
        if (!*s)
    13a8:	00054783          	lbu	a5,0(a0)
    13ac:	16078c63          	beqz	a5,1524 <printf+0x1c2>
    13b0:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13b2:	19278463          	beq	a5,s2,153a <printf+0x1d8>
    13b6:	00164783          	lbu	a5,1(a2)
    13ba:	0605                	addi	a2,a2,1
    13bc:	fbfd                	bnez	a5,13b2 <printf+0x50>
    13be:	84b2                	mv	s1,a2
        l = z - a;
    13c0:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13c4:	85aa                	mv	a1,a0
    13c6:	8622                	mv	a2,s0
    13c8:	4505                	li	a0,1
    13ca:	0e5000ef          	jal	1cae <write>
        if (l)
    13ce:	18041f63          	bnez	s0,156c <printf+0x20a>
        if (s[1] == 0)
    13d2:	0014c783          	lbu	a5,1(s1)
    13d6:	14078763          	beqz	a5,1524 <printf+0x1c2>
        switch (s[1])
    13da:	1d478163          	beq	a5,s4,159c <printf+0x23a>
    13de:	18fa6963          	bltu	s4,a5,1570 <printf+0x20e>
    13e2:	1b678363          	beq	a5,s6,1588 <printf+0x226>
    13e6:	07000713          	li	a4,112
    13ea:	1ce79c63          	bne	a5,a4,15c2 <printf+0x260>
            printptr(va_arg(ap, uint64));
    13ee:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13f0:	03000793          	li	a5,48
    13f4:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13f8:	631c                	ld	a5,0(a4)
    13fa:	0721                	addi	a4,a4,8
    13fc:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13fe:	00479f93          	slli	t6,a5,0x4
    1402:	00879f13          	slli	t5,a5,0x8
    1406:	00c79e93          	slli	t4,a5,0xc
    140a:	01079e13          	slli	t3,a5,0x10
    140e:	01479313          	slli	t1,a5,0x14
    1412:	01879893          	slli	a7,a5,0x18
    1416:	01c79713          	slli	a4,a5,0x1c
    141a:	02479813          	slli	a6,a5,0x24
    141e:	02879513          	slli	a0,a5,0x28
    1422:	02c79593          	slli	a1,a5,0x2c
    1426:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    142a:	03c7d293          	srli	t0,a5,0x3c
    142e:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1432:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1436:	03cfdf93          	srli	t6,t6,0x3c
    143a:	03cf5f13          	srli	t5,t5,0x3c
    143e:	03cede93          	srli	t4,t4,0x3c
    1442:	03ce5e13          	srli	t3,t3,0x3c
    1446:	03c35313          	srli	t1,t1,0x3c
    144a:	03c8d893          	srli	a7,a7,0x3c
    144e:	9371                	srli	a4,a4,0x3c
    1450:	03c85813          	srli	a6,a6,0x3c
    1454:	9171                	srli	a0,a0,0x3c
    1456:	91f1                	srli	a1,a1,0x3c
    1458:	9271                	srli	a2,a2,0x3c
    145a:	974e                	add	a4,a4,s3
    145c:	92f1                	srli	a3,a3,0x3c
    145e:	92ce                	add	t0,t0,s3
    1460:	9fce                	add	t6,t6,s3
    1462:	9f4e                	add	t5,t5,s3
    1464:	9ece                	add	t4,t4,s3
    1466:	9e4e                	add	t3,t3,s3
    1468:	934e                	add	t1,t1,s3
    146a:	98ce                	add	a7,a7,s3
    146c:	93ce                	add	t2,t2,s3
    146e:	984e                	add	a6,a6,s3
    1470:	954e                	add	a0,a0,s3
    1472:	95ce                	add	a1,a1,s3
    1474:	964e                	add	a2,a2,s3
    1476:	0002c283          	lbu	t0,0(t0)
    147a:	000fcf83          	lbu	t6,0(t6)
    147e:	000f4f03          	lbu	t5,0(t5)
    1482:	000ece83          	lbu	t4,0(t4)
    1486:	000e4e03          	lbu	t3,0(t3)
    148a:	00034303          	lbu	t1,0(t1)
    148e:	0008c883          	lbu	a7,0(a7)
    1492:	00074403          	lbu	s0,0(a4)
    1496:	0003c383          	lbu	t2,0(t2)
    149a:	00084803          	lbu	a6,0(a6)
    149e:	00054503          	lbu	a0,0(a0)
    14a2:	0005c583          	lbu	a1,0(a1)
    14a6:	00064603          	lbu	a2,0(a2)
    14aa:	00d98733          	add	a4,s3,a3
    14ae:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14b2:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14b6:	9371                	srli	a4,a4,0x3c
    14b8:	8bbd                	andi	a5,a5,15
    14ba:	00510523          	sb	t0,10(sp)
    14be:	01f105a3          	sb	t6,11(sp)
    14c2:	01e10623          	sb	t5,12(sp)
    14c6:	01d106a3          	sb	t4,13(sp)
    14ca:	01c10723          	sb	t3,14(sp)
    14ce:	006107a3          	sb	t1,15(sp)
    14d2:	01110823          	sb	a7,16(sp)
    14d6:	00710923          	sb	t2,18(sp)
    14da:	010109a3          	sb	a6,19(sp)
    14de:	00a10a23          	sb	a0,20(sp)
    14e2:	00b10aa3          	sb	a1,21(sp)
    14e6:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14ea:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ee:	008108a3          	sb	s0,17(sp)
    14f2:	974e                	add	a4,a4,s3
    14f4:	97ce                	add	a5,a5,s3
    14f6:	00d10ba3          	sb	a3,23(sp)
    14fa:	00074703          	lbu	a4,0(a4)
    14fe:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1502:	4649                	li	a2,18
    1504:	002c                	addi	a1,sp,8
    1506:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1508:	00e10c23          	sb	a4,24(sp)
    150c:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1510:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1514:	79a000ef          	jal	1cae <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    1518:	00248513          	addi	a0,s1,2
        if (!*s)
    151c:	00054783          	lbu	a5,0(a0)
    1520:	e80798e3          	bnez	a5,13b0 <printf+0x4e>
    }
    va_end(ap);
}
    1524:	70e6                	ld	ra,120(sp)
    1526:	7446                	ld	s0,112(sp)
    1528:	74a6                	ld	s1,104(sp)
    152a:	7906                	ld	s2,96(sp)
    152c:	69e6                	ld	s3,88(sp)
    152e:	6a46                	ld	s4,80(sp)
    1530:	6aa6                	ld	s5,72(sp)
    1532:	6b06                	ld	s6,64(sp)
    1534:	7be2                	ld	s7,56(sp)
    1536:	6129                	addi	sp,sp,192
    1538:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    153a:	00064783          	lbu	a5,0(a2)
    153e:	84b2                	mv	s1,a2
    1540:	01278963          	beq	a5,s2,1552 <printf+0x1f0>
    1544:	bdb5                	j	13c0 <printf+0x5e>
    1546:	0024c783          	lbu	a5,2(s1)
    154a:	0605                	addi	a2,a2,1
    154c:	0489                	addi	s1,s1,2
    154e:	e72799e3          	bne	a5,s2,13c0 <printf+0x5e>
    1552:	0014c783          	lbu	a5,1(s1)
    1556:	ff2788e3          	beq	a5,s2,1546 <printf+0x1e4>
        l = z - a;
    155a:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    155e:	85aa                	mv	a1,a0
    1560:	8622                	mv	a2,s0
    1562:	4505                	li	a0,1
    1564:	74a000ef          	jal	1cae <write>
        if (l)
    1568:	e60405e3          	beqz	s0,13d2 <printf+0x70>
    156c:	8526                	mv	a0,s1
    156e:	bd2d                	j	13a8 <printf+0x46>
        switch (s[1])
    1570:	05579963          	bne	a5,s5,15c2 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1574:	6782                	ld	a5,0(sp)
    1576:	45c1                	li	a1,16
    1578:	4388                	lw	a0,0(a5)
    157a:	07a1                	addi	a5,a5,8
    157c:	e03e                	sd	a5,0(sp)
    157e:	b6bff0ef          	jal	10e8 <printint.constprop.0>
        s += 2;
    1582:	00248513          	addi	a0,s1,2
    1586:	bf59                	j	151c <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1588:	6782                	ld	a5,0(sp)
    158a:	45a9                	li	a1,10
    158c:	4388                	lw	a0,0(a5)
    158e:	07a1                	addi	a5,a5,8
    1590:	e03e                	sd	a5,0(sp)
    1592:	b57ff0ef          	jal	10e8 <printint.constprop.0>
        s += 2;
    1596:	00248513          	addi	a0,s1,2
    159a:	b749                	j	151c <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    159c:	6782                	ld	a5,0(sp)
    159e:	6380                	ld	s0,0(a5)
    15a0:	07a1                	addi	a5,a5,8
    15a2:	e03e                	sd	a5,0(sp)
    15a4:	c031                	beqz	s0,15e8 <printf+0x286>
            l = strnlen(a, 200);
    15a6:	0c800593          	li	a1,200
    15aa:	8522                	mv	a0,s0
    15ac:	40a000ef          	jal	19b6 <strnlen>
    write(f, s, l);
    15b0:	0005061b          	sext.w	a2,a0
    15b4:	85a2                	mv	a1,s0
    15b6:	4505                	li	a0,1
    15b8:	6f6000ef          	jal	1cae <write>
        s += 2;
    15bc:	00248513          	addi	a0,s1,2
    15c0:	bfb1                	j	151c <printf+0x1ba>
    return write(stdout, &byte, 1);
    15c2:	4605                	li	a2,1
    15c4:	002c                	addi	a1,sp,8
    15c6:	4505                	li	a0,1
    char byte = c;
    15c8:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15cc:	6e2000ef          	jal	1cae <write>
    char byte = c;
    15d0:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15d4:	4605                	li	a2,1
    15d6:	002c                	addi	a1,sp,8
    15d8:	4505                	li	a0,1
    char byte = c;
    15da:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15de:	6d0000ef          	jal	1cae <write>
        s += 2;
    15e2:	00248513          	addi	a0,s1,2
    15e6:	bf1d                	j	151c <printf+0x1ba>
                a = "(null)";
    15e8:	845e                	mv	s0,s7
    15ea:	bf75                	j	15a6 <printf+0x244>

00000000000015ec <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15ec:	1141                	addi	sp,sp,-16
    15ee:	e406                	sd	ra,8(sp)
    puts(m);
    15f0:	d51ff0ef          	jal	1340 <puts>
    exit(-100);
}
    15f4:	60a2                	ld	ra,8(sp)
    exit(-100);
    15f6:	f9c00513          	li	a0,-100
}
    15fa:	0141                	addi	sp,sp,16
    exit(-100);
    15fc:	a709                	j	1cfe <exit>

00000000000015fe <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15fe:	02000793          	li	a5,32
    1602:	00f50663          	beq	a0,a5,160e <isspace+0x10>
    1606:	355d                	addiw	a0,a0,-9
    1608:	00553513          	sltiu	a0,a0,5
    160c:	8082                	ret
    160e:	4505                	li	a0,1
}
    1610:	8082                	ret

0000000000001612 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1612:	fd05051b          	addiw	a0,a0,-48
}
    1616:	00a53513          	sltiu	a0,a0,10
    161a:	8082                	ret

000000000000161c <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    161c:	02000613          	li	a2,32
    1620:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1622:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1626:	ff77069b          	addiw	a3,a4,-9
    162a:	04c70d63          	beq	a4,a2,1684 <atoi+0x68>
    162e:	0007079b          	sext.w	a5,a4
    1632:	04d5f963          	bgeu	a1,a3,1684 <atoi+0x68>
        s++;
    switch (*s)
    1636:	02b00693          	li	a3,43
    163a:	04d70a63          	beq	a4,a3,168e <atoi+0x72>
    163e:	02d00693          	li	a3,45
    1642:	06d70463          	beq	a4,a3,16aa <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1646:	fd07859b          	addiw	a1,a5,-48
    164a:	4625                	li	a2,9
    164c:	873e                	mv	a4,a5
    164e:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1650:	4e01                	li	t3,0
    while (isdigit(*s))
    1652:	04b66a63          	bltu	a2,a1,16a6 <atoi+0x8a>
    int n = 0, neg = 0;
    1656:	4501                	li	a0,0
    while (isdigit(*s))
    1658:	4825                	li	a6,9
    165a:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    165e:	0025179b          	slliw	a5,a0,0x2
    1662:	9d3d                	addw	a0,a0,a5
    1664:	fd07031b          	addiw	t1,a4,-48
    1668:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    166c:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1670:	0685                	addi	a3,a3,1
    1672:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1676:	0006071b          	sext.w	a4,a2
    167a:	feb870e3          	bgeu	a6,a1,165a <atoi+0x3e>
    return neg ? n : -n;
    167e:	000e0563          	beqz	t3,1688 <atoi+0x6c>
}
    1682:	8082                	ret
        s++;
    1684:	0505                	addi	a0,a0,1
    1686:	bf71                	j	1622 <atoi+0x6>
    return neg ? n : -n;
    1688:	4113053b          	subw	a0,t1,a7
    168c:	8082                	ret
    while (isdigit(*s))
    168e:	00154783          	lbu	a5,1(a0)
    1692:	4625                	li	a2,9
        s++;
    1694:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1698:	fd07859b          	addiw	a1,a5,-48
    169c:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16a0:	4e01                	li	t3,0
    while (isdigit(*s))
    16a2:	fab67ae3          	bgeu	a2,a1,1656 <atoi+0x3a>
    16a6:	4501                	li	a0,0
}
    16a8:	8082                	ret
    while (isdigit(*s))
    16aa:	00154783          	lbu	a5,1(a0)
    16ae:	4625                	li	a2,9
        s++;
    16b0:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16b4:	fd07859b          	addiw	a1,a5,-48
    16b8:	0007871b          	sext.w	a4,a5
    16bc:	feb665e3          	bltu	a2,a1,16a6 <atoi+0x8a>
        neg = 1;
    16c0:	4e05                	li	t3,1
    16c2:	bf51                	j	1656 <atoi+0x3a>

00000000000016c4 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16c4:	16060d63          	beqz	a2,183e <memset+0x17a>
    16c8:	40a007b3          	neg	a5,a0
    16cc:	8b9d                	andi	a5,a5,7
    16ce:	00778713          	addi	a4,a5,7
    16d2:	482d                	li	a6,11
    16d4:	0ff5f593          	zext.b	a1,a1
    16d8:	fff60693          	addi	a3,a2,-1
    16dc:	17076263          	bltu	a4,a6,1840 <memset+0x17c>
    16e0:	16e6ea63          	bltu	a3,a4,1854 <memset+0x190>
    16e4:	16078563          	beqz	a5,184e <memset+0x18a>
    16e8:	00b50023          	sb	a1,0(a0)
    16ec:	4705                	li	a4,1
    16ee:	00150e93          	addi	t4,a0,1
    16f2:	14e78c63          	beq	a5,a4,184a <memset+0x186>
    16f6:	00b500a3          	sb	a1,1(a0)
    16fa:	4709                	li	a4,2
    16fc:	00250e93          	addi	t4,a0,2
    1700:	14e78d63          	beq	a5,a4,185a <memset+0x196>
    1704:	00b50123          	sb	a1,2(a0)
    1708:	470d                	li	a4,3
    170a:	00350e93          	addi	t4,a0,3
    170e:	12e78b63          	beq	a5,a4,1844 <memset+0x180>
    1712:	00b501a3          	sb	a1,3(a0)
    1716:	4711                	li	a4,4
    1718:	00450e93          	addi	t4,a0,4
    171c:	14e78163          	beq	a5,a4,185e <memset+0x19a>
    1720:	00b50223          	sb	a1,4(a0)
    1724:	4715                	li	a4,5
    1726:	00550e93          	addi	t4,a0,5
    172a:	12e78c63          	beq	a5,a4,1862 <memset+0x19e>
    172e:	00b502a3          	sb	a1,5(a0)
    1732:	471d                	li	a4,7
    1734:	00650e93          	addi	t4,a0,6
    1738:	12e79763          	bne	a5,a4,1866 <memset+0x1a2>
    173c:	00750e93          	addi	t4,a0,7
    1740:	00b50323          	sb	a1,6(a0)
    1744:	4f1d                	li	t5,7
    1746:	00859713          	slli	a4,a1,0x8
    174a:	8f4d                	or	a4,a4,a1
    174c:	01059e13          	slli	t3,a1,0x10
    1750:	01c76e33          	or	t3,a4,t3
    1754:	01859313          	slli	t1,a1,0x18
    1758:	006e6333          	or	t1,t3,t1
    175c:	02059893          	slli	a7,a1,0x20
    1760:	011368b3          	or	a7,t1,a7
    1764:	02859813          	slli	a6,a1,0x28
    1768:	40f60333          	sub	t1,a2,a5
    176c:	0108e833          	or	a6,a7,a6
    1770:	03059693          	slli	a3,a1,0x30
    1774:	00d866b3          	or	a3,a6,a3
    1778:	03859713          	slli	a4,a1,0x38
    177c:	97aa                	add	a5,a5,a0
    177e:	ff837813          	andi	a6,t1,-8
    1782:	8f55                	or	a4,a4,a3
    1784:	00f806b3          	add	a3,a6,a5
    1788:	e398                	sd	a4,0(a5)
    178a:	07a1                	addi	a5,a5,8
    178c:	fed79ee3          	bne	a5,a3,1788 <memset+0xc4>
    1790:	ff837693          	andi	a3,t1,-8
    1794:	00de87b3          	add	a5,t4,a3
    1798:	01e6873b          	addw	a4,a3,t5
    179c:	0ad30663          	beq	t1,a3,1848 <memset+0x184>
    17a0:	00b78023          	sb	a1,0(a5)
    17a4:	0017069b          	addiw	a3,a4,1
    17a8:	08c6fb63          	bgeu	a3,a2,183e <memset+0x17a>
    17ac:	00b780a3          	sb	a1,1(a5)
    17b0:	0027069b          	addiw	a3,a4,2
    17b4:	08c6f563          	bgeu	a3,a2,183e <memset+0x17a>
    17b8:	00b78123          	sb	a1,2(a5)
    17bc:	0037069b          	addiw	a3,a4,3
    17c0:	06c6ff63          	bgeu	a3,a2,183e <memset+0x17a>
    17c4:	00b781a3          	sb	a1,3(a5)
    17c8:	0047069b          	addiw	a3,a4,4
    17cc:	06c6f963          	bgeu	a3,a2,183e <memset+0x17a>
    17d0:	00b78223          	sb	a1,4(a5)
    17d4:	0057069b          	addiw	a3,a4,5
    17d8:	06c6f363          	bgeu	a3,a2,183e <memset+0x17a>
    17dc:	00b782a3          	sb	a1,5(a5)
    17e0:	0067069b          	addiw	a3,a4,6
    17e4:	04c6fd63          	bgeu	a3,a2,183e <memset+0x17a>
    17e8:	00b78323          	sb	a1,6(a5)
    17ec:	0077069b          	addiw	a3,a4,7
    17f0:	04c6f763          	bgeu	a3,a2,183e <memset+0x17a>
    17f4:	00b783a3          	sb	a1,7(a5)
    17f8:	0087069b          	addiw	a3,a4,8
    17fc:	04c6f163          	bgeu	a3,a2,183e <memset+0x17a>
    1800:	00b78423          	sb	a1,8(a5)
    1804:	0097069b          	addiw	a3,a4,9
    1808:	02c6fb63          	bgeu	a3,a2,183e <memset+0x17a>
    180c:	00b784a3          	sb	a1,9(a5)
    1810:	00a7069b          	addiw	a3,a4,10
    1814:	02c6f563          	bgeu	a3,a2,183e <memset+0x17a>
    1818:	00b78523          	sb	a1,10(a5)
    181c:	00b7069b          	addiw	a3,a4,11
    1820:	00c6ff63          	bgeu	a3,a2,183e <memset+0x17a>
    1824:	00b785a3          	sb	a1,11(a5)
    1828:	00c7069b          	addiw	a3,a4,12
    182c:	00c6f963          	bgeu	a3,a2,183e <memset+0x17a>
    1830:	00b78623          	sb	a1,12(a5)
    1834:	2735                	addiw	a4,a4,13
    1836:	00c77463          	bgeu	a4,a2,183e <memset+0x17a>
    183a:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    183e:	8082                	ret
    1840:	472d                	li	a4,11
    1842:	bd79                	j	16e0 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1844:	4f0d                	li	t5,3
    1846:	b701                	j	1746 <memset+0x82>
    1848:	8082                	ret
    184a:	4f05                	li	t5,1
    184c:	bded                	j	1746 <memset+0x82>
    184e:	8eaa                	mv	t4,a0
    1850:	4f01                	li	t5,0
    1852:	bdd5                	j	1746 <memset+0x82>
    1854:	87aa                	mv	a5,a0
    1856:	4701                	li	a4,0
    1858:	b7a1                	j	17a0 <memset+0xdc>
    185a:	4f09                	li	t5,2
    185c:	b5ed                	j	1746 <memset+0x82>
    185e:	4f11                	li	t5,4
    1860:	b5dd                	j	1746 <memset+0x82>
    1862:	4f15                	li	t5,5
    1864:	b5cd                	j	1746 <memset+0x82>
    1866:	4f19                	li	t5,6
    1868:	bdf9                	j	1746 <memset+0x82>

000000000000186a <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    186a:	00054783          	lbu	a5,0(a0)
    186e:	0005c703          	lbu	a4,0(a1)
    1872:	00e79863          	bne	a5,a4,1882 <strcmp+0x18>
    1876:	0505                	addi	a0,a0,1
    1878:	0585                	addi	a1,a1,1
    187a:	fbe5                	bnez	a5,186a <strcmp>
    187c:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    187e:	9d19                	subw	a0,a0,a4
    1880:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1882:	0007851b          	sext.w	a0,a5
    1886:	bfe5                	j	187e <strcmp+0x14>

0000000000001888 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1888:	ce05                	beqz	a2,18c0 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    188a:	00054703          	lbu	a4,0(a0)
    188e:	0005c783          	lbu	a5,0(a1)
    1892:	cb0d                	beqz	a4,18c4 <strncmp+0x3c>
    if (!n--)
    1894:	167d                	addi	a2,a2,-1
    1896:	00c506b3          	add	a3,a0,a2
    189a:	a819                	j	18b0 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    189c:	00a68e63          	beq	a3,a0,18b8 <strncmp+0x30>
    18a0:	0505                	addi	a0,a0,1
    18a2:	00e79b63          	bne	a5,a4,18b8 <strncmp+0x30>
    18a6:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18aa:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18ae:	cb19                	beqz	a4,18c4 <strncmp+0x3c>
    18b0:	0005c783          	lbu	a5,0(a1)
    18b4:	0585                	addi	a1,a1,1
    18b6:	f3fd                	bnez	a5,189c <strncmp+0x14>
    return *l - *r;
    18b8:	0007051b          	sext.w	a0,a4
    18bc:	9d1d                	subw	a0,a0,a5
    18be:	8082                	ret
        return 0;
    18c0:	4501                	li	a0,0
}
    18c2:	8082                	ret
    18c4:	4501                	li	a0,0
    return *l - *r;
    18c6:	9d1d                	subw	a0,a0,a5
    18c8:	8082                	ret

00000000000018ca <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18ca:	00757793          	andi	a5,a0,7
    18ce:	cf89                	beqz	a5,18e8 <strlen+0x1e>
    18d0:	87aa                	mv	a5,a0
    18d2:	a029                	j	18dc <strlen+0x12>
    18d4:	0785                	addi	a5,a5,1
    18d6:	0077f713          	andi	a4,a5,7
    18da:	cb01                	beqz	a4,18ea <strlen+0x20>
        if (!*s)
    18dc:	0007c703          	lbu	a4,0(a5)
    18e0:	fb75                	bnez	a4,18d4 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18e2:	40a78533          	sub	a0,a5,a0
}
    18e6:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18e8:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18ea:	6394                	ld	a3,0(a5)
    18ec:	00000597          	auipc	a1,0x0
    18f0:	7045b583          	ld	a1,1796(a1) # 1ff0 <__clone+0x10a>
    18f4:	00000617          	auipc	a2,0x0
    18f8:	70463603          	ld	a2,1796(a2) # 1ff8 <__clone+0x112>
    18fc:	a019                	j	1902 <strlen+0x38>
    18fe:	6794                	ld	a3,8(a5)
    1900:	07a1                	addi	a5,a5,8
    1902:	00b68733          	add	a4,a3,a1
    1906:	fff6c693          	not	a3,a3
    190a:	8f75                	and	a4,a4,a3
    190c:	8f71                	and	a4,a4,a2
    190e:	db65                	beqz	a4,18fe <strlen+0x34>
    for (; *s; s++)
    1910:	0007c703          	lbu	a4,0(a5)
    1914:	d779                	beqz	a4,18e2 <strlen+0x18>
    1916:	0017c703          	lbu	a4,1(a5)
    191a:	0785                	addi	a5,a5,1
    191c:	d379                	beqz	a4,18e2 <strlen+0x18>
    191e:	0017c703          	lbu	a4,1(a5)
    1922:	0785                	addi	a5,a5,1
    1924:	fb6d                	bnez	a4,1916 <strlen+0x4c>
    1926:	bf75                	j	18e2 <strlen+0x18>

0000000000001928 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1928:	00757713          	andi	a4,a0,7
{
    192c:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    192e:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1932:	cb19                	beqz	a4,1948 <memchr+0x20>
    1934:	ce25                	beqz	a2,19ac <memchr+0x84>
    1936:	0007c703          	lbu	a4,0(a5)
    193a:	04b70e63          	beq	a4,a1,1996 <memchr+0x6e>
    193e:	0785                	addi	a5,a5,1
    1940:	0077f713          	andi	a4,a5,7
    1944:	167d                	addi	a2,a2,-1
    1946:	f77d                	bnez	a4,1934 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1948:	4501                	li	a0,0
    if (n && *s != c)
    194a:	c235                	beqz	a2,19ae <memchr+0x86>
    194c:	0007c703          	lbu	a4,0(a5)
    1950:	04b70363          	beq	a4,a1,1996 <memchr+0x6e>
        size_t k = ONES * c;
    1954:	00000517          	auipc	a0,0x0
    1958:	6ac53503          	ld	a0,1708(a0) # 2000 <__clone+0x11a>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    195c:	471d                	li	a4,7
        size_t k = ONES * c;
    195e:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1962:	02c77a63          	bgeu	a4,a2,1996 <memchr+0x6e>
    1966:	00000897          	auipc	a7,0x0
    196a:	68a8b883          	ld	a7,1674(a7) # 1ff0 <__clone+0x10a>
    196e:	00000817          	auipc	a6,0x0
    1972:	68a83803          	ld	a6,1674(a6) # 1ff8 <__clone+0x112>
    1976:	431d                	li	t1,7
    1978:	a029                	j	1982 <memchr+0x5a>
    197a:	1661                	addi	a2,a2,-8
    197c:	07a1                	addi	a5,a5,8
    197e:	02c37963          	bgeu	t1,a2,19b0 <memchr+0x88>
    1982:	6398                	ld	a4,0(a5)
    1984:	8f29                	xor	a4,a4,a0
    1986:	011706b3          	add	a3,a4,a7
    198a:	fff74713          	not	a4,a4
    198e:	8f75                	and	a4,a4,a3
    1990:	01077733          	and	a4,a4,a6
    1994:	d37d                	beqz	a4,197a <memchr+0x52>
    1996:	853e                	mv	a0,a5
    1998:	97b2                	add	a5,a5,a2
    199a:	a021                	j	19a2 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    199c:	0505                	addi	a0,a0,1
    199e:	00f50763          	beq	a0,a5,19ac <memchr+0x84>
    19a2:	00054703          	lbu	a4,0(a0)
    19a6:	feb71be3          	bne	a4,a1,199c <memchr+0x74>
    19aa:	8082                	ret
    return n ? (void *)s : 0;
    19ac:	4501                	li	a0,0
}
    19ae:	8082                	ret
    return n ? (void *)s : 0;
    19b0:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19b2:	f275                	bnez	a2,1996 <memchr+0x6e>
}
    19b4:	8082                	ret

00000000000019b6 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19b6:	1101                	addi	sp,sp,-32
    19b8:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19ba:	862e                	mv	a2,a1
{
    19bc:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19be:	4581                	li	a1,0
{
    19c0:	e426                	sd	s1,8(sp)
    19c2:	ec06                	sd	ra,24(sp)
    19c4:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19c6:	f63ff0ef          	jal	1928 <memchr>
    return p ? p - s : n;
    19ca:	c519                	beqz	a0,19d8 <strnlen+0x22>
}
    19cc:	60e2                	ld	ra,24(sp)
    19ce:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19d0:	8d05                	sub	a0,a0,s1
}
    19d2:	64a2                	ld	s1,8(sp)
    19d4:	6105                	addi	sp,sp,32
    19d6:	8082                	ret
    19d8:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19da:	8522                	mv	a0,s0
}
    19dc:	6442                	ld	s0,16(sp)
    19de:	64a2                	ld	s1,8(sp)
    19e0:	6105                	addi	sp,sp,32
    19e2:	8082                	ret

00000000000019e4 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19e4:	00b547b3          	xor	a5,a0,a1
    19e8:	8b9d                	andi	a5,a5,7
    19ea:	eb95                	bnez	a5,1a1e <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19ec:	0075f793          	andi	a5,a1,7
    19f0:	e7b1                	bnez	a5,1a3c <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19f2:	6198                	ld	a4,0(a1)
    19f4:	00000617          	auipc	a2,0x0
    19f8:	5fc63603          	ld	a2,1532(a2) # 1ff0 <__clone+0x10a>
    19fc:	00000817          	auipc	a6,0x0
    1a00:	5fc83803          	ld	a6,1532(a6) # 1ff8 <__clone+0x112>
    1a04:	a029                	j	1a0e <strcpy+0x2a>
    1a06:	e118                	sd	a4,0(a0)
    1a08:	6598                	ld	a4,8(a1)
    1a0a:	05a1                	addi	a1,a1,8
    1a0c:	0521                	addi	a0,a0,8
    1a0e:	00c707b3          	add	a5,a4,a2
    1a12:	fff74693          	not	a3,a4
    1a16:	8ff5                	and	a5,a5,a3
    1a18:	0107f7b3          	and	a5,a5,a6
    1a1c:	d7ed                	beqz	a5,1a06 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a1e:	0005c783          	lbu	a5,0(a1)
    1a22:	00f50023          	sb	a5,0(a0)
    1a26:	c785                	beqz	a5,1a4e <strcpy+0x6a>
    1a28:	0015c783          	lbu	a5,1(a1)
    1a2c:	0505                	addi	a0,a0,1
    1a2e:	0585                	addi	a1,a1,1
    1a30:	00f50023          	sb	a5,0(a0)
    1a34:	fbf5                	bnez	a5,1a28 <strcpy+0x44>
        ;
    return d;
}
    1a36:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a38:	0505                	addi	a0,a0,1
    1a3a:	df45                	beqz	a4,19f2 <strcpy+0xe>
            if (!(*d = *s))
    1a3c:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a40:	0585                	addi	a1,a1,1
    1a42:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a46:	00f50023          	sb	a5,0(a0)
    1a4a:	f7fd                	bnez	a5,1a38 <strcpy+0x54>
}
    1a4c:	8082                	ret
    1a4e:	8082                	ret

0000000000001a50 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a50:	00b547b3          	xor	a5,a0,a1
    1a54:	8b9d                	andi	a5,a5,7
    1a56:	1a079863          	bnez	a5,1c06 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a5a:	0075f793          	andi	a5,a1,7
    1a5e:	16078463          	beqz	a5,1bc6 <strncpy+0x176>
    1a62:	ea01                	bnez	a2,1a72 <strncpy+0x22>
    1a64:	a421                	j	1c6c <strncpy+0x21c>
    1a66:	167d                	addi	a2,a2,-1
    1a68:	0505                	addi	a0,a0,1
    1a6a:	14070e63          	beqz	a4,1bc6 <strncpy+0x176>
    1a6e:	1a060863          	beqz	a2,1c1e <strncpy+0x1ce>
    1a72:	0005c783          	lbu	a5,0(a1)
    1a76:	0585                	addi	a1,a1,1
    1a78:	0075f713          	andi	a4,a1,7
    1a7c:	00f50023          	sb	a5,0(a0)
    1a80:	f3fd                	bnez	a5,1a66 <strncpy+0x16>
    1a82:	4805                	li	a6,1
    1a84:	1a061863          	bnez	a2,1c34 <strncpy+0x1e4>
    1a88:	40a007b3          	neg	a5,a0
    1a8c:	8b9d                	andi	a5,a5,7
    1a8e:	4681                	li	a3,0
    1a90:	18061a63          	bnez	a2,1c24 <strncpy+0x1d4>
    1a94:	00778713          	addi	a4,a5,7
    1a98:	45ad                	li	a1,11
    1a9a:	18b76363          	bltu	a4,a1,1c20 <strncpy+0x1d0>
    1a9e:	1ae6eb63          	bltu	a3,a4,1c54 <strncpy+0x204>
    1aa2:	1a078363          	beqz	a5,1c48 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1aa6:	00050023          	sb	zero,0(a0)
    1aaa:	4685                	li	a3,1
    1aac:	00150713          	addi	a4,a0,1
    1ab0:	18d78f63          	beq	a5,a3,1c4e <strncpy+0x1fe>
    1ab4:	000500a3          	sb	zero,1(a0)
    1ab8:	4689                	li	a3,2
    1aba:	00250713          	addi	a4,a0,2
    1abe:	18d78e63          	beq	a5,a3,1c5a <strncpy+0x20a>
    1ac2:	00050123          	sb	zero,2(a0)
    1ac6:	468d                	li	a3,3
    1ac8:	00350713          	addi	a4,a0,3
    1acc:	16d78c63          	beq	a5,a3,1c44 <strncpy+0x1f4>
    1ad0:	000501a3          	sb	zero,3(a0)
    1ad4:	4691                	li	a3,4
    1ad6:	00450713          	addi	a4,a0,4
    1ada:	18d78263          	beq	a5,a3,1c5e <strncpy+0x20e>
    1ade:	00050223          	sb	zero,4(a0)
    1ae2:	4695                	li	a3,5
    1ae4:	00550713          	addi	a4,a0,5
    1ae8:	16d78d63          	beq	a5,a3,1c62 <strncpy+0x212>
    1aec:	000502a3          	sb	zero,5(a0)
    1af0:	469d                	li	a3,7
    1af2:	00650713          	addi	a4,a0,6
    1af6:	16d79863          	bne	a5,a3,1c66 <strncpy+0x216>
    1afa:	00750713          	addi	a4,a0,7
    1afe:	00050323          	sb	zero,6(a0)
    1b02:	40f80833          	sub	a6,a6,a5
    1b06:	ff887593          	andi	a1,a6,-8
    1b0a:	97aa                	add	a5,a5,a0
    1b0c:	95be                	add	a1,a1,a5
    1b0e:	0007b023          	sd	zero,0(a5)
    1b12:	07a1                	addi	a5,a5,8
    1b14:	feb79de3          	bne	a5,a1,1b0e <strncpy+0xbe>
    1b18:	ff887593          	andi	a1,a6,-8
    1b1c:	9ead                	addw	a3,a3,a1
    1b1e:	00b707b3          	add	a5,a4,a1
    1b22:	12b80863          	beq	a6,a1,1c52 <strncpy+0x202>
    1b26:	00078023          	sb	zero,0(a5)
    1b2a:	0016871b          	addiw	a4,a3,1
    1b2e:	0ec77863          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1b32:	000780a3          	sb	zero,1(a5)
    1b36:	0026871b          	addiw	a4,a3,2
    1b3a:	0ec77263          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1b3e:	00078123          	sb	zero,2(a5)
    1b42:	0036871b          	addiw	a4,a3,3
    1b46:	0cc77c63          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1b4a:	000781a3          	sb	zero,3(a5)
    1b4e:	0046871b          	addiw	a4,a3,4
    1b52:	0cc77663          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1b56:	00078223          	sb	zero,4(a5)
    1b5a:	0056871b          	addiw	a4,a3,5
    1b5e:	0cc77063          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1b62:	000782a3          	sb	zero,5(a5)
    1b66:	0066871b          	addiw	a4,a3,6
    1b6a:	0ac77a63          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1b6e:	00078323          	sb	zero,6(a5)
    1b72:	0076871b          	addiw	a4,a3,7
    1b76:	0ac77463          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1b7a:	000783a3          	sb	zero,7(a5)
    1b7e:	0086871b          	addiw	a4,a3,8
    1b82:	08c77e63          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1b86:	00078423          	sb	zero,8(a5)
    1b8a:	0096871b          	addiw	a4,a3,9
    1b8e:	08c77863          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1b92:	000784a3          	sb	zero,9(a5)
    1b96:	00a6871b          	addiw	a4,a3,10
    1b9a:	08c77263          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1b9e:	00078523          	sb	zero,10(a5)
    1ba2:	00b6871b          	addiw	a4,a3,11
    1ba6:	06c77c63          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1baa:	000785a3          	sb	zero,11(a5)
    1bae:	00c6871b          	addiw	a4,a3,12
    1bb2:	06c77663          	bgeu	a4,a2,1c1e <strncpy+0x1ce>
    1bb6:	00078623          	sb	zero,12(a5)
    1bba:	26b5                	addiw	a3,a3,13
    1bbc:	06c6f163          	bgeu	a3,a2,1c1e <strncpy+0x1ce>
    1bc0:	000786a3          	sb	zero,13(a5)
    1bc4:	8082                	ret
            ;
        if (!n || !*s)
    1bc6:	c645                	beqz	a2,1c6e <strncpy+0x21e>
    1bc8:	0005c783          	lbu	a5,0(a1)
    1bcc:	ea078be3          	beqz	a5,1a82 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bd0:	479d                	li	a5,7
    1bd2:	02c7ff63          	bgeu	a5,a2,1c10 <strncpy+0x1c0>
    1bd6:	00000897          	auipc	a7,0x0
    1bda:	41a8b883          	ld	a7,1050(a7) # 1ff0 <__clone+0x10a>
    1bde:	00000817          	auipc	a6,0x0
    1be2:	41a83803          	ld	a6,1050(a6) # 1ff8 <__clone+0x112>
    1be6:	431d                	li	t1,7
    1be8:	6198                	ld	a4,0(a1)
    1bea:	011707b3          	add	a5,a4,a7
    1bee:	fff74693          	not	a3,a4
    1bf2:	8ff5                	and	a5,a5,a3
    1bf4:	0107f7b3          	and	a5,a5,a6
    1bf8:	ef81                	bnez	a5,1c10 <strncpy+0x1c0>
            *wd = *ws;
    1bfa:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bfc:	1661                	addi	a2,a2,-8
    1bfe:	05a1                	addi	a1,a1,8
    1c00:	0521                	addi	a0,a0,8
    1c02:	fec363e3          	bltu	t1,a2,1be8 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c06:	e609                	bnez	a2,1c10 <strncpy+0x1c0>
    1c08:	a08d                	j	1c6a <strncpy+0x21a>
    1c0a:	167d                	addi	a2,a2,-1
    1c0c:	0505                	addi	a0,a0,1
    1c0e:	ca01                	beqz	a2,1c1e <strncpy+0x1ce>
    1c10:	0005c783          	lbu	a5,0(a1)
    1c14:	0585                	addi	a1,a1,1
    1c16:	00f50023          	sb	a5,0(a0)
    1c1a:	fbe5                	bnez	a5,1c0a <strncpy+0x1ba>
        ;
tail:
    1c1c:	b59d                	j	1a82 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c1e:	8082                	ret
    1c20:	472d                	li	a4,11
    1c22:	bdb5                	j	1a9e <strncpy+0x4e>
    1c24:	00778713          	addi	a4,a5,7
    1c28:	45ad                	li	a1,11
    1c2a:	fff60693          	addi	a3,a2,-1
    1c2e:	e6b778e3          	bgeu	a4,a1,1a9e <strncpy+0x4e>
    1c32:	b7fd                	j	1c20 <strncpy+0x1d0>
    1c34:	40a007b3          	neg	a5,a0
    1c38:	8832                	mv	a6,a2
    1c3a:	8b9d                	andi	a5,a5,7
    1c3c:	4681                	li	a3,0
    1c3e:	e4060be3          	beqz	a2,1a94 <strncpy+0x44>
    1c42:	b7cd                	j	1c24 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c44:	468d                	li	a3,3
    1c46:	bd75                	j	1b02 <strncpy+0xb2>
    1c48:	872a                	mv	a4,a0
    1c4a:	4681                	li	a3,0
    1c4c:	bd5d                	j	1b02 <strncpy+0xb2>
    1c4e:	4685                	li	a3,1
    1c50:	bd4d                	j	1b02 <strncpy+0xb2>
    1c52:	8082                	ret
    1c54:	87aa                	mv	a5,a0
    1c56:	4681                	li	a3,0
    1c58:	b5f9                	j	1b26 <strncpy+0xd6>
    1c5a:	4689                	li	a3,2
    1c5c:	b55d                	j	1b02 <strncpy+0xb2>
    1c5e:	4691                	li	a3,4
    1c60:	b54d                	j	1b02 <strncpy+0xb2>
    1c62:	4695                	li	a3,5
    1c64:	bd79                	j	1b02 <strncpy+0xb2>
    1c66:	4699                	li	a3,6
    1c68:	bd69                	j	1b02 <strncpy+0xb2>
    1c6a:	8082                	ret
    1c6c:	8082                	ret
    1c6e:	8082                	ret

0000000000001c70 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c70:	87aa                	mv	a5,a0
    1c72:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c74:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c78:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c7c:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c7e:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c80:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c84:	2501                	sext.w	a0,a0
    1c86:	8082                	ret

0000000000001c88 <openat>:
    register long a7 __asm__("a7") = n;
    1c88:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c8c:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c90:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c94:	2501                	sext.w	a0,a0
    1c96:	8082                	ret

0000000000001c98 <close>:
    register long a7 __asm__("a7") = n;
    1c98:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c9c:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1ca0:	2501                	sext.w	a0,a0
    1ca2:	8082                	ret

0000000000001ca4 <read>:
    register long a7 __asm__("a7") = n;
    1ca4:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ca8:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cac:	8082                	ret

0000000000001cae <write>:
    register long a7 __asm__("a7") = n;
    1cae:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cb2:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cb6:	8082                	ret

0000000000001cb8 <getpid>:
    register long a7 __asm__("a7") = n;
    1cb8:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cbc:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cc0:	2501                	sext.w	a0,a0
    1cc2:	8082                	ret

0000000000001cc4 <getppid>:
    register long a7 __asm__("a7") = n;
    1cc4:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cc8:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1ccc:	2501                	sext.w	a0,a0
    1cce:	8082                	ret

0000000000001cd0 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cd0:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cd4:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cd8:	2501                	sext.w	a0,a0
    1cda:	8082                	ret

0000000000001cdc <fork>:
    register long a7 __asm__("a7") = n;
    1cdc:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1ce0:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1ce2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ce4:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1ce8:	2501                	sext.w	a0,a0
    1cea:	8082                	ret

0000000000001cec <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cec:	85b2                	mv	a1,a2
    1cee:	863a                	mv	a2,a4
    if (stack)
    1cf0:	c191                	beqz	a1,1cf4 <clone+0x8>
	stack += stack_size;
    1cf2:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cf4:	4781                	li	a5,0
    1cf6:	4701                	li	a4,0
    1cf8:	4681                	li	a3,0
    1cfa:	2601                	sext.w	a2,a2
    1cfc:	a2ed                	j	1ee6 <__clone>

0000000000001cfe <exit>:
    register long a7 __asm__("a7") = n;
    1cfe:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d02:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d06:	8082                	ret

0000000000001d08 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d08:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d0c:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d0e:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d12:	2501                	sext.w	a0,a0
    1d14:	8082                	ret

0000000000001d16 <exec>:
    register long a7 __asm__("a7") = n;
    1d16:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d1a:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d1e:	2501                	sext.w	a0,a0
    1d20:	8082                	ret

0000000000001d22 <execve>:
    register long a7 __asm__("a7") = n;
    1d22:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d26:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d2a:	2501                	sext.w	a0,a0
    1d2c:	8082                	ret

0000000000001d2e <times>:
    register long a7 __asm__("a7") = n;
    1d2e:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d32:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d36:	2501                	sext.w	a0,a0
    1d38:	8082                	ret

0000000000001d3a <get_time>:

int64 get_time()
{
    1d3a:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d3c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d40:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d42:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d44:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d48:	2501                	sext.w	a0,a0
    1d4a:	ed09                	bnez	a0,1d64 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d4c:	67a2                	ld	a5,8(sp)
    1d4e:	3e800713          	li	a4,1000
    1d52:	00015503          	lhu	a0,0(sp)
    1d56:	02e7d7b3          	divu	a5,a5,a4
    1d5a:	02e50533          	mul	a0,a0,a4
    1d5e:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d60:	0141                	addi	sp,sp,16
    1d62:	8082                	ret
        return -1;
    1d64:	557d                	li	a0,-1
    1d66:	bfed                	j	1d60 <get_time+0x26>

0000000000001d68 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d68:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d6c:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d70:	2501                	sext.w	a0,a0
    1d72:	8082                	ret

0000000000001d74 <time>:
    register long a7 __asm__("a7") = n;
    1d74:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d78:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d7c:	2501                	sext.w	a0,a0
    1d7e:	8082                	ret

0000000000001d80 <sleep>:

int sleep(unsigned long long time)
{
    1d80:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d82:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d84:	850a                	mv	a0,sp
    1d86:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d88:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d8c:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d8e:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d92:	e501                	bnez	a0,1d9a <sleep+0x1a>
    return 0;
    1d94:	4501                	li	a0,0
}
    1d96:	0141                	addi	sp,sp,16
    1d98:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d9a:	4502                	lw	a0,0(sp)
}
    1d9c:	0141                	addi	sp,sp,16
    1d9e:	8082                	ret

0000000000001da0 <set_priority>:
    register long a7 __asm__("a7") = n;
    1da0:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1da4:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1da8:	2501                	sext.w	a0,a0
    1daa:	8082                	ret

0000000000001dac <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1dac:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1db0:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1db4:	8082                	ret

0000000000001db6 <munmap>:
    register long a7 __asm__("a7") = n;
    1db6:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dba:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1dbe:	2501                	sext.w	a0,a0
    1dc0:	8082                	ret

0000000000001dc2 <wait>:

int wait(int *code)
{
    1dc2:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dc4:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1dc8:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1dca:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dcc:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dce:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dd2:	2501                	sext.w	a0,a0
    1dd4:	8082                	ret

0000000000001dd6 <spawn>:
    register long a7 __asm__("a7") = n;
    1dd6:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dda:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dde:	2501                	sext.w	a0,a0
    1de0:	8082                	ret

0000000000001de2 <mailread>:
    register long a7 __asm__("a7") = n;
    1de2:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1de6:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dea:	2501                	sext.w	a0,a0
    1dec:	8082                	ret

0000000000001dee <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dee:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1df2:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1df6:	2501                	sext.w	a0,a0
    1df8:	8082                	ret

0000000000001dfa <fstat>:
    register long a7 __asm__("a7") = n;
    1dfa:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dfe:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e02:	2501                	sext.w	a0,a0
    1e04:	8082                	ret

0000000000001e06 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e06:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e08:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e0c:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e0e:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e12:	2501                	sext.w	a0,a0
    1e14:	8082                	ret

0000000000001e16 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e16:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e18:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e1c:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e1e:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e22:	2501                	sext.w	a0,a0
    1e24:	8082                	ret

0000000000001e26 <link>:

int link(char *old_path, char *new_path)
{
    1e26:	87aa                	mv	a5,a0
    1e28:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e2a:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e2e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e32:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e34:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e38:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e3a:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e3e:	2501                	sext.w	a0,a0
    1e40:	8082                	ret

0000000000001e42 <unlink>:

int unlink(char *path)
{
    1e42:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e44:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e48:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e4c:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e4e:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e52:	2501                	sext.w	a0,a0
    1e54:	8082                	ret

0000000000001e56 <uname>:
    register long a7 __asm__("a7") = n;
    1e56:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e5a:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e5e:	2501                	sext.w	a0,a0
    1e60:	8082                	ret

0000000000001e62 <brk>:
    register long a7 __asm__("a7") = n;
    1e62:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e66:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e6a:	2501                	sext.w	a0,a0
    1e6c:	8082                	ret

0000000000001e6e <getcwd>:
    register long a7 __asm__("a7") = n;
    1e6e:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e70:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e74:	8082                	ret

0000000000001e76 <chdir>:
    register long a7 __asm__("a7") = n;
    1e76:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e7a:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e7e:	2501                	sext.w	a0,a0
    1e80:	8082                	ret

0000000000001e82 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e82:	862e                	mv	a2,a1
    1e84:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e86:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e88:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e8c:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e90:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e92:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e94:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e98:	2501                	sext.w	a0,a0
    1e9a:	8082                	ret

0000000000001e9c <getdents>:
    register long a7 __asm__("a7") = n;
    1e9c:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ea0:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ea4:	2501                	sext.w	a0,a0
    1ea6:	8082                	ret

0000000000001ea8 <pipe>:
    register long a7 __asm__("a7") = n;
    1ea8:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1eac:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eae:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1eb2:	2501                	sext.w	a0,a0
    1eb4:	8082                	ret

0000000000001eb6 <dup>:
    register long a7 __asm__("a7") = n;
    1eb6:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1eb8:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1ebc:	2501                	sext.w	a0,a0
    1ebe:	8082                	ret

0000000000001ec0 <dup2>:
    register long a7 __asm__("a7") = n;
    1ec0:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ec2:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ec4:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ec8:	2501                	sext.w	a0,a0
    1eca:	8082                	ret

0000000000001ecc <mount>:
    register long a7 __asm__("a7") = n;
    1ecc:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ed0:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ed4:	2501                	sext.w	a0,a0
    1ed6:	8082                	ret

0000000000001ed8 <umount>:
    register long a7 __asm__("a7") = n;
    1ed8:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1edc:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ede:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ee2:	2501                	sext.w	a0,a0
    1ee4:	8082                	ret

0000000000001ee6 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ee6:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ee8:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1eea:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1eec:	8532                	mv	a0,a2
	mv a2, a4
    1eee:	863a                	mv	a2,a4
	mv a3, a5
    1ef0:	86be                	mv	a3,a5
	mv a4, a6
    1ef2:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ef4:	0dc00893          	li	a7,220
	ecall
    1ef8:	00000073          	ecall

	beqz a0, 1f
    1efc:	c111                	beqz	a0,1f00 <__clone+0x1a>
	# Parent
	ret
    1efe:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f00:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f02:	6522                	ld	a0,8(sp)
	jalr a1
    1f04:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f06:	05d00893          	li	a7,93
	ecall
    1f0a:	00000073          	ecall
