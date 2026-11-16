# PURPOSE:  This program writes the message "hello world" and
#           exits
#

.include "linux.s"

.section .data

helloworld: .ascii "hello world\n" 
helloworld_end: 

# NOTE: We compute the string length by the difference between the buffer 
#       address and a label just after its definition, 
#       resolved at assembly time
.equ helloworld_len, helloworld_end - helloworld

.section .text
.globl _start

_start:

# Syscall print hello world
movl $SYS_WRITE     , %eax
movl $STDOUT        , %ebx
movl $helloworld    , %ecx
movl $helloworld_len, %edx
int  $LINUX_SYSCALL

# Syscall exit
movl $SYS_EXIT, %eax
movl $0, %ebx
int  $LINUX_SYSCALL
