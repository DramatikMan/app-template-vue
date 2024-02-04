<script setup lang="ts">
import {store, cfg} from "~/core";

defineProps<{msg: string}>();

const state = store.use();
const BACKEND_API_URL = cfg.get("BACKEND_API_URL");
</script>

<template>
    <h1>{{ msg }}</h1>

    <div class="card">
        <button type="button" @click="state.addCount">count is {{ state.count }}</button>
        <p>
            Edit
            <code>components/HelloWorld.vue</code> to test HMR
        </p>
    </div>

    <p>
        Check out
        <a href="https://vuejs.org/guide/quick-start.html#local" target="_blank">create-vue</a>, the
        official Vue + Vite starter
    </p>

    <p>
        Install
        <a href="https://github.com/vuejs/language-tools" target="_blank">Volar</a>
        in your IDE for a better DX
    </p>

    <p class="read-the-docs">Click on the Vite and Vue logos to learn more</p>
    <p>BACKEND_API_URL: {{ BACKEND_API_URL }}</p>
</template>

<style scoped>
.read-the-docs {
    color: #888;
}
</style>
