**Description:** This file contains more than it seems. Get the flag from garden.jpg.

**Topic:** Forensic

Download the file, unzip it and open the file within th `zip file` with:

```bash 
xxd 86b265d37d1fc10b721a2accae04a60d
```
Grep for the flag: 

```bash 
xxd 86b265d37d1fc10b721a2accae04a60d | grep -oE "FLAG.*"
```
And we have the flag: 

**Flag:** `FLAG-ggmgk05096.`


