EXES = print toupper toupper_stdin

all: $(EXES)

$(EXES): %: %.o
	ld -m elf_i386 $< -o $@

%.o: %.s
	as -g --32 $< -o $@

clean:
	rm -f $(EXES) *.o

.PHONY: all clean
