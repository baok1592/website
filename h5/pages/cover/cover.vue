<template>
	<view class="cover">
		<view class="head" :style="{'background': 'url('+bg_url+')'}">
			<!-- <img class="img" :src="bg_url" alt=""> -->
		</view>
		<view class="content" v-html="content"></view>
		<tabbar v-if="is_tabbar"></tabbar>
	</view>
</template>

<script>
	import Tabbar from '@/components/tabbar.vue'
	
	export default {
		components: {
			Tabbar,
		},
		data() {
			return {
				content: '',
				bg_url:"",
				// 控制tabbar显示
				is_tabbar: true,
				// 控制返回键的显示与隐藏
				backButton: false,
			};
		},
		onLoad(option) {
			if(option.id) {
				this.getCoverByID(option.id);
			}
			if(option.tabbar_hide) {
				if(Number(option.tabbar_hide) == 1) {
					this.is_tabbar = false;
					this.backButton = true;
				}
			}
		},
		mounted() {
			if(this.backButton) {
				let backButton = document.getElementsByClassName('uni-page-head-btn');
				backButton[0].style.display = 'block';
			}
		},
		methods: {
			// 获取当前封面
			getCoverByID(id) {
				const _this = this;
				this.modulePublic.getCoverByID(id).then(res => {
					let dat = res.data[0].content;
					dat = dat.replace(/<img /g, '<img style="max-width: 100%"')
					_this.content = dat;
				});
			}
		},
	}
</script>

<style lang="scss" scoped>
.cover {
	padding-bottom: 110rpx;
	.head {
		height: 300rpx;
		background-color: #0086B3;
		overflow: hidden;
		background-size: cover;
		.img {
			width: 100%;
		}
	}
	.content {
		background-color: white;
		padding: 50rpx 20rpx 20rpx 20rpx;
		border-radius: 50rpx 50rpx 0 0;
		z-index: 999;
		margin-top: -50rpx;
	}
}

.uni-page-head-btn {
	display: block !important;
}
</style>
