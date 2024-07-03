GFlAG = -Wall -Werror -Wextra

all:
	make s21_grep

s21_grep: s21_grep.c
	gcc $(GFlAG) s21_grep.c -o s21_grep -D_GNU_SOURCE #-fsanitize=address -g

test:
	./t_grep.sh

clean:
	rm -rf s21_grep log.txt my.txt orig.txt

style:
	make s21_grep
	python3 ../../materials/linters/cpplint.py --extensions=c s21_grep.c
	
leak:
	make s21_grep
	valgrind ./s21_grep -b test.txt

FUN = -v for t_grep.sh s21_grep.c
testov:
	make clean
	make s21_grep
	./s21_grep $(FUN) >> my.txt
	grep $(FUN) >> orig.txt
	diff -s my.txt orig.txt

tess:
	make clean
	make s21_grep
	./s21_grep $(FUN)
