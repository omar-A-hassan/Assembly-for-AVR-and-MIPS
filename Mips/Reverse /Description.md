## MIPS Nibble Reversal Algorithm done in reverse.asm
MIPS assembly program that reverses the order of nibbles (4-bit groups) in a 32-bit word. Takes the value `0x76543210` and systematically extracts each nibble using masks and shifts, then repositions them in reverse order to create `0x01234567`. Demonstrates complex bit manipulation techniques, nibble extraction/insertion, and bit field operations - useful for understanding endianness conversion and data format transformations.


## MIPS Optimized Nibble Reversal v2
MIPS assembly program that efficiently reverses the order of nibbles in a 32-bit word, transforming `0x76543210` to `0x01234567`. Uses a streamlined approach with fewer register clears compared to the previous version, combining immediate masks (ANDI) and constructed masks (LUI) to extract each nibble, then repositions them through shifts and OR operations. Demonstrates optimized bit manipulation and efficient nibble swapping techniques.