<template>
	<div>
		<el-container>
			<el-aside width="200px">
				<NavTo></NavTo>
			</el-aside>
			<el-container>
				<el-header style="border-bottom: 1px solid #d0d0d0;">
					<Header></Header>
				</el-header>
				<el-main>
					<transition appear appear-active-class="animated fadeInLeft">
						<div class="article">
							<el-button v-if="is_hsz == 0" type="primary" size="small" @click="ontab_nav">{{btn_title}}</el-button>
							<el-button v-if="is_hsz == 0 && is_add == 0" type="primary" size="small" @click="hsz">回收站</el-button>
							<el-button v-if="is_hsz == 1" size="small" type="primary" @click="is_hsz = 0">返回</el-button>
							<el-row v-if="is_hsz == 1" style="margin-bottom: 20px;margin-top: 10px;">
								<el-button type="info" size="mini" @click="pl_del">批量删除</el-button>
								<el-button type="info" size="mini" @click="pl_hf">批量恢复</el-button>
								<!-- <el-button type="danger" size="mini" @click="yj_del">一键清空</el-button> -->
								<!-- <el-button type="danger" size="mini" @click="yj_hf">一键恢复</el-button> -->
							</el-row>
							<div style="height:20px;">&nbsp;</div>
							<!-- 添加文章 -->
							<template v-if="is_add == 1">
								<el-row>
									<el-form :model="form">
										<el-row>
											<el-col :span="6">
												<el-form-item label="栏目" :label-width="formLabelWidth">
													<el-select v-model="form.category_id" placeholder="请选择栏目">
														<el-option v-for="(item,index) in category_list" :key="index" :value="item.category_id" :label="item.category_name"></el-option>
													</el-select>
												</el-form-item>
											</el-col>
											<!-- <el-col :span="18">
												<el-form-item label="是否跳转:" :label-width="formLabelWidth">
													<el-radio v-model="radio" label="1">不跳转</el-radio>
													<el-radio v-model="radio" label="2">跳转到</el-radio>
													<el-input v-model="form.externallinks" v-if="radio == 2" auto-complete="off" style="width: 45%"></el-input>
												</el-form-item>
											</el-col> -->

										</el-row>
										<el-row>
											<el-col :span="12">
												<el-form-item label="文章标题" :label-width="formLabelWidth">
													<el-input v-model="form.title" auto-complete="off" style="width:90%"></el-input>
												</el-form-item>
											</el-col>
											<el-col :span="12">
												<el-form-item label="简略标题" :label-width="formLabelWidth">
													<el-input v-model="form.short_title" auto-complete="off" style="width:40%;"></el-input>
												</el-form-item>
											</el-col>
										</el-row>
										<el-row>
											<el-col :span="12">
												<el-form-item label="来源" :label-width="formLabelWidth">
													<el-input v-model="form.source" auto-complete="off" style="width:70%;"></el-input>
												</el-form-item>
											</el-col>
											<!-- <el-col :span="12">
												<el-form-item label="标签" :label-width="formLabelWidth">
													<el-input v-model="form.label" auto-complete="off" style="width:40%;"></el-input>
												</el-form-item>
											</el-col> -->
										</el-row>
										<el-form-item label="文章简要" :label-width="formLabelWidth">
											<el-input type="textarea" v-model="form.summary" auto-complete="off" style="width:500px;"></el-input>
										</el-form-item>

										<el-form-item label="缩略图" :label-width="formLabelWidth">
											<template v-if="img_list.length > 0">
												<div style="display: flex; width:530px ; flex-wrap: wrap;">
													<template v-for="(item,index) of img_list">
														<i class="el-icon-circle-close" @click="delimg(index)"></i>
														<div class="picA" v-if="img_list.length > 0">
															<img class="img" :src="getimg + item.url">
														</div>
													</template>
												</div>
											</template>
											<div class="picA" style="margin-left: 19px;" @click="to_choose_img" v-if="img_list.length < 1">
												<i class="el-icon-plus" style="margin-top: 45%; height: 28px; width: 28px;"></i>
											</div>


										</el-form-item>

										<el-form-item label="文章内容" :label-width="formLabelWidth">
											<vue-ueditor-wrap v-model="form.content" :config="myConfig"></vue-ueditor-wrap>
										</el-form-item>
									</el-form>
									<div class="dialog-footer">
										<el-button type="primary" @click="sub('form')" v-if="!isedit">确 定</el-button>
										<el-button type="primary" @click="sub_edit('form')" v-else>修 改</el-button>
									</div>
								</el-row>
							</template>
							<template v-if="is_add == 0 && is_hsz == 0">
								<el-table :data="list" border style="width: 100%">
									<el-table-column type="index" label="排序" width="70" prop>
										<template slot-scope="scope">
											<el-input v-model="scope.row.sort"></el-input>
										</template>
									</el-table-column>
									<el-table-column prop="title" label="文章标题" width="400"></el-table-column>
									<el-table-column label="类别" width="180">
										<template slot-scope="scope">
											<template v-for="x of category_list">
												<p v-if="x.category_id==scope.row.category_id">{{x.category_name}}</p>
											</template>
										</template>
									</el-table-column>
									<el-table-column label="创建时间" width="280">
										<template slot-scope="scope">
											<p>{{scope.row.create_time}}</p>
										</template>
									</el-table-column>
									<el-table-column label="推荐到首页" width="100">
										<template slot-scope="scope">
											<el-switch @change="is_index(scope.row.id)" v-model="scope.row.is_index" active-color="#409EFF"
											 :active-value="1" :inactive-value="0" inactive-color="#DCDFE6"></el-switch>
										</template>
									</el-table-column>
									<el-table-column label="头条" width="100">
										<template slot-scope="scope">
											<el-switch @change="is_head(scope.row.id)" v-model="scope.row.is_headlines" active-color="#409EFF"
											 :active-value="1" :inactive-value="0" inactive-color="#DCDFE6"></el-switch>
										</template>
									</el-table-column>
									<el-table-column label="幻灯" width="100">
										<template slot-scope="scope">
											<el-switch @change="is_ppt(scope.row.id)" :active-value="1" :inactive-value="0" v-model="scope.row.is_slide"
											 active-color="#409EFF" inactive-color="#DCDFE6"></el-switch>
										</template>
									</el-table-column>
									<el-table-column label="仅VIP浏览" width="100">
										<template slot-scope="scope">
											<el-switch @change="is_vip(scope.row.id)" v-model="scope.row.is_hidden" active-color="#409EFF"
											 inactive-color="#DCDFE6"></el-switch>
										</template>
									</el-table-column>

									<el-table-column prop="operation" label="操作">
										<template slot-scope="scope">
											<el-button @click="edit_get(scope.row.id)" type="success" size="small">修改</el-button>
											<el-button style="margin-left: 10px" type="danger" size="small" slot="reference" @click="del(scope.row.id,scope.$index)">删除</el-button>
										</template>
									</el-table-column>
									<strong></strong>
								</el-table>
								<div class="sort_btn">
									<el-button type="success" size="small" @click="sort_sub">提交排序</el-button>
								</div>
								<el-pagination style="margin-top: 10px;margin-left: 40%;" background layout="prev, pager, next" :total="total"
								 :page-size="size" @current-change="jump_page"></el-pagination>
							</template>

							<!-- 回收站 -->
							<template v-if="is_hsz == 1">
								<el-table :data="hsz_lit" border style="width: 100%">
									<el-table-column type="selection" width="70" prop>
										<template slot-scope="scope">
											<input style="zoom:180%;text-align: center;" type="checkbox" @change="choose(scope.row.id)" />
										</template>
									</el-table-column>
									<el-table-column prop="title" label="文章标题" width="400"></el-table-column>
									<el-table-column label="类别" width="180">
										<template slot-scope="scope">
											<template v-for="x of category_list">
												<p v-if="x.category_id==scope.row.category_id">{{x.category_name}}</p>
											</template>
										</template>
									</el-table-column>
									<el-table-column label="创建时间" width="280">
										<template slot-scope="scope">
											<p>{{scope.row.create_time[1]}}</p>
										</template>
									</el-table-column>
									<el-table-column label="首页" width="100">
										<template slot-scope="scope">
											<el-switch @change="is_index(scope.row.id)" v-model="scope.row.is_index" active-color="#409EFF"
											 :active-value="1" :inactive-value="0" inactive-color="#DCDFE6"></el-switch>
										</template>
									</el-table-column>
									<el-table-column label="头条" width="100">
										<template slot-scope="scope">
											<el-switch @change="is_head(scope.row.id)" v-model="scope.row.is_headlines" active-color="#409EFF"
											 :active-value="1" :inactive-value="0" inactive-color="#DCDFE6"></el-switch>
										</template>
									</el-table-column>
									<el-table-column label="幻灯" width="100">
										<template slot-scope="scope">
											<el-switch @change="is_ppt(scope.row.id)" :active-value="1" :inactive-value="0" v-model="scope.row.is_slide"
											 active-color="#409EFF" inactive-color="#DCDFE6"></el-switch>
										</template>
									</el-table-column>
									<el-table-column label="仅VIP浏览">
										<template slot-scope="scope">
											<el-switch @change="is_vip(scope.row.id)" v-model="scope.row.is_hidden" active-color="#409EFF"
											 inactive-color="#DCDFE6"></el-switch>
										</template>
									</el-table-column>
									<strong></strong>
								</el-table>
								<el-pagination style="margin-top: 10px;margin-left: 40%;" background layout="prev, pager, next" :total="hsz_total"
								 :page-size="size" @current-change="jump_page_hsz"></el-pagination>
							</template>
							<!-- 回收站结束 -->

						</div>
					</transition>
				</el-main>
			</el-container>
		</el-container>
		<Pic :drawer="drawer" :father_fun="get_img" :length="length"></Pic>
	</div>
</template>

<script>
	import Pic from '../About.vue'
	import {
		Loading
	} from "element-ui";
	import VueUeditorWrap from "vue-ueditor-wrap";
	import NavTo from '@/components/navTo.vue'
	import Header from "@/components/header.vue";
	import {
		Api_url
	} from "@/common/config";
	export default {
		name: "Article",
		data() {
			return {
				is_add: 0,
				ids: [],
				hsz_list: '',
				is_hsz: 0,
				radio: '1',
				length: 1,
				drawer: false,
				getimg: this.$getimg,
				img_list: [],
				list: "",
				size: 8,
				all: "",
				total: "",
				btn_title: "添加文章",
				isedit: false,
				tab_nav: false,
				dialogFormVisible: false,
				myConfig: {
					autoHeightEnabled: false,
					wordCount: false, //是否开启字数统计
					maximumWords: 1000000, //字符限制
					initialFrameHeight: 540,
					initialFrameWidth: "80%",
					serverUrl: Api_url + "ue_uploads",
					UEDITOR_HOME_URL: "/cms/static/UEditor/",
					toolbars: [
						[
							"justifyleft",
							"justifycenter",
							"justifyright",
							"justifyjustify",
							"bold",
							"forecolor",
							"fontsize",
							"source",
							"insertimage"
						]
					]
				},
				category_list: "",
				oid: 0,
				form: {
					title: "",
					img_id: "",
					content: "",
					category_id: "",
					short_title: '',
					summary: "",
					source: '',
					externallinks: '',
					label: ""
				},
				formLabelWidth: "120px",
				upfile_url: Api_url + "/admin/upload/img",
				upfile_head: {
					token: localStorage.getItem("token")
				},
				upfile_list: [], //上传文件列表
				list: [],
				// 显示回收站中的数据
				hsz_lit: [],
				// 回收站中页面个数
				hsz_total: 0,
			};
		},
		components: {
			VueUeditorWrap,
			NavTo,
			Header,
			Pic
		},
		mounted() {
			// this.getArticles();
			// this.get_category();
			this._load()
		},
		methods: {
			_load() {
				this.http.get('softDeletion/admin/get_trashed').then(res => {
					this.hsz_list = res.data.article
					this.hsz_lit = res.data.article.slice(0, this.size);
					this.hsz_total = res.data.article.length;
				})
				this.getArticles();
				this.get_category();
			},
			//批量删除
			pl_del() {
				let data = {
					id: {
						article: this.ids
					}
				}
				this.http.post('softDeletion/admin/del_trashedBatch', data).then(res => {
					this.$message({
						message: '删除成功',
						type: 'success'
					})
					this.ids = []
					this._load()
				})
			},
			//批量恢复
			pl_hf() {
				let data = {
					id: {
						article: this.ids
					}
				}
				this.http.post('softDeletion/admin/recovery_trashedBatch', data).then(res => {
					this.$message({
						message: '恢复成功',
						type: 'success'
					})
					this.ids = []
					this._load()
				})
			},
			//一键删除
			yj_del() {
				this.$confirm('此操作将清空回收站, 是否继续?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.get('softDeletion/admin/del_trashedAll').then(res => {
						this.$message({
							type: 'success',
							message: '删除成功!'
						});
						this._load()
					})
				})
			},
			//一键恢复
			yj_hf() {
				this.$confirm('此操作将恢复回收站所有文件, 是否继续?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.get('softDeletion/recovery').then(res => {
						this.$message({
							type: 'success',
							message: '恢复成功!'
						});
						this._load()
					})
				})
			},
			choose(id) {
				const index = this.ids.indexOf(id)
				console.log(index)
				if (index >= 0) {
					this.ids.splice(index, 1)
				} else {
					this.ids.push(id)
				}
				console.log(this.ids)
			},
			hsz() {
				this.is_hsz = 1
			},
			to_choose_img() {
				this.drawer = !this.drawer
			},
			is_show() {
				this.drawer = !this.drawer
			},
			get_img(e) {
				this.drawer = false
				for (let k in e) {
					const v = e[k]
					this.img_list.push(v)
					this.form.img_id = v.url
				}
				this.length = 6 - this.img_list.length
				console.log('get_img_end:', e, this.img_list)
				console.log(this.form)
			},
			delimg(index) {
				this.img_list.splice(index, 1)
			},

			//提交排序
			sort_sub() {
				let obj = {};

				const that = this;
				for (let value of that.all) {
					obj[value.id] = value.sort;
				}
				console.log(obj);
				this.http.post("article/update_article_sort", obj).then(res => {
					this.$message({
						message: "操作成功",
						type: "success"
					});
				});
			},

			jump_page_hsz(e) {
				const that = this;
				let start = (e - 1) * that.size;
				let end = e * that.size;
				console.log(start, end);
				this.hsz_lit = this.hsz_list.slice(start, end);
			},
			
			// 回收站分页
			jump_page(e) {
				const that = this;
				let start = (e - 1) * that.size;
				let end = e * that.size;
				// console.log(start, end);
				this.list = this.all.slice(start, end);
			},

			//获取文章分类
			async get_category() {
				let that = this;
				let category_list = [];
				await this.http.get("category/admin/get_category_all").then(async res => {
					category_list = await res.data;
				});
				this.category_list = category_list.filter(item => item.type != 'cover');
				console.log(this.category_list)
			},
			//获取所有文章
			getArticles() {
				var that = this;
				// let loadingInstance = Loading.service({
				// 	fullscreen: true
				// }); //显示加载
				this.http
					.get("article/admin/get_article_all").then(res => {
						console.log(res.data);
						// loadingInstance.close(); //关闭加载
						var res_code = res.status.toString();
						if (res_code.charAt(0) == 2) {
							that.list = res.data.slice(0, that.size);
							that.all = res.data;
							that.total = res.data.length;
						}
					});
			},
			//上传主图后的回调 
			up_ok(res) {
				if (res.code == 201) {
					this.form.img_id = res.id;
				}
			},
			ontab_nav() {
				if (this.btn_title == '添加文章') {
					this.is_add = 1
					this.btn_title = '返回'
					this.isedit = false
					this.clear_data()
					this.img_list = []
				}else{
					this.is_add = 0
					this.btn_title = '添加文章'
					this.clear_data()
					this.img_list = []
				}
				console.log(this.btn_title)
				// this.isedit = false;
				// this.img_list=[]
				// if (!this.tab_nav) {
				// 	this.btn_title = "添加文章";
				// 	this.tab_nav = false;
				// 	this.is_hsz == 1
				// 	this.clear_data();
				// } else {
				// 	this.btn_title = "返回";
				// 	this.tab_nav = true;
				// }
			},
			//  创建文章
			sub() {
				var that = this;
				console.log(this.form)
				this.http.post("article/admin/create_article", {
					form: that.form
				}).then(res => {
					that.$message({
						showClose: true,
						message: "添加成功",
						type: "success"
					});
					this.is_add = 0
					this.is_hsz = 0
					this.img_list = []
					that.clear_data();
					that.getArticles();
					this.btn_title = "添加文章";
					this.tab_nav = false;
				});
			},
			// 确定修改文章
			sub_edit() {
				var that = this;
				const data = that.form;
				data["id"] = that.oid;
				let form = {
					"form": data
				}

				this.http.post("article/admin/update_article", form).then(res => {
					that.$message({
						showClose: true,
						message: "修改成功",
						type: "success"
					});
					setTimeout(()=>{
						that.is_add = 0
					that.is_hsz = 0
					},1000)
					
					that.clear_data();
					that.getArticles();
					this.btn_title = "文章列表";
					this.tab_nav = false;
				});
			},
			//删除文章
			del(id, index) {
				var that = this;
				this.$confirm("是否删除?", "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(() => {
					this.http
						.put("article/admin/delete_article", {
							id: id
						})
						.then(res => {
							that.$message({
								showClose: true,
								message: "删除成功",
								type: "success"
							});
							that.list.splice(index, 1);
						});
					that._load();
				});
			},
			//是否首页
			is_index(id) {
				this.http.put("article/admin/push_article", {
					id: id,
					field: "is_index"
				})
				.then(res => {
					this.$message({
						type: 'success',
						message: '操作成功'
					})
				});
				
			},
			//是否头条
			is_head(id) {
				this.http.put("admin/onOff", {
						id: id,
						db: "article",
						field: "is_headlines"
					})
					.then(res => {
						this.$message({
							type: 'success',
							message: '操作成功'
						})
					});
			},
			//是否幻灯片
			is_ppt(id) {
				this.http
					.put("common/onOff", {
						id: id,
						db: "article",
						field: "is_slide"
					})
					.then(res => {
						console.log(res);
					});
			},
			//是否vip
			is_vip(id) {
				this.http
					.put("common/onOff", {
						id: id,
						db: "article",
						field: "is_hidden"
					})
					.then(res => {
						console.log(res);
					});
			},
			// 修改文章
			edit_get(id) {
				var that = this;
				this.is_add = 1
				this.http.get("article/admin/get_article_content?id="+id).then(res => {
					that.btn_title = "文章列表";
					let data = res.data[0]
					if (data.image) {
						that.upfile_list = [{
							url: data.image.url
						}];
					}
					console.log('edit_get:', data.img)
					that.img_list = [{
						id: data.img_id,
						url: data.img_id
					}];
					that.form.title = data.title;
					that.form.content = data.content;
					that.form.source = data.source;
					that.form.img_id = data.img_id;
					that.form.summary = data.summary;
					that.form.category_id = data.category_id;
					that.form.short_title = data.short_title
					this.form.label = data.label
					that.form.externallinks = data.externallinks
					that.isedit = true;
					that.oid = data.id;
					that.tab_nav = true;
				});
			},
			close_fun(done) {
				this.clear_data();
				done(); //官方实例用法
			},
			clear_data() {
				this.dialogFormVisible = false;
				this.form = {
					title: "",
					content: "",
					category_id: "",
					summary: "",
					img_id: "",
					source: ""
				};
				this.img_list = []
				this.upfile_list = []; //清空上传列表
				this.oid = 0;
			}
		}
	};
</script>

<style lang="less" scoped="">
	.upload-demo {
		width: 50% !important;
	}

	.picA {
		width: 148px;
		height: 148px;
		background-color: #FBFDFF;
		border: 1px dashed #C0CCDA;
		border-radius: 6px;
		box-sizing: border-box;
		vertical-align: top;
		text-align: center;
		margin: 6px;


		img {
			width: 144px;
			height: 144px;
			border: 1px solid #BFBFBF;
			border-radius: 3px;
		}
	}

	.article {
		line-height: 30px;
		text-align: left;
	}

	.sort_btn {
		margin-top: 20px;
	}

	.list-head {
		padding-bottom: 10px;
	}

	.dialog-footer {
		margin: 20px auto;
		text-align: center;
	}
</style>
