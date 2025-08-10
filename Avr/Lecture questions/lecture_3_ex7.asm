.include "m32def.inc"

.ORG 0x0000
RJMP START

START:
    LDS R16, 0x200    ; Load the value at memory address 0x200 into R16

    CPI R16, 0x00     ; Compare R16 with 0x00
    BRNE SKIP_LOAD    ; If R16 != 0, skip the LOAD_REG block

LOAD_REG:
    LDI R16, 0x55     ; Load 0x55 into R16
    STS 0x200, R16    ; Store R16 (0x55) into memory address 0x200

SKIP_LOAD:
    ; Continue with the rest of the program