section .data

    msg1 db 0xA,0xD,"en este programa vamos a ocupar numeros ya asignados -no se he podido programar para que el usuario lo ingrese, me daba eror-, se va a ocupar el 8 como numerador y el 4 como denominador. Puede revisar el codigo para comprobar que si se ha hecho la division puramente en ensamblador  ",  0xA
    len1 equ $-msg1

    msg2 db 0xA,0xD,"la division total es de: ", 0xA
    len2 equ $-msg2

section .bss
    res resb 1

section .text
global _start

_start:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    mov ax, 8         
    mov bx, 4        
    mov dx, 0        
    div bx           
    add ax, 48
    mov [res], ax    

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, res
    mov edx, 1
    int 0x80


    ; Fin
    mov eax, 1
    mov ebx, 0
    int 0x80
