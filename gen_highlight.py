import os

instructions = [
    "mov", "push", "pop", "call", "ret", "jmp", "cmp", "test", "lea", "add", "sub",
    "inc", "dec", "xor", "and", "or", "shl", "shr", "mul", "div", "nop", "je", "jne",
    "jz", "jnz", "ja", "jae", "jb", "jbe", "jg", "jge", "jl", "jle"
]

registers = [
    "rax", "rbx", "rcx", "rdx", "rsi", "rdi", "rbp", "rsp", "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
    "eax", "ebx", "ecx", "edx", "esi", "edi", "ebp", "esp", "r8d", "r9d", "r10d", "r11d", "r12d", "r13d", "r14d", "r15d",
    "ax", "bx", "cx", "dx", "si", "di", "bp", "sp", "r8w", "r9w", "r10w", "r11w", "r12w", "r13w", "r14w", "r15w",
    "al", "bl", "cl", "dl", "r8b", "r9b", "r10b", "r11b", "r12b", "r13b", "r14b", "r15b"
]

directives = [
    "section", "global", "extern", "db", "dw", "dd", "dq", "resb", "resw", "resd", "resq", "equ"
]

python_keywords = [
    "import", "def", "class", "return", "if", "elif", "else", "while", "for", "in",
    "pass", "break", "continue", "yield", "with", "as", "try", "except", "finally",
    "raise", "assert", "and", "or", "not", "is", "lambda", "global", "nonlocal", "del",
    "async", "await", "from"
]
python_builtins = ["True", "False", "None"]

c_keywords = [
    "switch", "case", "default", "do", "goto", "sizeof", "struct", "union", "enum",
    "typedef", "const", "volatile", "static", "inline", "restrict", "include", "define", "pragma"
]
c_types = [
    "int", "char", "void", "float", "double", "short", "long", "unsigned", "signed", "bool", "size_t",
    "int8_t", "uint8_t", "int16_t", "uint16_t", "int32_t", "uint32_t", "int64_t", "uint64_t"
]

web_keywords = [
    "function", "var", "let", "const", "if", "else", "for", "while", "do", "switch", "case", "default",
    "try", "catch", "finally", "throw", "return", "break", "continue", "yield", "await", "async", "import",
    "export", "from", "class", "extends", "super", "this", "new", "delete", "typeof", "instanceof", "in",
    "of", "debugger", "html", "head", "body", "div", "span", "script", "style", "link", "meta", "title"
]

systems_keywords = [
    "fn", "let", "mut", "pub", "use", "mod", "struct", "enum", "trait", "impl", "match", "if", "else",
    "while", "loop", "for", "in", "return", "break", "continue", "unsafe", "extern", "crate", "ref",
    "func", "package", "import", "type", "interface", "map", "chan", "go", "defer", "select", "fallthrough"
]

enterprise_keywords = [
    "public", "private", "protected", "class", "interface", "extends", "implements", "this", "super",
    "new", "return", "if", "else", "while", "for", "do", "switch", "case", "default", "break", "continue",
    "try", "catch", "finally", "throw", "throws", "import", "package", "static", "final", "abstract",
    "synchronized", "volatile", "transient", "native", "strictfp", "namespace", "using", "virtual", "override"
]

colors = {
    "instruction": "0x00FFBB55",
    "register": "0x0055FFFF",
    "directive": "0x00FF88FF",
    "keyword": "0x00FF88FF",  # Bright Pink/Magenta
    "type": "0x0055FF55",     # Electric Green
    "builtin": "0x0055FFFF",  # Bright Yellow/Cyan
}

words_by_length = {}
added_words = set()

for word_list, token_type in [
    (instructions, "instruction"),
    (registers, "register"),
    (directives, "directive"),
    (python_keywords, "keyword"),
    (python_builtins, "builtin"),
    (c_keywords, "keyword"),
    (c_types, "type"),
    (web_keywords, "keyword"),
    (systems_keywords, "keyword"),
    (enterprise_keywords, "keyword")
]:
    for w in word_list:
        if w in added_words:
            continue
        added_words.add(w)
        l = len(w)
        if l not in words_by_length:
            words_by_length[l] = []
        words_by_length[l].append((w, token_type))

asm = []
asm.append("global GetTokenInfo")
asm.append("section .text")
asm.append("GetTokenInfo:")
asm.append("    mov rdx, 0x00CCCCCC")
asm.append("")

for l in sorted(words_by_length.keys()):
    asm.append(f"    cmp r13, {l}")
    asm.append(f"    je near .gt_len{l}")

asm.append("    ret")

for l in sorted(words_by_length.keys()):
    asm.append(f".gt_len{l}:")
    
    words = words_by_length[l]
    first_chars = set([w[0][0] for w in words])
    for c in sorted(first_chars):
        asm.append(f"    cmp byte [r15], '{c}'")
        asm.append(f"    je near .l{l}_c_{c}")
    asm.append("    ret")

    for c in sorted(first_chars):
        asm.append(f".l{l}_c_{c}:")
        matching = [w for w in words if w[0][0] == c]
        for w, t in matching:
            asm.append(f"    ; {w}")
            if len(w) > 1:
                for i in range(1, len(w)):
                    asm.append(f"    cmp byte [r15+{i}], '{w[i]}'")
                    asm.append(f"    jne short .skip_{w}")
            asm.append(f"    mov rdx, {colors[t]}")
            asm.append(f"    ret")
            
            if len(w) > 1:
                asm.append(f".skip_{w}:")
        asm.append("    ret")

with open("highlight.asm", "w") as f:
    f.write("\n".join(asm))
