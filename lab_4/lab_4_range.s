.text
.global _start
.extern scanf

_start:
    
    ADR   X0, fmt_str   // Load address of formated string
    ADR   X1, left      // Load &left
    ADR   X2, right     // Load &right
    ADR   X3, target    // Load &target
    BL    scanf         // scanf("%ld %ld %ld", &left, &right, &target);

    ADR   X1, left      // Load &left
    LDR   X1, [X1]      // Store left in X1
    ADR   X2, right     // Load &right
    LDR   X2, [X2]      // Store right in X2
    ADR   X3, target    // Load &target
    LDR   X3, [X3]      // Store target in X3

    /* Your code here */

    CMP   X3, X1        //compare X3 and X1
    b.le  not           //if(X3 < X1){ goto not; }

    CMP   X3, X2        //compare X3 and X2
    b.ge  not           //if(X3 > X2){ goto not; }

    MOV   X0, 1       //Destination for printing to screen
    ADR   X1, yes     //Load address yes to X1
    ADR   X3, len_yes //Assign address len_yes to X3
    LDR   X2, [X3]    //Assign len_yes string to X2
    MOV   X8, 64      //Assign syscall 64 to X8
    SVC   0           //Syscall

    B exit
    

not:
    MOV   X0, 1       //Destination for printing to screen
    ADR   X1, no      //Load address no to X1
    ADR   X3, len_no  //Assign address len_no to X3
    LDR   X2, [X3]    //Assign len_no string to X2
    MOV   X8, 64      //Assign syscall 64 to X8
    SVC   0           //Syscall

    B exit

exit:
    MOV   X0, 0        // Pass 0 to exit()
    MOV   X8, 93       // Move syscall number 93 (exit) to X8
    SVC   0            // Invoke syscall

.data
    left:    .quad     0
    right:   .quad     0
    target:  .quad     0
    fmt_str: .string   "%ld%ld%ld"
    yes:     .string   "Target is in range\n"
    len_yes: .quad     . - yes  // Calculate the length of string yes
    no:      .string   "Target is not in range\n"
    len_no:  .quad     . - no   // Calculate the length of string no
