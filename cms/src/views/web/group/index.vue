<template>
	<div v-if="auth">
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
						<div class="manage">
							<el-tabs v-model="activeName" @tab-click="handleClick">
								<el-tab-pane label="用户列表" name="first">
									<UserList></UserList>
								</el-tab-pane>
								<el-tab-pane label="管理组" name="second">
									<SetGroup></SetGroup>
								</el-tab-pane>
								<el-tab-pane label="操作日志" name="third">
									<Logs></Logs>
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
	import UserList from './components/user_list.vue'
	import SetGroup from './components/set_group.vue'
	
	import NavTo from '@/components/navTo.vue'
	import Header from "@/components/header.vue";
	import Logs from './components/logs.vue'
	export default {
		name: 'Manage',
		data() {
			return {
				activeName: 'first',
				auth: false
			}
		},
		components: {
			UserList,
			SetGroup,
			Logs,
			Header,
			NavTo
		},
		methods: {
			handleClick(tab, event) {
				console.log(tab, event);
			},
			check_auth(name) {
				const auth = localStorage.getItem("oauth");
				if (auth.indexOf(name) < 0) {
					this.$message({
						message: '无权限',
						type: 'none'
					});
				} else {
					this.auth = true
				}
			}
		},
		mounted() {
			this.check_auth('member_list')
		}
	}
</script>

<style lang="less" scoped="">
	.manage {
		line-height: 30px;
	}
</style>
