#!/bin/bash
echo ""
echo "Convert Celsius to Fahrenheit"
echo ""
if [ "$1" == "" ] ; then
   echo "Command line is blank.  Try $0 26"
   echo ""
else
gawk -v var=$1 'BEGIN {print var,"ºC =", var * 1.8 + 32,"ºF"}'
echo ""
fi
