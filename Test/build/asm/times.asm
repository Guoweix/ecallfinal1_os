
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/times:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a869                	j	109c <__start_main>

0000000000001004 <test_times>:
	long tms_cstime; 
};

struct tms mytimes;

void test_times() {
    1004:	1141                	addi	sp,sp,-16
	TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	eda50513          	addi	a0,a0,-294 # 1ee0 <__clone+0x2c>
void test_times() {
    100e:	e406                	sd	ra,8(sp)
	TEST_START(__func__);
    1010:	2fe000ef          	jal	130e <puts>
    1014:	00001517          	auipc	a0,0x1
    1018:	fb450513          	addi	a0,a0,-76 # 1fc8 <__func__.0>
    101c:	2f2000ef          	jal	130e <puts>
    1020:	00001517          	auipc	a0,0x1
    1024:	ed850513          	addi	a0,a0,-296 # 1ef8 <__clone+0x44>
    1028:	2e6000ef          	jal	130e <puts>

	int test_ret = times(&mytimes);
    102c:	00001517          	auipc	a0,0x1
    1030:	f7c50513          	addi	a0,a0,-132 # 1fa8 <mytimes>
    1034:	4c9000ef          	jal	1cfc <times>
	assert(test_ret >= 0);
    1038:	04054363          	bltz	a0,107e <test_times+0x7a>

	printf("mytimes success\n{tms_utime:%d, tms_stime:%d, tms_cutime:%d, tms_cstime:%d}\n",
    103c:	00001797          	auipc	a5,0x1
    1040:	f6c78793          	addi	a5,a5,-148 # 1fa8 <mytimes>
    1044:	6f98                	ld	a4,24(a5)
    1046:	6b94                	ld	a3,16(a5)
    1048:	6790                	ld	a2,8(a5)
    104a:	638c                	ld	a1,0(a5)
    104c:	00001517          	auipc	a0,0x1
    1050:	edc50513          	addi	a0,a0,-292 # 1f28 <__clone+0x74>
    1054:	2dc000ef          	jal	1330 <printf>
		mytimes.tms_utime, mytimes.tms_stime, mytimes.tms_cutime, mytimes.tms_cstime);
	TEST_END(__func__);
    1058:	00001517          	auipc	a0,0x1
    105c:	f2050513          	addi	a0,a0,-224 # 1f78 <__clone+0xc4>
    1060:	2ae000ef          	jal	130e <puts>
    1064:	00001517          	auipc	a0,0x1
    1068:	f6450513          	addi	a0,a0,-156 # 1fc8 <__func__.0>
    106c:	2a2000ef          	jal	130e <puts>
}
    1070:	60a2                	ld	ra,8(sp)
	TEST_END(__func__);
    1072:	00001517          	auipc	a0,0x1
    1076:	e8650513          	addi	a0,a0,-378 # 1ef8 <__clone+0x44>
}
    107a:	0141                	addi	sp,sp,16
	TEST_END(__func__);
    107c:	ac49                	j	130e <puts>
	assert(test_ret >= 0);
    107e:	00001517          	auipc	a0,0x1
    1082:	e8a50513          	addi	a0,a0,-374 # 1f08 <__clone+0x54>
    1086:	534000ef          	jal	15ba <panic>
    108a:	bf4d                	j	103c <test_times+0x38>

000000000000108c <main>:

int main(void) {
    108c:	1141                	addi	sp,sp,-16
    108e:	e406                	sd	ra,8(sp)
	test_times();
    1090:	f75ff0ef          	jal	1004 <test_times>
	return 0;
}
    1094:	60a2                	ld	ra,8(sp)
    1096:	4501                	li	a0,0
    1098:	0141                	addi	sp,sp,16
    109a:	8082                	ret

000000000000109c <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    109c:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    109e:	4108                	lw	a0,0(a0)
{
    10a0:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10a2:	05a1                	addi	a1,a1,8
{
    10a4:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10a6:	fe7ff0ef          	jal	108c <main>
    10aa:	423000ef          	jal	1ccc <exit>
	return 0;
}
    10ae:	60a2                	ld	ra,8(sp)
    10b0:	4501                	li	a0,0
    10b2:	0141                	addi	sp,sp,16
    10b4:	8082                	ret

00000000000010b6 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10b6:	7179                	addi	sp,sp,-48
    10b8:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10ba:	12054b63          	bltz	a0,11f0 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    10be:	02b577bb          	remuw	a5,a0,a1
    10c2:	00001617          	auipc	a2,0x1
    10c6:	f1660613          	addi	a2,a2,-234 # 1fd8 <digits>
    buf[16] = 0;
    10ca:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    10ce:	0005871b          	sext.w	a4,a1
    10d2:	1782                	slli	a5,a5,0x20
    10d4:	9381                	srli	a5,a5,0x20
    10d6:	97b2                	add	a5,a5,a2
    10d8:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10dc:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    10e0:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    10e4:	1cb56363          	bltu	a0,a1,12aa <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    10e8:	45b9                	li	a1,14
    10ea:	02e877bb          	remuw	a5,a6,a4
    10ee:	1782                	slli	a5,a5,0x20
    10f0:	9381                	srli	a5,a5,0x20
    10f2:	97b2                	add	a5,a5,a2
    10f4:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    10f8:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    10fc:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1100:	0ce86e63          	bltu	a6,a4,11dc <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1104:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1108:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    110c:	1582                	slli	a1,a1,0x20
    110e:	9181                	srli	a1,a1,0x20
    1110:	95b2                	add	a1,a1,a2
    1112:	0005c583          	lbu	a1,0(a1)
    1116:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    111a:	0007859b          	sext.w	a1,a5
    111e:	12e6ec63          	bltu	a3,a4,1256 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1122:	02e7f6bb          	remuw	a3,a5,a4
    1126:	1682                	slli	a3,a3,0x20
    1128:	9281                	srli	a3,a3,0x20
    112a:	96b2                	add	a3,a3,a2
    112c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1130:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1134:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1138:	12e5e863          	bltu	a1,a4,1268 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    113c:	02e876bb          	remuw	a3,a6,a4
    1140:	1682                	slli	a3,a3,0x20
    1142:	9281                	srli	a3,a3,0x20
    1144:	96b2                	add	a3,a3,a2
    1146:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    114a:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    114e:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1152:	12e86463          	bltu	a6,a4,127a <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    1156:	02e5f6bb          	remuw	a3,a1,a4
    115a:	1682                	slli	a3,a3,0x20
    115c:	9281                	srli	a3,a3,0x20
    115e:	96b2                	add	a3,a3,a2
    1160:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1164:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1168:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    116c:	0ce5ec63          	bltu	a1,a4,1244 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    1170:	02e876bb          	remuw	a3,a6,a4
    1174:	1682                	slli	a3,a3,0x20
    1176:	9281                	srli	a3,a3,0x20
    1178:	96b2                	add	a3,a3,a2
    117a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    117e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1182:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    1186:	10e86963          	bltu	a6,a4,1298 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    118a:	02e5f6bb          	remuw	a3,a1,a4
    118e:	1682                	slli	a3,a3,0x20
    1190:	9281                	srli	a3,a3,0x20
    1192:	96b2                	add	a3,a3,a2
    1194:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1198:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    119c:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11a0:	10e5e763          	bltu	a1,a4,12ae <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11a4:	02e876bb          	remuw	a3,a6,a4
    11a8:	1682                	slli	a3,a3,0x20
    11aa:	9281                	srli	a3,a3,0x20
    11ac:	96b2                	add	a3,a3,a2
    11ae:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11b2:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11b6:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11ba:	10e86363          	bltu	a6,a4,12c0 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    11be:	1782                	slli	a5,a5,0x20
    11c0:	9381                	srli	a5,a5,0x20
    11c2:	97b2                	add	a5,a5,a2
    11c4:	0007c783          	lbu	a5,0(a5)
    11c8:	4599                	li	a1,6
    11ca:	00f10723          	sb	a5,14(sp)

    if (sign)
    11ce:	00055763          	bgez	a0,11dc <printint.constprop.0+0x126>
        buf[i--] = '-';
    11d2:	02d00793          	li	a5,45
    11d6:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    11da:	4595                	li	a1,5
    write(f, s, l);
    11dc:	003c                	addi	a5,sp,8
    11de:	4641                	li	a2,16
    11e0:	9e0d                	subw	a2,a2,a1
    11e2:	4505                	li	a0,1
    11e4:	95be                	add	a1,a1,a5
    11e6:	297000ef          	jal	1c7c <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    11ea:	70a2                	ld	ra,40(sp)
    11ec:	6145                	addi	sp,sp,48
    11ee:	8082                	ret
        x = -xx;
    11f0:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    11f4:	02b877bb          	remuw	a5,a6,a1
    11f8:	00001617          	auipc	a2,0x1
    11fc:	de060613          	addi	a2,a2,-544 # 1fd8 <digits>
    buf[16] = 0;
    1200:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1204:	0005871b          	sext.w	a4,a1
    1208:	1782                	slli	a5,a5,0x20
    120a:	9381                	srli	a5,a5,0x20
    120c:	97b2                	add	a5,a5,a2
    120e:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1212:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1216:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    121a:	06b86963          	bltu	a6,a1,128c <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    121e:	02e8f7bb          	remuw	a5,a7,a4
    1222:	1782                	slli	a5,a5,0x20
    1224:	9381                	srli	a5,a5,0x20
    1226:	97b2                	add	a5,a5,a2
    1228:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    122c:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1230:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1234:	ece8f8e3          	bgeu	a7,a4,1104 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1238:	02d00793          	li	a5,45
    123c:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1240:	45b5                	li	a1,13
    1242:	bf69                	j	11dc <printint.constprop.0+0x126>
    1244:	45a9                	li	a1,10
    if (sign)
    1246:	f8055be3          	bgez	a0,11dc <printint.constprop.0+0x126>
        buf[i--] = '-';
    124a:	02d00793          	li	a5,45
    124e:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1252:	45a5                	li	a1,9
    1254:	b761                	j	11dc <printint.constprop.0+0x126>
    1256:	45b5                	li	a1,13
    if (sign)
    1258:	f80552e3          	bgez	a0,11dc <printint.constprop.0+0x126>
        buf[i--] = '-';
    125c:	02d00793          	li	a5,45
    1260:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    1264:	45b1                	li	a1,12
    1266:	bf9d                	j	11dc <printint.constprop.0+0x126>
    1268:	45b1                	li	a1,12
    if (sign)
    126a:	f60559e3          	bgez	a0,11dc <printint.constprop.0+0x126>
        buf[i--] = '-';
    126e:	02d00793          	li	a5,45
    1272:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    1276:	45ad                	li	a1,11
    1278:	b795                	j	11dc <printint.constprop.0+0x126>
    127a:	45ad                	li	a1,11
    if (sign)
    127c:	f60550e3          	bgez	a0,11dc <printint.constprop.0+0x126>
        buf[i--] = '-';
    1280:	02d00793          	li	a5,45
    1284:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    1288:	45a9                	li	a1,10
    128a:	bf89                	j	11dc <printint.constprop.0+0x126>
        buf[i--] = '-';
    128c:	02d00793          	li	a5,45
    1290:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    1294:	45b9                	li	a1,14
    1296:	b799                	j	11dc <printint.constprop.0+0x126>
    1298:	45a5                	li	a1,9
    if (sign)
    129a:	f40551e3          	bgez	a0,11dc <printint.constprop.0+0x126>
        buf[i--] = '-';
    129e:	02d00793          	li	a5,45
    12a2:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12a6:	45a1                	li	a1,8
    12a8:	bf15                	j	11dc <printint.constprop.0+0x126>
    i = 15;
    12aa:	45bd                	li	a1,15
    12ac:	bf05                	j	11dc <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12ae:	45a1                	li	a1,8
    if (sign)
    12b0:	f20556e3          	bgez	a0,11dc <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b4:	02d00793          	li	a5,45
    12b8:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    12bc:	459d                	li	a1,7
    12be:	bf39                	j	11dc <printint.constprop.0+0x126>
    12c0:	459d                	li	a1,7
    if (sign)
    12c2:	f0055de3          	bgez	a0,11dc <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c6:	02d00793          	li	a5,45
    12ca:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    12ce:	4599                	li	a1,6
    12d0:	b731                	j	11dc <printint.constprop.0+0x126>

00000000000012d2 <getchar>:
{
    12d2:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    12d4:	00f10593          	addi	a1,sp,15
    12d8:	4605                	li	a2,1
    12da:	4501                	li	a0,0
{
    12dc:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12de:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12e2:	191000ef          	jal	1c72 <read>
}
    12e6:	60e2                	ld	ra,24(sp)
    12e8:	00f14503          	lbu	a0,15(sp)
    12ec:	6105                	addi	sp,sp,32
    12ee:	8082                	ret

00000000000012f0 <putchar>:
{
    12f0:	1101                	addi	sp,sp,-32
    12f2:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    12f4:	00f10593          	addi	a1,sp,15
    12f8:	4605                	li	a2,1
    12fa:	4505                	li	a0,1
{
    12fc:	ec06                	sd	ra,24(sp)
    char byte = c;
    12fe:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1302:	17b000ef          	jal	1c7c <write>
}
    1306:	60e2                	ld	ra,24(sp)
    1308:	2501                	sext.w	a0,a0
    130a:	6105                	addi	sp,sp,32
    130c:	8082                	ret

000000000000130e <puts>:
{
    130e:	1141                	addi	sp,sp,-16
    1310:	e406                	sd	ra,8(sp)
    1312:	e022                	sd	s0,0(sp)
    1314:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1316:	582000ef          	jal	1898 <strlen>
    131a:	862a                	mv	a2,a0
    131c:	85a2                	mv	a1,s0
    131e:	4505                	li	a0,1
    1320:	15d000ef          	jal	1c7c <write>
}
    1324:	60a2                	ld	ra,8(sp)
    1326:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1328:	957d                	srai	a0,a0,0x3f
    return r;
    132a:	2501                	sext.w	a0,a0
}
    132c:	0141                	addi	sp,sp,16
    132e:	8082                	ret

0000000000001330 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1330:	7131                	addi	sp,sp,-192
    1332:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1334:	013c                	addi	a5,sp,136
{
    1336:	f0ca                	sd	s2,96(sp)
    1338:	ecce                	sd	s3,88(sp)
    133a:	e8d2                	sd	s4,80(sp)
    133c:	e4d6                	sd	s5,72(sp)
    133e:	e0da                	sd	s6,64(sp)
    1340:	fc5e                	sd	s7,56(sp)
    1342:	fc86                	sd	ra,120(sp)
    1344:	f8a2                	sd	s0,112(sp)
    1346:	f4a6                	sd	s1,104(sp)
    1348:	e52e                	sd	a1,136(sp)
    134a:	e932                	sd	a2,144(sp)
    134c:	ed36                	sd	a3,152(sp)
    134e:	f13a                	sd	a4,160(sp)
    1350:	f942                	sd	a6,176(sp)
    1352:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1354:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    1356:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    135a:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    135e:	00001b97          	auipc	s7,0x1
    1362:	c2ab8b93          	addi	s7,s7,-982 # 1f88 <__clone+0xd4>
        switch (s[1])
    1366:	07800a93          	li	s5,120
    136a:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    136e:	00001997          	auipc	s3,0x1
    1372:	c6a98993          	addi	s3,s3,-918 # 1fd8 <digits>
        if (!*s)
    1376:	00054783          	lbu	a5,0(a0)
    137a:	16078c63          	beqz	a5,14f2 <printf+0x1c2>
    137e:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1380:	19278463          	beq	a5,s2,1508 <printf+0x1d8>
    1384:	00164783          	lbu	a5,1(a2)
    1388:	0605                	addi	a2,a2,1
    138a:	fbfd                	bnez	a5,1380 <printf+0x50>
    138c:	84b2                	mv	s1,a2
        l = z - a;
    138e:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1392:	85aa                	mv	a1,a0
    1394:	8622                	mv	a2,s0
    1396:	4505                	li	a0,1
    1398:	0e5000ef          	jal	1c7c <write>
        if (l)
    139c:	18041f63          	bnez	s0,153a <printf+0x20a>
        if (s[1] == 0)
    13a0:	0014c783          	lbu	a5,1(s1)
    13a4:	14078763          	beqz	a5,14f2 <printf+0x1c2>
        switch (s[1])
    13a8:	1d478163          	beq	a5,s4,156a <printf+0x23a>
    13ac:	18fa6963          	bltu	s4,a5,153e <printf+0x20e>
    13b0:	1b678363          	beq	a5,s6,1556 <printf+0x226>
    13b4:	07000713          	li	a4,112
    13b8:	1ce79c63          	bne	a5,a4,1590 <printf+0x260>
            printptr(va_arg(ap, uint64));
    13bc:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    13be:	03000793          	li	a5,48
    13c2:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    13c6:	631c                	ld	a5,0(a4)
    13c8:	0721                	addi	a4,a4,8
    13ca:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    13cc:	00479f93          	slli	t6,a5,0x4
    13d0:	00879f13          	slli	t5,a5,0x8
    13d4:	00c79e93          	slli	t4,a5,0xc
    13d8:	01079e13          	slli	t3,a5,0x10
    13dc:	01479313          	slli	t1,a5,0x14
    13e0:	01879893          	slli	a7,a5,0x18
    13e4:	01c79713          	slli	a4,a5,0x1c
    13e8:	02479813          	slli	a6,a5,0x24
    13ec:	02879513          	slli	a0,a5,0x28
    13f0:	02c79593          	slli	a1,a5,0x2c
    13f4:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13f8:	03c7d293          	srli	t0,a5,0x3c
    13fc:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1400:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1404:	03cfdf93          	srli	t6,t6,0x3c
    1408:	03cf5f13          	srli	t5,t5,0x3c
    140c:	03cede93          	srli	t4,t4,0x3c
    1410:	03ce5e13          	srli	t3,t3,0x3c
    1414:	03c35313          	srli	t1,t1,0x3c
    1418:	03c8d893          	srli	a7,a7,0x3c
    141c:	9371                	srli	a4,a4,0x3c
    141e:	03c85813          	srli	a6,a6,0x3c
    1422:	9171                	srli	a0,a0,0x3c
    1424:	91f1                	srli	a1,a1,0x3c
    1426:	9271                	srli	a2,a2,0x3c
    1428:	974e                	add	a4,a4,s3
    142a:	92f1                	srli	a3,a3,0x3c
    142c:	92ce                	add	t0,t0,s3
    142e:	9fce                	add	t6,t6,s3
    1430:	9f4e                	add	t5,t5,s3
    1432:	9ece                	add	t4,t4,s3
    1434:	9e4e                	add	t3,t3,s3
    1436:	934e                	add	t1,t1,s3
    1438:	98ce                	add	a7,a7,s3
    143a:	93ce                	add	t2,t2,s3
    143c:	984e                	add	a6,a6,s3
    143e:	954e                	add	a0,a0,s3
    1440:	95ce                	add	a1,a1,s3
    1442:	964e                	add	a2,a2,s3
    1444:	0002c283          	lbu	t0,0(t0)
    1448:	000fcf83          	lbu	t6,0(t6)
    144c:	000f4f03          	lbu	t5,0(t5)
    1450:	000ece83          	lbu	t4,0(t4)
    1454:	000e4e03          	lbu	t3,0(t3)
    1458:	00034303          	lbu	t1,0(t1)
    145c:	0008c883          	lbu	a7,0(a7)
    1460:	00074403          	lbu	s0,0(a4)
    1464:	0003c383          	lbu	t2,0(t2)
    1468:	00084803          	lbu	a6,0(a6)
    146c:	00054503          	lbu	a0,0(a0)
    1470:	0005c583          	lbu	a1,0(a1)
    1474:	00064603          	lbu	a2,0(a2)
    1478:	00d98733          	add	a4,s3,a3
    147c:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1480:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1484:	9371                	srli	a4,a4,0x3c
    1486:	8bbd                	andi	a5,a5,15
    1488:	00510523          	sb	t0,10(sp)
    148c:	01f105a3          	sb	t6,11(sp)
    1490:	01e10623          	sb	t5,12(sp)
    1494:	01d106a3          	sb	t4,13(sp)
    1498:	01c10723          	sb	t3,14(sp)
    149c:	006107a3          	sb	t1,15(sp)
    14a0:	01110823          	sb	a7,16(sp)
    14a4:	00710923          	sb	t2,18(sp)
    14a8:	010109a3          	sb	a6,19(sp)
    14ac:	00a10a23          	sb	a0,20(sp)
    14b0:	00b10aa3          	sb	a1,21(sp)
    14b4:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14b8:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14bc:	008108a3          	sb	s0,17(sp)
    14c0:	974e                	add	a4,a4,s3
    14c2:	97ce                	add	a5,a5,s3
    14c4:	00d10ba3          	sb	a3,23(sp)
    14c8:	00074703          	lbu	a4,0(a4)
    14cc:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    14d0:	4649                	li	a2,18
    14d2:	002c                	addi	a1,sp,8
    14d4:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14d6:	00e10c23          	sb	a4,24(sp)
    14da:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    14de:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    14e2:	79a000ef          	jal	1c7c <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    14e6:	00248513          	addi	a0,s1,2
        if (!*s)
    14ea:	00054783          	lbu	a5,0(a0)
    14ee:	e80798e3          	bnez	a5,137e <printf+0x4e>
    }
    va_end(ap);
}
    14f2:	70e6                	ld	ra,120(sp)
    14f4:	7446                	ld	s0,112(sp)
    14f6:	74a6                	ld	s1,104(sp)
    14f8:	7906                	ld	s2,96(sp)
    14fa:	69e6                	ld	s3,88(sp)
    14fc:	6a46                	ld	s4,80(sp)
    14fe:	6aa6                	ld	s5,72(sp)
    1500:	6b06                	ld	s6,64(sp)
    1502:	7be2                	ld	s7,56(sp)
    1504:	6129                	addi	sp,sp,192
    1506:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1508:	00064783          	lbu	a5,0(a2)
    150c:	84b2                	mv	s1,a2
    150e:	01278963          	beq	a5,s2,1520 <printf+0x1f0>
    1512:	bdb5                	j	138e <printf+0x5e>
    1514:	0024c783          	lbu	a5,2(s1)
    1518:	0605                	addi	a2,a2,1
    151a:	0489                	addi	s1,s1,2
    151c:	e72799e3          	bne	a5,s2,138e <printf+0x5e>
    1520:	0014c783          	lbu	a5,1(s1)
    1524:	ff2788e3          	beq	a5,s2,1514 <printf+0x1e4>
        l = z - a;
    1528:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    152c:	85aa                	mv	a1,a0
    152e:	8622                	mv	a2,s0
    1530:	4505                	li	a0,1
    1532:	74a000ef          	jal	1c7c <write>
        if (l)
    1536:	e60405e3          	beqz	s0,13a0 <printf+0x70>
    153a:	8526                	mv	a0,s1
    153c:	bd2d                	j	1376 <printf+0x46>
        switch (s[1])
    153e:	05579963          	bne	a5,s5,1590 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1542:	6782                	ld	a5,0(sp)
    1544:	45c1                	li	a1,16
    1546:	4388                	lw	a0,0(a5)
    1548:	07a1                	addi	a5,a5,8
    154a:	e03e                	sd	a5,0(sp)
    154c:	b6bff0ef          	jal	10b6 <printint.constprop.0>
        s += 2;
    1550:	00248513          	addi	a0,s1,2
    1554:	bf59                	j	14ea <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    1556:	6782                	ld	a5,0(sp)
    1558:	45a9                	li	a1,10
    155a:	4388                	lw	a0,0(a5)
    155c:	07a1                	addi	a5,a5,8
    155e:	e03e                	sd	a5,0(sp)
    1560:	b57ff0ef          	jal	10b6 <printint.constprop.0>
        s += 2;
    1564:	00248513          	addi	a0,s1,2
    1568:	b749                	j	14ea <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    156a:	6782                	ld	a5,0(sp)
    156c:	6380                	ld	s0,0(a5)
    156e:	07a1                	addi	a5,a5,8
    1570:	e03e                	sd	a5,0(sp)
    1572:	c031                	beqz	s0,15b6 <printf+0x286>
            l = strnlen(a, 200);
    1574:	0c800593          	li	a1,200
    1578:	8522                	mv	a0,s0
    157a:	40a000ef          	jal	1984 <strnlen>
    write(f, s, l);
    157e:	0005061b          	sext.w	a2,a0
    1582:	85a2                	mv	a1,s0
    1584:	4505                	li	a0,1
    1586:	6f6000ef          	jal	1c7c <write>
        s += 2;
    158a:	00248513          	addi	a0,s1,2
    158e:	bfb1                	j	14ea <printf+0x1ba>
    return write(stdout, &byte, 1);
    1590:	4605                	li	a2,1
    1592:	002c                	addi	a1,sp,8
    1594:	4505                	li	a0,1
    char byte = c;
    1596:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    159a:	6e2000ef          	jal	1c7c <write>
    char byte = c;
    159e:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15a2:	4605                	li	a2,1
    15a4:	002c                	addi	a1,sp,8
    15a6:	4505                	li	a0,1
    char byte = c;
    15a8:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15ac:	6d0000ef          	jal	1c7c <write>
        s += 2;
    15b0:	00248513          	addi	a0,s1,2
    15b4:	bf1d                	j	14ea <printf+0x1ba>
                a = "(null)";
    15b6:	845e                	mv	s0,s7
    15b8:	bf75                	j	1574 <printf+0x244>

00000000000015ba <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15ba:	1141                	addi	sp,sp,-16
    15bc:	e406                	sd	ra,8(sp)
    puts(m);
    15be:	d51ff0ef          	jal	130e <puts>
    exit(-100);
}
    15c2:	60a2                	ld	ra,8(sp)
    exit(-100);
    15c4:	f9c00513          	li	a0,-100
}
    15c8:	0141                	addi	sp,sp,16
    exit(-100);
    15ca:	a709                	j	1ccc <exit>

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
    18be:	6d65b583          	ld	a1,1750(a1) # 1f90 <__clone+0xdc>
    18c2:	00000617          	auipc	a2,0x0
    18c6:	6d663603          	ld	a2,1750(a2) # 1f98 <__clone+0xe4>
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
    1926:	67e53503          	ld	a0,1662(a0) # 1fa0 <__clone+0xec>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    192a:	471d                	li	a4,7
        size_t k = ONES * c;
    192c:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1930:	02c77a63          	bgeu	a4,a2,1964 <memchr+0x6e>
    1934:	00000897          	auipc	a7,0x0
    1938:	65c8b883          	ld	a7,1628(a7) # 1f90 <__clone+0xdc>
    193c:	00000817          	auipc	a6,0x0
    1940:	65c83803          	ld	a6,1628(a6) # 1f98 <__clone+0xe4>
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
    19c6:	5ce63603          	ld	a2,1486(a2) # 1f90 <__clone+0xdc>
    19ca:	00000817          	auipc	a6,0x0
    19ce:	5ce83803          	ld	a6,1486(a6) # 1f98 <__clone+0xe4>
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
    1ba8:	3ec8b883          	ld	a7,1004(a7) # 1f90 <__clone+0xdc>
    1bac:	00000817          	auipc	a6,0x0
    1bb0:	3ec83803          	ld	a6,1004(a6) # 1f98 <__clone+0xe4>
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
