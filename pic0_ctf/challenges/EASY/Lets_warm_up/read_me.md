**Description:** If I told you a word started with 0x70 in hexadecimal, what would it start with in ASCII?

**Topic:** General Skills

Run the below bash command

```bash 
#!/bin/bash
res=$(printf "%d\n" 0x70) 
echo "picoCTF{$(printf "\\$(printf '%03o' "$res")")}"
```
And we have the flag:
**Flag:** `picoCTF{p}`
