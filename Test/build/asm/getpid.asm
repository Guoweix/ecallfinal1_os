
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/getpid:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a061                	j	108a <__start_main>

0000000000001004 <test_getpid>:
/*
理想结果：得到进程 pid，注意要关注 pid 是否符合内核逻辑，不要单纯以 Test OK! 作为判断。
*/

int test_getpid()
{
    1004:	1101                	addi	sp,sp,-32
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	eca50513          	addi	a0,a0,-310 # 1ed0 <__clone+0x2e>
{
    100e:	ec06                	sd	ra,24(sp)
    TEST_START(__func__);
    1010:	2ec000ef          	jal	12fc <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	f5450513          	addi	a0,a0,-172 # 1f68 <__func__.0>
    101c:	2e0000ef          	jal	12fc <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ec850513          	addi	a0,a0,-312 # 1ee8 <__clone+0x46>
    1028:	2d4000ef          	jal	12fc <puts>
    int pid = getpid();
    102c:	449000ef          	jal	1c74 <getpid>
    1030:	85aa                	mv	a1,a0
    assert(pid >= 0);
    1032:	02054b63          	bltz	a0,1068 <test_getpid+0x64>
    printf("getpid success.\npid = %d\n", pid);
    1036:	00001517          	auipc	a0,0x1
    103a:	ee250513          	addi	a0,a0,-286 # 1f18 <__clone+0x76>
    103e:	2e0000ef          	jal	131e <printf>
    TEST_END(__func__);
    1042:	00001517          	auipc	a0,0x1
    1046:	ef650513          	addi	a0,a0,-266 # 1f38 <__clone+0x96>
    104a:	2b2000ef          	jal	12fc <puts>
    104e:	00001517          	auipc	a0,0x1
    1052:	f1a50513          	addi	a0,a0,-230 # 1f68 <__func__.0>
    1056:	2a6000ef          	jal	12fc <puts>
}
    105a:	60e2                	ld	ra,24(sp)
    TEST_END(__func__);
    105c:	00001517          	auipc	a0,0x1
    1060:	e8c50513          	addi	a0,a0,-372 # 1ee8 <__clone+0x46>
}
    1064:	6105                	addi	sp,sp,32
    TEST_END(__func__);
    1066:	ac59                	j	12fc <puts>
    1068:	e42a                	sd	a0,8(sp)
    assert(pid >= 0);
    106a:	00001517          	auipc	a0,0x1
    106e:	e8e50513          	addi	a0,a0,-370 # 1ef8 <__clone+0x56>
    1072:	536000ef          	jal	15a8 <panic>
    1076:	65a2                	ld	a1,8(sp)
    1078:	bf7d                	j	1036 <test_getpid+0x32>

000000000000107a <main>:

int main(void) {
    107a:	1141                	addi	sp,sp,-16
    107c:	e406                	sd	ra,8(sp)
	test_getpid();
    107e:	f87ff0ef          	jal	1004 <test_getpid>
	return 0;
}
    1082:	60a2                	ld	ra,8(sp)
    1084:	4501                	li	a0,0
    1086:	0141                	addi	sp,sp,16
    1088:	8082                	ret

000000000000108a <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    108a:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    108c:	4108                	lw	a0,0(a0)
{
    108e:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1090:	05a1                	addi	a1,a1,8
{
    1092:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    1094:	fe7ff0ef          	jal	107a <main>
    1098:	423000ef          	jal	1cba <exit>
	return 0;
}
    109c:	60a2                	ld	ra,8(sp)
    109e:	4501                	li	a0,0
    10a0:	0141                	addi	sp,sp,16
    10a2:	8082                	ret

00000000000010a4 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10a4:	7179                	addi	sp,sp,-48
    10a6:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10a8:	12054b63          	bltz	a0,11de <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10ac:	02b577bb          	remuw	a5,a0,a1
    10b0:	00001617          	auipc	a2,0x1
    10b4:	ec860613          	addi	a2,a2,-312 # 1f78 <digits>
    buf[16] = 0;
    10b8:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10bc:	0005871b          	sext.w	a4,a1
    10c0:	1782                	slli	a5,a5,0x20
    10c2:	9381                	srli	a5,a5,0x20
    10c4:	97b2                	add	a5,a5,a2
    10c6:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10ca:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10ce:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10d2:	1cb56363          	bltu	a0,a1,1298 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    10d6:	45b9                	li	a1,14
    10d8:	02e877bb          	remuw	a5,a6,a4
    10dc:	1782                	slli	a5,a5,0x20
    10de:	9381                	srli	a5,a5,0x20
    10e0:	97b2                	add	a5,a5,a2
    10e2:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10e6:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    10ea:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    10ee:	0ce86e63          	bltu	a6,a4,11ca <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    10f2:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    10f6:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    10fa:	1582                	slli	a1,a1,0x20
    10fc:	9181                	srli	a1,a1,0x20
    10fe:	95b2                	add	a1,a1,a2
    1100:	0005c583          	lbu	a1,0(a1)
    1104:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    1108:	0007859b          	sext.w	a1,a5
    110c:	12e6ec63          	bltu	a3,a4,1244 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1110:	02e7f6bb          	remuw	a3,a5,a4
    1114:	1682                	slli	a3,a3,0x20
    1116:	9281                	srli	a3,a3,0x20
    1118:	96b2                	add	a3,a3,a2
    111a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    111e:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1122:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1126:	12e5e863          	bltu	a1,a4,1256 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    112a:	02e876bb          	remuw	a3,a6,a4
    112e:	1682                	slli	a3,a3,0x20
    1130:	9281                	srli	a3,a3,0x20
    1132:	96b2                	add	a3,a3,a2
    1134:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1138:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    113c:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1140:	12e86463          	bltu	a6,a4,1268 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1144:	02e5f6bb          	remuw	a3,a1,a4
    1148:	1682                	slli	a3,a3,0x20
    114a:	9281                	srli	a3,a3,0x20
    114c:	96b2                	add	a3,a3,a2
    114e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1152:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1156:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    115a:	0ce5ec63          	bltu	a1,a4,1232 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    115e:	02e876bb          	remuw	a3,a6,a4
    1162:	1682                	slli	a3,a3,0x20
    1164:	9281                	srli	a3,a3,0x20
    1166:	96b2                	add	a3,a3,a2
    1168:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    116c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1170:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    1174:	10e86963          	bltu	a6,a4,1286 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    1178:	02e5f6bb          	remuw	a3,a1,a4
    117c:	1682                	slli	a3,a3,0x20
    117e:	9281                	srli	a3,a3,0x20
    1180:	96b2                	add	a3,a3,a2
    1182:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1186:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    118a:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    118e:	10e5e763          	bltu	a1,a4,129c <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    1192:	02e876bb          	remuw	a3,a6,a4
    1196:	1682                	slli	a3,a3,0x20
    1198:	9281                	srli	a3,a3,0x20
    119a:	96b2                	add	a3,a3,a2
    119c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11a0:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11a4:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11a8:	10e86363          	bltu	a6,a4,12ae <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11ac:	1782                	slli	a5,a5,0x20
    11ae:	9381                	srli	a5,a5,0x20
    11b0:	97b2                	add	a5,a5,a2
    11b2:	0007c783          	lbu	a5,0(a5)
    11b6:	4599                	li	a1,6
    11b8:	00f10723          	sb	a5,14(sp)

    if (sign)
    11bc:	00055763          	bgez	a0,11ca <printint.constprop.0+0x126>
        buf[i--] = '-';
    11c0:	02d00793          	li	a5,45
    11c4:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11c8:	4595                	li	a1,5
    write(f, s, l);
    11ca:	003c                	addi	a5,sp,8
    11cc:	4641                	li	a2,16
    11ce:	9e0d                	subw	a2,a2,a1
    11d0:	4505                	li	a0,1
    11d2:	95be                	add	a1,a1,a5
    11d4:	297000ef          	jal	1c6a <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11d8:	70a2                	ld	ra,40(sp)
    11da:	6145                	addi	sp,sp,48
    11dc:	8082                	ret
        x = -xx;
    11de:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    11e2:	02b877bb          	remuw	a5,a6,a1
    11e6:	00001617          	auipc	a2,0x1
    11ea:	d9260613          	addi	a2,a2,-622 # 1f78 <digits>
    buf[16] = 0;
    11ee:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    11f2:	0005871b          	sext.w	a4,a1
    11f6:	1782                	slli	a5,a5,0x20
    11f8:	9381                	srli	a5,a5,0x20
    11fa:	97b2                	add	a5,a5,a2
    11fc:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1200:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1204:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1208:	06b86963          	bltu	a6,a1,127a <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    120c:	02e8f7bb          	remuw	a5,a7,a4
    1210:	1782                	slli	a5,a5,0x20
    1212:	9381                	srli	a5,a5,0x20
    1214:	97b2                	add	a5,a5,a2
    1216:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    121a:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    121e:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1222:	ece8f8e3          	bgeu	a7,a4,10f2 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1226:	02d00793          	li	a5,45
    122a:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    122e:	45b5                	li	a1,13
    1230:	bf69                	j	11ca <printint.constprop.0+0x126>
    1232:	45a9                	li	a1,10
    if (sign)
    1234:	f8055be3          	bgez	a0,11ca <printint.constprop.0+0x126>
        buf[i--] = '-';
    1238:	02d00793          	li	a5,45
    123c:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1240:	45a5                	li	a1,9
    1242:	b761                	j	11ca <printint.constprop.0+0x126>
    1244:	45b5                	li	a1,13
    if (sign)
    1246:	f80552e3          	bgez	a0,11ca <printint.constprop.0+0x126>
        buf[i--] = '-';
    124a:	02d00793          	li	a5,45
    124e:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1252:	45b1                	li	a1,12
    1254:	bf9d                	j	11ca <printint.constprop.0+0x126>
    1256:	45b1                	li	a1,12
    if (sign)
    1258:	f60559e3          	bgez	a0,11ca <printint.constprop.0+0x126>
        buf[i--] = '-';
    125c:	02d00793          	li	a5,45
    1260:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    1264:	45ad                	li	a1,11
    1266:	b795                	j	11ca <printint.constprop.0+0x126>
    1268:	45ad                	li	a1,11
    if (sign)
    126a:	f60550e3          	bgez	a0,11ca <printint.constprop.0+0x126>
        buf[i--] = '-';
    126e:	02d00793          	li	a5,45
    1272:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    1276:	45a9                	li	a1,10
    1278:	bf89                	j	11ca <printint.constprop.0+0x126>
        buf[i--] = '-';
    127a:	02d00793          	li	a5,45
    127e:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1282:	45b9                	li	a1,14
    1284:	b799                	j	11ca <printint.constprop.0+0x126>
    1286:	45a5                	li	a1,9
    if (sign)
    1288:	f40551e3          	bgez	a0,11ca <printint.constprop.0+0x126>
        buf[i--] = '-';
    128c:	02d00793          	li	a5,45
    1290:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    1294:	45a1                	li	a1,8
    1296:	bf15                	j	11ca <printint.constprop.0+0x126>
    i = 15;
    1298:	45bd                	li	a1,15
    129a:	bf05                	j	11ca <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    129c:	45a1                	li	a1,8
    if (sign)
    129e:	f20556e3          	bgez	a0,11ca <printint.constprop.0+0x126>
        buf[i--] = '-';
    12a2:	02d00793          	li	a5,45
    12a6:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12aa:	459d                	li	a1,7
    12ac:	bf39                	j	11ca <printint.constprop.0+0x126>
    12ae:	459d                	li	a1,7
    if (sign)
    12b0:	f0055de3          	bgez	a0,11ca <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b4:	02d00793          	li	a5,45
    12b8:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12bc:	4599                	li	a1,6
    12be:	b731                	j	11ca <printint.constprop.0+0x126>

00000000000012c0 <getchar>:
{
    12c0:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12c2:	00f10593          	addi	a1,sp,15
    12c6:	4605                	li	a2,1
    12c8:	4501                	li	a0,0
{
    12ca:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12cc:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12d0:	191000ef          	jal	1c60 <read>
}
    12d4:	60e2                	ld	ra,24(sp)
    12d6:	00f14503          	lbu	a0,15(sp)
    12da:	6105                	addi	sp,sp,32
    12dc:	8082                	ret

00000000000012de <putchar>:
{
    12de:	1101                	addi	sp,sp,-32
    12e0:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    12e2:	00f10593          	addi	a1,sp,15
    12e6:	4605                	li	a2,1
    12e8:	4505                	li	a0,1
{
    12ea:	ec06                	sd	ra,24(sp)
    char byte = c;
    12ec:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12f0:	17b000ef          	jal	1c6a <write>
}
    12f4:	60e2                	ld	ra,24(sp)
    12f6:	2501                	sext.w	a0,a0
    12f8:	6105                	addi	sp,sp,32
    12fa:	8082                	ret

00000000000012fc <puts>:
{
    12fc:	1141                	addi	sp,sp,-16
    12fe:	e406                	sd	ra,8(sp)
    1300:	e022                	sd	s0,0(sp)
    1302:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1304:	582000ef          	jal	1886 <strlen>
    1308:	862a                	mv	a2,a0
    130a:	85a2                	mv	a1,s0
    130c:	4505                	li	a0,1
    130e:	15d000ef          	jal	1c6a <write>
}
    1312:	60a2                	ld	ra,8(sp)
    1314:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1316:	957d                	srai	a0,a0,0x3f
    return r;
    1318:	2501                	sext.w	a0,a0
}
    131a:	0141                	addi	sp,sp,16
    131c:	8082                	ret

000000000000131e <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    131e:	7131                	addi	sp,sp,-192
    1320:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1322:	013c                	addi	a5,sp,136
{
    1324:	f0ca                	sd	s2,96(sp)
    1326:	ecce                	sd	s3,88(sp)
    1328:	e8d2                	sd	s4,80(sp)
    132a:	e4d6                	sd	s5,72(sp)
    132c:	e0da                	sd	s6,64(sp)
    132e:	fc5e                	sd	s7,56(sp)
    1330:	fc86                	sd	ra,120(sp)
    1332:	f8a2                	sd	s0,112(sp)
    1334:	f4a6                	sd	s1,104(sp)
    1336:	e52e                	sd	a1,136(sp)
    1338:	e932                	sd	a2,144(sp)
    133a:	ed36                	sd	a3,152(sp)
    133c:	f13a                	sd	a4,160(sp)
    133e:	f942                	sd	a6,176(sp)
    1340:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1342:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1344:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    1348:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    134c:	00001b97          	auipc	s7,0x1
    1350:	bfcb8b93          	addi	s7,s7,-1028 # 1f48 <__clone+0xa6>
        switch (s[1])
    1354:	07800a93          	li	s5,120
    1358:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    135c:	00001997          	auipc	s3,0x1
    1360:	c1c98993          	addi	s3,s3,-996 # 1f78 <digits>
        if (!*s)
    1364:	00054783          	lbu	a5,0(a0)
    1368:	16078c63          	beqz	a5,14e0 <printf+0x1c2>
    136c:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    136e:	19278463          	beq	a5,s2,14f6 <printf+0x1d8>
    1372:	00164783          	lbu	a5,1(a2)
    1376:	0605                	addi	a2,a2,1
    1378:	fbfd                	bnez	a5,136e <printf+0x50>
    137a:	84b2                	mv	s1,a2
        l = z - a;
    137c:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1380:	85aa                	mv	a1,a0
    1382:	8622                	mv	a2,s0
    1384:	4505                	li	a0,1
    1386:	0e5000ef          	jal	1c6a <write>
        if (l)
    138a:	18041f63          	bnez	s0,1528 <printf+0x20a>
        if (s[1] == 0)
    138e:	0014c783          	lbu	a5,1(s1)
    1392:	14078763          	beqz	a5,14e0 <printf+0x1c2>
        switch (s[1])
    1396:	1d478163          	beq	a5,s4,1558 <printf+0x23a>
    139a:	18fa6963          	bltu	s4,a5,152c <printf+0x20e>
    139e:	1b678363          	beq	a5,s6,1544 <printf+0x226>
    13a2:	07000713          	li	a4,112
    13a6:	1ce79c63          	bne	a5,a4,157e <printf+0x260>
            printptr(va_arg(ap, uint64));
    13aa:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13ac:	03000793          	li	a5,48
    13b0:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13b4:	631c                	ld	a5,0(a4)
    13b6:	0721                	addi	a4,a4,8
    13b8:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13ba:	00479f93          	slli	t6,a5,0x4
    13be:	00879f13          	slli	t5,a5,0x8
    13c2:	00c79e93          	slli	t4,a5,0xc
    13c6:	01079e13          	slli	t3,a5,0x10
    13ca:	01479313          	slli	t1,a5,0x14
    13ce:	01879893          	slli	a7,a5,0x18
    13d2:	01c79713          	slli	a4,a5,0x1c
    13d6:	02479813          	slli	a6,a5,0x24
    13da:	02879513          	slli	a0,a5,0x28
    13de:	02c79593          	slli	a1,a5,0x2c
    13e2:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13e6:	03c7d293          	srli	t0,a5,0x3c
    13ea:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13ee:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13f2:	03cfdf93          	srli	t6,t6,0x3c
    13f6:	03cf5f13          	srli	t5,t5,0x3c
    13fa:	03cede93          	srli	t4,t4,0x3c
    13fe:	03ce5e13          	srli	t3,t3,0x3c
    1402:	03c35313          	srli	t1,t1,0x3c
    1406:	03c8d893          	srli	a7,a7,0x3c
    140a:	9371                	srli	a4,a4,0x3c
    140c:	03c85813          	srli	a6,a6,0x3c
    1410:	9171                	srli	a0,a0,0x3c
    1412:	91f1                	srli	a1,a1,0x3c
    1414:	9271                	srli	a2,a2,0x3c
    1416:	974e                	add	a4,a4,s3
    1418:	92f1                	srli	a3,a3,0x3c
    141a:	92ce                	add	t0,t0,s3
    141c:	9fce                	add	t6,t6,s3
    141e:	9f4e                	add	t5,t5,s3
    1420:	9ece                	add	t4,t4,s3
    1422:	9e4e                	add	t3,t3,s3
    1424:	934e                	add	t1,t1,s3
    1426:	98ce                	add	a7,a7,s3
    1428:	93ce                	add	t2,t2,s3
    142a:	984e                	add	a6,a6,s3
    142c:	954e                	add	a0,a0,s3
    142e:	95ce                	add	a1,a1,s3
    1430:	964e                	add	a2,a2,s3
    1432:	0002c283          	lbu	t0,0(t0)
    1436:	000fcf83          	lbu	t6,0(t6)
    143a:	000f4f03          	lbu	t5,0(t5)
    143e:	000ece83          	lbu	t4,0(t4)
    1442:	000e4e03          	lbu	t3,0(t3)
    1446:	00034303          	lbu	t1,0(t1)
    144a:	0008c883          	lbu	a7,0(a7)
    144e:	00074403          	lbu	s0,0(a4)
    1452:	0003c383          	lbu	t2,0(t2)
    1456:	00084803          	lbu	a6,0(a6)
    145a:	00054503          	lbu	a0,0(a0)
    145e:	0005c583          	lbu	a1,0(a1)
    1462:	00064603          	lbu	a2,0(a2)
    1466:	00d98733          	add	a4,s3,a3
    146a:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    146e:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1472:	9371                	srli	a4,a4,0x3c
    1474:	8bbd                	andi	a5,a5,15
    1476:	00510523          	sb	t0,10(sp)
    147a:	01f105a3          	sb	t6,11(sp)
    147e:	01e10623          	sb	t5,12(sp)
    1482:	01d106a3          	sb	t4,13(sp)
    1486:	01c10723          	sb	t3,14(sp)
    148a:	006107a3          	sb	t1,15(sp)
    148e:	01110823          	sb	a7,16(sp)
    1492:	00710923          	sb	t2,18(sp)
    1496:	010109a3          	sb	a6,19(sp)
    149a:	00a10a23          	sb	a0,20(sp)
    149e:	00b10aa3          	sb	a1,21(sp)
    14a2:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14a6:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14aa:	008108a3          	sb	s0,17(sp)
    14ae:	974e                	add	a4,a4,s3
    14b0:	97ce                	add	a5,a5,s3
    14b2:	00d10ba3          	sb	a3,23(sp)
    14b6:	00074703          	lbu	a4,0(a4)
    14ba:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14be:	4649                	li	a2,18
    14c0:	002c                	addi	a1,sp,8
    14c2:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14c4:	00e10c23          	sb	a4,24(sp)
    14c8:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14cc:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14d0:	79a000ef          	jal	1c6a <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14d4:	00248513          	addi	a0,s1,2
        if (!*s)
    14d8:	00054783          	lbu	a5,0(a0)
    14dc:	e80798e3          	bnez	a5,136c <printf+0x4e>
    }
    va_end(ap);
}
    14e0:	70e6                	ld	ra,120(sp)
    14e2:	7446                	ld	s0,112(sp)
    14e4:	74a6                	ld	s1,104(sp)
    14e6:	7906                	ld	s2,96(sp)
    14e8:	69e6                	ld	s3,88(sp)
    14ea:	6a46                	ld	s4,80(sp)
    14ec:	6aa6                	ld	s5,72(sp)
    14ee:	6b06                	ld	s6,64(sp)
    14f0:	7be2                	ld	s7,56(sp)
    14f2:	6129                	addi	sp,sp,192
    14f4:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14f6:	00064783          	lbu	a5,0(a2)
    14fa:	84b2                	mv	s1,a2
    14fc:	01278963          	beq	a5,s2,150e <printf+0x1f0>
    1500:	bdb5                	j	137c <printf+0x5e>
    1502:	0024c783          	lbu	a5,2(s1)
    1506:	0605                	addi	a2,a2,1
    1508:	0489                	addi	s1,s1,2
    150a:	e72799e3          	bne	a5,s2,137c <printf+0x5e>
    150e:	0014c783          	lbu	a5,1(s1)
    1512:	ff2788e3          	beq	a5,s2,1502 <printf+0x1e4>
        l = z - a;
    1516:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    151a:	85aa                	mv	a1,a0
    151c:	8622                	mv	a2,s0
    151e:	4505                	li	a0,1
    1520:	74a000ef          	jal	1c6a <write>
        if (l)
    1524:	e60405e3          	beqz	s0,138e <printf+0x70>
    1528:	8526                	mv	a0,s1
    152a:	bd2d                	j	1364 <printf+0x46>
        switch (s[1])
    152c:	05579963          	bne	a5,s5,157e <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1530:	6782                	ld	a5,0(sp)
    1532:	45c1                	li	a1,16
    1534:	4388                	lw	a0,0(a5)
    1536:	07a1                	addi	a5,a5,8
    1538:	e03e                	sd	a5,0(sp)
    153a:	b6bff0ef          	jal	10a4 <printint.constprop.0>
        s += 2;
    153e:	00248513          	addi	a0,s1,2
    1542:	bf59                	j	14d8 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1544:	6782                	ld	a5,0(sp)
    1546:	45a9                	li	a1,10
    1548:	4388                	lw	a0,0(a5)
    154a:	07a1                	addi	a5,a5,8
    154c:	e03e                	sd	a5,0(sp)
    154e:	b57ff0ef          	jal	10a4 <printint.constprop.0>
        s += 2;
    1552:	00248513          	addi	a0,s1,2
    1556:	b749                	j	14d8 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1558:	6782                	ld	a5,0(sp)
    155a:	6380                	ld	s0,0(a5)
    155c:	07a1                	addi	a5,a5,8
    155e:	e03e                	sd	a5,0(sp)
    1560:	c031                	beqz	s0,15a4 <printf+0x286>
            l = strnlen(a, 200);
    1562:	0c800593          	li	a1,200
    1566:	8522                	mv	a0,s0
    1568:	40a000ef          	jal	1972 <strnlen>
    write(f, s, l);
    156c:	0005061b          	sext.w	a2,a0
    1570:	85a2                	mv	a1,s0
    1572:	4505                	li	a0,1
    1574:	6f6000ef          	jal	1c6a <write>
        s += 2;
    1578:	00248513          	addi	a0,s1,2
    157c:	bfb1                	j	14d8 <printf+0x1ba>
    return write(stdout, &byte, 1);
    157e:	4605                	li	a2,1
    1580:	002c                	addi	a1,sp,8
    1582:	4505                	li	a0,1
    char byte = c;
    1584:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    1588:	6e2000ef          	jal	1c6a <write>
    char byte = c;
    158c:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    1590:	4605                	li	a2,1
    1592:	002c                	addi	a1,sp,8
    1594:	4505                	li	a0,1
    char byte = c;
    1596:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    159a:	6d0000ef          	jal	1c6a <write>
        s += 2;
    159e:	00248513          	addi	a0,s1,2
    15a2:	bf1d                	j	14d8 <printf+0x1ba>
                a = "(null)";
    15a4:	845e                	mv	s0,s7
    15a6:	bf75                	j	1562 <printf+0x244>

00000000000015a8 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15a8:	1141                	addi	sp,sp,-16
    15aa:	e406                	sd	ra,8(sp)
    puts(m);
    15ac:	d51ff0ef          	jal	12fc <puts>
    exit(-100);
}
    15b0:	60a2                	ld	ra,8(sp)
    exit(-100);
    15b2:	f9c00513          	li	a0,-100
}
    15b6:	0141                	addi	sp,sp,16
    exit(-100);
    15b8:	a709                	j	1cba <exit>

00000000000015ba <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15ba:	02000793          	li	a5,32
    15be:	00f50663          	beq	a0,a5,15ca <isspace+0x10>
    15c2:	355d                	addiw	a0,a0,-9
    15c4:	00553513          	sltiu	a0,a0,5
    15c8:	8082                	ret
    15ca:	4505                	li	a0,1
}
    15cc:	8082                	ret

00000000000015ce <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15ce:	fd05051b          	addiw	a0,a0,-48
}
    15d2:	00a53513          	sltiu	a0,a0,10
    15d6:	8082                	ret

00000000000015d8 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15d8:	02000613          	li	a2,32
    15dc:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15de:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15e2:	ff77069b          	addiw	a3,a4,-9
    15e6:	04c70d63          	beq	a4,a2,1640 <atoi+0x68>
    15ea:	0007079b          	sext.w	a5,a4
    15ee:	04d5f963          	bgeu	a1,a3,1640 <atoi+0x68>
        s++;
    switch (*s)
    15f2:	02b00693          	li	a3,43
    15f6:	04d70a63          	beq	a4,a3,164a <atoi+0x72>
    15fa:	02d00693          	li	a3,45
    15fe:	06d70463          	beq	a4,a3,1666 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1602:	fd07859b          	addiw	a1,a5,-48
    1606:	4625                	li	a2,9
    1608:	873e                	mv	a4,a5
    160a:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    160c:	4e01                	li	t3,0
    while (isdigit(*s))
    160e:	04b66a63          	bltu	a2,a1,1662 <atoi+0x8a>
    int n = 0, neg = 0;
    1612:	4501                	li	a0,0
    while (isdigit(*s))
    1614:	4825                	li	a6,9
    1616:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    161a:	0025179b          	slliw	a5,a0,0x2
    161e:	9d3d                	addw	a0,a0,a5
    1620:	fd07031b          	addiw	t1,a4,-48
    1624:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1628:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    162c:	0685                	addi	a3,a3,1
    162e:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1632:	0006071b          	sext.w	a4,a2
    1636:	feb870e3          	bgeu	a6,a1,1616 <atoi+0x3e>
    return neg ? n : -n;
    163a:	000e0563          	beqz	t3,1644 <atoi+0x6c>
}
    163e:	8082                	ret
        s++;
    1640:	0505                	addi	a0,a0,1
    1642:	bf71                	j	15de <atoi+0x6>
    return neg ? n : -n;
    1644:	4113053b          	subw	a0,t1,a7
    1648:	8082                	ret
    while (isdigit(*s))
    164a:	00154783          	lbu	a5,1(a0)
    164e:	4625                	li	a2,9
        s++;
    1650:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1654:	fd07859b          	addiw	a1,a5,-48
    1658:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    165c:	4e01                	li	t3,0
    while (isdigit(*s))
    165e:	fab67ae3          	bgeu	a2,a1,1612 <atoi+0x3a>
    1662:	4501                	li	a0,0
}
    1664:	8082                	ret
    while (isdigit(*s))
    1666:	00154783          	lbu	a5,1(a0)
    166a:	4625                	li	a2,9
        s++;
    166c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1670:	fd07859b          	addiw	a1,a5,-48
    1674:	0007871b          	sext.w	a4,a5
    1678:	feb665e3          	bltu	a2,a1,1662 <atoi+0x8a>
        neg = 1;
    167c:	4e05                	li	t3,1
    167e:	bf51                	j	1612 <atoi+0x3a>

0000000000001680 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1680:	16060d63          	beqz	a2,17fa <memset+0x17a>
    1684:	40a007b3          	neg	a5,a0
    1688:	8b9d                	andi	a5,a5,7
    168a:	00778713          	addi	a4,a5,7
    168e:	482d                	li	a6,11
    1690:	0ff5f593          	zext.b	a1,a1
    1694:	fff60693          	addi	a3,a2,-1
    1698:	17076263          	bltu	a4,a6,17fc <memset+0x17c>
    169c:	16e6ea63          	bltu	a3,a4,1810 <memset+0x190>
    16a0:	16078563          	beqz	a5,180a <memset+0x18a>
    16a4:	00b50023          	sb	a1,0(a0)
    16a8:	4705                	li	a4,1
    16aa:	00150e93          	addi	t4,a0,1
    16ae:	14e78c63          	beq	a5,a4,1806 <memset+0x186>
    16b2:	00b500a3          	sb	a1,1(a0)
    16b6:	4709                	li	a4,2
    16b8:	00250e93          	addi	t4,a0,2
    16bc:	14e78d63          	beq	a5,a4,1816 <memset+0x196>
    16c0:	00b50123          	sb	a1,2(a0)
    16c4:	470d                	li	a4,3
    16c6:	00350e93          	addi	t4,a0,3
    16ca:	12e78b63          	beq	a5,a4,1800 <memset+0x180>
    16ce:	00b501a3          	sb	a1,3(a0)
    16d2:	4711                	li	a4,4
    16d4:	00450e93          	addi	t4,a0,4
    16d8:	14e78163          	beq	a5,a4,181a <memset+0x19a>
    16dc:	00b50223          	sb	a1,4(a0)
    16e0:	4715                	li	a4,5
    16e2:	00550e93          	addi	t4,a0,5
    16e6:	12e78c63          	beq	a5,a4,181e <memset+0x19e>
    16ea:	00b502a3          	sb	a1,5(a0)
    16ee:	471d                	li	a4,7
    16f0:	00650e93          	addi	t4,a0,6
    16f4:	12e79763          	bne	a5,a4,1822 <memset+0x1a2>
    16f8:	00750e93          	addi	t4,a0,7
    16fc:	00b50323          	sb	a1,6(a0)
    1700:	4f1d                	li	t5,7
    1702:	00859713          	slli	a4,a1,0x8
    1706:	8f4d                	or	a4,a4,a1
    1708:	01059e13          	slli	t3,a1,0x10
    170c:	01c76e33          	or	t3,a4,t3
    1710:	01859313          	slli	t1,a1,0x18
    1714:	006e6333          	or	t1,t3,t1
    1718:	02059893          	slli	a7,a1,0x20
    171c:	011368b3          	or	a7,t1,a7
    1720:	02859813          	slli	a6,a1,0x28
    1724:	40f60333          	sub	t1,a2,a5
    1728:	0108e833          	or	a6,a7,a6
    172c:	03059693          	slli	a3,a1,0x30
    1730:	00d866b3          	or	a3,a6,a3
    1734:	03859713          	slli	a4,a1,0x38
    1738:	97aa                	add	a5,a5,a0
    173a:	ff837813          	andi	a6,t1,-8
    173e:	8f55                	or	a4,a4,a3
    1740:	00f806b3          	add	a3,a6,a5
    1744:	e398                	sd	a4,0(a5)
    1746:	07a1                	addi	a5,a5,8
    1748:	fed79ee3          	bne	a5,a3,1744 <memset+0xc4>
    174c:	ff837693          	andi	a3,t1,-8
    1750:	00de87b3          	add	a5,t4,a3
    1754:	01e6873b          	addw	a4,a3,t5
    1758:	0ad30663          	beq	t1,a3,1804 <memset+0x184>
    175c:	00b78023          	sb	a1,0(a5)
    1760:	0017069b          	addiw	a3,a4,1
    1764:	08c6fb63          	bgeu	a3,a2,17fa <memset+0x17a>
    1768:	00b780a3          	sb	a1,1(a5)
    176c:	0027069b          	addiw	a3,a4,2
    1770:	08c6f563          	bgeu	a3,a2,17fa <memset+0x17a>
    1774:	00b78123          	sb	a1,2(a5)
    1778:	0037069b          	addiw	a3,a4,3
    177c:	06c6ff63          	bgeu	a3,a2,17fa <memset+0x17a>
    1780:	00b781a3          	sb	a1,3(a5)
    1784:	0047069b          	addiw	a3,a4,4
    1788:	06c6f963          	bgeu	a3,a2,17fa <memset+0x17a>
    178c:	00b78223          	sb	a1,4(a5)
    1790:	0057069b          	addiw	a3,a4,5
    1794:	06c6f363          	bgeu	a3,a2,17fa <memset+0x17a>
    1798:	00b782a3          	sb	a1,5(a5)
    179c:	0067069b          	addiw	a3,a4,6
    17a0:	04c6fd63          	bgeu	a3,a2,17fa <memset+0x17a>
    17a4:	00b78323          	sb	a1,6(a5)
    17a8:	0077069b          	addiw	a3,a4,7
    17ac:	04c6f763          	bgeu	a3,a2,17fa <memset+0x17a>
    17b0:	00b783a3          	sb	a1,7(a5)
    17b4:	0087069b          	addiw	a3,a4,8
    17b8:	04c6f163          	bgeu	a3,a2,17fa <memset+0x17a>
    17bc:	00b78423          	sb	a1,8(a5)
    17c0:	0097069b          	addiw	a3,a4,9
    17c4:	02c6fb63          	bgeu	a3,a2,17fa <memset+0x17a>
    17c8:	00b784a3          	sb	a1,9(a5)
    17cc:	00a7069b          	addiw	a3,a4,10
    17d0:	02c6f563          	bgeu	a3,a2,17fa <memset+0x17a>
    17d4:	00b78523          	sb	a1,10(a5)
    17d8:	00b7069b          	addiw	a3,a4,11
    17dc:	00c6ff63          	bgeu	a3,a2,17fa <memset+0x17a>
    17e0:	00b785a3          	sb	a1,11(a5)
    17e4:	00c7069b          	addiw	a3,a4,12
    17e8:	00c6f963          	bgeu	a3,a2,17fa <memset+0x17a>
    17ec:	00b78623          	sb	a1,12(a5)
    17f0:	2735                	addiw	a4,a4,13
    17f2:	00c77463          	bgeu	a4,a2,17fa <memset+0x17a>
    17f6:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    17fa:	8082                	ret
    17fc:	472d                	li	a4,11
    17fe:	bd79                	j	169c <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1800:	4f0d                	li	t5,3
    1802:	b701                	j	1702 <memset+0x82>
    1804:	8082                	ret
    1806:	4f05                	li	t5,1
    1808:	bded                	j	1702 <memset+0x82>
    180a:	8eaa                	mv	t4,a0
    180c:	4f01                	li	t5,0
    180e:	bdd5                	j	1702 <memset+0x82>
    1810:	87aa                	mv	a5,a0
    1812:	4701                	li	a4,0
    1814:	b7a1                	j	175c <memset+0xdc>
    1816:	4f09                	li	t5,2
    1818:	b5ed                	j	1702 <memset+0x82>
    181a:	4f11                	li	t5,4
    181c:	b5dd                	j	1702 <memset+0x82>
    181e:	4f15                	li	t5,5
    1820:	b5cd                	j	1702 <memset+0x82>
    1822:	4f19                	li	t5,6
    1824:	bdf9                	j	1702 <memset+0x82>

0000000000001826 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1826:	00054783          	lbu	a5,0(a0)
    182a:	0005c703          	lbu	a4,0(a1)
    182e:	00e79863          	bne	a5,a4,183e <strcmp+0x18>
    1832:	0505                	addi	a0,a0,1
    1834:	0585                	addi	a1,a1,1
    1836:	fbe5                	bnez	a5,1826 <strcmp>
    1838:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    183a:	9d19                	subw	a0,a0,a4
    183c:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    183e:	0007851b          	sext.w	a0,a5
    1842:	bfe5                	j	183a <strcmp+0x14>

0000000000001844 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1844:	ce05                	beqz	a2,187c <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1846:	00054703          	lbu	a4,0(a0)
    184a:	0005c783          	lbu	a5,0(a1)
    184e:	cb0d                	beqz	a4,1880 <strncmp+0x3c>
    if (!n--)
    1850:	167d                	addi	a2,a2,-1
    1852:	00c506b3          	add	a3,a0,a2
    1856:	a819                	j	186c <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1858:	00a68e63          	beq	a3,a0,1874 <strncmp+0x30>
    185c:	0505                	addi	a0,a0,1
    185e:	00e79b63          	bne	a5,a4,1874 <strncmp+0x30>
    1862:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    1866:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    186a:	cb19                	beqz	a4,1880 <strncmp+0x3c>
    186c:	0005c783          	lbu	a5,0(a1)
    1870:	0585                	addi	a1,a1,1
    1872:	f3fd                	bnez	a5,1858 <strncmp+0x14>
    return *l - *r;
    1874:	0007051b          	sext.w	a0,a4
    1878:	9d1d                	subw	a0,a0,a5
    187a:	8082                	ret
        return 0;
    187c:	4501                	li	a0,0
}
    187e:	8082                	ret
    1880:	4501                	li	a0,0
    return *l - *r;
    1882:	9d1d                	subw	a0,a0,a5
    1884:	8082                	ret

0000000000001886 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    1886:	00757793          	andi	a5,a0,7
    188a:	cf89                	beqz	a5,18a4 <strlen+0x1e>
    188c:	87aa                	mv	a5,a0
    188e:	a029                	j	1898 <strlen+0x12>
    1890:	0785                	addi	a5,a5,1
    1892:	0077f713          	andi	a4,a5,7
    1896:	cb01                	beqz	a4,18a6 <strlen+0x20>
        if (!*s)
    1898:	0007c703          	lbu	a4,0(a5)
    189c:	fb75                	bnez	a4,1890 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    189e:	40a78533          	sub	a0,a5,a0
}
    18a2:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18a4:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18a6:	6394                	ld	a3,0(a5)
    18a8:	00000597          	auipc	a1,0x0
    18ac:	6a85b583          	ld	a1,1704(a1) # 1f50 <__clone+0xae>
    18b0:	00000617          	auipc	a2,0x0
    18b4:	6a863603          	ld	a2,1704(a2) # 1f58 <__clone+0xb6>
    18b8:	a019                	j	18be <strlen+0x38>
    18ba:	6794                	ld	a3,8(a5)
    18bc:	07a1                	addi	a5,a5,8
    18be:	00b68733          	add	a4,a3,a1
    18c2:	fff6c693          	not	a3,a3
    18c6:	8f75                	and	a4,a4,a3
    18c8:	8f71                	and	a4,a4,a2
    18ca:	db65                	beqz	a4,18ba <strlen+0x34>
    for (; *s; s++)
    18cc:	0007c703          	lbu	a4,0(a5)
    18d0:	d779                	beqz	a4,189e <strlen+0x18>
    18d2:	0017c703          	lbu	a4,1(a5)
    18d6:	0785                	addi	a5,a5,1
    18d8:	d379                	beqz	a4,189e <strlen+0x18>
    18da:	0017c703          	lbu	a4,1(a5)
    18de:	0785                	addi	a5,a5,1
    18e0:	fb6d                	bnez	a4,18d2 <strlen+0x4c>
    18e2:	bf75                	j	189e <strlen+0x18>

00000000000018e4 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18e4:	00757713          	andi	a4,a0,7
{
    18e8:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18ea:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18ee:	cb19                	beqz	a4,1904 <memchr+0x20>
    18f0:	ce25                	beqz	a2,1968 <memchr+0x84>
    18f2:	0007c703          	lbu	a4,0(a5)
    18f6:	04b70e63          	beq	a4,a1,1952 <memchr+0x6e>
    18fa:	0785                	addi	a5,a5,1
    18fc:	0077f713          	andi	a4,a5,7
    1900:	167d                	addi	a2,a2,-1
    1902:	f77d                	bnez	a4,18f0 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1904:	4501                	li	a0,0
    if (n && *s != c)
    1906:	c235                	beqz	a2,196a <memchr+0x86>
    1908:	0007c703          	lbu	a4,0(a5)
    190c:	04b70363          	beq	a4,a1,1952 <memchr+0x6e>
        size_t k = ONES * c;
    1910:	00000517          	auipc	a0,0x0
    1914:	65053503          	ld	a0,1616(a0) # 1f60 <__clone+0xbe>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1918:	471d                	li	a4,7
        size_t k = ONES * c;
    191a:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    191e:	02c77a63          	bgeu	a4,a2,1952 <memchr+0x6e>
    1922:	00000897          	auipc	a7,0x0
    1926:	62e8b883          	ld	a7,1582(a7) # 1f50 <__clone+0xae>
    192a:	00000817          	auipc	a6,0x0
    192e:	62e83803          	ld	a6,1582(a6) # 1f58 <__clone+0xb6>
    1932:	431d                	li	t1,7
    1934:	a029                	j	193e <memchr+0x5a>
    1936:	1661                	addi	a2,a2,-8
    1938:	07a1                	addi	a5,a5,8
    193a:	02c37963          	bgeu	t1,a2,196c <memchr+0x88>
    193e:	6398                	ld	a4,0(a5)
    1940:	8f29                	xor	a4,a4,a0
    1942:	011706b3          	add	a3,a4,a7
    1946:	fff74713          	not	a4,a4
    194a:	8f75                	and	a4,a4,a3
    194c:	01077733          	and	a4,a4,a6
    1950:	d37d                	beqz	a4,1936 <memchr+0x52>
    1952:	853e                	mv	a0,a5
    1954:	97b2                	add	a5,a5,a2
    1956:	a021                	j	195e <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1958:	0505                	addi	a0,a0,1
    195a:	00f50763          	beq	a0,a5,1968 <memchr+0x84>
    195e:	00054703          	lbu	a4,0(a0)
    1962:	feb71be3          	bne	a4,a1,1958 <memchr+0x74>
    1966:	8082                	ret
    return n ? (void *)s : 0;
    1968:	4501                	li	a0,0
}
    196a:	8082                	ret
    return n ? (void *)s : 0;
    196c:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    196e:	f275                	bnez	a2,1952 <memchr+0x6e>
}
    1970:	8082                	ret

0000000000001972 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1972:	1101                	addi	sp,sp,-32
    1974:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1976:	862e                	mv	a2,a1
{
    1978:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    197a:	4581                	li	a1,0
{
    197c:	e426                	sd	s1,8(sp)
    197e:	ec06                	sd	ra,24(sp)
    1980:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1982:	f63ff0ef          	jal	18e4 <memchr>
    return p ? p - s : n;
    1986:	c519                	beqz	a0,1994 <strnlen+0x22>
}
    1988:	60e2                	ld	ra,24(sp)
    198a:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    198c:	8d05                	sub	a0,a0,s1
}
    198e:	64a2                	ld	s1,8(sp)
    1990:	6105                	addi	sp,sp,32
    1992:	8082                	ret
    1994:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1996:	8522                	mv	a0,s0
}
    1998:	6442                	ld	s0,16(sp)
    199a:	64a2                	ld	s1,8(sp)
    199c:	6105                	addi	sp,sp,32
    199e:	8082                	ret

00000000000019a0 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19a0:	00b547b3          	xor	a5,a0,a1
    19a4:	8b9d                	andi	a5,a5,7
    19a6:	eb95                	bnez	a5,19da <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19a8:	0075f793          	andi	a5,a1,7
    19ac:	e7b1                	bnez	a5,19f8 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19ae:	6198                	ld	a4,0(a1)
    19b0:	00000617          	auipc	a2,0x0
    19b4:	5a063603          	ld	a2,1440(a2) # 1f50 <__clone+0xae>
    19b8:	00000817          	auipc	a6,0x0
    19bc:	5a083803          	ld	a6,1440(a6) # 1f58 <__clone+0xb6>
    19c0:	a029                	j	19ca <strcpy+0x2a>
    19c2:	e118                	sd	a4,0(a0)
    19c4:	6598                	ld	a4,8(a1)
    19c6:	05a1                	addi	a1,a1,8
    19c8:	0521                	addi	a0,a0,8
    19ca:	00c707b3          	add	a5,a4,a2
    19ce:	fff74693          	not	a3,a4
    19d2:	8ff5                	and	a5,a5,a3
    19d4:	0107f7b3          	and	a5,a5,a6
    19d8:	d7ed                	beqz	a5,19c2 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19da:	0005c783          	lbu	a5,0(a1)
    19de:	00f50023          	sb	a5,0(a0)
    19e2:	c785                	beqz	a5,1a0a <strcpy+0x6a>
    19e4:	0015c783          	lbu	a5,1(a1)
    19e8:	0505                	addi	a0,a0,1
    19ea:	0585                	addi	a1,a1,1
    19ec:	00f50023          	sb	a5,0(a0)
    19f0:	fbf5                	bnez	a5,19e4 <strcpy+0x44>
        ;
    return d;
}
    19f2:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    19f4:	0505                	addi	a0,a0,1
    19f6:	df45                	beqz	a4,19ae <strcpy+0xe>
            if (!(*d = *s))
    19f8:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    19fc:	0585                	addi	a1,a1,1
    19fe:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a02:	00f50023          	sb	a5,0(a0)
    1a06:	f7fd                	bnez	a5,19f4 <strcpy+0x54>
}
    1a08:	8082                	ret
    1a0a:	8082                	ret

0000000000001a0c <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a0c:	00b547b3          	xor	a5,a0,a1
    1a10:	8b9d                	andi	a5,a5,7
    1a12:	1a079863          	bnez	a5,1bc2 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a16:	0075f793          	andi	a5,a1,7
    1a1a:	16078463          	beqz	a5,1b82 <strncpy+0x176>
    1a1e:	ea01                	bnez	a2,1a2e <strncpy+0x22>
    1a20:	a421                	j	1c28 <strncpy+0x21c>
    1a22:	167d                	addi	a2,a2,-1
    1a24:	0505                	addi	a0,a0,1
    1a26:	14070e63          	beqz	a4,1b82 <strncpy+0x176>
    1a2a:	1a060863          	beqz	a2,1bda <strncpy+0x1ce>
    1a2e:	0005c783          	lbu	a5,0(a1)
    1a32:	0585                	addi	a1,a1,1
    1a34:	0075f713          	andi	a4,a1,7
    1a38:	00f50023          	sb	a5,0(a0)
    1a3c:	f3fd                	bnez	a5,1a22 <strncpy+0x16>
    1a3e:	4805                	li	a6,1
    1a40:	1a061863          	bnez	a2,1bf0 <strncpy+0x1e4>
    1a44:	40a007b3          	neg	a5,a0
    1a48:	8b9d                	andi	a5,a5,7
    1a4a:	4681                	li	a3,0
    1a4c:	18061a63          	bnez	a2,1be0 <strncpy+0x1d4>
    1a50:	00778713          	addi	a4,a5,7
    1a54:	45ad                	li	a1,11
    1a56:	18b76363          	bltu	a4,a1,1bdc <strncpy+0x1d0>
    1a5a:	1ae6eb63          	bltu	a3,a4,1c10 <strncpy+0x204>
    1a5e:	1a078363          	beqz	a5,1c04 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a62:	00050023          	sb	zero,0(a0)
    1a66:	4685                	li	a3,1
    1a68:	00150713          	addi	a4,a0,1
    1a6c:	18d78f63          	beq	a5,a3,1c0a <strncpy+0x1fe>
    1a70:	000500a3          	sb	zero,1(a0)
    1a74:	4689                	li	a3,2
    1a76:	00250713          	addi	a4,a0,2
    1a7a:	18d78e63          	beq	a5,a3,1c16 <strncpy+0x20a>
    1a7e:	00050123          	sb	zero,2(a0)
    1a82:	468d                	li	a3,3
    1a84:	00350713          	addi	a4,a0,3
    1a88:	16d78c63          	beq	a5,a3,1c00 <strncpy+0x1f4>
    1a8c:	000501a3          	sb	zero,3(a0)
    1a90:	4691                	li	a3,4
    1a92:	00450713          	addi	a4,a0,4
    1a96:	18d78263          	beq	a5,a3,1c1a <strncpy+0x20e>
    1a9a:	00050223          	sb	zero,4(a0)
    1a9e:	4695                	li	a3,5
    1aa0:	00550713          	addi	a4,a0,5
    1aa4:	16d78d63          	beq	a5,a3,1c1e <strncpy+0x212>
    1aa8:	000502a3          	sb	zero,5(a0)
    1aac:	469d                	li	a3,7
    1aae:	00650713          	addi	a4,a0,6
    1ab2:	16d79863          	bne	a5,a3,1c22 <strncpy+0x216>
    1ab6:	00750713          	addi	a4,a0,7
    1aba:	00050323          	sb	zero,6(a0)
    1abe:	40f80833          	sub	a6,a6,a5
    1ac2:	ff887593          	andi	a1,a6,-8
    1ac6:	97aa                	add	a5,a5,a0
    1ac8:	95be                	add	a1,a1,a5
    1aca:	0007b023          	sd	zero,0(a5)
    1ace:	07a1                	addi	a5,a5,8
    1ad0:	feb79de3          	bne	a5,a1,1aca <strncpy+0xbe>
    1ad4:	ff887593          	andi	a1,a6,-8
    1ad8:	9ead                	addw	a3,a3,a1
    1ada:	00b707b3          	add	a5,a4,a1
    1ade:	12b80863          	beq	a6,a1,1c0e <strncpy+0x202>
    1ae2:	00078023          	sb	zero,0(a5)
    1ae6:	0016871b          	addiw	a4,a3,1
    1aea:	0ec77863          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1aee:	000780a3          	sb	zero,1(a5)
    1af2:	0026871b          	addiw	a4,a3,2
    1af6:	0ec77263          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1afa:	00078123          	sb	zero,2(a5)
    1afe:	0036871b          	addiw	a4,a3,3
    1b02:	0cc77c63          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1b06:	000781a3          	sb	zero,3(a5)
    1b0a:	0046871b          	addiw	a4,a3,4
    1b0e:	0cc77663          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1b12:	00078223          	sb	zero,4(a5)
    1b16:	0056871b          	addiw	a4,a3,5
    1b1a:	0cc77063          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1b1e:	000782a3          	sb	zero,5(a5)
    1b22:	0066871b          	addiw	a4,a3,6
    1b26:	0ac77a63          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1b2a:	00078323          	sb	zero,6(a5)
    1b2e:	0076871b          	addiw	a4,a3,7
    1b32:	0ac77463          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1b36:	000783a3          	sb	zero,7(a5)
    1b3a:	0086871b          	addiw	a4,a3,8
    1b3e:	08c77e63          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1b42:	00078423          	sb	zero,8(a5)
    1b46:	0096871b          	addiw	a4,a3,9
    1b4a:	08c77863          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1b4e:	000784a3          	sb	zero,9(a5)
    1b52:	00a6871b          	addiw	a4,a3,10
    1b56:	08c77263          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1b5a:	00078523          	sb	zero,10(a5)
    1b5e:	00b6871b          	addiw	a4,a3,11
    1b62:	06c77c63          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1b66:	000785a3          	sb	zero,11(a5)
    1b6a:	00c6871b          	addiw	a4,a3,12
    1b6e:	06c77663          	bgeu	a4,a2,1bda <strncpy+0x1ce>
    1b72:	00078623          	sb	zero,12(a5)
    1b76:	26b5                	addiw	a3,a3,13
    1b78:	06c6f163          	bgeu	a3,a2,1bda <strncpy+0x1ce>
    1b7c:	000786a3          	sb	zero,13(a5)
    1b80:	8082                	ret
            ;
        if (!n || !*s)
    1b82:	c645                	beqz	a2,1c2a <strncpy+0x21e>
    1b84:	0005c783          	lbu	a5,0(a1)
    1b88:	ea078be3          	beqz	a5,1a3e <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b8c:	479d                	li	a5,7
    1b8e:	02c7ff63          	bgeu	a5,a2,1bcc <strncpy+0x1c0>
    1b92:	00000897          	auipc	a7,0x0
    1b96:	3be8b883          	ld	a7,958(a7) # 1f50 <__clone+0xae>
    1b9a:	00000817          	auipc	a6,0x0
    1b9e:	3be83803          	ld	a6,958(a6) # 1f58 <__clone+0xb6>
    1ba2:	431d                	li	t1,7
    1ba4:	6198                	ld	a4,0(a1)
    1ba6:	011707b3          	add	a5,a4,a7
    1baa:	fff74693          	not	a3,a4
    1bae:	8ff5                	and	a5,a5,a3
    1bb0:	0107f7b3          	and	a5,a5,a6
    1bb4:	ef81                	bnez	a5,1bcc <strncpy+0x1c0>
            *wd = *ws;
    1bb6:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bb8:	1661                	addi	a2,a2,-8
    1bba:	05a1                	addi	a1,a1,8
    1bbc:	0521                	addi	a0,a0,8
    1bbe:	fec363e3          	bltu	t1,a2,1ba4 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bc2:	e609                	bnez	a2,1bcc <strncpy+0x1c0>
    1bc4:	a08d                	j	1c26 <strncpy+0x21a>
    1bc6:	167d                	addi	a2,a2,-1
    1bc8:	0505                	addi	a0,a0,1
    1bca:	ca01                	beqz	a2,1bda <strncpy+0x1ce>
    1bcc:	0005c783          	lbu	a5,0(a1)
    1bd0:	0585                	addi	a1,a1,1
    1bd2:	00f50023          	sb	a5,0(a0)
    1bd6:	fbe5                	bnez	a5,1bc6 <strncpy+0x1ba>
        ;
tail:
    1bd8:	b59d                	j	1a3e <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bda:	8082                	ret
    1bdc:	472d                	li	a4,11
    1bde:	bdb5                	j	1a5a <strncpy+0x4e>
    1be0:	00778713          	addi	a4,a5,7
    1be4:	45ad                	li	a1,11
    1be6:	fff60693          	addi	a3,a2,-1
    1bea:	e6b778e3          	bgeu	a4,a1,1a5a <strncpy+0x4e>
    1bee:	b7fd                	j	1bdc <strncpy+0x1d0>
    1bf0:	40a007b3          	neg	a5,a0
    1bf4:	8832                	mv	a6,a2
    1bf6:	8b9d                	andi	a5,a5,7
    1bf8:	4681                	li	a3,0
    1bfa:	e4060be3          	beqz	a2,1a50 <strncpy+0x44>
    1bfe:	b7cd                	j	1be0 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c00:	468d                	li	a3,3
    1c02:	bd75                	j	1abe <strncpy+0xb2>
    1c04:	872a                	mv	a4,a0
    1c06:	4681                	li	a3,0
    1c08:	bd5d                	j	1abe <strncpy+0xb2>
    1c0a:	4685                	li	a3,1
    1c0c:	bd4d                	j	1abe <strncpy+0xb2>
    1c0e:	8082                	ret
    1c10:	87aa                	mv	a5,a0
    1c12:	4681                	li	a3,0
    1c14:	b5f9                	j	1ae2 <strncpy+0xd6>
    1c16:	4689                	li	a3,2
    1c18:	b55d                	j	1abe <strncpy+0xb2>
    1c1a:	4691                	li	a3,4
    1c1c:	b54d                	j	1abe <strncpy+0xb2>
    1c1e:	4695                	li	a3,5
    1c20:	bd79                	j	1abe <strncpy+0xb2>
    1c22:	4699                	li	a3,6
    1c24:	bd69                	j	1abe <strncpy+0xb2>
    1c26:	8082                	ret
    1c28:	8082                	ret
    1c2a:	8082                	ret

0000000000001c2c <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c2c:	87aa                	mv	a5,a0
    1c2e:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c30:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c34:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c38:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c3a:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c3c:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c40:	2501                	sext.w	a0,a0
    1c42:	8082                	ret

0000000000001c44 <openat>:
    register long a7 __asm__("a7") = n;
    1c44:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c48:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c4c:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c50:	2501                	sext.w	a0,a0
    1c52:	8082                	ret

0000000000001c54 <close>:
    register long a7 __asm__("a7") = n;
    1c54:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c58:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c5c:	2501                	sext.w	a0,a0
    1c5e:	8082                	ret

0000000000001c60 <read>:
    register long a7 __asm__("a7") = n;
    1c60:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c64:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c68:	8082                	ret

0000000000001c6a <write>:
    register long a7 __asm__("a7") = n;
    1c6a:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c6e:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c72:	8082                	ret

0000000000001c74 <getpid>:
    register long a7 __asm__("a7") = n;
    1c74:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c78:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c7c:	2501                	sext.w	a0,a0
    1c7e:	8082                	ret

0000000000001c80 <getppid>:
    register long a7 __asm__("a7") = n;
    1c80:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c84:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c88:	2501                	sext.w	a0,a0
    1c8a:	8082                	ret

0000000000001c8c <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c8c:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c90:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c94:	2501                	sext.w	a0,a0
    1c96:	8082                	ret

0000000000001c98 <fork>:
    register long a7 __asm__("a7") = n;
    1c98:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1c9c:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1c9e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ca0:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1ca4:	2501                	sext.w	a0,a0
    1ca6:	8082                	ret

0000000000001ca8 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1ca8:	85b2                	mv	a1,a2
    1caa:	863a                	mv	a2,a4
    if (stack)
    1cac:	c191                	beqz	a1,1cb0 <clone+0x8>
	stack += stack_size;
    1cae:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cb0:	4781                	li	a5,0
    1cb2:	4701                	li	a4,0
    1cb4:	4681                	li	a3,0
    1cb6:	2601                	sext.w	a2,a2
    1cb8:	a2ed                	j	1ea2 <__clone>

0000000000001cba <exit>:
    register long a7 __asm__("a7") = n;
    1cba:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cbe:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cc2:	8082                	ret

0000000000001cc4 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cc4:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cc8:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cca:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1cce:	2501                	sext.w	a0,a0
    1cd0:	8082                	ret

0000000000001cd2 <exec>:
    register long a7 __asm__("a7") = n;
    1cd2:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1cd6:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cda:	2501                	sext.w	a0,a0
    1cdc:	8082                	ret

0000000000001cde <execve>:
    register long a7 __asm__("a7") = n;
    1cde:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ce2:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1ce6:	2501                	sext.w	a0,a0
    1ce8:	8082                	ret

0000000000001cea <times>:
    register long a7 __asm__("a7") = n;
    1cea:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1cee:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1cf2:	2501                	sext.w	a0,a0
    1cf4:	8082                	ret

0000000000001cf6 <get_time>:

int64 get_time()
{
    1cf6:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1cf8:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1cfc:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1cfe:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d00:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d04:	2501                	sext.w	a0,a0
    1d06:	ed09                	bnez	a0,1d20 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d08:	67a2                	ld	a5,8(sp)
    1d0a:	3e800713          	li	a4,1000
    1d0e:	00015503          	lhu	a0,0(sp)
    1d12:	02e7d7b3          	divu	a5,a5,a4
    1d16:	02e50533          	mul	a0,a0,a4
    1d1a:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d1c:	0141                	addi	sp,sp,16
    1d1e:	8082                	ret
        return -1;
    1d20:	557d                	li	a0,-1
    1d22:	bfed                	j	1d1c <get_time+0x26>

0000000000001d24 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d24:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d28:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d2c:	2501                	sext.w	a0,a0
    1d2e:	8082                	ret

0000000000001d30 <time>:
    register long a7 __asm__("a7") = n;
    1d30:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d34:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d38:	2501                	sext.w	a0,a0
    1d3a:	8082                	ret

0000000000001d3c <sleep>:

int sleep(unsigned long long time)
{
    1d3c:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d3e:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d40:	850a                	mv	a0,sp
    1d42:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d44:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d48:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d4a:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d4e:	e501                	bnez	a0,1d56 <sleep+0x1a>
    return 0;
    1d50:	4501                	li	a0,0
}
    1d52:	0141                	addi	sp,sp,16
    1d54:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d56:	4502                	lw	a0,0(sp)
}
    1d58:	0141                	addi	sp,sp,16
    1d5a:	8082                	ret

0000000000001d5c <set_priority>:
    register long a7 __asm__("a7") = n;
    1d5c:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d60:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d64:	2501                	sext.w	a0,a0
    1d66:	8082                	ret

0000000000001d68 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d68:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d6c:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d70:	8082                	ret

0000000000001d72 <munmap>:
    register long a7 __asm__("a7") = n;
    1d72:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d76:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d7a:	2501                	sext.w	a0,a0
    1d7c:	8082                	ret

0000000000001d7e <wait>:

int wait(int *code)
{
    1d7e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d80:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d84:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d86:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d88:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d8a:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1d8e:	2501                	sext.w	a0,a0
    1d90:	8082                	ret

0000000000001d92 <spawn>:
    register long a7 __asm__("a7") = n;
    1d92:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1d96:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1d9a:	2501                	sext.w	a0,a0
    1d9c:	8082                	ret

0000000000001d9e <mailread>:
    register long a7 __asm__("a7") = n;
    1d9e:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1da2:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1da6:	2501                	sext.w	a0,a0
    1da8:	8082                	ret

0000000000001daa <mailwrite>:
    register long a7 __asm__("a7") = n;
    1daa:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dae:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1db2:	2501                	sext.w	a0,a0
    1db4:	8082                	ret

0000000000001db6 <fstat>:
    register long a7 __asm__("a7") = n;
    1db6:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dba:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dbe:	2501                	sext.w	a0,a0
    1dc0:	8082                	ret

0000000000001dc2 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dc2:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dc4:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dc8:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dca:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1dce:	2501                	sext.w	a0,a0
    1dd0:	8082                	ret

0000000000001dd2 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1dd2:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1dd4:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1dd8:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dda:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1dde:	2501                	sext.w	a0,a0
    1de0:	8082                	ret

0000000000001de2 <link>:

int link(char *old_path, char *new_path)
{
    1de2:	87aa                	mv	a5,a0
    1de4:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1de6:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1dea:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1dee:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1df0:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1df4:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1df6:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1dfa:	2501                	sext.w	a0,a0
    1dfc:	8082                	ret

0000000000001dfe <unlink>:

int unlink(char *path)
{
    1dfe:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e00:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e04:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e08:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e0a:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e0e:	2501                	sext.w	a0,a0
    1e10:	8082                	ret

0000000000001e12 <uname>:
    register long a7 __asm__("a7") = n;
    1e12:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e16:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e1a:	2501                	sext.w	a0,a0
    1e1c:	8082                	ret

0000000000001e1e <brk>:
    register long a7 __asm__("a7") = n;
    1e1e:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e22:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e26:	2501                	sext.w	a0,a0
    1e28:	8082                	ret

0000000000001e2a <getcwd>:
    register long a7 __asm__("a7") = n;
    1e2a:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e2c:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e30:	8082                	ret

0000000000001e32 <chdir>:
    register long a7 __asm__("a7") = n;
    1e32:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e36:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e3a:	2501                	sext.w	a0,a0
    1e3c:	8082                	ret

0000000000001e3e <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e3e:	862e                	mv	a2,a1
    1e40:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e42:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e44:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e48:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e4c:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e4e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e50:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e54:	2501                	sext.w	a0,a0
    1e56:	8082                	ret

0000000000001e58 <getdents>:
    register long a7 __asm__("a7") = n;
    1e58:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e5c:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e60:	2501                	sext.w	a0,a0
    1e62:	8082                	ret

0000000000001e64 <pipe>:
    register long a7 __asm__("a7") = n;
    1e64:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e68:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e6a:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e6e:	2501                	sext.w	a0,a0
    1e70:	8082                	ret

0000000000001e72 <dup>:
    register long a7 __asm__("a7") = n;
    1e72:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e74:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e78:	2501                	sext.w	a0,a0
    1e7a:	8082                	ret

0000000000001e7c <dup2>:
    register long a7 __asm__("a7") = n;
    1e7c:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e7e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e80:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e84:	2501                	sext.w	a0,a0
    1e86:	8082                	ret

0000000000001e88 <mount>:
    register long a7 __asm__("a7") = n;
    1e88:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e8c:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1e90:	2501                	sext.w	a0,a0
    1e92:	8082                	ret

0000000000001e94 <umount>:
    register long a7 __asm__("a7") = n;
    1e94:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1e98:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e9a:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1e9e:	2501                	sext.w	a0,a0
    1ea0:	8082                	ret

0000000000001ea2 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ea2:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1ea4:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1ea6:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1ea8:	8532                	mv	a0,a2
	mv a2, a4
    1eaa:	863a                	mv	a2,a4
	mv a3, a5
    1eac:	86be                	mv	a3,a5
	mv a4, a6
    1eae:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1eb0:	0dc00893          	li	a7,220
	ecall
    1eb4:	00000073          	ecall

	beqz a0, 1f
    1eb8:	c111                	beqz	a0,1ebc <__clone+0x1a>
	# Parent
	ret
    1eba:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ebc:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ebe:	6522                	ld	a0,8(sp)
	jalr a1
    1ec0:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ec2:	05d00893          	li	a7,93
	ecall
    1ec6:	00000073          	ecall
