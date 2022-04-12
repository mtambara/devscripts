#!/bin/sh

printHelpAndExit() {
	echo ''
	echo 'Usage:'
	echo '    getu [-uf] <search terms>'
	echo ''
	echo 'Options: (all optional)'
	echo '    -u : Display only usernames'
	echo '    -f : Display only fullnames'
	echo ''
	echo 'Example:'
	echo '    getu -u brian'
	echo ''
	exit "$1"
}

SHOW_FULLNAME=0
SHOW_USERNAME=0

while getopts fhu FLAGS; do
	case $FLAGS in
		f) SHOW_FULLNAME=1 ; SHOW_USERNAME=0 ;;
		h) printHelpAndExit 0 ;;
		u) SHOW_FULLNAME=0 ; SHOW_USERNAME=1 ;;
		*) printHelpAndExit 1 ;;
	esac
done

shift $((OPTIND-1))

[ "$#" -gt 0 ] || printHelpAndExit 1

url="$(echo "https://github.com/orgs/liferay/people?query=${*}" | sed "s| |%20|g")"

# 1st tr: replaces all newlines with spaces
# 1st sed: splits into multiple lines by pattern (OS X specific)
# grep: filters out irrelevant 1st line
# 2nd sed: removes everything up till USERNAME
# 3rd sed: replaces everything from USERNAME till FULLNAME with a colon
# 4th sed: removes everything after FULLNAME
# 5th sed: replaces escaped double-quotes with actual double-quotes
# 6th sed: swaps output so FULLNAME shows first

RESULTS="$(
curl -s "${url}" |
	tr '\n' ' ' |
	sed 's| member-info|\'$'\n&|g' |
	grep member-info |
	sed -E \
		-e 's|^.*css-truncate-target f4" href="/||' \
		-e 's|"> +| : |' \
		-e 's| +</a>.*||' \
		-e 's|&quot;|"|g' \
		-e 's|(.*) : (.*)|\2 : \1|'
)"

if [ -z "${RESULTS}" ]; then
	echo "No users found..."
elif [ ${SHOW_FULLNAME} -gt 0 ]; then
	echo "${RESULTS}" | awk -F' : ' '{print $1}'
elif [ ${SHOW_USERNAME} -gt 0 ]; then
	echo "${RESULTS}" | awk -F' : ' '{print $2}'
else
	echo "${RESULTS}"
fi