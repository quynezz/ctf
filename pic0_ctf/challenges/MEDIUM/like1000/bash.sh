#!/bin/bash

# Define the starting number
current_num=1000

while [ $current_num -ge 1 ]; do
	filename="${current_num}.tar"

    # Check if the specific file exists
    if [ -f "$filename" ]; then
	    echo "Extracting $filename..."

	# Extract it
	tar -xf "$filename"

	# Remove the one we just extracted
	rm "$filename"

	# Move to the next number down
	((current_num--))
else
	echo "Finished or $filename not found."
	break
    fi
done

echo "Final extraction complete."
