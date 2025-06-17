import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  base: '/real-support-portal/', // GitHub Pages のパスプレフィックス
  plugins: [react()],
  build: {
    outDir: 'docs', // GitHub Pages用にdocsに出力
    rollupOptions: {
      input: './index.html', // メインエントリーポイント
      onwarn(warning, warn) {
        if (warning.message.includes('css-syntax-error')) return
        warn(warning)
      },
    },
    emptyOutDir: false // これを追加することで upload.html や jobData.json を消さない
  },
})
