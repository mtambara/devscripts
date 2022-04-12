#!/bin/bash
exec_gradlew() {
    rm -f ../settings.gradle

	if [ -e ../gradlew ];
	then
		../gradlew $1 $2 $3 $4 $5 $6 $7 $8 $9
	elif [ -e ../../gradlew ]
	then
		../../gradlew $1 $2 $3 $4 $5 $6 $7 $8 $9
	elif [ -e ../../../gradlew ]
	then
		../../../gradlew $1 $2 $3 $4 $5 $6 $7 $8 $9
	elif [ -e ../../../../gradlew ]
	then
		../../../../gradlew $1 $2 $3 $4 $5 $6 $7 $8 $9
	elif [ -e ../../../../../gradlew ]
	then
		../../../../../gradlew $1 $2 $3 $4 $5 $6 $7 $8 $9
	elif [ -e ../../../../../../gradlew ]
	then
		../../../../../../gradlew $1 $2 $3 $4 $5 $6 $7 $8 $9
	elif [ -e ../../../../../../../gradlew ]
	then
		../../../../../../../gradlew $1 $2 $3 $4 $5 $6 $7 $8 $9
	elif [ -e ../../../../../../../../gradlew ]
	then		../../../../../../../../gradlew $1 $2 $3 $4 $5 $6 $7 $8 $9
	else
		echo "Unable to find locate Gradle wrapper."
	fi
}

drd=$PWD
for d in $(find . -name "bnd.bnd") ;
do 
	dr=${d%/*}

	# echo $dr
	cd "$drd"
	cd "$dr" && exec_gradlew $1
done