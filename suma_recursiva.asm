.data
mensaje: .asciiz "numero: "
mensaje2: .asciiz "resultado es: "

.text

sum:
    beq $a0, $zero, sum_exit 
    add $a1, $a1, $a0 
    addi $a0, $a0, -1 
    j sum 
sum_exit:
    add $v0, $a1, $zero 
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
