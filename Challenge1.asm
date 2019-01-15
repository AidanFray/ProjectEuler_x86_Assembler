; >>> Challenge
; If we list all the natural numbers below 10 that are multiples 
; of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
; 
; Find the sum of all the multiples of 3 or 5 below 1000.
global _start
extern _printNumber

_start:

    ; Running total for the calulcation
    mov rcx, 0

    ; Loop counter
    mov rbx, 0

    repeat:
    
        ; Loop range
        cmp rbx, 999
        je fin
        inc rbx

        ; Division command:
        ;   'div X' == rax/X

        ; Checks if divisible by 3
        push rbx
        mov rdx, 0 ; Reset remainder
        mov rax, rbx
        mov rbx, 3
        div rbx
        pop rbx

        cmp rdx, 0
        je add_result

        ; Checks if divisible by 5
        push rbx
        mov rdx, 0 ; Reset remainder
        mov rax, rbx
        mov rbx, 5
        div rbx
        pop rbx

        cmp rdx, 0
        je add_result

        jmp repeat

        add_result: 
            add rcx, rbx 
            jmp repeat

    fin:
        ; TODO - Print final value
        mov rax, rcx
        call _printNumber

    ; exit(int code)
    mov ebx, 0
    mov eax, 1
    int 80h

