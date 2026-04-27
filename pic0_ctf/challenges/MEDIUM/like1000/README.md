**Description:** This .tar file got tarred a lot.

**Topic:** Forensics 

Firstly, let's download the tar file first.

`wget https://challenge-files.picoctf.net/c_fickle_tempest/96ad54735d25c18a159eb22cd408adc8dad73f855113b1b700a769d4fa9f2c10/1000.tar`

If we run 

```bash
tar -xf 1000.tar
```
it just continously subtract into 999.tar and so on. Because of that, let the bash magic do it work for us

```bash
#!/bin/bash

# Define the starting number
current_num=1000

while [ $current_num -ge 1 ]; do
        filename="${current_num}.tar"

    # Check if the specific file exists
    if [ -f "$filename" ]; then
            echo "Extracting $filename..."

        # Extract it
        tar -xf "$filename"

        # Remove the one we just extracted
        rm "$filename"

        # Move to the next number down
        ((current_num--))
else
        echo "Finished or $filename not found."
        break
    fi
done

echo "Final extraction complete."
```
`Untar` it till it reach 1 and no other tar file left and we will find a `flag.png`, open it 

```bash
eog flag.png
```
And we have the flag: 

**Flag:** `picoCTF{l0t5_0f_TAR5}`

