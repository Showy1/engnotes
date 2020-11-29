<template>
  <div>
    <router-view />
  </div>
</template>

<script>
import Vue from 'vue';
import VueRouter from 'vue-router';

import CardIndex from 'cards/CardIndex.vue';
import CardShow from 'cards/CardShow.vue';

const routes = [
  { path: '/guest', component: CardIndex },
  { path: '/:id(\\d+)', name: 'CardShow', component: CardShow },
];

const router = new VueRouter({
  mode: 'history',
  routes
});

Vue.use(VueRouter);

export default {
  router
};
</script>

<style scoped>
</style>
