# CSVのURL
$csvUrl = "https://docs.google.com/spreadsheets/d/1L4cMgiOHxt9x5DWRH_RZH-uRxpAyBsIwUiSpxYM3zsI/export?format=csv&gid=0"

# 保存先パス
$outputPath = "C:\Users\user\Desktop\real-support-portal\original.csv"

# CSVをそのままバイト配列として取得
$response = Invoke-WebRequest -Uri $csvUrl -UseBasicParsing

# バイト配列として取得する場合はRawContentStreamを使うかContentをバイト配列に変換する必要あり
# ここではRawContentStreamから読み込む方法例
$stream = $response.RawContentStream
$reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::UTF8)
$content = $reader.ReadToEnd()
$reader.Close()

# UTF-8で書き込み（BOMあり）
[System.IO.File]::WriteAllText($outputPath, $content, [System.Text.Encoding]::UTF8)
