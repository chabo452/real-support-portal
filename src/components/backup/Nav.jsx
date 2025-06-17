import React from 'react'
import { Link } from 'react-router-dom'

const Nav = () => (
  <nav style={{ marginBottom: '1rem' }}>
    <Link to='/'>����</Link> | 
    <Link to='/chart'>�O���t</Link> | 
    <Link to='/dashboard'>CSV�O���t</Link> | 
    <Link to='/about'>�x���Ƃ�</Link> | 
    <Link to='/report'>���</Link>
  </nav>
)
export default Nav
