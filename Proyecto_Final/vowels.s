.global _start

_start:
    LDR R0, =input_text       // Carga la dirección de memoria de input_text en R0
    LDR R1, =output_text      // Carga la dirección de memoria de output_text en R1
    LDR R3, =replacement      // Carga la dirección de memoria de replacement en R3
    LDR R2, =num_vowels       // Carga la dirección de memoria de num_vowels en R2

    BL process_text           // Llama a la función process_text

end_loop:
    B end_loop                // Bucle infinito

process_text:
    PUSH {LR, R4-R7}          // Guarda el registro de enlace (LR) y los registros R4-R7 en la pila
    MOV R4, #0                // Inicializa el contador de vocales a 0
    MOV R5, #0                // Inicializa el indicador de palabra con las vocales requeridas a 0
    MOV R6, #0                // Inicializa el registro para el carácter actual a 0

next_char:
    LDRB R6, [R0], #1         // Carga el siguiente byte del texto de entrada en R6
    CMP R6, #0                // Compara R6 con 0 (fin de cadena)
    BEQ done                   // Si es el final del texto, salta a done

    CMP R6, #' '              // Compara R6 con el espacio
    BEQ check_word            // Si es un espacio, salta a check_word
    CMP R6, #'.'
    BEQ check_word
    CMP R6, #'\n'
    BEQ check_word

    BL is_vowel               // Llama a la función is_vowel para verificar si R6 es una vocal
    CMP R7, #1                // Compara el resultado de is_vowel con 1 (si R6 es una vocal)
    ADDNE R4, R4, #1          // Si R6 es una vocal, incrementa el contador de vocales (R4)
    B next_char               // Salta a next_char para procesar el siguiente carácter del texto de entrada

check_word:
    CMP R4, R2                // Compara el contador de vocales (R4) con el número de vocales requerido (R2)
    BNE copy_word             // Si no coincide, salta a copy_word

    CMP R5, #0                // Compara el indicador de palabra con las vocales requeridas (R5) con 0
    BEQ reset_counters       // Si es 0, salta a reset_counters

    MOV R4, #0                // Reinicia el contador de vocales (R4) a 0
    MOV R5, #0                // Reinicia el indicador de palabra con las vocales requeridas (R5) a 0
    B next_char               // Salta a next_char para procesar el siguiente carácter del texto de entrada

copy_word:
    CMP R4, R2                // Compara el contador de vocales (R4) con el número de vocales requerido (R2)
    BNE copy_char_continue    // Si no coincide, salta a copy_char_continue

    MOV R5, #1                // Establece el indicador de palabra con las vocales requeridas (R5) a 1

copy_char_continue:
    CMP R5, #1                // Compara el indicador de palabra con las vocales requeridas (R5) con 1
    BEQ copy_replacement      // Si es 1, salta a copy_replacement
    STRB R6, [R1], #1         // Almacena el carácter actual (R6) en la dirección de memoria apuntada por R1 y avanza R1
    B check_end_of_word       // Salta a check_end_of_word para verificar el final de la palabra

copy_replacement:
    STRB R3, [R1], #1         // Almacena el carácter de reemplazo (R3) en la dirección de memoria apuntada por R1 y avanza R1
    B check_end_of_word       // Salta a check_end_of_word para verificar el final de la palabra

check_end_of_word:
    CMP R6, #' '              // Compara R6 con el espacio
    BEQ next_char             // Si es un espacio, salta a next_char
    CMP R6, #'.'
    BEQ next_char
    CMP R6, #'\n'
    BEQ next_char

    B next_char               // Salta a next_char para procesar el siguiente carácter del texto de entrada

reset_counters:
    MOV R4, #0                // Reinicia el contador de vocales (R4) a 0
    MOV R5, #1                // Establece el indicador de palabra con las vocales requeridas (R5) a 1
    STRB R3, [R1], #1         // Almacena el carácter de reemplazo (R3) en la dirección de memoria apuntada por R1 y avanza R1
    B next_char               // Salta a next_char para procesar el siguiente carácter del texto de entrada

done:
    MOV R6, #0                // Establece R6 a 0
    STRB R6, [R1]             // Almacena un byte nulo en la dirección de memoria apuntada por R1 (terminación del texto de salida)
    POP {R4-R7, LR}           // Restaura los registros R4-R7 y el registro de enlace (LR) desde la pila
    BX LR                      // Salta a la dirección almacenada en LR para regresar a la instrucción de llamada

is_vowel:
    PUSH {R0-R3, R7, LR}      // Guarda los registros R0-R3, R7 y LR en la pila
    MOV R7, #0                // Establece R7 a 0 (indicador de si R6 es una vocal)
    CMP R6, #'a'              // Compara R6 con 'a'
    BEQ is_vowel_done         // Si es 'a', salta a is_vowel_done
    CMP R6, #'e'              // Compara R6 con 'e'
    BEQ is_vowel_done         // Si es 'e', salta a is_vowel_done
    CMP R6, #'i'              // Compara R6 con 'i'
    BEQ is_vowel_done         // Si es 'i', salta
    CMP R6, #'o'              // Compara R6 con 'o'
    BEQ is_vowel_done         // Si es 'o', salta a is_vowel_done
    CMP R6, #'u'              // Compara R6 con 'u'
    BEQ is_vowel_done         // Si es 'u', salta a is_vowel_done
    CMP R6, #'A'              // Compara R6 con 'A'
    BEQ is_vowel_done         // Si es 'A', salta a is_vowel_done
    CMP R6, #'E'              // Compara R6 con 'E'
    BEQ is_vowel_done         // Si es 'E', salta a is_vowel_done
    CMP R6, #'I'              // Compara R6 con 'I'
    BEQ is_vowel_done         // Si es 'I', salta a is_vowel_done
    CMP R6, #'O'              // Compara R6 con 'O'
    BEQ is_vowel_done         // Si es 'O', salta a is_vowel_done
    CMP R6, #'U'              // Compara R6 con 'U'
    BEQ is_vowel_done         // Si es 'U', salta a is_vowel_done
    B is_vowel_exit           // Salta a is_vowel_exit si no es una vocal

is_vowel_done:
    MOV R7, #1                // Establece R7 a 1 (indicando que R6 es una vocal)

is_vowel_exit:
    POP {R0-R3, R7, LR}       // Restaura los registros R0-R3, R7 y LR desde la pila
    BX LR                      // Salta a la dirección almacenada en LR para regresar a la instrucción de llamada

.data
input_text:
    .asciz "Texto de prueba para que sea modificado"  // Texto de entrada
output_text:
    .space 1000                // Espacio para texto de salida

.equ num_vowels, 2             // Número de vocales requeridas en una palabra para ser reemplazada

replacement:
    .asciz "#"                 // Carácter de reemplazo para las palabras con el número requerido de vocales

