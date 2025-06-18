import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  base: '/real-support-portal/',
  build: {
    outDir: 'dist/docs'
  },
  plugins: [react()]
})
