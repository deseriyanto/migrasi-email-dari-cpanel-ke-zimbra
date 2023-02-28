#!/bin/sh

# Clear screen
clear
LOCATION=`pwd`
rm $LOCATION/create-account-zimbra.zmp
touch $LOCATION/create-account-zimbra.zmp
echo "Looping for all users"

DOMAIN=`hostname`
USER_LIST="shadow"
USERS=`cat $LOCATION/$USER_LIST`


for ACCOUNT in $USERS; 
do
        PASS=`echo $ACCOUNT | cut -d ':' -f2`
        ACC=`echo $ACCOUNT | cut -d ":" -f1`

echo "Retrieve password account $ACC@$DOMAIN"
echo "ca $ACC@$DOMAIN PasswordTemp" >> create-account-zimbra.zmp
echo "ma $ACC@$DOMAIN userPassword '{crypt}$PASS'" >> create-account-zimbra.zmp

done
echo "Complete"
