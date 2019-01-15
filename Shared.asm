section .bss

    digitSpace resb 100 ; Allows printing of 100 digits
    digitSpacePos resb 8

section .text

    ; Prints a value to stdout
    global _printNumber

    ; Prints a string to stdout
    global _writeString

; Arguments:
;   EAX - Number to print
_printNumber:

    push rax
    push rbx
    push rcx
    push rdx

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
    
        pop rdx
        pop rcx
        pop rbx
        pop rax

        ret


; Arguments
;   EAX - String to print
_writeString:

    push rax
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
        pop rax

        ret

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
