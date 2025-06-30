# ダウンロード対象と保存先
$csvUrl = "https://docs.google.com/spreadsheets/d/1L4cMgiOHxt9x5DWRH_RZH-uRxpAyBsIwUiSpxYM3zsI/export?format=csv&gid=0"
$csvPath = "original.csv"
$jsonPath = "jobData.json"
$targetHtml = "docs\upload.html"

# CSVダウンロード（User-Agent指定）
Invoke-WebRequest -Uri $csvUrl -OutFile $csvPath -Headers @{'User-Agent'='Mozilla/5.0'}

# CSV → JSON変換
$data = Import-Csv $csvPath
$json = $data | ConvertTo-Json -Depth 3
[System.IO.File]::WriteAllText($jsonPath, $json, [System.Text.Encoding]::UTF8)

# Reveal.jsスライド＋地図HTML生成
$htmlTemplate = @"
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>求人マップ表示</title>
  <script src="https://cdn.jsdelivr.net/npm/reveal.js@4.5.0/dist/reveal.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@4.5.0/dist/reveal.css" />
  <style>#map { height: 400px; }</style>
</head>
<body>
  <div class="reveal">
    <div class="slides">
"@

foreach ($job in $data) {
  $htmlTemplate += "<section><h2>$($job.title)</h2><p>$($job.description)</p><p>タグ: $($job.tag)</p></section>`n"
}

$htmlTemplate += @"
    </div>
  </div>
  <h2>求人マップ表示</h2>
  <div id="map"></div>
  <script>
    const jobData = $json;
    function initMap() {
      const map = new google.maps.Map(document.getElementById("map"), {
        zoom: 10,
        center: { lat: 35.681236, lng: 139.767125 }
      });
      jobData.forEach(job => {
        if (job.lat && job.lng) {
          new google.maps.Marker({
            position: { lat: parseFloat(job.lat), lng: parseFloat(job.lng) },
            map: map,
            title: job.title
          });
        }
      });
    }
  </script>
  <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDj7H7ob5yR3tM-6b0-xr_J1xmFBc57VzE&callback=initMap"></script>
  <script>Reveal.initialize();</script>
</body>
</html>
"@

Set-Content -Path $targetHtml -Value $htmlTemplate -Encoding UTF8
Write-Host "✅ upload.html を再生成しました: $targetHtml"
