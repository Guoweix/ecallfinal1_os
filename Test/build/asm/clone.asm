
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/clone:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a0f5                	j	10ee <__start_main>

0000000000001004 <child_func>:
#include "unistd.h"

size_t stack[1024] = {0};
static int child_pid;

static int child_func(void){
    1004:	1141                	addi	sp,sp,-16
    printf("  Child says successfully!\n");
    1006:	00001517          	auipc	a0,0x1
    100a:	f2a50513          	addi	a0,a0,-214 # 1f30 <__clone+0x2a>
static int child_func(void){
    100e:	e406                	sd	ra,8(sp)
    printf("  Child says successfully!\n");
    1010:	372000ef          	jal	1382 <printf>
    return 0;
}
    1014:	60a2                	ld	ra,8(sp)
    1016:	4501                	li	a0,0
    1018:	0141                	addi	sp,sp,16
    101a:	8082                	ret

000000000000101c <test_clone>:

void test_clone(void){
    101c:	1101                	addi	sp,sp,-32
    TEST_START(__func__);
    101e:	00001517          	auipc	a0,0x1
    1022:	f3250513          	addi	a0,a0,-206 # 1f50 <__clone+0x4a>
void test_clone(void){
    1026:	ec06                	sd	ra,24(sp)
    1028:	e822                	sd	s0,16(sp)
    TEST_START(__func__);
    102a:	336000ef          	jal	1360 <puts>
    102e:	00003517          	auipc	a0,0x3
    1032:	fe250513          	addi	a0,a0,-30 # 4010 <__func__.0>
    1036:	32a000ef          	jal	1360 <puts>
    103a:	00001517          	auipc	a0,0x1
    103e:	f2e50513          	addi	a0,a0,-210 # 1f68 <__clone+0x62>
    1042:	31e000ef          	jal	1360 <puts>
    int wstatus;
    child_pid = clone(child_func, NULL, stack, 1024, SIGCHLD);
    1046:	4745                	li	a4,17
    1048:	40000693          	li	a3,1024
    104c:	00001617          	auipc	a2,0x1
    1050:	fbc60613          	addi	a2,a2,-68 # 2008 <stack>
    1054:	4581                	li	a1,0
    1056:	00000517          	auipc	a0,0x0
    105a:	fae50513          	addi	a0,a0,-82 # 1004 <child_func>
    105e:	4af000ef          	jal	1d0c <clone>
    1062:	00003417          	auipc	s0,0x3
    1066:	fa640413          	addi	s0,s0,-90 # 4008 <child_pid>
    106a:	c008                	sw	a0,0(s0)
    assert(child_pid != -1);
    106c:	57fd                	li	a5,-1
    106e:	04f50863          	beq	a0,a5,10be <test_clone+0xa2>
    if (child_pid == 0){
    1072:	e90d                	bnez	a0,10a4 <test_clone+0x88>
	exit(0);
    1074:	4ab000ef          	jal	1d1e <exit>
	    printf("clone process successfully.\npid:%d\n", child_pid);
	else
	    printf("clone process error.\n");
    }

    TEST_END(__func__);
    1078:	00001517          	auipc	a0,0x1
    107c:	f6050513          	addi	a0,a0,-160 # 1fd8 <__clone+0xd2>
    1080:	2e0000ef          	jal	1360 <puts>
    1084:	00003517          	auipc	a0,0x3
    1088:	f8c50513          	addi	a0,a0,-116 # 4010 <__func__.0>
    108c:	2d4000ef          	jal	1360 <puts>
    1090:	00001517          	auipc	a0,0x1
    1094:	ed850513          	addi	a0,a0,-296 # 1f68 <__clone+0x62>
    1098:	2c8000ef          	jal	1360 <puts>
}
    109c:	60e2                	ld	ra,24(sp)
    109e:	6442                	ld	s0,16(sp)
    10a0:	6105                	addi	sp,sp,32
    10a2:	8082                	ret
	if(wait(&wstatus) == child_pid)
    10a4:	0068                	addi	a0,sp,12
    10a6:	53d000ef          	jal	1de2 <wait>
    10aa:	401c                	lw	a5,0(s0)
    10ac:	02f50163          	beq	a0,a5,10ce <test_clone+0xb2>
	    printf("clone process error.\n");
    10b0:	00001517          	auipc	a0,0x1
    10b4:	f1050513          	addi	a0,a0,-240 # 1fc0 <__clone+0xba>
    10b8:	2ca000ef          	jal	1382 <printf>
    10bc:	bf75                	j	1078 <test_clone+0x5c>
    assert(child_pid != -1);
    10be:	00001517          	auipc	a0,0x1
    10c2:	eba50513          	addi	a0,a0,-326 # 1f78 <__clone+0x72>
    10c6:	546000ef          	jal	160c <panic>
    if (child_pid == 0){
    10ca:	4008                	lw	a0,0(s0)
    10cc:	b75d                	j	1072 <test_clone+0x56>
	    printf("clone process successfully.\npid:%d\n", child_pid);
    10ce:	85aa                	mv	a1,a0
    10d0:	00001517          	auipc	a0,0x1
    10d4:	ec850513          	addi	a0,a0,-312 # 1f98 <__clone+0x92>
    10d8:	2aa000ef          	jal	1382 <printf>
    10dc:	bf71                	j	1078 <test_clone+0x5c>

00000000000010de <main>:

int main(void){
    10de:	1141                	addi	sp,sp,-16
    10e0:	e406                	sd	ra,8(sp)
    test_clone();
    10e2:	f3bff0ef          	jal	101c <test_clone>
    return 0;
}
    10e6:	60a2                	ld	ra,8(sp)
    10e8:	4501                	li	a0,0
    10ea:	0141                	addi	sp,sp,16
    10ec:	8082                	ret

00000000000010ee <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10ee:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10f0:	4108                	lw	a0,0(a0)
{
    10f2:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10f4:	05a1                	addi	a1,a1,8
{
    10f6:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10f8:	fe7ff0ef          	jal	10de <main>
    10fc:	423000ef          	jal	1d1e <exit>
	return 0;
}
    1100:	60a2                	ld	ra,8(sp)
    1102:	4501                	li	a0,0
    1104:	0141                	addi	sp,sp,16
    1106:	8082                	ret

0000000000001108 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    1108:	7179                	addi	sp,sp,-48
    110a:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    110c:	12054b63          	bltz	a0,1242 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    1110:	02b577bb          	remuw	a5,a0,a1
    1114:	00003617          	auipc	a2,0x3
    1118:	f0c60613          	addi	a2,a2,-244 # 4020 <digits>
    buf[16] = 0;
    111c:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1120:	0005871b          	sext.w	a4,a1
    1124:	1782                	slli	a5,a5,0x20
    1126:	9381                	srli	a5,a5,0x20
    1128:	97b2                	add	a5,a5,a2
    112a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    112e:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1132:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1136:	1cb56363          	bltu	a0,a1,12fc <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    113a:	45b9                	li	a1,14
    113c:	02e877bb          	remuw	a5,a6,a4
    1140:	1782                	slli	a5,a5,0x20
    1142:	9381                	srli	a5,a5,0x20
    1144:	97b2                	add	a5,a5,a2
    1146:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    114a:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    114e:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1152:	0ce86e63          	bltu	a6,a4,122e <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1156:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    115a:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    115e:	1582                	slli	a1,a1,0x20
    1160:	9181                	srli	a1,a1,0x20
    1162:	95b2                	add	a1,a1,a2
    1164:	0005c583          	lbu	a1,0(a1)
    1168:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    116c:	0007859b          	sext.w	a1,a5
    1170:	12e6ec63          	bltu	a3,a4,12a8 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1174:	02e7f6bb          	remuw	a3,a5,a4
    1178:	1682                	slli	a3,a3,0x20
    117a:	9281                	srli	a3,a3,0x20
    117c:	96b2                	add	a3,a3,a2
    117e:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1182:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1186:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    118a:	12e5e863          	bltu	a1,a4,12ba <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    118e:	02e876bb          	remuw	a3,a6,a4
    1192:	1682                	slli	a3,a3,0x20
    1194:	9281                	srli	a3,a3,0x20
    1196:	96b2                	add	a3,a3,a2
    1198:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    119c:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11a0:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    11a4:	12e86463          	bltu	a6,a4,12cc <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    11a8:	02e5f6bb          	remuw	a3,a1,a4
    11ac:	1682                	slli	a3,a3,0x20
    11ae:	9281                	srli	a3,a3,0x20
    11b0:	96b2                	add	a3,a3,a2
    11b2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11b6:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11ba:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    11be:	0ce5ec63          	bltu	a1,a4,1296 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    11c2:	02e876bb          	remuw	a3,a6,a4
    11c6:	1682                	slli	a3,a3,0x20
    11c8:	9281                	srli	a3,a3,0x20
    11ca:	96b2                	add	a3,a3,a2
    11cc:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11d0:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11d4:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11d8:	10e86963          	bltu	a6,a4,12ea <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11dc:	02e5f6bb          	remuw	a3,a1,a4
    11e0:	1682                	slli	a3,a3,0x20
    11e2:	9281                	srli	a3,a3,0x20
    11e4:	96b2                	add	a3,a3,a2
    11e6:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11ea:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11ee:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11f2:	10e5e763          	bltu	a1,a4,1300 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11f6:	02e876bb          	remuw	a3,a6,a4
    11fa:	1682                	slli	a3,a3,0x20
    11fc:	9281                	srli	a3,a3,0x20
    11fe:	96b2                	add	a3,a3,a2
    1200:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1204:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    1208:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    120c:	10e86363          	bltu	a6,a4,1312 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    1210:	1782                	slli	a5,a5,0x20
    1212:	9381                	srli	a5,a5,0x20
    1214:	97b2                	add	a5,a5,a2
    1216:	0007c783          	lbu	a5,0(a5)
    121a:	4599                	li	a1,6
    121c:	00f10723          	sb	a5,14(sp)

    if (sign)
    1220:	00055763          	bgez	a0,122e <printint.constprop.0+0x126>
        buf[i--] = '-';
    1224:	02d00793          	li	a5,45
    1228:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    122c:	4595                	li	a1,5
    write(f, s, l);
    122e:	003c                	addi	a5,sp,8
    1230:	4641                	li	a2,16
    1232:	9e0d                	subw	a2,a2,a1
    1234:	4505                	li	a0,1
    1236:	95be                	add	a1,a1,a5
    1238:	297000ef          	jal	1cce <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    123c:	70a2                	ld	ra,40(sp)
    123e:	6145                	addi	sp,sp,48
    1240:	8082                	ret
        x = -xx;
    1242:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1246:	02b877bb          	remuw	a5,a6,a1
    124a:	00003617          	auipc	a2,0x3
    124e:	dd660613          	addi	a2,a2,-554 # 4020 <digits>
    buf[16] = 0;
    1252:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1256:	0005871b          	sext.w	a4,a1
    125a:	1782                	slli	a5,a5,0x20
    125c:	9381                	srli	a5,a5,0x20
    125e:	97b2                	add	a5,a5,a2
    1260:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1264:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1268:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    126c:	06b86963          	bltu	a6,a1,12de <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1270:	02e8f7bb          	remuw	a5,a7,a4
    1274:	1782                	slli	a5,a5,0x20
    1276:	9381                	srli	a5,a5,0x20
    1278:	97b2                	add	a5,a5,a2
    127a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    127e:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1282:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1286:	ece8f8e3          	bgeu	a7,a4,1156 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    128a:	02d00793          	li	a5,45
    128e:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1292:	45b5                	li	a1,13
    1294:	bf69                	j	122e <printint.constprop.0+0x126>
    1296:	45a9                	li	a1,10
    if (sign)
    1298:	f8055be3          	bgez	a0,122e <printint.constprop.0+0x126>
        buf[i--] = '-';
    129c:	02d00793          	li	a5,45
    12a0:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    12a4:	45a5                	li	a1,9
    12a6:	b761                	j	122e <printint.constprop.0+0x126>
    12a8:	45b5                	li	a1,13
    if (sign)
    12aa:	f80552e3          	bgez	a0,122e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12ae:	02d00793          	li	a5,45
    12b2:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    12b6:	45b1                	li	a1,12
    12b8:	bf9d                	j	122e <printint.constprop.0+0x126>
    12ba:	45b1                	li	a1,12
    if (sign)
    12bc:	f60559e3          	bgez	a0,122e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c0:	02d00793          	li	a5,45
    12c4:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12c8:	45ad                	li	a1,11
    12ca:	b795                	j	122e <printint.constprop.0+0x126>
    12cc:	45ad                	li	a1,11
    if (sign)
    12ce:	f60550e3          	bgez	a0,122e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d2:	02d00793          	li	a5,45
    12d6:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12da:	45a9                	li	a1,10
    12dc:	bf89                	j	122e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12de:	02d00793          	li	a5,45
    12e2:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12e6:	45b9                	li	a1,14
    12e8:	b799                	j	122e <printint.constprop.0+0x126>
    12ea:	45a5                	li	a1,9
    if (sign)
    12ec:	f40551e3          	bgez	a0,122e <printint.constprop.0+0x126>
        buf[i--] = '-';
    12f0:	02d00793          	li	a5,45
    12f4:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12f8:	45a1                	li	a1,8
    12fa:	bf15                	j	122e <printint.constprop.0+0x126>
    i = 15;
    12fc:	45bd                	li	a1,15
    12fe:	bf05                	j	122e <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1300:	45a1                	li	a1,8
    if (sign)
    1302:	f20556e3          	bgez	a0,122e <printint.constprop.0+0x126>
        buf[i--] = '-';
    1306:	02d00793          	li	a5,45
    130a:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    130e:	459d                	li	a1,7
    1310:	bf39                	j	122e <printint.constprop.0+0x126>
    1312:	459d                	li	a1,7
    if (sign)
    1314:	f0055de3          	bgez	a0,122e <printint.constprop.0+0x126>
        buf[i--] = '-';
    1318:	02d00793          	li	a5,45
    131c:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    1320:	4599                	li	a1,6
    1322:	b731                	j	122e <printint.constprop.0+0x126>

0000000000001324 <getchar>:
{
    1324:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1326:	00f10593          	addi	a1,sp,15
    132a:	4605                	li	a2,1
    132c:	4501                	li	a0,0
{
    132e:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1330:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1334:	191000ef          	jal	1cc4 <read>
}
    1338:	60e2                	ld	ra,24(sp)
    133a:	00f14503          	lbu	a0,15(sp)
    133e:	6105                	addi	sp,sp,32
    1340:	8082                	ret

0000000000001342 <putchar>:
{
    1342:	1101                	addi	sp,sp,-32
    1344:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1346:	00f10593          	addi	a1,sp,15
    134a:	4605                	li	a2,1
    134c:	4505                	li	a0,1
{
    134e:	ec06                	sd	ra,24(sp)
    char byte = c;
    1350:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1354:	17b000ef          	jal	1cce <write>
}
    1358:	60e2                	ld	ra,24(sp)
    135a:	2501                	sext.w	a0,a0
    135c:	6105                	addi	sp,sp,32
    135e:	8082                	ret

0000000000001360 <puts>:
{
    1360:	1141                	addi	sp,sp,-16
    1362:	e406                	sd	ra,8(sp)
    1364:	e022                	sd	s0,0(sp)
    1366:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1368:	582000ef          	jal	18ea <strlen>
    136c:	862a                	mv	a2,a0
    136e:	85a2                	mv	a1,s0
    1370:	4505                	li	a0,1
    1372:	15d000ef          	jal	1cce <write>
}
    1376:	60a2                	ld	ra,8(sp)
    1378:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    137a:	957d                	srai	a0,a0,0x3f
    return r;
    137c:	2501                	sext.w	a0,a0
}
    137e:	0141                	addi	sp,sp,16
    1380:	8082                	ret

0000000000001382 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1382:	7131                	addi	sp,sp,-192
    1384:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1386:	013c                	addi	a5,sp,136
{
    1388:	f0ca                	sd	s2,96(sp)
    138a:	ecce                	sd	s3,88(sp)
    138c:	e8d2                	sd	s4,80(sp)
    138e:	e4d6                	sd	s5,72(sp)
    1390:	e0da                	sd	s6,64(sp)
    1392:	fc5e                	sd	s7,56(sp)
    1394:	fc86                	sd	ra,120(sp)
    1396:	f8a2                	sd	s0,112(sp)
    1398:	f4a6                	sd	s1,104(sp)
    139a:	e52e                	sd	a1,136(sp)
    139c:	e932                	sd	a2,144(sp)
    139e:	ed36                	sd	a3,152(sp)
    13a0:	f13a                	sd	a4,160(sp)
    13a2:	f942                	sd	a6,176(sp)
    13a4:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    13a6:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    13a8:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    13ac:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    13b0:	00001b97          	auipc	s7,0x1
    13b4:	c38b8b93          	addi	s7,s7,-968 # 1fe8 <__clone+0xe2>
        switch (s[1])
    13b8:	07800a93          	li	s5,120
    13bc:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13c0:	00003997          	auipc	s3,0x3
    13c4:	c6098993          	addi	s3,s3,-928 # 4020 <digits>
        if (!*s)
    13c8:	00054783          	lbu	a5,0(a0)
    13cc:	16078c63          	beqz	a5,1544 <printf+0x1c2>
    13d0:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13d2:	19278463          	beq	a5,s2,155a <printf+0x1d8>
    13d6:	00164783          	lbu	a5,1(a2)
    13da:	0605                	addi	a2,a2,1
    13dc:	fbfd                	bnez	a5,13d2 <printf+0x50>
    13de:	84b2                	mv	s1,a2
        l = z - a;
    13e0:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13e4:	85aa                	mv	a1,a0
    13e6:	8622                	mv	a2,s0
    13e8:	4505                	li	a0,1
    13ea:	0e5000ef          	jal	1cce <write>
        if (l)
    13ee:	18041f63          	bnez	s0,158c <printf+0x20a>
        if (s[1] == 0)
    13f2:	0014c783          	lbu	a5,1(s1)
    13f6:	14078763          	beqz	a5,1544 <printf+0x1c2>
        switch (s[1])
    13fa:	1d478163          	beq	a5,s4,15bc <printf+0x23a>
    13fe:	18fa6963          	bltu	s4,a5,1590 <printf+0x20e>
    1402:	1b678363          	beq	a5,s6,15a8 <printf+0x226>
    1406:	07000713          	li	a4,112
    140a:	1ce79c63          	bne	a5,a4,15e2 <printf+0x260>
            printptr(va_arg(ap, uint64));
    140e:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    1410:	03000793          	li	a5,48
    1414:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    1418:	631c                	ld	a5,0(a4)
    141a:	0721                	addi	a4,a4,8
    141c:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    141e:	00479f93          	slli	t6,a5,0x4
    1422:	00879f13          	slli	t5,a5,0x8
    1426:	00c79e93          	slli	t4,a5,0xc
    142a:	01079e13          	slli	t3,a5,0x10
    142e:	01479313          	slli	t1,a5,0x14
    1432:	01879893          	slli	a7,a5,0x18
    1436:	01c79713          	slli	a4,a5,0x1c
    143a:	02479813          	slli	a6,a5,0x24
    143e:	02879513          	slli	a0,a5,0x28
    1442:	02c79593          	slli	a1,a5,0x2c
    1446:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    144a:	03c7d293          	srli	t0,a5,0x3c
    144e:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1452:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1456:	03cfdf93          	srli	t6,t6,0x3c
    145a:	03cf5f13          	srli	t5,t5,0x3c
    145e:	03cede93          	srli	t4,t4,0x3c
    1462:	03ce5e13          	srli	t3,t3,0x3c
    1466:	03c35313          	srli	t1,t1,0x3c
    146a:	03c8d893          	srli	a7,a7,0x3c
    146e:	9371                	srli	a4,a4,0x3c
    1470:	03c85813          	srli	a6,a6,0x3c
    1474:	9171                	srli	a0,a0,0x3c
    1476:	91f1                	srli	a1,a1,0x3c
    1478:	9271                	srli	a2,a2,0x3c
    147a:	974e                	add	a4,a4,s3
    147c:	92f1                	srli	a3,a3,0x3c
    147e:	92ce                	add	t0,t0,s3
    1480:	9fce                	add	t6,t6,s3
    1482:	9f4e                	add	t5,t5,s3
    1484:	9ece                	add	t4,t4,s3
    1486:	9e4e                	add	t3,t3,s3
    1488:	934e                	add	t1,t1,s3
    148a:	98ce                	add	a7,a7,s3
    148c:	93ce                	add	t2,t2,s3
    148e:	984e                	add	a6,a6,s3
    1490:	954e                	add	a0,a0,s3
    1492:	95ce                	add	a1,a1,s3
    1494:	964e                	add	a2,a2,s3
    1496:	0002c283          	lbu	t0,0(t0)
    149a:	000fcf83          	lbu	t6,0(t6)
    149e:	000f4f03          	lbu	t5,0(t5)
    14a2:	000ece83          	lbu	t4,0(t4)
    14a6:	000e4e03          	lbu	t3,0(t3)
    14aa:	00034303          	lbu	t1,0(t1)
    14ae:	0008c883          	lbu	a7,0(a7)
    14b2:	00074403          	lbu	s0,0(a4)
    14b6:	0003c383          	lbu	t2,0(t2)
    14ba:	00084803          	lbu	a6,0(a6)
    14be:	00054503          	lbu	a0,0(a0)
    14c2:	0005c583          	lbu	a1,0(a1)
    14c6:	00064603          	lbu	a2,0(a2)
    14ca:	00d98733          	add	a4,s3,a3
    14ce:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14d2:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14d6:	9371                	srli	a4,a4,0x3c
    14d8:	8bbd                	andi	a5,a5,15
    14da:	00510523          	sb	t0,10(sp)
    14de:	01f105a3          	sb	t6,11(sp)
    14e2:	01e10623          	sb	t5,12(sp)
    14e6:	01d106a3          	sb	t4,13(sp)
    14ea:	01c10723          	sb	t3,14(sp)
    14ee:	006107a3          	sb	t1,15(sp)
    14f2:	01110823          	sb	a7,16(sp)
    14f6:	00710923          	sb	t2,18(sp)
    14fa:	010109a3          	sb	a6,19(sp)
    14fe:	00a10a23          	sb	a0,20(sp)
    1502:	00b10aa3          	sb	a1,21(sp)
    1506:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    150a:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    150e:	008108a3          	sb	s0,17(sp)
    1512:	974e                	add	a4,a4,s3
    1514:	97ce                	add	a5,a5,s3
    1516:	00d10ba3          	sb	a3,23(sp)
    151a:	00074703          	lbu	a4,0(a4)
    151e:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1522:	4649                	li	a2,18
    1524:	002c                	addi	a1,sp,8
    1526:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1528:	00e10c23          	sb	a4,24(sp)
    152c:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1530:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1534:	79a000ef          	jal	1cce <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    1538:	00248513          	addi	a0,s1,2
        if (!*s)
    153c:	00054783          	lbu	a5,0(a0)
    1540:	e80798e3          	bnez	a5,13d0 <printf+0x4e>
    }
    va_end(ap);
}
    1544:	70e6                	ld	ra,120(sp)
    1546:	7446                	ld	s0,112(sp)
    1548:	74a6                	ld	s1,104(sp)
    154a:	7906                	ld	s2,96(sp)
    154c:	69e6                	ld	s3,88(sp)
    154e:	6a46                	ld	s4,80(sp)
    1550:	6aa6                	ld	s5,72(sp)
    1552:	6b06                	ld	s6,64(sp)
    1554:	7be2                	ld	s7,56(sp)
    1556:	6129                	addi	sp,sp,192
    1558:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    155a:	00064783          	lbu	a5,0(a2)
    155e:	84b2                	mv	s1,a2
    1560:	01278963          	beq	a5,s2,1572 <printf+0x1f0>
    1564:	bdb5                	j	13e0 <printf+0x5e>
    1566:	0024c783          	lbu	a5,2(s1)
    156a:	0605                	addi	a2,a2,1
    156c:	0489                	addi	s1,s1,2
    156e:	e72799e3          	bne	a5,s2,13e0 <printf+0x5e>
    1572:	0014c783          	lbu	a5,1(s1)
    1576:	ff2788e3          	beq	a5,s2,1566 <printf+0x1e4>
        l = z - a;
    157a:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    157e:	85aa                	mv	a1,a0
    1580:	8622                	mv	a2,s0
    1582:	4505                	li	a0,1
    1584:	74a000ef          	jal	1cce <write>
        if (l)
    1588:	e60405e3          	beqz	s0,13f2 <printf+0x70>
    158c:	8526                	mv	a0,s1
    158e:	bd2d                	j	13c8 <printf+0x46>
        switch (s[1])
    1590:	05579963          	bne	a5,s5,15e2 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1594:	6782                	ld	a5,0(sp)
    1596:	45c1                	li	a1,16
    1598:	4388                	lw	a0,0(a5)
    159a:	07a1                	addi	a5,a5,8
    159c:	e03e                	sd	a5,0(sp)
    159e:	b6bff0ef          	jal	1108 <printint.constprop.0>
        s += 2;
    15a2:	00248513          	addi	a0,s1,2
    15a6:	bf59                	j	153c <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    15a8:	6782                	ld	a5,0(sp)
    15aa:	45a9                	li	a1,10
    15ac:	4388                	lw	a0,0(a5)
    15ae:	07a1                	addi	a5,a5,8
    15b0:	e03e                	sd	a5,0(sp)
    15b2:	b57ff0ef          	jal	1108 <printint.constprop.0>
        s += 2;
    15b6:	00248513          	addi	a0,s1,2
    15ba:	b749                	j	153c <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    15bc:	6782                	ld	a5,0(sp)
    15be:	6380                	ld	s0,0(a5)
    15c0:	07a1                	addi	a5,a5,8
    15c2:	e03e                	sd	a5,0(sp)
    15c4:	c031                	beqz	s0,1608 <printf+0x286>
            l = strnlen(a, 200);
    15c6:	0c800593          	li	a1,200
    15ca:	8522                	mv	a0,s0
    15cc:	40a000ef          	jal	19d6 <strnlen>
    write(f, s, l);
    15d0:	0005061b          	sext.w	a2,a0
    15d4:	85a2                	mv	a1,s0
    15d6:	4505                	li	a0,1
    15d8:	6f6000ef          	jal	1cce <write>
        s += 2;
    15dc:	00248513          	addi	a0,s1,2
    15e0:	bfb1                	j	153c <printf+0x1ba>
    return write(stdout, &byte, 1);
    15e2:	4605                	li	a2,1
    15e4:	002c                	addi	a1,sp,8
    15e6:	4505                	li	a0,1
    char byte = c;
    15e8:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15ec:	6e2000ef          	jal	1cce <write>
    char byte = c;
    15f0:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15f4:	4605                	li	a2,1
    15f6:	002c                	addi	a1,sp,8
    15f8:	4505                	li	a0,1
    char byte = c;
    15fa:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15fe:	6d0000ef          	jal	1cce <write>
        s += 2;
    1602:	00248513          	addi	a0,s1,2
    1606:	bf1d                	j	153c <printf+0x1ba>
                a = "(null)";
    1608:	845e                	mv	s0,s7
    160a:	bf75                	j	15c6 <printf+0x244>

000000000000160c <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    160c:	1141                	addi	sp,sp,-16
    160e:	e406                	sd	ra,8(sp)
    puts(m);
    1610:	d51ff0ef          	jal	1360 <puts>
    exit(-100);
}
    1614:	60a2                	ld	ra,8(sp)
    exit(-100);
    1616:	f9c00513          	li	a0,-100
}
    161a:	0141                	addi	sp,sp,16
    exit(-100);
    161c:	a709                	j	1d1e <exit>

000000000000161e <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    161e:	02000793          	li	a5,32
    1622:	00f50663          	beq	a0,a5,162e <isspace+0x10>
    1626:	355d                	addiw	a0,a0,-9
    1628:	00553513          	sltiu	a0,a0,5
    162c:	8082                	ret
    162e:	4505                	li	a0,1
}
    1630:	8082                	ret

0000000000001632 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1632:	fd05051b          	addiw	a0,a0,-48
}
    1636:	00a53513          	sltiu	a0,a0,10
    163a:	8082                	ret

000000000000163c <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    163c:	02000613          	li	a2,32
    1640:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1642:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1646:	ff77069b          	addiw	a3,a4,-9
    164a:	04c70d63          	beq	a4,a2,16a4 <atoi+0x68>
    164e:	0007079b          	sext.w	a5,a4
    1652:	04d5f963          	bgeu	a1,a3,16a4 <atoi+0x68>
        s++;
    switch (*s)
    1656:	02b00693          	li	a3,43
    165a:	04d70a63          	beq	a4,a3,16ae <atoi+0x72>
    165e:	02d00693          	li	a3,45
    1662:	06d70463          	beq	a4,a3,16ca <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1666:	fd07859b          	addiw	a1,a5,-48
    166a:	4625                	li	a2,9
    166c:	873e                	mv	a4,a5
    166e:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1670:	4e01                	li	t3,0
    while (isdigit(*s))
    1672:	04b66a63          	bltu	a2,a1,16c6 <atoi+0x8a>
    int n = 0, neg = 0;
    1676:	4501                	li	a0,0
    while (isdigit(*s))
    1678:	4825                	li	a6,9
    167a:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    167e:	0025179b          	slliw	a5,a0,0x2
    1682:	9d3d                	addw	a0,a0,a5
    1684:	fd07031b          	addiw	t1,a4,-48
    1688:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    168c:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1690:	0685                	addi	a3,a3,1
    1692:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1696:	0006071b          	sext.w	a4,a2
    169a:	feb870e3          	bgeu	a6,a1,167a <atoi+0x3e>
    return neg ? n : -n;
    169e:	000e0563          	beqz	t3,16a8 <atoi+0x6c>
}
    16a2:	8082                	ret
        s++;
    16a4:	0505                	addi	a0,a0,1
    16a6:	bf71                	j	1642 <atoi+0x6>
    return neg ? n : -n;
    16a8:	4113053b          	subw	a0,t1,a7
    16ac:	8082                	ret
    while (isdigit(*s))
    16ae:	00154783          	lbu	a5,1(a0)
    16b2:	4625                	li	a2,9
        s++;
    16b4:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16b8:	fd07859b          	addiw	a1,a5,-48
    16bc:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16c0:	4e01                	li	t3,0
    while (isdigit(*s))
    16c2:	fab67ae3          	bgeu	a2,a1,1676 <atoi+0x3a>
    16c6:	4501                	li	a0,0
}
    16c8:	8082                	ret
    while (isdigit(*s))
    16ca:	00154783          	lbu	a5,1(a0)
    16ce:	4625                	li	a2,9
        s++;
    16d0:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16d4:	fd07859b          	addiw	a1,a5,-48
    16d8:	0007871b          	sext.w	a4,a5
    16dc:	feb665e3          	bltu	a2,a1,16c6 <atoi+0x8a>
        neg = 1;
    16e0:	4e05                	li	t3,1
    16e2:	bf51                	j	1676 <atoi+0x3a>

00000000000016e4 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16e4:	16060d63          	beqz	a2,185e <memset+0x17a>
    16e8:	40a007b3          	neg	a5,a0
    16ec:	8b9d                	andi	a5,a5,7
    16ee:	00778713          	addi	a4,a5,7
    16f2:	482d                	li	a6,11
    16f4:	0ff5f593          	zext.b	a1,a1
    16f8:	fff60693          	addi	a3,a2,-1
    16fc:	17076263          	bltu	a4,a6,1860 <memset+0x17c>
    1700:	16e6ea63          	bltu	a3,a4,1874 <memset+0x190>
    1704:	16078563          	beqz	a5,186e <memset+0x18a>
    1708:	00b50023          	sb	a1,0(a0)
    170c:	4705                	li	a4,1
    170e:	00150e93          	addi	t4,a0,1
    1712:	14e78c63          	beq	a5,a4,186a <memset+0x186>
    1716:	00b500a3          	sb	a1,1(a0)
    171a:	4709                	li	a4,2
    171c:	00250e93          	addi	t4,a0,2
    1720:	14e78d63          	beq	a5,a4,187a <memset+0x196>
    1724:	00b50123          	sb	a1,2(a0)
    1728:	470d                	li	a4,3
    172a:	00350e93          	addi	t4,a0,3
    172e:	12e78b63          	beq	a5,a4,1864 <memset+0x180>
    1732:	00b501a3          	sb	a1,3(a0)
    1736:	4711                	li	a4,4
    1738:	00450e93          	addi	t4,a0,4
    173c:	14e78163          	beq	a5,a4,187e <memset+0x19a>
    1740:	00b50223          	sb	a1,4(a0)
    1744:	4715                	li	a4,5
    1746:	00550e93          	addi	t4,a0,5
    174a:	12e78c63          	beq	a5,a4,1882 <memset+0x19e>
    174e:	00b502a3          	sb	a1,5(a0)
    1752:	471d                	li	a4,7
    1754:	00650e93          	addi	t4,a0,6
    1758:	12e79763          	bne	a5,a4,1886 <memset+0x1a2>
    175c:	00750e93          	addi	t4,a0,7
    1760:	00b50323          	sb	a1,6(a0)
    1764:	4f1d                	li	t5,7
    1766:	00859713          	slli	a4,a1,0x8
    176a:	8f4d                	or	a4,a4,a1
    176c:	01059e13          	slli	t3,a1,0x10
    1770:	01c76e33          	or	t3,a4,t3
    1774:	01859313          	slli	t1,a1,0x18
    1778:	006e6333          	or	t1,t3,t1
    177c:	02059893          	slli	a7,a1,0x20
    1780:	011368b3          	or	a7,t1,a7
    1784:	02859813          	slli	a6,a1,0x28
    1788:	40f60333          	sub	t1,a2,a5
    178c:	0108e833          	or	a6,a7,a6
    1790:	03059693          	slli	a3,a1,0x30
    1794:	00d866b3          	or	a3,a6,a3
    1798:	03859713          	slli	a4,a1,0x38
    179c:	97aa                	add	a5,a5,a0
    179e:	ff837813          	andi	a6,t1,-8
    17a2:	8f55                	or	a4,a4,a3
    17a4:	00f806b3          	add	a3,a6,a5
    17a8:	e398                	sd	a4,0(a5)
    17aa:	07a1                	addi	a5,a5,8
    17ac:	fed79ee3          	bne	a5,a3,17a8 <memset+0xc4>
    17b0:	ff837693          	andi	a3,t1,-8
    17b4:	00de87b3          	add	a5,t4,a3
    17b8:	01e6873b          	addw	a4,a3,t5
    17bc:	0ad30663          	beq	t1,a3,1868 <memset+0x184>
    17c0:	00b78023          	sb	a1,0(a5)
    17c4:	0017069b          	addiw	a3,a4,1
    17c8:	08c6fb63          	bgeu	a3,a2,185e <memset+0x17a>
    17cc:	00b780a3          	sb	a1,1(a5)
    17d0:	0027069b          	addiw	a3,a4,2
    17d4:	08c6f563          	bgeu	a3,a2,185e <memset+0x17a>
    17d8:	00b78123          	sb	a1,2(a5)
    17dc:	0037069b          	addiw	a3,a4,3
    17e0:	06c6ff63          	bgeu	a3,a2,185e <memset+0x17a>
    17e4:	00b781a3          	sb	a1,3(a5)
    17e8:	0047069b          	addiw	a3,a4,4
    17ec:	06c6f963          	bgeu	a3,a2,185e <memset+0x17a>
    17f0:	00b78223          	sb	a1,4(a5)
    17f4:	0057069b          	addiw	a3,a4,5
    17f8:	06c6f363          	bgeu	a3,a2,185e <memset+0x17a>
    17fc:	00b782a3          	sb	a1,5(a5)
    1800:	0067069b          	addiw	a3,a4,6
    1804:	04c6fd63          	bgeu	a3,a2,185e <memset+0x17a>
    1808:	00b78323          	sb	a1,6(a5)
    180c:	0077069b          	addiw	a3,a4,7
    1810:	04c6f763          	bgeu	a3,a2,185e <memset+0x17a>
    1814:	00b783a3          	sb	a1,7(a5)
    1818:	0087069b          	addiw	a3,a4,8
    181c:	04c6f163          	bgeu	a3,a2,185e <memset+0x17a>
    1820:	00b78423          	sb	a1,8(a5)
    1824:	0097069b          	addiw	a3,a4,9
    1828:	02c6fb63          	bgeu	a3,a2,185e <memset+0x17a>
    182c:	00b784a3          	sb	a1,9(a5)
    1830:	00a7069b          	addiw	a3,a4,10
    1834:	02c6f563          	bgeu	a3,a2,185e <memset+0x17a>
    1838:	00b78523          	sb	a1,10(a5)
    183c:	00b7069b          	addiw	a3,a4,11
    1840:	00c6ff63          	bgeu	a3,a2,185e <memset+0x17a>
    1844:	00b785a3          	sb	a1,11(a5)
    1848:	00c7069b          	addiw	a3,a4,12
    184c:	00c6f963          	bgeu	a3,a2,185e <memset+0x17a>
    1850:	00b78623          	sb	a1,12(a5)
    1854:	2735                	addiw	a4,a4,13
    1856:	00c77463          	bgeu	a4,a2,185e <memset+0x17a>
    185a:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    185e:	8082                	ret
    1860:	472d                	li	a4,11
    1862:	bd79                	j	1700 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1864:	4f0d                	li	t5,3
    1866:	b701                	j	1766 <memset+0x82>
    1868:	8082                	ret
    186a:	4f05                	li	t5,1
    186c:	bded                	j	1766 <memset+0x82>
    186e:	8eaa                	mv	t4,a0
    1870:	4f01                	li	t5,0
    1872:	bdd5                	j	1766 <memset+0x82>
    1874:	87aa                	mv	a5,a0
    1876:	4701                	li	a4,0
    1878:	b7a1                	j	17c0 <memset+0xdc>
    187a:	4f09                	li	t5,2
    187c:	b5ed                	j	1766 <memset+0x82>
    187e:	4f11                	li	t5,4
    1880:	b5dd                	j	1766 <memset+0x82>
    1882:	4f15                	li	t5,5
    1884:	b5cd                	j	1766 <memset+0x82>
    1886:	4f19                	li	t5,6
    1888:	bdf9                	j	1766 <memset+0x82>

000000000000188a <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    188a:	00054783          	lbu	a5,0(a0)
    188e:	0005c703          	lbu	a4,0(a1)
    1892:	00e79863          	bne	a5,a4,18a2 <strcmp+0x18>
    1896:	0505                	addi	a0,a0,1
    1898:	0585                	addi	a1,a1,1
    189a:	fbe5                	bnez	a5,188a <strcmp>
    189c:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    189e:	9d19                	subw	a0,a0,a4
    18a0:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    18a2:	0007851b          	sext.w	a0,a5
    18a6:	bfe5                	j	189e <strcmp+0x14>

00000000000018a8 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    18a8:	ce05                	beqz	a2,18e0 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18aa:	00054703          	lbu	a4,0(a0)
    18ae:	0005c783          	lbu	a5,0(a1)
    18b2:	cb0d                	beqz	a4,18e4 <strncmp+0x3c>
    if (!n--)
    18b4:	167d                	addi	a2,a2,-1
    18b6:	00c506b3          	add	a3,a0,a2
    18ba:	a819                	j	18d0 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18bc:	00a68e63          	beq	a3,a0,18d8 <strncmp+0x30>
    18c0:	0505                	addi	a0,a0,1
    18c2:	00e79b63          	bne	a5,a4,18d8 <strncmp+0x30>
    18c6:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18ca:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18ce:	cb19                	beqz	a4,18e4 <strncmp+0x3c>
    18d0:	0005c783          	lbu	a5,0(a1)
    18d4:	0585                	addi	a1,a1,1
    18d6:	f3fd                	bnez	a5,18bc <strncmp+0x14>
    return *l - *r;
    18d8:	0007051b          	sext.w	a0,a4
    18dc:	9d1d                	subw	a0,a0,a5
    18de:	8082                	ret
        return 0;
    18e0:	4501                	li	a0,0
}
    18e2:	8082                	ret
    18e4:	4501                	li	a0,0
    return *l - *r;
    18e6:	9d1d                	subw	a0,a0,a5
    18e8:	8082                	ret

00000000000018ea <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18ea:	00757793          	andi	a5,a0,7
    18ee:	cf89                	beqz	a5,1908 <strlen+0x1e>
    18f0:	87aa                	mv	a5,a0
    18f2:	a029                	j	18fc <strlen+0x12>
    18f4:	0785                	addi	a5,a5,1
    18f6:	0077f713          	andi	a4,a5,7
    18fa:	cb01                	beqz	a4,190a <strlen+0x20>
        if (!*s)
    18fc:	0007c703          	lbu	a4,0(a5)
    1900:	fb75                	bnez	a4,18f4 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    1902:	40a78533          	sub	a0,a5,a0
}
    1906:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1908:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    190a:	6394                	ld	a3,0(a5)
    190c:	00000597          	auipc	a1,0x0
    1910:	6e45b583          	ld	a1,1764(a1) # 1ff0 <__clone+0xea>
    1914:	00000617          	auipc	a2,0x0
    1918:	6e463603          	ld	a2,1764(a2) # 1ff8 <__clone+0xf2>
    191c:	a019                	j	1922 <strlen+0x38>
    191e:	6794                	ld	a3,8(a5)
    1920:	07a1                	addi	a5,a5,8
    1922:	00b68733          	add	a4,a3,a1
    1926:	fff6c693          	not	a3,a3
    192a:	8f75                	and	a4,a4,a3
    192c:	8f71                	and	a4,a4,a2
    192e:	db65                	beqz	a4,191e <strlen+0x34>
    for (; *s; s++)
    1930:	0007c703          	lbu	a4,0(a5)
    1934:	d779                	beqz	a4,1902 <strlen+0x18>
    1936:	0017c703          	lbu	a4,1(a5)
    193a:	0785                	addi	a5,a5,1
    193c:	d379                	beqz	a4,1902 <strlen+0x18>
    193e:	0017c703          	lbu	a4,1(a5)
    1942:	0785                	addi	a5,a5,1
    1944:	fb6d                	bnez	a4,1936 <strlen+0x4c>
    1946:	bf75                	j	1902 <strlen+0x18>

0000000000001948 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1948:	00757713          	andi	a4,a0,7
{
    194c:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    194e:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1952:	cb19                	beqz	a4,1968 <memchr+0x20>
    1954:	ce25                	beqz	a2,19cc <memchr+0x84>
    1956:	0007c703          	lbu	a4,0(a5)
    195a:	04b70e63          	beq	a4,a1,19b6 <memchr+0x6e>
    195e:	0785                	addi	a5,a5,1
    1960:	0077f713          	andi	a4,a5,7
    1964:	167d                	addi	a2,a2,-1
    1966:	f77d                	bnez	a4,1954 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1968:	4501                	li	a0,0
    if (n && *s != c)
    196a:	c235                	beqz	a2,19ce <memchr+0x86>
    196c:	0007c703          	lbu	a4,0(a5)
    1970:	04b70363          	beq	a4,a1,19b6 <memchr+0x6e>
        size_t k = ONES * c;
    1974:	00000517          	auipc	a0,0x0
    1978:	68c53503          	ld	a0,1676(a0) # 2000 <__clone+0xfa>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    197c:	471d                	li	a4,7
        size_t k = ONES * c;
    197e:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1982:	02c77a63          	bgeu	a4,a2,19b6 <memchr+0x6e>
    1986:	00000897          	auipc	a7,0x0
    198a:	66a8b883          	ld	a7,1642(a7) # 1ff0 <__clone+0xea>
    198e:	00000817          	auipc	a6,0x0
    1992:	66a83803          	ld	a6,1642(a6) # 1ff8 <__clone+0xf2>
    1996:	431d                	li	t1,7
    1998:	a029                	j	19a2 <memchr+0x5a>
    199a:	1661                	addi	a2,a2,-8
    199c:	07a1                	addi	a5,a5,8
    199e:	02c37963          	bgeu	t1,a2,19d0 <memchr+0x88>
    19a2:	6398                	ld	a4,0(a5)
    19a4:	8f29                	xor	a4,a4,a0
    19a6:	011706b3          	add	a3,a4,a7
    19aa:	fff74713          	not	a4,a4
    19ae:	8f75                	and	a4,a4,a3
    19b0:	01077733          	and	a4,a4,a6
    19b4:	d37d                	beqz	a4,199a <memchr+0x52>
    19b6:	853e                	mv	a0,a5
    19b8:	97b2                	add	a5,a5,a2
    19ba:	a021                	j	19c2 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19bc:	0505                	addi	a0,a0,1
    19be:	00f50763          	beq	a0,a5,19cc <memchr+0x84>
    19c2:	00054703          	lbu	a4,0(a0)
    19c6:	feb71be3          	bne	a4,a1,19bc <memchr+0x74>
    19ca:	8082                	ret
    return n ? (void *)s : 0;
    19cc:	4501                	li	a0,0
}
    19ce:	8082                	ret
    return n ? (void *)s : 0;
    19d0:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19d2:	f275                	bnez	a2,19b6 <memchr+0x6e>
}
    19d4:	8082                	ret

00000000000019d6 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19d6:	1101                	addi	sp,sp,-32
    19d8:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19da:	862e                	mv	a2,a1
{
    19dc:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19de:	4581                	li	a1,0
{
    19e0:	e426                	sd	s1,8(sp)
    19e2:	ec06                	sd	ra,24(sp)
    19e4:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19e6:	f63ff0ef          	jal	1948 <memchr>
    return p ? p - s : n;
    19ea:	c519                	beqz	a0,19f8 <strnlen+0x22>
}
    19ec:	60e2                	ld	ra,24(sp)
    19ee:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19f0:	8d05                	sub	a0,a0,s1
}
    19f2:	64a2                	ld	s1,8(sp)
    19f4:	6105                	addi	sp,sp,32
    19f6:	8082                	ret
    19f8:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19fa:	8522                	mv	a0,s0
}
    19fc:	6442                	ld	s0,16(sp)
    19fe:	64a2                	ld	s1,8(sp)
    1a00:	6105                	addi	sp,sp,32
    1a02:	8082                	ret

0000000000001a04 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    1a04:	00b547b3          	xor	a5,a0,a1
    1a08:	8b9d                	andi	a5,a5,7
    1a0a:	eb95                	bnez	a5,1a3e <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    1a0c:	0075f793          	andi	a5,a1,7
    1a10:	e7b1                	bnez	a5,1a5c <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a12:	6198                	ld	a4,0(a1)
    1a14:	00000617          	auipc	a2,0x0
    1a18:	5dc63603          	ld	a2,1500(a2) # 1ff0 <__clone+0xea>
    1a1c:	00000817          	auipc	a6,0x0
    1a20:	5dc83803          	ld	a6,1500(a6) # 1ff8 <__clone+0xf2>
    1a24:	a029                	j	1a2e <strcpy+0x2a>
    1a26:	e118                	sd	a4,0(a0)
    1a28:	6598                	ld	a4,8(a1)
    1a2a:	05a1                	addi	a1,a1,8
    1a2c:	0521                	addi	a0,a0,8
    1a2e:	00c707b3          	add	a5,a4,a2
    1a32:	fff74693          	not	a3,a4
    1a36:	8ff5                	and	a5,a5,a3
    1a38:	0107f7b3          	and	a5,a5,a6
    1a3c:	d7ed                	beqz	a5,1a26 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a3e:	0005c783          	lbu	a5,0(a1)
    1a42:	00f50023          	sb	a5,0(a0)
    1a46:	c785                	beqz	a5,1a6e <strcpy+0x6a>
    1a48:	0015c783          	lbu	a5,1(a1)
    1a4c:	0505                	addi	a0,a0,1
    1a4e:	0585                	addi	a1,a1,1
    1a50:	00f50023          	sb	a5,0(a0)
    1a54:	fbf5                	bnez	a5,1a48 <strcpy+0x44>
        ;
    return d;
}
    1a56:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a58:	0505                	addi	a0,a0,1
    1a5a:	df45                	beqz	a4,1a12 <strcpy+0xe>
            if (!(*d = *s))
    1a5c:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a60:	0585                	addi	a1,a1,1
    1a62:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a66:	00f50023          	sb	a5,0(a0)
    1a6a:	f7fd                	bnez	a5,1a58 <strcpy+0x54>
}
    1a6c:	8082                	ret
    1a6e:	8082                	ret

0000000000001a70 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a70:	00b547b3          	xor	a5,a0,a1
    1a74:	8b9d                	andi	a5,a5,7
    1a76:	1a079863          	bnez	a5,1c26 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a7a:	0075f793          	andi	a5,a1,7
    1a7e:	16078463          	beqz	a5,1be6 <strncpy+0x176>
    1a82:	ea01                	bnez	a2,1a92 <strncpy+0x22>
    1a84:	a421                	j	1c8c <strncpy+0x21c>
    1a86:	167d                	addi	a2,a2,-1
    1a88:	0505                	addi	a0,a0,1
    1a8a:	14070e63          	beqz	a4,1be6 <strncpy+0x176>
    1a8e:	1a060863          	beqz	a2,1c3e <strncpy+0x1ce>
    1a92:	0005c783          	lbu	a5,0(a1)
    1a96:	0585                	addi	a1,a1,1
    1a98:	0075f713          	andi	a4,a1,7
    1a9c:	00f50023          	sb	a5,0(a0)
    1aa0:	f3fd                	bnez	a5,1a86 <strncpy+0x16>
    1aa2:	4805                	li	a6,1
    1aa4:	1a061863          	bnez	a2,1c54 <strncpy+0x1e4>
    1aa8:	40a007b3          	neg	a5,a0
    1aac:	8b9d                	andi	a5,a5,7
    1aae:	4681                	li	a3,0
    1ab0:	18061a63          	bnez	a2,1c44 <strncpy+0x1d4>
    1ab4:	00778713          	addi	a4,a5,7
    1ab8:	45ad                	li	a1,11
    1aba:	18b76363          	bltu	a4,a1,1c40 <strncpy+0x1d0>
    1abe:	1ae6eb63          	bltu	a3,a4,1c74 <strncpy+0x204>
    1ac2:	1a078363          	beqz	a5,1c68 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1ac6:	00050023          	sb	zero,0(a0)
    1aca:	4685                	li	a3,1
    1acc:	00150713          	addi	a4,a0,1
    1ad0:	18d78f63          	beq	a5,a3,1c6e <strncpy+0x1fe>
    1ad4:	000500a3          	sb	zero,1(a0)
    1ad8:	4689                	li	a3,2
    1ada:	00250713          	addi	a4,a0,2
    1ade:	18d78e63          	beq	a5,a3,1c7a <strncpy+0x20a>
    1ae2:	00050123          	sb	zero,2(a0)
    1ae6:	468d                	li	a3,3
    1ae8:	00350713          	addi	a4,a0,3
    1aec:	16d78c63          	beq	a5,a3,1c64 <strncpy+0x1f4>
    1af0:	000501a3          	sb	zero,3(a0)
    1af4:	4691                	li	a3,4
    1af6:	00450713          	addi	a4,a0,4
    1afa:	18d78263          	beq	a5,a3,1c7e <strncpy+0x20e>
    1afe:	00050223          	sb	zero,4(a0)
    1b02:	4695                	li	a3,5
    1b04:	00550713          	addi	a4,a0,5
    1b08:	16d78d63          	beq	a5,a3,1c82 <strncpy+0x212>
    1b0c:	000502a3          	sb	zero,5(a0)
    1b10:	469d                	li	a3,7
    1b12:	00650713          	addi	a4,a0,6
    1b16:	16d79863          	bne	a5,a3,1c86 <strncpy+0x216>
    1b1a:	00750713          	addi	a4,a0,7
    1b1e:	00050323          	sb	zero,6(a0)
    1b22:	40f80833          	sub	a6,a6,a5
    1b26:	ff887593          	andi	a1,a6,-8
    1b2a:	97aa                	add	a5,a5,a0
    1b2c:	95be                	add	a1,a1,a5
    1b2e:	0007b023          	sd	zero,0(a5)
    1b32:	07a1                	addi	a5,a5,8
    1b34:	feb79de3          	bne	a5,a1,1b2e <strncpy+0xbe>
    1b38:	ff887593          	andi	a1,a6,-8
    1b3c:	9ead                	addw	a3,a3,a1
    1b3e:	00b707b3          	add	a5,a4,a1
    1b42:	12b80863          	beq	a6,a1,1c72 <strncpy+0x202>
    1b46:	00078023          	sb	zero,0(a5)
    1b4a:	0016871b          	addiw	a4,a3,1
    1b4e:	0ec77863          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1b52:	000780a3          	sb	zero,1(a5)
    1b56:	0026871b          	addiw	a4,a3,2
    1b5a:	0ec77263          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1b5e:	00078123          	sb	zero,2(a5)
    1b62:	0036871b          	addiw	a4,a3,3
    1b66:	0cc77c63          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1b6a:	000781a3          	sb	zero,3(a5)
    1b6e:	0046871b          	addiw	a4,a3,4
    1b72:	0cc77663          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1b76:	00078223          	sb	zero,4(a5)
    1b7a:	0056871b          	addiw	a4,a3,5
    1b7e:	0cc77063          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1b82:	000782a3          	sb	zero,5(a5)
    1b86:	0066871b          	addiw	a4,a3,6
    1b8a:	0ac77a63          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1b8e:	00078323          	sb	zero,6(a5)
    1b92:	0076871b          	addiw	a4,a3,7
    1b96:	0ac77463          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1b9a:	000783a3          	sb	zero,7(a5)
    1b9e:	0086871b          	addiw	a4,a3,8
    1ba2:	08c77e63          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1ba6:	00078423          	sb	zero,8(a5)
    1baa:	0096871b          	addiw	a4,a3,9
    1bae:	08c77863          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1bb2:	000784a3          	sb	zero,9(a5)
    1bb6:	00a6871b          	addiw	a4,a3,10
    1bba:	08c77263          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1bbe:	00078523          	sb	zero,10(a5)
    1bc2:	00b6871b          	addiw	a4,a3,11
    1bc6:	06c77c63          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1bca:	000785a3          	sb	zero,11(a5)
    1bce:	00c6871b          	addiw	a4,a3,12
    1bd2:	06c77663          	bgeu	a4,a2,1c3e <strncpy+0x1ce>
    1bd6:	00078623          	sb	zero,12(a5)
    1bda:	26b5                	addiw	a3,a3,13
    1bdc:	06c6f163          	bgeu	a3,a2,1c3e <strncpy+0x1ce>
    1be0:	000786a3          	sb	zero,13(a5)
    1be4:	8082                	ret
            ;
        if (!n || !*s)
    1be6:	c645                	beqz	a2,1c8e <strncpy+0x21e>
    1be8:	0005c783          	lbu	a5,0(a1)
    1bec:	ea078be3          	beqz	a5,1aa2 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bf0:	479d                	li	a5,7
    1bf2:	02c7ff63          	bgeu	a5,a2,1c30 <strncpy+0x1c0>
    1bf6:	00000897          	auipc	a7,0x0
    1bfa:	3fa8b883          	ld	a7,1018(a7) # 1ff0 <__clone+0xea>
    1bfe:	00000817          	auipc	a6,0x0
    1c02:	3fa83803          	ld	a6,1018(a6) # 1ff8 <__clone+0xf2>
    1c06:	431d                	li	t1,7
    1c08:	6198                	ld	a4,0(a1)
    1c0a:	011707b3          	add	a5,a4,a7
    1c0e:	fff74693          	not	a3,a4
    1c12:	8ff5                	and	a5,a5,a3
    1c14:	0107f7b3          	and	a5,a5,a6
    1c18:	ef81                	bnez	a5,1c30 <strncpy+0x1c0>
            *wd = *ws;
    1c1a:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c1c:	1661                	addi	a2,a2,-8
    1c1e:	05a1                	addi	a1,a1,8
    1c20:	0521                	addi	a0,a0,8
    1c22:	fec363e3          	bltu	t1,a2,1c08 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c26:	e609                	bnez	a2,1c30 <strncpy+0x1c0>
    1c28:	a08d                	j	1c8a <strncpy+0x21a>
    1c2a:	167d                	addi	a2,a2,-1
    1c2c:	0505                	addi	a0,a0,1
    1c2e:	ca01                	beqz	a2,1c3e <strncpy+0x1ce>
    1c30:	0005c783          	lbu	a5,0(a1)
    1c34:	0585                	addi	a1,a1,1
    1c36:	00f50023          	sb	a5,0(a0)
    1c3a:	fbe5                	bnez	a5,1c2a <strncpy+0x1ba>
        ;
tail:
    1c3c:	b59d                	j	1aa2 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c3e:	8082                	ret
    1c40:	472d                	li	a4,11
    1c42:	bdb5                	j	1abe <strncpy+0x4e>
    1c44:	00778713          	addi	a4,a5,7
    1c48:	45ad                	li	a1,11
    1c4a:	fff60693          	addi	a3,a2,-1
    1c4e:	e6b778e3          	bgeu	a4,a1,1abe <strncpy+0x4e>
    1c52:	b7fd                	j	1c40 <strncpy+0x1d0>
    1c54:	40a007b3          	neg	a5,a0
    1c58:	8832                	mv	a6,a2
    1c5a:	8b9d                	andi	a5,a5,7
    1c5c:	4681                	li	a3,0
    1c5e:	e4060be3          	beqz	a2,1ab4 <strncpy+0x44>
    1c62:	b7cd                	j	1c44 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c64:	468d                	li	a3,3
    1c66:	bd75                	j	1b22 <strncpy+0xb2>
    1c68:	872a                	mv	a4,a0
    1c6a:	4681                	li	a3,0
    1c6c:	bd5d                	j	1b22 <strncpy+0xb2>
    1c6e:	4685                	li	a3,1
    1c70:	bd4d                	j	1b22 <strncpy+0xb2>
    1c72:	8082                	ret
    1c74:	87aa                	mv	a5,a0
    1c76:	4681                	li	a3,0
    1c78:	b5f9                	j	1b46 <strncpy+0xd6>
    1c7a:	4689                	li	a3,2
    1c7c:	b55d                	j	1b22 <strncpy+0xb2>
    1c7e:	4691                	li	a3,4
    1c80:	b54d                	j	1b22 <strncpy+0xb2>
    1c82:	4695                	li	a3,5
    1c84:	bd79                	j	1b22 <strncpy+0xb2>
    1c86:	4699                	li	a3,6
    1c88:	bd69                	j	1b22 <strncpy+0xb2>
    1c8a:	8082                	ret
    1c8c:	8082                	ret
    1c8e:	8082                	ret

0000000000001c90 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c90:	87aa                	mv	a5,a0
    1c92:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c94:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c98:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c9c:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c9e:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ca0:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1ca4:	2501                	sext.w	a0,a0
    1ca6:	8082                	ret

0000000000001ca8 <openat>:
    register long a7 __asm__("a7") = n;
    1ca8:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1cac:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cb0:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1cb4:	2501                	sext.w	a0,a0
    1cb6:	8082                	ret

0000000000001cb8 <close>:
    register long a7 __asm__("a7") = n;
    1cb8:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cbc:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cc0:	2501                	sext.w	a0,a0
    1cc2:	8082                	ret

0000000000001cc4 <read>:
    register long a7 __asm__("a7") = n;
    1cc4:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cc8:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1ccc:	8082                	ret

0000000000001cce <write>:
    register long a7 __asm__("a7") = n;
    1cce:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cd2:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cd6:	8082                	ret

0000000000001cd8 <getpid>:
    register long a7 __asm__("a7") = n;
    1cd8:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cdc:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1ce0:	2501                	sext.w	a0,a0
    1ce2:	8082                	ret

0000000000001ce4 <getppid>:
    register long a7 __asm__("a7") = n;
    1ce4:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1ce8:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cec:	2501                	sext.w	a0,a0
    1cee:	8082                	ret

0000000000001cf0 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cf0:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cf4:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cf8:	2501                	sext.w	a0,a0
    1cfa:	8082                	ret

0000000000001cfc <fork>:
    register long a7 __asm__("a7") = n;
    1cfc:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1d00:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1d02:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d04:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1d08:	2501                	sext.w	a0,a0
    1d0a:	8082                	ret

0000000000001d0c <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1d0c:	85b2                	mv	a1,a2
    1d0e:	863a                	mv	a2,a4
    if (stack)
    1d10:	c191                	beqz	a1,1d14 <clone+0x8>
	stack += stack_size;
    1d12:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d14:	4781                	li	a5,0
    1d16:	4701                	li	a4,0
    1d18:	4681                	li	a3,0
    1d1a:	2601                	sext.w	a2,a2
    1d1c:	a2ed                	j	1f06 <__clone>

0000000000001d1e <exit>:
    register long a7 __asm__("a7") = n;
    1d1e:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d22:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d26:	8082                	ret

0000000000001d28 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d28:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d2c:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d2e:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d32:	2501                	sext.w	a0,a0
    1d34:	8082                	ret

0000000000001d36 <exec>:
    register long a7 __asm__("a7") = n;
    1d36:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d3a:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d3e:	2501                	sext.w	a0,a0
    1d40:	8082                	ret

0000000000001d42 <execve>:
    register long a7 __asm__("a7") = n;
    1d42:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d46:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d4a:	2501                	sext.w	a0,a0
    1d4c:	8082                	ret

0000000000001d4e <times>:
    register long a7 __asm__("a7") = n;
    1d4e:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d52:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d56:	2501                	sext.w	a0,a0
    1d58:	8082                	ret

0000000000001d5a <get_time>:

int64 get_time()
{
    1d5a:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d5c:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d60:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d62:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d64:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d68:	2501                	sext.w	a0,a0
    1d6a:	ed09                	bnez	a0,1d84 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d6c:	67a2                	ld	a5,8(sp)
    1d6e:	3e800713          	li	a4,1000
    1d72:	00015503          	lhu	a0,0(sp)
    1d76:	02e7d7b3          	divu	a5,a5,a4
    1d7a:	02e50533          	mul	a0,a0,a4
    1d7e:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d80:	0141                	addi	sp,sp,16
    1d82:	8082                	ret
        return -1;
    1d84:	557d                	li	a0,-1
    1d86:	bfed                	j	1d80 <get_time+0x26>

0000000000001d88 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d88:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d8c:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d90:	2501                	sext.w	a0,a0
    1d92:	8082                	ret

0000000000001d94 <time>:
    register long a7 __asm__("a7") = n;
    1d94:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d98:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d9c:	2501                	sext.w	a0,a0
    1d9e:	8082                	ret

0000000000001da0 <sleep>:

int sleep(unsigned long long time)
{
    1da0:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1da2:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1da4:	850a                	mv	a0,sp
    1da6:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1da8:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1dac:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dae:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1db2:	e501                	bnez	a0,1dba <sleep+0x1a>
    return 0;
    1db4:	4501                	li	a0,0
}
    1db6:	0141                	addi	sp,sp,16
    1db8:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dba:	4502                	lw	a0,0(sp)
}
    1dbc:	0141                	addi	sp,sp,16
    1dbe:	8082                	ret

0000000000001dc0 <set_priority>:
    register long a7 __asm__("a7") = n;
    1dc0:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1dc4:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1dc8:	2501                	sext.w	a0,a0
    1dca:	8082                	ret

0000000000001dcc <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1dcc:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1dd0:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1dd4:	8082                	ret

0000000000001dd6 <munmap>:
    register long a7 __asm__("a7") = n;
    1dd6:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dda:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1dde:	2501                	sext.w	a0,a0
    1de0:	8082                	ret

0000000000001de2 <wait>:

int wait(int *code)
{
    1de2:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1de4:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1de8:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1dea:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dec:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dee:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1df2:	2501                	sext.w	a0,a0
    1df4:	8082                	ret

0000000000001df6 <spawn>:
    register long a7 __asm__("a7") = n;
    1df6:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dfa:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1dfe:	2501                	sext.w	a0,a0
    1e00:	8082                	ret

0000000000001e02 <mailread>:
    register long a7 __asm__("a7") = n;
    1e02:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e06:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1e0a:	2501                	sext.w	a0,a0
    1e0c:	8082                	ret

0000000000001e0e <mailwrite>:
    register long a7 __asm__("a7") = n;
    1e0e:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e12:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e16:	2501                	sext.w	a0,a0
    1e18:	8082                	ret

0000000000001e1a <fstat>:
    register long a7 __asm__("a7") = n;
    1e1a:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e1e:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e22:	2501                	sext.w	a0,a0
    1e24:	8082                	ret

0000000000001e26 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e26:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e28:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e2c:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e2e:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e32:	2501                	sext.w	a0,a0
    1e34:	8082                	ret

0000000000001e36 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e36:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e38:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e3c:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e3e:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e42:	2501                	sext.w	a0,a0
    1e44:	8082                	ret

0000000000001e46 <link>:

int link(char *old_path, char *new_path)
{
    1e46:	87aa                	mv	a5,a0
    1e48:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e4a:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e4e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e52:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e54:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e58:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e5a:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e5e:	2501                	sext.w	a0,a0
    1e60:	8082                	ret

0000000000001e62 <unlink>:

int unlink(char *path)
{
    1e62:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e64:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e68:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e6c:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e6e:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e72:	2501                	sext.w	a0,a0
    1e74:	8082                	ret

0000000000001e76 <uname>:
    register long a7 __asm__("a7") = n;
    1e76:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e7a:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e7e:	2501                	sext.w	a0,a0
    1e80:	8082                	ret

0000000000001e82 <brk>:
    register long a7 __asm__("a7") = n;
    1e82:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e86:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e8a:	2501                	sext.w	a0,a0
    1e8c:	8082                	ret

0000000000001e8e <getcwd>:
    register long a7 __asm__("a7") = n;
    1e8e:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e90:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e94:	8082                	ret

0000000000001e96 <chdir>:
    register long a7 __asm__("a7") = n;
    1e96:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e9a:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e9e:	2501                	sext.w	a0,a0
    1ea0:	8082                	ret

0000000000001ea2 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1ea2:	862e                	mv	a2,a1
    1ea4:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1ea6:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1ea8:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1eac:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1eb0:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1eb2:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eb4:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1eb8:	2501                	sext.w	a0,a0
    1eba:	8082                	ret

0000000000001ebc <getdents>:
    register long a7 __asm__("a7") = n;
    1ebc:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ec0:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ec4:	2501                	sext.w	a0,a0
    1ec6:	8082                	ret

0000000000001ec8 <pipe>:
    register long a7 __asm__("a7") = n;
    1ec8:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ecc:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ece:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1ed2:	2501                	sext.w	a0,a0
    1ed4:	8082                	ret

0000000000001ed6 <dup>:
    register long a7 __asm__("a7") = n;
    1ed6:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1ed8:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1edc:	2501                	sext.w	a0,a0
    1ede:	8082                	ret

0000000000001ee0 <dup2>:
    register long a7 __asm__("a7") = n;
    1ee0:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ee2:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ee4:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ee8:	2501                	sext.w	a0,a0
    1eea:	8082                	ret

0000000000001eec <mount>:
    register long a7 __asm__("a7") = n;
    1eec:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ef0:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ef4:	2501                	sext.w	a0,a0
    1ef6:	8082                	ret

0000000000001ef8 <umount>:
    register long a7 __asm__("a7") = n;
    1ef8:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1efc:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1efe:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1f02:	2501                	sext.w	a0,a0
    1f04:	8082                	ret

0000000000001f06 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1f06:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1f08:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1f0a:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1f0c:	8532                	mv	a0,a2
	mv a2, a4
    1f0e:	863a                	mv	a2,a4
	mv a3, a5
    1f10:	86be                	mv	a3,a5
	mv a4, a6
    1f12:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f14:	0dc00893          	li	a7,220
	ecall
    1f18:	00000073          	ecall

	beqz a0, 1f
    1f1c:	c111                	beqz	a0,1f20 <__clone+0x1a>
	# Parent
	ret
    1f1e:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f20:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f22:	6522                	ld	a0,8(sp)
	jalr a1
    1f24:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f26:	05d00893          	li	a7,93
	ecall
    1f2a:	00000073          	ecall
