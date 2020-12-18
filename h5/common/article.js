import http from '@/main.js'

// 获取某个栏目下的文章
function getArticleByID(id) {
	let url = '/common/article/get_column_article';
	let data = {};
	data.id = id;
	return reGET(url, data);
}
// 获取文章栏目下的所有子类及其信息
function getSubCategoryByID(id) {
	let url = 'common/category/get_PclassList';
	let data = {};
	data.id = id;
	return reGET(url, data);
}
// 获取推荐到首页的栏目和文章
function getRecommendAll() {
	let url = 'phone/index/get_conter';
	return reGET(url);
}
// 通过id获取某篇文章
function getArticle(id) {
	let url = 'PC/article/get_article?id=' + id;
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

export default {
	getArticleByID,	// 获取某个栏目下的文章
	getSubCategoryByID,	// 获取文章栏目下的所有子类及其信息
	getRecommendAll,	// 获取推荐到首页的栏目和文章
	getArticle,	// 通过id获取某篇文章
}