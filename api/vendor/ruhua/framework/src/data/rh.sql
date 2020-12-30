SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小程序openid',
  `openid_app` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nickname` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `sign_time` int(11) NULL DEFAULT NULL COMMENT '上次签到时间',
  `sign_day` int(11) NULL DEFAULT NULL COMMENT '连续签到天数',
  `points` int(11) NULL DEFAULT 0 COMMENT '积分',
  `level_id` int(11) NULL DEFAULT 0 COMMENT '用户等级',
  `headpic` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机',
  `start` int(11) NULL DEFAULT NULL,
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户真实姓名',
  `is_visible` int(1) NOT NULL DEFAULT 1 COMMENT '1显示0隐藏',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '注册时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除',
  `update_time` int(11) NULL DEFAULT NULL,
  `money` float(11, 2) NOT NULL DEFAULT 0.00 COMMENT '余额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;
CREATE TABLE `sys_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  `switch` int(11) NOT NULL DEFAULT 0 COMMENT '0填写框1开关2单选3多选',
  `other` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置表' ROW_FORMAT = Compact;

INSERT INTO `sys_config` VALUES (1, 'api_url', '', 'API网址', 2, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (2, 'web_name', '', '公众号名称', 1, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (3, 'gzh_appid', '', '公众号appid', 2, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (4, 'gzh_secret', '', '公众号秘钥', 2, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (5, 'wx_app_id', '', '小程序appid', 2, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (6, 'wx_app_secret', '', '小程序秘钥', 2, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (7, 'pay_num', '', '商户id', 2, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (8, 'pay_key', '', '商户key', 2, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (9, 'wx_token_expire', '7200', 'token有效期', 1, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (10, 'merge_mode', '3', '账号关联', 1, 2, '1微信开放平台关联2手机关联3手机登录', NULL, NULL);
INSERT INTO `sys_config` VALUES (11, 'yzm_sign', '黔域', '阿里云短信签名', 3, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (12, 'yzm_keyid', '', '阿里云短信KeyId', 3, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (13, 'yzm_secret', '', '阿里云短信秘钥', 3, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (14, 'yzm_tmp_id', '', '验证码模板ID', 3, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (15, 'yzm_shops_sm', '', '入驻成功模板ID', 3, 0, NULL, NULL, NULL);
INSERT INTO `sys_config` VALUES (16, 'zfb_appid', '', '支付宝appid', 9, 0, '', NULL, NULL);
INSERT INTO `sys_config` VALUES (17, 'zfb_private_key', '0', '支付宝商户私钥', 9, 0, '', NULL, NULL);
INSERT INTO `sys_config` VALUES (18, 'zfb_public_key', '', '支付宝公钥', 9, 0, '', NULL, NULL);
INSERT INTO `sys_config` VALUES (19, 'zfb_back', '', '支付宝回调地址', 9, 0, '', NULL, NULL);
SET FOREIGN_KEY_CHECKS = 1;
