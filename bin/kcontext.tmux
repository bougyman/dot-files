#!/bin/bash
kcontext() {
  kubectl config current-context | awk '
    {
      n=split($1,arr,"-")
      if(n == 1) {
          print $1
          next
      }
      if(n == 2) {
        print arr[n-1]"-"arr[n]
      } else {
        print arr[2]"-"arr[3]
      }
    }'
}

output_kcontext() {
    ctx=$1
    case "$ctx" in
        *prod*)
            echo "#[fg=red,bold]#[bg=default]$context"
            ;;
        *load*)
            echo "#[fg=pink,bold]#[bg=default]$context"
            ;;
        *stg*)
            echo "#[fg=yellow,bold]#[bg=default]$context"
            ;;
        *stag*)
            echo "#[fg=yellow,bold]#[bg=default]$context"
            ;;
        *dev*)
            echo "#[fg=green,bold]#[bg=default]$context"
            ;;
        *)
            echo "#[fg=cyan,bold]#[bg=default]$context"
            ;;
    esac
}
context=$(kcontext)
if [ $? -eq 0 ]
then
    output_kcontext "$context"
fi
