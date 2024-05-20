
/home/gwx/workspace/testsuits-for-oskernel/riscv-syscalls-testing/user/build/riscv64/unlink:     file format elf64-littleriscv


Disassembly of section .text:

0000000000001000 <_start>:
.section .text.entry
.globl _start
_start:
    mv a0, sp
    1000:	850a                	mv	a0,sp
    tail __start_main
    1002:	a8f9                	j	10e0 <__start_main>

0000000000001004 <test_unlink>:
 * 测试失败，应有如下输出：
 * "  unlink error!"
 */

int test_unlink()
{
    1004:	1141                	addi	sp,sp,-16
    TEST_START(__func__);
    1006:	00001517          	auipc	a0,0x1
    100a:	f1a50513          	addi	a0,a0,-230 # 1f20 <__clone+0x28>
{
    100e:	e406                	sd	ra,8(sp)
    1010:	e022                	sd	s0,0(sp)
    TEST_START(__func__);
    1012:	340000ef          	jal	1352 <puts>
    1016:	00001517          	auipc	a0,0x1
    101a:	fc250513          	addi	a0,a0,-62 # 1fd8 <__func__.0>
    101e:	334000ef          	jal	1352 <puts>
    1022:	00001517          	auipc	a0,0x1
    1026:	f1650513          	addi	a0,a0,-234 # 1f38 <__clone+0x40>
    102a:	328000ef          	jal	1352 <puts>

    char *fname = "./test_unlink";
    int fd, ret;

    fd = open(fname, O_CREATE | O_WRONLY);
    102e:	04100593          	li	a1,65
    1032:	00001517          	auipc	a0,0x1
    1036:	f1650513          	addi	a0,a0,-234 # 1f48 <__clone+0x50>
    103a:	449000ef          	jal	1c82 <open>
    103e:	842a                	mv	s0,a0
    assert(fd > 0);
    1040:	08a05163          	blez	a0,10c2 <test_unlink+0xbe>
    close(fd);
    1044:	8522                	mv	a0,s0
    1046:	465000ef          	jal	1caa <close>

    // unlink test
    ret = unlink(fname);
    104a:	00001517          	auipc	a0,0x1
    104e:	efe50513          	addi	a0,a0,-258 # 1f48 <__clone+0x50>
    1052:	603000ef          	jal	1e54 <unlink>
    assert(ret == 0);
    1056:	ed39                	bnez	a0,10b4 <test_unlink+0xb0>
    fd = open(fname, O_RDONLY);
    1058:	4581                	li	a1,0
    105a:	00001517          	auipc	a0,0x1
    105e:	eee50513          	addi	a0,a0,-274 # 1f48 <__clone+0x50>
    1062:	421000ef          	jal	1c82 <open>
    1066:	842a                	mv	s0,a0
    if(fd < 0){
    1068:	02054f63          	bltz	a0,10a6 <test_unlink+0xa2>
        printf("  unlink success!\n");
    }else{
	printf("  unlink error!\n");
    106c:	00001517          	auipc	a0,0x1
    1070:	f2450513          	addi	a0,a0,-220 # 1f90 <__clone+0x98>
    1074:	300000ef          	jal	1374 <printf>
        close(fd);
    1078:	8522                	mv	a0,s0
    107a:	431000ef          	jal	1caa <close>
    }
    // It's Ok if you don't delete the inode and data blocks.

    TEST_END(__func__);
    107e:	00001517          	auipc	a0,0x1
    1082:	f2a50513          	addi	a0,a0,-214 # 1fa8 <__clone+0xb0>
    1086:	2cc000ef          	jal	1352 <puts>
    108a:	00001517          	auipc	a0,0x1
    108e:	f4e50513          	addi	a0,a0,-178 # 1fd8 <__func__.0>
    1092:	2c0000ef          	jal	1352 <puts>
}
    1096:	6402                	ld	s0,0(sp)
    1098:	60a2                	ld	ra,8(sp)
    TEST_END(__func__);
    109a:	00001517          	auipc	a0,0x1
    109e:	e9e50513          	addi	a0,a0,-354 # 1f38 <__clone+0x40>
}
    10a2:	0141                	addi	sp,sp,16
    TEST_END(__func__);
    10a4:	a47d                	j	1352 <puts>
        printf("  unlink success!\n");
    10a6:	00001517          	auipc	a0,0x1
    10aa:	ed250513          	addi	a0,a0,-302 # 1f78 <__clone+0x80>
    10ae:	2c6000ef          	jal	1374 <printf>
    10b2:	b7f1                	j	107e <test_unlink+0x7a>
    assert(ret == 0);
    10b4:	00001517          	auipc	a0,0x1
    10b8:	ea450513          	addi	a0,a0,-348 # 1f58 <__clone+0x60>
    10bc:	542000ef          	jal	15fe <panic>
    10c0:	bf61                	j	1058 <test_unlink+0x54>
    assert(fd > 0);
    10c2:	00001517          	auipc	a0,0x1
    10c6:	e9650513          	addi	a0,a0,-362 # 1f58 <__clone+0x60>
    10ca:	534000ef          	jal	15fe <panic>
    10ce:	bf9d                	j	1044 <test_unlink+0x40>

00000000000010d0 <main>:

int main(void) {
    10d0:	1141                	addi	sp,sp,-16
    10d2:	e406                	sd	ra,8(sp)
	test_unlink();
    10d4:	f31ff0ef          	jal	1004 <test_unlink>
	return 0;
}
    10d8:	60a2                	ld	ra,8(sp)
    10da:	4501                	li	a0,0
    10dc:	0141                	addi	sp,sp,16
    10de:	8082                	ret

00000000000010e0 <__start_main>:
#include <unistd.h>

extern int main();

int __start_main(long *p)
{
    10e0:	85aa                	mv	a1,a0
	int argc = p[0];
	char **argv = (void *)(p+1);

	exit(main(argc, argv));
    10e2:	4108                	lw	a0,0(a0)
{
    10e4:	1141                	addi	sp,sp,-16
	exit(main(argc, argv));
    10e6:	05a1                	addi	a1,a1,8
{
    10e8:	e406                	sd	ra,8(sp)
	exit(main(argc, argv));
    10ea:	fe7ff0ef          	jal	10d0 <main>
    10ee:	423000ef          	jal	1d10 <exit>
	return 0;
}
    10f2:	60a2                	ld	ra,8(sp)
    10f4:	4501                	li	a0,0
    10f6:	0141                	addi	sp,sp,16
    10f8:	8082                	ret

00000000000010fa <printint.constprop.0>:
    write(f, s, l);
}

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
    10fa:	7179                	addi	sp,sp,-48
    10fc:	f406                	sd	ra,40(sp)
{
    char buf[16 + 1];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    10fe:	12054b63          	bltz	a0,1234 <printint.constprop.0+0x13a>

    buf[16] = 0;
    i = 15;
    do
    {
        buf[i--] = digits[x % base];
    1102:	02b577bb          	remuw	a5,a0,a1
    1106:	00001617          	auipc	a2,0x1
    110a:	ee260613          	addi	a2,a2,-286 # 1fe8 <digits>
    buf[16] = 0;
    110e:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1112:	0005871b          	sext.w	a4,a1
    1116:	1782                	slli	a5,a5,0x20
    1118:	9381                	srli	a5,a5,0x20
    111a:	97b2                	add	a5,a5,a2
    111c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1120:	02b5583b          	divuw	a6,a0,a1
        buf[i--] = digits[x % base];
    1124:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    1128:	1cb56363          	bltu	a0,a1,12ee <printint.constprop.0+0x1f4>
        buf[i--] = digits[x % base];
    112c:	45b9                	li	a1,14
    112e:	02e877bb          	remuw	a5,a6,a4
    1132:	1782                	slli	a5,a5,0x20
    1134:	9381                	srli	a5,a5,0x20
    1136:	97b2                	add	a5,a5,a2
    1138:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    113c:	02e856bb          	divuw	a3,a6,a4
        buf[i--] = digits[x % base];
    1140:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1144:	0ce86e63          	bltu	a6,a4,1220 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    1148:	02e6f5bb          	remuw	a1,a3,a4
    } while ((x /= base) != 0);
    114c:	02e6d7bb          	divuw	a5,a3,a4
        buf[i--] = digits[x % base];
    1150:	1582                	slli	a1,a1,0x20
    1152:	9181                	srli	a1,a1,0x20
    1154:	95b2                	add	a1,a1,a2
    1156:	0005c583          	lbu	a1,0(a1)
    115a:	00b10aa3          	sb	a1,21(sp)
    } while ((x /= base) != 0);
    115e:	0007859b          	sext.w	a1,a5
    1162:	12e6ec63          	bltu	a3,a4,129a <printint.constprop.0+0x1a0>
        buf[i--] = digits[x % base];
    1166:	02e7f6bb          	remuw	a3,a5,a4
    116a:	1682                	slli	a3,a3,0x20
    116c:	9281                	srli	a3,a3,0x20
    116e:	96b2                	add	a3,a3,a2
    1170:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    1174:	02e7d83b          	divuw	a6,a5,a4
        buf[i--] = digits[x % base];
    1178:	00d10a23          	sb	a3,20(sp)
    } while ((x /= base) != 0);
    117c:	12e5e863          	bltu	a1,a4,12ac <printint.constprop.0+0x1b2>
        buf[i--] = digits[x % base];
    1180:	02e876bb          	remuw	a3,a6,a4
    1184:	1682                	slli	a3,a3,0x20
    1186:	9281                	srli	a3,a3,0x20
    1188:	96b2                	add	a3,a3,a2
    118a:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    118e:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    1192:	00d109a3          	sb	a3,19(sp)
    } while ((x /= base) != 0);
    1196:	12e86463          	bltu	a6,a4,12be <printint.constprop.0+0x1c4>
        buf[i--] = digits[x % base];
    119a:	02e5f6bb          	remuw	a3,a1,a4
    119e:	1682                	slli	a3,a3,0x20
    11a0:	9281                	srli	a3,a3,0x20
    11a2:	96b2                	add	a3,a3,a2
    11a4:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11a8:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11ac:	00d10923          	sb	a3,18(sp)
    } while ((x /= base) != 0);
    11b0:	0ce5ec63          	bltu	a1,a4,1288 <printint.constprop.0+0x18e>
        buf[i--] = digits[x % base];
    11b4:	02e876bb          	remuw	a3,a6,a4
    11b8:	1682                	slli	a3,a3,0x20
    11ba:	9281                	srli	a3,a3,0x20
    11bc:	96b2                	add	a3,a3,a2
    11be:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11c2:	02e855bb          	divuw	a1,a6,a4
        buf[i--] = digits[x % base];
    11c6:	00d108a3          	sb	a3,17(sp)
    } while ((x /= base) != 0);
    11ca:	10e86963          	bltu	a6,a4,12dc <printint.constprop.0+0x1e2>
        buf[i--] = digits[x % base];
    11ce:	02e5f6bb          	remuw	a3,a1,a4
    11d2:	1682                	slli	a3,a3,0x20
    11d4:	9281                	srli	a3,a3,0x20
    11d6:	96b2                	add	a3,a3,a2
    11d8:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11dc:	02e5d83b          	divuw	a6,a1,a4
        buf[i--] = digits[x % base];
    11e0:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    11e4:	10e5e763          	bltu	a1,a4,12f2 <printint.constprop.0+0x1f8>
        buf[i--] = digits[x % base];
    11e8:	02e876bb          	remuw	a3,a6,a4
    11ec:	1682                	slli	a3,a3,0x20
    11ee:	9281                	srli	a3,a3,0x20
    11f0:	96b2                	add	a3,a3,a2
    11f2:	0006c683          	lbu	a3,0(a3)
    } while ((x /= base) != 0);
    11f6:	02e857bb          	divuw	a5,a6,a4
        buf[i--] = digits[x % base];
    11fa:	00d107a3          	sb	a3,15(sp)
    } while ((x /= base) != 0);
    11fe:	10e86363          	bltu	a6,a4,1304 <printint.constprop.0+0x20a>
        buf[i--] = digits[x % base];
    1202:	1782                	slli	a5,a5,0x20
    1204:	9381                	srli	a5,a5,0x20
    1206:	97b2                	add	a5,a5,a2
    1208:	0007c783          	lbu	a5,0(a5)
    120c:	4599                	li	a1,6
    120e:	00f10723          	sb	a5,14(sp)

    if (sign)
    1212:	00055763          	bgez	a0,1220 <printint.constprop.0+0x126>
        buf[i--] = '-';
    1216:	02d00793          	li	a5,45
    121a:	00f106a3          	sb	a5,13(sp)
        buf[i--] = digits[x % base];
    121e:	4595                	li	a1,5
    write(f, s, l);
    1220:	003c                	addi	a5,sp,8
    1222:	4641                	li	a2,16
    1224:	9e0d                	subw	a2,a2,a1
    1226:	4505                	li	a0,1
    1228:	95be                	add	a1,a1,a5
    122a:	297000ef          	jal	1cc0 <write>
    i++;
    if (i < 0)
        puts("printint error");
    out(stdout, buf + i, 16 - i);
}
    122e:	70a2                	ld	ra,40(sp)
    1230:	6145                	addi	sp,sp,48
    1232:	8082                	ret
        x = -xx;
    1234:	40a0083b          	negw	a6,a0
        buf[i--] = digits[x % base];
    1238:	02b877bb          	remuw	a5,a6,a1
    123c:	00001617          	auipc	a2,0x1
    1240:	dac60613          	addi	a2,a2,-596 # 1fe8 <digits>
    buf[16] = 0;
    1244:	00010c23          	sb	zero,24(sp)
        buf[i--] = digits[x % base];
    1248:	0005871b          	sext.w	a4,a1
    124c:	1782                	slli	a5,a5,0x20
    124e:	9381                	srli	a5,a5,0x20
    1250:	97b2                	add	a5,a5,a2
    1252:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1256:	02b858bb          	divuw	a7,a6,a1
        buf[i--] = digits[x % base];
    125a:	00f10ba3          	sb	a5,23(sp)
    } while ((x /= base) != 0);
    125e:	06b86963          	bltu	a6,a1,12d0 <printint.constprop.0+0x1d6>
        buf[i--] = digits[x % base];
    1262:	02e8f7bb          	remuw	a5,a7,a4
    1266:	1782                	slli	a5,a5,0x20
    1268:	9381                	srli	a5,a5,0x20
    126a:	97b2                	add	a5,a5,a2
    126c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1270:	02e8d6bb          	divuw	a3,a7,a4
        buf[i--] = digits[x % base];
    1274:	00f10b23          	sb	a5,22(sp)
    } while ((x /= base) != 0);
    1278:	ece8f8e3          	bgeu	a7,a4,1148 <printint.constprop.0+0x4e>
        buf[i--] = '-';
    127c:	02d00793          	li	a5,45
    1280:	00f10aa3          	sb	a5,21(sp)
        buf[i--] = digits[x % base];
    1284:	45b5                	li	a1,13
    1286:	bf69                	j	1220 <printint.constprop.0+0x126>
    1288:	45a9                	li	a1,10
    if (sign)
    128a:	f8055be3          	bgez	a0,1220 <printint.constprop.0+0x126>
        buf[i--] = '-';
    128e:	02d00793          	li	a5,45
    1292:	00f108a3          	sb	a5,17(sp)
        buf[i--] = digits[x % base];
    1296:	45a5                	li	a1,9
    1298:	b761                	j	1220 <printint.constprop.0+0x126>
    129a:	45b5                	li	a1,13
    if (sign)
    129c:	f80552e3          	bgez	a0,1220 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12a0:	02d00793          	li	a5,45
    12a4:	00f10a23          	sb	a5,20(sp)
        buf[i--] = digits[x % base];
    12a8:	45b1                	li	a1,12
    12aa:	bf9d                	j	1220 <printint.constprop.0+0x126>
    12ac:	45b1                	li	a1,12
    if (sign)
    12ae:	f60559e3          	bgez	a0,1220 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12b2:	02d00793          	li	a5,45
    12b6:	00f109a3          	sb	a5,19(sp)
        buf[i--] = digits[x % base];
    12ba:	45ad                	li	a1,11
    12bc:	b795                	j	1220 <printint.constprop.0+0x126>
    12be:	45ad                	li	a1,11
    if (sign)
    12c0:	f60550e3          	bgez	a0,1220 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12c4:	02d00793          	li	a5,45
    12c8:	00f10923          	sb	a5,18(sp)
        buf[i--] = digits[x % base];
    12cc:	45a9                	li	a1,10
    12ce:	bf89                	j	1220 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12d0:	02d00793          	li	a5,45
    12d4:	00f10b23          	sb	a5,22(sp)
        buf[i--] = digits[x % base];
    12d8:	45b9                	li	a1,14
    12da:	b799                	j	1220 <printint.constprop.0+0x126>
    12dc:	45a5                	li	a1,9
    if (sign)
    12de:	f40551e3          	bgez	a0,1220 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12e2:	02d00793          	li	a5,45
    12e6:	00f10823          	sb	a5,16(sp)
        buf[i--] = digits[x % base];
    12ea:	45a1                	li	a1,8
    12ec:	bf15                	j	1220 <printint.constprop.0+0x126>
    i = 15;
    12ee:	45bd                	li	a1,15
    12f0:	bf05                	j	1220 <printint.constprop.0+0x126>
        buf[i--] = digits[x % base];
    12f2:	45a1                	li	a1,8
    if (sign)
    12f4:	f20556e3          	bgez	a0,1220 <printint.constprop.0+0x126>
        buf[i--] = '-';
    12f8:	02d00793          	li	a5,45
    12fc:	00f107a3          	sb	a5,15(sp)
        buf[i--] = digits[x % base];
    1300:	459d                	li	a1,7
    1302:	bf39                	j	1220 <printint.constprop.0+0x126>
    1304:	459d                	li	a1,7
    if (sign)
    1306:	f0055de3          	bgez	a0,1220 <printint.constprop.0+0x126>
        buf[i--] = '-';
    130a:	02d00793          	li	a5,45
    130e:	00f10723          	sb	a5,14(sp)
        buf[i--] = digits[x % base];
    1312:	4599                	li	a1,6
    1314:	b731                	j	1220 <printint.constprop.0+0x126>

0000000000001316 <getchar>:
{
    1316:	1101                	addi	sp,sp,-32
    read(stdin, &byte, 1);
    1318:	00f10593          	addi	a1,sp,15
    131c:	4605                	li	a2,1
    131e:	4501                	li	a0,0
{
    1320:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1322:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1326:	191000ef          	jal	1cb6 <read>
}
    132a:	60e2                	ld	ra,24(sp)
    132c:	00f14503          	lbu	a0,15(sp)
    1330:	6105                	addi	sp,sp,32
    1332:	8082                	ret

0000000000001334 <putchar>:
{
    1334:	1101                	addi	sp,sp,-32
    1336:	87aa                	mv	a5,a0
    return write(stdout, &byte, 1);
    1338:	00f10593          	addi	a1,sp,15
    133c:	4605                	li	a2,1
    133e:	4505                	li	a0,1
{
    1340:	ec06                	sd	ra,24(sp)
    char byte = c;
    1342:	00f107a3          	sb	a5,15(sp)
    return write(stdout, &byte, 1);
    1346:	17b000ef          	jal	1cc0 <write>
}
    134a:	60e2                	ld	ra,24(sp)
    134c:	2501                	sext.w	a0,a0
    134e:	6105                	addi	sp,sp,32
    1350:	8082                	ret

0000000000001352 <puts>:
{
    1352:	1141                	addi	sp,sp,-16
    1354:	e406                	sd	ra,8(sp)
    1356:	e022                	sd	s0,0(sp)
    1358:	842a                	mv	s0,a0
    r = -(write(stdout, s, strlen(s)) < 0);
    135a:	582000ef          	jal	18dc <strlen>
    135e:	862a                	mv	a2,a0
    1360:	85a2                	mv	a1,s0
    1362:	4505                	li	a0,1
    1364:	15d000ef          	jal	1cc0 <write>
}
    1368:	60a2                	ld	ra,8(sp)
    136a:	6402                	ld	s0,0(sp)
    r = -(write(stdout, s, strlen(s)) < 0);
    136c:	957d                	srai	a0,a0,0x3f
    return r;
    136e:	2501                	sext.w	a0,a0
}
    1370:	0141                	addi	sp,sp,16
    1372:	8082                	ret

0000000000001374 <printf>:
    out(stdout, buf, i);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char *fmt, ...)
{
    1374:	7131                	addi	sp,sp,-192
    1376:	f53e                	sd	a5,168(sp)
    va_list ap;
    int cnt = 0, l = 0;
    char *a, *z, *s = (char *)fmt, str;
    int f = stdout;

    va_start(ap, fmt);
    1378:	013c                	addi	a5,sp,136
{
    137a:	f0ca                	sd	s2,96(sp)
    137c:	ecce                	sd	s3,88(sp)
    137e:	e8d2                	sd	s4,80(sp)
    1380:	e4d6                	sd	s5,72(sp)
    1382:	e0da                	sd	s6,64(sp)
    1384:	fc5e                	sd	s7,56(sp)
    1386:	fc86                	sd	ra,120(sp)
    1388:	f8a2                	sd	s0,112(sp)
    138a:	f4a6                	sd	s1,104(sp)
    138c:	e52e                	sd	a1,136(sp)
    138e:	e932                	sd	a2,144(sp)
    1390:	ed36                	sd	a3,152(sp)
    1392:	f13a                	sd	a4,160(sp)
    1394:	f942                	sd	a6,176(sp)
    1396:	fd46                	sd	a7,184(sp)
    va_start(ap, fmt);
    1398:	e03e                	sd	a5,0(sp)
    for (;;)
    {
        if (!*s)
            break;
        for (a = s; *s && *s != '%'; s++)
    139a:	02500913          	li	s2,37
        out(f, a, l);
        if (l)
            continue;
        if (s[1] == 0)
            break;
        switch (s[1])
    139e:	07300a13          	li	s4,115
        case 'p':
            printptr(va_arg(ap, uint64));
            break;
        case 's':
            if ((a = va_arg(ap, char *)) == 0)
                a = "(null)";
    13a2:	00001b97          	auipc	s7,0x1
    13a6:	c16b8b93          	addi	s7,s7,-1002 # 1fb8 <__clone+0xc0>
        switch (s[1])
    13aa:	07800a93          	li	s5,120
    13ae:	06400b13          	li	s6,100
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    13b2:	00001997          	auipc	s3,0x1
    13b6:	c3698993          	addi	s3,s3,-970 # 1fe8 <digits>
        if (!*s)
    13ba:	00054783          	lbu	a5,0(a0)
    13be:	16078c63          	beqz	a5,1536 <printf+0x1c2>
    13c2:	862a                	mv	a2,a0
        for (a = s; *s && *s != '%'; s++)
    13c4:	19278463          	beq	a5,s2,154c <printf+0x1d8>
    13c8:	00164783          	lbu	a5,1(a2)
    13cc:	0605                	addi	a2,a2,1
    13ce:	fbfd                	bnez	a5,13c4 <printf+0x50>
    13d0:	84b2                	mv	s1,a2
        l = z - a;
    13d2:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    13d6:	85aa                	mv	a1,a0
    13d8:	8622                	mv	a2,s0
    13da:	4505                	li	a0,1
    13dc:	0e5000ef          	jal	1cc0 <write>
        if (l)
    13e0:	18041f63          	bnez	s0,157e <printf+0x20a>
        if (s[1] == 0)
    13e4:	0014c783          	lbu	a5,1(s1)
    13e8:	14078763          	beqz	a5,1536 <printf+0x1c2>
        switch (s[1])
    13ec:	1d478163          	beq	a5,s4,15ae <printf+0x23a>
    13f0:	18fa6963          	bltu	s4,a5,1582 <printf+0x20e>
    13f4:	1b678363          	beq	a5,s6,159a <printf+0x226>
    13f8:	07000713          	li	a4,112
    13fc:	1ce79c63          	bne	a5,a4,15d4 <printf+0x260>
            printptr(va_arg(ap, uint64));
    1400:	6702                	ld	a4,0(sp)
    buf[i++] = '0';
    1402:	03000793          	li	a5,48
    1406:	00f10423          	sb	a5,8(sp)
            printptr(va_arg(ap, uint64));
    140a:	631c                	ld	a5,0(a4)
    140c:	0721                	addi	a4,a4,8
    140e:	e03a                	sd	a4,0(sp)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1410:	00479f93          	slli	t6,a5,0x4
    1414:	00879f13          	slli	t5,a5,0x8
    1418:	00c79e93          	slli	t4,a5,0xc
    141c:	01079e13          	slli	t3,a5,0x10
    1420:	01479313          	slli	t1,a5,0x14
    1424:	01879893          	slli	a7,a5,0x18
    1428:	01c79713          	slli	a4,a5,0x1c
    142c:	02479813          	slli	a6,a5,0x24
    1430:	02879513          	slli	a0,a5,0x28
    1434:	02c79593          	slli	a1,a5,0x2c
    1438:	03079613          	slli	a2,a5,0x30
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    143c:	03c7d293          	srli	t0,a5,0x3c
    1440:	01c7d39b          	srliw	t2,a5,0x1c
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    1444:	03479693          	slli	a3,a5,0x34
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1448:	03cfdf93          	srli	t6,t6,0x3c
    144c:	03cf5f13          	srli	t5,t5,0x3c
    1450:	03cede93          	srli	t4,t4,0x3c
    1454:	03ce5e13          	srli	t3,t3,0x3c
    1458:	03c35313          	srli	t1,t1,0x3c
    145c:	03c8d893          	srli	a7,a7,0x3c
    1460:	9371                	srli	a4,a4,0x3c
    1462:	03c85813          	srli	a6,a6,0x3c
    1466:	9171                	srli	a0,a0,0x3c
    1468:	91f1                	srli	a1,a1,0x3c
    146a:	9271                	srli	a2,a2,0x3c
    146c:	974e                	add	a4,a4,s3
    146e:	92f1                	srli	a3,a3,0x3c
    1470:	92ce                	add	t0,t0,s3
    1472:	9fce                	add	t6,t6,s3
    1474:	9f4e                	add	t5,t5,s3
    1476:	9ece                	add	t4,t4,s3
    1478:	9e4e                	add	t3,t3,s3
    147a:	934e                	add	t1,t1,s3
    147c:	98ce                	add	a7,a7,s3
    147e:	93ce                	add	t2,t2,s3
    1480:	984e                	add	a6,a6,s3
    1482:	954e                	add	a0,a0,s3
    1484:	95ce                	add	a1,a1,s3
    1486:	964e                	add	a2,a2,s3
    1488:	0002c283          	lbu	t0,0(t0)
    148c:	000fcf83          	lbu	t6,0(t6)
    1490:	000f4f03          	lbu	t5,0(t5)
    1494:	000ece83          	lbu	t4,0(t4)
    1498:	000e4e03          	lbu	t3,0(t3)
    149c:	00034303          	lbu	t1,0(t1)
    14a0:	0008c883          	lbu	a7,0(a7)
    14a4:	00074403          	lbu	s0,0(a4)
    14a8:	0003c383          	lbu	t2,0(t2)
    14ac:	00084803          	lbu	a6,0(a6)
    14b0:	00054503          	lbu	a0,0(a0)
    14b4:	0005c583          	lbu	a1,0(a1)
    14b8:	00064603          	lbu	a2,0(a2)
    14bc:	00d98733          	add	a4,s3,a3
    14c0:	00074683          	lbu	a3,0(a4)
    for (j = 0; j < (sizeof(uint64) * 2); j++, x <<= 4)
    14c4:	03879713          	slli	a4,a5,0x38
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    14c8:	9371                	srli	a4,a4,0x3c
    14ca:	8bbd                	andi	a5,a5,15
    14cc:	00510523          	sb	t0,10(sp)
    14d0:	01f105a3          	sb	t6,11(sp)
    14d4:	01e10623          	sb	t5,12(sp)
    14d8:	01d106a3          	sb	t4,13(sp)
    14dc:	01c10723          	sb	t3,14(sp)
    14e0:	006107a3          	sb	t1,15(sp)
    14e4:	01110823          	sb	a7,16(sp)
    14e8:	00710923          	sb	t2,18(sp)
    14ec:	010109a3          	sb	a6,19(sp)
    14f0:	00a10a23          	sb	a0,20(sp)
    14f4:	00b10aa3          	sb	a1,21(sp)
    14f8:	00c10b23          	sb	a2,22(sp)
    buf[i++] = 'x';
    14fc:	015104a3          	sb	s5,9(sp)
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    1500:	008108a3          	sb	s0,17(sp)
    1504:	974e                	add	a4,a4,s3
    1506:	97ce                	add	a5,a5,s3
    1508:	00d10ba3          	sb	a3,23(sp)
    150c:	00074703          	lbu	a4,0(a4)
    1510:	0007c783          	lbu	a5,0(a5)
    write(f, s, l);
    1514:	4649                	li	a2,18
    1516:	002c                	addi	a1,sp,8
    1518:	4505                	li	a0,1
        buf[i++] = digits[x >> (sizeof(uint64) * 8 - 4)];
    151a:	00e10c23          	sb	a4,24(sp)
    151e:	00f10ca3          	sb	a5,25(sp)
    buf[i] = 0;
    1522:	00010d23          	sb	zero,26(sp)
    write(f, s, l);
    1526:	79a000ef          	jal	1cc0 <write>
            // Print unknown % sequence to draw attention.
            putchar('%');
            putchar(s[1]);
            break;
        }
        s += 2;
    152a:	00248513          	addi	a0,s1,2
        if (!*s)
    152e:	00054783          	lbu	a5,0(a0)
    1532:	e80798e3          	bnez	a5,13c2 <printf+0x4e>
    }
    va_end(ap);
}
    1536:	70e6                	ld	ra,120(sp)
    1538:	7446                	ld	s0,112(sp)
    153a:	74a6                	ld	s1,104(sp)
    153c:	7906                	ld	s2,96(sp)
    153e:	69e6                	ld	s3,88(sp)
    1540:	6a46                	ld	s4,80(sp)
    1542:	6aa6                	ld	s5,72(sp)
    1544:	6b06                	ld	s6,64(sp)
    1546:	7be2                	ld	s7,56(sp)
    1548:	6129                	addi	sp,sp,192
    154a:	8082                	ret
        for (z = s; s[0] == '%' && s[1] == '%'; z++, s += 2)
    154c:	00064783          	lbu	a5,0(a2)
    1550:	84b2                	mv	s1,a2
    1552:	01278963          	beq	a5,s2,1564 <printf+0x1f0>
    1556:	bdb5                	j	13d2 <printf+0x5e>
    1558:	0024c783          	lbu	a5,2(s1)
    155c:	0605                	addi	a2,a2,1
    155e:	0489                	addi	s1,s1,2
    1560:	e72799e3          	bne	a5,s2,13d2 <printf+0x5e>
    1564:	0014c783          	lbu	a5,1(s1)
    1568:	ff2788e3          	beq	a5,s2,1558 <printf+0x1e4>
        l = z - a;
    156c:	40a6043b          	subw	s0,a2,a0
    write(f, s, l);
    1570:	85aa                	mv	a1,a0
    1572:	8622                	mv	a2,s0
    1574:	4505                	li	a0,1
    1576:	74a000ef          	jal	1cc0 <write>
        if (l)
    157a:	e60405e3          	beqz	s0,13e4 <printf+0x70>
    157e:	8526                	mv	a0,s1
    1580:	bd2d                	j	13ba <printf+0x46>
        switch (s[1])
    1582:	05579963          	bne	a5,s5,15d4 <printf+0x260>
            printint(va_arg(ap, int), 16, 1);
    1586:	6782                	ld	a5,0(sp)
    1588:	45c1                	li	a1,16
    158a:	4388                	lw	a0,0(a5)
    158c:	07a1                	addi	a5,a5,8
    158e:	e03e                	sd	a5,0(sp)
    1590:	b6bff0ef          	jal	10fa <printint.constprop.0>
        s += 2;
    1594:	00248513          	addi	a0,s1,2
    1598:	bf59                	j	152e <printf+0x1ba>
            printint(va_arg(ap, int), 10, 1);
    159a:	6782                	ld	a5,0(sp)
    159c:	45a9                	li	a1,10
    159e:	4388                	lw	a0,0(a5)
    15a0:	07a1                	addi	a5,a5,8
    15a2:	e03e                	sd	a5,0(sp)
    15a4:	b57ff0ef          	jal	10fa <printint.constprop.0>
        s += 2;
    15a8:	00248513          	addi	a0,s1,2
    15ac:	b749                	j	152e <printf+0x1ba>
            if ((a = va_arg(ap, char *)) == 0)
    15ae:	6782                	ld	a5,0(sp)
    15b0:	6380                	ld	s0,0(a5)
    15b2:	07a1                	addi	a5,a5,8
    15b4:	e03e                	sd	a5,0(sp)
    15b6:	c031                	beqz	s0,15fa <printf+0x286>
            l = strnlen(a, 200);
    15b8:	0c800593          	li	a1,200
    15bc:	8522                	mv	a0,s0
    15be:	40a000ef          	jal	19c8 <strnlen>
    write(f, s, l);
    15c2:	0005061b          	sext.w	a2,a0
    15c6:	85a2                	mv	a1,s0
    15c8:	4505                	li	a0,1
    15ca:	6f6000ef          	jal	1cc0 <write>
        s += 2;
    15ce:	00248513          	addi	a0,s1,2
    15d2:	bfb1                	j	152e <printf+0x1ba>
    return write(stdout, &byte, 1);
    15d4:	4605                	li	a2,1
    15d6:	002c                	addi	a1,sp,8
    15d8:	4505                	li	a0,1
    char byte = c;
    15da:	01210423          	sb	s2,8(sp)
    return write(stdout, &byte, 1);
    15de:	6e2000ef          	jal	1cc0 <write>
    char byte = c;
    15e2:	0014c783          	lbu	a5,1(s1)
    return write(stdout, &byte, 1);
    15e6:	4605                	li	a2,1
    15e8:	002c                	addi	a1,sp,8
    15ea:	4505                	li	a0,1
    char byte = c;
    15ec:	00f10423          	sb	a5,8(sp)
    return write(stdout, &byte, 1);
    15f0:	6d0000ef          	jal	1cc0 <write>
        s += 2;
    15f4:	00248513          	addi	a0,s1,2
    15f8:	bf1d                	j	152e <printf+0x1ba>
                a = "(null)";
    15fa:	845e                	mv	s0,s7
    15fc:	bf75                	j	15b8 <printf+0x244>

00000000000015fe <panic>:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void panic(char *m)
{
    15fe:	1141                	addi	sp,sp,-16
    1600:	e406                	sd	ra,8(sp)
    puts(m);
    1602:	d51ff0ef          	jal	1352 <puts>
    exit(-100);
}
    1606:	60a2                	ld	ra,8(sp)
    exit(-100);
    1608:	f9c00513          	li	a0,-100
}
    160c:	0141                	addi	sp,sp,16
    exit(-100);
    160e:	a709                	j	1d10 <exit>

0000000000001610 <isspace>:
#define HIGHS (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x)&HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1610:	02000793          	li	a5,32
    1614:	00f50663          	beq	a0,a5,1620 <isspace+0x10>
    1618:	355d                	addiw	a0,a0,-9
    161a:	00553513          	sltiu	a0,a0,5
    161e:	8082                	ret
    1620:	4505                	li	a0,1
}
    1622:	8082                	ret

0000000000001624 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1624:	fd05051b          	addiw	a0,a0,-48
}
    1628:	00a53513          	sltiu	a0,a0,10
    162c:	8082                	ret

000000000000162e <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    162e:	02000613          	li	a2,32
    1632:	4591                	li	a1,4

int atoi(const char *s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1634:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1638:	ff77069b          	addiw	a3,a4,-9
    163c:	04c70d63          	beq	a4,a2,1696 <atoi+0x68>
    1640:	0007079b          	sext.w	a5,a4
    1644:	04d5f963          	bgeu	a1,a3,1696 <atoi+0x68>
        s++;
    switch (*s)
    1648:	02b00693          	li	a3,43
    164c:	04d70a63          	beq	a4,a3,16a0 <atoi+0x72>
    1650:	02d00693          	li	a3,45
    1654:	06d70463          	beq	a4,a3,16bc <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1658:	fd07859b          	addiw	a1,a5,-48
    165c:	4625                	li	a2,9
    165e:	873e                	mv	a4,a5
    1660:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1662:	4e01                	li	t3,0
    while (isdigit(*s))
    1664:	04b66a63          	bltu	a2,a1,16b8 <atoi+0x8a>
    int n = 0, neg = 0;
    1668:	4501                	li	a0,0
    while (isdigit(*s))
    166a:	4825                	li	a6,9
    166c:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1670:	0025179b          	slliw	a5,a0,0x2
    1674:	9d3d                	addw	a0,a0,a5
    1676:	fd07031b          	addiw	t1,a4,-48
    167a:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    167e:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1682:	0685                	addi	a3,a3,1
    1684:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1688:	0006071b          	sext.w	a4,a2
    168c:	feb870e3          	bgeu	a6,a1,166c <atoi+0x3e>
    return neg ? n : -n;
    1690:	000e0563          	beqz	t3,169a <atoi+0x6c>
}
    1694:	8082                	ret
        s++;
    1696:	0505                	addi	a0,a0,1
    1698:	bf71                	j	1634 <atoi+0x6>
    return neg ? n : -n;
    169a:	4113053b          	subw	a0,t1,a7
    169e:	8082                	ret
    while (isdigit(*s))
    16a0:	00154783          	lbu	a5,1(a0)
    16a4:	4625                	li	a2,9
        s++;
    16a6:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16aa:	fd07859b          	addiw	a1,a5,-48
    16ae:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16b2:	4e01                	li	t3,0
    while (isdigit(*s))
    16b4:	fab67ae3          	bgeu	a2,a1,1668 <atoi+0x3a>
    16b8:	4501                	li	a0,0
}
    16ba:	8082                	ret
    while (isdigit(*s))
    16bc:	00154783          	lbu	a5,1(a0)
    16c0:	4625                	li	a2,9
        s++;
    16c2:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16c6:	fd07859b          	addiw	a1,a5,-48
    16ca:	0007871b          	sext.w	a4,a5
    16ce:	feb665e3          	bltu	a2,a1,16b8 <atoi+0x8a>
        neg = 1;
    16d2:	4e05                	li	t3,1
    16d4:	bf51                	j	1668 <atoi+0x3a>

00000000000016d6 <memset>:

void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    for (int i = 0; i < n; ++i, *(p++) = c)
    16d6:	16060d63          	beqz	a2,1850 <memset+0x17a>
    16da:	40a007b3          	neg	a5,a0
    16de:	8b9d                	andi	a5,a5,7
    16e0:	00778713          	addi	a4,a5,7
    16e4:	482d                	li	a6,11
    16e6:	0ff5f593          	zext.b	a1,a1
    16ea:	fff60693          	addi	a3,a2,-1
    16ee:	17076263          	bltu	a4,a6,1852 <memset+0x17c>
    16f2:	16e6ea63          	bltu	a3,a4,1866 <memset+0x190>
    16f6:	16078563          	beqz	a5,1860 <memset+0x18a>
    16fa:	00b50023          	sb	a1,0(a0)
    16fe:	4705                	li	a4,1
    1700:	00150e93          	addi	t4,a0,1
    1704:	14e78c63          	beq	a5,a4,185c <memset+0x186>
    1708:	00b500a3          	sb	a1,1(a0)
    170c:	4709                	li	a4,2
    170e:	00250e93          	addi	t4,a0,2
    1712:	14e78d63          	beq	a5,a4,186c <memset+0x196>
    1716:	00b50123          	sb	a1,2(a0)
    171a:	470d                	li	a4,3
    171c:	00350e93          	addi	t4,a0,3
    1720:	12e78b63          	beq	a5,a4,1856 <memset+0x180>
    1724:	00b501a3          	sb	a1,3(a0)
    1728:	4711                	li	a4,4
    172a:	00450e93          	addi	t4,a0,4
    172e:	14e78163          	beq	a5,a4,1870 <memset+0x19a>
    1732:	00b50223          	sb	a1,4(a0)
    1736:	4715                	li	a4,5
    1738:	00550e93          	addi	t4,a0,5
    173c:	12e78c63          	beq	a5,a4,1874 <memset+0x19e>
    1740:	00b502a3          	sb	a1,5(a0)
    1744:	471d                	li	a4,7
    1746:	00650e93          	addi	t4,a0,6
    174a:	12e79763          	bne	a5,a4,1878 <memset+0x1a2>
    174e:	00750e93          	addi	t4,a0,7
    1752:	00b50323          	sb	a1,6(a0)
    1756:	4f1d                	li	t5,7
    1758:	00859713          	slli	a4,a1,0x8
    175c:	8f4d                	or	a4,a4,a1
    175e:	01059e13          	slli	t3,a1,0x10
    1762:	01c76e33          	or	t3,a4,t3
    1766:	01859313          	slli	t1,a1,0x18
    176a:	006e6333          	or	t1,t3,t1
    176e:	02059893          	slli	a7,a1,0x20
    1772:	011368b3          	or	a7,t1,a7
    1776:	02859813          	slli	a6,a1,0x28
    177a:	40f60333          	sub	t1,a2,a5
    177e:	0108e833          	or	a6,a7,a6
    1782:	03059693          	slli	a3,a1,0x30
    1786:	00d866b3          	or	a3,a6,a3
    178a:	03859713          	slli	a4,a1,0x38
    178e:	97aa                	add	a5,a5,a0
    1790:	ff837813          	andi	a6,t1,-8
    1794:	8f55                	or	a4,a4,a3
    1796:	00f806b3          	add	a3,a6,a5
    179a:	e398                	sd	a4,0(a5)
    179c:	07a1                	addi	a5,a5,8
    179e:	fed79ee3          	bne	a5,a3,179a <memset+0xc4>
    17a2:	ff837693          	andi	a3,t1,-8
    17a6:	00de87b3          	add	a5,t4,a3
    17aa:	01e6873b          	addw	a4,a3,t5
    17ae:	0ad30663          	beq	t1,a3,185a <memset+0x184>
    17b2:	00b78023          	sb	a1,0(a5)
    17b6:	0017069b          	addiw	a3,a4,1
    17ba:	08c6fb63          	bgeu	a3,a2,1850 <memset+0x17a>
    17be:	00b780a3          	sb	a1,1(a5)
    17c2:	0027069b          	addiw	a3,a4,2
    17c6:	08c6f563          	bgeu	a3,a2,1850 <memset+0x17a>
    17ca:	00b78123          	sb	a1,2(a5)
    17ce:	0037069b          	addiw	a3,a4,3
    17d2:	06c6ff63          	bgeu	a3,a2,1850 <memset+0x17a>
    17d6:	00b781a3          	sb	a1,3(a5)
    17da:	0047069b          	addiw	a3,a4,4
    17de:	06c6f963          	bgeu	a3,a2,1850 <memset+0x17a>
    17e2:	00b78223          	sb	a1,4(a5)
    17e6:	0057069b          	addiw	a3,a4,5
    17ea:	06c6f363          	bgeu	a3,a2,1850 <memset+0x17a>
    17ee:	00b782a3          	sb	a1,5(a5)
    17f2:	0067069b          	addiw	a3,a4,6
    17f6:	04c6fd63          	bgeu	a3,a2,1850 <memset+0x17a>
    17fa:	00b78323          	sb	a1,6(a5)
    17fe:	0077069b          	addiw	a3,a4,7
    1802:	04c6f763          	bgeu	a3,a2,1850 <memset+0x17a>
    1806:	00b783a3          	sb	a1,7(a5)
    180a:	0087069b          	addiw	a3,a4,8
    180e:	04c6f163          	bgeu	a3,a2,1850 <memset+0x17a>
    1812:	00b78423          	sb	a1,8(a5)
    1816:	0097069b          	addiw	a3,a4,9
    181a:	02c6fb63          	bgeu	a3,a2,1850 <memset+0x17a>
    181e:	00b784a3          	sb	a1,9(a5)
    1822:	00a7069b          	addiw	a3,a4,10
    1826:	02c6f563          	bgeu	a3,a2,1850 <memset+0x17a>
    182a:	00b78523          	sb	a1,10(a5)
    182e:	00b7069b          	addiw	a3,a4,11
    1832:	00c6ff63          	bgeu	a3,a2,1850 <memset+0x17a>
    1836:	00b785a3          	sb	a1,11(a5)
    183a:	00c7069b          	addiw	a3,a4,12
    183e:	00c6f963          	bgeu	a3,a2,1850 <memset+0x17a>
    1842:	00b78623          	sb	a1,12(a5)
    1846:	2735                	addiw	a4,a4,13
    1848:	00c77463          	bgeu	a4,a2,1850 <memset+0x17a>
    184c:	00b786a3          	sb	a1,13(a5)
        ;
    return dest;
}
    1850:	8082                	ret
    1852:	472d                	li	a4,11
    1854:	bd79                	j	16f2 <memset+0x1c>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1856:	4f0d                	li	t5,3
    1858:	b701                	j	1758 <memset+0x82>
    185a:	8082                	ret
    185c:	4f05                	li	t5,1
    185e:	bded                	j	1758 <memset+0x82>
    1860:	8eaa                	mv	t4,a0
    1862:	4f01                	li	t5,0
    1864:	bdd5                	j	1758 <memset+0x82>
    1866:	87aa                	mv	a5,a0
    1868:	4701                	li	a4,0
    186a:	b7a1                	j	17b2 <memset+0xdc>
    186c:	4f09                	li	t5,2
    186e:	b5ed                	j	1758 <memset+0x82>
    1870:	4f11                	li	t5,4
    1872:	b5dd                	j	1758 <memset+0x82>
    1874:	4f15                	li	t5,5
    1876:	b5cd                	j	1758 <memset+0x82>
    1878:	4f19                	li	t5,6
    187a:	bdf9                	j	1758 <memset+0x82>

000000000000187c <strcmp>:

int strcmp(const char *l, const char *r)
{
    for (; *l == *r && *l; l++, r++)
    187c:	00054783          	lbu	a5,0(a0)
    1880:	0005c703          	lbu	a4,0(a1)
    1884:	00e79863          	bne	a5,a4,1894 <strcmp+0x18>
    1888:	0505                	addi	a0,a0,1
    188a:	0585                	addi	a1,a1,1
    188c:	fbe5                	bnez	a5,187c <strcmp>
    188e:	4501                	li	a0,0
        ;
    return *(unsigned char *)l - *(unsigned char *)r;
}
    1890:	9d19                	subw	a0,a0,a4
    1892:	8082                	ret
    return *(unsigned char *)l - *(unsigned char *)r;
    1894:	0007851b          	sext.w	a0,a5
    1898:	bfe5                	j	1890 <strcmp+0x14>

000000000000189a <strncmp>:

int strncmp(const char *_l, const char *_r, size_t n)
{
    const unsigned char *l = (void *)_l, *r = (void *)_r;
    if (!n--)
    189a:	ce05                	beqz	a2,18d2 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    189c:	00054703          	lbu	a4,0(a0)
    18a0:	0005c783          	lbu	a5,0(a1)
    18a4:	cb0d                	beqz	a4,18d6 <strncmp+0x3c>
    if (!n--)
    18a6:	167d                	addi	a2,a2,-1
    18a8:	00c506b3          	add	a3,a0,a2
    18ac:	a819                	j	18c2 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18ae:	00a68e63          	beq	a3,a0,18ca <strncmp+0x30>
    18b2:	0505                	addi	a0,a0,1
    18b4:	00e79b63          	bne	a5,a4,18ca <strncmp+0x30>
    18b8:	00054703          	lbu	a4,0(a0)
        ;
    return *l - *r;
    18bc:	0005c783          	lbu	a5,0(a1)
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18c0:	cb19                	beqz	a4,18d6 <strncmp+0x3c>
    18c2:	0005c783          	lbu	a5,0(a1)
    18c6:	0585                	addi	a1,a1,1
    18c8:	f3fd                	bnez	a5,18ae <strncmp+0x14>
    return *l - *r;
    18ca:	0007051b          	sext.w	a0,a4
    18ce:	9d1d                	subw	a0,a0,a5
    18d0:	8082                	ret
        return 0;
    18d2:	4501                	li	a0,0
}
    18d4:	8082                	ret
    18d6:	4501                	li	a0,0
    return *l - *r;
    18d8:	9d1d                	subw	a0,a0,a5
    18da:	8082                	ret

00000000000018dc <strlen>:
size_t strlen(const char *s)
{
    const char *a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word *w;
    for (; (uintptr_t)s % SS; s++)
    18dc:	00757793          	andi	a5,a0,7
    18e0:	cf89                	beqz	a5,18fa <strlen+0x1e>
    18e2:	87aa                	mv	a5,a0
    18e4:	a029                	j	18ee <strlen+0x12>
    18e6:	0785                	addi	a5,a5,1
    18e8:	0077f713          	andi	a4,a5,7
    18ec:	cb01                	beqz	a4,18fc <strlen+0x20>
        if (!*s)
    18ee:	0007c703          	lbu	a4,0(a5)
    18f2:	fb75                	bnez	a4,18e6 <strlen+0xa>
    for (w = (const void *)s; !HASZERO(*w); w++)
        ;
    s = (const void *)w;
    for (; *s; s++)
        ;
    return s - a;
    18f4:	40a78533          	sub	a0,a5,a0
}
    18f8:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18fa:	87aa                	mv	a5,a0
    for (w = (const void *)s; !HASZERO(*w); w++)
    18fc:	6394                	ld	a3,0(a5)
    18fe:	00000597          	auipc	a1,0x0
    1902:	6c25b583          	ld	a1,1730(a1) # 1fc0 <__clone+0xc8>
    1906:	00000617          	auipc	a2,0x0
    190a:	6c263603          	ld	a2,1730(a2) # 1fc8 <__clone+0xd0>
    190e:	a019                	j	1914 <strlen+0x38>
    1910:	6794                	ld	a3,8(a5)
    1912:	07a1                	addi	a5,a5,8
    1914:	00b68733          	add	a4,a3,a1
    1918:	fff6c693          	not	a3,a3
    191c:	8f75                	and	a4,a4,a3
    191e:	8f71                	and	a4,a4,a2
    1920:	db65                	beqz	a4,1910 <strlen+0x34>
    for (; *s; s++)
    1922:	0007c703          	lbu	a4,0(a5)
    1926:	d779                	beqz	a4,18f4 <strlen+0x18>
    1928:	0017c703          	lbu	a4,1(a5)
    192c:	0785                	addi	a5,a5,1
    192e:	d379                	beqz	a4,18f4 <strlen+0x18>
    1930:	0017c703          	lbu	a4,1(a5)
    1934:	0785                	addi	a5,a5,1
    1936:	fb6d                	bnez	a4,1928 <strlen+0x4c>
    1938:	bf75                	j	18f4 <strlen+0x18>

000000000000193a <memchr>:

void *memchr(const void *src, int c, size_t n)
{
    const unsigned char *s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    193a:	00757713          	andi	a4,a0,7
{
    193e:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1940:	0ff5f593          	zext.b	a1,a1
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1944:	cb19                	beqz	a4,195a <memchr+0x20>
    1946:	ce25                	beqz	a2,19be <memchr+0x84>
    1948:	0007c703          	lbu	a4,0(a5)
    194c:	04b70e63          	beq	a4,a1,19a8 <memchr+0x6e>
    1950:	0785                	addi	a5,a5,1
    1952:	0077f713          	andi	a4,a5,7
    1956:	167d                	addi	a2,a2,-1
    1958:	f77d                	bnez	a4,1946 <memchr+0xc>
            ;
        s = (const void *)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void *)s : 0;
    195a:	4501                	li	a0,0
    if (n && *s != c)
    195c:	c235                	beqz	a2,19c0 <memchr+0x86>
    195e:	0007c703          	lbu	a4,0(a5)
    1962:	04b70363          	beq	a4,a1,19a8 <memchr+0x6e>
        size_t k = ONES * c;
    1966:	00000517          	auipc	a0,0x0
    196a:	66a53503          	ld	a0,1642(a0) # 1fd0 <__clone+0xd8>
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    196e:	471d                	li	a4,7
        size_t k = ONES * c;
    1970:	02a58533          	mul	a0,a1,a0
        for (w = (const void *)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1974:	02c77a63          	bgeu	a4,a2,19a8 <memchr+0x6e>
    1978:	00000897          	auipc	a7,0x0
    197c:	6488b883          	ld	a7,1608(a7) # 1fc0 <__clone+0xc8>
    1980:	00000817          	auipc	a6,0x0
    1984:	64883803          	ld	a6,1608(a6) # 1fc8 <__clone+0xd0>
    1988:	431d                	li	t1,7
    198a:	a029                	j	1994 <memchr+0x5a>
    198c:	1661                	addi	a2,a2,-8
    198e:	07a1                	addi	a5,a5,8
    1990:	02c37963          	bgeu	t1,a2,19c2 <memchr+0x88>
    1994:	6398                	ld	a4,0(a5)
    1996:	8f29                	xor	a4,a4,a0
    1998:	011706b3          	add	a3,a4,a7
    199c:	fff74713          	not	a4,a4
    19a0:	8f75                	and	a4,a4,a3
    19a2:	01077733          	and	a4,a4,a6
    19a6:	d37d                	beqz	a4,198c <memchr+0x52>
    19a8:	853e                	mv	a0,a5
    19aa:	97b2                	add	a5,a5,a2
    19ac:	a021                	j	19b4 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19ae:	0505                	addi	a0,a0,1
    19b0:	00f50763          	beq	a0,a5,19be <memchr+0x84>
    19b4:	00054703          	lbu	a4,0(a0)
    19b8:	feb71be3          	bne	a4,a1,19ae <memchr+0x74>
    19bc:	8082                	ret
    return n ? (void *)s : 0;
    19be:	4501                	li	a0,0
}
    19c0:	8082                	ret
    return n ? (void *)s : 0;
    19c2:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19c4:	f275                	bnez	a2,19a8 <memchr+0x6e>
}
    19c6:	8082                	ret

00000000000019c8 <strnlen>:

size_t strnlen(const char *s, size_t n)
{
    19c8:	1101                	addi	sp,sp,-32
    19ca:	e822                	sd	s0,16(sp)
    const char *p = memchr(s, 0, n);
    19cc:	862e                	mv	a2,a1
{
    19ce:	842e                	mv	s0,a1
    const char *p = memchr(s, 0, n);
    19d0:	4581                	li	a1,0
{
    19d2:	e426                	sd	s1,8(sp)
    19d4:	ec06                	sd	ra,24(sp)
    19d6:	84aa                	mv	s1,a0
    const char *p = memchr(s, 0, n);
    19d8:	f63ff0ef          	jal	193a <memchr>
    return p ? p - s : n;
    19dc:	c519                	beqz	a0,19ea <strnlen+0x22>
}
    19de:	60e2                	ld	ra,24(sp)
    19e0:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19e2:	8d05                	sub	a0,a0,s1
}
    19e4:	64a2                	ld	s1,8(sp)
    19e6:	6105                	addi	sp,sp,32
    19e8:	8082                	ret
    19ea:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19ec:	8522                	mv	a0,s0
}
    19ee:	6442                	ld	s0,16(sp)
    19f0:	64a2                	ld	s1,8(sp)
    19f2:	6105                	addi	sp,sp,32
    19f4:	8082                	ret

00000000000019f6 <strcpy>:
char *strcpy(char *restrict d, const char *s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS)
    19f6:	00b547b3          	xor	a5,a0,a1
    19fa:	8b9d                	andi	a5,a5,7
    19fc:	eb95                	bnez	a5,1a30 <strcpy+0x3a>
    {
        for (; (uintptr_t)s % SS; s++, d++)
    19fe:	0075f793          	andi	a5,a1,7
    1a02:	e7b1                	bnez	a5,1a4e <strcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void *)d;
        ws = (const void *)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a04:	6198                	ld	a4,0(a1)
    1a06:	00000617          	auipc	a2,0x0
    1a0a:	5ba63603          	ld	a2,1466(a2) # 1fc0 <__clone+0xc8>
    1a0e:	00000817          	auipc	a6,0x0
    1a12:	5ba83803          	ld	a6,1466(a6) # 1fc8 <__clone+0xd0>
    1a16:	a029                	j	1a20 <strcpy+0x2a>
    1a18:	e118                	sd	a4,0(a0)
    1a1a:	6598                	ld	a4,8(a1)
    1a1c:	05a1                	addi	a1,a1,8
    1a1e:	0521                	addi	a0,a0,8
    1a20:	00c707b3          	add	a5,a4,a2
    1a24:	fff74693          	not	a3,a4
    1a28:	8ff5                	and	a5,a5,a3
    1a2a:	0107f7b3          	and	a5,a5,a6
    1a2e:	d7ed                	beqz	a5,1a18 <strcpy+0x22>
            ;
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; (*d = *s); s++, d++)
    1a30:	0005c783          	lbu	a5,0(a1)
    1a34:	00f50023          	sb	a5,0(a0)
    1a38:	c785                	beqz	a5,1a60 <strcpy+0x6a>
    1a3a:	0015c783          	lbu	a5,1(a1)
    1a3e:	0505                	addi	a0,a0,1
    1a40:	0585                	addi	a1,a1,1
    1a42:	00f50023          	sb	a5,0(a0)
    1a46:	fbf5                	bnez	a5,1a3a <strcpy+0x44>
        ;
    return d;
}
    1a48:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a4a:	0505                	addi	a0,a0,1
    1a4c:	df45                	beqz	a4,1a04 <strcpy+0xe>
            if (!(*d = *s))
    1a4e:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a52:	0585                	addi	a1,a1,1
    1a54:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a58:	00f50023          	sb	a5,0(a0)
    1a5c:	f7fd                	bnez	a5,1a4a <strcpy+0x54>
}
    1a5e:	8082                	ret
    1a60:	8082                	ret

0000000000001a62 <strncpy>:
char *strncpy(char *restrict d, const char *s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word *wd;
    const word *ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN))
    1a62:	00b547b3          	xor	a5,a0,a1
    1a66:	8b9d                	andi	a5,a5,7
    1a68:	1a079863          	bnez	a5,1c18 <strncpy+0x1b6>
    {
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a6c:	0075f793          	andi	a5,a1,7
    1a70:	16078463          	beqz	a5,1bd8 <strncpy+0x176>
    1a74:	ea01                	bnez	a2,1a84 <strncpy+0x22>
    1a76:	a421                	j	1c7e <strncpy+0x21c>
    1a78:	167d                	addi	a2,a2,-1
    1a7a:	0505                	addi	a0,a0,1
    1a7c:	14070e63          	beqz	a4,1bd8 <strncpy+0x176>
    1a80:	1a060863          	beqz	a2,1c30 <strncpy+0x1ce>
    1a84:	0005c783          	lbu	a5,0(a1)
    1a88:	0585                	addi	a1,a1,1
    1a8a:	0075f713          	andi	a4,a1,7
    1a8e:	00f50023          	sb	a5,0(a0)
    1a92:	f3fd                	bnez	a5,1a78 <strncpy+0x16>
    1a94:	4805                	li	a6,1
    1a96:	1a061863          	bnez	a2,1c46 <strncpy+0x1e4>
    1a9a:	40a007b3          	neg	a5,a0
    1a9e:	8b9d                	andi	a5,a5,7
    1aa0:	4681                	li	a3,0
    1aa2:	18061a63          	bnez	a2,1c36 <strncpy+0x1d4>
    1aa6:	00778713          	addi	a4,a5,7
    1aaa:	45ad                	li	a1,11
    1aac:	18b76363          	bltu	a4,a1,1c32 <strncpy+0x1d0>
    1ab0:	1ae6eb63          	bltu	a3,a4,1c66 <strncpy+0x204>
    1ab4:	1a078363          	beqz	a5,1c5a <strncpy+0x1f8>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1ab8:	00050023          	sb	zero,0(a0)
    1abc:	4685                	li	a3,1
    1abe:	00150713          	addi	a4,a0,1
    1ac2:	18d78f63          	beq	a5,a3,1c60 <strncpy+0x1fe>
    1ac6:	000500a3          	sb	zero,1(a0)
    1aca:	4689                	li	a3,2
    1acc:	00250713          	addi	a4,a0,2
    1ad0:	18d78e63          	beq	a5,a3,1c6c <strncpy+0x20a>
    1ad4:	00050123          	sb	zero,2(a0)
    1ad8:	468d                	li	a3,3
    1ada:	00350713          	addi	a4,a0,3
    1ade:	16d78c63          	beq	a5,a3,1c56 <strncpy+0x1f4>
    1ae2:	000501a3          	sb	zero,3(a0)
    1ae6:	4691                	li	a3,4
    1ae8:	00450713          	addi	a4,a0,4
    1aec:	18d78263          	beq	a5,a3,1c70 <strncpy+0x20e>
    1af0:	00050223          	sb	zero,4(a0)
    1af4:	4695                	li	a3,5
    1af6:	00550713          	addi	a4,a0,5
    1afa:	16d78d63          	beq	a5,a3,1c74 <strncpy+0x212>
    1afe:	000502a3          	sb	zero,5(a0)
    1b02:	469d                	li	a3,7
    1b04:	00650713          	addi	a4,a0,6
    1b08:	16d79863          	bne	a5,a3,1c78 <strncpy+0x216>
    1b0c:	00750713          	addi	a4,a0,7
    1b10:	00050323          	sb	zero,6(a0)
    1b14:	40f80833          	sub	a6,a6,a5
    1b18:	ff887593          	andi	a1,a6,-8
    1b1c:	97aa                	add	a5,a5,a0
    1b1e:	95be                	add	a1,a1,a5
    1b20:	0007b023          	sd	zero,0(a5)
    1b24:	07a1                	addi	a5,a5,8
    1b26:	feb79de3          	bne	a5,a1,1b20 <strncpy+0xbe>
    1b2a:	ff887593          	andi	a1,a6,-8
    1b2e:	9ead                	addw	a3,a3,a1
    1b30:	00b707b3          	add	a5,a4,a1
    1b34:	12b80863          	beq	a6,a1,1c64 <strncpy+0x202>
    1b38:	00078023          	sb	zero,0(a5)
    1b3c:	0016871b          	addiw	a4,a3,1
    1b40:	0ec77863          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1b44:	000780a3          	sb	zero,1(a5)
    1b48:	0026871b          	addiw	a4,a3,2
    1b4c:	0ec77263          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1b50:	00078123          	sb	zero,2(a5)
    1b54:	0036871b          	addiw	a4,a3,3
    1b58:	0cc77c63          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1b5c:	000781a3          	sb	zero,3(a5)
    1b60:	0046871b          	addiw	a4,a3,4
    1b64:	0cc77663          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1b68:	00078223          	sb	zero,4(a5)
    1b6c:	0056871b          	addiw	a4,a3,5
    1b70:	0cc77063          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1b74:	000782a3          	sb	zero,5(a5)
    1b78:	0066871b          	addiw	a4,a3,6
    1b7c:	0ac77a63          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1b80:	00078323          	sb	zero,6(a5)
    1b84:	0076871b          	addiw	a4,a3,7
    1b88:	0ac77463          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1b8c:	000783a3          	sb	zero,7(a5)
    1b90:	0086871b          	addiw	a4,a3,8
    1b94:	08c77e63          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1b98:	00078423          	sb	zero,8(a5)
    1b9c:	0096871b          	addiw	a4,a3,9
    1ba0:	08c77863          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1ba4:	000784a3          	sb	zero,9(a5)
    1ba8:	00a6871b          	addiw	a4,a3,10
    1bac:	08c77263          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1bb0:	00078523          	sb	zero,10(a5)
    1bb4:	00b6871b          	addiw	a4,a3,11
    1bb8:	06c77c63          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1bbc:	000785a3          	sb	zero,11(a5)
    1bc0:	00c6871b          	addiw	a4,a3,12
    1bc4:	06c77663          	bgeu	a4,a2,1c30 <strncpy+0x1ce>
    1bc8:	00078623          	sb	zero,12(a5)
    1bcc:	26b5                	addiw	a3,a3,13
    1bce:	06c6f163          	bgeu	a3,a2,1c30 <strncpy+0x1ce>
    1bd2:	000786a3          	sb	zero,13(a5)
    1bd6:	8082                	ret
            ;
        if (!n || !*s)
    1bd8:	c645                	beqz	a2,1c80 <strncpy+0x21e>
    1bda:	0005c783          	lbu	a5,0(a1)
    1bde:	ea078be3          	beqz	a5,1a94 <strncpy+0x32>
            goto tail;
        wd = (void *)d;
        ws = (const void *)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1be2:	479d                	li	a5,7
    1be4:	02c7ff63          	bgeu	a5,a2,1c22 <strncpy+0x1c0>
    1be8:	00000897          	auipc	a7,0x0
    1bec:	3d88b883          	ld	a7,984(a7) # 1fc0 <__clone+0xc8>
    1bf0:	00000817          	auipc	a6,0x0
    1bf4:	3d883803          	ld	a6,984(a6) # 1fc8 <__clone+0xd0>
    1bf8:	431d                	li	t1,7
    1bfa:	6198                	ld	a4,0(a1)
    1bfc:	011707b3          	add	a5,a4,a7
    1c00:	fff74693          	not	a3,a4
    1c04:	8ff5                	and	a5,a5,a3
    1c06:	0107f7b3          	and	a5,a5,a6
    1c0a:	ef81                	bnez	a5,1c22 <strncpy+0x1c0>
            *wd = *ws;
    1c0c:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c0e:	1661                	addi	a2,a2,-8
    1c10:	05a1                	addi	a1,a1,8
    1c12:	0521                	addi	a0,a0,8
    1c14:	fec363e3          	bltu	t1,a2,1bfa <strncpy+0x198>
        d = (void *)wd;
        s = (const void *)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c18:	e609                	bnez	a2,1c22 <strncpy+0x1c0>
    1c1a:	a08d                	j	1c7c <strncpy+0x21a>
    1c1c:	167d                	addi	a2,a2,-1
    1c1e:	0505                	addi	a0,a0,1
    1c20:	ca01                	beqz	a2,1c30 <strncpy+0x1ce>
    1c22:	0005c783          	lbu	a5,0(a1)
    1c26:	0585                	addi	a1,a1,1
    1c28:	00f50023          	sb	a5,0(a0)
    1c2c:	fbe5                	bnez	a5,1c1c <strncpy+0x1ba>
        ;
tail:
    1c2e:	b59d                	j	1a94 <strncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c30:	8082                	ret
    1c32:	472d                	li	a4,11
    1c34:	bdb5                	j	1ab0 <strncpy+0x4e>
    1c36:	00778713          	addi	a4,a5,7
    1c3a:	45ad                	li	a1,11
    1c3c:	fff60693          	addi	a3,a2,-1
    1c40:	e6b778e3          	bgeu	a4,a1,1ab0 <strncpy+0x4e>
    1c44:	b7fd                	j	1c32 <strncpy+0x1d0>
    1c46:	40a007b3          	neg	a5,a0
    1c4a:	8832                	mv	a6,a2
    1c4c:	8b9d                	andi	a5,a5,7
    1c4e:	4681                	li	a3,0
    1c50:	e4060be3          	beqz	a2,1aa6 <strncpy+0x44>
    1c54:	b7cd                	j	1c36 <strncpy+0x1d4>
    for (int i = 0; i < n; ++i, *(p++) = c)
    1c56:	468d                	li	a3,3
    1c58:	bd75                	j	1b14 <strncpy+0xb2>
    1c5a:	872a                	mv	a4,a0
    1c5c:	4681                	li	a3,0
    1c5e:	bd5d                	j	1b14 <strncpy+0xb2>
    1c60:	4685                	li	a3,1
    1c62:	bd4d                	j	1b14 <strncpy+0xb2>
    1c64:	8082                	ret
    1c66:	87aa                	mv	a5,a0
    1c68:	4681                	li	a3,0
    1c6a:	b5f9                	j	1b38 <strncpy+0xd6>
    1c6c:	4689                	li	a3,2
    1c6e:	b55d                	j	1b14 <strncpy+0xb2>
    1c70:	4691                	li	a3,4
    1c72:	b54d                	j	1b14 <strncpy+0xb2>
    1c74:	4695                	li	a3,5
    1c76:	bd79                	j	1b14 <strncpy+0xb2>
    1c78:	4699                	li	a3,6
    1c7a:	bd69                	j	1b14 <strncpy+0xb2>
    1c7c:	8082                	ret
    1c7e:	8082                	ret
    1c80:	8082                	ret

0000000000001c82 <open>:
#include <unistd.h>

#include "syscall.h"

int open(const char *path, int flags)
{
    1c82:	87aa                	mv	a5,a0
    1c84:	862e                	mv	a2,a1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
}

static inline long __syscall4(long n, long a, long b, long c, long d)
{
    register long a7 __asm__("a7") = n;
    1c86:	03800893          	li	a7,56
    register long a0 __asm__("a0") = a;
    1c8a:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1c8e:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    1c90:	4689                	li	a3,2
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1c92:	00000073          	ecall
    return syscall(SYS_openat, AT_FDCWD, path, flags, O_RDWR);
}
    1c96:	2501                	sext.w	a0,a0
    1c98:	8082                	ret

0000000000001c9a <openat>:
    register long a7 __asm__("a7") = n;
    1c9a:	03800893          	li	a7,56
    register long a3 __asm__("a3") = d;
    1c9e:	18000693          	li	a3,384
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1ca2:	00000073          	ecall

int openat(int dirfd,const char *path, int flags)
{
    return syscall(SYS_openat, dirfd, path, flags, 0600);
}
    1ca6:	2501                	sext.w	a0,a0
    1ca8:	8082                	ret

0000000000001caa <close>:
    register long a7 __asm__("a7") = n;
    1caa:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cae:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cb2:	2501                	sext.w	a0,a0
    1cb4:	8082                	ret

0000000000001cb6 <read>:
    register long a7 __asm__("a7") = n;
    1cb6:	03f00893          	li	a7,63
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cba:	00000073          	ecall

ssize_t read(int fd, void *buf, size_t len)
{
    return syscall(SYS_read, fd, buf, len);
}
    1cbe:	8082                	ret

0000000000001cc0 <write>:
    register long a7 __asm__("a7") = n;
    1cc0:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cc4:	00000073          	ecall

ssize_t write(int fd, const void *buf, size_t len)
{
    return syscall(SYS_write, fd, buf, len);
}
    1cc8:	8082                	ret

0000000000001cca <getpid>:
    register long a7 __asm__("a7") = n;
    1cca:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cce:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cd2:	2501                	sext.w	a0,a0
    1cd4:	8082                	ret

0000000000001cd6 <getppid>:
    register long a7 __asm__("a7") = n;
    1cd6:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1cda:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cde:	2501                	sext.w	a0,a0
    1ce0:	8082                	ret

0000000000001ce2 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1ce2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1ce6:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cea:	2501                	sext.w	a0,a0
    1cec:	8082                	ret

0000000000001cee <fork>:
    register long a7 __asm__("a7") = n;
    1cee:	0dc00893          	li	a7,220
    register long a0 __asm__("a0") = a;
    1cf2:	4545                	li	a0,17
    register long a1 __asm__("a1") = b;
    1cf4:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cf6:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_clone, SIGCHLD, 0);
}
    1cfa:	2501                	sext.w	a0,a0
    1cfc:	8082                	ret

0000000000001cfe <clone>:

pid_t clone(int (*fn)(void *arg), void *arg, void *stack, size_t stack_size, unsigned long flags)
{
    1cfe:	85b2                	mv	a1,a2
    1d00:	863a                	mv	a2,a4
    if (stack)
    1d02:	c191                	beqz	a1,1d06 <clone+0x8>
	stack += stack_size;
    1d04:	95b6                	add	a1,a1,a3

    return __clone(fn, stack, flags, NULL, NULL, NULL);
    1d06:	4781                	li	a5,0
    1d08:	4701                	li	a4,0
    1d0a:	4681                	li	a3,0
    1d0c:	2601                	sext.w	a2,a2
    1d0e:	a2ed                	j	1ef8 <__clone>

0000000000001d10 <exit>:
    register long a7 __asm__("a7") = n;
    1d10:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d14:	00000073          	ecall
    //return syscall(SYS_clone, fn, stack, flags, NULL, NULL, NULL);
}
void exit(int code)
{
    syscall(SYS_exit, code);
}
    1d18:	8082                	ret

0000000000001d1a <waitpid>:
    register long a7 __asm__("a7") = n;
    1d1a:	10400893          	li	a7,260
    register long a3 __asm__("a3") = d;
    1d1e:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1d20:	00000073          	ecall

int waitpid(int pid, int *code, int options)
{
    return syscall(SYS_wait4, pid, code, options, 0);
}
    1d24:	2501                	sext.w	a0,a0
    1d26:	8082                	ret

0000000000001d28 <exec>:
    register long a7 __asm__("a7") = n;
    1d28:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0))
    1d2c:	00000073          	ecall

int exec(char *name)
{
    return syscall(SYS_execve, name);
}
    1d30:	2501                	sext.w	a0,a0
    1d32:	8082                	ret

0000000000001d34 <execve>:
    register long a7 __asm__("a7") = n;
    1d34:	0dd00893          	li	a7,221
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d38:	00000073          	ecall

int execve(const char *name, char *const argv[], char *const argp[])
{
    return syscall(SYS_execve, name, argv, argp);
}
    1d3c:	2501                	sext.w	a0,a0
    1d3e:	8082                	ret

0000000000001d40 <times>:
    register long a7 __asm__("a7") = n;
    1d40:	09900893          	li	a7,153
    __asm_syscall("r"(a7), "0"(a0))
    1d44:	00000073          	ecall

int times(void *mytimes)
{
	return syscall(SYS_times, mytimes);
}
    1d48:	2501                	sext.w	a0,a0
    1d4a:	8082                	ret

0000000000001d4c <get_time>:

int64 get_time()
{
    1d4c:	1141                	addi	sp,sp,-16
    register long a7 __asm__("a7") = n;
    1d4e:	0a900893          	li	a7,169
    register long a0 __asm__("a0") = a;
    1d52:	850a                	mv	a0,sp
    register long a1 __asm__("a1") = b;
    1d54:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d56:	00000073          	ecall
    TimeVal time;
    int err = sys_get_time(&time, 0);
    if (err == 0)
    1d5a:	2501                	sext.w	a0,a0
    1d5c:	ed09                	bnez	a0,1d76 <get_time+0x2a>
    {
        return ((time.sec & 0xffff) * 1000 + time.usec / 1000);
    1d5e:	67a2                	ld	a5,8(sp)
    1d60:	3e800713          	li	a4,1000
    1d64:	00015503          	lhu	a0,0(sp)
    1d68:	02e7d7b3          	divu	a5,a5,a4
    1d6c:	02e50533          	mul	a0,a0,a4
    1d70:	953e                	add	a0,a0,a5
    }
    else
    {
        return -1;
    }
}
    1d72:	0141                	addi	sp,sp,16
    1d74:	8082                	ret
        return -1;
    1d76:	557d                	li	a0,-1
    1d78:	bfed                	j	1d72 <get_time+0x26>

0000000000001d7a <sys_get_time>:
    register long a7 __asm__("a7") = n;
    1d7a:	0a900893          	li	a7,169
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d7e:	00000073          	ecall

int sys_get_time(TimeVal *ts, int tz)
{
    return syscall(SYS_gettimeofday, ts, tz);
}
    1d82:	2501                	sext.w	a0,a0
    1d84:	8082                	ret

0000000000001d86 <time>:
    register long a7 __asm__("a7") = n;
    1d86:	42600893          	li	a7,1062
    __asm_syscall("r"(a7), "0"(a0))
    1d8a:	00000073          	ecall

int time(unsigned long *tloc)
{
    return syscall(SYS_time, tloc);
}
    1d8e:	2501                	sext.w	a0,a0
    1d90:	8082                	ret

0000000000001d92 <sleep>:

int sleep(unsigned long long time)
{
    1d92:	1141                	addi	sp,sp,-16
    TimeVal tv = {.sec = time, .usec = 0};
    1d94:	e02a                	sd	a0,0(sp)
    register long a0 __asm__("a0") = a;
    1d96:	850a                	mv	a0,sp
    1d98:	e402                	sd	zero,8(sp)
    register long a7 __asm__("a7") = n;
    1d9a:	06500893          	li	a7,101
    register long a1 __asm__("a1") = b;
    1d9e:	85aa                	mv	a1,a0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1da0:	00000073          	ecall
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1da4:	e501                	bnez	a0,1dac <sleep+0x1a>
    return 0;
    1da6:	4501                	li	a0,0
}
    1da8:	0141                	addi	sp,sp,16
    1daa:	8082                	ret
    if (syscall(SYS_nanosleep, &tv, &tv)) return tv.sec;
    1dac:	4502                	lw	a0,0(sp)
}
    1dae:	0141                	addi	sp,sp,16
    1db0:	8082                	ret

0000000000001db2 <set_priority>:
    register long a7 __asm__("a7") = n;
    1db2:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1db6:	00000073          	ecall

int set_priority(int prio)
{
    return syscall(SYS_setpriority, prio);
}
    1dba:	2501                	sext.w	a0,a0
    1dbc:	8082                	ret

0000000000001dbe <mmap>:
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
}

static inline long __syscall6(long n, long a, long b, long c, long d, long e, long f)
{
    register long a7 __asm__("a7") = n;
    1dbe:	0de00893          	li	a7,222
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    register long a3 __asm__("a3") = d;
    register long a4 __asm__("a4") = e;
    register long a5 __asm__("a5") = f;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5))
    1dc2:	00000073          	ecall

void *mmap(void *start, size_t len, int prot, int flags, int fd, off_t off)
{
    return syscall(SYS_mmap, start, len, prot, flags, fd, off);
}
    1dc6:	8082                	ret

0000000000001dc8 <munmap>:
    register long a7 __asm__("a7") = n;
    1dc8:	0d700893          	li	a7,215
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dcc:	00000073          	ecall

int munmap(void *start, size_t len)
{
    return syscall(SYS_munmap, start, len);
}
    1dd0:	2501                	sext.w	a0,a0
    1dd2:	8082                	ret

0000000000001dd4 <wait>:

int wait(int *code)
{
    1dd4:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dd6:	10400893          	li	a7,260
    register long a0 __asm__("a0") = a;
    1dda:	557d                	li	a0,-1
    register long a2 __asm__("a2") = c;
    1ddc:	4601                	li	a2,0
    register long a3 __asm__("a3") = d;
    1dde:	4681                	li	a3,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3))
    1de0:	00000073          	ecall
    return waitpid((int)-1, code, 0);
}
    1de4:	2501                	sext.w	a0,a0
    1de6:	8082                	ret

0000000000001de8 <spawn>:
    register long a7 __asm__("a7") = n;
    1de8:	19000893          	li	a7,400
    __asm_syscall("r"(a7), "0"(a0))
    1dec:	00000073          	ecall

int spawn(char *file)
{
    return syscall(SYS_spawn, file);
}
    1df0:	2501                	sext.w	a0,a0
    1df2:	8082                	ret

0000000000001df4 <mailread>:
    register long a7 __asm__("a7") = n;
    1df4:	19100893          	li	a7,401
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1df8:	00000073          	ecall

int mailread(void *buf, int len)
{
    return syscall(SYS_mailread, buf, len);
}
    1dfc:	2501                	sext.w	a0,a0
    1dfe:	8082                	ret

0000000000001e00 <mailwrite>:
    register long a7 __asm__("a7") = n;
    1e00:	19200893          	li	a7,402
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e04:	00000073          	ecall

int mailwrite(int pid, void *buf, int len)
{
    return syscall(SYS_mailwrite, pid, buf, len);
}
    1e08:	2501                	sext.w	a0,a0
    1e0a:	8082                	ret

0000000000001e0c <fstat>:
    register long a7 __asm__("a7") = n;
    1e0c:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e10:	00000073          	ecall

int fstat(int fd, struct kstat *st)
{
    return syscall(SYS_fstat, fd, st);
}
    1e14:	2501                	sext.w	a0,a0
    1e16:	8082                	ret

0000000000001e18 <sys_linkat>:
    register long a4 __asm__("a4") = e;
    1e18:	1702                	slli	a4,a4,0x20
    register long a7 __asm__("a7") = n;
    1e1a:	02500893          	li	a7,37
    register long a4 __asm__("a4") = e;
    1e1e:	9301                	srli	a4,a4,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e20:	00000073          	ecall

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, unsigned int flags)
{
    return syscall(SYS_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}
    1e24:	2501                	sext.w	a0,a0
    1e26:	8082                	ret

0000000000001e28 <sys_unlinkat>:
    register long a2 __asm__("a2") = c;
    1e28:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e2a:	02300893          	li	a7,35
    register long a2 __asm__("a2") = c;
    1e2e:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e30:	00000073          	ecall

int sys_unlinkat(int dirfd, char *path, unsigned int flags)
{
    return syscall(SYS_unlinkat, dirfd, path, flags);
}
    1e34:	2501                	sext.w	a0,a0
    1e36:	8082                	ret

0000000000001e38 <link>:

int link(char *old_path, char *new_path)
{
    1e38:	87aa                	mv	a5,a0
    1e3a:	86ae                	mv	a3,a1
    register long a7 __asm__("a7") = n;
    1e3c:	02500893          	li	a7,37
    register long a0 __asm__("a0") = a;
    1e40:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1e44:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1e46:	f9c00613          	li	a2,-100
    register long a4 __asm__("a4") = e;
    1e4a:	4701                	li	a4,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1e4c:	00000073          	ecall
    return sys_linkat(AT_FDCWD, old_path, AT_FDCWD, new_path, 0);
}
    1e50:	2501                	sext.w	a0,a0
    1e52:	8082                	ret

0000000000001e54 <unlink>:

int unlink(char *path)
{
    1e54:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1e56:	02300893          	li	a7,35
    register long a0 __asm__("a0") = a;
    1e5a:	f9c00513          	li	a0,-100
    register long a2 __asm__("a2") = c;
    1e5e:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e60:	00000073          	ecall
    return sys_unlinkat(AT_FDCWD, path, 0);
}
    1e64:	2501                	sext.w	a0,a0
    1e66:	8082                	ret

0000000000001e68 <uname>:
    register long a7 __asm__("a7") = n;
    1e68:	0a000893          	li	a7,160
    __asm_syscall("r"(a7), "0"(a0))
    1e6c:	00000073          	ecall

int uname(void *buf)
{
    return syscall(SYS_uname, buf);
}
    1e70:	2501                	sext.w	a0,a0
    1e72:	8082                	ret

0000000000001e74 <brk>:
    register long a7 __asm__("a7") = n;
    1e74:	0d600893          	li	a7,214
    __asm_syscall("r"(a7), "0"(a0))
    1e78:	00000073          	ecall

int brk(void *addr)
{
    return syscall(SYS_brk, addr);
}
    1e7c:	2501                	sext.w	a0,a0
    1e7e:	8082                	ret

0000000000001e80 <getcwd>:
    register long a7 __asm__("a7") = n;
    1e80:	48c5                	li	a7,17
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e82:	00000073          	ecall

char *getcwd(char *buf, size_t size){
    return syscall(SYS_getcwd, buf, size);
}
    1e86:	8082                	ret

0000000000001e88 <chdir>:
    register long a7 __asm__("a7") = n;
    1e88:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e8c:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e90:	2501                	sext.w	a0,a0
    1e92:	8082                	ret

0000000000001e94 <mkdir>:

int mkdir(const char *path, mode_t mode){
    1e94:	862e                	mv	a2,a1
    1e96:	87aa                	mv	a5,a0
    register long a2 __asm__("a2") = c;
    1e98:	1602                	slli	a2,a2,0x20
    register long a7 __asm__("a7") = n;
    1e9a:	02200893          	li	a7,34
    register long a0 __asm__("a0") = a;
    1e9e:	f9c00513          	li	a0,-100
    register long a1 __asm__("a1") = b;
    1ea2:	85be                	mv	a1,a5
    register long a2 __asm__("a2") = c;
    1ea4:	9201                	srli	a2,a2,0x20
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ea6:	00000073          	ecall
    return syscall(SYS_mkdirat, AT_FDCWD, path, mode);
}
    1eaa:	2501                	sext.w	a0,a0
    1eac:	8082                	ret

0000000000001eae <getdents>:
    register long a7 __asm__("a7") = n;
    1eae:	03d00893          	li	a7,61
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eb2:	00000073          	ecall

int getdents(int fd, struct linux_dirent64 *dirp64, unsigned long len){
    //return syscall(SYS_getdents64, fd, dirp64, len);
    return syscall(SYS_getdents64, fd, dirp64, len);
}
    1eb6:	2501                	sext.w	a0,a0
    1eb8:	8082                	ret

0000000000001eba <pipe>:
    register long a7 __asm__("a7") = n;
    1eba:	03b00893          	li	a7,59
    register long a1 __asm__("a1") = b;
    1ebe:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ec0:	00000073          	ecall

int pipe(int fd[2]){
    return syscall(SYS_pipe2, fd, 0);
}
    1ec4:	2501                	sext.w	a0,a0
    1ec6:	8082                	ret

0000000000001ec8 <dup>:
    register long a7 __asm__("a7") = n;
    1ec8:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1eca:	00000073          	ecall

int dup(int fd){
    return syscall(SYS_dup, fd);
}
    1ece:	2501                	sext.w	a0,a0
    1ed0:	8082                	ret

0000000000001ed2 <dup2>:
    register long a7 __asm__("a7") = n;
    1ed2:	48e1                	li	a7,24
    register long a2 __asm__("a2") = c;
    1ed4:	4601                	li	a2,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ed6:	00000073          	ecall

int dup2(int old, int new){
    return syscall(SYS_dup3, old, new, 0);
}
    1eda:	2501                	sext.w	a0,a0
    1edc:	8082                	ret

0000000000001ede <mount>:
    register long a7 __asm__("a7") = n;
    1ede:	02800893          	li	a7,40
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4))
    1ee2:	00000073          	ecall

int mount(const char *special, const char *dir, const char *fstype, unsigned long flags, const void *data)
{
        return syscall(SYS_mount, special, dir, fstype, flags, data);
}
    1ee6:	2501                	sext.w	a0,a0
    1ee8:	8082                	ret

0000000000001eea <umount>:
    register long a7 __asm__("a7") = n;
    1eea:	02700893          	li	a7,39
    register long a1 __asm__("a1") = b;
    1eee:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ef0:	00000073          	ecall

int umount(const char *special)
{
        return syscall(SYS_umount2, special, 0);
}
    1ef4:	2501                	sext.w	a0,a0
    1ef6:	8082                	ret

0000000000001ef8 <__clone>:

.global __clone
.type  __clone, %function
__clone:
	# Save func and arg to stack
	addi a1, a1, -16
    1ef8:	15c1                	addi	a1,a1,-16
	sd a0, 0(a1)
    1efa:	e188                	sd	a0,0(a1)
	sd a3, 8(a1)
    1efc:	e594                	sd	a3,8(a1)

	# Call SYS_clone
	mv a0, a2
    1efe:	8532                	mv	a0,a2
	mv a2, a4
    1f00:	863a                	mv	a2,a4
	mv a3, a5
    1f02:	86be                	mv	a3,a5
	mv a4, a6
    1f04:	8742                	mv	a4,a6
	li a7, 220 # SYS_clone
    1f06:	0dc00893          	li	a7,220
	ecall
    1f0a:	00000073          	ecall

	beqz a0, 1f
    1f0e:	c111                	beqz	a0,1f12 <__clone+0x1a>
	# Parent
	ret
    1f10:	8082                	ret

	# Child
1:      ld a1, 0(sp)
    1f12:	6582                	ld	a1,0(sp)
	ld a0, 8(sp)
    1f14:	6522                	ld	a0,8(sp)
	jalr a1
    1f16:	9582                	jalr	a1

	# Exit
	li a7, 93 # SYS_exit
    1f18:	05d00893          	li	a7,93
	ecall
    1f1c:	00000073          	ecall
