
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/pipe:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a281                	j	1142 <__start_main>

0000000000001004 <test_pipe>:
 * 成功测试时的输出：
 * "  Write to pipe successfully."
 */
static int fd[2];

void test_pipe(void){
    1004:	7135                	addi	sp,sp,-160
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f8250513          	addi	a0,a0,-126 # 1f88 <__clone+0x2e>
void test_pipe(void){
    100e:	ed06                	sd	ra,152(sp)
    1010:	e922                	sd	s0,144(sp)
    1012:	e526                	sd	s1,136(sp)
    TEST_START(__func__);
    1014:	3a0000ef          	jal	13b4 <puts>
    1018:	00001517          	auipc	a0,0x1
    101c:	02050513          	addi	a0,a0,32 # 2038 <__func__.0>
    1020:	394000ef          	jal	13b4 <puts>
    1024:	00001517          	auipc	a0,0x1
    1028:	f7c50513          	addi	a0,a0,-132 # 1fa0 <__clone+0x46>
    102c:	388000ef          	jal	13b4 <puts>
    int cpid;
    char buf[128] = {0};
    int ret = pipe(fd);
    1030:	00001517          	auipc	a0,0x1
    1034:	00050513          	mv	a0,a0
    char buf[128] = {0};
    1038:	e002                	sd	zero,0(sp)
    103a:	e402                	sd	zero,8(sp)
    103c:	e802                	sd	zero,16(sp)
    103e:	ec02                	sd	zero,24(sp)
    1040:	f002                	sd	zero,32(sp)
    1042:	f402                	sd	zero,40(sp)
    1044:	f802                	sd	zero,48(sp)
    1046:	fc02                	sd	zero,56(sp)
    1048:	e082                	sd	zero,64(sp)
    104a:	e482                	sd	zero,72(sp)
    104c:	e882                	sd	zero,80(sp)
    104e:	ec82                	sd	zero,88(sp)
    1050:	f082                	sd	zero,96(sp)
    1052:	f482                	sd	zero,104(sp)
    1054:	f882                	sd	zero,112(sp)
    1056:	fc82                	sd	zero,120(sp)
    int ret = pipe(fd);
    1058:	6c5000ef          	jal	1f1c <pipe>
    assert(ret != -1);
    105c:	57fd                	li	a5,-1
    105e:	0cf50363          	beq	a0,a5,1124 <test_pipe+0x120>
    const char *data = "  Write to pipe successfully.\n";
    cpid = fork();
    1062:	4ef000ef          	jal	1d50 <fork>
    1066:	842a                	mv	s0,a0
    printf("cpid: %d\n", cpid);
    1068:	85aa                	mv	a1,a0
    106a:	00001517          	auipc	a0,0x1
    106e:	f6650513          	addi	a0,a0,-154 # 1fd0 <__clone+0x76>
    1072:	364000ef          	jal	13d6 <printf>
    if(cpid > 0){
    1076:	06805a63          	blez	s0,10ea <test_pipe+0xe6>
	close(fd[1]);
    107a:	00001417          	auipc	s0,0x1
    107e:	fb640413          	addi	s0,s0,-74 # 2030 <fd>
    1082:	4048                	lw	a0,4(s0)
    1084:	489000ef          	jal	1d0c <close>
	while(read(fd[0], buf, 1) > 0)
    1088:	a019                	j	108e <test_pipe+0x8a>
            write(STDOUT, buf, 1);
    108a:	499000ef          	jal	1d22 <write>
	while(read(fd[0], buf, 1) > 0)
    108e:	4008                	lw	a0,0(s0)
    1090:	4605                	li	a2,1
    1092:	858a                	mv	a1,sp
    1094:	485000ef          	jal	1d18 <read>
    1098:	87aa                	mv	a5,a0
            write(STDOUT, buf, 1);
    109a:	4605                	li	a2,1
    109c:	858a                	mv	a1,sp
    109e:	4505                	li	a0,1
	while(read(fd[0], buf, 1) > 0)
    10a0:	fef045e3          	bgtz	a5,108a <test_pipe+0x86>
	write(STDOUT, "\n", 1);
    10a4:	00001597          	auipc	a1,0x1
    10a8:	f2458593          	addi	a1,a1,-220 # 1fc8 <__clone+0x6e>
    10ac:	477000ef          	jal	1d22 <write>
	close(fd[0]);
    10b0:	4008                	lw	a0,0(s0)
    10b2:	45b000ef          	jal	1d0c <close>
	wait(NULL);
    10b6:	4501                	li	a0,0
    10b8:	57f000ef          	jal	1e36 <wait>
	close(fd[0]);
	write(fd[1], data, strlen(data));
	close(fd[1]);
	exit(0);
    }
    TEST_END(__func__);
    10bc:	00001517          	auipc	a0,0x1
    10c0:	f4450513          	addi	a0,a0,-188 # 2000 <__clone+0xa6>
    10c4:	2f0000ef          	jal	13b4 <puts>
    10c8:	00001517          	auipc	a0,0x1
    10cc:	f7050513          	addi	a0,a0,-144 # 2038 <__func__.0>
    10d0:	2e4000ef          	jal	13b4 <puts>
    10d4:	00001517          	auipc	a0,0x1
    10d8:	ecc50513          	addi	a0,a0,-308 # 1fa0 <__clone+0x46>
    10dc:	2d8000ef          	jal	13b4 <puts>
}
    10e0:	60ea                	ld	ra,152(sp)
    10e2:	644a                	ld	s0,144(sp)
    10e4:	64aa                	ld	s1,136(sp)
    10e6:	610d                	addi	sp,sp,160
    10e8:	8082                	ret
	close(fd[0]);
    10ea:	00001417          	auipc	s0,0x1
    10ee:	f4640413          	addi	s0,s0,-186 # 2030 <fd>
    10f2:	4008                	lw	a0,0(s0)
    10f4:	419000ef          	jal	1d0c <close>
	write(fd[1], data, strlen(data));
    10f8:	4044                	lw	s1,4(s0)
    10fa:	00001517          	auipc	a0,0x1
    10fe:	ee650513          	addi	a0,a0,-282 # 1fe0 <__clone+0x86>
    1102:	03d000ef          	jal	193e <strlen>
    1106:	862a                	mv	a2,a0
    1108:	00001597          	auipc	a1,0x1
    110c:	ed858593          	addi	a1,a1,-296 # 1fe0 <__clone+0x86>
    1110:	8526                	mv	a0,s1
    1112:	411000ef          	jal	1d22 <write>
	close(fd[1]);
    1116:	4048                	lw	a0,4(s0)
    1118:	3f5000ef          	jal	1d0c <close>
	exit(0);
    111c:	4501                	li	a0,0
    111e:	455000ef          	jal	1d72 <exit>
    1122:	bf69                	j	10bc <test_pipe+0xb8>
    assert(ret != -1);
    1124:	00001517          	auipc	a0,0x1
    1128:	e8c50513          	addi	a0,a0,-372 # 1fb0 <__clone+0x56>
    112c:	534000ef          	jal	1660 <panic>
    1130:	bf0d                	j	1062 <test_pipe+0x5e>

0000000000001132 <main>:

int main(void){
    1132:	1141                	addi	sp,sp,-16
    1134:	e406                	sd	ra,8(sp)
    test_pipe();
    1136:	ecfff0ef          	jal	1004 <test_pipe>
    return 0;
}
    113a:	60a2                	ld	ra,8(sp)
    113c:	4501                	li	a0,0
    113e:	0141                	addi	sp,sp,16
    1140:	8082                	ret

0000000000001142 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    1142:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    1144:	4108                	lw	a0,0(a0)
{
    1146:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    1148:	05a1                	addi	a1,a1,8
{
    114a:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    114c:	fe7ff0ef          	jal	1132 <main>
    1150:	423000ef          	jal	1d72 <exit>
	return 0;
}
    1154:	60a2                	ld	ra,8(sp)
    1156:	4501                	li	a0,0
    1158:	0141                	addi	sp,sp,16
    115a:	8082                	ret

000000000000115c <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    115c:	7179                	addi	sp,sp,-48
    115e:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    1160:	12054b63          	bltz	a0,1296 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    1164:	02b577bb          	remuw	a5,a0,a1
    1168:	00001617          	auipc	a2,0x1
    116c:	ee060613          	addi	a2,a2,-288 # 2048 <digits>
    buf[16] = 0;
    1170:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1174:	0005871b          	sext.w	a4,a1
    1178:	1782                	slli	a5,a5,0x20
    117a:	9381                	srli	a5,a5,0x20
    117c:	97b2                	add	a5,a5,a2
    117e:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1182:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1186:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    118a:	1cb56363          	bltu	a0,a1,1350 <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    118e:	45b9                	li	a1,14
    1190:	02e877bb          	remuw	a5,a6,a4
    1194:	1782                	slli	a5,a5,0x20
    1196:	9381                	srli	a5,a5,0x20
    1198:	97b2                	add	a5,a5,a2
    119a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    119e:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    11a2:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    11a6:	0ce86e63          	bltu	a6,a4,1282 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    11aa:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    11ae:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    11b2:	1582                	slli	a1,a1,0x20
    11b4:	9181                	srli	a1,a1,0x20
    11b6:	95b2                	add	a1,a1,a2
    11b8:	0005c583          	lbu	a1,0(a1)
    11bc:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    11c0:	0007859b          	sext.w	a1,a5
    11c4:	12e6ec63          	bltu	a3,a4,12fc <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    11c8:	02e7f6bb          	remuw	a3,a5,a4
    11cc:	1682                	slli	a3,a3,0x20
    11ce:	9281                	srli	a3,a3,0x20
    11d0:	96b2                	add	a3,a3,a2
    11d2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11d6:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    11da:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    11de:	12e5e863          	bltu	a1,a4,130e <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    11e2:	02e876bb          	remuw	a3,a6,a4
    11e6:	1682                	slli	a3,a3,0x20
    11e8:	9281                	srli	a3,a3,0x20
    11ea:	96b2                	add	a3,a3,a2
    11ec:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11f0:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11f4:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    11f8:	12e86463          	bltu	a6,a4,1320 <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    11fc:	02e5f6bb          	remuw	a3,a1,a4
    1200:	1682                	slli	a3,a3,0x20
    1202:	9281                	srli	a3,a3,0x20
    1204:	96b2                	add	a3,a3,a2
    1206:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    120a:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    120e:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    1212:	0ce5ec63          	bltu	a1,a4,12ea <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    1216:	02e876bb          	remuw	a3,a6,a4
    121a:	1682                	slli	a3,a3,0x20
    121c:	9281                	srli	a3,a3,0x20
    121e:	96b2                	add	a3,a3,a2
    1220:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1224:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1228:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    122c:	10e86963          	bltu	a6,a4,133e <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    1230:	02e5f6bb          	remuw	a3,a1,a4
    1234:	1682                	slli	a3,a3,0x20
    1236:	9281                	srli	a3,a3,0x20
    1238:	96b2                	add	a3,a3,a2
    123a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    123e:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    1242:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1246:	10e5e763          	bltu	a1,a4,1354 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    124a:	02e876bb          	remuw	a3,a6,a4
    124e:	1682                	slli	a3,a3,0x20
    1250:	9281                	srli	a3,a3,0x20
    1252:	96b2                	add	a3,a3,a2
    1254:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1258:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    125c:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    1260:	10e86363          	bltu	a6,a4,1366 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    1264:	1782                	slli	a5,a5,0x20
    1266:	9381                	srli	a5,a5,0x20
    1268:	97b2                	add	a5,a5,a2
    126a:	0007c783          	lbu	a5,0(a5)
    126e:	4599                	li	a1,6
    1270:	00f10723          	sb	a5,14(sp)

    if (sign)
    1274:	00055763          	bgez	a0,1282 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1278:	02d00793          	li	a5,45
    127c:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    1280:	4595                	li	a1,5
    write(f, s, l);
    1282:	003c                	addi	a5,sp,8
    1284:	4641                	li	a2,16
    1286:	9e0d                	subw	a2,a2,a1
    1288:	4505                	li	a0,1
    128a:	95be                	add	a1,a1,a5
    128c:	297000ef          	jal	1d22 <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    1290:	70a2                	ld	ra,40(sp)
    1292:	6145                	addi	sp,sp,48
    1294:	8082                	ret
        x = -xx;
    1296:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    129a:	02b877bb          	remuw	a5,a6,a1
    129e:	00001617          	auipc	a2,0x1
    12a2:	daa60613          	addi	a2,a2,-598 # 2048 <digits>
    buf[16] = 0;
    12a6:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    12aa:	0005871b          	sext.w	a4,a1
    12ae:	1782                	slli	a5,a5,0x20
    12b0:	9381                	srli	a5,a5,0x20
    12b2:	97b2                	add	a5,a5,a2
    12b4:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    12b8:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    12bc:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    12c0:	06b86963          	bltu	a6,a1,1332 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    12c4:	02e8f7bb          	remuw	a5,a7,a4
    12c8:	1782                	slli	a5,a5,0x20
    12ca:	9381                	srli	a5,a5,0x20
    12cc:	97b2                	add	a5,a5,a2
    12ce:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    12d2:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    12d6:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    12da:	ece8f8e3          	bgeu	a7,a4,11aa <printint.constprop.0+0x4e>
        buf[i--] = '-';
    12de:	02d00793          	li	a5,45
    12e2:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    12e6:	45b5                	li	a1,13
    12e8:	bf69                	j	1282 <printint.constprop.0+0x126>
    12ea:	45a9                	li	a1,10
    if (sign)
    12ec:	f8055be3          	bgez	a0,1282 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12f0:	02d00793          	li	a5,45
    12f4:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    12f8:	45a5                	li	a1,9
    12fa:	b761                	j	1282 <printint.constprop.0+0x126>
    12fc:	45b5                	li	a1,13
    if (sign)
    12fe:	f80552e3          	bgez	a0,1282 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1302:	02d00793          	li	a5,45
    1306:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    130a:	45b1                	li	a1,12
    130c:	bf9d                	j	1282 <printint.constprop.0+0x126>
    130e:	45b1                	li	a1,12
    if (sign)
    1310:	f60559e3          	bgez	a0,1282 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1314:	02d00793          	li	a5,45
    1318:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    131c:	45ad                	li	a1,11
    131e:	b795                	j	1282 <printint.constprop.0+0x126>
    1320:	45ad                	li	a1,11
    if (sign)
    1322:	f60550e3          	bgez	a0,1282 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1326:	02d00793          	li	a5,45
    132a:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    132e:	45a9                	li	a1,10
    1330:	bf89                	j	1282 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1332:	02d00793          	li	a5,45
    1336:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    133a:	45b9                	li	a1,14
    133c:	b799                	j	1282 <printint.constprop.0+0x126>
    133e:	45a5                	li	a1,9
    if (sign)
    1340:	f40551e3          	bgez	a0,1282 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1344:	02d00793          	li	a5,45
    1348:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    134c:	45a1                	li	a1,8
    134e:	bf15                	j	1282 <printint.constprop.0+0x126>
    i = 15;
    1350:	45bd                	li	a1,15
    1352:	bf05                	j	1282 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1354:	45a1                	li	a1,8
    if (sign)
    1356:	f20556e3          	bgez	a0,1282 <printint.constprop.0+0x126>
        buf[i--] = '-';
    135a:	02d00793          	li	a5,45
    135e:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    1362:	459d                	li	a1,7
    1364:	bf39                	j	1282 <printint.constprop.0+0x126>
    1366:	459d                	li	a1,7
    if (sign)
    1368:	f0055de3          	bgez	a0,1282 <printint.constprop.0+0x126>
        buf[i--] = '-';
    136c:	02d00793          	li	a5,45
    1370:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    1374:	4599                	li	a1,6
    1376:	b731                	j	1282 <printint.constprop.0+0x126>

0000000000001378 <getchar>:
{
    1378:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    137a:	00f10593          	addi	a1,sp,15
    137e:	4605                	li	a2,1
    1380:	4501                	li	a0,0
{
    1382:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1384:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1388:	191000ef          	jal	1d18 <read>
}
    138c:	60e2                	ld	ra,24(sp)
    138e:	00f14503          	lbu	a0,15(sp)
    1392:	6105                	addi	sp,sp,32
    1394:	8082                	ret

0000000000001396 <putchar>:
{
    1396:	1101                	addi	sp,sp,-32
    1398:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    139a:	00f10593          	addi	a1,sp,15
    139e:	4605                	li	a2,1
    13a0:	4505                	li	a0,1
{
    13a2:	ec06                	sd	ra,24(sp)
    char byte = c;
    13a4:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    13a8:	17b000ef          	jal	1d22 <write>
}
    13ac:	60e2                	ld	ra,24(sp)
    13ae:	2501                	sext.w	a0,a0
    13b0:	6105                	addi	sp,sp,32
    13b2:	8082                	ret

00000000000013b4 <puts>:
{
    13b4:	1141                	addi	sp,sp,-16
    13b6:	e406                	sd	ra,8(sp)
    13b8:	e022                	sd	s0,0(sp)
    13ba:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    13bc:	582000ef          	jal	193e <strlen>
    13c0:	862a                	mv	a2,a0
    13c2:	85a2                	mv	a1,s0
    13c4:	4505                	li	a0,1
    13c6:	15d000ef          	jal	1d22 <write>
}
    13ca:	60a2                	ld	ra,8(sp)
    13cc:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    13ce:	957d                	srai	a0,a0,0x3f
    return r;
    13d0:	2501                	sext.w	a0,a0
}
    13d2:	0141                	addi	sp,sp,16
    13d4:	8082                	ret

00000000000013d6 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    13d6:	7131                	addi	sp,sp,-192
    13d8:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    13da:	013c                	addi	a5,sp,136
{
    13dc:	f0ca                	sd	s2,96(sp)
    13de:	ecce                	sd	s3,88(sp)
    13e0:	e8d2                	sd	s4,80(sp)
    13e2:	e4d6                	sd	s5,72(sp)
    13e4:	e0da                	sd	s6,64(sp)
    13e6:	fc5e                	sd	s7,56(sp)
    13e8:	fc86                	sd	ra,120(sp)
    13ea:	f8a2                	sd	s0,112(sp)
    13ec:	f4a6                	sd	s1,104(sp)
    13ee:	e52e                	sd	a1,136(sp)
    13f0:	e932                	sd	a2,144(sp)
    13f2:	ed36                	sd	a3,152(sp)
    13f4:	f13a                	sd	a4,160(sp)
    13f6:	f942                	sd	a6,176(sp)
    13f8:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    13fa:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    13fc:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    1400:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    1404:	00001b97          	auipc	s7,0x1
    1408:	c0cb8b93          	addi	s7,s7,-1012 # 2010 <__clone+0xb6>
        switch (s[1])
    140c:	07800a93          	li	s5,120
    1410:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1414:	00001997          	auipc	s3,0x1
    1418:	c3498993          	addi	s3,s3,-972 # 2048 <digits>
        if (!*s)
    141c:	00054783          	lbu	a5,0(a0)
    1420:	16078c63          	beqz	a5,1598 <printf+0x1c2>
    1424:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    1426:	19278463          	beq	a5,s2,15ae <printf+0x1d8>
    142a:	00164783          	lbu	a5,1(a2)
    142e:	0605                	addi	a2,a2,1
    1430:	fbfd                	bnez	a5,1426 <printf+0x50>
    1432:	84b2                	mv	s1,a2
        l = z - a;
    1434:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1438:	85aa                	mv	a1,a0
    143a:	8622                	mv	a2,s0
    143c:	4505                	li	a0,1
    143e:	0e5000ef          	jal	1d22 <write>
        if (l)
    1442:	18041f63          	bnez	s0,15e0 <printf+0x20a>
        if (s[1] == 0)
    1446:	0014c783          	lbu	a5,1(s1)
    144a:	14078763          	beqz	a5,1598 <printf+0x1c2>
        switch (s[1])
    144e:	1d478163          	beq	a5,s4,1610 <printf+0x23a>
    1452:	18fa6963          	bltu	s4,a5,15e4 <printf+0x20e>
    1456:	1b678363          	beq	a5,s6,15fc <printf+0x226>
    145a:	07000713          	li	a4,112
    145e:	1ce79c63          	bne	a5,a4,1636 <printf+0x260>
            printptr(va_arg(ap, uint64));
    1462:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    1464:	03000793          	li	a5,48
    1468:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    146c:	631c                	ld	a5,0(a4)
    146e:	0721                	addi	a4,a4,8
    1470:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1472:	00479f93          	slli	t6,a5,0x4
    1476:	00879f13          	slli	t5,a5,0x8
    147a:	00c79e93          	slli	t4,a5,0xc
    147e:	01079e13          	slli	t3,a5,0x10
    1482:	01479313          	slli	t1,a5,0x14
    1486:	01879893          	slli	a7,a5,0x18
    148a:	01c79713          	slli	a4,a5,0x1c
    148e:	02479813          	slli	a6,a5,0x24
    1492:	02879513          	slli	a0,a5,0x28
    1496:	02c79593          	slli	a1,a5,0x2c
    149a:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    149e:	03c7d293          	srli	t0,a5,0x3c
    14a2:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14a6:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14aa:	03cfdf93          	srli	t6,t6,0x3c
    14ae:	03cf5f13          	srli	t5,t5,0x3c
    14b2:	03cede93          	srli	t4,t4,0x3c
    14b6:	03ce5e13          	srli	t3,t3,0x3c
    14ba:	03c35313          	srli	t1,t1,0x3c
    14be:	03c8d893          	srli	a7,a7,0x3c
    14c2:	9371                	srli	a4,a4,0x3c
    14c4:	03c85813          	srli	a6,a6,0x3c
    14c8:	9171                	srli	a0,a0,0x3c
    14ca:	91f1                	srli	a1,a1,0x3c
    14cc:	9271                	srli	a2,a2,0x3c
    14ce:	974e                	add	a4,a4,s3
    14d0:	92f1                	srli	a3,a3,0x3c
    14d2:	92ce                	add	t0,t0,s3
    14d4:	9fce                	add	t6,t6,s3
    14d6:	9f4e                	add	t5,t5,s3
    14d8:	9ece                	add	t4,t4,s3
    14da:	9e4e                	add	t3,t3,s3
    14dc:	934e                	add	t1,t1,s3
    14de:	98ce                	add	a7,a7,s3
    14e0:	93ce                	add	t2,t2,s3
    14e2:	984e                	add	a6,a6,s3
    14e4:	954e                	add	a0,a0,s3
    14e6:	95ce                	add	a1,a1,s3
    14e8:	964e                	add	a2,a2,s3
    14ea:	0002c283          	lbu	t0,0(t0)
    14ee:	000fcf83          	lbu	t6,0(t6)
    14f2:	000f4f03          	lbu	t5,0(t5)
    14f6:	000ece83          	lbu	t4,0(t4)
    14fa:	000e4e03          	lbu	t3,0(t3)
    14fe:	00034303          	lbu	t1,0(t1)
    1502:	0008c883          	lbu	a7,0(a7)
    1506:	00074403          	lbu	s0,0(a4)
    150a:	0003c383          	lbu	t2,0(t2)
    150e:	00084803          	lbu	a6,0(a6)
    1512:	00054503          	lbu	a0,0(a0)
    1516:	0005c583          	lbu	a1,0(a1)
    151a:	00064603          	lbu	a2,0(a2)
    151e:	00d98733          	add	a4,s3,a3
    1522:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1526:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    152a:	9371                	srli	a4,a4,0x3c
    152c:	8bbd                	andi	a5,a5,15
    152e:	00510523          	sb	t0,10(sp)
    1532:	01f105a3          	sb	t6,11(sp)
    1536:	01e10623          	sb	t5,12(sp)
    153a:	01d106a3          	sb	t4,13(sp)
    153e:	01c10723          	sb	t3,14(sp)
    1542:	006107a3          	sb	t1,15(sp)
    1546:	01110823          	sb	a7,16(sp)
    154a:	00710923          	sb	t2,18(sp)
    154e:	010109a3          	sb	a6,19(sp)
    1552:	00a10a23          	sb	a0,20(sp)
    1556:	00b10aa3          	sb	a1,21(sp)
    155a:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    155e:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1562:	008108a3          	sb	s0,17(sp)
    1566:	974e                	add	a4,a4,s3
    1568:	97ce                	add	a5,a5,s3
    156a:	00d10ba3          	sb	a3,23(sp)
    156e:	00074703          	lbu	a4,0(a4)
    1572:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1576:	4649                	li	a2,18
    1578:	002c                	addi	a1,sp,8
    157a:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    157c:	00e10c23          	sb	a4,24(sp)
    1580:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1584:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1588:	79a000ef          	jal	1d22 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    158c:	00248513          	addi	a0,s1,2
        if (!*s)
    1590:	00054783          	lbu	a5,0(a0)
    1594:	e80798e3          	bnez	a5,1424 <printf+0x4e>
    }
    va_end(ap);
}
    1598:	70e6                	ld	ra,120(sp)
    159a:	7446                	ld	s0,112(sp)
    159c:	74a6                	ld	s1,104(sp)
    159e:	7906                	ld	s2,96(sp)
    15a0:	69e6                	ld	s3,88(sp)
    15a2:	6a46                	ld	s4,80(sp)
    15a4:	6aa6                	ld	s5,72(sp)
    15a6:	6b06                	ld	s6,64(sp)
    15a8:	7be2                	ld	s7,56(sp)
    15aa:	6129                	addi	sp,sp,192
    15ac:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    15ae:	00064783          	lbu	a5,0(a2)
    15b2:	84b2                	mv	s1,a2
    15b4:	01278963          	beq	a5,s2,15c6 <printf+0x1f0>
    15b8:	bdb5                	j	1434 <printf+0x5e>
    15ba:	0024c783          	lbu	a5,2(s1)
    15be:	0605                	addi	a2,a2,1
    15c0:	0489                	addi	s1,s1,2
    15c2:	e72799e3          	bne	a5,s2,1434 <printf+0x5e>
    15c6:	0014c783          	lbu	a5,1(s1)
    15ca:	ff2788e3          	beq	a5,s2,15ba <printf+0x1e4>
        l = z - a;
    15ce:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    15d2:	85aa                	mv	a1,a0
    15d4:	8622                	mv	a2,s0
    15d6:	4505                	li	a0,1
    15d8:	74a000ef          	jal	1d22 <write>
        if (l)
    15dc:	e60405e3          	beqz	s0,1446 <printf+0x70>
    15e0:	8526                	mv	a0,s1
    15e2:	bd2d                	j	141c <printf+0x46>
        switch (s[1])
    15e4:	05579963          	bne	a5,s5,1636 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    15e8:	6782                	ld	a5,0(sp)
    15ea:	45c1                	li	a1,16
    15ec:	4388                	lw	a0,0(a5)
    15ee:	07a1                	addi	a5,a5,8
    15f0:	e03e                	sd	a5,0(sp)
    15f2:	b6bff0ef          	jal	115c <printint.constprop.0>
        s += 2;
    15f6:	00248513          	addi	a0,s1,2
    15fa:	bf59                	j	1590 <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    15fc:	6782                	ld	a5,0(sp)
    15fe:	45a9                	li	a1,10
    1600:	4388                	lw	a0,0(a5)
    1602:	07a1                	addi	a5,a5,8
    1604:	e03e                	sd	a5,0(sp)
    1606:	b57ff0ef          	jal	115c <printint.constprop.0>
        s += 2;
    160a:	00248513          	addi	a0,s1,2
    160e:	b749                	j	1590 <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    1610:	6782                	ld	a5,0(sp)
    1612:	6380                	ld	s0,0(a5)
    1614:	07a1                	addi	a5,a5,8
    1616:	e03e                	sd	a5,0(sp)
    1618:	c031                	beqz	s0,165c <printf+0x286>
            l = strnlen(a, 200);
    161a:	0c800593          	li	a1,200
    161e:	8522                	mv	a0,s0
    1620:	40a000ef          	jal	1a2a <strnlen>
    write(f, s, l);
    1624:	0005061b          	sext.w	a2,a0
    1628:	85a2                	mv	a1,s0
    162a:	4505                	li	a0,1
    162c:	6f6000ef          	jal	1d22 <write>
        s += 2;
    1630:	00248513          	addi	a0,s1,2
    1634:	bfb1                	j	1590 <printf+0x1ba>
    return write(stdout, &byte, 1);
    1636:	4605                	li	a2,1
    1638:	002c                	addi	a1,sp,8
    163a:	4505                	li	a0,1
    char byte = c;
    163c:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    1640:	6e2000ef          	jal	1d22 <write>
    char byte = c;
    1644:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    1648:	4605                	li	a2,1
    164a:	002c                	addi	a1,sp,8
    164c:	4505                	li	a0,1
    char byte = c;
    164e:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    1652:	6d0000ef          	jal	1d22 <write>
        s += 2;
    1656:	00248513          	addi	a0,s1,2
    165a:	bf1d                	j	1590 <printf+0x1ba>
                a = "(null)";
    165c:	845e                	mv	s0,s7
    165e:	bf75                	j	161a <printf+0x244>

0000000000001660 <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    1660:	1141                	addi	sp,sp,-16
    1662:	e406                	sd	ra,8(sp)
    puts(m);
    1664:	d51ff0ef          	jal	13b4 <puts>
    exit(-100);
}
    1668:	60a2                	ld	ra,8(sp)
    exit(-100);
    166a:	f9c00513          	li	a0,-100
}
    166e:	0141                	addi	sp,sp,16
    exit(-100);
    1670:	a709                	j	1d72 <exit>

0000000000001672 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1672:	02000793          	li	a5,32
    1676:	00f50663          	beq	a0,a5,1682 <isspace+0x10>
    167a:	355d                	addiw	a0,a0,-9
    167c:	00553513          	sltiu	a0,a0,5
    1680:	8082                	ret
    1682:	4505                	li	a0,1
}
    1684:	8082                	ret

0000000000001686 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1686:	fd05051b          	addiw	a0,a0,-48
}
    168a:	00a53513          	sltiu	a0,a0,10
    168e:	8082                	ret

0000000000001690 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1690:	02000613          	li	a2,32
    1694:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1696:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    169a:	ff77069b          	addiw	a3,a4,-9
    169e:	04c70d63          	beq	a4,a2,16f8 <atoi+0x68>
    16a2:	0007079b          	sext.w	a5,a4
    16a6:	04d5f963          	bgeu	a1,a3,16f8 <atoi+0x68>
        s++;
    switch (*s)
    16aa:	02b00693          	li	a3,43
    16ae:	04d70a63          	beq	a4,a3,1702 <atoi+0x72>
    16b2:	02d00693          	li	a3,45
    16b6:	06d70463          	beq	a4,a3,171e <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    16ba:	fd07859b          	addiw	a1,a5,-48
    16be:	4625                	li	a2,9
    16c0:	873e                	mv	a4,a5
    16c2:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    16c4:	4e01                	li	t3,0
    while (isdigit(*s))
    16c6:	04b66a63          	bltu	a2,a1,171a <atoi+0x8a>
    int n = 0, neg = 0;
    16ca:	4501                	li	a0,0
    while (isdigit(*s))
    16cc:	4825                	li	a6,9
    16ce:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    16d2:	0025179b          	slliw	a5,a0,0x2
    16d6:	9d3d                	addw	a0,a0,a5
    16d8:	fd07031b          	addiw	t1,a4,-48
    16dc:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    16e0:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    16e4:	0685                	addi	a3,a3,1
    16e6:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    16ea:	0006071b          	sext.w	a4,a2
    16ee:	feb870e3          	bgeu	a6,a1,16ce <atoi+0x3e>
    return neg ? n : -n;
    16f2:	000e0563          	beqz	t3,16fc <atoi+0x6c>
}
    16f6:	8082                	ret
        s++;
    16f8:	0505                	addi	a0,a0,1
    16fa:	bf71                	j	1696 <atoi+0x6>
    return neg ? n : -n;
    16fc:	4113053b          	subw	a0,t1,a7
    1700:	8082                	ret
    while (isdigit(*s))
    1702:	00154783          	lbu	a5,1(a0)
    1706:	4625                	li	a2,9
        s++;
    1708:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    170c:	fd07859b          	addiw	a1,a5,-48
    1710:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1714:	4e01                	li	t3,0
    while (isdigit(*s))
    1716:	fab67ae3          	bgeu	a2,a1,16ca <atoi+0x3a>
    171a:	4501                	li	a0,0
}
    171c:	8082                	ret
    while (isdigit(*s))
    171e:	00154783          	lbu	a5,1(a0)
    1722:	4625                	li	a2,9
        s++;
    1724:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1728:	fd07859b          	addiw	a1,a5,-48
    172c:	0007871b          	sext.w	a4,a5
    1730:	feb665e3          	bltu	a2,a1,171a <atoi+0x8a>
        neg = 1;
    1734:	4e05                	li	t3,1
    1736:	bf51                	j	16ca <atoi+0x3a>

0000000000001738 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    1738:	16060d63          	beqz	a2,18b2 <memset+0x17a>
    173c:	40a007b3          	neg	a5,a0
    1740:	8b9d                	andi	a5,a5,7
    1742:	00778713          	addi	a4,a5,7
    1746:	482d                	li	a6,11
    1748:	0ff5f593          	zext.b	a1,a1
    174c:	fff60693          	addi	a3,a2,-1
    1750:	17076263          	bltu	a4,a6,18b4 <memset+0x17c>
    1754:	16e6ea63          	bltu	a3,a4,18c8 <memset+0x190>
    1758:	16078563          	beqz	a5,18c2 <memset+0x18a>
    175c:	00b50023          	sb	a1,0(a0)
    1760:	4705                	li	a4,1
    1762:	00150e93          	addi	t4,a0,1
    1766:	14e78c63          	beq	a5,a4,18be <memset+0x186>
    176a:	00b500a3          	sb	a1,1(a0)
    176e:	4709                	li	a4,2
    1770:	00250e93          	addi	t4,a0,2
    1774:	14e78d63          	beq	a5,a4,18ce <memset+0x196>
    1778:	00b50123          	sb	a1,2(a0)
    177c:	470d                	li	a4,3
    177e:	00350e93          	addi	t4,a0,3
    1782:	12e78b63          	beq	a5,a4,18b8 <memset+0x180>
    1786:	00b501a3          	sb	a1,3(a0)
    178a:	4711                	li	a4,4
    178c:	00450e93          	addi	t4,a0,4
    1790:	14e78163          	beq	a5,a4,18d2 <memset+0x19a>
    1794:	00b50223          	sb	a1,4(a0)
    1798:	4715                	li	a4,5
    179a:	00550e93          	addi	t4,a0,5
    179e:	12e78c63          	beq	a5,a4,18d6 <memset+0x19e>
    17a2:	00b502a3          	sb	a1,5(a0)
    17a6:	471d                	li	a4,7
    17a8:	00650e93          	addi	t4,a0,6
    17ac:	12e79763          	bne	a5,a4,18da <memset+0x1a2>
    17b0:	00750e93          	addi	t4,a0,7
    17b4:	00b50323          	sb	a1,6(a0)
    17b8:	4f1d                	li	t5,7
    17ba:	00859713          	slli	a4,a1,0x8
    17be:	8f4d                	or	a4,a4,a1
    17c0:	01059e13          	slli	t3,a1,0x10
    17c4:	01c76e33          	or	t3,a4,t3
    17c8:	01859313          	slli	t1,a1,0x18
    17cc:	006e6333          	or	t1,t3,t1
    17d0:	02059893          	slli	a7,a1,0x20
    17d4:	011368b3          	or	a7,t1,a7
    17d8:	02859813          	slli	a6,a1,0x28
    17dc:	40f60333          	sub	t1,a2,a5
    17e0:	0108e833          	or	a6,a7,a6
    17e4:	03059693          	slli	a3,a1,0x30
    17e8:	00d866b3          	or	a3,a6,a3
    17ec:	03859713          	slli	a4,a1,0x38
    17f0:	97aa                	add	a5,a5,a0
    17f2:	ff837813          	andi	a6,t1,-8
    17f6:	8f55                	or	a4,a4,a3
    17f8:	00f806b3          	add	a3,a6,a5
    17fc:	e398                	sd	a4,0(a5)
    17fe:	07a1                	addi	a5,a5,8
    1800:	fed79ee3          	bne	a5,a3,17fc <memset+0xc4>
    1804:	ff837693          	andi	a3,t1,-8
    1808:	00de87b3          	add	a5,t4,a3
    180c:	01e6873b          	addw	a4,a3,t5
    1810:	0ad30663          	beq	t1,a3,18bc <memset+0x184>
    1814:	00b78023          	sb	a1,0(a5)
    1818:	0017069b          	addiw	a3,a4,1
    181c:	08c6fb63          	bgeu	a3,a2,18b2 <memset+0x17a>
    1820:	00b780a3          	sb	a1,1(a5)
    1824:	0027069b          	addiw	a3,a4,2
    1828:	08c6f563          	bgeu	a3,a2,18b2 <memset+0x17a>
    182c:	00b78123          	sb	a1,2(a5)
    1830:	0037069b          	addiw	a3,a4,3
    1834:	06c6ff63          	bgeu	a3,a2,18b2 <memset+0x17a>
    1838:	00b781a3          	sb	a1,3(a5)
    183c:	0047069b          	addiw	a3,a4,4
    1840:	06c6f963          	bgeu	a3,a2,18b2 <memset+0x17a>
    1844:	00b78223          	sb	a1,4(a5)
    1848:	0057069b          	addiw	a3,a4,5
    184c:	06c6f363          	bgeu	a3,a2,18b2 <memset+0x17a>
    1850:	00b782a3          	sb	a1,5(a5)
    1854:	0067069b          	addiw	a3,a4,6
    1858:	04c6fd63          	bgeu	a3,a2,18b2 <memset+0x17a>
    185c:	00b78323          	sb	a1,6(a5)
    1860:	0077069b          	addiw	a3,a4,7
    1864:	04c6f763          	bgeu	a3,a2,18b2 <memset+0x17a>
    1868:	00b783a3          	sb	a1,7(a5)
    186c:	0087069b          	addiw	a3,a4,8
    1870:	04c6f163          	bgeu	a3,a2,18b2 <memset+0x17a>
    1874:	00b78423          	sb	a1,8(a5)
    1878:	0097069b          	addiw	a3,a4,9
    187c:	02c6fb63          	bgeu	a3,a2,18b2 <memset+0x17a>
    1880:	00b784a3          	sb	a1,9(a5)
    1884:	00a7069b          	addiw	a3,a4,10
    1888:	02c6f563          	bgeu	a3,a2,18b2 <memset+0x17a>
    188c:	00b78523          	sb	a1,10(a5)
    1890:	00b7069b          	addiw	a3,a4,11
    1894:	00c6ff63          	bgeu	a3,a2,18b2 <memset+0x17a>
    1898:	00b785a3          	sb	a1,11(a5)
    189c:	00c7069b          	addiw	a3,a4,12
    18a0:	00c6f963          	bgeu	a3,a2,18b2 <memset+0x17a>
    18a4:	00b78623          	sb	a1,12(a5)
    18a8:	2735                	addiw	a4,a4,13
    18aa:	00c77463          	bgeu	a4,a2,18b2 <memset+0x17a>
    18ae:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    18b2:	8082                	ret
    18b4:	472d                	li	a4,11
    18b6:	bd79                	j	1754 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    18b8:	4f0d                	li	t5,3
    18ba:	b701                	j	17ba <memset+0x82>
    18bc:	8082                	ret
    18be:	4f05                	li	t5,1
    18c0:	bded                	j	17ba <memset+0x82>
    18c2:	8eaa                	mv	t4,a0
    18c4:	4f01                	li	t5,0
    18c6:	bdd5                	j	17ba <memset+0x82>
    18c8:	87aa                	mv	a5,a0
    18ca:	4701                	li	a4,0
    18cc:	b7a1                	j	1814 <memset+0xdc>
    18ce:	4f09                	li	t5,2
    18d0:	b5ed                	j	17ba <memset+0x82>
    18d2:	4f11                	li	t5,4
    18d4:	b5dd                	j	17ba <memset+0x82>
    18d6:	4f15                	li	t5,5
    18d8:	b5cd                	j	17ba <memset+0x82>
    18da:	4f19                	li	t5,6
    18dc:	bdf9                	j	17ba <memset+0x82>

00000000000018de <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    18de:	00054783          	lbu	a5,0(a0)
    18e2:	0005c703          	lbu	a4,0(a1)
    18e6:	00e79863          	bne	a5,a4,18f6 <strcmp+0x18>
    18ea:	0505                	addi	a0,a0,1
    18ec:	0585                	addi	a1,a1,1
    18ee:	fbe5                	bnez	a5,18de <strcmp>
    18f0:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    18f2:	9d19                	subw	a0,a0,a4
    18f4:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    18f6:	0007851b          	sext.w	a0,a5
    18fa:	bfe5                	j	18f2 <strcmp+0x14>

00000000000018fc <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    18fc:	ce05                	beqz	a2,1934 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18fe:	00054703          	lbu	a4,0(a0)
    1902:	0005c783          	lbu	a5,0(a1)
    1906:	cb0d                	beqz	a4,1938 <strncmp+0x3c>
    if (!n--)
    1908:	167d                	addi	a2,a2,-1
    190a:	00c506b3          	add	a3,a0,a2
    190e:	a819                	j	1924 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1910:	00a68e63          	beq	a3,a0,192c <strncmp+0x30>
    1914:	0505                	addi	a0,a0,1
    1916:	00e79b63          	bne	a5,a4,192c <strncmp+0x30>
    191a:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    191e:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1922:	cb19                	beqz	a4,1938 <strncmp+0x3c>
    1924:	0005c783          	lbu	a5,0(a1)
    1928:	0585                	addi	a1,a1,1
    192a:	f3fd                	bnez	a5,1910 <strncmp+0x14>
    return *l - *r;
    192c:	0007051b          	sext.w	a0,a4
    1930:	9d1d                	subw	a0,a0,a5
    1932:	8082                	ret
        return 0;
    1934:	4501                	li	a0,0
}
    1936:	8082                	ret
    1938:	4501                	li	a0,0
    return *l - *r;
    193a:	9d1d                	subw	a0,a0,a5
    193c:	8082                	ret

000000000000193e <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    193e:	00757793          	andi	a5,a0,7
    1942:	cf89                	beqz	a5,195c <strlen+0x1e>
    1944:	87aa                	mv	a5,a0
    1946:	a029                	j	1950 <strlen+0x12>
    1948:	0785                	addi	a5,a5,1
    194a:	0077f713          	andi	a4,a5,7
    194e:	cb01                	beqz	a4,195e <strlen+0x20>
        if (!*s)
    1950:	0007c703          	lbu	a4,0(a5)
    1954:	fb75                	bnez	a4,1948 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    1956:	40a78533          	sub	a0,a5,a0
}
    195a:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    195c:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    195e:	6394                	ld	a3,0(a5)
    1960:	00000597          	auipc	a1,0x0
    1964:	6b85b583          	ld	a1,1720(a1) # 2018 <__clone+0xbe>
    1968:	00000617          	auipc	a2,0x0
    196c:	6b863603          	ld	a2,1720(a2) # 2020 <__clone+0xc6>
    1970:	a019                	j	1976 <strlen+0x38>
    1972:	6794                	ld	a3,8(a5)
    1974:	07a1                	addi	a5,a5,8
    1976:	00b68733          	add	a4,a3,a1
    197a:	fff6c693          	not	a3,a3
    197e:	8f75                	and	a4,a4,a3
    1980:	8f71                	and	a4,a4,a2
    1982:	db65                	beqz	a4,1972 <strlen+0x34>
    for (; *s; s++)
    1984:	0007c703          	lbu	a4,0(a5)
    1988:	d779                	beqz	a4,1956 <strlen+0x18>
    198a:	0017c703          	lbu	a4,1(a5)
    198e:	0785                	addi	a5,a5,1
    1990:	d379                	beqz	a4,1956 <strlen+0x18>
    1992:	0017c703          	lbu	a4,1(a5)
    1996:	0785                	addi	a5,a5,1
    1998:	fb6d                	bnez	a4,198a <strlen+0x4c>
    199a:	bf75                	j	1956 <strlen+0x18>

000000000000199c <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    199c:	00757713          	andi	a4,a0,7
{
    19a0:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    19a2:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    19a6:	cb19                	beqz	a4,19bc <memchr+0x20>
    19a8:	ce25                	beqz	a2,1a20 <memchr+0x84>
    19aa:	0007c703          	lbu	a4,0(a5)
    19ae:	04b70e63          	beq	a4,a1,1a0a <memchr+0x6e>
    19b2:	0785                	addi	a5,a5,1
    19b4:	0077f713          	andi	a4,a5,7
    19b8:	167d                	addi	a2,a2,-1
    19ba:	f77d                	bnez	a4,19a8 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    19bc:	4501                	li	a0,0
    if (n && *s != c)
    19be:	c235                	beqz	a2,1a22 <memchr+0x86>
    19c0:	0007c703          	lbu	a4,0(a5)
    19c4:	04b70363          	beq	a4,a1,1a0a <memchr+0x6e>
        size_t k = ONES * c;
    19c8:	00000517          	auipc	a0,0x0
    19cc:	66053503          	ld	a0,1632(a0) # 2028 <__clone+0xce>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    19d0:	471d                	li	a4,7
        size_t k = ONES * c;
    19d2:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    19d6:	02c77a63          	bgeu	a4,a2,1a0a <memchr+0x6e>
    19da:	00000897          	auipc	a7,0x0
    19de:	63e8b883          	ld	a7,1598(a7) # 2018 <__clone+0xbe>
    19e2:	00000817          	auipc	a6,0x0
    19e6:	63e83803          	ld	a6,1598(a6) # 2020 <__clone+0xc6>
    19ea:	431d                	li	t1,7
    19ec:	a029                	j	19f6 <memchr+0x5a>
    19ee:	1661                	addi	a2,a2,-8
    19f0:	07a1                	addi	a5,a5,8
    19f2:	02c37963          	bgeu	t1,a2,1a24 <memchr+0x88>
    19f6:	6398                	ld	a4,0(a5)
    19f8:	8f29                	xor	a4,a4,a0
    19fa:	011706b3          	add	a3,a4,a7
    19fe:	fff74713          	not	a4,a4
    1a02:	8f75                	and	a4,a4,a3
    1a04:	01077733          	and	a4,a4,a6
    1a08:	d37d                	beqz	a4,19ee <memchr+0x52>
    1a0a:	853e                	mv	a0,a5
    1a0c:	97b2                	add	a5,a5,a2
    1a0e:	a021                	j	1a16 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1a10:	0505                	addi	a0,a0,1
    1a12:	00f50763          	beq	a0,a5,1a20 <memchr+0x84>
    1a16:	00054703          	lbu	a4,0(a0)
    1a1a:	feb71be3          	bne	a4,a1,1a10 <memchr+0x74>
    1a1e:	8082                	ret
    return n ? (void *)s : 0;
    1a20:	4501                	li	a0,0
}
    1a22:	8082                	ret
    return n ? (void *)s : 0;
    1a24:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1a26:	f275                	bnez	a2,1a0a <memchr+0x6e>
}
    1a28:	8082                	ret

0000000000001a2a <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    1a2a:	1101                	addi	sp,sp,-32
    1a2c:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    1a2e:	862e                	mv	a2,a1
{
    1a30:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    1a32:	4581                	li	a1,0
{
    1a34:	e426                	sd	s1,8(sp)
    1a36:	ec06                	sd	ra,24(sp)
    1a38:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    1a3a:	f63ff0ef          	jal	199c <memchr>
    return p ? p - s : n;
    1a3e:	c519                	beqz	a0,1a4c <strnlen+0x22>
}
    1a40:	60e2                	ld	ra,24(sp)
    1a42:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1a44:	8d05                	sub	a0,a0,s1
}
    1a46:	64a2                	ld	s1,8(sp)
    1a48:	6105                	addi	sp,sp,32
    1a4a:	8082                	ret
    1a4c:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1a4e:	8522                	mv	a0,s0
}
    1a50:	6442                	ld	s0,16(sp)
    1a52:	64a2                	ld	s1,8(sp)
    1a54:	6105                	addi	sp,sp,32
    1a56:	8082                	ret

0000000000001a58 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    1a58:	00b547b3          	xor	a5,a0,a1
    1a5c:	8b9d                	andi	a5,a5,7
    1a5e:	eb95                	bnez	a5,1a92 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    1a60:	0075f793          	andi	a5,a1,7
    1a64:	e7b1                	bnez	a5,1ab0 <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a66:	6198                	ld	a4,0(a1)
    1a68:	00000617          	auipc	a2,0x0
    1a6c:	5b063603          	ld	a2,1456(a2) # 2018 <__clone+0xbe>
    1a70:	00000817          	auipc	a6,0x0
    1a74:	5b083803          	ld	a6,1456(a6) # 2020 <__clone+0xc6>
    1a78:	a029                	j	1a82 <strcpy+0x2a>
    1a7a:	e118                	sd	a4,0(a0)
    1a7c:	6598                	ld	a4,8(a1)
    1a7e:	05a1                	addi	a1,a1,8
    1a80:	0521                	addi	a0,a0,8
    1a82:	00c707b3          	add	a5,a4,a2
    1a86:	fff74693          	not	a3,a4
    1a8a:	8ff5                	and	a5,a5,a3
    1a8c:	0107f7b3          	and	a5,a5,a6
    1a90:	d7ed                	beqz	a5,1a7a <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a92:	0005c783          	lbu	a5,0(a1)
    1a96:	00f50023          	sb	a5,0(a0)
    1a9a:	c785                	beqz	a5,1ac2 <strcpy+0x6a>
    1a9c:	0015c783          	lbu	a5,1(a1)
    1aa0:	0505                	addi	a0,a0,1
    1aa2:	0585                	addi	a1,a1,1
    1aa4:	00f50023          	sb	a5,0(a0)
    1aa8:	fbf5                	bnez	a5,1a9c <strcpy+0x44>
        ;
    return d;
}
    1aaa:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1aac:	0505                	addi	a0,a0,1
    1aae:	df45                	beqz	a4,1a66 <strcpy+0xe>
            if (!(*d = *s))
    1ab0:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1ab4:	0585                	addi	a1,a1,1
    1ab6:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1aba:	00f50023          	sb	a5,0(a0)
    1abe:	f7fd                	bnez	a5,1aac <strcpy+0x54>
}
    1ac0:	8082                	ret
    1ac2:	8082                	ret

0000000000001ac4 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1ac4:	00b547b3          	xor	a5,a0,a1
    1ac8:	8b9d                	andi	a5,a5,7
    1aca:	1a079863          	bnez	a5,1c7a <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1ace:	0075f793          	andi	a5,a1,7
    1ad2:	16078463          	beqz	a5,1c3a <strncpy+0x176>
    1ad6:	ea01                	bnez	a2,1ae6 <strncpy+0x22>
    1ad8:	a421                	j	1ce0 <strncpy+0x21c>
    1ada:	167d                	addi	a2,a2,-1
    1adc:	0505                	addi	a0,a0,1
    1ade:	14070e63          	beqz	a4,1c3a <strncpy+0x176>
    1ae2:	1a060863          	beqz	a2,1c92 <strncpy+0x1ce>
    1ae6:	0005c783          	lbu	a5,0(a1)
    1aea:	0585                	addi	a1,a1,1
    1aec:	0075f713          	andi	a4,a1,7
    1af0:	00f50023          	sb	a5,0(a0)
    1af4:	f3fd                	bnez	a5,1ada <strncpy+0x16>
    1af6:	4805                	li	a6,1
    1af8:	1a061863          	bnez	a2,1ca8 <strncpy+0x1e4>
    1afc:	40a007b3          	neg	a5,a0
    1b00:	8b9d                	andi	a5,a5,7
    1b02:	4681                	li	a3,0
    1b04:	18061a63          	bnez	a2,1c98 <strncpy+0x1d4>
    1b08:	00778713          	addi	a4,a5,7
    1b0c:	45ad                	li	a1,11
    1b0e:	18b76363          	bltu	a4,a1,1c94 <strncpy+0x1d0>
    1b12:	1ae6eb63          	bltu	a3,a4,1cc8 <strncpy+0x204>
    1b16:	1a078363          	beqz	a5,1cbc <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1b1a:	00050023          	sb	zero,0(a0)
    1b1e:	4685                	li	a3,1
    1b20:	00150713          	addi	a4,a0,1
    1b24:	18d78f63          	beq	a5,a3,1cc2 <strncpy+0x1fe>
    1b28:	000500a3          	sb	zero,1(a0)
    1b2c:	4689                	li	a3,2
    1b2e:	00250713          	addi	a4,a0,2
    1b32:	18d78e63          	beq	a5,a3,1cce <strncpy+0x20a>
    1b36:	00050123          	sb	zero,2(a0)
    1b3a:	468d                	li	a3,3
    1b3c:	00350713          	addi	a4,a0,3
    1b40:	16d78c63          	beq	a5,a3,1cb8 <strncpy+0x1f4>
    1b44:	000501a3          	sb	zero,3(a0)
    1b48:	4691                	li	a3,4
    1b4a:	00450713          	addi	a4,a0,4
    1b4e:	18d78263          	beq	a5,a3,1cd2 <strncpy+0x20e>
    1b52:	00050223          	sb	zero,4(a0)
    1b56:	4695                	li	a3,5
    1b58:	00550713          	addi	a4,a0,5
    1b5c:	16d78d63          	beq	a5,a3,1cd6 <strncpy+0x212>
    1b60:	000502a3          	sb	zero,5(a0)
    1b64:	469d                	li	a3,7
    1b66:	00650713          	addi	a4,a0,6
    1b6a:	16d79863          	bne	a5,a3,1cda <strncpy+0x216>
    1b6e:	00750713          	addi	a4,a0,7
    1b72:	00050323          	sb	zero,6(a0)
    1b76:	40f80833          	sub	a6,a6,a5
    1b7a:	ff887593          	andi	a1,a6,-8
    1b7e:	97aa                	add	a5,a5,a0
    1b80:	95be                	add	a1,a1,a5
    1b82:	0007b023          	sd	zero,0(a5)
    1b86:	07a1                	addi	a5,a5,8
    1b88:	feb79de3          	bne	a5,a1,1b82 <strncpy+0xbe>
    1b8c:	ff887593          	andi	a1,a6,-8
    1b90:	9ead                	addw	a3,a3,a1
    1b92:	00b707b3          	add	a5,a4,a1
    1b96:	12b80863          	beq	a6,a1,1cc6 <strncpy+0x202>
    1b9a:	00078023          	sb	zero,0(a5)
    1b9e:	0016871b          	addiw	a4,a3,1
    1ba2:	0ec77863          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1ba6:	000780a3          	sb	zero,1(a5)
    1baa:	0026871b          	addiw	a4,a3,2
    1bae:	0ec77263          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1bb2:	00078123          	sb	zero,2(a5)
    1bb6:	0036871b          	addiw	a4,a3,3
    1bba:	0cc77c63          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1bbe:	000781a3          	sb	zero,3(a5)
    1bc2:	0046871b          	addiw	a4,a3,4
    1bc6:	0cc77663          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1bca:	00078223          	sb	zero,4(a5)
    1bce:	0056871b          	addiw	a4,a3,5
    1bd2:	0cc77063          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1bd6:	000782a3          	sb	zero,5(a5)
    1bda:	0066871b          	addiw	a4,a3,6
    1bde:	0ac77a63          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1be2:	00078323          	sb	zero,6(a5)
    1be6:	0076871b          	addiw	a4,a3,7
    1bea:	0ac77463          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1bee:	000783a3          	sb	zero,7(a5)
    1bf2:	0086871b          	addiw	a4,a3,8
    1bf6:	08c77e63          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1bfa:	00078423          	sb	zero,8(a5)
    1bfe:	0096871b          	addiw	a4,a3,9
    1c02:	08c77863          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1c06:	000784a3          	sb	zero,9(a5)
    1c0a:	00a6871b          	addiw	a4,a3,10
    1c0e:	08c77263          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1c12:	00078523          	sb	zero,10(a5)
    1c16:	00b6871b          	addiw	a4,a3,11
    1c1a:	06c77c63          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1c1e:	000785a3          	sb	zero,11(a5)
    1c22:	00c6871b          	addiw	a4,a3,12
    1c26:	06c77663          	bgeu	a4,a2,1c92 <strncpy+0x1ce>
    1c2a:	00078623          	sb	zero,12(a5)
    1c2e:	26b5                	addiw	a3,a3,13
    1c30:	06c6f163          	bgeu	a3,a2,1c92 <strncpy+0x1ce>
    1c34:	000786a3          	sb	zero,13(a5)
    1c38:	8082                	ret
            ;
        if (!n || !*s)
    1c3a:	c645                	beqz	a2,1ce2 <strncpy+0x21e>
    1c3c:	0005c783          	lbu	a5,0(a1)
    1c40:	ea078be3          	beqz	a5,1af6 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c44:	479d                	li	a5,7
    1c46:	02c7ff63          	bgeu	a5,a2,1c84 <strncpy+0x1c0>
    1c4a:	00000897          	auipc	a7,0x0
    1c4e:	3ce8b883          	ld	a7,974(a7) # 2018 <__clone+0xbe>
    1c52:	00000817          	auipc	a6,0x0
    1c56:	3ce83803          	ld	a6,974(a6) # 2020 <__clone+0xc6>
    1c5a:	431d                	li	t1,7
    1c5c:	6198                	ld	a4,0(a1)
    1c5e:	011707b3          	add	a5,a4,a7
    1c62:	fff74693          	not	a3,a4
    1c66:	8ff5                	and	a5,a5,a3
    1c68:	0107f7b3          	and	a5,a5,a6
    1c6c:	ef81                	bnez	a5,1c84 <strncpy+0x1c0>
            *wd = *ws;
    1c6e:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c70:	1661                	addi	a2,a2,-8
    1c72:	05a1                	addi	a1,a1,8
    1c74:	0521                	addi	a0,a0,8
    1c76:	fec363e3          	bltu	t1,a2,1c5c <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c7a:	e609                	bnez	a2,1c84 <strncpy+0x1c0>
    1c7c:	a08d                	j	1cde <strncpy+0x21a>
    1c7e:	167d                	addi	a2,a2,-1
    1c80:	0505                	addi	a0,a0,1
    1c82:	ca01                	beqz	a2,1c92 <strncpy+0x1ce>
    1c84:	0005c783          	lbu	a5,0(a1)
    1c88:	0585                	addi	a1,a1,1
    1c8a:	00f50023          	sb	a5,0(a0)
    1c8e:	fbe5                	bnez	a5,1c7e <strncpy+0x1ba>
        ;
tail:
    1c90:	b59d                	j	1af6 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c92:	8082                	ret
    1c94:	472d                	li	a4,11
    1c96:	bdb5                	j	1b12 <strncpy+0x4e>
    1c98:	00778713          	addi	a4,a5,7
    1c9c:	45ad                	li	a1,11
    1c9e:	fff60693          	addi	a3,a2,-1
    1ca2:	e6b778e3          	bgeu	a4,a1,1b12 <strncpy+0x4e>
    1ca6:	b7fd                	j	1c94 <strncpy+0x1d0>
    1ca8:	40a007b3          	neg	a5,a0
    1cac:	8832                	mv	a6,a2
    1cae:	8b9d                	andi	a5,a5,7
    1cb0:	4681                	li	a3,0
    1cb2:	e4060be3          	beqz	a2,1b08 <strncpy+0x44>
    1cb6:	b7cd                	j	1c98 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1cb8:	468d                	li	a3,3
    1cba:	bd75                	j	1b76 <strncpy+0xb2>
    1cbc:	872a                	mv	a4,a0
    1cbe:	4681                	li	a3,0
    1cc0:	bd5d                	j	1b76 <strncpy+0xb2>
    1cc2:	4685                	li	a3,1
    1cc4:	bd4d                	j	1b76 <strncpy+0xb2>
    1cc6:	8082                	ret
    1cc8:	87aa                	mv	a5,a0
    1cca:	4681                	li	a3,0
    1ccc:	b5f9                	j	1b9a <strncpy+0xd6>
    1cce:	4689                	li	a3,2
    1cd0:	b55d                	j	1b76 <strncpy+0xb2>
    1cd2:	4691                	li	a3,4
    1cd4:	b54d                	j	1b76 <strncpy+0xb2>
    1cd6:	4695                	li	a3,5
    1cd8:	bd79                	j	1b76 <strncpy+0xb2>
    1cda:	4699                	li	a3,6
    1cdc:	bd69                	j	1b76 <strncpy+0xb2>
    1cde:	8082                	ret
    1ce0:	8082                	ret
    1ce2:	8082                	ret

0000000000001ce4 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1ce4:	87aa                	mv	a5,a0
    1ce6:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1ce8:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1cec:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1cf0:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1cf2:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1cf4:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1cf8:	2501                	sext.w	a0,a0
    1cfa:	8082                	ret

0000000000001cfc <openat>:
    register long a7 __asm__("a7") = n;
    1cfc:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1d00:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d04:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1d08:	2501                	sext.w	a0,a0
    1d0a:	8082                	ret

0000000000001d0c <close>:
    register long a7 __asm__("a7") = n;
    1d0c:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1d10:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1d14:	2501                	sext.w	a0,a0
    1d16:	8082                	ret

0000000000001d18 <read>:
    register long a7 __asm__("a7") = n;
    1d18:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d1c:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1d20:	8082                	ret

0000000000001d22 <write>:
    register long a7 __asm__("a7") = n;
    1d22:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d26:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1d2a:	8082                	ret

0000000000001d2c <getpid>:
    register long a7 __asm__("a7") = n;
    1d2c:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1d30:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1d34:	2501                	sext.w	a0,a0
    1d36:	8082                	ret

0000000000001d38 <getppid>:
    register long a7 __asm__("a7") = n;
    1d38:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1d3c:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1d40:	2501                	sext.w	a0,a0
    1d42:	8082                	ret

0000000000001d44 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1d44:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d48:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1d4c:	2501                	sext.w	a0,a0
    1d4e:	8082                	ret

0000000000001d50 <fork>:
    register long a7 __asm__("a7") = n;
    1d50:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1d54:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1d56:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d58:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1d5c:	2501                	sext.w	a0,a0
    1d5e:	8082                	ret

0000000000001d60 <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1d60:	85b2                	mv	a1,a2
    1d62:	863a                	mv	a2,a4
    if (stack)
    1d64:	c191                	beqz	a1,1d68 <clone+0x8>
	stack += stack_size;
    1d66:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d68:	4781                	li	a5,0
    1d6a:	4701                	li	a4,0
    1d6c:	4681                	li	a3,0
    1d6e:	2601                	sext.w	a2,a2
    1d70:	a2ed                	j	1f5a <__clone>

0000000000001d72 <exit>:
    register long a7 __asm__("a7") = n;
    1d72:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d76:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d7a:	8082                	ret

0000000000001d7c <waitpid>:
    register long a7 __asm__("a7") = n;
    1d7c:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d80:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d82:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d86:	2501                	sext.w	a0,a0
    1d88:	8082                	ret

0000000000001d8a <exec>:
    register long a7 __asm__("a7") = n;
    1d8a:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d8e:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d92:	2501                	sext.w	a0,a0
    1d94:	8082                	ret

0000000000001d96 <execve>:
    register long a7 __asm__("a7") = n;
    1d96:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d9a:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d9e:	2501                	sext.w	a0,a0
    1da0:	8082                	ret

0000000000001da2 <times>:
    register long a7 __asm__("a7") = n;
    1da2:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1da6:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1daa:	2501                	sext.w	a0,a0
    1dac:	8082                	ret

0000000000001dae <get_time>:

int64 get_time()
{
    1dae:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1db0:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1db4:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1db6:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db8:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1dbc:	2501                	sext.w	a0,a0
    1dbe:	ed09                	bnez	a0,1dd8 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1dc0:	67a2                	ld	a5,8(sp)
    1dc2:	3e800713          	li	a4,1000
    1dc6:	00015503          	lhu	a0,0(sp)
    1dca:	02e7d7b3          	divu	a5,a5,a4
    1dce:	02e50533          	mul	a0,a0,a4
    1dd2:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1dd4:	0141                	addi	sp,sp,16
    1dd6:	8082                	ret
        return -1;
    1dd8:	557d                	li	a0,-1
    1dda:	bfed                	j	1dd4 <get_time+0x26>

0000000000001ddc <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1ddc:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1de0:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1de4:	2501                	sext.w	a0,a0
    1de6:	8082                	ret

0000000000001de8 <time>:
    register long a7 __asm__("a7") = n;
    1de8:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1dec:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1df0:	2501                	sext.w	a0,a0
    1df2:	8082                	ret

0000000000001df4 <sleep>:

int sleep(unsigned long long time)
{
    1df4:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1df6:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1df8:	850a                	mv	a0,sp
    1dfa:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1dfc:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1e00:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e02:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1e06:	e501                	bnez	a0,1e0e <sleep+0x1a>
    return 0;
    1e08:	4501                	li	a0,0
}
    1e0a:	0141                	addi	sp,sp,16
    1e0c:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1e0e:	4502                	lw	a0,0(sp)
}
    1e10:	0141                	addi	sp,sp,16
    1e12:	8082                	ret

0000000000001e14 <set_priority>:
    register long a7 __asm__("a7") = n;
    1e14:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1e18:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1e1c:	2501                	sext.w	a0,a0
    1e1e:	8082                	ret

0000000000001e20 <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1e20:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1e24:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1e28:	8082                	ret

0000000000001e2a <munmap>:
    register long a7 __asm__("a7") = n;
    1e2a:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e2e:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1e32:	2501                	sext.w	a0,a0
    1e34:	8082                	ret

0000000000001e36 <wait>:

int wait(int *code)
{
    1e36:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e38:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1e3c:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1e3e:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1e40:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1e42:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1e46:	2501                	sext.w	a0,a0
    1e48:	8082                	ret

0000000000001e4a <spawn>:
    register long a7 __asm__("a7") = n;
    1e4a:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1e4e:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1e52:	2501                	sext.w	a0,a0
    1e54:	8082                	ret

0000000000001e56 <mailread>:
    register long a7 __asm__("a7") = n;
    1e56:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e5a:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1e5e:	2501                	sext.w	a0,a0
    1e60:	8082                	ret

0000000000001e62 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1e62:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e66:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e6a:	2501                	sext.w	a0,a0
    1e6c:	8082                	ret

0000000000001e6e <fstat>:
    register long a7 __asm__("a7") = n;
    1e6e:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e72:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e76:	2501                	sext.w	a0,a0
    1e78:	8082                	ret

0000000000001e7a <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e7a:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e7c:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e80:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e82:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e86:	2501                	sext.w	a0,a0
    1e88:	8082                	ret

0000000000001e8a <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e8a:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e8c:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e90:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e92:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e96:	2501                	sext.w	a0,a0
    1e98:	8082                	ret

0000000000001e9a <link>:

int link(char *old_path, char *new_path)
{
    1e9a:	87aa                	mv	a5,a0
    1e9c:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e9e:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1ea2:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1ea6:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1ea8:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1eac:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1eae:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1eb2:	2501                	sext.w	a0,a0
    1eb4:	8082                	ret

0000000000001eb6 <unlink>:

int unlink(char *path)
{
    1eb6:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1eb8:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1ebc:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1ec0:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ec2:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1ec6:	2501                	sext.w	a0,a0
    1ec8:	8082                	ret

0000000000001eca <uname>:
    register long a7 __asm__("a7") = n;
    1eca:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1ece:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1ed2:	2501                	sext.w	a0,a0
    1ed4:	8082                	ret

0000000000001ed6 <brk>:
    register long a7 __asm__("a7") = n;
    1ed6:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1eda:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1ede:	2501                	sext.w	a0,a0
    1ee0:	8082                	ret

0000000000001ee2 <getcwd>:
    register long a7 __asm__("a7") = n;
    1ee2:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ee4:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1ee8:	8082                	ret

0000000000001eea <chdir>:
    register long a7 __asm__("a7") = n;
    1eea:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1eee:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1ef2:	2501                	sext.w	a0,a0
    1ef4:	8082                	ret

0000000000001ef6 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1ef6:	862e                	mv	a2,a1
    1ef8:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1efa:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1efc:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1f00:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1f04:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1f06:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f08:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1f0c:	2501                	sext.w	a0,a0
    1f0e:	8082                	ret

0000000000001f10 <getdents>:
    register long a7 __asm__("a7") = n;
    1f10:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f14:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1f18:	2501                	sext.w	a0,a0
    1f1a:	8082                	ret

0000000000001f1c <pipe>:
    register long a7 __asm__("a7") = n;
    1f1c:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1f20:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f22:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1f26:	2501                	sext.w	a0,a0
    1f28:	8082                	ret

0000000000001f2a <dup>:
    register long a7 __asm__("a7") = n;
    1f2a:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1f2c:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1f30:	2501                	sext.w	a0,a0
    1f32:	8082                	ret

0000000000001f34 <dup2>:
    register long a7 __asm__("a7") = n;
    1f34:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1f36:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f38:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1f3c:	2501                	sext.w	a0,a0
    1f3e:	8082                	ret

0000000000001f40 <mount>:
    register long a7 __asm__("a7") = n;
    1f40:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1f44:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1f48:	2501                	sext.w	a0,a0
    1f4a:	8082                	ret

0000000000001f4c <umount>:
    register long a7 __asm__("a7") = n;
    1f4c:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1f50:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f52:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1f56:	2501                	sext.w	a0,a0
    1f58:	8082                	ret

0000000000001f5a <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1f5a:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1f5c:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1f5e:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1f60:	8532                	mv	a0,a2
	mv a2, a4
    1f62:	863a                	mv	a2,a4
	mv a3, a5
    1f64:	86be                	mv	a3,a5
	mv a4, a6
    1f66:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f68:	0dc00893          	li	a7,220
	ecall
    1f6c:	00000073          	ecall

	beqz a0, 1f
    1f70:	c111                	beqz	a0,1f74 <__clone+0x1a>
	# Parent
	ret
    1f72:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f74:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f76:	6522                	ld	a0,8(sp)
	jalr a1
    1f78:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f7a:	05d00893          	li	a7,93
	ecall
    1f7e:	00000073          	ecall
