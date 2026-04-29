**Bunch of nested encrypting method** 

i wrote a `one-liner script` for this in bash so you won't do it in cyberchef mannually.

```bash
#!/usr/bin/env bash

file='./message.txt'

# decode base64 -> turn hex into ascii (which the result will be url-encoded) -> decode url-encoded -> decode rot13 -> FLAG
flag=$(cat $file | base64 -d | xxd -r -p | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));" | tr "$(echo -n {A..Z} {a..z} | tr -d ' ')" "$(echo -n {N..Z} {A..M} {n..z} {a..m} | tr -d ' ')")

# echo out the flag
echo $flag
```
FLAG: `picoCTF{nested_enc0ding_66b54257}`
