; >>> Challenge
; If we list all the natural numbers below 10 that are multiples 
; of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
; 
; Find the sum of all the multiples of 3 or 5 below 1000.

section .bss

    digitSpace resb 100 ; Allows printing of 100 digits
    digitSpacePos resb 8

section .text

    global _start

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

; Arguments
;   EAX - Message to count length (Need to save message before)
; Return
;   EAX - Message length
len:
    ; This code loops up until the end of the string is found
    ; it uses pointer arithmatic to achive this
    cmp byte [eax], 0
    jz len_finish
    inc eax
    jmp len

    len_finish:
        
        ; Works out the difference between the values
        sub eax, ebx

        ; Brings the program back to the position of the call
        ret

; Arguments
;   EAX - String to print
write:

    push rbx
    push rcx
    push rdx

    ; Dynamic len calc 
    mov ebx, eax

    call len
    
    mov edx, eax
    mov ecx, ebx
    mov ebx, 1
    mov eax, 4
    int 80h

    write_fin:

        pop rdx
        pop rcx
        pop rbx

        ret

; Arguments:
;   EAX - Number to print
_printNumber:
    mov rcx, digitSpace
    mov rbx, 10 ; Newline
    mov [rcx], rbx
    inc rcx
    mov [digitSpacePos], rcx
 
    _printNumberLoop:

        ; This section works beacuse it trims the
        ; last digit off by diving by 10.
        ; The remainder will be found in RDX

        mov rdx, 0 ; Needs to be reset to not alter divison
        mov rbx, 10
        div rbx
        push rax
        add rdx, 48 ; Converts to char
    
        mov rcx, [digitSpacePos]
        mov [rcx], dl
        inc rcx
        mov [digitSpacePos], rcx
    
        pop rax
        cmp rax, 0 ; When the division has finished
        jne _printNumberLoop
    
    _printNumberLoop2:
        mov rcx, [digitSpacePos]
    
        ; print call
        mov rax, 1
        mov rdi, 1
        mov rsi, rcx
        mov rdx, 1
        syscall
    
        mov rcx, [digitSpacePos]
        dec rcx
        mov [digitSpacePos], rcx
    
        cmp rcx, digitSpace
        jge _printNumberLoop2
    
        ret

