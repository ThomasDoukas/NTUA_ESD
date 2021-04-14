.text
.global main
.extern tcsetattr
.extern printf

main:
    @Open serial port
    ldr r0, =serial_port
    mov r1, #2 @ReadWrite
    ldr r2, =0666
    mov r7, #5 @open sys call
    swi 0

    @Check open for errors
    cmp r0, #0
    bmi end
    @Save fd from r0
    mov r5, r0

    @Setting up termio
    @r0 has file descriptor
    mov r1, #0 @TCSANOW
    ldr r2, =options
    bl tcsetattr

    @Read all chars from serial port - 64Worst case
    mov r0, r5 @Fd
    ldr r1, =buffer
    mov r2, #64
    mov r7, #3 @read syscall
    swi 0
    @Number of chars read on r0

    bl freq_calculate

    @Write results to the serial port
    mov r0, r5 @Fd
    ldr r1, =result
    ldr r2, =len_result
    mov r7, #4 @write syscall
    swi 0

    @Close the serial port
    mov r0, r5 @Fd
    mov r7, #6 @close syscall
    swi 0

end:
    @Exit with status code 0
    mov r0, #0 
    mov r7, #1 
    swi 0

freq_calculate:
    push {r1-r6}
    @r1 = buffer
    mov r2, #0 @Counter
    @r3 = current load-store
    ldr r4, =freq_arr

start:
    cmp r2, #64 @When counter reaches the end of freq_arr stop iterating 
    beq cont    @This is for the special case where the user enters 64 characters + \n

    ldrb r3, [r1, r2]
    cmp r3, #10 @If we find \n frequency culculator is ended
    beq cont

    cmp r3, #32 @Do not count space character's frequency
    addeq r2, r2, #1 @ Increase coutner
    beq start

    sub r3, r3, #33 @Calculate offset in frequency array
    ldrb r5, [r4, r3] @Load frequency of input char from frequrency array
    add r5, r5, #1 @Increment frequency by 1
    strb r5, [r4, r3] @Offset is already calculated
    add r2, r2, #1 @ Increase coutner
    b start

cont:
    mov r2, #0 @Initialize counter
    mov r5, #0 @Use r5 for max_freq
    mov r6, #0 @Position of max frequency in freq_arr

max_freq_loop:
    cmp r2, #94 @Last possition of freq_arr (freq_arr length = 94Bytes - 1 For each possible input)
    beq finalize
    ldrb r3, [r4, r2] @Get frequency of r2 cell in freq_arr.
    cmp r3, r5  @If new_freq(r3) > max_freq (r5)
    movgt r5, r3 
    movgt r6, r2 @Save new_max_freq, character's offset in freq_arr
    add r2, r2, #1 @Increase counter
    b max_freq_loop

finalize:

    @Save results in variable results
    @r4 has result array address
    ldr r4, =result
    add r6, r6, #33 @Most frequent character
    strb r6, [r4]
    sub r5, r5, #48
    strb r5, [r4, #2] @Frequency of most frequent character

exit:
    pop {r1-r6}
    bx lr


.data

options:    
    .word 0x00000000 /* c_iflag */
    .word 0x00000000 /* c_oflag */
    .word 0x000008b0 /* c_cflag */
    .word 0x00000000 /* c_lflag */
    .byte 0x00       /* c_line */
    .word 0x00000000 /* c_cc[0-3] */
    .word 0x000a0000 /* c_cc[4-7] */
    .word 0x00000000 /* c_cc[8-11] */
    .word 0x00000000 /* c_cc[12-15] */
    .word 0x00000000 /* c_cc[16-19] */
    .word 0x00000000 /* c_cc[20-23] */
    .word 0x00000000 /* c_cc[24-27] */
    .word 0x00000000 /* c_cc[28-31] */
    .byte 0x00       /* padding */
    .hword 0x0000    /* padding */
    .word 0x0000000d /* c_ispeed */
    .word 0x0000000d /* c_ospeed */

serial_port:
    .ascii "/dev/ttyAMA0" @Guest serial port as shown in dmesg | grep tty


buffer: 
    .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
len_buffer = . - buffer

freq_arr:
    .ascii "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
@need 1byte for 94 possible characters
result: 
    .ascii "c\0f"
len_result = . - result

test:
    .ascii "MALAKIES\n"
