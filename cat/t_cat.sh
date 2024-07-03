#!/bin/bash
COUNTER_SUCCESS=0
COUNTER_FAIL=0
DIFF_RES=""
TEST_FILE="bytes.txt test.txt"
echo "Cat tests"
for var in -e -s -t -v -b -n -E -T #--number-nonblank --number --squeeze-blank
do
          TEST1="$var $TEST_FILE"          
          ./s21_cat $TEST1 > s21_cat.txt
          cat $TEST1 > cat.txt
          DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
          if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
            then
              (( COUNTER_SUCCESS++ ))              
            else              
              (( COUNTER_FAIL++ ))
              echo "$TEST1 - fail" 
          fi
          rm s21_cat.txt cat.txt
done

for var in -b -e -n -s -t -v -E -T #--number-nonblank --number --squeeze-blank
do
  for var2 in -b -e -n -s -t -v -E -T #--number-nonblank --number --squeeze-blank
  do
        if [ $var != $var2 ]
        then
          TEST1="$var $var2 $TEST_FILE"
          ./s21_cat $TEST1 > s21_cat.txt
          cat $TEST1 > cat.txt
          DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
          if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
            then
              (( COUNTER_SUCCESS++ ))             
            else 
              echo "$TEST1 - fail"              
              (( COUNTER_FAIL++ ))
          fi
          rm s21_cat.txt cat.txt
        fi
  done
done

for var in -b -e -n -s -t -v -E -T #--number-nonblank --number --squeeze-blank
do
  for var2 in -b -e -n -s -t -v -E -T #--number-nonblank --number --squeeze-blank
  do
      for var3 in -b -e -n -s -t -v -E -T #--number-nonblank --number --squeeze-blank
      do
        if [ $var != $var2 ] && [ $var2 != $var3 ] && [ $var != $var3 ]
        then
          TEST1="$var $var2 $var3 $TEST_FILE"
          ./s21_cat $TEST1 > s21_cat.txt
          cat $TEST1 > cat.txt
          DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
          if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
            then
              (( COUNTER_SUCCESS++ ))              
            else
              echo "$TEST1 - fail"              
              (( COUNTER_FAIL++ ))
          fi
          rm s21_cat.txt cat.txt
        fi
      done
  done
done

for var in -b -e -n -s -t -v -E -T #--number-nonblank --number --squeeze-blank
do
  for var2 in -b -e -n -s -t -v -E -T #--number-nonblank --number --squeeze-blank
  do
      for var3 in -b -e -n -s -t -v -E -T #--number-nonblank --number --squeeze-blank
      do
          for var4 in -b -e -n -s -t -v -E -T #--number-nonblank --number --squeeze-blank
          do
            if [ $var != $var2 ] && [ $var2 != $var3 ] && [ $var != $var3 ] && [ $var != $var4 ] && [ $var2 != $var4 ] && [ $var3 != $var4 ]
            then
              TEST1="$var $var2 $var3 $var4 $TEST_FILE"
              ./s21_cat $TEST1 > s21_cat.txt
              cat $TEST1 > cat.txt
              DIFF_RES="$(diff -s s21_cat.txt cat.txt)"
              if [ "$DIFF_RES" == "Files s21_cat.txt and cat.txt are identical" ]
                then
                  (( COUNTER_SUCCESS++ ))                  
                else   
                  echo "$TEST1 - fail"              
                  (( COUNTER_FAIL++ ))
              fi
              rm s21_cat.txt cat.txt
            fi
          done
      done
  done
done

echo "SUCCESS: $COUNTER_SUCCESS"
echo "FAIL: $COUNTER_FAIL"
if [ $COUNTER_FAIL -gt 0 ] 
then
	echo "Cat test fail"
	exit 1
else
	echo "Cat test sucssec"
	exit 0
fi
