import Vue from 'vue'
import Router from 'vue-router'
import mainapp from './components/mainapp.vue'
Vue.use(Router)
export default new Router({
	  mode: 'history',
	  routes: 
	  [
        {
	      path: '/mainapp',
	      name: 'mainapp',
	      component: mainapp
	    },
	 ]
})