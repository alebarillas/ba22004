_EXIT  equ 1
_READ  equ 3
_WRITE equ 4
STDIN  equ 0
STDOUT equ 1

section .data
    msg1 db "Ingrese un numero del 0 al 9: ", 0xA, 0xD
    len1 equ $- msg1 
    msg2 db "Ingrese otro numero del 0 al 9: ", 0xA, 0xD 
    len2 equ $- msg2 
    msg3 db "Ingresse un tercer numero del 0 al 9: ", 0xA, 0xD 
    len3 equ $- msg3
    msg4 db "La resta es: ", 0xA, 0xD
    len4 equ $- msg4

section .bss
    num1 resb 2 
    num2 resb 2 
    num3 resb 2
    res resb 1    

section .text
    global _start    

_start:     
     ; limpiando registros
   mov eax,0
   mov ebx,0
   mov ecx,0
   mov edx,0

    ; Solicitar primer número - BA22004
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

    ; Solicitar segundo número
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

    ; Solicitar tercer número
    mov eax, _WRITE         
    mov ebx, STDOUT         
    mov ecx, msg3          
    mov edx, len3         
    int 0x80

    mov eax, _READ  
    mov ebx, STDIN  
    mov ecx, num3 
    mov edx, 2
    int 0x80

    ; Mostrar mensaje de resultado
    mov eax, _WRITE         
    mov ebx, STDOUT         
    mov ecx, msg4          
    mov edx, len4         
    int 0x80

    ; Convertir y restar números
    movzx ax, byte [num1]   ; Cargar primer número en AX y convertir a entero de 16 bits
    sub ax, '0'             ; Convertir carácter ASCII a número

    movzx bx, byte [num2]   ; Cargar segundo número en BX y convertir a entero de 16 bits
    sub bx, '0'             ; Convertir carácter ASCII a número

    movzx cx, byte [num3]   ; Cargar tercer número en CX y convertir a entero de 16 bits
    sub cx, '0'             ; Convertir carácter ASCII a número

    ; Restar bx y cx de ax
    sub ax, bx
    sub ax, cx

    ; Convertir el resultado a carácter ASCII
    add ax, '0'

    ; Guardar el resultado en res
    mov [res], al

    ; Imprimir el resultado
    mov eax, _WRITE        
    mov ebx, STDOUT
    mov ecx, res         
    mov edx, 1        
    int 0x80

    ; Salir del programa
    mov eax, _EXIT   
    xor ebx, ebx 
    int 0x80
