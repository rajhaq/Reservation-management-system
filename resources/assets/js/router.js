import Vue from 'vue'
import Router from 'vue-router'
import mainapp from './components/mainapp.vue'
import home from './components/home.vue'
import newbooking from './components/booking/newbooking.vue'
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
		{
			path: '/home',
			name: 'home',
			component: home
		},
		{
			path: '/newbooking',
			name: 'newbooking',
			component: newbooking
		},
	]
})