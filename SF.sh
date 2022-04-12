#!/bin/bash
cd /lsc/liferay-portal/portal-impl;

if [ "$1" == "local" ]; then
	ant format-source-local-changes;
elif [ "$1" == "author" ]; then
	ant format-source-latest-author;
elif [ "$1" == "branch" ]; then
	ant format-source-current-branch;
else
	echo "Use either \"local\", \"author\", or \"branch\""
fi
