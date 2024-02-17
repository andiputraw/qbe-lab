# Define variables
SRCDIR := src
BINDIR := bin
ASMDIR := asm

# Define the list of source files
SOURCES := $(wildcard $(SRCDIR)/*.ssa)

# Define the list of assembly files
ASSEMBLIES := $(patsubst $(SRCDIR)/%.ssa,$(ASMDIR)/%.s,$(SOURCES))

# Define the list of object files
OBJECTS := $(patsubst $(SRCDIR)/%.ssa,$(BINDIR)/%,$(SOURCES))

# Define the compiler and flags
QBE := qbe
CC := gcc
CFLAGS := -Wall -Wextra -Werror

# Define phony targets
.PHONY: all clean test
test: test.c
	cc -s test.s -S test.c
	cc -o test test.c

# Default target
all: $(OBJECTS) $(ASSEMBLIES)

# Rule to compile .ssa files into assembly files
$(ASMDIR)/%.s: $(SRCDIR)/%.ssa
	$(QBE) $< -o $@

# Rule to compile assembly files into object files
$(BINDIR)/%: $(ASMDIR)/%.s
	$(CC) $(CFLAGS) $< -o $@

# Clean target
clean:
	rm -f $(ASMDIR)/*.s $(BINDIR)/*

