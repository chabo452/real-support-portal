# ECプロジェクト構成

## ディレクトリ構造
ecshop-project-online/
├── lp/index.html
├── pitch/index.html, slides.md
├── styles/app.css
├── assets/images/, videos/
├── data/products.csv
├── config/settings.json
├── logs/build-YYYYMMDD.log
├── archive/pitch-YYYYMMDD.zip
├── reveal.js/
└── deploy.ps1

## 運用手順
1. PowerShellを管理者で実行
2. ポーズ表示でGitHubブランチ切替（gh-pages）
3. 10分程度待機で公開
