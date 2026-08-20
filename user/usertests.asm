
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	711d                	addi	sp,sp,-96
       2:	ec86                	sd	ra,88(sp)
       4:	e8a2                	sd	s0,80(sp)
       6:	e4a6                	sd	s1,72(sp)
       8:	e0ca                	sd	s2,64(sp)
       a:	fc4e                	sd	s3,56(sp)
       c:	1080                	addi	s0,sp,96
  uint64 addrs[] = {0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
       e:	00008797          	auipc	a5,0x8
      12:	01a78793          	addi	a5,a5,26 # 8028 <malloc+0x2930>
      16:	638c                	ld	a1,0(a5)
      18:	6790                	ld	a2,8(a5)
      1a:	6b94                	ld	a3,16(a5)
      1c:	6f98                	ld	a4,24(a5)
      1e:	739c                	ld	a5,32(a5)
      20:	fab43423          	sd	a1,-88(s0)
      24:	fac43823          	sd	a2,-80(s0)
      28:	fad43c23          	sd	a3,-72(s0)
      2c:	fce43023          	sd	a4,-64(s0)
      30:	fcf43423          	sd	a5,-56(s0)
                    0xffffffffffffffff};

  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
      34:	fa840493          	addi	s1,s0,-88
      38:	fd040993          	addi	s3,s0,-48
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE | O_WRONLY);
      3c:	0004b903          	ld	s2,0(s1)
      40:	20100593          	li	a1,513
      44:	854a                	mv	a0,s2
      46:	20e050ef          	jal	5254 <open>
    if (fd >= 0) {
      4a:	00055c63          	bgez	a0,62 <copyinstr1+0x62>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
      4e:	04a1                	addi	s1,s1,8
      50:	ff3496e3          	bne	s1,s3,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", (void *)addr, fd);
      exit(1);
    }
  }
}
      54:	60e6                	ld	ra,88(sp)
      56:	6446                	ld	s0,80(sp)
      58:	64a6                	ld	s1,72(sp)
      5a:	6906                	ld	s2,64(sp)
      5c:	79e2                	ld	s3,56(sp)
      5e:	6125                	addi	sp,sp,96
      60:	8082                	ret
      printf("open(%p) returned %d, not -1\n", (void *)addr, fd);
      62:	862a                	mv	a2,a0
      64:	85ca                	mv	a1,s2
      66:	00005517          	auipc	a0,0x5
      6a:	78a50513          	addi	a0,a0,1930 # 57f0 <malloc+0xf8>
      6e:	5d6050ef          	jal	5644 <printf>
      exit(1);
      72:	4505                	li	a0,1
      74:	1a0050ef          	jal	5214 <exit>

0000000000000078 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for (i = 0; i < sizeof(uninit); i++) {
      78:	0000b797          	auipc	a5,0xb
      7c:	56078793          	addi	a5,a5,1376 # b5d8 <uninit>
      80:	0000e697          	auipc	a3,0xe
      84:	c6868693          	addi	a3,a3,-920 # dce8 <buf>
    if (uninit[i] != '\0') {
      88:	0007c703          	lbu	a4,0(a5)
      8c:	e709                	bnez	a4,96 <bsstest+0x1e>
  for (i = 0; i < sizeof(uninit); i++) {
      8e:	0785                	addi	a5,a5,1
      90:	fed79ce3          	bne	a5,a3,88 <bsstest+0x10>
      94:	8082                	ret
{
      96:	1141                	addi	sp,sp,-16
      98:	e406                	sd	ra,8(sp)
      9a:	e022                	sd	s0,0(sp)
      9c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      9e:	85aa                	mv	a1,a0
      a0:	00005517          	auipc	a0,0x5
      a4:	77050513          	addi	a0,a0,1904 # 5810 <malloc+0x118>
      a8:	59c050ef          	jal	5644 <printf>
      exit(1);
      ac:	4505                	li	a0,1
      ae:	166050ef          	jal	5214 <exit>

00000000000000b2 <opentest>:
{
      b2:	1101                	addi	sp,sp,-32
      b4:	ec06                	sd	ra,24(sp)
      b6:	e822                	sd	s0,16(sp)
      b8:	e426                	sd	s1,8(sp)
      ba:	1000                	addi	s0,sp,32
      bc:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      be:	4581                	li	a1,0
      c0:	00005517          	auipc	a0,0x5
      c4:	76850513          	addi	a0,a0,1896 # 5828 <malloc+0x130>
      c8:	18c050ef          	jal	5254 <open>
  if (fd < 0) {
      cc:	02054263          	bltz	a0,f0 <opentest+0x3e>
  close(fd);
      d0:	16c050ef          	jal	523c <close>
  fd = open("doesnotexist", 0);
      d4:	4581                	li	a1,0
      d6:	00005517          	auipc	a0,0x5
      da:	77250513          	addi	a0,a0,1906 # 5848 <malloc+0x150>
      de:	176050ef          	jal	5254 <open>
  if (fd >= 0) {
      e2:	02055163          	bgez	a0,104 <opentest+0x52>
}
      e6:	60e2                	ld	ra,24(sp)
      e8:	6442                	ld	s0,16(sp)
      ea:	64a2                	ld	s1,8(sp)
      ec:	6105                	addi	sp,sp,32
      ee:	8082                	ret
    printf("%s: open echo failed!\n", s);
      f0:	85a6                	mv	a1,s1
      f2:	00005517          	auipc	a0,0x5
      f6:	73e50513          	addi	a0,a0,1854 # 5830 <malloc+0x138>
      fa:	54a050ef          	jal	5644 <printf>
    exit(1);
      fe:	4505                	li	a0,1
     100:	114050ef          	jal	5214 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     104:	85a6                	mv	a1,s1
     106:	00005517          	auipc	a0,0x5
     10a:	75250513          	addi	a0,a0,1874 # 5858 <malloc+0x160>
     10e:	536050ef          	jal	5644 <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	100050ef          	jal	5214 <exit>

0000000000000118 <truncate2>:
{
     118:	7179                	addi	sp,sp,-48
     11a:	f406                	sd	ra,40(sp)
     11c:	f022                	sd	s0,32(sp)
     11e:	ec26                	sd	s1,24(sp)
     120:	e84a                	sd	s2,16(sp)
     122:	e44e                	sd	s3,8(sp)
     124:	1800                	addi	s0,sp,48
     126:	89aa                	mv	s3,a0
  unlink("truncfile");
     128:	00005517          	auipc	a0,0x5
     12c:	75850513          	addi	a0,a0,1880 # 5880 <malloc+0x188>
     130:	134050ef          	jal	5264 <unlink>
  int fd1 = open("truncfile", O_CREATE | O_TRUNC | O_WRONLY);
     134:	60100593          	li	a1,1537
     138:	00005517          	auipc	a0,0x5
     13c:	74850513          	addi	a0,a0,1864 # 5880 <malloc+0x188>
     140:	114050ef          	jal	5254 <open>
     144:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     146:	4611                	li	a2,4
     148:	00005597          	auipc	a1,0x5
     14c:	74858593          	addi	a1,a1,1864 # 5890 <malloc+0x198>
     150:	0e4050ef          	jal	5234 <write>
  int fd2 = open("truncfile", O_TRUNC | O_WRONLY);
     154:	40100593          	li	a1,1025
     158:	00005517          	auipc	a0,0x5
     15c:	72850513          	addi	a0,a0,1832 # 5880 <malloc+0x188>
     160:	0f4050ef          	jal	5254 <open>
     164:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     166:	4605                	li	a2,1
     168:	00005597          	auipc	a1,0x5
     16c:	73058593          	addi	a1,a1,1840 # 5898 <malloc+0x1a0>
     170:	8526                	mv	a0,s1
     172:	0c2050ef          	jal	5234 <write>
  if (n != -1) {
     176:	57fd                	li	a5,-1
     178:	02f51563          	bne	a0,a5,1a2 <truncate2+0x8a>
  unlink("truncfile");
     17c:	00005517          	auipc	a0,0x5
     180:	70450513          	addi	a0,a0,1796 # 5880 <malloc+0x188>
     184:	0e0050ef          	jal	5264 <unlink>
  close(fd1);
     188:	8526                	mv	a0,s1
     18a:	0b2050ef          	jal	523c <close>
  close(fd2);
     18e:	854a                	mv	a0,s2
     190:	0ac050ef          	jal	523c <close>
}
     194:	70a2                	ld	ra,40(sp)
     196:	7402                	ld	s0,32(sp)
     198:	64e2                	ld	s1,24(sp)
     19a:	6942                	ld	s2,16(sp)
     19c:	69a2                	ld	s3,8(sp)
     19e:	6145                	addi	sp,sp,48
     1a0:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1a2:	862a                	mv	a2,a0
     1a4:	85ce                	mv	a1,s3
     1a6:	00005517          	auipc	a0,0x5
     1aa:	6fa50513          	addi	a0,a0,1786 # 58a0 <malloc+0x1a8>
     1ae:	496050ef          	jal	5644 <printf>
    exit(1);
     1b2:	4505                	li	a0,1
     1b4:	060050ef          	jal	5214 <exit>

00000000000001b8 <createtest>:
{
     1b8:	7179                	addi	sp,sp,-48
     1ba:	f406                	sd	ra,40(sp)
     1bc:	f022                	sd	s0,32(sp)
     1be:	ec26                	sd	s1,24(sp)
     1c0:	e84a                	sd	s2,16(sp)
     1c2:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1c4:	06100793          	li	a5,97
     1c8:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1cc:	fc040d23          	sb	zero,-38(s0)
     1d0:	03000493          	li	s1,48
  for (i = 0; i < N; i++) {
     1d4:	06400913          	li	s2,100
    name[1] = '0' + i;
     1d8:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE | O_RDWR);
     1dc:	20200593          	li	a1,514
     1e0:	fd840513          	addi	a0,s0,-40
     1e4:	070050ef          	jal	5254 <open>
    close(fd);
     1e8:	054050ef          	jal	523c <close>
  for (i = 0; i < N; i++) {
     1ec:	2485                	addiw	s1,s1,1
     1ee:	0ff4f493          	zext.b	s1,s1
     1f2:	ff2493e3          	bne	s1,s2,1d8 <createtest+0x20>
  name[0] = 'a';
     1f6:	06100793          	li	a5,97
     1fa:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1fe:	fc040d23          	sb	zero,-38(s0)
     202:	03000493          	li	s1,48
  for (i = 0; i < N; i++) {
     206:	06400913          	li	s2,100
    name[1] = '0' + i;
     20a:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     20e:	fd840513          	addi	a0,s0,-40
     212:	052050ef          	jal	5264 <unlink>
  for (i = 0; i < N; i++) {
     216:	2485                	addiw	s1,s1,1
     218:	0ff4f493          	zext.b	s1,s1
     21c:	ff2497e3          	bne	s1,s2,20a <createtest+0x52>
}
     220:	70a2                	ld	ra,40(sp)
     222:	7402                	ld	s0,32(sp)
     224:	64e2                	ld	s1,24(sp)
     226:	6942                	ld	s2,16(sp)
     228:	6145                	addi	sp,sp,48
     22a:	8082                	ret

000000000000022c <bigwrite>:
{
     22c:	715d                	addi	sp,sp,-80
     22e:	e486                	sd	ra,72(sp)
     230:	e0a2                	sd	s0,64(sp)
     232:	fc26                	sd	s1,56(sp)
     234:	f84a                	sd	s2,48(sp)
     236:	f44e                	sd	s3,40(sp)
     238:	f052                	sd	s4,32(sp)
     23a:	ec56                	sd	s5,24(sp)
     23c:	e85a                	sd	s6,16(sp)
     23e:	e45e                	sd	s7,8(sp)
     240:	0880                	addi	s0,sp,80
     242:	8baa                	mv	s7,a0
  unlink("bigwrite");
     244:	00005517          	auipc	a0,0x5
     248:	68450513          	addi	a0,a0,1668 # 58c8 <malloc+0x1d0>
     24c:	018050ef          	jal	5264 <unlink>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     250:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     254:	00005a97          	auipc	s5,0x5
     258:	674a8a93          	addi	s5,s5,1652 # 58c8 <malloc+0x1d0>
      int cc = write(fd, buf, sz);
     25c:	0000ea17          	auipc	s4,0xe
     260:	a8ca0a13          	addi	s4,s4,-1396 # dce8 <buf>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     264:	6b0d                	lui	s6,0x3
     266:	1c9b0b13          	addi	s6,s6,457 # 31c9 <dirfile+0x69>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     26a:	20200593          	li	a1,514
     26e:	8556                	mv	a0,s5
     270:	7e5040ef          	jal	5254 <open>
     274:	892a                	mv	s2,a0
    if (fd < 0) {
     276:	04054563          	bltz	a0,2c0 <bigwrite+0x94>
      int cc = write(fd, buf, sz);
     27a:	8626                	mv	a2,s1
     27c:	85d2                	mv	a1,s4
     27e:	7b7040ef          	jal	5234 <write>
     282:	89aa                	mv	s3,a0
      if (cc != sz) {
     284:	04a49863          	bne	s1,a0,2d4 <bigwrite+0xa8>
      int cc = write(fd, buf, sz);
     288:	8626                	mv	a2,s1
     28a:	85d2                	mv	a1,s4
     28c:	854a                	mv	a0,s2
     28e:	7a7040ef          	jal	5234 <write>
      if (cc != sz) {
     292:	04951263          	bne	a0,s1,2d6 <bigwrite+0xaa>
    close(fd);
     296:	854a                	mv	a0,s2
     298:	7a5040ef          	jal	523c <close>
    unlink("bigwrite");
     29c:	8556                	mv	a0,s5
     29e:	7c7040ef          	jal	5264 <unlink>
  for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     2a2:	1d74849b          	addiw	s1,s1,471
     2a6:	fd6492e3          	bne	s1,s6,26a <bigwrite+0x3e>
}
     2aa:	60a6                	ld	ra,72(sp)
     2ac:	6406                	ld	s0,64(sp)
     2ae:	74e2                	ld	s1,56(sp)
     2b0:	7942                	ld	s2,48(sp)
     2b2:	79a2                	ld	s3,40(sp)
     2b4:	7a02                	ld	s4,32(sp)
     2b6:	6ae2                	ld	s5,24(sp)
     2b8:	6b42                	ld	s6,16(sp)
     2ba:	6ba2                	ld	s7,8(sp)
     2bc:	6161                	addi	sp,sp,80
     2be:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     2c0:	85de                	mv	a1,s7
     2c2:	00005517          	auipc	a0,0x5
     2c6:	61650513          	addi	a0,a0,1558 # 58d8 <malloc+0x1e0>
     2ca:	37a050ef          	jal	5644 <printf>
      exit(1);
     2ce:	4505                	li	a0,1
     2d0:	745040ef          	jal	5214 <exit>
      if (cc != sz) {
     2d4:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     2d6:	86aa                	mv	a3,a0
     2d8:	864e                	mv	a2,s3
     2da:	85de                	mv	a1,s7
     2dc:	00005517          	auipc	a0,0x5
     2e0:	61c50513          	addi	a0,a0,1564 # 58f8 <malloc+0x200>
     2e4:	360050ef          	jal	5644 <printf>
        exit(1);
     2e8:	4505                	li	a0,1
     2ea:	72b040ef          	jal	5214 <exit>

00000000000002ee <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     2ee:	7179                	addi	sp,sp,-48
     2f0:	f406                	sd	ra,40(sp)
     2f2:	f022                	sd	s0,32(sp)
     2f4:	ec26                	sd	s1,24(sp)
     2f6:	e84a                	sd	s2,16(sp)
     2f8:	e44e                	sd	s3,8(sp)
     2fa:	e052                	sd	s4,0(sp)
     2fc:	1800                	addi	s0,sp,48
  int assumed_free = 600;

  unlink("junk");
     2fe:	00005517          	auipc	a0,0x5
     302:	61250513          	addi	a0,a0,1554 # 5910 <malloc+0x218>
     306:	75f040ef          	jal	5264 <unlink>
     30a:	25800913          	li	s2,600
  for (int i = 0; i < assumed_free; i++) {
    int fd = open("junk", O_CREATE | O_WRONLY);
     30e:	00005997          	auipc	s3,0x5
     312:	60298993          	addi	s3,s3,1538 # 5910 <malloc+0x218>
    if (fd < 0) {
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char *)0xffffffffffL, 1);
     316:	5a7d                	li	s4,-1
     318:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE | O_WRONLY);
     31c:	20100593          	li	a1,513
     320:	854e                	mv	a0,s3
     322:	733040ef          	jal	5254 <open>
     326:	84aa                	mv	s1,a0
    if (fd < 0) {
     328:	04054d63          	bltz	a0,382 <badwrite+0x94>
    write(fd, (char *)0xffffffffffL, 1);
     32c:	4605                	li	a2,1
     32e:	85d2                	mv	a1,s4
     330:	705040ef          	jal	5234 <write>
    close(fd);
     334:	8526                	mv	a0,s1
     336:	707040ef          	jal	523c <close>
    unlink("junk");
     33a:	854e                	mv	a0,s3
     33c:	729040ef          	jal	5264 <unlink>
  for (int i = 0; i < assumed_free; i++) {
     340:	397d                	addiw	s2,s2,-1
     342:	fc091de3          	bnez	s2,31c <badwrite+0x2e>
  }

  int fd = open("junk", O_CREATE | O_WRONLY);
     346:	20100593          	li	a1,513
     34a:	00005517          	auipc	a0,0x5
     34e:	5c650513          	addi	a0,a0,1478 # 5910 <malloc+0x218>
     352:	703040ef          	jal	5254 <open>
     356:	84aa                	mv	s1,a0
  if (fd < 0) {
     358:	02054e63          	bltz	a0,394 <badwrite+0xa6>
    printf("open junk failed\n");
    exit(1);
  }
  if (write(fd, "x", 1) != 1) {
     35c:	4605                	li	a2,1
     35e:	00005597          	auipc	a1,0x5
     362:	53a58593          	addi	a1,a1,1338 # 5898 <malloc+0x1a0>
     366:	6cf040ef          	jal	5234 <write>
     36a:	4785                	li	a5,1
     36c:	02f50d63          	beq	a0,a5,3a6 <badwrite+0xb8>
    printf("write failed\n");
     370:	00005517          	auipc	a0,0x5
     374:	5c050513          	addi	a0,a0,1472 # 5930 <malloc+0x238>
     378:	2cc050ef          	jal	5644 <printf>
    exit(1);
     37c:	4505                	li	a0,1
     37e:	697040ef          	jal	5214 <exit>
      printf("open junk failed\n");
     382:	00005517          	auipc	a0,0x5
     386:	59650513          	addi	a0,a0,1430 # 5918 <malloc+0x220>
     38a:	2ba050ef          	jal	5644 <printf>
      exit(1);
     38e:	4505                	li	a0,1
     390:	685040ef          	jal	5214 <exit>
    printf("open junk failed\n");
     394:	00005517          	auipc	a0,0x5
     398:	58450513          	addi	a0,a0,1412 # 5918 <malloc+0x220>
     39c:	2a8050ef          	jal	5644 <printf>
    exit(1);
     3a0:	4505                	li	a0,1
     3a2:	673040ef          	jal	5214 <exit>
  }
  close(fd);
     3a6:	8526                	mv	a0,s1
     3a8:	695040ef          	jal	523c <close>
  unlink("junk");
     3ac:	00005517          	auipc	a0,0x5
     3b0:	56450513          	addi	a0,a0,1380 # 5910 <malloc+0x218>
     3b4:	6b1040ef          	jal	5264 <unlink>

  exit(0);
     3b8:	4501                	li	a0,0
     3ba:	65b040ef          	jal	5214 <exit>

00000000000003be <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     3be:	715d                	addi	sp,sp,-80
     3c0:	e486                	sd	ra,72(sp)
     3c2:	e0a2                	sd	s0,64(sp)
     3c4:	fc26                	sd	s1,56(sp)
     3c6:	f84a                	sd	s2,48(sp)
     3c8:	f44e                	sd	s3,40(sp)
     3ca:	0880                	addi	s0,sp,80
  int nzz = 32 * 32;
  for (int i = 0; i < nzz; i++) {
     3cc:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     3ce:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
     3d2:	40000993          	li	s3,1024
    name[0] = 'z';
     3d6:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     3da:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     3de:	41f4d71b          	sraiw	a4,s1,0x1f
     3e2:	01b7571b          	srliw	a4,a4,0x1b
     3e6:	009707bb          	addw	a5,a4,s1
     3ea:	4057d69b          	sraiw	a3,a5,0x5
     3ee:	0306869b          	addiw	a3,a3,48
     3f2:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     3f6:	8bfd                	andi	a5,a5,31
     3f8:	9f99                	subw	a5,a5,a4
     3fa:	0307879b          	addiw	a5,a5,48
     3fe:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     402:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     406:	fb040513          	addi	a0,s0,-80
     40a:	65b040ef          	jal	5264 <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
     40e:	60200593          	li	a1,1538
     412:	fb040513          	addi	a0,s0,-80
     416:	63f040ef          	jal	5254 <open>
    if (fd < 0) {
     41a:	00054763          	bltz	a0,428 <outofinodes+0x6a>
      // failure is eventually expected.
      break;
    }
    close(fd);
     41e:	61f040ef          	jal	523c <close>
  for (int i = 0; i < nzz; i++) {
     422:	2485                	addiw	s1,s1,1
     424:	fb3499e3          	bne	s1,s3,3d6 <outofinodes+0x18>
     428:	4481                	li	s1,0
  }

  for (int i = 0; i < nzz; i++) {
    char name[32];
    name[0] = 'z';
     42a:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
     42e:	40000993          	li	s3,1024
    name[0] = 'z';
     432:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     436:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     43a:	41f4d71b          	sraiw	a4,s1,0x1f
     43e:	01b7571b          	srliw	a4,a4,0x1b
     442:	009707bb          	addw	a5,a4,s1
     446:	4057d69b          	sraiw	a3,a5,0x5
     44a:	0306869b          	addiw	a3,a3,48
     44e:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     452:	8bfd                	andi	a5,a5,31
     454:	9f99                	subw	a5,a5,a4
     456:	0307879b          	addiw	a5,a5,48
     45a:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     45e:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     462:	fb040513          	addi	a0,s0,-80
     466:	5ff040ef          	jal	5264 <unlink>
  for (int i = 0; i < nzz; i++) {
     46a:	2485                	addiw	s1,s1,1
     46c:	fd3493e3          	bne	s1,s3,432 <outofinodes+0x74>
  }
}
     470:	60a6                	ld	ra,72(sp)
     472:	6406                	ld	s0,64(sp)
     474:	74e2                	ld	s1,56(sp)
     476:	7942                	ld	s2,48(sp)
     478:	79a2                	ld	s3,40(sp)
     47a:	6161                	addi	sp,sp,80
     47c:	8082                	ret

000000000000047e <copyin>:
{
     47e:	7159                	addi	sp,sp,-112
     480:	f486                	sd	ra,104(sp)
     482:	f0a2                	sd	s0,96(sp)
     484:	eca6                	sd	s1,88(sp)
     486:	e8ca                	sd	s2,80(sp)
     488:	e4ce                	sd	s3,72(sp)
     48a:	e0d2                	sd	s4,64(sp)
     48c:	fc56                	sd	s5,56(sp)
     48e:	1880                	addi	s0,sp,112
  uint64 addrs[] = {0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     490:	00008797          	auipc	a5,0x8
     494:	b9878793          	addi	a5,a5,-1128 # 8028 <malloc+0x2930>
     498:	638c                	ld	a1,0(a5)
     49a:	6790                	ld	a2,8(a5)
     49c:	6b94                	ld	a3,16(a5)
     49e:	6f98                	ld	a4,24(a5)
     4a0:	739c                	ld	a5,32(a5)
     4a2:	f8b43c23          	sd	a1,-104(s0)
     4a6:	fac43023          	sd	a2,-96(s0)
     4aa:	fad43423          	sd	a3,-88(s0)
     4ae:	fae43823          	sd	a4,-80(s0)
     4b2:	faf43c23          	sd	a5,-72(s0)
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
     4b6:	f9840913          	addi	s2,s0,-104
     4ba:	fc040a93          	addi	s5,s0,-64
    int fd = open("copyin1", O_CREATE | O_WRONLY);
     4be:	00005a17          	auipc	s4,0x5
     4c2:	482a0a13          	addi	s4,s4,1154 # 5940 <malloc+0x248>
    uint64 addr = addrs[ai];
     4c6:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE | O_WRONLY);
     4ca:	20100593          	li	a1,513
     4ce:	8552                	mv	a0,s4
     4d0:	585040ef          	jal	5254 <open>
     4d4:	84aa                	mv	s1,a0
    if (fd < 0) {
     4d6:	06054763          	bltz	a0,544 <copyin+0xc6>
    int n = write(fd, (void *)addr, 8192);
     4da:	6609                	lui	a2,0x2
     4dc:	85ce                	mv	a1,s3
     4de:	557040ef          	jal	5234 <write>
    if (n >= 0) {
     4e2:	06055a63          	bgez	a0,556 <copyin+0xd8>
    close(fd);
     4e6:	8526                	mv	a0,s1
     4e8:	555040ef          	jal	523c <close>
    unlink("copyin1");
     4ec:	8552                	mv	a0,s4
     4ee:	577040ef          	jal	5264 <unlink>
    n = write(1, (char *)addr, 8192);
     4f2:	6609                	lui	a2,0x2
     4f4:	85ce                	mv	a1,s3
     4f6:	4505                	li	a0,1
     4f8:	53d040ef          	jal	5234 <write>
    if (n > 0) {
     4fc:	06a04863          	bgtz	a0,56c <copyin+0xee>
    if (pipe(fds) < 0) {
     500:	f9040513          	addi	a0,s0,-112
     504:	521040ef          	jal	5224 <pipe>
     508:	06054d63          	bltz	a0,582 <copyin+0x104>
    n = write(fds[1], (char *)addr, 8192);
     50c:	6609                	lui	a2,0x2
     50e:	85ce                	mv	a1,s3
     510:	f9442503          	lw	a0,-108(s0)
     514:	521040ef          	jal	5234 <write>
    if (n > 0) {
     518:	06a04e63          	bgtz	a0,594 <copyin+0x116>
    close(fds[0]);
     51c:	f9042503          	lw	a0,-112(s0)
     520:	51d040ef          	jal	523c <close>
    close(fds[1]);
     524:	f9442503          	lw	a0,-108(s0)
     528:	515040ef          	jal	523c <close>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
     52c:	0921                	addi	s2,s2,8
     52e:	f9591ce3          	bne	s2,s5,4c6 <copyin+0x48>
}
     532:	70a6                	ld	ra,104(sp)
     534:	7406                	ld	s0,96(sp)
     536:	64e6                	ld	s1,88(sp)
     538:	6946                	ld	s2,80(sp)
     53a:	69a6                	ld	s3,72(sp)
     53c:	6a06                	ld	s4,64(sp)
     53e:	7ae2                	ld	s5,56(sp)
     540:	6165                	addi	sp,sp,112
     542:	8082                	ret
      printf("open(copyin1) failed\n");
     544:	00005517          	auipc	a0,0x5
     548:	40450513          	addi	a0,a0,1028 # 5948 <malloc+0x250>
     54c:	0f8050ef          	jal	5644 <printf>
      exit(1);
     550:	4505                	li	a0,1
     552:	4c3040ef          	jal	5214 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", (void *)addr, n);
     556:	862a                	mv	a2,a0
     558:	85ce                	mv	a1,s3
     55a:	00005517          	auipc	a0,0x5
     55e:	40650513          	addi	a0,a0,1030 # 5960 <malloc+0x268>
     562:	0e2050ef          	jal	5644 <printf>
      exit(1);
     566:	4505                	li	a0,1
     568:	4ad040ef          	jal	5214 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", (void *)addr, n);
     56c:	862a                	mv	a2,a0
     56e:	85ce                	mv	a1,s3
     570:	00005517          	auipc	a0,0x5
     574:	42050513          	addi	a0,a0,1056 # 5990 <malloc+0x298>
     578:	0cc050ef          	jal	5644 <printf>
      exit(1);
     57c:	4505                	li	a0,1
     57e:	497040ef          	jal	5214 <exit>
      printf("pipe() failed\n");
     582:	00005517          	auipc	a0,0x5
     586:	43e50513          	addi	a0,a0,1086 # 59c0 <malloc+0x2c8>
     58a:	0ba050ef          	jal	5644 <printf>
      exit(1);
     58e:	4505                	li	a0,1
     590:	485040ef          	jal	5214 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", (void *)addr,
     594:	862a                	mv	a2,a0
     596:	85ce                	mv	a1,s3
     598:	00005517          	auipc	a0,0x5
     59c:	43850513          	addi	a0,a0,1080 # 59d0 <malloc+0x2d8>
     5a0:	0a4050ef          	jal	5644 <printf>
      exit(1);
     5a4:	4505                	li	a0,1
     5a6:	46f040ef          	jal	5214 <exit>

00000000000005aa <copyout>:
{
     5aa:	7119                	addi	sp,sp,-128
     5ac:	fc86                	sd	ra,120(sp)
     5ae:	f8a2                	sd	s0,112(sp)
     5b0:	f4a6                	sd	s1,104(sp)
     5b2:	f0ca                	sd	s2,96(sp)
     5b4:	ecce                	sd	s3,88(sp)
     5b6:	e8d2                	sd	s4,80(sp)
     5b8:	e4d6                	sd	s5,72(sp)
     5ba:	e0da                	sd	s6,64(sp)
     5bc:	0100                	addi	s0,sp,128
  uint64 addrs[] = {0LL,          0x80000000LL, 0x3fffffe000,
     5be:	00008797          	auipc	a5,0x8
     5c2:	a6a78793          	addi	a5,a5,-1430 # 8028 <malloc+0x2930>
     5c6:	7788                	ld	a0,40(a5)
     5c8:	7b8c                	ld	a1,48(a5)
     5ca:	7f90                	ld	a2,56(a5)
     5cc:	63b4                	ld	a3,64(a5)
     5ce:	67b8                	ld	a4,72(a5)
     5d0:	6bbc                	ld	a5,80(a5)
     5d2:	f8a43823          	sd	a0,-112(s0)
     5d6:	f8b43c23          	sd	a1,-104(s0)
     5da:	fac43023          	sd	a2,-96(s0)
     5de:	fad43423          	sd	a3,-88(s0)
     5e2:	fae43823          	sd	a4,-80(s0)
     5e6:	faf43c23          	sd	a5,-72(s0)
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
     5ea:	f9040913          	addi	s2,s0,-112
     5ee:	fc040b13          	addi	s6,s0,-64
    int fd = open("README", 0);
     5f2:	00005a17          	auipc	s4,0x5
     5f6:	40ea0a13          	addi	s4,s4,1038 # 5a00 <malloc+0x308>
    n = write(fds[1], "x", 1);
     5fa:	00005a97          	auipc	s5,0x5
     5fe:	29ea8a93          	addi	s5,s5,670 # 5898 <malloc+0x1a0>
    uint64 addr = addrs[ai];
     602:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     606:	4581                	li	a1,0
     608:	8552                	mv	a0,s4
     60a:	44b040ef          	jal	5254 <open>
     60e:	84aa                	mv	s1,a0
    if (fd < 0) {
     610:	06054763          	bltz	a0,67e <copyout+0xd4>
    int n = read(fd, (void *)addr, 8192);
     614:	6609                	lui	a2,0x2
     616:	85ce                	mv	a1,s3
     618:	415040ef          	jal	522c <read>
    if (n > 0) {
     61c:	06a04a63          	bgtz	a0,690 <copyout+0xe6>
    close(fd);
     620:	8526                	mv	a0,s1
     622:	41b040ef          	jal	523c <close>
    if (pipe(fds) < 0) {
     626:	f8840513          	addi	a0,s0,-120
     62a:	3fb040ef          	jal	5224 <pipe>
     62e:	06054c63          	bltz	a0,6a6 <copyout+0xfc>
    n = write(fds[1], "x", 1);
     632:	4605                	li	a2,1
     634:	85d6                	mv	a1,s5
     636:	f8c42503          	lw	a0,-116(s0)
     63a:	3fb040ef          	jal	5234 <write>
    if (n != 1) {
     63e:	4785                	li	a5,1
     640:	06f51c63          	bne	a0,a5,6b8 <copyout+0x10e>
    n = read(fds[0], (void *)addr, 8192);
     644:	6609                	lui	a2,0x2
     646:	85ce                	mv	a1,s3
     648:	f8842503          	lw	a0,-120(s0)
     64c:	3e1040ef          	jal	522c <read>
    if (n > 0) {
     650:	06a04d63          	bgtz	a0,6ca <copyout+0x120>
    close(fds[0]);
     654:	f8842503          	lw	a0,-120(s0)
     658:	3e5040ef          	jal	523c <close>
    close(fds[1]);
     65c:	f8c42503          	lw	a0,-116(s0)
     660:	3dd040ef          	jal	523c <close>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
     664:	0921                	addi	s2,s2,8
     666:	f9691ee3          	bne	s2,s6,602 <copyout+0x58>
}
     66a:	70e6                	ld	ra,120(sp)
     66c:	7446                	ld	s0,112(sp)
     66e:	74a6                	ld	s1,104(sp)
     670:	7906                	ld	s2,96(sp)
     672:	69e6                	ld	s3,88(sp)
     674:	6a46                	ld	s4,80(sp)
     676:	6aa6                	ld	s5,72(sp)
     678:	6b06                	ld	s6,64(sp)
     67a:	6109                	addi	sp,sp,128
     67c:	8082                	ret
      printf("open(README) failed\n");
     67e:	00005517          	auipc	a0,0x5
     682:	38a50513          	addi	a0,a0,906 # 5a08 <malloc+0x310>
     686:	7bf040ef          	jal	5644 <printf>
      exit(1);
     68a:	4505                	li	a0,1
     68c:	389040ef          	jal	5214 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", (void *)addr, n);
     690:	862a                	mv	a2,a0
     692:	85ce                	mv	a1,s3
     694:	00005517          	auipc	a0,0x5
     698:	38c50513          	addi	a0,a0,908 # 5a20 <malloc+0x328>
     69c:	7a9040ef          	jal	5644 <printf>
      exit(1);
     6a0:	4505                	li	a0,1
     6a2:	373040ef          	jal	5214 <exit>
      printf("pipe() failed\n");
     6a6:	00005517          	auipc	a0,0x5
     6aa:	31a50513          	addi	a0,a0,794 # 59c0 <malloc+0x2c8>
     6ae:	797040ef          	jal	5644 <printf>
      exit(1);
     6b2:	4505                	li	a0,1
     6b4:	361040ef          	jal	5214 <exit>
      printf("pipe write failed\n");
     6b8:	00005517          	auipc	a0,0x5
     6bc:	39850513          	addi	a0,a0,920 # 5a50 <malloc+0x358>
     6c0:	785040ef          	jal	5644 <printf>
      exit(1);
     6c4:	4505                	li	a0,1
     6c6:	34f040ef          	jal	5214 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", (void *)addr,
     6ca:	862a                	mv	a2,a0
     6cc:	85ce                	mv	a1,s3
     6ce:	00005517          	auipc	a0,0x5
     6d2:	39a50513          	addi	a0,a0,922 # 5a68 <malloc+0x370>
     6d6:	76f040ef          	jal	5644 <printf>
      exit(1);
     6da:	4505                	li	a0,1
     6dc:	339040ef          	jal	5214 <exit>

00000000000006e0 <truncate1>:
{
     6e0:	711d                	addi	sp,sp,-96
     6e2:	ec86                	sd	ra,88(sp)
     6e4:	e8a2                	sd	s0,80(sp)
     6e6:	e4a6                	sd	s1,72(sp)
     6e8:	e0ca                	sd	s2,64(sp)
     6ea:	fc4e                	sd	s3,56(sp)
     6ec:	f852                	sd	s4,48(sp)
     6ee:	f456                	sd	s5,40(sp)
     6f0:	1080                	addi	s0,sp,96
     6f2:	8aaa                	mv	s5,a0
  unlink("truncfile");
     6f4:	00005517          	auipc	a0,0x5
     6f8:	18c50513          	addi	a0,a0,396 # 5880 <malloc+0x188>
     6fc:	369040ef          	jal	5264 <unlink>
  int fd1 = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
     700:	60100593          	li	a1,1537
     704:	00005517          	auipc	a0,0x5
     708:	17c50513          	addi	a0,a0,380 # 5880 <malloc+0x188>
     70c:	349040ef          	jal	5254 <open>
     710:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     712:	4611                	li	a2,4
     714:	00005597          	auipc	a1,0x5
     718:	17c58593          	addi	a1,a1,380 # 5890 <malloc+0x198>
     71c:	319040ef          	jal	5234 <write>
  close(fd1);
     720:	8526                	mv	a0,s1
     722:	31b040ef          	jal	523c <close>
  int fd2 = open("truncfile", O_RDONLY);
     726:	4581                	li	a1,0
     728:	00005517          	auipc	a0,0x5
     72c:	15850513          	addi	a0,a0,344 # 5880 <malloc+0x188>
     730:	325040ef          	jal	5254 <open>
     734:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     736:	02000613          	li	a2,32
     73a:	fa040593          	addi	a1,s0,-96
     73e:	2ef040ef          	jal	522c <read>
  if (n != 4) {
     742:	4791                	li	a5,4
     744:	0af51863          	bne	a0,a5,7f4 <truncate1+0x114>
  fd1 = open("truncfile", O_WRONLY | O_TRUNC);
     748:	40100593          	li	a1,1025
     74c:	00005517          	auipc	a0,0x5
     750:	13450513          	addi	a0,a0,308 # 5880 <malloc+0x188>
     754:	301040ef          	jal	5254 <open>
     758:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     75a:	4581                	li	a1,0
     75c:	00005517          	auipc	a0,0x5
     760:	12450513          	addi	a0,a0,292 # 5880 <malloc+0x188>
     764:	2f1040ef          	jal	5254 <open>
     768:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     76a:	02000613          	li	a2,32
     76e:	fa040593          	addi	a1,s0,-96
     772:	2bb040ef          	jal	522c <read>
     776:	8a2a                	mv	s4,a0
  if (n != 0) {
     778:	e949                	bnez	a0,80a <truncate1+0x12a>
  n = read(fd2, buf, sizeof(buf));
     77a:	02000613          	li	a2,32
     77e:	fa040593          	addi	a1,s0,-96
     782:	8526                	mv	a0,s1
     784:	2a9040ef          	jal	522c <read>
     788:	8a2a                	mv	s4,a0
  if (n != 0) {
     78a:	e155                	bnez	a0,82e <truncate1+0x14e>
  write(fd1, "abcdef", 6);
     78c:	4619                	li	a2,6
     78e:	00005597          	auipc	a1,0x5
     792:	36a58593          	addi	a1,a1,874 # 5af8 <malloc+0x400>
     796:	854e                	mv	a0,s3
     798:	29d040ef          	jal	5234 <write>
  n = read(fd3, buf, sizeof(buf));
     79c:	02000613          	li	a2,32
     7a0:	fa040593          	addi	a1,s0,-96
     7a4:	854a                	mv	a0,s2
     7a6:	287040ef          	jal	522c <read>
  if (n != 6) {
     7aa:	4799                	li	a5,6
     7ac:	0af51363          	bne	a0,a5,852 <truncate1+0x172>
  n = read(fd2, buf, sizeof(buf));
     7b0:	02000613          	li	a2,32
     7b4:	fa040593          	addi	a1,s0,-96
     7b8:	8526                	mv	a0,s1
     7ba:	273040ef          	jal	522c <read>
  if (n != 2) {
     7be:	4789                	li	a5,2
     7c0:	0af51463          	bne	a0,a5,868 <truncate1+0x188>
  unlink("truncfile");
     7c4:	00005517          	auipc	a0,0x5
     7c8:	0bc50513          	addi	a0,a0,188 # 5880 <malloc+0x188>
     7cc:	299040ef          	jal	5264 <unlink>
  close(fd1);
     7d0:	854e                	mv	a0,s3
     7d2:	26b040ef          	jal	523c <close>
  close(fd2);
     7d6:	8526                	mv	a0,s1
     7d8:	265040ef          	jal	523c <close>
  close(fd3);
     7dc:	854a                	mv	a0,s2
     7de:	25f040ef          	jal	523c <close>
}
     7e2:	60e6                	ld	ra,88(sp)
     7e4:	6446                	ld	s0,80(sp)
     7e6:	64a6                	ld	s1,72(sp)
     7e8:	6906                	ld	s2,64(sp)
     7ea:	79e2                	ld	s3,56(sp)
     7ec:	7a42                	ld	s4,48(sp)
     7ee:	7aa2                	ld	s5,40(sp)
     7f0:	6125                	addi	sp,sp,96
     7f2:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     7f4:	862a                	mv	a2,a0
     7f6:	85d6                	mv	a1,s5
     7f8:	00005517          	auipc	a0,0x5
     7fc:	2a050513          	addi	a0,a0,672 # 5a98 <malloc+0x3a0>
     800:	645040ef          	jal	5644 <printf>
    exit(1);
     804:	4505                	li	a0,1
     806:	20f040ef          	jal	5214 <exit>
    printf("aaa fd3=%d\n", fd3);
     80a:	85ca                	mv	a1,s2
     80c:	00005517          	auipc	a0,0x5
     810:	2ac50513          	addi	a0,a0,684 # 5ab8 <malloc+0x3c0>
     814:	631040ef          	jal	5644 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     818:	8652                	mv	a2,s4
     81a:	85d6                	mv	a1,s5
     81c:	00005517          	auipc	a0,0x5
     820:	2ac50513          	addi	a0,a0,684 # 5ac8 <malloc+0x3d0>
     824:	621040ef          	jal	5644 <printf>
    exit(1);
     828:	4505                	li	a0,1
     82a:	1eb040ef          	jal	5214 <exit>
    printf("bbb fd2=%d\n", fd2);
     82e:	85a6                	mv	a1,s1
     830:	00005517          	auipc	a0,0x5
     834:	2b850513          	addi	a0,a0,696 # 5ae8 <malloc+0x3f0>
     838:	60d040ef          	jal	5644 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     83c:	8652                	mv	a2,s4
     83e:	85d6                	mv	a1,s5
     840:	00005517          	auipc	a0,0x5
     844:	28850513          	addi	a0,a0,648 # 5ac8 <malloc+0x3d0>
     848:	5fd040ef          	jal	5644 <printf>
    exit(1);
     84c:	4505                	li	a0,1
     84e:	1c7040ef          	jal	5214 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     852:	862a                	mv	a2,a0
     854:	85d6                	mv	a1,s5
     856:	00005517          	auipc	a0,0x5
     85a:	2aa50513          	addi	a0,a0,682 # 5b00 <malloc+0x408>
     85e:	5e7040ef          	jal	5644 <printf>
    exit(1);
     862:	4505                	li	a0,1
     864:	1b1040ef          	jal	5214 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     868:	862a                	mv	a2,a0
     86a:	85d6                	mv	a1,s5
     86c:	00005517          	auipc	a0,0x5
     870:	2b450513          	addi	a0,a0,692 # 5b20 <malloc+0x428>
     874:	5d1040ef          	jal	5644 <printf>
    exit(1);
     878:	4505                	li	a0,1
     87a:	19b040ef          	jal	5214 <exit>

000000000000087e <writetest>:
{
     87e:	7139                	addi	sp,sp,-64
     880:	fc06                	sd	ra,56(sp)
     882:	f822                	sd	s0,48(sp)
     884:	f426                	sd	s1,40(sp)
     886:	f04a                	sd	s2,32(sp)
     888:	ec4e                	sd	s3,24(sp)
     88a:	e852                	sd	s4,16(sp)
     88c:	e456                	sd	s5,8(sp)
     88e:	e05a                	sd	s6,0(sp)
     890:	0080                	addi	s0,sp,64
     892:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE | O_RDWR);
     894:	20200593          	li	a1,514
     898:	00005517          	auipc	a0,0x5
     89c:	2a850513          	addi	a0,a0,680 # 5b40 <malloc+0x448>
     8a0:	1b5040ef          	jal	5254 <open>
  if (fd < 0) {
     8a4:	08054f63          	bltz	a0,942 <writetest+0xc4>
     8a8:	892a                	mv	s2,a0
     8aa:	4481                	li	s1,0
    if (write(fd, "aaaaaaaaaa", SZ) != SZ) {
     8ac:	00005997          	auipc	s3,0x5
     8b0:	2bc98993          	addi	s3,s3,700 # 5b68 <malloc+0x470>
    if (write(fd, "bbbbbbbbbb", SZ) != SZ) {
     8b4:	00005a97          	auipc	s5,0x5
     8b8:	2eca8a93          	addi	s5,s5,748 # 5ba0 <malloc+0x4a8>
  for (i = 0; i < N; i++) {
     8bc:	06400a13          	li	s4,100
    if (write(fd, "aaaaaaaaaa", SZ) != SZ) {
     8c0:	4629                	li	a2,10
     8c2:	85ce                	mv	a1,s3
     8c4:	854a                	mv	a0,s2
     8c6:	16f040ef          	jal	5234 <write>
     8ca:	47a9                	li	a5,10
     8cc:	08f51563          	bne	a0,a5,956 <writetest+0xd8>
    if (write(fd, "bbbbbbbbbb", SZ) != SZ) {
     8d0:	4629                	li	a2,10
     8d2:	85d6                	mv	a1,s5
     8d4:	854a                	mv	a0,s2
     8d6:	15f040ef          	jal	5234 <write>
     8da:	47a9                	li	a5,10
     8dc:	08f51863          	bne	a0,a5,96c <writetest+0xee>
  for (i = 0; i < N; i++) {
     8e0:	2485                	addiw	s1,s1,1
     8e2:	fd449fe3          	bne	s1,s4,8c0 <writetest+0x42>
  close(fd);
     8e6:	854a                	mv	a0,s2
     8e8:	155040ef          	jal	523c <close>
  fd = open("small", O_RDONLY);
     8ec:	4581                	li	a1,0
     8ee:	00005517          	auipc	a0,0x5
     8f2:	25250513          	addi	a0,a0,594 # 5b40 <malloc+0x448>
     8f6:	15f040ef          	jal	5254 <open>
     8fa:	84aa                	mv	s1,a0
  if (fd < 0) {
     8fc:	08054363          	bltz	a0,982 <writetest+0x104>
  i = read(fd, buf, N * SZ * 2);
     900:	7d000613          	li	a2,2000
     904:	0000d597          	auipc	a1,0xd
     908:	3e458593          	addi	a1,a1,996 # dce8 <buf>
     90c:	121040ef          	jal	522c <read>
  if (i != N * SZ * 2) {
     910:	7d000793          	li	a5,2000
     914:	08f51163          	bne	a0,a5,996 <writetest+0x118>
  close(fd);
     918:	8526                	mv	a0,s1
     91a:	123040ef          	jal	523c <close>
  if (unlink("small") < 0) {
     91e:	00005517          	auipc	a0,0x5
     922:	22250513          	addi	a0,a0,546 # 5b40 <malloc+0x448>
     926:	13f040ef          	jal	5264 <unlink>
     92a:	08054063          	bltz	a0,9aa <writetest+0x12c>
}
     92e:	70e2                	ld	ra,56(sp)
     930:	7442                	ld	s0,48(sp)
     932:	74a2                	ld	s1,40(sp)
     934:	7902                	ld	s2,32(sp)
     936:	69e2                	ld	s3,24(sp)
     938:	6a42                	ld	s4,16(sp)
     93a:	6aa2                	ld	s5,8(sp)
     93c:	6b02                	ld	s6,0(sp)
     93e:	6121                	addi	sp,sp,64
     940:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     942:	85da                	mv	a1,s6
     944:	00005517          	auipc	a0,0x5
     948:	20450513          	addi	a0,a0,516 # 5b48 <malloc+0x450>
     94c:	4f9040ef          	jal	5644 <printf>
    exit(1);
     950:	4505                	li	a0,1
     952:	0c3040ef          	jal	5214 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     956:	8626                	mv	a2,s1
     958:	85da                	mv	a1,s6
     95a:	00005517          	auipc	a0,0x5
     95e:	21e50513          	addi	a0,a0,542 # 5b78 <malloc+0x480>
     962:	4e3040ef          	jal	5644 <printf>
      exit(1);
     966:	4505                	li	a0,1
     968:	0ad040ef          	jal	5214 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     96c:	8626                	mv	a2,s1
     96e:	85da                	mv	a1,s6
     970:	00005517          	auipc	a0,0x5
     974:	24050513          	addi	a0,a0,576 # 5bb0 <malloc+0x4b8>
     978:	4cd040ef          	jal	5644 <printf>
      exit(1);
     97c:	4505                	li	a0,1
     97e:	097040ef          	jal	5214 <exit>
    printf("%s: error: open small failed!\n", s);
     982:	85da                	mv	a1,s6
     984:	00005517          	auipc	a0,0x5
     988:	25450513          	addi	a0,a0,596 # 5bd8 <malloc+0x4e0>
     98c:	4b9040ef          	jal	5644 <printf>
    exit(1);
     990:	4505                	li	a0,1
     992:	083040ef          	jal	5214 <exit>
    printf("%s: read failed\n", s);
     996:	85da                	mv	a1,s6
     998:	00005517          	auipc	a0,0x5
     99c:	26050513          	addi	a0,a0,608 # 5bf8 <malloc+0x500>
     9a0:	4a5040ef          	jal	5644 <printf>
    exit(1);
     9a4:	4505                	li	a0,1
     9a6:	06f040ef          	jal	5214 <exit>
    printf("%s: unlink small failed\n", s);
     9aa:	85da                	mv	a1,s6
     9ac:	00005517          	auipc	a0,0x5
     9b0:	26450513          	addi	a0,a0,612 # 5c10 <malloc+0x518>
     9b4:	491040ef          	jal	5644 <printf>
    exit(1);
     9b8:	4505                	li	a0,1
     9ba:	05b040ef          	jal	5214 <exit>

00000000000009be <writebig>:
{
     9be:	7139                	addi	sp,sp,-64
     9c0:	fc06                	sd	ra,56(sp)
     9c2:	f822                	sd	s0,48(sp)
     9c4:	f426                	sd	s1,40(sp)
     9c6:	f04a                	sd	s2,32(sp)
     9c8:	ec4e                	sd	s3,24(sp)
     9ca:	e852                	sd	s4,16(sp)
     9cc:	e456                	sd	s5,8(sp)
     9ce:	0080                	addi	s0,sp,64
     9d0:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE | O_RDWR);
     9d2:	20200593          	li	a1,514
     9d6:	00005517          	auipc	a0,0x5
     9da:	25a50513          	addi	a0,a0,602 # 5c30 <malloc+0x538>
     9de:	077040ef          	jal	5254 <open>
     9e2:	89aa                	mv	s3,a0
  for (i = 0; i < MAXFILE; i++) {
     9e4:	4481                	li	s1,0
    ((int *)buf)[0] = i;
     9e6:	0000d917          	auipc	s2,0xd
     9ea:	30290913          	addi	s2,s2,770 # dce8 <buf>
  for (i = 0; i < MAXFILE; i++) {
     9ee:	10c00a13          	li	s4,268
  if (fd < 0) {
     9f2:	06054463          	bltz	a0,a5a <writebig+0x9c>
    ((int *)buf)[0] = i;
     9f6:	00992023          	sw	s1,0(s2)
    if (write(fd, buf, BSIZE) != BSIZE) {
     9fa:	40000613          	li	a2,1024
     9fe:	85ca                	mv	a1,s2
     a00:	854e                	mv	a0,s3
     a02:	033040ef          	jal	5234 <write>
     a06:	40000793          	li	a5,1024
     a0a:	06f51263          	bne	a0,a5,a6e <writebig+0xb0>
  for (i = 0; i < MAXFILE; i++) {
     a0e:	2485                	addiw	s1,s1,1
     a10:	ff4493e3          	bne	s1,s4,9f6 <writebig+0x38>
  close(fd);
     a14:	854e                	mv	a0,s3
     a16:	027040ef          	jal	523c <close>
  fd = open("big", O_RDONLY);
     a1a:	4581                	li	a1,0
     a1c:	00005517          	auipc	a0,0x5
     a20:	21450513          	addi	a0,a0,532 # 5c30 <malloc+0x538>
     a24:	031040ef          	jal	5254 <open>
     a28:	89aa                	mv	s3,a0
  n = 0;
     a2a:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a2c:	0000d917          	auipc	s2,0xd
     a30:	2bc90913          	addi	s2,s2,700 # dce8 <buf>
  if (fd < 0) {
     a34:	04054863          	bltz	a0,a84 <writebig+0xc6>
    i = read(fd, buf, BSIZE);
     a38:	40000613          	li	a2,1024
     a3c:	85ca                	mv	a1,s2
     a3e:	854e                	mv	a0,s3
     a40:	7ec040ef          	jal	522c <read>
    if (i == 0) {
     a44:	c931                	beqz	a0,a98 <writebig+0xda>
    } else if (i != BSIZE) {
     a46:	40000793          	li	a5,1024
     a4a:	08f51a63          	bne	a0,a5,ade <writebig+0x120>
    if (((int *)buf)[0] != n) {
     a4e:	00092683          	lw	a3,0(s2)
     a52:	0a969163          	bne	a3,s1,af4 <writebig+0x136>
    n++;
     a56:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     a58:	b7c5                	j	a38 <writebig+0x7a>
    printf("%s: error: creat big failed!\n", s);
     a5a:	85d6                	mv	a1,s5
     a5c:	00005517          	auipc	a0,0x5
     a60:	1dc50513          	addi	a0,a0,476 # 5c38 <malloc+0x540>
     a64:	3e1040ef          	jal	5644 <printf>
    exit(1);
     a68:	4505                	li	a0,1
     a6a:	7aa040ef          	jal	5214 <exit>
      printf("%s: error: write big file failed i=%d\n", s, i);
     a6e:	8626                	mv	a2,s1
     a70:	85d6                	mv	a1,s5
     a72:	00005517          	auipc	a0,0x5
     a76:	1e650513          	addi	a0,a0,486 # 5c58 <malloc+0x560>
     a7a:	3cb040ef          	jal	5644 <printf>
      exit(1);
     a7e:	4505                	li	a0,1
     a80:	794040ef          	jal	5214 <exit>
    printf("%s: error: open big failed!\n", s);
     a84:	85d6                	mv	a1,s5
     a86:	00005517          	auipc	a0,0x5
     a8a:	1fa50513          	addi	a0,a0,506 # 5c80 <malloc+0x588>
     a8e:	3b7040ef          	jal	5644 <printf>
    exit(1);
     a92:	4505                	li	a0,1
     a94:	780040ef          	jal	5214 <exit>
      if (n != MAXFILE) {
     a98:	10c00793          	li	a5,268
     a9c:	02f49663          	bne	s1,a5,ac8 <writebig+0x10a>
  close(fd);
     aa0:	854e                	mv	a0,s3
     aa2:	79a040ef          	jal	523c <close>
  if (unlink("big") < 0) {
     aa6:	00005517          	auipc	a0,0x5
     aaa:	18a50513          	addi	a0,a0,394 # 5c30 <malloc+0x538>
     aae:	7b6040ef          	jal	5264 <unlink>
     ab2:	04054c63          	bltz	a0,b0a <writebig+0x14c>
}
     ab6:	70e2                	ld	ra,56(sp)
     ab8:	7442                	ld	s0,48(sp)
     aba:	74a2                	ld	s1,40(sp)
     abc:	7902                	ld	s2,32(sp)
     abe:	69e2                	ld	s3,24(sp)
     ac0:	6a42                	ld	s4,16(sp)
     ac2:	6aa2                	ld	s5,8(sp)
     ac4:	6121                	addi	sp,sp,64
     ac6:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     ac8:	8626                	mv	a2,s1
     aca:	85d6                	mv	a1,s5
     acc:	00005517          	auipc	a0,0x5
     ad0:	1d450513          	addi	a0,a0,468 # 5ca0 <malloc+0x5a8>
     ad4:	371040ef          	jal	5644 <printf>
        exit(1);
     ad8:	4505                	li	a0,1
     ada:	73a040ef          	jal	5214 <exit>
      printf("%s: read failed %d\n", s, i);
     ade:	862a                	mv	a2,a0
     ae0:	85d6                	mv	a1,s5
     ae2:	00005517          	auipc	a0,0x5
     ae6:	1e650513          	addi	a0,a0,486 # 5cc8 <malloc+0x5d0>
     aea:	35b040ef          	jal	5644 <printf>
      exit(1);
     aee:	4505                	li	a0,1
     af0:	724040ef          	jal	5214 <exit>
      printf("%s: read content of block %d is %d\n", s, n, ((int *)buf)[0]);
     af4:	8626                	mv	a2,s1
     af6:	85d6                	mv	a1,s5
     af8:	00005517          	auipc	a0,0x5
     afc:	1e850513          	addi	a0,a0,488 # 5ce0 <malloc+0x5e8>
     b00:	345040ef          	jal	5644 <printf>
      exit(1);
     b04:	4505                	li	a0,1
     b06:	70e040ef          	jal	5214 <exit>
    printf("%s: unlink big failed\n", s);
     b0a:	85d6                	mv	a1,s5
     b0c:	00005517          	auipc	a0,0x5
     b10:	1fc50513          	addi	a0,a0,508 # 5d08 <malloc+0x610>
     b14:	331040ef          	jal	5644 <printf>
    exit(1);
     b18:	4505                	li	a0,1
     b1a:	6fa040ef          	jal	5214 <exit>

0000000000000b1e <unlinkread>:
{
     b1e:	7179                	addi	sp,sp,-48
     b20:	f406                	sd	ra,40(sp)
     b22:	f022                	sd	s0,32(sp)
     b24:	ec26                	sd	s1,24(sp)
     b26:	e84a                	sd	s2,16(sp)
     b28:	e44e                	sd	s3,8(sp)
     b2a:	1800                	addi	s0,sp,48
     b2c:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b2e:	20200593          	li	a1,514
     b32:	00005517          	auipc	a0,0x5
     b36:	1ee50513          	addi	a0,a0,494 # 5d20 <malloc+0x628>
     b3a:	71a040ef          	jal	5254 <open>
  if (fd < 0) {
     b3e:	0a054f63          	bltz	a0,bfc <unlinkread+0xde>
     b42:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b44:	4615                	li	a2,5
     b46:	00005597          	auipc	a1,0x5
     b4a:	20a58593          	addi	a1,a1,522 # 5d50 <malloc+0x658>
     b4e:	6e6040ef          	jal	5234 <write>
  close(fd);
     b52:	8526                	mv	a0,s1
     b54:	6e8040ef          	jal	523c <close>
  fd = open("unlinkread", O_RDWR);
     b58:	4589                	li	a1,2
     b5a:	00005517          	auipc	a0,0x5
     b5e:	1c650513          	addi	a0,a0,454 # 5d20 <malloc+0x628>
     b62:	6f2040ef          	jal	5254 <open>
     b66:	84aa                	mv	s1,a0
  if (fd < 0) {
     b68:	0a054463          	bltz	a0,c10 <unlinkread+0xf2>
  if (unlink("unlinkread") != 0) {
     b6c:	00005517          	auipc	a0,0x5
     b70:	1b450513          	addi	a0,a0,436 # 5d20 <malloc+0x628>
     b74:	6f0040ef          	jal	5264 <unlink>
     b78:	e555                	bnez	a0,c24 <unlinkread+0x106>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     b7a:	20200593          	li	a1,514
     b7e:	00005517          	auipc	a0,0x5
     b82:	1a250513          	addi	a0,a0,418 # 5d20 <malloc+0x628>
     b86:	6ce040ef          	jal	5254 <open>
     b8a:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     b8c:	460d                	li	a2,3
     b8e:	00005597          	auipc	a1,0x5
     b92:	20a58593          	addi	a1,a1,522 # 5d98 <malloc+0x6a0>
     b96:	69e040ef          	jal	5234 <write>
  close(fd1);
     b9a:	854a                	mv	a0,s2
     b9c:	6a0040ef          	jal	523c <close>
  if (read(fd, buf, sizeof(buf)) != SZ) {
     ba0:	660d                	lui	a2,0x3
     ba2:	0000d597          	auipc	a1,0xd
     ba6:	14658593          	addi	a1,a1,326 # dce8 <buf>
     baa:	8526                	mv	a0,s1
     bac:	680040ef          	jal	522c <read>
     bb0:	4795                	li	a5,5
     bb2:	08f51363          	bne	a0,a5,c38 <unlinkread+0x11a>
  if (buf[0] != 'h') {
     bb6:	0000d717          	auipc	a4,0xd
     bba:	13274703          	lbu	a4,306(a4) # dce8 <buf>
     bbe:	06800793          	li	a5,104
     bc2:	08f71563          	bne	a4,a5,c4c <unlinkread+0x12e>
  if (write(fd, buf, 10) != 10) {
     bc6:	4629                	li	a2,10
     bc8:	0000d597          	auipc	a1,0xd
     bcc:	12058593          	addi	a1,a1,288 # dce8 <buf>
     bd0:	8526                	mv	a0,s1
     bd2:	662040ef          	jal	5234 <write>
     bd6:	47a9                	li	a5,10
     bd8:	08f51463          	bne	a0,a5,c60 <unlinkread+0x142>
  close(fd);
     bdc:	8526                	mv	a0,s1
     bde:	65e040ef          	jal	523c <close>
  unlink("unlinkread");
     be2:	00005517          	auipc	a0,0x5
     be6:	13e50513          	addi	a0,a0,318 # 5d20 <malloc+0x628>
     bea:	67a040ef          	jal	5264 <unlink>
}
     bee:	70a2                	ld	ra,40(sp)
     bf0:	7402                	ld	s0,32(sp)
     bf2:	64e2                	ld	s1,24(sp)
     bf4:	6942                	ld	s2,16(sp)
     bf6:	69a2                	ld	s3,8(sp)
     bf8:	6145                	addi	sp,sp,48
     bfa:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     bfc:	85ce                	mv	a1,s3
     bfe:	00005517          	auipc	a0,0x5
     c02:	13250513          	addi	a0,a0,306 # 5d30 <malloc+0x638>
     c06:	23f040ef          	jal	5644 <printf>
    exit(1);
     c0a:	4505                	li	a0,1
     c0c:	608040ef          	jal	5214 <exit>
    printf("%s: open unlinkread failed\n", s);
     c10:	85ce                	mv	a1,s3
     c12:	00005517          	auipc	a0,0x5
     c16:	14650513          	addi	a0,a0,326 # 5d58 <malloc+0x660>
     c1a:	22b040ef          	jal	5644 <printf>
    exit(1);
     c1e:	4505                	li	a0,1
     c20:	5f4040ef          	jal	5214 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     c24:	85ce                	mv	a1,s3
     c26:	00005517          	auipc	a0,0x5
     c2a:	15250513          	addi	a0,a0,338 # 5d78 <malloc+0x680>
     c2e:	217040ef          	jal	5644 <printf>
    exit(1);
     c32:	4505                	li	a0,1
     c34:	5e0040ef          	jal	5214 <exit>
    printf("%s: unlinkread read failed", s);
     c38:	85ce                	mv	a1,s3
     c3a:	00005517          	auipc	a0,0x5
     c3e:	16650513          	addi	a0,a0,358 # 5da0 <malloc+0x6a8>
     c42:	203040ef          	jal	5644 <printf>
    exit(1);
     c46:	4505                	li	a0,1
     c48:	5cc040ef          	jal	5214 <exit>
    printf("%s: unlinkread wrong data\n", s);
     c4c:	85ce                	mv	a1,s3
     c4e:	00005517          	auipc	a0,0x5
     c52:	17250513          	addi	a0,a0,370 # 5dc0 <malloc+0x6c8>
     c56:	1ef040ef          	jal	5644 <printf>
    exit(1);
     c5a:	4505                	li	a0,1
     c5c:	5b8040ef          	jal	5214 <exit>
    printf("%s: unlinkread write failed\n", s);
     c60:	85ce                	mv	a1,s3
     c62:	00005517          	auipc	a0,0x5
     c66:	17e50513          	addi	a0,a0,382 # 5de0 <malloc+0x6e8>
     c6a:	1db040ef          	jal	5644 <printf>
    exit(1);
     c6e:	4505                	li	a0,1
     c70:	5a4040ef          	jal	5214 <exit>

0000000000000c74 <linktest>:
{
     c74:	1101                	addi	sp,sp,-32
     c76:	ec06                	sd	ra,24(sp)
     c78:	e822                	sd	s0,16(sp)
     c7a:	e426                	sd	s1,8(sp)
     c7c:	e04a                	sd	s2,0(sp)
     c7e:	1000                	addi	s0,sp,32
     c80:	892a                	mv	s2,a0
  unlink("lf1");
     c82:	00005517          	auipc	a0,0x5
     c86:	17e50513          	addi	a0,a0,382 # 5e00 <malloc+0x708>
     c8a:	5da040ef          	jal	5264 <unlink>
  unlink("lf2");
     c8e:	00005517          	auipc	a0,0x5
     c92:	17a50513          	addi	a0,a0,378 # 5e08 <malloc+0x710>
     c96:	5ce040ef          	jal	5264 <unlink>
  fd = open("lf1", O_CREATE | O_RDWR);
     c9a:	20200593          	li	a1,514
     c9e:	00005517          	auipc	a0,0x5
     ca2:	16250513          	addi	a0,a0,354 # 5e00 <malloc+0x708>
     ca6:	5ae040ef          	jal	5254 <open>
  if (fd < 0) {
     caa:	0c054f63          	bltz	a0,d88 <linktest+0x114>
     cae:	84aa                	mv	s1,a0
  if (write(fd, "hello", SZ) != SZ) {
     cb0:	4615                	li	a2,5
     cb2:	00005597          	auipc	a1,0x5
     cb6:	09e58593          	addi	a1,a1,158 # 5d50 <malloc+0x658>
     cba:	57a040ef          	jal	5234 <write>
     cbe:	4795                	li	a5,5
     cc0:	0cf51e63          	bne	a0,a5,d9c <linktest+0x128>
  close(fd);
     cc4:	8526                	mv	a0,s1
     cc6:	576040ef          	jal	523c <close>
  if (link("lf1", "lf2") < 0) {
     cca:	00005597          	auipc	a1,0x5
     cce:	13e58593          	addi	a1,a1,318 # 5e08 <malloc+0x710>
     cd2:	00005517          	auipc	a0,0x5
     cd6:	12e50513          	addi	a0,a0,302 # 5e00 <malloc+0x708>
     cda:	59a040ef          	jal	5274 <link>
     cde:	0c054963          	bltz	a0,db0 <linktest+0x13c>
  unlink("lf1");
     ce2:	00005517          	auipc	a0,0x5
     ce6:	11e50513          	addi	a0,a0,286 # 5e00 <malloc+0x708>
     cea:	57a040ef          	jal	5264 <unlink>
  if (open("lf1", 0) >= 0) {
     cee:	4581                	li	a1,0
     cf0:	00005517          	auipc	a0,0x5
     cf4:	11050513          	addi	a0,a0,272 # 5e00 <malloc+0x708>
     cf8:	55c040ef          	jal	5254 <open>
     cfc:	0c055463          	bgez	a0,dc4 <linktest+0x150>
  fd = open("lf2", 0);
     d00:	4581                	li	a1,0
     d02:	00005517          	auipc	a0,0x5
     d06:	10650513          	addi	a0,a0,262 # 5e08 <malloc+0x710>
     d0a:	54a040ef          	jal	5254 <open>
     d0e:	84aa                	mv	s1,a0
  if (fd < 0) {
     d10:	0c054463          	bltz	a0,dd8 <linktest+0x164>
  if (read(fd, buf, sizeof(buf)) != SZ) {
     d14:	660d                	lui	a2,0x3
     d16:	0000d597          	auipc	a1,0xd
     d1a:	fd258593          	addi	a1,a1,-46 # dce8 <buf>
     d1e:	50e040ef          	jal	522c <read>
     d22:	4795                	li	a5,5
     d24:	0cf51463          	bne	a0,a5,dec <linktest+0x178>
  close(fd);
     d28:	8526                	mv	a0,s1
     d2a:	512040ef          	jal	523c <close>
  if (link("lf2", "lf2") >= 0) {
     d2e:	00005597          	auipc	a1,0x5
     d32:	0da58593          	addi	a1,a1,218 # 5e08 <malloc+0x710>
     d36:	852e                	mv	a0,a1
     d38:	53c040ef          	jal	5274 <link>
     d3c:	0c055263          	bgez	a0,e00 <linktest+0x18c>
  unlink("lf2");
     d40:	00005517          	auipc	a0,0x5
     d44:	0c850513          	addi	a0,a0,200 # 5e08 <malloc+0x710>
     d48:	51c040ef          	jal	5264 <unlink>
  if (link("lf2", "lf1") >= 0) {
     d4c:	00005597          	auipc	a1,0x5
     d50:	0b458593          	addi	a1,a1,180 # 5e00 <malloc+0x708>
     d54:	00005517          	auipc	a0,0x5
     d58:	0b450513          	addi	a0,a0,180 # 5e08 <malloc+0x710>
     d5c:	518040ef          	jal	5274 <link>
     d60:	0a055a63          	bgez	a0,e14 <linktest+0x1a0>
  if (link(".", "lf1") >= 0) {
     d64:	00005597          	auipc	a1,0x5
     d68:	09c58593          	addi	a1,a1,156 # 5e00 <malloc+0x708>
     d6c:	00005517          	auipc	a0,0x5
     d70:	1a450513          	addi	a0,a0,420 # 5f10 <malloc+0x818>
     d74:	500040ef          	jal	5274 <link>
     d78:	0a055863          	bgez	a0,e28 <linktest+0x1b4>
}
     d7c:	60e2                	ld	ra,24(sp)
     d7e:	6442                	ld	s0,16(sp)
     d80:	64a2                	ld	s1,8(sp)
     d82:	6902                	ld	s2,0(sp)
     d84:	6105                	addi	sp,sp,32
     d86:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     d88:	85ca                	mv	a1,s2
     d8a:	00005517          	auipc	a0,0x5
     d8e:	08650513          	addi	a0,a0,134 # 5e10 <malloc+0x718>
     d92:	0b3040ef          	jal	5644 <printf>
    exit(1);
     d96:	4505                	li	a0,1
     d98:	47c040ef          	jal	5214 <exit>
    printf("%s: write lf1 failed\n", s);
     d9c:	85ca                	mv	a1,s2
     d9e:	00005517          	auipc	a0,0x5
     da2:	08a50513          	addi	a0,a0,138 # 5e28 <malloc+0x730>
     da6:	09f040ef          	jal	5644 <printf>
    exit(1);
     daa:	4505                	li	a0,1
     dac:	468040ef          	jal	5214 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     db0:	85ca                	mv	a1,s2
     db2:	00005517          	auipc	a0,0x5
     db6:	08e50513          	addi	a0,a0,142 # 5e40 <malloc+0x748>
     dba:	08b040ef          	jal	5644 <printf>
    exit(1);
     dbe:	4505                	li	a0,1
     dc0:	454040ef          	jal	5214 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     dc4:	85ca                	mv	a1,s2
     dc6:	00005517          	auipc	a0,0x5
     dca:	09a50513          	addi	a0,a0,154 # 5e60 <malloc+0x768>
     dce:	077040ef          	jal	5644 <printf>
    exit(1);
     dd2:	4505                	li	a0,1
     dd4:	440040ef          	jal	5214 <exit>
    printf("%s: open lf2 failed\n", s);
     dd8:	85ca                	mv	a1,s2
     dda:	00005517          	auipc	a0,0x5
     dde:	0b650513          	addi	a0,a0,182 # 5e90 <malloc+0x798>
     de2:	063040ef          	jal	5644 <printf>
    exit(1);
     de6:	4505                	li	a0,1
     de8:	42c040ef          	jal	5214 <exit>
    printf("%s: read lf2 failed\n", s);
     dec:	85ca                	mv	a1,s2
     dee:	00005517          	auipc	a0,0x5
     df2:	0ba50513          	addi	a0,a0,186 # 5ea8 <malloc+0x7b0>
     df6:	04f040ef          	jal	5644 <printf>
    exit(1);
     dfa:	4505                	li	a0,1
     dfc:	418040ef          	jal	5214 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     e00:	85ca                	mv	a1,s2
     e02:	00005517          	auipc	a0,0x5
     e06:	0be50513          	addi	a0,a0,190 # 5ec0 <malloc+0x7c8>
     e0a:	03b040ef          	jal	5644 <printf>
    exit(1);
     e0e:	4505                	li	a0,1
     e10:	404040ef          	jal	5214 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     e14:	85ca                	mv	a1,s2
     e16:	00005517          	auipc	a0,0x5
     e1a:	0d250513          	addi	a0,a0,210 # 5ee8 <malloc+0x7f0>
     e1e:	027040ef          	jal	5644 <printf>
    exit(1);
     e22:	4505                	li	a0,1
     e24:	3f0040ef          	jal	5214 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     e28:	85ca                	mv	a1,s2
     e2a:	00005517          	auipc	a0,0x5
     e2e:	0ee50513          	addi	a0,a0,238 # 5f18 <malloc+0x820>
     e32:	013040ef          	jal	5644 <printf>
    exit(1);
     e36:	4505                	li	a0,1
     e38:	3dc040ef          	jal	5214 <exit>

0000000000000e3c <validatetest>:
{
     e3c:	7139                	addi	sp,sp,-64
     e3e:	fc06                	sd	ra,56(sp)
     e40:	f822                	sd	s0,48(sp)
     e42:	f426                	sd	s1,40(sp)
     e44:	f04a                	sd	s2,32(sp)
     e46:	ec4e                	sd	s3,24(sp)
     e48:	e852                	sd	s4,16(sp)
     e4a:	e456                	sd	s5,8(sp)
     e4c:	e05a                	sd	s6,0(sp)
     e4e:	0080                	addi	s0,sp,64
     e50:	8b2a                	mv	s6,a0
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
     e52:	4481                	li	s1,0
    if (link("nosuchfile", (char *)p) != -1) {
     e54:	00005997          	auipc	s3,0x5
     e58:	0e498993          	addi	s3,s3,228 # 5f38 <malloc+0x840>
     e5c:	597d                	li	s2,-1
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
     e5e:	6a85                	lui	s5,0x1
     e60:	00114a37          	lui	s4,0x114
    if (link("nosuchfile", (char *)p) != -1) {
     e64:	85a6                	mv	a1,s1
     e66:	854e                	mv	a0,s3
     e68:	40c040ef          	jal	5274 <link>
     e6c:	01251f63          	bne	a0,s2,e8a <validatetest+0x4e>
  for (p = 0; p <= (uint)hi; p += PGSIZE) {
     e70:	94d6                	add	s1,s1,s5
     e72:	ff4499e3          	bne	s1,s4,e64 <validatetest+0x28>
}
     e76:	70e2                	ld	ra,56(sp)
     e78:	7442                	ld	s0,48(sp)
     e7a:	74a2                	ld	s1,40(sp)
     e7c:	7902                	ld	s2,32(sp)
     e7e:	69e2                	ld	s3,24(sp)
     e80:	6a42                	ld	s4,16(sp)
     e82:	6aa2                	ld	s5,8(sp)
     e84:	6b02                	ld	s6,0(sp)
     e86:	6121                	addi	sp,sp,64
     e88:	8082                	ret
      printf("%s: link should not succeed\n", s);
     e8a:	85da                	mv	a1,s6
     e8c:	00005517          	auipc	a0,0x5
     e90:	0bc50513          	addi	a0,a0,188 # 5f48 <malloc+0x850>
     e94:	7b0040ef          	jal	5644 <printf>
      exit(1);
     e98:	4505                	li	a0,1
     e9a:	37a040ef          	jal	5214 <exit>

0000000000000e9e <bigdir>:
{
     e9e:	715d                	addi	sp,sp,-80
     ea0:	e486                	sd	ra,72(sp)
     ea2:	e0a2                	sd	s0,64(sp)
     ea4:	fc26                	sd	s1,56(sp)
     ea6:	f84a                	sd	s2,48(sp)
     ea8:	f44e                	sd	s3,40(sp)
     eaa:	f052                	sd	s4,32(sp)
     eac:	ec56                	sd	s5,24(sp)
     eae:	e85a                	sd	s6,16(sp)
     eb0:	0880                	addi	s0,sp,80
     eb2:	89aa                	mv	s3,a0
  unlink("bd");
     eb4:	00005517          	auipc	a0,0x5
     eb8:	0b450513          	addi	a0,a0,180 # 5f68 <malloc+0x870>
     ebc:	3a8040ef          	jal	5264 <unlink>
  fd = open("bd", O_CREATE);
     ec0:	20000593          	li	a1,512
     ec4:	00005517          	auipc	a0,0x5
     ec8:	0a450513          	addi	a0,a0,164 # 5f68 <malloc+0x870>
     ecc:	388040ef          	jal	5254 <open>
  if (fd < 0) {
     ed0:	0c054163          	bltz	a0,f92 <bigdir+0xf4>
  close(fd);
     ed4:	368040ef          	jal	523c <close>
  for (i = 0; i < N; i++) {
     ed8:	4901                	li	s2,0
    name[0] = 'x';
     eda:	07800a93          	li	s5,120
    if (link("bd", name) != 0) {
     ede:	00005a17          	auipc	s4,0x5
     ee2:	08aa0a13          	addi	s4,s4,138 # 5f68 <malloc+0x870>
  for (i = 0; i < N; i++) {
     ee6:	1f400b13          	li	s6,500
    name[0] = 'x';
     eea:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
     eee:	41f9571b          	sraiw	a4,s2,0x1f
     ef2:	01a7571b          	srliw	a4,a4,0x1a
     ef6:	012707bb          	addw	a5,a4,s2
     efa:	4067d69b          	sraiw	a3,a5,0x6
     efe:	0306869b          	addiw	a3,a3,48
     f02:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     f06:	03f7f793          	andi	a5,a5,63
     f0a:	9f99                	subw	a5,a5,a4
     f0c:	0307879b          	addiw	a5,a5,48
     f10:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     f14:	fa0409a3          	sb	zero,-77(s0)
    if (link("bd", name) != 0) {
     f18:	fb040593          	addi	a1,s0,-80
     f1c:	8552                	mv	a0,s4
     f1e:	356040ef          	jal	5274 <link>
     f22:	84aa                	mv	s1,a0
     f24:	e149                	bnez	a0,fa6 <bigdir+0x108>
  for (i = 0; i < N; i++) {
     f26:	2905                	addiw	s2,s2,1
     f28:	fd6911e3          	bne	s2,s6,eea <bigdir+0x4c>
  unlink("bd");
     f2c:	00005517          	auipc	a0,0x5
     f30:	03c50513          	addi	a0,a0,60 # 5f68 <malloc+0x870>
     f34:	330040ef          	jal	5264 <unlink>
    name[0] = 'x';
     f38:	07800913          	li	s2,120
  for (i = 0; i < N; i++) {
     f3c:	1f400a13          	li	s4,500
    name[0] = 'x';
     f40:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
     f44:	41f4d71b          	sraiw	a4,s1,0x1f
     f48:	01a7571b          	srliw	a4,a4,0x1a
     f4c:	009707bb          	addw	a5,a4,s1
     f50:	4067d69b          	sraiw	a3,a5,0x6
     f54:	0306869b          	addiw	a3,a3,48
     f58:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     f5c:	03f7f793          	andi	a5,a5,63
     f60:	9f99                	subw	a5,a5,a4
     f62:	0307879b          	addiw	a5,a5,48
     f66:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     f6a:	fa0409a3          	sb	zero,-77(s0)
    if (unlink(name) != 0) {
     f6e:	fb040513          	addi	a0,s0,-80
     f72:	2f2040ef          	jal	5264 <unlink>
     f76:	e529                	bnez	a0,fc0 <bigdir+0x122>
  for (i = 0; i < N; i++) {
     f78:	2485                	addiw	s1,s1,1
     f7a:	fd4493e3          	bne	s1,s4,f40 <bigdir+0xa2>
}
     f7e:	60a6                	ld	ra,72(sp)
     f80:	6406                	ld	s0,64(sp)
     f82:	74e2                	ld	s1,56(sp)
     f84:	7942                	ld	s2,48(sp)
     f86:	79a2                	ld	s3,40(sp)
     f88:	7a02                	ld	s4,32(sp)
     f8a:	6ae2                	ld	s5,24(sp)
     f8c:	6b42                	ld	s6,16(sp)
     f8e:	6161                	addi	sp,sp,80
     f90:	8082                	ret
    printf("%s: bigdir create failed\n", s);
     f92:	85ce                	mv	a1,s3
     f94:	00005517          	auipc	a0,0x5
     f98:	fdc50513          	addi	a0,a0,-36 # 5f70 <malloc+0x878>
     f9c:	6a8040ef          	jal	5644 <printf>
    exit(1);
     fa0:	4505                	li	a0,1
     fa2:	272040ef          	jal	5214 <exit>
      printf("%s: bigdir i=%d link(bd, %s) failed\n", s, i, name);
     fa6:	fb040693          	addi	a3,s0,-80
     faa:	864a                	mv	a2,s2
     fac:	85ce                	mv	a1,s3
     fae:	00005517          	auipc	a0,0x5
     fb2:	fe250513          	addi	a0,a0,-30 # 5f90 <malloc+0x898>
     fb6:	68e040ef          	jal	5644 <printf>
      exit(1);
     fba:	4505                	li	a0,1
     fbc:	258040ef          	jal	5214 <exit>
      printf("%s: bigdir unlink failed", s);
     fc0:	85ce                	mv	a1,s3
     fc2:	00005517          	auipc	a0,0x5
     fc6:	ff650513          	addi	a0,a0,-10 # 5fb8 <malloc+0x8c0>
     fca:	67a040ef          	jal	5644 <printf>
      exit(1);
     fce:	4505                	li	a0,1
     fd0:	244040ef          	jal	5214 <exit>

0000000000000fd4 <pgbug>:
{
     fd4:	7179                	addi	sp,sp,-48
     fd6:	f406                	sd	ra,40(sp)
     fd8:	f022                	sd	s0,32(sp)
     fda:	ec26                	sd	s1,24(sp)
     fdc:	1800                	addi	s0,sp,48
  argv[0] = 0;
     fde:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
     fe2:	00009497          	auipc	s1,0x9
     fe6:	01e48493          	addi	s1,s1,30 # a000 <big>
     fea:	fd840593          	addi	a1,s0,-40
     fee:	6088                	ld	a0,0(s1)
     ff0:	25c040ef          	jal	524c <exec>
  pipe(big);
     ff4:	6088                	ld	a0,0(s1)
     ff6:	22e040ef          	jal	5224 <pipe>
  exit(0);
     ffa:	4501                	li	a0,0
     ffc:	218040ef          	jal	5214 <exit>

0000000000001000 <badarg>:
{
    1000:	7139                	addi	sp,sp,-64
    1002:	fc06                	sd	ra,56(sp)
    1004:	f822                	sd	s0,48(sp)
    1006:	f426                	sd	s1,40(sp)
    1008:	f04a                	sd	s2,32(sp)
    100a:	ec4e                	sd	s3,24(sp)
    100c:	0080                	addi	s0,sp,64
    100e:	64b1                	lui	s1,0xc
    1010:	35048493          	addi	s1,s1,848 # c350 <uninit+0xd78>
    argv[0] = (char *)0xffffffff;
    1014:	597d                	li	s2,-1
    1016:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    101a:	00005997          	auipc	s3,0x5
    101e:	80e98993          	addi	s3,s3,-2034 # 5828 <malloc+0x130>
    argv[0] = (char *)0xffffffff;
    1022:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1026:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    102a:	fc040593          	addi	a1,s0,-64
    102e:	854e                	mv	a0,s3
    1030:	21c040ef          	jal	524c <exec>
  for (int i = 0; i < 50000; i++) {
    1034:	34fd                	addiw	s1,s1,-1
    1036:	f4f5                	bnez	s1,1022 <badarg+0x22>
  exit(0);
    1038:	4501                	li	a0,0
    103a:	1da040ef          	jal	5214 <exit>

000000000000103e <copyinstr2>:
{
    103e:	7155                	addi	sp,sp,-208
    1040:	e586                	sd	ra,200(sp)
    1042:	e1a2                	sd	s0,192(sp)
    1044:	0980                	addi	s0,sp,208
  for (int i = 0; i < MAXPATH; i++)
    1046:	f6840793          	addi	a5,s0,-152
    104a:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    104e:	07800713          	li	a4,120
    1052:	00e78023          	sb	a4,0(a5)
  for (int i = 0; i < MAXPATH; i++)
    1056:	0785                	addi	a5,a5,1
    1058:	fed79de3          	bne	a5,a3,1052 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    105c:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    1060:	f6840513          	addi	a0,s0,-152
    1064:	200040ef          	jal	5264 <unlink>
  if (ret != -1) {
    1068:	57fd                	li	a5,-1
    106a:	0cf51263          	bne	a0,a5,112e <copyinstr2+0xf0>
  int fd = open(b, O_CREATE | O_WRONLY);
    106e:	20100593          	li	a1,513
    1072:	f6840513          	addi	a0,s0,-152
    1076:	1de040ef          	jal	5254 <open>
  if (fd != -1) {
    107a:	57fd                	li	a5,-1
    107c:	0cf51563          	bne	a0,a5,1146 <copyinstr2+0x108>
  ret = link(b, b);
    1080:	f6840593          	addi	a1,s0,-152
    1084:	852e                	mv	a0,a1
    1086:	1ee040ef          	jal	5274 <link>
  if (ret != -1) {
    108a:	57fd                	li	a5,-1
    108c:	0cf51963          	bne	a0,a5,115e <copyinstr2+0x120>
  char *args[] = {"xx", 0};
    1090:	00006797          	auipc	a5,0x6
    1094:	01078793          	addi	a5,a5,16 # 70a0 <malloc+0x19a8>
    1098:	f4f43c23          	sd	a5,-168(s0)
    109c:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    10a0:	f5840593          	addi	a1,s0,-168
    10a4:	f6840513          	addi	a0,s0,-152
    10a8:	1a4040ef          	jal	524c <exec>
  if (ret != -1) {
    10ac:	57fd                	li	a5,-1
    10ae:	0cf51563          	bne	a0,a5,1178 <copyinstr2+0x13a>
  int pid = fork();
    10b2:	15a040ef          	jal	520c <fork>
  if (pid < 0) {
    10b6:	0c054d63          	bltz	a0,1190 <copyinstr2+0x152>
  if (pid == 0) {
    10ba:	0e051863          	bnez	a0,11aa <copyinstr2+0x16c>
    10be:	00009797          	auipc	a5,0x9
    10c2:	51278793          	addi	a5,a5,1298 # a5d0 <big.0>
    10c6:	0000a697          	auipc	a3,0xa
    10ca:	50a68693          	addi	a3,a3,1290 # b5d0 <big.0+0x1000>
      big[i] = 'x';
    10ce:	07800713          	li	a4,120
    10d2:	00e78023          	sb	a4,0(a5)
    for (int i = 0; i < PGSIZE; i++)
    10d6:	0785                	addi	a5,a5,1
    10d8:	fed79de3          	bne	a5,a3,10d2 <copyinstr2+0x94>
    big[PGSIZE] = '\0';
    10dc:	0000a797          	auipc	a5,0xa
    10e0:	4e078a23          	sb	zero,1268(a5) # b5d0 <big.0+0x1000>
    char *args2[] = {big, big, big, 0};
    10e4:	00007797          	auipc	a5,0x7
    10e8:	f4478793          	addi	a5,a5,-188 # 8028 <malloc+0x2930>
    10ec:	6fb0                	ld	a2,88(a5)
    10ee:	73b4                	ld	a3,96(a5)
    10f0:	77b8                	ld	a4,104(a5)
    10f2:	7bbc                	ld	a5,112(a5)
    10f4:	f2c43823          	sd	a2,-208(s0)
    10f8:	f2d43c23          	sd	a3,-200(s0)
    10fc:	f4e43023          	sd	a4,-192(s0)
    1100:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1104:	f3040593          	addi	a1,s0,-208
    1108:	00004517          	auipc	a0,0x4
    110c:	72050513          	addi	a0,a0,1824 # 5828 <malloc+0x130>
    1110:	13c040ef          	jal	524c <exec>
    if (ret != -1) {
    1114:	57fd                	li	a5,-1
    1116:	08f50663          	beq	a0,a5,11a2 <copyinstr2+0x164>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    111a:	55fd                	li	a1,-1
    111c:	00005517          	auipc	a0,0x5
    1120:	f4450513          	addi	a0,a0,-188 # 6060 <malloc+0x968>
    1124:	520040ef          	jal	5644 <printf>
      exit(1);
    1128:	4505                	li	a0,1
    112a:	0ea040ef          	jal	5214 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    112e:	862a                	mv	a2,a0
    1130:	f6840593          	addi	a1,s0,-152
    1134:	00005517          	auipc	a0,0x5
    1138:	ea450513          	addi	a0,a0,-348 # 5fd8 <malloc+0x8e0>
    113c:	508040ef          	jal	5644 <printf>
    exit(1);
    1140:	4505                	li	a0,1
    1142:	0d2040ef          	jal	5214 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1146:	862a                	mv	a2,a0
    1148:	f6840593          	addi	a1,s0,-152
    114c:	00005517          	auipc	a0,0x5
    1150:	eac50513          	addi	a0,a0,-340 # 5ff8 <malloc+0x900>
    1154:	4f0040ef          	jal	5644 <printf>
    exit(1);
    1158:	4505                	li	a0,1
    115a:	0ba040ef          	jal	5214 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    115e:	86aa                	mv	a3,a0
    1160:	f6840613          	addi	a2,s0,-152
    1164:	85b2                	mv	a1,a2
    1166:	00005517          	auipc	a0,0x5
    116a:	eb250513          	addi	a0,a0,-334 # 6018 <malloc+0x920>
    116e:	4d6040ef          	jal	5644 <printf>
    exit(1);
    1172:	4505                	li	a0,1
    1174:	0a0040ef          	jal	5214 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1178:	567d                	li	a2,-1
    117a:	f6840593          	addi	a1,s0,-152
    117e:	00005517          	auipc	a0,0x5
    1182:	ec250513          	addi	a0,a0,-318 # 6040 <malloc+0x948>
    1186:	4be040ef          	jal	5644 <printf>
    exit(1);
    118a:	4505                	li	a0,1
    118c:	088040ef          	jal	5214 <exit>
    printf("fork failed\n");
    1190:	00006517          	auipc	a0,0x6
    1194:	5e850513          	addi	a0,a0,1512 # 7778 <malloc+0x2080>
    1198:	4ac040ef          	jal	5644 <printf>
    exit(1);
    119c:	4505                	li	a0,1
    119e:	076040ef          	jal	5214 <exit>
    exit(747); // OK
    11a2:	2eb00513          	li	a0,747
    11a6:	06e040ef          	jal	5214 <exit>
  int st = 0;
    11aa:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    11ae:	f5440513          	addi	a0,s0,-172
    11b2:	06a040ef          	jal	521c <wait>
  if (st != 747) {
    11b6:	f5442703          	lw	a4,-172(s0)
    11ba:	2eb00793          	li	a5,747
    11be:	00f71663          	bne	a4,a5,11ca <copyinstr2+0x18c>
}
    11c2:	60ae                	ld	ra,200(sp)
    11c4:	640e                	ld	s0,192(sp)
    11c6:	6169                	addi	sp,sp,208
    11c8:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    11ca:	00005517          	auipc	a0,0x5
    11ce:	ebe50513          	addi	a0,a0,-322 # 6088 <malloc+0x990>
    11d2:	472040ef          	jal	5644 <printf>
    exit(1);
    11d6:	4505                	li	a0,1
    11d8:	03c040ef          	jal	5214 <exit>

00000000000011dc <truncate3>:
{
    11dc:	7159                	addi	sp,sp,-112
    11de:	f486                	sd	ra,104(sp)
    11e0:	f0a2                	sd	s0,96(sp)
    11e2:	e8ca                	sd	s2,80(sp)
    11e4:	1880                	addi	s0,sp,112
    11e6:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE | O_TRUNC | O_WRONLY));
    11e8:	60100593          	li	a1,1537
    11ec:	00004517          	auipc	a0,0x4
    11f0:	69450513          	addi	a0,a0,1684 # 5880 <malloc+0x188>
    11f4:	060040ef          	jal	5254 <open>
    11f8:	044040ef          	jal	523c <close>
  pid = fork();
    11fc:	010040ef          	jal	520c <fork>
  if (pid < 0) {
    1200:	06054663          	bltz	a0,126c <truncate3+0x90>
  if (pid == 0) {
    1204:	e55d                	bnez	a0,12b2 <truncate3+0xd6>
    1206:	eca6                	sd	s1,88(sp)
    1208:	e4ce                	sd	s3,72(sp)
    120a:	e0d2                	sd	s4,64(sp)
    120c:	fc56                	sd	s5,56(sp)
    120e:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    1212:	00004a17          	auipc	s4,0x4
    1216:	66ea0a13          	addi	s4,s4,1646 # 5880 <malloc+0x188>
      int n = write(fd, "1234567890", 10);
    121a:	00005a97          	auipc	s5,0x5
    121e:	ecea8a93          	addi	s5,s5,-306 # 60e8 <malloc+0x9f0>
      int fd = open("truncfile", O_WRONLY);
    1222:	4585                	li	a1,1
    1224:	8552                	mv	a0,s4
    1226:	02e040ef          	jal	5254 <open>
    122a:	84aa                	mv	s1,a0
      if (fd < 0) {
    122c:	04054e63          	bltz	a0,1288 <truncate3+0xac>
      int n = write(fd, "1234567890", 10);
    1230:	4629                	li	a2,10
    1232:	85d6                	mv	a1,s5
    1234:	000040ef          	jal	5234 <write>
      if (n != 10) {
    1238:	47a9                	li	a5,10
    123a:	06f51163          	bne	a0,a5,129c <truncate3+0xc0>
      close(fd);
    123e:	8526                	mv	a0,s1
    1240:	7fd030ef          	jal	523c <close>
      fd = open("truncfile", O_RDONLY);
    1244:	4581                	li	a1,0
    1246:	8552                	mv	a0,s4
    1248:	00c040ef          	jal	5254 <open>
    124c:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    124e:	02000613          	li	a2,32
    1252:	f9840593          	addi	a1,s0,-104
    1256:	7d7030ef          	jal	522c <read>
      close(fd);
    125a:	8526                	mv	a0,s1
    125c:	7e1030ef          	jal	523c <close>
    for (int i = 0; i < 100; i++) {
    1260:	39fd                	addiw	s3,s3,-1
    1262:	fc0990e3          	bnez	s3,1222 <truncate3+0x46>
    exit(0);
    1266:	4501                	li	a0,0
    1268:	7ad030ef          	jal	5214 <exit>
    126c:	eca6                	sd	s1,88(sp)
    126e:	e4ce                	sd	s3,72(sp)
    1270:	e0d2                	sd	s4,64(sp)
    1272:	fc56                	sd	s5,56(sp)
    printf("%s: fork failed\n", s);
    1274:	85ca                	mv	a1,s2
    1276:	00005517          	auipc	a0,0x5
    127a:	e4250513          	addi	a0,a0,-446 # 60b8 <malloc+0x9c0>
    127e:	3c6040ef          	jal	5644 <printf>
    exit(1);
    1282:	4505                	li	a0,1
    1284:	791030ef          	jal	5214 <exit>
        printf("%s: open failed\n", s);
    1288:	85ca                	mv	a1,s2
    128a:	00005517          	auipc	a0,0x5
    128e:	e4650513          	addi	a0,a0,-442 # 60d0 <malloc+0x9d8>
    1292:	3b2040ef          	jal	5644 <printf>
        exit(1);
    1296:	4505                	li	a0,1
    1298:	77d030ef          	jal	5214 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    129c:	862a                	mv	a2,a0
    129e:	85ca                	mv	a1,s2
    12a0:	00005517          	auipc	a0,0x5
    12a4:	e5850513          	addi	a0,a0,-424 # 60f8 <malloc+0xa00>
    12a8:	39c040ef          	jal	5644 <printf>
        exit(1);
    12ac:	4505                	li	a0,1
    12ae:	767030ef          	jal	5214 <exit>
    12b2:	eca6                	sd	s1,88(sp)
    12b4:	e4ce                	sd	s3,72(sp)
    12b6:	e0d2                	sd	s4,64(sp)
    12b8:	fc56                	sd	s5,56(sp)
    12ba:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
    12be:	00004a17          	auipc	s4,0x4
    12c2:	5c2a0a13          	addi	s4,s4,1474 # 5880 <malloc+0x188>
    int n = write(fd, "xxx", 3);
    12c6:	00005a97          	auipc	s5,0x5
    12ca:	e52a8a93          	addi	s5,s5,-430 # 6118 <malloc+0xa20>
    int fd = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
    12ce:	60100593          	li	a1,1537
    12d2:	8552                	mv	a0,s4
    12d4:	781030ef          	jal	5254 <open>
    12d8:	84aa                	mv	s1,a0
    if (fd < 0) {
    12da:	02054d63          	bltz	a0,1314 <truncate3+0x138>
    int n = write(fd, "xxx", 3);
    12de:	460d                	li	a2,3
    12e0:	85d6                	mv	a1,s5
    12e2:	753030ef          	jal	5234 <write>
    if (n != 3) {
    12e6:	478d                	li	a5,3
    12e8:	04f51063          	bne	a0,a5,1328 <truncate3+0x14c>
    close(fd);
    12ec:	8526                	mv	a0,s1
    12ee:	74f030ef          	jal	523c <close>
  for (int i = 0; i < 150; i++) {
    12f2:	39fd                	addiw	s3,s3,-1
    12f4:	fc099de3          	bnez	s3,12ce <truncate3+0xf2>
  wait(&xstatus);
    12f8:	fbc40513          	addi	a0,s0,-68
    12fc:	721030ef          	jal	521c <wait>
  unlink("truncfile");
    1300:	00004517          	auipc	a0,0x4
    1304:	58050513          	addi	a0,a0,1408 # 5880 <malloc+0x188>
    1308:	75d030ef          	jal	5264 <unlink>
  exit(xstatus);
    130c:	fbc42503          	lw	a0,-68(s0)
    1310:	705030ef          	jal	5214 <exit>
      printf("%s: open failed\n", s);
    1314:	85ca                	mv	a1,s2
    1316:	00005517          	auipc	a0,0x5
    131a:	dba50513          	addi	a0,a0,-582 # 60d0 <malloc+0x9d8>
    131e:	326040ef          	jal	5644 <printf>
      exit(1);
    1322:	4505                	li	a0,1
    1324:	6f1030ef          	jal	5214 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1328:	862a                	mv	a2,a0
    132a:	85ca                	mv	a1,s2
    132c:	00005517          	auipc	a0,0x5
    1330:	df450513          	addi	a0,a0,-524 # 6120 <malloc+0xa28>
    1334:	310040ef          	jal	5644 <printf>
      exit(1);
    1338:	4505                	li	a0,1
    133a:	6db030ef          	jal	5214 <exit>

000000000000133e <pipe1>:
{
    133e:	711d                	addi	sp,sp,-96
    1340:	ec86                	sd	ra,88(sp)
    1342:	e8a2                	sd	s0,80(sp)
    1344:	fc4e                	sd	s3,56(sp)
    1346:	1080                	addi	s0,sp,96
    1348:	89aa                	mv	s3,a0
  if (pipe(fds) != 0) {
    134a:	fa840513          	addi	a0,s0,-88
    134e:	6d7030ef          	jal	5224 <pipe>
    1352:	e92d                	bnez	a0,13c4 <pipe1+0x86>
    1354:	e4a6                	sd	s1,72(sp)
    1356:	f852                	sd	s4,48(sp)
    1358:	84aa                	mv	s1,a0
  pid = fork();
    135a:	6b3030ef          	jal	520c <fork>
    135e:	8a2a                	mv	s4,a0
  if (pid == 0) {
    1360:	c151                	beqz	a0,13e4 <pipe1+0xa6>
  } else if (pid > 0) {
    1362:	14a05e63          	blez	a0,14be <pipe1+0x180>
    1366:	e0ca                	sd	s2,64(sp)
    1368:	f456                	sd	s5,40(sp)
    close(fds[1]);
    136a:	fac42503          	lw	a0,-84(s0)
    136e:	6cf030ef          	jal	523c <close>
    total = 0;
    1372:	8a26                	mv	s4,s1
    cc = 1;
    1374:	4905                	li	s2,1
    while ((n = read(fds[0], buf, cc)) > 0) {
    1376:	0000da97          	auipc	s5,0xd
    137a:	972a8a93          	addi	s5,s5,-1678 # dce8 <buf>
    137e:	864a                	mv	a2,s2
    1380:	85d6                	mv	a1,s5
    1382:	fa842503          	lw	a0,-88(s0)
    1386:	6a7030ef          	jal	522c <read>
    138a:	0ea05a63          	blez	a0,147e <pipe1+0x140>
      for (i = 0; i < n; i++) {
    138e:	0000d717          	auipc	a4,0xd
    1392:	95a70713          	addi	a4,a4,-1702 # dce8 <buf>
    1396:	00a4863b          	addw	a2,s1,a0
        if ((buf[i] & 0xff) != (seq++ & 0xff)) {
    139a:	00074683          	lbu	a3,0(a4)
    139e:	0ff4f793          	zext.b	a5,s1
    13a2:	2485                	addiw	s1,s1,1
    13a4:	0af69d63          	bne	a3,a5,145e <pipe1+0x120>
      for (i = 0; i < n; i++) {
    13a8:	0705                	addi	a4,a4,1
    13aa:	fec498e3          	bne	s1,a2,139a <pipe1+0x5c>
      total += n;
    13ae:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    13b2:	0019179b          	slliw	a5,s2,0x1
    13b6:	0007891b          	sext.w	s2,a5
      if (cc > sizeof(buf))
    13ba:	670d                	lui	a4,0x3
    13bc:	fd2771e3          	bgeu	a4,s2,137e <pipe1+0x40>
        cc = sizeof(buf);
    13c0:	690d                	lui	s2,0x3
    13c2:	bf75                	j	137e <pipe1+0x40>
    13c4:	e4a6                	sd	s1,72(sp)
    13c6:	e0ca                	sd	s2,64(sp)
    13c8:	f852                	sd	s4,48(sp)
    13ca:	f456                	sd	s5,40(sp)
    13cc:	f05a                	sd	s6,32(sp)
    13ce:	ec5e                	sd	s7,24(sp)
    printf("%s: pipe() failed\n", s);
    13d0:	85ce                	mv	a1,s3
    13d2:	00005517          	auipc	a0,0x5
    13d6:	d6e50513          	addi	a0,a0,-658 # 6140 <malloc+0xa48>
    13da:	26a040ef          	jal	5644 <printf>
    exit(1);
    13de:	4505                	li	a0,1
    13e0:	635030ef          	jal	5214 <exit>
    13e4:	e0ca                	sd	s2,64(sp)
    13e6:	f456                	sd	s5,40(sp)
    13e8:	f05a                	sd	s6,32(sp)
    13ea:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    13ec:	fa842503          	lw	a0,-88(s0)
    13f0:	64d030ef          	jal	523c <close>
    for (n = 0; n < N; n++) {
    13f4:	0000db17          	auipc	s6,0xd
    13f8:	8f4b0b13          	addi	s6,s6,-1804 # dce8 <buf>
    13fc:	416004bb          	negw	s1,s6
    1400:	0ff4f493          	zext.b	s1,s1
    1404:	409b0913          	addi	s2,s6,1033
      if (write(fds[1], buf, SZ) != SZ) {
    1408:	8bda                	mv	s7,s6
    for (n = 0; n < N; n++) {
    140a:	6a85                	lui	s5,0x1
    140c:	42da8a93          	addi	s5,s5,1069 # 142d <pipe1+0xef>
{
    1410:	87da                	mv	a5,s6
        buf[i] = seq++;
    1412:	0097873b          	addw	a4,a5,s1
    1416:	00e78023          	sb	a4,0(a5)
      for (i = 0; i < SZ; i++)
    141a:	0785                	addi	a5,a5,1
    141c:	ff279be3          	bne	a5,s2,1412 <pipe1+0xd4>
    1420:	409a0a1b          	addiw	s4,s4,1033
      if (write(fds[1], buf, SZ) != SZ) {
    1424:	40900613          	li	a2,1033
    1428:	85de                	mv	a1,s7
    142a:	fac42503          	lw	a0,-84(s0)
    142e:	607030ef          	jal	5234 <write>
    1432:	40900793          	li	a5,1033
    1436:	00f51a63          	bne	a0,a5,144a <pipe1+0x10c>
    for (n = 0; n < N; n++) {
    143a:	24a5                	addiw	s1,s1,9
    143c:	0ff4f493          	zext.b	s1,s1
    1440:	fd5a18e3          	bne	s4,s5,1410 <pipe1+0xd2>
    exit(0);
    1444:	4501                	li	a0,0
    1446:	5cf030ef          	jal	5214 <exit>
        printf("%s: pipe1 oops 1\n", s);
    144a:	85ce                	mv	a1,s3
    144c:	00005517          	auipc	a0,0x5
    1450:	d0c50513          	addi	a0,a0,-756 # 6158 <malloc+0xa60>
    1454:	1f0040ef          	jal	5644 <printf>
        exit(1);
    1458:	4505                	li	a0,1
    145a:	5bb030ef          	jal	5214 <exit>
          printf("%s: pipe1 oops 2\n", s);
    145e:	85ce                	mv	a1,s3
    1460:	00005517          	auipc	a0,0x5
    1464:	d1050513          	addi	a0,a0,-752 # 6170 <malloc+0xa78>
    1468:	1dc040ef          	jal	5644 <printf>
          return;
    146c:	64a6                	ld	s1,72(sp)
    146e:	6906                	ld	s2,64(sp)
    1470:	7a42                	ld	s4,48(sp)
    1472:	7aa2                	ld	s5,40(sp)
}
    1474:	60e6                	ld	ra,88(sp)
    1476:	6446                	ld	s0,80(sp)
    1478:	79e2                	ld	s3,56(sp)
    147a:	6125                	addi	sp,sp,96
    147c:	8082                	ret
    if (total != N * SZ) {
    147e:	6785                	lui	a5,0x1
    1480:	42d78793          	addi	a5,a5,1069 # 142d <pipe1+0xef>
    1484:	00fa0f63          	beq	s4,a5,14a2 <pipe1+0x164>
    1488:	f05a                	sd	s6,32(sp)
    148a:	ec5e                	sd	s7,24(sp)
      printf("%s: pipe1 oops 3 total %d\n", s, total);
    148c:	8652                	mv	a2,s4
    148e:	85ce                	mv	a1,s3
    1490:	00005517          	auipc	a0,0x5
    1494:	cf850513          	addi	a0,a0,-776 # 6188 <malloc+0xa90>
    1498:	1ac040ef          	jal	5644 <printf>
      exit(1);
    149c:	4505                	li	a0,1
    149e:	577030ef          	jal	5214 <exit>
    14a2:	f05a                	sd	s6,32(sp)
    14a4:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    14a6:	fa842503          	lw	a0,-88(s0)
    14aa:	593030ef          	jal	523c <close>
    wait(&xstatus);
    14ae:	fa440513          	addi	a0,s0,-92
    14b2:	56b030ef          	jal	521c <wait>
    exit(xstatus);
    14b6:	fa442503          	lw	a0,-92(s0)
    14ba:	55b030ef          	jal	5214 <exit>
    14be:	e0ca                	sd	s2,64(sp)
    14c0:	f456                	sd	s5,40(sp)
    14c2:	f05a                	sd	s6,32(sp)
    14c4:	ec5e                	sd	s7,24(sp)
    printf("%s: fork() failed\n", s);
    14c6:	85ce                	mv	a1,s3
    14c8:	00005517          	auipc	a0,0x5
    14cc:	ce050513          	addi	a0,a0,-800 # 61a8 <malloc+0xab0>
    14d0:	174040ef          	jal	5644 <printf>
    exit(1);
    14d4:	4505                	li	a0,1
    14d6:	53f030ef          	jal	5214 <exit>

00000000000014da <exitwait>:
{
    14da:	7139                	addi	sp,sp,-64
    14dc:	fc06                	sd	ra,56(sp)
    14de:	f822                	sd	s0,48(sp)
    14e0:	f426                	sd	s1,40(sp)
    14e2:	f04a                	sd	s2,32(sp)
    14e4:	ec4e                	sd	s3,24(sp)
    14e6:	e852                	sd	s4,16(sp)
    14e8:	0080                	addi	s0,sp,64
    14ea:	8a2a                	mv	s4,a0
  for (i = 0; i < 100; i++) {
    14ec:	4901                	li	s2,0
    14ee:	06400993          	li	s3,100
    pid = fork();
    14f2:	51b030ef          	jal	520c <fork>
    14f6:	84aa                	mv	s1,a0
    if (pid < 0) {
    14f8:	02054863          	bltz	a0,1528 <exitwait+0x4e>
    if (pid) {
    14fc:	c525                	beqz	a0,1564 <exitwait+0x8a>
      if (wait(&xstate) != pid) {
    14fe:	fcc40513          	addi	a0,s0,-52
    1502:	51b030ef          	jal	521c <wait>
    1506:	02951b63          	bne	a0,s1,153c <exitwait+0x62>
      if (i != xstate) {
    150a:	fcc42783          	lw	a5,-52(s0)
    150e:	05279163          	bne	a5,s2,1550 <exitwait+0x76>
  for (i = 0; i < 100; i++) {
    1512:	2905                	addiw	s2,s2,1 # 3001 <subdir+0x5b5>
    1514:	fd391fe3          	bne	s2,s3,14f2 <exitwait+0x18>
}
    1518:	70e2                	ld	ra,56(sp)
    151a:	7442                	ld	s0,48(sp)
    151c:	74a2                	ld	s1,40(sp)
    151e:	7902                	ld	s2,32(sp)
    1520:	69e2                	ld	s3,24(sp)
    1522:	6a42                	ld	s4,16(sp)
    1524:	6121                	addi	sp,sp,64
    1526:	8082                	ret
      printf("%s: fork failed\n", s);
    1528:	85d2                	mv	a1,s4
    152a:	00005517          	auipc	a0,0x5
    152e:	b8e50513          	addi	a0,a0,-1138 # 60b8 <malloc+0x9c0>
    1532:	112040ef          	jal	5644 <printf>
      exit(1);
    1536:	4505                	li	a0,1
    1538:	4dd030ef          	jal	5214 <exit>
        printf("%s: wait wrong pid\n", s);
    153c:	85d2                	mv	a1,s4
    153e:	00005517          	auipc	a0,0x5
    1542:	c8250513          	addi	a0,a0,-894 # 61c0 <malloc+0xac8>
    1546:	0fe040ef          	jal	5644 <printf>
        exit(1);
    154a:	4505                	li	a0,1
    154c:	4c9030ef          	jal	5214 <exit>
        printf("%s: wait wrong exit status\n", s);
    1550:	85d2                	mv	a1,s4
    1552:	00005517          	auipc	a0,0x5
    1556:	c8650513          	addi	a0,a0,-890 # 61d8 <malloc+0xae0>
    155a:	0ea040ef          	jal	5644 <printf>
        exit(1);
    155e:	4505                	li	a0,1
    1560:	4b5030ef          	jal	5214 <exit>
      exit(i);
    1564:	854a                	mv	a0,s2
    1566:	4af030ef          	jal	5214 <exit>

000000000000156a <twochildren>:
{
    156a:	1101                	addi	sp,sp,-32
    156c:	ec06                	sd	ra,24(sp)
    156e:	e822                	sd	s0,16(sp)
    1570:	e426                	sd	s1,8(sp)
    1572:	e04a                	sd	s2,0(sp)
    1574:	1000                	addi	s0,sp,32
    1576:	892a                	mv	s2,a0
    1578:	3e800493          	li	s1,1000
    int pid1 = fork();
    157c:	491030ef          	jal	520c <fork>
    if (pid1 < 0) {
    1580:	02054663          	bltz	a0,15ac <twochildren+0x42>
    if (pid1 == 0) {
    1584:	cd15                	beqz	a0,15c0 <twochildren+0x56>
      int pid2 = fork();
    1586:	487030ef          	jal	520c <fork>
      if (pid2 < 0) {
    158a:	02054d63          	bltz	a0,15c4 <twochildren+0x5a>
      if (pid2 == 0) {
    158e:	c529                	beqz	a0,15d8 <twochildren+0x6e>
        wait(0);
    1590:	4501                	li	a0,0
    1592:	48b030ef          	jal	521c <wait>
        wait(0);
    1596:	4501                	li	a0,0
    1598:	485030ef          	jal	521c <wait>
  for (int i = 0; i < 1000; i++) {
    159c:	34fd                	addiw	s1,s1,-1
    159e:	fcf9                	bnez	s1,157c <twochildren+0x12>
}
    15a0:	60e2                	ld	ra,24(sp)
    15a2:	6442                	ld	s0,16(sp)
    15a4:	64a2                	ld	s1,8(sp)
    15a6:	6902                	ld	s2,0(sp)
    15a8:	6105                	addi	sp,sp,32
    15aa:	8082                	ret
      printf("%s: fork failed\n", s);
    15ac:	85ca                	mv	a1,s2
    15ae:	00005517          	auipc	a0,0x5
    15b2:	b0a50513          	addi	a0,a0,-1270 # 60b8 <malloc+0x9c0>
    15b6:	08e040ef          	jal	5644 <printf>
      exit(1);
    15ba:	4505                	li	a0,1
    15bc:	459030ef          	jal	5214 <exit>
      exit(0);
    15c0:	455030ef          	jal	5214 <exit>
        printf("%s: fork failed\n", s);
    15c4:	85ca                	mv	a1,s2
    15c6:	00005517          	auipc	a0,0x5
    15ca:	af250513          	addi	a0,a0,-1294 # 60b8 <malloc+0x9c0>
    15ce:	076040ef          	jal	5644 <printf>
        exit(1);
    15d2:	4505                	li	a0,1
    15d4:	441030ef          	jal	5214 <exit>
        exit(0);
    15d8:	43d030ef          	jal	5214 <exit>

00000000000015dc <forkfork>:
{
    15dc:	7179                	addi	sp,sp,-48
    15de:	f406                	sd	ra,40(sp)
    15e0:	f022                	sd	s0,32(sp)
    15e2:	ec26                	sd	s1,24(sp)
    15e4:	1800                	addi	s0,sp,48
    15e6:	84aa                	mv	s1,a0
    int pid = fork();
    15e8:	425030ef          	jal	520c <fork>
    if (pid < 0) {
    15ec:	02054b63          	bltz	a0,1622 <forkfork+0x46>
    if (pid == 0) {
    15f0:	c139                	beqz	a0,1636 <forkfork+0x5a>
    int pid = fork();
    15f2:	41b030ef          	jal	520c <fork>
    if (pid < 0) {
    15f6:	02054663          	bltz	a0,1622 <forkfork+0x46>
    if (pid == 0) {
    15fa:	cd15                	beqz	a0,1636 <forkfork+0x5a>
    wait(&xstatus);
    15fc:	fdc40513          	addi	a0,s0,-36
    1600:	41d030ef          	jal	521c <wait>
    if (xstatus != 0) {
    1604:	fdc42783          	lw	a5,-36(s0)
    1608:	ebb9                	bnez	a5,165e <forkfork+0x82>
    wait(&xstatus);
    160a:	fdc40513          	addi	a0,s0,-36
    160e:	40f030ef          	jal	521c <wait>
    if (xstatus != 0) {
    1612:	fdc42783          	lw	a5,-36(s0)
    1616:	e7a1                	bnez	a5,165e <forkfork+0x82>
}
    1618:	70a2                	ld	ra,40(sp)
    161a:	7402                	ld	s0,32(sp)
    161c:	64e2                	ld	s1,24(sp)
    161e:	6145                	addi	sp,sp,48
    1620:	8082                	ret
      printf("%s: fork failed", s);
    1622:	85a6                	mv	a1,s1
    1624:	00005517          	auipc	a0,0x5
    1628:	bd450513          	addi	a0,a0,-1068 # 61f8 <malloc+0xb00>
    162c:	018040ef          	jal	5644 <printf>
      exit(1);
    1630:	4505                	li	a0,1
    1632:	3e3030ef          	jal	5214 <exit>
{
    1636:	0c800493          	li	s1,200
        int pid1 = fork();
    163a:	3d3030ef          	jal	520c <fork>
        if (pid1 < 0) {
    163e:	00054b63          	bltz	a0,1654 <forkfork+0x78>
        if (pid1 == 0) {
    1642:	cd01                	beqz	a0,165a <forkfork+0x7e>
        wait(0);
    1644:	4501                	li	a0,0
    1646:	3d7030ef          	jal	521c <wait>
      for (int j = 0; j < 200; j++) {
    164a:	34fd                	addiw	s1,s1,-1
    164c:	f4fd                	bnez	s1,163a <forkfork+0x5e>
      exit(0);
    164e:	4501                	li	a0,0
    1650:	3c5030ef          	jal	5214 <exit>
          exit(1);
    1654:	4505                	li	a0,1
    1656:	3bf030ef          	jal	5214 <exit>
          exit(0);
    165a:	3bb030ef          	jal	5214 <exit>
      printf("%s: fork in child failed", s);
    165e:	85a6                	mv	a1,s1
    1660:	00005517          	auipc	a0,0x5
    1664:	ba850513          	addi	a0,a0,-1112 # 6208 <malloc+0xb10>
    1668:	7dd030ef          	jal	5644 <printf>
      exit(1);
    166c:	4505                	li	a0,1
    166e:	3a7030ef          	jal	5214 <exit>

0000000000001672 <reparent2>:
{
    1672:	1101                	addi	sp,sp,-32
    1674:	ec06                	sd	ra,24(sp)
    1676:	e822                	sd	s0,16(sp)
    1678:	e426                	sd	s1,8(sp)
    167a:	1000                	addi	s0,sp,32
    167c:	32000493          	li	s1,800
    int pid1 = fork();
    1680:	38d030ef          	jal	520c <fork>
    if (pid1 < 0) {
    1684:	00054b63          	bltz	a0,169a <reparent2+0x28>
    if (pid1 == 0) {
    1688:	c115                	beqz	a0,16ac <reparent2+0x3a>
    wait(0);
    168a:	4501                	li	a0,0
    168c:	391030ef          	jal	521c <wait>
  for (int i = 0; i < 800; i++) {
    1690:	34fd                	addiw	s1,s1,-1
    1692:	f4fd                	bnez	s1,1680 <reparent2+0xe>
  exit(0);
    1694:	4501                	li	a0,0
    1696:	37f030ef          	jal	5214 <exit>
      printf("fork failed\n");
    169a:	00006517          	auipc	a0,0x6
    169e:	0de50513          	addi	a0,a0,222 # 7778 <malloc+0x2080>
    16a2:	7a3030ef          	jal	5644 <printf>
      exit(1);
    16a6:	4505                	li	a0,1
    16a8:	36d030ef          	jal	5214 <exit>
      fork();
    16ac:	361030ef          	jal	520c <fork>
      fork();
    16b0:	35d030ef          	jal	520c <fork>
      exit(0);
    16b4:	4501                	li	a0,0
    16b6:	35f030ef          	jal	5214 <exit>

00000000000016ba <createdelete>:
{
    16ba:	7175                	addi	sp,sp,-144
    16bc:	e506                	sd	ra,136(sp)
    16be:	e122                	sd	s0,128(sp)
    16c0:	fca6                	sd	s1,120(sp)
    16c2:	f8ca                	sd	s2,112(sp)
    16c4:	f4ce                	sd	s3,104(sp)
    16c6:	f0d2                	sd	s4,96(sp)
    16c8:	ecd6                	sd	s5,88(sp)
    16ca:	e8da                	sd	s6,80(sp)
    16cc:	e4de                	sd	s7,72(sp)
    16ce:	e0e2                	sd	s8,64(sp)
    16d0:	fc66                	sd	s9,56(sp)
    16d2:	0900                	addi	s0,sp,144
    16d4:	8caa                	mv	s9,a0
  for (pi = 0; pi < NCHILD; pi++) {
    16d6:	4901                	li	s2,0
    16d8:	4991                	li	s3,4
    pid = fork();
    16da:	333030ef          	jal	520c <fork>
    16de:	84aa                	mv	s1,a0
    if (pid < 0) {
    16e0:	02054d63          	bltz	a0,171a <createdelete+0x60>
    if (pid == 0) {
    16e4:	c529                	beqz	a0,172e <createdelete+0x74>
  for (pi = 0; pi < NCHILD; pi++) {
    16e6:	2905                	addiw	s2,s2,1
    16e8:	ff3919e3          	bne	s2,s3,16da <createdelete+0x20>
    16ec:	4491                	li	s1,4
    wait(&xstatus);
    16ee:	f7c40513          	addi	a0,s0,-132
    16f2:	32b030ef          	jal	521c <wait>
    if (xstatus != 0)
    16f6:	f7c42903          	lw	s2,-132(s0)
    16fa:	0a091e63          	bnez	s2,17b6 <createdelete+0xfc>
  for (pi = 0; pi < NCHILD; pi++) {
    16fe:	34fd                	addiw	s1,s1,-1
    1700:	f4fd                	bnez	s1,16ee <createdelete+0x34>
  name[0] = name[1] = name[2] = 0;
    1702:	f8040123          	sb	zero,-126(s0)
    1706:	03000993          	li	s3,48
    170a:	5a7d                	li	s4,-1
    170c:	07000c13          	li	s8,112
      if ((i == 0 || i >= N / 2) && fd < 0) {
    1710:	4b25                	li	s6,9
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    1712:	4ba1                	li	s7,8
    for (pi = 0; pi < NCHILD; pi++) {
    1714:	07400a93          	li	s5,116
    1718:	aa39                	j	1836 <createdelete+0x17c>
      printf("%s: fork failed\n", s);
    171a:	85e6                	mv	a1,s9
    171c:	00005517          	auipc	a0,0x5
    1720:	99c50513          	addi	a0,a0,-1636 # 60b8 <malloc+0x9c0>
    1724:	721030ef          	jal	5644 <printf>
      exit(1);
    1728:	4505                	li	a0,1
    172a:	2eb030ef          	jal	5214 <exit>
      name[0] = 'p' + pi;
    172e:	0709091b          	addiw	s2,s2,112
    1732:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1736:	f8040123          	sb	zero,-126(s0)
      for (i = 0; i < N; i++) {
    173a:	4951                	li	s2,20
    173c:	a831                	j	1758 <createdelete+0x9e>
          printf("%s: create failed\n", s);
    173e:	85e6                	mv	a1,s9
    1740:	00005517          	auipc	a0,0x5
    1744:	ae850513          	addi	a0,a0,-1304 # 6228 <malloc+0xb30>
    1748:	6fd030ef          	jal	5644 <printf>
          exit(1);
    174c:	4505                	li	a0,1
    174e:	2c7030ef          	jal	5214 <exit>
      for (i = 0; i < N; i++) {
    1752:	2485                	addiw	s1,s1,1
    1754:	05248e63          	beq	s1,s2,17b0 <createdelete+0xf6>
        name[1] = '0' + i;
    1758:	0304879b          	addiw	a5,s1,48
    175c:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1760:	20200593          	li	a1,514
    1764:	f8040513          	addi	a0,s0,-128
    1768:	2ed030ef          	jal	5254 <open>
        if (fd < 0) {
    176c:	fc0549e3          	bltz	a0,173e <createdelete+0x84>
        close(fd);
    1770:	2cd030ef          	jal	523c <close>
        if (i > 0 && (i % 2) == 0) {
    1774:	10905063          	blez	s1,1874 <createdelete+0x1ba>
    1778:	0014f793          	andi	a5,s1,1
    177c:	fbf9                	bnez	a5,1752 <createdelete+0x98>
          name[1] = '0' + (i / 2);
    177e:	01f4d79b          	srliw	a5,s1,0x1f
    1782:	9fa5                	addw	a5,a5,s1
    1784:	4017d79b          	sraiw	a5,a5,0x1
    1788:	0307879b          	addiw	a5,a5,48
    178c:	f8f400a3          	sb	a5,-127(s0)
          if (unlink(name) < 0) {
    1790:	f8040513          	addi	a0,s0,-128
    1794:	2d1030ef          	jal	5264 <unlink>
    1798:	fa055de3          	bgez	a0,1752 <createdelete+0x98>
            printf("%s: unlink failed\n", s);
    179c:	85e6                	mv	a1,s9
    179e:	00005517          	auipc	a0,0x5
    17a2:	aa250513          	addi	a0,a0,-1374 # 6240 <malloc+0xb48>
    17a6:	69f030ef          	jal	5644 <printf>
            exit(1);
    17aa:	4505                	li	a0,1
    17ac:	269030ef          	jal	5214 <exit>
      exit(0);
    17b0:	4501                	li	a0,0
    17b2:	263030ef          	jal	5214 <exit>
      exit(1);
    17b6:	4505                	li	a0,1
    17b8:	25d030ef          	jal	5214 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    17bc:	f8040613          	addi	a2,s0,-128
    17c0:	85e6                	mv	a1,s9
    17c2:	00005517          	auipc	a0,0x5
    17c6:	a9650513          	addi	a0,a0,-1386 # 6258 <malloc+0xb60>
    17ca:	67b030ef          	jal	5644 <printf>
        exit(1);
    17ce:	4505                	li	a0,1
    17d0:	245030ef          	jal	5214 <exit>
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    17d4:	034bfb63          	bgeu	s7,s4,180a <createdelete+0x150>
      if (fd >= 0)
    17d8:	02055663          	bgez	a0,1804 <createdelete+0x14a>
    for (pi = 0; pi < NCHILD; pi++) {
    17dc:	2485                	addiw	s1,s1,1
    17de:	0ff4f493          	zext.b	s1,s1
    17e2:	05548263          	beq	s1,s5,1826 <createdelete+0x16c>
      name[0] = 'p' + pi;
    17e6:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    17ea:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    17ee:	4581                	li	a1,0
    17f0:	f8040513          	addi	a0,s0,-128
    17f4:	261030ef          	jal	5254 <open>
      if ((i == 0 || i >= N / 2) && fd < 0) {
    17f8:	00090463          	beqz	s2,1800 <createdelete+0x146>
    17fc:	fd2b5ce3          	bge	s6,s2,17d4 <createdelete+0x11a>
    1800:	fa054ee3          	bltz	a0,17bc <createdelete+0x102>
        close(fd);
    1804:	239030ef          	jal	523c <close>
    1808:	bfd1                	j	17dc <createdelete+0x122>
      } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    180a:	fc0549e3          	bltz	a0,17dc <createdelete+0x122>
        printf("%s: oops createdelete %s did exist\n", s, name);
    180e:	f8040613          	addi	a2,s0,-128
    1812:	85e6                	mv	a1,s9
    1814:	00005517          	auipc	a0,0x5
    1818:	a6c50513          	addi	a0,a0,-1428 # 6280 <malloc+0xb88>
    181c:	629030ef          	jal	5644 <printf>
        exit(1);
    1820:	4505                	li	a0,1
    1822:	1f3030ef          	jal	5214 <exit>
  for (i = 0; i < N; i++) {
    1826:	2905                	addiw	s2,s2,1
    1828:	2a05                	addiw	s4,s4,1
    182a:	2985                	addiw	s3,s3,1
    182c:	0ff9f993          	zext.b	s3,s3
    1830:	47d1                	li	a5,20
    1832:	02f90863          	beq	s2,a5,1862 <createdelete+0x1a8>
    for (pi = 0; pi < NCHILD; pi++) {
    1836:	84e2                	mv	s1,s8
    1838:	b77d                	j	17e6 <createdelete+0x12c>
  for (i = 0; i < N; i++) {
    183a:	2905                	addiw	s2,s2,1
    183c:	0ff97913          	zext.b	s2,s2
    1840:	03490c63          	beq	s2,s4,1878 <createdelete+0x1be>
  name[0] = name[1] = name[2] = 0;
    1844:	84d6                	mv	s1,s5
      name[0] = 'p' + pi;
    1846:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    184a:	f92400a3          	sb	s2,-127(s0)
      unlink(name);
    184e:	f8040513          	addi	a0,s0,-128
    1852:	213030ef          	jal	5264 <unlink>
    for (pi = 0; pi < NCHILD; pi++) {
    1856:	2485                	addiw	s1,s1,1
    1858:	0ff4f493          	zext.b	s1,s1
    185c:	ff3495e3          	bne	s1,s3,1846 <createdelete+0x18c>
    1860:	bfe9                	j	183a <createdelete+0x180>
    1862:	03000913          	li	s2,48
  name[0] = name[1] = name[2] = 0;
    1866:	07000a93          	li	s5,112
    for (pi = 0; pi < NCHILD; pi++) {
    186a:	07400993          	li	s3,116
  for (i = 0; i < N; i++) {
    186e:	04400a13          	li	s4,68
    1872:	bfc9                	j	1844 <createdelete+0x18a>
      for (i = 0; i < N; i++) {
    1874:	2485                	addiw	s1,s1,1
    1876:	b5cd                	j	1758 <createdelete+0x9e>
}
    1878:	60aa                	ld	ra,136(sp)
    187a:	640a                	ld	s0,128(sp)
    187c:	74e6                	ld	s1,120(sp)
    187e:	7946                	ld	s2,112(sp)
    1880:	79a6                	ld	s3,104(sp)
    1882:	7a06                	ld	s4,96(sp)
    1884:	6ae6                	ld	s5,88(sp)
    1886:	6b46                	ld	s6,80(sp)
    1888:	6ba6                	ld	s7,72(sp)
    188a:	6c06                	ld	s8,64(sp)
    188c:	7ce2                	ld	s9,56(sp)
    188e:	6149                	addi	sp,sp,144
    1890:	8082                	ret

0000000000001892 <linkunlink>:
{
    1892:	711d                	addi	sp,sp,-96
    1894:	ec86                	sd	ra,88(sp)
    1896:	e8a2                	sd	s0,80(sp)
    1898:	e4a6                	sd	s1,72(sp)
    189a:	e0ca                	sd	s2,64(sp)
    189c:	fc4e                	sd	s3,56(sp)
    189e:	f852                	sd	s4,48(sp)
    18a0:	f456                	sd	s5,40(sp)
    18a2:	f05a                	sd	s6,32(sp)
    18a4:	ec5e                	sd	s7,24(sp)
    18a6:	e862                	sd	s8,16(sp)
    18a8:	e466                	sd	s9,8(sp)
    18aa:	1080                	addi	s0,sp,96
    18ac:	84aa                	mv	s1,a0
  unlink("x");
    18ae:	00004517          	auipc	a0,0x4
    18b2:	fea50513          	addi	a0,a0,-22 # 5898 <malloc+0x1a0>
    18b6:	1af030ef          	jal	5264 <unlink>
  pid = fork();
    18ba:	153030ef          	jal	520c <fork>
  if (pid < 0) {
    18be:	02054b63          	bltz	a0,18f4 <linkunlink+0x62>
    18c2:	8caa                	mv	s9,a0
  unsigned int x = (pid ? 1 : 97);
    18c4:	06100913          	li	s2,97
    18c8:	c111                	beqz	a0,18cc <linkunlink+0x3a>
    18ca:	4905                	li	s2,1
    18cc:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    18d0:	41c65a37          	lui	s4,0x41c65
    18d4:	e6da0a1b          	addiw	s4,s4,-403 # 41c64e6d <base+0x41c54185>
    18d8:	698d                	lui	s3,0x3
    18da:	0399899b          	addiw	s3,s3,57 # 3039 <subdir+0x5ed>
    if ((x % 3) == 0) {
    18de:	4a8d                	li	s5,3
    } else if ((x % 3) == 1) {
    18e0:	4b85                	li	s7,1
      unlink("x");
    18e2:	00004b17          	auipc	s6,0x4
    18e6:	fb6b0b13          	addi	s6,s6,-74 # 5898 <malloc+0x1a0>
      link("cat", "x");
    18ea:	00005c17          	auipc	s8,0x5
    18ee:	9bec0c13          	addi	s8,s8,-1602 # 62a8 <malloc+0xbb0>
    18f2:	a025                	j	191a <linkunlink+0x88>
    printf("%s: fork failed\n", s);
    18f4:	85a6                	mv	a1,s1
    18f6:	00004517          	auipc	a0,0x4
    18fa:	7c250513          	addi	a0,a0,1986 # 60b8 <malloc+0x9c0>
    18fe:	547030ef          	jal	5644 <printf>
    exit(1);
    1902:	4505                	li	a0,1
    1904:	111030ef          	jal	5214 <exit>
      close(open("x", O_RDWR | O_CREATE));
    1908:	20200593          	li	a1,514
    190c:	855a                	mv	a0,s6
    190e:	147030ef          	jal	5254 <open>
    1912:	12b030ef          	jal	523c <close>
  for (i = 0; i < 100; i++) {
    1916:	34fd                	addiw	s1,s1,-1
    1918:	c495                	beqz	s1,1944 <linkunlink+0xb2>
    x = x * 1103515245 + 12345;
    191a:	034907bb          	mulw	a5,s2,s4
    191e:	013787bb          	addw	a5,a5,s3
    1922:	0007891b          	sext.w	s2,a5
    if ((x % 3) == 0) {
    1926:	0357f7bb          	remuw	a5,a5,s5
    192a:	2781                	sext.w	a5,a5
    192c:	dff1                	beqz	a5,1908 <linkunlink+0x76>
    } else if ((x % 3) == 1) {
    192e:	01778663          	beq	a5,s7,193a <linkunlink+0xa8>
      unlink("x");
    1932:	855a                	mv	a0,s6
    1934:	131030ef          	jal	5264 <unlink>
    1938:	bff9                	j	1916 <linkunlink+0x84>
      link("cat", "x");
    193a:	85da                	mv	a1,s6
    193c:	8562                	mv	a0,s8
    193e:	137030ef          	jal	5274 <link>
    1942:	bfd1                	j	1916 <linkunlink+0x84>
  if (pid)
    1944:	020c8263          	beqz	s9,1968 <linkunlink+0xd6>
    wait(0);
    1948:	4501                	li	a0,0
    194a:	0d3030ef          	jal	521c <wait>
}
    194e:	60e6                	ld	ra,88(sp)
    1950:	6446                	ld	s0,80(sp)
    1952:	64a6                	ld	s1,72(sp)
    1954:	6906                	ld	s2,64(sp)
    1956:	79e2                	ld	s3,56(sp)
    1958:	7a42                	ld	s4,48(sp)
    195a:	7aa2                	ld	s5,40(sp)
    195c:	7b02                	ld	s6,32(sp)
    195e:	6be2                	ld	s7,24(sp)
    1960:	6c42                	ld	s8,16(sp)
    1962:	6ca2                	ld	s9,8(sp)
    1964:	6125                	addi	sp,sp,96
    1966:	8082                	ret
    exit(0);
    1968:	4501                	li	a0,0
    196a:	0ab030ef          	jal	5214 <exit>

000000000000196e <forktest>:
{
    196e:	7179                	addi	sp,sp,-48
    1970:	f406                	sd	ra,40(sp)
    1972:	f022                	sd	s0,32(sp)
    1974:	ec26                	sd	s1,24(sp)
    1976:	e84a                	sd	s2,16(sp)
    1978:	e44e                	sd	s3,8(sp)
    197a:	1800                	addi	s0,sp,48
    197c:	89aa                	mv	s3,a0
  for (n = 0; n < N; n++) {
    197e:	4481                	li	s1,0
    1980:	3e800913          	li	s2,1000
    pid = fork();
    1984:	089030ef          	jal	520c <fork>
    if (pid < 0)
    1988:	06054063          	bltz	a0,19e8 <forktest+0x7a>
    if (pid == 0)
    198c:	cd11                	beqz	a0,19a8 <forktest+0x3a>
  for (n = 0; n < N; n++) {
    198e:	2485                	addiw	s1,s1,1
    1990:	ff249ae3          	bne	s1,s2,1984 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1994:	85ce                	mv	a1,s3
    1996:	00005517          	auipc	a0,0x5
    199a:	96250513          	addi	a0,a0,-1694 # 62f8 <malloc+0xc00>
    199e:	4a7030ef          	jal	5644 <printf>
    exit(1);
    19a2:	4505                	li	a0,1
    19a4:	071030ef          	jal	5214 <exit>
      exit(0);
    19a8:	06d030ef          	jal	5214 <exit>
    printf("%s: no fork at all!\n", s);
    19ac:	85ce                	mv	a1,s3
    19ae:	00005517          	auipc	a0,0x5
    19b2:	90250513          	addi	a0,a0,-1790 # 62b0 <malloc+0xbb8>
    19b6:	48f030ef          	jal	5644 <printf>
    exit(1);
    19ba:	4505                	li	a0,1
    19bc:	059030ef          	jal	5214 <exit>
      printf("%s: wait stopped early\n", s);
    19c0:	85ce                	mv	a1,s3
    19c2:	00005517          	auipc	a0,0x5
    19c6:	90650513          	addi	a0,a0,-1786 # 62c8 <malloc+0xbd0>
    19ca:	47b030ef          	jal	5644 <printf>
      exit(1);
    19ce:	4505                	li	a0,1
    19d0:	045030ef          	jal	5214 <exit>
    printf("%s: wait got too many\n", s);
    19d4:	85ce                	mv	a1,s3
    19d6:	00005517          	auipc	a0,0x5
    19da:	90a50513          	addi	a0,a0,-1782 # 62e0 <malloc+0xbe8>
    19de:	467030ef          	jal	5644 <printf>
    exit(1);
    19e2:	4505                	li	a0,1
    19e4:	031030ef          	jal	5214 <exit>
  if (n == 0) {
    19e8:	d0f1                	beqz	s1,19ac <forktest+0x3e>
  for (; n > 0; n--) {
    19ea:	00905963          	blez	s1,19fc <forktest+0x8e>
    if (wait(0) < 0) {
    19ee:	4501                	li	a0,0
    19f0:	02d030ef          	jal	521c <wait>
    19f4:	fc0546e3          	bltz	a0,19c0 <forktest+0x52>
  for (; n > 0; n--) {
    19f8:	34fd                	addiw	s1,s1,-1
    19fa:	f8f5                	bnez	s1,19ee <forktest+0x80>
  if (wait(0) != -1) {
    19fc:	4501                	li	a0,0
    19fe:	01f030ef          	jal	521c <wait>
    1a02:	57fd                	li	a5,-1
    1a04:	fcf518e3          	bne	a0,a5,19d4 <forktest+0x66>
}
    1a08:	70a2                	ld	ra,40(sp)
    1a0a:	7402                	ld	s0,32(sp)
    1a0c:	64e2                	ld	s1,24(sp)
    1a0e:	6942                	ld	s2,16(sp)
    1a10:	69a2                	ld	s3,8(sp)
    1a12:	6145                	addi	sp,sp,48
    1a14:	8082                	ret

0000000000001a16 <kernmem>:
{
    1a16:	715d                	addi	sp,sp,-80
    1a18:	e486                	sd	ra,72(sp)
    1a1a:	e0a2                	sd	s0,64(sp)
    1a1c:	fc26                	sd	s1,56(sp)
    1a1e:	f84a                	sd	s2,48(sp)
    1a20:	f44e                	sd	s3,40(sp)
    1a22:	f052                	sd	s4,32(sp)
    1a24:	ec56                	sd	s5,24(sp)
    1a26:	0880                	addi	s0,sp,80
    1a28:	8aaa                	mv	s5,a0
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    1a2a:	4485                	li	s1,1
    1a2c:	04fe                	slli	s1,s1,0x1f
    if (xstatus != -1) // did kernel kill child?
    1a2e:	5a7d                	li	s4,-1
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    1a30:	69b1                	lui	s3,0xc
    1a32:	35098993          	addi	s3,s3,848 # c350 <uninit+0xd78>
    1a36:	1003d937          	lui	s2,0x1003d
    1a3a:	090e                	slli	s2,s2,0x3
    1a3c:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002c798>
    pid = fork();
    1a40:	7cc030ef          	jal	520c <fork>
    if (pid < 0) {
    1a44:	02054763          	bltz	a0,1a72 <kernmem+0x5c>
    if (pid == 0) {
    1a48:	cd1d                	beqz	a0,1a86 <kernmem+0x70>
    wait(&xstatus);
    1a4a:	fbc40513          	addi	a0,s0,-68
    1a4e:	7ce030ef          	jal	521c <wait>
    if (xstatus != -1) // did kernel kill child?
    1a52:	fbc42783          	lw	a5,-68(s0)
    1a56:	05479563          	bne	a5,s4,1aa0 <kernmem+0x8a>
  for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    1a5a:	94ce                	add	s1,s1,s3
    1a5c:	ff2492e3          	bne	s1,s2,1a40 <kernmem+0x2a>
}
    1a60:	60a6                	ld	ra,72(sp)
    1a62:	6406                	ld	s0,64(sp)
    1a64:	74e2                	ld	s1,56(sp)
    1a66:	7942                	ld	s2,48(sp)
    1a68:	79a2                	ld	s3,40(sp)
    1a6a:	7a02                	ld	s4,32(sp)
    1a6c:	6ae2                	ld	s5,24(sp)
    1a6e:	6161                	addi	sp,sp,80
    1a70:	8082                	ret
      printf("%s: fork failed\n", s);
    1a72:	85d6                	mv	a1,s5
    1a74:	00004517          	auipc	a0,0x4
    1a78:	64450513          	addi	a0,a0,1604 # 60b8 <malloc+0x9c0>
    1a7c:	3c9030ef          	jal	5644 <printf>
      exit(1);
    1a80:	4505                	li	a0,1
    1a82:	792030ef          	jal	5214 <exit>
      printf("%s: oops could read %p = %x\n", s, a, *a);
    1a86:	0004c683          	lbu	a3,0(s1)
    1a8a:	8626                	mv	a2,s1
    1a8c:	85d6                	mv	a1,s5
    1a8e:	00005517          	auipc	a0,0x5
    1a92:	89250513          	addi	a0,a0,-1902 # 6320 <malloc+0xc28>
    1a96:	3af030ef          	jal	5644 <printf>
      exit(1);
    1a9a:	4505                	li	a0,1
    1a9c:	778030ef          	jal	5214 <exit>
      exit(1);
    1aa0:	4505                	li	a0,1
    1aa2:	772030ef          	jal	5214 <exit>

0000000000001aa6 <MAXVAplus>:
{
    1aa6:	7179                	addi	sp,sp,-48
    1aa8:	f406                	sd	ra,40(sp)
    1aaa:	f022                	sd	s0,32(sp)
    1aac:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    1aae:	4785                	li	a5,1
    1ab0:	179a                	slli	a5,a5,0x26
    1ab2:	fcf43c23          	sd	a5,-40(s0)
  for (; a != 0; a <<= 1) {
    1ab6:	fd843783          	ld	a5,-40(s0)
    1aba:	cf85                	beqz	a5,1af2 <MAXVAplus+0x4c>
    1abc:	ec26                	sd	s1,24(sp)
    1abe:	e84a                	sd	s2,16(sp)
    1ac0:	892a                	mv	s2,a0
    if (xstatus != -1) // did kernel kill child?
    1ac2:	54fd                	li	s1,-1
    pid = fork();
    1ac4:	748030ef          	jal	520c <fork>
    if (pid < 0) {
    1ac8:	02054963          	bltz	a0,1afa <MAXVAplus+0x54>
    if (pid == 0) {
    1acc:	c129                	beqz	a0,1b0e <MAXVAplus+0x68>
    wait(&xstatus);
    1ace:	fd440513          	addi	a0,s0,-44
    1ad2:	74a030ef          	jal	521c <wait>
    if (xstatus != -1) // did kernel kill child?
    1ad6:	fd442783          	lw	a5,-44(s0)
    1ada:	04979c63          	bne	a5,s1,1b32 <MAXVAplus+0x8c>
  for (; a != 0; a <<= 1) {
    1ade:	fd843783          	ld	a5,-40(s0)
    1ae2:	0786                	slli	a5,a5,0x1
    1ae4:	fcf43c23          	sd	a5,-40(s0)
    1ae8:	fd843783          	ld	a5,-40(s0)
    1aec:	ffe1                	bnez	a5,1ac4 <MAXVAplus+0x1e>
    1aee:	64e2                	ld	s1,24(sp)
    1af0:	6942                	ld	s2,16(sp)
}
    1af2:	70a2                	ld	ra,40(sp)
    1af4:	7402                	ld	s0,32(sp)
    1af6:	6145                	addi	sp,sp,48
    1af8:	8082                	ret
      printf("%s: fork failed\n", s);
    1afa:	85ca                	mv	a1,s2
    1afc:	00004517          	auipc	a0,0x4
    1b00:	5bc50513          	addi	a0,a0,1468 # 60b8 <malloc+0x9c0>
    1b04:	341030ef          	jal	5644 <printf>
      exit(1);
    1b08:	4505                	li	a0,1
    1b0a:	70a030ef          	jal	5214 <exit>
      *(char *)a = 99;
    1b0e:	fd843783          	ld	a5,-40(s0)
    1b12:	06300713          	li	a4,99
    1b16:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %p\n", s, (void *)a);
    1b1a:	fd843603          	ld	a2,-40(s0)
    1b1e:	85ca                	mv	a1,s2
    1b20:	00005517          	auipc	a0,0x5
    1b24:	82050513          	addi	a0,a0,-2016 # 6340 <malloc+0xc48>
    1b28:	31d030ef          	jal	5644 <printf>
      exit(1);
    1b2c:	4505                	li	a0,1
    1b2e:	6e6030ef          	jal	5214 <exit>
      exit(1);
    1b32:	4505                	li	a0,1
    1b34:	6e0030ef          	jal	5214 <exit>

0000000000001b38 <stacktest>:
{
    1b38:	7179                	addi	sp,sp,-48
    1b3a:	f406                	sd	ra,40(sp)
    1b3c:	f022                	sd	s0,32(sp)
    1b3e:	ec26                	sd	s1,24(sp)
    1b40:	1800                	addi	s0,sp,48
    1b42:	84aa                	mv	s1,a0
  pid = fork();
    1b44:	6c8030ef          	jal	520c <fork>
  if (pid == 0) {
    1b48:	cd11                	beqz	a0,1b64 <stacktest+0x2c>
  } else if (pid < 0) {
    1b4a:	02054c63          	bltz	a0,1b82 <stacktest+0x4a>
  wait(&xstatus);
    1b4e:	fdc40513          	addi	a0,s0,-36
    1b52:	6ca030ef          	jal	521c <wait>
  if (xstatus == -1) // kernel killed child?
    1b56:	fdc42503          	lw	a0,-36(s0)
    1b5a:	57fd                	li	a5,-1
    1b5c:	02f50d63          	beq	a0,a5,1b96 <stacktest+0x5e>
    exit(xstatus);
    1b60:	6b4030ef          	jal	5214 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r"(x));
    1b64:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %d\n", s, *sp);
    1b66:	77fd                	lui	a5,0xfffff
    1b68:	97ba                	add	a5,a5,a4
    1b6a:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffee318>
    1b6e:	85a6                	mv	a1,s1
    1b70:	00004517          	auipc	a0,0x4
    1b74:	7e850513          	addi	a0,a0,2024 # 6358 <malloc+0xc60>
    1b78:	2cd030ef          	jal	5644 <printf>
    exit(1);
    1b7c:	4505                	li	a0,1
    1b7e:	696030ef          	jal	5214 <exit>
    printf("%s: fork failed\n", s);
    1b82:	85a6                	mv	a1,s1
    1b84:	00004517          	auipc	a0,0x4
    1b88:	53450513          	addi	a0,a0,1332 # 60b8 <malloc+0x9c0>
    1b8c:	2b9030ef          	jal	5644 <printf>
    exit(1);
    1b90:	4505                	li	a0,1
    1b92:	682030ef          	jal	5214 <exit>
    exit(0);
    1b96:	4501                	li	a0,0
    1b98:	67c030ef          	jal	5214 <exit>

0000000000001b9c <nowrite>:
{
    1b9c:	7159                	addi	sp,sp,-112
    1b9e:	f486                	sd	ra,104(sp)
    1ba0:	f0a2                	sd	s0,96(sp)
    1ba2:	eca6                	sd	s1,88(sp)
    1ba4:	e8ca                	sd	s2,80(sp)
    1ba6:	e4ce                	sd	s3,72(sp)
    1ba8:	1880                	addi	s0,sp,112
    1baa:	89aa                	mv	s3,a0
  uint64 addrs[] = {0,
    1bac:	00006797          	auipc	a5,0x6
    1bb0:	47c78793          	addi	a5,a5,1148 # 8028 <malloc+0x2930>
    1bb4:	7788                	ld	a0,40(a5)
    1bb6:	7b8c                	ld	a1,48(a5)
    1bb8:	7f90                	ld	a2,56(a5)
    1bba:	63b4                	ld	a3,64(a5)
    1bbc:	67b8                	ld	a4,72(a5)
    1bbe:	6bbc                	ld	a5,80(a5)
    1bc0:	f8a43c23          	sd	a0,-104(s0)
    1bc4:	fab43023          	sd	a1,-96(s0)
    1bc8:	fac43423          	sd	a2,-88(s0)
    1bcc:	fad43823          	sd	a3,-80(s0)
    1bd0:	fae43c23          	sd	a4,-72(s0)
    1bd4:	fcf43023          	sd	a5,-64(s0)
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
    1bd8:	4481                	li	s1,0
    1bda:	4919                	li	s2,6
    pid = fork();
    1bdc:	630030ef          	jal	520c <fork>
    if (pid == 0) {
    1be0:	c105                	beqz	a0,1c00 <nowrite+0x64>
    } else if (pid < 0) {
    1be2:	04054263          	bltz	a0,1c26 <nowrite+0x8a>
    wait(&xstatus);
    1be6:	fcc40513          	addi	a0,s0,-52
    1bea:	632030ef          	jal	521c <wait>
    if (xstatus == 0) {
    1bee:	fcc42783          	lw	a5,-52(s0)
    1bf2:	c7a1                	beqz	a5,1c3a <nowrite+0x9e>
  for (int ai = 0; ai < sizeof(addrs) / sizeof(addrs[0]); ai++) {
    1bf4:	2485                	addiw	s1,s1,1
    1bf6:	ff2493e3          	bne	s1,s2,1bdc <nowrite+0x40>
  exit(0);
    1bfa:	4501                	li	a0,0
    1bfc:	618030ef          	jal	5214 <exit>
      volatile int *addr = (int *)addrs[ai];
    1c00:	048e                	slli	s1,s1,0x3
    1c02:	fd048793          	addi	a5,s1,-48
    1c06:	008784b3          	add	s1,a5,s0
    1c0a:	fc84b603          	ld	a2,-56(s1)
      *addr = 10;
    1c0e:	47a9                	li	a5,10
    1c10:	c21c                	sw	a5,0(a2)
      printf("%s: write to %p did not fail!\n", s, addr);
    1c12:	85ce                	mv	a1,s3
    1c14:	00004517          	auipc	a0,0x4
    1c18:	76c50513          	addi	a0,a0,1900 # 6380 <malloc+0xc88>
    1c1c:	229030ef          	jal	5644 <printf>
      exit(0);
    1c20:	4501                	li	a0,0
    1c22:	5f2030ef          	jal	5214 <exit>
      printf("%s: fork failed\n", s);
    1c26:	85ce                	mv	a1,s3
    1c28:	00004517          	auipc	a0,0x4
    1c2c:	49050513          	addi	a0,a0,1168 # 60b8 <malloc+0x9c0>
    1c30:	215030ef          	jal	5644 <printf>
      exit(1);
    1c34:	4505                	li	a0,1
    1c36:	5de030ef          	jal	5214 <exit>
      exit(1);
    1c3a:	4505                	li	a0,1
    1c3c:	5d8030ef          	jal	5214 <exit>

0000000000001c40 <manywrites>:
{
    1c40:	711d                	addi	sp,sp,-96
    1c42:	ec86                	sd	ra,88(sp)
    1c44:	e8a2                	sd	s0,80(sp)
    1c46:	e4a6                	sd	s1,72(sp)
    1c48:	e0ca                	sd	s2,64(sp)
    1c4a:	fc4e                	sd	s3,56(sp)
    1c4c:	f456                	sd	s5,40(sp)
    1c4e:	1080                	addi	s0,sp,96
    1c50:	8aaa                	mv	s5,a0
  for (int ci = 0; ci < nchildren; ci++) {
    1c52:	4981                	li	s3,0
    1c54:	4911                	li	s2,4
    int pid = fork();
    1c56:	5b6030ef          	jal	520c <fork>
    1c5a:	84aa                	mv	s1,a0
    if (pid < 0) {
    1c5c:	02054963          	bltz	a0,1c8e <manywrites+0x4e>
    if (pid == 0) {
    1c60:	c139                	beqz	a0,1ca6 <manywrites+0x66>
  for (int ci = 0; ci < nchildren; ci++) {
    1c62:	2985                	addiw	s3,s3,1
    1c64:	ff2999e3          	bne	s3,s2,1c56 <manywrites+0x16>
    1c68:	f852                	sd	s4,48(sp)
    1c6a:	f05a                	sd	s6,32(sp)
    1c6c:	ec5e                	sd	s7,24(sp)
    1c6e:	4491                	li	s1,4
    int st = 0;
    1c70:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    1c74:	fa840513          	addi	a0,s0,-88
    1c78:	5a4030ef          	jal	521c <wait>
    if (st != 0)
    1c7c:	fa842503          	lw	a0,-88(s0)
    1c80:	0c051863          	bnez	a0,1d50 <manywrites+0x110>
  for (int ci = 0; ci < nchildren; ci++) {
    1c84:	34fd                	addiw	s1,s1,-1
    1c86:	f4ed                	bnez	s1,1c70 <manywrites+0x30>
  exit(0);
    1c88:	4501                	li	a0,0
    1c8a:	58a030ef          	jal	5214 <exit>
    1c8e:	f852                	sd	s4,48(sp)
    1c90:	f05a                	sd	s6,32(sp)
    1c92:	ec5e                	sd	s7,24(sp)
      printf("fork failed\n");
    1c94:	00006517          	auipc	a0,0x6
    1c98:	ae450513          	addi	a0,a0,-1308 # 7778 <malloc+0x2080>
    1c9c:	1a9030ef          	jal	5644 <printf>
      exit(1);
    1ca0:	4505                	li	a0,1
    1ca2:	572030ef          	jal	5214 <exit>
    1ca6:	f852                	sd	s4,48(sp)
    1ca8:	f05a                	sd	s6,32(sp)
    1caa:	ec5e                	sd	s7,24(sp)
      name[0] = 'b';
    1cac:	06200793          	li	a5,98
    1cb0:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    1cb4:	0619879b          	addiw	a5,s3,97
    1cb8:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    1cbc:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    1cc0:	fa840513          	addi	a0,s0,-88
    1cc4:	5a0030ef          	jal	5264 <unlink>
    1cc8:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    1cca:	0000cb17          	auipc	s6,0xc
    1cce:	01eb0b13          	addi	s6,s6,30 # dce8 <buf>
        for (int i = 0; i < ci + 1; i++) {
    1cd2:	8a26                	mv	s4,s1
    1cd4:	0209c863          	bltz	s3,1d04 <manywrites+0xc4>
          int fd = open(name, O_CREATE | O_RDWR);
    1cd8:	20200593          	li	a1,514
    1cdc:	fa840513          	addi	a0,s0,-88
    1ce0:	574030ef          	jal	5254 <open>
    1ce4:	892a                	mv	s2,a0
          if (fd < 0) {
    1ce6:	02054d63          	bltz	a0,1d20 <manywrites+0xe0>
          int cc = write(fd, buf, sz);
    1cea:	660d                	lui	a2,0x3
    1cec:	85da                	mv	a1,s6
    1cee:	546030ef          	jal	5234 <write>
          if (cc != sz) {
    1cf2:	678d                	lui	a5,0x3
    1cf4:	04f51263          	bne	a0,a5,1d38 <manywrites+0xf8>
          close(fd);
    1cf8:	854a                	mv	a0,s2
    1cfa:	542030ef          	jal	523c <close>
        for (int i = 0; i < ci + 1; i++) {
    1cfe:	2a05                	addiw	s4,s4,1
    1d00:	fd49dce3          	bge	s3,s4,1cd8 <manywrites+0x98>
        unlink(name);
    1d04:	fa840513          	addi	a0,s0,-88
    1d08:	55c030ef          	jal	5264 <unlink>
      for (int iters = 0; iters < howmany; iters++) {
    1d0c:	3bfd                	addiw	s7,s7,-1
    1d0e:	fc0b92e3          	bnez	s7,1cd2 <manywrites+0x92>
      unlink(name);
    1d12:	fa840513          	addi	a0,s0,-88
    1d16:	54e030ef          	jal	5264 <unlink>
      exit(0);
    1d1a:	4501                	li	a0,0
    1d1c:	4f8030ef          	jal	5214 <exit>
            printf("%s: cannot create %s\n", s, name);
    1d20:	fa840613          	addi	a2,s0,-88
    1d24:	85d6                	mv	a1,s5
    1d26:	00004517          	auipc	a0,0x4
    1d2a:	67a50513          	addi	a0,a0,1658 # 63a0 <malloc+0xca8>
    1d2e:	117030ef          	jal	5644 <printf>
            exit(1);
    1d32:	4505                	li	a0,1
    1d34:	4e0030ef          	jal	5214 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1d38:	86aa                	mv	a3,a0
    1d3a:	660d                	lui	a2,0x3
    1d3c:	85d6                	mv	a1,s5
    1d3e:	00004517          	auipc	a0,0x4
    1d42:	bba50513          	addi	a0,a0,-1094 # 58f8 <malloc+0x200>
    1d46:	0ff030ef          	jal	5644 <printf>
            exit(1);
    1d4a:	4505                	li	a0,1
    1d4c:	4c8030ef          	jal	5214 <exit>
      exit(st);
    1d50:	4c4030ef          	jal	5214 <exit>

0000000000001d54 <copyinstr3>:
{
    1d54:	7179                	addi	sp,sp,-48
    1d56:	f406                	sd	ra,40(sp)
    1d58:	f022                	sd	s0,32(sp)
    1d5a:	ec26                	sd	s1,24(sp)
    1d5c:	1800                	addi	s0,sp,48
  sbrk(8192);
    1d5e:	6509                	lui	a0,0x2
    1d60:	480030ef          	jal	51e0 <sbrk>
  uint64 top = (uint64)sbrk(0);
    1d64:	4501                	li	a0,0
    1d66:	47a030ef          	jal	51e0 <sbrk>
  if ((top % PGSIZE) != 0) {
    1d6a:	03451793          	slli	a5,a0,0x34
    1d6e:	e7bd                	bnez	a5,1ddc <copyinstr3+0x88>
  top = (uint64)sbrk(0);
    1d70:	4501                	li	a0,0
    1d72:	46e030ef          	jal	51e0 <sbrk>
  if (top % PGSIZE) {
    1d76:	03451793          	slli	a5,a0,0x34
    1d7a:	ebad                	bnez	a5,1dec <copyinstr3+0x98>
  char *b = (char *)(top - 1);
    1d7c:	fff50493          	addi	s1,a0,-1 # 1fff <sbrkbasic+0xa1>
  *b = 'x';
    1d80:	07800793          	li	a5,120
    1d84:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    1d88:	8526                	mv	a0,s1
    1d8a:	4da030ef          	jal	5264 <unlink>
  if (ret != -1) {
    1d8e:	57fd                	li	a5,-1
    1d90:	06f51763          	bne	a0,a5,1dfe <copyinstr3+0xaa>
  int fd = open(b, O_CREATE | O_WRONLY);
    1d94:	20100593          	li	a1,513
    1d98:	8526                	mv	a0,s1
    1d9a:	4ba030ef          	jal	5254 <open>
  if (fd != -1) {
    1d9e:	57fd                	li	a5,-1
    1da0:	06f51a63          	bne	a0,a5,1e14 <copyinstr3+0xc0>
  ret = link(b, b);
    1da4:	85a6                	mv	a1,s1
    1da6:	8526                	mv	a0,s1
    1da8:	4cc030ef          	jal	5274 <link>
  if (ret != -1) {
    1dac:	57fd                	li	a5,-1
    1dae:	06f51e63          	bne	a0,a5,1e2a <copyinstr3+0xd6>
  char *args[] = {"xx", 0};
    1db2:	00005797          	auipc	a5,0x5
    1db6:	2ee78793          	addi	a5,a5,750 # 70a0 <malloc+0x19a8>
    1dba:	fcf43823          	sd	a5,-48(s0)
    1dbe:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    1dc2:	fd040593          	addi	a1,s0,-48
    1dc6:	8526                	mv	a0,s1
    1dc8:	484030ef          	jal	524c <exec>
  if (ret != -1) {
    1dcc:	57fd                	li	a5,-1
    1dce:	06f51a63          	bne	a0,a5,1e42 <copyinstr3+0xee>
}
    1dd2:	70a2                	ld	ra,40(sp)
    1dd4:	7402                	ld	s0,32(sp)
    1dd6:	64e2                	ld	s1,24(sp)
    1dd8:	6145                	addi	sp,sp,48
    1dda:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    1ddc:	0347d513          	srli	a0,a5,0x34
    1de0:	6785                	lui	a5,0x1
    1de2:	40a7853b          	subw	a0,a5,a0
    1de6:	3fa030ef          	jal	51e0 <sbrk>
    1dea:	b759                	j	1d70 <copyinstr3+0x1c>
    printf("oops\n");
    1dec:	00004517          	auipc	a0,0x4
    1df0:	5cc50513          	addi	a0,a0,1484 # 63b8 <malloc+0xcc0>
    1df4:	051030ef          	jal	5644 <printf>
    exit(1);
    1df8:	4505                	li	a0,1
    1dfa:	41a030ef          	jal	5214 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1dfe:	862a                	mv	a2,a0
    1e00:	85a6                	mv	a1,s1
    1e02:	00004517          	auipc	a0,0x4
    1e06:	1d650513          	addi	a0,a0,470 # 5fd8 <malloc+0x8e0>
    1e0a:	03b030ef          	jal	5644 <printf>
    exit(1);
    1e0e:	4505                	li	a0,1
    1e10:	404030ef          	jal	5214 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1e14:	862a                	mv	a2,a0
    1e16:	85a6                	mv	a1,s1
    1e18:	00004517          	auipc	a0,0x4
    1e1c:	1e050513          	addi	a0,a0,480 # 5ff8 <malloc+0x900>
    1e20:	025030ef          	jal	5644 <printf>
    exit(1);
    1e24:	4505                	li	a0,1
    1e26:	3ee030ef          	jal	5214 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    1e2a:	86aa                	mv	a3,a0
    1e2c:	8626                	mv	a2,s1
    1e2e:	85a6                	mv	a1,s1
    1e30:	00004517          	auipc	a0,0x4
    1e34:	1e850513          	addi	a0,a0,488 # 6018 <malloc+0x920>
    1e38:	00d030ef          	jal	5644 <printf>
    exit(1);
    1e3c:	4505                	li	a0,1
    1e3e:	3d6030ef          	jal	5214 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1e42:	567d                	li	a2,-1
    1e44:	85a6                	mv	a1,s1
    1e46:	00004517          	auipc	a0,0x4
    1e4a:	1fa50513          	addi	a0,a0,506 # 6040 <malloc+0x948>
    1e4e:	7f6030ef          	jal	5644 <printf>
    exit(1);
    1e52:	4505                	li	a0,1
    1e54:	3c0030ef          	jal	5214 <exit>

0000000000001e58 <rwsbrk>:
{
    1e58:	1101                	addi	sp,sp,-32
    1e5a:	ec06                	sd	ra,24(sp)
    1e5c:	e822                	sd	s0,16(sp)
    1e5e:	1000                	addi	s0,sp,32
  uint64 a = (uint64)sbrk(8192);
    1e60:	6509                	lui	a0,0x2
    1e62:	37e030ef          	jal	51e0 <sbrk>
  if (a == (uint64)SBRK_ERROR) {
    1e66:	57fd                	li	a5,-1
    1e68:	04f50a63          	beq	a0,a5,1ebc <rwsbrk+0x64>
    1e6c:	e426                	sd	s1,8(sp)
    1e6e:	84aa                	mv	s1,a0
  if (sbrk(-8192) == SBRK_ERROR) {
    1e70:	7579                	lui	a0,0xffffe
    1e72:	36e030ef          	jal	51e0 <sbrk>
    1e76:	57fd                	li	a5,-1
    1e78:	04f50d63          	beq	a0,a5,1ed2 <rwsbrk+0x7a>
    1e7c:	e04a                	sd	s2,0(sp)
  fd = open("rwsbrk", O_CREATE | O_WRONLY);
    1e7e:	20100593          	li	a1,513
    1e82:	00004517          	auipc	a0,0x4
    1e86:	57650513          	addi	a0,a0,1398 # 63f8 <malloc+0xd00>
    1e8a:	3ca030ef          	jal	5254 <open>
    1e8e:	892a                	mv	s2,a0
  if (fd < 0) {
    1e90:	04054b63          	bltz	a0,1ee6 <rwsbrk+0x8e>
  n = write(fd, (void *)(a + PGSIZE), 1024);
    1e94:	6785                	lui	a5,0x1
    1e96:	94be                	add	s1,s1,a5
    1e98:	40000613          	li	a2,1024
    1e9c:	85a6                	mv	a1,s1
    1e9e:	396030ef          	jal	5234 <write>
    1ea2:	862a                	mv	a2,a0
  if (n >= 0) {
    1ea4:	04054a63          	bltz	a0,1ef8 <rwsbrk+0xa0>
    printf("write(fd, %p, 1024) returned %d, not -1\n", (void *)a + PGSIZE, n);
    1ea8:	85a6                	mv	a1,s1
    1eaa:	00004517          	auipc	a0,0x4
    1eae:	56e50513          	addi	a0,a0,1390 # 6418 <malloc+0xd20>
    1eb2:	792030ef          	jal	5644 <printf>
    exit(1);
    1eb6:	4505                	li	a0,1
    1eb8:	35c030ef          	jal	5214 <exit>
    1ebc:	e426                	sd	s1,8(sp)
    1ebe:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) failed\n");
    1ec0:	00004517          	auipc	a0,0x4
    1ec4:	50050513          	addi	a0,a0,1280 # 63c0 <malloc+0xcc8>
    1ec8:	77c030ef          	jal	5644 <printf>
    exit(1);
    1ecc:	4505                	li	a0,1
    1ece:	346030ef          	jal	5214 <exit>
    1ed2:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) shrink failed\n");
    1ed4:	00004517          	auipc	a0,0x4
    1ed8:	50450513          	addi	a0,a0,1284 # 63d8 <malloc+0xce0>
    1edc:	768030ef          	jal	5644 <printf>
    exit(1);
    1ee0:	4505                	li	a0,1
    1ee2:	332030ef          	jal	5214 <exit>
    printf("open(rwsbrk) failed\n");
    1ee6:	00004517          	auipc	a0,0x4
    1eea:	51a50513          	addi	a0,a0,1306 # 6400 <malloc+0xd08>
    1eee:	756030ef          	jal	5644 <printf>
    exit(1);
    1ef2:	4505                	li	a0,1
    1ef4:	320030ef          	jal	5214 <exit>
  close(fd);
    1ef8:	854a                	mv	a0,s2
    1efa:	342030ef          	jal	523c <close>
  unlink("rwsbrk");
    1efe:	00004517          	auipc	a0,0x4
    1f02:	4fa50513          	addi	a0,a0,1274 # 63f8 <malloc+0xd00>
    1f06:	35e030ef          	jal	5264 <unlink>
  fd = open("README", O_RDONLY);
    1f0a:	4581                	li	a1,0
    1f0c:	00004517          	auipc	a0,0x4
    1f10:	af450513          	addi	a0,a0,-1292 # 5a00 <malloc+0x308>
    1f14:	340030ef          	jal	5254 <open>
    1f18:	892a                	mv	s2,a0
  if (fd < 0) {
    1f1a:	02054363          	bltz	a0,1f40 <rwsbrk+0xe8>
  n = read(fd, (void *)(a + PGSIZE), 10);
    1f1e:	4629                	li	a2,10
    1f20:	85a6                	mv	a1,s1
    1f22:	30a030ef          	jal	522c <read>
    1f26:	862a                	mv	a2,a0
  if (n >= 0) {
    1f28:	02054563          	bltz	a0,1f52 <rwsbrk+0xfa>
    printf("read(fd, %p, 10) returned %d, not -1\n", (void *)a + PGSIZE, n);
    1f2c:	85a6                	mv	a1,s1
    1f2e:	00004517          	auipc	a0,0x4
    1f32:	51a50513          	addi	a0,a0,1306 # 6448 <malloc+0xd50>
    1f36:	70e030ef          	jal	5644 <printf>
    exit(1);
    1f3a:	4505                	li	a0,1
    1f3c:	2d8030ef          	jal	5214 <exit>
    printf("open(README) failed\n");
    1f40:	00004517          	auipc	a0,0x4
    1f44:	ac850513          	addi	a0,a0,-1336 # 5a08 <malloc+0x310>
    1f48:	6fc030ef          	jal	5644 <printf>
    exit(1);
    1f4c:	4505                	li	a0,1
    1f4e:	2c6030ef          	jal	5214 <exit>
  close(fd);
    1f52:	854a                	mv	a0,s2
    1f54:	2e8030ef          	jal	523c <close>
  exit(0);
    1f58:	4501                	li	a0,0
    1f5a:	2ba030ef          	jal	5214 <exit>

0000000000001f5e <sbrkbasic>:
{
    1f5e:	7139                	addi	sp,sp,-64
    1f60:	fc06                	sd	ra,56(sp)
    1f62:	f822                	sd	s0,48(sp)
    1f64:	ec4e                	sd	s3,24(sp)
    1f66:	0080                	addi	s0,sp,64
    1f68:	89aa                	mv	s3,a0
  pid = fork();
    1f6a:	2a2030ef          	jal	520c <fork>
  if (pid < 0) {
    1f6e:	02054b63          	bltz	a0,1fa4 <sbrkbasic+0x46>
  if (pid == 0) {
    1f72:	e939                	bnez	a0,1fc8 <sbrkbasic+0x6a>
    a = sbrk(TOOMUCH);
    1f74:	40000537          	lui	a0,0x40000
    1f78:	268030ef          	jal	51e0 <sbrk>
    if (a == (char *)SBRK_ERROR) {
    1f7c:	57fd                	li	a5,-1
    1f7e:	02f50f63          	beq	a0,a5,1fbc <sbrkbasic+0x5e>
    1f82:	f426                	sd	s1,40(sp)
    1f84:	f04a                	sd	s2,32(sp)
    1f86:	e852                	sd	s4,16(sp)
    for (b = a; b < a + TOOMUCH; b += PGSIZE) {
    1f88:	400007b7          	lui	a5,0x40000
    1f8c:	97aa                	add	a5,a5,a0
      *b = 99;
    1f8e:	06300693          	li	a3,99
    for (b = a; b < a + TOOMUCH; b += PGSIZE) {
    1f92:	6705                	lui	a4,0x1
      *b = 99;
    1f94:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3ffef318>
    for (b = a; b < a + TOOMUCH; b += PGSIZE) {
    1f98:	953a                	add	a0,a0,a4
    1f9a:	fef51de3          	bne	a0,a5,1f94 <sbrkbasic+0x36>
    exit(1);
    1f9e:	4505                	li	a0,1
    1fa0:	274030ef          	jal	5214 <exit>
    1fa4:	f426                	sd	s1,40(sp)
    1fa6:	f04a                	sd	s2,32(sp)
    1fa8:	e852                	sd	s4,16(sp)
    printf("fork failed in sbrkbasic\n");
    1faa:	00004517          	auipc	a0,0x4
    1fae:	4c650513          	addi	a0,a0,1222 # 6470 <malloc+0xd78>
    1fb2:	692030ef          	jal	5644 <printf>
    exit(1);
    1fb6:	4505                	li	a0,1
    1fb8:	25c030ef          	jal	5214 <exit>
    1fbc:	f426                	sd	s1,40(sp)
    1fbe:	f04a                	sd	s2,32(sp)
    1fc0:	e852                	sd	s4,16(sp)
      exit(0);
    1fc2:	4501                	li	a0,0
    1fc4:	250030ef          	jal	5214 <exit>
  wait(&xstatus);
    1fc8:	fcc40513          	addi	a0,s0,-52
    1fcc:	250030ef          	jal	521c <wait>
  if (xstatus == 1) {
    1fd0:	fcc42703          	lw	a4,-52(s0)
    1fd4:	4785                	li	a5,1
    1fd6:	00f70e63          	beq	a4,a5,1ff2 <sbrkbasic+0x94>
    1fda:	f426                	sd	s1,40(sp)
    1fdc:	f04a                	sd	s2,32(sp)
    1fde:	e852                	sd	s4,16(sp)
  a = sbrk(0);
    1fe0:	4501                	li	a0,0
    1fe2:	1fe030ef          	jal	51e0 <sbrk>
    1fe6:	84aa                	mv	s1,a0
  for (i = 0; i < 5000; i++) {
    1fe8:	4901                	li	s2,0
    1fea:	6a05                	lui	s4,0x1
    1fec:	388a0a13          	addi	s4,s4,904 # 1388 <pipe1+0x4a>
    1ff0:	a839                	j	200e <sbrkbasic+0xb0>
    1ff2:	f426                	sd	s1,40(sp)
    1ff4:	f04a                	sd	s2,32(sp)
    1ff6:	e852                	sd	s4,16(sp)
    printf("%s: too much memory allocated!\n", s);
    1ff8:	85ce                	mv	a1,s3
    1ffa:	00004517          	auipc	a0,0x4
    1ffe:	49650513          	addi	a0,a0,1174 # 6490 <malloc+0xd98>
    2002:	642030ef          	jal	5644 <printf>
    exit(1);
    2006:	4505                	li	a0,1
    2008:	20c030ef          	jal	5214 <exit>
    200c:	84be                	mv	s1,a5
    b = sbrk(1);
    200e:	4505                	li	a0,1
    2010:	1d0030ef          	jal	51e0 <sbrk>
    if (b != a) {
    2014:	04951263          	bne	a0,s1,2058 <sbrkbasic+0xfa>
    *b = 1;
    2018:	4785                	li	a5,1
    201a:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    201e:	00148793          	addi	a5,s1,1
  for (i = 0; i < 5000; i++) {
    2022:	2905                	addiw	s2,s2,1
    2024:	ff4914e3          	bne	s2,s4,200c <sbrkbasic+0xae>
  pid = fork();
    2028:	1e4030ef          	jal	520c <fork>
    202c:	892a                	mv	s2,a0
  if (pid < 0) {
    202e:	04054263          	bltz	a0,2072 <sbrkbasic+0x114>
  c = sbrk(1);
    2032:	4505                	li	a0,1
    2034:	1ac030ef          	jal	51e0 <sbrk>
  c = sbrk(1);
    2038:	4505                	li	a0,1
    203a:	1a6030ef          	jal	51e0 <sbrk>
  if (c != a + 1) {
    203e:	0489                	addi	s1,s1,2
    2040:	04a48363          	beq	s1,a0,2086 <sbrkbasic+0x128>
    printf("%s: sbrk test failed post-fork\n", s);
    2044:	85ce                	mv	a1,s3
    2046:	00004517          	auipc	a0,0x4
    204a:	4aa50513          	addi	a0,a0,1194 # 64f0 <malloc+0xdf8>
    204e:	5f6030ef          	jal	5644 <printf>
    exit(1);
    2052:	4505                	li	a0,1
    2054:	1c0030ef          	jal	5214 <exit>
      printf("%s: sbrk test failed %d %p %p\n", s, i, a, b);
    2058:	872a                	mv	a4,a0
    205a:	86a6                	mv	a3,s1
    205c:	864a                	mv	a2,s2
    205e:	85ce                	mv	a1,s3
    2060:	00004517          	auipc	a0,0x4
    2064:	45050513          	addi	a0,a0,1104 # 64b0 <malloc+0xdb8>
    2068:	5dc030ef          	jal	5644 <printf>
      exit(1);
    206c:	4505                	li	a0,1
    206e:	1a6030ef          	jal	5214 <exit>
    printf("%s: sbrk test fork failed\n", s);
    2072:	85ce                	mv	a1,s3
    2074:	00004517          	auipc	a0,0x4
    2078:	45c50513          	addi	a0,a0,1116 # 64d0 <malloc+0xdd8>
    207c:	5c8030ef          	jal	5644 <printf>
    exit(1);
    2080:	4505                	li	a0,1
    2082:	192030ef          	jal	5214 <exit>
  if (pid == 0)
    2086:	00091563          	bnez	s2,2090 <sbrkbasic+0x132>
    exit(0);
    208a:	4501                	li	a0,0
    208c:	188030ef          	jal	5214 <exit>
  wait(&xstatus);
    2090:	fcc40513          	addi	a0,s0,-52
    2094:	188030ef          	jal	521c <wait>
  exit(xstatus);
    2098:	fcc42503          	lw	a0,-52(s0)
    209c:	178030ef          	jal	5214 <exit>

00000000000020a0 <sbrkmuch>:
{
    20a0:	7179                	addi	sp,sp,-48
    20a2:	f406                	sd	ra,40(sp)
    20a4:	f022                	sd	s0,32(sp)
    20a6:	ec26                	sd	s1,24(sp)
    20a8:	e84a                	sd	s2,16(sp)
    20aa:	e44e                	sd	s3,8(sp)
    20ac:	e052                	sd	s4,0(sp)
    20ae:	1800                	addi	s0,sp,48
    20b0:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    20b2:	4501                	li	a0,0
    20b4:	12c030ef          	jal	51e0 <sbrk>
    20b8:	892a                	mv	s2,a0
  a = sbrk(0);
    20ba:	4501                	li	a0,0
    20bc:	124030ef          	jal	51e0 <sbrk>
    20c0:	84aa                	mv	s1,a0
  p = sbrk(amt);
    20c2:	06400537          	lui	a0,0x6400
    20c6:	9d05                	subw	a0,a0,s1
    20c8:	118030ef          	jal	51e0 <sbrk>
  if (p != a) {
    20cc:	08a49763          	bne	s1,a0,215a <sbrkmuch+0xba>
  *lastaddr = 99;
    20d0:	064007b7          	lui	a5,0x6400
    20d4:	06300713          	li	a4,99
    20d8:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63ef317>
  a = sbrk(0);
    20dc:	4501                	li	a0,0
    20de:	102030ef          	jal	51e0 <sbrk>
    20e2:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    20e4:	757d                	lui	a0,0xfffff
    20e6:	0fa030ef          	jal	51e0 <sbrk>
  if (c == (char *)SBRK_ERROR) {
    20ea:	57fd                	li	a5,-1
    20ec:	08f50163          	beq	a0,a5,216e <sbrkmuch+0xce>
  c = sbrk(0);
    20f0:	4501                	li	a0,0
    20f2:	0ee030ef          	jal	51e0 <sbrk>
  if (c != a - PGSIZE) {
    20f6:	77fd                	lui	a5,0xfffff
    20f8:	97a6                	add	a5,a5,s1
    20fa:	08f51463          	bne	a0,a5,2182 <sbrkmuch+0xe2>
  a = sbrk(0);
    20fe:	4501                	li	a0,0
    2100:	0e0030ef          	jal	51e0 <sbrk>
    2104:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2106:	6505                	lui	a0,0x1
    2108:	0d8030ef          	jal	51e0 <sbrk>
    210c:	8a2a                	mv	s4,a0
  if (c != a || sbrk(0) != a + PGSIZE) {
    210e:	08a49663          	bne	s1,a0,219a <sbrkmuch+0xfa>
    2112:	4501                	li	a0,0
    2114:	0cc030ef          	jal	51e0 <sbrk>
    2118:	6785                	lui	a5,0x1
    211a:	97a6                	add	a5,a5,s1
    211c:	06f51f63          	bne	a0,a5,219a <sbrkmuch+0xfa>
  if (*lastaddr == 99) {
    2120:	064007b7          	lui	a5,0x6400
    2124:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63ef317>
    2128:	06300793          	li	a5,99
    212c:	08f70363          	beq	a4,a5,21b2 <sbrkmuch+0x112>
  a = sbrk(0);
    2130:	4501                	li	a0,0
    2132:	0ae030ef          	jal	51e0 <sbrk>
    2136:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2138:	4501                	li	a0,0
    213a:	0a6030ef          	jal	51e0 <sbrk>
    213e:	40a9053b          	subw	a0,s2,a0
    2142:	09e030ef          	jal	51e0 <sbrk>
  if (c != a) {
    2146:	08a49063          	bne	s1,a0,21c6 <sbrkmuch+0x126>
}
    214a:	70a2                	ld	ra,40(sp)
    214c:	7402                	ld	s0,32(sp)
    214e:	64e2                	ld	s1,24(sp)
    2150:	6942                	ld	s2,16(sp)
    2152:	69a2                	ld	s3,8(sp)
    2154:	6a02                	ld	s4,0(sp)
    2156:	6145                	addi	sp,sp,48
    2158:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n",
    215a:	85ce                	mv	a1,s3
    215c:	00004517          	auipc	a0,0x4
    2160:	3b450513          	addi	a0,a0,948 # 6510 <malloc+0xe18>
    2164:	4e0030ef          	jal	5644 <printf>
    exit(1);
    2168:	4505                	li	a0,1
    216a:	0aa030ef          	jal	5214 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    216e:	85ce                	mv	a1,s3
    2170:	00004517          	auipc	a0,0x4
    2174:	3e850513          	addi	a0,a0,1000 # 6558 <malloc+0xe60>
    2178:	4cc030ef          	jal	5644 <printf>
    exit(1);
    217c:	4505                	li	a0,1
    217e:	096030ef          	jal	5214 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %p c %p\n", s, a,
    2182:	86aa                	mv	a3,a0
    2184:	8626                	mv	a2,s1
    2186:	85ce                	mv	a1,s3
    2188:	00004517          	auipc	a0,0x4
    218c:	3f050513          	addi	a0,a0,1008 # 6578 <malloc+0xe80>
    2190:	4b4030ef          	jal	5644 <printf>
    exit(1);
    2194:	4505                	li	a0,1
    2196:	07e030ef          	jal	5214 <exit>
    printf("%s: sbrk re-allocation failed, a %p c %p\n", s, a, c);
    219a:	86d2                	mv	a3,s4
    219c:	8626                	mv	a2,s1
    219e:	85ce                	mv	a1,s3
    21a0:	00004517          	auipc	a0,0x4
    21a4:	41850513          	addi	a0,a0,1048 # 65b8 <malloc+0xec0>
    21a8:	49c030ef          	jal	5644 <printf>
    exit(1);
    21ac:	4505                	li	a0,1
    21ae:	066030ef          	jal	5214 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    21b2:	85ce                	mv	a1,s3
    21b4:	00004517          	auipc	a0,0x4
    21b8:	43450513          	addi	a0,a0,1076 # 65e8 <malloc+0xef0>
    21bc:	488030ef          	jal	5644 <printf>
    exit(1);
    21c0:	4505                	li	a0,1
    21c2:	052030ef          	jal	5214 <exit>
    printf("%s: sbrk downsize failed, a %p c %p\n", s, a, c);
    21c6:	86aa                	mv	a3,a0
    21c8:	8626                	mv	a2,s1
    21ca:	85ce                	mv	a1,s3
    21cc:	00004517          	auipc	a0,0x4
    21d0:	45450513          	addi	a0,a0,1108 # 6620 <malloc+0xf28>
    21d4:	470030ef          	jal	5644 <printf>
    exit(1);
    21d8:	4505                	li	a0,1
    21da:	03a030ef          	jal	5214 <exit>

00000000000021de <sbrkarg>:
{
    21de:	7179                	addi	sp,sp,-48
    21e0:	f406                	sd	ra,40(sp)
    21e2:	f022                	sd	s0,32(sp)
    21e4:	ec26                	sd	s1,24(sp)
    21e6:	e84a                	sd	s2,16(sp)
    21e8:	e44e                	sd	s3,8(sp)
    21ea:	1800                	addi	s0,sp,48
    21ec:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    21ee:	6505                	lui	a0,0x1
    21f0:	7f1020ef          	jal	51e0 <sbrk>
    21f4:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE | O_WRONLY);
    21f6:	20100593          	li	a1,513
    21fa:	00004517          	auipc	a0,0x4
    21fe:	44e50513          	addi	a0,a0,1102 # 6648 <malloc+0xf50>
    2202:	052030ef          	jal	5254 <open>
    2206:	84aa                	mv	s1,a0
  unlink("sbrk");
    2208:	00004517          	auipc	a0,0x4
    220c:	44050513          	addi	a0,a0,1088 # 6648 <malloc+0xf50>
    2210:	054030ef          	jal	5264 <unlink>
  if (fd < 0) {
    2214:	0204c963          	bltz	s1,2246 <sbrkarg+0x68>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2218:	6605                	lui	a2,0x1
    221a:	85ca                	mv	a1,s2
    221c:	8526                	mv	a0,s1
    221e:	016030ef          	jal	5234 <write>
    2222:	02054c63          	bltz	a0,225a <sbrkarg+0x7c>
  close(fd);
    2226:	8526                	mv	a0,s1
    2228:	014030ef          	jal	523c <close>
  a = sbrk(PGSIZE);
    222c:	6505                	lui	a0,0x1
    222e:	7b3020ef          	jal	51e0 <sbrk>
  if (pipe((int *)a) != 0) {
    2232:	7f3020ef          	jal	5224 <pipe>
    2236:	ed05                	bnez	a0,226e <sbrkarg+0x90>
}
    2238:	70a2                	ld	ra,40(sp)
    223a:	7402                	ld	s0,32(sp)
    223c:	64e2                	ld	s1,24(sp)
    223e:	6942                	ld	s2,16(sp)
    2240:	69a2                	ld	s3,8(sp)
    2242:	6145                	addi	sp,sp,48
    2244:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2246:	85ce                	mv	a1,s3
    2248:	00004517          	auipc	a0,0x4
    224c:	40850513          	addi	a0,a0,1032 # 6650 <malloc+0xf58>
    2250:	3f4030ef          	jal	5644 <printf>
    exit(1);
    2254:	4505                	li	a0,1
    2256:	7bf020ef          	jal	5214 <exit>
    printf("%s: write sbrk failed\n", s);
    225a:	85ce                	mv	a1,s3
    225c:	00004517          	auipc	a0,0x4
    2260:	40c50513          	addi	a0,a0,1036 # 6668 <malloc+0xf70>
    2264:	3e0030ef          	jal	5644 <printf>
    exit(1);
    2268:	4505                	li	a0,1
    226a:	7ab020ef          	jal	5214 <exit>
    printf("%s: pipe() failed\n", s);
    226e:	85ce                	mv	a1,s3
    2270:	00004517          	auipc	a0,0x4
    2274:	ed050513          	addi	a0,a0,-304 # 6140 <malloc+0xa48>
    2278:	3cc030ef          	jal	5644 <printf>
    exit(1);
    227c:	4505                	li	a0,1
    227e:	797020ef          	jal	5214 <exit>

0000000000002282 <argptest>:
{
    2282:	1101                	addi	sp,sp,-32
    2284:	ec06                	sd	ra,24(sp)
    2286:	e822                	sd	s0,16(sp)
    2288:	e426                	sd	s1,8(sp)
    228a:	e04a                	sd	s2,0(sp)
    228c:	1000                	addi	s0,sp,32
    228e:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2290:	4581                	li	a1,0
    2292:	00004517          	auipc	a0,0x4
    2296:	3ee50513          	addi	a0,a0,1006 # 6680 <malloc+0xf88>
    229a:	7bb020ef          	jal	5254 <open>
  if (fd < 0) {
    229e:	02054563          	bltz	a0,22c8 <argptest+0x46>
    22a2:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    22a4:	4501                	li	a0,0
    22a6:	73b020ef          	jal	51e0 <sbrk>
    22aa:	567d                	li	a2,-1
    22ac:	fff50593          	addi	a1,a0,-1
    22b0:	8526                	mv	a0,s1
    22b2:	77b020ef          	jal	522c <read>
  close(fd);
    22b6:	8526                	mv	a0,s1
    22b8:	785020ef          	jal	523c <close>
}
    22bc:	60e2                	ld	ra,24(sp)
    22be:	6442                	ld	s0,16(sp)
    22c0:	64a2                	ld	s1,8(sp)
    22c2:	6902                	ld	s2,0(sp)
    22c4:	6105                	addi	sp,sp,32
    22c6:	8082                	ret
    printf("%s: open failed\n", s);
    22c8:	85ca                	mv	a1,s2
    22ca:	00004517          	auipc	a0,0x4
    22ce:	e0650513          	addi	a0,a0,-506 # 60d0 <malloc+0x9d8>
    22d2:	372030ef          	jal	5644 <printf>
    exit(1);
    22d6:	4505                	li	a0,1
    22d8:	73d020ef          	jal	5214 <exit>

00000000000022dc <sbrkbugs>:
{
    22dc:	1141                	addi	sp,sp,-16
    22de:	e406                	sd	ra,8(sp)
    22e0:	e022                	sd	s0,0(sp)
    22e2:	0800                	addi	s0,sp,16
  int pid = fork();
    22e4:	729020ef          	jal	520c <fork>
  if (pid < 0) {
    22e8:	00054c63          	bltz	a0,2300 <sbrkbugs+0x24>
  if (pid == 0) {
    22ec:	e11d                	bnez	a0,2312 <sbrkbugs+0x36>
    int sz = (uint64)sbrk(0);
    22ee:	6f3020ef          	jal	51e0 <sbrk>
    sbrk(-sz);
    22f2:	40a0053b          	negw	a0,a0
    22f6:	6eb020ef          	jal	51e0 <sbrk>
    exit(0);
    22fa:	4501                	li	a0,0
    22fc:	719020ef          	jal	5214 <exit>
    printf("fork failed\n");
    2300:	00005517          	auipc	a0,0x5
    2304:	47850513          	addi	a0,a0,1144 # 7778 <malloc+0x2080>
    2308:	33c030ef          	jal	5644 <printf>
    exit(1);
    230c:	4505                	li	a0,1
    230e:	707020ef          	jal	5214 <exit>
  wait(0);
    2312:	4501                	li	a0,0
    2314:	709020ef          	jal	521c <wait>
  pid = fork();
    2318:	6f5020ef          	jal	520c <fork>
  if (pid < 0) {
    231c:	00054f63          	bltz	a0,233a <sbrkbugs+0x5e>
  if (pid == 0) {
    2320:	e515                	bnez	a0,234c <sbrkbugs+0x70>
    int sz = (uint64)sbrk(0);
    2322:	6bf020ef          	jal	51e0 <sbrk>
    sbrk(-(sz - 3500));
    2326:	6785                	lui	a5,0x1
    2328:	dac7879b          	addiw	a5,a5,-596 # dac <linktest+0x138>
    232c:	40a7853b          	subw	a0,a5,a0
    2330:	6b1020ef          	jal	51e0 <sbrk>
    exit(0);
    2334:	4501                	li	a0,0
    2336:	6df020ef          	jal	5214 <exit>
    printf("fork failed\n");
    233a:	00005517          	auipc	a0,0x5
    233e:	43e50513          	addi	a0,a0,1086 # 7778 <malloc+0x2080>
    2342:	302030ef          	jal	5644 <printf>
    exit(1);
    2346:	4505                	li	a0,1
    2348:	6cd020ef          	jal	5214 <exit>
  wait(0);
    234c:	4501                	li	a0,0
    234e:	6cf020ef          	jal	521c <wait>
  pid = fork();
    2352:	6bb020ef          	jal	520c <fork>
  if (pid < 0) {
    2356:	02054263          	bltz	a0,237a <sbrkbugs+0x9e>
  if (pid == 0) {
    235a:	e90d                	bnez	a0,238c <sbrkbugs+0xb0>
    sbrk((10 * PGSIZE + 2048) - (uint64)sbrk(0));
    235c:	685020ef          	jal	51e0 <sbrk>
    2360:	67ad                	lui	a5,0xb
    2362:	8007879b          	addiw	a5,a5,-2048 # a800 <big.0+0x230>
    2366:	40a7853b          	subw	a0,a5,a0
    236a:	677020ef          	jal	51e0 <sbrk>
    sbrk(-10);
    236e:	5559                	li	a0,-10
    2370:	671020ef          	jal	51e0 <sbrk>
    exit(0);
    2374:	4501                	li	a0,0
    2376:	69f020ef          	jal	5214 <exit>
    printf("fork failed\n");
    237a:	00005517          	auipc	a0,0x5
    237e:	3fe50513          	addi	a0,a0,1022 # 7778 <malloc+0x2080>
    2382:	2c2030ef          	jal	5644 <printf>
    exit(1);
    2386:	4505                	li	a0,1
    2388:	68d020ef          	jal	5214 <exit>
  wait(0);
    238c:	4501                	li	a0,0
    238e:	68f020ef          	jal	521c <wait>
  exit(0);
    2392:	4501                	li	a0,0
    2394:	681020ef          	jal	5214 <exit>

0000000000002398 <sbrklast>:
{
    2398:	7179                	addi	sp,sp,-48
    239a:	f406                	sd	ra,40(sp)
    239c:	f022                	sd	s0,32(sp)
    239e:	ec26                	sd	s1,24(sp)
    23a0:	e84a                	sd	s2,16(sp)
    23a2:	e44e                	sd	s3,8(sp)
    23a4:	e052                	sd	s4,0(sp)
    23a6:	1800                	addi	s0,sp,48
  uint64 top = (uint64)sbrk(0);
    23a8:	4501                	li	a0,0
    23aa:	637020ef          	jal	51e0 <sbrk>
  if ((top % PGSIZE) != 0)
    23ae:	03451793          	slli	a5,a0,0x34
    23b2:	ebad                	bnez	a5,2424 <sbrklast+0x8c>
  sbrk(PGSIZE);
    23b4:	6505                	lui	a0,0x1
    23b6:	62b020ef          	jal	51e0 <sbrk>
  sbrk(10);
    23ba:	4529                	li	a0,10
    23bc:	625020ef          	jal	51e0 <sbrk>
  sbrk(-20);
    23c0:	5531                	li	a0,-20
    23c2:	61f020ef          	jal	51e0 <sbrk>
  top = (uint64)sbrk(0);
    23c6:	4501                	li	a0,0
    23c8:	619020ef          	jal	51e0 <sbrk>
    23cc:	84aa                	mv	s1,a0
  char *p = (char *)(top - 64);
    23ce:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0x122>
  p[0] = 'x';
    23d2:	07800a13          	li	s4,120
    23d6:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    23da:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR | O_CREATE);
    23de:	20200593          	li	a1,514
    23e2:	854a                	mv	a0,s2
    23e4:	671020ef          	jal	5254 <open>
    23e8:	89aa                	mv	s3,a0
  write(fd, p, 1);
    23ea:	4605                	li	a2,1
    23ec:	85ca                	mv	a1,s2
    23ee:	647020ef          	jal	5234 <write>
  close(fd);
    23f2:	854e                	mv	a0,s3
    23f4:	649020ef          	jal	523c <close>
  fd = open(p, O_RDWR);
    23f8:	4589                	li	a1,2
    23fa:	854a                	mv	a0,s2
    23fc:	659020ef          	jal	5254 <open>
  p[0] = '\0';
    2400:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2404:	4605                	li	a2,1
    2406:	85ca                	mv	a1,s2
    2408:	625020ef          	jal	522c <read>
  if (p[0] != 'x')
    240c:	fc04c783          	lbu	a5,-64(s1)
    2410:	03479263          	bne	a5,s4,2434 <sbrklast+0x9c>
}
    2414:	70a2                	ld	ra,40(sp)
    2416:	7402                	ld	s0,32(sp)
    2418:	64e2                	ld	s1,24(sp)
    241a:	6942                	ld	s2,16(sp)
    241c:	69a2                	ld	s3,8(sp)
    241e:	6a02                	ld	s4,0(sp)
    2420:	6145                	addi	sp,sp,48
    2422:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    2424:	0347d513          	srli	a0,a5,0x34
    2428:	6785                	lui	a5,0x1
    242a:	40a7853b          	subw	a0,a5,a0
    242e:	5b3020ef          	jal	51e0 <sbrk>
    2432:	b749                	j	23b4 <sbrklast+0x1c>
    exit(1);
    2434:	4505                	li	a0,1
    2436:	5df020ef          	jal	5214 <exit>

000000000000243a <sbrk8000>:
{
    243a:	1141                	addi	sp,sp,-16
    243c:	e406                	sd	ra,8(sp)
    243e:	e022                	sd	s0,0(sp)
    2440:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2442:	80000537          	lui	a0,0x80000
    2446:	0511                	addi	a0,a0,4 # ffffffff80000004 <base+0xffffffff7ffef31c>
    2448:	599020ef          	jal	51e0 <sbrk>
  volatile char *top = sbrk(0);
    244c:	4501                	li	a0,0
    244e:	593020ef          	jal	51e0 <sbrk>
  *(top - 1) = *(top - 1) + 1;
    2452:	fff54783          	lbu	a5,-1(a0)
    2456:	2785                	addiw	a5,a5,1 # 1001 <badarg+0x1>
    2458:	0ff7f793          	zext.b	a5,a5
    245c:	fef50fa3          	sb	a5,-1(a0)
}
    2460:	60a2                	ld	ra,8(sp)
    2462:	6402                	ld	s0,0(sp)
    2464:	0141                	addi	sp,sp,16
    2466:	8082                	ret

0000000000002468 <execout>:
{
    2468:	715d                	addi	sp,sp,-80
    246a:	e486                	sd	ra,72(sp)
    246c:	e0a2                	sd	s0,64(sp)
    246e:	fc26                	sd	s1,56(sp)
    2470:	f84a                	sd	s2,48(sp)
    2472:	f44e                	sd	s3,40(sp)
    2474:	f052                	sd	s4,32(sp)
    2476:	0880                	addi	s0,sp,80
  for (int avail = 0; avail < 15; avail++) {
    2478:	4901                	li	s2,0
    247a:	49bd                	li	s3,15
    int pid = fork();
    247c:	591020ef          	jal	520c <fork>
    2480:	84aa                	mv	s1,a0
    if (pid < 0) {
    2482:	00054c63          	bltz	a0,249a <execout+0x32>
    } else if (pid == 0) {
    2486:	c11d                	beqz	a0,24ac <execout+0x44>
      wait((int *)0);
    2488:	4501                	li	a0,0
    248a:	593020ef          	jal	521c <wait>
  for (int avail = 0; avail < 15; avail++) {
    248e:	2905                	addiw	s2,s2,1
    2490:	ff3916e3          	bne	s2,s3,247c <execout+0x14>
  exit(0);
    2494:	4501                	li	a0,0
    2496:	57f020ef          	jal	5214 <exit>
      printf("fork failed\n");
    249a:	00005517          	auipc	a0,0x5
    249e:	2de50513          	addi	a0,a0,734 # 7778 <malloc+0x2080>
    24a2:	1a2030ef          	jal	5644 <printf>
      exit(1);
    24a6:	4505                	li	a0,1
    24a8:	56d020ef          	jal	5214 <exit>
        if (a == SBRK_ERROR)
    24ac:	59fd                	li	s3,-1
        *(a + PGSIZE - 1) = 1;
    24ae:	4a05                	li	s4,1
        char *a = sbrk(PGSIZE);
    24b0:	6505                	lui	a0,0x1
    24b2:	52f020ef          	jal	51e0 <sbrk>
        if (a == SBRK_ERROR)
    24b6:	01350763          	beq	a0,s3,24c4 <execout+0x5c>
        *(a + PGSIZE - 1) = 1;
    24ba:	6785                	lui	a5,0x1
    24bc:	953e                	add	a0,a0,a5
    24be:	ff450fa3          	sb	s4,-1(a0) # fff <pgbug+0x2b>
      while (1) {
    24c2:	b7fd                	j	24b0 <execout+0x48>
      for (int i = 0; i < avail; i++)
    24c4:	01205863          	blez	s2,24d4 <execout+0x6c>
        sbrk(-PGSIZE);
    24c8:	757d                	lui	a0,0xfffff
    24ca:	517020ef          	jal	51e0 <sbrk>
      for (int i = 0; i < avail; i++)
    24ce:	2485                	addiw	s1,s1,1
    24d0:	ff249ce3          	bne	s1,s2,24c8 <execout+0x60>
      close(1);
    24d4:	4505                	li	a0,1
    24d6:	567020ef          	jal	523c <close>
      char *args[] = {"echo", "x", 0};
    24da:	00003517          	auipc	a0,0x3
    24de:	34e50513          	addi	a0,a0,846 # 5828 <malloc+0x130>
    24e2:	faa43c23          	sd	a0,-72(s0)
    24e6:	00003797          	auipc	a5,0x3
    24ea:	3b278793          	addi	a5,a5,946 # 5898 <malloc+0x1a0>
    24ee:	fcf43023          	sd	a5,-64(s0)
    24f2:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    24f6:	fb840593          	addi	a1,s0,-72
    24fa:	553020ef          	jal	524c <exec>
      exit(0);
    24fe:	4501                	li	a0,0
    2500:	515020ef          	jal	5214 <exit>

0000000000002504 <fourteen>:
{
    2504:	1101                	addi	sp,sp,-32
    2506:	ec06                	sd	ra,24(sp)
    2508:	e822                	sd	s0,16(sp)
    250a:	e426                	sd	s1,8(sp)
    250c:	1000                	addi	s0,sp,32
    250e:	84aa                	mv	s1,a0
  if (mkdir("12345678901234") != 0) {
    2510:	00004517          	auipc	a0,0x4
    2514:	34850513          	addi	a0,a0,840 # 6858 <malloc+0x1160>
    2518:	565020ef          	jal	527c <mkdir>
    251c:	e555                	bnez	a0,25c8 <fourteen+0xc4>
  if (mkdir("12345678901234/123456789012345") != 0) {
    251e:	00004517          	auipc	a0,0x4
    2522:	19250513          	addi	a0,a0,402 # 66b0 <malloc+0xfb8>
    2526:	557020ef          	jal	527c <mkdir>
    252a:	e94d                	bnez	a0,25dc <fourteen+0xd8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    252c:	20000593          	li	a1,512
    2530:	00004517          	auipc	a0,0x4
    2534:	1d850513          	addi	a0,a0,472 # 6708 <malloc+0x1010>
    2538:	51d020ef          	jal	5254 <open>
  if (fd < 0) {
    253c:	0a054a63          	bltz	a0,25f0 <fourteen+0xec>
  close(fd);
    2540:	4fd020ef          	jal	523c <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2544:	4581                	li	a1,0
    2546:	00004517          	auipc	a0,0x4
    254a:	23a50513          	addi	a0,a0,570 # 6780 <malloc+0x1088>
    254e:	507020ef          	jal	5254 <open>
  if (fd < 0) {
    2552:	0a054963          	bltz	a0,2604 <fourteen+0x100>
  close(fd);
    2556:	4e7020ef          	jal	523c <close>
  if (mkdir("12345678901234/12345678901234") == 0) {
    255a:	00004517          	auipc	a0,0x4
    255e:	29650513          	addi	a0,a0,662 # 67f0 <malloc+0x10f8>
    2562:	51b020ef          	jal	527c <mkdir>
    2566:	c94d                	beqz	a0,2618 <fourteen+0x114>
  if (mkdir("123456789012345/12345678901234") == 0) {
    2568:	00004517          	auipc	a0,0x4
    256c:	2e050513          	addi	a0,a0,736 # 6848 <malloc+0x1150>
    2570:	50d020ef          	jal	527c <mkdir>
    2574:	cd45                	beqz	a0,262c <fourteen+0x128>
  unlink("123456789012345/12345678901234");
    2576:	00004517          	auipc	a0,0x4
    257a:	2d250513          	addi	a0,a0,722 # 6848 <malloc+0x1150>
    257e:	4e7020ef          	jal	5264 <unlink>
  unlink("12345678901234/12345678901234");
    2582:	00004517          	auipc	a0,0x4
    2586:	26e50513          	addi	a0,a0,622 # 67f0 <malloc+0x10f8>
    258a:	4db020ef          	jal	5264 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    258e:	00004517          	auipc	a0,0x4
    2592:	1f250513          	addi	a0,a0,498 # 6780 <malloc+0x1088>
    2596:	4cf020ef          	jal	5264 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    259a:	00004517          	auipc	a0,0x4
    259e:	16e50513          	addi	a0,a0,366 # 6708 <malloc+0x1010>
    25a2:	4c3020ef          	jal	5264 <unlink>
  unlink("12345678901234/123456789012345");
    25a6:	00004517          	auipc	a0,0x4
    25aa:	10a50513          	addi	a0,a0,266 # 66b0 <malloc+0xfb8>
    25ae:	4b7020ef          	jal	5264 <unlink>
  unlink("12345678901234");
    25b2:	00004517          	auipc	a0,0x4
    25b6:	2a650513          	addi	a0,a0,678 # 6858 <malloc+0x1160>
    25ba:	4ab020ef          	jal	5264 <unlink>
}
    25be:	60e2                	ld	ra,24(sp)
    25c0:	6442                	ld	s0,16(sp)
    25c2:	64a2                	ld	s1,8(sp)
    25c4:	6105                	addi	sp,sp,32
    25c6:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    25c8:	85a6                	mv	a1,s1
    25ca:	00004517          	auipc	a0,0x4
    25ce:	0be50513          	addi	a0,a0,190 # 6688 <malloc+0xf90>
    25d2:	072030ef          	jal	5644 <printf>
    exit(1);
    25d6:	4505                	li	a0,1
    25d8:	43d020ef          	jal	5214 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    25dc:	85a6                	mv	a1,s1
    25de:	00004517          	auipc	a0,0x4
    25e2:	0f250513          	addi	a0,a0,242 # 66d0 <malloc+0xfd8>
    25e6:	05e030ef          	jal	5644 <printf>
    exit(1);
    25ea:	4505                	li	a0,1
    25ec:	429020ef          	jal	5214 <exit>
    printf(
    25f0:	85a6                	mv	a1,s1
    25f2:	00004517          	auipc	a0,0x4
    25f6:	14650513          	addi	a0,a0,326 # 6738 <malloc+0x1040>
    25fa:	04a030ef          	jal	5644 <printf>
    exit(1);
    25fe:	4505                	li	a0,1
    2600:	415020ef          	jal	5214 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    2604:	85a6                	mv	a1,s1
    2606:	00004517          	auipc	a0,0x4
    260a:	1aa50513          	addi	a0,a0,426 # 67b0 <malloc+0x10b8>
    260e:	036030ef          	jal	5644 <printf>
    exit(1);
    2612:	4505                	li	a0,1
    2614:	401020ef          	jal	5214 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    2618:	85a6                	mv	a1,s1
    261a:	00004517          	auipc	a0,0x4
    261e:	1f650513          	addi	a0,a0,502 # 6810 <malloc+0x1118>
    2622:	022030ef          	jal	5644 <printf>
    exit(1);
    2626:	4505                	li	a0,1
    2628:	3ed020ef          	jal	5214 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    262c:	85a6                	mv	a1,s1
    262e:	00004517          	auipc	a0,0x4
    2632:	23a50513          	addi	a0,a0,570 # 6868 <malloc+0x1170>
    2636:	00e030ef          	jal	5644 <printf>
    exit(1);
    263a:	4505                	li	a0,1
    263c:	3d9020ef          	jal	5214 <exit>

0000000000002640 <diskfull>:
{
    2640:	b8010113          	addi	sp,sp,-1152
    2644:	46113c23          	sd	ra,1144(sp)
    2648:	46813823          	sd	s0,1136(sp)
    264c:	46913423          	sd	s1,1128(sp)
    2650:	47213023          	sd	s2,1120(sp)
    2654:	45313c23          	sd	s3,1112(sp)
    2658:	45413823          	sd	s4,1104(sp)
    265c:	45513423          	sd	s5,1096(sp)
    2660:	45613023          	sd	s6,1088(sp)
    2664:	43713c23          	sd	s7,1080(sp)
    2668:	43813823          	sd	s8,1072(sp)
    266c:	43913423          	sd	s9,1064(sp)
    2670:	48010413          	addi	s0,sp,1152
    2674:	8caa                	mv	s9,a0
  unlink("diskfulldir");
    2676:	00004517          	auipc	a0,0x4
    267a:	22a50513          	addi	a0,a0,554 # 68a0 <malloc+0x11a8>
    267e:	3e7020ef          	jal	5264 <unlink>
    2682:	03000993          	li	s3,48
    name[0] = 'b';
    2686:	06200b13          	li	s6,98
    name[1] = 'i';
    268a:	06900a93          	li	s5,105
    name[2] = 'g';
    268e:	06700a13          	li	s4,103
    2692:	10c00b93          	li	s7,268
  for (fi = 0; done == 0 && '0' + fi < 0177; fi++) {
    2696:	07f00c13          	li	s8,127
    269a:	aab9                	j	27f8 <diskfull+0x1b8>
      printf("%s: could not create file %s\n", s, name);
    269c:	b8040613          	addi	a2,s0,-1152
    26a0:	85e6                	mv	a1,s9
    26a2:	00004517          	auipc	a0,0x4
    26a6:	20e50513          	addi	a0,a0,526 # 68b0 <malloc+0x11b8>
    26aa:	79b020ef          	jal	5644 <printf>
      break;
    26ae:	a039                	j	26bc <diskfull+0x7c>
        close(fd);
    26b0:	854a                	mv	a0,s2
    26b2:	38b020ef          	jal	523c <close>
    close(fd);
    26b6:	854a                	mv	a0,s2
    26b8:	385020ef          	jal	523c <close>
  for (int i = 0; i < nzz; i++) {
    26bc:	4481                	li	s1,0
    name[0] = 'z';
    26be:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
    26c2:	08000993          	li	s3,128
    name[0] = 'z';
    26c6:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    26ca:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    26ce:	41f4d71b          	sraiw	a4,s1,0x1f
    26d2:	01b7571b          	srliw	a4,a4,0x1b
    26d6:	009707bb          	addw	a5,a4,s1
    26da:	4057d69b          	sraiw	a3,a5,0x5
    26de:	0306869b          	addiw	a3,a3,48
    26e2:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    26e6:	8bfd                	andi	a5,a5,31
    26e8:	9f99                	subw	a5,a5,a4
    26ea:	0307879b          	addiw	a5,a5,48
    26ee:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    26f2:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    26f6:	ba040513          	addi	a0,s0,-1120
    26fa:	36b020ef          	jal	5264 <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
    26fe:	60200593          	li	a1,1538
    2702:	ba040513          	addi	a0,s0,-1120
    2706:	34f020ef          	jal	5254 <open>
    if (fd < 0)
    270a:	00054763          	bltz	a0,2718 <diskfull+0xd8>
    close(fd);
    270e:	32f020ef          	jal	523c <close>
  for (int i = 0; i < nzz; i++) {
    2712:	2485                	addiw	s1,s1,1
    2714:	fb3499e3          	bne	s1,s3,26c6 <diskfull+0x86>
  if (mkdir("diskfulldir") == 0)
    2718:	00004517          	auipc	a0,0x4
    271c:	18850513          	addi	a0,a0,392 # 68a0 <malloc+0x11a8>
    2720:	35d020ef          	jal	527c <mkdir>
    2724:	12050063          	beqz	a0,2844 <diskfull+0x204>
  unlink("diskfulldir");
    2728:	00004517          	auipc	a0,0x4
    272c:	17850513          	addi	a0,a0,376 # 68a0 <malloc+0x11a8>
    2730:	335020ef          	jal	5264 <unlink>
  for (int i = 0; i < nzz; i++) {
    2734:	4481                	li	s1,0
    name[0] = 'z';
    2736:	07a00913          	li	s2,122
  for (int i = 0; i < nzz; i++) {
    273a:	08000993          	li	s3,128
    name[0] = 'z';
    273e:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    2742:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    2746:	41f4d71b          	sraiw	a4,s1,0x1f
    274a:	01b7571b          	srliw	a4,a4,0x1b
    274e:	009707bb          	addw	a5,a4,s1
    2752:	4057d69b          	sraiw	a3,a5,0x5
    2756:	0306869b          	addiw	a3,a3,48
    275a:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    275e:	8bfd                	andi	a5,a5,31
    2760:	9f99                	subw	a5,a5,a4
    2762:	0307879b          	addiw	a5,a5,48
    2766:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    276a:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    276e:	ba040513          	addi	a0,s0,-1120
    2772:	2f3020ef          	jal	5264 <unlink>
  for (int i = 0; i < nzz; i++) {
    2776:	2485                	addiw	s1,s1,1
    2778:	fd3493e3          	bne	s1,s3,273e <diskfull+0xfe>
    277c:	03000493          	li	s1,48
    name[0] = 'b';
    2780:	06200a93          	li	s5,98
    name[1] = 'i';
    2784:	06900a13          	li	s4,105
    name[2] = 'g';
    2788:	06700993          	li	s3,103
  for (int i = 0; '0' + i < 0177; i++) {
    278c:	07f00913          	li	s2,127
    name[0] = 'b';
    2790:	bb540023          	sb	s5,-1120(s0)
    name[1] = 'i';
    2794:	bb4400a3          	sb	s4,-1119(s0)
    name[2] = 'g';
    2798:	bb340123          	sb	s3,-1118(s0)
    name[3] = '0' + i;
    279c:	ba9401a3          	sb	s1,-1117(s0)
    name[4] = '\0';
    27a0:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    27a4:	ba040513          	addi	a0,s0,-1120
    27a8:	2bd020ef          	jal	5264 <unlink>
  for (int i = 0; '0' + i < 0177; i++) {
    27ac:	2485                	addiw	s1,s1,1
    27ae:	0ff4f493          	zext.b	s1,s1
    27b2:	fd249fe3          	bne	s1,s2,2790 <diskfull+0x150>
}
    27b6:	47813083          	ld	ra,1144(sp)
    27ba:	47013403          	ld	s0,1136(sp)
    27be:	46813483          	ld	s1,1128(sp)
    27c2:	46013903          	ld	s2,1120(sp)
    27c6:	45813983          	ld	s3,1112(sp)
    27ca:	45013a03          	ld	s4,1104(sp)
    27ce:	44813a83          	ld	s5,1096(sp)
    27d2:	44013b03          	ld	s6,1088(sp)
    27d6:	43813b83          	ld	s7,1080(sp)
    27da:	43013c03          	ld	s8,1072(sp)
    27de:	42813c83          	ld	s9,1064(sp)
    27e2:	48010113          	addi	sp,sp,1152
    27e6:	8082                	ret
    close(fd);
    27e8:	854a                	mv	a0,s2
    27ea:	253020ef          	jal	523c <close>
  for (fi = 0; done == 0 && '0' + fi < 0177; fi++) {
    27ee:	2985                	addiw	s3,s3,1
    27f0:	0ff9f993          	zext.b	s3,s3
    27f4:	ed8984e3          	beq	s3,s8,26bc <diskfull+0x7c>
    name[0] = 'b';
    27f8:	b9640023          	sb	s6,-1152(s0)
    name[1] = 'i';
    27fc:	b95400a3          	sb	s5,-1151(s0)
    name[2] = 'g';
    2800:	b9440123          	sb	s4,-1150(s0)
    name[3] = '0' + fi;
    2804:	b93401a3          	sb	s3,-1149(s0)
    name[4] = '\0';
    2808:	b8040223          	sb	zero,-1148(s0)
    unlink(name);
    280c:	b8040513          	addi	a0,s0,-1152
    2810:	255020ef          	jal	5264 <unlink>
    int fd = open(name, O_CREATE | O_RDWR | O_TRUNC);
    2814:	60200593          	li	a1,1538
    2818:	b8040513          	addi	a0,s0,-1152
    281c:	239020ef          	jal	5254 <open>
    2820:	892a                	mv	s2,a0
    if (fd < 0) {
    2822:	e6054de3          	bltz	a0,269c <diskfull+0x5c>
    2826:	84de                	mv	s1,s7
      if (write(fd, buf, BSIZE) != BSIZE) {
    2828:	40000613          	li	a2,1024
    282c:	ba040593          	addi	a1,s0,-1120
    2830:	854a                	mv	a0,s2
    2832:	203020ef          	jal	5234 <write>
    2836:	40000793          	li	a5,1024
    283a:	e6f51be3          	bne	a0,a5,26b0 <diskfull+0x70>
    for (int i = 0; i < MAXFILE; i++) {
    283e:	34fd                	addiw	s1,s1,-1
    2840:	f4e5                	bnez	s1,2828 <diskfull+0x1e8>
    2842:	b75d                	j	27e8 <diskfull+0x1a8>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n", s);
    2844:	85e6                	mv	a1,s9
    2846:	00004517          	auipc	a0,0x4
    284a:	08a50513          	addi	a0,a0,138 # 68d0 <malloc+0x11d8>
    284e:	5f7020ef          	jal	5644 <printf>
    2852:	bdd9                	j	2728 <diskfull+0xe8>

0000000000002854 <iputtest>:
{
    2854:	1101                	addi	sp,sp,-32
    2856:	ec06                	sd	ra,24(sp)
    2858:	e822                	sd	s0,16(sp)
    285a:	e426                	sd	s1,8(sp)
    285c:	1000                	addi	s0,sp,32
    285e:	84aa                	mv	s1,a0
  if (mkdir("iputdir") < 0) {
    2860:	00004517          	auipc	a0,0x4
    2864:	0a050513          	addi	a0,a0,160 # 6900 <malloc+0x1208>
    2868:	215020ef          	jal	527c <mkdir>
    286c:	02054f63          	bltz	a0,28aa <iputtest+0x56>
  if (chdir("iputdir") < 0) {
    2870:	00004517          	auipc	a0,0x4
    2874:	09050513          	addi	a0,a0,144 # 6900 <malloc+0x1208>
    2878:	20d020ef          	jal	5284 <chdir>
    287c:	04054163          	bltz	a0,28be <iputtest+0x6a>
  if (unlink("../iputdir") < 0) {
    2880:	00004517          	auipc	a0,0x4
    2884:	0c050513          	addi	a0,a0,192 # 6940 <malloc+0x1248>
    2888:	1dd020ef          	jal	5264 <unlink>
    288c:	04054363          	bltz	a0,28d2 <iputtest+0x7e>
  if (chdir("/") < 0) {
    2890:	00004517          	auipc	a0,0x4
    2894:	0e050513          	addi	a0,a0,224 # 6970 <malloc+0x1278>
    2898:	1ed020ef          	jal	5284 <chdir>
    289c:	04054563          	bltz	a0,28e6 <iputtest+0x92>
}
    28a0:	60e2                	ld	ra,24(sp)
    28a2:	6442                	ld	s0,16(sp)
    28a4:	64a2                	ld	s1,8(sp)
    28a6:	6105                	addi	sp,sp,32
    28a8:	8082                	ret
    printf("%s: mkdir failed\n", s);
    28aa:	85a6                	mv	a1,s1
    28ac:	00004517          	auipc	a0,0x4
    28b0:	05c50513          	addi	a0,a0,92 # 6908 <malloc+0x1210>
    28b4:	591020ef          	jal	5644 <printf>
    exit(1);
    28b8:	4505                	li	a0,1
    28ba:	15b020ef          	jal	5214 <exit>
    printf("%s: chdir iputdir failed\n", s);
    28be:	85a6                	mv	a1,s1
    28c0:	00004517          	auipc	a0,0x4
    28c4:	06050513          	addi	a0,a0,96 # 6920 <malloc+0x1228>
    28c8:	57d020ef          	jal	5644 <printf>
    exit(1);
    28cc:	4505                	li	a0,1
    28ce:	147020ef          	jal	5214 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    28d2:	85a6                	mv	a1,s1
    28d4:	00004517          	auipc	a0,0x4
    28d8:	07c50513          	addi	a0,a0,124 # 6950 <malloc+0x1258>
    28dc:	569020ef          	jal	5644 <printf>
    exit(1);
    28e0:	4505                	li	a0,1
    28e2:	133020ef          	jal	5214 <exit>
    printf("%s: chdir / failed\n", s);
    28e6:	85a6                	mv	a1,s1
    28e8:	00004517          	auipc	a0,0x4
    28ec:	09050513          	addi	a0,a0,144 # 6978 <malloc+0x1280>
    28f0:	555020ef          	jal	5644 <printf>
    exit(1);
    28f4:	4505                	li	a0,1
    28f6:	11f020ef          	jal	5214 <exit>

00000000000028fa <exitiputtest>:
{
    28fa:	7179                	addi	sp,sp,-48
    28fc:	f406                	sd	ra,40(sp)
    28fe:	f022                	sd	s0,32(sp)
    2900:	ec26                	sd	s1,24(sp)
    2902:	1800                	addi	s0,sp,48
    2904:	84aa                	mv	s1,a0
  pid = fork();
    2906:	107020ef          	jal	520c <fork>
  if (pid < 0) {
    290a:	02054e63          	bltz	a0,2946 <exitiputtest+0x4c>
  if (pid == 0) {
    290e:	e541                	bnez	a0,2996 <exitiputtest+0x9c>
    if (mkdir("iputdir") < 0) {
    2910:	00004517          	auipc	a0,0x4
    2914:	ff050513          	addi	a0,a0,-16 # 6900 <malloc+0x1208>
    2918:	165020ef          	jal	527c <mkdir>
    291c:	02054f63          	bltz	a0,295a <exitiputtest+0x60>
    if (chdir("iputdir") < 0) {
    2920:	00004517          	auipc	a0,0x4
    2924:	fe050513          	addi	a0,a0,-32 # 6900 <malloc+0x1208>
    2928:	15d020ef          	jal	5284 <chdir>
    292c:	04054163          	bltz	a0,296e <exitiputtest+0x74>
    if (unlink("../iputdir") < 0) {
    2930:	00004517          	auipc	a0,0x4
    2934:	01050513          	addi	a0,a0,16 # 6940 <malloc+0x1248>
    2938:	12d020ef          	jal	5264 <unlink>
    293c:	04054363          	bltz	a0,2982 <exitiputtest+0x88>
    exit(0);
    2940:	4501                	li	a0,0
    2942:	0d3020ef          	jal	5214 <exit>
    printf("%s: fork failed\n", s);
    2946:	85a6                	mv	a1,s1
    2948:	00003517          	auipc	a0,0x3
    294c:	77050513          	addi	a0,a0,1904 # 60b8 <malloc+0x9c0>
    2950:	4f5020ef          	jal	5644 <printf>
    exit(1);
    2954:	4505                	li	a0,1
    2956:	0bf020ef          	jal	5214 <exit>
      printf("%s: mkdir failed\n", s);
    295a:	85a6                	mv	a1,s1
    295c:	00004517          	auipc	a0,0x4
    2960:	fac50513          	addi	a0,a0,-84 # 6908 <malloc+0x1210>
    2964:	4e1020ef          	jal	5644 <printf>
      exit(1);
    2968:	4505                	li	a0,1
    296a:	0ab020ef          	jal	5214 <exit>
      printf("%s: child chdir failed\n", s);
    296e:	85a6                	mv	a1,s1
    2970:	00004517          	auipc	a0,0x4
    2974:	02050513          	addi	a0,a0,32 # 6990 <malloc+0x1298>
    2978:	4cd020ef          	jal	5644 <printf>
      exit(1);
    297c:	4505                	li	a0,1
    297e:	097020ef          	jal	5214 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    2982:	85a6                	mv	a1,s1
    2984:	00004517          	auipc	a0,0x4
    2988:	fcc50513          	addi	a0,a0,-52 # 6950 <malloc+0x1258>
    298c:	4b9020ef          	jal	5644 <printf>
      exit(1);
    2990:	4505                	li	a0,1
    2992:	083020ef          	jal	5214 <exit>
  wait(&xstatus);
    2996:	fdc40513          	addi	a0,s0,-36
    299a:	083020ef          	jal	521c <wait>
  exit(xstatus);
    299e:	fdc42503          	lw	a0,-36(s0)
    29a2:	073020ef          	jal	5214 <exit>

00000000000029a6 <dirtest>:
{
    29a6:	1101                	addi	sp,sp,-32
    29a8:	ec06                	sd	ra,24(sp)
    29aa:	e822                	sd	s0,16(sp)
    29ac:	e426                	sd	s1,8(sp)
    29ae:	1000                	addi	s0,sp,32
    29b0:	84aa                	mv	s1,a0
  if (mkdir("dir0") < 0) {
    29b2:	00004517          	auipc	a0,0x4
    29b6:	ff650513          	addi	a0,a0,-10 # 69a8 <malloc+0x12b0>
    29ba:	0c3020ef          	jal	527c <mkdir>
    29be:	02054f63          	bltz	a0,29fc <dirtest+0x56>
  if (chdir("dir0") < 0) {
    29c2:	00004517          	auipc	a0,0x4
    29c6:	fe650513          	addi	a0,a0,-26 # 69a8 <malloc+0x12b0>
    29ca:	0bb020ef          	jal	5284 <chdir>
    29ce:	04054163          	bltz	a0,2a10 <dirtest+0x6a>
  if (chdir("..") < 0) {
    29d2:	00004517          	auipc	a0,0x4
    29d6:	ff650513          	addi	a0,a0,-10 # 69c8 <malloc+0x12d0>
    29da:	0ab020ef          	jal	5284 <chdir>
    29de:	04054363          	bltz	a0,2a24 <dirtest+0x7e>
  if (unlink("dir0") < 0) {
    29e2:	00004517          	auipc	a0,0x4
    29e6:	fc650513          	addi	a0,a0,-58 # 69a8 <malloc+0x12b0>
    29ea:	07b020ef          	jal	5264 <unlink>
    29ee:	04054563          	bltz	a0,2a38 <dirtest+0x92>
}
    29f2:	60e2                	ld	ra,24(sp)
    29f4:	6442                	ld	s0,16(sp)
    29f6:	64a2                	ld	s1,8(sp)
    29f8:	6105                	addi	sp,sp,32
    29fa:	8082                	ret
    printf("%s: mkdir failed\n", s);
    29fc:	85a6                	mv	a1,s1
    29fe:	00004517          	auipc	a0,0x4
    2a02:	f0a50513          	addi	a0,a0,-246 # 6908 <malloc+0x1210>
    2a06:	43f020ef          	jal	5644 <printf>
    exit(1);
    2a0a:	4505                	li	a0,1
    2a0c:	009020ef          	jal	5214 <exit>
    printf("%s: chdir dir0 failed\n", s);
    2a10:	85a6                	mv	a1,s1
    2a12:	00004517          	auipc	a0,0x4
    2a16:	f9e50513          	addi	a0,a0,-98 # 69b0 <malloc+0x12b8>
    2a1a:	42b020ef          	jal	5644 <printf>
    exit(1);
    2a1e:	4505                	li	a0,1
    2a20:	7f4020ef          	jal	5214 <exit>
    printf("%s: chdir .. failed\n", s);
    2a24:	85a6                	mv	a1,s1
    2a26:	00004517          	auipc	a0,0x4
    2a2a:	faa50513          	addi	a0,a0,-86 # 69d0 <malloc+0x12d8>
    2a2e:	417020ef          	jal	5644 <printf>
    exit(1);
    2a32:	4505                	li	a0,1
    2a34:	7e0020ef          	jal	5214 <exit>
    printf("%s: unlink dir0 failed\n", s);
    2a38:	85a6                	mv	a1,s1
    2a3a:	00004517          	auipc	a0,0x4
    2a3e:	fae50513          	addi	a0,a0,-82 # 69e8 <malloc+0x12f0>
    2a42:	403020ef          	jal	5644 <printf>
    exit(1);
    2a46:	4505                	li	a0,1
    2a48:	7cc020ef          	jal	5214 <exit>

0000000000002a4c <subdir>:
{
    2a4c:	1101                	addi	sp,sp,-32
    2a4e:	ec06                	sd	ra,24(sp)
    2a50:	e822                	sd	s0,16(sp)
    2a52:	e426                	sd	s1,8(sp)
    2a54:	e04a                	sd	s2,0(sp)
    2a56:	1000                	addi	s0,sp,32
    2a58:	892a                	mv	s2,a0
  unlink("ff");
    2a5a:	00004517          	auipc	a0,0x4
    2a5e:	0d650513          	addi	a0,a0,214 # 6b30 <malloc+0x1438>
    2a62:	003020ef          	jal	5264 <unlink>
  if (mkdir("dd") != 0) {
    2a66:	00004517          	auipc	a0,0x4
    2a6a:	f9a50513          	addi	a0,a0,-102 # 6a00 <malloc+0x1308>
    2a6e:	00f020ef          	jal	527c <mkdir>
    2a72:	2e051263          	bnez	a0,2d56 <subdir+0x30a>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2a76:	20200593          	li	a1,514
    2a7a:	00004517          	auipc	a0,0x4
    2a7e:	fa650513          	addi	a0,a0,-90 # 6a20 <malloc+0x1328>
    2a82:	7d2020ef          	jal	5254 <open>
    2a86:	84aa                	mv	s1,a0
  if (fd < 0) {
    2a88:	2e054163          	bltz	a0,2d6a <subdir+0x31e>
  write(fd, "ff", 2);
    2a8c:	4609                	li	a2,2
    2a8e:	00004597          	auipc	a1,0x4
    2a92:	0a258593          	addi	a1,a1,162 # 6b30 <malloc+0x1438>
    2a96:	79e020ef          	jal	5234 <write>
  close(fd);
    2a9a:	8526                	mv	a0,s1
    2a9c:	7a0020ef          	jal	523c <close>
  if (unlink("dd") >= 0) {
    2aa0:	00004517          	auipc	a0,0x4
    2aa4:	f6050513          	addi	a0,a0,-160 # 6a00 <malloc+0x1308>
    2aa8:	7bc020ef          	jal	5264 <unlink>
    2aac:	2c055963          	bgez	a0,2d7e <subdir+0x332>
  if (mkdir("/dd/dd") != 0) {
    2ab0:	00004517          	auipc	a0,0x4
    2ab4:	fc850513          	addi	a0,a0,-56 # 6a78 <malloc+0x1380>
    2ab8:	7c4020ef          	jal	527c <mkdir>
    2abc:	2c051b63          	bnez	a0,2d92 <subdir+0x346>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2ac0:	20200593          	li	a1,514
    2ac4:	00004517          	auipc	a0,0x4
    2ac8:	fdc50513          	addi	a0,a0,-36 # 6aa0 <malloc+0x13a8>
    2acc:	788020ef          	jal	5254 <open>
    2ad0:	84aa                	mv	s1,a0
  if (fd < 0) {
    2ad2:	2c054a63          	bltz	a0,2da6 <subdir+0x35a>
  write(fd, "FF", 2);
    2ad6:	4609                	li	a2,2
    2ad8:	00004597          	auipc	a1,0x4
    2adc:	ff858593          	addi	a1,a1,-8 # 6ad0 <malloc+0x13d8>
    2ae0:	754020ef          	jal	5234 <write>
  close(fd);
    2ae4:	8526                	mv	a0,s1
    2ae6:	756020ef          	jal	523c <close>
  fd = open("dd/dd/../ff", 0);
    2aea:	4581                	li	a1,0
    2aec:	00004517          	auipc	a0,0x4
    2af0:	fec50513          	addi	a0,a0,-20 # 6ad8 <malloc+0x13e0>
    2af4:	760020ef          	jal	5254 <open>
    2af8:	84aa                	mv	s1,a0
  if (fd < 0) {
    2afa:	2c054063          	bltz	a0,2dba <subdir+0x36e>
  cc = read(fd, buf, sizeof(buf));
    2afe:	660d                	lui	a2,0x3
    2b00:	0000b597          	auipc	a1,0xb
    2b04:	1e858593          	addi	a1,a1,488 # dce8 <buf>
    2b08:	724020ef          	jal	522c <read>
  if (cc != 2 || buf[0] != 'f') {
    2b0c:	4789                	li	a5,2
    2b0e:	2cf51063          	bne	a0,a5,2dce <subdir+0x382>
    2b12:	0000b717          	auipc	a4,0xb
    2b16:	1d674703          	lbu	a4,470(a4) # dce8 <buf>
    2b1a:	06600793          	li	a5,102
    2b1e:	2af71863          	bne	a4,a5,2dce <subdir+0x382>
  close(fd);
    2b22:	8526                	mv	a0,s1
    2b24:	718020ef          	jal	523c <close>
  if (link("dd/dd/ff", "dd/dd/ffff") != 0) {
    2b28:	00004597          	auipc	a1,0x4
    2b2c:	00058593          	mv	a1,a1
    2b30:	00004517          	auipc	a0,0x4
    2b34:	f7050513          	addi	a0,a0,-144 # 6aa0 <malloc+0x13a8>
    2b38:	73c020ef          	jal	5274 <link>
    2b3c:	2a051363          	bnez	a0,2de2 <subdir+0x396>
  if (unlink("dd/dd/ff") != 0) {
    2b40:	00004517          	auipc	a0,0x4
    2b44:	f6050513          	addi	a0,a0,-160 # 6aa0 <malloc+0x13a8>
    2b48:	71c020ef          	jal	5264 <unlink>
    2b4c:	2a051563          	bnez	a0,2df6 <subdir+0x3aa>
  if (open("dd/dd/ff", O_RDONLY) >= 0) {
    2b50:	4581                	li	a1,0
    2b52:	00004517          	auipc	a0,0x4
    2b56:	f4e50513          	addi	a0,a0,-178 # 6aa0 <malloc+0x13a8>
    2b5a:	6fa020ef          	jal	5254 <open>
    2b5e:	2a055663          	bgez	a0,2e0a <subdir+0x3be>
  if (chdir("dd") != 0) {
    2b62:	00004517          	auipc	a0,0x4
    2b66:	e9e50513          	addi	a0,a0,-354 # 6a00 <malloc+0x1308>
    2b6a:	71a020ef          	jal	5284 <chdir>
    2b6e:	2a051863          	bnez	a0,2e1e <subdir+0x3d2>
  if (chdir("dd/../../dd") != 0) {
    2b72:	00004517          	auipc	a0,0x4
    2b76:	04e50513          	addi	a0,a0,78 # 6bc0 <malloc+0x14c8>
    2b7a:	70a020ef          	jal	5284 <chdir>
    2b7e:	2a051a63          	bnez	a0,2e32 <subdir+0x3e6>
  if (chdir("dd/../../../dd") != 0) {
    2b82:	00004517          	auipc	a0,0x4
    2b86:	06e50513          	addi	a0,a0,110 # 6bf0 <malloc+0x14f8>
    2b8a:	6fa020ef          	jal	5284 <chdir>
    2b8e:	2a051c63          	bnez	a0,2e46 <subdir+0x3fa>
  if (chdir("./..") != 0) {
    2b92:	00004517          	auipc	a0,0x4
    2b96:	09650513          	addi	a0,a0,150 # 6c28 <malloc+0x1530>
    2b9a:	6ea020ef          	jal	5284 <chdir>
    2b9e:	2a051e63          	bnez	a0,2e5a <subdir+0x40e>
  fd = open("dd/dd/ffff", 0);
    2ba2:	4581                	li	a1,0
    2ba4:	00004517          	auipc	a0,0x4
    2ba8:	f8450513          	addi	a0,a0,-124 # 6b28 <malloc+0x1430>
    2bac:	6a8020ef          	jal	5254 <open>
    2bb0:	84aa                	mv	s1,a0
  if (fd < 0) {
    2bb2:	2a054e63          	bltz	a0,2e6e <subdir+0x422>
  if (read(fd, buf, sizeof(buf)) != 2) {
    2bb6:	660d                	lui	a2,0x3
    2bb8:	0000b597          	auipc	a1,0xb
    2bbc:	13058593          	addi	a1,a1,304 # dce8 <buf>
    2bc0:	66c020ef          	jal	522c <read>
    2bc4:	4789                	li	a5,2
    2bc6:	2af51e63          	bne	a0,a5,2e82 <subdir+0x436>
  close(fd);
    2bca:	8526                	mv	a0,s1
    2bcc:	670020ef          	jal	523c <close>
  if (open("dd/dd/ff", O_RDONLY) >= 0) {
    2bd0:	4581                	li	a1,0
    2bd2:	00004517          	auipc	a0,0x4
    2bd6:	ece50513          	addi	a0,a0,-306 # 6aa0 <malloc+0x13a8>
    2bda:	67a020ef          	jal	5254 <open>
    2bde:	2a055c63          	bgez	a0,2e96 <subdir+0x44a>
  if (open("dd/ff/ff", O_CREATE | O_RDWR) >= 0) {
    2be2:	20200593          	li	a1,514
    2be6:	00004517          	auipc	a0,0x4
    2bea:	0d250513          	addi	a0,a0,210 # 6cb8 <malloc+0x15c0>
    2bee:	666020ef          	jal	5254 <open>
    2bf2:	2a055c63          	bgez	a0,2eaa <subdir+0x45e>
  if (open("dd/xx/ff", O_CREATE | O_RDWR) >= 0) {
    2bf6:	20200593          	li	a1,514
    2bfa:	00004517          	auipc	a0,0x4
    2bfe:	0ee50513          	addi	a0,a0,238 # 6ce8 <malloc+0x15f0>
    2c02:	652020ef          	jal	5254 <open>
    2c06:	2a055c63          	bgez	a0,2ebe <subdir+0x472>
  if (open("dd", O_CREATE) >= 0) {
    2c0a:	20000593          	li	a1,512
    2c0e:	00004517          	auipc	a0,0x4
    2c12:	df250513          	addi	a0,a0,-526 # 6a00 <malloc+0x1308>
    2c16:	63e020ef          	jal	5254 <open>
    2c1a:	2a055c63          	bgez	a0,2ed2 <subdir+0x486>
  if (open("dd", O_RDWR) >= 0) {
    2c1e:	4589                	li	a1,2
    2c20:	00004517          	auipc	a0,0x4
    2c24:	de050513          	addi	a0,a0,-544 # 6a00 <malloc+0x1308>
    2c28:	62c020ef          	jal	5254 <open>
    2c2c:	2a055d63          	bgez	a0,2ee6 <subdir+0x49a>
  if (open("dd", O_WRONLY) >= 0) {
    2c30:	4585                	li	a1,1
    2c32:	00004517          	auipc	a0,0x4
    2c36:	dce50513          	addi	a0,a0,-562 # 6a00 <malloc+0x1308>
    2c3a:	61a020ef          	jal	5254 <open>
    2c3e:	2a055e63          	bgez	a0,2efa <subdir+0x4ae>
  if (link("dd/ff/ff", "dd/dd/xx") == 0) {
    2c42:	00004597          	auipc	a1,0x4
    2c46:	13658593          	addi	a1,a1,310 # 6d78 <malloc+0x1680>
    2c4a:	00004517          	auipc	a0,0x4
    2c4e:	06e50513          	addi	a0,a0,110 # 6cb8 <malloc+0x15c0>
    2c52:	622020ef          	jal	5274 <link>
    2c56:	2a050c63          	beqz	a0,2f0e <subdir+0x4c2>
  if (link("dd/xx/ff", "dd/dd/xx") == 0) {
    2c5a:	00004597          	auipc	a1,0x4
    2c5e:	11e58593          	addi	a1,a1,286 # 6d78 <malloc+0x1680>
    2c62:	00004517          	auipc	a0,0x4
    2c66:	08650513          	addi	a0,a0,134 # 6ce8 <malloc+0x15f0>
    2c6a:	60a020ef          	jal	5274 <link>
    2c6e:	2a050a63          	beqz	a0,2f22 <subdir+0x4d6>
  if (link("dd/ff", "dd/dd/ffff") == 0) {
    2c72:	00004597          	auipc	a1,0x4
    2c76:	eb658593          	addi	a1,a1,-330 # 6b28 <malloc+0x1430>
    2c7a:	00004517          	auipc	a0,0x4
    2c7e:	da650513          	addi	a0,a0,-602 # 6a20 <malloc+0x1328>
    2c82:	5f2020ef          	jal	5274 <link>
    2c86:	2a050863          	beqz	a0,2f36 <subdir+0x4ea>
  if (mkdir("dd/ff/ff") == 0) {
    2c8a:	00004517          	auipc	a0,0x4
    2c8e:	02e50513          	addi	a0,a0,46 # 6cb8 <malloc+0x15c0>
    2c92:	5ea020ef          	jal	527c <mkdir>
    2c96:	2a050a63          	beqz	a0,2f4a <subdir+0x4fe>
  if (mkdir("dd/xx/ff") == 0) {
    2c9a:	00004517          	auipc	a0,0x4
    2c9e:	04e50513          	addi	a0,a0,78 # 6ce8 <malloc+0x15f0>
    2ca2:	5da020ef          	jal	527c <mkdir>
    2ca6:	2a050c63          	beqz	a0,2f5e <subdir+0x512>
  if (mkdir("dd/dd/ffff") == 0) {
    2caa:	00004517          	auipc	a0,0x4
    2cae:	e7e50513          	addi	a0,a0,-386 # 6b28 <malloc+0x1430>
    2cb2:	5ca020ef          	jal	527c <mkdir>
    2cb6:	2a050e63          	beqz	a0,2f72 <subdir+0x526>
  if (unlink("dd/xx/ff") == 0) {
    2cba:	00004517          	auipc	a0,0x4
    2cbe:	02e50513          	addi	a0,a0,46 # 6ce8 <malloc+0x15f0>
    2cc2:	5a2020ef          	jal	5264 <unlink>
    2cc6:	2c050063          	beqz	a0,2f86 <subdir+0x53a>
  if (unlink("dd/ff/ff") == 0) {
    2cca:	00004517          	auipc	a0,0x4
    2cce:	fee50513          	addi	a0,a0,-18 # 6cb8 <malloc+0x15c0>
    2cd2:	592020ef          	jal	5264 <unlink>
    2cd6:	2c050263          	beqz	a0,2f9a <subdir+0x54e>
  if (chdir("dd/ff") == 0) {
    2cda:	00004517          	auipc	a0,0x4
    2cde:	d4650513          	addi	a0,a0,-698 # 6a20 <malloc+0x1328>
    2ce2:	5a2020ef          	jal	5284 <chdir>
    2ce6:	2c050463          	beqz	a0,2fae <subdir+0x562>
  if (chdir("dd/xx") == 0) {
    2cea:	00004517          	auipc	a0,0x4
    2cee:	1de50513          	addi	a0,a0,478 # 6ec8 <malloc+0x17d0>
    2cf2:	592020ef          	jal	5284 <chdir>
    2cf6:	2c050663          	beqz	a0,2fc2 <subdir+0x576>
  if (unlink("dd/dd/ffff") != 0) {
    2cfa:	00004517          	auipc	a0,0x4
    2cfe:	e2e50513          	addi	a0,a0,-466 # 6b28 <malloc+0x1430>
    2d02:	562020ef          	jal	5264 <unlink>
    2d06:	2c051863          	bnez	a0,2fd6 <subdir+0x58a>
  if (unlink("dd/ff") != 0) {
    2d0a:	00004517          	auipc	a0,0x4
    2d0e:	d1650513          	addi	a0,a0,-746 # 6a20 <malloc+0x1328>
    2d12:	552020ef          	jal	5264 <unlink>
    2d16:	2c051a63          	bnez	a0,2fea <subdir+0x59e>
  if (unlink("dd") == 0) {
    2d1a:	00004517          	auipc	a0,0x4
    2d1e:	ce650513          	addi	a0,a0,-794 # 6a00 <malloc+0x1308>
    2d22:	542020ef          	jal	5264 <unlink>
    2d26:	2c050c63          	beqz	a0,2ffe <subdir+0x5b2>
  if (unlink("dd/dd") < 0) {
    2d2a:	00004517          	auipc	a0,0x4
    2d2e:	20e50513          	addi	a0,a0,526 # 6f38 <malloc+0x1840>
    2d32:	532020ef          	jal	5264 <unlink>
    2d36:	2c054e63          	bltz	a0,3012 <subdir+0x5c6>
  if (unlink("dd") < 0) {
    2d3a:	00004517          	auipc	a0,0x4
    2d3e:	cc650513          	addi	a0,a0,-826 # 6a00 <malloc+0x1308>
    2d42:	522020ef          	jal	5264 <unlink>
    2d46:	2e054063          	bltz	a0,3026 <subdir+0x5da>
}
    2d4a:	60e2                	ld	ra,24(sp)
    2d4c:	6442                	ld	s0,16(sp)
    2d4e:	64a2                	ld	s1,8(sp)
    2d50:	6902                	ld	s2,0(sp)
    2d52:	6105                	addi	sp,sp,32
    2d54:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    2d56:	85ca                	mv	a1,s2
    2d58:	00004517          	auipc	a0,0x4
    2d5c:	cb050513          	addi	a0,a0,-848 # 6a08 <malloc+0x1310>
    2d60:	0e5020ef          	jal	5644 <printf>
    exit(1);
    2d64:	4505                	li	a0,1
    2d66:	4ae020ef          	jal	5214 <exit>
    printf("%s: create dd/ff failed\n", s);
    2d6a:	85ca                	mv	a1,s2
    2d6c:	00004517          	auipc	a0,0x4
    2d70:	cbc50513          	addi	a0,a0,-836 # 6a28 <malloc+0x1330>
    2d74:	0d1020ef          	jal	5644 <printf>
    exit(1);
    2d78:	4505                	li	a0,1
    2d7a:	49a020ef          	jal	5214 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    2d7e:	85ca                	mv	a1,s2
    2d80:	00004517          	auipc	a0,0x4
    2d84:	cc850513          	addi	a0,a0,-824 # 6a48 <malloc+0x1350>
    2d88:	0bd020ef          	jal	5644 <printf>
    exit(1);
    2d8c:	4505                	li	a0,1
    2d8e:	486020ef          	jal	5214 <exit>
    printf("%s: subdir mkdir dd/dd failed\n", s);
    2d92:	85ca                	mv	a1,s2
    2d94:	00004517          	auipc	a0,0x4
    2d98:	cec50513          	addi	a0,a0,-788 # 6a80 <malloc+0x1388>
    2d9c:	0a9020ef          	jal	5644 <printf>
    exit(1);
    2da0:	4505                	li	a0,1
    2da2:	472020ef          	jal	5214 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    2da6:	85ca                	mv	a1,s2
    2da8:	00004517          	auipc	a0,0x4
    2dac:	d0850513          	addi	a0,a0,-760 # 6ab0 <malloc+0x13b8>
    2db0:	095020ef          	jal	5644 <printf>
    exit(1);
    2db4:	4505                	li	a0,1
    2db6:	45e020ef          	jal	5214 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    2dba:	85ca                	mv	a1,s2
    2dbc:	00004517          	auipc	a0,0x4
    2dc0:	d2c50513          	addi	a0,a0,-724 # 6ae8 <malloc+0x13f0>
    2dc4:	081020ef          	jal	5644 <printf>
    exit(1);
    2dc8:	4505                	li	a0,1
    2dca:	44a020ef          	jal	5214 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    2dce:	85ca                	mv	a1,s2
    2dd0:	00004517          	auipc	a0,0x4
    2dd4:	d3850513          	addi	a0,a0,-712 # 6b08 <malloc+0x1410>
    2dd8:	06d020ef          	jal	5644 <printf>
    exit(1);
    2ddc:	4505                	li	a0,1
    2dde:	436020ef          	jal	5214 <exit>
    printf("%s: link dd/dd/ff dd/dd/ffff failed\n", s);
    2de2:	85ca                	mv	a1,s2
    2de4:	00004517          	auipc	a0,0x4
    2de8:	d5450513          	addi	a0,a0,-684 # 6b38 <malloc+0x1440>
    2dec:	059020ef          	jal	5644 <printf>
    exit(1);
    2df0:	4505                	li	a0,1
    2df2:	422020ef          	jal	5214 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    2df6:	85ca                	mv	a1,s2
    2df8:	00004517          	auipc	a0,0x4
    2dfc:	d6850513          	addi	a0,a0,-664 # 6b60 <malloc+0x1468>
    2e00:	045020ef          	jal	5644 <printf>
    exit(1);
    2e04:	4505                	li	a0,1
    2e06:	40e020ef          	jal	5214 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    2e0a:	85ca                	mv	a1,s2
    2e0c:	00004517          	auipc	a0,0x4
    2e10:	d7450513          	addi	a0,a0,-652 # 6b80 <malloc+0x1488>
    2e14:	031020ef          	jal	5644 <printf>
    exit(1);
    2e18:	4505                	li	a0,1
    2e1a:	3fa020ef          	jal	5214 <exit>
    printf("%s: chdir dd failed\n", s);
    2e1e:	85ca                	mv	a1,s2
    2e20:	00004517          	auipc	a0,0x4
    2e24:	d8850513          	addi	a0,a0,-632 # 6ba8 <malloc+0x14b0>
    2e28:	01d020ef          	jal	5644 <printf>
    exit(1);
    2e2c:	4505                	li	a0,1
    2e2e:	3e6020ef          	jal	5214 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    2e32:	85ca                	mv	a1,s2
    2e34:	00004517          	auipc	a0,0x4
    2e38:	d9c50513          	addi	a0,a0,-612 # 6bd0 <malloc+0x14d8>
    2e3c:	009020ef          	jal	5644 <printf>
    exit(1);
    2e40:	4505                	li	a0,1
    2e42:	3d2020ef          	jal	5214 <exit>
    printf("%s: chdir dd/../../../dd failed\n", s);
    2e46:	85ca                	mv	a1,s2
    2e48:	00004517          	auipc	a0,0x4
    2e4c:	db850513          	addi	a0,a0,-584 # 6c00 <malloc+0x1508>
    2e50:	7f4020ef          	jal	5644 <printf>
    exit(1);
    2e54:	4505                	li	a0,1
    2e56:	3be020ef          	jal	5214 <exit>
    printf("%s: chdir ./.. failed\n", s);
    2e5a:	85ca                	mv	a1,s2
    2e5c:	00004517          	auipc	a0,0x4
    2e60:	dd450513          	addi	a0,a0,-556 # 6c30 <malloc+0x1538>
    2e64:	7e0020ef          	jal	5644 <printf>
    exit(1);
    2e68:	4505                	li	a0,1
    2e6a:	3aa020ef          	jal	5214 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    2e6e:	85ca                	mv	a1,s2
    2e70:	00004517          	auipc	a0,0x4
    2e74:	dd850513          	addi	a0,a0,-552 # 6c48 <malloc+0x1550>
    2e78:	7cc020ef          	jal	5644 <printf>
    exit(1);
    2e7c:	4505                	li	a0,1
    2e7e:	396020ef          	jal	5214 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    2e82:	85ca                	mv	a1,s2
    2e84:	00004517          	auipc	a0,0x4
    2e88:	de450513          	addi	a0,a0,-540 # 6c68 <malloc+0x1570>
    2e8c:	7b8020ef          	jal	5644 <printf>
    exit(1);
    2e90:	4505                	li	a0,1
    2e92:	382020ef          	jal	5214 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    2e96:	85ca                	mv	a1,s2
    2e98:	00004517          	auipc	a0,0x4
    2e9c:	df050513          	addi	a0,a0,-528 # 6c88 <malloc+0x1590>
    2ea0:	7a4020ef          	jal	5644 <printf>
    exit(1);
    2ea4:	4505                	li	a0,1
    2ea6:	36e020ef          	jal	5214 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    2eaa:	85ca                	mv	a1,s2
    2eac:	00004517          	auipc	a0,0x4
    2eb0:	e1c50513          	addi	a0,a0,-484 # 6cc8 <malloc+0x15d0>
    2eb4:	790020ef          	jal	5644 <printf>
    exit(1);
    2eb8:	4505                	li	a0,1
    2eba:	35a020ef          	jal	5214 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    2ebe:	85ca                	mv	a1,s2
    2ec0:	00004517          	auipc	a0,0x4
    2ec4:	e3850513          	addi	a0,a0,-456 # 6cf8 <malloc+0x1600>
    2ec8:	77c020ef          	jal	5644 <printf>
    exit(1);
    2ecc:	4505                	li	a0,1
    2ece:	346020ef          	jal	5214 <exit>
    printf("%s: create dd succeeded!\n", s);
    2ed2:	85ca                	mv	a1,s2
    2ed4:	00004517          	auipc	a0,0x4
    2ed8:	e4450513          	addi	a0,a0,-444 # 6d18 <malloc+0x1620>
    2edc:	768020ef          	jal	5644 <printf>
    exit(1);
    2ee0:	4505                	li	a0,1
    2ee2:	332020ef          	jal	5214 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    2ee6:	85ca                	mv	a1,s2
    2ee8:	00004517          	auipc	a0,0x4
    2eec:	e5050513          	addi	a0,a0,-432 # 6d38 <malloc+0x1640>
    2ef0:	754020ef          	jal	5644 <printf>
    exit(1);
    2ef4:	4505                	li	a0,1
    2ef6:	31e020ef          	jal	5214 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    2efa:	85ca                	mv	a1,s2
    2efc:	00004517          	auipc	a0,0x4
    2f00:	e5c50513          	addi	a0,a0,-420 # 6d58 <malloc+0x1660>
    2f04:	740020ef          	jal	5644 <printf>
    exit(1);
    2f08:	4505                	li	a0,1
    2f0a:	30a020ef          	jal	5214 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    2f0e:	85ca                	mv	a1,s2
    2f10:	00004517          	auipc	a0,0x4
    2f14:	e7850513          	addi	a0,a0,-392 # 6d88 <malloc+0x1690>
    2f18:	72c020ef          	jal	5644 <printf>
    exit(1);
    2f1c:	4505                	li	a0,1
    2f1e:	2f6020ef          	jal	5214 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    2f22:	85ca                	mv	a1,s2
    2f24:	00004517          	auipc	a0,0x4
    2f28:	e8c50513          	addi	a0,a0,-372 # 6db0 <malloc+0x16b8>
    2f2c:	718020ef          	jal	5644 <printf>
    exit(1);
    2f30:	4505                	li	a0,1
    2f32:	2e2020ef          	jal	5214 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    2f36:	85ca                	mv	a1,s2
    2f38:	00004517          	auipc	a0,0x4
    2f3c:	ea050513          	addi	a0,a0,-352 # 6dd8 <malloc+0x16e0>
    2f40:	704020ef          	jal	5644 <printf>
    exit(1);
    2f44:	4505                	li	a0,1
    2f46:	2ce020ef          	jal	5214 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    2f4a:	85ca                	mv	a1,s2
    2f4c:	00004517          	auipc	a0,0x4
    2f50:	eb450513          	addi	a0,a0,-332 # 6e00 <malloc+0x1708>
    2f54:	6f0020ef          	jal	5644 <printf>
    exit(1);
    2f58:	4505                	li	a0,1
    2f5a:	2ba020ef          	jal	5214 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    2f5e:	85ca                	mv	a1,s2
    2f60:	00004517          	auipc	a0,0x4
    2f64:	ec050513          	addi	a0,a0,-320 # 6e20 <malloc+0x1728>
    2f68:	6dc020ef          	jal	5644 <printf>
    exit(1);
    2f6c:	4505                	li	a0,1
    2f6e:	2a6020ef          	jal	5214 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    2f72:	85ca                	mv	a1,s2
    2f74:	00004517          	auipc	a0,0x4
    2f78:	ecc50513          	addi	a0,a0,-308 # 6e40 <malloc+0x1748>
    2f7c:	6c8020ef          	jal	5644 <printf>
    exit(1);
    2f80:	4505                	li	a0,1
    2f82:	292020ef          	jal	5214 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    2f86:	85ca                	mv	a1,s2
    2f88:	00004517          	auipc	a0,0x4
    2f8c:	ee050513          	addi	a0,a0,-288 # 6e68 <malloc+0x1770>
    2f90:	6b4020ef          	jal	5644 <printf>
    exit(1);
    2f94:	4505                	li	a0,1
    2f96:	27e020ef          	jal	5214 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    2f9a:	85ca                	mv	a1,s2
    2f9c:	00004517          	auipc	a0,0x4
    2fa0:	eec50513          	addi	a0,a0,-276 # 6e88 <malloc+0x1790>
    2fa4:	6a0020ef          	jal	5644 <printf>
    exit(1);
    2fa8:	4505                	li	a0,1
    2faa:	26a020ef          	jal	5214 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    2fae:	85ca                	mv	a1,s2
    2fb0:	00004517          	auipc	a0,0x4
    2fb4:	ef850513          	addi	a0,a0,-264 # 6ea8 <malloc+0x17b0>
    2fb8:	68c020ef          	jal	5644 <printf>
    exit(1);
    2fbc:	4505                	li	a0,1
    2fbe:	256020ef          	jal	5214 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    2fc2:	85ca                	mv	a1,s2
    2fc4:	00004517          	auipc	a0,0x4
    2fc8:	f0c50513          	addi	a0,a0,-244 # 6ed0 <malloc+0x17d8>
    2fcc:	678020ef          	jal	5644 <printf>
    exit(1);
    2fd0:	4505                	li	a0,1
    2fd2:	242020ef          	jal	5214 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    2fd6:	85ca                	mv	a1,s2
    2fd8:	00004517          	auipc	a0,0x4
    2fdc:	b8850513          	addi	a0,a0,-1144 # 6b60 <malloc+0x1468>
    2fe0:	664020ef          	jal	5644 <printf>
    exit(1);
    2fe4:	4505                	li	a0,1
    2fe6:	22e020ef          	jal	5214 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    2fea:	85ca                	mv	a1,s2
    2fec:	00004517          	auipc	a0,0x4
    2ff0:	f0450513          	addi	a0,a0,-252 # 6ef0 <malloc+0x17f8>
    2ff4:	650020ef          	jal	5644 <printf>
    exit(1);
    2ff8:	4505                	li	a0,1
    2ffa:	21a020ef          	jal	5214 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    2ffe:	85ca                	mv	a1,s2
    3000:	00004517          	auipc	a0,0x4
    3004:	f1050513          	addi	a0,a0,-240 # 6f10 <malloc+0x1818>
    3008:	63c020ef          	jal	5644 <printf>
    exit(1);
    300c:	4505                	li	a0,1
    300e:	206020ef          	jal	5214 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3012:	85ca                	mv	a1,s2
    3014:	00004517          	auipc	a0,0x4
    3018:	f2c50513          	addi	a0,a0,-212 # 6f40 <malloc+0x1848>
    301c:	628020ef          	jal	5644 <printf>
    exit(1);
    3020:	4505                	li	a0,1
    3022:	1f2020ef          	jal	5214 <exit>
    printf("%s: unlink dd failed\n", s);
    3026:	85ca                	mv	a1,s2
    3028:	00004517          	auipc	a0,0x4
    302c:	f3850513          	addi	a0,a0,-200 # 6f60 <malloc+0x1868>
    3030:	614020ef          	jal	5644 <printf>
    exit(1);
    3034:	4505                	li	a0,1
    3036:	1de020ef          	jal	5214 <exit>

000000000000303a <rmdot>:
{
    303a:	1101                	addi	sp,sp,-32
    303c:	ec06                	sd	ra,24(sp)
    303e:	e822                	sd	s0,16(sp)
    3040:	e426                	sd	s1,8(sp)
    3042:	1000                	addi	s0,sp,32
    3044:	84aa                	mv	s1,a0
  if (mkdir("dots") != 0) {
    3046:	00004517          	auipc	a0,0x4
    304a:	f3250513          	addi	a0,a0,-206 # 6f78 <malloc+0x1880>
    304e:	22e020ef          	jal	527c <mkdir>
    3052:	e53d                	bnez	a0,30c0 <rmdot+0x86>
  if (chdir("dots") != 0) {
    3054:	00004517          	auipc	a0,0x4
    3058:	f2450513          	addi	a0,a0,-220 # 6f78 <malloc+0x1880>
    305c:	228020ef          	jal	5284 <chdir>
    3060:	e935                	bnez	a0,30d4 <rmdot+0x9a>
  if (unlink(".") == 0) {
    3062:	00003517          	auipc	a0,0x3
    3066:	eae50513          	addi	a0,a0,-338 # 5f10 <malloc+0x818>
    306a:	1fa020ef          	jal	5264 <unlink>
    306e:	cd2d                	beqz	a0,30e8 <rmdot+0xae>
  if (unlink("..") == 0) {
    3070:	00004517          	auipc	a0,0x4
    3074:	95850513          	addi	a0,a0,-1704 # 69c8 <malloc+0x12d0>
    3078:	1ec020ef          	jal	5264 <unlink>
    307c:	c141                	beqz	a0,30fc <rmdot+0xc2>
  if (chdir("/") != 0) {
    307e:	00004517          	auipc	a0,0x4
    3082:	8f250513          	addi	a0,a0,-1806 # 6970 <malloc+0x1278>
    3086:	1fe020ef          	jal	5284 <chdir>
    308a:	e159                	bnez	a0,3110 <rmdot+0xd6>
  if (unlink("dots/.") == 0) {
    308c:	00004517          	auipc	a0,0x4
    3090:	f5450513          	addi	a0,a0,-172 # 6fe0 <malloc+0x18e8>
    3094:	1d0020ef          	jal	5264 <unlink>
    3098:	c551                	beqz	a0,3124 <rmdot+0xea>
  if (unlink("dots/..") == 0) {
    309a:	00004517          	auipc	a0,0x4
    309e:	f6e50513          	addi	a0,a0,-146 # 7008 <malloc+0x1910>
    30a2:	1c2020ef          	jal	5264 <unlink>
    30a6:	c949                	beqz	a0,3138 <rmdot+0xfe>
  if (unlink("dots") != 0) {
    30a8:	00004517          	auipc	a0,0x4
    30ac:	ed050513          	addi	a0,a0,-304 # 6f78 <malloc+0x1880>
    30b0:	1b4020ef          	jal	5264 <unlink>
    30b4:	ed41                	bnez	a0,314c <rmdot+0x112>
}
    30b6:	60e2                	ld	ra,24(sp)
    30b8:	6442                	ld	s0,16(sp)
    30ba:	64a2                	ld	s1,8(sp)
    30bc:	6105                	addi	sp,sp,32
    30be:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    30c0:	85a6                	mv	a1,s1
    30c2:	00004517          	auipc	a0,0x4
    30c6:	ebe50513          	addi	a0,a0,-322 # 6f80 <malloc+0x1888>
    30ca:	57a020ef          	jal	5644 <printf>
    exit(1);
    30ce:	4505                	li	a0,1
    30d0:	144020ef          	jal	5214 <exit>
    printf("%s: chdir dots failed\n", s);
    30d4:	85a6                	mv	a1,s1
    30d6:	00004517          	auipc	a0,0x4
    30da:	ec250513          	addi	a0,a0,-318 # 6f98 <malloc+0x18a0>
    30de:	566020ef          	jal	5644 <printf>
    exit(1);
    30e2:	4505                	li	a0,1
    30e4:	130020ef          	jal	5214 <exit>
    printf("%s: rm . worked!\n", s);
    30e8:	85a6                	mv	a1,s1
    30ea:	00004517          	auipc	a0,0x4
    30ee:	ec650513          	addi	a0,a0,-314 # 6fb0 <malloc+0x18b8>
    30f2:	552020ef          	jal	5644 <printf>
    exit(1);
    30f6:	4505                	li	a0,1
    30f8:	11c020ef          	jal	5214 <exit>
    printf("%s: rm .. worked!\n", s);
    30fc:	85a6                	mv	a1,s1
    30fe:	00004517          	auipc	a0,0x4
    3102:	eca50513          	addi	a0,a0,-310 # 6fc8 <malloc+0x18d0>
    3106:	53e020ef          	jal	5644 <printf>
    exit(1);
    310a:	4505                	li	a0,1
    310c:	108020ef          	jal	5214 <exit>
    printf("%s: chdir / failed\n", s);
    3110:	85a6                	mv	a1,s1
    3112:	00004517          	auipc	a0,0x4
    3116:	86650513          	addi	a0,a0,-1946 # 6978 <malloc+0x1280>
    311a:	52a020ef          	jal	5644 <printf>
    exit(1);
    311e:	4505                	li	a0,1
    3120:	0f4020ef          	jal	5214 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3124:	85a6                	mv	a1,s1
    3126:	00004517          	auipc	a0,0x4
    312a:	ec250513          	addi	a0,a0,-318 # 6fe8 <malloc+0x18f0>
    312e:	516020ef          	jal	5644 <printf>
    exit(1);
    3132:	4505                	li	a0,1
    3134:	0e0020ef          	jal	5214 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3138:	85a6                	mv	a1,s1
    313a:	00004517          	auipc	a0,0x4
    313e:	ed650513          	addi	a0,a0,-298 # 7010 <malloc+0x1918>
    3142:	502020ef          	jal	5644 <printf>
    exit(1);
    3146:	4505                	li	a0,1
    3148:	0cc020ef          	jal	5214 <exit>
    printf("%s: unlink dots failed!\n", s);
    314c:	85a6                	mv	a1,s1
    314e:	00004517          	auipc	a0,0x4
    3152:	ee250513          	addi	a0,a0,-286 # 7030 <malloc+0x1938>
    3156:	4ee020ef          	jal	5644 <printf>
    exit(1);
    315a:	4505                	li	a0,1
    315c:	0b8020ef          	jal	5214 <exit>

0000000000003160 <dirfile>:
{
    3160:	1101                	addi	sp,sp,-32
    3162:	ec06                	sd	ra,24(sp)
    3164:	e822                	sd	s0,16(sp)
    3166:	e426                	sd	s1,8(sp)
    3168:	e04a                	sd	s2,0(sp)
    316a:	1000                	addi	s0,sp,32
    316c:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    316e:	20000593          	li	a1,512
    3172:	00004517          	auipc	a0,0x4
    3176:	ede50513          	addi	a0,a0,-290 # 7050 <malloc+0x1958>
    317a:	0da020ef          	jal	5254 <open>
  if (fd < 0) {
    317e:	0c054563          	bltz	a0,3248 <dirfile+0xe8>
  close(fd);
    3182:	0ba020ef          	jal	523c <close>
  if (chdir("dirfile") == 0) {
    3186:	00004517          	auipc	a0,0x4
    318a:	eca50513          	addi	a0,a0,-310 # 7050 <malloc+0x1958>
    318e:	0f6020ef          	jal	5284 <chdir>
    3192:	c569                	beqz	a0,325c <dirfile+0xfc>
  fd = open("dirfile/xx", 0);
    3194:	4581                	li	a1,0
    3196:	00004517          	auipc	a0,0x4
    319a:	f0250513          	addi	a0,a0,-254 # 7098 <malloc+0x19a0>
    319e:	0b6020ef          	jal	5254 <open>
  if (fd >= 0) {
    31a2:	0c055763          	bgez	a0,3270 <dirfile+0x110>
  fd = open("dirfile/xx", O_CREATE);
    31a6:	20000593          	li	a1,512
    31aa:	00004517          	auipc	a0,0x4
    31ae:	eee50513          	addi	a0,a0,-274 # 7098 <malloc+0x19a0>
    31b2:	0a2020ef          	jal	5254 <open>
  if (fd >= 0) {
    31b6:	0c055763          	bgez	a0,3284 <dirfile+0x124>
  if (mkdir("dirfile/xx") == 0) {
    31ba:	00004517          	auipc	a0,0x4
    31be:	ede50513          	addi	a0,a0,-290 # 7098 <malloc+0x19a0>
    31c2:	0ba020ef          	jal	527c <mkdir>
    31c6:	0c050963          	beqz	a0,3298 <dirfile+0x138>
  if (unlink("dirfile/xx") == 0) {
    31ca:	00004517          	auipc	a0,0x4
    31ce:	ece50513          	addi	a0,a0,-306 # 7098 <malloc+0x19a0>
    31d2:	092020ef          	jal	5264 <unlink>
    31d6:	0c050b63          	beqz	a0,32ac <dirfile+0x14c>
  if (link("README", "dirfile/xx") == 0) {
    31da:	00004597          	auipc	a1,0x4
    31de:	ebe58593          	addi	a1,a1,-322 # 7098 <malloc+0x19a0>
    31e2:	00003517          	auipc	a0,0x3
    31e6:	81e50513          	addi	a0,a0,-2018 # 5a00 <malloc+0x308>
    31ea:	08a020ef          	jal	5274 <link>
    31ee:	0c050963          	beqz	a0,32c0 <dirfile+0x160>
  if (unlink("dirfile") != 0) {
    31f2:	00004517          	auipc	a0,0x4
    31f6:	e5e50513          	addi	a0,a0,-418 # 7050 <malloc+0x1958>
    31fa:	06a020ef          	jal	5264 <unlink>
    31fe:	0c051b63          	bnez	a0,32d4 <dirfile+0x174>
  fd = open(".", O_RDWR);
    3202:	4589                	li	a1,2
    3204:	00003517          	auipc	a0,0x3
    3208:	d0c50513          	addi	a0,a0,-756 # 5f10 <malloc+0x818>
    320c:	048020ef          	jal	5254 <open>
  if (fd >= 0) {
    3210:	0c055c63          	bgez	a0,32e8 <dirfile+0x188>
  fd = open(".", 0);
    3214:	4581                	li	a1,0
    3216:	00003517          	auipc	a0,0x3
    321a:	cfa50513          	addi	a0,a0,-774 # 5f10 <malloc+0x818>
    321e:	036020ef          	jal	5254 <open>
    3222:	84aa                	mv	s1,a0
  if (write(fd, "x", 1) > 0) {
    3224:	4605                	li	a2,1
    3226:	00002597          	auipc	a1,0x2
    322a:	67258593          	addi	a1,a1,1650 # 5898 <malloc+0x1a0>
    322e:	006020ef          	jal	5234 <write>
    3232:	0ca04563          	bgtz	a0,32fc <dirfile+0x19c>
  close(fd);
    3236:	8526                	mv	a0,s1
    3238:	004020ef          	jal	523c <close>
}
    323c:	60e2                	ld	ra,24(sp)
    323e:	6442                	ld	s0,16(sp)
    3240:	64a2                	ld	s1,8(sp)
    3242:	6902                	ld	s2,0(sp)
    3244:	6105                	addi	sp,sp,32
    3246:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    3248:	85ca                	mv	a1,s2
    324a:	00004517          	auipc	a0,0x4
    324e:	e0e50513          	addi	a0,a0,-498 # 7058 <malloc+0x1960>
    3252:	3f2020ef          	jal	5644 <printf>
    exit(1);
    3256:	4505                	li	a0,1
    3258:	7bd010ef          	jal	5214 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    325c:	85ca                	mv	a1,s2
    325e:	00004517          	auipc	a0,0x4
    3262:	e1a50513          	addi	a0,a0,-486 # 7078 <malloc+0x1980>
    3266:	3de020ef          	jal	5644 <printf>
    exit(1);
    326a:	4505                	li	a0,1
    326c:	7a9010ef          	jal	5214 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3270:	85ca                	mv	a1,s2
    3272:	00004517          	auipc	a0,0x4
    3276:	e3650513          	addi	a0,a0,-458 # 70a8 <malloc+0x19b0>
    327a:	3ca020ef          	jal	5644 <printf>
    exit(1);
    327e:	4505                	li	a0,1
    3280:	795010ef          	jal	5214 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3284:	85ca                	mv	a1,s2
    3286:	00004517          	auipc	a0,0x4
    328a:	e2250513          	addi	a0,a0,-478 # 70a8 <malloc+0x19b0>
    328e:	3b6020ef          	jal	5644 <printf>
    exit(1);
    3292:	4505                	li	a0,1
    3294:	781010ef          	jal	5214 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3298:	85ca                	mv	a1,s2
    329a:	00004517          	auipc	a0,0x4
    329e:	e3650513          	addi	a0,a0,-458 # 70d0 <malloc+0x19d8>
    32a2:	3a2020ef          	jal	5644 <printf>
    exit(1);
    32a6:	4505                	li	a0,1
    32a8:	76d010ef          	jal	5214 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    32ac:	85ca                	mv	a1,s2
    32ae:	00004517          	auipc	a0,0x4
    32b2:	e4a50513          	addi	a0,a0,-438 # 70f8 <malloc+0x1a00>
    32b6:	38e020ef          	jal	5644 <printf>
    exit(1);
    32ba:	4505                	li	a0,1
    32bc:	759010ef          	jal	5214 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    32c0:	85ca                	mv	a1,s2
    32c2:	00004517          	auipc	a0,0x4
    32c6:	e5e50513          	addi	a0,a0,-418 # 7120 <malloc+0x1a28>
    32ca:	37a020ef          	jal	5644 <printf>
    exit(1);
    32ce:	4505                	li	a0,1
    32d0:	745010ef          	jal	5214 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    32d4:	85ca                	mv	a1,s2
    32d6:	00004517          	auipc	a0,0x4
    32da:	e7250513          	addi	a0,a0,-398 # 7148 <malloc+0x1a50>
    32de:	366020ef          	jal	5644 <printf>
    exit(1);
    32e2:	4505                	li	a0,1
    32e4:	731010ef          	jal	5214 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    32e8:	85ca                	mv	a1,s2
    32ea:	00004517          	auipc	a0,0x4
    32ee:	e7e50513          	addi	a0,a0,-386 # 7168 <malloc+0x1a70>
    32f2:	352020ef          	jal	5644 <printf>
    exit(1);
    32f6:	4505                	li	a0,1
    32f8:	71d010ef          	jal	5214 <exit>
    printf("%s: write . succeeded!\n", s);
    32fc:	85ca                	mv	a1,s2
    32fe:	00004517          	auipc	a0,0x4
    3302:	e9250513          	addi	a0,a0,-366 # 7190 <malloc+0x1a98>
    3306:	33e020ef          	jal	5644 <printf>
    exit(1);
    330a:	4505                	li	a0,1
    330c:	709010ef          	jal	5214 <exit>

0000000000003310 <iref>:
{
    3310:	7139                	addi	sp,sp,-64
    3312:	fc06                	sd	ra,56(sp)
    3314:	f822                	sd	s0,48(sp)
    3316:	f426                	sd	s1,40(sp)
    3318:	f04a                	sd	s2,32(sp)
    331a:	ec4e                	sd	s3,24(sp)
    331c:	e852                	sd	s4,16(sp)
    331e:	e456                	sd	s5,8(sp)
    3320:	e05a                	sd	s6,0(sp)
    3322:	0080                	addi	s0,sp,64
    3324:	8b2a                	mv	s6,a0
    3326:	03300913          	li	s2,51
    if (mkdir("irefd") != 0) {
    332a:	00004a17          	auipc	s4,0x4
    332e:	e7ea0a13          	addi	s4,s4,-386 # 71a8 <malloc+0x1ab0>
    mkdir("");
    3332:	00004497          	auipc	s1,0x4
    3336:	97e48493          	addi	s1,s1,-1666 # 6cb0 <malloc+0x15b8>
    link("README", "");
    333a:	00002a97          	auipc	s5,0x2
    333e:	6c6a8a93          	addi	s5,s5,1734 # 5a00 <malloc+0x308>
    fd = open("xx", O_CREATE);
    3342:	00004997          	auipc	s3,0x4
    3346:	d5e98993          	addi	s3,s3,-674 # 70a0 <malloc+0x19a8>
    334a:	a835                	j	3386 <iref+0x76>
      printf("%s: mkdir irefd failed\n", s);
    334c:	85da                	mv	a1,s6
    334e:	00004517          	auipc	a0,0x4
    3352:	e6250513          	addi	a0,a0,-414 # 71b0 <malloc+0x1ab8>
    3356:	2ee020ef          	jal	5644 <printf>
      exit(1);
    335a:	4505                	li	a0,1
    335c:	6b9010ef          	jal	5214 <exit>
      printf("%s: chdir irefd failed\n", s);
    3360:	85da                	mv	a1,s6
    3362:	00004517          	auipc	a0,0x4
    3366:	e6650513          	addi	a0,a0,-410 # 71c8 <malloc+0x1ad0>
    336a:	2da020ef          	jal	5644 <printf>
      exit(1);
    336e:	4505                	li	a0,1
    3370:	6a5010ef          	jal	5214 <exit>
      close(fd);
    3374:	6c9010ef          	jal	523c <close>
    3378:	a82d                	j	33b2 <iref+0xa2>
    unlink("xx");
    337a:	854e                	mv	a0,s3
    337c:	6e9010ef          	jal	5264 <unlink>
  for (i = 0; i < NINODE + 1; i++) {
    3380:	397d                	addiw	s2,s2,-1
    3382:	04090263          	beqz	s2,33c6 <iref+0xb6>
    if (mkdir("irefd") != 0) {
    3386:	8552                	mv	a0,s4
    3388:	6f5010ef          	jal	527c <mkdir>
    338c:	f161                	bnez	a0,334c <iref+0x3c>
    if (chdir("irefd") != 0) {
    338e:	8552                	mv	a0,s4
    3390:	6f5010ef          	jal	5284 <chdir>
    3394:	f571                	bnez	a0,3360 <iref+0x50>
    mkdir("");
    3396:	8526                	mv	a0,s1
    3398:	6e5010ef          	jal	527c <mkdir>
    link("README", "");
    339c:	85a6                	mv	a1,s1
    339e:	8556                	mv	a0,s5
    33a0:	6d5010ef          	jal	5274 <link>
    fd = open("", O_CREATE);
    33a4:	20000593          	li	a1,512
    33a8:	8526                	mv	a0,s1
    33aa:	6ab010ef          	jal	5254 <open>
    if (fd >= 0)
    33ae:	fc0553e3          	bgez	a0,3374 <iref+0x64>
    fd = open("xx", O_CREATE);
    33b2:	20000593          	li	a1,512
    33b6:	854e                	mv	a0,s3
    33b8:	69d010ef          	jal	5254 <open>
    if (fd >= 0)
    33bc:	fa054fe3          	bltz	a0,337a <iref+0x6a>
      close(fd);
    33c0:	67d010ef          	jal	523c <close>
    33c4:	bf5d                	j	337a <iref+0x6a>
    33c6:	03300493          	li	s1,51
    chdir("..");
    33ca:	00003997          	auipc	s3,0x3
    33ce:	5fe98993          	addi	s3,s3,1534 # 69c8 <malloc+0x12d0>
    unlink("irefd");
    33d2:	00004917          	auipc	s2,0x4
    33d6:	dd690913          	addi	s2,s2,-554 # 71a8 <malloc+0x1ab0>
    chdir("..");
    33da:	854e                	mv	a0,s3
    33dc:	6a9010ef          	jal	5284 <chdir>
    unlink("irefd");
    33e0:	854a                	mv	a0,s2
    33e2:	683010ef          	jal	5264 <unlink>
  for (i = 0; i < NINODE + 1; i++) {
    33e6:	34fd                	addiw	s1,s1,-1
    33e8:	f8ed                	bnez	s1,33da <iref+0xca>
  chdir("/");
    33ea:	00003517          	auipc	a0,0x3
    33ee:	58650513          	addi	a0,a0,1414 # 6970 <malloc+0x1278>
    33f2:	693010ef          	jal	5284 <chdir>
}
    33f6:	70e2                	ld	ra,56(sp)
    33f8:	7442                	ld	s0,48(sp)
    33fa:	74a2                	ld	s1,40(sp)
    33fc:	7902                	ld	s2,32(sp)
    33fe:	69e2                	ld	s3,24(sp)
    3400:	6a42                	ld	s4,16(sp)
    3402:	6aa2                	ld	s5,8(sp)
    3404:	6b02                	ld	s6,0(sp)
    3406:	6121                	addi	sp,sp,64
    3408:	8082                	ret

000000000000340a <unlinkcwd>:
{
    340a:	1101                	addi	sp,sp,-32
    340c:	ec06                	sd	ra,24(sp)
    340e:	e822                	sd	s0,16(sp)
    3410:	e426                	sd	s1,8(sp)
    3412:	1000                	addi	s0,sp,32
    3414:	84aa                	mv	s1,a0
  if (mkdir("/a") < 0) {
    3416:	00004517          	auipc	a0,0x4
    341a:	dca50513          	addi	a0,a0,-566 # 71e0 <malloc+0x1ae8>
    341e:	65f010ef          	jal	527c <mkdir>
    3422:	06054a63          	bltz	a0,3496 <unlinkcwd+0x8c>
  if (mkdir("/a/b") < 0) {
    3426:	00004517          	auipc	a0,0x4
    342a:	dda50513          	addi	a0,a0,-550 # 7200 <malloc+0x1b08>
    342e:	64f010ef          	jal	527c <mkdir>
    3432:	06054c63          	bltz	a0,34aa <unlinkcwd+0xa0>
  if (chdir("/a/b") < 0) {
    3436:	00004517          	auipc	a0,0x4
    343a:	dca50513          	addi	a0,a0,-566 # 7200 <malloc+0x1b08>
    343e:	647010ef          	jal	5284 <chdir>
    3442:	06054e63          	bltz	a0,34be <unlinkcwd+0xb4>
  if (unlink("/a/b") < 0) {
    3446:	00004517          	auipc	a0,0x4
    344a:	dba50513          	addi	a0,a0,-582 # 7200 <malloc+0x1b08>
    344e:	617010ef          	jal	5264 <unlink>
    3452:	08054063          	bltz	a0,34d2 <unlinkcwd+0xc8>
  if (unlink("/a") < 0) {
    3456:	00004517          	auipc	a0,0x4
    345a:	d8a50513          	addi	a0,a0,-630 # 71e0 <malloc+0x1ae8>
    345e:	607010ef          	jal	5264 <unlink>
    3462:	08054263          	bltz	a0,34e6 <unlinkcwd+0xdc>
  if (open("../", O_RDONLY) > 0) {
    3466:	4581                	li	a1,0
    3468:	00004517          	auipc	a0,0x4
    346c:	e0050513          	addi	a0,a0,-512 # 7268 <malloc+0x1b70>
    3470:	5e5010ef          	jal	5254 <open>
    3474:	08a04363          	bgtz	a0,34fa <unlinkcwd+0xf0>
  if (open("../c", O_CREATE) > 0) {
    3478:	20000593          	li	a1,512
    347c:	00004517          	auipc	a0,0x4
    3480:	e1c50513          	addi	a0,a0,-484 # 7298 <malloc+0x1ba0>
    3484:	5d1010ef          	jal	5254 <open>
    3488:	08a04163          	bgtz	a0,350a <unlinkcwd+0x100>
}
    348c:	60e2                	ld	ra,24(sp)
    348e:	6442                	ld	s0,16(sp)
    3490:	64a2                	ld	s1,8(sp)
    3492:	6105                	addi	sp,sp,32
    3494:	8082                	ret
    printf("%s: mkdir /a failed\n", s);
    3496:	85a6                	mv	a1,s1
    3498:	00004517          	auipc	a0,0x4
    349c:	d5050513          	addi	a0,a0,-688 # 71e8 <malloc+0x1af0>
    34a0:	1a4020ef          	jal	5644 <printf>
    exit(1);
    34a4:	4505                	li	a0,1
    34a6:	56f010ef          	jal	5214 <exit>
    printf("%s: mkdir /a/b failed\n", s);
    34aa:	85a6                	mv	a1,s1
    34ac:	00004517          	auipc	a0,0x4
    34b0:	d5c50513          	addi	a0,a0,-676 # 7208 <malloc+0x1b10>
    34b4:	190020ef          	jal	5644 <printf>
    exit(1);
    34b8:	4505                	li	a0,1
    34ba:	55b010ef          	jal	5214 <exit>
    printf("%s: chdir failed\n", s);
    34be:	85a6                	mv	a1,s1
    34c0:	00004517          	auipc	a0,0x4
    34c4:	d6050513          	addi	a0,a0,-672 # 7220 <malloc+0x1b28>
    34c8:	17c020ef          	jal	5644 <printf>
    exit(1);
    34cc:	4505                	li	a0,1
    34ce:	547010ef          	jal	5214 <exit>
    printf("%s: unlink /a/b failed\n", s);
    34d2:	85a6                	mv	a1,s1
    34d4:	00004517          	auipc	a0,0x4
    34d8:	d6450513          	addi	a0,a0,-668 # 7238 <malloc+0x1b40>
    34dc:	168020ef          	jal	5644 <printf>
    exit(1);
    34e0:	4505                	li	a0,1
    34e2:	533010ef          	jal	5214 <exit>
    printf("%s: unlink /a failed\n", s);
    34e6:	85a6                	mv	a1,s1
    34e8:	00004517          	auipc	a0,0x4
    34ec:	d6850513          	addi	a0,a0,-664 # 7250 <malloc+0x1b58>
    34f0:	154020ef          	jal	5644 <printf>
    exit(1);
    34f4:	4505                	li	a0,1
    34f6:	51f010ef          	jal	5214 <exit>
    printf("%s: open ../ non-existing directory\n", s);
    34fa:	85a6                	mv	a1,s1
    34fc:	00004517          	auipc	a0,0x4
    3500:	d7450513          	addi	a0,a0,-652 # 7270 <malloc+0x1b78>
    3504:	140020ef          	jal	5644 <printf>
    3508:	bf85                	j	3478 <unlinkcwd+0x6e>
    printf("%s: create ../c non-existing file\n", s);
    350a:	85a6                	mv	a1,s1
    350c:	00004517          	auipc	a0,0x4
    3510:	d9450513          	addi	a0,a0,-620 # 72a0 <malloc+0x1ba8>
    3514:	130020ef          	jal	5644 <printf>
}
    3518:	bf95                	j	348c <unlinkcwd+0x82>

000000000000351a <openiputtest>:
{
    351a:	7179                	addi	sp,sp,-48
    351c:	f406                	sd	ra,40(sp)
    351e:	f022                	sd	s0,32(sp)
    3520:	ec26                	sd	s1,24(sp)
    3522:	1800                	addi	s0,sp,48
    3524:	84aa                	mv	s1,a0
  if (mkdir("oidir") < 0) {
    3526:	00004517          	auipc	a0,0x4
    352a:	da250513          	addi	a0,a0,-606 # 72c8 <malloc+0x1bd0>
    352e:	54f010ef          	jal	527c <mkdir>
    3532:	02054a63          	bltz	a0,3566 <openiputtest+0x4c>
  pid = fork();
    3536:	4d7010ef          	jal	520c <fork>
  if (pid < 0) {
    353a:	04054063          	bltz	a0,357a <openiputtest+0x60>
  if (pid == 0) {
    353e:	e939                	bnez	a0,3594 <openiputtest+0x7a>
    int fd = open("oidir", O_RDWR);
    3540:	4589                	li	a1,2
    3542:	00004517          	auipc	a0,0x4
    3546:	d8650513          	addi	a0,a0,-634 # 72c8 <malloc+0x1bd0>
    354a:	50b010ef          	jal	5254 <open>
    if (fd >= 0) {
    354e:	04054063          	bltz	a0,358e <openiputtest+0x74>
      printf("%s: open directory for write succeeded\n", s);
    3552:	85a6                	mv	a1,s1
    3554:	00004517          	auipc	a0,0x4
    3558:	d9450513          	addi	a0,a0,-620 # 72e8 <malloc+0x1bf0>
    355c:	0e8020ef          	jal	5644 <printf>
      exit(1);
    3560:	4505                	li	a0,1
    3562:	4b3010ef          	jal	5214 <exit>
    printf("%s: mkdir oidir failed\n", s);
    3566:	85a6                	mv	a1,s1
    3568:	00004517          	auipc	a0,0x4
    356c:	d6850513          	addi	a0,a0,-664 # 72d0 <malloc+0x1bd8>
    3570:	0d4020ef          	jal	5644 <printf>
    exit(1);
    3574:	4505                	li	a0,1
    3576:	49f010ef          	jal	5214 <exit>
    printf("%s: fork failed\n", s);
    357a:	85a6                	mv	a1,s1
    357c:	00003517          	auipc	a0,0x3
    3580:	b3c50513          	addi	a0,a0,-1220 # 60b8 <malloc+0x9c0>
    3584:	0c0020ef          	jal	5644 <printf>
    exit(1);
    3588:	4505                	li	a0,1
    358a:	48b010ef          	jal	5214 <exit>
    exit(0);
    358e:	4501                	li	a0,0
    3590:	485010ef          	jal	5214 <exit>
  pause(1);
    3594:	4505                	li	a0,1
    3596:	50f010ef          	jal	52a4 <pause>
  if (unlink("oidir") != 0) {
    359a:	00004517          	auipc	a0,0x4
    359e:	d2e50513          	addi	a0,a0,-722 # 72c8 <malloc+0x1bd0>
    35a2:	4c3010ef          	jal	5264 <unlink>
    35a6:	c919                	beqz	a0,35bc <openiputtest+0xa2>
    printf("%s: unlink failed\n", s);
    35a8:	85a6                	mv	a1,s1
    35aa:	00003517          	auipc	a0,0x3
    35ae:	c9650513          	addi	a0,a0,-874 # 6240 <malloc+0xb48>
    35b2:	092020ef          	jal	5644 <printf>
    exit(1);
    35b6:	4505                	li	a0,1
    35b8:	45d010ef          	jal	5214 <exit>
  wait(&xstatus);
    35bc:	fdc40513          	addi	a0,s0,-36
    35c0:	45d010ef          	jal	521c <wait>
  exit(xstatus);
    35c4:	fdc42503          	lw	a0,-36(s0)
    35c8:	44d010ef          	jal	5214 <exit>

00000000000035cc <forkforkfork>:
{
    35cc:	1101                	addi	sp,sp,-32
    35ce:	ec06                	sd	ra,24(sp)
    35d0:	e822                	sd	s0,16(sp)
    35d2:	e426                	sd	s1,8(sp)
    35d4:	1000                	addi	s0,sp,32
    35d6:	84aa                	mv	s1,a0
  unlink("stopforking");
    35d8:	00004517          	auipc	a0,0x4
    35dc:	d3850513          	addi	a0,a0,-712 # 7310 <malloc+0x1c18>
    35e0:	485010ef          	jal	5264 <unlink>
  int pid = fork();
    35e4:	429010ef          	jal	520c <fork>
  if (pid < 0) {
    35e8:	02054b63          	bltz	a0,361e <forkforkfork+0x52>
  if (pid == 0) {
    35ec:	c139                	beqz	a0,3632 <forkforkfork+0x66>
  pause(20); // two seconds
    35ee:	4551                	li	a0,20
    35f0:	4b5010ef          	jal	52a4 <pause>
  close(open("stopforking", O_CREATE | O_RDWR));
    35f4:	20200593          	li	a1,514
    35f8:	00004517          	auipc	a0,0x4
    35fc:	d1850513          	addi	a0,a0,-744 # 7310 <malloc+0x1c18>
    3600:	455010ef          	jal	5254 <open>
    3604:	439010ef          	jal	523c <close>
  wait(0);
    3608:	4501                	li	a0,0
    360a:	413010ef          	jal	521c <wait>
  pause(10); // one second
    360e:	4529                	li	a0,10
    3610:	495010ef          	jal	52a4 <pause>
}
    3614:	60e2                	ld	ra,24(sp)
    3616:	6442                	ld	s0,16(sp)
    3618:	64a2                	ld	s1,8(sp)
    361a:	6105                	addi	sp,sp,32
    361c:	8082                	ret
    printf("%s: fork failed", s);
    361e:	85a6                	mv	a1,s1
    3620:	00003517          	auipc	a0,0x3
    3624:	bd850513          	addi	a0,a0,-1064 # 61f8 <malloc+0xb00>
    3628:	01c020ef          	jal	5644 <printf>
    exit(1);
    362c:	4505                	li	a0,1
    362e:	3e7010ef          	jal	5214 <exit>
      int fd = open("stopforking", 0);
    3632:	00004497          	auipc	s1,0x4
    3636:	cde48493          	addi	s1,s1,-802 # 7310 <malloc+0x1c18>
    363a:	4581                	li	a1,0
    363c:	8526                	mv	a0,s1
    363e:	417010ef          	jal	5254 <open>
      if (fd >= 0) {
    3642:	02055163          	bgez	a0,3664 <forkforkfork+0x98>
      if (fork() < 0) {
    3646:	3c7010ef          	jal	520c <fork>
    364a:	fe0558e3          	bgez	a0,363a <forkforkfork+0x6e>
        close(open("stopforking", O_CREATE | O_RDWR));
    364e:	20200593          	li	a1,514
    3652:	00004517          	auipc	a0,0x4
    3656:	cbe50513          	addi	a0,a0,-834 # 7310 <malloc+0x1c18>
    365a:	3fb010ef          	jal	5254 <open>
    365e:	3df010ef          	jal	523c <close>
    3662:	bfe1                	j	363a <forkforkfork+0x6e>
        exit(0);
    3664:	4501                	li	a0,0
    3666:	3af010ef          	jal	5214 <exit>

000000000000366a <exectest>:
{
    366a:	711d                	addi	sp,sp,-96
    366c:	ec86                	sd	ra,88(sp)
    366e:	e8a2                	sd	s0,80(sp)
    3670:	e0ca                	sd	s2,64(sp)
    3672:	1080                	addi	s0,sp,96
    3674:	892a                	mv	s2,a0
  char *echoargv[] = {"echo", "OK", 0};
    3676:	00002797          	auipc	a5,0x2
    367a:	1b278793          	addi	a5,a5,434 # 5828 <malloc+0x130>
    367e:	faf43823          	sd	a5,-80(s0)
    3682:	00004797          	auipc	a5,0x4
    3686:	c9e78793          	addi	a5,a5,-866 # 7320 <malloc+0x1c28>
    368a:	faf43c23          	sd	a5,-72(s0)
    368e:	fc043023          	sd	zero,-64(s0)
  unlink("echo-ok");
    3692:	00004517          	auipc	a0,0x4
    3696:	c9650513          	addi	a0,a0,-874 # 7328 <malloc+0x1c30>
    369a:	3cb010ef          	jal	5264 <unlink>
  pid = fork();
    369e:	36f010ef          	jal	520c <fork>
  if (pid < 0) {
    36a2:	04054763          	bltz	a0,36f0 <exectest+0x86>
    36a6:	e4a6                	sd	s1,72(sp)
    36a8:	fc4e                	sd	s3,56(sp)
    36aa:	84aa                	mv	s1,a0
  if (pid == 0) {
    36ac:	ed49                	bnez	a0,3746 <exectest+0xdc>
    int errfd = dup(1);
    36ae:	4505                	li	a0,1
    36b0:	3dd010ef          	jal	528c <dup>
    36b4:	89aa                	mv	s3,a0
    if (errfd < 0) {
    36b6:	04054963          	bltz	a0,3708 <exectest+0x9e>
    close(1);
    36ba:	4505                	li	a0,1
    36bc:	381010ef          	jal	523c <close>
    fd = open("echo-ok", O_CREATE | O_WRONLY);
    36c0:	20100593          	li	a1,513
    36c4:	00004517          	auipc	a0,0x4
    36c8:	c6450513          	addi	a0,a0,-924 # 7328 <malloc+0x1c30>
    36cc:	389010ef          	jal	5254 <open>
    if (fd < 0) {
    36d0:	04054663          	bltz	a0,371c <exectest+0xb2>
    if (fd != 1) {
    36d4:	4785                	li	a5,1
    36d6:	04f50e63          	beq	a0,a5,3732 <exectest+0xc8>
      fprintf(errfd, "%s: wrong fd\n", s);
    36da:	864a                	mv	a2,s2
    36dc:	00004597          	auipc	a1,0x4
    36e0:	c6458593          	addi	a1,a1,-924 # 7340 <malloc+0x1c48>
    36e4:	854e                	mv	a0,s3
    36e6:	735010ef          	jal	561a <fprintf>
      exit(1);
    36ea:	4505                	li	a0,1
    36ec:	329010ef          	jal	5214 <exit>
    36f0:	e4a6                	sd	s1,72(sp)
    36f2:	fc4e                	sd	s3,56(sp)
    printf("%s: fork failed\n", s);
    36f4:	85ca                	mv	a1,s2
    36f6:	00003517          	auipc	a0,0x3
    36fa:	9c250513          	addi	a0,a0,-1598 # 60b8 <malloc+0x9c0>
    36fe:	747010ef          	jal	5644 <printf>
    exit(1);
    3702:	4505                	li	a0,1
    3704:	311010ef          	jal	5214 <exit>
      printf("%s: dup failed\n", s);
    3708:	85ca                	mv	a1,s2
    370a:	00004517          	auipc	a0,0x4
    370e:	c2650513          	addi	a0,a0,-986 # 7330 <malloc+0x1c38>
    3712:	733010ef          	jal	5644 <printf>
      exit(1);
    3716:	4505                	li	a0,1
    3718:	2fd010ef          	jal	5214 <exit>
      fprintf(errfd, "%s: create failed\n", s);
    371c:	864a                	mv	a2,s2
    371e:	00003597          	auipc	a1,0x3
    3722:	b0a58593          	addi	a1,a1,-1270 # 6228 <malloc+0xb30>
    3726:	854e                	mv	a0,s3
    3728:	6f3010ef          	jal	561a <fprintf>
      exit(1);
    372c:	4505                	li	a0,1
    372e:	2e7010ef          	jal	5214 <exit>
    if (exec("echo", echoargv) < 0) {
    3732:	fb040593          	addi	a1,s0,-80
    3736:	00002517          	auipc	a0,0x2
    373a:	0f250513          	addi	a0,a0,242 # 5828 <malloc+0x130>
    373e:	30f010ef          	jal	524c <exec>
    3742:	02054563          	bltz	a0,376c <exectest+0x102>
  if (wait(&xstatus) != pid) {
    3746:	fcc40513          	addi	a0,s0,-52
    374a:	2d3010ef          	jal	521c <wait>
    374e:	02951a63          	bne	a0,s1,3782 <exectest+0x118>
  if (xstatus != 0) {
    3752:	fcc42603          	lw	a2,-52(s0)
    3756:	ce15                	beqz	a2,3792 <exectest+0x128>
    printf("%s: nonzero wait status %d\n", s, xstatus);
    3758:	85ca                	mv	a1,s2
    375a:	00004517          	auipc	a0,0x4
    375e:	c2650513          	addi	a0,a0,-986 # 7380 <malloc+0x1c88>
    3762:	6e3010ef          	jal	5644 <printf>
    exit(1);
    3766:	4505                	li	a0,1
    3768:	2ad010ef          	jal	5214 <exit>
      fprintf(errfd, "%s: exec echo failed\n", s);
    376c:	864a                	mv	a2,s2
    376e:	00004597          	auipc	a1,0x4
    3772:	be258593          	addi	a1,a1,-1054 # 7350 <malloc+0x1c58>
    3776:	854e                	mv	a0,s3
    3778:	6a3010ef          	jal	561a <fprintf>
      exit(1);
    377c:	4505                	li	a0,1
    377e:	297010ef          	jal	5214 <exit>
    printf("%s: wait failed!\n", s);
    3782:	85ca                	mv	a1,s2
    3784:	00004517          	auipc	a0,0x4
    3788:	be450513          	addi	a0,a0,-1052 # 7368 <malloc+0x1c70>
    378c:	6b9010ef          	jal	5644 <printf>
    3790:	b7c9                	j	3752 <exectest+0xe8>
  fd = open("echo-ok", O_RDONLY);
    3792:	4581                	li	a1,0
    3794:	00004517          	auipc	a0,0x4
    3798:	b9450513          	addi	a0,a0,-1132 # 7328 <malloc+0x1c30>
    379c:	2b9010ef          	jal	5254 <open>
  if (fd < 0) {
    37a0:	02054463          	bltz	a0,37c8 <exectest+0x15e>
  if (read(fd, buf, 2) != 2) {
    37a4:	4609                	li	a2,2
    37a6:	fa840593          	addi	a1,s0,-88
    37aa:	283010ef          	jal	522c <read>
    37ae:	4789                	li	a5,2
    37b0:	02f50663          	beq	a0,a5,37dc <exectest+0x172>
    printf("%s: read failed\n", s);
    37b4:	85ca                	mv	a1,s2
    37b6:	00002517          	auipc	a0,0x2
    37ba:	44250513          	addi	a0,a0,1090 # 5bf8 <malloc+0x500>
    37be:	687010ef          	jal	5644 <printf>
    exit(1);
    37c2:	4505                	li	a0,1
    37c4:	251010ef          	jal	5214 <exit>
    printf("%s: open failed\n", s);
    37c8:	85ca                	mv	a1,s2
    37ca:	00003517          	auipc	a0,0x3
    37ce:	90650513          	addi	a0,a0,-1786 # 60d0 <malloc+0x9d8>
    37d2:	673010ef          	jal	5644 <printf>
    exit(1);
    37d6:	4505                	li	a0,1
    37d8:	23d010ef          	jal	5214 <exit>
  unlink("echo-ok");
    37dc:	00004517          	auipc	a0,0x4
    37e0:	b4c50513          	addi	a0,a0,-1204 # 7328 <malloc+0x1c30>
    37e4:	281010ef          	jal	5264 <unlink>
  if (buf[0] == 'O' && buf[1] == 'K')
    37e8:	fa844703          	lbu	a4,-88(s0)
    37ec:	04f00793          	li	a5,79
    37f0:	00f71863          	bne	a4,a5,3800 <exectest+0x196>
    37f4:	fa944703          	lbu	a4,-87(s0)
    37f8:	04b00793          	li	a5,75
    37fc:	00f70c63          	beq	a4,a5,3814 <exectest+0x1aa>
    printf("%s: wrong output\n", s);
    3800:	85ca                	mv	a1,s2
    3802:	00004517          	auipc	a0,0x4
    3806:	b9e50513          	addi	a0,a0,-1122 # 73a0 <malloc+0x1ca8>
    380a:	63b010ef          	jal	5644 <printf>
    exit(1);
    380e:	4505                	li	a0,1
    3810:	205010ef          	jal	5214 <exit>
    exit(0);
    3814:	4501                	li	a0,0
    3816:	1ff010ef          	jal	5214 <exit>

000000000000381a <killstatus>:
{
    381a:	7139                	addi	sp,sp,-64
    381c:	fc06                	sd	ra,56(sp)
    381e:	f822                	sd	s0,48(sp)
    3820:	f426                	sd	s1,40(sp)
    3822:	f04a                	sd	s2,32(sp)
    3824:	ec4e                	sd	s3,24(sp)
    3826:	e852                	sd	s4,16(sp)
    3828:	0080                	addi	s0,sp,64
    382a:	8a2a                	mv	s4,a0
    382c:	06400913          	li	s2,100
    if (xst != -1) {
    3830:	59fd                	li	s3,-1
    int pid1 = fork();
    3832:	1db010ef          	jal	520c <fork>
    3836:	84aa                	mv	s1,a0
    if (pid1 < 0) {
    3838:	02054763          	bltz	a0,3866 <killstatus+0x4c>
    if (pid1 == 0) {
    383c:	cd1d                	beqz	a0,387a <killstatus+0x60>
    pause(1);
    383e:	4505                	li	a0,1
    3840:	265010ef          	jal	52a4 <pause>
    kill(pid1);
    3844:	8526                	mv	a0,s1
    3846:	1ff010ef          	jal	5244 <kill>
    wait(&xst);
    384a:	fcc40513          	addi	a0,s0,-52
    384e:	1cf010ef          	jal	521c <wait>
    if (xst != -1) {
    3852:	fcc42783          	lw	a5,-52(s0)
    3856:	03379563          	bne	a5,s3,3880 <killstatus+0x66>
  for (int i = 0; i < 100; i++) {
    385a:	397d                	addiw	s2,s2,-1
    385c:	fc091be3          	bnez	s2,3832 <killstatus+0x18>
  exit(0);
    3860:	4501                	li	a0,0
    3862:	1b3010ef          	jal	5214 <exit>
      printf("%s: fork failed\n", s);
    3866:	85d2                	mv	a1,s4
    3868:	00003517          	auipc	a0,0x3
    386c:	85050513          	addi	a0,a0,-1968 # 60b8 <malloc+0x9c0>
    3870:	5d5010ef          	jal	5644 <printf>
      exit(1);
    3874:	4505                	li	a0,1
    3876:	19f010ef          	jal	5214 <exit>
        getpid();
    387a:	21b010ef          	jal	5294 <getpid>
      while (1) {
    387e:	bff5                	j	387a <killstatus+0x60>
      printf("%s: status should be -1\n", s);
    3880:	85d2                	mv	a1,s4
    3882:	00004517          	auipc	a0,0x4
    3886:	b3650513          	addi	a0,a0,-1226 # 73b8 <malloc+0x1cc0>
    388a:	5bb010ef          	jal	5644 <printf>
      exit(1);
    388e:	4505                	li	a0,1
    3890:	185010ef          	jal	5214 <exit>

0000000000003894 <preempt>:
{
    3894:	7139                	addi	sp,sp,-64
    3896:	fc06                	sd	ra,56(sp)
    3898:	f822                	sd	s0,48(sp)
    389a:	f426                	sd	s1,40(sp)
    389c:	f04a                	sd	s2,32(sp)
    389e:	ec4e                	sd	s3,24(sp)
    38a0:	e852                	sd	s4,16(sp)
    38a2:	0080                	addi	s0,sp,64
    38a4:	892a                	mv	s2,a0
  pid1 = fork();
    38a6:	167010ef          	jal	520c <fork>
  if (pid1 < 0) {
    38aa:	00054563          	bltz	a0,38b4 <preempt+0x20>
    38ae:	84aa                	mv	s1,a0
  if (pid1 == 0)
    38b0:	ed01                	bnez	a0,38c8 <preempt+0x34>
    for (;;)
    38b2:	a001                	j	38b2 <preempt+0x1e>
    printf("%s: fork failed", s);
    38b4:	85ca                	mv	a1,s2
    38b6:	00003517          	auipc	a0,0x3
    38ba:	94250513          	addi	a0,a0,-1726 # 61f8 <malloc+0xb00>
    38be:	587010ef          	jal	5644 <printf>
    exit(1);
    38c2:	4505                	li	a0,1
    38c4:	151010ef          	jal	5214 <exit>
  pid2 = fork();
    38c8:	145010ef          	jal	520c <fork>
    38cc:	89aa                	mv	s3,a0
  if (pid2 < 0) {
    38ce:	00054463          	bltz	a0,38d6 <preempt+0x42>
  if (pid2 == 0)
    38d2:	ed01                	bnez	a0,38ea <preempt+0x56>
    for (;;)
    38d4:	a001                	j	38d4 <preempt+0x40>
    printf("%s: fork failed\n", s);
    38d6:	85ca                	mv	a1,s2
    38d8:	00002517          	auipc	a0,0x2
    38dc:	7e050513          	addi	a0,a0,2016 # 60b8 <malloc+0x9c0>
    38e0:	565010ef          	jal	5644 <printf>
    exit(1);
    38e4:	4505                	li	a0,1
    38e6:	12f010ef          	jal	5214 <exit>
  pipe(pfds);
    38ea:	fc840513          	addi	a0,s0,-56
    38ee:	137010ef          	jal	5224 <pipe>
  pid3 = fork();
    38f2:	11b010ef          	jal	520c <fork>
    38f6:	8a2a                	mv	s4,a0
  if (pid3 < 0) {
    38f8:	02054863          	bltz	a0,3928 <preempt+0x94>
  if (pid3 == 0) {
    38fc:	e921                	bnez	a0,394c <preempt+0xb8>
    close(pfds[0]);
    38fe:	fc842503          	lw	a0,-56(s0)
    3902:	13b010ef          	jal	523c <close>
    if (write(pfds[1], "x", 1) != 1)
    3906:	4605                	li	a2,1
    3908:	00002597          	auipc	a1,0x2
    390c:	f9058593          	addi	a1,a1,-112 # 5898 <malloc+0x1a0>
    3910:	fcc42503          	lw	a0,-52(s0)
    3914:	121010ef          	jal	5234 <write>
    3918:	4785                	li	a5,1
    391a:	02f51163          	bne	a0,a5,393c <preempt+0xa8>
    close(pfds[1]);
    391e:	fcc42503          	lw	a0,-52(s0)
    3922:	11b010ef          	jal	523c <close>
    for (;;)
    3926:	a001                	j	3926 <preempt+0x92>
    printf("%s: fork failed\n", s);
    3928:	85ca                	mv	a1,s2
    392a:	00002517          	auipc	a0,0x2
    392e:	78e50513          	addi	a0,a0,1934 # 60b8 <malloc+0x9c0>
    3932:	513010ef          	jal	5644 <printf>
    exit(1);
    3936:	4505                	li	a0,1
    3938:	0dd010ef          	jal	5214 <exit>
      printf("%s: preempt write error", s);
    393c:	85ca                	mv	a1,s2
    393e:	00004517          	auipc	a0,0x4
    3942:	a9a50513          	addi	a0,a0,-1382 # 73d8 <malloc+0x1ce0>
    3946:	4ff010ef          	jal	5644 <printf>
    394a:	bfd1                	j	391e <preempt+0x8a>
  close(pfds[1]);
    394c:	fcc42503          	lw	a0,-52(s0)
    3950:	0ed010ef          	jal	523c <close>
  if (read(pfds[0], buf, sizeof(buf)) != 1) {
    3954:	660d                	lui	a2,0x3
    3956:	0000a597          	auipc	a1,0xa
    395a:	39258593          	addi	a1,a1,914 # dce8 <buf>
    395e:	fc842503          	lw	a0,-56(s0)
    3962:	0cb010ef          	jal	522c <read>
    3966:	4785                	li	a5,1
    3968:	02f50163          	beq	a0,a5,398a <preempt+0xf6>
    printf("%s: preempt read error", s);
    396c:	85ca                	mv	a1,s2
    396e:	00004517          	auipc	a0,0x4
    3972:	a8250513          	addi	a0,a0,-1406 # 73f0 <malloc+0x1cf8>
    3976:	4cf010ef          	jal	5644 <printf>
}
    397a:	70e2                	ld	ra,56(sp)
    397c:	7442                	ld	s0,48(sp)
    397e:	74a2                	ld	s1,40(sp)
    3980:	7902                	ld	s2,32(sp)
    3982:	69e2                	ld	s3,24(sp)
    3984:	6a42                	ld	s4,16(sp)
    3986:	6121                	addi	sp,sp,64
    3988:	8082                	ret
  close(pfds[0]);
    398a:	fc842503          	lw	a0,-56(s0)
    398e:	0af010ef          	jal	523c <close>
  printf("kill... ");
    3992:	00004517          	auipc	a0,0x4
    3996:	a7650513          	addi	a0,a0,-1418 # 7408 <malloc+0x1d10>
    399a:	4ab010ef          	jal	5644 <printf>
  kill(pid1);
    399e:	8526                	mv	a0,s1
    39a0:	0a5010ef          	jal	5244 <kill>
  kill(pid2);
    39a4:	854e                	mv	a0,s3
    39a6:	09f010ef          	jal	5244 <kill>
  kill(pid3);
    39aa:	8552                	mv	a0,s4
    39ac:	099010ef          	jal	5244 <kill>
  printf("wait... ");
    39b0:	00004517          	auipc	a0,0x4
    39b4:	a6850513          	addi	a0,a0,-1432 # 7418 <malloc+0x1d20>
    39b8:	48d010ef          	jal	5644 <printf>
  wait(0);
    39bc:	4501                	li	a0,0
    39be:	05f010ef          	jal	521c <wait>
  wait(0);
    39c2:	4501                	li	a0,0
    39c4:	059010ef          	jal	521c <wait>
  wait(0);
    39c8:	4501                	li	a0,0
    39ca:	053010ef          	jal	521c <wait>
    39ce:	b775                	j	397a <preempt+0xe6>

00000000000039d0 <reparent>:
{
    39d0:	7179                	addi	sp,sp,-48
    39d2:	f406                	sd	ra,40(sp)
    39d4:	f022                	sd	s0,32(sp)
    39d6:	ec26                	sd	s1,24(sp)
    39d8:	e84a                	sd	s2,16(sp)
    39da:	e44e                	sd	s3,8(sp)
    39dc:	e052                	sd	s4,0(sp)
    39de:	1800                	addi	s0,sp,48
    39e0:	89aa                	mv	s3,a0
  int master_pid = getpid();
    39e2:	0b3010ef          	jal	5294 <getpid>
    39e6:	8a2a                	mv	s4,a0
    39e8:	0c800913          	li	s2,200
    int pid = fork();
    39ec:	021010ef          	jal	520c <fork>
    39f0:	84aa                	mv	s1,a0
    if (pid < 0) {
    39f2:	00054e63          	bltz	a0,3a0e <reparent+0x3e>
    if (pid) {
    39f6:	c121                	beqz	a0,3a36 <reparent+0x66>
      if (wait(0) != pid) {
    39f8:	4501                	li	a0,0
    39fa:	023010ef          	jal	521c <wait>
    39fe:	02951263          	bne	a0,s1,3a22 <reparent+0x52>
  for (int i = 0; i < 200; i++) {
    3a02:	397d                	addiw	s2,s2,-1
    3a04:	fe0914e3          	bnez	s2,39ec <reparent+0x1c>
  exit(0);
    3a08:	4501                	li	a0,0
    3a0a:	00b010ef          	jal	5214 <exit>
      printf("%s: fork failed\n", s);
    3a0e:	85ce                	mv	a1,s3
    3a10:	00002517          	auipc	a0,0x2
    3a14:	6a850513          	addi	a0,a0,1704 # 60b8 <malloc+0x9c0>
    3a18:	42d010ef          	jal	5644 <printf>
      exit(1);
    3a1c:	4505                	li	a0,1
    3a1e:	7f6010ef          	jal	5214 <exit>
        printf("%s: wait wrong pid\n", s);
    3a22:	85ce                	mv	a1,s3
    3a24:	00002517          	auipc	a0,0x2
    3a28:	79c50513          	addi	a0,a0,1948 # 61c0 <malloc+0xac8>
    3a2c:	419010ef          	jal	5644 <printf>
        exit(1);
    3a30:	4505                	li	a0,1
    3a32:	7e2010ef          	jal	5214 <exit>
      int pid2 = fork();
    3a36:	7d6010ef          	jal	520c <fork>
      if (pid2 < 0) {
    3a3a:	00054563          	bltz	a0,3a44 <reparent+0x74>
      exit(0);
    3a3e:	4501                	li	a0,0
    3a40:	7d4010ef          	jal	5214 <exit>
        kill(master_pid);
    3a44:	8552                	mv	a0,s4
    3a46:	7fe010ef          	jal	5244 <kill>
        exit(1);
    3a4a:	4505                	li	a0,1
    3a4c:	7c8010ef          	jal	5214 <exit>

0000000000003a50 <sbrkfail>:
{
    3a50:	7175                	addi	sp,sp,-144
    3a52:	e506                	sd	ra,136(sp)
    3a54:	e122                	sd	s0,128(sp)
    3a56:	fca6                	sd	s1,120(sp)
    3a58:	f8ca                	sd	s2,112(sp)
    3a5a:	f4ce                	sd	s3,104(sp)
    3a5c:	f0d2                	sd	s4,96(sp)
    3a5e:	ecd6                	sd	s5,88(sp)
    3a60:	e8da                	sd	s6,80(sp)
    3a62:	e4de                	sd	s7,72(sp)
    3a64:	0900                	addi	s0,sp,144
    3a66:	8b2a                	mv	s6,a0
  if (pipe(fds) != 0) {
    3a68:	fa040513          	addi	a0,s0,-96
    3a6c:	7b8010ef          	jal	5224 <pipe>
    3a70:	e919                	bnez	a0,3a86 <sbrkfail+0x36>
    3a72:	8aaa                	mv	s5,a0
    3a74:	f7040493          	addi	s1,s0,-144
    3a78:	f9840993          	addi	s3,s0,-104
    3a7c:	8926                	mv	s2,s1
    if (pids[i] != -1) {
    3a7e:	5a7d                	li	s4,-1
      if (scratch == '0')
    3a80:	03000b93          	li	s7,48
    3a84:	a08d                	j	3ae6 <sbrkfail+0x96>
    printf("%s: pipe() failed\n", s);
    3a86:	85da                	mv	a1,s6
    3a88:	00002517          	auipc	a0,0x2
    3a8c:	6b850513          	addi	a0,a0,1720 # 6140 <malloc+0xa48>
    3a90:	3b5010ef          	jal	5644 <printf>
    exit(1);
    3a94:	4505                	li	a0,1
    3a96:	77e010ef          	jal	5214 <exit>
      if (sbrk(BIG - (uint64)sbrk(0)) == (char *)SBRK_ERROR)
    3a9a:	746010ef          	jal	51e0 <sbrk>
    3a9e:	064007b7          	lui	a5,0x6400
    3aa2:	40a7853b          	subw	a0,a5,a0
    3aa6:	73a010ef          	jal	51e0 <sbrk>
    3aaa:	57fd                	li	a5,-1
    3aac:	02f50063          	beq	a0,a5,3acc <sbrkfail+0x7c>
        write(fds[1], "1", 1);
    3ab0:	4605                	li	a2,1
    3ab2:	00004597          	auipc	a1,0x4
    3ab6:	26658593          	addi	a1,a1,614 # 7d18 <malloc+0x2620>
    3aba:	fa442503          	lw	a0,-92(s0)
    3abe:	776010ef          	jal	5234 <write>
        pause(1000);
    3ac2:	3e800513          	li	a0,1000
    3ac6:	7de010ef          	jal	52a4 <pause>
      for (;;)
    3aca:	bfe5                	j	3ac2 <sbrkfail+0x72>
        write(fds[1], "0", 1);
    3acc:	4605                	li	a2,1
    3ace:	00004597          	auipc	a1,0x4
    3ad2:	95a58593          	addi	a1,a1,-1702 # 7428 <malloc+0x1d30>
    3ad6:	fa442503          	lw	a0,-92(s0)
    3ada:	75a010ef          	jal	5234 <write>
    3ade:	b7d5                	j	3ac2 <sbrkfail+0x72>
  for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
    3ae0:	0911                	addi	s2,s2,4
    3ae2:	03390663          	beq	s2,s3,3b0e <sbrkfail+0xbe>
    if ((pids[i] = fork()) == 0) {
    3ae6:	726010ef          	jal	520c <fork>
    3aea:	00a92023          	sw	a0,0(s2)
    3aee:	d555                	beqz	a0,3a9a <sbrkfail+0x4a>
    if (pids[i] != -1) {
    3af0:	ff4508e3          	beq	a0,s4,3ae0 <sbrkfail+0x90>
      read(fds[0], &scratch, 1);
    3af4:	4605                	li	a2,1
    3af6:	f9f40593          	addi	a1,s0,-97
    3afa:	fa042503          	lw	a0,-96(s0)
    3afe:	72e010ef          	jal	522c <read>
      if (scratch == '0')
    3b02:	f9f44783          	lbu	a5,-97(s0)
    3b06:	fd779de3          	bne	a5,s7,3ae0 <sbrkfail+0x90>
        failed = 1;
    3b0a:	4a85                	li	s5,1
    3b0c:	bfd1                	j	3ae0 <sbrkfail+0x90>
  if (!failed) {
    3b0e:	000a8863          	beqz	s5,3b1e <sbrkfail+0xce>
  c = sbrk(PGSIZE);
    3b12:	6505                	lui	a0,0x1
    3b14:	6cc010ef          	jal	51e0 <sbrk>
    3b18:	8a2a                	mv	s4,a0
    if (pids[i] == -1)
    3b1a:	597d                	li	s2,-1
    3b1c:	a821                	j	3b34 <sbrkfail+0xe4>
    printf("%s: no allocation failed; allocate more?\n", s);
    3b1e:	85da                	mv	a1,s6
    3b20:	00004517          	auipc	a0,0x4
    3b24:	91050513          	addi	a0,a0,-1776 # 7430 <malloc+0x1d38>
    3b28:	31d010ef          	jal	5644 <printf>
    3b2c:	b7dd                	j	3b12 <sbrkfail+0xc2>
  for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
    3b2e:	0491                	addi	s1,s1,4
    3b30:	01348b63          	beq	s1,s3,3b46 <sbrkfail+0xf6>
    if (pids[i] == -1)
    3b34:	4088                	lw	a0,0(s1)
    3b36:	ff250ce3          	beq	a0,s2,3b2e <sbrkfail+0xde>
    kill(pids[i]);
    3b3a:	70a010ef          	jal	5244 <kill>
    wait(0);
    3b3e:	4501                	li	a0,0
    3b40:	6dc010ef          	jal	521c <wait>
    3b44:	b7ed                	j	3b2e <sbrkfail+0xde>
  if (c == (char *)SBRK_ERROR) {
    3b46:	57fd                	li	a5,-1
    3b48:	02fa0a63          	beq	s4,a5,3b7c <sbrkfail+0x12c>
  pid = fork();
    3b4c:	6c0010ef          	jal	520c <fork>
  if (pid < 0) {
    3b50:	04054063          	bltz	a0,3b90 <sbrkfail+0x140>
  if (pid == 0) {
    3b54:	e939                	bnez	a0,3baa <sbrkfail+0x15a>
    a = sbrk(10 * BIG);
    3b56:	3e800537          	lui	a0,0x3e800
    3b5a:	686010ef          	jal	51e0 <sbrk>
    if (a == (char *)SBRK_ERROR) {
    3b5e:	57fd                	li	a5,-1
    3b60:	04f50263          	beq	a0,a5,3ba4 <sbrkfail+0x154>
    printf("%s: allocate a lot of memory succeeded %d\n", s, 10 * BIG);
    3b64:	3e800637          	lui	a2,0x3e800
    3b68:	85da                	mv	a1,s6
    3b6a:	00004517          	auipc	a0,0x4
    3b6e:	91650513          	addi	a0,a0,-1770 # 7480 <malloc+0x1d88>
    3b72:	2d3010ef          	jal	5644 <printf>
    exit(1);
    3b76:	4505                	li	a0,1
    3b78:	69c010ef          	jal	5214 <exit>
    printf("%s: failed sbrk leaked memory\n", s);
    3b7c:	85da                	mv	a1,s6
    3b7e:	00004517          	auipc	a0,0x4
    3b82:	8e250513          	addi	a0,a0,-1822 # 7460 <malloc+0x1d68>
    3b86:	2bf010ef          	jal	5644 <printf>
    exit(1);
    3b8a:	4505                	li	a0,1
    3b8c:	688010ef          	jal	5214 <exit>
    printf("%s: fork failed\n", s);
    3b90:	85da                	mv	a1,s6
    3b92:	00002517          	auipc	a0,0x2
    3b96:	52650513          	addi	a0,a0,1318 # 60b8 <malloc+0x9c0>
    3b9a:	2ab010ef          	jal	5644 <printf>
    exit(1);
    3b9e:	4505                	li	a0,1
    3ba0:	674010ef          	jal	5214 <exit>
      exit(0);
    3ba4:	4501                	li	a0,0
    3ba6:	66e010ef          	jal	5214 <exit>
  wait(&xstatus);
    3baa:	fac40513          	addi	a0,s0,-84
    3bae:	66e010ef          	jal	521c <wait>
  if (xstatus != 0)
    3bb2:	fac42783          	lw	a5,-84(s0)
    3bb6:	ef81                	bnez	a5,3bce <sbrkfail+0x17e>
}
    3bb8:	60aa                	ld	ra,136(sp)
    3bba:	640a                	ld	s0,128(sp)
    3bbc:	74e6                	ld	s1,120(sp)
    3bbe:	7946                	ld	s2,112(sp)
    3bc0:	79a6                	ld	s3,104(sp)
    3bc2:	7a06                	ld	s4,96(sp)
    3bc4:	6ae6                	ld	s5,88(sp)
    3bc6:	6b46                	ld	s6,80(sp)
    3bc8:	6ba6                	ld	s7,72(sp)
    3bca:	6149                	addi	sp,sp,144
    3bcc:	8082                	ret
    exit(1);
    3bce:	4505                	li	a0,1
    3bd0:	644010ef          	jal	5214 <exit>

0000000000003bd4 <mem>:
{
    3bd4:	7139                	addi	sp,sp,-64
    3bd6:	fc06                	sd	ra,56(sp)
    3bd8:	f822                	sd	s0,48(sp)
    3bda:	f426                	sd	s1,40(sp)
    3bdc:	f04a                	sd	s2,32(sp)
    3bde:	ec4e                	sd	s3,24(sp)
    3be0:	0080                	addi	s0,sp,64
    3be2:	89aa                	mv	s3,a0
  if ((pid = fork()) == 0) {
    3be4:	628010ef          	jal	520c <fork>
    m1 = 0;
    3be8:	4481                	li	s1,0
    while ((m2 = malloc(10001)) != 0) {
    3bea:	6909                	lui	s2,0x2
    3bec:	71190913          	addi	s2,s2,1809 # 2711 <diskfull+0xd1>
  if ((pid = fork()) == 0) {
    3bf0:	cd11                	beqz	a0,3c0c <mem+0x38>
    wait(&xstatus);
    3bf2:	fcc40513          	addi	a0,s0,-52
    3bf6:	626010ef          	jal	521c <wait>
    if (xstatus == -1) {
    3bfa:	fcc42503          	lw	a0,-52(s0)
    3bfe:	57fd                	li	a5,-1
    3c00:	04f50363          	beq	a0,a5,3c46 <mem+0x72>
    exit(xstatus);
    3c04:	610010ef          	jal	5214 <exit>
      *(char **)m2 = m1;
    3c08:	e104                	sd	s1,0(a0)
      m1 = m2;
    3c0a:	84aa                	mv	s1,a0
    while ((m2 = malloc(10001)) != 0) {
    3c0c:	854a                	mv	a0,s2
    3c0e:	2eb010ef          	jal	56f8 <malloc>
    3c12:	f97d                	bnez	a0,3c08 <mem+0x34>
    while (m1) {
    3c14:	c491                	beqz	s1,3c20 <mem+0x4c>
      m2 = *(char **)m1;
    3c16:	8526                	mv	a0,s1
    3c18:	6084                	ld	s1,0(s1)
      free(m1);
    3c1a:	25d010ef          	jal	5676 <free>
    while (m1) {
    3c1e:	fce5                	bnez	s1,3c16 <mem+0x42>
    m1 = malloc(1024 * 20);
    3c20:	6515                	lui	a0,0x5
    3c22:	2d7010ef          	jal	56f8 <malloc>
    if (m1 == 0) {
    3c26:	c511                	beqz	a0,3c32 <mem+0x5e>
    free(m1);
    3c28:	24f010ef          	jal	5676 <free>
    exit(0);
    3c2c:	4501                	li	a0,0
    3c2e:	5e6010ef          	jal	5214 <exit>
      printf("%s: couldn't allocate mem?!!\n", s);
    3c32:	85ce                	mv	a1,s3
    3c34:	00004517          	auipc	a0,0x4
    3c38:	87c50513          	addi	a0,a0,-1924 # 74b0 <malloc+0x1db8>
    3c3c:	209010ef          	jal	5644 <printf>
      exit(1);
    3c40:	4505                	li	a0,1
    3c42:	5d2010ef          	jal	5214 <exit>
      exit(0);
    3c46:	4501                	li	a0,0
    3c48:	5cc010ef          	jal	5214 <exit>

0000000000003c4c <sharedfd>:
{
    3c4c:	7159                	addi	sp,sp,-112
    3c4e:	f486                	sd	ra,104(sp)
    3c50:	f0a2                	sd	s0,96(sp)
    3c52:	e0d2                	sd	s4,64(sp)
    3c54:	1880                	addi	s0,sp,112
    3c56:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    3c58:	00004517          	auipc	a0,0x4
    3c5c:	87850513          	addi	a0,a0,-1928 # 74d0 <malloc+0x1dd8>
    3c60:	604010ef          	jal	5264 <unlink>
  fd = open("sharedfd", O_CREATE | O_RDWR);
    3c64:	20200593          	li	a1,514
    3c68:	00004517          	auipc	a0,0x4
    3c6c:	86850513          	addi	a0,a0,-1944 # 74d0 <malloc+0x1dd8>
    3c70:	5e4010ef          	jal	5254 <open>
  if (fd < 0) {
    3c74:	04054863          	bltz	a0,3cc4 <sharedfd+0x78>
    3c78:	eca6                	sd	s1,88(sp)
    3c7a:	e8ca                	sd	s2,80(sp)
    3c7c:	e4ce                	sd	s3,72(sp)
    3c7e:	fc56                	sd	s5,56(sp)
    3c80:	f85a                	sd	s6,48(sp)
    3c82:	f45e                	sd	s7,40(sp)
    3c84:	892a                	mv	s2,a0
  pid = fork();
    3c86:	586010ef          	jal	520c <fork>
    3c8a:	89aa                	mv	s3,a0
  memset(buf, pid == 0 ? 'c' : 'p', sizeof(buf));
    3c8c:	07000593          	li	a1,112
    3c90:	e119                	bnez	a0,3c96 <sharedfd+0x4a>
    3c92:	06300593          	li	a1,99
    3c96:	4629                	li	a2,10
    3c98:	fa040513          	addi	a0,s0,-96
    3c9c:	366010ef          	jal	5002 <memset>
    3ca0:	3e800493          	li	s1,1000
    if (write(fd, buf, sizeof(buf)) != sizeof(buf)) {
    3ca4:	4629                	li	a2,10
    3ca6:	fa040593          	addi	a1,s0,-96
    3caa:	854a                	mv	a0,s2
    3cac:	588010ef          	jal	5234 <write>
    3cb0:	47a9                	li	a5,10
    3cb2:	02f51963          	bne	a0,a5,3ce4 <sharedfd+0x98>
  for (i = 0; i < N; i++) {
    3cb6:	34fd                	addiw	s1,s1,-1
    3cb8:	f4f5                	bnez	s1,3ca4 <sharedfd+0x58>
  if (pid == 0) {
    3cba:	02099f63          	bnez	s3,3cf8 <sharedfd+0xac>
    exit(0);
    3cbe:	4501                	li	a0,0
    3cc0:	554010ef          	jal	5214 <exit>
    3cc4:	eca6                	sd	s1,88(sp)
    3cc6:	e8ca                	sd	s2,80(sp)
    3cc8:	e4ce                	sd	s3,72(sp)
    3cca:	fc56                	sd	s5,56(sp)
    3ccc:	f85a                	sd	s6,48(sp)
    3cce:	f45e                	sd	s7,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    3cd0:	85d2                	mv	a1,s4
    3cd2:	00004517          	auipc	a0,0x4
    3cd6:	80e50513          	addi	a0,a0,-2034 # 74e0 <malloc+0x1de8>
    3cda:	16b010ef          	jal	5644 <printf>
    exit(1);
    3cde:	4505                	li	a0,1
    3ce0:	534010ef          	jal	5214 <exit>
      printf("%s: write sharedfd failed\n", s);
    3ce4:	85d2                	mv	a1,s4
    3ce6:	00004517          	auipc	a0,0x4
    3cea:	82250513          	addi	a0,a0,-2014 # 7508 <malloc+0x1e10>
    3cee:	157010ef          	jal	5644 <printf>
      exit(1);
    3cf2:	4505                	li	a0,1
    3cf4:	520010ef          	jal	5214 <exit>
    wait(&xstatus);
    3cf8:	f9c40513          	addi	a0,s0,-100
    3cfc:	520010ef          	jal	521c <wait>
    if (xstatus != 0)
    3d00:	f9c42983          	lw	s3,-100(s0)
    3d04:	00098563          	beqz	s3,3d0e <sharedfd+0xc2>
      exit(xstatus);
    3d08:	854e                	mv	a0,s3
    3d0a:	50a010ef          	jal	5214 <exit>
  close(fd);
    3d0e:	854a                	mv	a0,s2
    3d10:	52c010ef          	jal	523c <close>
  fd = open("sharedfd", 0);
    3d14:	4581                	li	a1,0
    3d16:	00003517          	auipc	a0,0x3
    3d1a:	7ba50513          	addi	a0,a0,1978 # 74d0 <malloc+0x1dd8>
    3d1e:	536010ef          	jal	5254 <open>
    3d22:	8baa                	mv	s7,a0
  nc = np = 0;
    3d24:	8ace                	mv	s5,s3
  if (fd < 0) {
    3d26:	02054363          	bltz	a0,3d4c <sharedfd+0x100>
    3d2a:	faa40913          	addi	s2,s0,-86
      if (buf[i] == 'c')
    3d2e:	06300493          	li	s1,99
      if (buf[i] == 'p')
    3d32:	07000b13          	li	s6,112
  while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3d36:	4629                	li	a2,10
    3d38:	fa040593          	addi	a1,s0,-96
    3d3c:	855e                	mv	a0,s7
    3d3e:	4ee010ef          	jal	522c <read>
    3d42:	02a05b63          	blez	a0,3d78 <sharedfd+0x12c>
    3d46:	fa040793          	addi	a5,s0,-96
    3d4a:	a839                	j	3d68 <sharedfd+0x11c>
    printf("%s: cannot open sharedfd for reading\n", s);
    3d4c:	85d2                	mv	a1,s4
    3d4e:	00003517          	auipc	a0,0x3
    3d52:	7da50513          	addi	a0,a0,2010 # 7528 <malloc+0x1e30>
    3d56:	0ef010ef          	jal	5644 <printf>
    exit(1);
    3d5a:	4505                	li	a0,1
    3d5c:	4b8010ef          	jal	5214 <exit>
        nc++;
    3d60:	2985                	addiw	s3,s3,1
    for (i = 0; i < sizeof(buf); i++) {
    3d62:	0785                	addi	a5,a5,1 # 6400001 <base+0x63ef319>
    3d64:	fd2789e3          	beq	a5,s2,3d36 <sharedfd+0xea>
      if (buf[i] == 'c')
    3d68:	0007c703          	lbu	a4,0(a5)
    3d6c:	fe970ae3          	beq	a4,s1,3d60 <sharedfd+0x114>
      if (buf[i] == 'p')
    3d70:	ff6719e3          	bne	a4,s6,3d62 <sharedfd+0x116>
        np++;
    3d74:	2a85                	addiw	s5,s5,1
    3d76:	b7f5                	j	3d62 <sharedfd+0x116>
  close(fd);
    3d78:	855e                	mv	a0,s7
    3d7a:	4c2010ef          	jal	523c <close>
  unlink("sharedfd");
    3d7e:	00003517          	auipc	a0,0x3
    3d82:	75250513          	addi	a0,a0,1874 # 74d0 <malloc+0x1dd8>
    3d86:	4de010ef          	jal	5264 <unlink>
  if (nc == N * SZ && np == N * SZ) {
    3d8a:	6789                	lui	a5,0x2
    3d8c:	71078793          	addi	a5,a5,1808 # 2710 <diskfull+0xd0>
    3d90:	00f99763          	bne	s3,a5,3d9e <sharedfd+0x152>
    3d94:	6789                	lui	a5,0x2
    3d96:	71078793          	addi	a5,a5,1808 # 2710 <diskfull+0xd0>
    3d9a:	00fa8c63          	beq	s5,a5,3db2 <sharedfd+0x166>
    printf("%s: nc/np test fails\n", s);
    3d9e:	85d2                	mv	a1,s4
    3da0:	00003517          	auipc	a0,0x3
    3da4:	7b050513          	addi	a0,a0,1968 # 7550 <malloc+0x1e58>
    3da8:	09d010ef          	jal	5644 <printf>
    exit(1);
    3dac:	4505                	li	a0,1
    3dae:	466010ef          	jal	5214 <exit>
    exit(0);
    3db2:	4501                	li	a0,0
    3db4:	460010ef          	jal	5214 <exit>

0000000000003db8 <fourfiles>:
{
    3db8:	7135                	addi	sp,sp,-160
    3dba:	ed06                	sd	ra,152(sp)
    3dbc:	e922                	sd	s0,144(sp)
    3dbe:	e526                	sd	s1,136(sp)
    3dc0:	e14a                	sd	s2,128(sp)
    3dc2:	fcce                	sd	s3,120(sp)
    3dc4:	f8d2                	sd	s4,112(sp)
    3dc6:	f4d6                	sd	s5,104(sp)
    3dc8:	f0da                	sd	s6,96(sp)
    3dca:	ecde                	sd	s7,88(sp)
    3dcc:	e8e2                	sd	s8,80(sp)
    3dce:	e4e6                	sd	s9,72(sp)
    3dd0:	e0ea                	sd	s10,64(sp)
    3dd2:	fc6e                	sd	s11,56(sp)
    3dd4:	1100                	addi	s0,sp,160
    3dd6:	8caa                	mv	s9,a0
  char *names[] = {"f0", "f1", "f2", "f3"};
    3dd8:	00003797          	auipc	a5,0x3
    3ddc:	79078793          	addi	a5,a5,1936 # 7568 <malloc+0x1e70>
    3de0:	f6f43823          	sd	a5,-144(s0)
    3de4:	00003797          	auipc	a5,0x3
    3de8:	78c78793          	addi	a5,a5,1932 # 7570 <malloc+0x1e78>
    3dec:	f6f43c23          	sd	a5,-136(s0)
    3df0:	00003797          	auipc	a5,0x3
    3df4:	78878793          	addi	a5,a5,1928 # 7578 <malloc+0x1e80>
    3df8:	f8f43023          	sd	a5,-128(s0)
    3dfc:	00003797          	auipc	a5,0x3
    3e00:	78478793          	addi	a5,a5,1924 # 7580 <malloc+0x1e88>
    3e04:	f8f43423          	sd	a5,-120(s0)
  for (pi = 0; pi < NCHILD; pi++) {
    3e08:	f7040b93          	addi	s7,s0,-144
  char *names[] = {"f0", "f1", "f2", "f3"};
    3e0c:	895e                	mv	s2,s7
  for (pi = 0; pi < NCHILD; pi++) {
    3e0e:	4481                	li	s1,0
    3e10:	4a11                	li	s4,4
    fname = names[pi];
    3e12:	00093983          	ld	s3,0(s2)
    unlink(fname);
    3e16:	854e                	mv	a0,s3
    3e18:	44c010ef          	jal	5264 <unlink>
    pid = fork();
    3e1c:	3f0010ef          	jal	520c <fork>
    if (pid < 0) {
    3e20:	02054e63          	bltz	a0,3e5c <fourfiles+0xa4>
    if (pid == 0) {
    3e24:	c531                	beqz	a0,3e70 <fourfiles+0xb8>
  for (pi = 0; pi < NCHILD; pi++) {
    3e26:	2485                	addiw	s1,s1,1
    3e28:	0921                	addi	s2,s2,8
    3e2a:	ff4494e3          	bne	s1,s4,3e12 <fourfiles+0x5a>
    3e2e:	4491                	li	s1,4
    wait(&xstatus);
    3e30:	f6c40513          	addi	a0,s0,-148
    3e34:	3e8010ef          	jal	521c <wait>
    if (xstatus != 0)
    3e38:	f6c42a83          	lw	s5,-148(s0)
    3e3c:	0a0a9463          	bnez	s5,3ee4 <fourfiles+0x12c>
  for (pi = 0; pi < NCHILD; pi++) {
    3e40:	34fd                	addiw	s1,s1,-1
    3e42:	f4fd                	bnez	s1,3e30 <fourfiles+0x78>
    3e44:	03000b13          	li	s6,48
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3e48:	0000aa17          	auipc	s4,0xa
    3e4c:	ea0a0a13          	addi	s4,s4,-352 # dce8 <buf>
    if (total != N * SZ) {
    3e50:	6d05                	lui	s10,0x1
    3e52:	770d0d13          	addi	s10,s10,1904 # 1770 <createdelete+0xb6>
  for (i = 0; i < NCHILD; i++) {
    3e56:	03400d93          	li	s11,52
    3e5a:	a0ed                	j	3f44 <fourfiles+0x18c>
      printf("%s: fork failed\n", s);
    3e5c:	85e6                	mv	a1,s9
    3e5e:	00002517          	auipc	a0,0x2
    3e62:	25a50513          	addi	a0,a0,602 # 60b8 <malloc+0x9c0>
    3e66:	7de010ef          	jal	5644 <printf>
      exit(1);
    3e6a:	4505                	li	a0,1
    3e6c:	3a8010ef          	jal	5214 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    3e70:	20200593          	li	a1,514
    3e74:	854e                	mv	a0,s3
    3e76:	3de010ef          	jal	5254 <open>
    3e7a:	892a                	mv	s2,a0
      if (fd < 0) {
    3e7c:	04054163          	bltz	a0,3ebe <fourfiles+0x106>
      memset(buf, '0' + pi, SZ);
    3e80:	1f400613          	li	a2,500
    3e84:	0304859b          	addiw	a1,s1,48
    3e88:	0000a517          	auipc	a0,0xa
    3e8c:	e6050513          	addi	a0,a0,-416 # dce8 <buf>
    3e90:	172010ef          	jal	5002 <memset>
    3e94:	44b1                	li	s1,12
        if ((n = write(fd, buf, SZ)) != SZ) {
    3e96:	0000a997          	auipc	s3,0xa
    3e9a:	e5298993          	addi	s3,s3,-430 # dce8 <buf>
    3e9e:	1f400613          	li	a2,500
    3ea2:	85ce                	mv	a1,s3
    3ea4:	854a                	mv	a0,s2
    3ea6:	38e010ef          	jal	5234 <write>
    3eaa:	85aa                	mv	a1,a0
    3eac:	1f400793          	li	a5,500
    3eb0:	02f51163          	bne	a0,a5,3ed2 <fourfiles+0x11a>
      for (i = 0; i < N; i++) {
    3eb4:	34fd                	addiw	s1,s1,-1
    3eb6:	f4e5                	bnez	s1,3e9e <fourfiles+0xe6>
      exit(0);
    3eb8:	4501                	li	a0,0
    3eba:	35a010ef          	jal	5214 <exit>
        printf("%s: create failed\n", s);
    3ebe:	85e6                	mv	a1,s9
    3ec0:	00002517          	auipc	a0,0x2
    3ec4:	36850513          	addi	a0,a0,872 # 6228 <malloc+0xb30>
    3ec8:	77c010ef          	jal	5644 <printf>
        exit(1);
    3ecc:	4505                	li	a0,1
    3ece:	346010ef          	jal	5214 <exit>
          printf("write failed %d\n", n);
    3ed2:	00003517          	auipc	a0,0x3
    3ed6:	6b650513          	addi	a0,a0,1718 # 7588 <malloc+0x1e90>
    3eda:	76a010ef          	jal	5644 <printf>
          exit(1);
    3ede:	4505                	li	a0,1
    3ee0:	334010ef          	jal	5214 <exit>
      exit(xstatus);
    3ee4:	8556                	mv	a0,s5
    3ee6:	32e010ef          	jal	5214 <exit>
          printf("%s: wrong char\n", s);
    3eea:	85e6                	mv	a1,s9
    3eec:	00003517          	auipc	a0,0x3
    3ef0:	6b450513          	addi	a0,a0,1716 # 75a0 <malloc+0x1ea8>
    3ef4:	750010ef          	jal	5644 <printf>
          exit(1);
    3ef8:	4505                	li	a0,1
    3efa:	31a010ef          	jal	5214 <exit>
      total += n;
    3efe:	00a9093b          	addw	s2,s2,a0
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3f02:	660d                	lui	a2,0x3
    3f04:	85d2                	mv	a1,s4
    3f06:	854e                	mv	a0,s3
    3f08:	324010ef          	jal	522c <read>
    3f0c:	02a05063          	blez	a0,3f2c <fourfiles+0x174>
    3f10:	0000a797          	auipc	a5,0xa
    3f14:	dd878793          	addi	a5,a5,-552 # dce8 <buf>
    3f18:	00f506b3          	add	a3,a0,a5
        if (buf[j] != '0' + i) {
    3f1c:	0007c703          	lbu	a4,0(a5)
    3f20:	fc9715e3          	bne	a4,s1,3eea <fourfiles+0x132>
      for (j = 0; j < n; j++) {
    3f24:	0785                	addi	a5,a5,1
    3f26:	fed79be3          	bne	a5,a3,3f1c <fourfiles+0x164>
    3f2a:	bfd1                	j	3efe <fourfiles+0x146>
    close(fd);
    3f2c:	854e                	mv	a0,s3
    3f2e:	30e010ef          	jal	523c <close>
    if (total != N * SZ) {
    3f32:	03a91463          	bne	s2,s10,3f5a <fourfiles+0x1a2>
    unlink(fname);
    3f36:	8562                	mv	a0,s8
    3f38:	32c010ef          	jal	5264 <unlink>
  for (i = 0; i < NCHILD; i++) {
    3f3c:	0ba1                	addi	s7,s7,8
    3f3e:	2b05                	addiw	s6,s6,1
    3f40:	03bb0763          	beq	s6,s11,3f6e <fourfiles+0x1b6>
    fname = names[i];
    3f44:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    3f48:	4581                	li	a1,0
    3f4a:	8562                	mv	a0,s8
    3f4c:	308010ef          	jal	5254 <open>
    3f50:	89aa                	mv	s3,a0
    total = 0;
    3f52:	8956                	mv	s2,s5
        if (buf[j] != '0' + i) {
    3f54:	000b049b          	sext.w	s1,s6
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    3f58:	b76d                	j	3f02 <fourfiles+0x14a>
      printf("wrong length %d\n", total);
    3f5a:	85ca                	mv	a1,s2
    3f5c:	00003517          	auipc	a0,0x3
    3f60:	65450513          	addi	a0,a0,1620 # 75b0 <malloc+0x1eb8>
    3f64:	6e0010ef          	jal	5644 <printf>
      exit(1);
    3f68:	4505                	li	a0,1
    3f6a:	2aa010ef          	jal	5214 <exit>
}
    3f6e:	60ea                	ld	ra,152(sp)
    3f70:	644a                	ld	s0,144(sp)
    3f72:	64aa                	ld	s1,136(sp)
    3f74:	690a                	ld	s2,128(sp)
    3f76:	79e6                	ld	s3,120(sp)
    3f78:	7a46                	ld	s4,112(sp)
    3f7a:	7aa6                	ld	s5,104(sp)
    3f7c:	7b06                	ld	s6,96(sp)
    3f7e:	6be6                	ld	s7,88(sp)
    3f80:	6c46                	ld	s8,80(sp)
    3f82:	6ca6                	ld	s9,72(sp)
    3f84:	6d06                	ld	s10,64(sp)
    3f86:	7de2                	ld	s11,56(sp)
    3f88:	610d                	addi	sp,sp,160
    3f8a:	8082                	ret

0000000000003f8c <concreate>:
{
    3f8c:	7135                	addi	sp,sp,-160
    3f8e:	ed06                	sd	ra,152(sp)
    3f90:	e922                	sd	s0,144(sp)
    3f92:	e526                	sd	s1,136(sp)
    3f94:	e14a                	sd	s2,128(sp)
    3f96:	fcce                	sd	s3,120(sp)
    3f98:	f8d2                	sd	s4,112(sp)
    3f9a:	f4d6                	sd	s5,104(sp)
    3f9c:	f0da                	sd	s6,96(sp)
    3f9e:	ecde                	sd	s7,88(sp)
    3fa0:	1100                	addi	s0,sp,160
    3fa2:	89aa                	mv	s3,a0
  file[0] = 'C';
    3fa4:	04300793          	li	a5,67
    3fa8:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    3fac:	fa040523          	sb	zero,-86(s0)
  for (i = 0; i < N; i++) {
    3fb0:	4901                	li	s2,0
    if (pid && (i % 3) == 1) {
    3fb2:	4b0d                	li	s6,3
    3fb4:	4a85                	li	s5,1
      link("C0", file);
    3fb6:	00003b97          	auipc	s7,0x3
    3fba:	612b8b93          	addi	s7,s7,1554 # 75c8 <malloc+0x1ed0>
  for (i = 0; i < N; i++) {
    3fbe:	02800a13          	li	s4,40
    3fc2:	a41d                	j	41e8 <concreate+0x25c>
      link("C0", file);
    3fc4:	fa840593          	addi	a1,s0,-88
    3fc8:	855e                	mv	a0,s7
    3fca:	2aa010ef          	jal	5274 <link>
    if (pid == 0) {
    3fce:	a411                	j	41d2 <concreate+0x246>
    } else if (pid == 0 && (i % 5) == 1) {
    3fd0:	4795                	li	a5,5
    3fd2:	02f9693b          	remw	s2,s2,a5
    3fd6:	4785                	li	a5,1
    3fd8:	02f90563          	beq	s2,a5,4002 <concreate+0x76>
      fd = open(file, O_CREATE | O_RDWR);
    3fdc:	20200593          	li	a1,514
    3fe0:	fa840513          	addi	a0,s0,-88
    3fe4:	270010ef          	jal	5254 <open>
      if (fd < 0) {
    3fe8:	1e055063          	bgez	a0,41c8 <concreate+0x23c>
        printf("concreate create %s failed\n", file);
    3fec:	fa840593          	addi	a1,s0,-88
    3ff0:	00003517          	auipc	a0,0x3
    3ff4:	5e050513          	addi	a0,a0,1504 # 75d0 <malloc+0x1ed8>
    3ff8:	64c010ef          	jal	5644 <printf>
        exit(1);
    3ffc:	4505                	li	a0,1
    3ffe:	216010ef          	jal	5214 <exit>
      link("C0", file);
    4002:	fa840593          	addi	a1,s0,-88
    4006:	00003517          	auipc	a0,0x3
    400a:	5c250513          	addi	a0,a0,1474 # 75c8 <malloc+0x1ed0>
    400e:	266010ef          	jal	5274 <link>
      exit(0);
    4012:	4501                	li	a0,0
    4014:	200010ef          	jal	5214 <exit>
        exit(1);
    4018:	4505                	li	a0,1
    401a:	1fa010ef          	jal	5214 <exit>
  memset(fa, 0, sizeof(fa));
    401e:	02800613          	li	a2,40
    4022:	4581                	li	a1,0
    4024:	f8040513          	addi	a0,s0,-128
    4028:	7db000ef          	jal	5002 <memset>
  fd = open(".", 0);
    402c:	4581                	li	a1,0
    402e:	00002517          	auipc	a0,0x2
    4032:	ee250513          	addi	a0,a0,-286 # 5f10 <malloc+0x818>
    4036:	21e010ef          	jal	5254 <open>
    403a:	892a                	mv	s2,a0
  n = 0;
    403c:	8aa6                	mv	s5,s1
    if (de.name[0] == 'C' && de.name[2] == '\0') {
    403e:	04300a13          	li	s4,67
      if (i < 0 || i >= sizeof(fa)) {
    4042:	02700b13          	li	s6,39
      fa[i] = 1;
    4046:	4b85                	li	s7,1
  while (read(fd, &de, sizeof(de)) > 0) {
    4048:	4641                	li	a2,16
    404a:	f7040593          	addi	a1,s0,-144
    404e:	854a                	mv	a0,s2
    4050:	1dc010ef          	jal	522c <read>
    4054:	06a05a63          	blez	a0,40c8 <concreate+0x13c>
    if (de.inum == 0)
    4058:	f7045783          	lhu	a5,-144(s0)
    405c:	d7f5                	beqz	a5,4048 <concreate+0xbc>
    if (de.name[0] == 'C' && de.name[2] == '\0') {
    405e:	f7244783          	lbu	a5,-142(s0)
    4062:	ff4793e3          	bne	a5,s4,4048 <concreate+0xbc>
    4066:	f7444783          	lbu	a5,-140(s0)
    406a:	fff9                	bnez	a5,4048 <concreate+0xbc>
      i = de.name[1] - '0';
    406c:	f7344783          	lbu	a5,-141(s0)
    4070:	fd07879b          	addiw	a5,a5,-48
    4074:	0007871b          	sext.w	a4,a5
      if (i < 0 || i >= sizeof(fa)) {
    4078:	02eb6063          	bltu	s6,a4,4098 <concreate+0x10c>
      if (fa[i]) {
    407c:	fb070793          	addi	a5,a4,-80
    4080:	97a2                	add	a5,a5,s0
    4082:	fd07c783          	lbu	a5,-48(a5)
    4086:	e78d                	bnez	a5,40b0 <concreate+0x124>
      fa[i] = 1;
    4088:	fb070793          	addi	a5,a4,-80
    408c:	00878733          	add	a4,a5,s0
    4090:	fd770823          	sb	s7,-48(a4)
      n++;
    4094:	2a85                	addiw	s5,s5,1
    4096:	bf4d                	j	4048 <concreate+0xbc>
        printf("%s: concreate weird file %s\n", s, de.name);
    4098:	f7240613          	addi	a2,s0,-142
    409c:	85ce                	mv	a1,s3
    409e:	00003517          	auipc	a0,0x3
    40a2:	55250513          	addi	a0,a0,1362 # 75f0 <malloc+0x1ef8>
    40a6:	59e010ef          	jal	5644 <printf>
        exit(1);
    40aa:	4505                	li	a0,1
    40ac:	168010ef          	jal	5214 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    40b0:	f7240613          	addi	a2,s0,-142
    40b4:	85ce                	mv	a1,s3
    40b6:	00003517          	auipc	a0,0x3
    40ba:	55a50513          	addi	a0,a0,1370 # 7610 <malloc+0x1f18>
    40be:	586010ef          	jal	5644 <printf>
        exit(1);
    40c2:	4505                	li	a0,1
    40c4:	150010ef          	jal	5214 <exit>
  close(fd);
    40c8:	854a                	mv	a0,s2
    40ca:	172010ef          	jal	523c <close>
  if (n != N) {
    40ce:	02800793          	li	a5,40
    40d2:	00fa9763          	bne	s5,a5,40e0 <concreate+0x154>
    if (((i % 3) == 0 && pid == 0) || ((i % 3) == 1 && pid != 0)) {
    40d6:	4a8d                	li	s5,3
    40d8:	4b05                	li	s6,1
  for (i = 0; i < N; i++) {
    40da:	02800a13          	li	s4,40
    40de:	a079                	j	416c <concreate+0x1e0>
    printf("%s: concreate not enough files in directory listing\n", s);
    40e0:	85ce                	mv	a1,s3
    40e2:	00003517          	auipc	a0,0x3
    40e6:	55650513          	addi	a0,a0,1366 # 7638 <malloc+0x1f40>
    40ea:	55a010ef          	jal	5644 <printf>
    exit(1);
    40ee:	4505                	li	a0,1
    40f0:	124010ef          	jal	5214 <exit>
      printf("%s: fork failed\n", s);
    40f4:	85ce                	mv	a1,s3
    40f6:	00002517          	auipc	a0,0x2
    40fa:	fc250513          	addi	a0,a0,-62 # 60b8 <malloc+0x9c0>
    40fe:	546010ef          	jal	5644 <printf>
      exit(1);
    4102:	4505                	li	a0,1
    4104:	110010ef          	jal	5214 <exit>
      close(open(file, 0));
    4108:	4581                	li	a1,0
    410a:	fa840513          	addi	a0,s0,-88
    410e:	146010ef          	jal	5254 <open>
    4112:	12a010ef          	jal	523c <close>
      close(open(file, 0));
    4116:	4581                	li	a1,0
    4118:	fa840513          	addi	a0,s0,-88
    411c:	138010ef          	jal	5254 <open>
    4120:	11c010ef          	jal	523c <close>
      close(open(file, 0));
    4124:	4581                	li	a1,0
    4126:	fa840513          	addi	a0,s0,-88
    412a:	12a010ef          	jal	5254 <open>
    412e:	10e010ef          	jal	523c <close>
      close(open(file, 0));
    4132:	4581                	li	a1,0
    4134:	fa840513          	addi	a0,s0,-88
    4138:	11c010ef          	jal	5254 <open>
    413c:	100010ef          	jal	523c <close>
      close(open(file, 0));
    4140:	4581                	li	a1,0
    4142:	fa840513          	addi	a0,s0,-88
    4146:	10e010ef          	jal	5254 <open>
    414a:	0f2010ef          	jal	523c <close>
      close(open(file, 0));
    414e:	4581                	li	a1,0
    4150:	fa840513          	addi	a0,s0,-88
    4154:	100010ef          	jal	5254 <open>
    4158:	0e4010ef          	jal	523c <close>
    if (pid == 0)
    415c:	06090363          	beqz	s2,41c2 <concreate+0x236>
      wait(0);
    4160:	4501                	li	a0,0
    4162:	0ba010ef          	jal	521c <wait>
  for (i = 0; i < N; i++) {
    4166:	2485                	addiw	s1,s1,1
    4168:	0b448963          	beq	s1,s4,421a <concreate+0x28e>
    file[1] = '0' + i;
    416c:	0304879b          	addiw	a5,s1,48
    4170:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    4174:	098010ef          	jal	520c <fork>
    4178:	892a                	mv	s2,a0
    if (pid < 0) {
    417a:	f6054de3          	bltz	a0,40f4 <concreate+0x168>
    if (((i % 3) == 0 && pid == 0) || ((i % 3) == 1 && pid != 0)) {
    417e:	0354e73b          	remw	a4,s1,s5
    4182:	00a767b3          	or	a5,a4,a0
    4186:	2781                	sext.w	a5,a5
    4188:	d3c1                	beqz	a5,4108 <concreate+0x17c>
    418a:	01671363          	bne	a4,s6,4190 <concreate+0x204>
    418e:	fd2d                	bnez	a0,4108 <concreate+0x17c>
      unlink(file);
    4190:	fa840513          	addi	a0,s0,-88
    4194:	0d0010ef          	jal	5264 <unlink>
      unlink(file);
    4198:	fa840513          	addi	a0,s0,-88
    419c:	0c8010ef          	jal	5264 <unlink>
      unlink(file);
    41a0:	fa840513          	addi	a0,s0,-88
    41a4:	0c0010ef          	jal	5264 <unlink>
      unlink(file);
    41a8:	fa840513          	addi	a0,s0,-88
    41ac:	0b8010ef          	jal	5264 <unlink>
      unlink(file);
    41b0:	fa840513          	addi	a0,s0,-88
    41b4:	0b0010ef          	jal	5264 <unlink>
      unlink(file);
    41b8:	fa840513          	addi	a0,s0,-88
    41bc:	0a8010ef          	jal	5264 <unlink>
    41c0:	bf71                	j	415c <concreate+0x1d0>
      exit(0);
    41c2:	4501                	li	a0,0
    41c4:	050010ef          	jal	5214 <exit>
      close(fd);
    41c8:	074010ef          	jal	523c <close>
    if (pid == 0) {
    41cc:	b599                	j	4012 <concreate+0x86>
      close(fd);
    41ce:	06e010ef          	jal	523c <close>
      wait(&xstatus);
    41d2:	f6c40513          	addi	a0,s0,-148
    41d6:	046010ef          	jal	521c <wait>
      if (xstatus != 0)
    41da:	f6c42483          	lw	s1,-148(s0)
    41de:	e2049de3          	bnez	s1,4018 <concreate+0x8c>
  for (i = 0; i < N; i++) {
    41e2:	2905                	addiw	s2,s2,1
    41e4:	e3490de3          	beq	s2,s4,401e <concreate+0x92>
    file[1] = '0' + i;
    41e8:	0309079b          	addiw	a5,s2,48
    41ec:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    41f0:	fa840513          	addi	a0,s0,-88
    41f4:	070010ef          	jal	5264 <unlink>
    pid = fork();
    41f8:	014010ef          	jal	520c <fork>
    if (pid && (i % 3) == 1) {
    41fc:	dc050ae3          	beqz	a0,3fd0 <concreate+0x44>
    4200:	036967bb          	remw	a5,s2,s6
    4204:	dd5780e3          	beq	a5,s5,3fc4 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    4208:	20200593          	li	a1,514
    420c:	fa840513          	addi	a0,s0,-88
    4210:	044010ef          	jal	5254 <open>
      if (fd < 0) {
    4214:	fa055de3          	bgez	a0,41ce <concreate+0x242>
    4218:	bbd1                	j	3fec <concreate+0x60>
}
    421a:	60ea                	ld	ra,152(sp)
    421c:	644a                	ld	s0,144(sp)
    421e:	64aa                	ld	s1,136(sp)
    4220:	690a                	ld	s2,128(sp)
    4222:	79e6                	ld	s3,120(sp)
    4224:	7a46                	ld	s4,112(sp)
    4226:	7aa6                	ld	s5,104(sp)
    4228:	7b06                	ld	s6,96(sp)
    422a:	6be6                	ld	s7,88(sp)
    422c:	610d                	addi	sp,sp,160
    422e:	8082                	ret

0000000000004230 <bigfile>:
{
    4230:	7139                	addi	sp,sp,-64
    4232:	fc06                	sd	ra,56(sp)
    4234:	f822                	sd	s0,48(sp)
    4236:	f426                	sd	s1,40(sp)
    4238:	f04a                	sd	s2,32(sp)
    423a:	ec4e                	sd	s3,24(sp)
    423c:	e852                	sd	s4,16(sp)
    423e:	e456                	sd	s5,8(sp)
    4240:	0080                	addi	s0,sp,64
    4242:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    4244:	00003517          	auipc	a0,0x3
    4248:	42c50513          	addi	a0,a0,1068 # 7670 <malloc+0x1f78>
    424c:	018010ef          	jal	5264 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4250:	20200593          	li	a1,514
    4254:	00003517          	auipc	a0,0x3
    4258:	41c50513          	addi	a0,a0,1052 # 7670 <malloc+0x1f78>
    425c:	7f9000ef          	jal	5254 <open>
    4260:	89aa                	mv	s3,a0
  for (i = 0; i < N; i++) {
    4262:	4481                	li	s1,0
    memset(buf, i, SZ);
    4264:	0000a917          	auipc	s2,0xa
    4268:	a8490913          	addi	s2,s2,-1404 # dce8 <buf>
  for (i = 0; i < N; i++) {
    426c:	4a51                	li	s4,20
  if (fd < 0) {
    426e:	08054663          	bltz	a0,42fa <bigfile+0xca>
    memset(buf, i, SZ);
    4272:	25800613          	li	a2,600
    4276:	85a6                	mv	a1,s1
    4278:	854a                	mv	a0,s2
    427a:	589000ef          	jal	5002 <memset>
    if (write(fd, buf, SZ) != SZ) {
    427e:	25800613          	li	a2,600
    4282:	85ca                	mv	a1,s2
    4284:	854e                	mv	a0,s3
    4286:	7af000ef          	jal	5234 <write>
    428a:	25800793          	li	a5,600
    428e:	08f51063          	bne	a0,a5,430e <bigfile+0xde>
  for (i = 0; i < N; i++) {
    4292:	2485                	addiw	s1,s1,1
    4294:	fd449fe3          	bne	s1,s4,4272 <bigfile+0x42>
  close(fd);
    4298:	854e                	mv	a0,s3
    429a:	7a3000ef          	jal	523c <close>
  fd = open("bigfile.dat", 0);
    429e:	4581                	li	a1,0
    42a0:	00003517          	auipc	a0,0x3
    42a4:	3d050513          	addi	a0,a0,976 # 7670 <malloc+0x1f78>
    42a8:	7ad000ef          	jal	5254 <open>
    42ac:	8a2a                	mv	s4,a0
  total = 0;
    42ae:	4981                	li	s3,0
  for (i = 0;; i++) {
    42b0:	4481                	li	s1,0
    cc = read(fd, buf, SZ / 2);
    42b2:	0000a917          	auipc	s2,0xa
    42b6:	a3690913          	addi	s2,s2,-1482 # dce8 <buf>
  if (fd < 0) {
    42ba:	06054463          	bltz	a0,4322 <bigfile+0xf2>
    cc = read(fd, buf, SZ / 2);
    42be:	12c00613          	li	a2,300
    42c2:	85ca                	mv	a1,s2
    42c4:	8552                	mv	a0,s4
    42c6:	767000ef          	jal	522c <read>
    if (cc < 0) {
    42ca:	06054663          	bltz	a0,4336 <bigfile+0x106>
    if (cc == 0)
    42ce:	c155                	beqz	a0,4372 <bigfile+0x142>
    if (cc != SZ / 2) {
    42d0:	12c00793          	li	a5,300
    42d4:	06f51b63          	bne	a0,a5,434a <bigfile+0x11a>
    if (buf[0] != i / 2 || buf[SZ / 2 - 1] != i / 2) {
    42d8:	01f4d79b          	srliw	a5,s1,0x1f
    42dc:	9fa5                	addw	a5,a5,s1
    42de:	4017d79b          	sraiw	a5,a5,0x1
    42e2:	00094703          	lbu	a4,0(s2)
    42e6:	06f71c63          	bne	a4,a5,435e <bigfile+0x12e>
    42ea:	12b94703          	lbu	a4,299(s2)
    42ee:	06f71863          	bne	a4,a5,435e <bigfile+0x12e>
    total += cc;
    42f2:	12c9899b          	addiw	s3,s3,300
  for (i = 0;; i++) {
    42f6:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ / 2);
    42f8:	b7d9                	j	42be <bigfile+0x8e>
    printf("%s: cannot create bigfile", s);
    42fa:	85d6                	mv	a1,s5
    42fc:	00003517          	auipc	a0,0x3
    4300:	38450513          	addi	a0,a0,900 # 7680 <malloc+0x1f88>
    4304:	340010ef          	jal	5644 <printf>
    exit(1);
    4308:	4505                	li	a0,1
    430a:	70b000ef          	jal	5214 <exit>
      printf("%s: write bigfile failed\n", s);
    430e:	85d6                	mv	a1,s5
    4310:	00003517          	auipc	a0,0x3
    4314:	39050513          	addi	a0,a0,912 # 76a0 <malloc+0x1fa8>
    4318:	32c010ef          	jal	5644 <printf>
      exit(1);
    431c:	4505                	li	a0,1
    431e:	6f7000ef          	jal	5214 <exit>
    printf("%s: cannot open bigfile\n", s);
    4322:	85d6                	mv	a1,s5
    4324:	00003517          	auipc	a0,0x3
    4328:	39c50513          	addi	a0,a0,924 # 76c0 <malloc+0x1fc8>
    432c:	318010ef          	jal	5644 <printf>
    exit(1);
    4330:	4505                	li	a0,1
    4332:	6e3000ef          	jal	5214 <exit>
      printf("%s: read bigfile failed\n", s);
    4336:	85d6                	mv	a1,s5
    4338:	00003517          	auipc	a0,0x3
    433c:	3a850513          	addi	a0,a0,936 # 76e0 <malloc+0x1fe8>
    4340:	304010ef          	jal	5644 <printf>
      exit(1);
    4344:	4505                	li	a0,1
    4346:	6cf000ef          	jal	5214 <exit>
      printf("%s: short read bigfile\n", s);
    434a:	85d6                	mv	a1,s5
    434c:	00003517          	auipc	a0,0x3
    4350:	3b450513          	addi	a0,a0,948 # 7700 <malloc+0x2008>
    4354:	2f0010ef          	jal	5644 <printf>
      exit(1);
    4358:	4505                	li	a0,1
    435a:	6bb000ef          	jal	5214 <exit>
      printf("%s: read bigfile wrong data\n", s);
    435e:	85d6                	mv	a1,s5
    4360:	00003517          	auipc	a0,0x3
    4364:	3b850513          	addi	a0,a0,952 # 7718 <malloc+0x2020>
    4368:	2dc010ef          	jal	5644 <printf>
      exit(1);
    436c:	4505                	li	a0,1
    436e:	6a7000ef          	jal	5214 <exit>
  close(fd);
    4372:	8552                	mv	a0,s4
    4374:	6c9000ef          	jal	523c <close>
  if (total != N * SZ) {
    4378:	678d                	lui	a5,0x3
    437a:	ee078793          	addi	a5,a5,-288 # 2ee0 <subdir+0x494>
    437e:	02f99163          	bne	s3,a5,43a0 <bigfile+0x170>
  unlink("bigfile.dat");
    4382:	00003517          	auipc	a0,0x3
    4386:	2ee50513          	addi	a0,a0,750 # 7670 <malloc+0x1f78>
    438a:	6db000ef          	jal	5264 <unlink>
}
    438e:	70e2                	ld	ra,56(sp)
    4390:	7442                	ld	s0,48(sp)
    4392:	74a2                	ld	s1,40(sp)
    4394:	7902                	ld	s2,32(sp)
    4396:	69e2                	ld	s3,24(sp)
    4398:	6a42                	ld	s4,16(sp)
    439a:	6aa2                	ld	s5,8(sp)
    439c:	6121                	addi	sp,sp,64
    439e:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    43a0:	85d6                	mv	a1,s5
    43a2:	00003517          	auipc	a0,0x3
    43a6:	39650513          	addi	a0,a0,918 # 7738 <malloc+0x2040>
    43aa:	29a010ef          	jal	5644 <printf>
    exit(1);
    43ae:	4505                	li	a0,1
    43b0:	665000ef          	jal	5214 <exit>

00000000000043b4 <bigargtest>:
{
    43b4:	7121                	addi	sp,sp,-448
    43b6:	ff06                	sd	ra,440(sp)
    43b8:	fb22                	sd	s0,432(sp)
    43ba:	f726                	sd	s1,424(sp)
    43bc:	0380                	addi	s0,sp,448
    43be:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    43c0:	00003517          	auipc	a0,0x3
    43c4:	39850513          	addi	a0,a0,920 # 7758 <malloc+0x2060>
    43c8:	69d000ef          	jal	5264 <unlink>
  pid = fork();
    43cc:	641000ef          	jal	520c <fork>
  if (pid == 0) {
    43d0:	c915                	beqz	a0,4404 <bigargtest+0x50>
  } else if (pid < 0) {
    43d2:	08054a63          	bltz	a0,4466 <bigargtest+0xb2>
  wait(&xstatus);
    43d6:	fdc40513          	addi	a0,s0,-36
    43da:	643000ef          	jal	521c <wait>
  if (xstatus != 0)
    43de:	fdc42503          	lw	a0,-36(s0)
    43e2:	ed41                	bnez	a0,447a <bigargtest+0xc6>
  fd = open("bigarg-ok", 0);
    43e4:	4581                	li	a1,0
    43e6:	00003517          	auipc	a0,0x3
    43ea:	37250513          	addi	a0,a0,882 # 7758 <malloc+0x2060>
    43ee:	667000ef          	jal	5254 <open>
  if (fd < 0) {
    43f2:	08054663          	bltz	a0,447e <bigargtest+0xca>
  close(fd);
    43f6:	647000ef          	jal	523c <close>
}
    43fa:	70fa                	ld	ra,440(sp)
    43fc:	745a                	ld	s0,432(sp)
    43fe:	74ba                	ld	s1,424(sp)
    4400:	6139                	addi	sp,sp,448
    4402:	8082                	ret
    memset(big, ' ', sizeof(big));
    4404:	19000613          	li	a2,400
    4408:	02000593          	li	a1,32
    440c:	e4840513          	addi	a0,s0,-440
    4410:	3f3000ef          	jal	5002 <memset>
    big[sizeof(big) - 1] = '\0';
    4414:	fc040ba3          	sb	zero,-41(s0)
    for (i = 0; i < MAXARG - 1; i++)
    4418:	00006797          	auipc	a5,0x6
    441c:	0b878793          	addi	a5,a5,184 # a4d0 <args.1>
    4420:	00006697          	auipc	a3,0x6
    4424:	1a868693          	addi	a3,a3,424 # a5c8 <args.1+0xf8>
      args[i] = big;
    4428:	e4840713          	addi	a4,s0,-440
    442c:	e398                	sd	a4,0(a5)
    for (i = 0; i < MAXARG - 1; i++)
    442e:	07a1                	addi	a5,a5,8
    4430:	fed79ee3          	bne	a5,a3,442c <bigargtest+0x78>
    args[MAXARG - 1] = 0;
    4434:	00006597          	auipc	a1,0x6
    4438:	09c58593          	addi	a1,a1,156 # a4d0 <args.1>
    443c:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    4440:	00001517          	auipc	a0,0x1
    4444:	3e850513          	addi	a0,a0,1000 # 5828 <malloc+0x130>
    4448:	605000ef          	jal	524c <exec>
    fd = open("bigarg-ok", O_CREATE);
    444c:	20000593          	li	a1,512
    4450:	00003517          	auipc	a0,0x3
    4454:	30850513          	addi	a0,a0,776 # 7758 <malloc+0x2060>
    4458:	5fd000ef          	jal	5254 <open>
    close(fd);
    445c:	5e1000ef          	jal	523c <close>
    exit(0);
    4460:	4501                	li	a0,0
    4462:	5b3000ef          	jal	5214 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    4466:	85a6                	mv	a1,s1
    4468:	00003517          	auipc	a0,0x3
    446c:	30050513          	addi	a0,a0,768 # 7768 <malloc+0x2070>
    4470:	1d4010ef          	jal	5644 <printf>
    exit(1);
    4474:	4505                	li	a0,1
    4476:	59f000ef          	jal	5214 <exit>
    exit(xstatus);
    447a:	59b000ef          	jal	5214 <exit>
    printf("%s: bigarg test failed!\n", s);
    447e:	85a6                	mv	a1,s1
    4480:	00003517          	auipc	a0,0x3
    4484:	30850513          	addi	a0,a0,776 # 7788 <malloc+0x2090>
    4488:	1bc010ef          	jal	5644 <printf>
    exit(1);
    448c:	4505                	li	a0,1
    448e:	587000ef          	jal	5214 <exit>

0000000000004492 <partial_write>:
{
    4492:	bc010113          	addi	sp,sp,-1088
    4496:	42113c23          	sd	ra,1080(sp)
    449a:	42813823          	sd	s0,1072(sp)
    449e:	42913423          	sd	s1,1064(sp)
    44a2:	43213023          	sd	s2,1056(sp)
    44a6:	41313c23          	sd	s3,1048(sp)
    44aa:	44010413          	addi	s0,sp,1088
    44ae:	89aa                	mv	s3,a0
  unlink("testfile");
    44b0:	00003517          	auipc	a0,0x3
    44b4:	2f850513          	addi	a0,a0,760 # 77a8 <malloc+0x20b0>
    44b8:	5ad000ef          	jal	5264 <unlink>
  int fd = open("testfile", O_CREATE | O_RDWR);
    44bc:	20200593          	li	a1,514
    44c0:	00003517          	auipc	a0,0x3
    44c4:	2e850513          	addi	a0,a0,744 # 77a8 <malloc+0x20b0>
    44c8:	58d000ef          	jal	5254 <open>
  if (fd < 0) {
    44cc:	14054c63          	bltz	a0,4624 <partial_write+0x192>
    44d0:	84aa                	mv	s1,a0
  int cc = write(fd, "A", 1);
    44d2:	4605                	li	a2,1
    44d4:	00003597          	auipc	a1,0x3
    44d8:	30458593          	addi	a1,a1,772 # 77d8 <malloc+0x20e0>
    44dc:	559000ef          	jal	5234 <write>
  if (cc != 1) {
    44e0:	4785                	li	a5,1
    44e2:	14f51b63          	bne	a0,a5,4638 <partial_write+0x1a6>
  close(fd);
    44e6:	8526                	mv	a0,s1
    44e8:	555000ef          	jal	523c <close>
  fd = open("testfile", O_RDWR);
    44ec:	4589                	li	a1,2
    44ee:	00003517          	auipc	a0,0x3
    44f2:	2ba50513          	addi	a0,a0,698 # 77a8 <malloc+0x20b0>
    44f6:	55f000ef          	jal	5254 <open>
    44fa:	892a                	mv	s2,a0
  if (fd < 0) {
    44fc:	14054863          	bltz	a0,464c <partial_write+0x1ba>
  char *p = sbrk(0);
    4500:	4501                	li	a0,0
    4502:	4df000ef          	jal	51e0 <sbrk>
  sbrk(PGSIZE - ((uint64)p % PGSIZE));
    4506:	6485                	lui	s1,0x1
    4508:	14fd                	addi	s1,s1,-1 # fff <pgbug+0x2b>
    450a:	009577b3          	and	a5,a0,s1
    450e:	6505                	lui	a0,0x1
    4510:	9d1d                	subw	a0,a0,a5
    4512:	4cf000ef          	jal	51e0 <sbrk>
  p = sbrk(0);
    4516:	4501                	li	a0,0
    4518:	4c9000ef          	jal	51e0 <sbrk>
  if ((uint64)p % PGSIZE != 0) {
    451c:	8ce9                	and	s1,s1,a0
    451e:	14049163          	bnez	s1,4660 <partial_write+0x1ce>
  p[-1] = 'X';
    4522:	05800793          	li	a5,88
    4526:	fef50fa3          	sb	a5,-1(a0) # fff <pgbug+0x2b>
  cc = write(fd, p - 1, 2);
    452a:	4609                	li	a2,2
    452c:	fff50593          	addi	a1,a0,-1
    4530:	854a                	mv	a0,s2
    4532:	503000ef          	jal	5234 <write>
  if (cc != -1) {
    4536:	57fd                	li	a5,-1
    4538:	12f51e63          	bne	a0,a5,4674 <partial_write+0x1e2>
  close(fd);
    453c:	854a                	mv	a0,s2
    453e:	4ff000ef          	jal	523c <close>
  fd = open("testfile", O_RDONLY);
    4542:	4581                	li	a1,0
    4544:	00003517          	auipc	a0,0x3
    4548:	26450513          	addi	a0,a0,612 # 77a8 <malloc+0x20b0>
    454c:	509000ef          	jal	5254 <open>
    4550:	84aa                	mv	s1,a0
  if (fd < 0) {
    4552:	12054b63          	bltz	a0,4688 <partial_write+0x1f6>
  cc = read(fd, &b, 1);
    4556:	4605                	li	a2,1
    4558:	fcf40593          	addi	a1,s0,-49
    455c:	4d1000ef          	jal	522c <read>
  if (cc != 1) {
    4560:	4785                	li	a5,1
    4562:	12f51d63          	bne	a0,a5,469c <partial_write+0x20a>
  close(fd);
    4566:	8526                	mv	a0,s1
    4568:	4d5000ef          	jal	523c <close>
  if (b != 'X') {
    456c:	fcf44603          	lbu	a2,-49(s0)
    4570:	05800793          	li	a5,88
    4574:	12f61e63          	bne	a2,a5,46b0 <partial_write+0x21e>
  fd = open("bigfile", O_CREATE | O_RDWR);
    4578:	20200593          	li	a1,514
    457c:	00003517          	auipc	a0,0x3
    4580:	32c50513          	addi	a0,a0,812 # 78a8 <malloc+0x21b0>
    4584:	4d1000ef          	jal	5254 <open>
    4588:	892a                	mv	s2,a0
    458a:	04000493          	li	s1,64
    memset(buf, 0, sizeof(buf));
    458e:	40000613          	li	a2,1024
    4592:	4581                	li	a1,0
    4594:	bc840513          	addi	a0,s0,-1080
    4598:	26b000ef          	jal	5002 <memset>
    cc = write(fd, buf, sizeof(buf));
    459c:	40000613          	li	a2,1024
    45a0:	bc840593          	addi	a1,s0,-1080
    45a4:	854a                	mv	a0,s2
    45a6:	48f000ef          	jal	5234 <write>
    if (cc != sizeof(buf)) {
    45aa:	40000793          	li	a5,1024
    45ae:	10f51b63          	bne	a0,a5,46c4 <partial_write+0x232>
  for (int i = 0; i < 64; i++) {
    45b2:	34fd                	addiw	s1,s1,-1
    45b4:	fce9                	bnez	s1,458e <partial_write+0xfc>
  close(fd);
    45b6:	854a                	mv	a0,s2
    45b8:	485000ef          	jal	523c <close>
  unlink("bigfile");
    45bc:	00003517          	auipc	a0,0x3
    45c0:	2ec50513          	addi	a0,a0,748 # 78a8 <malloc+0x21b0>
    45c4:	4a1000ef          	jal	5264 <unlink>
  fd = open("testfile", O_RDONLY);
    45c8:	4581                	li	a1,0
    45ca:	00003517          	auipc	a0,0x3
    45ce:	1de50513          	addi	a0,a0,478 # 77a8 <malloc+0x20b0>
    45d2:	483000ef          	jal	5254 <open>
    45d6:	84aa                	mv	s1,a0
  if (fd < 0) {
    45d8:	10054063          	bltz	a0,46d8 <partial_write+0x246>
  cc = read(fd, &b, 1);
    45dc:	4605                	li	a2,1
    45de:	fcf40593          	addi	a1,s0,-49
    45e2:	44b000ef          	jal	522c <read>
  if (cc != 1) {
    45e6:	4785                	li	a5,1
    45e8:	10f51263          	bne	a0,a5,46ec <partial_write+0x25a>
  close(fd);
    45ec:	8526                	mv	a0,s1
    45ee:	44f000ef          	jal	523c <close>
  if (b != 'X') {
    45f2:	fcf44603          	lbu	a2,-49(s0)
    45f6:	05800793          	li	a5,88
    45fa:	10f61363          	bne	a2,a5,4700 <partial_write+0x26e>
  unlink("testfile");
    45fe:	00003517          	auipc	a0,0x3
    4602:	1aa50513          	addi	a0,a0,426 # 77a8 <malloc+0x20b0>
    4606:	45f000ef          	jal	5264 <unlink>
}
    460a:	43813083          	ld	ra,1080(sp)
    460e:	43013403          	ld	s0,1072(sp)
    4612:	42813483          	ld	s1,1064(sp)
    4616:	42013903          	ld	s2,1056(sp)
    461a:	41813983          	ld	s3,1048(sp)
    461e:	44010113          	addi	sp,sp,1088
    4622:	8082                	ret
    printf("%s: cannot create testfile\n", s);
    4624:	85ce                	mv	a1,s3
    4626:	00003517          	auipc	a0,0x3
    462a:	19250513          	addi	a0,a0,402 # 77b8 <malloc+0x20c0>
    462e:	016010ef          	jal	5644 <printf>
    exit(1);
    4632:	4505                	li	a0,1
    4634:	3e1000ef          	jal	5214 <exit>
    printf("%s: could not write A\n", s);
    4638:	85ce                	mv	a1,s3
    463a:	00003517          	auipc	a0,0x3
    463e:	1a650513          	addi	a0,a0,422 # 77e0 <malloc+0x20e8>
    4642:	002010ef          	jal	5644 <printf>
    exit(1);
    4646:	4505                	li	a0,1
    4648:	3cd000ef          	jal	5214 <exit>
    printf("%s: cannot re-open testfile\n", s);
    464c:	85ce                	mv	a1,s3
    464e:	00003517          	auipc	a0,0x3
    4652:	1aa50513          	addi	a0,a0,426 # 77f8 <malloc+0x2100>
    4656:	7ef000ef          	jal	5644 <printf>
    exit(1);
    465a:	4505                	li	a0,1
    465c:	3b9000ef          	jal	5214 <exit>
    printf("%s: sbrk did not align\n", s);
    4660:	85ce                	mv	a1,s3
    4662:	00003517          	auipc	a0,0x3
    4666:	1b650513          	addi	a0,a0,438 # 7818 <malloc+0x2120>
    466a:	7db000ef          	jal	5644 <printf>
    exit(1);
    466e:	4505                	li	a0,1
    4670:	3a5000ef          	jal	5214 <exit>
    printf("%s: write succeeded, should have failed\n", s);
    4674:	85ce                	mv	a1,s3
    4676:	00003517          	auipc	a0,0x3
    467a:	1ba50513          	addi	a0,a0,442 # 7830 <malloc+0x2138>
    467e:	7c7000ef          	jal	5644 <printf>
    exit(1);
    4682:	4505                	li	a0,1
    4684:	391000ef          	jal	5214 <exit>
    printf("%s: cannot re-open testfile\n", s);
    4688:	85ce                	mv	a1,s3
    468a:	00003517          	auipc	a0,0x3
    468e:	16e50513          	addi	a0,a0,366 # 77f8 <malloc+0x2100>
    4692:	7b3000ef          	jal	5644 <printf>
    exit(1);
    4696:	4505                	li	a0,1
    4698:	37d000ef          	jal	5214 <exit>
    printf("%s: cannot read testfile\n", s);
    469c:	85ce                	mv	a1,s3
    469e:	00003517          	auipc	a0,0x3
    46a2:	1c250513          	addi	a0,a0,450 # 7860 <malloc+0x2168>
    46a6:	79f000ef          	jal	5644 <printf>
    exit(1);
    46aa:	4505                	li	a0,1
    46ac:	369000ef          	jal	5214 <exit>
    printf("%s: read returned %c, expected X\n", s, b);
    46b0:	85ce                	mv	a1,s3
    46b2:	00003517          	auipc	a0,0x3
    46b6:	1ce50513          	addi	a0,a0,462 # 7880 <malloc+0x2188>
    46ba:	78b000ef          	jal	5644 <printf>
    exit(1);
    46be:	4505                	li	a0,1
    46c0:	355000ef          	jal	5214 <exit>
      printf("%s: could not write to bigfile\n", s);
    46c4:	85ce                	mv	a1,s3
    46c6:	00003517          	auipc	a0,0x3
    46ca:	1ea50513          	addi	a0,a0,490 # 78b0 <malloc+0x21b8>
    46ce:	777000ef          	jal	5644 <printf>
      exit(-1);
    46d2:	557d                	li	a0,-1
    46d4:	341000ef          	jal	5214 <exit>
    printf("%s: cannot re-open testfile\n", s);
    46d8:	85ce                	mv	a1,s3
    46da:	00003517          	auipc	a0,0x3
    46de:	11e50513          	addi	a0,a0,286 # 77f8 <malloc+0x2100>
    46e2:	763000ef          	jal	5644 <printf>
    exit(1);
    46e6:	4505                	li	a0,1
    46e8:	32d000ef          	jal	5214 <exit>
    printf("%s: cannot read testfile\n", s);
    46ec:	85ce                	mv	a1,s3
    46ee:	00003517          	auipc	a0,0x3
    46f2:	17250513          	addi	a0,a0,370 # 7860 <malloc+0x2168>
    46f6:	74f000ef          	jal	5644 <printf>
    exit(1);
    46fa:	4505                	li	a0,1
    46fc:	319000ef          	jal	5214 <exit>
    printf("%s: read returned %c, expected X\n", s, b);
    4700:	85ce                	mv	a1,s3
    4702:	00003517          	auipc	a0,0x3
    4706:	17e50513          	addi	a0,a0,382 # 7880 <malloc+0x2188>
    470a:	73b000ef          	jal	5644 <printf>
    exit(1);
    470e:	4505                	li	a0,1
    4710:	305000ef          	jal	5214 <exit>

0000000000004714 <lazy_alloc>:
{
    4714:	1141                	addi	sp,sp,-16
    4716:	e406                	sd	ra,8(sp)
    4718:	e022                	sd	s0,0(sp)
    471a:	0800                	addi	s0,sp,16
  prev_end = sbrklazy(REGION_SZ);
    471c:	40000537          	lui	a0,0x40000
    4720:	2d7000ef          	jal	51f6 <sbrklazy>
  if (prev_end == (char *)SBRK_ERROR) {
    4724:	57fd                	li	a5,-1
    4726:	02f50a63          	beq	a0,a5,475a <lazy_alloc+0x46>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    472a:	6605                	lui	a2,0x1
    472c:	962a                	add	a2,a2,a0
    472e:	400017b7          	lui	a5,0x40001
    4732:	00f50733          	add	a4,a0,a5
    4736:	87b2                	mv	a5,a2
    4738:	000406b7          	lui	a3,0x40
    *(char **)i = i;
    473c:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    473e:	97b6                	add	a5,a5,a3
    4740:	fee79ee3          	bne	a5,a4,473c <lazy_alloc+0x28>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    4744:	000406b7          	lui	a3,0x40
    if (*(char **)i != i) {
    4748:	621c                	ld	a5,0(a2)
    474a:	02c79163          	bne	a5,a2,476c <lazy_alloc+0x58>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    474e:	9636                	add	a2,a2,a3
    4750:	fee61ce3          	bne	a2,a4,4748 <lazy_alloc+0x34>
  exit(0);
    4754:	4501                	li	a0,0
    4756:	2bf000ef          	jal	5214 <exit>
    printf("sbrklazy() failed\n");
    475a:	00003517          	auipc	a0,0x3
    475e:	17650513          	addi	a0,a0,374 # 78d0 <malloc+0x21d8>
    4762:	6e3000ef          	jal	5644 <printf>
    exit(1);
    4766:	4505                	li	a0,1
    4768:	2ad000ef          	jal	5214 <exit>
      printf("failed to read value from memory\n");
    476c:	00003517          	auipc	a0,0x3
    4770:	17c50513          	addi	a0,a0,380 # 78e8 <malloc+0x21f0>
    4774:	6d1000ef          	jal	5644 <printf>
      exit(1);
    4778:	4505                	li	a0,1
    477a:	29b000ef          	jal	5214 <exit>

000000000000477e <lazy_unmap>:
{
    477e:	7139                	addi	sp,sp,-64
    4780:	fc06                	sd	ra,56(sp)
    4782:	f822                	sd	s0,48(sp)
    4784:	0080                	addi	s0,sp,64
  prev_end = sbrklazy(REGION_SZ);
    4786:	40000537          	lui	a0,0x40000
    478a:	26d000ef          	jal	51f6 <sbrklazy>
  if (prev_end == (char *)SBRK_ERROR) {
    478e:	57fd                	li	a5,-1
    4790:	04f50663          	beq	a0,a5,47dc <lazy_unmap+0x5e>
    4794:	f426                	sd	s1,40(sp)
    4796:	f04a                	sd	s2,32(sp)
    4798:	ec4e                	sd	s3,24(sp)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    479a:	6905                	lui	s2,0x1
    479c:	992a                	add	s2,s2,a0
    479e:	400017b7          	lui	a5,0x40001
    47a2:	00f504b3          	add	s1,a0,a5
    47a6:	87ca                	mv	a5,s2
    47a8:	01000737          	lui	a4,0x1000
    *(char **)i = i;
    47ac:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    47ae:	97ba                	add	a5,a5,a4
    47b0:	fe979ee3          	bne	a5,s1,47ac <lazy_unmap+0x2e>
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    47b4:	010009b7          	lui	s3,0x1000
    pid = fork();
    47b8:	255000ef          	jal	520c <fork>
    if (pid < 0) {
    47bc:	02054c63          	bltz	a0,47f4 <lazy_unmap+0x76>
    } else if (pid == 0) {
    47c0:	c139                	beqz	a0,4806 <lazy_unmap+0x88>
      wait(&status);
    47c2:	fcc40513          	addi	a0,s0,-52
    47c6:	257000ef          	jal	521c <wait>
      if (status == 0) {
    47ca:	fcc42783          	lw	a5,-52(s0)
    47ce:	c7a9                	beqz	a5,4818 <lazy_unmap+0x9a>
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    47d0:	994e                	add	s2,s2,s3
    47d2:	fe9913e3          	bne	s2,s1,47b8 <lazy_unmap+0x3a>
  exit(0);
    47d6:	4501                	li	a0,0
    47d8:	23d000ef          	jal	5214 <exit>
    47dc:	f426                	sd	s1,40(sp)
    47de:	f04a                	sd	s2,32(sp)
    47e0:	ec4e                	sd	s3,24(sp)
    printf("sbrklazy() failed\n");
    47e2:	00003517          	auipc	a0,0x3
    47e6:	0ee50513          	addi	a0,a0,238 # 78d0 <malloc+0x21d8>
    47ea:	65b000ef          	jal	5644 <printf>
    exit(1);
    47ee:	4505                	li	a0,1
    47f0:	225000ef          	jal	5214 <exit>
      printf("error forking\n");
    47f4:	00003517          	auipc	a0,0x3
    47f8:	11c50513          	addi	a0,a0,284 # 7910 <malloc+0x2218>
    47fc:	649000ef          	jal	5644 <printf>
      exit(1);
    4800:	4505                	li	a0,1
    4802:	213000ef          	jal	5214 <exit>
      sbrklazy(-1L * REGION_SZ);
    4806:	c0000537          	lui	a0,0xc0000
    480a:	1ed000ef          	jal	51f6 <sbrklazy>
      *(char **)i = i;
    480e:	01293023          	sd	s2,0(s2) # 1000 <badarg>
      exit(0);
    4812:	4501                	li	a0,0
    4814:	201000ef          	jal	5214 <exit>
        printf("memory not unmapped\n");
    4818:	00003517          	auipc	a0,0x3
    481c:	10850513          	addi	a0,a0,264 # 7920 <malloc+0x2228>
    4820:	625000ef          	jal	5644 <printf>
        exit(1);
    4824:	4505                	li	a0,1
    4826:	1ef000ef          	jal	5214 <exit>

000000000000482a <lazy_copy>:
{
    482a:	7159                	addi	sp,sp,-112
    482c:	f486                	sd	ra,104(sp)
    482e:	f0a2                	sd	s0,96(sp)
    4830:	eca6                	sd	s1,88(sp)
    4832:	e8ca                	sd	s2,80(sp)
    4834:	e4ce                	sd	s3,72(sp)
    4836:	e0d2                	sd	s4,64(sp)
    4838:	fc56                	sd	s5,56(sp)
    483a:	f85a                	sd	s6,48(sp)
    483c:	1880                	addi	s0,sp,112
    char *p = sbrk(0);
    483e:	4501                	li	a0,0
    4840:	1a1000ef          	jal	51e0 <sbrk>
    4844:	84aa                	mv	s1,a0
    sbrklazy(4 * PGSIZE);
    4846:	6511                	lui	a0,0x4
    4848:	1af000ef          	jal	51f6 <sbrklazy>
    open(p + 8192, 0);
    484c:	4581                	li	a1,0
    484e:	6509                	lui	a0,0x2
    4850:	9526                	add	a0,a0,s1
    4852:	203000ef          	jal	5254 <open>
    void *xx = sbrk(0);
    4856:	4501                	li	a0,0
    4858:	189000ef          	jal	51e0 <sbrk>
    485c:	84aa                	mv	s1,a0
    void *ret = sbrk(-(((uint64)xx) + 1));
    485e:	fff54513          	not	a0,a0
    4862:	2501                	sext.w	a0,a0
    4864:	17d000ef          	jal	51e0 <sbrk>
    if (ret != xx) {
    4868:	00a48c63          	beq	s1,a0,4880 <lazy_copy+0x56>
    486c:	85aa                	mv	a1,a0
      printf("sbrk(sbrk(0)+1) returned %p, not old sz\n", ret);
    486e:	00003517          	auipc	a0,0x3
    4872:	0ca50513          	addi	a0,a0,202 # 7938 <malloc+0x2240>
    4876:	5cf000ef          	jal	5644 <printf>
      exit(1);
    487a:	4505                	li	a0,1
    487c:	199000ef          	jal	5214 <exit>
  unsigned long bad[] = {
    4880:	00003797          	auipc	a5,0x3
    4884:	7a878793          	addi	a5,a5,1960 # 8028 <malloc+0x2930>
    4888:	7fa8                	ld	a0,120(a5)
    488a:	63cc                	ld	a1,128(a5)
    488c:	67d0                	ld	a2,136(a5)
    488e:	6bd4                	ld	a3,144(a5)
    4890:	6fd8                	ld	a4,152(a5)
    4892:	73dc                	ld	a5,160(a5)
    4894:	f8a43823          	sd	a0,-112(s0)
    4898:	f8b43c23          	sd	a1,-104(s0)
    489c:	fac43023          	sd	a2,-96(s0)
    48a0:	fad43423          	sd	a3,-88(s0)
    48a4:	fae43823          	sd	a4,-80(s0)
    48a8:	faf43c23          	sd	a5,-72(s0)
  for (int i = 0; i < sizeof(bad) / sizeof(bad[0]); i++) {
    48ac:	f9040913          	addi	s2,s0,-112
    48b0:	fc040b13          	addi	s6,s0,-64
    int fd = open("README", 0);
    48b4:	00001a17          	auipc	s4,0x1
    48b8:	14ca0a13          	addi	s4,s4,332 # 5a00 <malloc+0x308>
    fd = open("junk", O_CREATE | O_RDWR | O_TRUNC);
    48bc:	00001a97          	auipc	s5,0x1
    48c0:	054a8a93          	addi	s5,s5,84 # 5910 <malloc+0x218>
    int fd = open("README", 0);
    48c4:	4581                	li	a1,0
    48c6:	8552                	mv	a0,s4
    48c8:	18d000ef          	jal	5254 <open>
    48cc:	84aa                	mv	s1,a0
    if (fd < 0) {
    48ce:	04054663          	bltz	a0,491a <lazy_copy+0xf0>
    if (read(fd, (char *)bad[i], 512) >= 0) {
    48d2:	00093983          	ld	s3,0(s2)
    48d6:	20000613          	li	a2,512
    48da:	85ce                	mv	a1,s3
    48dc:	151000ef          	jal	522c <read>
    48e0:	04055663          	bgez	a0,492c <lazy_copy+0x102>
    close(fd);
    48e4:	8526                	mv	a0,s1
    48e6:	157000ef          	jal	523c <close>
    fd = open("junk", O_CREATE | O_RDWR | O_TRUNC);
    48ea:	60200593          	li	a1,1538
    48ee:	8556                	mv	a0,s5
    48f0:	165000ef          	jal	5254 <open>
    48f4:	84aa                	mv	s1,a0
    if (fd < 0) {
    48f6:	04054463          	bltz	a0,493e <lazy_copy+0x114>
    if (write(fd, (char *)bad[i], 512) >= 0) {
    48fa:	20000613          	li	a2,512
    48fe:	85ce                	mv	a1,s3
    4900:	135000ef          	jal	5234 <write>
    4904:	04055663          	bgez	a0,4950 <lazy_copy+0x126>
    close(fd);
    4908:	8526                	mv	a0,s1
    490a:	133000ef          	jal	523c <close>
  for (int i = 0; i < sizeof(bad) / sizeof(bad[0]); i++) {
    490e:	0921                	addi	s2,s2,8
    4910:	fb691ae3          	bne	s2,s6,48c4 <lazy_copy+0x9a>
  exit(0);
    4914:	4501                	li	a0,0
    4916:	0ff000ef          	jal	5214 <exit>
      printf("cannot open README\n");
    491a:	00003517          	auipc	a0,0x3
    491e:	04e50513          	addi	a0,a0,78 # 7968 <malloc+0x2270>
    4922:	523000ef          	jal	5644 <printf>
      exit(1);
    4926:	4505                	li	a0,1
    4928:	0ed000ef          	jal	5214 <exit>
      printf("read succeeded\n");
    492c:	00003517          	auipc	a0,0x3
    4930:	05450513          	addi	a0,a0,84 # 7980 <malloc+0x2288>
    4934:	511000ef          	jal	5644 <printf>
      exit(1);
    4938:	4505                	li	a0,1
    493a:	0db000ef          	jal	5214 <exit>
      printf("cannot open junk\n");
    493e:	00003517          	auipc	a0,0x3
    4942:	05250513          	addi	a0,a0,82 # 7990 <malloc+0x2298>
    4946:	4ff000ef          	jal	5644 <printf>
      exit(1);
    494a:	4505                	li	a0,1
    494c:	0c9000ef          	jal	5214 <exit>
      printf("write succeeded\n");
    4950:	00003517          	auipc	a0,0x3
    4954:	05850513          	addi	a0,a0,88 # 79a8 <malloc+0x22b0>
    4958:	4ed000ef          	jal	5644 <printf>
      exit(1);
    495c:	4505                	li	a0,1
    495e:	0b7000ef          	jal	5214 <exit>

0000000000004962 <lazy_sbrk>:
{
    4962:	1101                	addi	sp,sp,-32
    4964:	ec06                	sd	ra,24(sp)
    4966:	e822                	sd	s0,16(sp)
    4968:	e426                	sd	s1,8(sp)
    496a:	e04a                	sd	s2,0(sp)
    496c:	1000                	addi	s0,sp,32
  char *p = sbrk(0);
    496e:	4501                	li	a0,0
    4970:	071000ef          	jal	51e0 <sbrk>
    4974:	84aa                	mv	s1,a0
  while ((uint64)p < MAXVA - (1 << 30)) {
    4976:	0ff00793          	li	a5,255
    497a:	07fa                	slli	a5,a5,0x1e
    497c:	00f57d63          	bgeu	a0,a5,4996 <lazy_sbrk+0x34>
    4980:	893e                	mv	s2,a5
    p = sbrklazy(1 << 30);
    4982:	40000537          	lui	a0,0x40000
    4986:	071000ef          	jal	51f6 <sbrklazy>
    p = sbrklazy(0);
    498a:	4501                	li	a0,0
    498c:	06b000ef          	jal	51f6 <sbrklazy>
    4990:	84aa                	mv	s1,a0
  while ((uint64)p < MAXVA - (1 << 30)) {
    4992:	ff2568e3          	bltu	a0,s2,4982 <lazy_sbrk+0x20>
  int n = TRAPFRAME - PGSIZE - (uint64)p;
    4996:	7975                	lui	s2,0xffffd
    4998:	4099093b          	subw	s2,s2,s1
  char *p1 = sbrklazy(n);
    499c:	854a                	mv	a0,s2
    499e:	059000ef          	jal	51f6 <sbrklazy>
    49a2:	862a                	mv	a2,a0
  if (p1 < 0 || p1 != p) {
    49a4:	00950d63          	beq	a0,s1,49be <lazy_sbrk+0x5c>
    printf("sbrklazy(%d) returned %p, not expected %p\n", n, p1, p);
    49a8:	86a6                	mv	a3,s1
    49aa:	85ca                	mv	a1,s2
    49ac:	00003517          	auipc	a0,0x3
    49b0:	01450513          	addi	a0,a0,20 # 79c0 <malloc+0x22c8>
    49b4:	491000ef          	jal	5644 <printf>
    exit(1);
    49b8:	4505                	li	a0,1
    49ba:	05b000ef          	jal	5214 <exit>
  p = sbrk(PGSIZE);
    49be:	6505                	lui	a0,0x1
    49c0:	021000ef          	jal	51e0 <sbrk>
    49c4:	862a                	mv	a2,a0
  if (p < 0 || (uint64)p != TRAPFRAME - PGSIZE) {
    49c6:	040007b7          	lui	a5,0x4000
    49ca:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3fef315>
    49cc:	07b2                	slli	a5,a5,0xc
    49ce:	00f50c63          	beq	a0,a5,49e6 <lazy_sbrk+0x84>
    printf("sbrk(%d) returned %p, not expected TRAPFRAME-PGSIZE\n", PGSIZE, p);
    49d2:	6585                	lui	a1,0x1
    49d4:	00003517          	auipc	a0,0x3
    49d8:	01c50513          	addi	a0,a0,28 # 79f0 <malloc+0x22f8>
    49dc:	469000ef          	jal	5644 <printf>
    exit(1);
    49e0:	4505                	li	a0,1
    49e2:	033000ef          	jal	5214 <exit>
  p[0] = 1;
    49e6:	040007b7          	lui	a5,0x4000
    49ea:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3fef315>
    49ec:	07b2                	slli	a5,a5,0xc
    49ee:	4705                	li	a4,1
    49f0:	00e78023          	sb	a4,0(a5)
  if (p[1] != 0) {
    49f4:	0017c783          	lbu	a5,1(a5)
    49f8:	cb91                	beqz	a5,4a0c <lazy_sbrk+0xaa>
    printf("sbrk() returned non-zero-filled memory\n");
    49fa:	00003517          	auipc	a0,0x3
    49fe:	02e50513          	addi	a0,a0,46 # 7a28 <malloc+0x2330>
    4a02:	443000ef          	jal	5644 <printf>
    exit(1);
    4a06:	4505                	li	a0,1
    4a08:	00d000ef          	jal	5214 <exit>
  p = sbrk(1);
    4a0c:	4505                	li	a0,1
    4a0e:	7d2000ef          	jal	51e0 <sbrk>
    4a12:	85aa                	mv	a1,a0
  if ((uint64)p != -1) {
    4a14:	57fd                	li	a5,-1
    4a16:	00f50b63          	beq	a0,a5,4a2c <lazy_sbrk+0xca>
    printf("sbrk(1) returned %p, expected error\n", p);
    4a1a:	00003517          	auipc	a0,0x3
    4a1e:	03650513          	addi	a0,a0,54 # 7a50 <malloc+0x2358>
    4a22:	423000ef          	jal	5644 <printf>
    exit(1);
    4a26:	4505                	li	a0,1
    4a28:	7ec000ef          	jal	5214 <exit>
  p = sbrklazy(1);
    4a2c:	4505                	li	a0,1
    4a2e:	7c8000ef          	jal	51f6 <sbrklazy>
    4a32:	85aa                	mv	a1,a0
  if ((uint64)p != -1) {
    4a34:	57fd                	li	a5,-1
    4a36:	00f50b63          	beq	a0,a5,4a4c <lazy_sbrk+0xea>
    printf("sbrklazy(1) returned %p, expected error\n", p);
    4a3a:	00003517          	auipc	a0,0x3
    4a3e:	03e50513          	addi	a0,a0,62 # 7a78 <malloc+0x2380>
    4a42:	403000ef          	jal	5644 <printf>
    exit(1);
    4a46:	4505                	li	a0,1
    4a48:	7cc000ef          	jal	5214 <exit>
  exit(0);
    4a4c:	4501                	li	a0,0
    4a4e:	7c6000ef          	jal	5214 <exit>

0000000000004a52 <lazy_copyinstr>:
{
    4a52:	715d                	addi	sp,sp,-80
    4a54:	e486                	sd	ra,72(sp)
    4a56:	e0a2                	sd	s0,64(sp)
    4a58:	fc26                	sd	s1,56(sp)
    4a5a:	f84a                	sd	s2,48(sp)
    4a5c:	f44e                	sd	s3,40(sp)
    4a5e:	0880                	addi	s0,sp,80
    4a60:	89aa                	mv	s3,a0
  char *p = sbrk(0);
    4a62:	4501                	li	a0,0
    4a64:	77c000ef          	jal	51e0 <sbrk>
  sbrk(PGSIZE - ((uint64)p % PGSIZE));
    4a68:	6485                	lui	s1,0x1
    4a6a:	14fd                	addi	s1,s1,-1 # fff <pgbug+0x2b>
    4a6c:	009577b3          	and	a5,a0,s1
    4a70:	6505                	lui	a0,0x1
    4a72:	9d1d                	subw	a0,a0,a5
    4a74:	76c000ef          	jal	51e0 <sbrk>
  p = sbrk(0);
    4a78:	4501                	li	a0,0
    4a7a:	766000ef          	jal	51e0 <sbrk>
  if ((uint64)p % PGSIZE != 0) {
    4a7e:	8ce9                	and	s1,s1,a0
    4a80:	e8a9                	bnez	s1,4ad2 <lazy_copyinstr+0x80>
    4a82:	892a                	mv	s2,a0
  sbrklazy(2 * PGSIZE);
    4a84:	6509                	lui	a0,0x2
    4a86:	770000ef          	jal	51f6 <sbrklazy>
  p[4095] = '/';
    4a8a:	6505                	lui	a0,0x1
    4a8c:	00a907b3          	add	a5,s2,a0
    4a90:	02f00713          	li	a4,47
    4a94:	fee78fa3          	sb	a4,-1(a5)
  int fd = open(&p[4095], O_RDONLY);
    4a98:	157d                	addi	a0,a0,-1 # fff <pgbug+0x2b>
    4a9a:	4581                	li	a1,0
    4a9c:	954a                	add	a0,a0,s2
    4a9e:	7b6000ef          	jal	5254 <open>
    4aa2:	84aa                	mv	s1,a0
  if (fd < 0) {
    4aa4:	04054163          	bltz	a0,4ae6 <lazy_copyinstr+0x94>
  int r = fstat(fd, &st);
    4aa8:	fb840593          	addi	a1,s0,-72
    4aac:	7c0000ef          	jal	526c <fstat>
  if (r < 0) {
    4ab0:	04054463          	bltz	a0,4af8 <lazy_copyinstr+0xa6>
  if (st.type != T_DIR) {
    4ab4:	fc041703          	lh	a4,-64(s0)
    4ab8:	4785                	li	a5,1
    4aba:	04f71863          	bne	a4,a5,4b0a <lazy_copyinstr+0xb8>
  close(fd);
    4abe:	8526                	mv	a0,s1
    4ac0:	77c000ef          	jal	523c <close>
}
    4ac4:	60a6                	ld	ra,72(sp)
    4ac6:	6406                	ld	s0,64(sp)
    4ac8:	74e2                	ld	s1,56(sp)
    4aca:	7942                	ld	s2,48(sp)
    4acc:	79a2                	ld	s3,40(sp)
    4ace:	6161                	addi	sp,sp,80
    4ad0:	8082                	ret
    printf("%s: sbrk did not align\n", s);
    4ad2:	85ce                	mv	a1,s3
    4ad4:	00003517          	auipc	a0,0x3
    4ad8:	d4450513          	addi	a0,a0,-700 # 7818 <malloc+0x2120>
    4adc:	369000ef          	jal	5644 <printf>
    exit(1);
    4ae0:	4505                	li	a0,1
    4ae2:	732000ef          	jal	5214 <exit>
    printf("could not open /");
    4ae6:	00003517          	auipc	a0,0x3
    4aea:	fc250513          	addi	a0,a0,-62 # 7aa8 <malloc+0x23b0>
    4aee:	357000ef          	jal	5644 <printf>
    exit(1);
    4af2:	4505                	li	a0,1
    4af4:	720000ef          	jal	5214 <exit>
    printf("could not stat /");
    4af8:	00003517          	auipc	a0,0x3
    4afc:	fc850513          	addi	a0,a0,-56 # 7ac0 <malloc+0x23c8>
    4b00:	345000ef          	jal	5644 <printf>
    exit(1);
    4b04:	4505                	li	a0,1
    4b06:	70e000ef          	jal	5214 <exit>
    printf("/ is not T_DIR");
    4b0a:	00003517          	auipc	a0,0x3
    4b0e:	fce50513          	addi	a0,a0,-50 # 7ad8 <malloc+0x23e0>
    4b12:	333000ef          	jal	5644 <printf>
    exit(1);
    4b16:	4505                	li	a0,1
    4b18:	6fc000ef          	jal	5214 <exit>

0000000000004b1c <fsfull>:
{
    4b1c:	7171                	addi	sp,sp,-176
    4b1e:	f506                	sd	ra,168(sp)
    4b20:	f122                	sd	s0,160(sp)
    4b22:	ed26                	sd	s1,152(sp)
    4b24:	e94a                	sd	s2,144(sp)
    4b26:	e54e                	sd	s3,136(sp)
    4b28:	e152                	sd	s4,128(sp)
    4b2a:	fcd6                	sd	s5,120(sp)
    4b2c:	f8da                	sd	s6,112(sp)
    4b2e:	f4de                	sd	s7,104(sp)
    4b30:	f0e2                	sd	s8,96(sp)
    4b32:	ece6                	sd	s9,88(sp)
    4b34:	e8ea                	sd	s10,80(sp)
    4b36:	e4ee                	sd	s11,72(sp)
    4b38:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    4b3a:	00003517          	auipc	a0,0x3
    4b3e:	fae50513          	addi	a0,a0,-82 # 7ae8 <malloc+0x23f0>
    4b42:	303000ef          	jal	5644 <printf>
  int fsblocks = 0;
    4b46:	4a81                	li	s5,0
  for (nfiles = 0;; nfiles++) {
    4b48:	4481                	li	s1,0
    name[0] = 'f';
    4b4a:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    4b4e:	3e800c93          	li	s9,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4b52:	06400c13          	li	s8,100
    name[3] = '0' + (nfiles % 100) / 10;
    4b56:	4ba9                	li	s7,10
    printf("writing %s\n", name);
    4b58:	00003d17          	auipc	s10,0x3
    4b5c:	fa0d0d13          	addi	s10,s10,-96 # 7af8 <malloc+0x2400>
    name[0] = 'f';
    4b60:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4b64:	0394c7bb          	divw	a5,s1,s9
    4b68:	0307879b          	addiw	a5,a5,48
    4b6c:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4b70:	0394e7bb          	remw	a5,s1,s9
    4b74:	0387c7bb          	divw	a5,a5,s8
    4b78:	0307879b          	addiw	a5,a5,48
    4b7c:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4b80:	0384e7bb          	remw	a5,s1,s8
    4b84:	0377c7bb          	divw	a5,a5,s7
    4b88:	0307879b          	addiw	a5,a5,48
    4b8c:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4b90:	0374e7bb          	remw	a5,s1,s7
    4b94:	0307879b          	addiw	a5,a5,48
    4b98:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4b9c:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    4ba0:	f5040593          	addi	a1,s0,-176
    4ba4:	856a                	mv	a0,s10
    4ba6:	29f000ef          	jal	5644 <printf>
    int fd = open(name, O_CREATE | O_RDWR);
    4baa:	20200593          	li	a1,514
    4bae:	f5040513          	addi	a0,s0,-176
    4bb2:	6a2000ef          	jal	5254 <open>
    4bb6:	892a                	mv	s2,a0
    if (fd < 0) {
    4bb8:	0a055163          	bgez	a0,4c5a <fsfull+0x13e>
      printf("open %s failed\n", name);
    4bbc:	f5040593          	addi	a1,s0,-176
    4bc0:	00003517          	auipc	a0,0x3
    4bc4:	f4850513          	addi	a0,a0,-184 # 7b08 <malloc+0x2410>
    4bc8:	27d000ef          	jal	5644 <printf>
  while (nfiles >= 0) {
    4bcc:	0604c163          	bltz	s1,4c2e <fsfull+0x112>
    name[0] = 'f';
    4bd0:	06600b93          	li	s7,102
    name[1] = '0' + nfiles / 1000;
    4bd4:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4bd8:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    4bdc:	4929                	li	s2,10
  while (nfiles >= 0) {
    4bde:	5b7d                	li	s6,-1
    name[0] = 'f';
    4be0:	f5740823          	sb	s7,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4be4:	0344c7bb          	divw	a5,s1,s4
    4be8:	0307879b          	addiw	a5,a5,48
    4bec:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4bf0:	0344e7bb          	remw	a5,s1,s4
    4bf4:	0337c7bb          	divw	a5,a5,s3
    4bf8:	0307879b          	addiw	a5,a5,48
    4bfc:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4c00:	0334e7bb          	remw	a5,s1,s3
    4c04:	0327c7bb          	divw	a5,a5,s2
    4c08:	0307879b          	addiw	a5,a5,48
    4c0c:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4c10:	0324e7bb          	remw	a5,s1,s2
    4c14:	0307879b          	addiw	a5,a5,48
    4c18:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4c1c:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    4c20:	f5040513          	addi	a0,s0,-176
    4c24:	640000ef          	jal	5264 <unlink>
    nfiles--;
    4c28:	34fd                	addiw	s1,s1,-1
  while (nfiles >= 0) {
    4c2a:	fb649be3          	bne	s1,s6,4be0 <fsfull+0xc4>
  printf("fsfull test finished, %d blocks\n", fsblocks);
    4c2e:	85d6                	mv	a1,s5
    4c30:	00003517          	auipc	a0,0x3
    4c34:	ef850513          	addi	a0,a0,-264 # 7b28 <malloc+0x2430>
    4c38:	20d000ef          	jal	5644 <printf>
}
    4c3c:	70aa                	ld	ra,168(sp)
    4c3e:	740a                	ld	s0,160(sp)
    4c40:	64ea                	ld	s1,152(sp)
    4c42:	694a                	ld	s2,144(sp)
    4c44:	69aa                	ld	s3,136(sp)
    4c46:	6a0a                	ld	s4,128(sp)
    4c48:	7ae6                	ld	s5,120(sp)
    4c4a:	7b46                	ld	s6,112(sp)
    4c4c:	7ba6                	ld	s7,104(sp)
    4c4e:	7c06                	ld	s8,96(sp)
    4c50:	6ce6                	ld	s9,88(sp)
    4c52:	6d46                	ld	s10,80(sp)
    4c54:	6da6                	ld	s11,72(sp)
    4c56:	614d                	addi	sp,sp,176
    4c58:	8082                	ret
    int total = 0;
    4c5a:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    4c5c:	00009b17          	auipc	s6,0x9
    4c60:	08cb0b13          	addi	s6,s6,140 # dce8 <buf>
      if (cc < BSIZE)
    4c64:	3ff00a13          	li	s4,1023
      int cc = write(fd, buf, BSIZE);
    4c68:	40000613          	li	a2,1024
    4c6c:	85da                	mv	a1,s6
    4c6e:	854a                	mv	a0,s2
    4c70:	5c4000ef          	jal	5234 <write>
      if (cc < BSIZE)
    4c74:	00aa5663          	bge	s4,a0,4c80 <fsfull+0x164>
      total += cc;
    4c78:	00a989bb          	addw	s3,s3,a0
      fsblocks++;
    4c7c:	2a85                	addiw	s5,s5,1
    while (1) {
    4c7e:	b7ed                	j	4c68 <fsfull+0x14c>
    printf("wrote %d bytes\n", total);
    4c80:	85ce                	mv	a1,s3
    4c82:	00003517          	auipc	a0,0x3
    4c86:	e9650513          	addi	a0,a0,-362 # 7b18 <malloc+0x2420>
    4c8a:	1bb000ef          	jal	5644 <printf>
    close(fd);
    4c8e:	854a                	mv	a0,s2
    4c90:	5ac000ef          	jal	523c <close>
    if (total == 0)
    4c94:	f2098ce3          	beqz	s3,4bcc <fsfull+0xb0>
  for (nfiles = 0;; nfiles++) {
    4c98:	2485                	addiw	s1,s1,1
    4c9a:	b5d9                	j	4b60 <fsfull+0x44>

0000000000004c9c <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s)
{
    4c9c:	7179                	addi	sp,sp,-48
    4c9e:	f406                	sd	ra,40(sp)
    4ca0:	f022                	sd	s0,32(sp)
    4ca2:	ec26                	sd	s1,24(sp)
    4ca4:	e84a                	sd	s2,16(sp)
    4ca6:	1800                	addi	s0,sp,48
    4ca8:	84aa                	mv	s1,a0
    4caa:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    4cac:	00003517          	auipc	a0,0x3
    4cb0:	ea450513          	addi	a0,a0,-348 # 7b50 <malloc+0x2458>
    4cb4:	191000ef          	jal	5644 <printf>
  if ((pid = fork()) < 0) {
    4cb8:	554000ef          	jal	520c <fork>
    4cbc:	02054a63          	bltz	a0,4cf0 <run+0x54>
    printf("runtest: fork error\n");
    exit(1);
  }
  if (pid == 0) {
    4cc0:	c129                	beqz	a0,4d02 <run+0x66>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    4cc2:	fdc40513          	addi	a0,s0,-36
    4cc6:	556000ef          	jal	521c <wait>
    if (xstatus != 0)
    4cca:	fdc42783          	lw	a5,-36(s0)
    4cce:	cf9d                	beqz	a5,4d0c <run+0x70>
      printf("FAILED\n");
    4cd0:	00003517          	auipc	a0,0x3
    4cd4:	ea850513          	addi	a0,a0,-344 # 7b78 <malloc+0x2480>
    4cd8:	16d000ef          	jal	5644 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    4cdc:	fdc42503          	lw	a0,-36(s0)
  }
}
    4ce0:	00153513          	seqz	a0,a0
    4ce4:	70a2                	ld	ra,40(sp)
    4ce6:	7402                	ld	s0,32(sp)
    4ce8:	64e2                	ld	s1,24(sp)
    4cea:	6942                	ld	s2,16(sp)
    4cec:	6145                	addi	sp,sp,48
    4cee:	8082                	ret
    printf("runtest: fork error\n");
    4cf0:	00003517          	auipc	a0,0x3
    4cf4:	e7050513          	addi	a0,a0,-400 # 7b60 <malloc+0x2468>
    4cf8:	14d000ef          	jal	5644 <printf>
    exit(1);
    4cfc:	4505                	li	a0,1
    4cfe:	516000ef          	jal	5214 <exit>
    f(s);
    4d02:	854a                	mv	a0,s2
    4d04:	9482                	jalr	s1
    exit(0);
    4d06:	4501                	li	a0,0
    4d08:	50c000ef          	jal	5214 <exit>
      printf("OK\n");
    4d0c:	00003517          	auipc	a0,0x3
    4d10:	e7450513          	addi	a0,a0,-396 # 7b80 <malloc+0x2488>
    4d14:	131000ef          	jal	5644 <printf>
    4d18:	b7d1                	j	4cdc <run+0x40>

0000000000004d1a <runtests>:

int
runtests(struct test *tests, char *justone, int continuous)
{
    4d1a:	7139                	addi	sp,sp,-64
    4d1c:	fc06                	sd	ra,56(sp)
    4d1e:	f822                	sd	s0,48(sp)
    4d20:	f426                	sd	s1,40(sp)
    4d22:	ec4e                	sd	s3,24(sp)
    4d24:	0080                	addi	s0,sp,64
    4d26:	84aa                	mv	s1,a0
  int ntests = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    4d28:	6508                	ld	a0,8(a0)
    4d2a:	cd39                	beqz	a0,4d88 <runtests+0x6e>
    4d2c:	f04a                	sd	s2,32(sp)
    4d2e:	e852                	sd	s4,16(sp)
    4d30:	e456                	sd	s5,8(sp)
    4d32:	892e                	mv	s2,a1
    4d34:	8a32                	mv	s4,a2
  int ntests = 0;
    4d36:	4981                	li	s3,0
    if ((justone == 0) || strcmp(t->s, justone) == 0) {
      ntests++;
      if (!run(t->f, t->s)) {
        if (continuous != 2) {
    4d38:	4a89                	li	s5,2
    4d3a:	a021                	j	4d42 <runtests+0x28>
  for (struct test *t = tests; t->s != 0; t++) {
    4d3c:	04c1                	addi	s1,s1,16
    4d3e:	6488                	ld	a0,8(s1)
    4d40:	c915                	beqz	a0,4d74 <runtests+0x5a>
    if ((justone == 0) || strcmp(t->s, justone) == 0) {
    4d42:	00090663          	beqz	s2,4d4e <runtests+0x34>
    4d46:	85ca                	mv	a1,s2
    4d48:	264000ef          	jal	4fac <strcmp>
    4d4c:	f965                	bnez	a0,4d3c <runtests+0x22>
      ntests++;
    4d4e:	2985                	addiw	s3,s3,1 # 1000001 <base+0xfef319>
      if (!run(t->f, t->s)) {
    4d50:	648c                	ld	a1,8(s1)
    4d52:	6088                	ld	a0,0(s1)
    4d54:	f49ff0ef          	jal	4c9c <run>
    4d58:	f175                	bnez	a0,4d3c <runtests+0x22>
        if (continuous != 2) {
    4d5a:	ff5a01e3          	beq	s4,s5,4d3c <runtests+0x22>
          printf("SOME TESTS FAILED\n");
    4d5e:	00003517          	auipc	a0,0x3
    4d62:	e2a50513          	addi	a0,a0,-470 # 7b88 <malloc+0x2490>
    4d66:	0df000ef          	jal	5644 <printf>
          return -1;
    4d6a:	59fd                	li	s3,-1
    4d6c:	7902                	ld	s2,32(sp)
    4d6e:	6a42                	ld	s4,16(sp)
    4d70:	6aa2                	ld	s5,8(sp)
    4d72:	a021                	j	4d7a <runtests+0x60>
    4d74:	7902                	ld	s2,32(sp)
    4d76:	6a42                	ld	s4,16(sp)
    4d78:	6aa2                	ld	s5,8(sp)
        }
      }
    }
  }
  return ntests;
}
    4d7a:	854e                	mv	a0,s3
    4d7c:	70e2                	ld	ra,56(sp)
    4d7e:	7442                	ld	s0,48(sp)
    4d80:	74a2                	ld	s1,40(sp)
    4d82:	69e2                	ld	s3,24(sp)
    4d84:	6121                	addi	sp,sp,64
    4d86:	8082                	ret
  return ntests;
    4d88:	4981                	li	s3,0
    4d8a:	bfc5                	j	4d7a <runtests+0x60>

0000000000004d8c <countfree>:

// use sbrk() to count how many free physical memory pages there are.
int
countfree()
{
    4d8c:	7179                	addi	sp,sp,-48
    4d8e:	f406                	sd	ra,40(sp)
    4d90:	f022                	sd	s0,32(sp)
    4d92:	ec26                	sd	s1,24(sp)
    4d94:	e84a                	sd	s2,16(sp)
    4d96:	e44e                	sd	s3,8(sp)
    4d98:	1800                	addi	s0,sp,48
  int n = 0;
  uint64 sz0 = (uint64)sbrk(0);
    4d9a:	4501                	li	a0,0
    4d9c:	444000ef          	jal	51e0 <sbrk>
    4da0:	89aa                	mv	s3,a0
  int n = 0;
    4da2:	4481                	li	s1,0
  while (1) {
    char *a = sbrk(PGSIZE);
    if (a == SBRK_ERROR) {
    4da4:	597d                	li	s2,-1
    4da6:	a011                	j	4daa <countfree+0x1e>
      break;
    }
    n += 1;
    4da8:	2485                	addiw	s1,s1,1
    char *a = sbrk(PGSIZE);
    4daa:	6505                	lui	a0,0x1
    4dac:	434000ef          	jal	51e0 <sbrk>
    if (a == SBRK_ERROR) {
    4db0:	ff251ce3          	bne	a0,s2,4da8 <countfree+0x1c>
  }
  sbrk(-((uint64)sbrk(0) - sz0));
    4db4:	4501                	li	a0,0
    4db6:	42a000ef          	jal	51e0 <sbrk>
    4dba:	40a9853b          	subw	a0,s3,a0
    4dbe:	422000ef          	jal	51e0 <sbrk>
  return n;
}
    4dc2:	8526                	mv	a0,s1
    4dc4:	70a2                	ld	ra,40(sp)
    4dc6:	7402                	ld	s0,32(sp)
    4dc8:	64e2                	ld	s1,24(sp)
    4dca:	6942                	ld	s2,16(sp)
    4dcc:	69a2                	ld	s3,8(sp)
    4dce:	6145                	addi	sp,sp,48
    4dd0:	8082                	ret

0000000000004dd2 <drivetests>:

int
drivetests(int quick, int continuous, char *justone)
{
    4dd2:	7159                	addi	sp,sp,-112
    4dd4:	f486                	sd	ra,104(sp)
    4dd6:	f0a2                	sd	s0,96(sp)
    4dd8:	eca6                	sd	s1,88(sp)
    4dda:	e8ca                	sd	s2,80(sp)
    4ddc:	e4ce                	sd	s3,72(sp)
    4dde:	e0d2                	sd	s4,64(sp)
    4de0:	fc56                	sd	s5,56(sp)
    4de2:	f85a                	sd	s6,48(sp)
    4de4:	f45e                	sd	s7,40(sp)
    4de6:	f062                	sd	s8,32(sp)
    4de8:	ec66                	sd	s9,24(sp)
    4dea:	e86a                	sd	s10,16(sp)
    4dec:	e46e                	sd	s11,8(sp)
    4dee:	1880                	addi	s0,sp,112
    4df0:	8aaa                	mv	s5,a0
    4df2:	89ae                	mv	s3,a1
    4df4:	8a32                	mv	s4,a2
  do {
    printf("usertests starting\n");
    4df6:	00003c17          	auipc	s8,0x3
    4dfa:	daac0c13          	addi	s8,s8,-598 # 7ba0 <malloc+0x24a8>
    int free0 = countfree();
    int free1 = 0;
    int ntests = 0;
    int n;
    n = runtests(quicktests, justone, continuous);
    4dfe:	00005b97          	auipc	s7,0x5
    4e02:	212b8b93          	addi	s7,s7,530 # a010 <quicktests>
    if (n < 0) {
      if (continuous != 2) {
    4e06:	4b09                	li	s6,2
      ntests += n;
    }
    if (!quick) {
      if (justone == 0)
        printf("usertests slow tests starting\n");
      n = runtests(slowtests, justone, continuous);
    4e08:	00005c97          	auipc	s9,0x5
    4e0c:	648c8c93          	addi	s9,s9,1608 # a450 <slowtests>
        printf("usertests slow tests starting\n");
    4e10:	00003d97          	auipc	s11,0x3
    4e14:	da8d8d93          	addi	s11,s11,-600 # 7bb8 <malloc+0x24c0>
      } else {
        ntests += n;
      }
    }
    if ((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    4e18:	00003d17          	auipc	s10,0x3
    4e1c:	dc0d0d13          	addi	s10,s10,-576 # 7bd8 <malloc+0x24e0>
    4e20:	a025                	j	4e48 <drivetests+0x76>
      if (continuous != 2) {
    4e22:	09699063          	bne	s3,s6,4ea2 <drivetests+0xd0>
    int ntests = 0;
    4e26:	4481                	li	s1,0
    4e28:	a835                	j	4e64 <drivetests+0x92>
        printf("usertests slow tests starting\n");
    4e2a:	856e                	mv	a0,s11
    4e2c:	019000ef          	jal	5644 <printf>
    4e30:	a835                	j	4e6c <drivetests+0x9a>
        if (continuous != 2) {
    4e32:	07699a63          	bne	s3,s6,4ea6 <drivetests+0xd4>
    if ((free1 = countfree()) < free0) {
    4e36:	f57ff0ef          	jal	4d8c <countfree>
    4e3a:	05254263          	blt	a0,s2,4e7e <drivetests+0xac>
      if (continuous != 2) {
        return 1;
      }
    }
    if (justone != 0 && ntests == 0) {
    4e3e:	000a0363          	beqz	s4,4e44 <drivetests+0x72>
    4e42:	c8a1                	beqz	s1,4e92 <drivetests+0xc0>
      printf("NO TESTS EXECUTED\n");
      return 1;
    }
  } while (continuous);
    4e44:	06098563          	beqz	s3,4eae <drivetests+0xdc>
    printf("usertests starting\n");
    4e48:	8562                	mv	a0,s8
    4e4a:	7fa000ef          	jal	5644 <printf>
    int free0 = countfree();
    4e4e:	f3fff0ef          	jal	4d8c <countfree>
    4e52:	892a                	mv	s2,a0
    n = runtests(quicktests, justone, continuous);
    4e54:	864e                	mv	a2,s3
    4e56:	85d2                	mv	a1,s4
    4e58:	855e                	mv	a0,s7
    4e5a:	ec1ff0ef          	jal	4d1a <runtests>
    4e5e:	84aa                	mv	s1,a0
    if (n < 0) {
    4e60:	fc0541e3          	bltz	a0,4e22 <drivetests+0x50>
    if (!quick) {
    4e64:	fc0a99e3          	bnez	s5,4e36 <drivetests+0x64>
      if (justone == 0)
    4e68:	fc0a01e3          	beqz	s4,4e2a <drivetests+0x58>
      n = runtests(slowtests, justone, continuous);
    4e6c:	864e                	mv	a2,s3
    4e6e:	85d2                	mv	a1,s4
    4e70:	8566                	mv	a0,s9
    4e72:	ea9ff0ef          	jal	4d1a <runtests>
      if (n < 0) {
    4e76:	fa054ee3          	bltz	a0,4e32 <drivetests+0x60>
        ntests += n;
    4e7a:	9ca9                	addw	s1,s1,a0
    4e7c:	bf6d                	j	4e36 <drivetests+0x64>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    4e7e:	864a                	mv	a2,s2
    4e80:	85aa                	mv	a1,a0
    4e82:	856a                	mv	a0,s10
    4e84:	7c0000ef          	jal	5644 <printf>
      if (continuous != 2) {
    4e88:	03699163          	bne	s3,s6,4eaa <drivetests+0xd8>
    if (justone != 0 && ntests == 0) {
    4e8c:	fa0a1be3          	bnez	s4,4e42 <drivetests+0x70>
    4e90:	bf65                	j	4e48 <drivetests+0x76>
      printf("NO TESTS EXECUTED\n");
    4e92:	00003517          	auipc	a0,0x3
    4e96:	d7650513          	addi	a0,a0,-650 # 7c08 <malloc+0x2510>
    4e9a:	7aa000ef          	jal	5644 <printf>
      return 1;
    4e9e:	4505                	li	a0,1
    4ea0:	a801                	j	4eb0 <drivetests+0xde>
        return 1;
    4ea2:	4505                	li	a0,1
    4ea4:	a031                	j	4eb0 <drivetests+0xde>
          return 1;
    4ea6:	4505                	li	a0,1
    4ea8:	a021                	j	4eb0 <drivetests+0xde>
        return 1;
    4eaa:	4505                	li	a0,1
    4eac:	a011                	j	4eb0 <drivetests+0xde>
  return 0;
    4eae:	854e                	mv	a0,s3
}
    4eb0:	70a6                	ld	ra,104(sp)
    4eb2:	7406                	ld	s0,96(sp)
    4eb4:	64e6                	ld	s1,88(sp)
    4eb6:	6946                	ld	s2,80(sp)
    4eb8:	69a6                	ld	s3,72(sp)
    4eba:	6a06                	ld	s4,64(sp)
    4ebc:	7ae2                	ld	s5,56(sp)
    4ebe:	7b42                	ld	s6,48(sp)
    4ec0:	7ba2                	ld	s7,40(sp)
    4ec2:	7c02                	ld	s8,32(sp)
    4ec4:	6ce2                	ld	s9,24(sp)
    4ec6:	6d42                	ld	s10,16(sp)
    4ec8:	6da2                	ld	s11,8(sp)
    4eca:	6165                	addi	sp,sp,112
    4ecc:	8082                	ret

0000000000004ece <main>:

int
main(int argc, char *argv[])
{
    4ece:	1101                	addi	sp,sp,-32
    4ed0:	ec06                	sd	ra,24(sp)
    4ed2:	e822                	sd	s0,16(sp)
    4ed4:	e426                	sd	s1,8(sp)
    4ed6:	e04a                	sd	s2,0(sp)
    4ed8:	1000                	addi	s0,sp,32
    4eda:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if (argc == 2 && strcmp(argv[1], "-q") == 0) {
    4edc:	4789                	li	a5,2
    4ede:	00f50e63          	beq	a0,a5,4efa <main+0x2c>
    continuous = 1;
  } else if (argc == 2 && strcmp(argv[1], "-C") == 0) {
    continuous = 2;
  } else if (argc == 2 && argv[1][0] != '-') {
    justone = argv[1];
  } else if (argc > 1) {
    4ee2:	4785                	li	a5,1
    4ee4:	06a7c663          	blt	a5,a0,4f50 <main+0x82>
  char *justone = 0;
    4ee8:	4601                	li	a2,0
  int quick = 0;
    4eea:	4501                	li	a0,0
  int continuous = 0;
    4eec:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    4eee:	ee5ff0ef          	jal	4dd2 <drivetests>
    4ef2:	cd35                	beqz	a0,4f6e <main+0xa0>
    exit(1);
    4ef4:	4505                	li	a0,1
    4ef6:	31e000ef          	jal	5214 <exit>
    4efa:	892e                	mv	s2,a1
  if (argc == 2 && strcmp(argv[1], "-q") == 0) {
    4efc:	00003597          	auipc	a1,0x3
    4f00:	d2458593          	addi	a1,a1,-732 # 7c20 <malloc+0x2528>
    4f04:	00893503          	ld	a0,8(s2) # ffffffffffffd008 <base+0xfffffffffffec320>
    4f08:	0a4000ef          	jal	4fac <strcmp>
    4f0c:	85aa                	mv	a1,a0
    4f0e:	e501                	bnez	a0,4f16 <main+0x48>
  char *justone = 0;
    4f10:	4601                	li	a2,0
    quick = 1;
    4f12:	4505                	li	a0,1
    4f14:	bfe9                	j	4eee <main+0x20>
  } else if (argc == 2 && strcmp(argv[1], "-c") == 0) {
    4f16:	00003597          	auipc	a1,0x3
    4f1a:	d1258593          	addi	a1,a1,-750 # 7c28 <malloc+0x2530>
    4f1e:	00893503          	ld	a0,8(s2)
    4f22:	08a000ef          	jal	4fac <strcmp>
    4f26:	cd15                	beqz	a0,4f62 <main+0x94>
  } else if (argc == 2 && strcmp(argv[1], "-C") == 0) {
    4f28:	00003597          	auipc	a1,0x3
    4f2c:	d5058593          	addi	a1,a1,-688 # 7c78 <malloc+0x2580>
    4f30:	00893503          	ld	a0,8(s2)
    4f34:	078000ef          	jal	4fac <strcmp>
    4f38:	c905                	beqz	a0,4f68 <main+0x9a>
  } else if (argc == 2 && argv[1][0] != '-') {
    4f3a:	00893603          	ld	a2,8(s2)
    4f3e:	00064703          	lbu	a4,0(a2) # 1000 <badarg>
    4f42:	02d00793          	li	a5,45
    4f46:	00f70563          	beq	a4,a5,4f50 <main+0x82>
  int quick = 0;
    4f4a:	4501                	li	a0,0
  int continuous = 0;
    4f4c:	4581                	li	a1,0
    4f4e:	b745                	j	4eee <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    4f50:	00003517          	auipc	a0,0x3
    4f54:	ce050513          	addi	a0,a0,-800 # 7c30 <malloc+0x2538>
    4f58:	6ec000ef          	jal	5644 <printf>
    exit(1);
    4f5c:	4505                	li	a0,1
    4f5e:	2b6000ef          	jal	5214 <exit>
  char *justone = 0;
    4f62:	4601                	li	a2,0
    continuous = 1;
    4f64:	4585                	li	a1,1
    4f66:	b761                	j	4eee <main+0x20>
    continuous = 2;
    4f68:	85a6                	mv	a1,s1
  char *justone = 0;
    4f6a:	4601                	li	a2,0
    4f6c:	b749                	j	4eee <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    4f6e:	00003517          	auipc	a0,0x3
    4f72:	cf250513          	addi	a0,a0,-782 # 7c60 <malloc+0x2568>
    4f76:	6ce000ef          	jal	5644 <printf>
  exit(0);
    4f7a:	4501                	li	a0,0
    4f7c:	298000ef          	jal	5214 <exit>

0000000000004f80 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
    4f80:	1141                	addi	sp,sp,-16
    4f82:	e406                	sd	ra,8(sp)
    4f84:	e022                	sd	s0,0(sp)
    4f86:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
    4f88:	f47ff0ef          	jal	4ece <main>
  exit(r);
    4f8c:	288000ef          	jal	5214 <exit>

0000000000004f90 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
    4f90:	1141                	addi	sp,sp,-16
    4f92:	e422                	sd	s0,8(sp)
    4f94:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
    4f96:	87aa                	mv	a5,a0
    4f98:	0585                	addi	a1,a1,1
    4f9a:	0785                	addi	a5,a5,1
    4f9c:	fff5c703          	lbu	a4,-1(a1)
    4fa0:	fee78fa3          	sb	a4,-1(a5)
    4fa4:	fb75                	bnez	a4,4f98 <strcpy+0x8>
    ;
  return os;
}
    4fa6:	6422                	ld	s0,8(sp)
    4fa8:	0141                	addi	sp,sp,16
    4faa:	8082                	ret

0000000000004fac <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4fac:	1141                	addi	sp,sp,-16
    4fae:	e422                	sd	s0,8(sp)
    4fb0:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
    4fb2:	00054783          	lbu	a5,0(a0)
    4fb6:	cb91                	beqz	a5,4fca <strcmp+0x1e>
    4fb8:	0005c703          	lbu	a4,0(a1)
    4fbc:	00f71763          	bne	a4,a5,4fca <strcmp+0x1e>
    p++, q++;
    4fc0:	0505                	addi	a0,a0,1
    4fc2:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
    4fc4:	00054783          	lbu	a5,0(a0)
    4fc8:	fbe5                	bnez	a5,4fb8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    4fca:	0005c503          	lbu	a0,0(a1)
}
    4fce:	40a7853b          	subw	a0,a5,a0
    4fd2:	6422                	ld	s0,8(sp)
    4fd4:	0141                	addi	sp,sp,16
    4fd6:	8082                	ret

0000000000004fd8 <strlen>:

uint
strlen(const char *s)
{
    4fd8:	1141                	addi	sp,sp,-16
    4fda:	e422                	sd	s0,8(sp)
    4fdc:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
    4fde:	00054783          	lbu	a5,0(a0)
    4fe2:	cf91                	beqz	a5,4ffe <strlen+0x26>
    4fe4:	0505                	addi	a0,a0,1
    4fe6:	87aa                	mv	a5,a0
    4fe8:	86be                	mv	a3,a5
    4fea:	0785                	addi	a5,a5,1
    4fec:	fff7c703          	lbu	a4,-1(a5)
    4ff0:	ff65                	bnez	a4,4fe8 <strlen+0x10>
    4ff2:	40a6853b          	subw	a0,a3,a0
    4ff6:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    4ff8:	6422                	ld	s0,8(sp)
    4ffa:	0141                	addi	sp,sp,16
    4ffc:	8082                	ret
  for (n = 0; s[n]; n++)
    4ffe:	4501                	li	a0,0
    5000:	bfe5                	j	4ff8 <strlen+0x20>

0000000000005002 <memset>:

void *
memset(void *dst, int c, uint n)
{
    5002:	1141                	addi	sp,sp,-16
    5004:	e422                	sd	s0,8(sp)
    5006:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
    5008:	ca19                	beqz	a2,501e <memset+0x1c>
    500a:	87aa                	mv	a5,a0
    500c:	1602                	slli	a2,a2,0x20
    500e:	9201                	srli	a2,a2,0x20
    5010:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    5014:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
    5018:	0785                	addi	a5,a5,1
    501a:	fee79de3          	bne	a5,a4,5014 <memset+0x12>
  }
  return dst;
}
    501e:	6422                	ld	s0,8(sp)
    5020:	0141                	addi	sp,sp,16
    5022:	8082                	ret

0000000000005024 <strchr>:

char *
strchr(const char *s, char c)
{
    5024:	1141                	addi	sp,sp,-16
    5026:	e422                	sd	s0,8(sp)
    5028:	0800                	addi	s0,sp,16
  for (; *s; s++)
    502a:	00054783          	lbu	a5,0(a0)
    502e:	cb99                	beqz	a5,5044 <strchr+0x20>
    if (*s == c)
    5030:	00f58763          	beq	a1,a5,503e <strchr+0x1a>
  for (; *s; s++)
    5034:	0505                	addi	a0,a0,1
    5036:	00054783          	lbu	a5,0(a0)
    503a:	fbfd                	bnez	a5,5030 <strchr+0xc>
      return (char *)s;
  return 0;
    503c:	4501                	li	a0,0
}
    503e:	6422                	ld	s0,8(sp)
    5040:	0141                	addi	sp,sp,16
    5042:	8082                	ret
  return 0;
    5044:	4501                	li	a0,0
    5046:	bfe5                	j	503e <strchr+0x1a>

0000000000005048 <gets>:

char *
gets(char *buf, int max)
{
    5048:	711d                	addi	sp,sp,-96
    504a:	ec86                	sd	ra,88(sp)
    504c:	e8a2                	sd	s0,80(sp)
    504e:	e4a6                	sd	s1,72(sp)
    5050:	e0ca                	sd	s2,64(sp)
    5052:	fc4e                	sd	s3,56(sp)
    5054:	f852                	sd	s4,48(sp)
    5056:	f456                	sd	s5,40(sp)
    5058:	f05a                	sd	s6,32(sp)
    505a:	ec5e                	sd	s7,24(sp)
    505c:	1080                	addi	s0,sp,96
    505e:	8baa                	mv	s7,a0
    5060:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
    5062:	892a                	mv	s2,a0
    5064:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
    5066:	4aa9                	li	s5,10
    5068:	4b35                	li	s6,13
  for (i = 0; i + 1 < max;) {
    506a:	89a6                	mv	s3,s1
    506c:	2485                	addiw	s1,s1,1
    506e:	0344d663          	bge	s1,s4,509a <gets+0x52>
    cc = read(0, &c, 1);
    5072:	4605                	li	a2,1
    5074:	faf40593          	addi	a1,s0,-81
    5078:	4501                	li	a0,0
    507a:	1b2000ef          	jal	522c <read>
    if (cc < 1)
    507e:	00a05e63          	blez	a0,509a <gets+0x52>
    buf[i++] = c;
    5082:	faf44783          	lbu	a5,-81(s0)
    5086:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
    508a:	01578763          	beq	a5,s5,5098 <gets+0x50>
    508e:	0905                	addi	s2,s2,1
    5090:	fd679de3          	bne	a5,s6,506a <gets+0x22>
    buf[i++] = c;
    5094:	89a6                	mv	s3,s1
    5096:	a011                	j	509a <gets+0x52>
    5098:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    509a:	99de                	add	s3,s3,s7
    509c:	00098023          	sb	zero,0(s3)
  return buf;
}
    50a0:	855e                	mv	a0,s7
    50a2:	60e6                	ld	ra,88(sp)
    50a4:	6446                	ld	s0,80(sp)
    50a6:	64a6                	ld	s1,72(sp)
    50a8:	6906                	ld	s2,64(sp)
    50aa:	79e2                	ld	s3,56(sp)
    50ac:	7a42                	ld	s4,48(sp)
    50ae:	7aa2                	ld	s5,40(sp)
    50b0:	7b02                	ld	s6,32(sp)
    50b2:	6be2                	ld	s7,24(sp)
    50b4:	6125                	addi	sp,sp,96
    50b6:	8082                	ret

00000000000050b8 <stat>:

int
stat(const char *n, struct stat *st)
{
    50b8:	1101                	addi	sp,sp,-32
    50ba:	ec06                	sd	ra,24(sp)
    50bc:	e822                	sd	s0,16(sp)
    50be:	e04a                	sd	s2,0(sp)
    50c0:	1000                	addi	s0,sp,32
    50c2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    50c4:	4581                	li	a1,0
    50c6:	18e000ef          	jal	5254 <open>
  if (fd < 0)
    50ca:	02054263          	bltz	a0,50ee <stat+0x36>
    50ce:	e426                	sd	s1,8(sp)
    50d0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    50d2:	85ca                	mv	a1,s2
    50d4:	198000ef          	jal	526c <fstat>
    50d8:	892a                	mv	s2,a0
  close(fd);
    50da:	8526                	mv	a0,s1
    50dc:	160000ef          	jal	523c <close>
  return r;
    50e0:	64a2                	ld	s1,8(sp)
}
    50e2:	854a                	mv	a0,s2
    50e4:	60e2                	ld	ra,24(sp)
    50e6:	6442                	ld	s0,16(sp)
    50e8:	6902                	ld	s2,0(sp)
    50ea:	6105                	addi	sp,sp,32
    50ec:	8082                	ret
    return -1;
    50ee:	597d                	li	s2,-1
    50f0:	bfcd                	j	50e2 <stat+0x2a>

00000000000050f2 <atoi>:

int
atoi(const char *s)
{
    50f2:	1141                	addi	sp,sp,-16
    50f4:	e422                	sd	s0,8(sp)
    50f6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
    50f8:	00054683          	lbu	a3,0(a0)
    50fc:	fd06879b          	addiw	a5,a3,-48 # 3ffd0 <base+0x2f2e8>
    5100:	0ff7f793          	zext.b	a5,a5
    5104:	4625                	li	a2,9
    5106:	02f66863          	bltu	a2,a5,5136 <atoi+0x44>
    510a:	872a                	mv	a4,a0
  n = 0;
    510c:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
    510e:	0705                	addi	a4,a4,1 # 1000001 <base+0xfef319>
    5110:	0025179b          	slliw	a5,a0,0x2
    5114:	9fa9                	addw	a5,a5,a0
    5116:	0017979b          	slliw	a5,a5,0x1
    511a:	9fb5                	addw	a5,a5,a3
    511c:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
    5120:	00074683          	lbu	a3,0(a4)
    5124:	fd06879b          	addiw	a5,a3,-48
    5128:	0ff7f793          	zext.b	a5,a5
    512c:	fef671e3          	bgeu	a2,a5,510e <atoi+0x1c>
  return n;
}
    5130:	6422                	ld	s0,8(sp)
    5132:	0141                	addi	sp,sp,16
    5134:	8082                	ret
  n = 0;
    5136:	4501                	li	a0,0
    5138:	bfe5                	j	5130 <atoi+0x3e>

000000000000513a <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    513a:	1141                	addi	sp,sp,-16
    513c:	e422                	sd	s0,8(sp)
    513e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5140:	02b57463          	bgeu	a0,a1,5168 <memmove+0x2e>
    while (n-- > 0)
    5144:	00c05f63          	blez	a2,5162 <memmove+0x28>
    5148:	1602                	slli	a2,a2,0x20
    514a:	9201                	srli	a2,a2,0x20
    514c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    5150:	872a                	mv	a4,a0
      *dst++ = *src++;
    5152:	0585                	addi	a1,a1,1
    5154:	0705                	addi	a4,a4,1
    5156:	fff5c683          	lbu	a3,-1(a1)
    515a:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
    515e:	fef71ae3          	bne	a4,a5,5152 <memmove+0x18>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    5162:	6422                	ld	s0,8(sp)
    5164:	0141                	addi	sp,sp,16
    5166:	8082                	ret
    dst += n;
    5168:	00c50733          	add	a4,a0,a2
    src += n;
    516c:	95b2                	add	a1,a1,a2
    while (n-- > 0)
    516e:	fec05ae3          	blez	a2,5162 <memmove+0x28>
    5172:	fff6079b          	addiw	a5,a2,-1
    5176:	1782                	slli	a5,a5,0x20
    5178:	9381                	srli	a5,a5,0x20
    517a:	fff7c793          	not	a5,a5
    517e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    5180:	15fd                	addi	a1,a1,-1
    5182:	177d                	addi	a4,a4,-1
    5184:	0005c683          	lbu	a3,0(a1)
    5188:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
    518c:	fee79ae3          	bne	a5,a4,5180 <memmove+0x46>
    5190:	bfc9                	j	5162 <memmove+0x28>

0000000000005192 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5192:	1141                	addi	sp,sp,-16
    5194:	e422                	sd	s0,8(sp)
    5196:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    5198:	ca05                	beqz	a2,51c8 <memcmp+0x36>
    519a:	fff6069b          	addiw	a3,a2,-1
    519e:	1682                	slli	a3,a3,0x20
    51a0:	9281                	srli	a3,a3,0x20
    51a2:	0685                	addi	a3,a3,1
    51a4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    51a6:	00054783          	lbu	a5,0(a0)
    51aa:	0005c703          	lbu	a4,0(a1)
    51ae:	00e79863          	bne	a5,a4,51be <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    51b2:	0505                	addi	a0,a0,1
    p2++;
    51b4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    51b6:	fed518e3          	bne	a0,a3,51a6 <memcmp+0x14>
  }
  return 0;
    51ba:	4501                	li	a0,0
    51bc:	a019                	j	51c2 <memcmp+0x30>
      return *p1 - *p2;
    51be:	40e7853b          	subw	a0,a5,a4
}
    51c2:	6422                	ld	s0,8(sp)
    51c4:	0141                	addi	sp,sp,16
    51c6:	8082                	ret
  return 0;
    51c8:	4501                	li	a0,0
    51ca:	bfe5                	j	51c2 <memcmp+0x30>

00000000000051cc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    51cc:	1141                	addi	sp,sp,-16
    51ce:	e406                	sd	ra,8(sp)
    51d0:	e022                	sd	s0,0(sp)
    51d2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    51d4:	f67ff0ef          	jal	513a <memmove>
}
    51d8:	60a2                	ld	ra,8(sp)
    51da:	6402                	ld	s0,0(sp)
    51dc:	0141                	addi	sp,sp,16
    51de:	8082                	ret

00000000000051e0 <sbrk>:

char *
sbrk(int n)
{
    51e0:	1141                	addi	sp,sp,-16
    51e2:	e406                	sd	ra,8(sp)
    51e4:	e022                	sd	s0,0(sp)
    51e6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
    51e8:	4585                	li	a1,1
    51ea:	0b2000ef          	jal	529c <sys_sbrk>
}
    51ee:	60a2                	ld	ra,8(sp)
    51f0:	6402                	ld	s0,0(sp)
    51f2:	0141                	addi	sp,sp,16
    51f4:	8082                	ret

00000000000051f6 <sbrklazy>:

char *
sbrklazy(int n)
{
    51f6:	1141                	addi	sp,sp,-16
    51f8:	e406                	sd	ra,8(sp)
    51fa:	e022                	sd	s0,0(sp)
    51fc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
    51fe:	4589                	li	a1,2
    5200:	09c000ef          	jal	529c <sys_sbrk>
}
    5204:	60a2                	ld	ra,8(sp)
    5206:	6402                	ld	s0,0(sp)
    5208:	0141                	addi	sp,sp,16
    520a:	8082                	ret

000000000000520c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    520c:	4885                	li	a7,1
 ecall
    520e:	00000073          	ecall
 ret
    5212:	8082                	ret

0000000000005214 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5214:	4889                	li	a7,2
 ecall
    5216:	00000073          	ecall
 ret
    521a:	8082                	ret

000000000000521c <wait>:
.global wait
wait:
 li a7, SYS_wait
    521c:	488d                	li	a7,3
 ecall
    521e:	00000073          	ecall
 ret
    5222:	8082                	ret

0000000000005224 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5224:	4891                	li	a7,4
 ecall
    5226:	00000073          	ecall
 ret
    522a:	8082                	ret

000000000000522c <read>:
.global read
read:
 li a7, SYS_read
    522c:	4895                	li	a7,5
 ecall
    522e:	00000073          	ecall
 ret
    5232:	8082                	ret

0000000000005234 <write>:
.global write
write:
 li a7, SYS_write
    5234:	48c1                	li	a7,16
 ecall
    5236:	00000073          	ecall
 ret
    523a:	8082                	ret

000000000000523c <close>:
.global close
close:
 li a7, SYS_close
    523c:	48d5                	li	a7,21
 ecall
    523e:	00000073          	ecall
 ret
    5242:	8082                	ret

0000000000005244 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5244:	4899                	li	a7,6
 ecall
    5246:	00000073          	ecall
 ret
    524a:	8082                	ret

000000000000524c <exec>:
.global exec
exec:
 li a7, SYS_exec
    524c:	489d                	li	a7,7
 ecall
    524e:	00000073          	ecall
 ret
    5252:	8082                	ret

0000000000005254 <open>:
.global open
open:
 li a7, SYS_open
    5254:	48bd                	li	a7,15
 ecall
    5256:	00000073          	ecall
 ret
    525a:	8082                	ret

000000000000525c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    525c:	48c5                	li	a7,17
 ecall
    525e:	00000073          	ecall
 ret
    5262:	8082                	ret

0000000000005264 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5264:	48c9                	li	a7,18
 ecall
    5266:	00000073          	ecall
 ret
    526a:	8082                	ret

000000000000526c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    526c:	48a1                	li	a7,8
 ecall
    526e:	00000073          	ecall
 ret
    5272:	8082                	ret

0000000000005274 <link>:
.global link
link:
 li a7, SYS_link
    5274:	48cd                	li	a7,19
 ecall
    5276:	00000073          	ecall
 ret
    527a:	8082                	ret

000000000000527c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    527c:	48d1                	li	a7,20
 ecall
    527e:	00000073          	ecall
 ret
    5282:	8082                	ret

0000000000005284 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5284:	48a5                	li	a7,9
 ecall
    5286:	00000073          	ecall
 ret
    528a:	8082                	ret

000000000000528c <dup>:
.global dup
dup:
 li a7, SYS_dup
    528c:	48a9                	li	a7,10
 ecall
    528e:	00000073          	ecall
 ret
    5292:	8082                	ret

0000000000005294 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5294:	48ad                	li	a7,11
 ecall
    5296:	00000073          	ecall
 ret
    529a:	8082                	ret

000000000000529c <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
    529c:	48b1                	li	a7,12
 ecall
    529e:	00000073          	ecall
 ret
    52a2:	8082                	ret

00000000000052a4 <pause>:
.global pause
pause:
 li a7, SYS_pause
    52a4:	48b5                	li	a7,13
 ecall
    52a6:	00000073          	ecall
 ret
    52aa:	8082                	ret

00000000000052ac <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    52ac:	48b9                	li	a7,14
 ecall
    52ae:	00000073          	ecall
 ret
    52b2:	8082                	ret

00000000000052b4 <sync>:
.global sync
sync:
 li a7, SYS_sync
    52b4:	48d9                	li	a7,22
 ecall
    52b6:	00000073          	ecall
 ret
    52ba:	8082                	ret

00000000000052bc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    52bc:	1101                	addi	sp,sp,-32
    52be:	ec06                	sd	ra,24(sp)
    52c0:	e822                	sd	s0,16(sp)
    52c2:	1000                	addi	s0,sp,32
    52c4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    52c8:	4605                	li	a2,1
    52ca:	fef40593          	addi	a1,s0,-17
    52ce:	f67ff0ef          	jal	5234 <write>
}
    52d2:	60e2                	ld	ra,24(sp)
    52d4:	6442                	ld	s0,16(sp)
    52d6:	6105                	addi	sp,sp,32
    52d8:	8082                	ret

00000000000052da <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    52da:	715d                	addi	sp,sp,-80
    52dc:	e486                	sd	ra,72(sp)
    52de:	e0a2                	sd	s0,64(sp)
    52e0:	f84a                	sd	s2,48(sp)
    52e2:	0880                	addi	s0,sp,80
    52e4:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
    52e6:	c299                	beqz	a3,52ec <printint+0x12>
    52e8:	0805c363          	bltz	a1,536e <printint+0x94>
  neg = 0;
    52ec:	4881                	li	a7,0
    52ee:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    52f2:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
    52f4:	00003517          	auipc	a0,0x3
    52f8:	ddc50513          	addi	a0,a0,-548 # 80d0 <digits>
    52fc:	883e                	mv	a6,a5
    52fe:	2785                	addiw	a5,a5,1
    5300:	02c5f733          	remu	a4,a1,a2
    5304:	972a                	add	a4,a4,a0
    5306:	00074703          	lbu	a4,0(a4)
    530a:	00e68023          	sb	a4,0(a3)
  } while ((x /= base) != 0);
    530e:	872e                	mv	a4,a1
    5310:	02c5d5b3          	divu	a1,a1,a2
    5314:	0685                	addi	a3,a3,1
    5316:	fec773e3          	bgeu	a4,a2,52fc <printint+0x22>
  if (neg)
    531a:	00088b63          	beqz	a7,5330 <printint+0x56>
    buf[i++] = '-';
    531e:	fd078793          	addi	a5,a5,-48
    5322:	97a2                	add	a5,a5,s0
    5324:	02d00713          	li	a4,45
    5328:	fee78423          	sb	a4,-24(a5)
    532c:	0028079b          	addiw	a5,a6,2

  while (--i >= 0)
    5330:	02f05a63          	blez	a5,5364 <printint+0x8a>
    5334:	fc26                	sd	s1,56(sp)
    5336:	f44e                	sd	s3,40(sp)
    5338:	fb840713          	addi	a4,s0,-72
    533c:	00f704b3          	add	s1,a4,a5
    5340:	fff70993          	addi	s3,a4,-1
    5344:	99be                	add	s3,s3,a5
    5346:	37fd                	addiw	a5,a5,-1
    5348:	1782                	slli	a5,a5,0x20
    534a:	9381                	srli	a5,a5,0x20
    534c:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
    5350:	fff4c583          	lbu	a1,-1(s1)
    5354:	854a                	mv	a0,s2
    5356:	f67ff0ef          	jal	52bc <putc>
  while (--i >= 0)
    535a:	14fd                	addi	s1,s1,-1
    535c:	ff349ae3          	bne	s1,s3,5350 <printint+0x76>
    5360:	74e2                	ld	s1,56(sp)
    5362:	79a2                	ld	s3,40(sp)
}
    5364:	60a6                	ld	ra,72(sp)
    5366:	6406                	ld	s0,64(sp)
    5368:	7942                	ld	s2,48(sp)
    536a:	6161                	addi	sp,sp,80
    536c:	8082                	ret
    x = -xx;
    536e:	40b005b3          	neg	a1,a1
    neg = 1;
    5372:	4885                	li	a7,1
    x = -xx;
    5374:	bfad                	j	52ee <printint+0x14>

0000000000005376 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5376:	711d                	addi	sp,sp,-96
    5378:	ec86                	sd	ra,88(sp)
    537a:	e8a2                	sd	s0,80(sp)
    537c:	e0ca                	sd	s2,64(sp)
    537e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
    5380:	0005c903          	lbu	s2,0(a1)
    5384:	28090663          	beqz	s2,5610 <vprintf+0x29a>
    5388:	e4a6                	sd	s1,72(sp)
    538a:	fc4e                	sd	s3,56(sp)
    538c:	f852                	sd	s4,48(sp)
    538e:	f456                	sd	s5,40(sp)
    5390:	f05a                	sd	s6,32(sp)
    5392:	ec5e                	sd	s7,24(sp)
    5394:	e862                	sd	s8,16(sp)
    5396:	e466                	sd	s9,8(sp)
    5398:	8b2a                	mv	s6,a0
    539a:	8a2e                	mv	s4,a1
    539c:	8bb2                	mv	s7,a2
  state = 0;
    539e:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
    53a0:	4481                	li	s1,0
    53a2:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
    53a4:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
    53a8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
    53ac:	06c00c93          	li	s9,108
    53b0:	a005                	j	53d0 <vprintf+0x5a>
        putc(fd, c0);
    53b2:	85ca                	mv	a1,s2
    53b4:	855a                	mv	a0,s6
    53b6:	f07ff0ef          	jal	52bc <putc>
    53ba:	a019                	j	53c0 <vprintf+0x4a>
    } else if (state == '%') {
    53bc:	03598263          	beq	s3,s5,53e0 <vprintf+0x6a>
  for (i = 0; fmt[i]; i++) {
    53c0:	2485                	addiw	s1,s1,1
    53c2:	8726                	mv	a4,s1
    53c4:	009a07b3          	add	a5,s4,s1
    53c8:	0007c903          	lbu	s2,0(a5)
    53cc:	22090a63          	beqz	s2,5600 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
    53d0:	0009079b          	sext.w	a5,s2
    if (state == 0) {
    53d4:	fe0994e3          	bnez	s3,53bc <vprintf+0x46>
      if (c0 == '%') {
    53d8:	fd579de3          	bne	a5,s5,53b2 <vprintf+0x3c>
        state = '%';
    53dc:	89be                	mv	s3,a5
    53de:	b7cd                	j	53c0 <vprintf+0x4a>
        c1 = fmt[i + 1] & 0xff;
    53e0:	00ea06b3          	add	a3,s4,a4
    53e4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
    53e8:	8636                	mv	a2,a3
      if (c1)
    53ea:	c681                	beqz	a3,53f2 <vprintf+0x7c>
        c2 = fmt[i + 2] & 0xff;
    53ec:	9752                	add	a4,a4,s4
    53ee:	00274603          	lbu	a2,2(a4)
      if (c0 == 'd') {
    53f2:	05878363          	beq	a5,s8,5438 <vprintf+0xc2>
      } else if (c0 == 'l' && c1 == 'd') {
    53f6:	05978d63          	beq	a5,s9,5450 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
    53fa:	07500713          	li	a4,117
    53fe:	0ee78763          	beq	a5,a4,54ec <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
    5402:	07800713          	li	a4,120
    5406:	12e78963          	beq	a5,a4,5538 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
    540a:	07000713          	li	a4,112
    540e:	14e78e63          	beq	a5,a4,556a <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
    5412:	06300713          	li	a4,99
    5416:	18e78e63          	beq	a5,a4,55b2 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
    541a:	07300713          	li	a4,115
    541e:	1ae78463          	beq	a5,a4,55c6 <vprintf+0x250>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
    5422:	02500713          	li	a4,37
    5426:	04e79563          	bne	a5,a4,5470 <vprintf+0xfa>
        putc(fd, '%');
    542a:	02500593          	li	a1,37
    542e:	855a                	mv	a0,s6
    5430:	e8dff0ef          	jal	52bc <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
    5434:	4981                	li	s3,0
    5436:	b769                	j	53c0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
    5438:	008b8913          	addi	s2,s7,8
    543c:	4685                	li	a3,1
    543e:	4629                	li	a2,10
    5440:	000ba583          	lw	a1,0(s7)
    5444:	855a                	mv	a0,s6
    5446:	e95ff0ef          	jal	52da <printint>
    544a:	8bca                	mv	s7,s2
      state = 0;
    544c:	4981                	li	s3,0
    544e:	bf8d                	j	53c0 <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'd') {
    5450:	06400793          	li	a5,100
    5454:	02f68963          	beq	a3,a5,5486 <vprintf+0x110>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    5458:	06c00793          	li	a5,108
    545c:	04f68263          	beq	a3,a5,54a0 <vprintf+0x12a>
      } else if (c0 == 'l' && c1 == 'u') {
    5460:	07500793          	li	a5,117
    5464:	0af68063          	beq	a3,a5,5504 <vprintf+0x18e>
      } else if (c0 == 'l' && c1 == 'x') {
    5468:	07800793          	li	a5,120
    546c:	0ef68263          	beq	a3,a5,5550 <vprintf+0x1da>
        putc(fd, '%');
    5470:	02500593          	li	a1,37
    5474:	855a                	mv	a0,s6
    5476:	e47ff0ef          	jal	52bc <putc>
        putc(fd, c0);
    547a:	85ca                	mv	a1,s2
    547c:	855a                	mv	a0,s6
    547e:	e3fff0ef          	jal	52bc <putc>
      state = 0;
    5482:	4981                	li	s3,0
    5484:	bf35                	j	53c0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    5486:	008b8913          	addi	s2,s7,8
    548a:	4685                	li	a3,1
    548c:	4629                	li	a2,10
    548e:	000bb583          	ld	a1,0(s7)
    5492:	855a                	mv	a0,s6
    5494:	e47ff0ef          	jal	52da <printint>
        i += 1;
    5498:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    549a:	8bca                	mv	s7,s2
      state = 0;
    549c:	4981                	li	s3,0
        i += 1;
    549e:	b70d                	j	53c0 <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
    54a0:	06400793          	li	a5,100
    54a4:	02f60763          	beq	a2,a5,54d2 <vprintf+0x15c>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
    54a8:	07500793          	li	a5,117
    54ac:	06f60963          	beq	a2,a5,551e <vprintf+0x1a8>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
    54b0:	07800793          	li	a5,120
    54b4:	faf61ee3          	bne	a2,a5,5470 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
    54b8:	008b8913          	addi	s2,s7,8
    54bc:	4681                	li	a3,0
    54be:	4641                	li	a2,16
    54c0:	000bb583          	ld	a1,0(s7)
    54c4:	855a                	mv	a0,s6
    54c6:	e15ff0ef          	jal	52da <printint>
        i += 2;
    54ca:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    54cc:	8bca                	mv	s7,s2
      state = 0;
    54ce:	4981                	li	s3,0
        i += 2;
    54d0:	bdc5                	j	53c0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    54d2:	008b8913          	addi	s2,s7,8
    54d6:	4685                	li	a3,1
    54d8:	4629                	li	a2,10
    54da:	000bb583          	ld	a1,0(s7)
    54de:	855a                	mv	a0,s6
    54e0:	dfbff0ef          	jal	52da <printint>
        i += 2;
    54e4:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    54e6:	8bca                	mv	s7,s2
      state = 0;
    54e8:	4981                	li	s3,0
        i += 2;
    54ea:	bdd9                	j	53c0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
    54ec:	008b8913          	addi	s2,s7,8
    54f0:	4681                	li	a3,0
    54f2:	4629                	li	a2,10
    54f4:	000be583          	lwu	a1,0(s7)
    54f8:	855a                	mv	a0,s6
    54fa:	de1ff0ef          	jal	52da <printint>
    54fe:	8bca                	mv	s7,s2
      state = 0;
    5500:	4981                	li	s3,0
    5502:	bd7d                	j	53c0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5504:	008b8913          	addi	s2,s7,8
    5508:	4681                	li	a3,0
    550a:	4629                	li	a2,10
    550c:	000bb583          	ld	a1,0(s7)
    5510:	855a                	mv	a0,s6
    5512:	dc9ff0ef          	jal	52da <printint>
        i += 1;
    5516:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    5518:	8bca                	mv	s7,s2
      state = 0;
    551a:	4981                	li	s3,0
        i += 1;
    551c:	b555                	j	53c0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    551e:	008b8913          	addi	s2,s7,8
    5522:	4681                	li	a3,0
    5524:	4629                	li	a2,10
    5526:	000bb583          	ld	a1,0(s7)
    552a:	855a                	mv	a0,s6
    552c:	dafff0ef          	jal	52da <printint>
        i += 2;
    5530:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    5532:	8bca                	mv	s7,s2
      state = 0;
    5534:	4981                	li	s3,0
        i += 2;
    5536:	b569                	j	53c0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
    5538:	008b8913          	addi	s2,s7,8
    553c:	4681                	li	a3,0
    553e:	4641                	li	a2,16
    5540:	000be583          	lwu	a1,0(s7)
    5544:	855a                	mv	a0,s6
    5546:	d95ff0ef          	jal	52da <printint>
    554a:	8bca                	mv	s7,s2
      state = 0;
    554c:	4981                	li	s3,0
    554e:	bd8d                	j	53c0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    5550:	008b8913          	addi	s2,s7,8
    5554:	4681                	li	a3,0
    5556:	4641                	li	a2,16
    5558:	000bb583          	ld	a1,0(s7)
    555c:	855a                	mv	a0,s6
    555e:	d7dff0ef          	jal	52da <printint>
        i += 1;
    5562:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    5564:	8bca                	mv	s7,s2
      state = 0;
    5566:	4981                	li	s3,0
        i += 1;
    5568:	bda1                	j	53c0 <vprintf+0x4a>
    556a:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    556c:	008b8d13          	addi	s10,s7,8
    5570:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    5574:	03000593          	li	a1,48
    5578:	855a                	mv	a0,s6
    557a:	d43ff0ef          	jal	52bc <putc>
  putc(fd, 'x');
    557e:	07800593          	li	a1,120
    5582:	855a                	mv	a0,s6
    5584:	d39ff0ef          	jal	52bc <putc>
    5588:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    558a:	00003b97          	auipc	s7,0x3
    558e:	b46b8b93          	addi	s7,s7,-1210 # 80d0 <digits>
    5592:	03c9d793          	srli	a5,s3,0x3c
    5596:	97de                	add	a5,a5,s7
    5598:	0007c583          	lbu	a1,0(a5)
    559c:	855a                	mv	a0,s6
    559e:	d1fff0ef          	jal	52bc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    55a2:	0992                	slli	s3,s3,0x4
    55a4:	397d                	addiw	s2,s2,-1
    55a6:	fe0916e3          	bnez	s2,5592 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
    55aa:	8bea                	mv	s7,s10
      state = 0;
    55ac:	4981                	li	s3,0
    55ae:	6d02                	ld	s10,0(sp)
    55b0:	bd01                	j	53c0 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
    55b2:	008b8913          	addi	s2,s7,8
    55b6:	000bc583          	lbu	a1,0(s7)
    55ba:	855a                	mv	a0,s6
    55bc:	d01ff0ef          	jal	52bc <putc>
    55c0:	8bca                	mv	s7,s2
      state = 0;
    55c2:	4981                	li	s3,0
    55c4:	bbf5                	j	53c0 <vprintf+0x4a>
        if ((s = va_arg(ap, char *)) == 0)
    55c6:	008b8993          	addi	s3,s7,8
    55ca:	000bb903          	ld	s2,0(s7)
    55ce:	00090f63          	beqz	s2,55ec <vprintf+0x276>
        for (; *s; s++)
    55d2:	00094583          	lbu	a1,0(s2)
    55d6:	c195                	beqz	a1,55fa <vprintf+0x284>
          putc(fd, *s);
    55d8:	855a                	mv	a0,s6
    55da:	ce3ff0ef          	jal	52bc <putc>
        for (; *s; s++)
    55de:	0905                	addi	s2,s2,1
    55e0:	00094583          	lbu	a1,0(s2)
    55e4:	f9f5                	bnez	a1,55d8 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
    55e6:	8bce                	mv	s7,s3
      state = 0;
    55e8:	4981                	li	s3,0
    55ea:	bbd9                	j	53c0 <vprintf+0x4a>
          s = "(null)";
    55ec:	00003917          	auipc	s2,0x3
    55f0:	a3490913          	addi	s2,s2,-1484 # 8020 <malloc+0x2928>
        for (; *s; s++)
    55f4:	02800593          	li	a1,40
    55f8:	b7c5                	j	55d8 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
    55fa:	8bce                	mv	s7,s3
      state = 0;
    55fc:	4981                	li	s3,0
    55fe:	b3c9                	j	53c0 <vprintf+0x4a>
    5600:	64a6                	ld	s1,72(sp)
    5602:	79e2                	ld	s3,56(sp)
    5604:	7a42                	ld	s4,48(sp)
    5606:	7aa2                	ld	s5,40(sp)
    5608:	7b02                	ld	s6,32(sp)
    560a:	6be2                	ld	s7,24(sp)
    560c:	6c42                	ld	s8,16(sp)
    560e:	6ca2                	ld	s9,8(sp)
    }
  }
}
    5610:	60e6                	ld	ra,88(sp)
    5612:	6446                	ld	s0,80(sp)
    5614:	6906                	ld	s2,64(sp)
    5616:	6125                	addi	sp,sp,96
    5618:	8082                	ret

000000000000561a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    561a:	715d                	addi	sp,sp,-80
    561c:	ec06                	sd	ra,24(sp)
    561e:	e822                	sd	s0,16(sp)
    5620:	1000                	addi	s0,sp,32
    5622:	e010                	sd	a2,0(s0)
    5624:	e414                	sd	a3,8(s0)
    5626:	e818                	sd	a4,16(s0)
    5628:	ec1c                	sd	a5,24(s0)
    562a:	03043023          	sd	a6,32(s0)
    562e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5632:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5636:	8622                	mv	a2,s0
    5638:	d3fff0ef          	jal	5376 <vprintf>
}
    563c:	60e2                	ld	ra,24(sp)
    563e:	6442                	ld	s0,16(sp)
    5640:	6161                	addi	sp,sp,80
    5642:	8082                	ret

0000000000005644 <printf>:

void
printf(const char *fmt, ...)
{
    5644:	711d                	addi	sp,sp,-96
    5646:	ec06                	sd	ra,24(sp)
    5648:	e822                	sd	s0,16(sp)
    564a:	1000                	addi	s0,sp,32
    564c:	e40c                	sd	a1,8(s0)
    564e:	e810                	sd	a2,16(s0)
    5650:	ec14                	sd	a3,24(s0)
    5652:	f018                	sd	a4,32(s0)
    5654:	f41c                	sd	a5,40(s0)
    5656:	03043823          	sd	a6,48(s0)
    565a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    565e:	00840613          	addi	a2,s0,8
    5662:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5666:	85aa                	mv	a1,a0
    5668:	4505                	li	a0,1
    566a:	d0dff0ef          	jal	5376 <vprintf>
}
    566e:	60e2                	ld	ra,24(sp)
    5670:	6442                	ld	s0,16(sp)
    5672:	6125                	addi	sp,sp,96
    5674:	8082                	ret

0000000000005676 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5676:	1141                	addi	sp,sp,-16
    5678:	e422                	sd	s0,8(sp)
    567a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
    567c:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5680:	00005797          	auipc	a5,0x5
    5684:	e407b783          	ld	a5,-448(a5) # a4c0 <freep>
    5688:	a02d                	j	56b2 <free+0x3c>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
    bp->s.size += p->s.ptr->s.size;
    568a:	4618                	lw	a4,8(a2)
    568c:	9f2d                	addw	a4,a4,a1
    568e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5692:	6398                	ld	a4,0(a5)
    5694:	6310                	ld	a2,0(a4)
    5696:	a83d                	j	56d4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    p->s.size += bp->s.size;
    5698:	ff852703          	lw	a4,-8(a0)
    569c:	9f31                	addw	a4,a4,a2
    569e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    56a0:	ff053683          	ld	a3,-16(a0)
    56a4:	a091                	j	56e8 <free+0x72>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    56a6:	6398                	ld	a4,0(a5)
    56a8:	00e7e463          	bltu	a5,a4,56b0 <free+0x3a>
    56ac:	00e6ea63          	bltu	a3,a4,56c0 <free+0x4a>
{
    56b0:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    56b2:	fed7fae3          	bgeu	a5,a3,56a6 <free+0x30>
    56b6:	6398                	ld	a4,0(a5)
    56b8:	00e6e463          	bltu	a3,a4,56c0 <free+0x4a>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    56bc:	fee7eae3          	bltu	a5,a4,56b0 <free+0x3a>
  if (bp + bp->s.size == p->s.ptr) {
    56c0:	ff852583          	lw	a1,-8(a0)
    56c4:	6390                	ld	a2,0(a5)
    56c6:	02059813          	slli	a6,a1,0x20
    56ca:	01c85713          	srli	a4,a6,0x1c
    56ce:	9736                	add	a4,a4,a3
    56d0:	fae60de3          	beq	a2,a4,568a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    56d4:	fec53823          	sd	a2,-16(a0)
  if (p + p->s.size == bp) {
    56d8:	4790                	lw	a2,8(a5)
    56da:	02061593          	slli	a1,a2,0x20
    56de:	01c5d713          	srli	a4,a1,0x1c
    56e2:	973e                	add	a4,a4,a5
    56e4:	fae68ae3          	beq	a3,a4,5698 <free+0x22>
    p->s.ptr = bp->s.ptr;
    56e8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    56ea:	00005717          	auipc	a4,0x5
    56ee:	dcf73b23          	sd	a5,-554(a4) # a4c0 <freep>
}
    56f2:	6422                	ld	s0,8(sp)
    56f4:	0141                	addi	sp,sp,16
    56f6:	8082                	ret

00000000000056f8 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
    56f8:	7139                	addi	sp,sp,-64
    56fa:	fc06                	sd	ra,56(sp)
    56fc:	f822                	sd	s0,48(sp)
    56fe:	f426                	sd	s1,40(sp)
    5700:	ec4e                	sd	s3,24(sp)
    5702:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    5704:	02051493          	slli	s1,a0,0x20
    5708:	9081                	srli	s1,s1,0x20
    570a:	04bd                	addi	s1,s1,15
    570c:	8091                	srli	s1,s1,0x4
    570e:	0014899b          	addiw	s3,s1,1
    5712:	0485                	addi	s1,s1,1
  if ((prevp = freep) == 0) {
    5714:	00005517          	auipc	a0,0x5
    5718:	dac53503          	ld	a0,-596(a0) # a4c0 <freep>
    571c:	c915                	beqz	a0,5750 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    571e:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    5720:	4798                	lw	a4,8(a5)
    5722:	08977a63          	bgeu	a4,s1,57b6 <malloc+0xbe>
    5726:	f04a                	sd	s2,32(sp)
    5728:	e852                	sd	s4,16(sp)
    572a:	e456                	sd	s5,8(sp)
    572c:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
    572e:	8a4e                	mv	s4,s3
    5730:	0009871b          	sext.w	a4,s3
    5734:	6685                	lui	a3,0x1
    5736:	00d77363          	bgeu	a4,a3,573c <malloc+0x44>
    573a:	6a05                	lui	s4,0x1
    573c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    5740:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
    5744:	00005917          	auipc	s2,0x5
    5748:	d7c90913          	addi	s2,s2,-644 # a4c0 <freep>
  if (p == SBRK_ERROR)
    574c:	5afd                	li	s5,-1
    574e:	a081                	j	578e <malloc+0x96>
    5750:	f04a                	sd	s2,32(sp)
    5752:	e852                	sd	s4,16(sp)
    5754:	e456                	sd	s5,8(sp)
    5756:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    5758:	0000b797          	auipc	a5,0xb
    575c:	59078793          	addi	a5,a5,1424 # 10ce8 <base>
    5760:	00005717          	auipc	a4,0x5
    5764:	d6f73023          	sd	a5,-672(a4) # a4c0 <freep>
    5768:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    576a:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
    576e:	b7c1                	j	572e <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    5770:	6398                	ld	a4,0(a5)
    5772:	e118                	sd	a4,0(a0)
    5774:	a8a9                	j	57ce <malloc+0xd6>
  hp->s.size = nu;
    5776:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
    577a:	0541                	addi	a0,a0,16
    577c:	efbff0ef          	jal	5676 <free>
  return freep;
    5780:	00093503          	ld	a0,0(s2)
      if ((p = morecore(nunits)) == 0)
    5784:	c12d                	beqz	a0,57e6 <malloc+0xee>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    5786:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
    5788:	4798                	lw	a4,8(a5)
    578a:	02977263          	bgeu	a4,s1,57ae <malloc+0xb6>
    if (p == freep)
    578e:	00093703          	ld	a4,0(s2)
    5792:	853e                	mv	a0,a5
    5794:	fef719e3          	bne	a4,a5,5786 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    5798:	8552                	mv	a0,s4
    579a:	a47ff0ef          	jal	51e0 <sbrk>
  if (p == SBRK_ERROR)
    579e:	fd551ce3          	bne	a0,s5,5776 <malloc+0x7e>
        return 0;
    57a2:	4501                	li	a0,0
    57a4:	7902                	ld	s2,32(sp)
    57a6:	6a42                	ld	s4,16(sp)
    57a8:	6aa2                	ld	s5,8(sp)
    57aa:	6b02                	ld	s6,0(sp)
    57ac:	a03d                	j	57da <malloc+0xe2>
    57ae:	7902                	ld	s2,32(sp)
    57b0:	6a42                	ld	s4,16(sp)
    57b2:	6aa2                	ld	s5,8(sp)
    57b4:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
    57b6:	fae48de3          	beq	s1,a4,5770 <malloc+0x78>
        p->s.size -= nunits;
    57ba:	4137073b          	subw	a4,a4,s3
    57be:	c798                	sw	a4,8(a5)
        p += p->s.size;
    57c0:	02071693          	slli	a3,a4,0x20
    57c4:	01c6d713          	srli	a4,a3,0x1c
    57c8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    57ca:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    57ce:	00005717          	auipc	a4,0x5
    57d2:	cea73923          	sd	a0,-782(a4) # a4c0 <freep>
      return (void *)(p + 1);
    57d6:	01078513          	addi	a0,a5,16
  }
}
    57da:	70e2                	ld	ra,56(sp)
    57dc:	7442                	ld	s0,48(sp)
    57de:	74a2                	ld	s1,40(sp)
    57e0:	69e2                	ld	s3,24(sp)
    57e2:	6121                	addi	sp,sp,64
    57e4:	8082                	ret
    57e6:	7902                	ld	s2,32(sp)
    57e8:	6a42                	ld	s4,16(sp)
    57ea:	6aa2                	ld	s5,8(sp)
    57ec:	6b02                	ld	s6,0(sp)
    57ee:	b7f5                	j	57da <malloc+0xe2>
