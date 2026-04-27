## KCSC CHRISTMAS OSINT GAME 2025 writeups

vô tình lướt qua được cái challenge này trên fb của KMA club nên mình chơi luôn xem sao

![Image_xin_chao](./img/hinh_anh_xin_chao.jpg)

như mọi lần OSINT, thì mình có thử scan **Sherlock** nhưng ko kiếm được gì, dorking một hồi thì cũng tìm được một quả youtube có date mới tạo gần đây nên click vào luôn.

![Image_1](./img/1.png)

có quả alime gơn nhảy nhót =V, để chắc hơn thì mình còn kiểm tra trong phần comment của video và cũng thấy vài bạn trong club comment nên đích thị là nó rồi =)). Lạ cái là nó chỉ có mỗi video trên với lại một **hidden video**  đang bị unavailable.


![Image_2](./img/2.png)

dùng **wayback machine** để check snapshot của video đã bị ẩn.

![Image_4](./img/4.png)

đường link của video bị ẩn 👇

![Image_3](./img/3.png)


mình check thì có hai date cách rời nhau, khỏi cần check snap của ngày 23 nên mình quyết định click 20 luôn cho nhanh

![Image_5](./img/5.png)

snapshot dẫn tới một đường link chứa video trước khi bị ẩn, ở phần description có part thứ 1, kèm với dòng breadcrumb hint cho part tiếp theo.

```bash
Part 1: KSCS{cHuC_C4c_b4n
```

![Image_6](./img/6.png)

đoạn breadcrumb đó laf một mã base64, sau khi decode ra thì mình được một đường dẫn tới một website để up và share file

![Image_7](./img/7.png)

![Image_8](./img/8.png)

soi một hồi thì mình thấy chữ học viện kèm với hint location là toạ lạc ở **Hà Nội** nên trong đầu nảy nhanh đến google map =)))

![Image_9](./img/9.png)

check cơ sở KMA ở hà nội

![Image_10](./img/10.png)

soi ở phần review gần nhất thì mình thấy một user đang kèm ảnh với video khá giống với video trong website trước kèm với dòng part 2


![Image_11](./img/11.png)

```bash
Part 2: _614n6_51nh_Vu1
```

![Image_12](./img/12.png)

Tra tiếp tên của user đã đăng review **Kchristmas8386** (có thể dork hoặc dùng các trang social osint khác) thì mình tìm được một trang github khớp với tên user đó cũng vừa mới tạo thời gian gần đây.

Có một repo duy nhất với tên **study**, có một đoạn script encode XOR và file readme.

Trong đoạn code đã update hiện tại thì không có gì nên mình quyết định check commit history thì trúng ngay part 3 đang nằm sẵn trong code kèm với đoạn mã hex đã bị **mã hoá**.

![Image_13](./img/13.png)

```bash
Part 3: _v3_l3u_l3U_m4y_b4n
```
![Image_17](./img/17.png)

Mình tiếp tục viết 1 đoạn code để decode mã hex bị XOR encoded thì ra được một đoạn text ngắn kèm dòng plaintext.txt. Không chần chừ (PK ở trước dòng text kèm với file txt) thì nó chắc chắn là một đoạn **binary code** của file **ZIP**.

Lưu về máy và unzip ra thôi :v

Bên trong có một *đường dẫn youtube* ở đầu file plaintext (hint cho part 5)=]] cái này thì chắc bạn giải tới đây thì tự click vào nó đi nha =]]

![Image_19](./img/19.png)

Kéo xuống tít ở dưới thì mình có thấy thêm một dòng breadcrumb cho part tiếp theo


![Image_20](./img/20.png)

Đang xài github luôn (cũng dùng gmail), nên mình thêm dòng `.path`  vào cuối file commit để check tài khoản mail thì đúng thật, có một tài khoản mail lạ với tên **lotusspeed2025**

![Image_21](./img/21.png)

Tiếp tục OSINT các nền tảng khác thì mình thấy một tài khoản ở tiktok được đăng ký với tên này (trùng khớp với cái breadcrumb hint).

![Image_22](./img/22.png)

Part 4 ngay trong phần chưng bày.

```bash
Part 4: _kh0n6_c0_ny
```

![Image_23](./img/23.png)

có một video được đang kèm với dòng hint quá obvious =)) nên mình quyết định google lens cái cái screenshot trong video (để có thủ tục) rồi tìm địa chỉ của cơ sở KMA thành phố Hồ  Chí Minh.

![Image_24](./img/24.png)

và đúng như mình suy đoán, toàn nhà VTC giống y hệt trong video =V.

![Image_25](./img/25.png)

lại tiếp tục lướt tới phần review của chi nhanh Hồ Chí Minh thì mình lại thấy một dòng ceasar cipher kèm với một đoạn mã base bị trộn lẫn.

![Image_26](./img/26.png)

Đoạn này lười chụp lại code quá =)) nói chung là nó shift <... ký tự> ở dòng text đầu thì mình shift y chang z với đoạn base ở dưới rồi decode base32 thì sẽ ra một đường dẫn file drive.

![Image_26.2](./img/26.2.png)

kèm hai file ảnh

![Image_28](./img/28.png)
![Image_26.1](./img/26.1.png)

tới khúc này mình bí =)) nên có hỏi chatgpt thì nó recommend đối chiếu hai ảnh (trùng hợp là đang decode XOR luôn)  nên mình tra google xem có cách nào XOR ảnh không thì đúng thật, có techique ấy thật và nó có hẳn một website để check diff của hai ảnh luôn.

![Image_27](./img/27.png)
![Image_29](./img/29.png)

ghép lại vào zoom lên với độ cỡ nhất định thì mình thấy dòng part 5 cuối cùng để ghép lại thành một flag hoàn chỉnh

![Image_30](./img/30.png)

```bash
Part 5: d1_ch0l_n03l_:3}
```


VÀ GHÉP TẤT CẢ LẠI TA ĐƯỢC FLAGGGGGGG 👇👇👇

```bash
KSCS{cHuC_C4c_b4n_614n6_51nh_Vu1_v3_l3u_l3U_m4y_b4n_kh0n6_c0_nyd1_ch0l_n03l_:3}
```



