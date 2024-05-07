.global main  

.data  @ Sección de datos, donde se definen las variables estáticas.

matrix1:  @ Define la matriz 1.
    .word 1, 2, 3, 4  @ Define los elementos de la primera fila.
    .word 1, 2, 3, 4  @ Define los elementos de la segunda fila.
    .word 1, 2, 3, 4  @ Define los elementos de la tercera fila.
    .word 1, 2, 3, 4  @ Define los elementos de la cuarta fila.

matrix2:  @ Define la matriz 2.
    .word 1, 1, 1, 1  @ Define los elementos de la primera fila.
    .word 2, 2, 2, 2  @ Define los elementos de la segunda fila.
    .word 3, 3, 3, 3  @ Define los elementos de la tercera fila.
    .word 4, 4, 4, 4  @ Define los elementos de la cuarta fila.

result:  @ Define el array para almacenar el resultado de la suma.
    .space 64  @ Reserva espacio para un array de 16 elementos de 4 bytes cada uno (4x4 matrix requires 64 bytes).

.text  @ Sección de código, donde se definen las instrucciones del programa.

main:  @ Función principal del programa.

    @ Carga la dirección de matrix1 en un registro.
    ldr r0, =matrix1
    
    @ Carga la dirección de matrix2 en un registro.
    ldr r1, =matrix2
    
    @ Carga la dirección de result en un registro.
    ldr r2, =result
    
    @ Inicia un bucle para recorrer los arrays (cada array tiene 16 elementos).
    mov r3, #0  @ Inicializa un contador para el bucle.
loop:
    @ Carga los elementos de matrix1 y matrix2.
    ldr r4, [r0, r3, lsl #2]  @ Carga un elemento de matrix1.
    ldr r5, [r1, r3, lsl #2]  @ Carga un elemento de matrix2.
    
    @ Suma los elementos.
    add r6, r4, r5  @ Suma los elementos de matrix1 y matrix2.
    
    @ Almacena el resultado.
    str r6, [r2, r3, lsl #2]  @ Almacena el elemento resultado en el array result.
    
    @ Incrementa el contador.
    add r3, r3, #1  @ Incrementa el contador del bucle.
    
    @ Comprueba si el contador ha llegado a 16 (fin de los arrays).
    cmp r3, #16  @ Compara el contador con 16.
    blt loop  @ Salta a loop si el contador es menor que 16 (repetir el bucle).
    
    @ Fin del programa.
    b end  @ Salta a la etiqueta end.

end:

    b end  
