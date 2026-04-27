**Description:** Hi, intrepid investigator! 📄🔍 You've stumbled upon a peculiar PDF filled with what seems like nothing more than garbled nonsense. But beware! Not everything is as it appears. Amidst the chaos lies a hidden treasure—an elusive flag waiting to be uncovered.
Find the PDF file here Hidden Confidential Document and uncover the flag within the metadata.

**Topic:** Riddle Registry

First, we download the pdf file  with

```bash
wget https://challenge-files.picoctf.net/c_amiable_citadel/a8aa03694837741eed59c479749fc7f5bfd14fa66f4295b83776f16b2003a67d/confidential.pdf
```

Extract the content with `pdftotext`

```bash
pdftotext confidential.pdf
```

View the content of the file we see

```txt
Title: The Ultimate Guide to Flag Hunting
Welcome to the challenge!
Don’t worry, this might look like gibberish, but maybe there’s something hidden somewhere? I
spent so much time creating this PDF with care... or maybe not!

Here’s a Quick Story:
Once upon a time, in a land far, far away, there was a secret... But where could it be? Hidden
deep within the document? Maybe the text holds clues?
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante venenatis
dapibus posuere velit aliquet. Aenean lacinia bibendum nulla sed consectetur. Fusce dapibus,
tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet
risus. Curabitur blandit tempus porttitor. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
You thought this was important? Nah, it’s just random text. Keep looking. Or maybe, just
maybe, you’re in the wrong place?

Special Hidden Section:
The author have done a great and good job
Don’t bother trying to reveal the hidden text, it’s just nonsense anyway. Even if you somehow
manage to do it, all you’ll get is:
No flag here. Nice try though!

If you're still reading this, I’ll tell you a secret: the answer might not be here after all...

Good luck! You’ll need it!

```

Look at the **Special Hidden Section**, we see the hint *The author have done a great and good job*. Immediately think of metadata, ran

```bash
exiftool confidential.pdf
```


Ran this one (so you no need to find it :) )

```bash
 exiftool confidential.pdf | grep "Author" | cut -d ":" -f2 | base64 --decode
``````



And we have the flag:

**Flag:** `picoCTF{puzzl3d_m3tadata_f0und!_c2073669}`

