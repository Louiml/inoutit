section .data
    buffer: times 100 db 0 ; buffer to hold user input
    input_prompt db "Enter your input: ",0
    output_prompt db "You entered: ",0

section .text
    global _start

_start:
    mov edx, input_prompt_len
    mov ecx, input_prompt
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, 100
    mov ecx, buffer
    mov ebx, 0
    mov eax, 3
    int 0x80

    mov edx, buffer_len
    mov ecx, buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
