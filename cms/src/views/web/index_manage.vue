<template>
	<div class="index_manage">
		<el-container>
			<el-aside width="200px">
				<NavTo></NavTo>
			</el-aside>
			<el-container>
				<el-header style="border-bottom: 1px solid #d0d0d0;">
					<Header></Header>
				</el-header>
				<el-main style="background-color: #F3F3F3;">
					<el-tabs >
						<el-tab-pane>
							<span slot="label" style="font-size:18px">模 板</span>
							<el-row class="mt-2">
								<div class="tmp-lists">
									<div class="tmp-panel">
										<!-- v-if="pc_tmp && pc_tmp.tep && pc_tmp.tep.img_url"-->
										<template  v-if="pc_tmp && pc_tmp.tep && pc_tmp.tep.img_url"><img :src="getimg + pc_tmp.tep.img_url" alt=""></template>
										<img :src="getimg + urltest" alt="">
										<span class="tmp-panel-title" v-if="pc_tmp && pc_tmp.tep && pc_tmp.tep.cn_name">{{ pc_tmp.tep.cn_name }}</span>
										<div class="tmp-panel-btns">
											<span class="text-red">当前模板</span>
										</div>
									</div>
									<template v-for="item in tmp_list">
										<template v-if="(item&&pc_tmp.tep&&pc_tmp.tep.temp_num)&&item.temp_num!=pc_tmp.tep.temp_num">
											<div class="tmp-panel">
												<template v-if="item.img_url"><img :src="getimg + item.img_url" alt=""></template>
												<span class="tmp-panel-title">{{ item.cn_name }}</span>
												<div class="tmp-panel-btns">
													<template>
														<el-button type="primary" size="small" @click="change_pc(item.temp_num)">使用该模板</el-button>
													</template>
												</div>
											</div>
										</template>
									</template>
								</div>
							</el-row>
						</el-tab-pane>
					</el-tabs>
					
					<!-- <el-dialog title="" :visible.sync="addbox" width="35%" center :before-close="handleClose">
						<el-form :model="addform">
							<el-form-item label="名称" :label-width="formLabelWidth" style='width: 80%'>
								<el-input v-model="addform.navigation_name" auto-complete="off"></el-input>
							</el-form-item>
							<el-form-item label="路径" :label-width="formLabelWidth">
								<el-select v-model="addform.url" placeholder="请选择" @change="choose_url">
									<el-option v-for="(item,index) in url_list" :value="item.path" :label="item.name"></el-option>
								</el-select>
							</el-form-item>
							<el-form-item label="模板" :label-width="formLabelWidth">
								<el-select v-model="addform.template_id" placeholder="请选择">
									<el-option v-for="item in nav_list" :value="item.id" :label="item.template"></el-option>
								</el-select>
							</el-form-item>
							<el-form-item v-if="is_lanmu == 1" label="栏目ID" :label-width="formLabelWidth">
								<el-select v-model="addform.category_id" placeholder="请选择">
									<el-option :value="0" label="全部"></el-option>
									<el-option :value="-1" label="推荐"></el-option>
									<el-option v-for="item in cate_list" :value="item.category_id" :label="item.category_name"></el-option>
								</el-select>
							</el-form-item>
							<el-form-item label="图标" :label-width="formLabelWidth">

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
						</el-form>
						<div slot="footer" class="dialog-footer" style='text-align: center'>
							<el-button @click="cancel">取 消</el-button>
							<template v-if="is_edit == 1">
								<el-button type="primary" @click="onSubmit">修改</el-button>
							</template>
							<template v-else>
								<el-button type="primary" @click="onSubmit">确 定</el-button>
							</template>

						</div>
					</el-dialog> -->
				</el-main>
			</el-container>
		</el-container>
		<Pic :drawer="drawer" :father_fun="get_img" :length="length"></Pic>
	</div>
</template>
<script>
	import NavTo from '@/components/navTo.vue'
	import Header from "@/components/header.vue";
	import Pic from '../About.vue'
	
	export default {
		data() {
			return {
				is_lanmu: 0,
				is_edit: 0,
				nav_list: [],
				category: '',
				cate_list: '',
				getimg: this.$getimg,
				urltest:'/uploads//imgs/a1.jpg',
				length: 1,
				drawer: false,
				img_list: [],
				formLabelWidth: '120px',
				addbox: false,
				addform: {
					navigation_name: '',
					template_id: '',
					img_id: '',
					category_id: '',
					url: ''
				},
				url_list: [{
						name: '首页',
						path: 'home/home'
					},
					{
						name: '分类',
						path: 'cate/cate'
					},
					{
						name: '列表',
						path: 'lists/lists'
					},
					{
						name: '封面',
						path: 'us/us'
					}
				],
				list: [1, 2, 3, 4, 5, 6, 7, 8, 9],
				show: 2,
				btn_name: '设置首页内容',
				tableData: [],
				options: [],
				value: '',
				nav_Tem_list: [],
				pc_index_list: [],
				phone_index_list: [],
				using_list:'',
				phone_using:'',
				pc_using:'',
				// 保存 PC 端当前使用的模板数据
				pc_tmp: '',
				// 保存 PC 端所有模板
				tmp_list: [],				
			}
		},

		components: {
			NavTo,
			Header,
			Pic
		},
		mounted() {
			this._load()
			// this.getCategory()
		},
		methods: {
			// 修改 PC 模板
			change_pc (type) {
				let that = this;
				console.log('pc');
				this.http.post_show('system/admin/edit_tep', {
					type: type,
				}).then(res => {
					this.$message({
						type: 'success',
						message: '修改模板成功',
					})
					that._load();
				})
			},
			_load() {
				let that = this;
				//所有底部导航
				// this.http.get('phone/bottomNavigation/get_bottom_navigation_all').then(res => {
				// 	this.tableData = res.data.data
				// 	console.log(this.tableData)
				// })
				//所有导航模板
				this.http.get('/temp/admin/get_all_temp').then(res => {
					// this.nav_Tem_list = res.data
					that.tmp_list = res.data
					console.log(that.tmp_list);
				})
				that.get_pc_tmp();			
			},
			// 获取 PC 端当前使用的模板
			async get_pc_tmp () {
				let that = this;
				await this.http.get('common/template/get_pc_tep').then(res => {
					that.pc_tmp = res.data;
				})
			},
			getCategory() {
				var that = this;
				var arr = [];
				this.http.get('category/get_category_all')
					.then((res) => {
						console.log('getCategory:', res);
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
						that.cate_list = res.data
					});
			},
			//设置电脑首页
			use_pc_tem(tem, index) {
				this.http.get('template/update_config', {
					tmp: tem
				}).then(res => {
					this.$message({
						message: '操作成功',
						type: 'success'
					});
					this._load()
				})
			},
			//设置手机首页
			install_phone_tmp(id, index) {
				this.http.put('template/up_phoneIndexTmp', {
					id: id
				}).then(res => {
					this.$message({
						message: '操作成功',
						type: 'success'
					});
					this._load()
				})
			},
			handleClose() {
				this.addbox = false
				this.clearn_data()
			},
			//修改导航
			edit(item, id) {
				this.is_edit = 1
				this.img_list = []
				console.log(item)
				this.addbox = true
				this.addform.id = id
				this.addform.img_id = item.img_id
				this.addform.template_id = item.template_id
				this.addform.navigation_name = item.navigation_name
				this.addform.url = item.url
				this.addform.category_id = item.access_type
				let img = {
					id: item.img_id,
					url: item.img
				}
				this.img_list.push(img)
				console.log(this.addform)
			},
			//删除导航
			del(id) {
				this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.$message({
						type: 'success',
						message: '删除成功!'
					});
				}).catch(() => {
					this.$message({
						type: 'info',
						message: '已取消删除'
					});
				});
			},
			//区分路径
			choose_url(e) {
				const that = this
				console.log(e)
				this.nav_list = []
				if (e == 'cate/cate' || e == 'lists/lists') {
					this.nav_list = this.nav_Tem_list.data.listTemplate
					if (e == 'lists/lists') {
						that.is_lanmu = 1
					} else {
						that.is_lanmu = 0
					}
				}
				if (e == 'home/home') {
					that.is_lanmu = 0
					this.nav_list = this.nav_Tem_list.data.indexTemplate
				}
				if (e == 'us/us') {
					that.is_lanmu = 0
					this.nav_list = this.nav_Tem_list.data.columnTemplate
				}

				console.log(this.nav_list)
				console.log(this.nav_Tem_list)
			},
			//提交新增
			onSubmit() {
				if (this.is_edit == 1) {
					console.log(this.addform)
					this.http.post('phone/bottomNavigation/up_bottom_navigation', this.addform).then(res => {
						this.$message({
							type: 'success',
							message: '修改成功!'
						});
						this.is_edit = 0
						this.addbox = false
						this.clearn_data()
						this._load()
					})

				} else {
					console.log(this.addform)
					this.addbox = false
					this._load()
					this.clearn_data()
				}

			},
			to_choose_img() {
				this.drawer = !this.drawer
			},
			is_show() {
				this.show = 1
			},
			back() {
				this.show = 2
			},
			shows() {
				this.addbox = true
			},
			get_img(e) {
				this.drawer = false
				for (let k in e) {
					const v = e[k]
					this.img_list.push(v)
					this.addform.img_id = v.id
				}
				this.length = 6 - this.img_list.length
				console.log('get_img_end:', e, this.img_list)
				console.log(this.addform)
			},
			delimg(index) {
				this.img_list.splice(index, 1)
			},
			cancel() {
				this.addbox = false
				this.clearn_data()
			},
			clearn_data() {
				this.addform = {
					navigation_name: '',
					template_id: '',
					img_id: '',
					category_id: '',
					url: ''
				}
				this.img_list = []
			}
		}
	}
</script>



<style lang="less">
	.mt-2 {
		margin-top: 20px;
		
	}
	
	.ml-2 {
		margin-left: 20px;
	}
	
	.img-init {
		width: 100px;
		height: 100px;
	}
	.now-template {
		font-weight: 600;
		// color: red;
		color: rgba(64,158,255, 1);
	}
	.tmp-lists {
		display: flex;
		flex-wrap: wrap;
		// justify-content: space-between;
	}
	
	.text-red {
		color: red;
	}
	// PC 端
	.tmp-panel {
		display: flex;
		flex-direction: column;
		width: 30%;
		min-width: 30%;
		text-align: center;
		margin-bottom: 20px;
		padding-bottom: 10px;
		transition: all 0.5s;
		margin-right: 5%;
		z-index: 999;
		cursor: pointer;	
		&:hover {
			box-shadow: 0 0 5px -2px #8f8f8f;
			// transform: scale(1.1);
			transform: translateY(-10px);
		}
		&:nth-child(3n) {
			margin-right: 0;
		}
		
		img {
			width: 100%;
			height: 300px;
		}
		
		.tmp-panel-title {
			display: block;
			text-align: center;
			padding: 10px 0;
		}
		
	}
	// 手机 端
	.tmp-panel-ph {
		display: flex;
		flex-direction: column;
		width: 22%;
		min-width: 22%;
		text-align: center;
		margin-bottom: 20px;
		padding-bottom: 10px;
		transition: all 0.5s;
		margin-right: 4%;
		z-index: 999;
		cursor: pointer;
		&:hover {
			box-shadow: 0 0 5px -2px #8f8f8f;
			// transform: scale(1.1);
			transform: translateY(-10px);
		}
		&:nth-child(4n) {
			margin-right: 0;
		}
		
		img {
			width: 100%;
			height: 550px;
		}
		
		.tmp-panel-ph-title {
			display: block;
			text-align: center;
			padding: 10px 0;
		}
		
	}
	
	
	/* <style>   */
	.index_manage {}

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

	/* 	.right {
		width: 70%;
		height: 300px;

		.top {
			height: 20%;

			background-color: aqua;
		}

		.content {
			height: 80%;
			background-color: burlywood;
		}
	} */
</style>
