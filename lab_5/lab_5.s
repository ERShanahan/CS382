.text
.global _start
.extern printf


/* char _uppercase(char lower) */
_uppercase:
    SUB W0, W0, 32          //Subtract 32 from the ascii code
    RET                     //Return to Stored pc value

/* int _toupper(char* string) */
_toupper:

    SUB sp, sp, 8           //allocate 8 bytes to stack
    STR X30, [sp]           //store pc to stack

    MOV X9, X0              //X9 = addr of string
    MOV X8, 0               //X8 = 0
    MOV X16, 0              //X16 = 0

    loop:
        LDRB W0, [X9, X8]   //W0 = string.charat(X8)
        CBZ W0, END         //if(W0 == 0) { goto END }
        CMP W0, 90          //Compare W0 and 90 (ascii code of 'Z' = 90)
        B.le upper          //if(W0 < 90) { goto upper }
        BL _uppercase       //call _uppercase(W0)
        STRB W0, [X9, X8]   //string.charat(X8) = W0
        ADD X16, X16, 1     //X16++
        upper:
        ADD X8, X8, 1       //X8++
        B loop              //goto loop

    END:
        MOV X0, X16         //X0 = X16
        LDR X30, [sp]       //Load pc from stack
        ADD sp, sp, 8       //deallocate stack
        RET                 //return to stored pc value

_start:

    ADR X0, str             //X0 = addr of string
    BL _toupper             //call _toupper(X0)

    MOV X1, X0              //X1 = X0 (number of characters alterd)
    ADR X0, outstr          //X0 = addr of formatted string
    ADR X2, str             //X2 = addr of uppercase string
    BL printf               //call printf(X0, X1, X2)

    MOV  X0, 0
    MOV  X8, 93
    SVC  0


.data
    str:    .string   "helloworld"
    outstr: .string   "Converted %ld characters: %s\n"
