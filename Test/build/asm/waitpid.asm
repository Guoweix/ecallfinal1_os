
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/waitpid:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a8e5                	j	10fa <__start_main>

0000000000001004 <test_waitpid>:
#include "stdio.h"
#include "stdlib.h"
#include "unistd.h"

int i = 1000;
void test_waitpid(void){
    1004:	7179                	addi	sp,sp,-48
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f3a50513          	addi	a0,a0,-198 # 1f40 <__clone+0x2e>
void test_waitpid(void){
    100e:	f406                	sd	ra,40(sp)
    1010:	f022                	sd	s0,32(sp)
    1012:	ec26                	sd	s1,24(sp)
    TEST_START(__func__);
    1014:	358000ef          	jal	136c <puts>
    1018:	00001517          	auipc	a0,0x1
    101c:	ff050513          	addi	a0,a0,-16 # 2008 <__func__.0>
    1020:	34c000ef          	jal	136c <puts>
    1024:	00001517          	auipc	a0,0x1
    1028:	f3450513          	addi	a0,a0,-204 # 1f58 <__clone+0x46>
    102c:	340000ef          	jal	136c <puts>
    int cpid, wstatus;
    cpid = fork();
    1030:	4d9000ef          	jal	1d08 <fork>
    assert(cpid != -1);
    1034:	547d                	li	s0,-1
    cpid = fork();
    1036:	84aa                	mv	s1,a0
    assert(cpid != -1);
    1038:	04850963          	beq	a0,s0,108a <test_waitpid+0x86>
    if(cpid == 0){
    103c:	e93d                	bnez	a0,10b2 <test_waitpid+0xae>
	while(i--);
    103e:	00001797          	auipc	a5,0x1
    1042:	fe87a723          	sw	s0,-18(a5) # 202c <i>
	sched_yield();
    1046:	4b7000ef          	jal	1cfc <sched_yield>
	printf("This is child process\n");
    104a:	00001517          	auipc	a0,0x1
    104e:	f3e50513          	addi	a0,a0,-194 # 1f88 <__clone+0x76>
    1052:	33c000ef          	jal	138e <printf>
        exit(3);
    1056:	450d                	li	a0,3
    1058:	4d3000ef          	jal	1d2a <exit>
	    printf("waitpid successfully.\nwstatus: %x\n", WEXITSTATUS(wstatus));
	else
	    printf("waitpid error.\n");

    }
    TEST_END(__func__);
    105c:	00001517          	auipc	a0,0x1
    1060:	f7c50513          	addi	a0,a0,-132 # 1fd8 <__clone+0xc6>
    1064:	308000ef          	jal	136c <puts>
    1068:	00001517          	auipc	a0,0x1
    106c:	fa050513          	addi	a0,a0,-96 # 2008 <__func__.0>
    1070:	2fc000ef          	jal	136c <puts>
    1074:	00001517          	auipc	a0,0x1
    1078:	ee450513          	addi	a0,a0,-284 # 1f58 <__clone+0x46>
    107c:	2f0000ef          	jal	136c <puts>
}
    1080:	70a2                	ld	ra,40(sp)
    1082:	7402                	ld	s0,32(sp)
    1084:	64e2                	ld	s1,24(sp)
    1086:	6145                	addi	sp,sp,48
    1088:	8082                	ret
    assert(cpid != -1);
    108a:	00001517          	auipc	a0,0x1
    108e:	ede50513          	addi	a0,a0,-290 # 1f68 <__clone+0x56>
    1092:	586000ef          	jal	1618 <panic>
	pid_t ret = waitpid(cpid, &wstatus, 0);
    1096:	4601                	li	a2,0
    1098:	006c                	addi	a1,sp,12
    109a:	557d                	li	a0,-1
    109c:	499000ef          	jal	1d34 <waitpid>
	assert(ret != -1);
    10a0:	00950f63          	beq	a0,s1,10be <test_waitpid+0xba>
	    printf("waitpid error.\n");
    10a4:	00001517          	auipc	a0,0x1
    10a8:	f2450513          	addi	a0,a0,-220 # 1fc8 <__clone+0xb6>
    10ac:	2e2000ef          	jal	138e <printf>
    10b0:	b775                	j	105c <test_waitpid+0x58>
	pid_t ret = waitpid(cpid, &wstatus, 0);
    10b2:	4601                	li	a2,0
    10b4:	006c                	addi	a1,sp,12
    10b6:	47f000ef          	jal	1d34 <waitpid>
	assert(ret != -1);
    10ba:	00851963          	bne	a0,s0,10cc <test_waitpid+0xc8>
    10be:	00001517          	auipc	a0,0x1
    10c2:	eaa50513          	addi	a0,a0,-342 # 1f68 <__clone+0x56>
    10c6:	552000ef          	jal	1618 <panic>
    10ca:	557d                	li	a0,-1
	if(ret == cpid && WEXITSTATUS(wstatus) == 3)
    10cc:	fca49ce3          	bne	s1,a0,10a4 <test_waitpid+0xa0>
    10d0:	00d14703          	lbu	a4,13(sp)
    10d4:	478d                	li	a5,3
    10d6:	fcf717e3          	bne	a4,a5,10a4 <test_waitpid+0xa0>
	    printf("waitpid successfully.\nwstatus: %x\n", WEXITSTATUS(wstatus));
    10da:	458d                	li	a1,3
    10dc:	00001517          	auipc	a0,0x1
    10e0:	ec450513          	addi	a0,a0,-316 # 1fa0 <__clone+0x8e>
    10e4:	2aa000ef          	jal	138e <printf>
    10e8:	bf95                	j	105c <test_waitpid+0x58>

00000000000010ea <main>:

int main(void){
    10ea:	1141                	addi	sp,sp,-16
    10ec:	e406                	sd	ra,8(sp)
    test_waitpid();
    10ee:	f17ff0ef          	jal	1004 <test_waitpid>
    return 0;
}
    10f2:	60a2                	ld	ra,8(sp)
    10f4:	4501                	li	a0,0
    10f6:	0141                	addi	sp,sp,16
    10f8:	8082                	ret

00000000000010fa <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10fa:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10fc:	4108                	lw	a0,0(a0)
{
    10fe:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1100:	05a1                	addi	a1,a1,8
{
    1102:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    1104:	fe7ff0ef          	jal	10ea <main>
    1108:	423000ef          	jal	1d2a <exit>
	return 0;
}
    110c:	60a2                	ld	ra,8(sp)
    110e:	4501                	li	a0,0
    1110:	0141                	addi	sp,sp,16
    1112:	8082                	ret

0000000000001114 <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    1114:	7179                	addi	sp,sp,-48
    1116:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    1118:	12054b63          	bltz	a0,124e <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    111c:	02b577bb          	remuw	a5,a0,a1
    1120:	00001617          	auipc	a2,0x1
    1124:	ef860613          	addi	a2,a2,-264 # 2018 <digits>
    buf[16] = 0;
    1128:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    112c:	0005871b          	sext.w	a4,a1
    1130:	1782                	slli	a5,a5,0x20
    1132:	9381                	srli	a5,a5,0x20
    1134:	97b2                	add	a5,a5,a2
    1136:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    113a:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    113e:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1142:	1cb56363          	bltu	a0,a1,1308 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    1146:	45b9                	li	a1,14
    1148:	02e877bb          	remuw	a5,a6,a4
    114c:	1782                	slli	a5,a5,0x20
    114e:	9381                	srli	a5,a5,0x20
    1150:	97b2                	add	a5,a5,a2
    1152:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1156:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    115a:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    115e:	0ce86e63          	bltu	a6,a4,123a <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1162:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    1166:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    116a:	1582                	slli	a1,a1,0x20
    116c:	9181                	srli	a1,a1,0x20
    116e:	95b2                	add	a1,a1,a2
    1170:	0005c583          	lbu	a1,0(a1)
    1174:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    1178:	0007859b          	sext.w	a1,a5
    117c:	12e6ec63          	bltu	a3,a4,12b4 <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1180:	02e7f6bb          	remuw	a3,a5,a4
    1184:	1682                	slli	a3,a3,0x20
    1186:	9281                	srli	a3,a3,0x20
    1188:	96b2                	add	a3,a3,a2
    118a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    118e:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1192:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    1196:	12e5e863          	bltu	a1,a4,12c6 <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    119a:	02e876bb          	remuw	a3,a6,a4
    119e:	1682                	slli	a3,a3,0x20
    11a0:	9281                	srli	a3,a3,0x20
    11a2:	96b2                	add	a3,a3,a2
    11a4:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11a8:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11ac:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    11b0:	12e86463          	bltu	a6,a4,12d8 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    11b4:	02e5f6bb          	remuw	a3,a1,a4
    11b8:	1682                	slli	a3,a3,0x20
    11ba:	9281                	srli	a3,a3,0x20
    11bc:	96b2                	add	a3,a3,a2
    11be:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11c2:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11c6:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    11ca:	0ce5ec63          	bltu	a1,a4,12a2 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    11ce:	02e876bb          	remuw	a3,a6,a4
    11d2:	1682                	slli	a3,a3,0x20
    11d4:	9281                	srli	a3,a3,0x20
    11d6:	96b2                	add	a3,a3,a2
    11d8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11dc:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11e0:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11e4:	10e86963          	bltu	a6,a4,12f6 <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11e8:	02e5f6bb          	remuw	a3,a1,a4
    11ec:	1682                	slli	a3,a3,0x20
    11ee:	9281                	srli	a3,a3,0x20
    11f0:	96b2                	add	a3,a3,a2
    11f2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11f6:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11fa:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11fe:	10e5e763          	bltu	a1,a4,130c <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    1202:	02e876bb          	remuw	a3,a6,a4
    1206:	1682                	slli	a3,a3,0x20
    1208:	9281                	srli	a3,a3,0x20
    120a:	96b2                	add	a3,a3,a2
    120c:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1210:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    1214:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    1218:	10e86363          	bltu	a6,a4,131e <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    121c:	1782                	slli	a5,a5,0x20
    121e:	9381                	srli	a5,a5,0x20
    1220:	97b2                	add	a5,a5,a2
    1222:	0007c783          	lbu	a5,0(a5)
    1226:	4599                	li	a1,6
    1228:	00f10723          	sb	a5,14(sp)

    if (sign)
    122c:	00055763          	bgez	a0,123a <printint.constprop.0+0x126>
        buf[i--] = '-';
    1230:	02d00793          	li	a5,45
    1234:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    1238:	4595                	li	a1,5
    write(f, s, l);
    123a:	003c                	addi	a5,sp,8
    123c:	4641                	li	a2,16
    123e:	9e0d                	subw	a2,a2,a1
    1240:	4505                	li	a0,1
    1242:	95be                	add	a1,a1,a5
    1244:	297000ef          	jal	1cda <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1248:	70a2                	ld	ra,40(sp)
    124a:	6145                	addi	sp,sp,48
    124c:	8082                	ret
        x = -xx;
    124e:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1252:	02b877bb          	remuw	a5,a6,a1
    1256:	00001617          	auipc	a2,0x1
    125a:	dc260613          	addi	a2,a2,-574 # 2018 <digits>
    buf[16] = 0;
    125e:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1262:	0005871b          	sext.w	a4,a1
    1266:	1782                	slli	a5,a5,0x20
    1268:	9381                	srli	a5,a5,0x20
    126a:	97b2                	add	a5,a5,a2
    126c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1270:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    1274:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1278:	06b86963          	bltu	a6,a1,12ea <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    127c:	02e8f7bb          	remuw	a5,a7,a4
    1280:	1782                	slli	a5,a5,0x20
    1282:	9381                	srli	a5,a5,0x20
    1284:	97b2                	add	a5,a5,a2
    1286:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    128a:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    128e:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1292:	ece8f8e3          	bgeu	a7,a4,1162 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    1296:	02d00793          	li	a5,45
    129a:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    129e:	45b5                	li	a1,13
    12a0:	bf69                	j	123a <printint.constprop.0+0x126>
    12a2:	45a9                	li	a1,10
    if (sign)
    12a4:	f8055be3          	bgez	a0,123a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12a8:	02d00793          	li	a5,45
    12ac:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    12b0:	45a5                	li	a1,9
    12b2:	b761                	j	123a <printint.constprop.0+0x126>
    12b4:	45b5                	li	a1,13
    if (sign)
    12b6:	f80552e3          	bgez	a0,123a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12ba:	02d00793          	li	a5,45
    12be:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    12c2:	45b1                	li	a1,12
    12c4:	bf9d                	j	123a <printint.constprop.0+0x126>
    12c6:	45b1                	li	a1,12
    if (sign)
    12c8:	f60559e3          	bgez	a0,123a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12cc:	02d00793          	li	a5,45
    12d0:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12d4:	45ad                	li	a1,11
    12d6:	b795                	j	123a <printint.constprop.0+0x126>
    12d8:	45ad                	li	a1,11
    if (sign)
    12da:	f60550e3          	bgez	a0,123a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12de:	02d00793          	li	a5,45
    12e2:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12e6:	45a9                	li	a1,10
    12e8:	bf89                	j	123a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12ea:	02d00793          	li	a5,45
    12ee:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12f2:	45b9                	li	a1,14
    12f4:	b799                	j	123a <printint.constprop.0+0x126>
    12f6:	45a5                	li	a1,9
    if (sign)
    12f8:	f40551e3          	bgez	a0,123a <printint.constprop.0+0x126>
        buf[i--] = '-';
    12fc:	02d00793          	li	a5,45
    1300:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    1304:	45a1                	li	a1,8
    1306:	bf15                	j	123a <printint.constprop.0+0x126>
    i = 15;
    1308:	45bd                	li	a1,15
    130a:	bf05                	j	123a <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    130c:	45a1                	li	a1,8
    if (sign)
    130e:	f20556e3          	bgez	a0,123a <printint.constprop.0+0x126>
        buf[i--] = '-';
    1312:	02d00793          	li	a5,45
    1316:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    131a:	459d                	li	a1,7
    131c:	bf39                	j	123a <printint.constprop.0+0x126>
    131e:	459d                	li	a1,7
    if (sign)
    1320:	f0055de3          	bgez	a0,123a <printint.constprop.0+0x126>
        buf[i--] = '-';
    1324:	02d00793          	li	a5,45
    1328:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    132c:	4599                	li	a1,6
    132e:	b731                	j	123a <printint.constprop.0+0x126>

0000000000001330 <getchar>:
{
    1330:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1332:	00f10593          	addi	a1,sp,15
    1336:	4605                	li	a2,1
    1338:	4501                	li	a0,0
{
    133a:	ec06                	sd	ra,24(sp)
    char byte = 0;
    133c:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1340:	191000ef          	jal	1cd0 <read>
}
    1344:	60e2                	ld	ra,24(sp)
    1346:	00f14503          	lbu	a0,15(sp)
    134a:	6105                	addi	sp,sp,32
    134c:	8082                	ret

000000000000134e <putchar>:
{
    134e:	1101                	addi	sp,sp,-32
    1350:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1352:	00f10593          	addi	a1,sp,15
    1356:	4605                	li	a2,1
    1358:	4505                	li	a0,1
{
    135a:	ec06                	sd	ra,24(sp)
    char byte = c;
    135c:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1360:	17b000ef          	jal	1cda <write>
}
    1364:	60e2                	ld	ra,24(sp)
    1366:	2501                	sext.w	a0,a0
    1368:	6105                	addi	sp,sp,32
    136a:	8082                	ret

000000000000136c <puts>:
{
    136c:	1141                	addi	sp,sp,-16
    136e:	e406                	sd	ra,8(sp)
    1370:	e022                	sd	s0,0(sp)
    1372:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    1374:	582000ef          	jal	18f6 <strlen>
    1378:	862a                	mv	a2,a0
    137a:	85a2                	mv	a1,s0
    137c:	4505                	li	a0,1
    137e:	15d000ef          	jal	1cda <write>
}
    1382:	60a2                	ld	ra,8(sp)
    1384:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    1386:	957d                	srai	a0,a0,0x3f
    return r;
    1388:	2501                	sext.w	a0,a0
}
    138a:	0141                	addi	sp,sp,16
    138c:	8082                	ret

000000000000138e <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    138e:	7131                	addi	sp,sp,-192
    1390:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1392:	013c                	addi	a5,sp,136
{
    1394:	f0ca                	sd	s2,96(sp)
    1396:	ecce                	sd	s3,88(sp)
    1398:	e8d2                	sd	s4,80(sp)
    139a:	e4d6                	sd	s5,72(sp)
    139c:	e0da                	sd	s6,64(sp)
    139e:	fc5e                	sd	s7,56(sp)
    13a0:	fc86                	sd	ra,120(sp)
    13a2:	f8a2                	sd	s0,112(sp)
    13a4:	f4a6                	sd	s1,104(sp)
    13a6:	e52e                	sd	a1,136(sp)
    13a8:	e932                	sd	a2,144(sp)
    13aa:	ed36                	sd	a3,152(sp)
    13ac:	f13a                	sd	a4,160(sp)
    13ae:	f942                	sd	a6,176(sp)
    13b0:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    13b2:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    13b4:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    13b8:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    13bc:	00001b97          	auipc	s7,0x1
    13c0:	c2cb8b93          	addi	s7,s7,-980 # 1fe8 <__clone+0xd6>
        switch (s[1])
    13c4:	07800a93          	li	s5,120
    13c8:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13cc:	00001997          	auipc	s3,0x1
    13d0:	c4c98993          	addi	s3,s3,-948 # 2018 <digits>
        if (!*s)
    13d4:	00054783          	lbu	a5,0(a0)
    13d8:	16078c63          	beqz	a5,1550 <printf+0x1c2>
    13dc:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13de:	19278463          	beq	a5,s2,1566 <printf+0x1d8>
    13e2:	00164783          	lbu	a5,1(a2)
    13e6:	0605                	addi	a2,a2,1
    13e8:	fbfd                	bnez	a5,13de <printf+0x50>
    13ea:	84b2                	mv	s1,a2
        l = z - a;
    13ec:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13f0:	85aa                	mv	a1,a0
    13f2:	8622                	mv	a2,s0
    13f4:	4505                	li	a0,1
    13f6:	0e5000ef          	jal	1cda <write>
        if (l)
    13fa:	18041f63          	bnez	s0,1598 <printf+0x20a>
        if (s[1] == 0)
    13fe:	0014c783          	lbu	a5,1(s1)
    1402:	14078763          	beqz	a5,1550 <printf+0x1c2>
        switch (s[1])
    1406:	1d478163          	beq	a5,s4,15c8 <printf+0x23a>
    140a:	18fa6963          	bltu	s4,a5,159c <printf+0x20e>
    140e:	1b678363          	beq	a5,s6,15b4 <printf+0x226>
    1412:	07000713          	li	a4,112
    1416:	1ce79c63          	bne	a5,a4,15ee <printf+0x260>
            printptr(va_arg(ap, uint64));
    141a:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    141c:	03000793          	li	a5,48
    1420:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    1424:	631c                	ld	a5,0(a4)
    1426:	0721                	addi	a4,a4,8
    1428:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    142a:	00479f93          	slli	t6,a5,0x4
    142e:	00879f13          	slli	t5,a5,0x8
    1432:	00c79e93          	slli	t4,a5,0xc
    1436:	01079e13          	slli	t3,a5,0x10
    143a:	01479313          	slli	t1,a5,0x14
    143e:	01879893          	slli	a7,a5,0x18
    1442:	01c79713          	slli	a4,a5,0x1c
    1446:	02479813          	slli	a6,a5,0x24
    144a:	02879513          	slli	a0,a5,0x28
    144e:	02c79593          	slli	a1,a5,0x2c
    1452:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1456:	03c7d293          	srli	t0,a5,0x3c
    145a:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    145e:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1462:	03cfdf93          	srli	t6,t6,0x3c
    1466:	03cf5f13          	srli	t5,t5,0x3c
    146a:	03cede93          	srli	t4,t4,0x3c
    146e:	03ce5e13          	srli	t3,t3,0x3c
    1472:	03c35313          	srli	t1,t1,0x3c
    1476:	03c8d893          	srli	a7,a7,0x3c
    147a:	9371                	srli	a4,a4,0x3c
    147c:	03c85813          	srli	a6,a6,0x3c
    1480:	9171                	srli	a0,a0,0x3c
    1482:	91f1                	srli	a1,a1,0x3c
    1484:	9271                	srli	a2,a2,0x3c
    1486:	974e                	add	a4,a4,s3
    1488:	92f1                	srli	a3,a3,0x3c
    148a:	92ce                	add	t0,t0,s3
    148c:	9fce                	add	t6,t6,s3
    148e:	9f4e                	add	t5,t5,s3
    1490:	9ece                	add	t4,t4,s3
    1492:	9e4e                	add	t3,t3,s3
    1494:	934e                	add	t1,t1,s3
    1496:	98ce                	add	a7,a7,s3
    1498:	93ce                	add	t2,t2,s3
    149a:	984e                	add	a6,a6,s3
    149c:	954e                	add	a0,a0,s3
    149e:	95ce                	add	a1,a1,s3
    14a0:	964e                	add	a2,a2,s3
    14a2:	0002c283          	lbu	t0,0(t0)
    14a6:	000fcf83          	lbu	t6,0(t6)
    14aa:	000f4f03          	lbu	t5,0(t5)
    14ae:	000ece83          	lbu	t4,0(t4)
    14b2:	000e4e03          	lbu	t3,0(t3)
    14b6:	00034303          	lbu	t1,0(t1)
    14ba:	0008c883          	lbu	a7,0(a7)
    14be:	00074403          	lbu	s0,0(a4)
    14c2:	0003c383          	lbu	t2,0(t2)
    14c6:	00084803          	lbu	a6,0(a6)
    14ca:	00054503          	lbu	a0,0(a0)
    14ce:	0005c583          	lbu	a1,0(a1)
    14d2:	00064603          	lbu	a2,0(a2)
    14d6:	00d98733          	add	a4,s3,a3
    14da:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14de:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14e2:	9371                	srli	a4,a4,0x3c
    14e4:	8bbd                	andi	a5,a5,15
    14e6:	00510523          	sb	t0,10(sp)
    14ea:	01f105a3          	sb	t6,11(sp)
    14ee:	01e10623          	sb	t5,12(sp)
    14f2:	01d106a3          	sb	t4,13(sp)
    14f6:	01c10723          	sb	t3,14(sp)
    14fa:	006107a3          	sb	t1,15(sp)
    14fe:	01110823          	sb	a7,16(sp)
    1502:	00710923          	sb	t2,18(sp)
    1506:	010109a3          	sb	a6,19(sp)
    150a:	00a10a23          	sb	a0,20(sp)
    150e:	00b10aa3          	sb	a1,21(sp)
    1512:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    1516:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    151a:	008108a3          	sb	s0,17(sp)
    151e:	974e                	add	a4,a4,s3
    1520:	97ce                	add	a5,a5,s3
    1522:	00d10ba3          	sb	a3,23(sp)
    1526:	00074703          	lbu	a4,0(a4)
    152a:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    152e:	4649                	li	a2,18
    1530:	002c                	addi	a1,sp,8
    1532:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1534:	00e10c23          	sb	a4,24(sp)
    1538:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    153c:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1540:	79a000ef          	jal	1cda <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    1544:	00248513          	addi	a0,s1,2
        if (!*s)
    1548:	00054783          	lbu	a5,0(a0)
    154c:	e80798e3          	bnez	a5,13dc <printf+0x4e>
    }
    va_end(ap);
}
    1550:	70e6                	ld	ra,120(sp)
    1552:	7446                	ld	s0,112(sp)
    1554:	74a6                	ld	s1,104(sp)
    1556:	7906                	ld	s2,96(sp)
    1558:	69e6                	ld	s3,88(sp)
    155a:	6a46                	ld	s4,80(sp)
    155c:	6aa6                	ld	s5,72(sp)
    155e:	6b06                	ld	s6,64(sp)
    1560:	7be2                	ld	s7,56(sp)
    1562:	6129                	addi	sp,sp,192
    1564:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    1566:	00064783          	lbu	a5,0(a2)
    156a:	84b2                	mv	s1,a2
    156c:	01278963          	beq	a5,s2,157e <printf+0x1f0>
    1570:	bdb5                	j	13ec <printf+0x5e>
    1572:	0024c783          	lbu	a5,2(s1)
    1576:	0605                	addi	a2,a2,1
    1578:	0489                	addi	s1,s1,2
    157a:	e72799e3          	bne	a5,s2,13ec <printf+0x5e>
    157e:	0014c783          	lbu	a5,1(s1)
    1582:	ff2788e3          	beq	a5,s2,1572 <printf+0x1e4>
        l = z - a;
    1586:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    158a:	85aa                	mv	a1,a0
    158c:	8622                	mv	a2,s0
    158e:	4505                	li	a0,1
    1590:	74a000ef          	jal	1cda <write>
        if (l)
    1594:	e60405e3          	beqz	s0,13fe <printf+0x70>
    1598:	8526                	mv	a0,s1
    159a:	bd2d                	j	13d4 <printf+0x46>
        switch (s[1])
    159c:	05579963          	bne	a5,s5,15ee <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    15a0:	6782                	ld	a5,0(sp)
    15a2:	45c1                	li	a1,16
    15a4:	4388                	lw	a0,0(a5)
    15a6:	07a1                	addi	a5,a5,8
    15a8:	e03e                	sd	a5,0(sp)
    15aa:	b6bff0ef          	jal	1114 <printint.constprop.0>
        s += 2;
    15ae:	00248513          	addi	a0,s1,2
    15b2:	bf59                	j	1548 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    15b4:	6782                	ld	a5,0(sp)
    15b6:	45a9                	li	a1,10
    15b8:	4388                	lw	a0,0(a5)
    15ba:	07a1                	addi	a5,a5,8
    15bc:	e03e                	sd	a5,0(sp)
    15be:	b57ff0ef          	jal	1114 <printint.constprop.0>
        s += 2;
    15c2:	00248513          	addi	a0,s1,2
    15c6:	b749                	j	1548 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    15c8:	6782                	ld	a5,0(sp)
    15ca:	6380                	ld	s0,0(a5)
    15cc:	07a1                	addi	a5,a5,8
    15ce:	e03e                	sd	a5,0(sp)
    15d0:	c031                	beqz	s0,1614 <printf+0x286>
            l = strnlen(a, 200);
    15d2:	0c800593          	li	a1,200
    15d6:	8522                	mv	a0,s0
    15d8:	40a000ef          	jal	19e2 <strnlen>
    write(f, s, l);
    15dc:	0005061b          	sext.w	a2,a0
    15e0:	85a2                	mv	a1,s0
    15e2:	4505                	li	a0,1
    15e4:	6f6000ef          	jal	1cda <write>
        s += 2;
    15e8:	00248513          	addi	a0,s1,2
    15ec:	bfb1                	j	1548 <printf+0x1ba>
    return write(stdout, &byte, 1);
    15ee:	4605                	li	a2,1
    15f0:	002c                	addi	a1,sp,8
    15f2:	4505                	li	a0,1
    char byte = c;
    15f4:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15f8:	6e2000ef          	jal	1cda <write>
    char byte = c;
    15fc:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    1600:	4605                	li	a2,1
    1602:	002c                	addi	a1,sp,8
    1604:	4505                	li	a0,1
    char byte = c;
    1606:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    160a:	6d0000ef          	jal	1cda <write>
        s += 2;
    160e:	00248513          	addi	a0,s1,2
    1612:	bf1d                	j	1548 <printf+0x1ba>
                a = "(null)";
    1614:	845e                	mv	s0,s7
    1616:	bf75                	j	15d2 <printf+0x244>

0000000000001618 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    1618:	1141                	addi	sp,sp,-16
    161a:	e406                	sd	ra,8(sp)
    puts(m);
    161c:	d51ff0ef          	jal	136c <puts>
    exit(-100);
}
    1620:	60a2                	ld	ra,8(sp)
    exit(-100);
    1622:	f9c00513          	li	a0,-100
}
    1626:	0141                	addi	sp,sp,16
    exit(-100);
    1628:	a709                	j	1d2a <exit>

000000000000162a <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    162a:	02000793          	li	a5,32
    162e:	00f50663          	beq	a0,a5,163a <isspace+0x10>
    1632:	355d                	addiw	a0,a0,-9
    1634:	00553513          	sltiu	a0,a0,5
    1638:	8082                	ret
    163a:	4505                	li	a0,1
}
    163c:	8082                	ret

000000000000163e <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    163e:	fd05051b          	addiw	a0,a0,-48
}
    1642:	00a53513          	sltiu	a0,a0,10
    1646:	8082                	ret

0000000000001648 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1648:	02000613          	li	a2,32
    164c:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    164e:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1652:	ff77069b          	addiw	a3,a4,-9
    1656:	04c70d63          	beq	a4,a2,16b0 <atoi+0x68>
    165a:	0007079b          	sext.w	a5,a4
    165e:	04d5f963          	bgeu	a1,a3,16b0 <atoi+0x68>
        s++;
    switch (*s)
    1662:	02b00693          	li	a3,43
    1666:	04d70a63          	beq	a4,a3,16ba <atoi+0x72>
    166a:	02d00693          	li	a3,45
    166e:	06d70463          	beq	a4,a3,16d6 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1672:	fd07859b          	addiw	a1,a5,-48
    1676:	4625                	li	a2,9
    1678:	873e                	mv	a4,a5
    167a:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    167c:	4e01                	li	t3,0
    while (isdigit(*s))
    167e:	04b66a63          	bltu	a2,a1,16d2 <atoi+0x8a>
    int n = 0, neg = 0;
    1682:	4501                	li	a0,0
    while (isdigit(*s))
    1684:	4825                	li	a6,9
    1686:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    168a:	0025179b          	slliw	a5,a0,0x2
    168e:	9d3d                	addw	a0,a0,a5
    1690:	fd07031b          	addiw	t1,a4,-48
    1694:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1698:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    169c:	0685                	addi	a3,a3,1
    169e:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    16a2:	0006071b          	sext.w	a4,a2
    16a6:	feb870e3          	bgeu	a6,a1,1686 <atoi+0x3e>
    return neg ? n : -n;
    16aa:	000e0563          	beqz	t3,16b4 <atoi+0x6c>
}
    16ae:	8082                	ret
        s++;
    16b0:	0505                	addi	a0,a0,1
    16b2:	bf71                	j	164e <atoi+0x6>
    return neg ? n : -n;
    16b4:	4113053b          	subw	a0,t1,a7
    16b8:	8082                	ret
    while (isdigit(*s))
    16ba:	00154783          	lbu	a5,1(a0)
    16be:	4625                	li	a2,9
        s++;
    16c0:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16c4:	fd07859b          	addiw	a1,a5,-48
    16c8:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16cc:	4e01                	li	t3,0
    while (isdigit(*s))
    16ce:	fab67ae3          	bgeu	a2,a1,1682 <atoi+0x3a>
    16d2:	4501                	li	a0,0
}
    16d4:	8082                	ret
    while (isdigit(*s))
    16d6:	00154783          	lbu	a5,1(a0)
    16da:	4625                	li	a2,9
        s++;
    16dc:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16e0:	fd07859b          	addiw	a1,a5,-48
    16e4:	0007871b          	sext.w	a4,a5
    16e8:	feb665e3          	bltu	a2,a1,16d2 <atoi+0x8a>
        neg = 1;
    16ec:	4e05                	li	t3,1
    16ee:	bf51                	j	1682 <atoi+0x3a>

00000000000016f0 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16f0:	16060d63          	beqz	a2,186a <memset+0x17a>
    16f4:	40a007b3          	neg	a5,a0
    16f8:	8b9d                	andi	a5,a5,7
    16fa:	00778713          	addi	a4,a5,7
    16fe:	482d                	li	a6,11
    1700:	0ff5f593          	zext.b	a1,a1
    1704:	fff60693          	addi	a3,a2,-1
    1708:	17076263          	bltu	a4,a6,186c <memset+0x17c>
    170c:	16e6ea63          	bltu	a3,a4,1880 <memset+0x190>
    1710:	16078563          	beqz	a5,187a <memset+0x18a>
    1714:	00b50023          	sb	a1,0(a0)
    1718:	4705                	li	a4,1
    171a:	00150e93          	addi	t4,a0,1
    171e:	14e78c63          	beq	a5,a4,1876 <memset+0x186>
    1722:	00b500a3          	sb	a1,1(a0)
    1726:	4709                	li	a4,2
    1728:	00250e93          	addi	t4,a0,2
    172c:	14e78d63          	beq	a5,a4,1886 <memset+0x196>
    1730:	00b50123          	sb	a1,2(a0)
    1734:	470d                	li	a4,3
    1736:	00350e93          	addi	t4,a0,3
    173a:	12e78b63          	beq	a5,a4,1870 <memset+0x180>
    173e:	00b501a3          	sb	a1,3(a0)
    1742:	4711                	li	a4,4
    1744:	00450e93          	addi	t4,a0,4
    1748:	14e78163          	beq	a5,a4,188a <memset+0x19a>
    174c:	00b50223          	sb	a1,4(a0)
    1750:	4715                	li	a4,5
    1752:	00550e93          	addi	t4,a0,5
    1756:	12e78c63          	beq	a5,a4,188e <memset+0x19e>
    175a:	00b502a3          	sb	a1,5(a0)
    175e:	471d                	li	a4,7
    1760:	00650e93          	addi	t4,a0,6
    1764:	12e79763          	bne	a5,a4,1892 <memset+0x1a2>
    1768:	00750e93          	addi	t4,a0,7
    176c:	00b50323          	sb	a1,6(a0)
    1770:	4f1d                	li	t5,7
    1772:	00859713          	slli	a4,a1,0x8
    1776:	8f4d                	or	a4,a4,a1
    1778:	01059e13          	slli	t3,a1,0x10
    177c:	01c76e33          	or	t3,a4,t3
    1780:	01859313          	slli	t1,a1,0x18
    1784:	006e6333          	or	t1,t3,t1
    1788:	02059893          	slli	a7,a1,0x20
    178c:	011368b3          	or	a7,t1,a7
    1790:	02859813          	slli	a6,a1,0x28
    1794:	40f60333          	sub	t1,a2,a5
    1798:	0108e833          	or	a6,a7,a6
    179c:	03059693          	slli	a3,a1,0x30
    17a0:	00d866b3          	or	a3,a6,a3
    17a4:	03859713          	slli	a4,a1,0x38
    17a8:	97aa                	add	a5,a5,a0
    17aa:	ff837813          	andi	a6,t1,-8
    17ae:	8f55                	or	a4,a4,a3
    17b0:	00f806b3          	add	a3,a6,a5
    17b4:	e398                	sd	a4,0(a5)
    17b6:	07a1                	addi	a5,a5,8
    17b8:	fed79ee3          	bne	a5,a3,17b4 <memset+0xc4>
    17bc:	ff837693          	andi	a3,t1,-8
    17c0:	00de87b3          	add	a5,t4,a3
    17c4:	01e6873b          	addw	a4,a3,t5
    17c8:	0ad30663          	beq	t1,a3,1874 <memset+0x184>
    17cc:	00b78023          	sb	a1,0(a5)
    17d0:	0017069b          	addiw	a3,a4,1
    17d4:	08c6fb63          	bgeu	a3,a2,186a <memset+0x17a>
    17d8:	00b780a3          	sb	a1,1(a5)
    17dc:	0027069b          	addiw	a3,a4,2
    17e0:	08c6f563          	bgeu	a3,a2,186a <memset+0x17a>
    17e4:	00b78123          	sb	a1,2(a5)
    17e8:	0037069b          	addiw	a3,a4,3
    17ec:	06c6ff63          	bgeu	a3,a2,186a <memset+0x17a>
    17f0:	00b781a3          	sb	a1,3(a5)
    17f4:	0047069b          	addiw	a3,a4,4
    17f8:	06c6f963          	bgeu	a3,a2,186a <memset+0x17a>
    17fc:	00b78223          	sb	a1,4(a5)
    1800:	0057069b          	addiw	a3,a4,5
    1804:	06c6f363          	bgeu	a3,a2,186a <memset+0x17a>
    1808:	00b782a3          	sb	a1,5(a5)
    180c:	0067069b          	addiw	a3,a4,6
    1810:	04c6fd63          	bgeu	a3,a2,186a <memset+0x17a>
    1814:	00b78323          	sb	a1,6(a5)
    1818:	0077069b          	addiw	a3,a4,7
    181c:	04c6f763          	bgeu	a3,a2,186a <memset+0x17a>
    1820:	00b783a3          	sb	a1,7(a5)
    1824:	0087069b          	addiw	a3,a4,8
    1828:	04c6f163          	bgeu	a3,a2,186a <memset+0x17a>
    182c:	00b78423          	sb	a1,8(a5)
    1830:	0097069b          	addiw	a3,a4,9
    1834:	02c6fb63          	bgeu	a3,a2,186a <memset+0x17a>
    1838:	00b784a3          	sb	a1,9(a5)
    183c:	00a7069b          	addiw	a3,a4,10
    1840:	02c6f563          	bgeu	a3,a2,186a <memset+0x17a>
    1844:	00b78523          	sb	a1,10(a5)
    1848:	00b7069b          	addiw	a3,a4,11
    184c:	00c6ff63          	bgeu	a3,a2,186a <memset+0x17a>
    1850:	00b785a3          	sb	a1,11(a5)
    1854:	00c7069b          	addiw	a3,a4,12
    1858:	00c6f963          	bgeu	a3,a2,186a <memset+0x17a>
    185c:	00b78623          	sb	a1,12(a5)
    1860:	2735                	addiw	a4,a4,13
    1862:	00c77463          	bgeu	a4,a2,186a <memset+0x17a>
    1866:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    186a:	8082                	ret
    186c:	472d                	li	a4,11
    186e:	bd79                	j	170c <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1870:	4f0d                	li	t5,3
    1872:	b701                	j	1772 <memset+0x82>
    1874:	8082                	ret
    1876:	4f05                	li	t5,1
    1878:	bded                	j	1772 <memset+0x82>
    187a:	8eaa                	mv	t4,a0
    187c:	4f01                	li	t5,0
    187e:	bdd5                	j	1772 <memset+0x82>
    1880:	87aa                	mv	a5,a0
    1882:	4701                	li	a4,0
    1884:	b7a1                	j	17cc <memset+0xdc>
    1886:	4f09                	li	t5,2
    1888:	b5ed                	j	1772 <memset+0x82>
    188a:	4f11                	li	t5,4
    188c:	b5dd                	j	1772 <memset+0x82>
    188e:	4f15                	li	t5,5
    1890:	b5cd                	j	1772 <memset+0x82>
    1892:	4f19                	li	t5,6
    1894:	bdf9                	j	1772 <memset+0x82>

0000000000001896 <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    1896:	00054783          	lbu	a5,0(a0)
    189a:	0005c703          	lbu	a4,0(a1)
    189e:	00e79863          	bne	a5,a4,18ae <strcmp+0x18>
    18a2:	0505                	addi	a0,a0,1
    18a4:	0585                	addi	a1,a1,1
    18a6:	fbe5                	bnez	a5,1896 <strcmp>
    18a8:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    18aa:	9d19                	subw	a0,a0,a4
    18ac:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    18ae:	0007851b          	sext.w	a0,a5
    18b2:	bfe5                	j	18aa <strcmp+0x14>

00000000000018b4 <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    18b4:	ce05                	beqz	a2,18ec <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18b6:	00054703          	lbu	a4,0(a0)
    18ba:	0005c783          	lbu	a5,0(a1)
    18be:	cb0d                	beqz	a4,18f0 <strncmp+0x3c>
    if (!n--)
    18c0:	167d                	addi	a2,a2,-1
    18c2:	00c506b3          	add	a3,a0,a2
    18c6:	a819                	j	18dc <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18c8:	00a68e63          	beq	a3,a0,18e4 <strncmp+0x30>
    18cc:	0505                	addi	a0,a0,1
    18ce:	00e79b63          	bne	a5,a4,18e4 <strncmp+0x30>
    18d2:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18d6:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18da:	cb19                	beqz	a4,18f0 <strncmp+0x3c>
    18dc:	0005c783          	lbu	a5,0(a1)
    18e0:	0585                	addi	a1,a1,1
    18e2:	f3fd                	bnez	a5,18c8 <strncmp+0x14>
    return *l - *r;
    18e4:	0007051b          	sext.w	a0,a4
    18e8:	9d1d                	subw	a0,a0,a5
    18ea:	8082                	ret
        return 0;
    18ec:	4501                	li	a0,0
}
    18ee:	8082                	ret
    18f0:	4501                	li	a0,0
    return *l - *r;
    18f2:	9d1d                	subw	a0,a0,a5
    18f4:	8082                	ret

00000000000018f6 <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18f6:	00757793          	andi	a5,a0,7
    18fa:	cf89                	beqz	a5,1914 <strlen+0x1e>
    18fc:	87aa                	mv	a5,a0
    18fe:	a029                	j	1908 <strlen+0x12>
    1900:	0785                	addi	a5,a5,1
    1902:	0077f713          	andi	a4,a5,7
    1906:	cb01                	beqz	a4,1916 <strlen+0x20>
        if (!*s)
    1908:	0007c703          	lbu	a4,0(a5)
    190c:	fb75                	bnez	a4,1900 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    190e:	40a78533          	sub	a0,a5,a0
}
    1912:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1914:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    1916:	6394                	ld	a3,0(a5)
    1918:	00000597          	auipc	a1,0x0
    191c:	6d85b583          	ld	a1,1752(a1) # 1ff0 <__clone+0xde>
    1920:	00000617          	auipc	a2,0x0
    1924:	6d863603          	ld	a2,1752(a2) # 1ff8 <__clone+0xe6>
    1928:	a019                	j	192e <strlen+0x38>
    192a:	6794                	ld	a3,8(a5)
    192c:	07a1                	addi	a5,a5,8
    192e:	00b68733          	add	a4,a3,a1
    1932:	fff6c693          	not	a3,a3
    1936:	8f75                	and	a4,a4,a3
    1938:	8f71                	and	a4,a4,a2
    193a:	db65                	beqz	a4,192a <strlen+0x34>
    for (; *s; s++)
    193c:	0007c703          	lbu	a4,0(a5)
    1940:	d779                	beqz	a4,190e <strlen+0x18>
    1942:	0017c703          	lbu	a4,1(a5)
    1946:	0785                	addi	a5,a5,1
    1948:	d379                	beqz	a4,190e <strlen+0x18>
    194a:	0017c703          	lbu	a4,1(a5)
    194e:	0785                	addi	a5,a5,1
    1950:	fb6d                	bnez	a4,1942 <strlen+0x4c>
    1952:	bf75                	j	190e <strlen+0x18>

0000000000001954 <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1954:	00757713          	andi	a4,a0,7
{
    1958:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    195a:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    195e:	cb19                	beqz	a4,1974 <memchr+0x20>
    1960:	ce25                	beqz	a2,19d8 <memchr+0x84>
    1962:	0007c703          	lbu	a4,0(a5)
    1966:	04b70e63          	beq	a4,a1,19c2 <memchr+0x6e>
    196a:	0785                	addi	a5,a5,1
    196c:	0077f713          	andi	a4,a5,7
    1970:	167d                	addi	a2,a2,-1
    1972:	f77d                	bnez	a4,1960 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    1974:	4501                	li	a0,0
    if (n && *s != c)
    1976:	c235                	beqz	a2,19da <memchr+0x86>
    1978:	0007c703          	lbu	a4,0(a5)
    197c:	04b70363          	beq	a4,a1,19c2 <memchr+0x6e>
        size_t k = ONES * c;
    1980:	00000517          	auipc	a0,0x0
    1984:	68053503          	ld	a0,1664(a0) # 2000 <__clone+0xee>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1988:	471d                	li	a4,7
        size_t k = ONES * c;
    198a:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    198e:	02c77a63          	bgeu	a4,a2,19c2 <memchr+0x6e>
    1992:	00000897          	auipc	a7,0x0
    1996:	65e8b883          	ld	a7,1630(a7) # 1ff0 <__clone+0xde>
    199a:	00000817          	auipc	a6,0x0
    199e:	65e83803          	ld	a6,1630(a6) # 1ff8 <__clone+0xe6>
    19a2:	431d                	li	t1,7
    19a4:	a029                	j	19ae <memchr+0x5a>
    19a6:	1661                	addi	a2,a2,-8
    19a8:	07a1                	addi	a5,a5,8
    19aa:	02c37963          	bgeu	t1,a2,19dc <memchr+0x88>
    19ae:	6398                	ld	a4,0(a5)
    19b0:	8f29                	xor	a4,a4,a0
    19b2:	011706b3          	add	a3,a4,a7
    19b6:	fff74713          	not	a4,a4
    19ba:	8f75                	and	a4,a4,a3
    19bc:	01077733          	and	a4,a4,a6
    19c0:	d37d                	beqz	a4,19a6 <memchr+0x52>
    19c2:	853e                	mv	a0,a5
    19c4:	97b2                	add	a5,a5,a2
    19c6:	a021                	j	19ce <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19c8:	0505                	addi	a0,a0,1
    19ca:	00f50763          	beq	a0,a5,19d8 <memchr+0x84>
    19ce:	00054703          	lbu	a4,0(a0)
    19d2:	feb71be3          	bne	a4,a1,19c8 <memchr+0x74>
    19d6:	8082                	ret
    return n ? (void *)s : 0;
    19d8:	4501                	li	a0,0
}
    19da:	8082                	ret
    return n ? (void *)s : 0;
    19dc:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19de:	f275                	bnez	a2,19c2 <memchr+0x6e>
}
    19e0:	8082                	ret

00000000000019e2 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19e2:	1101                	addi	sp,sp,-32
    19e4:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19e6:	862e                	mv	a2,a1
{
    19e8:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19ea:	4581                	li	a1,0
{
    19ec:	e426                	sd	s1,8(sp)
    19ee:	ec06                	sd	ra,24(sp)
    19f0:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19f2:	f63ff0ef          	jal	1954 <memchr>
    return p ? p - s : n;
    19f6:	c519                	beqz	a0,1a04 <strnlen+0x22>
}
    19f8:	60e2                	ld	ra,24(sp)
    19fa:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19fc:	8d05                	sub	a0,a0,s1
}
    19fe:	64a2                	ld	s1,8(sp)
    1a00:	6105                	addi	sp,sp,32
    1a02:	8082                	ret
    1a04:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1a06:	8522                	mv	a0,s0
}
    1a08:	6442                	ld	s0,16(sp)
    1a0a:	64a2                	ld	s1,8(sp)
    1a0c:	6105                	addi	sp,sp,32
    1a0e:	8082                	ret

0000000000001a10 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    1a10:	00b547b3          	xor	a5,a0,a1
    1a14:	8b9d                	andi	a5,a5,7
    1a16:	eb95                	bnez	a5,1a4a <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    1a18:	0075f793          	andi	a5,a1,7
    1a1c:	e7b1                	bnez	a5,1a68 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a1e:	6198                	ld	a4,0(a1)
    1a20:	00000617          	auipc	a2,0x0
    1a24:	5d063603          	ld	a2,1488(a2) # 1ff0 <__clone+0xde>
    1a28:	00000817          	auipc	a6,0x0
    1a2c:	5d083803          	ld	a6,1488(a6) # 1ff8 <__clone+0xe6>
    1a30:	a029                	j	1a3a <strcpy+0x2a>
    1a32:	e118                	sd	a4,0(a0)
    1a34:	6598                	ld	a4,8(a1)
    1a36:	05a1                	addi	a1,a1,8
    1a38:	0521                	addi	a0,a0,8
    1a3a:	00c707b3          	add	a5,a4,a2
    1a3e:	fff74693          	not	a3,a4
    1a42:	8ff5                	and	a5,a5,a3
    1a44:	0107f7b3          	and	a5,a5,a6
    1a48:	d7ed                	beqz	a5,1a32 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a4a:	0005c783          	lbu	a5,0(a1)
    1a4e:	00f50023          	sb	a5,0(a0)
    1a52:	c785                	beqz	a5,1a7a <strcpy+0x6a>
    1a54:	0015c783          	lbu	a5,1(a1)
    1a58:	0505                	addi	a0,a0,1
    1a5a:	0585                	addi	a1,a1,1
    1a5c:	00f50023          	sb	a5,0(a0)
    1a60:	fbf5                	bnez	a5,1a54 <strcpy+0x44>
        ;
    return d;
}
    1a62:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a64:	0505                	addi	a0,a0,1
    1a66:	df45                	beqz	a4,1a1e <strcpy+0xe>
            if (!(*d = *s))
    1a68:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a6c:	0585                	addi	a1,a1,1
    1a6e:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a72:	00f50023          	sb	a5,0(a0)
    1a76:	f7fd                	bnez	a5,1a64 <strcpy+0x54>
}
    1a78:	8082                	ret
    1a7a:	8082                	ret

0000000000001a7c <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a7c:	00b547b3          	xor	a5,a0,a1
    1a80:	8b9d                	andi	a5,a5,7
    1a82:	1a079863          	bnez	a5,1c32 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a86:	0075f793          	andi	a5,a1,7
    1a8a:	16078463          	beqz	a5,1bf2 <strncpy+0x176>
    1a8e:	ea01                	bnez	a2,1a9e <strncpy+0x22>
    1a90:	a421                	j	1c98 <strncpy+0x21c>
    1a92:	167d                	addi	a2,a2,-1
    1a94:	0505                	addi	a0,a0,1
    1a96:	14070e63          	beqz	a4,1bf2 <strncpy+0x176>
    1a9a:	1a060863          	beqz	a2,1c4a <strncpy+0x1ce>
    1a9e:	0005c783          	lbu	a5,0(a1)
    1aa2:	0585                	addi	a1,a1,1
    1aa4:	0075f713          	andi	a4,a1,7
    1aa8:	00f50023          	sb	a5,0(a0)
    1aac:	f3fd                	bnez	a5,1a92 <strncpy+0x16>
    1aae:	4805                	li	a6,1
    1ab0:	1a061863          	bnez	a2,1c60 <strncpy+0x1e4>
    1ab4:	40a007b3          	neg	a5,a0
    1ab8:	8b9d                	andi	a5,a5,7
    1aba:	4681                	li	a3,0
    1abc:	18061a63          	bnez	a2,1c50 <strncpy+0x1d4>
    1ac0:	00778713          	addi	a4,a5,7
    1ac4:	45ad                	li	a1,11
    1ac6:	18b76363          	bltu	a4,a1,1c4c <strncpy+0x1d0>
    1aca:	1ae6eb63          	bltu	a3,a4,1c80 <strncpy+0x204>
    1ace:	1a078363          	beqz	a5,1c74 <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1ad2:	00050023          	sb	zero,0(a0)
    1ad6:	4685                	li	a3,1
    1ad8:	00150713          	addi	a4,a0,1
    1adc:	18d78f63          	beq	a5,a3,1c7a <strncpy+0x1fe>
    1ae0:	000500a3          	sb	zero,1(a0)
    1ae4:	4689                	li	a3,2
    1ae6:	00250713          	addi	a4,a0,2
    1aea:	18d78e63          	beq	a5,a3,1c86 <strncpy+0x20a>
    1aee:	00050123          	sb	zero,2(a0)
    1af2:	468d                	li	a3,3
    1af4:	00350713          	addi	a4,a0,3
    1af8:	16d78c63          	beq	a5,a3,1c70 <strncpy+0x1f4>
    1afc:	000501a3          	sb	zero,3(a0)
    1b00:	4691                	li	a3,4
    1b02:	00450713          	addi	a4,a0,4
    1b06:	18d78263          	beq	a5,a3,1c8a <strncpy+0x20e>
    1b0a:	00050223          	sb	zero,4(a0)
    1b0e:	4695                	li	a3,5
    1b10:	00550713          	addi	a4,a0,5
    1b14:	16d78d63          	beq	a5,a3,1c8e <strncpy+0x212>
    1b18:	000502a3          	sb	zero,5(a0)
    1b1c:	469d                	li	a3,7
    1b1e:	00650713          	addi	a4,a0,6
    1b22:	16d79863          	bne	a5,a3,1c92 <strncpy+0x216>
    1b26:	00750713          	addi	a4,a0,7
    1b2a:	00050323          	sb	zero,6(a0)
    1b2e:	40f80833          	sub	a6,a6,a5
    1b32:	ff887593          	andi	a1,a6,-8
    1b36:	97aa                	add	a5,a5,a0
    1b38:	95be                	add	a1,a1,a5
    1b3a:	0007b023          	sd	zero,0(a5)
    1b3e:	07a1                	addi	a5,a5,8
    1b40:	feb79de3          	bne	a5,a1,1b3a <strncpy+0xbe>
    1b44:	ff887593          	andi	a1,a6,-8
    1b48:	9ead                	addw	a3,a3,a1
    1b4a:	00b707b3          	add	a5,a4,a1
    1b4e:	12b80863          	beq	a6,a1,1c7e <strncpy+0x202>
    1b52:	00078023          	sb	zero,0(a5)
    1b56:	0016871b          	addiw	a4,a3,1
    1b5a:	0ec77863          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1b5e:	000780a3          	sb	zero,1(a5)
    1b62:	0026871b          	addiw	a4,a3,2
    1b66:	0ec77263          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1b6a:	00078123          	sb	zero,2(a5)
    1b6e:	0036871b          	addiw	a4,a3,3
    1b72:	0cc77c63          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1b76:	000781a3          	sb	zero,3(a5)
    1b7a:	0046871b          	addiw	a4,a3,4
    1b7e:	0cc77663          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1b82:	00078223          	sb	zero,4(a5)
    1b86:	0056871b          	addiw	a4,a3,5
    1b8a:	0cc77063          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1b8e:	000782a3          	sb	zero,5(a5)
    1b92:	0066871b          	addiw	a4,a3,6
    1b96:	0ac77a63          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1b9a:	00078323          	sb	zero,6(a5)
    1b9e:	0076871b          	addiw	a4,a3,7
    1ba2:	0ac77463          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1ba6:	000783a3          	sb	zero,7(a5)
    1baa:	0086871b          	addiw	a4,a3,8
    1bae:	08c77e63          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1bb2:	00078423          	sb	zero,8(a5)
    1bb6:	0096871b          	addiw	a4,a3,9
    1bba:	08c77863          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1bbe:	000784a3          	sb	zero,9(a5)
    1bc2:	00a6871b          	addiw	a4,a3,10
    1bc6:	08c77263          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1bca:	00078523          	sb	zero,10(a5)
    1bce:	00b6871b          	addiw	a4,a3,11
    1bd2:	06c77c63          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1bd6:	000785a3          	sb	zero,11(a5)
    1bda:	00c6871b          	addiw	a4,a3,12
    1bde:	06c77663          	bgeu	a4,a2,1c4a <strncpy+0x1ce>
    1be2:	00078623          	sb	zero,12(a5)
    1be6:	26b5                	addiw	a3,a3,13
    1be8:	06c6f163          	bgeu	a3,a2,1c4a <strncpy+0x1ce>
    1bec:	000786a3          	sb	zero,13(a5)
    1bf0:	8082                	ret
            ;
        if (!n || !*s)
    1bf2:	c645                	beqz	a2,1c9a <strncpy+0x21e>
    1bf4:	0005c783          	lbu	a5,0(a1)
    1bf8:	ea078be3          	beqz	a5,1aae <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bfc:	479d                	li	a5,7
    1bfe:	02c7ff63          	bgeu	a5,a2,1c3c <strncpy+0x1c0>
    1c02:	00000897          	auipc	a7,0x0
    1c06:	3ee8b883          	ld	a7,1006(a7) # 1ff0 <__clone+0xde>
    1c0a:	00000817          	auipc	a6,0x0
    1c0e:	3ee83803          	ld	a6,1006(a6) # 1ff8 <__clone+0xe6>
    1c12:	431d                	li	t1,7
    1c14:	6198                	ld	a4,0(a1)
    1c16:	011707b3          	add	a5,a4,a7
    1c1a:	fff74693          	not	a3,a4
    1c1e:	8ff5                	and	a5,a5,a3
    1c20:	0107f7b3          	and	a5,a5,a6
    1c24:	ef81                	bnez	a5,1c3c <strncpy+0x1c0>
            *wd = *ws;
    1c26:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c28:	1661                	addi	a2,a2,-8
    1c2a:	05a1                	addi	a1,a1,8
    1c2c:	0521                	addi	a0,a0,8
    1c2e:	fec363e3          	bltu	t1,a2,1c14 <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c32:	e609                	bnez	a2,1c3c <strncpy+0x1c0>
    1c34:	a08d                	j	1c96 <strncpy+0x21a>
    1c36:	167d                	addi	a2,a2,-1
    1c38:	0505                	addi	a0,a0,1
    1c3a:	ca01                	beqz	a2,1c4a <strncpy+0x1ce>
    1c3c:	0005c783          	lbu	a5,0(a1)
    1c40:	0585                	addi	a1,a1,1
    1c42:	00f50023          	sb	a5,0(a0)
    1c46:	fbe5                	bnez	a5,1c36 <strncpy+0x1ba>
        ;
tail:
    1c48:	b59d                	j	1aae <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c4a:	8082                	ret
    1c4c:	472d                	li	a4,11
    1c4e:	bdb5                	j	1aca <strncpy+0x4e>
    1c50:	00778713          	addi	a4,a5,7
    1c54:	45ad                	li	a1,11
    1c56:	fff60693          	addi	a3,a2,-1
    1c5a:	e6b778e3          	bgeu	a4,a1,1aca <strncpy+0x4e>
    1c5e:	b7fd                	j	1c4c <strncpy+0x1d0>
    1c60:	40a007b3          	neg	a5,a0
    1c64:	8832                	mv	a6,a2
    1c66:	8b9d                	andi	a5,a5,7
    1c68:	4681                	li	a3,0
    1c6a:	e4060be3          	beqz	a2,1ac0 <strncpy+0x44>
    1c6e:	b7cd                	j	1c50 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c70:	468d                	li	a3,3
    1c72:	bd75                	j	1b2e <strncpy+0xb2>
    1c74:	872a                	mv	a4,a0
    1c76:	4681                	li	a3,0
    1c78:	bd5d                	j	1b2e <strncpy+0xb2>
    1c7a:	4685                	li	a3,1
    1c7c:	bd4d                	j	1b2e <strncpy+0xb2>
    1c7e:	8082                	ret
    1c80:	87aa                	mv	a5,a0
    1c82:	4681                	li	a3,0
    1c84:	b5f9                	j	1b52 <strncpy+0xd6>
    1c86:	4689                	li	a3,2
    1c88:	b55d                	j	1b2e <strncpy+0xb2>
    1c8a:	4691                	li	a3,4
    1c8c:	b54d                	j	1b2e <strncpy+0xb2>
    1c8e:	4695                	li	a3,5
    1c90:	bd79                	j	1b2e <strncpy+0xb2>
    1c92:	4699                	li	a3,6
    1c94:	bd69                	j	1b2e <strncpy+0xb2>
    1c96:	8082                	ret
    1c98:	8082                	ret
    1c9a:	8082                	ret

0000000000001c9c <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c9c:	87aa                	mv	a5,a0
    1c9e:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1ca0:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1ca4:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1ca8:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1caa:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cac:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1cb0:	2501                	sext.w	a0,a0
    1cb2:	8082                	ret

0000000000001cb4 <openat>:
    register long a7 __asm__("a7") = n;
    1cb4:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1cb8:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cbc:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1cc0:	2501                	sext.w	a0,a0
    1cc2:	8082                	ret

0000000000001cc4 <close>:
    register long a7 __asm__("a7") = n;
    1cc4:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cc8:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1ccc:	2501                	sext.w	a0,a0
    1cce:	8082                	ret

0000000000001cd0 <read>:
    register long a7 __asm__("a7") = n;
    1cd0:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cd4:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cd8:	8082                	ret

0000000000001cda <write>:
    register long a7 __asm__("a7") = n;
    1cda:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cde:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1ce2:	8082                	ret

0000000000001ce4 <getpid>:
    register long a7 __asm__("a7") = n;
    1ce4:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1ce8:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cec:	2501                	sext.w	a0,a0
    1cee:	8082                	ret

0000000000001cf0 <getppid>:
    register long a7 __asm__("a7") = n;
    1cf0:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cf4:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cf8:	2501                	sext.w	a0,a0
    1cfa:	8082                	ret

0000000000001cfc <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cfc:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d00:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1d04:	2501                	sext.w	a0,a0
    1d06:	8082                	ret

0000000000001d08 <fork>:
    register long a7 __asm__("a7") = n;
    1d08:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1d0c:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1d0e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d10:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1d14:	2501                	sext.w	a0,a0
    1d16:	8082                	ret

0000000000001d18 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1d18:	85b2                	mv	a1,a2
    1d1a:	863a                	mv	a2,a4
    if (stack)
    1d1c:	c191                	beqz	a1,1d20 <clone+0x8>
	stack += stack_size;
    1d1e:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d20:	4781                	li	a5,0
    1d22:	4701                	li	a4,0
    1d24:	4681                	li	a3,0
    1d26:	2601                	sext.w	a2,a2
    1d28:	a2ed                	j	1f12 <__clone>

0000000000001d2a <exit>:
    register long a7 __asm__("a7") = n;
    1d2a:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d2e:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d32:	8082                	ret

0000000000001d34 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d34:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d38:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d3a:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d3e:	2501                	sext.w	a0,a0
    1d40:	8082                	ret

0000000000001d42 <exec>:
    register long a7 __asm__("a7") = n;
    1d42:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d46:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d4a:	2501                	sext.w	a0,a0
    1d4c:	8082                	ret

0000000000001d4e <execve>:
    register long a7 __asm__("a7") = n;
    1d4e:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d52:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d56:	2501                	sext.w	a0,a0
    1d58:	8082                	ret

0000000000001d5a <times>:
    register long a7 __asm__("a7") = n;
    1d5a:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d5e:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d62:	2501                	sext.w	a0,a0
    1d64:	8082                	ret

0000000000001d66 <get_time>:

int64 get_time()
{
    1d66:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d68:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d6c:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d6e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d70:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d74:	2501                	sext.w	a0,a0
    1d76:	ed09                	bnez	a0,1d90 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d78:	67a2                	ld	a5,8(sp)
    1d7a:	3e800713          	li	a4,1000
    1d7e:	00015503          	lhu	a0,0(sp)
    1d82:	02e7d7b3          	divu	a5,a5,a4
    1d86:	02e50533          	mul	a0,a0,a4
    1d8a:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d8c:	0141                	addi	sp,sp,16
    1d8e:	8082                	ret
        return -1;
    1d90:	557d                	li	a0,-1
    1d92:	bfed                	j	1d8c <get_time+0x26>

0000000000001d94 <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d94:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d98:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d9c:	2501                	sext.w	a0,a0
    1d9e:	8082                	ret

0000000000001da0 <time>:
    register long a7 __asm__("a7") = n;
    1da0:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1da4:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1da8:	2501                	sext.w	a0,a0
    1daa:	8082                	ret

0000000000001dac <sleep>:

int sleep(unsigned long long time)
{
    1dac:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1dae:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1db0:	850a                	mv	a0,sp
    1db2:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1db4:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1db8:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dba:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dbe:	e501                	bnez	a0,1dc6 <sleep+0x1a>
    return 0;
    1dc0:	4501                	li	a0,0
}
    1dc2:	0141                	addi	sp,sp,16
    1dc4:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dc6:	4502                	lw	a0,0(sp)
}
    1dc8:	0141                	addi	sp,sp,16
    1dca:	8082                	ret

0000000000001dcc <set_priority>:
    register long a7 __asm__("a7") = n;
    1dcc:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1dd0:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1dd4:	2501                	sext.w	a0,a0
    1dd6:	8082                	ret

0000000000001dd8 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1dd8:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1ddc:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1de0:	8082                	ret

0000000000001de2 <munmap>:
    register long a7 __asm__("a7") = n;
    1de2:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1de6:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1dea:	2501                	sext.w	a0,a0
    1dec:	8082                	ret

0000000000001dee <wait>:

int wait(int *code)
{
    1dee:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1df0:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1df4:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1df6:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1df8:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1dfa:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1dfe:	2501                	sext.w	a0,a0
    1e00:	8082                	ret

0000000000001e02 <spawn>:
    register long a7 __asm__("a7") = n;
    1e02:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1e06:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1e0a:	2501                	sext.w	a0,a0
    1e0c:	8082                	ret

0000000000001e0e <mailread>:
    register long a7 __asm__("a7") = n;
    1e0e:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e12:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1e16:	2501                	sext.w	a0,a0
    1e18:	8082                	ret

0000000000001e1a <mailwrite>:
    register long a7 __asm__("a7") = n;
    1e1a:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e1e:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e22:	2501                	sext.w	a0,a0
    1e24:	8082                	ret

0000000000001e26 <fstat>:
    register long a7 __asm__("a7") = n;
    1e26:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e2a:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e2e:	2501                	sext.w	a0,a0
    1e30:	8082                	ret

0000000000001e32 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e32:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e34:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e38:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e3a:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e3e:	2501                	sext.w	a0,a0
    1e40:	8082                	ret

0000000000001e42 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e42:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e44:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e48:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e4a:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e4e:	2501                	sext.w	a0,a0
    1e50:	8082                	ret

0000000000001e52 <link>:

int link(char *old_path, char *new_path)
{
    1e52:	87aa                	mv	a5,a0
    1e54:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e56:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e5a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e5e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e60:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e64:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e66:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e6a:	2501                	sext.w	a0,a0
    1e6c:	8082                	ret

0000000000001e6e <unlink>:

int unlink(char *path)
{
    1e6e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e70:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e74:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e78:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e7a:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e7e:	2501                	sext.w	a0,a0
    1e80:	8082                	ret

0000000000001e82 <uname>:
    register long a7 __asm__("a7") = n;
    1e82:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e86:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e8a:	2501                	sext.w	a0,a0
    1e8c:	8082                	ret

0000000000001e8e <brk>:
    register long a7 __asm__("a7") = n;
    1e8e:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e92:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e96:	2501                	sext.w	a0,a0
    1e98:	8082                	ret

0000000000001e9a <getcwd>:
    register long a7 __asm__("a7") = n;
    1e9a:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e9c:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1ea0:	8082                	ret

0000000000001ea2 <chdir>:
    register long a7 __asm__("a7") = n;
    1ea2:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1ea6:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1eaa:	2501                	sext.w	a0,a0
    1eac:	8082                	ret

0000000000001eae <mkdir>:

int mkdir(const char *path, mode_t mode){
    1eae:	862e                	mv	a2,a1
    1eb0:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1eb2:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1eb4:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1eb8:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1ebc:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1ebe:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ec0:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1ec4:	2501                	sext.w	a0,a0
    1ec6:	8082                	ret

0000000000001ec8 <getdents>:
    register long a7 __asm__("a7") = n;
    1ec8:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ecc:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1ed0:	2501                	sext.w	a0,a0
    1ed2:	8082                	ret

0000000000001ed4 <pipe>:
    register long a7 __asm__("a7") = n;
    1ed4:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ed8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eda:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1ede:	2501                	sext.w	a0,a0
    1ee0:	8082                	ret

0000000000001ee2 <dup>:
    register long a7 __asm__("a7") = n;
    1ee2:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1ee4:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1ee8:	2501                	sext.w	a0,a0
    1eea:	8082                	ret

0000000000001eec <dup2>:
    register long a7 __asm__("a7") = n;
    1eec:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1eee:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ef0:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1ef4:	2501                	sext.w	a0,a0
    1ef6:	8082                	ret

0000000000001ef8 <mount>:
    register long a7 __asm__("a7") = n;
    1ef8:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1efc:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1f00:	2501                	sext.w	a0,a0
    1f02:	8082                	ret

0000000000001f04 <umount>:
    register long a7 __asm__("a7") = n;
    1f04:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1f08:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f0a:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1f0e:	2501                	sext.w	a0,a0
    1f10:	8082                	ret

0000000000001f12 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1f12:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1f14:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1f16:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1f18:	8532                	mv	a0,a2
	mv a2, a4
    1f1a:	863a                	mv	a2,a4
	mv a3, a5
    1f1c:	86be                	mv	a3,a5
	mv a4, a6
    1f1e:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f20:	0dc00893          	li	a7,220
	ecall
    1f24:	00000073          	ecall

	beqz a0, 1f
    1f28:	c111                	beqz	a0,1f2c <__clone+0x1a>
	# Parent
	ret
    1f2a:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f2c:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f2e:	6522                	ld	a0,8(sp)
	jalr a1
    1f30:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f32:	05d00893          	li	a7,93
	ecall
    1f36:	00000073          	ecall
