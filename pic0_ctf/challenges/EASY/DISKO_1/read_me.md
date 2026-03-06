**Description:** Can you find the flag in this disk image? Download the disk image here. 

**Topic:** Forensic

First we need to download the image from the problem first 

```bash
wget https://artifacts.picoctf.net/c/537/disko-1.dd.gz
```
It an compress zip file -> `gunzip it to see any of the content within`

`gunzip disko-1.dd.gz`

We see a `disko-1.dd` type of file

Using the next step of every forensics problem that i would repeatedly do :) 

```bash 
strings disko-1.dd | grep -oE "picoCTF{.*}"
```
And we actually found the flag: 

**Flag:** `picoCTF{1t5_ju5t_4_5tr1n9_be6031da}`
