**Description:** This file contains more than it seems. Get the flag from garden.jpg.

**Topic:** Forensic

First we need to download the image from the problem first 

```bash
wget https://challenge-files.picoctf.net/c_fickle_tempest/ae74cbed5077635927f22095db7234ef717013f25d893a6993e4418696e586f0/garden.jpg
```
It seem like a normal image like usual :) 

![image1](./garden.jpg)

using `strings` to extract the printable character of an image, and at the end of the sentences i saw a flag

`
...
={~5
h--@3
cZi-
M(.I
]hWP&
jc#k
=7g&
mjx/
s\]|."Ue
\qZf
Here is a flag: picoCTF{more_than_m33ts_the_3y395e12915}
`

A little bit of bash magic 

```bash
strings garden.jpg | tail -n 1 | cut -d ":" -f2
```

And we have the flag: 

**Flag:** `picoCTF{more_than_m33ts_the_3y395e12915}`
