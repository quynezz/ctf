follow the instruction in `README.md` file 

```bash
# MyGit
### If you want the flag, make sure to push the flag!

Only flag.txt pushed by ```root:root@picoctf``` will be updated with the flag.

GOOD LUCK!
```

```bash 
# check the current git branch (master)
git branch
git config user.name "root"
git config user.email "root@picoctf"
# create a file name 'flag.txt'
echo 1 > flag.txt
git status && git add . && git commit -m "done" && git push origin master
```

```bash
** WARNING: connection is not using a post-quantum key exchange algorithm.
** This session may be vulnerable to "store now, decrypt later" attacks.
** The server may need to be upgraded. See https://openssh.com/pq.html
git@foggy-cliff.picoctf.net's password:
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 2 threads
Compressing objects: 100% (2/2), done.
    Writing objects: 100% (3/3), 270 bytes | 270.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
    remote: Author matched and flag.txt found in commit...
    remote: Congratulations! You have successfully impersonated the root user
    remote: Here's your flag: `picoCTF{1mp3rs0n4t4_g17_345y_367122f4}`
    To ssh://foggy-cliff.picoctf.net:59684/git/challenge.git
    39ba833..0ba8ce2  master -> master
    ```
