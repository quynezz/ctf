**Description**: Can you find the flag in the file? This would be really tedious to look through manually, something tells me there is a better way.

```bash 
strings file | grep -oE "picoCTF{.*}"
```
**Flag**: `picoCTF{grep_is_good_to_find_things_eb80073D}`


