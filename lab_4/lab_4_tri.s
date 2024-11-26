.text
.global _start

_start:

    ADR   X4, side_a    //X4 = address side_a
    ADR   X5, side_b    //X5 = address side_b
    ADR   X6, side_c    //X6 = address side_c
    LDR   X4, [X4]      //X4 = 3
    LDR   X5, [X5]      //X5 = 4
    LDR   X6, [X6]      //X6 = 5

    MUL   X4, X4, X4    //X4 = X4 * X4
    MUL   X5, X5, X5    //X5 = X5 * X5
    MUL   X6, X6, X6    //X6 = X6 * X6

    ADD   X5, X4, X5    //X5 = X5 + X4

    SUB   X4, X6, X5    //X4 = X6 - X5

    CBZ   X4, right     //if(X4 == 0){ goto right; }

    MOV   X0, 1       //Destination for printing to screen
    ADR   X1, no      //Load address no to X1
    ADR   X3, len_no  //Assign address len_no to X3
    LDR   X2, [X3]    //Assign len_no string to X2
    MOV   X8, 64      //Assign syscall 64 to X8
    SVC   0           //Syscall

    B exit            //goto exit;

right:

    MOV   X0, 1       //Destination for printing to screen
    ADR   X1, yes     //Load address yes to X1
    ADR   X3, len_yes //Assign address len_yes to X3
    LDR   X2, [X3]    //Assign len_yes string to X2
    MOV   X8, 64      //Assign syscall 64 to X8
    SVC   0           //Syscall

    B exit            //goto exit;

exit:
    MOV   X0, 0        // Pass 0 to exit()
    MOV   X8, 93       // Move syscall number 93 (exit) to X8
    SVC   0            // Invoke syscall

.data
    side_a: .quad 3
    side_b: .quad 4
    side_c: .quad 6
    yes: .string "It is a right triangle.\n"
    len_yes: .quad . - yes // Calculate the length of string yes
    no: .string "It is not a right triangle.\n"
    len_no: .quad . - no // Calculate the length of string no
