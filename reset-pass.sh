#!/bin/sh

# Clear screen
clear
LOCATION=`pwd`
rm $LOCATION/reset-pass.zmp
touch $LOCATION/reset-pass.zmp
echo "Looping for all users"

DOMAIN="namadomain" #ganti nama domain dengan domain TLD masing-masing
USER_LIST="shadow"
USERS=`cat $LOCATION/$USER_LIST`


for ACCOUNT in $USERS;
do
        PASS=`echo $ACCOUNT | cut -d ':' -f2`
        ACC=`echo $ACCOUNT | cut -d ":" -f1`

echo "Retrieve password account $ACC@$DOMAIN"
echo "ma $ACC@$DOMAIN userPassword '{crypt}$PASS'" >> reset-pass.zmp

done
echo "Complete"
