<template>
	<div class="about">
		<el-drawer title="图库管理" :visible.sync="drawer" direction="rtl" size="32%" :before-close="handleClose">
			<span>
				<div class="rltan">
					<div class="btn">
						<el-button @click="dialogVisibleadd=true">添加</el-button>
					</div>
					<el-tabs v-model="activeName" type="card" @tab-click="handleClick">
						<el-tab-pane label="全部" :name="0+''"></el-tab-pane>
						<template v-for="item of img_category">
							<el-tab-pane :label="item.category_name" :name="item.id+''">
							</el-tab-pane>
						</template>

						<!-- <el-tab-pane label="配置管理" name="second"></el-tab-pane>
						<el-tab-pane label="角色管理" name="third"></el-tab-pane>
						<el-tab-pane label="定时任务补偿" name="fourth"></el-tab-pane> -->
					</el-tabs>
					<div class="con">
						<el-upload :action="upfile_url" :data="{cid:cate}" :on-success="res_banner_imgs" :headers="upfile_head"
						 :limit="5" multiple :show-file-list="false" :file-list="upfile_banner_list" name="image" :on-remove="handleRemove"
						 list-type="picture-card">
							<i class="el-icon-plus"></i>
						</el-upload>
						<el-dialog :visible.sync="dialogVisiblea">
							<!-- <img width="100%" :src="dialogImageUrl" alt=""> -->
						</el-dialog>
						<div style="height: 25px"></div>
						<el-row :gutter="18">
							<template v-if="cate == 0">
								<el-col :span="6" v-for="(item,index) of img_list" :key="index">
									<div :class="is_change(index)">
										<img class="img" :src="getimg + item.url" @click="choose_img(index)">
									</div>
								</el-col>
							</template>
							<template v-else>
								<el-col :span="6" v-for="(item,index) of imgB" :key="index">
									<div :class="is_change(index)">
										<img class="img" :src="getimg + item.url" @click="choose_img(index)">
									</div>
								</el-col>
							</template>
							<!-- <el-col :span="6" v-for="(item,index) of img_list" :key="index"> -->
							<!-- <div :class="is_change(index)"> -->
							<!-- <template v-if="cate == 0"> -->
							<!-- <img class="img" :src="getimg + item.url" @click="choose_img(index)"> -->
							<!-- </template> -->
							<!-- <template v-else>
										<template v-if="cate == item.category_id">
											<img class="img" :src="getimg + item.url" @click="choose_img(index)">
										</template>
									</template> -->
							<!-- </div> -->
							<!-- </el-col> -->
						</el-row>

					</div>
					<div class="footbtn">
						<!-- <el-button @click="hidden_img" v-if="show_choose == 1">删除</el-button> -->
						<el-button @click="change_del" v-if="show_choose == 1">选择删除</el-button>
						<el-button @click="cancel_del" v-if="show_del == 1">取消</el-button>
						<el-button @click="hidden_img" v-if="show_del == 1" type="warning">确定删除</el-button>
						<el-button type="primary" @click="add_img" v-if="show_choose  == 1">确定</el-button>
					</div>
				</div>
			</span>
		</el-drawer>
		<!-- 添加弹出框 -->
		<el-dialog title="添加图片分类" :visible.sync="dialogVisibleadd" width="30%">
			<el-form ref="cate_form" :model="cate_form" label-width="80px">
				<el-form-item label="分类名称">
					<el-input v-model="cate_form.category_name"></el-input>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button @click="dialogVisibleadd = false">取 消</el-button>
				<el-button type="primary" @click="onSubmit">确 定</el-button>
			</span>
		</el-dialog>
	</div>
</template>
<script>
	import {
		Api_url
	} from "@/common/config";
	export default {
		data() {
			return {
				getimg: this.$getimg,
				upfile_url: Api_url + "image/upload_img ",
				upfile_head: {
					token: localStorage.getItem("token")
				},

				upfile_list: [], //上传文件列表
				upfile_list_sku: [], //上传文件列表--规格
				upfile_banner_list: [], //上传幻灯片列表
				activeName: 'first',
				form: {
					name: '',
					banner_imgs: ''
				},
				dialogVisibleadd: false,
				dialogVisiblea: false,
				img_list: [],
				img_category: '',
				cate: '0',

				cate_form: {
					category_name: '',
				},
				checkList: [],
				add_img_list: [],
				show_del: '',
				show_choose: 1,
				img_length: ''
			}
		}, 
		props: {
			drawer:'',
			length:'',
			ishead:'',
			fathers: {
				type: Function,
				default: null
			}
		},
		components: {},
		mounted() {
			this._load()
			this.checkList = []
			this.img_length = this.length
			console.log(this.fathers)
		},
		methods: {
			_load() {
				this.http.get('image/get_img_all').then(res => {
					this.img_list = res.data.data
				}) 
			},


			//新增
			onSubmit() {
				this.http.post('img_category/admin/add_category', this.cate_form).then(res => {
					this.$message({
						message: '添加成功',
						type: 'success'
					});
					this.dialogVisibleadd = false
					this._load()
				})
			},

			change_del() {
				this.checkList = []
				this.show_del = 1
				this.show_choose = ''
				this.length = this.img_list.length
			},
			cancel_del() {
				this.checkList = []
				this.show_choose = 1
				this.show_del = ''
				this.length = this.img_length
			},
			add_img() {
				console.log(this.fathers)
				const that = this
				for (let v in this.checkList) {
					for (let r in this.img_list) {
						if (this.checkList[v] == r) {
							that.add_img_list.push({
								id: this.img_list[r].id,
								url: this.img_list[r].url
							})
						}
					}
				}
				console.log(this.add_img_list)
				console.log(this.length)
				if (this.add_img_list.length > this.length) {
					this.$message({
						message: '最多选择' + this.length + '张图片',
						type: 'warning'
					});
					this.add_img_list = []
					this.checkList = []
					return
				} else {
					if (that.ishead) {
						this.$emit('get_headpic', this.add_img_list)
						let drawer = false
						that.$emit('drawer', drawer)
						this.add_img_list = []
						this.checkList = []
						this.drawer = false
					} else {
						this.$emit('get_img', this.add_img_list)
						let drawer = false
						this.checkList = []
						that.$emit('drawer', drawer)
						this.fathers();
						this.add_img_list = []
						
						this.drawer = false
					}


				}

			},
			is_change(index) {
				if (this.checkList.indexOf(index) > -1) {
					return 'pic1'
				} else {
					return 'pic'
				}
			},

			choose_img(inde) {
				console.log(this.length)
				const that = this
				if (that.checkList.indexOf(inde) > -1) {
					let index = that.checkList.indexOf(inde)
					that.checkList.splice(index, 1)
				} else {
					if (that.checkList.length < that.length) {
						that.checkList.push(inde)
					} else {
						return
					}
				}
			},
			hidden_img() {
				let ids = []
				for (let v in this.checkList) {
					for (let r in this.img_list) {
						if (this.checkList[v] == r) {
							ids.push(this.img_list[r].id)
						}
					}
				}
				console.log(ids)
				this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.post('img_category/admin/edit_image', {
						ids: ids
					}).then(res => {
						this.$message({
							type: 'success',
							message: res.msg
						});
						this._load()
						this.checkList = []
						this.cancel_del()
					})
				}).catch(() => {
					this.$message({
						type: 'info',
						message: '已取消删除'
					});
					this.checkList = []
					this.cancel_del()
				});

			},
			res_banner_imgs(res) {
				// if (res.code == 201) {
				// 	if (this.form.banner_imgs.length < 1) {
				// 		this.form.banner_imgs = res.id;
				// 	} else {
				// 		this.form.banner_imgs = this.form.banner_imgs + "," + res.id;
				// 	}

				// }
				// console.log(res)
				// this.img_list.push({id:res.data[0].id,url:res.data[0].url})
				// console.log(this.img_list)
				// setTimeout(()=>{
				// 	this._load()
				// },1000)
				this.$message({
					type: 'success',
					message: '上传成功'
				});
				this._load()
			},
			handleRemove() {

			},
			handleClick(event) {
				this.cate = event.name
				let arr = []
				for (let v in this.img_list) {
					let k = this.img_list[v]
					if (k.category_id == event.name) {
						arr.push(k)
					}
				}
				this.imgB = arr
			},
			handleClose(done) {
				const that = this
				let drawer = false
				that.$emit('drawer', drawer)
				done();
			}
		}
	}
</script>
<style lang="less">
	.about {
		text-align: left;
		padding: 20px;
	}

	.rltan {
		padding: 0 20px 0px;

		.el-upload--picture-card {
			width: 120px;
			height: 120px;
			display: flex;
			justify-content: center;
			align-items: center;
		}

		.btn {
			margin-bottom: 20px;
		}

		.pic {
			display: flex;
			flex-wrap: wrap;
			justify-content: space-around;
			margin: 10px 0;

			img {
				width: 106px;
				height: 106px;
				border: 5px solid #BFBFBF;
				border-radius: 3px;
			}
		}

		.pic1 {
			display: flex;
			flex-wrap: wrap;
			justify-content: space-around;
			margin: 10px 0;

			img {
				width: 106px;
				height: 106px;
				border: 5px solid #FA2736;
				border-radius: 3px;
			}
		}

		.con {
			overflow-y: scroll;
			overflow-x: hidden;
			height: 600px;
			width: 100%;
		}

		.footbtn {
			text-align: right;
			position: fixed;
			bottom: 20px;
			right: 20px;
			background-color: #fff;
			z-index: 99;
		}
	}
</style>
