global GetTokenInfo
section .text
GetTokenInfo:
    mov rdx, 0x00CCCCCC

    cmp r13, 2
    je near .gt_len2
    cmp r13, 3
    je near .gt_len3
    cmp r13, 4
    je near .gt_len4
    cmp r13, 5
    je near .gt_len5
    cmp r13, 6
    je near .gt_len6
    cmp r13, 7
    je near .gt_len7
    cmp r13, 8
    je near .gt_len8
    cmp r13, 9
    je near .gt_len9
    cmp r13, 10
    je near .gt_len10
    cmp r13, 11
    je near .gt_len11
    cmp r13, 12
    je near .gt_len12
    ret
.gt_len2:
    cmp byte [r15], 'a'
    je near .l2_c_a
    cmp byte [r15], 'b'
    je near .l2_c_b
    cmp byte [r15], 'c'
    je near .l2_c_c
    cmp byte [r15], 'd'
    je near .l2_c_d
    cmp byte [r15], 'f'
    je near .l2_c_f
    cmp byte [r15], 'g'
    je near .l2_c_g
    cmp byte [r15], 'i'
    je near .l2_c_i
    cmp byte [r15], 'j'
    je near .l2_c_j
    cmp byte [r15], 'o'
    je near .l2_c_o
    cmp byte [r15], 'r'
    je near .l2_c_r
    cmp byte [r15], 's'
    je near .l2_c_s
    ret
.l2_c_a:
    ; ax
    cmp byte [r15+1], 'x'
    jne short .skip_ax
    mov rdx, 0x0055FFFF
    ret
.skip_ax:
    ; al
    cmp byte [r15+1], 'l'
    jne short .skip_al
    mov rdx, 0x0055FFFF
    ret
.skip_al:
    ; as
    cmp byte [r15+1], 's'
    jne short .skip_as
    mov rdx, 0x00FF88FF
    ret
.skip_as:
    ret
.l2_c_b:
    ; bx
    cmp byte [r15+1], 'x'
    jne short .skip_bx
    mov rdx, 0x0055FFFF
    ret
.skip_bx:
    ; bp
    cmp byte [r15+1], 'p'
    jne short .skip_bp
    mov rdx, 0x0055FFFF
    ret
.skip_bp:
    ; bl
    cmp byte [r15+1], 'l'
    jne short .skip_bl
    mov rdx, 0x0055FFFF
    ret
.skip_bl:
    ret
.l2_c_c:
    ; cx
    cmp byte [r15+1], 'x'
    jne short .skip_cx
    mov rdx, 0x0055FFFF
    ret
.skip_cx:
    ; cl
    cmp byte [r15+1], 'l'
    jne short .skip_cl
    mov rdx, 0x0055FFFF
    ret
.skip_cl:
    ret
.l2_c_d:
    ; dx
    cmp byte [r15+1], 'x'
    jne short .skip_dx
    mov rdx, 0x0055FFFF
    ret
.skip_dx:
    ; di
    cmp byte [r15+1], 'i'
    jne short .skip_di
    mov rdx, 0x0055FFFF
    ret
.skip_di:
    ; dl
    cmp byte [r15+1], 'l'
    jne short .skip_dl
    mov rdx, 0x0055FFFF
    ret
.skip_dl:
    ; db
    cmp byte [r15+1], 'b'
    jne short .skip_db
    mov rdx, 0x00FF88FF
    ret
.skip_db:
    ; dw
    cmp byte [r15+1], 'w'
    jne short .skip_dw
    mov rdx, 0x00FF88FF
    ret
.skip_dw:
    ; dd
    cmp byte [r15+1], 'd'
    jne short .skip_dd
    mov rdx, 0x00FF88FF
    ret
.skip_dd:
    ; dq
    cmp byte [r15+1], 'q'
    jne short .skip_dq
    mov rdx, 0x00FF88FF
    ret
.skip_dq:
    ; do
    cmp byte [r15+1], 'o'
    jne short .skip_do
    mov rdx, 0x00FF88FF
    ret
.skip_do:
    ret
.l2_c_f:
    ; fn
    cmp byte [r15+1], 'n'
    jne short .skip_fn
    mov rdx, 0x00FF88FF
    ret
.skip_fn:
    ret
.l2_c_g:
    ; go
    cmp byte [r15+1], 'o'
    jne short .skip_go
    mov rdx, 0x00FF88FF
    ret
.skip_go:
    ret
.l2_c_i:
    ; if
    cmp byte [r15+1], 'f'
    jne short .skip_if
    mov rdx, 0x00FF88FF
    ret
.skip_if:
    ; in
    cmp byte [r15+1], 'n'
    jne short .skip_in
    mov rdx, 0x00FF88FF
    ret
.skip_in:
    ; is
    cmp byte [r15+1], 's'
    jne short .skip_is
    mov rdx, 0x00FF88FF
    ret
.skip_is:
    ret
.l2_c_j:
    ; je
    cmp byte [r15+1], 'e'
    jne short .skip_je
    mov rdx, 0x00FFBB55
    ret
.skip_je:
    ; jz
    cmp byte [r15+1], 'z'
    jne short .skip_jz
    mov rdx, 0x00FFBB55
    ret
.skip_jz:
    ; ja
    cmp byte [r15+1], 'a'
    jne short .skip_ja
    mov rdx, 0x00FFBB55
    ret
.skip_ja:
    ; jb
    cmp byte [r15+1], 'b'
    jne short .skip_jb
    mov rdx, 0x00FFBB55
    ret
.skip_jb:
    ; jg
    cmp byte [r15+1], 'g'
    jne short .skip_jg
    mov rdx, 0x00FFBB55
    ret
.skip_jg:
    ; jl
    cmp byte [r15+1], 'l'
    jne short .skip_jl
    mov rdx, 0x00FFBB55
    ret
.skip_jl:
    ret
.l2_c_o:
    ; or
    cmp byte [r15+1], 'r'
    jne short .skip_or
    mov rdx, 0x00FFBB55
    ret
.skip_or:
    ; of
    cmp byte [r15+1], 'f'
    jne short .skip_of
    mov rdx, 0x00FF88FF
    ret
.skip_of:
    ret
.l2_c_r:
    ; r8
    cmp byte [r15+1], '8'
    jne short .skip_r8
    mov rdx, 0x0055FFFF
    ret
.skip_r8:
    ; r9
    cmp byte [r15+1], '9'
    jne short .skip_r9
    mov rdx, 0x0055FFFF
    ret
.skip_r9:
    ret
.l2_c_s:
    ; si
    cmp byte [r15+1], 'i'
    jne short .skip_si
    mov rdx, 0x0055FFFF
    ret
.skip_si:
    ; sp
    cmp byte [r15+1], 'p'
    jne short .skip_sp
    mov rdx, 0x0055FFFF
    ret
.skip_sp:
    ret
.gt_len3:
    cmp byte [r15], 'a'
    je near .l3_c_a
    cmp byte [r15], 'c'
    je near .l3_c_c
    cmp byte [r15], 'd'
    je near .l3_c_d
    cmp byte [r15], 'e'
    je near .l3_c_e
    cmp byte [r15], 'f'
    je near .l3_c_f
    cmp byte [r15], 'i'
    je near .l3_c_i
    cmp byte [r15], 'j'
    je near .l3_c_j
    cmp byte [r15], 'l'
    je near .l3_c_l
    cmp byte [r15], 'm'
    je near .l3_c_m
    cmp byte [r15], 'n'
    je near .l3_c_n
    cmp byte [r15], 'p'
    je near .l3_c_p
    cmp byte [r15], 'r'
    je near .l3_c_r
    cmp byte [r15], 's'
    je near .l3_c_s
    cmp byte [r15], 't'
    je near .l3_c_t
    cmp byte [r15], 'u'
    je near .l3_c_u
    cmp byte [r15], 'v'
    je near .l3_c_v
    cmp byte [r15], 'x'
    je near .l3_c_x
    ret
.l3_c_a:
    ; add
    cmp byte [r15+1], 'd'
    jne short .skip_add
    cmp byte [r15+2], 'd'
    jne short .skip_add
    mov rdx, 0x00FFBB55
    ret
.skip_add:
    ; and
    cmp byte [r15+1], 'n'
    jne short .skip_and
    cmp byte [r15+2], 'd'
    jne short .skip_and
    mov rdx, 0x00FFBB55
    ret
.skip_and:
    ret
.l3_c_c:
    ; cmp
    cmp byte [r15+1], 'm'
    jne short .skip_cmp
    cmp byte [r15+2], 'p'
    jne short .skip_cmp
    mov rdx, 0x00FFBB55
    ret
.skip_cmp:
    ret
.l3_c_d:
    ; dec
    cmp byte [r15+1], 'e'
    jne short .skip_dec
    cmp byte [r15+2], 'c'
    jne short .skip_dec
    mov rdx, 0x00FFBB55
    ret
.skip_dec:
    ; div
    cmp byte [r15+1], 'i'
    jne short .skip_div
    cmp byte [r15+2], 'v'
    jne short .skip_div
    mov rdx, 0x00FFBB55
    ret
.skip_div:
    ; def
    cmp byte [r15+1], 'e'
    jne short .skip_def
    cmp byte [r15+2], 'f'
    jne short .skip_def
    mov rdx, 0x00FF88FF
    ret
.skip_def:
    ; del
    cmp byte [r15+1], 'e'
    jne short .skip_del
    cmp byte [r15+2], 'l'
    jne short .skip_del
    mov rdx, 0x00FF88FF
    ret
.skip_del:
    ret
.l3_c_e:
    ; eax
    cmp byte [r15+1], 'a'
    jne short .skip_eax
    cmp byte [r15+2], 'x'
    jne short .skip_eax
    mov rdx, 0x0055FFFF
    ret
.skip_eax:
    ; ebx
    cmp byte [r15+1], 'b'
    jne short .skip_ebx
    cmp byte [r15+2], 'x'
    jne short .skip_ebx
    mov rdx, 0x0055FFFF
    ret
.skip_ebx:
    ; ecx
    cmp byte [r15+1], 'c'
    jne short .skip_ecx
    cmp byte [r15+2], 'x'
    jne short .skip_ecx
    mov rdx, 0x0055FFFF
    ret
.skip_ecx:
    ; edx
    cmp byte [r15+1], 'd'
    jne short .skip_edx
    cmp byte [r15+2], 'x'
    jne short .skip_edx
    mov rdx, 0x0055FFFF
    ret
.skip_edx:
    ; esi
    cmp byte [r15+1], 's'
    jne short .skip_esi
    cmp byte [r15+2], 'i'
    jne short .skip_esi
    mov rdx, 0x0055FFFF
    ret
.skip_esi:
    ; edi
    cmp byte [r15+1], 'd'
    jne short .skip_edi
    cmp byte [r15+2], 'i'
    jne short .skip_edi
    mov rdx, 0x0055FFFF
    ret
.skip_edi:
    ; ebp
    cmp byte [r15+1], 'b'
    jne short .skip_ebp
    cmp byte [r15+2], 'p'
    jne short .skip_ebp
    mov rdx, 0x0055FFFF
    ret
.skip_ebp:
    ; esp
    cmp byte [r15+1], 's'
    jne short .skip_esp
    cmp byte [r15+2], 'p'
    jne short .skip_esp
    mov rdx, 0x0055FFFF
    ret
.skip_esp:
    ; equ
    cmp byte [r15+1], 'q'
    jne short .skip_equ
    cmp byte [r15+2], 'u'
    jne short .skip_equ
    mov rdx, 0x00FF88FF
    ret
.skip_equ:
    ret
.l3_c_f:
    ; for
    cmp byte [r15+1], 'o'
    jne short .skip_for
    cmp byte [r15+2], 'r'
    jne short .skip_for
    mov rdx, 0x00FF88FF
    ret
.skip_for:
    ret
.l3_c_i:
    ; inc
    cmp byte [r15+1], 'n'
    jne short .skip_inc
    cmp byte [r15+2], 'c'
    jne short .skip_inc
    mov rdx, 0x00FFBB55
    ret
.skip_inc:
    ; int
    cmp byte [r15+1], 'n'
    jne short .skip_int
    cmp byte [r15+2], 't'
    jne short .skip_int
    mov rdx, 0x0055FF55
    ret
.skip_int:
    ret
.l3_c_j:
    ; jmp
    cmp byte [r15+1], 'm'
    jne short .skip_jmp
    cmp byte [r15+2], 'p'
    jne short .skip_jmp
    mov rdx, 0x00FFBB55
    ret
.skip_jmp:
    ; jne
    cmp byte [r15+1], 'n'
    jne short .skip_jne
    cmp byte [r15+2], 'e'
    jne short .skip_jne
    mov rdx, 0x00FFBB55
    ret
.skip_jne:
    ; jnz
    cmp byte [r15+1], 'n'
    jne short .skip_jnz
    cmp byte [r15+2], 'z'
    jne short .skip_jnz
    mov rdx, 0x00FFBB55
    ret
.skip_jnz:
    ; jae
    cmp byte [r15+1], 'a'
    jne short .skip_jae
    cmp byte [r15+2], 'e'
    jne short .skip_jae
    mov rdx, 0x00FFBB55
    ret
.skip_jae:
    ; jbe
    cmp byte [r15+1], 'b'
    jne short .skip_jbe
    cmp byte [r15+2], 'e'
    jne short .skip_jbe
    mov rdx, 0x00FFBB55
    ret
.skip_jbe:
    ; jge
    cmp byte [r15+1], 'g'
    jne short .skip_jge
    cmp byte [r15+2], 'e'
    jne short .skip_jge
    mov rdx, 0x00FFBB55
    ret
.skip_jge:
    ; jle
    cmp byte [r15+1], 'l'
    jne short .skip_jle
    cmp byte [r15+2], 'e'
    jne short .skip_jle
    mov rdx, 0x00FFBB55
    ret
.skip_jle:
    ret
.l3_c_l:
    ; lea
    cmp byte [r15+1], 'e'
    jne short .skip_lea
    cmp byte [r15+2], 'a'
    jne short .skip_lea
    mov rdx, 0x00FFBB55
    ret
.skip_lea:
    ; let
    cmp byte [r15+1], 'e'
    jne short .skip_let
    cmp byte [r15+2], 't'
    jne short .skip_let
    mov rdx, 0x00FF88FF
    ret
.skip_let:
    ret
.l3_c_m:
    ; mov
    cmp byte [r15+1], 'o'
    jne short .skip_mov
    cmp byte [r15+2], 'v'
    jne short .skip_mov
    mov rdx, 0x00FFBB55
    ret
.skip_mov:
    ; mul
    cmp byte [r15+1], 'u'
    jne short .skip_mul
    cmp byte [r15+2], 'l'
    jne short .skip_mul
    mov rdx, 0x00FFBB55
    ret
.skip_mul:
    ; mut
    cmp byte [r15+1], 'u'
    jne short .skip_mut
    cmp byte [r15+2], 't'
    jne short .skip_mut
    mov rdx, 0x00FF88FF
    ret
.skip_mut:
    ; mod
    cmp byte [r15+1], 'o'
    jne short .skip_mod
    cmp byte [r15+2], 'd'
    jne short .skip_mod
    mov rdx, 0x00FF88FF
    ret
.skip_mod:
    ; map
    cmp byte [r15+1], 'a'
    jne short .skip_map
    cmp byte [r15+2], 'p'
    jne short .skip_map
    mov rdx, 0x00FF88FF
    ret
.skip_map:
    ret
.l3_c_n:
    ; nop
    cmp byte [r15+1], 'o'
    jne short .skip_nop
    cmp byte [r15+2], 'p'
    jne short .skip_nop
    mov rdx, 0x00FFBB55
    ret
.skip_nop:
    ; not
    cmp byte [r15+1], 'o'
    jne short .skip_not
    cmp byte [r15+2], 't'
    jne short .skip_not
    mov rdx, 0x00FF88FF
    ret
.skip_not:
    ; new
    cmp byte [r15+1], 'e'
    jne short .skip_new
    cmp byte [r15+2], 'w'
    jne short .skip_new
    mov rdx, 0x00FF88FF
    ret
.skip_new:
    ret
.l3_c_p:
    ; pop
    cmp byte [r15+1], 'o'
    jne short .skip_pop
    cmp byte [r15+2], 'p'
    jne short .skip_pop
    mov rdx, 0x00FFBB55
    ret
.skip_pop:
    ; pub
    cmp byte [r15+1], 'u'
    jne short .skip_pub
    cmp byte [r15+2], 'b'
    jne short .skip_pub
    mov rdx, 0x00FF88FF
    ret
.skip_pub:
    ret
.l3_c_r:
    ; ret
    cmp byte [r15+1], 'e'
    jne short .skip_ret
    cmp byte [r15+2], 't'
    jne short .skip_ret
    mov rdx, 0x00FFBB55
    ret
.skip_ret:
    ; rax
    cmp byte [r15+1], 'a'
    jne short .skip_rax
    cmp byte [r15+2], 'x'
    jne short .skip_rax
    mov rdx, 0x0055FFFF
    ret
.skip_rax:
    ; rbx
    cmp byte [r15+1], 'b'
    jne short .skip_rbx
    cmp byte [r15+2], 'x'
    jne short .skip_rbx
    mov rdx, 0x0055FFFF
    ret
.skip_rbx:
    ; rcx
    cmp byte [r15+1], 'c'
    jne short .skip_rcx
    cmp byte [r15+2], 'x'
    jne short .skip_rcx
    mov rdx, 0x0055FFFF
    ret
.skip_rcx:
    ; rdx
    cmp byte [r15+1], 'd'
    jne short .skip_rdx
    cmp byte [r15+2], 'x'
    jne short .skip_rdx
    mov rdx, 0x0055FFFF
    ret
.skip_rdx:
    ; rsi
    cmp byte [r15+1], 's'
    jne short .skip_rsi
    cmp byte [r15+2], 'i'
    jne short .skip_rsi
    mov rdx, 0x0055FFFF
    ret
.skip_rsi:
    ; rdi
    cmp byte [r15+1], 'd'
    jne short .skip_rdi
    cmp byte [r15+2], 'i'
    jne short .skip_rdi
    mov rdx, 0x0055FFFF
    ret
.skip_rdi:
    ; rbp
    cmp byte [r15+1], 'b'
    jne short .skip_rbp
    cmp byte [r15+2], 'p'
    jne short .skip_rbp
    mov rdx, 0x0055FFFF
    ret
.skip_rbp:
    ; rsp
    cmp byte [r15+1], 's'
    jne short .skip_rsp
    cmp byte [r15+2], 'p'
    jne short .skip_rsp
    mov rdx, 0x0055FFFF
    ret
.skip_rsp:
    ; r10
    cmp byte [r15+1], '1'
    jne short .skip_r10
    cmp byte [r15+2], '0'
    jne short .skip_r10
    mov rdx, 0x0055FFFF
    ret
.skip_r10:
    ; r11
    cmp byte [r15+1], '1'
    jne short .skip_r11
    cmp byte [r15+2], '1'
    jne short .skip_r11
    mov rdx, 0x0055FFFF
    ret
.skip_r11:
    ; r12
    cmp byte [r15+1], '1'
    jne short .skip_r12
    cmp byte [r15+2], '2'
    jne short .skip_r12
    mov rdx, 0x0055FFFF
    ret
.skip_r12:
    ; r13
    cmp byte [r15+1], '1'
    jne short .skip_r13
    cmp byte [r15+2], '3'
    jne short .skip_r13
    mov rdx, 0x0055FFFF
    ret
.skip_r13:
    ; r14
    cmp byte [r15+1], '1'
    jne short .skip_r14
    cmp byte [r15+2], '4'
    jne short .skip_r14
    mov rdx, 0x0055FFFF
    ret
.skip_r14:
    ; r15
    cmp byte [r15+1], '1'
    jne short .skip_r15
    cmp byte [r15+2], '5'
    jne short .skip_r15
    mov rdx, 0x0055FFFF
    ret
.skip_r15:
    ; r8d
    cmp byte [r15+1], '8'
    jne short .skip_r8d
    cmp byte [r15+2], 'd'
    jne short .skip_r8d
    mov rdx, 0x0055FFFF
    ret
.skip_r8d:
    ; r9d
    cmp byte [r15+1], '9'
    jne short .skip_r9d
    cmp byte [r15+2], 'd'
    jne short .skip_r9d
    mov rdx, 0x0055FFFF
    ret
.skip_r9d:
    ; r8w
    cmp byte [r15+1], '8'
    jne short .skip_r8w
    cmp byte [r15+2], 'w'
    jne short .skip_r8w
    mov rdx, 0x0055FFFF
    ret
.skip_r8w:
    ; r9w
    cmp byte [r15+1], '9'
    jne short .skip_r9w
    cmp byte [r15+2], 'w'
    jne short .skip_r9w
    mov rdx, 0x0055FFFF
    ret
.skip_r9w:
    ; r8b
    cmp byte [r15+1], '8'
    jne short .skip_r8b
    cmp byte [r15+2], 'b'
    jne short .skip_r8b
    mov rdx, 0x0055FFFF
    ret
.skip_r8b:
    ; r9b
    cmp byte [r15+1], '9'
    jne short .skip_r9b
    cmp byte [r15+2], 'b'
    jne short .skip_r9b
    mov rdx, 0x0055FFFF
    ret
.skip_r9b:
    ; ref
    cmp byte [r15+1], 'e'
    jne short .skip_ref
    cmp byte [r15+2], 'f'
    jne short .skip_ref
    mov rdx, 0x00FF88FF
    ret
.skip_ref:
    ret
.l3_c_s:
    ; sub
    cmp byte [r15+1], 'u'
    jne short .skip_sub
    cmp byte [r15+2], 'b'
    jne short .skip_sub
    mov rdx, 0x00FFBB55
    ret
.skip_sub:
    ; shl
    cmp byte [r15+1], 'h'
    jne short .skip_shl
    cmp byte [r15+2], 'l'
    jne short .skip_shl
    mov rdx, 0x00FFBB55
    ret
.skip_shl:
    ; shr
    cmp byte [r15+1], 'h'
    jne short .skip_shr
    cmp byte [r15+2], 'r'
    jne short .skip_shr
    mov rdx, 0x00FFBB55
    ret
.skip_shr:
    ret
.l3_c_t:
    ; try
    cmp byte [r15+1], 'r'
    jne short .skip_try
    cmp byte [r15+2], 'y'
    jne short .skip_try
    mov rdx, 0x00FF88FF
    ret
.skip_try:
    ret
.l3_c_u:
    ; use
    cmp byte [r15+1], 's'
    jne short .skip_use
    cmp byte [r15+2], 'e'
    jne short .skip_use
    mov rdx, 0x00FF88FF
    ret
.skip_use:
    ret
.l3_c_v:
    ; var
    cmp byte [r15+1], 'a'
    jne short .skip_var
    cmp byte [r15+2], 'r'
    jne short .skip_var
    mov rdx, 0x00FF88FF
    ret
.skip_var:
    ret
.l3_c_x:
    ; xor
    cmp byte [r15+1], 'o'
    jne short .skip_xor
    cmp byte [r15+2], 'r'
    jne short .skip_xor
    mov rdx, 0x00FFBB55
    ret
.skip_xor:
    ret
.gt_len4:
    cmp byte [r15], 'N'
    je near .l4_c_N
    cmp byte [r15], 'T'
    je near .l4_c_T
    cmp byte [r15], 'b'
    je near .l4_c_b
    cmp byte [r15], 'c'
    je near .l4_c_c
    cmp byte [r15], 'e'
    je near .l4_c_e
    cmp byte [r15], 'f'
    je near .l4_c_f
    cmp byte [r15], 'g'
    je near .l4_c_g
    cmp byte [r15], 'h'
    je near .l4_c_h
    cmp byte [r15], 'i'
    je near .l4_c_i
    cmp byte [r15], 'l'
    je near .l4_c_l
    cmp byte [r15], 'm'
    je near .l4_c_m
    cmp byte [r15], 'p'
    je near .l4_c_p
    cmp byte [r15], 'r'
    je near .l4_c_r
    cmp byte [r15], 's'
    je near .l4_c_s
    cmp byte [r15], 't'
    je near .l4_c_t
    cmp byte [r15], 'v'
    je near .l4_c_v
    cmp byte [r15], 'w'
    je near .l4_c_w
    ret
.l4_c_N:
    ; None
    cmp byte [r15+1], 'o'
    jne short .skip_None
    cmp byte [r15+2], 'n'
    jne short .skip_None
    cmp byte [r15+3], 'e'
    jne short .skip_None
    mov rdx, 0x0055FFFF
    ret
.skip_None:
    ret
.l4_c_T:
    ; True
    cmp byte [r15+1], 'r'
    jne short .skip_True
    cmp byte [r15+2], 'u'
    jne short .skip_True
    cmp byte [r15+3], 'e'
    jne short .skip_True
    mov rdx, 0x0055FFFF
    ret
.skip_True:
    ret
.l4_c_b:
    ; bool
    cmp byte [r15+1], 'o'
    jne short .skip_bool
    cmp byte [r15+2], 'o'
    jne short .skip_bool
    cmp byte [r15+3], 'l'
    jne short .skip_bool
    mov rdx, 0x0055FF55
    ret
.skip_bool:
    ; body
    cmp byte [r15+1], 'o'
    jne short .skip_body
    cmp byte [r15+2], 'd'
    jne short .skip_body
    cmp byte [r15+3], 'y'
    jne short .skip_body
    mov rdx, 0x00FF88FF
    ret
.skip_body:
    ret
.l4_c_c:
    ; call
    cmp byte [r15+1], 'a'
    jne short .skip_call
    cmp byte [r15+2], 'l'
    jne short .skip_call
    cmp byte [r15+3], 'l'
    jne short .skip_call
    mov rdx, 0x00FFBB55
    ret
.skip_call:
    ; case
    cmp byte [r15+1], 'a'
    jne short .skip_case
    cmp byte [r15+2], 's'
    jne short .skip_case
    cmp byte [r15+3], 'e'
    jne short .skip_case
    mov rdx, 0x00FF88FF
    ret
.skip_case:
    ; char
    cmp byte [r15+1], 'h'
    jne short .skip_char
    cmp byte [r15+2], 'a'
    jne short .skip_char
    cmp byte [r15+3], 'r'
    jne short .skip_char
    mov rdx, 0x0055FF55
    ret
.skip_char:
    ; chan
    cmp byte [r15+1], 'h'
    jne short .skip_chan
    cmp byte [r15+2], 'a'
    jne short .skip_chan
    cmp byte [r15+3], 'n'
    jne short .skip_chan
    mov rdx, 0x00FF88FF
    ret
.skip_chan:
    ret
.l4_c_e:
    ; elif
    cmp byte [r15+1], 'l'
    jne short .skip_elif
    cmp byte [r15+2], 'i'
    jne short .skip_elif
    cmp byte [r15+3], 'f'
    jne short .skip_elif
    mov rdx, 0x00FF88FF
    ret
.skip_elif:
    ; else
    cmp byte [r15+1], 'l'
    jne short .skip_else
    cmp byte [r15+2], 's'
    jne short .skip_else
    cmp byte [r15+3], 'e'
    jne short .skip_else
    mov rdx, 0x00FF88FF
    ret
.skip_else:
    ; enum
    cmp byte [r15+1], 'n'
    jne short .skip_enum
    cmp byte [r15+2], 'u'
    jne short .skip_enum
    cmp byte [r15+3], 'm'
    jne short .skip_enum
    mov rdx, 0x00FF88FF
    ret
.skip_enum:
    ret
.l4_c_f:
    ; from
    cmp byte [r15+1], 'r'
    jne short .skip_from
    cmp byte [r15+2], 'o'
    jne short .skip_from
    cmp byte [r15+3], 'm'
    jne short .skip_from
    mov rdx, 0x00FF88FF
    ret
.skip_from:
    ; func
    cmp byte [r15+1], 'u'
    jne short .skip_func
    cmp byte [r15+2], 'n'
    jne short .skip_func
    cmp byte [r15+3], 'c'
    jne short .skip_func
    mov rdx, 0x00FF88FF
    ret
.skip_func:
    ret
.l4_c_g:
    ; goto
    cmp byte [r15+1], 'o'
    jne short .skip_goto
    cmp byte [r15+2], 't'
    jne short .skip_goto
    cmp byte [r15+3], 'o'
    jne short .skip_goto
    mov rdx, 0x00FF88FF
    ret
.skip_goto:
    ret
.l4_c_h:
    ; html
    cmp byte [r15+1], 't'
    jne short .skip_html
    cmp byte [r15+2], 'm'
    jne short .skip_html
    cmp byte [r15+3], 'l'
    jne short .skip_html
    mov rdx, 0x00FF88FF
    ret
.skip_html:
    ; head
    cmp byte [r15+1], 'e'
    jne short .skip_head
    cmp byte [r15+2], 'a'
    jne short .skip_head
    cmp byte [r15+3], 'd'
    jne short .skip_head
    mov rdx, 0x00FF88FF
    ret
.skip_head:
    ret
.l4_c_i:
    ; impl
    cmp byte [r15+1], 'm'
    jne short .skip_impl
    cmp byte [r15+2], 'p'
    jne short .skip_impl
    cmp byte [r15+3], 'l'
    jne short .skip_impl
    mov rdx, 0x00FF88FF
    ret
.skip_impl:
    ret
.l4_c_l:
    ; long
    cmp byte [r15+1], 'o'
    jne short .skip_long
    cmp byte [r15+2], 'n'
    jne short .skip_long
    cmp byte [r15+3], 'g'
    jne short .skip_long
    mov rdx, 0x0055FF55
    ret
.skip_long:
    ; link
    cmp byte [r15+1], 'i'
    jne short .skip_link
    cmp byte [r15+2], 'n'
    jne short .skip_link
    cmp byte [r15+3], 'k'
    jne short .skip_link
    mov rdx, 0x00FF88FF
    ret
.skip_link:
    ; loop
    cmp byte [r15+1], 'o'
    jne short .skip_loop
    cmp byte [r15+2], 'o'
    jne short .skip_loop
    cmp byte [r15+3], 'p'
    jne short .skip_loop
    mov rdx, 0x00FF88FF
    ret
.skip_loop:
    ret
.l4_c_m:
    ; meta
    cmp byte [r15+1], 'e'
    jne short .skip_meta
    cmp byte [r15+2], 't'
    jne short .skip_meta
    cmp byte [r15+3], 'a'
    jne short .skip_meta
    mov rdx, 0x00FF88FF
    ret
.skip_meta:
    ret
.l4_c_p:
    ; push
    cmp byte [r15+1], 'u'
    jne short .skip_push
    cmp byte [r15+2], 's'
    jne short .skip_push
    cmp byte [r15+3], 'h'
    jne short .skip_push
    mov rdx, 0x00FFBB55
    ret
.skip_push:
    ; pass
    cmp byte [r15+1], 'a'
    jne short .skip_pass
    cmp byte [r15+2], 's'
    jne short .skip_pass
    cmp byte [r15+3], 's'
    jne short .skip_pass
    mov rdx, 0x00FF88FF
    ret
.skip_pass:
    ret
.l4_c_r:
    ; r10d
    cmp byte [r15+1], '1'
    jne short .skip_r10d
    cmp byte [r15+2], '0'
    jne short .skip_r10d
    cmp byte [r15+3], 'd'
    jne short .skip_r10d
    mov rdx, 0x0055FFFF
    ret
.skip_r10d:
    ; r11d
    cmp byte [r15+1], '1'
    jne short .skip_r11d
    cmp byte [r15+2], '1'
    jne short .skip_r11d
    cmp byte [r15+3], 'd'
    jne short .skip_r11d
    mov rdx, 0x0055FFFF
    ret
.skip_r11d:
    ; r12d
    cmp byte [r15+1], '1'
    jne short .skip_r12d
    cmp byte [r15+2], '2'
    jne short .skip_r12d
    cmp byte [r15+3], 'd'
    jne short .skip_r12d
    mov rdx, 0x0055FFFF
    ret
.skip_r12d:
    ; r13d
    cmp byte [r15+1], '1'
    jne short .skip_r13d
    cmp byte [r15+2], '3'
    jne short .skip_r13d
    cmp byte [r15+3], 'd'
    jne short .skip_r13d
    mov rdx, 0x0055FFFF
    ret
.skip_r13d:
    ; r14d
    cmp byte [r15+1], '1'
    jne short .skip_r14d
    cmp byte [r15+2], '4'
    jne short .skip_r14d
    cmp byte [r15+3], 'd'
    jne short .skip_r14d
    mov rdx, 0x0055FFFF
    ret
.skip_r14d:
    ; r15d
    cmp byte [r15+1], '1'
    jne short .skip_r15d
    cmp byte [r15+2], '5'
    jne short .skip_r15d
    cmp byte [r15+3], 'd'
    jne short .skip_r15d
    mov rdx, 0x0055FFFF
    ret
.skip_r15d:
    ; r10w
    cmp byte [r15+1], '1'
    jne short .skip_r10w
    cmp byte [r15+2], '0'
    jne short .skip_r10w
    cmp byte [r15+3], 'w'
    jne short .skip_r10w
    mov rdx, 0x0055FFFF
    ret
.skip_r10w:
    ; r11w
    cmp byte [r15+1], '1'
    jne short .skip_r11w
    cmp byte [r15+2], '1'
    jne short .skip_r11w
    cmp byte [r15+3], 'w'
    jne short .skip_r11w
    mov rdx, 0x0055FFFF
    ret
.skip_r11w:
    ; r12w
    cmp byte [r15+1], '1'
    jne short .skip_r12w
    cmp byte [r15+2], '2'
    jne short .skip_r12w
    cmp byte [r15+3], 'w'
    jne short .skip_r12w
    mov rdx, 0x0055FFFF
    ret
.skip_r12w:
    ; r13w
    cmp byte [r15+1], '1'
    jne short .skip_r13w
    cmp byte [r15+2], '3'
    jne short .skip_r13w
    cmp byte [r15+3], 'w'
    jne short .skip_r13w
    mov rdx, 0x0055FFFF
    ret
.skip_r13w:
    ; r14w
    cmp byte [r15+1], '1'
    jne short .skip_r14w
    cmp byte [r15+2], '4'
    jne short .skip_r14w
    cmp byte [r15+3], 'w'
    jne short .skip_r14w
    mov rdx, 0x0055FFFF
    ret
.skip_r14w:
    ; r15w
    cmp byte [r15+1], '1'
    jne short .skip_r15w
    cmp byte [r15+2], '5'
    jne short .skip_r15w
    cmp byte [r15+3], 'w'
    jne short .skip_r15w
    mov rdx, 0x0055FFFF
    ret
.skip_r15w:
    ; r10b
    cmp byte [r15+1], '1'
    jne short .skip_r10b
    cmp byte [r15+2], '0'
    jne short .skip_r10b
    cmp byte [r15+3], 'b'
    jne short .skip_r10b
    mov rdx, 0x0055FFFF
    ret
.skip_r10b:
    ; r11b
    cmp byte [r15+1], '1'
    jne short .skip_r11b
    cmp byte [r15+2], '1'
    jne short .skip_r11b
    cmp byte [r15+3], 'b'
    jne short .skip_r11b
    mov rdx, 0x0055FFFF
    ret
.skip_r11b:
    ; r12b
    cmp byte [r15+1], '1'
    jne short .skip_r12b
    cmp byte [r15+2], '2'
    jne short .skip_r12b
    cmp byte [r15+3], 'b'
    jne short .skip_r12b
    mov rdx, 0x0055FFFF
    ret
.skip_r12b:
    ; r13b
    cmp byte [r15+1], '1'
    jne short .skip_r13b
    cmp byte [r15+2], '3'
    jne short .skip_r13b
    cmp byte [r15+3], 'b'
    jne short .skip_r13b
    mov rdx, 0x0055FFFF
    ret
.skip_r13b:
    ; r14b
    cmp byte [r15+1], '1'
    jne short .skip_r14b
    cmp byte [r15+2], '4'
    jne short .skip_r14b
    cmp byte [r15+3], 'b'
    jne short .skip_r14b
    mov rdx, 0x0055FFFF
    ret
.skip_r14b:
    ; r15b
    cmp byte [r15+1], '1'
    jne short .skip_r15b
    cmp byte [r15+2], '5'
    jne short .skip_r15b
    cmp byte [r15+3], 'b'
    jne short .skip_r15b
    mov rdx, 0x0055FFFF
    ret
.skip_r15b:
    ; resb
    cmp byte [r15+1], 'e'
    jne short .skip_resb
    cmp byte [r15+2], 's'
    jne short .skip_resb
    cmp byte [r15+3], 'b'
    jne short .skip_resb
    mov rdx, 0x00FF88FF
    ret
.skip_resb:
    ; resw
    cmp byte [r15+1], 'e'
    jne short .skip_resw
    cmp byte [r15+2], 's'
    jne short .skip_resw
    cmp byte [r15+3], 'w'
    jne short .skip_resw
    mov rdx, 0x00FF88FF
    ret
.skip_resw:
    ; resd
    cmp byte [r15+1], 'e'
    jne short .skip_resd
    cmp byte [r15+2], 's'
    jne short .skip_resd
    cmp byte [r15+3], 'd'
    jne short .skip_resd
    mov rdx, 0x00FF88FF
    ret
.skip_resd:
    ; resq
    cmp byte [r15+1], 'e'
    jne short .skip_resq
    cmp byte [r15+2], 's'
    jne short .skip_resq
    cmp byte [r15+3], 'q'
    jne short .skip_resq
    mov rdx, 0x00FF88FF
    ret
.skip_resq:
    ret
.l4_c_s:
    ; span
    cmp byte [r15+1], 'p'
    jne short .skip_span
    cmp byte [r15+2], 'a'
    jne short .skip_span
    cmp byte [r15+3], 'n'
    jne short .skip_span
    mov rdx, 0x00FF88FF
    ret
.skip_span:
    ret
.l4_c_t:
    ; test
    cmp byte [r15+1], 'e'
    jne short .skip_test
    cmp byte [r15+2], 's'
    jne short .skip_test
    cmp byte [r15+3], 't'
    jne short .skip_test
    mov rdx, 0x00FFBB55
    ret
.skip_test:
    ; this
    cmp byte [r15+1], 'h'
    jne short .skip_this
    cmp byte [r15+2], 'i'
    jne short .skip_this
    cmp byte [r15+3], 's'
    jne short .skip_this
    mov rdx, 0x00FF88FF
    ret
.skip_this:
    ; type
    cmp byte [r15+1], 'y'
    jne short .skip_type
    cmp byte [r15+2], 'p'
    jne short .skip_type
    cmp byte [r15+3], 'e'
    jne short .skip_type
    mov rdx, 0x00FF88FF
    ret
.skip_type:
    ret
.l4_c_v:
    ; void
    cmp byte [r15+1], 'o'
    jne short .skip_void
    cmp byte [r15+2], 'i'
    jne short .skip_void
    cmp byte [r15+3], 'd'
    jne short .skip_void
    mov rdx, 0x0055FF55
    ret
.skip_void:
    ret
.l4_c_w:
    ; with
    cmp byte [r15+1], 'i'
    jne short .skip_with
    cmp byte [r15+2], 't'
    jne short .skip_with
    cmp byte [r15+3], 'h'
    jne short .skip_with
    mov rdx, 0x00FF88FF
    ret
.skip_with:
    ret
.gt_len5:
    cmp byte [r15], 'F'
    je near .l5_c_F
    cmp byte [r15], 'a'
    je near .l5_c_a
    cmp byte [r15], 'b'
    je near .l5_c_b
    cmp byte [r15], 'c'
    je near .l5_c_c
    cmp byte [r15], 'd'
    je near .l5_c_d
    cmp byte [r15], 'f'
    je near .l5_c_f
    cmp byte [r15], 'm'
    je near .l5_c_m
    cmp byte [r15], 'r'
    je near .l5_c_r
    cmp byte [r15], 's'
    je near .l5_c_s
    cmp byte [r15], 't'
    je near .l5_c_t
    cmp byte [r15], 'u'
    je near .l5_c_u
    cmp byte [r15], 'w'
    je near .l5_c_w
    cmp byte [r15], 'y'
    je near .l5_c_y
    ret
.l5_c_F:
    ; False
    cmp byte [r15+1], 'a'
    jne short .skip_False
    cmp byte [r15+2], 'l'
    jne short .skip_False
    cmp byte [r15+3], 's'
    jne short .skip_False
    cmp byte [r15+4], 'e'
    jne short .skip_False
    mov rdx, 0x0055FFFF
    ret
.skip_False:
    ret
.l5_c_a:
    ; async
    cmp byte [r15+1], 's'
    jne short .skip_async
    cmp byte [r15+2], 'y'
    jne short .skip_async
    cmp byte [r15+3], 'n'
    jne short .skip_async
    cmp byte [r15+4], 'c'
    jne short .skip_async
    mov rdx, 0x00FF88FF
    ret
.skip_async:
    ; await
    cmp byte [r15+1], 'w'
    jne short .skip_await
    cmp byte [r15+2], 'a'
    jne short .skip_await
    cmp byte [r15+3], 'i'
    jne short .skip_await
    cmp byte [r15+4], 't'
    jne short .skip_await
    mov rdx, 0x00FF88FF
    ret
.skip_await:
    ret
.l5_c_b:
    ; break
    cmp byte [r15+1], 'r'
    jne short .skip_break
    cmp byte [r15+2], 'e'
    jne short .skip_break
    cmp byte [r15+3], 'a'
    jne short .skip_break
    cmp byte [r15+4], 'k'
    jne short .skip_break
    mov rdx, 0x00FF88FF
    ret
.skip_break:
    ret
.l5_c_c:
    ; class
    cmp byte [r15+1], 'l'
    jne short .skip_class
    cmp byte [r15+2], 'a'
    jne short .skip_class
    cmp byte [r15+3], 's'
    jne short .skip_class
    cmp byte [r15+4], 's'
    jne short .skip_class
    mov rdx, 0x00FF88FF
    ret
.skip_class:
    ; const
    cmp byte [r15+1], 'o'
    jne short .skip_const
    cmp byte [r15+2], 'n'
    jne short .skip_const
    cmp byte [r15+3], 's'
    jne short .skip_const
    cmp byte [r15+4], 't'
    jne short .skip_const
    mov rdx, 0x00FF88FF
    ret
.skip_const:
    ; catch
    cmp byte [r15+1], 'a'
    jne short .skip_catch
    cmp byte [r15+2], 't'
    jne short .skip_catch
    cmp byte [r15+3], 'c'
    jne short .skip_catch
    cmp byte [r15+4], 'h'
    jne short .skip_catch
    mov rdx, 0x00FF88FF
    ret
.skip_catch:
    ; crate
    cmp byte [r15+1], 'r'
    jne short .skip_crate
    cmp byte [r15+2], 'a'
    jne short .skip_crate
    cmp byte [r15+3], 't'
    jne short .skip_crate
    cmp byte [r15+4], 'e'
    jne short .skip_crate
    mov rdx, 0x00FF88FF
    ret
.skip_crate:
    ret
.l5_c_d:
    ; defer
    cmp byte [r15+1], 'e'
    jne short .skip_defer
    cmp byte [r15+2], 'f'
    jne short .skip_defer
    cmp byte [r15+3], 'e'
    jne short .skip_defer
    cmp byte [r15+4], 'r'
    jne short .skip_defer
    mov rdx, 0x00FF88FF
    ret
.skip_defer:
    ret
.l5_c_f:
    ; float
    cmp byte [r15+1], 'l'
    jne short .skip_float
    cmp byte [r15+2], 'o'
    jne short .skip_float
    cmp byte [r15+3], 'a'
    jne short .skip_float
    cmp byte [r15+4], 't'
    jne short .skip_float
    mov rdx, 0x0055FF55
    ret
.skip_float:
    ; final
    cmp byte [r15+1], 'i'
    jne short .skip_final
    cmp byte [r15+2], 'n'
    jne short .skip_final
    cmp byte [r15+3], 'a'
    jne short .skip_final
    cmp byte [r15+4], 'l'
    jne short .skip_final
    mov rdx, 0x00FF88FF
    ret
.skip_final:
    ret
.l5_c_m:
    ; match
    cmp byte [r15+1], 'a'
    jne short .skip_match
    cmp byte [r15+2], 't'
    jne short .skip_match
    cmp byte [r15+3], 'c'
    jne short .skip_match
    cmp byte [r15+4], 'h'
    jne short .skip_match
    mov rdx, 0x00FF88FF
    ret
.skip_match:
    ret
.l5_c_r:
    ; raise
    cmp byte [r15+1], 'a'
    jne short .skip_raise
    cmp byte [r15+2], 'i'
    jne short .skip_raise
    cmp byte [r15+3], 's'
    jne short .skip_raise
    cmp byte [r15+4], 'e'
    jne short .skip_raise
    mov rdx, 0x00FF88FF
    ret
.skip_raise:
    ret
.l5_c_s:
    ; short
    cmp byte [r15+1], 'h'
    jne short .skip_short
    cmp byte [r15+2], 'o'
    jne short .skip_short
    cmp byte [r15+3], 'r'
    jne short .skip_short
    cmp byte [r15+4], 't'
    jne short .skip_short
    mov rdx, 0x0055FF55
    ret
.skip_short:
    ; super
    cmp byte [r15+1], 'u'
    jne short .skip_super
    cmp byte [r15+2], 'p'
    jne short .skip_super
    cmp byte [r15+3], 'e'
    jne short .skip_super
    cmp byte [r15+4], 'r'
    jne short .skip_super
    mov rdx, 0x00FF88FF
    ret
.skip_super:
    ; style
    cmp byte [r15+1], 't'
    jne short .skip_style
    cmp byte [r15+2], 'y'
    jne short .skip_style
    cmp byte [r15+3], 'l'
    jne short .skip_style
    cmp byte [r15+4], 'e'
    jne short .skip_style
    mov rdx, 0x00FF88FF
    ret
.skip_style:
    ret
.l5_c_t:
    ; throw
    cmp byte [r15+1], 'h'
    jne short .skip_throw
    cmp byte [r15+2], 'r'
    jne short .skip_throw
    cmp byte [r15+3], 'o'
    jne short .skip_throw
    cmp byte [r15+4], 'w'
    jne short .skip_throw
    mov rdx, 0x00FF88FF
    ret
.skip_throw:
    ; title
    cmp byte [r15+1], 'i'
    jne short .skip_title
    cmp byte [r15+2], 't'
    jne short .skip_title
    cmp byte [r15+3], 'l'
    jne short .skip_title
    cmp byte [r15+4], 'e'
    jne short .skip_title
    mov rdx, 0x00FF88FF
    ret
.skip_title:
    ; trait
    cmp byte [r15+1], 'r'
    jne short .skip_trait
    cmp byte [r15+2], 'a'
    jne short .skip_trait
    cmp byte [r15+3], 'i'
    jne short .skip_trait
    cmp byte [r15+4], 't'
    jne short .skip_trait
    mov rdx, 0x00FF88FF
    ret
.skip_trait:
    ret
.l5_c_u:
    ; union
    cmp byte [r15+1], 'n'
    jne short .skip_union
    cmp byte [r15+2], 'i'
    jne short .skip_union
    cmp byte [r15+3], 'o'
    jne short .skip_union
    cmp byte [r15+4], 'n'
    jne short .skip_union
    mov rdx, 0x00FF88FF
    ret
.skip_union:
    ; using
    cmp byte [r15+1], 's'
    jne short .skip_using
    cmp byte [r15+2], 'i'
    jne short .skip_using
    cmp byte [r15+3], 'n'
    jne short .skip_using
    cmp byte [r15+4], 'g'
    jne short .skip_using
    mov rdx, 0x00FF88FF
    ret
.skip_using:
    ret
.l5_c_w:
    ; while
    cmp byte [r15+1], 'h'
    jne short .skip_while
    cmp byte [r15+2], 'i'
    jne short .skip_while
    cmp byte [r15+3], 'l'
    jne short .skip_while
    cmp byte [r15+4], 'e'
    jne short .skip_while
    mov rdx, 0x00FF88FF
    ret
.skip_while:
    ret
.l5_c_y:
    ; yield
    cmp byte [r15+1], 'i'
    jne short .skip_yield
    cmp byte [r15+2], 'e'
    jne short .skip_yield
    cmp byte [r15+3], 'l'
    jne short .skip_yield
    cmp byte [r15+4], 'd'
    jne short .skip_yield
    mov rdx, 0x00FF88FF
    ret
.skip_yield:
    ret
.gt_len6:
    cmp byte [r15], 'a'
    je near .l6_c_a
    cmp byte [r15], 'd'
    je near .l6_c_d
    cmp byte [r15], 'e'
    je near .l6_c_e
    cmp byte [r15], 'g'
    je near .l6_c_g
    cmp byte [r15], 'i'
    je near .l6_c_i
    cmp byte [r15], 'l'
    je near .l6_c_l
    cmp byte [r15], 'n'
    je near .l6_c_n
    cmp byte [r15], 'p'
    je near .l6_c_p
    cmp byte [r15], 'r'
    je near .l6_c_r
    cmp byte [r15], 's'
    je near .l6_c_s
    cmp byte [r15], 't'
    je near .l6_c_t
    cmp byte [r15], 'u'
    je near .l6_c_u
    ret
.l6_c_a:
    ; assert
    cmp byte [r15+1], 's'
    jne short .skip_assert
    cmp byte [r15+2], 's'
    jne short .skip_assert
    cmp byte [r15+3], 'e'
    jne short .skip_assert
    cmp byte [r15+4], 'r'
    jne short .skip_assert
    cmp byte [r15+5], 't'
    jne short .skip_assert
    mov rdx, 0x00FF88FF
    ret
.skip_assert:
    ret
.l6_c_d:
    ; define
    cmp byte [r15+1], 'e'
    jne short .skip_define
    cmp byte [r15+2], 'f'
    jne short .skip_define
    cmp byte [r15+3], 'i'
    jne short .skip_define
    cmp byte [r15+4], 'n'
    jne short .skip_define
    cmp byte [r15+5], 'e'
    jne short .skip_define
    mov rdx, 0x00FF88FF
    ret
.skip_define:
    ; double
    cmp byte [r15+1], 'o'
    jne short .skip_double
    cmp byte [r15+2], 'u'
    jne short .skip_double
    cmp byte [r15+3], 'b'
    jne short .skip_double
    cmp byte [r15+4], 'l'
    jne short .skip_double
    cmp byte [r15+5], 'e'
    jne short .skip_double
    mov rdx, 0x0055FF55
    ret
.skip_double:
    ; delete
    cmp byte [r15+1], 'e'
    jne short .skip_delete
    cmp byte [r15+2], 'l'
    jne short .skip_delete
    cmp byte [r15+3], 'e'
    jne short .skip_delete
    cmp byte [r15+4], 't'
    jne short .skip_delete
    cmp byte [r15+5], 'e'
    jne short .skip_delete
    mov rdx, 0x00FF88FF
    ret
.skip_delete:
    ret
.l6_c_e:
    ; extern
    cmp byte [r15+1], 'x'
    jne short .skip_extern
    cmp byte [r15+2], 't'
    jne short .skip_extern
    cmp byte [r15+3], 'e'
    jne short .skip_extern
    cmp byte [r15+4], 'r'
    jne short .skip_extern
    cmp byte [r15+5], 'n'
    jne short .skip_extern
    mov rdx, 0x00FF88FF
    ret
.skip_extern:
    ; except
    cmp byte [r15+1], 'x'
    jne short .skip_except
    cmp byte [r15+2], 'c'
    jne short .skip_except
    cmp byte [r15+3], 'e'
    jne short .skip_except
    cmp byte [r15+4], 'p'
    jne short .skip_except
    cmp byte [r15+5], 't'
    jne short .skip_except
    mov rdx, 0x00FF88FF
    ret
.skip_except:
    ; export
    cmp byte [r15+1], 'x'
    jne short .skip_export
    cmp byte [r15+2], 'p'
    jne short .skip_export
    cmp byte [r15+3], 'o'
    jne short .skip_export
    cmp byte [r15+4], 'r'
    jne short .skip_export
    cmp byte [r15+5], 't'
    jne short .skip_export
    mov rdx, 0x00FF88FF
    ret
.skip_export:
    ret
.l6_c_g:
    ; global
    cmp byte [r15+1], 'l'
    jne short .skip_global
    cmp byte [r15+2], 'o'
    jne short .skip_global
    cmp byte [r15+3], 'b'
    jne short .skip_global
    cmp byte [r15+4], 'a'
    jne short .skip_global
    cmp byte [r15+5], 'l'
    jne short .skip_global
    mov rdx, 0x00FF88FF
    ret
.skip_global:
    ret
.l6_c_i:
    ; import
    cmp byte [r15+1], 'm'
    jne short .skip_import
    cmp byte [r15+2], 'p'
    jne short .skip_import
    cmp byte [r15+3], 'o'
    jne short .skip_import
    cmp byte [r15+4], 'r'
    jne short .skip_import
    cmp byte [r15+5], 't'
    jne short .skip_import
    mov rdx, 0x00FF88FF
    ret
.skip_import:
    ; inline
    cmp byte [r15+1], 'n'
    jne short .skip_inline
    cmp byte [r15+2], 'l'
    jne short .skip_inline
    cmp byte [r15+3], 'i'
    jne short .skip_inline
    cmp byte [r15+4], 'n'
    jne short .skip_inline
    cmp byte [r15+5], 'e'
    jne short .skip_inline
    mov rdx, 0x00FF88FF
    ret
.skip_inline:
    ; int8_t
    cmp byte [r15+1], 'n'
    jne short .skip_int8_t
    cmp byte [r15+2], 't'
    jne short .skip_int8_t
    cmp byte [r15+3], '8'
    jne short .skip_int8_t
    cmp byte [r15+4], '_'
    jne short .skip_int8_t
    cmp byte [r15+5], 't'
    jne short .skip_int8_t
    mov rdx, 0x0055FF55
    ret
.skip_int8_t:
    ret
.l6_c_l:
    ; lambda
    cmp byte [r15+1], 'a'
    jne short .skip_lambda
    cmp byte [r15+2], 'm'
    jne short .skip_lambda
    cmp byte [r15+3], 'b'
    jne short .skip_lambda
    cmp byte [r15+4], 'd'
    jne short .skip_lambda
    cmp byte [r15+5], 'a'
    jne short .skip_lambda
    mov rdx, 0x00FF88FF
    ret
.skip_lambda:
    ret
.l6_c_n:
    ; native
    cmp byte [r15+1], 'a'
    jne short .skip_native
    cmp byte [r15+2], 't'
    jne short .skip_native
    cmp byte [r15+3], 'i'
    jne short .skip_native
    cmp byte [r15+4], 'v'
    jne short .skip_native
    cmp byte [r15+5], 'e'
    jne short .skip_native
    mov rdx, 0x00FF88FF
    ret
.skip_native:
    ret
.l6_c_p:
    ; pragma
    cmp byte [r15+1], 'r'
    jne short .skip_pragma
    cmp byte [r15+2], 'a'
    jne short .skip_pragma
    cmp byte [r15+3], 'g'
    jne short .skip_pragma
    cmp byte [r15+4], 'm'
    jne short .skip_pragma
    cmp byte [r15+5], 'a'
    jne short .skip_pragma
    mov rdx, 0x00FF88FF
    ret
.skip_pragma:
    ; public
    cmp byte [r15+1], 'u'
    jne short .skip_public
    cmp byte [r15+2], 'b'
    jne short .skip_public
    cmp byte [r15+3], 'l'
    jne short .skip_public
    cmp byte [r15+4], 'i'
    jne short .skip_public
    cmp byte [r15+5], 'c'
    jne short .skip_public
    mov rdx, 0x00FF88FF
    ret
.skip_public:
    ret
.l6_c_r:
    ; return
    cmp byte [r15+1], 'e'
    jne short .skip_return
    cmp byte [r15+2], 't'
    jne short .skip_return
    cmp byte [r15+3], 'u'
    jne short .skip_return
    cmp byte [r15+4], 'r'
    jne short .skip_return
    cmp byte [r15+5], 'n'
    jne short .skip_return
    mov rdx, 0x00FF88FF
    ret
.skip_return:
    ret
.l6_c_s:
    ; switch
    cmp byte [r15+1], 'w'
    jne short .skip_switch
    cmp byte [r15+2], 'i'
    jne short .skip_switch
    cmp byte [r15+3], 't'
    jne short .skip_switch
    cmp byte [r15+4], 'c'
    jne short .skip_switch
    cmp byte [r15+5], 'h'
    jne short .skip_switch
    mov rdx, 0x00FF88FF
    ret
.skip_switch:
    ; sizeof
    cmp byte [r15+1], 'i'
    jne short .skip_sizeof
    cmp byte [r15+2], 'z'
    jne short .skip_sizeof
    cmp byte [r15+3], 'e'
    jne short .skip_sizeof
    cmp byte [r15+4], 'o'
    jne short .skip_sizeof
    cmp byte [r15+5], 'f'
    jne short .skip_sizeof
    mov rdx, 0x00FF88FF
    ret
.skip_sizeof:
    ; struct
    cmp byte [r15+1], 't'
    jne short .skip_struct
    cmp byte [r15+2], 'r'
    jne short .skip_struct
    cmp byte [r15+3], 'u'
    jne short .skip_struct
    cmp byte [r15+4], 'c'
    jne short .skip_struct
    cmp byte [r15+5], 't'
    jne short .skip_struct
    mov rdx, 0x00FF88FF
    ret
.skip_struct:
    ; static
    cmp byte [r15+1], 't'
    jne short .skip_static
    cmp byte [r15+2], 'a'
    jne short .skip_static
    cmp byte [r15+3], 't'
    jne short .skip_static
    cmp byte [r15+4], 'i'
    jne short .skip_static
    cmp byte [r15+5], 'c'
    jne short .skip_static
    mov rdx, 0x00FF88FF
    ret
.skip_static:
    ; signed
    cmp byte [r15+1], 'i'
    jne short .skip_signed
    cmp byte [r15+2], 'g'
    jne short .skip_signed
    cmp byte [r15+3], 'n'
    jne short .skip_signed
    cmp byte [r15+4], 'e'
    jne short .skip_signed
    cmp byte [r15+5], 'd'
    jne short .skip_signed
    mov rdx, 0x0055FF55
    ret
.skip_signed:
    ; size_t
    cmp byte [r15+1], 'i'
    jne short .skip_size_t
    cmp byte [r15+2], 'z'
    jne short .skip_size_t
    cmp byte [r15+3], 'e'
    jne short .skip_size_t
    cmp byte [r15+4], '_'
    jne short .skip_size_t
    cmp byte [r15+5], 't'
    jne short .skip_size_t
    mov rdx, 0x0055FF55
    ret
.skip_size_t:
    ; script
    cmp byte [r15+1], 'c'
    jne short .skip_script
    cmp byte [r15+2], 'r'
    jne short .skip_script
    cmp byte [r15+3], 'i'
    jne short .skip_script
    cmp byte [r15+4], 'p'
    jne short .skip_script
    cmp byte [r15+5], 't'
    jne short .skip_script
    mov rdx, 0x00FF88FF
    ret
.skip_script:
    ; select
    cmp byte [r15+1], 'e'
    jne short .skip_select
    cmp byte [r15+2], 'l'
    jne short .skip_select
    cmp byte [r15+3], 'e'
    jne short .skip_select
    cmp byte [r15+4], 'c'
    jne short .skip_select
    cmp byte [r15+5], 't'
    jne short .skip_select
    mov rdx, 0x00FF88FF
    ret
.skip_select:
    ret
.l6_c_t:
    ; typeof
    cmp byte [r15+1], 'y'
    jne short .skip_typeof
    cmp byte [r15+2], 'p'
    jne short .skip_typeof
    cmp byte [r15+3], 'e'
    jne short .skip_typeof
    cmp byte [r15+4], 'o'
    jne short .skip_typeof
    cmp byte [r15+5], 'f'
    jne short .skip_typeof
    mov rdx, 0x00FF88FF
    ret
.skip_typeof:
    ; throws
    cmp byte [r15+1], 'h'
    jne short .skip_throws
    cmp byte [r15+2], 'r'
    jne short .skip_throws
    cmp byte [r15+3], 'o'
    jne short .skip_throws
    cmp byte [r15+4], 'w'
    jne short .skip_throws
    cmp byte [r15+5], 's'
    jne short .skip_throws
    mov rdx, 0x00FF88FF
    ret
.skip_throws:
    ret
.l6_c_u:
    ; unsafe
    cmp byte [r15+1], 'n'
    jne short .skip_unsafe
    cmp byte [r15+2], 's'
    jne short .skip_unsafe
    cmp byte [r15+3], 'a'
    jne short .skip_unsafe
    cmp byte [r15+4], 'f'
    jne short .skip_unsafe
    cmp byte [r15+5], 'e'
    jne short .skip_unsafe
    mov rdx, 0x00FF88FF
    ret
.skip_unsafe:
    ret
.gt_len7:
    cmp byte [r15], 'd'
    je near .l7_c_d
    cmp byte [r15], 'e'
    je near .l7_c_e
    cmp byte [r15], 'f'
    je near .l7_c_f
    cmp byte [r15], 'i'
    je near .l7_c_i
    cmp byte [r15], 'p'
    je near .l7_c_p
    cmp byte [r15], 's'
    je near .l7_c_s
    cmp byte [r15], 't'
    je near .l7_c_t
    cmp byte [r15], 'u'
    je near .l7_c_u
    cmp byte [r15], 'v'
    je near .l7_c_v
    ret
.l7_c_d:
    ; default
    cmp byte [r15+1], 'e'
    jne short .skip_default
    cmp byte [r15+2], 'f'
    jne short .skip_default
    cmp byte [r15+3], 'a'
    jne short .skip_default
    cmp byte [r15+4], 'u'
    jne short .skip_default
    cmp byte [r15+5], 'l'
    jne short .skip_default
    cmp byte [r15+6], 't'
    jne short .skip_default
    mov rdx, 0x00FF88FF
    ret
.skip_default:
    ret
.l7_c_e:
    ; extends
    cmp byte [r15+1], 'x'
    jne short .skip_extends
    cmp byte [r15+2], 't'
    jne short .skip_extends
    cmp byte [r15+3], 'e'
    jne short .skip_extends
    cmp byte [r15+4], 'n'
    jne short .skip_extends
    cmp byte [r15+5], 'd'
    jne short .skip_extends
    cmp byte [r15+6], 's'
    jne short .skip_extends
    mov rdx, 0x00FF88FF
    ret
.skip_extends:
    ret
.l7_c_f:
    ; finally
    cmp byte [r15+1], 'i'
    jne short .skip_finally
    cmp byte [r15+2], 'n'
    jne short .skip_finally
    cmp byte [r15+3], 'a'
    jne short .skip_finally
    cmp byte [r15+4], 'l'
    jne short .skip_finally
    cmp byte [r15+5], 'l'
    jne short .skip_finally
    cmp byte [r15+6], 'y'
    jne short .skip_finally
    mov rdx, 0x00FF88FF
    ret
.skip_finally:
    ret
.l7_c_i:
    ; include
    cmp byte [r15+1], 'n'
    jne short .skip_include
    cmp byte [r15+2], 'c'
    jne short .skip_include
    cmp byte [r15+3], 'l'
    jne short .skip_include
    cmp byte [r15+4], 'u'
    jne short .skip_include
    cmp byte [r15+5], 'd'
    jne short .skip_include
    cmp byte [r15+6], 'e'
    jne short .skip_include
    mov rdx, 0x00FF88FF
    ret
.skip_include:
    ; int16_t
    cmp byte [r15+1], 'n'
    jne short .skip_int16_t
    cmp byte [r15+2], 't'
    jne short .skip_int16_t
    cmp byte [r15+3], '1'
    jne short .skip_int16_t
    cmp byte [r15+4], '6'
    jne short .skip_int16_t
    cmp byte [r15+5], '_'
    jne short .skip_int16_t
    cmp byte [r15+6], 't'
    jne short .skip_int16_t
    mov rdx, 0x0055FF55
    ret
.skip_int16_t:
    ; int32_t
    cmp byte [r15+1], 'n'
    jne short .skip_int32_t
    cmp byte [r15+2], 't'
    jne short .skip_int32_t
    cmp byte [r15+3], '3'
    jne short .skip_int32_t
    cmp byte [r15+4], '2'
    jne short .skip_int32_t
    cmp byte [r15+5], '_'
    jne short .skip_int32_t
    cmp byte [r15+6], 't'
    jne short .skip_int32_t
    mov rdx, 0x0055FF55
    ret
.skip_int32_t:
    ; int64_t
    cmp byte [r15+1], 'n'
    jne short .skip_int64_t
    cmp byte [r15+2], 't'
    jne short .skip_int64_t
    cmp byte [r15+3], '6'
    jne short .skip_int64_t
    cmp byte [r15+4], '4'
    jne short .skip_int64_t
    cmp byte [r15+5], '_'
    jne short .skip_int64_t
    cmp byte [r15+6], 't'
    jne short .skip_int64_t
    mov rdx, 0x0055FF55
    ret
.skip_int64_t:
    ret
.l7_c_p:
    ; package
    cmp byte [r15+1], 'a'
    jne short .skip_package
    cmp byte [r15+2], 'c'
    jne short .skip_package
    cmp byte [r15+3], 'k'
    jne short .skip_package
    cmp byte [r15+4], 'a'
    jne short .skip_package
    cmp byte [r15+5], 'g'
    jne short .skip_package
    cmp byte [r15+6], 'e'
    jne short .skip_package
    mov rdx, 0x00FF88FF
    ret
.skip_package:
    ; private
    cmp byte [r15+1], 'r'
    jne short .skip_private
    cmp byte [r15+2], 'i'
    jne short .skip_private
    cmp byte [r15+3], 'v'
    jne short .skip_private
    cmp byte [r15+4], 'a'
    jne short .skip_private
    cmp byte [r15+5], 't'
    jne short .skip_private
    cmp byte [r15+6], 'e'
    jne short .skip_private
    mov rdx, 0x00FF88FF
    ret
.skip_private:
    ret
.l7_c_s:
    ; section
    cmp byte [r15+1], 'e'
    jne short .skip_section
    cmp byte [r15+2], 'c'
    jne short .skip_section
    cmp byte [r15+3], 't'
    jne short .skip_section
    cmp byte [r15+4], 'i'
    jne short .skip_section
    cmp byte [r15+5], 'o'
    jne short .skip_section
    cmp byte [r15+6], 'n'
    jne short .skip_section
    mov rdx, 0x00FF88FF
    ret
.skip_section:
    ret
.l7_c_t:
    ; typedef
    cmp byte [r15+1], 'y'
    jne short .skip_typedef
    cmp byte [r15+2], 'p'
    jne short .skip_typedef
    cmp byte [r15+3], 'e'
    jne short .skip_typedef
    cmp byte [r15+4], 'd'
    jne short .skip_typedef
    cmp byte [r15+5], 'e'
    jne short .skip_typedef
    cmp byte [r15+6], 'f'
    jne short .skip_typedef
    mov rdx, 0x00FF88FF
    ret
.skip_typedef:
    ret
.l7_c_u:
    ; uint8_t
    cmp byte [r15+1], 'i'
    jne short .skip_uint8_t
    cmp byte [r15+2], 'n'
    jne short .skip_uint8_t
    cmp byte [r15+3], 't'
    jne short .skip_uint8_t
    cmp byte [r15+4], '8'
    jne short .skip_uint8_t
    cmp byte [r15+5], '_'
    jne short .skip_uint8_t
    cmp byte [r15+6], 't'
    jne short .skip_uint8_t
    mov rdx, 0x0055FF55
    ret
.skip_uint8_t:
    ret
.l7_c_v:
    ; virtual
    cmp byte [r15+1], 'i'
    jne short .skip_virtual
    cmp byte [r15+2], 'r'
    jne short .skip_virtual
    cmp byte [r15+3], 't'
    jne short .skip_virtual
    cmp byte [r15+4], 'u'
    jne short .skip_virtual
    cmp byte [r15+5], 'a'
    jne short .skip_virtual
    cmp byte [r15+6], 'l'
    jne short .skip_virtual
    mov rdx, 0x00FF88FF
    ret
.skip_virtual:
    ret
.gt_len8:
    cmp byte [r15], 'a'
    je near .l8_c_a
    cmp byte [r15], 'c'
    je near .l8_c_c
    cmp byte [r15], 'd'
    je near .l8_c_d
    cmp byte [r15], 'f'
    je near .l8_c_f
    cmp byte [r15], 'n'
    je near .l8_c_n
    cmp byte [r15], 'o'
    je near .l8_c_o
    cmp byte [r15], 'r'
    je near .l8_c_r
    cmp byte [r15], 's'
    je near .l8_c_s
    cmp byte [r15], 'u'
    je near .l8_c_u
    cmp byte [r15], 'v'
    je near .l8_c_v
    ret
.l8_c_a:
    ; abstract
    cmp byte [r15+1], 'b'
    jne short .skip_abstract
    cmp byte [r15+2], 's'
    jne short .skip_abstract
    cmp byte [r15+3], 't'
    jne short .skip_abstract
    cmp byte [r15+4], 'r'
    jne short .skip_abstract
    cmp byte [r15+5], 'a'
    jne short .skip_abstract
    cmp byte [r15+6], 'c'
    jne short .skip_abstract
    cmp byte [r15+7], 't'
    jne short .skip_abstract
    mov rdx, 0x00FF88FF
    ret
.skip_abstract:
    ret
.l8_c_c:
    ; continue
    cmp byte [r15+1], 'o'
    jne short .skip_continue
    cmp byte [r15+2], 'n'
    jne short .skip_continue
    cmp byte [r15+3], 't'
    jne short .skip_continue
    cmp byte [r15+4], 'i'
    jne short .skip_continue
    cmp byte [r15+5], 'n'
    jne short .skip_continue
    cmp byte [r15+6], 'u'
    jne short .skip_continue
    cmp byte [r15+7], 'e'
    jne short .skip_continue
    mov rdx, 0x00FF88FF
    ret
.skip_continue:
    ret
.l8_c_d:
    ; debugger
    cmp byte [r15+1], 'e'
    jne short .skip_debugger
    cmp byte [r15+2], 'b'
    jne short .skip_debugger
    cmp byte [r15+3], 'u'
    jne short .skip_debugger
    cmp byte [r15+4], 'g'
    jne short .skip_debugger
    cmp byte [r15+5], 'g'
    jne short .skip_debugger
    cmp byte [r15+6], 'e'
    jne short .skip_debugger
    cmp byte [r15+7], 'r'
    jne short .skip_debugger
    mov rdx, 0x00FF88FF
    ret
.skip_debugger:
    ret
.l8_c_f:
    ; function
    cmp byte [r15+1], 'u'
    jne short .skip_function
    cmp byte [r15+2], 'n'
    jne short .skip_function
    cmp byte [r15+3], 'c'
    jne short .skip_function
    cmp byte [r15+4], 't'
    jne short .skip_function
    cmp byte [r15+5], 'i'
    jne short .skip_function
    cmp byte [r15+6], 'o'
    jne short .skip_function
    cmp byte [r15+7], 'n'
    jne short .skip_function
    mov rdx, 0x00FF88FF
    ret
.skip_function:
    ret
.l8_c_n:
    ; nonlocal
    cmp byte [r15+1], 'o'
    jne short .skip_nonlocal
    cmp byte [r15+2], 'n'
    jne short .skip_nonlocal
    cmp byte [r15+3], 'l'
    jne short .skip_nonlocal
    cmp byte [r15+4], 'o'
    jne short .skip_nonlocal
    cmp byte [r15+5], 'c'
    jne short .skip_nonlocal
    cmp byte [r15+6], 'a'
    jne short .skip_nonlocal
    cmp byte [r15+7], 'l'
    jne short .skip_nonlocal
    mov rdx, 0x00FF88FF
    ret
.skip_nonlocal:
    ret
.l8_c_o:
    ; override
    cmp byte [r15+1], 'v'
    jne short .skip_override
    cmp byte [r15+2], 'e'
    jne short .skip_override
    cmp byte [r15+3], 'r'
    jne short .skip_override
    cmp byte [r15+4], 'r'
    jne short .skip_override
    cmp byte [r15+5], 'i'
    jne short .skip_override
    cmp byte [r15+6], 'd'
    jne short .skip_override
    cmp byte [r15+7], 'e'
    jne short .skip_override
    mov rdx, 0x00FF88FF
    ret
.skip_override:
    ret
.l8_c_r:
    ; restrict
    cmp byte [r15+1], 'e'
    jne short .skip_restrict
    cmp byte [r15+2], 's'
    jne short .skip_restrict
    cmp byte [r15+3], 't'
    jne short .skip_restrict
    cmp byte [r15+4], 'r'
    jne short .skip_restrict
    cmp byte [r15+5], 'i'
    jne short .skip_restrict
    cmp byte [r15+6], 'c'
    jne short .skip_restrict
    cmp byte [r15+7], 't'
    jne short .skip_restrict
    mov rdx, 0x00FF88FF
    ret
.skip_restrict:
    ret
.l8_c_s:
    ; strictfp
    cmp byte [r15+1], 't'
    jne short .skip_strictfp
    cmp byte [r15+2], 'r'
    jne short .skip_strictfp
    cmp byte [r15+3], 'i'
    jne short .skip_strictfp
    cmp byte [r15+4], 'c'
    jne short .skip_strictfp
    cmp byte [r15+5], 't'
    jne short .skip_strictfp
    cmp byte [r15+6], 'f'
    jne short .skip_strictfp
    cmp byte [r15+7], 'p'
    jne short .skip_strictfp
    mov rdx, 0x00FF88FF
    ret
.skip_strictfp:
    ret
.l8_c_u:
    ; unsigned
    cmp byte [r15+1], 'n'
    jne short .skip_unsigned
    cmp byte [r15+2], 's'
    jne short .skip_unsigned
    cmp byte [r15+3], 'i'
    jne short .skip_unsigned
    cmp byte [r15+4], 'g'
    jne short .skip_unsigned
    cmp byte [r15+5], 'n'
    jne short .skip_unsigned
    cmp byte [r15+6], 'e'
    jne short .skip_unsigned
    cmp byte [r15+7], 'd'
    jne short .skip_unsigned
    mov rdx, 0x0055FF55
    ret
.skip_unsigned:
    ; uint16_t
    cmp byte [r15+1], 'i'
    jne short .skip_uint16_t
    cmp byte [r15+2], 'n'
    jne short .skip_uint16_t
    cmp byte [r15+3], 't'
    jne short .skip_uint16_t
    cmp byte [r15+4], '1'
    jne short .skip_uint16_t
    cmp byte [r15+5], '6'
    jne short .skip_uint16_t
    cmp byte [r15+6], '_'
    jne short .skip_uint16_t
    cmp byte [r15+7], 't'
    jne short .skip_uint16_t
    mov rdx, 0x0055FF55
    ret
.skip_uint16_t:
    ; uint32_t
    cmp byte [r15+1], 'i'
    jne short .skip_uint32_t
    cmp byte [r15+2], 'n'
    jne short .skip_uint32_t
    cmp byte [r15+3], 't'
    jne short .skip_uint32_t
    cmp byte [r15+4], '3'
    jne short .skip_uint32_t
    cmp byte [r15+5], '2'
    jne short .skip_uint32_t
    cmp byte [r15+6], '_'
    jne short .skip_uint32_t
    cmp byte [r15+7], 't'
    jne short .skip_uint32_t
    mov rdx, 0x0055FF55
    ret
.skip_uint32_t:
    ; uint64_t
    cmp byte [r15+1], 'i'
    jne short .skip_uint64_t
    cmp byte [r15+2], 'n'
    jne short .skip_uint64_t
    cmp byte [r15+3], 't'
    jne short .skip_uint64_t
    cmp byte [r15+4], '6'
    jne short .skip_uint64_t
    cmp byte [r15+5], '4'
    jne short .skip_uint64_t
    cmp byte [r15+6], '_'
    jne short .skip_uint64_t
    cmp byte [r15+7], 't'
    jne short .skip_uint64_t
    mov rdx, 0x0055FF55
    ret
.skip_uint64_t:
    ret
.l8_c_v:
    ; volatile
    cmp byte [r15+1], 'o'
    jne short .skip_volatile
    cmp byte [r15+2], 'l'
    jne short .skip_volatile
    cmp byte [r15+3], 'a'
    jne short .skip_volatile
    cmp byte [r15+4], 't'
    jne short .skip_volatile
    cmp byte [r15+5], 'i'
    jne short .skip_volatile
    cmp byte [r15+6], 'l'
    jne short .skip_volatile
    cmp byte [r15+7], 'e'
    jne short .skip_volatile
    mov rdx, 0x00FF88FF
    ret
.skip_volatile:
    ret
.gt_len9:
    cmp byte [r15], 'i'
    je near .l9_c_i
    cmp byte [r15], 'n'
    je near .l9_c_n
    cmp byte [r15], 'p'
    je near .l9_c_p
    cmp byte [r15], 't'
    je near .l9_c_t
    ret
.l9_c_i:
    ; interface
    cmp byte [r15+1], 'n'
    jne short .skip_interface
    cmp byte [r15+2], 't'
    jne short .skip_interface
    cmp byte [r15+3], 'e'
    jne short .skip_interface
    cmp byte [r15+4], 'r'
    jne short .skip_interface
    cmp byte [r15+5], 'f'
    jne short .skip_interface
    cmp byte [r15+6], 'a'
    jne short .skip_interface
    cmp byte [r15+7], 'c'
    jne short .skip_interface
    cmp byte [r15+8], 'e'
    jne short .skip_interface
    mov rdx, 0x00FF88FF
    ret
.skip_interface:
    ret
.l9_c_n:
    ; namespace
    cmp byte [r15+1], 'a'
    jne short .skip_namespace
    cmp byte [r15+2], 'm'
    jne short .skip_namespace
    cmp byte [r15+3], 'e'
    jne short .skip_namespace
    cmp byte [r15+4], 's'
    jne short .skip_namespace
    cmp byte [r15+5], 'p'
    jne short .skip_namespace
    cmp byte [r15+6], 'a'
    jne short .skip_namespace
    cmp byte [r15+7], 'c'
    jne short .skip_namespace
    cmp byte [r15+8], 'e'
    jne short .skip_namespace
    mov rdx, 0x00FF88FF
    ret
.skip_namespace:
    ret
.l9_c_p:
    ; protected
    cmp byte [r15+1], 'r'
    jne short .skip_protected
    cmp byte [r15+2], 'o'
    jne short .skip_protected
    cmp byte [r15+3], 't'
    jne short .skip_protected
    cmp byte [r15+4], 'e'
    jne short .skip_protected
    cmp byte [r15+5], 'c'
    jne short .skip_protected
    cmp byte [r15+6], 't'
    jne short .skip_protected
    cmp byte [r15+7], 'e'
    jne short .skip_protected
    cmp byte [r15+8], 'd'
    jne short .skip_protected
    mov rdx, 0x00FF88FF
    ret
.skip_protected:
    ret
.l9_c_t:
    ; transient
    cmp byte [r15+1], 'r'
    jne short .skip_transient
    cmp byte [r15+2], 'a'
    jne short .skip_transient
    cmp byte [r15+3], 'n'
    jne short .skip_transient
    cmp byte [r15+4], 's'
    jne short .skip_transient
    cmp byte [r15+5], 'i'
    jne short .skip_transient
    cmp byte [r15+6], 'e'
    jne short .skip_transient
    cmp byte [r15+7], 'n'
    jne short .skip_transient
    cmp byte [r15+8], 't'
    jne short .skip_transient
    mov rdx, 0x00FF88FF
    ret
.skip_transient:
    ret
.gt_len10:
    cmp byte [r15], 'i'
    je near .l10_c_i
    ret
.l10_c_i:
    ; instanceof
    cmp byte [r15+1], 'n'
    jne short .skip_instanceof
    cmp byte [r15+2], 's'
    jne short .skip_instanceof
    cmp byte [r15+3], 't'
    jne short .skip_instanceof
    cmp byte [r15+4], 'a'
    jne short .skip_instanceof
    cmp byte [r15+5], 'n'
    jne short .skip_instanceof
    cmp byte [r15+6], 'c'
    jne short .skip_instanceof
    cmp byte [r15+7], 'e'
    jne short .skip_instanceof
    cmp byte [r15+8], 'o'
    jne short .skip_instanceof
    cmp byte [r15+9], 'f'
    jne short .skip_instanceof
    mov rdx, 0x00FF88FF
    ret
.skip_instanceof:
    ; implements
    cmp byte [r15+1], 'm'
    jne short .skip_implements
    cmp byte [r15+2], 'p'
    jne short .skip_implements
    cmp byte [r15+3], 'l'
    jne short .skip_implements
    cmp byte [r15+4], 'e'
    jne short .skip_implements
    cmp byte [r15+5], 'm'
    jne short .skip_implements
    cmp byte [r15+6], 'e'
    jne short .skip_implements
    cmp byte [r15+7], 'n'
    jne short .skip_implements
    cmp byte [r15+8], 't'
    jne short .skip_implements
    cmp byte [r15+9], 's'
    jne short .skip_implements
    mov rdx, 0x00FF88FF
    ret
.skip_implements:
    ret
.gt_len11:
    cmp byte [r15], 'f'
    je near .l11_c_f
    ret
.l11_c_f:
    ; fallthrough
    cmp byte [r15+1], 'a'
    jne short .skip_fallthrough
    cmp byte [r15+2], 'l'
    jne short .skip_fallthrough
    cmp byte [r15+3], 'l'
    jne short .skip_fallthrough
    cmp byte [r15+4], 't'
    jne short .skip_fallthrough
    cmp byte [r15+5], 'h'
    jne short .skip_fallthrough
    cmp byte [r15+6], 'r'
    jne short .skip_fallthrough
    cmp byte [r15+7], 'o'
    jne short .skip_fallthrough
    cmp byte [r15+8], 'u'
    jne short .skip_fallthrough
    cmp byte [r15+9], 'g'
    jne short .skip_fallthrough
    cmp byte [r15+10], 'h'
    jne short .skip_fallthrough
    mov rdx, 0x00FF88FF
    ret
.skip_fallthrough:
    ret
.gt_len12:
    cmp byte [r15], 's'
    je near .l12_c_s
    ret
.l12_c_s:
    ; synchronized
    cmp byte [r15+1], 'y'
    jne short .skip_synchronized
    cmp byte [r15+2], 'n'
    jne short .skip_synchronized
    cmp byte [r15+3], 'c'
    jne short .skip_synchronized
    cmp byte [r15+4], 'h'
    jne short .skip_synchronized
    cmp byte [r15+5], 'r'
    jne short .skip_synchronized
    cmp byte [r15+6], 'o'
    jne short .skip_synchronized
    cmp byte [r15+7], 'n'
    jne short .skip_synchronized
    cmp byte [r15+8], 'i'
    jne short .skip_synchronized
    cmp byte [r15+9], 'z'
    jne short .skip_synchronized
    cmp byte [r15+10], 'e'
    jne short .skip_synchronized
    cmp byte [r15+11], 'd'
    jne short .skip_synchronized
    mov rdx, 0x00FF88FF
    ret
.skip_synchronized:
    ret