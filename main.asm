extern GetTokenInfo
default rel

extern GetModuleHandleA
extern RegisterClassExA
extern CreateWindowExA
extern ShowWindow
extern UpdateWindow
extern GetMessageA
extern TranslateMessage
extern DispatchMessageA
extern DefWindowProcA
extern PostQuitMessage
extern LoadCursorA
extern ExitProcess
extern SendMessageA
extern SetFocus
extern SetForegroundWindow

extern BeginPaint
extern EndPaint
extern TextOutA
extern GetTextExtentPoint32A
extern CreateFontA
extern SelectObject
extern DeleteObject
extern SetTextColor
extern SetBkColor
extern InvalidateRect
extern GetClientRect
extern CreateSolidBrush
extern SetBkMode
extern FillRect
extern CreateProcessA
extern WaitForSingleObject

extern IntersectClipRect
extern SelectClipRgn
extern DrawTextA

extern SetLayeredWindowAttributes
extern CreateCaret
extern SetCaretPos
extern ShowCaret
extern HideCaret
extern DestroyCaret

extern GetOpenFileNameA
extern GetSaveFileNameA
extern CreateFileA
extern ReadFile
extern WriteFile
extern CloseHandle
extern GetFileSize

extern FindFirstFileA
extern FindNextFileA
extern FindClose
extern SetCurrentDirectoryA
extern GetCurrentDirectoryA

extern OpenClipboard
extern EmptyClipboard
extern SetClipboardData
extern GetClipboardData
extern CloseClipboard
extern GlobalAlloc
extern GlobalLock
extern GlobalUnlock
extern GetKeyState

section .data
    className db 'AsmGuiEditor', 0
    windowTitle db 'AssemblIDE - Native Assembly Editor', 0
    fontName db 'Consolas', 0
    searchPattern db '*.*', 0
    
    ; Custom Top Bar Buttons
    btnNew db ' NEW ', 0
    btnOpen db ' OPEN ', 0
    btnSave db ' SAVE ', 0
    btnRun db ' RUN ', 0
    btnOpenDir db ' OPEN DIR ', 0
    btnTerminal db ' TERMINAL ', 0
    btnExit db ' EXIT ', 0
    btnTab1 db ' TAB 1 ', 0
    btnTab2 db ' TAB 2 ', 0

    pyCmd db 'cmd.exe /c "python script.py > run.log 2>&1"', 0
    asmCmd db 'cmd.exe /c "build.bat > run.log 2>&1"', 0
    cCmd db 'cmd.exe /c "gcc script.c -o script.exe && script.exe > run.log 2>&1"', 0
    jsCmd db 'cmd.exe /c "node script.js > run.log 2>&1"', 0
    rsCmd db 'cmd.exe /c "rustc script.rs -o script.exe && script.exe > run.log 2>&1"', 0
    goCmd db 'cmd.exe /c "go run script.go > run.log 2>&1"', 0
    cmdExe db 'cmd.exe', 0
    runLogFile db 'run.log', 0
    pyFile db 'script.py', 0
    cFile db 'script.c', 0
    jsFile db 'script.js', 0
    rsFile db 'script.rs', 0
    goFile db 'script.go', 0
    asmFile db 'script.asm', 0
    
    filter db 'All Files (*.*)', 0, '*.*', 0, 'Python Files (*.py)', 0, '*.py', 0, 0
    
    strLine db 'Line: ', 0
    strCol db '  Col: ', 0
    strEnc db '   Encoding: UTF-8', 0

    wc:
        dd 80
        dd 3
        dq WndProc
        dd 0
        dd 0
        dq 0
        dq 0
        dq 0
        dq 6
        dq 0
        dq className
        dq 0

section .bss
    hInstance resq 1
    msg resb 48
    ps resb 72
    hFont resq 1
    clientRect resb 16
    topRect resb 16
    bottomRect resb 16
    termRect resb 16
    sideRect resb 16
    statusRect resb 16
    highlightRect resb 16
    
    find_data resb 320
    file_list resb 26000
    file_count resd 1
    ; --- TAB STATE BLOCK START ---
tab_state_start:
    text_buffer resb 1048576
    text_len resq 1
    
    output_buffer resb 65536
    output_len resq 1
    runlog_read resd 1
    
    startup_info resb 104
    process_info resb 24
    
    current_x resd 1
    current_y resd 1
    textSize resb 8
    
    cursor_pos resq 1
    cursor_x resd 1
    cursor_y resd 1
    
    scroll_y resd 1
    is_new_line resb 1
    current_line_num resd 1
    line_str resb 16
    status_str resb 128
    hover_btn resd 1
    active_btn resd 1
    
    cursor_absolute_line resd 1
    cursor_absolute_col resd 1

    selection_start resq 1
    selection_end resq 1
    is_selecting resb 1
    sel_min resq 1
    sel_max resq 1
    
    undo_buffer resb 10485760
    undo_lens resq 10
    undo_cursors resq 10
    undo_current resd 1
    undo_max resd 1
    
    ofn resb 152
    filename resb 260
    bytesRead resd 1
    bytesWritten resd 1
tab_state_end:

    ; --- INACTIVE TAB STATE BLOCK ---
inactive_tab_state:
    resb (tab_state_end - tab_state_start)
    
    active_tab resd 1

section .text
global WinMain
global main

WinMain:
main:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    xor rcx, rcx
    call GetModuleHandleA
    mov [hInstance], rax
    mov [wc + 24], rax

    xor rcx, rcx
    mov rdx, 32512
    call LoadCursorA
    mov [wc + 40], rax

    mov rcx, 0x00000000
    call CreateSolidBrush
    mov [wc + 48], rax

    lea rcx, [wc]
    call RegisterClassExA
    test rax, rax
    jz .exit_reg

    sub rsp, 96
    mov rcx, 0x00080000
    lea rdx, [className]
    lea r8, [windowTitle]
    mov r9, 0x00EF0000
    mov dword [rsp + 32], 0x80000000
    mov dword [rsp + 40], 0x80000000
    mov dword [rsp + 48], 1280
    mov dword [rsp + 56], 768
    mov qword [rsp + 64], 0
    mov qword [rsp + 72], 0
    mov rax, [hInstance]
    mov qword [rsp + 80], rax
    mov qword [rsp + 88], 0
    call CreateWindowExA
    add rsp, 96
    
    test rax, rax
    jz .exit_win
    mov r12, rax

    sub rsp, 32
    mov rcx, r12
    mov rdx, 0
    mov r8, 240
    mov r9, 2
    call SetLayeredWindowAttributes
    add rsp, 32

    mov rcx, r12
    mov rdx, 10
    call ShowWindow

    mov rcx, r12
    call SetForegroundWindow

    mov rcx, r12
    call SetFocus

    mov rcx, r12
    call UpdateWindow

    mov qword [text_len], 0
    mov qword [cursor_pos], 0
    mov dword [scroll_y], 0
    mov qword [output_len], 0
    
    mov dword [undo_current], 0
    mov dword [undo_max], 0
    call SaveSnapshot

.message_loop:
    lea rcx, [msg]
    xor rdx, rdx
    xor r8, r8
    xor r9, r9
    call GetMessageA
    test rax, rax
    jle .exit_loop

    lea rcx, [msg]
    call TranslateMessage

    lea rcx, [msg]
    call DispatchMessageA
    jmp .message_loop

.exit_loop:
    mov rcx, [msg + 16]
    call ExitProcess

.exit_reg:
    mov rcx, 1
    call ExitProcess

.exit_win:
    mov rcx, 2
    call ExitProcess

SaveSnapshot:
    push rsi
    push rdi
    push rcx
    push rax
    push rbx
    push r8
    push r9
    
    mov eax, [undo_current]
    mov [undo_max], eax
    
    cmp eax, 10
    jb .ss_no_shift
    
    lea rdi, [undo_buffer]
    lea rsi, [undo_buffer + 1048576]
    mov rcx, 9437184
    rep movsb
    
    lea rdi, [undo_lens]
    lea rsi, [undo_lens + 8]
    mov rcx, 9
    rep movsq
    
    lea rdi, [undo_cursors]
    lea rsi, [undo_cursors + 8]
    mov rcx, 9
    rep movsq
    
    mov eax, 9
    mov [undo_current], eax
    mov [undo_max], eax

.ss_no_shift:
    mov eax, [undo_current]
    mov r8, 1048576
    mul r8
    lea rdi, [undo_buffer]
    add rdi, rax
    lea rsi, [text_buffer]
    mov rcx, [text_len]
    test rcx, rcx
    jz .ss_copy_done
    rep movsb
.ss_copy_done:
    
    mov eax, [undo_current]
    mov rbx, rax
    shl rbx, 3
    
    lea rdi, [undo_lens]
    mov rax, [text_len]
    mov [rdi + rbx], rax
    
    lea rdi, [undo_cursors]
    mov rax, [cursor_pos]
    mov [rdi + rbx], rax
    
    inc dword [undo_current]
    inc dword [undo_max]

    pop r9
    pop r8
    pop rbx
    pop rax
    pop rcx
    pop rdi
    pop rsi
    ret

LoadFiles:
    push rbp
    mov rbp, rsp
    push r14
    push r15
    push rdi
    push rsi
    sub rsp, 64

    mov dword [file_count], 0
    lea rcx, [searchPattern]
    lea rdx, [find_data]
    call FindFirstFileA
    cmp rax, -1
    je .load_files_done
    mov r14, rax
.read_loop:
    mov eax, [file_count]
    cmp eax, 100
    jae .close_find
    imul eax, 260
    lea rdi, [file_list]
    add rdi, rax
    
    lea rsi, [find_data + 44]
.copy_name:
    lodsb
    stosb
    test al, al
    jnz .copy_name

    mov eax, [find_data]
    test eax, 0x10 ; FILE_ATTRIBUTE_DIRECTORY
    jz .not_dir
    dec rdi
    mov byte [rdi], '\'
    mov byte [rdi+1], 0
.not_dir:
    inc dword [file_count]

    mov rcx, r14
    lea rdx, [find_data]
    call FindNextFileA
    test rax, rax
    jnz .read_loop
.close_find:
    mov rcx, r14
    call FindClose
.load_files_done:
    add rsp, 64
    pop rsi
    pop rdi
    pop r15
    pop r14
    pop rbp
    ret

itoa:
    push rbx
    push rcx
    push rdx
    mov ecx, 10
    mov ebx, eax
    lea rdi, [line_str + 15]
    mov byte [rdi], 0
.itoa_loop:
    dec rdi
    xor edx, edx
    mov eax, ebx
    div ecx
    mov ebx, eax
    add dl, '0'
    mov [rdi], dl
    test ebx, ebx
    jnz .itoa_loop
    pop rdx
    pop rcx
    pop rbx
    ret

IsWordChar:
    cmp al, 32
    je .iwc_no
    cmp al, 13
    je .iwc_no
    cmp al, 10
    je .iwc_no
    mov rax, 1
    ret
.iwc_no:
    xor rax, rax
    ret

WndProc:
    push rbp
    mov rbp, rsp
    push rbx
    push rdi
    push r12
    push r13
    push r14
    push r15
    sub rsp, 144

    mov r12, rcx
    mov r13, rdx
    mov r14, r8
    mov r15, r9

    cmp r13, 1                      ; WM_CREATE
    je .wm_create
    cmp r13, 2                      ; WM_DESTROY
    je .wm_destroy
    cmp r13, 5                      ; WM_SIZE
    je .wm_size
    cmp r13, 15                     ; WM_PAINT
    je .wm_paint
    cmp r13, 258                    ; WM_CHAR
    je .wm_char
    cmp r13, 0x0100                 ; WM_KEYDOWN
    je .wm_keydown
    cmp r13, 7                      ; WM_SETFOCUS
    je .wm_setfocus
    cmp r13, 8                      ; WM_KILLFOCUS
    je .wm_killfocus
    cmp r13, 0x0201                 ; WM_LBUTTONDOWN
    je .wm_lbuttondown
    cmp r13, 0x0202                 ; WM_LBUTTONUP
    je .wm_lbuttonup
    cmp r13, 0x0200                 ; WM_MOUSEMOVE
    je .wm_mousemove
    cmp r13, 0x020A                 ; WM_MOUSEWHEEL
    je .wm_mousewheel

    mov rcx, r12
    mov rdx, r13
    mov r8, r14
    mov r9, r15
    call DefWindowProcA
    jmp .end_wndproc

.wm_mousewheel:
    mov eax, r14d
    shr eax, 16
    movsx eax, ax
    cmp eax, 0
    jg .scroll_up
    jl .scroll_down
    jmp .end_wndproc
.scroll_up:
    cmp dword [scroll_y], 0
    je .end_wndproc
    sub dword [scroll_y], 3
    jns .scroll_force_repaint
    mov dword [scroll_y], 0
    jmp .scroll_force_repaint
.scroll_down:
    add dword [scroll_y], 3
.scroll_force_repaint:
    jmp near .force_repaint

.wm_mousemove:
    movzx eax, r15w
    mov r10d, eax
    mov eax, r15d
    shr eax, 16
    mov r11d, eax
    
    mov r8d, 0
    cmp r11d, 40
    ja .mm_check
    
    cmp r10d, 10
    jb .mm_check
    cmp r10d, 70
    jb .mm_b1
    cmp r10d, 80
    jb .mm_check
    cmp r10d, 140
    jb .mm_b2
    cmp r10d, 160
    jb .mm_check
    cmp r10d, 220
    jb .mm_b3
    cmp r10d, 240
    jb .mm_check
    cmp r10d, 320
    jb .mm_b4
    cmp r10d, 340
    jb .mm_check
    cmp r10d, 420
    jb .mm_b5
    cmp r10d, 440
    jb .mm_check
    cmp r10d, 540
    jb .mm_b6
    cmp r10d, 560
    jb .mm_check
    cmp r10d, 660
    jb .mm_b7
    cmp r10d, 680
    jb .mm_check
    cmp r10d, 740
    jb .mm_b8
    cmp r10d, 800
    jb .mm_check
    cmp r10d, 860
    jb .mm_b9
    cmp r10d, 880
    jb .mm_check
    cmp r10d, 940
    jb .mm_b10
    jmp .mm_check
.mm_b1: mov r8d, 1
    jmp .mm_check
.mm_b2: mov r8d, 2
    jmp .mm_check
.mm_b3: mov r8d, 3
    jmp .mm_check
.mm_b4: mov r8d, 4
    jmp .mm_check
.mm_b5: mov r8d, 5
    jmp .mm_check
.mm_b6: mov r8d, 6
    jmp .mm_check
.mm_b7: mov r8d, 7
    jmp .mm_check
.mm_b8: mov r8d, 8
    jmp .mm_check
.mm_b9: mov r8d, 9
    jmp .mm_check
.mm_b10: mov r8d, 10
.mm_check:
    cmp r8d, [hover_btn]
    je .end_wndproc
    mov [hover_btn], r8d
    jmp near .force_repaint

.wm_lbuttonup:
    mov r8d, [active_btn]
    mov dword [active_btn], 0
    test r8d, r8d
    jz .end_wndproc
    
    cmp r8d, [hover_btn]
    jne .force_repaint
    
    cmp r8d, 1
    je near .click_new
    cmp r8d, 2
    je near .click_open
    cmp r8d, 3
    je near .click_save
    cmp r8d, 4
    je near .click_run
    cmp r8d, 5
    cmp r8d, 5
    je near .click_open_dir
    cmp r8d, 6
    je near .click_terminal
    cmp r8d, 7
    je near .click_exit
    cmp r8d, 8
    je near .click_tab1
    cmp r8d, 9
    je near .click_tab2
    jmp near .force_repaint

.wm_setfocus:
    sub rsp, 48
    mov rcx, r12
    mov rdx, 0
    mov r8, 2
    mov r9, 20
    call CreateCaret
    mov rcx, r12
    call ShowCaret
    add rsp, 48
    jmp .end_wndproc

.wm_killfocus:
    sub rsp, 32
    mov rcx, r12
    call HideCaret
    call DestroyCaret
    add rsp, 32
    jmp .end_wndproc

.wm_keydown:
    ; CHECK CTRL
    sub rsp, 32
    mov rcx, 17 ; VK_CONTROL
    call GetKeyState
    add rsp, 32
    test ax, 0x8000
    jz .no_ctrl
    
    cmp r14, 'S'
    je near .click_save
    cmp r14, 'O'
    je near .click_open
    cmp r14, 'N'
    je near .click_new
    cmp r14, 'B'
    cmp r14, 0x5A ; Z
    je .ctrl_z
    cmp r14, 0x59 ; Y
    je .ctrl_y
    cmp r14, 'C'
    je .ctrl_c
    cmp r14, 'X'
    je .ctrl_x
    cmp r14, 'V'
    je .ctrl_v
    
    cmp r14, 0x25
    je .ctrl_left_sh
    cmp r14, 0x27
    je .ctrl_right_sh
    jmp .end_wndproc

.ctrl_left_sh:
    call .check_shift
    jmp .ctrl_left
.ctrl_right_sh:
    call .check_shift
    jmp .ctrl_right

.no_ctrl:
    sub rsp, 32
    mov rcx, 16 ; VK_SHIFT
    call GetKeyState
    add rsp, 32
    test ax, 0x8000
    jz .no_shift

    cmp byte [is_selecting], 0
    jne .shift_cont
    mov byte [is_selecting], 1
    mov rax, [cursor_pos]
    mov [selection_start], rax
.shift_cont:
    cmp r14, 0x25
    je .key_left
    cmp r14, 0x27
    je .key_right
    cmp r14, 0x26
    je .key_up
    cmp r14, 0x28
    je .key_down
    jmp .end_wndproc

.no_shift:
    mov byte [is_selecting], 0
    cmp r14, 0x25
    je .key_left
    cmp r14, 0x27
    je .key_right
    cmp r14, 0x26
    je .key_up
    cmp r14, 0x28
    je .key_down
    jmp .end_wndproc

.check_shift:
    sub rsp, 32
    mov rcx, 16
    call GetKeyState
    add rsp, 32
    test ax, 0x8000
    jz .cs_no
    cmp byte [is_selecting], 0
    jne .cs_ret
    mov byte [is_selecting], 1
    mov rax, [cursor_pos]
    mov [selection_start], rax
    ret
.cs_no:
    mov byte [is_selecting], 0
.cs_ret:
    ret

.ctrl_left:
    mov rsi, [cursor_pos]
    test rsi, rsi
    jz .end_wndproc
    lea r8, [text_buffer]
.cl_loop1:
    dec rsi
    mov al, [r8+rsi]
    call IsWordChar
    test rax, rax
    jnz .cl_in_word
    test rsi, rsi
    jz .cl_done
    jmp .cl_loop1
.cl_in_word:
.cl_loop2:
    test rsi, rsi
    jz .cl_done
    dec rsi
    mov al, [r8+rsi]
    call IsWordChar
    test rax, rax
    jz .cl_found_start
    jmp .cl_loop2
.cl_found_start:
    inc rsi
.cl_done:
    mov [cursor_pos], rsi
    jmp .auto_scroll

.ctrl_right:
    mov rsi, [cursor_pos]
    mov rdi, [text_len]
    cmp rsi, rdi
    jae .end_wndproc
    lea r8, [text_buffer]
.cr_loop1:
    cmp rsi, rdi
    jae .cr_done
    mov al, [r8+rsi]
    call IsWordChar
    test rax, rax
    jz .cr_in_space
    inc rsi
    jmp .cr_loop1
.cr_in_space:
.cr_loop2:
    cmp rsi, rdi
    jae .cr_done
    mov al, [r8+rsi]
    call IsWordChar
    test rax, rax
    jnz .cr_done
    inc rsi
    jmp .cr_loop2
.cr_done:
    mov [cursor_pos], rsi
    jmp .auto_scroll


.ctrl_c:
    cmp byte [is_selecting], 1
    jne .cc_line
    mov r10, [sel_min]
    mov r11, [sel_max]
    jmp .cc_fwd_done
.cc_line:
    mov rsi, [cursor_pos]
    lea r8, [text_buffer]
    mov r10, rsi
.cc_back:
    test r10, r10
    jz .cc_back_done
    dec r10
    cmp byte [r8+r10], 10
    je .cc_back_found
    jmp .cc_back
.cc_back_found:
    inc r10
.cc_back_done:
    mov r11, rsi
    mov rdx, [text_len]
.cc_fwd:
    cmp r11, rdx
    jae .cc_fwd_done
    cmp byte [r8+r11], 10
    je .cc_fwd_found
    inc r11
    jmp .cc_fwd
.cc_fwd_found:
    inc r11
.cc_fwd_done:
    mov r13, r11
    sub r13, r10
    jz .end_wndproc
    
    inc r13
    sub rsp, 32
    mov rcx, 0x0002
    mov rdx, r13
    call GlobalAlloc
    add rsp, 32
    test rax, rax
    jz .end_wndproc
    mov rdi, rax
    
    sub rsp, 32
    mov rcx, rdi
    call GlobalLock
    add rsp, 32
    mov rbx, rax
    
    lea rsi, [text_buffer]
    add rsi, r10
    mov rcx, r13
    dec rcx
.cc_cpy:
    test rcx, rcx
    jz .cc_cpy_done
    mov al, [rsi]
    mov [rbx], al
    inc rsi
    inc rbx
    dec rcx
    jmp .cc_cpy
.cc_cpy_done:
    mov byte [rbx], 0
    
    sub rsp, 32
    mov rcx, rdi
    call GlobalUnlock
    mov rcx, r12
    call OpenClipboard
    call EmptyClipboard
    mov rcx, 1
    mov rdx, rdi
    call SetClipboardData
    call CloseClipboard
    add rsp, 32
    jmp .end_wndproc

.ctrl_x:
    cmp byte [is_selecting], 1
    jne .cx_line
    mov r10, [sel_min]
    mov r11, [sel_max]
    mov byte [is_selecting], 0
    jmp .cx_fwd_done
.cx_line:
    mov rsi, [cursor_pos]
    lea r8, [text_buffer]
    mov r10, rsi
.cx_back:
    test r10, r10
    jz .cx_back_done
    dec r10
    cmp byte [r8+r10], 10
    je .cx_back_found
    jmp .cx_back
.cx_back_found:
    inc r10
.cx_back_done:
    mov r11, rsi
    mov rdx, [text_len]
.cx_fwd:
    cmp r11, rdx
    jae .cx_fwd_done
    cmp byte [r8+r11], 10
    je .cx_fwd_found
    inc r11
    jmp .cx_fwd
.cx_fwd_found:
    inc r11
.cx_fwd_done:
    mov r13, r11
    sub r13, r10
    jz .end_wndproc
    
    sub rsp, 32
    mov rcx, r12
    call OpenClipboard
    mov rcx, 0
    call EmptyClipboard
    
    mov rcx, 1
    mov rdx, r13
    inc rdx
    call GlobalAlloc
    mov r15, rax
    mov rcx, rax
    call GlobalLock
    mov rdi, rax
    
    lea rsi, [text_buffer]
    add rsi, r10
    mov rcx, r13
    rep movsb
    mov byte [rdi], 0
    
    mov rcx, r15
    call GlobalUnlock
    mov rcx, 1
    mov rdx, r15
    call SetClipboardData
    call CloseClipboard
    add rsp, 32
    
    mov rsi, r11
    mov rdi, r10
    mov rcx, [text_len]
    sub rcx, r11
    lea r8, [text_buffer]
    add rsi, r8
    add rdi, r8
.cx_del:
    test rcx, rcx
    jz .cx_del_done
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    dec rcx
    jmp .cx_del
.cx_del_done:
    mov rax, [text_len]
    sub rax, r13
    mov [text_len], rax
    mov [cursor_pos], r10
    call SaveSnapshot
    jmp near .force_repaint

.ctrl_v:
    cmp byte [is_selecting], 1
    jne .cv_do
    ; Delete selection first
    mov r10, [sel_min]
    mov r11, [sel_max]
    mov byte [is_selecting], 0
    
    mov r13, r11
    sub r13, r10
    mov rsi, r11
    mov rdi, r10
    mov rcx, [text_len]
    sub rcx, r11
    lea r8, [text_buffer]
    add rsi, r8
    add rdi, r8
.cv_del:
    test rcx, rcx
    jz .cv_del_done
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    dec rcx
    jmp .cv_del
.cv_del_done:
    mov rax, [text_len]
    sub rax, r13
    mov [text_len], rax
    mov [cursor_pos], r10

.cv_do:
    sub rsp, 32
    mov rcx, r12
    call OpenClipboard
    mov rcx, 1
    call GetClipboardData
    add rsp, 32
    test rax, rax
    jz .cv_end
    mov rdi, rax
    
    sub rsp, 32
    mov rcx, rdi
    call GlobalLock
    add rsp, 32
    mov rbx, rax
    
    mov r15, 0
.cv_len:
    cmp byte [rbx+r15], 0
    je .cv_len_done
    inc r15
    jmp .cv_len
.cv_len_done:
    
    mov rcx, [text_len]
    mov r8, [cursor_pos]
    lea r9, [text_buffer]
.cv_shift:
    cmp rcx, r8
    jbe .cv_paste
    mov al, [r9 + rcx - 1]
    mov r10, rcx
    add r10, r15
    mov [r9 + r10 - 1], al
    dec rcx
    jmp .cv_shift
.cv_paste:
    mov rcx, r15
    mov rsi, rbx
    lea rdi, [text_buffer]
    add rdi, r8
.cv_cpy2:
    test rcx, rcx
    jz .cv_cpy_done2
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    dec rcx
    jmp .cv_cpy2
.cv_cpy_done2:
    mov rax, [text_len]
    add rax, r15
    mov [text_len], rax
    mov rax, [cursor_pos]
    add rax, r15
    mov [cursor_pos], rax

    sub rsp, 32
    mov rcx, rdi
    call GlobalUnlock
    call CloseClipboard
    add rsp, 32
    call SaveSnapshot
    jmp near .force_repaint
.cv_end:
    sub rsp, 32
    call CloseClipboard
    add rsp, 32
    jmp .end_wndproc

.key_left:
    mov rax, [cursor_pos]
    test rax, rax
    jz .end_wndproc
    dec qword [cursor_pos]
    jmp .auto_scroll

.key_right:
    mov rax, [cursor_pos]
    cmp rax, [text_len]
    jae .end_wndproc
    inc qword [cursor_pos]
    jmp .auto_scroll

.key_up:
    mov rcx, [cursor_pos]
    test rcx, rcx
    jz .end_wndproc
.ku_loop1:
    dec rcx
    jz .ku_done
    lea r9, [text_buffer]
    cmp byte [r9 + rcx], 10
    je .ku_found_lf
    jmp .ku_loop1
.ku_found_lf:
    mov [cursor_pos], rcx
    jmp .auto_scroll
.ku_done:
    mov qword [cursor_pos], 0
    jmp .auto_scroll

.key_down:
    mov rcx, [cursor_pos]
    mov rdx, [text_len]
.kd_loop:
    cmp rcx, rdx
    jae .kd_done
    lea r9, [text_buffer]
    mov al, [r9 + rcx]
    inc rcx
    cmp al, 10
    je .kd_done
    jmp .kd_loop
.kd_done:
    mov [cursor_pos], rcx
    jmp .auto_scroll

.wm_lbuttondown:
    mov rcx, r12
    call SetForegroundWindow
    mov rcx, r12
    call SetFocus

    movzx eax, r15w
    mov r10d, eax
    mov eax, r15d
    shr eax, 16
    mov r11d, eax

    cmp r11d, 40
    jbe .top_bar_click
    
    sub rsp, 32
    mov rcx, r12
    lea rdx, [clientRect]
    call GetClientRect
    add rsp, 32

    mov eax, [clientRect+12]
    sub eax, 250 ; terminal is 250 from bottom now
    cmp r11d, eax
    jae .end_wndproc
    
    cmp r10d, 200
    ja .editor_click
    
    ; SIDEBAR CLICK
    mov eax, r11d
    sub eax, 50
    js .end_wndproc
    mov ecx, 20
    xor edx, edx
    div ecx
    cmp eax, [file_count]
    jae .end_wndproc

    imul eax, 260
    lea rsi, [file_list]
    add rsi, rax
    lea rdi, [filename]
    mov r8, rdi
.copy_fname:
    lodsb
    stosb
    test al, al
    jnz .copy_fname

    ; Directory Check
    dec rdi
    dec rdi
    cmp byte [rdi], '\'
    jne .load_filename_and_repaint

    ; Set Current Directory
    mov byte [rdi], 0
    sub rsp, 32
    mov rcx, r8
    call SetCurrentDirectoryA
    add rsp, 32
    call LoadFiles
    jmp near .force_repaint

.editor_click:
    mov byte [is_selecting], 0
    mov eax, r11d
    sub eax, 50
    js .end_wndproc
    mov ecx, 24
    xor edx, edx
    div ecx
    add eax, [scroll_y]
    mov r13d, eax

    mov eax, r10d
    sub eax, 260
    js .col_zero
    mov ecx, 11
    xor edx, edx
    div ecx
    jmp .got_col
.col_zero:
    xor eax, eax
.got_col:
    mov r14d, eax

    lea rsi, [text_buffer]
    mov rdi, rsi
    add rdi, [text_len]
    mov ecx, 0
    mov edx, 0
.hit_loop:
    cmp rsi, rdi
    jae .hit_limit
    cmp ecx, r13d
    ja .hit_limit
    jb .next_char
    cmp edx, r14d
    jae .hit_limit
.next_char:
    mov al, [rsi]
    inc rsi
    inc edx
    cmp al, 10
    jne .hit_loop
    inc ecx
    mov edx, 0
    jmp .hit_loop
.hit_limit:
    lea r8, [text_buffer]
    sub rsi, r8
    mov [cursor_pos], rsi
    jmp near .force_repaint


.top_bar_click:
    mov eax, [hover_btn]
    mov [active_btn], eax
    jmp near .force_repaint

.click_tab1:
    cmp dword [active_tab], 0
    je near .force_repaint
    call SwitchTab
    jmp near .force_repaint

.click_tab2:
    cmp dword [active_tab], 1
    je near .force_repaint
    call SwitchTab
    jmp near .force_repaint

.click_new:
    mov qword [text_len], 0
    mov qword [cursor_pos], 0
    mov dword [scroll_y], 0
    mov dword [undo_current], 0
    mov dword [undo_max], 0
    mov byte [filename], 0
    call SaveSnapshot
    jmp near .force_repaint

.ctrl_z:
    cmp dword [undo_current], 1
    jbe .end_wndproc
    
    dec dword [undo_current]
    mov eax, [undo_current]
    dec eax
    
    mov rbx, rax
    shl rbx, 3
    lea rsi, [undo_lens]
    mov rcx, [rsi + rbx]
    mov [text_len], rcx
    
    lea rsi, [undo_cursors]
    mov rdx, [rsi + rbx]
    mov [cursor_pos], rdx
    
    mov r8, 1048576
    mul r8
    lea rsi, [undo_buffer]
    add rsi, rax
    lea rdi, [text_buffer]
    test rcx, rcx
    jz .force_repaint
    rep movsb
    jmp near .force_repaint

.ctrl_y:
    mov eax, [undo_current]
    cmp eax, [undo_max]
    jae .end_wndproc
    
    mov rbx, rax
    shl rbx, 3
    lea rsi, [undo_lens]
    mov rcx, [rsi + rbx]
    mov [text_len], rcx
    
    lea rsi, [undo_cursors]
    mov rdx, [rsi + rbx]
    mov [cursor_pos], rdx
    
    mov r8, 1048576
    mul r8
    lea rsi, [undo_buffer]
    add rsi, rax
    lea rdi, [text_buffer]
    test rcx, rcx
    jz .cy_done
    rep movsb
.cy_done:
    inc dword [undo_current]
    jmp near .force_repaint

.click_open_dir:
    lea rdi, [ofn]
    mov rcx, 152
    xor al, al
    rep stosb
    mov dword [ofn], 152
    mov [ofn+8], r12
    lea rax, [filter]
    mov [ofn+24], rax
    lea rax, [filename]
    mov [ofn+48], rax
    mov dword [ofn+56], 260
    mov dword [ofn+96], 0x00081000 ; OFN_FILEMUSTEXIST

    sub rsp, 32
    lea rcx, [ofn]
    call GetOpenFileNameA
    add rsp, 32
    test rax, rax
    jz .end_wndproc

    ; Extract directory
    lea rsi, [filename]
    mov rdi, rsi
.fd_loop:
    mov al, [rsi]
    test al, al
    jz .fd_done
    cmp al, '\'
    jne .fd_not_slash
    mov rdi, rsi
.fd_not_slash:
    inc rsi
    jmp .fd_loop
.fd_done:
    mov byte [rdi], 0

    sub rsp, 32
    lea rcx, [filename]
    call SetCurrentDirectoryA
    add rsp, 32

    call LoadFiles
    jmp near .force_repaint

.click_terminal:
    lea rdi, [startup_info]
    mov rcx, 104
    xor al, al
    rep stosb
    mov dword [startup_info], 104

    sub rsp, 112
    mov rcx, 0
    lea rdx, [cmdExe]
    mov r8, 0
    mov r9, 0
    mov dword [rsp+32], 0
    mov dword [rsp+40], 0x00000010 ; CREATE_NEW_CONSOLE
    mov qword [rsp+48], 0
    mov qword [rsp+56], 0
    lea rax, [startup_info]
    mov qword [rsp+64], rax
    lea rax, [process_info]
    mov qword [rsp+72], rax
    call CreateProcessA
    add rsp, 112

    sub rsp, 32
    mov rcx, [process_info]
    call CloseHandle
    mov rcx, [process_info+8]
    call CloseHandle
    add rsp, 32

    jmp .end_wndproc

.click_open:
    lea rdi, [ofn]
    mov rcx, 152
    xor al, al
    rep stosb
    mov dword [ofn], 152
    mov [ofn+8], r12
    lea rax, [filter]
    mov [ofn+24], rax
    lea rax, [filename]
    mov [ofn+48], rax
    mov dword [ofn+56], 260
    mov dword [ofn+96], 0x00081000

    sub rsp, 32
    lea rcx, [ofn]
    call GetOpenFileNameA
    add rsp, 32
    test rax, rax
    jz .end_wndproc

.load_filename_and_repaint:
    sub rsp, 64
    lea rcx, [filename]
    mov rdx, 0x80000000
    mov r8, 1
    mov r9, 0
    mov dword [rsp+32], 3
    mov dword [rsp+40], 128
    mov qword [rsp+48], 0
    call CreateFileA
    add rsp, 64
    cmp rax, -1
    je .end_wndproc
    mov r14, rax

    sub rsp, 32
    mov rcx, r14
    mov rdx, 0
    call GetFileSize
    add rsp, 32
    mov [text_len], rax
    mov qword [cursor_pos], rax

    sub rsp, 48
    mov rcx, r14
    lea rdx, [text_buffer]
    mov r8, [text_len]
    lea r9, [bytesRead]
    mov qword [rsp+32], 0
    call ReadFile
    add rsp, 48

    sub rsp, 32
    mov rcx, r14
    call CloseHandle
    add rsp, 32
    jmp near .force_repaint

.click_save:
    lea rdi, [ofn]
    mov rcx, 152
    xor al, al
    rep stosb
    mov dword [ofn], 152
    mov [ofn+8], r12
    lea rax, [filter]
    mov [ofn+24], rax
    lea rax, [filename]
    mov [ofn+48], rax
    mov dword [ofn+56], 260
    mov dword [ofn+96], 0x00080002

    sub rsp, 32
    lea rcx, [ofn]
    call GetSaveFileNameA
    add rsp, 32
    test rax, rax
    jz .end_wndproc

    sub rsp, 64
    lea rcx, [filename]
    mov rdx, 0x40000000
    mov r8, 0
    mov r9, 0
    mov dword [rsp+32], 2
    mov dword [rsp+40], 128
    mov qword [rsp+48], 0
    call CreateFileA
    add rsp, 64
    cmp rax, -1
    je .end_wndproc
    mov r14, rax

    sub rsp, 48
    mov rcx, r14
    lea rdx, [text_buffer]
    mov r8, [text_len]
    lea r9, [bytesWritten]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 48

    sub rsp, 32
    mov rcx, r14
    call CloseHandle
    add rsp, 32
    jmp .end_wndproc

.click_run:
    lea r12, [pyFile]
    lea r13, [pyCmd]
    
    cmp byte [filename], 0
    je near .run_start
    
    lea rsi, [filename]
.r_loop:
    mov al, [rsi]
    test al, al
    jz .r_end
    inc rsi
    jmp .r_loop
.r_end:
    lea rdx, [filename]    ; Safely load the 64-bit address using RIP-relative addressing
.r_dot_loop:
    cmp rsi, rdx           ; Compare the registers directly
    je near .run_start
    dec rsi
    mov al, [rsi]
    cmp al, '.'
    jne .r_dot_loop
    inc rsi

    cmp word [rsi], 'py'
    je near .run_py
    cmp word [rsi], 'js'
    je near .run_js
    cmp word [rsi], 'rs'
    je near .run_rs
    cmp word [rsi], 'go'
    je near .run_go
    cmp byte [rsi], 'c'
    je near .run_c
    mov eax, dword [rsi]
    and eax, 0x00FFFFFF ; check 'asm'
    cmp eax, 0x006D7361 ; 'asm'
    je near .run_asm
    
    jmp near .run_start

.run_js:
    lea r12, [jsFile]
    lea r13, [jsCmd]
    jmp near .run_start
.run_rs:
    lea r12, [rsFile]
    lea r13, [rsCmd]
    jmp near .run_start
.run_go:
    lea r12, [goFile]
    lea r13, [goCmd]
    jmp near .run_start
.run_c:
    cmp byte [rsi+1], 0
    jne near .run_start
    lea r12, [cFile]
    lea r13, [cCmd]
    jmp near .run_start
.run_asm:
    lea r12, [asmFile]
    lea r13, [asmCmd]
    jmp near .run_start
.run_py:
    lea r12, [pyFile]
    lea r13, [pyCmd]

.run_start:
    sub rsp, 64
    mov rcx, r12
    mov rdx, 0x40000000
    mov r8, 0
    mov r9, 0
    mov dword [rsp+32], 2
    mov dword [rsp+40], 128
    mov qword [rsp+48], 0
    call CreateFileA
    add rsp, 64
    cmp rax, -1
    je .end_wndproc
    mov r14, rax

    sub rsp, 48
    mov rcx, r14
    lea rdx, [text_buffer]
    mov r8, [text_len]
    lea r9, [bytesWritten]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 48

    sub rsp, 32
    mov rcx, r14
    call CloseHandle
    add rsp, 32

    lea rdi, [startup_info]
    mov rcx, 104
    xor al, al
    rep stosb
    lea rax, [startup_info]
    mov dword [rax], 104

    sub rsp, 112
    mov rcx, 0
    mov rdx, r13
    mov r8, 0
    mov r9, 0
    mov dword [rsp+32], 0
    mov dword [rsp+40], 0x08000000
    mov qword [rsp+48], 0
    mov qword [rsp+56], 0
    lea rax, [startup_info]
    mov qword [rsp+64], rax
    lea rax, [process_info]
    mov qword [rsp+72], rax
    call CreateProcessA
    add rsp, 112
    jmp .end_wndproc

.click_exit:
    mov rcx, 0
    call PostQuitMessage
    jmp .end_wndproc

.wm_size:
    jmp near .force_repaint

.wm_char:
    cmp byte [is_selecting], 1
    jne .wm_char_cont
    
    ; Delete selection
    mov r10, [sel_min]
    mov r11, [sel_max]
    mov byte [is_selecting], 0
    mov r13, r11
    sub r13, r10
    mov rsi, r11
    mov rdi, r10
    mov rcx, [text_len]
    sub rcx, r11
    lea r8, [text_buffer]
    add rsi, r8
    add rdi, r8
.wc_del:
    test rcx, rcx
    jz .wc_del_done
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    dec rcx
    jmp .wc_del
.wc_del_done:
    mov rax, [text_len]
    sub rax, r13
    mov [text_len], rax
    mov [cursor_pos], r10

.wm_char_cont:
    cmp r14, 8
    je .backspace
    cmp r14, 13
    je .enter
    
    ; IGNORE control characters (ctrl combinations generate wm_char < 32)
    cmp r14, 32
    jb .end_wm_char

    mov rax, [text_len]
    cmp rax, 1048575
    jae .end_wm_char

    mov rcx, [text_len]
    mov r8, [cursor_pos]
    lea r9, [text_buffer]
.shift_right:
    cmp rcx, r8
    jbe .do_insert
    mov al, [r9 + rcx - 1]
    mov [r9 + rcx], al
    dec rcx
    jmp .shift_right

.do_insert:
    mov byte [r9 + r8], r14b
    inc qword [cursor_pos]
    inc qword [text_len]
    jmp .auto_scroll

.backspace:
    mov r8, [cursor_pos]
    test r8, r8
    jz .end_wm_char
    
    mov rcx, r8
    dec rcx
    mov rdx, [text_len]
    lea r9, [text_buffer]
.shift_left:
    cmp rcx, rdx
    jae .bs_done
    mov al, [r9 + rcx + 1]
    mov [r9 + rcx], al
    inc rcx
    jmp .shift_left
.bs_done:
    dec qword [cursor_pos]
    dec qword [text_len]
    jmp .auto_scroll

.enter:
    mov rcx, [text_len]
    mov r8, [cursor_pos]
    lea r9, [text_buffer]
.shift_right2:
    cmp rcx, r8
    jbe .do_insert2
    mov al, [r9 + rcx - 1]
    mov [r9 + rcx + 1], al
    dec rcx
    jmp .shift_right2
.do_insert2:
    mov byte [r9 + r8], 13
    mov byte [r9 + r8 + 1], 10
    add qword [cursor_pos], 2
    add qword [text_len], 2
    jmp .auto_scroll

.auto_scroll:
    cmp byte [is_selecting], 1
    jne .as_normal
    mov rax, [cursor_pos]
    mov [selection_end], rax
.as_normal:
    mov rsi, [cursor_pos]
    lea r8, [text_buffer]
    mov ecx, 0
    mov rdx, 0
.as_loop:
    cmp rdx, rsi
    jae .as_done
    mov al, [r8 + rdx]
    inc rdx
    cmp al, 10
    jne .as_loop
    inc ecx
    jmp .as_loop
.as_done:
    mov eax, ecx
    cmp eax, [scroll_y]
    jl .scroll_to_cursor
    mov edx, [scroll_y]
    add edx, 18
    cmp eax, edx
    jg .scroll_cursor_down
    jmp near .force_repaint
.scroll_to_cursor:
    mov [scroll_y], eax
    jmp near .force_repaint
.scroll_cursor_down:
    sub eax, 18
    mov [scroll_y], eax

.force_repaint:
    sub rsp, 32
    mov rcx, r12
    xor rdx, rdx
    mov r8, 1
    call InvalidateRect
    add rsp, 32
    
.end_wm_char:
    xor rax, rax
    jmp .end_wndproc

.wm_create:
    sub rsp, 112
    mov rcx, 24
    mov rdx, 0
    mov r8, 0
    mov r9, 0
    mov dword [rsp+32], 400
    mov dword [rsp+40], 0
    mov dword [rsp+48], 0
    mov dword [rsp+56], 0
    mov dword [rsp+64], 0
    mov dword [rsp+72], 0
    mov dword [rsp+80], 0
    mov dword [rsp+88], 0
    mov dword [rsp+96], 0
    lea rax, [fontName]
    mov qword [rsp+104], rax
    call CreateFontA
    add rsp, 112
    mov [hFont], rax

    call LoadFiles

    xor rax, rax
    jmp .end_wndproc

.wm_paint:
    mov rcx, r12
    lea rdx, [ps]
    call BeginPaint
    mov rbx, rax

    mov rcx, rbx
    mov rdx, [hFont]
    call SelectObject

    mov rcx, rbx
    mov rdx, 1
    call SetBkMode

    sub rsp, 32
    mov rcx, r12
    lea rdx, [clientRect]
    call GetClientRect
    add rsp, 32

    mov rcx, 0x001B1B1B
    call CreateSolidBrush
    mov r14, rax
    mov dword [topRect], 0
    mov dword [topRect+4], 0
    mov eax, [clientRect+8]
    mov dword [topRect+8], eax
    mov dword [topRect+12], 40
    mov rcx, rbx
    lea rdx, [topRect]
    mov r8, r14
    call FillRect
    mov rcx, r14
    call DeleteObject

    mov rcx, 0x001B1B1B
    call CreateSolidBrush
    mov r14, rax
    mov dword [bottomRect], 0
    mov eax, [clientRect+12]
    sub eax, 50
    mov dword [bottomRect+4], eax
    mov eax, [clientRect+8]
    mov dword [bottomRect+8], eax
    mov eax, [clientRect+12]
    sub eax, 20
    mov dword [bottomRect+12], eax
    mov rcx, rbx
    lea rdx, [bottomRect]
    mov r8, r14
    call FillRect
    mov rcx, r14
    call DeleteObject
    
    ; STATUS BAR
    mov rcx, 0x00332211
    call CreateSolidBrush
    mov r14, rax
    mov dword [statusRect], 0
    mov eax, [clientRect+12]
    sub eax, 20
    mov dword [statusRect+4], eax
    mov eax, [clientRect+8]
    mov dword [statusRect+8], eax
    mov eax, [clientRect+12]
    mov dword [statusRect+12], eax
    mov rcx, rbx
    lea rdx, [statusRect]
    mov r8, r14
    call FillRect
    mov rcx, r14
    call DeleteObject

    ; Explorer Sidebar
    mov rcx, 0x00161616
    call CreateSolidBrush
    mov r14, rax
    mov dword [sideRect], 0
    mov dword [sideRect+4], 40
    mov dword [sideRect+8], 200
    mov eax, [clientRect+12]
    sub eax, 250
    mov dword [sideRect+12], eax
    mov rcx, rbx
    lea rdx, [sideRect]
    mov r8, r14
    call FillRect
    mov rcx, r14
    call DeleteObject

    mov rcx, 0x00AAAAAA
    call SetTextColor

    mov dword [current_y], 50
    mov dword [current_x], 10
    mov r13d, 0
.draw_files_loop:
    cmp r13d, [file_count]
    jae .draw_files_done
    mov eax, r13d
    imul eax, 260
    lea r9, [file_list]
    add r9, rax

    mov r15, r9
.len_loop:
    cmp byte [r15], 0
    je .len_done
    inc r15
    jmp .len_loop
.len_done:
    sub r15, r9

    sub rsp, 48
    mov rcx, rbx
    mov edx, [current_x]
    mov r8d, [current_y]
    mov dword [rsp+32], r15d
    call TextOutA
    add rsp, 48

    add dword [current_y], 20
    inc r13d
    jmp .draw_files_loop
.draw_files_done:

    mov rcx, rbx
    mov rdx, 0x00E0E0E0
    call SetTextColor
    mov rcx, rbx
    mov rdx, 2
    call SetBkMode

    jmp .skip_btn_state
.SetBtnState:
    sub rsp, 40
    cmp r8d, [active_btn]
    jne .sbs_not_active
    mov rcx, rbx
    mov rdx, 0x00444444
    call SetBkColor
    add rsp, 40
    ret
.sbs_not_active:
    cmp r8d, [hover_btn]
    jne .sbs_not_hover
    mov rcx, rbx
    mov rdx, 0x00333333
    call SetBkColor
    add rsp, 40
    ret
.sbs_not_hover:
    mov rcx, rbx
    mov rdx, 0x001B1B1B
    call SetBkColor
    add rsp, 40
    ret
.skip_btn_state:

    mov r8d, 1
    call .SetBtnState
    sub rsp, 48
    mov rcx, rbx
    mov edx, 10
    mov r8d, 10
    lea r9, [btnNew]
    mov dword [rsp+32], 5
    call TextOutA
    add rsp, 48

    mov r8d, 2
    call .SetBtnState
    sub rsp, 48
    mov rcx, rbx
    mov edx, 80
    mov r8d, 10
    lea r9, [btnOpen]
    mov dword [rsp+32], 6
    call TextOutA
    add rsp, 48

    mov r8d, 3
    call .SetBtnState
    sub rsp, 48
    mov rcx, rbx
    mov edx, 160
    mov r8d, 10
    lea r9, [btnSave]
    mov dword [rsp+32], 6
    call TextOutA
    add rsp, 48

    mov r8d, 4
    call .SetBtnState
    sub rsp, 48
    mov rcx, rbx
    mov edx, 240
    mov r8d, 10
    lea r9, [btnRun]
    mov dword [rsp+32], 5
    call TextOutA
    add rsp, 48

    
    mov r8d, 6
    call .SetBtnState
    sub rsp, 48
    mov rcx, rbx
    mov edx, 440
    mov r8d, 10
    lea r9, [btnOpenDir]
    mov dword [rsp+32], 10
    call TextOutA
    add rsp, 48

    mov r8d, 7
    call .SetBtnState
    sub rsp, 48
    mov rcx, rbx
    mov edx, 560
    mov r8d, 10
    lea r9, [btnTerminal]
    mov dword [rsp+32], 10
    call TextOutA
    add rsp, 48

    mov r8d, 8
    call .SetBtnState
    sub rsp, 48
    mov rcx, rbx
    mov edx, 680
    mov r8d, 10
    lea r9, [btnExit]
    mov dword [rsp+32], 6
    call TextOutA
    add rsp, 48

    ; TAB 1 BUTTON
    mov r8d, 9
    call .SetBtnState
    cmp dword [active_tab], 0
    jne .not_active_t1
    mov rcx, rbx
    mov rdx, 0x00FF8800
    call SetBkColor
.not_active_t1:
    sub rsp, 48
    mov rcx, rbx
    mov edx, 800
    mov r8d, 10
    lea r9, [btnTab1]
    mov dword [rsp+32], 7
    call TextOutA
    add rsp, 48

    ; TAB 2 BUTTON
    mov r8d, 10
    call .SetBtnState
    cmp dword [active_tab], 1
    jne .not_active_t2
    mov rcx, rbx
    mov rdx, 0x00FF8800
    call SetBkColor
.not_active_t2:
    sub rsp, 48
    mov rcx, rbx
    mov edx, 880
    mov r8d, 10
    lea r9, [btnTab2]
    mov dword [rsp+32], 7
    call TextOutA
    add rsp, 48

    mov rcx, rbx
    mov rdx, 1
    call SetBkMode

    mov rcx, 0x00111111
    call CreateSolidBrush
    mov r14, rax
    mov dword [termRect], 0
    mov eax, [clientRect+12]
    sub eax, 250
    mov dword [termRect+4], eax
    mov eax, [clientRect+8]
    mov dword [termRect+8], eax
    mov eax, [clientRect+12]
    sub eax, 50
    mov dword [termRect+12], eax
    mov rcx, rbx
    lea rdx, [termRect]
    mov r8, r14
    call FillRect
    mov rcx, r14
    call DeleteObject

    sub rsp, 48
    mov rcx, rbx
    mov rdx, 210
    mov r8, 40
    mov r9d, [clientRect+8]
    mov eax, [clientRect+12]
    sub eax, 250
    mov dword [rsp+32], eax
    call IntersectClipRect
    add rsp, 48

    mov dword [current_y], 50
    mov dword [current_x], 260
    mov dword [cursor_x], -1
    mov dword [cursor_y], -1
    mov byte [is_new_line], 1
    mov eax, [scroll_y]
    inc eax
    mov [current_line_num], eax

    mov rax, [selection_start]
    mov rdx, [selection_end]
    cmp rax, rdx
    jbe .sel_ok
    xchg rax, rdx
.sel_ok:
    mov [sel_min], rax
    mov [sel_max], rdx

    ; Calc absolute cursor line/col
    mov rsi, [cursor_pos]
    lea r8, [text_buffer]
    mov ecx, 0
    mov rdx, 0
.calc_cl_loop:
    cmp rdx, rsi
    jae .calc_cl_done
    mov al, [r8 + rdx]
    inc rdx
    cmp al, 10
    jne .calc_cl_loop
    inc ecx
    jmp .calc_cl_loop
.calc_cl_done:
    mov [cursor_absolute_line], ecx
    
    mov rdx, rsi
.calc_col_loop:
    test rdx, rdx
    jz .calc_col_done
    dec rdx
    mov al, [r8 + rdx]
    cmp al, 10
    je .calc_col_found
    jmp .calc_col_loop
.calc_col_found:
    inc rdx
.calc_col_done:
    mov rax, rsi
    sub rax, rdx
    mov [cursor_absolute_col], eax

    lea rsi, [text_buffer]
    mov rdi, rsi
    add rdi, [text_len]

    mov ecx, [scroll_y]
    test ecx, ecx
    jz .render_loop
.skip_loop:
    cmp rsi, rdi
    jae .render_loop
    mov al, [rsi]
    inc rsi
    cmp al, 10
    jne .skip_loop
    dec ecx
    jnz .skip_loop

.render_loop:
    cmp byte [is_new_line], 1
    jne .check_cursor
    mov byte [is_new_line], 0
    
    ; HIGHLIGHT ACTIVE LINE
    mov eax, [current_line_num]
    dec eax
    cmp eax, [cursor_absolute_line]
    jne .skip_hl
    
    mov rcx, 0x00252525
    call CreateSolidBrush
    mov r14, rax
    mov dword [highlightRect], 250
    mov eax, [current_y]
    mov dword [highlightRect+4], eax
    mov eax, [clientRect+8]
    mov dword [highlightRect+8], eax
    mov eax, [current_y]
    add eax, 24
    mov dword [highlightRect+12], eax
    mov rcx, rbx
    lea rdx, [highlightRect]
    mov r8, r14
    call FillRect
    mov rcx, r14
    call DeleteObject
.skip_hl:

    push rdi
    mov eax, [current_line_num]
    call itoa
    mov r14, rdi
    pop rdi

    sub rsp, 32
    mov rcx, rbx
    mov rdx, 0x000088FF
    call SetTextColor
    add rsp, 32

    mov r15, r14
.ln_len:
    cmp byte [r15], 0
    je .ln_done
    inc r15
    jmp .ln_len
.ln_done:
    sub r15, r14

    sub rsp, 48
    mov rcx, rbx
    mov edx, 210
    mov r8d, [current_y]
    mov r9, r14
    mov dword [rsp+32], r15d
    call TextOutA
    add rsp, 48

.check_cursor:
    mov rax, rsi
    lea r9, [text_buffer]
    sub rax, r9
    cmp rax, [cursor_pos]
    jne .not_cursor
    mov eax, [current_x]
    mov [cursor_x], eax
    mov eax, [current_y]
    mov [cursor_y], eax
.not_cursor:

    cmp rsi, rdi
    jae .render_done

    mov al, [rsi]
    cmp al, 13
    je .handle_cr
    cmp al, 10
    je .handle_lf
    cmp al, 32
    je .handle_space
    cmp al, ','
    je .handle_punct
    cmp al, '['
    je .handle_punct
    cmp al, ']'
    je .handle_punct
    cmp al, '+'
    je .handle_punct
    cmp al, '-'
    je .handle_punct
    cmp al, '*'
    je .handle_punct
    cmp al, ':'
    je .handle_punct
    cmp al, '('
    je .handle_punct
    cmp al, ')'
    je .handle_punct
    cmp al, '{'
    je .handle_punct
    cmp al, '}'
    je .handle_punct
    cmp al, '.'
    je .handle_punct
    cmp al, '='
    je .handle_punct
    cmp al, '<'
    je .handle_punct
    cmp al, '>'
    je .handle_punct
    cmp al, '/'
    je .handle_punct
    cmp al, '&'
    je .handle_punct
    cmp al, '|'
    je .handle_punct
    cmp al, '!'
    je .handle_punct
    cmp al, '~'
    je .handle_punct
    cmp al, '%'
    je .handle_punct
    cmp al, '^'
    je .handle_punct
    cmp al, ';'
    je .handle_punct

    mov r15, rsi
.find_word_end:
    cmp rsi, rdi
    jae .word_found
    mov al, [rsi]
    cmp al, 13
    je .word_found
    cmp al, 10
    je .word_found
    cmp al, 32
    je .word_found
    cmp al, ','
    je .word_found
    cmp al, '['
    je .word_found
    cmp al, ']'
    je .word_found
    cmp al, '+'
    je .word_found
    cmp al, '-'
    je .word_found
    cmp al, '*'
    je .word_found
    cmp al, ':'
    je .word_found
    cmp al, '('
    je .word_found
    cmp al, ')'
    je .word_found
    cmp al, '{'
    je .word_found
    cmp al, '}'
    je .word_found
    cmp al, '.'
    je .word_found
    cmp al, '='
    je .word_found
    cmp al, '<'
    je .word_found
    cmp al, '>'
    je .word_found
    cmp al, '/'
    je .word_found
    cmp al, '&'
    je .word_found
    cmp al, '|'
    je .word_found
    cmp al, '!'
    je .word_found
    cmp al, '~'
    je .word_found
    cmp al, '%'
    je .word_found
    cmp al, '^'
    je .word_found
    cmp al, ';'
    je .word_found
    inc rsi
    jmp .find_word_end

.handle_punct:
    mov r15, rsi
    inc rsi
    jmp .word_found

.word_found:
    mov r13, rsi
    sub r13, r15
    
    call GetTokenInfo

    cmp byte [is_selecting], 1
    jne .draw_word

    ; CHAR BY CHAR RENDERING
    mov r14, rdx ; save color
    mov r10, r15 ; current char ptr
.c_loop:
    cmp r10, rsi
    jae .c_done
    
    mov rax, r10
    lea r9, [text_buffer]
    sub rax, r9
    
    cmp rax, [sel_min]
    jb .no_sel_c
    cmp rax, [sel_max]
    jae .no_sel_c
    
    mov rcx, rbx
    mov rdx, 0x00AA5500
    call SetBkColor
    mov rcx, rbx
    mov rdx, 2
    call SetBkMode
    jmp .c_draw
    
.no_sel_c:
    mov rcx, rbx
    mov rdx, 0x001B1B1B
    call SetBkColor
    mov rcx, rbx
    mov rdx, 1
    call SetBkMode

.c_draw:
    sub rsp, 32
    mov rcx, rbx
    mov rdx, r14
    call SetTextColor
    add rsp, 32

    sub rsp, 48
    mov rcx, rbx
    mov edx, [current_x]
    mov r8d, [current_y]
    mov r9, r10
    mov dword [rsp+32], 1
    call TextOutA
    add rsp, 48

    sub rsp, 48
    mov rcx, rbx
    mov rdx, r10
    mov r8d, 1
    lea r9, [textSize]
    call GetTextExtentPoint32A
    add rsp, 48
    mov eax, [textSize]
    add [current_x], eax

    inc r10
    jmp .c_loop
.c_done:
    ; Restore transparency
    mov rcx, rbx
    mov rdx, 1
    call SetBkMode
    jmp .render_loop

.draw_word:
    sub rsp, 32
    mov rcx, rbx
    call SetTextColor
    add rsp, 32

    sub rsp, 48
    mov rcx, rbx
    mov edx, [current_x]
    mov r8d, [current_y]
    mov r9, r15
    mov dword [rsp+32], r13d
    call TextOutA
    add rsp, 48

    sub rsp, 48
    mov rcx, rbx
    mov rdx, r15
    mov r8d, r13d
    lea r9, [textSize]
    call GetTextExtentPoint32A
    add rsp, 48

    mov eax, [textSize]
    add [current_x], eax

    jmp .render_loop

.handle_space:
    mov rax, rsi
    lea r9, [text_buffer]
    sub rax, r9
    
    cmp byte [is_selecting], 1
    jne .do_space_adv
    
    cmp rax, [sel_min]
    jb .do_space_adv
    cmp rax, [sel_max]
    jae .do_space_adv
    
    mov rcx, rbx
    mov rdx, 0x00AA5500
    call SetBkColor
    mov rcx, rbx
    mov rdx, 2
    call SetBkMode
    
    sub rsp, 48
    mov rcx, rbx
    mov edx, [current_x]
    mov r8d, [current_y]
    mov r9, rsi
    mov dword [rsp+32], 1
    call TextOutA
    add rsp, 48

    mov rcx, rbx
    mov rdx, 1
    call SetBkMode

.do_space_adv:
    add dword [current_x], 11
    inc rsi
    jmp .render_loop

.handle_cr:
    inc rsi
    jmp .render_loop

.handle_lf:
    mov dword [current_x], 260
    add dword [current_y], 24
    inc dword [current_line_num]
    mov byte [is_new_line], 1
    inc rsi
    jmp .render_loop

.render_done:
    mov rax, rsi
    lea r9, [text_buffer]
    sub rax, r9
    cmp rax, [cursor_pos]
    jne .draw_caret
    mov eax, [current_x]
    mov [cursor_x], eax
    mov eax, [current_y]
    mov [cursor_y], eax

.draw_caret:
    cmp dword [cursor_x], -1
    je .clear_clip

    sub rsp, 32
    mov rcx, [cursor_x]
    mov rdx, [cursor_y]
    call SetCaretPos
    add rsp, 32

.clear_clip:
    sub rsp, 32
    mov rcx, rbx
    mov rdx, 0
    call SelectClipRgn
    add rsp, 32

    mov rcx, 0x00AAAAAA
    call SetTextColor
    
    add dword [termRect+4], 10
    add dword [termRect], 10

    sub rsp, 32
    mov rcx, rbx
    lea rdx, [output_buffer]
    mov r8d, [output_len]
    lea r9, [termRect]
    mov dword [rsp+32], 0
    call DrawTextA
    add rsp, 32

    ; RENDER STATUS BAR
    sub rsp, 48
    mov rcx, rbx
    mov edx, 210
    mov r8d, [clientRect+12]
    sub r8d, 18
    lea r9, [strLine]
    mov dword [rsp+32], 6
    call TextOutA
    add rsp, 48

    mov eax, [cursor_absolute_line]
    inc eax
    call itoa
    mov r14, rdi
    mov r15, rdi
.sln_len:
    cmp byte [r15], 0
    je .sln_done
    inc r15
    jmp .sln_len
.sln_done:
    sub r15, r14
    sub rsp, 48
    mov rcx, rbx
    mov edx, 260
    mov r8d, [clientRect+12]
    sub r8d, 18
    mov r9, r14
    mov dword [rsp+32], r15d
    call TextOutA
    add rsp, 48

    sub rsp, 48
    mov rcx, rbx
    mov edx, 300
    mov r8d, [clientRect+12]
    sub r8d, 18
    lea r9, [strCol]
    mov dword [rsp+32], 7
    call TextOutA
    add rsp, 48

    mov eax, [cursor_absolute_col]
    call itoa
    mov r14, rdi
    mov r15, rdi
.scn_len:
    cmp byte [r15], 0
    je .scn_done
    inc r15
    jmp .scn_len
.scn_done:
    sub r15, r14
    sub rsp, 48
    mov rcx, rbx
    mov edx, 360
    mov r8d, [clientRect+12]
    sub r8d, 18
    mov r9, r14
    mov dword [rsp+32], r15d
    call TextOutA
    add rsp, 48

    sub rsp, 48
    mov rcx, rbx
    mov edx, 400
    mov r8d, [clientRect+12]
    sub r8d, 18
    lea r9, [strEnc]
    mov dword [rsp+32], 18
    call TextOutA
    add rsp, 48

.finish_paint:
    mov rcx, r12
    lea rdx, [ps]
    call EndPaint
    xor rax, rax
    jmp .end_wndproc

.wm_destroy:
    mov rcx, [hFont]
    call DeleteObject
    xor rcx, rcx
    call PostQuitMessage
    xor rax, rax

.end_wndproc:
    add rsp, 144
    pop r15
    pop r14
    pop r13
    pop r12
    pop rdi
    pop rbx
    pop rbp
    ret


SwitchTab:
    push rcx
    push rsi
    push rdi
    push rax
    
    mov eax, [active_tab]
    xor eax, 1
    mov [active_tab], eax
    
    mov rcx, (tab_state_end - tab_state_start) / 8
    lea rsi, [tab_state_start]
    lea rdi, [inactive_tab_state]
.swap_loop:
    mov rax, [rsi]
    mov r8, [rdi]
    mov [rsi], r8
    mov [rdi], rax
    add rsi, 8
    add rdi, 8
    dec rcx
    jnz .swap_loop
    
    pop rax
    pop rdi
    pop rsi
    pop rcx
    ret
