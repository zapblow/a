# Projeto Socket em um Shellcode

### O que é um shellcode?

Em segurança da informação, um shellcode é um trecho de código que é usado durante a exploração de alguma vulnerabilidade.

É chamado shellcode por normalmente envolver a abertura de uma shell durante a execução, mas não é necessariamente limitado a isso.

Esse tipo clássico de shellcode é interessante quando há um programa rodando em uma porta de uma máquina na rede que você pode interagir ou quando esse programa possui permissões maiores que a do seu usuário atual, pois ao abrir uma shell com seu shellcode, você terá acesso à maquina com possivelmente as mesmas permissões desse tal programa. Portanto você pode conseguir acesso a uma máquina ou realizar uma escalada de privilégios.

Nesse projeto o codigo em assembly é basicamente um socket simples.

Para criarmos um shellcode, primeiramente precisamos criar um código em assembly.
Em seguida compilamos o codigo e abrimos o executável em um debugger. Assim podemos ver os bytes que precisamos para montar o shellcode.


![Pasted image 20220620033644](https://user-images.githubusercontent.com/59076746/174547182-500b5f6f-5c1d-4525-9844-b60aa8c85998.png)



Assim temos os bytes:

``` 
\x31\xc0\x31\xdb\x31\xff\x31\xf6\x6a\x06\x6a\x01\x6a\x02\x89\xe1\xbb\x01\x00\x00\x00\xb8\x66\x00\x00\x00\xcd\x80\x89\xc7\x69\x00\x66\x68\x11\x5c\x66\x6a\x02\x89\xe1\x6a\x10\x51\x57\x89\xe1\xbb\x02\x00\x00\x00\xb8\x66\x00\x00\x00\xcd\x80\x6a\x01\x57\x89\xe1\xbb\x04\x00\x00\x00\xb8\x66\x00\x00\x00\xcd\x80\x6a\x00\x6a\x00\x57\x89\xe1\xbb\x05\x00\x00\x00\xb8\x66\x00\x00\x00\xcd\x80
```

E podemos passar esses bytes para uma linguagem mais alto nível, como C:

```C
unsigned char shellcode[] = "\x31\xc0\x31\xdb\x31\xff\x31\xf6\x6a\x06\x6a\x01\x6a\x02\x89\xe1\xbb\x01\x00\x00\x00\xb8\x66\x00\x00\x00\xcd\x80\x89\xc7\x69\x00\x66\x68\x11\x5c\x66\x6a\x02\x89\xe1\x6a\x10\x51\x57\x89\xe1\xbb\x02\x00\x00\x00\xb8\x66\x00\x00\x00\xcd\x80\x6a\x01\x57\x89\xe1\xbb\x04\x00\x00\x00\xb8\x66\x00\x00\x00\xcd\x80\x6a\x00\x6a\x00\x57\x89\xe1\xbb\x05\x00\x00\x00\xb8\x66\x00\x00\x00\xcd\x80";

main(int argc, char *argv[])
{
  int (*ret)() = (int(*)())shellcode;

  ret();
}

```

Ao compilar e executar esse código C temos um socket inicializado.

Em um uso real, o shellcode quase sempre é usado junto a um exploit (codigo que explora alguma falha).

<br />
<br />
<small>Fontes: https://gitbook.ganeshicmc.com/pwning/shellcode, https://en.wikipedia.org/wiki/Shellcode, https://www.exploit-db.com/shellcodes</small>
