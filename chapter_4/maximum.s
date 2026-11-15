.section .data

array0: .long 2,94,1,12,53,0
array1: .long 93,32,6,1,0
array2: .long 12,65,53,1,85,0

.section .text
.globl _start

_start:
pushl $array0   # call maximum with array0
call maximum
addl $4, %esp

pushl $array1   # call maximum with array1
call maximum
addl $4, %esp

pushl $array2   # call maximum with array2
call maximum
addl $4, %esp

movl %eax, %ebx # Set the maximum number as exit code
movl $1, %eax   # syscall to exit program
int $0x80

# INPUT:  Address to an array of numbers with 0 as sentinel
# OUTPUT: The maximum value in %eax
# Variables:
#           8(%ebp) start of the array
#           %ebx    start of the array
#           %eax    current maximum number
#           %ecx    current number to test
#           %edi    current array position index
.type maximum, @function
maximum:
pushl %ebp         # Standard function start
movl %esp, %ebp
movl 8(%ebp), %ebx # store the start of the array
movl $0, %edi      # Set iterator to 0
movl (%ebx), %eax  # ininialize %eax with first element of the array

maximum_loop:
movl (%ebx, %edi, 4), %ecx
incl %edi
cmpl $0, %ecx
je maximum_end

cmpl %ecx, %eax  # compare current number with maximum one
jg maximum_loop  # return to loop if current one is less or equal to maximum
movl %ecx, %eax 
jmp maximum_loop

maximum_end:
movl %esp, %ebp
popl %ebp
ret
