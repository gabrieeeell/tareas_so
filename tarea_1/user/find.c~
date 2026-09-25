#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h" // este es el archivo que tiene la definicion de dirent, cosa que yo solo tenga que referenciarla
#include "kernel/fcntl.h" // para poder abrir el archivo con read only (o_rdonly)

struct dirent
  archivo_actual; // deberia ser un puntero al archivo que este leyendo en este momento

// Este struct lo necesito para guardar la informacion de que tipo es cada archivo
struct stat st;

//hay que asegurarse que el buffer que se ocupe para pegar las cadenas tenga suficiente espacio para ambas
char *
concatenar_cadenas(char *dest, const char *src, int dest_size)
{
  int i = 0;
  int j = 0;

  // buscar el final de la cadena dest
  while (dest[i] != '\0' && i < dest_size - 1) {
    i++;
  }

  // copiar src al final de dest
  while (src[j] != '\0' && i < dest_size - 1) {
    dest[i] = src[j];
    i++;
    j++;
  }

  // asegurar el fin de cadena nulo
  dest[i] = '\0';
  return dest;
}
// hola
//como es solo para leer la cadena de caracteres, se usa const
// clang-format off
void buscar_archivo(char *ruta_actual, char *archivo_a_buscar)
{
  // Es lo que se ocupa para iterar sobre el directorio
  int file_descriptor = open(ruta_actual, O_RDONLY);

  // read deuelve la cantidad de bytes que logro leer con exito
  while (read(file_descriptor, &archivo_actual, sizeof(archivo_actual)) == sizeof(archivo_actual)) {

    // le sumo 2, uno para '/' y otro porciacaso para el '\0'
    char dest[strlen(ruta_actual) + strlen(archivo_actual.name) + 2]; //deberia ser inecesario poner el * al principio ya que al ser un arreglo, debe ser un puntero
    dest[0] = '\0'; // Si declaras pero no incializas una variable en C, esta contiene basura por defecto
    if (strlen(ruta_actual) == 2) {
      ruta_actual[0] = '.';
      ruta_actual[1] = '\0';
    }
    concatenar_cadenas(dest, ruta_actual, sizeof(dest));
    concatenar_cadenas(dest, "/", sizeof(dest));
    concatenar_cadenas(dest, archivo_actual.name, sizeof(dest));

    // El inum == 0, se usa en xv6 para indicar que este directorio es un espacio que el sistema dejo reservado pero que actualmente no contiene ningun archivo realmente
    if (archivo_actual.inum == 0 || strcmp(archivo_actual.name, ".") == 0 || strcmp(archivo_actual.name, "..") == 0) continue; // igual deberia funcionar sin esta linea

    // Supongo que al poner este condicional antes que el que ve si el archivo es una carpeta, esta función también identificara carpetas con el nombre buscado

    if (strcmp(archivo_actual.name,archivo_a_buscar) == 0) { // No se pueden comparar usando == pues son direcciones de memoria
      printf("%s\n", dest);
    }
  
    if (stat(dest, &st) < 0) continue; // aca se saca la informacion del archivo si es que se pudo y si no se salta al siguiente bucle
    
    if (st.type == T_DIR) {
      buscar_archivo(dest, archivo_a_buscar);
    }
  }
}

int
main(int argc, char *argv[])
{
  // estoy asumiendo que se usa la ruta relativa
  if (argc < 3) {
    printf("find ./ruta_relativa archivo_a_buscar\n");
    exit(1);
  }

  buscar_archivo(argv[1], argv[2]);
  // argv[0] es el nombre del propio ejecutable
  // argv[1] es el primer argumento real que pasas en la terminal

  exit(0);
}
