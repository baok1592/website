import http from '@/main.js'

const jsonData = require("./data.json");

// 获取底部导航
async function getBottom() {
	let url = '/phone/bottomNavigation/get_bottom_navigation_all';
	return reAsyncGET(url);
}
// 获取网站配置信息
function getSystemInfo() {
	let url = 'phone/index/get_record';
	return reGET(url);
}
// 获取某个封面的内容0
function getCoverByID(id) {
	let url = 'common/cover/get_one_cover';
	let data = {};
	data.id = id;
	return reGET(url, data);
}
// 获取首页导航
function getHomeNav() {
	let url = 'phone/index/get_nav';
	return reGET(url);
}
// 获取首页banner
function getBanner() {
	let url = 'phone/index/get_banneritem';
	return reGET(url);
}


//-----------返回结果
function reGET(url, data) {
	return http.$u.get(url, data).then(res => {
		return res;
	}).catch(err => {
		return err;
	});
}
function rePOST(url, data) {
	return http.$u.post(url, data).then(res => {
		return res;
	}).catch(err => {
		return err;
	});
}
function rePUT(url, data) {
	return http.$u.put(url, data).then(res => {
		return res;
	}).catch(err => {
		return err;
	});
}
function reDELETE(url, data) {
	return http.$u.delete(url, data).then(res => {
		return res;
	}).catch(err => {
		return err;
	});
}

//----------同步返回结果
async function reAsyncGET(url, data) {
	return await http.$u.get(url).then(res => {
		return res;
	}).catch(err => {
		return err;
	});
}
async function reAsyncPOST(url, data) {
	return await http.$u.post(url).then(res => {
		return res;
	}).catch(err => {
		return err;
	});
}

// ---------------读取 json 文件
function getJSON(key) {
	let data = {};
	return jsonData[key];
}

export default {
	getBottom,	// 获取底部导航
	getSystemInfo,	// 获取网站配置信息
	getCoverByID,	// 获取某个封面的内容
	getHomeNav,	// 获取首页导航
	getBanner,	// 获取首页banner
}