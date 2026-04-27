**Description:** Your mission is to enter Dr. Evil's laboratory and retrieve the blueprints for his Doomsday Project. The laboratory is protected by a series of locked vault doors. Each door is controlled by a computer and requires a password to open. Unfortunately, our undercover agents have not been able to obtain the secret passwords for the vault doors, but one of our junior agents obtained the source code for each vault's computer! You will need to read the source code for each level to figure out what the password is for that vault door. As a warmup, we have created a replica vault in our trainingfacility. The source code for the training vault is here: **VaultDoorTraining.java**

**Topic:** Reverse Engineering

First we need to download the image from the problem first 

```bash
wget https://challenge-files.picoctf.net/c_fickle_tempest/894d84f5b5e66228fa8e422d898a42adf4fd8298aa8d322decaf9b172ba276ea/VaultDoorTraining.java
```
A little bit of bash magic 

```bash
echo "picoCTF{$(cat VaultDoorTraining.java | grep -oE "w4.*" | cut -d '"' -f1)}"
```

And we have the flag: 

**Flag:** `picoCTF{w4rm1ng_Up_w1tH_jAv4_000HPpgh7Ph}`


