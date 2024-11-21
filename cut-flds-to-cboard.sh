#!/bin/sh

# Here using "cut" it is necessary to use Ansi C quoting for --output-delim=tab:
#   https://www.gnu.org/software/bash/manual/html_node/ANSI_002dC-Quoting.html
# Credit: https://unix.stackexchange.com/questions/35369/how-to-define-tab-delimiter-with-cut-in-bash
# "cut" assumes input field seps are tabs. Output below: fields 1 and 4

#xclip -o -sel c|cut -f 1,4 --output-d=$'\t'|xclip -i -sel c
#On Mac 2024-11-18
output="$(pbpaste|cut -f 2|sed -E 's/ (\| )*(Age )*[0-9]*$//g'
printf "$output"|pbcopy

#= = = = = = = = = 
# Another way to achieve this using awk:
#xclip -o -sel c|gawk -F '\t' -v OFS='\t' '{print $1 OFS $4}'|xclip -i -sel -c

