        .text
        .globl  main

main:
        ori    $1, $0, 0x7654    #clears register 25
        sll    $1, $1, 16
        ori    $1, $1, 0x3210
        andi   $2, $1, 0xFF
        nor    $2, $2, $0
        andi   $2, $2, 0xFF