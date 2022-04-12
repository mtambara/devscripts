#!/bin/bash
if [ -f output.txt ];
then
   rm output.txt
fi

touch output.txt

for i in {0..19}
do
	echo "Starting test class group $i"
	echo "Test $i" >> output.txt
	ant test-class-group -Dtest.class.group.index=$i |tee -a output.txt
done

echo "Finished, check output.txt for results"
