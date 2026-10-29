
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
  2c:	e6d78793          	addi	a5,a5,-403 # 41c64e6d <base+0x41c5899d>
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
  54:	07860613          	addi	a2,a2,120 # 1078 <digits+0x3b0>
  58:	45a9                	li	a1,10
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
  72:	bb250513          	addi	a0,a0,-1102 # c20 <switch_context+0x6c>
  76:	191000ef          	jal	a06 <printf>
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
  8e:	07870713          	addi	a4,a4,120 # 1078 <digits+0x3b0>
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
  b6:	5b8000ef          	jal	66e <uptime>
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
  e2:	7135                	addi	sp,sp,-160
  e4:	ed06                	sd	ra,152(sp)
  e6:	e922                	sd	s0,144(sp)
  e8:	e526                	sd	s1,136(sp)
  ea:	e14a                	sd	s2,128(sp)
  ec:	fcce                	sd	s3,120(sp)
  ee:	f8d2                	sd	s4,112(sp)
  f0:	f4d6                	sd	s5,104(sp)
  f2:	f0da                	sd	s6,96(sp)
  f4:	ecde                	sd	s7,88(sp)
  f6:	1100                	addi	s0,sp,160
  f8:	8b0a                	mv	s6,sp
  // Se copia el puntero de la hebra que se está ejectuando en este momento en "hebra_reemplazada"
  // esto sirve para poder guardar el contexto de la hebra que se está ejecutando actualmente
  // entonces como la función se RISC V reemplaza los registros de las hebras, si no se clonara no se podría
  // guardar cual fue la hebra que se estaba ejecutando antes
    struct Thread* hebra_reemplazada = hebra_actual;
  fa:	00002a97          	auipc	s5,0x2
  fe:	f16aba83          	ld	s5,-234(s5) # 2010 <hebra_actual>
    int largo = MAX_THREADS;
    
    // aritmetica de punteros para saber el indice de la hebra que se va a reemplazar
    int id_reemplazada = hebra_actual - thread_pool;
 102:	00002a17          	auipc	s4,0x2
 106:	f1ea0a13          	addi	s4,s4,-226 # 2020 <thread_pool>
 10a:	414a8a33          	sub	s4,s5,s4
 10e:	403a5a13          	srai	s4,s4,0x3
 112:	ffa4b7b7          	lui	a5,0xffa4b
 116:	cef78793          	addi	a5,a5,-785 # ffffffffffa4acef <base+0xffffffffffa3e81f>
 11a:	07ba                	slli	a5,a5,0xe
 11c:	1785                	addi	a5,a5,-31
 11e:	07ba                	slli	a5,a5,0xe
 120:	a4b78793          	addi	a5,a5,-1461
 124:	07b2                	slli	a5,a5,0xc
 126:	cef78793          	addi	a5,a5,-785
 12a:	02fa0a3b          	mulw	s4,s4,a5
    int aux[largo - 1];
    
    // Se filtra
    // En aux se guardan todos los indices diferentes al de la hebra que se va a reemplazar
    int index_aux = 0;
    for (int i = 0; i < largo; i++) {
 12e:	4781                	li	a5,0
    int index_aux = 0;
 130:	4681                	li	a3,0
    for (int i = 0; i < largo; i++) {
 132:	4629                	li	a2,10
 134:	a021                	j	13c <thread_schedule+0x5a>
 136:	2785                	addiw	a5,a5,1
 138:	00c78d63          	beq	a5,a2,152 <thread_schedule+0x70>
        if (i != id_reemplazada) {
 13c:	fefa0de3          	beq	s4,a5,136 <thread_schedule+0x54>
            aux[index_aux] = i;
 140:	00269713          	slli	a4,a3,0x2
 144:	fb070713          	addi	a4,a4,-80
 148:	9722                	add	a4,a4,s0
 14a:	faf72823          	sw	a5,-80(a4)
            index_aux++;
 14e:	2685                	addiw	a3,a3,1
 150:	b7dd                	j	136 <thread_schedule+0x54>
 152:	f6040493          	addi	s1,s0,-160
    for (int i = 0; i < largo; i++) {
 156:	89a6                	mv	s3,s1
 158:	4925                	li	s2,9
    }

    // Se elige indice aleatorio j.
    // Se recorre en orden inverso y se intercambia el valor del indice final i con alguno de una posicion j
    int hebras_disp = MAX_THREADS - 1;
    for (int i = hebras_disp - 1; i > 0; i--) {
 15a:	4b85                	li	s7,1
        // rand() numero aleatorio, al hacer modulo da un rango entre 0 e i
        int j = rand() % (i + 1);
 15c:	ebdff0ef          	jal	18 <rand>
 160:	0325653b          	remw	a0,a0,s2
        int temp = aux[i];
 164:	0209a783          	lw	a5,32(s3)
        aux[i] = aux[j];
 168:	050a                	slli	a0,a0,0x2
 16a:	fb050713          	addi	a4,a0,-80
 16e:	00870533          	add	a0,a4,s0
 172:	fb052703          	lw	a4,-80(a0)
 176:	02e9a023          	sw	a4,32(s3)
        aux[j] = temp;
 17a:	faf52823          	sw	a5,-80(a0)
    for (int i = hebras_disp - 1; i > 0; i--) {
 17e:	397d                	addiw	s2,s2,-1
 180:	19f1                	addi	s3,s3,-4
 182:	fd791de3          	bne	s2,s7,15c <thread_schedule+0x7a>
 186:	f8840713          	addi	a4,s0,-120
 18a:	02448613          	addi	a2,s1,36
 18e:	87ba                	mv	a5,a4
    }

    // Se guardan todos los valores de los indices desordenados en los indices finales
    for (int i = 0; i < hebras_disp; i++) {
        indicesFinales[i] = aux[i];
 190:	4094                	lw	a3,0(s1)
 192:	c394                	sw	a3,0(a5)
    for (int i = 0; i < hebras_disp; i++) {
 194:	0491                	addi	s1,s1,4
 196:	0791                	addi	a5,a5,4
 198:	fec49ce3          	bne	s1,a2,190 <thread_schedule+0xae>
    }

    // Se agrega el indice de la hebra reemplazada al final 
    indicesFinales[MAX_THREADS - 1] = id_reemplazada;
 19c:	fb442623          	sw	s4,-84(s0)

    // Aqui se recorren los indices random, se guarda el puntero de la hebra que se va a ejecutar, se cambia su estado
    // y despues se hace el cambio de contexto
    for (int i = 0; i < MAX_THREADS; i++) {
 1a0:	02870813          	addi	a6,a4,40
        int indiceRandom = indicesFinales[i];
        if (thread_pool[indiceRandom].estado_thread == LISTA_PARA_CORRER) {
 1a4:	00002517          	auipc	a0,0x2
 1a8:	e7c50513          	addi	a0,a0,-388 # 2020 <thread_pool>
 1ac:	6605                	lui	a2,0x1
 1ae:	07860613          	addi	a2,a2,120 # 1078 <digits+0x3b0>
 1b2:	4585                	li	a1,1
        int indiceRandom = indicesFinales[i];
 1b4:	4314                	lw	a3,0(a4)
        if (thread_pool[indiceRandom].estado_thread == LISTA_PARA_CORRER) {
 1b6:	02c687b3          	mul	a5,a3,a2
 1ba:	97aa                	add	a5,a5,a0
 1bc:	439c                	lw	a5,0(a5)
 1be:	02b78163          	beq	a5,a1,1e0 <thread_schedule+0xfe>
    for (int i = 0; i < MAX_THREADS; i++) {
 1c2:	0711                	addi	a4,a4,4
 1c4:	ff0718e3          	bne	a4,a6,1b4 <thread_schedule+0xd2>
 1c8:	815a                	mv	sp,s6
            hebra_actual->estado_thread = CORRIENDO;
            switch_context(&hebra_reemplazada->s0, &hebra_actual->s0);
            return;
        }
    }
}
 1ca:	60ea                	ld	ra,152(sp)
 1cc:	644a                	ld	s0,144(sp)
 1ce:	64aa                	ld	s1,136(sp)
 1d0:	690a                	ld	s2,128(sp)
 1d2:	79e6                	ld	s3,120(sp)
 1d4:	7a46                	ld	s4,112(sp)
 1d6:	7aa6                	ld	s5,104(sp)
 1d8:	7b06                	ld	s6,96(sp)
 1da:	6be6                	ld	s7,88(sp)
 1dc:	610d                	addi	sp,sp,160
 1de:	8082                	ret
            hebra_actual = &thread_pool[indiceRandom];
 1e0:	6785                	lui	a5,0x1
 1e2:	07878793          	addi	a5,a5,120 # 1078 <digits+0x3b0>
 1e6:	02f686b3          	mul	a3,a3,a5
 1ea:	00002597          	auipc	a1,0x2
 1ee:	e3658593          	addi	a1,a1,-458 # 2020 <thread_pool>
 1f2:	00b687b3          	add	a5,a3,a1
 1f6:	00002717          	auipc	a4,0x2
 1fa:	e0f73d23          	sd	a5,-486(a4) # 2010 <hebra_actual>
            hebra_actual->estado_thread = CORRIENDO;
 1fe:	4709                	li	a4,2
 200:	c398                	sw	a4,0(a5)
            switch_context(&hebra_reemplazada->s0, &hebra_actual->s0);
 202:	6505                	lui	a0,0x1
 204:	0521                	addi	a0,a0,8 # 1008 <digits+0x340>
 206:	96aa                	add	a3,a3,a0
 208:	95b6                	add	a1,a1,a3
 20a:	9556                	add	a0,a0,s5
 20c:	1a9000ef          	jal	bb4 <switch_context>
            return;
 210:	815a                	mv	sp,s6
 212:	bf65                	j	1ca <thread_schedule+0xe8>

0000000000000214 <thread_yield>:

// Simplemente cambia el estado de la hebra que lo llame y hace que otra tome la CPU
void thread_yield() {
 214:	1141                	addi	sp,sp,-16
 216:	e406                	sd	ra,8(sp)
 218:	e022                	sd	s0,0(sp)
 21a:	0800                	addi	s0,sp,16
    hebra_actual->estado_thread = LISTA_PARA_CORRER;
 21c:	00002797          	auipc	a5,0x2
 220:	df47b783          	ld	a5,-524(a5) # 2010 <hebra_actual>
 224:	4705                	li	a4,1
 226:	c398                	sw	a4,0(a5)
    thread_schedule();
 228:	ebbff0ef          	jal	e2 <thread_schedule>
}
 22c:	60a2                	ld	ra,8(sp)
 22e:	6402                	ld	s0,0(sp)
 230:	0141                	addi	sp,sp,16
 232:	8082                	ret

0000000000000234 <thread_exit>:

void thread_exit() {
 234:	1141                	addi	sp,sp,-16
 236:	e406                	sd	ra,8(sp)
 238:	e022                	sd	s0,0(sp)
 23a:	0800                	addi	s0,sp,16
    hebra_actual->estado_thread = LIBRE;
 23c:	00002797          	auipc	a5,0x2
 240:	dd47b783          	ld	a5,-556(a5) # 2010 <hebra_actual>
 244:	0007a023          	sw	zero,0(a5)

    // Ver si hay hebras activas
    int hay_hebras_activas = 0;
    for (int i = 1; i < MAX_THREADS; i++) {
 248:	00003797          	auipc	a5,0x3
 24c:	e5078793          	addi	a5,a5,-432 # 3098 <thread_pool+0x1078>
 250:	0000c617          	auipc	a2,0xc
 254:	28060613          	addi	a2,a2,640 # c4d0 <base>
 258:	6685                	lui	a3,0x1
 25a:	07868693          	addi	a3,a3,120 # 1078 <digits+0x3b0>
        if (thread_pool[i].estado_thread != LIBRE) {
 25e:	4398                	lw	a4,0(a5)
 260:	eb09                	bnez	a4,272 <thread_exit+0x3e>
    for (int i = 1; i < MAX_THREADS; i++) {
 262:	97b6                	add	a5,a5,a3
 264:	fec79de3          	bne	a5,a2,25e <thread_exit+0x2a>
    }

    // Esto es para que la hebra principal pueda volver a tomar el control cuando todas las hebras
    // terminen de ejecutar su función
    if (!hay_hebras_activas) {
        thread_pool[0].estado_thread = LISTA_PARA_CORRER;
 268:	4785                	li	a5,1
 26a:	00002717          	auipc	a4,0x2
 26e:	daf72b23          	sw	a5,-586(a4) # 2020 <thread_pool>
    }
    thread_schedule();
 272:	e71ff0ef          	jal	e2 <thread_schedule>
}
 276:	60a2                	ld	ra,8(sp)
 278:	6402                	ld	s0,0(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret

000000000000027e <tarea_generica>:
#include "user/user.h"
#include "threads.c"

void
tarea_generica()
{
 27e:	7179                	addi	sp,sp,-48
 280:	f406                	sd	ra,40(sp)
 282:	f022                	sd	s0,32(sp)
 284:	ec26                	sd	s1,24(sp)
 286:	e84a                	sd	s2,16(sp)
 288:	e44e                	sd	s3,8(sp)
 28a:	e052                	sd	s4,0(sp)
 28c:	1800                	addi	s0,sp,48
  int id = hebra_actual - thread_pool;
 28e:	00002917          	auipc	s2,0x2
 292:	d8293903          	ld	s2,-638(s2) # 2010 <hebra_actual>
 296:	00002797          	auipc	a5,0x2
 29a:	d8a78793          	addi	a5,a5,-630 # 2020 <thread_pool>
 29e:	40f90933          	sub	s2,s2,a5
 2a2:	40395913          	srai	s2,s2,0x3
 2a6:	ffa4b7b7          	lui	a5,0xffa4b
 2aa:	cef78793          	addi	a5,a5,-785 # ffffffffffa4acef <base+0xffffffffffa3e81f>
 2ae:	07ba                	slli	a5,a5,0xe
 2b0:	1785                	addi	a5,a5,-31
 2b2:	07ba                	slli	a5,a5,0xe
 2b4:	a4b78793          	addi	a5,a5,-1461
 2b8:	07b2                	slli	a5,a5,0xc
 2ba:	cef78793          	addi	a5,a5,-785
 2be:	02f9093b          	mulw	s2,s2,a5
  int suma = id;

  for (int i = 1; i <= 5; i++) {
 2c2:	4485                	li	s1,1
    printf("Hebra %d - Iteracion %d\n", id, i);
 2c4:	00001a17          	auipc	s4,0x1
 2c8:	97ca0a13          	addi	s4,s4,-1668 # c40 <switch_context+0x8c>
  for (int i = 1; i <= 5; i++) {
 2cc:	4999                	li	s3,6
    printf("Hebra %d - Iteracion %d\n", id, i);
 2ce:	8626                	mv	a2,s1
 2d0:	85ca                	mv	a1,s2
 2d2:	8552                	mv	a0,s4
 2d4:	732000ef          	jal	a06 <printf>
    suma++;
    thread_yield();
 2d8:	f3dff0ef          	jal	214 <thread_yield>
  for (int i = 1; i <= 5; i++) {
 2dc:	2485                	addiw	s1,s1,1
 2de:	ff3498e3          	bne	s1,s3,2ce <tarea_generica+0x50>
  }
  printf("Hebra %d termino su trabajo. la suma tiene el valor de: %d \n", id,
 2e2:	0059061b          	addiw	a2,s2,5
 2e6:	85ca                	mv	a1,s2
 2e8:	00001517          	auipc	a0,0x1
 2ec:	97850513          	addi	a0,a0,-1672 # c60 <switch_context+0xac>
 2f0:	716000ef          	jal	a06 <printf>
         suma);
  thread_exit();
 2f4:	f41ff0ef          	jal	234 <thread_exit>
}
 2f8:	70a2                	ld	ra,40(sp)
 2fa:	7402                	ld	s0,32(sp)
 2fc:	64e2                	ld	s1,24(sp)
 2fe:	6942                	ld	s2,16(sp)
 300:	69a2                	ld	s3,8(sp)
 302:	6a02                	ld	s4,0(sp)
 304:	6145                	addi	sp,sp,48
 306:	8082                	ret

0000000000000308 <main>:

int
main(int argc, char *argv[])
{
 308:	1101                	addi	sp,sp,-32
 30a:	ec06                	sd	ra,24(sp)
 30c:	e822                	sd	s0,16(sp)
 30e:	e426                	sd	s1,8(sp)
 310:	e04a                	sd	s2,0(sp)
 312:	1000                	addi	s0,sp,32

  // Inicialzación
  thread_init();
 314:	d9bff0ef          	jal	ae <thread_init>
 318:	44a5                	li	s1,9

  // Crea la cantidad de hebras - 1, ya que la 0 es el main
  for (int i = 1; i < MAX_THREADS; i++) {
    // Se le pasa la tarea
    thread_create(tarea_generica);
 31a:	00000917          	auipc	s2,0x0
 31e:	f6490913          	addi	s2,s2,-156 # 27e <tarea_generica>
 322:	854a                	mv	a0,s2
 324:	d25ff0ef          	jal	48 <thread_create>
  for (int i = 1; i < MAX_THREADS; i++) {
 328:	34fd                	addiw	s1,s1,-1
 32a:	fce5                	bnez	s1,322 <main+0x1a>
  }

  // Una vez que todas están listas se llama al planificador que se encarga de irlas asignando de forma justa
  thread_schedule();
 32c:	db7ff0ef          	jal	e2 <thread_schedule>

  printf("Todas las hebras finalizaron.\n");
 330:	00001517          	auipc	a0,0x1
 334:	97050513          	addi	a0,a0,-1680 # ca0 <switch_context+0xec>
 338:	6ce000ef          	jal	a06 <printf>
  exit(0);
 33c:	4501                	li	a0,0
 33e:	298000ef          	jal	5d6 <exit>

0000000000000342 <start>:
 342:	1141                	addi	sp,sp,-16
 344:	e406                	sd	ra,8(sp)
 346:	e022                	sd	s0,0(sp)
 348:	0800                	addi	s0,sp,16
 34a:	fbfff0ef          	jal	308 <main>
 34e:	288000ef          	jal	5d6 <exit>

0000000000000352 <strcpy>:
 352:	1141                	addi	sp,sp,-16
 354:	e422                	sd	s0,8(sp)
 356:	0800                	addi	s0,sp,16
 358:	87aa                	mv	a5,a0
 35a:	0585                	addi	a1,a1,1
 35c:	0785                	addi	a5,a5,1
 35e:	fff5c703          	lbu	a4,-1(a1)
 362:	fee78fa3          	sb	a4,-1(a5)
 366:	fb75                	bnez	a4,35a <strcpy+0x8>
 368:	6422                	ld	s0,8(sp)
 36a:	0141                	addi	sp,sp,16
 36c:	8082                	ret

000000000000036e <strcmp>:
 36e:	1141                	addi	sp,sp,-16
 370:	e422                	sd	s0,8(sp)
 372:	0800                	addi	s0,sp,16
 374:	00054783          	lbu	a5,0(a0)
 378:	cb91                	beqz	a5,38c <strcmp+0x1e>
 37a:	0005c703          	lbu	a4,0(a1)
 37e:	00f71763          	bne	a4,a5,38c <strcmp+0x1e>
 382:	0505                	addi	a0,a0,1
 384:	0585                	addi	a1,a1,1
 386:	00054783          	lbu	a5,0(a0)
 38a:	fbe5                	bnez	a5,37a <strcmp+0xc>
 38c:	0005c503          	lbu	a0,0(a1)
 390:	40a7853b          	subw	a0,a5,a0
 394:	6422                	ld	s0,8(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret

000000000000039a <strlen>:
 39a:	1141                	addi	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	addi	s0,sp,16
 3a0:	00054783          	lbu	a5,0(a0)
 3a4:	cf91                	beqz	a5,3c0 <strlen+0x26>
 3a6:	0505                	addi	a0,a0,1
 3a8:	87aa                	mv	a5,a0
 3aa:	86be                	mv	a3,a5
 3ac:	0785                	addi	a5,a5,1
 3ae:	fff7c703          	lbu	a4,-1(a5)
 3b2:	ff65                	bnez	a4,3aa <strlen+0x10>
 3b4:	40a6853b          	subw	a0,a3,a0
 3b8:	2505                	addiw	a0,a0,1
 3ba:	6422                	ld	s0,8(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret
 3c0:	4501                	li	a0,0
 3c2:	bfe5                	j	3ba <strlen+0x20>

00000000000003c4 <memset>:
 3c4:	1141                	addi	sp,sp,-16
 3c6:	e422                	sd	s0,8(sp)
 3c8:	0800                	addi	s0,sp,16
 3ca:	ca19                	beqz	a2,3e0 <memset+0x1c>
 3cc:	87aa                	mv	a5,a0
 3ce:	1602                	slli	a2,a2,0x20
 3d0:	9201                	srli	a2,a2,0x20
 3d2:	00a60733          	add	a4,a2,a0
 3d6:	00b78023          	sb	a1,0(a5)
 3da:	0785                	addi	a5,a5,1
 3dc:	fee79de3          	bne	a5,a4,3d6 <memset+0x12>
 3e0:	6422                	ld	s0,8(sp)
 3e2:	0141                	addi	sp,sp,16
 3e4:	8082                	ret

00000000000003e6 <strchr>:
 3e6:	1141                	addi	sp,sp,-16
 3e8:	e422                	sd	s0,8(sp)
 3ea:	0800                	addi	s0,sp,16
 3ec:	00054783          	lbu	a5,0(a0)
 3f0:	cb99                	beqz	a5,406 <strchr+0x20>
 3f2:	00f58763          	beq	a1,a5,400 <strchr+0x1a>
 3f6:	0505                	addi	a0,a0,1
 3f8:	00054783          	lbu	a5,0(a0)
 3fc:	fbfd                	bnez	a5,3f2 <strchr+0xc>
 3fe:	4501                	li	a0,0
 400:	6422                	ld	s0,8(sp)
 402:	0141                	addi	sp,sp,16
 404:	8082                	ret
 406:	4501                	li	a0,0
 408:	bfe5                	j	400 <strchr+0x1a>

000000000000040a <gets>:
 40a:	711d                	addi	sp,sp,-96
 40c:	ec86                	sd	ra,88(sp)
 40e:	e8a2                	sd	s0,80(sp)
 410:	e4a6                	sd	s1,72(sp)
 412:	e0ca                	sd	s2,64(sp)
 414:	fc4e                	sd	s3,56(sp)
 416:	f852                	sd	s4,48(sp)
 418:	f456                	sd	s5,40(sp)
 41a:	f05a                	sd	s6,32(sp)
 41c:	ec5e                	sd	s7,24(sp)
 41e:	1080                	addi	s0,sp,96
 420:	8baa                	mv	s7,a0
 422:	8a2e                	mv	s4,a1
 424:	892a                	mv	s2,a0
 426:	4481                	li	s1,0
 428:	4aa9                	li	s5,10
 42a:	4b35                	li	s6,13
 42c:	89a6                	mv	s3,s1
 42e:	2485                	addiw	s1,s1,1
 430:	0344d663          	bge	s1,s4,45c <gets+0x52>
 434:	4605                	li	a2,1
 436:	faf40593          	addi	a1,s0,-81
 43a:	4501                	li	a0,0
 43c:	1b2000ef          	jal	5ee <read>
 440:	00a05e63          	blez	a0,45c <gets+0x52>
 444:	faf44783          	lbu	a5,-81(s0)
 448:	00f90023          	sb	a5,0(s2)
 44c:	01578763          	beq	a5,s5,45a <gets+0x50>
 450:	0905                	addi	s2,s2,1
 452:	fd679de3          	bne	a5,s6,42c <gets+0x22>
 456:	89a6                	mv	s3,s1
 458:	a011                	j	45c <gets+0x52>
 45a:	89a6                	mv	s3,s1
 45c:	99de                	add	s3,s3,s7
 45e:	00098023          	sb	zero,0(s3)
 462:	855e                	mv	a0,s7
 464:	60e6                	ld	ra,88(sp)
 466:	6446                	ld	s0,80(sp)
 468:	64a6                	ld	s1,72(sp)
 46a:	6906                	ld	s2,64(sp)
 46c:	79e2                	ld	s3,56(sp)
 46e:	7a42                	ld	s4,48(sp)
 470:	7aa2                	ld	s5,40(sp)
 472:	7b02                	ld	s6,32(sp)
 474:	6be2                	ld	s7,24(sp)
 476:	6125                	addi	sp,sp,96
 478:	8082                	ret

000000000000047a <stat>:
 47a:	1101                	addi	sp,sp,-32
 47c:	ec06                	sd	ra,24(sp)
 47e:	e822                	sd	s0,16(sp)
 480:	e04a                	sd	s2,0(sp)
 482:	1000                	addi	s0,sp,32
 484:	892e                	mv	s2,a1
 486:	4581                	li	a1,0
 488:	18e000ef          	jal	616 <open>
 48c:	02054263          	bltz	a0,4b0 <stat+0x36>
 490:	e426                	sd	s1,8(sp)
 492:	84aa                	mv	s1,a0
 494:	85ca                	mv	a1,s2
 496:	198000ef          	jal	62e <fstat>
 49a:	892a                	mv	s2,a0
 49c:	8526                	mv	a0,s1
 49e:	160000ef          	jal	5fe <close>
 4a2:	64a2                	ld	s1,8(sp)
 4a4:	854a                	mv	a0,s2
 4a6:	60e2                	ld	ra,24(sp)
 4a8:	6442                	ld	s0,16(sp)
 4aa:	6902                	ld	s2,0(sp)
 4ac:	6105                	addi	sp,sp,32
 4ae:	8082                	ret
 4b0:	597d                	li	s2,-1
 4b2:	bfcd                	j	4a4 <stat+0x2a>

00000000000004b4 <atoi>:
 4b4:	1141                	addi	sp,sp,-16
 4b6:	e422                	sd	s0,8(sp)
 4b8:	0800                	addi	s0,sp,16
 4ba:	00054683          	lbu	a3,0(a0)
 4be:	fd06879b          	addiw	a5,a3,-48
 4c2:	0ff7f793          	zext.b	a5,a5
 4c6:	4625                	li	a2,9
 4c8:	02f66863          	bltu	a2,a5,4f8 <atoi+0x44>
 4cc:	872a                	mv	a4,a0
 4ce:	4501                	li	a0,0
 4d0:	0705                	addi	a4,a4,1
 4d2:	0025179b          	slliw	a5,a0,0x2
 4d6:	9fa9                	addw	a5,a5,a0
 4d8:	0017979b          	slliw	a5,a5,0x1
 4dc:	9fb5                	addw	a5,a5,a3
 4de:	fd07851b          	addiw	a0,a5,-48
 4e2:	00074683          	lbu	a3,0(a4)
 4e6:	fd06879b          	addiw	a5,a3,-48
 4ea:	0ff7f793          	zext.b	a5,a5
 4ee:	fef671e3          	bgeu	a2,a5,4d0 <atoi+0x1c>
 4f2:	6422                	ld	s0,8(sp)
 4f4:	0141                	addi	sp,sp,16
 4f6:	8082                	ret
 4f8:	4501                	li	a0,0
 4fa:	bfe5                	j	4f2 <atoi+0x3e>

00000000000004fc <memmove>:
 4fc:	1141                	addi	sp,sp,-16
 4fe:	e422                	sd	s0,8(sp)
 500:	0800                	addi	s0,sp,16
 502:	02b57463          	bgeu	a0,a1,52a <memmove+0x2e>
 506:	00c05f63          	blez	a2,524 <memmove+0x28>
 50a:	1602                	slli	a2,a2,0x20
 50c:	9201                	srli	a2,a2,0x20
 50e:	00c507b3          	add	a5,a0,a2
 512:	872a                	mv	a4,a0
 514:	0585                	addi	a1,a1,1
 516:	0705                	addi	a4,a4,1
 518:	fff5c683          	lbu	a3,-1(a1)
 51c:	fed70fa3          	sb	a3,-1(a4)
 520:	fef71ae3          	bne	a4,a5,514 <memmove+0x18>
 524:	6422                	ld	s0,8(sp)
 526:	0141                	addi	sp,sp,16
 528:	8082                	ret
 52a:	00c50733          	add	a4,a0,a2
 52e:	95b2                	add	a1,a1,a2
 530:	fec05ae3          	blez	a2,524 <memmove+0x28>
 534:	fff6079b          	addiw	a5,a2,-1
 538:	1782                	slli	a5,a5,0x20
 53a:	9381                	srli	a5,a5,0x20
 53c:	fff7c793          	not	a5,a5
 540:	97ba                	add	a5,a5,a4
 542:	15fd                	addi	a1,a1,-1
 544:	177d                	addi	a4,a4,-1
 546:	0005c683          	lbu	a3,0(a1)
 54a:	00d70023          	sb	a3,0(a4)
 54e:	fee79ae3          	bne	a5,a4,542 <memmove+0x46>
 552:	bfc9                	j	524 <memmove+0x28>

0000000000000554 <memcmp>:
 554:	1141                	addi	sp,sp,-16
 556:	e422                	sd	s0,8(sp)
 558:	0800                	addi	s0,sp,16
 55a:	ca05                	beqz	a2,58a <memcmp+0x36>
 55c:	fff6069b          	addiw	a3,a2,-1
 560:	1682                	slli	a3,a3,0x20
 562:	9281                	srli	a3,a3,0x20
 564:	0685                	addi	a3,a3,1
 566:	96aa                	add	a3,a3,a0
 568:	00054783          	lbu	a5,0(a0)
 56c:	0005c703          	lbu	a4,0(a1)
 570:	00e79863          	bne	a5,a4,580 <memcmp+0x2c>
 574:	0505                	addi	a0,a0,1
 576:	0585                	addi	a1,a1,1
 578:	fed518e3          	bne	a0,a3,568 <memcmp+0x14>
 57c:	4501                	li	a0,0
 57e:	a019                	j	584 <memcmp+0x30>
 580:	40e7853b          	subw	a0,a5,a4
 584:	6422                	ld	s0,8(sp)
 586:	0141                	addi	sp,sp,16
 588:	8082                	ret
 58a:	4501                	li	a0,0
 58c:	bfe5                	j	584 <memcmp+0x30>

000000000000058e <memcpy>:
 58e:	1141                	addi	sp,sp,-16
 590:	e406                	sd	ra,8(sp)
 592:	e022                	sd	s0,0(sp)
 594:	0800                	addi	s0,sp,16
 596:	f67ff0ef          	jal	4fc <memmove>
 59a:	60a2                	ld	ra,8(sp)
 59c:	6402                	ld	s0,0(sp)
 59e:	0141                	addi	sp,sp,16
 5a0:	8082                	ret

00000000000005a2 <sbrk>:
 5a2:	1141                	addi	sp,sp,-16
 5a4:	e406                	sd	ra,8(sp)
 5a6:	e022                	sd	s0,0(sp)
 5a8:	0800                	addi	s0,sp,16
 5aa:	4585                	li	a1,1
 5ac:	0b2000ef          	jal	65e <sys_sbrk>
 5b0:	60a2                	ld	ra,8(sp)
 5b2:	6402                	ld	s0,0(sp)
 5b4:	0141                	addi	sp,sp,16
 5b6:	8082                	ret

00000000000005b8 <sbrklazy>:
 5b8:	1141                	addi	sp,sp,-16
 5ba:	e406                	sd	ra,8(sp)
 5bc:	e022                	sd	s0,0(sp)
 5be:	0800                	addi	s0,sp,16
 5c0:	4589                	li	a1,2
 5c2:	09c000ef          	jal	65e <sys_sbrk>
 5c6:	60a2                	ld	ra,8(sp)
 5c8:	6402                	ld	s0,0(sp)
 5ca:	0141                	addi	sp,sp,16
 5cc:	8082                	ret

00000000000005ce <fork>:
 5ce:	4885                	li	a7,1
 5d0:	00000073          	ecall
 5d4:	8082                	ret

00000000000005d6 <exit>:
 5d6:	4889                	li	a7,2
 5d8:	00000073          	ecall
 5dc:	8082                	ret

00000000000005de <wait>:
 5de:	488d                	li	a7,3
 5e0:	00000073          	ecall
 5e4:	8082                	ret

00000000000005e6 <pipe>:
 5e6:	4891                	li	a7,4
 5e8:	00000073          	ecall
 5ec:	8082                	ret

00000000000005ee <read>:
 5ee:	4895                	li	a7,5
 5f0:	00000073          	ecall
 5f4:	8082                	ret

00000000000005f6 <write>:
 5f6:	48c1                	li	a7,16
 5f8:	00000073          	ecall
 5fc:	8082                	ret

00000000000005fe <close>:
 5fe:	48d5                	li	a7,21
 600:	00000073          	ecall
 604:	8082                	ret

0000000000000606 <kill>:
 606:	4899                	li	a7,6
 608:	00000073          	ecall
 60c:	8082                	ret

000000000000060e <exec>:
 60e:	489d                	li	a7,7
 610:	00000073          	ecall
 614:	8082                	ret

0000000000000616 <open>:
 616:	48bd                	li	a7,15
 618:	00000073          	ecall
 61c:	8082                	ret

000000000000061e <mknod>:
 61e:	48c5                	li	a7,17
 620:	00000073          	ecall
 624:	8082                	ret

0000000000000626 <unlink>:
 626:	48c9                	li	a7,18
 628:	00000073          	ecall
 62c:	8082                	ret

000000000000062e <fstat>:
 62e:	48a1                	li	a7,8
 630:	00000073          	ecall
 634:	8082                	ret

0000000000000636 <link>:
 636:	48cd                	li	a7,19
 638:	00000073          	ecall
 63c:	8082                	ret

000000000000063e <mkdir>:
 63e:	48d1                	li	a7,20
 640:	00000073          	ecall
 644:	8082                	ret

0000000000000646 <chdir>:
 646:	48a5                	li	a7,9
 648:	00000073          	ecall
 64c:	8082                	ret

000000000000064e <dup>:
 64e:	48a9                	li	a7,10
 650:	00000073          	ecall
 654:	8082                	ret

0000000000000656 <getpid>:
 656:	48ad                	li	a7,11
 658:	00000073          	ecall
 65c:	8082                	ret

000000000000065e <sys_sbrk>:
 65e:	48b1                	li	a7,12
 660:	00000073          	ecall
 664:	8082                	ret

0000000000000666 <pause>:
 666:	48b5                	li	a7,13
 668:	00000073          	ecall
 66c:	8082                	ret

000000000000066e <uptime>:
 66e:	48b9                	li	a7,14
 670:	00000073          	ecall
 674:	8082                	ret

0000000000000676 <sync>:
 676:	48d9                	li	a7,22
 678:	00000073          	ecall
 67c:	8082                	ret

000000000000067e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 67e:	1101                	addi	sp,sp,-32
 680:	ec06                	sd	ra,24(sp)
 682:	e822                	sd	s0,16(sp)
 684:	1000                	addi	s0,sp,32
 686:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 68a:	4605                	li	a2,1
 68c:	fef40593          	addi	a1,s0,-17
 690:	f67ff0ef          	jal	5f6 <write>
}
 694:	60e2                	ld	ra,24(sp)
 696:	6442                	ld	s0,16(sp)
 698:	6105                	addi	sp,sp,32
 69a:	8082                	ret

000000000000069c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 69c:	715d                	addi	sp,sp,-80
 69e:	e486                	sd	ra,72(sp)
 6a0:	e0a2                	sd	s0,64(sp)
 6a2:	f84a                	sd	s2,48(sp)
 6a4:	0880                	addi	s0,sp,80
 6a6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if (sgn && xx < 0) {
 6a8:	c299                	beqz	a3,6ae <printint+0x12>
 6aa:	0805c363          	bltz	a1,730 <printint+0x94>
  neg = 0;
 6ae:	4881                	li	a7,0
 6b0:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 6b4:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
 6b6:	00000517          	auipc	a0,0x0
 6ba:	61250513          	addi	a0,a0,1554 # cc8 <digits>
 6be:	883e                	mv	a6,a5
 6c0:	2785                	addiw	a5,a5,1
 6c2:	02c5f733          	remu	a4,a1,a2
 6c6:	972a                	add	a4,a4,a0
 6c8:	00074703          	lbu	a4,0(a4)
 6cc:	00e68023          	sb	a4,0(a3)
  } while ((x /= base) != 0);
 6d0:	872e                	mv	a4,a1
 6d2:	02c5d5b3          	divu	a1,a1,a2
 6d6:	0685                	addi	a3,a3,1
 6d8:	fec773e3          	bgeu	a4,a2,6be <printint+0x22>
  if (neg)
 6dc:	00088b63          	beqz	a7,6f2 <printint+0x56>
    buf[i++] = '-';
 6e0:	fd078793          	addi	a5,a5,-48
 6e4:	97a2                	add	a5,a5,s0
 6e6:	02d00713          	li	a4,45
 6ea:	fee78423          	sb	a4,-24(a5)
 6ee:	0028079b          	addiw	a5,a6,2

  while (--i >= 0)
 6f2:	02f05a63          	blez	a5,726 <printint+0x8a>
 6f6:	fc26                	sd	s1,56(sp)
 6f8:	f44e                	sd	s3,40(sp)
 6fa:	fb840713          	addi	a4,s0,-72
 6fe:	00f704b3          	add	s1,a4,a5
 702:	fff70993          	addi	s3,a4,-1
 706:	99be                	add	s3,s3,a5
 708:	37fd                	addiw	a5,a5,-1
 70a:	1782                	slli	a5,a5,0x20
 70c:	9381                	srli	a5,a5,0x20
 70e:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 712:	fff4c583          	lbu	a1,-1(s1)
 716:	854a                	mv	a0,s2
 718:	f67ff0ef          	jal	67e <putc>
  while (--i >= 0)
 71c:	14fd                	addi	s1,s1,-1
 71e:	ff349ae3          	bne	s1,s3,712 <printint+0x76>
 722:	74e2                	ld	s1,56(sp)
 724:	79a2                	ld	s3,40(sp)
}
 726:	60a6                	ld	ra,72(sp)
 728:	6406                	ld	s0,64(sp)
 72a:	7942                	ld	s2,48(sp)
 72c:	6161                	addi	sp,sp,80
 72e:	8082                	ret
    x = -xx;
 730:	40b005b3          	neg	a1,a1
    neg = 1;
 734:	4885                	li	a7,1
    x = -xx;
 736:	bfad                	j	6b0 <printint+0x14>

0000000000000738 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 738:	711d                	addi	sp,sp,-96
 73a:	ec86                	sd	ra,88(sp)
 73c:	e8a2                	sd	s0,80(sp)
 73e:	e0ca                	sd	s2,64(sp)
 740:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for (i = 0; fmt[i]; i++) {
 742:	0005c903          	lbu	s2,0(a1)
 746:	28090663          	beqz	s2,9d2 <vprintf+0x29a>
 74a:	e4a6                	sd	s1,72(sp)
 74c:	fc4e                	sd	s3,56(sp)
 74e:	f852                	sd	s4,48(sp)
 750:	f456                	sd	s5,40(sp)
 752:	f05a                	sd	s6,32(sp)
 754:	ec5e                	sd	s7,24(sp)
 756:	e862                	sd	s8,16(sp)
 758:	e466                	sd	s9,8(sp)
 75a:	8b2a                	mv	s6,a0
 75c:	8a2e                	mv	s4,a1
 75e:	8bb2                	mv	s7,a2
  state = 0;
 760:	4981                	li	s3,0
  for (i = 0; fmt[i]; i++) {
 762:	4481                	li	s1,0
 764:	4701                	li	a4,0
      if (c0 == '%') {
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if (state == '%') {
 766:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if (c0)
        c1 = fmt[i + 1] & 0xff;
      if (c1)
        c2 = fmt[i + 2] & 0xff;
      if (c0 == 'd') {
 76a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if (c0 == 'l' && c1 == 'd') {
 76e:	06c00c93          	li	s9,108
 772:	a005                	j	792 <vprintf+0x5a>
        putc(fd, c0);
 774:	85ca                	mv	a1,s2
 776:	855a                	mv	a0,s6
 778:	f07ff0ef          	jal	67e <putc>
 77c:	a019                	j	782 <vprintf+0x4a>
    } else if (state == '%') {
 77e:	03598263          	beq	s3,s5,7a2 <vprintf+0x6a>
  for (i = 0; fmt[i]; i++) {
 782:	2485                	addiw	s1,s1,1
 784:	8726                	mv	a4,s1
 786:	009a07b3          	add	a5,s4,s1
 78a:	0007c903          	lbu	s2,0(a5)
 78e:	22090a63          	beqz	s2,9c2 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 792:	0009079b          	sext.w	a5,s2
    if (state == 0) {
 796:	fe0994e3          	bnez	s3,77e <vprintf+0x46>
      if (c0 == '%') {
 79a:	fd579de3          	bne	a5,s5,774 <vprintf+0x3c>
        state = '%';
 79e:	89be                	mv	s3,a5
 7a0:	b7cd                	j	782 <vprintf+0x4a>
        c1 = fmt[i + 1] & 0xff;
 7a2:	00ea06b3          	add	a3,s4,a4
 7a6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 7aa:	8636                	mv	a2,a3
      if (c1)
 7ac:	c681                	beqz	a3,7b4 <vprintf+0x7c>
        c2 = fmt[i + 2] & 0xff;
 7ae:	9752                	add	a4,a4,s4
 7b0:	00274603          	lbu	a2,2(a4)
      if (c0 == 'd') {
 7b4:	05878363          	beq	a5,s8,7fa <vprintf+0xc2>
      } else if (c0 == 'l' && c1 == 'd') {
 7b8:	05978d63          	beq	a5,s9,812 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if (c0 == 'u') {
 7bc:	07500713          	li	a4,117
 7c0:	0ee78763          	beq	a5,a4,8ae <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if (c0 == 'x') {
 7c4:	07800713          	li	a4,120
 7c8:	12e78963          	beq	a5,a4,8fa <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if (c0 == 'p') {
 7cc:	07000713          	li	a4,112
 7d0:	14e78e63          	beq	a5,a4,92c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if (c0 == 'c') {
 7d4:	06300713          	li	a4,99
 7d8:	18e78e63          	beq	a5,a4,974 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if (c0 == 's') {
 7dc:	07300713          	li	a4,115
 7e0:	1ae78463          	beq	a5,a4,988 <vprintf+0x250>
        if ((s = va_arg(ap, char *)) == 0)
          s = "(null)";
        for (; *s; s++)
          putc(fd, *s);
      } else if (c0 == '%') {
 7e4:	02500713          	li	a4,37
 7e8:	04e79563          	bne	a5,a4,832 <vprintf+0xfa>
        putc(fd, '%');
 7ec:	02500593          	li	a1,37
 7f0:	855a                	mv	a0,s6
 7f2:	e8dff0ef          	jal	67e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 7f6:	4981                	li	s3,0
 7f8:	b769                	j	782 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7fa:	008b8913          	addi	s2,s7,8
 7fe:	4685                	li	a3,1
 800:	4629                	li	a2,10
 802:	000ba583          	lw	a1,0(s7)
 806:	855a                	mv	a0,s6
 808:	e95ff0ef          	jal	69c <printint>
 80c:	8bca                	mv	s7,s2
      state = 0;
 80e:	4981                	li	s3,0
 810:	bf8d                	j	782 <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'd') {
 812:	06400793          	li	a5,100
 816:	02f68963          	beq	a3,a5,848 <vprintf+0x110>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 81a:	06c00793          	li	a5,108
 81e:	04f68263          	beq	a3,a5,862 <vprintf+0x12a>
      } else if (c0 == 'l' && c1 == 'u') {
 822:	07500793          	li	a5,117
 826:	0af68063          	beq	a3,a5,8c6 <vprintf+0x18e>
      } else if (c0 == 'l' && c1 == 'x') {
 82a:	07800793          	li	a5,120
 82e:	0ef68263          	beq	a3,a5,912 <vprintf+0x1da>
        putc(fd, '%');
 832:	02500593          	li	a1,37
 836:	855a                	mv	a0,s6
 838:	e47ff0ef          	jal	67e <putc>
        putc(fd, c0);
 83c:	85ca                	mv	a1,s2
 83e:	855a                	mv	a0,s6
 840:	e3fff0ef          	jal	67e <putc>
      state = 0;
 844:	4981                	li	s3,0
 846:	bf35                	j	782 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 848:	008b8913          	addi	s2,s7,8
 84c:	4685                	li	a3,1
 84e:	4629                	li	a2,10
 850:	000bb583          	ld	a1,0(s7)
 854:	855a                	mv	a0,s6
 856:	e47ff0ef          	jal	69c <printint>
        i += 1;
 85a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 85c:	8bca                	mv	s7,s2
      state = 0;
 85e:	4981                	li	s3,0
        i += 1;
 860:	b70d                	j	782 <vprintf+0x4a>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'd') {
 862:	06400793          	li	a5,100
 866:	02f60763          	beq	a2,a5,894 <vprintf+0x15c>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'u') {
 86a:	07500793          	li	a5,117
 86e:	06f60963          	beq	a2,a5,8e0 <vprintf+0x1a8>
      } else if (c0 == 'l' && c1 == 'l' && c2 == 'x') {
 872:	07800793          	li	a5,120
 876:	faf61ee3          	bne	a2,a5,832 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 87a:	008b8913          	addi	s2,s7,8
 87e:	4681                	li	a3,0
 880:	4641                	li	a2,16
 882:	000bb583          	ld	a1,0(s7)
 886:	855a                	mv	a0,s6
 888:	e15ff0ef          	jal	69c <printint>
        i += 2;
 88c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 88e:	8bca                	mv	s7,s2
      state = 0;
 890:	4981                	li	s3,0
        i += 2;
 892:	bdc5                	j	782 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 894:	008b8913          	addi	s2,s7,8
 898:	4685                	li	a3,1
 89a:	4629                	li	a2,10
 89c:	000bb583          	ld	a1,0(s7)
 8a0:	855a                	mv	a0,s6
 8a2:	dfbff0ef          	jal	69c <printint>
        i += 2;
 8a6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 8a8:	8bca                	mv	s7,s2
      state = 0;
 8aa:	4981                	li	s3,0
        i += 2;
 8ac:	bdd9                	j	782 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 8ae:	008b8913          	addi	s2,s7,8
 8b2:	4681                	li	a3,0
 8b4:	4629                	li	a2,10
 8b6:	000be583          	lwu	a1,0(s7)
 8ba:	855a                	mv	a0,s6
 8bc:	de1ff0ef          	jal	69c <printint>
 8c0:	8bca                	mv	s7,s2
      state = 0;
 8c2:	4981                	li	s3,0
 8c4:	bd7d                	j	782 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8c6:	008b8913          	addi	s2,s7,8
 8ca:	4681                	li	a3,0
 8cc:	4629                	li	a2,10
 8ce:	000bb583          	ld	a1,0(s7)
 8d2:	855a                	mv	a0,s6
 8d4:	dc9ff0ef          	jal	69c <printint>
        i += 1;
 8d8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8da:	8bca                	mv	s7,s2
      state = 0;
 8dc:	4981                	li	s3,0
        i += 1;
 8de:	b555                	j	782 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8e0:	008b8913          	addi	s2,s7,8
 8e4:	4681                	li	a3,0
 8e6:	4629                	li	a2,10
 8e8:	000bb583          	ld	a1,0(s7)
 8ec:	855a                	mv	a0,s6
 8ee:	dafff0ef          	jal	69c <printint>
        i += 2;
 8f2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8f4:	8bca                	mv	s7,s2
      state = 0;
 8f6:	4981                	li	s3,0
        i += 2;
 8f8:	b569                	j	782 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 8fa:	008b8913          	addi	s2,s7,8
 8fe:	4681                	li	a3,0
 900:	4641                	li	a2,16
 902:	000be583          	lwu	a1,0(s7)
 906:	855a                	mv	a0,s6
 908:	d95ff0ef          	jal	69c <printint>
 90c:	8bca                	mv	s7,s2
      state = 0;
 90e:	4981                	li	s3,0
 910:	bd8d                	j	782 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 912:	008b8913          	addi	s2,s7,8
 916:	4681                	li	a3,0
 918:	4641                	li	a2,16
 91a:	000bb583          	ld	a1,0(s7)
 91e:	855a                	mv	a0,s6
 920:	d7dff0ef          	jal	69c <printint>
        i += 1;
 924:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 926:	8bca                	mv	s7,s2
      state = 0;
 928:	4981                	li	s3,0
        i += 1;
 92a:	bda1                	j	782 <vprintf+0x4a>
 92c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 92e:	008b8d13          	addi	s10,s7,8
 932:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 936:	03000593          	li	a1,48
 93a:	855a                	mv	a0,s6
 93c:	d43ff0ef          	jal	67e <putc>
  putc(fd, 'x');
 940:	07800593          	li	a1,120
 944:	855a                	mv	a0,s6
 946:	d39ff0ef          	jal	67e <putc>
 94a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 94c:	00000b97          	auipc	s7,0x0
 950:	37cb8b93          	addi	s7,s7,892 # cc8 <digits>
 954:	03c9d793          	srli	a5,s3,0x3c
 958:	97de                	add	a5,a5,s7
 95a:	0007c583          	lbu	a1,0(a5)
 95e:	855a                	mv	a0,s6
 960:	d1fff0ef          	jal	67e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 964:	0992                	slli	s3,s3,0x4
 966:	397d                	addiw	s2,s2,-1
 968:	fe0916e3          	bnez	s2,954 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 96c:	8bea                	mv	s7,s10
      state = 0;
 96e:	4981                	li	s3,0
 970:	6d02                	ld	s10,0(sp)
 972:	bd01                	j	782 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 974:	008b8913          	addi	s2,s7,8
 978:	000bc583          	lbu	a1,0(s7)
 97c:	855a                	mv	a0,s6
 97e:	d01ff0ef          	jal	67e <putc>
 982:	8bca                	mv	s7,s2
      state = 0;
 984:	4981                	li	s3,0
 986:	bbf5                	j	782 <vprintf+0x4a>
        if ((s = va_arg(ap, char *)) == 0)
 988:	008b8993          	addi	s3,s7,8
 98c:	000bb903          	ld	s2,0(s7)
 990:	00090f63          	beqz	s2,9ae <vprintf+0x276>
        for (; *s; s++)
 994:	00094583          	lbu	a1,0(s2)
 998:	c195                	beqz	a1,9bc <vprintf+0x284>
          putc(fd, *s);
 99a:	855a                	mv	a0,s6
 99c:	ce3ff0ef          	jal	67e <putc>
        for (; *s; s++)
 9a0:	0905                	addi	s2,s2,1
 9a2:	00094583          	lbu	a1,0(s2)
 9a6:	f9f5                	bnez	a1,99a <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 9a8:	8bce                	mv	s7,s3
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	bbd9                	j	782 <vprintf+0x4a>
          s = "(null)";
 9ae:	00000917          	auipc	s2,0x0
 9b2:	31290913          	addi	s2,s2,786 # cc0 <switch_context+0x10c>
        for (; *s; s++)
 9b6:	02800593          	li	a1,40
 9ba:	b7c5                	j	99a <vprintf+0x262>
        if ((s = va_arg(ap, char *)) == 0)
 9bc:	8bce                	mv	s7,s3
      state = 0;
 9be:	4981                	li	s3,0
 9c0:	b3c9                	j	782 <vprintf+0x4a>
 9c2:	64a6                	ld	s1,72(sp)
 9c4:	79e2                	ld	s3,56(sp)
 9c6:	7a42                	ld	s4,48(sp)
 9c8:	7aa2                	ld	s5,40(sp)
 9ca:	7b02                	ld	s6,32(sp)
 9cc:	6be2                	ld	s7,24(sp)
 9ce:	6c42                	ld	s8,16(sp)
 9d0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 9d2:	60e6                	ld	ra,88(sp)
 9d4:	6446                	ld	s0,80(sp)
 9d6:	6906                	ld	s2,64(sp)
 9d8:	6125                	addi	sp,sp,96
 9da:	8082                	ret

00000000000009dc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9dc:	715d                	addi	sp,sp,-80
 9de:	ec06                	sd	ra,24(sp)
 9e0:	e822                	sd	s0,16(sp)
 9e2:	1000                	addi	s0,sp,32
 9e4:	e010                	sd	a2,0(s0)
 9e6:	e414                	sd	a3,8(s0)
 9e8:	e818                	sd	a4,16(s0)
 9ea:	ec1c                	sd	a5,24(s0)
 9ec:	03043023          	sd	a6,32(s0)
 9f0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9f4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9f8:	8622                	mv	a2,s0
 9fa:	d3fff0ef          	jal	738 <vprintf>
}
 9fe:	60e2                	ld	ra,24(sp)
 a00:	6442                	ld	s0,16(sp)
 a02:	6161                	addi	sp,sp,80
 a04:	8082                	ret

0000000000000a06 <printf>:

void
printf(const char *fmt, ...)
{
 a06:	711d                	addi	sp,sp,-96
 a08:	ec06                	sd	ra,24(sp)
 a0a:	e822                	sd	s0,16(sp)
 a0c:	1000                	addi	s0,sp,32
 a0e:	e40c                	sd	a1,8(s0)
 a10:	e810                	sd	a2,16(s0)
 a12:	ec14                	sd	a3,24(s0)
 a14:	f018                	sd	a4,32(s0)
 a16:	f41c                	sd	a5,40(s0)
 a18:	03043823          	sd	a6,48(s0)
 a1c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a20:	00840613          	addi	a2,s0,8
 a24:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a28:	85aa                	mv	a1,a0
 a2a:	4505                	li	a0,1
 a2c:	d0dff0ef          	jal	738 <vprintf>
}
 a30:	60e2                	ld	ra,24(sp)
 a32:	6442                	ld	s0,16(sp)
 a34:	6125                	addi	sp,sp,96
 a36:	8082                	ret

0000000000000a38 <free>:
 a38:	1141                	addi	sp,sp,-16
 a3a:	e422                	sd	s0,8(sp)
 a3c:	0800                	addi	s0,sp,16
 a3e:	ff050693          	addi	a3,a0,-16
 a42:	00001797          	auipc	a5,0x1
 a46:	5d67b783          	ld	a5,1494(a5) # 2018 <freep>
 a4a:	a02d                	j	a74 <free+0x3c>
 a4c:	4618                	lw	a4,8(a2)
 a4e:	9f2d                	addw	a4,a4,a1
 a50:	fee52c23          	sw	a4,-8(a0)
 a54:	6398                	ld	a4,0(a5)
 a56:	6310                	ld	a2,0(a4)
 a58:	a83d                	j	a96 <free+0x5e>
 a5a:	ff852703          	lw	a4,-8(a0)
 a5e:	9f31                	addw	a4,a4,a2
 a60:	c798                	sw	a4,8(a5)
 a62:	ff053683          	ld	a3,-16(a0)
 a66:	a091                	j	aaa <free+0x72>
 a68:	6398                	ld	a4,0(a5)
 a6a:	00e7e463          	bltu	a5,a4,a72 <free+0x3a>
 a6e:	00e6ea63          	bltu	a3,a4,a82 <free+0x4a>
 a72:	87ba                	mv	a5,a4
 a74:	fed7fae3          	bgeu	a5,a3,a68 <free+0x30>
 a78:	6398                	ld	a4,0(a5)
 a7a:	00e6e463          	bltu	a3,a4,a82 <free+0x4a>
 a7e:	fee7eae3          	bltu	a5,a4,a72 <free+0x3a>
 a82:	ff852583          	lw	a1,-8(a0)
 a86:	6390                	ld	a2,0(a5)
 a88:	02059813          	slli	a6,a1,0x20
 a8c:	01c85713          	srli	a4,a6,0x1c
 a90:	9736                	add	a4,a4,a3
 a92:	fae60de3          	beq	a2,a4,a4c <free+0x14>
 a96:	fec53823          	sd	a2,-16(a0)
 a9a:	4790                	lw	a2,8(a5)
 a9c:	02061593          	slli	a1,a2,0x20
 aa0:	01c5d713          	srli	a4,a1,0x1c
 aa4:	973e                	add	a4,a4,a5
 aa6:	fae68ae3          	beq	a3,a4,a5a <free+0x22>
 aaa:	e394                	sd	a3,0(a5)
 aac:	00001717          	auipc	a4,0x1
 ab0:	56f73623          	sd	a5,1388(a4) # 2018 <freep>
 ab4:	6422                	ld	s0,8(sp)
 ab6:	0141                	addi	sp,sp,16
 ab8:	8082                	ret

0000000000000aba <malloc>:
 aba:	7139                	addi	sp,sp,-64
 abc:	fc06                	sd	ra,56(sp)
 abe:	f822                	sd	s0,48(sp)
 ac0:	f426                	sd	s1,40(sp)
 ac2:	ec4e                	sd	s3,24(sp)
 ac4:	0080                	addi	s0,sp,64
 ac6:	02051493          	slli	s1,a0,0x20
 aca:	9081                	srli	s1,s1,0x20
 acc:	04bd                	addi	s1,s1,15
 ace:	8091                	srli	s1,s1,0x4
 ad0:	0014899b          	addiw	s3,s1,1
 ad4:	0485                	addi	s1,s1,1
 ad6:	00001517          	auipc	a0,0x1
 ada:	54253503          	ld	a0,1346(a0) # 2018 <freep>
 ade:	c915                	beqz	a0,b12 <malloc+0x58>
 ae0:	611c                	ld	a5,0(a0)
 ae2:	4798                	lw	a4,8(a5)
 ae4:	08977a63          	bgeu	a4,s1,b78 <malloc+0xbe>
 ae8:	f04a                	sd	s2,32(sp)
 aea:	e852                	sd	s4,16(sp)
 aec:	e456                	sd	s5,8(sp)
 aee:	e05a                	sd	s6,0(sp)
 af0:	8a4e                	mv	s4,s3
 af2:	0009871b          	sext.w	a4,s3
 af6:	6685                	lui	a3,0x1
 af8:	00d77363          	bgeu	a4,a3,afe <malloc+0x44>
 afc:	6a05                	lui	s4,0x1
 afe:	000a0b1b          	sext.w	s6,s4
 b02:	004a1a1b          	slliw	s4,s4,0x4
 b06:	00001917          	auipc	s2,0x1
 b0a:	51290913          	addi	s2,s2,1298 # 2018 <freep>
 b0e:	5afd                	li	s5,-1
 b10:	a081                	j	b50 <malloc+0x96>
 b12:	f04a                	sd	s2,32(sp)
 b14:	e852                	sd	s4,16(sp)
 b16:	e456                	sd	s5,8(sp)
 b18:	e05a                	sd	s6,0(sp)
 b1a:	0000c797          	auipc	a5,0xc
 b1e:	9b678793          	addi	a5,a5,-1610 # c4d0 <base>
 b22:	00001717          	auipc	a4,0x1
 b26:	4ef73b23          	sd	a5,1270(a4) # 2018 <freep>
 b2a:	e39c                	sd	a5,0(a5)
 b2c:	0007a423          	sw	zero,8(a5)
 b30:	b7c1                	j	af0 <malloc+0x36>
 b32:	6398                	ld	a4,0(a5)
 b34:	e118                	sd	a4,0(a0)
 b36:	a8a9                	j	b90 <malloc+0xd6>
 b38:	01652423          	sw	s6,8(a0)
 b3c:	0541                	addi	a0,a0,16
 b3e:	efbff0ef          	jal	a38 <free>
 b42:	00093503          	ld	a0,0(s2)
 b46:	c12d                	beqz	a0,ba8 <malloc+0xee>
 b48:	611c                	ld	a5,0(a0)
 b4a:	4798                	lw	a4,8(a5)
 b4c:	02977263          	bgeu	a4,s1,b70 <malloc+0xb6>
 b50:	00093703          	ld	a4,0(s2)
 b54:	853e                	mv	a0,a5
 b56:	fef719e3          	bne	a4,a5,b48 <malloc+0x8e>
 b5a:	8552                	mv	a0,s4
 b5c:	a47ff0ef          	jal	5a2 <sbrk>
 b60:	fd551ce3          	bne	a0,s5,b38 <malloc+0x7e>
 b64:	4501                	li	a0,0
 b66:	7902                	ld	s2,32(sp)
 b68:	6a42                	ld	s4,16(sp)
 b6a:	6aa2                	ld	s5,8(sp)
 b6c:	6b02                	ld	s6,0(sp)
 b6e:	a03d                	j	b9c <malloc+0xe2>
 b70:	7902                	ld	s2,32(sp)
 b72:	6a42                	ld	s4,16(sp)
 b74:	6aa2                	ld	s5,8(sp)
 b76:	6b02                	ld	s6,0(sp)
 b78:	fae48de3          	beq	s1,a4,b32 <malloc+0x78>
 b7c:	4137073b          	subw	a4,a4,s3
 b80:	c798                	sw	a4,8(a5)
 b82:	02071693          	slli	a3,a4,0x20
 b86:	01c6d713          	srli	a4,a3,0x1c
 b8a:	97ba                	add	a5,a5,a4
 b8c:	0137a423          	sw	s3,8(a5)
 b90:	00001717          	auipc	a4,0x1
 b94:	48a73423          	sd	a0,1160(a4) # 2018 <freep>
 b98:	01078513          	addi	a0,a5,16
 b9c:	70e2                	ld	ra,56(sp)
 b9e:	7442                	ld	s0,48(sp)
 ba0:	74a2                	ld	s1,40(sp)
 ba2:	69e2                	ld	s3,24(sp)
 ba4:	6121                	addi	sp,sp,64
 ba6:	8082                	ret
 ba8:	7902                	ld	s2,32(sp)
 baa:	6a42                	ld	s4,16(sp)
 bac:	6aa2                	ld	s5,8(sp)
 bae:	6b02                	ld	s6,0(sp)
 bb0:	b7f5                	j	b9c <malloc+0xe2>
	...

0000000000000bb4 <switch_context>:
 bb4:	e100                	sd	s0,0(a0)
 bb6:	e504                	sd	s1,8(a0)
 bb8:	01253823          	sd	s2,16(a0)
 bbc:	01353c23          	sd	s3,24(a0)
 bc0:	03453023          	sd	s4,32(a0)
 bc4:	03553423          	sd	s5,40(a0)
 bc8:	03653823          	sd	s6,48(a0)
 bcc:	03753c23          	sd	s7,56(a0)
 bd0:	05853023          	sd	s8,64(a0)
 bd4:	05953423          	sd	s9,72(a0)
 bd8:	05a53823          	sd	s10,80(a0)
 bdc:	05b53c23          	sd	s11,88(a0)
 be0:	06153023          	sd	ra,96(a0)
 be4:	06253423          	sd	sp,104(a0)
 be8:	6180                	ld	s0,0(a1)
 bea:	6584                	ld	s1,8(a1)
 bec:	0105b903          	ld	s2,16(a1)
 bf0:	0185b983          	ld	s3,24(a1)
 bf4:	0205ba03          	ld	s4,32(a1)
 bf8:	0285ba83          	ld	s5,40(a1)
 bfc:	0305bb03          	ld	s6,48(a1)
 c00:	0385bb83          	ld	s7,56(a1)
 c04:	0405bc03          	ld	s8,64(a1)
 c08:	0485bc83          	ld	s9,72(a1)
 c0c:	0505bd03          	ld	s10,80(a1)
 c10:	0585bd83          	ld	s11,88(a1)
 c14:	0605b083          	ld	ra,96(a1)
 c18:	0685b103          	ld	sp,104(a1)
 c1c:	8082                	ret
