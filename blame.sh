#!/usr/bin/env sh
#
# Counts developers' involvement to the project by `git blame`. Shows the number of lines modified by each developer.
#
# Usage:
# 1. Edit line with `find . -name ...` with your project source files extentions.
#    This example count Kotlin, Swift, Elixir, Markdown and Docker files.
# 2. Start blame.sh in the project's root with .git directory.
# 3. Don't blame yourself for low lines counts, gold is between lines ;)
#


TMP_FILE="__blame.txt"

echo Create big blame file...

rm -f $TMP_FILE
find . -name "*Dockerfile" -o -name "*.kts" -o -name "*.md" -o -name "*.kt" -o -name "*.swift" -o -name "*.ex" -o -name "*.exs" | xargs -n1 git blame -e >>$TMP_FILE

DEVELOPERS=`cat $TMP_FILE | sed -n 's/^.*(<\([^>]*\)>.*$/\1/p' | sort | uniq`

echo Count lines...

for dev in $DEVELOPERS ; do
	WC=`cat $TMP_FILE | sed -n 's/^.*(<\([^>]*\)>.*$/\1/p' | grep $dev | wc -l`
	printf "$dev $WC\n"
done


rm -f $TMP_FILE
