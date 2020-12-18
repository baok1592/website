<template>
	<view class="tabbar">
		<template v-for="(item,index) in options">
			<view class="list" :key="index" @tap="toGo(item.path, index, item.id)" :class="{list_click: index == list_index}">
				<i class="iconfont" :class="item.icon"></i>
				{{item.text}}
			</view>
		</template>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				// 当前选中的 tabbar
				list_index: 0,
				// tabbar 模拟数据
				list: [
					{
						icon: 'iconchanpin',
						text: '产品列表',
						path: '/pages/pic_list/pic_list',
						id: -1,
					},
					{
						icon: 'iconxinwen',
						text: '新闻列表',
						path: '/pages/article_list/article_list',
						id: -1,
					},
					{
						icon: 'iconcoverage-fill',
						text: '封面',
						path: '/pages/cover/cover',
						id: -1,
					},
					{
						icon: 'icongeren1',
						text: 'us',
						path: '/pages/us/us',
						id: -1,
					},
				],
				// tabbar 数据
				options: [
					{
						icon: 'iconzhuye1',
						text: '主页',
						path: '/pages/index/index',
						id: 0,
					},
				],
			};
		},
		created() {
			if(uni.getStorageSync('tabbar_index')) {
				this.list_index = uni.getStorageSync('tabbar_index');
			}
			this.getTabbar();
		},
		methods: {
			// 跳转，选中 tabbar
			toGo(path, index, id) {
				uni.setStorageSync('tabbar_index', index);
				if(index == 0) {
					uni.redirectTo({
						url: path
					})
				}
				else {
					uni.redirectTo({
						url: path+'?id='+id
					})
				}
			},
			// 获取 tabbar
			async getTabbar() {
				let dat = {};
				const that = this;
				await this.modulePublic.getBottom().then(res => {
					dat = res.data;
				})
				
				// dat = this.testData.tabbar;
				
				dat = dat.filter(item => item.is_show == 1);
				for(let i = 0; i < dat.length; i++)
				{
					if(dat[i].type == 'pic_list') {
						that.options.push(this.list[0]);
					}
					else if(dat[i].type == 'article_list') {
						that.options.push(this.list[1]);
					}
					else if(dat[i].type == 'cover') {
						that.options.push(this.list[2]);
					}
					else if(dat[i].type == 'us') {
						that.options.push(this.list[3]);
					}
					that.options[i+1].text = dat[i].navigation_name;
					that.options[i+1].id = dat[i].category_id;
				}
				// console.log(this.options)
			},
		}
	}
</script>

<style lang="scss" scoped>
.tabbar {
	height: 100rpx;
	width: 100%;
	position: fixed;
	bottom: 0;
	left: 0;
	border-top: 2rpx solid #eee;
	padding: 10rpx;
	display: flex;
	justify-content: space-around;
	align-items: center;
	z-index: 9999;
	color: #999;
	background-color: #fff;
	
	.list {
		height: 100%;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		font-size: 0.6rem;
		i {
			width: 32rpx;
			height: 32rpx;
		}
		&_click {
			color: #333;
		}
	}
	
}
</style>
