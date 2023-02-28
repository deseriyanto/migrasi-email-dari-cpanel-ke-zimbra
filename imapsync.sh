#!/bin/bash

############# CONFIGURATION ###########
ACCOUNTS=accounts.list
SRCHOST=sourceserver.domain.tld
DSTHOST=destinationserver.domain.tld
#######################################

EXTRALOG=sync.log
TSFORMAT="%Y-%m-%d %H:%M:%S"

# loop through all accounts
grep -ve '^#.*' $ACCOUNTS | while read SRCUSER SRCPW DSTUSER DSTPW
do
    MESSAGE="[`date +"$TSFORMAT"`] synchronizing $SRCUSER to $DSTUSER ..."
    echo $MESSAGE
    echo $MESSAGE >> $EXTRALOG

    # security: temporarly store passwords to files in order
    # not to pass them directly by command line option
    echo -n $SRCPW > imap-secret-src
    echo -n $DSTPW > imap-secret-dst

    ## Masukkan Script ImapSync disini ##
    imapsync --syncinternaldates --useheader="Message-Id" --skipcrossduplicates \
             --host1 $SRCHOST --user1 $SRCUSER --passfile1 imap-secret-src \
             --host2 $DSTHOST --user2 $DSTUSER --passfile2 imap-secret-dst

    ## VARIANT 1) source host supports SSL/TLS (imap port 993)
    #imapsync --host1 $SRCHOST --ssl1 --port1 993 --authmech1 PLAIN --user1 $SRCUSER --passfile1 imap-secret-src \
    #         --host2 $DSTHOST --ssl2 --port2 993 --authmech2 PLAIN --user2 $DSTUSER --passfile2 imap-secret-dst \
    #         --delete2 --delete2folders

    ## VARIANT 2) source host does not support SSL/TLS (imap port 143)
#    imapsync --host1 $SRCHOST        --port1 143 --authmech1 PLAIN --user1 $SRCUSER --passfile1 imap-secret-src \
 #            --host2 $DSTHOST --ssl2 --port2 993 --authmech2 PLAIN --user2 $DSTUSER --passfile2 imap-secret-dst
    #         --delete2 --delete2folders

    ## VARIANT 3) source host has different INBOX prefix, transform it while syncing
    #imapsync --host1 $SRCHOST --ssl1 --port1 993 --authmech1 PLAIN --user1 $SRCUSER --passfile1 imap-secret-src \
    #         --host2 $DSTHOST --ssl2 --port2 993 --authmech2 PLAIN --user2 $DSTUSER --passfile2 imap-secret-dst \
    #         --delete2 --delete2folders
    #         --regextrans2 "s/INBOX.INBOX/INBOX/"

  #  rm -f imap-secret-*
done

MESSAGE="[`date +"$TSFORMAT"`] imapsync sucessfully completed!"
echo $MESSAGE
echo $MESSAGE >> $EXTRALOG
exit 0
