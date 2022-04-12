#!/bin/bash

echo $2

if [ -e /lsc/repeatLog.log ]; then
rm -f /lsc/repeatLog.log
fi

touch /lsc/repeatLog.log

for i in `seq 1 10` ; do
	gwTest FileinstallDeployTest
done
