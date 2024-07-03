GFlAG = -Wall -Werror -Wextra -std=c11

all:
	make s21_cat

s21_cat: s21_cat.c
	gcc $(GFlAG) s21_cat.c -o s21_cat

test:
	./t_cat.sh

clean:
	rm -rf s21_cat log.txt

style:
	clang-format -n -style=Google s21_cat.c
	
leak:
	make s21_cat
	valgrind ./s21_cat -b test.txt
