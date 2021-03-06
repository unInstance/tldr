CC = cc

CFLAGS  = -std=c99
CFLAGS += -pedantic
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -Wcast-align
CFLAGS += -Wstrict-prototypes
CFLAGS += -Wundef

CFLAGS += -D_DEFAULT_SOURCE

LDFLAGS  = -lcurl
LDFLAGS += -larchive

PREFIX = /usr/local

PROJECT = tldr

all:
	$(CC) $(CFLAGS) $(LDFLAGS) *.c -o $(PROJECT)

debug:
	$(CC) $(CFLAGS) $(LDFLAGS) -g *.c -o $(PROJECT)

gdb: debug
	gdb $(PROJECT)

memcheck: debug
	valgrind --leak-check=yes ./$(PROJECT)

memcheck_v: debug
	valgrind --leak-check=yes -v ./$(PROJECT)

memcheck_full: debug
	valgrind --leak-check=full --show-leak-kinds=all ./$(PROJECT)

clean:
	rm $(PROJECT)

install:
	cp $(PROJECT) $(PREFIX)/bin/$(PROJECT)

.PHONY: all debug gdb memcheck memcheck_v memcheck_full clean install
