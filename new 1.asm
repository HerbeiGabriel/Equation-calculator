bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...m * 9 - n / 7 + p, having the following data types: p - quadword, n - word, m - byte
    p dq 3
    n dw 7
    m db 1
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al, byte[m]
        mov bl, 9
        imul bl
        mov bx, ax ;bx=m*9
        mov ax, word[n]
        mov cl, 7
        idiv cl
        movsx ax, al
        sub bx, ax; bx=m*9-n/7
        mov eax, [p+0]
        mov edx, [p+4]
        movsx ebx, bx
        add eax, ebx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
