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
#
# put the script in the to level directory
# the contains sub directories of files
# IE put it in ~/Photos
# and run like this ./uplink.sh
#
# TODO: make the source and destination parameters
# work correctly, so that it can be run from anywhere.

source=
destination=

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

# override the parameter for now, see TODO:
destination=links_tmp
echo removing and recreating $destination directory
rm --recursive --force $destination
mkdir --parents --verbose $destination
#echo $source $destination

# find all files and count file types
# http://stackoverflow.com/questions/14514535/how-can-i-count-the-different-file-types-within-a-folder-using-linux-terminal
# find ./ -type f |awk -F . '{print $NF}' | sort | awk '{count[$1]++}END{for(j in count) print j,"("count[j]" occurences)"}'
# find -type f -name *.jpeg -print

images=("JPG" "3gp" "wmv" "swf" "MPG" "AVI" "MOV" "jpg" "GIF" "mpg" "tif" "gif" "bmp" "MP4" "jpeg")

# find the files and make links
echo count the orginals
for ext in "${images[@]}"; do
find ./ -type f -name *.$ext |awk -F . '{print $NF}' | sort | awk '{count[$1]++}END{for(j in count) print j,"("count[j]" occurences)"}' ;
done

# find all image files below this location
# and make a link to them in a directory
# TODO: this is the only place that uses links_tmp rather than destination
# TODO: also needs to work with source
echo finding and linking files

for ext in "${images[@]}"; do
find -type f -name *.$ext -exec ln --backup=numbered -s ../'{}' ./links_tmp/ \;
done


echo Renaming links
# Iterate and rename the links created
for filename in ./$destination/*.*; do

    echo -n .
    #base=`basename $filename`
    base=${filename##*/}

    # remove the  twice to deal with double s
    nameOnly=${base%.*}
    nameOnly=${nameOnly%.*}

    extension=${filename##*.}
    directory=`dirname $filename`

    # echo filename=$filename base=$base name=$nameOnly ext=$extension dir=$directory

    # check the length of the number in the extension
    # ~1~ = 1
    # ~10~ = 2
    length=0
    regex1='~[0-9]~'
    regex2='~[0-9][0-9]~'
    if [[ $extension =~ $regex1 ]]
    then length=1
    fi

    if [[ $extension =~ $regex2 ]]
    then length=2
    fi
    # echo $length

    # Extract the string number from the extension
    number=`expr substr $extension 2 $length`
    # echo number string = $number

    # move the file to a better named one that works as a image file.
    # 0009.jpg.~3~ -> 00009_3.jpg
    if [[ $number != "" ]]
    then
    TODO: get the real extention
    echo mv $filename $directory/$nameOnly"_"$number.jpg
    mv $filename $directory/$nameOnly"_"$number.jpg
    fi
done
echo .

echo count the links
for ext in "${images[@]}"; do
find ./links_tmp -type l -name *.$ext |awk -F . '{print $NF}' | sort | awk '{count[$1]++}END{for(j in count) print j,"("count[j]" occurences)"}' ;
done
