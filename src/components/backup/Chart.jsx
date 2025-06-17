import React from 'react'
import { Bar } from 'react-chartjs-2'

const data = {
  labels: ['���A', '���B', '���C'],
  datasets: [{
    label: '���E�� (%)',
    data: [40, 25, 60],
    backgroundColor: 'rgba(75, 192, 192, 0.6)'
  }]
}
const options = {
  scales: { y: { beginAtZero: true } }
}
const Chart = () => (
  <div>
    <h2>���E���O���t</h2>
    <Bar data={data} options={options} />
  </div>
)
export default Chart
