.data
mensaje: .asciiz "numero: "
mensaje2: .asciiz "resultado es: "

.text

sum:
    # Suma los valores de $a0 y $a1
    add $v0, $a0, $a1
    jr $ra

main:
    la $a0, mensaje
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    blt $v0, $zero, main
    add $s0, $v0, $zero

    add $s1, $zero, $zero

    add $a0, $s0, $zero
    add $a1, $s1, $zero

    jal sum

    add $s0, $v0, $zero

    la $a0, mensaje2
    li $v0, 4
    syscall

    add $a0, $s0, $zero
    li $v0, 1
    syscall

    li $v0, 10
    syscall
