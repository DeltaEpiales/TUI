with open("main.asm", "r") as f:
    text = f.read()

text = text.replace("je .run_start", "je near .run_start")
text = text.replace("je .run_py", "je near .run_py")
text = text.replace("je .run_js", "je near .run_js")
text = text.replace("je .run_rs", "je near .run_rs")
text = text.replace("je .run_go", "je near .run_go")
text = text.replace("je .run_c", "je near .run_c")
text = text.replace("je .run_asm", "je near .run_asm")
text = text.replace("jmp .run_start", "jmp near .run_start")

with open("main.asm", "w") as f:
    f.write(text)
print("Fixed jumps")
