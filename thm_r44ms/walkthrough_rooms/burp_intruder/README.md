# thm burp intruder walkthrough

**Burp Suite: Intruder**

![1](./img/1.png)

![2](./img/2.png)

Trước hết phải bật intercept lên đã -> để có thể đứng giữa và modify request

![3](./img/3.png)

Nhập vào hai trường ở form login mà bạn muốn modify

![4](./img/4.png)

Sau đó chúng ta send nó đến intruder để tiến hành thay đổi các trường trong một request

Như bạn đã thấy thì ở đây có hai trường, **username**  và **password**

![5](./img/5.png)

Tiến hành nhấn **add** để có thể thay thế giá trị cho hai trường đó với payload mà mình muốn

![6](./img/6.png)

Chọn kiểu tấn công mà mình muốn đối với hai trường giá trị đó, như ở đây mình dùng **Pitchfork attack** (phương thức tấn công song song, dùng value1 của payload 1 để thay vào giá trị 1 và dùng giá trị 1 của payload 2 để gán vào giá trị 2)

![7](./img/7.png)

Chọn wordlist tương ứng với position

![8](./img/8.png)



![9](./img/9.png)

![10](./img/10.png)

Sau đó nhấn **attack**

![11](./img/11.png)

Để ý kỹ thì status code sẽ trả về 302 cho mọi request nên mình sẽ chú ý vào độ dài của response để so sánh đâu là payload thành công

![12](./img/12.png)

Tiếp theo, đến với kiểu tấn công cho IDOR(Insecure Direct Object Reference), tận dụng việc có thể modify query -> chúng ta có thể xem được nhiều hơn là các ticket hiện đang có

![13](./img/13.png)

Cũng tiếp tục bắt request và send nó vào intruder để thay thế với payload của mình

![14](./img/14.png)





![15](./img/15.png)

Tạo một file txt trong đó có value từ 1 - 100 để check

![16](./img/16.png)

Ta nhận thấy được 4 value trả về response code là 200 -> trong đó có ba id thì đã có sẵn và một id lạ với value là **83**

![17](./img/17.png)

Và test thử thì đúng thật, chúng ta đã tìm được flag

![18](./img/18.png)

![19](./img/19.png)

Còn phần này thì làm rồi mà quên chụp =)), nói chung thì tìm hiểu về Burp marco để có thể bắt được CSRF token và thêm nó vào với các payload của mình.

![20](./img/20.png)

