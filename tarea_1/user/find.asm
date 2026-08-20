
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
void buscar_archivo(const char *ruta_actual, char *archivo_a_buscar)
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
  86:	8a2a                	mv	s4,a0
  88:	8c2e                	mv	s8,a1
  int len_ruta_actual = strlen(ruta_actual);
  8a:	19e000ef          	jal	228 <strlen>
  8e:	0005049b          	sext.w	s1,a0
  int len_nombre_archivo = strlen(archivo_a_buscar);
  92:	8562                	mv	a0,s8
  94:	194000ef          	jal	228 <strlen>
  98:	00050a9b          	sext.w	s5,a0
  int file_descriptor = open(ruta_actual, O_RDONLY);
  9c:	4581                	li	a1,0
  9e:	8552                	mv	a0,s4
  a0:	404000ef          	jal	4a4 <open>
  a4:	89aa                	mv	s3,a0

  // read deuelve la cantidad de bytes que logro leer con exito
  while (read(file_descriptor, &archivo_actual, sizeof(archivo_actual)) == sizeof(archivo_actual)) {
  a6:	00001917          	auipc	s2,0x1
  aa:	f6a90913          	addi	s2,s2,-150 # 1010 <archivo_actual>

    // le sumo 2, uno para "/" y otro porciacaso para el '\0' por que no se si lo contempla
    char dest[len_ruta_actual + len_nombre_archivo + 2]; //deberia ser inecesario poner el * al principio ya que al ser un arreglo, debe ser un puntero
  ae:	015484bb          	addw	s1,s1,s5
  b2:	2489                	addiw	s1,s1,2
  b4:	00f48b13          	addi	s6,s1,15
  b8:	ff0b7b13          	andi	s6,s6,-16
    dest[0] = '\0'; // Si declaras pero no incializas una variable en C, esta contiene basura por defecto
    concatenar_cadenas(dest, ruta_actual, sizeof(dest));
    concatenar_cadenas(dest, "/", sizeof(dest));
    concatenar_cadenas(dest, archivo_actual.name, sizeof(dest));
  bc:	00001b97          	auipc	s7,0x1
  c0:	f56b8b93          	addi	s7,s7,-170 # 1012 <archivo_actual+0x2>
  while (read(file_descriptor, &archivo_actual, sizeof(archivo_actual)) == sizeof(archivo_actual)) {
  c4:	a839                	j	e2 <buscar_archivo+0x76>
    if (archivo_actual.inum == 0 || strcmp(archivo_actual.name, ".") == 0 || strcmp(archivo_actual.name, "..") == 0) continue; // igual deberia funcionar sin esta linea

    // Supongo que al poner este condicional antes que el que ve si el archivo es una carpeta, esta función también identificara carpetas con el nombre buscado

    if (strcmp(archivo_actual.name,archivo_a_buscar) == 0) { // No se pueden comparar usando == pues son direcciones de memoria
      printf("%s\n", dest);
  c6:	85e6                	mv	a1,s9
  c8:	00001517          	auipc	a0,0x1
  cc:	99050513          	addi	a0,a0,-1648 # a58 <malloc+0x110>
  d0:	7c4000ef          	jal	894 <printf>
  d4:	a069                	j	15e <buscar_archivo+0xf2>
    }
  
    if (stat(dest, &st) < 0) continue; // aca se saca la informacion del archivo si es que se pudo y si no se salta al siguiente bucle
    
    if (st.type == T_DIR) {
      buscar_archivo(dest, archivo_a_buscar);
  d6:	85e2                	mv	a1,s8
  d8:	8566                	mv	a0,s9
  da:	f93ff0ef          	jal	6c <buscar_archivo>
  de:	a045                	j	17e <buscar_archivo+0x112>
    if (archivo_actual.inum == 0 || strcmp(archivo_actual.name, ".") == 0 || strcmp(archivo_actual.name, "..") == 0) continue; // igual deberia funcionar sin esta linea
  e0:	8156                	mv	sp,s5
  while (read(file_descriptor, &archivo_actual, sizeof(archivo_actual)) == sizeof(archivo_actual)) {
  e2:	4641                	li	a2,16
  e4:	85ca                	mv	a1,s2
  e6:	854e                	mv	a0,s3
  e8:	394000ef          	jal	47c <read>
  ec:	47c1                	li	a5,16
  ee:	08f51a63          	bne	a0,a5,182 <buscar_archivo+0x116>
  f2:	8a8a                	mv	s5,sp
    char dest[len_ruta_actual + len_nombre_archivo + 2]; //deberia ser inecesario poner el * al principio ya que al ser un arreglo, debe ser un puntero
  f4:	41610133          	sub	sp,sp,s6
  f8:	8c8a                	mv	s9,sp
    dest[0] = '\0'; // Si declaras pero no incializas una variable en C, esta contiene basura por defecto
  fa:	00010023          	sb	zero,0(sp)
    concatenar_cadenas(dest, ruta_actual, sizeof(dest));
  fe:	8626                	mv	a2,s1
 100:	85d2                	mv	a1,s4
 102:	850a                	mv	a0,sp
 104:	efdff0ef          	jal	0 <concatenar_cadenas>
    concatenar_cadenas(dest, "/", sizeof(dest));
 108:	8626                	mv	a2,s1
 10a:	00001597          	auipc	a1,0x1
 10e:	93658593          	addi	a1,a1,-1738 # a40 <malloc+0xf8>
 112:	850a                	mv	a0,sp
 114:	eedff0ef          	jal	0 <concatenar_cadenas>
    concatenar_cadenas(dest, archivo_actual.name, sizeof(dest));
 118:	8626                	mv	a2,s1
 11a:	85de                	mv	a1,s7
 11c:	850a                	mv	a0,sp
 11e:	ee3ff0ef          	jal	0 <concatenar_cadenas>
    if (archivo_actual.inum == 0 || strcmp(archivo_actual.name, ".") == 0 || strcmp(archivo_actual.name, "..") == 0) continue; // igual deberia funcionar sin esta linea
 122:	00095783          	lhu	a5,0(s2)
 126:	dfcd                	beqz	a5,e0 <buscar_archivo+0x74>
 128:	00001597          	auipc	a1,0x1
 12c:	92058593          	addi	a1,a1,-1760 # a48 <malloc+0x100>
 130:	855e                	mv	a0,s7
 132:	0ca000ef          	jal	1fc <strcmp>
 136:	d54d                	beqz	a0,e0 <buscar_archivo+0x74>
 138:	00001597          	auipc	a1,0x1
 13c:	91858593          	addi	a1,a1,-1768 # a50 <malloc+0x108>
 140:	00001517          	auipc	a0,0x1
 144:	ed250513          	addi	a0,a0,-302 # 1012 <archivo_actual+0x2>
 148:	0b4000ef          	jal	1fc <strcmp>
 14c:	d951                	beqz	a0,e0 <buscar_archivo+0x74>
    if (strcmp(archivo_actual.name,archivo_a_buscar) == 0) { // No se pueden comparar usando == pues son direcciones de memoria
 14e:	85e2                	mv	a1,s8
 150:	00001517          	auipc	a0,0x1
 154:	ec250513          	addi	a0,a0,-318 # 1012 <archivo_actual+0x2>
 158:	0a4000ef          	jal	1fc <strcmp>
 15c:	d52d                	beqz	a0,c6 <buscar_archivo+0x5a>
    if (stat(dest, &st) < 0) continue; // aca se saca la informacion del archivo si es que se pudo y si no se salta al siguiente bucle
 15e:	00001597          	auipc	a1,0x1
 162:	ec258593          	addi	a1,a1,-318 # 1020 <st>
 166:	8566                	mv	a0,s9
 168:	1a0000ef          	jal	308 <stat>
 16c:	f6054ae3          	bltz	a0,e0 <buscar_archivo+0x74>
    if (st.type == T_DIR) {
 170:	00001717          	auipc	a4,0x1
 174:	eb871703          	lh	a4,-328(a4) # 1028 <st+0x8>
 178:	4785                	li	a5,1
 17a:	f4f70ee3          	beq	a4,a5,d6 <buscar_archivo+0x6a>
 17e:	8156                	mv	sp,s5
 180:	b78d                	j	e2 <buscar_archivo+0x76>
    }
  }
}
 182:	fa040113          	addi	sp,s0,-96
 186:	60e6                	ld	ra,88(sp)
 188:	6446                	ld	s0,80(sp)
 18a:	64a6                	ld	s1,72(sp)
 18c:	6906                	ld	s2,64(sp)
 18e:	79e2                	ld	s3,56(sp)
 190:	7a42                	ld	s4,48(sp)
 192:	7aa2                	ld	s5,40(sp)
 194:	7b02                	ld	s6,32(sp)
 196:	6be2                	ld	s7,24(sp)
 198:	6c42                	ld	s8,16(sp)
 19a:	6ca2                	ld	s9,8(sp)
 19c:	6125                	addi	sp,sp,96
 19e:	8082                	ret

00000000000001a0 <main>:

int
main(int argc, char *argv[])
{
 1a0:	1141                	addi	sp,sp,-16
 1a2:	e406                	sd	ra,8(sp)
 1a4:	e022                	sd	s0,0(sp)
 1a6:	0800                	addi	s0,sp,16
  // estoy asumiendo que se usa la ruta relativa
  if (argc < 3) {
 1a8:	4709                	li	a4,2
 1aa:	00a74b63          	blt	a4,a0,1c0 <main+0x20>
    printf("find ./ruta_relativa archivo_a_buscar\n");
 1ae:	00001517          	auipc	a0,0x1
 1b2:	8b250513          	addi	a0,a0,-1870 # a60 <malloc+0x118>
 1b6:	6de000ef          	jal	894 <printf>
    exit(1);
 1ba:	4505                	li	a0,1
 1bc:	2a8000ef          	jal	464 <exit>
 1c0:	87ae                	mv	a5,a1
  }

  buscar_archivo(argv[1], argv[2]);
 1c2:	698c                	ld	a1,16(a1)
 1c4:	6788                	ld	a0,8(a5)
 1c6:	ea7ff0ef          	jal	6c <buscar_archivo>
  // argv[0] es el nombre del propio ejecutable
  // argv[1] es el primer argumento real que pasas en la terminal

  exit(0);
 1ca:	4501                	li	a0,0
 1cc:	298000ef          	jal	464 <exit>

00000000000001d0 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 1d0:	1141                	addi	sp,sp,-16
 1d2:	e406                	sd	ra,8(sp)
 1d4:	e022                	sd	s0,0(sp)
 1d6:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 1d8:	fc9ff0ef          	jal	1a0 <main>
  exit(r);
 1dc:	288000ef          	jal	464 <exit>

00000000000001e0 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 1e0:	1141                	addi	sp,sp,-16
 1e2:	e422                	sd	s0,8(sp)
 1e4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 1e6:	87aa                	mv	a5,a0
 1e8:	0585                	addi	a1,a1,1
 1ea:	0785                	addi	a5,a5,1
 1ec:	fff5c703          	lbu	a4,-1(a1)
 1f0:	fee78fa3          	sb	a4,-1(a5)
 1f4:	fb75                	bnez	a4,1e8 <strcpy+0x8>
    ;
  return os;
}
 1f6:	6422                	ld	s0,8(sp)
 1f8:	0141                	addi	sp,sp,16
 1fa:	8082                	ret

00000000000001fc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e422                	sd	s0,8(sp)
 200:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 202:	00054783          	lbu	a5,0(a0)
 206:	cb91                	beqz	a5,21a <strcmp+0x1e>
 208:	0005c703          	lbu	a4,0(a1)
 20c:	00f71763          	bne	a4,a5,21a <strcmp+0x1e>
    p++, q++;
 210:	0505                	addi	a0,a0,1
 212:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 214:	00054783          	lbu	a5,0(a0)
 218:	fbe5                	bnez	a5,208 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 21a:	0005c503          	lbu	a0,0(a1)
}
 21e:	40a7853b          	subw	a0,a5,a0
 222:	6422                	ld	s0,8(sp)
 224:	0141                	addi	sp,sp,16
 226:	8082                	ret

0000000000000228 <strlen>:

uint
strlen(const char *s)
{
 228:	1141                	addi	sp,sp,-16
 22a:	e422                	sd	s0,8(sp)
 22c:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 22e:	00054783          	lbu	a5,0(a0)
 232:	cf91                	beqz	a5,24e <strlen+0x26>
 234:	0505                	addi	a0,a0,1
 236:	87aa                	mv	a5,a0
 238:	86be                	mv	a3,a5
 23a:	0785                	addi	a5,a5,1
 23c:	fff7c703          	lbu	a4,-1(a5)
 240:	ff65                	bnez	a4,238 <strlen+0x10>
 242:	40a6853b          	subw	a0,a3,a0
 246:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 248:	6422                	ld	s0,8(sp)
 24a:	0141                	addi	sp,sp,16
 24c:	8082                	ret
  for (n = 0; s[n]; n++)
 24e:	4501                	li	a0,0
 250:	bfe5                	j	248 <strlen+0x20>

0000000000000252 <memset>:

void *
memset(void *dst, int c, uint n)
{
 252:	1141                	addi	sp,sp,-16
 254:	e422                	sd	s0,8(sp)
 256:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 258:	ca19                	beqz	a2,26e <memset+0x1c>
 25a:	87aa                	mv	a5,a0
 25c:	1602                	slli	a2,a2,0x20
 25e:	9201                	srli	a2,a2,0x20
 260:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 264:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 268:	0785                	addi	a5,a5,1
 26a:	fee79de3          	bne	a5,a4,264 <memset+0x12>
  }
  return dst;
}
 26e:	6422                	ld	s0,8(sp)
 270:	0141                	addi	sp,sp,16
 272:	8082                	ret

0000000000000274 <strchr>:

char *
strchr(const char *s, char c)
{
 274:	1141                	addi	sp,sp,-16
 276:	e422                	sd	s0,8(sp)
 278:	0800                	addi	s0,sp,16
  for (; *s; s++)
 27a:	00054783          	lbu	a5,0(a0)
 27e:	cb99                	beqz	a5,294 <strchr+0x20>
    if (*s == c)
 280:	00f58763          	beq	a1,a5,28e <strchr+0x1a>
  for (; *s; s++)
 284:	0505                	addi	a0,a0,1
 286:	00054783          	lbu	a5,0(a0)
 28a:	fbfd                	bnez	a5,280 <strchr+0xc>
      return (char *)s;
  return 0;
 28c:	4501                	li	a0,0
}
 28e:	6422                	ld	s0,8(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret
  return 0;
 294:	4501                	li	a0,0
 296:	bfe5                	j	28e <strchr+0x1a>

0000000000000298 <gets>:

char *
gets(char *buf, int max)
{
 298:	711d                	addi	sp,sp,-96
 29a:	ec86                	sd	ra,88(sp)
 29c:	e8a2                	sd	s0,80(sp)
 29e:	e4a6                	sd	s1,72(sp)
 2a0:	e0ca                	sd	s2,64(sp)
 2a2:	fc4e                	sd	s3,56(sp)
 2a4:	f852                	sd	s4,48(sp)
 2a6:	f456                	sd	s5,40(sp)
 2a8:	f05a                	sd	s6,32(sp)
 2aa:	ec5e                	sd	s7,24(sp)
 2ac:	1080                	addi	s0,sp,96
 2ae:	8baa                	mv	s7,a0
 2b0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 2b2:	892a                	mv	s2,a0
 2b4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 2b6:	4aa9                	li	s5,10
 2b8:	4b35                	li	s6,13
  for (i = 0; i + 1 < max;) {
 2ba:	89a6                	mv	s3,s1
 2bc:	2485                	addiw	s1,s1,1
 2be:	0344d663          	bge	s1,s4,2ea <gets+0x52>
    cc = read(0, &c, 1);
 2c2:	4605                	li	a2,1
 2c4:	faf40593          	addi	a1,s0,-81
 2c8:	4501                	li	a0,0
 2ca:	1b2000ef          	jal	47c <read>
    if (cc < 1)
 2ce:	00a05e63          	blez	a0,2ea <gets+0x52>
    buf[i++] = c;
 2d2:	faf44783          	lbu	a5,-81(s0)
 2d6:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 2da:	01578763          	beq	a5,s5,2e8 <gets+0x50>
 2de:	0905                	addi	s2,s2,1
 2e0:	fd679de3          	bne	a5,s6,2ba <gets+0x22>
    buf[i++] = c;
 2e4:	89a6                	mv	s3,s1
 2e6:	a011                	j	2ea <gets+0x52>
 2e8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2ea:	99de                	add	s3,s3,s7
 2ec:	00098023          	sb	zero,0(s3)
  return buf;
}
 2f0:	855e                	mv	a0,s7
 2f2:	60e6                	ld	ra,88(sp)
 2f4:	6446                	ld	s0,80(sp)
 2f6:	64a6                	ld	s1,72(sp)
 2f8:	6906                	ld	s2,64(sp)
 2fa:	79e2                	ld	s3,56(sp)
 2fc:	7a42                	ld	s4,48(sp)
 2fe:	7aa2                	ld	s5,40(sp)
 300:	7b02                	ld	s6,32(sp)
 302:	6be2                	ld	s7,24(sp)
 304:	6125                	addi	sp,sp,96
 306:	8082                	ret

0000000000000308 <stat>:

int
stat(const char *n, struct stat *st)
{
 308:	1101                	addi	sp,sp,-32
 30a:	ec06                	sd	ra,24(sp)
 30c:	e822                	sd	s0,16(sp)
 30e:	e04a                	sd	s2,0(sp)
 310:	1000                	addi	s0,sp,32
 312:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 314:	4581                	li	a1,0
 316:	18e000ef          	jal	4a4 <open>
  if (fd < 0)
 31a:	02054263          	bltz	a0,33e <stat+0x36>
 31e:	e426                	sd	s1,8(sp)
 320:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 322:	85ca                	mv	a1,s2
 324:	198000ef          	jal	4bc <fstat>
 328:	892a                	mv	s2,a0
  close(fd);
 32a:	8526                	mv	a0,s1
 32c:	160000ef          	jal	48c <close>
  return r;
 330:	64a2                	ld	s1,8(sp)
}
 332:	854a                	mv	a0,s2
 334:	60e2                	ld	ra,24(sp)
 336:	6442                	ld	s0,16(sp)
 338:	6902                	ld	s2,0(sp)
 33a:	6105                	addi	sp,sp,32
 33c:	8082                	ret
    return -1;
 33e:	597d                	li	s2,-1
 340:	bfcd                	j	332 <stat+0x2a>

0000000000000342 <atoi>:

int
atoi(const char *s)
{
 342:	1141                	addi	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 348:	00054683          	lbu	a3,0(a0)
 34c:	fd06879b          	addiw	a5,a3,-48
 350:	0ff7f793          	zext.b	a5,a5
 354:	4625                	li	a2,9
 356:	02f66863          	bltu	a2,a5,386 <atoi+0x44>
 35a:	872a                	mv	a4,a0
  n = 0;
 35c:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 35e:	0705                	addi	a4,a4,1
 360:	0025179b          	slliw	a5,a0,0x2
 364:	9fa9                	addw	a5,a5,a0
 366:	0017979b          	slliw	a5,a5,0x1
 36a:	9fb5                	addw	a5,a5,a3
 36c:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 370:	00074683          	lbu	a3,0(a4)
 374:	fd06879b          	addiw	a5,a3,-48
 378:	0ff7f793          	zext.b	a5,a5
 37c:	fef671e3          	bgeu	a2,a5,35e <atoi+0x1c>
  return n;
}
 380:	6422                	ld	s0,8(sp)
 382:	0141                	addi	sp,sp,16
 384:	8082                	ret
  n = 0;
 386:	4501                	li	a0,0
 388:	bfe5                	j	380 <atoi+0x3e>

000000000000038a <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 38a:	1141                	addi	sp,sp,-16
 38c:	e422                	sd	s0,8(sp)
 38e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 390:	02b57463          	bgeu	a0,a1,3b8 <memmove+0x2e>
    while (n-- > 0)
 394:	00c05f63          	blez	a2,3b2 <memmove+0x28>
 398:	1602                	slli	a2,a2,0x20
 39a:	9201                	srli	a2,a2,0x20
 39c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3a0:	872a                	mv	a4,a0
      *dst++ = *src++;
 3a2:	0585                	addi	a1,a1,1
 3a4:	0705                	addi	a4,a4,1
 3a6:	fff5c683          	lbu	a3,-1(a1)
 3aa:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 3ae:	fef71ae3          	bne	a4,a5,3a2 <memmove+0x18>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3b2:	6422                	ld	s0,8(sp)
 3b4:	0141                	addi	sp,sp,16
 3b6:	8082                	ret
    dst += n;
 3b8:	00c50733          	add	a4,a0,a2
    src += n;
 3bc:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 3be:	fec05ae3          	blez	a2,3b2 <memmove+0x28>
 3c2:	fff6079b          	addiw	a5,a2,-1
 3c6:	1782                	slli	a5,a5,0x20
 3c8:	9381                	srli	a5,a5,0x20
 3ca:	fff7c793          	not	a5,a5
 3ce:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3d0:	15fd                	addi	a1,a1,-1
 3d2:	177d                	addi	a4,a4,-1
 3d4:	0005c683          	lbu	a3,0(a1)
 3d8:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 3dc:	fee79ae3          	bne	a5,a4,3d0 <memmove+0x46>
 3e0:	bfc9                	j	3b2 <memmove+0x28>

00000000000003e2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3e2:	1141                	addi	sp,sp,-16
 3e4:	e422                	sd	s0,8(sp)
 3e6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3e8:	ca05                	beqz	a2,418 <memcmp+0x36>
 3ea:	fff6069b          	addiw	a3,a2,-1
 3ee:	1682                	slli	a3,a3,0x20
 3f0:	9281                	srli	a3,a3,0x20
 3f2:	0685                	addi	a3,a3,1
 3f4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3f6:	00054783          	lbu	a5,0(a0)
 3fa:	0005c703          	lbu	a4,0(a1)
 3fe:	00e79863          	bne	a5,a4,40e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 402:	0505                	addi	a0,a0,1
    p2++;
 404:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 406:	fed518e3          	bne	a0,a3,3f6 <memcmp+0x14>
  }
  return 0;
 40a:	4501                	li	a0,0
 40c:	a019                	j	412 <memcmp+0x30>
      return *p1 - *p2;
 40e:	40e7853b          	subw	a0,a5,a4
}
 412:	6422                	ld	s0,8(sp)
 414:	0141                	addi	sp,sp,16
 416:	8082                	ret
  return 0;
 418:	4501                	li	a0,0
 41a:	bfe5                	j	412 <memcmp+0x30>

000000000000041c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 41c:	1141                	addi	sp,sp,-16
 41e:	e406                	sd	ra,8(sp)
 420:	e022                	sd	s0,0(sp)
 422:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 424:	f67ff0ef          	jal	38a <memmove>
}
 428:	60a2                	ld	ra,8(sp)
 42a:	6402                	ld	s0,0(sp)
 42c:	0141                	addi	sp,sp,16
 42e:	8082                	ret

0000000000000430 <sbrk>:

char *
sbrk(int n)
{
 430:	1141                	addi	sp,sp,-16
 432:	e406                	sd	ra,8(sp)
 434:	e022                	sd	s0,0(sp)
 436:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 438:	4585                	li	a1,1
 43a:	0b2000ef          	jal	4ec <sys_sbrk>
}
 43e:	60a2                	ld	ra,8(sp)
 440:	6402                	ld	s0,0(sp)
 442:	0141                	addi	sp,sp,16
 444:	8082                	ret

0000000000000446 <sbrklazy>:

char *
sbrklazy(int n)
{
 446:	1141                	addi	sp,sp,-16
 448:	e406                	sd	ra,8(sp)
 44a:	e022                	sd	s0,0(sp)
 44c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 44e:	4589                	li	a1,2
 450:	09c000ef          	jal	4ec <sys_sbrk>
}
 454:	60a2                	ld	ra,8(sp)
 456:	6402                	ld	s0,0(sp)
 458:	0141                	addi	sp,sp,16
 45a:	8082                	ret

000000000000045c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 45c:	4885                	li	a7,1
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <exit>:
.global exit
exit:
 li a7, SYS_exit
 464:	4889                	li	a7,2
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <wait>:
.global wait
wait:
 li a7, SYS_wait
 46c:	488d                	li	a7,3
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 474:	4891                	li	a7,4
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <read>:
.global read
read:
 li a7, SYS_read
 47c:	4895                	li	a7,5
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <write>:
.global write
write:
 li a7, SYS_write
 484:	48c1                	li	a7,16
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <close>:
.global close
close:
 li a7, SYS_close
 48c:	48d5                	li	a7,21
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <kill>:
.global kill
kill:
 li a7, SYS_kill
 494:	4899                	li	a7,6
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <exec>:
.global exec
exec:
 li a7, SYS_exec
 49c:	489d                	li	a7,7
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <open>:
.global open
open:
 li a7, SYS_open
 4a4:	48bd                	li	a7,15
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4ac:	48c5                	li	a7,17
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4b4:	48c9                	li	a7,18
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4bc:	48a1                	li	a7,8
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <link>:
.global link
link:
 li a7, SYS_link
 4c4:	48cd                	li	a7,19
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4cc:	48d1                	li	a7,20
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4d4:	48a5                	li	a7,9
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <dup>:
.global dup
dup:
 li a7, SYS_dup
 4dc:	48a9                	li	a7,10
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4e4:	48ad                	li	a7,11
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 4ec:	48b1                	li	a7,12
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <pause>:
.global pause
pause:
 li a7, SYS_pause
 4f4:	48b5                	li	a7,13
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4fc:	48b9                	li	a7,14
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <sync>:
.global sync
sync:
 li a7, SYS_sync
 504:	48d9                	li	a7,22
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 50c:	1101                	addi	sp,sp,-32
 50e:	ec06                	sd	ra,24(sp)
 510:	e822                	sd	s0,16(sp)
 512:	1000                	addi	s0,sp,32
 514:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 518:	4605                	li	a2,1
 51a:	fef40593          	addi	a1,s0,-17
 51e:	f67ff0ef          	jal	484 <write>
}
 522:	60e2                	ld	ra,24(sp)
 524:	6442                	ld	s0,16(sp)
 526:	6105                	addi	sp,sp,32
 528:	8082                	ret

000000000000052a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 52a:	715d                	addi	sp,sp,-80
 52c:	e486                	sd	ra,72(sp)
 52e:	e0a2                	sd	s0,64(sp)
 530:	f84a                	sd	s2,48(sp)
 532:	0880                	addi	s0,sp,80
 534:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 536:	c299                	beqz	a3,53c <printint+0x12>
 538:	0805c363          	bltz	a1,5be <printint+0x94>
  neg = 0;
 53c:	4881                	li	a7,0
 53e:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 542:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
 544:	00000517          	auipc	a0,0x0
 548:	54c50513          	addi	a0,a0,1356 # a90 <digits>
 54c:	883e                	mv	a6,a5
 54e:	2785                	addiw	a5,a5,1
 550:	02c5f733          	remu	a4,a1,a2
 554:	972a                	add	a4,a4,a0
 556:	00074703          	lbu	a4,0(a4)
 55a:	00e68023          	sb	a4,0(a3)
  } while ((x /= base) != 0);
 55e:	872e                	mv	a4,a1
 560:	02c5d5b3          	divu	a1,a1,a2
 564:	0685                	addi	a3,a3,1
 566:	fec773e3          	bgeu	a4,a2,54c <printint+0x22>
  if (neg)
 56a:	00088b63          	beqz	a7,580 <printint+0x56>
    buf[i++] = '-';
 56e:	fd078793          	addi	a5,a5,-48
 572:	97a2                	add	a5,a5,s0
 574:	02d00713          	li	a4,45
 578:	fee78423          	sb	a4,-24(a5)
 57c:	0028079b          	addiw	a5,a6,2

  while (--i >= 0)
 580:	02f05a63          	blez	a5,5b4 <printint+0x8a>
 584:	fc26                	sd	s1,56(sp)
 586:	f44e                	sd	s3,40(sp)
 588:	fb840713          	addi	a4,s0,-72
 58c:	00f704b3          	add	s1,a4,a5
 590:	fff70993          	addi	s3,a4,-1
 594:	99be                	add	s3,s3,a5
 596:	37fd                	addiw	a5,a5,-1
 598:	1782                	slli	a5,a5,0x20
 59a:	9381                	srli	a5,a5,0x20
 59c:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 5a0:	fff4c583          	lbu	a1,-1(s1)
 5a4:	854a                	mv	a0,s2
 5a6:	f67ff0ef          	jal	50c <putc>
  while (--i >= 0)
 5aa:	14fd                	addi	s1,s1,-1
 5ac:	ff349ae3          	bne	s1,s3,5a0 <printint+0x76>
 5b0:	74e2                	ld	s1,56(sp)
 5b2:	79a2                	ld	s3,40(sp)
}
 5b4:	60a6                	ld	ra,72(sp)
 5b6:	6406                	ld	s0,64(sp)
 5b8:	7942                	ld	s2,48(sp)
 5ba:	6161                	addi	sp,sp,80
 5bc:	8082                	ret
    x = -xx;
 5be:	40b005b3          	neg	a1,a1
    neg = 1;
 5c2:	4885                	li	a7,1
    x = -xx;
 5c4:	bfad                	j	53e <printint+0x14>

00000000000005c6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5c6:	711d                	addi	sp,sp,-96
 5c8:	ec86                	sd	ra,88(sp)
 5ca:	e8a2                	sd	s0,80(sp)
 5cc:	e0ca                	sd	s2,64(sp)
 5ce:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 5d0:	0005c903          	lbu	s2,0(a1)
 5d4:	28090663          	beqz	s2,860 <vprintf+0x29a>
 5d8:	e4a6                	sd	s1,72(sp)
 5da:	fc4e                	sd	s3,56(sp)
 5dc:	f852                	sd	s4,48(sp)
 5de:	f456                	sd	s5,40(sp)
 5e0:	f05a                	sd	s6,32(sp)
 5e2:	ec5e                	sd	s7,24(sp)
 5e4:	e862                	sd	s8,16(sp)
 5e6:	e466                	sd	s9,8(sp)
 5e8:	8b2a                	mv	s6,a0
 5ea:	8a2e                	mv	s4,a1
 5ec:	8bb2                	mv	s7,a2
  state = 0;
 5ee:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 5f0:	4481                	li	s1,0
 5f2:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 5f4:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 5f8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 5fc:	06c00c93          	li	s9,108
 600:	a005                	j	620 <vprintf+0x5a>
        putc(fd, c0);
 602:	85ca                	mv	a1,s2
 604:	855a                	mv	a0,s6
 606:	f07ff0ef          	jal	50c <putc>
 60a:	a019                	j	610 <vprintf+0x4a>
    } else if (state == '%') {
 60c:	03598263          	beq	s3,s5,630 <vprintf+0x6a>
  for (i = 0; fmt[i]; i++) {
 610:	2485                	addiw	s1,s1,1
 612:	8726                	mv	a4,s1
 614:	009a07b3          	add	a5,s4,s1
 618:	0007c903          	lbu	s2,0(a5)
 61c:	22090a63          	beqz	s2,850 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 620:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 624:	fe0994e3          	bnez	s3,60c <vprintf+0x46>
      if (c0 == '%') {
 628:	fd579de3          	bne	a5,s5,602 <vprintf+0x3c>
        state = '%';
 62c:	89be                	mv	s3,a5
 62e:	b7cd                	j	610 <vprintf+0x4a>
        c1 = fmt[i + 1] & 0xff;
 630:	00ea06b3          	add	a3,s4,a4
 634:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 638:	8636                	mv	a2,a3
      if (c1)
 63a:	c681                	beqz	a3,642 <vprintf+0x7c>
        c2 = fmt[i + 2] & 0xff;
 63c:	9752                	add	a4,a4,s4
 63e:	00274603          	lbu	a2,2(a4)
      if (c0 == 'd') {
 642:	05878363          	beq	a5,s8,688 <vprintf+0xc2>
      } else if (c0 == 'l' && c1 == 'd') {
 646:	05978d63          	beq	a5,s9,6a0 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 64a:	07500713          	li	a4,117
 64e:	0ee78763          	beq	a5,a4,73c <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 652:	07800713          	li	a4,120
 656:	12e78963          	beq	a5,a4,788 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 65a:	07000713          	li	a4,112
 65e:	14e78e63          	beq	a5,a4,7ba <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 662:	06300713          	li	a4,99
 666:	18e78e63          	beq	a5,a4,802 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 66a:	07300713          	li	a4,115
 66e:	1ae78463          	beq	a5,a4,816 <vprintf+0x250>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 672:	02500713          	li	a4,37
 676:	04e79563          	bne	a5,a4,6c0 <vprintf+0xfa>
        putc(fd, '%');
 67a:	02500593          	li	a1,37
 67e:	855a                	mv	a0,s6
 680:	e8dff0ef          	jal	50c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 684:	4981                	li	s3,0
 686:	b769                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 688:	008b8913          	addi	s2,s7,8
 68c:	4685                	li	a3,1
 68e:	4629                	li	a2,10
 690:	000ba583          	lw	a1,0(s7)
 694:	855a                	mv	a0,s6
 696:	e95ff0ef          	jal	52a <printint>
 69a:	8bca                	mv	s7,s2
      state = 0;
 69c:	4981                	li	s3,0
 69e:	bf8d                	j	610 <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'd') {
 6a0:	06400793          	li	a5,100
 6a4:	02f68963          	beq	a3,a5,6d6 <vprintf+0x110>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 6a8:	06c00793          	li	a5,108
 6ac:	04f68263          	beq	a3,a5,6f0 <vprintf+0x12a>
      } else if (c0 == 'l' && c1 == 'u') {
 6b0:	07500793          	li	a5,117
 6b4:	0af68063          	beq	a3,a5,754 <vprintf+0x18e>
      } else if (c0 == 'l' && c1 == 'x') {
 6b8:	07800793          	li	a5,120
 6bc:	0ef68263          	beq	a3,a5,7a0 <vprintf+0x1da>
        putc(fd, '%');
 6c0:	02500593          	li	a1,37
 6c4:	855a                	mv	a0,s6
 6c6:	e47ff0ef          	jal	50c <putc>
        putc(fd, c0);
 6ca:	85ca                	mv	a1,s2
 6cc:	855a                	mv	a0,s6
 6ce:	e3fff0ef          	jal	50c <putc>
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	bf35                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d6:	008b8913          	addi	s2,s7,8
 6da:	4685                	li	a3,1
 6dc:	4629                	li	a2,10
 6de:	000bb583          	ld	a1,0(s7)
 6e2:	855a                	mv	a0,s6
 6e4:	e47ff0ef          	jal	52a <printint>
        i += 1;
 6e8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ea:	8bca                	mv	s7,s2
      state = 0;
 6ec:	4981                	li	s3,0
        i += 1;
 6ee:	b70d                	j	610 <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 6f0:	06400793          	li	a5,100
 6f4:	02f60763          	beq	a2,a5,722 <vprintf+0x15c>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 6f8:	07500793          	li	a5,117
 6fc:	06f60963          	beq	a2,a5,76e <vprintf+0x1a8>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 700:	07800793          	li	a5,120
 704:	faf61ee3          	bne	a2,a5,6c0 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 708:	008b8913          	addi	s2,s7,8
 70c:	4681                	li	a3,0
 70e:	4641                	li	a2,16
 710:	000bb583          	ld	a1,0(s7)
 714:	855a                	mv	a0,s6
 716:	e15ff0ef          	jal	52a <printint>
        i += 2;
 71a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 71c:	8bca                	mv	s7,s2
      state = 0;
 71e:	4981                	li	s3,0
        i += 2;
 720:	bdc5                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 722:	008b8913          	addi	s2,s7,8
 726:	4685                	li	a3,1
 728:	4629                	li	a2,10
 72a:	000bb583          	ld	a1,0(s7)
 72e:	855a                	mv	a0,s6
 730:	dfbff0ef          	jal	52a <printint>
        i += 2;
 734:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 736:	8bca                	mv	s7,s2
      state = 0;
 738:	4981                	li	s3,0
        i += 2;
 73a:	bdd9                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 73c:	008b8913          	addi	s2,s7,8
 740:	4681                	li	a3,0
 742:	4629                	li	a2,10
 744:	000be583          	lwu	a1,0(s7)
 748:	855a                	mv	a0,s6
 74a:	de1ff0ef          	jal	52a <printint>
 74e:	8bca                	mv	s7,s2
      state = 0;
 750:	4981                	li	s3,0
 752:	bd7d                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 754:	008b8913          	addi	s2,s7,8
 758:	4681                	li	a3,0
 75a:	4629                	li	a2,10
 75c:	000bb583          	ld	a1,0(s7)
 760:	855a                	mv	a0,s6
 762:	dc9ff0ef          	jal	52a <printint>
        i += 1;
 766:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 768:	8bca                	mv	s7,s2
      state = 0;
 76a:	4981                	li	s3,0
        i += 1;
 76c:	b555                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 76e:	008b8913          	addi	s2,s7,8
 772:	4681                	li	a3,0
 774:	4629                	li	a2,10
 776:	000bb583          	ld	a1,0(s7)
 77a:	855a                	mv	a0,s6
 77c:	dafff0ef          	jal	52a <printint>
        i += 2;
 780:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 782:	8bca                	mv	s7,s2
      state = 0;
 784:	4981                	li	s3,0
        i += 2;
 786:	b569                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 788:	008b8913          	addi	s2,s7,8
 78c:	4681                	li	a3,0
 78e:	4641                	li	a2,16
 790:	000be583          	lwu	a1,0(s7)
 794:	855a                	mv	a0,s6
 796:	d95ff0ef          	jal	52a <printint>
 79a:	8bca                	mv	s7,s2
      state = 0;
 79c:	4981                	li	s3,0
 79e:	bd8d                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7a0:	008b8913          	addi	s2,s7,8
 7a4:	4681                	li	a3,0
 7a6:	4641                	li	a2,16
 7a8:	000bb583          	ld	a1,0(s7)
 7ac:	855a                	mv	a0,s6
 7ae:	d7dff0ef          	jal	52a <printint>
        i += 1;
 7b2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7b4:	8bca                	mv	s7,s2
      state = 0;
 7b6:	4981                	li	s3,0
        i += 1;
 7b8:	bda1                	j	610 <vprintf+0x4a>
 7ba:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7bc:	008b8d13          	addi	s10,s7,8
 7c0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7c4:	03000593          	li	a1,48
 7c8:	855a                	mv	a0,s6
 7ca:	d43ff0ef          	jal	50c <putc>
  putc(fd, 'x');
 7ce:	07800593          	li	a1,120
 7d2:	855a                	mv	a0,s6
 7d4:	d39ff0ef          	jal	50c <putc>
 7d8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7da:	00000b97          	auipc	s7,0x0
 7de:	2b6b8b93          	addi	s7,s7,694 # a90 <digits>
 7e2:	03c9d793          	srli	a5,s3,0x3c
 7e6:	97de                	add	a5,a5,s7
 7e8:	0007c583          	lbu	a1,0(a5)
 7ec:	855a                	mv	a0,s6
 7ee:	d1fff0ef          	jal	50c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7f2:	0992                	slli	s3,s3,0x4
 7f4:	397d                	addiw	s2,s2,-1
 7f6:	fe0916e3          	bnez	s2,7e2 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7fa:	8bea                	mv	s7,s10
      state = 0;
 7fc:	4981                	li	s3,0
 7fe:	6d02                	ld	s10,0(sp)
 800:	bd01                	j	610 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 802:	008b8913          	addi	s2,s7,8
 806:	000bc583          	lbu	a1,0(s7)
 80a:	855a                	mv	a0,s6
 80c:	d01ff0ef          	jal	50c <putc>
 810:	8bca                	mv	s7,s2
      state = 0;
 812:	4981                	li	s3,0
 814:	bbf5                	j	610 <vprintf+0x4a>
        if ((s = va_arg(ap, char *)) == 0)
 816:	008b8993          	addi	s3,s7,8
 81a:	000bb903          	ld	s2,0(s7)
 81e:	00090f63          	beqz	s2,83c <vprintf+0x276>
        for (; *s; s++)
 822:	00094583          	lbu	a1,0(s2)
 826:	c195                	beqz	a1,84a <vprintf+0x284>
          putc(fd, *s);
 828:	855a                	mv	a0,s6
 82a:	ce3ff0ef          	jal	50c <putc>
        for (; *s; s++)
 82e:	0905                	addi	s2,s2,1
 830:	00094583          	lbu	a1,0(s2)
 834:	f9f5                	bnez	a1,828 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 836:	8bce                	mv	s7,s3
      state = 0;
 838:	4981                	li	s3,0
 83a:	bbd9                	j	610 <vprintf+0x4a>
          s = "(null)";
 83c:	00000917          	auipc	s2,0x0
 840:	24c90913          	addi	s2,s2,588 # a88 <malloc+0x140>
        for (; *s; s++)
 844:	02800593          	li	a1,40
 848:	b7c5                	j	828 <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 84a:	8bce                	mv	s7,s3
      state = 0;
 84c:	4981                	li	s3,0
 84e:	b3c9                	j	610 <vprintf+0x4a>
 850:	64a6                	ld	s1,72(sp)
 852:	79e2                	ld	s3,56(sp)
 854:	7a42                	ld	s4,48(sp)
 856:	7aa2                	ld	s5,40(sp)
 858:	7b02                	ld	s6,32(sp)
 85a:	6be2                	ld	s7,24(sp)
 85c:	6c42                	ld	s8,16(sp)
 85e:	6ca2                	ld	s9,8(sp)
    }
  }
}
 860:	60e6                	ld	ra,88(sp)
 862:	6446                	ld	s0,80(sp)
 864:	6906                	ld	s2,64(sp)
 866:	6125                	addi	sp,sp,96
 868:	8082                	ret

000000000000086a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 86a:	715d                	addi	sp,sp,-80
 86c:	ec06                	sd	ra,24(sp)
 86e:	e822                	sd	s0,16(sp)
 870:	1000                	addi	s0,sp,32
 872:	e010                	sd	a2,0(s0)
 874:	e414                	sd	a3,8(s0)
 876:	e818                	sd	a4,16(s0)
 878:	ec1c                	sd	a5,24(s0)
 87a:	03043023          	sd	a6,32(s0)
 87e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 882:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 886:	8622                	mv	a2,s0
 888:	d3fff0ef          	jal	5c6 <vprintf>
}
 88c:	60e2                	ld	ra,24(sp)
 88e:	6442                	ld	s0,16(sp)
 890:	6161                	addi	sp,sp,80
 892:	8082                	ret

0000000000000894 <printf>:

void
printf(const char *fmt, ...)
{
 894:	711d                	addi	sp,sp,-96
 896:	ec06                	sd	ra,24(sp)
 898:	e822                	sd	s0,16(sp)
 89a:	1000                	addi	s0,sp,32
 89c:	e40c                	sd	a1,8(s0)
 89e:	e810                	sd	a2,16(s0)
 8a0:	ec14                	sd	a3,24(s0)
 8a2:	f018                	sd	a4,32(s0)
 8a4:	f41c                	sd	a5,40(s0)
 8a6:	03043823          	sd	a6,48(s0)
 8aa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ae:	00840613          	addi	a2,s0,8
 8b2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8b6:	85aa                	mv	a1,a0
 8b8:	4505                	li	a0,1
 8ba:	d0dff0ef          	jal	5c6 <vprintf>
}
 8be:	60e2                	ld	ra,24(sp)
 8c0:	6442                	ld	s0,16(sp)
 8c2:	6125                	addi	sp,sp,96
 8c4:	8082                	ret

00000000000008c6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c6:	1141                	addi	sp,sp,-16
 8c8:	e422                	sd	s0,8(sp)
 8ca:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 8cc:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d0:	00000797          	auipc	a5,0x0
 8d4:	7307b783          	ld	a5,1840(a5) # 1000 <freep>
 8d8:	a02d                	j	902 <free+0x3c>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
    bp->s.size += p->s.ptr->s.size;
 8da:	4618                	lw	a4,8(a2)
 8dc:	9f2d                	addw	a4,a4,a1
 8de:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e2:	6398                	ld	a4,0(a5)
 8e4:	6310                	ld	a2,0(a4)
 8e6:	a83d                	j	924 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    p->s.size += bp->s.size;
 8e8:	ff852703          	lw	a4,-8(a0)
 8ec:	9f31                	addw	a4,a4,a2
 8ee:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8f0:	ff053683          	ld	a3,-16(a0)
 8f4:	a091                	j	938 <free+0x72>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f6:	6398                	ld	a4,0(a5)
 8f8:	00e7e463          	bltu	a5,a4,900 <free+0x3a>
 8fc:	00e6ea63          	bltu	a3,a4,910 <free+0x4a>
{
 900:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 902:	fed7fae3          	bgeu	a5,a3,8f6 <free+0x30>
 906:	6398                	ld	a4,0(a5)
 908:	00e6e463          	bltu	a3,a4,910 <free+0x4a>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 90c:	fee7eae3          	bltu	a5,a4,900 <free+0x3a>
  if (bp + bp->s.size == p->s.ptr) {
 910:	ff852583          	lw	a1,-8(a0)
 914:	6390                	ld	a2,0(a5)
 916:	02059813          	slli	a6,a1,0x20
 91a:	01c85713          	srli	a4,a6,0x1c
 91e:	9736                	add	a4,a4,a3
 920:	fae60de3          	beq	a2,a4,8da <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 924:	fec53823          	sd	a2,-16(a0)
  if (p + p->s.size == bp) {
 928:	4790                	lw	a2,8(a5)
 92a:	02061593          	slli	a1,a2,0x20
 92e:	01c5d713          	srli	a4,a1,0x1c
 932:	973e                	add	a4,a4,a5
 934:	fae68ae3          	beq	a3,a4,8e8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 938:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 93a:	00000717          	auipc	a4,0x0
 93e:	6cf73323          	sd	a5,1734(a4) # 1000 <freep>
}
 942:	6422                	ld	s0,8(sp)
 944:	0141                	addi	sp,sp,16
 946:	8082                	ret

0000000000000948 <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 948:	7139                	addi	sp,sp,-64
 94a:	fc06                	sd	ra,56(sp)
 94c:	f822                	sd	s0,48(sp)
 94e:	f426                	sd	s1,40(sp)
 950:	ec4e                	sd	s3,24(sp)
 952:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 954:	02051493          	slli	s1,a0,0x20
 958:	9081                	srli	s1,s1,0x20
 95a:	04bd                	addi	s1,s1,15
 95c:	8091                	srli	s1,s1,0x4
 95e:	0014899b          	addiw	s3,s1,1
 962:	0485                	addi	s1,s1,1
  if ((prevp = freep) == 0) {
 964:	00000517          	auipc	a0,0x0
 968:	69c53503          	ld	a0,1692(a0) # 1000 <freep>
 96c:	c915                	beqz	a0,9a0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 96e:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 970:	4798                	lw	a4,8(a5)
 972:	08977a63          	bgeu	a4,s1,a06 <malloc+0xbe>
 976:	f04a                	sd	s2,32(sp)
 978:	e852                	sd	s4,16(sp)
 97a:	e456                	sd	s5,8(sp)
 97c:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 97e:	8a4e                	mv	s4,s3
 980:	0009871b          	sext.w	a4,s3
 984:	6685                	lui	a3,0x1
 986:	00d77363          	bgeu	a4,a3,98c <malloc+0x44>
 98a:	6a05                	lui	s4,0x1
 98c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 990:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 994:	00000917          	auipc	s2,0x0
 998:	66c90913          	addi	s2,s2,1644 # 1000 <freep>
  if (p == SBRK_ERROR)
 99c:	5afd                	li	s5,-1
 99e:	a081                	j	9de <malloc+0x96>
 9a0:	f04a                	sd	s2,32(sp)
 9a2:	e852                	sd	s4,16(sp)
 9a4:	e456                	sd	s5,8(sp)
 9a6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9a8:	00000797          	auipc	a5,0x0
 9ac:	69078793          	addi	a5,a5,1680 # 1038 <base>
 9b0:	00000717          	auipc	a4,0x0
 9b4:	64f73823          	sd	a5,1616(a4) # 1000 <freep>
 9b8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9ba:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 9be:	b7c1                	j	97e <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9c0:	6398                	ld	a4,0(a5)
 9c2:	e118                	sd	a4,0(a0)
 9c4:	a8a9                	j	a1e <malloc+0xd6>
  hp->s.size = nu;
 9c6:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 9ca:	0541                	addi	a0,a0,16
 9cc:	efbff0ef          	jal	8c6 <free>
  return freep;
 9d0:	00093503          	ld	a0,0(s2)
      if ((p = morecore(nunits)) == 0)
 9d4:	c12d                	beqz	a0,a36 <malloc+0xee>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 9d6:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 9d8:	4798                	lw	a4,8(a5)
 9da:	02977263          	bgeu	a4,s1,9fe <malloc+0xb6>
    if (p == freep)
 9de:	00093703          	ld	a4,0(s2)
 9e2:	853e                	mv	a0,a5
 9e4:	fef719e3          	bne	a4,a5,9d6 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9e8:	8552                	mv	a0,s4
 9ea:	a47ff0ef          	jal	430 <sbrk>
  if (p == SBRK_ERROR)
 9ee:	fd551ce3          	bne	a0,s5,9c6 <malloc+0x7e>
        return 0;
 9f2:	4501                	li	a0,0
 9f4:	7902                	ld	s2,32(sp)
 9f6:	6a42                	ld	s4,16(sp)
 9f8:	6aa2                	ld	s5,8(sp)
 9fa:	6b02                	ld	s6,0(sp)
 9fc:	a03d                	j	a2a <malloc+0xe2>
 9fe:	7902                	ld	s2,32(sp)
 a00:	6a42                	ld	s4,16(sp)
 a02:	6aa2                	ld	s5,8(sp)
 a04:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 a06:	fae48de3          	beq	s1,a4,9c0 <malloc+0x78>
        p->s.size -= nunits;
 a0a:	4137073b          	subw	a4,a4,s3
 a0e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a10:	02071693          	slli	a3,a4,0x20
 a14:	01c6d713          	srli	a4,a3,0x1c
 a18:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a1a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a1e:	00000717          	auipc	a4,0x0
 a22:	5ea73123          	sd	a0,1506(a4) # 1000 <freep>
      return (void *)(p + 1);
 a26:	01078513          	addi	a0,a5,16
  }
}
 a2a:	70e2                	ld	ra,56(sp)
 a2c:	7442                	ld	s0,48(sp)
 a2e:	74a2                	ld	s1,40(sp)
 a30:	69e2                	ld	s3,24(sp)
 a32:	6121                	addi	sp,sp,64
 a34:	8082                	ret
 a36:	7902                	ld	s2,32(sp)
 a38:	6a42                	ld	s4,16(sp)
 a3a:	6aa2                	ld	s5,8(sp)
 a3c:	6b02                	ld	s6,0(sp)
 a3e:	b7f5                	j	a2a <malloc+0xe2>
