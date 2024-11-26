/**
 * Name:
 * Pledge:
 */

.text
.global _start

_start:

    adr x0, numstr

    mov x1, 0
    calcLen:
        ldrb w2, [x0, x1]
        cbz w2, done
        add x1, x1, 1
        b calcLen
    done:
    mov x15, x1 //x15 = x10 (len of numstr)
    sub x15, x15, 1 //convert to indexes for use

    mov w16, 10
    mov x10, 0
    mov x1, 0
    mov x2, 0
    loop:
        ldrb w2, [x0, x1]
        cbz w2, end
        sub w2, w2, 48
        mov x6, x15
        innerLoop:
            cbz x6, innerEnd
            mul w2, w2, w16
            sub x6, x6, 1
            b innerLoop
        innerEnd:
        add x10, x10, x2
        sub x15, x15, 1
        add x1, x1, 1
        b loop
    end:
    adr x0, number
    str x10, [x0]


/* Do not change any part of the following code */
exit:
    MOV  X0, 1
    ADR  X1, number
    MOV  X2, 8
    MOV  X8, 64
    SVC  0
    MOV  X0, 0
    MOV  X8, 93
    SVC  0
    /* End of the code. */







