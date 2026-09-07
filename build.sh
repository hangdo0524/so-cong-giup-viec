#!/usr/bin/env bash
# Gói index.html (fragment dùng cho Claude Artifact) thành docs/index.html chạy độc lập.
# Bản trong docs/ là bản GitHub Pages phục vụ — không có đồng bộ cloud,
# dữ liệu nằm trong localStorage của từng máy.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p docs
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
<script src="firebase-config.js"></script>
HEAD
  cat index.html
  printf '</body>\n</html>\n'
} > docs/index.html
[ -f docs/firebase-config.js ] || cp firebase-config.example.js docs/firebase-config.js
echo "→ docs/index.html ($(wc -c < docs/index.html) bytes)"
