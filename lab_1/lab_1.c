/***********************************************************
 * Filename: lab_1.c
 * Author  : Ethan Shanahan
 * Version : 1.0
 * Date    : Sep 12 2023
 * Description: Displays 32-bit binary representation of int
 * Pledge  : I pledge my honor that I have abided by the Stevens Honor System.
***********************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

void display(int8_t bit){
    putchar(bit + 48);
}

void display_32(int32_t num){
    for(int i = 31; i >= 0; i--){
        display((num >> i) & 1);
    }
}

int main(int argc, char const *argv[]){
    display_32(234);
    putchar('\n');
    return 0;
}