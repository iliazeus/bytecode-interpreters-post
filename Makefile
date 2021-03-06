CC = gcc
CFLAGS = -std=gnu11 -O3 -g

INTERPRETERS = basic-switch immediate-arg stack-machine register-machine regexp

all: $(INTERPRETERS) pigletvm

test: test-interpreters pigletvm-test

test-interpreters: $(INTERPRETERS)
	$(foreach interpr,$(INTERPRETERS),./$(interpr);)

%: interpreter-%.c
	$(CC) $(CFLAGS) $< -o $@

pigletvm: pigletvm.c pigletvm-exec.c
	$(CC) $(CFLAGS) $^ -o $@

pigletvm-test: pigletvm.c pigletvm-test.c
	$(CC) -g $(CFLAGS) $^ -o $@
	./pigletvm-test

clean:
	rm -vf $(INTERPRETERS) pigletvm pigletvm-test

.PHONY: all clean pigletvm-test test-interpreters
