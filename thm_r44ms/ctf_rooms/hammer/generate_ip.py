import random

open("ip.txt", "w").writelines(
    ".".join(str(random.randint(0,255)) for _ in range(4)) + "\n"
    for _ in range(10000)
)

print("Done → random_ips.txt")
