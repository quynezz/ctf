#!/bin/bash

res=$(printf "%d\n" 0x70) 

echo "picoCTF{$(printf "\\$(printf '%03o' "$res")")}"
