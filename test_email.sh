#!/bin/bash
#
# test_email.sh - send a test email with ssmtp
# usage: test_email.sh to_address subject "message"

# Set Variables
to_addr="$1"
subj="$2"
msg="$3"
echo ""
echo "Test Email Script"
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
   echo "Send Test Email"
   echo "To: $1"
   echo "Subject: $2"
   echo "Message: $3"
fi
echo ""
echo -e "To: $1\nSubject: $2\n$3\n\n" | ssmtp -vvv $1
