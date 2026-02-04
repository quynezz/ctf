This box is kinda interesting thus quite easy. 

So first and foremost like everyother box, i ran the nmap scan 

```bash 
nmap -sVC -O -p- --min-rate 5000 -oN nmap.txt <target_ip> 
```
And we have the results 

```bash 
# Nmap 7.98 scan initiated Wed Feb  4 09:28:07 2026 as: /usr/lib/nmap/nmap --privileged -sVC -O -p- -T4 --min-rate 5000 -oN nmap.txt 10.48.135.212
Warning: 10.48.135.212 giving up on port because retransmission cap hit (6).
Nmap scan report for 10.48.135.212
Host is up (0.098s latency).
Not shown: 65436 closed tcp ports (reset), 96 filtered tcp ports (no-response)
PORT   STATE SERVICE VERSION
21/tcp open  ftp     vsftpd 3.0.3
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
| drwxrwxrwx    2 65534    65534        4096 Nov 12  2020 ftp [NSE: writeable]
| -rw-r--r--    1 0        0          251631 Nov 12  2020 important.jpg
|_-rw-r--r--    1 0        0             208 Nov 12  2020 notice.txt
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to 192.168.129.210
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 3
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
22/tcp open  ssh     OpenSSH 7.2p2 Ubuntu 4ubuntu2.10 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 b9:a6:0b:84:1d:22:01:a4:01:30:48:43:61:2b:ab:94 (RSA)
|   256 ec:13:25:8c:18:20:36:e6:ce:91:0e:16:26:eb:a2:be (ECDSA)
|_  256 a2:ff:2a:72:81:aa:a2:9f:55:a4:dc:92:23:e6:b4:3f (ED25519)
80/tcp open  http    Apache httpd 2.4.18 ((Ubuntu))
|_http-server-header: Apache/2.4.18 (Ubuntu)
|_http-title: Maintenance
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
```

As we see, the `ftp` port could login anonymously so we could exploit that. But first, we also see the port 80 `http` open so let inspect the web (nothing seem appear in the web) -> so i ran the `gobuster`

```bash 
gobuster dir -u <target_ip> -w /usr/share/wordlist/rockyou.txt -b 403,404 -o gobuster.txt
```
And i saw a `files` directory within the web server

![](./files_found_during_exploitation/1.png)
