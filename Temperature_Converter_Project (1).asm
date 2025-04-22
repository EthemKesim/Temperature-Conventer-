	.data
    prompt:         .asciiz "Select input temperature unit:\n1. Celsius\n2. Fahrenheit\n3. Kelvin\n4. Rankine\nChoice: "
    enter_value:    .asciiz "Enter the temperature value: "
    invalid_input:  .asciiz "Invalid input. Please enter a number from 1 to 4.\n"
    out_c:          .asciiz "Celsius: "
    out_f:          .asciiz "Fahrenheit: "
    out_k:          .asciiz "Kelvin: "
    out_r:          .asciiz "Rankine: "
    newline:        .asciiz "\n"

.text
.globl main
main:
input_unit:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    blt $t0, 1, invalid_input_loop
    bgt $t0, 4, invalid_input_loop
    j continue_program

invalid_input_loop:
    li $v0, 4
    la $a0, invalid_input
    syscall
    j input_unit

continue_program:
    li $v0, 4
    la $a0, enter_value
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    beq $t0, 1, input_is_celsius
    beq $t0, 2, input_is_fahrenheit
    beq $t0, 3, input_is_kelvin
    beq $t0, 4, input_is_rankine

input_is_celsius:
    move $t2, $t1
    j convert

input_is_fahrenheit:
    li $t3, 32
    sub $t4, $t1, $t3
    li $t5, 5
    li $t6, 9
    mul $t4, $t4, $t5
    div $t4, $t6
    mflo $t2
    j convert

input_is_kelvin:
    li $t3, 273
    sub $t2, $t1, $t3
    j convert

input_is_rankine:
    li $t3, 491
    sub $t4, $t1, $t3
    li $t5, 5
    li $t6, 9
    mul $t4, $t4, $t5
    div $t4, $t6
    mflo $t2
    j convert

convert:
    # Celsius to Fahrenheit
    li $t3, 9
    li $t4, 5
    mul $t5, $t2, $t3
    div $t5, $t4
    mflo $t5
    li $t6, 32
    add $t5, $t5, $t6

    # Celsius to Kelvin
    li $t6, 273
    add $t7, $t2, $t6

    # Celsius to Rankine
    li $t8, 9
    li $t9, 5
    mul $s0, $t7, $t8
    div $s0, $t9
    mflo $s0
    li $v0, 4
    li $t9, 1
    bne $t0, $t9, show_celsius
    j skip_celsius

show_celsius:
    la $a0, out_c
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, newline
    syscall

skip_celsius:
    li $t9, 2
    bne $t0, $t9, show_fahrenheit
    j skip_fahrenheit

show_fahrenheit:
    la $a0, out_f
    syscall
    li $v0, 1
    move $a0, $t5
    syscall
    li $v0, 4
    la $a0, newline
    syscall

skip_fahrenheit:
    li $t9, 3
    bne $t0, $t9, show_kelvin
    j skip_kelvin

show_kelvin:
    la $a0, out_k
    syscall
    li $v0, 1
    move $a0, $t7
    syscall
    li $v0, 4
    la $a0, newline
    syscall

skip_kelvin:
    li $t9, 4
    bne $t0, $t9, show_rankine
    j done

show_rankine:
    la $a0, out_r
    syscall
    li $v0, 1
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, newline
    syscall

done:
    li $v0, 10
    syscall
