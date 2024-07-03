scp -p22 -o stricthostkeychecking=no -o userknownhostsfile=/dev/null ./cat/s21_cat user@172.24.116.8:/home/user
scp -p22 -o stricthostkeychecking=no -o userknownhostsfile=/dev/null ./grep/s21_grep user@172.24.116.8:/home/user
ssh -p22 user@172.24.116.8 "echo -en "user" | sudo -S mv s21* /usr/local/bin"

