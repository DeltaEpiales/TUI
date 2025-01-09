# Assembly Text Editor

A powerful, lightweight text editor written in x86 Assembly for Linux systems. Features real-time syntax highlighting, full TUI interface, and advanced editing capabilities.
(NOTE: this is still very early in development - expect bugs and some issues)

## Features

- Full screen TUI (Text User Interface)
- Real-time syntax highlighting for Assembly
- Line numbering
- Copy/paste buffer
- Find/replace functionality
- Undo/redo stack
- File save/load operations
- Status bar with command hints
- Raw terminal handling
- Error handling with status messages

## Requirements

- Linux operating system (x86/x86_64)
- NASM (Netwide Assembler)
- GNU Linker (ld)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/DeltaEpiales/TUI.git
cd TUI
```

2. Compile the editor:
```bash
nasm -f elf editor.asm && ld -m elf_i386 editor.o -o editor
```

3. Make it executable:
```bash
chmod +x editor
```

4. (Optional) Install system-wide:
```bash
sudo cp editor /usr/local/bin/
```

## Usage

Start the editor:
```bash
./editor [filename]
```

### Keyboard Commands

- `F1`: Show help
- `F2`: Save file
- `F3`: Find text
- `F4`: Replace text
- `F5`: Exit editor
- Arrow keys: Navigate text
- `ESC`: Cancel current operation

## Building from Source

Detailed build instructions:

1. Install NASM:
```bash
# Debian/Ubuntu
sudo apt-get install nasm

# Fedora
sudo dnf install nasm

# Arch Linux
sudo pacman -S nasm
```

2. Compile:
```bash
nasm -f elf editor.asm && ld -m elf_i386 editor.o -o editor
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
