
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/fork:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a05d                	j	10a8 <__start_main>

0000000000001004 <test_fork>:
 * 成功测试时子进程的输出：
 * "  child process."
 */
static int fd[2];

void test_fork(void){
    1004:	1101                	addi	sp,sp,-32
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	ee250513          	addi	a0,a0,-286 # 1ee8 <__clone+0x28>
void test_fork(void){
    100e:	ec06                	sd	ra,24(sp)
    TEST_START(__func__);
    1010:	30a000ef          	jal	131a <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	f8450513          	addi	a0,a0,-124 # 1f98 <__func__.0>
    101c:	2fe000ef          	jal	131a <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ee050513          	addi	a0,a0,-288 # 1f00 <__clone+0x40>
    1028:	2f2000ef          	jal	131a <puts>
    int cpid, wstatus;
    cpid = fork();
    102c:	48b000ef          	jal	1cb6 <fork>
    assert(cpid != -1);
    1030:	57fd                	li	a5,-1
    1032:	04f50363          	beq	a0,a5,1078 <test_fork+0x74>

    if(cpid > 0){
    1036:	04a05763          	blez	a0,1084 <test_fork+0x80>
	wait(&wstatus);
    103a:	0068                	addi	a0,sp,12
    103c:	561000ef          	jal	1d9c <wait>
	printf("  parent process. wstatus:%d\n", wstatus);
    1040:	45b2                	lw	a1,12(sp)
    1042:	00001517          	auipc	a0,0x1
    1046:	eee50513          	addi	a0,a0,-274 # 1f30 <__clone+0x70>
    104a:	2f2000ef          	jal	133c <printf>
    }else{
	printf("  child process.\n");
	exit(0);
    }
    TEST_END(__func__);
    104e:	00001517          	auipc	a0,0x1
    1052:	f1a50513          	addi	a0,a0,-230 # 1f68 <__clone+0xa8>
    1056:	2c4000ef          	jal	131a <puts>
    105a:	00001517          	auipc	a0,0x1
    105e:	f3e50513          	addi	a0,a0,-194 # 1f98 <__func__.0>
    1062:	2b8000ef          	jal	131a <puts>
    1066:	00001517          	auipc	a0,0x1
    106a:	e9a50513          	addi	a0,a0,-358 # 1f00 <__clone+0x40>
    106e:	2ac000ef          	jal	131a <puts>
}
    1072:	60e2                	ld	ra,24(sp)
    1074:	6105                	addi	sp,sp,32
    1076:	8082                	ret
    assert(cpid != -1);
    1078:	00001517          	auipc	a0,0x1
    107c:	e9850513          	addi	a0,a0,-360 # 1f10 <__clone+0x50>
    1080:	546000ef          	jal	15c6 <panic>
	printf("  child process.\n");
    1084:	00001517          	auipc	a0,0x1
    1088:	ecc50513          	addi	a0,a0,-308 # 1f50 <__clone+0x90>
    108c:	2b0000ef          	jal	133c <printf>
	exit(0);
    1090:	4501                	li	a0,0
    1092:	447000ef          	jal	1cd8 <exit>
    1096:	bf65                	j	104e <test_fork+0x4a>

0000000000001098 <main>:

int main(void){
    1098:	1141                	addi	sp,sp,-16
    109a:	e406                	sd	ra,8(sp)
    test_fork();
    109c:	f69ff0ef          	jal	1004 <test_fork>
    return 0;
}
    10a0:	60a2                	ld	ra,8(sp)
    10a2:	4501                	li	a0,0
    10a4:	0141                	addi	sp,sp,16
    10a6:	8082                	ret

00000000000010a8 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10a8:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10aa:	4108                	lw	a0,0(a0)
{
    10ac:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10ae:	05a1                	addi	a1,a1,8
{
    10b0:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10b2:	fe7ff0ef          	jal	1098 <main>
    10b6:	423000ef          	jal	1cd8 <exit>
	return 0;
}
    10ba:	60a2                	ld	ra,8(sp)
    10bc:	4501                	li	a0,0
    10be:	0141                	addi	sp,sp,16
    10c0:	8082                	ret

00000000000010c2 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10c2:	7179                	addi	sp,sp,-48
    10c4:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10c6:	12054b63          	bltz	a0,11fc <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10ca:	02b577bb          	remuw	a5,a0,a1
    10ce:	00001617          	auipc	a2,0x1
    10d2:	eda60613          	addi	a2,a2,-294 # 1fa8 <digits>
    buf[16] = 0;
    10d6:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10da:	0005871b          	sext.w	a4,a1
    10de:	1782                	slli	a5,a5,0x20
    10e0:	9381                	srli	a5,a5,0x20
    10e2:	97b2                	add	a5,a5,a2
    10e4:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10e8:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10ec:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10f0:	1cb56363          	bltu	a0,a1,12b6 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    10f4:	45b9                	li	a1,14
    10f6:	02e877bb          	remuw	a5,a6,a4
    10fa:	1782                	slli	a5,a5,0x20
    10fc:	9381                	srli	a5,a5,0x20
    10fe:	97b2                	add	a5,a5,a2
    1100:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1104:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    1108:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    110c:	0ce86e63          	bltu	a6,a4,11e8 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1110:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1114:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    1118:	1582                	slli	a1,a1,0x20
    111a:	9181                	srli	a1,a1,0x20
    111c:	95b2                	add	a1,a1,a2
    111e:	0005c583          	lbu	a1,0(a1)
    1122:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    1126:	0007859b          	sext.w	a1,a5
    112a:	12e6ec63          	bltu	a3,a4,1262 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    112e:	02e7f6bb          	remuw	a3,a5,a4
    1132:	1682                	slli	a3,a3,0x20
    1134:	9281                	srli	a3,a3,0x20
    1136:	96b2                	add	a3,a3,a2
    1138:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    113c:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1140:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1144:	12e5e863          	bltu	a1,a4,1274 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    1148:	02e876bb          	remuw	a3,a6,a4
    114c:	1682                	slli	a3,a3,0x20
    114e:	9281                	srli	a3,a3,0x20
    1150:	96b2                	add	a3,a3,a2
    1152:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1156:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    115a:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    115e:	12e86463          	bltu	a6,a4,1286 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1162:	02e5f6bb          	remuw	a3,a1,a4
    1166:	1682                	slli	a3,a3,0x20
    1168:	9281                	srli	a3,a3,0x20
    116a:	96b2                	add	a3,a3,a2
    116c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1170:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1174:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    1178:	0ce5ec63          	bltu	a1,a4,1250 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    117c:	02e876bb          	remuw	a3,a6,a4
    1180:	1682                	slli	a3,a3,0x20
    1182:	9281                	srli	a3,a3,0x20
    1184:	96b2                	add	a3,a3,a2
    1186:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    118a:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    118e:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    1192:	10e86963          	bltu	a6,a4,12a4 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    1196:	02e5f6bb          	remuw	a3,a1,a4
    119a:	1682                	slli	a3,a3,0x20
    119c:	9281                	srli	a3,a3,0x20
    119e:	96b2                	add	a3,a3,a2
    11a0:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11a4:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11a8:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11ac:	10e5e763          	bltu	a1,a4,12ba <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11b0:	02e876bb          	remuw	a3,a6,a4
    11b4:	1682                	slli	a3,a3,0x20
    11b6:	9281                	srli	a3,a3,0x20
    11b8:	96b2                	add	a3,a3,a2
    11ba:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11be:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11c2:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11c6:	10e86363          	bltu	a6,a4,12cc <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11ca:	1782                	slli	a5,a5,0x20
    11cc:	9381                	srli	a5,a5,0x20
    11ce:	97b2                	add	a5,a5,a2
    11d0:	0007c783          	lbu	a5,0(a5)
    11d4:	4599                	li	a1,6
    11d6:	00f10723          	sb	a5,14(sp)

    if (sign)
    11da:	00055763          	bgez	a0,11e8 <printint.constprop.0+0x126>
        buf[i--] = '-';
    11de:	02d00793          	li	a5,45
    11e2:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11e6:	4595                	li	a1,5
    write(f, s, l);
    11e8:	003c                	addi	a5,sp,8
    11ea:	4641                	li	a2,16
    11ec:	9e0d                	subw	a2,a2,a1
    11ee:	4505                	li	a0,1
    11f0:	95be                	add	a1,a1,a5
    11f2:	297000ef          	jal	1c88 <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11f6:	70a2                	ld	ra,40(sp)
    11f8:	6145                	addi	sp,sp,48
    11fa:	8082                	ret
        x = -xx;
    11fc:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1200:	02b877bb          	remuw	a5,a6,a1
    1204:	00001617          	auipc	a2,0x1
    1208:	da460613          	addi	a2,a2,-604 # 1fa8 <digits>
    buf[16] = 0;
    120c:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1210:	0005871b          	sext.w	a4,a1
    1214:	1782                	slli	a5,a5,0x20
    1216:	9381                	srli	a5,a5,0x20
    1218:	97b2                	add	a5,a5,a2
    121a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    121e:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1222:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1226:	06b86963          	bltu	a6,a1,1298 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    122a:	02e8f7bb          	remuw	a5,a7,a4
    122e:	1782                	slli	a5,a5,0x20
    1230:	9381                	srli	a5,a5,0x20
    1232:	97b2                	add	a5,a5,a2
    1234:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1238:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    123c:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1240:	ece8f8e3          	bgeu	a7,a4,1110 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1244:	02d00793          	li	a5,45
    1248:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    124c:	45b5                	li	a1,13
    124e:	bf69                	j	11e8 <printint.constprop.0+0x126>
    1250:	45a9                	li	a1,10
    if (sign)
    1252:	f8055be3          	bgez	a0,11e8 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1256:	02d00793          	li	a5,45
    125a:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    125e:	45a5                	li	a1,9
    1260:	b761                	j	11e8 <printint.constprop.0+0x126>
    1262:	45b5                	li	a1,13
    if (sign)
    1264:	f80552e3          	bgez	a0,11e8 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1268:	02d00793          	li	a5,45
    126c:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1270:	45b1                	li	a1,12
    1272:	bf9d                	j	11e8 <printint.constprop.0+0x126>
    1274:	45b1                	li	a1,12
    if (sign)
    1276:	f60559e3          	bgez	a0,11e8 <printint.constprop.0+0x126>
        buf[i--] = '-';
    127a:	02d00793          	li	a5,45
    127e:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    1282:	45ad                	li	a1,11
    1284:	b795                	j	11e8 <printint.constprop.0+0x126>
    1286:	45ad                	li	a1,11
    if (sign)
    1288:	f60550e3          	bgez	a0,11e8 <printint.constprop.0+0x126>
        buf[i--] = '-';
    128c:	02d00793          	li	a5,45
    1290:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    1294:	45a9                	li	a1,10
    1296:	bf89                	j	11e8 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1298:	02d00793          	li	a5,45
    129c:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12a0:	45b9                	li	a1,14
    12a2:	b799                	j	11e8 <printint.constprop.0+0x126>
    12a4:	45a5                	li	a1,9
    if (sign)
    12a6:	f40551e3          	bgez	a0,11e8 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12aa:	02d00793          	li	a5,45
    12ae:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12b2:	45a1                	li	a1,8
    12b4:	bf15                	j	11e8 <printint.constprop.0+0x126>
    i = 15;
    12b6:	45bd                	li	a1,15
    12b8:	bf05                	j	11e8 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12ba:	45a1                	li	a1,8
    if (sign)
    12bc:	f20556e3          	bgez	a0,11e8 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c0:	02d00793          	li	a5,45
    12c4:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12c8:	459d                	li	a1,7
    12ca:	bf39                	j	11e8 <printint.constprop.0+0x126>
    12cc:	459d                	li	a1,7
    if (sign)
    12ce:	f0055de3          	bgez	a0,11e8 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d2:	02d00793          	li	a5,45
    12d6:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12da:	4599                	li	a1,6
    12dc:	b731                	j	11e8 <printint.constprop.0+0x126>

00000000000012de <getchar>:
{
    12de:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12e0:	00f10593          	addi	a1,sp,15
    12e4:	4605                	li	a2,1
    12e6:	4501                	li	a0,0
{
    12e8:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12ea:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12ee:	191000ef          	jal	1c7e <read>
}
    12f2:	60e2                	ld	ra,24(sp)
    12f4:	00f14503          	lbu	a0,15(sp)
    12f8:	6105                	addi	sp,sp,32
    12fa:	8082                	ret

00000000000012fc <putchar>:
{
    12fc:	1101                	addi	sp,sp,-32
    12fe:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1300:	00f10593          	addi	a1,sp,15
    1304:	4605                	li	a2,1
    1306:	4505                	li	a0,1
{
    1308:	ec06                	sd	ra,24(sp)
    char byte = c;
    130a:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    130e:	17b000ef          	jal	1c88 <write>
}
    1312:	60e2                	ld	ra,24(sp)
    1314:	2501                	sext.w	a0,a0
    1316:	6105                	addi	sp,sp,32
    1318:	8082                	ret

000000000000131a <puts>:
{
    131a:	1141                	addi	sp,sp,-16
    131c:	e406                	sd	ra,8(sp)
    131e:	e022                	sd	s0,0(sp)
    1320:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1322:	582000ef          	jal	18a4 <strlen>
    1326:	862a                	mv	a2,a0
    1328:	85a2                	mv	a1,s0
    132a:	4505                	li	a0,1
    132c:	15d000ef          	jal	1c88 <write>
}
    1330:	60a2                	ld	ra,8(sp)
    1332:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1334:	957d                	srai	a0,a0,0x3f
    return r;
    1336:	2501                	sext.w	a0,a0
}
    1338:	0141                	addi	sp,sp,16
    133a:	8082                	ret

000000000000133c <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    133c:	7131                	addi	sp,sp,-192
    133e:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1340:	013c                	addi	a5,sp,136
{
    1342:	f0ca                	sd	s2,96(sp)
    1344:	ecce                	sd	s3,88(sp)
    1346:	e8d2                	sd	s4,80(sp)
    1348:	e4d6                	sd	s5,72(sp)
    134a:	e0da                	sd	s6,64(sp)
    134c:	fc5e                	sd	s7,56(sp)
    134e:	fc86                	sd	ra,120(sp)
    1350:	f8a2                	sd	s0,112(sp)
    1352:	f4a6                	sd	s1,104(sp)
    1354:	e52e                	sd	a1,136(sp)
    1356:	e932                	sd	a2,144(sp)
    1358:	ed36                	sd	a3,152(sp)
    135a:	f13a                	sd	a4,160(sp)
    135c:	f942                	sd	a6,176(sp)
    135e:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1360:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1362:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    1366:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    136a:	00001b97          	auipc	s7,0x1
    136e:	c0eb8b93          	addi	s7,s7,-1010 # 1f78 <__clone+0xb8>
        switch (s[1])
    1372:	07800a93          	li	s5,120
    1376:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    137a:	00001997          	auipc	s3,0x1
    137e:	c2e98993          	addi	s3,s3,-978 # 1fa8 <digits>
        if (!*s)
    1382:	00054783          	lbu	a5,0(a0)
    1386:	16078c63          	beqz	a5,14fe <printf+0x1c2>
    138a:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    138c:	19278463          	beq	a5,s2,1514 <printf+0x1d8>
    1390:	00164783          	lbu	a5,1(a2)
    1394:	0605                	addi	a2,a2,1
    1396:	fbfd                	bnez	a5,138c <printf+0x50>
    1398:	84b2                	mv	s1,a2
        l = z - a;
    139a:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    139e:	85aa                	mv	a1,a0
    13a0:	8622                	mv	a2,s0
    13a2:	4505                	li	a0,1
    13a4:	0e5000ef          	jal	1c88 <write>
        if (l)
    13a8:	18041f63          	bnez	s0,1546 <printf+0x20a>
        if (s[1] == 0)
    13ac:	0014c783          	lbu	a5,1(s1)
    13b0:	14078763          	beqz	a5,14fe <printf+0x1c2>
        switch (s[1])
    13b4:	1d478163          	beq	a5,s4,1576 <printf+0x23a>
    13b8:	18fa6963          	bltu	s4,a5,154a <printf+0x20e>
    13bc:	1b678363          	beq	a5,s6,1562 <printf+0x226>
    13c0:	07000713          	li	a4,112
    13c4:	1ce79c63          	bne	a5,a4,159c <printf+0x260>
            printptr(va_arg(ap, uint64));
    13c8:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13ca:	03000793          	li	a5,48
    13ce:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13d2:	631c                	ld	a5,0(a4)
    13d4:	0721                	addi	a4,a4,8
    13d6:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13d8:	00479f93          	slli	t6,a5,0x4
    13dc:	00879f13          	slli	t5,a5,0x8
    13e0:	00c79e93          	slli	t4,a5,0xc
    13e4:	01079e13          	slli	t3,a5,0x10
    13e8:	01479313          	slli	t1,a5,0x14
    13ec:	01879893          	slli	a7,a5,0x18
    13f0:	01c79713          	slli	a4,a5,0x1c
    13f4:	02479813          	slli	a6,a5,0x24
    13f8:	02879513          	slli	a0,a5,0x28
    13fc:	02c79593          	slli	a1,a5,0x2c
    1400:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1404:	03c7d293          	srli	t0,a5,0x3c
    1408:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    140c:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1410:	03cfdf93          	srli	t6,t6,0x3c
    1414:	03cf5f13          	srli	t5,t5,0x3c
    1418:	03cede93          	srli	t4,t4,0x3c
    141c:	03ce5e13          	srli	t3,t3,0x3c
    1420:	03c35313          	srli	t1,t1,0x3c
    1424:	03c8d893          	srli	a7,a7,0x3c
    1428:	9371                	srli	a4,a4,0x3c
    142a:	03c85813          	srli	a6,a6,0x3c
    142e:	9171                	srli	a0,a0,0x3c
    1430:	91f1                	srli	a1,a1,0x3c
    1432:	9271                	srli	a2,a2,0x3c
    1434:	974e                	add	a4,a4,s3
    1436:	92f1                	srli	a3,a3,0x3c
    1438:	92ce                	add	t0,t0,s3
    143a:	9fce                	add	t6,t6,s3
    143c:	9f4e                	add	t5,t5,s3
    143e:	9ece                	add	t4,t4,s3
    1440:	9e4e                	add	t3,t3,s3
    1442:	934e                	add	t1,t1,s3
    1444:	98ce                	add	a7,a7,s3
    1446:	93ce                	add	t2,t2,s3
    1448:	984e                	add	a6,a6,s3
    144a:	954e                	add	a0,a0,s3
    144c:	95ce                	add	a1,a1,s3
    144e:	964e                	add	a2,a2,s3
    1450:	0002c283          	lbu	t0,0(t0)
    1454:	000fcf83          	lbu	t6,0(t6)
    1458:	000f4f03          	lbu	t5,0(t5)
    145c:	000ece83          	lbu	t4,0(t4)
    1460:	000e4e03          	lbu	t3,0(t3)
    1464:	00034303          	lbu	t1,0(t1)
    1468:	0008c883          	lbu	a7,0(a7)
    146c:	00074403          	lbu	s0,0(a4)
    1470:	0003c383          	lbu	t2,0(t2)
    1474:	00084803          	lbu	a6,0(a6)
    1478:	00054503          	lbu	a0,0(a0)
    147c:	0005c583          	lbu	a1,0(a1)
    1480:	00064603          	lbu	a2,0(a2)
    1484:	00d98733          	add	a4,s3,a3
    1488:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    148c:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1490:	9371                	srli	a4,a4,0x3c
    1492:	8bbd                	andi	a5,a5,15
    1494:	00510523          	sb	t0,10(sp)
    1498:	01f105a3          	sb	t6,11(sp)
    149c:	01e10623          	sb	t5,12(sp)
    14a0:	01d106a3          	sb	t4,13(sp)
    14a4:	01c10723          	sb	t3,14(sp)
    14a8:	006107a3          	sb	t1,15(sp)
    14ac:	01110823          	sb	a7,16(sp)
    14b0:	00710923          	sb	t2,18(sp)
    14b4:	010109a3          	sb	a6,19(sp)
    14b8:	00a10a23          	sb	a0,20(sp)
    14bc:	00b10aa3          	sb	a1,21(sp)
    14c0:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14c4:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14c8:	008108a3          	sb	s0,17(sp)
    14cc:	974e                	add	a4,a4,s3
    14ce:	97ce                	add	a5,a5,s3
    14d0:	00d10ba3          	sb	a3,23(sp)
    14d4:	00074703          	lbu	a4,0(a4)
    14d8:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14dc:	4649                	li	a2,18
    14de:	002c                	addi	a1,sp,8
    14e0:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14e2:	00e10c23          	sb	a4,24(sp)
    14e6:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14ea:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14ee:	79a000ef          	jal	1c88 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14f2:	00248513          	addi	a0,s1,2
        if (!*s)
    14f6:	00054783          	lbu	a5,0(a0)
    14fa:	e80798e3          	bnez	a5,138a <printf+0x4e>
    }
    va_end(ap);
}
    14fe:	70e6                	ld	ra,120(sp)
    1500:	7446                	ld	s0,112(sp)
    1502:	74a6                	ld	s1,104(sp)
    1504:	7906                	ld	s2,96(sp)
    1506:	69e6                	ld	s3,88(sp)
    1508:	6a46                	ld	s4,80(sp)
    150a:	6aa6                	ld	s5,72(sp)
    150c:	6b06                	ld	s6,64(sp)
    150e:	7be2                	ld	s7,56(sp)
    1510:	6129                	addi	sp,sp,192
    1512:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1514:	00064783          	lbu	a5,0(a2)
    1518:	84b2                	mv	s1,a2
    151a:	01278963          	beq	a5,s2,152c <printf+0x1f0>
    151e:	bdb5                	j	139a <printf+0x5e>
    1520:	0024c783          	lbu	a5,2(s1)
    1524:	0605                	addi	a2,a2,1
    1526:	0489                	addi	s1,s1,2
    1528:	e72799e3          	bne	a5,s2,139a <printf+0x5e>
    152c:	0014c783          	lbu	a5,1(s1)
    1530:	ff2788e3          	beq	a5,s2,1520 <printf+0x1e4>
        l = z - a;
    1534:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1538:	85aa                	mv	a1,a0
    153a:	8622                	mv	a2,s0
    153c:	4505                	li	a0,1
    153e:	74a000ef          	jal	1c88 <write>
        if (l)
    1542:	e60405e3          	beqz	s0,13ac <printf+0x70>
    1546:	8526                	mv	a0,s1
    1548:	bd2d                	j	1382 <printf+0x46>
        switch (s[1])
    154a:	05579963          	bne	a5,s5,159c <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    154e:	6782                	ld	a5,0(sp)
    1550:	45c1                	li	a1,16
    1552:	4388                	lw	a0,0(a5)
    1554:	07a1                	addi	a5,a5,8
    1556:	e03e                	sd	a5,0(sp)
    1558:	b6bff0ef          	jal	10c2 <printint.constprop.0>
        s += 2;
    155c:	00248513          	addi	a0,s1,2
    1560:	bf59                	j	14f6 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1562:	6782                	ld	a5,0(sp)
    1564:	45a9                	li	a1,10
    1566:	4388                	lw	a0,0(a5)
    1568:	07a1                	addi	a5,a5,8
    156a:	e03e                	sd	a5,0(sp)
    156c:	b57ff0ef          	jal	10c2 <printint.constprop.0>
        s += 2;
    1570:	00248513          	addi	a0,s1,2
    1574:	b749                	j	14f6 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1576:	6782                	ld	a5,0(sp)
    1578:	6380                	ld	s0,0(a5)
    157a:	07a1                	addi	a5,a5,8
    157c:	e03e                	sd	a5,0(sp)
    157e:	c031                	beqz	s0,15c2 <printf+0x286>
            l = strnlen(a, 200);
    1580:	0c800593          	li	a1,200
    1584:	8522                	mv	a0,s0
    1586:	40a000ef          	jal	1990 <strnlen>
    write(f, s, l);
    158a:	0005061b          	sext.w	a2,a0
    158e:	85a2                	mv	a1,s0
    1590:	4505                	li	a0,1
    1592:	6f6000ef          	jal	1c88 <write>
        s += 2;
    1596:	00248513          	addi	a0,s1,2
    159a:	bfb1                	j	14f6 <printf+0x1ba>
    return write(stdout, &byte, 1);
    159c:	4605                	li	a2,1
    159e:	002c                	addi	a1,sp,8
    15a0:	4505                	li	a0,1
    char byte = c;
    15a2:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15a6:	6e2000ef          	jal	1c88 <write>
    char byte = c;
    15aa:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15ae:	4605                	li	a2,1
    15b0:	002c                	addi	a1,sp,8
    15b2:	4505                	li	a0,1
    char byte = c;
    15b4:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15b8:	6d0000ef          	jal	1c88 <write>
        s += 2;
    15bc:	00248513          	addi	a0,s1,2
    15c0:	bf1d                	j	14f6 <printf+0x1ba>
                a = "(null)";
    15c2:	845e                	mv	s0,s7
    15c4:	bf75                	j	1580 <printf+0x244>

00000000000015c6 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15c6:	1141                	addi	sp,sp,-16
    15c8:	e406                	sd	ra,8(sp)
    puts(m);
    15ca:	d51ff0ef          	jal	131a <puts>
    exit(-100);
}
    15ce:	60a2                	ld	ra,8(sp)
    exit(-100);
    15d0:	f9c00513          	li	a0,-100
}
    15d4:	0141                	addi	sp,sp,16
    exit(-100);
    15d6:	a709                	j	1cd8 <exit>

00000000000015d8 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15d8:	02000793          	li	a5,32
    15dc:	00f50663          	beq	a0,a5,15e8 <isspace+0x10>
    15e0:	355d                	addiw	a0,a0,-9
    15e2:	00553513          	sltiu	a0,a0,5
    15e6:	8082                	ret
    15e8:	4505                	li	a0,1
}
    15ea:	8082                	ret

00000000000015ec <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15ec:	fd05051b          	addiw	a0,a0,-48
}
    15f0:	00a53513          	sltiu	a0,a0,10
    15f4:	8082                	ret

00000000000015f6 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15f6:	02000613          	li	a2,32
    15fa:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15fc:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1600:	ff77069b          	addiw	a3,a4,-9
    1604:	04c70d63          	beq	a4,a2,165e <atoi+0x68>
    1608:	0007079b          	sext.w	a5,a4
    160c:	04d5f963          	bgeu	a1,a3,165e <atoi+0x68>
        s++;
    switch (*s)
    1610:	02b00693          	li	a3,43
    1614:	04d70a63          	beq	a4,a3,1668 <atoi+0x72>
    1618:	02d00693          	li	a3,45
    161c:	06d70463          	beq	a4,a3,1684 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1620:	fd07859b          	addiw	a1,a5,-48
    1624:	4625                	li	a2,9
    1626:	873e                	mv	a4,a5
    1628:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    162a:	4e01                	li	t3,0
    while (isdigit(*s))
    162c:	04b66a63          	bltu	a2,a1,1680 <atoi+0x8a>
    int n = 0, neg = 0;
    1630:	4501                	li	a0,0
    while (isdigit(*s))
    1632:	4825                	li	a6,9
    1634:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1638:	0025179b          	slliw	a5,a0,0x2
    163c:	9d3d                	addw	a0,a0,a5
    163e:	fd07031b          	addiw	t1,a4,-48
    1642:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1646:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    164a:	0685                	addi	a3,a3,1
    164c:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1650:	0006071b          	sext.w	a4,a2
    1654:	feb870e3          	bgeu	a6,a1,1634 <atoi+0x3e>
    return neg ? n : -n;
    1658:	000e0563          	beqz	t3,1662 <atoi+0x6c>
}
    165c:	8082                	ret
        s++;
    165e:	0505                	addi	a0,a0,1
    1660:	bf71                	j	15fc <atoi+0x6>
    return neg ? n : -n;
    1662:	4113053b          	subw	a0,t1,a7
    1666:	8082                	ret
    while (isdigit(*s))
    1668:	00154783          	lbu	a5,1(a0)
    166c:	4625                	li	a2,9
        s++;
    166e:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1672:	fd07859b          	addiw	a1,a5,-48
    1676:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    167a:	4e01                	li	t3,0
    while (isdigit(*s))
    167c:	fab67ae3          	bgeu	a2,a1,1630 <atoi+0x3a>
    1680:	4501                	li	a0,0
}
    1682:	8082                	ret
    while (isdigit(*s))
    1684:	00154783          	lbu	a5,1(a0)
    1688:	4625                	li	a2,9
        s++;
    168a:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    168e:	fd07859b          	addiw	a1,a5,-48
    1692:	0007871b          	sext.w	a4,a5
    1696:	feb665e3          	bltu	a2,a1,1680 <atoi+0x8a>
        neg = 1;
    169a:	4e05                	li	t3,1
    169c:	bf51                	j	1630 <atoi+0x3a>

000000000000169e <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    169e:	16060d63          	beqz	a2,1818 <memset+0x17a>
    16a2:	40a007b3          	neg	a5,a0
    16a6:	8b9d                	andi	a5,a5,7
    16a8:	00778713          	addi	a4,a5,7
    16ac:	482d                	li	a6,11
    16ae:	0ff5f593          	zext.b	a1,a1
    16b2:	fff60693          	addi	a3,a2,-1
    16b6:	17076263          	bltu	a4,a6,181a <memset+0x17c>
    16ba:	16e6ea63          	bltu	a3,a4,182e <memset+0x190>
    16be:	16078563          	beqz	a5,1828 <memset+0x18a>
    16c2:	00b50023          	sb	a1,0(a0)
    16c6:	4705                	li	a4,1
    16c8:	00150e93          	addi	t4,a0,1
    16cc:	14e78c63          	beq	a5,a4,1824 <memset+0x186>
    16d0:	00b500a3          	sb	a1,1(a0)
    16d4:	4709                	li	a4,2
    16d6:	00250e93          	addi	t4,a0,2
    16da:	14e78d63          	beq	a5,a4,1834 <memset+0x196>
    16de:	00b50123          	sb	a1,2(a0)
    16e2:	470d                	li	a4,3
    16e4:	00350e93          	addi	t4,a0,3
    16e8:	12e78b63          	beq	a5,a4,181e <memset+0x180>
    16ec:	00b501a3          	sb	a1,3(a0)
    16f0:	4711                	li	a4,4
    16f2:	00450e93          	addi	t4,a0,4
    16f6:	14e78163          	beq	a5,a4,1838 <memset+0x19a>
    16fa:	00b50223          	sb	a1,4(a0)
    16fe:	4715                	li	a4,5
    1700:	00550e93          	addi	t4,a0,5
    1704:	12e78c63          	beq	a5,a4,183c <memset+0x19e>
    1708:	00b502a3          	sb	a1,5(a0)
    170c:	471d                	li	a4,7
    170e:	00650e93          	addi	t4,a0,6
    1712:	12e79763          	bne	a5,a4,1840 <memset+0x1a2>
    1716:	00750e93          	addi	t4,a0,7
    171a:	00b50323          	sb	a1,6(a0)
    171e:	4f1d                	li	t5,7
    1720:	00859713          	slli	a4,a1,0x8
    1724:	8f4d                	or	a4,a4,a1
    1726:	01059e13          	slli	t3,a1,0x10
    172a:	01c76e33          	or	t3,a4,t3
    172e:	01859313          	slli	t1,a1,0x18
    1732:	006e6333          	or	t1,t3,t1
    1736:	02059893          	slli	a7,a1,0x20
    173a:	011368b3          	or	a7,t1,a7
    173e:	02859813          	slli	a6,a1,0x28
    1742:	40f60333          	sub	t1,a2,a5
    1746:	0108e833          	or	a6,a7,a6
    174a:	03059693          	slli	a3,a1,0x30
    174e:	00d866b3          	or	a3,a6,a3
    1752:	03859713          	slli	a4,a1,0x38
    1756:	97aa                	add	a5,a5,a0
    1758:	ff837813          	andi	a6,t1,-8
    175c:	8f55                	or	a4,a4,a3
    175e:	00f806b3          	add	a3,a6,a5
    1762:	e398                	sd	a4,0(a5)
    1764:	07a1                	addi	a5,a5,8
    1766:	fed79ee3          	bne	a5,a3,1762 <memset+0xc4>
    176a:	ff837693          	andi	a3,t1,-8
    176e:	00de87b3          	add	a5,t4,a3
    1772:	01e6873b          	addw	a4,a3,t5
    1776:	0ad30663          	beq	t1,a3,1822 <memset+0x184>
    177a:	00b78023          	sb	a1,0(a5)
    177e:	0017069b          	addiw	a3,a4,1
    1782:	08c6fb63          	bgeu	a3,a2,1818 <memset+0x17a>
    1786:	00b780a3          	sb	a1,1(a5)
    178a:	0027069b          	addiw	a3,a4,2
    178e:	08c6f563          	bgeu	a3,a2,1818 <memset+0x17a>
    1792:	00b78123          	sb	a1,2(a5)
    1796:	0037069b          	addiw	a3,a4,3
    179a:	06c6ff63          	bgeu	a3,a2,1818 <memset+0x17a>
    179e:	00b781a3          	sb	a1,3(a5)
    17a2:	0047069b          	addiw	a3,a4,4
    17a6:	06c6f963          	bgeu	a3,a2,1818 <memset+0x17a>
    17aa:	00b78223          	sb	a1,4(a5)
    17ae:	0057069b          	addiw	a3,a4,5
    17b2:	06c6f363          	bgeu	a3,a2,1818 <memset+0x17a>
    17b6:	00b782a3          	sb	a1,5(a5)
    17ba:	0067069b          	addiw	a3,a4,6
    17be:	04c6fd63          	bgeu	a3,a2,1818 <memset+0x17a>
    17c2:	00b78323          	sb	a1,6(a5)
    17c6:	0077069b          	addiw	a3,a4,7
    17ca:	04c6f763          	bgeu	a3,a2,1818 <memset+0x17a>
    17ce:	00b783a3          	sb	a1,7(a5)
    17d2:	0087069b          	addiw	a3,a4,8
    17d6:	04c6f163          	bgeu	a3,a2,1818 <memset+0x17a>
    17da:	00b78423          	sb	a1,8(a5)
    17de:	0097069b          	addiw	a3,a4,9
    17e2:	02c6fb63          	bgeu	a3,a2,1818 <memset+0x17a>
    17e6:	00b784a3          	sb	a1,9(a5)
    17ea:	00a7069b          	addiw	a3,a4,10
    17ee:	02c6f563          	bgeu	a3,a2,1818 <memset+0x17a>
    17f2:	00b78523          	sb	a1,10(a5)
    17f6:	00b7069b          	addiw	a3,a4,11
    17fa:	00c6ff63          	bgeu	a3,a2,1818 <memset+0x17a>
    17fe:	00b785a3          	sb	a1,11(a5)
    1802:	00c7069b          	addiw	a3,a4,12
    1806:	00c6f963          	bgeu	a3,a2,1818 <memset+0x17a>
    180a:	00b78623          	sb	a1,12(a5)
    180e:	2735                	addiw	a4,a4,13
    1810:	00c77463          	bgeu	a4,a2,1818 <memset+0x17a>
    1814:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1818:	8082                	ret
    181a:	472d                	li	a4,11
    181c:	bd79                	j	16ba <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    181e:	4f0d                	li	t5,3
    1820:	b701                	j	1720 <memset+0x82>
    1822:	8082                	ret
    1824:	4f05                	li	t5,1
    1826:	bded                	j	1720 <memset+0x82>
    1828:	8eaa                	mv	t4,a0
    182a:	4f01                	li	t5,0
    182c:	bdd5                	j	1720 <memset+0x82>
    182e:	87aa                	mv	a5,a0
    1830:	4701                	li	a4,0
    1832:	b7a1                	j	177a <memset+0xdc>
    1834:	4f09                	li	t5,2
    1836:	b5ed                	j	1720 <memset+0x82>
    1838:	4f11                	li	t5,4
    183a:	b5dd                	j	1720 <memset+0x82>
    183c:	4f15                	li	t5,5
    183e:	b5cd                	j	1720 <memset+0x82>
    1840:	4f19                	li	t5,6
    1842:	bdf9                	j	1720 <memset+0x82>

0000000000001844 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1844:	00054783          	lbu	a5,0(a0)
    1848:	0005c703          	lbu	a4,0(a1)
    184c:	00e79863          	bne	a5,a4,185c <strcmp+0x18>
    1850:	0505                	addi	a0,a0,1
    1852:	0585                	addi	a1,a1,1
    1854:	fbe5                	bnez	a5,1844 <strcmp>
    1856:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1858:	9d19                	subw	a0,a0,a4
    185a:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    185c:	0007851b          	sext.w	a0,a5
    1860:	bfe5                	j	1858 <strcmp+0x14>

0000000000001862 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1862:	ce05                	beqz	a2,189a <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1864:	00054703          	lbu	a4,0(a0)
    1868:	0005c783          	lbu	a5,0(a1)
    186c:	cb0d                	beqz	a4,189e <strncmp+0x3c>
    if (!n--)
    186e:	167d                	addi	a2,a2,-1
    1870:	00c506b3          	add	a3,a0,a2
    1874:	a819                	j	188a <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1876:	00a68e63          	beq	a3,a0,1892 <strncmp+0x30>
    187a:	0505                	addi	a0,a0,1
    187c:	00e79b63          	bne	a5,a4,1892 <strncmp+0x30>
    1880:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    1884:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1888:	cb19                	beqz	a4,189e <strncmp+0x3c>
    188a:	0005c783          	lbu	a5,0(a1)
    188e:	0585                	addi	a1,a1,1
    1890:	f3fd                	bnez	a5,1876 <strncmp+0x14>
    return *l - *r;
    1892:	0007051b          	sext.w	a0,a4
    1896:	9d1d                	subw	a0,a0,a5
    1898:	8082                	ret
        return 0;
    189a:	4501                	li	a0,0
}
    189c:	8082                	ret
    189e:	4501                	li	a0,0
    return *l - *r;
    18a0:	9d1d                	subw	a0,a0,a5
    18a2:	8082                	ret

00000000000018a4 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18a4:	00757793          	andi	a5,a0,7
    18a8:	cf89                	beqz	a5,18c2 <strlen+0x1e>
    18aa:	87aa                	mv	a5,a0
    18ac:	a029                	j	18b6 <strlen+0x12>
    18ae:	0785                	addi	a5,a5,1
    18b0:	0077f713          	andi	a4,a5,7
    18b4:	cb01                	beqz	a4,18c4 <strlen+0x20>
        if (!*s)
    18b6:	0007c703          	lbu	a4,0(a5)
    18ba:	fb75                	bnez	a4,18ae <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18bc:	40a78533          	sub	a0,a5,a0
}
    18c0:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18c2:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18c4:	6394                	ld	a3,0(a5)
    18c6:	00000597          	auipc	a1,0x0
    18ca:	6ba5b583          	ld	a1,1722(a1) # 1f80 <__clone+0xc0>
    18ce:	00000617          	auipc	a2,0x0
    18d2:	6ba63603          	ld	a2,1722(a2) # 1f88 <__clone+0xc8>
    18d6:	a019                	j	18dc <strlen+0x38>
    18d8:	6794                	ld	a3,8(a5)
    18da:	07a1                	addi	a5,a5,8
    18dc:	00b68733          	add	a4,a3,a1
    18e0:	fff6c693          	not	a3,a3
    18e4:	8f75                	and	a4,a4,a3
    18e6:	8f71                	and	a4,a4,a2
    18e8:	db65                	beqz	a4,18d8 <strlen+0x34>
    for (; *s; s++)
    18ea:	0007c703          	lbu	a4,0(a5)
    18ee:	d779                	beqz	a4,18bc <strlen+0x18>
    18f0:	0017c703          	lbu	a4,1(a5)
    18f4:	0785                	addi	a5,a5,1
    18f6:	d379                	beqz	a4,18bc <strlen+0x18>
    18f8:	0017c703          	lbu	a4,1(a5)
    18fc:	0785                	addi	a5,a5,1
    18fe:	fb6d                	bnez	a4,18f0 <strlen+0x4c>
    1900:	bf75                	j	18bc <strlen+0x18>

0000000000001902 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1902:	00757713          	andi	a4,a0,7
{
    1906:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1908:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    190c:	cb19                	beqz	a4,1922 <memchr+0x20>
    190e:	ce25                	beqz	a2,1986 <memchr+0x84>
    1910:	0007c703          	lbu	a4,0(a5)
    1914:	04b70e63          	beq	a4,a1,1970 <memchr+0x6e>
    1918:	0785                	addi	a5,a5,1
    191a:	0077f713          	andi	a4,a5,7
    191e:	167d                	addi	a2,a2,-1
    1920:	f77d                	bnez	a4,190e <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1922:	4501                	li	a0,0
    if (n && *s != c)
    1924:	c235                	beqz	a2,1988 <memchr+0x86>
    1926:	0007c703          	lbu	a4,0(a5)
    192a:	04b70363          	beq	a4,a1,1970 <memchr+0x6e>
        size_t k = ONES * c;
    192e:	00000517          	auipc	a0,0x0
    1932:	66253503          	ld	a0,1634(a0) # 1f90 <__clone+0xd0>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1936:	471d                	li	a4,7
        size_t k = ONES * c;
    1938:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    193c:	02c77a63          	bgeu	a4,a2,1970 <memchr+0x6e>
    1940:	00000897          	auipc	a7,0x0
    1944:	6408b883          	ld	a7,1600(a7) # 1f80 <__clone+0xc0>
    1948:	00000817          	auipc	a6,0x0
    194c:	64083803          	ld	a6,1600(a6) # 1f88 <__clone+0xc8>
    1950:	431d                	li	t1,7
    1952:	a029                	j	195c <memchr+0x5a>
    1954:	1661                	addi	a2,a2,-8
    1956:	07a1                	addi	a5,a5,8
    1958:	02c37963          	bgeu	t1,a2,198a <memchr+0x88>
    195c:	6398                	ld	a4,0(a5)
    195e:	8f29                	xor	a4,a4,a0
    1960:	011706b3          	add	a3,a4,a7
    1964:	fff74713          	not	a4,a4
    1968:	8f75                	and	a4,a4,a3
    196a:	01077733          	and	a4,a4,a6
    196e:	d37d                	beqz	a4,1954 <memchr+0x52>
    1970:	853e                	mv	a0,a5
    1972:	97b2                	add	a5,a5,a2
    1974:	a021                	j	197c <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1976:	0505                	addi	a0,a0,1
    1978:	00f50763          	beq	a0,a5,1986 <memchr+0x84>
    197c:	00054703          	lbu	a4,0(a0)
    1980:	feb71be3          	bne	a4,a1,1976 <memchr+0x74>
    1984:	8082                	ret
    return n ? (void *)s : 0;
    1986:	4501                	li	a0,0
}
    1988:	8082                	ret
    return n ? (void *)s : 0;
    198a:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    198c:	f275                	bnez	a2,1970 <memchr+0x6e>
}
    198e:	8082                	ret

0000000000001990 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1990:	1101                	addi	sp,sp,-32
    1992:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1994:	862e                	mv	a2,a1
{
    1996:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1998:	4581                	li	a1,0
{
    199a:	e426                	sd	s1,8(sp)
    199c:	ec06                	sd	ra,24(sp)
    199e:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19a0:	f63ff0ef          	jal	1902 <memchr>
    return p ? p - s : n;
    19a4:	c519                	beqz	a0,19b2 <strnlen+0x22>
}
    19a6:	60e2                	ld	ra,24(sp)
    19a8:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19aa:	8d05                	sub	a0,a0,s1
}
    19ac:	64a2                	ld	s1,8(sp)
    19ae:	6105                	addi	sp,sp,32
    19b0:	8082                	ret
    19b2:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19b4:	8522                	mv	a0,s0
}
    19b6:	6442                	ld	s0,16(sp)
    19b8:	64a2                	ld	s1,8(sp)
    19ba:	6105                	addi	sp,sp,32
    19bc:	8082                	ret

00000000000019be <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19be:	00b547b3          	xor	a5,a0,a1
    19c2:	8b9d                	andi	a5,a5,7
    19c4:	eb95                	bnez	a5,19f8 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19c6:	0075f793          	andi	a5,a1,7
    19ca:	e7b1                	bnez	a5,1a16 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19cc:	6198                	ld	a4,0(a1)
    19ce:	00000617          	auipc	a2,0x0
    19d2:	5b263603          	ld	a2,1458(a2) # 1f80 <__clone+0xc0>
    19d6:	00000817          	auipc	a6,0x0
    19da:	5b283803          	ld	a6,1458(a6) # 1f88 <__clone+0xc8>
    19de:	a029                	j	19e8 <strcpy+0x2a>
    19e0:	e118                	sd	a4,0(a0)
    19e2:	6598                	ld	a4,8(a1)
    19e4:	05a1                	addi	a1,a1,8
    19e6:	0521                	addi	a0,a0,8
    19e8:	00c707b3          	add	a5,a4,a2
    19ec:	fff74693          	not	a3,a4
    19f0:	8ff5                	and	a5,a5,a3
    19f2:	0107f7b3          	and	a5,a5,a6
    19f6:	d7ed                	beqz	a5,19e0 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19f8:	0005c783          	lbu	a5,0(a1)
    19fc:	00f50023          	sb	a5,0(a0)
    1a00:	c785                	beqz	a5,1a28 <strcpy+0x6a>
    1a02:	0015c783          	lbu	a5,1(a1)
    1a06:	0505                	addi	a0,a0,1
    1a08:	0585                	addi	a1,a1,1
    1a0a:	00f50023          	sb	a5,0(a0)
    1a0e:	fbf5                	bnez	a5,1a02 <strcpy+0x44>
        ;
    return d;
}
    1a10:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a12:	0505                	addi	a0,a0,1
    1a14:	df45                	beqz	a4,19cc <strcpy+0xe>
            if (!(*d = *s))
    1a16:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a1a:	0585                	addi	a1,a1,1
    1a1c:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a20:	00f50023          	sb	a5,0(a0)
    1a24:	f7fd                	bnez	a5,1a12 <strcpy+0x54>
}
    1a26:	8082                	ret
    1a28:	8082                	ret

0000000000001a2a <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a2a:	00b547b3          	xor	a5,a0,a1
    1a2e:	8b9d                	andi	a5,a5,7
    1a30:	1a079863          	bnez	a5,1be0 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a34:	0075f793          	andi	a5,a1,7
    1a38:	16078463          	beqz	a5,1ba0 <strncpy+0x176>
    1a3c:	ea01                	bnez	a2,1a4c <strncpy+0x22>
    1a3e:	a421                	j	1c46 <strncpy+0x21c>
    1a40:	167d                	addi	a2,a2,-1
    1a42:	0505                	addi	a0,a0,1
    1a44:	14070e63          	beqz	a4,1ba0 <strncpy+0x176>
    1a48:	1a060863          	beqz	a2,1bf8 <strncpy+0x1ce>
    1a4c:	0005c783          	lbu	a5,0(a1)
    1a50:	0585                	addi	a1,a1,1
    1a52:	0075f713          	andi	a4,a1,7
    1a56:	00f50023          	sb	a5,0(a0)
    1a5a:	f3fd                	bnez	a5,1a40 <strncpy+0x16>
    1a5c:	4805                	li	a6,1
    1a5e:	1a061863          	bnez	a2,1c0e <strncpy+0x1e4>
    1a62:	40a007b3          	neg	a5,a0
    1a66:	8b9d                	andi	a5,a5,7
    1a68:	4681                	li	a3,0
    1a6a:	18061a63          	bnez	a2,1bfe <strncpy+0x1d4>
    1a6e:	00778713          	addi	a4,a5,7
    1a72:	45ad                	li	a1,11
    1a74:	18b76363          	bltu	a4,a1,1bfa <strncpy+0x1d0>
    1a78:	1ae6eb63          	bltu	a3,a4,1c2e <strncpy+0x204>
    1a7c:	1a078363          	beqz	a5,1c22 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a80:	00050023          	sb	zero,0(a0)
    1a84:	4685                	li	a3,1
    1a86:	00150713          	addi	a4,a0,1
    1a8a:	18d78f63          	beq	a5,a3,1c28 <strncpy+0x1fe>
    1a8e:	000500a3          	sb	zero,1(a0)
    1a92:	4689                	li	a3,2
    1a94:	00250713          	addi	a4,a0,2
    1a98:	18d78e63          	beq	a5,a3,1c34 <strncpy+0x20a>
    1a9c:	00050123          	sb	zero,2(a0)
    1aa0:	468d                	li	a3,3
    1aa2:	00350713          	addi	a4,a0,3
    1aa6:	16d78c63          	beq	a5,a3,1c1e <strncpy+0x1f4>
    1aaa:	000501a3          	sb	zero,3(a0)
    1aae:	4691                	li	a3,4
    1ab0:	00450713          	addi	a4,a0,4
    1ab4:	18d78263          	beq	a5,a3,1c38 <strncpy+0x20e>
    1ab8:	00050223          	sb	zero,4(a0)
    1abc:	4695                	li	a3,5
    1abe:	00550713          	addi	a4,a0,5
    1ac2:	16d78d63          	beq	a5,a3,1c3c <strncpy+0x212>
    1ac6:	000502a3          	sb	zero,5(a0)
    1aca:	469d                	li	a3,7
    1acc:	00650713          	addi	a4,a0,6
    1ad0:	16d79863          	bne	a5,a3,1c40 <strncpy+0x216>
    1ad4:	00750713          	addi	a4,a0,7
    1ad8:	00050323          	sb	zero,6(a0)
    1adc:	40f80833          	sub	a6,a6,a5
    1ae0:	ff887593          	andi	a1,a6,-8
    1ae4:	97aa                	add	a5,a5,a0
    1ae6:	95be                	add	a1,a1,a5
    1ae8:	0007b023          	sd	zero,0(a5)
    1aec:	07a1                	addi	a5,a5,8
    1aee:	feb79de3          	bne	a5,a1,1ae8 <strncpy+0xbe>
    1af2:	ff887593          	andi	a1,a6,-8
    1af6:	9ead                	addw	a3,a3,a1
    1af8:	00b707b3          	add	a5,a4,a1
    1afc:	12b80863          	beq	a6,a1,1c2c <strncpy+0x202>
    1b00:	00078023          	sb	zero,0(a5)
    1b04:	0016871b          	addiw	a4,a3,1
    1b08:	0ec77863          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b0c:	000780a3          	sb	zero,1(a5)
    1b10:	0026871b          	addiw	a4,a3,2
    1b14:	0ec77263          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b18:	00078123          	sb	zero,2(a5)
    1b1c:	0036871b          	addiw	a4,a3,3
    1b20:	0cc77c63          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b24:	000781a3          	sb	zero,3(a5)
    1b28:	0046871b          	addiw	a4,a3,4
    1b2c:	0cc77663          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b30:	00078223          	sb	zero,4(a5)
    1b34:	0056871b          	addiw	a4,a3,5
    1b38:	0cc77063          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b3c:	000782a3          	sb	zero,5(a5)
    1b40:	0066871b          	addiw	a4,a3,6
    1b44:	0ac77a63          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b48:	00078323          	sb	zero,6(a5)
    1b4c:	0076871b          	addiw	a4,a3,7
    1b50:	0ac77463          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b54:	000783a3          	sb	zero,7(a5)
    1b58:	0086871b          	addiw	a4,a3,8
    1b5c:	08c77e63          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b60:	00078423          	sb	zero,8(a5)
    1b64:	0096871b          	addiw	a4,a3,9
    1b68:	08c77863          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b6c:	000784a3          	sb	zero,9(a5)
    1b70:	00a6871b          	addiw	a4,a3,10
    1b74:	08c77263          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b78:	00078523          	sb	zero,10(a5)
    1b7c:	00b6871b          	addiw	a4,a3,11
    1b80:	06c77c63          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b84:	000785a3          	sb	zero,11(a5)
    1b88:	00c6871b          	addiw	a4,a3,12
    1b8c:	06c77663          	bgeu	a4,a2,1bf8 <strncpy+0x1ce>
    1b90:	00078623          	sb	zero,12(a5)
    1b94:	26b5                	addiw	a3,a3,13
    1b96:	06c6f163          	bgeu	a3,a2,1bf8 <strncpy+0x1ce>
    1b9a:	000786a3          	sb	zero,13(a5)
    1b9e:	8082                	ret
            ;
        if (!n || !*s)
    1ba0:	c645                	beqz	a2,1c48 <strncpy+0x21e>
    1ba2:	0005c783          	lbu	a5,0(a1)
    1ba6:	ea078be3          	beqz	a5,1a5c <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1baa:	479d                	li	a5,7
    1bac:	02c7ff63          	bgeu	a5,a2,1bea <strncpy+0x1c0>
    1bb0:	00000897          	auipc	a7,0x0
    1bb4:	3d08b883          	ld	a7,976(a7) # 1f80 <__clone+0xc0>
    1bb8:	00000817          	auipc	a6,0x0
    1bbc:	3d083803          	ld	a6,976(a6) # 1f88 <__clone+0xc8>
    1bc0:	431d                	li	t1,7
    1bc2:	6198                	ld	a4,0(a1)
    1bc4:	011707b3          	add	a5,a4,a7
    1bc8:	fff74693          	not	a3,a4
    1bcc:	8ff5                	and	a5,a5,a3
    1bce:	0107f7b3          	and	a5,a5,a6
    1bd2:	ef81                	bnez	a5,1bea <strncpy+0x1c0>
            *wd = *ws;
    1bd4:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bd6:	1661                	addi	a2,a2,-8
    1bd8:	05a1                	addi	a1,a1,8
    1bda:	0521                	addi	a0,a0,8
    1bdc:	fec363e3          	bltu	t1,a2,1bc2 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1be0:	e609                	bnez	a2,1bea <strncpy+0x1c0>
    1be2:	a08d                	j	1c44 <strncpy+0x21a>
    1be4:	167d                	addi	a2,a2,-1
    1be6:	0505                	addi	a0,a0,1
    1be8:	ca01                	beqz	a2,1bf8 <strncpy+0x1ce>
    1bea:	0005c783          	lbu	a5,0(a1)
    1bee:	0585                	addi	a1,a1,1
    1bf0:	00f50023          	sb	a5,0(a0)
    1bf4:	fbe5                	bnez	a5,1be4 <strncpy+0x1ba>
        ;
tail:
    1bf6:	b59d                	j	1a5c <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bf8:	8082                	ret
    1bfa:	472d                	li	a4,11
    1bfc:	bdb5                	j	1a78 <strncpy+0x4e>
    1bfe:	00778713          	addi	a4,a5,7
    1c02:	45ad                	li	a1,11
    1c04:	fff60693          	addi	a3,a2,-1
    1c08:	e6b778e3          	bgeu	a4,a1,1a78 <strncpy+0x4e>
    1c0c:	b7fd                	j	1bfa <strncpy+0x1d0>
    1c0e:	40a007b3          	neg	a5,a0
    1c12:	8832                	mv	a6,a2
    1c14:	8b9d                	andi	a5,a5,7
    1c16:	4681                	li	a3,0
    1c18:	e4060be3          	beqz	a2,1a6e <strncpy+0x44>
    1c1c:	b7cd                	j	1bfe <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c1e:	468d                	li	a3,3
    1c20:	bd75                	j	1adc <strncpy+0xb2>
    1c22:	872a                	mv	a4,a0
    1c24:	4681                	li	a3,0
    1c26:	bd5d                	j	1adc <strncpy+0xb2>
    1c28:	4685                	li	a3,1
    1c2a:	bd4d                	j	1adc <strncpy+0xb2>
    1c2c:	8082                	ret
    1c2e:	87aa                	mv	a5,a0
    1c30:	4681                	li	a3,0
    1c32:	b5f9                	j	1b00 <strncpy+0xd6>
    1c34:	4689                	li	a3,2
    1c36:	b55d                	j	1adc <strncpy+0xb2>
    1c38:	4691                	li	a3,4
    1c3a:	b54d                	j	1adc <strncpy+0xb2>
    1c3c:	4695                	li	a3,5
    1c3e:	bd79                	j	1adc <strncpy+0xb2>
    1c40:	4699                	li	a3,6
    1c42:	bd69                	j	1adc <strncpy+0xb2>
    1c44:	8082                	ret
    1c46:	8082                	ret
    1c48:	8082                	ret

0000000000001c4a <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c4a:	87aa                	mv	a5,a0
    1c4c:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c4e:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c52:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c56:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c58:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c5a:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c5e:	2501                	sext.w	a0,a0
    1c60:	8082                	ret

0000000000001c62 <openat>:
    register long a7 __asm__("a7") = n;
    1c62:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c66:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c6a:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c6e:	2501                	sext.w	a0,a0
    1c70:	8082                	ret

0000000000001c72 <close>:
    register long a7 __asm__("a7") = n;
    1c72:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c76:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c7a:	2501                	sext.w	a0,a0
    1c7c:	8082                	ret

0000000000001c7e <read>:
    register long a7 __asm__("a7") = n;
    1c7e:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c82:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c86:	8082                	ret

0000000000001c88 <write>:
    register long a7 __asm__("a7") = n;
    1c88:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c8c:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c90:	8082                	ret

0000000000001c92 <getpid>:
    register long a7 __asm__("a7") = n;
    1c92:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c96:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c9a:	2501                	sext.w	a0,a0
    1c9c:	8082                	ret

0000000000001c9e <getppid>:
    register long a7 __asm__("a7") = n;
    1c9e:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1ca2:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1ca6:	2501                	sext.w	a0,a0
    1ca8:	8082                	ret

0000000000001caa <sched_yield>:
    register long a7 __asm__("a7") = n;
    1caa:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cae:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cb2:	2501                	sext.w	a0,a0
    1cb4:	8082                	ret

0000000000001cb6 <fork>:
    register long a7 __asm__("a7") = n;
    1cb6:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cba:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cbc:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cbe:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cc2:	2501                	sext.w	a0,a0
    1cc4:	8082                	ret

0000000000001cc6 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cc6:	85b2                	mv	a1,a2
    1cc8:	863a                	mv	a2,a4
    if (stack)
    1cca:	c191                	beqz	a1,1cce <clone+0x8>
	stack += stack_size;
    1ccc:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cce:	4781                	li	a5,0
    1cd0:	4701                	li	a4,0
    1cd2:	4681                	li	a3,0
    1cd4:	2601                	sext.w	a2,a2
    1cd6:	a2ed                	j	1ec0 <__clone>

0000000000001cd8 <exit>:
    register long a7 __asm__("a7") = n;
    1cd8:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cdc:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1ce0:	8082                	ret

0000000000001ce2 <waitpid>:
    register long a7 __asm__("a7") = n;
    1ce2:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1ce6:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ce8:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cec:	2501                	sext.w	a0,a0
    1cee:	8082                	ret

0000000000001cf0 <exec>:
    register long a7 __asm__("a7") = n;
    1cf0:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cf4:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cf8:	2501                	sext.w	a0,a0
    1cfa:	8082                	ret

0000000000001cfc <execve>:
    register long a7 __asm__("a7") = n;
    1cfc:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d00:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d04:	2501                	sext.w	a0,a0
    1d06:	8082                	ret

0000000000001d08 <times>:
    register long a7 __asm__("a7") = n;
    1d08:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d0c:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d10:	2501                	sext.w	a0,a0
    1d12:	8082                	ret

0000000000001d14 <get_time>:

int64 get_time()
{
    1d14:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d16:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d1a:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d1c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d1e:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d22:	2501                	sext.w	a0,a0
    1d24:	ed09                	bnez	a0,1d3e <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d26:	67a2                	ld	a5,8(sp)
    1d28:	3e800713          	li	a4,1000
    1d2c:	00015503          	lhu	a0,0(sp)
    1d30:	02e7d7b3          	divu	a5,a5,a4
    1d34:	02e50533          	mul	a0,a0,a4
    1d38:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d3a:	0141                	addi	sp,sp,16
    1d3c:	8082                	ret
        return -1;
    1d3e:	557d                	li	a0,-1
    1d40:	bfed                	j	1d3a <get_time+0x26>

0000000000001d42 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d42:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d46:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d4a:	2501                	sext.w	a0,a0
    1d4c:	8082                	ret

0000000000001d4e <time>:
    register long a7 __asm__("a7") = n;
    1d4e:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d52:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d56:	2501                	sext.w	a0,a0
    1d58:	8082                	ret

0000000000001d5a <sleep>:

int sleep(unsigned long long time)
{
    1d5a:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d5c:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d5e:	850a                	mv	a0,sp
    1d60:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d62:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d66:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d68:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d6c:	e501                	bnez	a0,1d74 <sleep+0x1a>
    return 0;
    1d6e:	4501                	li	a0,0
}
    1d70:	0141                	addi	sp,sp,16
    1d72:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d74:	4502                	lw	a0,0(sp)
}
    1d76:	0141                	addi	sp,sp,16
    1d78:	8082                	ret

0000000000001d7a <set_priority>:
    register long a7 __asm__("a7") = n;
    1d7a:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d7e:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d82:	2501                	sext.w	a0,a0
    1d84:	8082                	ret

0000000000001d86 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d86:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d8a:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d8e:	8082                	ret

0000000000001d90 <munmap>:
    register long a7 __asm__("a7") = n;
    1d90:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d94:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d98:	2501                	sext.w	a0,a0
    1d9a:	8082                	ret

0000000000001d9c <wait>:

int wait(int *code)
{
    1d9c:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d9e:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1da2:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1da4:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1da6:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1da8:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dac:	2501                	sext.w	a0,a0
    1dae:	8082                	ret

0000000000001db0 <spawn>:
    register long a7 __asm__("a7") = n;
    1db0:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1db4:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1db8:	2501                	sext.w	a0,a0
    1dba:	8082                	ret

0000000000001dbc <mailread>:
    register long a7 __asm__("a7") = n;
    1dbc:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dc0:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dc4:	2501                	sext.w	a0,a0
    1dc6:	8082                	ret

0000000000001dc8 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dc8:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dcc:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dd0:	2501                	sext.w	a0,a0
    1dd2:	8082                	ret

0000000000001dd4 <fstat>:
    register long a7 __asm__("a7") = n;
    1dd4:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd8:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1ddc:	2501                	sext.w	a0,a0
    1dde:	8082                	ret

0000000000001de0 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1de0:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1de2:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1de6:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1de8:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1dec:	2501                	sext.w	a0,a0
    1dee:	8082                	ret

0000000000001df0 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1df0:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1df2:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1df6:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1df8:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1dfc:	2501                	sext.w	a0,a0
    1dfe:	8082                	ret

0000000000001e00 <link>:

int link(char *old_path, char *new_path)
{
    1e00:	87aa                	mv	a5,a0
    1e02:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e04:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e08:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e0c:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e0e:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e12:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e14:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e18:	2501                	sext.w	a0,a0
    1e1a:	8082                	ret

0000000000001e1c <unlink>:

int unlink(char *path)
{
    1e1c:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e1e:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e22:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e26:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e28:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e2c:	2501                	sext.w	a0,a0
    1e2e:	8082                	ret

0000000000001e30 <uname>:
    register long a7 __asm__("a7") = n;
    1e30:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e34:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e38:	2501                	sext.w	a0,a0
    1e3a:	8082                	ret

0000000000001e3c <brk>:
    register long a7 __asm__("a7") = n;
    1e3c:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e40:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e44:	2501                	sext.w	a0,a0
    1e46:	8082                	ret

0000000000001e48 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e48:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e4a:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e4e:	8082                	ret

0000000000001e50 <chdir>:
    register long a7 __asm__("a7") = n;
    1e50:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e54:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e58:	2501                	sext.w	a0,a0
    1e5a:	8082                	ret

0000000000001e5c <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e5c:	862e                	mv	a2,a1
    1e5e:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e60:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e62:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e66:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e6a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e6c:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e6e:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e72:	2501                	sext.w	a0,a0
    1e74:	8082                	ret

0000000000001e76 <getdents>:
    register long a7 __asm__("a7") = n;
    1e76:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e7a:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e7e:	2501                	sext.w	a0,a0
    1e80:	8082                	ret

0000000000001e82 <pipe>:
    register long a7 __asm__("a7") = n;
    1e82:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e86:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e88:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e8c:	2501                	sext.w	a0,a0
    1e8e:	8082                	ret

0000000000001e90 <dup>:
    register long a7 __asm__("a7") = n;
    1e90:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e92:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e96:	2501                	sext.w	a0,a0
    1e98:	8082                	ret

0000000000001e9a <dup2>:
    register long a7 __asm__("a7") = n;
    1e9a:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e9c:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e9e:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ea2:	2501                	sext.w	a0,a0
    1ea4:	8082                	ret

0000000000001ea6 <mount>:
    register long a7 __asm__("a7") = n;
    1ea6:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1eaa:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1eae:	2501                	sext.w	a0,a0
    1eb0:	8082                	ret

0000000000001eb2 <umount>:
    register long a7 __asm__("a7") = n;
    1eb2:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1eb6:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eb8:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ebc:	2501                	sext.w	a0,a0
    1ebe:	8082                	ret

0000000000001ec0 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ec0:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ec2:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ec4:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ec6:	8532                	mv	a0,a2
	mv a2, a4
    1ec8:	863a                	mv	a2,a4
	mv a3, a5
    1eca:	86be                	mv	a3,a5
	mv a4, a6
    1ecc:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ece:	0dc00893          	li	a7,220
	ecall
    1ed2:	00000073          	ecall

	beqz a0, 1f
    1ed6:	c111                	beqz	a0,1eda <__clone+0x1a>
	# Parent
	ret
    1ed8:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1eda:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1edc:	6522                	ld	a0,8(sp)
	jalr a1
    1ede:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ee0:	05d00893          	li	a7,93
	ecall
    1ee4:	00000073          	ecall
