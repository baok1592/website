<template>
	<view class="container">
		<view class="main">
			<!-- banner -->
			<swiper class="swiper" :indicator-dots="true" :circular="true"
			 :autoplay="true" interval="5000" duration="500">
				<swiper-item v-for="(item,index) in swiperList" :key="index">
					<image class="img" :src="item" mode="scaleToFill"></image>
				</swiper-item>
			</swiper>
			<!-- help -->
			<view class="help">
				<!-- <view class="help_01">I'll HELP YOU </view>
				<view class="help_02"><img src="@/static/imgs/help.jpg"></img></view>
				<view class="help_03">品牌推广帮您搞定</view> -->
				<view class="help_04">
					<template v-for="(item,index) in nav_list">
						<view class="help_04_01" @tap="toGo(item.category_id, item.type)">
							<i class="iconfont iconchanpin"></i>
							<p>{{item.category_name}}</p>
						</view>
					</template>
				</view>
			</view>
			<template v-for="(item,index) in lists_data">
				<!-- 图片列表 -->
				<view class="products" v-if="item.type == 'pic_list'">
					<view class="title">{{item.category_name}}</view>
					<view class="title_small">{{item.short_name}}</view>
					<view class="lists">
						<template v-for="res in item.article">
							<view class="list" :key="res.id" @tap="picListToGo(res.id)">
								<view class="img">
									<image :src="Api_url+res.img_id" mode="heightFix"></image>
								</view>
								<view class="list-title">{{res.title}}</view>
								<view class="list-content" v-html="res.short_title"></view>
							</view>
						</template>
					</view>
				</view>
				<!-- 文章列表 -->
				<view class="news" v-if="item.type == 'article_list'">
					<view class="title">
						<text>{{item.category_name}}</text>
						<!-- <text @tap="toGoNews">更多</text> -->
					</view>
					<template v-for="res in item.article">
						<news-panel :key="res.id" :data="res" class="news-list"></news-panel>
					</template>
				</view>
			</template>
		</view>
		<tabbar></tabbar>
	</view>
</template>

<script>
	import Tabbar from '@/components/tabbar.vue'
	import NewsPanel from '@/components/news-panel.vue'
	
	export default {
		components: {
			Tabbar,
			NewsPanel,
		},
		data() {
			return {
				Api_url: this.Api_url,
				// 显示每个栏目文章在主页的个数
				category_num: 4,
				// 保存导航列表
				nav_list: [],
				// 导航显示个数
				nav_num: 4,
				// 保存所有推荐到首页的栏目和文章
				lists_data: [],
				// banners
				swiperList: [{
						id: 0,
						type: 'image',
						url: 'https://ossweb-img.qq.com/images/lol/web201310/skin/big84000.jpg'
					}, {
						id: 1,
						type: 'image',
						url: 'https://ossweb-img.qq.com/images/lol/web201310/skin/big37006.jpg',
					}, {
						id: 2,
						type: 'image',
						url: 'https://ossweb-img.qq.com/images/lol/web201310/skin/big39000.jpg'
					}, {
						id: 3,
						type: 'image',
						url: 'https://ossweb-img.qq.com/images/lol/web201310/skin/big10001.jpg'
					}, {
						id: 4,
						type: 'image',
						url: 'https://ossweb-img.qq.com/images/lol/web201310/skin/big25011.jpg'
					}, {
						id: 5,
						type: 'image',
						url: 'https://ossweb-img.qq.com/images/lol/web201310/skin/big21016.jpg'
					}, {
						id: 6,
						type: 'image',
						url: 'https://ossweb-img.qq.com/images/lol/web201310/skin/big99008.jpg'
				}],
			}
		},
		created() {
			this.getHomeNav();
			this.getRecommendAll();
			this.getBanner();
		},
		methods: {
			// 跳转 news
			toGoNews() {
				uni.setStorageSync('tabbar_index', 2);
				uni.reLaunch({
					url: '../article_list/article_list'
				})
			},
			// 获取首页导航
			getHomeNav() {
				const _this = this;
				this.modulePublic.getHomeNav().then(res => {
					for(let i = 0; i < res.data.length; i++)
					{
						if(res.data[i].type.indexOf('_100') == -1) {
							_this.nav_list.push(res.data[i]);
						}
						if(_this.nav_list.length >= 4) {
							break;
						}
					}
				})
			},
			// 点击导航跳转对应页面
			toGo(id, type) {
				if(type == 'cover') {
					uni.navigateTo({
						url: '../cover/cover?id=' + id + '&tabbar_hide=1',
					})
				}
				else if(type == 'article_list') {
					uni.navigateTo({
						url: '../article_list/article_list?id=' + id + '&tabbar_hide=1'
					})
				}
				else if(type == 'pic_list') {
					uni.navigateTo({
						url: '../pic_list/pic_list?id=' + id + '&tabbar_hide=1'
					})
				}
			},
			// 首页图片列表跳转详情页面
			picListToGo(id) {
				uni.navigateTo({
					url: '../article/article?id=' + id
				})
			},
			// 获取推荐到首页的栏目和文章
			async getRecommendAll() {
				const _this = this;
				await this.moduleArticle.getRecommendAll().then(async res => {
					// console.log('res', res)
					_this.lists_data = res.data;
					// 当某个栏目下没有文章时，获取该栏目下子类的所有文章
					for(let key in res.data)
					{
						if(res.data[key].article.length <= 0) {
							await _this.moduleArticle.getSubCategoryByID(res.data[key].category_id).then(result => {
								// 将所有子栏目下的文章组合起来
								for(let j = 0; j < result.data.data.length; j++)
								{
									_this.lists_data[key].article.push.apply(_this.lists_data[key].article, result.data.data[j].Article);
								}
							})
						}
					}
					// 截取每个栏目下的前4个文章
					for(let i = 0; i < _this.lists_data.length; i++)
					{
						if(_this.lists_data[i].article) {
							_this.lists_data[i].article = _this.lists_data[i].article.slice(0, _this.category_num);
						}
					}
				})
			},
			// 获取首页banner
			getBanner() {
				this.swiperList = this.testData.banner;
				// const _this = this;
				// this.modulePublic.getBanner().then(res => {
				// 	_this.swiperList = res.data;
				// })
			},
			
		}
	}
</script>

<style lang="scss" scoped>
.container {
	color: #444;
	padding-bottom: 120rpx;
	//banner
	.swiper {
		height: 150px;
		width: 100%;
		text-align: center;
		.img {
			width: 100%;
		}
	}
	// help
	.help {
		text-align: center;
		padding: 25px 20px;
		.help_01 {
			font-size: 15px;
			padding-bottom: 3px;
		}
		.help_02 img {
			width: 150px;
			height: 15px;
		}
		.help_03 {
			font-size: 17px;
			padding-top: 2px;
		}
		.help_04 {
			display: flex;
			justify-content: space-between;
			padding: 20px 0 10px;
			.help_04_01 i {
				font-size: 1.5em;
				color: #777;
			}
			.help_04_01 p {
				color: #7A7A7A;
				padding-top: 7px;
			}
		}
	}
	// 产品列表
	.products {
		width: 100%;
		display: flex;
		flex-direction: column;
		padding: 50rpx;
		text-align: center;
		color: #444;
		>view {
			width: 100%;
		}
		.title {
			font-size: 1.2rem;
			margin-bottom: 15rpx;
			font-weight: 600;
			&::before
			{
				display: inline-block;
				margin-right: 10rpx;
				content: "-";
				color: #888;
			}
			&::after {
				display: inline-block;
				margin-left: 10rpx;
				content: "-";
				color: #888;
			}
		}
		.title_small {
			font-size: 0.8rem;
		}
		.lists {
			display: flex;
			justify-content: space-between;
			flex-wrap: wrap;
			overflow: hidden;
			width: 100%;
			.list {
				text-align: left;
				width: 45%;
				margin-top: 50rpx;
				overflow: hidden;
				.img {
					width: 100%;
					height: 200rpx;
					border-radius: 10rpx;
					overflow: hidden;
					image {
						width: 100%;
					}
				}
				.list-title {
					font-weight: 600;
					margin-bottom: 10rpx;
					white-space: nowrap;
					overflow: hidden;
					text-overflow: ellipsis;
				}
				.list-content {
					display: -webkit-box;
					-webkit-box-orient: vertical;
					-webkit-line-clamp: 2;
					overflow: hidden;
					font-size: 0.8rem;
					color: #777;
					// background-color: #0062CC;
					/* 
						使用多行进行限制显示行数不成功，
						因此添加高度以显示显示行数
					*/
					height: 68rpx;
				}
			}
		}
	}
	// 热点新闻
	.news {
		width: 100%;
		max-width: 100%;
		padding: 30rpx;
		>view {
			width: 100%;
		}
		.title {
			display: flex;
			justify-content: space-between;
			margin-bottom: 50rpx;
			text {
				&:first-child {
					font-size: 1.2rem;
					font-weight: 600;
				}
				&:nth-child(2) {
					color: #888;
				}
			}
		}
		.news-list {
			margin-bottom: 50rpx;
		}
	}
}
</style>
