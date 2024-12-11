/*******************************************************************************
 * Name          : assembler.cpp
 * Author        : Ethan Shanahan and Kieran Corson
 * Pledge        : I pledge my honor that I have abided by the Stevens Honor System.
 * Date          : 12/8/2023
 * Description   : Assembles txt file of valid instructions into image file of hex and addr
 ******************************************************************************/

#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>

std::string decToHexa(int n) {
    //Open Source Algorithm for converting decimal value to hexadecimal
    std::string ans = ""; 
    while (n != 0) { 
        int rem = 0; 
        char ch; 
        rem = n % 16; 
        if (rem < 10) { ch = rem + 48; } 
        else { ch = rem + 55; } 
        ans += ch; 
        n = n / 16; 
    } 
    int i = 0, j = ans.size() - 1; 
    while(i <= j) { 
      std::swap(ans[i], ans[j]); 
      i++; 
      j--; 
    } 
    return ans; 
} 

void pass_reg(long& data, std::string arg, bool imm){
    std::istringstream iss(arg);
    int integer_arg;
    iss >> integer_arg;
    if(imm){
        data = (data << 11) | integer_arg;
        return;
    }
    data = (data << 5) | integer_arg;
}

// Function to convert assembly instruction to machine code
long encode(const std::vector<std::string>& params) {
    long data;
    bool imm = true;

    std::string opcode = params[0];

    if(params[3].at(0) == 'x'){
        imm = false;
    }

    if(opcode.compare("add") == 0){
        data = (imm)? 0b1101 : 0b101;
    }else if(opcode.compare("mult") == 0){
        data = (imm)? 0b1111 : 0b111;
    }else if(opcode.compare("ldr") == 0){
        data = 0b111100;
    }else if(opcode.compare("str") == 0){
        data = 0b1001000;
    }

    if(!imm){
        pass_reg(data, params[3].substr(1,params[3].find('\n')), false);
        data = (data << 6) | 0b111000;
    }else{
        pass_reg(data, params[3], true);
    }
    pass_reg(data, params[2].substr(1,params[2].find(',')-1), false);
    pass_reg(data, params[1].substr(1,params[1].find(',')-1), false);

    return data;
}

int main(int argc, char *argv[]) {

    if(argc != 2){
        std::cerr << "Usage: ./assembler <filename>" << std::endl;
        return 1;
    }

    std::ifstream input(argv[1]);
    if (!input.is_open()) {
        std::cerr << "Error opening file." << std::endl;
        return 1;
    }

    std::ofstream output("bin");
    if (!output.is_open()) {
        std::cerr << "Error creating output file." << std::endl;
        return 1;
    }

    output << "v3.0 hex words plain" << std::endl;

    std::string line;
    std::vector<std::string> params;
    unsigned int line_number = 1;
    while (std::getline(input, line)) {
        std::stringstream ss(line);
        std::string s;
        while (std::getline(ss, s, ' ')) {
            params.push_back(s);
        }
        if(line_number!=1 && line_number%8 == 1){
            output << std::endl;
        }
        output << decToHexa(encode(params)) << ' ';
        params.clear();
        ++line_number;
    }

    input.close();
    output.close();
 
    return 0;
}