import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  base: '/real-support-portal/', // GitHub Pages のサブパス用に必須
  plugins: [react()],
  build: {
    outDir: 'dist/docs', // ここにビルド出力 → gh-pages ブランチ直下にコピー
    emptyOutDir: true
  }
})
