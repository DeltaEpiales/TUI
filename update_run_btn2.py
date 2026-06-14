import sys

with open("main.asm", "r") as f:
    lines = f.readlines()

new_lines = []
skip = False
for i, line in enumerate(lines):
    if skip:
        if line.strip() == "1546:" or "cmp rax, -1" in line: # wait, click_run_asm ends when?
            pass
        if "jmp .end_wndproc" in line and skip:
            skip = False # we just blindly skip until the end of the handler
        continue

    if "je near .click_run_py" in line:
        new_lines.append("    je near .click_run\n")
    elif "je near .click_run_asm" in line:
        pass # delete this check completely!
    elif "cmp r8d, 6" in line and i < 700: # wm_lbuttonup area
        new_lines.append("    cmp r8d, 5\n")
    elif "je near .click_open_dir" in line:
        new_lines.append(line)
    elif "cmp r8d, 7" in line and i < 700:
        new_lines.append("    cmp r8d, 6\n")
    elif "je near .click_terminal" in line:
        new_lines.append(line)
    elif "cmp r8d, 8" in line and i < 700:
        new_lines.append("    cmp r8d, 7\n")
    elif "je near .click_exit" in line:
        new_lines.append(line)
    elif "cmp r8d, 9" in line and i < 700:
        new_lines.append("    cmp r8d, 8\n")
    elif "je near .click_tab1" in line:
        new_lines.append(line)
    elif "cmp r8d, 10" in line and i < 700:
        new_lines.append("    cmp r8d, 9\n")
    elif "je near .click_tab2" in line:
        new_lines.append(line)

    elif ".click_run_py:" in line:
        new_lines.append(".click_run:\n")
    elif ".click_run_asm:" in line:
        skip = True # Start skipping the asm handler
    else:
        new_lines.append(line)

with open("main.asm", "w") as f:
    f.writelines(new_lines)
print("Updated click handlers")
