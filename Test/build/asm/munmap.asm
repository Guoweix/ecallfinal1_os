
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/munmap:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	aa01                	j	1112 <__start_main>

0000000000001004 <test_munmap>:
 * "  Hello, mmap success"
 * 测试失败时输出：
 * "mmap error."
 */
static struct kstat kst;
void test_munmap(void){
    1004:	1101                	addi	sp,sp,-32
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f5250513          	addi	a0,a0,-174 # 1f58 <__clone+0x2e>
void test_munmap(void){
    100e:	ec06                	sd	ra,24(sp)
    1010:	e822                	sd	s0,16(sp)
    1012:	e426                	sd	s1,8(sp)
    TEST_START(__func__);
    1014:	370000ef          	jal	1384 <puts>
    1018:	00001517          	auipc	a0,0x1
    101c:	0b850513          	addi	a0,a0,184 # 20d0 <__func__.0>
    1020:	364000ef          	jal	1384 <puts>
    1024:	00001517          	auipc	a0,0x1
    1028:	f4c50513          	addi	a0,a0,-180 # 1f70 <__clone+0x46>
    102c:	358000ef          	jal	1384 <puts>
    char *array;
    const char *str = "  Hello, mmap successfully!";
    int fd;

    fd = open("test_mmap.txt", O_RDWR | O_CREATE);
    1030:	04200593          	li	a1,66
    1034:	00001517          	auipc	a0,0x1
    1038:	f4c50513          	addi	a0,a0,-180 # 1f80 <__clone+0x56>
    103c:	479000ef          	jal	1cb4 <open>
    1040:	842a                	mv	s0,a0
    write(fd, str, strlen(str));
    1042:	00001517          	auipc	a0,0x1
    1046:	f4e50513          	addi	a0,a0,-178 # 1f90 <__clone+0x66>
    104a:	0c5000ef          	jal	190e <strlen>
    104e:	862a                	mv	a2,a0
    1050:	00001597          	auipc	a1,0x1
    1054:	f4058593          	addi	a1,a1,-192 # 1f90 <__clone+0x66>
    1058:	8522                	mv	a0,s0
    105a:	499000ef          	jal	1cf2 <write>
    fstat(fd, &kst);
    105e:	00001497          	auipc	s1,0x1
    1062:	ff248493          	addi	s1,s1,-14 # 2050 <kst>
    1066:	85a6                	mv	a1,s1
    1068:	8522                	mv	a0,s0
    106a:	5d5000ef          	jal	1e3e <fstat>
    printf("file len: %d\n", kst.st_size);
    106e:	788c                	ld	a1,48(s1)
    1070:	00001517          	auipc	a0,0x1
    1074:	f4050513          	addi	a0,a0,-192 # 1fb0 <__clone+0x86>
    1078:	32e000ef          	jal	13a6 <printf>
    array = mmap(NULL, kst.st_size, PROT_WRITE | PROT_READ, MAP_FILE | MAP_SHARED, fd, 0);
    107c:	788c                	ld	a1,48(s1)
    107e:	4781                	li	a5,0
    1080:	8722                	mv	a4,s0
    1082:	4685                	li	a3,1
    1084:	460d                	li	a2,3
    1086:	4501                	li	a0,0
    1088:	569000ef          	jal	1df0 <mmap>
    //printf("return array: %x\n", array);

    if (array == MAP_FAILED) {
    108c:	57fd                	li	a5,-1
    108e:	06f50363          	beq	a0,a5,10f4 <test_munmap+0xf0>
	printf("mmap error.\n");
    }else{
	//printf("mmap content: %s\n", array);

    	int ret = munmap(array, kst.st_size);
    1092:	788c                	ld	a1,48(s1)
    1094:	567000ef          	jal	1dfa <munmap>
    1098:	84aa                	mv	s1,a0
	printf("munmap return: %d\n",ret);
    109a:	85aa                	mv	a1,a0
    109c:	00001517          	auipc	a0,0x1
    10a0:	f3450513          	addi	a0,a0,-204 # 1fd0 <__clone+0xa6>
    10a4:	302000ef          	jal	13a6 <printf>
	assert(ret == 0);
    10a8:	ec9d                	bnez	s1,10e6 <test_munmap+0xe2>

	if (ret == 0)
		printf("munmap successfully!\n");
    10aa:	00001517          	auipc	a0,0x1
    10ae:	f6e50513          	addi	a0,a0,-146 # 2018 <__clone+0xee>
    10b2:	2f4000ef          	jal	13a6 <printf>
    }
    close(fd);
    10b6:	8522                	mv	a0,s0
    10b8:	425000ef          	jal	1cdc <close>

    TEST_END(__func__);
    10bc:	00001517          	auipc	a0,0x1
    10c0:	f4c50513          	addi	a0,a0,-180 # 2008 <__clone+0xde>
    10c4:	2c0000ef          	jal	1384 <puts>
    10c8:	00001517          	auipc	a0,0x1
    10cc:	00850513          	addi	a0,a0,8 # 20d0 <__func__.0>
    10d0:	2b4000ef          	jal	1384 <puts>
}
    10d4:	6442                	ld	s0,16(sp)
    10d6:	60e2                	ld	ra,24(sp)
    10d8:	64a2                	ld	s1,8(sp)
    TEST_END(__func__);
    10da:	00001517          	auipc	a0,0x1
    10de:	e9650513          	addi	a0,a0,-362 # 1f70 <__clone+0x46>
}
    10e2:	6105                	addi	sp,sp,32
    TEST_END(__func__);
    10e4:	a445                	j	1384 <puts>
	assert(ret == 0);
    10e6:	00001517          	auipc	a0,0x1
    10ea:	f0250513          	addi	a0,a0,-254 # 1fe8 <__clone+0xbe>
    10ee:	542000ef          	jal	1630 <panic>
	if (ret == 0)
    10f2:	b7d1                	j	10b6 <test_munmap+0xb2>
	printf("mmap error.\n");
    10f4:	00001517          	auipc	a0,0x1
    10f8:	ecc50513          	addi	a0,a0,-308 # 1fc0 <__clone+0x96>
    10fc:	2aa000ef          	jal	13a6 <printf>
    1100:	bf5d                	j	10b6 <test_munmap+0xb2>

0000000000001102 <main>:

int main(void){
    1102:	1141                	addi	sp,sp,-16
    1104:	e406                	sd	ra,8(sp)
    test_munmap();
    1106:	effff0ef          	jal	1004 <test_munmap>
    return 0;
}
    110a:	60a2                	ld	ra,8(sp)
    110c:	4501                	li	a0,0
    110e:	0141                	addi	sp,sp,16
    1110:	8082                	ret

0000000000001112 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    1112:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    1114:	4108                	lw	a0,0(a0)
{
    1116:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1118:	05a1                	addi	a1,a1,8
{
    111a:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    111c:	fe7ff0ef          	jal	1102 <main>
    1120:	423000ef          	jal	1d42 <exit>
	return 0;
}
    1124:	60a2                	ld	ra,8(sp)
    1126:	4501                	li	a0,0
    1128:	0141                	addi	sp,sp,16
    112a:	8082                	ret

000000000000112c <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    112c:	7179                	addi	sp,sp,-48
    112e:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    1130:	12054b63          	bltz	a0,1266 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    1134:	02b577bb          	remuw	a5,a0,a1
    1138:	00001617          	auipc	a2,0x1
    113c:	fa860613          	addi	a2,a2,-88 # 20e0 <digits>
    buf[16] = 0;
    1140:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1144:	0005871b          	sext.w	a4,a1
    1148:	1782                	slli	a5,a5,0x20
    114a:	9381                	srli	a5,a5,0x20
    114c:	97b2                	add	a5,a5,a2
    114e:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1152:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1156:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    115a:	1cb56363          	bltu	a0,a1,1320 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    115e:	45b9                	li	a1,14
    1160:	02e877bb          	remuw	a5,a6,a4
    1164:	1782                	slli	a5,a5,0x20
    1166:	9381                	srli	a5,a5,0x20
    1168:	97b2                	add	a5,a5,a2
    116a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    116e:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    1172:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1176:	0ce86e63          	bltu	a6,a4,1252 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    117a:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    117e:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    1182:	1582                	slli	a1,a1,0x20
    1184:	9181                	srli	a1,a1,0x20
    1186:	95b2                	add	a1,a1,a2
    1188:	0005c583          	lbu	a1,0(a1)
    118c:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    1190:	0007859b          	sext.w	a1,a5
    1194:	12e6ec63          	bltu	a3,a4,12cc <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1198:	02e7f6bb          	remuw	a3,a5,a4
    119c:	1682                	slli	a3,a3,0x20
    119e:	9281                	srli	a3,a3,0x20
    11a0:	96b2                	add	a3,a3,a2
    11a2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11a6:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    11aa:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    11ae:	12e5e863          	bltu	a1,a4,12de <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    11b2:	02e876bb          	remuw	a3,a6,a4
    11b6:	1682                	slli	a3,a3,0x20
    11b8:	9281                	srli	a3,a3,0x20
    11ba:	96b2                	add	a3,a3,a2
    11bc:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11c0:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11c4:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    11c8:	12e86463          	bltu	a6,a4,12f0 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    11cc:	02e5f6bb          	remuw	a3,a1,a4
    11d0:	1682                	slli	a3,a3,0x20
    11d2:	9281                	srli	a3,a3,0x20
    11d4:	96b2                	add	a3,a3,a2
    11d6:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11da:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11de:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    11e2:	0ce5ec63          	bltu	a1,a4,12ba <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    11e6:	02e876bb          	remuw	a3,a6,a4
    11ea:	1682                	slli	a3,a3,0x20
    11ec:	9281                	srli	a3,a3,0x20
    11ee:	96b2                	add	a3,a3,a2
    11f0:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11f4:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11f8:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11fc:	10e86963          	bltu	a6,a4,130e <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    1200:	02e5f6bb          	remuw	a3,a1,a4
    1204:	1682                	slli	a3,a3,0x20
    1206:	9281                	srli	a3,a3,0x20
    1208:	96b2                	add	a3,a3,a2
    120a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    120e:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1212:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1216:	10e5e763          	bltu	a1,a4,1324 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    121a:	02e876bb          	remuw	a3,a6,a4
    121e:	1682                	slli	a3,a3,0x20
    1220:	9281                	srli	a3,a3,0x20
    1222:	96b2                	add	a3,a3,a2
    1224:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1228:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    122c:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    1230:	10e86363          	bltu	a6,a4,1336 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    1234:	1782                	slli	a5,a5,0x20
    1236:	9381                	srli	a5,a5,0x20
    1238:	97b2                	add	a5,a5,a2
    123a:	0007c783          	lbu	a5,0(a5)
    123e:	4599                	li	a1,6
    1240:	00f10723          	sb	a5,14(sp)

    if (sign)
    1244:	00055763          	bgez	a0,1252 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1248:	02d00793          	li	a5,45
    124c:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    1250:	4595                	li	a1,5
    write(f, s, l);
    1252:	003c                	addi	a5,sp,8
    1254:	4641                	li	a2,16
    1256:	9e0d                	subw	a2,a2,a1
    1258:	4505                	li	a0,1
    125a:	95be                	add	a1,a1,a5
    125c:	297000ef          	jal	1cf2 <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1260:	70a2                	ld	ra,40(sp)
    1262:	6145                	addi	sp,sp,48
    1264:	8082                	ret
        x = -xx;
    1266:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    126a:	02b877bb          	remuw	a5,a6,a1
    126e:	00001617          	auipc	a2,0x1
    1272:	e7260613          	addi	a2,a2,-398 # 20e0 <digits>
    buf[16] = 0;
    1276:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    127a:	0005871b          	sext.w	a4,a1
    127e:	1782                	slli	a5,a5,0x20
    1280:	9381                	srli	a5,a5,0x20
    1282:	97b2                	add	a5,a5,a2
    1284:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1288:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    128c:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1290:	06b86963          	bltu	a6,a1,1302 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1294:	02e8f7bb          	remuw	a5,a7,a4
    1298:	1782                	slli	a5,a5,0x20
    129a:	9381                	srli	a5,a5,0x20
    129c:	97b2                	add	a5,a5,a2
    129e:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    12a2:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    12a6:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    12aa:	ece8f8e3          	bgeu	a7,a4,117a <printint.constprop.0+0x4e>
        buf[i--] = '-';
    12ae:	02d00793          	li	a5,45
    12b2:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    12b6:	45b5                	li	a1,13
    12b8:	bf69                	j	1252 <printint.constprop.0+0x126>
    12ba:	45a9                	li	a1,10
    if (sign)
    12bc:	f8055be3          	bgez	a0,1252 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c0:	02d00793          	li	a5,45
    12c4:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    12c8:	45a5                	li	a1,9
    12ca:	b761                	j	1252 <printint.constprop.0+0x126>
    12cc:	45b5                	li	a1,13
    if (sign)
    12ce:	f80552e3          	bgez	a0,1252 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d2:	02d00793          	li	a5,45
    12d6:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    12da:	45b1                	li	a1,12
    12dc:	bf9d                	j	1252 <printint.constprop.0+0x126>
    12de:	45b1                	li	a1,12
    if (sign)
    12e0:	f60559e3          	bgez	a0,1252 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12e4:	02d00793          	li	a5,45
    12e8:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12ec:	45ad                	li	a1,11
    12ee:	b795                	j	1252 <printint.constprop.0+0x126>
    12f0:	45ad                	li	a1,11
    if (sign)
    12f2:	f60550e3          	bgez	a0,1252 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12f6:	02d00793          	li	a5,45
    12fa:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12fe:	45a9                	li	a1,10
    1300:	bf89                	j	1252 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1302:	02d00793          	li	a5,45
    1306:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    130a:	45b9                	li	a1,14
    130c:	b799                	j	1252 <printint.constprop.0+0x126>
    130e:	45a5                	li	a1,9
    if (sign)
    1310:	f40551e3          	bgez	a0,1252 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1314:	02d00793          	li	a5,45
    1318:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    131c:	45a1                	li	a1,8
    131e:	bf15                	j	1252 <printint.constprop.0+0x126>
    i = 15;
    1320:	45bd                	li	a1,15
    1322:	bf05                	j	1252 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1324:	45a1                	li	a1,8
    if (sign)
    1326:	f20556e3          	bgez	a0,1252 <printint.constprop.0+0x126>
        buf[i--] = '-';
    132a:	02d00793          	li	a5,45
    132e:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    1332:	459d                	li	a1,7
    1334:	bf39                	j	1252 <printint.constprop.0+0x126>
    1336:	459d                	li	a1,7
    if (sign)
    1338:	f0055de3          	bgez	a0,1252 <printint.constprop.0+0x126>
        buf[i--] = '-';
    133c:	02d00793          	li	a5,45
    1340:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    1344:	4599                	li	a1,6
    1346:	b731                	j	1252 <printint.constprop.0+0x126>

0000000000001348 <getchar>:
{
    1348:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    134a:	00f10593          	addi	a1,sp,15
    134e:	4605                	li	a2,1
    1350:	4501                	li	a0,0
{
    1352:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1354:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1358:	191000ef          	jal	1ce8 <read>
}
    135c:	60e2                	ld	ra,24(sp)
    135e:	00f14503          	lbu	a0,15(sp)
    1362:	6105                	addi	sp,sp,32
    1364:	8082                	ret

0000000000001366 <putchar>:
{
    1366:	1101                	addi	sp,sp,-32
    1368:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    136a:	00f10593          	addi	a1,sp,15
    136e:	4605                	li	a2,1
    1370:	4505                	li	a0,1
{
    1372:	ec06                	sd	ra,24(sp)
    char byte = c;
    1374:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1378:	17b000ef          	jal	1cf2 <write>
}
    137c:	60e2                	ld	ra,24(sp)
    137e:	2501                	sext.w	a0,a0
    1380:	6105                	addi	sp,sp,32
    1382:	8082                	ret

0000000000001384 <puts>:
{
    1384:	1141                	addi	sp,sp,-16
    1386:	e406                	sd	ra,8(sp)
    1388:	e022                	sd	s0,0(sp)
    138a:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    138c:	582000ef          	jal	190e <strlen>
    1390:	862a                	mv	a2,a0
    1392:	85a2                	mv	a1,s0
    1394:	4505                	li	a0,1
    1396:	15d000ef          	jal	1cf2 <write>
}
    139a:	60a2                	ld	ra,8(sp)
    139c:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    139e:	957d                	srai	a0,a0,0x3f
    return r;
    13a0:	2501                	sext.w	a0,a0
}
    13a2:	0141                	addi	sp,sp,16
    13a4:	8082                	ret

00000000000013a6 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    13a6:	7131                	addi	sp,sp,-192
    13a8:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    13aa:	013c                	addi	a5,sp,136
{
    13ac:	f0ca                	sd	s2,96(sp)
    13ae:	ecce                	sd	s3,88(sp)
    13b0:	e8d2                	sd	s4,80(sp)
    13b2:	e4d6                	sd	s5,72(sp)
    13b4:	e0da                	sd	s6,64(sp)
    13b6:	fc5e                	sd	s7,56(sp)
    13b8:	fc86                	sd	ra,120(sp)
    13ba:	f8a2                	sd	s0,112(sp)
    13bc:	f4a6                	sd	s1,104(sp)
    13be:	e52e                	sd	a1,136(sp)
    13c0:	e932                	sd	a2,144(sp)
    13c2:	ed36                	sd	a3,152(sp)
    13c4:	f13a                	sd	a4,160(sp)
    13c6:	f942                	sd	a6,176(sp)
    13c8:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    13ca:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    13cc:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    13d0:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    13d4:	00001b97          	auipc	s7,0x1
    13d8:	c5cb8b93          	addi	s7,s7,-932 # 2030 <__clone+0x106>
        switch (s[1])
    13dc:	07800a93          	li	s5,120
    13e0:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13e4:	00001997          	auipc	s3,0x1
    13e8:	cfc98993          	addi	s3,s3,-772 # 20e0 <digits>
        if (!*s)
    13ec:	00054783          	lbu	a5,0(a0)
    13f0:	16078c63          	beqz	a5,1568 <printf+0x1c2>
    13f4:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13f6:	19278463          	beq	a5,s2,157e <printf+0x1d8>
    13fa:	00164783          	lbu	a5,1(a2)
    13fe:	0605                	addi	a2,a2,1
    1400:	fbfd                	bnez	a5,13f6 <printf+0x50>
    1402:	84b2                	mv	s1,a2
        l = z - a;
    1404:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1408:	85aa                	mv	a1,a0
    140a:	8622                	mv	a2,s0
    140c:	4505                	li	a0,1
    140e:	0e5000ef          	jal	1cf2 <write>
        if (l)
    1412:	18041f63          	bnez	s0,15b0 <printf+0x20a>
        if (s[1] == 0)
    1416:	0014c783          	lbu	a5,1(s1)
    141a:	14078763          	beqz	a5,1568 <printf+0x1c2>
        switch (s[1])
    141e:	1d478163          	beq	a5,s4,15e0 <printf+0x23a>
    1422:	18fa6963          	bltu	s4,a5,15b4 <printf+0x20e>
    1426:	1b678363          	beq	a5,s6,15cc <printf+0x226>
    142a:	07000713          	li	a4,112
    142e:	1ce79c63          	bne	a5,a4,1606 <printf+0x260>
            printptr(va_arg(ap, uint64));
    1432:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    1434:	03000793          	li	a5,48
    1438:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    143c:	631c                	ld	a5,0(a4)
    143e:	0721                	addi	a4,a4,8
    1440:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1442:	00479f93          	slli	t6,a5,0x4
    1446:	00879f13          	slli	t5,a5,0x8
    144a:	00c79e93          	slli	t4,a5,0xc
    144e:	01079e13          	slli	t3,a5,0x10
    1452:	01479313          	slli	t1,a5,0x14
    1456:	01879893          	slli	a7,a5,0x18
    145a:	01c79713          	slli	a4,a5,0x1c
    145e:	02479813          	slli	a6,a5,0x24
    1462:	02879513          	slli	a0,a5,0x28
    1466:	02c79593          	slli	a1,a5,0x2c
    146a:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    146e:	03c7d293          	srli	t0,a5,0x3c
    1472:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1476:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    147a:	03cfdf93          	srli	t6,t6,0x3c
    147e:	03cf5f13          	srli	t5,t5,0x3c
    1482:	03cede93          	srli	t4,t4,0x3c
    1486:	03ce5e13          	srli	t3,t3,0x3c
    148a:	03c35313          	srli	t1,t1,0x3c
    148e:	03c8d893          	srli	a7,a7,0x3c
    1492:	9371                	srli	a4,a4,0x3c
    1494:	03c85813          	srli	a6,a6,0x3c
    1498:	9171                	srli	a0,a0,0x3c
    149a:	91f1                	srli	a1,a1,0x3c
    149c:	9271                	srli	a2,a2,0x3c
    149e:	974e                	add	a4,a4,s3
    14a0:	92f1                	srli	a3,a3,0x3c
    14a2:	92ce                	add	t0,t0,s3
    14a4:	9fce                	add	t6,t6,s3
    14a6:	9f4e                	add	t5,t5,s3
    14a8:	9ece                	add	t4,t4,s3
    14aa:	9e4e                	add	t3,t3,s3
    14ac:	934e                	add	t1,t1,s3
    14ae:	98ce                	add	a7,a7,s3
    14b0:	93ce                	add	t2,t2,s3
    14b2:	984e                	add	a6,a6,s3
    14b4:	954e                	add	a0,a0,s3
    14b6:	95ce                	add	a1,a1,s3
    14b8:	964e                	add	a2,a2,s3
    14ba:	0002c283          	lbu	t0,0(t0)
    14be:	000fcf83          	lbu	t6,0(t6)
    14c2:	000f4f03          	lbu	t5,0(t5)
    14c6:	000ece83          	lbu	t4,0(t4)
    14ca:	000e4e03          	lbu	t3,0(t3)
    14ce:	00034303          	lbu	t1,0(t1)
    14d2:	0008c883          	lbu	a7,0(a7)
    14d6:	00074403          	lbu	s0,0(a4)
    14da:	0003c383          	lbu	t2,0(t2)
    14de:	00084803          	lbu	a6,0(a6)
    14e2:	00054503          	lbu	a0,0(a0)
    14e6:	0005c583          	lbu	a1,0(a1)
    14ea:	00064603          	lbu	a2,0(a2)
    14ee:	00d98733          	add	a4,s3,a3
    14f2:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14f6:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14fa:	9371                	srli	a4,a4,0x3c
    14fc:	8bbd                	andi	a5,a5,15
    14fe:	00510523          	sb	t0,10(sp)
    1502:	01f105a3          	sb	t6,11(sp)
    1506:	01e10623          	sb	t5,12(sp)
    150a:	01d106a3          	sb	t4,13(sp)
    150e:	01c10723          	sb	t3,14(sp)
    1512:	006107a3          	sb	t1,15(sp)
    1516:	01110823          	sb	a7,16(sp)
    151a:	00710923          	sb	t2,18(sp)
    151e:	010109a3          	sb	a6,19(sp)
    1522:	00a10a23          	sb	a0,20(sp)
    1526:	00b10aa3          	sb	a1,21(sp)
    152a:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    152e:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1532:	008108a3          	sb	s0,17(sp)
    1536:	974e                	add	a4,a4,s3
    1538:	97ce                	add	a5,a5,s3
    153a:	00d10ba3          	sb	a3,23(sp)
    153e:	00074703          	lbu	a4,0(a4)
    1542:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1546:	4649                	li	a2,18
    1548:	002c                	addi	a1,sp,8
    154a:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    154c:	00e10c23          	sb	a4,24(sp)
    1550:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1554:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1558:	79a000ef          	jal	1cf2 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    155c:	00248513          	addi	a0,s1,2
        if (!*s)
    1560:	00054783          	lbu	a5,0(a0)
    1564:	e80798e3          	bnez	a5,13f4 <printf+0x4e>
    }
    va_end(ap);
}
    1568:	70e6                	ld	ra,120(sp)
    156a:	7446                	ld	s0,112(sp)
    156c:	74a6                	ld	s1,104(sp)
    156e:	7906                	ld	s2,96(sp)
    1570:	69e6                	ld	s3,88(sp)
    1572:	6a46                	ld	s4,80(sp)
    1574:	6aa6                	ld	s5,72(sp)
    1576:	6b06                	ld	s6,64(sp)
    1578:	7be2                	ld	s7,56(sp)
    157a:	6129                	addi	sp,sp,192
    157c:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    157e:	00064783          	lbu	a5,0(a2)
    1582:	84b2                	mv	s1,a2
    1584:	01278963          	beq	a5,s2,1596 <printf+0x1f0>
    1588:	bdb5                	j	1404 <printf+0x5e>
    158a:	0024c783          	lbu	a5,2(s1)
    158e:	0605                	addi	a2,a2,1
    1590:	0489                	addi	s1,s1,2
    1592:	e72799e3          	bne	a5,s2,1404 <printf+0x5e>
    1596:	0014c783          	lbu	a5,1(s1)
    159a:	ff2788e3          	beq	a5,s2,158a <printf+0x1e4>
        l = z - a;
    159e:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    15a2:	85aa                	mv	a1,a0
    15a4:	8622                	mv	a2,s0
    15a6:	4505                	li	a0,1
    15a8:	74a000ef          	jal	1cf2 <write>
        if (l)
    15ac:	e60405e3          	beqz	s0,1416 <printf+0x70>
    15b0:	8526                	mv	a0,s1
    15b2:	bd2d                	j	13ec <printf+0x46>
        switch (s[1])
    15b4:	05579963          	bne	a5,s5,1606 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    15b8:	6782                	ld	a5,0(sp)
    15ba:	45c1                	li	a1,16
    15bc:	4388                	lw	a0,0(a5)
    15be:	07a1                	addi	a5,a5,8
    15c0:	e03e                	sd	a5,0(sp)
    15c2:	b6bff0ef          	jal	112c <printint.constprop.0>
        s += 2;
    15c6:	00248513          	addi	a0,s1,2
    15ca:	bf59                	j	1560 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    15cc:	6782                	ld	a5,0(sp)
    15ce:	45a9                	li	a1,10
    15d0:	4388                	lw	a0,0(a5)
    15d2:	07a1                	addi	a5,a5,8
    15d4:	e03e                	sd	a5,0(sp)
    15d6:	b57ff0ef          	jal	112c <printint.constprop.0>
        s += 2;
    15da:	00248513          	addi	a0,s1,2
    15de:	b749                	j	1560 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    15e0:	6782                	ld	a5,0(sp)
    15e2:	6380                	ld	s0,0(a5)
    15e4:	07a1                	addi	a5,a5,8
    15e6:	e03e                	sd	a5,0(sp)
    15e8:	c031                	beqz	s0,162c <printf+0x286>
            l = strnlen(a, 200);
    15ea:	0c800593          	li	a1,200
    15ee:	8522                	mv	a0,s0
    15f0:	40a000ef          	jal	19fa <strnlen>
    write(f, s, l);
    15f4:	0005061b          	sext.w	a2,a0
    15f8:	85a2                	mv	a1,s0
    15fa:	4505                	li	a0,1
    15fc:	6f6000ef          	jal	1cf2 <write>
        s += 2;
    1600:	00248513          	addi	a0,s1,2
    1604:	bfb1                	j	1560 <printf+0x1ba>
    return write(stdout, &byte, 1);
    1606:	4605                	li	a2,1
    1608:	002c                	addi	a1,sp,8
    160a:	4505                	li	a0,1
    char byte = c;
    160c:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    1610:	6e2000ef          	jal	1cf2 <write>
    char byte = c;
    1614:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    1618:	4605                	li	a2,1
    161a:	002c                	addi	a1,sp,8
    161c:	4505                	li	a0,1
    char byte = c;
    161e:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1622:	6d0000ef          	jal	1cf2 <write>
        s += 2;
    1626:	00248513          	addi	a0,s1,2
    162a:	bf1d                	j	1560 <printf+0x1ba>
                a = "(null)";
    162c:	845e                	mv	s0,s7
    162e:	bf75                	j	15ea <printf+0x244>

0000000000001630 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    1630:	1141                	addi	sp,sp,-16
    1632:	e406                	sd	ra,8(sp)
    puts(m);
    1634:	d51ff0ef          	jal	1384 <puts>
    exit(-100);
}
    1638:	60a2                	ld	ra,8(sp)
    exit(-100);
    163a:	f9c00513          	li	a0,-100
}
    163e:	0141                	addi	sp,sp,16
    exit(-100);
    1640:	a709                	j	1d42 <exit>

0000000000001642 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1642:	02000793          	li	a5,32
    1646:	00f50663          	beq	a0,a5,1652 <isspace+0x10>
    164a:	355d                	addiw	a0,a0,-9
    164c:	00553513          	sltiu	a0,a0,5
    1650:	8082                	ret
    1652:	4505                	li	a0,1
}
    1654:	8082                	ret

0000000000001656 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1656:	fd05051b          	addiw	a0,a0,-48
}
    165a:	00a53513          	sltiu	a0,a0,10
    165e:	8082                	ret

0000000000001660 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1660:	02000613          	li	a2,32
    1664:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1666:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    166a:	ff77069b          	addiw	a3,a4,-9
    166e:	04c70d63          	beq	a4,a2,16c8 <atoi+0x68>
    1672:	0007079b          	sext.w	a5,a4
    1676:	04d5f963          	bgeu	a1,a3,16c8 <atoi+0x68>
        s++;
    switch (*s)
    167a:	02b00693          	li	a3,43
    167e:	04d70a63          	beq	a4,a3,16d2 <atoi+0x72>
    1682:	02d00693          	li	a3,45
    1686:	06d70463          	beq	a4,a3,16ee <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    168a:	fd07859b          	addiw	a1,a5,-48
    168e:	4625                	li	a2,9
    1690:	873e                	mv	a4,a5
    1692:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1694:	4e01                	li	t3,0
    while (isdigit(*s))
    1696:	04b66a63          	bltu	a2,a1,16ea <atoi+0x8a>
    int n = 0, neg = 0;
    169a:	4501                	li	a0,0
    while (isdigit(*s))
    169c:	4825                	li	a6,9
    169e:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    16a2:	0025179b          	slliw	a5,a0,0x2
    16a6:	9d3d                	addw	a0,a0,a5
    16a8:	fd07031b          	addiw	t1,a4,-48
    16ac:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    16b0:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    16b4:	0685                	addi	a3,a3,1
    16b6:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    16ba:	0006071b          	sext.w	a4,a2
    16be:	feb870e3          	bgeu	a6,a1,169e <atoi+0x3e>
    return neg ? n : -n;
    16c2:	000e0563          	beqz	t3,16cc <atoi+0x6c>
}
    16c6:	8082                	ret
        s++;
    16c8:	0505                	addi	a0,a0,1
    16ca:	bf71                	j	1666 <atoi+0x6>
    return neg ? n : -n;
    16cc:	4113053b          	subw	a0,t1,a7
    16d0:	8082                	ret
    while (isdigit(*s))
    16d2:	00154783          	lbu	a5,1(a0)
    16d6:	4625                	li	a2,9
        s++;
    16d8:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16dc:	fd07859b          	addiw	a1,a5,-48
    16e0:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16e4:	4e01                	li	t3,0
    while (isdigit(*s))
    16e6:	fab67ae3          	bgeu	a2,a1,169a <atoi+0x3a>
    16ea:	4501                	li	a0,0
}
    16ec:	8082                	ret
    while (isdigit(*s))
    16ee:	00154783          	lbu	a5,1(a0)
    16f2:	4625                	li	a2,9
        s++;
    16f4:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16f8:	fd07859b          	addiw	a1,a5,-48
    16fc:	0007871b          	sext.w	a4,a5
    1700:	feb665e3          	bltu	a2,a1,16ea <atoi+0x8a>
        neg = 1;
    1704:	4e05                	li	t3,1
    1706:	bf51                	j	169a <atoi+0x3a>

0000000000001708 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1708:	16060d63          	beqz	a2,1882 <memset+0x17a>
    170c:	40a007b3          	neg	a5,a0
    1710:	8b9d                	andi	a5,a5,7
    1712:	00778713          	addi	a4,a5,7
    1716:	482d                	li	a6,11
    1718:	0ff5f593          	zext.b	a1,a1
    171c:	fff60693          	addi	a3,a2,-1
    1720:	17076263          	bltu	a4,a6,1884 <memset+0x17c>
    1724:	16e6ea63          	bltu	a3,a4,1898 <memset+0x190>
    1728:	16078563          	beqz	a5,1892 <memset+0x18a>
    172c:	00b50023          	sb	a1,0(a0)
    1730:	4705                	li	a4,1
    1732:	00150e93          	addi	t4,a0,1
    1736:	14e78c63          	beq	a5,a4,188e <memset+0x186>
    173a:	00b500a3          	sb	a1,1(a0)
    173e:	4709                	li	a4,2
    1740:	00250e93          	addi	t4,a0,2
    1744:	14e78d63          	beq	a5,a4,189e <memset+0x196>
    1748:	00b50123          	sb	a1,2(a0)
    174c:	470d                	li	a4,3
    174e:	00350e93          	addi	t4,a0,3
    1752:	12e78b63          	beq	a5,a4,1888 <memset+0x180>
    1756:	00b501a3          	sb	a1,3(a0)
    175a:	4711                	li	a4,4
    175c:	00450e93          	addi	t4,a0,4
    1760:	14e78163          	beq	a5,a4,18a2 <memset+0x19a>
    1764:	00b50223          	sb	a1,4(a0)
    1768:	4715                	li	a4,5
    176a:	00550e93          	addi	t4,a0,5
    176e:	12e78c63          	beq	a5,a4,18a6 <memset+0x19e>
    1772:	00b502a3          	sb	a1,5(a0)
    1776:	471d                	li	a4,7
    1778:	00650e93          	addi	t4,a0,6
    177c:	12e79763          	bne	a5,a4,18aa <memset+0x1a2>
    1780:	00750e93          	addi	t4,a0,7
    1784:	00b50323          	sb	a1,6(a0)
    1788:	4f1d                	li	t5,7
    178a:	00859713          	slli	a4,a1,0x8
    178e:	8f4d                	or	a4,a4,a1
    1790:	01059e13          	slli	t3,a1,0x10
    1794:	01c76e33          	or	t3,a4,t3
    1798:	01859313          	slli	t1,a1,0x18
    179c:	006e6333          	or	t1,t3,t1
    17a0:	02059893          	slli	a7,a1,0x20
    17a4:	011368b3          	or	a7,t1,a7
    17a8:	02859813          	slli	a6,a1,0x28
    17ac:	40f60333          	sub	t1,a2,a5
    17b0:	0108e833          	or	a6,a7,a6
    17b4:	03059693          	slli	a3,a1,0x30
    17b8:	00d866b3          	or	a3,a6,a3
    17bc:	03859713          	slli	a4,a1,0x38
    17c0:	97aa                	add	a5,a5,a0
    17c2:	ff837813          	andi	a6,t1,-8
    17c6:	8f55                	or	a4,a4,a3
    17c8:	00f806b3          	add	a3,a6,a5
    17cc:	e398                	sd	a4,0(a5)
    17ce:	07a1                	addi	a5,a5,8
    17d0:	fed79ee3          	bne	a5,a3,17cc <memset+0xc4>
    17d4:	ff837693          	andi	a3,t1,-8
    17d8:	00de87b3          	add	a5,t4,a3
    17dc:	01e6873b          	addw	a4,a3,t5
    17e0:	0ad30663          	beq	t1,a3,188c <memset+0x184>
    17e4:	00b78023          	sb	a1,0(a5)
    17e8:	0017069b          	addiw	a3,a4,1
    17ec:	08c6fb63          	bgeu	a3,a2,1882 <memset+0x17a>
    17f0:	00b780a3          	sb	a1,1(a5)
    17f4:	0027069b          	addiw	a3,a4,2
    17f8:	08c6f563          	bgeu	a3,a2,1882 <memset+0x17a>
    17fc:	00b78123          	sb	a1,2(a5)
    1800:	0037069b          	addiw	a3,a4,3
    1804:	06c6ff63          	bgeu	a3,a2,1882 <memset+0x17a>
    1808:	00b781a3          	sb	a1,3(a5)
    180c:	0047069b          	addiw	a3,a4,4
    1810:	06c6f963          	bgeu	a3,a2,1882 <memset+0x17a>
    1814:	00b78223          	sb	a1,4(a5)
    1818:	0057069b          	addiw	a3,a4,5
    181c:	06c6f363          	bgeu	a3,a2,1882 <memset+0x17a>
    1820:	00b782a3          	sb	a1,5(a5)
    1824:	0067069b          	addiw	a3,a4,6
    1828:	04c6fd63          	bgeu	a3,a2,1882 <memset+0x17a>
    182c:	00b78323          	sb	a1,6(a5)
    1830:	0077069b          	addiw	a3,a4,7
    1834:	04c6f763          	bgeu	a3,a2,1882 <memset+0x17a>
    1838:	00b783a3          	sb	a1,7(a5)
    183c:	0087069b          	addiw	a3,a4,8
    1840:	04c6f163          	bgeu	a3,a2,1882 <memset+0x17a>
    1844:	00b78423          	sb	a1,8(a5)
    1848:	0097069b          	addiw	a3,a4,9
    184c:	02c6fb63          	bgeu	a3,a2,1882 <memset+0x17a>
    1850:	00b784a3          	sb	a1,9(a5)
    1854:	00a7069b          	addiw	a3,a4,10
    1858:	02c6f563          	bgeu	a3,a2,1882 <memset+0x17a>
    185c:	00b78523          	sb	a1,10(a5)
    1860:	00b7069b          	addiw	a3,a4,11
    1864:	00c6ff63          	bgeu	a3,a2,1882 <memset+0x17a>
    1868:	00b785a3          	sb	a1,11(a5)
    186c:	00c7069b          	addiw	a3,a4,12
    1870:	00c6f963          	bgeu	a3,a2,1882 <memset+0x17a>
    1874:	00b78623          	sb	a1,12(a5)
    1878:	2735                	addiw	a4,a4,13
    187a:	00c77463          	bgeu	a4,a2,1882 <memset+0x17a>
    187e:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1882:	8082                	ret
    1884:	472d                	li	a4,11
    1886:	bd79                	j	1724 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1888:	4f0d                	li	t5,3
    188a:	b701                	j	178a <memset+0x82>
    188c:	8082                	ret
    188e:	4f05                	li	t5,1
    1890:	bded                	j	178a <memset+0x82>
    1892:	8eaa                	mv	t4,a0
    1894:	4f01                	li	t5,0
    1896:	bdd5                	j	178a <memset+0x82>
    1898:	87aa                	mv	a5,a0
    189a:	4701                	li	a4,0
    189c:	b7a1                	j	17e4 <memset+0xdc>
    189e:	4f09                	li	t5,2
    18a0:	b5ed                	j	178a <memset+0x82>
    18a2:	4f11                	li	t5,4
    18a4:	b5dd                	j	178a <memset+0x82>
    18a6:	4f15                	li	t5,5
    18a8:	b5cd                	j	178a <memset+0x82>
    18aa:	4f19                	li	t5,6
    18ac:	bdf9                	j	178a <memset+0x82>

00000000000018ae <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    18ae:	00054783          	lbu	a5,0(a0)
    18b2:	0005c703          	lbu	a4,0(a1)
    18b6:	00e79863          	bne	a5,a4,18c6 <strcmp+0x18>
    18ba:	0505                	addi	a0,a0,1
    18bc:	0585                	addi	a1,a1,1
    18be:	fbe5                	bnez	a5,18ae <strcmp>
    18c0:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    18c2:	9d19                	subw	a0,a0,a4
    18c4:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    18c6:	0007851b          	sext.w	a0,a5
    18ca:	bfe5                	j	18c2 <strcmp+0x14>

00000000000018cc <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    18cc:	ce05                	beqz	a2,1904 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18ce:	00054703          	lbu	a4,0(a0)
    18d2:	0005c783          	lbu	a5,0(a1)
    18d6:	cb0d                	beqz	a4,1908 <strncmp+0x3c>
    if (!n--)
    18d8:	167d                	addi	a2,a2,-1
    18da:	00c506b3          	add	a3,a0,a2
    18de:	a819                	j	18f4 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18e0:	00a68e63          	beq	a3,a0,18fc <strncmp+0x30>
    18e4:	0505                	addi	a0,a0,1
    18e6:	00e79b63          	bne	a5,a4,18fc <strncmp+0x30>
    18ea:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18ee:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18f2:	cb19                	beqz	a4,1908 <strncmp+0x3c>
    18f4:	0005c783          	lbu	a5,0(a1)
    18f8:	0585                	addi	a1,a1,1
    18fa:	f3fd                	bnez	a5,18e0 <strncmp+0x14>
    return *l - *r;
    18fc:	0007051b          	sext.w	a0,a4
    1900:	9d1d                	subw	a0,a0,a5
    1902:	8082                	ret
        return 0;
    1904:	4501                	li	a0,0
}
    1906:	8082                	ret
    1908:	4501                	li	a0,0
    return *l - *r;
    190a:	9d1d                	subw	a0,a0,a5
    190c:	8082                	ret

000000000000190e <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    190e:	00757793          	andi	a5,a0,7
    1912:	cf89                	beqz	a5,192c <strlen+0x1e>
    1914:	87aa                	mv	a5,a0
    1916:	a029                	j	1920 <strlen+0x12>
    1918:	0785                	addi	a5,a5,1
    191a:	0077f713          	andi	a4,a5,7
    191e:	cb01                	beqz	a4,192e <strlen+0x20>
        if (!*s)
    1920:	0007c703          	lbu	a4,0(a5)
    1924:	fb75                	bnez	a4,1918 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    1926:	40a78533          	sub	a0,a5,a0
}
    192a:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    192c:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    192e:	6394                	ld	a3,0(a5)
    1930:	00000597          	auipc	a1,0x0
    1934:	7085b583          	ld	a1,1800(a1) # 2038 <__clone+0x10e>
    1938:	00000617          	auipc	a2,0x0
    193c:	70863603          	ld	a2,1800(a2) # 2040 <__clone+0x116>
    1940:	a019                	j	1946 <strlen+0x38>
    1942:	6794                	ld	a3,8(a5)
    1944:	07a1                	addi	a5,a5,8
    1946:	00b68733          	add	a4,a3,a1
    194a:	fff6c693          	not	a3,a3
    194e:	8f75                	and	a4,a4,a3
    1950:	8f71                	and	a4,a4,a2
    1952:	db65                	beqz	a4,1942 <strlen+0x34>
    for (; *s; s++)
    1954:	0007c703          	lbu	a4,0(a5)
    1958:	d779                	beqz	a4,1926 <strlen+0x18>
    195a:	0017c703          	lbu	a4,1(a5)
    195e:	0785                	addi	a5,a5,1
    1960:	d379                	beqz	a4,1926 <strlen+0x18>
    1962:	0017c703          	lbu	a4,1(a5)
    1966:	0785                	addi	a5,a5,1
    1968:	fb6d                	bnez	a4,195a <strlen+0x4c>
    196a:	bf75                	j	1926 <strlen+0x18>

000000000000196c <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    196c:	00757713          	andi	a4,a0,7
{
    1970:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1972:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1976:	cb19                	beqz	a4,198c <memchr+0x20>
    1978:	ce25                	beqz	a2,19f0 <memchr+0x84>
    197a:	0007c703          	lbu	a4,0(a5)
    197e:	04b70e63          	beq	a4,a1,19da <memchr+0x6e>
    1982:	0785                	addi	a5,a5,1
    1984:	0077f713          	andi	a4,a5,7
    1988:	167d                	addi	a2,a2,-1
    198a:	f77d                	bnez	a4,1978 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    198c:	4501                	li	a0,0
    if (n && *s != c)
    198e:	c235                	beqz	a2,19f2 <memchr+0x86>
    1990:	0007c703          	lbu	a4,0(a5)
    1994:	04b70363          	beq	a4,a1,19da <memchr+0x6e>
        size_t k = ONES * c;
    1998:	00000517          	auipc	a0,0x0
    199c:	6b053503          	ld	a0,1712(a0) # 2048 <__clone+0x11e>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    19a0:	471d                	li	a4,7
        size_t k = ONES * c;
    19a2:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    19a6:	02c77a63          	bgeu	a4,a2,19da <memchr+0x6e>
    19aa:	00000897          	auipc	a7,0x0
    19ae:	68e8b883          	ld	a7,1678(a7) # 2038 <__clone+0x10e>
    19b2:	00000817          	auipc	a6,0x0
    19b6:	68e83803          	ld	a6,1678(a6) # 2040 <__clone+0x116>
    19ba:	431d                	li	t1,7
    19bc:	a029                	j	19c6 <memchr+0x5a>
    19be:	1661                	addi	a2,a2,-8
    19c0:	07a1                	addi	a5,a5,8
    19c2:	02c37963          	bgeu	t1,a2,19f4 <memchr+0x88>
    19c6:	6398                	ld	a4,0(a5)
    19c8:	8f29                	xor	a4,a4,a0
    19ca:	011706b3          	add	a3,a4,a7
    19ce:	fff74713          	not	a4,a4
    19d2:	8f75                	and	a4,a4,a3
    19d4:	01077733          	and	a4,a4,a6
    19d8:	d37d                	beqz	a4,19be <memchr+0x52>
    19da:	853e                	mv	a0,a5
    19dc:	97b2                	add	a5,a5,a2
    19de:	a021                	j	19e6 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19e0:	0505                	addi	a0,a0,1
    19e2:	00f50763          	beq	a0,a5,19f0 <memchr+0x84>
    19e6:	00054703          	lbu	a4,0(a0)
    19ea:	feb71be3          	bne	a4,a1,19e0 <memchr+0x74>
    19ee:	8082                	ret
    return n ? (void *)s : 0;
    19f0:	4501                	li	a0,0
}
    19f2:	8082                	ret
    return n ? (void *)s : 0;
    19f4:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19f6:	f275                	bnez	a2,19da <memchr+0x6e>
}
    19f8:	8082                	ret

00000000000019fa <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19fa:	1101                	addi	sp,sp,-32
    19fc:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19fe:	862e                	mv	a2,a1
{
    1a00:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1a02:	4581                	li	a1,0
{
    1a04:	e426                	sd	s1,8(sp)
    1a06:	ec06                	sd	ra,24(sp)
    1a08:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1a0a:	f63ff0ef          	jal	196c <memchr>
    return p ? p - s : n;
    1a0e:	c519                	beqz	a0,1a1c <strnlen+0x22>
}
    1a10:	60e2                	ld	ra,24(sp)
    1a12:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1a14:	8d05                	sub	a0,a0,s1
}
    1a16:	64a2                	ld	s1,8(sp)
    1a18:	6105                	addi	sp,sp,32
    1a1a:	8082                	ret
    1a1c:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1a1e:	8522                	mv	a0,s0
}
    1a20:	6442                	ld	s0,16(sp)
    1a22:	64a2                	ld	s1,8(sp)
    1a24:	6105                	addi	sp,sp,32
    1a26:	8082                	ret

0000000000001a28 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    1a28:	00b547b3          	xor	a5,a0,a1
    1a2c:	8b9d                	andi	a5,a5,7
    1a2e:	eb95                	bnez	a5,1a62 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    1a30:	0075f793          	andi	a5,a1,7
    1a34:	e7b1                	bnez	a5,1a80 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a36:	6198                	ld	a4,0(a1)
    1a38:	00000617          	auipc	a2,0x0
    1a3c:	60063603          	ld	a2,1536(a2) # 2038 <__clone+0x10e>
    1a40:	00000817          	auipc	a6,0x0
    1a44:	60083803          	ld	a6,1536(a6) # 2040 <__clone+0x116>
    1a48:	a029                	j	1a52 <strcpy+0x2a>
    1a4a:	e118                	sd	a4,0(a0)
    1a4c:	6598                	ld	a4,8(a1)
    1a4e:	05a1                	addi	a1,a1,8
    1a50:	0521                	addi	a0,a0,8
    1a52:	00c707b3          	add	a5,a4,a2
    1a56:	fff74693          	not	a3,a4
    1a5a:	8ff5                	and	a5,a5,a3
    1a5c:	0107f7b3          	and	a5,a5,a6
    1a60:	d7ed                	beqz	a5,1a4a <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a62:	0005c783          	lbu	a5,0(a1)
    1a66:	00f50023          	sb	a5,0(a0)
    1a6a:	c785                	beqz	a5,1a92 <strcpy+0x6a>
    1a6c:	0015c783          	lbu	a5,1(a1)
    1a70:	0505                	addi	a0,a0,1
    1a72:	0585                	addi	a1,a1,1
    1a74:	00f50023          	sb	a5,0(a0)
    1a78:	fbf5                	bnez	a5,1a6c <strcpy+0x44>
        ;
    return d;
}
    1a7a:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a7c:	0505                	addi	a0,a0,1
    1a7e:	df45                	beqz	a4,1a36 <strcpy+0xe>
            if (!(*d = *s))
    1a80:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a84:	0585                	addi	a1,a1,1
    1a86:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a8a:	00f50023          	sb	a5,0(a0)
    1a8e:	f7fd                	bnez	a5,1a7c <strcpy+0x54>
}
    1a90:	8082                	ret
    1a92:	8082                	ret

0000000000001a94 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a94:	00b547b3          	xor	a5,a0,a1
    1a98:	8b9d                	andi	a5,a5,7
    1a9a:	1a079863          	bnez	a5,1c4a <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a9e:	0075f793          	andi	a5,a1,7
    1aa2:	16078463          	beqz	a5,1c0a <strncpy+0x176>
    1aa6:	ea01                	bnez	a2,1ab6 <strncpy+0x22>
    1aa8:	a421                	j	1cb0 <strncpy+0x21c>
    1aaa:	167d                	addi	a2,a2,-1
    1aac:	0505                	addi	a0,a0,1
    1aae:	14070e63          	beqz	a4,1c0a <strncpy+0x176>
    1ab2:	1a060863          	beqz	a2,1c62 <strncpy+0x1ce>
    1ab6:	0005c783          	lbu	a5,0(a1)
    1aba:	0585                	addi	a1,a1,1
    1abc:	0075f713          	andi	a4,a1,7
    1ac0:	00f50023          	sb	a5,0(a0)
    1ac4:	f3fd                	bnez	a5,1aaa <strncpy+0x16>
    1ac6:	4805                	li	a6,1
    1ac8:	1a061863          	bnez	a2,1c78 <strncpy+0x1e4>
    1acc:	40a007b3          	neg	a5,a0
    1ad0:	8b9d                	andi	a5,a5,7
    1ad2:	4681                	li	a3,0
    1ad4:	18061a63          	bnez	a2,1c68 <strncpy+0x1d4>
    1ad8:	00778713          	addi	a4,a5,7
    1adc:	45ad                	li	a1,11
    1ade:	18b76363          	bltu	a4,a1,1c64 <strncpy+0x1d0>
    1ae2:	1ae6eb63          	bltu	a3,a4,1c98 <strncpy+0x204>
    1ae6:	1a078363          	beqz	a5,1c8c <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1aea:	00050023          	sb	zero,0(a0)
    1aee:	4685                	li	a3,1
    1af0:	00150713          	addi	a4,a0,1
    1af4:	18d78f63          	beq	a5,a3,1c92 <strncpy+0x1fe>
    1af8:	000500a3          	sb	zero,1(a0)
    1afc:	4689                	li	a3,2
    1afe:	00250713          	addi	a4,a0,2
    1b02:	18d78e63          	beq	a5,a3,1c9e <strncpy+0x20a>
    1b06:	00050123          	sb	zero,2(a0)
    1b0a:	468d                	li	a3,3
    1b0c:	00350713          	addi	a4,a0,3
    1b10:	16d78c63          	beq	a5,a3,1c88 <strncpy+0x1f4>
    1b14:	000501a3          	sb	zero,3(a0)
    1b18:	4691                	li	a3,4
    1b1a:	00450713          	addi	a4,a0,4
    1b1e:	18d78263          	beq	a5,a3,1ca2 <strncpy+0x20e>
    1b22:	00050223          	sb	zero,4(a0)
    1b26:	4695                	li	a3,5
    1b28:	00550713          	addi	a4,a0,5
    1b2c:	16d78d63          	beq	a5,a3,1ca6 <strncpy+0x212>
    1b30:	000502a3          	sb	zero,5(a0)
    1b34:	469d                	li	a3,7
    1b36:	00650713          	addi	a4,a0,6
    1b3a:	16d79863          	bne	a5,a3,1caa <strncpy+0x216>
    1b3e:	00750713          	addi	a4,a0,7
    1b42:	00050323          	sb	zero,6(a0)
    1b46:	40f80833          	sub	a6,a6,a5
    1b4a:	ff887593          	andi	a1,a6,-8
    1b4e:	97aa                	add	a5,a5,a0
    1b50:	95be                	add	a1,a1,a5
    1b52:	0007b023          	sd	zero,0(a5)
    1b56:	07a1                	addi	a5,a5,8
    1b58:	feb79de3          	bne	a5,a1,1b52 <strncpy+0xbe>
    1b5c:	ff887593          	andi	a1,a6,-8
    1b60:	9ead                	addw	a3,a3,a1
    1b62:	00b707b3          	add	a5,a4,a1
    1b66:	12b80863          	beq	a6,a1,1c96 <strncpy+0x202>
    1b6a:	00078023          	sb	zero,0(a5)
    1b6e:	0016871b          	addiw	a4,a3,1
    1b72:	0ec77863          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1b76:	000780a3          	sb	zero,1(a5)
    1b7a:	0026871b          	addiw	a4,a3,2
    1b7e:	0ec77263          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1b82:	00078123          	sb	zero,2(a5)
    1b86:	0036871b          	addiw	a4,a3,3
    1b8a:	0cc77c63          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1b8e:	000781a3          	sb	zero,3(a5)
    1b92:	0046871b          	addiw	a4,a3,4
    1b96:	0cc77663          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1b9a:	00078223          	sb	zero,4(a5)
    1b9e:	0056871b          	addiw	a4,a3,5
    1ba2:	0cc77063          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1ba6:	000782a3          	sb	zero,5(a5)
    1baa:	0066871b          	addiw	a4,a3,6
    1bae:	0ac77a63          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1bb2:	00078323          	sb	zero,6(a5)
    1bb6:	0076871b          	addiw	a4,a3,7
    1bba:	0ac77463          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1bbe:	000783a3          	sb	zero,7(a5)
    1bc2:	0086871b          	addiw	a4,a3,8
    1bc6:	08c77e63          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1bca:	00078423          	sb	zero,8(a5)
    1bce:	0096871b          	addiw	a4,a3,9
    1bd2:	08c77863          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1bd6:	000784a3          	sb	zero,9(a5)
    1bda:	00a6871b          	addiw	a4,a3,10
    1bde:	08c77263          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1be2:	00078523          	sb	zero,10(a5)
    1be6:	00b6871b          	addiw	a4,a3,11
    1bea:	06c77c63          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1bee:	000785a3          	sb	zero,11(a5)
    1bf2:	00c6871b          	addiw	a4,a3,12
    1bf6:	06c77663          	bgeu	a4,a2,1c62 <strncpy+0x1ce>
    1bfa:	00078623          	sb	zero,12(a5)
    1bfe:	26b5                	addiw	a3,a3,13
    1c00:	06c6f163          	bgeu	a3,a2,1c62 <strncpy+0x1ce>
    1c04:	000786a3          	sb	zero,13(a5)
    1c08:	8082                	ret
            ;
        if (!n || !*s)
    1c0a:	c645                	beqz	a2,1cb2 <strncpy+0x21e>
    1c0c:	0005c783          	lbu	a5,0(a1)
    1c10:	ea078be3          	beqz	a5,1ac6 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c14:	479d                	li	a5,7
    1c16:	02c7ff63          	bgeu	a5,a2,1c54 <strncpy+0x1c0>
    1c1a:	00000897          	auipc	a7,0x0
    1c1e:	41e8b883          	ld	a7,1054(a7) # 2038 <__clone+0x10e>
    1c22:	00000817          	auipc	a6,0x0
    1c26:	41e83803          	ld	a6,1054(a6) # 2040 <__clone+0x116>
    1c2a:	431d                	li	t1,7
    1c2c:	6198                	ld	a4,0(a1)
    1c2e:	011707b3          	add	a5,a4,a7
    1c32:	fff74693          	not	a3,a4
    1c36:	8ff5                	and	a5,a5,a3
    1c38:	0107f7b3          	and	a5,a5,a6
    1c3c:	ef81                	bnez	a5,1c54 <strncpy+0x1c0>
            *wd = *ws;
    1c3e:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c40:	1661                	addi	a2,a2,-8
    1c42:	05a1                	addi	a1,a1,8
    1c44:	0521                	addi	a0,a0,8
    1c46:	fec363e3          	bltu	t1,a2,1c2c <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c4a:	e609                	bnez	a2,1c54 <strncpy+0x1c0>
    1c4c:	a08d                	j	1cae <strncpy+0x21a>
    1c4e:	167d                	addi	a2,a2,-1
    1c50:	0505                	addi	a0,a0,1
    1c52:	ca01                	beqz	a2,1c62 <strncpy+0x1ce>
    1c54:	0005c783          	lbu	a5,0(a1)
    1c58:	0585                	addi	a1,a1,1
    1c5a:	00f50023          	sb	a5,0(a0)
    1c5e:	fbe5                	bnez	a5,1c4e <strncpy+0x1ba>
        ;
tail:
    1c60:	b59d                	j	1ac6 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c62:	8082                	ret
    1c64:	472d                	li	a4,11
    1c66:	bdb5                	j	1ae2 <strncpy+0x4e>
    1c68:	00778713          	addi	a4,a5,7
    1c6c:	45ad                	li	a1,11
    1c6e:	fff60693          	addi	a3,a2,-1
    1c72:	e6b778e3          	bgeu	a4,a1,1ae2 <strncpy+0x4e>
    1c76:	b7fd                	j	1c64 <strncpy+0x1d0>
    1c78:	40a007b3          	neg	a5,a0
    1c7c:	8832                	mv	a6,a2
    1c7e:	8b9d                	andi	a5,a5,7
    1c80:	4681                	li	a3,0
    1c82:	e4060be3          	beqz	a2,1ad8 <strncpy+0x44>
    1c86:	b7cd                	j	1c68 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c88:	468d                	li	a3,3
    1c8a:	bd75                	j	1b46 <strncpy+0xb2>
    1c8c:	872a                	mv	a4,a0
    1c8e:	4681                	li	a3,0
    1c90:	bd5d                	j	1b46 <strncpy+0xb2>
    1c92:	4685                	li	a3,1
    1c94:	bd4d                	j	1b46 <strncpy+0xb2>
    1c96:	8082                	ret
    1c98:	87aa                	mv	a5,a0
    1c9a:	4681                	li	a3,0
    1c9c:	b5f9                	j	1b6a <strncpy+0xd6>
    1c9e:	4689                	li	a3,2
    1ca0:	b55d                	j	1b46 <strncpy+0xb2>
    1ca2:	4691                	li	a3,4
    1ca4:	b54d                	j	1b46 <strncpy+0xb2>
    1ca6:	4695                	li	a3,5
    1ca8:	bd79                	j	1b46 <strncpy+0xb2>
    1caa:	4699                	li	a3,6
    1cac:	bd69                	j	1b46 <strncpy+0xb2>
    1cae:	8082                	ret
    1cb0:	8082                	ret
    1cb2:	8082                	ret

0000000000001cb4 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1cb4:	87aa                	mv	a5,a0
    1cb6:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1cb8:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1cbc:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1cc0:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1cc2:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cc4:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1cc8:	2501                	sext.w	a0,a0
    1cca:	8082                	ret

0000000000001ccc <openat>:
    register long a7 __asm__("a7") = n;
    1ccc:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1cd0:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cd4:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1cd8:	2501                	sext.w	a0,a0
    1cda:	8082                	ret

0000000000001cdc <close>:
    register long a7 __asm__("a7") = n;
    1cdc:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1ce0:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1ce4:	2501                	sext.w	a0,a0
    1ce6:	8082                	ret

0000000000001ce8 <read>:
    register long a7 __asm__("a7") = n;
    1ce8:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cec:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cf0:	8082                	ret

0000000000001cf2 <write>:
    register long a7 __asm__("a7") = n;
    1cf2:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cf6:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cfa:	8082                	ret

0000000000001cfc <getpid>:
    register long a7 __asm__("a7") = n;
    1cfc:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1d00:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1d04:	2501                	sext.w	a0,a0
    1d06:	8082                	ret

0000000000001d08 <getppid>:
    register long a7 __asm__("a7") = n;
    1d08:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1d0c:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1d10:	2501                	sext.w	a0,a0
    1d12:	8082                	ret

0000000000001d14 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1d14:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d18:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1d1c:	2501                	sext.w	a0,a0
    1d1e:	8082                	ret

0000000000001d20 <fork>:
    register long a7 __asm__("a7") = n;
    1d20:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1d24:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1d26:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d28:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1d2c:	2501                	sext.w	a0,a0
    1d2e:	8082                	ret

0000000000001d30 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1d30:	85b2                	mv	a1,a2
    1d32:	863a                	mv	a2,a4
    if (stack)
    1d34:	c191                	beqz	a1,1d38 <clone+0x8>
	stack += stack_size;
    1d36:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d38:	4781                	li	a5,0
    1d3a:	4701                	li	a4,0
    1d3c:	4681                	li	a3,0
    1d3e:	2601                	sext.w	a2,a2
    1d40:	a2ed                	j	1f2a <__clone>

0000000000001d42 <exit>:
    register long a7 __asm__("a7") = n;
    1d42:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d46:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d4a:	8082                	ret

0000000000001d4c <waitpid>:
    register long a7 __asm__("a7") = n;
    1d4c:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d50:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d52:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d56:	2501                	sext.w	a0,a0
    1d58:	8082                	ret

0000000000001d5a <exec>:
    register long a7 __asm__("a7") = n;
    1d5a:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d5e:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d62:	2501                	sext.w	a0,a0
    1d64:	8082                	ret

0000000000001d66 <execve>:
    register long a7 __asm__("a7") = n;
    1d66:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d6a:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d6e:	2501                	sext.w	a0,a0
    1d70:	8082                	ret

0000000000001d72 <times>:
    register long a7 __asm__("a7") = n;
    1d72:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d76:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d7a:	2501                	sext.w	a0,a0
    1d7c:	8082                	ret

0000000000001d7e <get_time>:

int64 get_time()
{
    1d7e:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d80:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d84:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d86:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d88:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d8c:	2501                	sext.w	a0,a0
    1d8e:	ed09                	bnez	a0,1da8 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d90:	67a2                	ld	a5,8(sp)
    1d92:	3e800713          	li	a4,1000
    1d96:	00015503          	lhu	a0,0(sp)
    1d9a:	02e7d7b3          	divu	a5,a5,a4
    1d9e:	02e50533          	mul	a0,a0,a4
    1da2:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1da4:	0141                	addi	sp,sp,16
    1da6:	8082                	ret
        return -1;
    1da8:	557d                	li	a0,-1
    1daa:	bfed                	j	1da4 <get_time+0x26>

0000000000001dac <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1dac:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db0:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1db4:	2501                	sext.w	a0,a0
    1db6:	8082                	ret

0000000000001db8 <time>:
    register long a7 __asm__("a7") = n;
    1db8:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1dbc:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1dc0:	2501                	sext.w	a0,a0
    1dc2:	8082                	ret

0000000000001dc4 <sleep>:

int sleep(unsigned long long time)
{
    1dc4:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1dc6:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1dc8:	850a                	mv	a0,sp
    1dca:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1dcc:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1dd0:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd2:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dd6:	e501                	bnez	a0,1dde <sleep+0x1a>
    return 0;
    1dd8:	4501                	li	a0,0
}
    1dda:	0141                	addi	sp,sp,16
    1ddc:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dde:	4502                	lw	a0,0(sp)
}
    1de0:	0141                	addi	sp,sp,16
    1de2:	8082                	ret

0000000000001de4 <set_priority>:
    register long a7 __asm__("a7") = n;
    1de4:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1de8:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1dec:	2501                	sext.w	a0,a0
    1dee:	8082                	ret

0000000000001df0 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1df0:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1df4:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1df8:	8082                	ret

0000000000001dfa <munmap>:
    register long a7 __asm__("a7") = n;
    1dfa:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dfe:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1e02:	2501                	sext.w	a0,a0
    1e04:	8082                	ret

0000000000001e06 <wait>:

int wait(int *code)
{
    1e06:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e08:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1e0c:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1e0e:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1e10:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1e12:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1e16:	2501                	sext.w	a0,a0
    1e18:	8082                	ret

0000000000001e1a <spawn>:
    register long a7 __asm__("a7") = n;
    1e1a:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1e1e:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1e22:	2501                	sext.w	a0,a0
    1e24:	8082                	ret

0000000000001e26 <mailread>:
    register long a7 __asm__("a7") = n;
    1e26:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e2a:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1e2e:	2501                	sext.w	a0,a0
    1e30:	8082                	ret

0000000000001e32 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1e32:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e36:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e3a:	2501                	sext.w	a0,a0
    1e3c:	8082                	ret

0000000000001e3e <fstat>:
    register long a7 __asm__("a7") = n;
    1e3e:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e42:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e46:	2501                	sext.w	a0,a0
    1e48:	8082                	ret

0000000000001e4a <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e4a:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e4c:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e50:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e52:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e56:	2501                	sext.w	a0,a0
    1e58:	8082                	ret

0000000000001e5a <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e5a:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e5c:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e60:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e62:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e66:	2501                	sext.w	a0,a0
    1e68:	8082                	ret

0000000000001e6a <link>:

int link(char *old_path, char *new_path)
{
    1e6a:	87aa                	mv	a5,a0
    1e6c:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e6e:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e72:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e76:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e78:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e7c:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e7e:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e82:	2501                	sext.w	a0,a0
    1e84:	8082                	ret

0000000000001e86 <unlink>:

int unlink(char *path)
{
    1e86:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e88:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e8c:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e90:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e92:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e96:	2501                	sext.w	a0,a0
    1e98:	8082                	ret

0000000000001e9a <uname>:
    register long a7 __asm__("a7") = n;
    1e9a:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e9e:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1ea2:	2501                	sext.w	a0,a0
    1ea4:	8082                	ret

0000000000001ea6 <brk>:
    register long a7 __asm__("a7") = n;
    1ea6:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1eaa:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1eae:	2501                	sext.w	a0,a0
    1eb0:	8082                	ret

0000000000001eb2 <getcwd>:
    register long a7 __asm__("a7") = n;
    1eb2:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eb4:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1eb8:	8082                	ret

0000000000001eba <chdir>:
    register long a7 __asm__("a7") = n;
    1eba:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1ebe:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1ec2:	2501                	sext.w	a0,a0
    1ec4:	8082                	ret

0000000000001ec6 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1ec6:	862e                	mv	a2,a1
    1ec8:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1eca:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1ecc:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1ed0:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1ed4:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1ed6:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ed8:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1edc:	2501                	sext.w	a0,a0
    1ede:	8082                	ret

0000000000001ee0 <getdents>:
    register long a7 __asm__("a7") = n;
    1ee0:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ee4:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ee8:	2501                	sext.w	a0,a0
    1eea:	8082                	ret

0000000000001eec <pipe>:
    register long a7 __asm__("a7") = n;
    1eec:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ef0:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ef2:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1ef6:	2501                	sext.w	a0,a0
    1ef8:	8082                	ret

0000000000001efa <dup>:
    register long a7 __asm__("a7") = n;
    1efa:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1efc:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1f00:	2501                	sext.w	a0,a0
    1f02:	8082                	ret

0000000000001f04 <dup2>:
    register long a7 __asm__("a7") = n;
    1f04:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1f06:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f08:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1f0c:	2501                	sext.w	a0,a0
    1f0e:	8082                	ret

0000000000001f10 <mount>:
    register long a7 __asm__("a7") = n;
    1f10:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1f14:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1f18:	2501                	sext.w	a0,a0
    1f1a:	8082                	ret

0000000000001f1c <umount>:
    register long a7 __asm__("a7") = n;
    1f1c:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1f20:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f22:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1f26:	2501                	sext.w	a0,a0
    1f28:	8082                	ret

0000000000001f2a <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1f2a:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1f2c:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1f2e:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1f30:	8532                	mv	a0,a2
	mv a2, a4
    1f32:	863a                	mv	a2,a4
	mv a3, a5
    1f34:	86be                	mv	a3,a5
	mv a4, a6
    1f36:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f38:	0dc00893          	li	a7,220
	ecall
    1f3c:	00000073          	ecall

	beqz a0, 1f
    1f40:	c111                	beqz	a0,1f44 <__clone+0x1a>
	# Parent
	ret
    1f42:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f44:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f46:	6522                	ld	a0,8(sp)
	jalr a1
    1f48:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f4a:	05d00893          	li	a7,93
	ecall
    1f4e:	00000073          	ecall
