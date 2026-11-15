.include "linux.s"
.include "record-def.s"

.section .data
input_file: .asciz "test.dat"

.section .bss
.lcomm buffer, RECORD_SIZE


# Local variables addresses
.equ FD_INPUT, -4
.equ GREATEST, -8

.section .text
.globl _start

_start:
movl %esp, %ebp

# Reserve memory for local variables
subl $8, %esp

# Init local variables 
movl $0, GREATEST(%ebp)    

# Syscall open input
movl $SYS_OPEN  , %eax
movl $input_file, %ebx
movl $0         , %ecx
movl $0666      , %edx
int $LINUX_SYSCALL
movl %eax, FD_INPUT(%ebp)

loop_begin:
# Call read next record
pushl FD_INPUT(%ebp)
pushl $buffer
call read_record
addl $8, %esp

# Exit if read bytes are different than expected
cmpl $RECORD_SIZE, %eax
jne loop_end

# Compute and store the maximum age
pushl GREATEST(%ebp)
pushl RECORD_AGE + buffer
call max
addl $8, %esp
movl %eax, GREATEST(%ebp)

jmp loop_begin

loop_end:

# Syscall close input
movl $SYS_CLOSE    , %eax
movl FD_INPUT(%ebp), %ebx
int $LINUX_SYSCALL

# Syscall exit with result as return code
movl $SYS_EXIT     , %eax
movl GREATEST(%ebp), %ebx # TODO change this to the greatest
int $LINUX_SYSCALL


# MAX function
# INPUT:  Two numbers
# OUTPUT: The maximum value
.type max, @function
.equ MAX_ARG0, 8
.equ MAX_ARG1, 12
max:
pushl %ebp
movl %esp, %ebp

movl MAX_ARG0(%ebp), %eax
movl MAX_ARG1(%ebp), %ebx
cmpl %eax, %ebx
jle max_end
movl %ebx, %eax

max_end:
movl %ebp, %esp
popl %ebp
ret

