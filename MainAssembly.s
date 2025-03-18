/*
 * MainAssembly.s
 *
 *  Created on: Mar 17, 2025
 *      Author: alkar
 */
.syntax unified
.cpu cortex-m4
.thumb
.global assembly_main
.section .text

assembly_main:
    push {r1, lr}   @ Save return address (lr) and registers

    @ Enable GPIOA Clock (RCC_AHBENR)
    ldr r0, =0x40021014
    ldr r1, [r0]
    orr r1, r1, #(1 << 17)
    str r1, [r0]

    @ Configure PA5 as output (GPIOA_MODER)
    ldr r0, =0x48000000
    ldr r1, [r0]
    bic r1, r1, #(3 << (5 * 2))
    orr r1, r1, #(1 << (5 * 2))
    str r1, [r0]

    @ Turn LED ON (GPIOA_ODR)
    ldr r0, =0x48000014
    ldr r1, [r0]
    orr r1, r1, #(1 << 5)
    str r1, [r0]
	bl delay

    @ Turn LED OFF (GPIOA_ODR)
    ldr r1, [r0]
    bic r1, r1, #(1 << 5)
    str r1, [r0]
    bl delay @ Call delay function
    pop {r1, pc}  @ Restore registers and return properly

delay:
    ldr r2, =100000
delay_loop:
    subs r2, #1
    bne delay_loop
	bx lr
