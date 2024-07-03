#include "s21_grep.h"

int main(int argc, char **argv) {
  FLAG flag = {0};
  char buf_str[1024] = {0};
  regex_t reg;
  int size_str = 1, num_flag = 0, i = 0;
  parser(argc, argv, &flag, &num_flag, &size_str, &i, buf_str);
  if (flag.err == 1) return -1;
  E_flag(argc, argv, &flag, size_str, &i, buf_str);
  reg = work_argc(&argc, num_flag, &flag, buf_str, reg);
  work_file(argc, argv, &flag, reg, i);
  regfree(&reg);
  return 0;
}

char *parser(int argc, char **argv, FLAG *flag, int *num, int *len, int *e,
             char *str) {
  int j = 1;
  for (int i = 1; i < argc; i++) {
    if (argv[i][0] == '-') {
      j = 1;
      while (argv[i][j] != '\0') {
        switch (argv[i][j]) {
          case 'i':
            flag->I = 1;
            (*num)++;
            break;
          case 'e':
            *e = i + 1;
            if (flag->E == 1) str[*len - 1] = '|', *len += 1, (*num)++;
            *len += strlen(argv[i + 1]);
            strcat(str, argv[i + 1]);
            str[*len - 1] = '\0';
            flag->E = 1;
            (*num)++;
            break;
          case 'c':
            flag->C = 1;
            (*num)++;
            break;
          case 'n':
            flag->N = 1;
            (*num)++;
            break;
          case 'l':
            flag->L = 1;
            (*num)++;
            break;
          case 'v':
            flag->V = 1;
            (*num)++;
            break;
          case 'f':
            flag->F = 1;
            *e = i + 1;
            (*num)++;
            break;
          case 's':
            flag->S = 1;
            (*num)++;
            break;
          case 'h':
            flag->H = 1;
            (*num)++;
            break;
          case 'o':
            flag->O = 1;
            (*num)++;
            break;
          default:
            printf("s21_grep: invalid option -- '%c'", argv[i][j]);
            flag->err = 1;
            break;
        }
        if (j >= 2) (*num)--;
        j++;
      }
    }
  }
  return str;
}

char *E_flag(int argc, char **argv, FLAG *flag, int size_str, int *i,
             char *buf_str) {
  if (flag->E != 1 && flag->F != 1) {
    for (*i = 1; *i < argc; (*i)++) {
      if (argv[*i][0] != '-') {
        size_str += strlen(argv[*i]);
        strcat(buf_str, argv[*i]);
        break;
      }
    }
  }
  if (flag->F == 1) {
    FILE *file;
    int red = 0;
    char *temp = NULL;
    size_t llen = 0;
    file = fopen(argv[*i], "r");
    while (red != -1) {
      red = getline(&temp, &llen, file);
      if (red != -1) {
        if (temp[red - 1] == '\n') temp[red - 1] = '|';
        size_str += strlen(temp);
        strcat(buf_str, temp);
      }
    }
    buf_str[size_str - 2] = '\0';
    free(temp);
  }
  return buf_str;
}

regex_t work_argc(int *argc, int num_flag, FLAG *flag, char *buf_str,
                  regex_t reg) {
  int reg_flag = REG_EXTENDED;
  *argc -= (num_flag + 2);
  if (*argc > 1) flag->file = 1;
  if (flag->I == 1) reg_flag = REG_ICASE | REG_EXTENDED;
  regcomp(&reg, buf_str, reg_flag);
  return reg;
}

char *put_line(char **argv, FLAG *flag, FILE *file, regex_t reg, int i,
               char *temp, int *cout) {
  int red = 0, SUC = 0, cout_line = 0, red_d = 0;
  size_t llen = 0;
  char *alloc_str = NULL;
  regmatch_t math[10];
  while (red != -1) {
    red = getline(&temp, &llen, file), cout_line++;
    if (red != -1) red_d = red;
    SUC = regexec(&reg, temp, 10, math, 0);
    if (SUC == REG_NOMATCH && flag->V == 1 && red != -1) {
      (*cout)++;
      if (flag->C != 1 && flag->L != 1 && flag->O != 1) {
        if (flag->file == 1 && flag->H != 1) printf("%s:", argv[i + 1]);
        if (flag->N == 1) printf("%d:", cout_line);
        printf("%s", temp);
      }
    } else if (SUC == 0 && flag->V != 1 && red != -1) {
      (*cout)++;
      if (flag->C != 1 && flag->L != 1) {
        if (flag->file == 1 && flag->H != 1) printf("%s:", argv[i + 1]);
        if (flag->N == 1) printf("%d:", cout_line);
        if (flag->O == 1) {
          alloc_str = get_o(math[0].rm_so, math[0].rm_eo, temp);
          printf("%s\n", alloc_str);
          free(alloc_str);
        } else {
          printf("%s", temp);
        }
      }
    }
  }
  if (temp[red_d - 1] != '\n' && (flag->V == 1) && flag->C != 1 &&
      flag->L != 1 && flag->O != 1)
    printf("\n");
  free(temp);
  return temp;
}

void work_file(int argc, char **argv, FLAG *flag, regex_t reg, int i) {
  int cout = 0;
  char *temp = NULL;
  while (argc) {
    FILE *file;
    file = fopen(argv[i + 1], "r");
    if (file == NULL) {
      flag->err = 1;
      if (flag->S != 1)
        printf("s21_grep: No such file or directory\n%s\n", argv[i + 1]);
    }
    if (flag->err == 1) exit(-1);
    put_line(argv, flag, file, reg, i, temp, &cout);
    if (flag->L == 1 && cout > 0) printf("%s\n", argv[i + 1]);
    if (flag->C == 1 && flag->L != 1) {
      if (flag->file == 1 && flag->H != 1) printf("%s:", argv[i + 1]);
      printf("%d\n", cout);
    }
    cout = 0;
    fclose(file);
    i++, argc--;
  }
}

char *get_o(int start, int end, char *temp) {
  int len = end - start;
  int j = 0;
  char *mass = calloc(len + 1, sizeof(char));
  for (int i = start; i < end; i++) {
    mass[j] = temp[i];
    j++;
  }
  return mass;
}
