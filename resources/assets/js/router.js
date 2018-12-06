import Vue from 'vue'
import Router from 'vue-router'
import mainapp from './components/mainapp.vue'
import home from './components/home.vue'
import newbooking from './components/booking/newbooking.vue'
import bookinglist from './components/booking/bookinglist.vue'
import calender from './components/booking/calender.vue'
import payment from './components/service/payment.vue'

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
        {
			path: '/bookinglist',
			name: 'bookinglist',
			component: bookinglist
		},
        {
			path: '/calender',
			name: 'calender',
			component: calender
        },
        {
			path: '/payment',
			name: 'payment',
			component: payment
        },
    ]
})
