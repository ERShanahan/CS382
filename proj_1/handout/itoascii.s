
/*  
    Name: Ethan Shanahan
    Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

.global itoascii


itoascii:
   sub sp, sp, 56
   str x30, [sp]
   str x20, [sp, 8]
   str x21, [sp, 16]
   str x22, [sp, 24]
   str x23, [sp, 32]
   str x24, [sp, 40]
   str x25, [sp, 48]

   mov x21, x0     //x21 = long unsigned int
   adr x0, buffer    //x0 = address of buffer
   adr x20, temp
   mov x22, 10     //x22 = 10 (for dividing by 10)
   mov x23, 0      //x23 = 0 (for counting iterations)

   itoascii_loop:

      cbz x21, itoascii_loopEnd      //if(x21 == 0){ end loop }

      mov x24, x21      //x24 = x21 (long unsigned int)
      sdiv x24, x21, x22          
      mul x25, x24, x22
      sub x21, x21, x25
      add x21, x21, 48    //x21 = x21 + 48 (string rep of digit from long unsigned int)
      strb w21, [x20, x23]    //store character byte in buffer, mov to next pos
      mov x21, x24
      add x23, x23, 1     //increment digit counter

      b itoascii_loop

   itoascii_loopEnd:

   cbz x23, no_digits

   mov x24, 0
   mov x25, x23
   sub x25, x25, 1

   itoascii_copy_loop:

      ldrb w21, [x20, x24]
      strb w21, [x0, x25]

      cbz x25, itoascii_copy_loop_end

      add x24, x24, 1
      sub x25, x25, 1

      b itoascii_copy_loop
   
   itoascii_copy_loop_end:

   mov x21, 0
   strb w21, [x0, x23]

   b itoascii_end

   no_digits:

   mov x21, 48
   strb w21, [x0]
   mov x21, 0
   strb w21, [x0, 1]

   itoascii_end:

   ldr x30, [sp]
   ldr x20, [sp, 8]
   ldr x21, [sp, 16]
   ldr x22, [sp, 24]
   ldr x23, [sp, 32]
   ldr x24, [sp, 40]
   ldr x25, [sp, 48]
   add sp, sp, 56
   ret

.data
    /* Put the converted string into buffer,
       and return the address of buffer */
    buffer: .fill 128, 1, 0
    temp: .fill 128, 1, 0


