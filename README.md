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
---

# Sổ Công Giúp Việc

Web chấm công cho người giúp việc trả theo giờ. Làm ngày nào tính tiền ngày đó, trả công một lần vào cuối tháng.

## Tính năng

- **Lịch tháng** — chạm 1 lần vào ngày để chấm công theo số giờ mặc định (T2–T6: 3h, cuối tuần: 4h). Chạm lại để mở bảng chi tiết.
- **Giờ vào / giờ ra** — ghi giờ bắt đầu và kết thúc, tự tính số giờ.
- **Hệ số** — thường ×1, ngày lễ ×1.2, 10 ngày cận Tết ×1.5. Sửa được trong Cài đặt.
- **Nhận xét từng buổi** — đánh giá tốt / bình thường / chưa đạt kèm ghi chú.
- **Ngày quá khứ được khoá** — ngày đã qua mà đã chấm công thì chạm trên lịch chỉ **mở bảng chi tiết**, không bỏ chấm nữa. Muốn sửa hoặc xoá phải làm trong bảng chi tiết. Ngày hôm nay và ngày sắp tới vẫn chạm lại để bỏ chấm nhanh.
- **Sổ trả lương** — ghi từng lần trả, theo dõi còn thiếu bao nhiêu.
- **Tổng quan các tháng** — luôn hiện tháng hiện tại; bấm vào một tháng để nhảy tới tháng đó.

Đơn giá và hệ số được **chốt lại tại thời điểm chấm công**. Sửa đơn giá trong Cài đặt chỉ ảnh hưởng các buổi chấm sau đó, không tính lại quá khứ.

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

`docs/firebase-config.js` **không nằm trong `.gitignore`** — các khoá này công khai được, Firebase thiết kế như vậy. Phần chặn nằm ở `firestore.rules` cộng với mã sổ.

### Mã sổ và chia sẻ giữa các thiết bị

Lần đầu mở, app sinh một mã ngẫu nhiên 26 ký tự và gắn vào link dạng `…/#s=<mã>`. Toàn bộ dữ liệu của sổ nằm dưới `books/<mã>/` trong Firestore.

Muốn điện thoại và máy tính chung một sổ: mở **Cài đặt → Liên kết thiết bị → Chép**, rồi mở đúng link đó trên máy kia.

**App không có đăng nhập** — ai có link là đọc và sửa được sổ. Mã sổ dài nên không mò ra được, nhưng đừng đăng link công khai.

## Build

```bash
./build.sh
```

Ghép `index.html` vào khung HTML đầy đủ và ghi ra `docs/index.html` — thư mục GitHub Pages phục vụ. Sửa code thì sửa trong `index.html` rồi chạy lại lệnh trên.

## Cấu trúc dữ liệu (cloud)

Trên Artifact là đường dẫn gốc; trên Firestore thì thêm tiền tố `books/<mã sổ>/`.

```
config/settings          { rate, hoursWeekday, hoursWeekend, multNormal, multPreTet, multHoliday, tetStart, ... }
shifts/YYYY-MM           { month, days: { "12": { hours, type, rate, mult, start, end, note, rating, review } } }
payments/YYYY-MM         { month, items: [ { id, date, amount, note } ] }
```
