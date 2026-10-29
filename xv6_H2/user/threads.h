#ifndef THREADS_H
#define THREADS_H

// Aca no defino el enum del thread ya que el compilador necesita la defincion completa del enum apenas se declara y como la idea es que la estructura del enum sea privada la debo hacer en el .c

typedef struct Thread Thread;

// En la tarea pone que la función recibira como parametro la función a ejecutar y ya esta, asi que asumo no tengo que considerar que esta funcion reciba parametros
// también en lo que dice la pauta hay que hacer para probar el fnucionamiento de las hebras, no hace referencia a que la función deba retornar algo, asi que
// pondre que retorna void ()
void thread_create(void funcion(void));
void thread_init(void);
void thread_schedule(void);
void thread_yield(void);

#endif
