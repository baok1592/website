<template>
	<view class="us">
		<!-- 地图 -->
		<view class="title">- 企业位置 -</view>
		<view class="maps">
			<map class="map" :latitude="latitude" :longitude="longitude"></map>
		</view>
		<!-- company_info -->
		<view class="company-info">
			<view class="title">- 联系我们 -</view>
			<template v-for="(item,index) in info">
				<view class="panel" :key="index">
					<text>{{item.desc}}</text>
					<text>{{item.value}}</text>
				</view>
			</template>
		</view>
		<tabbar></tabbar>
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
				latitude: 0,
				longitude: 0,
				// 保存 配置 信息
				info: [],
			};
		},
		created() {
			this.getSystemInfo();
		},
		methods: {
			// 获取配置信息
			getSystemInfo() {
				const _this = this;
				this.modulePublic.getSystemInfo().then(res => {
					let dat = [];
					dat = res.data;
					dat.forEach(item => {
						if(item.key == 'home_cpy') {
							_this.info.push(item);
						}
						else if(item.key == 'tel') {
							_this.info.push(item);
						}
						else if(item.key == 'cpy_address') {
							_this.info.push(item);
						}
						else if(item.key == 'longitude') {
							_this.longitude = item.value;
						}
						else if(item.key == 'latitude') {
							_this.latitude = item.value;
						}
					})
				})
			}
		}
		
	}
</script>

<style lang="scss" scoped>
.us {
	.maps {
		width: 100%;
		height: 400rpx;
		overflow: hidden;
		.map {
			width: 100%;
			height: 120%;
		}
	}
	.company-info {
		margin-top: 80rpx;
		.panel {
			padding-left: 40rpx;
			padding-right: 20rpx;
			min-height: 80rpx;
			display: flex;
			align-items: center;
			color: #555;
			text {
				&:first-child {
					display: inline-block;
					margin-right: 30rpx;
					flex-shrink: 0;
					font-weight: 600;
				}
			}
		}
	}
	.title {
		padding: 30rpx 20rpx;
		font-size: 1.1rem;
		font-weight: 600;
		text-align: center;
	}
}
</style>
