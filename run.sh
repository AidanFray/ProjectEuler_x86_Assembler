#!/bin/sh
# Runs a assembly file passed as an argument

echo "Running $1"

nasm -f elf64 Shared.asm
nasm -f elf64 $1.asm

ld Shared.o $1.o

./a.out