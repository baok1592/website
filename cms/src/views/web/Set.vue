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
						<div class="set">
							<el-tabs v-model="activeName">
								<el-tab-pane label="基础设置" name="first">
									<set-a :datas="abc"></set-a>
								</el-tab-pane>
								<el-tab-pane label="PC首页JSON" name="second">
									<el-row>
										<el-col :span="10" :offset="1">
											<ul class="index-json">
												<li v-for="i in pc_tmp.index_json_num">
													<span>{{ (i - 1) }}</span>
													<el-input type="textarea" :autosize="{ minRows: 2}" v-model="index_json[i - 1]"></el-input>
												</li>
											</ul>
										</el-col>
									</el-row>
									<el-button type="primary" @click="setIndexJson">提交</el-button>
								</el-tab-pane>
								<el-tab-pane label="移动端 tabbar" name="thirdly">
									<el-row class="mb-2">
										<el-col class="tabbar-set color-dray" :offset="1">底部导航一共仅能选择 {{this.tab_num}} 项，排序数值越大越靠右</el-col>
									</el-row>
									<!-- 选择底部导航 -->
									<template v-for="(i,index) in tab_num">
										<el-row class="mb-2" :key="i">
											<el-col class="tabbar-set flex" :span="23" :offset="1">
												<!-- <span>{{index}}</span> -->
												<!-- 排序 -->
												<span class="small-font">排序</span>
												<el-input type="tel" min="0" style="width: 80px;" v-model="tabbar_data[index].bottom_sort"></el-input>
												<!-- 输入tabbar显示的文字 -->
												<span class="small-font">显示的文字</span>
												<el-input v-model="tabbar_data[index].navigation_name" class="w-3" placeholder="输入tabbar显示的文字"></el-input>
												<!-- 选择类型 -->
												<span class="small-font">选择类型</span>
												<el-select :disabled="is_select" v-model="tabbar_data[index].category_type" placeholder="请选择类型" @change="changeType(index)">
												    <el-option
												      v-for="item in options_type"
												      :key="item.value"
												      :label="item.label"
												      :value="item.value">
												    </el-option>
												</el-select>
												<!-- 选择栏目 -->
												<span v-if="tabbar_data[index].category_type == 'list' || tabbar_data[index].category_type == 'cover'" class="small-font">选择栏目</span>
												<template v-if="tabbar_data[index].category_type == 'list'">
													<el-select :disabled="is_select" v-model="tabbar_data[index].category_id" placeholder="请选择栏目">
														<template v-for="item in options_list">
															<el-option v-if="item.level == 2"
															  :key="item.value"
															  :label="'|----'+item.label"
															  :value="item.value">
															</el-option>
															<el-option v-else
															  :key="item.value"
															  :label="item.label"
															  :value="item.value">
															</el-option>
														</template>
													</el-select>
												</template>
												<template v-if="tabbar_data[index].category_type == 'cover'">
													<el-select :disabled="is_select" v-model="tabbar_data[index].category_id" placeholder="请选择栏目">
														<template v-for="item in options_cover">
															<el-option v-if="item.level == 2"
															  :key="item.value"
															  :label="'|--'+item.label"
															  :value="item.value">
															</el-option>
															<el-option v-else
															  :key="item.value"
															  :label="item.label"
															  :value="item.value">
															</el-option>
														</template>
													    
													</el-select>
												</template>
												<!-- 是否显示 -->
												<span class="small-font">是否显示</span>
												<el-select style="width: 100px;" :disabled="is_select" v-model="tabbar_data[index].is_show" placeholder="是否显示">
												    <el-option
												      :label="'是'"
												      :value="1">
												    </el-option>
													<el-option
													  :label="'否'"
													  :value="0">
													</el-option>
												</el-select>
												<!-- <el-button type="danger" @click="subTabbar(index)">删除</el-button> -->
											</el-col>
										</el-row>
									</template>
									<!-- <el-row class="mb-2">
										<el-col :offset="1" class="tabbar-set">
											<el-button v-if="tab_num > tab_num_now" type="success" @click="addTabbar">新增</el-button>
										</el-col>
									</el-row> -->
									<el-row class="mb-2">
										<el-button type="primary" @click="tabbarSubmit">提交</el-button>
									</el-row>
								</el-tab-pane>
							</el-tabs>
						</div>
					</transition>
				</el-main>
			</el-container>
		</el-container>

	</div>

</template>

<script>
	import SetA from './set_config/Set-a.vue'
	import SetB from './set_config/Set-b.vue'
	import NavTo from '@/components/navTo.vue'
	import Header from "@/components/header.vue"
	
	export default {
		name: 'Set',
		data() {
			return {
				activeName: 'first',
				abc: [],
				pc_tmp: '',
				// 保存json数据
				index_json: [],
				// 在设置首页JSON时所需要的 id key
				set_index_data: {},
				// tabbar 列表
				options_list: [],
				options_cover: [],
				options_us: [],
				options_type: [
					{value: 'list', label: '列表'},
					{value: 'cover', label: '封面'},
					{value: 'us', label: 'us'},
				],
				// tabbar 最多选择项目数
				tab_num: 4,
				// 是否禁用 tabbar 选择
				is_select: false,
				// 当前已选 tabbar 个数
				tab_num_now: 1,
				// 保存 tabbar 设置的数据
				tabbar_data: [],
				// 控制删除按钮显示
				delete_btn_index: '',
			}
		},
		created() {
			this.getCategoryAll();
			this.tabbarDataInit();
		},
		components: {
			SetA,
			SetB,
			NavTo,
			Header
		},
		mounted() {
			this.getPCTmp();
		},
		methods: {
			// 初始化 tabbar 设置的数据
			async tabbarDataInit(index) {
				let data = [];
				this.tabbar_data = [];
				await this.http.get('/phone/bottomNavigation/get_bottom_navigation_all').then(res => {
					data = res.data;
				})
				for(let i = 0; i < this.tab_num; i++)
				{
					let dat = {};
					// 底部导航显示文字
					dat.navigation_name = data[i].navigation_name;
					// 底部导航排序
					dat.bottom_sort = data[i].bottom_sort;
					// 栏目的类型
					if(data[i].type == 'pic_list' || data[i].type == 'article_list') {
						dat.category_type = 'list';
					}
					else {
						dat.category_type = data[i].type;
					}
					// 栏目id
					dat.category_id = data[i].category_id;
					// 是否显示
					dat.is_show = data[i].is_show;
					// 底部导航id
					dat.id = data[i].id;
					this.tabbar_data.push(dat);
					dat = {};
				}
				
				// dat.index = this.tab_num_now - 1;
				console.log(this.tabbar_data)
			},
			// 获取当前模板
			async getPCTmp() {
				let that = this;
				let index_json = this.index_json;
				await this.http.get('common/template/get_pc_tep').then(res => {
					that.pc_tmp = res.data.tep;
					for(let i = 0; i < res.data.tep.index_json_num; i++)
					{
						index_json[i] = '';
					}
					that.index_json = index_json;
					that.getJsonID();
				})
			},
			// 获取 首页 JSON数据
			async getJsonID() {
				let that = this;
				await this.http.get('system/index_config').then(res => {
					// console.log('inde', res.data[0]);
					// console.log('vv', that.index_json);
					that.set_index_data = res.data[0];
					for(let i = 0; i < that.index_json.length; i++)
					{
						that.index_json[i] = that.set_index_data.values[i];
					}
					// console.log('vvv', that.index_json);
					// console.log('vvvv', that.set_index_data);
					// 强制刷新
					this.$forceUpdate()
				})
				
			},
			// 设置 首页 JSON 
			setIndexJson() {
				let that = this;
				let dat = [];
				let obj = {};
				let val = {};
				for(let i = 0; i < this.pc_tmp.index_json_num; i++)
				{
					val[i] = that.index_json[i];
				}
				obj['id'] = this.set_index_data.id;
				obj['key'] = this.set_index_data.key;
				obj['value'] = val;
				// dat.push(obj);
				// console.log(dat);
				this.http.post('system/admin/edit_index_config', obj).then(res => {
					this.$message({
						type: 'success',
						message: '提交成功'
					})
					that.getPCTmp();
				})
			},
			// 获取所有栏目
			async getCategoryAll() {
				const that = this;
				await this.http.get('category/admin/get_category_all').then(async res => {
					let dat = await res.data;
					for(let i = 0; i < dat.length; i++)
					{
						dat[i].value = dat[i].category_id;
						dat[i].label = dat[i].category_name;
					}
					that.options_list = dat.filter(item => item.type == 'pic_list' || item.type == 'article_list' || item.type == 'list');
					that.options_cover = dat.filter(item => item.type == 'cover');
				});
				
			},
			// 改变类型
			changeType(index) {
				this.tabbar_data[index].category_id = '';
				if(this.tabbar_data[index].category_type == 'list') {
					this.tabbar_data[index].category_id = this.options_list[0].category_id;
				}
			},
			// 新增 tabbar
			addTabbar() {
				if(this.tab_num_now < this.tab_num) {
					this.tab_num_now++;
					// 当 tabbar 增加并且数据中也没有时
					if(!this.tabbar_data[this.tab_num_now]) {
						// 再增加一个 tabbar 数据
						this.tabbarDataInit();
					}
				}
			},
			// 减少 tabbar
			subTabbar(index) {
				if(this.tab_num_now > 0) {
					this.tab_num_now--;
				}
				// 删除对应的项
				let dat = new Set(this.tabbar_data);
				dat.forEach(item => {
					if(item.index == index) {
						dat.delete(item);
					}
				})
				this.tabbar_data = Array.from(dat);
				// 重新将 index 从 0 开始赋值
				for(let i = 0; i < this.tabbar_data.length; i++)
				{
					this.tabbar_data[i].index = i;
				}
				// console.log(this.tabbar_data)
				
			},
			// tabbar 提交
			tabbarSubmit() {
				let flag = false;
				for(let i = 0; i < this.tabbar_data.length; i++)
				{
					if(this.tabbar_data[i].navigation_name == '') {
						this.$message({
						  message: 'tabbar 显示的文字不能为空，请填写',
						  type: 'warning'
						});
						flag = false;
						break;
					}
					else if(this.tabbar_data[i].category_type == '') {
						this.$message({
						  message: 'tabbar 类型不能为空，请填写',
						  type: 'warning'
						});
						flag = false;
						break;
					}
					else if(this.tabbar_data[i].category_type == 'cover' && this.tabbar_data[i].category_id == '') {
						this.$message({
						  message: '栏目不能为空，请填写',
						  type: 'warning'
						});
						flag = false;
						break;
					}
					else {
						flag = true;
					}
				}
				if(flag) {
					// console.log(this.tabbar_data)
					let that = this;
					this.http.post('/system/admin/up_bottom_navigation', this.tabbar_data).then(res => {
						this.$message({
						  message: '提交成功',
						  type: 'success'
						});
						that.tabbarDataInit();
						// location.reload();
					})
				}
				// console.log(this.tabbar_data)
			},
			
		}
	}
</script>

<style lang="less" scoped>
	.set {
		line-height: 30px;
		
		.tabbar-set {
			text-align: left;
		}
		
		.flex {
			display: flex;
			align-items: center;
			>* {
				display: inline-block;
				margin-right: 20px;
				&:last-child {
					margin-right: 0;
				}
			}
		}
		
		.color-dray {
			color: #777;
		}
		
		.is-select {
			display: inline-block;
			margin: auto 20px;
			span {
				&:first-child {
					color: #777;
				}
				&:not(:first-child) {
					color: #3c96f0;
				}
			}
			.mr-2 {
				margin-right: 20rpx;
			}
		}
	}
	.index-json {
		list-style: none;
		
		li {
			display: flex;
			margin-bottom: 10px;
			
			span {
				display: inline-block;
				margin-right: 10px;
			}
		}
	}
	.inline-block {
		display: inline-block;
	}
	.mr-2 {
		margin-right: 20px;
	}
	.mb-2 {
		margin-bottom: 20px;
	}
	.w-1 {
		width: 100px;
	}
	.w-3 {
		width: 300px;
	}
	span.small-font {
		color: #777;
		font-size: 0.7rem;
		margin-right: 10px !important;
		&::after {
			content: ":";
		}
	}
</style>
