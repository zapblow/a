;       Arquitetura E Organização De Computadores S73        ;
;       Alunos: Gabriel Augusto Daroz e Cristiano Morales    ;
;                                                            ;
;                                                            ;
;                    SOCKETS e Shellcode                     ;


SECTION .text
global  _start

_start:                         ; Inicia os registradores
    xor     eax, eax          
    xor     ebx, ebx
    xor     edi, edi
    xor     esi, esi
 
_socket:
    push    byte 6              ; IPPROTO_TCP
    push    byte 1              ; SOCK_STREAM
    push    byte 2              ; PF_INET
    mov     ecx, esp            ; move o endereço do argumento para ecx
    mov     ebx, 1              ; SOCKET
    mov     eax, 102            ; SYS_SOCKETCALL
    int     80h                 ; chama o kernel
    
_bind:
    mov     edi, eax            ; guarda valor de retorno de SYS_SOCKETCALL para edi
    push    dword 0x00000000    ; endereço ip 0.0.0.0
    push    word 0x5c11         ; porta 4444 em hexadecimal, ordem de byte inversa.
    push    word 2              ; AF_INET
    mov     ecx, esp            ; move o endereço do ponteiro da pilha para ecx
    push    byte 16             ; tamanho dos argumentos
    push    ecx                 ; endereço dos argumentos
    push    edi                 ; file decriptor
    mov     ecx, esp            ; move o enedereço dos argumentos para ecx
    mov     ebx, 2              ; BIND
    mov     eax, 102            ; SYS_SOCKETCALL
    int     80h                 ; chama o kernel
 
_listen:
    push    byte 1              ; argumento de comprimento máximo da fila
    push    edi                 ; file descriptor
    mov     ecx, esp            ; move o endereço dos argumentos para ecx
    mov     ebx, 4              ; LISTEN
    mov     eax, 102            ; SYS_SOCKETCALL
    int     80h                 ; chama o kernel
 
_accept:
    push    byte 0              ; argumento de comprimento de endereço
    push    byte 0              ; argumento de endereço
    push    edi                 ; file decriptor
    mov     ecx, esp            ; move o endereço dos argumentos para ecx
    mov     ebx, 5              ; ACCEPT
    mov     eax, 102            ; SYS_SOCKETCALL
    int     80h                 ; chama o kernel
