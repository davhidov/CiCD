cp ../materials/linters/.clang-format cat/
cp ../materials/linters/.clang-format grep/

clang-format -n cat/*.c grep/*.c
clang-format -n cat/*.c grep/*.c >> find.txt 2>&1

r=$(cat find.txt | wc -l)
rm find.txt

if [ $r -gt 0 ] 
then
	echo "Fail"
	exit 1
else
	echo "Sucsess"
	exit 0
fi
