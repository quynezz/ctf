**Description**: There's something in the building. Can you retrieve the flag?

**Topic**: Forensics

First, we retreive the `buildings.png` image from the problem 

```bash
wget https://challenge-files.picoctf.net/c_fickle_tempest/c0eec6af0f04316e2bdc4a9f095afd0e2d0121f5e543dbc4a65bb0038d72a993/buildings.png
```
As we ran through the title, it seem like not really "something" in the building in the image, butthe image itself, so instantly think of **STEGANOGRAPHY** (a obfusication type of method to encodethe hidden data within the image). 

So we can whether run the `zsteg` command or go to online decode. 

```bash 
zsteg buildings.png | grep -oE "picoCTF{.*}
```
And we have the flag:

**Flag** `picoCTF{h1d1ng_1n_th3_b1t5}`
