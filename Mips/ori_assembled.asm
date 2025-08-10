        .text
        .globl  main

main:
        xor    $25,$25,$25    #clears register 25
        ori    $25,$0,0xD     #loads opcode in register 25
        sll    $25,$25,26     #shift opcode 0xD 26 positions to the left
        ori    $10,$0,0x9     #loads operand register
        sll    $10,$10,21     #moves operand register 21 positions into it's correct position
        or     $25,$25,$10
        xor    $10,$10,$10
        ori    $10,$0,0x8
        sll    $10,$10,16
        or     $25,$25,$10
        xor    $10,$10,$10
        ori    $10,$0,0x004A
        or     $25,$25,$10