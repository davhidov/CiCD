#ifndef C3_SRC_GREP_S21_GREP_H_
#define C3_SRC_GREP_S21_GREP_H_
#include <stdio.h>
#include <regex.h>
#include <string.h>
#include <stdlib.h>

typedef struct FLAG {
    int E;
    int I;
    int V;
    int C;
    int L;
    int N;
    int err;
    int file;
    int H;
    int O;
    int S;
    int F;
} FLAG;

char* parser(int argc, char** argv, FLAG *flag, int* num, int *len, int *i, char* str);
char*  E_flag(int argc, char **argv, FLAG *flag, int size_str, int *i, char* buf_str);
regex_t work_argc(int *argc, int num_flag, FLAG *flag, char *buf_str, regex_t reg);
char* put_line(char** argv, FLAG *flag, FILE *file, regex_t reg, int i, char *temp, int* cout);
char *get_o(int start, int end, char* temp);
void work_file(int argc, char **argv, FLAG *flag, regex_t reg, int i);

#endif  // C3_SRC_GREP_S21_GREP_H_
