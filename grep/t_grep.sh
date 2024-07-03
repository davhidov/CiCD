#!/bin/bash

COUNTER_SUCCESS=0
COUNTER_FAIL=0
DIFF_RES=""
find=for
LEAK=""

#echo "" > log.txt
echo "Grep testing start"
TEST1="t_grep.sh s21_grep.c find.txt"
      grep $TEST1 > grep.txt
      $LEAK ./s21_grep $TEST1 > s21_grep.txt
      DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
      if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
        then
          (( COUNTER_SUCCESS++ ))
        else
          echo "$TEST1 FAIL"
          (( COUNTER_FAIL++ ))
      fi
      rm -rf s21_grep.txt grep.txt


for var in -e -i -v -c -l -n -h -s -o
do
  TEST1="$var $find t_grep.sh s21_grep.c"
  #echo "$TEST1"
  grep $TEST1 > grep.txt
  $LEAK ./s21_grep $TEST1 > s21_grep.txt
  DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
  if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
    then
      (( COUNTER_SUCCESS++ ))
    else
      echo "$TEST1 FAIL"
      (( COUNTER_FAIL++ ))
  fi
  rm -rf s21_grep.txt grep.txt
done

for var in -e -i -v -c -l -n -h -s -o
do
  for var1 in -e -i -v -c -l -n -h -s -o
  do
    if [ $var != $var1 ] && [ $var != -e ]
      then
      TEST1="$var $var1 $find t_grep.sh s21_grep.c"
      grep $TEST1 > grep.txt
      $LEAK ./s21_grep $TEST1 > s21_grep.txt
      DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
      if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
        then
          (( COUNTER_SUCCESS++ ))
        else
          echo "$TEST1 FAIL"
          (( COUNTER_FAIL++ ))
      fi
      rm -rf s21_grep.txt grep.txt
    fi
  done
done

for var in -e -i -v -c -l -n -h -s -o
do
  for var1 in -e -i -v -c -l -n -h -s -o
  do
    for var2 in -e -i -v -c -l -n -h -s -o
    do
      if [ $var != $var1 ] && [ $var != -e ] && [ $var1 != $var2 ] && [ $var1 != -e ] && [ $var != $var2 ]
        then
        TEST1="$var $var1 $var2 $find t_grep.sh s21_grep.c"
        grep $TEST1 > grep.txt
        $LEAK ./s21_grep $TEST1 > s21_grep.txt
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
          then
            (( COUNTER_SUCCESS++ ))
          else
            echo "$TEST1 FAIL"
            (( COUNTER_FAIL++ ))
        fi
        rm -rf s21_grep.txt grep.txt
      fi
    done
  done
done

for var in -i -v -c -l -n -h -s
do
  TEST1="$var -e if -e for t_grep.sh s21_grep.c"
  #echo "$TEST1"
  grep $TEST1 > grep.txt
  $LEAK ./s21_grep $TEST1 > s21_grep.txt
  DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
  if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
    then
      (( COUNTER_SUCCESS++ ))
    else
      echo "$TEST1 FAIL"
      (( COUNTER_FAIL++ ))
  fi
  rm -rf s21_grep.txt grep.txt
done

for var in -i -v -c -l -n -h -s
do
  for var1 in -i -v -c -l -n -h -s
  do
    if [ $var != $var1 ]
      then
      TEST1="$var $var1 -e if -e for t_grep.sh s21_grep.c"
      grep $TEST1 > grep.txt
      $LEAK ./s21_grep $TEST1 > s21_grep.txt
      DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
      if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
        then
          (( COUNTER_SUCCESS++ ))
        else
          echo "$TEST1 FAIL"
          (( COUNTER_FAIL++ ))
      fi
      rm -rf s21_grep.txt grep.txt
    fi
  done
done


TEST1="-s $find t_grep s21_gre"
      grep $TEST1 > grep.txt
      $LEAK ./s21_grep $TEST1 > s21_grep.txt
      DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
      if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
        then
	  (( COUNTER_SUCCESS++ ))
        else
          echo "$TEST1 FAIL"
          (( COUNTER_FAIL++ ))
      fi
      rm -rf s21_grep.txt grep.txt


for var in -i -v -c -l -n -h -s
do
  TEST1="$var -f find.txt t_grep.sh"
  grep $TEST1 > grep.txt
  $LEAK ./s21_grep $TEST1 > s21_grep.txt
  DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
  if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
    then
      (( COUNTER_SUCCESS++ ))
    else
      echo "$TEST1 FAIL"
      (( COUNTER_FAIL++ ))
  fi
  rm -rf s21_grep.txt grep.txt
done


for var in i v c l n h s e o
do
  for var1 in i v c l n h s e o
  do
    if [ $var != $var1 ] && [ $var != e ]
      then
      TEST1="-$var$var1 for t_grep.sh s21_grep.c"
      grep $TEST1 > grep.txt
      $LEAK ./s21_grep $TEST1 > s21_grep.txt
      DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
      if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
        then
          (( COUNTER_SUCCESS++ ))
        else
          echo "$TEST1 FAIL"
          (( COUNTER_FAIL++ ))
      fi
      rm -rf s21_grep.txt grep.txt
    fi
  done
done

for var in i v c l n h s e o
do
  for var1 in i v c l n h s e o
  do
    for var2 in i v c l n h s e o
    do
      if [ $var != $var1 ] && [ $var != e ] && [ $var1 != $var2 ] && [ $var1 != e ] && [ $var != $var2 ]
        then
        TEST1="-$var$var1$var2 $find t_grep.sh s21_grep.c"
        grep $TEST1 > grep.txt
        $LEAK ./s21_grep $TEST1 > s21_grep.txt
        DIFF_RES="$(diff -s s21_grep.txt grep.txt)"
        if [ "$DIFF_RES" == "Files s21_grep.txt and grep.txt are identical" ]
          then
            (( COUNTER_SUCCESS++ ))
          else
            echo "$TEST1 FAIL"
            (( COUNTER_FAIL++ ))
        fi
        rm -rf s21_grep.txt grep.txt
      fi
    done
  done
done

echo "SUCCESS: $COUNTER_SUCCESS"
echo "FAIL: $COUNTER_FAIL"
if [ $COUNTER_FAIL -gt 0 ]
then
	echo "Grep test fail"
	exit 1
else
	echo "Grep test sucsses"
	exit 0
fi
