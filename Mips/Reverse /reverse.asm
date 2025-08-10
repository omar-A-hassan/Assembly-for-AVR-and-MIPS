        .text
        .globl  main

main:
        lui     $1,0x7654
        ori     $1,0x3210
        andi    $2,$1,0xF
        sll     $2,$2,27
        lui     $15,0xF000
        ori     $15,0x0000
        and     $3,$1,$15
        srl     $3,$3,28
        or      $2,$2,$3
        xor     $3,$3,$3
        andi    $3,$1,0xF0
        sll     $3,$3,20
        or      $2,$2,$3
        xor     $3,$3,$3
        xor     $15,$15,$15
        lui     $15,0x0F00
        ori     $15,0x0000
        and     $3,$1,$15
        srl     $3,$3,20
        or      $2,$2,$3
        xor     $3,$3,$3
        xor     $15,$15,$15
        andi    $3,$1,0xF00
        sll     $3,$3,12
        or      $2,$2,$3
        xor     $3,$3,$3
        xor     $15,$15,$15
        lui     $15,0x00F0
        ori     $15,0x0000
        and     $3,$1,$15
        srl     $3,$3,12
        or      $2,$2,$3
        xor     $3,$3,$3
        xor     $15,$15,$15
        andi    $3,$1,0xF000
        sll     $3,$3,4
        or      $2,$2,$3
        xor     $3,$3,$3
        xor     $15,$15,$15
        lui     $15,0x000F
        ori     $15,0x0000
        and     $3,$1,$15
        srl     $3,$3,4
        or      $2,$2,$3

        
