; The prime factors of 13195 are 5, 7, 13 and 29.

; What is the largest prime factor of the number 600851475143 ?

global _start
extern _printNumber

; Macro for finding if a number is a factor
; Arguments
;   - <Factor> <Number>
%macro factor 2
    push rax
    push rbx
    push rcx
    push rdx

    mov rdx, 0 ; Resets remainder
    mov rax, %2
    mov rbx, %1
    div rbx

    cmp rdx, 0

    pop rdx
    pop rcx
    pop rbx
    pop rax
%endmacro

_start:

    mov rax, 600851475143
    mov rbx, 2
    mov rcx, 0

    loop:
        ; Finishes when rax becomes 1
        ; rax will be divided over the loop
        cmp rax, 1
        je finish

        factor rbx, rax
        je .is_factor
        jmp .is_not_factor

        .is_factor:
            div rbx

            cmp rbx, rcx
            jg .bigger_divider

            mov rbx, 2
            jmp loop

            ; Keeps track of the biggest divider so far
            .bigger_divider:

                ; Saves rbx as the biggest divider
                mov rcx, rbx

                mov rbx, 2
                jmp loop


        .is_not_factor:
            inc rbx
            jmp loop

    finish:
        mov rax, rcx
        call _printNumber

    mov rbx, 0
    mov rax, 1
    int 80h
