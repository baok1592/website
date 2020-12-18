<template>
	<div class="root">
		<el-menu :default-active="act" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose" background-color="#545c64"
		text-color="#fff" active-text-color="#ffd04b" @select="handleSelect"> 
			<el-menu-item index="4">
				<span slot="title"></span>
			</el-menu-item>
			<el-menu-item index="1" @click="jump_tohome">
				<span slot="title">首页</span>
			</el-menu-item>
			<el-menu-item index="2" @click="jump_tocategory">
				<span slot="title" >栏目管理</span>
			</el-menu-item>
			<el-menu-item index="3" @click="jump_toarticle">
				<span slot="title" >文章管理</span>
			</el-menu-item>
			<el-menu-item index="5" @click="jump_toad">
				<span slot="title">广告管理</span>
			</el-menu-item>
			<el-menu-item index="6" @click="jump_toindex_manage">
				<span slot="title">模板管理</span>
			</el-menu-item>
			
			<!-- <el-submenu index="9">
				<template slot="title">
					<span>用户</span>
				</template>
				<el-menu-item-group>
					<el-menu-item index="9-1">
						<span slot="title" style="margin-left: 40px;">用户列表</span>
					</el-menu-item>
					<el-menu-item index="9-2">
						<span slot="title" style="margin-left: 40px;">积分</span>
					</el-menu-item>
				</el-menu-item-group>
			</el-submenu> -->
			<el-submenu index="7">
				<template slot="title">
					<span>设置</span>
				</template>
				<el-menu-item-group>
					<el-menu-item index="7-1" @click="jump_toset">
						<span slot="title" style="margin-left: 40px;">站点设置</span>
					</el-menu-item>
					<el-menu-item index="7-2" @click="jump_toadmin">
						<span slot="title" style="margin-left: 40px;">管理员</span>
					</el-menu-item>
				</el-menu-item-group>
			</el-submenu>
			<!-- <el-menu-item index="6" @click="logout">
				<span slot="title">退出</span>
			</el-menu-item> -->
			<el-menu-item index="11" disabled style="cursor:default">
				<span slot="title"></span>
			</el-menu-item>
			<el-menu-item index="111" disabled style="cursor:default">
				<span slot="title"></span>
			</el-menu-item>
			<el-menu-item index="411" disabled style="cursor:default">
				<span slot="title"></span>
			</el-menu-item>
			<el-menu-item index="4111" disabled style="cursor:default">
				<span slot="title"></span>
			</el-menu-item>
			<el-menu-item index="42" disabled style="cursor:default">
				<span slot="title"></span>
			</el-menu-item>
			<el-menu-item index="43" disabled style="cursor:default">
				<span slot="title"></span>
			</el-menu-item>
			<el-menu-item index="44" disabled style="cursor:default">
				<span slot="title"></span>
			</el-menu-item>
			<el-menu-item index="45" disabled style="cursor:default">
				<span slot="title"></span>
			</el-menu-item>
			<el-menu-item index="46" disabled style="cursor:default">
				<span slot="title"></span>
			</el-menu-item>

		</el-menu>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				act:'',
				activeIndex: '1',
				activeIndex2: '1',
				status: 0,
				msg: '确定退出？'
			}
			props:['act']
		},
		mounted(){
			this.act=localStorage.getItem("act");
		},
		methods: {
			logout() {
				this.$confirm('此操作将退出管理系统, 是否继续?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					localStorage.clear(); //清除所有缓存
					this.$router.push({
						path: '/',
					})
					this.$message({
						type: 'success',
						message: '退出成功!'
					});
				}).catch(() => {
					this.$message({
						type: 'info',
						message: '已取消'
					});
				});
			},
			handleOpen(key, keyPath) {
				console.log('handleOpen:',key, keyPath);
			},
			handleClose(key, keyPath) {
				console.log(key, keyPath);
			},
			handleSelect(key, keyPath) {
				console.log('handleSelect:',key, keyPath);
				this.act=key
				localStorage.setItem("act",key);
			},
			jump_template(){
				this.$router.push({
					path: '/product/template'
				})
			},
			jump_tocategory(){
				this.$router.push({
					path:'/article/Category'
				})
			},
			jump_toarticle(){
				this.$router.push({
					path:'/article/Article'
				})
			},
			jump_toindex_manage(){
				this.$router.push({
					path:'/web/index_manage'
				})
			},
			jump_good(){
				this.$router.push({
					path: '/good'
				})
			},
			jump_tohome() {
				this.$router.push({
					path: '/'
				})
			},
			
			
		
			jump_toad(){
				this.$router.push({
					path: '/views/web/ad'
				})
			},
			jump_toset(){
				this.$router.push({
					path: '/set'
				})
			},
			jump_toadmin(){
				this.$router.push({
					path: '/admin'
				})
			}
		}
	}
</script>

<style>
	.root {
		height: 100%;
		background-color: #545c64;
	}
	.el-menu-vertical-demo {
		min-height: 100vh;
	}
</style>
