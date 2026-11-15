EXES = exit maximum minimum sum

all: $(EXES)

$(EXES): %: %.o
	ld $< -o $@

%.o: %.s
	as $< -o $@

clean:
	rm -f $(EXES) *.o

.PHONY: all clean
