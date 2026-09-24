
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <concatenar_cadenas>:
struct stat st;

//hay que asegurarse que el buffer que se ocupe para pegar las cadenas tenga suficiente espacio para ambas
char *
concatenar_cadenas(char *dest, const char *src, int dest_size)
{
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
  int i = 0;
  int j = 0;

  // buscar el final de la cadena dest
  while (dest[i] != '\0' && i < dest_size - 1) {
   6:	00054783          	lbu	a5,0(a0)
   a:	cfa9                	beqz	a5,64 <concatenar_cadenas+0x64>
   c:	4785                	li	a5,1
   e:	04c7dd63          	bge	a5,a2,68 <concatenar_cadenas+0x68>
  12:	00150713          	addi	a4,a0,1
  16:	fff6081b          	addiw	a6,a2,-1
  int i = 0;
  1a:	4781                	li	a5,0
    i++;
  1c:	2785                	addiw	a5,a5,1
  while (dest[i] != '\0' && i < dest_size - 1) {
  1e:	00074683          	lbu	a3,0(a4)
  22:	c689                	beqz	a3,2c <concatenar_cadenas+0x2c>
  24:	0705                	addi	a4,a4,1
  26:	ff079be3          	bne	a5,a6,1c <concatenar_cadenas+0x1c>
  2a:	87c2                	mv	a5,a6
  }

  // copiar src al final de dest
  while (src[j] != '\0' && i < dest_size - 1) {
  2c:	0005c703          	lbu	a4,0(a1)
  30:	c705                	beqz	a4,58 <concatenar_cadenas+0x58>
  32:	fff6069b          	addiw	a3,a2,-1
  36:	02d7d163          	bge	a5,a3,58 <concatenar_cadenas+0x58>
  3a:	00f506b3          	add	a3,a0,a5
  3e:	0585                	addi	a1,a1,1
  40:	367d                	addiw	a2,a2,-1
    dest[i] = src[j];
  42:	00e68023          	sb	a4,0(a3)
    i++;
  46:	2785                	addiw	a5,a5,1
  while (src[j] != '\0' && i < dest_size - 1) {
  48:	0005c703          	lbu	a4,0(a1)
  4c:	c711                	beqz	a4,58 <concatenar_cadenas+0x58>
  4e:	0685                	addi	a3,a3,1
  50:	0585                	addi	a1,a1,1
  52:	fec798e3          	bne	a5,a2,42 <concatenar_cadenas+0x42>
  56:	87b2                	mv	a5,a2
    j++;
  }

  // asegurar el fin de cadena nulo
  dest[i] = '\0';
  58:	97aa                	add	a5,a5,a0
  5a:	00078023          	sb	zero,0(a5)
  return dest;
}
  5e:	6422                	ld	s0,8(sp)
  60:	0141                	addi	sp,sp,16
  62:	8082                	ret
  int i = 0;
  64:	4781                	li	a5,0
  66:	b7d9                	j	2c <concatenar_cadenas+0x2c>
  68:	4781                	li	a5,0
  6a:	b7c9                	j	2c <concatenar_cadenas+0x2c>

000000000000006c <buscar_archivo>:

//como es solo para leer la cadena de caracteres, se usa const
// clang-format off
void buscar_archivo(char *ruta_actual, char *archivo_a_buscar)
{
  6c:	711d                	addi	sp,sp,-96
  6e:	ec86                	sd	ra,88(sp)
  70:	e8a2                	sd	s0,80(sp)
  72:	e4a6                	sd	s1,72(sp)
  74:	e0ca                	sd	s2,64(sp)
  76:	fc4e                	sd	s3,56(sp)
  78:	f852                	sd	s4,48(sp)
  7a:	f456                	sd	s5,40(sp)
  7c:	f05a                	sd	s6,32(sp)
  7e:	ec5e                	sd	s7,24(sp)
  80:	e862                	sd	s8,16(sp)
  82:	e466                	sd	s9,8(sp)
  84:	1080                	addi	s0,sp,96
  86:	89aa                	mv	s3,a0
  88:	8c2e                	mv	s8,a1
  int len_ruta_actual = strlen(ruta_actual);
  8a:	1bc000ef          	jal	246 <strlen>
  8e:	0005049b          	sext.w	s1,a0
  int len_nombre_archivo = strlen(archivo_a_buscar);
  92:	8562                	mv	a0,s8
  94:	1b2000ef          	jal	246 <strlen>
  98:	0005091b          	sext.w	s2,a0
  // Es lo que se ocupa para iterar sobre el directorio
  int file_descriptor = open(ruta_actual, O_RDONLY);
  9c:	4581                	li	a1,0
  9e:	854e                	mv	a0,s3
  a0:	422000ef          	jal	4c2 <open>
  a4:	8aaa                	mv	s5,a0

  // read deuelve la cantidad de bytes que logro leer con exito
  while (read(file_descriptor, &archivo_actual, sizeof(archivo_actual)) == sizeof(archivo_actual)) {
  a6:	00001a17          	auipc	s4,0x1
  aa:	f6aa0a13          	addi	s4,s4,-150 # 1010 <archivo_actual>

    // le sumo 2, uno para '/' y otro porciacaso para el '\0'
    char dest[len_ruta_actual + len_nombre_archivo + 2]; //deberia ser inecesario poner el * al principio ya que al ser un arreglo, debe ser un puntero
  ae:	012484bb          	addw	s1,s1,s2
  b2:	2489                	addiw	s1,s1,2
  b4:	00f48b13          	addi	s6,s1,15
  b8:	ff0b7b13          	andi	s6,s6,-16
      ruta_actual[0] = '.';
      ruta_actual[1] = '\0';
    }
    concatenar_cadenas(dest, ruta_actual, sizeof(dest));
    concatenar_cadenas(dest, "/", sizeof(dest));
    concatenar_cadenas(dest, archivo_actual.name, sizeof(dest));
  bc:	00001b97          	auipc	s7,0x1
  c0:	f56b8b93          	addi	s7,s7,-170 # 1012 <archivo_actual+0x2>
  while (read(file_descriptor, &archivo_actual, sizeof(archivo_actual)) == sizeof(archivo_actual)) {
  c4:	a035                	j	f0 <buscar_archivo+0x84>
      ruta_actual[0] = '.';
  c6:	02e00793          	li	a5,46
  ca:	00f98023          	sb	a5,0(s3)
      ruta_actual[1] = '\0';
  ce:	000980a3          	sb	zero,1(s3)
  d2:	a0a9                	j	11c <buscar_archivo+0xb0>
    if (archivo_actual.inum == 0 || strcmp(archivo_actual.name, ".") == 0 || strcmp(archivo_actual.name, "..") == 0) continue; // igual deberia funcionar sin esta linea

    // Supongo que al poner este condicional antes que el que ve si el archivo es una carpeta, esta función también identificara carpetas con el nombre buscado

    if (strcmp(archivo_actual.name,archivo_a_buscar) == 0) { // No se pueden comparar usando == pues son direcciones de memoria
      printf("%s\n", dest);
  d4:	85ca                	mv	a1,s2
  d6:	00001517          	auipc	a0,0x1
  da:	9a250513          	addi	a0,a0,-1630 # a78 <malloc+0x112>
  de:	7d4000ef          	jal	8b2 <printf>
  e2:	a869                	j	17c <buscar_archivo+0x110>
    }
  
    if (stat(dest, &st) < 0) continue; // aca se saca la informacion del archivo si es que se pudo y si no se salta al siguiente bucle
    
    if (st.type == T_DIR) {
      buscar_archivo(dest, archivo_a_buscar);
  e4:	85e2                	mv	a1,s8
  e6:	854a                	mv	a0,s2
  e8:	f85ff0ef          	jal	6c <buscar_archivo>
  ec:	a845                	j	19c <buscar_archivo+0x130>
    if (archivo_actual.inum == 0 || strcmp(archivo_actual.name, ".") == 0 || strcmp(archivo_actual.name, "..") == 0) continue; // igual deberia funcionar sin esta linea
  ee:	8166                	mv	sp,s9
  while (read(file_descriptor, &archivo_actual, sizeof(archivo_actual)) == sizeof(archivo_actual)) {
  f0:	4641                	li	a2,16
  f2:	85d2                	mv	a1,s4
  f4:	8556                	mv	a0,s5
  f6:	3a4000ef          	jal	49a <read>
  fa:	47c1                	li	a5,16
  fc:	0af51263          	bne	a0,a5,1a0 <buscar_archivo+0x134>
 100:	8c8a                	mv	s9,sp
    char dest[len_ruta_actual + len_nombre_archivo + 2]; //deberia ser inecesario poner el * al principio ya que al ser un arreglo, debe ser un puntero
 102:	41610133          	sub	sp,sp,s6
 106:	890a                	mv	s2,sp
    dest[0] = '\0'; // Si declaras pero no incializas una variable en C, esta contiene basura por defecto
 108:	00010023          	sb	zero,0(sp)
    if (strlen(ruta_actual) == 2) {
 10c:	854e                	mv	a0,s3
 10e:	138000ef          	jal	246 <strlen>
 112:	0005079b          	sext.w	a5,a0
 116:	4709                	li	a4,2
 118:	fae787e3          	beq	a5,a4,c6 <buscar_archivo+0x5a>
    concatenar_cadenas(dest, ruta_actual, sizeof(dest));
 11c:	8626                	mv	a2,s1
 11e:	85ce                	mv	a1,s3
 120:	854a                	mv	a0,s2
 122:	edfff0ef          	jal	0 <concatenar_cadenas>
    concatenar_cadenas(dest, "/", sizeof(dest));
 126:	8626                	mv	a2,s1
 128:	00001597          	auipc	a1,0x1
 12c:	93858593          	addi	a1,a1,-1736 # a60 <malloc+0xfa>
 130:	854a                	mv	a0,s2
 132:	ecfff0ef          	jal	0 <concatenar_cadenas>
    concatenar_cadenas(dest, archivo_actual.name, sizeof(dest));
 136:	8626                	mv	a2,s1
 138:	85de                	mv	a1,s7
 13a:	854a                	mv	a0,s2
 13c:	ec5ff0ef          	jal	0 <concatenar_cadenas>
    if (archivo_actual.inum == 0 || strcmp(archivo_actual.name, ".") == 0 || strcmp(archivo_actual.name, "..") == 0) continue; // igual deberia funcionar sin esta linea
 140:	000a5783          	lhu	a5,0(s4)
 144:	d7cd                	beqz	a5,ee <buscar_archivo+0x82>
 146:	00001597          	auipc	a1,0x1
 14a:	92258593          	addi	a1,a1,-1758 # a68 <malloc+0x102>
 14e:	855e                	mv	a0,s7
 150:	0ca000ef          	jal	21a <strcmp>
 154:	dd49                	beqz	a0,ee <buscar_archivo+0x82>
 156:	00001597          	auipc	a1,0x1
 15a:	91a58593          	addi	a1,a1,-1766 # a70 <malloc+0x10a>
 15e:	00001517          	auipc	a0,0x1
 162:	eb450513          	addi	a0,a0,-332 # 1012 <archivo_actual+0x2>
 166:	0b4000ef          	jal	21a <strcmp>
 16a:	d151                	beqz	a0,ee <buscar_archivo+0x82>
    if (strcmp(archivo_actual.name,archivo_a_buscar) == 0) { // No se pueden comparar usando == pues son direcciones de memoria
 16c:	85e2                	mv	a1,s8
 16e:	00001517          	auipc	a0,0x1
 172:	ea450513          	addi	a0,a0,-348 # 1012 <archivo_actual+0x2>
 176:	0a4000ef          	jal	21a <strcmp>
 17a:	dd29                	beqz	a0,d4 <buscar_archivo+0x68>
    if (stat(dest, &st) < 0) continue; // aca se saca la informacion del archivo si es que se pudo y si no se salta al siguiente bucle
 17c:	00001597          	auipc	a1,0x1
 180:	ea458593          	addi	a1,a1,-348 # 1020 <st>
 184:	854a                	mv	a0,s2
 186:	1a0000ef          	jal	326 <stat>
 18a:	f60542e3          	bltz	a0,ee <buscar_archivo+0x82>
    if (st.type == T_DIR) {
 18e:	00001717          	auipc	a4,0x1
 192:	e9a71703          	lh	a4,-358(a4) # 1028 <st+0x8>
 196:	4785                	li	a5,1
 198:	f4f706e3          	beq	a4,a5,e4 <buscar_archivo+0x78>
 19c:	8166                	mv	sp,s9
 19e:	bf89                	j	f0 <buscar_archivo+0x84>
    }
  }
}
 1a0:	fa040113          	addi	sp,s0,-96
 1a4:	60e6                	ld	ra,88(sp)
 1a6:	6446                	ld	s0,80(sp)
 1a8:	64a6                	ld	s1,72(sp)
 1aa:	6906                	ld	s2,64(sp)
 1ac:	79e2                	ld	s3,56(sp)
 1ae:	7a42                	ld	s4,48(sp)
 1b0:	7aa2                	ld	s5,40(sp)
 1b2:	7b02                	ld	s6,32(sp)
 1b4:	6be2                	ld	s7,24(sp)
 1b6:	6c42                	ld	s8,16(sp)
 1b8:	6ca2                	ld	s9,8(sp)
 1ba:	6125                	addi	sp,sp,96
 1bc:	8082                	ret

00000000000001be <main>:

int
main(int argc, char *argv[])
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e406                	sd	ra,8(sp)
 1c2:	e022                	sd	s0,0(sp)
 1c4:	0800                	addi	s0,sp,16
  // estoy asumiendo que se usa la ruta relativa
  if (argc < 3) {
 1c6:	4709                	li	a4,2
 1c8:	00a74b63          	blt	a4,a0,1de <main+0x20>
    printf("find ./ruta_relativa archivo_a_buscar\n");
 1cc:	00001517          	auipc	a0,0x1
 1d0:	8b450513          	addi	a0,a0,-1868 # a80 <malloc+0x11a>
 1d4:	6de000ef          	jal	8b2 <printf>
    exit(1);
 1d8:	4505                	li	a0,1
 1da:	2a8000ef          	jal	482 <exit>
 1de:	87ae                	mv	a5,a1
  }

  buscar_archivo(argv[1], argv[2]);
 1e0:	698c                	ld	a1,16(a1)
 1e2:	6788                	ld	a0,8(a5)
 1e4:	e89ff0ef          	jal	6c <buscar_archivo>
  // argv[0] es el nombre del propio ejecutable
  // argv[1] es el primer argumento real que pasas en la terminal

  exit(0);
 1e8:	4501                	li	a0,0
 1ea:	298000ef          	jal	482 <exit>

00000000000001ee <start>:
 1ee:	1141                	addi	sp,sp,-16
 1f0:	e406                	sd	ra,8(sp)
 1f2:	e022                	sd	s0,0(sp)
 1f4:	0800                	addi	s0,sp,16
 1f6:	fc9ff0ef          	jal	1be <main>
 1fa:	288000ef          	jal	482 <exit>

00000000000001fe <strcpy>:
 1fe:	1141                	addi	sp,sp,-16
 200:	e422                	sd	s0,8(sp)
 202:	0800                	addi	s0,sp,16
 204:	87aa                	mv	a5,a0
 206:	0585                	addi	a1,a1,1
 208:	0785                	addi	a5,a5,1
 20a:	fff5c703          	lbu	a4,-1(a1)
 20e:	fee78fa3          	sb	a4,-1(a5)
 212:	fb75                	bnez	a4,206 <strcpy+0x8>
 214:	6422                	ld	s0,8(sp)
 216:	0141                	addi	sp,sp,16
 218:	8082                	ret

000000000000021a <strcmp>:
 21a:	1141                	addi	sp,sp,-16
 21c:	e422                	sd	s0,8(sp)
 21e:	0800                	addi	s0,sp,16
 220:	00054783          	lbu	a5,0(a0)
 224:	cb91                	beqz	a5,238 <strcmp+0x1e>
 226:	0005c703          	lbu	a4,0(a1)
 22a:	00f71763          	bne	a4,a5,238 <strcmp+0x1e>
 22e:	0505                	addi	a0,a0,1
 230:	0585                	addi	a1,a1,1
 232:	00054783          	lbu	a5,0(a0)
 236:	fbe5                	bnez	a5,226 <strcmp+0xc>
 238:	0005c503          	lbu	a0,0(a1)
 23c:	40a7853b          	subw	a0,a5,a0
 240:	6422                	ld	s0,8(sp)
 242:	0141                	addi	sp,sp,16
 244:	8082                	ret

0000000000000246 <strlen>:
 246:	1141                	addi	sp,sp,-16
 248:	e422                	sd	s0,8(sp)
 24a:	0800                	addi	s0,sp,16
 24c:	00054783          	lbu	a5,0(a0)
 250:	cf91                	beqz	a5,26c <strlen+0x26>
 252:	0505                	addi	a0,a0,1
 254:	87aa                	mv	a5,a0
 256:	86be                	mv	a3,a5
 258:	0785                	addi	a5,a5,1
 25a:	fff7c703          	lbu	a4,-1(a5)
 25e:	ff65                	bnez	a4,256 <strlen+0x10>
 260:	40a6853b          	subw	a0,a3,a0
 264:	2505                	addiw	a0,a0,1
 266:	6422                	ld	s0,8(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret
 26c:	4501                	li	a0,0
 26e:	bfe5                	j	266 <strlen+0x20>

0000000000000270 <memset>:
 270:	1141                	addi	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	addi	s0,sp,16
 276:	ca19                	beqz	a2,28c <memset+0x1c>
 278:	87aa                	mv	a5,a0
 27a:	1602                	slli	a2,a2,0x20
 27c:	9201                	srli	a2,a2,0x20
 27e:	00a60733          	add	a4,a2,a0
 282:	00b78023          	sb	a1,0(a5)
 286:	0785                	addi	a5,a5,1
 288:	fee79de3          	bne	a5,a4,282 <memset+0x12>
 28c:	6422                	ld	s0,8(sp)
 28e:	0141                	addi	sp,sp,16
 290:	8082                	ret

0000000000000292 <strchr>:
 292:	1141                	addi	sp,sp,-16
 294:	e422                	sd	s0,8(sp)
 296:	0800                	addi	s0,sp,16
 298:	00054783          	lbu	a5,0(a0)
 29c:	cb99                	beqz	a5,2b2 <strchr+0x20>
 29e:	00f58763          	beq	a1,a5,2ac <strchr+0x1a>
 2a2:	0505                	addi	a0,a0,1
 2a4:	00054783          	lbu	a5,0(a0)
 2a8:	fbfd                	bnez	a5,29e <strchr+0xc>
 2aa:	4501                	li	a0,0
 2ac:	6422                	ld	s0,8(sp)
 2ae:	0141                	addi	sp,sp,16
 2b0:	8082                	ret
 2b2:	4501                	li	a0,0
 2b4:	bfe5                	j	2ac <strchr+0x1a>

00000000000002b6 <gets>:
 2b6:	711d                	addi	sp,sp,-96
 2b8:	ec86                	sd	ra,88(sp)
 2ba:	e8a2                	sd	s0,80(sp)
 2bc:	e4a6                	sd	s1,72(sp)
 2be:	e0ca                	sd	s2,64(sp)
 2c0:	fc4e                	sd	s3,56(sp)
 2c2:	f852                	sd	s4,48(sp)
 2c4:	f456                	sd	s5,40(sp)
 2c6:	f05a                	sd	s6,32(sp)
 2c8:	ec5e                	sd	s7,24(sp)
 2ca:	1080                	addi	s0,sp,96
 2cc:	8baa                	mv	s7,a0
 2ce:	8a2e                	mv	s4,a1
 2d0:	892a                	mv	s2,a0
 2d2:	4481                	li	s1,0
 2d4:	4aa9                	li	s5,10
 2d6:	4b35                	li	s6,13
 2d8:	89a6                	mv	s3,s1
 2da:	2485                	addiw	s1,s1,1
 2dc:	0344d663          	bge	s1,s4,308 <gets+0x52>
 2e0:	4605                	li	a2,1
 2e2:	faf40593          	addi	a1,s0,-81
 2e6:	4501                	li	a0,0
 2e8:	1b2000ef          	jal	49a <read>
 2ec:	00a05e63          	blez	a0,308 <gets+0x52>
 2f0:	faf44783          	lbu	a5,-81(s0)
 2f4:	00f90023          	sb	a5,0(s2)
 2f8:	01578763          	beq	a5,s5,306 <gets+0x50>
 2fc:	0905                	addi	s2,s2,1
 2fe:	fd679de3          	bne	a5,s6,2d8 <gets+0x22>
 302:	89a6                	mv	s3,s1
 304:	a011                	j	308 <gets+0x52>
 306:	89a6                	mv	s3,s1
 308:	99de                	add	s3,s3,s7
 30a:	00098023          	sb	zero,0(s3)
 30e:	855e                	mv	a0,s7
 310:	60e6                	ld	ra,88(sp)
 312:	6446                	ld	s0,80(sp)
 314:	64a6                	ld	s1,72(sp)
 316:	6906                	ld	s2,64(sp)
 318:	79e2                	ld	s3,56(sp)
 31a:	7a42                	ld	s4,48(sp)
 31c:	7aa2                	ld	s5,40(sp)
 31e:	7b02                	ld	s6,32(sp)
 320:	6be2                	ld	s7,24(sp)
 322:	6125                	addi	sp,sp,96
 324:	8082                	ret

0000000000000326 <stat>:
 326:	1101                	addi	sp,sp,-32
 328:	ec06                	sd	ra,24(sp)
 32a:	e822                	sd	s0,16(sp)
 32c:	e04a                	sd	s2,0(sp)
 32e:	1000                	addi	s0,sp,32
 330:	892e                	mv	s2,a1
 332:	4581                	li	a1,0
 334:	18e000ef          	jal	4c2 <open>
 338:	02054263          	bltz	a0,35c <stat+0x36>
 33c:	e426                	sd	s1,8(sp)
 33e:	84aa                	mv	s1,a0
 340:	85ca                	mv	a1,s2
 342:	198000ef          	jal	4da <fstat>
 346:	892a                	mv	s2,a0
 348:	8526                	mv	a0,s1
 34a:	160000ef          	jal	4aa <close>
 34e:	64a2                	ld	s1,8(sp)
 350:	854a                	mv	a0,s2
 352:	60e2                	ld	ra,24(sp)
 354:	6442                	ld	s0,16(sp)
 356:	6902                	ld	s2,0(sp)
 358:	6105                	addi	sp,sp,32
 35a:	8082                	ret
 35c:	597d                	li	s2,-1
 35e:	bfcd                	j	350 <stat+0x2a>

0000000000000360 <atoi>:
 360:	1141                	addi	sp,sp,-16
 362:	e422                	sd	s0,8(sp)
 364:	0800                	addi	s0,sp,16
 366:	00054683          	lbu	a3,0(a0)
 36a:	fd06879b          	addiw	a5,a3,-48
 36e:	0ff7f793          	zext.b	a5,a5
 372:	4625                	li	a2,9
 374:	02f66863          	bltu	a2,a5,3a4 <atoi+0x44>
 378:	872a                	mv	a4,a0
 37a:	4501                	li	a0,0
 37c:	0705                	addi	a4,a4,1
 37e:	0025179b          	slliw	a5,a0,0x2
 382:	9fa9                	addw	a5,a5,a0
 384:	0017979b          	slliw	a5,a5,0x1
 388:	9fb5                	addw	a5,a5,a3
 38a:	fd07851b          	addiw	a0,a5,-48
 38e:	00074683          	lbu	a3,0(a4)
 392:	fd06879b          	addiw	a5,a3,-48
 396:	0ff7f793          	zext.b	a5,a5
 39a:	fef671e3          	bgeu	a2,a5,37c <atoi+0x1c>
 39e:	6422                	ld	s0,8(sp)
 3a0:	0141                	addi	sp,sp,16
 3a2:	8082                	ret
 3a4:	4501                	li	a0,0
 3a6:	bfe5                	j	39e <atoi+0x3e>

00000000000003a8 <memmove>:
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	addi	s0,sp,16
 3ae:	02b57463          	bgeu	a0,a1,3d6 <memmove+0x2e>
 3b2:	00c05f63          	blez	a2,3d0 <memmove+0x28>
 3b6:	1602                	slli	a2,a2,0x20
 3b8:	9201                	srli	a2,a2,0x20
 3ba:	00c507b3          	add	a5,a0,a2
 3be:	872a                	mv	a4,a0
 3c0:	0585                	addi	a1,a1,1
 3c2:	0705                	addi	a4,a4,1
 3c4:	fff5c683          	lbu	a3,-1(a1)
 3c8:	fed70fa3          	sb	a3,-1(a4)
 3cc:	fef71ae3          	bne	a4,a5,3c0 <memmove+0x18>
 3d0:	6422                	ld	s0,8(sp)
 3d2:	0141                	addi	sp,sp,16
 3d4:	8082                	ret
 3d6:	00c50733          	add	a4,a0,a2
 3da:	95b2                	add	a1,a1,a2
 3dc:	fec05ae3          	blez	a2,3d0 <memmove+0x28>
 3e0:	fff6079b          	addiw	a5,a2,-1
 3e4:	1782                	slli	a5,a5,0x20
 3e6:	9381                	srli	a5,a5,0x20
 3e8:	fff7c793          	not	a5,a5
 3ec:	97ba                	add	a5,a5,a4
 3ee:	15fd                	addi	a1,a1,-1
 3f0:	177d                	addi	a4,a4,-1
 3f2:	0005c683          	lbu	a3,0(a1)
 3f6:	00d70023          	sb	a3,0(a4)
 3fa:	fee79ae3          	bne	a5,a4,3ee <memmove+0x46>
 3fe:	bfc9                	j	3d0 <memmove+0x28>

0000000000000400 <memcmp>:
 400:	1141                	addi	sp,sp,-16
 402:	e422                	sd	s0,8(sp)
 404:	0800                	addi	s0,sp,16
 406:	ca05                	beqz	a2,436 <memcmp+0x36>
 408:	fff6069b          	addiw	a3,a2,-1
 40c:	1682                	slli	a3,a3,0x20
 40e:	9281                	srli	a3,a3,0x20
 410:	0685                	addi	a3,a3,1
 412:	96aa                	add	a3,a3,a0
 414:	00054783          	lbu	a5,0(a0)
 418:	0005c703          	lbu	a4,0(a1)
 41c:	00e79863          	bne	a5,a4,42c <memcmp+0x2c>
 420:	0505                	addi	a0,a0,1
 422:	0585                	addi	a1,a1,1
 424:	fed518e3          	bne	a0,a3,414 <memcmp+0x14>
 428:	4501                	li	a0,0
 42a:	a019                	j	430 <memcmp+0x30>
 42c:	40e7853b          	subw	a0,a5,a4
 430:	6422                	ld	s0,8(sp)
 432:	0141                	addi	sp,sp,16
 434:	8082                	ret
 436:	4501                	li	a0,0
 438:	bfe5                	j	430 <memcmp+0x30>

000000000000043a <memcpy>:
 43a:	1141                	addi	sp,sp,-16
 43c:	e406                	sd	ra,8(sp)
 43e:	e022                	sd	s0,0(sp)
 440:	0800                	addi	s0,sp,16
 442:	f67ff0ef          	jal	3a8 <memmove>
 446:	60a2                	ld	ra,8(sp)
 448:	6402                	ld	s0,0(sp)
 44a:	0141                	addi	sp,sp,16
 44c:	8082                	ret

000000000000044e <sbrk>:
 44e:	1141                	addi	sp,sp,-16
 450:	e406                	sd	ra,8(sp)
 452:	e022                	sd	s0,0(sp)
 454:	0800                	addi	s0,sp,16
 456:	4585                	li	a1,1
 458:	0b2000ef          	jal	50a <sys_sbrk>
 45c:	60a2                	ld	ra,8(sp)
 45e:	6402                	ld	s0,0(sp)
 460:	0141                	addi	sp,sp,16
 462:	8082                	ret

0000000000000464 <sbrklazy>:
 464:	1141                	addi	sp,sp,-16
 466:	e406                	sd	ra,8(sp)
 468:	e022                	sd	s0,0(sp)
 46a:	0800                	addi	s0,sp,16
 46c:	4589                	li	a1,2
 46e:	09c000ef          	jal	50a <sys_sbrk>
 472:	60a2                	ld	ra,8(sp)
 474:	6402                	ld	s0,0(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret

000000000000047a <fork>:
 47a:	4885                	li	a7,1
 47c:	00000073          	ecall
 480:	8082                	ret

0000000000000482 <exit>:
 482:	4889                	li	a7,2
 484:	00000073          	ecall
 488:	8082                	ret

000000000000048a <wait>:
 48a:	488d                	li	a7,3
 48c:	00000073          	ecall
 490:	8082                	ret

0000000000000492 <pipe>:
 492:	4891                	li	a7,4
 494:	00000073          	ecall
 498:	8082                	ret

000000000000049a <read>:
 49a:	4895                	li	a7,5
 49c:	00000073          	ecall
 4a0:	8082                	ret

00000000000004a2 <write>:
 4a2:	48c1                	li	a7,16
 4a4:	00000073          	ecall
 4a8:	8082                	ret

00000000000004aa <close>:
 4aa:	48d5                	li	a7,21
 4ac:	00000073          	ecall
 4b0:	8082                	ret

00000000000004b2 <kill>:
 4b2:	4899                	li	a7,6
 4b4:	00000073          	ecall
 4b8:	8082                	ret

00000000000004ba <exec>:
 4ba:	489d                	li	a7,7
 4bc:	00000073          	ecall
 4c0:	8082                	ret

00000000000004c2 <open>:
 4c2:	48bd                	li	a7,15
 4c4:	00000073          	ecall
 4c8:	8082                	ret

00000000000004ca <mknod>:
 4ca:	48c5                	li	a7,17
 4cc:	00000073          	ecall
 4d0:	8082                	ret

00000000000004d2 <unlink>:
 4d2:	48c9                	li	a7,18
 4d4:	00000073          	ecall
 4d8:	8082                	ret

00000000000004da <fstat>:
 4da:	48a1                	li	a7,8
 4dc:	00000073          	ecall
 4e0:	8082                	ret

00000000000004e2 <link>:
 4e2:	48cd                	li	a7,19
 4e4:	00000073          	ecall
 4e8:	8082                	ret

00000000000004ea <mkdir>:
 4ea:	48d1                	li	a7,20
 4ec:	00000073          	ecall
 4f0:	8082                	ret

00000000000004f2 <chdir>:
 4f2:	48a5                	li	a7,9
 4f4:	00000073          	ecall
 4f8:	8082                	ret

00000000000004fa <dup>:
 4fa:	48a9                	li	a7,10
 4fc:	00000073          	ecall
 500:	8082                	ret

0000000000000502 <getpid>:
 502:	48ad                	li	a7,11
 504:	00000073          	ecall
 508:	8082                	ret

000000000000050a <sys_sbrk>:
 50a:	48b1                	li	a7,12
 50c:	00000073          	ecall
 510:	8082                	ret

0000000000000512 <pause>:
 512:	48b5                	li	a7,13
 514:	00000073          	ecall
 518:	8082                	ret

000000000000051a <uptime>:
 51a:	48b9                	li	a7,14
 51c:	00000073          	ecall
 520:	8082                	ret

0000000000000522 <sync>:
 522:	48d9                	li	a7,22
 524:	00000073          	ecall
 528:	8082                	ret

000000000000052a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 52a:	1101                	addi	sp,sp,-32
 52c:	ec06                	sd	ra,24(sp)
 52e:	e822                	sd	s0,16(sp)
 530:	1000                	addi	s0,sp,32
 532:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 536:	4605                	li	a2,1
 538:	fef40593          	addi	a1,s0,-17
 53c:	f67ff0ef          	jal	4a2 <write>
}
 540:	60e2                	ld	ra,24(sp)
 542:	6442                	ld	s0,16(sp)
 544:	6105                	addi	sp,sp,32
 546:	8082                	ret

0000000000000548 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 548:	715d                	addi	sp,sp,-80
 54a:	e486                	sd	ra,72(sp)
 54c:	e0a2                	sd	s0,64(sp)
 54e:	f84a                	sd	s2,48(sp)
 550:	0880                	addi	s0,sp,80
 552:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 554:	c299                	beqz	a3,55a <printint+0x12>
 556:	0805c363          	bltz	a1,5dc <printint+0x94>
  neg = 0;
 55a:	4881                	li	a7,0
 55c:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 560:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
 562:	00000517          	auipc	a0,0x0
 566:	54e50513          	addi	a0,a0,1358 # ab0 <digits>
 56a:	883e                	mv	a6,a5
 56c:	2785                	addiw	a5,a5,1
 56e:	02c5f733          	remu	a4,a1,a2
 572:	972a                	add	a4,a4,a0
 574:	00074703          	lbu	a4,0(a4)
 578:	00e68023          	sb	a4,0(a3)
  } while ((x /= base) != 0);
 57c:	872e                	mv	a4,a1
 57e:	02c5d5b3          	divu	a1,a1,a2
 582:	0685                	addi	a3,a3,1
 584:	fec773e3          	bgeu	a4,a2,56a <printint+0x22>
  if (neg)
 588:	00088b63          	beqz	a7,59e <printint+0x56>
    buf[i++] = '-';
 58c:	fd078793          	addi	a5,a5,-48
 590:	97a2                	add	a5,a5,s0
 592:	02d00713          	li	a4,45
 596:	fee78423          	sb	a4,-24(a5)
 59a:	0028079b          	addiw	a5,a6,2

  while (--i >= 0)
 59e:	02f05a63          	blez	a5,5d2 <printint+0x8a>
 5a2:	fc26                	sd	s1,56(sp)
 5a4:	f44e                	sd	s3,40(sp)
 5a6:	fb840713          	addi	a4,s0,-72
 5aa:	00f704b3          	add	s1,a4,a5
 5ae:	fff70993          	addi	s3,a4,-1
 5b2:	99be                	add	s3,s3,a5
 5b4:	37fd                	addiw	a5,a5,-1
 5b6:	1782                	slli	a5,a5,0x20
 5b8:	9381                	srli	a5,a5,0x20
 5ba:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 5be:	fff4c583          	lbu	a1,-1(s1)
 5c2:	854a                	mv	a0,s2
 5c4:	f67ff0ef          	jal	52a <putc>
  while (--i >= 0)
 5c8:	14fd                	addi	s1,s1,-1
 5ca:	ff349ae3          	bne	s1,s3,5be <printint+0x76>
 5ce:	74e2                	ld	s1,56(sp)
 5d0:	79a2                	ld	s3,40(sp)
}
 5d2:	60a6                	ld	ra,72(sp)
 5d4:	6406                	ld	s0,64(sp)
 5d6:	7942                	ld	s2,48(sp)
 5d8:	6161                	addi	sp,sp,80
 5da:	8082                	ret
    x = -xx;
 5dc:	40b005b3          	neg	a1,a1
    neg = 1;
 5e0:	4885                	li	a7,1
    x = -xx;
 5e2:	bfad                	j	55c <printint+0x14>

00000000000005e4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5e4:	711d                	addi	sp,sp,-96
 5e6:	ec86                	sd	ra,88(sp)
 5e8:	e8a2                	sd	s0,80(sp)
 5ea:	e0ca                	sd	s2,64(sp)
 5ec:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 5ee:	0005c903          	lbu	s2,0(a1)
 5f2:	28090663          	beqz	s2,87e <vprintf+0x29a>
 5f6:	e4a6                	sd	s1,72(sp)
 5f8:	fc4e                	sd	s3,56(sp)
 5fa:	f852                	sd	s4,48(sp)
 5fc:	f456                	sd	s5,40(sp)
 5fe:	f05a                	sd	s6,32(sp)
 600:	ec5e                	sd	s7,24(sp)
 602:	e862                	sd	s8,16(sp)
 604:	e466                	sd	s9,8(sp)
 606:	8b2a                	mv	s6,a0
 608:	8a2e                	mv	s4,a1
 60a:	8bb2                	mv	s7,a2
  state = 0;
 60c:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 60e:	4481                	li	s1,0
 610:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 612:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 616:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 61a:	06c00c93          	li	s9,108
 61e:	a005                	j	63e <vprintf+0x5a>
        putc(fd, c0);
 620:	85ca                	mv	a1,s2
 622:	855a                	mv	a0,s6
 624:	f07ff0ef          	jal	52a <putc>
 628:	a019                	j	62e <vprintf+0x4a>
    } else if (state == '%') {
 62a:	03598263          	beq	s3,s5,64e <vprintf+0x6a>
  for (i = 0; fmt[i]; i++) {
 62e:	2485                	addiw	s1,s1,1
 630:	8726                	mv	a4,s1
 632:	009a07b3          	add	a5,s4,s1
 636:	0007c903          	lbu	s2,0(a5)
 63a:	22090a63          	beqz	s2,86e <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 63e:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 642:	fe0994e3          	bnez	s3,62a <vprintf+0x46>
      if (c0 == '%') {
 646:	fd579de3          	bne	a5,s5,620 <vprintf+0x3c>
        state = '%';
 64a:	89be                	mv	s3,a5
 64c:	b7cd                	j	62e <vprintf+0x4a>
        c1 = fmt[i + 1] & 0xff;
 64e:	00ea06b3          	add	a3,s4,a4
 652:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 656:	8636                	mv	a2,a3
      if (c1)
 658:	c681                	beqz	a3,660 <vprintf+0x7c>
        c2 = fmt[i + 2] & 0xff;
 65a:	9752                	add	a4,a4,s4
 65c:	00274603          	lbu	a2,2(a4)
      if (c0 == 'd') {
 660:	05878363          	beq	a5,s8,6a6 <vprintf+0xc2>
      } else if (c0 == 'l' && c1 == 'd') {
 664:	05978d63          	beq	a5,s9,6be <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 668:	07500713          	li	a4,117
 66c:	0ee78763          	beq	a5,a4,75a <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 670:	07800713          	li	a4,120
 674:	12e78963          	beq	a5,a4,7a6 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 678:	07000713          	li	a4,112
 67c:	14e78e63          	beq	a5,a4,7d8 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 680:	06300713          	li	a4,99
 684:	18e78e63          	beq	a5,a4,820 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 688:	07300713          	li	a4,115
 68c:	1ae78463          	beq	a5,a4,834 <vprintf+0x250>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 690:	02500713          	li	a4,37
 694:	04e79563          	bne	a5,a4,6de <vprintf+0xfa>
        putc(fd, '%');
 698:	02500593          	li	a1,37
 69c:	855a                	mv	a0,s6
 69e:	e8dff0ef          	jal	52a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 6a2:	4981                	li	s3,0
 6a4:	b769                	j	62e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 6a6:	008b8913          	addi	s2,s7,8
 6aa:	4685                	li	a3,1
 6ac:	4629                	li	a2,10
 6ae:	000ba583          	lw	a1,0(s7)
 6b2:	855a                	mv	a0,s6
 6b4:	e95ff0ef          	jal	548 <printint>
 6b8:	8bca                	mv	s7,s2
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	bf8d                	j	62e <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'd') {
 6be:	06400793          	li	a5,100
 6c2:	02f68963          	beq	a3,a5,6f4 <vprintf+0x110>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 6c6:	06c00793          	li	a5,108
 6ca:	04f68263          	beq	a3,a5,70e <vprintf+0x12a>
      } else if (c0 == 'l' && c1 == 'u') {
 6ce:	07500793          	li	a5,117
 6d2:	0af68063          	beq	a3,a5,772 <vprintf+0x18e>
      } else if (c0 == 'l' && c1 == 'x') {
 6d6:	07800793          	li	a5,120
 6da:	0ef68263          	beq	a3,a5,7be <vprintf+0x1da>
        putc(fd, '%');
 6de:	02500593          	li	a1,37
 6e2:	855a                	mv	a0,s6
 6e4:	e47ff0ef          	jal	52a <putc>
        putc(fd, c0);
 6e8:	85ca                	mv	a1,s2
 6ea:	855a                	mv	a0,s6
 6ec:	e3fff0ef          	jal	52a <putc>
      state = 0;
 6f0:	4981                	li	s3,0
 6f2:	bf35                	j	62e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f4:	008b8913          	addi	s2,s7,8
 6f8:	4685                	li	a3,1
 6fa:	4629                	li	a2,10
 6fc:	000bb583          	ld	a1,0(s7)
 700:	855a                	mv	a0,s6
 702:	e47ff0ef          	jal	548 <printint>
        i += 1;
 706:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 708:	8bca                	mv	s7,s2
      state = 0;
 70a:	4981                	li	s3,0
        i += 1;
 70c:	b70d                	j	62e <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 70e:	06400793          	li	a5,100
 712:	02f60763          	beq	a2,a5,740 <vprintf+0x15c>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 716:	07500793          	li	a5,117
 71a:	06f60963          	beq	a2,a5,78c <vprintf+0x1a8>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 71e:	07800793          	li	a5,120
 722:	faf61ee3          	bne	a2,a5,6de <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 726:	008b8913          	addi	s2,s7,8
 72a:	4681                	li	a3,0
 72c:	4641                	li	a2,16
 72e:	000bb583          	ld	a1,0(s7)
 732:	855a                	mv	a0,s6
 734:	e15ff0ef          	jal	548 <printint>
        i += 2;
 738:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 73a:	8bca                	mv	s7,s2
      state = 0;
 73c:	4981                	li	s3,0
        i += 2;
 73e:	bdc5                	j	62e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 740:	008b8913          	addi	s2,s7,8
 744:	4685                	li	a3,1
 746:	4629                	li	a2,10
 748:	000bb583          	ld	a1,0(s7)
 74c:	855a                	mv	a0,s6
 74e:	dfbff0ef          	jal	548 <printint>
        i += 2;
 752:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 754:	8bca                	mv	s7,s2
      state = 0;
 756:	4981                	li	s3,0
        i += 2;
 758:	bdd9                	j	62e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 75a:	008b8913          	addi	s2,s7,8
 75e:	4681                	li	a3,0
 760:	4629                	li	a2,10
 762:	000be583          	lwu	a1,0(s7)
 766:	855a                	mv	a0,s6
 768:	de1ff0ef          	jal	548 <printint>
 76c:	8bca                	mv	s7,s2
      state = 0;
 76e:	4981                	li	s3,0
 770:	bd7d                	j	62e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 772:	008b8913          	addi	s2,s7,8
 776:	4681                	li	a3,0
 778:	4629                	li	a2,10
 77a:	000bb583          	ld	a1,0(s7)
 77e:	855a                	mv	a0,s6
 780:	dc9ff0ef          	jal	548 <printint>
        i += 1;
 784:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 786:	8bca                	mv	s7,s2
      state = 0;
 788:	4981                	li	s3,0
        i += 1;
 78a:	b555                	j	62e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 78c:	008b8913          	addi	s2,s7,8
 790:	4681                	li	a3,0
 792:	4629                	li	a2,10
 794:	000bb583          	ld	a1,0(s7)
 798:	855a                	mv	a0,s6
 79a:	dafff0ef          	jal	548 <printint>
        i += 2;
 79e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7a0:	8bca                	mv	s7,s2
      state = 0;
 7a2:	4981                	li	s3,0
        i += 2;
 7a4:	b569                	j	62e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 7a6:	008b8913          	addi	s2,s7,8
 7aa:	4681                	li	a3,0
 7ac:	4641                	li	a2,16
 7ae:	000be583          	lwu	a1,0(s7)
 7b2:	855a                	mv	a0,s6
 7b4:	d95ff0ef          	jal	548 <printint>
 7b8:	8bca                	mv	s7,s2
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	bd8d                	j	62e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7be:	008b8913          	addi	s2,s7,8
 7c2:	4681                	li	a3,0
 7c4:	4641                	li	a2,16
 7c6:	000bb583          	ld	a1,0(s7)
 7ca:	855a                	mv	a0,s6
 7cc:	d7dff0ef          	jal	548 <printint>
        i += 1;
 7d0:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7d2:	8bca                	mv	s7,s2
      state = 0;
 7d4:	4981                	li	s3,0
        i += 1;
 7d6:	bda1                	j	62e <vprintf+0x4a>
 7d8:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7da:	008b8d13          	addi	s10,s7,8
 7de:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7e2:	03000593          	li	a1,48
 7e6:	855a                	mv	a0,s6
 7e8:	d43ff0ef          	jal	52a <putc>
  putc(fd, 'x');
 7ec:	07800593          	li	a1,120
 7f0:	855a                	mv	a0,s6
 7f2:	d39ff0ef          	jal	52a <putc>
 7f6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7f8:	00000b97          	auipc	s7,0x0
 7fc:	2b8b8b93          	addi	s7,s7,696 # ab0 <digits>
 800:	03c9d793          	srli	a5,s3,0x3c
 804:	97de                	add	a5,a5,s7
 806:	0007c583          	lbu	a1,0(a5)
 80a:	855a                	mv	a0,s6
 80c:	d1fff0ef          	jal	52a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 810:	0992                	slli	s3,s3,0x4
 812:	397d                	addiw	s2,s2,-1
 814:	fe0916e3          	bnez	s2,800 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 818:	8bea                	mv	s7,s10
      state = 0;
 81a:	4981                	li	s3,0
 81c:	6d02                	ld	s10,0(sp)
 81e:	bd01                	j	62e <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 820:	008b8913          	addi	s2,s7,8
 824:	000bc583          	lbu	a1,0(s7)
 828:	855a                	mv	a0,s6
 82a:	d01ff0ef          	jal	52a <putc>
 82e:	8bca                	mv	s7,s2
      state = 0;
 830:	4981                	li	s3,0
 832:	bbf5                	j	62e <vprintf+0x4a>
        if ((s = va_arg(ap, char *)) == 0)
 834:	008b8993          	addi	s3,s7,8
 838:	000bb903          	ld	s2,0(s7)
 83c:	00090f63          	beqz	s2,85a <vprintf+0x276>
        for (; *s; s++)
 840:	00094583          	lbu	a1,0(s2)
 844:	c195                	beqz	a1,868 <vprintf+0x284>
          putc(fd, *s);
 846:	855a                	mv	a0,s6
 848:	ce3ff0ef          	jal	52a <putc>
        for (; *s; s++)
 84c:	0905                	addi	s2,s2,1
 84e:	00094583          	lbu	a1,0(s2)
 852:	f9f5                	bnez	a1,846 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 854:	8bce                	mv	s7,s3
      state = 0;
 856:	4981                	li	s3,0
 858:	bbd9                	j	62e <vprintf+0x4a>
          s = "(null)";
 85a:	00000917          	auipc	s2,0x0
 85e:	24e90913          	addi	s2,s2,590 # aa8 <malloc+0x142>
        for (; *s; s++)
 862:	02800593          	li	a1,40
 866:	b7c5                	j	846 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 868:	8bce                	mv	s7,s3
      state = 0;
 86a:	4981                	li	s3,0
 86c:	b3c9                	j	62e <vprintf+0x4a>
 86e:	64a6                	ld	s1,72(sp)
 870:	79e2                	ld	s3,56(sp)
 872:	7a42                	ld	s4,48(sp)
 874:	7aa2                	ld	s5,40(sp)
 876:	7b02                	ld	s6,32(sp)
 878:	6be2                	ld	s7,24(sp)
 87a:	6c42                	ld	s8,16(sp)
 87c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 87e:	60e6                	ld	ra,88(sp)
 880:	6446                	ld	s0,80(sp)
 882:	6906                	ld	s2,64(sp)
 884:	6125                	addi	sp,sp,96
 886:	8082                	ret

0000000000000888 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 888:	715d                	addi	sp,sp,-80
 88a:	ec06                	sd	ra,24(sp)
 88c:	e822                	sd	s0,16(sp)
 88e:	1000                	addi	s0,sp,32
 890:	e010                	sd	a2,0(s0)
 892:	e414                	sd	a3,8(s0)
 894:	e818                	sd	a4,16(s0)
 896:	ec1c                	sd	a5,24(s0)
 898:	03043023          	sd	a6,32(s0)
 89c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8a0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8a4:	8622                	mv	a2,s0
 8a6:	d3fff0ef          	jal	5e4 <vprintf>
}
 8aa:	60e2                	ld	ra,24(sp)
 8ac:	6442                	ld	s0,16(sp)
 8ae:	6161                	addi	sp,sp,80
 8b0:	8082                	ret

00000000000008b2 <printf>:

void
printf(const char *fmt, ...)
{
 8b2:	711d                	addi	sp,sp,-96
 8b4:	ec06                	sd	ra,24(sp)
 8b6:	e822                	sd	s0,16(sp)
 8b8:	1000                	addi	s0,sp,32
 8ba:	e40c                	sd	a1,8(s0)
 8bc:	e810                	sd	a2,16(s0)
 8be:	ec14                	sd	a3,24(s0)
 8c0:	f018                	sd	a4,32(s0)
 8c2:	f41c                	sd	a5,40(s0)
 8c4:	03043823          	sd	a6,48(s0)
 8c8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8cc:	00840613          	addi	a2,s0,8
 8d0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8d4:	85aa                	mv	a1,a0
 8d6:	4505                	li	a0,1
 8d8:	d0dff0ef          	jal	5e4 <vprintf>
}
 8dc:	60e2                	ld	ra,24(sp)
 8de:	6442                	ld	s0,16(sp)
 8e0:	6125                	addi	sp,sp,96
 8e2:	8082                	ret

00000000000008e4 <free>:
 8e4:	1141                	addi	sp,sp,-16
 8e6:	e422                	sd	s0,8(sp)
 8e8:	0800                	addi	s0,sp,16
 8ea:	ff050693          	addi	a3,a0,-16
 8ee:	00000797          	auipc	a5,0x0
 8f2:	7127b783          	ld	a5,1810(a5) # 1000 <freep>
 8f6:	a02d                	j	920 <free+0x3c>
 8f8:	4618                	lw	a4,8(a2)
 8fa:	9f2d                	addw	a4,a4,a1
 8fc:	fee52c23          	sw	a4,-8(a0)
 900:	6398                	ld	a4,0(a5)
 902:	6310                	ld	a2,0(a4)
 904:	a83d                	j	942 <free+0x5e>
 906:	ff852703          	lw	a4,-8(a0)
 90a:	9f31                	addw	a4,a4,a2
 90c:	c798                	sw	a4,8(a5)
 90e:	ff053683          	ld	a3,-16(a0)
 912:	a091                	j	956 <free+0x72>
 914:	6398                	ld	a4,0(a5)
 916:	00e7e463          	bltu	a5,a4,91e <free+0x3a>
 91a:	00e6ea63          	bltu	a3,a4,92e <free+0x4a>
 91e:	87ba                	mv	a5,a4
 920:	fed7fae3          	bgeu	a5,a3,914 <free+0x30>
 924:	6398                	ld	a4,0(a5)
 926:	00e6e463          	bltu	a3,a4,92e <free+0x4a>
 92a:	fee7eae3          	bltu	a5,a4,91e <free+0x3a>
 92e:	ff852583          	lw	a1,-8(a0)
 932:	6390                	ld	a2,0(a5)
 934:	02059813          	slli	a6,a1,0x20
 938:	01c85713          	srli	a4,a6,0x1c
 93c:	9736                	add	a4,a4,a3
 93e:	fae60de3          	beq	a2,a4,8f8 <free+0x14>
 942:	fec53823          	sd	a2,-16(a0)
 946:	4790                	lw	a2,8(a5)
 948:	02061593          	slli	a1,a2,0x20
 94c:	01c5d713          	srli	a4,a1,0x1c
 950:	973e                	add	a4,a4,a5
 952:	fae68ae3          	beq	a3,a4,906 <free+0x22>
 956:	e394                	sd	a3,0(a5)
 958:	00000717          	auipc	a4,0x0
 95c:	6af73423          	sd	a5,1704(a4) # 1000 <freep>
 960:	6422                	ld	s0,8(sp)
 962:	0141                	addi	sp,sp,16
 964:	8082                	ret

0000000000000966 <malloc>:
 966:	7139                	addi	sp,sp,-64
 968:	fc06                	sd	ra,56(sp)
 96a:	f822                	sd	s0,48(sp)
 96c:	f426                	sd	s1,40(sp)
 96e:	ec4e                	sd	s3,24(sp)
 970:	0080                	addi	s0,sp,64
 972:	02051493          	slli	s1,a0,0x20
 976:	9081                	srli	s1,s1,0x20
 978:	04bd                	addi	s1,s1,15
 97a:	8091                	srli	s1,s1,0x4
 97c:	0014899b          	addiw	s3,s1,1
 980:	0485                	addi	s1,s1,1
 982:	00000517          	auipc	a0,0x0
 986:	67e53503          	ld	a0,1662(a0) # 1000 <freep>
 98a:	c915                	beqz	a0,9be <malloc+0x58>
 98c:	611c                	ld	a5,0(a0)
 98e:	4798                	lw	a4,8(a5)
 990:	08977a63          	bgeu	a4,s1,a24 <malloc+0xbe>
 994:	f04a                	sd	s2,32(sp)
 996:	e852                	sd	s4,16(sp)
 998:	e456                	sd	s5,8(sp)
 99a:	e05a                	sd	s6,0(sp)
 99c:	8a4e                	mv	s4,s3
 99e:	0009871b          	sext.w	a4,s3
 9a2:	6685                	lui	a3,0x1
 9a4:	00d77363          	bgeu	a4,a3,9aa <malloc+0x44>
 9a8:	6a05                	lui	s4,0x1
 9aa:	000a0b1b          	sext.w	s6,s4
 9ae:	004a1a1b          	slliw	s4,s4,0x4
 9b2:	00000917          	auipc	s2,0x0
 9b6:	64e90913          	addi	s2,s2,1614 # 1000 <freep>
 9ba:	5afd                	li	s5,-1
 9bc:	a081                	j	9fc <malloc+0x96>
 9be:	f04a                	sd	s2,32(sp)
 9c0:	e852                	sd	s4,16(sp)
 9c2:	e456                	sd	s5,8(sp)
 9c4:	e05a                	sd	s6,0(sp)
 9c6:	00000797          	auipc	a5,0x0
 9ca:	67278793          	addi	a5,a5,1650 # 1038 <base>
 9ce:	00000717          	auipc	a4,0x0
 9d2:	62f73923          	sd	a5,1586(a4) # 1000 <freep>
 9d6:	e39c                	sd	a5,0(a5)
 9d8:	0007a423          	sw	zero,8(a5)
 9dc:	b7c1                	j	99c <malloc+0x36>
 9de:	6398                	ld	a4,0(a5)
 9e0:	e118                	sd	a4,0(a0)
 9e2:	a8a9                	j	a3c <malloc+0xd6>
 9e4:	01652423          	sw	s6,8(a0)
 9e8:	0541                	addi	a0,a0,16
 9ea:	efbff0ef          	jal	8e4 <free>
 9ee:	00093503          	ld	a0,0(s2)
 9f2:	c12d                	beqz	a0,a54 <malloc+0xee>
 9f4:	611c                	ld	a5,0(a0)
 9f6:	4798                	lw	a4,8(a5)
 9f8:	02977263          	bgeu	a4,s1,a1c <malloc+0xb6>
 9fc:	00093703          	ld	a4,0(s2)
 a00:	853e                	mv	a0,a5
 a02:	fef719e3          	bne	a4,a5,9f4 <malloc+0x8e>
 a06:	8552                	mv	a0,s4
 a08:	a47ff0ef          	jal	44e <sbrk>
 a0c:	fd551ce3          	bne	a0,s5,9e4 <malloc+0x7e>
 a10:	4501                	li	a0,0
 a12:	7902                	ld	s2,32(sp)
 a14:	6a42                	ld	s4,16(sp)
 a16:	6aa2                	ld	s5,8(sp)
 a18:	6b02                	ld	s6,0(sp)
 a1a:	a03d                	j	a48 <malloc+0xe2>
 a1c:	7902                	ld	s2,32(sp)
 a1e:	6a42                	ld	s4,16(sp)
 a20:	6aa2                	ld	s5,8(sp)
 a22:	6b02                	ld	s6,0(sp)
 a24:	fae48de3          	beq	s1,a4,9de <malloc+0x78>
 a28:	4137073b          	subw	a4,a4,s3
 a2c:	c798                	sw	a4,8(a5)
 a2e:	02071693          	slli	a3,a4,0x20
 a32:	01c6d713          	srli	a4,a3,0x1c
 a36:	97ba                	add	a5,a5,a4
 a38:	0137a423          	sw	s3,8(a5)
 a3c:	00000717          	auipc	a4,0x0
 a40:	5ca73223          	sd	a0,1476(a4) # 1000 <freep>
 a44:	01078513          	addi	a0,a5,16
 a48:	70e2                	ld	ra,56(sp)
 a4a:	7442                	ld	s0,48(sp)
 a4c:	74a2                	ld	s1,40(sp)
 a4e:	69e2                	ld	s3,24(sp)
 a50:	6121                	addi	sp,sp,64
 a52:	8082                	ret
 a54:	7902                	ld	s2,32(sp)
 a56:	6a42                	ld	s4,16(sp)
 a58:	6aa2                	ld	s5,8(sp)
 a5a:	6b02                	ld	s6,0(sp)
 a5c:	b7f5                	j	a48 <malloc+0xe2>
