    .text
    .globl main
main:
    
    ori $1, $0, 0xFACE
    and $2, $1, 0xF000
    and $3, $1, 0x00F0
    and $4, $1, 0x0F0F
    sll $3, $3, 8
    srl $2, $2, 8
    xor $1, $1, $1
    or  $5, $2, $3
    or  $5, $5, $4
