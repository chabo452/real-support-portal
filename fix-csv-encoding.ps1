# 修正対象フォルダ
$csvFiles = @(
    "$env:USERPROFILE\Desktop\real-support-portal\data\output.csv",
    "$env:USERPROFILE\Desktop\real-support-portal\data\original.csv"
)

foreach ($file in $csvFiles) {
    if (Test-Path $file) {
        try {
            $content = Get-Content $file -Raw
            $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
            [System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
            Write-Host "✅ 文字コード修正完了：" $file
        } catch {
            Write-Host "❌ 修正失敗：" $file
        }
    } else {
        Write-Host "⚠ ファイルが見つかりません：" $file
    }
}
