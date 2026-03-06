**Description:** Kishor Balan tipped us off that the following code may need inspection: http://fickle-tempest.picoctf.net:63860

**Topic:** Web Exploitation

Inspect three file, html, css and js of the website and do the bash magic:

```bash
curl http://fickle-tempest.picoctf.net:64784/ | grep -oE  "picoCTF{.*" | cut -d " "-f1  
curl http://fickle-tempest.picoctf.net:64784/mycss.css | grep -oE "t3.*" | cut -d " " -f1
curl http://fickle-tempest.picoctf.net:64784/myjs.js | grep -oE "flag: .*" | cut -d " "-f2
```
And we have the flag: 

**Flag:** `picoCTF{tru3_d3t3ct1ve_0r_ju5t_lucky?302945a7}`
