<template>
	<div id="category">
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
						<div class="category">
							<!-- 新增分类 -->
							<el-row v-if="is_add == 1">
								<el-button v-if="is_hsz == 0" type="primary" size="small"  class="btn" @click="add">{{btn_name}}</el-button>
								<el-button v-if="is_hsz == 0" type="primary" size="small"  @click="hsz">回收站</el-button>
								<el-button v-if="is_hsz == 1" size="small" type="primary"  @click="is_hsz = 0">返回</el-button>
							</el-row>
							<!-- 回收站按钮 -->
							<el-row v-if="is_hsz == 1" style="margin-bottom: 20px;margin-top: 10px;">
								<el-button type="info"  size="mini" @click="pl_del">批量删除</el-button>
								<el-button type="info"  size="mini" @click="pl_hf">批量恢复</el-button>
								<!-- <el-button type="danger"  size="mini" @click="yj_del">一键清空</el-button>
								<el-button type="danger"  size="mini" @click="yj_hf">一键恢复</el-button> -->
							</el-row>
							<!-- <AddCategory @up_parent="up_list" :list="category_top"></AddCategory> -->

							<!-- 弹窗修改分类 -->
							<el-dialog title="" :visible.sync="editbox" width="35%" center>
								<el-form :model="editform">
									<el-form-item label="栏目名称" :label-width="formLabelWidth" style='width: 80%'>
										<el-input v-model="editform.category_name" auto-complete="off"></el-input>
									</el-form-item>
									<el-form-item label="栏目简称" :label-width="formLabelWidth" style='width: 80%'>
										<el-input v-model="editform.short_name" auto-complete="off"></el-input>
									</el-form-item>
									<el-form-item label="上级栏目" :label-width="formLabelWidth">
										<el-select v-model="editform.pid" placeholder="请选择分类">
											<el-option label="顶级分类" value="0"></el-option>
											<el-option v-for="(item,index) in category_top" :value="item.category_id" :label="item.category_name" :key="index"></el-option>
										</el-select>
									</el-form-item>

								</el-form>
								<div slot="footer" class="dialog-footer" style='text-align: center'>
									<el-button @click="editbox = false">取 消</el-button>
									<el-button type="primary" @click="onSubmit(editindex)">确 定</el-button>
								</div>
							</el-dialog>

							<!-- 栏目列表 -->
							<template v-if="is_add == 1 && is_hsz == 0">
								<el-table :data="list" border style="width: 100%">
									<el-table-column prop="" label="排序" width="70">
										<template slot-scope="scope">
											<el-input v-model="scope.row.sort"></el-input>
										</template>
									</el-table-column>
									<el-table-column prop="category_name" label="栏目名字" width="280">
										<template slot-scope="scope">
											<span v-if="scope.row.line">&emsp;&emsp;|——</span>{{scope.row.category_name}}
										</template>
									</el-table-column>
									<el-table-column prop="short_name" label="栏目简称" width="180">
									</el-table-column>
									<el-table-column prop="pid" label="Pid" width="150">
									</el-table-column>
									<el-table-column prop="is_visible" label="是否显示" width="150">
										<template slot-scope="scope">
											<el-switch @change="onswitch(scope.row.category_id)" v-model="scope.row.is_visible" active-color="#409EFF" inactive-color="#DCDFE6" :active-value="1" :inactive-value="0">
											</el-switch>
										</template>
									</el-table-column>
									<el-table-column prop="is_visible" label="推荐到PC首页" width="150">
										<template slot-scope="scope">
											<el-switch @change="onindex(scope.row.category_id, 'pc')" v-model="scope.row.is_pc_index" active-color="#409EFF"
											 inactive-color="#DCDFE6" :active-value="1" :inactive-value="0">
											</el-switch>
										</template>
									</el-table-column>
									<el-table-column prop="is_visible" label="推荐到手机首页" width="150">
										<template slot-scope="scope">
											<el-switch @change="onindex(scope.row.category_id, 'ph')" v-model="scope.row.is_phone_index" active-color="#409EFF"
											 inactive-color="#DCDFE6" :active-value="1" :inactive-value="0">
											</el-switch>
										</template>
									</el-table-column>
									<el-table-column prop="level" label="操作">
										<template slot-scope="scope">
											<el-button type="success" size="small" @click="onedit(scope.row)">修改</el-button>
											<el-button type="danger" size="small" @click="del(scope.row.category_id,scope.$index)">删除</el-button>

										</template>
									</el-table-column>
								</el-table>
								<div class="sort_btn">
									<el-button type="success" size="small" @click="sort_sub">提交排序</el-button>
								</div>
							</template>
							<!-- 栏目列表结束 -->

							<!-- 回收站 -->
							<template v-if="is_hsz == 1">

								<el-table :data="hsz_list" border style="width: 100%" ref="multipleTable" tooltip-effect="dark"
								 @selection-change="handleSelectionChange">
									<el-table-column type="selection" width="45">
										<template slot-scope="scope">
											<input style="zoom:180%;text-align: center;" type="checkbox" @change="choose(scope.row.category_id)" />
										</template>

									</el-table-column>

									<el-table-column prop="category_name" label="栏目名字" width="280">
										<template slot-scope="scope">
											<span v-if="scope.row.line">&emsp;&emsp;|——</span>{{scope.row.category_name}}
										</template>
									</el-table-column>
									<el-table-column prop="short_name" label="栏目简称" width="180">
									</el-table-column>
									<el-table-column prop="pid" label="Pid" width="150">
									</el-table-column>
									<el-table-column prop="is_visible" label="是否显示" width="150">
										<template slot-scope="scope">
											<el-switch @change="onswitch(scope.row.category_id)" v-model="scope.row.is_visible" active-color="#409EFF"
											 inactive-color="#DCDFE6" :active-value="1" :inactive-value="0">
											</el-switch>
										</template>
									</el-table-column>
									<el-table-column prop="is_visible" label="推荐到首页" width="150">
										<template slot-scope="scope">
											<el-switch @change="onindex(scope.row.category_id)" v-model="scope.row.is_index" active-color="#409EFF"
											 inactive-color="#DCDFE6" :active-value="1" :inactive-value="0">
											</el-switch>
										</template>
									</el-table-column>
								</el-table>
							</template>
							<!-- 回收站结束 -->
							
							<!-- 添加栏目 -->
							<template v-if="is_add == 2">
								<el-row>
									<el-button type="primary" size="small" class="btn" @click="back">返回</el-button>
								</el-row>
								<el-form ref="form" :model="form" label-width="120px">
									<el-tabs v-model="activeName" @tab-click="handleClick">
										<el-tab-pane label="常规选项" name="first">
											<el-row>
												<el-col :span="6">
													<el-form-item label="栏目名称">
														<el-input v-model="form.category_name" style="width: 80%;"></el-input>
													</el-form-item>
												</el-col>
												<el-col :span="12">
													<el-form-item label="栏目简称">
														<el-input v-model="form.short_name" style="width: 20%;"></el-input>
													</el-form-item>
												</el-col>
												<el-col :span="8"></el-col>
											</el-row>
																			
											<el-row>
												<el-col :span="5">
													<el-form-item label="上级栏目">
														<el-select v-model="form.pid" placeholder="请选择上级分类">
															<el-option label="顶级栏目" value="0"></el-option>
															<el-option v-for="item of article_leve_h" :label="item.category_name" :value="item.category_id"></el-option>
														</el-select>
													</el-form-item>
												</el-col>
											</el-row>
											<el-row>
												<el-col :span="24">
													<el-row>
														<el-col :span="5">
															<el-form-item label="栏目类型">
																<el-select @change="choose_json(form.type)" v-model="form.type" placeholder="请选择分类模板">
																	
																	<el-option label="封面" :value="'cover'"></el-option>
																	<el-option label="文章列表" :value="'article_list'"></el-option>
																	<el-option label="图片列表" :value="'pic_list'"></el-option>
																	<el-option label="外部链接" :value="'address'"></el-option>
																</el-select>
															</el-form-item>
														</el-col>
														<el-col :span="5"  v-if="form.type == 'address'">
															<el-form-item label="跳转到">
																<el-input v-model="form.jumpaddress"></el-input>
															</el-form-item>
														</el-col>
														<!-- <el-col :span="24" v-if="form.type == 2">
															<el-row>
																<el-col :span="6">
																	<el-form-item label="手机列表模板">
																		<el-select v-model="form.list_template_id" placeholder="请选择手机列表模板">
																			<template v-for="item of phone_tmp.listTemplate">
																				<el-option :label="item.template" :value="item.id"></el-option>
																			</template>
																		</el-select>
																	</el-form-item>
																</el-col>
																<el-col :span="6">
																	<el-form-item label="手机文章模板">
																		<el-select v-model="form.article_template_id" placeholder="请选择手机文章模板">
																			<template v-for="item of phone_tmp.articleTemplate">
																				<el-option :label="item.template" :value="item.id"></el-option>
																			</template>
																		</el-select>
																	</el-form-item>
																</el-col>
																<el-col :span="6">
																	<el-form-item label="电脑列表模板">
																		<el-select v-model="form.list_template" placeholder="请选择电脑列表模板">
																			<template v-for="item of pc_tmp.listTemplate">
																				<el-option :label="item" :value="item"></el-option>
																			</template>
																		</el-select>
																	</el-form-item>
																</el-col>
																<el-col :span="6">
																	<el-form-item label="电脑文章模板">
																		<el-select v-model="form.article_template" placeholder="请选择电脑文章模板">
																			<template v-for="item of pc_tmp.articleTemplate">
																				<el-option :label="item" :value="item"></el-option>
																			</template>
																		</el-select>
																	</el-form-item>
																</el-col>
															</el-row>
														</el-col> -->
													</el-row>
												</el-col>
											</el-row>
											
																			
											<el-form-item label="分类图片">
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
											<el-form-item label="文章内容" :label-width="formLabelWidth" v-if="form.type == 'cover'">
												<vue-ueditor-wrap v-model="form.content" :config="myConfig"></vue-ueditor-wrap>
											</el-form-item>
										</el-tab-pane>
										<el-tab-pane label="高级选项" name="second">
											<el-row>
												<el-col :span="5">
													<el-form-item label="SEO标题">
														<el-input v-model="form.seotitle"></el-input>
													</el-form-item>
												</el-col>
												<el-col :span="5">
													<el-form-item label="关键词">
														<el-input v-model="form.keyword"></el-input>
													</el-form-item>
												</el-col>
											</el-row>
											<el-row>
												<el-col :span="10">
													<el-form-item label="栏目描述">
														<el-input type="textarea" :autosize="{ minRows: 2}" v-model="form.content"></el-input>
													</el-form-item>
												</el-col>
											</el-row>
											<!-- json -->
											<div v-if="cate_json.cover">
											<el-row v-if="cate_json.cover['flag'] || cate_json.article_list['flag'] || cate_json.pic_list['flag']">
												<el-col :span="10">
													<el-form-item label="JSON">
														<ul class="json">
															<template v-if="cate_json.cover['flag']">
																<li v-for="i in cate_json.cover.data.length">
																	<span>{{ (i - 1) }}</span>
																	<el-input type="textarea" :autosize="{ minRows: 2}" v-model="cate_json.cover.data[i - 1]" @input="changeCateJsonCover(i - 1, $event)"></el-input>
																</li>
															</template>
															<template v-if="cate_json.article_list['flag']">
																<li v-for="i in cate_json.article_list.data.length">
																	<span>{{ (i - 1) }}</span>
																	<el-input type="textarea" :autosize="{ minRows: 2}" v-model="cate_json.article_list.data[i - 1]" @input="changeCateJsonArticle(i - 1, $event)"></el-input>
																</li>
															</template>
															<template v-if="cate_json.pic_list['flag']">
																<li v-for="i in cate_json.pic_list.data.length">
																	<span>{{ (i - 1) }}</span>
																	<el-input type="textarea" :autosize="{ minRows: 2}" v-model="cate_json.pic_list.data[i - 1]" @input="changeCateJsonPic(i - 1, $event)"></el-input>
																</li>
															</template>
														</ul>
													</el-form-item>
												</el-col>
											</el-row>
											</div>
										</el-tab-pane>
									</el-tabs>
									
								</el-form>
								
								<div class="dialog-footer">
									<el-button type="primary" @click="sub" v-if="!isedit">确 定</el-button>
									<el-button type="primary" @click="sub_edit('form')" v-else>修 改</el-button>
								</div>
							</template>


							<!-- <el-pagination style="margin-top: 10px;margin-left: 40%;" background layout="prev, pager, next" :total="total" :page-size="size" @current-change="jump_page">
				</el-pagination> -->
						</div>
					</transition>
				</el-main>
			</el-container>
		</el-container>
		<Pic :drawer="drawer" :father_fun="get_img" :length="length"></Pic>
	</div>
</template>

<script>
	import VueUeditorWrap from "vue-ueditor-wrap";
	import Pic from '../About.vue'
	import NavTo from '@/components/navTo.vue'
	import Header from "@/components/header.vue";
	import {
		Api_url
	} from '@/common/config.js'

	export default {
		name: 'Category',
		components: {
			NavTo,
			Header,
			VueUeditorWrap,
			Pic
		},
		data() {
			return {
				ids: [],
				multipleSelection: [],
				is_hsz: 0,
				radio: '1',
				isedit: false,
				length: 1,
				drawer: false,
				getimg: this.$getimg,
				img_list: [],
				myConfig: {
					autoHeightEnabled: false,
					wordCount: false, //是否开启字数统计
					maximumWords: 1000000, //字符限制
					initialFrameHeight: 540,
					initialFrameWidth: "80%",
					serverUrl: Api_url + "ue_uploads",
					UEDITOR_HOME_URL: "/cms/static/UEditor/",

					//serverUrl: Api_url + 'index/admin/ue_uploads',
					//UEDITOR_HOME_URL: this.$ue + '/static/UEditor/',
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
				btn_name: '添加栏目',
				is_add: 1,
				list: '',
				all: '',
				size: 8,
				total: '',
				input: '',
				category: [],
				category_top: [],
				dialogTableVisible: false,
				editbox: false, //修改的box
				editform: {
					category_name: '',
					short_name: '',
					pid: '',
					category_pic: ''
				},
				formLabelWidth: '120px',
				editindex: 0,
				form: {
					category_name: "",
					short_name: "",
					pid: '',
					category_pic: "",
					column_template_id: '', //手机封面模板
					list_template_id: '', //手机列表模板
					article_template_id: '', //手机文章模板
					column_template: '', //电脑封面模板
					list_template: '', //电脑列表
					article_template: '', //电脑文章
					seotitle: '',
					keyword: "",
					seo_desc: '',
					type: '',
					jumpaddress: '',
					//---
					template: '',
					is_visible: 1,
					level: 1,
					sort: 0,
					content: '',
					json: []
					//---
				},
				pc_tmp: '',
				phone_tmp: '',
				// 用于添加栏目中 tabs 的切换
				activeName: 'first',
				hsz_list: '',
				// 保存顶级栏目
				article_leve_h: [],
				// 保存栏目创建时的 JSON
				cate_json: {},
				// 保存栏目创建时 JSON 的零时值
				json_temp: '',
			};
		},
		mounted() {
			// this.getCategory(); //获取分类
			// this.get_template() //获取模板
			this._load()
		},
		methods: {
			// 改变 cate_json 中的值
			changeCateJsonCover(index, value) {
				this.cate_json.cover.data[index] = value;
				// 强制刷新
				this.$forceUpdate()
			},
			changeCateJsonArticle(index, value) {
				this.cate_json.article_list.data[index] = value;
				// 强制刷新
				this.$forceUpdate()
			},
			changeCateJsonPic(index, value) {
				this.cate_json.pic_list.data[index] = value;
				// 强制刷新
				this.$forceUpdate()
			},
			// 根据 select 选择显示 json 输入框数
			choose_json(type) {
				let cate_json = this.cate_json;
				for(let k in cate_json)
				{
					cate_json[k].flag = false;
				}
				// 判断用户的选择激活对应 json
				if(type == 'cover') {
					cate_json.cover['flag'] = true;
				}
				else if(type == 'article_list') {
					cate_json.article_list['flag'] = true;
				}
				else if(type == 'pic_list') {
					cate_json.pic_list['flag'] = true;
				}
				
				this.cate_json = cate_json;
				console.log('co:', this.cate_json);
			},
			//批量删除
			pl_del() {
				let data = {
					id: {
						category: this.ids
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
						category: this.ids
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
					this.http.get('softDeletion/del_trashedAll').then(res => {
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
			handleSelectionChange(val) {
				this.multipleSelection = val;
			},
			async _load() {
				let that = this;
				this.http.get('softDeletion/admin/get_trashed').then(res => {
					that.hsz_list = res.data.category
					// console.log(this.hsz_list)
				})
				this.getCategory(); //获取分类
				// 获取当前 PC 模板
				await this.http.get('common/template/get_pc_tep').then(res => {
					if(res.data.tep) {
						/*
						构造一个数据结构
						cate_json: {
							cover: {
								flag: false,
								data: {
									0: '',
									...
								}
							},
							article_list: {
								flag: false,
								data: {
									0: '',
									...
								}
							},
							pic_list: {
								flag: false,
								data: {
									0: '',
									...
								}
							}
						}
						*/
						that.pc_tmp = res.data.tep;
						that.cate_json['cover'] = {};
						that.cate_json.cover['flag'] = false;
						that.cate_json.cover['data'] = [];
						
						that.cate_json['article_list'] = {};
						that.cate_json.article_list['flag'] = false;
						that.cate_json.article_list['data'] = [];
						
						that.cate_json['pic_list'] = {};
						that.cate_json.pic_list['flag'] = false;
						that.cate_json.pic_list['data'] = [];
						
						
						for(let i = 0; i < res.data.tep.cover_num; i++) 
						{
							that.cate_json.cover.data[i] = '';
						}
						for(let i = 0; i < res.data.tep.article_list_num; i++)
						{
							that.cate_json.article_list.data[i] = '';
						}
						for(let i = 0; i < res.data.tep.pic_list_num; i++)
						{
							that.cate_json.pic_list.data[i] = '';
						}
						console.log(that.cate_json.article_list.data.length)
					}
				})
			},
			hsz() {
				this.is_hsz = 1
			},
			// 添加栏目
			sub() {
				const that = this
				console.log('pid:', this.form.pid);
				// 确定 level
				if(this.form.pid != 0) {
					for(let k in this.list)
					{
						if(this.list[k].category_id == this.form.pid) {
							this.form.level = this.list[k].level + 1;
							break;
						}
					}
				}
				this.form.json = this.cate_json;
				for(let k in this.cate_json)
				{
					if(this.cate_json[k].flag == true) {
						this.form.json = this.cate_json[k].data;
					}
				}
				
				console.log('level: ', this.form)
				this.http.post('category/admin/create_category', {
					form: this.form
				}).then(res => {
					that.is_add = 1
					that.clear_data()
					that.getCategory()
					that.$message({
						message: '添加成功',
						type: 'success'
					})
				})
			},
			// 修改栏目
			sub_edit() {
				// console.log(this.form)
				// console.log(this.img_list)
				let data = {
					form: this.form
				}
				data.form.json = this.cate_json;
				// console.log('修改', this.form);
				this.http.post('category/admin/update_category', data).then(res => {
					this.$message({
						message: '修改成功',
						type: 'success'
					})
					this.back()
					this.getCategory()
				})
			},
			// 添加栏目
			add() {
				this.is_add = 2
				this.isedit = false
				this.is_hsz = 0
			},
			back() {
				this.isedit = false
				this.is_add = 1
				this.is_hsz = 0
				this.form = {
					category_name: "",
					short_name: "",
					pid: '',
					category_pic: "",
					column_template_id: '', //手机封面模板
					list_template_id: '', //手机列表模板
					article_template_id: '', //手机文章模板
					column_template: '', //电脑封面模板
					list_template: '', //电脑列表
					article_template: '', //电脑文章
					seotitle: '',
					keyword: "",
					type: '',
					jumpaddress: ''
				}
				this.img_list = []
			},
			//提交排序
			sort_sub() {
				let obj = {}

				const that = this
				for (let value of that.category) {
					obj[value.category_id] = value.sort
				}
				this.http.post('category/admin/update_category_sort', obj)
					.then(() => {
						this.$message({
							message: '操作成功',
							type: 'success'
						})
						this.getCategory();
					})
			},
			get_template() {
				//获取PC模板
				this.http.get('template/get_pc_template').then(res => {
					this.pc_tmp = res.data
					// console.log("pc_tmp:", res)
				})
				//获取phone模板
				this.http.get('template/get_phone_template').then(res => {
					this.phone_tmp = res.data
					// console.log("phone_tmp:", res)
				})
			},
			// 获取栏目
			getCategory() {
				var that = this;
				var arr = [];
				this.http.get('category/admin/get_category_all')
					.then((res) => {
						that.article_leve_h = res.data.filter(item => item.level == 1);
						// console.log('getCategory:', res);
						for (var i = 0; i < res.data.length; i++) {
							if (res.data[i].level == 1) {
								arr.push(res.data[i]);
							}
							if (res.data[i].level == 2) {
								res.data[i].line = true;
							} else {
								res.data[i].line = false;
							}
						}
						that.category = res.data;
						that.list = res.data
					});
			},
			clear_data() {
				const form = {
					category_name: "",
					short_name: "",
					pid: '',
					category_pic: "",
					column_template_id: '', //手机封面模板
					list_template_id: '', //手机列表模板
					article_template_id: '', //手机文章模板
					column_template: '', //电脑封面模板
					list_template: '', //电脑列表
					article_template: '', //电脑文章
					seotitle: '',
					keyword: "",
					type: '',
					jumpaddress: ''
				}
				this.img_list = []
				this.form = form
			},
			//删除分类
			del(id, index) {
				var that = this;
				this.$confirm('是否删除?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.put('category/admin/delete_category', {
						id: id
					}).then(() => {
						that.$message({
							showClose: true,
							message: '删除成功',
							type: 'success'
						});
						that.category.splice(index, 1);
						this._load()
						return false;
					})
				})
			},
			//修改分类
			onedit(item) {
				console.log(item)
				this.isedit = true
				this.is_add = 2
				this.form.category_pic = item.category_pic
				this.form.category_name = item.category_name
				this.form.short_name = item.short_name
				this.form.pid = item.pid
				this.form.column_template_id = item.column_template_id
				this.form.list_template_id = item.list_template_id
				this.form.article_template_id = item.article_template_id
				this.form.list_template = item.list_template
				this.form.column_template = item.column_template
				this.form.article_template = item.article_template
				this.form.seotitle = item.seotitle
				this.form.keyword = item.keyword
				this.form.type = item.type
				this.form.category_id = item.category_id
				if (item.jumpaddress) {
					this.form.jumpaddress = item.jumpaddress
				}
				if (item.content) {
					this.form.content = item.content
				}
				this.img_list.push({
					url: item.category_pic,
					// url: item.img
				})
				
				// 判断栏目是属于哪一种类型的
				let dat = JSON.parse(item.json);
				if(item.type == 'cover') {
					this.cate_json.cover['flag'] = true;
					for(let i = 0; i < this.cate_json.cover.data.length; i++)
					{
						this.cate_json.cover.data[i] = dat.cover.data[i];
					}
					// console.log(this.cate_json.cover.data);
				}
				else if(item.type == 'article_list') {
					this.cate_json.article_list['flag'] = true;
					for(let i = 0; i < this.cate_json.article_list.data.length; i++)
					{
						this.cate_json.article_list.data[i] = dat.article_list.data[i];
					}
				}
				else if(item.type == 'pic_list') {
					this.cate_json.pic_list['flag'] = true;
					for(let i = 0; i < this.cate_json.pic_list.data.length; i++)
					{
						this.cate_json.pic_list.data[i] = dat.pic_list.data[i];
					}
				}
			},
			//新增分类成功后
			up_list() {
				this.getCategory();
			},
			//更新分类
			onSubmit(index) {
				var that = this;
				this.http.post('/admin/update_category', {
						form: that.editform
					}) 
					.then((res) => {
						console.log(res.data);
						that.editbox = false;
						this.category.splice(index, 1, res.data);
					});
			},
			//是否隐藏
			onswitch(id) {
				console.log(id);
				this.http.put('admin/onOff', {
						id: id,
						db: 'category',
						field: 'is_visible'
					})
					.then((res) => {
						console.log(res);
						this.$message({
							type: 'success',
							message: '操作成功'
						})
					});
			},
			//是否首页
			onindex(id, flag) {
				let that = this;
				let field = '';
				if(flag == 'pc') {
					field = 'is_pc_index';
				}
				else if(flag == 'ph') {
					field = 'is_phone_index'
				}
				this.http.put('admin/onOff', {
					id: id,
					db: 'category',
					field: field
				}).then((res) => {
					console.log(res);
					this.$message({
						type: 'success',
						message: '操作成功'
					})
				});
				// console.log('id:',id)
			},
			up_ok(res) {
				if (res.code == 201) {
					this.editform.category_pic = res.id;
				}
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
					this.form.category_pic = v.url
				}
				this.length = 6 - this.img_list.length
				console.log('get_img_end:', e, this.img_list)
				console.log(this.form)
			},
			delimg(index) {
				this.img_list.splice(index, 1)
			},
			// 添加栏目中 tabs 切换
			handleClick() {
				console.log(this.activeName)
			}
		},


	}
</script>

<style lang="less" scoped="">
	// --
	.json {
		list-style: none;
		margin: 0;
		padding: 0;
		
		li {
			display: flex;
			margin-bottom: 10px;
			
			span {
				display: inline-block;
				margin-right: 10px;
			}
		}
	}
	// --
	
	#category {
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

		.category {
			line-height: 30px;
			text-align: left;
		}

		.sort_btn {
			margin-top: 20px;
		}

		.btn {
			margin-bottom: 6px;
		}

	}
</style>
