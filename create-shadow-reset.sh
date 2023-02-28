#!/bin/sh

# Clear screen
clear
LOCATION=`pwd`
rm $LOCATION/shadow-reset
touch $LOCATION/shadow-reset
echo "Looping for all users"

DOMAIN=`namadomain` #ubah namadomain sesuai domain yang benar
USER_LIST="shadow_original"
USERS=`cat $LOCATION/$USER_LIST`
PASS=`cat $LOCATION/password.txt`

for ACCOUNT in $USERS;
do
        ACC=`echo $ACCOUNT | cut -d ":" -f1`
        ID=`echo $ACCOUNT | cut -d ':' -f3`

echo "create data untuk akun $ACC@$DOMAIN"
echo "$ACC:$PASS:$ID::::::" >> shadow-reset

done
echo "Complete"
