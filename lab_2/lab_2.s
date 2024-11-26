/***********************************************************
 * Filename: lab_2.s
 * Author  : Ethan Shanahan
 * Version : 1.0
 * Date    : Sep 19 2023
 * Description: Hello World assembly program
 * Pledge  : I pledge my honor that I have abided by the Stevens Honor System.
***********************************************************/

.text               //Begin Program
.global _start      //Create Start label

_start:             //Main Function

    MOV X0, 1       //Destination for printing to screen
    ADR X1, msg     //Load address msg to X1
    ADR X3, len     //Assign address len to X3
    LDR X2, [X3]    //Assign len string to X2
    MOV X8, 64      //Assign syscall 64 to X8
    SVC 0           //Syscall

    MOV X0, 0       //Assign immediate 0 to X0
    MOV X8, 93      //Assign System call 93 to X8
    SVC 0           //Syscall

.data               //Storage of Data in RAM
    msg: .string "Hello World!\n"       //Assign address msg to string
    len: .quad . - msg                  //Assign address len to length of string
