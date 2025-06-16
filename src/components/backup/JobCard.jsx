import React from 'react'

const JobCard = ({ data }) => (
  <div style={{ border: '1px solid #ccc', padding: '1rem', margin: '1rem 0' }}>
    <h3>{data.title} - {data.company}</h3>
    <p>‹Î–±’n: {data.location}</p>
    <p>‹‹—^: {data.salary}</p>
    <p>”õl: {data.note}</p>
  </div>
)
export default JobCard
