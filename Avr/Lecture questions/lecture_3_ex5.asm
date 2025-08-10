.include "m32def.inc"

.ORG 0x0000
RJMP START

START:
    LDI R16,0x03

    ADD_4_TIMES:
            ADD R16, R16  ; add R16 to itself has the same effect of doubling it
            CPI R16, 0x0C ; compare R16 to 12
            BRNE ADD_4_TIMES ; loops untill R16 = 12