<template>
	<view class="news-detail">
		<!-- 标题 -->
		<view class="title">{{news.title}}</view>
		<!-- 基本信息 -->
		<view class="info">
			<text class="author"><text>作者：</text>{{news.author}}</text>
			<text class="source"><text>来源：</text>{{news.source}}</text>
			<text class="time"><text>时间：</text>{{news.create_time}}</text>
		</view>
		<!-- 新闻内容 -->
		<view class="content" v-html="news.content"></view>
		<!-- 底线 -->
		<view class="foot">
			-- 人家是有底线的 --
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				// 新闻数据
				news: {
					// title: '大货车高速被特殊对待，服务区禁止大货车进入，出了事谁负责？',
					// content: '现在的生活节奏比较快，每一个人身上的压力都是比较大的，这时候很多人都会去选择一个高收入的行业，就比如说是大货车司机，不过由于大货车的特殊性，如今一些地区对于大货车也是有着一些不公平的对待。就比如说是在今年的国庆节期间，有不少大货车司机表示自己在高速公路上开车的时候遇到了不公平的对待，一位路过四川省高速公路的大货车司机表示，自己由于长时间开车感觉有些劳累，也深知疲劳驾驶的危害，就打算进服务区休息一下，没想到在高速服务区看到一个指示牌上面写着“禁止货车驶入服务区”。',
					// img: require('@/static/index/index-pro-1.jpg'),
					// source: '百度',
					// author: '李风',
					// time: '2020-10-12',
				},
			}
		},
		onLoad(option) {
			const _this = this;
			if(option.id) {
				let id = option.id;
				this.moduleArticle.getArticle(id).then(res => {
					_this.news = res.data[0];
					_this.news.content = _this.news.content.replace(/<img /g, '<img style="width: 100%"');
					// console.log(res.data[0])
				})
			}
		},
		
	}
</script>


<style lang="scss" scoped>
$color-primary: #444;
$color-title: #333;
$color-title-small: #777;

.news-detail {
	display: flex;
	flex-direction: column;
	padding: 20rpx;
	color: $color-primary;
	.title {
		color: $color-title;
		font-size: 1.2em;
		font-weight: 600;
		margin-bottom: 50rpx;
		margin-top: 30rpx;
	}
	.info {
		color: $color-title-small;
		margin-bottom: 50rpx;
		font-size: 0.7rem;
		>text {
			margin-right: 30rpx;
		}
	}
	.content {
		// text-indent: 2em;
		line-height: 1.7em;
		img, image {
			width: 100%;
		}
	}
	.foot {
		width: 100%;
		display: flex;
		justify-content: center;
		margin-top: 80rpx;
		margin-bottom: 40rpx;
		color: #bbb;
	}
}
</style>
