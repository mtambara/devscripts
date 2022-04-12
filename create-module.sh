#!/bin/bash

base=$1

cd $base

api="${base##*/}-api"
impl="${base##*/}-impl"

bnd="Bundle-Name: \nBundle-SymbolicName: \nBundle-Version: 1.0.0"

if [ ! -d $api ]
then
	echo "Creating $api"
	mkdir $api
	
	echo -e $bnd >> $api/bnd.bnd
	touch $api/build.gradle
	mkdir -p $api/src/main/java

fi

if [ ! -d $impl ]
then
	echo "Creating $impl"
	mkdir $impl
	
	echo -e $bnd >> $impl/bnd.bnd
	touch $impl/build.gradle
	mkdir -p $impl/src/main/java

fi