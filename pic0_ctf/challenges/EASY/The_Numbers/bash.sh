#!/bin/bash

for i in $(cat the_numbers.txt); do
	# Check if the input is a number (integer)
	if [[ "$i" =~ ^[0-9]+$ ]]; then
		res=$((97 + i -1))
		printf "\\$(printf '%03o' "$res")"
	else
		# not a int 
		printf "%s" "$i"
	fi
done
