#!/bin/bash

# Prepare gallery.md file from gallery.template
cat gallery.base > gallery.md

# Make entry for each renamed .jpg in sorted order
for file in $(ls [0-9]*.jp* | sort -n)
do
  echo \<img class=\"square-crop\" tabindex=1 src=\"$thumb_dir/$file\" /\>\<span class=\"f\"\>\<img src=\""$file"\" /\>\</span\> >> gallery.md
done

# Close div
echo  \</div\> >> gallery.md
