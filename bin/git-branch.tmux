#!/bin/bash
dir=$(pwd)
if [ -n "$1" ]
then
    dir="$1"
fi
pushd "$dir" >/dev/null 2>&1|| exit
if git branch --show-current >/dev/null 2>&1
then
    full_branch=$(pushd "$1" >/dev/null 2>&1 && git branch --show-current)
    just_branch=${full_branch##*/}
    branch=${just_branch:0:20}
    open_color="#[fg=green,bold]"
    sep_color="#[fg=white,bold]"
    if [[ "$branch" =~ (master|main) ]]
    then
        open_color="#[fg=red,bold]"
    fi
    printf " %s{%s%s%s} " "$sep_color" "$open_color" "$branch" "$sep_color"
else
    printf " "
fi
