#!/bin/sh

# Here using "cut" it is necessary to use Ansi C quoting for --output-delim=tab:
#   https://www.gnu.org/software/bash/manual/html_node/ANSI_002dC-Quoting.html
# Credit: https://unix.stackexchange.com/questions/35369/how-to-define-tab-delimiter-with-cut-in-bash
# Script purpose: Reformat spreadsheet data from two adjacent fields
#  for pasting directly into addressee field of mailing envelope.
# Example of target, source is congregation territory spreadsheet:
# "1112 Water Lily Dr Simpsonville, SC 29680[tab]John Resident | Age 75"
# "cut" assumes input field seps are tabs. Then "sed" output: fields 1 and 4 yield three address lines
# John Resident
# 1112 Water Lily Dr
# Simpsonville, SC 29680

# Note: xclip assumes X11 is in use on Linux OS.
#xclip -o -sel c|cut -f 1,4 --output-d=$'\t'|xclip -i -sel c

#On Mac 2024-11-18
# Capture the second field with name, "sed" removing if present: "Age | 75"
output="$(pbpaste|cut -f 2|sed -E 's/ (\| )*(Age )*[0-9]*$//g'
# "sed" inserts line break between street and city, state, zipl
# NOTE: Mac OS "sed" provides no way to insert "\n" in replacement regex.
#       Must provide a literal linebreak in the code, thus: "&/g" in regex on next line
pbpaste|cut -f 1|sed -E 's/(Simpsonville|Fountain Inn|Gray Court)/\
&/g')"
printf "$output"|pbcopy

#= = = = = = = = = 
# Another way to achieve this using awk:
#xclip -o -sel c|gawk -F '\t' -v OFS='\t' \
# '{ \
#    sub(/(Simpsonville|Fountain Inn|Gray Court, 296[48][045])/\
print $1 OFS $4}'|xclip -i -sel -c

