.include "m32def.inc"

.ORG 0x0000
RJMP START

START:
     LDI  R16, 0xFF
     OUT  DDRB, R16        ; sets portb as output
     LDI  R17, LOW(700)    ; captures low byte of 700 
     LDI  R18, HIGH(700)   ; captures high byte of 700
     LDI  R16, 0x55
     OUT  PORTB, R16       ; puts 0x55 in portb

     LOOP:
     COM  R16             ; inverts what is in r16 ie toggling it
     OUT  PORTB, R16
     DEC  R17             ; decrements low byte
     BRNE LOOP
     DEC  R18             ; decrements high byte
     BRNE LOOP
