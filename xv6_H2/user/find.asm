
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
// hola
//como es solo para leer la cadena de caracteres, se usa const
// clang-format off
void buscar_archivo(char *ruta_actual, char *archivo_a_buscar)
{
  6c:	7119                	addi	sp,sp,-128
  6e:	fc86                	sd	ra,120(sp)
  70:	f8a2                	sd	s0,112(sp)
  72:	f4a6                	sd	s1,104(sp)
  74:	f0ca                	sd	s2,96(sp)
  76:	ecce                	sd	s3,88(sp)
  78:	e8d2                	sd	s4,80(sp)
  7a:	e4d6                	sd	s5,72(sp)
  7c:	e0da                	sd	s6,64(sp)
  7e:	fc5e                	sd	s7,56(sp)
  80:	f862                	sd	s8,48(sp)
  82:	f466                	sd	s9,40(sp)
  84:	f06a                	sd	s10,32(sp)
  86:	ec6e                	sd	s11,24(sp)
  88:	0100                	addi	s0,sp,128
  8a:	892a                	mv	s2,a0
  8c:	f8b43423          	sd	a1,-120(s0)
  // Es lo que se ocupa para iterar sobre el directorio
  int file_descriptor = open(ruta_actual, O_RDONLY);
  90:	4581                	li	a1,0
  92:	440000ef          	jal	4d2 <open>
  96:	8b2a                	mv	s6,a0

  // read deuelve la cantidad de bytes que logro leer con exito
  while (read(file_descriptor, &archivo_actual, sizeof(archivo_actual)) == sizeof(archivo_actual)) {
  98:	00001a97          	auipc	s5,0x1
  9c:	f78a8a93          	addi	s5,s5,-136 # 1010 <archivo_actual>

    // le sumo 2, uno para '/' y otro porciacaso para el '\0'
    char dest[strlen(ruta_actual) + strlen(archivo_actual.name) + 2]; //deberia ser inecesario poner el * al principio ya que al ser un arreglo, debe ser un puntero
  a0:	00001a17          	auipc	s4,0x1
  a4:	f72a0a13          	addi	s4,s4,-142 # 1012 <archivo_actual+0x2>
    dest[0] = '\0'; // Si declaras pero no incializas una variable en C, esta contiene basura por defecto
    if (strlen(ruta_actual) == 2) {
  a8:	4c89                	li	s9,2
      ruta_actual[0] = '.';
  aa:	02e00d93          	li	s11,46
      ruta_actual[1] = '\0';
    }
    concatenar_cadenas(dest, ruta_actual, sizeof(dest));
    concatenar_cadenas(dest, "/", sizeof(dest));
  ae:	00001c17          	auipc	s8,0x1
  b2:	9c2c0c13          	addi	s8,s8,-1598 # a70 <malloc+0xfa>
    concatenar_cadenas(dest, archivo_actual.name, sizeof(dest));

    // El inum == 0, se usa en xv6 para indicar que este directorio es un espacio que el sistema dejo reservado pero que actualmente no contiene ningun archivo realmente
    if (archivo_actual.inum == 0 || strcmp(archivo_actual.name, ".") == 0 || strcmp(archivo_actual.name, "..") == 0) continue; // igual deberia funcionar sin esta linea
  b6:	00001d17          	auipc	s10,0x1
  ba:	9c2d0d13          	addi	s10,s10,-1598 # a78 <malloc+0x102>
  while (read(file_descriptor, &archivo_actual, sizeof(archivo_actual)) == sizeof(archivo_actual)) {
  be:	a02d                	j	e8 <buscar_archivo+0x7c>
      ruta_actual[0] = '.';
  c0:	01b90023          	sb	s11,0(s2)
      ruta_actual[1] = '\0';
  c4:	000900a3          	sb	zero,1(s2)
  c8:	a0a5                	j	130 <buscar_archivo+0xc4>

    // Supongo que al poner este condicional antes que el que ve si el archivo es una carpeta, esta función también identificara carpetas con el nombre buscado

    if (strcmp(archivo_actual.name,archivo_a_buscar) == 0) { // No se pueden comparar usando == pues son direcciones de memoria
      printf("%s\n", dest);
  ca:	85ce                	mv	a1,s3
  cc:	00001517          	auipc	a0,0x1
  d0:	9bc50513          	addi	a0,a0,-1604 # a88 <malloc+0x112>
  d4:	7ee000ef          	jal	8c2 <printf>
  d8:	a845                	j	188 <buscar_archivo+0x11c>
    }
  
    if (stat(dest, &st) < 0) continue; // aca se saca la informacion del archivo si es que se pudo y si no se salta al siguiente bucle
    
    if (st.type == T_DIR) {
      buscar_archivo(dest, archivo_a_buscar);
  da:	f8843583          	ld	a1,-120(s0)
  de:	854e                	mv	a0,s3
  e0:	f8dff0ef          	jal	6c <buscar_archivo>
  e4:	a0d1                	j	1a8 <buscar_archivo+0x13c>
    if (archivo_actual.inum == 0 || strcmp(archivo_actual.name, ".") == 0 || strcmp(archivo_actual.name, "..") == 0) continue; // igual deberia funcionar sin esta linea
  e6:	815e                	mv	sp,s7
  while (read(file_descriptor, &archivo_actual, sizeof(archivo_actual)) == sizeof(archivo_actual)) {
  e8:	4641                	li	a2,16
  ea:	85d6                	mv	a1,s5
  ec:	855a                	mv	a0,s6
  ee:	3bc000ef          	jal	4aa <read>
  f2:	47c1                	li	a5,16
  f4:	0af51c63          	bne	a0,a5,1ac <buscar_archivo+0x140>
  f8:	8b8a                	mv	s7,sp
    char dest[strlen(ruta_actual) + strlen(archivo_actual.name) + 2]; //deberia ser inecesario poner el * al principio ya que al ser un arreglo, debe ser un puntero
  fa:	854a                	mv	a0,s2
  fc:	15a000ef          	jal	256 <strlen>
 100:	0005049b          	sext.w	s1,a0
 104:	8552                	mv	a0,s4
 106:	150000ef          	jal	256 <strlen>
 10a:	9ca9                	addw	s1,s1,a0
 10c:	2489                	addiw	s1,s1,2
 10e:	02049793          	slli	a5,s1,0x20
 112:	9381                	srli	a5,a5,0x20
 114:	07bd                	addi	a5,a5,15
 116:	8391                	srli	a5,a5,0x4
 118:	0792                	slli	a5,a5,0x4
 11a:	40f10133          	sub	sp,sp,a5
 11e:	898a                	mv	s3,sp
    dest[0] = '\0'; // Si declaras pero no incializas una variable en C, esta contiene basura por defecto
 120:	00010023          	sb	zero,0(sp)
    if (strlen(ruta_actual) == 2) {
 124:	854a                	mv	a0,s2
 126:	130000ef          	jal	256 <strlen>
 12a:	2501                	sext.w	a0,a0
 12c:	f9950ae3          	beq	a0,s9,c0 <buscar_archivo+0x54>
    concatenar_cadenas(dest, ruta_actual, sizeof(dest));
 130:	2481                	sext.w	s1,s1
 132:	8626                	mv	a2,s1
 134:	85ca                	mv	a1,s2
 136:	854e                	mv	a0,s3
 138:	ec9ff0ef          	jal	0 <concatenar_cadenas>
    concatenar_cadenas(dest, "/", sizeof(dest));
 13c:	8626                	mv	a2,s1
 13e:	85e2                	mv	a1,s8
 140:	854e                	mv	a0,s3
 142:	ebfff0ef          	jal	0 <concatenar_cadenas>
    concatenar_cadenas(dest, archivo_actual.name, sizeof(dest));
 146:	8626                	mv	a2,s1
 148:	85d2                	mv	a1,s4
 14a:	854e                	mv	a0,s3
 14c:	eb5ff0ef          	jal	0 <concatenar_cadenas>
    if (archivo_actual.inum == 0 || strcmp(archivo_actual.name, ".") == 0 || strcmp(archivo_actual.name, "..") == 0) continue; // igual deberia funcionar sin esta linea
 150:	000ad783          	lhu	a5,0(s5)
 154:	dbc9                	beqz	a5,e6 <buscar_archivo+0x7a>
 156:	85ea                	mv	a1,s10
 158:	8552                	mv	a0,s4
 15a:	0d0000ef          	jal	22a <strcmp>
 15e:	d541                	beqz	a0,e6 <buscar_archivo+0x7a>
 160:	00001597          	auipc	a1,0x1
 164:	92058593          	addi	a1,a1,-1760 # a80 <malloc+0x10a>
 168:	00001517          	auipc	a0,0x1
 16c:	eaa50513          	addi	a0,a0,-342 # 1012 <archivo_actual+0x2>
 170:	0ba000ef          	jal	22a <strcmp>
 174:	d92d                	beqz	a0,e6 <buscar_archivo+0x7a>
    if (strcmp(archivo_actual.name,archivo_a_buscar) == 0) { // No se pueden comparar usando == pues son direcciones de memoria
 176:	f8843583          	ld	a1,-120(s0)
 17a:	00001517          	auipc	a0,0x1
 17e:	e9850513          	addi	a0,a0,-360 # 1012 <archivo_actual+0x2>
 182:	0a8000ef          	jal	22a <strcmp>
 186:	d131                	beqz	a0,ca <buscar_archivo+0x5e>
    if (stat(dest, &st) < 0) continue; // aca se saca la informacion del archivo si es que se pudo y si no se salta al siguiente bucle
 188:	00001597          	auipc	a1,0x1
 18c:	e9858593          	addi	a1,a1,-360 # 1020 <st>
 190:	854e                	mv	a0,s3
 192:	1a4000ef          	jal	336 <stat>
 196:	f40548e3          	bltz	a0,e6 <buscar_archivo+0x7a>
    if (st.type == T_DIR) {
 19a:	00001717          	auipc	a4,0x1
 19e:	e8e71703          	lh	a4,-370(a4) # 1028 <st+0x8>
 1a2:	4785                	li	a5,1
 1a4:	f2f70be3          	beq	a4,a5,da <buscar_archivo+0x6e>
 1a8:	815e                	mv	sp,s7
 1aa:	bf3d                	j	e8 <buscar_archivo+0x7c>
    }
  }
}
 1ac:	f8040113          	addi	sp,s0,-128
 1b0:	70e6                	ld	ra,120(sp)
 1b2:	7446                	ld	s0,112(sp)
 1b4:	74a6                	ld	s1,104(sp)
 1b6:	7906                	ld	s2,96(sp)
 1b8:	69e6                	ld	s3,88(sp)
 1ba:	6a46                	ld	s4,80(sp)
 1bc:	6aa6                	ld	s5,72(sp)
 1be:	6b06                	ld	s6,64(sp)
 1c0:	7be2                	ld	s7,56(sp)
 1c2:	7c42                	ld	s8,48(sp)
 1c4:	7ca2                	ld	s9,40(sp)
 1c6:	7d02                	ld	s10,32(sp)
 1c8:	6de2                	ld	s11,24(sp)
 1ca:	6109                	addi	sp,sp,128
 1cc:	8082                	ret

00000000000001ce <main>:

int
main(int argc, char *argv[])
{
 1ce:	1141                	addi	sp,sp,-16
 1d0:	e406                	sd	ra,8(sp)
 1d2:	e022                	sd	s0,0(sp)
 1d4:	0800                	addi	s0,sp,16
  // estoy asumiendo que se usa la ruta relativa
  if (argc < 3) {
 1d6:	4709                	li	a4,2
 1d8:	00a74b63          	blt	a4,a0,1ee <main+0x20>
    printf("find ./ruta_relativa archivo_a_buscar\n");
 1dc:	00001517          	auipc	a0,0x1
 1e0:	8b450513          	addi	a0,a0,-1868 # a90 <malloc+0x11a>
 1e4:	6de000ef          	jal	8c2 <printf>
    exit(1);
 1e8:	4505                	li	a0,1
 1ea:	2a8000ef          	jal	492 <exit>
 1ee:	87ae                	mv	a5,a1
  }

  buscar_archivo(argv[1], argv[2]);
 1f0:	698c                	ld	a1,16(a1)
 1f2:	6788                	ld	a0,8(a5)
 1f4:	e79ff0ef          	jal	6c <buscar_archivo>
  // argv[0] es el nombre del propio ejecutable
  // argv[1] es el primer argumento real que pasas en la terminal

  exit(0);
 1f8:	4501                	li	a0,0
 1fa:	298000ef          	jal	492 <exit>

00000000000001fe <start>:
 1fe:	1141                	addi	sp,sp,-16
 200:	e406                	sd	ra,8(sp)
 202:	e022                	sd	s0,0(sp)
 204:	0800                	addi	s0,sp,16
 206:	fc9ff0ef          	jal	1ce <main>
 20a:	288000ef          	jal	492 <exit>

000000000000020e <strcpy>:
 20e:	1141                	addi	sp,sp,-16
 210:	e422                	sd	s0,8(sp)
 212:	0800                	addi	s0,sp,16
 214:	87aa                	mv	a5,a0
 216:	0585                	addi	a1,a1,1
 218:	0785                	addi	a5,a5,1
 21a:	fff5c703          	lbu	a4,-1(a1)
 21e:	fee78fa3          	sb	a4,-1(a5)
 222:	fb75                	bnez	a4,216 <strcpy+0x8>
 224:	6422                	ld	s0,8(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret

000000000000022a <strcmp>:
 22a:	1141                	addi	sp,sp,-16
 22c:	e422                	sd	s0,8(sp)
 22e:	0800                	addi	s0,sp,16
 230:	00054783          	lbu	a5,0(a0)
 234:	cb91                	beqz	a5,248 <strcmp+0x1e>
 236:	0005c703          	lbu	a4,0(a1)
 23a:	00f71763          	bne	a4,a5,248 <strcmp+0x1e>
 23e:	0505                	addi	a0,a0,1
 240:	0585                	addi	a1,a1,1
 242:	00054783          	lbu	a5,0(a0)
 246:	fbe5                	bnez	a5,236 <strcmp+0xc>
 248:	0005c503          	lbu	a0,0(a1)
 24c:	40a7853b          	subw	a0,a5,a0
 250:	6422                	ld	s0,8(sp)
 252:	0141                	addi	sp,sp,16
 254:	8082                	ret

0000000000000256 <strlen>:
 256:	1141                	addi	sp,sp,-16
 258:	e422                	sd	s0,8(sp)
 25a:	0800                	addi	s0,sp,16
 25c:	00054783          	lbu	a5,0(a0)
 260:	cf91                	beqz	a5,27c <strlen+0x26>
 262:	0505                	addi	a0,a0,1
 264:	87aa                	mv	a5,a0
 266:	86be                	mv	a3,a5
 268:	0785                	addi	a5,a5,1
 26a:	fff7c703          	lbu	a4,-1(a5)
 26e:	ff65                	bnez	a4,266 <strlen+0x10>
 270:	40a6853b          	subw	a0,a3,a0
 274:	2505                	addiw	a0,a0,1
 276:	6422                	ld	s0,8(sp)
 278:	0141                	addi	sp,sp,16
 27a:	8082                	ret
 27c:	4501                	li	a0,0
 27e:	bfe5                	j	276 <strlen+0x20>

0000000000000280 <memset>:
 280:	1141                	addi	sp,sp,-16
 282:	e422                	sd	s0,8(sp)
 284:	0800                	addi	s0,sp,16
 286:	ca19                	beqz	a2,29c <memset+0x1c>
 288:	87aa                	mv	a5,a0
 28a:	1602                	slli	a2,a2,0x20
 28c:	9201                	srli	a2,a2,0x20
 28e:	00a60733          	add	a4,a2,a0
 292:	00b78023          	sb	a1,0(a5)
 296:	0785                	addi	a5,a5,1
 298:	fee79de3          	bne	a5,a4,292 <memset+0x12>
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret

00000000000002a2 <strchr>:
 2a2:	1141                	addi	sp,sp,-16
 2a4:	e422                	sd	s0,8(sp)
 2a6:	0800                	addi	s0,sp,16
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	cb99                	beqz	a5,2c2 <strchr+0x20>
 2ae:	00f58763          	beq	a1,a5,2bc <strchr+0x1a>
 2b2:	0505                	addi	a0,a0,1
 2b4:	00054783          	lbu	a5,0(a0)
 2b8:	fbfd                	bnez	a5,2ae <strchr+0xc>
 2ba:	4501                	li	a0,0
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret
 2c2:	4501                	li	a0,0
 2c4:	bfe5                	j	2bc <strchr+0x1a>

00000000000002c6 <gets>:
 2c6:	711d                	addi	sp,sp,-96
 2c8:	ec86                	sd	ra,88(sp)
 2ca:	e8a2                	sd	s0,80(sp)
 2cc:	e4a6                	sd	s1,72(sp)
 2ce:	e0ca                	sd	s2,64(sp)
 2d0:	fc4e                	sd	s3,56(sp)
 2d2:	f852                	sd	s4,48(sp)
 2d4:	f456                	sd	s5,40(sp)
 2d6:	f05a                	sd	s6,32(sp)
 2d8:	ec5e                	sd	s7,24(sp)
 2da:	1080                	addi	s0,sp,96
 2dc:	8baa                	mv	s7,a0
 2de:	8a2e                	mv	s4,a1
 2e0:	892a                	mv	s2,a0
 2e2:	4481                	li	s1,0
 2e4:	4aa9                	li	s5,10
 2e6:	4b35                	li	s6,13
 2e8:	89a6                	mv	s3,s1
 2ea:	2485                	addiw	s1,s1,1
 2ec:	0344d663          	bge	s1,s4,318 <gets+0x52>
 2f0:	4605                	li	a2,1
 2f2:	faf40593          	addi	a1,s0,-81
 2f6:	4501                	li	a0,0
 2f8:	1b2000ef          	jal	4aa <read>
 2fc:	00a05e63          	blez	a0,318 <gets+0x52>
 300:	faf44783          	lbu	a5,-81(s0)
 304:	00f90023          	sb	a5,0(s2)
 308:	01578763          	beq	a5,s5,316 <gets+0x50>
 30c:	0905                	addi	s2,s2,1
 30e:	fd679de3          	bne	a5,s6,2e8 <gets+0x22>
 312:	89a6                	mv	s3,s1
 314:	a011                	j	318 <gets+0x52>
 316:	89a6                	mv	s3,s1
 318:	99de                	add	s3,s3,s7
 31a:	00098023          	sb	zero,0(s3)
 31e:	855e                	mv	a0,s7
 320:	60e6                	ld	ra,88(sp)
 322:	6446                	ld	s0,80(sp)
 324:	64a6                	ld	s1,72(sp)
 326:	6906                	ld	s2,64(sp)
 328:	79e2                	ld	s3,56(sp)
 32a:	7a42                	ld	s4,48(sp)
 32c:	7aa2                	ld	s5,40(sp)
 32e:	7b02                	ld	s6,32(sp)
 330:	6be2                	ld	s7,24(sp)
 332:	6125                	addi	sp,sp,96
 334:	8082                	ret

0000000000000336 <stat>:
 336:	1101                	addi	sp,sp,-32
 338:	ec06                	sd	ra,24(sp)
 33a:	e822                	sd	s0,16(sp)
 33c:	e04a                	sd	s2,0(sp)
 33e:	1000                	addi	s0,sp,32
 340:	892e                	mv	s2,a1
 342:	4581                	li	a1,0
 344:	18e000ef          	jal	4d2 <open>
 348:	02054263          	bltz	a0,36c <stat+0x36>
 34c:	e426                	sd	s1,8(sp)
 34e:	84aa                	mv	s1,a0
 350:	85ca                	mv	a1,s2
 352:	198000ef          	jal	4ea <fstat>
 356:	892a                	mv	s2,a0
 358:	8526                	mv	a0,s1
 35a:	160000ef          	jal	4ba <close>
 35e:	64a2                	ld	s1,8(sp)
 360:	854a                	mv	a0,s2
 362:	60e2                	ld	ra,24(sp)
 364:	6442                	ld	s0,16(sp)
 366:	6902                	ld	s2,0(sp)
 368:	6105                	addi	sp,sp,32
 36a:	8082                	ret
 36c:	597d                	li	s2,-1
 36e:	bfcd                	j	360 <stat+0x2a>

0000000000000370 <atoi>:
 370:	1141                	addi	sp,sp,-16
 372:	e422                	sd	s0,8(sp)
 374:	0800                	addi	s0,sp,16
 376:	00054683          	lbu	a3,0(a0)
 37a:	fd06879b          	addiw	a5,a3,-48
 37e:	0ff7f793          	zext.b	a5,a5
 382:	4625                	li	a2,9
 384:	02f66863          	bltu	a2,a5,3b4 <atoi+0x44>
 388:	872a                	mv	a4,a0
 38a:	4501                	li	a0,0
 38c:	0705                	addi	a4,a4,1
 38e:	0025179b          	slliw	a5,a0,0x2
 392:	9fa9                	addw	a5,a5,a0
 394:	0017979b          	slliw	a5,a5,0x1
 398:	9fb5                	addw	a5,a5,a3
 39a:	fd07851b          	addiw	a0,a5,-48
 39e:	00074683          	lbu	a3,0(a4)
 3a2:	fd06879b          	addiw	a5,a3,-48
 3a6:	0ff7f793          	zext.b	a5,a5
 3aa:	fef671e3          	bgeu	a2,a5,38c <atoi+0x1c>
 3ae:	6422                	ld	s0,8(sp)
 3b0:	0141                	addi	sp,sp,16
 3b2:	8082                	ret
 3b4:	4501                	li	a0,0
 3b6:	bfe5                	j	3ae <atoi+0x3e>

00000000000003b8 <memmove>:
 3b8:	1141                	addi	sp,sp,-16
 3ba:	e422                	sd	s0,8(sp)
 3bc:	0800                	addi	s0,sp,16
 3be:	02b57463          	bgeu	a0,a1,3e6 <memmove+0x2e>
 3c2:	00c05f63          	blez	a2,3e0 <memmove+0x28>
 3c6:	1602                	slli	a2,a2,0x20
 3c8:	9201                	srli	a2,a2,0x20
 3ca:	00c507b3          	add	a5,a0,a2
 3ce:	872a                	mv	a4,a0
 3d0:	0585                	addi	a1,a1,1
 3d2:	0705                	addi	a4,a4,1
 3d4:	fff5c683          	lbu	a3,-1(a1)
 3d8:	fed70fa3          	sb	a3,-1(a4)
 3dc:	fef71ae3          	bne	a4,a5,3d0 <memmove+0x18>
 3e0:	6422                	ld	s0,8(sp)
 3e2:	0141                	addi	sp,sp,16
 3e4:	8082                	ret
 3e6:	00c50733          	add	a4,a0,a2
 3ea:	95b2                	add	a1,a1,a2
 3ec:	fec05ae3          	blez	a2,3e0 <memmove+0x28>
 3f0:	fff6079b          	addiw	a5,a2,-1
 3f4:	1782                	slli	a5,a5,0x20
 3f6:	9381                	srli	a5,a5,0x20
 3f8:	fff7c793          	not	a5,a5
 3fc:	97ba                	add	a5,a5,a4
 3fe:	15fd                	addi	a1,a1,-1
 400:	177d                	addi	a4,a4,-1
 402:	0005c683          	lbu	a3,0(a1)
 406:	00d70023          	sb	a3,0(a4)
 40a:	fee79ae3          	bne	a5,a4,3fe <memmove+0x46>
 40e:	bfc9                	j	3e0 <memmove+0x28>

0000000000000410 <memcmp>:
 410:	1141                	addi	sp,sp,-16
 412:	e422                	sd	s0,8(sp)
 414:	0800                	addi	s0,sp,16
 416:	ca05                	beqz	a2,446 <memcmp+0x36>
 418:	fff6069b          	addiw	a3,a2,-1
 41c:	1682                	slli	a3,a3,0x20
 41e:	9281                	srli	a3,a3,0x20
 420:	0685                	addi	a3,a3,1
 422:	96aa                	add	a3,a3,a0
 424:	00054783          	lbu	a5,0(a0)
 428:	0005c703          	lbu	a4,0(a1)
 42c:	00e79863          	bne	a5,a4,43c <memcmp+0x2c>
 430:	0505                	addi	a0,a0,1
 432:	0585                	addi	a1,a1,1
 434:	fed518e3          	bne	a0,a3,424 <memcmp+0x14>
 438:	4501                	li	a0,0
 43a:	a019                	j	440 <memcmp+0x30>
 43c:	40e7853b          	subw	a0,a5,a4
 440:	6422                	ld	s0,8(sp)
 442:	0141                	addi	sp,sp,16
 444:	8082                	ret
 446:	4501                	li	a0,0
 448:	bfe5                	j	440 <memcmp+0x30>

000000000000044a <memcpy>:
 44a:	1141                	addi	sp,sp,-16
 44c:	e406                	sd	ra,8(sp)
 44e:	e022                	sd	s0,0(sp)
 450:	0800                	addi	s0,sp,16
 452:	f67ff0ef          	jal	3b8 <memmove>
 456:	60a2                	ld	ra,8(sp)
 458:	6402                	ld	s0,0(sp)
 45a:	0141                	addi	sp,sp,16
 45c:	8082                	ret

000000000000045e <sbrk>:
 45e:	1141                	addi	sp,sp,-16
 460:	e406                	sd	ra,8(sp)
 462:	e022                	sd	s0,0(sp)
 464:	0800                	addi	s0,sp,16
 466:	4585                	li	a1,1
 468:	0b2000ef          	jal	51a <sys_sbrk>
 46c:	60a2                	ld	ra,8(sp)
 46e:	6402                	ld	s0,0(sp)
 470:	0141                	addi	sp,sp,16
 472:	8082                	ret

0000000000000474 <sbrklazy>:
 474:	1141                	addi	sp,sp,-16
 476:	e406                	sd	ra,8(sp)
 478:	e022                	sd	s0,0(sp)
 47a:	0800                	addi	s0,sp,16
 47c:	4589                	li	a1,2
 47e:	09c000ef          	jal	51a <sys_sbrk>
 482:	60a2                	ld	ra,8(sp)
 484:	6402                	ld	s0,0(sp)
 486:	0141                	addi	sp,sp,16
 488:	8082                	ret

000000000000048a <fork>:
 48a:	4885                	li	a7,1
 48c:	00000073          	ecall
 490:	8082                	ret

0000000000000492 <exit>:
 492:	4889                	li	a7,2
 494:	00000073          	ecall
 498:	8082                	ret

000000000000049a <wait>:
 49a:	488d                	li	a7,3
 49c:	00000073          	ecall
 4a0:	8082                	ret

00000000000004a2 <pipe>:
 4a2:	4891                	li	a7,4
 4a4:	00000073          	ecall
 4a8:	8082                	ret

00000000000004aa <read>:
 4aa:	4895                	li	a7,5
 4ac:	00000073          	ecall
 4b0:	8082                	ret

00000000000004b2 <write>:
 4b2:	48c1                	li	a7,16
 4b4:	00000073          	ecall
 4b8:	8082                	ret

00000000000004ba <close>:
 4ba:	48d5                	li	a7,21
 4bc:	00000073          	ecall
 4c0:	8082                	ret

00000000000004c2 <kill>:
 4c2:	4899                	li	a7,6
 4c4:	00000073          	ecall
 4c8:	8082                	ret

00000000000004ca <exec>:
 4ca:	489d                	li	a7,7
 4cc:	00000073          	ecall
 4d0:	8082                	ret

00000000000004d2 <open>:
 4d2:	48bd                	li	a7,15
 4d4:	00000073          	ecall
 4d8:	8082                	ret

00000000000004da <mknod>:
 4da:	48c5                	li	a7,17
 4dc:	00000073          	ecall
 4e0:	8082                	ret

00000000000004e2 <unlink>:
 4e2:	48c9                	li	a7,18
 4e4:	00000073          	ecall
 4e8:	8082                	ret

00000000000004ea <fstat>:
 4ea:	48a1                	li	a7,8
 4ec:	00000073          	ecall
 4f0:	8082                	ret

00000000000004f2 <link>:
 4f2:	48cd                	li	a7,19
 4f4:	00000073          	ecall
 4f8:	8082                	ret

00000000000004fa <mkdir>:
 4fa:	48d1                	li	a7,20
 4fc:	00000073          	ecall
 500:	8082                	ret

0000000000000502 <chdir>:
 502:	48a5                	li	a7,9
 504:	00000073          	ecall
 508:	8082                	ret

000000000000050a <dup>:
 50a:	48a9                	li	a7,10
 50c:	00000073          	ecall
 510:	8082                	ret

0000000000000512 <getpid>:
 512:	48ad                	li	a7,11
 514:	00000073          	ecall
 518:	8082                	ret

000000000000051a <sys_sbrk>:
 51a:	48b1                	li	a7,12
 51c:	00000073          	ecall
 520:	8082                	ret

0000000000000522 <pause>:
 522:	48b5                	li	a7,13
 524:	00000073          	ecall
 528:	8082                	ret

000000000000052a <uptime>:
 52a:	48b9                	li	a7,14
 52c:	00000073          	ecall
 530:	8082                	ret

0000000000000532 <sync>:
 532:	48d9                	li	a7,22
 534:	00000073          	ecall
 538:	8082                	ret

000000000000053a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 53a:	1101                	addi	sp,sp,-32
 53c:	ec06                	sd	ra,24(sp)
 53e:	e822                	sd	s0,16(sp)
 540:	1000                	addi	s0,sp,32
 542:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 546:	4605                	li	a2,1
 548:	fef40593          	addi	a1,s0,-17
 54c:	f67ff0ef          	jal	4b2 <write>
}
 550:	60e2                	ld	ra,24(sp)
 552:	6442                	ld	s0,16(sp)
 554:	6105                	addi	sp,sp,32
 556:	8082                	ret

0000000000000558 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 558:	715d                	addi	sp,sp,-80
 55a:	e486                	sd	ra,72(sp)
 55c:	e0a2                	sd	s0,64(sp)
 55e:	f84a                	sd	s2,48(sp)
 560:	0880                	addi	s0,sp,80
 562:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 564:	c299                	beqz	a3,56a <printint+0x12>
 566:	0805c363          	bltz	a1,5ec <printint+0x94>
  neg = 0;
 56a:	4881                	li	a7,0
 56c:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 570:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
 572:	00000517          	auipc	a0,0x0
 576:	54e50513          	addi	a0,a0,1358 # ac0 <digits>
 57a:	883e                	mv	a6,a5
 57c:	2785                	addiw	a5,a5,1
 57e:	02c5f733          	remu	a4,a1,a2
 582:	972a                	add	a4,a4,a0
 584:	00074703          	lbu	a4,0(a4)
 588:	00e68023          	sb	a4,0(a3)
  } while ((x /= base) != 0);
 58c:	872e                	mv	a4,a1
 58e:	02c5d5b3          	divu	a1,a1,a2
 592:	0685                	addi	a3,a3,1
 594:	fec773e3          	bgeu	a4,a2,57a <printint+0x22>
  if (neg)
 598:	00088b63          	beqz	a7,5ae <printint+0x56>
    buf[i++] = '-';
 59c:	fd078793          	addi	a5,a5,-48
 5a0:	97a2                	add	a5,a5,s0
 5a2:	02d00713          	li	a4,45
 5a6:	fee78423          	sb	a4,-24(a5)
 5aa:	0028079b          	addiw	a5,a6,2

  while (--i >= 0)
 5ae:	02f05a63          	blez	a5,5e2 <printint+0x8a>
 5b2:	fc26                	sd	s1,56(sp)
 5b4:	f44e                	sd	s3,40(sp)
 5b6:	fb840713          	addi	a4,s0,-72
 5ba:	00f704b3          	add	s1,a4,a5
 5be:	fff70993          	addi	s3,a4,-1
 5c2:	99be                	add	s3,s3,a5
 5c4:	37fd                	addiw	a5,a5,-1
 5c6:	1782                	slli	a5,a5,0x20
 5c8:	9381                	srli	a5,a5,0x20
 5ca:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 5ce:	fff4c583          	lbu	a1,-1(s1)
 5d2:	854a                	mv	a0,s2
 5d4:	f67ff0ef          	jal	53a <putc>
  while (--i >= 0)
 5d8:	14fd                	addi	s1,s1,-1
 5da:	ff349ae3          	bne	s1,s3,5ce <printint+0x76>
 5de:	74e2                	ld	s1,56(sp)
 5e0:	79a2                	ld	s3,40(sp)
}
 5e2:	60a6                	ld	ra,72(sp)
 5e4:	6406                	ld	s0,64(sp)
 5e6:	7942                	ld	s2,48(sp)
 5e8:	6161                	addi	sp,sp,80
 5ea:	8082                	ret
    x = -xx;
 5ec:	40b005b3          	neg	a1,a1
    neg = 1;
 5f0:	4885                	li	a7,1
    x = -xx;
 5f2:	bfad                	j	56c <printint+0x14>

00000000000005f4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5f4:	711d                	addi	sp,sp,-96
 5f6:	ec86                	sd	ra,88(sp)
 5f8:	e8a2                	sd	s0,80(sp)
 5fa:	e0ca                	sd	s2,64(sp)
 5fc:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 5fe:	0005c903          	lbu	s2,0(a1)
 602:	28090663          	beqz	s2,88e <vprintf+0x29a>
 606:	e4a6                	sd	s1,72(sp)
 608:	fc4e                	sd	s3,56(sp)
 60a:	f852                	sd	s4,48(sp)
 60c:	f456                	sd	s5,40(sp)
 60e:	f05a                	sd	s6,32(sp)
 610:	ec5e                	sd	s7,24(sp)
 612:	e862                	sd	s8,16(sp)
 614:	e466                	sd	s9,8(sp)
 616:	8b2a                	mv	s6,a0
 618:	8a2e                	mv	s4,a1
 61a:	8bb2                	mv	s7,a2
  state = 0;
 61c:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 61e:	4481                	li	s1,0
 620:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 622:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 626:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 62a:	06c00c93          	li	s9,108
 62e:	a005                	j	64e <vprintf+0x5a>
        putc(fd, c0);
 630:	85ca                	mv	a1,s2
 632:	855a                	mv	a0,s6
 634:	f07ff0ef          	jal	53a <putc>
 638:	a019                	j	63e <vprintf+0x4a>
    } else if (state == '%') {
 63a:	03598263          	beq	s3,s5,65e <vprintf+0x6a>
  for (i = 0; fmt[i]; i++) {
 63e:	2485                	addiw	s1,s1,1
 640:	8726                	mv	a4,s1
 642:	009a07b3          	add	a5,s4,s1
 646:	0007c903          	lbu	s2,0(a5)
 64a:	22090a63          	beqz	s2,87e <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 64e:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 652:	fe0994e3          	bnez	s3,63a <vprintf+0x46>
      if (c0 == '%') {
 656:	fd579de3          	bne	a5,s5,630 <vprintf+0x3c>
        state = '%';
 65a:	89be                	mv	s3,a5
 65c:	b7cd                	j	63e <vprintf+0x4a>
        c1 = fmt[i + 1] & 0xff;
 65e:	00ea06b3          	add	a3,s4,a4
 662:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 666:	8636                	mv	a2,a3
      if (c1)
 668:	c681                	beqz	a3,670 <vprintf+0x7c>
        c2 = fmt[i + 2] & 0xff;
 66a:	9752                	add	a4,a4,s4
 66c:	00274603          	lbu	a2,2(a4)
      if (c0 == 'd') {
 670:	05878363          	beq	a5,s8,6b6 <vprintf+0xc2>
      } else if (c0 == 'l' && c1 == 'd') {
 674:	05978d63          	beq	a5,s9,6ce <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 678:	07500713          	li	a4,117
 67c:	0ee78763          	beq	a5,a4,76a <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 680:	07800713          	li	a4,120
 684:	12e78963          	beq	a5,a4,7b6 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 688:	07000713          	li	a4,112
 68c:	14e78e63          	beq	a5,a4,7e8 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 690:	06300713          	li	a4,99
 694:	18e78e63          	beq	a5,a4,830 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 698:	07300713          	li	a4,115
 69c:	1ae78463          	beq	a5,a4,844 <vprintf+0x250>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 6a0:	02500713          	li	a4,37
 6a4:	04e79563          	bne	a5,a4,6ee <vprintf+0xfa>
        putc(fd, '%');
 6a8:	02500593          	li	a1,37
 6ac:	855a                	mv	a0,s6
 6ae:	e8dff0ef          	jal	53a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 6b2:	4981                	li	s3,0
 6b4:	b769                	j	63e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 6b6:	008b8913          	addi	s2,s7,8
 6ba:	4685                	li	a3,1
 6bc:	4629                	li	a2,10
 6be:	000ba583          	lw	a1,0(s7)
 6c2:	855a                	mv	a0,s6
 6c4:	e95ff0ef          	jal	558 <printint>
 6c8:	8bca                	mv	s7,s2
      state = 0;
 6ca:	4981                	li	s3,0
 6cc:	bf8d                	j	63e <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'd') {
 6ce:	06400793          	li	a5,100
 6d2:	02f68963          	beq	a3,a5,704 <vprintf+0x110>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 6d6:	06c00793          	li	a5,108
 6da:	04f68263          	beq	a3,a5,71e <vprintf+0x12a>
      } else if (c0 == 'l' && c1 == 'u') {
 6de:	07500793          	li	a5,117
 6e2:	0af68063          	beq	a3,a5,782 <vprintf+0x18e>
      } else if (c0 == 'l' && c1 == 'x') {
 6e6:	07800793          	li	a5,120
 6ea:	0ef68263          	beq	a3,a5,7ce <vprintf+0x1da>
        putc(fd, '%');
 6ee:	02500593          	li	a1,37
 6f2:	855a                	mv	a0,s6
 6f4:	e47ff0ef          	jal	53a <putc>
        putc(fd, c0);
 6f8:	85ca                	mv	a1,s2
 6fa:	855a                	mv	a0,s6
 6fc:	e3fff0ef          	jal	53a <putc>
      state = 0;
 700:	4981                	li	s3,0
 702:	bf35                	j	63e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 704:	008b8913          	addi	s2,s7,8
 708:	4685                	li	a3,1
 70a:	4629                	li	a2,10
 70c:	000bb583          	ld	a1,0(s7)
 710:	855a                	mv	a0,s6
 712:	e47ff0ef          	jal	558 <printint>
        i += 1;
 716:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 718:	8bca                	mv	s7,s2
      state = 0;
 71a:	4981                	li	s3,0
        i += 1;
 71c:	b70d                	j	63e <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 71e:	06400793          	li	a5,100
 722:	02f60763          	beq	a2,a5,750 <vprintf+0x15c>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 726:	07500793          	li	a5,117
 72a:	06f60963          	beq	a2,a5,79c <vprintf+0x1a8>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 72e:	07800793          	li	a5,120
 732:	faf61ee3          	bne	a2,a5,6ee <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 736:	008b8913          	addi	s2,s7,8
 73a:	4681                	li	a3,0
 73c:	4641                	li	a2,16
 73e:	000bb583          	ld	a1,0(s7)
 742:	855a                	mv	a0,s6
 744:	e15ff0ef          	jal	558 <printint>
        i += 2;
 748:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 74a:	8bca                	mv	s7,s2
      state = 0;
 74c:	4981                	li	s3,0
        i += 2;
 74e:	bdc5                	j	63e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 750:	008b8913          	addi	s2,s7,8
 754:	4685                	li	a3,1
 756:	4629                	li	a2,10
 758:	000bb583          	ld	a1,0(s7)
 75c:	855a                	mv	a0,s6
 75e:	dfbff0ef          	jal	558 <printint>
        i += 2;
 762:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 764:	8bca                	mv	s7,s2
      state = 0;
 766:	4981                	li	s3,0
        i += 2;
 768:	bdd9                	j	63e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 76a:	008b8913          	addi	s2,s7,8
 76e:	4681                	li	a3,0
 770:	4629                	li	a2,10
 772:	000be583          	lwu	a1,0(s7)
 776:	855a                	mv	a0,s6
 778:	de1ff0ef          	jal	558 <printint>
 77c:	8bca                	mv	s7,s2
      state = 0;
 77e:	4981                	li	s3,0
 780:	bd7d                	j	63e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 782:	008b8913          	addi	s2,s7,8
 786:	4681                	li	a3,0
 788:	4629                	li	a2,10
 78a:	000bb583          	ld	a1,0(s7)
 78e:	855a                	mv	a0,s6
 790:	dc9ff0ef          	jal	558 <printint>
        i += 1;
 794:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 796:	8bca                	mv	s7,s2
      state = 0;
 798:	4981                	li	s3,0
        i += 1;
 79a:	b555                	j	63e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 79c:	008b8913          	addi	s2,s7,8
 7a0:	4681                	li	a3,0
 7a2:	4629                	li	a2,10
 7a4:	000bb583          	ld	a1,0(s7)
 7a8:	855a                	mv	a0,s6
 7aa:	dafff0ef          	jal	558 <printint>
        i += 2;
 7ae:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7b0:	8bca                	mv	s7,s2
      state = 0;
 7b2:	4981                	li	s3,0
        i += 2;
 7b4:	b569                	j	63e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 7b6:	008b8913          	addi	s2,s7,8
 7ba:	4681                	li	a3,0
 7bc:	4641                	li	a2,16
 7be:	000be583          	lwu	a1,0(s7)
 7c2:	855a                	mv	a0,s6
 7c4:	d95ff0ef          	jal	558 <printint>
 7c8:	8bca                	mv	s7,s2
      state = 0;
 7ca:	4981                	li	s3,0
 7cc:	bd8d                	j	63e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7ce:	008b8913          	addi	s2,s7,8
 7d2:	4681                	li	a3,0
 7d4:	4641                	li	a2,16
 7d6:	000bb583          	ld	a1,0(s7)
 7da:	855a                	mv	a0,s6
 7dc:	d7dff0ef          	jal	558 <printint>
        i += 1;
 7e0:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7e2:	8bca                	mv	s7,s2
      state = 0;
 7e4:	4981                	li	s3,0
        i += 1;
 7e6:	bda1                	j	63e <vprintf+0x4a>
 7e8:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7ea:	008b8d13          	addi	s10,s7,8
 7ee:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7f2:	03000593          	li	a1,48
 7f6:	855a                	mv	a0,s6
 7f8:	d43ff0ef          	jal	53a <putc>
  putc(fd, 'x');
 7fc:	07800593          	li	a1,120
 800:	855a                	mv	a0,s6
 802:	d39ff0ef          	jal	53a <putc>
 806:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 808:	00000b97          	auipc	s7,0x0
 80c:	2b8b8b93          	addi	s7,s7,696 # ac0 <digits>
 810:	03c9d793          	srli	a5,s3,0x3c
 814:	97de                	add	a5,a5,s7
 816:	0007c583          	lbu	a1,0(a5)
 81a:	855a                	mv	a0,s6
 81c:	d1fff0ef          	jal	53a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 820:	0992                	slli	s3,s3,0x4
 822:	397d                	addiw	s2,s2,-1
 824:	fe0916e3          	bnez	s2,810 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 828:	8bea                	mv	s7,s10
      state = 0;
 82a:	4981                	li	s3,0
 82c:	6d02                	ld	s10,0(sp)
 82e:	bd01                	j	63e <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 830:	008b8913          	addi	s2,s7,8
 834:	000bc583          	lbu	a1,0(s7)
 838:	855a                	mv	a0,s6
 83a:	d01ff0ef          	jal	53a <putc>
 83e:	8bca                	mv	s7,s2
      state = 0;
 840:	4981                	li	s3,0
 842:	bbf5                	j	63e <vprintf+0x4a>
        if ((s = va_arg(ap, char *)) == 0)
 844:	008b8993          	addi	s3,s7,8
 848:	000bb903          	ld	s2,0(s7)
 84c:	00090f63          	beqz	s2,86a <vprintf+0x276>
        for (; *s; s++)
 850:	00094583          	lbu	a1,0(s2)
 854:	c195                	beqz	a1,878 <vprintf+0x284>
          putc(fd, *s);
 856:	855a                	mv	a0,s6
 858:	ce3ff0ef          	jal	53a <putc>
        for (; *s; s++)
 85c:	0905                	addi	s2,s2,1
 85e:	00094583          	lbu	a1,0(s2)
 862:	f9f5                	bnez	a1,856 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 864:	8bce                	mv	s7,s3
      state = 0;
 866:	4981                	li	s3,0
 868:	bbd9                	j	63e <vprintf+0x4a>
          s = "(null)";
 86a:	00000917          	auipc	s2,0x0
 86e:	24e90913          	addi	s2,s2,590 # ab8 <malloc+0x142>
        for (; *s; s++)
 872:	02800593          	li	a1,40
 876:	b7c5                	j	856 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 878:	8bce                	mv	s7,s3
      state = 0;
 87a:	4981                	li	s3,0
 87c:	b3c9                	j	63e <vprintf+0x4a>
 87e:	64a6                	ld	s1,72(sp)
 880:	79e2                	ld	s3,56(sp)
 882:	7a42                	ld	s4,48(sp)
 884:	7aa2                	ld	s5,40(sp)
 886:	7b02                	ld	s6,32(sp)
 888:	6be2                	ld	s7,24(sp)
 88a:	6c42                	ld	s8,16(sp)
 88c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 88e:	60e6                	ld	ra,88(sp)
 890:	6446                	ld	s0,80(sp)
 892:	6906                	ld	s2,64(sp)
 894:	6125                	addi	sp,sp,96
 896:	8082                	ret

0000000000000898 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 898:	715d                	addi	sp,sp,-80
 89a:	ec06                	sd	ra,24(sp)
 89c:	e822                	sd	s0,16(sp)
 89e:	1000                	addi	s0,sp,32
 8a0:	e010                	sd	a2,0(s0)
 8a2:	e414                	sd	a3,8(s0)
 8a4:	e818                	sd	a4,16(s0)
 8a6:	ec1c                	sd	a5,24(s0)
 8a8:	03043023          	sd	a6,32(s0)
 8ac:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8b0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8b4:	8622                	mv	a2,s0
 8b6:	d3fff0ef          	jal	5f4 <vprintf>
}
 8ba:	60e2                	ld	ra,24(sp)
 8bc:	6442                	ld	s0,16(sp)
 8be:	6161                	addi	sp,sp,80
 8c0:	8082                	ret

00000000000008c2 <printf>:

void
printf(const char *fmt, ...)
{
 8c2:	711d                	addi	sp,sp,-96
 8c4:	ec06                	sd	ra,24(sp)
 8c6:	e822                	sd	s0,16(sp)
 8c8:	1000                	addi	s0,sp,32
 8ca:	e40c                	sd	a1,8(s0)
 8cc:	e810                	sd	a2,16(s0)
 8ce:	ec14                	sd	a3,24(s0)
 8d0:	f018                	sd	a4,32(s0)
 8d2:	f41c                	sd	a5,40(s0)
 8d4:	03043823          	sd	a6,48(s0)
 8d8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8dc:	00840613          	addi	a2,s0,8
 8e0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8e4:	85aa                	mv	a1,a0
 8e6:	4505                	li	a0,1
 8e8:	d0dff0ef          	jal	5f4 <vprintf>
}
 8ec:	60e2                	ld	ra,24(sp)
 8ee:	6442                	ld	s0,16(sp)
 8f0:	6125                	addi	sp,sp,96
 8f2:	8082                	ret

00000000000008f4 <free>:
 8f4:	1141                	addi	sp,sp,-16
 8f6:	e422                	sd	s0,8(sp)
 8f8:	0800                	addi	s0,sp,16
 8fa:	ff050693          	addi	a3,a0,-16
 8fe:	00000797          	auipc	a5,0x0
 902:	7027b783          	ld	a5,1794(a5) # 1000 <freep>
 906:	a02d                	j	930 <free+0x3c>
 908:	4618                	lw	a4,8(a2)
 90a:	9f2d                	addw	a4,a4,a1
 90c:	fee52c23          	sw	a4,-8(a0)
 910:	6398                	ld	a4,0(a5)
 912:	6310                	ld	a2,0(a4)
 914:	a83d                	j	952 <free+0x5e>
 916:	ff852703          	lw	a4,-8(a0)
 91a:	9f31                	addw	a4,a4,a2
 91c:	c798                	sw	a4,8(a5)
 91e:	ff053683          	ld	a3,-16(a0)
 922:	a091                	j	966 <free+0x72>
 924:	6398                	ld	a4,0(a5)
 926:	00e7e463          	bltu	a5,a4,92e <free+0x3a>
 92a:	00e6ea63          	bltu	a3,a4,93e <free+0x4a>
 92e:	87ba                	mv	a5,a4
 930:	fed7fae3          	bgeu	a5,a3,924 <free+0x30>
 934:	6398                	ld	a4,0(a5)
 936:	00e6e463          	bltu	a3,a4,93e <free+0x4a>
 93a:	fee7eae3          	bltu	a5,a4,92e <free+0x3a>
 93e:	ff852583          	lw	a1,-8(a0)
 942:	6390                	ld	a2,0(a5)
 944:	02059813          	slli	a6,a1,0x20
 948:	01c85713          	srli	a4,a6,0x1c
 94c:	9736                	add	a4,a4,a3
 94e:	fae60de3          	beq	a2,a4,908 <free+0x14>
 952:	fec53823          	sd	a2,-16(a0)
 956:	4790                	lw	a2,8(a5)
 958:	02061593          	slli	a1,a2,0x20
 95c:	01c5d713          	srli	a4,a1,0x1c
 960:	973e                	add	a4,a4,a5
 962:	fae68ae3          	beq	a3,a4,916 <free+0x22>
 966:	e394                	sd	a3,0(a5)
 968:	00000717          	auipc	a4,0x0
 96c:	68f73c23          	sd	a5,1688(a4) # 1000 <freep>
 970:	6422                	ld	s0,8(sp)
 972:	0141                	addi	sp,sp,16
 974:	8082                	ret

0000000000000976 <malloc>:
 976:	7139                	addi	sp,sp,-64
 978:	fc06                	sd	ra,56(sp)
 97a:	f822                	sd	s0,48(sp)
 97c:	f426                	sd	s1,40(sp)
 97e:	ec4e                	sd	s3,24(sp)
 980:	0080                	addi	s0,sp,64
 982:	02051493          	slli	s1,a0,0x20
 986:	9081                	srli	s1,s1,0x20
 988:	04bd                	addi	s1,s1,15
 98a:	8091                	srli	s1,s1,0x4
 98c:	0014899b          	addiw	s3,s1,1
 990:	0485                	addi	s1,s1,1
 992:	00000517          	auipc	a0,0x0
 996:	66e53503          	ld	a0,1646(a0) # 1000 <freep>
 99a:	c915                	beqz	a0,9ce <malloc+0x58>
 99c:	611c                	ld	a5,0(a0)
 99e:	4798                	lw	a4,8(a5)
 9a0:	08977a63          	bgeu	a4,s1,a34 <malloc+0xbe>
 9a4:	f04a                	sd	s2,32(sp)
 9a6:	e852                	sd	s4,16(sp)
 9a8:	e456                	sd	s5,8(sp)
 9aa:	e05a                	sd	s6,0(sp)
 9ac:	8a4e                	mv	s4,s3
 9ae:	0009871b          	sext.w	a4,s3
 9b2:	6685                	lui	a3,0x1
 9b4:	00d77363          	bgeu	a4,a3,9ba <malloc+0x44>
 9b8:	6a05                	lui	s4,0x1
 9ba:	000a0b1b          	sext.w	s6,s4
 9be:	004a1a1b          	slliw	s4,s4,0x4
 9c2:	00000917          	auipc	s2,0x0
 9c6:	63e90913          	addi	s2,s2,1598 # 1000 <freep>
 9ca:	5afd                	li	s5,-1
 9cc:	a081                	j	a0c <malloc+0x96>
 9ce:	f04a                	sd	s2,32(sp)
 9d0:	e852                	sd	s4,16(sp)
 9d2:	e456                	sd	s5,8(sp)
 9d4:	e05a                	sd	s6,0(sp)
 9d6:	00000797          	auipc	a5,0x0
 9da:	66278793          	addi	a5,a5,1634 # 1038 <base>
 9de:	00000717          	auipc	a4,0x0
 9e2:	62f73123          	sd	a5,1570(a4) # 1000 <freep>
 9e6:	e39c                	sd	a5,0(a5)
 9e8:	0007a423          	sw	zero,8(a5)
 9ec:	b7c1                	j	9ac <malloc+0x36>
 9ee:	6398                	ld	a4,0(a5)
 9f0:	e118                	sd	a4,0(a0)
 9f2:	a8a9                	j	a4c <malloc+0xd6>
 9f4:	01652423          	sw	s6,8(a0)
 9f8:	0541                	addi	a0,a0,16
 9fa:	efbff0ef          	jal	8f4 <free>
 9fe:	00093503          	ld	a0,0(s2)
 a02:	c12d                	beqz	a0,a64 <malloc+0xee>
 a04:	611c                	ld	a5,0(a0)
 a06:	4798                	lw	a4,8(a5)
 a08:	02977263          	bgeu	a4,s1,a2c <malloc+0xb6>
 a0c:	00093703          	ld	a4,0(s2)
 a10:	853e                	mv	a0,a5
 a12:	fef719e3          	bne	a4,a5,a04 <malloc+0x8e>
 a16:	8552                	mv	a0,s4
 a18:	a47ff0ef          	jal	45e <sbrk>
 a1c:	fd551ce3          	bne	a0,s5,9f4 <malloc+0x7e>
 a20:	4501                	li	a0,0
 a22:	7902                	ld	s2,32(sp)
 a24:	6a42                	ld	s4,16(sp)
 a26:	6aa2                	ld	s5,8(sp)
 a28:	6b02                	ld	s6,0(sp)
 a2a:	a03d                	j	a58 <malloc+0xe2>
 a2c:	7902                	ld	s2,32(sp)
 a2e:	6a42                	ld	s4,16(sp)
 a30:	6aa2                	ld	s5,8(sp)
 a32:	6b02                	ld	s6,0(sp)
 a34:	fae48de3          	beq	s1,a4,9ee <malloc+0x78>
 a38:	4137073b          	subw	a4,a4,s3
 a3c:	c798                	sw	a4,8(a5)
 a3e:	02071693          	slli	a3,a4,0x20
 a42:	01c6d713          	srli	a4,a3,0x1c
 a46:	97ba                	add	a5,a5,a4
 a48:	0137a423          	sw	s3,8(a5)
 a4c:	00000717          	auipc	a4,0x0
 a50:	5aa73a23          	sd	a0,1460(a4) # 1000 <freep>
 a54:	01078513          	addi	a0,a5,16
 a58:	70e2                	ld	ra,56(sp)
 a5a:	7442                	ld	s0,48(sp)
 a5c:	74a2                	ld	s1,40(sp)
 a5e:	69e2                	ld	s3,24(sp)
 a60:	6121                	addi	sp,sp,64
 a62:	8082                	ret
 a64:	7902                	ld	s2,32(sp)
 a66:	6a42                	ld	s4,16(sp)
 a68:	6aa2                	ld	s5,8(sp)
 a6a:	6b02                	ld	s6,0(sp)
 a6c:	b7f5                	j	a58 <malloc+0xe2>
