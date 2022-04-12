#!/bin/bash

alias gw="exec_gradlew $1"

exec_gradlew() {
	if [ -e ../gradlew ];
	then
		../gradlew $1
	elif [ -e ../../gradlew ]
	then
		../../gradlew $1
	elif [ -e ../../../gradlew ]
	then
		../../../gradlew $1
	elif [ -e ../../../../gradlew ]
	then
		../../../../gradlew $1
	elif [ -e ../../../../../gradlew ]
	then
		../../../../../gradlew $1
	else
		echo "Unable to find locate Gradle wrapper."
	fi
}
