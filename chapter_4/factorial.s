# PURPOSE - Given a number, this program computes the
#           factorial. For example, the factorial of
#           3 is 3 * 2 * 1, or 6. The factorial of 
#           4 is 4 * 3 * 2 * 1, or 24, and so on.
#

# This program shows how to call a function recursively.

.section data

# This program has no global data

.section .text

.globl _start
.globl factorial # This is unneded unless we want to sahre
                 # this function among other programs
_start:
pushl $4         # The factorial takes one argument - the
                 # number we want a factorial of. So, it 
                 # gets pushed
call factorial   # run the factorial function
addl $4, %esp    # Scrubs the paramenter that was pushed
                 # on the stack
movl %eax, %ebx  # factorial returns the answer in %eax, but
                 # we want it in %ebx to send it as our exit
                 # status
movl $1, %eax    #call the kernel's exit function
int $0x80

# This is the actual function definition
# INPUT: number integer
# OUTPUT: number integer
.type factorial, @function
factorial:
pushl %ebp
movl %esp, %ebp
movl 8(%ebp), %eax

cmpl $1, %eax    # if input argument is 1, the result is 1, so return
je factorial_end

decl %eax          # decrease %eax
pushl %eax         # push decreased value into function argument
call factorial     # recursive call with the decreased argument
addl $4, %esp      # return %esp to before funcion call
movl 8(%ebp), %ebx # pop current argument value
imull %ebx, %eax

factorial_end:
movl %esp, %ebp
popl %ebp
ret
