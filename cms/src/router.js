import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'

Vue.use(Router)

export default new Router({
  routes: [
	  
	{
      path: '/',
      name: 'home',
      component: Home
    },
	{
	  	path: '/About',
	  	name: 'About',
	  	component: () => import('./views/About.vue')
	  },
	{
	  	path: '/login',
	  	name: 'Login',
	  	component: () => import('./views/login/Login.vue')
	  },
	{
		path: '/set_gift',
		name: 'set_gift',
		component: () => import('./views/set_gift/set_gift.vue')
	},
	{
		path: '/user',
		name: 'user',
		component: () => import('./views/user/user.vue')
	},
	{
		path: '/admin',
		name: 'admin',
		component: () => import('./views/user/admin.vue')
	},
	{
		path: '/article/Category',
		name: 'Category',
		component: () => import('./views/article/Category.vue')
	},
	{
		path: '/article/Article',
		name: 'Article',
		component: () => import('./views/article/Article.vue')
	},
	{
		path: '/views/web/ad',
		name: 'ad',
		component: () => import('./views/web/Ad.vue')
	},
	{
		path: '/web/index_manage',
		name: 'index_manage',
		component: () => import('./views/web/index_manage.vue')
	},
	{
		path: '/user/point',
		name: 'point',
		component: () => import('./views/user/point.vue')
	},
	{
		path: '/detail/detail',
		name: 'detail',
		component: () => import('./views/detail/detail.vue')
	},
	{
		path: '/components/time_range/time_range',
		name: 'time_range',
		component: () => import('./components/time_range/time_range.vue')
	},
	{
		path: '/set',
		name: 'set',
		component: () => import('./views/web/Set.vue')
	},
	
	{
		path: '/web/group/group',
		name: 'group',
		component: () => import('./views/web/group/index.vue')
	},
	{
		path: '/lout',
		name: 'lout',
		component: () => import('./views/login/lout.vue')
	}, 
	
  ]
})
