#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h" // Este es el archivo que tiene la definicion de dirent, cosa que yo solo tenga que referenciarla
#include "kernel/fcntl.h" // Para poder abrir el archivo con read only (O_RDONLY)

struct dirent
  archivo_actual; // deberia ser un puntero al archivo que este leyendo en este momento

int
main(int argc, char *argv[])
{
  // Estoy asumiendo que se usa la ruta relativa
  if (argc < 3) {
    printf("find ./ruta_relativa archivo_a_buscar\n");
    exit(1);
  }

  // argv[0] es el nombre del propio ejecutable
  // argv[1] es el primer argumento real que pasas en la terminal

  exit(0);
}

//como es solo para leer la cadena de caracteres, se usa const
void
buscar_archivo(const char *ruta_actual, char *archivo_a_buscar)
{
  int len_ruta_actual = strlen(ruta_actual);
  int len_nombre_archivo = strlen(archivo_a_buscar);
  int file_descriptor = open(ruta_actual, O_RDONLY);

  // read deuelve la cantidad de bytes que logro leer con exito
  while (read(file_descriptor, &archivo_actual, sizeof(archivo_actual)) ==
         sizeof(archivo_actual)) {

    if (archivo_actual.name == archivo_a_buscar) {
      char dest[]
        // Copiar la primera cadena
        safestrcpy(dest, s1, sizeof(dest));

      // Buscar el final de la cadena de destino
      int len = strlen(dest);

      // Concatenar la segunda cadena de forma segura
      safestrcpy(dest + len, s2, sizeof(dest) - len);
    }
    printf("%s\n", archivo_actual.name);
  }
}
