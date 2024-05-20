
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/mmap:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a201                	j	1102 <__start_main>

0000000000001004 <test_mmap>:
 * "  Hello, mmap success"
 * 测试失败时输出：
 * "mmap error."
 */
static struct kstat kst;
void test_mmap(void){
    1004:	1101                	addi	sp,sp,-32
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f2a50513          	addi	a0,a0,-214 # 1f30 <__clone+0x28>
void test_mmap(void){
    100e:	ec06                	sd	ra,24(sp)
    1010:	e822                	sd	s0,16(sp)
    1012:	e04a                	sd	s2,0(sp)
    1014:	e426                	sd	s1,8(sp)
    TEST_START(__func__);
    1016:	35e000ef          	jal	1374 <puts>
    101a:	00001517          	auipc	a0,0x1
    101e:	05650513          	addi	a0,a0,86 # 2070 <__func__.0>
    1022:	352000ef          	jal	1374 <puts>
    1026:	00001517          	auipc	a0,0x1
    102a:	f2250513          	addi	a0,a0,-222 # 1f48 <__clone+0x40>
    102e:	346000ef          	jal	1374 <puts>
    char *array;
    const char *str = "  Hello, mmap successfully!";
    int fd;

    fd = open("test_mmap.txt", O_RDWR | O_CREATE);
    1032:	04200593          	li	a1,66
    1036:	00001517          	auipc	a0,0x1
    103a:	f2250513          	addi	a0,a0,-222 # 1f58 <__clone+0x50>
    103e:	455000ef          	jal	1c92 <open>
    1042:	842a                	mv	s0,a0
    write(fd, str, strlen(str));
    1044:	00001517          	auipc	a0,0x1
    1048:	f2450513          	addi	a0,a0,-220 # 1f68 <__clone+0x60>
    104c:	0a1000ef          	jal	18ec <strlen>
    1050:	862a                	mv	a2,a0
    1052:	00001597          	auipc	a1,0x1
    1056:	f1658593          	addi	a1,a1,-234 # 1f68 <__clone+0x60>
    105a:	8522                	mv	a0,s0
    105c:	475000ef          	jal	1cd0 <write>
    fstat(fd, &kst);
    1060:	00001917          	auipc	s2,0x1
    1064:	f9090913          	addi	s2,s2,-112 # 1ff0 <kst>
    1068:	85ca                	mv	a1,s2
    106a:	8522                	mv	a0,s0
    106c:	5b1000ef          	jal	1e1c <fstat>
    printf("file len: %d\n", kst.st_size);
    1070:	03093583          	ld	a1,48(s2)
    1074:	00001517          	auipc	a0,0x1
    1078:	f1450513          	addi	a0,a0,-236 # 1f88 <__clone+0x80>
    107c:	31a000ef          	jal	1396 <printf>
    array = mmap(NULL, kst.st_size, PROT_WRITE | PROT_READ, MAP_FILE | MAP_SHARED, fd, 0);
    1080:	03093583          	ld	a1,48(s2)
    1084:	4781                	li	a5,0
    1086:	8722                	mv	a4,s0
    1088:	4685                	li	a3,1
    108a:	460d                	li	a2,3
    108c:	4501                	li	a0,0
    108e:	541000ef          	jal	1dce <mmap>
    //printf("return array: %x\n", array);

    if (array == MAP_FAILED) {
    1092:	57fd                	li	a5,-1
    1094:	04f50863          	beq	a0,a5,10e4 <test_mmap+0xe0>
	printf("mmap error.\n");
    }else{
	printf("mmap content: %s\n", array);
    1098:	85aa                	mv	a1,a0
    109a:	84aa                	mv	s1,a0
    109c:	00001517          	auipc	a0,0x1
    10a0:	f0c50513          	addi	a0,a0,-244 # 1fa8 <__clone+0xa0>
    10a4:	2f2000ef          	jal	1396 <printf>
	//printf("%s\n", str);

	munmap(array, kst.st_size);
    10a8:	03093583          	ld	a1,48(s2)
    10ac:	8526                	mv	a0,s1
    10ae:	52b000ef          	jal	1dd8 <munmap>
    }

    close(fd);
    10b2:	8522                	mv	a0,s0
    10b4:	407000ef          	jal	1cba <close>

    TEST_END(__func__);
    10b8:	00001517          	auipc	a0,0x1
    10bc:	f0850513          	addi	a0,a0,-248 # 1fc0 <__clone+0xb8>
    10c0:	2b4000ef          	jal	1374 <puts>
    10c4:	00001517          	auipc	a0,0x1
    10c8:	fac50513          	addi	a0,a0,-84 # 2070 <__func__.0>
    10cc:	2a8000ef          	jal	1374 <puts>
}
    10d0:	6442                	ld	s0,16(sp)
    10d2:	60e2                	ld	ra,24(sp)
    10d4:	64a2                	ld	s1,8(sp)
    10d6:	6902                	ld	s2,0(sp)
    TEST_END(__func__);
    10d8:	00001517          	auipc	a0,0x1
    10dc:	e7050513          	addi	a0,a0,-400 # 1f48 <__clone+0x40>
}
    10e0:	6105                	addi	sp,sp,32
    TEST_END(__func__);
    10e2:	ac49                	j	1374 <puts>
	printf("mmap error.\n");
    10e4:	00001517          	auipc	a0,0x1
    10e8:	eb450513          	addi	a0,a0,-332 # 1f98 <__clone+0x90>
    10ec:	2aa000ef          	jal	1396 <printf>
    10f0:	b7c9                	j	10b2 <test_mmap+0xae>

00000000000010f2 <main>:

int main(void){
    10f2:	1141                	addi	sp,sp,-16
    10f4:	e406                	sd	ra,8(sp)
    test_mmap();
    10f6:	f0fff0ef          	jal	1004 <test_mmap>
    return 0;
}
    10fa:	60a2                	ld	ra,8(sp)
    10fc:	4501                	li	a0,0
    10fe:	0141                	addi	sp,sp,16
    1100:	8082                	ret

0000000000001102 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    1102:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    1104:	4108                	lw	a0,0(a0)
{
    1106:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1108:	05a1                	addi	a1,a1,8
{
    110a:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    110c:	fe7ff0ef          	jal	10f2 <main>
    1110:	411000ef          	jal	1d20 <exit>
	return 0;
}
    1114:	60a2                	ld	ra,8(sp)
    1116:	4501                	li	a0,0
    1118:	0141                	addi	sp,sp,16
    111a:	8082                	ret

000000000000111c <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    111c:	7179                	addi	sp,sp,-48
    111e:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    1120:	12054b63          	bltz	a0,1256 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    1124:	02b577bb          	remuw	a5,a0,a1
    1128:	00001617          	auipc	a2,0x1
    112c:	f5860613          	addi	a2,a2,-168 # 2080 <digits>
    buf[16] = 0;
    1130:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1134:	0005871b          	sext.w	a4,a1
    1138:	1782                	slli	a5,a5,0x20
    113a:	9381                	srli	a5,a5,0x20
    113c:	97b2                	add	a5,a5,a2
    113e:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1142:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1146:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    114a:	1cb56363          	bltu	a0,a1,1310 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    114e:	45b9                	li	a1,14
    1150:	02e877bb          	remuw	a5,a6,a4
    1154:	1782                	slli	a5,a5,0x20
    1156:	9381                	srli	a5,a5,0x20
    1158:	97b2                	add	a5,a5,a2
    115a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    115e:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    1162:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1166:	0ce86e63          	bltu	a6,a4,1242 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    116a:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    116e:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    1172:	1582                	slli	a1,a1,0x20
    1174:	9181                	srli	a1,a1,0x20
    1176:	95b2                	add	a1,a1,a2
    1178:	0005c583          	lbu	a1,0(a1)
    117c:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    1180:	0007859b          	sext.w	a1,a5
    1184:	12e6ec63          	bltu	a3,a4,12bc <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1188:	02e7f6bb          	remuw	a3,a5,a4
    118c:	1682                	slli	a3,a3,0x20
    118e:	9281                	srli	a3,a3,0x20
    1190:	96b2                	add	a3,a3,a2
    1192:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1196:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    119a:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    119e:	12e5e863          	bltu	a1,a4,12ce <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    11a2:	02e876bb          	remuw	a3,a6,a4
    11a6:	1682                	slli	a3,a3,0x20
    11a8:	9281                	srli	a3,a3,0x20
    11aa:	96b2                	add	a3,a3,a2
    11ac:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11b0:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11b4:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    11b8:	12e86463          	bltu	a6,a4,12e0 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    11bc:	02e5f6bb          	remuw	a3,a1,a4
    11c0:	1682                	slli	a3,a3,0x20
    11c2:	9281                	srli	a3,a3,0x20
    11c4:	96b2                	add	a3,a3,a2
    11c6:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11ca:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11ce:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    11d2:	0ce5ec63          	bltu	a1,a4,12aa <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    11d6:	02e876bb          	remuw	a3,a6,a4
    11da:	1682                	slli	a3,a3,0x20
    11dc:	9281                	srli	a3,a3,0x20
    11de:	96b2                	add	a3,a3,a2
    11e0:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11e4:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11e8:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11ec:	10e86963          	bltu	a6,a4,12fe <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11f0:	02e5f6bb          	remuw	a3,a1,a4
    11f4:	1682                	slli	a3,a3,0x20
    11f6:	9281                	srli	a3,a3,0x20
    11f8:	96b2                	add	a3,a3,a2
    11fa:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11fe:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1202:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1206:	10e5e763          	bltu	a1,a4,1314 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    120a:	02e876bb          	remuw	a3,a6,a4
    120e:	1682                	slli	a3,a3,0x20
    1210:	9281                	srli	a3,a3,0x20
    1212:	96b2                	add	a3,a3,a2
    1214:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1218:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    121c:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    1220:	10e86363          	bltu	a6,a4,1326 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    1224:	1782                	slli	a5,a5,0x20
    1226:	9381                	srli	a5,a5,0x20
    1228:	97b2                	add	a5,a5,a2
    122a:	0007c783          	lbu	a5,0(a5)
    122e:	4599                	li	a1,6
    1230:	00f10723          	sb	a5,14(sp)

    if (sign)
    1234:	00055763          	bgez	a0,1242 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1238:	02d00793          	li	a5,45
    123c:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    1240:	4595                	li	a1,5
    write(f, s, l);
    1242:	003c                	addi	a5,sp,8
    1244:	4641                	li	a2,16
    1246:	9e0d                	subw	a2,a2,a1
    1248:	4505                	li	a0,1
    124a:	95be                	add	a1,a1,a5
    124c:	285000ef          	jal	1cd0 <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1250:	70a2                	ld	ra,40(sp)
    1252:	6145                	addi	sp,sp,48
    1254:	8082                	ret
        x = -xx;
    1256:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    125a:	02b877bb          	remuw	a5,a6,a1
    125e:	00001617          	auipc	a2,0x1
    1262:	e2260613          	addi	a2,a2,-478 # 2080 <digits>
    buf[16] = 0;
    1266:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    126a:	0005871b          	sext.w	a4,a1
    126e:	1782                	slli	a5,a5,0x20
    1270:	9381                	srli	a5,a5,0x20
    1272:	97b2                	add	a5,a5,a2
    1274:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1278:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    127c:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1280:	06b86963          	bltu	a6,a1,12f2 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1284:	02e8f7bb          	remuw	a5,a7,a4
    1288:	1782                	slli	a5,a5,0x20
    128a:	9381                	srli	a5,a5,0x20
    128c:	97b2                	add	a5,a5,a2
    128e:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1292:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1296:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    129a:	ece8f8e3          	bgeu	a7,a4,116a <printint.constprop.0+0x4e>
        buf[i--] = '-';
    129e:	02d00793          	li	a5,45
    12a2:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    12a6:	45b5                	li	a1,13
    12a8:	bf69                	j	1242 <printint.constprop.0+0x126>
    12aa:	45a9                	li	a1,10
    if (sign)
    12ac:	f8055be3          	bgez	a0,1242 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b0:	02d00793          	li	a5,45
    12b4:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    12b8:	45a5                	li	a1,9
    12ba:	b761                	j	1242 <printint.constprop.0+0x126>
    12bc:	45b5                	li	a1,13
    if (sign)
    12be:	f80552e3          	bgez	a0,1242 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c2:	02d00793          	li	a5,45
    12c6:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    12ca:	45b1                	li	a1,12
    12cc:	bf9d                	j	1242 <printint.constprop.0+0x126>
    12ce:	45b1                	li	a1,12
    if (sign)
    12d0:	f60559e3          	bgez	a0,1242 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d4:	02d00793          	li	a5,45
    12d8:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12dc:	45ad                	li	a1,11
    12de:	b795                	j	1242 <printint.constprop.0+0x126>
    12e0:	45ad                	li	a1,11
    if (sign)
    12e2:	f60550e3          	bgez	a0,1242 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12e6:	02d00793          	li	a5,45
    12ea:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12ee:	45a9                	li	a1,10
    12f0:	bf89                	j	1242 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12f2:	02d00793          	li	a5,45
    12f6:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12fa:	45b9                	li	a1,14
    12fc:	b799                	j	1242 <printint.constprop.0+0x126>
    12fe:	45a5                	li	a1,9
    if (sign)
    1300:	f40551e3          	bgez	a0,1242 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1304:	02d00793          	li	a5,45
    1308:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    130c:	45a1                	li	a1,8
    130e:	bf15                	j	1242 <printint.constprop.0+0x126>
    i = 15;
    1310:	45bd                	li	a1,15
    1312:	bf05                	j	1242 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1314:	45a1                	li	a1,8
    if (sign)
    1316:	f20556e3          	bgez	a0,1242 <printint.constprop.0+0x126>
        buf[i--] = '-';
    131a:	02d00793          	li	a5,45
    131e:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    1322:	459d                	li	a1,7
    1324:	bf39                	j	1242 <printint.constprop.0+0x126>
    1326:	459d                	li	a1,7
    if (sign)
    1328:	f0055de3          	bgez	a0,1242 <printint.constprop.0+0x126>
        buf[i--] = '-';
    132c:	02d00793          	li	a5,45
    1330:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    1334:	4599                	li	a1,6
    1336:	b731                	j	1242 <printint.constprop.0+0x126>

0000000000001338 <getchar>:
{
    1338:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    133a:	00f10593          	addi	a1,sp,15
    133e:	4605                	li	a2,1
    1340:	4501                	li	a0,0
{
    1342:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1344:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1348:	17f000ef          	jal	1cc6 <read>
}
    134c:	60e2                	ld	ra,24(sp)
    134e:	00f14503          	lbu	a0,15(sp)
    1352:	6105                	addi	sp,sp,32
    1354:	8082                	ret

0000000000001356 <putchar>:
{
    1356:	1101                	addi	sp,sp,-32
    1358:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    135a:	00f10593          	addi	a1,sp,15
    135e:	4605                	li	a2,1
    1360:	4505                	li	a0,1
{
    1362:	ec06                	sd	ra,24(sp)
    char byte = c;
    1364:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1368:	169000ef          	jal	1cd0 <write>
}
    136c:	60e2                	ld	ra,24(sp)
    136e:	2501                	sext.w	a0,a0
    1370:	6105                	addi	sp,sp,32
    1372:	8082                	ret

0000000000001374 <puts>:
{
    1374:	1141                	addi	sp,sp,-16
    1376:	e406                	sd	ra,8(sp)
    1378:	e022                	sd	s0,0(sp)
    137a:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    137c:	570000ef          	jal	18ec <strlen>
    1380:	862a                	mv	a2,a0
    1382:	85a2                	mv	a1,s0
    1384:	4505                	li	a0,1
    1386:	14b000ef          	jal	1cd0 <write>
}
    138a:	60a2                	ld	ra,8(sp)
    138c:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    138e:	957d                	srai	a0,a0,0x3f
    return r;
    1390:	2501                	sext.w	a0,a0
}
    1392:	0141                	addi	sp,sp,16
    1394:	8082                	ret

0000000000001396 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1396:	7131                	addi	sp,sp,-192
    1398:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    139a:	013c                	addi	a5,sp,136
{
    139c:	f0ca                	sd	s2,96(sp)
    139e:	ecce                	sd	s3,88(sp)
    13a0:	e8d2                	sd	s4,80(sp)
    13a2:	e4d6                	sd	s5,72(sp)
    13a4:	e0da                	sd	s6,64(sp)
    13a6:	fc5e                	sd	s7,56(sp)
    13a8:	fc86                	sd	ra,120(sp)
    13aa:	f8a2                	sd	s0,112(sp)
    13ac:	f4a6                	sd	s1,104(sp)
    13ae:	e52e                	sd	a1,136(sp)
    13b0:	e932                	sd	a2,144(sp)
    13b2:	ed36                	sd	a3,152(sp)
    13b4:	f13a                	sd	a4,160(sp)
    13b6:	f942                	sd	a6,176(sp)
    13b8:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    13ba:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    13bc:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    13c0:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    13c4:	00001b97          	auipc	s7,0x1
    13c8:	c0cb8b93          	addi	s7,s7,-1012 # 1fd0 <__clone+0xc8>
        switch (s[1])
    13cc:	07800a93          	li	s5,120
    13d0:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13d4:	00001997          	auipc	s3,0x1
    13d8:	cac98993          	addi	s3,s3,-852 # 2080 <digits>
        if (!*s)
    13dc:	00054783          	lbu	a5,0(a0)
    13e0:	16078c63          	beqz	a5,1558 <printf+0x1c2>
    13e4:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13e6:	19278463          	beq	a5,s2,156e <printf+0x1d8>
    13ea:	00164783          	lbu	a5,1(a2)
    13ee:	0605                	addi	a2,a2,1
    13f0:	fbfd                	bnez	a5,13e6 <printf+0x50>
    13f2:	84b2                	mv	s1,a2
        l = z - a;
    13f4:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13f8:	85aa                	mv	a1,a0
    13fa:	8622                	mv	a2,s0
    13fc:	4505                	li	a0,1
    13fe:	0d3000ef          	jal	1cd0 <write>
        if (l)
    1402:	18041f63          	bnez	s0,15a0 <printf+0x20a>
        if (s[1] == 0)
    1406:	0014c783          	lbu	a5,1(s1)
    140a:	14078763          	beqz	a5,1558 <printf+0x1c2>
        switch (s[1])
    140e:	1d478163          	beq	a5,s4,15d0 <printf+0x23a>
    1412:	18fa6963          	bltu	s4,a5,15a4 <printf+0x20e>
    1416:	1b678363          	beq	a5,s6,15bc <printf+0x226>
    141a:	07000713          	li	a4,112
    141e:	1ce79c63          	bne	a5,a4,15f6 <printf+0x260>
            printptr(va_arg(ap, uint64));
    1422:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    1424:	03000793          	li	a5,48
    1428:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    142c:	631c                	ld	a5,0(a4)
    142e:	0721                	addi	a4,a4,8
    1430:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1432:	00479f93          	slli	t6,a5,0x4
    1436:	00879f13          	slli	t5,a5,0x8
    143a:	00c79e93          	slli	t4,a5,0xc
    143e:	01079e13          	slli	t3,a5,0x10
    1442:	01479313          	slli	t1,a5,0x14
    1446:	01879893          	slli	a7,a5,0x18
    144a:	01c79713          	slli	a4,a5,0x1c
    144e:	02479813          	slli	a6,a5,0x24
    1452:	02879513          	slli	a0,a5,0x28
    1456:	02c79593          	slli	a1,a5,0x2c
    145a:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    145e:	03c7d293          	srli	t0,a5,0x3c
    1462:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1466:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    146a:	03cfdf93          	srli	t6,t6,0x3c
    146e:	03cf5f13          	srli	t5,t5,0x3c
    1472:	03cede93          	srli	t4,t4,0x3c
    1476:	03ce5e13          	srli	t3,t3,0x3c
    147a:	03c35313          	srli	t1,t1,0x3c
    147e:	03c8d893          	srli	a7,a7,0x3c
    1482:	9371                	srli	a4,a4,0x3c
    1484:	03c85813          	srli	a6,a6,0x3c
    1488:	9171                	srli	a0,a0,0x3c
    148a:	91f1                	srli	a1,a1,0x3c
    148c:	9271                	srli	a2,a2,0x3c
    148e:	974e                	add	a4,a4,s3
    1490:	92f1                	srli	a3,a3,0x3c
    1492:	92ce                	add	t0,t0,s3
    1494:	9fce                	add	t6,t6,s3
    1496:	9f4e                	add	t5,t5,s3
    1498:	9ece                	add	t4,t4,s3
    149a:	9e4e                	add	t3,t3,s3
    149c:	934e                	add	t1,t1,s3
    149e:	98ce                	add	a7,a7,s3
    14a0:	93ce                	add	t2,t2,s3
    14a2:	984e                	add	a6,a6,s3
    14a4:	954e                	add	a0,a0,s3
    14a6:	95ce                	add	a1,a1,s3
    14a8:	964e                	add	a2,a2,s3
    14aa:	0002c283          	lbu	t0,0(t0)
    14ae:	000fcf83          	lbu	t6,0(t6)
    14b2:	000f4f03          	lbu	t5,0(t5)
    14b6:	000ece83          	lbu	t4,0(t4)
    14ba:	000e4e03          	lbu	t3,0(t3)
    14be:	00034303          	lbu	t1,0(t1)
    14c2:	0008c883          	lbu	a7,0(a7)
    14c6:	00074403          	lbu	s0,0(a4)
    14ca:	0003c383          	lbu	t2,0(t2)
    14ce:	00084803          	lbu	a6,0(a6)
    14d2:	00054503          	lbu	a0,0(a0)
    14d6:	0005c583          	lbu	a1,0(a1)
    14da:	00064603          	lbu	a2,0(a2)
    14de:	00d98733          	add	a4,s3,a3
    14e2:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14e6:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ea:	9371                	srli	a4,a4,0x3c
    14ec:	8bbd                	andi	a5,a5,15
    14ee:	00510523          	sb	t0,10(sp)
    14f2:	01f105a3          	sb	t6,11(sp)
    14f6:	01e10623          	sb	t5,12(sp)
    14fa:	01d106a3          	sb	t4,13(sp)
    14fe:	01c10723          	sb	t3,14(sp)
    1502:	006107a3          	sb	t1,15(sp)
    1506:	01110823          	sb	a7,16(sp)
    150a:	00710923          	sb	t2,18(sp)
    150e:	010109a3          	sb	a6,19(sp)
    1512:	00a10a23          	sb	a0,20(sp)
    1516:	00b10aa3          	sb	a1,21(sp)
    151a:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    151e:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1522:	008108a3          	sb	s0,17(sp)
    1526:	974e                	add	a4,a4,s3
    1528:	97ce                	add	a5,a5,s3
    152a:	00d10ba3          	sb	a3,23(sp)
    152e:	00074703          	lbu	a4,0(a4)
    1532:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1536:	4649                	li	a2,18
    1538:	002c                	addi	a1,sp,8
    153a:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    153c:	00e10c23          	sb	a4,24(sp)
    1540:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1544:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1548:	788000ef          	jal	1cd0 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    154c:	00248513          	addi	a0,s1,2
        if (!*s)
    1550:	00054783          	lbu	a5,0(a0)
    1554:	e80798e3          	bnez	a5,13e4 <printf+0x4e>
    }
    va_end(ap);
}
    1558:	70e6                	ld	ra,120(sp)
    155a:	7446                	ld	s0,112(sp)
    155c:	74a6                	ld	s1,104(sp)
    155e:	7906                	ld	s2,96(sp)
    1560:	69e6                	ld	s3,88(sp)
    1562:	6a46                	ld	s4,80(sp)
    1564:	6aa6                	ld	s5,72(sp)
    1566:	6b06                	ld	s6,64(sp)
    1568:	7be2                	ld	s7,56(sp)
    156a:	6129                	addi	sp,sp,192
    156c:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    156e:	00064783          	lbu	a5,0(a2)
    1572:	84b2                	mv	s1,a2
    1574:	01278963          	beq	a5,s2,1586 <printf+0x1f0>
    1578:	bdb5                	j	13f4 <printf+0x5e>
    157a:	0024c783          	lbu	a5,2(s1)
    157e:	0605                	addi	a2,a2,1
    1580:	0489                	addi	s1,s1,2
    1582:	e72799e3          	bne	a5,s2,13f4 <printf+0x5e>
    1586:	0014c783          	lbu	a5,1(s1)
    158a:	ff2788e3          	beq	a5,s2,157a <printf+0x1e4>
        l = z - a;
    158e:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1592:	85aa                	mv	a1,a0
    1594:	8622                	mv	a2,s0
    1596:	4505                	li	a0,1
    1598:	738000ef          	jal	1cd0 <write>
        if (l)
    159c:	e60405e3          	beqz	s0,1406 <printf+0x70>
    15a0:	8526                	mv	a0,s1
    15a2:	bd2d                	j	13dc <printf+0x46>
        switch (s[1])
    15a4:	05579963          	bne	a5,s5,15f6 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    15a8:	6782                	ld	a5,0(sp)
    15aa:	45c1                	li	a1,16
    15ac:	4388                	lw	a0,0(a5)
    15ae:	07a1                	addi	a5,a5,8
    15b0:	e03e                	sd	a5,0(sp)
    15b2:	b6bff0ef          	jal	111c <printint.constprop.0>
        s += 2;
    15b6:	00248513          	addi	a0,s1,2
    15ba:	bf59                	j	1550 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    15bc:	6782                	ld	a5,0(sp)
    15be:	45a9                	li	a1,10
    15c0:	4388                	lw	a0,0(a5)
    15c2:	07a1                	addi	a5,a5,8
    15c4:	e03e                	sd	a5,0(sp)
    15c6:	b57ff0ef          	jal	111c <printint.constprop.0>
        s += 2;
    15ca:	00248513          	addi	a0,s1,2
    15ce:	b749                	j	1550 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    15d0:	6782                	ld	a5,0(sp)
    15d2:	6380                	ld	s0,0(a5)
    15d4:	07a1                	addi	a5,a5,8
    15d6:	e03e                	sd	a5,0(sp)
    15d8:	c031                	beqz	s0,161c <printf+0x286>
            l = strnlen(a, 200);
    15da:	0c800593          	li	a1,200
    15de:	8522                	mv	a0,s0
    15e0:	3f8000ef          	jal	19d8 <strnlen>
    write(f, s, l);
    15e4:	0005061b          	sext.w	a2,a0
    15e8:	85a2                	mv	a1,s0
    15ea:	4505                	li	a0,1
    15ec:	6e4000ef          	jal	1cd0 <write>
        s += 2;
    15f0:	00248513          	addi	a0,s1,2
    15f4:	bfb1                	j	1550 <printf+0x1ba>
    return write(stdout, &byte, 1);
    15f6:	4605                	li	a2,1
    15f8:	002c                	addi	a1,sp,8
    15fa:	4505                	li	a0,1
    char byte = c;
    15fc:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    1600:	6d0000ef          	jal	1cd0 <write>
    char byte = c;
    1604:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    1608:	4605                	li	a2,1
    160a:	002c                	addi	a1,sp,8
    160c:	4505                	li	a0,1
    char byte = c;
    160e:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1612:	6be000ef          	jal	1cd0 <write>
        s += 2;
    1616:	00248513          	addi	a0,s1,2
    161a:	bf1d                	j	1550 <printf+0x1ba>
                a = "(null)";
    161c:	845e                	mv	s0,s7
    161e:	bf75                	j	15da <printf+0x244>

0000000000001620 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1620:	02000793          	li	a5,32
    1624:	00f50663          	beq	a0,a5,1630 <isspace+0x10>
    1628:	355d                	addiw	a0,a0,-9
    162a:	00553513          	sltiu	a0,a0,5
    162e:	8082                	ret
    1630:	4505                	li	a0,1
}
    1632:	8082                	ret

0000000000001634 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1634:	fd05051b          	addiw	a0,a0,-48
}
    1638:	00a53513          	sltiu	a0,a0,10
    163c:	8082                	ret

000000000000163e <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    163e:	02000613          	li	a2,32
    1642:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1644:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1648:	ff77069b          	addiw	a3,a4,-9
    164c:	04c70d63          	beq	a4,a2,16a6 <atoi+0x68>
    1650:	0007079b          	sext.w	a5,a4
    1654:	04d5f963          	bgeu	a1,a3,16a6 <atoi+0x68>
        s++;
    switch (*s)
    1658:	02b00693          	li	a3,43
    165c:	04d70a63          	beq	a4,a3,16b0 <atoi+0x72>
    1660:	02d00693          	li	a3,45
    1664:	06d70463          	beq	a4,a3,16cc <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1668:	fd07859b          	addiw	a1,a5,-48
    166c:	4625                	li	a2,9
    166e:	873e                	mv	a4,a5
    1670:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1672:	4e01                	li	t3,0
    while (isdigit(*s))
    1674:	04b66a63          	bltu	a2,a1,16c8 <atoi+0x8a>
    int n = 0, neg = 0;
    1678:	4501                	li	a0,0
    while (isdigit(*s))
    167a:	4825                	li	a6,9
    167c:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1680:	0025179b          	slliw	a5,a0,0x2
    1684:	9d3d                	addw	a0,a0,a5
    1686:	fd07031b          	addiw	t1,a4,-48
    168a:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    168e:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1692:	0685                	addi	a3,a3,1
    1694:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1698:	0006071b          	sext.w	a4,a2
    169c:	feb870e3          	bgeu	a6,a1,167c <atoi+0x3e>
    return neg ? n : -n;
    16a0:	000e0563          	beqz	t3,16aa <atoi+0x6c>
}
    16a4:	8082                	ret
        s++;
    16a6:	0505                	addi	a0,a0,1
    16a8:	bf71                	j	1644 <atoi+0x6>
    return neg ? n : -n;
    16aa:	4113053b          	subw	a0,t1,a7
    16ae:	8082                	ret
    while (isdigit(*s))
    16b0:	00154783          	lbu	a5,1(a0)
    16b4:	4625                	li	a2,9
        s++;
    16b6:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16ba:	fd07859b          	addiw	a1,a5,-48
    16be:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16c2:	4e01                	li	t3,0
    while (isdigit(*s))
    16c4:	fab67ae3          	bgeu	a2,a1,1678 <atoi+0x3a>
    16c8:	4501                	li	a0,0
}
    16ca:	8082                	ret
    while (isdigit(*s))
    16cc:	00154783          	lbu	a5,1(a0)
    16d0:	4625                	li	a2,9
        s++;
    16d2:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16d6:	fd07859b          	addiw	a1,a5,-48
    16da:	0007871b          	sext.w	a4,a5
    16de:	feb665e3          	bltu	a2,a1,16c8 <atoi+0x8a>
        neg = 1;
    16e2:	4e05                	li	t3,1
    16e4:	bf51                	j	1678 <atoi+0x3a>

00000000000016e6 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16e6:	16060d63          	beqz	a2,1860 <memset+0x17a>
    16ea:	40a007b3          	neg	a5,a0
    16ee:	8b9d                	andi	a5,a5,7
    16f0:	00778713          	addi	a4,a5,7
    16f4:	482d                	li	a6,11
    16f6:	0ff5f593          	zext.b	a1,a1
    16fa:	fff60693          	addi	a3,a2,-1
    16fe:	17076263          	bltu	a4,a6,1862 <memset+0x17c>
    1702:	16e6ea63          	bltu	a3,a4,1876 <memset+0x190>
    1706:	16078563          	beqz	a5,1870 <memset+0x18a>
    170a:	00b50023          	sb	a1,0(a0)
    170e:	4705                	li	a4,1
    1710:	00150e93          	addi	t4,a0,1
    1714:	14e78c63          	beq	a5,a4,186c <memset+0x186>
    1718:	00b500a3          	sb	a1,1(a0)
    171c:	4709                	li	a4,2
    171e:	00250e93          	addi	t4,a0,2
    1722:	14e78d63          	beq	a5,a4,187c <memset+0x196>
    1726:	00b50123          	sb	a1,2(a0)
    172a:	470d                	li	a4,3
    172c:	00350e93          	addi	t4,a0,3
    1730:	12e78b63          	beq	a5,a4,1866 <memset+0x180>
    1734:	00b501a3          	sb	a1,3(a0)
    1738:	4711                	li	a4,4
    173a:	00450e93          	addi	t4,a0,4
    173e:	14e78163          	beq	a5,a4,1880 <memset+0x19a>
    1742:	00b50223          	sb	a1,4(a0)
    1746:	4715                	li	a4,5
    1748:	00550e93          	addi	t4,a0,5
    174c:	12e78c63          	beq	a5,a4,1884 <memset+0x19e>
    1750:	00b502a3          	sb	a1,5(a0)
    1754:	471d                	li	a4,7
    1756:	00650e93          	addi	t4,a0,6
    175a:	12e79763          	bne	a5,a4,1888 <memset+0x1a2>
    175e:	00750e93          	addi	t4,a0,7
    1762:	00b50323          	sb	a1,6(a0)
    1766:	4f1d                	li	t5,7
    1768:	00859713          	slli	a4,a1,0x8
    176c:	8f4d                	or	a4,a4,a1
    176e:	01059e13          	slli	t3,a1,0x10
    1772:	01c76e33          	or	t3,a4,t3
    1776:	01859313          	slli	t1,a1,0x18
    177a:	006e6333          	or	t1,t3,t1
    177e:	02059893          	slli	a7,a1,0x20
    1782:	011368b3          	or	a7,t1,a7
    1786:	02859813          	slli	a6,a1,0x28
    178a:	40f60333          	sub	t1,a2,a5
    178e:	0108e833          	or	a6,a7,a6
    1792:	03059693          	slli	a3,a1,0x30
    1796:	00d866b3          	or	a3,a6,a3
    179a:	03859713          	slli	a4,a1,0x38
    179e:	97aa                	add	a5,a5,a0
    17a0:	ff837813          	andi	a6,t1,-8
    17a4:	8f55                	or	a4,a4,a3
    17a6:	00f806b3          	add	a3,a6,a5
    17aa:	e398                	sd	a4,0(a5)
    17ac:	07a1                	addi	a5,a5,8
    17ae:	fed79ee3          	bne	a5,a3,17aa <memset+0xc4>
    17b2:	ff837693          	andi	a3,t1,-8
    17b6:	00de87b3          	add	a5,t4,a3
    17ba:	01e6873b          	addw	a4,a3,t5
    17be:	0ad30663          	beq	t1,a3,186a <memset+0x184>
    17c2:	00b78023          	sb	a1,0(a5)
    17c6:	0017069b          	addiw	a3,a4,1
    17ca:	08c6fb63          	bgeu	a3,a2,1860 <memset+0x17a>
    17ce:	00b780a3          	sb	a1,1(a5)
    17d2:	0027069b          	addiw	a3,a4,2
    17d6:	08c6f563          	bgeu	a3,a2,1860 <memset+0x17a>
    17da:	00b78123          	sb	a1,2(a5)
    17de:	0037069b          	addiw	a3,a4,3
    17e2:	06c6ff63          	bgeu	a3,a2,1860 <memset+0x17a>
    17e6:	00b781a3          	sb	a1,3(a5)
    17ea:	0047069b          	addiw	a3,a4,4
    17ee:	06c6f963          	bgeu	a3,a2,1860 <memset+0x17a>
    17f2:	00b78223          	sb	a1,4(a5)
    17f6:	0057069b          	addiw	a3,a4,5
    17fa:	06c6f363          	bgeu	a3,a2,1860 <memset+0x17a>
    17fe:	00b782a3          	sb	a1,5(a5)
    1802:	0067069b          	addiw	a3,a4,6
    1806:	04c6fd63          	bgeu	a3,a2,1860 <memset+0x17a>
    180a:	00b78323          	sb	a1,6(a5)
    180e:	0077069b          	addiw	a3,a4,7
    1812:	04c6f763          	bgeu	a3,a2,1860 <memset+0x17a>
    1816:	00b783a3          	sb	a1,7(a5)
    181a:	0087069b          	addiw	a3,a4,8
    181e:	04c6f163          	bgeu	a3,a2,1860 <memset+0x17a>
    1822:	00b78423          	sb	a1,8(a5)
    1826:	0097069b          	addiw	a3,a4,9
    182a:	02c6fb63          	bgeu	a3,a2,1860 <memset+0x17a>
    182e:	00b784a3          	sb	a1,9(a5)
    1832:	00a7069b          	addiw	a3,a4,10
    1836:	02c6f563          	bgeu	a3,a2,1860 <memset+0x17a>
    183a:	00b78523          	sb	a1,10(a5)
    183e:	00b7069b          	addiw	a3,a4,11
    1842:	00c6ff63          	bgeu	a3,a2,1860 <memset+0x17a>
    1846:	00b785a3          	sb	a1,11(a5)
    184a:	00c7069b          	addiw	a3,a4,12
    184e:	00c6f963          	bgeu	a3,a2,1860 <memset+0x17a>
    1852:	00b78623          	sb	a1,12(a5)
    1856:	2735                	addiw	a4,a4,13
    1858:	00c77463          	bgeu	a4,a2,1860 <memset+0x17a>
    185c:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1860:	8082                	ret
    1862:	472d                	li	a4,11
    1864:	bd79                	j	1702 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1866:	4f0d                	li	t5,3
    1868:	b701                	j	1768 <memset+0x82>
    186a:	8082                	ret
    186c:	4f05                	li	t5,1
    186e:	bded                	j	1768 <memset+0x82>
    1870:	8eaa                	mv	t4,a0
    1872:	4f01                	li	t5,0
    1874:	bdd5                	j	1768 <memset+0x82>
    1876:	87aa                	mv	a5,a0
    1878:	4701                	li	a4,0
    187a:	b7a1                	j	17c2 <memset+0xdc>
    187c:	4f09                	li	t5,2
    187e:	b5ed                	j	1768 <memset+0x82>
    1880:	4f11                	li	t5,4
    1882:	b5dd                	j	1768 <memset+0x82>
    1884:	4f15                	li	t5,5
    1886:	b5cd                	j	1768 <memset+0x82>
    1888:	4f19                	li	t5,6
    188a:	bdf9                	j	1768 <memset+0x82>

000000000000188c <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    188c:	00054783          	lbu	a5,0(a0)
    1890:	0005c703          	lbu	a4,0(a1)
    1894:	00e79863          	bne	a5,a4,18a4 <strcmp+0x18>
    1898:	0505                	addi	a0,a0,1
    189a:	0585                	addi	a1,a1,1
    189c:	fbe5                	bnez	a5,188c <strcmp>
    189e:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    18a0:	9d19                	subw	a0,a0,a4
    18a2:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    18a4:	0007851b          	sext.w	a0,a5
    18a8:	bfe5                	j	18a0 <strcmp+0x14>

00000000000018aa <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    18aa:	ce05                	beqz	a2,18e2 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18ac:	00054703          	lbu	a4,0(a0)
    18b0:	0005c783          	lbu	a5,0(a1)
    18b4:	cb0d                	beqz	a4,18e6 <strncmp+0x3c>
    if (!n--)
    18b6:	167d                	addi	a2,a2,-1
    18b8:	00c506b3          	add	a3,a0,a2
    18bc:	a819                	j	18d2 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18be:	00a68e63          	beq	a3,a0,18da <strncmp+0x30>
    18c2:	0505                	addi	a0,a0,1
    18c4:	00e79b63          	bne	a5,a4,18da <strncmp+0x30>
    18c8:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18cc:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18d0:	cb19                	beqz	a4,18e6 <strncmp+0x3c>
    18d2:	0005c783          	lbu	a5,0(a1)
    18d6:	0585                	addi	a1,a1,1
    18d8:	f3fd                	bnez	a5,18be <strncmp+0x14>
    return *l - *r;
    18da:	0007051b          	sext.w	a0,a4
    18de:	9d1d                	subw	a0,a0,a5
    18e0:	8082                	ret
        return 0;
    18e2:	4501                	li	a0,0
}
    18e4:	8082                	ret
    18e6:	4501                	li	a0,0
    return *l - *r;
    18e8:	9d1d                	subw	a0,a0,a5
    18ea:	8082                	ret

00000000000018ec <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18ec:	00757793          	andi	a5,a0,7
    18f0:	cf89                	beqz	a5,190a <strlen+0x1e>
    18f2:	87aa                	mv	a5,a0
    18f4:	a029                	j	18fe <strlen+0x12>
    18f6:	0785                	addi	a5,a5,1
    18f8:	0077f713          	andi	a4,a5,7
    18fc:	cb01                	beqz	a4,190c <strlen+0x20>
        if (!*s)
    18fe:	0007c703          	lbu	a4,0(a5)
    1902:	fb75                	bnez	a4,18f6 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    1904:	40a78533          	sub	a0,a5,a0
}
    1908:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    190a:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    190c:	6394                	ld	a3,0(a5)
    190e:	00000597          	auipc	a1,0x0
    1912:	6ca5b583          	ld	a1,1738(a1) # 1fd8 <__clone+0xd0>
    1916:	00000617          	auipc	a2,0x0
    191a:	6ca63603          	ld	a2,1738(a2) # 1fe0 <__clone+0xd8>
    191e:	a019                	j	1924 <strlen+0x38>
    1920:	6794                	ld	a3,8(a5)
    1922:	07a1                	addi	a5,a5,8
    1924:	00b68733          	add	a4,a3,a1
    1928:	fff6c693          	not	a3,a3
    192c:	8f75                	and	a4,a4,a3
    192e:	8f71                	and	a4,a4,a2
    1930:	db65                	beqz	a4,1920 <strlen+0x34>
    for (; *s; s++)
    1932:	0007c703          	lbu	a4,0(a5)
    1936:	d779                	beqz	a4,1904 <strlen+0x18>
    1938:	0017c703          	lbu	a4,1(a5)
    193c:	0785                	addi	a5,a5,1
    193e:	d379                	beqz	a4,1904 <strlen+0x18>
    1940:	0017c703          	lbu	a4,1(a5)
    1944:	0785                	addi	a5,a5,1
    1946:	fb6d                	bnez	a4,1938 <strlen+0x4c>
    1948:	bf75                	j	1904 <strlen+0x18>

000000000000194a <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    194a:	00757713          	andi	a4,a0,7
{
    194e:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1950:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1954:	cb19                	beqz	a4,196a <memchr+0x20>
    1956:	ce25                	beqz	a2,19ce <memchr+0x84>
    1958:	0007c703          	lbu	a4,0(a5)
    195c:	04b70e63          	beq	a4,a1,19b8 <memchr+0x6e>
    1960:	0785                	addi	a5,a5,1
    1962:	0077f713          	andi	a4,a5,7
    1966:	167d                	addi	a2,a2,-1
    1968:	f77d                	bnez	a4,1956 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    196a:	4501                	li	a0,0
    if (n && *s != c)
    196c:	c235                	beqz	a2,19d0 <memchr+0x86>
    196e:	0007c703          	lbu	a4,0(a5)
    1972:	04b70363          	beq	a4,a1,19b8 <memchr+0x6e>
        size_t k = ONES * c;
    1976:	00000517          	auipc	a0,0x0
    197a:	67253503          	ld	a0,1650(a0) # 1fe8 <__clone+0xe0>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    197e:	471d                	li	a4,7
        size_t k = ONES * c;
    1980:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1984:	02c77a63          	bgeu	a4,a2,19b8 <memchr+0x6e>
    1988:	00000897          	auipc	a7,0x0
    198c:	6508b883          	ld	a7,1616(a7) # 1fd8 <__clone+0xd0>
    1990:	00000817          	auipc	a6,0x0
    1994:	65083803          	ld	a6,1616(a6) # 1fe0 <__clone+0xd8>
    1998:	431d                	li	t1,7
    199a:	a029                	j	19a4 <memchr+0x5a>
    199c:	1661                	addi	a2,a2,-8
    199e:	07a1                	addi	a5,a5,8
    19a0:	02c37963          	bgeu	t1,a2,19d2 <memchr+0x88>
    19a4:	6398                	ld	a4,0(a5)
    19a6:	8f29                	xor	a4,a4,a0
    19a8:	011706b3          	add	a3,a4,a7
    19ac:	fff74713          	not	a4,a4
    19b0:	8f75                	and	a4,a4,a3
    19b2:	01077733          	and	a4,a4,a6
    19b6:	d37d                	beqz	a4,199c <memchr+0x52>
    19b8:	853e                	mv	a0,a5
    19ba:	97b2                	add	a5,a5,a2
    19bc:	a021                	j	19c4 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19be:	0505                	addi	a0,a0,1
    19c0:	00f50763          	beq	a0,a5,19ce <memchr+0x84>
    19c4:	00054703          	lbu	a4,0(a0)
    19c8:	feb71be3          	bne	a4,a1,19be <memchr+0x74>
    19cc:	8082                	ret
    return n ? (void *)s : 0;
    19ce:	4501                	li	a0,0
}
    19d0:	8082                	ret
    return n ? (void *)s : 0;
    19d2:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19d4:	f275                	bnez	a2,19b8 <memchr+0x6e>
}
    19d6:	8082                	ret

00000000000019d8 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19d8:	1101                	addi	sp,sp,-32
    19da:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19dc:	862e                	mv	a2,a1
{
    19de:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19e0:	4581                	li	a1,0
{
    19e2:	e426                	sd	s1,8(sp)
    19e4:	ec06                	sd	ra,24(sp)
    19e6:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19e8:	f63ff0ef          	jal	194a <memchr>
    return p ? p - s : n;
    19ec:	c519                	beqz	a0,19fa <strnlen+0x22>
}
    19ee:	60e2                	ld	ra,24(sp)
    19f0:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19f2:	8d05                	sub	a0,a0,s1
}
    19f4:	64a2                	ld	s1,8(sp)
    19f6:	6105                	addi	sp,sp,32
    19f8:	8082                	ret
    19fa:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19fc:	8522                	mv	a0,s0
}
    19fe:	6442                	ld	s0,16(sp)
    1a00:	64a2                	ld	s1,8(sp)
    1a02:	6105                	addi	sp,sp,32
    1a04:	8082                	ret

0000000000001a06 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    1a06:	00b547b3          	xor	a5,a0,a1
    1a0a:	8b9d                	andi	a5,a5,7
    1a0c:	eb95                	bnez	a5,1a40 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    1a0e:	0075f793          	andi	a5,a1,7
    1a12:	e7b1                	bnez	a5,1a5e <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a14:	6198                	ld	a4,0(a1)
    1a16:	00000617          	auipc	a2,0x0
    1a1a:	5c263603          	ld	a2,1474(a2) # 1fd8 <__clone+0xd0>
    1a1e:	00000817          	auipc	a6,0x0
    1a22:	5c283803          	ld	a6,1474(a6) # 1fe0 <__clone+0xd8>
    1a26:	a029                	j	1a30 <strcpy+0x2a>
    1a28:	e118                	sd	a4,0(a0)
    1a2a:	6598                	ld	a4,8(a1)
    1a2c:	05a1                	addi	a1,a1,8
    1a2e:	0521                	addi	a0,a0,8
    1a30:	00c707b3          	add	a5,a4,a2
    1a34:	fff74693          	not	a3,a4
    1a38:	8ff5                	and	a5,a5,a3
    1a3a:	0107f7b3          	and	a5,a5,a6
    1a3e:	d7ed                	beqz	a5,1a28 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a40:	0005c783          	lbu	a5,0(a1)
    1a44:	00f50023          	sb	a5,0(a0)
    1a48:	c785                	beqz	a5,1a70 <strcpy+0x6a>
    1a4a:	0015c783          	lbu	a5,1(a1)
    1a4e:	0505                	addi	a0,a0,1
    1a50:	0585                	addi	a1,a1,1
    1a52:	00f50023          	sb	a5,0(a0)
    1a56:	fbf5                	bnez	a5,1a4a <strcpy+0x44>
        ;
    return d;
}
    1a58:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a5a:	0505                	addi	a0,a0,1
    1a5c:	df45                	beqz	a4,1a14 <strcpy+0xe>
            if (!(*d = *s))
    1a5e:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a62:	0585                	addi	a1,a1,1
    1a64:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a68:	00f50023          	sb	a5,0(a0)
    1a6c:	f7fd                	bnez	a5,1a5a <strcpy+0x54>
}
    1a6e:	8082                	ret
    1a70:	8082                	ret

0000000000001a72 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a72:	00b547b3          	xor	a5,a0,a1
    1a76:	8b9d                	andi	a5,a5,7
    1a78:	1a079863          	bnez	a5,1c28 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a7c:	0075f793          	andi	a5,a1,7
    1a80:	16078463          	beqz	a5,1be8 <strncpy+0x176>
    1a84:	ea01                	bnez	a2,1a94 <strncpy+0x22>
    1a86:	a421                	j	1c8e <strncpy+0x21c>
    1a88:	167d                	addi	a2,a2,-1
    1a8a:	0505                	addi	a0,a0,1
    1a8c:	14070e63          	beqz	a4,1be8 <strncpy+0x176>
    1a90:	1a060863          	beqz	a2,1c40 <strncpy+0x1ce>
    1a94:	0005c783          	lbu	a5,0(a1)
    1a98:	0585                	addi	a1,a1,1
    1a9a:	0075f713          	andi	a4,a1,7
    1a9e:	00f50023          	sb	a5,0(a0)
    1aa2:	f3fd                	bnez	a5,1a88 <strncpy+0x16>
    1aa4:	4805                	li	a6,1
    1aa6:	1a061863          	bnez	a2,1c56 <strncpy+0x1e4>
    1aaa:	40a007b3          	neg	a5,a0
    1aae:	8b9d                	andi	a5,a5,7
    1ab0:	4681                	li	a3,0
    1ab2:	18061a63          	bnez	a2,1c46 <strncpy+0x1d4>
    1ab6:	00778713          	addi	a4,a5,7
    1aba:	45ad                	li	a1,11
    1abc:	18b76363          	bltu	a4,a1,1c42 <strncpy+0x1d0>
    1ac0:	1ae6eb63          	bltu	a3,a4,1c76 <strncpy+0x204>
    1ac4:	1a078363          	beqz	a5,1c6a <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1ac8:	00050023          	sb	zero,0(a0)
    1acc:	4685                	li	a3,1
    1ace:	00150713          	addi	a4,a0,1
    1ad2:	18d78f63          	beq	a5,a3,1c70 <strncpy+0x1fe>
    1ad6:	000500a3          	sb	zero,1(a0)
    1ada:	4689                	li	a3,2
    1adc:	00250713          	addi	a4,a0,2
    1ae0:	18d78e63          	beq	a5,a3,1c7c <strncpy+0x20a>
    1ae4:	00050123          	sb	zero,2(a0)
    1ae8:	468d                	li	a3,3
    1aea:	00350713          	addi	a4,a0,3
    1aee:	16d78c63          	beq	a5,a3,1c66 <strncpy+0x1f4>
    1af2:	000501a3          	sb	zero,3(a0)
    1af6:	4691                	li	a3,4
    1af8:	00450713          	addi	a4,a0,4
    1afc:	18d78263          	beq	a5,a3,1c80 <strncpy+0x20e>
    1b00:	00050223          	sb	zero,4(a0)
    1b04:	4695                	li	a3,5
    1b06:	00550713          	addi	a4,a0,5
    1b0a:	16d78d63          	beq	a5,a3,1c84 <strncpy+0x212>
    1b0e:	000502a3          	sb	zero,5(a0)
    1b12:	469d                	li	a3,7
    1b14:	00650713          	addi	a4,a0,6
    1b18:	16d79863          	bne	a5,a3,1c88 <strncpy+0x216>
    1b1c:	00750713          	addi	a4,a0,7
    1b20:	00050323          	sb	zero,6(a0)
    1b24:	40f80833          	sub	a6,a6,a5
    1b28:	ff887593          	andi	a1,a6,-8
    1b2c:	97aa                	add	a5,a5,a0
    1b2e:	95be                	add	a1,a1,a5
    1b30:	0007b023          	sd	zero,0(a5)
    1b34:	07a1                	addi	a5,a5,8
    1b36:	feb79de3          	bne	a5,a1,1b30 <strncpy+0xbe>
    1b3a:	ff887593          	andi	a1,a6,-8
    1b3e:	9ead                	addw	a3,a3,a1
    1b40:	00b707b3          	add	a5,a4,a1
    1b44:	12b80863          	beq	a6,a1,1c74 <strncpy+0x202>
    1b48:	00078023          	sb	zero,0(a5)
    1b4c:	0016871b          	addiw	a4,a3,1
    1b50:	0ec77863          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1b54:	000780a3          	sb	zero,1(a5)
    1b58:	0026871b          	addiw	a4,a3,2
    1b5c:	0ec77263          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1b60:	00078123          	sb	zero,2(a5)
    1b64:	0036871b          	addiw	a4,a3,3
    1b68:	0cc77c63          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1b6c:	000781a3          	sb	zero,3(a5)
    1b70:	0046871b          	addiw	a4,a3,4
    1b74:	0cc77663          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1b78:	00078223          	sb	zero,4(a5)
    1b7c:	0056871b          	addiw	a4,a3,5
    1b80:	0cc77063          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1b84:	000782a3          	sb	zero,5(a5)
    1b88:	0066871b          	addiw	a4,a3,6
    1b8c:	0ac77a63          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1b90:	00078323          	sb	zero,6(a5)
    1b94:	0076871b          	addiw	a4,a3,7
    1b98:	0ac77463          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1b9c:	000783a3          	sb	zero,7(a5)
    1ba0:	0086871b          	addiw	a4,a3,8
    1ba4:	08c77e63          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1ba8:	00078423          	sb	zero,8(a5)
    1bac:	0096871b          	addiw	a4,a3,9
    1bb0:	08c77863          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1bb4:	000784a3          	sb	zero,9(a5)
    1bb8:	00a6871b          	addiw	a4,a3,10
    1bbc:	08c77263          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1bc0:	00078523          	sb	zero,10(a5)
    1bc4:	00b6871b          	addiw	a4,a3,11
    1bc8:	06c77c63          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1bcc:	000785a3          	sb	zero,11(a5)
    1bd0:	00c6871b          	addiw	a4,a3,12
    1bd4:	06c77663          	bgeu	a4,a2,1c40 <strncpy+0x1ce>
    1bd8:	00078623          	sb	zero,12(a5)
    1bdc:	26b5                	addiw	a3,a3,13
    1bde:	06c6f163          	bgeu	a3,a2,1c40 <strncpy+0x1ce>
    1be2:	000786a3          	sb	zero,13(a5)
    1be6:	8082                	ret
            ;
        if (!n || !*s)
    1be8:	c645                	beqz	a2,1c90 <strncpy+0x21e>
    1bea:	0005c783          	lbu	a5,0(a1)
    1bee:	ea078be3          	beqz	a5,1aa4 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bf2:	479d                	li	a5,7
    1bf4:	02c7ff63          	bgeu	a5,a2,1c32 <strncpy+0x1c0>
    1bf8:	00000897          	auipc	a7,0x0
    1bfc:	3e08b883          	ld	a7,992(a7) # 1fd8 <__clone+0xd0>
    1c00:	00000817          	auipc	a6,0x0
    1c04:	3e083803          	ld	a6,992(a6) # 1fe0 <__clone+0xd8>
    1c08:	431d                	li	t1,7
    1c0a:	6198                	ld	a4,0(a1)
    1c0c:	011707b3          	add	a5,a4,a7
    1c10:	fff74693          	not	a3,a4
    1c14:	8ff5                	and	a5,a5,a3
    1c16:	0107f7b3          	and	a5,a5,a6
    1c1a:	ef81                	bnez	a5,1c32 <strncpy+0x1c0>
            *wd = *ws;
    1c1c:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c1e:	1661                	addi	a2,a2,-8
    1c20:	05a1                	addi	a1,a1,8
    1c22:	0521                	addi	a0,a0,8
    1c24:	fec363e3          	bltu	t1,a2,1c0a <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c28:	e609                	bnez	a2,1c32 <strncpy+0x1c0>
    1c2a:	a08d                	j	1c8c <strncpy+0x21a>
    1c2c:	167d                	addi	a2,a2,-1
    1c2e:	0505                	addi	a0,a0,1
    1c30:	ca01                	beqz	a2,1c40 <strncpy+0x1ce>
    1c32:	0005c783          	lbu	a5,0(a1)
    1c36:	0585                	addi	a1,a1,1
    1c38:	00f50023          	sb	a5,0(a0)
    1c3c:	fbe5                	bnez	a5,1c2c <strncpy+0x1ba>
        ;
tail:
    1c3e:	b59d                	j	1aa4 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c40:	8082                	ret
    1c42:	472d                	li	a4,11
    1c44:	bdb5                	j	1ac0 <strncpy+0x4e>
    1c46:	00778713          	addi	a4,a5,7
    1c4a:	45ad                	li	a1,11
    1c4c:	fff60693          	addi	a3,a2,-1
    1c50:	e6b778e3          	bgeu	a4,a1,1ac0 <strncpy+0x4e>
    1c54:	b7fd                	j	1c42 <strncpy+0x1d0>
    1c56:	40a007b3          	neg	a5,a0
    1c5a:	8832                	mv	a6,a2
    1c5c:	8b9d                	andi	a5,a5,7
    1c5e:	4681                	li	a3,0
    1c60:	e4060be3          	beqz	a2,1ab6 <strncpy+0x44>
    1c64:	b7cd                	j	1c46 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c66:	468d                	li	a3,3
    1c68:	bd75                	j	1b24 <strncpy+0xb2>
    1c6a:	872a                	mv	a4,a0
    1c6c:	4681                	li	a3,0
    1c6e:	bd5d                	j	1b24 <strncpy+0xb2>
    1c70:	4685                	li	a3,1
    1c72:	bd4d                	j	1b24 <strncpy+0xb2>
    1c74:	8082                	ret
    1c76:	87aa                	mv	a5,a0
    1c78:	4681                	li	a3,0
    1c7a:	b5f9                	j	1b48 <strncpy+0xd6>
    1c7c:	4689                	li	a3,2
    1c7e:	b55d                	j	1b24 <strncpy+0xb2>
    1c80:	4691                	li	a3,4
    1c82:	b54d                	j	1b24 <strncpy+0xb2>
    1c84:	4695                	li	a3,5
    1c86:	bd79                	j	1b24 <strncpy+0xb2>
    1c88:	4699                	li	a3,6
    1c8a:	bd69                	j	1b24 <strncpy+0xb2>
    1c8c:	8082                	ret
    1c8e:	8082                	ret
    1c90:	8082                	ret

0000000000001c92 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c92:	87aa                	mv	a5,a0
    1c94:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c96:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c9a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c9e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1ca0:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ca2:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1ca6:	2501                	sext.w	a0,a0
    1ca8:	8082                	ret

0000000000001caa <openat>:
    register long a7 __asm__("a7") = n;
    1caa:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1cae:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cb2:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1cb6:	2501                	sext.w	a0,a0
    1cb8:	8082                	ret

0000000000001cba <close>:
    register long a7 __asm__("a7") = n;
    1cba:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cbe:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cc2:	2501                	sext.w	a0,a0
    1cc4:	8082                	ret

0000000000001cc6 <read>:
    register long a7 __asm__("a7") = n;
    1cc6:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cca:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cce:	8082                	ret

0000000000001cd0 <write>:
    register long a7 __asm__("a7") = n;
    1cd0:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cd4:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cd8:	8082                	ret

0000000000001cda <getpid>:
    register long a7 __asm__("a7") = n;
    1cda:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cde:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1ce2:	2501                	sext.w	a0,a0
    1ce4:	8082                	ret

0000000000001ce6 <getppid>:
    register long a7 __asm__("a7") = n;
    1ce6:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cea:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cee:	2501                	sext.w	a0,a0
    1cf0:	8082                	ret

0000000000001cf2 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cf2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cf6:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cfa:	2501                	sext.w	a0,a0
    1cfc:	8082                	ret

0000000000001cfe <fork>:
    register long a7 __asm__("a7") = n;
    1cfe:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1d02:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1d04:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d06:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1d0a:	2501                	sext.w	a0,a0
    1d0c:	8082                	ret

0000000000001d0e <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1d0e:	85b2                	mv	a1,a2
    1d10:	863a                	mv	a2,a4
    if (stack)
    1d12:	c191                	beqz	a1,1d16 <clone+0x8>
	stack += stack_size;
    1d14:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d16:	4781                	li	a5,0
    1d18:	4701                	li	a4,0
    1d1a:	4681                	li	a3,0
    1d1c:	2601                	sext.w	a2,a2
    1d1e:	a2ed                	j	1f08 <__clone>

0000000000001d20 <exit>:
    register long a7 __asm__("a7") = n;
    1d20:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d24:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d28:	8082                	ret

0000000000001d2a <waitpid>:
    register long a7 __asm__("a7") = n;
    1d2a:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d2e:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d30:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d34:	2501                	sext.w	a0,a0
    1d36:	8082                	ret

0000000000001d38 <exec>:
    register long a7 __asm__("a7") = n;
    1d38:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d3c:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d40:	2501                	sext.w	a0,a0
    1d42:	8082                	ret

0000000000001d44 <execve>:
    register long a7 __asm__("a7") = n;
    1d44:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d48:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d4c:	2501                	sext.w	a0,a0
    1d4e:	8082                	ret

0000000000001d50 <times>:
    register long a7 __asm__("a7") = n;
    1d50:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d54:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d58:	2501                	sext.w	a0,a0
    1d5a:	8082                	ret

0000000000001d5c <get_time>:

int64 get_time()
{
    1d5c:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d5e:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d62:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d64:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d66:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d6a:	2501                	sext.w	a0,a0
    1d6c:	ed09                	bnez	a0,1d86 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d6e:	67a2                	ld	a5,8(sp)
    1d70:	3e800713          	li	a4,1000
    1d74:	00015503          	lhu	a0,0(sp)
    1d78:	02e7d7b3          	divu	a5,a5,a4
    1d7c:	02e50533          	mul	a0,a0,a4
    1d80:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d82:	0141                	addi	sp,sp,16
    1d84:	8082                	ret
        return -1;
    1d86:	557d                	li	a0,-1
    1d88:	bfed                	j	1d82 <get_time+0x26>

0000000000001d8a <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d8a:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d8e:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d92:	2501                	sext.w	a0,a0
    1d94:	8082                	ret

0000000000001d96 <time>:
    register long a7 __asm__("a7") = n;
    1d96:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d9a:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d9e:	2501                	sext.w	a0,a0
    1da0:	8082                	ret

0000000000001da2 <sleep>:

int sleep(unsigned long long time)
{
    1da2:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1da4:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1da6:	850a                	mv	a0,sp
    1da8:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1daa:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1dae:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db0:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1db4:	e501                	bnez	a0,1dbc <sleep+0x1a>
    return 0;
    1db6:	4501                	li	a0,0
}
    1db8:	0141                	addi	sp,sp,16
    1dba:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dbc:	4502                	lw	a0,0(sp)
}
    1dbe:	0141                	addi	sp,sp,16
    1dc0:	8082                	ret

0000000000001dc2 <set_priority>:
    register long a7 __asm__("a7") = n;
    1dc2:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1dc6:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1dca:	2501                	sext.w	a0,a0
    1dcc:	8082                	ret

0000000000001dce <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1dce:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1dd2:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1dd6:	8082                	ret

0000000000001dd8 <munmap>:
    register long a7 __asm__("a7") = n;
    1dd8:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ddc:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1de0:	2501                	sext.w	a0,a0
    1de2:	8082                	ret

0000000000001de4 <wait>:

int wait(int *code)
{
    1de4:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1de6:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1dea:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1dec:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dee:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1df0:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1df4:	2501                	sext.w	a0,a0
    1df6:	8082                	ret

0000000000001df8 <spawn>:
    register long a7 __asm__("a7") = n;
    1df8:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dfc:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1e00:	2501                	sext.w	a0,a0
    1e02:	8082                	ret

0000000000001e04 <mailread>:
    register long a7 __asm__("a7") = n;
    1e04:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e08:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1e0c:	2501                	sext.w	a0,a0
    1e0e:	8082                	ret

0000000000001e10 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1e10:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e14:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e18:	2501                	sext.w	a0,a0
    1e1a:	8082                	ret

0000000000001e1c <fstat>:
    register long a7 __asm__("a7") = n;
    1e1c:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e20:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e24:	2501                	sext.w	a0,a0
    1e26:	8082                	ret

0000000000001e28 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e28:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e2a:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e2e:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e30:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e34:	2501                	sext.w	a0,a0
    1e36:	8082                	ret

0000000000001e38 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e38:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e3a:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e3e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e40:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e44:	2501                	sext.w	a0,a0
    1e46:	8082                	ret

0000000000001e48 <link>:

int link(char *old_path, char *new_path)
{
    1e48:	87aa                	mv	a5,a0
    1e4a:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e4c:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e50:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e54:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e56:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e5a:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e5c:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e60:	2501                	sext.w	a0,a0
    1e62:	8082                	ret

0000000000001e64 <unlink>:

int unlink(char *path)
{
    1e64:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e66:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e6a:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e6e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e70:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e74:	2501                	sext.w	a0,a0
    1e76:	8082                	ret

0000000000001e78 <uname>:
    register long a7 __asm__("a7") = n;
    1e78:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e7c:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e80:	2501                	sext.w	a0,a0
    1e82:	8082                	ret

0000000000001e84 <brk>:
    register long a7 __asm__("a7") = n;
    1e84:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e88:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e8c:	2501                	sext.w	a0,a0
    1e8e:	8082                	ret

0000000000001e90 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e90:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e92:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e96:	8082                	ret

0000000000001e98 <chdir>:
    register long a7 __asm__("a7") = n;
    1e98:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e9c:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1ea0:	2501                	sext.w	a0,a0
    1ea2:	8082                	ret

0000000000001ea4 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1ea4:	862e                	mv	a2,a1
    1ea6:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1ea8:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1eaa:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1eae:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1eb2:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1eb4:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eb6:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1eba:	2501                	sext.w	a0,a0
    1ebc:	8082                	ret

0000000000001ebe <getdents>:
    register long a7 __asm__("a7") = n;
    1ebe:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ec2:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ec6:	2501                	sext.w	a0,a0
    1ec8:	8082                	ret

0000000000001eca <pipe>:
    register long a7 __asm__("a7") = n;
    1eca:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ece:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ed0:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1ed4:	2501                	sext.w	a0,a0
    1ed6:	8082                	ret

0000000000001ed8 <dup>:
    register long a7 __asm__("a7") = n;
    1ed8:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1eda:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1ede:	2501                	sext.w	a0,a0
    1ee0:	8082                	ret

0000000000001ee2 <dup2>:
    register long a7 __asm__("a7") = n;
    1ee2:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ee4:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ee6:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1eea:	2501                	sext.w	a0,a0
    1eec:	8082                	ret

0000000000001eee <mount>:
    register long a7 __asm__("a7") = n;
    1eee:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ef2:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ef6:	2501                	sext.w	a0,a0
    1ef8:	8082                	ret

0000000000001efa <umount>:
    register long a7 __asm__("a7") = n;
    1efa:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1efe:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f00:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1f04:	2501                	sext.w	a0,a0
    1f06:	8082                	ret

0000000000001f08 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1f08:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1f0a:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1f0c:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1f0e:	8532                	mv	a0,a2
	mv a2, a4
    1f10:	863a                	mv	a2,a4
	mv a3, a5
    1f12:	86be                	mv	a3,a5
	mv a4, a6
    1f14:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f16:	0dc00893          	li	a7,220
	ecall
    1f1a:	00000073          	ecall

	beqz a0, 1f
    1f1e:	c111                	beqz	a0,1f22 <__clone+0x1a>
	# Parent
	ret
    1f20:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f22:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f24:	6522                	ld	a0,8(sp)
	jalr a1
    1f26:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f28:	05d00893          	li	a7,93
	ecall
    1f2c:	00000073          	ecall
