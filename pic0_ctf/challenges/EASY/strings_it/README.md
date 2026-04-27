**Description:** Can you find the flag in file without running it?

**Topic**: General Skills

First we download the file  first 

`wget https://challenge-files.picoctf.net/c_fickle_tempest/094a1db42d5ae681cd9e513dcbea2d997495dd3763d50c643b939923ca86e29b/strings`

Then as the title mention about a command line function call `strings`, i imediately run the `strings` command  with alittle bit of greping to see if there is any flag format as `picoCTF{...}`

`strings strings | grep -oE "picoCTF{.*}"`

And we have the flag: 

**Flag:** `picoCTF{5tRIng5_1T_47948C73}
`
