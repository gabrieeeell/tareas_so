
user/_dorphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  char *s = argv[0];
   a:	6184                	ld	s1,0(a1)

  if (mkdir("dd") != 0) {
   c:	00001517          	auipc	a0,0x1
  10:	8f450513          	addi	a0,a0,-1804 # 900 <malloc+0xfe>
  14:	372000ef          	jal	386 <mkdir>
  18:	c919                	beqz	a0,2e <main+0x2e>
    printf("%s: mkdir dd failed\n", s);
  1a:	85a6                	mv	a1,s1
  1c:	00001517          	auipc	a0,0x1
  20:	8ec50513          	addi	a0,a0,-1812 # 908 <malloc+0x106>
  24:	72a000ef          	jal	74e <printf>
    exit(1);
  28:	4505                	li	a0,1
  2a:	2f4000ef          	jal	31e <exit>
  }

  if (chdir("dd") != 0) {
  2e:	00001517          	auipc	a0,0x1
  32:	8d250513          	addi	a0,a0,-1838 # 900 <malloc+0xfe>
  36:	358000ef          	jal	38e <chdir>
  3a:	c919                	beqz	a0,50 <main+0x50>
    printf("%s: chdir dd failed\n", s);
  3c:	85a6                	mv	a1,s1
  3e:	00001517          	auipc	a0,0x1
  42:	8e250513          	addi	a0,a0,-1822 # 920 <malloc+0x11e>
  46:	708000ef          	jal	74e <printf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	2d2000ef          	jal	31e <exit>
  }

  if (unlink("../dd") < 0) {
  50:	00001517          	auipc	a0,0x1
  54:	8e850513          	addi	a0,a0,-1816 # 938 <malloc+0x136>
  58:	316000ef          	jal	36e <unlink>
  5c:	00054d63          	bltz	a0,76 <main+0x76>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  printf("wait for kill and reclaim\n");
  60:	00001517          	auipc	a0,0x1
  64:	8f850513          	addi	a0,a0,-1800 # 958 <malloc+0x156>
  68:	6e6000ef          	jal	74e <printf>
  // sit around until killed
  for (;;)
    pause(1000);
  6c:	3e800513          	li	a0,1000
  70:	33e000ef          	jal	3ae <pause>
  for (;;)
  74:	bfe5                	j	6c <main+0x6c>
    printf("%s: unlink failed\n", s);
  76:	85a6                	mv	a1,s1
  78:	00001517          	auipc	a0,0x1
  7c:	8c850513          	addi	a0,a0,-1848 # 940 <malloc+0x13e>
  80:	6ce000ef          	jal	74e <printf>
    exit(1);
  84:	4505                	li	a0,1
  86:	298000ef          	jal	31e <exit>

000000000000008a <start>:
  8a:	1141                	addi	sp,sp,-16
  8c:	e406                	sd	ra,8(sp)
  8e:	e022                	sd	s0,0(sp)
  90:	0800                	addi	s0,sp,16
  92:	f6fff0ef          	jal	0 <main>
  96:	288000ef          	jal	31e <exit>

000000000000009a <strcpy>:
  9a:	1141                	addi	sp,sp,-16
  9c:	e422                	sd	s0,8(sp)
  9e:	0800                	addi	s0,sp,16
  a0:	87aa                	mv	a5,a0
  a2:	0585                	addi	a1,a1,1
  a4:	0785                	addi	a5,a5,1
  a6:	fff5c703          	lbu	a4,-1(a1)
  aa:	fee78fa3          	sb	a4,-1(a5)
  ae:	fb75                	bnez	a4,a2 <strcpy+0x8>
  b0:	6422                	ld	s0,8(sp)
  b2:	0141                	addi	sp,sp,16
  b4:	8082                	ret

00000000000000b6 <strcmp>:
  b6:	1141                	addi	sp,sp,-16
  b8:	e422                	sd	s0,8(sp)
  ba:	0800                	addi	s0,sp,16
  bc:	00054783          	lbu	a5,0(a0)
  c0:	cb91                	beqz	a5,d4 <strcmp+0x1e>
  c2:	0005c703          	lbu	a4,0(a1)
  c6:	00f71763          	bne	a4,a5,d4 <strcmp+0x1e>
  ca:	0505                	addi	a0,a0,1
  cc:	0585                	addi	a1,a1,1
  ce:	00054783          	lbu	a5,0(a0)
  d2:	fbe5                	bnez	a5,c2 <strcmp+0xc>
  d4:	0005c503          	lbu	a0,0(a1)
  d8:	40a7853b          	subw	a0,a5,a0
  dc:	6422                	ld	s0,8(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret

00000000000000e2 <strlen>:
  e2:	1141                	addi	sp,sp,-16
  e4:	e422                	sd	s0,8(sp)
  e6:	0800                	addi	s0,sp,16
  e8:	00054783          	lbu	a5,0(a0)
  ec:	cf91                	beqz	a5,108 <strlen+0x26>
  ee:	0505                	addi	a0,a0,1
  f0:	87aa                	mv	a5,a0
  f2:	86be                	mv	a3,a5
  f4:	0785                	addi	a5,a5,1
  f6:	fff7c703          	lbu	a4,-1(a5)
  fa:	ff65                	bnez	a4,f2 <strlen+0x10>
  fc:	40a6853b          	subw	a0,a3,a0
 100:	2505                	addiw	a0,a0,1
 102:	6422                	ld	s0,8(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret
 108:	4501                	li	a0,0
 10a:	bfe5                	j	102 <strlen+0x20>

000000000000010c <memset>:
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
 112:	ca19                	beqz	a2,128 <memset+0x1c>
 114:	87aa                	mv	a5,a0
 116:	1602                	slli	a2,a2,0x20
 118:	9201                	srli	a2,a2,0x20
 11a:	00a60733          	add	a4,a2,a0
 11e:	00b78023          	sb	a1,0(a5)
 122:	0785                	addi	a5,a5,1
 124:	fee79de3          	bne	a5,a4,11e <memset+0x12>
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret

000000000000012e <strchr>:
 12e:	1141                	addi	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	addi	s0,sp,16
 134:	00054783          	lbu	a5,0(a0)
 138:	cb99                	beqz	a5,14e <strchr+0x20>
 13a:	00f58763          	beq	a1,a5,148 <strchr+0x1a>
 13e:	0505                	addi	a0,a0,1
 140:	00054783          	lbu	a5,0(a0)
 144:	fbfd                	bnez	a5,13a <strchr+0xc>
 146:	4501                	li	a0,0
 148:	6422                	ld	s0,8(sp)
 14a:	0141                	addi	sp,sp,16
 14c:	8082                	ret
 14e:	4501                	li	a0,0
 150:	bfe5                	j	148 <strchr+0x1a>

0000000000000152 <gets>:
 152:	711d                	addi	sp,sp,-96
 154:	ec86                	sd	ra,88(sp)
 156:	e8a2                	sd	s0,80(sp)
 158:	e4a6                	sd	s1,72(sp)
 15a:	e0ca                	sd	s2,64(sp)
 15c:	fc4e                	sd	s3,56(sp)
 15e:	f852                	sd	s4,48(sp)
 160:	f456                	sd	s5,40(sp)
 162:	f05a                	sd	s6,32(sp)
 164:	ec5e                	sd	s7,24(sp)
 166:	1080                	addi	s0,sp,96
 168:	8baa                	mv	s7,a0
 16a:	8a2e                	mv	s4,a1
 16c:	892a                	mv	s2,a0
 16e:	4481                	li	s1,0
 170:	4aa9                	li	s5,10
 172:	4b35                	li	s6,13
 174:	89a6                	mv	s3,s1
 176:	2485                	addiw	s1,s1,1
 178:	0344d663          	bge	s1,s4,1a4 <gets+0x52>
 17c:	4605                	li	a2,1
 17e:	faf40593          	addi	a1,s0,-81
 182:	4501                	li	a0,0
 184:	1b2000ef          	jal	336 <read>
 188:	00a05e63          	blez	a0,1a4 <gets+0x52>
 18c:	faf44783          	lbu	a5,-81(s0)
 190:	00f90023          	sb	a5,0(s2)
 194:	01578763          	beq	a5,s5,1a2 <gets+0x50>
 198:	0905                	addi	s2,s2,1
 19a:	fd679de3          	bne	a5,s6,174 <gets+0x22>
 19e:	89a6                	mv	s3,s1
 1a0:	a011                	j	1a4 <gets+0x52>
 1a2:	89a6                	mv	s3,s1
 1a4:	99de                	add	s3,s3,s7
 1a6:	00098023          	sb	zero,0(s3)
 1aa:	855e                	mv	a0,s7
 1ac:	60e6                	ld	ra,88(sp)
 1ae:	6446                	ld	s0,80(sp)
 1b0:	64a6                	ld	s1,72(sp)
 1b2:	6906                	ld	s2,64(sp)
 1b4:	79e2                	ld	s3,56(sp)
 1b6:	7a42                	ld	s4,48(sp)
 1b8:	7aa2                	ld	s5,40(sp)
 1ba:	7b02                	ld	s6,32(sp)
 1bc:	6be2                	ld	s7,24(sp)
 1be:	6125                	addi	sp,sp,96
 1c0:	8082                	ret

00000000000001c2 <stat>:
 1c2:	1101                	addi	sp,sp,-32
 1c4:	ec06                	sd	ra,24(sp)
 1c6:	e822                	sd	s0,16(sp)
 1c8:	e04a                	sd	s2,0(sp)
 1ca:	1000                	addi	s0,sp,32
 1cc:	892e                	mv	s2,a1
 1ce:	4581                	li	a1,0
 1d0:	18e000ef          	jal	35e <open>
 1d4:	02054263          	bltz	a0,1f8 <stat+0x36>
 1d8:	e426                	sd	s1,8(sp)
 1da:	84aa                	mv	s1,a0
 1dc:	85ca                	mv	a1,s2
 1de:	198000ef          	jal	376 <fstat>
 1e2:	892a                	mv	s2,a0
 1e4:	8526                	mv	a0,s1
 1e6:	160000ef          	jal	346 <close>
 1ea:	64a2                	ld	s1,8(sp)
 1ec:	854a                	mv	a0,s2
 1ee:	60e2                	ld	ra,24(sp)
 1f0:	6442                	ld	s0,16(sp)
 1f2:	6902                	ld	s2,0(sp)
 1f4:	6105                	addi	sp,sp,32
 1f6:	8082                	ret
 1f8:	597d                	li	s2,-1
 1fa:	bfcd                	j	1ec <stat+0x2a>

00000000000001fc <atoi>:
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e422                	sd	s0,8(sp)
 200:	0800                	addi	s0,sp,16
 202:	00054683          	lbu	a3,0(a0)
 206:	fd06879b          	addiw	a5,a3,-48
 20a:	0ff7f793          	zext.b	a5,a5
 20e:	4625                	li	a2,9
 210:	02f66863          	bltu	a2,a5,240 <atoi+0x44>
 214:	872a                	mv	a4,a0
 216:	4501                	li	a0,0
 218:	0705                	addi	a4,a4,1
 21a:	0025179b          	slliw	a5,a0,0x2
 21e:	9fa9                	addw	a5,a5,a0
 220:	0017979b          	slliw	a5,a5,0x1
 224:	9fb5                	addw	a5,a5,a3
 226:	fd07851b          	addiw	a0,a5,-48
 22a:	00074683          	lbu	a3,0(a4)
 22e:	fd06879b          	addiw	a5,a3,-48
 232:	0ff7f793          	zext.b	a5,a5
 236:	fef671e3          	bgeu	a2,a5,218 <atoi+0x1c>
 23a:	6422                	ld	s0,8(sp)
 23c:	0141                	addi	sp,sp,16
 23e:	8082                	ret
 240:	4501                	li	a0,0
 242:	bfe5                	j	23a <atoi+0x3e>

0000000000000244 <memmove>:
 244:	1141                	addi	sp,sp,-16
 246:	e422                	sd	s0,8(sp)
 248:	0800                	addi	s0,sp,16
 24a:	02b57463          	bgeu	a0,a1,272 <memmove+0x2e>
 24e:	00c05f63          	blez	a2,26c <memmove+0x28>
 252:	1602                	slli	a2,a2,0x20
 254:	9201                	srli	a2,a2,0x20
 256:	00c507b3          	add	a5,a0,a2
 25a:	872a                	mv	a4,a0
 25c:	0585                	addi	a1,a1,1
 25e:	0705                	addi	a4,a4,1
 260:	fff5c683          	lbu	a3,-1(a1)
 264:	fed70fa3          	sb	a3,-1(a4)
 268:	fef71ae3          	bne	a4,a5,25c <memmove+0x18>
 26c:	6422                	ld	s0,8(sp)
 26e:	0141                	addi	sp,sp,16
 270:	8082                	ret
 272:	00c50733          	add	a4,a0,a2
 276:	95b2                	add	a1,a1,a2
 278:	fec05ae3          	blez	a2,26c <memmove+0x28>
 27c:	fff6079b          	addiw	a5,a2,-1
 280:	1782                	slli	a5,a5,0x20
 282:	9381                	srli	a5,a5,0x20
 284:	fff7c793          	not	a5,a5
 288:	97ba                	add	a5,a5,a4
 28a:	15fd                	addi	a1,a1,-1
 28c:	177d                	addi	a4,a4,-1
 28e:	0005c683          	lbu	a3,0(a1)
 292:	00d70023          	sb	a3,0(a4)
 296:	fee79ae3          	bne	a5,a4,28a <memmove+0x46>
 29a:	bfc9                	j	26c <memmove+0x28>

000000000000029c <memcmp>:
 29c:	1141                	addi	sp,sp,-16
 29e:	e422                	sd	s0,8(sp)
 2a0:	0800                	addi	s0,sp,16
 2a2:	ca05                	beqz	a2,2d2 <memcmp+0x36>
 2a4:	fff6069b          	addiw	a3,a2,-1
 2a8:	1682                	slli	a3,a3,0x20
 2aa:	9281                	srli	a3,a3,0x20
 2ac:	0685                	addi	a3,a3,1
 2ae:	96aa                	add	a3,a3,a0
 2b0:	00054783          	lbu	a5,0(a0)
 2b4:	0005c703          	lbu	a4,0(a1)
 2b8:	00e79863          	bne	a5,a4,2c8 <memcmp+0x2c>
 2bc:	0505                	addi	a0,a0,1
 2be:	0585                	addi	a1,a1,1
 2c0:	fed518e3          	bne	a0,a3,2b0 <memcmp+0x14>
 2c4:	4501                	li	a0,0
 2c6:	a019                	j	2cc <memcmp+0x30>
 2c8:	40e7853b          	subw	a0,a5,a4
 2cc:	6422                	ld	s0,8(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret
 2d2:	4501                	li	a0,0
 2d4:	bfe5                	j	2cc <memcmp+0x30>

00000000000002d6 <memcpy>:
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e406                	sd	ra,8(sp)
 2da:	e022                	sd	s0,0(sp)
 2dc:	0800                	addi	s0,sp,16
 2de:	f67ff0ef          	jal	244 <memmove>
 2e2:	60a2                	ld	ra,8(sp)
 2e4:	6402                	ld	s0,0(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <sbrk>:
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
 2f2:	4585                	li	a1,1
 2f4:	0b2000ef          	jal	3a6 <sys_sbrk>
 2f8:	60a2                	ld	ra,8(sp)
 2fa:	6402                	ld	s0,0(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <sbrklazy>:
 300:	1141                	addi	sp,sp,-16
 302:	e406                	sd	ra,8(sp)
 304:	e022                	sd	s0,0(sp)
 306:	0800                	addi	s0,sp,16
 308:	4589                	li	a1,2
 30a:	09c000ef          	jal	3a6 <sys_sbrk>
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret

0000000000000316 <fork>:
 316:	4885                	li	a7,1
 318:	00000073          	ecall
 31c:	8082                	ret

000000000000031e <exit>:
 31e:	4889                	li	a7,2
 320:	00000073          	ecall
 324:	8082                	ret

0000000000000326 <wait>:
 326:	488d                	li	a7,3
 328:	00000073          	ecall
 32c:	8082                	ret

000000000000032e <pipe>:
 32e:	4891                	li	a7,4
 330:	00000073          	ecall
 334:	8082                	ret

0000000000000336 <read>:
 336:	4895                	li	a7,5
 338:	00000073          	ecall
 33c:	8082                	ret

000000000000033e <write>:
 33e:	48c1                	li	a7,16
 340:	00000073          	ecall
 344:	8082                	ret

0000000000000346 <close>:
 346:	48d5                	li	a7,21
 348:	00000073          	ecall
 34c:	8082                	ret

000000000000034e <kill>:
 34e:	4899                	li	a7,6
 350:	00000073          	ecall
 354:	8082                	ret

0000000000000356 <exec>:
 356:	489d                	li	a7,7
 358:	00000073          	ecall
 35c:	8082                	ret

000000000000035e <open>:
 35e:	48bd                	li	a7,15
 360:	00000073          	ecall
 364:	8082                	ret

0000000000000366 <mknod>:
 366:	48c5                	li	a7,17
 368:	00000073          	ecall
 36c:	8082                	ret

000000000000036e <unlink>:
 36e:	48c9                	li	a7,18
 370:	00000073          	ecall
 374:	8082                	ret

0000000000000376 <fstat>:
 376:	48a1                	li	a7,8
 378:	00000073          	ecall
 37c:	8082                	ret

000000000000037e <link>:
 37e:	48cd                	li	a7,19
 380:	00000073          	ecall
 384:	8082                	ret

0000000000000386 <mkdir>:
 386:	48d1                	li	a7,20
 388:	00000073          	ecall
 38c:	8082                	ret

000000000000038e <chdir>:
 38e:	48a5                	li	a7,9
 390:	00000073          	ecall
 394:	8082                	ret

0000000000000396 <dup>:
 396:	48a9                	li	a7,10
 398:	00000073          	ecall
 39c:	8082                	ret

000000000000039e <getpid>:
 39e:	48ad                	li	a7,11
 3a0:	00000073          	ecall
 3a4:	8082                	ret

00000000000003a6 <sys_sbrk>:
 3a6:	48b1                	li	a7,12
 3a8:	00000073          	ecall
 3ac:	8082                	ret

00000000000003ae <pause>:
 3ae:	48b5                	li	a7,13
 3b0:	00000073          	ecall
 3b4:	8082                	ret

00000000000003b6 <uptime>:
 3b6:	48b9                	li	a7,14
 3b8:	00000073          	ecall
 3bc:	8082                	ret

00000000000003be <sync>:
 3be:	48d9                	li	a7,22
 3c0:	00000073          	ecall
 3c4:	8082                	ret

00000000000003c6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3c6:	1101                	addi	sp,sp,-32
 3c8:	ec06                	sd	ra,24(sp)
 3ca:	e822                	sd	s0,16(sp)
 3cc:	1000                	addi	s0,sp,32
 3ce:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3d2:	4605                	li	a2,1
 3d4:	fef40593          	addi	a1,s0,-17
 3d8:	f67ff0ef          	jal	33e <write>
}
 3dc:	60e2                	ld	ra,24(sp)
 3de:	6442                	ld	s0,16(sp)
 3e0:	6105                	addi	sp,sp,32
 3e2:	8082                	ret

00000000000003e4 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3e4:	715d                	addi	sp,sp,-80
 3e6:	e486                	sd	ra,72(sp)
 3e8:	e0a2                	sd	s0,64(sp)
 3ea:	f84a                	sd	s2,48(sp)
 3ec:	0880                	addi	s0,sp,80
 3ee:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 3f0:	c299                	beqz	a3,3f6 <printint+0x12>
 3f2:	0805c363          	bltz	a1,478 <printint+0x94>
  neg = 0;
 3f6:	4881                	li	a7,0
 3f8:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3fc:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
 3fe:	00000517          	auipc	a0,0x0
 402:	58250513          	addi	a0,a0,1410 # 980 <digits>
 406:	883e                	mv	a6,a5
 408:	2785                	addiw	a5,a5,1
 40a:	02c5f733          	remu	a4,a1,a2
 40e:	972a                	add	a4,a4,a0
 410:	00074703          	lbu	a4,0(a4)
 414:	00e68023          	sb	a4,0(a3)
  } while ((x /= base) != 0);
 418:	872e                	mv	a4,a1
 41a:	02c5d5b3          	divu	a1,a1,a2
 41e:	0685                	addi	a3,a3,1
 420:	fec773e3          	bgeu	a4,a2,406 <printint+0x22>
  if (neg)
 424:	00088b63          	beqz	a7,43a <printint+0x56>
    buf[i++] = '-';
 428:	fd078793          	addi	a5,a5,-48
 42c:	97a2                	add	a5,a5,s0
 42e:	02d00713          	li	a4,45
 432:	fee78423          	sb	a4,-24(a5)
 436:	0028079b          	addiw	a5,a6,2

  while (--i >= 0)
 43a:	02f05a63          	blez	a5,46e <printint+0x8a>
 43e:	fc26                	sd	s1,56(sp)
 440:	f44e                	sd	s3,40(sp)
 442:	fb840713          	addi	a4,s0,-72
 446:	00f704b3          	add	s1,a4,a5
 44a:	fff70993          	addi	s3,a4,-1
 44e:	99be                	add	s3,s3,a5
 450:	37fd                	addiw	a5,a5,-1
 452:	1782                	slli	a5,a5,0x20
 454:	9381                	srli	a5,a5,0x20
 456:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 45a:	fff4c583          	lbu	a1,-1(s1)
 45e:	854a                	mv	a0,s2
 460:	f67ff0ef          	jal	3c6 <putc>
  while (--i >= 0)
 464:	14fd                	addi	s1,s1,-1
 466:	ff349ae3          	bne	s1,s3,45a <printint+0x76>
 46a:	74e2                	ld	s1,56(sp)
 46c:	79a2                	ld	s3,40(sp)
}
 46e:	60a6                	ld	ra,72(sp)
 470:	6406                	ld	s0,64(sp)
 472:	7942                	ld	s2,48(sp)
 474:	6161                	addi	sp,sp,80
 476:	8082                	ret
    x = -xx;
 478:	40b005b3          	neg	a1,a1
    neg = 1;
 47c:	4885                	li	a7,1
    x = -xx;
 47e:	bfad                	j	3f8 <printint+0x14>

0000000000000480 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 480:	711d                	addi	sp,sp,-96
 482:	ec86                	sd	ra,88(sp)
 484:	e8a2                	sd	s0,80(sp)
 486:	e0ca                	sd	s2,64(sp)
 488:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 48a:	0005c903          	lbu	s2,0(a1)
 48e:	28090663          	beqz	s2,71a <vprintf+0x29a>
 492:	e4a6                	sd	s1,72(sp)
 494:	fc4e                	sd	s3,56(sp)
 496:	f852                	sd	s4,48(sp)
 498:	f456                	sd	s5,40(sp)
 49a:	f05a                	sd	s6,32(sp)
 49c:	ec5e                	sd	s7,24(sp)
 49e:	e862                	sd	s8,16(sp)
 4a0:	e466                	sd	s9,8(sp)
 4a2:	8b2a                	mv	s6,a0
 4a4:	8a2e                	mv	s4,a1
 4a6:	8bb2                	mv	s7,a2
  state = 0;
 4a8:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 4aa:	4481                	li	s1,0
 4ac:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 4ae:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 4b2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 4b6:	06c00c93          	li	s9,108
 4ba:	a005                	j	4da <vprintf+0x5a>
        putc(fd, c0);
 4bc:	85ca                	mv	a1,s2
 4be:	855a                	mv	a0,s6
 4c0:	f07ff0ef          	jal	3c6 <putc>
 4c4:	a019                	j	4ca <vprintf+0x4a>
    } else if (state == '%') {
 4c6:	03598263          	beq	s3,s5,4ea <vprintf+0x6a>
  for (i = 0; fmt[i]; i++) {
 4ca:	2485                	addiw	s1,s1,1
 4cc:	8726                	mv	a4,s1
 4ce:	009a07b3          	add	a5,s4,s1
 4d2:	0007c903          	lbu	s2,0(a5)
 4d6:	22090a63          	beqz	s2,70a <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 4da:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 4de:	fe0994e3          	bnez	s3,4c6 <vprintf+0x46>
      if (c0 == '%') {
 4e2:	fd579de3          	bne	a5,s5,4bc <vprintf+0x3c>
        state = '%';
 4e6:	89be                	mv	s3,a5
 4e8:	b7cd                	j	4ca <vprintf+0x4a>
        c1 = fmt[i + 1] & 0xff;
 4ea:	00ea06b3          	add	a3,s4,a4
 4ee:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4f2:	8636                	mv	a2,a3
      if (c1)
 4f4:	c681                	beqz	a3,4fc <vprintf+0x7c>
        c2 = fmt[i + 2] & 0xff;
 4f6:	9752                	add	a4,a4,s4
 4f8:	00274603          	lbu	a2,2(a4)
      if (c0 == 'd') {
 4fc:	05878363          	beq	a5,s8,542 <vprintf+0xc2>
      } else if (c0 == 'l' && c1 == 'd') {
 500:	05978d63          	beq	a5,s9,55a <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 504:	07500713          	li	a4,117
 508:	0ee78763          	beq	a5,a4,5f6 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 50c:	07800713          	li	a4,120
 510:	12e78963          	beq	a5,a4,642 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 514:	07000713          	li	a4,112
 518:	14e78e63          	beq	a5,a4,674 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 51c:	06300713          	li	a4,99
 520:	18e78e63          	beq	a5,a4,6bc <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 524:	07300713          	li	a4,115
 528:	1ae78463          	beq	a5,a4,6d0 <vprintf+0x250>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 52c:	02500713          	li	a4,37
 530:	04e79563          	bne	a5,a4,57a <vprintf+0xfa>
        putc(fd, '%');
 534:	02500593          	li	a1,37
 538:	855a                	mv	a0,s6
 53a:	e8dff0ef          	jal	3c6 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 53e:	4981                	li	s3,0
 540:	b769                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 542:	008b8913          	addi	s2,s7,8
 546:	4685                	li	a3,1
 548:	4629                	li	a2,10
 54a:	000ba583          	lw	a1,0(s7)
 54e:	855a                	mv	a0,s6
 550:	e95ff0ef          	jal	3e4 <printint>
 554:	8bca                	mv	s7,s2
      state = 0;
 556:	4981                	li	s3,0
 558:	bf8d                	j	4ca <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'd') {
 55a:	06400793          	li	a5,100
 55e:	02f68963          	beq	a3,a5,590 <vprintf+0x110>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 562:	06c00793          	li	a5,108
 566:	04f68263          	beq	a3,a5,5aa <vprintf+0x12a>
      } else if (c0 == 'l' && c1 == 'u') {
 56a:	07500793          	li	a5,117
 56e:	0af68063          	beq	a3,a5,60e <vprintf+0x18e>
      } else if (c0 == 'l' && c1 == 'x') {
 572:	07800793          	li	a5,120
 576:	0ef68263          	beq	a3,a5,65a <vprintf+0x1da>
        putc(fd, '%');
 57a:	02500593          	li	a1,37
 57e:	855a                	mv	a0,s6
 580:	e47ff0ef          	jal	3c6 <putc>
        putc(fd, c0);
 584:	85ca                	mv	a1,s2
 586:	855a                	mv	a0,s6
 588:	e3fff0ef          	jal	3c6 <putc>
      state = 0;
 58c:	4981                	li	s3,0
 58e:	bf35                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 590:	008b8913          	addi	s2,s7,8
 594:	4685                	li	a3,1
 596:	4629                	li	a2,10
 598:	000bb583          	ld	a1,0(s7)
 59c:	855a                	mv	a0,s6
 59e:	e47ff0ef          	jal	3e4 <printint>
        i += 1;
 5a2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5a4:	8bca                	mv	s7,s2
      state = 0;
 5a6:	4981                	li	s3,0
        i += 1;
 5a8:	b70d                	j	4ca <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 5aa:	06400793          	li	a5,100
 5ae:	02f60763          	beq	a2,a5,5dc <vprintf+0x15c>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 5b2:	07500793          	li	a5,117
 5b6:	06f60963          	beq	a2,a5,628 <vprintf+0x1a8>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 5ba:	07800793          	li	a5,120
 5be:	faf61ee3          	bne	a2,a5,57a <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5c2:	008b8913          	addi	s2,s7,8
 5c6:	4681                	li	a3,0
 5c8:	4641                	li	a2,16
 5ca:	000bb583          	ld	a1,0(s7)
 5ce:	855a                	mv	a0,s6
 5d0:	e15ff0ef          	jal	3e4 <printint>
        i += 2;
 5d4:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5d6:	8bca                	mv	s7,s2
      state = 0;
 5d8:	4981                	li	s3,0
        i += 2;
 5da:	bdc5                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5dc:	008b8913          	addi	s2,s7,8
 5e0:	4685                	li	a3,1
 5e2:	4629                	li	a2,10
 5e4:	000bb583          	ld	a1,0(s7)
 5e8:	855a                	mv	a0,s6
 5ea:	dfbff0ef          	jal	3e4 <printint>
        i += 2;
 5ee:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5f0:	8bca                	mv	s7,s2
      state = 0;
 5f2:	4981                	li	s3,0
        i += 2;
 5f4:	bdd9                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5f6:	008b8913          	addi	s2,s7,8
 5fa:	4681                	li	a3,0
 5fc:	4629                	li	a2,10
 5fe:	000be583          	lwu	a1,0(s7)
 602:	855a                	mv	a0,s6
 604:	de1ff0ef          	jal	3e4 <printint>
 608:	8bca                	mv	s7,s2
      state = 0;
 60a:	4981                	li	s3,0
 60c:	bd7d                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 60e:	008b8913          	addi	s2,s7,8
 612:	4681                	li	a3,0
 614:	4629                	li	a2,10
 616:	000bb583          	ld	a1,0(s7)
 61a:	855a                	mv	a0,s6
 61c:	dc9ff0ef          	jal	3e4 <printint>
        i += 1;
 620:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 622:	8bca                	mv	s7,s2
      state = 0;
 624:	4981                	li	s3,0
        i += 1;
 626:	b555                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 628:	008b8913          	addi	s2,s7,8
 62c:	4681                	li	a3,0
 62e:	4629                	li	a2,10
 630:	000bb583          	ld	a1,0(s7)
 634:	855a                	mv	a0,s6
 636:	dafff0ef          	jal	3e4 <printint>
        i += 2;
 63a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 63c:	8bca                	mv	s7,s2
      state = 0;
 63e:	4981                	li	s3,0
        i += 2;
 640:	b569                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 642:	008b8913          	addi	s2,s7,8
 646:	4681                	li	a3,0
 648:	4641                	li	a2,16
 64a:	000be583          	lwu	a1,0(s7)
 64e:	855a                	mv	a0,s6
 650:	d95ff0ef          	jal	3e4 <printint>
 654:	8bca                	mv	s7,s2
      state = 0;
 656:	4981                	li	s3,0
 658:	bd8d                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 65a:	008b8913          	addi	s2,s7,8
 65e:	4681                	li	a3,0
 660:	4641                	li	a2,16
 662:	000bb583          	ld	a1,0(s7)
 666:	855a                	mv	a0,s6
 668:	d7dff0ef          	jal	3e4 <printint>
        i += 1;
 66c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 66e:	8bca                	mv	s7,s2
      state = 0;
 670:	4981                	li	s3,0
        i += 1;
 672:	bda1                	j	4ca <vprintf+0x4a>
 674:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 676:	008b8d13          	addi	s10,s7,8
 67a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 67e:	03000593          	li	a1,48
 682:	855a                	mv	a0,s6
 684:	d43ff0ef          	jal	3c6 <putc>
  putc(fd, 'x');
 688:	07800593          	li	a1,120
 68c:	855a                	mv	a0,s6
 68e:	d39ff0ef          	jal	3c6 <putc>
 692:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 694:	00000b97          	auipc	s7,0x0
 698:	2ecb8b93          	addi	s7,s7,748 # 980 <digits>
 69c:	03c9d793          	srli	a5,s3,0x3c
 6a0:	97de                	add	a5,a5,s7
 6a2:	0007c583          	lbu	a1,0(a5)
 6a6:	855a                	mv	a0,s6
 6a8:	d1fff0ef          	jal	3c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ac:	0992                	slli	s3,s3,0x4
 6ae:	397d                	addiw	s2,s2,-1
 6b0:	fe0916e3          	bnez	s2,69c <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 6b4:	8bea                	mv	s7,s10
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	6d02                	ld	s10,0(sp)
 6ba:	bd01                	j	4ca <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 6bc:	008b8913          	addi	s2,s7,8
 6c0:	000bc583          	lbu	a1,0(s7)
 6c4:	855a                	mv	a0,s6
 6c6:	d01ff0ef          	jal	3c6 <putc>
 6ca:	8bca                	mv	s7,s2
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	bbf5                	j	4ca <vprintf+0x4a>
        if ((s = va_arg(ap, char *)) == 0)
 6d0:	008b8993          	addi	s3,s7,8
 6d4:	000bb903          	ld	s2,0(s7)
 6d8:	00090f63          	beqz	s2,6f6 <vprintf+0x276>
        for (; *s; s++)
 6dc:	00094583          	lbu	a1,0(s2)
 6e0:	c195                	beqz	a1,704 <vprintf+0x284>
          putc(fd, *s);
 6e2:	855a                	mv	a0,s6
 6e4:	ce3ff0ef          	jal	3c6 <putc>
        for (; *s; s++)
 6e8:	0905                	addi	s2,s2,1
 6ea:	00094583          	lbu	a1,0(s2)
 6ee:	f9f5                	bnez	a1,6e2 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 6f0:	8bce                	mv	s7,s3
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	bbd9                	j	4ca <vprintf+0x4a>
          s = "(null)";
 6f6:	00000917          	auipc	s2,0x0
 6fa:	28290913          	addi	s2,s2,642 # 978 <malloc+0x176>
        for (; *s; s++)
 6fe:	02800593          	li	a1,40
 702:	b7c5                	j	6e2 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 704:	8bce                	mv	s7,s3
      state = 0;
 706:	4981                	li	s3,0
 708:	b3c9                	j	4ca <vprintf+0x4a>
 70a:	64a6                	ld	s1,72(sp)
 70c:	79e2                	ld	s3,56(sp)
 70e:	7a42                	ld	s4,48(sp)
 710:	7aa2                	ld	s5,40(sp)
 712:	7b02                	ld	s6,32(sp)
 714:	6be2                	ld	s7,24(sp)
 716:	6c42                	ld	s8,16(sp)
 718:	6ca2                	ld	s9,8(sp)
    }
  }
}
 71a:	60e6                	ld	ra,88(sp)
 71c:	6446                	ld	s0,80(sp)
 71e:	6906                	ld	s2,64(sp)
 720:	6125                	addi	sp,sp,96
 722:	8082                	ret

0000000000000724 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 724:	715d                	addi	sp,sp,-80
 726:	ec06                	sd	ra,24(sp)
 728:	e822                	sd	s0,16(sp)
 72a:	1000                	addi	s0,sp,32
 72c:	e010                	sd	a2,0(s0)
 72e:	e414                	sd	a3,8(s0)
 730:	e818                	sd	a4,16(s0)
 732:	ec1c                	sd	a5,24(s0)
 734:	03043023          	sd	a6,32(s0)
 738:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 73c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 740:	8622                	mv	a2,s0
 742:	d3fff0ef          	jal	480 <vprintf>
}
 746:	60e2                	ld	ra,24(sp)
 748:	6442                	ld	s0,16(sp)
 74a:	6161                	addi	sp,sp,80
 74c:	8082                	ret

000000000000074e <printf>:

void
printf(const char *fmt, ...)
{
 74e:	711d                	addi	sp,sp,-96
 750:	ec06                	sd	ra,24(sp)
 752:	e822                	sd	s0,16(sp)
 754:	1000                	addi	s0,sp,32
 756:	e40c                	sd	a1,8(s0)
 758:	e810                	sd	a2,16(s0)
 75a:	ec14                	sd	a3,24(s0)
 75c:	f018                	sd	a4,32(s0)
 75e:	f41c                	sd	a5,40(s0)
 760:	03043823          	sd	a6,48(s0)
 764:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 768:	00840613          	addi	a2,s0,8
 76c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 770:	85aa                	mv	a1,a0
 772:	4505                	li	a0,1
 774:	d0dff0ef          	jal	480 <vprintf>
}
 778:	60e2                	ld	ra,24(sp)
 77a:	6442                	ld	s0,16(sp)
 77c:	6125                	addi	sp,sp,96
 77e:	8082                	ret

0000000000000780 <free>:
 780:	1141                	addi	sp,sp,-16
 782:	e422                	sd	s0,8(sp)
 784:	0800                	addi	s0,sp,16
 786:	ff050693          	addi	a3,a0,-16
 78a:	00001797          	auipc	a5,0x1
 78e:	8767b783          	ld	a5,-1930(a5) # 1000 <freep>
 792:	a02d                	j	7bc <free+0x3c>
 794:	4618                	lw	a4,8(a2)
 796:	9f2d                	addw	a4,a4,a1
 798:	fee52c23          	sw	a4,-8(a0)
 79c:	6398                	ld	a4,0(a5)
 79e:	6310                	ld	a2,0(a4)
 7a0:	a83d                	j	7de <free+0x5e>
 7a2:	ff852703          	lw	a4,-8(a0)
 7a6:	9f31                	addw	a4,a4,a2
 7a8:	c798                	sw	a4,8(a5)
 7aa:	ff053683          	ld	a3,-16(a0)
 7ae:	a091                	j	7f2 <free+0x72>
 7b0:	6398                	ld	a4,0(a5)
 7b2:	00e7e463          	bltu	a5,a4,7ba <free+0x3a>
 7b6:	00e6ea63          	bltu	a3,a4,7ca <free+0x4a>
 7ba:	87ba                	mv	a5,a4
 7bc:	fed7fae3          	bgeu	a5,a3,7b0 <free+0x30>
 7c0:	6398                	ld	a4,0(a5)
 7c2:	00e6e463          	bltu	a3,a4,7ca <free+0x4a>
 7c6:	fee7eae3          	bltu	a5,a4,7ba <free+0x3a>
 7ca:	ff852583          	lw	a1,-8(a0)
 7ce:	6390                	ld	a2,0(a5)
 7d0:	02059813          	slli	a6,a1,0x20
 7d4:	01c85713          	srli	a4,a6,0x1c
 7d8:	9736                	add	a4,a4,a3
 7da:	fae60de3          	beq	a2,a4,794 <free+0x14>
 7de:	fec53823          	sd	a2,-16(a0)
 7e2:	4790                	lw	a2,8(a5)
 7e4:	02061593          	slli	a1,a2,0x20
 7e8:	01c5d713          	srli	a4,a1,0x1c
 7ec:	973e                	add	a4,a4,a5
 7ee:	fae68ae3          	beq	a3,a4,7a2 <free+0x22>
 7f2:	e394                	sd	a3,0(a5)
 7f4:	00001717          	auipc	a4,0x1
 7f8:	80f73623          	sd	a5,-2036(a4) # 1000 <freep>
 7fc:	6422                	ld	s0,8(sp)
 7fe:	0141                	addi	sp,sp,16
 800:	8082                	ret

0000000000000802 <malloc>:
 802:	7139                	addi	sp,sp,-64
 804:	fc06                	sd	ra,56(sp)
 806:	f822                	sd	s0,48(sp)
 808:	f426                	sd	s1,40(sp)
 80a:	ec4e                	sd	s3,24(sp)
 80c:	0080                	addi	s0,sp,64
 80e:	02051493          	slli	s1,a0,0x20
 812:	9081                	srli	s1,s1,0x20
 814:	04bd                	addi	s1,s1,15
 816:	8091                	srli	s1,s1,0x4
 818:	0014899b          	addiw	s3,s1,1
 81c:	0485                	addi	s1,s1,1
 81e:	00000517          	auipc	a0,0x0
 822:	7e253503          	ld	a0,2018(a0) # 1000 <freep>
 826:	c915                	beqz	a0,85a <malloc+0x58>
 828:	611c                	ld	a5,0(a0)
 82a:	4798                	lw	a4,8(a5)
 82c:	08977a63          	bgeu	a4,s1,8c0 <malloc+0xbe>
 830:	f04a                	sd	s2,32(sp)
 832:	e852                	sd	s4,16(sp)
 834:	e456                	sd	s5,8(sp)
 836:	e05a                	sd	s6,0(sp)
 838:	8a4e                	mv	s4,s3
 83a:	0009871b          	sext.w	a4,s3
 83e:	6685                	lui	a3,0x1
 840:	00d77363          	bgeu	a4,a3,846 <malloc+0x44>
 844:	6a05                	lui	s4,0x1
 846:	000a0b1b          	sext.w	s6,s4
 84a:	004a1a1b          	slliw	s4,s4,0x4
 84e:	00000917          	auipc	s2,0x0
 852:	7b290913          	addi	s2,s2,1970 # 1000 <freep>
 856:	5afd                	li	s5,-1
 858:	a081                	j	898 <malloc+0x96>
 85a:	f04a                	sd	s2,32(sp)
 85c:	e852                	sd	s4,16(sp)
 85e:	e456                	sd	s5,8(sp)
 860:	e05a                	sd	s6,0(sp)
 862:	00001797          	auipc	a5,0x1
 866:	9a678793          	addi	a5,a5,-1626 # 1208 <base>
 86a:	00000717          	auipc	a4,0x0
 86e:	78f73b23          	sd	a5,1942(a4) # 1000 <freep>
 872:	e39c                	sd	a5,0(a5)
 874:	0007a423          	sw	zero,8(a5)
 878:	b7c1                	j	838 <malloc+0x36>
 87a:	6398                	ld	a4,0(a5)
 87c:	e118                	sd	a4,0(a0)
 87e:	a8a9                	j	8d8 <malloc+0xd6>
 880:	01652423          	sw	s6,8(a0)
 884:	0541                	addi	a0,a0,16
 886:	efbff0ef          	jal	780 <free>
 88a:	00093503          	ld	a0,0(s2)
 88e:	c12d                	beqz	a0,8f0 <malloc+0xee>
 890:	611c                	ld	a5,0(a0)
 892:	4798                	lw	a4,8(a5)
 894:	02977263          	bgeu	a4,s1,8b8 <malloc+0xb6>
 898:	00093703          	ld	a4,0(s2)
 89c:	853e                	mv	a0,a5
 89e:	fef719e3          	bne	a4,a5,890 <malloc+0x8e>
 8a2:	8552                	mv	a0,s4
 8a4:	a47ff0ef          	jal	2ea <sbrk>
 8a8:	fd551ce3          	bne	a0,s5,880 <malloc+0x7e>
 8ac:	4501                	li	a0,0
 8ae:	7902                	ld	s2,32(sp)
 8b0:	6a42                	ld	s4,16(sp)
 8b2:	6aa2                	ld	s5,8(sp)
 8b4:	6b02                	ld	s6,0(sp)
 8b6:	a03d                	j	8e4 <malloc+0xe2>
 8b8:	7902                	ld	s2,32(sp)
 8ba:	6a42                	ld	s4,16(sp)
 8bc:	6aa2                	ld	s5,8(sp)
 8be:	6b02                	ld	s6,0(sp)
 8c0:	fae48de3          	beq	s1,a4,87a <malloc+0x78>
 8c4:	4137073b          	subw	a4,a4,s3
 8c8:	c798                	sw	a4,8(a5)
 8ca:	02071693          	slli	a3,a4,0x20
 8ce:	01c6d713          	srli	a4,a3,0x1c
 8d2:	97ba                	add	a5,a5,a4
 8d4:	0137a423          	sw	s3,8(a5)
 8d8:	00000717          	auipc	a4,0x0
 8dc:	72a73423          	sd	a0,1832(a4) # 1000 <freep>
 8e0:	01078513          	addi	a0,a5,16
 8e4:	70e2                	ld	ra,56(sp)
 8e6:	7442                	ld	s0,48(sp)
 8e8:	74a2                	ld	s1,40(sp)
 8ea:	69e2                	ld	s3,24(sp)
 8ec:	6121                	addi	sp,sp,64
 8ee:	8082                	ret
 8f0:	7902                	ld	s2,32(sp)
 8f2:	6a42                	ld	s4,16(sp)
 8f4:	6aa2                	ld	s5,8(sp)
 8f6:	6b02                	ld	s6,0(sp)
 8f8:	b7f5                	j	8e4 <malloc+0xe2>
