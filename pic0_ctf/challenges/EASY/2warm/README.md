**Description:** Can you convert the number 42 (base 10) to binary (base 2)?

```bash 
# convert automatically in bash command and yank it into clipboard
echo "picoCTF{$(obase=2; 42) | bc}" | xlip
```
**Flag**: `picoCTF{101010}`
