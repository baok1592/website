/*
 Navicat Premium Data Transfer

 Source Server         : XamppSQl
 Source Server Type    : MariaDB
 Source Server Version : 100414
 Source Host           : localhost:3306
 Source Schema         : qzgit123

 Target Server Type    : MariaDB
 Target Server Version : 100414
 File Encoding         : 65001

 Date: 30/12/2020 16:27:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for news_admins
-- ----------------------------
DROP TABLE IF EXISTS `news_admins`;
CREATE TABLE `news_admins`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `username` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `state` int(1) NOT NULL DEFAULT 0 COMMENT '是否禁用',
  `region_id` int(1) NOT NULL COMMENT '代理区域ID',
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `login_time` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for news_article
-- ----------------------------
DROP TABLE IF EXISTS `news_article`;
CREATE TABLE `news_article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NULL DEFAULT 0,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章标题',
  `short_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '短标题',
  `summary` varchar(140) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文章摘要',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章正文',
  `img_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章标题图片',
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-显示、1-隐藏',
  `author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布者用户名 ',
  `category_id` int(11) NOT NULL,
  `source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '来源',
  `type` int(11) NULL DEFAULT NULL COMMENT '0用户中1商家公告2商家中',
  `create_time` int(11) NULL DEFAULT 0 COMMENT '文章发布时间',
  `sort` int(11) NULL DEFAULT NULL,
  `externallinks` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reading_volume` int(11) NULL DEFAULT NULL COMMENT '阅读量',
  `label` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_slide` int(11) NULL DEFAULT 0 COMMENT '是否幻灯片0否1是',
  `is_index` int(11) NULL DEFAULT 0 COMMENT '是否首页0否1是',
  `is_headlines` int(11) NULL DEFAULT 0 COMMENT '是否头条0否1是',
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 AVG_ROW_LENGTH = 6553 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'CMS文章表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of news_article
-- ----------------------------
INSERT INTO `news_article` VALUES (1, 0, '海洋运输', '￥ 3200/次', '海洋运输又称“国际海洋货物运输”，是国际物流中最主要的运输方式。它是指使用船舶通过海上航道在不同国家和地区的港口之间运送货物的一种方式，在国际货物运输中使用最广泛。国际贸易总运量中的2/3以上，中国进出口货运总量的约90%都是利用海上运输。海洋运输对世界的改变是巨大的。', '<p>随着中国经济的快速发展，中国已经成为世界上最重要的海运大国之一。全球</p><p>有19%的大宗海运货物运往中国，有20%的<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E9%9B%86%E8%A3%85%E7%AE%B1%E8%BF%90%E8%BE%93/2474651\" data-lemmaid=\"2474651\" style=\"color: rgb(19, 110, 194); text-decoration-line: none;\">集装箱运输</a>来自中国；而新增的大宗货物海洋运输之中，有60%至70%是运往中国的。中国的<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E6%B8%AF%E5%8F%A3%E8%B4%A7%E7%89%A9%E5%90%9E%E5%90%90%E9%87%8F\" style=\"color: rgb(19, 110, 194); text-decoration-line: none;\">港口货物吞吐量</a>和<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E9%9B%86%E8%A3%85%E7%AE%B1/919222\" data-lemmaid=\"919222\" style=\"color: rgb(19, 110, 194); text-decoration-line: none;\">集装箱</a>吞吐量均已居世界第一位；世界集装箱吞吐量前5大港口中，中国占了3 个。随着中国经济影响力的不断扩大，世界航运中心正在逐步从西方转移到东方，中国海运业已经进入<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E4%B8%96%E7%95%8C%E6%B5%B7%E8%BF%90/6456579\" data-lemmaid=\"6456579\" style=\"color: rgb(19, 110, 194); text-decoration-line: none;\">世界海运</a>竞争舞台的前列。</p><p>世界经济发展环境发生了很大的变化，世界经济中心已经开始向亚太地区转移，世界经济的发展也将会在西太平洋海岸掀起一股新的热潮，而且进一步加强区域经济和跨国集团的开发都在为中国的港口建设和海运业的发展提供有利条件。面临大好的机遇，中国港航业自身能力不足问题十分突出，缺少大型<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E6%B2%B9%E8%88%B9/3109611\" data-lemmaid=\"3109611\" style=\"color: rgb(19, 110, 194); text-decoration-line: none;\">油船</a>和大型油船码头泊位，使中国石油进口运输中国轮船运率只占10%，不得不大量租用外轮运输。不仅需要支付大量外汇，也失去了中国海运业发展和增加就业的良好机遇。</p><p>海运业是资金密集型行业，发展中国家因缺少资金，大多数进出口货物运输都不得不受控于发达国家的船队，中国也未能免遭这一厄运。伴随着中国工业化进程的发展和加快，这一问题会越来越突出。如果解决不好，会形成不良循环。</p><p><br/></p>', '/uploads/imgs/202011/5fc4b450f1a1a.jpeg', 0, 'admin', 3, '', 0, 1606726816, 0, '', 0, '', 0, 1, 0, NULL);
INSERT INTO `news_article` VALUES (2, 0, '陆路运输服务', '￥ 4200/次', '陆路运输服务、是指通过陆路(地上或者地下) 运送货物或者旅客的运输业务活动，包括铁路运输和其他陆路运输(公路运输缆车运输、索道运输、地铁运输、城市轻轨运输等)。\n', '<p>陆路运输服务、是指通过陆路(地上或者地下) 运送货物或者旅客的运输业务活动，包括铁路运输和其他陆路运输(公路运输缆车运输、索道运输、地铁运输、城市轻轨运输等)。<span class=\"sup--normal\" data-sup=\"1\" data-ctrmap=\":1,\" style=\"font-size: 12px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em; margin-left: 2px; color: rgb(51, 102, 204); cursor: pointer; padding: 0px 2px;\">&nbsp;[1]</span><a style=\"color: rgb(19, 110, 194); position: relative; top: -50px; font-size: 0px; line-height: 0;\" name=\"ref_[1]_22915097\"></a>&nbsp;</p><p>出租车公司向使用本公司自有出租车的出租车司机收取的管理费用，按陆路运输服务征收增值税。</p><p>陆路运输服务、是指通过陆路(地上或者地下) 运送货物或者旅客的运输业务活动，包括铁路运输和其他陆路运输(公路运输缆车运输、索道运输、地铁运输、城市轻轨运输等)。<span class=\"sup--normal\" data-sup=\"1\" data-ctrmap=\":1,\" style=\"font-size: 12px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em; margin-left: 2px; color: rgb(51, 102, 204); cursor: pointer; padding: 0px 2px;\">&nbsp;[1]</span><a style=\"color: rgb(19, 110, 194); position: relative; top: -50px; font-size: 0px; line-height: 0;\" name=\"ref_[1]_22915097\"></a>&nbsp;</p><p>出租车公司向使用本公司自有出租车的出租车司机收取的管理费用，按陆路运输服务征收增值税。</p><p>陆路运输服务、是指通过陆路(地上或者地下) 运送货物或者旅客的运输业务活动，包括铁路运输和其他陆路运输(公路运输缆车运输、索道运输、地铁运输、城市轻轨运输等)。<span class=\"sup--normal\" data-sup=\"1\" data-ctrmap=\":1,\" style=\"font-size: 12px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em; margin-left: 2px; color: rgb(51, 102, 204); cursor: pointer; padding: 0px 2px;\">&nbsp;[1]</span><a style=\"color: rgb(19, 110, 194); position: relative; top: -50px; font-size: 0px; line-height: 0;\" name=\"ref_[1]_22915097\"></a>&nbsp;</p><p>出租车公司向使用本公司自有出租车的出租车司机收取的管理费用，按陆路运输服务征收增值税。</p><p><br/></p>', '/uploads/imgs/202011/5fc4a93bc127a.jpeg', 0, 'admin', 3, '', 0, 1606726970, 0, '', 0, '', 0, 1, 0, NULL);
INSERT INTO `news_article` VALUES (3, 0, '搬家服务', '￥ 200/次', '搬家指从一个地方搬到一个新的地方。纵观现代人的一生总会有几次的变迁与异动。', '<p><span style=\"color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px; background-color: rgb(255, 255, 255);\">时懂一些搬家常识可以避免在搬家时出现的一些意外情况，这样既给自己在搬家时减少了麻烦，也为搬家公司在搬家时提高速</span></p><p>繁搬家。对于这种家庭，最好避免购买一些大件家俱，而是尽量利用房东提供的设备。搬家用过的<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E7%BA%B8%E7%AE%B1\" style=\"color: rgb(19, 110, 194); text-decoration-line: none;\">纸箱</a>子最好不要扔掉，以备下次再用。最好不要预定一些长期服务，如订报、定奶等服务，这样可以避免很多麻烦。</p><p><span style=\"font-weight: 700;\">如何节省搬家时间</span></p><p><span style=\"color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px; background-color: rgb(255, 255, 255);\">要节省搬家时间，首先准备工作要充分，把所有零散东西都收进箱子或打包，化零为整。其次，可以要求搬家公司多派些人手。最后，要合理安排时间和行程，错过堵车高峰和堵车路线。</span></p><p><span style=\"color: rgb(51, 51, 51); font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px; background-color: rgb(255, 255, 255);\">鼓搬家的繁琐，最好的办法是卖掉所有旧家俱和不必要的日常用品，在新家重新置办一套家俱。虽然这种做法有些奢侈，但会给</span></p>', '/uploads/imgs/202011/5fc4b44d3ebda.jpeg', 0, 'admin', 5, '', 0, 1606727200, 0, '', 0, '', 0, 0, 0, NULL);
INSERT INTO `news_article` VALUES (4, 0, '航空运输', '￥ 6200/次', '航空运输（air transportation），是使用飞机直升机及其他航空器运送人员、货物、邮件的一种运输方式。具有快速、机动的特点', '<p>航空运输又称<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E9%A3%9E%E6%9C%BA%E8%BF%90%E8%BE%93\" style=\"color: rgb(19, 110, 194); text-decoration-line: none;\">飞机运输</a>，简称“<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E7%A9%BA%E8%BF%90/2456816\" data-lemmaid=\"2456816\" style=\"color: rgb(19, 110, 194); text-decoration-line: none;\">空运</a>”，它是在具有航空线路和飞机场的条件下，利用飞机作为运输工具进行货物运输的一种运输方式。航空运输在我国运输业中，其货运量占全国运输量比重还比较小，主要是承担长途客运任务，伴随着物流的快速发展，航空运输在货运方面也将会扮演重要角色。</p><p>航空运输的货物重量按<a target=\"_blank\" href=\"https://baike.baidu.com/item/%E6%AF%9B%E9%87%8D/1571722\" data-lemmaid=\"1571722\" style=\"color: rgb(19, 110, 194); text-decoration-line: none;\">毛重</a>计算。计算单位为公斤。重量不足1公斤，按1公斤算，超过1公斤的尾数四舍五入。非宽体飞机装载的每件货物重量一般不超过80 公斤，体积一般不超过40 * 60 * 100厘米。 宽体飞机装载每件货物重量一般不超过250公斤。体积一般不超过250 * 200 * 160厘米． 超过以上重量和体积的货物，由西北公司依据具体条件确定可否收运。每公斤的体积超过6000立方厘米的货物按轻泡货物计重。轻泡货物以每6000立方厘米折合1公斤计量。</p><p><br/></p>', '/uploads/imgs/202011/5fc4a9441e92f.jpeg', 0, 'admin', 6, '', 0, 1606727374, 0, '', 0, '', 0, 0, 0, NULL);
INSERT INTO `news_article` VALUES (5, 0, '“十三五”时期是我国全面建成小康社会，全面推进健康中国建设 ', '全面推进健康中国建设 ', '　马晓伟\n\n　　“十三五”时期是我国全面建成小康社会、实现第一个百年奋斗目标的决胜阶段。以习近平同志为核心的党中央把维护人民健康摆在更加突出的位置，作出实施健康中国战略的决策部署，召开全国卫生与健康大会，确立新时代卫生健康工作方针，印发《“健康中国2030”规划纲要》，明确了建设', '<p>　马晓伟</p><p>　　“十三五”时期是我国全面建成小康社会、实现第一个百年奋斗目标的决胜阶段。以习近平同志为核心的党中央把维护人民健康摆在更加突出的位置，作出实施健康中国战略的决策部署，召开全国卫生与健康大会，确立新时代卫生健康工作方针，印发《“健康中国2030”规划纲要》，明确了建设健康中国的大政方针和行动纲领，中国特色基本医疗卫生制度框架基本建立，健康中国建设持续推进，人民健康水平不断提高。</p><p>　　推进健康中国建设的根本遵循和行动指南</p><p>　　党的十八大以来，习近平总书记创造性地把马克思主义基本原理同卫生健康工作实际相结合，提出一系列新理念新思想新要求，作出一系列新部署，为全面建设健康中国指明了方向和路径。</p><p>　　把人民健康放在优先发展战略地位。在实现“两个一百年”奋斗目标的历史进程中，发展卫生健康事业始终处于基础性地位，与国家整体战略紧密衔接，发挥着重要支撑作用。以习近平同志为核心的党中央坚持人民至上、生命至上，始终把人民生命安全和身体健康放在第一位，强调要把人民健康放在优先发展战略地位，努力全方位全周期保障人民健康。这是我们党的根本宗旨在卫生健康领域的体现，也是主动适应我国社会主要矛盾变化、不断满足人民日益增长的美好生活需要的战略选择。这就要求我们把增进人民健康福祉作为发展的重要目的、把保障人民健康作为全面建成小康社会的重要内涵和全面建设社会主义现代化国家的重要任务，不断提高卫生健康供给和服务水平，加快形成有利于健康的生活方式、生态环境和经济社会发展方式，实现健康与经济社会协调发展。</p><p>　　确立新时代卫生与健康工作方针。习近平总书记在深入分析我国卫生健康事业发展大势的基础上，提出了新时代卫生与健康工作方针：以基层为重点，以改革创新为动力，预防为主，中西医并重，将健康融入所有政策，人民共建共享。这38字工作方针既与党在不同历史时期的卫生工作方针一脉相承，又体现了新发展理念的科学内涵，具有鲜明的时代特征，是对新形势下卫生与健康工作的总要求，是推进健康中国建设和制定相关政策的基本遵循。</p><p>　　坚持基本医疗卫生事业的公益性。习近平总书记指出，要坚持基本医疗卫生事业的公益性。我们党是全心全意为人民服务的党，我国是人民当家作主的国家，这就决定了我们必须毫不动摇把公益性写在医疗卫生事业的旗帜上，把实现好维护好发展好人民群众健康利益作为医疗卫生事业发展的出发点和落脚点，把为群众提供安全、有效、方便、价廉的公共卫生和基本医疗服务作为基本职责。从社会主义初级阶段基本国情出发，尊重医学科学发展规律，坚持政府主导、公益性主导、公立医院主导的基本原则，落实政府领导责任、保障责任、管理责任、监督责任，不断完善制度、扩展服务、提高质量，让卫生健康发展成果更多更公平惠及广大人民群众。</p><p>　　树立大卫生、大健康的观念。习近平总书记指出，树立大卫生、大健康的观念，把以治病为中心转变为以人民健康为中心。这既是对世界健康发展趋势的科学把握，也是对健康发展内在规律的深刻揭示。这就要求我们从影响健康因素的广泛性出发，关注生命全周期、健康全过程，将健康作为制定实施各项公共政策的重要考量，统筹调配全社会卫生健康资源，将维护人民健康的范畴从传统的疾病防治拓展到影响健康的各个领域，让广大人民群众享有公平可及、系统连续的健康服务。</p><p>　　“十三五”时期健康中国建设实现良好开局</p><p>　　“十三五”时期，全国卫生健康系统以习近平新时代中国特色社会主义思想为指引，坚决贯彻党中央、国务院决策部署，全力推进健康中国建设，卫生健康事业取得新发展，深化医药卫生体制改革取得新成效，医疗卫生体系经受住了新冠肺炎疫情重大考验。2015—2019年，我国居民人均预期寿命从76.34岁提高到77.3岁，主要健康指标总体上优于中高收入国家平均水平，个人卫生支出占卫生总费用的比重降至28.4%，为全面建成小康社会打下了坚实的健康基础。</p><p>　　健康中国行动启动实施。2020年6月1日，《中华人民共和国基本医疗卫生与健康促进法》实施，“国家实施健康中国战略”写入法律，为健康中国建设提供了法治保障。着眼于全方位干预健康影响因素、维护全生命周期健康、防控重大疾病，实施健康中国行动，政府、社会、个人协同推进15个专项行动，深入开展爱国卫生运动，综合防控儿童青少年近视和肥胖，推广戒烟限酒、适量运动、合理膳食、心理平衡的健康生活习惯，居民健康素养水平明显提升，关注健康、追求健康的社会氛围初步形成。</p><p>　　医药卫生体制改革取得重要进展。优化医疗资源配置，启动国家医学中心和区域医疗中心建设，推进医联体建设和县域综合医改，84%的县级医院达到二级及以上医院水平。推进现代医院管理制度建设，公立医院全面取消药品和耗材加成，以质量为核心、以公益性为导向开展绩效考核。深化医教协同，建立临床医师规范化培训制度和医师区域注册制度，千人口执业医师数达2.77人，万人口全科医生数达2.61人。建立综合督查制度，实现全国督查全覆盖。强化医疗、医保、医药联动改革，协同推进药品集中采购和使用，打通降价药进医院“最后一公里”，将政策红利引导到临床端。扎实做好短缺药品保供稳价工作，基本药物数量由520种增加到685种。</p><p>　　健康扶贫成效显著。围绕“基本医疗有保障”目标，确定县医院能力建设、“县乡一体、乡村一体”机制建设、乡村医疗卫生机构标准化建设3个主攻方向，组织三级医院“组团式”帮扶贫困县县医院，远程医疗服务覆盖国家级贫困县和边远地区。实施分类救治策略，大病专项救治病种扩大至30种，对高血压等4种慢性病患者优先落实家庭医生签约服务，实施贫困地区健康促进三年行动，以“三区三州”为重点加强重大传染病和地方病综合防治，累计分类救治贫困患者1900多万人，近1000万因病致贫返贫户成功脱贫。</p><p>　　公共卫生整体实力进一步提高。重大传染病防控策略持续优化，5岁以下儿童乙型肝炎病毒（HBV）感染率降至1%以下。实施职业病、地方病三年攻坚行动，重点职业病监测范围由原来的10种扩大到28种。实施扩大国家免疫规划，扩大癌症早诊早治覆盖人群，2019年重大慢性病过早死亡率比2015年降低10.8%。免费向全体城乡居民提供12类国家基本公共卫生服务项目和其他19项基本公共卫生服务项目，基本公共卫生服务均等化水平进一步提升。面对突如其来的新冠肺炎疫情，广大卫生健康工作者坚决听从习近平总书记和党中央指挥，冲锋在前、救死扶伤，为取得抗疫斗争重大战略成果作出了应有贡献。</p><p>　　积极推进“一老一小”健康服务。贯彻落实党中央关于调整完善生育政策的决策部署，优化生育服务，出生人口性别比持续改善。加强“一老一小”健康服务保障，全面加强出生缺陷综合防治，促进3岁以下婴幼儿照护服务发展，制定托育机构设置标准和管理规范；加强老年健康教育和预防保健，将老年健康与医养结合服务列入国家基本公共卫生服务，大力促进医养结合，为居家老人提供医疗服务的机构达到4万多家。</p><p>　　中医药振兴发展迈出新步伐。颁布实施《中华人民共和国中医药法》，发布《中共中央国务院关于促进中医药传承创新发展的意见》，召开全国中医药大会，中医药传承创新发展迎来大好发展机遇。中医药服务体系建设、人才培养、科技创新和质量提升等全面推进，实施文献传承和活态传承并举的中医药学术传承制度，推广中医适宜技术，中西医药优势互补、相互促进，共同维护人民健康。</p><p>　　在新发展阶段全面推进健康中国建设</p><p>　　党的十九届五中全会从党和国家事业发展全局的高度，提出了到2035年“建成健康中国”的远景目标，对“十四五”时期全面推进健康中国建设、实施积极应对人口老龄化国家战略作出明确部署。全国卫生健康系统要坚持以习近平新时代中国特色社会主义思想为指引，深入学习贯彻党的十九届五中全会精神，增强“四个意识”、坚定“四个自信”、做到“两个维护”，坚持党对卫生健康工作的领导，坚持新发展理念，坚持稳中求进工作总基调，更加注重预防为主和风险防范，更加注重提高质量和促进均衡，更加注重资源下沉和系统协作，确保党中央决策部署落地见效。</p><p>　　把保障人民健康放在优先发展的战略位置，深入实施健康中国行动。坚持预防为主方针，针对居民主要健康问题和影响因素，聚焦重点人群，完善国民健康促进政策，优化重大疾病防控策略措施，广泛开展全民共建共享的健康行动，倡导文明健康绿色环保的生活方式，重视精神卫生和心理健康，为人民提供全方位全周期健康服务。</p><p>　　以改革创新为动力，持续深化医药卫生体制改革。加快优质医疗资源扩容和区域均衡布局，推进国家医学中心和区域医疗中心建设，强化医联体网格化布局，持续提升县域服务能力。加强公立医院建设和管理考核，完善公立医院补偿和运行机制，推动公立医院高质量发展。落实中医药特色发展的政策措施，推动中医药传承创新发展。支持社会办医，推广远程医疗，加快发展健康产业。</p><p>　　以安全为底线，织牢公共卫生防护网。完善疾病预防控制体系，在理顺体制机制、明确功能定位、提升专业能力等方面加大改革力度。落实医疗机构公共卫生责任，创新医防协同机制。健全医疗救治、科技支撑、物资保障体系，提高应对突发公共卫生事件能力。</p><p>　　以老年友好型社会为目标，积极应对人口老龄化。加快构建老年健康服务体系，深入推进医养结合，增加居家、社区、机构等医养结合服务供给。加强人口监测和研判，增强生育政策包容性，促进人口长期均衡发展。支持社会力量开展普惠托育服务，促进婴幼儿照护服务发展，减轻群众生育养育负担。</p><p>　　以补短板强弱项为重点，强化卫生健康事业发展改革的支撑与保障。加强健康优先发展制度保障，推动建立稳定的公共卫生事业投入机制，推动将主要健康指标、重大疫情防控和突发公共卫生事件应对纳入各级党委和政府考核指标体系。加强公共卫生等重点领域法律法规建设，健全行业综合监管制度。深化“一带一路”卫生健康合作，推动构建人类卫生健康共同体。（作者为国家卫生健康委员会主任、党组书记）</p><p><br/></p>', '/uploads/imgs/202011/5fc4b45fb987e.jpeg', 0, 'admin', 4, '', 0, 1606729428, 0, '', 0, '', 0, 1, 0, NULL);
INSERT INTO `news_article` VALUES (6, 0, '全面建设社会主义现代化国家高质量供给来自哪里 ', '高质量供给来自哪里 ', '党的十九届五中全会是我们党在全面建成小康社会胜利在望、全面建设社会主义现代化国家新征程即将开启的重要历史时刻召开的一次十分重要的会议，全会通过的《中共中央关于制定国民经济和社会发展第十四个五年规划和二〇三五年远景目标的建议》（以下简称《建议》），是开启全面建设社会主义现', '<p>编者按</p><p>　　党的十九届五中全会是我们党在全面建成小康社会胜利在望、全面建设社会主义现代化国家新征程即将开启的重要历史时刻召开的一次十分重要的会议，全会通过的《中共中央关于制定国民经济和社会发展第十四个五年规划和二〇三五年远景目标的建议》（以下简称《建议》），是开启全面建设社会主义现代化国家新征程、向第二个百年奋斗目标进军的纲领性文件，是今后五年乃至更长时间中国经济社会发展的行动指南。为深入学习贯彻党的十九届五中全会精神，本报与广东省社会科学界联合会特邀我省优秀社会科学家，围绕推动高质量发展、加快构建新发展格局、全面推进乡村振兴、推进社会主义文化强国建设等重大问题撰写刊发一组理论文章，敬请垂注。</p><p>　　我国即将跨入全面建设社会主义现代化国家的新阶段。这个新阶段的基本特征是高质量发展。高质量发展就是以高质量供给不断地满足人民群众的高品质需要。正因为如此，《建议》明确地把高质量发展和深化供给侧结构性改革作为我国“十四五”发展规划的主题主线。那么，高质量供给从哪里来？</p><p>　　一是技术创新。我们现在使用的诸如智能手机、数码相机、智能玩具和电动飞行器等许多产品在几十年前都不曾见过。与人们生活密切相关的产品种类从上世纪80年代初期不足百种到现在多达上万种。即使是同一类产品，款式、品种、功能与档次等也是多种多样、琳琅满目，同时，每一种产品的功能不断更新，诸如食品越来越突出绿色、健康、卫生以及地方特色，手机从单纯打电话发展到集社交、支付、计算、门禁、网上阅读、听音乐、看电影以及网络阅读等众多功能于一体，许多家具企业从标准化的制造商转向了以定制化为主的服务商。显然，我们生活中发生的这些变化都是创新推动的结果。未来，新一轮科技革命与产业变革的快速进步将使生产与生活方式发生更深刻、更迅速的变化。习近平总书记在浦东开发开放30周年庆祝大会上指出：“科学技术从来没有像今天这样深刻影响着国家前途命运，从来没有像今天这样深刻影响着人民幸福安康。”在这个科技快速进步的时代，哪个企业能不断聚焦新产品、新技术与新模式，把创新作为第一动力，不断加大创新投入，它在激烈的市场竞争中就能抢占更多的市场份额。哪一个城市和地区能围绕着创新配置资源与布局产业，它们就会脱颖而出。</p><p>　　二是工匠精神。工匠精神就是一种一丝不苟、精益求精的工作态度，孜孜不倦、精雕细琢的职业精神。一个企业要重视长期发展，懂得渐进变革，关注质量改进，就离不开工匠精神。因为提供高质量产品与服务的关键在于对细节的专注，在品质革命中，细节决定竞争力。当然，重视质量与品质并不是与生俱来的，而是在质量决定生存的环境中逼出来的。比如说，19世纪末期，“德国制造”被英国人当成是低质工业品的标签。二战后，“德国制造”逐步成为质量与稳定的代名词。到目前为止，德国人生产的工业制造品，大到挖地铁的掘进机，小到文具订书机，从质量上讲都称得上世界领先。之所以“德国制造”有这样的变化，就是因为德国企业自一战后就把产品质量看成是生存发展的命门，一方面由制造业的行业联盟制定很高的产品质量标准，引导企业按照高标准生产以质量提高竞争力；另一方面形成了通过企业与客户互动、促进企业开发符合客户特定需要产品的机制。这种机制使客户可以识别质量的差距，也使竞争对手难以轻易复制。在走向创新型社会中，工匠精神与创新是相互促进的，发扬工匠精神既有利于企业通过精益求精发现许多创新的机会，也有利于新创出来的产品功能不断完善。</p><p>　　三是循环效率。高质量发展不仅体现在某一种产品与服务上，还体现在生产、流通、分配、消费等环节构成的经济运行与联系上。经济学理论表明，企业将资金配置到采购、生产与销售等三个环节，从而发生了资本从货币形态转向实物与产品形态再转向货币形态的变化过程。如果每个环节占用的资金少、周转快，那么，资金的循环效率就较高。如果采购与销售中的交易成本与运输成本都较高，产品积压较多，资金周转缓慢，那么，资金的循环效率就较低。提高资金循环效率是企业提高资金配置效率的重要领域，如果资金周转缓慢，循环效率偏低，企业采购原材料与提供产品与服务的及时性、精准性与有效性都会受到影响，高质量供给也无从谈起。宏观经济是建立在微观经济活动基础上的，如果微观的资金循环效率不高，那么，宏观经济运行也会受到影响，这将迫使宏观经济环境进一步优化，交易成本与运输成本大幅度降低，从而为微观经济活动提供更好的软硬件服务。2013—2019年间，我国社会物流总费用占GDP的比重从17.3%降至14.1%，还高于世界平均水平3个百分点。这表明，我国在降低交易成本与运输成本等方面还有较大潜力。这需要在高质量发展新阶段，加大体制改革力度，打通制约产品、要素流动的各种障碍，消除地方壁垒，从而为企业提供更高质量、更低成本的公共设施网络与服务体系。</p><p>　　四是制度供给。高水平的制度供给是高质量供给中的重要组成部分，也是高质量产品与服务供给的重要支撑。推动高水平的制度供给可从三方面入手。第一，提供的制度要与国际先进的技术与质量标准相衔接、与国际通行的营商惯例相适应。高质量供给是在更开放条件下推进的，更开放的制度供给的特征是规则等制度型开放。这需要统一内外资法律法规，完善公开、透明的涉外法律体系，全面实行准入前国民待遇加负面清单管理制度，持续放宽市场准入，尊重国际营商惯例，保护外资企业合法权益。第二，市场体系建设要体现高标准要求。诸如推进营商环境向市场化、国际化与法治化等国际一流方向迈进，加快自由贸易试验区先行先试的经验做法向更大范围内复制与推广，打通部门之间、地区之间的信息孤岛，扩大市场环境中政策规则的区域一体化进程，推进更大区域内形成高效规范、公平竞争的统一市场。第三，内外贸一体化体系要加快形成。《建议》强调：“促进内外贸法律规则、监管体系、经营资质、质量标准、检测检疫、认证认可等相衔接，推进同线同标同质。”这是充分利用两个市场、两种资源，形成国内国际双循环的关键。哪些省市和地区在这些方面能率先推进，那么，它在国内国际双循环的新发展格局中就能先走一步。（广东省第二届优秀社会科学家、广东省社会科学院教授\n 王珺）</p><p><br/></p>', '/uploads/imgs/202011/5fc4b448ba0e8.jpeg', 0, 'admin', 4, '', 0, 1606729473, 0, '', 0, '', 0, 1, 0, NULL);
INSERT INTO `news_article` VALUES (7, 0, '党的十九届五中全会文化强国：文化软实力的中国目标 ', '文化强国：文化软实力的中国目标 ', '党的十九届五中全会通过的《建议》，给我们指出了2035年的文化发展目标——建成文化强国，这是提升国家文化软实力的重大举措，也是实现民族复兴伟大梦想的重要步骤。', '<p>党的十九届五中全会通过的《建议》，给我们指出了2035年的文化发展目标——建成文化强国，这是提升国家文化软实力的重大举措，也是实现民族复兴伟大梦想的重要步骤。</p><p>　　文化强国目标的实现是中华民族伟大复兴的重要台阶和砝码</p><p>　　2013年，习近平总书记在十八届中央政治局第十二次集体学习时就指出：“提高国家文化软实力，关系‘两个一百年’奋斗目标和中华民族伟大复兴中国梦的实现。”在党的十九大报告中总书记又指出：“文化兴国运兴，文化强民族强。没有高度的文化自信，没有文化的繁荣兴盛，就没有中华民族伟大复兴。”从中国全面实现现代化的进程看，中国在改革开放中实现了经济腾飞并全面建成小康社会之后，文化强国的建设就成为今后15年的主要目标。再从2050年的长期目标看，民族的伟大复兴除了成为经济强国、军事强国之外，还必须以文化复兴作为标志，而文化强国目标的实现就是迈向2050年全面实现现代化达到民族伟大复兴的重要台阶和砝码。作为已经是世界第二大经济体的中国，我们不仅要坚持推进经济、政治、社会、生态文明高质量发展，也要推进文化高质量发展，以满足人民不断增长的文化需求和精神需求。作为经济大国，不能让世界把我们看作只能输出物质产品而缺乏精神文化的跛足社会，未来中国的形象必定是一个在文化软实力上非常强大的国家。</p><p>　　中国古代的汉、唐社会，之所以被世界视为有“汉唐雄风”的大国，就在于那时的社会不仅有强大的经济与军事实力，而且也具有雄阔博大的文化气象，它不仅向国外输出丝绸、瓷器等器物，也向国外输出文化观念和文化制度，并深深地影响到周边亚洲国家文明的发展。北宋和明中晚期，中国的富足与繁华以及生活方式、文化艺术也向国外辐射，远及欧洲、非洲，中国的器物如扇子、茶叶、丝绸等成为亚洲、欧洲的畅销货，园林建筑被搬进欧洲皇家公园内，文学艺术作品也被引进到亚洲周边国家和欧洲的法国、德国等。</p><p>　　社会主义核心价值观是建设文化强国、增强国家文化软实力的关键和核心</p><p>　　当今世界正经历百年未有之大变局，中国在积极应对外部环境变化带来的冲击与挑战的时候，必须增强综合实力，提高国际竞争力，才能有效地维护国家安全，实现社会和谐平稳安定。而综合国力就包括文化软实力。围绕着如何推进文化强国建设，增强文化软实力，《建议》提出了明确的使命任务，那就是举旗帜、聚民心、育新人、兴文化、展形象。今后15年我们就是要围绕这些使命任务，将举措落实到文化兴国的若干工作中。</p><p>　　我们首先要坚定文化自信，举旗帜，固灵魂。要坚持马克思主义在意识形态领域的指导地位，以社会主义核心价值观为引领，加强社会主义精神文明建设，为培育社会主义新人固本强魂。社会主义核心价值观是文化自信的灵魂内核与价值旨归，它是建设文化强国、增强国家文化软实力的关键和核心。在促进社会主义文化繁荣发展、建设文化强国的过程中，坚持社会主义核心价值观就能充分展现中国的文化自信，就能夯实走向文化强国的价值观基础。文化自信是承载国家与民族价值共识的精神依托，核心价值观的培育与成就文化上的自信以及建成文化强国有着内在的紧密关联。没有核心价值观，就等于没有国之魂魄、民族之魂魄。正如习近平总书记指出的：“我们生为中国人，最根本的就是我们有中国人的独特精神世界，有百姓日用而不觉的价值观。”要让社会主义核心价值观成为广大人民日常生活的价值操守，并在知行合一的实践中成为价值引领的精神旗帜，内化为中国人民普遍遵循的集体文化心理和精神追求，成为完善民族人格的重要内核，外化为人们的自觉行动。</p><p>　　其次是要坚持以人民为中心，实施文化兴国的若干工程。推进城乡公共文化服务体系一体化建设，创新实施文化惠民工程，是以人民为中心的持续性普惠措施。加强国家重大文化设施和文化项目的建设，强化重要文化和自然遗产、非物质文化遗产系统性保护，建设若干具有标志性的国家文化公园如长城、黄河文化公园等，也是让人民获利、共享美好幸福生活的凝聚民心工程。在推进媒体深度融合，实施全媒体传播工程方面，也是更大程度上为了人民更好地共享信息，在健康、便利、快捷的网络世界里有获得感和愉悦感。在哲学社会科学和文学艺术领域实施质量提升工程，创造出更多的哲学社会科学和文艺精品，也是聚民心的重要举措。《建议》还专门提到要加强文艺中现实题材创作生产，不断推出反映时代新气象、讴歌人民新创造的文艺精品，这既是方向性的政策引导，也是有针对性的现实调整。因为文艺要发挥凝心聚气、强魄铸魂的作用，离不开对人民正在从事的火热现实生活的充分书写与表达，如对长征精神、“两弹一星”精神、伟大抗疫精神等的书写更能体现时代精神的召唤力。另外，健全现代文化产业体系，加强文化市场体系建设，扩大优质文化产品供给，也是为了让文化产品更好地进入百姓生活，成为日常生活审美化的参与者和共享者。</p><p>　　再次，文化软实力还表现在中国文化的国际传播上。如何以讲好中国故事为着力点，以创新的手段进行文化的对外传播，在对外文化交流中获得更多更大的主动权和话语权，让中国在世界塑造自身的良好形象，也让世界在接纳和对话中国的进程中更好地了解中国、认识中国，从而进行深度的多层次的文明互鉴。这也是文化强国建设中的重头戏，需要我们付出更大的努力，才可达到预期的效果和目的。（广东省第二届优秀社会科学家、暨南大学文学院教授\n 蒋述卓）</p><p><br/></p>', '/uploads/imgs/202011/5fc4a9441e92f.jpeg', 0, 'admin', 4, '', 0, 1606729524, 0, '', 0, '', 0, 1, 0, NULL);
INSERT INTO `news_article` VALUES (8, 0, '着力构建高水平社会主义市场经济体制 ', '着力构建高水平社会主义市场经济体制 ', '党的十九届五中全会审议通过的《中共中央关于制定国民经济和社会发展第十四个五年规划和二〇三五年远景目标的建议》（以下简称《建议》），提出“全面深化改革', '<p>　党的十九届五中全会审议通过的《中共中央关于制定国民经济和社会发展第十四个五年规划和二〇三五年远景目标的建议》（以下简称《建议》），提出“全面深化改革，构建高水平社会主义市场经济体制”的重点任务并作出一系列重要部署。这对于推动高质量发展、全面建成小康社会、开启全面建设社会主义现代化国家新征程，具有重要意义。</p><p><br/></p><p>　　构建高水平社会主义市场经济体制，应着重在以下几个方面下大功夫、花大力气。</p><p><br/></p><p>　　<strong>建设高标准市场体系，推进要素市场化配置改革</strong></p><p><br/></p><p>　　市场体系是市场机制发挥作用的必要条件，充分发挥市场机制在资源配置中的作用，构建体系完整、机制健全、统一开放、竞争有序的高标准市场体系，是构建高水平社会主义市场经济体制的重要内容。</p><p><br/></p><p>　　党的十九届五中全会提出了“十四五”时期经济社会发展主要目标，其中包括“社会主义市场经济体制更加完善，高标准市场体系基本建成”等。按照《建议》的部署，建设高标准市场体系的重点之一是健全市场体系基础制度，完善要素市场化配置。必须从健全市场体系基础制度抓起，提高制度供给水平和能力,保障市场体系有效运行,形成高效规范、公平竞争的国内统一市场。重在健全产权执法司法保护制度，实施统一的市场准入负面清单制度,健全公平竞争制度，清除市场壁垒，维护清单的统一性和权威性，提高资源配置效率和公平性，保障资源优化配置，进一步营造公平竞争的市场环境。必须着力推进要素市场化改革,健全要素市场运行机制。推进资本要素市场化配置，健全股票、债券等资本市场制度，加强资本市场结构、功能、制度规范、法律建设；健全数据、知识、技术等要素市场化配置机制，进一步激发数据、知识、技术等要素市场活力，完善相关法律法规，明确不同主体的权利义务，规范交易行为和市场秩序；加快完善城乡统一的土地市场，推动土地要素市场化配置，加快构建“保护产权、同权同价、维护契约、平等交易”的城乡统一建设用地市场体系；建立城乡统一的劳动力市场，推动劳动力要素有序流动，深化劳动力要素市场体制机制改革，健全统一规范的人力资源市场体系，完善要素交易规则和服务体系；建设多元平衡、安全高效的全面开放体系，发展更高层次的开放型经济。</p><p><br/></p><p>　　当前，我国已进入高质量发展阶段。针对市场秩序不规范、生产要素市场发展滞后、市场规则不统一、市场竞争不充分等问题，必须破除制约高质量发展的体制机制性障碍，加快建设统一开放、竞争有序的市场体系，提高资源配置效率，为构建高水平社会主义市场经济体制奠定坚实基础。</p><p><br/></p><p>　　<strong>坚持和完善社会主义基本经济制度，激发各类市场主体活力</strong></p><p><br/></p><p>　　基本经济制度在制度体系中具有长期性和稳定性，决定着经济发展的质量和效益。构建高水平社会主义市场经济体制，必须坚持和完善社会主义基本经济制度，在基本经济制度框架内形成以公有制为主体、多种所有制经济共同发展的所有制结构，形成公有制经济、非公有制经济相辅相成、相得益彰的好局面，激发各类市场主体活力。</p><p><br/></p><p>　　必须毫不动摇地巩固和发展公有制经济，激发国有企业活力。重在加快国有经济布局优化和结构调整，加快完善中国特色现代企业制度，健全管资本为主的国有资产监管体制，发展混合所有制经济，分层分类深化国有企业混合所有制改革，因地、因业、因企施策，支持民营企业、社会资本参与国有企业混合所有制改革，鼓励国有资本投资入股民营企业；深化国资国企改革，做强做优做大国有资本和国有企业，以提升自主创新能力增强新发展动能，以深化国资国企改革激发新发展活力，增强国有经济竞争力、创新力、控制力、影响力和抗风险能力。</p><p><br/></p><p>　　必须毫不动摇地鼓励、支持、引导非公有制经济发展，激发民营企业活力。重在优化民营经济发展环境，依法平等保护民营企业产权和企业家权益，完善促进中小微企业发展的法律环境和政策体系，支持企业积极参与市场合作竞争，进一步激发企业活力和创造力。</p><p><br/></p><p>　　<strong>坚持社会主义市场经济改革方向，推动有效市场和有为政府更好结合</strong></p><p><br/></p><p>　　构建高水平社会主义市场经济体制，重点在于统筹协调好市场与政府的关系。《建议》提出，“坚持和完善社会主义基本经济制度，充分发挥市场在资源配置中的决定性作用，更好发挥政府作用，推动有效市场和有为政府更好结合”。</p><p><br/></p><p>　　市场决定资源配置是市场经济的一般规律，中国特色社会主义市场经济是在尊重并发挥市场配置资源决定作用基础上的社会主义市场经济。必须加快转变政府职能，围绕构建高水平社会主义市场经济体制加快建设职责明确、依法行政的政府治理体系，更加尊重市场经济的一般规律，最大限度地减少政府对市场资源的直接配置和对微观经济活动的直接干预，创新完善宏观调控，推动实现更高质量、更有效率、更加公平、更可持续、更为安全的发展。要完善宏观经济治理，建立现代财税金融体制，通过科学的宏观调控和经济治理，最大程度地减少单纯市场调节的自发性、盲目性和滞后性。重在深化简政放权、优化服务，建立和完善权力清单、负面清单和责任清单制度，推进政务服务标准化、规范化、便利化，持续优化市场化法治化国际化营商环境。</p><p><br/></p><p>　　进入新发展阶段,贯彻新发展理念，构建新发展格局,更加需要正确处理市场与政府关系。必须进一步明确市场和政府在经济社会发展中的作用定位，厘清市场和政府边界，在社会主义基本制度与市场经济的结合上下功夫，增强二者的适应性、匹配度、融合度，充分发挥两个方面的作用和优势，更好发挥我国制度优势，实现市场机制有效、微观主体有活力、宏观调控有度，推动经济高质量发展。</p><p><br/></p><p>　　<strong>推进经济体制改革与收入分配制度改革同向发力，提高人民收入水平</strong></p><p><br/></p><p>　　《建议》提出了“十四五”时期经济社会发展必须遵循的原则，其中包括“坚持以人民为中心”“坚持人民主体地位，坚持共同富裕方向，始终做到发展为了人民、发展依靠人民、发展成果由人民共享”等；明确了“十四五”时期经济社会发展主要目标，其中包括“民生福祉达到新水平”“居民收入增长和经济增长基本同步，分配结构明显改善，基本公共服务均等化水平明显提高”等；提出了到2035年基本实现社会主义现代化远景目标，其中包括“人的全面发展、全体人民共同富裕取得更为明显的实质性进展”等。实现收入分配合理、社会公平正义、全体人民共同富裕，是社会主义市场经济体制对分配环节的内在要求。</p><p><br/></p><p>　　收入分配制度是一项带有根本性、基础性的制度安排。构建高水平社会主义市场经济体制，必须在深化社会主义市场经济体制改革的同时进一步完善社会主义分配制度，推动社会主义市场经济体制改革与社会主义分配制度改革同向发力。构建高水平社会主义市场经济体制，要坚持公有制为主体、多种所有制经济共同发展，坚持按劳分配为主体、多种分配方式并存，推动居民收入增长和经济增长同步、劳动报酬提高和劳动生产率提高同步。要健全和完善收入分配体制机制，通过调整国民收入分配格局，逐步缩小收入分配差距，为全体人民共享发展成果提供制度性保证。要健全体现效率、促进公平的收入分配体系，形成公平合理的收入分配关系，努力实现收入分配公平、全体人民共同富裕。要建立健全社会公平保障体系，推进基本公共服务均等化，着力构建公平公正、共建共享的发展新机制，通过制度安排解决民生问题，在更高经济发展水平上促进社会公平正义、实现发展成果由人民共享。（作者系北京市习近平新时代中国特色社会主义思想研究中心特约研究员，中共中央宣传部宣传舆情研究中心副主任、研究员）</p><p><br/></p>', '/uploads/imgs/202011/5fc4b456b27b8.jpeg', 0, 'admin', 4, '', 0, 1606729566, 0, '', 0, '', 0, 1, 0, NULL);
INSERT INTO `news_article` VALUES (9, 0, '空中运输服务', '￥ 6200/次', '空运[air transport;airfreight;airlift;air transportation] 也叫空中运输', '<p>陆路运输服务、是指通过陆路(地上或者地下) 运送货物或者旅客的运输业务活动，包括铁路运输和其他陆路运输(公路运输缆车运输、索道运输、地铁运输、城市轻轨运输等)。<span class=\"sup--normal\" data-sup=\"1\" data-ctrmap=\":1,\" style=\"font-size: 12px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em; margin-left: 2px; color: rgb(51, 102, 204); cursor: pointer; padding: 0px 2px;\">&nbsp;[1]</span><a style=\"color: rgb(19, 110, 194); position: relative; top: -50px; font-size: 0px; line-height: 0;\" name=\"ref_[1]_22915097\"></a>&nbsp;</p><p>出租车公司向使用本公司自有出租车的出租车司机收取的管理费用，按陆路运输服务征收增值税。</p><p>陆路运输服务、是指通过陆路(地上或者地下) 运送货物或者旅客的运输业务活动，包括铁路运输和其他陆路运输(公路运输缆车运输、索道运输、地铁运输、城市轻轨运输等)。<span class=\"sup--normal\" data-sup=\"1\" data-ctrmap=\":1,\" style=\"font-size: 12px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em; margin-left: 2px; color: rgb(51, 102, 204); cursor: pointer; padding: 0px 2px;\">&nbsp;[1]</span><a style=\"color: rgb(19, 110, 194); position: relative; top: -50px; font-size: 0px; line-height: 0;\" name=\"ref_[1]_22915097\"></a>&nbsp;</p><p>出租车公司向使用本公司自有出租车的出租车司机收取的管理费用，按陆路运输服务征收增值税。</p><p>陆路运输服务、是指通过陆路(地上或者地下) 运送货物或者旅客的运输业务活动，包括铁路运输和其他陆路运输(公路运输缆车运输、索道运输、地铁运输、城市轻轨运输等)。<span class=\"sup--normal\" data-sup=\"1\" data-ctrmap=\":1,\" style=\"font-size: 12px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em; margin-left: 2px; color: rgb(51, 102, 204); cursor: pointer; padding: 0px 2px;\">&nbsp;[1]</span><a style=\"color: rgb(19, 110, 194); position: relative; top: -50px; font-size: 0px; line-height: 0;\" name=\"ref_[1]_22915097\"></a>&nbsp;</p><p>出租车公司向使用本公司自有出租车的出租车司机收取的管理费用，按陆路运输服务征收增值税。</p><p><br/></p>', '/uploads/imgs/202011/5fc4a9441e92f.jpeg', 0, 'admin', 3, '', 0, 1606726970, 0, '', 0, '', 0, 1, 0, NULL);
INSERT INTO `news_article` VALUES (10, 0, '铁路运输服务', '￥ 2200/次', '铁路运输是使用铁路列车运送旅客和货物的一种运输方式。它在社会物质生产过程中起着重要作用。', '<p>陆路运输服务、是指通过陆路(地上或者地下) 运送货物或者旅客的运输业务活动，包括铁路运输和其他陆路运输(公路运输缆车运输、索道运输、地铁运输、城市轻轨运输等)。<span class=\"sup--normal\" data-sup=\"1\" data-ctrmap=\":1,\" style=\"font-size: 12px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em; margin-left: 2px; color: rgb(51, 102, 204); cursor: pointer; padding: 0px 2px;\">&nbsp;[1]</span><a style=\"color: rgb(19, 110, 194); position: relative; top: -50px; font-size: 0px; line-height: 0;\" name=\"ref_[1]_22915097\"></a>&nbsp;</p><p>出租车公司向使用本公司自有出租车的出租车司机收取的管理费用，按陆路运输服务征收增值税。</p><p>陆路运输服务、是指通过陆路(地上或者地下) 运送货物或者旅客的运输业务活动，包括铁路运输和其他陆路运输(公路运输缆车运输、索道运输、地铁运输、城市轻轨运输等)。<span class=\"sup--normal\" data-sup=\"1\" data-ctrmap=\":1,\" style=\"font-size: 12px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em; margin-left: 2px; color: rgb(51, 102, 204); cursor: pointer; padding: 0px 2px;\">&nbsp;[1]</span><a style=\"color: rgb(19, 110, 194); position: relative; top: -50px; font-size: 0px; line-height: 0;\" name=\"ref_[1]_22915097\"></a>&nbsp;</p><p>出租车公司向使用本公司自有出租车的出租车司机收取的管理费用，按陆路运输服务征收增值税。</p><p>陆路运输服务、是指通过陆路(地上或者地下) 运送货物或者旅客的运输业务活动，包括铁路运输和其他陆路运输(公路运输缆车运输、索道运输、地铁运输、城市轻轨运输等)。<span class=\"sup--normal\" data-sup=\"1\" data-ctrmap=\":1,\" style=\"font-size: 12px; line-height: 0; position: relative; vertical-align: baseline; top: -0.5em; margin-left: 2px; color: rgb(51, 102, 204); cursor: pointer; padding: 0px 2px;\">&nbsp;[1]</span><a style=\"color: rgb(19, 110, 194); position: relative; top: -50px; font-size: 0px; line-height: 0;\" name=\"ref_[1]_22915097\"></a>&nbsp;</p><p>出租车公司向使用本公司自有出租车的出租车司机收取的管理费用，按陆路运输服务征收增值税。</p><p><br/></p>', '/uploads/imgs/202011/5fc4b45fb987e.jpeg', 0, 'admin', 3, '', 0, 1606726970, 0, '', 0, '', 0, 1, 0, NULL);
INSERT INTO `news_article` VALUES (11, 0, '1', '1', '1', '<p>1111</p>', '/uploads/imgs/202011/5fc4aa6902774.png', 0, 'admin', 3, '1', NULL, 1608188249, NULL, NULL, NULL, NULL, 0, 0, 0, 1608188259);
INSERT INTO `news_article` VALUES (12, 0, 'ccc', 'cc', '333', '<p>cccc</p>', '/uploads/imgs/202011/5fc4a93bc127a.jpeg', 0, 'admin', 3, '222', NULL, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 1609316846);

-- ----------------------------
-- Table structure for news_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `news_auth_group`;
CREATE TABLE `news_auth_group`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `rules` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of news_auth_group
-- ----------------------------
INSERT INTO `news_auth_group` VALUES (1, '超级管理员', 1, '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40.41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65');
INSERT INTO `news_auth_group` VALUES (3, '超级管理员1', 1, '2,3,4,5,6,7,8,9');

-- ----------------------------
-- Table structure for news_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `news_auth_group_access`;
CREATE TABLE `news_auth_group_access`  (
  `aid` mediumint(8) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL,
  UNIQUE INDEX `uid_group_id`(`aid`, `group_id`) USING BTREE,
  INDEX `uid`(`aid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of news_auth_group_access
-- ----------------------------
INSERT INTO `news_auth_group_access` VALUES (1, 1);
INSERT INTO `news_auth_group_access` VALUES (9, 1);

-- ----------------------------
-- Table structure for news_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `news_auth_rule`;
CREATE TABLE `news_auth_rule`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `title` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `condition` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `brief` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 66 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news_auth_rule
-- ----------------------------
INSERT INTO `news_auth_rule` VALUES (19, '/file/admin/upload_file', '上传文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (2, '/system/admin/edit_index_config', '修改首页配置', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (3, '/admins/createAdmin', '新增管理员', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (4, '/admins/get_admin_all', '查看所有管理员', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (5, '/admins/deleteAdmin', '删除管理员', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (6, '/admins/update_admin', '修改管理员信息', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (7, '/admin/onOff', '更改系统设置', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (8, '/image/del_img', '删除图片', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (9, '/image/get_img_all', '获取所有图片', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (10, '/image/upload_img', '上传图片', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (11, '/softDeletion/admin/add_categoryTrashed', '将分类批量添加到回收站', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (12, '/softDeletion/admin/add_articleTrashed', '将文章批量添加到回收站', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (13, '/softDeletion/admin/get_trashed', '查看回收站的所有文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (14, '/softDeletion/admin/recovery', '恢复回收站里所有文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (15, '/softDeletion/admin/recovery_trashedBatch', '批量恢复回收站文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (16, '/softDeletion/admin/del_trashedBatch', '批量清空回收站文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (17, '/softDeletion/admin/del_trashedAll', '清空回收站文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (18, '/file/del', '删除文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (20, '/file/admin/get_file_all', '查看所有文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (21, '/article/admin/get_article_all', '查看所有文章', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (22, '/article/admin/create_article', '上传文章', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (23, '/article/admin/delete_article', '删除文章', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (24, '/article/admin/update_article', '编辑文章', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (25, '/group/admin/get_interfaceAll', '查看所有权限', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (26, '/group/admin/getGroupContent', '查看组的权限', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (27, '/group/admin/getGroupAll', '查看所有组', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (28, '/group/admin/createGroup', '添加组', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (29, '/group/admin/deleteGroup', '删除组', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (30, '/group/admin/updateGroup', '更新组', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (1, '/file_manage/cs_oss', '检测oss链接', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (31, '/category/admin/update_category', '更新栏目', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (32, '/article/admin/get_article_content', '查看文章详情', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (33, '/article/admin/update_article_sort', '更新文章排序', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (34, '/article/admin/labelRecommendation', '根据标签获取推荐内容', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (35, '/article/admin/push_article', '推送文章', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (36, '/log/get_log', '查看所有日志', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (37, '/log/del_log', '清空日志', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (38, '/log/del_cache', '清空缓存', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (39, '/file_manage/get_load_file', '查看本地所有文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (40, '/file_manage/get_oss_file', '查看oss文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (41, '/file_manage/del_file', '文件管理-删除文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (42, '/sql/backup', '备份数据库', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (43, '/sql/backup_list', '备份文件列表', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (44, '/sql/restore', '还原数据库', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (45, '/sql/delete', '删除备份文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (46, '/file/download', '下载备份文件', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (47, '/temp/admin/get_all_temp', '获取所有模板', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (48, '/temp/admin/add_temp', '添加模板', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (49, '/temp/admin/edit_temp', '修改模板', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (50, '/banner/admin/banner_items_all', '查看所有广告', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (51, '/banner/admin/create_banner', '添加广告', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (52, '/banner/admin/delete_banner', '删除广告', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (53, '/banner/admin/update_banner', '更新广告', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (54, '/banner/admin/update_banner_sort', '更新广告排序', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (55, '/banner/admin/get_banner_content', '查看广告详情', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (56, '/system/admin/get_config', '查看系统配置', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (57, '/system/admin/update_config', '更新系统配置', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (58, '/system/admin/up_bottom_navigation', '修改底部导航', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (59, '/system/admin/edit_tep', '修改使用的模板', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (60, '/category/admin/get_category_all', '获取所有栏目', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (61, '/category/admin/delete_category', '删除栏目', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (62, '/category/admin/create_category', '新增栏目', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (63, '/category/admin/update_category_sort', '更新栏目排序', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (64, '/category/admin/article_category', '获取发文章的栏目列表', 1, 1, '', '');
INSERT INTO `news_auth_rule` VALUES (65, '/category/admin/get_one_category', '查看栏目详情', 1, 1, '', '');

-- ----------------------------
-- Table structure for news_banner
-- ----------------------------
DROP TABLE IF EXISTS `news_banner`;
CREATE TABLE `news_banner`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Banner名称，通常作为标识',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Banner描述',
  `delete_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'banner管理表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of news_banner
-- ----------------------------
INSERT INTO `news_banner` VALUES (1, 0, '1', '2', NULL, NULL);

-- ----------------------------
-- Table structure for news_banner_item
-- ----------------------------
DROP TABLE IF EXISTS `news_banner_item`;
CREATE TABLE `news_banner_item`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL DEFAULT 0,
  `key_word` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `img_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '外键，关联image表',
  `category_id` int(100) NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '跳转类型',
  `jump_id` int(11) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `delete_time` int(11) NULL DEFAULT NULL,
  `banner_id` int(11) NOT NULL COMMENT '外键，关联banner表',
  `update_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'banner子项表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for news_bottom_navigation
-- ----------------------------
DROP TABLE IF EXISTS `news_bottom_navigation`;
CREATE TABLE `news_bottom_navigation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `navigation_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `bottom_sort` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '排序',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '栏目id',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '0图片列表1文章列表2封面3us',
  `is_show` int(1) NOT NULL DEFAULT 1 COMMENT '是否显示',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of news_bottom_navigation
-- ----------------------------
INSERT INTO `news_bottom_navigation` VALUES (6, 0, '新闻快讯', '2', 4, 'article_list', 1);
INSERT INTO `news_bottom_navigation` VALUES (7, 2, '线上预约', '3', 1, 'cover', 0);
INSERT INTO `news_bottom_navigation` VALUES (8, 0, '快件运输', '1', 3, 'pic_list', 1);
INSERT INTO `news_bottom_navigation` VALUES (9, 2, '联系我们', '4', -1, 'us', 1);

-- ----------------------------
-- Table structure for news_category
-- ----------------------------
DROP TABLE IF EXISTS `news_category`;
CREATE TABLE `news_category`  (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL DEFAULT 0,
  `category_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '栏目标题',
  `short_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '栏目描述',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型list列表cover封面',
  `pid` int(11) NOT NULL DEFAULT 0,
  `level` tinyint(4) NOT NULL DEFAULT 0,
  `is_visible` int(11) NOT NULL DEFAULT 1 COMMENT '是否显示  1 显示 0 不显示',
  `sort` int(11) NULL DEFAULT NULL,
  `category_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商品分类图片',
  `template` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '模板',
  `seotitle` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT 'seo标题',
  `keyword` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '关键字',
  `is_jump` int(11) NOT NULL DEFAULT 0 COMMENT '是否跳转',
  `jumpaddress` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '跳转地址',
  `json` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 0 COMMENT '封面内容',
  `is_phone_index` int(11) NOT NULL DEFAULT 0 COMMENT '是否手机端首页显示0否1是',
  `is_pc_index` int(11) NOT NULL DEFAULT 0 COMMENT '是否pc首页显示0否1是',
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 AVG_ROW_LENGTH = 244 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of news_category
-- ----------------------------
INSERT INTO `news_category` VALUES (1, 0, '关于我们', '关于我们', 'cover', 0, 1, 1, 3, '/uploads/imgs/202012/5fc62612ccccf.png', '', '', '', 0, '', '{\"cover\":{\"flag\":true,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"article_list\":{\"flag\":false,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"pic_list\":{\"flag\":false,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]}}', '<p>关于我们</p>', 1, 1, NULL);
INSERT INTO `news_category` VALUES (2, 0, '大件运输', '大件运输', 'cover', 0, 1, 1, 1, '/uploads/imgs/202012/5fc626183484d.png', '', '', '', 0, '', '{\"cover\":{\"flag\":true,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"article_list\":{\"flag\":false,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"pic_list\":{\"flag\":false,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]}}', '<p>线大件运输</p>', 1, 0, NULL);
INSERT INTO `news_category` VALUES (3, 0, '快件运输', '快件运输', 'pic_list', 0, 1, 1, 2, '/uploads/imgs/202012/5fc6261c7b64d.png', '', '', '', 0, '', '{\"cover\":{\"flag\":true,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"article_list\":{\"flag\":false,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"pic_list\":{\"flag\":true,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]}}', '<p>sss</p>', 1, 1, NULL);
INSERT INTO `news_category` VALUES (4, 0, '新闻快讯', '新闻快讯', 'article_list', 0, 1, 1, 4, '/uploads/imgs/202012/5fc6262113c55.png', '', '', '', 0, '', '{\"cover\":{\"flag\":true,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"article_list\":{\"flag\":true,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"pic_list\":{\"flag\":true,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]}}', '', 1, 1, NULL);
INSERT INTO `news_category` VALUES (5, 0, '搬家', '搬家', 'pic_list', 3, 2, 1, 0, '/uploads/imgs/202011/5fc4b44d3ebda.jpeg', '', '', '', 0, '', '{\"cover\":{\"flag\":false,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"article_list\":{\"flag\":false,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"pic_list\":{\"flag\":true,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]}}', '', 0, 0, NULL);
INSERT INTO `news_category` VALUES (6, 0, '长途运输', '长途运输', 'pic_list', 3, 2, 1, 0, '/uploads/imgs/202011/5fc4a946e70d8.jpeg', '', '', '', 0, '', '{\"cover\":{\"flag\":false,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"article_list\":{\"flag\":false,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]},\"pic_list\":{\"flag\":true,\"data\":[\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]}}', '', 0, 0, NULL);
INSERT INTO `news_category` VALUES (7, 0, 'ces ', 'ccc', 'article_list', 0, 1, 1, 0, '/uploads/imgs/202011/5fc4a93bc127a.jpeg', '', '', '', 0, '', '[]', '', 0, 0, 1609316850);

-- ----------------------------
-- Table structure for news_file
-- ----------------------------
DROP TABLE IF EXISTS `news_file`;
CREATE TABLE `news_file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件路径',
  `file_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件存储方式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for news_form
-- ----------------------------
DROP TABLE IF EXISTS `news_form`;
CREATE TABLE `news_form`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `form_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of news_form
-- ----------------------------
INSERT INTO `news_form` VALUES (1, 0, '线下报名');
INSERT INTO `news_form` VALUES (2, 0, '线下报名');

-- ----------------------------
-- Table structure for news_image
-- ----------------------------
DROP TABLE IF EXISTS `news_image`;
CREATE TABLE `news_image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片路径',
  `from` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 来自本地，2 来自公网',
  `use_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cid` int(11) NOT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '图片总表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of news_image
-- ----------------------------
INSERT INTO `news_image` VALUES (1, 0, '/uploads/imgs/202011/5fc4a93bc127a.jpeg', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (2, 0, '/uploads/imgs/202011/5fc4a9441e92f.jpeg', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (3, 0, '/uploads/imgs/202011/5fc4a946e70d8.jpeg', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (4, 0, '/uploads/imgs/202011/5fc4aa61a34fc.png', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (5, 0, '/uploads/imgs/202011/5fc4aa6529687.png', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (6, 0, '/uploads/imgs/202011/5fc4aa67062f5.png', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (7, 0, '/uploads/imgs/202011/5fc4aa6902774.png', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (8, 0, '/uploads/imgs/202011/5fc4b09aea046.png', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (9, 0, '/uploads/imgs/202011/5fc4b448ba0e8.jpeg', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (10, 0, '/uploads/imgs/202011/5fc4b44d3ebda.jpeg', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (11, 0, '/uploads/imgs/202011/5fc4b450f1a1a.jpeg', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (12, 0, '/uploads/imgs/202011/5fc4b456b27b8.jpeg', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (13, 0, '/uploads/imgs/202011/5fc4b45a661e3.jpeg', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (14, 0, '/uploads/imgs/202011/5fc4b45fb987e.jpeg', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (15, 0, '/uploads/imgs/202012/5fc62612ccccf.png', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (16, 0, '/uploads/imgs/202012/5fc626183484d.png', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (17, 0, '/uploads/imgs/202012/5fc6261c7b64d.png', 1, '', 0, NULL, NULL);
INSERT INTO `news_image` VALUES (18, 0, '/uploads/imgs/202012/5fc6262113c55.png', 1, '', 0, NULL, NULL);

-- ----------------------------
-- Table structure for news_link
-- ----------------------------
DROP TABLE IF EXISTS `news_link`;
CREATE TABLE `news_link`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img_id` int(11) NULL DEFAULT NULL COMMENT '图标',
  `linkname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '链接名称',
  `linkurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '链接地址',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of news_link
-- ----------------------------
INSERT INTO `news_link` VALUES (1, 1, '如花商城', 'http://ruhuashop.com/', 0, 0);
INSERT INTO `news_link` VALUES (2, 1, '开发平台', 'http://open.ruhuashop.com/cms/#/', 0, 0);

-- ----------------------------
-- Table structure for news_sys_config
-- ----------------------------
DROP TABLE IF EXISTS `news_sys_config`;
CREATE TABLE `news_sys_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uniacid` int(11) NOT NULL,
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置项',
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置值json',
  `desc` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `type` int(11) NOT NULL COMMENT '1配置2基础3网站信息',
  `is_use` tinyint(4) NOT NULL DEFAULT 1 COMMENT '是否启用 1启用 0不启用',
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 AVG_ROW_LENGTH = 963 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '第三方配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of news_sys_config
-- ----------------------------
INSERT INTO `news_sys_config` VALUES (1, 0, 'wx_app_id', '', '小程序appid', 1, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (2, 0, 'wx_app_secret', '', '小程序秘钥', 1, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (3, 0, 'setSignName', '', '设置标志名称', 1, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (4, 0, 'setTemplateCode', '', '公司名称', 1, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (5, 0, 'gzh_appid', '', '公众号appid', 1, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (6, 0, 'gzh_secret', '', '公众号密钥', 1, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (7, 0, 'wx_token_expire', '7200', 'token有效期', 1, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (8, 0, 'pay_num', '', '商户id', 1, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (9, 0, 'pay_key', '', '商户key', 1, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (10, 0, 'index_tmp', '', '首页企业简介', 3, 1, 0);
INSERT INTO `news_sys_config` VALUES (11, 0, 'site_name', '某某企业', '站点名称', 3, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (12, 0, 'tel', '', '联系电话', 3, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (13, 0, 'home_cpy', '', '公司名称', 3, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (14, 0, 'seo_title', '', '首页标题', 3, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (15, 0, 'cpy_address', '', '公司地址', 3, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (16, 0, 'seo_desc', '', '首页描述', 3, 1, 1567744893);
INSERT INTO `news_sys_config` VALUES (17, 0, 'customer_service_switch', '0', '客服开关', 0, 0, 0);
INSERT INTO `news_sys_config` VALUES (18, 0, 'pc_tmp', '', 'pc端模板', 4, 1, 0);
INSERT INTO `news_sys_config` VALUES (19, 0, 'phone_tmp', '', '手机端模板', 4, 1, 0);
INSERT INTO `news_sys_config` VALUES (20, 0, 'file_type', '', '文件存储类型：0 本地 1 oss', 5, 1, 0);
INSERT INTO `news_sys_config` VALUES (21, 0, 'accessKeyId', '', 'oss的accessKeyId', 5, 1, 0);
INSERT INTO `news_sys_config` VALUES (22, 0, 'accessKeySecret', '', 'oss的accessKeySecret', 5, 1, 0);
INSERT INTO `news_sys_config` VALUES (23, 0, 'bucket', '', 'bucket名称', 5, 1, 0);
INSERT INTO `news_sys_config` VALUES (24, 0, 'endpoint', '', 'oss访问的域名', 5, 1, 0);
INSERT INTO `news_sys_config` VALUES (25, 0, 'index_json', '[\"\\u5c0f\\u7a0b\\u5e8f\\u7535\\u5546\\u7cfb\\u7edf\",\"\\u5e2e\\u52a9\\u5546\\u5bb6\\u9ad8\\u6548\\u5feb\\u6377\\u7684\\u6253\\u9020\\u4e00\\u6b3e\\u529f\\u80fd\\u5b8c\\u5584\\u7684\\u8d2d\\u7269\\u5c0f\\u7a0b\\u5e8f\\uff0c\\u901f\\u5ea6\\u5feb\\uff0c\\u65e0\\u9700\\u4e0b\\u8f7d\\u5b89\\u88c5\\uff0c\\u5171\\u4eab\\u5fae\\u4fe18\\u4ebf\\u7528\\u6237\\u6d41\\u91cf\\uff0c\\u5f00\\u542f\\u96f6\\u552e\\u6a21\\u5f0f\",\"\\u884c\\u4e1a\\u70ed\\u8bcd \\u7b49\\u4f60\\u62a2\\u5360\",\"\\u8d8a\\u65e9\\u4e0a\\u7ebf\\u5c0f\\u7a0b\\u5e8f\\u5373\\u53ef\\u4f18\\u5148\\u6ce8\\u518c\\u4f18\\u79c0\\u884c\\u4e1a\\u70ed\\u8bcd\\u3001\\u907f\\u514d\\u540c\\u884c\\u62a2\\u5360\",\"\\u65e0\\u9700\\u4e0b\\u8f7d \\u66f4\\u591a\\u6d41\\u91cf\",\"\\u6709\\u5fae\\u4fe1\\u5373\\u53ef\\u5feb\\u901f\\u8fdb\\u5165\\u5c0f\\u7a0b\\u5e8f\\uff0c\\u4e00\\u7ad9\\u5f0f\\u5feb\\u901f\\u8d2d\\u7269\\u3001\\u5e26\\u6765\\u66f4\\u591a\\u6d41\\u91cf\",\"\\u964d\\u4f4e\\u95e8\\u69db \\u5feb\\u901f\\u521b\\u4e1a\",\"\\u4e3a\\u66f4\\u591a\\u4e2a\\u4eba\\u548c\\u5c0f\\u578b\\u4f01\\u4e1a\\u964d\\u4f4e\\u521b\\u4e1a\\u95e8\\u69db\\u3001\\u66f4\\u5feb\\u7684\\u5165\\u9a7b\\u79fb\\u52a8\\u7535\\u5546\",\"\\u5e97\\u94fa\\u9996\\u9875\\u7ec4\\u4ef6\\u5143\\u7d20\",\"\\u62e5\\u6709\\u4e00\\u4e2a\\u81ea\\u5df1\\u7684\\u5546\\u57ce\\u5c0f\\u7a0b\\u5e8f\\u53ea\\u9700\\u52a8\\u52a8\\u9f20\\u6807\\uff0c\\u62d2\\u63a5\\u5343\\u7bc7\\u4e00\\u5f8b\",\"\\u9ed4\\u57df\\u5546\\u57ce\\u7cfb\\u7edf\\u6280\\u672f\\u652f\\u6301\",\"\\u81ea\\u4e3b\\u7814\\u53d1\",\"\\u63d0\\u4f9b\\u6e90\\u7801\",\"\\u514d\\u8d39\\u5347\\u7ea7\",\"\\u4e13\\u4e1a\\u5ba2\\u670d\",\"\\u8f7b\\u7ad9\\u4f18\\u52bf\",\"\\u81f4\\u529b\\u4e8e\\u6a21\\u677f\\u5f00\\u53d1\\uff0c\\u5feb\\u901f\\u3001\\u9ad8\\u6548\\u3001\\u7a33\\u5b9a\\u3002\\u4e00\\u5957\\u6a21\\u677f\\u591a\\u4e2a\\u7f51\\u7ad9\\uff0c\\u4e00\\u4e2a\\u6570\\u636e\\u591a\\u5957\\u6a21\\u677f\",\"\\u8f7b\\u7ad9\\u5f00\\u6e90\\u7cfb\\u7edf\",\"\\u6211\\u4eec\\u7684\\u670d\\u52a1\",\"\\u56e2\\u961f\\u6210\\u5458\\u5168\\u90fd\\u662f\\u8ba1\\u7b97\\u673a\\u4e13\\u4e1a\\u6bd5\\u4e1a\\uff0c\\u4e3b\\u8981\\u6d89\\u53ca\\u5f00\\u53d1\\u884c\\u4e1a\\uff0c\\u6709\\u7740\\u4e30\\u5bcc\\u7684\\u884c\\u4e1a\\u7ecf\\u9a8c\\u548c\\u65e0\\u4e0e\\u4f26\\u6bd4\\u7684\\u6280\\u672f\\u5b9e\\u529b\",\"iconfuwu\",\"\\u4e00\\u7ad9\\u5f0f\\u670d\\u52a1\",\"\\u6ee1\\u8db3\\u9700\\u6c42\\uff0c\\u4fdd\\u8bc1\\u8d28\\u91cf\\uff0c\\u8ba9\\u5ba2\\u6237\\u6ee1\\u610f\",\"icondingzhi\",\"APP\\u5f00\\u53d1\\u5236\\u5b9a\",\"\\u4e30\\u5bcc\\u7684APP\\u4ee5\\u53ca\\u540e\\u53f0\\u5f00\\u53d1\\u7ecf\\u9a8c\\uff0c\\u63d0\\u4f9b\\u6574\\u4e2aAPP\\u89e3\\u51b3\\u65b9\\u6848\",\"icondashujukeshihuaico-\",\"CMS\\u5f00\\u53d1\\u5236\\u5b9a\",\"\\u6309\\u9700\\u5b9a\\u5236\\uff0c\\u7cbe\\u51c6\\u5f00\\u53d1\\uff0c\\u6587\\u7ae0\\uff0c\\u4ea7\\u54c1\\uff0c\\u8868\\u5355\",\"iconkaiyuan\",\"\\u5f00\\u6e90\\u4ea7\\u54c1\\u652f\\u6301\",\"\\u79c9\\u627f\\u5f00\\u6e90\\u539f\\u5219\\uff0c\\u4f18\\u79c0\\u7684\\u4ee3\\u7801\\u8d28\\u91cf\",\"iconweixin\",\"\\u4f01\\u4e1a\\u5fae\\u4fe1\",\"\\u5305\\u542b\\u5404\\u4e2a\\u884c\\u4e1a\\u7cbe\\u82f1\\uff0c\\u6253\\u901a\\u751f\\u610f\\u7684\\u5927\\u95e8\",\"iconzixun\",\"\\u670d\\u52a1\\u54a8\\u8be2\",\"\\u4e30\\u5bcc\\u7684\\u5b9e\\u6218\\u7ecf\\u9a8c\\uff0c\\u5b8c\\u7f8e\\u7684\\u89e3\\u51b3\\u65b9\\u6848\"]', '首页json', 8, 1, 0);
INSERT INTO `news_sys_config` VALUES (26, 0, 'kf', '', '客服', 6, 1, 0);
INSERT INTO `news_sys_config` VALUES (27, 0, 'watermark_text', '', '水印文字', 7, 1, 0);
INSERT INTO `news_sys_config` VALUES (28, 0, 'watermark', '', '水印开关', 7, 1, 0);
INSERT INTO `news_sys_config` VALUES (29, 0, 'longitude', '104.921027', '企业经度', 3, 1, 0);
INSERT INTO `news_sys_config` VALUES (30, 0, 'latitude', '25.104948', '企业纬度', 3, 1, 0);
INSERT INTO `news_sys_config` VALUES (31, 0, 'beian', '', '企业备案号', 3, 1, 0);
INSERT INTO `news_sys_config` VALUES (32, 0, 'email', '1222222@qq.com', '邮箱', 3, 1, 0);

-- ----------------------------
-- Table structure for news_user
-- ----------------------------
DROP TABLE IF EXISTS `news_user`;
CREATE TABLE `news_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniacid` int(11) NOT NULL,
  `openid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `openid_gzh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `session_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `unionid` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nickname` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `headpic` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `points` int(11) NOT NULL,
  `start` int(11) NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL COMMENT '注册时间',
  `update_time` int(11) NULL DEFAULT NULL,
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_money` int(11) NOT NULL,
  `prepay_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_visible` int(1) NOT NULL DEFAULT 1 COMMENT '1显示0隐藏',
  `code` int(11) NULL DEFAULT 0 COMMENT '验证码',
  `code_time` int(11) NOT NULL COMMENT '验证码保存时间',
  `vip_status` int(1) NOT NULL DEFAULT 0 COMMENT '是否是会员(0非会员，1会员，2会员已过期)',
  `vip_time` int(11) NOT NULL COMMENT '会员到期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for news_web_template
-- ----------------------------
DROP TABLE IF EXISTS `news_web_template`;
CREATE TABLE `news_web_template`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cn_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '中文名',
  `uniacid` int(11) NOT NULL,
  `en_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英文名',
  `intro` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板简介',
  `list_tmp` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT '列表模板',
  `cover_tmp` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT '封面模板',
  `template_type` int(11) NOT NULL COMMENT '0PC1Phone',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '缩略图',
  `delete_time` int(11) NULL DEFAULT NULL,
  `article_list_num` int(2) NOT NULL COMMENT '文章列表长度',
  `pic_list_num` int(2) NOT NULL COMMENT '图片列表长度',
  `cover_num` int(2) NOT NULL COMMENT '封面长度',
  `index_json_num` int(2) NULL DEFAULT NULL COMMENT '首页json长度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of news_web_template
-- ----------------------------
INSERT INTO `news_web_template` VALUES (30, 'qianyu-B', 0, 'B', '餐饮专用', '', '', 0, '/uploads//imgs/a1.jpg', NULL, 3, 4, 8, 15);
INSERT INTO `news_web_template` VALUES (31, '餐饮微网站4', 0, 'adhjds', '餐饮专用', '', '', 1, '/uploads//imgs/a2.jpg', NULL, 3, 3, 3, 0);
INSERT INTO `news_web_template` VALUES (32, 'qianyu-A', 0, 'A', '餐饮专用', '', '', 0, '/uploads//imgs/a3.jpg', NULL, 30, 26, 8, 38);
INSERT INTO `news_web_template` VALUES (33, '餐饮微网站3', 0, 'adhjds', '餐饮专用', '', '', 1, '/uploads//imgs/a4.jpg', NULL, 5, 5, 3, 0);
INSERT INTO `news_web_template` VALUES (35, '餐饮微网站2', 0, 'adhjds', '餐饮专用', '', '', 1, '/uploads//imgs/a1.jpg', NULL, 4, 4, 3, 0);

SET FOREIGN_KEY_CHECKS = 1;
