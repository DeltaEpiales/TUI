CC=nasm
CFLAGS=-f elf
LDFLAGS=-m elf_i386

all: editor

editor: editor.o
	ld $(LDFLAGS) editor.o -o editor

editor.o: editor.asm
	$(CC) $(CFLAGS) editor.asm

clean:
	rm -f editor *.o

.PHONY: all clean