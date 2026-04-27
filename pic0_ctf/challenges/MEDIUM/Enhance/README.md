**Description:** Download this image file and find the flag.

`Download image file`

**Topic:** Forensic

First we need to download the disk image from the problem first

```bash
wget https://artifacts.picoctf.net/c/101/drawing.flag.svg
```

Strings in the image file

```bash
strings drawing.flag.svg | less
```

And run
```bash
strings drawing.flag.svg | grep "</tspan>"  | cut -d "<" -f1 | cut -d ">" -f2 | tr -d "\n" | tr -d " "
```

And we have the flag:

**Flag:** `picoCTF{3nh4nc3d_24374675}`
