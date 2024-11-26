
/*  Name: Ethan Shanahan
    Pledge: I plegde my honor that I have abided by the Stevens Honor System.
 */

/*

    PLEASE GRADE FOR EXTRA CREDIT

 */

.global pringle

pringle:
    
    sub sp, sp, 72
    str x7, [sp, 64]
    str x6, [sp, 56]
    str x5, [sp, 48]
    str x4, [sp, 40]
    str x3, [sp, 32]
    str x2, [sp, 24]
    str x1, [sp, 16]
    str x0, [sp, 8]
    str x30, [sp]

    
    adr x8, output_string       //stores address of output string

    mov x9, 0       //to iterate through the formatted string
    mov x10, 1      //to iterate through the next char of formatted string
    mov x16, 0      //to place chars into output string
    mov x17, 16     //to iterate through the parameters (starting at x1 (sp, 16))

    pringle_add_loop:

        ldr x0, [sp, 8]                         //make sure that x0 is the address of formatted string
        ldrb w11, [x0, x9]                      //load char from formatted string
        cbz w11, pringle_add_loop_end           //check if this char is null
        ldrb w12, [x0, x10]                     //load next char from formatted string
        cbz w12, pringle_percent_not_found      //check if this char is null (iterate once more)

        cmp w11, 37                 //compare first char with %
        b.eq pringle_percent_found
        b pringle_percent_not_found

        pringle_percent_found:

            cmp w12, 97        //compare next char with a
            b.eq pringle_a_found
            b pringle_a_not_found

            pringle_a_found:

                ldr x0, [sp, x17]       //load address of array from stack
                add x17, x17, 8         //go to the next register on stack
                ldr x1, [sp, x17]       //load length of array from stack
                add x17, x17, 8         //go to the next register on stack
                bl concat_array         //call concat_array

                mov x13, 0      //to iterate through string from concat_array
                concat_copy_loop:

                    ldrb w11, [x0, x13]             //load char from string from concat_array
                    cbz w11, concat_copy_loop_end   //if null, end loop

                    strb w11, [x8, x16]     //store char in output string

                    add x16, x16, 1       //to store char in right spot in output string
                    add x13, x13, 1       //increment to get next char
                    
                    b concat_copy_loop      //loop

                concat_copy_loop_end:

                b added_array       //we added array, so no need to add a character from
                                    //formatted string, goto added_array
            pringle_a_not_found:

        pringle_percent_not_found:

        strb w11, [x8, x16]     //store character from formatted string in output string

        add x9, x9, 1       //increment to get next char from formatted string
        add x10, x10, 1     //increment to get next next char from formatted string
        add x16, x16, 1     //increment to keep track of where to place char in output string

        b pringle_add_loop      //loop

        added_array:

        add x9, x9, 2       //increment to get next char from formatted string
        add x10, x10, 2     //increment to get next next char from formatted string

        b pringle_add_loop      //loop

    pringle_add_loop_end:

    mov x0, 1
    adr x1, output_string
    mov x2, x16
    mov x8, 64
    svc 0

    mov x0, x16     //to return length of printed string

    ldr x30, [sp]
    add sp, sp, 72
    ret



/*
    Declare .data here if you need.
*/
.data
    output_string: .fill 1024, 1, 0


