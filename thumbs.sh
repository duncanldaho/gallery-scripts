#!/bin/bash

# Determine current working directory and make the thumbnail directory
cwd=${PWD##*/}
cwd=${cwd:-/}
thumb_dir=$cwd
thumb_dir+=_t
mkdir "$thumb_dir"

# Rename JPGs with leading zeros, generate thumbs & apply watermark
for file in [0-9]*.jp*
do
  name=${file%.*}
  extension=${file##*.}
  new_name=`printf %04d.%s ${name} ${extension}`
  mv -n $file $new_name
  composite -gravity south -geometry +0+10 stamp.png $new_name $new_name
done

# Change directory to new thumb_dir and generate thumbs
cp [0-9]*.jp* $thumb_dir
cd $thumb_dir
mogrify -thumbnail 150x150^ -gravity center *.jp*
