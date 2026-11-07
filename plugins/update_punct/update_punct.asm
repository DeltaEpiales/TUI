; Auto-converted Native x86-64 NASM Module from update_punct.py
; Follows Microsoft x64 fastcall ABI: RCX, RDX, R8, R9, [RSP+32...]
bits 64
default rel

section .text
global Plugin_update_punct_Run
Plugin_update_punct_Run:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov rax, 1
    add rsp, 32
    pop rbp
    ret
