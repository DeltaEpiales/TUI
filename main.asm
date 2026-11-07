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



extern AllocConsole

extern GetConsoleWindow

extern FreeConsole

extern SetParent

extern SetWindowPos

extern MoveWindow

extern GetWindowLongPtrA

extern SetWindowLongPtrA



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

extern SHBrowseForFolderA

extern SHGetPathFromIDListA

extern CoTaskMemFree

extern OleInitialize

extern OleUninitialize

extern CoCreateInstance

extern WideCharToMultiByte



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

    is_term_visible dd 0

    hConsole dq 0

    className db 'AsmGuiEditor', 0

    windowTitle db 'AssemblIDE - Native Assembly Editor', 0

    fontName db 'Consolas', 0

    searchPattern db '*', 0

    dirDlgTitle db 'Select Directory - AssemblIDE', 0

    

    ; Custom Top Bar Buttons

    btnNew db ' NEW ', 0

    btnOpen db ' OPEN ', 0

    btnSave db ' SAVE ', 0

    btnRun db ' RUN ', 0

    btnOpenDir db ' OPEN DIR ', 0

    btnTerminal db ' TERMINAL ', 0

    btnPlugins db ' PLUGINS ', 0

    btnExit db ' EXIT ', 0

    btnTab1 db ' TAB 1 ', 0

    btnTab2 db ' TAB 2 ', 0



    strExplorer db 'EXPLORER', 0

    strDirPrefix db '[DIR] ', 0

    strParentDir db '.. (parent)', 0

    strFilePrefix db '  ', 0

    strBrand db 'AssemblIDE v2.0', 0

    strTargetArch db 'x86-64 NASM', 0

    pluginsCmd db 'cmd.exe /c start "AssemblIDE Plugin Market" cmd.exe /k "asm-plugin.bat market"', 0



    CLSID_FileOpenDialog:

        dd 0xDC1C5A9C

        dw 0xE88A, 0x4DDE

        db 0xA5, 0xA1, 0x60, 0xF8, 0x2A, 0x20, 0xAE, 0xF7



    IID_IFileOpenDialog:

        dd 0x42F85136

        dw 0xDB7E, 0x439C

        db 0x85, 0xF1, 0xE4, 0x07, 0x5D, 0x13, 0x5F, 0xC8



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

    

    browse_info resb 64

    dispName resb 260

    pDialog resq 1

    pItem resq 1

    pPathW resq 1

    dlgOptions resd 1

    current_dir_path resb 260

    current_dir_name resb 64

    search_pattern resb 300

    app_dir resb 260

    find_data resb 320

    file_list resb 66560

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

    sub rsp, 48



    ; Initialize OLE/COM for native folder dialogs

    xor rcx, rcx

    call OleInitialize

    ; Record application base directory
    mov rcx, 260
    lea rdx, [app_dir]
    call GetCurrentDirectoryA



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

    xor rcx, rcx                ; Clean solid window (no WS_EX_LAYERED!)

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



PickFolderModern:

    ; Native Windows 11/10 COM IFileOpenDialog with FOS_PICKFOLDERS
    ; Parameters: rcx = hwndParent, rdx = outBuffer (260 bytes)
    ; Returns eax = 1 on success (path in outBuffer), 0 on cancel/failure

    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    push rbx
    sub rsp, 120

    mov r12, rcx                ; hwndParent
    mov r13, rdx                ; outBuffer
    xor r14d, r14d              ; Default result = 0 (cancel/failure)
    mov qword [pDialog], 0
    mov qword [pItem], 0

    ; CoCreateInstance(&CLSID_FileOpenDialog, NULL, CLSCTX_INPROC_SERVER, &IID_IFileOpenDialog, &pDialog)
    lea rcx, [CLSID_FileOpenDialog]
    xor rdx, rdx
    mov r8d, 1                  ; CLSCTX_INPROC_SERVER
    lea r9, [IID_IFileOpenDialog]
    lea rax, [pDialog]
    mov [rsp + 32], rax
    call CoCreateInstance

    test eax, eax
    jnz .pf_fail

    ; pDialog->GetOptions(&dlgOptions) (vtable offset 10 * 8 = 80)
    mov rcx, [pDialog]
    mov rax, [rcx]
    lea rdx, [dlgOptions]
    call [rax + 80]

    ; pDialog->SetOptions(dlgOptions | FOS_PICKFOLDERS (0x20) | FOS_FORCEFILESYSTEM (0x40)) (vtable offset 9 * 8 = 72)
    mov edx, [dlgOptions]
    or edx, 0x60
    mov rcx, [pDialog]
    mov rax, [rcx]
    call [rax + 72]

    ; pDialog->Show(hwndParent) (vtable offset 3 * 8 = 24)
    mov rcx, [pDialog]
    mov rax, [rcx]
    mov rdx, r12
    call [rax + 24]

    test eax, eax
    jnz .pf_release_dialog      ; User cancelled folder picker

    ; pDialog->GetResult(&pItem) (vtable offset 20 * 8 = 160)
    mov rcx, [pDialog]
    mov rax, [rcx]
    lea rdx, [pItem]
    call [rax + 160]

    test eax, eax
    jnz .pf_release_dialog

    ; pItem->GetDisplayName(SIGDN_FILESYSPATH (0x80058000), &pPathW) (vtable offset 5 * 8 = 40)
    mov rcx, [pItem]
    mov rax, [rcx]
    mov edx, 0x80058000
    lea r8, [pPathW]
    call [rax + 40]

    test eax, eax
    jnz .pf_release_item

    ; Convert wchar_t path to ANSI: WideCharToMultiByte(CP_ACP, 0, pPathW, -1, outBuffer, 260, NULL, NULL)
    xor ecx, ecx
    xor edx, edx
    mov r8, [pPathW]
    mov r9d, -1
    mov [rsp + 32], r13
    mov dword [rsp + 40], 260
    mov qword [rsp + 48], 0
    mov qword [rsp + 56], 0
    call WideCharToMultiByte

    ; Free wchar string allocated by shell
    mov rcx, [pPathW]
    call CoTaskMemFree

    mov r14d, 1                 ; Marked as SUCCESS!

.pf_release_item:
    mov rcx, [pItem]
    test rcx, rcx
    jz .pf_release_dialog
    mov rax, [rcx]
    call [rax + 16]             ; pItem->Release()

.pf_release_dialog:
    mov rcx, [pDialog]
    test rcx, rcx
    jz .pf_fail
    mov rax, [rcx]
    call [rax + 16]             ; pDialog->Release()

.pf_fail:
    mov eax, r14d

.pf_done:
    add rsp, 120
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret



; ==============================================================
; UpdateCurrentDirName
; Extracts the last directory component from current_dir_path into current_dir_name
; ==============================================================
UpdateCurrentDirName:
    push rbp
    mov rbp, rsp
    push rsi
    push rdi
    push rbx
    sub rsp, 48

    ; If current_dir_path is empty, fetch working directory from OS
    cmp byte [current_dir_path], 0
    jne .ucd_has_path

    mov rcx, 260
    lea rdx, [current_dir_path]
    call GetCurrentDirectoryA

.ucd_has_path:
    ; Find length of current_dir_path
    lea rsi, [current_dir_path]
    xor ecx, ecx
.ucd_len:
    mov al, [rsi + rcx]
    test al, al
    jz .ucd_len_done
    inc ecx
    jmp .ucd_len

.ucd_len_done:
    test ecx, ecx
    jz .ucd_empty

    ; Scan backwards from ecx-1 to find last backslash
    mov eax, ecx
    dec eax
    cmp eax, 2
    jbe .ucd_is_root
    cmp byte [rsi + rax], '\'
    jne .ucd_scan_back
    dec eax

.ucd_scan_back:
    cmp eax, 0
    jl .ucd_take_start
    cmp byte [rsi + rax], '\'
    je .ucd_found_slash
    dec eax
    jmp .ucd_scan_back

.ucd_found_slash:
    inc eax                     ; eax = index of first char of folder name
    jmp .ucd_do_copy

.ucd_is_root:
    xor eax, eax
    jmp .ucd_do_copy

.ucd_take_start:
    xor eax, eax

.ucd_do_copy:
    lea rsi, [current_dir_path]
    add rsi, rax
    lea rdi, [current_dir_name]
    xor ebx, ebx
.ucd_copy_loop:
    mov al, [rsi]
    cmp al, 0
    je .ucd_copy_end
    cmp al, '\'
    je .ucd_copy_end
    mov [rdi], al
    inc rsi
    inc rdi
    inc ebx
    cmp ebx, 60
    jb .ucd_copy_loop

.ucd_copy_end:
    mov byte [rdi], 0

.ucd_empty:
    add rsp, 48
    pop rbx
    pop rdi
    pop rsi
    pop rbp
    ret



; ==============================================================
; LoadFiles
; Enumerates files in current_dir_path into file_list
; ==============================================================
LoadFiles:
    push rbp
    mov rbp, rsp
    push r14
    push r15
    push rdi
    push rsi
    sub rsp, 64

    call UpdateCurrentDirName

    mov dword [file_count], 0

    ; Construct search_pattern: current_dir_path + "\*"
    lea rsi, [current_dir_path]
    lea rdi, [search_pattern]

.pat_copy:
    lodsb
    stosb
    test al, al
    jnz .pat_copy

    dec rdi                     ; points to null terminator
    dec rdi                     ; points to last char of current_dir_path
    cmp byte [rdi], '\'
    je .pat_add_star
    inc rdi
    mov byte [rdi], '\'

.pat_add_star:
    inc rdi
    mov byte [rdi], '*'
    inc rdi
    mov byte [rdi], 0

    ; FindFirstFileA(search_pattern, &find_data)
    lea rcx, [search_pattern]
    lea rdx, [find_data]
    call FindFirstFileA

    cmp rax, -1
    je .load_files_done
    mov r14, rax                ; r14 = FindHandle

.read_loop:
    mov eax, [file_count]
    cmp eax, 256
    jae .close_find

    ; Skip single dot "." directory entry
    cmp byte [find_data + 44], '.'
    jne .not_dot_entry
    cmp byte [find_data + 45], 0
    je .next_dir_entry

.not_dot_entry:
    ; Store entry into file_list + eax * 260
    imul eax, 260
    lea rdi, [file_list]
    add rdi, rax
    lea rsi, [find_data + 44]

.copy_name:
    lodsb
    stosb
    test al, al
    jnz .copy_name

    ; If it's a directory, append '\'
    mov eax, [find_data]
    test eax, 0x10              ; FILE_ATTRIBUTE_DIRECTORY
    jz .not_dir
    dec rdi                     ; point back to null terminator
    mov byte [rdi], '\'        ; append '\'
    mov byte [rdi+1], 0

.not_dir:
    inc dword [file_count]

.next_dir_entry:
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

    cmp r13, 20                     ; WM_ERASEBKGND

    je .wm_erasebkgnd

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

    cmp r10d, 68

    jb .mm_b1

    cmp r10d, 76

    jb .mm_check

    cmp r10d, 142

    jb .mm_b2

    cmp r10d, 150

    jb .mm_check

    cmp r10d, 216

    jb .mm_b3

    cmp r10d, 224

    jb .mm_check

    cmp r10d, 288

    jb .mm_b4

    cmp r10d, 298

    jb .mm_check

    cmp r10d, 404

    jb .mm_b5

    cmp r10d, 412

    jb .mm_check

    cmp r10d, 520

    jb .mm_b6

    cmp r10d, 528

    jb .mm_check

    cmp r10d, 616

    jb .mm_b7

    cmp r10d, 624

    jb .mm_check

    cmp r10d, 684

    jb .mm_b8

    cmp r10d, 700

    jb .mm_check

    cmp r10d, 770

    jb .mm_b9

    cmp r10d, 778

    jb .mm_check

    cmp r10d, 848

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

    je near .click_open_dir

    cmp r8d, 6

    je near .click_terminal

    cmp r8d, 7

    je near .click_plugins

    cmp r8d, 8

    je near .click_exit

    cmp r8d, 9

    je near .click_tab1

    cmp r8d, 10

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



    ; If terminal is visible, ignore clicks in terminal region (y >= clientHeight - 220)

    cmp dword [is_term_visible], 1

    jne .chk_sidebar_editor

    mov eax, [clientRect+12]

    sub eax, 220

    cmp r11d, eax

    jae .end_wndproc

.chk_sidebar_editor:

    cmp r10d, 200

    ja .editor_click

    

    ; SIDEBAR CLICK (files start at y=94 below directory header)
    mov eax, r11d
    sub eax, 94
    js .end_wndproc
    mov ecx, 20
    xor edx, edx
    div ecx
    cmp eax, [file_count]
    jae .end_wndproc

    imul eax, 260
    lea rsi, [file_list]
    add rsi, rax                ; rsi points to clicked item

    ; Check if item is ".." (Parent directory)
    cmp byte [rsi], '.'
    jne .sb_chk_dir
    cmp byte [rsi+1], '.'
    jne .sb_chk_dir
    cmp byte [rsi+2], '\'
    jne .sb_chk_dir

    ; --- PARENT DIRECTORY ".." CLICKED ---
    lea rdi, [current_dir_path]
    xor ecx, ecx
.sb_up_len:
    mov al, [rdi + rcx]
    test al, al
    jz .sb_up_len_done
    inc ecx
    jmp .sb_up_len

.sb_up_len_done:
    ; If length <= 3 (e.g. "C:\"), cannot go up
    cmp ecx, 3
    jbe .sb_repaint

    mov eax, ecx
    dec eax
    cmp byte [rdi + rax], '\'
    jne .sb_up_scan
    dec eax

.sb_up_scan:
    cmp eax, 0
    jle .sb_repaint
    cmp byte [rdi + rax], '\'
    je .sb_up_found
    dec eax
    jmp .sb_up_scan

.sb_up_found:
    ; If backslash is at index 2 (e.g. "C:\"), truncate at index 3 so "C:\" remains
    cmp eax, 2
    jne .sb_up_truncate
    mov byte [rdi + 3], 0
    jmp .sb_up_apply

.sb_up_truncate:
    mov byte [rdi + rax], 0

.sb_up_apply:
    sub rsp, 32
    lea rcx, [current_dir_path]
    call SetCurrentDirectoryA
    add rsp, 32

    mov dword [scroll_y], 0
    call LoadFiles
    jmp near .force_repaint

.sb_chk_dir:
    ; Check if item is a subdirectory (ends with '\')
    mov rdx, rsi
.sb_find_end:
    mov al, [rdx]
    test al, al
    jz .sb_found_end
    inc rdx
    jmp .sb_find_end

.sb_found_end:
    dec rdx                     ; points to last char
    cmp byte [rdx], '\'
    jne .sb_is_file

    ; --- SUBDIRECTORY CLICKED ---
    ; Append subdir name to current_dir_path
    lea rdi, [current_dir_path]
.sb_cdp_end:
    mov al, [rdi]
    test al, al
    jz .sb_cdp_found_end
    inc rdi
    jmp .sb_cdp_end

.sb_cdp_found_end:
    lea rax, [current_dir_path]
    cmp rdi, rax
    je .sb_cdp_add_slash
    dec rdi
    cmp byte [rdi], '\'
    je .sb_cdp_slash_ok
    inc rdi

.sb_cdp_add_slash:
    mov byte [rdi], '\'
    inc rdi

.sb_cdp_slash_ok:
    ; Copy from rsi up to (but not including) trailing '\'
.sb_append_sub:
    mov al, [rsi]
    cmp al, '\'
    je .sb_append_done
    cmp al, 0
    je .sb_append_done
    mov [rdi], al
    inc rsi
    inc rdi
    jmp .sb_append_sub

.sb_append_done:
    mov byte [rdi], 0

    sub rsp, 32
    lea rcx, [current_dir_path]
    call SetCurrentDirectoryA
    add rsp, 32

    mov dword [scroll_y], 0
    call LoadFiles
    jmp near .force_repaint

.sb_is_file:
    ; --- REGULAR FILE CLICKED ---
    ; Construct absolute path in filename: current_dir_path + "\" + file_name
    lea rdi, [filename]
    lea rdx, [current_dir_path]

.sb_fn_cdp:
    mov al, [rdx]
    test al, al
    jz .sb_fn_cdp_done
    mov [rdi], al
    inc rdx
    inc rdi
    jmp .sb_fn_cdp

.sb_fn_cdp_done:
    dec rdi
    cmp byte [rdi], '\'
    je .sb_fn_has_slash
    inc rdi
    mov byte [rdi], '\'

.sb_fn_has_slash:
    inc rdi

.sb_fn_copy:
    lodsb
    stosb
    test al, al
    jnz .sb_fn_copy

    jmp near .load_filename_and_repaint

.sb_repaint:
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

    ; Modern Windows 11 Explorer Folder Browser via COM IFileOpenDialog
    mov rcx, r12
    lea rdx, [filename]
    call PickFolderModern
    test eax, eax
    jz .end_wndproc             ; User cancelled, do nothing

    ; Success! Copy filename to current_dir_path
    lea rsi, [filename]
    lea rdi, [current_dir_path]
.od_copy_cur_path:
    lodsb
    stosb
    test al, al
    jnz .od_copy_cur_path

    ; Synchronize OS working directory for child processes/cmd
    sub rsp, 32
    lea rcx, [current_dir_path]
    call SetCurrentDirectoryA
    add rsp, 32

    ; Reset scroll position and reload files
    mov dword [scroll_y], 0
    call LoadFiles
    jmp near .force_repaint

.click_plugins:

    sub rsp, 112

    lea rdi, [startup_info]
    mov rcx, 104
    xor al, al
    rep stosb
    mov dword [startup_info], 104

    xor rcx, rcx
    lea rdx, [pluginsCmd]
    xor r8, r8
    xor r9, r9
    mov qword [rsp+32], 0       ; bInheritHandles = FALSE
    mov qword [rsp+40], 0       ; dwCreationFlags
    mov qword [rsp+48], 0       ; lpEnvironment
    lea rax, [app_dir]
    mov qword [rsp+56], rax     ; lpCurrentDirectory = app_dir (always finds asm-plugin.bat)
    lea rax, [startup_info]
    mov qword [rsp+64], rax
    lea rax, [process_info]
    mov qword [rsp+72], rax
    call CreateProcessA

    test rax, rax
    jz .cp_skip_close

    sub rsp, 32
    mov rcx, [process_info]
    call CloseHandle
    mov rcx, [process_info+8]
    call CloseHandle
    add rsp, 32

.cp_skip_close:
    add rsp, 112
    jmp near .force_repaint

.click_terminal:

    cmp qword [hConsole], 0

    jne .term_already_created



    ; Allocate console for this process

    sub rsp, 32

    call AllocConsole

    call GetConsoleWindow

    add rsp, 32

    test rax, rax

    jz .term_done

    mov [hConsole], rax



    ; Strip caption, borders: WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS

    sub rsp, 32

    mov rcx, [hConsole]

    mov rdx, -16                ; GWL_STYLE

    call GetWindowLongPtrA

    add rsp, 32



    and eax, 0x7EBBFFFF

    or eax, 0x54000000



    sub rsp, 48

    mov rcx, [hConsole]

    mov rdx, -16

    mov r8, rax

    call SetWindowLongPtrA

    add rsp, 48



    ; Dock console to main window (r12 = hWnd)

    sub rsp, 32

    mov rcx, [hConsole]

    mov rdx, r12

    call SetParent

    add rsp, 32



    ; Launch cmd.exe inside this console

    lea rdi, [startup_info]

    mov rcx, 104

    xor al, al

    rep stosb

    mov dword [startup_info], 104



    sub rsp, 112

    xor rcx, rcx

    lea rdx, [cmdExe]

    xor r8, r8

    xor r9, r9

    mov dword [rsp+32], 0

    mov dword [rsp+40], 0       ; Inherit console!

    mov qword [rsp+48], 0

    mov qword [rsp+56], 0

    lea rax, [startup_info]

    mov qword [rsp+64], rax

    lea rax, [process_info]

    mov qword [rsp+72], rax

    call CreateProcessA

    add rsp, 112



    mov dword [is_term_visible], 1

    call .ResizeDockedTerm

    jmp .term_focus



.term_already_created:

    ; Toggle visibility

    xor dword [is_term_visible], 1

    cmp dword [is_term_visible], 1

    jne .hide_term



    ; Show docked terminal

    sub rsp, 32

    mov rcx, [hConsole]

    mov rdx, 5                  ; SW_SHOW

    call ShowWindow

    add rsp, 32

    call .ResizeDockedTerm

.term_focus:

    sub rsp, 32

    mov rcx, [hConsole]

    call SetFocus

    add rsp, 32

    jmp .term_done



.hide_term:

    sub rsp, 32

    mov rcx, [hConsole]

    mov rdx, 0                  ; SW_HIDE

    call ShowWindow

    add rsp, 32

    sub rsp, 32

    mov rcx, r12

    call SetFocus

    add rsp, 32



.term_done:

    jmp near .force_repaint



.ResizeDockedTerm:

    sub rsp, 72                 ; 72 + 8 = 80 (aligned to 16 bytes!)

    mov rcx, r12

    lea rdx, [clientRect]

    call GetClientRect



    mov eax, [clientRect+12]

    sub eax, 220                ; Y = clientHeight - 220

    mov r10d, [clientRect+8]

    sub r10d, 201               ; width = clientWidth - 201



    mov qword [rsp+32], r10     ; 5th param: cx (width)

    mov qword [rsp+40], 199     ; 6th param: cy (height = 199)

    mov qword [rsp+48], 0x0064  ; 7th param: SWP_NOZORDER | SWP_FRAMECHANGED | SWP_SHOWWINDOW



    mov rcx, [hConsole]         ; 1st param: hWnd

    xor rdx, rdx                ; 2nd param: hWndInsertAfter = NULL

    mov r8d, 201                ; 3rd param: X = 201

    mov r9d, eax                ; 4th param: Y = clientHeight - 220

    call SetWindowPos

    add rsp, 72

    ret



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



    ; Extract directory from filename and synchronize working directory
    lea rsi, [filename]
    mov rdi, rsi
    xor ebx, ebx                ; ebx = pointer to last slash

.co_find_slash:
    mov al, [rsi]
    test al, al
    jz .co_slash_done
    cmp al, '\'
    jne .co_not_slash
    mov rbx, rsi
.co_not_slash:
    inc rsi
    jmp .co_find_slash

.co_slash_done:
    test rbx, rbx
    jz .co_no_dir

    ; Copy directory part (up to last slash) into current_dir_path
    lea rsi, [filename]
    lea rdi, [current_dir_path]

.co_copy_dir_loop:
    cmp rsi, rbx
    jae .co_copy_dir_done
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    jmp .co_copy_dir_loop

.co_copy_dir_done:
    ; If directory was drive root (e.g. "C:"), keep the backslash ("C:\")
    lea rax, [filename + 2]
    cmp rbx, rax
    jne .co_cdp_terminate
    mov byte [rdi], '\'
    inc rdi

.co_cdp_terminate:
    mov byte [rdi], 0

    sub rsp, 32
    lea rcx, [current_dir_path]
    call SetCurrentDirectoryA
    add rsp, 32

.co_no_dir:
    call LoadFiles

.load_filename_and_repaint:

    sub rsp, 64

    lea rcx, [filename]

    mov rdx, 0x80000000

    mov r8, 1

    xor r9, r9

    mov qword [rsp+32], 3       ; OPEN_EXISTING

    mov qword [rsp+40], 128     ; FILE_ATTRIBUTE_NORMAL

    mov qword [rsp+48], 0

    call CreateFileA

    add rsp, 64

    cmp rax, -1

    je .end_wndproc

    mov r14, rax



    sub rsp, 32

    mov rcx, r14

    xor rdx, rdx

    call GetFileSize

    add rsp, 32



    ; Clamp file size to max 1048575 bytes (1MB buffer)

    cmp rax, 1048575

    jbe .fs_ok

    mov rax, 1048575

.fs_ok:

    mov [text_len], rax

    mov qword [cursor_pos], 0   ; Cursor at start of file

    mov dword [scroll_y], 0     ; Scroll at top of file



    sub rsp, 48

    mov rcx, r14

    lea rdx, [text_buffer]

    mov r8, [text_len]

    lea r9, [bytesRead]

    mov qword [rsp+32], 0

    call ReadFile

    add rsp, 48



    ; Null-terminate text_buffer

    lea r8, [text_buffer]

    add r8, [text_len]

    mov byte [r8], 0



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

    mov dword [rsp+40], 0x08000000 ; CREATE_NO_WINDOW

    mov qword [rsp+48], 0

    mov qword [rsp+56], 0

    lea rax, [startup_info]

    mov qword [rsp+64], rax

    lea rax, [process_info]

    mov qword [rsp+72], rax

    call CreateProcessA

    add rsp, 112



    ; Wait for process to finish (max 3 seconds)

    sub rsp, 32

    mov rcx, [process_info]

    mov rdx, 3000

    call WaitForSingleObject

    add rsp, 32



    ; Close handles

    sub rsp, 32

    mov rcx, [process_info]

    call CloseHandle

    add rsp, 32

    sub rsp, 32

    mov rcx, [process_info+8]

    call CloseHandle

    add rsp, 32



    ; Read run.log into output_buffer

    sub rsp, 64

    lea rcx, [runLogFile]

    mov rdx, 0x80000000          ; GENERIC_READ

    mov r8, 1                   ; FILE_SHARE_READ

    xor r9, r9

    mov dword [rsp+32], 3       ; OPEN_EXISTING

    mov dword [rsp+40], 128     ; FILE_ATTRIBUTE_NORMAL

    mov qword [rsp+48], 0

    call CreateFileA

    add rsp, 64

    cmp rax, -1

    je .run_read_fail

    mov r14, rax



    sub rsp, 48

    mov rcx, r14

    lea rdx, [output_buffer]

    mov r8, 65535

    lea r9, [runlog_read]

    mov qword [rsp+32], 0

    call ReadFile

    add rsp, 48



    mov eax, [runlog_read]

    mov [output_len], rax



    sub rsp, 32

    mov rcx, r14

    call CloseHandle

    add rsp, 32



.run_read_fail:

    mov dword [is_term_visible], 1

    jmp near .force_repaint



.click_exit:

    mov rcx, 0

    call PostQuitMessage

    jmp .end_wndproc



.wm_size:

    cmp dword [is_term_visible], 1

    jne .wms_cont

    cmp qword [hConsole], 0

    je .wms_cont

    call .ResizeDockedTerm

.wms_cont:

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

    sub rsp, 48

    mov rcx, r12

    xor rdx, rdx

    mov r8, 1                   ; bErase = TRUE

    call InvalidateRect

    mov rcx, r12

    call UpdateWindow

    add rsp, 48

    

.end_wm_char:

    xor rax, rax

    jmp .end_wndproc



.wm_create:

    sub rsp, 112

    mov rcx, 20                 ; Height 20

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

    mov dword [rsp+88], 5       ; CLEARTYPE_QUALITY!

    mov dword [rsp+96], 49      ; FIXED_PITCH | FF_MODERN

    lea rax, [fontName]

    mov qword [rsp+104], rax

    call CreateFontA

    add rsp, 112

    mov [hFont], rax



    call LoadFiles



    xor rax, rax

    jmp .end_wndproc



.wm_erasebkgnd:

    mov rax, 1

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



    ; 1. Clear entire canvas with sleek obsidian editor background #111219 (BGR: 0x191211)

    mov rcx, 0x00191211

    call CreateSolidBrush

    mov r14, rax

    mov rcx, rbx

    lea rdx, [clientRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    ; 2. Top Bar #0B0C12 (BGR: 0x120C0B)

    mov rcx, 0x00120C0B

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



    ; (Static bottomRect removed: bottom panel is now fully dynamic)

    

    ; STATUS BAR - Modern sleek background #0B0C12 (BGR: 0x120C0B)

    mov rcx, 0x00120C0B

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



    ; 1px Divider above status bar #1F2233 (BGR: 0x33221F)

    mov rcx, 0x0033221F

    call CreateSolidBrush

    mov r14, rax

    mov dword [statusRect], 0

    mov eax, [clientRect+12]

    sub eax, 21

    mov dword [statusRect+4], eax

    mov eax, [clientRect+8]

    mov dword [statusRect+8], eax

    mov eax, [clientRect+12]

    sub eax, 20

    mov dword [statusRect+12], eax

    mov rcx, rbx

    lea rdx, [statusRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    ; Explorer Sidebar - Spans full height down to status bar

    mov rcx, 0x001C1312        ; Deep Obsidian-Slate #12131C (BGR: 0x1C1312)

    call CreateSolidBrush

    mov r14, rax

    mov dword [sideRect], 0

    mov dword [sideRect+4], 40

    mov dword [sideRect+8], 200

    mov eax, [clientRect+12]

    sub eax, 20

    mov dword [sideRect+12], eax

    mov rcx, rbx

    lea rdx, [sideRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    ; 1px Vertical Separator between sidebar and editor at x=199

    mov rcx, 0x00422E29        ; Slate divider #292E42 (BGR: 0x422E29)

    call CreateSolidBrush

    mov r14, rax

    mov dword [sideRect], 199

    mov dword [sideRect+4], 40

    mov dword [sideRect+8], 200

    mov eax, [clientRect+12]

    sub eax, 20

    mov dword [sideRect+12], eax

    mov rcx, rbx

    lea rdx, [sideRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    ; --- SIDEBAR HEADER: EXPLORER ---

    mov rcx, rbx

    mov rdx, 0x00F7A27A        ; Modern Blue-Violet #7AA2F7 (BGR: 0xF7A27A)

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 14

    mov r8d, 48

    lea r9, [strExplorer]

    mov qword [rsp+32], 8

    call TextOutA

    add rsp, 48



    ; Active Directory Name Badge: [DIR] <dir_name>

    mov rcx, rbx

    mov rdx, 0x0068AFE0        ; Warm Amber #E0AF68 (BGR: 0x68AFE0)

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 14

    mov r8d, 68

    lea r9, [strDirPrefix]

    mov qword [rsp+32], 6

    call TextOutA

    add rsp, 48



    lea r14, [current_dir_name]

    mov r15, r14

.cdn_calc_len:

    cmp byte [r15], 0

    je .cdn_len_done

    inc r15

    jmp .cdn_calc_len

.cdn_len_done:

    sub r15, r14

    test r15, r15

    jz .skip_cdn_print

    cmp r15d, 15

    jbe .cdn_len_ok

    mov r15d, 15

.cdn_len_ok:

    mov rcx, rbx

    mov rdx, 0x00FFFFFF        ; Pure White #FFFFFF

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 56

    mov r8d, 68

    mov r9, r14

    mov qword [rsp+32], r15

    call TextOutA

    add rsp, 48

.skip_cdn_print:



    ; 1px Horizontal Divider under directory header at y=88

    mov rcx, 0x00422E29

    call CreateSolidBrush

    mov r14, rax

    mov dword [topRect], 10

    mov dword [topRect+4], 88

    mov dword [topRect+8], 190

    mov dword [topRect+12], 89

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    ; File list starts at y=94 below directory header

    mov dword [current_y], 94

    mov dword [current_x], 14

    mov r13d, 0

.draw_files_loop:

    cmp r13d, [file_count]

    jae .draw_files_done

    mov eax, r13d

    imul eax, 260

    lea r14, [file_list]

    add r14, rax



    mov r15, r14

.len_loop:

    cmp byte [r15], 0

    je .len_done

    inc r15

    jmp .len_loop

.len_done:

    sub r15, r14

    test r15, r15

    jz .skip_file_draw



    ; If item is "..\\", draw parent directory label

    cmp byte [r14], '.'

    jne .chk_normal_item

    cmp byte [r14+1], '.'

    jne .chk_normal_item

    mov rcx, rbx

    mov rdx, 0x0068AFE0        ; Warm Amber #E0AF68

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, [current_x]

    mov r8d, [current_y]

    lea r9, [strParentDir]

    mov qword [rsp+32], 11

    call TextOutA

    add rsp, 48

    jmp .skip_file_draw



.chk_normal_item:

    ; Check if directory (ends with '\\')

    mov rax, r15

    dec rax

    cmp byte [r14 + rax], '\'

    je .is_directory_item



    ; Check file extension for color-coding:

    ; .asm / .inc -> Purple #BB9AF7 (BGR: 0xF79ABB)

    ; .bat / Makefile -> Emerald #73DACA (BGR: 0xCADA73)

    ; .c / .h / .cpp -> Cyan #7DCFFF (BGR: 0xFFCF7D)

    cmp r15, 4

    jb .use_default_file_color

    

    mov rax, r15

    sub rax, 4

    cmp dword [r14 + rax], 0x6D73612E ; '.asm'

    je .color_purple

    cmp dword [r14 + rax], 0x636E692E ; '.inc'

    je .color_purple

    cmp dword [r14 + rax], 0x7461622E ; '.bat'

    je .color_emerald

    

    cmp r15, 2

    jb .use_default_file_color

    mov rax, r15

    sub rax, 2

    cmp word [r14 + rax], 0x632E      ; '.c'

    je .color_cyan

    cmp word [r14 + rax], 0x682E      ; '.h'

    je .color_cyan



.use_default_file_color:

    mov rcx, rbx

    mov rdx, 0x00F0E8E2        ; Off-white #E2E8F0

    call SetTextColor

    jmp .clamp_and_draw



.color_purple:

    mov rcx, rbx

    mov rdx, 0x00F79ABB        ; Purple #BB9AF7

    call SetTextColor

    jmp .clamp_and_draw



.color_emerald:

    mov rcx, rbx

    mov rdx, 0x00CADA73        ; Mint Emerald #73DACA

    call SetTextColor

    jmp .clamp_and_draw



.color_cyan:

    mov rcx, rbx

    mov rdx, 0x00FFCF7D        ; Electric Cyan #7DCFFF

    call SetTextColor

    jmp .clamp_and_draw



.is_directory_item:

    mov rcx, rbx

    mov rdx, 0x0068AFE0        ; Warm Amber #E0AF68

    call SetTextColor



.clamp_and_draw:

    cmp r15d, 18

    jbe .len_ok

    mov r15d, 18

.len_ok:



.do_file_textout:

    sub rsp, 48

    mov rcx, rbx

    mov edx, [current_x]

    mov r8d, [current_y]

    mov r9, r14

    mov qword [rsp+32], r15

    call TextOutA

    add rsp, 48

.skip_file_draw:



    add dword [current_y], 20

    inc r13d

    jmp .draw_files_loop

.draw_files_done:

    ; Clear sidebar clipping region

    sub rsp, 32

    mov rcx, rbx

    xor rdx, rdx

    call SelectClipRgn

    add rsp, 32



    ; 1px Divider under topbar at y=39

    mov rcx, 0x0033221F

    call CreateSolidBrush

    mov r14, rax

    mov dword [topRect], 0

    mov dword [topRect+4], 39

    mov eax, [clientRect+8]

    mov dword [topRect+8], eax

    mov dword [topRect+12], 40

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    

    ; 1px Vertical divider right of sidebar at x=200

    mov dword [topRect], 200

    mov dword [topRect+4], 40

    mov dword [topRect+8], 201

    mov eax, [clientRect+12]

    sub eax, 20

    mov dword [topRect+12], eax

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    mov rcx, rbx

    mov rdx, 1                  ; TRANSPARENT text

    call SetBkMode



    ; Button 1: New (x: 10..68)

    mov r8d, 1

    call .DrawFlatBtn

    mov dword [topRect], 10

    mov dword [topRect+4], 6

    mov dword [topRect+8], 68

    mov dword [topRect+12], 34

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    mov rcx, rbx

    mov rdx, 0x00F0E8E2

    cmp dword [hover_btn], 1

    jne .b1_norm

    mov rdx, 0x00FFFFFF

.b1_norm:

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 18

    mov r8d, 10

    lea r9, [btnNew]

    mov dword [rsp+32], 5

    call TextOutA

    add rsp, 48



    ; Button 2: Open (x: 76..142)

    mov r8d, 2

    call .DrawFlatBtn

    mov dword [topRect], 76

    mov dword [topRect+4], 6

    mov dword [topRect+8], 142

    mov dword [topRect+12], 34

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    mov rcx, rbx

    mov rdx, 0x00F0E8E2

    cmp dword [hover_btn], 2

    jne .b2_norm

    mov rdx, 0x00FFFFFF

.b2_norm:

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 83

    mov r8d, 10

    lea r9, [btnOpen]

    mov dword [rsp+32], 6

    call TextOutA

    add rsp, 48



    ; Button 3: Save (x: 150..216)

    mov r8d, 3

    call .DrawFlatBtn

    mov dword [topRect], 150

    mov dword [topRect+4], 6

    mov dword [topRect+8], 216

    mov dword [topRect+12], 34

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    mov rcx, rbx

    mov rdx, 0x00F0E8E2

    cmp dword [hover_btn], 3

    jne .b3_norm

    mov rdx, 0x00FFFFFF

.b3_norm:

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 157

    mov r8d, 10

    lea r9, [btnSave]

    mov dword [rsp+32], 6

    call TextOutA

    add rsp, 48



    ; Button 4: Run (x: 224..288) -> Emerald accent!

    mov r8d, 4

    cmp r8d, [active_btn]

    jne .run_not_act

    mov rcx, 0x003F5E2B        ; Active #2B5E3F

    jmp .run_make_brush

.run_not_act:

    cmp r8d, [hover_btn]

    jne .run_not_hov

    mov rcx, 0x002B401C        ; Hover #1C402B

    jmp .run_make_brush

.run_not_hov:

    mov rcx, 0x001D2B13        ; Normal #132B1D

.run_make_brush:

    call CreateSolidBrush

    mov r14, rax

    mov dword [topRect], 224

    mov dword [topRect+4], 6

    mov dword [topRect+8], 288

    mov dword [topRect+12], 34

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    mov rcx, rbx

    mov rdx, 0x008DD048        ; Vibrant emerald text

    cmp dword [hover_btn], 4

    jne .b4_norm

    mov rdx, 0x00B1EB70

.b4_norm:

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 235

    mov r8d, 10

    lea r9, [btnRun]

    mov dword [rsp+32], 5

    call TextOutA

    add rsp, 48



    ; Button 5: Open Dir (x: 298..404)

    mov r8d, 5

    call .DrawFlatBtn

    mov dword [topRect], 298

    mov dword [topRect+4], 6

    mov dword [topRect+8], 404

    mov dword [topRect+12], 34

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    mov rcx, rbx

    mov rdx, 0x00F0E8E2

    cmp dword [hover_btn], 5

    jne .b5_norm

    mov rdx, 0x00FFFFFF

.b5_norm:

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 306

    mov r8d, 10

    lea r9, [btnOpenDir]

    mov dword [rsp+32], 10

    call TextOutA

    add rsp, 48



    ; Button 6: Terminal (x: 412..520)

    mov r8d, 6

    cmp dword [is_term_visible], 1

    jne .b6_use_flat

    mov rcx, 0x00563C35        ; Highlighted background if docked terminal is open!

    call CreateSolidBrush

    mov r14, rax

    jmp .b6_draw_rect

.b6_use_flat:

    call .DrawFlatBtn

.b6_draw_rect:

    mov dword [topRect], 412

    mov dword [topRect+4], 6

    mov dword [topRect+8], 520

    mov dword [topRect+12], 34

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    mov rcx, rbx

    mov rdx, 0x00F0E8E2

    cmp dword [is_term_visible], 1

    jne .b6_chk_hover

    mov rdx, 0x00F7A27A        ; Active blue accent text #7AA2F7

    jmp .b6_text_set

.b6_chk_hover:

    cmp dword [hover_btn], 6

    jne .b6_norm

    mov rdx, 0x00FFFFFF

.b6_norm:

.b6_text_set:

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 420

    mov r8d, 10

    lea r9, [btnTerminal]

    mov dword [rsp+32], 10

    call TextOutA

    add rsp, 48



    ; Button 7: Plugins (x: 528..616) -> Violet badge #BB9AF7

    mov r8d, 7

    call .DrawFlatBtn

    mov dword [topRect], 528

    mov dword [topRect+4], 6

    mov dword [topRect+8], 616

    mov dword [topRect+12], 34

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    mov rcx, rbx

    mov rdx, 0x00F79ABB        ; Violet accent #BB9AF7 (BGR: 0xF79ABB)

    cmp dword [hover_btn], 7

    jne .b7_norm

    mov rdx, 0x00FFFFFF

.b7_norm:

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 536

    mov r8d, 10

    lea r9, [btnPlugins]

    mov dword [rsp+32], 9

    call TextOutA

    add rsp, 48



    ; Button 8: Exit (x: 624..684)

    mov r8d, 8

    cmp r8d, [active_btn]

    jne .exit_not_act

    mov rcx, 0x002F235E

    jmp .exit_make_brush

.exit_not_act:

    cmp r8d, [hover_btn]

    jne .exit_not_hov

    mov rcx, 0x00221B3D

    jmp .exit_make_brush

.exit_not_hov:

    mov rcx, 0x00261A18

.exit_make_brush:

    call CreateSolidBrush

    mov r14, rax

    mov dword [topRect], 624

    mov dword [topRect+4], 6

    mov dword [topRect+8], 684

    mov dword [topRect+12], 34

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    mov rcx, rbx

    mov rdx, 0x00F0E8E2

    cmp dword [hover_btn], 8

    jne .b8_norm

    mov rdx, 0x00727BFF        ; Crimson accent on hover

.b8_norm:

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 634

    mov r8d, 10

    lea r9, [btnExit]

    mov dword [rsp+32], 6

    call TextOutA

    add rsp, 48



    ; Button 9: Tab 1 (x: 700..770)

    cmp dword [active_tab], 0

    jne .t1_inactive

    mov rcx, 0x00382622

    jmp .t1_fill

.t1_inactive:

    mov rcx, 0x001F1413

.t1_fill:

    call CreateSolidBrush

    mov r14, rax

    mov dword [topRect], 700

    mov dword [topRect+4], 6

    mov dword [topRect+8], 770

    mov dword [topRect+12], 34

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    cmp dword [active_tab], 0

    jne .t1_dim_txt

    mov rcx, rbx

    mov rdx, 0x00F7A27A

    call SetTextColor

    jmp .t1_print

.t1_dim_txt:

    mov rcx, rbx

    mov rdx, 0x00997C78

    call SetTextColor

.t1_print:

    sub rsp, 48

    mov rcx, rbx

    mov edx, 712

    mov r8d, 10

    lea r9, [btnTab1]

    mov dword [rsp+32], 7

    call TextOutA

    add rsp, 48



    ; Button 10: Tab 2 (x: 778..848)

    cmp dword [active_tab], 1

    jne .t2_inactive

    mov rcx, 0x00382622

    jmp .t2_fill

.t2_inactive:

    mov rcx, 0x001F1413

.t2_fill:

    call CreateSolidBrush

    mov r14, rax

    mov dword [topRect], 778

    mov dword [topRect+4], 6

    mov dword [topRect+8], 848

    mov dword [topRect+12], 34

    mov rcx, rbx

    lea rdx, [topRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    cmp dword [active_tab], 1

    jne .t2_dim_txt

    mov rcx, rbx

    mov rdx, 0x00F7A27A

    call SetTextColor

    jmp .t2_print

.t2_dim_txt:

    mov rcx, rbx

    mov rdx, 0x00997C78

    call SetTextColor

.t2_print:

    sub rsp, 48

    mov rcx, rbx

    mov edx, 790

    mov r8d, 10

    lea r9, [btnTab2]

    mov dword [rsp+32], 7

    call TextOutA

    add rsp, 48



    jmp .skip_flat_btn_helper



.DrawFlatBtn:

    sub rsp, 40

    cmp r8d, [active_btn]

    jne .dfb_not_act

    mov rcx, 0x00563C35        ; Active click #353C56

    jmp .dfb_make

.dfb_not_act:

    cmp r8d, [hover_btn]

    jne .dfb_not_hov

    mov rcx, 0x003D2A25        ; Hover #252A3D

    jmp .dfb_make

.dfb_not_hov:

    mov rcx, 0x00261A18        ; Default #181A26

.dfb_make:

    call CreateSolidBrush

    mov r14, rax

    add rsp, 40

    ret



.skip_flat_btn_helper:



    mov rcx, rbx

    mov rdx, 1

    call SetBkMode



    cmp dword [is_term_visible], 1

    jne .skip_term_paint



    ; 1px Divider above terminal panel at [clientRect+12] - 221

    mov rcx, 0x0033221F        ; #1F2233

    call CreateSolidBrush

    mov r14, rax

    mov dword [termRect], 200

    mov eax, [clientRect+12]

    sub eax, 221

    mov dword [termRect+4], eax

    mov eax, [clientRect+8]

    mov dword [termRect+8], eax

    mov eax, [clientRect+12]

    sub eax, 220

    mov dword [termRect+12], eax

    mov rcx, rbx

    lea rdx, [termRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



    ; Terminal background #0D0E15 (BGR: 0x150E0D)

    mov rcx, 0x00150E0D

    call CreateSolidBrush

    mov r14, rax

    mov dword [termRect], 201

    mov eax, [clientRect+12]

    sub eax, 220

    mov dword [termRect+4], eax

    mov eax, [clientRect+8]

    mov dword [termRect+8], eax

    mov eax, [clientRect+12]

    sub eax, 21

    mov dword [termRect+12], eax

    mov rcx, rbx

    lea rdx, [termRect]

    mov r8, r14

    call FillRect

    mov rcx, r14

    call DeleteObject



.skip_term_paint:



    ; Dynamic Editor Clipping: expands to full height when terminal is hidden!

    sub rsp, 48

    mov rcx, rbx

    mov rdx, 210

    mov r8, 40

    mov r9d, [clientRect+8]

    mov eax, [clientRect+12]

    sub eax, 21                 ; full height down to status bar

    cmp dword [is_term_visible], 1

    jne .clip_editor

    sub eax, 200                ; if terminal open: clip at clientHeight - 221

.clip_editor:

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

    

    mov rcx, 0x00281C19        ; Subtle obsidian line highlight #191C28

    call CreateSolidBrush

    mov r14, rax

    mov dword [highlightRect], 201

    mov eax, [current_y]

    mov dword [highlightRect+4], eax

    mov eax, [clientRect+8]

    mov dword [highlightRect+8], eax

    mov eax, [current_y]

    add eax, 20

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

    mov rdx, 0x00895F56        ; Elegant slate blue #565F89 (BGR: 0x895F56)

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



    cmp dword [is_term_visible], 1

    jne .skip_output_draw

    cmp qword [output_len], 0

    je .skip_output_draw



    mov rcx, rbx

    mov rdx, 0x00D6B1A9        ; Crisp Tokyo Night off-white #A9B1D6

    call SetTextColor

    

    mov dword [termRect], 215

    mov eax, [clientRect+12]

    sub eax, 210

    mov dword [termRect+4], eax

    mov eax, [clientRect+8]

    sub eax, 10

    mov dword [termRect+8], eax

    mov eax, [clientRect+12]

    sub eax, 25

    mov dword [termRect+12], eax



    sub rsp, 32

    mov rcx, rbx

    lea rdx, [output_buffer]

    mov r8d, [output_len]

    lea r9, [termRect]

    mov dword [rsp+32], 0

    call DrawTextA

    add rsp, 32

.skip_output_draw:



    ; RENDER STATUS BAR

    ; Left brand & project indicator

    mov rcx, rbx

    mov rdx, 0x00F7A27A        ; Modern Blue-Violet #7AA2F7

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 14

    mov r8d, [clientRect+12]

    sub r8d, 18

    lea r9, [strBrand]

    mov qword [rsp+32], 15

    call TextOutA

    add rsp, 48



    ; Active line & column in Gutter Slate

    mov rcx, rbx

    mov rdx, 0x00895F56        ; Slate Blue #565F89

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 260

    mov r8d, [clientRect+12]

    sub r8d, 18

    lea r9, [strLine]

    mov qword [rsp+32], 6

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

    mov edx, 450

    mov r8d, [clientRect+12]

    sub r8d, 18

    lea r9, [strEnc]

    mov qword [rsp+32], 18

    call TextOutA

    add rsp, 48



    ; Architecture Badge: x86-64 NASM

    mov rcx, rbx

    mov rdx, 0x00895F56

    call SetTextColor

    sub rsp, 48

    mov rcx, rbx

    mov edx, 620

    mov r8d, [clientRect+12]

    sub r8d, 18

    lea r9, [strTargetArch]

    mov qword [rsp+32], 11

    call TextOutA

    add rsp, 48



.finish_paint:

    mov rcx, r12

    lea rdx, [ps]

    call EndPaint

    xor rax, rax

    jmp .end_wndproc



.wm_destroy:

    cmp qword [hConsole], 0

    je .no_console_free

    call FreeConsole

.no_console_free:

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

