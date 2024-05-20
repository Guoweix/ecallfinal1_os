
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/test_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a83d                	j	1040 <__start_main>

0000000000001004 <main>:

/*
 * for execve
 */

int main(int argc, char *argv[]){
    1004:	1141                	addi	sp,sp,-16
    printf("  I am test_echo.\nexecve success.\n");
    1006:	00001517          	auipc	a0,0x1
    100a:	e6a50513          	addi	a0,a0,-406 # 1e70 <__clone+0x2a>
int main(int argc, char *argv[]){
    100e:	e406                	sd	ra,8(sp)
    printf("  I am test_echo.\nexecve success.\n");
    1010:	2c4000ef          	jal	12d4 <printf>
    TEST_END(__func__);
    1014:	00001517          	auipc	a0,0x1
    1018:	e8450513          	addi	a0,a0,-380 # 1e98 <__clone+0x52>
    101c:	296000ef          	jal	12b2 <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ea050513          	addi	a0,a0,-352 # 1ec0 <__func__.0>
    1028:	28a000ef          	jal	12b2 <puts>
    102c:	00001517          	auipc	a0,0x1
    1030:	e7c50513          	addi	a0,a0,-388 # 1ea8 <__clone+0x62>
    1034:	27e000ef          	jal	12b2 <puts>
    return 0;
}
    1038:	60a2                	ld	ra,8(sp)
    103a:	4501                	li	a0,0
    103c:	0141                	addi	sp,sp,16
    103e:	8082                	ret

0000000000001040 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    1040:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    1042:	4108                	lw	a0,0(a0)
{
    1044:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1046:	05a1                	addi	a1,a1,8
{
    1048:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    104a:	fbbff0ef          	jal	1004 <main>
    104e:	411000ef          	jal	1c5e <exit>
	return 0;
}
    1052:	60a2                	ld	ra,8(sp)
    1054:	4501                	li	a0,0
    1056:	0141                	addi	sp,sp,16
    1058:	8082                	ret

000000000000105a <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    105a:	7179                	addi	sp,sp,-48
    105c:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    105e:	12054b63          	bltz	a0,1194 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    1062:	02b577bb          	remuw	a5,a0,a1
    1066:	00001617          	auipc	a2,0x1
    106a:	e7a60613          	addi	a2,a2,-390 # 1ee0 <digits>
    buf[16] = 0;
    106e:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1072:	0005871b          	sext.w	a4,a1
    1076:	1782                	slli	a5,a5,0x20
    1078:	9381                	srli	a5,a5,0x20
    107a:	97b2                	add	a5,a5,a2
    107c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1080:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1084:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1088:	1cb56363          	bltu	a0,a1,124e <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    108c:	45b9                	li	a1,14
    108e:	02e877bb          	remuw	a5,a6,a4
    1092:	1782                	slli	a5,a5,0x20
    1094:	9381                	srli	a5,a5,0x20
    1096:	97b2                	add	a5,a5,a2
    1098:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    109c:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    10a0:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    10a4:	0ce86e63          	bltu	a6,a4,1180 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    10a8:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    10ac:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    10b0:	1582                	slli	a1,a1,0x20
    10b2:	9181                	srli	a1,a1,0x20
    10b4:	95b2                	add	a1,a1,a2
    10b6:	0005c583          	lbu	a1,0(a1)
    10ba:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    10be:	0007859b          	sext.w	a1,a5
    10c2:	12e6ec63          	bltu	a3,a4,11fa <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    10c6:	02e7f6bb          	remuw	a3,a5,a4
    10ca:	1682                	slli	a3,a3,0x20
    10cc:	9281                	srli	a3,a3,0x20
    10ce:	96b2                	add	a3,a3,a2
    10d0:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    10d4:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    10d8:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    10dc:	12e5e863          	bltu	a1,a4,120c <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    10e0:	02e876bb          	remuw	a3,a6,a4
    10e4:	1682                	slli	a3,a3,0x20
    10e6:	9281                	srli	a3,a3,0x20
    10e8:	96b2                	add	a3,a3,a2
    10ea:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    10ee:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    10f2:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    10f6:	12e86463          	bltu	a6,a4,121e <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    10fa:	02e5f6bb          	remuw	a3,a1,a4
    10fe:	1682                	slli	a3,a3,0x20
    1100:	9281                	srli	a3,a3,0x20
    1102:	96b2                	add	a3,a3,a2
    1104:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1108:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    110c:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    1110:	0ce5ec63          	bltu	a1,a4,11e8 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    1114:	02e876bb          	remuw	a3,a6,a4
    1118:	1682                	slli	a3,a3,0x20
    111a:	9281                	srli	a3,a3,0x20
    111c:	96b2                	add	a3,a3,a2
    111e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1122:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1126:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    112a:	10e86963          	bltu	a6,a4,123c <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    112e:	02e5f6bb          	remuw	a3,a1,a4
    1132:	1682                	slli	a3,a3,0x20
    1134:	9281                	srli	a3,a3,0x20
    1136:	96b2                	add	a3,a3,a2
    1138:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    113c:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1140:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1144:	10e5e763          	bltu	a1,a4,1252 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    1148:	02e876bb          	remuw	a3,a6,a4
    114c:	1682                	slli	a3,a3,0x20
    114e:	9281                	srli	a3,a3,0x20
    1150:	96b2                	add	a3,a3,a2
    1152:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1156:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    115a:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    115e:	10e86363          	bltu	a6,a4,1264 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    1162:	1782                	slli	a5,a5,0x20
    1164:	9381                	srli	a5,a5,0x20
    1166:	97b2                	add	a5,a5,a2
    1168:	0007c783          	lbu	a5,0(a5)
    116c:	4599                	li	a1,6
    116e:	00f10723          	sb	a5,14(sp)

    if (sign)
    1172:	00055763          	bgez	a0,1180 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1176:	02d00793          	li	a5,45
    117a:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    117e:	4595                	li	a1,5
    write(f, s, l);
    1180:	003c                	addi	a5,sp,8
    1182:	4641                	li	a2,16
    1184:	9e0d                	subw	a2,a2,a1
    1186:	4505                	li	a0,1
    1188:	95be                	add	a1,a1,a5
    118a:	285000ef          	jal	1c0e <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    118e:	70a2                	ld	ra,40(sp)
    1190:	6145                	addi	sp,sp,48
    1192:	8082                	ret
        x = -xx;
    1194:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1198:	02b877bb          	remuw	a5,a6,a1
    119c:	00001617          	auipc	a2,0x1
    11a0:	d4460613          	addi	a2,a2,-700 # 1ee0 <digits>
    buf[16] = 0;
    11a4:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    11a8:	0005871b          	sext.w	a4,a1
    11ac:	1782                	slli	a5,a5,0x20
    11ae:	9381                	srli	a5,a5,0x20
    11b0:	97b2                	add	a5,a5,a2
    11b2:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    11b6:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    11ba:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    11be:	06b86963          	bltu	a6,a1,1230 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    11c2:	02e8f7bb          	remuw	a5,a7,a4
    11c6:	1782                	slli	a5,a5,0x20
    11c8:	9381                	srli	a5,a5,0x20
    11ca:	97b2                	add	a5,a5,a2
    11cc:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    11d0:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    11d4:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    11d8:	ece8f8e3          	bgeu	a7,a4,10a8 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    11dc:	02d00793          	li	a5,45
    11e0:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    11e4:	45b5                	li	a1,13
    11e6:	bf69                	j	1180 <printint.constprop.0+0x126>
    11e8:	45a9                	li	a1,10
    if (sign)
    11ea:	f8055be3          	bgez	a0,1180 <printint.constprop.0+0x126>
        buf[i--] = '-';
    11ee:	02d00793          	li	a5,45
    11f2:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    11f6:	45a5                	li	a1,9
    11f8:	b761                	j	1180 <printint.constprop.0+0x126>
    11fa:	45b5                	li	a1,13
    if (sign)
    11fc:	f80552e3          	bgez	a0,1180 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1200:	02d00793          	li	a5,45
    1204:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1208:	45b1                	li	a1,12
    120a:	bf9d                	j	1180 <printint.constprop.0+0x126>
    120c:	45b1                	li	a1,12
    if (sign)
    120e:	f60559e3          	bgez	a0,1180 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1212:	02d00793          	li	a5,45
    1216:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    121a:	45ad                	li	a1,11
    121c:	b795                	j	1180 <printint.constprop.0+0x126>
    121e:	45ad                	li	a1,11
    if (sign)
    1220:	f60550e3          	bgez	a0,1180 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1224:	02d00793          	li	a5,45
    1228:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    122c:	45a9                	li	a1,10
    122e:	bf89                	j	1180 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1230:	02d00793          	li	a5,45
    1234:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1238:	45b9                	li	a1,14
    123a:	b799                	j	1180 <printint.constprop.0+0x126>
    123c:	45a5                	li	a1,9
    if (sign)
    123e:	f40551e3          	bgez	a0,1180 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1242:	02d00793          	li	a5,45
    1246:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    124a:	45a1                	li	a1,8
    124c:	bf15                	j	1180 <printint.constprop.0+0x126>
    i = 15;
    124e:	45bd                	li	a1,15
    1250:	bf05                	j	1180 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1252:	45a1                	li	a1,8
    if (sign)
    1254:	f20556e3          	bgez	a0,1180 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1258:	02d00793          	li	a5,45
    125c:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    1260:	459d                	li	a1,7
    1262:	bf39                	j	1180 <printint.constprop.0+0x126>
    1264:	459d                	li	a1,7
    if (sign)
    1266:	f0055de3          	bgez	a0,1180 <printint.constprop.0+0x126>
        buf[i--] = '-';
    126a:	02d00793          	li	a5,45
    126e:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    1272:	4599                	li	a1,6
    1274:	b731                	j	1180 <printint.constprop.0+0x126>

0000000000001276 <getchar>:
{
    1276:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1278:	00f10593          	addi	a1,sp,15
    127c:	4605                	li	a2,1
    127e:	4501                	li	a0,0
{
    1280:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1282:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1286:	17f000ef          	jal	1c04 <read>
}
    128a:	60e2                	ld	ra,24(sp)
    128c:	00f14503          	lbu	a0,15(sp)
    1290:	6105                	addi	sp,sp,32
    1292:	8082                	ret

0000000000001294 <putchar>:
{
    1294:	1101                	addi	sp,sp,-32
    1296:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1298:	00f10593          	addi	a1,sp,15
    129c:	4605                	li	a2,1
    129e:	4505                	li	a0,1
{
    12a0:	ec06                	sd	ra,24(sp)
    char byte = c;
    12a2:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12a6:	169000ef          	jal	1c0e <write>
}
    12aa:	60e2                	ld	ra,24(sp)
    12ac:	2501                	sext.w	a0,a0
    12ae:	6105                	addi	sp,sp,32
    12b0:	8082                	ret

00000000000012b2 <puts>:
{
    12b2:	1141                	addi	sp,sp,-16
    12b4:	e406                	sd	ra,8(sp)
    12b6:	e022                	sd	s0,0(sp)
    12b8:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    12ba:	570000ef          	jal	182a <strlen>
    12be:	862a                	mv	a2,a0
    12c0:	85a2                	mv	a1,s0
    12c2:	4505                	li	a0,1
    12c4:	14b000ef          	jal	1c0e <write>
}
    12c8:	60a2                	ld	ra,8(sp)
    12ca:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    12cc:	957d                	srai	a0,a0,0x3f
    return r;
    12ce:	2501                	sext.w	a0,a0
}
    12d0:	0141                	addi	sp,sp,16
    12d2:	8082                	ret

00000000000012d4 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    12d4:	7131                	addi	sp,sp,-192
    12d6:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    12d8:	013c                	addi	a5,sp,136
{
    12da:	f0ca                	sd	s2,96(sp)
    12dc:	ecce                	sd	s3,88(sp)
    12de:	e8d2                	sd	s4,80(sp)
    12e0:	e4d6                	sd	s5,72(sp)
    12e2:	e0da                	sd	s6,64(sp)
    12e4:	fc5e                	sd	s7,56(sp)
    12e6:	fc86                	sd	ra,120(sp)
    12e8:	f8a2                	sd	s0,112(sp)
    12ea:	f4a6                	sd	s1,104(sp)
    12ec:	e52e                	sd	a1,136(sp)
    12ee:	e932                	sd	a2,144(sp)
    12f0:	ed36                	sd	a3,152(sp)
    12f2:	f13a                	sd	a4,160(sp)
    12f4:	f942                	sd	a6,176(sp)
    12f6:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    12f8:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    12fa:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    12fe:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1302:	00001b97          	auipc	s7,0x1
    1306:	bb6b8b93          	addi	s7,s7,-1098 # 1eb8 <__clone+0x72>
        switch (s[1])
    130a:	07800a93          	li	s5,120
    130e:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1312:	00001997          	auipc	s3,0x1
    1316:	bce98993          	addi	s3,s3,-1074 # 1ee0 <digits>
        if (!*s)
    131a:	00054783          	lbu	a5,0(a0)
    131e:	16078c63          	beqz	a5,1496 <printf+0x1c2>
    1322:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1324:	19278463          	beq	a5,s2,14ac <printf+0x1d8>
    1328:	00164783          	lbu	a5,1(a2)
    132c:	0605                	addi	a2,a2,1
    132e:	fbfd                	bnez	a5,1324 <printf+0x50>
    1330:	84b2                	mv	s1,a2
        l = z - a;
    1332:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1336:	85aa                	mv	a1,a0
    1338:	8622                	mv	a2,s0
    133a:	4505                	li	a0,1
    133c:	0d3000ef          	jal	1c0e <write>
        if (l)
    1340:	18041f63          	bnez	s0,14de <printf+0x20a>
        if (s[1] == 0)
    1344:	0014c783          	lbu	a5,1(s1)
    1348:	14078763          	beqz	a5,1496 <printf+0x1c2>
        switch (s[1])
    134c:	1d478163          	beq	a5,s4,150e <printf+0x23a>
    1350:	18fa6963          	bltu	s4,a5,14e2 <printf+0x20e>
    1354:	1b678363          	beq	a5,s6,14fa <printf+0x226>
    1358:	07000713          	li	a4,112
    135c:	1ce79c63          	bne	a5,a4,1534 <printf+0x260>
            printptr(va_arg(ap, uint64));
    1360:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    1362:	03000793          	li	a5,48
    1366:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    136a:	631c                	ld	a5,0(a4)
    136c:	0721                	addi	a4,a4,8
    136e:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1370:	00479f93          	slli	t6,a5,0x4
    1374:	00879f13          	slli	t5,a5,0x8
    1378:	00c79e93          	slli	t4,a5,0xc
    137c:	01079e13          	slli	t3,a5,0x10
    1380:	01479313          	slli	t1,a5,0x14
    1384:	01879893          	slli	a7,a5,0x18
    1388:	01c79713          	slli	a4,a5,0x1c
    138c:	02479813          	slli	a6,a5,0x24
    1390:	02879513          	slli	a0,a5,0x28
    1394:	02c79593          	slli	a1,a5,0x2c
    1398:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    139c:	03c7d293          	srli	t0,a5,0x3c
    13a0:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13a4:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13a8:	03cfdf93          	srli	t6,t6,0x3c
    13ac:	03cf5f13          	srli	t5,t5,0x3c
    13b0:	03cede93          	srli	t4,t4,0x3c
    13b4:	03ce5e13          	srli	t3,t3,0x3c
    13b8:	03c35313          	srli	t1,t1,0x3c
    13bc:	03c8d893          	srli	a7,a7,0x3c
    13c0:	9371                	srli	a4,a4,0x3c
    13c2:	03c85813          	srli	a6,a6,0x3c
    13c6:	9171                	srli	a0,a0,0x3c
    13c8:	91f1                	srli	a1,a1,0x3c
    13ca:	9271                	srli	a2,a2,0x3c
    13cc:	974e                	add	a4,a4,s3
    13ce:	92f1                	srli	a3,a3,0x3c
    13d0:	92ce                	add	t0,t0,s3
    13d2:	9fce                	add	t6,t6,s3
    13d4:	9f4e                	add	t5,t5,s3
    13d6:	9ece                	add	t4,t4,s3
    13d8:	9e4e                	add	t3,t3,s3
    13da:	934e                	add	t1,t1,s3
    13dc:	98ce                	add	a7,a7,s3
    13de:	93ce                	add	t2,t2,s3
    13e0:	984e                	add	a6,a6,s3
    13e2:	954e                	add	a0,a0,s3
    13e4:	95ce                	add	a1,a1,s3
    13e6:	964e                	add	a2,a2,s3
    13e8:	0002c283          	lbu	t0,0(t0)
    13ec:	000fcf83          	lbu	t6,0(t6)
    13f0:	000f4f03          	lbu	t5,0(t5)
    13f4:	000ece83          	lbu	t4,0(t4)
    13f8:	000e4e03          	lbu	t3,0(t3)
    13fc:	00034303          	lbu	t1,0(t1)
    1400:	0008c883          	lbu	a7,0(a7)
    1404:	00074403          	lbu	s0,0(a4)
    1408:	0003c383          	lbu	t2,0(t2)
    140c:	00084803          	lbu	a6,0(a6)
    1410:	00054503          	lbu	a0,0(a0)
    1414:	0005c583          	lbu	a1,0(a1)
    1418:	00064603          	lbu	a2,0(a2)
    141c:	00d98733          	add	a4,s3,a3
    1420:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1424:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1428:	9371                	srli	a4,a4,0x3c
    142a:	8bbd                	andi	a5,a5,15
    142c:	00510523          	sb	t0,10(sp)
    1430:	01f105a3          	sb	t6,11(sp)
    1434:	01e10623          	sb	t5,12(sp)
    1438:	01d106a3          	sb	t4,13(sp)
    143c:	01c10723          	sb	t3,14(sp)
    1440:	006107a3          	sb	t1,15(sp)
    1444:	01110823          	sb	a7,16(sp)
    1448:	00710923          	sb	t2,18(sp)
    144c:	010109a3          	sb	a6,19(sp)
    1450:	00a10a23          	sb	a0,20(sp)
    1454:	00b10aa3          	sb	a1,21(sp)
    1458:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    145c:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1460:	008108a3          	sb	s0,17(sp)
    1464:	974e                	add	a4,a4,s3
    1466:	97ce                	add	a5,a5,s3
    1468:	00d10ba3          	sb	a3,23(sp)
    146c:	00074703          	lbu	a4,0(a4)
    1470:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1474:	4649                	li	a2,18
    1476:	002c                	addi	a1,sp,8
    1478:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    147a:	00e10c23          	sb	a4,24(sp)
    147e:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1482:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1486:	788000ef          	jal	1c0e <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    148a:	00248513          	addi	a0,s1,2
        if (!*s)
    148e:	00054783          	lbu	a5,0(a0)
    1492:	e80798e3          	bnez	a5,1322 <printf+0x4e>
    }
    va_end(ap);
}
    1496:	70e6                	ld	ra,120(sp)
    1498:	7446                	ld	s0,112(sp)
    149a:	74a6                	ld	s1,104(sp)
    149c:	7906                	ld	s2,96(sp)
    149e:	69e6                	ld	s3,88(sp)
    14a0:	6a46                	ld	s4,80(sp)
    14a2:	6aa6                	ld	s5,72(sp)
    14a4:	6b06                	ld	s6,64(sp)
    14a6:	7be2                	ld	s7,56(sp)
    14a8:	6129                	addi	sp,sp,192
    14aa:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14ac:	00064783          	lbu	a5,0(a2)
    14b0:	84b2                	mv	s1,a2
    14b2:	01278963          	beq	a5,s2,14c4 <printf+0x1f0>
    14b6:	bdb5                	j	1332 <printf+0x5e>
    14b8:	0024c783          	lbu	a5,2(s1)
    14bc:	0605                	addi	a2,a2,1
    14be:	0489                	addi	s1,s1,2
    14c0:	e72799e3          	bne	a5,s2,1332 <printf+0x5e>
    14c4:	0014c783          	lbu	a5,1(s1)
    14c8:	ff2788e3          	beq	a5,s2,14b8 <printf+0x1e4>
        l = z - a;
    14cc:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    14d0:	85aa                	mv	a1,a0
    14d2:	8622                	mv	a2,s0
    14d4:	4505                	li	a0,1
    14d6:	738000ef          	jal	1c0e <write>
        if (l)
    14da:	e60405e3          	beqz	s0,1344 <printf+0x70>
    14de:	8526                	mv	a0,s1
    14e0:	bd2d                	j	131a <printf+0x46>
        switch (s[1])
    14e2:	05579963          	bne	a5,s5,1534 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    14e6:	6782                	ld	a5,0(sp)
    14e8:	45c1                	li	a1,16
    14ea:	4388                	lw	a0,0(a5)
    14ec:	07a1                	addi	a5,a5,8
    14ee:	e03e                	sd	a5,0(sp)
    14f0:	b6bff0ef          	jal	105a <printint.constprop.0>
        s += 2;
    14f4:	00248513          	addi	a0,s1,2
    14f8:	bf59                	j	148e <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    14fa:	6782                	ld	a5,0(sp)
    14fc:	45a9                	li	a1,10
    14fe:	4388                	lw	a0,0(a5)
    1500:	07a1                	addi	a5,a5,8
    1502:	e03e                	sd	a5,0(sp)
    1504:	b57ff0ef          	jal	105a <printint.constprop.0>
        s += 2;
    1508:	00248513          	addi	a0,s1,2
    150c:	b749                	j	148e <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    150e:	6782                	ld	a5,0(sp)
    1510:	6380                	ld	s0,0(a5)
    1512:	07a1                	addi	a5,a5,8
    1514:	e03e                	sd	a5,0(sp)
    1516:	c031                	beqz	s0,155a <printf+0x286>
            l = strnlen(a, 200);
    1518:	0c800593          	li	a1,200
    151c:	8522                	mv	a0,s0
    151e:	3f8000ef          	jal	1916 <strnlen>
    write(f, s, l);
    1522:	0005061b          	sext.w	a2,a0
    1526:	85a2                	mv	a1,s0
    1528:	4505                	li	a0,1
    152a:	6e4000ef          	jal	1c0e <write>
        s += 2;
    152e:	00248513          	addi	a0,s1,2
    1532:	bfb1                	j	148e <printf+0x1ba>
    return write(stdout, &byte, 1);
    1534:	4605                	li	a2,1
    1536:	002c                	addi	a1,sp,8
    1538:	4505                	li	a0,1
    char byte = c;
    153a:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    153e:	6d0000ef          	jal	1c0e <write>
    char byte = c;
    1542:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    1546:	4605                	li	a2,1
    1548:	002c                	addi	a1,sp,8
    154a:	4505                	li	a0,1
    char byte = c;
    154c:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1550:	6be000ef          	jal	1c0e <write>
        s += 2;
    1554:	00248513          	addi	a0,s1,2
    1558:	bf1d                	j	148e <printf+0x1ba>
                a = "(null)";
    155a:	845e                	mv	s0,s7
    155c:	bf75                	j	1518 <printf+0x244>

000000000000155e <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    155e:	02000793          	li	a5,32
    1562:	00f50663          	beq	a0,a5,156e <isspace+0x10>
    1566:	355d                	addiw	a0,a0,-9
    1568:	00553513          	sltiu	a0,a0,5
    156c:	8082                	ret
    156e:	4505                	li	a0,1
}
    1570:	8082                	ret

0000000000001572 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1572:	fd05051b          	addiw	a0,a0,-48
}
    1576:	00a53513          	sltiu	a0,a0,10
    157a:	8082                	ret

000000000000157c <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    157c:	02000613          	li	a2,32
    1580:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1582:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1586:	ff77069b          	addiw	a3,a4,-9
    158a:	04c70d63          	beq	a4,a2,15e4 <atoi+0x68>
    158e:	0007079b          	sext.w	a5,a4
    1592:	04d5f963          	bgeu	a1,a3,15e4 <atoi+0x68>
        s++;
    switch (*s)
    1596:	02b00693          	li	a3,43
    159a:	04d70a63          	beq	a4,a3,15ee <atoi+0x72>
    159e:	02d00693          	li	a3,45
    15a2:	06d70463          	beq	a4,a3,160a <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    15a6:	fd07859b          	addiw	a1,a5,-48
    15aa:	4625                	li	a2,9
    15ac:	873e                	mv	a4,a5
    15ae:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    15b0:	4e01                	li	t3,0
    while (isdigit(*s))
    15b2:	04b66a63          	bltu	a2,a1,1606 <atoi+0x8a>
    int n = 0, neg = 0;
    15b6:	4501                	li	a0,0
    while (isdigit(*s))
    15b8:	4825                	li	a6,9
    15ba:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    15be:	0025179b          	slliw	a5,a0,0x2
    15c2:	9d3d                	addw	a0,a0,a5
    15c4:	fd07031b          	addiw	t1,a4,-48
    15c8:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    15cc:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    15d0:	0685                	addi	a3,a3,1
    15d2:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    15d6:	0006071b          	sext.w	a4,a2
    15da:	feb870e3          	bgeu	a6,a1,15ba <atoi+0x3e>
    return neg ? n : -n;
    15de:	000e0563          	beqz	t3,15e8 <atoi+0x6c>
}
    15e2:	8082                	ret
        s++;
    15e4:	0505                	addi	a0,a0,1
    15e6:	bf71                	j	1582 <atoi+0x6>
    return neg ? n : -n;
    15e8:	4113053b          	subw	a0,t1,a7
    15ec:	8082                	ret
    while (isdigit(*s))
    15ee:	00154783          	lbu	a5,1(a0)
    15f2:	4625                	li	a2,9
        s++;
    15f4:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    15f8:	fd07859b          	addiw	a1,a5,-48
    15fc:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1600:	4e01                	li	t3,0
    while (isdigit(*s))
    1602:	fab67ae3          	bgeu	a2,a1,15b6 <atoi+0x3a>
    1606:	4501                	li	a0,0
}
    1608:	8082                	ret
    while (isdigit(*s))
    160a:	00154783          	lbu	a5,1(a0)
    160e:	4625                	li	a2,9
        s++;
    1610:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1614:	fd07859b          	addiw	a1,a5,-48
    1618:	0007871b          	sext.w	a4,a5
    161c:	feb665e3          	bltu	a2,a1,1606 <atoi+0x8a>
        neg = 1;
    1620:	4e05                	li	t3,1
    1622:	bf51                	j	15b6 <atoi+0x3a>

0000000000001624 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1624:	16060d63          	beqz	a2,179e <memset+0x17a>
    1628:	40a007b3          	neg	a5,a0
    162c:	8b9d                	andi	a5,a5,7
    162e:	00778713          	addi	a4,a5,7
    1632:	482d                	li	a6,11
    1634:	0ff5f593          	zext.b	a1,a1
    1638:	fff60693          	addi	a3,a2,-1
    163c:	17076263          	bltu	a4,a6,17a0 <memset+0x17c>
    1640:	16e6ea63          	bltu	a3,a4,17b4 <memset+0x190>
    1644:	16078563          	beqz	a5,17ae <memset+0x18a>
    1648:	00b50023          	sb	a1,0(a0)
    164c:	4705                	li	a4,1
    164e:	00150e93          	addi	t4,a0,1
    1652:	14e78c63          	beq	a5,a4,17aa <memset+0x186>
    1656:	00b500a3          	sb	a1,1(a0)
    165a:	4709                	li	a4,2
    165c:	00250e93          	addi	t4,a0,2
    1660:	14e78d63          	beq	a5,a4,17ba <memset+0x196>
    1664:	00b50123          	sb	a1,2(a0)
    1668:	470d                	li	a4,3
    166a:	00350e93          	addi	t4,a0,3
    166e:	12e78b63          	beq	a5,a4,17a4 <memset+0x180>
    1672:	00b501a3          	sb	a1,3(a0)
    1676:	4711                	li	a4,4
    1678:	00450e93          	addi	t4,a0,4
    167c:	14e78163          	beq	a5,a4,17be <memset+0x19a>
    1680:	00b50223          	sb	a1,4(a0)
    1684:	4715                	li	a4,5
    1686:	00550e93          	addi	t4,a0,5
    168a:	12e78c63          	beq	a5,a4,17c2 <memset+0x19e>
    168e:	00b502a3          	sb	a1,5(a0)
    1692:	471d                	li	a4,7
    1694:	00650e93          	addi	t4,a0,6
    1698:	12e79763          	bne	a5,a4,17c6 <memset+0x1a2>
    169c:	00750e93          	addi	t4,a0,7
    16a0:	00b50323          	sb	a1,6(a0)
    16a4:	4f1d                	li	t5,7
    16a6:	00859713          	slli	a4,a1,0x8
    16aa:	8f4d                	or	a4,a4,a1
    16ac:	01059e13          	slli	t3,a1,0x10
    16b0:	01c76e33          	or	t3,a4,t3
    16b4:	01859313          	slli	t1,a1,0x18
    16b8:	006e6333          	or	t1,t3,t1
    16bc:	02059893          	slli	a7,a1,0x20
    16c0:	011368b3          	or	a7,t1,a7
    16c4:	02859813          	slli	a6,a1,0x28
    16c8:	40f60333          	sub	t1,a2,a5
    16cc:	0108e833          	or	a6,a7,a6
    16d0:	03059693          	slli	a3,a1,0x30
    16d4:	00d866b3          	or	a3,a6,a3
    16d8:	03859713          	slli	a4,a1,0x38
    16dc:	97aa                	add	a5,a5,a0
    16de:	ff837813          	andi	a6,t1,-8
    16e2:	8f55                	or	a4,a4,a3
    16e4:	00f806b3          	add	a3,a6,a5
    16e8:	e398                	sd	a4,0(a5)
    16ea:	07a1                	addi	a5,a5,8
    16ec:	fed79ee3          	bne	a5,a3,16e8 <memset+0xc4>
    16f0:	ff837693          	andi	a3,t1,-8
    16f4:	00de87b3          	add	a5,t4,a3
    16f8:	01e6873b          	addw	a4,a3,t5
    16fc:	0ad30663          	beq	t1,a3,17a8 <memset+0x184>
    1700:	00b78023          	sb	a1,0(a5)
    1704:	0017069b          	addiw	a3,a4,1
    1708:	08c6fb63          	bgeu	a3,a2,179e <memset+0x17a>
    170c:	00b780a3          	sb	a1,1(a5)
    1710:	0027069b          	addiw	a3,a4,2
    1714:	08c6f563          	bgeu	a3,a2,179e <memset+0x17a>
    1718:	00b78123          	sb	a1,2(a5)
    171c:	0037069b          	addiw	a3,a4,3
    1720:	06c6ff63          	bgeu	a3,a2,179e <memset+0x17a>
    1724:	00b781a3          	sb	a1,3(a5)
    1728:	0047069b          	addiw	a3,a4,4
    172c:	06c6f963          	bgeu	a3,a2,179e <memset+0x17a>
    1730:	00b78223          	sb	a1,4(a5)
    1734:	0057069b          	addiw	a3,a4,5
    1738:	06c6f363          	bgeu	a3,a2,179e <memset+0x17a>
    173c:	00b782a3          	sb	a1,5(a5)
    1740:	0067069b          	addiw	a3,a4,6
    1744:	04c6fd63          	bgeu	a3,a2,179e <memset+0x17a>
    1748:	00b78323          	sb	a1,6(a5)
    174c:	0077069b          	addiw	a3,a4,7
    1750:	04c6f763          	bgeu	a3,a2,179e <memset+0x17a>
    1754:	00b783a3          	sb	a1,7(a5)
    1758:	0087069b          	addiw	a3,a4,8
    175c:	04c6f163          	bgeu	a3,a2,179e <memset+0x17a>
    1760:	00b78423          	sb	a1,8(a5)
    1764:	0097069b          	addiw	a3,a4,9
    1768:	02c6fb63          	bgeu	a3,a2,179e <memset+0x17a>
    176c:	00b784a3          	sb	a1,9(a5)
    1770:	00a7069b          	addiw	a3,a4,10
    1774:	02c6f563          	bgeu	a3,a2,179e <memset+0x17a>
    1778:	00b78523          	sb	a1,10(a5)
    177c:	00b7069b          	addiw	a3,a4,11
    1780:	00c6ff63          	bgeu	a3,a2,179e <memset+0x17a>
    1784:	00b785a3          	sb	a1,11(a5)
    1788:	00c7069b          	addiw	a3,a4,12
    178c:	00c6f963          	bgeu	a3,a2,179e <memset+0x17a>
    1790:	00b78623          	sb	a1,12(a5)
    1794:	2735                	addiw	a4,a4,13
    1796:	00c77463          	bgeu	a4,a2,179e <memset+0x17a>
    179a:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    179e:	8082                	ret
    17a0:	472d                	li	a4,11
    17a2:	bd79                	j	1640 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    17a4:	4f0d                	li	t5,3
    17a6:	b701                	j	16a6 <memset+0x82>
    17a8:	8082                	ret
    17aa:	4f05                	li	t5,1
    17ac:	bded                	j	16a6 <memset+0x82>
    17ae:	8eaa                	mv	t4,a0
    17b0:	4f01                	li	t5,0
    17b2:	bdd5                	j	16a6 <memset+0x82>
    17b4:	87aa                	mv	a5,a0
    17b6:	4701                	li	a4,0
    17b8:	b7a1                	j	1700 <memset+0xdc>
    17ba:	4f09                	li	t5,2
    17bc:	b5ed                	j	16a6 <memset+0x82>
    17be:	4f11                	li	t5,4
    17c0:	b5dd                	j	16a6 <memset+0x82>
    17c2:	4f15                	li	t5,5
    17c4:	b5cd                	j	16a6 <memset+0x82>
    17c6:	4f19                	li	t5,6
    17c8:	bdf9                	j	16a6 <memset+0x82>

00000000000017ca <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    17ca:	00054783          	lbu	a5,0(a0)
    17ce:	0005c703          	lbu	a4,0(a1)
    17d2:	00e79863          	bne	a5,a4,17e2 <strcmp+0x18>
    17d6:	0505                	addi	a0,a0,1
    17d8:	0585                	addi	a1,a1,1
    17da:	fbe5                	bnez	a5,17ca <strcmp>
    17dc:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    17de:	9d19                	subw	a0,a0,a4
    17e0:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    17e2:	0007851b          	sext.w	a0,a5
    17e6:	bfe5                	j	17de <strcmp+0x14>

00000000000017e8 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    17e8:	ce05                	beqz	a2,1820 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    17ea:	00054703          	lbu	a4,0(a0)
    17ee:	0005c783          	lbu	a5,0(a1)
    17f2:	cb0d                	beqz	a4,1824 <strncmp+0x3c>
    if (!n--)
    17f4:	167d                	addi	a2,a2,-1
    17f6:	00c506b3          	add	a3,a0,a2
    17fa:	a819                	j	1810 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    17fc:	00a68e63          	beq	a3,a0,1818 <strncmp+0x30>
    1800:	0505                	addi	a0,a0,1
    1802:	00e79b63          	bne	a5,a4,1818 <strncmp+0x30>
    1806:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    180a:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    180e:	cb19                	beqz	a4,1824 <strncmp+0x3c>
    1810:	0005c783          	lbu	a5,0(a1)
    1814:	0585                	addi	a1,a1,1
    1816:	f3fd                	bnez	a5,17fc <strncmp+0x14>
    return *l - *r;
    1818:	0007051b          	sext.w	a0,a4
    181c:	9d1d                	subw	a0,a0,a5
    181e:	8082                	ret
        return 0;
    1820:	4501                	li	a0,0
}
    1822:	8082                	ret
    1824:	4501                	li	a0,0
    return *l - *r;
    1826:	9d1d                	subw	a0,a0,a5
    1828:	8082                	ret

000000000000182a <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    182a:	00757793          	andi	a5,a0,7
    182e:	cf89                	beqz	a5,1848 <strlen+0x1e>
    1830:	87aa                	mv	a5,a0
    1832:	a029                	j	183c <strlen+0x12>
    1834:	0785                	addi	a5,a5,1
    1836:	0077f713          	andi	a4,a5,7
    183a:	cb01                	beqz	a4,184a <strlen+0x20>
        if (!*s)
    183c:	0007c703          	lbu	a4,0(a5)
    1840:	fb75                	bnez	a4,1834 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    1842:	40a78533          	sub	a0,a5,a0
}
    1846:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1848:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    184a:	6394                	ld	a3,0(a5)
    184c:	00000597          	auipc	a1,0x0
    1850:	67c5b583          	ld	a1,1660(a1) # 1ec8 <__func__.0+0x8>
    1854:	00000617          	auipc	a2,0x0
    1858:	67c63603          	ld	a2,1660(a2) # 1ed0 <__func__.0+0x10>
    185c:	a019                	j	1862 <strlen+0x38>
    185e:	6794                	ld	a3,8(a5)
    1860:	07a1                	addi	a5,a5,8
    1862:	00b68733          	add	a4,a3,a1
    1866:	fff6c693          	not	a3,a3
    186a:	8f75                	and	a4,a4,a3
    186c:	8f71                	and	a4,a4,a2
    186e:	db65                	beqz	a4,185e <strlen+0x34>
    for (; *s; s++)
    1870:	0007c703          	lbu	a4,0(a5)
    1874:	d779                	beqz	a4,1842 <strlen+0x18>
    1876:	0017c703          	lbu	a4,1(a5)
    187a:	0785                	addi	a5,a5,1
    187c:	d379                	beqz	a4,1842 <strlen+0x18>
    187e:	0017c703          	lbu	a4,1(a5)
    1882:	0785                	addi	a5,a5,1
    1884:	fb6d                	bnez	a4,1876 <strlen+0x4c>
    1886:	bf75                	j	1842 <strlen+0x18>

0000000000001888 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1888:	00757713          	andi	a4,a0,7
{
    188c:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    188e:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1892:	cb19                	beqz	a4,18a8 <memchr+0x20>
    1894:	ce25                	beqz	a2,190c <memchr+0x84>
    1896:	0007c703          	lbu	a4,0(a5)
    189a:	04b70e63          	beq	a4,a1,18f6 <memchr+0x6e>
    189e:	0785                	addi	a5,a5,1
    18a0:	0077f713          	andi	a4,a5,7
    18a4:	167d                	addi	a2,a2,-1
    18a6:	f77d                	bnez	a4,1894 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    18a8:	4501                	li	a0,0
    if (n && *s != c)
    18aa:	c235                	beqz	a2,190e <memchr+0x86>
    18ac:	0007c703          	lbu	a4,0(a5)
    18b0:	04b70363          	beq	a4,a1,18f6 <memchr+0x6e>
        size_t k = ONES * c;
    18b4:	00000517          	auipc	a0,0x0
    18b8:	62453503          	ld	a0,1572(a0) # 1ed8 <__func__.0+0x18>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    18bc:	471d                	li	a4,7
        size_t k = ONES * c;
    18be:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    18c2:	02c77a63          	bgeu	a4,a2,18f6 <memchr+0x6e>
    18c6:	00000897          	auipc	a7,0x0
    18ca:	6028b883          	ld	a7,1538(a7) # 1ec8 <__func__.0+0x8>
    18ce:	00000817          	auipc	a6,0x0
    18d2:	60283803          	ld	a6,1538(a6) # 1ed0 <__func__.0+0x10>
    18d6:	431d                	li	t1,7
    18d8:	a029                	j	18e2 <memchr+0x5a>
    18da:	1661                	addi	a2,a2,-8
    18dc:	07a1                	addi	a5,a5,8
    18de:	02c37963          	bgeu	t1,a2,1910 <memchr+0x88>
    18e2:	6398                	ld	a4,0(a5)
    18e4:	8f29                	xor	a4,a4,a0
    18e6:	011706b3          	add	a3,a4,a7
    18ea:	fff74713          	not	a4,a4
    18ee:	8f75                	and	a4,a4,a3
    18f0:	01077733          	and	a4,a4,a6
    18f4:	d37d                	beqz	a4,18da <memchr+0x52>
    18f6:	853e                	mv	a0,a5
    18f8:	97b2                	add	a5,a5,a2
    18fa:	a021                	j	1902 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    18fc:	0505                	addi	a0,a0,1
    18fe:	00f50763          	beq	a0,a5,190c <memchr+0x84>
    1902:	00054703          	lbu	a4,0(a0)
    1906:	feb71be3          	bne	a4,a1,18fc <memchr+0x74>
    190a:	8082                	ret
    return n ? (void *)s : 0;
    190c:	4501                	li	a0,0
}
    190e:	8082                	ret
    return n ? (void *)s : 0;
    1910:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1912:	f275                	bnez	a2,18f6 <memchr+0x6e>
}
    1914:	8082                	ret

0000000000001916 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1916:	1101                	addi	sp,sp,-32
    1918:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    191a:	862e                	mv	a2,a1
{
    191c:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    191e:	4581                	li	a1,0
{
    1920:	e426                	sd	s1,8(sp)
    1922:	ec06                	sd	ra,24(sp)
    1924:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1926:	f63ff0ef          	jal	1888 <memchr>
    return p ? p - s : n;
    192a:	c519                	beqz	a0,1938 <strnlen+0x22>
}
    192c:	60e2                	ld	ra,24(sp)
    192e:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1930:	8d05                	sub	a0,a0,s1
}
    1932:	64a2                	ld	s1,8(sp)
    1934:	6105                	addi	sp,sp,32
    1936:	8082                	ret
    1938:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    193a:	8522                	mv	a0,s0
}
    193c:	6442                	ld	s0,16(sp)
    193e:	64a2                	ld	s1,8(sp)
    1940:	6105                	addi	sp,sp,32
    1942:	8082                	ret

0000000000001944 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    1944:	00b547b3          	xor	a5,a0,a1
    1948:	8b9d                	andi	a5,a5,7
    194a:	eb95                	bnez	a5,197e <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    194c:	0075f793          	andi	a5,a1,7
    1950:	e7b1                	bnez	a5,199c <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1952:	6198                	ld	a4,0(a1)
    1954:	00000617          	auipc	a2,0x0
    1958:	57463603          	ld	a2,1396(a2) # 1ec8 <__func__.0+0x8>
    195c:	00000817          	auipc	a6,0x0
    1960:	57483803          	ld	a6,1396(a6) # 1ed0 <__func__.0+0x10>
    1964:	a029                	j	196e <strcpy+0x2a>
    1966:	e118                	sd	a4,0(a0)
    1968:	6598                	ld	a4,8(a1)
    196a:	05a1                	addi	a1,a1,8
    196c:	0521                	addi	a0,a0,8
    196e:	00c707b3          	add	a5,a4,a2
    1972:	fff74693          	not	a3,a4
    1976:	8ff5                	and	a5,a5,a3
    1978:	0107f7b3          	and	a5,a5,a6
    197c:	d7ed                	beqz	a5,1966 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    197e:	0005c783          	lbu	a5,0(a1)
    1982:	00f50023          	sb	a5,0(a0)
    1986:	c785                	beqz	a5,19ae <strcpy+0x6a>
    1988:	0015c783          	lbu	a5,1(a1)
    198c:	0505                	addi	a0,a0,1
    198e:	0585                	addi	a1,a1,1
    1990:	00f50023          	sb	a5,0(a0)
    1994:	fbf5                	bnez	a5,1988 <strcpy+0x44>
        ;
    return d;
}
    1996:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1998:	0505                	addi	a0,a0,1
    199a:	df45                	beqz	a4,1952 <strcpy+0xe>
            if (!(*d = *s))
    199c:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    19a0:	0585                	addi	a1,a1,1
    19a2:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    19a6:	00f50023          	sb	a5,0(a0)
    19aa:	f7fd                	bnez	a5,1998 <strcpy+0x54>
}
    19ac:	8082                	ret
    19ae:	8082                	ret

00000000000019b0 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    19b0:	00b547b3          	xor	a5,a0,a1
    19b4:	8b9d                	andi	a5,a5,7
    19b6:	1a079863          	bnez	a5,1b66 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    19ba:	0075f793          	andi	a5,a1,7
    19be:	16078463          	beqz	a5,1b26 <strncpy+0x176>
    19c2:	ea01                	bnez	a2,19d2 <strncpy+0x22>
    19c4:	a421                	j	1bcc <strncpy+0x21c>
    19c6:	167d                	addi	a2,a2,-1
    19c8:	0505                	addi	a0,a0,1
    19ca:	14070e63          	beqz	a4,1b26 <strncpy+0x176>
    19ce:	1a060863          	beqz	a2,1b7e <strncpy+0x1ce>
    19d2:	0005c783          	lbu	a5,0(a1)
    19d6:	0585                	addi	a1,a1,1
    19d8:	0075f713          	andi	a4,a1,7
    19dc:	00f50023          	sb	a5,0(a0)
    19e0:	f3fd                	bnez	a5,19c6 <strncpy+0x16>
    19e2:	4805                	li	a6,1
    19e4:	1a061863          	bnez	a2,1b94 <strncpy+0x1e4>
    19e8:	40a007b3          	neg	a5,a0
    19ec:	8b9d                	andi	a5,a5,7
    19ee:	4681                	li	a3,0
    19f0:	18061a63          	bnez	a2,1b84 <strncpy+0x1d4>
    19f4:	00778713          	addi	a4,a5,7
    19f8:	45ad                	li	a1,11
    19fa:	18b76363          	bltu	a4,a1,1b80 <strncpy+0x1d0>
    19fe:	1ae6eb63          	bltu	a3,a4,1bb4 <strncpy+0x204>
    1a02:	1a078363          	beqz	a5,1ba8 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a06:	00050023          	sb	zero,0(a0)
    1a0a:	4685                	li	a3,1
    1a0c:	00150713          	addi	a4,a0,1
    1a10:	18d78f63          	beq	a5,a3,1bae <strncpy+0x1fe>
    1a14:	000500a3          	sb	zero,1(a0)
    1a18:	4689                	li	a3,2
    1a1a:	00250713          	addi	a4,a0,2
    1a1e:	18d78e63          	beq	a5,a3,1bba <strncpy+0x20a>
    1a22:	00050123          	sb	zero,2(a0)
    1a26:	468d                	li	a3,3
    1a28:	00350713          	addi	a4,a0,3
    1a2c:	16d78c63          	beq	a5,a3,1ba4 <strncpy+0x1f4>
    1a30:	000501a3          	sb	zero,3(a0)
    1a34:	4691                	li	a3,4
    1a36:	00450713          	addi	a4,a0,4
    1a3a:	18d78263          	beq	a5,a3,1bbe <strncpy+0x20e>
    1a3e:	00050223          	sb	zero,4(a0)
    1a42:	4695                	li	a3,5
    1a44:	00550713          	addi	a4,a0,5
    1a48:	16d78d63          	beq	a5,a3,1bc2 <strncpy+0x212>
    1a4c:	000502a3          	sb	zero,5(a0)
    1a50:	469d                	li	a3,7
    1a52:	00650713          	addi	a4,a0,6
    1a56:	16d79863          	bne	a5,a3,1bc6 <strncpy+0x216>
    1a5a:	00750713          	addi	a4,a0,7
    1a5e:	00050323          	sb	zero,6(a0)
    1a62:	40f80833          	sub	a6,a6,a5
    1a66:	ff887593          	andi	a1,a6,-8
    1a6a:	97aa                	add	a5,a5,a0
    1a6c:	95be                	add	a1,a1,a5
    1a6e:	0007b023          	sd	zero,0(a5)
    1a72:	07a1                	addi	a5,a5,8
    1a74:	feb79de3          	bne	a5,a1,1a6e <strncpy+0xbe>
    1a78:	ff887593          	andi	a1,a6,-8
    1a7c:	9ead                	addw	a3,a3,a1
    1a7e:	00b707b3          	add	a5,a4,a1
    1a82:	12b80863          	beq	a6,a1,1bb2 <strncpy+0x202>
    1a86:	00078023          	sb	zero,0(a5)
    1a8a:	0016871b          	addiw	a4,a3,1
    1a8e:	0ec77863          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1a92:	000780a3          	sb	zero,1(a5)
    1a96:	0026871b          	addiw	a4,a3,2
    1a9a:	0ec77263          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1a9e:	00078123          	sb	zero,2(a5)
    1aa2:	0036871b          	addiw	a4,a3,3
    1aa6:	0cc77c63          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1aaa:	000781a3          	sb	zero,3(a5)
    1aae:	0046871b          	addiw	a4,a3,4
    1ab2:	0cc77663          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1ab6:	00078223          	sb	zero,4(a5)
    1aba:	0056871b          	addiw	a4,a3,5
    1abe:	0cc77063          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1ac2:	000782a3          	sb	zero,5(a5)
    1ac6:	0066871b          	addiw	a4,a3,6
    1aca:	0ac77a63          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1ace:	00078323          	sb	zero,6(a5)
    1ad2:	0076871b          	addiw	a4,a3,7
    1ad6:	0ac77463          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1ada:	000783a3          	sb	zero,7(a5)
    1ade:	0086871b          	addiw	a4,a3,8
    1ae2:	08c77e63          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1ae6:	00078423          	sb	zero,8(a5)
    1aea:	0096871b          	addiw	a4,a3,9
    1aee:	08c77863          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1af2:	000784a3          	sb	zero,9(a5)
    1af6:	00a6871b          	addiw	a4,a3,10
    1afa:	08c77263          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1afe:	00078523          	sb	zero,10(a5)
    1b02:	00b6871b          	addiw	a4,a3,11
    1b06:	06c77c63          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1b0a:	000785a3          	sb	zero,11(a5)
    1b0e:	00c6871b          	addiw	a4,a3,12
    1b12:	06c77663          	bgeu	a4,a2,1b7e <strncpy+0x1ce>
    1b16:	00078623          	sb	zero,12(a5)
    1b1a:	26b5                	addiw	a3,a3,13
    1b1c:	06c6f163          	bgeu	a3,a2,1b7e <strncpy+0x1ce>
    1b20:	000786a3          	sb	zero,13(a5)
    1b24:	8082                	ret
            ;
        if (!n || !*s)
    1b26:	c645                	beqz	a2,1bce <strncpy+0x21e>
    1b28:	0005c783          	lbu	a5,0(a1)
    1b2c:	ea078be3          	beqz	a5,19e2 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b30:	479d                	li	a5,7
    1b32:	02c7ff63          	bgeu	a5,a2,1b70 <strncpy+0x1c0>
    1b36:	00000897          	auipc	a7,0x0
    1b3a:	3928b883          	ld	a7,914(a7) # 1ec8 <__func__.0+0x8>
    1b3e:	00000817          	auipc	a6,0x0
    1b42:	39283803          	ld	a6,914(a6) # 1ed0 <__func__.0+0x10>
    1b46:	431d                	li	t1,7
    1b48:	6198                	ld	a4,0(a1)
    1b4a:	011707b3          	add	a5,a4,a7
    1b4e:	fff74693          	not	a3,a4
    1b52:	8ff5                	and	a5,a5,a3
    1b54:	0107f7b3          	and	a5,a5,a6
    1b58:	ef81                	bnez	a5,1b70 <strncpy+0x1c0>
            *wd = *ws;
    1b5a:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b5c:	1661                	addi	a2,a2,-8
    1b5e:	05a1                	addi	a1,a1,8
    1b60:	0521                	addi	a0,a0,8
    1b62:	fec363e3          	bltu	t1,a2,1b48 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1b66:	e609                	bnez	a2,1b70 <strncpy+0x1c0>
    1b68:	a08d                	j	1bca <strncpy+0x21a>
    1b6a:	167d                	addi	a2,a2,-1
    1b6c:	0505                	addi	a0,a0,1
    1b6e:	ca01                	beqz	a2,1b7e <strncpy+0x1ce>
    1b70:	0005c783          	lbu	a5,0(a1)
    1b74:	0585                	addi	a1,a1,1
    1b76:	00f50023          	sb	a5,0(a0)
    1b7a:	fbe5                	bnez	a5,1b6a <strncpy+0x1ba>
        ;
tail:
    1b7c:	b59d                	j	19e2 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1b7e:	8082                	ret
    1b80:	472d                	li	a4,11
    1b82:	bdb5                	j	19fe <strncpy+0x4e>
    1b84:	00778713          	addi	a4,a5,7
    1b88:	45ad                	li	a1,11
    1b8a:	fff60693          	addi	a3,a2,-1
    1b8e:	e6b778e3          	bgeu	a4,a1,19fe <strncpy+0x4e>
    1b92:	b7fd                	j	1b80 <strncpy+0x1d0>
    1b94:	40a007b3          	neg	a5,a0
    1b98:	8832                	mv	a6,a2
    1b9a:	8b9d                	andi	a5,a5,7
    1b9c:	4681                	li	a3,0
    1b9e:	e4060be3          	beqz	a2,19f4 <strncpy+0x44>
    1ba2:	b7cd                	j	1b84 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1ba4:	468d                	li	a3,3
    1ba6:	bd75                	j	1a62 <strncpy+0xb2>
    1ba8:	872a                	mv	a4,a0
    1baa:	4681                	li	a3,0
    1bac:	bd5d                	j	1a62 <strncpy+0xb2>
    1bae:	4685                	li	a3,1
    1bb0:	bd4d                	j	1a62 <strncpy+0xb2>
    1bb2:	8082                	ret
    1bb4:	87aa                	mv	a5,a0
    1bb6:	4681                	li	a3,0
    1bb8:	b5f9                	j	1a86 <strncpy+0xd6>
    1bba:	4689                	li	a3,2
    1bbc:	b55d                	j	1a62 <strncpy+0xb2>
    1bbe:	4691                	li	a3,4
    1bc0:	b54d                	j	1a62 <strncpy+0xb2>
    1bc2:	4695                	li	a3,5
    1bc4:	bd79                	j	1a62 <strncpy+0xb2>
    1bc6:	4699                	li	a3,6
    1bc8:	bd69                	j	1a62 <strncpy+0xb2>
    1bca:	8082                	ret
    1bcc:	8082                	ret
    1bce:	8082                	ret

0000000000001bd0 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1bd0:	87aa                	mv	a5,a0
    1bd2:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1bd4:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1bd8:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1bdc:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1bde:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1be0:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1be4:	2501                	sext.w	a0,a0
    1be6:	8082                	ret

0000000000001be8 <openat>:
    register long a7 __asm__("a7") = n;
    1be8:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1bec:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1bf0:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1bf4:	2501                	sext.w	a0,a0
    1bf6:	8082                	ret

0000000000001bf8 <close>:
    register long a7 __asm__("a7") = n;
    1bf8:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1bfc:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c00:	2501                	sext.w	a0,a0
    1c02:	8082                	ret

0000000000001c04 <read>:
    register long a7 __asm__("a7") = n;
    1c04:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c08:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c0c:	8082                	ret

0000000000001c0e <write>:
    register long a7 __asm__("a7") = n;
    1c0e:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c12:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c16:	8082                	ret

0000000000001c18 <getpid>:
    register long a7 __asm__("a7") = n;
    1c18:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c1c:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c20:	2501                	sext.w	a0,a0
    1c22:	8082                	ret

0000000000001c24 <getppid>:
    register long a7 __asm__("a7") = n;
    1c24:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c28:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c2c:	2501                	sext.w	a0,a0
    1c2e:	8082                	ret

0000000000001c30 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c30:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c34:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c38:	2501                	sext.w	a0,a0
    1c3a:	8082                	ret

0000000000001c3c <fork>:
    register long a7 __asm__("a7") = n;
    1c3c:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1c40:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1c42:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c44:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1c48:	2501                	sext.w	a0,a0
    1c4a:	8082                	ret

0000000000001c4c <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1c4c:	85b2                	mv	a1,a2
    1c4e:	863a                	mv	a2,a4
    if (stack)
    1c50:	c191                	beqz	a1,1c54 <clone+0x8>
	stack += stack_size;
    1c52:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1c54:	4781                	li	a5,0
    1c56:	4701                	li	a4,0
    1c58:	4681                	li	a3,0
    1c5a:	2601                	sext.w	a2,a2
    1c5c:	a2ed                	j	1e46 <__clone>

0000000000001c5e <exit>:
    register long a7 __asm__("a7") = n;
    1c5e:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1c62:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1c66:	8082                	ret

0000000000001c68 <waitpid>:
    register long a7 __asm__("a7") = n;
    1c68:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1c6c:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c6e:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1c72:	2501                	sext.w	a0,a0
    1c74:	8082                	ret

0000000000001c76 <exec>:
    register long a7 __asm__("a7") = n;
    1c76:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1c7a:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1c7e:	2501                	sext.w	a0,a0
    1c80:	8082                	ret

0000000000001c82 <execve>:
    register long a7 __asm__("a7") = n;
    1c82:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c86:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1c8a:	2501                	sext.w	a0,a0
    1c8c:	8082                	ret

0000000000001c8e <times>:
    register long a7 __asm__("a7") = n;
    1c8e:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1c92:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1c96:	2501                	sext.w	a0,a0
    1c98:	8082                	ret

0000000000001c9a <get_time>:

int64 get_time()
{
    1c9a:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1c9c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1ca0:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1ca2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ca4:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1ca8:	2501                	sext.w	a0,a0
    1caa:	ed09                	bnez	a0,1cc4 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1cac:	67a2                	ld	a5,8(sp)
    1cae:	3e800713          	li	a4,1000
    1cb2:	00015503          	lhu	a0,0(sp)
    1cb6:	02e7d7b3          	divu	a5,a5,a4
    1cba:	02e50533          	mul	a0,a0,a4
    1cbe:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1cc0:	0141                	addi	sp,sp,16
    1cc2:	8082                	ret
        return -1;
    1cc4:	557d                	li	a0,-1
    1cc6:	bfed                	j	1cc0 <get_time+0x26>

0000000000001cc8 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1cc8:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ccc:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1cd0:	2501                	sext.w	a0,a0
    1cd2:	8082                	ret

0000000000001cd4 <time>:
    register long a7 __asm__("a7") = n;
    1cd4:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1cd8:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1cdc:	2501                	sext.w	a0,a0
    1cde:	8082                	ret

0000000000001ce0 <sleep>:

int sleep(unsigned long long time)
{
    1ce0:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1ce2:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1ce4:	850a                	mv	a0,sp
    1ce6:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1ce8:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1cec:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cee:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1cf2:	e501                	bnez	a0,1cfa <sleep+0x1a>
    return 0;
    1cf4:	4501                	li	a0,0
}
    1cf6:	0141                	addi	sp,sp,16
    1cf8:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1cfa:	4502                	lw	a0,0(sp)
}
    1cfc:	0141                	addi	sp,sp,16
    1cfe:	8082                	ret

0000000000001d00 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d00:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d04:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d08:	2501                	sext.w	a0,a0
    1d0a:	8082                	ret

0000000000001d0c <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d0c:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d10:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d14:	8082                	ret

0000000000001d16 <munmap>:
    register long a7 __asm__("a7") = n;
    1d16:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d1a:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d1e:	2501                	sext.w	a0,a0
    1d20:	8082                	ret

0000000000001d22 <wait>:

int wait(int *code)
{
    1d22:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d24:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d28:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d2a:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d2c:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d2e:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1d32:	2501                	sext.w	a0,a0
    1d34:	8082                	ret

0000000000001d36 <spawn>:
    register long a7 __asm__("a7") = n;
    1d36:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1d3a:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1d3e:	2501                	sext.w	a0,a0
    1d40:	8082                	ret

0000000000001d42 <mailread>:
    register long a7 __asm__("a7") = n;
    1d42:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d46:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1d4a:	2501                	sext.w	a0,a0
    1d4c:	8082                	ret

0000000000001d4e <mailwrite>:
    register long a7 __asm__("a7") = n;
    1d4e:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d52:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1d56:	2501                	sext.w	a0,a0
    1d58:	8082                	ret

0000000000001d5a <fstat>:
    register long a7 __asm__("a7") = n;
    1d5a:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d5e:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1d62:	2501                	sext.w	a0,a0
    1d64:	8082                	ret

0000000000001d66 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1d66:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1d68:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1d6c:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1d6e:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1d72:	2501                	sext.w	a0,a0
    1d74:	8082                	ret

0000000000001d76 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1d76:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1d78:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1d7c:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d7e:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1d82:	2501                	sext.w	a0,a0
    1d84:	8082                	ret

0000000000001d86 <link>:

int link(char *old_path, char *new_path)
{
    1d86:	87aa                	mv	a5,a0
    1d88:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1d8a:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1d8e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1d92:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1d94:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1d98:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1d9a:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1d9e:	2501                	sext.w	a0,a0
    1da0:	8082                	ret

0000000000001da2 <unlink>:

int unlink(char *path)
{
    1da2:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1da4:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1da8:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1dac:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dae:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1db2:	2501                	sext.w	a0,a0
    1db4:	8082                	ret

0000000000001db6 <uname>:
    register long a7 __asm__("a7") = n;
    1db6:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1dba:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1dbe:	2501                	sext.w	a0,a0
    1dc0:	8082                	ret

0000000000001dc2 <brk>:
    register long a7 __asm__("a7") = n;
    1dc2:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1dc6:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1dca:	2501                	sext.w	a0,a0
    1dcc:	8082                	ret

0000000000001dce <getcwd>:
    register long a7 __asm__("a7") = n;
    1dce:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd0:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1dd4:	8082                	ret

0000000000001dd6 <chdir>:
    register long a7 __asm__("a7") = n;
    1dd6:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1dda:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1dde:	2501                	sext.w	a0,a0
    1de0:	8082                	ret

0000000000001de2 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1de2:	862e                	mv	a2,a1
    1de4:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1de6:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1de8:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1dec:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1df0:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1df2:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1df4:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1df8:	2501                	sext.w	a0,a0
    1dfa:	8082                	ret

0000000000001dfc <getdents>:
    register long a7 __asm__("a7") = n;
    1dfc:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e00:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e04:	2501                	sext.w	a0,a0
    1e06:	8082                	ret

0000000000001e08 <pipe>:
    register long a7 __asm__("a7") = n;
    1e08:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e0c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e0e:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e12:	2501                	sext.w	a0,a0
    1e14:	8082                	ret

0000000000001e16 <dup>:
    register long a7 __asm__("a7") = n;
    1e16:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e18:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e1c:	2501                	sext.w	a0,a0
    1e1e:	8082                	ret

0000000000001e20 <dup2>:
    register long a7 __asm__("a7") = n;
    1e20:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e22:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e24:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e28:	2501                	sext.w	a0,a0
    1e2a:	8082                	ret

0000000000001e2c <mount>:
    register long a7 __asm__("a7") = n;
    1e2c:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e30:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1e34:	2501                	sext.w	a0,a0
    1e36:	8082                	ret

0000000000001e38 <umount>:
    register long a7 __asm__("a7") = n;
    1e38:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1e3c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e3e:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1e42:	2501                	sext.w	a0,a0
    1e44:	8082                	ret

0000000000001e46 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1e46:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1e48:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1e4a:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1e4c:	8532                	mv	a0,a2
	mv a2, a4
    1e4e:	863a                	mv	a2,a4
	mv a3, a5
    1e50:	86be                	mv	a3,a5
	mv a4, a6
    1e52:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1e54:	0dc00893          	li	a7,220
	ecall
    1e58:	00000073          	ecall

	beqz a0, 1f
    1e5c:	c111                	beqz	a0,1e60 <__clone+0x1a>
	# Parent
	ret
    1e5e:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1e60:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1e62:	6522                	ld	a0,8(sp)
	jalr a1
    1e64:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1e66:	05d00893          	li	a7,93
	ecall
    1e6a:	00000073          	ecall
