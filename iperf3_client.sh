#!/bin/sh
echo ""
echo "iPerf Client"
echo ""
if [ "$1" == "" ] ; then
   echo "Requires IP\hostname of iPerf server.  Try $0 192.168.0.1"
   echo ""
   exit 1
else
iperf3 -c $1 -f M -n 200M
fi

