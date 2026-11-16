EXES = helloworld-nolib helloworld-lib printf-example
AS_FLAGS = -g --32
LD_FLAGS = -m elf_i386 -L/usr/lib32
LD_FLAGS_DYN = -L . -rpath . $(LD_FLAGS) -dynamic-linker /lib/ld-linux.so.2
LIBS = -lc

all: $(EXES)

helloworld-nolib: helloworld-nolib.o
	ld $(LD_FLAGS) $^ -o $@

helloworld-lib: helloworld-lib.o
	ld $(LD_FLAGS_DYN) $^ -o $@ $(LIBS)

printf-example: printf-example.o
	ld $(LD_FLAGS_DYN) $^ -o $@ $(LIBS)

%.o: %.s
	as $(AS_FLAGS) $< -o $@

clean:
	rm -f $(EXES) *.o

.PHONY: all clean
