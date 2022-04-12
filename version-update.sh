#!/bin/bash

OLD_VERSION=$2

if [ -z $OLD_VERSION ]; then 
    OLD_VERSION='[^\"]+'
fi

find . -type f -name "build.gradle" -exec sed -i -E "s/(name: \")($1)(\", version: \")$OLD_VERSION\"/\1\2\3default\"/" {} +
