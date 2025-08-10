## AVR Digital I/O Bridge (ATmega32) Example 2
AVR assembly program for ATmega32 that creates a simple digital bridge between PORTB (input) and PORTA (output). Configures all PORTA pins as outputs and PORTB pins as inputs, then continuously reads the state of PORTB and mirrors it to PORTA in real-time. Basic example of GPIO configuration and data transfer between ports - useful for understanding digital I/O fundamentals and port manipulation.


## AVR Loop and Addition Demo (ATmega32) Example 5 v2
AVR assembly program for ATmega32 that demonstrates basic loop control and arithmetic operations. Adds the value 3 to itself 4 times using a decrementing counter loop, resulting in 3×4=12 stored in R17. Shows fundamental programming concepts: loop initialization, conditional branching with BRNE (Branch if Not Equal), and register-based arithmetic operations.


## AVR Power-of-2 Loop Demo (ATmega32) Example 5
AVR assembly program for ATmega32 that demonstrates doubling operations using a compare-and-branch loop. Starts with value 3 in R16 and repeatedly doubles it (3→6→12) until reaching 12, then exits. Shows register doubling through self-addition, immediate value comparison with CPI, and conditional looping with BRNE - illustrating binary arithmetic and loop termination conditions.


## AVR Nested Loop LED Toggle (ATmega32) Example 6 v2
AVR assembly program for ATmega32 that demonstrates nested loop control with LED pattern toggling. Sets PORTB as output with initial pattern 0x55, then uses nested loops (outer: 70 iterations, inner: 10 iterations) to create 700 total toggle cycles. Each inner loop toggles the bit pattern 10 times before the outer loop decrements. Shows nested loop programming, timing control through loop counts, and visual feedback via LED pattern inversion.


## AVR LED Toggle with 16-bit Delay (ATmega32) Example 6
AVR assembly program for ATmega32 that toggles PORTB output pins using a 16-bit delay counter. Initializes PORTB as output with pattern 0x55 (alternating bits), then continuously inverts the pattern using COM instruction. Uses a 16-bit counter (700 cycles) created from LOW/HIGH bytes to create visible timing delays. Demonstrates bit pattern toggling, 16-bit arithmetic, and basic LED blinking techniques for visual output indication.


## AVR Memory Initialization Check (ATmega32) Example 7
AVR assembly program for ATmega32 that implements conditional memory initialization using SRAM operations. Checks if memory location 0x200 contains zero, and initializes it with 0x55 only if empty. Demonstrates proper conditional branching with compare-and-branch logic, memory access using LDS/STS instructions, and one-time initialization patterns.