#include <stdio.h>

typedef struct flag {
  int NUM_NON;  // -b
  int DOLLAR;   // -e or e+v or E(e-v)
  int NUM;      // -n
  int SQIZZE;   // -s
  int TAB;      // -t or t+v or T(t-v)
  int UTF;      // -v
  int error;
  int E;
  int T;
} flag;

int parser_arg(int argc, char **argv, flag *flag);
void print_al(int argc, char **argv, flag *flag);
int put_char(int num, FILE *file, flag *flag);

int main(int argc, char **argv) {
  flag flag = {0, 0, 0, 0, 0, 0, 0, 0, 0};
  parser_arg(argc, argv, &flag);
  if (flag.NUM == flag.NUM_NON) flag.NUM = 0;
  if (flag.error == 1) return -1;
  print_al(argc, argv, &flag);
  if (flag.error == 1) return -2;

  return 0;
}

int parser_arg(int argc, char **argv, flag *flag) {
  int cont = 0;
  for (int i = 1; i < argc; i++) {
    if (argv[i][0] == '-') {
#ifdef __linux__
      if (argv[i][1] == 'E') {
        flag->E = 1;
        continue;
      }
      if (argv[i][1] == 'T') {
        flag->T = 1;
        continue;
      }
      if (argv[i][1] == '-') {
        if (argv[i][2] == 'n' && argv[i][9] == 'n') {
          flag->NUM_NON = 1;
          continue;
        } else if (argv[i][2] == 'n') {
          flag->NUM = 1;
          continue;
        }
        if (argv[i][2] == 's') {
          flag->SQIZZE = 1;
          continue;
        }
      }
#endif
      switch (argv[i][1]) {
        case 'n':
          flag->NUM = 1;
          cont = 1;
          break;
        case 'b':
          flag->NUM_NON = 1;
          cont = 1;
          break;
        case 'e':
          flag->DOLLAR = 1;
          cont = 1;
          break;
        case 's':
          flag->SQIZZE = 1;
          cont = 1;
          break;
        case 't':
          flag->TAB = 1;
          cont = 1;
          break;
        case 'v':
          flag->UTF = 1;
          cont = 1;
          break;
        default:
          printf("cat: invalid option -- '%c'\n", argv[i][1]);
          flag->error = 1;
          break;
      }
    }
  }
  return cont;
}

void print_al(int argc, char **argv, flag *flag) {
  int num = 1;
  for (int i = 1; i < argc; i++) {
    if (argv[i][0] == '-') continue;
    FILE *file;
    file = fopen(argv[i], "r");
    if (file == NULL)
      printf("cat: %s: No such file or directory\n", argv[i]), flag->error = 1;
    if (flag->error == 1) break;
    num = put_char(num, file, flag);
    fclose(file);
  }
}

int put_char(int num, FILE *file, flag *flag) {
  char i = 0, i_p = 0;
#ifdef __APPLE__
  num = 1;
#endif
  if (flag->NUM == 1 || flag->NUM_NON == 1) printf("%6d\t", num), num++;
  while (i_p != EOF) {
    i = getc(file);
    if (i == '\t' && (flag->TAB == 1 || flag->T == 1)) {
      printf("^I");
      i_p = getc(file);
      if (i_p == '\n' && (flag->DOLLAR == 1 || flag->E == 1)) printf("$");
      fseek(file, -1, 1);
      continue;
    }
    if (flag->UTF == 1 || flag->DOLLAR == 1 || flag->TAB) {
      if ((i >= 0 && i < 9) || (i > 10 && i <= 31))
        i += 64, printf("^%c", i);
      else if (i == 127)
        printf("^?");
      else
        printf("%c", i);
    } else {
      printf("%c", i);
    }
    i_p = getc(file);
    if (i_p == '\n' && i == '\n' && flag->SQIZZE == 1) {
      while ((i_p = getc(file)) == '\n') {
      }
      if (flag->NUM) printf("%6d\t", num), num++;
      if (flag->DOLLAR || flag->E == 1) printf("$");
      printf("%c", i);
    }
    if (i == '\n' && flag->NUM == 1 && i_p != EOF) printf("%6d\t", num), num++;
    if ((i == '\n' && (i_p != '\n' && i_p != EOF)) && flag->NUM_NON == 1)
      printf("%6d\t", num), num++;
    if ((i_p == '\n') && (flag->DOLLAR == 1 || flag->E)) printf("$");
    fseek(file, -1, 1);
  }
  return num;
}
