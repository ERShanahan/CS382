
/*  Name: Ethan Shanahan
    Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

.global concat_array

concat_array:
   sub sp, sp, 64
   str x30, [sp]
   str x0, [sp, 8]
   str x23, [sp, 16]
   str x25, [sp, 24]
   str x26, [sp, 32]
   str x27, [sp, 40]
   str x28, [sp, 48]
   str x29, [sp, 56]
   

   adr x26, concat_array_outstr   //x26 = address of output string
   mov x27, 32  //ascii value for space
   mov x25, 0   
   mov x29, 0   //init counter
   

   loop:

      cbz x1, end    //if(x1 == 0){end loop} (x1 stores len of arr)
      ldr x0, [x0, x29]     //x0 = long unsigned int at arr[x29]
      bl itoascii    //call itoascii(x0)

      mov x28, 0      //init counter
      mov x23, x0

      innerLoop:

         ldrb w0, [x23, x28]      //x0 = byte from string rep of long unsigned int (first char)
         cbz w0, endInnerLoop    //if(null terminator){end loop}
         strb w0, [x26, x25]     //store char from string rep of long unsigned int in output string
         add x28, x28, 1     //increment inner counter
         add x25, x25, 1
         b innerLoop    //continue loop

      endInnerLoop:

      strb w27, [x26, x25]    //place space after digits

      ldr x0, [sp, 8]   //load the nuked value of x0 (address of arr)
      add x25, x25, 1     //increment counter
      add x29, x29, 8
      sub x1, x1, 1     //decrement len
      b loop            //continue loop

   end:

   mov x0, 0
   strb w0, [x26, x25]

   mov x0, x26

   ldr x30, [sp]
   ldr x23, [sp, 16]
   ldr x25, [sp, 24]
   ldr x26, [sp, 32]
   ldr x27, [sp, 40]
   ldr x28, [sp, 48]
   ldr x29, [sp, 56]
   add sp, sp, 64
   ret


.data
    /* Put the converted string into concat_array_outstrer,
       and return the address of concat_array_outstr */
   concat_array_outstr:  .fill 1024, 1, 0

