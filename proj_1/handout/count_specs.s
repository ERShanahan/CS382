
/*  Name: Ethan Shanahan
    Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

.global count_specs

count_specs:

    sub sp, sp, 16
    str x30, [sp]
    str x0, [sp, 8]
    mov x2, 0
    mov x3, 1
    mov x4, 0
    mov x5, 37
    mov x6, 97

    count_specs_loop:

        ldr x0, [sp, 8]
        ldrb w1, [x0, x3]
        cbz w1, end_count_specs_loop
        ldrb w0, [x0, x2]
        cbz w0, end_count_specs_loop
        

        cmp x0, x5
        b.eq percent_found
        b percent_not_found

        percent_found:

            cmp x1, x6
            b.eq a_found
            b a_not_found

            a_found:
            
            add x4, x4, 1

            a_not_found:

        percent_not_found:

        add x2, x2, 1
        add x3, x3, 1

        b count_specs_loop

    end_count_specs_loop:

    mov x0, x4

    ldr x30, [sp]
    add sp, sp, 16
    ret

