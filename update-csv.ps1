Write-Host "===== 処理開始 ====="

$csvUrl = "https://docs.google.com/spreadsheets/d/1L4cMgiOHxt9x5DWRH_RZH-uRxpAyBsIwUiSpxYM3zsI/export?format=csv&gid=0"
$dataDir = "$env:USERPROFILE\Desktop\real-support-portal\data"
$outputPath = "$dataDir\output.csv"

# ディレクトリがなければ作成
if (-not (Test-Path $dataDir)) {
    New-Item -ItemType Directory -Path $dataDir | Out-Null
}

# 既存のoutput.csvを削除
if (Test-Path $outputPath) {
    Remove-Item $outputPath -Force
}

# CSVダウンロード
try {
    Invoke-WebRequest -Uri $csvUrl -OutFile $outputPath -UseBasicParsing
    Write-Host "✅ CSVをダウンロードしました： $outputPath"
} catch {
    Write-Host "❌ CSVダウンロード失敗: $($_.Exception.Message)"
    exit 1
}

# UTF-8 BOM付きで保存し直し
try {
    $content = Get-Content $outputPath -Raw
    $utf8Bom = New-Object System.Text.UTF8Encoding($true)
    [System.IO.File]::WriteAllText($outputPath, $content, $utf8Bom)
    Write-Host "✅ UTF-8 (BOM付き) で再保存しました"
} catch {
    Write-Host "❌ UTF-8変換失敗: $($_.Exception.Message)"
    exit 1
}

# CSV構造チェック
try {
    $csv = Import-Csv $outputPath
    if ($csv.Count -eq 0) {
        Write-Host "⚠️ CSVにデータがありません"
    } elseif ($csv[0].PSObject.Properties.Name -contains "職種") {
        $firstRow = $csv | Select-Object -First 1
        $titleValue = $firstRow["職種"]
        Write-Host "✅ レコード数: $($csv.Count)"
        Write-Host "✅ 職種: $titleValue"
    } else {
        Write-Host "⚠️ '職種'列が見つかりませんでした"
    }
} catch {
    Write-Host "❌ CSV読み込み失敗: $($_.Exception.Message)"
    exit 1
}

Write-Host "===== 処理終了 ====="
Read-Host "Enter を押すと終了します..."
