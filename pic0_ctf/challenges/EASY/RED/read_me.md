**Description:** Kishor Balan tipped us off that the following code may need inspection: http://fickle-tempest.picoctf.net:63860

**Topic:** Web Exploitation

First, we download the `red.png` file by `wget`

```bash
wget https://challenge-files.picoctf.net/c_verbal_sleep/831307718b34193b288dde31e557484876fb84978b5818e2627e453a54aa9ba6/red.png
```

Check the file format again to see any breadcrumbs left ?

```bash
file red.png
```

Open the file with Gnome image opener to see what within the image but i had not seen anything yet

```bash
eog red.png
```

So we move to next step -> printout all of the printable strings of the `png` file and i saw a very weird poem

```bash
strings red.png | less
```

Use `zsteg` :) and found the base64 encoded flag within the image

```bash
zsteg red.png -b1
```

```txt

b1,r,lsb,xy         ..
b1,r,msb,xy         ..
b1,g,lsb,xy         ..
b1,g,msb,xy         ..
b1,b,lsb,xy         ..
b1,b,msb,xy         ..
b1,a,lsb,xy         ..
b1,a,msb,xy         ..
b1,rgb,lsb,xy       ..
b1,rgb,msb,xy       ..
b1,bgr,lsb,xy       ..
b1,bgr,msb,xy       ..
b1,rgba,lsb,xy      .. text: "cGljb0NURntyM2RfMXNfdGgzX3VsdDFtNHQzX2N1cjNfZjByXzU0ZG4zNTVffQ==cGljb0NURntyM2RfMXNfdGgzX3VsdDFtNHQzX2N1cjNfZjByXzU0ZG4zNTVffQ==c  Gljb0NURntyM2RfMXNfdGgzX3VsdDFtNHQzX2N1cjNfZjByXzU0ZG4zNTVffQ==cGljb0NURntyM2RfMXNfdGgzX3VsdDFtNHQzX2N1cjNfZjByXzU0ZG4zNTVffQ=="

b1,rgba,msb,xy      .. file: OpenPGP Public Key

b1,abgr,lsb,xy      ..
b1,abgr,msb,xy      ..

```

Decode the repeated lab and we have

```bash
echo "cGljb0NURntyM2RfMXNfdGgzX3VsdDFtNHQzX2N1cjNfZjByXzU0ZG4zNTVffQ==" | base64 -d
```

And we have the flag:

**Flag:** `picoCTF{r3d_1s_th3_ult1m4t3_cur3_f0r_54dn355_}`
