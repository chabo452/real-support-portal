import React, { useRef } from "react"
import { useReactToPrint } from "react-to-print"

function PrintableContent() {
  return (
    <div>
      <h2>印刷用レポート</h2>
      <p>ここに分析・提案内容を記載</p>
    </div>
  )
}
function PrintableReport() {
  const ref = useRef()
  const handlePrint = useReactToPrint({ content: () => ref.current })

  return (
    <div>
      <button onClick={handlePrint}>印刷する</button>
      <div ref={ref}>
        <PrintableContent />
      </div>
    </div>
  )
}
export default PrintableReport
