# PURPOSE: Prints hello world to stdout
#
# NOTE: syscall write needs this:
# %eax with 4 for syscall write
# %ebx with 1 for stdout file descriptor
# %ecx buffer address
# %edx buffer size
#
# NOTE: in the _start address, argc is in (%esp), argv[0] in 4(%esp), etc...

.section .data
str: .ascii "Hello, world!\n\0"

.section .text
.globl _start

# ============== START ==============
_start:
pushl $str
call print
addl $4, %esp

call exit

# PURPOSE: Function that prints to stdout a string
# Input: a buffer address and a buffer size
# Variables:
#       8(%ebp) - buffer address
#       12(%ebp)  - buffer size
.type printn, @function
printn:
pushl %ebp           # standard function start
movl %esp, %ebp     

movl $4, %eax        # write syscall
movl $1, %ebx        # stdout file descriptor
movl 8(%ebp), %ecx   # use str buffer
movl 12(%ebp), %edx  # the size of the buffer
int $0x80            # performs the print syscall

movl %ebp, %esp      # standard function end
popl %ebp
ret


# PURPOSE: Gets the length of a 0 terminated string
# Input: Address of a string
# Variables:
#       %eax - size of the string
#       %ebx - buffer address
#       %cl - current character
#       %edi - buffer index
.type strlen, @function
strlen:
pushl %ebp
movl %esp, %ebp

movl $0, %edi      # Initialize size to 0
movl 8(%ebp), %ebx # Initialize %ebx to string address

strlen_loop:
movb (%ebx, %edi, 1), %cl
cmpb $0, %cl
je strlen_end      # jump to end if the current character is \0
incl %edi
jmp strlen_loop

strlen_end:
movl %edi, %eax
movl %ebp, %esp
popl %ebp
ret


# PURPOSE: Prints a null terminated string
# Input: an address of a null terminated string
# Variables:
#       8(%ebp) buffer address
#       %eax buffer size
.type print, @function
print:
pushl %ebp
movl %esp, %ebp

pushl 8(%ebp)   # Get the string size into %eax
call strlen
addl $4, %esp

pushl %eax      # Calls printn with an address and its size
pushl 8(%ebp)
call printn
addl $8, %esp

movl %ebp, %esp
popl %ebp
ret


# PURPOSE: Exits the program
.type exit, @function
exit:
movl $1, %eax   # exit syscall
movl $0, %ebx   # return code 0
int $0x80

