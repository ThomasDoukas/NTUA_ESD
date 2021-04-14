.text
.global main

main:
    @Print start message
    mov r0, #1 @std_out
    ldr r1, =msg_start
    ldr r2, =msg_start_len
    mov r7, #4 @write syscall
    swi 0

    @Read data from user
    mov r0, #0 @std_in
    ldr r1, =buffer
    mov r2, #33
    mov r7, #3 @read syscall
    swi 0

    @Read syscall returns number of bytes read in r0
    mov r4, r0 
    mov r6, r0 @r4,r6 = chars user entered
    mov r8, #0 @flag (1 = last user char is \n)

    cmp r4, #33 @If user input is 32 chars make sure that pos 33 is \n
    bne clean_buf

    mov r5, #10 @End line
    ldrb r3, [r1, #32]
    cmp r5, r3
    moveq r8, #1 @Last char was already \n
    beq cont
    strb r5, [r1, #32] @Otherwise store \n to last buffer position
    b cont @No need to check for q or Q bc input=33chars
    
clean_buf:
    @Add \0 to erase older trash stored in buffer
    mov r5, #0
    cmp r4, #33
    beq check
    strb r5, [r1, r4]
    add r4, r4, #1
    b clean_buf

check:
    @Check for quiting
    cmp r0, #2  
    bne cont   @If 2 chars are read => check for q, Q
    ldrb r0, [r1] @Read 1st character from buffer
    @Quit case: q
    cmp r0, #113
    beq end
    @Quit case: Q
    cmp r0, #81 
    beq end

cont:
    @String transformation
    bl transformation

    @Print result message
    mov r0, #1 @std_out
    ldr r1, =msg_result
    ldr r2, =msg_result_len
    mov r7, #4 @write syscall
    swi 0

    @Print result
    mov r0, #1 @std_out
    ldr r1, =buffer
    mov r2, #33
    mov r7, #4 @write syscall
    swi 0

clean_input:
    cmp r6, #33 @No need to clean input if user entered 32 chars 
    blo main

    cmp r8, #1 @If last char was already a \n stdin is empty
    beq main

read_stdin:
    @Repeatedly read until std_in is empty
    mov r0, #0 @std_in
    ldr r1, =buffer
    mov r2, #33
    mov r7, #3 @read syscall
    swi 0
    
    cmp r0, #33 @If read_chars < 33 stdin is empty
    blo main
    b read_stdin

end:
    @Print result
    mov r0, #1 @std_out
    ldr r1, =msg_quit
    ldr r2, =msg_quit_len
    mov r7, #4 @write syscall
    swi 0

    @Exit with status code 0
    mov r0, #0 
    mov r7, #1
    swi 0

transformation:
    push {r1-r6}
    mov r2, #0 @counter/byte offset
start:
    cmp r2, r6 @Change #input_chars
    beq exit
    ldrb r3,[r1,r2]

    cmp r3, #48 @ <0
    blo next_iteration
    
number:
    cmp r3, #57
    bgt check_letter
    @Number Transform 
    cmp r3, #53 @If number is 5
    subge r3, r3, #5 @ 56789 -> 01234
    addlo r3, r3, #5 @ 01234 -> 56789
    strb r3, [r1, r2]
    add r2,r2, #1 @next iteration
    b start

check_letter:
    cmp r3, #65
    blo next_iteration    

uppercase_letter:
    cmp r3, #90
    bgt lowercase_letter
    @Uppercase tsanformation
    add r3, r3, #32
    strb r3, [r1, r2]
    add r2,r2, #1
    b start

lowercase_letter:
    cmp r3, #97
    blo next_iteration
    cmp r3, #122
    bgt next_iteration
    @Lowercase transformation
    sub r3, r3, #32
    strb r3, [r1, r2]
    add r2,r2, #1
    b start

next_iteration:
    add r2, r2, #1
    b start

exit:
    pop {r1-r6}
    bx lr



.data

msg_start:
    .ascii "Please enter string up to 32 chars long: "
msg_start_len = .-msg_start

msg_result:
    .ascii "Result is: "
msg_result_len = .-msg_result

msg_quit:
    .ascii "Quiting...\n"
msg_quit_len = .-msg_quit

buffer:
    .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"

