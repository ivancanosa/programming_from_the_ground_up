# PURPOSE:  This is a test usage of the load priority of LD_PRELOAD.
#           This file only provides an implementation for the exit function
#           from the libc. It needs to have the same format of input and 
#           output arguments. The test will be to use
#           "LD_PRELOAD=libc.so test-exit" so see how the executable uses
#           our own implementation instead of the original libc. We don't need
#           to implement all of libc, unresolved symbols will be searched
#           in the original .so

.section .data
err_msg: .asciz "Exit error code: %i\n"

.section .text

.globl exit
.type exit, @function
.equ EXIT_CODE, 8

exit:
pushl %ebp
movl %esp, %ebp

# NOTE - It is problematic to reference addresses of the .data section
#        from the .text when the object is to be compiled as a
#        shared library. So, it is necesary a specific operation
#        to get the relocated address during runtime, a process
#        known normally as PIC.
call .Lget_pc
.Lget_pc:
popl %ecx
addl $(err_msg - .Lget_pc), %ecx

# NOTE - You should call printf@PLT instead of printf, if the object is
#        to be compiled as a shared library. For the same reason as before. In
#        this case, the ELF format provides a mechanism for the relocation.
pushl EXIT_CODE(%ebp)
pushl %ecx
call printf@PLT
addl $8, %esp

# Syscall exit
movl $1             , %eax
movl EXIT_CODE(%ebp), %ebx
int  $0x80

# NOTE - This provides useful information for the ELF header. If you do
#        readelf -s custom.exit.o, it can show you the size of the function. 
#        Otherwise, it would just show 0 bytes. This is a good practice, but
#        not mandatory.
.size exit, .-exit
