; LCD Interface Program for ATmega32
; Displays "Hello World" on a 16x2 LCD in 4-bit mode

.include "m32def.inc"    ; Include ATmega32 definitions

; Define LCD control pins (connected to PORTB)
.equ LCD_RS = 0    ; Register Select on PB0
.equ LCD_RW = 1    ; Read/Write on PB1
.equ LCD_E  = 2    ; Enable on PB2
.equ LCD_DATA = 4  ; Data pins start at PB4 (PB4-PB7 for D4-D7)

; Register definitions
.def temp = r16    ; Temporary register
.def temp2 = r17   ; Second temporary register

; Reset vector
.org 0x0000
    rjmp main      ; Jump to main program

; Main program
main:
    ; Initialize the stack pointer
    ldi temp, HIGH(RAMEND)
    out SPH, temp    ; Set stack pointer high byte
    ldi temp, LOW(RAMEND)
    out SPL, temp    ; Set stack pointer low byte
    
    ; Initialize I/O ports
    ldi temp, (1<<LCD_RS)|(1<<LCD_RW)|(1<<LCD_E)|(0xF0)
    out DDRB, temp   ; Set control pins and data pins as outputs
    
    ; Initialize PORTB values to known state
    ldi temp, 0x00
    out PORTB, temp  ; Initialize all pins low
    
    rcall lcd_init   ; Initialize the LCD
    
    ; Display "Hello World"
    ldi ZH, high(message*2)  ; Load message address into Z pointer
    ldi ZL, low(message*2)
    rcall lcd_display_string  ; Display the string
    
    ; Main loop (do nothing, just display)
forever:
    rjmp forever

;------------------------------------------------
; Subroutine: LCD Initialization
;------------------------------------------------
lcd_init:
    ; Wait for LCD to power up
    rcall Delay15ms
    
    ; Ensure control signals are in correct state
    cbi PORTB, LCD_RS    ; RS=0 for command mode
    cbi PORTB, LCD_RW    ; RW=0 for write mode
    cbi PORTB, LCD_E     ; E=0 (idle state)
    
    ; First send 0x03 three times (special case for 4-bit initialization)
    ldi temp, 0x30       ; 8-bit mode command
    rcall lcd_send_high_nibble
    rcall Delay5ms
    
    ldi temp, 0x30       ; 8-bit mode command (second time)
    rcall lcd_send_high_nibble
    rcall Delay1ms
    
    ldi temp, 0x30       ; 8-bit mode command (third time)
    rcall lcd_send_high_nibble
    rcall Delay1ms
    
    ; Now switch to 4-bit mode
    ldi temp, 0x20       ; 4-bit mode command
    rcall lcd_send_high_nibble
    rcall Delay1ms
    
    ; Now we're in 4-bit mode, send full commands
    ldi temp, 0x28       ; Function set: 4-bit, 2 lines, 5x7 dots
    rcall lcd_send_command
    
    ldi temp, 0x0C       ; Display on, cursor off, blinking off
    rcall lcd_send_command
    
    ldi temp, 0x01       ; Clear display
    rcall lcd_send_command
    rcall Delay5ms       ; Clear display needs longer delay
    
    ldi temp, 0x06       ; Entry mode: increment cursor, no shift
    rcall lcd_send_command
    
    ret

;------------------------------------------------
; Subroutine: Send command to LCD
;------------------------------------------------
lcd_send_command:
    cbi PORTB, LCD_RS    ; RS=0 for command
    cbi PORTB, LCD_RW    ; RW=0 for write
    rcall lcd_send_byte  ; Send the byte
    rcall Delay50us      ; Wait for command to complete
    ret

;------------------------------------------------
; Subroutine: Send data to LCD
;------------------------------------------------
lcd_send_data:
    sbi PORTB, LCD_RS    ; RS=1 for data
    cbi PORTB, LCD_RW    ; RW=0 for write
    rcall lcd_send_byte  ; Send the byte
    rcall Delay50us      ; Wait for data write to complete
    ret

;------------------------------------------------
; Subroutine: Send byte to LCD in 4-bit mode
;------------------------------------------------
lcd_send_byte:
    push temp            ; Save the original byte
    rcall lcd_send_high_nibble  ; Send high nibble first
    pop temp             ; Restore the original byte
    swap temp            ; Swap nibbles to get low nibble in position
    rcall lcd_send_high_nibble  ; Send what was the low nibble
    ret

;------------------------------------------------
; Subroutine: Send high nibble to LCD
;------------------------------------------------
lcd_send_high_nibble:
    push temp            ; Save original value
    
    in temp2, PORTB      ; Read current port value
    andi temp2, 0x0F     ; Clear high nibble area
    andi temp, 0xF0      ; Keep only high nibble of data
    or temp, temp2       ; Combine with current port value
    out PORTB, temp      ; Output to port
    
    ; Pulse E pin to latch data
    sbi PORTB, LCD_E     ; E=1
    nop                  ; Small delay (E pulse must be >450ns)
    nop
    cbi PORTB, LCD_E     ; E=0
    
    pop temp             ; Restore original value
    ret

;------------------------------------------------
; Subroutine: Display string from program memory
;------------------------------------------------
lcd_display_string:
    lpm temp, Z+         ; Load character from program memory
    cpi temp, 0          ; Check for null terminator
    breq lcd_display_done ; If null, we're done
    
    rcall lcd_send_data  ; Send the character
    rjmp lcd_display_string ; Continue with next character
    
lcd_display_done:
    ret

;------------------------------------------------
; Delay Routines
;------------------------------------------------
Delay15ms:               ; 15ms delay for power-up
    push    r16
    push    r17
    
    ldi     r16, 150
    ldi     r17, 200
D15ms_Loop:
    dec     r17
    brne    D15ms_Loop
    dec     r16
    brne    D15ms_Loop
    
    pop     r17
    pop     r16
    ret

Delay5ms:                ; 5ms delay for clear and home commands
    push    r16
    push    r17
    
    ldi     r16, 50
    ldi     r17, 200
D5ms_Loop:
    dec     r17
    brne    D5ms_Loop
    dec     r16
    brne    D5ms_Loop
    
    pop     r17
    pop     r16
    ret

Delay1ms:                ; 1ms delay for initialization
    push    r16
    push    r17
    
    ldi     r16, 10
    ldi     r17, 200
D1ms_Loop:
    dec     r17
    brne    D1ms_Loop
    dec     r16
    brne    D1ms_Loop
    
    pop     r17
    pop     r16
    ret

Delay50us:               ; 50us delay for normal operations
    push    r16
    
    ldi     r16, 98
D50us_Loop:
    dec     r16
    brne    D50us_Loop
    
    pop     r16
    ret

;------------------------------------------------
; Message data in program memory
;------------------------------------------------
message: .db "Hello World", 0 