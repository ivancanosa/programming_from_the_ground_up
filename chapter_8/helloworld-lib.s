.section .data
helloworld: .asciz "Hello world!\n"

.section .text
.globl _start

_start:
# Print hello world
pushl $helloworld
call printf
addl $4, %esp

# Exit
pushl $0
call exit
