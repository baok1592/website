<template>
	<div id="ad">
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
			<div class="list">
				<div class="list-head">
					<el-row>
						<el-col :span="1">
							<el-button type="primary" size='small' @click="create_ad">添加广告</el-button>
						</el-col>
						<el-col :span="2">
							<el-button type="warning" size='small' @click='sort_sub'>更新排序</el-button>
						</el-col>
						
						
						<!-- 广告修改弹框 -->
						<el-dialog title="" :visible.sync="dialogFormVisible" width="45%" center>
							<el-form :model="form">
								<el-form-item label="广告位名称" :label-width="formLabelWidth">
									<el-input v-model="form.key_word" auto-complete="off"></el-input>
								</el-form-item>
								<el-form-item label="选择广告位" :label-width="formLabelWidth">
									<el-select v-model="form.banner_id">
										<el-option v-for="item in banners" :value="item.id" :label="item.description"></el-option>
									</el-select>
								</el-form-item>
								<el-form-item label="跳转到" :label-width="formLabelWidth">
									<el-select v-model="form.type">
										<el-option label="不跳转"></el-option>
										<el-option label="文章" value="article"></el-option>
										<el-option label="企业" value="cpy"></el-option>

									</el-select>
									&emsp;&emsp;
									<!-- <el-select v-model="form.jump_id" filterable>
										<el-option v-for="(item,index) in type_list" :value="index" :label="item"></el-option> -->
									</el-select>
								</el-form-item>
								<el-form-item label="广告图片" :label-width="formLabelWidth">
									<!-- <el-upload class="upload-demo" :action="upfile_url" :data="upfile_data" :on-success="up_ok" :limit=1
									 :file-list="upfile_list" list-type="picture" :headers="upfile_head">
										<el-button size="small" type="primary">点击上传</el-button>
									</el-upload> -->
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
							<div slot="footer" class="dialog-footer">
								<el-button type="primary" v-if="eid<1" @click="sub">立即创建</el-button>
								<el-button v-else type="success" @click="subEdit">提交修改</el-button>


							</div>

						</el-dialog>
					</el-row>
				</div>
				<!-- 广告列表 -->
				<template>
					<el-table :data="list" border style="width: 100%">
						<el-table-column label="排序" width="70">
							<template slot-scope="scope">
								<el-input v-model="scope.row.sort"></el-input>
							</template>
						</el-table-column>
						<el-table-column prop="key_word" label="名称" width="220"></el-table-column>
						<el-table-column prop="banner.description" label="所属广告位" width="220"></el-table-column>
						<el-table-column prop="imgs" label="缩略图" width="280">
							<template slot-scope="scope">
								<img :src="getimg+scope.row.img_id" with="140" height="70" />
							</template>
						</el-table-column>
						<el-table-column prop="main.title" label="跳转到" width="280">
						</el-table-column>
						<el-table-column prop="operation" label="操作">
							<template slot-scope="scope">
								<el-button type="success" size="small" @click="on_edit(scope.row.id)">编辑</el-button>
								<el-button style="margin-left: 10px" type="danger" size="small" slot="reference" @click="del(scope.row.id,scope.$index)">删除</el-button>
							</template>
						</el-table-column>
					</el-table>
				</template>
				<el-pagination style="margin-top: 10px;" background layout="prev, pager, next" :total="total"
				:page-size="size" @current-change="jump_page">
				</el-pagination>
			</div>
		</transition> 
				</el-main>
			</el-container>
		</el-container>
		<Pic :drawer="drawer"  :father_fun="get_img" :length="length"></Pic>
	</div>
</template>

<script>
	import Pic from '../About.vue'
	import {
		Loading
	} from 'element-ui';
	import {
		Api_url
	} from '@/common/config'
	
	import NavTo from '@/components/navTo.vue'
	import Header from "@/components/header.vue";
	export default {
		name: 'Ad',
		data() {
			return {
				getimg: this.$getimg,
				length:1,
				drawer: false, 
				img_list: [],
				total: '',
				size: 6,
				list: '',
				all: '',
				dialogFormVisible: false,
				form: {
					key_word: '',
					img_id: '',
					banner_id: '',
					type: "",
					jump_id: ""
				},
				formLabelWidth: '120px',
				input: '',
				banners: [
					{
						id:1,
						description:'首页大图'
					}
				],
				eid:''
			}
		},
		components:{
			NavTo,
			Header,
			Pic
		},
		computed: {
			type_list: function() {
				this.form.jump_id = ""
				if (this.form.type == 'article') {
					return this.article;
				}
				if (this.form.type == 'cpy') {
					return this.cpy;
				}

			}
		},
		mounted() {
			// this.getBanners();
			this.getBannerItems();
		},
		methods: {
			
			to_choose_img() {
				console.log(1)
				this.drawer = !this.drawer
			},
			is_show() {
				this.drawer = !this.drawer
			},
			get_img(e) {
				this.drawer = false
				for (let k in e) {
					const v=e[k]
					this.img_list.push(v)
					this.form.img_id = v.url
				}
				this.length=6-this.img_list.length
				console.log('get_img_end:',e,this.img_list)
				console.log(this.form)
			},
			delimg(index){
				this.img_list.splice(index,1)
			},
			
			
			//清空form表单数据
			_clsForm() {
				const that = this
				that.eid = ""
				that.upfile_list = [];
				for (var x in that.form) {
					that.form[x] = ""
				};
			},
			// 更新广告
			subEdit() {
				const that = this;
				that.form['id'] = this.eid
				this.http.post('banner/admin/update_banner', {form:that.form})
					.then((res) => {
						that.$message({
							showClose: true,
							message: '更新成功',
							type: 'success'
						});
						that._clsForm()
						that.dialogFormVisible = false;
						that.getBannerItems();
					});
			},
			//获取修改AD信息
			on_edit(id) {
				const that = this;
				this.dialogFormVisible = true
				this.eid = id;
				this.http.get('banner/admin/get_banner_content?id=' + id)
					.then((res) => {
						that.img_list = [{
							'url': res.data.img_id,
							'id': res.data.img_id
						}]
						for (let x in that.form) {
							that.form[x] = res.data[x]
						};
					})
			},
			//提交排序
			sort_sub() {
				let obj = {}
				const that = this
				for (let value of that.list) {
					obj[value.id] = value.sort
				}
				this.http.post('banner/admin/update_banner_sort', obj)
					.then((res) => {
						this.$message({
							message: '操作成功',
							type: 'success'
						})
						that.getBannerItems();
					})
			},
			// 添加广告
			create_ad() {
				this._clsForm()
				this.dialogFormVisible = true
			},
			// 添加广告
			sub() {
				var that = this;
				this.http.post('banner/admin/create_banner', {form:that.form})
					.then((res) => {
						that.$message({
							showClose: true,
							message: '添加成功',
							type: 'success'
						});
						for (var x in that.form) {
							that.form[x] = ""
						};
						that.upfile_list = [];
						that.dialogFormVisible = false;
						that.getBannerItems();
					});
			},
			//获取广告位
			getBanners() {
				// var that = this;
				// this.http.get('/banners')
				// 	.then((res) => {
				// 		console.log(res.data);
				// 		var res_code = res.status.toString();
				// 		if (res_code.charAt(0) == 2) {
				// 			that.banners = res.data;
				// 		}
				// 	});
				// this.http.get('/newlist?type=cms')
				// 	.then((res) => {
				// 		let article = {}
				// 		for (let v of res.data) {
				// 			article[v.id] = v.title;
				// 		}
				// 		this.article = article
				// 		console.log(this.article)
				// 	});
			},
			jump_page(e) {
				const that = this;
				let start = (e - 1) * that.size;
				let end = e * that.size;
				console.log(start, end)
				this.list = this.all.slice(start, end);
			},


			//获取所有广告位下的广告
			getBannerItems() {
				var that = this;
				// let loadingInstance = Loading.service({
				// 	fullscreen: true
				// }); //显示加载  
				this.http.get('banner/admin/banner_items_all')
					.then((res) => {
						// loadingInstance.close(); //关闭加载 
						var res_code = res.status.toString();
						if (res_code.charAt(0) == 2) {
							that.list = res.data;
							that.all = res.data
							that.list = res.data.slice(0, that.size);
							that.total = res.data.length;
						}
					});
			},
			up_ok(res) {
				this.form.img_id = res.id;
			},
			//删除AD
			del(id, index) {
				var that = this;
				this.$confirm('是否删除?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.put('banner/admin/delete_banner', {
							id: id
						})
						.then((res) => {
							that.$message({
								showClose: true,
								message: '删除成功',
								type: 'success'
							});
							that.list.splice(index, 1);
						});
				})
			}
		},
		


	}
</script>

<style lang="less">
	#ad {
		line-height: 30px;
		.list-head {
			padding-bottom: 10px
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
	}
</style>
