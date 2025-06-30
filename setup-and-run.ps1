Write-Host "=== スクリプト再生成＆実行 開始 ==="

# パス定義
$baseDir = "$env:USERPROFILE\Desktop\real-support-portal"
$scriptPath = "$baseDir\update-csv.ps1"

# 既存スクリプト削除
if (Test-Path $scriptPath) {
    Remove-Item $scriptPath -Force
    Write-Host "✅ 古い update-csv.ps1 を削除しました"
}

# スクリプト本文（日本語対応・BOMなし）
$scriptContent = @'
Write-Host "===== スクリプト開始 ====="

$csvUrl = "https://docs.google.com/spreadsheets/d/1L4cMgiOHxt9x5DWRH_RZH-uRxpAyBsIwUiSpxYM3zsI/export?format=csv&gid=0"
$dataDir = "$env:USERPROFILE\Desktop\real-support-portal\data"
$outputPath = "$dataDir\output.csv"

if (-not (Test-Path $dataDir)) {
    New-Item -ItemType Directory -Path $dataDir | Out-Null
}

if (Test-Path $outputPath) {
    Remove-Item $outputPath -Force
}

try {
    Invoke-WebRequest -Uri $csvUrl -OutFile $outputPath -UseBasicParsing
    Write-Host "✅ CSVダウンロード成功: $outputPath"
} catch {
    Write-Host "❌ ダウンロード失敗：" $_.Exception.Message
    exit 1
}

try {
    $content = Get-Content $outputPath -Raw
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($outputPath, $content, $utf8)
    Write-Host "✅ UTF-8変換完了"
} catch {
    Write-Host "❌ UTF-8変換失敗：" $_.Exception.Message
    exit 1
}

try {
    $csv = Import-Csv $outputPath
    if ($csv.Count -eq 0) {
        Write-Host "⚠️ CSVが空です"
    } elseif ($csv[0].PSObject.Properties.Name -contains "タイトル") {
        $firstRow = $csv | Select-Object -First 1
        $titleValue = $firstRow["タイトル"]  # ここを修正！
        Write-Host "✅ レコード数：$($csv.Count)"
        Write-Host "✅ 最初のタイトル：$titleValue"
    } else {
        Write-Host "⚠️ 'タイトル'列が見つかりません"
    }
} catch {
    Write-Host "❌ CSV読み込み失敗：" $_.Exception.Message
    exit 1
}

Write-Host "===== スクリプト終了 ====="
Read-Host "Enterキーを押して終了..."
'@

# BOMなしUTF-8で保存
$utf8 = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($scriptPath, $scriptContent, $utf8)
Write-Host "✅ update-csv.ps1 をUTF-8で再生成しました"

# 実行
Write-Host "🔁 PowerShellスクリプトを実行します..."
powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath

Write-Host "=== 完了 ==="
