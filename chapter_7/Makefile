EXES = write-records add-year
AS_FLAGS = -g --32
LD_FLAGS = -m elf_i386

all: $(EXES)

write-records: write-records.o write-record.o
	ld $(LD_FLAGS) $^ -o $@

add-year: add-year.o write-newline.o count-chars.o read-record.o write-record.o error-exit.o
	ld $(LD_FLAGS) $^ -o $@

%.o: %.s
	as $(AS_FLAGS) $< -o $@

clean:
	rm -f $(EXES) *.o test.dat testout.dat

.PHONY: all clean
