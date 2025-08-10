.include "m32def.inc"

.ORG 0x0000
RJMP START

START:
    LDI R16,0x03
    LDI R17,0x00
    LDI R18,0x04

    ADD_4_TIMES:
            ADD R17,R16 ; at first adds R16 to 0 then Adds 3 to itself
            DEC R18     ; decrements R18 4 times
            BRNE ADD_4_TIMES ; when R18 reaches zero the zero flag is set exiting the loop