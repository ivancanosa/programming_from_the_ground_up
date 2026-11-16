EXES = libc.so test-exit
AS_FLAGS = -g --32
LD_FLAGS = -m elf_i386 -L/usr/lib32
LD_FLAGS_DYN = -L . -rpath . $(LD_FLAGS) -dynamic-linker /lib/ld-linux.so.2
LIBS = -lc

all: $(EXES)

test-exit: test-exit.o
	ld $(LD_FLAGS_DYN) $^ -o $@ $(LIBS)

libc.so: custom-exit.o | test-exit
	ld -shared $(LD_FLAGS) $^ -o $@ -lc

%.o: %.s
	as $(AS_FLAGS) $< -o $@

clean:
	rm -f $(EXES) *.o

run0: test-exit
	./test-exit

run1: test-exit libc.so
	LD_PRELOAD=libc.so ./test-exit


.PHONY: all clean run0 run1

