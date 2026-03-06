**Description:** The SOC team discovered a suspiciously large log file after a recent breach. When they opened it, they found an enormous block of encoded text instead of typical logs. Could there be something hidden within? Your mission is to inspect the resulting file and reveal the real purpose of it. The team is relying on your skills to uncover any concealed information within this unusual log. Download the encoded data here: Logs Data. Be prepared—the file is large, and examining it thoroughly is crucial .


**Topic:** Forensic

First we need to download the `logs.txt` first

```bash
wget https://challenge-files.picoctf.net/c_amiable_citadel/929daf6ef01bba32b165e0a7c649ff4c953f2af21c28b024e8af5276b7716de5/logs.txt
```
As i examine the `logs_file.txt` it a bunch of base64 encoded text

```bash 
file logs.txt  

### 

tail -n 2 logs.tt

```
After decoded,

```bash 
cat logs.txt| base64 --decode > flag

```
I check the file format again and it said:

```bash
└─$ file flag    
flag: PNG image data, 896 x 1152, 8-bit/color RGB, non-interlaced
```
Open the image -> we see a script kiddie (me) and a strings of hex numbers 

![](./image.png)

```bash 
echo "7069636F435446467B666F72656E736963735F616E616C797369735F69735F616D617A696E675F65633139383466637D" | xxd -r -p
```
And we have the flag: 

**Flag:** `picoCTF{forensics_analysis_is_amazing_ec1984fc}`
