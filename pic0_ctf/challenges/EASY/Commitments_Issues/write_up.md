wget the file ->

```bash
wget <file>

unzip <file>

grep -oiEr "flag" .git/*

# and then we found a commit "3d5ec8a26ee7b092a1760fea18f384c35e435139"

git checkout 3d5ec8a26ee7b092a1760fea18f384c35e435139

cat message.txt
```

**FLAG**: `picoCTF{s@n1t1z3_30e86d36}`
