import React, { useRef } from "react"
import { useReactToPrint } from "react-to-print"

function PrintableContent() {
  return (
    <div>
      <h2>����p���|�[�g</h2>
      <p>�����ɕ��́E��ē��e���L��</p>
    </div>
  )
}
function PrintableReport() {
  const ref = useRef()
  const handlePrint = useReactToPrint({ content: () => ref.current })

  return (
    <div>
      <button onClick={handlePrint}>�������</button>
      <div ref={ref}>
        <PrintableContent />
      </div>
    </div>
  )
}
export default PrintableReport
