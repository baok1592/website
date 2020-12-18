import Vue from 'vue'
import App from './App'
import uView from 'uview-ui'
import Api_url from './common/config.js'
import modulePublic from '@/common/public.js'
import moduleArticle from '@/common/article.js'
import testData from './common/testData.js';

Vue.use(uView);
Vue.prototype.modulePublic = modulePublic;
Vue.prototype.moduleArticle = moduleArticle;
Vue.prototype.Api_url = Api_url;
Vue.prototype.testData = testData;

Vue.config.productionTip = false

App.mpType = 'app'

const app = new Vue({
	...App
})

import HttpInterceptor from './common/http.interceptor.js';

Vue.use(HttpInterceptor, app);

app.$mount()

export default app