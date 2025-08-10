; LCD Interface Program for ATmega32 with Temperature Sensor
; Displays temperature reading from ADC0 (PA0)

.include "m32def.inc"    ; Include ATmega32 definitions

; Define LCD control pins (connected to PORTB)
.equ LCD_RS = 0    ; Register Select on PB0
.equ LCD_RW = 1    ; Read/Write on PB1
.equ LCD_E  = 2    ; Enable on PB2
.equ LCD_DATA = 4  ; Data pins start at PB4 (PB4-PB7 for D4-D7)


; Register definitions
.def temp = r16    ; Temporary register
.def temp2 = r17   ; Second temporary register
.def adc_value = r20   ; Register to store ADC reading

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
    out DDRB, temp   ; Set LCD control and data pins as outputs
    
    ; Initialize PORTB values to known state
    ldi temp, 0x00
    out PORTB, temp  ; Initialize all pins low
    
    ; Configure PA0 as input for ADC
    cbi DDRA, 0      ; Clear bit 0 in DDRA (PA0 as input)
    
    ; Initialize ADC
    ldi temp, 0x87   ; Enable ADC, prescaler = 128
    out ADCSRA, temp
    
    ldi temp, 0xE0   ; 2.56V reference, left-adjusted (ADLAR=1), ADC0
    out ADMUX, temp
    
    rcall lcd_init   ; Initialize the LCD
    
    ; Display "Temperature:" label
    ldi ZH, high(temp_msg*2)  ; Load message address into Z pointer
    ldi ZL, low(temp_msg*2)
    rcall lcd_display_string  ; Display the string
    
    ; Main loop - read temperature and display
forever:
    ; Start ADC conversion
    sbi ADCSRA, ADSC
    
    ; Wait for conversion to complete
wait_adc:
    sbis ADCSRA, ADIF
    rjmp wait_adc
    
    ; Clear ADIF by writing 0 to it
    cbi ADCSRA, ADIF
    
    ; Read ADC result (8-bit, left-adjusted)
    in adc_value, ADCH
    
    ; Convert and display temperature
    rcall convert_display_temp
    
    ; Delay between readings (approx. 500ms)
    ldi temp, 20
    loop_delay:
        rcall Delay15ms
        dec temp
        brne loop_delay
    
    rjmp forever

;------------------------------------------------
; Subroutine: Convert and display temperature
;------------------------------------------------
convert_display_temp:
    push temp
    push temp2
    
    ; Position cursor at column 13 on first line
    ldi temp, 0x8D
    rcall lcd_send_command
    
    ; Convert binary value to decimal digits
    mov temp, adc_value
    ldi temp2, 10
    rcall divide    ; Divide by 10
    
    ; Now temp contains tens digit, temp2 contains ones digit
    
    ; Display tens digit
    subi temp, -0x30    ; Convert to ASCII
    rcall lcd_send_data
    
    ; Display ones digit
    mov temp, temp2
    subi temp, -0x30    ; Convert to ASCII
    rcall lcd_send_data
    
    pop temp2
    pop temp
    ret

;------------------------------------------------
; Subroutine: Division (temp / temp2)
;------------------------------------------------
divide:
    push r23
    clr r23    ; Initialize quotient
divide_loop:
    cp temp, temp2
    brlo divide_done
    sub temp, temp2
    inc r23
    rjmp divide_loop
divide_done:
    mov temp2, temp    ; Remainder to temp2
    mov temp, r23      ; Quotient to temp
    pop r23
    ret

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
    push r16
    push r17
    
    ldi r16, 150
    ldi r17, 200
D15ms_Loop:
    dec r17
    brne D15ms_Loop
    dec r16
    brne D15ms_Loop
    
    pop r17
    pop r16
    ret

Delay5ms:                ; 5ms delay for clear and home commands
    push r16
    push r17
    
    ldi r16, 50
    ldi r17, 200
D5ms_Loop:
    dec r17
    brne D5ms_Loop
    dec r16
    brne D5ms_Loop
    
    pop r17
    pop r16
    ret

Delay1ms:                ; 1ms delay for initialization
    push r16
    push r17
    
    ldi r16, 10
    ldi r17, 200
D1ms_Loop:
    dec r17
    brne D1ms_Loop
    dec r16
    brne D1ms_Loop
    
    pop r17
    pop r16
    ret

Delay50us:               ; 50us delay for normal operations
    push r16
    
    ldi r16, 98
D50us_Loop:
    dec r16
    brne D50us_Loop
    
    pop r16
    ret

;------------------------------------------------
; Message data in program memory
;------------------------------------------------
temp_msg: .db "Temperature:", 0