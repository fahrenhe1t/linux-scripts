#!/bin/bash
echo ""
echo "Convert Fahrenheit to Celsius"
echo ""
if [ "$1" == "" ] ; then
   echo "Command line is blank.  Try $0 26"
   echo ""
else
gawk -v var=$1 'BEGIN {print var,"ºF =", (var - 32) / 1.8,"ºC"}'
echo ""
fi
