.data   
arr:    .word   10, 60, 40, 70, 20, 30, 90, 100, 0, 80, 50
space:  .asciiz " "
.text   
        .globl  main

main:   
    # Inicialización de registros y variables
    lui     $s0,    0x1001                                  # Dirección de arr[0]
    li      $t0,    0                                       # i = 0
    li      $t1,    0                                       # j = 0
    li      $s1,    11                                      # n = 11
    li      $s2,    11                                      # n-i para el bucle interno
    add     $t2,    $zero,      $s0                         # Para iterar la dirección por i
    add     $t3,    $zero,      $s0                         # Para iterar la dirección por j

    addi    $s1,    $s1,        -1

outer_loop:
    li      $t1,    0                                       # j = 0
    addi    $s2,    $s2,        -1                          # Decrementar tamaño para el bucle interno
    add     $t3,    $zero,      $s0                         # Reiniciar la dirección de iteración por j

inner_loop:
    lw      $s3,    0($t3)                                  # arr[j]
    addi    $t3,    $t3,        4                           # Iterar la dirección por j += 4
    lw      $s4,    0($t3)                                  # arr[j+1]
    addi    $t1,    $t1,        1                           # j++

    slt     $t4,    $s3,        $s4                         # Establecer $t4 = 1 si $s3 < $s4
    bne     $t4,    $zero,      cond

    # Intercambiar los elementos si es necesario
swap:   
    sw      $s3,    0($t3)
    sw      $s4,    -4($t3)
    lw      $s4,    0($t3)

cond:   
    bne     $t1,    $s2,        inner_loop                  # j != n-i

    addi    $t0,    $t0,        1                           # i++
    bne     $t0,    $s1,        outer_loop                  # i != n

    # Imprimir el arreglo resultante
    li      $t0,    0
    addi    $s1,    $s1,        1

print_loop:
    li      $v0,    1
    lw      $a0,    0($t2)
    syscall 
    li      $v0,    4
    la      $a0,    space
    syscall 

    addi    $t2,    $t2,        4                           # Iterar la dirección por i += 4
    addi    $t0,    $t0,        1                           # i++
    bne     $t0,    $s1,        print_loop                  # i != n

exit:   
    # Salir del programa
    li      $v0,    10
    syscall 