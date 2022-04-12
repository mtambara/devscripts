#!/bin/bash
exec_gradlew() {
    rm ../settings.gradle

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

name=$(echo $1|cut -d '.' -f 1)

v=$(find . -name "$name.java")

dr=${v%/src/*}

if [[ $v = *"src/testIntegration/"* ]]; then
    (cd $dr;exec_gradlew testIntegration --tests *.$1 $2 $3 $4 $5 $6 $7 $8 $9)
elif [[ $v = *"src/test/"* ]]; then
    (cd $dr;exec_gradlew test --tests *.$1 $2 $3 $4 $5 $6 $7 $8 $9)
else
    echo "Not a test"
fi