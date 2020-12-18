<?php
use think\facade\Route;


Route::get('', 'pc.PcView/index');
Route::group('', function() {
    Route::get('pc_index', 'pc.PcView/index');
    Route::get('pc_article_list', 'pc.PcView/article_list');
    Route::get('pc_pic_list', 'pc.PcView/pic_list');
    Route::get('pc_cover', 'pc.PcView/cover');
    Route::get('pc_article', 'pc.PcView/article');

});

//系统安装
Route::group('install', function () {
    Route::get('', 'install.Index/step1');
    Route::get('step2', 'install.Index/step2');
    Route::get('step3', 'install.Index/step3');
    Route::post('create_data', 'install.Index/createData');
});
Route::any('/ue_uploads', 'cms.Admins/ue_uploads');
Route::get('/cccc', 'install.Index/jumphome');
//Route::get('/jumphome','install.Index/jumphome');
//管理员Admins
Route::group('admins', function(){

    Route::get('/get_admin_all', 'cms.Admins/getAdmin_all');   //获取管理员
    Route::post('/createAdmin', 'cms.Admins/add_admin');   //添加管理员
    Route::put('/deleteAdmin', 'cms.Admins/del_admin');   //删除管理员
    Route::post('/update_admin', 'cms.Admins/up_admin');   //更新管理员
})->middleware('CheckCms');
//分类Category
Route::group('category', function(){

    Route::group('',function (){
        Route::get('get_one_category', 'cms.Category/getCategory'); //获取栏目详情
    });
    //管理员
    Route::group('admin', function(){
        Route::get('/get_category_all', 'cms.Category/get_categorySort'); //获取所有栏目并排好序，包括隐藏
        Route::put('/delete_category', 'cms.Category/del_category'); //删除栏目
        Route::get('get_one_category', 'cms.Category/getCategory'); //获取栏目详情
        Route::post('/update_category', 'cms.Category/up_category'); //更新栏目
        Route::post('/create_category', 'cms.Category/add_category'); //新增栏目
        Route::post('/update_category_sort', 'cms.Category/up_category_sort'); //更新栏目排序
        Route::post('/article_category', 'cms.Category/article_category_list'); //获取发文章的所有栏目

    })->middleware('CheckCms');
});
//文章Article
Route::group('article', function(){
    //管理员
    Route::group('admin', function(){
        Route::get('/get_article_all', 'cms.Article/get_article_list');    //获取所有文章列表
        Route::put('/delete_article', 'cms.Article/del_article');   //删除文章
        Route::put('push_article', 'cms.Article/push_article');   //推送文章
        Route::post('/create_article', 'cms.Article/add_article');   //新增文章
        Route::post('/update_article', 'cms.Article/up_article');  //修改文章
        Route::get('/get_article_content', 'cms.Article/get_article_content');  //获取某文章详情
        Route::post('/update_article_sort', 'cms.Article/up_article_sort');  //更新文章排序
        Route::get('labelRecommendation', 'cms.Article/label_recommendation');  //获取标签推荐内容
    })->middleware('CheckCms');
});

//广告Banner
Route::group('banner', function(){
    //管理员
    Route::group('admin', function(){
        Route::get('/banner_items_all', 'cms.Banner/bannerItems_all');    //获取所有广告列表
        Route::put('/delete_banner', 'cms.Banner/del_banner');   //删除广告
        Route::post('/create_banner', 'cms.Banner/add_banner');   //新增广告
        Route::post('/update_banner', 'cms.Banner/up_banner');  //修改广告
        Route::post('/update_banner_sort', 'cms.Banner/up_banner_sort'); //更新广告排序
        Route::get('/get_banner_content', 'cms.Banner/get_banner_content'); //获取某广告详情
    })->middleware('CheckCms');
});
//管理员
Route::group('admin', function(){
    Route::post('/login', 'cms.Admins/login');   //登陆
    Route::get('/check_login', 'cms.Admins/check_login');   //检查是否登陆
    Route::put('/onOff', 'cms.Admins/on_off')->middleware('CheckCms');   //更新某模型下布尔字段
    Route::post('/updatePassWord', 'cms.Admins/updatePassWord');   //修改密码
    Route::post('/ue_uploads', 'cms.Admins/ue_uploads');
});
//Image图片
Route::group('image', function(){
    //公共
    Route::group('', function(){

    });

    //管理员
    Route::group('', function(){
        Route::get('get_img_all', 'cms.Image/get_img_all');   //获取图片
        Route::post('upload_img', 'cms.Image/uploadImg');   //上传图片
        Route::delete('del_img','cms.Image/delImage');   //删除图片
    })->middleware('CheckCms');
});

//File文件
Route::group('file', function(){
    //公共
    Route::group('', function(){
        Route::get('del','cms.File/del_file');

    });

    //管理员
    Route::group('admin', function(){
        Route::get('get_file_all', 'cms.File/get_file_all');   //获取所有文件
        Route::post('upload_file', 'cms.File/upload_file');   //上传文件
    })->middleware('CheckCms');
});

//系统System
Route::group('system', function(){
    //公共
    Route::group('', function(){
        Route::get('index_config','common.IndexConfig/getConfig');//获取首页配置信息

    });

    //管理员
    Route::group('admin', function(){
        Route::post('edit_index_config','common.IndexConfig/up_config');//修改首页配置信息
        Route::get('/get_config', 'cms.System/getConfig');   //获取配置信息
        Route::post('/update_config', 'cms.System/up_config');  //修改配置信息
        Route::post('/edit_tep', 'common.Config/editNowTep');  //修改正在用的模板
        Route::post('up_bottom_navigation', 'phone.BottomNav/up_bottomNavigation');   //修改底部导航
    })->middleware('CheckCms');
});
//PC
Route::group('pc', function(){
    //首页
    Route::group('index',function () {
        Route::get('get_nav', 'PC.Index/GetNav');   //获取导航栏
        Route::get('get_banneritem', 'PC.Index/getBannerItem');   //获取导航栏
        Route::get('get_conter', 'PC.Index/getConter');   //获取首页中间部分
        Route::get('get_record', 'PC.Index/getRecord');   //获取网站底部备案信息
    });
    //列表页
    Route::group('list',function () {
        Route::get('get_list_column', 'PC.ArticleList/getColumn');   //获取列表页左侧导航
        Route::get('get_article_list', 'PC.ArticleList/getList');   //获取列表页的内容
    });
    //文章页
    Route::group('article',function () {
        Route::get('get_article', 'PC.Article/getArticle');   //获取文章内容
        Route::get('get_column', 'PC.Article/getColumn');   //获取文章左侧栏目
    });
});
//公共
Route::group('common',function (){
    Route::get('get_link','common.Link/getLink'); //获取友情链接
    //文章
    Route::group('article',function (){
        Route::get('search','common.Search/SearchArticle'); //搜索文章
        Route::get('get_all_article','common.Article/getAllArticle'); //获取所有文章
        Route::get('get_column_article','common.Article/getColumnArticle'); //获取某栏目列表下的文章列表
    });
    //封面
    Route::group('cover',function (){
        Route::get('get_all_cover','common.Column/getALLCover'); //获取所有封面
        Route::get('get_one_cover','common.Column/getOneCover'); //获取某一个封面
    });
    //模板
    Route::group('template',function (){
        Route::get('get_all_tep','common.Common/getALLTep'); //获取WEB所有模板
        Route::get('get_all_mtep','common.Common/getALLMTep'); //获WEB取所有手机模板
        Route::get('get_all_pctep','common.Common/getALLPCTep'); //获取WEB所有电脑模板
        Route::get('get_pc_tep','common.Config/getPCNowTep'); //获取pc端使用那一套模板
        Route::get('get_phone_tep','common.Config/getPhoneNowTep'); //获取手机端使用那一套模板
    });
    //分类
    Route::group('category',function (){
        Route::get('get_all_list','common.Column/getALLList'); //获取所有列表
        Route::get('get_all','common.Column/getALL'); //获取所有栏目
        Route::get('get_suBclassList','common.Common/getsuBclassList'); //获取子类所有数据
        Route::get('get_PclassList','common.Common/getPclassList'); //获取大类所有数据
    });
});
//Trashed软删除回收站
Route::group('softDeletion', function(){
    //公共
    Route::group('', function(){

    });

    //管理员
    Route::group('admin', function(){
        Route::get('add_articleTrashedAll', 'cms.SoftDeletion/add_articleTrashedAll');   //将article全部添加到回收站
        Route::get('add_categoryTrashedAll', 'cms.SoftDeletion/add_categoryTrashedAll');   //将category全部批量添加到回收站
        Route::post('add_articleTrashed', 'cms.SoftDeletion/add_articleTrashed');   //将article批量添加到回收站
        Route::post('add_categoryTrashed', 'cms.SoftDeletion/add_categoryTrashed');   //将category添加到回收站
        Route::get('get_trashed', 'cms.SoftDeletion/get_trashed');   //获取回收站里的所有数据
        Route::get('recovery', 'cms.SoftDeletion/recovery_trashed');   //恢复回收站里的所有数据
        Route::post('recovery_trashedBatch', 'cms.SoftDeletion/recovery_trashedBatch');   //批量恢复回收站里的数据
        Route::get('del_trashedAll', 'cms.SoftDeletion/del_trashedAll');   //一键清空回收站数据
        Route::post('del_trashedBatch', 'cms.SoftDeletion/del_trashedBatch');   //批量清空回收站数据
    })->middleware('CheckCms');
});
//手机版
Route::group('phone', function(){
    //公共
    Route::group('', function(){

    });

    //获取首页数据
    Route::group('index',function (){
        Route::get('get_nav', 'phone.Index/GetNav');   //获取导航栏
        Route::get('get_banneritem', 'phone.Index/getBannerItem');   //获取导航栏
        Route::get('get_conter', 'phone.Index/getConter');   //获取首页中间部分
        Route::get('get_record', 'phone.Index/getRecord');   //获取网站底部备案信息
    });

    //BottomNavigation底部导航
    Route::group('bottomNavigation', function(){
        Route::post('up_bottom_navigation', 'phone.BottomNavigation/up_bottomNavigation');   //修改底部导航
        Route::get('get_bottom_navigation_all', 'phone.BottomNav/get_bottomNavigationAll');   //获取所有底部导航数据
    });

    //User
    Route::group('user', function(){
        Route::get('send_mobile_code', 'User/send_mobile_code');   //发送验证码
        Route::post('bind_phone', 'User/bind_phone');   //绑定手机号
    });

});
//管理组Group
Route::group('group', function() {
    //公共
    Route::group('', function () {

    });

    //管理员
    Route::group('admin', function () {
        Route::get('/getGroupAll', 'cms.Group/getGroup_all');   //获取所有管理组
        Route::post('/createGroup', 'cms.Group/add_group');   //添加管理组
        Route::put('/deleteGroup', 'cms.Group/del_group');   //删除管理组
        Route::post('/updateGroup', 'cms.Group/up_group');   //更新管理组
        Route::post('/getGroupContent', 'cms.Group/get_group_content');   //获取某管理组详细
        Route::get('/get_interfaceAll', 'cms.AuthRule/get_interfaceAll');   //获取所有权限

    })->middleware('CheckCms');
});
    //模板
Route::group('temp', function(){
    //管理员
    Route::group('admin', function(){
        Route::get('get_all_temp', 'cms.Temp/getAllTemp');   //获取所有模板
        Route::post('add_temp', 'cms.Temp/addTemp');   //添加模板
        Route::post('edit_temp', 'cms.Temp/editTemp');   //修改模板


    })->middleware('CheckCms');
});
//数据库操作
Route::group('sql',function (){
    Route::get('backup','cms.Backup/data_backup');//数据库备份
    Route::get('backup_list','cms.Backup/backup_list');//备份文件列表
    Route::get('restore','cms.Backup/data_restore');//数据库还原
    Route::delete('delete','cms.Backup/delete');//删除备份文件
    Route::get('download','cms.Backup/downloadFile');//下载备份文件
});
//
//文件管理系统
Route::group('file_manage',function (){
    Route::get('get_load_file','cms.FileManage/get_load_file');//获取本地所有文件
    Route::delete('del_file','cms.FileManage/del_file');//删除文件
    Route::get('get_oss_file','cms.FileManage/get_oss_file');//获取oss所有文件
    Route::get('cs_oss','cms.FileManage/cs_oss');//测试oss链接
});
//日志管理
Route::group('log',function (){
    Route::get('get_log','cms.Log/getLog');//获取日志文件
    Route::delete('del_log','cms.Log/clear');//清空日志
    Route::delete('del_cache','cms.Log/clear_cache');//清空缓存
});
