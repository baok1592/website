<template>
	<div class="admin">
		<el-container>
			<el-aside width="200px">
				<NavTo></NavTo>
			</el-aside>
			<el-container>
				<el-header style="border-bottom: 1px solid #d0d0d0;background-color: #FFFFFF;">
					<Header></Header>
				</el-header>

				<transition appear appear-active-class="animated fadeInLeft">
					<el-main>
						<el-tabs v-model="activeName" type="card" @tab-click="handleClick" style="background-color: #FFFFFF;">

							<el-tab-pane label="管理员" name="first">
								<el-button style="display: flex;justify-content: flex-start;margin-bottom: 20px; margin-top: 10px; margin-left: 10px;"
								 type="primary" @click="add_admin">添加管理员</el-button>
								<el-table :data="tableData" stripe style="width: 100%">
									<el-table-column type="index" label="序号" width="80">
									</el-table-column>
									<el-table-column prop="nickname" label="姓名">
									</el-table-column>
									<el-table-column prop="groups.name" label="所在分组">
										<!-- <template slot-scope="scope">
											{{group_list_b[scope.row.group_id].name}}
										</template> -->
									</el-table-column>
									<el-table-column prop="state" label="是否禁用">
										<template slot-scope="scope">
											{{scope.row.state==1?'是':'否'}}
										</template>
									</el-table-column>
									<el-table-column prop="description" label="描述">
									</el-table-column>
									<el-table-column label="操作">
										<template slot-scope="scope">
											<el-button type="success" @click="edit_admin(scope.row,scope.row.id)">编辑</el-button>
											<el-button type="danger" @click="del_admin(scope.row.id)">删除</el-button>
										</template>
									</el-table-column>
								</el-table>
							</el-tab-pane>
							<el-tab-pane label="分组管理" name="second">
								<template v-if="is_add == 1">
									<el-button style="display: flex;justify-content: flex-start;margin-bottom: 20px; margin-top: 10px; margin-left: 10px;"
									 type="primary" @click="add_group">添加分组</el-button>
									<el-table :data="group_list" stripe style="width: 100%">
										<el-table-column type="index" label="序号" width="80">
										</el-table-column>
										<el-table-column prop="name" label="分组名称" width="180">
										</el-table-column>
										<el-table-column prop="rule" label="分组规则">
											<template slot-scope="scope">
												<template v-for="item of scope.row.rule">
													{{rule_list_b[item].title}},
												</template>
											</template>
										</el-table-column>
										<el-table-column label="操作">
											<template slot-scope="scope">
												<el-button type="success" @click="edit_group(scope.row.id)">编辑</el-button>
												<el-button type="danger" @click="del_group(scope.row.id)">删除</el-button>
											</template>
										</el-table-column>
									</el-table>
								</template>
								<template v-if="is_add == 2">
									<el-button style="display: flex;justify-content: flex-start;margin-bottom: 20px; margin-top: 10px; margin-left: 10px;"
									 type="primary" @click="back">返回</el-button>
									<el-form ref="form" :model="add_group_form" label-width="90px">
										<el-form-item label="分组名">
											<el-input v-model="add_group_form.name" style="width: 300px;"></el-input>
										</el-form-item>
										<el-form-item label="分组规则">
											<el-checkbox-group v-model="add_group_form.oauth" size="medium" @change="choose_rule">
												<template v-for="item of rule_list">
													<el-col :span="6" style="text-align: left;">
														<el-checkbox :label="item.title" :value="item.id" border></el-checkbox>
													</el-col>
												</template>
											</el-checkbox-group>
										</el-form-item>
									</el-form>
									<div class="dialog-footer" style="text-align: left;padding: 10px;">
										<el-button type="primary" @click="sub">确 定</el-button>
									</div>
								</template>
							</el-tab-pane>
						</el-tabs>
					</el-main>
				</transition>
			</el-container>
		</el-container>
		<!-- 添加管理员弹窗 -->
		<el-dialog title="添加管理员" :visible.sync="add_admin_dialog" width="30%" :before-close="handleClose">
			<el-form ref="form" :model="form" label-width="90px">
				<el-form-item label="管理员分组">
					<el-select v-model="form.gid" placeholder="请选择分组" @change="get_gid">
						<template v-for="item of group_list">
							<el-option :label="item.name" :value="item.id"></el-option>
						</template>
					</el-select>
				</el-form-item>
				<el-form-item label="用户名">
					<el-input v-model="form.username"></el-input>
				</el-form-item>
				<el-form-item label="密码">
					<el-input type="password" v-model="form.password"></el-input>
				</el-form-item>
				<el-form-item label="姓名">
					<el-input v-model="form.nickname"></el-input>
				</el-form-item>
				<el-form-item label="描述">
					<el-input v-model="form.description"></el-input>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button @click="cancel_add">取 消</el-button>
				<el-button type="primary" @click="sub_add">确 定</el-button>
			</span>
		</el-dialog>
		<!-- 添加管理员弹窗结束 -->
		<!-- 修改管理员弹窗 -->
		<el-dialog title="修改管理员" :visible.sync="edit_admin_dialog" width="30%" :before-close="handleClose">
			<el-form ref="form" :model="edit_form" label-width="90px">
				<el-form-item label="管理员分组">
					<el-select v-model="edit_form.gid" placeholder="请选择分组">
						<template v-for="item of group_list">
							<el-option :label="item.name" :value="item.id"></el-option>
						</template>
					</el-select>
				</el-form-item>
				<el-form-item label="昵称">
					<el-input v-model="edit_form.nickname"></el-input>
				</el-form-item>
				<el-form-item label="描述">
					<el-input v-model="edit_form.description"></el-input>
				</el-form-item>
				<!-- <el-form-item label="是否禁用">
					<el-radio v-model="radio" :label="1">是</el-radio>
					<el-radio v-model="radio" :label="0">否</el-radio>
				</el-form-item> -->
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button @click="cancel_edit">取 消</el-button>
				<el-button type="primary" @click="sub_edit">确 定</el-button>
			</span>
		</el-dialog>
		<!-- 修改管理员弹窗结束 -->
		<!-- 添加分组弹窗 -->
		<el-dialog title="添加分组" :visible.sync="add_group_dialog" width="60%" :before-close="handleClose">

		</el-dialog>
		<!-- 添加分组弹窗结束 -->
		<!-- 修改分组弹窗 -->
		<el-dialog title="修改分组" :visible.sync="edit_group_dialog" width="60%" :before-close="handleClose">
			<el-form ref="form" :model="edit_group_form" label-width="90px">
				<el-form-item label="分组名">
					<el-input v-model="edit_group_form.name"></el-input>
				</el-form-item>
				<el-form-item label="分组规则">
					<el-checkbox-group v-model="edit_group_form.oauth" size="medium" @change="choose_rule">
						<template v-for="item of rule_list">
							<el-col :span="6" style="text-align: left;">
								<el-checkbox :label="item.title" :value="item.id" border></el-checkbox>
							</el-col>
						</template>
					</el-checkbox-group>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button @click="cancel_edit_group">取 消</el-button>
				<el-button type="primary" @click="sub_edit_group">确 定</el-button>
			</span>
		</el-dialog>
		<!-- 修改分组弹窗结束 -->

	</div>

</template>

<script>
	import NavTo from '@/components/navTo.vue'
	import Header from '@/components/header.vue'
	export default {
		data() {
			return {
				is_add: 1,
				choose_list: [],
				radio: 0,
				gid: '',
				add_admin_dialog: false,
				edit_admin_dialog: false,
				add_group_dialog: false,
				edit_group_dialog: false,
				tableData: [],
				group_list: [],
				activeName: 'first',
				rule_list: [{
					"id": 1,
					"name": "AdminManage,Backup,Group,System",
					"title": "管理员"
				}, {
					"id": 2,
					"name": "ProductManage\/addProduct",
					"title": "添加商品"
				}, {
					"id": 3,
					"name": "ProductManage\/deleteProduct",
					"title": "删除商品"
				}, {
					"id": 4,
					"name": "ProductManage\/editProduct",
					"title": "修改商品"
				}, {
					"id": 5,
					"name": "ProductManage\/getProduct",
					"title": "获取商品"
				}, {
					"id": 6,
					"name": "CategoryManage\/addCategory",
					"title": "增加分类"
				}, {
					"id": 7,
					"name": "CategoryManage\/deleteCategory",
					"title": "删除分类"
				}, {
					"id": 8,
					"name": "CategoryManage\/editCategory",
					"title": "修改分类"
				}, {
					"id": 9,
					"name": "CategoryManage\/getCateSort",
					"title": "获取分类"
				}, {
					"id": 10,
					"name": "OrderManage\/deleteOrder",
					"title": "删除订单"
				}, {
					"id": 11,
					"name": "OrderManage\/getOrderAll",
					"title": "获取订单列表"
				}, {
					"id": 12,
					"name": "OrderManage\/editCourier",
					"title": "订单发货"
				}, {
					"id": 13,
					"name": "ArticleManage\/addArticle",
					"title": "添加文章"
				}, {
					"id": 14,
					"name": "ArticleManage\/editArticle",
					"title": "修改文章"
				}, {
					"id": 15,
					"name": "ArticleManage\/deleteArticle",
					"title": "删除文章"
				}, {
					"id": 16,
					"name": "ArticleManage\/adminGetAllArticle",
					"title": "获取文章"
				}, {
					"id": 17,
					"name": "BannerManage\/addBanner",
					"title": "添加广告"
				}, {
					"id": 18,
					"name": "BannerManage\/deleteBanner",
					"title": "删除广告"
				}, {
					"id": 19,
					"name": "BannerManage\/editBanner",
					"title": "修改广告"
				}, {
					"id": 20,
					"name": "BannerManage\/adminAllBanner",
					"title": "获取广告"
				}, {
					"id": 21,
					"name": "NavManage\/addNav",
					"title": "添加导航"
				}, {
					"id": 22,
					"name": "NavManage\/editNav",
					"title": "修改导航"
				}, {
					"id": 23,
					"name": "NavManage\/deleteNav",
					"title": "删除导航"
				}, {
					"id": 24,
					"name": "NavManage\/getNav",
					"title": "获取导航"
				}, {
					"id": 25,
					"name": "RateManage",
					"title": "评价管理"
				}, {
					"id": 26,
					"name": "TuiManage",
					"title": "退款管理"
				}, {
					"id": 27,
					"name": "Common\\upValue",
					"title": "更新不同模型的布尔字段"
				}, {
					"id": 28,
					"name": "CouponManage",
					"title": "优惠券管理"
				}, {
					"id": 29,
					"name": "FxManage",
					"title": "分销管理"
				}, {
					"id": 30,
					"name": "Delivery",
					"title": "运费模板管理"
				}, {
					"id": 31,
					"name": "DiscountManage",
					"title": "限时折扣管理"
				}, {
					"id": 32,
					"name": "PtManage",
					"title": "拼团管理"
				}],
				group_list_b: [],
				rule_list_b: [],
				form: {
					nickname: '',
					username: '',
					description: '',
					gid: '',
					password: '',
					edi: '',
				},
				edit_form: {
					nickname: '',
					description: '',
					gid: '',
					id: ''
				},
				add_group_form: {
					name: '',
					oauth: []
				},
				edit_group_form: {
					name: '',
					oauth: [],
					id: ''
				}
			}
		},
		mounted() {
			this._load()
		},
		components: {
			Header,
			NavTo
		},

		methods: {
			sub() {
				this.http.post('group/createGroup', this.add_group_form).then(res => {
					this.$message({
						type: 'success',
						message: '添加成功!'
					});
					this.is_add = 1
					this._load()
				})
			},
			_load() {
				this.http.get('admins/get_admin_all').then(res => {
					this.tableData = res.data
				})
				// this.http.post('group/getGroupAll').then(res => {
				// 	this.group_list = res.data
				// 	let arr = []
				// 	for (let k in res.data) {
				// 		let v = res.data[k]
				// 		arr[v.id] = v
				// 	}
				// 	this.group_list_b = arr
				// })
				// this.http.get('group/admin/get_all_rule').then(res => {
				// 	this.rule_list = res.data
				// 	let arr = []
				// 	for (let k in res.data) {
				// 		let v = res.data[k]
				// 		arr[v.id] = v
				// 	}
				// 	this.rule_list_b = arr
				// })
			},
			//修改分组
			edit_group(id) {
				this.edit_group_dialog = true
				this.http.post('group/getGroupContent', {
					id: id
				}).then(res => {
					this.edit_group_form.id = res.data.id
					this.edit_group_form.name = res.data.name
					this.edit_group_form.oauth = res.data.oauth
					console.log(this.edit_group_form)
					let arr = []
					for (let g in this.rule_list) {
						let h = this.rule_list[g]
						for (let k in res.data.oauth) {
							let j = res.data.oauth[k]
							if (j == h.id * 1) {
								arr.push(h.title)
							}
						}
					}
					this.edit_group_form.oauth = arr
				})
				// this.edit_group_form.id = item.id
				// this.edit_group_form.name = item.name

			},
			// 提交修改
			sub_edit_group() {
				this.edit_group_form.oauth = this.choose_list
				this.http.post('group/updateGroup', this.edit_group_form).then(res => {
					this.$message({
						type: 'success',
						message: '修改成功!'
					});
					this.edit_group_form = {
						id: '',
						name: '',
						oauth: []
					}
					this.edit_group_dialog = false
					this._load()
				})
			},
			//取消修改
			cancel_edit_group() {
				this.edit_group_form = {
					id: '',
					name: '',
					oauth: []
				}
				this.edit_group_dialog = false
			},
			//删除分组
			del_group(id) {
				this.$confirm('确定删除该分组？', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.put('group/deleteGroup', {
						id: id
					}).then(res => {
						this.$message({
							type: 'success',
							message: '删除成功!'
						});
						this._load()
					})
				})
			},
			//获取所选的分组规则
			choose_rule(e) {
				console.log(e)
				let arr = []
				for (let k in this.rule_list) {
					let v = this.rule_list[k]
					for (let g in e) {
						let h = e[g]
						if (v.title == h) {
							arr.push(v.id)
						}
					}
				}
				this.choose_list = arr
				console.log(arr)
			},
			//添加分组
			add_group() {
				this.is_add = 2
				// this.add_group_dialog = true
			},
			back() {
				this.is_add = 1
			},
			//提交添加分组
			sub_add_group() {
				this.add_group_form.oauth = this.choose_list
				console.log(this.add_group_form)
				this.http.post('group/admin/add_group', this.add_group_form).then(res => {
					this.$message({
						type: 'success',
						message: '添加成功!'
					});
					this.add_group_form = {
						name: '',
						oauth: []
					}
					this.add_group_dialog = false
					this._load()
				})
			},
			//取消添加分组
			cancel_add_group() {
				this.add_group_form = {
					name: '',
					rule_ids: []
				}
				this.add_group_dialog = false
			},
			//修改管理员
			edit_admin(item, id) {
				console.log(item)
				this.edit_admin_dialog = true
				this.edit_form.gid = item.group_id
				this.edit_form.id = id
				this.edit_form.nickname = item.nickname
				this.edit_form.description = item.description
				console.log(this.edit_form)
			},
			//提交修改
			sub_edit() {
				console.log('admins')
				let form = {};
				form.id = this.edit_form.id;
				form.gid = this.edit_form.gid;
				form.description = this.edit_form.description;
				form.nickname = this.edit_form.nickname;
				this.http.post('admins/update_admin', {form: form}).then(res => {
					this.$message({
						type: 'success',
						message: '修改成功!'
					});
					this.edit_admin_dialog = false
					this.edit_form = {
						nickname: '',
						description: '',
						gid: '',
						id: ''
					}
					this._load()
				})
			},
			//取消修改
			cancel_edit() {
				this.edit_admin_dialog = false
				this.edit_form = {
					gid: '',
					id: '',
				}
			},
			//删除管理员
			del_admin(id) {
				console.log(id)
				this.$confirm('确定删除该管理员？', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.put('admins/deleteAdmin', {
						id: id
					}).then(res => {
						this.$message({
							type: 'success',
							message: '删除成功!'
						});
						this._load()
					})
				})
			},
			//添加管理员弹窗
			add_admin() {
				this.add_admin_dialog = true
			},
			//提交添加
			sub_add() {
				console.log(this.form.username.length)
				if (this.form.username.length < 3) {
					this.$message({
						message: '用户名长度最少为3位',
						type: 'warning'
					});
					this.form.username = ''
					return
				}
				if (this.form.password.length < 6) {
					this.$message({
						message: '密码长度不能小于6位',
						type: 'warning'
					});
					this.form.password = ''
					return
				}
				// if (!this.form.gid) {
				// 	this.$message({
				// 		message: '请选择管理员分组',
				// 		type: 'warning'
				// 	});
				// 	return
				// }
				console.log(this.form)
				this.http.post('admins/createAdmin', this.form).then(res => {
					this.$message({
						message: '添加成功',
						type: 'success'
					});
					this.form = {
						gid: '',
						username: '',
						password: ''
					}
					this.add_admin_dialog = false
					this._load()
				})
			},
			//取消添加
			cancel_add() {
				this.form = {
					gid: '',
					username: '',
					password: ''
				}
				this.add_admin_dialog = false
			},
			//获取所选分组id
			get_gid(e) {
				console.log(e)
			},
			handleClick(tab, event) {
				console.log(tab, event);
			},
			handleClose() {
				this.form = {
					gid: '',
					username: '',
					password: ''
				}
				this.edit_form = {
					gid: '',
					id: ''
				}
				this.add_group_form = {
					name: '',
					rule_ids: []
				}
				this.edit_group_form = {
					id: '',
					name: '',
					rule_ids: []
				}
				this.edit_group_dialog = false
				this.add_group_dialog = false
				this.edit_admin_dialog = false
				this.add_admin_dialog = false
			}
		},

	}
</script>

<style lang="less">
	.admin {
		background-color: #FFFFFF;

		.el-table__row {
			line-height: 40px !important;

			img {
				width: 80px !important;
				height: 80px !important;
			}
		}

		.el-main {
			height: auto !important;
			background-color: #F3F3F3;
			padding: 15px;

			.el-table {
				height: auto !important;
			}

			.el-table__body-wrapper,
			.is-scrolling-none,
			.el-table__body {
				height: auto !important;
			}
		}

		.article {
			line-height: 30px;
			background-color: #fff;
			padding: 15px;
			text-align: left;
		}

		.list-head {
			padding-bottom: 10px
		}

		.el-form-item__content {
			display: flex;
			justify-content: flex-start;
		}
	}
</style>
