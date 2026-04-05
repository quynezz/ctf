First, let's copy all of the file in the remote instances (because i can stand of the laggy movement when interact with the kernel :)

```bash
# do this on local machine -> not ssh machine
scp -P 61438 ctf-player@dolphin-cove.picoctf.net:\* .
```
and then we have these file

```bash
instructions.txt  part_aa  part_ab  part_ac  part_ad  part_ae

```


```txt
# instruction.txt
Hint:
- The flag is split into multiple parts as a zipped file.
- Use Linux commands to combine the parts into one file.
- The zip file is password protected. Use this "supersecret" password to extract the zip file.
- After unzipping, check the extracted text file for the flag.
```
so it very simple task, just concatenate all of the file and then unzip it with the super duper secret message to reveal the flag :)
-> i create a bash script to not do it manual.

```bash
#!/usr/bin/env bash

if [ -f flag.zip ]; then
    touch flag.zip
fi

cat part_a* >>flag.zip

# unzip and read the file
unzip -q -P "supersecret" flag.zip

flag="flag.txt"
if [ -f $flag ]; then
    cat flag
fi
```

and BOOM, we have the flag

`FLAG: picoCTF{z1p_and_spl1t_f1l3s_4r3_fun_2d6c5d3f}`

