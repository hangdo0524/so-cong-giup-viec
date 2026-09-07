#!/usr/bin/env bash
# Gói index.html (fragment dùng cho Claude Artifact) thành docs/index.html chạy độc lập.
# Bản trong docs/ nạp thêm firebase-config.js để lưu dữ liệu lên Firestore;
# chưa điền config thì chạy bằng localStorage của từng máy.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p docs
STAMP=$(date +%Y%m%d%H%M%S)   # đổi config xong là trình duyệt nạp lại ngay, không dính cache
{
  cat <<'HEAD'
<!doctype html>
<html lang="vi">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="theme-color" content="#0e1a15">
<meta name="description" content="Sổ chấm công giúp việc theo giờ: số buổi, hệ số lễ/cận Tết, nhận xét và lịch sử trả lương.">
<style>*{box-sizing:border-box}html,body{margin:0}body{font:14px/1.5 system-ui,-apple-system,"Segoe UI",Roboto,sans-serif;background:#f6f8f6}img{max-width:100%}[hidden]{display:none!important}</style>
HEAD
  printf '<script src="firebase-config.js?v=%s"></script>\n' "$STAMP"
  cat <<'HEAD2'
HEAD2
  cat index.html
  printf '</body>\n</html>\n'
} > docs/index.html
[ -f docs/firebase-config.js ] || cp firebase-config.example.js docs/firebase-config.js
echo "→ docs/index.html ($(wc -c < docs/index.html) bytes)"
