#! /bin/bash

# Link all the files in a directory tree to an empty directory.
# Create soft links to every file in every directory and adds a index
# to any that have a duplicate name, some how...
#
# param - source directory - The directory with the files that you need links to
# param - destination - The directory where you would like all the links to be
# Make a symbolic link from the destination (/usr/local/bin) back to the each of the full path commands piped in
# IE call like this : sudo find /opt/maven/bin/ -maxdepth 1 -perm -111 -type f -print | ./mlinks.sh

source=  destination=

# http://stackoverflow.com/questions/12036445/bash-command-line-arguments

while getopts s:d: opt; do
  case $opt in
  s)
      source=$OPTARG
      ;;
  d)
      destination=$OPTARG
      ;;
  esac
done

shift $((OPTIND - 1))

echo $source
echo $destination


# destination=/usr/local/bin
