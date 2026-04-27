**Description:** The numbers... what do they mean? numbers.png

First we open the image file with 

```bash 
xdg-open numbers.png 
```

Then we'll see a combination of non-formatted range of number

Write it in a `the_numbers.txt` file and use the below command the split the ' ' character into '\n' for easily loop through the file

`sed -i 's/ /"\n"/g' the_numbers.txt`

![image](./the_numbers.png)

but it seem like ascii number but being modify by some math formula 

`real_number = 97 + (current_number - 1)`

```bash
#!/bin/bash

for i in $(cat the_numbers.txt); do
        # Check if the input is a number (integer)
        if [[ "$i" =~ ^[0-9]+$ ]]; then
                res=$((97 + i - 1))
                printf "\\$(printf '%03o' "$res")"
        else
                # not a int 
                printf "%s" "$i"
        fi
done
```
run 

`./bash.sh`

 and we have: 

**Flag:** `picoctf{thenumbersmason}`


