PROGRAM = readline

all: $(PROGRAM)

$(PROGRAM): $(PROGRAM).c
	gcc $(PROGRAM).c -lreadline -o $(PROGRAM)

PHONY: clean
clean:
	rm -rf $(PROGRAM)
