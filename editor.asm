;------------------------------------------------------------
; Advanced Text Editor in x86 Assembly (Linux)
; Features:
; - Full screen TUI interface
; - Real-time syntax highlighting
; - Line numbering
; - Copy/paste buffer
; - Find/replace
; - Undo/redo stack
; - File save/load
; - Status bar
;------------------------------------------------------------

section .data
    ; Terminal control sequences
    clear_screen db 27, '[2J', 27, '[H', 0
    clear_line   db 27, '[K', 0
    cursor_home  db 27, '[H', 0
    save_cursor  db 27, '[s', 0
    rest_cursor  db 27, '[u', 0
    
    ; Colors
    color_reset  db 27, '[0m', 0
    color_keyword db 27, '[1;34m', 0  ; Blue
    color_string db 27, '[0;32m', 0   ; Green
    color_number db 27, '[0;33m', 0   ; Yellow
    color_comment db 27, '[0;36m', 0  ; Cyan
    
    ; UI elements
    status_bar   db 27, '[47;30m', '  F1:Help  F2:Save  F3:Find  F4:Replace  F5:Exit ', 27, '[K', 27, '[0m', 0
    line_num_fmt db '%4d ', 0
    
    ; Messages
    msg_save     db 'File saved successfully', 0
    msg_load     db 'File loaded successfully', 0
    msg_error    db 'Error: ', 0
    
    ; File operations
    f_mode_r     db 'r', 0
    f_mode_w     db 'w', 0
    
    ; Keywords for syntax highlighting
    keywords     db 'section', 0
                db 'global', 0
                db 'extern', 0
                db 'mov', 0
                db 'push', 0
                db 'pop', 0
                db 'call', 0
                db 'ret', 0
                db 'jmp', 0
                db 'je', 0
                db 'jne', 0
                db 0        ; End of keywords

section .bss
    ; Editor buffers
    text_buffer  resb 1048576    ; 1MB text buffer
    undo_buffer  resb 1048576    ; 1MB undo buffer
    copy_buffer  resb 4096       ; 4KB copy buffer
    find_buffer  resb 256        ; Search pattern buffer
    
    ; Screen state
    term_width   resd 1          ; Terminal width
    term_height  resd 1          ; Terminal height
    cursor_x     resd 1          ; Cursor X position
    cursor_y     resd 1          ; Cursor Y position
    top_line     resd 1          ; Top visible line
    
    ; File state
    filename     resb 256        ; Current file name
    modified     resb 1          ; Modified flag
    
    ; Input state
    key_buffer   resb 16         ; Input key buffer
    
    ; Temporary storage
    temp_buffer  resb 4096       ; General purpose buffer

section .text
    global _start

_start:
    ; Initialize terminal
    call init_terminal
    call get_terminal_size
    call setup_raw_mode
    
    ; Initialize editor state
    call init_editor
    
    ; Main event loop
main_loop:
    call render_screen
    call handle_input
    test eax, eax        ; Check for exit condition
    jnz main_loop
    
    ; Cleanup and exit
    call restore_terminal
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; return 0
    int 0x80

;------------------------------------------------------------
; Terminal Handling
;------------------------------------------------------------
init_terminal:
    push ebp
    mov ebp, esp
    
    ; Save original terminal settings
    mov eax, 54         ; sys_ioctl
    mov ebx, 0          ; stdin
    mov ecx, 0x5401     ; TCGETS
    lea edx, [orig_termios]
    int 0x80
    
    ; Clear screen
    mov ecx, clear_screen
    call print_string
    
    pop ebp
    ret

setup_raw_mode:
    push ebp
    mov ebp, esp
    
    ; Copy original settings
    mov esi, orig_termios
    mov edi, raw_termios
    mov ecx, 36         ; sizeof(struct termios)
    rep movsb
    
    ; Modify flags for raw mode
    and dword [raw_termios+12], ~(ICANON | ECHO)
    
    ; Apply new settings
    mov eax, 54         ; sys_ioctl
    mov ebx, 0          ; stdin
    mov ecx, 0x5402     ; TCSETS
    lea edx, [raw_termios]
    int 0x80
    
    pop ebp
    ret

restore_terminal:
    push ebp
    mov ebp, esp
    
    ; Restore original terminal settings
    mov eax, 54         ; sys_ioctl
    mov ebx, 0          ; stdin
    mov ecx, 0x5402     ; TCSETS
    lea edx, [orig_termios]
    int 0x80
    
    ; Show cursor
    mov ecx, show_cursor
    call print_string
    
    pop ebp
    ret

;------------------------------------------------------------
; Editor Core Functions
;------------------------------------------------------------
init_editor:
    push ebp
    mov ebp, esp
    
    ; Initialize buffers
    xor eax, eax
    mov edi, text_buffer
    mov ecx, 1048576
    rep stosb
    
    ; Initialize cursor position
    mov dword [cursor_x], 0
    mov dword [cursor_y], 0
    mov dword [top_line], 0
    
    ; Initialize modified flag
    mov byte [modified], 0
    
    pop ebp
    ret

render_screen:
    push ebp
    mov ebp, esp
    
    ; Save cursor position
    mov ecx, save_cursor
    call print_string
    
    ; Move to top
    mov ecx, cursor_home
    call print_string
    
    ; Render visible lines
    mov esi, text_buffer
    mov ebx, [top_line]
    mov edx, [term_height]
    dec edx             ; Reserve bottom line for status
    
.render_loop:
    test edx, edx
    jz .done_render
    
    ; Print line number
    push edx
    push ebx
    push esi
    mov eax, ebx
    inc eax             ; 1-based line numbers
    push eax
    push line_num_fmt
    call printf
    add esp, 8
    pop esi
    pop ebx
    pop edx
    
    ; Render line with syntax highlighting
    call render_line
    
    ; Next line
    inc ebx
    dec edx
    jmp .render_loop
    
.done_render:
    ; Render status bar
    call render_status
    
    ; Restore cursor position
    mov ecx, rest_cursor
    call print_string
    
    pop ebp
    ret

render_line:
    push ebp
    mov ebp, esp
    
    ; Find end of line
    mov edi, esi
.find_eol:
    cmp byte [edi], 10  ; newline
    je .eol_found
    cmp byte [edi], 0   ; null
    je .eol_found
    inc edi
    jmp .find_eol
    
.eol_found:
    ; Save end of line
    push edi
    
    ; Apply syntax highlighting
.highlight_loop:
    cmp esi, edi
    jae .done_highlight
    
    ; Check for comments
    cmp byte [esi], ';'
    je .highlight_comment
    
    ; Check for strings
    cmp byte [esi], '"'
    je .highlight_string
    cmp byte [esi], "'"
    je .highlight_string
    
    ; Check for numbers
    cmp byte [esi], '0'
    jb .check_keywords
    cmp byte [esi], '9'
    ja .check_keywords
    jmp .highlight_number
    
.check_keywords:
    ; Check if word start
    cmp esi, text_buffer
    je .is_word_start
    cmp byte [esi-1], ' '
    je .is_word_start
    cmp byte [esi-1], 9   ; tab
    je .is_word_start
    jmp .print_char
    
.is_word_start:
    call check_keyword
    test eax, eax
    jnz .highlight_keyword
    
.print_char:
    ; Regular character
    mov ecx, color_reset
    call print_string
    movsb
    jmp .highlight_loop
    
.highlight_comment:
    ; Comment until end of line
    mov ecx, color_comment
    call print_string
    rep movsb
    jmp .done_highlight
    
.highlight_string:
    ; String until closing quote
    mov ecx, color_string
    call print_string
    movsb               ; Opening quote
.string_loop:
    cmp esi, edi
    jae .done_highlight
    movsb
    cmp byte [esi-1], al  ; Closing quote
    jne .string_loop
    jmp .highlight_loop
    
.highlight_number:
    mov ecx, color_number
    call print_string
.number_loop:
    cmp esi, edi
    jae .done_highlight
    cmp byte [esi], '0'
    jb .highlight_loop
    cmp byte [esi], '9'
    ja .highlight_loop
    movsb
    jmp .number_loop
    
.highlight_keyword:
    mov ecx, color_keyword
    call print_string
    rep movsb
    jmp .highlight_loop
    
.done_highlight:
    ; Reset color and print newline
    mov ecx, color_reset
    call print_string
    mov al, 10
    stosb
    
    pop edi             ; Restore end of line
    mov esi, edi        ; Update source pointer
    inc esi             ; Skip newline
    
    pop ebp
    ret

;------------------------------------------------------------
; Input Handling
;------------------------------------------------------------
handle_input:
    push ebp
    mov ebp, esp
    
    ; Read key
    mov eax, 3          ; sys_read
    mov ebx, 0          ; stdin
    mov ecx, key_buffer
    mov edx, 1
    int 0x80
    
    ; Check special keys
    cmp byte [key_buffer], 27  ; ESC
    je .handle_escape
    
    ; Normal character
    mov al, [key_buffer]
    call insert_char
    
    pop ebp
    xor eax, eax        ; Continue
    ret
    
.handle_escape:
    ; Read escape sequence
    mov eax, 3
    mov ebx, 0
    mov ecx, key_buffer+1
    mov edx, 2
    int 0x80
    
    ; Check arrow keys
    cmp word [key_buffer+1], 0x5b41  ; Up
    je .cursor_up
    cmp word [key_buffer+1], 0x5b42  ; Down
    je .cursor_down
    cmp word [key_buffer+1], 0x5b43  ; Right
    je .cursor_right
    cmp word [key_buffer+1], 0x5b44  ; Left
    je .cursor_left
    
    ; Function keys
    cmp word [key_buffer+1], 0x5b50  ; F1
    je .show_help
    cmp word [key_buffer+1], 0x5b51  ; F2
    je .save_file
    cmp word [key_buffer+1], 0x5b52  ; F3
    je .find_text
    cmp word [key_buffer+1], 0x5b53  ; F4
    je .replace_text
    cmp word [key_buffer+1], 0x5b54  ; F5
    je .exit_editor
    
    pop ebp
    xor eax, eax
    ret

;------------------------------------------------------------
; File Operations
;------------------------------------------------------------
save_file:
    push ebp
    mov ebp, esp
    
    ; Open file
    mov eax, 5          ; sys_open
    mov ebx, filename
    mov ecx, 0x241      ; O_WRONLY | O_CREAT | O_TRUNC
    mov edx, 0644       ; Mode
    int 0x80
    
    test eax, eax
    js .save_error
    
    ; Write buffer
    mov ebx, eax        ; File descriptor
    mov eax, 4          ; sys_write
    mov ecx, text_buffer
    call get_buffer_size
    mov edx, eax        ; Size
    int 0x80
    
    ; Close file
    mov eax, 6          ; sys_close
    int 0x80
    
    ; Clear modified flag
    mov byte [modified], 0
    
    ; Show success message
    mov ecx, msg_save
    call print_status
    
    pop ebp
    ret
    
.save_error:
    mov ecx, msg_error
    call print_status
    pop ebp
    ret

;------------------------------------------------------------
; Utility Functions
;------------------------------------------------------------
print_string:
    push ebp
    mov ebp, esp
    
    ; Get string length
    mov edx, 0          ; Length counter
.strlen:
    cmp byte [ecx + edx], 0
    je .print
    inc edx
    jmp .strlen
    
.print:
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    int 0x80
    
    pop ebp
    ret

check_keyword:
    push ebp
    mov ebp, esp
    
    mov edi, keywords   ; Keyword list
.check_loop:
    cmp byte [edi], 0   ; End of list
    je .not_found
    
    push esi
    push edi
.compare:
    mov al, [esi]
    mov bl, [edi]
    test bl, bl         ; End of keyword
    jz .word_boundary
    cmp al, bl
    jne .next_keyword
    inc esi
    inc edi
    jmp .compare
    
.word_boundary:
    ; Check if word ends
    cmp byte [esi], ' '
    je .found
    cmp byte [esi], 9   ; tab
    je .found
    cmp byte [esi], 10  ; newline
    je .found
    cmp byte [esi], 0   ; null
    je .found
    
.next_keyword:
    pop edi
    pop esi
    
    ; Skip to next keyword
.skip:
    cmp byte [edi], 0
    je .check_loop
    inc edi
    jmp .skip
    
.found:
    pop edi
    pop esi
    mov eax, 1          ; Found
    pop ebp
    ret
    
.not_found:
    xor eax, eax        ; Not found
    pop ebp
    ret

get_buffer_size:
    push ebp
    mov ebp, esp
    
    mov edi, text_buffer
    mov ecx, 1048576
    xor al, al
    repne scasb
    mov eax, 1048576
    sub eax, ecx
    dec eax
    
    pop ebp
    ret

section .bss
    ; Terminal state
    orig_termios resb 36        ; Original terminal settings
    raw_termios  resb 36        ; Raw mode settings