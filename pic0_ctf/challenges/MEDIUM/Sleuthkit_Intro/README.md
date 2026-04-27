**Description:** This file contains more than it seems. Get the flag from garden.jpg.

**Topic:** Forensic

First we need to download the disk image from the problem first

```bash
wget https://artifacts.picoctf.net/c/164/disk.img.gz
```
Unzip it with `gunzip` and run

```bash
mmls disk.img
```

The size of Linux partition is **202752**

Start TCP connection with `nc`

```bash
nc saturn.picoctf.net 53740
```

And we have the flag:

**Flag:** `picoCTF{mm15_f7w!}`
