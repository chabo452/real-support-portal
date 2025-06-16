import React, { useEffect, useState } from 'react'
import axios from 'axios'
import Papa from 'papaparse'
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer } from 'recharts'

function Dashboard() {
  const [data, setData] = useState([])

  useEffect(() => {
    axios.get('/src/data/jobData.csv').then((response) => {
      Papa.parse(response.data, {
        header: true,
        dynamicTyping: true,
        complete: (results) => setData(results.data),
      })
    })
  }, [])

  return (
    <div>
      <h2>CSV�f�[�^����</h2>
      <ResponsiveContainer width='100%' height={300}>
        <BarChart data={data}>
          <XAxis dataKey='��Ɩ�' />
          <YAxis />
          <Tooltip />
          <Bar dataKey='���E��' fill='#8884d8' />
        </BarChart>
      </ResponsiveContainer>
    </div>
  )
}
export default Dashboard
