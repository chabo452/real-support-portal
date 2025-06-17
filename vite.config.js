import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  base: '/real-support-portal/',
  plugins: [react()],
  build: {
    rollupOptions: {
      input: './index.html',
      onwarn(warning, warn) {
        // CSSとしてJSを誤認しても無視
        if (warning.message.includes('css-syntax-error')) return
        warn(warning)
      },
    },
  },
})
