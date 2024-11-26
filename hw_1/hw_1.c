/***********************************************************
 * Filename: hw_1.c
 * Author  : Ethan Shanahan
 * Version : 1.0
 * Date    : Sep 20 2023
 * Description: Copy String, compute dot product, in-place sort nibbles of integers
 * Pledge  : I pledge my honor that I have abided by the Stevens Honor System.
***********************************************************/

#include <stdio.h>

//Copies string from src to dst
void copy_str(char* src, char* dst) {

    //Init iterator var
    int i = 0;
    L:
        //Check if String null operator has been reached
        if(src[i] == '\0'){
            //Include null operator in dst
            dst[i] = src[i];
            return;
        }
        //Copy char from src to dst
        dst[i] = src[i];
        //iterate
        i++;
    //repeat
    goto L;
}

//Calculate dot product of vec_a and vec_b, both of size length
//contains values of size_elem
int dot_prod(char* vec_a, char* vec_b, int length, int size_elem) {
    /* Your code here
    Do not cast the vectors directly, such as
    int* va = (int*)vec_a;
    */
    
    //Init iterator var
    int i = 0;
    //Init sum var
    int sum = 0;
    //Init space for storing loaded values of vec_a and vec_b respectively
    int va, vb;
    L:
        //Check if reached end length, then simply return sum
        if(i == length){
            return sum;
        }
        //Load value of vec_a[i] to va
        va = *((int*)(vec_a + i*size_elem));
        //Load value of vec_b[i] to vb
        vb = *((int*)(vec_b + i*size_elem));
        //add the product of va and vb
        sum += va*vb;
        //iterate
        i++;
    //repeat
    goto L;
}

void insertionSort(char* nibs, int l){
    //Init iterator vars
    int i = 0;
    int j = 0;
    //Init temp var
    char c;
    L1:
        //if reach end of char array
        if(i == l){goto E1;}
        //Store nibs[i]
        c = nibs[i];
        //Setup iterator for inner loop
        j = i - 1;
        L2:
            //Continue to insert sort until i < 0 or up to c sorted
            if(i < 0 || nibs[j] <= c){goto E2;}
            //Backwards swap values
            nibs[j+1] = nibs[j];
            //decrement iterator var
            j -= 1;
            //repeat
            goto L2;
        E2:
        //add c into correct position
        nibs[j+1] = c;
        //increment iterator var
        i++;
        //repeat
        goto L1;
    E1:
}

void sort_nib(int* arr, int length) {
    //Init iterator vars
    int i = 0;
    int j = 0;
    //Init nibs array to store digits of nibbles
    char nibs[length*8];

    L1:
        //End outer loop if looped length num of times
        if(i == length){goto E1;}
        //Set j to 0
        j = 0;
        L2:
            //End inner loop when reached 8 iterations
            if(j == 8){goto E2;}
            //assign the first nibble of arr[i], bitshifted by j*4, to the next
            //pos in the nibs array
            nibs[j+(i*8)] = ((*(arr + i) >> (j*4)) & 0xF);
            //increment iterator
            j++;
            //repeat
            goto L2;
        E2:
        //increment iterator
        i++;
        //repeat
        goto L1;
    E1:
    
    //Sort chars in nibs array
    insertionSort(nibs, length*8);

    //Set i to 0
    i = 0;
    L3:
        //End outer loop if looped length num of times
        if(i == length){goto E3;}
        //Set j to 0
        j = 0;
        //Setup 4-bytes of zeroes to append nibbles
        int num = 0;
        L4:
            //End inner loop when reached 8 iterations
            if(j == 8){goto E4;}
            //Append nibble to word of zeroes
            num += nibs[j+(i*8)] << (4 * (7-j));  
            //increment iterator     
            j++;
            //repeat
            goto L4;
        E4:
        //Copy num to arr[i]
        *(arr + i) = num;
        //increment
        i++;
        //repeat
        goto L3;
    E3:
    
}


int main(int argc, char** argv) {

    /**
     * Task 1
     */

    char str1[] = "382 is the best!";
    char str2[100] = {0};

    copy_str(str1,str2);
    puts(str1);
    puts(str2);
    
    /**
     * Task 2
     */
    
    int vec_a[3] = {12, 34, 10};
    int vec_b[3] = {10, 20, 30};
    int dot = dot_prod((char*)vec_a, (char*)vec_b, 3, sizeof(int));
    
    printf("%d\n",dot);

    int vec_c[3] = {500, 500, 500};
    int vec_d[3] = {1000, 1000, 1000};
    dot = dot_prod((char*)vec_c, (char*)vec_d, 3, sizeof(int));

    printf("%d\n",dot);
    
    /**
     * Task 3
     */

    
    int arr[3] = {0x12BFDA09, 0x9089CDBA, 0x56788910};
    sort_nib(arr, 3);
    for(int i = 0; i<3; i++) {
        printf("0x%x ", arr[i]);
    }
    
    puts(" ");

    return 0;
}
