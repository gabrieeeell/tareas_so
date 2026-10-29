
user/_test_threads:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <srand>:
#include "user/user.h"
//#include <stdlib.h>

static unsigned long rand_state = 1;

void srand(unsigned int seed) {
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
    rand_state = seed;
   6:	1502                	slli	a0,a0,0x20
   8:	9101                	srli	a0,a0,0x20
   a:	00002797          	auipc	a5,0x2
   e:	fea7bb23          	sd	a0,-10(a5) # 2000 <rand_state>
}
  12:	6422                	ld	s0,8(sp)
  14:	0141                	addi	sp,sp,16
  16:	8082                	ret

0000000000000018 <rand>:

int rand(void) {
  18:	1141                	addi	sp,sp,-16
  1a:	e422                	sd	s0,8(sp)
  1c:	0800                	addi	s0,sp,16
    rand_state = rand_state * 1103515245 + 12345;
  1e:	00002717          	auipc	a4,0x2
  22:	fe270713          	addi	a4,a4,-30 # 2000 <rand_state>
  26:	6308                	ld	a0,0(a4)
  28:	41c657b7          	lui	a5,0x41c65
  2c:	e6d78793          	addi	a5,a5,-403 # 41c64e6d <base+0x41c4e4ed>
  30:	02f50533          	mul	a0,a0,a5
  34:	678d                	lui	a5,0x3
  36:	03978793          	addi	a5,a5,57 # 3039 <thread_pool+0x1019>
  3a:	953e                	add	a0,a0,a5
  3c:	e308                	sd	a0,0(a4)
    return (unsigned int)(rand_state / 65536) % 32768;
  3e:	1506                	slli	a0,a0,0x21
}
  40:	9145                	srli	a0,a0,0x31
  42:	6422                	ld	s0,8(sp)
  44:	0141                	addi	sp,sp,16
  46:	8082                	ret

0000000000000048 <thread_create>:


// No puedo crear un stack dentro del contexto de la funcion, ya que en el momento que retorne desde esta se borrara y luego dara un
// segmentation fault al referenciar a ese stack
void thread_create(void funcion(void)) {
  for (int i = 0; i < MAX_THREADS; i++) {
  48:	00002717          	auipc	a4,0x2
  4c:	fd870713          	addi	a4,a4,-40 # 2020 <thread_pool>
  50:	4781                	li	a5,0
  52:	6605                	lui	a2,0x1
  54:	07860613          	addi	a2,a2,120 # 1078 <digits+0x350>
  58:	45d1                	li	a1,20
    // A las hebras no les debo copiar el valor de los s0-s11 ni del stack inicialmente ya que estas ya que esats como que unicamente se inician para realizar
    // una función, no se les pasa el contexto de donde se llamaron originalmente o algo asi
    if (thread_pool[i].estado_thread == LIBRE) {
  5a:	4314                	lw	a3,0(a4)
  5c:	c29d                	beqz	a3,82 <thread_create+0x3a>
  for (int i = 0; i < MAX_THREADS; i++) {
  5e:	2785                	addiw	a5,a5,1
  60:	9732                	add	a4,a4,a2
  62:	feb79ce3          	bne	a5,a1,5a <thread_create+0x12>
void thread_create(void funcion(void)) {
  66:	1141                	addi	sp,sp,-16
  68:	e406                	sd	ra,8(sp)
  6a:	e022                	sd	s0,0(sp)
  6c:	0800                	addi	s0,sp,16
      thread_pool[i].estado_thread = LISTA_PARA_CORRER;
      // no hice cambios al registro "ra" por lo que se puede retornar con normalidad
      return;
    }
  }
  printf("No hay hebras disponibles");
  6e:	00001517          	auipc	a0,0x1
  72:	bc250513          	addi	a0,a0,-1086 # c30 <switch_context+0x6c>
  76:	1a1000ef          	jal	a16 <printf>
}
  7a:	60a2                	ld	ra,8(sp)
  7c:	6402                	ld	s0,0(sp)
  7e:	0141                	addi	sp,sp,16
  80:	8082                	ret
      thread_pool[i].ra = (uint64)funcion; // por defecto el nombre de la funcion es la direccion de memoria fisica donde comienzan las instrucciones de esta
  82:	00002597          	auipc	a1,0x2
  86:	f9e58593          	addi	a1,a1,-98 # 2020 <thread_pool>
  8a:	6605                	lui	a2,0x1
  8c:	6705                	lui	a4,0x1
  8e:	07870713          	addi	a4,a4,120 # 1078 <digits+0x350>
  92:	02e787b3          	mul	a5,a5,a4
  96:	00f58733          	add	a4,a1,a5
  9a:	00e606b3          	add	a3,a2,a4
  9e:	f6a8                	sd	a0,104(a3)
      uint64 comienzo_stack = (uint64)(thread_pool[i].stack) + (uint64)(sizeof(char)) * 4096;
  a0:	0791                	addi	a5,a5,4
  a2:	97ae                	add	a5,a5,a1
  a4:	97b2                	add	a5,a5,a2
      thread_pool[i].sp = comienzo_stack;
  a6:	fabc                	sd	a5,112(a3)
      thread_pool[i].estado_thread = LISTA_PARA_CORRER;
  a8:	4785                	li	a5,1
  aa:	c31c                	sw	a5,0(a4)
      return;
  ac:	8082                	ret

00000000000000ae <thread_init>:

// La unica función que cumple es asignar la "hebra original" del proceso a la lista de thread_pool
// Notar que la hebra original ignorara el stack definido en su struct, ya que realmente su "sp" apuntara a donde este apuntando orignalmente el "sp" del
// proceso que probablemente es despues de la declaracion de todas las hebras y stacks respectivos
// Ademas esta función probablemente sirve para argumentar el paso 4.1 de la pauta
void thread_init() {
  ae:	1141                	addi	sp,sp,-16
  b0:	e406                	sd	ra,8(sp)
  b2:	e022                	sd	s0,0(sp)
  b4:	0800                	addi	s0,sp,16
  srand(uptime());
  b6:	5c8000ef          	jal	67e <uptime>
    rand_state = seed;
  ba:	1502                	slli	a0,a0,0x20
  bc:	9101                	srli	a0,a0,0x20
  be:	00002797          	auipc	a5,0x2
  c2:	f4a7b123          	sd	a0,-190(a5) # 2000 <rand_state>
  thread_pool[0].estado_thread = CORRIENDO;  
  c6:	00002797          	auipc	a5,0x2
  ca:	f5a78793          	addi	a5,a5,-166 # 2020 <thread_pool>
  ce:	4709                	li	a4,2
  d0:	c398                	sw	a4,0(a5)
  hebra_actual = &thread_pool[0];
  d2:	00002717          	auipc	a4,0x2
  d6:	f2f73f23          	sd	a5,-194(a4) # 2010 <hebra_actual>
}
  da:	60a2                	ld	ra,8(sp)
  dc:	6402                	ld	s0,0(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret

00000000000000e2 <thread_schedule>:
extern void switch_context(void* thread_dnd_guardar_context_actual, void* thread_a_ejecutar);




void thread_schedule() {
  e2:	7115                	addi	sp,sp,-224
  e4:	ed86                	sd	ra,216(sp)
  e6:	e9a2                	sd	s0,208(sp)
  e8:	e5a6                	sd	s1,200(sp)
  ea:	e1ca                	sd	s2,192(sp)
  ec:	fd4e                	sd	s3,184(sp)
  ee:	f952                	sd	s4,176(sp)
  f0:	f556                	sd	s5,168(sp)
  f2:	f15a                	sd	s6,160(sp)
  f4:	1180                	addi	s0,sp,224
  f6:	8a0a                	mv	s4,sp
  // Se copia el puntero de la hebra que se está ejectuando en este momento en "hebra_reemplazada"
  // esto sirve para poder guardar el contexto de la hebra que se está ejecutando actualmente
  // entonces como la función se RISC V reemplaza los registros de las hebras, si no se clonara no se podría
  // guardar cual fue la hebra que se estaba ejecutando antes
    struct Thread* hebra_reemplazada = hebra_actual;
  f8:	00002997          	auipc	s3,0x2
  fc:	f189b983          	ld	s3,-232(s3) # 2010 <hebra_actual>
    int largo = MAX_THREADS;
    
    // aritmetica de punteros para saber el indice de la hebra que se va a reemplazar
    int id_reemplazada = hebra_actual - thread_pool;
 100:	00002917          	auipc	s2,0x2
 104:	f2090913          	addi	s2,s2,-224 # 2020 <thread_pool>
 108:	41298933          	sub	s2,s3,s2
 10c:	40395913          	srai	s2,s2,0x3
 110:	ffa4b7b7          	lui	a5,0xffa4b
 114:	cef78793          	addi	a5,a5,-785 # ffffffffffa4acef <base+0xffffffffffa3436f>
 118:	07ba                	slli	a5,a5,0xe
 11a:	1785                	addi	a5,a5,-31
 11c:	07ba                	slli	a5,a5,0xe
 11e:	a4b78793          	addi	a5,a5,-1461
 122:	07b2                	slli	a5,a5,0xc
 124:	cef78793          	addi	a5,a5,-785
 128:	02f9093b          	mulw	s2,s2,a5
    int aux[largo - 1];
    
    // Se filtra
    // En aux se guardan todos los indices diferentes al de la hebra que se va a reemplazar
    int index_aux = 0;
    for (int i = 0; i < largo; i++) {
 12c:	4781                	li	a5,0
    int index_aux = 0;
 12e:	4681                	li	a3,0
    for (int i = 0; i < largo; i++) {
 130:	4651                	li	a2,20
 132:	a021                	j	13a <thread_schedule+0x58>
 134:	2785                	addiw	a5,a5,1
 136:	00c78d63          	beq	a5,a2,150 <thread_schedule+0x6e>
        if (i != id_reemplazada) {
 13a:	fef90de3          	beq	s2,a5,134 <thread_schedule+0x52>
            aux[index_aux] = i;
 13e:	00269713          	slli	a4,a3,0x2
 142:	fc070713          	addi	a4,a4,-64
 146:	9722                	add	a4,a4,s0
 148:	f6f72023          	sw	a5,-160(a4)
            index_aux++;
 14c:	2685                	addiw	a3,a3,1
 14e:	b7dd                	j	134 <thread_schedule+0x52>
 150:	f6840493          	addi	s1,s0,-152
 154:	f2040b13          	addi	s6,s0,-224
    for (int i = 0; i < largo; i++) {
 158:	4acd                	li	s5,19
    // Se elige indice aleatorio j.
    // Se recorre en orden inverso y se intercambia el valor del indice final i con alguno de una posicion j
    int hebras_disp = MAX_THREADS - 1;
    for (int i = hebras_disp - 1; i > 0; i--) {
        // rand() numero aleatorio, al hacer modulo da un rango entre 0 e i
        int j = rand() % (i + 1);
 15a:	ebfff0ef          	jal	18 <rand>
 15e:	0355653b          	remw	a0,a0,s5
        int temp = aux[i];
 162:	409c                	lw	a5,0(s1)
        aux[i] = aux[j];
 164:	050a                	slli	a0,a0,0x2
 166:	fc050713          	addi	a4,a0,-64
 16a:	00870533          	add	a0,a4,s0
 16e:	f6052703          	lw	a4,-160(a0)
 172:	c098                	sw	a4,0(s1)
        aux[j] = temp;
 174:	f6f52023          	sw	a5,-160(a0)
    for (int i = hebras_disp - 1; i > 0; i--) {
 178:	3afd                	addiw	s5,s5,-1
 17a:	86a6                	mv	a3,s1
 17c:	14f1                	addi	s1,s1,-4
 17e:	fd649ee3          	bne	s1,s6,15a <thread_schedule+0x78>
 182:	f7040713          	addi	a4,s0,-144
 186:	04868693          	addi	a3,a3,72
 18a:	87ba                	mv	a5,a4
    }

    // Se guardan todos los valores de los indices desordenados en los indices finales
    for (int i = 0; i < hebras_disp; i++) {
        indicesFinales[i] = aux[i];
 18c:	4090                	lw	a2,0(s1)
 18e:	c390                	sw	a2,0(a5)
    for (int i = 0; i < hebras_disp; i++) {
 190:	0491                	addi	s1,s1,4
 192:	0791                	addi	a5,a5,4
 194:	fed49ce3          	bne	s1,a3,18c <thread_schedule+0xaa>
    }

    // Se agrega el indice de la hebra reemplazada al final 
    indicesFinales[MAX_THREADS - 1] = id_reemplazada;
 198:	fb242e23          	sw	s2,-68(s0)

    // Aqui se recorren los indices random, se guarda el puntero de la hebra que se va a ejecutar, se cambia su estado
    // y despues se hace el cambio de contexto
    for (int i = 0; i < MAX_THREADS; i++) {
 19c:	05070813          	addi	a6,a4,80
        int indiceRandom = indicesFinales[i];
        if (thread_pool[indiceRandom].estado_thread == LISTA_PARA_CORRER) {
 1a0:	00002517          	auipc	a0,0x2
 1a4:	e8050513          	addi	a0,a0,-384 # 2020 <thread_pool>
 1a8:	6605                	lui	a2,0x1
 1aa:	07860613          	addi	a2,a2,120 # 1078 <digits+0x350>
 1ae:	4585                	li	a1,1
        int indiceRandom = indicesFinales[i];
 1b0:	4314                	lw	a3,0(a4)
        if (thread_pool[indiceRandom].estado_thread == LISTA_PARA_CORRER) {
 1b2:	02c687b3          	mul	a5,a3,a2
 1b6:	97aa                	add	a5,a5,a0
 1b8:	439c                	lw	a5,0(a5)
 1ba:	00b78763          	beq	a5,a1,1c8 <thread_schedule+0xe6>
    for (int i = 0; i < MAX_THREADS; i++) {
 1be:	0711                	addi	a4,a4,4
 1c0:	ff0718e3          	bne	a4,a6,1b0 <thread_schedule+0xce>
 1c4:	8152                	mv	sp,s4
 1c6:	a815                	j	1fa <thread_schedule+0x118>
            hebra_actual = &thread_pool[indiceRandom];
 1c8:	6785                	lui	a5,0x1
 1ca:	07878793          	addi	a5,a5,120 # 1078 <digits+0x350>
 1ce:	02f686b3          	mul	a3,a3,a5
 1d2:	00002597          	auipc	a1,0x2
 1d6:	e4e58593          	addi	a1,a1,-434 # 2020 <thread_pool>
 1da:	00b687b3          	add	a5,a3,a1
 1de:	00002717          	auipc	a4,0x2
 1e2:	e2f73923          	sd	a5,-462(a4) # 2010 <hebra_actual>
            hebra_actual->estado_thread = CORRIENDO;
 1e6:	4709                	li	a4,2
 1e8:	c398                	sw	a4,0(a5)
            switch_context(&hebra_reemplazada->s0, &hebra_actual->s0);
 1ea:	6505                	lui	a0,0x1
 1ec:	0521                	addi	a0,a0,8 # 1008 <digits+0x2e0>
 1ee:	96aa                	add	a3,a3,a0
 1f0:	95b6                	add	a1,a1,a3
 1f2:	954e                	add	a0,a0,s3
 1f4:	1d1000ef          	jal	bc4 <switch_context>
            return;
 1f8:	8152                	mv	sp,s4
        }
    }
}
 1fa:	60ee                	ld	ra,216(sp)
 1fc:	644e                	ld	s0,208(sp)
 1fe:	64ae                	ld	s1,200(sp)
 200:	690e                	ld	s2,192(sp)
 202:	79ea                	ld	s3,184(sp)
 204:	7a4a                	ld	s4,176(sp)
 206:	7aaa                	ld	s5,168(sp)
 208:	7b0a                	ld	s6,160(sp)
 20a:	612d                	addi	sp,sp,224
 20c:	8082                	ret

000000000000020e <thread_yield>:

// Simplemente cambia el estado de la hebra que lo llame y hace que otra tome la CPU
void thread_yield() {
 20e:	1141                	addi	sp,sp,-16
 210:	e406                	sd	ra,8(sp)
 212:	e022                	sd	s0,0(sp)
 214:	0800                	addi	s0,sp,16
    hebra_actual->estado_thread = LISTA_PARA_CORRER;
 216:	00002797          	auipc	a5,0x2
 21a:	dfa7b783          	ld	a5,-518(a5) # 2010 <hebra_actual>
 21e:	4705                	li	a4,1
 220:	c398                	sw	a4,0(a5)
    thread_schedule();
 222:	ec1ff0ef          	jal	e2 <thread_schedule>
}
 226:	60a2                	ld	ra,8(sp)
 228:	6402                	ld	s0,0(sp)
 22a:	0141                	addi	sp,sp,16
 22c:	8082                	ret

000000000000022e <thread_exit>:

void thread_exit() {
 22e:	1141                	addi	sp,sp,-16
 230:	e406                	sd	ra,8(sp)
 232:	e022                	sd	s0,0(sp)
 234:	0800                	addi	s0,sp,16
    hebra_actual->estado_thread = LIBRE;
 236:	00002797          	auipc	a5,0x2
 23a:	dda7b783          	ld	a5,-550(a5) # 2010 <hebra_actual>
 23e:	0007a023          	sw	zero,0(a5)

    // Ver si hay hebras activas
    int hay_hebras_activas = 0;
    for (int i = 1; i < MAX_THREADS; i++) {
 242:	00003797          	auipc	a5,0x3
 246:	e5678793          	addi	a5,a5,-426 # 3098 <thread_pool+0x1078>
 24a:	00016617          	auipc	a2,0x16
 24e:	73660613          	addi	a2,a2,1846 # 16980 <base>
 252:	6685                	lui	a3,0x1
 254:	07868693          	addi	a3,a3,120 # 1078 <digits+0x350>
        if (thread_pool[i].estado_thread != LIBRE) {
 258:	4398                	lw	a4,0(a5)
 25a:	eb09                	bnez	a4,26c <thread_exit+0x3e>
    for (int i = 1; i < MAX_THREADS; i++) {
 25c:	97b6                	add	a5,a5,a3
 25e:	fec79de3          	bne	a5,a2,258 <thread_exit+0x2a>
    }

    // Esto es para que la hebra principal pueda volver a tomar el control cuando todas las hebras
    // terminen de ejecutar su función
    if (!hay_hebras_activas) {
        thread_pool[0].estado_thread = LISTA_PARA_CORRER;
 262:	4785                	li	a5,1
 264:	00002717          	auipc	a4,0x2
 268:	daf72e23          	sw	a5,-580(a4) # 2020 <thread_pool>
    }
    thread_schedule();
 26c:	e77ff0ef          	jal	e2 <thread_schedule>
}
 270:	60a2                	ld	ra,8(sp)
 272:	6402                	ld	s0,0(sp)
 274:	0141                	addi	sp,sp,16
 276:	8082                	ret

0000000000000278 <tarea_generica>:
#include "kernel/stat.h"
#include "user/user.h"
#include "threads.c"

// Tarea única y genérica para cualquier hebra
void tarea_generica() {
 278:	7179                	addi	sp,sp,-48
 27a:	f406                	sd	ra,40(sp)
 27c:	f022                	sd	s0,32(sp)
 27e:	ec26                	sd	s1,24(sp)
 280:	e84a                	sd	s2,16(sp)
 282:	e44e                	sd	s3,8(sp)
 284:	e052                	sd	s4,0(sp)
 286:	1800                	addi	s0,sp,48
    // Obtenemos el ID de la hebra actual dinámicamente mediante aritmética de punteros
    int id = hebra_actual - thread_pool;
 288:	00002917          	auipc	s2,0x2
 28c:	d8893903          	ld	s2,-632(s2) # 2010 <hebra_actual>
 290:	00002797          	auipc	a5,0x2
 294:	d9078793          	addi	a5,a5,-624 # 2020 <thread_pool>
 298:	40f90933          	sub	s2,s2,a5
 29c:	40395913          	srai	s2,s2,0x3
 2a0:	ffa4b7b7          	lui	a5,0xffa4b
 2a4:	cef78793          	addi	a5,a5,-785 # ffffffffffa4acef <base+0xffffffffffa3436f>
 2a8:	07ba                	slli	a5,a5,0xe
 2aa:	1785                	addi	a5,a5,-31
 2ac:	07ba                	slli	a5,a5,0xe
 2ae:	a4b78793          	addi	a5,a5,-1461
 2b2:	07b2                	slli	a5,a5,0xc
 2b4:	cef78793          	addi	a5,a5,-785
 2b8:	02f9093b          	mulw	s2,s2,a5

    for (int i = 1; i <= 5; i++) {
 2bc:	4485                	li	s1,1
        printf("Hebra %d - Iteracion %d\n", id, i);
 2be:	00001a17          	auipc	s4,0x1
 2c2:	992a0a13          	addi	s4,s4,-1646 # c50 <switch_context+0x8c>
    for (int i = 1; i <= 5; i++) {
 2c6:	4999                	li	s3,6
        printf("Hebra %d - Iteracion %d\n", id, i);
 2c8:	8626                	mv	a2,s1
 2ca:	85ca                	mv	a1,s2
 2cc:	8552                	mv	a0,s4
 2ce:	748000ef          	jal	a16 <printf>
        thread_yield();
 2d2:	f3dff0ef          	jal	20e <thread_yield>
    for (int i = 1; i <= 5; i++) {
 2d6:	2485                	addiw	s1,s1,1
 2d8:	ff3498e3          	bne	s1,s3,2c8 <tarea_generica+0x50>
    }
    printf("Hebra %d termino su trabajo.\n", id);
 2dc:	85ca                	mv	a1,s2
 2de:	00001517          	auipc	a0,0x1
 2e2:	99250513          	addi	a0,a0,-1646 # c70 <switch_context+0xac>
 2e6:	730000ef          	jal	a16 <printf>
    thread_exit();
 2ea:	f45ff0ef          	jal	22e <thread_exit>
}
 2ee:	70a2                	ld	ra,40(sp)
 2f0:	7402                	ld	s0,32(sp)
 2f2:	64e2                	ld	s1,24(sp)
 2f4:	6942                	ld	s2,16(sp)
 2f6:	69a2                	ld	s3,8(sp)
 2f8:	6a02                	ld	s4,0(sp)
 2fa:	6145                	addi	sp,sp,48
 2fc:	8082                	ret

00000000000002fe <main>:

int main(int argc, char *argv[]) {
 2fe:	1101                	addi	sp,sp,-32
 300:	ec06                	sd	ra,24(sp)
 302:	e822                	sd	s0,16(sp)
 304:	e426                	sd	s1,8(sp)
 306:	e04a                	sd	s2,0(sp)
 308:	1000                	addi	s0,sp,32
    printf("Iniciando sistema con MAX_THREADS = %d...\n", MAX_THREADS);
 30a:	45d1                	li	a1,20
 30c:	00001517          	auipc	a0,0x1
 310:	98450513          	addi	a0,a0,-1660 # c90 <switch_context+0xcc>
 314:	702000ef          	jal	a16 <printf>

    // 1. Inicialización de la hebra principal (main ocupa el slot 0)
    thread_init(); 
 318:	d97ff0ef          	jal	ae <thread_init>
 31c:	44cd                	li	s1,19

    // 2. Creación dinámica de hebras según el MAX_THREADS definido
    // Se crean (MAX_THREADS - 1) hebras porque el slot 0 pertenece a main
    for (int i = 1; i < MAX_THREADS; i++) {
        thread_create(tarea_generica);
 31e:	00000917          	auipc	s2,0x0
 322:	f5a90913          	addi	s2,s2,-166 # 278 <tarea_generica>
 326:	854a                	mv	a0,s2
 328:	d21ff0ef          	jal	48 <thread_create>
    for (int i = 1; i < MAX_THREADS; i++) {
 32c:	34fd                	addiw	s1,s1,-1
 32e:	fce5                	bnez	s1,326 <main+0x28>
    }

    printf("Hebras creadas exitosamente. Encendiendo planificador...\n\n");
 330:	00001517          	auipc	a0,0x1
 334:	99050513          	addi	a0,a0,-1648 # cc0 <switch_context+0xfc>
 338:	6de000ef          	jal	a16 <printf>

    // 3. Encendido del motor del planificador
    thread_schedule();
 33c:	da7ff0ef          	jal	e2 <thread_schedule>

    printf("Todas las hebras finalizaron.\n");
 340:	00001517          	auipc	a0,0x1
 344:	9c050513          	addi	a0,a0,-1600 # d00 <switch_context+0x13c>
 348:	6ce000ef          	jal	a16 <printf>
    exit(0);
 34c:	4501                	li	a0,0
 34e:	298000ef          	jal	5e6 <exit>

0000000000000352 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 352:	1141                	addi	sp,sp,-16
 354:	e406                	sd	ra,8(sp)
 356:	e022                	sd	s0,0(sp)
 358:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 35a:	fa5ff0ef          	jal	2fe <main>
  exit(r);
 35e:	288000ef          	jal	5e6 <exit>

0000000000000362 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 362:	1141                	addi	sp,sp,-16
 364:	e422                	sd	s0,8(sp)
 366:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 368:	87aa                	mv	a5,a0
 36a:	0585                	addi	a1,a1,1
 36c:	0785                	addi	a5,a5,1
 36e:	fff5c703          	lbu	a4,-1(a1)
 372:	fee78fa3          	sb	a4,-1(a5)
 376:	fb75                	bnez	a4,36a <strcpy+0x8>
    ;
  return os;
}
 378:	6422                	ld	s0,8(sp)
 37a:	0141                	addi	sp,sp,16
 37c:	8082                	ret

000000000000037e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 37e:	1141                	addi	sp,sp,-16
 380:	e422                	sd	s0,8(sp)
 382:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 384:	00054783          	lbu	a5,0(a0)
 388:	cb91                	beqz	a5,39c <strcmp+0x1e>
 38a:	0005c703          	lbu	a4,0(a1)
 38e:	00f71763          	bne	a4,a5,39c <strcmp+0x1e>
    p++, q++;
 392:	0505                	addi	a0,a0,1
 394:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 396:	00054783          	lbu	a5,0(a0)
 39a:	fbe5                	bnez	a5,38a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 39c:	0005c503          	lbu	a0,0(a1)
}
 3a0:	40a7853b          	subw	a0,a5,a0
 3a4:	6422                	ld	s0,8(sp)
 3a6:	0141                	addi	sp,sp,16
 3a8:	8082                	ret

00000000000003aa <strlen>:

uint
strlen(const char *s)
{
 3aa:	1141                	addi	sp,sp,-16
 3ac:	e422                	sd	s0,8(sp)
 3ae:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 3b0:	00054783          	lbu	a5,0(a0)
 3b4:	cf91                	beqz	a5,3d0 <strlen+0x26>
 3b6:	0505                	addi	a0,a0,1
 3b8:	87aa                	mv	a5,a0
 3ba:	86be                	mv	a3,a5
 3bc:	0785                	addi	a5,a5,1
 3be:	fff7c703          	lbu	a4,-1(a5)
 3c2:	ff65                	bnez	a4,3ba <strlen+0x10>
 3c4:	40a6853b          	subw	a0,a3,a0
 3c8:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 3ca:	6422                	ld	s0,8(sp)
 3cc:	0141                	addi	sp,sp,16
 3ce:	8082                	ret
  for (n = 0; s[n]; n++)
 3d0:	4501                	li	a0,0
 3d2:	bfe5                	j	3ca <strlen+0x20>

00000000000003d4 <memset>:

void *
memset(void *dst, int c, uint n)
{
 3d4:	1141                	addi	sp,sp,-16
 3d6:	e422                	sd	s0,8(sp)
 3d8:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++) {
 3da:	ca19                	beqz	a2,3f0 <memset+0x1c>
 3dc:	87aa                	mv	a5,a0
 3de:	1602                	slli	a2,a2,0x20
 3e0:	9201                	srli	a2,a2,0x20
 3e2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3e6:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++) {
 3ea:	0785                	addi	a5,a5,1
 3ec:	fee79de3          	bne	a5,a4,3e6 <memset+0x12>
  }
  return dst;
}
 3f0:	6422                	ld	s0,8(sp)
 3f2:	0141                	addi	sp,sp,16
 3f4:	8082                	ret

00000000000003f6 <strchr>:

char *
strchr(const char *s, char c)
{
 3f6:	1141                	addi	sp,sp,-16
 3f8:	e422                	sd	s0,8(sp)
 3fa:	0800                	addi	s0,sp,16
  for (; *s; s++)
 3fc:	00054783          	lbu	a5,0(a0)
 400:	cb99                	beqz	a5,416 <strchr+0x20>
    if (*s == c)
 402:	00f58763          	beq	a1,a5,410 <strchr+0x1a>
  for (; *s; s++)
 406:	0505                	addi	a0,a0,1
 408:	00054783          	lbu	a5,0(a0)
 40c:	fbfd                	bnez	a5,402 <strchr+0xc>
      return (char *)s;
  return 0;
 40e:	4501                	li	a0,0
}
 410:	6422                	ld	s0,8(sp)
 412:	0141                	addi	sp,sp,16
 414:	8082                	ret
  return 0;
 416:	4501                	li	a0,0
 418:	bfe5                	j	410 <strchr+0x1a>

000000000000041a <gets>:

char *
gets(char *buf, int max)
{
 41a:	711d                	addi	sp,sp,-96
 41c:	ec86                	sd	ra,88(sp)
 41e:	e8a2                	sd	s0,80(sp)
 420:	e4a6                	sd	s1,72(sp)
 422:	e0ca                	sd	s2,64(sp)
 424:	fc4e                	sd	s3,56(sp)
 426:	f852                	sd	s4,48(sp)
 428:	f456                	sd	s5,40(sp)
 42a:	f05a                	sd	s6,32(sp)
 42c:	ec5e                	sd	s7,24(sp)
 42e:	1080                	addi	s0,sp,96
 430:	8baa                	mv	s7,a0
 432:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;) {
 434:	892a                	mv	s2,a0
 436:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 438:	4aa9                	li	s5,10
 43a:	4b35                	li	s6,13
  for (i = 0; i + 1 < max;) {
 43c:	89a6                	mv	s3,s1
 43e:	2485                	addiw	s1,s1,1
 440:	0344d663          	bge	s1,s4,46c <gets+0x52>
    cc = read(0, &c, 1);
 444:	4605                	li	a2,1
 446:	faf40593          	addi	a1,s0,-81
 44a:	4501                	li	a0,0
 44c:	1b2000ef          	jal	5fe <read>
    if (cc < 1)
 450:	00a05e63          	blez	a0,46c <gets+0x52>
    buf[i++] = c;
 454:	faf44783          	lbu	a5,-81(s0)
 458:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 45c:	01578763          	beq	a5,s5,46a <gets+0x50>
 460:	0905                	addi	s2,s2,1
 462:	fd679de3          	bne	a5,s6,43c <gets+0x22>
    buf[i++] = c;
 466:	89a6                	mv	s3,s1
 468:	a011                	j	46c <gets+0x52>
 46a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 46c:	99de                	add	s3,s3,s7
 46e:	00098023          	sb	zero,0(s3)
  return buf;
}
 472:	855e                	mv	a0,s7
 474:	60e6                	ld	ra,88(sp)
 476:	6446                	ld	s0,80(sp)
 478:	64a6                	ld	s1,72(sp)
 47a:	6906                	ld	s2,64(sp)
 47c:	79e2                	ld	s3,56(sp)
 47e:	7a42                	ld	s4,48(sp)
 480:	7aa2                	ld	s5,40(sp)
 482:	7b02                	ld	s6,32(sp)
 484:	6be2                	ld	s7,24(sp)
 486:	6125                	addi	sp,sp,96
 488:	8082                	ret

000000000000048a <stat>:

int
stat(const char *n, struct stat *st)
{
 48a:	1101                	addi	sp,sp,-32
 48c:	ec06                	sd	ra,24(sp)
 48e:	e822                	sd	s0,16(sp)
 490:	e04a                	sd	s2,0(sp)
 492:	1000                	addi	s0,sp,32
 494:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 496:	4581                	li	a1,0
 498:	18e000ef          	jal	626 <open>
  if (fd < 0)
 49c:	02054263          	bltz	a0,4c0 <stat+0x36>
 4a0:	e426                	sd	s1,8(sp)
 4a2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4a4:	85ca                	mv	a1,s2
 4a6:	198000ef          	jal	63e <fstat>
 4aa:	892a                	mv	s2,a0
  close(fd);
 4ac:	8526                	mv	a0,s1
 4ae:	160000ef          	jal	60e <close>
  return r;
 4b2:	64a2                	ld	s1,8(sp)
}
 4b4:	854a                	mv	a0,s2
 4b6:	60e2                	ld	ra,24(sp)
 4b8:	6442                	ld	s0,16(sp)
 4ba:	6902                	ld	s2,0(sp)
 4bc:	6105                	addi	sp,sp,32
 4be:	8082                	ret
    return -1;
 4c0:	597d                	li	s2,-1
 4c2:	bfcd                	j	4b4 <stat+0x2a>

00000000000004c4 <atoi>:

int
atoi(const char *s)
{
 4c4:	1141                	addi	sp,sp,-16
 4c6:	e422                	sd	s0,8(sp)
 4c8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 4ca:	00054683          	lbu	a3,0(a0)
 4ce:	fd06879b          	addiw	a5,a3,-48
 4d2:	0ff7f793          	zext.b	a5,a5
 4d6:	4625                	li	a2,9
 4d8:	02f66863          	bltu	a2,a5,508 <atoi+0x44>
 4dc:	872a                	mv	a4,a0
  n = 0;
 4de:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 4e0:	0705                	addi	a4,a4,1
 4e2:	0025179b          	slliw	a5,a0,0x2
 4e6:	9fa9                	addw	a5,a5,a0
 4e8:	0017979b          	slliw	a5,a5,0x1
 4ec:	9fb5                	addw	a5,a5,a3
 4ee:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 4f2:	00074683          	lbu	a3,0(a4)
 4f6:	fd06879b          	addiw	a5,a3,-48
 4fa:	0ff7f793          	zext.b	a5,a5
 4fe:	fef671e3          	bgeu	a2,a5,4e0 <atoi+0x1c>
  return n;
}
 502:	6422                	ld	s0,8(sp)
 504:	0141                	addi	sp,sp,16
 506:	8082                	ret
  n = 0;
 508:	4501                	li	a0,0
 50a:	bfe5                	j	502 <atoi+0x3e>

000000000000050c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 50c:	1141                	addi	sp,sp,-16
 50e:	e422                	sd	s0,8(sp)
 510:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 512:	02b57463          	bgeu	a0,a1,53a <memmove+0x2e>
    while (n-- > 0)
 516:	00c05f63          	blez	a2,534 <memmove+0x28>
 51a:	1602                	slli	a2,a2,0x20
 51c:	9201                	srli	a2,a2,0x20
 51e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 522:	872a                	mv	a4,a0
      *dst++ = *src++;
 524:	0585                	addi	a1,a1,1
 526:	0705                	addi	a4,a4,1
 528:	fff5c683          	lbu	a3,-1(a1)
 52c:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 530:	fef71ae3          	bne	a4,a5,524 <memmove+0x18>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 534:	6422                	ld	s0,8(sp)
 536:	0141                	addi	sp,sp,16
 538:	8082                	ret
    dst += n;
 53a:	00c50733          	add	a4,a0,a2
    src += n;
 53e:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 540:	fec05ae3          	blez	a2,534 <memmove+0x28>
 544:	fff6079b          	addiw	a5,a2,-1
 548:	1782                	slli	a5,a5,0x20
 54a:	9381                	srli	a5,a5,0x20
 54c:	fff7c793          	not	a5,a5
 550:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 552:	15fd                	addi	a1,a1,-1
 554:	177d                	addi	a4,a4,-1
 556:	0005c683          	lbu	a3,0(a1)
 55a:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 55e:	fee79ae3          	bne	a5,a4,552 <memmove+0x46>
 562:	bfc9                	j	534 <memmove+0x28>

0000000000000564 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 564:	1141                	addi	sp,sp,-16
 566:	e422                	sd	s0,8(sp)
 568:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 56a:	ca05                	beqz	a2,59a <memcmp+0x36>
 56c:	fff6069b          	addiw	a3,a2,-1
 570:	1682                	slli	a3,a3,0x20
 572:	9281                	srli	a3,a3,0x20
 574:	0685                	addi	a3,a3,1
 576:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 578:	00054783          	lbu	a5,0(a0)
 57c:	0005c703          	lbu	a4,0(a1)
 580:	00e79863          	bne	a5,a4,590 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 584:	0505                	addi	a0,a0,1
    p2++;
 586:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 588:	fed518e3          	bne	a0,a3,578 <memcmp+0x14>
  }
  return 0;
 58c:	4501                	li	a0,0
 58e:	a019                	j	594 <memcmp+0x30>
      return *p1 - *p2;
 590:	40e7853b          	subw	a0,a5,a4
}
 594:	6422                	ld	s0,8(sp)
 596:	0141                	addi	sp,sp,16
 598:	8082                	ret
  return 0;
 59a:	4501                	li	a0,0
 59c:	bfe5                	j	594 <memcmp+0x30>

000000000000059e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 59e:	1141                	addi	sp,sp,-16
 5a0:	e406                	sd	ra,8(sp)
 5a2:	e022                	sd	s0,0(sp)
 5a4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5a6:	f67ff0ef          	jal	50c <memmove>
}
 5aa:	60a2                	ld	ra,8(sp)
 5ac:	6402                	ld	s0,0(sp)
 5ae:	0141                	addi	sp,sp,16
 5b0:	8082                	ret

00000000000005b2 <sbrk>:

char *
sbrk(int n)
{
 5b2:	1141                	addi	sp,sp,-16
 5b4:	e406                	sd	ra,8(sp)
 5b6:	e022                	sd	s0,0(sp)
 5b8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 5ba:	4585                	li	a1,1
 5bc:	0b2000ef          	jal	66e <sys_sbrk>
}
 5c0:	60a2                	ld	ra,8(sp)
 5c2:	6402                	ld	s0,0(sp)
 5c4:	0141                	addi	sp,sp,16
 5c6:	8082                	ret

00000000000005c8 <sbrklazy>:

char *
sbrklazy(int n)
{
 5c8:	1141                	addi	sp,sp,-16
 5ca:	e406                	sd	ra,8(sp)
 5cc:	e022                	sd	s0,0(sp)
 5ce:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 5d0:	4589                	li	a1,2
 5d2:	09c000ef          	jal	66e <sys_sbrk>
}
 5d6:	60a2                	ld	ra,8(sp)
 5d8:	6402                	ld	s0,0(sp)
 5da:	0141                	addi	sp,sp,16
 5dc:	8082                	ret

00000000000005de <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5de:	4885                	li	a7,1
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5e6:	4889                	li	a7,2
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ee:	488d                	li	a7,3
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5f6:	4891                	li	a7,4
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <read>:
.global read
read:
 li a7, SYS_read
 5fe:	4895                	li	a7,5
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <write>:
.global write
write:
 li a7, SYS_write
 606:	48c1                	li	a7,16
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <close>:
.global close
close:
 li a7, SYS_close
 60e:	48d5                	li	a7,21
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <kill>:
.global kill
kill:
 li a7, SYS_kill
 616:	4899                	li	a7,6
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <exec>:
.global exec
exec:
 li a7, SYS_exec
 61e:	489d                	li	a7,7
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <open>:
.global open
open:
 li a7, SYS_open
 626:	48bd                	li	a7,15
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 62e:	48c5                	li	a7,17
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 636:	48c9                	li	a7,18
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 63e:	48a1                	li	a7,8
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <link>:
.global link
link:
 li a7, SYS_link
 646:	48cd                	li	a7,19
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 64e:	48d1                	li	a7,20
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 656:	48a5                	li	a7,9
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <dup>:
.global dup
dup:
 li a7, SYS_dup
 65e:	48a9                	li	a7,10
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 666:	48ad                	li	a7,11
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 66e:	48b1                	li	a7,12
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <pause>:
.global pause
pause:
 li a7, SYS_pause
 676:	48b5                	li	a7,13
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 67e:	48b9                	li	a7,14
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <sync>:
.global sync
sync:
 li a7, SYS_sync
 686:	48d9                	li	a7,22
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 68e:	1101                	addi	sp,sp,-32
 690:	ec06                	sd	ra,24(sp)
 692:	e822                	sd	s0,16(sp)
 694:	1000                	addi	s0,sp,32
 696:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 69a:	4605                	li	a2,1
 69c:	fef40593          	addi	a1,s0,-17
 6a0:	f67ff0ef          	jal	606 <write>
}
 6a4:	60e2                	ld	ra,24(sp)
 6a6:	6442                	ld	s0,16(sp)
 6a8:	6105                	addi	sp,sp,32
 6aa:	8082                	ret

00000000000006ac <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 6ac:	715d                	addi	sp,sp,-80
 6ae:	e486                	sd	ra,72(sp)
 6b0:	e0a2                	sd	s0,64(sp)
 6b2:	f84a                	sd	s2,48(sp)
 6b4:	0880                	addi	s0,sp,80
 6b6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 6b8:	c299                	beqz	a3,6be <printint+0x12>
 6ba:	0805c363          	bltz	a1,740 <printint+0x94>
  neg = 0;
 6be:	4881                	li	a7,0
 6c0:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 6c4:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
 6c6:	00000517          	auipc	a0,0x0
 6ca:	66250513          	addi	a0,a0,1634 # d28 <digits>
 6ce:	883e                	mv	a6,a5
 6d0:	2785                	addiw	a5,a5,1
 6d2:	02c5f733          	remu	a4,a1,a2
 6d6:	972a                	add	a4,a4,a0
 6d8:	00074703          	lbu	a4,0(a4)
 6dc:	00e68023          	sb	a4,0(a3)
  } while ((x /= base) != 0);
 6e0:	872e                	mv	a4,a1
 6e2:	02c5d5b3          	divu	a1,a1,a2
 6e6:	0685                	addi	a3,a3,1
 6e8:	fec773e3          	bgeu	a4,a2,6ce <printint+0x22>
  if (neg)
 6ec:	00088b63          	beqz	a7,702 <printint+0x56>
    buf[i++] = '-';
 6f0:	fd078793          	addi	a5,a5,-48
 6f4:	97a2                	add	a5,a5,s0
 6f6:	02d00713          	li	a4,45
 6fa:	fee78423          	sb	a4,-24(a5)
 6fe:	0028079b          	addiw	a5,a6,2

  while (--i >= 0)
 702:	02f05a63          	blez	a5,736 <printint+0x8a>
 706:	fc26                	sd	s1,56(sp)
 708:	f44e                	sd	s3,40(sp)
 70a:	fb840713          	addi	a4,s0,-72
 70e:	00f704b3          	add	s1,a4,a5
 712:	fff70993          	addi	s3,a4,-1
 716:	99be                	add	s3,s3,a5
 718:	37fd                	addiw	a5,a5,-1
 71a:	1782                	slli	a5,a5,0x20
 71c:	9381                	srli	a5,a5,0x20
 71e:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 722:	fff4c583          	lbu	a1,-1(s1)
 726:	854a                	mv	a0,s2
 728:	f67ff0ef          	jal	68e <putc>
  while (--i >= 0)
 72c:	14fd                	addi	s1,s1,-1
 72e:	ff349ae3          	bne	s1,s3,722 <printint+0x76>
 732:	74e2                	ld	s1,56(sp)
 734:	79a2                	ld	s3,40(sp)
}
 736:	60a6                	ld	ra,72(sp)
 738:	6406                	ld	s0,64(sp)
 73a:	7942                	ld	s2,48(sp)
 73c:	6161                	addi	sp,sp,80
 73e:	8082                	ret
    x = -xx;
 740:	40b005b3          	neg	a1,a1
    neg = 1;
 744:	4885                	li	a7,1
    x = -xx;
 746:	bfad                	j	6c0 <printint+0x14>

0000000000000748 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 748:	711d                	addi	sp,sp,-96
 74a:	ec86                	sd	ra,88(sp)
 74c:	e8a2                	sd	s0,80(sp)
 74e:	e0ca                	sd	s2,64(sp)
 750:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 752:	0005c903          	lbu	s2,0(a1)
 756:	28090663          	beqz	s2,9e2 <vprintf+0x29a>
 75a:	e4a6                	sd	s1,72(sp)
 75c:	fc4e                	sd	s3,56(sp)
 75e:	f852                	sd	s4,48(sp)
 760:	f456                	sd	s5,40(sp)
 762:	f05a                	sd	s6,32(sp)
 764:	ec5e                	sd	s7,24(sp)
 766:	e862                	sd	s8,16(sp)
 768:	e466                	sd	s9,8(sp)
 76a:	8b2a                	mv	s6,a0
 76c:	8a2e                	mv	s4,a1
 76e:	8bb2                	mv	s7,a2
  state = 0;
 770:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 772:	4481                	li	s1,0
 774:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 776:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 77a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 77e:	06c00c93          	li	s9,108
 782:	a005                	j	7a2 <vprintf+0x5a>
        putc(fd, c0);
 784:	85ca                	mv	a1,s2
 786:	855a                	mv	a0,s6
 788:	f07ff0ef          	jal	68e <putc>
 78c:	a019                	j	792 <vprintf+0x4a>
    } else if (state == '%') {
 78e:	03598263          	beq	s3,s5,7b2 <vprintf+0x6a>
  for (i = 0; fmt[i]; i++) {
 792:	2485                	addiw	s1,s1,1
 794:	8726                	mv	a4,s1
 796:	009a07b3          	add	a5,s4,s1
 79a:	0007c903          	lbu	s2,0(a5)
 79e:	22090a63          	beqz	s2,9d2 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 7a2:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 7a6:	fe0994e3          	bnez	s3,78e <vprintf+0x46>
      if (c0 == '%') {
 7aa:	fd579de3          	bne	a5,s5,784 <vprintf+0x3c>
        state = '%';
 7ae:	89be                	mv	s3,a5
 7b0:	b7cd                	j	792 <vprintf+0x4a>
        c1 = fmt[i + 1] & 0xff;
 7b2:	00ea06b3          	add	a3,s4,a4
 7b6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 7ba:	8636                	mv	a2,a3
      if (c1)
 7bc:	c681                	beqz	a3,7c4 <vprintf+0x7c>
        c2 = fmt[i + 2] & 0xff;
 7be:	9752                	add	a4,a4,s4
 7c0:	00274603          	lbu	a2,2(a4)
      if (c0 == 'd') {
 7c4:	05878363          	beq	a5,s8,80a <vprintf+0xc2>
      } else if (c0 == 'l' && c1 == 'd') {
 7c8:	05978d63          	beq	a5,s9,822 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 7cc:	07500713          	li	a4,117
 7d0:	0ee78763          	beq	a5,a4,8be <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 7d4:	07800713          	li	a4,120
 7d8:	12e78963          	beq	a5,a4,90a <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 7dc:	07000713          	li	a4,112
 7e0:	14e78e63          	beq	a5,a4,93c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 7e4:	06300713          	li	a4,99
 7e8:	18e78e63          	beq	a5,a4,984 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 7ec:	07300713          	li	a4,115
 7f0:	1ae78463          	beq	a5,a4,998 <vprintf+0x250>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 7f4:	02500713          	li	a4,37
 7f8:	04e79563          	bne	a5,a4,842 <vprintf+0xfa>
        putc(fd, '%');
 7fc:	02500593          	li	a1,37
 800:	855a                	mv	a0,s6
 802:	e8dff0ef          	jal	68e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 806:	4981                	li	s3,0
 808:	b769                	j	792 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 80a:	008b8913          	addi	s2,s7,8
 80e:	4685                	li	a3,1
 810:	4629                	li	a2,10
 812:	000ba583          	lw	a1,0(s7)
 816:	855a                	mv	a0,s6
 818:	e95ff0ef          	jal	6ac <printint>
 81c:	8bca                	mv	s7,s2
      state = 0;
 81e:	4981                	li	s3,0
 820:	bf8d                	j	792 <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'd') {
 822:	06400793          	li	a5,100
 826:	02f68963          	beq	a3,a5,858 <vprintf+0x110>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 82a:	06c00793          	li	a5,108
 82e:	04f68263          	beq	a3,a5,872 <vprintf+0x12a>
      } else if (c0 == 'l' && c1 == 'u') {
 832:	07500793          	li	a5,117
 836:	0af68063          	beq	a3,a5,8d6 <vprintf+0x18e>
      } else if (c0 == 'l' && c1 == 'x') {
 83a:	07800793          	li	a5,120
 83e:	0ef68263          	beq	a3,a5,922 <vprintf+0x1da>
        putc(fd, '%');
 842:	02500593          	li	a1,37
 846:	855a                	mv	a0,s6
 848:	e47ff0ef          	jal	68e <putc>
        putc(fd, c0);
 84c:	85ca                	mv	a1,s2
 84e:	855a                	mv	a0,s6
 850:	e3fff0ef          	jal	68e <putc>
      state = 0;
 854:	4981                	li	s3,0
 856:	bf35                	j	792 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 858:	008b8913          	addi	s2,s7,8
 85c:	4685                	li	a3,1
 85e:	4629                	li	a2,10
 860:	000bb583          	ld	a1,0(s7)
 864:	855a                	mv	a0,s6
 866:	e47ff0ef          	jal	6ac <printint>
        i += 1;
 86a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 86c:	8bca                	mv	s7,s2
      state = 0;
 86e:	4981                	li	s3,0
        i += 1;
 870:	b70d                	j	792 <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 872:	06400793          	li	a5,100
 876:	02f60763          	beq	a2,a5,8a4 <vprintf+0x15c>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 87a:	07500793          	li	a5,117
 87e:	06f60963          	beq	a2,a5,8f0 <vprintf+0x1a8>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 882:	07800793          	li	a5,120
 886:	faf61ee3          	bne	a2,a5,842 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 88a:	008b8913          	addi	s2,s7,8
 88e:	4681                	li	a3,0
 890:	4641                	li	a2,16
 892:	000bb583          	ld	a1,0(s7)
 896:	855a                	mv	a0,s6
 898:	e15ff0ef          	jal	6ac <printint>
        i += 2;
 89c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 89e:	8bca                	mv	s7,s2
      state = 0;
 8a0:	4981                	li	s3,0
        i += 2;
 8a2:	bdc5                	j	792 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8a4:	008b8913          	addi	s2,s7,8
 8a8:	4685                	li	a3,1
 8aa:	4629                	li	a2,10
 8ac:	000bb583          	ld	a1,0(s7)
 8b0:	855a                	mv	a0,s6
 8b2:	dfbff0ef          	jal	6ac <printint>
        i += 2;
 8b6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 8b8:	8bca                	mv	s7,s2
      state = 0;
 8ba:	4981                	li	s3,0
        i += 2;
 8bc:	bdd9                	j	792 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 8be:	008b8913          	addi	s2,s7,8
 8c2:	4681                	li	a3,0
 8c4:	4629                	li	a2,10
 8c6:	000be583          	lwu	a1,0(s7)
 8ca:	855a                	mv	a0,s6
 8cc:	de1ff0ef          	jal	6ac <printint>
 8d0:	8bca                	mv	s7,s2
      state = 0;
 8d2:	4981                	li	s3,0
 8d4:	bd7d                	j	792 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d6:	008b8913          	addi	s2,s7,8
 8da:	4681                	li	a3,0
 8dc:	4629                	li	a2,10
 8de:	000bb583          	ld	a1,0(s7)
 8e2:	855a                	mv	a0,s6
 8e4:	dc9ff0ef          	jal	6ac <printint>
        i += 1;
 8e8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ea:	8bca                	mv	s7,s2
      state = 0;
 8ec:	4981                	li	s3,0
        i += 1;
 8ee:	b555                	j	792 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8f0:	008b8913          	addi	s2,s7,8
 8f4:	4681                	li	a3,0
 8f6:	4629                	li	a2,10
 8f8:	000bb583          	ld	a1,0(s7)
 8fc:	855a                	mv	a0,s6
 8fe:	dafff0ef          	jal	6ac <printint>
        i += 2;
 902:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 904:	8bca                	mv	s7,s2
      state = 0;
 906:	4981                	li	s3,0
        i += 2;
 908:	b569                	j	792 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 90a:	008b8913          	addi	s2,s7,8
 90e:	4681                	li	a3,0
 910:	4641                	li	a2,16
 912:	000be583          	lwu	a1,0(s7)
 916:	855a                	mv	a0,s6
 918:	d95ff0ef          	jal	6ac <printint>
 91c:	8bca                	mv	s7,s2
      state = 0;
 91e:	4981                	li	s3,0
 920:	bd8d                	j	792 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 922:	008b8913          	addi	s2,s7,8
 926:	4681                	li	a3,0
 928:	4641                	li	a2,16
 92a:	000bb583          	ld	a1,0(s7)
 92e:	855a                	mv	a0,s6
 930:	d7dff0ef          	jal	6ac <printint>
        i += 1;
 934:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 936:	8bca                	mv	s7,s2
      state = 0;
 938:	4981                	li	s3,0
        i += 1;
 93a:	bda1                	j	792 <vprintf+0x4a>
 93c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 93e:	008b8d13          	addi	s10,s7,8
 942:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 946:	03000593          	li	a1,48
 94a:	855a                	mv	a0,s6
 94c:	d43ff0ef          	jal	68e <putc>
  putc(fd, 'x');
 950:	07800593          	li	a1,120
 954:	855a                	mv	a0,s6
 956:	d39ff0ef          	jal	68e <putc>
 95a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 95c:	00000b97          	auipc	s7,0x0
 960:	3ccb8b93          	addi	s7,s7,972 # d28 <digits>
 964:	03c9d793          	srli	a5,s3,0x3c
 968:	97de                	add	a5,a5,s7
 96a:	0007c583          	lbu	a1,0(a5)
 96e:	855a                	mv	a0,s6
 970:	d1fff0ef          	jal	68e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 974:	0992                	slli	s3,s3,0x4
 976:	397d                	addiw	s2,s2,-1
 978:	fe0916e3          	bnez	s2,964 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 97c:	8bea                	mv	s7,s10
      state = 0;
 97e:	4981                	li	s3,0
 980:	6d02                	ld	s10,0(sp)
 982:	bd01                	j	792 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 984:	008b8913          	addi	s2,s7,8
 988:	000bc583          	lbu	a1,0(s7)
 98c:	855a                	mv	a0,s6
 98e:	d01ff0ef          	jal	68e <putc>
 992:	8bca                	mv	s7,s2
      state = 0;
 994:	4981                	li	s3,0
 996:	bbf5                	j	792 <vprintf+0x4a>
        if ((s = va_arg(ap, char *)) == 0)
 998:	008b8993          	addi	s3,s7,8
 99c:	000bb903          	ld	s2,0(s7)
 9a0:	00090f63          	beqz	s2,9be <vprintf+0x276>
        for (; *s; s++)
 9a4:	00094583          	lbu	a1,0(s2)
 9a8:	c195                	beqz	a1,9cc <vprintf+0x284>
          putc(fd, *s);
 9aa:	855a                	mv	a0,s6
 9ac:	ce3ff0ef          	jal	68e <putc>
        for (; *s; s++)
 9b0:	0905                	addi	s2,s2,1
 9b2:	00094583          	lbu	a1,0(s2)
 9b6:	f9f5                	bnez	a1,9aa <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 9b8:	8bce                	mv	s7,s3
      state = 0;
 9ba:	4981                	li	s3,0
 9bc:	bbd9                	j	792 <vprintf+0x4a>
          s = "(null)";
 9be:	00000917          	auipc	s2,0x0
 9c2:	36290913          	addi	s2,s2,866 # d20 <switch_context+0x15c>
        for (; *s; s++)
 9c6:	02800593          	li	a1,40
 9ca:	b7c5                	j	9aa <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 9cc:	8bce                	mv	s7,s3
      state = 0;
 9ce:	4981                	li	s3,0
 9d0:	b3c9                	j	792 <vprintf+0x4a>
 9d2:	64a6                	ld	s1,72(sp)
 9d4:	79e2                	ld	s3,56(sp)
 9d6:	7a42                	ld	s4,48(sp)
 9d8:	7aa2                	ld	s5,40(sp)
 9da:	7b02                	ld	s6,32(sp)
 9dc:	6be2                	ld	s7,24(sp)
 9de:	6c42                	ld	s8,16(sp)
 9e0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 9e2:	60e6                	ld	ra,88(sp)
 9e4:	6446                	ld	s0,80(sp)
 9e6:	6906                	ld	s2,64(sp)
 9e8:	6125                	addi	sp,sp,96
 9ea:	8082                	ret

00000000000009ec <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9ec:	715d                	addi	sp,sp,-80
 9ee:	ec06                	sd	ra,24(sp)
 9f0:	e822                	sd	s0,16(sp)
 9f2:	1000                	addi	s0,sp,32
 9f4:	e010                	sd	a2,0(s0)
 9f6:	e414                	sd	a3,8(s0)
 9f8:	e818                	sd	a4,16(s0)
 9fa:	ec1c                	sd	a5,24(s0)
 9fc:	03043023          	sd	a6,32(s0)
 a00:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a04:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a08:	8622                	mv	a2,s0
 a0a:	d3fff0ef          	jal	748 <vprintf>
}
 a0e:	60e2                	ld	ra,24(sp)
 a10:	6442                	ld	s0,16(sp)
 a12:	6161                	addi	sp,sp,80
 a14:	8082                	ret

0000000000000a16 <printf>:

void
printf(const char *fmt, ...)
{
 a16:	711d                	addi	sp,sp,-96
 a18:	ec06                	sd	ra,24(sp)
 a1a:	e822                	sd	s0,16(sp)
 a1c:	1000                	addi	s0,sp,32
 a1e:	e40c                	sd	a1,8(s0)
 a20:	e810                	sd	a2,16(s0)
 a22:	ec14                	sd	a3,24(s0)
 a24:	f018                	sd	a4,32(s0)
 a26:	f41c                	sd	a5,40(s0)
 a28:	03043823          	sd	a6,48(s0)
 a2c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a30:	00840613          	addi	a2,s0,8
 a34:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a38:	85aa                	mv	a1,a0
 a3a:	4505                	li	a0,1
 a3c:	d0dff0ef          	jal	748 <vprintf>
}
 a40:	60e2                	ld	ra,24(sp)
 a42:	6442                	ld	s0,16(sp)
 a44:	6125                	addi	sp,sp,96
 a46:	8082                	ret

0000000000000a48 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a48:	1141                	addi	sp,sp,-16
 a4a:	e422                	sd	s0,8(sp)
 a4c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 a4e:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a52:	00001797          	auipc	a5,0x1
 a56:	5c67b783          	ld	a5,1478(a5) # 2018 <freep>
 a5a:	a02d                	j	a84 <free+0x3c>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if (bp + bp->s.size == p->s.ptr) {
    bp->s.size += p->s.ptr->s.size;
 a5c:	4618                	lw	a4,8(a2)
 a5e:	9f2d                	addw	a4,a4,a1
 a60:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a64:	6398                	ld	a4,0(a5)
 a66:	6310                	ld	a2,0(a4)
 a68:	a83d                	j	aa6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp) {
    p->s.size += bp->s.size;
 a6a:	ff852703          	lw	a4,-8(a0)
 a6e:	9f31                	addw	a4,a4,a2
 a70:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a72:	ff053683          	ld	a3,-16(a0)
 a76:	a091                	j	aba <free+0x72>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a78:	6398                	ld	a4,0(a5)
 a7a:	00e7e463          	bltu	a5,a4,a82 <free+0x3a>
 a7e:	00e6ea63          	bltu	a3,a4,a92 <free+0x4a>
{
 a82:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a84:	fed7fae3          	bgeu	a5,a3,a78 <free+0x30>
 a88:	6398                	ld	a4,0(a5)
 a8a:	00e6e463          	bltu	a3,a4,a92 <free+0x4a>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a8e:	fee7eae3          	bltu	a5,a4,a82 <free+0x3a>
  if (bp + bp->s.size == p->s.ptr) {
 a92:	ff852583          	lw	a1,-8(a0)
 a96:	6390                	ld	a2,0(a5)
 a98:	02059813          	slli	a6,a1,0x20
 a9c:	01c85713          	srli	a4,a6,0x1c
 aa0:	9736                	add	a4,a4,a3
 aa2:	fae60de3          	beq	a2,a4,a5c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 aa6:	fec53823          	sd	a2,-16(a0)
  if (p + p->s.size == bp) {
 aaa:	4790                	lw	a2,8(a5)
 aac:	02061593          	slli	a1,a2,0x20
 ab0:	01c5d713          	srli	a4,a1,0x1c
 ab4:	973e                	add	a4,a4,a5
 ab6:	fae68ae3          	beq	a3,a4,a6a <free+0x22>
    p->s.ptr = bp->s.ptr;
 aba:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 abc:	00001717          	auipc	a4,0x1
 ac0:	54f73e23          	sd	a5,1372(a4) # 2018 <freep>
}
 ac4:	6422                	ld	s0,8(sp)
 ac6:	0141                	addi	sp,sp,16
 ac8:	8082                	ret

0000000000000aca <malloc>:
  return freep;
}

void *
malloc(uint nbytes)
{
 aca:	7139                	addi	sp,sp,-64
 acc:	fc06                	sd	ra,56(sp)
 ace:	f822                	sd	s0,48(sp)
 ad0:	f426                	sd	s1,40(sp)
 ad2:	ec4e                	sd	s3,24(sp)
 ad4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 ad6:	02051493          	slli	s1,a0,0x20
 ada:	9081                	srli	s1,s1,0x20
 adc:	04bd                	addi	s1,s1,15
 ade:	8091                	srli	s1,s1,0x4
 ae0:	0014899b          	addiw	s3,s1,1
 ae4:	0485                	addi	s1,s1,1
  if ((prevp = freep) == 0) {
 ae6:	00001517          	auipc	a0,0x1
 aea:	53253503          	ld	a0,1330(a0) # 2018 <freep>
 aee:	c915                	beqz	a0,b22 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 af0:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 af2:	4798                	lw	a4,8(a5)
 af4:	08977a63          	bgeu	a4,s1,b88 <malloc+0xbe>
 af8:	f04a                	sd	s2,32(sp)
 afa:	e852                	sd	s4,16(sp)
 afc:	e456                	sd	s5,8(sp)
 afe:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 b00:	8a4e                	mv	s4,s3
 b02:	0009871b          	sext.w	a4,s3
 b06:	6685                	lui	a3,0x1
 b08:	00d77363          	bgeu	a4,a3,b0e <malloc+0x44>
 b0c:	6a05                	lui	s4,0x1
 b0e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b12:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void *)(p + 1);
    }
    if (p == freep)
 b16:	00001917          	auipc	s2,0x1
 b1a:	50290913          	addi	s2,s2,1282 # 2018 <freep>
  if (p == SBRK_ERROR)
 b1e:	5afd                	li	s5,-1
 b20:	a081                	j	b60 <malloc+0x96>
 b22:	f04a                	sd	s2,32(sp)
 b24:	e852                	sd	s4,16(sp)
 b26:	e456                	sd	s5,8(sp)
 b28:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b2a:	00016797          	auipc	a5,0x16
 b2e:	e5678793          	addi	a5,a5,-426 # 16980 <base>
 b32:	00001717          	auipc	a4,0x1
 b36:	4ef73323          	sd	a5,1254(a4) # 2018 <freep>
 b3a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b3c:	0007a423          	sw	zero,8(a5)
    if (p->s.size >= nunits) {
 b40:	b7c1                	j	b00 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b42:	6398                	ld	a4,0(a5)
 b44:	e118                	sd	a4,0(a0)
 b46:	a8a9                	j	ba0 <malloc+0xd6>
  hp->s.size = nu;
 b48:	01652423          	sw	s6,8(a0)
  free((void *)(hp + 1));
 b4c:	0541                	addi	a0,a0,16
 b4e:	efbff0ef          	jal	a48 <free>
  return freep;
 b52:	00093503          	ld	a0,0(s2)
      if ((p = morecore(nunits)) == 0)
 b56:	c12d                	beqz	a0,bb8 <malloc+0xee>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 b58:	611c                	ld	a5,0(a0)
    if (p->s.size >= nunits) {
 b5a:	4798                	lw	a4,8(a5)
 b5c:	02977263          	bgeu	a4,s1,b80 <malloc+0xb6>
    if (p == freep)
 b60:	00093703          	ld	a4,0(s2)
 b64:	853e                	mv	a0,a5
 b66:	fef719e3          	bne	a4,a5,b58 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b6a:	8552                	mv	a0,s4
 b6c:	a47ff0ef          	jal	5b2 <sbrk>
  if (p == SBRK_ERROR)
 b70:	fd551ce3          	bne	a0,s5,b48 <malloc+0x7e>
        return 0;
 b74:	4501                	li	a0,0
 b76:	7902                	ld	s2,32(sp)
 b78:	6a42                	ld	s4,16(sp)
 b7a:	6aa2                	ld	s5,8(sp)
 b7c:	6b02                	ld	s6,0(sp)
 b7e:	a03d                	j	bac <malloc+0xe2>
 b80:	7902                	ld	s2,32(sp)
 b82:	6a42                	ld	s4,16(sp)
 b84:	6aa2                	ld	s5,8(sp)
 b86:	6b02                	ld	s6,0(sp)
      if (p->s.size == nunits)
 b88:	fae48de3          	beq	s1,a4,b42 <malloc+0x78>
        p->s.size -= nunits;
 b8c:	4137073b          	subw	a4,a4,s3
 b90:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b92:	02071693          	slli	a3,a4,0x20
 b96:	01c6d713          	srli	a4,a3,0x1c
 b9a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b9c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ba0:	00001717          	auipc	a4,0x1
 ba4:	46a73c23          	sd	a0,1144(a4) # 2018 <freep>
      return (void *)(p + 1);
 ba8:	01078513          	addi	a0,a5,16
  }
}
 bac:	70e2                	ld	ra,56(sp)
 bae:	7442                	ld	s0,48(sp)
 bb0:	74a2                	ld	s1,40(sp)
 bb2:	69e2                	ld	s3,24(sp)
 bb4:	6121                	addi	sp,sp,64
 bb6:	8082                	ret
 bb8:	7902                	ld	s2,32(sp)
 bba:	6a42                	ld	s4,16(sp)
 bbc:	6aa2                	ld	s5,8(sp)
 bbe:	6b02                	ld	s6,0(sp)
 bc0:	b7f5                	j	bac <malloc+0xe2>
	...

0000000000000bc4 <switch_context>:
 bc4:	e100                	sd	s0,0(a0)
 bc6:	e504                	sd	s1,8(a0)
 bc8:	01253823          	sd	s2,16(a0)
 bcc:	01353c23          	sd	s3,24(a0)
 bd0:	03453023          	sd	s4,32(a0)
 bd4:	03553423          	sd	s5,40(a0)
 bd8:	03653823          	sd	s6,48(a0)
 bdc:	03753c23          	sd	s7,56(a0)
 be0:	05853023          	sd	s8,64(a0)
 be4:	05953423          	sd	s9,72(a0)
 be8:	05a53823          	sd	s10,80(a0)
 bec:	05b53c23          	sd	s11,88(a0)
 bf0:	06153023          	sd	ra,96(a0)
 bf4:	06253423          	sd	sp,104(a0)
 bf8:	6180                	ld	s0,0(a1)
 bfa:	6584                	ld	s1,8(a1)
 bfc:	0105b903          	ld	s2,16(a1)
 c00:	0185b983          	ld	s3,24(a1)
 c04:	0205ba03          	ld	s4,32(a1)
 c08:	0285ba83          	ld	s5,40(a1)
 c0c:	0305bb03          	ld	s6,48(a1)
 c10:	0385bb83          	ld	s7,56(a1)
 c14:	0405bc03          	ld	s8,64(a1)
 c18:	0485bc83          	ld	s9,72(a1)
 c1c:	0505bd03          	ld	s10,80(a1)
 c20:	0585bd83          	ld	s11,88(a1)
 c24:	0605b083          	ld	ra,96(a1)
 c28:	0685b103          	ld	sp,104(a1)
 c2c:	8082                	ret
