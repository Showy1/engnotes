/* eslint no-console: 0 */

import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';
import App from '../app.vue';
import UserApp from '../userApp.vue';

import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';

Vue.use(BootstrapVue);

document.addEventListener('DOMContentLoaded', () => {
  if(document.getElementById('app')){
    new Vue({
      el: '#app',
      render: h => h(App)
    }).$mount();
  }

  if(document.getElementById('user_app')){
    new Vue({
      el: '#user_app',
      render: h => h(UserApp)
    }).$mount();
  }
});
