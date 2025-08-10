.include "m32def.inc"

.ORG 0x0000
RJMP START

START:
    LDI R16, 0xFF  ; load immediate value 0xFF which is 1111 1111

    OUT DDRA, R16  ; puts what is in reg16 into DDRA setting all the pins as output

    LDI R16, 0x00  ; load immediate value 0x00 which is 0000 0000

    OUT DDRB, R16  ; put 0x00 into DDRB clearing all bits & setting pins as input

    GET_DATA_READ: ; loop to continously read PINB and send to PORTA
        IN  R16, PINB ; put what is in PINB into R16
        OUT PORTA, R16 ; put what is in R16 into PORTA
        RJMP GET_DATA_READ ; unconditional jump to GET_DATA_READ label to loop