#include <stdio.h>
#include <string.h>

unsigned char shellcode[] = "[insira seu shellcode aqui]";


main(int argc, char *argv[])
{
  int (*ret)() = (int(*)())shellcode;

  ret(); 
}
