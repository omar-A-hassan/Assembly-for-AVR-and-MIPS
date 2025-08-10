        .text
        .globl main

main:
        ori     $1,$0,0xF
        ori     $2,$0,0xE0
        or      $1,$2,$1
        xor     $2,$2,$2
        ori     $2,$0,0xE00
        or      $1,$2,$1
        xor     $2,$2,$2
        ori     $2,$0,0xB000
        or      $1,$2,$1
        xor     $2,$2,$2
        ori     $2,$0,0xD
        sll     $2,$2,28
        or      $1,$2,$1
        xor     $2,$2,$2
        ori     $2,$0,0xE
        sll     $2,$2,24
        or      $1,$2,$1
        xor     $2,$2,$2
        ori     $2,$0,0xA
        sll     $2,$2,20
        or      $1,$2,$1
        xor     $2,$2,$2
        ori     $2,$0,0xD
        sll     $2,$2,16
        or      $1,$2,$1
        xor     $2,$2,$2

