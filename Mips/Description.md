## MIPS Bit Position Eaxmple 2
MIPS assembly program that demonstrates individual bit positioning by loading powers of 2 into sequential registers. Each register contains a single set bit: $1=0x2 (bit 1), $2=0x4 (bit 2), $3=0x8 (bit 3), etc. up to $7=0x80 (bit 7). Educational example showing the relationship between bit positions and their corresponding hexadecimal values.


## MIPS Bitwise Operations Example 3
MIPS assembly program that demonstrates fundamental bitwise operations using the bit pattern `0x55555555` (alternating 0s and 1s). Constructs the pattern by combining `0x5555` in upper and lower 16-bit halves, then performs OR, AND, and XOR operations with shifted versions. Shows how bitwise operations manipulate alternating bit patterns - useful for understanding Boolean logic and bit manipulation techniques.


## MIPS Nibble Manipulation Example 4
MIPS assembly program that demonstrates nibble (4-bit) extraction and rearrangement using the hex value `0xFACE`. Extracts individual nibbles using AND masks (`0xF000`, `0x00F0`, `0x0F0F`), repositions them with bit shifts, then recombines using OR operations. Shows fundamental techniques for manipulating specific bit groups within a word - essential for bit field operations and data packing/unpacking.


## MIPS Bitwise NOT Operation Example 5
MIPS assembly program that constructs the 32-bit value `0x76543210`, extracts the lowest byte (0x10), and demonstrates bitwise NOT operation using NOR. Builds the constant efficiently with shift-and-OR, then uses `nor $2, $2, $0` to invert the extracted byte (since NOR with zero equals bitwise NOT). Shows practical bit manipulation and demonstrates NOR as a universal logic gate for implementing NOT operations.


## MIPS Instruction Encoding Building the ori instruction (ori_assembled)
MIPS assembly program that manually constructs a 32-bit MIPS instruction by building each field separately. Assembles opcode 0xD at bits 31-26, register field 0x9 at bits 25-21, value 0x8 at bits 20-16, and immediate 0x004A at bits 15-0. Demonstrates how MIPS instruction formats work by showing the bit-level construction of machine code - educational example of instruction encoding and processor architecture fundamentals.