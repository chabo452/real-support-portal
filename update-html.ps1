# update-html.ps1

# 📁 ディレクトリとファイルパス設定
$projectRoot = "$env:USERPROFILE\Desktop\real-support-portal"
$htmlPath = "$projectRoot\upload.html"
$dataPath = "$projectRoot\data\jobData.js"

# 🔍 HTMLに挿入するプレースホルダーのコメントタグ
$startTag = "<!-- jobData.js START -->"
$endTag   = "<!-- jobData.js END -->"

# 📄 jobData.js の内容を読み込み
$scriptContent = Get-Content -Path $dataPath -Raw

# 🧱 <script> タグで囲む
$embeddedScript = "<script>`n$scriptContent`n</script>"

# 📄 upload.html を読み込み
$htmlContent = Get-Content -Path $htmlPath -Raw

# 🔄 jobData.js セクション置き換え
$pattern = [regex]::Escape($startTag) + '.*?' + [regex]::Escape($endTag)
if ($htmlContent -match $pattern) {
    $replacement = "$startTag`r`n$embeddedScript`r`n$endTag"
    $updatedHtml = [regex]::Replace($htmlContent, $pattern, $replacement, 'Singleline')
    Set-Content -Path $htmlPath -Value $updatedHtml -Encoding UTF8
    Write-Host "✅ upload.html に jobData.js を埋め込みました"
} else {
    Write-Host "❌ upload.html に jobData.js 埋め込みタグが見つかりません"
    exit 1
}
