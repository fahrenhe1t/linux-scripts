#!/bin/bash
#
# email_accounts.sh - send emails with ssmtp to Gmail accounts to make them check more often
# usage: email_accounts.sh to_address subject "message"

# Set Variables
to_addr="$1"
subj="$2"
msg="$3"
now=$(date +"%T")
echo ""
echo "Email Script"
echo ""
if [ -z "$1" ]; then
   echo "Script requires 'To' address.  Try: $0 you@gmail.com Test \"Test Message\""
   echo ""
   exit 1
elif [ -z "$2" ]; then
   echo "Script requires 'Subject'.  Try: $0 you@gmail.com Test \"Test Message\""
   echo ""
   exit 1
elif [ -z "$3" ]; then
   echo "Script requires a message.  Try: $0 you@gmail.com Test \"Test Message\""
   echo ""
   exit 1
else
   echo "Send Email"
   echo "To: $1"
   echo "Subject: $2 - $now"
   echo "Message: $3"
fi
echo ""
echo -e "To: $1\nSubject: $2 - $now\n$3\n\n" | /usr/sbin/ssmtp -vvv $1
