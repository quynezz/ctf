**Description**: I wrote you a song. Put it in the picoCTF{} flag format.

**Topic**: General Skills 

First, let's download the song file 
```bash
wget https://challenge-files.picoctf.net/c_fickle_tempest/bc2c7a0f35011244188f5baa68570c069372182a12d9416654d5593b48570a16/lyrics.txt
```
Again, look at some of the keywords like `shout it`,... immidiately think of `Rockstar` programming language. Went to this website to decode the lyrics 

![Link](https://codewithrockstar.com/online) 

And the have array of decimals 

```bash
114
114
114
111
99
107
110
114
110
48
49
49
51
114
```
Decode with `Cyberchef` with the `recipe` is `From Decimal` and the `Delimiter` is `Line feed`, we have 

```bash
rrrocknrn0113r
```
Wrap it around the format and we have the flag:

**Flag** `picoCTF{rrrocknrn0113r}`

