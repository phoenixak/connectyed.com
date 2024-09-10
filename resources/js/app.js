import './bootstrap';
import '../css/app.css'
import Router from '@/router'
import store from '@/store'
import { createApp } from 'vue';

const app = createApp({});

app.use(Router)
app.use(store)
app.mount('#app');