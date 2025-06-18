# CSVのURL
$csvUrl = "https://docs.google.com/spreadsheets/d/1L4cMgiOHxt9x5DWRH_RZH-uRxpAyBsIwUiSpxYM3zsI/export?format=csv&gid=0"

# 保存先パス
$outputPath = "C:\Users\user\Desktop\real-support-portal\original.csv"

# UTF-8 でバイナリ取得 → UTF8として読み込む
$response = Invoke-WebRequest -Uri $csvUrl -UseBasicParsing
$bytes = $response.Content
$utf8 = [System.Text.Encoding]::UTF8
$cleaned = $utf8.GetString([System.Text.Encoding]::GetEncoding("ISO-8859-1").GetBytes($bytes))

# UTF-8 with BOMで保存（VS Code / Excel / メモ帳OK）
[System.IO.File]::WriteAllText($outputPath, $cleaned, [System.Text.Encoding]::UTF8)
