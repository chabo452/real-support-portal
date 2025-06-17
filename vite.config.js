import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  base: '/real-support-portal/',
  plugins: [react()],
  publicDir: 'public',
  build: {
    outDir: 'docs'  // GitHub Pages 用
  }
})
