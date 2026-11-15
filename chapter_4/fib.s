.section .data

.section .text
.globl _start

_start:
pushl $12       # push n to compute fibbonacci
call fib        # call fib(n)
addl $4, %esp   # restore the stack

movl %eax, %ebx # Set the fibbonaci number as exit code
movl $1, %eax   # syscall to exit program
int $0x80

# PURPOSE: Computes the n-th fibonacci number with 
#          recursive calls to f(n-1) and f(n-2)
# VARIABLES:
#       8(%ebp)  input argument
#       -4(%ebp) accumulator
#       %eax     the result
.type fib, @function
fib:
pushl %ebp
movl %esp, %ebp
subl $4, %esp       # Create space for the accumulator

cmpl $2, 8(%ebp)
jle fib_base        # jump to the base case if n <= 2

movl 8(%ebp), %eax  # move input argument to %eax

decl %eax
pushl %eax
call fib            # call fib(n-1)
addl $4, %esp       # restore the stack
movl %eax, -4(%ebp) # store fib(n-1) in -4(%ebp)

movl 8(%ebp), %eax  # retrieve again n
subl $2, %eax       # compute n-2
pushl %eax
call fib            # call fib(n-2)
addl $4, %esp       # restore the stack

addl -4(%ebp), %eax # add fib(n-1) into %eax
jmp fib_end         # end function

fib_base:
movl $1, %eax

fib_end:
movl %ebp, %esp
popl %ebp
ret
