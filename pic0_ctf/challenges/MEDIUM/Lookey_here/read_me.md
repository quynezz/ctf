**Description:** This file contains more than it seems. Get the flag from garden.jpg.

**Topic:** Forensic

First we need to download the file from the problem first 

```bash
wget https://artifacts.picoctf.net/c/126/anthem.flag.txt
```
Check the file type 

```bash 
file anthem.flag.txt
```
Trynna `cat` it and `grep` for flag 

```bash
cat anthem.flag.txt | grep -oE "picoCTF{.*}"
```
And we have the flag: 

**Flag:** `picoCTF{gr3p_15_@w3s0m3_2116b979}`
