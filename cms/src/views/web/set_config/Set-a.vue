<template>
	<div class="set-a">
		<el-form ref="form" label-width="100px">
			<el-form-item v-for="(item,index) in list" :label="item.desc" style="width: 70%">
				<template v-if="item.desc == '客服开关' || item.desc == '电话开关'" style="display: flex;justify-content: flex-start;">
					<template v-if="item.desc == '客服开关'">
						<el-row>
							<el-col :span="4">
								<el-switch v-model="item.value" :active-value="1" :inactive-value="0" active-color="#13ce66" inactive-color="#ff4949"
								 @change="change_kefu">
								</el-switch>
							</el-col>
						</el-row>
					</template>
					<template v-if="item.desc == '电话开关'">
						<el-row>
							<el-col :span="4">
								<el-switch v-model="item.value" :active-value="1" :inactive-value="0" active-color="#13ce66" inactive-color="#ff4949"
								 @change="change_phone">
								</el-switch>
							</el-col>
						</el-row>
					</template>

				</template>
				<template v-else-if="item.key == 'pc_tmp' || item.key == 'phone_tmp'">
					<el-input v-model="item.value" :disabled="true"></el-input>
				</template>
				<template v-else>
					<el-input v-model="item.value" v-if="item.desc!='关于我们'"></el-input>
					<div class="us" v-else>
						<vue-ueditor-wrap v-model="item.value" :config="myConfig"></vue-ueditor-wrap>
					</div>
				</template>
			</el-form-item>
			<el-form-item style="width: 80%;margin-top:20px;">
				<el-button type="primary" @click="onSubmit">提交修改</el-button>
			</el-form-item>
		</el-form>
	</div>
</template>

<script>
	import VueUeditorWrap from "vue-ueditor-wrap";
	import {
		Api_url
	} from "@/common/config";
	export default {
		name: "Set-a",
		data() {
			return {
				list: [],
				us: "",
				myConfig: {
					autoHeightEnabled: false,
					initialFrameHeight: 400,
					initialFrameWidth: "80%",
					serverUrl: Api_url + "ue_uploads",
					UEDITOR_HOME_URL: "/static/UEditor/",
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
					],
					edit_form: [{
						"id": 10,
						"type": 1,
						"value": "如花商城",
						"desc": "首页企业简介"
					}, {
						"id": 11,
						"type": 1,
						"value": "如花商城",
						"desc": "站点名称"
					}, {
						"id": 12,
						"type": 1,
						"value": "0859-3333333",
						"desc": "联系电话"
					}, {
						"id": 13,
						"type": 1,
						"value": "如花商城",
						"desc": "公司名称"
					}, {
						"id": 14,
						"type": 1,
						"value": "如花商城开源系统_新零售社交商城系统,Thinkphp+VUE+Uniapp开发商城",
						"desc": "SEO标题"
					}, {
						"id": 15,
						"type": 1,
						"value": "如花商城",
						"desc": "地址"
					}, {
						"id": 16,
						"type": 1,
						"value": "如花商城开源系统,采用TP6+VUE+Uniapp开发,简单易用的特点深受大家喜爱。欢迎thinkphp、vue、uniapp的爱好者交流学习商城系统",
						"desc": "SEO描述"
					}]
				}
			};
		},
		components: {
			VueUeditorWrap
		},
		//vue生命函数
		mounted() {
			this.post_config();
		},
		methods: {
			// 修改配置信息
			onSubmit() {
				var that = this;
				this.http.post("system/admin/update_config", that.list).then(res => {
					that.$message({
						showClose: true,
						message: "修改成功",
						type: "success"
					});
				});
			},
			post_config() {
				var that = this;
				this.http.get("system/admin/get_config").then(res => {
					that.list = res.data; //收藏返回的是商品和店铺
				});
			},
			change_kefu(){
				this.http.put('admin/onOff?id=17&db=sys_config&field=is_use').then(res=>{
					
				})
			},
			change_phone(){
				this.http.put('admin/onOff?id=18&db=sys_config&field=is_use').then(res=>{
					
				})
			}
		}
		
	};
</script>

<style lang="less">
	.set-a {
		.ts {
			text-align: left;
			color: #cc4747;
		}

		.el-form-item {
			margin-bottom: 12px !important;
		}

		.us {
			text-align: left;
			width: 80%;
		}
	}
</style>
