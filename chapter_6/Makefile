EXES = write-records read-records add-year largest-age add-year-lseek librecord.so
AS_FLAGS = -g --32
LD_FLAGS = -m elf_i386 -L/usr/lib32
LD_FLAGS_DYN = -L . -rpath . $(LD_FLAGS) -dynamic-linker /lib/ld-linux.so.2
LIBS = -lrecord

all: $(EXES)

write-records: write-records.o | librecord.so
	ld $(LD_FLAGS_DYN) $^ -o $@ $(LIBS)

read-records: read-records.o read-record.o count-chars.o write-newline.o
	ld $(LD_FLAGS) $^ -o $@

add-year: add-year.o read-record.o write-record.o
	ld $(LD_FLAGS) $^ -o $@

add-year-lseek: add-year-lseek.o read-record.o write-record.o
	ld $(LD_FLAGS) $^ -o $@

largest-age: largest-age.o read-record.o
	ld $(LD_FLAGS) $^ -o $@

librecord.so: write-record.o read-record.o
	ld -shared $(LD_FLAGS) $^ -o $@

%.o: %.s
	as $(AS_FLAGS) $< -o $@

clean:
	rm -f $(EXES) *.o test.dat

.PHONY: all clean
