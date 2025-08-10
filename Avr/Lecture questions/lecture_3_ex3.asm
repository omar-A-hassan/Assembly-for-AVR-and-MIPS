.include "m32def.inc"

.ORG 0x0000

RJMP START

START:
      LDS R5, 0x420 ; load what is in address 0x420 into R5
      INC R5        ; increment what is register R5 by 1
      STS 0x420, R5 ; return what is in R5 into address 0x420