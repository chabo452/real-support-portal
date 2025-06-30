# 📁 パス設定
$projectRoot = "$env:USERPROFILE\Desktop\real-support-portal"
$inputPath   = "$projectRoot\data\original.csv"
$outputPath  = "$projectRoot\data\output.csv"
$htmlPath    = "$projectRoot\upload.html"
$dataPath    = "$projectRoot\data\jobData.js"

# 📌 HTMLに埋め込む区間
$startTag = "<!-- jobData.js START -->"
$endTag   = "<!-- jobData.js END -->"

# ✅ original.csv → output.csv（UTF-8 BOM付きで保存）
try {
    if (-Not (Test-Path $inputPath)) {
        Write-Host "❌ original.csv が見つかりません：" $inputPath
        exit 1
    }
    $content = Get-Content $inputPath -Raw
    $utf8Bom = New-Object System.Text.UTF8Encoding($true)
    [System.IO.File]::WriteAllText($outputPath, $content, $utf8Bom)
    Write-Host "✅ CSV 変換完了（BOM付き）：" $outputPath
} catch {
    Write-Host "❌ CSV変換エラー：" $_.Exception.Message
    exit 1
}

# ✅ jobData.js 読み込み
if (-Not (Test-Path $dataPath)) {
    Write-Host "❌ jobData.js が見つかりません：" $dataPath
    exit 1
}
$scriptContent = Get-Content -Path $dataPath -Raw
$embeddedScript = "<script>`n$scriptContent`n</script>"

# ✅ upload.html 更新
if (-Not (Test-Path $htmlPath)) {
    Write-Host "❌ upload.html が見つかりません：" $htmlPath
    exit 1
}

$htmlContent = Get-Content -Path $htmlPath -Raw
if ($htmlContent -match "$startTag.*?$endTag") {
    $updatedHtml = $htmlContent -replace "(?s)$startTag.*?$endTag", "$startTag`n$embeddedScript`n$endTag"
    Write-Host "✅ 既存のタグを検出し、内容を置換しました"
} else {
    Write-Host "⚠ 指定タグが見つからないため、</body> の直前に自動追加します"
    $newSection = "$startTag`n$embeddedScript`n$endTag"
    $updatedHtml = $htmlContent -replace "</body>", "$newSection`n</body>"
}

# 🔄 BOM付きで保存
$utf8Bom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText($htmlPath, $updatedHtml, $utf8Bom)
Write-Host "✅ upload.html に jobData.js を埋め込み完了（BOM付き保存）"
