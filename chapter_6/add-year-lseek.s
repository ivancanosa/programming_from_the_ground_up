.include "linux.s"
.include "record-def.s"

.section .data
file_name : .asciz "test.dat"

.section .bss
.lcomm record_buffer, RECORD_SIZE

# Stack offsets of local varaibles
.equ ST_INPUT_DESCRIPTOR, -4
.equ ST_OUTPUT_DESCRIPTOR, -8

.section .text
.globl _start
_start:
# Copy stack pointer and make room for local variables
movl %esp, %ebp
subl $8, %esp

# Syscall open file for reading and writing
movl $SYS_OPEN , %eax
movl $file_name, %ebx
movl $2        , %ecx
movl $0666     , %edx
int  $LINUX_SYSCALL
movl %eax, ST_INPUT_DESCRIPTOR(%ebp)
movl %eax, ST_OUTPUT_DESCRIPTOR(%ebp)


# Loop transforming input and writting to output
loop_begin:

# Call read next record
pushl ST_INPUT_DESCRIPTOR(%ebp)
pushl $record_buffer
call read_record
addl $8, %esp

# Returns the number of bytes read.
# If it isn't the same number we
# requested, then it's either an
# end-of-file, or an error, so we're
# quitting
cmpl $RECORD_SIZE, %eax
jne loop_end

# Increment the age
incl record_buffer + RECORD_AGE

# Syscall to backtrace a record, since after reading it our pointer in the
# file descriptor moved ahead
movl $SYS_LSEEK               , %eax
movl ST_INPUT_DESCRIPTOR(%ebp), %ebx
movl $-RECORD_SIZE            , %ecx
movl $SEEK_CUR                , %edx
int  $LINUX_SYSCALL

# Write the record out
pushl ST_OUTPUT_DESCRIPTOR(%ebp)
pushl $record_buffer
call write_record
addl $8, %esp

jmp loop_begin

loop_end:
movl $SYS_EXIT, %eax
movl $0       , %ebx
int  $LINUX_SYSCALL
