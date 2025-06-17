import React from 'react'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import About from './components/About'
import JobAnalysis from './components/JobAnalysis'
import Dashboard from './components/Dashboard'
import Chart from './components/Chart'
import Nav from './components/Nav'
import PrintableReport from './components/PrintableReport'

function App() {
  return (
    <Router basename="/real-support-portal">
      <Nav />
      <Routes>
        <Route path="/" element={<JobAnalysis />} />
        <Route path="/about" element={<About />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/chart" element={<Chart />} />
        <Route path="/report" element={<PrintableReport />} />
      </Routes>
    </Router>
  )
}

export default App
