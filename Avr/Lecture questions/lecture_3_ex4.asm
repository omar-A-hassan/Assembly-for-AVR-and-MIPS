.include "m32def.inc"


.ORG 0x0000
RJMP START

START:
     LDS R16, 0x300 ; load address 0x300 into R16
     SUBI R16, 5    ; sub 5  from R16
     STS  0x320, R16 ; return what is in R16 to address 0x300