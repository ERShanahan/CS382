/***********************************************************
 * Filename: lab_3.s
 * Author  : Ethan Shanahan
 * Version : 1.0
 * Date    : Sep 28 2023
 * Description: Dot Product
 * Pledge  : I pledge my honor that I have abided by the Stevens Honor System.
***********************************************************/

.data
    vec1:   .quad   10, 20, 30      //Vector1 = {10, 20, 30};
    vec2:   .quad   1,  2,  3       //Vector2 = {1, 2, 3};
    dot:    .quad   0               //dot = 0;

.text
.global _start                      //label for start of program

_start:

    ADR X0, vec1                    //X0 = base address of vec1
    ADR X1, vec2                    //X1 = base address of vec2
    ADR X2, dot                     //X2 = base address of dot

    LDR X4, [X0]                    //X4 = *(vec1 + 0);
    ADD X0, X0, 8                   //X0 += 8;
    LDR X5, [X0]                    //X5 = *(vec1 + 8);
    ADD X0, X0, 8                   //X0 += 8;
    LDR X6, [X0]                    //X6 = *(vec1 + 16);

    LDR X7, [X1]                    //X7 = *(vec2 + 0);
    ADD X1, X1, 8                   //X1 += 8;
    LDR X8, [X1]                    //X8 = *(vec2 + 8);
    ADD X1, X1, 8                   //X1 += 8;
    LDR X9, [X1]                    //X9 = *(vec2 + 16);

    MUL X11, X4, X7                 //X11 = X4 * X7;

    MUL X10, X5, X8                 //X10 = X5 * X8;
    ADD X12, X11, X10               //X12 = X11 + X10;

    MUL X10, X6, X9                 //X10 = X6 * X9;
    ADD X11, X12, X10               //X11 = X12 + X10;

    STR X11, [X2]                   //*(dot) = X11;

    MOV X0, 0                       //X0 = 0;
    MOV X8, 93                      //X8 = 93;
    SVC 0                           //Syscall terminate

