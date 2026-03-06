**Description**: Find the flag in this picture.

**Topic**: Forensics


```bash
wget https://challenge-files.picoctf.net/c_fickle_tempest/5a0c9a73ac940fb0369275fcf8600f02af2e8d732dd178e19ed8ea8f223d65db/pico_img.png
```
`Meta`? Immediately ran `strings` & exfiltool 

```bash 
strings pico_img.png | grep -oE "picoCTF{.*}
# OR 
exfiltool pico_img.png | grep -oE "picoCTF{.*}
```
And we have the flag:

**Flag** `picoCTF{s0_m3ta_ba6c953a}`
