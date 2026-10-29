#include "threads.h"
#include "kernel/types.h"
#include "user/user.h"
//#include <stdlib.h>

static unsigned long rand_state = 1;

void srand(unsigned int seed) {
    rand_state = seed;
}

int rand(void) {
    rand_state = rand_state * 1103515245 + 12345;
    return (unsigned int)(rand_state / 65536) % 32768;
}

// Puntero para almacenar la direccion de memoria para saber la hebra que se ejecuta en este instante, sirve para 
// identificar que hebra de la pool es la que se está ejecutando y poder hacer 
struct Thread* hebra_actual;
#define MAX_THREADS 10

// con estos estados y el proposito del ejercicio probablemente esta bien
enum EstadoThread {
  LIBRE,
  LISTA_PARA_CORRER,
  CORRIENDO
};

struct Thread {
  enum EstadoThread estado_thread;
  // El stack en este codigo solo se ocupa como para darle el inicio desde donde empezara a trabajar el program counter, pero a partir de ahi
  // el propio procesador se preocupara de mover el program counter a partir de las instrucciones que reciba (yo solo le doy el terreno al sp)
  char stack[4096]; //Basta con que sea un arreglo simple, (importante usar char en vez de char* ya que sino cada casilla ocupa 8bytes en vez de 1)

// Solo me tengo que preocupar de guardar lo que esta en los registros s0-s11, ra, sp ya que estos son los unicos que el compilador
// gcc no se encarga de guardar en el stack al hacer una llamada a una funcion. Los registros "t" y "a" se asume que cada llamada
// los ocupara y "destruira" por ello el compilador se preocupa de guardarlos en el stack para cada llamada
  uint64 s0;
  uint64 s1;
  uint64 s2;
  uint64 s3;
  uint64 s4;
  uint64 s5;
  uint64 s6;
  uint64 s7;
  uint64 s8;
  uint64 s9;
  uint64 s10;
  uint64 s11;
  // Para este caso se ocupa el registro "ra" en conjunto con la instruccion "ret" (return) para dirigir la ejecución del programa hacia donde se quiera
  uint64 ra;
  uint64 sp;
};

// Los parametros del thread se rellenaran automaticamente con ceros o vacios, y el estado_thread sera LIBRE por defecto ya que es el primero en definirse en el enum
struct Thread thread_pool[MAX_THREADS];



// No puedo crear un stack dentro del contexto de la funcion, ya que en el momento que retorne desde esta se borrara y luego dara un
// segmentation fault al referenciar a ese stack
void thread_create(void funcion(void)) {
  for (int i = 0; i < MAX_THREADS; i++) {
    // A las hebras no les debo copiar el valor de los s0-s11 ni del stack inicialmente ya que estas ya que esats como que unicamente se inician para realizar
    // una función, no se les pasa el contexto de donde se llamaron originalmente o algo asi
    if (thread_pool[i].estado_thread == LIBRE) {
      thread_pool[i].ra = (uint64)funcion; // por defecto el nombre de la funcion es la direccion de memoria fisica donde comienzan las instrucciones de esta
      // el stack crece hacia abajo asi que el puntero del inicio del stack debe ser al final del arreglo original
      uint64 comienzo_stack = (uint64)(thread_pool[i].stack) + (uint64)(sizeof(char)) * 4096;
      thread_pool[i].sp = comienzo_stack;
      thread_pool[i].estado_thread = LISTA_PARA_CORRER;
      // no hice cambios al registro "ra" por lo que se puede retornar con normalidad
      return;
    }
  }
  printf("No hay hebras disponibles");
}


// La unica función que cumple es asignar la "hebra original" del proceso a la lista de thread_pool
// Notar que la hebra original ignorara el stack definido en su struct, ya que realmente su "sp" apuntara a donde este apuntando orignalmente el "sp" del
// proceso que probablemente es despues de la declaracion de todas las hebras y stacks respectivos
// Ademas esta función probablemente sirve para argumentar el paso 4.1 de la pauta
void thread_init() {
  srand(uptime());
  thread_pool[0].estado_thread = CORRIENDO;  
  hebra_actual = &thread_pool[0];
}

// el puntero void* sirve como un puntero a cualquier tipo de dato
extern void switch_context(void* thread_dnd_guardar_context_actual, void* thread_a_ejecutar);




void thread_schedule() {
  // Se copia el puntero de la hebra que se está ejectuando en este momento en "hebra_reemplazada"
  // esto sirve para poder guardar el contexto de la hebra que se está ejecutando actualmente
  // entonces como la función se RISC V reemplaza los registros de las hebras, si no se clonara no se podría
  // guardar cual fue la hebra que se estaba ejecutando antes
    struct Thread* hebra_reemplazada = hebra_actual;
    int largo = MAX_THREADS;
    
    // aritmetica de punteros para saber el indice de la hebra que se va a reemplazar
    int id_reemplazada = hebra_actual - thread_pool;
    int indicesFinales[largo];
    int aux[largo - 1];
    
    // Se filtra
    // En aux se guardan todos los indices diferentes al de la hebra que se va a reemplazar
    int index_aux = 0;
    for (int i = 0; i < largo; i++) {
        if (i != id_reemplazada) {
            aux[index_aux] = i;
            index_aux++;
        }
    }

    // Se elige indice aleatorio j.
    // Se recorre en orden inverso y se intercambia el valor del indice final i con alguno de una posicion j
    int hebras_disp = MAX_THREADS - 1;
    for (int i = hebras_disp - 1; i > 0; i--) {
        // rand() numero aleatorio, al hacer modulo da un rango entre 0 e i
        int j = rand() % (i + 1);
        int temp = aux[i];
        aux[i] = aux[j];
        aux[j] = temp;
    }

    // Se guardan todos los valores de los indices desordenados en los indices finales
    for (int i = 0; i < hebras_disp; i++) {
        indicesFinales[i] = aux[i];
    }

    // Se agrega el indice de la hebra reemplazada al final 
    indicesFinales[MAX_THREADS - 1] = id_reemplazada;

    // Aqui se recorren los indices random, se guarda el puntero de la hebra que se va a ejecutar, se cambia su estado
    // y despues se hace el cambio de contexto
    for (int i = 0; i < MAX_THREADS; i++) {
        int indiceRandom = indicesFinales[i];
        if (thread_pool[indiceRandom].estado_thread == LISTA_PARA_CORRER) {
            hebra_actual = &thread_pool[indiceRandom];
            hebra_actual->estado_thread = CORRIENDO;
            switch_context(&hebra_reemplazada->s0, &hebra_actual->s0);
            return;
        }
    }
}

// Simplemente cambia el estado de la hebra que lo llame y hace que otra tome la CPU
void thread_yield() {
    hebra_actual->estado_thread = LISTA_PARA_CORRER;
    thread_schedule();
}

void thread_exit() {
    hebra_actual->estado_thread = LIBRE;

    // Ver si hay hebras activas
    int hay_hebras_activas = 0;
    for (int i = 1; i < MAX_THREADS; i++) {
        if (thread_pool[i].estado_thread != LIBRE) {
            hay_hebras_activas = 1;
            break;
        }
    }

    // Esto es para que la hebra principal pueda volver a tomar el control cuando todas las hebras
    // terminen de ejecutar su función
    if (!hay_hebras_activas) {
        thread_pool[0].estado_thread = LISTA_PARA_CORRER;
    }
    thread_schedule();
}
