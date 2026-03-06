**Description:** Can you find the robots? http://fickle-tempest.picoctf.net:51529

**Topic:** Web Exploitation 

As the title mention too obvious, `robots.txt` is instruction file for whether which domain is disallowed or allowed for web crawler 

Change the subdomain the robots.txt and we will find a disallowed domain call `cc6b1.html`

`http://fickle-tempest.picoctf.net:51529`

Run the magic bash script 

```bash
curl http://fickle-tempest.picoctf.net:54183/cc6b1.html | grep -oE "picoCTF{.*}"
```
And we have the flag: 

**Flag:** `picoCTF{ca1cu1at1ng_Mach1n3s_cc6b1}`


