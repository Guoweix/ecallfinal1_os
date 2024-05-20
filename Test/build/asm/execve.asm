
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/execve:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a08d                	j	1064 <__start_main>

0000000000001004 <test_execve>:
 * 测试成功则输出：
 * "  I am test_echo."
 * 测试失败则输出：
 * "  execve error."
 */
void test_execve(void){
    1004:	7179                	addi	sp,sp,-48
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	e9250513          	addi	a0,a0,-366 # 1e98 <__clone+0x2e>
void test_execve(void){
    100e:	f406                	sd	ra,40(sp)
    TEST_START(__func__);
    1010:	2c6000ef          	jal	12d6 <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	ef450513          	addi	a0,a0,-268 # 1f08 <__func__.0>
    101c:	2ba000ef          	jal	12d6 <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	e9050513          	addi	a0,a0,-368 # 1eb0 <__clone+0x46>
    1028:	2ae000ef          	jal	12d6 <puts>
    char *newargv[] = {"test_echo", NULL};
    char *newenviron[] = {NULL};
    execve("test_echo", newargv, newenviron);
    102c:	0030                	addi	a2,sp,8
    102e:	080c                	addi	a1,sp,16
    char *newargv[] = {"test_echo", NULL};
    1030:	00001517          	auipc	a0,0x1
    1034:	e9050513          	addi	a0,a0,-368 # 1ec0 <__clone+0x56>
    1038:	e82a                	sd	a0,16(sp)
    103a:	ec02                	sd	zero,24(sp)
    char *newenviron[] = {NULL};
    103c:	e402                	sd	zero,8(sp)
    execve("test_echo", newargv, newenviron);
    103e:	469000ef          	jal	1ca6 <execve>
    printf("  execve error.\n");
    1042:	00001517          	auipc	a0,0x1
    1046:	e8e50513          	addi	a0,a0,-370 # 1ed0 <__clone+0x66>
    104a:	2ae000ef          	jal	12f8 <printf>
    //TEST_END(__func__);
}
    104e:	70a2                	ld	ra,40(sp)
    1050:	6145                	addi	sp,sp,48
    1052:	8082                	ret

0000000000001054 <main>:

int main(void){
    1054:	1141                	addi	sp,sp,-16
    1056:	e406                	sd	ra,8(sp)
    test_execve();
    1058:	fadff0ef          	jal	1004 <test_execve>
    return 0;
}
    105c:	60a2                	ld	ra,8(sp)
    105e:	4501                	li	a0,0
    1060:	0141                	addi	sp,sp,16
    1062:	8082                	ret

0000000000001064 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    1064:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    1066:	4108                	lw	a0,0(a0)
{
    1068:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    106a:	05a1                	addi	a1,a1,8
{
    106c:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    106e:	fe7ff0ef          	jal	1054 <main>
    1072:	411000ef          	jal	1c82 <exit>
	return 0;
}
    1076:	60a2                	ld	ra,8(sp)
    1078:	4501                	li	a0,0
    107a:	0141                	addi	sp,sp,16
    107c:	8082                	ret

000000000000107e <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    107e:	7179                	addi	sp,sp,-48
    1080:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    1082:	12054b63          	bltz	a0,11b8 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    1086:	02b577bb          	remuw	a5,a0,a1
    108a:	00001617          	auipc	a2,0x1
    108e:	e8e60613          	addi	a2,a2,-370 # 1f18 <digits>
    buf[16] = 0;
    1092:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1096:	0005871b          	sext.w	a4,a1
    109a:	1782                	slli	a5,a5,0x20
    109c:	9381                	srli	a5,a5,0x20
    109e:	97b2                	add	a5,a5,a2
    10a0:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10a4:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10a8:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10ac:	1cb56363          	bltu	a0,a1,1272 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    10b0:	45b9                	li	a1,14
    10b2:	02e877bb          	remuw	a5,a6,a4
    10b6:	1782                	slli	a5,a5,0x20
    10b8:	9381                	srli	a5,a5,0x20
    10ba:	97b2                	add	a5,a5,a2
    10bc:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10c0:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    10c4:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    10c8:	0ce86e63          	bltu	a6,a4,11a4 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    10cc:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    10d0:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    10d4:	1582                	slli	a1,a1,0x20
    10d6:	9181                	srli	a1,a1,0x20
    10d8:	95b2                	add	a1,a1,a2
    10da:	0005c583          	lbu	a1,0(a1)
    10de:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    10e2:	0007859b          	sext.w	a1,a5
    10e6:	12e6ec63          	bltu	a3,a4,121e <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    10ea:	02e7f6bb          	remuw	a3,a5,a4
    10ee:	1682                	slli	a3,a3,0x20
    10f0:	9281                	srli	a3,a3,0x20
    10f2:	96b2                	add	a3,a3,a2
    10f4:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    10f8:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    10fc:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1100:	12e5e863          	bltu	a1,a4,1230 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    1104:	02e876bb          	remuw	a3,a6,a4
    1108:	1682                	slli	a3,a3,0x20
    110a:	9281                	srli	a3,a3,0x20
    110c:	96b2                	add	a3,a3,a2
    110e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1112:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1116:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    111a:	12e86463          	bltu	a6,a4,1242 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    111e:	02e5f6bb          	remuw	a3,a1,a4
    1122:	1682                	slli	a3,a3,0x20
    1124:	9281                	srli	a3,a3,0x20
    1126:	96b2                	add	a3,a3,a2
    1128:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    112c:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1130:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    1134:	0ce5ec63          	bltu	a1,a4,120c <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    1138:	02e876bb          	remuw	a3,a6,a4
    113c:	1682                	slli	a3,a3,0x20
    113e:	9281                	srli	a3,a3,0x20
    1140:	96b2                	add	a3,a3,a2
    1142:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1146:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    114a:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    114e:	10e86963          	bltu	a6,a4,1260 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    1152:	02e5f6bb          	remuw	a3,a1,a4
    1156:	1682                	slli	a3,a3,0x20
    1158:	9281                	srli	a3,a3,0x20
    115a:	96b2                	add	a3,a3,a2
    115c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1160:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1164:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1168:	10e5e763          	bltu	a1,a4,1276 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    116c:	02e876bb          	remuw	a3,a6,a4
    1170:	1682                	slli	a3,a3,0x20
    1172:	9281                	srli	a3,a3,0x20
    1174:	96b2                	add	a3,a3,a2
    1176:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    117a:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    117e:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    1182:	10e86363          	bltu	a6,a4,1288 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    1186:	1782                	slli	a5,a5,0x20
    1188:	9381                	srli	a5,a5,0x20
    118a:	97b2                	add	a5,a5,a2
    118c:	0007c783          	lbu	a5,0(a5)
    1190:	4599                	li	a1,6
    1192:	00f10723          	sb	a5,14(sp)

    if (sign)
    1196:	00055763          	bgez	a0,11a4 <printint.constprop.0+0x126>
        buf[i--] = '-';
    119a:	02d00793          	li	a5,45
    119e:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11a2:	4595                	li	a1,5
    write(f, s, l);
    11a4:	003c                	addi	a5,sp,8
    11a6:	4641                	li	a2,16
    11a8:	9e0d                	subw	a2,a2,a1
    11aa:	4505                	li	a0,1
    11ac:	95be                	add	a1,a1,a5
    11ae:	285000ef          	jal	1c32 <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11b2:	70a2                	ld	ra,40(sp)
    11b4:	6145                	addi	sp,sp,48
    11b6:	8082                	ret
        x = -xx;
    11b8:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    11bc:	02b877bb          	remuw	a5,a6,a1
    11c0:	00001617          	auipc	a2,0x1
    11c4:	d5860613          	addi	a2,a2,-680 # 1f18 <digits>
    buf[16] = 0;
    11c8:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    11cc:	0005871b          	sext.w	a4,a1
    11d0:	1782                	slli	a5,a5,0x20
    11d2:	9381                	srli	a5,a5,0x20
    11d4:	97b2                	add	a5,a5,a2
    11d6:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    11da:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    11de:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    11e2:	06b86963          	bltu	a6,a1,1254 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    11e6:	02e8f7bb          	remuw	a5,a7,a4
    11ea:	1782                	slli	a5,a5,0x20
    11ec:	9381                	srli	a5,a5,0x20
    11ee:	97b2                	add	a5,a5,a2
    11f0:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    11f4:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    11f8:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    11fc:	ece8f8e3          	bgeu	a7,a4,10cc <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1200:	02d00793          	li	a5,45
    1204:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1208:	45b5                	li	a1,13
    120a:	bf69                	j	11a4 <printint.constprop.0+0x126>
    120c:	45a9                	li	a1,10
    if (sign)
    120e:	f8055be3          	bgez	a0,11a4 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1212:	02d00793          	li	a5,45
    1216:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    121a:	45a5                	li	a1,9
    121c:	b761                	j	11a4 <printint.constprop.0+0x126>
    121e:	45b5                	li	a1,13
    if (sign)
    1220:	f80552e3          	bgez	a0,11a4 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1224:	02d00793          	li	a5,45
    1228:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    122c:	45b1                	li	a1,12
    122e:	bf9d                	j	11a4 <printint.constprop.0+0x126>
    1230:	45b1                	li	a1,12
    if (sign)
    1232:	f60559e3          	bgez	a0,11a4 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1236:	02d00793          	li	a5,45
    123a:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    123e:	45ad                	li	a1,11
    1240:	b795                	j	11a4 <printint.constprop.0+0x126>
    1242:	45ad                	li	a1,11
    if (sign)
    1244:	f60550e3          	bgez	a0,11a4 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1248:	02d00793          	li	a5,45
    124c:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    1250:	45a9                	li	a1,10
    1252:	bf89                	j	11a4 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1254:	02d00793          	li	a5,45
    1258:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    125c:	45b9                	li	a1,14
    125e:	b799                	j	11a4 <printint.constprop.0+0x126>
    1260:	45a5                	li	a1,9
    if (sign)
    1262:	f40551e3          	bgez	a0,11a4 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1266:	02d00793          	li	a5,45
    126a:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    126e:	45a1                	li	a1,8
    1270:	bf15                	j	11a4 <printint.constprop.0+0x126>
    i = 15;
    1272:	45bd                	li	a1,15
    1274:	bf05                	j	11a4 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1276:	45a1                	li	a1,8
    if (sign)
    1278:	f20556e3          	bgez	a0,11a4 <printint.constprop.0+0x126>
        buf[i--] = '-';
    127c:	02d00793          	li	a5,45
    1280:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    1284:	459d                	li	a1,7
    1286:	bf39                	j	11a4 <printint.constprop.0+0x126>
    1288:	459d                	li	a1,7
    if (sign)
    128a:	f0055de3          	bgez	a0,11a4 <printint.constprop.0+0x126>
        buf[i--] = '-';
    128e:	02d00793          	li	a5,45
    1292:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    1296:	4599                	li	a1,6
    1298:	b731                	j	11a4 <printint.constprop.0+0x126>

000000000000129a <getchar>:
{
    129a:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    129c:	00f10593          	addi	a1,sp,15
    12a0:	4605                	li	a2,1
    12a2:	4501                	li	a0,0
{
    12a4:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12a6:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12aa:	17f000ef          	jal	1c28 <read>
}
    12ae:	60e2                	ld	ra,24(sp)
    12b0:	00f14503          	lbu	a0,15(sp)
    12b4:	6105                	addi	sp,sp,32
    12b6:	8082                	ret

00000000000012b8 <putchar>:
{
    12b8:	1101                	addi	sp,sp,-32
    12ba:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    12bc:	00f10593          	addi	a1,sp,15
    12c0:	4605                	li	a2,1
    12c2:	4505                	li	a0,1
{
    12c4:	ec06                	sd	ra,24(sp)
    char byte = c;
    12c6:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    12ca:	169000ef          	jal	1c32 <write>
}
    12ce:	60e2                	ld	ra,24(sp)
    12d0:	2501                	sext.w	a0,a0
    12d2:	6105                	addi	sp,sp,32
    12d4:	8082                	ret

00000000000012d6 <puts>:
{
    12d6:	1141                	addi	sp,sp,-16
    12d8:	e406                	sd	ra,8(sp)
    12da:	e022                	sd	s0,0(sp)
    12dc:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    12de:	570000ef          	jal	184e <strlen>
    12e2:	862a                	mv	a2,a0
    12e4:	85a2                	mv	a1,s0
    12e6:	4505                	li	a0,1
    12e8:	14b000ef          	jal	1c32 <write>
}
    12ec:	60a2                	ld	ra,8(sp)
    12ee:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    12f0:	957d                	srai	a0,a0,0x3f
    return r;
    12f2:	2501                	sext.w	a0,a0
}
    12f4:	0141                	addi	sp,sp,16
    12f6:	8082                	ret

00000000000012f8 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    12f8:	7131                	addi	sp,sp,-192
    12fa:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    12fc:	013c                	addi	a5,sp,136
{
    12fe:	f0ca                	sd	s2,96(sp)
    1300:	ecce                	sd	s3,88(sp)
    1302:	e8d2                	sd	s4,80(sp)
    1304:	e4d6                	sd	s5,72(sp)
    1306:	e0da                	sd	s6,64(sp)
    1308:	fc5e                	sd	s7,56(sp)
    130a:	fc86                	sd	ra,120(sp)
    130c:	f8a2                	sd	s0,112(sp)
    130e:	f4a6                	sd	s1,104(sp)
    1310:	e52e                	sd	a1,136(sp)
    1312:	e932                	sd	a2,144(sp)
    1314:	ed36                	sd	a3,152(sp)
    1316:	f13a                	sd	a4,160(sp)
    1318:	f942                	sd	a6,176(sp)
    131a:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    131c:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    131e:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    1322:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1326:	00001b97          	auipc	s7,0x1
    132a:	bc2b8b93          	addi	s7,s7,-1086 # 1ee8 <__clone+0x7e>
        switch (s[1])
    132e:	07800a93          	li	s5,120
    1332:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1336:	00001997          	auipc	s3,0x1
    133a:	be298993          	addi	s3,s3,-1054 # 1f18 <digits>
        if (!*s)
    133e:	00054783          	lbu	a5,0(a0)
    1342:	16078c63          	beqz	a5,14ba <printf+0x1c2>
    1346:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1348:	19278463          	beq	a5,s2,14d0 <printf+0x1d8>
    134c:	00164783          	lbu	a5,1(a2)
    1350:	0605                	addi	a2,a2,1
    1352:	fbfd                	bnez	a5,1348 <printf+0x50>
    1354:	84b2                	mv	s1,a2
        l = z - a;
    1356:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    135a:	85aa                	mv	a1,a0
    135c:	8622                	mv	a2,s0
    135e:	4505                	li	a0,1
    1360:	0d3000ef          	jal	1c32 <write>
        if (l)
    1364:	18041f63          	bnez	s0,1502 <printf+0x20a>
        if (s[1] == 0)
    1368:	0014c783          	lbu	a5,1(s1)
    136c:	14078763          	beqz	a5,14ba <printf+0x1c2>
        switch (s[1])
    1370:	1d478163          	beq	a5,s4,1532 <printf+0x23a>
    1374:	18fa6963          	bltu	s4,a5,1506 <printf+0x20e>
    1378:	1b678363          	beq	a5,s6,151e <printf+0x226>
    137c:	07000713          	li	a4,112
    1380:	1ce79c63          	bne	a5,a4,1558 <printf+0x260>
            printptr(va_arg(ap, uint64));
    1384:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    1386:	03000793          	li	a5,48
    138a:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    138e:	631c                	ld	a5,0(a4)
    1390:	0721                	addi	a4,a4,8
    1392:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1394:	00479f93          	slli	t6,a5,0x4
    1398:	00879f13          	slli	t5,a5,0x8
    139c:	00c79e93          	slli	t4,a5,0xc
    13a0:	01079e13          	slli	t3,a5,0x10
    13a4:	01479313          	slli	t1,a5,0x14
    13a8:	01879893          	slli	a7,a5,0x18
    13ac:	01c79713          	slli	a4,a5,0x1c
    13b0:	02479813          	slli	a6,a5,0x24
    13b4:	02879513          	slli	a0,a5,0x28
    13b8:	02c79593          	slli	a1,a5,0x2c
    13bc:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13c0:	03c7d293          	srli	t0,a5,0x3c
    13c4:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13c8:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13cc:	03cfdf93          	srli	t6,t6,0x3c
    13d0:	03cf5f13          	srli	t5,t5,0x3c
    13d4:	03cede93          	srli	t4,t4,0x3c
    13d8:	03ce5e13          	srli	t3,t3,0x3c
    13dc:	03c35313          	srli	t1,t1,0x3c
    13e0:	03c8d893          	srli	a7,a7,0x3c
    13e4:	9371                	srli	a4,a4,0x3c
    13e6:	03c85813          	srli	a6,a6,0x3c
    13ea:	9171                	srli	a0,a0,0x3c
    13ec:	91f1                	srli	a1,a1,0x3c
    13ee:	9271                	srli	a2,a2,0x3c
    13f0:	974e                	add	a4,a4,s3
    13f2:	92f1                	srli	a3,a3,0x3c
    13f4:	92ce                	add	t0,t0,s3
    13f6:	9fce                	add	t6,t6,s3
    13f8:	9f4e                	add	t5,t5,s3
    13fa:	9ece                	add	t4,t4,s3
    13fc:	9e4e                	add	t3,t3,s3
    13fe:	934e                	add	t1,t1,s3
    1400:	98ce                	add	a7,a7,s3
    1402:	93ce                	add	t2,t2,s3
    1404:	984e                	add	a6,a6,s3
    1406:	954e                	add	a0,a0,s3
    1408:	95ce                	add	a1,a1,s3
    140a:	964e                	add	a2,a2,s3
    140c:	0002c283          	lbu	t0,0(t0)
    1410:	000fcf83          	lbu	t6,0(t6)
    1414:	000f4f03          	lbu	t5,0(t5)
    1418:	000ece83          	lbu	t4,0(t4)
    141c:	000e4e03          	lbu	t3,0(t3)
    1420:	00034303          	lbu	t1,0(t1)
    1424:	0008c883          	lbu	a7,0(a7)
    1428:	00074403          	lbu	s0,0(a4)
    142c:	0003c383          	lbu	t2,0(t2)
    1430:	00084803          	lbu	a6,0(a6)
    1434:	00054503          	lbu	a0,0(a0)
    1438:	0005c583          	lbu	a1,0(a1)
    143c:	00064603          	lbu	a2,0(a2)
    1440:	00d98733          	add	a4,s3,a3
    1444:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1448:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    144c:	9371                	srli	a4,a4,0x3c
    144e:	8bbd                	andi	a5,a5,15
    1450:	00510523          	sb	t0,10(sp)
    1454:	01f105a3          	sb	t6,11(sp)
    1458:	01e10623          	sb	t5,12(sp)
    145c:	01d106a3          	sb	t4,13(sp)
    1460:	01c10723          	sb	t3,14(sp)
    1464:	006107a3          	sb	t1,15(sp)
    1468:	01110823          	sb	a7,16(sp)
    146c:	00710923          	sb	t2,18(sp)
    1470:	010109a3          	sb	a6,19(sp)
    1474:	00a10a23          	sb	a0,20(sp)
    1478:	00b10aa3          	sb	a1,21(sp)
    147c:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    1480:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1484:	008108a3          	sb	s0,17(sp)
    1488:	974e                	add	a4,a4,s3
    148a:	97ce                	add	a5,a5,s3
    148c:	00d10ba3          	sb	a3,23(sp)
    1490:	00074703          	lbu	a4,0(a4)
    1494:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1498:	4649                	li	a2,18
    149a:	002c                	addi	a1,sp,8
    149c:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    149e:	00e10c23          	sb	a4,24(sp)
    14a2:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14a6:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14aa:	788000ef          	jal	1c32 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14ae:	00248513          	addi	a0,s1,2
        if (!*s)
    14b2:	00054783          	lbu	a5,0(a0)
    14b6:	e80798e3          	bnez	a5,1346 <printf+0x4e>
    }
    va_end(ap);
}
    14ba:	70e6                	ld	ra,120(sp)
    14bc:	7446                	ld	s0,112(sp)
    14be:	74a6                	ld	s1,104(sp)
    14c0:	7906                	ld	s2,96(sp)
    14c2:	69e6                	ld	s3,88(sp)
    14c4:	6a46                	ld	s4,80(sp)
    14c6:	6aa6                	ld	s5,72(sp)
    14c8:	6b06                	ld	s6,64(sp)
    14ca:	7be2                	ld	s7,56(sp)
    14cc:	6129                	addi	sp,sp,192
    14ce:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    14d0:	00064783          	lbu	a5,0(a2)
    14d4:	84b2                	mv	s1,a2
    14d6:	01278963          	beq	a5,s2,14e8 <printf+0x1f0>
    14da:	bdb5                	j	1356 <printf+0x5e>
    14dc:	0024c783          	lbu	a5,2(s1)
    14e0:	0605                	addi	a2,a2,1
    14e2:	0489                	addi	s1,s1,2
    14e4:	e72799e3          	bne	a5,s2,1356 <printf+0x5e>
    14e8:	0014c783          	lbu	a5,1(s1)
    14ec:	ff2788e3          	beq	a5,s2,14dc <printf+0x1e4>
        l = z - a;
    14f0:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    14f4:	85aa                	mv	a1,a0
    14f6:	8622                	mv	a2,s0
    14f8:	4505                	li	a0,1
    14fa:	738000ef          	jal	1c32 <write>
        if (l)
    14fe:	e60405e3          	beqz	s0,1368 <printf+0x70>
    1502:	8526                	mv	a0,s1
    1504:	bd2d                	j	133e <printf+0x46>
        switch (s[1])
    1506:	05579963          	bne	a5,s5,1558 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    150a:	6782                	ld	a5,0(sp)
    150c:	45c1                	li	a1,16
    150e:	4388                	lw	a0,0(a5)
    1510:	07a1                	addi	a5,a5,8
    1512:	e03e                	sd	a5,0(sp)
    1514:	b6bff0ef          	jal	107e <printint.constprop.0>
        s += 2;
    1518:	00248513          	addi	a0,s1,2
    151c:	bf59                	j	14b2 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    151e:	6782                	ld	a5,0(sp)
    1520:	45a9                	li	a1,10
    1522:	4388                	lw	a0,0(a5)
    1524:	07a1                	addi	a5,a5,8
    1526:	e03e                	sd	a5,0(sp)
    1528:	b57ff0ef          	jal	107e <printint.constprop.0>
        s += 2;
    152c:	00248513          	addi	a0,s1,2
    1530:	b749                	j	14b2 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1532:	6782                	ld	a5,0(sp)
    1534:	6380                	ld	s0,0(a5)
    1536:	07a1                	addi	a5,a5,8
    1538:	e03e                	sd	a5,0(sp)
    153a:	c031                	beqz	s0,157e <printf+0x286>
            l = strnlen(a, 200);
    153c:	0c800593          	li	a1,200
    1540:	8522                	mv	a0,s0
    1542:	3f8000ef          	jal	193a <strnlen>
    write(f, s, l);
    1546:	0005061b          	sext.w	a2,a0
    154a:	85a2                	mv	a1,s0
    154c:	4505                	li	a0,1
    154e:	6e4000ef          	jal	1c32 <write>
        s += 2;
    1552:	00248513          	addi	a0,s1,2
    1556:	bfb1                	j	14b2 <printf+0x1ba>
    return write(stdout, &byte, 1);
    1558:	4605                	li	a2,1
    155a:	002c                	addi	a1,sp,8
    155c:	4505                	li	a0,1
    char byte = c;
    155e:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    1562:	6d0000ef          	jal	1c32 <write>
    char byte = c;
    1566:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    156a:	4605                	li	a2,1
    156c:	002c                	addi	a1,sp,8
    156e:	4505                	li	a0,1
    char byte = c;
    1570:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1574:	6be000ef          	jal	1c32 <write>
        s += 2;
    1578:	00248513          	addi	a0,s1,2
    157c:	bf1d                	j	14b2 <printf+0x1ba>
                a = "(null)";
    157e:	845e                	mv	s0,s7
    1580:	bf75                	j	153c <printf+0x244>

0000000000001582 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1582:	02000793          	li	a5,32
    1586:	00f50663          	beq	a0,a5,1592 <isspace+0x10>
    158a:	355d                	addiw	a0,a0,-9
    158c:	00553513          	sltiu	a0,a0,5
    1590:	8082                	ret
    1592:	4505                	li	a0,1
}
    1594:	8082                	ret

0000000000001596 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1596:	fd05051b          	addiw	a0,a0,-48
}
    159a:	00a53513          	sltiu	a0,a0,10
    159e:	8082                	ret

00000000000015a0 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15a0:	02000613          	li	a2,32
    15a4:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15a6:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15aa:	ff77069b          	addiw	a3,a4,-9
    15ae:	04c70d63          	beq	a4,a2,1608 <atoi+0x68>
    15b2:	0007079b          	sext.w	a5,a4
    15b6:	04d5f963          	bgeu	a1,a3,1608 <atoi+0x68>
        s++;
    switch (*s)
    15ba:	02b00693          	li	a3,43
    15be:	04d70a63          	beq	a4,a3,1612 <atoi+0x72>
    15c2:	02d00693          	li	a3,45
    15c6:	06d70463          	beq	a4,a3,162e <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    15ca:	fd07859b          	addiw	a1,a5,-48
    15ce:	4625                	li	a2,9
    15d0:	873e                	mv	a4,a5
    15d2:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    15d4:	4e01                	li	t3,0
    while (isdigit(*s))
    15d6:	04b66a63          	bltu	a2,a1,162a <atoi+0x8a>
    int n = 0, neg = 0;
    15da:	4501                	li	a0,0
    while (isdigit(*s))
    15dc:	4825                	li	a6,9
    15de:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    15e2:	0025179b          	slliw	a5,a0,0x2
    15e6:	9d3d                	addw	a0,a0,a5
    15e8:	fd07031b          	addiw	t1,a4,-48
    15ec:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    15f0:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    15f4:	0685                	addi	a3,a3,1
    15f6:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    15fa:	0006071b          	sext.w	a4,a2
    15fe:	feb870e3          	bgeu	a6,a1,15de <atoi+0x3e>
    return neg ? n : -n;
    1602:	000e0563          	beqz	t3,160c <atoi+0x6c>
}
    1606:	8082                	ret
        s++;
    1608:	0505                	addi	a0,a0,1
    160a:	bf71                	j	15a6 <atoi+0x6>
    return neg ? n : -n;
    160c:	4113053b          	subw	a0,t1,a7
    1610:	8082                	ret
    while (isdigit(*s))
    1612:	00154783          	lbu	a5,1(a0)
    1616:	4625                	li	a2,9
        s++;
    1618:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    161c:	fd07859b          	addiw	a1,a5,-48
    1620:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1624:	4e01                	li	t3,0
    while (isdigit(*s))
    1626:	fab67ae3          	bgeu	a2,a1,15da <atoi+0x3a>
    162a:	4501                	li	a0,0
}
    162c:	8082                	ret
    while (isdigit(*s))
    162e:	00154783          	lbu	a5,1(a0)
    1632:	4625                	li	a2,9
        s++;
    1634:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1638:	fd07859b          	addiw	a1,a5,-48
    163c:	0007871b          	sext.w	a4,a5
    1640:	feb665e3          	bltu	a2,a1,162a <atoi+0x8a>
        neg = 1;
    1644:	4e05                	li	t3,1
    1646:	bf51                	j	15da <atoi+0x3a>

0000000000001648 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1648:	16060d63          	beqz	a2,17c2 <memset+0x17a>
    164c:	40a007b3          	neg	a5,a0
    1650:	8b9d                	andi	a5,a5,7
    1652:	00778713          	addi	a4,a5,7
    1656:	482d                	li	a6,11
    1658:	0ff5f593          	zext.b	a1,a1
    165c:	fff60693          	addi	a3,a2,-1
    1660:	17076263          	bltu	a4,a6,17c4 <memset+0x17c>
    1664:	16e6ea63          	bltu	a3,a4,17d8 <memset+0x190>
    1668:	16078563          	beqz	a5,17d2 <memset+0x18a>
    166c:	00b50023          	sb	a1,0(a0)
    1670:	4705                	li	a4,1
    1672:	00150e93          	addi	t4,a0,1
    1676:	14e78c63          	beq	a5,a4,17ce <memset+0x186>
    167a:	00b500a3          	sb	a1,1(a0)
    167e:	4709                	li	a4,2
    1680:	00250e93          	addi	t4,a0,2
    1684:	14e78d63          	beq	a5,a4,17de <memset+0x196>
    1688:	00b50123          	sb	a1,2(a0)
    168c:	470d                	li	a4,3
    168e:	00350e93          	addi	t4,a0,3
    1692:	12e78b63          	beq	a5,a4,17c8 <memset+0x180>
    1696:	00b501a3          	sb	a1,3(a0)
    169a:	4711                	li	a4,4
    169c:	00450e93          	addi	t4,a0,4
    16a0:	14e78163          	beq	a5,a4,17e2 <memset+0x19a>
    16a4:	00b50223          	sb	a1,4(a0)
    16a8:	4715                	li	a4,5
    16aa:	00550e93          	addi	t4,a0,5
    16ae:	12e78c63          	beq	a5,a4,17e6 <memset+0x19e>
    16b2:	00b502a3          	sb	a1,5(a0)
    16b6:	471d                	li	a4,7
    16b8:	00650e93          	addi	t4,a0,6
    16bc:	12e79763          	bne	a5,a4,17ea <memset+0x1a2>
    16c0:	00750e93          	addi	t4,a0,7
    16c4:	00b50323          	sb	a1,6(a0)
    16c8:	4f1d                	li	t5,7
    16ca:	00859713          	slli	a4,a1,0x8
    16ce:	8f4d                	or	a4,a4,a1
    16d0:	01059e13          	slli	t3,a1,0x10
    16d4:	01c76e33          	or	t3,a4,t3
    16d8:	01859313          	slli	t1,a1,0x18
    16dc:	006e6333          	or	t1,t3,t1
    16e0:	02059893          	slli	a7,a1,0x20
    16e4:	011368b3          	or	a7,t1,a7
    16e8:	02859813          	slli	a6,a1,0x28
    16ec:	40f60333          	sub	t1,a2,a5
    16f0:	0108e833          	or	a6,a7,a6
    16f4:	03059693          	slli	a3,a1,0x30
    16f8:	00d866b3          	or	a3,a6,a3
    16fc:	03859713          	slli	a4,a1,0x38
    1700:	97aa                	add	a5,a5,a0
    1702:	ff837813          	andi	a6,t1,-8
    1706:	8f55                	or	a4,a4,a3
    1708:	00f806b3          	add	a3,a6,a5
    170c:	e398                	sd	a4,0(a5)
    170e:	07a1                	addi	a5,a5,8
    1710:	fed79ee3          	bne	a5,a3,170c <memset+0xc4>
    1714:	ff837693          	andi	a3,t1,-8
    1718:	00de87b3          	add	a5,t4,a3
    171c:	01e6873b          	addw	a4,a3,t5
    1720:	0ad30663          	beq	t1,a3,17cc <memset+0x184>
    1724:	00b78023          	sb	a1,0(a5)
    1728:	0017069b          	addiw	a3,a4,1
    172c:	08c6fb63          	bgeu	a3,a2,17c2 <memset+0x17a>
    1730:	00b780a3          	sb	a1,1(a5)
    1734:	0027069b          	addiw	a3,a4,2
    1738:	08c6f563          	bgeu	a3,a2,17c2 <memset+0x17a>
    173c:	00b78123          	sb	a1,2(a5)
    1740:	0037069b          	addiw	a3,a4,3
    1744:	06c6ff63          	bgeu	a3,a2,17c2 <memset+0x17a>
    1748:	00b781a3          	sb	a1,3(a5)
    174c:	0047069b          	addiw	a3,a4,4
    1750:	06c6f963          	bgeu	a3,a2,17c2 <memset+0x17a>
    1754:	00b78223          	sb	a1,4(a5)
    1758:	0057069b          	addiw	a3,a4,5
    175c:	06c6f363          	bgeu	a3,a2,17c2 <memset+0x17a>
    1760:	00b782a3          	sb	a1,5(a5)
    1764:	0067069b          	addiw	a3,a4,6
    1768:	04c6fd63          	bgeu	a3,a2,17c2 <memset+0x17a>
    176c:	00b78323          	sb	a1,6(a5)
    1770:	0077069b          	addiw	a3,a4,7
    1774:	04c6f763          	bgeu	a3,a2,17c2 <memset+0x17a>
    1778:	00b783a3          	sb	a1,7(a5)
    177c:	0087069b          	addiw	a3,a4,8
    1780:	04c6f163          	bgeu	a3,a2,17c2 <memset+0x17a>
    1784:	00b78423          	sb	a1,8(a5)
    1788:	0097069b          	addiw	a3,a4,9
    178c:	02c6fb63          	bgeu	a3,a2,17c2 <memset+0x17a>
    1790:	00b784a3          	sb	a1,9(a5)
    1794:	00a7069b          	addiw	a3,a4,10
    1798:	02c6f563          	bgeu	a3,a2,17c2 <memset+0x17a>
    179c:	00b78523          	sb	a1,10(a5)
    17a0:	00b7069b          	addiw	a3,a4,11
    17a4:	00c6ff63          	bgeu	a3,a2,17c2 <memset+0x17a>
    17a8:	00b785a3          	sb	a1,11(a5)
    17ac:	00c7069b          	addiw	a3,a4,12
    17b0:	00c6f963          	bgeu	a3,a2,17c2 <memset+0x17a>
    17b4:	00b78623          	sb	a1,12(a5)
    17b8:	2735                	addiw	a4,a4,13
    17ba:	00c77463          	bgeu	a4,a2,17c2 <memset+0x17a>
    17be:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    17c2:	8082                	ret
    17c4:	472d                	li	a4,11
    17c6:	bd79                	j	1664 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    17c8:	4f0d                	li	t5,3
    17ca:	b701                	j	16ca <memset+0x82>
    17cc:	8082                	ret
    17ce:	4f05                	li	t5,1
    17d0:	bded                	j	16ca <memset+0x82>
    17d2:	8eaa                	mv	t4,a0
    17d4:	4f01                	li	t5,0
    17d6:	bdd5                	j	16ca <memset+0x82>
    17d8:	87aa                	mv	a5,a0
    17da:	4701                	li	a4,0
    17dc:	b7a1                	j	1724 <memset+0xdc>
    17de:	4f09                	li	t5,2
    17e0:	b5ed                	j	16ca <memset+0x82>
    17e2:	4f11                	li	t5,4
    17e4:	b5dd                	j	16ca <memset+0x82>
    17e6:	4f15                	li	t5,5
    17e8:	b5cd                	j	16ca <memset+0x82>
    17ea:	4f19                	li	t5,6
    17ec:	bdf9                	j	16ca <memset+0x82>

00000000000017ee <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    17ee:	00054783          	lbu	a5,0(a0)
    17f2:	0005c703          	lbu	a4,0(a1)
    17f6:	00e79863          	bne	a5,a4,1806 <strcmp+0x18>
    17fa:	0505                	addi	a0,a0,1
    17fc:	0585                	addi	a1,a1,1
    17fe:	fbe5                	bnez	a5,17ee <strcmp>
    1800:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1802:	9d19                	subw	a0,a0,a4
    1804:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1806:	0007851b          	sext.w	a0,a5
    180a:	bfe5                	j	1802 <strcmp+0x14>

000000000000180c <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    180c:	ce05                	beqz	a2,1844 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    180e:	00054703          	lbu	a4,0(a0)
    1812:	0005c783          	lbu	a5,0(a1)
    1816:	cb0d                	beqz	a4,1848 <strncmp+0x3c>
    if (!n--)
    1818:	167d                	addi	a2,a2,-1
    181a:	00c506b3          	add	a3,a0,a2
    181e:	a819                	j	1834 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1820:	00a68e63          	beq	a3,a0,183c <strncmp+0x30>
    1824:	0505                	addi	a0,a0,1
    1826:	00e79b63          	bne	a5,a4,183c <strncmp+0x30>
    182a:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    182e:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1832:	cb19                	beqz	a4,1848 <strncmp+0x3c>
    1834:	0005c783          	lbu	a5,0(a1)
    1838:	0585                	addi	a1,a1,1
    183a:	f3fd                	bnez	a5,1820 <strncmp+0x14>
    return *l - *r;
    183c:	0007051b          	sext.w	a0,a4
    1840:	9d1d                	subw	a0,a0,a5
    1842:	8082                	ret
        return 0;
    1844:	4501                	li	a0,0
}
    1846:	8082                	ret
    1848:	4501                	li	a0,0
    return *l - *r;
    184a:	9d1d                	subw	a0,a0,a5
    184c:	8082                	ret

000000000000184e <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    184e:	00757793          	andi	a5,a0,7
    1852:	cf89                	beqz	a5,186c <strlen+0x1e>
    1854:	87aa                	mv	a5,a0
    1856:	a029                	j	1860 <strlen+0x12>
    1858:	0785                	addi	a5,a5,1
    185a:	0077f713          	andi	a4,a5,7
    185e:	cb01                	beqz	a4,186e <strlen+0x20>
        if (!*s)
    1860:	0007c703          	lbu	a4,0(a5)
    1864:	fb75                	bnez	a4,1858 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    1866:	40a78533          	sub	a0,a5,a0
}
    186a:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    186c:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    186e:	6394                	ld	a3,0(a5)
    1870:	00000597          	auipc	a1,0x0
    1874:	6805b583          	ld	a1,1664(a1) # 1ef0 <__clone+0x86>
    1878:	00000617          	auipc	a2,0x0
    187c:	68063603          	ld	a2,1664(a2) # 1ef8 <__clone+0x8e>
    1880:	a019                	j	1886 <strlen+0x38>
    1882:	6794                	ld	a3,8(a5)
    1884:	07a1                	addi	a5,a5,8
    1886:	00b68733          	add	a4,a3,a1
    188a:	fff6c693          	not	a3,a3
    188e:	8f75                	and	a4,a4,a3
    1890:	8f71                	and	a4,a4,a2
    1892:	db65                	beqz	a4,1882 <strlen+0x34>
    for (; *s; s++)
    1894:	0007c703          	lbu	a4,0(a5)
    1898:	d779                	beqz	a4,1866 <strlen+0x18>
    189a:	0017c703          	lbu	a4,1(a5)
    189e:	0785                	addi	a5,a5,1
    18a0:	d379                	beqz	a4,1866 <strlen+0x18>
    18a2:	0017c703          	lbu	a4,1(a5)
    18a6:	0785                	addi	a5,a5,1
    18a8:	fb6d                	bnez	a4,189a <strlen+0x4c>
    18aa:	bf75                	j	1866 <strlen+0x18>

00000000000018ac <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18ac:	00757713          	andi	a4,a0,7
{
    18b0:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18b2:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18b6:	cb19                	beqz	a4,18cc <memchr+0x20>
    18b8:	ce25                	beqz	a2,1930 <memchr+0x84>
    18ba:	0007c703          	lbu	a4,0(a5)
    18be:	04b70e63          	beq	a4,a1,191a <memchr+0x6e>
    18c2:	0785                	addi	a5,a5,1
    18c4:	0077f713          	andi	a4,a5,7
    18c8:	167d                	addi	a2,a2,-1
    18ca:	f77d                	bnez	a4,18b8 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    18cc:	4501                	li	a0,0
    if (n && *s != c)
    18ce:	c235                	beqz	a2,1932 <memchr+0x86>
    18d0:	0007c703          	lbu	a4,0(a5)
    18d4:	04b70363          	beq	a4,a1,191a <memchr+0x6e>
        size_t k = ONES * c;
    18d8:	00000517          	auipc	a0,0x0
    18dc:	62853503          	ld	a0,1576(a0) # 1f00 <__clone+0x96>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    18e0:	471d                	li	a4,7
        size_t k = ONES * c;
    18e2:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    18e6:	02c77a63          	bgeu	a4,a2,191a <memchr+0x6e>
    18ea:	00000897          	auipc	a7,0x0
    18ee:	6068b883          	ld	a7,1542(a7) # 1ef0 <__clone+0x86>
    18f2:	00000817          	auipc	a6,0x0
    18f6:	60683803          	ld	a6,1542(a6) # 1ef8 <__clone+0x8e>
    18fa:	431d                	li	t1,7
    18fc:	a029                	j	1906 <memchr+0x5a>
    18fe:	1661                	addi	a2,a2,-8
    1900:	07a1                	addi	a5,a5,8
    1902:	02c37963          	bgeu	t1,a2,1934 <memchr+0x88>
    1906:	6398                	ld	a4,0(a5)
    1908:	8f29                	xor	a4,a4,a0
    190a:	011706b3          	add	a3,a4,a7
    190e:	fff74713          	not	a4,a4
    1912:	8f75                	and	a4,a4,a3
    1914:	01077733          	and	a4,a4,a6
    1918:	d37d                	beqz	a4,18fe <memchr+0x52>
    191a:	853e                	mv	a0,a5
    191c:	97b2                	add	a5,a5,a2
    191e:	a021                	j	1926 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1920:	0505                	addi	a0,a0,1
    1922:	00f50763          	beq	a0,a5,1930 <memchr+0x84>
    1926:	00054703          	lbu	a4,0(a0)
    192a:	feb71be3          	bne	a4,a1,1920 <memchr+0x74>
    192e:	8082                	ret
    return n ? (void *)s : 0;
    1930:	4501                	li	a0,0
}
    1932:	8082                	ret
    return n ? (void *)s : 0;
    1934:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1936:	f275                	bnez	a2,191a <memchr+0x6e>
}
    1938:	8082                	ret

000000000000193a <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    193a:	1101                	addi	sp,sp,-32
    193c:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    193e:	862e                	mv	a2,a1
{
    1940:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1942:	4581                	li	a1,0
{
    1944:	e426                	sd	s1,8(sp)
    1946:	ec06                	sd	ra,24(sp)
    1948:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    194a:	f63ff0ef          	jal	18ac <memchr>
    return p ? p - s : n;
    194e:	c519                	beqz	a0,195c <strnlen+0x22>
}
    1950:	60e2                	ld	ra,24(sp)
    1952:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1954:	8d05                	sub	a0,a0,s1
}
    1956:	64a2                	ld	s1,8(sp)
    1958:	6105                	addi	sp,sp,32
    195a:	8082                	ret
    195c:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    195e:	8522                	mv	a0,s0
}
    1960:	6442                	ld	s0,16(sp)
    1962:	64a2                	ld	s1,8(sp)
    1964:	6105                	addi	sp,sp,32
    1966:	8082                	ret

0000000000001968 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    1968:	00b547b3          	xor	a5,a0,a1
    196c:	8b9d                	andi	a5,a5,7
    196e:	eb95                	bnez	a5,19a2 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    1970:	0075f793          	andi	a5,a1,7
    1974:	e7b1                	bnez	a5,19c0 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1976:	6198                	ld	a4,0(a1)
    1978:	00000617          	auipc	a2,0x0
    197c:	57863603          	ld	a2,1400(a2) # 1ef0 <__clone+0x86>
    1980:	00000817          	auipc	a6,0x0
    1984:	57883803          	ld	a6,1400(a6) # 1ef8 <__clone+0x8e>
    1988:	a029                	j	1992 <strcpy+0x2a>
    198a:	e118                	sd	a4,0(a0)
    198c:	6598                	ld	a4,8(a1)
    198e:	05a1                	addi	a1,a1,8
    1990:	0521                	addi	a0,a0,8
    1992:	00c707b3          	add	a5,a4,a2
    1996:	fff74693          	not	a3,a4
    199a:	8ff5                	and	a5,a5,a3
    199c:	0107f7b3          	and	a5,a5,a6
    19a0:	d7ed                	beqz	a5,198a <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19a2:	0005c783          	lbu	a5,0(a1)
    19a6:	00f50023          	sb	a5,0(a0)
    19aa:	c785                	beqz	a5,19d2 <strcpy+0x6a>
    19ac:	0015c783          	lbu	a5,1(a1)
    19b0:	0505                	addi	a0,a0,1
    19b2:	0585                	addi	a1,a1,1
    19b4:	00f50023          	sb	a5,0(a0)
    19b8:	fbf5                	bnez	a5,19ac <strcpy+0x44>
        ;
    return d;
}
    19ba:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    19bc:	0505                	addi	a0,a0,1
    19be:	df45                	beqz	a4,1976 <strcpy+0xe>
            if (!(*d = *s))
    19c0:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    19c4:	0585                	addi	a1,a1,1
    19c6:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    19ca:	00f50023          	sb	a5,0(a0)
    19ce:	f7fd                	bnez	a5,19bc <strcpy+0x54>
}
    19d0:	8082                	ret
    19d2:	8082                	ret

00000000000019d4 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    19d4:	00b547b3          	xor	a5,a0,a1
    19d8:	8b9d                	andi	a5,a5,7
    19da:	1a079863          	bnez	a5,1b8a <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    19de:	0075f793          	andi	a5,a1,7
    19e2:	16078463          	beqz	a5,1b4a <strncpy+0x176>
    19e6:	ea01                	bnez	a2,19f6 <strncpy+0x22>
    19e8:	a421                	j	1bf0 <strncpy+0x21c>
    19ea:	167d                	addi	a2,a2,-1
    19ec:	0505                	addi	a0,a0,1
    19ee:	14070e63          	beqz	a4,1b4a <strncpy+0x176>
    19f2:	1a060863          	beqz	a2,1ba2 <strncpy+0x1ce>
    19f6:	0005c783          	lbu	a5,0(a1)
    19fa:	0585                	addi	a1,a1,1
    19fc:	0075f713          	andi	a4,a1,7
    1a00:	00f50023          	sb	a5,0(a0)
    1a04:	f3fd                	bnez	a5,19ea <strncpy+0x16>
    1a06:	4805                	li	a6,1
    1a08:	1a061863          	bnez	a2,1bb8 <strncpy+0x1e4>
    1a0c:	40a007b3          	neg	a5,a0
    1a10:	8b9d                	andi	a5,a5,7
    1a12:	4681                	li	a3,0
    1a14:	18061a63          	bnez	a2,1ba8 <strncpy+0x1d4>
    1a18:	00778713          	addi	a4,a5,7
    1a1c:	45ad                	li	a1,11
    1a1e:	18b76363          	bltu	a4,a1,1ba4 <strncpy+0x1d0>
    1a22:	1ae6eb63          	bltu	a3,a4,1bd8 <strncpy+0x204>
    1a26:	1a078363          	beqz	a5,1bcc <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a2a:	00050023          	sb	zero,0(a0)
    1a2e:	4685                	li	a3,1
    1a30:	00150713          	addi	a4,a0,1
    1a34:	18d78f63          	beq	a5,a3,1bd2 <strncpy+0x1fe>
    1a38:	000500a3          	sb	zero,1(a0)
    1a3c:	4689                	li	a3,2
    1a3e:	00250713          	addi	a4,a0,2
    1a42:	18d78e63          	beq	a5,a3,1bde <strncpy+0x20a>
    1a46:	00050123          	sb	zero,2(a0)
    1a4a:	468d                	li	a3,3
    1a4c:	00350713          	addi	a4,a0,3
    1a50:	16d78c63          	beq	a5,a3,1bc8 <strncpy+0x1f4>
    1a54:	000501a3          	sb	zero,3(a0)
    1a58:	4691                	li	a3,4
    1a5a:	00450713          	addi	a4,a0,4
    1a5e:	18d78263          	beq	a5,a3,1be2 <strncpy+0x20e>
    1a62:	00050223          	sb	zero,4(a0)
    1a66:	4695                	li	a3,5
    1a68:	00550713          	addi	a4,a0,5
    1a6c:	16d78d63          	beq	a5,a3,1be6 <strncpy+0x212>
    1a70:	000502a3          	sb	zero,5(a0)
    1a74:	469d                	li	a3,7
    1a76:	00650713          	addi	a4,a0,6
    1a7a:	16d79863          	bne	a5,a3,1bea <strncpy+0x216>
    1a7e:	00750713          	addi	a4,a0,7
    1a82:	00050323          	sb	zero,6(a0)
    1a86:	40f80833          	sub	a6,a6,a5
    1a8a:	ff887593          	andi	a1,a6,-8
    1a8e:	97aa                	add	a5,a5,a0
    1a90:	95be                	add	a1,a1,a5
    1a92:	0007b023          	sd	zero,0(a5)
    1a96:	07a1                	addi	a5,a5,8
    1a98:	feb79de3          	bne	a5,a1,1a92 <strncpy+0xbe>
    1a9c:	ff887593          	andi	a1,a6,-8
    1aa0:	9ead                	addw	a3,a3,a1
    1aa2:	00b707b3          	add	a5,a4,a1
    1aa6:	12b80863          	beq	a6,a1,1bd6 <strncpy+0x202>
    1aaa:	00078023          	sb	zero,0(a5)
    1aae:	0016871b          	addiw	a4,a3,1
    1ab2:	0ec77863          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1ab6:	000780a3          	sb	zero,1(a5)
    1aba:	0026871b          	addiw	a4,a3,2
    1abe:	0ec77263          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1ac2:	00078123          	sb	zero,2(a5)
    1ac6:	0036871b          	addiw	a4,a3,3
    1aca:	0cc77c63          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1ace:	000781a3          	sb	zero,3(a5)
    1ad2:	0046871b          	addiw	a4,a3,4
    1ad6:	0cc77663          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1ada:	00078223          	sb	zero,4(a5)
    1ade:	0056871b          	addiw	a4,a3,5
    1ae2:	0cc77063          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1ae6:	000782a3          	sb	zero,5(a5)
    1aea:	0066871b          	addiw	a4,a3,6
    1aee:	0ac77a63          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1af2:	00078323          	sb	zero,6(a5)
    1af6:	0076871b          	addiw	a4,a3,7
    1afa:	0ac77463          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1afe:	000783a3          	sb	zero,7(a5)
    1b02:	0086871b          	addiw	a4,a3,8
    1b06:	08c77e63          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1b0a:	00078423          	sb	zero,8(a5)
    1b0e:	0096871b          	addiw	a4,a3,9
    1b12:	08c77863          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1b16:	000784a3          	sb	zero,9(a5)
    1b1a:	00a6871b          	addiw	a4,a3,10
    1b1e:	08c77263          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1b22:	00078523          	sb	zero,10(a5)
    1b26:	00b6871b          	addiw	a4,a3,11
    1b2a:	06c77c63          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1b2e:	000785a3          	sb	zero,11(a5)
    1b32:	00c6871b          	addiw	a4,a3,12
    1b36:	06c77663          	bgeu	a4,a2,1ba2 <strncpy+0x1ce>
    1b3a:	00078623          	sb	zero,12(a5)
    1b3e:	26b5                	addiw	a3,a3,13
    1b40:	06c6f163          	bgeu	a3,a2,1ba2 <strncpy+0x1ce>
    1b44:	000786a3          	sb	zero,13(a5)
    1b48:	8082                	ret
            ;
        if (!n || !*s)
    1b4a:	c645                	beqz	a2,1bf2 <strncpy+0x21e>
    1b4c:	0005c783          	lbu	a5,0(a1)
    1b50:	ea078be3          	beqz	a5,1a06 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b54:	479d                	li	a5,7
    1b56:	02c7ff63          	bgeu	a5,a2,1b94 <strncpy+0x1c0>
    1b5a:	00000897          	auipc	a7,0x0
    1b5e:	3968b883          	ld	a7,918(a7) # 1ef0 <__clone+0x86>
    1b62:	00000817          	auipc	a6,0x0
    1b66:	39683803          	ld	a6,918(a6) # 1ef8 <__clone+0x8e>
    1b6a:	431d                	li	t1,7
    1b6c:	6198                	ld	a4,0(a1)
    1b6e:	011707b3          	add	a5,a4,a7
    1b72:	fff74693          	not	a3,a4
    1b76:	8ff5                	and	a5,a5,a3
    1b78:	0107f7b3          	and	a5,a5,a6
    1b7c:	ef81                	bnez	a5,1b94 <strncpy+0x1c0>
            *wd = *ws;
    1b7e:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b80:	1661                	addi	a2,a2,-8
    1b82:	05a1                	addi	a1,a1,8
    1b84:	0521                	addi	a0,a0,8
    1b86:	fec363e3          	bltu	t1,a2,1b6c <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1b8a:	e609                	bnez	a2,1b94 <strncpy+0x1c0>
    1b8c:	a08d                	j	1bee <strncpy+0x21a>
    1b8e:	167d                	addi	a2,a2,-1
    1b90:	0505                	addi	a0,a0,1
    1b92:	ca01                	beqz	a2,1ba2 <strncpy+0x1ce>
    1b94:	0005c783          	lbu	a5,0(a1)
    1b98:	0585                	addi	a1,a1,1
    1b9a:	00f50023          	sb	a5,0(a0)
    1b9e:	fbe5                	bnez	a5,1b8e <strncpy+0x1ba>
        ;
tail:
    1ba0:	b59d                	j	1a06 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1ba2:	8082                	ret
    1ba4:	472d                	li	a4,11
    1ba6:	bdb5                	j	1a22 <strncpy+0x4e>
    1ba8:	00778713          	addi	a4,a5,7
    1bac:	45ad                	li	a1,11
    1bae:	fff60693          	addi	a3,a2,-1
    1bb2:	e6b778e3          	bgeu	a4,a1,1a22 <strncpy+0x4e>
    1bb6:	b7fd                	j	1ba4 <strncpy+0x1d0>
    1bb8:	40a007b3          	neg	a5,a0
    1bbc:	8832                	mv	a6,a2
    1bbe:	8b9d                	andi	a5,a5,7
    1bc0:	4681                	li	a3,0
    1bc2:	e4060be3          	beqz	a2,1a18 <strncpy+0x44>
    1bc6:	b7cd                	j	1ba8 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1bc8:	468d                	li	a3,3
    1bca:	bd75                	j	1a86 <strncpy+0xb2>
    1bcc:	872a                	mv	a4,a0
    1bce:	4681                	li	a3,0
    1bd0:	bd5d                	j	1a86 <strncpy+0xb2>
    1bd2:	4685                	li	a3,1
    1bd4:	bd4d                	j	1a86 <strncpy+0xb2>
    1bd6:	8082                	ret
    1bd8:	87aa                	mv	a5,a0
    1bda:	4681                	li	a3,0
    1bdc:	b5f9                	j	1aaa <strncpy+0xd6>
    1bde:	4689                	li	a3,2
    1be0:	b55d                	j	1a86 <strncpy+0xb2>
    1be2:	4691                	li	a3,4
    1be4:	b54d                	j	1a86 <strncpy+0xb2>
    1be6:	4695                	li	a3,5
    1be8:	bd79                	j	1a86 <strncpy+0xb2>
    1bea:	4699                	li	a3,6
    1bec:	bd69                	j	1a86 <strncpy+0xb2>
    1bee:	8082                	ret
    1bf0:	8082                	ret
    1bf2:	8082                	ret

0000000000001bf4 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1bf4:	87aa                	mv	a5,a0
    1bf6:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1bf8:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1bfc:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c00:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c02:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c04:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c08:	2501                	sext.w	a0,a0
    1c0a:	8082                	ret

0000000000001c0c <openat>:
    register long a7 __asm__("a7") = n;
    1c0c:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c10:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c14:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c18:	2501                	sext.w	a0,a0
    1c1a:	8082                	ret

0000000000001c1c <close>:
    register long a7 __asm__("a7") = n;
    1c1c:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c20:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c24:	2501                	sext.w	a0,a0
    1c26:	8082                	ret

0000000000001c28 <read>:
    register long a7 __asm__("a7") = n;
    1c28:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c2c:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c30:	8082                	ret

0000000000001c32 <write>:
    register long a7 __asm__("a7") = n;
    1c32:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c36:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c3a:	8082                	ret

0000000000001c3c <getpid>:
    register long a7 __asm__("a7") = n;
    1c3c:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c40:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c44:	2501                	sext.w	a0,a0
    1c46:	8082                	ret

0000000000001c48 <getppid>:
    register long a7 __asm__("a7") = n;
    1c48:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c4c:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c50:	2501                	sext.w	a0,a0
    1c52:	8082                	ret

0000000000001c54 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c54:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c58:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c5c:	2501                	sext.w	a0,a0
    1c5e:	8082                	ret

0000000000001c60 <fork>:
    register long a7 __asm__("a7") = n;
    1c60:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1c64:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1c66:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c68:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1c6c:	2501                	sext.w	a0,a0
    1c6e:	8082                	ret

0000000000001c70 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1c70:	85b2                	mv	a1,a2
    1c72:	863a                	mv	a2,a4
    if (stack)
    1c74:	c191                	beqz	a1,1c78 <clone+0x8>
	stack += stack_size;
    1c76:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1c78:	4781                	li	a5,0
    1c7a:	4701                	li	a4,0
    1c7c:	4681                	li	a3,0
    1c7e:	2601                	sext.w	a2,a2
    1c80:	a2ed                	j	1e6a <__clone>

0000000000001c82 <exit>:
    register long a7 __asm__("a7") = n;
    1c82:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1c86:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1c8a:	8082                	ret

0000000000001c8c <waitpid>:
    register long a7 __asm__("a7") = n;
    1c8c:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1c90:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c92:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1c96:	2501                	sext.w	a0,a0
    1c98:	8082                	ret

0000000000001c9a <exec>:
    register long a7 __asm__("a7") = n;
    1c9a:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1c9e:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1ca2:	2501                	sext.w	a0,a0
    1ca4:	8082                	ret

0000000000001ca6 <execve>:
    register long a7 __asm__("a7") = n;
    1ca6:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1caa:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1cae:	2501                	sext.w	a0,a0
    1cb0:	8082                	ret

0000000000001cb2 <times>:
    register long a7 __asm__("a7") = n;
    1cb2:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1cb6:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1cba:	2501                	sext.w	a0,a0
    1cbc:	8082                	ret

0000000000001cbe <get_time>:

int64 get_time()
{
    1cbe:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1cc0:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1cc4:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1cc6:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cc8:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1ccc:	2501                	sext.w	a0,a0
    1cce:	ed09                	bnez	a0,1ce8 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1cd0:	67a2                	ld	a5,8(sp)
    1cd2:	3e800713          	li	a4,1000
    1cd6:	00015503          	lhu	a0,0(sp)
    1cda:	02e7d7b3          	divu	a5,a5,a4
    1cde:	02e50533          	mul	a0,a0,a4
    1ce2:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1ce4:	0141                	addi	sp,sp,16
    1ce6:	8082                	ret
        return -1;
    1ce8:	557d                	li	a0,-1
    1cea:	bfed                	j	1ce4 <get_time+0x26>

0000000000001cec <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1cec:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cf0:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1cf4:	2501                	sext.w	a0,a0
    1cf6:	8082                	ret

0000000000001cf8 <time>:
    register long a7 __asm__("a7") = n;
    1cf8:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1cfc:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d00:	2501                	sext.w	a0,a0
    1d02:	8082                	ret

0000000000001d04 <sleep>:

int sleep(unsigned long long time)
{
    1d04:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d06:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d08:	850a                	mv	a0,sp
    1d0a:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d0c:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d10:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d12:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d16:	e501                	bnez	a0,1d1e <sleep+0x1a>
    return 0;
    1d18:	4501                	li	a0,0
}
    1d1a:	0141                	addi	sp,sp,16
    1d1c:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d1e:	4502                	lw	a0,0(sp)
}
    1d20:	0141                	addi	sp,sp,16
    1d22:	8082                	ret

0000000000001d24 <set_priority>:
    register long a7 __asm__("a7") = n;
    1d24:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d28:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d2c:	2501                	sext.w	a0,a0
    1d2e:	8082                	ret

0000000000001d30 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d30:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d34:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d38:	8082                	ret

0000000000001d3a <munmap>:
    register long a7 __asm__("a7") = n;
    1d3a:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d3e:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d42:	2501                	sext.w	a0,a0
    1d44:	8082                	ret

0000000000001d46 <wait>:

int wait(int *code)
{
    1d46:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d48:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d4c:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d4e:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d50:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d52:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1d56:	2501                	sext.w	a0,a0
    1d58:	8082                	ret

0000000000001d5a <spawn>:
    register long a7 __asm__("a7") = n;
    1d5a:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1d5e:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1d62:	2501                	sext.w	a0,a0
    1d64:	8082                	ret

0000000000001d66 <mailread>:
    register long a7 __asm__("a7") = n;
    1d66:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d6a:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1d6e:	2501                	sext.w	a0,a0
    1d70:	8082                	ret

0000000000001d72 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1d72:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d76:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1d7a:	2501                	sext.w	a0,a0
    1d7c:	8082                	ret

0000000000001d7e <fstat>:
    register long a7 __asm__("a7") = n;
    1d7e:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d82:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1d86:	2501                	sext.w	a0,a0
    1d88:	8082                	ret

0000000000001d8a <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1d8a:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1d8c:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1d90:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1d92:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1d96:	2501                	sext.w	a0,a0
    1d98:	8082                	ret

0000000000001d9a <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1d9a:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1d9c:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1da0:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1da2:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1da6:	2501                	sext.w	a0,a0
    1da8:	8082                	ret

0000000000001daa <link>:

int link(char *old_path, char *new_path)
{
    1daa:	87aa                	mv	a5,a0
    1dac:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1dae:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1db2:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1db6:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1db8:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1dbc:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1dbe:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1dc2:	2501                	sext.w	a0,a0
    1dc4:	8082                	ret

0000000000001dc6 <unlink>:

int unlink(char *path)
{
    1dc6:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dc8:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1dcc:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1dd0:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dd2:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1dd6:	2501                	sext.w	a0,a0
    1dd8:	8082                	ret

0000000000001dda <uname>:
    register long a7 __asm__("a7") = n;
    1dda:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1dde:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1de2:	2501                	sext.w	a0,a0
    1de4:	8082                	ret

0000000000001de6 <brk>:
    register long a7 __asm__("a7") = n;
    1de6:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1dea:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1dee:	2501                	sext.w	a0,a0
    1df0:	8082                	ret

0000000000001df2 <getcwd>:
    register long a7 __asm__("a7") = n;
    1df2:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1df4:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1df8:	8082                	ret

0000000000001dfa <chdir>:
    register long a7 __asm__("a7") = n;
    1dfa:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1dfe:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e02:	2501                	sext.w	a0,a0
    1e04:	8082                	ret

0000000000001e06 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e06:	862e                	mv	a2,a1
    1e08:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e0a:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e0c:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e10:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e14:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e16:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e18:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e1c:	2501                	sext.w	a0,a0
    1e1e:	8082                	ret

0000000000001e20 <getdents>:
    register long a7 __asm__("a7") = n;
    1e20:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e24:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e28:	2501                	sext.w	a0,a0
    1e2a:	8082                	ret

0000000000001e2c <pipe>:
    register long a7 __asm__("a7") = n;
    1e2c:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e30:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e32:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e36:	2501                	sext.w	a0,a0
    1e38:	8082                	ret

0000000000001e3a <dup>:
    register long a7 __asm__("a7") = n;
    1e3a:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e3c:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e40:	2501                	sext.w	a0,a0
    1e42:	8082                	ret

0000000000001e44 <dup2>:
    register long a7 __asm__("a7") = n;
    1e44:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e46:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e48:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e4c:	2501                	sext.w	a0,a0
    1e4e:	8082                	ret

0000000000001e50 <mount>:
    register long a7 __asm__("a7") = n;
    1e50:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e54:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1e58:	2501                	sext.w	a0,a0
    1e5a:	8082                	ret

0000000000001e5c <umount>:
    register long a7 __asm__("a7") = n;
    1e5c:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1e60:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e62:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1e66:	2501                	sext.w	a0,a0
    1e68:	8082                	ret

0000000000001e6a <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1e6a:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1e6c:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1e6e:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1e70:	8532                	mv	a0,a2
	mv a2, a4
    1e72:	863a                	mv	a2,a4
	mv a3, a5
    1e74:	86be                	mv	a3,a5
	mv a4, a6
    1e76:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1e78:	0dc00893          	li	a7,220
	ecall
    1e7c:	00000073          	ecall

	beqz a0, 1f
    1e80:	c111                	beqz	a0,1e84 <__clone+0x1a>
	# Parent
	ret
    1e82:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1e84:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1e86:	6522                	ld	a0,8(sp)
	jalr a1
    1e88:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1e8a:	05d00893          	li	a7,93
	ecall
    1e8e:	00000073          	ecall
