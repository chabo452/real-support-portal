// src/components/PrintableReport.jsx
import React from 'react';

function PrintableReport() {
  const handlePrint = () => {
    window.print();
  };

  return (
    <div>
      <h2>印刷用レポート</h2>
      <p>支援の理念や実績をまとめたものです</p>
      <button onClick={handlePrint}>印刷する</button>
    </div>
  );
}

export default PrintableReport;
