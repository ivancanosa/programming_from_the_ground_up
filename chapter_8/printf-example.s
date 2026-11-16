# PURPOSE: This program is to demsotrate how to call printf
#

.section .data

# This string is called the format string. It's the first
# parameter, and printf uses it to find out how many parameters 
# it was given, and what kind they are.
firststring: .asciz "Hello! %s in a %s who loves the number %d\n"
name: .asciz "Jonathan"
personstring: .asciz "person"
# This could also have been an .equ, but we decided to give it
# a real memory location just for kicks
numberloved: .long 3

.section .text
.globl _start

_start:
# note that the parameters are passed in the
# reverse order that they are listed in the
# function's prototype.
pushl numberloved
pushl $personstring
pushl $name
pushl $firststring
call printf
addl $16, %esp

# Syscall exit
pushl $0
call exit
