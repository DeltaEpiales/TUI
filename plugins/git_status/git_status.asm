; Git Status Plugin for AssemblIDE
; Pure x86-64 NASM Assembly
bits 64
default rel

section .data
    git_branch_str db ' (main*)', 0

section .text
global Plugin_GitStatus_Init
global Plugin_GitStatus_GetBranch

Plugin_GitStatus_Init:
    push rbp
    mov rbp, rsp
    ; Initialization hook
    mov rax, 1
    pop rbp
    ret

Plugin_GitStatus_GetBranch:
    push rbp
    mov rbp, rsp
    lea rax, [git_branch_str]
    pop rbp
    ret
