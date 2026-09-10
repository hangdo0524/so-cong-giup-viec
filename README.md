---
title: Sổ Công Giúp Việc
type: app
status: live
authors:
  - date: 2026-09-05
    email: "hang.do@difisoft.com"
    change: "Khởi tạo app chấm công giúp việc theo giờ — lịch tháng, hệ số lễ/cận Tết, nhận xét từng buổi, sổ trả lương; kèm hướng dẫn build và deploy"
  - date: 2026-09-07
    email: "hang.do@difisoft.com"
    change: "Khoá ngày quá khứ đã chấm — chạm trên lịch chỉ mở chi tiết, muốn sửa hoặc xoá phải vào bảng chi tiết"
  - date: 2026-09-07
    email: "hang.do@difisoft.com"
    change: "Sửa responsive cho iPhone — bỏ tràn ngang, thu gọn lịch và bảng tổng quan, chặn iOS tự phóng to khi nhập"
  - date: 2026-09-07
    email: "hang.do@difisoft.com"
    change: "Thêm lưu trữ server bằng Firebase Firestore cho bản GitHub Pages, kèm mã sổ trong link để dùng chung giữa các thiết bị"
  - date: 2026-09-10
    email: "hang.do@difisoft.com"
    change: "Chấm công cho nhiều người trong một sổ, mỗi người một công việc và đơn giá riêng"
  - date: 2026-09-10
    email: "hang.do@difisoft.com"
    change: "Đăng nhập Google cho chủ sổ — sổ gắn với tài khoản thay vì chỉ dựa vào link, kèm quy trình bật trên Firebase Console"
  - date: 2026-09-10
    email: "hang.do@difisoft.com"
    change: "Tách giờ công và tiền công thành phần theo hợp đồng miệng và phần phát sinh thêm, mỗi buổi phát sinh có ô ghi lý do; giờ chuẩn tách riêng T7 và CN"
---

# Sổ Công Giúp Việc

Web chấm công cho người giúp việc trả theo giờ. Làm ngày nào tính tiền ngày đó, trả công một lần vào cuối tháng.

## Tính năng

- **Lịch tháng** — chạm 1 lần vào ngày để chấm công theo số giờ chuẩn của ngày đó (mặc định T2–T6: 3h, T7: 4h, CN: không nằm trong hợp đồng). Chạm lại để mở bảng chi tiết.
- **Giờ vào / giờ ra** — ghi giờ bắt đầu và kết thúc, tự tính số giờ.
- **Hệ số** — thường ×1, ngày lễ ×1.2, 10 ngày cận Tết ×1.5. Sửa được trong Cài đặt.
- **Nhận xét từng buổi** — đánh giá tốt / bình thường / chưa đạt kèm ghi chú.
- **Ngày quá khứ được khoá** — ngày đã qua mà đã chấm công thì chạm trên lịch chỉ **mở bảng chi tiết**, không bỏ chấm nữa. Muốn sửa hoặc xoá phải làm trong bảng chi tiết. Ngày hôm nay và ngày sắp tới vẫn chạm lại để bỏ chấm nhanh.
- **Tách giờ chuẩn và giờ phát sinh** — mỗi buổi chia làm hai phần: phần nằm trong hợp đồng miệng và phần dôi ra. Cả số giờ lẫn số tiền đều tách đôi, ở ô ngày trên lịch (`3+2h`), trong bảng chi tiết, ở phần tổng tháng, trong bảng tổng quan các tháng và trong bảng kê gửi Zalo.
- **Lý do giờ phát sinh** — buổi nào làm quá giờ chuẩn thì bảng chi tiết mở thêm ô lý do (gợi ý theo các lý do đã dùng). Bảng **Giờ phát sinh** liệt kê từng ngày kèm lý do; buổi chưa ghi lý do được đánh dấu đỏ để cuối tháng đối chiếu cho dễ.
- **Làm hụt không tính bù** — làm ít hơn giờ chuẩn thì chỉ tính giờ làm thật, app ghi rõ hụt bao nhiêu chứ không tự trừ hay bù sang ngày khác.
- **Sổ trả lương** — ghi từng lần trả, theo dõi còn thiếu bao nhiêu.
- **Tổng quan các tháng** — luôn hiện tháng hiện tại; bấm vào một tháng để nhảy tới tháng đó.
- **Nhiều người trong một sổ** — mỗi người một công việc, đơn giá và giờ chuẩn riêng; chọn người bằng dải chip ở đầu trang. Ngưng làm thì tạm ẩn, số liệu cũ vẫn còn.
- **Đăng nhập chủ sổ** (bản GitHub Pages) — sổ gắn với tài khoản Google, máy mới chỉ cần đăng nhập là thấy đủ số liệu.

Đơn giá, hệ số và **giờ chuẩn** đều được **chốt lại tại thời điểm chấm công**. Sửa trong *Sửa thông tin* chỉ ảnh hưởng các buổi chấm sau đó, không tính lại quá khứ.

Giờ chuẩn đặt riêng cho T2–T6, T7 và CN. Để **CN = 0** nghĩa là Chủ nhật không nằm trong hợp đồng — hôm nào làm thì tính hết là giờ phát sinh. Việc tách này chỉ đổi cách hiển thị, **tổng tiền không đổi**: `chuẩn + phát sinh = tổng` luôn đúng.

## Hai bản

| Bản | Nơi chạy | Dữ liệu |
|-----|----------|---------|
| `index.html` | Claude Artifact (fragment, được bọc sẵn `<head>`/`<body>`) | Kho dữ liệu của Artifact — đồng bộ sẵn giữa các thiết bị |
| `docs/index.html` | GitHub Pages / mở trực tiếp bằng trình duyệt | Firebase Firestore nếu đã cấu hình, chưa cấu hình thì `localStorage` từng máy |

App tự chọn: có `window.claude` thì dùng kho của Artifact, không thì tìm `window.FIREBASE_CONFIG`, không có nữa thì chạy offline bằng `localStorage`. Cả ba đi qua **cùng một lớp `wireCloud()`** nên phần còn lại của app không biết mình đang chạy trên nền nào.

## Bật lưu server cho bản GitHub Pages

1. Vào [console.firebase.google.com](https://console.firebase.google.com) → **Add project** → đặt tên (vd `so-cong-giup-viec`), tắt Google Analytics cho gọn.
2. Trong project → **Build → Firestore Database** → **Create database** → chọn vùng `asia-southeast1` (Singapore) → **Start in production mode**.
3. Tab **Rules** → dán nội dung [`firestore.rules`](firestore.rules) → **Publish**.
4. **Project settings** (bánh răng) → kéo xuống **Your apps** → bấm biểu tượng `</>` (Web) → đặt nickname → **Register app**. Màn hình hiện đoạn `firebaseConfig = {...}`.
5. Chép `firebase-config.example.js` thành `docs/firebase-config.js`, điền các giá trị vừa lấy, rồi commit.
6. **Build → Authentication** → **Get started** → tab **Sign-in method** → bật **Google** → chọn email hỗ trợ → **Save**.
7. Vẫn trong Authentication → tab **Settings → Authorized domains** → **Add domain** → thêm tên miền GitHub Pages (vd `hangdo0524.github.io`). `localhost` có sẵn.

`docs/firebase-config.js` **không nằm trong `.gitignore`** — các khoá này công khai được, Firebase thiết kế như vậy. Phần chặn nằm ở `firestore.rules` cộng với mã sổ.

### Mã sổ, đăng nhập và chia sẻ giữa các thiết bị

Lần đầu mở, app sinh một mã ngẫu nhiên 26 ký tự và gắn vào link dạng `…/#s=<mã>`. Toàn bộ dữ liệu của sổ nằm dưới `books/<mã>/` trong Firestore.

Bấm **nhãn đồng bộ** ở góc trên bên phải để mở **Tài khoản và đồng bộ** — nơi có nút đăng nhập, mã QR và link sổ.

Sổ có hai trạng thái:

| Trạng thái | Ai mở được | Khi nào |
|---|---|---|
| **Chưa có chủ** | ai cầm link | mặc định, như bản cũ |
| **Đã có chủ** | chỉ tài khoản chủ sổ | sau khi bấm *Nhận sổ này về tài khoản* |

Nhận sổ rồi thì link không còn đủ để mở — điện thoại quét mã QR xong vẫn phải đăng nhập cùng tài khoản. Đổi lại, máy mới chỉ cần đăng nhập là app tự tìm ra sổ (nhờ `users/<uid>`), không cần quét mã.

Sổ chưa ai nhận vẫn mở được bằng link, để không ai bị khoá ngoài sổ của chính mình trong lúc chưa kịp đăng nhập.

**Thứ tự triển khai** (đổi rules trước là tự khoá mình ra ngoài):

1. Deploy code mới lên Pages — lúc này đăng nhập là tuỳ chọn.
2. Bật Google sign-in + authorized domain trên Firebase Console (bước 6–7 ở trên).
3. Mở sổ trên máy tính → đăng nhập → **Nhận sổ này về tài khoản**.
4. Mở sổ trên điện thoại → đăng nhập cùng tài khoản → kiểm tra thấy đủ số liệu.
5. Xong xuôi mới dán `firestore.rules` mới vào tab **Rules** → **Publish**.

## Build

```bash
./build.sh
```

Ghép `index.html` vào khung HTML đầy đủ và ghi ra `docs/index.html` — thư mục GitHub Pages phục vụ. Sửa code thì sửa trong `index.html` rồi chạy lại lệnh trên.

## Cấu trúc dữ liệu (cloud)

Trên Artifact là đường dẫn gốc; trên Firestore thì thêm tiền tố `books/<mã sổ>/`.

```
config/settings              { people: [ { id, name, job, rate, hoursWeekday, hoursSat, hoursSun, active } ], multNormal, multPreTet, multHoliday, tetStart, ... }
shifts/YYYY-MM__<mã người>   { month, person, days: { "12": { hours, base, type, rate, mult, start, end, note, why, rating, review } } }
payments/YYYY-MM__<mã người> { month, person, items: [ { id, date, amount, note } ] }
```

Riêng bản Firestore có thêm hai chỗ nằm ngoài sổ:

```
books/<mã sổ>            { owners: { "<uid>": true } }      hồ sơ sổ — ai là chủ
users/<uid>              { books: [ "<mã sổ>", ... ] }      tài khoản này có những sổ nào
```

`hours` luôn là **tổng** giờ làm thật, `base` là giờ chuẩn chốt lúc chấm. App tự suy ra `chuẩn = min(hours, base)` và `phát sinh = hours − chuẩn`, nên hai phần cộng lại không bao giờ lệch tổng. `why` là lý do phần phát sinh.

Sổ bản cũ đánh khoá theo tháng (`2026-09`); mở bằng bản mới thì tự gán cho người đầu tiên (`2026-09__p1`). Buổi chấm trước khi có tính năng tách giờ chưa có `base` — app suy ra từ cài đặt lúc đọc, **không sửa dữ liệu cũ**; lần lưu lại sau đó mới ghi thêm. Người chỉ có `hoursWeekend` cũng tự đọc thành `hoursSat`.
