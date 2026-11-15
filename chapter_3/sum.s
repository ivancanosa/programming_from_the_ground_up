# PURPOSE:      This program computes the sum of a list of numbers
#
# VARIABLES:    The registers have the following uses:
#
# %edi - Holds the index of the data item being examined
# %ebx - Accumulator
# %eax - Current data item
#
# The following memory locations are used:
#
# data_items - contains the item data. A 0 is used
#              to terminate the data
#

.section .data

data_items:     # These are the data items
.long 10,20,81,21,0

.section .text

.globl _start
_start:

movl $0, %edi               # move 0 into the index register
movl $0, %ebx               # set accumulator to 0

start_loop:                 # start loop
movl data_items(,%edi,4), %eax  # load the first number
addl %eax, %ebx             # add retrieved number into accumulator
cmpl $0, %eax               # check to see if we've hit the end
je loop_exit            
incl %edi                   # load next value
jmp start_loop              # jump to loop beginning

loop_exit:
# %ebx is the status code for the exit system call
# and it already has the maximum number
movl $1, %eax
int $0x80
