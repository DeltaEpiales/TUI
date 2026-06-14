import sys

with open("main.asm", "r") as f:
    lines = f.readlines()

new_lines = []
skip = False
for i, line in enumerate(lines):
    if skip:
        if "add rsp, 48" in line:
            skip = False
        continue

    if "btnRunPy db" in line:
        new_lines.append("    btnRun db ' RUN ', 0\n")
    elif "btnRunAsm db" in line:
        continue
    elif "pyCmd db" in line:
        new_lines.append("    pyCmd db 'cmd.exe /c \"python script.py > run.log 2>&1\"', 0\n")
        new_lines.append("    asmCmd db 'cmd.exe /c \"build.bat > run.log 2>&1\"', 0\n")
        new_lines.append("    cCmd db 'cmd.exe /c \"gcc script.c -o script.exe && script.exe > run.log 2>&1\"', 0\n")
        new_lines.append("    jsCmd db 'cmd.exe /c \"node script.js > run.log 2>&1\"', 0\n")
        new_lines.append("    rsCmd db 'cmd.exe /c \"rustc script.rs -o script.exe && script.exe > run.log 2>&1\"', 0\n")
        new_lines.append("    goCmd db 'cmd.exe /c \"go run script.go > run.log 2>&1\"', 0\n")
    elif "asmCmd db" in line:
        continue
    elif "pyFile db" in line:
        new_lines.append("    pyFile db 'script.py', 0\n")
        new_lines.append("    cFile db 'script.c', 0\n")
        new_lines.append("    jsFile db 'script.js', 0\n")
        new_lines.append("    rsFile db 'script.rs', 0\n")
        new_lines.append("    goFile db 'script.go', 0\n")
    elif "lea r9, [btnRunPy]" in line:
        new_lines.append("    lea r9, [btnRun]\n")
        new_lines.append("    mov dword [rsp+32], 5\n")
    elif "mov dword [rsp+32], 8" in line and i+1 < len(lines) and "TextOutA" in lines[i+1]:
        continue
    elif "mov r8d, 5" in line and i+1 < len(lines) and "call .SetBtnState" in lines[i+1]:
        skip = True
    else:
        new_lines.append(line)

with open("main.asm", "w") as f:
    f.writelines(new_lines)
print("Updated run button declarations")
