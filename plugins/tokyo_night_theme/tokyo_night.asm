; Tokyo Night Theme Module
bits 64
default rel

section .data
    global TN_BG_COLOR
    global TN_GUTTER_COLOR
    global TN_TEXT_COLOR
    global TN_KEYWORD_COLOR
    global TN_NUMBER_COLOR
    global TN_COMMENT_COLOR

    TN_BG_COLOR        dq 0x00191211   ; #111219 (Obsidian)
    TN_GUTTER_COLOR    dq 0x00221614   ; #141622 (Gutter)
    TN_TEXT_COLOR      dq 0x00F0E8E2   ; #E2E8F0 (Off-white)
    TN_KEYWORD_COLOR   dq 0x00F7A27A   ; #7AA2F7 (Tokyo Blue)
    TN_NUMBER_COLOR    dq 0x0068AFE0   ; #E0AF68 (Amber)
    TN_COMMENT_COLOR   dq 0x00895F56   ; #565F89 (Slate)

section .text
global Plugin_Theme_Init

Plugin_Theme_Init:
    push rbp
    mov rbp, rsp
    mov rax, 1
    pop rbp
    ret
