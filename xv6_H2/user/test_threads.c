#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "threads.c"

void
tarea_generica()
{
  int id = hebra_actual - thread_pool;
  int suma = id;

  for (int i = 1; i <= 5; i++) {
    printf("Hebra %d - Iteracion %d\n", id, i);
    suma++;
    thread_yield();
  }
  printf("Hebra %d termino su trabajo. la suma tiene el valor de: %d \n", id,
         suma);
  thread_exit();
}

int
main(int argc, char *argv[])
{

  // Inicialzación
  thread_init();

  // Crea la cantidad de hebras - 1, ya que la 0 es el main
  for (int i = 1; i < MAX_THREADS; i++) {
    // Se le pasa la tarea
    thread_create(tarea_generica);
  }

  // Una vez que todas están listas se llama al planificador que se encarga de irlas asignando de forma justa
  thread_schedule();

  printf("Todas las hebras finalizaron.\n");
  exit(0);
}
