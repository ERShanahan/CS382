/**
 * Name: Ethan Shanahan
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System.
*/


.text
.global _start

_start:

    adr x0, length          //x0 = adr of length
    ldr x0, [x0]            //x0 = load length value into x0
    mov x8, 0               //x8 = 0 (left index)
    mov x9, x0              //x9 = length
    sub x9, x9, 1           //x9 = right most index

    adr x1, target          //x1 = adr of target
    ldr x1, [x1]            //x1 = target value

    adr x3, arr             //x3 = base adr of arr
    
    loop:

        cmp x9, x8          //compare right index with left index
        b.lt notTarget      //if they are equal, no more room to search, target not found

        add x10, x9, x8     //x10 = x9 + x8
        lsr x4, x10, 1      //x4 = (x9 + x8) / 2

        lsl x7, x4, 3       //x7 = x4 * 8
        ldr x5, [x3, x7]    //x5 = arr[x4*8]

        cmp x5, x1          //compare arr[x4*8] with target
        b.eq found          //if equal, found target
        b.lt greater        //if less than, target is greater than
        b.gt less           //if greater than, target is less than

        less:
            sub x4, x4, 1   //x4--
            mov x9, x4      //set right most index to middle index
            b loop
        greater:
            add x4, x4, 1   //x4++
            mov x8, x4      //set left most index to middle index
            b loop

    found:

    //print Target found message
    adr x1, msg1
    mov x2, 24
    mov x0, 1
    mov x8, 64
    svc 0
    b end

    notTarget:

    //print Targer not found message
    adr x1, msg2
    mov x2, 28
    mov x0, 1
    mov x8, 64
    svc 0

    end:

    mov x0, 0
    mov x8, 93
    svc 0
