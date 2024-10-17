#!/usr/bin/env bash
outdir=$1
: "${outdir:=/mnt/passcrypt/data/archived}"
if [ ! -d "$outdir" ]
then
    printf "Directory %s does not exist, creating\n" "$outdir"
    if ! mkdir -vp "$outdir"
    then
        printf "Failed to create directory %s\n" "$outdir"
        exit 1
    fi
fi
while read -r f
do
    first=${f%%_*}
    base=$(basename "$first")
    just_base=$(basename "$f")
    dir=$(echo "$base" | sed -e 's/^teamskeet//' )
    echo Just Base: "$just_base"
    if [[ "$just_base" =~ ^[A-Z].*\.mp4 ]]
    then
        dir=21sextury
    elif [[ "$base" =~ ^[a-zA-Z0-9]+[0-9]x[0-9]\-[0-9]\.mp4 ]]
    then
        dir=chickpass/$(echo "$base" | ruby -ne 'puts $_.sub(/^([a-zA-Z]+)\d+x\d-\d\.mp4/, "\\1")')
    fi
    full_dir="$outdir/$dir"
    if [ ! -d "$full_dir" ]
    then
        mkdir -vp "$full_dir" || exit 22
    fi
    mv -v "$f" "$full_dir/"
done
