#!/bin/bash

while IFS= read -r line
do
	IFS=: read var1 var2 <<< $line

sed -i -E "s|\"image\": \".*\"|\"image\": \"$var2\"|g" $var1/LCP.json
  echo "$var1 $var2"
done < "images.properties"