
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <hijos_recursivos>:
// Lo que se debe hacer recursivamente es ver si el padre le paso elementos, en caso afirmativo imprimir el primer numero y filtrar los demas hasta que no se lean mas elementos
// en caso de que no se le haya pasado nada simplemente termina
// se le entregará pipe modo lectura, porque el hijo solo necesita leer los datos actuales del pipe y manejarlos, el hijo no escribe sobre el pipe que le pasó el padre
int
hijos_recursivos(int pipeX)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	addi	s0,sp,48
   a:	84aa                	mv	s1,a0
  int primo;
  int pid;
  int numero_restante;
  // Hay elementos en el pipe que comunica con el padre
  if (read(pipeX, &primo, 4) > 0) {
   c:	4611                	li	a2,4
   e:	fdc40593          	addi	a1,s0,-36
  12:	3ba000ef          	jal	3cc <read>
  16:	06a05763          	blez	a0,84 <hijos_recursivos+0x84>
    // Primer numero siempre primo
    printf("prime %d\n", primo);
  1a:	fdc42583          	lw	a1,-36(s0)
  1e:	00001517          	auipc	a0,0x1
  22:	97250513          	addi	a0,a0,-1678 # 990 <malloc+0xf8>
  26:	7be000ef          	jal	7e4 <printf>
    int pipe_hijo[2];
    pipe(pipe_hijo);
  2a:	fd040513          	addi	a0,s0,-48
  2e:	396000ef          	jal	3c4 <pipe>
    // Hijo crea un hijo
    pid = fork();
  32:	37a000ef          	jal	3ac <fork>
    // Padre debe filtrar los datos restantes del pipe y enviarselos a su hijo
    if (pid > 0) {
  36:	04a05d63          	blez	a0,90 <hijos_recursivos+0x90>
      // Solo se escribirá asique se debe cerrar la lectura
      // Se recorre toda la pipe actual y se crea la pipe con el hijo donde solamente se guardan los no-multiplos del primo que se imprimió
      close(pipe_hijo[0]);
  3a:	fd042503          	lw	a0,-48(s0)
  3e:	39e000ef          	jal	3dc <close>
      while (read(pipeX, &numero_restante, 4) > 0) {
  42:	4611                	li	a2,4
  44:	fd840593          	addi	a1,s0,-40
  48:	8526                	mv	a0,s1
  4a:	382000ef          	jal	3cc <read>
  4e:	02a05163          	blez	a0,70 <hijos_recursivos+0x70>
        // Si no es multiplo del primo que leyó, se envia por la pipe al hijo
        if (numero_restante % primo != 0) {
  52:	fd842783          	lw	a5,-40(s0)
  56:	fdc42703          	lw	a4,-36(s0)
  5a:	02e7e7bb          	remw	a5,a5,a4
  5e:	d3f5                	beqz	a5,42 <hijos_recursivos+0x42>
          write(pipe_hijo[1], &numero_restante, 4);
  60:	4611                	li	a2,4
  62:	fd840593          	addi	a1,s0,-40
  66:	fd442503          	lw	a0,-44(s0)
  6a:	36a000ef          	jal	3d4 <write>
  6e:	bfd1                	j	42 <hijos_recursivos+0x42>
        }
      }
      close(pipe_hijo[1]);
  70:	fd442503          	lw	a0,-44(s0)
  74:	368000ef          	jal	3dc <close>
      close(pipeX);
  78:	8526                	mv	a0,s1
  7a:	362000ef          	jal	3dc <close>
      // Para esperar a que el hijo termine de ejecutarse
      wait(0);
  7e:	4501                	li	a0,0
  80:	33c000ef          	jal	3bc <wait>
    }
  } else {
    return 0;
  }
  return 0;
}
  84:	4501                	li	a0,0
  86:	70a2                	ld	ra,40(sp)
  88:	7402                	ld	s0,32(sp)
  8a:	64e2                	ld	s1,24(sp)
  8c:	6145                	addi	sp,sp,48
  8e:	8082                	ret
      close(pipeX);
  90:	8526                	mv	a0,s1
  92:	34a000ef          	jal	3dc <close>
      close(pipe_hijo[1]);
  96:	fd442503          	lw	a0,-44(s0)
  9a:	342000ef          	jal	3dc <close>
      hijos_recursivos(pipe_hijo[0]);
  9e:	fd042503          	lw	a0,-48(s0)
  a2:	f5fff0ef          	jal	0 <hijos_recursivos>
  return 0;
  a6:	bff9                	j	84 <hijos_recursivos+0x84>

00000000000000a8 <main>:

int
main(int argc, char *argv[])
{
  a8:	7179                	addi	sp,sp,-48
  aa:	f406                	sd	ra,40(sp)
  ac:	f022                	sd	s0,32(sp)
  ae:	1800                	addi	s0,sp,48
  int fd[2];
  // Se crea el pipe donde se van enviando todos los numeros
  pipe(fd);
  b0:	fd840513          	addi	a0,s0,-40
  b4:	310000ef          	jal	3c4 <pipe>
  int pid;
  pid = fork();
  b8:	2f4000ef          	jal	3ac <fork>
  if (pid > 0) {
  bc:	04a05963          	blez	a0,10e <main+0x66>
  c0:	ec26                	sd	s1,24(sp)
    close(fd[0]);
  c2:	fd842503          	lw	a0,-40(s0)
  c6:	316000ef          	jal	3dc <close>
    for (int numero_actual = 2; numero_actual <= 35; numero_actual++) {
  ca:	4789                	li	a5,2
  cc:	fcf42a23          	sw	a5,-44(s0)
  d0:	02300493          	li	s1,35

      // Se escriben todos los numeros en el pipe
      write(fd[1], &numero_actual, 4);
  d4:	4611                	li	a2,4
  d6:	fd440593          	addi	a1,s0,-44
  da:	fdc42503          	lw	a0,-36(s0)
  de:	2f6000ef          	jal	3d4 <write>
    for (int numero_actual = 2; numero_actual <= 35; numero_actual++) {
  e2:	fd442783          	lw	a5,-44(s0)
  e6:	2785                	addiw	a5,a5,1
  e8:	0007871b          	sext.w	a4,a5
  ec:	fcf42a23          	sw	a5,-44(s0)
  f0:	fee4d2e3          	bge	s1,a4,d4 <main+0x2c>
    }
    close(fd[1]);
  f4:	fdc42503          	lw	a0,-36(s0)
  f8:	2e4000ef          	jal	3dc <close>
    // Para que termine de ejecutarse el hijo
    wait(0);
  fc:	4501                	li	a0,0
  fe:	2be000ef          	jal	3bc <wait>
 102:	64e2                	ld	s1,24(sp)
    close(fd[1]);
    // lectura pipe padre
    hijos_recursivos(fd[0]);
  }
  return 0;
}
 104:	4501                	li	a0,0
 106:	70a2                	ld	ra,40(sp)
 108:	7402                	ld	s0,32(sp)
 10a:	6145                	addi	sp,sp,48
 10c:	8082                	ret
    close(fd[1]);
 10e:	fdc42503          	lw	a0,-36(s0)
 112:	2ca000ef          	jal	3dc <close>
    hijos_recursivos(fd[0]);
 116:	fd842503          	lw	a0,-40(s0)
 11a:	ee7ff0ef          	jal	0 <hijos_recursivos>
 11e:	b7dd                	j	104 <main+0x5c>

0000000000000120 <start>:
 120:	1141                	addi	sp,sp,-16
 122:	e406                	sd	ra,8(sp)
 124:	e022                	sd	s0,0(sp)
 126:	0800                	addi	s0,sp,16
 128:	f81ff0ef          	jal	a8 <main>
 12c:	288000ef          	jal	3b4 <exit>

0000000000000130 <strcpy>:
 130:	1141                	addi	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	addi	s0,sp,16
 136:	87aa                	mv	a5,a0
 138:	0585                	addi	a1,a1,1
 13a:	0785                	addi	a5,a5,1
 13c:	fff5c703          	lbu	a4,-1(a1)
 140:	fee78fa3          	sb	a4,-1(a5)
 144:	fb75                	bnez	a4,138 <strcpy+0x8>
 146:	6422                	ld	s0,8(sp)
 148:	0141                	addi	sp,sp,16
 14a:	8082                	ret

000000000000014c <strcmp>:
 14c:	1141                	addi	sp,sp,-16
 14e:	e422                	sd	s0,8(sp)
 150:	0800                	addi	s0,sp,16
 152:	00054783          	lbu	a5,0(a0)
 156:	cb91                	beqz	a5,16a <strcmp+0x1e>
 158:	0005c703          	lbu	a4,0(a1)
 15c:	00f71763          	bne	a4,a5,16a <strcmp+0x1e>
 160:	0505                	addi	a0,a0,1
 162:	0585                	addi	a1,a1,1
 164:	00054783          	lbu	a5,0(a0)
 168:	fbe5                	bnez	a5,158 <strcmp+0xc>
 16a:	0005c503          	lbu	a0,0(a1)
 16e:	40a7853b          	subw	a0,a5,a0
 172:	6422                	ld	s0,8(sp)
 174:	0141                	addi	sp,sp,16
 176:	8082                	ret

0000000000000178 <strlen>:
 178:	1141                	addi	sp,sp,-16
 17a:	e422                	sd	s0,8(sp)
 17c:	0800                	addi	s0,sp,16
 17e:	00054783          	lbu	a5,0(a0)
 182:	cf91                	beqz	a5,19e <strlen+0x26>
 184:	0505                	addi	a0,a0,1
 186:	87aa                	mv	a5,a0
 188:	86be                	mv	a3,a5
 18a:	0785                	addi	a5,a5,1
 18c:	fff7c703          	lbu	a4,-1(a5)
 190:	ff65                	bnez	a4,188 <strlen+0x10>
 192:	40a6853b          	subw	a0,a3,a0
 196:	2505                	addiw	a0,a0,1
 198:	6422                	ld	s0,8(sp)
 19a:	0141                	addi	sp,sp,16
 19c:	8082                	ret
 19e:	4501                	li	a0,0
 1a0:	bfe5                	j	198 <strlen+0x20>

00000000000001a2 <memset>:
 1a2:	1141                	addi	sp,sp,-16
 1a4:	e422                	sd	s0,8(sp)
 1a6:	0800                	addi	s0,sp,16
 1a8:	ca19                	beqz	a2,1be <memset+0x1c>
 1aa:	87aa                	mv	a5,a0
 1ac:	1602                	slli	a2,a2,0x20
 1ae:	9201                	srli	a2,a2,0x20
 1b0:	00a60733          	add	a4,a2,a0
 1b4:	00b78023          	sb	a1,0(a5)
 1b8:	0785                	addi	a5,a5,1
 1ba:	fee79de3          	bne	a5,a4,1b4 <memset+0x12>
 1be:	6422                	ld	s0,8(sp)
 1c0:	0141                	addi	sp,sp,16
 1c2:	8082                	ret

00000000000001c4 <strchr>:
 1c4:	1141                	addi	sp,sp,-16
 1c6:	e422                	sd	s0,8(sp)
 1c8:	0800                	addi	s0,sp,16
 1ca:	00054783          	lbu	a5,0(a0)
 1ce:	cb99                	beqz	a5,1e4 <strchr+0x20>
 1d0:	00f58763          	beq	a1,a5,1de <strchr+0x1a>
 1d4:	0505                	addi	a0,a0,1
 1d6:	00054783          	lbu	a5,0(a0)
 1da:	fbfd                	bnez	a5,1d0 <strchr+0xc>
 1dc:	4501                	li	a0,0
 1de:	6422                	ld	s0,8(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret
 1e4:	4501                	li	a0,0
 1e6:	bfe5                	j	1de <strchr+0x1a>

00000000000001e8 <gets>:
 1e8:	711d                	addi	sp,sp,-96
 1ea:	ec86                	sd	ra,88(sp)
 1ec:	e8a2                	sd	s0,80(sp)
 1ee:	e4a6                	sd	s1,72(sp)
 1f0:	e0ca                	sd	s2,64(sp)
 1f2:	fc4e                	sd	s3,56(sp)
 1f4:	f852                	sd	s4,48(sp)
 1f6:	f456                	sd	s5,40(sp)
 1f8:	f05a                	sd	s6,32(sp)
 1fa:	ec5e                	sd	s7,24(sp)
 1fc:	1080                	addi	s0,sp,96
 1fe:	8baa                	mv	s7,a0
 200:	8a2e                	mv	s4,a1
 202:	892a                	mv	s2,a0
 204:	4481                	li	s1,0
 206:	4aa9                	li	s5,10
 208:	4b35                	li	s6,13
 20a:	89a6                	mv	s3,s1
 20c:	2485                	addiw	s1,s1,1
 20e:	0344d663          	bge	s1,s4,23a <gets+0x52>
 212:	4605                	li	a2,1
 214:	faf40593          	addi	a1,s0,-81
 218:	4501                	li	a0,0
 21a:	1b2000ef          	jal	3cc <read>
 21e:	00a05e63          	blez	a0,23a <gets+0x52>
 222:	faf44783          	lbu	a5,-81(s0)
 226:	00f90023          	sb	a5,0(s2)
 22a:	01578763          	beq	a5,s5,238 <gets+0x50>
 22e:	0905                	addi	s2,s2,1
 230:	fd679de3          	bne	a5,s6,20a <gets+0x22>
 234:	89a6                	mv	s3,s1
 236:	a011                	j	23a <gets+0x52>
 238:	89a6                	mv	s3,s1
 23a:	99de                	add	s3,s3,s7
 23c:	00098023          	sb	zero,0(s3)
 240:	855e                	mv	a0,s7
 242:	60e6                	ld	ra,88(sp)
 244:	6446                	ld	s0,80(sp)
 246:	64a6                	ld	s1,72(sp)
 248:	6906                	ld	s2,64(sp)
 24a:	79e2                	ld	s3,56(sp)
 24c:	7a42                	ld	s4,48(sp)
 24e:	7aa2                	ld	s5,40(sp)
 250:	7b02                	ld	s6,32(sp)
 252:	6be2                	ld	s7,24(sp)
 254:	6125                	addi	sp,sp,96
 256:	8082                	ret

0000000000000258 <stat>:
 258:	1101                	addi	sp,sp,-32
 25a:	ec06                	sd	ra,24(sp)
 25c:	e822                	sd	s0,16(sp)
 25e:	e04a                	sd	s2,0(sp)
 260:	1000                	addi	s0,sp,32
 262:	892e                	mv	s2,a1
 264:	4581                	li	a1,0
 266:	18e000ef          	jal	3f4 <open>
 26a:	02054263          	bltz	a0,28e <stat+0x36>
 26e:	e426                	sd	s1,8(sp)
 270:	84aa                	mv	s1,a0
 272:	85ca                	mv	a1,s2
 274:	198000ef          	jal	40c <fstat>
 278:	892a                	mv	s2,a0
 27a:	8526                	mv	a0,s1
 27c:	160000ef          	jal	3dc <close>
 280:	64a2                	ld	s1,8(sp)
 282:	854a                	mv	a0,s2
 284:	60e2                	ld	ra,24(sp)
 286:	6442                	ld	s0,16(sp)
 288:	6902                	ld	s2,0(sp)
 28a:	6105                	addi	sp,sp,32
 28c:	8082                	ret
 28e:	597d                	li	s2,-1
 290:	bfcd                	j	282 <stat+0x2a>

0000000000000292 <atoi>:
 292:	1141                	addi	sp,sp,-16
 294:	e422                	sd	s0,8(sp)
 296:	0800                	addi	s0,sp,16
 298:	00054683          	lbu	a3,0(a0)
 29c:	fd06879b          	addiw	a5,a3,-48
 2a0:	0ff7f793          	zext.b	a5,a5
 2a4:	4625                	li	a2,9
 2a6:	02f66863          	bltu	a2,a5,2d6 <atoi+0x44>
 2aa:	872a                	mv	a4,a0
 2ac:	4501                	li	a0,0
 2ae:	0705                	addi	a4,a4,1
 2b0:	0025179b          	slliw	a5,a0,0x2
 2b4:	9fa9                	addw	a5,a5,a0
 2b6:	0017979b          	slliw	a5,a5,0x1
 2ba:	9fb5                	addw	a5,a5,a3
 2bc:	fd07851b          	addiw	a0,a5,-48
 2c0:	00074683          	lbu	a3,0(a4)
 2c4:	fd06879b          	addiw	a5,a3,-48
 2c8:	0ff7f793          	zext.b	a5,a5
 2cc:	fef671e3          	bgeu	a2,a5,2ae <atoi+0x1c>
 2d0:	6422                	ld	s0,8(sp)
 2d2:	0141                	addi	sp,sp,16
 2d4:	8082                	ret
 2d6:	4501                	li	a0,0
 2d8:	bfe5                	j	2d0 <atoi+0x3e>

00000000000002da <memmove>:
 2da:	1141                	addi	sp,sp,-16
 2dc:	e422                	sd	s0,8(sp)
 2de:	0800                	addi	s0,sp,16
 2e0:	02b57463          	bgeu	a0,a1,308 <memmove+0x2e>
 2e4:	00c05f63          	blez	a2,302 <memmove+0x28>
 2e8:	1602                	slli	a2,a2,0x20
 2ea:	9201                	srli	a2,a2,0x20
 2ec:	00c507b3          	add	a5,a0,a2
 2f0:	872a                	mv	a4,a0
 2f2:	0585                	addi	a1,a1,1
 2f4:	0705                	addi	a4,a4,1
 2f6:	fff5c683          	lbu	a3,-1(a1)
 2fa:	fed70fa3          	sb	a3,-1(a4)
 2fe:	fef71ae3          	bne	a4,a5,2f2 <memmove+0x18>
 302:	6422                	ld	s0,8(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret
 308:	00c50733          	add	a4,a0,a2
 30c:	95b2                	add	a1,a1,a2
 30e:	fec05ae3          	blez	a2,302 <memmove+0x28>
 312:	fff6079b          	addiw	a5,a2,-1
 316:	1782                	slli	a5,a5,0x20
 318:	9381                	srli	a5,a5,0x20
 31a:	fff7c793          	not	a5,a5
 31e:	97ba                	add	a5,a5,a4
 320:	15fd                	addi	a1,a1,-1
 322:	177d                	addi	a4,a4,-1
 324:	0005c683          	lbu	a3,0(a1)
 328:	00d70023          	sb	a3,0(a4)
 32c:	fee79ae3          	bne	a5,a4,320 <memmove+0x46>
 330:	bfc9                	j	302 <memmove+0x28>

0000000000000332 <memcmp>:
 332:	1141                	addi	sp,sp,-16
 334:	e422                	sd	s0,8(sp)
 336:	0800                	addi	s0,sp,16
 338:	ca05                	beqz	a2,368 <memcmp+0x36>
 33a:	fff6069b          	addiw	a3,a2,-1
 33e:	1682                	slli	a3,a3,0x20
 340:	9281                	srli	a3,a3,0x20
 342:	0685                	addi	a3,a3,1
 344:	96aa                	add	a3,a3,a0
 346:	00054783          	lbu	a5,0(a0)
 34a:	0005c703          	lbu	a4,0(a1)
 34e:	00e79863          	bne	a5,a4,35e <memcmp+0x2c>
 352:	0505                	addi	a0,a0,1
 354:	0585                	addi	a1,a1,1
 356:	fed518e3          	bne	a0,a3,346 <memcmp+0x14>
 35a:	4501                	li	a0,0
 35c:	a019                	j	362 <memcmp+0x30>
 35e:	40e7853b          	subw	a0,a5,a4
 362:	6422                	ld	s0,8(sp)
 364:	0141                	addi	sp,sp,16
 366:	8082                	ret
 368:	4501                	li	a0,0
 36a:	bfe5                	j	362 <memcmp+0x30>

000000000000036c <memcpy>:
 36c:	1141                	addi	sp,sp,-16
 36e:	e406                	sd	ra,8(sp)
 370:	e022                	sd	s0,0(sp)
 372:	0800                	addi	s0,sp,16
 374:	f67ff0ef          	jal	2da <memmove>
 378:	60a2                	ld	ra,8(sp)
 37a:	6402                	ld	s0,0(sp)
 37c:	0141                	addi	sp,sp,16
 37e:	8082                	ret

0000000000000380 <sbrk>:
 380:	1141                	addi	sp,sp,-16
 382:	e406                	sd	ra,8(sp)
 384:	e022                	sd	s0,0(sp)
 386:	0800                	addi	s0,sp,16
 388:	4585                	li	a1,1
 38a:	0b2000ef          	jal	43c <sys_sbrk>
 38e:	60a2                	ld	ra,8(sp)
 390:	6402                	ld	s0,0(sp)
 392:	0141                	addi	sp,sp,16
 394:	8082                	ret

0000000000000396 <sbrklazy>:
 396:	1141                	addi	sp,sp,-16
 398:	e406                	sd	ra,8(sp)
 39a:	e022                	sd	s0,0(sp)
 39c:	0800                	addi	s0,sp,16
 39e:	4589                	li	a1,2
 3a0:	09c000ef          	jal	43c <sys_sbrk>
 3a4:	60a2                	ld	ra,8(sp)
 3a6:	6402                	ld	s0,0(sp)
 3a8:	0141                	addi	sp,sp,16
 3aa:	8082                	ret

00000000000003ac <fork>:
 3ac:	4885                	li	a7,1
 3ae:	00000073          	ecall
 3b2:	8082                	ret

00000000000003b4 <exit>:
 3b4:	4889                	li	a7,2
 3b6:	00000073          	ecall
 3ba:	8082                	ret

00000000000003bc <wait>:
 3bc:	488d                	li	a7,3
 3be:	00000073          	ecall
 3c2:	8082                	ret

00000000000003c4 <pipe>:
 3c4:	4891                	li	a7,4
 3c6:	00000073          	ecall
 3ca:	8082                	ret

00000000000003cc <read>:
 3cc:	4895                	li	a7,5
 3ce:	00000073          	ecall
 3d2:	8082                	ret

00000000000003d4 <write>:
 3d4:	48c1                	li	a7,16
 3d6:	00000073          	ecall
 3da:	8082                	ret

00000000000003dc <close>:
 3dc:	48d5                	li	a7,21
 3de:	00000073          	ecall
 3e2:	8082                	ret

00000000000003e4 <kill>:
 3e4:	4899                	li	a7,6
 3e6:	00000073          	ecall
 3ea:	8082                	ret

00000000000003ec <exec>:
 3ec:	489d                	li	a7,7
 3ee:	00000073          	ecall
 3f2:	8082                	ret

00000000000003f4 <open>:
 3f4:	48bd                	li	a7,15
 3f6:	00000073          	ecall
 3fa:	8082                	ret

00000000000003fc <mknod>:
 3fc:	48c5                	li	a7,17
 3fe:	00000073          	ecall
 402:	8082                	ret

0000000000000404 <unlink>:
 404:	48c9                	li	a7,18
 406:	00000073          	ecall
 40a:	8082                	ret

000000000000040c <fstat>:
 40c:	48a1                	li	a7,8
 40e:	00000073          	ecall
 412:	8082                	ret

0000000000000414 <link>:
 414:	48cd                	li	a7,19
 416:	00000073          	ecall
 41a:	8082                	ret

000000000000041c <mkdir>:
 41c:	48d1                	li	a7,20
 41e:	00000073          	ecall
 422:	8082                	ret

0000000000000424 <chdir>:
 424:	48a5                	li	a7,9
 426:	00000073          	ecall
 42a:	8082                	ret

000000000000042c <dup>:
 42c:	48a9                	li	a7,10
 42e:	00000073          	ecall
 432:	8082                	ret

0000000000000434 <getpid>:
 434:	48ad                	li	a7,11
 436:	00000073          	ecall
 43a:	8082                	ret

000000000000043c <sys_sbrk>:
 43c:	48b1                	li	a7,12
 43e:	00000073          	ecall
 442:	8082                	ret

0000000000000444 <pause>:
 444:	48b5                	li	a7,13
 446:	00000073          	ecall
 44a:	8082                	ret

000000000000044c <uptime>:
 44c:	48b9                	li	a7,14
 44e:	00000073          	ecall
 452:	8082                	ret

0000000000000454 <sync>:
 454:	48d9                	li	a7,22
 456:	00000073          	ecall
 45a:	8082                	ret

000000000000045c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 45c:	1101                	addi	sp,sp,-32
 45e:	ec06                	sd	ra,24(sp)
 460:	e822                	sd	s0,16(sp)
 462:	1000                	addi	s0,sp,32
 464:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 468:	4605                	li	a2,1
 46a:	fef40593          	addi	a1,s0,-17
 46e:	f67ff0ef          	jal	3d4 <write>
}
 472:	60e2                	ld	ra,24(sp)
 474:	6442                	ld	s0,16(sp)
 476:	6105                	addi	sp,sp,32
 478:	8082                	ret

000000000000047a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 47a:	715d                	addi	sp,sp,-80
 47c:	e486                	sd	ra,72(sp)
 47e:	e0a2                	sd	s0,64(sp)
 480:	f84a                	sd	s2,48(sp)
 482:	0880                	addi	s0,sp,80
 484:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 486:	c299                	beqz	a3,48c <printint+0x12>
 488:	0805c363          	bltz	a1,50e <printint+0x94>
  neg = 0;
 48c:	4881                	li	a7,0
 48e:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 492:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
 494:	00000517          	auipc	a0,0x0
 498:	51450513          	addi	a0,a0,1300 # 9a8 <digits>
 49c:	883e                	mv	a6,a5
 49e:	2785                	addiw	a5,a5,1
 4a0:	02c5f733          	remu	a4,a1,a2
 4a4:	972a                	add	a4,a4,a0
 4a6:	00074703          	lbu	a4,0(a4)
 4aa:	00e68023          	sb	a4,0(a3)
  } while ((x /= base) != 0);
 4ae:	872e                	mv	a4,a1
 4b0:	02c5d5b3          	divu	a1,a1,a2
 4b4:	0685                	addi	a3,a3,1
 4b6:	fec773e3          	bgeu	a4,a2,49c <printint+0x22>
  if (neg)
 4ba:	00088b63          	beqz	a7,4d0 <printint+0x56>
    buf[i++] = '-';
 4be:	fd078793          	addi	a5,a5,-48
 4c2:	97a2                	add	a5,a5,s0
 4c4:	02d00713          	li	a4,45
 4c8:	fee78423          	sb	a4,-24(a5)
 4cc:	0028079b          	addiw	a5,a6,2

  while (--i >= 0)
 4d0:	02f05a63          	blez	a5,504 <printint+0x8a>
 4d4:	fc26                	sd	s1,56(sp)
 4d6:	f44e                	sd	s3,40(sp)
 4d8:	fb840713          	addi	a4,s0,-72
 4dc:	00f704b3          	add	s1,a4,a5
 4e0:	fff70993          	addi	s3,a4,-1
 4e4:	99be                	add	s3,s3,a5
 4e6:	37fd                	addiw	a5,a5,-1
 4e8:	1782                	slli	a5,a5,0x20
 4ea:	9381                	srli	a5,a5,0x20
 4ec:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 4f0:	fff4c583          	lbu	a1,-1(s1)
 4f4:	854a                	mv	a0,s2
 4f6:	f67ff0ef          	jal	45c <putc>
  while (--i >= 0)
 4fa:	14fd                	addi	s1,s1,-1
 4fc:	ff349ae3          	bne	s1,s3,4f0 <printint+0x76>
 500:	74e2                	ld	s1,56(sp)
 502:	79a2                	ld	s3,40(sp)
}
 504:	60a6                	ld	ra,72(sp)
 506:	6406                	ld	s0,64(sp)
 508:	7942                	ld	s2,48(sp)
 50a:	6161                	addi	sp,sp,80
 50c:	8082                	ret
    x = -xx;
 50e:	40b005b3          	neg	a1,a1
    neg = 1;
 512:	4885                	li	a7,1
    x = -xx;
 514:	bfad                	j	48e <printint+0x14>

0000000000000516 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 516:	711d                	addi	sp,sp,-96
 518:	ec86                	sd	ra,88(sp)
 51a:	e8a2                	sd	s0,80(sp)
 51c:	e0ca                	sd	s2,64(sp)
 51e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 520:	0005c903          	lbu	s2,0(a1)
 524:	28090663          	beqz	s2,7b0 <vprintf+0x29a>
 528:	e4a6                	sd	s1,72(sp)
 52a:	fc4e                	sd	s3,56(sp)
 52c:	f852                	sd	s4,48(sp)
 52e:	f456                	sd	s5,40(sp)
 530:	f05a                	sd	s6,32(sp)
 532:	ec5e                	sd	s7,24(sp)
 534:	e862                	sd	s8,16(sp)
 536:	e466                	sd	s9,8(sp)
 538:	8b2a                	mv	s6,a0
 53a:	8a2e                	mv	s4,a1
 53c:	8bb2                	mv	s7,a2
  state = 0;
 53e:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 540:	4481                	li	s1,0
 542:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 544:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 548:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 54c:	06c00c93          	li	s9,108
 550:	a005                	j	570 <vprintf+0x5a>
        putc(fd, c0);
 552:	85ca                	mv	a1,s2
 554:	855a                	mv	a0,s6
 556:	f07ff0ef          	jal	45c <putc>
 55a:	a019                	j	560 <vprintf+0x4a>
    } else if (state == '%') {
 55c:	03598263          	beq	s3,s5,580 <vprintf+0x6a>
  for (i = 0; fmt[i]; i++) {
 560:	2485                	addiw	s1,s1,1
 562:	8726                	mv	a4,s1
 564:	009a07b3          	add	a5,s4,s1
 568:	0007c903          	lbu	s2,0(a5)
 56c:	22090a63          	beqz	s2,7a0 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 570:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 574:	fe0994e3          	bnez	s3,55c <vprintf+0x46>
      if (c0 == '%') {
 578:	fd579de3          	bne	a5,s5,552 <vprintf+0x3c>
        state = '%';
 57c:	89be                	mv	s3,a5
 57e:	b7cd                	j	560 <vprintf+0x4a>
        c1 = fmt[i + 1] & 0xff;
 580:	00ea06b3          	add	a3,s4,a4
 584:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 588:	8636                	mv	a2,a3
      if (c1)
 58a:	c681                	beqz	a3,592 <vprintf+0x7c>
        c2 = fmt[i + 2] & 0xff;
 58c:	9752                	add	a4,a4,s4
 58e:	00274603          	lbu	a2,2(a4)
      if (c0 == 'd') {
 592:	05878363          	beq	a5,s8,5d8 <vprintf+0xc2>
      } else if (c0 == 'l' && c1 == 'd') {
 596:	05978d63          	beq	a5,s9,5f0 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 59a:	07500713          	li	a4,117
 59e:	0ee78763          	beq	a5,a4,68c <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 5a2:	07800713          	li	a4,120
 5a6:	12e78963          	beq	a5,a4,6d8 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 5aa:	07000713          	li	a4,112
 5ae:	14e78e63          	beq	a5,a4,70a <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 5b2:	06300713          	li	a4,99
 5b6:	18e78e63          	beq	a5,a4,752 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 5ba:	07300713          	li	a4,115
 5be:	1ae78463          	beq	a5,a4,766 <vprintf+0x250>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 5c2:	02500713          	li	a4,37
 5c6:	04e79563          	bne	a5,a4,610 <vprintf+0xfa>
        putc(fd, '%');
 5ca:	02500593          	li	a1,37
 5ce:	855a                	mv	a0,s6
 5d0:	e8dff0ef          	jal	45c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	b769                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5d8:	008b8913          	addi	s2,s7,8
 5dc:	4685                	li	a3,1
 5de:	4629                	li	a2,10
 5e0:	000ba583          	lw	a1,0(s7)
 5e4:	855a                	mv	a0,s6
 5e6:	e95ff0ef          	jal	47a <printint>
 5ea:	8bca                	mv	s7,s2
      state = 0;
 5ec:	4981                	li	s3,0
 5ee:	bf8d                	j	560 <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'd') {
 5f0:	06400793          	li	a5,100
 5f4:	02f68963          	beq	a3,a5,626 <vprintf+0x110>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 5f8:	06c00793          	li	a5,108
 5fc:	04f68263          	beq	a3,a5,640 <vprintf+0x12a>
      } else if (c0 == 'l' && c1 == 'u') {
 600:	07500793          	li	a5,117
 604:	0af68063          	beq	a3,a5,6a4 <vprintf+0x18e>
      } else if (c0 == 'l' && c1 == 'x') {
 608:	07800793          	li	a5,120
 60c:	0ef68263          	beq	a3,a5,6f0 <vprintf+0x1da>
        putc(fd, '%');
 610:	02500593          	li	a1,37
 614:	855a                	mv	a0,s6
 616:	e47ff0ef          	jal	45c <putc>
        putc(fd, c0);
 61a:	85ca                	mv	a1,s2
 61c:	855a                	mv	a0,s6
 61e:	e3fff0ef          	jal	45c <putc>
      state = 0;
 622:	4981                	li	s3,0
 624:	bf35                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 626:	008b8913          	addi	s2,s7,8
 62a:	4685                	li	a3,1
 62c:	4629                	li	a2,10
 62e:	000bb583          	ld	a1,0(s7)
 632:	855a                	mv	a0,s6
 634:	e47ff0ef          	jal	47a <printint>
        i += 1;
 638:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 63a:	8bca                	mv	s7,s2
      state = 0;
 63c:	4981                	li	s3,0
        i += 1;
 63e:	b70d                	j	560 <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 640:	06400793          	li	a5,100
 644:	02f60763          	beq	a2,a5,672 <vprintf+0x15c>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 648:	07500793          	li	a5,117
 64c:	06f60963          	beq	a2,a5,6be <vprintf+0x1a8>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 650:	07800793          	li	a5,120
 654:	faf61ee3          	bne	a2,a5,610 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 658:	008b8913          	addi	s2,s7,8
 65c:	4681                	li	a3,0
 65e:	4641                	li	a2,16
 660:	000bb583          	ld	a1,0(s7)
 664:	855a                	mv	a0,s6
 666:	e15ff0ef          	jal	47a <printint>
        i += 2;
 66a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 66c:	8bca                	mv	s7,s2
      state = 0;
 66e:	4981                	li	s3,0
        i += 2;
 670:	bdc5                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 672:	008b8913          	addi	s2,s7,8
 676:	4685                	li	a3,1
 678:	4629                	li	a2,10
 67a:	000bb583          	ld	a1,0(s7)
 67e:	855a                	mv	a0,s6
 680:	dfbff0ef          	jal	47a <printint>
        i += 2;
 684:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 686:	8bca                	mv	s7,s2
      state = 0;
 688:	4981                	li	s3,0
        i += 2;
 68a:	bdd9                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 68c:	008b8913          	addi	s2,s7,8
 690:	4681                	li	a3,0
 692:	4629                	li	a2,10
 694:	000be583          	lwu	a1,0(s7)
 698:	855a                	mv	a0,s6
 69a:	de1ff0ef          	jal	47a <printint>
 69e:	8bca                	mv	s7,s2
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	bd7d                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a4:	008b8913          	addi	s2,s7,8
 6a8:	4681                	li	a3,0
 6aa:	4629                	li	a2,10
 6ac:	000bb583          	ld	a1,0(s7)
 6b0:	855a                	mv	a0,s6
 6b2:	dc9ff0ef          	jal	47a <printint>
        i += 1;
 6b6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b8:	8bca                	mv	s7,s2
      state = 0;
 6ba:	4981                	li	s3,0
        i += 1;
 6bc:	b555                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6be:	008b8913          	addi	s2,s7,8
 6c2:	4681                	li	a3,0
 6c4:	4629                	li	a2,10
 6c6:	000bb583          	ld	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	dafff0ef          	jal	47a <printint>
        i += 2;
 6d0:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d2:	8bca                	mv	s7,s2
      state = 0;
 6d4:	4981                	li	s3,0
        i += 2;
 6d6:	b569                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6d8:	008b8913          	addi	s2,s7,8
 6dc:	4681                	li	a3,0
 6de:	4641                	li	a2,16
 6e0:	000be583          	lwu	a1,0(s7)
 6e4:	855a                	mv	a0,s6
 6e6:	d95ff0ef          	jal	47a <printint>
 6ea:	8bca                	mv	s7,s2
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	bd8d                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	4681                	li	a3,0
 6f6:	4641                	li	a2,16
 6f8:	000bb583          	ld	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	d7dff0ef          	jal	47a <printint>
        i += 1;
 702:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 704:	8bca                	mv	s7,s2
      state = 0;
 706:	4981                	li	s3,0
        i += 1;
 708:	bda1                	j	560 <vprintf+0x4a>
 70a:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 70c:	008b8d13          	addi	s10,s7,8
 710:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 714:	03000593          	li	a1,48
 718:	855a                	mv	a0,s6
 71a:	d43ff0ef          	jal	45c <putc>
  putc(fd, 'x');
 71e:	07800593          	li	a1,120
 722:	855a                	mv	a0,s6
 724:	d39ff0ef          	jal	45c <putc>
 728:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 72a:	00000b97          	auipc	s7,0x0
 72e:	27eb8b93          	addi	s7,s7,638 # 9a8 <digits>
 732:	03c9d793          	srli	a5,s3,0x3c
 736:	97de                	add	a5,a5,s7
 738:	0007c583          	lbu	a1,0(a5)
 73c:	855a                	mv	a0,s6
 73e:	d1fff0ef          	jal	45c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 742:	0992                	slli	s3,s3,0x4
 744:	397d                	addiw	s2,s2,-1
 746:	fe0916e3          	bnez	s2,732 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 74a:	8bea                	mv	s7,s10
      state = 0;
 74c:	4981                	li	s3,0
 74e:	6d02                	ld	s10,0(sp)
 750:	bd01                	j	560 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 752:	008b8913          	addi	s2,s7,8
 756:	000bc583          	lbu	a1,0(s7)
 75a:	855a                	mv	a0,s6
 75c:	d01ff0ef          	jal	45c <putc>
 760:	8bca                	mv	s7,s2
      state = 0;
 762:	4981                	li	s3,0
 764:	bbf5                	j	560 <vprintf+0x4a>
        if ((s = va_arg(ap, char *)) == 0)
 766:	008b8993          	addi	s3,s7,8
 76a:	000bb903          	ld	s2,0(s7)
 76e:	00090f63          	beqz	s2,78c <vprintf+0x276>
        for (; *s; s++)
 772:	00094583          	lbu	a1,0(s2)
 776:	c195                	beqz	a1,79a <vprintf+0x284>
          putc(fd, *s);
 778:	855a                	mv	a0,s6
 77a:	ce3ff0ef          	jal	45c <putc>
        for (; *s; s++)
 77e:	0905                	addi	s2,s2,1
 780:	00094583          	lbu	a1,0(s2)
 784:	f9f5                	bnez	a1,778 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 786:	8bce                	mv	s7,s3
      state = 0;
 788:	4981                	li	s3,0
 78a:	bbd9                	j	560 <vprintf+0x4a>
          s = "(null)";
 78c:	00000917          	auipc	s2,0x0
 790:	21490913          	addi	s2,s2,532 # 9a0 <malloc+0x108>
        for (; *s; s++)
 794:	02800593          	li	a1,40
 798:	b7c5                	j	778 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 79a:	8bce                	mv	s7,s3
      state = 0;
 79c:	4981                	li	s3,0
 79e:	b3c9                	j	560 <vprintf+0x4a>
 7a0:	64a6                	ld	s1,72(sp)
 7a2:	79e2                	ld	s3,56(sp)
 7a4:	7a42                	ld	s4,48(sp)
 7a6:	7aa2                	ld	s5,40(sp)
 7a8:	7b02                	ld	s6,32(sp)
 7aa:	6be2                	ld	s7,24(sp)
 7ac:	6c42                	ld	s8,16(sp)
 7ae:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7b0:	60e6                	ld	ra,88(sp)
 7b2:	6446                	ld	s0,80(sp)
 7b4:	6906                	ld	s2,64(sp)
 7b6:	6125                	addi	sp,sp,96
 7b8:	8082                	ret

00000000000007ba <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7ba:	715d                	addi	sp,sp,-80
 7bc:	ec06                	sd	ra,24(sp)
 7be:	e822                	sd	s0,16(sp)
 7c0:	1000                	addi	s0,sp,32
 7c2:	e010                	sd	a2,0(s0)
 7c4:	e414                	sd	a3,8(s0)
 7c6:	e818                	sd	a4,16(s0)
 7c8:	ec1c                	sd	a5,24(s0)
 7ca:	03043023          	sd	a6,32(s0)
 7ce:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7d2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7d6:	8622                	mv	a2,s0
 7d8:	d3fff0ef          	jal	516 <vprintf>
}
 7dc:	60e2                	ld	ra,24(sp)
 7de:	6442                	ld	s0,16(sp)
 7e0:	6161                	addi	sp,sp,80
 7e2:	8082                	ret

00000000000007e4 <printf>:

void
printf(const char *fmt, ...)
{
 7e4:	711d                	addi	sp,sp,-96
 7e6:	ec06                	sd	ra,24(sp)
 7e8:	e822                	sd	s0,16(sp)
 7ea:	1000                	addi	s0,sp,32
 7ec:	e40c                	sd	a1,8(s0)
 7ee:	e810                	sd	a2,16(s0)
 7f0:	ec14                	sd	a3,24(s0)
 7f2:	f018                	sd	a4,32(s0)
 7f4:	f41c                	sd	a5,40(s0)
 7f6:	03043823          	sd	a6,48(s0)
 7fa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7fe:	00840613          	addi	a2,s0,8
 802:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 806:	85aa                	mv	a1,a0
 808:	4505                	li	a0,1
 80a:	d0dff0ef          	jal	516 <vprintf>
}
 80e:	60e2                	ld	ra,24(sp)
 810:	6442                	ld	s0,16(sp)
 812:	6125                	addi	sp,sp,96
 814:	8082                	ret

0000000000000816 <free>:
 816:	1141                	addi	sp,sp,-16
 818:	e422                	sd	s0,8(sp)
 81a:	0800                	addi	s0,sp,16
 81c:	ff050693          	addi	a3,a0,-16
 820:	00000797          	auipc	a5,0x0
 824:	7e07b783          	ld	a5,2016(a5) # 1000 <freep>
 828:	a02d                	j	852 <free+0x3c>
 82a:	4618                	lw	a4,8(a2)
 82c:	9f2d                	addw	a4,a4,a1
 82e:	fee52c23          	sw	a4,-8(a0)
 832:	6398                	ld	a4,0(a5)
 834:	6310                	ld	a2,0(a4)
 836:	a83d                	j	874 <free+0x5e>
 838:	ff852703          	lw	a4,-8(a0)
 83c:	9f31                	addw	a4,a4,a2
 83e:	c798                	sw	a4,8(a5)
 840:	ff053683          	ld	a3,-16(a0)
 844:	a091                	j	888 <free+0x72>
 846:	6398                	ld	a4,0(a5)
 848:	00e7e463          	bltu	a5,a4,850 <free+0x3a>
 84c:	00e6ea63          	bltu	a3,a4,860 <free+0x4a>
 850:	87ba                	mv	a5,a4
 852:	fed7fae3          	bgeu	a5,a3,846 <free+0x30>
 856:	6398                	ld	a4,0(a5)
 858:	00e6e463          	bltu	a3,a4,860 <free+0x4a>
 85c:	fee7eae3          	bltu	a5,a4,850 <free+0x3a>
 860:	ff852583          	lw	a1,-8(a0)
 864:	6390                	ld	a2,0(a5)
 866:	02059813          	slli	a6,a1,0x20
 86a:	01c85713          	srli	a4,a6,0x1c
 86e:	9736                	add	a4,a4,a3
 870:	fae60de3          	beq	a2,a4,82a <free+0x14>
 874:	fec53823          	sd	a2,-16(a0)
 878:	4790                	lw	a2,8(a5)
 87a:	02061593          	slli	a1,a2,0x20
 87e:	01c5d713          	srli	a4,a1,0x1c
 882:	973e                	add	a4,a4,a5
 884:	fae68ae3          	beq	a3,a4,838 <free+0x22>
 888:	e394                	sd	a3,0(a5)
 88a:	00000717          	auipc	a4,0x0
 88e:	76f73b23          	sd	a5,1910(a4) # 1000 <freep>
 892:	6422                	ld	s0,8(sp)
 894:	0141                	addi	sp,sp,16
 896:	8082                	ret

0000000000000898 <malloc>:
 898:	7139                	addi	sp,sp,-64
 89a:	fc06                	sd	ra,56(sp)
 89c:	f822                	sd	s0,48(sp)
 89e:	f426                	sd	s1,40(sp)
 8a0:	ec4e                	sd	s3,24(sp)
 8a2:	0080                	addi	s0,sp,64
 8a4:	02051493          	slli	s1,a0,0x20
 8a8:	9081                	srli	s1,s1,0x20
 8aa:	04bd                	addi	s1,s1,15
 8ac:	8091                	srli	s1,s1,0x4
 8ae:	0014899b          	addiw	s3,s1,1
 8b2:	0485                	addi	s1,s1,1
 8b4:	00000517          	auipc	a0,0x0
 8b8:	74c53503          	ld	a0,1868(a0) # 1000 <freep>
 8bc:	c915                	beqz	a0,8f0 <malloc+0x58>
 8be:	611c                	ld	a5,0(a0)
 8c0:	4798                	lw	a4,8(a5)
 8c2:	08977a63          	bgeu	a4,s1,956 <malloc+0xbe>
 8c6:	f04a                	sd	s2,32(sp)
 8c8:	e852                	sd	s4,16(sp)
 8ca:	e456                	sd	s5,8(sp)
 8cc:	e05a                	sd	s6,0(sp)
 8ce:	8a4e                	mv	s4,s3
 8d0:	0009871b          	sext.w	a4,s3
 8d4:	6685                	lui	a3,0x1
 8d6:	00d77363          	bgeu	a4,a3,8dc <malloc+0x44>
 8da:	6a05                	lui	s4,0x1
 8dc:	000a0b1b          	sext.w	s6,s4
 8e0:	004a1a1b          	slliw	s4,s4,0x4
 8e4:	00000917          	auipc	s2,0x0
 8e8:	71c90913          	addi	s2,s2,1820 # 1000 <freep>
 8ec:	5afd                	li	s5,-1
 8ee:	a081                	j	92e <malloc+0x96>
 8f0:	f04a                	sd	s2,32(sp)
 8f2:	e852                	sd	s4,16(sp)
 8f4:	e456                	sd	s5,8(sp)
 8f6:	e05a                	sd	s6,0(sp)
 8f8:	00000797          	auipc	a5,0x0
 8fc:	71878793          	addi	a5,a5,1816 # 1010 <base>
 900:	00000717          	auipc	a4,0x0
 904:	70f73023          	sd	a5,1792(a4) # 1000 <freep>
 908:	e39c                	sd	a5,0(a5)
 90a:	0007a423          	sw	zero,8(a5)
 90e:	b7c1                	j	8ce <malloc+0x36>
 910:	6398                	ld	a4,0(a5)
 912:	e118                	sd	a4,0(a0)
 914:	a8a9                	j	96e <malloc+0xd6>
 916:	01652423          	sw	s6,8(a0)
 91a:	0541                	addi	a0,a0,16
 91c:	efbff0ef          	jal	816 <free>
 920:	00093503          	ld	a0,0(s2)
 924:	c12d                	beqz	a0,986 <malloc+0xee>
 926:	611c                	ld	a5,0(a0)
 928:	4798                	lw	a4,8(a5)
 92a:	02977263          	bgeu	a4,s1,94e <malloc+0xb6>
 92e:	00093703          	ld	a4,0(s2)
 932:	853e                	mv	a0,a5
 934:	fef719e3          	bne	a4,a5,926 <malloc+0x8e>
 938:	8552                	mv	a0,s4
 93a:	a47ff0ef          	jal	380 <sbrk>
 93e:	fd551ce3          	bne	a0,s5,916 <malloc+0x7e>
 942:	4501                	li	a0,0
 944:	7902                	ld	s2,32(sp)
 946:	6a42                	ld	s4,16(sp)
 948:	6aa2                	ld	s5,8(sp)
 94a:	6b02                	ld	s6,0(sp)
 94c:	a03d                	j	97a <malloc+0xe2>
 94e:	7902                	ld	s2,32(sp)
 950:	6a42                	ld	s4,16(sp)
 952:	6aa2                	ld	s5,8(sp)
 954:	6b02                	ld	s6,0(sp)
 956:	fae48de3          	beq	s1,a4,910 <malloc+0x78>
 95a:	4137073b          	subw	a4,a4,s3
 95e:	c798                	sw	a4,8(a5)
 960:	02071693          	slli	a3,a4,0x20
 964:	01c6d713          	srli	a4,a3,0x1c
 968:	97ba                	add	a5,a5,a4
 96a:	0137a423          	sw	s3,8(a5)
 96e:	00000717          	auipc	a4,0x0
 972:	68a73923          	sd	a0,1682(a4) # 1000 <freep>
 976:	01078513          	addi	a0,a5,16
 97a:	70e2                	ld	ra,56(sp)
 97c:	7442                	ld	s0,48(sp)
 97e:	74a2                	ld	s1,40(sp)
 980:	69e2                	ld	s3,24(sp)
 982:	6121                	addi	sp,sp,64
 984:	8082                	ret
 986:	7902                	ld	s2,32(sp)
 988:	6a42                	ld	s4,16(sp)
 98a:	6aa2                	ld	s5,8(sp)
 98c:	6b02                	ld	s6,0(sp)
 98e:	b7f5                	j	97a <malloc+0xe2>
