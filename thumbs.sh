#!/bin/bash

# Determine current working directory and the thumbnail directory
cwd=${PWD##*/}
cwd=${cwd:-/}
thumb_dir=$cwd
thumb_dir+=_t

# If thumb_dir doesn't exist, make it and continue; otherwise exit script
if ! [ -d $thumb_dir ]; then
  mkdir "$thumb_dir"
else
  if [ -d $thumb_dir ]; then
    exit 1
  fi
fi

# User input date in ISO 8601 format
printf "%s" "Date in ISO 8601: "
read ISO8601

# Rename JPGs with leading zeros, generate thumbs & apply watermark
for file in [0-9]*.jp*
do
  new_name="$ISO8601"_"$file"
  echo "$new_name"
  composite -gravity south -geometry +0+10 stamp.png $file $new_name
  rm $file
done

# Change directory to new thumb_dir and generate thumbs
cp [0-9]*.jp* $thumb_dir
cd $thumb_dir
mogrify -thumbnail 150x150^ -gravity center *.jp*
