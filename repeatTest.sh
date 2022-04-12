#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then
	echo Need [test class name] and [number of runs]
	exit
fi

if [ -e /lsc/repeatTestLog.log ]; then
rm -f /lsc/repeatTestLog.log
fi

touch /lsc/repeatTestLog.log

for i in `seq 1 $2` ; do
	ant test-class -Dtest.class=$1 2>&1 | tee -a /lsc/repeatTestLog.log
done
