#!/usr/bin/env bash
img=$1
watermarked="$HOME/vista.vallarta/watermarked"
# Create the directory if it doesn't exist
[ -d "$watermarked" ] || mkdir -p "$watermarked"
# Grab the resolution
resolution=$(gm identify "$img" | awk '{print $3}' |awk -F'+' '{print $1}')
# Just the x
x=$(echo "$resolution" | awk -Fx '{print $1}')
# Just the y
y=$(echo "$resolution" | awk -Fx '{print $2}')
# Our watermark
watermark_big="$HOME/vista.vallarta/watermark_big.png"
[ -f "$watermark_big" ] || {
    echo "Can't find $watermark_big, bailing" >&2
    exit 2
}

watermarked_img="$watermarked/$img"
# Draw the watermark on the image
gm convert -gravity center -geometry +0+0 -draw "image Over 0,0 $x,$y '$watermark_big'" "$img" "$watermarked_img"
echo "Wrote $watermarked_img"
