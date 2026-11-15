// Physical memory allocator, for user processes,
// kernel stacks, page-table pages,
// and pipe buffers. Allocates whole 4096-byte pages.

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "defs.h"

void freerange(void *pa_start, void *pa_end);

extern char end[]; // first address after kernel.
                   // defined by kernel.ld.

struct run {
  struct run *next;
};

// Se crea una esctructura anonima (un struct que solo se puede instanciar inmediatamente despues de la definicion,
// ya que al no tener nombre no se puede referenciar despues)
// kmem el el administrador global de memoria fisica del sistema operativo
// free list es la lista de paginas libres de la memoria, necesita un lock para que no puedan 2 procesos pedir memoria
// al mismo tiempo

struct {
  //PHYSTOP es como la direccion final de la RAM, esto funciona ya que simplemente desde el uso del usuario se ignoraran
  //los indices que corresponden al kernel (si no se ignoraran seria un problema ya que estos no estarian correctamente
  //contabilizados ya que el kernel ya se "definio" para el punto donde se estaria instanciando kmem)
  int pag_n_references[PHYSTOP / PGSIZE];
  struct spinlock lock;
  struct run *freelist;
} kmem;

// Aca escribo una funcion para aumentar el numero de referencias a una pagina desde el struct "kmem", pero sin la necesidad
// de exportar kmem a otros archivos y asi manteniendolo privado en este

int
increase_pagref(uint64 pag_address)
{
  if (pag_address % PGSIZE != 0 || pag_address < (uint64)end ||
      pag_address >= PHYSTOP) {
    return 1;
  }
  acquire(&kmem.lock);
  kmem.pag_n_references[pag_address / PGSIZE]++;
  release(&kmem.lock);
  return 0;
}

// Una forma de resolver lo de las referencias es aca inicalizar un candado de las referencias
void
kinit()
{
  initlock(&kmem.lock, "kmem");
  freerange(end, (void *)PHYSTOP);
}

// Libera un rango de memoria
void
freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char *)PGROUNDUP((uint64)pa_start);
  for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE) {
    // se inicializa con 1 ya que kfree es la funcion que se llama para liberar una pagina cuando un proceso deja
    // de usarla y le restara 1 al valor de pag_n_references
    kmem.pag_n_references[(uint64)p / PGSIZE] = 1;
    kfree(p);
  }
}

// Free the page of physical memory pointed at by pa,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
  struct run *r;

  if (((uint64)pa % PGSIZE) != 0 || (char *)pa < end || (uint64)pa >= PHYSTOP) {
    panic("kfree");
  }
  // Un proceso que ocupa cierta pagina llama a esta funcion por cada pagina, entonces hay que indicar que esas paginas
  // pierden esa referencia
  acquire(&kmem.lock);
  kmem.pag_n_references[(uint64)pa / PGSIZE]--;
  int refs = kmem.pag_n_references[(uint64)pa / PGSIZE];
  release(&kmem.lock);

  //Si ya no quedan referencias hacia esta pagina, se libera
  if (refs <= 0) {
    // Fill with junk to catch dangling refs.
    memset(pa, 1, PGSIZE);
    acquire(&kmem.lock);
    r = (struct run *)pa;
    r->next = kmem.freelist;
    kmem.freelist = r;
    release(&kmem.lock);
  }
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
  struct run *r;

  acquire(&kmem.lock);
  r = kmem.freelist;
  // cuando tomo una pagina libre de la memoria y la asigno, esta empieza con 1 referencias a ella
  if (r) {
    kmem.pag_n_references[(uint64)r / PGSIZE] = 1;
    kmem.freelist = r->next;
  }
  release(&kmem.lock);

  if (r)
    memset((char *)r, 5, PGSIZE); // fill with junk
  return (void *)r;
}
