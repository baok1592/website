<template>
	<view class="pic-list">
		<view class="title">{{category_name}}</view>
		<view class="lists">
			<template v-for="(item,index) in articles">
				<view class="list" :key="index" @tap="toGo(item.id)">
					<view class="img">
						<image :src="Api_url + item.img_id" mode=""></image>
					</view>
					<view class="content">{{item.title}}</view>
				</view>
			</template>
		</view>
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
				// 当前栏目下的文章
				articles: [],
				Api_url: this.Api_url,
				// 控制tabbar显示
				is_tabbar: true,
				// 栏目名称
				category_name: '',
				// 控制返回键的显示与隐藏
				backButton: false,
			};
		},
		onLoad(option) {
			if(option.id) {
				this.getArticleAllByID(option.id);
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
			// 获取当前栏目下的文章
			getArticleAllByID(id) {
				const _this = this;
				this.moduleArticle.getArticleByID(id).then(async res => {
					_this.articles = res.data.article;
					// 栏目名称
					_this.category_name = res.data.column[0].category_name;
					// 当前栏目的id
					let id = res.data.column[0].category_id;
					if(_this.articles.length <= 0) {
						// 当某个栏目下没有文章时，获取该栏目下子类的所有文章
						await _this.moduleArticle.getSubCategoryByID(id).then(result => {
							// 将所有子栏目下的文章组合起来
							for(let j = 0; j < result.data.data.length; j++)
							{
								_this.articles.push.apply(_this.articles, result.data.data[j].Article);
							}
						})
					}
				});
			},
			// 跳转
			toGo(id) {
				uni.navigateTo({
					url: '../article/article?id='+id
				})
			},
		}
	}
</script>

<style lang="scss" scoped>
.pic-list {
	width: 100%;
	padding: 5%;
	padding-bottom: 120rpx;
	.title {
		font-size: 1.3rem;
		font-weight: 600;
		margin-bottom: 50rpx;
	}
	.lists {
		display: flex;
		flex-wrap: wrap;
		.list {
			width: 47%;
			margin-right: 6%;
			margin-bottom: 40rpx;
			&:nth-child(2n) {
				margin-right: 0;
			}
			.img {
				width: 100%;
				height: 200rpx;
				border-radius: 10rpx;
				overflow: hidden;
				image {
					width: 100%;
				}
			}
			.content {
				// display: -webkit-box;
				// -webkit-box-orient: vertical;
				// -webkit-line-clamp: 2;
				// overflow: hidden;
			}
		}
	}
}
</style>
