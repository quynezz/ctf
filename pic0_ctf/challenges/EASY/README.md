# Pico challenge: WebDecode #
### Level: <span style="color:green">Easy</span>

## Challenge Description

*Do you know how to use the **web inspector** ?
Additional details will be available after launching your challenge instance.*

## Solution

Đầu tiên, truy cập vào trang web của challenge, ta sẽ thấy một giao diện khá là đơn giản =V không có gì ngoài dòng treaky **KeepNavigating**

![web_1](./image/img_1.jpg)

quá dễ để ta có thể nhận ra từ dòng chữ "web inspector" rằng ta cần phải sử dụng công cụ Developer Tools (DevTools) của trình duyệt web để giải mã cùng với dòng KeepNavigating kia (đồng nghĩa là dòng "decoded flag" không có ở trang hiện tại).

![web_2](./image/img_2.jpg)

navigate tới trang contac thì nó lại hiện một dòng quá obvious =)), "Try ínpecting the page ....". Vì thế ta có thể bắt đầu inspect element của trang này và tìm được một dòng base64 encoded string trong thẻ section.

![web_3](./image/img_3.jpg)

giải mã chuỗi base64 này ta sẽ được đoạn flag như trong hình dưới đây:

![web_4](./image/img_4.jpg)

**🏴󠁧󠁢󠁷󠁬󠁳󠁿FLAG: picoCTF{web_succ3ssfully_d3c0ded_df0da727}**









