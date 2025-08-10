    .text
    .globl main
main:
    # Set bit 1 in register $1 (bit 1 is the second bit, corresponding to 0x2)
    ori $1, $0, 0x2      # Set register $1 to 0x2 (binary: 0000000000000010)

    # Set bit 2 in register $2 (bit 2 is the third bit, corresponding to 0x4)
    ori $2, $0, 0x4      # Set register $2 to 0x4 (binary: 0000000000000100)

    # Set bit 3 in register $3 (bit 3 is the fourth bit, corresponding to 0x8)
    ori $3, $0, 0x8      # Set register $3 to 0x8 (binary: 0000000000001000)

    # Set bit 4 in register $4 (bit 4 is the fifth bit, corresponding to 0x10)
    ori $4, $0, 0x10     # Set register $4 to 0x10 (binary: 0000000000010000)

    # Set bit 5 in register $5 (bit 5 is the sixth bit, corresponding to 0x20)
    ori $5, $0, 0x20     # Set register $5 to 0x20 (binary: 0000000000100000)

    # Set bit 6 in register $6 (bit 6 is the seventh bit, corresponding to 0x40)
    ori $6, $0, 0x40     # Set register $6 to 0x40 (binary: 0000000001000000)

    # Set bit 7 in register $7 (bit 7 is the eighth bit, corresponding to 0x80)
    ori $7, $0, 0x80     # Set register $7 to 0x80 (binary: 0000000010000000)