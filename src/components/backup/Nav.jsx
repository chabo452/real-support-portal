import React from 'react'
import { Link } from 'react-router-dom'

const Nav = () => (
  <nav style={{ marginBottom: '1rem' }}>
    <Link to='/'>分析</Link> | 
    <Link to='/chart'>グラフ</Link> | 
    <Link to='/dashboard'>CSVグラフ</Link> | 
    <Link to='/about'>支援とは</Link> | 
    <Link to='/report'>印刷</Link>
  </nav>
)
export default Nav
