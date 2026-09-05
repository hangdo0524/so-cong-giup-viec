---
title: Sổ Công Giúp Việc
type: app
status: live
authors:
  - date: 2026-09-05
    email: "hang.do@difisoft.com"
    change: "Khởi tạo app chấm công giúp việc theo giờ — lịch tháng, hệ số lễ/cận Tết, nhận xét từng buổi, sổ trả lương; kèm hướng dẫn build và deploy"
---

# Sổ Công Giúp Việc

Web chấm công cho người giúp việc trả theo giờ. Làm ngày nào tính tiền ngày đó, trả công một lần vào cuối tháng.

## Tính năng

- **Lịch tháng** — chạm 1 lần vào ngày để chấm công theo số giờ mặc định (T2–T6: 3h, cuối tuần: 4h). Chạm lại để mở bảng chi tiết.
- **Giờ vào / giờ ra** — ghi giờ bắt đầu và kết thúc, tự tính số giờ.
- **Hệ số** — thường ×1, ngày lễ ×1.2, 10 ngày cận Tết ×1.5. Sửa được trong Cài đặt.
- **Nhận xét từng buổi** — đánh giá tốt / bình thường / chưa đạt kèm ghi chú.
- **Sửa ngày quá khứ** — mở lại bất kỳ ngày nào để chỉnh hoặc xoá.
- **Sổ trả lương** — ghi từng lần trả, theo dõi còn thiếu bao nhiêu.
- **Tổng quan các tháng** — luôn hiện tháng hiện tại; bấm vào một tháng để nhảy tới tháng đó.

Đơn giá và hệ số được **chốt lại tại thời điểm chấm công**. Sửa đơn giá trong Cài đặt chỉ ảnh hưởng các buổi chấm sau đó, không tính lại quá khứ.

## Hai bản

| Bản | Nơi chạy | Dữ liệu |
|-----|----------|---------|
| `index.html` | Claude Artifact (fragment, được bọc sẵn `<head>`/`<body>`) | Đồng bộ cloud — mở trên điện thoại và máy tính đều thấy chung |
| `docs/index.html` | GitHub Pages / mở trực tiếp bằng trình duyệt | `localStorage` — mỗi máy một sổ riêng, **không đồng bộ** |

## Build

```bash
./build.sh
```

Ghép `index.html` vào khung HTML đầy đủ và ghi ra `docs/index.html` — thư mục GitHub Pages phục vụ. Sửa code thì sửa trong `index.html` rồi chạy lại lệnh trên.

## Cấu trúc dữ liệu (cloud)

```
config/settings          { rate, hoursWeekday, hoursWeekend, multNormal, multPreTet, multHoliday, tetStart, ... }
shifts/YYYY-MM           { month, days: { "12": { hours, type, rate, mult, start, end, note, rating, review } } }
payments/YYYY-MM         { month, items: [ { id, date, amount, note } ] }
```
