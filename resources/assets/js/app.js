require('./bootstrap');
window.Vue = require('vue');

import iView from 'iview';
import 'iview/dist/styles/iview.css';

import Vue from 'vue'
Vue.use(iView);
// common methods 

/*custom common methods*/
import common from './common';
Vue.mixin(common);


Vue.component('mainapp', require('./components/mainapp.vue'));
import router from './router'
const app = new Vue({
    el: '#app',
    router,
});

