module=$1

find . -name build.gradle | xargs grep -Fl $module | xargs -I {} dirname {}