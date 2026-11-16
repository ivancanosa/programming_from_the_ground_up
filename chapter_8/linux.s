# ------ Common Linux Definitions ------

# -- System Call Numbers --
.equ SYS_EXIT  , 1
.equ SYS_READ  , 3
.equ SYS_WRITE , 4
.equ SYS_OPEN  , 5
.equ SYS_CLOSE , 6
.equ SYS_LSEEK , 19
.equ SYS_BRK   , 45

# -- System Call Interrupt Number --
.equ LINUX_SYSCALL, 0x80

# -- Standard File Descriptors --
.equ STDIN , 0
.equ STDOUT, 1
.equ STDERR, 2

# -- Common Status Codes --

# -- Symbols lseek --
.equ SEEK_SET, 0 # Seek from beginning of file
.equ SEEK_CUR, 1 # Seek from current position
.equ SEEK_END, 2 # Seek from end of file

