/**
 * Name: Ethan Shanahan
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System.
*/

.text
.global _start

_start:

    adr x0, src_str
    adr x1, dst_str

    mov x2, 0   //x2 = 0

    loop:

        ldrb w3, [x0, x2]   //load character at index x2 into w3
        strb w3, [x1, x2]   //store character at w3 into index x2 in dst_str
        add x2, x2, 1       //iterate
        cbz w3, end         //if w3 was null, end
        b loop
    
    end:

    mov x0, 1
    mov x8, 64              //print command
    svc 0

    mov x0, 0
    mov x8, 93
    svc 0

