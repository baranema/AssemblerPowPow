.text

mystring: .asciz "Assignment 2: inout\n"

formatstr: .asciz "%dl"
formatstr2: .asciz "%d\n"

.global main

inout:
            pushq %rbp              # push the base pointer
            movq %rsp, %rbp         # copy stack pointer to %rbp

            subq $8, %rsp           # reserve stack space for variable
            leaq -8(%rbp), %rsi     # load address of stack var in rsi
            movq $formatstr, %rdi   # load argument of scanf
            
            movq $0, %rax
            call scanf

            movq -8(%rbp), %rsi     # move a return value into rsi
            mov $0,%rax

            movq %rbp, %rsp         # clear local variables from stack
            popq %rbp               # restore the base pointer

            ret                     # return from the subroutine

pow:
            pushq %rbp              # push the base pointer
            movq %rsp, %rbp         # copy stack pointer to %rbp

loop:
            cmpq $0, %rbx     
            jl endcode   
            jmp ifcode
            
ifcode:
            #pushq %rsi              # save number value
            subq $1, %rbx           # reduce number value by 1
            
            #popq %rsi               
            #mulq %rsi               # multiply number with previous number

            jmp loop

endcode:
            movq %rbp, %rsp         # clear local variables from stack
            popq %rbp               # restore the base pointer

            ret   
            
main:
            movq %rsp, %rbp         # copy stack pointer to %rbp

            mov $0, %rax
            movq $mystring, %rdi    # load address of a string 
            call printf             # print mystring

            movq $0, %rbx
            call inout              # call inout subroutine
            addq %rsi, %rbx

            mov $0, %rax
            call inout

            call pow
            
            mov $0, %rax            # no vector registers in use of printf
            movq $formatstr2, %rdi  # load address of string
            call printf             # print formatstr2

end:
            mov     $0 , %rdi       # load program exit code
            call    exit            # exit the program
