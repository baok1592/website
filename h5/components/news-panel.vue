<template>
	<view class="news-panel" @tap="toGo">
		<view class="left">
			<view class="title">{{data.title}}</view>
			<view class="small-title">{{data.short_title}}</view>
			<view class="time">{{data.create_time}}</view>
		</view>
		<view class="right">
			<image class="img" :src="Api_url+data.img_id" mode=""></image>
		</view>
	</view>
</template>

<script>
	export default {
		props: {
			data: {
				type: Object,
				default: {
					title: '标题',
					short_title: '副标题',
					create_time: '2020-10-12',
				}
			}
		},
		data() {
			return {
				Api_url: this.Api_url,
			};
		},
		methods: {
			toGo() {
				uni.navigateTo({
					url: '../article/article?id=' + this.data.id
				})
			},
		}
	}
</script>

<style lang="scss" scoped>
.news-panel {
	width: 100%;
	max-width: 100%;
	display: flex;
	justify-content: space-between;
	overflow: hidden;
	padding-bottom: 20rpx;
	border-bottom: 2rpx solid #eee;
	.left {
		width: 70%;
		padding-right: 10rpx;
		.title, .small-title {
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
		}
		.title {
			color: #333;
			font-weight: 600;
		}
		.small-title {
			color: #999;
			font-size: 0.7rem;
			margin-top: 8rpx;
			margin-bottom: 15rpx;
		}
		.time {
			color: #888;
			font-size: 0.7rem;
		}
	}
	.right {
		flex-shrink: 0;
		width: 200rpx;
		height: 120rpx;
		.img {
			width: 100%;
			height: 100%;
			border-radius: 10rpx;
		}
	}
}
</style>
