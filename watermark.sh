#!/bin/bash

# Generate grey text "© Duncan Idaho" and save as stamp_fgnd.png
convert -size 600x600 xc:grey30 -pointsize 80 -gravity center -draw "fill grey70 text 0,0 '© Duncan Idaho'" stamp_fgnd.png
# Generate black text "© Duncan Idaho" and save as stamp_mask.png
convert -size 600x600 xc:black -pointsize 80 -gravity center -draw "fill white text 1,1 '© Duncan Idaho' text 0,0 '© Duncan Idaho' fill black text -1,-1 '© Duncan Idaho'" -alpha off stamp_mask.png
# Merge stamp_mask.png and stamp_fgnd.png and save as stamp.png
composite -compose CopyOpacity stamp_mask.png stamp_fgnd.png stamp.png
# Trim canvas size
mogrify -trim stamp.png
# Delete stamp_mask.png and stamp_fgnd.png
rm stamp_mask.png stamp_fgnd.png
# Place watermark: stamp.png onto subject image: test.jpg
composite -gravity south -geometry +0+10 stamp.png test.jpg wmark_text_stamped.jpg
