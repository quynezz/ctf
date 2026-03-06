**Description:** This is a really weird text file. Can you find the flag? Get the flag from TXT.

**Topic:** Forensics 

First i checked the file with `strings` command to print out the printable character of the `flag.txt` file

```bash
string flag.txt
```
Then i saw a beginning of the file, it said `IHDR`, which is a format of a png file

Check agagin with `files` command to check the type of file 

```bash 
files flag.txt
```

Then it showed the current txt file is typed as a png file. So i changed the `flag.txt` into `flag.png` by `mv` command and `eog` it

```bash
mv flag.txt flag.png && eog flag.png
```

And we have the flag: 

**Flag:** `picoCTF{now_you_know_about_extensions}
`


