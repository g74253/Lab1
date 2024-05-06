.section .data
array:
    .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 
y:
    .word 8

.section .text
.globl _start
_start:
    mov r4, #0
    ldr r5, =array 
    ldr r6, =y 
    ldr r7, [r6]

loop:
    cmp r4, #10
    bge end_loop

    ldr r0, [r5, r4, LSL #2] @hace desplazamiento logico
    cmp r0, r7 
    blt else_branch

    mul r0, r0, r7 
    str r0, [r5, r4, LSL #2] 
    b continue_loop 

else_branch:
    add r0, r0, r7  
    str r0, [r5, r4, LSL #2] 

continue_loop:
    add r4, r4, #1 
    b loop

end_loop:
	