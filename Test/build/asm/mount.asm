
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/mount:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	aa31                	j	111e <__start_main>

0000000000001004 <test_mount>:

static char mntpoint[64] = "./mnt";
static char device[64] = "/dev/vda2";
static const char *fs_type = "vfat";

void test_mount() {
    1004:	1141                	addi	sp,sp,-16
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f5a50513          	addi	a0,a0,-166 # 1f60 <__clone+0x2a>
void test_mount() {
    100e:	e406                	sd	ra,8(sp)
    1010:	e022                	sd	s0,0(sp)
	TEST_START(__func__);
    1012:	37e000ef          	jal	1390 <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	0aa50513          	addi	a0,a0,170 # 20c0 <__func__.0>
    101e:	372000ef          	jal	1390 <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	f5650513          	addi	a0,a0,-170 # 1f78 <__clone+0x42>
    102a:	366000ef          	jal	1390 <puts>

	printf("Mounting dev:%s to %s\n", device, mntpoint);
    102e:	00001617          	auipc	a2,0x1
    1032:	01260613          	addi	a2,a2,18 # 2040 <mntpoint>
    1036:	00001597          	auipc	a1,0x1
    103a:	04a58593          	addi	a1,a1,74 # 2080 <device>
    103e:	00001517          	auipc	a0,0x1
    1042:	f4a50513          	addi	a0,a0,-182 # 1f88 <__clone+0x52>
    1046:	36c000ef          	jal	13b2 <printf>
	int ret = mount(device, mntpoint, fs_type, 0, NULL);
    104a:	00001597          	auipc	a1,0x1
    104e:	ff658593          	addi	a1,a1,-10 # 2040 <mntpoint>
    1052:	4701                	li	a4,0
    1054:	4681                	li	a3,0
    1056:	00001617          	auipc	a2,0x1
    105a:	f4a60613          	addi	a2,a2,-182 # 1fa0 <__clone+0x6a>
    105e:	00001517          	auipc	a0,0x1
    1062:	02250513          	addi	a0,a0,34 # 2080 <device>
    1066:	6b7000ef          	jal	1f1c <mount>
    106a:	842a                	mv	s0,a0
	printf("mount return: %d\n", ret);
    106c:	85aa                	mv	a1,a0
    106e:	00001517          	auipc	a0,0x1
    1072:	f3a50513          	addi	a0,a0,-198 # 1fa8 <__clone+0x72>
    1076:	33c000ef          	jal	13b2 <printf>
	assert(ret == 0);
    107a:	e821                	bnez	s0,10ca <test_mount+0xc6>

	if (ret == 0) {
		printf("mount successfully\n");
    107c:	00001517          	auipc	a0,0x1
    1080:	f7450513          	addi	a0,a0,-140 # 1ff0 <__clone+0xba>
    1084:	32e000ef          	jal	13b2 <printf>
		ret = umount(mntpoint);
    1088:	00001517          	auipc	a0,0x1
    108c:	fb850513          	addi	a0,a0,-72 # 2040 <mntpoint>
    1090:	699000ef          	jal	1f28 <umount>
    1094:	85aa                	mv	a1,a0
		printf("umount return: %d\n", ret);
    1096:	00001517          	auipc	a0,0x1
    109a:	f7250513          	addi	a0,a0,-142 # 2008 <__clone+0xd2>
    109e:	314000ef          	jal	13b2 <printf>
	}

	TEST_END(__func__);
    10a2:	00001517          	auipc	a0,0x1
    10a6:	f3e50513          	addi	a0,a0,-194 # 1fe0 <__clone+0xaa>
    10aa:	2e6000ef          	jal	1390 <puts>
    10ae:	00001517          	auipc	a0,0x1
    10b2:	01250513          	addi	a0,a0,18 # 20c0 <__func__.0>
    10b6:	2da000ef          	jal	1390 <puts>
}
    10ba:	6402                	ld	s0,0(sp)
    10bc:	60a2                	ld	ra,8(sp)
	TEST_END(__func__);
    10be:	00001517          	auipc	a0,0x1
    10c2:	eba50513          	addi	a0,a0,-326 # 1f78 <__clone+0x42>
}
    10c6:	0141                	addi	sp,sp,16
	TEST_END(__func__);
    10c8:	a4e1                	j	1390 <puts>
	assert(ret == 0);
    10ca:	00001517          	auipc	a0,0x1
    10ce:	ef650513          	addi	a0,a0,-266 # 1fc0 <__clone+0x8a>
    10d2:	56a000ef          	jal	163c <panic>
	if (ret == 0) {
    10d6:	b7f1                	j	10a2 <test_mount+0x9e>

00000000000010d8 <main>:

int main(int argc,char *argv[]) {
    10d8:	1101                	addi	sp,sp,-32
    10da:	ec06                	sd	ra,24(sp)
    10dc:	e822                	sd	s0,16(sp)
    10de:	e426                	sd	s1,8(sp)
	if(argc >= 2){
    10e0:	4785                	li	a5,1
    10e2:	00a7ca63          	blt	a5,a0,10f6 <main+0x1e>

	if(argc >= 3){
		strcpy(mntpoint, argv[2]);
	}

	test_mount();
    10e6:	f1fff0ef          	jal	1004 <test_mount>
	return 0;
}
    10ea:	60e2                	ld	ra,24(sp)
    10ec:	6442                	ld	s0,16(sp)
    10ee:	64a2                	ld	s1,8(sp)
    10f0:	4501                	li	a0,0
    10f2:	6105                	addi	sp,sp,32
    10f4:	8082                	ret
		strcpy(device, argv[1]);
    10f6:	84ae                	mv	s1,a1
    10f8:	658c                	ld	a1,8(a1)
    10fa:	842a                	mv	s0,a0
    10fc:	00001517          	auipc	a0,0x1
    1100:	f8450513          	addi	a0,a0,-124 # 2080 <device>
    1104:	131000ef          	jal	1a34 <strcpy>
	if(argc >= 3){
    1108:	4789                	li	a5,2
    110a:	fcf40ee3          	beq	s0,a5,10e6 <main+0xe>
		strcpy(mntpoint, argv[2]);
    110e:	688c                	ld	a1,16(s1)
    1110:	00001517          	auipc	a0,0x1
    1114:	f3050513          	addi	a0,a0,-208 # 2040 <mntpoint>
    1118:	11d000ef          	jal	1a34 <strcpy>
    111c:	b7e9                	j	10e6 <main+0xe>

000000000000111e <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    111e:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    1120:	4108                	lw	a0,0(a0)
{
    1122:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1124:	05a1                	addi	a1,a1,8
{
    1126:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    1128:	fb1ff0ef          	jal	10d8 <main>
    112c:	423000ef          	jal	1d4e <exit>
	return 0;
}
    1130:	60a2                	ld	ra,8(sp)
    1132:	4501                	li	a0,0
    1134:	0141                	addi	sp,sp,16
    1136:	8082                	ret

0000000000001138 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    1138:	7179                	addi	sp,sp,-48
    113a:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    113c:	12054b63          	bltz	a0,1272 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    1140:	02b577bb          	remuw	a5,a0,a1
    1144:	00001617          	auipc	a2,0x1
    1148:	f8c60613          	addi	a2,a2,-116 # 20d0 <digits>
    buf[16] = 0;
    114c:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1150:	0005871b          	sext.w	a4,a1
    1154:	1782                	slli	a5,a5,0x20
    1156:	9381                	srli	a5,a5,0x20
    1158:	97b2                	add	a5,a5,a2
    115a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    115e:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1162:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1166:	1cb56363          	bltu	a0,a1,132c <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    116a:	45b9                	li	a1,14
    116c:	02e877bb          	remuw	a5,a6,a4
    1170:	1782                	slli	a5,a5,0x20
    1172:	9381                	srli	a5,a5,0x20
    1174:	97b2                	add	a5,a5,a2
    1176:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    117a:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    117e:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1182:	0ce86e63          	bltu	a6,a4,125e <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1186:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    118a:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    118e:	1582                	slli	a1,a1,0x20
    1190:	9181                	srli	a1,a1,0x20
    1192:	95b2                	add	a1,a1,a2
    1194:	0005c583          	lbu	a1,0(a1)
    1198:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    119c:	0007859b          	sext.w	a1,a5
    11a0:	12e6ec63          	bltu	a3,a4,12d8 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    11a4:	02e7f6bb          	remuw	a3,a5,a4
    11a8:	1682                	slli	a3,a3,0x20
    11aa:	9281                	srli	a3,a3,0x20
    11ac:	96b2                	add	a3,a3,a2
    11ae:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11b2:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    11b6:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    11ba:	12e5e863          	bltu	a1,a4,12ea <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    11be:	02e876bb          	remuw	a3,a6,a4
    11c2:	1682                	slli	a3,a3,0x20
    11c4:	9281                	srli	a3,a3,0x20
    11c6:	96b2                	add	a3,a3,a2
    11c8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11cc:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11d0:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    11d4:	12e86463          	bltu	a6,a4,12fc <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    11d8:	02e5f6bb          	remuw	a3,a1,a4
    11dc:	1682                	slli	a3,a3,0x20
    11de:	9281                	srli	a3,a3,0x20
    11e0:	96b2                	add	a3,a3,a2
    11e2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11e6:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11ea:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    11ee:	0ce5ec63          	bltu	a1,a4,12c6 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    11f2:	02e876bb          	remuw	a3,a6,a4
    11f6:	1682                	slli	a3,a3,0x20
    11f8:	9281                	srli	a3,a3,0x20
    11fa:	96b2                	add	a3,a3,a2
    11fc:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1200:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1204:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    1208:	10e86963          	bltu	a6,a4,131a <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    120c:	02e5f6bb          	remuw	a3,a1,a4
    1210:	1682                	slli	a3,a3,0x20
    1212:	9281                	srli	a3,a3,0x20
    1214:	96b2                	add	a3,a3,a2
    1216:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    121a:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    121e:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1222:	10e5e763          	bltu	a1,a4,1330 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    1226:	02e876bb          	remuw	a3,a6,a4
    122a:	1682                	slli	a3,a3,0x20
    122c:	9281                	srli	a3,a3,0x20
    122e:	96b2                	add	a3,a3,a2
    1230:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1234:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    1238:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    123c:	10e86363          	bltu	a6,a4,1342 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    1240:	1782                	slli	a5,a5,0x20
    1242:	9381                	srli	a5,a5,0x20
    1244:	97b2                	add	a5,a5,a2
    1246:	0007c783          	lbu	a5,0(a5)
    124a:	4599                	li	a1,6
    124c:	00f10723          	sb	a5,14(sp)

    if (sign)
    1250:	00055763          	bgez	a0,125e <printint.constprop.0+0x126>
        buf[i--] = '-';
    1254:	02d00793          	li	a5,45
    1258:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    125c:	4595                	li	a1,5
    write(f, s, l);
    125e:	003c                	addi	a5,sp,8
    1260:	4641                	li	a2,16
    1262:	9e0d                	subw	a2,a2,a1
    1264:	4505                	li	a0,1
    1266:	95be                	add	a1,a1,a5
    1268:	297000ef          	jal	1cfe <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    126c:	70a2                	ld	ra,40(sp)
    126e:	6145                	addi	sp,sp,48
    1270:	8082                	ret
        x = -xx;
    1272:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1276:	02b877bb          	remuw	a5,a6,a1
    127a:	00001617          	auipc	a2,0x1
    127e:	e5660613          	addi	a2,a2,-426 # 20d0 <digits>
    buf[16] = 0;
    1282:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1286:	0005871b          	sext.w	a4,a1
    128a:	1782                	slli	a5,a5,0x20
    128c:	9381                	srli	a5,a5,0x20
    128e:	97b2                	add	a5,a5,a2
    1290:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1294:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1298:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    129c:	06b86963          	bltu	a6,a1,130e <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    12a0:	02e8f7bb          	remuw	a5,a7,a4
    12a4:	1782                	slli	a5,a5,0x20
    12a6:	9381                	srli	a5,a5,0x20
    12a8:	97b2                	add	a5,a5,a2
    12aa:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    12ae:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    12b2:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    12b6:	ece8f8e3          	bgeu	a7,a4,1186 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    12ba:	02d00793          	li	a5,45
    12be:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    12c2:	45b5                	li	a1,13
    12c4:	bf69                	j	125e <printint.constprop.0+0x126>
    12c6:	45a9                	li	a1,10
    if (sign)
    12c8:	f8055be3          	bgez	a0,125e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12cc:	02d00793          	li	a5,45
    12d0:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    12d4:	45a5                	li	a1,9
    12d6:	b761                	j	125e <printint.constprop.0+0x126>
    12d8:	45b5                	li	a1,13
    if (sign)
    12da:	f80552e3          	bgez	a0,125e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12de:	02d00793          	li	a5,45
    12e2:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    12e6:	45b1                	li	a1,12
    12e8:	bf9d                	j	125e <printint.constprop.0+0x126>
    12ea:	45b1                	li	a1,12
    if (sign)
    12ec:	f60559e3          	bgez	a0,125e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12f0:	02d00793          	li	a5,45
    12f4:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12f8:	45ad                	li	a1,11
    12fa:	b795                	j	125e <printint.constprop.0+0x126>
    12fc:	45ad                	li	a1,11
    if (sign)
    12fe:	f60550e3          	bgez	a0,125e <printint.constprop.0+0x126>
        buf[i--] = '-';
    1302:	02d00793          	li	a5,45
    1306:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    130a:	45a9                	li	a1,10
    130c:	bf89                	j	125e <printint.constprop.0+0x126>
        buf[i--] = '-';
    130e:	02d00793          	li	a5,45
    1312:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1316:	45b9                	li	a1,14
    1318:	b799                	j	125e <printint.constprop.0+0x126>
    131a:	45a5                	li	a1,9
    if (sign)
    131c:	f40551e3          	bgez	a0,125e <printint.constprop.0+0x126>
        buf[i--] = '-';
    1320:	02d00793          	li	a5,45
    1324:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    1328:	45a1                	li	a1,8
    132a:	bf15                	j	125e <printint.constprop.0+0x126>
    i = 15;
    132c:	45bd                	li	a1,15
    132e:	bf05                	j	125e <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1330:	45a1                	li	a1,8
    if (sign)
    1332:	f20556e3          	bgez	a0,125e <printint.constprop.0+0x126>
        buf[i--] = '-';
    1336:	02d00793          	li	a5,45
    133a:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    133e:	459d                	li	a1,7
    1340:	bf39                	j	125e <printint.constprop.0+0x126>
    1342:	459d                	li	a1,7
    if (sign)
    1344:	f0055de3          	bgez	a0,125e <printint.constprop.0+0x126>
        buf[i--] = '-';
    1348:	02d00793          	li	a5,45
    134c:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    1350:	4599                	li	a1,6
    1352:	b731                	j	125e <printint.constprop.0+0x126>

0000000000001354 <getchar>:
{
    1354:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1356:	00f10593          	addi	a1,sp,15
    135a:	4605                	li	a2,1
    135c:	4501                	li	a0,0
{
    135e:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1360:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1364:	191000ef          	jal	1cf4 <read>
}
    1368:	60e2                	ld	ra,24(sp)
    136a:	00f14503          	lbu	a0,15(sp)
    136e:	6105                	addi	sp,sp,32
    1370:	8082                	ret

0000000000001372 <putchar>:
{
    1372:	1101                	addi	sp,sp,-32
    1374:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1376:	00f10593          	addi	a1,sp,15
    137a:	4605                	li	a2,1
    137c:	4505                	li	a0,1
{
    137e:	ec06                	sd	ra,24(sp)
    char byte = c;
    1380:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1384:	17b000ef          	jal	1cfe <write>
}
    1388:	60e2                	ld	ra,24(sp)
    138a:	2501                	sext.w	a0,a0
    138c:	6105                	addi	sp,sp,32
    138e:	8082                	ret

0000000000001390 <puts>:
{
    1390:	1141                	addi	sp,sp,-16
    1392:	e406                	sd	ra,8(sp)
    1394:	e022                	sd	s0,0(sp)
    1396:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1398:	582000ef          	jal	191a <strlen>
    139c:	862a                	mv	a2,a0
    139e:	85a2                	mv	a1,s0
    13a0:	4505                	li	a0,1
    13a2:	15d000ef          	jal	1cfe <write>
}
    13a6:	60a2                	ld	ra,8(sp)
    13a8:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    13aa:	957d                	srai	a0,a0,0x3f
    return r;
    13ac:	2501                	sext.w	a0,a0
}
    13ae:	0141                	addi	sp,sp,16
    13b0:	8082                	ret

00000000000013b2 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    13b2:	7131                	addi	sp,sp,-192
    13b4:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    13b6:	013c                	addi	a5,sp,136
{
    13b8:	f0ca                	sd	s2,96(sp)
    13ba:	ecce                	sd	s3,88(sp)
    13bc:	e8d2                	sd	s4,80(sp)
    13be:	e4d6                	sd	s5,72(sp)
    13c0:	e0da                	sd	s6,64(sp)
    13c2:	fc5e                	sd	s7,56(sp)
    13c4:	fc86                	sd	ra,120(sp)
    13c6:	f8a2                	sd	s0,112(sp)
    13c8:	f4a6                	sd	s1,104(sp)
    13ca:	e52e                	sd	a1,136(sp)
    13cc:	e932                	sd	a2,144(sp)
    13ce:	ed36                	sd	a3,152(sp)
    13d0:	f13a                	sd	a4,160(sp)
    13d2:	f942                	sd	a6,176(sp)
    13d4:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    13d6:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    13d8:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    13dc:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    13e0:	00001b97          	auipc	s7,0x1
    13e4:	c40b8b93          	addi	s7,s7,-960 # 2020 <__clone+0xea>
        switch (s[1])
    13e8:	07800a93          	li	s5,120
    13ec:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13f0:	00001997          	auipc	s3,0x1
    13f4:	ce098993          	addi	s3,s3,-800 # 20d0 <digits>
        if (!*s)
    13f8:	00054783          	lbu	a5,0(a0)
    13fc:	16078c63          	beqz	a5,1574 <printf+0x1c2>
    1400:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1402:	19278463          	beq	a5,s2,158a <printf+0x1d8>
    1406:	00164783          	lbu	a5,1(a2)
    140a:	0605                	addi	a2,a2,1
    140c:	fbfd                	bnez	a5,1402 <printf+0x50>
    140e:	84b2                	mv	s1,a2
        l = z - a;
    1410:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1414:	85aa                	mv	a1,a0
    1416:	8622                	mv	a2,s0
    1418:	4505                	li	a0,1
    141a:	0e5000ef          	jal	1cfe <write>
        if (l)
    141e:	18041f63          	bnez	s0,15bc <printf+0x20a>
        if (s[1] == 0)
    1422:	0014c783          	lbu	a5,1(s1)
    1426:	14078763          	beqz	a5,1574 <printf+0x1c2>
        switch (s[1])
    142a:	1d478163          	beq	a5,s4,15ec <printf+0x23a>
    142e:	18fa6963          	bltu	s4,a5,15c0 <printf+0x20e>
    1432:	1b678363          	beq	a5,s6,15d8 <printf+0x226>
    1436:	07000713          	li	a4,112
    143a:	1ce79c63          	bne	a5,a4,1612 <printf+0x260>
            printptr(va_arg(ap, uint64));
    143e:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    1440:	03000793          	li	a5,48
    1444:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    1448:	631c                	ld	a5,0(a4)
    144a:	0721                	addi	a4,a4,8
    144c:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    144e:	00479f93          	slli	t6,a5,0x4
    1452:	00879f13          	slli	t5,a5,0x8
    1456:	00c79e93          	slli	t4,a5,0xc
    145a:	01079e13          	slli	t3,a5,0x10
    145e:	01479313          	slli	t1,a5,0x14
    1462:	01879893          	slli	a7,a5,0x18
    1466:	01c79713          	slli	a4,a5,0x1c
    146a:	02479813          	slli	a6,a5,0x24
    146e:	02879513          	slli	a0,a5,0x28
    1472:	02c79593          	slli	a1,a5,0x2c
    1476:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    147a:	03c7d293          	srli	t0,a5,0x3c
    147e:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1482:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1486:	03cfdf93          	srli	t6,t6,0x3c
    148a:	03cf5f13          	srli	t5,t5,0x3c
    148e:	03cede93          	srli	t4,t4,0x3c
    1492:	03ce5e13          	srli	t3,t3,0x3c
    1496:	03c35313          	srli	t1,t1,0x3c
    149a:	03c8d893          	srli	a7,a7,0x3c
    149e:	9371                	srli	a4,a4,0x3c
    14a0:	03c85813          	srli	a6,a6,0x3c
    14a4:	9171                	srli	a0,a0,0x3c
    14a6:	91f1                	srli	a1,a1,0x3c
    14a8:	9271                	srli	a2,a2,0x3c
    14aa:	974e                	add	a4,a4,s3
    14ac:	92f1                	srli	a3,a3,0x3c
    14ae:	92ce                	add	t0,t0,s3
    14b0:	9fce                	add	t6,t6,s3
    14b2:	9f4e                	add	t5,t5,s3
    14b4:	9ece                	add	t4,t4,s3
    14b6:	9e4e                	add	t3,t3,s3
    14b8:	934e                	add	t1,t1,s3
    14ba:	98ce                	add	a7,a7,s3
    14bc:	93ce                	add	t2,t2,s3
    14be:	984e                	add	a6,a6,s3
    14c0:	954e                	add	a0,a0,s3
    14c2:	95ce                	add	a1,a1,s3
    14c4:	964e                	add	a2,a2,s3
    14c6:	0002c283          	lbu	t0,0(t0)
    14ca:	000fcf83          	lbu	t6,0(t6)
    14ce:	000f4f03          	lbu	t5,0(t5)
    14d2:	000ece83          	lbu	t4,0(t4)
    14d6:	000e4e03          	lbu	t3,0(t3)
    14da:	00034303          	lbu	t1,0(t1)
    14de:	0008c883          	lbu	a7,0(a7)
    14e2:	00074403          	lbu	s0,0(a4)
    14e6:	0003c383          	lbu	t2,0(t2)
    14ea:	00084803          	lbu	a6,0(a6)
    14ee:	00054503          	lbu	a0,0(a0)
    14f2:	0005c583          	lbu	a1,0(a1)
    14f6:	00064603          	lbu	a2,0(a2)
    14fa:	00d98733          	add	a4,s3,a3
    14fe:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1502:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1506:	9371                	srli	a4,a4,0x3c
    1508:	8bbd                	andi	a5,a5,15
    150a:	00510523          	sb	t0,10(sp)
    150e:	01f105a3          	sb	t6,11(sp)
    1512:	01e10623          	sb	t5,12(sp)
    1516:	01d106a3          	sb	t4,13(sp)
    151a:	01c10723          	sb	t3,14(sp)
    151e:	006107a3          	sb	t1,15(sp)
    1522:	01110823          	sb	a7,16(sp)
    1526:	00710923          	sb	t2,18(sp)
    152a:	010109a3          	sb	a6,19(sp)
    152e:	00a10a23          	sb	a0,20(sp)
    1532:	00b10aa3          	sb	a1,21(sp)
    1536:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    153a:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    153e:	008108a3          	sb	s0,17(sp)
    1542:	974e                	add	a4,a4,s3
    1544:	97ce                	add	a5,a5,s3
    1546:	00d10ba3          	sb	a3,23(sp)
    154a:	00074703          	lbu	a4,0(a4)
    154e:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1552:	4649                	li	a2,18
    1554:	002c                	addi	a1,sp,8
    1556:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1558:	00e10c23          	sb	a4,24(sp)
    155c:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1560:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1564:	79a000ef          	jal	1cfe <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    1568:	00248513          	addi	a0,s1,2
        if (!*s)
    156c:	00054783          	lbu	a5,0(a0)
    1570:	e80798e3          	bnez	a5,1400 <printf+0x4e>
    }
    va_end(ap);
}
    1574:	70e6                	ld	ra,120(sp)
    1576:	7446                	ld	s0,112(sp)
    1578:	74a6                	ld	s1,104(sp)
    157a:	7906                	ld	s2,96(sp)
    157c:	69e6                	ld	s3,88(sp)
    157e:	6a46                	ld	s4,80(sp)
    1580:	6aa6                	ld	s5,72(sp)
    1582:	6b06                	ld	s6,64(sp)
    1584:	7be2                	ld	s7,56(sp)
    1586:	6129                	addi	sp,sp,192
    1588:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    158a:	00064783          	lbu	a5,0(a2)
    158e:	84b2                	mv	s1,a2
    1590:	01278963          	beq	a5,s2,15a2 <printf+0x1f0>
    1594:	bdb5                	j	1410 <printf+0x5e>
    1596:	0024c783          	lbu	a5,2(s1)
    159a:	0605                	addi	a2,a2,1
    159c:	0489                	addi	s1,s1,2
    159e:	e72799e3          	bne	a5,s2,1410 <printf+0x5e>
    15a2:	0014c783          	lbu	a5,1(s1)
    15a6:	ff2788e3          	beq	a5,s2,1596 <printf+0x1e4>
        l = z - a;
    15aa:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    15ae:	85aa                	mv	a1,a0
    15b0:	8622                	mv	a2,s0
    15b2:	4505                	li	a0,1
    15b4:	74a000ef          	jal	1cfe <write>
        if (l)
    15b8:	e60405e3          	beqz	s0,1422 <printf+0x70>
    15bc:	8526                	mv	a0,s1
    15be:	bd2d                	j	13f8 <printf+0x46>
        switch (s[1])
    15c0:	05579963          	bne	a5,s5,1612 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    15c4:	6782                	ld	a5,0(sp)
    15c6:	45c1                	li	a1,16
    15c8:	4388                	lw	a0,0(a5)
    15ca:	07a1                	addi	a5,a5,8
    15cc:	e03e                	sd	a5,0(sp)
    15ce:	b6bff0ef          	jal	1138 <printint.constprop.0>
        s += 2;
    15d2:	00248513          	addi	a0,s1,2
    15d6:	bf59                	j	156c <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    15d8:	6782                	ld	a5,0(sp)
    15da:	45a9                	li	a1,10
    15dc:	4388                	lw	a0,0(a5)
    15de:	07a1                	addi	a5,a5,8
    15e0:	e03e                	sd	a5,0(sp)
    15e2:	b57ff0ef          	jal	1138 <printint.constprop.0>
        s += 2;
    15e6:	00248513          	addi	a0,s1,2
    15ea:	b749                	j	156c <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    15ec:	6782                	ld	a5,0(sp)
    15ee:	6380                	ld	s0,0(a5)
    15f0:	07a1                	addi	a5,a5,8
    15f2:	e03e                	sd	a5,0(sp)
    15f4:	c031                	beqz	s0,1638 <printf+0x286>
            l = strnlen(a, 200);
    15f6:	0c800593          	li	a1,200
    15fa:	8522                	mv	a0,s0
    15fc:	40a000ef          	jal	1a06 <strnlen>
    write(f, s, l);
    1600:	0005061b          	sext.w	a2,a0
    1604:	85a2                	mv	a1,s0
    1606:	4505                	li	a0,1
    1608:	6f6000ef          	jal	1cfe <write>
        s += 2;
    160c:	00248513          	addi	a0,s1,2
    1610:	bfb1                	j	156c <printf+0x1ba>
    return write(stdout, &byte, 1);
    1612:	4605                	li	a2,1
    1614:	002c                	addi	a1,sp,8
    1616:	4505                	li	a0,1
    char byte = c;
    1618:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    161c:	6e2000ef          	jal	1cfe <write>
    char byte = c;
    1620:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    1624:	4605                	li	a2,1
    1626:	002c                	addi	a1,sp,8
    1628:	4505                	li	a0,1
    char byte = c;
    162a:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    162e:	6d0000ef          	jal	1cfe <write>
        s += 2;
    1632:	00248513          	addi	a0,s1,2
    1636:	bf1d                	j	156c <printf+0x1ba>
                a = "(null)";
    1638:	845e                	mv	s0,s7
    163a:	bf75                	j	15f6 <printf+0x244>

000000000000163c <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    163c:	1141                	addi	sp,sp,-16
    163e:	e406                	sd	ra,8(sp)
    puts(m);
    1640:	d51ff0ef          	jal	1390 <puts>
    exit(-100);
}
    1644:	60a2                	ld	ra,8(sp)
    exit(-100);
    1646:	f9c00513          	li	a0,-100
}
    164a:	0141                	addi	sp,sp,16
    exit(-100);
    164c:	a709                	j	1d4e <exit>

000000000000164e <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    164e:	02000793          	li	a5,32
    1652:	00f50663          	beq	a0,a5,165e <isspace+0x10>
    1656:	355d                	addiw	a0,a0,-9
    1658:	00553513          	sltiu	a0,a0,5
    165c:	8082                	ret
    165e:	4505                	li	a0,1
}
    1660:	8082                	ret

0000000000001662 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1662:	fd05051b          	addiw	a0,a0,-48
}
    1666:	00a53513          	sltiu	a0,a0,10
    166a:	8082                	ret

000000000000166c <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    166c:	02000613          	li	a2,32
    1670:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1672:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1676:	ff77069b          	addiw	a3,a4,-9
    167a:	04c70d63          	beq	a4,a2,16d4 <atoi+0x68>
    167e:	0007079b          	sext.w	a5,a4
    1682:	04d5f963          	bgeu	a1,a3,16d4 <atoi+0x68>
        s++;
    switch (*s)
    1686:	02b00693          	li	a3,43
    168a:	04d70a63          	beq	a4,a3,16de <atoi+0x72>
    168e:	02d00693          	li	a3,45
    1692:	06d70463          	beq	a4,a3,16fa <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1696:	fd07859b          	addiw	a1,a5,-48
    169a:	4625                	li	a2,9
    169c:	873e                	mv	a4,a5
    169e:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    16a0:	4e01                	li	t3,0
    while (isdigit(*s))
    16a2:	04b66a63          	bltu	a2,a1,16f6 <atoi+0x8a>
    int n = 0, neg = 0;
    16a6:	4501                	li	a0,0
    while (isdigit(*s))
    16a8:	4825                	li	a6,9
    16aa:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    16ae:	0025179b          	slliw	a5,a0,0x2
    16b2:	9d3d                	addw	a0,a0,a5
    16b4:	fd07031b          	addiw	t1,a4,-48
    16b8:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    16bc:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    16c0:	0685                	addi	a3,a3,1
    16c2:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    16c6:	0006071b          	sext.w	a4,a2
    16ca:	feb870e3          	bgeu	a6,a1,16aa <atoi+0x3e>
    return neg ? n : -n;
    16ce:	000e0563          	beqz	t3,16d8 <atoi+0x6c>
}
    16d2:	8082                	ret
        s++;
    16d4:	0505                	addi	a0,a0,1
    16d6:	bf71                	j	1672 <atoi+0x6>
    return neg ? n : -n;
    16d8:	4113053b          	subw	a0,t1,a7
    16dc:	8082                	ret
    while (isdigit(*s))
    16de:	00154783          	lbu	a5,1(a0)
    16e2:	4625                	li	a2,9
        s++;
    16e4:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16e8:	fd07859b          	addiw	a1,a5,-48
    16ec:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16f0:	4e01                	li	t3,0
    while (isdigit(*s))
    16f2:	fab67ae3          	bgeu	a2,a1,16a6 <atoi+0x3a>
    16f6:	4501                	li	a0,0
}
    16f8:	8082                	ret
    while (isdigit(*s))
    16fa:	00154783          	lbu	a5,1(a0)
    16fe:	4625                	li	a2,9
        s++;
    1700:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1704:	fd07859b          	addiw	a1,a5,-48
    1708:	0007871b          	sext.w	a4,a5
    170c:	feb665e3          	bltu	a2,a1,16f6 <atoi+0x8a>
        neg = 1;
    1710:	4e05                	li	t3,1
    1712:	bf51                	j	16a6 <atoi+0x3a>

0000000000001714 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1714:	16060d63          	beqz	a2,188e <memset+0x17a>
    1718:	40a007b3          	neg	a5,a0
    171c:	8b9d                	andi	a5,a5,7
    171e:	00778713          	addi	a4,a5,7
    1722:	482d                	li	a6,11
    1724:	0ff5f593          	zext.b	a1,a1
    1728:	fff60693          	addi	a3,a2,-1
    172c:	17076263          	bltu	a4,a6,1890 <memset+0x17c>
    1730:	16e6ea63          	bltu	a3,a4,18a4 <memset+0x190>
    1734:	16078563          	beqz	a5,189e <memset+0x18a>
    1738:	00b50023          	sb	a1,0(a0)
    173c:	4705                	li	a4,1
    173e:	00150e93          	addi	t4,a0,1
    1742:	14e78c63          	beq	a5,a4,189a <memset+0x186>
    1746:	00b500a3          	sb	a1,1(a0)
    174a:	4709                	li	a4,2
    174c:	00250e93          	addi	t4,a0,2
    1750:	14e78d63          	beq	a5,a4,18aa <memset+0x196>
    1754:	00b50123          	sb	a1,2(a0)
    1758:	470d                	li	a4,3
    175a:	00350e93          	addi	t4,a0,3
    175e:	12e78b63          	beq	a5,a4,1894 <memset+0x180>
    1762:	00b501a3          	sb	a1,3(a0)
    1766:	4711                	li	a4,4
    1768:	00450e93          	addi	t4,a0,4
    176c:	14e78163          	beq	a5,a4,18ae <memset+0x19a>
    1770:	00b50223          	sb	a1,4(a0)
    1774:	4715                	li	a4,5
    1776:	00550e93          	addi	t4,a0,5
    177a:	12e78c63          	beq	a5,a4,18b2 <memset+0x19e>
    177e:	00b502a3          	sb	a1,5(a0)
    1782:	471d                	li	a4,7
    1784:	00650e93          	addi	t4,a0,6
    1788:	12e79763          	bne	a5,a4,18b6 <memset+0x1a2>
    178c:	00750e93          	addi	t4,a0,7
    1790:	00b50323          	sb	a1,6(a0)
    1794:	4f1d                	li	t5,7
    1796:	00859713          	slli	a4,a1,0x8
    179a:	8f4d                	or	a4,a4,a1
    179c:	01059e13          	slli	t3,a1,0x10
    17a0:	01c76e33          	or	t3,a4,t3
    17a4:	01859313          	slli	t1,a1,0x18
    17a8:	006e6333          	or	t1,t3,t1
    17ac:	02059893          	slli	a7,a1,0x20
    17b0:	011368b3          	or	a7,t1,a7
    17b4:	02859813          	slli	a6,a1,0x28
    17b8:	40f60333          	sub	t1,a2,a5
    17bc:	0108e833          	or	a6,a7,a6
    17c0:	03059693          	slli	a3,a1,0x30
    17c4:	00d866b3          	or	a3,a6,a3
    17c8:	03859713          	slli	a4,a1,0x38
    17cc:	97aa                	add	a5,a5,a0
    17ce:	ff837813          	andi	a6,t1,-8
    17d2:	8f55                	or	a4,a4,a3
    17d4:	00f806b3          	add	a3,a6,a5
    17d8:	e398                	sd	a4,0(a5)
    17da:	07a1                	addi	a5,a5,8
    17dc:	fed79ee3          	bne	a5,a3,17d8 <memset+0xc4>
    17e0:	ff837693          	andi	a3,t1,-8
    17e4:	00de87b3          	add	a5,t4,a3
    17e8:	01e6873b          	addw	a4,a3,t5
    17ec:	0ad30663          	beq	t1,a3,1898 <memset+0x184>
    17f0:	00b78023          	sb	a1,0(a5)
    17f4:	0017069b          	addiw	a3,a4,1
    17f8:	08c6fb63          	bgeu	a3,a2,188e <memset+0x17a>
    17fc:	00b780a3          	sb	a1,1(a5)
    1800:	0027069b          	addiw	a3,a4,2
    1804:	08c6f563          	bgeu	a3,a2,188e <memset+0x17a>
    1808:	00b78123          	sb	a1,2(a5)
    180c:	0037069b          	addiw	a3,a4,3
    1810:	06c6ff63          	bgeu	a3,a2,188e <memset+0x17a>
    1814:	00b781a3          	sb	a1,3(a5)
    1818:	0047069b          	addiw	a3,a4,4
    181c:	06c6f963          	bgeu	a3,a2,188e <memset+0x17a>
    1820:	00b78223          	sb	a1,4(a5)
    1824:	0057069b          	addiw	a3,a4,5
    1828:	06c6f363          	bgeu	a3,a2,188e <memset+0x17a>
    182c:	00b782a3          	sb	a1,5(a5)
    1830:	0067069b          	addiw	a3,a4,6
    1834:	04c6fd63          	bgeu	a3,a2,188e <memset+0x17a>
    1838:	00b78323          	sb	a1,6(a5)
    183c:	0077069b          	addiw	a3,a4,7
    1840:	04c6f763          	bgeu	a3,a2,188e <memset+0x17a>
    1844:	00b783a3          	sb	a1,7(a5)
    1848:	0087069b          	addiw	a3,a4,8
    184c:	04c6f163          	bgeu	a3,a2,188e <memset+0x17a>
    1850:	00b78423          	sb	a1,8(a5)
    1854:	0097069b          	addiw	a3,a4,9
    1858:	02c6fb63          	bgeu	a3,a2,188e <memset+0x17a>
    185c:	00b784a3          	sb	a1,9(a5)
    1860:	00a7069b          	addiw	a3,a4,10
    1864:	02c6f563          	bgeu	a3,a2,188e <memset+0x17a>
    1868:	00b78523          	sb	a1,10(a5)
    186c:	00b7069b          	addiw	a3,a4,11
    1870:	00c6ff63          	bgeu	a3,a2,188e <memset+0x17a>
    1874:	00b785a3          	sb	a1,11(a5)
    1878:	00c7069b          	addiw	a3,a4,12
    187c:	00c6f963          	bgeu	a3,a2,188e <memset+0x17a>
    1880:	00b78623          	sb	a1,12(a5)
    1884:	2735                	addiw	a4,a4,13
    1886:	00c77463          	bgeu	a4,a2,188e <memset+0x17a>
    188a:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    188e:	8082                	ret
    1890:	472d                	li	a4,11
    1892:	bd79                	j	1730 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1894:	4f0d                	li	t5,3
    1896:	b701                	j	1796 <memset+0x82>
    1898:	8082                	ret
    189a:	4f05                	li	t5,1
    189c:	bded                	j	1796 <memset+0x82>
    189e:	8eaa                	mv	t4,a0
    18a0:	4f01                	li	t5,0
    18a2:	bdd5                	j	1796 <memset+0x82>
    18a4:	87aa                	mv	a5,a0
    18a6:	4701                	li	a4,0
    18a8:	b7a1                	j	17f0 <memset+0xdc>
    18aa:	4f09                	li	t5,2
    18ac:	b5ed                	j	1796 <memset+0x82>
    18ae:	4f11                	li	t5,4
    18b0:	b5dd                	j	1796 <memset+0x82>
    18b2:	4f15                	li	t5,5
    18b4:	b5cd                	j	1796 <memset+0x82>
    18b6:	4f19                	li	t5,6
    18b8:	bdf9                	j	1796 <memset+0x82>

00000000000018ba <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    18ba:	00054783          	lbu	a5,0(a0)
    18be:	0005c703          	lbu	a4,0(a1)
    18c2:	00e79863          	bne	a5,a4,18d2 <strcmp+0x18>
    18c6:	0505                	addi	a0,a0,1
    18c8:	0585                	addi	a1,a1,1
    18ca:	fbe5                	bnez	a5,18ba <strcmp>
    18cc:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    18ce:	9d19                	subw	a0,a0,a4
    18d0:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    18d2:	0007851b          	sext.w	a0,a5
    18d6:	bfe5                	j	18ce <strcmp+0x14>

00000000000018d8 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    18d8:	ce05                	beqz	a2,1910 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18da:	00054703          	lbu	a4,0(a0)
    18de:	0005c783          	lbu	a5,0(a1)
    18e2:	cb0d                	beqz	a4,1914 <strncmp+0x3c>
    if (!n--)
    18e4:	167d                	addi	a2,a2,-1
    18e6:	00c506b3          	add	a3,a0,a2
    18ea:	a819                	j	1900 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18ec:	00a68e63          	beq	a3,a0,1908 <strncmp+0x30>
    18f0:	0505                	addi	a0,a0,1
    18f2:	00e79b63          	bne	a5,a4,1908 <strncmp+0x30>
    18f6:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18fa:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18fe:	cb19                	beqz	a4,1914 <strncmp+0x3c>
    1900:	0005c783          	lbu	a5,0(a1)
    1904:	0585                	addi	a1,a1,1
    1906:	f3fd                	bnez	a5,18ec <strncmp+0x14>
    return *l - *r;
    1908:	0007051b          	sext.w	a0,a4
    190c:	9d1d                	subw	a0,a0,a5
    190e:	8082                	ret
        return 0;
    1910:	4501                	li	a0,0
}
    1912:	8082                	ret
    1914:	4501                	li	a0,0
    return *l - *r;
    1916:	9d1d                	subw	a0,a0,a5
    1918:	8082                	ret

000000000000191a <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    191a:	00757793          	andi	a5,a0,7
    191e:	cf89                	beqz	a5,1938 <strlen+0x1e>
    1920:	87aa                	mv	a5,a0
    1922:	a029                	j	192c <strlen+0x12>
    1924:	0785                	addi	a5,a5,1
    1926:	0077f713          	andi	a4,a5,7
    192a:	cb01                	beqz	a4,193a <strlen+0x20>
        if (!*s)
    192c:	0007c703          	lbu	a4,0(a5)
    1930:	fb75                	bnez	a4,1924 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    1932:	40a78533          	sub	a0,a5,a0
}
    1936:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1938:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    193a:	6394                	ld	a3,0(a5)
    193c:	00000597          	auipc	a1,0x0
    1940:	6ec5b583          	ld	a1,1772(a1) # 2028 <__clone+0xf2>
    1944:	00000617          	auipc	a2,0x0
    1948:	6ec63603          	ld	a2,1772(a2) # 2030 <__clone+0xfa>
    194c:	a019                	j	1952 <strlen+0x38>
    194e:	6794                	ld	a3,8(a5)
    1950:	07a1                	addi	a5,a5,8
    1952:	00b68733          	add	a4,a3,a1
    1956:	fff6c693          	not	a3,a3
    195a:	8f75                	and	a4,a4,a3
    195c:	8f71                	and	a4,a4,a2
    195e:	db65                	beqz	a4,194e <strlen+0x34>
    for (; *s; s++)
    1960:	0007c703          	lbu	a4,0(a5)
    1964:	d779                	beqz	a4,1932 <strlen+0x18>
    1966:	0017c703          	lbu	a4,1(a5)
    196a:	0785                	addi	a5,a5,1
    196c:	d379                	beqz	a4,1932 <strlen+0x18>
    196e:	0017c703          	lbu	a4,1(a5)
    1972:	0785                	addi	a5,a5,1
    1974:	fb6d                	bnez	a4,1966 <strlen+0x4c>
    1976:	bf75                	j	1932 <strlen+0x18>

0000000000001978 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1978:	00757713          	andi	a4,a0,7
{
    197c:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    197e:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1982:	cb19                	beqz	a4,1998 <memchr+0x20>
    1984:	ce25                	beqz	a2,19fc <memchr+0x84>
    1986:	0007c703          	lbu	a4,0(a5)
    198a:	04b70e63          	beq	a4,a1,19e6 <memchr+0x6e>
    198e:	0785                	addi	a5,a5,1
    1990:	0077f713          	andi	a4,a5,7
    1994:	167d                	addi	a2,a2,-1
    1996:	f77d                	bnez	a4,1984 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1998:	4501                	li	a0,0
    if (n && *s != c)
    199a:	c235                	beqz	a2,19fe <memchr+0x86>
    199c:	0007c703          	lbu	a4,0(a5)
    19a0:	04b70363          	beq	a4,a1,19e6 <memchr+0x6e>
        size_t k = ONES * c;
    19a4:	00000517          	auipc	a0,0x0
    19a8:	69453503          	ld	a0,1684(a0) # 2038 <__clone+0x102>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    19ac:	471d                	li	a4,7
        size_t k = ONES * c;
    19ae:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    19b2:	02c77a63          	bgeu	a4,a2,19e6 <memchr+0x6e>
    19b6:	00000897          	auipc	a7,0x0
    19ba:	6728b883          	ld	a7,1650(a7) # 2028 <__clone+0xf2>
    19be:	00000817          	auipc	a6,0x0
    19c2:	67283803          	ld	a6,1650(a6) # 2030 <__clone+0xfa>
    19c6:	431d                	li	t1,7
    19c8:	a029                	j	19d2 <memchr+0x5a>
    19ca:	1661                	addi	a2,a2,-8
    19cc:	07a1                	addi	a5,a5,8
    19ce:	02c37963          	bgeu	t1,a2,1a00 <memchr+0x88>
    19d2:	6398                	ld	a4,0(a5)
    19d4:	8f29                	xor	a4,a4,a0
    19d6:	011706b3          	add	a3,a4,a7
    19da:	fff74713          	not	a4,a4
    19de:	8f75                	and	a4,a4,a3
    19e0:	01077733          	and	a4,a4,a6
    19e4:	d37d                	beqz	a4,19ca <memchr+0x52>
    19e6:	853e                	mv	a0,a5
    19e8:	97b2                	add	a5,a5,a2
    19ea:	a021                	j	19f2 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19ec:	0505                	addi	a0,a0,1
    19ee:	00f50763          	beq	a0,a5,19fc <memchr+0x84>
    19f2:	00054703          	lbu	a4,0(a0)
    19f6:	feb71be3          	bne	a4,a1,19ec <memchr+0x74>
    19fa:	8082                	ret
    return n ? (void *)s : 0;
    19fc:	4501                	li	a0,0
}
    19fe:	8082                	ret
    return n ? (void *)s : 0;
    1a00:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1a02:	f275                	bnez	a2,19e6 <memchr+0x6e>
}
    1a04:	8082                	ret

0000000000001a06 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1a06:	1101                	addi	sp,sp,-32
    1a08:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1a0a:	862e                	mv	a2,a1
{
    1a0c:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1a0e:	4581                	li	a1,0
{
    1a10:	e426                	sd	s1,8(sp)
    1a12:	ec06                	sd	ra,24(sp)
    1a14:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1a16:	f63ff0ef          	jal	1978 <memchr>
    return p ? p - s : n;
    1a1a:	c519                	beqz	a0,1a28 <strnlen+0x22>
}
    1a1c:	60e2                	ld	ra,24(sp)
    1a1e:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1a20:	8d05                	sub	a0,a0,s1
}
    1a22:	64a2                	ld	s1,8(sp)
    1a24:	6105                	addi	sp,sp,32
    1a26:	8082                	ret
    1a28:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1a2a:	8522                	mv	a0,s0
}
    1a2c:	6442                	ld	s0,16(sp)
    1a2e:	64a2                	ld	s1,8(sp)
    1a30:	6105                	addi	sp,sp,32
    1a32:	8082                	ret

0000000000001a34 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    1a34:	00b547b3          	xor	a5,a0,a1
    1a38:	8b9d                	andi	a5,a5,7
    1a3a:	eb95                	bnez	a5,1a6e <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    1a3c:	0075f793          	andi	a5,a1,7
    1a40:	e7b1                	bnez	a5,1a8c <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a42:	6198                	ld	a4,0(a1)
    1a44:	00000617          	auipc	a2,0x0
    1a48:	5e463603          	ld	a2,1508(a2) # 2028 <__clone+0xf2>
    1a4c:	00000817          	auipc	a6,0x0
    1a50:	5e483803          	ld	a6,1508(a6) # 2030 <__clone+0xfa>
    1a54:	a029                	j	1a5e <strcpy+0x2a>
    1a56:	e118                	sd	a4,0(a0)
    1a58:	6598                	ld	a4,8(a1)
    1a5a:	05a1                	addi	a1,a1,8
    1a5c:	0521                	addi	a0,a0,8
    1a5e:	00c707b3          	add	a5,a4,a2
    1a62:	fff74693          	not	a3,a4
    1a66:	8ff5                	and	a5,a5,a3
    1a68:	0107f7b3          	and	a5,a5,a6
    1a6c:	d7ed                	beqz	a5,1a56 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a6e:	0005c783          	lbu	a5,0(a1)
    1a72:	00f50023          	sb	a5,0(a0)
    1a76:	c785                	beqz	a5,1a9e <strcpy+0x6a>
    1a78:	0015c783          	lbu	a5,1(a1)
    1a7c:	0505                	addi	a0,a0,1
    1a7e:	0585                	addi	a1,a1,1
    1a80:	00f50023          	sb	a5,0(a0)
    1a84:	fbf5                	bnez	a5,1a78 <strcpy+0x44>
        ;
    return d;
}
    1a86:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a88:	0505                	addi	a0,a0,1
    1a8a:	df45                	beqz	a4,1a42 <strcpy+0xe>
            if (!(*d = *s))
    1a8c:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a90:	0585                	addi	a1,a1,1
    1a92:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a96:	00f50023          	sb	a5,0(a0)
    1a9a:	f7fd                	bnez	a5,1a88 <strcpy+0x54>
}
    1a9c:	8082                	ret
    1a9e:	8082                	ret

0000000000001aa0 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1aa0:	00b547b3          	xor	a5,a0,a1
    1aa4:	8b9d                	andi	a5,a5,7
    1aa6:	1a079863          	bnez	a5,1c56 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1aaa:	0075f793          	andi	a5,a1,7
    1aae:	16078463          	beqz	a5,1c16 <strncpy+0x176>
    1ab2:	ea01                	bnez	a2,1ac2 <strncpy+0x22>
    1ab4:	a421                	j	1cbc <strncpy+0x21c>
    1ab6:	167d                	addi	a2,a2,-1
    1ab8:	0505                	addi	a0,a0,1
    1aba:	14070e63          	beqz	a4,1c16 <strncpy+0x176>
    1abe:	1a060863          	beqz	a2,1c6e <strncpy+0x1ce>
    1ac2:	0005c783          	lbu	a5,0(a1)
    1ac6:	0585                	addi	a1,a1,1
    1ac8:	0075f713          	andi	a4,a1,7
    1acc:	00f50023          	sb	a5,0(a0)
    1ad0:	f3fd                	bnez	a5,1ab6 <strncpy+0x16>
    1ad2:	4805                	li	a6,1
    1ad4:	1a061863          	bnez	a2,1c84 <strncpy+0x1e4>
    1ad8:	40a007b3          	neg	a5,a0
    1adc:	8b9d                	andi	a5,a5,7
    1ade:	4681                	li	a3,0
    1ae0:	18061a63          	bnez	a2,1c74 <strncpy+0x1d4>
    1ae4:	00778713          	addi	a4,a5,7
    1ae8:	45ad                	li	a1,11
    1aea:	18b76363          	bltu	a4,a1,1c70 <strncpy+0x1d0>
    1aee:	1ae6eb63          	bltu	a3,a4,1ca4 <strncpy+0x204>
    1af2:	1a078363          	beqz	a5,1c98 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1af6:	00050023          	sb	zero,0(a0)
    1afa:	4685                	li	a3,1
    1afc:	00150713          	addi	a4,a0,1
    1b00:	18d78f63          	beq	a5,a3,1c9e <strncpy+0x1fe>
    1b04:	000500a3          	sb	zero,1(a0)
    1b08:	4689                	li	a3,2
    1b0a:	00250713          	addi	a4,a0,2
    1b0e:	18d78e63          	beq	a5,a3,1caa <strncpy+0x20a>
    1b12:	00050123          	sb	zero,2(a0)
    1b16:	468d                	li	a3,3
    1b18:	00350713          	addi	a4,a0,3
    1b1c:	16d78c63          	beq	a5,a3,1c94 <strncpy+0x1f4>
    1b20:	000501a3          	sb	zero,3(a0)
    1b24:	4691                	li	a3,4
    1b26:	00450713          	addi	a4,a0,4
    1b2a:	18d78263          	beq	a5,a3,1cae <strncpy+0x20e>
    1b2e:	00050223          	sb	zero,4(a0)
    1b32:	4695                	li	a3,5
    1b34:	00550713          	addi	a4,a0,5
    1b38:	16d78d63          	beq	a5,a3,1cb2 <strncpy+0x212>
    1b3c:	000502a3          	sb	zero,5(a0)
    1b40:	469d                	li	a3,7
    1b42:	00650713          	addi	a4,a0,6
    1b46:	16d79863          	bne	a5,a3,1cb6 <strncpy+0x216>
    1b4a:	00750713          	addi	a4,a0,7
    1b4e:	00050323          	sb	zero,6(a0)
    1b52:	40f80833          	sub	a6,a6,a5
    1b56:	ff887593          	andi	a1,a6,-8
    1b5a:	97aa                	add	a5,a5,a0
    1b5c:	95be                	add	a1,a1,a5
    1b5e:	0007b023          	sd	zero,0(a5)
    1b62:	07a1                	addi	a5,a5,8
    1b64:	feb79de3          	bne	a5,a1,1b5e <strncpy+0xbe>
    1b68:	ff887593          	andi	a1,a6,-8
    1b6c:	9ead                	addw	a3,a3,a1
    1b6e:	00b707b3          	add	a5,a4,a1
    1b72:	12b80863          	beq	a6,a1,1ca2 <strncpy+0x202>
    1b76:	00078023          	sb	zero,0(a5)
    1b7a:	0016871b          	addiw	a4,a3,1
    1b7e:	0ec77863          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1b82:	000780a3          	sb	zero,1(a5)
    1b86:	0026871b          	addiw	a4,a3,2
    1b8a:	0ec77263          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1b8e:	00078123          	sb	zero,2(a5)
    1b92:	0036871b          	addiw	a4,a3,3
    1b96:	0cc77c63          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1b9a:	000781a3          	sb	zero,3(a5)
    1b9e:	0046871b          	addiw	a4,a3,4
    1ba2:	0cc77663          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1ba6:	00078223          	sb	zero,4(a5)
    1baa:	0056871b          	addiw	a4,a3,5
    1bae:	0cc77063          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1bb2:	000782a3          	sb	zero,5(a5)
    1bb6:	0066871b          	addiw	a4,a3,6
    1bba:	0ac77a63          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1bbe:	00078323          	sb	zero,6(a5)
    1bc2:	0076871b          	addiw	a4,a3,7
    1bc6:	0ac77463          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1bca:	000783a3          	sb	zero,7(a5)
    1bce:	0086871b          	addiw	a4,a3,8
    1bd2:	08c77e63          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1bd6:	00078423          	sb	zero,8(a5)
    1bda:	0096871b          	addiw	a4,a3,9
    1bde:	08c77863          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1be2:	000784a3          	sb	zero,9(a5)
    1be6:	00a6871b          	addiw	a4,a3,10
    1bea:	08c77263          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1bee:	00078523          	sb	zero,10(a5)
    1bf2:	00b6871b          	addiw	a4,a3,11
    1bf6:	06c77c63          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1bfa:	000785a3          	sb	zero,11(a5)
    1bfe:	00c6871b          	addiw	a4,a3,12
    1c02:	06c77663          	bgeu	a4,a2,1c6e <strncpy+0x1ce>
    1c06:	00078623          	sb	zero,12(a5)
    1c0a:	26b5                	addiw	a3,a3,13
    1c0c:	06c6f163          	bgeu	a3,a2,1c6e <strncpy+0x1ce>
    1c10:	000786a3          	sb	zero,13(a5)
    1c14:	8082                	ret
            ;
        if (!n || !*s)
    1c16:	c645                	beqz	a2,1cbe <strncpy+0x21e>
    1c18:	0005c783          	lbu	a5,0(a1)
    1c1c:	ea078be3          	beqz	a5,1ad2 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c20:	479d                	li	a5,7
    1c22:	02c7ff63          	bgeu	a5,a2,1c60 <strncpy+0x1c0>
    1c26:	00000897          	auipc	a7,0x0
    1c2a:	4028b883          	ld	a7,1026(a7) # 2028 <__clone+0xf2>
    1c2e:	00000817          	auipc	a6,0x0
    1c32:	40283803          	ld	a6,1026(a6) # 2030 <__clone+0xfa>
    1c36:	431d                	li	t1,7
    1c38:	6198                	ld	a4,0(a1)
    1c3a:	011707b3          	add	a5,a4,a7
    1c3e:	fff74693          	not	a3,a4
    1c42:	8ff5                	and	a5,a5,a3
    1c44:	0107f7b3          	and	a5,a5,a6
    1c48:	ef81                	bnez	a5,1c60 <strncpy+0x1c0>
            *wd = *ws;
    1c4a:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c4c:	1661                	addi	a2,a2,-8
    1c4e:	05a1                	addi	a1,a1,8
    1c50:	0521                	addi	a0,a0,8
    1c52:	fec363e3          	bltu	t1,a2,1c38 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c56:	e609                	bnez	a2,1c60 <strncpy+0x1c0>
    1c58:	a08d                	j	1cba <strncpy+0x21a>
    1c5a:	167d                	addi	a2,a2,-1
    1c5c:	0505                	addi	a0,a0,1
    1c5e:	ca01                	beqz	a2,1c6e <strncpy+0x1ce>
    1c60:	0005c783          	lbu	a5,0(a1)
    1c64:	0585                	addi	a1,a1,1
    1c66:	00f50023          	sb	a5,0(a0)
    1c6a:	fbe5                	bnez	a5,1c5a <strncpy+0x1ba>
        ;
tail:
    1c6c:	b59d                	j	1ad2 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c6e:	8082                	ret
    1c70:	472d                	li	a4,11
    1c72:	bdb5                	j	1aee <strncpy+0x4e>
    1c74:	00778713          	addi	a4,a5,7
    1c78:	45ad                	li	a1,11
    1c7a:	fff60693          	addi	a3,a2,-1
    1c7e:	e6b778e3          	bgeu	a4,a1,1aee <strncpy+0x4e>
    1c82:	b7fd                	j	1c70 <strncpy+0x1d0>
    1c84:	40a007b3          	neg	a5,a0
    1c88:	8832                	mv	a6,a2
    1c8a:	8b9d                	andi	a5,a5,7
    1c8c:	4681                	li	a3,0
    1c8e:	e4060be3          	beqz	a2,1ae4 <strncpy+0x44>
    1c92:	b7cd                	j	1c74 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c94:	468d                	li	a3,3
    1c96:	bd75                	j	1b52 <strncpy+0xb2>
    1c98:	872a                	mv	a4,a0
    1c9a:	4681                	li	a3,0
    1c9c:	bd5d                	j	1b52 <strncpy+0xb2>
    1c9e:	4685                	li	a3,1
    1ca0:	bd4d                	j	1b52 <strncpy+0xb2>
    1ca2:	8082                	ret
    1ca4:	87aa                	mv	a5,a0
    1ca6:	4681                	li	a3,0
    1ca8:	b5f9                	j	1b76 <strncpy+0xd6>
    1caa:	4689                	li	a3,2
    1cac:	b55d                	j	1b52 <strncpy+0xb2>
    1cae:	4691                	li	a3,4
    1cb0:	b54d                	j	1b52 <strncpy+0xb2>
    1cb2:	4695                	li	a3,5
    1cb4:	bd79                	j	1b52 <strncpy+0xb2>
    1cb6:	4699                	li	a3,6
    1cb8:	bd69                	j	1b52 <strncpy+0xb2>
    1cba:	8082                	ret
    1cbc:	8082                	ret
    1cbe:	8082                	ret

0000000000001cc0 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1cc0:	87aa                	mv	a5,a0
    1cc2:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1cc4:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1cc8:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1ccc:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1cce:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cd0:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1cd4:	2501                	sext.w	a0,a0
    1cd6:	8082                	ret

0000000000001cd8 <openat>:
    register long a7 __asm__("a7") = n;
    1cd8:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1cdc:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ce0:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1ce4:	2501                	sext.w	a0,a0
    1ce6:	8082                	ret

0000000000001ce8 <close>:
    register long a7 __asm__("a7") = n;
    1ce8:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cec:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cf0:	2501                	sext.w	a0,a0
    1cf2:	8082                	ret

0000000000001cf4 <read>:
    register long a7 __asm__("a7") = n;
    1cf4:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cf8:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cfc:	8082                	ret

0000000000001cfe <write>:
    register long a7 __asm__("a7") = n;
    1cfe:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d02:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1d06:	8082                	ret

0000000000001d08 <getpid>:
    register long a7 __asm__("a7") = n;
    1d08:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1d0c:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1d10:	2501                	sext.w	a0,a0
    1d12:	8082                	ret

0000000000001d14 <getppid>:
    register long a7 __asm__("a7") = n;
    1d14:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1d18:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1d1c:	2501                	sext.w	a0,a0
    1d1e:	8082                	ret

0000000000001d20 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1d20:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d24:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1d28:	2501                	sext.w	a0,a0
    1d2a:	8082                	ret

0000000000001d2c <fork>:
    register long a7 __asm__("a7") = n;
    1d2c:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1d30:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1d32:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d34:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1d38:	2501                	sext.w	a0,a0
    1d3a:	8082                	ret

0000000000001d3c <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1d3c:	85b2                	mv	a1,a2
    1d3e:	863a                	mv	a2,a4
    if (stack)
    1d40:	c191                	beqz	a1,1d44 <clone+0x8>
	stack += stack_size;
    1d42:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d44:	4781                	li	a5,0
    1d46:	4701                	li	a4,0
    1d48:	4681                	li	a3,0
    1d4a:	2601                	sext.w	a2,a2
    1d4c:	a2ed                	j	1f36 <__clone>

0000000000001d4e <exit>:
    register long a7 __asm__("a7") = n;
    1d4e:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d52:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d56:	8082                	ret

0000000000001d58 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d58:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d5c:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d5e:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d62:	2501                	sext.w	a0,a0
    1d64:	8082                	ret

0000000000001d66 <exec>:
    register long a7 __asm__("a7") = n;
    1d66:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d6a:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d6e:	2501                	sext.w	a0,a0
    1d70:	8082                	ret

0000000000001d72 <execve>:
    register long a7 __asm__("a7") = n;
    1d72:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d76:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d7a:	2501                	sext.w	a0,a0
    1d7c:	8082                	ret

0000000000001d7e <times>:
    register long a7 __asm__("a7") = n;
    1d7e:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d82:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d86:	2501                	sext.w	a0,a0
    1d88:	8082                	ret

0000000000001d8a <get_time>:

int64 get_time()
{
    1d8a:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d8c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d90:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d92:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d94:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d98:	2501                	sext.w	a0,a0
    1d9a:	ed09                	bnez	a0,1db4 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d9c:	67a2                	ld	a5,8(sp)
    1d9e:	3e800713          	li	a4,1000
    1da2:	00015503          	lhu	a0,0(sp)
    1da6:	02e7d7b3          	divu	a5,a5,a4
    1daa:	02e50533          	mul	a0,a0,a4
    1dae:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1db0:	0141                	addi	sp,sp,16
    1db2:	8082                	ret
        return -1;
    1db4:	557d                	li	a0,-1
    1db6:	bfed                	j	1db0 <get_time+0x26>

0000000000001db8 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1db8:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dbc:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1dc0:	2501                	sext.w	a0,a0
    1dc2:	8082                	ret

0000000000001dc4 <time>:
    register long a7 __asm__("a7") = n;
    1dc4:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1dc8:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1dcc:	2501                	sext.w	a0,a0
    1dce:	8082                	ret

0000000000001dd0 <sleep>:

int sleep(unsigned long long time)
{
    1dd0:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1dd2:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1dd4:	850a                	mv	a0,sp
    1dd6:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1dd8:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1ddc:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dde:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1de2:	e501                	bnez	a0,1dea <sleep+0x1a>
    return 0;
    1de4:	4501                	li	a0,0
}
    1de6:	0141                	addi	sp,sp,16
    1de8:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dea:	4502                	lw	a0,0(sp)
}
    1dec:	0141                	addi	sp,sp,16
    1dee:	8082                	ret

0000000000001df0 <set_priority>:
    register long a7 __asm__("a7") = n;
    1df0:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1df4:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1df8:	2501                	sext.w	a0,a0
    1dfa:	8082                	ret

0000000000001dfc <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1dfc:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1e00:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1e04:	8082                	ret

0000000000001e06 <munmap>:
    register long a7 __asm__("a7") = n;
    1e06:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e0a:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1e0e:	2501                	sext.w	a0,a0
    1e10:	8082                	ret

0000000000001e12 <wait>:

int wait(int *code)
{
    1e12:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e14:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1e18:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1e1a:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1e1c:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1e1e:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1e22:	2501                	sext.w	a0,a0
    1e24:	8082                	ret

0000000000001e26 <spawn>:
    register long a7 __asm__("a7") = n;
    1e26:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1e2a:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1e2e:	2501                	sext.w	a0,a0
    1e30:	8082                	ret

0000000000001e32 <mailread>:
    register long a7 __asm__("a7") = n;
    1e32:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e36:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1e3a:	2501                	sext.w	a0,a0
    1e3c:	8082                	ret

0000000000001e3e <mailwrite>:
    register long a7 __asm__("a7") = n;
    1e3e:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e42:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e46:	2501                	sext.w	a0,a0
    1e48:	8082                	ret

0000000000001e4a <fstat>:
    register long a7 __asm__("a7") = n;
    1e4a:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e4e:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e52:	2501                	sext.w	a0,a0
    1e54:	8082                	ret

0000000000001e56 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e56:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e58:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e5c:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e5e:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e62:	2501                	sext.w	a0,a0
    1e64:	8082                	ret

0000000000001e66 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e66:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e68:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e6c:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e6e:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e72:	2501                	sext.w	a0,a0
    1e74:	8082                	ret

0000000000001e76 <link>:

int link(char *old_path, char *new_path)
{
    1e76:	87aa                	mv	a5,a0
    1e78:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e7a:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e7e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e82:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e84:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e88:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e8a:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e8e:	2501                	sext.w	a0,a0
    1e90:	8082                	ret

0000000000001e92 <unlink>:

int unlink(char *path)
{
    1e92:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e94:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e98:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e9c:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e9e:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1ea2:	2501                	sext.w	a0,a0
    1ea4:	8082                	ret

0000000000001ea6 <uname>:
    register long a7 __asm__("a7") = n;
    1ea6:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1eaa:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1eae:	2501                	sext.w	a0,a0
    1eb0:	8082                	ret

0000000000001eb2 <brk>:
    register long a7 __asm__("a7") = n;
    1eb2:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1eb6:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1eba:	2501                	sext.w	a0,a0
    1ebc:	8082                	ret

0000000000001ebe <getcwd>:
    register long a7 __asm__("a7") = n;
    1ebe:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ec0:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1ec4:	8082                	ret

0000000000001ec6 <chdir>:
    register long a7 __asm__("a7") = n;
    1ec6:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1eca:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1ece:	2501                	sext.w	a0,a0
    1ed0:	8082                	ret

0000000000001ed2 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1ed2:	862e                	mv	a2,a1
    1ed4:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1ed6:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1ed8:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1edc:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1ee0:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1ee2:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ee4:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1ee8:	2501                	sext.w	a0,a0
    1eea:	8082                	ret

0000000000001eec <getdents>:
    register long a7 __asm__("a7") = n;
    1eec:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ef0:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ef4:	2501                	sext.w	a0,a0
    1ef6:	8082                	ret

0000000000001ef8 <pipe>:
    register long a7 __asm__("a7") = n;
    1ef8:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1efc:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1efe:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1f02:	2501                	sext.w	a0,a0
    1f04:	8082                	ret

0000000000001f06 <dup>:
    register long a7 __asm__("a7") = n;
    1f06:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1f08:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1f0c:	2501                	sext.w	a0,a0
    1f0e:	8082                	ret

0000000000001f10 <dup2>:
    register long a7 __asm__("a7") = n;
    1f10:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1f12:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f14:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1f18:	2501                	sext.w	a0,a0
    1f1a:	8082                	ret

0000000000001f1c <mount>:
    register long a7 __asm__("a7") = n;
    1f1c:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1f20:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1f24:	2501                	sext.w	a0,a0
    1f26:	8082                	ret

0000000000001f28 <umount>:
    register long a7 __asm__("a7") = n;
    1f28:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1f2c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f2e:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1f32:	2501                	sext.w	a0,a0
    1f34:	8082                	ret

0000000000001f36 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1f36:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1f38:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1f3a:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1f3c:	8532                	mv	a0,a2
	mv a2, a4
    1f3e:	863a                	mv	a2,a4
	mv a3, a5
    1f40:	86be                	mv	a3,a5
	mv a4, a6
    1f42:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f44:	0dc00893          	li	a7,220
	ecall
    1f48:	00000073          	ecall

	beqz a0, 1f
    1f4c:	c111                	beqz	a0,1f50 <__clone+0x1a>
	# Parent
	ret
    1f4e:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f50:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f52:	6522                	ld	a0,8(sp)
	jalr a1
    1f54:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f56:	05d00893          	li	a7,93
	ecall
    1f5a:	00000073          	ecall
