## MIPS Constant Builder (0xDEADBEEF) Example 1
MIPS assembly program that constructs the 32-bit hex constant `0xDEADBEEF` by systematically building it piece-by-piece using immediate loads, bit shifts, and OR operations. Demonstrates technique for creating large constants that exceed MIPS immediate instruction encoding limits.


## MIPS Efficient Constant Builder (0xDEADBEEF) Example 2
MIPS assembly program that constructs the 32-bit hex constant `0xDEADBEEF` using an optimized 3-instruction approach. Loads the upper 16 bits (`0xDEAD`), shifts left to make room, then ORs in the lower 16 bits (`0xBEEF`). Demonstrates the most efficient method for building large constants in MIPS when both halves fit within immediate instruction limits.
