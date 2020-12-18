<template>
	<view class="article-list">
		<!-- 头部 -->
		<view class="title" v-if="!sub_category_list.length">{{category_name}}</view>
		<view class="head-nav" v-if="sub_category_list.length">
			<text :class="{'text-Eff': nav_index==-1}" @tap="changeNavStyle(-1)">全部</text>
			<template v-for="(item,index) in sub_category_list">
				<text :class="{'text-Eff': nav_index==index}" @tap="changeNavStyle(index, item.category_id)">{{item.category_name}}</text>
			</template>
		</view>
		<!-- 分隔条 -->
		<view class="hr" v-if="sub_category_list.length"></view>
		<!-- 文章列表 -->
		<view class="lists">
			<template v-for="(item,index) in list">
				<news-panel class="list" :data="item" :key="index"></news-panel>
			</template>
		</view>
		<tabbar v-if="is_tabbar"></tabbar>
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
				// 当前栏目的id
				id: 0,
				// 当前导航栏
				nav_index: -1,
				// 是否存在下级分类
				is_category: true,
				// 当前栏目下的所有文章
				articles: [],
				// 当前栏目下所有子类的所有文章
				sub_articles: [],
				// 显示文章的列表
				list: [],
				// 当前栏目下的子栏目
				sub_category_list: [],
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
				let id = option.id;
				this.id = id;
				this.getArticleAllByID(id);
				this.getSubCategoryByID(id);
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
			// 点击改变 nav 样式
			changeNavStyle(index, category_id) {
				this.list = [];
				if(index == -1) {
					this.getSubCategoryByID(this.id);
					this.getArticleAllByID(this.id);
				}
				else {
					this.getArticleAllByID(category_id);
				}
				this.nav_index = index;
			},
			// 获取当前栏目下的文章
			getArticleAllByID(id) {
				const _this = this;
				this.moduleArticle.getArticleByID(id).then(res => {
					let dat = res.data.article;
					_this.category_name = res.data.column[0].category_name;
					_this.articles = dat;
					_this.addList(_this.articles);
				});
			},
			// 获取文章栏目下的所有子类及其信息
			getSubCategoryByID(id) {
				const _this = this;
				this.moduleArticle.getSubCategoryByID(id).then(res => {
					let dat = res.data.data;
					_this.sub_category_list = dat;
					// 将所有子栏目下的文章都放到显示列表中
					dat.forEach(item => {
						// 如果该子栏目下存在文章则加入
						if(item.Article.length) {
							_this.addList(item.Article);
						}
					})
					// console.log(_this.sub_category_list)
				});
			},
			// 把文章添加到显示列表中
			addList(list) {
				this.list = this.list.concat(list);
			}
		},
		
	}
</script>

<style lang="scss" scoped>
.article-list {
	padding-bottom: 80rpx;
	.title {
		font-size: 1.3rem;
		font-weight: 600;
		padding-left: 20rpx;
		padding-top: 30rpx;
		padding-bottom: 30rpx;
	}
	.hr {
		width: 100%;
		background-color: #eee;
		height: 20rpx;
	}
	.head-nav {
		width: auto;
		height: 100rpx;
		display: flex;
		align-items: center;
		overflow-y: scroll;
		text {
			flex-shrink: 0;
			display: flex;
			align-items: center;
			padding: 0 30rpx;
			height: 100%;
			border-top: 4rpx solid white;
			border-bottom: 4rpx solid white;
		}
		text.text-Eff {
			border-bottom: 4rpx solid #0062CC;
		}
	}
	.lists {
		padding: 20rpx;
		.list {
			margin-bottom: 50rpx;
		}
	}
}
</style>
