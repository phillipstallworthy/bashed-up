#! /bin/bash

# Symbolic Link Maker Utility
# Make a symbolic link from the destination (/usr/local/bin) back to the each of the full path commands piped in
# IE call like this : sudo find /opt/maven/bin/ -maxdepth 1 -perm -111 -type f -print | ./mlinks.sh

destination=/usr/local/bin

# read pipeline into path
while read path; do
	# extract the last token, delimited by /
	command=`echo $path | awk -F '/' '{print $NF}'`
	sudo ln -s $path $destination/$command
done
