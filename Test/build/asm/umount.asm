
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/umount:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	aa21                	j	111a <__start_main>

0000000000001004 <test_umount>:

static char mntpoint[64] = "./mnt";
static char device[64] = "/dev/vda2";
static const char *fs_type = "vfat";

void test_umount() {
    1004:	1101                	addi	sp,sp,-32
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f5a50513          	addi	a0,a0,-166 # 1f60 <__clone+0x2e>
void test_umount() {
    100e:	ec06                	sd	ra,24(sp)
    1010:	e822                	sd	s0,16(sp)
	TEST_START(__func__);
    1012:	37a000ef          	jal	138c <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	09a50513          	addi	a0,a0,154 # 20b0 <__func__.0>
    101e:	36e000ef          	jal	138c <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	f5650513          	addi	a0,a0,-170 # 1f78 <__clone+0x46>
    102a:	362000ef          	jal	138c <puts>

	printf("Mounting dev:%s to %s\n", device, mntpoint);
    102e:	00001617          	auipc	a2,0x1
    1032:	00260613          	addi	a2,a2,2 # 2030 <mntpoint>
    1036:	00001597          	auipc	a1,0x1
    103a:	03a58593          	addi	a1,a1,58 # 2070 <device>
    103e:	00001517          	auipc	a0,0x1
    1042:	f4a50513          	addi	a0,a0,-182 # 1f88 <__clone+0x56>
    1046:	368000ef          	jal	13ae <printf>
	int ret = mount(device, mntpoint, fs_type, 0, NULL);
    104a:	00001597          	auipc	a1,0x1
    104e:	fe658593          	addi	a1,a1,-26 # 2030 <mntpoint>
    1052:	4701                	li	a4,0
    1054:	4681                	li	a3,0
    1056:	00001617          	auipc	a2,0x1
    105a:	f4a60613          	addi	a2,a2,-182 # 1fa0 <__clone+0x6e>
    105e:	00001517          	auipc	a0,0x1
    1062:	01250513          	addi	a0,a0,18 # 2070 <device>
    1066:	6b3000ef          	jal	1f18 <mount>
    106a:	842a                	mv	s0,a0
	printf("mount return: %d\n", ret);
    106c:	85aa                	mv	a1,a0
    106e:	00001517          	auipc	a0,0x1
    1072:	f3a50513          	addi	a0,a0,-198 # 1fa8 <__clone+0x76>
    1076:	338000ef          	jal	13ae <printf>

	if (ret == 0) {
    107a:	c40d                	beqz	s0,10a4 <test_umount+0xa0>
		ret = umount(mntpoint);
		assert(ret == 0);
		printf("umount success.\nreturn: %d\n", ret);
	}

	TEST_END(__func__);
    107c:	00001517          	auipc	a0,0x1
    1080:	f8450513          	addi	a0,a0,-124 # 2000 <__clone+0xce>
    1084:	308000ef          	jal	138c <puts>
    1088:	00001517          	auipc	a0,0x1
    108c:	02850513          	addi	a0,a0,40 # 20b0 <__func__.0>
    1090:	2fc000ef          	jal	138c <puts>
}
    1094:	6442                	ld	s0,16(sp)
    1096:	60e2                	ld	ra,24(sp)
	TEST_END(__func__);
    1098:	00001517          	auipc	a0,0x1
    109c:	ee050513          	addi	a0,a0,-288 # 1f78 <__clone+0x46>
}
    10a0:	6105                	addi	sp,sp,32
	TEST_END(__func__);
    10a2:	a4ed                	j	138c <puts>
		ret = umount(mntpoint);
    10a4:	00001517          	auipc	a0,0x1
    10a8:	f8c50513          	addi	a0,a0,-116 # 2030 <mntpoint>
    10ac:	679000ef          	jal	1f24 <umount>
    10b0:	85aa                	mv	a1,a0
		assert(ret == 0);
    10b2:	e901                	bnez	a0,10c2 <test_umount+0xbe>
		printf("umount success.\nreturn: %d\n", ret);
    10b4:	00001517          	auipc	a0,0x1
    10b8:	f2c50513          	addi	a0,a0,-212 # 1fe0 <__clone+0xae>
    10bc:	2f2000ef          	jal	13ae <printf>
    10c0:	bf75                	j	107c <test_umount+0x78>
    10c2:	e42a                	sd	a0,8(sp)
		assert(ret == 0);
    10c4:	00001517          	auipc	a0,0x1
    10c8:	efc50513          	addi	a0,a0,-260 # 1fc0 <__clone+0x8e>
    10cc:	56c000ef          	jal	1638 <panic>
    10d0:	65a2                	ld	a1,8(sp)
    10d2:	b7cd                	j	10b4 <test_umount+0xb0>

00000000000010d4 <main>:

int main(int argc,char *argv[]) {
    10d4:	1101                	addi	sp,sp,-32
    10d6:	ec06                	sd	ra,24(sp)
    10d8:	e822                	sd	s0,16(sp)
    10da:	e426                	sd	s1,8(sp)
	if(argc >= 2){
    10dc:	4785                	li	a5,1
    10de:	00a7ca63          	blt	a5,a0,10f2 <main+0x1e>

	if(argc >= 3){
		strcpy(mntpoint, argv[2]);
	}

	test_umount();
    10e2:	f23ff0ef          	jal	1004 <test_umount>
	return 0;
}
    10e6:	60e2                	ld	ra,24(sp)
    10e8:	6442                	ld	s0,16(sp)
    10ea:	64a2                	ld	s1,8(sp)
    10ec:	4501                	li	a0,0
    10ee:	6105                	addi	sp,sp,32
    10f0:	8082                	ret
		strcpy(device, argv[1]);
    10f2:	84ae                	mv	s1,a1
    10f4:	658c                	ld	a1,8(a1)
    10f6:	842a                	mv	s0,a0
    10f8:	00001517          	auipc	a0,0x1
    10fc:	f7850513          	addi	a0,a0,-136 # 2070 <device>
    1100:	131000ef          	jal	1a30 <strcpy>
	if(argc >= 3){
    1104:	4789                	li	a5,2
    1106:	fcf40ee3          	beq	s0,a5,10e2 <main+0xe>
		strcpy(mntpoint, argv[2]);
    110a:	688c                	ld	a1,16(s1)
    110c:	00001517          	auipc	a0,0x1
    1110:	f2450513          	addi	a0,a0,-220 # 2030 <mntpoint>
    1114:	11d000ef          	jal	1a30 <strcpy>
    1118:	b7e9                	j	10e2 <main+0xe>

000000000000111a <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    111a:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    111c:	4108                	lw	a0,0(a0)
{
    111e:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1120:	05a1                	addi	a1,a1,8
{
    1122:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    1124:	fb1ff0ef          	jal	10d4 <main>
    1128:	423000ef          	jal	1d4a <exit>
	return 0;
}
    112c:	60a2                	ld	ra,8(sp)
    112e:	4501                	li	a0,0
    1130:	0141                	addi	sp,sp,16
    1132:	8082                	ret

0000000000001134 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    1134:	7179                	addi	sp,sp,-48
    1136:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    1138:	12054b63          	bltz	a0,126e <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    113c:	02b577bb          	remuw	a5,a0,a1
    1140:	00001617          	auipc	a2,0x1
    1144:	f8060613          	addi	a2,a2,-128 # 20c0 <digits>
    buf[16] = 0;
    1148:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    114c:	0005871b          	sext.w	a4,a1
    1150:	1782                	slli	a5,a5,0x20
    1152:	9381                	srli	a5,a5,0x20
    1154:	97b2                	add	a5,a5,a2
    1156:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    115a:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    115e:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1162:	1cb56363          	bltu	a0,a1,1328 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    1166:	45b9                	li	a1,14
    1168:	02e877bb          	remuw	a5,a6,a4
    116c:	1782                	slli	a5,a5,0x20
    116e:	9381                	srli	a5,a5,0x20
    1170:	97b2                	add	a5,a5,a2
    1172:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1176:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    117a:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    117e:	0ce86e63          	bltu	a6,a4,125a <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1182:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1186:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    118a:	1582                	slli	a1,a1,0x20
    118c:	9181                	srli	a1,a1,0x20
    118e:	95b2                	add	a1,a1,a2
    1190:	0005c583          	lbu	a1,0(a1)
    1194:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    1198:	0007859b          	sext.w	a1,a5
    119c:	12e6ec63          	bltu	a3,a4,12d4 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    11a0:	02e7f6bb          	remuw	a3,a5,a4
    11a4:	1682                	slli	a3,a3,0x20
    11a6:	9281                	srli	a3,a3,0x20
    11a8:	96b2                	add	a3,a3,a2
    11aa:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11ae:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    11b2:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    11b6:	12e5e863          	bltu	a1,a4,12e6 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    11ba:	02e876bb          	remuw	a3,a6,a4
    11be:	1682                	slli	a3,a3,0x20
    11c0:	9281                	srli	a3,a3,0x20
    11c2:	96b2                	add	a3,a3,a2
    11c4:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11c8:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11cc:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    11d0:	12e86463          	bltu	a6,a4,12f8 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    11d4:	02e5f6bb          	remuw	a3,a1,a4
    11d8:	1682                	slli	a3,a3,0x20
    11da:	9281                	srli	a3,a3,0x20
    11dc:	96b2                	add	a3,a3,a2
    11de:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11e2:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11e6:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    11ea:	0ce5ec63          	bltu	a1,a4,12c2 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    11ee:	02e876bb          	remuw	a3,a6,a4
    11f2:	1682                	slli	a3,a3,0x20
    11f4:	9281                	srli	a3,a3,0x20
    11f6:	96b2                	add	a3,a3,a2
    11f8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11fc:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1200:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    1204:	10e86963          	bltu	a6,a4,1316 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    1208:	02e5f6bb          	remuw	a3,a1,a4
    120c:	1682                	slli	a3,a3,0x20
    120e:	9281                	srli	a3,a3,0x20
    1210:	96b2                	add	a3,a3,a2
    1212:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1216:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    121a:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    121e:	10e5e763          	bltu	a1,a4,132c <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    1222:	02e876bb          	remuw	a3,a6,a4
    1226:	1682                	slli	a3,a3,0x20
    1228:	9281                	srli	a3,a3,0x20
    122a:	96b2                	add	a3,a3,a2
    122c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1230:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    1234:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    1238:	10e86363          	bltu	a6,a4,133e <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    123c:	1782                	slli	a5,a5,0x20
    123e:	9381                	srli	a5,a5,0x20
    1240:	97b2                	add	a5,a5,a2
    1242:	0007c783          	lbu	a5,0(a5)
    1246:	4599                	li	a1,6
    1248:	00f10723          	sb	a5,14(sp)

    if (sign)
    124c:	00055763          	bgez	a0,125a <printint.constprop.0+0x126>
        buf[i--] = '-';
    1250:	02d00793          	li	a5,45
    1254:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    1258:	4595                	li	a1,5
    write(f, s, l);
    125a:	003c                	addi	a5,sp,8
    125c:	4641                	li	a2,16
    125e:	9e0d                	subw	a2,a2,a1
    1260:	4505                	li	a0,1
    1262:	95be                	add	a1,a1,a5
    1264:	297000ef          	jal	1cfa <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1268:	70a2                	ld	ra,40(sp)
    126a:	6145                	addi	sp,sp,48
    126c:	8082                	ret
        x = -xx;
    126e:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1272:	02b877bb          	remuw	a5,a6,a1
    1276:	00001617          	auipc	a2,0x1
    127a:	e4a60613          	addi	a2,a2,-438 # 20c0 <digits>
    buf[16] = 0;
    127e:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1282:	0005871b          	sext.w	a4,a1
    1286:	1782                	slli	a5,a5,0x20
    1288:	9381                	srli	a5,a5,0x20
    128a:	97b2                	add	a5,a5,a2
    128c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1290:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1294:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1298:	06b86963          	bltu	a6,a1,130a <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    129c:	02e8f7bb          	remuw	a5,a7,a4
    12a0:	1782                	slli	a5,a5,0x20
    12a2:	9381                	srli	a5,a5,0x20
    12a4:	97b2                	add	a5,a5,a2
    12a6:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    12aa:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    12ae:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    12b2:	ece8f8e3          	bgeu	a7,a4,1182 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    12b6:	02d00793          	li	a5,45
    12ba:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    12be:	45b5                	li	a1,13
    12c0:	bf69                	j	125a <printint.constprop.0+0x126>
    12c2:	45a9                	li	a1,10
    if (sign)
    12c4:	f8055be3          	bgez	a0,125a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c8:	02d00793          	li	a5,45
    12cc:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    12d0:	45a5                	li	a1,9
    12d2:	b761                	j	125a <printint.constprop.0+0x126>
    12d4:	45b5                	li	a1,13
    if (sign)
    12d6:	f80552e3          	bgez	a0,125a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12da:	02d00793          	li	a5,45
    12de:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    12e2:	45b1                	li	a1,12
    12e4:	bf9d                	j	125a <printint.constprop.0+0x126>
    12e6:	45b1                	li	a1,12
    if (sign)
    12e8:	f60559e3          	bgez	a0,125a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12ec:	02d00793          	li	a5,45
    12f0:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12f4:	45ad                	li	a1,11
    12f6:	b795                	j	125a <printint.constprop.0+0x126>
    12f8:	45ad                	li	a1,11
    if (sign)
    12fa:	f60550e3          	bgez	a0,125a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12fe:	02d00793          	li	a5,45
    1302:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    1306:	45a9                	li	a1,10
    1308:	bf89                	j	125a <printint.constprop.0+0x126>
        buf[i--] = '-';
    130a:	02d00793          	li	a5,45
    130e:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1312:	45b9                	li	a1,14
    1314:	b799                	j	125a <printint.constprop.0+0x126>
    1316:	45a5                	li	a1,9
    if (sign)
    1318:	f40551e3          	bgez	a0,125a <printint.constprop.0+0x126>
        buf[i--] = '-';
    131c:	02d00793          	li	a5,45
    1320:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    1324:	45a1                	li	a1,8
    1326:	bf15                	j	125a <printint.constprop.0+0x126>
    i = 15;
    1328:	45bd                	li	a1,15
    132a:	bf05                	j	125a <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    132c:	45a1                	li	a1,8
    if (sign)
    132e:	f20556e3          	bgez	a0,125a <printint.constprop.0+0x126>
        buf[i--] = '-';
    1332:	02d00793          	li	a5,45
    1336:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    133a:	459d                	li	a1,7
    133c:	bf39                	j	125a <printint.constprop.0+0x126>
    133e:	459d                	li	a1,7
    if (sign)
    1340:	f0055de3          	bgez	a0,125a <printint.constprop.0+0x126>
        buf[i--] = '-';
    1344:	02d00793          	li	a5,45
    1348:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    134c:	4599                	li	a1,6
    134e:	b731                	j	125a <printint.constprop.0+0x126>

0000000000001350 <getchar>:
{
    1350:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1352:	00f10593          	addi	a1,sp,15
    1356:	4605                	li	a2,1
    1358:	4501                	li	a0,0
{
    135a:	ec06                	sd	ra,24(sp)
    char byte = 0;
    135c:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1360:	191000ef          	jal	1cf0 <read>
}
    1364:	60e2                	ld	ra,24(sp)
    1366:	00f14503          	lbu	a0,15(sp)
    136a:	6105                	addi	sp,sp,32
    136c:	8082                	ret

000000000000136e <putchar>:
{
    136e:	1101                	addi	sp,sp,-32
    1370:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1372:	00f10593          	addi	a1,sp,15
    1376:	4605                	li	a2,1
    1378:	4505                	li	a0,1
{
    137a:	ec06                	sd	ra,24(sp)
    char byte = c;
    137c:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1380:	17b000ef          	jal	1cfa <write>
}
    1384:	60e2                	ld	ra,24(sp)
    1386:	2501                	sext.w	a0,a0
    1388:	6105                	addi	sp,sp,32
    138a:	8082                	ret

000000000000138c <puts>:
{
    138c:	1141                	addi	sp,sp,-16
    138e:	e406                	sd	ra,8(sp)
    1390:	e022                	sd	s0,0(sp)
    1392:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1394:	582000ef          	jal	1916 <strlen>
    1398:	862a                	mv	a2,a0
    139a:	85a2                	mv	a1,s0
    139c:	4505                	li	a0,1
    139e:	15d000ef          	jal	1cfa <write>
}
    13a2:	60a2                	ld	ra,8(sp)
    13a4:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    13a6:	957d                	srai	a0,a0,0x3f
    return r;
    13a8:	2501                	sext.w	a0,a0
}
    13aa:	0141                	addi	sp,sp,16
    13ac:	8082                	ret

00000000000013ae <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    13ae:	7131                	addi	sp,sp,-192
    13b0:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    13b2:	013c                	addi	a5,sp,136
{
    13b4:	f0ca                	sd	s2,96(sp)
    13b6:	ecce                	sd	s3,88(sp)
    13b8:	e8d2                	sd	s4,80(sp)
    13ba:	e4d6                	sd	s5,72(sp)
    13bc:	e0da                	sd	s6,64(sp)
    13be:	fc5e                	sd	s7,56(sp)
    13c0:	fc86                	sd	ra,120(sp)
    13c2:	f8a2                	sd	s0,112(sp)
    13c4:	f4a6                	sd	s1,104(sp)
    13c6:	e52e                	sd	a1,136(sp)
    13c8:	e932                	sd	a2,144(sp)
    13ca:	ed36                	sd	a3,152(sp)
    13cc:	f13a                	sd	a4,160(sp)
    13ce:	f942                	sd	a6,176(sp)
    13d0:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    13d2:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    13d4:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    13d8:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    13dc:	00001b97          	auipc	s7,0x1
    13e0:	c34b8b93          	addi	s7,s7,-972 # 2010 <__clone+0xde>
        switch (s[1])
    13e4:	07800a93          	li	s5,120
    13e8:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13ec:	00001997          	auipc	s3,0x1
    13f0:	cd498993          	addi	s3,s3,-812 # 20c0 <digits>
        if (!*s)
    13f4:	00054783          	lbu	a5,0(a0)
    13f8:	16078c63          	beqz	a5,1570 <printf+0x1c2>
    13fc:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13fe:	19278463          	beq	a5,s2,1586 <printf+0x1d8>
    1402:	00164783          	lbu	a5,1(a2)
    1406:	0605                	addi	a2,a2,1
    1408:	fbfd                	bnez	a5,13fe <printf+0x50>
    140a:	84b2                	mv	s1,a2
        l = z - a;
    140c:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1410:	85aa                	mv	a1,a0
    1412:	8622                	mv	a2,s0
    1414:	4505                	li	a0,1
    1416:	0e5000ef          	jal	1cfa <write>
        if (l)
    141a:	18041f63          	bnez	s0,15b8 <printf+0x20a>
        if (s[1] == 0)
    141e:	0014c783          	lbu	a5,1(s1)
    1422:	14078763          	beqz	a5,1570 <printf+0x1c2>
        switch (s[1])
    1426:	1d478163          	beq	a5,s4,15e8 <printf+0x23a>
    142a:	18fa6963          	bltu	s4,a5,15bc <printf+0x20e>
    142e:	1b678363          	beq	a5,s6,15d4 <printf+0x226>
    1432:	07000713          	li	a4,112
    1436:	1ce79c63          	bne	a5,a4,160e <printf+0x260>
            printptr(va_arg(ap, uint64));
    143a:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    143c:	03000793          	li	a5,48
    1440:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    1444:	631c                	ld	a5,0(a4)
    1446:	0721                	addi	a4,a4,8
    1448:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    144a:	00479f93          	slli	t6,a5,0x4
    144e:	00879f13          	slli	t5,a5,0x8
    1452:	00c79e93          	slli	t4,a5,0xc
    1456:	01079e13          	slli	t3,a5,0x10
    145a:	01479313          	slli	t1,a5,0x14
    145e:	01879893          	slli	a7,a5,0x18
    1462:	01c79713          	slli	a4,a5,0x1c
    1466:	02479813          	slli	a6,a5,0x24
    146a:	02879513          	slli	a0,a5,0x28
    146e:	02c79593          	slli	a1,a5,0x2c
    1472:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1476:	03c7d293          	srli	t0,a5,0x3c
    147a:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    147e:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1482:	03cfdf93          	srli	t6,t6,0x3c
    1486:	03cf5f13          	srli	t5,t5,0x3c
    148a:	03cede93          	srli	t4,t4,0x3c
    148e:	03ce5e13          	srli	t3,t3,0x3c
    1492:	03c35313          	srli	t1,t1,0x3c
    1496:	03c8d893          	srli	a7,a7,0x3c
    149a:	9371                	srli	a4,a4,0x3c
    149c:	03c85813          	srli	a6,a6,0x3c
    14a0:	9171                	srli	a0,a0,0x3c
    14a2:	91f1                	srli	a1,a1,0x3c
    14a4:	9271                	srli	a2,a2,0x3c
    14a6:	974e                	add	a4,a4,s3
    14a8:	92f1                	srli	a3,a3,0x3c
    14aa:	92ce                	add	t0,t0,s3
    14ac:	9fce                	add	t6,t6,s3
    14ae:	9f4e                	add	t5,t5,s3
    14b0:	9ece                	add	t4,t4,s3
    14b2:	9e4e                	add	t3,t3,s3
    14b4:	934e                	add	t1,t1,s3
    14b6:	98ce                	add	a7,a7,s3
    14b8:	93ce                	add	t2,t2,s3
    14ba:	984e                	add	a6,a6,s3
    14bc:	954e                	add	a0,a0,s3
    14be:	95ce                	add	a1,a1,s3
    14c0:	964e                	add	a2,a2,s3
    14c2:	0002c283          	lbu	t0,0(t0)
    14c6:	000fcf83          	lbu	t6,0(t6)
    14ca:	000f4f03          	lbu	t5,0(t5)
    14ce:	000ece83          	lbu	t4,0(t4)
    14d2:	000e4e03          	lbu	t3,0(t3)
    14d6:	00034303          	lbu	t1,0(t1)
    14da:	0008c883          	lbu	a7,0(a7)
    14de:	00074403          	lbu	s0,0(a4)
    14e2:	0003c383          	lbu	t2,0(t2)
    14e6:	00084803          	lbu	a6,0(a6)
    14ea:	00054503          	lbu	a0,0(a0)
    14ee:	0005c583          	lbu	a1,0(a1)
    14f2:	00064603          	lbu	a2,0(a2)
    14f6:	00d98733          	add	a4,s3,a3
    14fa:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14fe:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1502:	9371                	srli	a4,a4,0x3c
    1504:	8bbd                	andi	a5,a5,15
    1506:	00510523          	sb	t0,10(sp)
    150a:	01f105a3          	sb	t6,11(sp)
    150e:	01e10623          	sb	t5,12(sp)
    1512:	01d106a3          	sb	t4,13(sp)
    1516:	01c10723          	sb	t3,14(sp)
    151a:	006107a3          	sb	t1,15(sp)
    151e:	01110823          	sb	a7,16(sp)
    1522:	00710923          	sb	t2,18(sp)
    1526:	010109a3          	sb	a6,19(sp)
    152a:	00a10a23          	sb	a0,20(sp)
    152e:	00b10aa3          	sb	a1,21(sp)
    1532:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    1536:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    153a:	008108a3          	sb	s0,17(sp)
    153e:	974e                	add	a4,a4,s3
    1540:	97ce                	add	a5,a5,s3
    1542:	00d10ba3          	sb	a3,23(sp)
    1546:	00074703          	lbu	a4,0(a4)
    154a:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    154e:	4649                	li	a2,18
    1550:	002c                	addi	a1,sp,8
    1552:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1554:	00e10c23          	sb	a4,24(sp)
    1558:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    155c:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1560:	79a000ef          	jal	1cfa <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    1564:	00248513          	addi	a0,s1,2
        if (!*s)
    1568:	00054783          	lbu	a5,0(a0)
    156c:	e80798e3          	bnez	a5,13fc <printf+0x4e>
    }
    va_end(ap);
}
    1570:	70e6                	ld	ra,120(sp)
    1572:	7446                	ld	s0,112(sp)
    1574:	74a6                	ld	s1,104(sp)
    1576:	7906                	ld	s2,96(sp)
    1578:	69e6                	ld	s3,88(sp)
    157a:	6a46                	ld	s4,80(sp)
    157c:	6aa6                	ld	s5,72(sp)
    157e:	6b06                	ld	s6,64(sp)
    1580:	7be2                	ld	s7,56(sp)
    1582:	6129                	addi	sp,sp,192
    1584:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1586:	00064783          	lbu	a5,0(a2)
    158a:	84b2                	mv	s1,a2
    158c:	01278963          	beq	a5,s2,159e <printf+0x1f0>
    1590:	bdb5                	j	140c <printf+0x5e>
    1592:	0024c783          	lbu	a5,2(s1)
    1596:	0605                	addi	a2,a2,1
    1598:	0489                	addi	s1,s1,2
    159a:	e72799e3          	bne	a5,s2,140c <printf+0x5e>
    159e:	0014c783          	lbu	a5,1(s1)
    15a2:	ff2788e3          	beq	a5,s2,1592 <printf+0x1e4>
        l = z - a;
    15a6:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    15aa:	85aa                	mv	a1,a0
    15ac:	8622                	mv	a2,s0
    15ae:	4505                	li	a0,1
    15b0:	74a000ef          	jal	1cfa <write>
        if (l)
    15b4:	e60405e3          	beqz	s0,141e <printf+0x70>
    15b8:	8526                	mv	a0,s1
    15ba:	bd2d                	j	13f4 <printf+0x46>
        switch (s[1])
    15bc:	05579963          	bne	a5,s5,160e <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    15c0:	6782                	ld	a5,0(sp)
    15c2:	45c1                	li	a1,16
    15c4:	4388                	lw	a0,0(a5)
    15c6:	07a1                	addi	a5,a5,8
    15c8:	e03e                	sd	a5,0(sp)
    15ca:	b6bff0ef          	jal	1134 <printint.constprop.0>
        s += 2;
    15ce:	00248513          	addi	a0,s1,2
    15d2:	bf59                	j	1568 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    15d4:	6782                	ld	a5,0(sp)
    15d6:	45a9                	li	a1,10
    15d8:	4388                	lw	a0,0(a5)
    15da:	07a1                	addi	a5,a5,8
    15dc:	e03e                	sd	a5,0(sp)
    15de:	b57ff0ef          	jal	1134 <printint.constprop.0>
        s += 2;
    15e2:	00248513          	addi	a0,s1,2
    15e6:	b749                	j	1568 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    15e8:	6782                	ld	a5,0(sp)
    15ea:	6380                	ld	s0,0(a5)
    15ec:	07a1                	addi	a5,a5,8
    15ee:	e03e                	sd	a5,0(sp)
    15f0:	c031                	beqz	s0,1634 <printf+0x286>
            l = strnlen(a, 200);
    15f2:	0c800593          	li	a1,200
    15f6:	8522                	mv	a0,s0
    15f8:	40a000ef          	jal	1a02 <strnlen>
    write(f, s, l);
    15fc:	0005061b          	sext.w	a2,a0
    1600:	85a2                	mv	a1,s0
    1602:	4505                	li	a0,1
    1604:	6f6000ef          	jal	1cfa <write>
        s += 2;
    1608:	00248513          	addi	a0,s1,2
    160c:	bfb1                	j	1568 <printf+0x1ba>
    return write(stdout, &byte, 1);
    160e:	4605                	li	a2,1
    1610:	002c                	addi	a1,sp,8
    1612:	4505                	li	a0,1
    char byte = c;
    1614:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    1618:	6e2000ef          	jal	1cfa <write>
    char byte = c;
    161c:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    1620:	4605                	li	a2,1
    1622:	002c                	addi	a1,sp,8
    1624:	4505                	li	a0,1
    char byte = c;
    1626:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    162a:	6d0000ef          	jal	1cfa <write>
        s += 2;
    162e:	00248513          	addi	a0,s1,2
    1632:	bf1d                	j	1568 <printf+0x1ba>
                a = "(null)";
    1634:	845e                	mv	s0,s7
    1636:	bf75                	j	15f2 <printf+0x244>

0000000000001638 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    1638:	1141                	addi	sp,sp,-16
    163a:	e406                	sd	ra,8(sp)
    puts(m);
    163c:	d51ff0ef          	jal	138c <puts>
    exit(-100);
}
    1640:	60a2                	ld	ra,8(sp)
    exit(-100);
    1642:	f9c00513          	li	a0,-100
}
    1646:	0141                	addi	sp,sp,16
    exit(-100);
    1648:	a709                	j	1d4a <exit>

000000000000164a <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    164a:	02000793          	li	a5,32
    164e:	00f50663          	beq	a0,a5,165a <isspace+0x10>
    1652:	355d                	addiw	a0,a0,-9
    1654:	00553513          	sltiu	a0,a0,5
    1658:	8082                	ret
    165a:	4505                	li	a0,1
}
    165c:	8082                	ret

000000000000165e <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    165e:	fd05051b          	addiw	a0,a0,-48
}
    1662:	00a53513          	sltiu	a0,a0,10
    1666:	8082                	ret

0000000000001668 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1668:	02000613          	li	a2,32
    166c:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    166e:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1672:	ff77069b          	addiw	a3,a4,-9
    1676:	04c70d63          	beq	a4,a2,16d0 <atoi+0x68>
    167a:	0007079b          	sext.w	a5,a4
    167e:	04d5f963          	bgeu	a1,a3,16d0 <atoi+0x68>
        s++;
    switch (*s)
    1682:	02b00693          	li	a3,43
    1686:	04d70a63          	beq	a4,a3,16da <atoi+0x72>
    168a:	02d00693          	li	a3,45
    168e:	06d70463          	beq	a4,a3,16f6 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1692:	fd07859b          	addiw	a1,a5,-48
    1696:	4625                	li	a2,9
    1698:	873e                	mv	a4,a5
    169a:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    169c:	4e01                	li	t3,0
    while (isdigit(*s))
    169e:	04b66a63          	bltu	a2,a1,16f2 <atoi+0x8a>
    int n = 0, neg = 0;
    16a2:	4501                	li	a0,0
    while (isdigit(*s))
    16a4:	4825                	li	a6,9
    16a6:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    16aa:	0025179b          	slliw	a5,a0,0x2
    16ae:	9d3d                	addw	a0,a0,a5
    16b0:	fd07031b          	addiw	t1,a4,-48
    16b4:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    16b8:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    16bc:	0685                	addi	a3,a3,1
    16be:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    16c2:	0006071b          	sext.w	a4,a2
    16c6:	feb870e3          	bgeu	a6,a1,16a6 <atoi+0x3e>
    return neg ? n : -n;
    16ca:	000e0563          	beqz	t3,16d4 <atoi+0x6c>
}
    16ce:	8082                	ret
        s++;
    16d0:	0505                	addi	a0,a0,1
    16d2:	bf71                	j	166e <atoi+0x6>
    return neg ? n : -n;
    16d4:	4113053b          	subw	a0,t1,a7
    16d8:	8082                	ret
    while (isdigit(*s))
    16da:	00154783          	lbu	a5,1(a0)
    16de:	4625                	li	a2,9
        s++;
    16e0:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16e4:	fd07859b          	addiw	a1,a5,-48
    16e8:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16ec:	4e01                	li	t3,0
    while (isdigit(*s))
    16ee:	fab67ae3          	bgeu	a2,a1,16a2 <atoi+0x3a>
    16f2:	4501                	li	a0,0
}
    16f4:	8082                	ret
    while (isdigit(*s))
    16f6:	00154783          	lbu	a5,1(a0)
    16fa:	4625                	li	a2,9
        s++;
    16fc:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1700:	fd07859b          	addiw	a1,a5,-48
    1704:	0007871b          	sext.w	a4,a5
    1708:	feb665e3          	bltu	a2,a1,16f2 <atoi+0x8a>
        neg = 1;
    170c:	4e05                	li	t3,1
    170e:	bf51                	j	16a2 <atoi+0x3a>

0000000000001710 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1710:	16060d63          	beqz	a2,188a <memset+0x17a>
    1714:	40a007b3          	neg	a5,a0
    1718:	8b9d                	andi	a5,a5,7
    171a:	00778713          	addi	a4,a5,7
    171e:	482d                	li	a6,11
    1720:	0ff5f593          	zext.b	a1,a1
    1724:	fff60693          	addi	a3,a2,-1
    1728:	17076263          	bltu	a4,a6,188c <memset+0x17c>
    172c:	16e6ea63          	bltu	a3,a4,18a0 <memset+0x190>
    1730:	16078563          	beqz	a5,189a <memset+0x18a>
    1734:	00b50023          	sb	a1,0(a0)
    1738:	4705                	li	a4,1
    173a:	00150e93          	addi	t4,a0,1
    173e:	14e78c63          	beq	a5,a4,1896 <memset+0x186>
    1742:	00b500a3          	sb	a1,1(a0)
    1746:	4709                	li	a4,2
    1748:	00250e93          	addi	t4,a0,2
    174c:	14e78d63          	beq	a5,a4,18a6 <memset+0x196>
    1750:	00b50123          	sb	a1,2(a0)
    1754:	470d                	li	a4,3
    1756:	00350e93          	addi	t4,a0,3
    175a:	12e78b63          	beq	a5,a4,1890 <memset+0x180>
    175e:	00b501a3          	sb	a1,3(a0)
    1762:	4711                	li	a4,4
    1764:	00450e93          	addi	t4,a0,4
    1768:	14e78163          	beq	a5,a4,18aa <memset+0x19a>
    176c:	00b50223          	sb	a1,4(a0)
    1770:	4715                	li	a4,5
    1772:	00550e93          	addi	t4,a0,5
    1776:	12e78c63          	beq	a5,a4,18ae <memset+0x19e>
    177a:	00b502a3          	sb	a1,5(a0)
    177e:	471d                	li	a4,7
    1780:	00650e93          	addi	t4,a0,6
    1784:	12e79763          	bne	a5,a4,18b2 <memset+0x1a2>
    1788:	00750e93          	addi	t4,a0,7
    178c:	00b50323          	sb	a1,6(a0)
    1790:	4f1d                	li	t5,7
    1792:	00859713          	slli	a4,a1,0x8
    1796:	8f4d                	or	a4,a4,a1
    1798:	01059e13          	slli	t3,a1,0x10
    179c:	01c76e33          	or	t3,a4,t3
    17a0:	01859313          	slli	t1,a1,0x18
    17a4:	006e6333          	or	t1,t3,t1
    17a8:	02059893          	slli	a7,a1,0x20
    17ac:	011368b3          	or	a7,t1,a7
    17b0:	02859813          	slli	a6,a1,0x28
    17b4:	40f60333          	sub	t1,a2,a5
    17b8:	0108e833          	or	a6,a7,a6
    17bc:	03059693          	slli	a3,a1,0x30
    17c0:	00d866b3          	or	a3,a6,a3
    17c4:	03859713          	slli	a4,a1,0x38
    17c8:	97aa                	add	a5,a5,a0
    17ca:	ff837813          	andi	a6,t1,-8
    17ce:	8f55                	or	a4,a4,a3
    17d0:	00f806b3          	add	a3,a6,a5
    17d4:	e398                	sd	a4,0(a5)
    17d6:	07a1                	addi	a5,a5,8
    17d8:	fed79ee3          	bne	a5,a3,17d4 <memset+0xc4>
    17dc:	ff837693          	andi	a3,t1,-8
    17e0:	00de87b3          	add	a5,t4,a3
    17e4:	01e6873b          	addw	a4,a3,t5
    17e8:	0ad30663          	beq	t1,a3,1894 <memset+0x184>
    17ec:	00b78023          	sb	a1,0(a5)
    17f0:	0017069b          	addiw	a3,a4,1
    17f4:	08c6fb63          	bgeu	a3,a2,188a <memset+0x17a>
    17f8:	00b780a3          	sb	a1,1(a5)
    17fc:	0027069b          	addiw	a3,a4,2
    1800:	08c6f563          	bgeu	a3,a2,188a <memset+0x17a>
    1804:	00b78123          	sb	a1,2(a5)
    1808:	0037069b          	addiw	a3,a4,3
    180c:	06c6ff63          	bgeu	a3,a2,188a <memset+0x17a>
    1810:	00b781a3          	sb	a1,3(a5)
    1814:	0047069b          	addiw	a3,a4,4
    1818:	06c6f963          	bgeu	a3,a2,188a <memset+0x17a>
    181c:	00b78223          	sb	a1,4(a5)
    1820:	0057069b          	addiw	a3,a4,5
    1824:	06c6f363          	bgeu	a3,a2,188a <memset+0x17a>
    1828:	00b782a3          	sb	a1,5(a5)
    182c:	0067069b          	addiw	a3,a4,6
    1830:	04c6fd63          	bgeu	a3,a2,188a <memset+0x17a>
    1834:	00b78323          	sb	a1,6(a5)
    1838:	0077069b          	addiw	a3,a4,7
    183c:	04c6f763          	bgeu	a3,a2,188a <memset+0x17a>
    1840:	00b783a3          	sb	a1,7(a5)
    1844:	0087069b          	addiw	a3,a4,8
    1848:	04c6f163          	bgeu	a3,a2,188a <memset+0x17a>
    184c:	00b78423          	sb	a1,8(a5)
    1850:	0097069b          	addiw	a3,a4,9
    1854:	02c6fb63          	bgeu	a3,a2,188a <memset+0x17a>
    1858:	00b784a3          	sb	a1,9(a5)
    185c:	00a7069b          	addiw	a3,a4,10
    1860:	02c6f563          	bgeu	a3,a2,188a <memset+0x17a>
    1864:	00b78523          	sb	a1,10(a5)
    1868:	00b7069b          	addiw	a3,a4,11
    186c:	00c6ff63          	bgeu	a3,a2,188a <memset+0x17a>
    1870:	00b785a3          	sb	a1,11(a5)
    1874:	00c7069b          	addiw	a3,a4,12
    1878:	00c6f963          	bgeu	a3,a2,188a <memset+0x17a>
    187c:	00b78623          	sb	a1,12(a5)
    1880:	2735                	addiw	a4,a4,13
    1882:	00c77463          	bgeu	a4,a2,188a <memset+0x17a>
    1886:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    188a:	8082                	ret
    188c:	472d                	li	a4,11
    188e:	bd79                	j	172c <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1890:	4f0d                	li	t5,3
    1892:	b701                	j	1792 <memset+0x82>
    1894:	8082                	ret
    1896:	4f05                	li	t5,1
    1898:	bded                	j	1792 <memset+0x82>
    189a:	8eaa                	mv	t4,a0
    189c:	4f01                	li	t5,0
    189e:	bdd5                	j	1792 <memset+0x82>
    18a0:	87aa                	mv	a5,a0
    18a2:	4701                	li	a4,0
    18a4:	b7a1                	j	17ec <memset+0xdc>
    18a6:	4f09                	li	t5,2
    18a8:	b5ed                	j	1792 <memset+0x82>
    18aa:	4f11                	li	t5,4
    18ac:	b5dd                	j	1792 <memset+0x82>
    18ae:	4f15                	li	t5,5
    18b0:	b5cd                	j	1792 <memset+0x82>
    18b2:	4f19                	li	t5,6
    18b4:	bdf9                	j	1792 <memset+0x82>

00000000000018b6 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    18b6:	00054783          	lbu	a5,0(a0)
    18ba:	0005c703          	lbu	a4,0(a1)
    18be:	00e79863          	bne	a5,a4,18ce <strcmp+0x18>
    18c2:	0505                	addi	a0,a0,1
    18c4:	0585                	addi	a1,a1,1
    18c6:	fbe5                	bnez	a5,18b6 <strcmp>
    18c8:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    18ca:	9d19                	subw	a0,a0,a4
    18cc:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    18ce:	0007851b          	sext.w	a0,a5
    18d2:	bfe5                	j	18ca <strcmp+0x14>

00000000000018d4 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    18d4:	ce05                	beqz	a2,190c <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18d6:	00054703          	lbu	a4,0(a0)
    18da:	0005c783          	lbu	a5,0(a1)
    18de:	cb0d                	beqz	a4,1910 <strncmp+0x3c>
    if (!n--)
    18e0:	167d                	addi	a2,a2,-1
    18e2:	00c506b3          	add	a3,a0,a2
    18e6:	a819                	j	18fc <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18e8:	00a68e63          	beq	a3,a0,1904 <strncmp+0x30>
    18ec:	0505                	addi	a0,a0,1
    18ee:	00e79b63          	bne	a5,a4,1904 <strncmp+0x30>
    18f2:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18f6:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18fa:	cb19                	beqz	a4,1910 <strncmp+0x3c>
    18fc:	0005c783          	lbu	a5,0(a1)
    1900:	0585                	addi	a1,a1,1
    1902:	f3fd                	bnez	a5,18e8 <strncmp+0x14>
    return *l - *r;
    1904:	0007051b          	sext.w	a0,a4
    1908:	9d1d                	subw	a0,a0,a5
    190a:	8082                	ret
        return 0;
    190c:	4501                	li	a0,0
}
    190e:	8082                	ret
    1910:	4501                	li	a0,0
    return *l - *r;
    1912:	9d1d                	subw	a0,a0,a5
    1914:	8082                	ret

0000000000001916 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    1916:	00757793          	andi	a5,a0,7
    191a:	cf89                	beqz	a5,1934 <strlen+0x1e>
    191c:	87aa                	mv	a5,a0
    191e:	a029                	j	1928 <strlen+0x12>
    1920:	0785                	addi	a5,a5,1
    1922:	0077f713          	andi	a4,a5,7
    1926:	cb01                	beqz	a4,1936 <strlen+0x20>
        if (!*s)
    1928:	0007c703          	lbu	a4,0(a5)
    192c:	fb75                	bnez	a4,1920 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    192e:	40a78533          	sub	a0,a5,a0
}
    1932:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1934:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    1936:	6394                	ld	a3,0(a5)
    1938:	00000597          	auipc	a1,0x0
    193c:	6e05b583          	ld	a1,1760(a1) # 2018 <__clone+0xe6>
    1940:	00000617          	auipc	a2,0x0
    1944:	6e063603          	ld	a2,1760(a2) # 2020 <__clone+0xee>
    1948:	a019                	j	194e <strlen+0x38>
    194a:	6794                	ld	a3,8(a5)
    194c:	07a1                	addi	a5,a5,8
    194e:	00b68733          	add	a4,a3,a1
    1952:	fff6c693          	not	a3,a3
    1956:	8f75                	and	a4,a4,a3
    1958:	8f71                	and	a4,a4,a2
    195a:	db65                	beqz	a4,194a <strlen+0x34>
    for (; *s; s++)
    195c:	0007c703          	lbu	a4,0(a5)
    1960:	d779                	beqz	a4,192e <strlen+0x18>
    1962:	0017c703          	lbu	a4,1(a5)
    1966:	0785                	addi	a5,a5,1
    1968:	d379                	beqz	a4,192e <strlen+0x18>
    196a:	0017c703          	lbu	a4,1(a5)
    196e:	0785                	addi	a5,a5,1
    1970:	fb6d                	bnez	a4,1962 <strlen+0x4c>
    1972:	bf75                	j	192e <strlen+0x18>

0000000000001974 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1974:	00757713          	andi	a4,a0,7
{
    1978:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    197a:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    197e:	cb19                	beqz	a4,1994 <memchr+0x20>
    1980:	ce25                	beqz	a2,19f8 <memchr+0x84>
    1982:	0007c703          	lbu	a4,0(a5)
    1986:	04b70e63          	beq	a4,a1,19e2 <memchr+0x6e>
    198a:	0785                	addi	a5,a5,1
    198c:	0077f713          	andi	a4,a5,7
    1990:	167d                	addi	a2,a2,-1
    1992:	f77d                	bnez	a4,1980 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1994:	4501                	li	a0,0
    if (n && *s != c)
    1996:	c235                	beqz	a2,19fa <memchr+0x86>
    1998:	0007c703          	lbu	a4,0(a5)
    199c:	04b70363          	beq	a4,a1,19e2 <memchr+0x6e>
        size_t k = ONES * c;
    19a0:	00000517          	auipc	a0,0x0
    19a4:	68853503          	ld	a0,1672(a0) # 2028 <__clone+0xf6>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    19a8:	471d                	li	a4,7
        size_t k = ONES * c;
    19aa:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    19ae:	02c77a63          	bgeu	a4,a2,19e2 <memchr+0x6e>
    19b2:	00000897          	auipc	a7,0x0
    19b6:	6668b883          	ld	a7,1638(a7) # 2018 <__clone+0xe6>
    19ba:	00000817          	auipc	a6,0x0
    19be:	66683803          	ld	a6,1638(a6) # 2020 <__clone+0xee>
    19c2:	431d                	li	t1,7
    19c4:	a029                	j	19ce <memchr+0x5a>
    19c6:	1661                	addi	a2,a2,-8
    19c8:	07a1                	addi	a5,a5,8
    19ca:	02c37963          	bgeu	t1,a2,19fc <memchr+0x88>
    19ce:	6398                	ld	a4,0(a5)
    19d0:	8f29                	xor	a4,a4,a0
    19d2:	011706b3          	add	a3,a4,a7
    19d6:	fff74713          	not	a4,a4
    19da:	8f75                	and	a4,a4,a3
    19dc:	01077733          	and	a4,a4,a6
    19e0:	d37d                	beqz	a4,19c6 <memchr+0x52>
    19e2:	853e                	mv	a0,a5
    19e4:	97b2                	add	a5,a5,a2
    19e6:	a021                	j	19ee <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19e8:	0505                	addi	a0,a0,1
    19ea:	00f50763          	beq	a0,a5,19f8 <memchr+0x84>
    19ee:	00054703          	lbu	a4,0(a0)
    19f2:	feb71be3          	bne	a4,a1,19e8 <memchr+0x74>
    19f6:	8082                	ret
    return n ? (void *)s : 0;
    19f8:	4501                	li	a0,0
}
    19fa:	8082                	ret
    return n ? (void *)s : 0;
    19fc:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19fe:	f275                	bnez	a2,19e2 <memchr+0x6e>
}
    1a00:	8082                	ret

0000000000001a02 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1a02:	1101                	addi	sp,sp,-32
    1a04:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1a06:	862e                	mv	a2,a1
{
    1a08:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1a0a:	4581                	li	a1,0
{
    1a0c:	e426                	sd	s1,8(sp)
    1a0e:	ec06                	sd	ra,24(sp)
    1a10:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1a12:	f63ff0ef          	jal	1974 <memchr>
    return p ? p - s : n;
    1a16:	c519                	beqz	a0,1a24 <strnlen+0x22>
}
    1a18:	60e2                	ld	ra,24(sp)
    1a1a:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1a1c:	8d05                	sub	a0,a0,s1
}
    1a1e:	64a2                	ld	s1,8(sp)
    1a20:	6105                	addi	sp,sp,32
    1a22:	8082                	ret
    1a24:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1a26:	8522                	mv	a0,s0
}
    1a28:	6442                	ld	s0,16(sp)
    1a2a:	64a2                	ld	s1,8(sp)
    1a2c:	6105                	addi	sp,sp,32
    1a2e:	8082                	ret

0000000000001a30 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    1a30:	00b547b3          	xor	a5,a0,a1
    1a34:	8b9d                	andi	a5,a5,7
    1a36:	eb95                	bnez	a5,1a6a <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    1a38:	0075f793          	andi	a5,a1,7
    1a3c:	e7b1                	bnez	a5,1a88 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a3e:	6198                	ld	a4,0(a1)
    1a40:	00000617          	auipc	a2,0x0
    1a44:	5d863603          	ld	a2,1496(a2) # 2018 <__clone+0xe6>
    1a48:	00000817          	auipc	a6,0x0
    1a4c:	5d883803          	ld	a6,1496(a6) # 2020 <__clone+0xee>
    1a50:	a029                	j	1a5a <strcpy+0x2a>
    1a52:	e118                	sd	a4,0(a0)
    1a54:	6598                	ld	a4,8(a1)
    1a56:	05a1                	addi	a1,a1,8
    1a58:	0521                	addi	a0,a0,8
    1a5a:	00c707b3          	add	a5,a4,a2
    1a5e:	fff74693          	not	a3,a4
    1a62:	8ff5                	and	a5,a5,a3
    1a64:	0107f7b3          	and	a5,a5,a6
    1a68:	d7ed                	beqz	a5,1a52 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a6a:	0005c783          	lbu	a5,0(a1)
    1a6e:	00f50023          	sb	a5,0(a0)
    1a72:	c785                	beqz	a5,1a9a <strcpy+0x6a>
    1a74:	0015c783          	lbu	a5,1(a1)
    1a78:	0505                	addi	a0,a0,1
    1a7a:	0585                	addi	a1,a1,1
    1a7c:	00f50023          	sb	a5,0(a0)
    1a80:	fbf5                	bnez	a5,1a74 <strcpy+0x44>
        ;
    return d;
}
    1a82:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a84:	0505                	addi	a0,a0,1
    1a86:	df45                	beqz	a4,1a3e <strcpy+0xe>
            if (!(*d = *s))
    1a88:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a8c:	0585                	addi	a1,a1,1
    1a8e:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a92:	00f50023          	sb	a5,0(a0)
    1a96:	f7fd                	bnez	a5,1a84 <strcpy+0x54>
}
    1a98:	8082                	ret
    1a9a:	8082                	ret

0000000000001a9c <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a9c:	00b547b3          	xor	a5,a0,a1
    1aa0:	8b9d                	andi	a5,a5,7
    1aa2:	1a079863          	bnez	a5,1c52 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1aa6:	0075f793          	andi	a5,a1,7
    1aaa:	16078463          	beqz	a5,1c12 <strncpy+0x176>
    1aae:	ea01                	bnez	a2,1abe <strncpy+0x22>
    1ab0:	a421                	j	1cb8 <strncpy+0x21c>
    1ab2:	167d                	addi	a2,a2,-1
    1ab4:	0505                	addi	a0,a0,1
    1ab6:	14070e63          	beqz	a4,1c12 <strncpy+0x176>
    1aba:	1a060863          	beqz	a2,1c6a <strncpy+0x1ce>
    1abe:	0005c783          	lbu	a5,0(a1)
    1ac2:	0585                	addi	a1,a1,1
    1ac4:	0075f713          	andi	a4,a1,7
    1ac8:	00f50023          	sb	a5,0(a0)
    1acc:	f3fd                	bnez	a5,1ab2 <strncpy+0x16>
    1ace:	4805                	li	a6,1
    1ad0:	1a061863          	bnez	a2,1c80 <strncpy+0x1e4>
    1ad4:	40a007b3          	neg	a5,a0
    1ad8:	8b9d                	andi	a5,a5,7
    1ada:	4681                	li	a3,0
    1adc:	18061a63          	bnez	a2,1c70 <strncpy+0x1d4>
    1ae0:	00778713          	addi	a4,a5,7
    1ae4:	45ad                	li	a1,11
    1ae6:	18b76363          	bltu	a4,a1,1c6c <strncpy+0x1d0>
    1aea:	1ae6eb63          	bltu	a3,a4,1ca0 <strncpy+0x204>
    1aee:	1a078363          	beqz	a5,1c94 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1af2:	00050023          	sb	zero,0(a0)
    1af6:	4685                	li	a3,1
    1af8:	00150713          	addi	a4,a0,1
    1afc:	18d78f63          	beq	a5,a3,1c9a <strncpy+0x1fe>
    1b00:	000500a3          	sb	zero,1(a0)
    1b04:	4689                	li	a3,2
    1b06:	00250713          	addi	a4,a0,2
    1b0a:	18d78e63          	beq	a5,a3,1ca6 <strncpy+0x20a>
    1b0e:	00050123          	sb	zero,2(a0)
    1b12:	468d                	li	a3,3
    1b14:	00350713          	addi	a4,a0,3
    1b18:	16d78c63          	beq	a5,a3,1c90 <strncpy+0x1f4>
    1b1c:	000501a3          	sb	zero,3(a0)
    1b20:	4691                	li	a3,4
    1b22:	00450713          	addi	a4,a0,4
    1b26:	18d78263          	beq	a5,a3,1caa <strncpy+0x20e>
    1b2a:	00050223          	sb	zero,4(a0)
    1b2e:	4695                	li	a3,5
    1b30:	00550713          	addi	a4,a0,5
    1b34:	16d78d63          	beq	a5,a3,1cae <strncpy+0x212>
    1b38:	000502a3          	sb	zero,5(a0)
    1b3c:	469d                	li	a3,7
    1b3e:	00650713          	addi	a4,a0,6
    1b42:	16d79863          	bne	a5,a3,1cb2 <strncpy+0x216>
    1b46:	00750713          	addi	a4,a0,7
    1b4a:	00050323          	sb	zero,6(a0)
    1b4e:	40f80833          	sub	a6,a6,a5
    1b52:	ff887593          	andi	a1,a6,-8
    1b56:	97aa                	add	a5,a5,a0
    1b58:	95be                	add	a1,a1,a5
    1b5a:	0007b023          	sd	zero,0(a5)
    1b5e:	07a1                	addi	a5,a5,8
    1b60:	feb79de3          	bne	a5,a1,1b5a <strncpy+0xbe>
    1b64:	ff887593          	andi	a1,a6,-8
    1b68:	9ead                	addw	a3,a3,a1
    1b6a:	00b707b3          	add	a5,a4,a1
    1b6e:	12b80863          	beq	a6,a1,1c9e <strncpy+0x202>
    1b72:	00078023          	sb	zero,0(a5)
    1b76:	0016871b          	addiw	a4,a3,1
    1b7a:	0ec77863          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1b7e:	000780a3          	sb	zero,1(a5)
    1b82:	0026871b          	addiw	a4,a3,2
    1b86:	0ec77263          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1b8a:	00078123          	sb	zero,2(a5)
    1b8e:	0036871b          	addiw	a4,a3,3
    1b92:	0cc77c63          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1b96:	000781a3          	sb	zero,3(a5)
    1b9a:	0046871b          	addiw	a4,a3,4
    1b9e:	0cc77663          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1ba2:	00078223          	sb	zero,4(a5)
    1ba6:	0056871b          	addiw	a4,a3,5
    1baa:	0cc77063          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1bae:	000782a3          	sb	zero,5(a5)
    1bb2:	0066871b          	addiw	a4,a3,6
    1bb6:	0ac77a63          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1bba:	00078323          	sb	zero,6(a5)
    1bbe:	0076871b          	addiw	a4,a3,7
    1bc2:	0ac77463          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1bc6:	000783a3          	sb	zero,7(a5)
    1bca:	0086871b          	addiw	a4,a3,8
    1bce:	08c77e63          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1bd2:	00078423          	sb	zero,8(a5)
    1bd6:	0096871b          	addiw	a4,a3,9
    1bda:	08c77863          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1bde:	000784a3          	sb	zero,9(a5)
    1be2:	00a6871b          	addiw	a4,a3,10
    1be6:	08c77263          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1bea:	00078523          	sb	zero,10(a5)
    1bee:	00b6871b          	addiw	a4,a3,11
    1bf2:	06c77c63          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1bf6:	000785a3          	sb	zero,11(a5)
    1bfa:	00c6871b          	addiw	a4,a3,12
    1bfe:	06c77663          	bgeu	a4,a2,1c6a <strncpy+0x1ce>
    1c02:	00078623          	sb	zero,12(a5)
    1c06:	26b5                	addiw	a3,a3,13
    1c08:	06c6f163          	bgeu	a3,a2,1c6a <strncpy+0x1ce>
    1c0c:	000786a3          	sb	zero,13(a5)
    1c10:	8082                	ret
            ;
        if (!n || !*s)
    1c12:	c645                	beqz	a2,1cba <strncpy+0x21e>
    1c14:	0005c783          	lbu	a5,0(a1)
    1c18:	ea078be3          	beqz	a5,1ace <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c1c:	479d                	li	a5,7
    1c1e:	02c7ff63          	bgeu	a5,a2,1c5c <strncpy+0x1c0>
    1c22:	00000897          	auipc	a7,0x0
    1c26:	3f68b883          	ld	a7,1014(a7) # 2018 <__clone+0xe6>
    1c2a:	00000817          	auipc	a6,0x0
    1c2e:	3f683803          	ld	a6,1014(a6) # 2020 <__clone+0xee>
    1c32:	431d                	li	t1,7
    1c34:	6198                	ld	a4,0(a1)
    1c36:	011707b3          	add	a5,a4,a7
    1c3a:	fff74693          	not	a3,a4
    1c3e:	8ff5                	and	a5,a5,a3
    1c40:	0107f7b3          	and	a5,a5,a6
    1c44:	ef81                	bnez	a5,1c5c <strncpy+0x1c0>
            *wd = *ws;
    1c46:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c48:	1661                	addi	a2,a2,-8
    1c4a:	05a1                	addi	a1,a1,8
    1c4c:	0521                	addi	a0,a0,8
    1c4e:	fec363e3          	bltu	t1,a2,1c34 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c52:	e609                	bnez	a2,1c5c <strncpy+0x1c0>
    1c54:	a08d                	j	1cb6 <strncpy+0x21a>
    1c56:	167d                	addi	a2,a2,-1
    1c58:	0505                	addi	a0,a0,1
    1c5a:	ca01                	beqz	a2,1c6a <strncpy+0x1ce>
    1c5c:	0005c783          	lbu	a5,0(a1)
    1c60:	0585                	addi	a1,a1,1
    1c62:	00f50023          	sb	a5,0(a0)
    1c66:	fbe5                	bnez	a5,1c56 <strncpy+0x1ba>
        ;
tail:
    1c68:	b59d                	j	1ace <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c6a:	8082                	ret
    1c6c:	472d                	li	a4,11
    1c6e:	bdb5                	j	1aea <strncpy+0x4e>
    1c70:	00778713          	addi	a4,a5,7
    1c74:	45ad                	li	a1,11
    1c76:	fff60693          	addi	a3,a2,-1
    1c7a:	e6b778e3          	bgeu	a4,a1,1aea <strncpy+0x4e>
    1c7e:	b7fd                	j	1c6c <strncpy+0x1d0>
    1c80:	40a007b3          	neg	a5,a0
    1c84:	8832                	mv	a6,a2
    1c86:	8b9d                	andi	a5,a5,7
    1c88:	4681                	li	a3,0
    1c8a:	e4060be3          	beqz	a2,1ae0 <strncpy+0x44>
    1c8e:	b7cd                	j	1c70 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c90:	468d                	li	a3,3
    1c92:	bd75                	j	1b4e <strncpy+0xb2>
    1c94:	872a                	mv	a4,a0
    1c96:	4681                	li	a3,0
    1c98:	bd5d                	j	1b4e <strncpy+0xb2>
    1c9a:	4685                	li	a3,1
    1c9c:	bd4d                	j	1b4e <strncpy+0xb2>
    1c9e:	8082                	ret
    1ca0:	87aa                	mv	a5,a0
    1ca2:	4681                	li	a3,0
    1ca4:	b5f9                	j	1b72 <strncpy+0xd6>
    1ca6:	4689                	li	a3,2
    1ca8:	b55d                	j	1b4e <strncpy+0xb2>
    1caa:	4691                	li	a3,4
    1cac:	b54d                	j	1b4e <strncpy+0xb2>
    1cae:	4695                	li	a3,5
    1cb0:	bd79                	j	1b4e <strncpy+0xb2>
    1cb2:	4699                	li	a3,6
    1cb4:	bd69                	j	1b4e <strncpy+0xb2>
    1cb6:	8082                	ret
    1cb8:	8082                	ret
    1cba:	8082                	ret

0000000000001cbc <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1cbc:	87aa                	mv	a5,a0
    1cbe:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1cc0:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1cc4:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1cc8:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1cca:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ccc:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1cd0:	2501                	sext.w	a0,a0
    1cd2:	8082                	ret

0000000000001cd4 <openat>:
    register long a7 __asm__("a7") = n;
    1cd4:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1cd8:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cdc:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1ce0:	2501                	sext.w	a0,a0
    1ce2:	8082                	ret

0000000000001ce4 <close>:
    register long a7 __asm__("a7") = n;
    1ce4:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1ce8:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cec:	2501                	sext.w	a0,a0
    1cee:	8082                	ret

0000000000001cf0 <read>:
    register long a7 __asm__("a7") = n;
    1cf0:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cf4:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cf8:	8082                	ret

0000000000001cfa <write>:
    register long a7 __asm__("a7") = n;
    1cfa:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cfe:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1d02:	8082                	ret

0000000000001d04 <getpid>:
    register long a7 __asm__("a7") = n;
    1d04:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1d08:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1d0c:	2501                	sext.w	a0,a0
    1d0e:	8082                	ret

0000000000001d10 <getppid>:
    register long a7 __asm__("a7") = n;
    1d10:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1d14:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1d18:	2501                	sext.w	a0,a0
    1d1a:	8082                	ret

0000000000001d1c <sched_yield>:
    register long a7 __asm__("a7") = n;
    1d1c:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d20:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1d24:	2501                	sext.w	a0,a0
    1d26:	8082                	ret

0000000000001d28 <fork>:
    register long a7 __asm__("a7") = n;
    1d28:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1d2c:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1d2e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d30:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1d34:	2501                	sext.w	a0,a0
    1d36:	8082                	ret

0000000000001d38 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1d38:	85b2                	mv	a1,a2
    1d3a:	863a                	mv	a2,a4
    if (stack)
    1d3c:	c191                	beqz	a1,1d40 <clone+0x8>
	stack += stack_size;
    1d3e:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d40:	4781                	li	a5,0
    1d42:	4701                	li	a4,0
    1d44:	4681                	li	a3,0
    1d46:	2601                	sext.w	a2,a2
    1d48:	a2ed                	j	1f32 <__clone>

0000000000001d4a <exit>:
    register long a7 __asm__("a7") = n;
    1d4a:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d4e:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d52:	8082                	ret

0000000000001d54 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d54:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d58:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d5a:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d5e:	2501                	sext.w	a0,a0
    1d60:	8082                	ret

0000000000001d62 <exec>:
    register long a7 __asm__("a7") = n;
    1d62:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d66:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d6a:	2501                	sext.w	a0,a0
    1d6c:	8082                	ret

0000000000001d6e <execve>:
    register long a7 __asm__("a7") = n;
    1d6e:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d72:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d76:	2501                	sext.w	a0,a0
    1d78:	8082                	ret

0000000000001d7a <times>:
    register long a7 __asm__("a7") = n;
    1d7a:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d7e:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d82:	2501                	sext.w	a0,a0
    1d84:	8082                	ret

0000000000001d86 <get_time>:

int64 get_time()
{
    1d86:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d88:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d8c:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d8e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d90:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d94:	2501                	sext.w	a0,a0
    1d96:	ed09                	bnez	a0,1db0 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d98:	67a2                	ld	a5,8(sp)
    1d9a:	3e800713          	li	a4,1000
    1d9e:	00015503          	lhu	a0,0(sp)
    1da2:	02e7d7b3          	divu	a5,a5,a4
    1da6:	02e50533          	mul	a0,a0,a4
    1daa:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1dac:	0141                	addi	sp,sp,16
    1dae:	8082                	ret
        return -1;
    1db0:	557d                	li	a0,-1
    1db2:	bfed                	j	1dac <get_time+0x26>

0000000000001db4 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1db4:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db8:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1dbc:	2501                	sext.w	a0,a0
    1dbe:	8082                	ret

0000000000001dc0 <time>:
    register long a7 __asm__("a7") = n;
    1dc0:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1dc4:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1dc8:	2501                	sext.w	a0,a0
    1dca:	8082                	ret

0000000000001dcc <sleep>:

int sleep(unsigned long long time)
{
    1dcc:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1dce:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1dd0:	850a                	mv	a0,sp
    1dd2:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1dd4:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1dd8:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dda:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dde:	e501                	bnez	a0,1de6 <sleep+0x1a>
    return 0;
    1de0:	4501                	li	a0,0
}
    1de2:	0141                	addi	sp,sp,16
    1de4:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1de6:	4502                	lw	a0,0(sp)
}
    1de8:	0141                	addi	sp,sp,16
    1dea:	8082                	ret

0000000000001dec <set_priority>:
    register long a7 __asm__("a7") = n;
    1dec:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1df0:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1df4:	2501                	sext.w	a0,a0
    1df6:	8082                	ret

0000000000001df8 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1df8:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1dfc:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1e00:	8082                	ret

0000000000001e02 <munmap>:
    register long a7 __asm__("a7") = n;
    1e02:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e06:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1e0a:	2501                	sext.w	a0,a0
    1e0c:	8082                	ret

0000000000001e0e <wait>:

int wait(int *code)
{
    1e0e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e10:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1e14:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1e16:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1e18:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1e1a:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1e1e:	2501                	sext.w	a0,a0
    1e20:	8082                	ret

0000000000001e22 <spawn>:
    register long a7 __asm__("a7") = n;
    1e22:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1e26:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1e2a:	2501                	sext.w	a0,a0
    1e2c:	8082                	ret

0000000000001e2e <mailread>:
    register long a7 __asm__("a7") = n;
    1e2e:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e32:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1e36:	2501                	sext.w	a0,a0
    1e38:	8082                	ret

0000000000001e3a <mailwrite>:
    register long a7 __asm__("a7") = n;
    1e3a:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e3e:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e42:	2501                	sext.w	a0,a0
    1e44:	8082                	ret

0000000000001e46 <fstat>:
    register long a7 __asm__("a7") = n;
    1e46:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e4a:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e4e:	2501                	sext.w	a0,a0
    1e50:	8082                	ret

0000000000001e52 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e52:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e54:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e58:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e5a:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e5e:	2501                	sext.w	a0,a0
    1e60:	8082                	ret

0000000000001e62 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e62:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e64:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e68:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e6a:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e6e:	2501                	sext.w	a0,a0
    1e70:	8082                	ret

0000000000001e72 <link>:

int link(char *old_path, char *new_path)
{
    1e72:	87aa                	mv	a5,a0
    1e74:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e76:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e7a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e7e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e80:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e84:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e86:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e8a:	2501                	sext.w	a0,a0
    1e8c:	8082                	ret

0000000000001e8e <unlink>:

int unlink(char *path)
{
    1e8e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e90:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e94:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e98:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e9a:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e9e:	2501                	sext.w	a0,a0
    1ea0:	8082                	ret

0000000000001ea2 <uname>:
    register long a7 __asm__("a7") = n;
    1ea2:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1ea6:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1eaa:	2501                	sext.w	a0,a0
    1eac:	8082                	ret

0000000000001eae <brk>:
    register long a7 __asm__("a7") = n;
    1eae:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1eb2:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1eb6:	2501                	sext.w	a0,a0
    1eb8:	8082                	ret

0000000000001eba <getcwd>:
    register long a7 __asm__("a7") = n;
    1eba:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ebc:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1ec0:	8082                	ret

0000000000001ec2 <chdir>:
    register long a7 __asm__("a7") = n;
    1ec2:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1ec6:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1eca:	2501                	sext.w	a0,a0
    1ecc:	8082                	ret

0000000000001ece <mkdir>:

int mkdir(const char *path, mode_t mode){
    1ece:	862e                	mv	a2,a1
    1ed0:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1ed2:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1ed4:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1ed8:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1edc:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1ede:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ee0:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1ee4:	2501                	sext.w	a0,a0
    1ee6:	8082                	ret

0000000000001ee8 <getdents>:
    register long a7 __asm__("a7") = n;
    1ee8:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eec:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ef0:	2501                	sext.w	a0,a0
    1ef2:	8082                	ret

0000000000001ef4 <pipe>:
    register long a7 __asm__("a7") = n;
    1ef4:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ef8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1efa:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1efe:	2501                	sext.w	a0,a0
    1f00:	8082                	ret

0000000000001f02 <dup>:
    register long a7 __asm__("a7") = n;
    1f02:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1f04:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1f08:	2501                	sext.w	a0,a0
    1f0a:	8082                	ret

0000000000001f0c <dup2>:
    register long a7 __asm__("a7") = n;
    1f0c:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1f0e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f10:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1f14:	2501                	sext.w	a0,a0
    1f16:	8082                	ret

0000000000001f18 <mount>:
    register long a7 __asm__("a7") = n;
    1f18:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1f1c:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1f20:	2501                	sext.w	a0,a0
    1f22:	8082                	ret

0000000000001f24 <umount>:
    register long a7 __asm__("a7") = n;
    1f24:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1f28:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f2a:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1f2e:	2501                	sext.w	a0,a0
    1f30:	8082                	ret

0000000000001f32 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1f32:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1f34:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1f36:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1f38:	8532                	mv	a0,a2
	mv a2, a4
    1f3a:	863a                	mv	a2,a4
	mv a3, a5
    1f3c:	86be                	mv	a3,a5
	mv a4, a6
    1f3e:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f40:	0dc00893          	li	a7,220
	ecall
    1f44:	00000073          	ecall

	beqz a0, 1f
    1f48:	c111                	beqz	a0,1f4c <__clone+0x1a>
	# Parent
	ret
    1f4a:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f4c:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f4e:	6522                	ld	a0,8(sp)
	jalr a1
    1f50:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f52:	05d00893          	li	a7,93
	ecall
    1f56:	00000073          	ecall
