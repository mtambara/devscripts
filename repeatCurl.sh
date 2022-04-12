#!/bin/bash

curl $1

while true;do
	curl -s $1 > /dev/null
done