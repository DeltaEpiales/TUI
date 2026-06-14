with open("main.asm", "r") as f:
    lines = f.readlines()

new_lines = []
punct_chars = [',', '[', ']', '+', '-', '*', ':', '(', ')', '{', '}', '.', '=', '<', '>', '/', '&', '|', '!', '~', '%', '^', ';']

i = 0
while i < len(lines):
    line = lines[i]
    if line.strip() == "cmp al, ','" and lines[i+1].strip() == "je .handle_punct":
        for p in punct_chars:
            new_lines.append(f"    cmp al, '{p}'\n")
            new_lines.append(f"    je .handle_punct\n")
        i += 14 # skip old 7 checks
    elif line.strip() == "cmp al, ','" and lines[i+1].strip() == "je .word_found":
        for p in punct_chars:
            new_lines.append(f"    cmp al, '{p}'\n")
            new_lines.append(f"    je .word_found\n")
        i += 14 # skip old 7 checks
    else:
        new_lines.append(line)
        i += 1

with open("main.asm", "w") as f:
    f.writelines(new_lines)
print("Updated punctuation parsing")
