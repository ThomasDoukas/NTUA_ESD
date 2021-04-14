.text
.align 4 

.global _strlen
.type _strlen, %function

_strlen:
    @Input string at r0
    push {r1-r3}
    mov r2, #0 @r2: Counter - String length

start__strlen:
    ldrb r3, [r0, r2] @Load string character
    cmp r3, #0 @Check if NULL (ASCII 0) - end of string
    addne r2, r2, #1 @Add 1 to the string lenght
    bne start__strlen @Continue to the next offset

end__strlen:
    mov r0, r2 @Result to r0
    pop {r1-r3}
    bx lr


.global _strcpy
.type _strcpy, %function

_strcpy:
    @Copying string from r1 to r0 (MUST ALSO COPY NULL AT THE END), returns copied string
    push {r2-r4}
    mov r2, #0 @r2: character offset

start__strcpy:
    ldrb r3, [r1, r2] @Take byte of source string r1 (at offset r2)
    cmp r3, #0  @Check if it is NULL character - end of string
    beq end__strcpy
    strb r3, [r0, r2] @Copy the selected byte to destination r0
    add r2, r2, #1 @Increment character offset
    b start__strcpy @Continue to the next offset

end__strcpy:
    strb r3, [r0, r2] @Copy NULL at the end of string, now r0 contains copied string
    pop {r2-r4}
    bx lr


.global _strcat
.type _strcat, %function

_strcat:
    @Destination string at r0, source string at r1
    push {r2-r4}
    mov r2, #0 @r2: 1st counter to find destination length
start__strcat:
    @Find end of destination
    ldrb r3, [r0, r2] @Load destination character
    cmp r3, #0 @And check if its NULL (ASCII 0) - end of string
    addne r2, r2, #1
    bne start__strcat @And continue to the next offset

    @Copy part
    mov r4, #0 @Second counter to use on source offset string
cont__strcat:
    ldrb r3, [r1, r4] @Load character of source string
    cmp r3, #0 @Check if it is NULL character - end of string
    beq end__strcat
    strb r3, [r0, r2] @r2 represents the current end of destination string
    add r4, r4, #1 @Increment both counters
    add r2, r2, #1
    b cont__strcat

end__strcat:
    strb r3, [r0, r2] @Copy NULL at the end of the destination string
    pop {r2-r4} @Result to r0
    bx lr


.global _strcmp
.type _strcmp, %function

_strcmp:
    @r0: str_1
    @r1: str_2
    @return value is placed on r0 and its referenced to str1 
    @(calculates the difference between the 1st unmatched character of the 2 strings)
    push {r2-r5}
    mov r2, #0 @r2: counter

start__strcmp:
    ldrb r3, [r0, r2] @Load character at offset r2 from both strings
    ldrb r4, [r1, r2]
    cmp r3, r4
    bne calc_diff
    cmp r4, #0
    addne r2, r2, #1  @ beq calc_diff @ add r2, r2, #1
    bne start__strcmp  @ b start__strcmp <-- A better implementation

calc_diff:
    sub r0, r3, r4 @Return value is calculated 

end__strcmp:
    pop {r2-r5} @Result to r0 (r0 < 0 => str1<str2, r0>0 => str1>str2, r0=0 => str1=str2)
    bx lr
