#! /bin/bash

# Link all the files in a directory tree to an empty directory.
# Create soft links to every file in every directory and adds a index
# to any that have a duplicate name, some how...
#
# Iterate files in a directory
# Look for ones that end in ~x~
# rename them 0003.jpg.~4~ > 00003_4.jpg
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
  \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
# need a better way to error with no args.
shift $((OPTIND - 1))

echo $source
echo $destination

# destination
for filename in ./links_tmp/*.*; do
    # for ((i=0; i<=3; i++)); do
    #    ./MyProgram.exe "$filename" "Logs/$(basename "$filename" .txt)_Log$i.txt"
    # done
    base=`basename $filename`
    extension=${filename##*.}

    echo $filename $base $extension

    if [[ $extension = ~?~ ]]
      then echo match
    fi
done

#find links_tmp/ -type l -print0 | xargs -0 bash -c for filename; do
# if [[ "${filename##*.}" = "~1~"  ]]
# then
#echo "match"
#fi
#done bash
