import {defineConfig} from "vite";
import eslintPlugin from "vite-plugin-eslint";
import vue from "@vitejs/plugin-vue";

// https://vitejs.dev/config/
export default defineConfig({
    root: "app",
    assetsInclude: ["public"],
    server: {host: "0.0.0.0", port: 3001},
    build: {
        outDir: "../build",
        emptyOutDir: true,
    },
    plugins: [vue(), eslintPlugin({failOnWarning: true})],
});
