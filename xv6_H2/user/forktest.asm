
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N 1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	122000ef          	jal	12e <strlen>
  10:	0005061b          	sext.w	a2,a0
  14:	85a6                	mv	a1,s1
  16:	4505                	li	a0,1
  18:	372000ef          	jal	38a <write>
}
  1c:	60e2                	ld	ra,24(sp)
  1e:	6442                	ld	s0,16(sp)
  20:	64a2                	ld	s1,8(sp)
  22:	6105                	addi	sp,sp,32
  24:	8082                	ret

0000000000000026 <forktest>:

void
forktest(void)
{
  26:	1101                	addi	sp,sp,-32
  28:	ec06                	sd	ra,24(sp)
  2a:	e822                	sd	s0,16(sp)
  2c:	e426                	sd	s1,8(sp)
  2e:	e04a                	sd	s2,0(sp)
  30:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  32:	00000517          	auipc	a0,0x0
  36:	3e650513          	addi	a0,a0,998 # 418 <sync+0xe>
  3a:	fc7ff0ef          	jal	0 <print>

  for (n = 0; n < N; n++) {
  3e:	4481                	li	s1,0
  40:	3e800913          	li	s2,1000
    pid = fork();
  44:	31e000ef          	jal	362 <fork>
    if (pid < 0)
  48:	04054363          	bltz	a0,8e <forktest+0x68>
      break;
    if (pid == 0)
  4c:	cd09                	beqz	a0,66 <forktest+0x40>
  for (n = 0; n < N; n++) {
  4e:	2485                	addiw	s1,s1,1
  50:	ff249ae3          	bne	s1,s2,44 <forktest+0x1e>
      exit(0);
  }

  if (n == N) {
    print("fork claimed to work N times!\n");
  54:	00000517          	auipc	a0,0x0
  58:	41450513          	addi	a0,a0,1044 # 468 <sync+0x5e>
  5c:	fa5ff0ef          	jal	0 <print>
    exit(1);
  60:	4505                	li	a0,1
  62:	308000ef          	jal	36a <exit>
      exit(0);
  66:	304000ef          	jal	36a <exit>
  }

  for (; n > 0; n--) {
    if (wait(0) < 0) {
      print("wait stopped early\n");
  6a:	00000517          	auipc	a0,0x0
  6e:	3be50513          	addi	a0,a0,958 # 428 <sync+0x1e>
  72:	f8fff0ef          	jal	0 <print>
      exit(1);
  76:	4505                	li	a0,1
  78:	2f2000ef          	jal	36a <exit>
    }
  }

  if (wait(0) != -1) {
    print("wait got too many\n");
  7c:	00000517          	auipc	a0,0x0
  80:	3c450513          	addi	a0,a0,964 # 440 <sync+0x36>
  84:	f7dff0ef          	jal	0 <print>
    exit(1);
  88:	4505                	li	a0,1
  8a:	2e0000ef          	jal	36a <exit>
  for (; n > 0; n--) {
  8e:	00905963          	blez	s1,a0 <forktest+0x7a>
    if (wait(0) < 0) {
  92:	4501                	li	a0,0
  94:	2de000ef          	jal	372 <wait>
  98:	fc0549e3          	bltz	a0,6a <forktest+0x44>
  for (; n > 0; n--) {
  9c:	34fd                	addiw	s1,s1,-1
  9e:	f8f5                	bnez	s1,92 <forktest+0x6c>
  if (wait(0) != -1) {
  a0:	4501                	li	a0,0
  a2:	2d0000ef          	jal	372 <wait>
  a6:	57fd                	li	a5,-1
  a8:	fcf51ae3          	bne	a0,a5,7c <forktest+0x56>
  }

  print("fork test OK\n");
  ac:	00000517          	auipc	a0,0x0
  b0:	3ac50513          	addi	a0,a0,940 # 458 <sync+0x4e>
  b4:	f4dff0ef          	jal	0 <print>
}
  b8:	60e2                	ld	ra,24(sp)
  ba:	6442                	ld	s0,16(sp)
  bc:	64a2                	ld	s1,8(sp)
  be:	6902                	ld	s2,0(sp)
  c0:	6105                	addi	sp,sp,32
  c2:	8082                	ret

00000000000000c4 <main>:

int
main(void)
{
  c4:	1141                	addi	sp,sp,-16
  c6:	e406                	sd	ra,8(sp)
  c8:	e022                	sd	s0,0(sp)
  ca:	0800                	addi	s0,sp,16
  forktest();
  cc:	f5bff0ef          	jal	26 <forktest>
  exit(0);
  d0:	4501                	li	a0,0
  d2:	298000ef          	jal	36a <exit>

00000000000000d6 <start>:
  d6:	1141                	addi	sp,sp,-16
  d8:	e406                	sd	ra,8(sp)
  da:	e022                	sd	s0,0(sp)
  dc:	0800                	addi	s0,sp,16
  de:	fe7ff0ef          	jal	c4 <main>
  e2:	288000ef          	jal	36a <exit>

00000000000000e6 <strcpy>:
  e6:	1141                	addi	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	addi	s0,sp,16
  ec:	87aa                	mv	a5,a0
  ee:	0585                	addi	a1,a1,1
  f0:	0785                	addi	a5,a5,1
  f2:	fff5c703          	lbu	a4,-1(a1)
  f6:	fee78fa3          	sb	a4,-1(a5)
  fa:	fb75                	bnez	a4,ee <strcpy+0x8>
  fc:	6422                	ld	s0,8(sp)
  fe:	0141                	addi	sp,sp,16
 100:	8082                	ret

0000000000000102 <strcmp>:
 102:	1141                	addi	sp,sp,-16
 104:	e422                	sd	s0,8(sp)
 106:	0800                	addi	s0,sp,16
 108:	00054783          	lbu	a5,0(a0)
 10c:	cb91                	beqz	a5,120 <strcmp+0x1e>
 10e:	0005c703          	lbu	a4,0(a1)
 112:	00f71763          	bne	a4,a5,120 <strcmp+0x1e>
 116:	0505                	addi	a0,a0,1
 118:	0585                	addi	a1,a1,1
 11a:	00054783          	lbu	a5,0(a0)
 11e:	fbe5                	bnez	a5,10e <strcmp+0xc>
 120:	0005c503          	lbu	a0,0(a1)
 124:	40a7853b          	subw	a0,a5,a0
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret

000000000000012e <strlen>:
 12e:	1141                	addi	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	addi	s0,sp,16
 134:	00054783          	lbu	a5,0(a0)
 138:	cf91                	beqz	a5,154 <strlen+0x26>
 13a:	0505                	addi	a0,a0,1
 13c:	87aa                	mv	a5,a0
 13e:	86be                	mv	a3,a5
 140:	0785                	addi	a5,a5,1
 142:	fff7c703          	lbu	a4,-1(a5)
 146:	ff65                	bnez	a4,13e <strlen+0x10>
 148:	40a6853b          	subw	a0,a3,a0
 14c:	2505                	addiw	a0,a0,1
 14e:	6422                	ld	s0,8(sp)
 150:	0141                	addi	sp,sp,16
 152:	8082                	ret
 154:	4501                	li	a0,0
 156:	bfe5                	j	14e <strlen+0x20>

0000000000000158 <memset>:
 158:	1141                	addi	sp,sp,-16
 15a:	e422                	sd	s0,8(sp)
 15c:	0800                	addi	s0,sp,16
 15e:	ca19                	beqz	a2,174 <memset+0x1c>
 160:	87aa                	mv	a5,a0
 162:	1602                	slli	a2,a2,0x20
 164:	9201                	srli	a2,a2,0x20
 166:	00a60733          	add	a4,a2,a0
 16a:	00b78023          	sb	a1,0(a5)
 16e:	0785                	addi	a5,a5,1
 170:	fee79de3          	bne	a5,a4,16a <memset+0x12>
 174:	6422                	ld	s0,8(sp)
 176:	0141                	addi	sp,sp,16
 178:	8082                	ret

000000000000017a <strchr>:
 17a:	1141                	addi	sp,sp,-16
 17c:	e422                	sd	s0,8(sp)
 17e:	0800                	addi	s0,sp,16
 180:	00054783          	lbu	a5,0(a0)
 184:	cb99                	beqz	a5,19a <strchr+0x20>
 186:	00f58763          	beq	a1,a5,194 <strchr+0x1a>
 18a:	0505                	addi	a0,a0,1
 18c:	00054783          	lbu	a5,0(a0)
 190:	fbfd                	bnez	a5,186 <strchr+0xc>
 192:	4501                	li	a0,0
 194:	6422                	ld	s0,8(sp)
 196:	0141                	addi	sp,sp,16
 198:	8082                	ret
 19a:	4501                	li	a0,0
 19c:	bfe5                	j	194 <strchr+0x1a>

000000000000019e <gets>:
 19e:	711d                	addi	sp,sp,-96
 1a0:	ec86                	sd	ra,88(sp)
 1a2:	e8a2                	sd	s0,80(sp)
 1a4:	e4a6                	sd	s1,72(sp)
 1a6:	e0ca                	sd	s2,64(sp)
 1a8:	fc4e                	sd	s3,56(sp)
 1aa:	f852                	sd	s4,48(sp)
 1ac:	f456                	sd	s5,40(sp)
 1ae:	f05a                	sd	s6,32(sp)
 1b0:	ec5e                	sd	s7,24(sp)
 1b2:	1080                	addi	s0,sp,96
 1b4:	8baa                	mv	s7,a0
 1b6:	8a2e                	mv	s4,a1
 1b8:	892a                	mv	s2,a0
 1ba:	4481                	li	s1,0
 1bc:	4aa9                	li	s5,10
 1be:	4b35                	li	s6,13
 1c0:	89a6                	mv	s3,s1
 1c2:	2485                	addiw	s1,s1,1
 1c4:	0344d663          	bge	s1,s4,1f0 <gets+0x52>
 1c8:	4605                	li	a2,1
 1ca:	faf40593          	addi	a1,s0,-81
 1ce:	4501                	li	a0,0
 1d0:	1b2000ef          	jal	382 <read>
 1d4:	00a05e63          	blez	a0,1f0 <gets+0x52>
 1d8:	faf44783          	lbu	a5,-81(s0)
 1dc:	00f90023          	sb	a5,0(s2)
 1e0:	01578763          	beq	a5,s5,1ee <gets+0x50>
 1e4:	0905                	addi	s2,s2,1
 1e6:	fd679de3          	bne	a5,s6,1c0 <gets+0x22>
 1ea:	89a6                	mv	s3,s1
 1ec:	a011                	j	1f0 <gets+0x52>
 1ee:	89a6                	mv	s3,s1
 1f0:	99de                	add	s3,s3,s7
 1f2:	00098023          	sb	zero,0(s3)
 1f6:	855e                	mv	a0,s7
 1f8:	60e6                	ld	ra,88(sp)
 1fa:	6446                	ld	s0,80(sp)
 1fc:	64a6                	ld	s1,72(sp)
 1fe:	6906                	ld	s2,64(sp)
 200:	79e2                	ld	s3,56(sp)
 202:	7a42                	ld	s4,48(sp)
 204:	7aa2                	ld	s5,40(sp)
 206:	7b02                	ld	s6,32(sp)
 208:	6be2                	ld	s7,24(sp)
 20a:	6125                	addi	sp,sp,96
 20c:	8082                	ret

000000000000020e <stat>:
 20e:	1101                	addi	sp,sp,-32
 210:	ec06                	sd	ra,24(sp)
 212:	e822                	sd	s0,16(sp)
 214:	e04a                	sd	s2,0(sp)
 216:	1000                	addi	s0,sp,32
 218:	892e                	mv	s2,a1
 21a:	4581                	li	a1,0
 21c:	18e000ef          	jal	3aa <open>
 220:	02054263          	bltz	a0,244 <stat+0x36>
 224:	e426                	sd	s1,8(sp)
 226:	84aa                	mv	s1,a0
 228:	85ca                	mv	a1,s2
 22a:	198000ef          	jal	3c2 <fstat>
 22e:	892a                	mv	s2,a0
 230:	8526                	mv	a0,s1
 232:	160000ef          	jal	392 <close>
 236:	64a2                	ld	s1,8(sp)
 238:	854a                	mv	a0,s2
 23a:	60e2                	ld	ra,24(sp)
 23c:	6442                	ld	s0,16(sp)
 23e:	6902                	ld	s2,0(sp)
 240:	6105                	addi	sp,sp,32
 242:	8082                	ret
 244:	597d                	li	s2,-1
 246:	bfcd                	j	238 <stat+0x2a>

0000000000000248 <atoi>:
 248:	1141                	addi	sp,sp,-16
 24a:	e422                	sd	s0,8(sp)
 24c:	0800                	addi	s0,sp,16
 24e:	00054683          	lbu	a3,0(a0)
 252:	fd06879b          	addiw	a5,a3,-48
 256:	0ff7f793          	zext.b	a5,a5
 25a:	4625                	li	a2,9
 25c:	02f66863          	bltu	a2,a5,28c <atoi+0x44>
 260:	872a                	mv	a4,a0
 262:	4501                	li	a0,0
 264:	0705                	addi	a4,a4,1
 266:	0025179b          	slliw	a5,a0,0x2
 26a:	9fa9                	addw	a5,a5,a0
 26c:	0017979b          	slliw	a5,a5,0x1
 270:	9fb5                	addw	a5,a5,a3
 272:	fd07851b          	addiw	a0,a5,-48
 276:	00074683          	lbu	a3,0(a4)
 27a:	fd06879b          	addiw	a5,a3,-48
 27e:	0ff7f793          	zext.b	a5,a5
 282:	fef671e3          	bgeu	a2,a5,264 <atoi+0x1c>
 286:	6422                	ld	s0,8(sp)
 288:	0141                	addi	sp,sp,16
 28a:	8082                	ret
 28c:	4501                	li	a0,0
 28e:	bfe5                	j	286 <atoi+0x3e>

0000000000000290 <memmove>:
 290:	1141                	addi	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	addi	s0,sp,16
 296:	02b57463          	bgeu	a0,a1,2be <memmove+0x2e>
 29a:	00c05f63          	blez	a2,2b8 <memmove+0x28>
 29e:	1602                	slli	a2,a2,0x20
 2a0:	9201                	srli	a2,a2,0x20
 2a2:	00c507b3          	add	a5,a0,a2
 2a6:	872a                	mv	a4,a0
 2a8:	0585                	addi	a1,a1,1
 2aa:	0705                	addi	a4,a4,1
 2ac:	fff5c683          	lbu	a3,-1(a1)
 2b0:	fed70fa3          	sb	a3,-1(a4)
 2b4:	fef71ae3          	bne	a4,a5,2a8 <memmove+0x18>
 2b8:	6422                	ld	s0,8(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret
 2be:	00c50733          	add	a4,a0,a2
 2c2:	95b2                	add	a1,a1,a2
 2c4:	fec05ae3          	blez	a2,2b8 <memmove+0x28>
 2c8:	fff6079b          	addiw	a5,a2,-1
 2cc:	1782                	slli	a5,a5,0x20
 2ce:	9381                	srli	a5,a5,0x20
 2d0:	fff7c793          	not	a5,a5
 2d4:	97ba                	add	a5,a5,a4
 2d6:	15fd                	addi	a1,a1,-1
 2d8:	177d                	addi	a4,a4,-1
 2da:	0005c683          	lbu	a3,0(a1)
 2de:	00d70023          	sb	a3,0(a4)
 2e2:	fee79ae3          	bne	a5,a4,2d6 <memmove+0x46>
 2e6:	bfc9                	j	2b8 <memmove+0x28>

00000000000002e8 <memcmp>:
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
 2ee:	ca05                	beqz	a2,31e <memcmp+0x36>
 2f0:	fff6069b          	addiw	a3,a2,-1
 2f4:	1682                	slli	a3,a3,0x20
 2f6:	9281                	srli	a3,a3,0x20
 2f8:	0685                	addi	a3,a3,1
 2fa:	96aa                	add	a3,a3,a0
 2fc:	00054783          	lbu	a5,0(a0)
 300:	0005c703          	lbu	a4,0(a1)
 304:	00e79863          	bne	a5,a4,314 <memcmp+0x2c>
 308:	0505                	addi	a0,a0,1
 30a:	0585                	addi	a1,a1,1
 30c:	fed518e3          	bne	a0,a3,2fc <memcmp+0x14>
 310:	4501                	li	a0,0
 312:	a019                	j	318 <memcmp+0x30>
 314:	40e7853b          	subw	a0,a5,a4
 318:	6422                	ld	s0,8(sp)
 31a:	0141                	addi	sp,sp,16
 31c:	8082                	ret
 31e:	4501                	li	a0,0
 320:	bfe5                	j	318 <memcmp+0x30>

0000000000000322 <memcpy>:
 322:	1141                	addi	sp,sp,-16
 324:	e406                	sd	ra,8(sp)
 326:	e022                	sd	s0,0(sp)
 328:	0800                	addi	s0,sp,16
 32a:	f67ff0ef          	jal	290 <memmove>
 32e:	60a2                	ld	ra,8(sp)
 330:	6402                	ld	s0,0(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret

0000000000000336 <sbrk>:
 336:	1141                	addi	sp,sp,-16
 338:	e406                	sd	ra,8(sp)
 33a:	e022                	sd	s0,0(sp)
 33c:	0800                	addi	s0,sp,16
 33e:	4585                	li	a1,1
 340:	0b2000ef          	jal	3f2 <sys_sbrk>
 344:	60a2                	ld	ra,8(sp)
 346:	6402                	ld	s0,0(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret

000000000000034c <sbrklazy>:
 34c:	1141                	addi	sp,sp,-16
 34e:	e406                	sd	ra,8(sp)
 350:	e022                	sd	s0,0(sp)
 352:	0800                	addi	s0,sp,16
 354:	4589                	li	a1,2
 356:	09c000ef          	jal	3f2 <sys_sbrk>
 35a:	60a2                	ld	ra,8(sp)
 35c:	6402                	ld	s0,0(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret

0000000000000362 <fork>:
 362:	4885                	li	a7,1
 364:	00000073          	ecall
 368:	8082                	ret

000000000000036a <exit>:
 36a:	4889                	li	a7,2
 36c:	00000073          	ecall
 370:	8082                	ret

0000000000000372 <wait>:
 372:	488d                	li	a7,3
 374:	00000073          	ecall
 378:	8082                	ret

000000000000037a <pipe>:
 37a:	4891                	li	a7,4
 37c:	00000073          	ecall
 380:	8082                	ret

0000000000000382 <read>:
 382:	4895                	li	a7,5
 384:	00000073          	ecall
 388:	8082                	ret

000000000000038a <write>:
 38a:	48c1                	li	a7,16
 38c:	00000073          	ecall
 390:	8082                	ret

0000000000000392 <close>:
 392:	48d5                	li	a7,21
 394:	00000073          	ecall
 398:	8082                	ret

000000000000039a <kill>:
 39a:	4899                	li	a7,6
 39c:	00000073          	ecall
 3a0:	8082                	ret

00000000000003a2 <exec>:
 3a2:	489d                	li	a7,7
 3a4:	00000073          	ecall
 3a8:	8082                	ret

00000000000003aa <open>:
 3aa:	48bd                	li	a7,15
 3ac:	00000073          	ecall
 3b0:	8082                	ret

00000000000003b2 <mknod>:
 3b2:	48c5                	li	a7,17
 3b4:	00000073          	ecall
 3b8:	8082                	ret

00000000000003ba <unlink>:
 3ba:	48c9                	li	a7,18
 3bc:	00000073          	ecall
 3c0:	8082                	ret

00000000000003c2 <fstat>:
 3c2:	48a1                	li	a7,8
 3c4:	00000073          	ecall
 3c8:	8082                	ret

00000000000003ca <link>:
 3ca:	48cd                	li	a7,19
 3cc:	00000073          	ecall
 3d0:	8082                	ret

00000000000003d2 <mkdir>:
 3d2:	48d1                	li	a7,20
 3d4:	00000073          	ecall
 3d8:	8082                	ret

00000000000003da <chdir>:
 3da:	48a5                	li	a7,9
 3dc:	00000073          	ecall
 3e0:	8082                	ret

00000000000003e2 <dup>:
 3e2:	48a9                	li	a7,10
 3e4:	00000073          	ecall
 3e8:	8082                	ret

00000000000003ea <getpid>:
 3ea:	48ad                	li	a7,11
 3ec:	00000073          	ecall
 3f0:	8082                	ret

00000000000003f2 <sys_sbrk>:
 3f2:	48b1                	li	a7,12
 3f4:	00000073          	ecall
 3f8:	8082                	ret

00000000000003fa <pause>:
 3fa:	48b5                	li	a7,13
 3fc:	00000073          	ecall
 400:	8082                	ret

0000000000000402 <uptime>:
 402:	48b9                	li	a7,14
 404:	00000073          	ecall
 408:	8082                	ret

000000000000040a <sync>:
 40a:	48d9                	li	a7,22
 40c:	00000073          	ecall
 410:	8082                	ret
