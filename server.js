const express = require('express');
const multer = require('multer');
const fs = require('fs');
const Papa = require('papaparse');
const path = require('path');

const app = express();
const upload = multer({ dest: 'uploads/' });

const jsonPath = path.join(__dirname, 'src', 'data', 'jobData.json');
const publicPath = path.join(__dirname, 'public', 'jobData.json');
const docsPath = path.join(__dirname, 'docs', 'jobData.json');

app.use(express.static(path.join(__dirname, 'public')));

app.post('/upload', upload.single('jobFile'), (req, res) => {
  try {
    let fileContent = fs.readFileSync(req.file.path, 'utf8');

    // BOM除去（文字化け対策）
    if (fileContent.charCodeAt(0) === 0xFEFF) {
      fileContent = fileContent.slice(1);
    }

    const result = Papa.parse(fileContent, {
      header: true,
      skipEmptyLines: true
    });

    const newData = result.data;

    let existingData = [];
    if (fs.existsSync(jsonPath)) {
      let existingRaw = fs.readFileSync(jsonPath, 'utf8');
      if (existingRaw.charCodeAt(0) === 0xFEFF) {
        existingRaw = existingRaw.slice(1);
      }
      existingData = JSON.parse(existingRaw);
    }

    newData.forEach(item => {
      if (!existingData.find(e => e['求人番号'] === item['求人番号'])) {
        existingData.push(item);
      }
    });

    const finalJson = JSON.stringify(existingData, null, 2);
    fs.writeFileSync(jsonPath, finalJson, 'utf8');
    fs.writeFileSync(publicPath, finalJson, 'utf8');
    fs.writeFileSync(docsPath, finalJson, 'utf8');

    fs.unlinkSync(req.file.path);
    res.send('✅ アップロード成功！');
  } catch (e) {
    console.error(e);
    res.status(500).send('❌ エラーが発生しました');
  }
});

app.listen(3000, () => console.log('🚀 http://localhost:3000'));
