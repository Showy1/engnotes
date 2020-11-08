/* eslint no-console: 0 */

import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';
import App from '../app.vue';

import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';

Vue.use(BootstrapVue);

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#vueapp',
    render: h => h(App)
  }).$mount();
});
