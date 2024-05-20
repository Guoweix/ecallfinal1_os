
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/getcwd:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a075                	j	10ae <__start_main>

0000000000001004 <test_getcwd>:
 * 测试通过时输出：
 * "getcwd OK."
 * 测试失败时输出：
 * "getcwd ERROR."
 */
void test_getcwd(void){
    1004:	7175                	addi	sp,sp,-144
   TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	eda50513          	addi	a0,a0,-294 # 1ee0 <__clone+0x2c>
void test_getcwd(void){
    100e:	e506                	sd	ra,136(sp)
   TEST_START(__func__);
    1010:	310000ef          	jal	1320 <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	f5450513          	addi	a0,a0,-172 # 1f68 <__func__.0>
    101c:	304000ef          	jal	1320 <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ed850513          	addi	a0,a0,-296 # 1ef8 <__clone+0x44>
    1028:	2f8000ef          	jal	1320 <puts>
    char *cwd = NULL;
    char buf[128] = {0};
    cwd = getcwd(buf, 128);
    102c:	08000593          	li	a1,128
    1030:	850a                	mv	a0,sp
    char buf[128] = {0};
    1032:	e002                	sd	zero,0(sp)
    1034:	e402                	sd	zero,8(sp)
    1036:	e802                	sd	zero,16(sp)
    1038:	ec02                	sd	zero,24(sp)
    103a:	f002                	sd	zero,32(sp)
    103c:	f402                	sd	zero,40(sp)
    103e:	f802                	sd	zero,48(sp)
    1040:	fc02                	sd	zero,56(sp)
    1042:	e082                	sd	zero,64(sp)
    1044:	e482                	sd	zero,72(sp)
    1046:	e882                	sd	zero,80(sp)
    1048:	ec82                	sd	zero,88(sp)
    104a:	f082                	sd	zero,96(sp)
    104c:	f482                	sd	zero,104(sp)
    104e:	f882                	sd	zero,112(sp)
    1050:	fc82                	sd	zero,120(sp)
    cwd = getcwd(buf, 128);
    1052:	5eb000ef          	jal	1e3c <getcwd>
    if(cwd != NULL) printf("getcwd: %s successfully!\n", buf);
    1056:	cd0d                	beqz	a0,1090 <test_getcwd+0x8c>
    1058:	858a                	mv	a1,sp
    105a:	00001517          	auipc	a0,0x1
    105e:	eae50513          	addi	a0,a0,-338 # 1f08 <__clone+0x54>
    1062:	2e0000ef          	jal	1342 <printf>
    else printf("getcwd ERROR.\n");
   TEST_END(__func__);
    1066:	00001517          	auipc	a0,0x1
    106a:	ed250513          	addi	a0,a0,-302 # 1f38 <__clone+0x84>
    106e:	2b2000ef          	jal	1320 <puts>
    1072:	00001517          	auipc	a0,0x1
    1076:	ef650513          	addi	a0,a0,-266 # 1f68 <__func__.0>
    107a:	2a6000ef          	jal	1320 <puts>
    107e:	00001517          	auipc	a0,0x1
    1082:	e7a50513          	addi	a0,a0,-390 # 1ef8 <__clone+0x44>
    1086:	29a000ef          	jal	1320 <puts>
}
    108a:	60aa                	ld	ra,136(sp)
    108c:	6149                	addi	sp,sp,144
    108e:	8082                	ret
    else printf("getcwd ERROR.\n");
    1090:	00001517          	auipc	a0,0x1
    1094:	e9850513          	addi	a0,a0,-360 # 1f28 <__clone+0x74>
    1098:	2aa000ef          	jal	1342 <printf>
    109c:	b7e9                	j	1066 <test_getcwd+0x62>

000000000000109e <main>:

int main(void){
    109e:	1141                	addi	sp,sp,-16
    10a0:	e406                	sd	ra,8(sp)
    test_getcwd();
    10a2:	f63ff0ef          	jal	1004 <test_getcwd>
    return 0;
}
    10a6:	60a2                	ld	ra,8(sp)
    10a8:	4501                	li	a0,0
    10aa:	0141                	addi	sp,sp,16
    10ac:	8082                	ret

00000000000010ae <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10ae:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10b0:	4108                	lw	a0,0(a0)
{
    10b2:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10b4:	05a1                	addi	a1,a1,8
{
    10b6:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10b8:	fe7ff0ef          	jal	109e <main>
    10bc:	411000ef          	jal	1ccc <exit>
	return 0;
}
    10c0:	60a2                	ld	ra,8(sp)
    10c2:	4501                	li	a0,0
    10c4:	0141                	addi	sp,sp,16
    10c6:	8082                	ret

00000000000010c8 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10c8:	7179                	addi	sp,sp,-48
    10ca:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10cc:	12054b63          	bltz	a0,1202 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10d0:	02b577bb          	remuw	a5,a0,a1
    10d4:	00001617          	auipc	a2,0x1
    10d8:	ea460613          	addi	a2,a2,-348 # 1f78 <digits>
    buf[16] = 0;
    10dc:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10e0:	0005871b          	sext.w	a4,a1
    10e4:	1782                	slli	a5,a5,0x20
    10e6:	9381                	srli	a5,a5,0x20
    10e8:	97b2                	add	a5,a5,a2
    10ea:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10ee:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10f2:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10f6:	1cb56363          	bltu	a0,a1,12bc <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    10fa:	45b9                	li	a1,14
    10fc:	02e877bb          	remuw	a5,a6,a4
    1100:	1782                	slli	a5,a5,0x20
    1102:	9381                	srli	a5,a5,0x20
    1104:	97b2                	add	a5,a5,a2
    1106:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    110a:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    110e:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1112:	0ce86e63          	bltu	a6,a4,11ee <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1116:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    111a:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    111e:	1582                	slli	a1,a1,0x20
    1120:	9181                	srli	a1,a1,0x20
    1122:	95b2                	add	a1,a1,a2
    1124:	0005c583          	lbu	a1,0(a1)
    1128:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    112c:	0007859b          	sext.w	a1,a5
    1130:	12e6ec63          	bltu	a3,a4,1268 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1134:	02e7f6bb          	remuw	a3,a5,a4
    1138:	1682                	slli	a3,a3,0x20
    113a:	9281                	srli	a3,a3,0x20
    113c:	96b2                	add	a3,a3,a2
    113e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1142:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1146:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    114a:	12e5e863          	bltu	a1,a4,127a <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    114e:	02e876bb          	remuw	a3,a6,a4
    1152:	1682                	slli	a3,a3,0x20
    1154:	9281                	srli	a3,a3,0x20
    1156:	96b2                	add	a3,a3,a2
    1158:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    115c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1160:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1164:	12e86463          	bltu	a6,a4,128c <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1168:	02e5f6bb          	remuw	a3,a1,a4
    116c:	1682                	slli	a3,a3,0x20
    116e:	9281                	srli	a3,a3,0x20
    1170:	96b2                	add	a3,a3,a2
    1172:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1176:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    117a:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    117e:	0ce5ec63          	bltu	a1,a4,1256 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    1182:	02e876bb          	remuw	a3,a6,a4
    1186:	1682                	slli	a3,a3,0x20
    1188:	9281                	srli	a3,a3,0x20
    118a:	96b2                	add	a3,a3,a2
    118c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1190:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1194:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    1198:	10e86963          	bltu	a6,a4,12aa <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    119c:	02e5f6bb          	remuw	a3,a1,a4
    11a0:	1682                	slli	a3,a3,0x20
    11a2:	9281                	srli	a3,a3,0x20
    11a4:	96b2                	add	a3,a3,a2
    11a6:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11aa:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11ae:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11b2:	10e5e763          	bltu	a1,a4,12c0 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11b6:	02e876bb          	remuw	a3,a6,a4
    11ba:	1682                	slli	a3,a3,0x20
    11bc:	9281                	srli	a3,a3,0x20
    11be:	96b2                	add	a3,a3,a2
    11c0:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11c4:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11c8:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11cc:	10e86363          	bltu	a6,a4,12d2 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11d0:	1782                	slli	a5,a5,0x20
    11d2:	9381                	srli	a5,a5,0x20
    11d4:	97b2                	add	a5,a5,a2
    11d6:	0007c783          	lbu	a5,0(a5)
    11da:	4599                	li	a1,6
    11dc:	00f10723          	sb	a5,14(sp)

    if (sign)
    11e0:	00055763          	bgez	a0,11ee <printint.constprop.0+0x126>
        buf[i--] = '-';
    11e4:	02d00793          	li	a5,45
    11e8:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11ec:	4595                	li	a1,5
    write(f, s, l);
    11ee:	003c                	addi	a5,sp,8
    11f0:	4641                	li	a2,16
    11f2:	9e0d                	subw	a2,a2,a1
    11f4:	4505                	li	a0,1
    11f6:	95be                	add	a1,a1,a5
    11f8:	285000ef          	jal	1c7c <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11fc:	70a2                	ld	ra,40(sp)
    11fe:	6145                	addi	sp,sp,48
    1200:	8082                	ret
        x = -xx;
    1202:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1206:	02b877bb          	remuw	a5,a6,a1
    120a:	00001617          	auipc	a2,0x1
    120e:	d6e60613          	addi	a2,a2,-658 # 1f78 <digits>
    buf[16] = 0;
    1212:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1216:	0005871b          	sext.w	a4,a1
    121a:	1782                	slli	a5,a5,0x20
    121c:	9381                	srli	a5,a5,0x20
    121e:	97b2                	add	a5,a5,a2
    1220:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1224:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1228:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    122c:	06b86963          	bltu	a6,a1,129e <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1230:	02e8f7bb          	remuw	a5,a7,a4
    1234:	1782                	slli	a5,a5,0x20
    1236:	9381                	srli	a5,a5,0x20
    1238:	97b2                	add	a5,a5,a2
    123a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    123e:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1242:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1246:	ece8f8e3          	bgeu	a7,a4,1116 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    124a:	02d00793          	li	a5,45
    124e:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1252:	45b5                	li	a1,13
    1254:	bf69                	j	11ee <printint.constprop.0+0x126>
    1256:	45a9                	li	a1,10
    if (sign)
    1258:	f8055be3          	bgez	a0,11ee <printint.constprop.0+0x126>
        buf[i--] = '-';
    125c:	02d00793          	li	a5,45
    1260:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1264:	45a5                	li	a1,9
    1266:	b761                	j	11ee <printint.constprop.0+0x126>
    1268:	45b5                	li	a1,13
    if (sign)
    126a:	f80552e3          	bgez	a0,11ee <printint.constprop.0+0x126>
        buf[i--] = '-';
    126e:	02d00793          	li	a5,45
    1272:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1276:	45b1                	li	a1,12
    1278:	bf9d                	j	11ee <printint.constprop.0+0x126>
    127a:	45b1                	li	a1,12
    if (sign)
    127c:	f60559e3          	bgez	a0,11ee <printint.constprop.0+0x126>
        buf[i--] = '-';
    1280:	02d00793          	li	a5,45
    1284:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    1288:	45ad                	li	a1,11
    128a:	b795                	j	11ee <printint.constprop.0+0x126>
    128c:	45ad                	li	a1,11
    if (sign)
    128e:	f60550e3          	bgez	a0,11ee <printint.constprop.0+0x126>
        buf[i--] = '-';
    1292:	02d00793          	li	a5,45
    1296:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    129a:	45a9                	li	a1,10
    129c:	bf89                	j	11ee <printint.constprop.0+0x126>
        buf[i--] = '-';
    129e:	02d00793          	li	a5,45
    12a2:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12a6:	45b9                	li	a1,14
    12a8:	b799                	j	11ee <printint.constprop.0+0x126>
    12aa:	45a5                	li	a1,9
    if (sign)
    12ac:	f40551e3          	bgez	a0,11ee <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b0:	02d00793          	li	a5,45
    12b4:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12b8:	45a1                	li	a1,8
    12ba:	bf15                	j	11ee <printint.constprop.0+0x126>
    i = 15;
    12bc:	45bd                	li	a1,15
    12be:	bf05                	j	11ee <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12c0:	45a1                	li	a1,8
    if (sign)
    12c2:	f20556e3          	bgez	a0,11ee <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c6:	02d00793          	li	a5,45
    12ca:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12ce:	459d                	li	a1,7
    12d0:	bf39                	j	11ee <printint.constprop.0+0x126>
    12d2:	459d                	li	a1,7
    if (sign)
    12d4:	f0055de3          	bgez	a0,11ee <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d8:	02d00793          	li	a5,45
    12dc:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12e0:	4599                	li	a1,6
    12e2:	b731                	j	11ee <printint.constprop.0+0x126>

00000000000012e4 <getchar>:
{
    12e4:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12e6:	00f10593          	addi	a1,sp,15
    12ea:	4605                	li	a2,1
    12ec:	4501                	li	a0,0
{
    12ee:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12f0:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12f4:	17f000ef          	jal	1c72 <read>
}
    12f8:	60e2                	ld	ra,24(sp)
    12fa:	00f14503          	lbu	a0,15(sp)
    12fe:	6105                	addi	sp,sp,32
    1300:	8082                	ret

0000000000001302 <putchar>:
{
    1302:	1101                	addi	sp,sp,-32
    1304:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1306:	00f10593          	addi	a1,sp,15
    130a:	4605                	li	a2,1
    130c:	4505                	li	a0,1
{
    130e:	ec06                	sd	ra,24(sp)
    char byte = c;
    1310:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1314:	169000ef          	jal	1c7c <write>
}
    1318:	60e2                	ld	ra,24(sp)
    131a:	2501                	sext.w	a0,a0
    131c:	6105                	addi	sp,sp,32
    131e:	8082                	ret

0000000000001320 <puts>:
{
    1320:	1141                	addi	sp,sp,-16
    1322:	e406                	sd	ra,8(sp)
    1324:	e022                	sd	s0,0(sp)
    1326:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1328:	570000ef          	jal	1898 <strlen>
    132c:	862a                	mv	a2,a0
    132e:	85a2                	mv	a1,s0
    1330:	4505                	li	a0,1
    1332:	14b000ef          	jal	1c7c <write>
}
    1336:	60a2                	ld	ra,8(sp)
    1338:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    133a:	957d                	srai	a0,a0,0x3f
    return r;
    133c:	2501                	sext.w	a0,a0
}
    133e:	0141                	addi	sp,sp,16
    1340:	8082                	ret

0000000000001342 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1342:	7131                	addi	sp,sp,-192
    1344:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1346:	013c                	addi	a5,sp,136
{
    1348:	f0ca                	sd	s2,96(sp)
    134a:	ecce                	sd	s3,88(sp)
    134c:	e8d2                	sd	s4,80(sp)
    134e:	e4d6                	sd	s5,72(sp)
    1350:	e0da                	sd	s6,64(sp)
    1352:	fc5e                	sd	s7,56(sp)
    1354:	fc86                	sd	ra,120(sp)
    1356:	f8a2                	sd	s0,112(sp)
    1358:	f4a6                	sd	s1,104(sp)
    135a:	e52e                	sd	a1,136(sp)
    135c:	e932                	sd	a2,144(sp)
    135e:	ed36                	sd	a3,152(sp)
    1360:	f13a                	sd	a4,160(sp)
    1362:	f942                	sd	a6,176(sp)
    1364:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1366:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1368:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    136c:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1370:	00001b97          	auipc	s7,0x1
    1374:	bd8b8b93          	addi	s7,s7,-1064 # 1f48 <__clone+0x94>
        switch (s[1])
    1378:	07800a93          	li	s5,120
    137c:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1380:	00001997          	auipc	s3,0x1
    1384:	bf898993          	addi	s3,s3,-1032 # 1f78 <digits>
        if (!*s)
    1388:	00054783          	lbu	a5,0(a0)
    138c:	16078c63          	beqz	a5,1504 <printf+0x1c2>
    1390:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1392:	19278463          	beq	a5,s2,151a <printf+0x1d8>
    1396:	00164783          	lbu	a5,1(a2)
    139a:	0605                	addi	a2,a2,1
    139c:	fbfd                	bnez	a5,1392 <printf+0x50>
    139e:	84b2                	mv	s1,a2
        l = z - a;
    13a0:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13a4:	85aa                	mv	a1,a0
    13a6:	8622                	mv	a2,s0
    13a8:	4505                	li	a0,1
    13aa:	0d3000ef          	jal	1c7c <write>
        if (l)
    13ae:	18041f63          	bnez	s0,154c <printf+0x20a>
        if (s[1] == 0)
    13b2:	0014c783          	lbu	a5,1(s1)
    13b6:	14078763          	beqz	a5,1504 <printf+0x1c2>
        switch (s[1])
    13ba:	1d478163          	beq	a5,s4,157c <printf+0x23a>
    13be:	18fa6963          	bltu	s4,a5,1550 <printf+0x20e>
    13c2:	1b678363          	beq	a5,s6,1568 <printf+0x226>
    13c6:	07000713          	li	a4,112
    13ca:	1ce79c63          	bne	a5,a4,15a2 <printf+0x260>
            printptr(va_arg(ap, uint64));
    13ce:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13d0:	03000793          	li	a5,48
    13d4:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13d8:	631c                	ld	a5,0(a4)
    13da:	0721                	addi	a4,a4,8
    13dc:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13de:	00479f93          	slli	t6,a5,0x4
    13e2:	00879f13          	slli	t5,a5,0x8
    13e6:	00c79e93          	slli	t4,a5,0xc
    13ea:	01079e13          	slli	t3,a5,0x10
    13ee:	01479313          	slli	t1,a5,0x14
    13f2:	01879893          	slli	a7,a5,0x18
    13f6:	01c79713          	slli	a4,a5,0x1c
    13fa:	02479813          	slli	a6,a5,0x24
    13fe:	02879513          	slli	a0,a5,0x28
    1402:	02c79593          	slli	a1,a5,0x2c
    1406:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    140a:	03c7d293          	srli	t0,a5,0x3c
    140e:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1412:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1416:	03cfdf93          	srli	t6,t6,0x3c
    141a:	03cf5f13          	srli	t5,t5,0x3c
    141e:	03cede93          	srli	t4,t4,0x3c
    1422:	03ce5e13          	srli	t3,t3,0x3c
    1426:	03c35313          	srli	t1,t1,0x3c
    142a:	03c8d893          	srli	a7,a7,0x3c
    142e:	9371                	srli	a4,a4,0x3c
    1430:	03c85813          	srli	a6,a6,0x3c
    1434:	9171                	srli	a0,a0,0x3c
    1436:	91f1                	srli	a1,a1,0x3c
    1438:	9271                	srli	a2,a2,0x3c
    143a:	974e                	add	a4,a4,s3
    143c:	92f1                	srli	a3,a3,0x3c
    143e:	92ce                	add	t0,t0,s3
    1440:	9fce                	add	t6,t6,s3
    1442:	9f4e                	add	t5,t5,s3
    1444:	9ece                	add	t4,t4,s3
    1446:	9e4e                	add	t3,t3,s3
    1448:	934e                	add	t1,t1,s3
    144a:	98ce                	add	a7,a7,s3
    144c:	93ce                	add	t2,t2,s3
    144e:	984e                	add	a6,a6,s3
    1450:	954e                	add	a0,a0,s3
    1452:	95ce                	add	a1,a1,s3
    1454:	964e                	add	a2,a2,s3
    1456:	0002c283          	lbu	t0,0(t0)
    145a:	000fcf83          	lbu	t6,0(t6)
    145e:	000f4f03          	lbu	t5,0(t5)
    1462:	000ece83          	lbu	t4,0(t4)
    1466:	000e4e03          	lbu	t3,0(t3)
    146a:	00034303          	lbu	t1,0(t1)
    146e:	0008c883          	lbu	a7,0(a7)
    1472:	00074403          	lbu	s0,0(a4)
    1476:	0003c383          	lbu	t2,0(t2)
    147a:	00084803          	lbu	a6,0(a6)
    147e:	00054503          	lbu	a0,0(a0)
    1482:	0005c583          	lbu	a1,0(a1)
    1486:	00064603          	lbu	a2,0(a2)
    148a:	00d98733          	add	a4,s3,a3
    148e:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1492:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1496:	9371                	srli	a4,a4,0x3c
    1498:	8bbd                	andi	a5,a5,15
    149a:	00510523          	sb	t0,10(sp)
    149e:	01f105a3          	sb	t6,11(sp)
    14a2:	01e10623          	sb	t5,12(sp)
    14a6:	01d106a3          	sb	t4,13(sp)
    14aa:	01c10723          	sb	t3,14(sp)
    14ae:	006107a3          	sb	t1,15(sp)
    14b2:	01110823          	sb	a7,16(sp)
    14b6:	00710923          	sb	t2,18(sp)
    14ba:	010109a3          	sb	a6,19(sp)
    14be:	00a10a23          	sb	a0,20(sp)
    14c2:	00b10aa3          	sb	a1,21(sp)
    14c6:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14ca:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14ce:	008108a3          	sb	s0,17(sp)
    14d2:	974e                	add	a4,a4,s3
    14d4:	97ce                	add	a5,a5,s3
    14d6:	00d10ba3          	sb	a3,23(sp)
    14da:	00074703          	lbu	a4,0(a4)
    14de:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14e2:	4649                	li	a2,18
    14e4:	002c                	addi	a1,sp,8
    14e6:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14e8:	00e10c23          	sb	a4,24(sp)
    14ec:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14f0:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14f4:	788000ef          	jal	1c7c <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14f8:	00248513          	addi	a0,s1,2
        if (!*s)
    14fc:	00054783          	lbu	a5,0(a0)
    1500:	e80798e3          	bnez	a5,1390 <printf+0x4e>
    }
    va_end(ap);
}
    1504:	70e6                	ld	ra,120(sp)
    1506:	7446                	ld	s0,112(sp)
    1508:	74a6                	ld	s1,104(sp)
    150a:	7906                	ld	s2,96(sp)
    150c:	69e6                	ld	s3,88(sp)
    150e:	6a46                	ld	s4,80(sp)
    1510:	6aa6                	ld	s5,72(sp)
    1512:	6b06                	ld	s6,64(sp)
    1514:	7be2                	ld	s7,56(sp)
    1516:	6129                	addi	sp,sp,192
    1518:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    151a:	00064783          	lbu	a5,0(a2)
    151e:	84b2                	mv	s1,a2
    1520:	01278963          	beq	a5,s2,1532 <printf+0x1f0>
    1524:	bdb5                	j	13a0 <printf+0x5e>
    1526:	0024c783          	lbu	a5,2(s1)
    152a:	0605                	addi	a2,a2,1
    152c:	0489                	addi	s1,s1,2
    152e:	e72799e3          	bne	a5,s2,13a0 <printf+0x5e>
    1532:	0014c783          	lbu	a5,1(s1)
    1536:	ff2788e3          	beq	a5,s2,1526 <printf+0x1e4>
        l = z - a;
    153a:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    153e:	85aa                	mv	a1,a0
    1540:	8622                	mv	a2,s0
    1542:	4505                	li	a0,1
    1544:	738000ef          	jal	1c7c <write>
        if (l)
    1548:	e60405e3          	beqz	s0,13b2 <printf+0x70>
    154c:	8526                	mv	a0,s1
    154e:	bd2d                	j	1388 <printf+0x46>
        switch (s[1])
    1550:	05579963          	bne	a5,s5,15a2 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1554:	6782                	ld	a5,0(sp)
    1556:	45c1                	li	a1,16
    1558:	4388                	lw	a0,0(a5)
    155a:	07a1                	addi	a5,a5,8
    155c:	e03e                	sd	a5,0(sp)
    155e:	b6bff0ef          	jal	10c8 <printint.constprop.0>
        s += 2;
    1562:	00248513          	addi	a0,s1,2
    1566:	bf59                	j	14fc <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1568:	6782                	ld	a5,0(sp)
    156a:	45a9                	li	a1,10
    156c:	4388                	lw	a0,0(a5)
    156e:	07a1                	addi	a5,a5,8
    1570:	e03e                	sd	a5,0(sp)
    1572:	b57ff0ef          	jal	10c8 <printint.constprop.0>
        s += 2;
    1576:	00248513          	addi	a0,s1,2
    157a:	b749                	j	14fc <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    157c:	6782                	ld	a5,0(sp)
    157e:	6380                	ld	s0,0(a5)
    1580:	07a1                	addi	a5,a5,8
    1582:	e03e                	sd	a5,0(sp)
    1584:	c031                	beqz	s0,15c8 <printf+0x286>
            l = strnlen(a, 200);
    1586:	0c800593          	li	a1,200
    158a:	8522                	mv	a0,s0
    158c:	3f8000ef          	jal	1984 <strnlen>
    write(f, s, l);
    1590:	0005061b          	sext.w	a2,a0
    1594:	85a2                	mv	a1,s0
    1596:	4505                	li	a0,1
    1598:	6e4000ef          	jal	1c7c <write>
        s += 2;
    159c:	00248513          	addi	a0,s1,2
    15a0:	bfb1                	j	14fc <printf+0x1ba>
    return write(stdout, &byte, 1);
    15a2:	4605                	li	a2,1
    15a4:	002c                	addi	a1,sp,8
    15a6:	4505                	li	a0,1
    char byte = c;
    15a8:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15ac:	6d0000ef          	jal	1c7c <write>
    char byte = c;
    15b0:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15b4:	4605                	li	a2,1
    15b6:	002c                	addi	a1,sp,8
    15b8:	4505                	li	a0,1
    char byte = c;
    15ba:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15be:	6be000ef          	jal	1c7c <write>
        s += 2;
    15c2:	00248513          	addi	a0,s1,2
    15c6:	bf1d                	j	14fc <printf+0x1ba>
                a = "(null)";
    15c8:	845e                	mv	s0,s7
    15ca:	bf75                	j	1586 <printf+0x244>

00000000000015cc <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15cc:	02000793          	li	a5,32
    15d0:	00f50663          	beq	a0,a5,15dc <isspace+0x10>
    15d4:	355d                	addiw	a0,a0,-9
    15d6:	00553513          	sltiu	a0,a0,5
    15da:	8082                	ret
    15dc:	4505                	li	a0,1
}
    15de:	8082                	ret

00000000000015e0 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15e0:	fd05051b          	addiw	a0,a0,-48
}
    15e4:	00a53513          	sltiu	a0,a0,10
    15e8:	8082                	ret

00000000000015ea <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15ea:	02000613          	li	a2,32
    15ee:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15f0:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15f4:	ff77069b          	addiw	a3,a4,-9
    15f8:	04c70d63          	beq	a4,a2,1652 <atoi+0x68>
    15fc:	0007079b          	sext.w	a5,a4
    1600:	04d5f963          	bgeu	a1,a3,1652 <atoi+0x68>
        s++;
    switch (*s)
    1604:	02b00693          	li	a3,43
    1608:	04d70a63          	beq	a4,a3,165c <atoi+0x72>
    160c:	02d00693          	li	a3,45
    1610:	06d70463          	beq	a4,a3,1678 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1614:	fd07859b          	addiw	a1,a5,-48
    1618:	4625                	li	a2,9
    161a:	873e                	mv	a4,a5
    161c:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    161e:	4e01                	li	t3,0
    while (isdigit(*s))
    1620:	04b66a63          	bltu	a2,a1,1674 <atoi+0x8a>
    int n = 0, neg = 0;
    1624:	4501                	li	a0,0
    while (isdigit(*s))
    1626:	4825                	li	a6,9
    1628:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    162c:	0025179b          	slliw	a5,a0,0x2
    1630:	9d3d                	addw	a0,a0,a5
    1632:	fd07031b          	addiw	t1,a4,-48
    1636:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    163a:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    163e:	0685                	addi	a3,a3,1
    1640:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1644:	0006071b          	sext.w	a4,a2
    1648:	feb870e3          	bgeu	a6,a1,1628 <atoi+0x3e>
    return neg ? n : -n;
    164c:	000e0563          	beqz	t3,1656 <atoi+0x6c>
}
    1650:	8082                	ret
        s++;
    1652:	0505                	addi	a0,a0,1
    1654:	bf71                	j	15f0 <atoi+0x6>
    return neg ? n : -n;
    1656:	4113053b          	subw	a0,t1,a7
    165a:	8082                	ret
    while (isdigit(*s))
    165c:	00154783          	lbu	a5,1(a0)
    1660:	4625                	li	a2,9
        s++;
    1662:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1666:	fd07859b          	addiw	a1,a5,-48
    166a:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    166e:	4e01                	li	t3,0
    while (isdigit(*s))
    1670:	fab67ae3          	bgeu	a2,a1,1624 <atoi+0x3a>
    1674:	4501                	li	a0,0
}
    1676:	8082                	ret
    while (isdigit(*s))
    1678:	00154783          	lbu	a5,1(a0)
    167c:	4625                	li	a2,9
        s++;
    167e:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1682:	fd07859b          	addiw	a1,a5,-48
    1686:	0007871b          	sext.w	a4,a5
    168a:	feb665e3          	bltu	a2,a1,1674 <atoi+0x8a>
        neg = 1;
    168e:	4e05                	li	t3,1
    1690:	bf51                	j	1624 <atoi+0x3a>

0000000000001692 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1692:	16060d63          	beqz	a2,180c <memset+0x17a>
    1696:	40a007b3          	neg	a5,a0
    169a:	8b9d                	andi	a5,a5,7
    169c:	00778713          	addi	a4,a5,7
    16a0:	482d                	li	a6,11
    16a2:	0ff5f593          	zext.b	a1,a1
    16a6:	fff60693          	addi	a3,a2,-1
    16aa:	17076263          	bltu	a4,a6,180e <memset+0x17c>
    16ae:	16e6ea63          	bltu	a3,a4,1822 <memset+0x190>
    16b2:	16078563          	beqz	a5,181c <memset+0x18a>
    16b6:	00b50023          	sb	a1,0(a0)
    16ba:	4705                	li	a4,1
    16bc:	00150e93          	addi	t4,a0,1
    16c0:	14e78c63          	beq	a5,a4,1818 <memset+0x186>
    16c4:	00b500a3          	sb	a1,1(a0)
    16c8:	4709                	li	a4,2
    16ca:	00250e93          	addi	t4,a0,2
    16ce:	14e78d63          	beq	a5,a4,1828 <memset+0x196>
    16d2:	00b50123          	sb	a1,2(a0)
    16d6:	470d                	li	a4,3
    16d8:	00350e93          	addi	t4,a0,3
    16dc:	12e78b63          	beq	a5,a4,1812 <memset+0x180>
    16e0:	00b501a3          	sb	a1,3(a0)
    16e4:	4711                	li	a4,4
    16e6:	00450e93          	addi	t4,a0,4
    16ea:	14e78163          	beq	a5,a4,182c <memset+0x19a>
    16ee:	00b50223          	sb	a1,4(a0)
    16f2:	4715                	li	a4,5
    16f4:	00550e93          	addi	t4,a0,5
    16f8:	12e78c63          	beq	a5,a4,1830 <memset+0x19e>
    16fc:	00b502a3          	sb	a1,5(a0)
    1700:	471d                	li	a4,7
    1702:	00650e93          	addi	t4,a0,6
    1706:	12e79763          	bne	a5,a4,1834 <memset+0x1a2>
    170a:	00750e93          	addi	t4,a0,7
    170e:	00b50323          	sb	a1,6(a0)
    1712:	4f1d                	li	t5,7
    1714:	00859713          	slli	a4,a1,0x8
    1718:	8f4d                	or	a4,a4,a1
    171a:	01059e13          	slli	t3,a1,0x10
    171e:	01c76e33          	or	t3,a4,t3
    1722:	01859313          	slli	t1,a1,0x18
    1726:	006e6333          	or	t1,t3,t1
    172a:	02059893          	slli	a7,a1,0x20
    172e:	011368b3          	or	a7,t1,a7
    1732:	02859813          	slli	a6,a1,0x28
    1736:	40f60333          	sub	t1,a2,a5
    173a:	0108e833          	or	a6,a7,a6
    173e:	03059693          	slli	a3,a1,0x30
    1742:	00d866b3          	or	a3,a6,a3
    1746:	03859713          	slli	a4,a1,0x38
    174a:	97aa                	add	a5,a5,a0
    174c:	ff837813          	andi	a6,t1,-8
    1750:	8f55                	or	a4,a4,a3
    1752:	00f806b3          	add	a3,a6,a5
    1756:	e398                	sd	a4,0(a5)
    1758:	07a1                	addi	a5,a5,8
    175a:	fed79ee3          	bne	a5,a3,1756 <memset+0xc4>
    175e:	ff837693          	andi	a3,t1,-8
    1762:	00de87b3          	add	a5,t4,a3
    1766:	01e6873b          	addw	a4,a3,t5
    176a:	0ad30663          	beq	t1,a3,1816 <memset+0x184>
    176e:	00b78023          	sb	a1,0(a5)
    1772:	0017069b          	addiw	a3,a4,1
    1776:	08c6fb63          	bgeu	a3,a2,180c <memset+0x17a>
    177a:	00b780a3          	sb	a1,1(a5)
    177e:	0027069b          	addiw	a3,a4,2
    1782:	08c6f563          	bgeu	a3,a2,180c <memset+0x17a>
    1786:	00b78123          	sb	a1,2(a5)
    178a:	0037069b          	addiw	a3,a4,3
    178e:	06c6ff63          	bgeu	a3,a2,180c <memset+0x17a>
    1792:	00b781a3          	sb	a1,3(a5)
    1796:	0047069b          	addiw	a3,a4,4
    179a:	06c6f963          	bgeu	a3,a2,180c <memset+0x17a>
    179e:	00b78223          	sb	a1,4(a5)
    17a2:	0057069b          	addiw	a3,a4,5
    17a6:	06c6f363          	bgeu	a3,a2,180c <memset+0x17a>
    17aa:	00b782a3          	sb	a1,5(a5)
    17ae:	0067069b          	addiw	a3,a4,6
    17b2:	04c6fd63          	bgeu	a3,a2,180c <memset+0x17a>
    17b6:	00b78323          	sb	a1,6(a5)
    17ba:	0077069b          	addiw	a3,a4,7
    17be:	04c6f763          	bgeu	a3,a2,180c <memset+0x17a>
    17c2:	00b783a3          	sb	a1,7(a5)
    17c6:	0087069b          	addiw	a3,a4,8
    17ca:	04c6f163          	bgeu	a3,a2,180c <memset+0x17a>
    17ce:	00b78423          	sb	a1,8(a5)
    17d2:	0097069b          	addiw	a3,a4,9
    17d6:	02c6fb63          	bgeu	a3,a2,180c <memset+0x17a>
    17da:	00b784a3          	sb	a1,9(a5)
    17de:	00a7069b          	addiw	a3,a4,10
    17e2:	02c6f563          	bgeu	a3,a2,180c <memset+0x17a>
    17e6:	00b78523          	sb	a1,10(a5)
    17ea:	00b7069b          	addiw	a3,a4,11
    17ee:	00c6ff63          	bgeu	a3,a2,180c <memset+0x17a>
    17f2:	00b785a3          	sb	a1,11(a5)
    17f6:	00c7069b          	addiw	a3,a4,12
    17fa:	00c6f963          	bgeu	a3,a2,180c <memset+0x17a>
    17fe:	00b78623          	sb	a1,12(a5)
    1802:	2735                	addiw	a4,a4,13
    1804:	00c77463          	bgeu	a4,a2,180c <memset+0x17a>
    1808:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    180c:	8082                	ret
    180e:	472d                	li	a4,11
    1810:	bd79                	j	16ae <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1812:	4f0d                	li	t5,3
    1814:	b701                	j	1714 <memset+0x82>
    1816:	8082                	ret
    1818:	4f05                	li	t5,1
    181a:	bded                	j	1714 <memset+0x82>
    181c:	8eaa                	mv	t4,a0
    181e:	4f01                	li	t5,0
    1820:	bdd5                	j	1714 <memset+0x82>
    1822:	87aa                	mv	a5,a0
    1824:	4701                	li	a4,0
    1826:	b7a1                	j	176e <memset+0xdc>
    1828:	4f09                	li	t5,2
    182a:	b5ed                	j	1714 <memset+0x82>
    182c:	4f11                	li	t5,4
    182e:	b5dd                	j	1714 <memset+0x82>
    1830:	4f15                	li	t5,5
    1832:	b5cd                	j	1714 <memset+0x82>
    1834:	4f19                	li	t5,6
    1836:	bdf9                	j	1714 <memset+0x82>

0000000000001838 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1838:	00054783          	lbu	a5,0(a0)
    183c:	0005c703          	lbu	a4,0(a1)
    1840:	00e79863          	bne	a5,a4,1850 <strcmp+0x18>
    1844:	0505                	addi	a0,a0,1
    1846:	0585                	addi	a1,a1,1
    1848:	fbe5                	bnez	a5,1838 <strcmp>
    184a:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    184c:	9d19                	subw	a0,a0,a4
    184e:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1850:	0007851b          	sext.w	a0,a5
    1854:	bfe5                	j	184c <strcmp+0x14>

0000000000001856 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    1856:	ce05                	beqz	a2,188e <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1858:	00054703          	lbu	a4,0(a0)
    185c:	0005c783          	lbu	a5,0(a1)
    1860:	cb0d                	beqz	a4,1892 <strncmp+0x3c>
    if (!n--)
    1862:	167d                	addi	a2,a2,-1
    1864:	00c506b3          	add	a3,a0,a2
    1868:	a819                	j	187e <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    186a:	00a68e63          	beq	a3,a0,1886 <strncmp+0x30>
    186e:	0505                	addi	a0,a0,1
    1870:	00e79b63          	bne	a5,a4,1886 <strncmp+0x30>
    1874:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    1878:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    187c:	cb19                	beqz	a4,1892 <strncmp+0x3c>
    187e:	0005c783          	lbu	a5,0(a1)
    1882:	0585                	addi	a1,a1,1
    1884:	f3fd                	bnez	a5,186a <strncmp+0x14>
    return *l - *r;
    1886:	0007051b          	sext.w	a0,a4
    188a:	9d1d                	subw	a0,a0,a5
    188c:	8082                	ret
        return 0;
    188e:	4501                	li	a0,0
}
    1890:	8082                	ret
    1892:	4501                	li	a0,0
    return *l - *r;
    1894:	9d1d                	subw	a0,a0,a5
    1896:	8082                	ret

0000000000001898 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    1898:	00757793          	andi	a5,a0,7
    189c:	cf89                	beqz	a5,18b6 <strlen+0x1e>
    189e:	87aa                	mv	a5,a0
    18a0:	a029                	j	18aa <strlen+0x12>
    18a2:	0785                	addi	a5,a5,1
    18a4:	0077f713          	andi	a4,a5,7
    18a8:	cb01                	beqz	a4,18b8 <strlen+0x20>
        if (!*s)
    18aa:	0007c703          	lbu	a4,0(a5)
    18ae:	fb75                	bnez	a4,18a2 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18b0:	40a78533          	sub	a0,a5,a0
}
    18b4:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18b6:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18b8:	6394                	ld	a3,0(a5)
    18ba:	00000597          	auipc	a1,0x0
    18be:	6965b583          	ld	a1,1686(a1) # 1f50 <__clone+0x9c>
    18c2:	00000617          	auipc	a2,0x0
    18c6:	69663603          	ld	a2,1686(a2) # 1f58 <__clone+0xa4>
    18ca:	a019                	j	18d0 <strlen+0x38>
    18cc:	6794                	ld	a3,8(a5)
    18ce:	07a1                	addi	a5,a5,8
    18d0:	00b68733          	add	a4,a3,a1
    18d4:	fff6c693          	not	a3,a3
    18d8:	8f75                	and	a4,a4,a3
    18da:	8f71                	and	a4,a4,a2
    18dc:	db65                	beqz	a4,18cc <strlen+0x34>
    for (; *s; s++)
    18de:	0007c703          	lbu	a4,0(a5)
    18e2:	d779                	beqz	a4,18b0 <strlen+0x18>
    18e4:	0017c703          	lbu	a4,1(a5)
    18e8:	0785                	addi	a5,a5,1
    18ea:	d379                	beqz	a4,18b0 <strlen+0x18>
    18ec:	0017c703          	lbu	a4,1(a5)
    18f0:	0785                	addi	a5,a5,1
    18f2:	fb6d                	bnez	a4,18e4 <strlen+0x4c>
    18f4:	bf75                	j	18b0 <strlen+0x18>

00000000000018f6 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18f6:	00757713          	andi	a4,a0,7
{
    18fa:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18fc:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1900:	cb19                	beqz	a4,1916 <memchr+0x20>
    1902:	ce25                	beqz	a2,197a <memchr+0x84>
    1904:	0007c703          	lbu	a4,0(a5)
    1908:	04b70e63          	beq	a4,a1,1964 <memchr+0x6e>
    190c:	0785                	addi	a5,a5,1
    190e:	0077f713          	andi	a4,a5,7
    1912:	167d                	addi	a2,a2,-1
    1914:	f77d                	bnez	a4,1902 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1916:	4501                	li	a0,0
    if (n && *s != c)
    1918:	c235                	beqz	a2,197c <memchr+0x86>
    191a:	0007c703          	lbu	a4,0(a5)
    191e:	04b70363          	beq	a4,a1,1964 <memchr+0x6e>
        size_t k = ONES * c;
    1922:	00000517          	auipc	a0,0x0
    1926:	63e53503          	ld	a0,1598(a0) # 1f60 <__clone+0xac>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    192a:	471d                	li	a4,7
        size_t k = ONES * c;
    192c:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1930:	02c77a63          	bgeu	a4,a2,1964 <memchr+0x6e>
    1934:	00000897          	auipc	a7,0x0
    1938:	61c8b883          	ld	a7,1564(a7) # 1f50 <__clone+0x9c>
    193c:	00000817          	auipc	a6,0x0
    1940:	61c83803          	ld	a6,1564(a6) # 1f58 <__clone+0xa4>
    1944:	431d                	li	t1,7
    1946:	a029                	j	1950 <memchr+0x5a>
    1948:	1661                	addi	a2,a2,-8
    194a:	07a1                	addi	a5,a5,8
    194c:	02c37963          	bgeu	t1,a2,197e <memchr+0x88>
    1950:	6398                	ld	a4,0(a5)
    1952:	8f29                	xor	a4,a4,a0
    1954:	011706b3          	add	a3,a4,a7
    1958:	fff74713          	not	a4,a4
    195c:	8f75                	and	a4,a4,a3
    195e:	01077733          	and	a4,a4,a6
    1962:	d37d                	beqz	a4,1948 <memchr+0x52>
    1964:	853e                	mv	a0,a5
    1966:	97b2                	add	a5,a5,a2
    1968:	a021                	j	1970 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    196a:	0505                	addi	a0,a0,1
    196c:	00f50763          	beq	a0,a5,197a <memchr+0x84>
    1970:	00054703          	lbu	a4,0(a0)
    1974:	feb71be3          	bne	a4,a1,196a <memchr+0x74>
    1978:	8082                	ret
    return n ? (void *)s : 0;
    197a:	4501                	li	a0,0
}
    197c:	8082                	ret
    return n ? (void *)s : 0;
    197e:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1980:	f275                	bnez	a2,1964 <memchr+0x6e>
}
    1982:	8082                	ret

0000000000001984 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1984:	1101                	addi	sp,sp,-32
    1986:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1988:	862e                	mv	a2,a1
{
    198a:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    198c:	4581                	li	a1,0
{
    198e:	e426                	sd	s1,8(sp)
    1990:	ec06                	sd	ra,24(sp)
    1992:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1994:	f63ff0ef          	jal	18f6 <memchr>
    return p ? p - s : n;
    1998:	c519                	beqz	a0,19a6 <strnlen+0x22>
}
    199a:	60e2                	ld	ra,24(sp)
    199c:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    199e:	8d05                	sub	a0,a0,s1
}
    19a0:	64a2                	ld	s1,8(sp)
    19a2:	6105                	addi	sp,sp,32
    19a4:	8082                	ret
    19a6:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19a8:	8522                	mv	a0,s0
}
    19aa:	6442                	ld	s0,16(sp)
    19ac:	64a2                	ld	s1,8(sp)
    19ae:	6105                	addi	sp,sp,32
    19b0:	8082                	ret

00000000000019b2 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19b2:	00b547b3          	xor	a5,a0,a1
    19b6:	8b9d                	andi	a5,a5,7
    19b8:	eb95                	bnez	a5,19ec <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19ba:	0075f793          	andi	a5,a1,7
    19be:	e7b1                	bnez	a5,1a0a <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19c0:	6198                	ld	a4,0(a1)
    19c2:	00000617          	auipc	a2,0x0
    19c6:	58e63603          	ld	a2,1422(a2) # 1f50 <__clone+0x9c>
    19ca:	00000817          	auipc	a6,0x0
    19ce:	58e83803          	ld	a6,1422(a6) # 1f58 <__clone+0xa4>
    19d2:	a029                	j	19dc <strcpy+0x2a>
    19d4:	e118                	sd	a4,0(a0)
    19d6:	6598                	ld	a4,8(a1)
    19d8:	05a1                	addi	a1,a1,8
    19da:	0521                	addi	a0,a0,8
    19dc:	00c707b3          	add	a5,a4,a2
    19e0:	fff74693          	not	a3,a4
    19e4:	8ff5                	and	a5,a5,a3
    19e6:	0107f7b3          	and	a5,a5,a6
    19ea:	d7ed                	beqz	a5,19d4 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    19ec:	0005c783          	lbu	a5,0(a1)
    19f0:	00f50023          	sb	a5,0(a0)
    19f4:	c785                	beqz	a5,1a1c <strcpy+0x6a>
    19f6:	0015c783          	lbu	a5,1(a1)
    19fa:	0505                	addi	a0,a0,1
    19fc:	0585                	addi	a1,a1,1
    19fe:	00f50023          	sb	a5,0(a0)
    1a02:	fbf5                	bnez	a5,19f6 <strcpy+0x44>
        ;
    return d;
}
    1a04:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a06:	0505                	addi	a0,a0,1
    1a08:	df45                	beqz	a4,19c0 <strcpy+0xe>
            if (!(*d = *s))
    1a0a:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a0e:	0585                	addi	a1,a1,1
    1a10:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a14:	00f50023          	sb	a5,0(a0)
    1a18:	f7fd                	bnez	a5,1a06 <strcpy+0x54>
}
    1a1a:	8082                	ret
    1a1c:	8082                	ret

0000000000001a1e <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a1e:	00b547b3          	xor	a5,a0,a1
    1a22:	8b9d                	andi	a5,a5,7
    1a24:	1a079863          	bnez	a5,1bd4 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a28:	0075f793          	andi	a5,a1,7
    1a2c:	16078463          	beqz	a5,1b94 <strncpy+0x176>
    1a30:	ea01                	bnez	a2,1a40 <strncpy+0x22>
    1a32:	a421                	j	1c3a <strncpy+0x21c>
    1a34:	167d                	addi	a2,a2,-1
    1a36:	0505                	addi	a0,a0,1
    1a38:	14070e63          	beqz	a4,1b94 <strncpy+0x176>
    1a3c:	1a060863          	beqz	a2,1bec <strncpy+0x1ce>
    1a40:	0005c783          	lbu	a5,0(a1)
    1a44:	0585                	addi	a1,a1,1
    1a46:	0075f713          	andi	a4,a1,7
    1a4a:	00f50023          	sb	a5,0(a0)
    1a4e:	f3fd                	bnez	a5,1a34 <strncpy+0x16>
    1a50:	4805                	li	a6,1
    1a52:	1a061863          	bnez	a2,1c02 <strncpy+0x1e4>
    1a56:	40a007b3          	neg	a5,a0
    1a5a:	8b9d                	andi	a5,a5,7
    1a5c:	4681                	li	a3,0
    1a5e:	18061a63          	bnez	a2,1bf2 <strncpy+0x1d4>
    1a62:	00778713          	addi	a4,a5,7
    1a66:	45ad                	li	a1,11
    1a68:	18b76363          	bltu	a4,a1,1bee <strncpy+0x1d0>
    1a6c:	1ae6eb63          	bltu	a3,a4,1c22 <strncpy+0x204>
    1a70:	1a078363          	beqz	a5,1c16 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1a74:	00050023          	sb	zero,0(a0)
    1a78:	4685                	li	a3,1
    1a7a:	00150713          	addi	a4,a0,1
    1a7e:	18d78f63          	beq	a5,a3,1c1c <strncpy+0x1fe>
    1a82:	000500a3          	sb	zero,1(a0)
    1a86:	4689                	li	a3,2
    1a88:	00250713          	addi	a4,a0,2
    1a8c:	18d78e63          	beq	a5,a3,1c28 <strncpy+0x20a>
    1a90:	00050123          	sb	zero,2(a0)
    1a94:	468d                	li	a3,3
    1a96:	00350713          	addi	a4,a0,3
    1a9a:	16d78c63          	beq	a5,a3,1c12 <strncpy+0x1f4>
    1a9e:	000501a3          	sb	zero,3(a0)
    1aa2:	4691                	li	a3,4
    1aa4:	00450713          	addi	a4,a0,4
    1aa8:	18d78263          	beq	a5,a3,1c2c <strncpy+0x20e>
    1aac:	00050223          	sb	zero,4(a0)
    1ab0:	4695                	li	a3,5
    1ab2:	00550713          	addi	a4,a0,5
    1ab6:	16d78d63          	beq	a5,a3,1c30 <strncpy+0x212>
    1aba:	000502a3          	sb	zero,5(a0)
    1abe:	469d                	li	a3,7
    1ac0:	00650713          	addi	a4,a0,6
    1ac4:	16d79863          	bne	a5,a3,1c34 <strncpy+0x216>
    1ac8:	00750713          	addi	a4,a0,7
    1acc:	00050323          	sb	zero,6(a0)
    1ad0:	40f80833          	sub	a6,a6,a5
    1ad4:	ff887593          	andi	a1,a6,-8
    1ad8:	97aa                	add	a5,a5,a0
    1ada:	95be                	add	a1,a1,a5
    1adc:	0007b023          	sd	zero,0(a5)
    1ae0:	07a1                	addi	a5,a5,8
    1ae2:	feb79de3          	bne	a5,a1,1adc <strncpy+0xbe>
    1ae6:	ff887593          	andi	a1,a6,-8
    1aea:	9ead                	addw	a3,a3,a1
    1aec:	00b707b3          	add	a5,a4,a1
    1af0:	12b80863          	beq	a6,a1,1c20 <strncpy+0x202>
    1af4:	00078023          	sb	zero,0(a5)
    1af8:	0016871b          	addiw	a4,a3,1
    1afc:	0ec77863          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b00:	000780a3          	sb	zero,1(a5)
    1b04:	0026871b          	addiw	a4,a3,2
    1b08:	0ec77263          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b0c:	00078123          	sb	zero,2(a5)
    1b10:	0036871b          	addiw	a4,a3,3
    1b14:	0cc77c63          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b18:	000781a3          	sb	zero,3(a5)
    1b1c:	0046871b          	addiw	a4,a3,4
    1b20:	0cc77663          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b24:	00078223          	sb	zero,4(a5)
    1b28:	0056871b          	addiw	a4,a3,5
    1b2c:	0cc77063          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b30:	000782a3          	sb	zero,5(a5)
    1b34:	0066871b          	addiw	a4,a3,6
    1b38:	0ac77a63          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b3c:	00078323          	sb	zero,6(a5)
    1b40:	0076871b          	addiw	a4,a3,7
    1b44:	0ac77463          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b48:	000783a3          	sb	zero,7(a5)
    1b4c:	0086871b          	addiw	a4,a3,8
    1b50:	08c77e63          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b54:	00078423          	sb	zero,8(a5)
    1b58:	0096871b          	addiw	a4,a3,9
    1b5c:	08c77863          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b60:	000784a3          	sb	zero,9(a5)
    1b64:	00a6871b          	addiw	a4,a3,10
    1b68:	08c77263          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b6c:	00078523          	sb	zero,10(a5)
    1b70:	00b6871b          	addiw	a4,a3,11
    1b74:	06c77c63          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b78:	000785a3          	sb	zero,11(a5)
    1b7c:	00c6871b          	addiw	a4,a3,12
    1b80:	06c77663          	bgeu	a4,a2,1bec <strncpy+0x1ce>
    1b84:	00078623          	sb	zero,12(a5)
    1b88:	26b5                	addiw	a3,a3,13
    1b8a:	06c6f163          	bgeu	a3,a2,1bec <strncpy+0x1ce>
    1b8e:	000786a3          	sb	zero,13(a5)
    1b92:	8082                	ret
            ;
        if (!n || !*s)
    1b94:	c645                	beqz	a2,1c3c <strncpy+0x21e>
    1b96:	0005c783          	lbu	a5,0(a1)
    1b9a:	ea078be3          	beqz	a5,1a50 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b9e:	479d                	li	a5,7
    1ba0:	02c7ff63          	bgeu	a5,a2,1bde <strncpy+0x1c0>
    1ba4:	00000897          	auipc	a7,0x0
    1ba8:	3ac8b883          	ld	a7,940(a7) # 1f50 <__clone+0x9c>
    1bac:	00000817          	auipc	a6,0x0
    1bb0:	3ac83803          	ld	a6,940(a6) # 1f58 <__clone+0xa4>
    1bb4:	431d                	li	t1,7
    1bb6:	6198                	ld	a4,0(a1)
    1bb8:	011707b3          	add	a5,a4,a7
    1bbc:	fff74693          	not	a3,a4
    1bc0:	8ff5                	and	a5,a5,a3
    1bc2:	0107f7b3          	and	a5,a5,a6
    1bc6:	ef81                	bnez	a5,1bde <strncpy+0x1c0>
            *wd = *ws;
    1bc8:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bca:	1661                	addi	a2,a2,-8
    1bcc:	05a1                	addi	a1,a1,8
    1bce:	0521                	addi	a0,a0,8
    1bd0:	fec363e3          	bltu	t1,a2,1bb6 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bd4:	e609                	bnez	a2,1bde <strncpy+0x1c0>
    1bd6:	a08d                	j	1c38 <strncpy+0x21a>
    1bd8:	167d                	addi	a2,a2,-1
    1bda:	0505                	addi	a0,a0,1
    1bdc:	ca01                	beqz	a2,1bec <strncpy+0x1ce>
    1bde:	0005c783          	lbu	a5,0(a1)
    1be2:	0585                	addi	a1,a1,1
    1be4:	00f50023          	sb	a5,0(a0)
    1be8:	fbe5                	bnez	a5,1bd8 <strncpy+0x1ba>
        ;
tail:
    1bea:	b59d                	j	1a50 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bec:	8082                	ret
    1bee:	472d                	li	a4,11
    1bf0:	bdb5                	j	1a6c <strncpy+0x4e>
    1bf2:	00778713          	addi	a4,a5,7
    1bf6:	45ad                	li	a1,11
    1bf8:	fff60693          	addi	a3,a2,-1
    1bfc:	e6b778e3          	bgeu	a4,a1,1a6c <strncpy+0x4e>
    1c00:	b7fd                	j	1bee <strncpy+0x1d0>
    1c02:	40a007b3          	neg	a5,a0
    1c06:	8832                	mv	a6,a2
    1c08:	8b9d                	andi	a5,a5,7
    1c0a:	4681                	li	a3,0
    1c0c:	e4060be3          	beqz	a2,1a62 <strncpy+0x44>
    1c10:	b7cd                	j	1bf2 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c12:	468d                	li	a3,3
    1c14:	bd75                	j	1ad0 <strncpy+0xb2>
    1c16:	872a                	mv	a4,a0
    1c18:	4681                	li	a3,0
    1c1a:	bd5d                	j	1ad0 <strncpy+0xb2>
    1c1c:	4685                	li	a3,1
    1c1e:	bd4d                	j	1ad0 <strncpy+0xb2>
    1c20:	8082                	ret
    1c22:	87aa                	mv	a5,a0
    1c24:	4681                	li	a3,0
    1c26:	b5f9                	j	1af4 <strncpy+0xd6>
    1c28:	4689                	li	a3,2
    1c2a:	b55d                	j	1ad0 <strncpy+0xb2>
    1c2c:	4691                	li	a3,4
    1c2e:	b54d                	j	1ad0 <strncpy+0xb2>
    1c30:	4695                	li	a3,5
    1c32:	bd79                	j	1ad0 <strncpy+0xb2>
    1c34:	4699                	li	a3,6
    1c36:	bd69                	j	1ad0 <strncpy+0xb2>
    1c38:	8082                	ret
    1c3a:	8082                	ret
    1c3c:	8082                	ret

0000000000001c3e <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c3e:	87aa                	mv	a5,a0
    1c40:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c42:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c46:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c4a:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c4c:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c4e:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c52:	2501                	sext.w	a0,a0
    1c54:	8082                	ret

0000000000001c56 <openat>:
    register long a7 __asm__("a7") = n;
    1c56:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c5a:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c5e:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1c62:	2501                	sext.w	a0,a0
    1c64:	8082                	ret

0000000000001c66 <close>:
    register long a7 __asm__("a7") = n;
    1c66:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c6a:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c6e:	2501                	sext.w	a0,a0
    1c70:	8082                	ret

0000000000001c72 <read>:
    register long a7 __asm__("a7") = n;
    1c72:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c76:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1c7a:	8082                	ret

0000000000001c7c <write>:
    register long a7 __asm__("a7") = n;
    1c7c:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c80:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1c84:	8082                	ret

0000000000001c86 <getpid>:
    register long a7 __asm__("a7") = n;
    1c86:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c8a:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c8e:	2501                	sext.w	a0,a0
    1c90:	8082                	ret

0000000000001c92 <getppid>:
    register long a7 __asm__("a7") = n;
    1c92:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c96:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c9a:	2501                	sext.w	a0,a0
    1c9c:	8082                	ret

0000000000001c9e <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c9e:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1ca2:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1ca6:	2501                	sext.w	a0,a0
    1ca8:	8082                	ret

0000000000001caa <fork>:
    register long a7 __asm__("a7") = n;
    1caa:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cae:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cb0:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cb2:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cb6:	2501                	sext.w	a0,a0
    1cb8:	8082                	ret

0000000000001cba <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cba:	85b2                	mv	a1,a2
    1cbc:	863a                	mv	a2,a4
    if (stack)
    1cbe:	c191                	beqz	a1,1cc2 <clone+0x8>
	stack += stack_size;
    1cc0:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1cc2:	4781                	li	a5,0
    1cc4:	4701                	li	a4,0
    1cc6:	4681                	li	a3,0
    1cc8:	2601                	sext.w	a2,a2
    1cca:	a2ed                	j	1eb4 <__clone>

0000000000001ccc <exit>:
    register long a7 __asm__("a7") = n;
    1ccc:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1cd0:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1cd4:	8082                	ret

0000000000001cd6 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cd6:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1cda:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cdc:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1ce0:	2501                	sext.w	a0,a0
    1ce2:	8082                	ret

0000000000001ce4 <exec>:
    register long a7 __asm__("a7") = n;
    1ce4:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1ce8:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1cec:	2501                	sext.w	a0,a0
    1cee:	8082                	ret

0000000000001cf0 <execve>:
    register long a7 __asm__("a7") = n;
    1cf0:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cf4:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1cf8:	2501                	sext.w	a0,a0
    1cfa:	8082                	ret

0000000000001cfc <times>:
    register long a7 __asm__("a7") = n;
    1cfc:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d00:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d04:	2501                	sext.w	a0,a0
    1d06:	8082                	ret

0000000000001d08 <get_time>:

int64 get_time()
{
    1d08:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d0a:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d0e:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d10:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d12:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d16:	2501                	sext.w	a0,a0
    1d18:	ed09                	bnez	a0,1d32 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d1a:	67a2                	ld	a5,8(sp)
    1d1c:	3e800713          	li	a4,1000
    1d20:	00015503          	lhu	a0,0(sp)
    1d24:	02e7d7b3          	divu	a5,a5,a4
    1d28:	02e50533          	mul	a0,a0,a4
    1d2c:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d2e:	0141                	addi	sp,sp,16
    1d30:	8082                	ret
        return -1;
    1d32:	557d                	li	a0,-1
    1d34:	bfed                	j	1d2e <get_time+0x26>

0000000000001d36 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d36:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d3a:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d3e:	2501                	sext.w	a0,a0
    1d40:	8082                	ret

0000000000001d42 <time>:
    register long a7 __asm__("a7") = n;
    1d42:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d46:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d4a:	2501                	sext.w	a0,a0
    1d4c:	8082                	ret

0000000000001d4e <sleep>:

int sleep(unsigned long long time)
{
    1d4e:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d50:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d52:	850a                	mv	a0,sp
    1d54:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d56:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d5a:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d5c:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d60:	e501                	bnez	a0,1d68 <sleep+0x1a>
    return 0;
    1d62:	4501                	li	a0,0
}
    1d64:	0141                	addi	sp,sp,16
    1d66:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1d68:	4502                	lw	a0,0(sp)
}
    1d6a:	0141                	addi	sp,sp,16
    1d6c:	8082                	ret

0000000000001d6e <set_priority>:
    register long a7 __asm__("a7") = n;
    1d6e:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d72:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1d76:	2501                	sext.w	a0,a0
    1d78:	8082                	ret

0000000000001d7a <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1d7a:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1d7e:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1d82:	8082                	ret

0000000000001d84 <munmap>:
    register long a7 __asm__("a7") = n;
    1d84:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d88:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1d8c:	2501                	sext.w	a0,a0
    1d8e:	8082                	ret

0000000000001d90 <wait>:

int wait(int *code)
{
    1d90:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d92:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1d96:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1d98:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1d9a:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d9c:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1da0:	2501                	sext.w	a0,a0
    1da2:	8082                	ret

0000000000001da4 <spawn>:
    register long a7 __asm__("a7") = n;
    1da4:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1da8:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dac:	2501                	sext.w	a0,a0
    1dae:	8082                	ret

0000000000001db0 <mailread>:
    register long a7 __asm__("a7") = n;
    1db0:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db4:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1db8:	2501                	sext.w	a0,a0
    1dba:	8082                	ret

0000000000001dbc <mailwrite>:
    register long a7 __asm__("a7") = n;
    1dbc:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dc0:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1dc4:	2501                	sext.w	a0,a0
    1dc6:	8082                	ret

0000000000001dc8 <fstat>:
    register long a7 __asm__("a7") = n;
    1dc8:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dcc:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1dd0:	2501                	sext.w	a0,a0
    1dd2:	8082                	ret

0000000000001dd4 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1dd4:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1dd6:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1dda:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ddc:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1de0:	2501                	sext.w	a0,a0
    1de2:	8082                	ret

0000000000001de4 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1de4:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1de6:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1dea:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1dec:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1df0:	2501                	sext.w	a0,a0
    1df2:	8082                	ret

0000000000001df4 <link>:

int link(char *old_path, char *new_path)
{
    1df4:	87aa                	mv	a5,a0
    1df6:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1df8:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1dfc:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e00:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e02:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e06:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e08:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e0c:	2501                	sext.w	a0,a0
    1e0e:	8082                	ret

0000000000001e10 <unlink>:

int unlink(char *path)
{
    1e10:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e12:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e16:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e1a:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e1c:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e20:	2501                	sext.w	a0,a0
    1e22:	8082                	ret

0000000000001e24 <uname>:
    register long a7 __asm__("a7") = n;
    1e24:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e28:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e2c:	2501                	sext.w	a0,a0
    1e2e:	8082                	ret

0000000000001e30 <brk>:
    register long a7 __asm__("a7") = n;
    1e30:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e34:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e38:	2501                	sext.w	a0,a0
    1e3a:	8082                	ret

0000000000001e3c <getcwd>:
    register long a7 __asm__("a7") = n;
    1e3c:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e3e:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e42:	8082                	ret

0000000000001e44 <chdir>:
    register long a7 __asm__("a7") = n;
    1e44:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e48:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e4c:	2501                	sext.w	a0,a0
    1e4e:	8082                	ret

0000000000001e50 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e50:	862e                	mv	a2,a1
    1e52:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e54:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e56:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e5a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e5e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e60:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e62:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1e66:	2501                	sext.w	a0,a0
    1e68:	8082                	ret

0000000000001e6a <getdents>:
    register long a7 __asm__("a7") = n;
    1e6a:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e6e:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1e72:	2501                	sext.w	a0,a0
    1e74:	8082                	ret

0000000000001e76 <pipe>:
    register long a7 __asm__("a7") = n;
    1e76:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1e7a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e7c:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1e80:	2501                	sext.w	a0,a0
    1e82:	8082                	ret

0000000000001e84 <dup>:
    register long a7 __asm__("a7") = n;
    1e84:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1e86:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1e8a:	2501                	sext.w	a0,a0
    1e8c:	8082                	ret

0000000000001e8e <dup2>:
    register long a7 __asm__("a7") = n;
    1e8e:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1e90:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e92:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1e96:	2501                	sext.w	a0,a0
    1e98:	8082                	ret

0000000000001e9a <mount>:
    register long a7 __asm__("a7") = n;
    1e9a:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e9e:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ea2:	2501                	sext.w	a0,a0
    1ea4:	8082                	ret

0000000000001ea6 <umount>:
    register long a7 __asm__("a7") = n;
    1ea6:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1eaa:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eac:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1eb0:	2501                	sext.w	a0,a0
    1eb2:	8082                	ret

0000000000001eb4 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1eb4:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1eb6:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1eb8:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1eba:	8532                	mv	a0,a2
	mv a2, a4
    1ebc:	863a                	mv	a2,a4
	mv a3, a5
    1ebe:	86be                	mv	a3,a5
	mv a4, a6
    1ec0:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1ec2:	0dc00893          	li	a7,220
	ecall
    1ec6:	00000073          	ecall

	beqz a0, 1f
    1eca:	c111                	beqz	a0,1ece <__clone+0x1a>
	# Parent
	ret
    1ecc:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1ece:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1ed0:	6522                	ld	a0,8(sp)
	jalr a1
    1ed2:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1ed4:	05d00893          	li	a7,93
	ecall
    1ed8:	00000073          	ecall
