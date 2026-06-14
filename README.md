# AssemblIDE
An incredibly lightweight, blazing fast Native Windows IDE written entirely in raw x64 Assembly.

![Dark Mode UI](media__1781402061073.png)

## Features

- **Blazing Fast Assembly Engine**: Compiles and runs locally on your CPU with zero abstraction overhead. The entire application executable and its graphics engine fit in a fraction of a megabyte.
- **Universal Syntax Tokenizer**: Features a mathematically decoupled Tokenizer engine that dynamically highlights syntax on the fly. It includes a custom Python code generator (`gen_highlight.py`) that pre-compiles hundreds of assembly directives, registers, and instructions directly into a hyper-optimized native `.obj` file for zero-overhead parsing!
- **Multi-Tab Interface**: Swap instantaneously between two active buffers using "TAB 1" and "TAB 2" controls. Tab state (scroll, cursor, selection, and undo history) is aggressively swapped in less than a millisecond using `rep movsq` native memory instructions.
- **Sublime-Style Keyboard Workflows**:
  - `Ctrl + C` / `Ctrl + X` dynamically cuts and copies entire lines perfectly seamlessly if no text is selected.
  - `Ctrl + V` integrates natively with the Windows Clipboard.
  - `Ctrl + Left/Right` utilizes the Universal Tokenizer to effortlessly leap your cursor over entire words.
  - `Ctrl + S / O / N` native workspace commands.
- **Native File Navigator**: Includes a built-in Side Panel that natively hooks `kernel32` directory APIs. Navigate seamlessly into subdirectories by simply clicking on them.
- **Embedded Environment**:
  - `[OPEN DIR]`: Instantly hooks the Windows Open File dialog and snaps your entire IDE workspace to that file's directory.
  - `[TERMINAL]`: Need to install packages? Clicking `[TERMINAL]` spawns a detached, fully native Windows Command Prompt perfectly bound to your current working directory.
  - **Embedded Output Pane**: Click `[RUN PY]` or `[RUN ASM]` to dynamically spin up background compiler threads, routing their exact output directly to the IDE's built-in console window without crashing or freezing the graphics loop!
- **Dynamic UI**: Real-time Line Number tracking (powered by a custom Assembly integer-to-string subroutine), fluid active-line highlighting, dynamic status bars, and mouse-wheel tracked vertical scrolling. 

## Requirements
- Windows 10/11 x64
- NASM (Netwide Assembler)
- MinGW/GCC (for linking)

## Building & Running
Run the provided `build.bat` script to assemble and link the executable natively.
```cmd
.\build.bat
.\editor.exe
```
