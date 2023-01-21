section .data
    buffer: times 10 db 0
    input_prompt db "Enter a number: ",0
    output_prompt db "You entered: ",0
    error_prompt db "Invalid input. Only numbers are allowed", 0

section .text
    global _start

_start:
    mov edx, input_prompt_len
    mov ecx, input_prompt
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, 10
    mov ecx, buffer
    mov ebx, 0
    mov eax, 3
    int 0x80

    mov eax, buffer
    call check_valid_number

    mov edx, buffer_len
    mov ecx, buffer
    mov ebx, 1
    mov eax, 4
    int 0x80
    mov eax, 1
    xor ebx, ebx
    int 0x80

check_valid_number:
    xor ebx, ebx
    xor ecx, ecx

check_valid_number_loop:
    mov bl, [eax]
    cmp bl, '0'
    jl invalid_input
    cmp bl, '9'
    jg invalid_input
    inc eax
    inc ecx
    cmp byte [eax], 0
    jne check_valid_number_loop
    mov edx, ecx
    ret

invalid_input:
    mov edx, error_prompt_len
    mov ecx, error_prompt
    mov ebx, 1
    mov eax, 4
    int 0x80
    jmp _start
