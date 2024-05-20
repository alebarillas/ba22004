_EXIT  equ 1
_READ  equ 3
_WRITE equ 4
STDIN  equ 0
STDOUT equ 1
;ba22004
section .data
    msg1 db "Ingrese el primer numero (0-9): ", 0xA, 0xD
    len1 equ $-msg1
    msg2 db "Ingrese el segundo numero (0-9): ", 0xA, 0xD
    len2 equ $-msg2
    msg3 db "El resultado de la multiplicacion es: ", 0xA, 0xD
    len3 equ $-msg3

section .bss
    num1 resb 2     
    num2 resb 2     
    result resb 3   

section .text
    global _start

_start:
    ; Limpiando registros
   mov eax,0
   mov ebx,0
   mov ecx,0
   mov edx,0
   
    ; Solicitar el primer número
    mov eax, _WRITE
    mov ebx, STDOUT
    mov ecx, msg1
    mov edx, len1
    int 0x80

    mov eax, _READ
    mov ebx, STDIN
    mov ecx, num1
    mov edx, 2
    int 0x80

    ; Solicitar el segundo número
    mov eax, _WRITE
    mov ebx, STDOUT
    mov ecx, msg2
    mov edx, len2
    int 0x80

    mov eax, _READ
    mov ebx, STDIN
    mov ecx, num2
    mov edx, 2
    int 0x80

    ; se resta el caracter cero en  ascii '0' para covertir a numero decimal
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'

    ; Realizar la multiplicación
    mul bl ; al = al * bl

    ; Convertir el resultado a cadena y mostrarlo
    add al, '0'
    mov [result], al
    mov byte [result+1], 0xA ; Agregar nueva línea
    mov byte [result+2], 0 ; Terminador nulo

    ; Mostrar mensaje del resultado
    mov eax, _WRITE
    mov ebx, STDOUT
    mov ecx, msg3
    mov edx, len3
    int 0x80

    ; Mostrar el resultado
    mov eax, _WRITE
    mov ebx, STDOUT
    mov ecx, result
    mov edx, 3
    int 0x80

    ; Salir del programa
    mov eax, _EXIT
    xor ebx, ebx
    int 0x80
