.section .text
.globl _start

_start:
    mov r0, #0              @ F(0)
    mov r1, #1              @ F(1)
    mov r2, #2              @ contador
    mov r4, #8              @ Valor establecido (8)

loop:
	add r5, r4,#1
    cmp r2, r5             
    bge end_loop           

    add r3, r0, r1         
    mov r0, r1             
    mov r1, r3             

    add r2, r2, #1         
    b loop                 

end_loop:
    mov r9, r3           
