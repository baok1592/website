<template>
	<div class="root">
		 
		<el-form style="margin-left: 50px;" v-if="detail_value.type == 2">
			<!-- 需求详情页面 -->
			<el-form-item class="content" label="公司名:" style='width: 70%;margin-top: 50px;'>
				<div class="nr_c">{{list.demand_json.cpy}}</div>
			</el-form-item>
			<el-form-item class="content" label="需求名称:" style='width: 70%'>
				<div class="nr_c">{{list.demand_json.title}}</div>
			</el-form-item>
			<el-form-item class="content" label="发布时间:" style='width: 70%'>
				<div class="nr_c">{{list.update_time}}</div>
			</el-form-item>
			<el-form-item class="content" label="行业类型:" style='width: 70%'>
				<div class="nr_c">{{list.demand_json.hy}}</div>
			</el-form-item>
			<el-form-item class="content" label="需求类型:" style='width: 70%'>
				<div class="nr_c">{{list.demand_json.xq}}</div>
			</el-form-item>
			<el-form-item class="content" label="投入预算:" style='width: 70%'>
				<div class="nr_c">{{list.demand_json.yusuan}}</div>
			</el-form-item>
			<el-form-item class="content" label="截止日期:" style='width: 70%'>
				<div class="nr_c">{{list.demand_json.date}}</div>
			</el-form-item>
			<el-form-item class="content" label="联系人:" style='width: 70%'>
				<div class="nr_c">{{list.demand_json.people}}</div>
			</el-form-item>
			<el-form-item class="content" label="联系电话:" style='width: 70%'>
				<div class="nr_c">{{list.demand_json.tel}}</div>
			</el-form-item>
			
			<el-form-item class="content" label="电子邮箱:" style='width: 70%'>
				<div class="nr_c">{{list.demand_json.email}}</div>
			</el-form-item>
			
			<el-form-item class="content" label="所在地:" style='width: 70%'>
				<div class="nr_c">{{list.demand_json.address}}</div>
			</el-form-item>
			<el-form-item class="content" label="是否公开需求:" style='width: 70%'>
				<div class="nr_c">{{list.demand_json.is_gk?"是":'否'}}</div>
			</el-form-item>
			<template v-if="list.status == 0">
				<el-form-item class="content" label="管理员回复:" :placeholder="list.reply" style='width: 70%'>
					<el-input type="textarea" v-model="text"></el-input>
				</el-form-item> 
			</template>
			<template v-else>
				<el-form-item label="管理员回复:"></el-form-item>				
				<div class="ctt">
					<!-- <div v-html="transChar(list.reply.content, '\\n', '<br>')"></div> -->
					<div v-html="list.reply.content"></div>
				</div>
			</template>

			
			<template v-if="list.status == 0"> 
				<el-form-item style='width: 80%;margin-top:120px;'>
					<el-button type="primary" @click="onSubmit(list.id,list.status,text,detail_value.type)">确认回复</el-button>
				</el-form-item>
			</template>
		</el-form>
		<el-form style="margin-left: 50px;" v-if="detail_value.type == 3">
			<!-- 留言信息详情页 -->
			<el-form-item class="content" label="标题:" style='width: 70%;margin-top: 50px;height: 30px;'>
				<div class="nr_c">{{list.title}}</div>
			</el-form-item>
			<el-form-item class="content" label="时间:" style='width: 70%'>
				<div class="nr_c">{{list.update_time}}</div>
			</el-form-item>
			<el-form-item class="content" label="联系电话:" style='width: 70%'>
				<div class="nr_c">{{list.message_json.tel}}</div>
			</el-form-item>
			<el-form-item class="content" label="留言内容:" style='width: 70%'>
				<div class="nr_c">{{list.message_json.content}}</div>
			</el-form-item>
			<template v-if="list.status == 0">
				<el-form-item label="管理员回复:" :placeholder="list.reply" style='width: 70%'>
					<el-input type="textarea" v-model="text"></el-input>
				</el-form-item>
				<el-form-item style='width: 80%;'>
					<el-button type="primary" @click="onSubmit(list.id,list.status,text,detail_value.type)">确认回复</el-button>
				</el-form-item>
			</template>
			<template v-else>
				<el-form-item label="管理员回复:"></el-form-item>				
				<div class="ctt">
					<!-- <div v-html="transChar(list.reply.content, '\\n', '<br>')"></div> -->
					<div v-html="list.reply.content"></div>
				</div>
			</template>
		</el-form>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				textarea: '',
				text: '',
				list: [],
			}
		},
		props: ['detail_value'],
		created(options) {
			this.get_register()
		},
		methods: {
			transChar (val, patten, replaceChar) { 
			    if (!val) { 
					return ''
			    }    
			    let reg = new RegExp(patten, 'g')    
			    return val.replace(reg, replaceChar) 
			},
			get_register() {
				if (this.detail_value.type == 1) {
					this.http.get('/admin/register?id=' + this.detail_value.rid).then(res => {
						this.list = res.data
					})
				} else if (this.detail_value.type == 2) {
					this.http.get('/admin/demand?id=' + this.detail_value.rid).then(res => {
						this.list = res.data
					})
				} else if (this.detail_value.type == 3) {
					this.http.get('/admin/message?id=' + this.detail_value.rid).then(res => {
						this.list = res.data
					})
				}
			},
			onSubmit(id, status, reply, type) {
				status = 1
				if (type == 1) {
					this.http.post('/admin/up_register', {
						id: id,
						status: status,
						reply: reply,
					}).then(res => {
					})
				} else if (type == 2) {
					this.http.post('/admin/up_demand', {
						id: id,
						status: status,
						reply: reply,
					}).then(res => {
					})
				} else if (type == 3) {
					this.http.post('/admin/reply', {
						id: id,
						status: status,
						reply: reply,
					}).then(res => {
					})
				}
				setTimeout(() => {
					this.$emit('children')
				}, 1000)
			},
		},
	}
</script>

<style>
	.ctt{ 
		padding:0px 20px;
		line-height: 28px;
		text-align: left;
		width:60%;
		color:firebrick;
	}
	.content{
		height: 30px;
	}
	.nr_c{
		display: flex;
		justify-content: flex-start;
	}

</style>
