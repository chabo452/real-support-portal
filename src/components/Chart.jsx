const data = {
  labels: ['地域A', '地域B', '地域C'],
  datasets: [{
    label: '離職率 (%)',
    data: [40, 25, 60],
    backgroundColor: 'rgba(75, 192, 192, 0.6)'
  }]
}
const options = {
  scales: { y: { beginAtZero: true } }
}
const Chart = () => (
  <div>
    <h2>離職率グラフ</h2>
    <Bar data={data} options={options} />
  </div>
)
export default Chart

