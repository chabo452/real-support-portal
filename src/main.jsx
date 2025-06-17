import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './styles/App.css' // ← CSSを使う場合

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
)
