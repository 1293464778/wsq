/*
Navicat MySQL Data Transfer

Source Server         : 121.199.30.7
Source Server Version : 50540
Source Host           : 121.199.30.7:3306
Source Database       : farm

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2017-05-09 11:39:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `farm_admin`
-- ----------------------------
DROP TABLE IF EXISTS `farm_admin`;
CREATE TABLE `farm_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `regTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `regIp` varchar(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `loginTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `loginIp` varchar(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '用户状态  0 禁用，1正常',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of farm_admin
-- ----------------------------
INSERT INTO `farm_admin` VALUES ('1', 'admin', '227af9354aef4e7d4050b1043d5be6b7', '47276980@qq.com', '12345678912', '0', '0', '1494300587', '123.149.211.89', '0', '1');
INSERT INTO `farm_admin` VALUES ('2', 'user01', '227af9354aef4e7d4050b1043d5be6b7', '', '', '1490757699', '123.149.210.123', '1490757843', '123.149.210.123', '1490757699', '1');

-- ----------------------------
-- Table structure for `farm_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `farm_auth_group`;
CREATE TABLE `farm_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '为1正常，为0禁用',
  `rules` char(80) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id， 多个规则","隔开',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of farm_auth_group
-- ----------------------------
INSERT INTO `farm_auth_group` VALUES ('1', '超级管理员', '1', '1,22,23,20,21,18,19,2,7,4,3,6,14,17,24,25,26,27,28,29,30,31,32,33');
INSERT INTO `farm_auth_group` VALUES ('4', '普通管理员', '1', '1,18,19,32,20,28,21,22,23,24,25,29,31,30');

-- ----------------------------
-- Table structure for `farm_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `farm_auth_group_access`;
CREATE TABLE `farm_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组权限表';

-- ----------------------------
-- Records of farm_auth_group_access
-- ----------------------------
INSERT INTO `farm_auth_group_access` VALUES ('1', '1');
INSERT INTO `farm_auth_group_access` VALUES ('2', '4');

-- ----------------------------
-- Table structure for `farm_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `farm_auth_rule`;
CREATE TABLE `farm_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '为1正常，为0禁用',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证',
  `pid` mediumint(8) NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `sorts` mediumint(8) NOT NULL DEFAULT '0' COMMENT '升序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of farm_auth_rule
-- ----------------------------
INSERT INTO `farm_auth_rule` VALUES ('1', 'Index/index', '系统主页', '1', '1', '', '0', '0');
INSERT INTO `farm_auth_rule` VALUES ('2', 'Manager', '权限管理', '1', '1', '', '0', '6');
INSERT INTO `farm_auth_rule` VALUES ('3', 'Manager/adminList', '管理员列表', '1', '1', '', '2', '0');
INSERT INTO `farm_auth_rule` VALUES ('4', 'Manager/rolesList', '角色列表', '1', '1', '', '2', '0');
INSERT INTO `farm_auth_rule` VALUES ('6', 'Sys', '系统管理', '1', '1', '', '0', '1');
INSERT INTO `farm_auth_rule` VALUES ('7', 'Manager/rulesList', '权限管理', '0', '0', '', '2', '0');
INSERT INTO `farm_auth_rule` VALUES ('14', 'Sys/index', '系统公告', '1', '1', '', '6', '0');
INSERT INTO `farm_auth_rule` VALUES ('17', 'Log/index', '登录日志', '1', '1', '', '0', '9');
INSERT INTO `farm_auth_rule` VALUES ('18', 'Statis', '数据统计', '1', '1', '', '0', '6');
INSERT INTO `farm_auth_rule` VALUES ('19', 'Statis/index', '定向出售订单统计', '1', '1', '', '18', '0');
INSERT INTO `farm_auth_rule` VALUES ('20', 'Garden', '果园管理', '1', '1', '', '0', '4');
INSERT INTO `farm_auth_rule` VALUES ('21', 'Garden/index', '果园列表', '1', '1', '', '20', '0');
INSERT INTO `farm_auth_rule` VALUES ('22', 'User', '用户管理', '1', '1', '', '0', '2');
INSERT INTO `farm_auth_rule` VALUES ('23', 'User/index', '用户列表', '1', '1', '', '22', '0');
INSERT INTO `farm_auth_rule` VALUES ('24', 'Apply', '申请管理', '1', '1', '', '0', '3');
INSERT INTO `farm_auth_rule` VALUES ('25', 'Apply/index', '申请列表', '1', '1', '', '24', '0');
INSERT INTO `farm_auth_rule` VALUES ('26', 'Mail/index', '站内信', '1', '1', '', '6', '0');
INSERT INTO `farm_auth_rule` VALUES ('27', 'Config/index', '系统配置', '1', '1', '', '6', '0');
INSERT INTO `farm_auth_rule` VALUES ('28', 'Garden/sys', '衰减率配置', '1', '1', '', '20', '0');
INSERT INTO `farm_auth_rule` VALUES ('29', 'Order', '订单管理', '1', '1', '', '0', '5');
INSERT INTO `farm_auth_rule` VALUES ('30', 'Order/direction', '定向出售订单列表', '1', '1', '', '29', '0');
INSERT INTO `farm_auth_rule` VALUES ('31', 'Order/commission', '委托出售订单列表', '1', '1', '', '29', '0');
INSERT INTO `farm_auth_rule` VALUES ('32', 'Statis/commission', '委托出售订单统计', '1', '1', '', '18', '0');
INSERT INTO `farm_auth_rule` VALUES ('33', 'Sys/remind', '温馨提示', '1', '1', '', '6', '0');

-- ----------------------------
-- Table structure for `farm_commission_sale`
-- ----------------------------
DROP TABLE IF EXISTS `farm_commission_sale`;
CREATE TABLE `farm_commission_sale` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `saleId` int(11) unsigned NOT NULL,
  `saleNum` varchar(255) NOT NULL COMMENT '出售数量',
  `realNum` varchar(255) NOT NULL COMMENT '实际出售数量',
  `fee` varchar(255) NOT NULL COMMENT '手续费比例',
  `status` tinyint(1) NOT NULL COMMENT '状态1未处理2已处理',
  `createTime` int(11) NOT NULL,
  `updateTime` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_id_index` (`saleId`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='委托出售表';

-- ----------------------------
-- Records of farm_commission_sale
-- ----------------------------
INSERT INTO `farm_commission_sale` VALUES ('1', '3', '100', '70', '0.30', '2', '1490156053', '1490156053');
INSERT INTO `farm_commission_sale` VALUES ('2', '6', '100', '70', '0.30', '2', '1490940811', '1490940811');
INSERT INTO `farm_commission_sale` VALUES ('3', '6', '100', '70', '0.30', '1', '1490942838', '1490942838');
INSERT INTO `farm_commission_sale` VALUES ('4', '6', '100', '70', '0.30', '1', '1490943492', '1490943492');
INSERT INTO `farm_commission_sale` VALUES ('5', '6', '100', '80', '0.20', '1', '1490952047', '1490952047');
INSERT INTO `farm_commission_sale` VALUES ('6', '6', '100', '80', '0.20', '1', '1490952206', '1490952206');
INSERT INTO `farm_commission_sale` VALUES ('7', '6', '100', '80', '0.20', '1', '1490952327', '1490952327');
INSERT INTO `farm_commission_sale` VALUES ('8', '6', '100', '80', '0.20', '1', '1490952437', '1490952437');
INSERT INTO `farm_commission_sale` VALUES ('9', '6', '100', '80', '0.20', '1', '1490952669', '1490952669');
INSERT INTO `farm_commission_sale` VALUES ('10', '6', '100', '80', '0.20', '1', '1490952809', '1490952809');
INSERT INTO `farm_commission_sale` VALUES ('11', '6', '100', '80', '0.20', '1', '1490952844', '1490952844');
INSERT INTO `farm_commission_sale` VALUES ('12', '6', '100', '80', '0.20', '1', '1490952880', '1490952880');
INSERT INTO `farm_commission_sale` VALUES ('13', '6', '100', '80', '0.20', '1', '1490952947', '1490952947');
INSERT INTO `farm_commission_sale` VALUES ('14', '6', '100', '80', '0.20', '1', '1490953106', '1490953106');
INSERT INTO `farm_commission_sale` VALUES ('15', '6', '100', '80', '0.20', '2', '1490955420', '1491362800');
INSERT INTO `farm_commission_sale` VALUES ('16', '6', '100', '80', '0.20', '2', '1491035412', '1491035412');
INSERT INTO `farm_commission_sale` VALUES ('17', '6', '100', '80', '0.20', '2', '1491362391', '1491362790');
INSERT INTO `farm_commission_sale` VALUES ('18', '7', '100', '80', '0.20', '2', '1491377531', '1491377795');
INSERT INTO `farm_commission_sale` VALUES ('19', '10', '100', '80', '0.20', '2', '1491451441', '1491451503');
INSERT INTO `farm_commission_sale` VALUES ('20', '57', '100', '80', '0.20', '2', '1491469913', '1491470063');
INSERT INTO `farm_commission_sale` VALUES ('21', '12', '100', '80', '0.20', '2', '1491530938', '1491802893');
INSERT INTO `farm_commission_sale` VALUES ('22', '7', '100', '80', '0.20', '2', '1491552191', '1491552210');
INSERT INTO `farm_commission_sale` VALUES ('23', '79', '100', '80', '0.20', '1', '1492083822', '1492083822');
INSERT INTO `farm_commission_sale` VALUES ('24', '79', '100', '80', '0.20', '1', '1492083835', '1492083835');
INSERT INTO `farm_commission_sale` VALUES ('25', '79', '100', '80', '0.20', '1', '1492843986', '1492843986');
INSERT INTO `farm_commission_sale` VALUES ('26', '79', '100', '80', '0.20', '1', '1492843991', '1492843991');
INSERT INTO `farm_commission_sale` VALUES ('27', '79', '100', '80', '0.20', '1', '1492843998', '1492843998');
INSERT INTO `farm_commission_sale` VALUES ('28', '79', '100', '80', '0.20', '1', '1492844003', '1492844003');
INSERT INTO `farm_commission_sale` VALUES ('29', '79', '100', '80', '0.20', '1', '1492844007', '1492844007');
INSERT INTO `farm_commission_sale` VALUES ('30', '79', '100', '80', '0.20', '1', '1492844012', '1492844012');
INSERT INTO `farm_commission_sale` VALUES ('31', '79', '100', '80', '0.20', '1', '1492844016', '1492844016');
INSERT INTO `farm_commission_sale` VALUES ('32', '79', '100', '80', '0.20', '1', '1492844020', '1492844020');
INSERT INTO `farm_commission_sale` VALUES ('33', '79', '100', '80', '0.20', '1', '1492844024', '1492844024');
INSERT INTO `farm_commission_sale` VALUES ('34', '79', '100', '80', '0.20', '1', '1492844028', '1492844028');

-- ----------------------------
-- Table structure for `farm_commit_profit`
-- ----------------------------
DROP TABLE IF EXISTS `farm_commit_profit`;
CREATE TABLE `farm_commit_profit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `adminId` int(11) NOT NULL,
  `clickTime` int(11) unsigned NOT NULL COMMENT '点击日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='管理员点击确认收益表';

-- ----------------------------
-- Records of farm_commit_profit
-- ----------------------------
INSERT INTO `farm_commit_profit` VALUES ('1', '1', '1489484253');
INSERT INTO `farm_commit_profit` VALUES ('4', '1', '1489563011');
INSERT INTO `farm_commit_profit` VALUES ('5', '1', '1489731747');
INSERT INTO `farm_commit_profit` VALUES ('6', '1', '1489976318');
INSERT INTO `farm_commit_profit` VALUES ('8', '1', '1490062853');
INSERT INTO `farm_commit_profit` VALUES ('9', '1', '1490231237');
INSERT INTO `farm_commit_profit` VALUES ('10', '1', '1490316248');
INSERT INTO `farm_commit_profit` VALUES ('11', '1', '1490578997');
INSERT INTO `farm_commit_profit` VALUES ('12', '1', '1490665581');
INSERT INTO `farm_commit_profit` VALUES ('15', '1', '1490780024');
INSERT INTO `farm_commit_profit` VALUES ('16', '1', '1490836581');
INSERT INTO `farm_commit_profit` VALUES ('17', '1', '1490938415');
INSERT INTO `farm_commit_profit` VALUES ('18', '1', '1491009576');
INSERT INTO `farm_commit_profit` VALUES ('19', '1', '1491353897');
INSERT INTO `farm_commit_profit` VALUES ('20', '1', '1491441087');
INSERT INTO `farm_commit_profit` VALUES ('21', '1', '1491530424');
INSERT INTO `farm_commit_profit` VALUES ('22', '1', '1491802844');
INSERT INTO `farm_commit_profit` VALUES ('23', '1', '1491865142');

-- ----------------------------
-- Table structure for `farm_config`
-- ----------------------------
DROP TABLE IF EXISTS `farm_config`;
CREATE TABLE `farm_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `config` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `type` tinyint(2) unsigned NOT NULL COMMENT '类型1等级配置收益比例2果园配置3道具配置4其他配置5衰减率配置',
  PRIMARY KEY (`id`),
  KEY `config_id_index` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
-- Records of farm_config
-- ----------------------------
INSERT INTO `farm_config` VALUES ('1', '一级贫农对应的收益率', '0.01', '1');
INSERT INTO `farm_config` VALUES ('2', '二级中农对应的收益率', '0.01', '1');
INSERT INTO `farm_config` VALUES ('3', '三级中上农对应的收益率', '0.01', '1');
INSERT INTO `farm_config` VALUES ('4', '四级富农对应的收益率', '0.01', '1');
INSERT INTO `farm_config` VALUES ('5', '五级农场主对应的收益率', '0.01', '1');
INSERT INTO `farm_config` VALUES ('6', '六级庄园主对应的收益率', '0.01', '1');
INSERT INTO `farm_config` VALUES ('7', '七级地产主对应的收益率', '0.01', '1');
INSERT INTO `farm_config` VALUES ('8', '普通土地需要果实基数', '300', '2');
INSERT INTO `farm_config` VALUES ('9', '金土地需要果实基数', '3000', '2');
INSERT INTO `farm_config` VALUES ('10', '系统每天派发化肥比例', '0.0061', '2');
INSERT INTO `farm_config` VALUES ('11', '好友采蜜为好友化肥数量的比例', '0.0', '2');
INSERT INTO `farm_config` VALUES ('12', '施肥1对应增加果实的数量', '1', '2');
INSERT INTO `farm_config` VALUES ('13', '系统每天派发的收益比例', '0.00', '2');
INSERT INTO `farm_config` VALUES ('14', '种子转化果实的比例', '1', '2');
INSERT INTO `farm_config` VALUES ('15', '土地果实不收益达到基数的倍数', '4', '2');
INSERT INTO `farm_config` VALUES ('16', '1条狗增加的收益率', '0.01', '3');
INSERT INTO `farm_config` VALUES ('17', '1个稻草人增加的收益率', '0.01', '3');
INSERT INTO `farm_config` VALUES ('18', '增加1个稻草人需要推荐的人数', '10', '3');
INSERT INTO `farm_config` VALUES ('19', '增加1条狗需要化肥的总数', '500', '3');
INSERT INTO `farm_config` VALUES ('20', '稻草人上限的数量', '4', '3');
INSERT INTO `farm_config` VALUES ('21', '狗上限的数量', '2', '3');
INSERT INTO `farm_config` VALUES ('22', '账号申请需要达到的果实数量', '330', '4');
INSERT INTO `farm_config` VALUES ('23', '委托出售平台收取佣金的比例', '0.30', '4');
INSERT INTO `farm_config` VALUES ('24', '定向出售平台收取佣金的比例', '0.10', '4');
INSERT INTO `farm_config` VALUES ('25', '发布一次站内信需要果实的数量', '10', '4');
INSERT INTO `farm_config` VALUES ('26', '推荐1人赠送的种子数量', '16', '4');
INSERT INTO `farm_config` VALUES ('33', '900', '0.001', '5');
INSERT INTO `farm_config` VALUES ('32', '800', '0.001', '5');
INSERT INTO `farm_config` VALUES ('27', '定向委托出售的比例', '0.30', '4');

-- ----------------------------
-- Table structure for `farm_direction_sale`
-- ----------------------------
DROP TABLE IF EXISTS `farm_direction_sale`;
CREATE TABLE `farm_direction_sale` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `saleId` int(11) unsigned NOT NULL COMMENT '出售人id',
  `saleNum` varchar(11) NOT NULL COMMENT '出售数量',
  `buyId` int(11) unsigned NOT NULL COMMENT '购买人id',
  `buyUsername` varchar(255) NOT NULL COMMENT '购买人账号',
  `buyRealname` varchar(255) NOT NULL COMMENT '购买人姓名',
  `realNum` varchar(255) NOT NULL COMMENT '实际交易数量',
  `fee` varchar(255) NOT NULL COMMENT '手续费比例',
  `status` tinyint(1) unsigned NOT NULL COMMENT '状态 0待买家确认  1买家已确认   2卖家确认',
  `createTime` int(11) unsigned NOT NULL,
  `updateTime` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_id_index_dir` (`saleId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='定向出售表';

-- ----------------------------
-- Records of farm_direction_sale
-- ----------------------------
INSERT INTO `farm_direction_sale` VALUES ('1', '5', '10', '4', 'user04', '小刘', '9', '0.10', '2', '1489712104', '1489712104');
INSERT INTO `farm_direction_sale` VALUES ('2', '6', '100', '7', 'zhu01', '整蛊一', '90', '0.10', '0', '1490940791', '1490940791');
INSERT INTO `farm_direction_sale` VALUES ('3', '6', '100', '7', 'zhu01', '整蛊一', '90', '0.10', '2', '1490940842', '1490940842');
INSERT INTO `farm_direction_sale` VALUES ('4', '6', '10', '7', 'zhu01', '整蛊一', '9.5', '0.05', '2', '1491035593', '1491035593');
INSERT INTO `farm_direction_sale` VALUES ('5', '6', '20', '7', 'zhu01', '整蛊一', '19', '0.05', '1', '1491036816', '1491373517');
INSERT INTO `farm_direction_sale` VALUES ('6', '6', '10', '7', 'zhu01', '整蛊一', '9.5', '0.05', '2', '1491036836', '1491372365');
INSERT INTO `farm_direction_sale` VALUES ('7', '6', '30', '7', 'zhu01', '整蛊一', '28.5', '0.05', '2', '1491037057', '1491372246');
INSERT INTO `farm_direction_sale` VALUES ('8', '6', '10', '7', 'zhu01', '整蛊一', '9.5', '0.05', '2', '1491037077', '1491037077');
INSERT INTO `farm_direction_sale` VALUES ('9', '6', '10', '7', 'zhu01', '整蛊一', '9.5', '0.05', '2', '1491037099', '1491037099');
INSERT INTO `farm_direction_sale` VALUES ('10', '7', '10', '6', '朱keke', '朱可1', '9.5', '0.05', '2', '1491377667', '1491386829');
INSERT INTO `farm_direction_sale` VALUES ('11', '10', '50', '52', '后台收益', '后台收益', '47.5', '0.05', '2', '1491451484', '1491451642');
INSERT INTO `farm_direction_sale` VALUES ('12', '57', '20', '24', 'kk01', '好友一', '19', '0.05', '2', '1491469976', '1491470148');
INSERT INTO `farm_direction_sale` VALUES ('13', '12', '50', '7', 'zhukk', '整蛊e', '47.5', '0.05', '2', '1491530993', '1491531049');
INSERT INTO `farm_direction_sale` VALUES ('14', '7', '10', '36', '测试道具', '道具1', '9.5', '0.05', '2', '1491552280', '1491552336');
INSERT INTO `farm_direction_sale` VALUES ('15', '7', '10', '36', '测试道具', '道具1', '9.5', '0.05', '2', '1491552407', '1491552459');
INSERT INTO `farm_direction_sale` VALUES ('16', '81', '10', '90', 'LL0000', '李龙', '9.5', '0.05', '2', '1493694192', '1493694310');
INSERT INTO `farm_direction_sale` VALUES ('17', '81', '100', '90', 'LL0000', '李龙', '90', '0.10', '2', '1493694734', '1493694987');
INSERT INTO `farm_direction_sale` VALUES ('18', '81', '660', '90', 'LL0000', '李龙', '594', '0.10', '2', '1493697852', '1493698315');
INSERT INTO `farm_direction_sale` VALUES ('19', '81', '470', '90', 'LL0000', '李龙', '423', '0.10', '2', '1493700097', '1493700285');
INSERT INTO `farm_direction_sale` VALUES ('20', '90', '790', '95', 'lxn123', '柳晓宁', '711', '0.10', '2', '1493716391', '1493716519');

-- ----------------------------
-- Table structure for `farm_fertilizer`
-- ----------------------------
DROP TABLE IF EXISTS `farm_fertilizer`;
CREATE TABLE `farm_fertilizer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) unsigned NOT NULL,
  `num` decimal(10,2) unsigned NOT NULL COMMENT '领取的化肥数量',
  `dateTime` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_time_index` (`userId`,`dateTime`)
) ENGINE=MyISAM AUTO_INCREMENT=199 DEFAULT CHARSET=utf8 COMMENT='用户领取化肥表';

-- ----------------------------
-- Records of farm_fertilizer
-- ----------------------------
INSERT INTO `farm_fertilizer` VALUES ('4', '3', '0.50', '1490153391');
INSERT INTO `farm_fertilizer` VALUES ('5', '5', '15.00', '1490167022');
INSERT INTO `farm_fertilizer` VALUES ('6', '5', '1.40', '1490237108');
INSERT INTO `farm_fertilizer` VALUES ('7', '3', '7.12', '1490263194');
INSERT INTO `farm_fertilizer` VALUES ('8', '5', '1.61', '1490318766');
INSERT INTO `farm_fertilizer` VALUES ('9', '5', '1.66', '1490612929');
INSERT INTO `farm_fertilizer` VALUES ('10', '4', '3.40', '1490682384');
INSERT INTO `farm_fertilizer` VALUES ('11', '4', '0.00', '1490750883');
INSERT INTO `farm_fertilizer` VALUES ('12', '5', '2.16', '1490775766');
INSERT INTO `farm_fertilizer` VALUES ('13', '5', '0.08', '1490839876');
INSERT INTO `farm_fertilizer` VALUES ('14', '4', '0.00', '1490844525');
INSERT INTO `farm_fertilizer` VALUES ('15', '6', '15.00', '1490859449');
INSERT INTO `farm_fertilizer` VALUES ('16', '3', '7.12', '1490862882');
INSERT INTO `farm_fertilizer` VALUES ('17', '5', '14.96', '1490925504');
INSERT INTO `farm_fertilizer` VALUES ('18', '6', '16.50', '1490927342');
INSERT INTO `farm_fertilizer` VALUES ('19', '3', '7.12', '1490930731');
INSERT INTO `farm_fertilizer` VALUES ('20', '7', '15.00', '1490931578');
INSERT INTO `farm_fertilizer` VALUES ('21', '4', '0.00', '1490944457');
INSERT INTO `farm_fertilizer` VALUES ('22', '9', '18.00', '1490946297');
INSERT INTO `farm_fertilizer` VALUES ('23', '10', '18.00', '1490946566');
INSERT INTO `farm_fertilizer` VALUES ('24', '11', '18.00', '1490953774');
INSERT INTO `farm_fertilizer` VALUES ('25', '12', '18.00', '1490954011');
INSERT INTO `farm_fertilizer` VALUES ('26', '13', '18.00', '1490954452');
INSERT INTO `farm_fertilizer` VALUES ('27', '14', '1272.00', '1490955787');
INSERT INTO `farm_fertilizer` VALUES ('28', '15', '18.00', '1490956092');
INSERT INTO `farm_fertilizer` VALUES ('29', '5', '8.05', '1491009474');
INSERT INTO `farm_fertilizer` VALUES ('30', '8', '78.00', '1491009589');
INSERT INTO `farm_fertilizer` VALUES ('31', '15', '0.00', '1491011353');
INSERT INTO `farm_fertilizer` VALUES ('32', '16', '18.00', '1491011453');
INSERT INTO `farm_fertilizer` VALUES ('33', '7', '6.54', '1491012067');
INSERT INTO `farm_fertilizer` VALUES ('34', '14', '0.00', '1491014677');
INSERT INTO `farm_fertilizer` VALUES ('35', '19', '600.00', '1491015223');
INSERT INTO `farm_fertilizer` VALUES ('36', '13', '0.00', '1491016585');
INSERT INTO `farm_fertilizer` VALUES ('37', '12', '0.00', '1491016683');
INSERT INTO `farm_fertilizer` VALUES ('38', '11', '0.00', '1491016784');
INSERT INTO `farm_fertilizer` VALUES ('39', '10', '0.00', '1491016879');
INSERT INTO `farm_fertilizer` VALUES ('40', '6', '82.80', '1491031280');
INSERT INTO `farm_fertilizer` VALUES ('41', '22', '0.00', '1491040592');
INSERT INTO `farm_fertilizer` VALUES ('42', '6', '27.62', '1491297343');
INSERT INTO `farm_fertilizer` VALUES ('43', '7', '14.19', '1491356035');
INSERT INTO `farm_fertilizer` VALUES ('44', '6', '27.02', '1491356039');
INSERT INTO `farm_fertilizer` VALUES ('45', '21', '18.00', '1491357327');
INSERT INTO `farm_fertilizer` VALUES ('46', '19', '0.00', '1491358803');
INSERT INTO `farm_fertilizer` VALUES ('47', '16', '1800.00', '1491360650');
INSERT INTO `farm_fertilizer` VALUES ('48', '5', '8.58', '1491361663');
INSERT INTO `farm_fertilizer` VALUES ('49', '36', '5000.00', '1491363579');
INSERT INTO `farm_fertilizer` VALUES ('50', '42', '620.00', '1491371357');
INSERT INTO `farm_fertilizer` VALUES ('51', '22', '730.00', '1491372999');
INSERT INTO `farm_fertilizer` VALUES ('52', '14', '0.00', '1491376930');
INSERT INTO `farm_fertilizer` VALUES ('53', '13', '0.00', '1491380269');
INSERT INTO `farm_fertilizer` VALUES ('54', '12', '0.00', '1491380448');
INSERT INTO `farm_fertilizer` VALUES ('55', '24', '30.00', '1491380854');
INSERT INTO `farm_fertilizer` VALUES ('56', '7', '497.02', '1491440874');
INSERT INTO `farm_fertilizer` VALUES ('57', '13', '0.00', '1491440955');
INSERT INTO `farm_fertilizer` VALUES ('58', '5', '630.00', '1491441993');
INSERT INTO `farm_fertilizer` VALUES ('59', '36', '3625.00', '1491442662');
INSERT INTO `farm_fertilizer` VALUES ('60', '24', '0.00', '1491442836');
INSERT INTO `farm_fertilizer` VALUES ('61', '48', '30.00', '1491443313');
INSERT INTO `farm_fertilizer` VALUES ('62', '44', '0.00', '1491444429');
INSERT INTO `farm_fertilizer` VALUES ('63', '25', '30.00', '1491445626');
INSERT INTO `farm_fertilizer` VALUES ('64', '51', '30.00', '1491446680');
INSERT INTO `farm_fertilizer` VALUES ('65', '52', '30.00', '1491446765');
INSERT INTO `farm_fertilizer` VALUES ('66', '10', '0.00', '1491449733');
INSERT INTO `farm_fertilizer` VALUES ('67', '6', '32.34', '1491450743');
INSERT INTO `farm_fertilizer` VALUES ('68', '53', '30.00', '1491466289');
INSERT INTO `farm_fertilizer` VALUES ('69', '57', '30.00', '1491468648');
INSERT INTO `farm_fertilizer` VALUES ('70', '48', '0.00', '1491527405');
INSERT INTO `farm_fertilizer` VALUES ('71', '7', '438.62', '1491529012');
INSERT INTO `farm_fertilizer` VALUES ('72', '58', '30.00', '1491529206');
INSERT INTO `farm_fertilizer` VALUES ('73', '27', '30.00', '1491529426');
INSERT INTO `farm_fertilizer` VALUES ('74', '21', '900.00', '1491529511');
INSERT INTO `farm_fertilizer` VALUES ('75', '12', '0.00', '1491529701');
INSERT INTO `farm_fertilizer` VALUES ('76', '42', '530.00', '1491531529');
INSERT INTO `farm_fertilizer` VALUES ('77', '14', '0.00', '1491532718');
INSERT INTO `farm_fertilizer` VALUES ('78', '29', '30.00', '1491535045');
INSERT INTO `farm_fertilizer` VALUES ('79', '5', '645.76', '1491543946');
INSERT INTO `farm_fertilizer` VALUES ('80', '24', '940.90', '1491544130');
INSERT INTO `farm_fertilizer` VALUES ('81', '36', '3625.00', '1491544536');
INSERT INTO `farm_fertilizer` VALUES ('82', '63', '27.00', '1491549227');
INSERT INTO `farm_fertilizer` VALUES ('83', '7', '286.51', '1491787788');
INSERT INTO `farm_fertilizer` VALUES ('84', '66', '30.00', '1491810558');
INSERT INTO `farm_fertilizer` VALUES ('85', '67', '330.00', '1491814171');
INSERT INTO `farm_fertilizer` VALUES ('86', '68', '30.00', '1491815473');
INSERT INTO `farm_fertilizer` VALUES ('87', '69', '3.00', '1491816319');
INSERT INTO `farm_fertilizer` VALUES ('88', '70', '0.30', '1491816954');
INSERT INTO `farm_fertilizer` VALUES ('89', '71', '1.05', '1491817300');
INSERT INTO `farm_fertilizer` VALUES ('90', '71', '0.00', '1491864027');
INSERT INTO `farm_fertilizer` VALUES ('91', '67', '0.41', '1491871594');
INSERT INTO `farm_fertilizer` VALUES ('92', '72', '1.05', '1491874040');
INSERT INTO `farm_fertilizer` VALUES ('93', '75', '0.00', '1491876414');
INSERT INTO `farm_fertilizer` VALUES ('94', '74', '1.09', '1491876839');
INSERT INTO `farm_fertilizer` VALUES ('95', '71', '1.08', '1491980804');
INSERT INTO `farm_fertilizer` VALUES ('96', '67', '14.77', '1491988067');
INSERT INTO `farm_fertilizer` VALUES ('97', '71', '1.08', '1492039897');
INSERT INTO `farm_fertilizer` VALUES ('98', '74', '1.09', '1492047631');
INSERT INTO `farm_fertilizer` VALUES ('99', '77', '0.00', '1492048191');
INSERT INTO `farm_fertilizer` VALUES ('100', '78', '31.50', '1492049415');
INSERT INTO `farm_fertilizer` VALUES ('101', '72', '1.05', '1492050227');
INSERT INTO `farm_fertilizer` VALUES ('102', '79', '31.50', '1492054604');
INSERT INTO `farm_fertilizer` VALUES ('103', '67', '16.16', '1492084990');
INSERT INTO `farm_fertilizer` VALUES ('104', '79', '32.26', '1492133363');
INSERT INTO `farm_fertilizer` VALUES ('105', '71', '2.13', '1492342660');
INSERT INTO `farm_fertilizer` VALUES ('106', '79', '33.13', '1492394205');
INSERT INTO `farm_fertilizer` VALUES ('107', '67', '17.62', '1492432163');
INSERT INTO `farm_fertilizer` VALUES ('108', '71', '2.14', '1492484317');
INSERT INTO `farm_fertilizer` VALUES ('109', '80', '0.00', '1492486897');
INSERT INTO `farm_fertilizer` VALUES ('110', '81', '0.00', '1492488323');
INSERT INTO `farm_fertilizer` VALUES ('111', '82', '0.00', '1492501771');
INSERT INTO `farm_fertilizer` VALUES ('112', '79', '34.34', '1492502442');
INSERT INTO `farm_fertilizer` VALUES ('113', '81', '1.05', '1492561811');
INSERT INTO `farm_fertilizer` VALUES ('114', '83', '0.00', '1492564010');
INSERT INTO `farm_fertilizer` VALUES ('115', '79', '34.34', '1492583934');
INSERT INTO `farm_fertilizer` VALUES ('116', '79', '34.34', '1492659432');
INSERT INTO `farm_fertilizer` VALUES ('117', '81', '1.06', '1492668603');
INSERT INTO `farm_fertilizer` VALUES ('118', '84', '0.00', '1492670584');
INSERT INTO `farm_fertilizer` VALUES ('119', '85', '481.50', '1492673471');
INSERT INTO `farm_fertilizer` VALUES ('120', '81', '4.16', '1492736092');
INSERT INTO `farm_fertilizer` VALUES ('121', '84', '4.05', '1492738116');
INSERT INTO `farm_fertilizer` VALUES ('122', '85', '507.26', '1492738378');
INSERT INTO `farm_fertilizer` VALUES ('123', '81', '4.22', '1492826305');
INSERT INTO `farm_fertilizer` VALUES ('124', '81', '4.27', '1492923849');
INSERT INTO `farm_fertilizer` VALUES ('125', '90', '0.00', '1492932517');
INSERT INTO `farm_fertilizer` VALUES ('126', '90', '4.05', '1492989440');
INSERT INTO `farm_fertilizer` VALUES ('127', '81', '4.27', '1492989530');
INSERT INTO `farm_fertilizer` VALUES ('128', '79', '76.05', '1492996339');
INSERT INTO `farm_fertilizer` VALUES ('129', '90', '4.10', '1493082048');
INSERT INTO `farm_fertilizer` VALUES ('130', '81', '4.33', '1493103673');
INSERT INTO `farm_fertilizer` VALUES ('131', '79', '532.35', '1493285418');
INSERT INTO `farm_fertilizer` VALUES ('132', '90', '4.16', '1493306413');
INSERT INTO `farm_fertilizer` VALUES ('133', '90', '4.22', '1493442208');
INSERT INTO `farm_fertilizer` VALUES ('134', '90', '4.27', '1493563953');
INSERT INTO `farm_fertilizer` VALUES ('135', '90', '4.33', '1493605234');
INSERT INTO `farm_fertilizer` VALUES ('136', '90', '4.39', '1493687262');
INSERT INTO `farm_fertilizer` VALUES ('137', '81', '4.39', '1493687337');
INSERT INTO `farm_fertilizer` VALUES ('138', '91', '0.00', '1493693914');
INSERT INTO `farm_fertilizer` VALUES ('139', '92', '0.00', '1493699763');
INSERT INTO `farm_fertilizer` VALUES ('140', '94', '0.00', '1493706216');
INSERT INTO `farm_fertilizer` VALUES ('141', '95', '0.00', '1493716253');
INSERT INTO `farm_fertilizer` VALUES ('142', '91', '4.05', '1493763169');
INSERT INTO `farm_fertilizer` VALUES ('143', '92', '4.05', '1493766419');
INSERT INTO `farm_fertilizer` VALUES ('144', '81', '0.00', '1493772077');
INSERT INTO `farm_fertilizer` VALUES ('145', '97', '0.00', '1493775625');
INSERT INTO `farm_fertilizer` VALUES ('146', '98', '0.00', '1493777353');
INSERT INTO `farm_fertilizer` VALUES ('147', '90', '5.14', '1493780797');
INSERT INTO `farm_fertilizer` VALUES ('148', '99', '0.00', '1493783228');
INSERT INTO `farm_fertilizer` VALUES ('149', '95', '4.05', '1493800782');
INSERT INTO `farm_fertilizer` VALUES ('150', '94', '4.05', '1493805334');
INSERT INTO `farm_fertilizer` VALUES ('151', '94', '4.10', '1493847711');
INSERT INTO `farm_fertilizer` VALUES ('152', '97', '4.05', '1493849482');
INSERT INTO `farm_fertilizer` VALUES ('153', '91', '4.10', '1493849644');
INSERT INTO `farm_fertilizer` VALUES ('154', '99', '4.05', '1493849723');
INSERT INTO `farm_fertilizer` VALUES ('155', '92', '4.10', '1493851753');
INSERT INTO `farm_fertilizer` VALUES ('156', '84', '4.10', '1493860572');
INSERT INTO `farm_fertilizer` VALUES ('157', '81', '0.00', '1493860644');
INSERT INTO `farm_fertilizer` VALUES ('158', '100', '0.00', '1493905752');
INSERT INTO `farm_fertilizer` VALUES ('159', '94', '4.16', '1493936581');
INSERT INTO `farm_fertilizer` VALUES ('160', '90', '18.41', '1493938197');
INSERT INTO `farm_fertilizer` VALUES ('161', '95', '4.10', '1493938637');
INSERT INTO `farm_fertilizer` VALUES ('162', '92', '4.16', '1493940094');
INSERT INTO `farm_fertilizer` VALUES ('163', '100', '4.05', '1493940352');
INSERT INTO `farm_fertilizer` VALUES ('164', '99', '4.10', '1493941441');
INSERT INTO `farm_fertilizer` VALUES ('165', '91', '4.16', '1493943175');
INSERT INTO `farm_fertilizer` VALUES ('166', '97', '4.10', '1493943278');
INSERT INTO `farm_fertilizer` VALUES ('167', '81', '1487.45', '1493955665');
INSERT INTO `farm_fertilizer` VALUES ('168', '94', '7.25', '1494025976');
INSERT INTO `farm_fertilizer` VALUES ('169', '100', '7.05', '1494030338');
INSERT INTO `farm_fertilizer` VALUES ('170', '97', '7.15', '1494030390');
INSERT INTO `farm_fertilizer` VALUES ('171', '81', '3751.18', '1494034002');
INSERT INTO `farm_fertilizer` VALUES ('172', '92', '7.26', '1494034075');
INSERT INTO `farm_fertilizer` VALUES ('173', '90', '144.99', '1494034564');
INSERT INTO `farm_fertilizer` VALUES ('174', '91', '5.36', '1494111273');
INSERT INTO `farm_fertilizer` VALUES ('175', '97', '5.08', '1494111434');
INSERT INTO `farm_fertilizer` VALUES ('176', '90', '126.39', '1494113573');
INSERT INTO `farm_fertilizer` VALUES ('177', '92', '5.28', '1494114378');
INSERT INTO `farm_fertilizer` VALUES ('178', '99', '4.96', '1494114651');
INSERT INTO `farm_fertilizer` VALUES ('179', '81', '770.18', '1494115653');
INSERT INTO `farm_fertilizer` VALUES ('180', '94', '5.14', '1494123617');
INSERT INTO `farm_fertilizer` VALUES ('181', '100', '5.01', '1494149428');
INSERT INTO `farm_fertilizer` VALUES ('182', '91', '6.29', '1494196095');
INSERT INTO `farm_fertilizer` VALUES ('183', '97', '5.16', '1494196183');
INSERT INTO `farm_fertilizer` VALUES ('184', '94', '5.23', '1494198676');
INSERT INTO `farm_fertilizer` VALUES ('185', '92', '5.36', '1494201821');
INSERT INTO `farm_fertilizer` VALUES ('186', '100', '5.09', '1494202486');
INSERT INTO `farm_fertilizer` VALUES ('187', '81', '851.48', '1494209481');
INSERT INTO `farm_fertilizer` VALUES ('188', '99', '5.04', '1494211244');
INSERT INTO `farm_fertilizer` VALUES ('189', '90', '58.45', '1494285725');
INSERT INTO `farm_fertilizer` VALUES ('190', '101', '0.00', '1494285730');
INSERT INTO `farm_fertilizer` VALUES ('191', '81', '849.77', '1494285764');
INSERT INTO `farm_fertilizer` VALUES ('192', '91', '6.39', '1494286370');
INSERT INTO `farm_fertilizer` VALUES ('193', '92', '5.45', '1494286389');
INSERT INTO `farm_fertilizer` VALUES ('194', '97', '5.24', '1494286431');
INSERT INTO `farm_fertilizer` VALUES ('195', '94', '5.31', '1494286616');
INSERT INTO `farm_fertilizer` VALUES ('196', '100', '5.17', '1494289888');
INSERT INTO `farm_fertilizer` VALUES ('197', '84', '4.96', '1494293555');
INSERT INTO `farm_fertilizer` VALUES ('198', '102', '0.00', '1494293647');

-- ----------------------------
-- Table structure for `farm_login_log`
-- ----------------------------
DROP TABLE IF EXISTS `farm_login_log`;
CREATE TABLE `farm_login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(10) unsigned DEFAULT NULL COMMENT '用户ID',
  `username` char(16) DEFAULT NULL COMMENT '用户名',
  `loginIp` varchar(20) DEFAULT '0' COMMENT '最后登录IP',
  `loginTime` int(10) unsigned DEFAULT '0' COMMENT '时间',
  `roles` varchar(50) DEFAULT '0' COMMENT '角色',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8 COMMENT='管理员登录';

-- ----------------------------
-- Records of farm_login_log
-- ----------------------------
INSERT INTO `farm_login_log` VALUES ('9', '1', 'admin', '0.0.0.0', '1489027203', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('10', '1', 'admin', '0.0.0.0', '1489027239', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('11', '1', 'admin', '171.8.135.143', '1489644560', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('12', '1', 'admin', '171.8.135.143', '1489649369', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('13', '1', 'admin', '171.8.135.143', '1489654165', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('14', '1', 'admin', '123.149.215.66', '1489712049', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('15', '1', 'admin', '123.149.215.66', '1489731415', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('16', '1', 'admin', '123.149.215.66', '1489740681', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('17', '1', 'admin', '123.149.209.55', '1489917679', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('18', '1', 'admin', '123.149.213.181', '1489973446', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('19', '1', 'admin', '123.149.213.181', '1490013109', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('20', '1', 'admin', '123.149.212.16', '1490061105', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('21', '1', 'admin', '123.149.212.16', '1490062534', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('22', '1', 'admin', '123.149.212.16', '1490074493', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('23', '1', 'admin', '123.149.212.16', '1490077972', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('24', '1', 'admin', '123.149.214.203', '1490154356', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('25', '1', 'admin', '123.149.214.203', '1490160465', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('26', '1', 'admin', '123.149.214.203', '1490160923', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('27', '1', 'admin', '123.149.214.203', '1490166345', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('28', '1', 'admin', '123.149.214.203', '1490170297', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('29', '1', 'admin', '123.149.214.203', '1490172468', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('30', '1', 'admin', '123.149.214.203', '1490183983', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('31', '1', 'admin', '123.149.213.73', '1490231207', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('32', '1', 'admin', '123.149.213.73', '1490234117', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('33', '1', 'admin', '123.149.213.73', '1490237696', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('34', '1', 'admin', '123.149.213.73', '1490253997', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('35', '1', 'admin', '123.149.213.211', '1490316204', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('36', '1', 'admin', '123.149.213.211', '1490325178', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('37', '1', 'admin', '123.149.213.211', '1490333853', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('38', '1', 'admin', '123.149.213.211', '1490341807', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('39', '1', 'admin', '123.149.213.211', '1490346396', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('40', '1', 'admin', '123.149.210.248', '1490577079', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('41', '1', 'admin', '123.149.210.248', '1490595562', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('42', '1', 'admin', '123.149.210.248', '1490600879', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('43', '1', 'admin', '123.149.210.248', '1490607632', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('44', '1', 'admin', '123.149.210.248', '1490607744', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('45', '1', 'admin', '123.149.210.46', '1490665520', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('46', '1', 'admin', '123.149.210.46', '1490673182', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('47', '1', 'admin', '123.149.210.46', '1490679128', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('48', '1', 'admin', '123.149.210.46', '1490681656', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('49', '1', 'admin', '123.149.215.8', '1490750220', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('50', '1', 'admin', '123.149.215.8', '1490750688', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('51', '1', 'admin', '123.149.210.123', '1490756798', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('52', '1', 'admin', '123.149.210.123', '1490757059', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('53', '1', 'admin', '123.149.210.123', '1490757767', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('54', '2', 'user01', '123.149.210.123', '1490757843', '普通管理员');
INSERT INTO `farm_login_log` VALUES ('55', '1', 'admin', '123.149.210.123', '1490759062', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('56', '1', 'admin', '123.149.210.123', '1490767641', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('57', '1', 'admin', '123.149.210.123', '1490768010', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('58', '1', 'admin', '123.149.210.123', '1490776234', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('59', '1', 'admin', '123.149.210.123', '1490777112', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('60', '1', 'admin', '123.149.212.170', '1490835875', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('61', '1', 'admin', '123.149.212.170', '1490837151', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('62', '1', 'admin', '123.149.212.170', '1490840449', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('63', '1', 'admin', '123.149.212.170', '1490842323', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('64', '1', 'admin', '123.149.212.170', '1490843173', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('65', '1', 'admin', '123.149.212.170', '1490846727', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('66', '1', 'admin', '123.149.212.170', '1490852450', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('67', '1', 'admin', '123.149.212.170', '1490855035', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('68', '1', 'admin', '123.149.212.170', '1490858591', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('69', '1', 'admin', '123.149.212.170', '1490867118', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('70', '1', 'admin', '123.149.211.236', '1490921428', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('71', '1', 'admin', '123.149.211.236', '1490925751', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('72', '1', 'admin', '123.149.211.236', '1490927639', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('73', '1', 'admin', '123.149.211.236', '1490930399', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('74', '1', 'admin', '123.149.211.236', '1490930438', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('75', '1', 'admin', '123.149.211.236', '1490938355', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('76', '1', 'admin', '123.149.211.236', '1490942582', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('77', '1', 'admin', '123.149.211.236', '1490949740', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('78', '1', 'admin', '123.149.208.27', '1491009507', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('79', '1', 'admin', '123.149.208.27', '1491011600', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('80', '1', 'admin', '123.149.208.27', '1491011643', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('81', '1', 'admin', '123.149.208.27', '1491030099', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('82', '1', 'admin', '123.149.215.220', '1491353687', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('83', '1', 'admin', '123.149.215.220', '1491354683', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('84', '1', 'admin', '123.149.215.220', '1491361686', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('85', '1', 'admin', '123.149.215.220', '1491364504', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('86', '1', 'admin', '123.149.215.220', '1491370683', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('87', '1', 'admin', '123.149.215.220', '1491370697', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('88', '1', 'admin', '123.149.215.220', '1491370907', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('89', '1', 'admin', '123.149.215.220', '1491378317', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('90', '1', 'admin', '123.149.215.220', '1491383259', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('91', '1', 'admin', '123.149.215.220', '1491392060', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('92', '1', 'admin', '123.149.214.102', '1491441022', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('93', '1', 'admin', '123.149.214.102', '1491441813', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('94', '1', 'admin', '123.149.214.102', '1491441932', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('95', '1', 'admin', '123.149.214.102', '1491442196', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('96', '1', 'admin', '123.149.214.102', '1491445593', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('97', '1', 'admin', '123.149.214.102', '1491448946', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('98', '1', 'admin', '123.149.214.102', '1491461615', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('99', '1', 'admin', '123.149.214.102', '1491465401', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('100', '1', 'admin', '123.149.214.102', '1491466224', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('101', '1', 'admin', '123.149.214.102', '1491466371', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('102', '1', 'admin', '123.149.214.72', '1491527298', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('103', '1', 'admin', '123.149.214.72', '1491527944', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('104', '1', 'admin', '123.149.214.72', '1491545574', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('105', '1', 'admin', '123.149.214.72', '1491548944', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('106', '1', 'admin', '123.149.214.72', '1491555680', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('107', '1', 'admin', '171.8.134.144', '1491640486', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('108', '1', 'admin', '123.149.209.118', '1491786291', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('109', '1', 'admin', '123.149.209.118', '1491786647', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('110', '1', 'admin', '221.15.196.22', '1491796612', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('111', '1', 'admin', '123.149.209.118', '1491803073', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('112', '1', 'admin', '183.204.49.193', '1491808905', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('113', '1', 'admin', '221.15.196.22', '1491809528', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('114', '1', 'admin', '183.204.49.193', '1491809972', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('115', '1', 'admin', '183.204.49.193', '1491810276', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('116', '1', 'admin', '183.204.49.193', '1491812515', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('117', '1', 'admin', '123.149.209.118', '1491815036', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('118', '1', 'admin', '123.149.209.118', '1491815346', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('119', '1', 'admin', '1.194.166.56', '1491821365', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('120', '1', 'admin', '1.194.166.56', '1491864719', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('121', '1', 'admin', '222.137.107.66', '1491872574', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('122', '1', 'admin', '123.149.209.15', '1491874596', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('123', '1', 'admin', '123.149.209.15', '1491876221', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('124', '1', 'admin', '123.149.209.15', '1491876700', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('125', '1', 'admin', '123.149.209.15', '1491882017', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('126', '1', 'admin', '123.149.209.15', '1491889905', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('127', '1', 'admin', '222.137.107.66', '1491891886', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('128', '1', 'admin', '222.137.107.66', '1491896918', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('129', '1', 'admin', '171.8.134.152', '1491965837', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('130', '1', 'admin', '171.8.134.152', '1491977370', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('131', '1', 'admin', '123.149.212.139', '1492046404', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('132', '1', 'admin', '123.149.212.139', '1492048944', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('133', '1', 'admin', '123.149.212.139', '1492053544', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('134', '1', 'admin', '123.149.212.139', '1492075171', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('135', '1', 'admin', '171.8.135.36', '1492149459', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('136', '1', 'admin', '171.8.135.36', '1492160072', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('137', '1', 'admin', '171.8.135.36', '1492160158', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('138', '1', 'admin', '171.8.135.36', '1492161761', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('139', '1', 'admin', '123.149.211.235', '1492398260', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('140', '1', 'admin', '183.204.49.55', '1492485448', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('141', '1', 'admin', '219.157.241.99', '1492486221', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('142', '1', 'admin', '219.157.241.99', '1492501666', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('143', '1', 'admin', '219.157.241.99', '1492508327', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('144', '1', 'admin', '219.157.241.99', '1492508339', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('145', '1', 'admin', '125.41.131.200', '1492563481', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('146', '1', 'admin', '221.15.197.9', '1492667282', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('147', '1', 'admin', '123.149.209.94', '1492668029', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('148', '1', 'admin', '183.204.49.140', '1492668512', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('149', '1', 'admin', '123.149.209.94', '1492671560', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('150', '1', 'admin', '123.149.209.94', '1492672566', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('151', '1', 'admin', '61.163.131.170', '1492738265', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('152', '1', 'admin', '171.8.135.119', '1492738277', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('153', '1', 'admin', '171.8.135.119', '1492738815', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('154', '1', 'admin', '171.8.135.119', '1492746576', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('155', '1', 'admin', '171.8.135.119', '1492753656', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('156', '1', 'admin', '219.157.246.7', '1492843860', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('157', '1', 'admin', '223.90.163.106', '1492910819', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('158', '1', 'admin', '223.90.163.106', '1492932354', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('159', '1', 'admin', '221.15.192.210', '1493005962', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('160', '1', 'admin', '221.15.192.210', '1493018750', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('161', '1', 'admin', '221.15.192.210', '1493031108', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('162', '1', 'admin', '221.15.192.210', '1493105916', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('163', '1', 'admin', '223.90.163.215', '1493690434', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('164', '1', 'admin', '106.39.190.207', '1493702509', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('165', '1', 'admin', '222.137.107.216', '1493703375', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('166', '1', 'admin', '123.149.210.84', '1493708886', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('167', '1', 'admin', '222.137.107.216', '1493714485', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('168', '1', 'admin', '106.42.26.70', '1493715502', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('169', '1', 'admin', '106.42.26.70', '1493716004', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('170', '1', 'admin', '223.90.163.215', '1493729803', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('171', '1', 'admin', '223.90.163.215', '1493774808', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('172', '1', 'admin', '223.90.163.215', '1493782961', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('173', '1', 'admin', '223.90.162.209', '1493790038', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('174', '1', 'admin', '125.41.135.140', '1493859397', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('175', '1', 'admin', '123.149.211.14', '1493861450', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('176', '1', 'admin', '223.90.162.209', '1493862356', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('177', '1', 'admin', '223.90.162.209', '1493905291', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('178', '1', 'admin', '221.15.199.107', '1493965472', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('179', '1', 'admin', '221.15.199.107', '1493965567', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('180', '1', 'admin', '171.8.134.105', '1493970379', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('181', '1', 'admin', '223.90.163.0', '1494034707', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('182', '1', 'admin', '223.90.163.0', '1494079482', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('183', '1', 'admin', '223.90.163.0', '1494114160', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('184', '1', 'admin', '222.137.105.33', '1494206173', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('185', '1', 'admin', '123.149.214.196', '1494207899', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('186', '1', 'admin', '223.90.162.237', '1494218235', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('187', '1', 'admin', '123.149.214.196', '1494234308', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('188', '1', 'admin', '223.90.162.237', '1494286336', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('189', '1', 'admin', '221.15.199.69', '1494292199', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('190', '1', 'admin', '123.149.208.245', '1494292717', '超级管理员');
INSERT INTO `farm_login_log` VALUES ('191', '1', 'admin', '123.149.211.89', '1494300587', '超级管理员');

-- ----------------------------
-- Table structure for `farm_mail`
-- ----------------------------
DROP TABLE IF EXISTS `farm_mail`;
CREATE TABLE `farm_mail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `userId` int(11) NOT NULL,
  `content` text NOT NULL,
  `pic` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `fruitNum` varchar(255) NOT NULL COMMENT '需要扣掉的果实数量',
  `phone` varchar(255) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0未处理1已处理',
  `createTime` int(11) NOT NULL,
  `updateTime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='站内信';

-- ----------------------------
-- Records of farm_mail
-- ----------------------------
INSERT INTO `farm_mail` VALUES ('16', '测试', '6', '放寒假', '20170331/58de2d5e4d8f4.jpg|20170331/58de2d5e4e142.jpg|20170331/58de2d5e4f070.jpg|', '10', '13663002569', '1', '1490955614', '1491362703');
INSERT INTO `farm_mail` VALUES ('17', '会', '6', '可以可以', '', '10', '15236478963', '1', '1491037962', '1491362712');
INSERT INTO `farm_mail` VALUES ('18', '好好说', '6', '体会', '', '10', '15236985214', '1', '1491038056', '1491362719');
INSERT INTO `farm_mail` VALUES ('19', '阿鲁', '6', '工作呢', '20170401/58df70d12ea48.jpg|', '10', '15236925814', '1', '1491038417', '1491362371');
INSERT INTO `farm_mail` VALUES ('20', '郑州', '6', '待机时间', '', '10', '13663', '1', '1491354787', '1491354787');
INSERT INTO `farm_mail` VALUES ('21', 'gg', '6', 'vsfg', '', '10', '15236985632', '1', '1491373810', '1491373834');
INSERT INTO `farm_mail` VALUES ('22', 'fnf', '6', 'cbdg', '', '10', '15623654789', '0', '1491373887', '1491373887');
INSERT INTO `farm_mail` VALUES ('23', 'dkcj', '6', 'dncn', '20170405/58e48f7c75996.jpg|', '10', '15863921456', '0', '1491373948', '1491373948');
INSERT INTO `farm_mail` VALUES ('24', '你好', '7', '高尔夫球场整顿催生的商机：打高球将像唱K般便捷便宜\n澎湃新闻04-0513:34\n科技能改变生活，科技更能改变运动。近日，2017中国国际高尔夫博览会在上海召开，会上除了传统的球具、衣帽等品牌，一种被称为高尔夫模拟器的装备分外惹眼。所谓高尔夫模拟器，就是利用计算机图形图像处理技术将高尔夫球场资料装入系统存储器中，通过大屏幕投影将球场景观逼真地投射在击球者面前的耐撞击屏幕上，让打球者有一种身临其境的感受。以模拟器品牌如歌提供的数据来看，2013年全国只有9家球馆，2014年增加到49家，2015年是98家，2016年已经达到200多家……同样，国内品牌衡泰信总经理王继军也透露，模拟器销量过去几年基本处于成倍上升趋势。为什么模拟器市场为何能成为国内玩家的新宠儿？\n\n观众在室内体验高尔夫模拟器。东方IC 资料图整顿违规球场，模拟器商机到来高尔夫模拟器并非今日才有，其诞生之日在欧美高尔夫发达国家可以追溯到上世纪70年代。上世纪90年代，中国也引入了这套装备，但发展算不上顺畅，“这经历了一个市场检验和淘汰的过程，模拟器市场从大伙儿扎堆走向了几家优质品牌占据绝大部分份额的局面。”国内模拟器品牌如歌市场总监张春开如是说。模拟器的火爆得益于政府对高尔夫市场的有效监管。《朝向白皮书——中国高尔夫行业报告》显示，在整顿违规高尔夫球场之后，国内球场数量从原先的650余家减少到460余家，但这却为中国高尔夫良性发展树立了标杆。高尔夫营销机构CEO杨坤就坦言：“整顿违规球场有利于行业的规范化，对于高尔夫运动和产业的未来发展其实是一个很大的助力。”经历了行业规范后，当下国内的高尔夫赛事尤其是青少年和业余比赛前所未有的火爆。以上海地区为例，全国最大的业余赛事上海大奖赛，2017年参赛选手达到7000人，场次规模高达55场，历时7个月，辐射高尔夫人群达20万人，并且计划在北京、四川、广东举办推广赛。同样是上海地区的2017上海市青少年高尔夫巡回赛，首站比赛报名人数就较去年增加了40%……在高尔夫人口日益增加，青少年训练需求提升的背景下，高尔夫模拟器就是练球打球性价比最高的选择。资深体育记者、高尔夫评论员王游宇就表示，“中国高尔夫运动还处在一个普及的过程，但人群正在逐渐壮大，尤其是青少年在人群中的比例逐年放大，要学球、练球，模拟器提供了一个很好的平台。”梁文冲的前经纪人彭焱焱也持相似观点，他提到当下模拟器的走热占据了“天时地利人和”。“一方面人群在扩大，另一方面球场不会再增加，要满足需求，模拟器成为了一个重要的载体，而且在模拟器上练球成本要比下场低了不少。”通常，三四个人打18洞模拟器，平均每人每小时大概一百元，而在真实的球场内，一场球下来的开销大致在一千元左右。\n在韩国练球就和唱K一样模拟器在国内找到了发展契机，那么模拟器和真实场地的训练比赛有什么不同？“你都需要拿着球杆去击球，技术上要求是一样的，但模拟器因为放置在室内，没有风向、场地凹凸不平的干扰，成绩通常会比真实下场要好一些，一般下场打出80多杆，在模拟器上可以打70多杆……”彭焱焱就表示，模拟器和真实差别并不大。在成本上他也做了一番解释，“特别是在上海、北京这样的城市，下场打球你花费的不仅仅是更多的金钱，还有时间成本，（球场都比较偏远）来去一趟一天时间就搭进去了。而模拟器处于室内，有灯光照明，可以24小时使用，不受早晚或者天气影响。”放眼世界，欧美地区由于高尔夫球场数量较多，模拟器尚未大行其道，但在青少年培训方面，一项数据显示，美国有25%的人是通过模拟器学会打球的。而在韩国，模拟器已经成为高尔夫运动及市场上最为重要的一股力量。数据表明，韩国超过5000万人口中有15%的人打高尔夫，但韩国的球场只有400多家，供求不平衡导致打球费用昂贵，50%以上的韩国人都利用或者主要利用模拟器练球。“在韩国通过模拟器在室内练球就像唱k一样普遍，不完全统计，有接近10000多家球馆。”王游宇说。\n12.5%参赛者通过模拟器选拔韩国高尔夫球场数量有限，需要通过模拟器来消化越来越多的高尔夫人口，尽管情况远不如韩国那么夸张，但中国目前也存在这样的刚需。今年全球著名的PGA青少年高尔夫联赛登陆中国，其CEO鲍勃就深感中美高尔夫的差异化，“在美国我们拥有2500个球场，有3400个球队超过5万人参与这项青少年赛事，但在中国情况可能有些不同，没有那么多的球场来容纳我们的球员。”最终鲍勃选择了国内一家模拟器运营商如歌一起合作赛事，按照他的想法，一些球场资源有限的偏远地区，完全可以通过模拟器选拔球员，到更高一级赛事时再下场对抗。无独有偶，在今年“张连伟杯”国际青少年邀请赛中，160个参赛者中有20个就是通过模拟器线上选拔出来的。对于这种线上、线下联动的比赛模式，彭焱焱认为高尔夫模拟器过去若干年在技术上也有了较大发展。“最早只是通过单一的机器进行练球，但现在已经实现了联网，只要纳入一家模拟器运营商的系统，所有打球的人的适时成绩甚至击球视频都可以同步到网络上，而且现在模拟器厂商已经越来越注重打球时的真实性。除了角度、速度、旋转、距离、轨迹之外，还尽可能还原真实的球场。”按照彭焱焱的说法，厂商也能通过获得各个球场的授权，在模拟器上按照比例还原球场真实的景观与地貌。此间，衡泰信王继军透露，利用雷达扫描还原球场误差仅仅在2厘米，“通常需要利用一家小型飞机或者直升机，通过航拍、雷达扫描的方式收集数据，如果要求低一些，拿到球场的竣工图外加实地拍摄也可以进行还原，误差稍微大一些……”\n国内品牌凭什么击败韩国有意思的是，尽管韩国在模拟器领域具有先发优势，其间也不乏很多韩国品牌想占领中国市场，但都没有达到预期的效果。国内市场当下以如歌、衡泰信、中通等国产品牌领头，看上去韩国模拟器在中国倒遭遇了水土不服。“国内第一台模拟器最早应该是在深圳的阳光大酒店，1996年，我还记得当时一台价格在60万，当年韩国和美国的品牌通过信息不对称在国内高内高价销售，一定程度打乱了市场……事实上，后来很多来到中国的模拟器品牌在韩国本土已经边缘化，把生存的机会寄希望于中国市场。”在衡泰信总经理王继军看来，在国内品牌开始大力发展后，研发能力不强的韩国品牌自然无力为继。事实上，目前国产品牌在模拟器领域的研发已经走到了世界前列。以衡泰信为例，当球距离球洞四码距离以内，模拟器会自动推出真实推杆台，而击球时系统中也加入风力干扰，在模拟器领域这些都属于最前沿的技术。此外，一些业内人士认为高尔夫球爱好者都有所谓的“主场意识”，韩国模拟器模拟的球场都是韩国球场，中国球手并不感冒，更愿意在模拟器上体验自己平时能下到场的国内球场。另一方面，国内品牌在体育产业的大潮中不仅仅盯着商业，更愿意投身到高尔夫运动的普及与推广中。\n中国高尔夫人口有望超越美国？如果说中国模拟器市场瞅准了产业发展的大势，间接享受到了政策的红利，那么在商业模式上，一些厂商也找到了自己最切实可行的落脚点。衡泰信主要以私人用户为主，产品售价从10万左右的入门级到50万左右的豪华级都有；如歌则主推一类19.8万的产品，主要采取“租赁”形式，关键点在于厂商将模拟器免费提供给个体球馆经营者，通过每月收租金的形式逐月回收模拟器的出售费用。个体经营者则在先期投入较小的情况下开始运营，需要支付的仅仅是房租、装修。据业内人士透露，经营状况好的情况下10个月可以收回成本。而目前这些国内主要模拟器品牌在满足娱乐的同时，都立足于培训。“高尔夫运动登陆中国以来，教学市场一直比较混乱，对于教练没有一个通用的评价体系。”按照王继军的说法，借助当下的科技以及大数据，可以做到对一个打球者击球距离、落点的长年跟踪。很显然，国内的模拟器厂商都憋足劲要来抢占这块尚未做大的高尔夫蛋糕，王继军也拿出了体育总局“十三五规划”做为蓝本。“2020年中国高尔夫人口有望达到3000万，其中1/2为青少年，这样一个数字意味着推广模拟器是一个必由之路。”在体育产业领域，高尔夫产业链相对完善，自成体系。以美国为例，每一年的经济影响力达到近700亿美元，提供200万个就业机会以及40亿美元的慈善收入。“十三五”规划专家委员会委员迟福林也预测，2020年我国高尔夫人口有望超越美国，成为世界第一高尔夫大国，而高尔夫基础设施每投入1美元，则上下游产业的带动增值为15美元……”\n查看原文\n体育手机模拟器口袋妖怪虚拟机\n\n相关推荐\n如何像职业球员一样踢出完美弧线球\n2017“唐高—京东体育杯”高球业余赛圆满落幕\n中国马拉松产业远未触及天花板\n揭秘NBA总经理工作 艰苦！他们不再高大上\n产品建议及投诉请联系：shoujibaidu@baidu.com', '', '10', '15623456987', '0', '1491374268', '1491374268');
INSERT INTO `farm_mail` VALUES ('25', 'kdmf', '6', '啊啊啊啊啊啊啊啊啊啊啊啊吃2啊啊啊啊啊啊啊吃？啊啊啊啊啊啊啊啊啊啊啊啊吃2啊啊啊啊啊啊啊吃？啊啊啊啊啊啊啊啊啊啊啊啊吃2啊啊啊啊啊啊啊吃？啊啊啊啊啊啊啊啊啊啊啊啊吃2啊啊啊啊啊啊啊吃？', '20170405/58e49310c668b.jpg|20170405/58e49310cf600.jpg|', '10', '15632654789', '1', '1491374864', '1491379996');
INSERT INTO `farm_mail` VALUES ('26', 'xnxn', '7', 'ncjfk', '20170406/58e5de6374366.jpeg|20170406/58e5de637c4a0.jpeg|20170406/58e5de637f43b.jpeg|', '10', '15623659863', '0', '1491459683', '1491459683');
INSERT INTO `farm_mail` VALUES ('27', 'nfjfk', '52', 'jdjdk', '20170406/58e5de91900ff.jpg|20170406/58e5de9195908.jpg|20170406/58e5de91d3e33.jpg|', '10', '15236953645', '0', '1491459729', '1491459729');
INSERT INTO `farm_mail` VALUES ('28', 'ghh', '52', 'ghn', '', '10', '15236985632', '0', '1491459767', '1491459767');
INSERT INTO `farm_mail` VALUES ('29', 'rfgg', '52', 'vgffgg', '20170406/58e5ded343a34.jpg|', '10', '15269554874', '0', '1491459795', '1491459795');
INSERT INTO `farm_mail` VALUES ('30', '回家', '7', '回家睡觉', '20170406/58e5e43e8cbe9.jpg|', '10', '13663002569', '0', '1491461182', '1491461182');
INSERT INTO `farm_mail` VALUES ('31', '呼吸机', '7', '还惦记', '20170406/58e5e48e999eb.jpg|', '10', '13663002569', '0', '1491461262', '1491461262');
INSERT INTO `farm_mail` VALUES ('32', '步行街', '7', '剑侠客见', '20170406/58e5e4c48e11b.jpg|', '10', '13663002569', '0', '1491461316', '1491461316');
INSERT INTO `farm_mail` VALUES ('33', '你想静静', '7', '江西九江', '', '10', '13663002569', '0', '1491461353', '1491461353');
INSERT INTO `farm_mail` VALUES ('34', 'hhg', '24', 'hhv', '', '10', '15236985632', '0', '1491467774', '1491467774');
INSERT INTO `farm_mail` VALUES ('35', 'kdkf', '25', 'jdkf', '20170406/58e5ff751b034.jpg|20170406/58e5ff75207a1.jpg|', '10', '15236956836', '0', '1491468149', '1491468149');
INSERT INTO `farm_mail` VALUES ('36', 'fhf', '25', 'gdc', '20170406/58e5ffd34748d.jpg|20170406/58e5ffd353757.jpg|', '10', '15936254785', '0', '1491468243', '1491468243');
INSERT INTO `farm_mail` VALUES ('37', '心魄', '57', 'jdkcj', '20170406/58e601d5cb31b.jpg|20170406/58e601d5d83e3.jpg|20170406/58e601d5e33fa.jpg|', '10', '15236985632', '0', '1491468757', '1491468757');
INSERT INTO `farm_mail` VALUES ('38', '255', '5', '都很好', '', '10', '13663002569', '0', '1491469220', '1491469220');
INSERT INTO `farm_mail` VALUES ('39', 'vss', '24', 'gds', '20170406/58e603d9d1347.jpeg|20170406/58e603d9e0b68.jpeg|20170406/58e603d9e8b56.jpeg|', '10', '15236589658', '0', '1491469273', '1491469273');
INSERT INTO `farm_mail` VALUES ('40', '您的传说', '57', 'jdkdj', '20170406/58e60a8a8f42c.jpg|20170406/58e60a8a9b209.jpg|20170406/58e60a8aa1110.jpg|20170406/58e60a8aa6449.jpg|', '10', '15236985632', '0', '1491470986', '1491470986');
INSERT INTO `farm_mail` VALUES ('41', 'dndn', '57', 'djxj', '20170406/58e60b8f36185.jpg|20170406/58e60b8f4367a.jpg|20170406/58e60b8f4ff68.jpg|20170406/58e60b8f5e7ce.jpg|20170406/58e60b8f64367.jpg|20170406/58e60b8f6972c.jpg|', '10', '15236985643', '0', '1491471247', '1491471247');
INSERT INTO `farm_mail` VALUES ('42', 'cch', '57', 'ghh', '', '10', '15236985632', '0', '1491471320', '1491471320');
INSERT INTO `farm_mail` VALUES ('43', 'jdkxk', '48', 'ndkfk', '20170407/58e6eb015daf4.jpg|20170407/58e6eb016713d.jpg|20170407/58e6eb01a4dfa.jpg|20170407/58e6eb01c5b29.jpg|', '10', '15236985632', '0', '1491528449', '1491528449');
INSERT INTO `farm_mail` VALUES ('44', '八年级', '5', '不拘小节', '', '10', '13663002569', '0', '1491529185', '1491529185');
INSERT INTO `farm_mail` VALUES ('45', '不健康', '5', '6646', '20170407/58e6ee20a1f57.jpg|20170407/58e6ee20a7283.jpg|20170407/58e6ee20abd9b.jpg|20170407/58e6ee20af868.jpg|20170407/58e6ee20b4dc9.jpg|20170407/58e6ee20ba268.jpg|', '10', '13663002569', '0', '1491529248', '1491529248');
INSERT INTO `farm_mail` VALUES ('46', '你的扣扣', '5', '你都拒绝', '20170407/58e6ef0385463.jpg|20170407/58e6ef0387f9e.jpg|20170407/58e6ef038c689.jpg|20170407/58e6ef0391ede.jpg|20170407/58e6ef03974c3.jpg|20170407/58e6ef039bb0d.jpg|', '10', '13663002569', '0', '1491529475', '1491529475');
INSERT INTO `farm_mail` VALUES ('47', '京津冀', '5', '不拘小节', '20170407/58e6f032605a7.jpg|20170407/58e6f032660f1.jpg|20170407/58e6f0326c34a.jpg|20170407/58e6f0327115b.jpg|20170407/58e6f03276bd2.jpg|20170407/58e6f0327bc94.jpg|', '10', '13663002569', '0', '1491529778', '1491529778');
INSERT INTO `farm_mail` VALUES ('48', '南京', '5', '回家姐姐', '20170407/58e6f05da30b8.jpg|20170407/58e6f05db6b98.jpg|20170407/58e6f05dba198.jpg|20170407/58e6f05dbe746.jpg|20170407/58e6f05dc22cc.jpg|20170407/58e6f05dc4e91.jpg|', '10', '13663002569', '0', '1491529821', '1491529821');
INSERT INTO `farm_mail` VALUES ('49', '凤凰', '5', '刚回家', '20170407/58e7019f295bf.jpg|20170407/58e7019f2e825.jpg|20170407/58e7019f353a6.jpg|20170407/58e7019f3a7c4.jpg|20170407/58e7019f3ef03.jpg|20170407/58e7019f43d3b.jpg|20170407/58e7019f47d92.jpg|', '10', '13663002569', '0', '1491534239', '1491534239');
INSERT INTO `farm_mail` VALUES ('50', 'kdkk', '7', 'dgb', '20170407/58e704316f8a6.png|20170407/58e70431727b0.jpg|20170407/58e7043174751.jpg|20170407/58e70431765b2.jpg|', '10', '15236985645', '0', '1491534897', '1491534897');
INSERT INTO `farm_mail` VALUES ('51', 'xmx', '7', 'jdk', '', '10', '15236956321', '0', '1491534930', '1491534930');
INSERT INTO `farm_mail` VALUES ('52', '路透社', '36', 'HK里hi', '', '10', '15263589632', '0', '1491547739', '1491547739');
INSERT INTO `farm_mail` VALUES ('53', '55路', '36', '攻击力', '', '10', '15841236985', '0', '1491547826', '1491547826');
INSERT INTO `farm_mail` VALUES ('54', '还很喜欢', '63', '5646', '', '10', '13663002569', '0', '1491549090', '1491549090');
INSERT INTO `farm_mail` VALUES ('55', '北京', '63', '哈哈健康', '', '10', '13663002569', '0', '1491549187', '1491549187');
INSERT INTO `farm_mail` VALUES ('56', '你姐姐', '63', '不健康', '', '10', '13663002569', '0', '1491549217', '1491549217');
INSERT INTO `farm_mail` VALUES ('58', '岁', '36', 'his去', '', '10', '15236952874', '0', '1491551772', '1491551772');
INSERT INTO `farm_mail` VALUES ('59', '32132', '79', '125545', '', '10', '13663002569', '0', '1492149418', '1492149418');
INSERT INTO `farm_mail` VALUES ('60', '333', '79', '5246596', '', '10', '13663002536', '0', '1492149932', '1492149932');
INSERT INTO `farm_mail` VALUES ('61', '1', '79', '1111111', '58f08e0fe832d.jpeg|', '10', '15515530963', '0', '1492160015', '1492160015');
INSERT INTO `farm_mail` VALUES ('62', '123', '79', '3232', '58f08e8d6159e.jpeg|58f08e8d646e1.jpeg|', '10', '13663002569', '0', '1492160141', '1492160141');
INSERT INTO `farm_mail` VALUES ('63', '2', '79', '2222222222', '58f08f7689f4d.jpeg|', '10', '15515530962', '0', '1492160374', '1492160374');
INSERT INTO `farm_mail` VALUES ('64', '333', '79', '333333333', '58f0981f9397120170414.jpeg|', '10', '15517560201', '0', '1492162591', '1492162591');

-- ----------------------------
-- Table structure for `farm_notice`
-- ----------------------------
DROP TABLE IF EXISTS `farm_notice`;
CREATE TABLE `farm_notice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `publishTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `sort` int(10) unsigned NOT NULL COMMENT '排序',
  `createTime` int(11) NOT NULL,
  `updateTime` int(10) unsigned NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1公告2温馨提示',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='系统公告表';

-- ----------------------------
-- Records of farm_notice
-- ----------------------------
INSERT INTO `farm_notice` VALUES ('2', '关于农场升级通知112', '&lt;p&gt;关于农场升级通知关于农场升级通知关于农场升级通知关于农场升级通知关于农场升级通知&lt;/p&gt;&lt;p&gt;关于农场升级通知关于农场升级通知关于农场升级通知关于农场升级通知关于农场升级通知&lt;/p&gt;&lt;p&gt;关于农场升级通知关于农场升级通知关于农场升级通知关于农场升级通知关于农场升级通知&lt;/p&gt;&lt;p&gt;111111&lt;/p&gt;', '2017-04-06 11:23:03', '39', '1489040145', '1490921606', '1');
INSERT INTO `farm_notice` VALUES ('3', '更新22', '&lt;p&gt;的反反复复反反复复&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0010.gif&quot;/&gt;&lt;/p&gt;', '2017-04-06 11:23:12', '42', '1490772457', '1490945917', '1');
INSERT INTO `farm_notice` VALUES ('4', '重置果园提示', '&lt;p&gt;&lt;span style=&quot;color: rgb(255, 0, 0);&quot;&gt;重要提示：重置果园将会拔出所有树苗，并且将肥料数量清零。！&lt;/span&gt;&lt;/p&gt;', '2017-04-05 14:09:24', '50', '1490859593', '1491372564', '2');
INSERT INTO `farm_notice` VALUES ('5', '定向出售提示', '&lt;p&gt;公司收取10%手续费，如果出售100枚果实，则实际交易的只有90枚，本次将锁定出售的果实，别人无法购买！&lt;br/&gt;&lt;/p&gt;', '2017-04-05 14:09:57', '50', '1490859942', '1491372597', '2');
INSERT INTO `farm_notice` VALUES ('6', '发布站内信提示', '&lt;p&gt;提示：每发一条站内信需要从仓库扣除4个果实。&lt;br/&gt;&lt;/p&gt;&lt;p&gt;图片说明：1修改个人资料，请上传身份证正反面、手持身份证拍照2.投诉违规玩家，请上传玩家身份证明1&lt;br/&gt;&lt;/p&gt;', '2017-03-31 10:44:14', '50', '1490860179', '1490928254', '2');
INSERT INTO `farm_notice` VALUES ('9', '农场系统通知', '&lt;p style=&quot;text-align: center;&quot;&gt;&lt;em&gt;&lt;strong&gt;&lt;span style=&quot;color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;回忆起两年前的一幕，柴火创始人潘昊仍然激动不已。他介绍，总理的&amp;quot;创客护照&amp;quot;封面上有个醒目的电烙铁标识，这源于&lt;/span&gt;&lt;/strong&gt;&lt;/em&gt;&lt;span style=&quot;color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;焊接是创客的必备技能。&amp;quot;我们觉得李克强总理本人就像一个创客，一个真正的Maker!&amp;quot;(记者 杨芳)&lt;/span&gt;&lt;/p&gt;', '2017-04-01 00:00:00', '50', '1491026427', '1491026427', '1');
INSERT INTO `farm_notice` VALUES ('8', '委托出售提示', '&lt;p&gt;提示：平台会扣取10%佣金！&lt;/p&gt;', '2017-04-05 14:09:44', '50', '1490943833', '1491372584', '2');
INSERT INTO `farm_notice` VALUES ('10', '不到发布时间', '&lt;p&gt;&lt;span style=&quot;color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;回忆起两年前的一幕，柴火创始人潘昊仍然激动不已。他介绍，总理的&amp;quot;创客护照&amp;quot;封面上有个醒目的电烙铁标识，这源于焊接是创客的必备技能。&amp;quot;我们觉得李克强总理本人就像一个创客，一个真正的Maker!&amp;quot;(记者 杨芳)&lt;/span&gt;&lt;/p&gt;', '2017-04-02 00:00:00', '50', '1491026768', '1491026768', '1');
INSERT INTO `farm_notice` VALUES ('11', '1', '&lt;p&gt;1违法未发生&lt;/p&gt;', '2017-04-01 17:05:44', '50', '1491037540', '1491037540', '1');
INSERT INTO `farm_notice` VALUES ('12', '2', '&lt;p&gt;山东分公司个&lt;/p&gt;', '2017-04-01 17:05:56', '50', '1491037553', '1491037553', '1');
INSERT INTO `farm_notice` VALUES ('13', '3', '&lt;p&gt;四大活动覆盖&lt;/p&gt;', '2017-04-01 17:06:09', '50', '1491037565', '1491037565', '1');
INSERT INTO `farm_notice` VALUES ('14', '4', '&lt;p&gt;顶丰健发馆&lt;/p&gt;', '2017-04-01 17:06:23', '50', '1491037579', '1491037579', '1');
INSERT INTO `farm_notice` VALUES ('15', '5', '&lt;p&gt;速度放缓的感觉&lt;/p&gt;', '2017-04-01 17:06:35', '50', '1491037591', '1491037591', '1');
INSERT INTO `farm_notice` VALUES ('16', '6', '&lt;p&gt;斯蒂芬几乎覆盖&lt;/p&gt;', '2017-04-01 17:06:48', '50', '1491037603', '1491037603', '1');
INSERT INTO `farm_notice` VALUES ('17', '7', '&lt;p&gt;废钢价格和&lt;/p&gt;', '2017-04-06 11:23:22', '1', '1491037616', '1491037616', '1');
INSERT INTO `farm_notice` VALUES ('18', 'nihao', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; white-space: normal; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;近年来，国土资源部多措并举进一步提升矿业权审批满意度。从2013年开始，按照国务院审改办要求，国土部积极梳理矿业权审批中的相关行政审批事项，为矿业权审批松绑，3年来，经国务院批准取消了9项审批事项。&lt;/p&gt;&lt;p style=&quot;margin-top: 1.8em; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; white-space: normal; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-weight: 700;&quot;&gt;简化要件降门槛，为企业办事降成本&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 1.8em; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; white-space: normal; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;国土部探索改进跨部门审批事项和服务，经与国家安全监管总局协调沟通，就不再将安全监督管理部门意见作为颁发采矿许可证的前置要件形成共识，2016年7月28日向社会公告，取消了实施多年的将安全监管部门意见作为申请采矿权材料的规定，减少矿业权申请前置材料，进一步优化行政审批事项，提高行政工作效率和社会服务水平。&lt;/p&gt;&lt;p style=&quot;margin-top: 1.8em; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; white-space: normal; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;在落实国务院办公厅有关加快推进落实注册资本登记制度改革要求中，取消采矿权审批登记中对申请人企业注册资本门槛限制，放宽市场准入条件，进一步激发市场活力和发展动力。&lt;/p&gt;&lt;p style=&quot;margin-top: 1.8em; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; white-space: normal; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;此外，国土部积极申请财政预算，用于支付2016年部发证采矿权的开发利用方案审查费用，不再由相对人自行支付，全年共支出经费126万元，降低了矿山企业办事成本。&lt;/p&gt;&lt;p style=&quot;margin-top: 1.8em; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; white-space: normal; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-weight: 700;&quot;&gt;清理与审批工作关联性不大事项，优化审批&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 1.8em; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; white-space: normal; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;经国务院批准，国土部将矿业权投放计划审批、探矿权采矿权协议出让申请审批等一些与审批工作关联性不大、增设的环节等事项进行了清理，一定程度上优化了审批。&lt;/p&gt;&lt;p style=&quot;margin-top: 1.8em; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; white-space: normal; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;此外，还积极清理矿业权审批过程中涉及到的中介服务，共清理矿业权转让鉴证和公示（勘查矿产资源审批、开采矿产资源审批）、矿产资源开发利用方案编制（开采矿产资源审批）、矿产资源勘查实施方案编制（勘查矿产资源审批）、采矿权申请范围核查（开采矿产资源审批）等4项中介服务事项，受到相对人好评。其中，仅矿业权转让鉴证和公示一项，2016年已为906个转让矿业权的相对人节省了一定数量的交易服务费。&lt;/p&gt;&lt;p style=&quot;margin-top: 1.8em; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; white-space: normal; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-weight: 700;&quot;&gt;调整矿业权管理政策，弱化政府行政干预&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 1.8em; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; white-space: normal; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;经认真梳理，国土部取消了实施多年的煤炭、钨矿探矿权和锑矿探矿权、采矿权新立暂停政策，不再下达锑矿开采总量控制指标，由相对人根据市场和相关政策决定是否新设探矿权，将主动权交给相对人，政府不再替相对人作决定。同时，结合国家安全、市场形势要求，更好发挥政府的宏观调控作用，继续对钨矿采矿权、稀土探矿权、采矿权新立实施暂停政策，有效保障市场的供需平衡。相关政策得到了社会的积极回应，2016年全国仅新立煤炭探矿权38个、锑矿探矿权6个、钨矿探矿权1个。&lt;/p&gt;&lt;p style=&quot;margin-top: 1.8em; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(51, 51, 51); font-family: &amp;quot;Hiragino Sans GB&amp;quot;, &amp;quot;Microsoft Yahei&amp;quot;, 宋体; line-height: 28.8px; white-space: normal; widows: 1; background-color: rgb(255, 255, 255);&quot;&gt;同时，经国务院批准，废止《国务院关于对黄金矿产实行保护性开采的通知》（国发〔1988〕75号），取消黄金矿产作为保护性开采特定矿种管理，进一步优化保护性开采特定矿种范围。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', '2017-04-07 17:22:03', '50', '1491556898', '1491556898', '1');

-- ----------------------------
-- Table structure for `farm_recommend`
-- ----------------------------
DROP TABLE IF EXISTS `farm_recommend`;
CREATE TABLE `farm_recommend` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) unsigned NOT NULL,
  `recommendedId` int(11) unsigned NOT NULL COMMENT '被推荐人id',
  `seedNum` varchar(11) NOT NULL COMMENT '赠送种子数量',
  `createTime` int(11) NOT NULL,
  `updateTime` int(11) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0未审核1审核成功2审核失败',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='推荐人表';

-- ----------------------------
-- Records of farm_recommend
-- ----------------------------
INSERT INTO `farm_recommend` VALUES ('1', '5', '4', '10', '1489973520', '1489973520', '1');
INSERT INTO `farm_recommend` VALUES ('2', '5', '3', '10', '1490074528', '1490074528', '1');
INSERT INTO `farm_recommend` VALUES ('3', '6', '17', '50', '1490949428', '1490949428', '1');
INSERT INTO `farm_recommend` VALUES ('4', '6', '18', '50', '1490949864', '1490949864', '2');
INSERT INTO `farm_recommend` VALUES ('5', '6', '20', '50', '1491032307', '1491032307', '1');
INSERT INTO `farm_recommend` VALUES ('6', '6', '21', '50', '1491034251', '1491034251', '1');
INSERT INTO `farm_recommend` VALUES ('7', '22', '23', '50', '1491038964', '1491038964', '2');
INSERT INTO `farm_recommend` VALUES ('8', '7', '24', '50', '1491361940', '1491362639', '1');
INSERT INTO `farm_recommend` VALUES ('9', '7', '25', '50', '1491361996', '1491362614', '1');
INSERT INTO `farm_recommend` VALUES ('10', '7', '26', '50', '1491362031', '1491362578', '1');
INSERT INTO `farm_recommend` VALUES ('11', '7', '27', '50', '1491362069', '1491362556', '1');
INSERT INTO `farm_recommend` VALUES ('12', '7', '28', '50', '1491362098', '1491362539', '1');
INSERT INTO `farm_recommend` VALUES ('13', '7', '29', '50', '1491362137', '1491362521', '1');
INSERT INTO `farm_recommend` VALUES ('14', '7', '30', '50', '1491362187', '1491362505', '1');
INSERT INTO `farm_recommend` VALUES ('15', '7', '31', '50', '1491362227', '1491362490', '1');
INSERT INTO `farm_recommend` VALUES ('16', '7', '32', '50', '1491362284', '1491362475', '1');
INSERT INTO `farm_recommend` VALUES ('17', '7', '33', '50', '1491362324', '1491362462', '1');
INSERT INTO `farm_recommend` VALUES ('18', '7', '34', '50', '1491362356', '1491362412', '2');
INSERT INTO `farm_recommend` VALUES ('19', '7', '35', '50', '1491362384', '1491362443', '1');
INSERT INTO `farm_recommend` VALUES ('20', '36', '37', '50', '1491363877', '1491363944', '1');
INSERT INTO `farm_recommend` VALUES ('21', '36', '38', '50', '1491363907', '1491363962', '1');
INSERT INTO `farm_recommend` VALUES ('22', '36', '39', '50', '1491364037', '1491364109', '1');
INSERT INTO `farm_recommend` VALUES ('23', '36', '40', '50', '1491364065', '1491364094', '2');
INSERT INTO `farm_recommend` VALUES ('24', '36', '41', '50', '1491364620', '1491373394', '2');
INSERT INTO `farm_recommend` VALUES ('25', '7', '43', '50', '1491372396', '1491372417', '1');
INSERT INTO `farm_recommend` VALUES ('26', '7', '44', '50', '1491378610', '1491378668', '1');
INSERT INTO `farm_recommend` VALUES ('27', '7', '45', '50', '1491378718', '1491378732', '2');
INSERT INTO `farm_recommend` VALUES ('28', '7', '46', '50', '1491379022', '1491379047', '2');
INSERT INTO `farm_recommend` VALUES ('29', '7', '47', '50', '1491379186', '1491379208', '1');
INSERT INTO `farm_recommend` VALUES ('30', '7', '49', '50', '1491445398', '1491445433', '1');
INSERT INTO `farm_recommend` VALUES ('31', '14', '50', '50', '1491445522', '1491445544', '1');
INSERT INTO `farm_recommend` VALUES ('32', '24', '54', '50', '1491466269', '1491466372', '1');
INSERT INTO `farm_recommend` VALUES ('33', '24', '55', '50', '1491466450', '1491466466', '2');
INSERT INTO `farm_recommend` VALUES ('34', '24', '56', '50', '1491466521', '1491466602', '1');
INSERT INTO `farm_recommend` VALUES ('35', '57', '58', '50', '1491469706', '1491469759', '1');
INSERT INTO `farm_recommend` VALUES ('36', '57', '59', '50', '1491469723', '1491469742', '2');
INSERT INTO `farm_recommend` VALUES ('37', '12', '60', '50', '1491530666', '1491530720', '1');
INSERT INTO `farm_recommend` VALUES ('38', '12', '61', '50', '1491530846', '1491530899', '2');
INSERT INTO `farm_recommend` VALUES ('39', '36', '62', '50', '1491545867', '1491545920', '1');
INSERT INTO `farm_recommend` VALUES ('40', '7', '64', '50', '1491552062', '1491552145', '1');
INSERT INTO `farm_recommend` VALUES ('41', '7', '65', '50', '1491787902', '1491787948', '1');
INSERT INTO `farm_recommend` VALUES ('42', '67', '68', '50', '1491815158', '1491815391', '1');
INSERT INTO `farm_recommend` VALUES ('43', '67', '69', '50', '1491816180', '1491816243', '1');
INSERT INTO `farm_recommend` VALUES ('44', '67', '70', '50', '1491816812', '1491816887', '1');
INSERT INTO `farm_recommend` VALUES ('45', '67', '71', '50', '1491817219', '1491817258', '1');
INSERT INTO `farm_recommend` VALUES ('46', '81', '84', '50', '1492669522', '1492669711', '1');
INSERT INTO `farm_recommend` VALUES ('47', '85', '86', '50', '1492738937', '1492738974', '1');
INSERT INTO `farm_recommend` VALUES ('48', '85', '87', '50', '1492739325', '1492739347', '1');
INSERT INTO `farm_recommend` VALUES ('49', '85', '88', '50', '1492739409', '1492739486', '1');
INSERT INTO `farm_recommend` VALUES ('50', '85', '89', '50', '1492739650', '1492739683', '1');
INSERT INTO `farm_recommend` VALUES ('51', '81', '90', '16', '1492932106', '1492932446', '1');
INSERT INTO `farm_recommend` VALUES ('52', '81', '91', '16', '1493691608', '1493691659', '1');
INSERT INTO `farm_recommend` VALUES ('53', '81', '92', '16', '1493693354', '1493693436', '1');
INSERT INTO `farm_recommend` VALUES ('54', '90', '95', '16', '1493714786', '1493715731', '1');
INSERT INTO `farm_recommend` VALUES ('55', '91', '96', '18', '1493774577', '1493774858', '1');
INSERT INTO `farm_recommend` VALUES ('56', '91', '97', '18', '1493775148', '1493775208', '1');
INSERT INTO `farm_recommend` VALUES ('57', '90', '99', '16', '1493782905', '1493782991', '1');
INSERT INTO `farm_recommend` VALUES ('58', '92', '100', '16', '1493905181', '1493905339', '1');
INSERT INTO `farm_recommend` VALUES ('59', '81', '101', '16', '1494209725', '1494218340', '1');
INSERT INTO `farm_recommend` VALUES ('60', '84', '102', '16', '1494293492', '1494293534', '1');

-- ----------------------------
-- Table structure for `farm_seed_fruit`
-- ----------------------------
DROP TABLE IF EXISTS `farm_seed_fruit`;
CREATE TABLE `farm_seed_fruit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `seedNum` varchar(255) NOT NULL COMMENT '种子余量',
  `fruitNum` varchar(255) NOT NULL COMMENT '果实数量',
  `fee` varchar(255) DEFAULT NULL COMMENT '兑换比例',
  `createTime` int(11) unsigned NOT NULL,
  `changeNum` varchar(255) NOT NULL COMMENT '兑换数量',
  PRIMARY KEY (`id`),
  KEY `user_seed_index` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='种子转化果实表';

-- ----------------------------
-- Records of farm_seed_fruit
-- ----------------------------
INSERT INTO `farm_seed_fruit` VALUES ('1', '3', '10', '0.2', '0.02', '1490259069', '0');
INSERT INTO `farm_seed_fruit` VALUES ('2', '7', '1000.00', '3', '0.03', '1490952733', '100');
INSERT INTO `farm_seed_fruit` VALUES ('3', '7', '900.00', '3', '0.03', '1490952908', '100');
INSERT INTO `farm_seed_fruit` VALUES ('4', '6', '150.00', '0.3', '0.03', '1491035704', '10');
INSERT INTO `farm_seed_fruit` VALUES ('5', '7', '800.00', '0.3', '0.03', '1491037324', '10');
INSERT INTO `farm_seed_fruit` VALUES ('6', '7', '790.00', '0.3', '0.03', '1491037330', '10');
INSERT INTO `farm_seed_fruit` VALUES ('7', '7', '780.00', '0.6', '0.03', '1491037335', '20');
INSERT INTO `farm_seed_fruit` VALUES ('8', '7', '760.00', '0.9', '0.03', '1491037340', '30');
INSERT INTO `farm_seed_fruit` VALUES ('9', '7', '730.00', '1.2', '0.03', '1491037344', '40');
INSERT INTO `farm_seed_fruit` VALUES ('10', '7', '690.00', '0.3', '0.03', '1491037349', '10');
INSERT INTO `farm_seed_fruit` VALUES ('11', '7', '680.00', '0.9', '0.03', '1491037355', '30');
INSERT INTO `farm_seed_fruit` VALUES ('12', '7', '650.00', '0.3', '0.03', '1491037393', '10');
INSERT INTO `farm_seed_fruit` VALUES ('13', '7', '640.00', '0.6', '0.03', '1491037397', '20');
INSERT INTO `farm_seed_fruit` VALUES ('14', '7', '620.00', '0.9', '0.03', '1491037402', '30');
INSERT INTO `farm_seed_fruit` VALUES ('15', '7', '590.00', '1.2', '0.03', '1491037406', '40');
INSERT INTO `farm_seed_fruit` VALUES ('16', '7', '550.00', '1.5', '0.03', '1491037410', '50');
INSERT INTO `farm_seed_fruit` VALUES ('17', '7', '1150.00', '0.3', '0.03', '1491378156', '10');
INSERT INTO `farm_seed_fruit` VALUES ('18', '7', '1140.00', '0.3', '0.03', '1491378284', '10');
INSERT INTO `farm_seed_fruit` VALUES ('19', '7', '1230.00', '3', '0.03', '1491386675', '100');
INSERT INTO `farm_seed_fruit` VALUES ('20', '7', '1130.00', '0.3', '0.03', '1491386688', '10');
INSERT INTO `farm_seed_fruit` VALUES ('21', '7', '1120.00', '0.3', '0.03', '1491386689', '10');
INSERT INTO `farm_seed_fruit` VALUES ('22', '7', '1160.00', '0.033333333', '0.03', '1491459408', '1.1111111');
INSERT INTO `farm_seed_fruit` VALUES ('23', '24', '100.00', '0.0333', '0.03', '1491467683', '1.11');
INSERT INTO `farm_seed_fruit` VALUES ('24', '24', '98.89', '0.033', '0.03', '1491467700', '1.1');
INSERT INTO `farm_seed_fruit` VALUES ('25', '57', '50.00', '0.03', '0.03', '1491470662', '1');
INSERT INTO `farm_seed_fruit` VALUES ('26', '57', '49.00', '0.03', '0.03', '1491470679', '1.0');
INSERT INTO `farm_seed_fruit` VALUES ('27', '12', '50.00', '0.3', '0.03', '1491531074', '10');
INSERT INTO `farm_seed_fruit` VALUES ('28', '14', '50.00', '0.3', '0.03', '1491550844', '10');
INSERT INTO `farm_seed_fruit` VALUES ('29', '7', '1208.89', '0.03', '0.03', '1491552589', '1');
INSERT INTO `farm_seed_fruit` VALUES ('30', '7', '1207.89', '0.03', '0.03', '1491553008', '1');
INSERT INTO `farm_seed_fruit` VALUES ('31', '7', '1206.89', '0.2688', '0.03', '1491553022', '8.96');
INSERT INTO `farm_seed_fruit` VALUES ('32', '7', '1197.93', '3', '0.03', '1491558183', '100');
INSERT INTO `farm_seed_fruit` VALUES ('33', '7', '1097.93', '0.03', '0.03', '1491558216', '1');
INSERT INTO `farm_seed_fruit` VALUES ('34', '67', '250.00', '7.5', '0.03', '1491897661', '250');
INSERT INTO `farm_seed_fruit` VALUES ('35', '81', '116.00', '3.48', '0.03', '1492989764', '116');

-- ----------------------------
-- Table structure for `farm_user`
-- ----------------------------
DROP TABLE IF EXISTS `farm_user`;
CREATE TABLE `farm_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userName` varchar(100) NOT NULL COMMENT '用户账号',
  `password` char(32) NOT NULL,
  `secondPwd` char(32) NOT NULL,
  `level` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '等级',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别0未知   1男  2女',
  `realName` varchar(100) DEFAULT NULL,
  `phone` char(11) DEFAULT NULL,
  `wechat` varchar(255) DEFAULT NULL,
  `alipay` varchar(255) DEFAULT NULL,
  `createTime` int(11) NOT NULL,
  `updateTime` int(11) unsigned NOT NULL,
  `isShow` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否展示  1展示  0不展示',
  `friendNum` int(11) unsigned NOT NULL COMMENT '好友数量',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of farm_user
-- ----------------------------
INSERT INTO `farm_user` VALUES ('1', 'user01', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '2', '小王', '15890052366', 'nnaa01', 'hdfh001', '1489118787', '1489631354', '0', '0');
INSERT INTO `farm_user` VALUES ('2', 'user02', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '2', '小张', '15515530216', 'hdfhjh12', 'njsd01', '1489630282', '1489630282', '0', '0');
INSERT INTO `farm_user` VALUES ('3', 'user03', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '1', 'xiaogao', '15890042558', 'ffghh', 'dfgg', '1489712104', '1489712104', '0', '0');
INSERT INTO `farm_user` VALUES ('4', 'user04', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '1', '小刘', '15790052554', '377hfjj', 'ffjkkdf', '1489973520', '1489973520', '0', '0');
INSERT INTO `farm_user` VALUES ('5', 'user05', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '4', '2', '洋洋样', '13462027456', 'shfd11', 'sdfdf11', '1490074871', '1490680235', '0', '0');
INSERT INTO `farm_user` VALUES ('6', '朱keke', '227af9354aef4e7d4050b1043d5be6b7', 'af17eb79a3966e522e1d79157c96fe68', '7', '1', '朱可1', '18595468601', '34534523530', '1424235234530', '1490859378', '1490859378', '0', '0');
INSERT INTO `farm_user` VALUES ('7', 'zhukk', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '3', '2', '整蛊e', '15212345678', 'jddjjfdeee', 'jfjfjeee', '1490930791', '1490930791', '0', '0');
INSERT INTO `farm_user` VALUES ('8', '小七', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '7', '2', '小七', '17236566689', 'ddf', 'ssd', '1490942633', '1490942633', '0', '0');
INSERT INTO `farm_user` VALUES ('9', '测试一级', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', '一级', '15678945612', '', '', '1490945164', '1490945164', '0', '0');
INSERT INTO `farm_user` VALUES ('10', '测试二级', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '3', '1', '二级', '15879564236', '', '', '1490945206', '1490945206', '0', '0');
INSERT INTO `farm_user` VALUES ('11', '测试三级', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '3', '1', '三级', '18745693216', '', '', '1490945254', '1490945254', '0', '0');
INSERT INTO `farm_user` VALUES ('12', '测试四级', '061c1afd52a84d98a1dd8da679c27078', 'af17eb79a3966e522e1d79157c96fe68', '4', '1', '四级', '15678956324', '', '', '1490945381', '1490945381', '0', '0');
INSERT INTO `farm_user` VALUES ('13', '测试五级', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '5', '1', '五级', '15245698745', '', '', '1490945450', '1490945450', '0', '0');
INSERT INTO `farm_user` VALUES ('14', '测试七级', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '7', '1', '七级', '15789456321', '明年', 'djfj', '1490945712', '1490945712', '0', '0');
INSERT INTO `farm_user` VALUES ('15', '测试六级', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '6', '1', '六级', '15078945612', 'jdkfk', 'ndjfk', '1490945774', '1490945774', '0', '0');
INSERT INTO `farm_user` VALUES ('16', '测试重置', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '6', '1', '重置', '15145698754', '', '', '1490945825', '1490945825', '0', '0');
INSERT INTO `farm_user` VALUES ('17', 'keke01', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '0', null, '18596321456', 'dncn', 'xncncm', '1491015493', '1491015493', '0', '0');
INSERT INTO `farm_user` VALUES ('18', 'keke02', '', '', '1', '0', null, '15232654789', 'dkxkc', 'dncjc', '1490949864', '1490949864', '0', '0');
INSERT INTO `farm_user` VALUES ('19', '测试衰减', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '3', '1', '衰减', '15678945612', '', '', '1491014031', '1491014031', '0', '0');
INSERT INTO `farm_user` VALUES ('20', 'keke03', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '0', 'keke', '15236547896', 'xndkkf', 'ndncn', '1491032398', '1491032398', '0', '0');
INSERT INTO `farm_user` VALUES ('21', 'keke04', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '3', '2', 'keke', '15294686542', 'nxnck', 'nfjfj', '1491034287', '1491361359', '0', '0');
INSERT INTO `farm_user` VALUES ('22', '开垦', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', 'kaiken', '15245698745', '', '', '1491038788', '1491038788', '0', '0');
INSERT INTO `farm_user` VALUES ('23', '开垦01', '', '', '1', '0', '123456', '15236956369', '化妆品', 'jdjcn', '1491038964', '1491038964', '0', '0');
INSERT INTO `farm_user` VALUES ('24', 'kk01', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '3', '0', '好友一', '15326457893', 'dgghh', 'fvhyy', '1491362639', '1491362639', '0', '0');
INSERT INTO `farm_user` VALUES ('25', 'kk02', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '3', '0', '好友二', '15212365478', 'ghgd', 'fhbn', '1491362614', '1491362614', '0', '0');
INSERT INTO `farm_user` VALUES ('26', 'kk03', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', '好友三', '15623456987', 'dgbjj', 'gdfbj', '1491362578', '1491362578', '0', '0');
INSERT INTO `farm_user` VALUES ('27', 'kk04', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', '好友四', '15812369856', 'fghh', 'vfeyj', '1491362556', '1491362556', '0', '0');
INSERT INTO `farm_user` VALUES ('28', 'kk05', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', '好友五', '15723654789', 'dbhrfh', 'dghtgb', '1491362539', '1491362539', '0', '0');
INSERT INTO `farm_user` VALUES ('29', 'kk06', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', '好友六', '15852147896', 'dgnjh', 'fbjyf', '1491362521', '1491362521', '0', '0');
INSERT INTO `farm_user` VALUES ('30', 'kk07', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', '好友七', '15923654789', 'gnhth', 'cghg', '1491362505', '1491362505', '0', '0');
INSERT INTO `farm_user` VALUES ('31', 'kk08', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', '好友八', '15623456987', 'jdjcnfn', 'djcjcj', '1491362490', '1491362490', '0', '0');
INSERT INTO `farm_user` VALUES ('32', 'kk09', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', '好友久', '15693657486', 'jfnfjf', 'jdjfj', '1491362475', '1491362475', '0', '0');
INSERT INTO `farm_user` VALUES ('33', 'kk10', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', '好友十', '15123654879', 'jfjcj', 'ndjfj', '1491362462', '1491362462', '0', '0');
INSERT INTO `farm_user` VALUES ('34', 'kk拒绝', '', '', '1', '0', '好友拒绝', '15632145869', 'djcjvj', 'jfjcjo', '1491362356', '1491362356', '0', '0');
INSERT INTO `farm_user` VALUES ('35', 'kk删除', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', '好友删除', '15032456987', 'jcjckc', 'jckfkfn', '1491362443', '1491362443', '0', '0');
INSERT INTO `farm_user` VALUES ('36', '测试道具', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '5', '1', '道具', '15678945621', '4654564', 'sdfasdfg124', '1491363505', '1491363505', '0', '0');
INSERT INTO `farm_user` VALUES ('37', '道具01', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', '道具一', '15236985634', 'kxkcmnc', 'xnmxmck', '1491363944', '1491363944', '0', '0');
INSERT INTO `farm_user` VALUES ('38', '道具02', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', ' 道具二', '15236985647', 'fjcncn', 'xnxnc', '1491363962', '1491363962', '0', '0');
INSERT INTO `farm_user` VALUES ('39', '道具03', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '0', '道具三', '15369985643', 'dnckc', 'nxnxj', '1491364109', '1491364109', '0', '0');
INSERT INTO `farm_user` VALUES ('40', '道具拒绝', '', '', '1', '0', '道具拒绝', '15632569874', 'xnckck', 'nckck', '1491364065', '1491364065', '0', '0');
INSERT INTO `farm_user` VALUES ('41', 'mx', '', '', '1', '0', 'ndm', '15236589654', 'mfkck', 'nxkck', '1491364620', '1491364620', '0', '0');
INSERT INTO `farm_user` VALUES ('42', '开垦02', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '3', '1', '开垦02', '15698756324', '', '', '1491371177', '1491371177', '0', '0');
INSERT INTO `farm_user` VALUES ('43', 'kk11', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', '好友11', '15236985643', 'dncj', 'ncnfk', '1491372417', '1491372417', '0', '0');
INSERT INTO `farm_user` VALUES ('44', 'kk12', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '2', '好友12', '15236985642', 'dnxj', 'ndncn', '1491378668', '1491378668', '0', '0');
INSERT INTO `farm_user` VALUES ('45', 'kk1拒绝', '', '', '1', '2', '拒绝', '15236945678', 'jdjcj', 'nxnxn', '1491378718', '1491378718', '0', '0');
INSERT INTO `farm_user` VALUES ('46', 'kk2拒绝', '', '', '1', '1', 'kk拒绝', '15236985632', 'mdjcj', 'ndnxk', '1491379022', '1491379022', '0', '0');
INSERT INTO `farm_user` VALUES ('47', 'kk1删除', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', '删除', '15623698546', 'jcjcn', 'nfncn', '1491379209', '1491379209', '0', '0');
INSERT INTO `farm_user` VALUES ('48', '衰减1', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '3', '1', '衰减', '15698745632', '466', '6568', '1491443263', '1491443263', '0', '0');
INSERT INTO `farm_user` VALUES ('49', '代kk13', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', '代推', '15236985632', 'jcjcnjc', 'ncjck', '1491445433', '1491445433', '0', '0');
INSERT INTO `farm_user` VALUES ('50', '七级推', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '2', 'mix', '15632456987', 'jfkcj', 'ncnck', '1491445544', '1491445544', '0', '0');
INSERT INTO `farm_user` VALUES ('51', '登录收益', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', '登录收益', '15689745632', '', '', '1491446129', '1491446129', '0', '0');
INSERT INTO `farm_user` VALUES ('52', '后台收益1', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '2', '后台收益1', '18745693252', 'dmfkkf', 'dnfjf', '1491446172', '1491446172', '0', '0');
INSERT INTO `farm_user` VALUES ('53', 'fc', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '1', 'fc', '13663223626', '', '', '1491465801', '1491465801', '0', '0');
INSERT INTO `farm_user` VALUES ('54', 'z01', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', '朱一', '15236986354', 'Nimrod', 'nfjks', '1491466372', '1491466372', '0', '0');
INSERT INTO `farm_user` VALUES ('55', 'z拒绝', '', '', '1', '2', 'z', '15236985643', 'jdfjkf', 'jdjcj', '1491466450', '1491466450', '0', '0');
INSERT INTO `farm_user` VALUES ('56', 'z删除', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '2', 'z', '15632569847', 'djcjc', 'ndncj', '1491466602', '1491466602', '0', '0');
INSERT INTO `farm_user` VALUES ('57', '收益1', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '3', '2', '收益1', '18756325691', 'nfk', 'nfk', '1491468351', '1491468351', '0', '0');
INSERT INTO `farm_user` VALUES ('58', 'jd', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '3', '2', 'kfk', '15632569856', 'kfkgk', 'jfkfk', '1491469759', '1491469759', '0', '0');
INSERT INTO `farm_user` VALUES ('59', 'jdjxj', '', '', '1', '2', 'jfkfm', '15236985632', 'nfjfj', 'nfjfj', '1491469723', '1491469723', '0', '0');
INSERT INTO `farm_user` VALUES ('60', '猴', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', '哦咯', '15236985632', 'dnxjjf', 'jdjfj', '1491530720', '1491530720', '0', '0');
INSERT INTO `farm_user` VALUES ('61', 'nfkck', '', '', '1', '1', 'jdkfk', '15632456978', 'bcjf', 'nfjf', '1491530846', '1491530846', '0', '0');
INSERT INTO `farm_user` VALUES ('62', '道具1', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '2', '道具一', '15236986352', 'dmxk', 'nfkd', '1491545921', '1491545921', '0', '0');
INSERT INTO `farm_user` VALUES ('63', '123', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '1', 'kong', '13663002569', '', '', '1491549056', '1491549056', '0', '0');
INSERT INTO `farm_user` VALUES ('64', 'kk15', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '2', '好友十五', '15636985234', 'jdkkf', 'nfjfk', '1491552145', '1491552145', '0', '0');
INSERT INTO `farm_user` VALUES ('65', 'df', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '2', 'scgfd', '15236985632', 'QDFbH', 'wddftg', '1491787948', '1491787948', '0', '0');
INSERT INTO `farm_user` VALUES ('66', 'woaini', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '2', '1', '李龙', '13598750000', 'wozuiai778899', '', '1491810512', '1491810512', '0', '0');
INSERT INTO `farm_user` VALUES ('67', 'zpp7858', 'f7d61f6d975a9ed166740fb1b2a182f3', '9c67260810e6fc0c268958f5ba926c47', '2', '2', '张盼盼', '18738967858', 'wmm850730911', '', '1491813974', '1491813974', '0', '1');
INSERT INTO `farm_user` VALUES ('68', 'woaini123', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '1', '1', '李龙', '13598750000', 'wozuiai778899', '13598750000', '1491815391', '1491815391', '0', '0');
INSERT INTO `farm_user` VALUES ('69', 'woaini1234', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '1', '1', '李龙', '13598750000', 'wozuiai778899', '13598750000', '1491816243', '1491816243', '0', '0');
INSERT INTO `farm_user` VALUES ('70', 'woaini1', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '1', '1', '李龙', '13598750000', 'wozuiai778899', '13598750000', '1491816887', '1491816887', '0', '0');
INSERT INTO `farm_user` VALUES ('71', 'woaini12345', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '1', '1', '李龙', '13598750000', 'wozuiai778899', '13598750000', '1491817258', '1491817258', '0', '0');
INSERT INTO `farm_user` VALUES ('72', 'ceshi', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '1', 'zhu', '12345678901', '', '', '1491873937', '1491873937', '0', '0');
INSERT INTO `farm_user` VALUES ('73', 'xiaowang01', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '1', '111', '15515530961', '1111111111', '111', '1491874659', '1491874659', '0', '0');
INSERT INTO `farm_user` VALUES ('74', 'hf', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', '化肥', '15698745632', '', '', '1491876258', '1491876258', '0', '0');
INSERT INTO `farm_user` VALUES ('75', 'hf01', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', '化肥01', '15236987456', '', '', '1491876369', '1491876369', '0', '0');
INSERT INTO `farm_user` VALUES ('76', 'xhf', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', '系统化肥', '15896325698', '', '', '1491876593', '1491876593', '0', '0');
INSERT INTO `farm_user` VALUES ('77', 'zkk', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '4', '1', '朱', '15698745632', '', '', '1492048009', '1492048009', '0', '0');
INSERT INTO `farm_user` VALUES ('78', 'zkk01', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '4', '1', '朱', '15515530962', '111', '11111111', '1492049006', '1492049006', '0', '0');
INSERT INTO `farm_user` VALUES ('79', 'zkk02', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '4', '1', 'zkk', '15515530964', '122', '111', '1492054080', '1492054080', '0', '0');
INSERT INTO `farm_user` VALUES ('80', 'zpp12345', 'f7d61f6d975a9ed166740fb1b2a182f3', '21abf09e72b3cf55a467d34dc939b136', '1', '2', '张盼盼', '18738967858', 'wmm850730911', '13691100300', '1492486742', '1492486742', '0', '0');
INSERT INTO `farm_user` VALUES ('81', 'zpp1234', 'e1bee75883f87d3771be8a0845f3daa3', '8798f9a74237453af59f21c4f0a0a169', '7', '2', '张盼盼', '18738967858', 'wmm830730911', '13691100300', '1492487770', '1492487770', '1', '5');
INSERT INTO `farm_user` VALUES ('82', '123456', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '1', '老三', '18103869634', '', '', '1492501735', '1492501735', '0', '0');
INSERT INTO `farm_user` VALUES ('83', '12345678', 'b631fa560cd632aa4297b67fd5a59bc5', 'b631fa560cd632aa4297b67fd5a59bc5', '1', '1', '王三', '18103869635', '', '', '1492563841', '1492563841', '1', '0');
INSERT INTO `farm_user` VALUES ('84', 'zgh7131', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '1', '1', '朱冠寰', '13838317131', 'Dream-zGh', '13838317131', '1492669711', '1492669711', '1', '1');
INSERT INTO `farm_user` VALUES ('85', 'zkk011', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '5', '1', 'zkk', '15698745632', '', '', '1492672470', '1493006209', '1', '2');
INSERT INTO `farm_user` VALUES ('86', 'zkkq', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '1', 'nxn', '15863985632', 'ncjf', 'jdjdjjx', '1492738974', '1492738974', '1', '0');
INSERT INTO `farm_user` VALUES ('87', 'sjxn', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '2', 'nxn', '15632457896', 'nfncn', 'jfjfj', '1492739347', '1492739347', '1', '0');
INSERT INTO `farm_user` VALUES ('88', 'jk', 'af17eb79a3966e522e1d79157c96fe68', 'af17eb79a3966e522e1d79157c96fe68', '1', '2', 'hvjk', '15269586345', 'jdjdjj', 'jdjjfjf', '1492739486', '1492739486', '0', '0');
INSERT INTO `farm_user` VALUES ('89', 'jxj', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '1', 'jcncj', '15636985634', 'nxnnc', 'jfjc', '1492739683', '1492739683', '1', '0');
INSERT INTO `farm_user` VALUES ('90', 'LL0000', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '2', '1', '李龙', '13598750000', 'wozuiai778899', '13598750000', '1492932446', '1492932446', '1', '2');
INSERT INTO `farm_user` VALUES ('91', 'CW0821', 'd98048f639f3a93466110738579a41b1', 'd98048f639f3a93466110738579a41b1', '1', '1', '陈伟', '15890300821', 'CW-XY0821', '15890300821', '1493691659', '1493691659', '1', '1');
INSERT INTO `farm_user` VALUES ('92', 'HLL7275', 'dbc232c663e4ccecdc0d928726ae2c7a', 'dbc232c663e4ccecdc0d928726ae2c7a', '1', '2', '户兰兰', '13569517275', 'H13569517275', '13569517275', '1493693436', '1493693436', '1', '1');
INSERT INTO `farm_user` VALUES ('93', 'lxn123456', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '1', '2', '柳晓宁', '18237803688', 'wmwpg789', '', '1493702785', '1493702785', '0', '0');
INSERT INTO `farm_user` VALUES ('94', 'whx9898', '40bbd8df36c8033cac5cb2d4fb72683b', '354d3eee10aac951285dc851788e474a', '1', '2', '王焕想', '18237807175', 'wanghuanxiang2013', '', '1493706165', '1493706165', '1', '0');
INSERT INTO `farm_user` VALUES ('95', 'lxn123', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '1', '2', '柳晓宁', '18237803600', 'l18237803688', '18237803688', '1493715731', '1493716143', '1', '0');
INSERT INTO `farm_user` VALUES ('96', 'CXJ', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '1', '2', '陈小静', '13938626911', 'C13938626911', '13938626911', '1493774858', '1493774858', '0', '0');
INSERT INTO `farm_user` VALUES ('97', 'CXJ6911', '3982387d6b0a2915264fe3f709c5eda3', '8cb030b181c3c0f9f836263084bbc696', '1', '2', '陈小静', '13938626911', 'C13938626911', '13938626911', '1493775208', '1493775208', '1', '0');
INSERT INTO `farm_user` VALUES ('98', 'zp7858', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '1', '2', '张盼盼', '18738967858', 'wmm850730911', '13691100300', '1493776812', '1493776812', '0', '0');
INSERT INTO `farm_user` VALUES ('99', 'LHJ5722', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '1', '1', '李海军', '13949405722', 'a13949405722', '13949405722', '1493782991', '1493782991', '1', '0');
INSERT INTO `farm_user` VALUES ('100', 'LYH9876', '227af9354aef4e7d4050b1043d5be6b7', '8cb030b181c3c0f9f836263084bbc696', '1', '2', '李艳红', '15093649876', 'yihu587', '15093649876', '1493905339', '1493905339', '1', '0');
INSERT INTO `farm_user` VALUES ('101', 'zpp123456', 'e1bee75883f87d3771be8a0845f3daa3', '8798f9a74237453af59f21c4f0a0a169', '1', '2', '张盼盼', '18738967858', 'wmm850730911', '18738967858', '1494218340', '1494218340', '1', '0');
INSERT INTO `farm_user` VALUES ('102', 'ceshi001', '227af9354aef4e7d4050b1043d5be6b7', '227af9354aef4e7d4050b1043d5be6b7', '1', '1', 'ceshi', '12345678901', '123', '123', '1494293534', '1494293534', '1', '0');

-- ----------------------------
-- Table structure for `farm_user_garden`
-- ----------------------------
DROP TABLE IF EXISTS `farm_user_garden`;
CREATE TABLE `farm_user_garden` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) unsigned NOT NULL,
  `houseFruit` decimal(11,2) NOT NULL COMMENT '仓库总量',
  `totalNum` decimal(11,2) unsigned NOT NULL COMMENT '总量',
  `totalGrow` decimal(11,2) unsigned NOT NULL COMMENT '生长总量',
  `seed` decimal(11,2) unsigned NOT NULL COMMENT '种子数量',
  `scarecrow` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '稻草人数量',
  `dog` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '狗的数量',
  `totalFertilizer` decimal(10,2) unsigned NOT NULL COMMENT '化肥总量',
  `doFertilizer` decimal(10,2) NOT NULL COMMENT '施肥总量',
  `landNum` tinyint(2) unsigned NOT NULL COMMENT '土地数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='用户果园表';

-- ----------------------------
-- Records of farm_user_garden
-- ----------------------------
INSERT INTO `farm_user_garden` VALUES ('1', '3', '142.37', '811.34', '811.34', '10.00', '0', '0', '7.12', '20.50', '1');
INSERT INTO `farm_user_garden` VALUES ('2', '4', '600.00', '4425.26', '6927.26', '0.00', '0', '0', '0.00', '422.21', '6');
INSERT INTO `farm_user_garden` VALUES ('3', '5', '6211.55', '900.00', '24048.53', '0.00', '0', '0', '645.76', '211.44', '1');
INSERT INTO `farm_user_garden` VALUES ('4', '6', '30323.40', '24300.00', '71300.00', '140.00', '0', '0', '32.34', '4251.60', '15');
INSERT INTO `farm_user_garden` VALUES ('5', '7', '1930.89', '5390.00', '22150.10', '1146.93', '4', '2', '46.55', '1238.58', '6');
INSERT INTO `farm_user_garden` VALUES ('6', '8', '8000.00', '9441.12', '58041.12', '0.00', '0', '0', '0.00', '0.00', '11');
INSERT INTO `farm_user_garden` VALUES ('7', '9', '0.00', '1301.46', '1301.46', '0.00', '0', '0', '0.00', '0.00', '2');
INSERT INTO `farm_user_garden` VALUES ('8', '10', '5850.00', '6998.40', '11206.02', '0.00', '0', '0', '1000.00', '0.00', '11');
INSERT INTO `farm_user_garden` VALUES ('9', '11', '0.00', '9275.17', '9285.17', '0.00', '0', '0', '0.00', '0.00', '11');
INSERT INTO `farm_user_garden` VALUES ('10', '12', '0.00', '0.00', '17210.04', '40.00', '0', '0', '20.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('11', '13', '0.00', '19757.10', '20357.10', '0.00', '0', '0', '0.00', '0.00', '13');
INSERT INTO `farm_user_garden` VALUES ('12', '14', '12006.00', '18000.00', '47375.04', '40.00', '0', '0', '0.00', '0.00', '15');
INSERT INTO `farm_user_garden` VALUES ('13', '15', '0.00', '24185.70', '24785.70', '0.00', '0', '0', '0.00', '0.00', '14');
INSERT INTO `farm_user_garden` VALUES ('14', '16', '30000.00', '0.00', '15180.00', '0.00', '0', '0', '1800.00', '18.00', '0');
INSERT INTO `farm_user_garden` VALUES ('15', '19', '0.00', '0.00', '16100.00', '0.00', '0', '0', '0.00', '600.00', '0');
INSERT INTO `farm_user_garden` VALUES ('16', '17', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('17', '20', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('20', '21', '9000.00', '9124.53', '11324.53', '0.00', '0', '0', '900.00', '0.00', '11');
INSERT INTO `farm_user_garden` VALUES ('21', '22', '6136.00', '0.00', '7676.00', '0.00', '0', '1', '0.00', '730.00', '0');
INSERT INTO `farm_user_garden` VALUES ('22', '35', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('23', '35', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('24', '33', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('25', '32', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('26', '31', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('27', '30', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('28', '29', '300.00', '0.00', '0.00', '0.00', '0', '0', '30.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('29', '28', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('30', '27', '300.00', '0.00', '0.00', '0.00', '0', '0', '30.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('31', '26', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('32', '25', '280.00', '7723.44', '7723.44', '0.00', '0', '0', '0.00', '30.00', '11');
INSERT INTO `farm_user_garden` VALUES ('33', '24', '109.00', '13200.00', '18068.00', '97.79', '1', '0', '480.10', '470.80', '11');
INSERT INTO `farm_user_garden` VALUES ('34', '36', '43.00', '0.00', '36001.01', '200.00', '2', '2', '0.00', '4500.00', '0');
INSERT INTO `farm_user_garden` VALUES ('35', '37', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('36', '38', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('37', '39', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('38', '42', '5000.00', '3024.00', '16224.00', '0.00', '0', '0', '59.98', '470.02', '4');
INSERT INTO `farm_user_garden` VALUES ('39', '43', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('40', '44', '0.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('41', '47', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('42', '48', '399.00', '9300.24', '9809.24', '0.00', '0', '0', '0.00', '10.00', '11');
INSERT INTO `farm_user_garden` VALUES ('43', '49', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('44', '50', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('45', '51', '300.00', '467.42', '467.42', '0.00', '0', '0', '30.00', '0.00', '1');
INSERT INTO `farm_user_garden` VALUES ('46', '52', '237.50', '0.00', '820.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('47', '53', '400.00', '939.33', '1339.33', '0.00', '0', '0', '30.00', '0.00', '2');
INSERT INTO `farm_user_garden` VALUES ('48', '54', '0.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('49', '56', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('50', '57', '2262.06', '1249.92', '8565.92', '48.00', '0', '0', '10.00', '0.00', '2');
INSERT INTO `farm_user_garden` VALUES ('51', '58', '300.00', '9944.71', '9944.71', '0.00', '0', '0', '30.00', '0.00', '11');
INSERT INTO `farm_user_garden` VALUES ('52', '60', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('53', '62', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('54', '63', '90.00', '0.00', '0.00', '0.00', '0', '0', '27.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('55', '64', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('56', '65', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('57', '66', '0.00', '4500.00', '7200.00', '0.00', '0', '0', '0.00', '300.00', '10');
INSERT INTO `farm_user_garden` VALUES ('58', '67', '0.00', '5033.21', '6484.21', '0.00', '1', '0', '17.62', '361.34', '10');
INSERT INTO `farm_user_garden` VALUES ('59', '68', '150.00', '300.00', '450.00', '0.00', '0', '0', '0.00', '30.00', '1');
INSERT INTO `farm_user_garden` VALUES ('60', '69', '0.00', '315.00', '315.00', '0.00', '0', '0', '0.00', '3.00', '1');
INSERT INTO `farm_user_garden` VALUES ('61', '70', '0.00', '313.56', '313.56', '0.00', '0', '0', '0.00', '0.30', '1');
INSERT INTO `farm_user_garden` VALUES ('63', '71', '200.00', '613.89', '864.06', '0.00', '0', '0', '0.00', '7.48', '1');
INSERT INTO `farm_user_garden` VALUES ('64', '72', '1.00', '301.10', '302.10', '0.00', '0', '0', '0.00', '2.10', '1');
INSERT INTO `farm_user_garden` VALUES ('65', '73', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('66', '74', '0.00', '313.09', '313.09', '0.00', '0', '0', '0.00', '1.09', '1');
INSERT INTO `farm_user_garden` VALUES ('67', '75', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('68', '76', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('69', '77', '19701.00', '10300.00', '15601.00', '0.00', '0', '0', '0.00', '1.00', '12');
INSERT INTO `farm_user_garden` VALUES ('70', '78', '300.00', '307.00', '307.00', '0.00', '1', '1', '0.00', '38.50', '1');
INSERT INTO `farm_user_garden` VALUES ('71', '79', '200.00', '2100.00', '2100.00', '0.00', '1', '1', '532.35', '96.89', '5');
INSERT INTO `farm_user_garden` VALUES ('72', '80', '0.00', '300.00', '300.00', '0.00', '0', '0', '0.00', '0.00', '1');
INSERT INTO `farm_user_garden` VALUES ('73', '81', '577.73', '24210.11', '24119.75', '48.00', '0', '2', '849.77', '6113.69', '15');
INSERT INTO `farm_user_garden` VALUES ('74', '82', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('75', '83', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('76', '84', '170.00', '313.11', '313.11', '16.00', '0', '0', '0.00', '13.11', '1');
INSERT INTO `farm_user_garden` VALUES ('78', '85', '300.00', '12588.76', '19588.76', '250.00', '1', '1', '0.00', '988.76', '13');
INSERT INTO `farm_user_garden` VALUES ('79', '86', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('80', '87', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('81', '88', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('82', '89', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('84', '90', '0.00', '3731.08', '5367.40', '32.00', '0', '0', '0.00', '382.90', '10');
INSERT INTO `farm_user_garden` VALUES ('85', '91', '0.00', '403.37', '330.35', '36.00', '0', '0', '0.00', '30.35', '1');
INSERT INTO `farm_user_garden` VALUES ('86', '92', '0.00', '343.88', '335.66', '16.00', '0', '0', '0.00', '35.66', '1');
INSERT INTO `farm_user_garden` VALUES ('87', '93', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('88', '94', '0.00', '335.24', '335.24', '0.00', '0', '0', '0.00', '35.24', '1');
INSERT INTO `farm_user_garden` VALUES ('89', '95', '111.00', '908.15', '908.15', '0.00', '0', '0', '0.00', '8.15', '3');
INSERT INTO `farm_user_garden` VALUES ('90', '96', '300.00', '0.00', '0.00', '0.00', '0', '0', '0.00', '0.00', '0');
INSERT INTO `farm_user_garden` VALUES ('91', '97', '0.00', '330.78', '330.78', '0.00', '0', '0', '0.00', '30.78', '1');
INSERT INTO `farm_user_garden` VALUES ('92', '98', '0.00', '300.00', '300.00', '0.00', '0', '0', '0.00', '0.00', '1');
INSERT INTO `farm_user_garden` VALUES ('93', '99', '0.00', '318.15', '318.15', '0.00', '0', '0', '0.00', '18.15', '1');
INSERT INTO `farm_user_garden` VALUES ('94', '100', '0.00', '326.37', '326.37', '0.00', '0', '0', '0.00', '26.37', '1');
INSERT INTO `farm_user_garden` VALUES ('95', '101', '0.00', '300.00', '300.00', '0.00', '0', '0', '0.00', '0.00', '1');
INSERT INTO `farm_user_garden` VALUES ('96', '102', '0.00', '300.00', '300.00', '0.00', '0', '0', '0.00', '0.00', '1');

-- ----------------------------
-- Table structure for `farm_user_harvest`
-- ----------------------------
DROP TABLE IF EXISTS `farm_user_harvest`;
CREATE TABLE `farm_user_harvest` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) unsigned NOT NULL,
  `friendId` int(11) unsigned NOT NULL,
  `fruitNum` varchar(11) NOT NULL COMMENT '采集果实数量',
  `createTime` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=360 DEFAULT CHARSET=utf8 COMMENT='用户采蜜表';

-- ----------------------------
-- Records of farm_user_harvest
-- ----------------------------
INSERT INTO `farm_user_harvest` VALUES ('6', '5', '3', '0.71', '1490257433');
INSERT INTO `farm_user_harvest` VALUES ('7', '5', '4', '0.3', '1490258429');
INSERT INTO `farm_user_harvest` VALUES ('8', '5', '4', '0.3', '1490318791');
INSERT INTO `farm_user_harvest` VALUES ('9', '5', '3', '0.71', '1490319161');
INSERT INTO `farm_user_harvest` VALUES ('10', '5', '3', '0.71', '1490788664');
INSERT INTO `farm_user_harvest` VALUES ('11', '5', '3', '0.71', '1490788665');
INSERT INTO `farm_user_harvest` VALUES ('12', '5', '3', '0.71', '1490846179');
INSERT INTO `farm_user_harvest` VALUES ('13', '5', '3', '0.71', '1490942462');
INSERT INTO `farm_user_harvest` VALUES ('14', '5', '4', '7.2', '1491028879');
INSERT INTO `farm_user_harvest` VALUES ('15', '5', '3', '1.71', '1491029332');
INSERT INTO `farm_user_harvest` VALUES ('16', '6', '21', '3.6', '1491357368');
INSERT INTO `farm_user_harvest` VALUES ('17', '7', '33', '6', '1491364744');
INSERT INTO `farm_user_harvest` VALUES ('18', '7', '33', '6', '1491364746');
INSERT INTO `farm_user_harvest` VALUES ('19', '7', '32', '6', '1491364757');
INSERT INTO `farm_user_harvest` VALUES ('20', '5', '4', '12', '1491370567');
INSERT INTO `farm_user_harvest` VALUES ('21', '5', '3', '2.85', '1491377632');
INSERT INTO `farm_user_harvest` VALUES ('22', '5', '3', '2.85', '1491381125');
INSERT INTO `farm_user_harvest` VALUES ('23', '5', '4', '12', '1491381125');
INSERT INTO `farm_user_harvest` VALUES ('24', '5', '3', '2.85', '1491388831');
INSERT INTO `farm_user_harvest` VALUES ('25', '5', '4', '12', '1491388831');
INSERT INTO `farm_user_harvest` VALUES ('26', '5', '3', '2.85', '1491388835');
INSERT INTO `farm_user_harvest` VALUES ('27', '5', '4', '12', '1491388835');
INSERT INTO `farm_user_harvest` VALUES ('28', '7', '25', '6', '1491444813');
INSERT INTO `farm_user_harvest` VALUES ('29', '7', '44', '0', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('30', '7', '43', '6', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('31', '7', '33', '6', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('32', '7', '32', '6', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('33', '7', '31', '6', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('34', '7', '30', '6', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('35', '7', '29', '6', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('36', '7', '28', '6', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('37', '7', '27', '6', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('38', '7', '26', '6', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('39', '7', '25', '6', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('40', '7', '24', '0', '1491445183');
INSERT INTO `farm_user_harvest` VALUES ('41', '5', '4', '12', '1491445477');
INSERT INTO `farm_user_harvest` VALUES ('42', '57', '58', '6', '1491470580');
INSERT INTO `farm_user_harvest` VALUES ('43', '57', '58', '6', '1491470632');
INSERT INTO `farm_user_harvest` VALUES ('44', '5', '3', '2.85', '1491476267');
INSERT INTO `farm_user_harvest` VALUES ('45', '5', '4', '12', '1491476267');
INSERT INTO `farm_user_harvest` VALUES ('46', '12', '60', '6', '1491530734');
INSERT INTO `farm_user_harvest` VALUES ('47', '7', '43', '6', '1491535136');
INSERT INTO `farm_user_harvest` VALUES ('48', '36', '39', '6', '1491544606');
INSERT INTO `farm_user_harvest` VALUES ('49', '36', '38', '6', '1491544606');
INSERT INTO `farm_user_harvest` VALUES ('50', '36', '37', '6', '1491544606');
INSERT INTO `farm_user_harvest` VALUES ('51', '36', '62', '6', '1491549191');
INSERT INTO `farm_user_harvest` VALUES ('52', '36', '39', '6', '1491549192');
INSERT INTO `farm_user_harvest` VALUES ('53', '36', '38', '6', '1491549192');
INSERT INTO `farm_user_harvest` VALUES ('54', '36', '37', '6', '1491549192');
INSERT INTO `farm_user_harvest` VALUES ('55', '36', '62', '6', '1491551972');
INSERT INTO `farm_user_harvest` VALUES ('56', '36', '39', '6', '1491551972');
INSERT INTO `farm_user_harvest` VALUES ('57', '36', '38', '6', '1491551973');
INSERT INTO `farm_user_harvest` VALUES ('58', '36', '37', '6', '1491551973');
INSERT INTO `farm_user_harvest` VALUES ('59', '7', '49', '6', '1491551989');
INSERT INTO `farm_user_harvest` VALUES ('60', '7', '31', '6', '1491557054');
INSERT INTO `farm_user_harvest` VALUES ('61', '14', '50', '6', '1491557453');
INSERT INTO `farm_user_harvest` VALUES ('62', '7', '64', '6', '1491787849');
INSERT INTO `farm_user_harvest` VALUES ('63', '67', '68', '6', '1491815867');
INSERT INTO `farm_user_harvest` VALUES ('64', '67', '69', '0.6', '1491816284');
INSERT INTO `farm_user_harvest` VALUES ('65', '81', '84', '0.81', '1492738297');
INSERT INTO `farm_user_harvest` VALUES ('66', '85', '89', '0', '1492753490');
INSERT INTO `farm_user_harvest` VALUES ('67', '85', '88', '0', '1492753490');
INSERT INTO `farm_user_harvest` VALUES ('68', '85', '87', '0', '1492753490');
INSERT INTO `farm_user_harvest` VALUES ('69', '85', '86', '0', '1492753490');
INSERT INTO `farm_user_harvest` VALUES ('70', '81', '84', '0.82', '1492826371');
INSERT INTO `farm_user_harvest` VALUES ('71', '81', '84', '0.82', '1492826380');
INSERT INTO `farm_user_harvest` VALUES ('72', '81', '84', '0.82', '1492923860');
INSERT INTO `farm_user_harvest` VALUES ('73', '81', '90', '0.81', '1492989582');
INSERT INTO `farm_user_harvest` VALUES ('74', '81', '84', '0.82', '1492989609');
INSERT INTO `farm_user_harvest` VALUES ('75', '81', '84', '0.82', '1493103734');
INSERT INTO `farm_user_harvest` VALUES ('76', '81', '90', '0.88', '1493687361');
INSERT INTO `farm_user_harvest` VALUES ('77', '81', '84', '0.82', '1493687393');
INSERT INTO `farm_user_harvest` VALUES ('78', '91', '97', '0', '1493775410');
INSERT INTO `farm_user_harvest` VALUES ('79', '90', '95', '0.32', '1493782892');
INSERT INTO `farm_user_harvest` VALUES ('80', '90', '95', '0.32', '1493782894');
INSERT INTO `farm_user_harvest` VALUES ('81', '90', '95', '0.32', '1493782895');
INSERT INTO `farm_user_harvest` VALUES ('82', '90', '95', '0.32', '1493782896');
INSERT INTO `farm_user_harvest` VALUES ('83', '90', '95', '0.32', '1493782897');
INSERT INTO `farm_user_harvest` VALUES ('84', '90', '95', '0.32', '1493782898');
INSERT INTO `farm_user_harvest` VALUES ('85', '90', '95', '0.32', '1493782899');
INSERT INTO `farm_user_harvest` VALUES ('86', '90', '95', '0.32', '1493782901');
INSERT INTO `farm_user_harvest` VALUES ('87', '90', '95', '0.32', '1493782902');
INSERT INTO `farm_user_harvest` VALUES ('88', '91', '97', '0.32', '1493849856');
INSERT INTO `farm_user_harvest` VALUES ('89', '91', '97', '0.32', '1493849858');
INSERT INTO `farm_user_harvest` VALUES ('90', '91', '97', '0.32', '1493849859');
INSERT INTO `farm_user_harvest` VALUES ('91', '91', '97', '0.32', '1493849860');
INSERT INTO `farm_user_harvest` VALUES ('92', '91', '97', '0.32', '1493849862');
INSERT INTO `farm_user_harvest` VALUES ('93', '91', '97', '0.32', '1493849863');
INSERT INTO `farm_user_harvest` VALUES ('94', '91', '97', '0.32', '1493849864');
INSERT INTO `farm_user_harvest` VALUES ('95', '91', '97', '0.32', '1493849865');
INSERT INTO `farm_user_harvest` VALUES ('96', '91', '97', '0.32', '1493849866');
INSERT INTO `farm_user_harvest` VALUES ('97', '91', '97', '0.32', '1493849867');
INSERT INTO `farm_user_harvest` VALUES ('98', '91', '97', '0.32', '1493849868');
INSERT INTO `farm_user_harvest` VALUES ('99', '91', '97', '0.32', '1493849869');
INSERT INTO `farm_user_harvest` VALUES ('100', '91', '97', '0.32', '1493849870');
INSERT INTO `farm_user_harvest` VALUES ('101', '91', '97', '0.32', '1493849871');
INSERT INTO `farm_user_harvest` VALUES ('102', '91', '97', '0.32', '1493849873');
INSERT INTO `farm_user_harvest` VALUES ('103', '91', '97', '0.32', '1493849874');
INSERT INTO `farm_user_harvest` VALUES ('104', '91', '97', '0.32', '1493849875');
INSERT INTO `farm_user_harvest` VALUES ('105', '91', '97', '0.32', '1493849876');
INSERT INTO `farm_user_harvest` VALUES ('106', '91', '97', '0.32', '1493849877');
INSERT INTO `farm_user_harvest` VALUES ('107', '91', '97', '0.32', '1493849878');
INSERT INTO `farm_user_harvest` VALUES ('108', '91', '97', '0.32', '1493849879');
INSERT INTO `farm_user_harvest` VALUES ('109', '91', '97', '0.32', '1493849881');
INSERT INTO `farm_user_harvest` VALUES ('110', '91', '97', '0.32', '1493849882');
INSERT INTO `farm_user_harvest` VALUES ('111', '91', '97', '0.32', '1493849883');
INSERT INTO `farm_user_harvest` VALUES ('112', '91', '97', '0.32', '1493849884');
INSERT INTO `farm_user_harvest` VALUES ('113', '91', '97', '0.32', '1493849885');
INSERT INTO `farm_user_harvest` VALUES ('114', '91', '97', '0.32', '1493849886');
INSERT INTO `farm_user_harvest` VALUES ('115', '91', '97', '0.32', '1493849887');
INSERT INTO `farm_user_harvest` VALUES ('116', '91', '97', '0.32', '1493849888');
INSERT INTO `farm_user_harvest` VALUES ('117', '91', '97', '0.32', '1493849890');
INSERT INTO `farm_user_harvest` VALUES ('118', '91', '97', '0.32', '1493849891');
INSERT INTO `farm_user_harvest` VALUES ('119', '91', '97', '0.32', '1493849892');
INSERT INTO `farm_user_harvest` VALUES ('120', '90', '95', '0.41', '1493938242');
INSERT INTO `farm_user_harvest` VALUES ('121', '90', '95', '0.41', '1493938252');
INSERT INTO `farm_user_harvest` VALUES ('122', '90', '99', '0.41', '1493938311');
INSERT INTO `farm_user_harvest` VALUES ('123', '90', '99', '0.41', '1493938316');
INSERT INTO `farm_user_harvest` VALUES ('124', '90', '99', '0.41', '1493938317');
INSERT INTO `farm_user_harvest` VALUES ('125', '90', '99', '0.41', '1493938318');
INSERT INTO `farm_user_harvest` VALUES ('126', '90', '99', '0.41', '1493938319');
INSERT INTO `farm_user_harvest` VALUES ('127', '90', '99', '0.41', '1493938320');
INSERT INTO `farm_user_harvest` VALUES ('128', '90', '99', '0.41', '1493938321');
INSERT INTO `farm_user_harvest` VALUES ('129', '92', '100', '0.41', '1493940445');
INSERT INTO `farm_user_harvest` VALUES ('130', '81', '92', '0.42', '1493955695');
INSERT INTO `farm_user_harvest` VALUES ('131', '81', '91', '0.42', '1493955695');
INSERT INTO `farm_user_harvest` VALUES ('132', '81', '90', '1.84', '1493955695');
INSERT INTO `farm_user_harvest` VALUES ('133', '81', '84', '0.42', '1493955695');
INSERT INTO `farm_user_harvest` VALUES ('134', '91', '97', '0.41', '1493973358');
INSERT INTO `farm_user_harvest` VALUES ('135', '91', '97', '0.41', '1493973360');
INSERT INTO `farm_user_harvest` VALUES ('136', '91', '97', '0.41', '1493973361');
INSERT INTO `farm_user_harvest` VALUES ('137', '91', '97', '0.41', '1493973363');
INSERT INTO `farm_user_harvest` VALUES ('138', '91', '97', '0.41', '1493973364');
INSERT INTO `farm_user_harvest` VALUES ('139', '91', '97', '0.41', '1493973365');
INSERT INTO `farm_user_harvest` VALUES ('140', '91', '97', '0.41', '1493973366');
INSERT INTO `farm_user_harvest` VALUES ('141', '91', '97', '0.41', '1493973367');
INSERT INTO `farm_user_harvest` VALUES ('142', '91', '97', '0.41', '1493973368');
INSERT INTO `farm_user_harvest` VALUES ('143', '91', '97', '0.41', '1493973369');
INSERT INTO `farm_user_harvest` VALUES ('144', '91', '97', '0.41', '1493973370');
INSERT INTO `farm_user_harvest` VALUES ('145', '91', '97', '0.41', '1493973371');
INSERT INTO `farm_user_harvest` VALUES ('146', '91', '97', '0.41', '1493973372');
INSERT INTO `farm_user_harvest` VALUES ('147', '91', '97', '0.41', '1493973374');
INSERT INTO `farm_user_harvest` VALUES ('148', '91', '97', '0.41', '1493973375');
INSERT INTO `farm_user_harvest` VALUES ('149', '91', '97', '0.41', '1493973376');
INSERT INTO `farm_user_harvest` VALUES ('150', '91', '97', '0.41', '1493973377');
INSERT INTO `farm_user_harvest` VALUES ('151', '91', '97', '0.41', '1493973378');
INSERT INTO `farm_user_harvest` VALUES ('152', '91', '97', '0.41', '1493973379');
INSERT INTO `farm_user_harvest` VALUES ('153', '91', '97', '0.41', '1493973380');
INSERT INTO `farm_user_harvest` VALUES ('154', '91', '97', '0.41', '1493973381');
INSERT INTO `farm_user_harvest` VALUES ('155', '91', '97', '0.41', '1493973382');
INSERT INTO `farm_user_harvest` VALUES ('156', '91', '97', '0.41', '1493973383');
INSERT INTO `farm_user_harvest` VALUES ('157', '91', '97', '0.41', '1493973387');
INSERT INTO `farm_user_harvest` VALUES ('158', '91', '97', '0.41', '1493973388');
INSERT INTO `farm_user_harvest` VALUES ('159', '81', '92', '0.73', '1494034028');
INSERT INTO `farm_user_harvest` VALUES ('160', '81', '91', '0.77', '1494034028');
INSERT INTO `farm_user_harvest` VALUES ('161', '81', '90', '14.5', '1494034028');
INSERT INTO `farm_user_harvest` VALUES ('162', '81', '84', '0.71', '1494034028');
INSERT INTO `farm_user_harvest` VALUES ('163', '90', '99', '0.71', '1494034601');
INSERT INTO `farm_user_harvest` VALUES ('164', '90', '95', '2.11', '1494034624');
INSERT INTO `farm_user_harvest` VALUES ('165', '92', '100', '0.71', '1494041747');
INSERT INTO `farm_user_harvest` VALUES ('166', '92', '100', '0.71', '1494041750');
INSERT INTO `farm_user_harvest` VALUES ('167', '92', '100', '0.71', '1494041752');
INSERT INTO `farm_user_harvest` VALUES ('168', '92', '100', '0.71', '1494041755');
INSERT INTO `farm_user_harvest` VALUES ('169', '92', '100', '0.71', '1494041766');
INSERT INTO `farm_user_harvest` VALUES ('170', '92', '100', '0.71', '1494041768');
INSERT INTO `farm_user_harvest` VALUES ('171', '92', '100', '0.71', '1494041781');
INSERT INTO `farm_user_harvest` VALUES ('172', '92', '100', '0.71', '1494041787');
INSERT INTO `farm_user_harvest` VALUES ('173', '92', '100', '0.71', '1494041789');
INSERT INTO `farm_user_harvest` VALUES ('174', '92', '100', '0.71', '1494041790');
INSERT INTO `farm_user_harvest` VALUES ('175', '92', '100', '0.71', '1494041791');
INSERT INTO `farm_user_harvest` VALUES ('176', '91', '97', '0.51', '1494111294');
INSERT INTO `farm_user_harvest` VALUES ('177', '91', '97', '0.51', '1494111295');
INSERT INTO `farm_user_harvest` VALUES ('178', '91', '97', '0.51', '1494111296');
INSERT INTO `farm_user_harvest` VALUES ('179', '91', '97', '0.51', '1494111297');
INSERT INTO `farm_user_harvest` VALUES ('180', '91', '97', '0.51', '1494111298');
INSERT INTO `farm_user_harvest` VALUES ('181', '91', '97', '0.51', '1494111299');
INSERT INTO `farm_user_harvest` VALUES ('182', '91', '97', '0.51', '1494111300');
INSERT INTO `farm_user_harvest` VALUES ('183', '91', '97', '0.51', '1494111301');
INSERT INTO `farm_user_harvest` VALUES ('184', '91', '97', '0.51', '1494111303');
INSERT INTO `farm_user_harvest` VALUES ('185', '91', '97', '0.51', '1494111304');
INSERT INTO `farm_user_harvest` VALUES ('186', '91', '97', '0.51', '1494111305');
INSERT INTO `farm_user_harvest` VALUES ('187', '91', '97', '0.51', '1494111306');
INSERT INTO `farm_user_harvest` VALUES ('188', '91', '97', '0.51', '1494111307');
INSERT INTO `farm_user_harvest` VALUES ('189', '91', '97', '0.51', '1494111308');
INSERT INTO `farm_user_harvest` VALUES ('190', '91', '97', '0.51', '1494111309');
INSERT INTO `farm_user_harvest` VALUES ('191', '91', '97', '0.51', '1494111310');
INSERT INTO `farm_user_harvest` VALUES ('192', '91', '97', '0.51', '1494111312');
INSERT INTO `farm_user_harvest` VALUES ('193', '91', '97', '0.51', '1494111313');
INSERT INTO `farm_user_harvest` VALUES ('194', '91', '97', '0.51', '1494111314');
INSERT INTO `farm_user_harvest` VALUES ('195', '91', '97', '0.51', '1494111315');
INSERT INTO `farm_user_harvest` VALUES ('196', '91', '97', '0.51', '1494111316');
INSERT INTO `farm_user_harvest` VALUES ('197', '91', '97', '0.51', '1494111317');
INSERT INTO `farm_user_harvest` VALUES ('198', '91', '97', '0.51', '1494111318');
INSERT INTO `farm_user_harvest` VALUES ('199', '91', '97', '0.51', '1494111320');
INSERT INTO `farm_user_harvest` VALUES ('200', '91', '97', '0.51', '1494111321');
INSERT INTO `farm_user_harvest` VALUES ('201', '91', '97', '0.51', '1494111322');
INSERT INTO `farm_user_harvest` VALUES ('202', '91', '97', '0.51', '1494111323');
INSERT INTO `farm_user_harvest` VALUES ('203', '91', '97', '0.51', '1494111324');
INSERT INTO `farm_user_harvest` VALUES ('204', '91', '97', '0.51', '1494111325');
INSERT INTO `farm_user_harvest` VALUES ('205', '91', '97', '0.51', '1494111326');
INSERT INTO `farm_user_harvest` VALUES ('206', '91', '97', '0.51', '1494111327');
INSERT INTO `farm_user_harvest` VALUES ('207', '91', '97', '0.51', '1494111328');
INSERT INTO `farm_user_harvest` VALUES ('208', '91', '97', '0.51', '1494111329');
INSERT INTO `farm_user_harvest` VALUES ('209', '91', '97', '0.51', '1494111330');
INSERT INTO `farm_user_harvest` VALUES ('210', '91', '97', '0.51', '1494111331');
INSERT INTO `farm_user_harvest` VALUES ('211', '91', '97', '0.51', '1494111333');
INSERT INTO `farm_user_harvest` VALUES ('212', '91', '97', '0.51', '1494111334');
INSERT INTO `farm_user_harvest` VALUES ('213', '91', '97', '0.51', '1494111335');
INSERT INTO `farm_user_harvest` VALUES ('214', '91', '97', '0.51', '1494111336');
INSERT INTO `farm_user_harvest` VALUES ('215', '91', '97', '0.51', '1494111337');
INSERT INTO `farm_user_harvest` VALUES ('216', '91', '97', '0.51', '1494111338');
INSERT INTO `farm_user_harvest` VALUES ('217', '91', '97', '0.51', '1494111339');
INSERT INTO `farm_user_harvest` VALUES ('218', '91', '97', '0.51', '1494111340');
INSERT INTO `farm_user_harvest` VALUES ('219', '91', '97', '0.51', '1494111341');
INSERT INTO `farm_user_harvest` VALUES ('220', '91', '97', '0.51', '1494111342');
INSERT INTO `farm_user_harvest` VALUES ('221', '91', '97', '0.51', '1494111343');
INSERT INTO `farm_user_harvest` VALUES ('222', '91', '97', '0.51', '1494111344');
INSERT INTO `farm_user_harvest` VALUES ('223', '91', '97', '0.51', '1494111346');
INSERT INTO `farm_user_harvest` VALUES ('224', '91', '97', '0.51', '1494111347');
INSERT INTO `farm_user_harvest` VALUES ('225', '91', '97', '0.51', '1494111348');
INSERT INTO `farm_user_harvest` VALUES ('226', '91', '97', '0.51', '1494111349');
INSERT INTO `farm_user_harvest` VALUES ('227', '91', '97', '0.51', '1494111350');
INSERT INTO `farm_user_harvest` VALUES ('228', '91', '97', '0.51', '1494111351');
INSERT INTO `farm_user_harvest` VALUES ('229', '91', '97', '0.51', '1494111352');
INSERT INTO `farm_user_harvest` VALUES ('230', '91', '97', '0.51', '1494111354');
INSERT INTO `farm_user_harvest` VALUES ('231', '91', '97', '0.51', '1494111355');
INSERT INTO `farm_user_harvest` VALUES ('232', '91', '97', '0.51', '1494111356');
INSERT INTO `farm_user_harvest` VALUES ('233', '91', '97', '0.51', '1494111357');
INSERT INTO `farm_user_harvest` VALUES ('234', '91', '97', '0.51', '1494111358');
INSERT INTO `farm_user_harvest` VALUES ('235', '91', '97', '0.51', '1494111359');
INSERT INTO `farm_user_harvest` VALUES ('236', '91', '97', '0.51', '1494111360');
INSERT INTO `farm_user_harvest` VALUES ('237', '91', '97', '0.51', '1494111361');
INSERT INTO `farm_user_harvest` VALUES ('238', '91', '97', '0.51', '1494111362');
INSERT INTO `farm_user_harvest` VALUES ('239', '91', '97', '0.51', '1494111364');
INSERT INTO `farm_user_harvest` VALUES ('240', '91', '97', '0.51', '1494111365');
INSERT INTO `farm_user_harvest` VALUES ('241', '91', '97', '0.51', '1494111366');
INSERT INTO `farm_user_harvest` VALUES ('242', '91', '97', '0.51', '1494111367');
INSERT INTO `farm_user_harvest` VALUES ('243', '91', '97', '0.51', '1494111368');
INSERT INTO `farm_user_harvest` VALUES ('244', '91', '97', '0.51', '1494111369');
INSERT INTO `farm_user_harvest` VALUES ('245', '91', '97', '0.51', '1494111370');
INSERT INTO `farm_user_harvest` VALUES ('246', '91', '97', '0.51', '1494111371');
INSERT INTO `farm_user_harvest` VALUES ('247', '91', '97', '0.51', '1494111372');
INSERT INTO `farm_user_harvest` VALUES ('248', '91', '97', '0.51', '1494111373');
INSERT INTO `farm_user_harvest` VALUES ('249', '91', '97', '0.51', '1494111374');
INSERT INTO `farm_user_harvest` VALUES ('250', '91', '97', '0.51', '1494111376');
INSERT INTO `farm_user_harvest` VALUES ('251', '91', '97', '0.51', '1494111377');
INSERT INTO `farm_user_harvest` VALUES ('252', '91', '97', '0.51', '1494111378');
INSERT INTO `farm_user_harvest` VALUES ('253', '91', '97', '0.51', '1494111379');
INSERT INTO `farm_user_harvest` VALUES ('254', '91', '97', '0.51', '1494111380');
INSERT INTO `farm_user_harvest` VALUES ('255', '91', '97', '0.51', '1494111381');
INSERT INTO `farm_user_harvest` VALUES ('256', '91', '97', '0.51', '1494111382');
INSERT INTO `farm_user_harvest` VALUES ('257', '91', '97', '0.51', '1494111383');
INSERT INTO `farm_user_harvest` VALUES ('258', '91', '97', '0.51', '1494111384');
INSERT INTO `farm_user_harvest` VALUES ('259', '91', '97', '0.51', '1494111385');
INSERT INTO `farm_user_harvest` VALUES ('260', '91', '97', '0.51', '1494111387');
INSERT INTO `farm_user_harvest` VALUES ('261', '91', '97', '0.51', '1494111388');
INSERT INTO `farm_user_harvest` VALUES ('262', '91', '97', '0.51', '1494111389');
INSERT INTO `farm_user_harvest` VALUES ('263', '91', '97', '0.51', '1494111390');
INSERT INTO `farm_user_harvest` VALUES ('264', '91', '97', '0.51', '1494111391');
INSERT INTO `farm_user_harvest` VALUES ('265', '91', '97', '0.51', '1494111392');
INSERT INTO `farm_user_harvest` VALUES ('266', '91', '97', '0.51', '1494111393');
INSERT INTO `farm_user_harvest` VALUES ('267', '91', '97', '0.51', '1494111394');
INSERT INTO `farm_user_harvest` VALUES ('268', '91', '97', '0.51', '1494111395');
INSERT INTO `farm_user_harvest` VALUES ('269', '91', '97', '0.51', '1494111396');
INSERT INTO `farm_user_harvest` VALUES ('270', '91', '97', '0.51', '1494111397');
INSERT INTO `farm_user_harvest` VALUES ('271', '91', '97', '0.51', '1494111399');
INSERT INTO `farm_user_harvest` VALUES ('272', '91', '97', '0.51', '1494111401');
INSERT INTO `farm_user_harvest` VALUES ('273', '91', '97', '0.51', '1494111402');
INSERT INTO `farm_user_harvest` VALUES ('274', '91', '97', '0.51', '1494111403');
INSERT INTO `farm_user_harvest` VALUES ('275', '91', '97', '0.51', '1494111404');
INSERT INTO `farm_user_harvest` VALUES ('276', '91', '97', '0.51', '1494111406');
INSERT INTO `farm_user_harvest` VALUES ('277', '91', '97', '0.51', '1494111407');
INSERT INTO `farm_user_harvest` VALUES ('278', '91', '97', '0.51', '1494111408');
INSERT INTO `farm_user_harvest` VALUES ('279', '90', '95', '1.46', '1494113754');
INSERT INTO `farm_user_harvest` VALUES ('280', '90', '95', '1.46', '1494113763');
INSERT INTO `farm_user_harvest` VALUES ('281', '90', '95', '1.46', '1494113766');
INSERT INTO `farm_user_harvest` VALUES ('282', '90', '95', '1.46', '1494113767');
INSERT INTO `farm_user_harvest` VALUES ('283', '90', '95', '1.46', '1494113768');
INSERT INTO `farm_user_harvest` VALUES ('284', '90', '95', '1.46', '1494113769');
INSERT INTO `farm_user_harvest` VALUES ('285', '90', '95', '1.46', '1494113770');
INSERT INTO `farm_user_harvest` VALUES ('286', '90', '95', '1.46', '1494113771');
INSERT INTO `farm_user_harvest` VALUES ('287', '90', '95', '1.46', '1494113773');
INSERT INTO `farm_user_harvest` VALUES ('288', '90', '95', '1.46', '1494113774');
INSERT INTO `farm_user_harvest` VALUES ('289', '90', '95', '1.46', '1494113775');
INSERT INTO `farm_user_harvest` VALUES ('290', '90', '95', '1.46', '1494113777');
INSERT INTO `farm_user_harvest` VALUES ('291', '90', '95', '1.46', '1494113778');
INSERT INTO `farm_user_harvest` VALUES ('292', '90', '95', '1.46', '1494113779');
INSERT INTO `farm_user_harvest` VALUES ('293', '90', '95', '1.46', '1494113780');
INSERT INTO `farm_user_harvest` VALUES ('294', '90', '95', '1.46', '1494113781');
INSERT INTO `farm_user_harvest` VALUES ('295', '90', '95', '1.46', '1494113782');
INSERT INTO `farm_user_harvest` VALUES ('296', '90', '99', '0.5', '1494113810');
INSERT INTO `farm_user_harvest` VALUES ('297', '90', '99', '0.5', '1494113811');
INSERT INTO `farm_user_harvest` VALUES ('298', '90', '99', '0.5', '1494113812');
INSERT INTO `farm_user_harvest` VALUES ('299', '90', '99', '0.5', '1494113813');
INSERT INTO `farm_user_harvest` VALUES ('300', '90', '99', '0.5', '1494113815');
INSERT INTO `farm_user_harvest` VALUES ('301', '90', '99', '0.5', '1494113816');
INSERT INTO `farm_user_harvest` VALUES ('302', '90', '99', '0.5', '1494113817');
INSERT INTO `farm_user_harvest` VALUES ('303', '90', '99', '0.5', '1494113818');
INSERT INTO `farm_user_harvest` VALUES ('304', '90', '99', '0.5', '1494113819');
INSERT INTO `farm_user_harvest` VALUES ('305', '90', '99', '0.5', '1494113820');
INSERT INTO `farm_user_harvest` VALUES ('306', '90', '99', '0.5', '1494113821');
INSERT INTO `farm_user_harvest` VALUES ('307', '90', '99', '0.5', '1494113822');
INSERT INTO `farm_user_harvest` VALUES ('308', '90', '99', '0.5', '1494113823');
INSERT INTO `farm_user_harvest` VALUES ('309', '90', '99', '0.5', '1494113825');
INSERT INTO `farm_user_harvest` VALUES ('310', '90', '99', '0.5', '1494113826');
INSERT INTO `farm_user_harvest` VALUES ('311', '90', '99', '0.5', '1494113827');
INSERT INTO `farm_user_harvest` VALUES ('312', '90', '99', '0.5', '1494113828');
INSERT INTO `farm_user_harvest` VALUES ('313', '90', '99', '0.5', '1494113829');
INSERT INTO `farm_user_harvest` VALUES ('314', '90', '99', '0.5', '1494113830');
INSERT INTO `farm_user_harvest` VALUES ('315', '90', '99', '0.5', '1494113831');
INSERT INTO `farm_user_harvest` VALUES ('316', '90', '99', '0.5', '1494113832');
INSERT INTO `farm_user_harvest` VALUES ('317', '90', '99', '0.5', '1494113833');
INSERT INTO `farm_user_harvest` VALUES ('318', '90', '99', '0.5', '1494113834');
INSERT INTO `farm_user_harvest` VALUES ('319', '90', '99', '0.5', '1494113835');
INSERT INTO `farm_user_harvest` VALUES ('320', '90', '99', '0.5', '1494113836');
INSERT INTO `farm_user_harvest` VALUES ('321', '90', '99', '0.5', '1494113837');
INSERT INTO `farm_user_harvest` VALUES ('322', '90', '99', '0.5', '1494113839');
INSERT INTO `farm_user_harvest` VALUES ('323', '90', '99', '0.5', '1494113840');
INSERT INTO `farm_user_harvest` VALUES ('324', '90', '99', '0.5', '1494113841');
INSERT INTO `farm_user_harvest` VALUES ('325', '90', '99', '0.5', '1494113842');
INSERT INTO `farm_user_harvest` VALUES ('326', '90', '99', '0.5', '1494113843');
INSERT INTO `farm_user_harvest` VALUES ('327', '92', '100', '0.5', '1494114420');
INSERT INTO `farm_user_harvest` VALUES ('328', '92', '100', '0.5', '1494114421');
INSERT INTO `farm_user_harvest` VALUES ('329', '81', '91', '0.05', '1494115632');
INSERT INTO `farm_user_harvest` VALUES ('330', '81', '91', '0.05', '1494115633');
INSERT INTO `farm_user_harvest` VALUES ('331', '81', '91', '0.05', '1494115634');
INSERT INTO `farm_user_harvest` VALUES ('332', '81', '91', '0.05', '1494115636');
INSERT INTO `farm_user_harvest` VALUES ('333', '81', '91', '0.05', '1494115637');
INSERT INTO `farm_user_harvest` VALUES ('334', '81', '91', '0.05', '1494115639');
INSERT INTO `farm_user_harvest` VALUES ('335', '81', '91', '0.05', '1494115640');
INSERT INTO `farm_user_harvest` VALUES ('336', '81', '91', '0.05', '1494115641');
INSERT INTO `farm_user_harvest` VALUES ('337', '81', '91', '0.05', '1494115644');
INSERT INTO `farm_user_harvest` VALUES ('338', '81', '91', '0.05', '1494115645');
INSERT INTO `farm_user_harvest` VALUES ('339', '81', '91', '0.05', '1494115646');
INSERT INTO `farm_user_harvest` VALUES ('340', '81', '92', '0.05', '1494115693');
INSERT INTO `farm_user_harvest` VALUES ('341', '81', '92', '0.05', '1494115694');
INSERT INTO `farm_user_harvest` VALUES ('342', '81', '92', '0.05', '1494115696');
INSERT INTO `farm_user_harvest` VALUES ('343', '81', '92', '0.05', '1494115697');
INSERT INTO `farm_user_harvest` VALUES ('344', '81', '92', '0.05', '1494115698');
INSERT INTO `farm_user_harvest` VALUES ('345', '81', '92', '0.05', '1494115699');
INSERT INTO `farm_user_harvest` VALUES ('346', '81', '92', '0.05', '1494115700');
INSERT INTO `farm_user_harvest` VALUES ('347', '81', '92', '0.05', '1494115701');
INSERT INTO `farm_user_harvest` VALUES ('348', '81', '92', '0.05', '1494115702');
INSERT INTO `farm_user_harvest` VALUES ('349', '81', '92', '0.05', '1494115704');
INSERT INTO `farm_user_harvest` VALUES ('350', '81', '92', '0.05', '1494115705');
INSERT INTO `farm_user_harvest` VALUES ('351', '81', '92', '0.05', '1494115706');
INSERT INTO `farm_user_harvest` VALUES ('352', '81', '92', '0.05', '1494115707');
INSERT INTO `farm_user_harvest` VALUES ('353', '90', '99', '0.51', '1494285747');
INSERT INTO `farm_user_harvest` VALUES ('354', '81', '92', '0.54', '1494285799');
INSERT INTO `farm_user_harvest` VALUES ('355', '90', '95', '1.46', '1494285851');
INSERT INTO `farm_user_harvest` VALUES ('356', '81', '91', '0.64', '1494285880');
INSERT INTO `farm_user_harvest` VALUES ('357', '81', '90', '5.85', '1494286046');
INSERT INTO `farm_user_harvest` VALUES ('358', '91', '97', '0', '1494287331');
INSERT INTO `farm_user_harvest` VALUES ('359', '81', '84', '0.05', '1494289901');

-- ----------------------------
-- Table structure for `farm_user_land`
-- ----------------------------
DROP TABLE IF EXISTS `farm_user_land`;
CREATE TABLE `farm_user_land` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `landId` tinyint(2) unsigned NOT NULL COMMENT '土地编号',
  `fruitNum` decimal(10,2) unsigned NOT NULL COMMENT '果实数量',
  `totalNum` decimal(10,2) unsigned NOT NULL COMMENT '总共数量',
  `createTime` int(11) unsigned NOT NULL,
  `updateTime` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=604 DEFAULT CHARSET=utf8 COMMENT='用户土地表';

-- ----------------------------
-- Records of farm_user_land
-- ----------------------------
INSERT INTO `farm_user_land` VALUES ('1', '3', '1', '579.17', '841.34', '0', '0');
INSERT INTO `farm_user_land` VALUES ('2', '4', '1', '401.46', '1703.46', '0', '0');
INSERT INTO `farm_user_land` VALUES ('5', '4', '2', '1200.00', '1200.00', '1490683928', '1490683928');
INSERT INTO `farm_user_land` VALUES ('6', '4', '3', '1052.88', '1652.88', '1490684790', '1490684790');
INSERT INTO `farm_user_land` VALUES ('7', '4', '4', '900.00', '1500.00', '1490685769', '1490685769');
INSERT INTO `farm_user_land` VALUES ('8', '4', '5', '469.66', '469.66', '1490687243', '1490687243');
INSERT INTO `farm_user_land` VALUES ('9', '6', '1', '1200.00', '1800.00', '1490859541', '1490859541');
INSERT INTO `farm_user_land` VALUES ('10', '6', '2', '900.00', '1800.00', '1490930175', '1490930175');
INSERT INTO `farm_user_land` VALUES ('11', '6', '3', '900.00', '1800.00', '1490930219', '1490930219');
INSERT INTO `farm_user_land` VALUES ('12', '6', '4', '900.00', '1800.00', '1490930475', '1490930475');
INSERT INTO `farm_user_land` VALUES ('13', '6', '5', '900.00', '900.00', '1490930598', '1490930598');
INSERT INTO `farm_user_land` VALUES ('14', '6', '6', '300.00', '900.00', '1490930605', '1490930605');
INSERT INTO `farm_user_land` VALUES ('15', '6', '7', '800.00', '900.00', '1490930608', '1490930608');
INSERT INTO `farm_user_land` VALUES ('16', '6', '8', '900.00', '1200.00', '1490930618', '1490930618');
INSERT INTO `farm_user_land` VALUES ('17', '6', '9', '900.00', '1400.00', '1490930620', '1490930620');
INSERT INTO `farm_user_land` VALUES ('18', '6', '10', '900.00', '900.00', '1490930621', '1490930621');
INSERT INTO `farm_user_land` VALUES ('24', '6', '11', '3000.00', '9000.00', '1490933531', '1490933531');
INSERT INTO `farm_user_land` VALUES ('25', '6', '12', '3200.00', '15200.00', '1490939638', '1490939638');
INSERT INTO `farm_user_land` VALUES ('26', '6', '13', '3200.00', '15200.00', '1490939640', '1490939640');
INSERT INTO `farm_user_land` VALUES ('27', '6', '14', '3200.00', '9200.00', '1490939645', '1490939645');
INSERT INTO `farm_user_land` VALUES ('28', '6', '15', '3100.00', '9300.00', '1490939647', '1490939647');
INSERT INTO `farm_user_land` VALUES ('30', '4', '6', '401.46', '401.46', '1490944472', '1490944472');
INSERT INTO `farm_user_land` VALUES ('31', '9', '1', '900.00', '900.00', '1490946368', '1490946368');
INSERT INTO `farm_user_land` VALUES ('32', '9', '2', '401.46', '401.46', '1490946373', '1490946373');
INSERT INTO `farm_user_land` VALUES ('43', '11', '1', '900.00', '900.00', '1490953868', '1490953868');
INSERT INTO `farm_user_land` VALUES ('44', '11', '2', '440.79', '450.79', '1490953870', '1490953870');
INSERT INTO `farm_user_land` VALUES ('45', '11', '3', '440.79', '440.79', '1490953871', '1490953871');
INSERT INTO `farm_user_land` VALUES ('46', '11', '4', '440.79', '440.79', '1490953877', '1490953877');
INSERT INTO `farm_user_land` VALUES ('47', '11', '5', '440.79', '440.79', '1490953878', '1490953878');
INSERT INTO `farm_user_land` VALUES ('48', '11', '6', '440.79', '440.79', '1490953896', '1490953896');
INSERT INTO `farm_user_land` VALUES ('49', '11', '7', '440.79', '440.79', '1490953898', '1490953898');
INSERT INTO `farm_user_land` VALUES ('50', '11', '8', '440.79', '440.79', '1490953899', '1490953899');
INSERT INTO `farm_user_land` VALUES ('51', '11', '9', '440.79', '440.79', '1490953905', '1490953905');
INSERT INTO `farm_user_land` VALUES ('52', '11', '10', '440.79', '440.79', '1490953906', '1490953906');
INSERT INTO `farm_user_land` VALUES ('53', '11', '11', '4407.99', '4407.99', '1490953975', '1490953975');
INSERT INTO `farm_user_land` VALUES ('66', '13', '1', '900.00', '900.00', '1490954553', '1490954553');
INSERT INTO `farm_user_land` VALUES ('67', '13', '2', '339.90', '339.90', '1490954555', '1490954555');
INSERT INTO `farm_user_land` VALUES ('68', '13', '3', '339.90', '339.90', '1490954556', '1490954556');
INSERT INTO `farm_user_land` VALUES ('69', '13', '4', '339.90', '339.90', '1490954557', '1490954557');
INSERT INTO `farm_user_land` VALUES ('70', '13', '5', '339.90', '339.90', '1490954563', '1490954563');
INSERT INTO `farm_user_land` VALUES ('71', '13', '6', '339.90', '939.90', '1490954616', '1490954616');
INSERT INTO `farm_user_land` VALUES ('72', '13', '7', '339.90', '339.90', '1490954622', '1490954622');
INSERT INTO `farm_user_land` VALUES ('73', '13', '8', '339.90', '339.90', '1490954623', '1490954623');
INSERT INTO `farm_user_land` VALUES ('74', '13', '9', '339.90', '339.90', '1490954624', '1490954624');
INSERT INTO `farm_user_land` VALUES ('75', '13', '10', '339.90', '339.90', '1490954625', '1490954625');
INSERT INTO `farm_user_land` VALUES ('76', '13', '11', '9000.00', '9000.00', '1490954682', '1490954682');
INSERT INTO `farm_user_land` VALUES ('77', '13', '12', '3399.00', '3399.00', '1490954684', '1490954684');
INSERT INTO `farm_user_land` VALUES ('78', '13', '13', '3399.00', '3399.00', '1490954685', '1490954685');
INSERT INTO `farm_user_land` VALUES ('94', '15', '1', '900.00', '900.00', '1490956297', '1490956297');
INSERT INTO `farm_user_land` VALUES ('95', '15', '2', '366.30', '366.30', '1490956302', '1490956302');
INSERT INTO `farm_user_land` VALUES ('96', '15', '3', '366.30', '366.30', '1490956304', '1490956304');
INSERT INTO `farm_user_land` VALUES ('97', '15', '4', '366.30', '366.30', '1490956305', '1490956305');
INSERT INTO `farm_user_land` VALUES ('98', '15', '5', '366.30', '366.30', '1490956306', '1490956306');
INSERT INTO `farm_user_land` VALUES ('99', '15', '6', '366.30', '966.30', '1490956312', '1490956312');
INSERT INTO `farm_user_land` VALUES ('100', '15', '7', '366.30', '366.30', '1490956317', '1490956317');
INSERT INTO `farm_user_land` VALUES ('101', '15', '8', '366.30', '366.30', '1490956318', '1490956318');
INSERT INTO `farm_user_land` VALUES ('102', '15', '9', '366.30', '366.30', '1490956320', '1490956320');
INSERT INTO `farm_user_land` VALUES ('103', '15', '10', '366.30', '366.30', '1490956321', '1490956321');
INSERT INTO `farm_user_land` VALUES ('104', '15', '11', '9000.00', '9000.00', '1490956328', '1490956328');
INSERT INTO `farm_user_land` VALUES ('105', '15', '12', '3663.00', '3663.00', '1490956330', '1490956330');
INSERT INTO `farm_user_land` VALUES ('106', '15', '13', '3663.00', '3663.00', '1490956331', '1490956331');
INSERT INTO `farm_user_land` VALUES ('107', '15', '14', '3663.00', '3663.00', '1490956333', '1490956333');
INSERT INTO `farm_user_land` VALUES ('250', '8', '1', '472.06', '472.06', '1491030796', '1491030796');
INSERT INTO `farm_user_land` VALUES ('251', '8', '2', '472.06', '472.06', '1491030800', '1491030800');
INSERT INTO `farm_user_land` VALUES ('252', '8', '3', '472.06', '472.06', '1491030805', '1491030805');
INSERT INTO `farm_user_land` VALUES ('253', '8', '4', '472.06', '472.06', '1491030809', '1491030809');
INSERT INTO `farm_user_land` VALUES ('254', '8', '5', '472.06', '472.06', '1491030812', '1491030812');
INSERT INTO `farm_user_land` VALUES ('255', '8', '6', '472.06', '472.06', '1491030820', '1491030820');
INSERT INTO `farm_user_land` VALUES ('256', '8', '7', '472.06', '472.06', '1491030825', '1491030825');
INSERT INTO `farm_user_land` VALUES ('257', '8', '8', '472.06', '472.06', '1491030831', '1491030831');
INSERT INTO `farm_user_land` VALUES ('258', '8', '9', '472.06', '472.06', '1491030835', '1491030835');
INSERT INTO `farm_user_land` VALUES ('259', '8', '10', '472.06', '472.06', '1491030838', '1491030838');
INSERT INTO `farm_user_land` VALUES ('260', '8', '11', '4720.55', '4720.55', '1491030850', '1491030850');
INSERT INTO `farm_user_land` VALUES ('270', '21', '1', '900.00', '900.00', '1491357784', '1491357784');
INSERT INTO `farm_user_land` VALUES ('271', '21', '2', '377.91', '377.91', '1491357787', '1491357787');
INSERT INTO `farm_user_land` VALUES ('272', '21', '3', '377.91', '377.91', '1491357789', '1491357789');
INSERT INTO `farm_user_land` VALUES ('273', '21', '4', '377.91', '377.91', '1491357793', '1491357793');
INSERT INTO `farm_user_land` VALUES ('274', '21', '5', '900.00', '900.00', '1491357799', '1491357799');
INSERT INTO `farm_user_land` VALUES ('275', '21', '6', '900.00', '900.00', '1491357898', '1491357898');
INSERT INTO `farm_user_land` VALUES ('276', '21', '7', '377.91', '377.91', '1491357900', '1491357900');
INSERT INTO `farm_user_land` VALUES ('277', '21', '8', '377.91', '377.91', '1491357902', '1491357902');
INSERT INTO `farm_user_land` VALUES ('278', '21', '9', '377.91', '377.91', '1491357904', '1491357904');
INSERT INTO `farm_user_land` VALUES ('279', '21', '10', '377.91', '377.91', '1491357908', '1491357908');
INSERT INTO `farm_user_land` VALUES ('280', '21', '11', '3779.14', '5979.14', '1491357962', '1491357962');
INSERT INTO `farm_user_land` VALUES ('352', '42', '1', '900.00', '900.00', '1491372017', '1491372017');
INSERT INTO `farm_user_land` VALUES ('385', '48', '1', '900.00', '900.00', '1491443348', '1491443348');
INSERT INTO `farm_user_land` VALUES ('386', '48', '2', '387.72', '387.72', '1491443350', '1491443350');
INSERT INTO `farm_user_land` VALUES ('387', '48', '3', '333.72', '333.72', '1491443353', '1491443353');
INSERT INTO `farm_user_land` VALUES ('388', '48', '4', '333.72', '333.72', '1491443357', '1491443357');
INSERT INTO `farm_user_land` VALUES ('389', '48', '5', '333.72', '333.72', '1491443359', '1491443359');
INSERT INTO `farm_user_land` VALUES ('390', '48', '6', '333.72', '333.72', '1491443364', '1491443364');
INSERT INTO `farm_user_land` VALUES ('391', '48', '7', '333.72', '333.72', '1491443368', '1491443368');
INSERT INTO `farm_user_land` VALUES ('392', '48', '8', '333.72', '333.72', '1491443371', '1491443371');
INSERT INTO `farm_user_land` VALUES ('393', '48', '9', '324.00', '333.00', '1491443375', '1491443375');
INSERT INTO `farm_user_land` VALUES ('394', '48', '10', '333.72', '333.72', '1491443377', '1491443377');
INSERT INTO `farm_user_land` VALUES ('395', '48', '11', '5352.48', '5852.48', '1491443384', '1491443384');
INSERT INTO `farm_user_land` VALUES ('396', '25', '1', '900.00', '900.00', '1491445689', '1491445689');
INSERT INTO `farm_user_land` VALUES ('397', '25', '2', '524.88', '524.88', '1491445892', '1491445892');
INSERT INTO `farm_user_land` VALUES ('398', '25', '3', '349.92', '349.92', '1491445896', '1491445896');
INSERT INTO `farm_user_land` VALUES ('399', '25', '4', '349.92', '349.92', '1491445899', '1491445899');
INSERT INTO `farm_user_land` VALUES ('400', '25', '5', '349.92', '349.92', '1491445903', '1491445903');
INSERT INTO `farm_user_land` VALUES ('401', '25', '6', '349.92', '349.92', '1491445908', '1491445908');
INSERT INTO `farm_user_land` VALUES ('402', '25', '7', '349.92', '349.92', '1491445911', '1491445911');
INSERT INTO `farm_user_land` VALUES ('403', '25', '8', '349.92', '349.92', '1491445915', '1491445915');
INSERT INTO `farm_user_land` VALUES ('404', '25', '9', '349.92', '349.92', '1491445918', '1491445918');
INSERT INTO `farm_user_land` VALUES ('405', '25', '10', '349.92', '349.92', '1491445922', '1491445922');
INSERT INTO `farm_user_land` VALUES ('406', '25', '11', '3499.20', '3499.20', '1491445925', '1491445925');
INSERT INTO `farm_user_land` VALUES ('407', '51', '1', '467.42', '467.42', '1491445925', '1491445925');
INSERT INTO `farm_user_land` VALUES ('410', '10', '1', '349.92', '349.92', '1491449864', '1491449864');
INSERT INTO `farm_user_land` VALUES ('411', '10', '2', '349.92', '349.92', '1491449871', '1491449871');
INSERT INTO `farm_user_land` VALUES ('412', '10', '3', '349.92', '349.92', '1491449875', '1491449875');
INSERT INTO `farm_user_land` VALUES ('413', '10', '4', '349.92', '349.92', '1491449900', '1491449900');
INSERT INTO `farm_user_land` VALUES ('414', '10', '5', '349.92', '349.92', '1491449903', '1491449903');
INSERT INTO `farm_user_land` VALUES ('415', '10', '6', '349.92', '349.92', '1491449907', '1491449907');
INSERT INTO `farm_user_land` VALUES ('416', '10', '7', '349.92', '349.92', '1491449911', '1491449911');
INSERT INTO `farm_user_land` VALUES ('417', '10', '8', '349.92', '349.92', '1491449915', '1491449915');
INSERT INTO `farm_user_land` VALUES ('418', '10', '9', '349.92', '349.92', '1491449919', '1491449919');
INSERT INTO `farm_user_land` VALUES ('419', '10', '10', '349.92', '349.92', '1491449923', '1491449923');
INSERT INTO `farm_user_land` VALUES ('420', '10', '11', '3499.20', '3499.20', '1491449930', '1491449930');
INSERT INTO `farm_user_land` VALUES ('422', '7', '1', '900.00', '1100.00', '1491462407', '1491462407');
INSERT INTO `farm_user_land` VALUES ('423', '53', '1', '584.27', '584.27', '1491462407', '1491462407');
INSERT INTO `farm_user_land` VALUES ('424', '53', '2', '355.06', '755.06', '1491462407', '1491462407');
INSERT INTO `farm_user_land` VALUES ('425', '24', '1', '900.00', '2100.00', '1491467602', '1491467602');
INSERT INTO `farm_user_land` VALUES ('427', '24', '2', '900.00', '900.00', '1491469146', '1491469146');
INSERT INTO `farm_user_land` VALUES ('428', '24', '3', '300.00', '900.00', '1491469150', '1491469150');
INSERT INTO `farm_user_land` VALUES ('439', '5', '1', '900.00', '1300.00', '1491469813', '1491469813');
INSERT INTO `farm_user_land` VALUES ('440', '57', '1', '900.00', '2100.00', '1491470369', '1491470369');
INSERT INTO `farm_user_land` VALUES ('441', '57', '2', '349.92', '349.92', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('442', '58', '1', '900.00', '900.00', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('443', '58', '2', '343.47', '343.47', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('444', '58', '3', '343.47', '343.47', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('445', '58', '4', '343.47', '343.47', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('446', '58', '5', '343.47', '343.47', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('447', '58', '6', '343.47', '343.47', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('448', '58', '7', '343.47', '343.47', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('449', '58', '8', '343.47', '343.47', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('450', '58', '9', '343.47', '343.47', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('451', '58', '10', '343.47', '343.47', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('452', '58', '11', '5953.48', '5953.48', '1491470606', '1491470606');
INSERT INTO `farm_user_land` VALUES ('453', '42', '2', '900.00', '900.00', '1491531651', '1491531651');
INSERT INTO `farm_user_land` VALUES ('454', '42', '3', '900.00', '900.00', '1491531656', '1491531656');
INSERT INTO `farm_user_land` VALUES ('455', '42', '4', '324.00', '924.00', '1491531662', '1491531662');
INSERT INTO `farm_user_land` VALUES ('456', '7', '2', '900.00', '900.00', '1491535072', '1491535072');
INSERT INTO `farm_user_land` VALUES ('457', '24', '4', '300.00', '900.00', '1491544211', '1491544211');
INSERT INTO `farm_user_land` VALUES ('458', '24', '5', '300.00', '900.00', '1491544214', '1491544214');
INSERT INTO `farm_user_land` VALUES ('459', '24', '6', '300.00', '900.00', '1491544452', '1491544452');
INSERT INTO `farm_user_land` VALUES ('460', '24', '7', '300.00', '300.00', '1491545005', '1491545005');
INSERT INTO `farm_user_land` VALUES ('461', '24', '8', '300.00', '300.00', '1491545009', '1491545009');
INSERT INTO `farm_user_land` VALUES ('462', '24', '9', '300.00', '300.00', '1491545015', '1491545015');
INSERT INTO `farm_user_land` VALUES ('463', '24', '10', '300.00', '300.00', '1491545020', '1491545020');
INSERT INTO `farm_user_land` VALUES ('464', '24', '11', '9000.00', '9000.00', '1491545026', '1491545026');
INSERT INTO `farm_user_land` VALUES ('465', '7', '3', '900.00', '900.00', '1491551863', '1491551863');
INSERT INTO `farm_user_land` VALUES ('466', '7', '4', '900.00', '900.00', '1491551867', '1491551867');
INSERT INTO `farm_user_land` VALUES ('467', '14', '1', '300.00', '300.00', '1491557222', '1491557222');
INSERT INTO `farm_user_land` VALUES ('468', '14', '2', '300.00', '300.00', '1491557226', '1491557226');
INSERT INTO `farm_user_land` VALUES ('469', '14', '3', '300.00', '300.00', '1491557230', '1491557230');
INSERT INTO `farm_user_land` VALUES ('470', '14', '4', '300.00', '300.00', '1491557237', '1491557237');
INSERT INTO `farm_user_land` VALUES ('471', '14', '5', '300.00', '300.00', '1491557240', '1491557240');
INSERT INTO `farm_user_land` VALUES ('472', '14', '6', '300.00', '300.00', '1491557246', '1491557246');
INSERT INTO `farm_user_land` VALUES ('473', '14', '7', '300.00', '300.00', '1491557251', '1491557251');
INSERT INTO `farm_user_land` VALUES ('474', '14', '8', '300.00', '300.00', '1491557257', '1491557257');
INSERT INTO `farm_user_land` VALUES ('475', '14', '9', '300.00', '300.00', '1491557261', '1491557261');
INSERT INTO `farm_user_land` VALUES ('476', '14', '10', '300.00', '300.00', '1491557265', '1491557265');
INSERT INTO `farm_user_land` VALUES ('477', '14', '11', '3000.00', '3000.00', '1491557271', '1491557271');
INSERT INTO `farm_user_land` VALUES ('478', '14', '12', '3000.00', '3000.00', '1491557276', '1491557276');
INSERT INTO `farm_user_land` VALUES ('479', '14', '13', '3000.00', '3000.00', '1491557280', '1491557280');
INSERT INTO `farm_user_land` VALUES ('480', '14', '14', '3000.00', '3000.00', '1491557286', '1491557286');
INSERT INTO `farm_user_land` VALUES ('481', '14', '15', '3000.00', '3000.00', '1491557291', '1491557291');
INSERT INTO `farm_user_land` VALUES ('482', '7', '5', '900.00', '900.00', '1491787794', '1491787794');
INSERT INTO `farm_user_land` VALUES ('483', '7', '6', '890.00', '900.00', '1491787798', '1491787798');
INSERT INTO `farm_user_land` VALUES ('484', '66', '1', '400.00', '1000.00', '1491810808', '1491810808');
INSERT INTO `farm_user_land` VALUES ('485', '66', '2', '400.00', '1000.00', '1491810845', '1491810845');
INSERT INTO `farm_user_land` VALUES ('486', '66', '3', '400.00', '700.00', '1491810855', '1491810855');
INSERT INTO `farm_user_land` VALUES ('487', '66', '4', '400.00', '400.00', '1491810881', '1491810881');
INSERT INTO `farm_user_land` VALUES ('488', '66', '5', '400.00', '400.00', '1491810890', '1491810890');
INSERT INTO `farm_user_land` VALUES ('489', '66', '6', '500.00', '1300.00', '1491810963', '1491810963');
INSERT INTO `farm_user_land` VALUES ('490', '66', '7', '500.00', '700.00', '1491810972', '1491810972');
INSERT INTO `farm_user_land` VALUES ('491', '66', '8', '500.00', '700.00', '1491810978', '1491810978');
INSERT INTO `farm_user_land` VALUES ('492', '66', '9', '500.00', '500.00', '1491810987', '1491810987');
INSERT INTO `farm_user_land` VALUES ('493', '66', '10', '500.00', '500.00', '1491810990', '1491810990');
INSERT INTO `farm_user_land` VALUES ('494', '67', '1', '702.41', '1002.41', '1491814310', '1491814310');
INSERT INTO `farm_user_land` VALUES ('495', '67', '2', '585.00', '985.00', '1491814316', '1491814316');
INSERT INTO `farm_user_land` VALUES ('496', '67', '3', '450.00', '900.00', '1491814321', '1491814321');
INSERT INTO `farm_user_land` VALUES ('497', '67', '4', '448.19', '448.19', '1491814325', '1491814325');
INSERT INTO `farm_user_land` VALUES ('498', '67', '5', '448.19', '448.19', '1491814331', '1491814331');
INSERT INTO `farm_user_land` VALUES ('499', '67', '6', '448.19', '448.19', '1491814350', '1491814350');
INSERT INTO `farm_user_land` VALUES ('500', '67', '7', '606.65', '606.65', '1491814360', '1491814360');
INSERT INTO `farm_user_land` VALUES ('501', '67', '8', '448.19', '448.19', '1491814365', '1491814365');
INSERT INTO `farm_user_land` VALUES ('502', '67', '9', '448.19', '449.19', '1491814369', '1491814369');
INSERT INTO `farm_user_land` VALUES ('503', '67', '10', '448.19', '748.19', '1491814373', '1491814373');
INSERT INTO `farm_user_land` VALUES ('504', '68', '1', '300.00', '450.00', '1491815560', '1491815560');
INSERT INTO `farm_user_land` VALUES ('505', '69', '1', '315.00', '315.00', '1491816330', '1491816330');
INSERT INTO `farm_user_land` VALUES ('506', '70', '1', '313.56', '313.56', '1491816962', '1491816962');
INSERT INTO `farm_user_land` VALUES ('507', '71', '1', '613.89', '864.06', '1491817306', '1491817306');
INSERT INTO `farm_user_land` VALUES ('508', '72', '1', '301.10', '302.10', '1491874069', '1491874069');
INSERT INTO `farm_user_land` VALUES ('509', '74', '1', '313.09', '313.09', '1491874069', '1491874069');
INSERT INTO `farm_user_land` VALUES ('510', '77', '1', '600.00', '900.00', '1492048400', '1492048400');
INSERT INTO `farm_user_land` VALUES ('511', '77', '2', '300.00', '301.00', '1492048403', '1492048403');
INSERT INTO `farm_user_land` VALUES ('512', '77', '3', '300.00', '300.00', '1492048407', '1492048407');
INSERT INTO `farm_user_land` VALUES ('513', '77', '4', '300.00', '300.00', '1492048411', '1492048411');
INSERT INTO `farm_user_land` VALUES ('514', '77', '5', '300.00', '300.00', '1492048415', '1492048415');
INSERT INTO `farm_user_land` VALUES ('515', '77', '6', '300.00', '300.00', '1492048422', '1492048422');
INSERT INTO `farm_user_land` VALUES ('516', '77', '7', '300.00', '300.00', '1492048478', '1492048478');
INSERT INTO `farm_user_land` VALUES ('517', '77', '8', '300.00', '300.00', '1492048482', '1492048482');
INSERT INTO `farm_user_land` VALUES ('518', '77', '9', '300.00', '300.00', '1492048486', '1492048486');
INSERT INTO `farm_user_land` VALUES ('519', '77', '10', '300.00', '300.00', '1492048489', '1492048489');
INSERT INTO `farm_user_land` VALUES ('520', '77', '11', '4000.00', '9000.00', '1492048496', '1492048496');
INSERT INTO `farm_user_land` VALUES ('521', '77', '12', '3000.00', '3000.00', '1492048512', '1492048512');
INSERT INTO `farm_user_land` VALUES ('534', '78', '1', '307.00', '307.00', '1492052112', '1492052112');
INSERT INTO `farm_user_land` VALUES ('547', '80', '1', '300.00', '300.00', '1492487242', '1492487242');
INSERT INTO `farm_user_land` VALUES ('548', '81', '1', '1800.00', '1800.00', '1492488963', '1492488963');
INSERT INTO `farm_user_land` VALUES ('549', '84', '1', '313.11', '313.11', '1492671499', '1492671499');
INSERT INTO `farm_user_land` VALUES ('550', '79', '1', '900.00', '900.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('551', '85', '1', '300.00', '900.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('552', '85', '2', '500.00', '900.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('553', '85', '3', '688.76', '688.76', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('554', '85', '4', '300.00', '300.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('555', '85', '5', '300.00', '300.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('556', '85', '6', '300.00', '300.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('557', '85', '7', '300.00', '300.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('558', '85', '8', '300.00', '300.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('559', '85', '9', '300.00', '300.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('560', '85', '10', '300.00', '300.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('561', '85', '11', '3000.00', '9000.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('562', '85', '12', '3000.00', '3000.00', '1492671601', '1492671601');
INSERT INTO `farm_user_land` VALUES ('563', '85', '13', '3000.00', '3000.00', '1492746611', '1492746611');
INSERT INTO `farm_user_land` VALUES ('564', '90', '1', '351.55', '1251.55', '1492932525', '1492932525');
INSERT INTO `farm_user_land` VALUES ('565', '79', '2', '300.00', '300.00', '1492996463', '1492996463');
INSERT INTO `farm_user_land` VALUES ('566', '79', '3', '300.00', '300.00', '1492996590', '1492996590');
INSERT INTO `farm_user_land` VALUES ('567', '79', '4', '300.00', '300.00', '1492996592', '1492996592');
INSERT INTO `farm_user_land` VALUES ('568', '79', '5', '300.00', '300.00', '1492996595', '1492996595');
INSERT INTO `farm_user_land` VALUES ('569', '81', '2', '300.00', '1200.00', '1493693973', '1493693973');
INSERT INTO `farm_user_land` VALUES ('570', '91', '1', '403.37', '330.35', '1493693987', '1493693987');
INSERT INTO `farm_user_land` VALUES ('571', '90', '2', '649.83', '1072.83', '1493699388', '1493699388');
INSERT INTO `farm_user_land` VALUES ('572', '90', '3', '320.00', '743.02', '1493699415', '1493699415');
INSERT INTO `farm_user_land` VALUES ('573', '92', '1', '343.88', '335.66', '1493699774', '1493699774');
INSERT INTO `farm_user_land` VALUES ('574', '90', '4', '500.00', '500.00', '1493704839', '1493704839');
INSERT INTO `farm_user_land` VALUES ('575', '94', '1', '335.24', '335.24', '1493706232', '1493706232');
INSERT INTO `farm_user_land` VALUES ('576', '95', '1', '308.15', '308.15', '1493716263', '1493716263');
INSERT INTO `farm_user_land` VALUES ('577', '81', '3', '1200.00', '1200.00', '1493730305', '1493730305');
INSERT INTO `farm_user_land` VALUES ('578', '81', '4', '1200.00', '1200.00', '1493730312', '1493730312');
INSERT INTO `farm_user_land` VALUES ('579', '81', '5', '1200.00', '1200.00', '1493730319', '1493730319');
INSERT INTO `farm_user_land` VALUES ('580', '81', '6', '1200.00', '1200.00', '1493730325', '1493730325');
INSERT INTO `farm_user_land` VALUES ('581', '81', '7', '419.75', '419.75', '1493730328', '1493730328');
INSERT INTO `farm_user_land` VALUES ('582', '81', '8', '300.00', '300.00', '1493730330', '1493730330');
INSERT INTO `farm_user_land` VALUES ('583', '81', '9', '300.00', '300.00', '1493730333', '1493730333');
INSERT INTO `farm_user_land` VALUES ('584', '81', '10', '300.00', '300.00', '1493730339', '1493730339');
INSERT INTO `farm_user_land` VALUES ('585', '81', '11', '3000.00', '3000.00', '1493730341', '1493730341');
INSERT INTO `farm_user_land` VALUES ('586', '81', '12', '3000.00', '3000.00', '1493730343', '1493730343');
INSERT INTO `farm_user_land` VALUES ('587', '81', '13', '3000.00', '3000.00', '1493730346', '1493730346');
INSERT INTO `farm_user_land` VALUES ('588', '81', '14', '3000.00', '3000.00', '1493730477', '1493730477');
INSERT INTO `farm_user_land` VALUES ('589', '81', '15', '3990.36', '3000.00', '1493730482', '1493730482');
INSERT INTO `farm_user_land` VALUES ('590', '97', '1', '330.78', '330.78', '1493775630', '1493775630');
INSERT INTO `farm_user_land` VALUES ('591', '98', '1', '300.00', '300.00', '1493777377', '1493777377');
INSERT INTO `farm_user_land` VALUES ('592', '99', '1', '318.15', '318.15', '1493783243', '1493783243');
INSERT INTO `farm_user_land` VALUES ('593', '100', '1', '326.37', '326.37', '1493905758', '1493905758');
INSERT INTO `farm_user_land` VALUES ('594', '90', '5', '314.00', '300.00', '1493938384', '1493938384');
INSERT INTO `farm_user_land` VALUES ('595', '90', '6', '320.00', '300.00', '1493938394', '1493938394');
INSERT INTO `farm_user_land` VALUES ('596', '90', '7', '301.59', '300.00', '1493938401', '1493938401');
INSERT INTO `farm_user_land` VALUES ('597', '90', '8', '311.80', '300.00', '1493938410', '1493938410');
INSERT INTO `farm_user_land` VALUES ('598', '90', '9', '305.00', '300.00', '1493938418', '1493938418');
INSERT INTO `farm_user_land` VALUES ('599', '90', '10', '357.31', '300.00', '1493938426', '1493938426');
INSERT INTO `farm_user_land` VALUES ('600', '95', '2', '300.00', '300.00', '1493938653', '1493938653');
INSERT INTO `farm_user_land` VALUES ('601', '95', '3', '300.00', '300.00', '1493939040', '1493939040');
INSERT INTO `farm_user_land` VALUES ('602', '101', '1', '300.00', '300.00', '1494285737', '1494285737');
INSERT INTO `farm_user_land` VALUES ('603', '102', '1', '300.00', '300.00', '1494293654', '1494293654');

-- ----------------------------
-- Table structure for `farm_user_profit`
-- ----------------------------
DROP TABLE IF EXISTS `farm_user_profit`;
CREATE TABLE `farm_user_profit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) unsigned NOT NULL,
  `profitRate` decimal(10,2) NOT NULL COMMENT '收益率',
  `profitNum` decimal(10,2) unsigned NOT NULL COMMENT '每天的收益量',
  `dateTime` int(11) unsigned NOT NULL COMMENT '日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8 COMMENT='用户每天收益表';

-- ----------------------------
-- Records of farm_user_profit
-- ----------------------------
INSERT INTO `farm_user_profit` VALUES ('1', '3', '0.04', '0.00', '1489731747');
INSERT INTO `farm_user_profit` VALUES ('2', '3', '0.06', '0.00', '1489976318');
INSERT INTO `farm_user_profit` VALUES ('3', '4', '0.04', '0.00', '1489976318');
INSERT INTO `farm_user_profit` VALUES ('6', '3', '0.04', '19.97', '1490062853');
INSERT INTO `farm_user_profit` VALUES ('7', '4', '0.04', '20.34', '1490062853');
INSERT INTO `farm_user_profit` VALUES ('9', '4', '0.04', '21.16', '1490231237');
INSERT INTO `farm_user_profit` VALUES ('10', '5', '0.04', '28.88', '1490231237');
INSERT INTO `farm_user_profit` VALUES ('11', '3', '0.03', '9.67', '1490263318');
INSERT INTO `farm_user_profit` VALUES ('12', '3', '0.04', '13.28', '1490316248');
INSERT INTO `farm_user_profit` VALUES ('13', '4', '0.04', '22.00', '1490316248');
INSERT INTO `farm_user_profit` VALUES ('14', '5', '0.04', '30.37', '1490316248');
INSERT INTO `farm_user_profit` VALUES ('15', '3', '0.04', '13.81', '1490578997');
INSERT INTO `farm_user_profit` VALUES ('16', '4', '0.04', '22.88', '1490578997');
INSERT INTO `farm_user_profit` VALUES ('17', '5', '0.04', '31.58', '1490578997');
INSERT INTO `farm_user_profit` VALUES ('18', '3', '0.04', '14.37', '1490665581');
INSERT INTO `farm_user_profit` VALUES ('19', '4', '0.04', '2437.06', '1490665581');
INSERT INTO `farm_user_profit` VALUES ('20', '5', '0.04', '32.45', '1490665581');
INSERT INTO `farm_user_profit` VALUES ('33', '3', '0.04', '15.54', '1490780024');
INSERT INTO `farm_user_profit` VALUES ('34', '4', '0.04', '74.88', '1490780024');
INSERT INTO `farm_user_profit` VALUES ('35', '5', '0.04', '35.10', '1490780024');
INSERT INTO `farm_user_profit` VALUES ('36', '3', '0.04', '16.16', '1490836581');
INSERT INTO `farm_user_profit` VALUES ('37', '4', '0.04', '77.88', '1490836581');
INSERT INTO `farm_user_profit` VALUES ('38', '5', '0.04', '38.70', '1490836581');
INSERT INTO `farm_user_profit` VALUES ('39', '6', '0.03', '900.00', '1490859449');
INSERT INTO `farm_user_profit` VALUES ('40', '5', '0.03', '109.63', '1490925504');
INSERT INTO `farm_user_profit` VALUES ('41', '6', '0.03', '38700.00', '1490927342');
INSERT INTO `farm_user_profit` VALUES ('42', '3', '0.03', '12.61', '1490930731');
INSERT INTO `farm_user_profit` VALUES ('43', '7', '0.03', '600.00', '1490931578');
INSERT INTO `farm_user_profit` VALUES ('44', '4', '0.04', '80.99', '1490938415');
INSERT INTO `farm_user_profit` VALUES ('45', '9', '0.04', '0.00', '1490946297');
INSERT INTO `farm_user_profit` VALUES ('46', '10', '0.04', '0.00', '1490946566');
INSERT INTO `farm_user_profit` VALUES ('47', '11', '0.04', '0.00', '1490953774');
INSERT INTO `farm_user_profit` VALUES ('48', '12', '0.04', '0.00', '1490954011');
INSERT INTO `farm_user_profit` VALUES ('49', '13', '0.04', '0.00', '1490954452');
INSERT INTO `farm_user_profit` VALUES ('50', '14', '0.04', '0.00', '1490955787');
INSERT INTO `farm_user_profit` VALUES ('51', '15', '0.04', '0.00', '1490956092');
INSERT INTO `farm_user_profit` VALUES ('52', '5', '0.04', '36.11', '1491009474');
INSERT INTO `farm_user_profit` VALUES ('53', '3', '0.06', '25.97', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('54', '4', '0.06', '99.17', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('55', '6', '0.12', '400.00', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('56', '7', '0.66', '795.00', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('57', '8', '0.06', '0.00', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('58', '9', '0.06', '18.00', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('59', '10', '0.07', '189.00', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('60', '11', '0.08', '456.00', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('61', '12', '0.09', '513.00', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('62', '13', '0.10', '870.00', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('63', '14', '0.12', '1764.00', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('64', '15', '0.11', '1287.00', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('65', '16', '0.06', '180.00', '1491009576');
INSERT INTO `farm_user_profit` VALUES ('66', '19', '0.04', '6000.00', '1491015223');
INSERT INTO `farm_user_profit` VALUES ('67', '22', '-0.16', '0.00', '1491040592');
INSERT INTO `farm_user_profit` VALUES ('68', '6', '-0.16', '0.00', '1491297343');
INSERT INTO `farm_user_profit` VALUES ('69', '3', '0.06', '27.53', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('70', '4', '0.06', '105.12', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('71', '5', '0.06', '56.33', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('72', '6', '-0.08', '0.00', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('73', '7', '0.66', '1314.72', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('74', '8', '0.12', '720.00', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('75', '9', '0.06', '19.08', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('76', '10', '0.07', '202.23', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('77', '11', '0.08', '492.48', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('78', '12', '-0.11', '0.00', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('79', '13', '-0.10', '0.00', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('80', '14', '-0.08', '0.00', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('81', '15', '-0.09', '0.00', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('82', '16', '-0.09', '0.00', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('83', '19', '-0.12', '0.00', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('84', '22', '0.06', '3812.00', '1491353897');
INSERT INTO `farm_user_profit` VALUES ('85', '21', '-0.16', '0.00', '1491357327');
INSERT INTO `farm_user_profit` VALUES ('86', '36', '0.04', '24000.00', '1491363579');
INSERT INTO `farm_user_profit` VALUES ('87', '42', '0.04', '0.00', '1491371357');
INSERT INTO `farm_user_profit` VALUES ('88', '24', '0.04', '0.00', '1491380854');
INSERT INTO `farm_user_profit` VALUES ('89', '7', '0.64', '3638.38', '1491440874');
INSERT INTO `farm_user_profit` VALUES ('90', '13', '0.03', '287.10', '1491440955');
INSERT INTO `farm_user_profit` VALUES ('91', '3', '0.06', '29.18', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('92', '4', '0.06', '111.43', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('94', '6', '-0.08', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('95', '8', '0.12', '806.40', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('96', '9', '0.06', '20.22', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('97', '10', '0.07', '216.39', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('98', '11', '0.08', '531.88', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('99', '12', '0.08', '497.04', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('100', '14', '0.11', '1811.04', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('101', '15', '0.10', '1298.70', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('102', '16', '0.11', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('103', '19', '0.08', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('104', '21', '0.08', '408.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('105', '22', '0.16', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('106', '33', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('107', '32', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('108', '31', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('109', '30', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('110', '29', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('111', '28', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('112', '27', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('113', '26', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('114', '25', '0.06', '150.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('115', '24', '0.06', '68.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('116', '36', '0.20', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('117', '37', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('118', '38', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('119', '39', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('120', '42', '0.08', '24.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('121', '43', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('122', '44', '0.06', '0.00', '1491441087');
INSERT INTO `farm_user_profit` VALUES ('123', '48', '0.04', '0.00', '1491443313');
INSERT INTO `farm_user_profit` VALUES ('124', '5', '0.04', '717.72', '1491444796');
INSERT INTO `farm_user_profit` VALUES ('125', '51', '0.04', '16.00', '1491446680');
INSERT INTO `farm_user_profit` VALUES ('126', '52', '0.04', '20.00', '1491446765');
INSERT INTO `farm_user_profit` VALUES ('127', '53', '0.04', '36.00', '1491466289');
INSERT INTO `farm_user_profit` VALUES ('128', '57', '0.04', '16.00', '1491468648');
INSERT INTO `farm_user_profit` VALUES ('129', '48', '0.03', '287.00', '1491527406');
INSERT INTO `farm_user_profit` VALUES ('130', '7', '0.64', '2200.00', '1491529012');
INSERT INTO `farm_user_profit` VALUES ('131', '58', '0.07', '553.00', '1491529207');
INSERT INTO `farm_user_profit` VALUES ('132', '27', '0.06', '0.00', '1491529426');
INSERT INTO `farm_user_profit` VALUES ('133', '21', '0.08', '440.64', '1491529511');
INSERT INTO `farm_user_profit` VALUES ('134', '12', '-0.11', '0.00', '1491529701');
INSERT INTO `farm_user_profit` VALUES ('135', '3', '0.06', '30.93', '1491530423');
INSERT INTO `farm_user_profit` VALUES ('136', '4', '0.06', '118.12', '1491530423');
INSERT INTO `farm_user_profit` VALUES ('137', '5', '0.09', '54.00', '1491530423');
INSERT INTO `farm_user_profit` VALUES ('138', '6', '-0.08', '0.00', '1491530423');
INSERT INTO `farm_user_profit` VALUES ('139', '8', '0.12', '903.17', '1491530423');
INSERT INTO `farm_user_profit` VALUES ('140', '9', '0.06', '21.44', '1491530423');
INSERT INTO `farm_user_profit` VALUES ('141', '10', '0.08', '480.00', '1491530423');
INSERT INTO `farm_user_profit` VALUES ('142', '11', '0.08', '574.43', '1491530423');
INSERT INTO `farm_user_profit` VALUES ('143', '13', '-0.10', '0.00', '1491530423');
INSERT INTO `farm_user_profit` VALUES ('144', '14', '-0.08', '0.00', '1491530423');
INSERT INTO `farm_user_profit` VALUES ('145', '15', '-0.09', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('146', '16', '0.11', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('147', '19', '0.08', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('148', '22', '0.16', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('149', '33', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('150', '32', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('151', '31', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('152', '30', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('153', '29', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('154', '28', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('155', '26', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('156', '25', '0.08', '468.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('157', '24', '0.16', '2400.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('158', '36', '0.20', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('159', '37', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('160', '38', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('161', '39', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('162', '42', '0.08', '2376.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('163', '43', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('164', '44', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('165', '49', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('166', '50', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('167', '51', '0.06', '24.96', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('168', '52', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('169', '53', '0.06', '50.16', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('170', '54', '0.06', '0.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('171', '57', '0.08', '24.00', '1491530424');
INSERT INTO `farm_user_profit` VALUES ('172', '63', '0.06', '0.00', '1491549227');
INSERT INTO `farm_user_profit` VALUES ('173', '7', '0.48', '1199.80', '1491787788');
INSERT INTO `farm_user_profit` VALUES ('174', '3', '0.06', '32.78', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('175', '4', '0.06', '85.87', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('176', '5', '-0.11', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('177', '6', '-0.08', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('178', '8', '0.12', '1011.55', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('179', '9', '0.06', '22.72', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('180', '10', '0.08', '518.40', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('181', '11', '0.08', '620.38', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('182', '12', '0.09', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('183', '13', '-0.10', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('184', '14', '-0.08', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('185', '15', '-0.09', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('186', '16', '0.11', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('187', '19', '0.08', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('188', '21', '0.08', '475.89', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('189', '22', '0.16', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('190', '33', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('191', '32', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('192', '31', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('193', '30', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('194', '29', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('195', '28', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('196', '27', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('197', '26', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('198', '25', '0.08', '505.44', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('199', '24', '-0.02', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('200', '36', '0.50', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('201', '37', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('202', '38', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('203', '39', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('204', '42', '0.08', '24.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('205', '43', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('206', '44', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('207', '48', '0.08', '622.24', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('208', '49', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('209', '50', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('210', '51', '0.06', '26.46', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('211', '52', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('212', '53', '0.06', '53.17', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('213', '54', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('214', '57', '0.08', '25.92', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('215', '58', '0.07', '591.71', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('216', '60', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('217', '62', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('218', '63', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('219', '64', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('220', '65', '0.06', '0.00', '1491802844');
INSERT INTO `farm_user_profit` VALUES ('221', '66', '0.04', '1500.00', '1491810558');
INSERT INTO `farm_user_profit` VALUES ('222', '67', '0.04', '1650.00', '1491814171');
INSERT INTO `farm_user_profit` VALUES ('223', '68', '0.04', '150.00', '1491815473');
INSERT INTO `farm_user_profit` VALUES ('224', '69', '0.04', '15.00', '1491816319');
INSERT INTO `farm_user_profit` VALUES ('225', '70', '0.04', '1.50', '1491816954');
INSERT INTO `farm_user_profit` VALUES ('226', '71', '0.04', '5.25', '1491817300');
INSERT INTO `farm_user_profit` VALUES ('227', '71', '0.04', '12.21', '1491864027');
INSERT INTO `farm_user_profit` VALUES ('228', '67', '0.17', '595.41', '1491865142');
INSERT INTO `farm_user_profit` VALUES ('229', '70', '0.04', '12.06', '1491865142');
INSERT INTO `farm_user_profit` VALUES ('230', '72', '0.04', '1.05', '1491874040');
INSERT INTO `farm_user_profit` VALUES ('231', '75', '0.04', '0.00', '1491876414');
INSERT INTO `farm_user_profit` VALUES ('232', '74', '0.04', '12.00', '1491876839');
INSERT INTO `farm_user_profit` VALUES ('233', '71', '0.00', '1.08', '1491980814');
INSERT INTO `farm_user_profit` VALUES ('234', '67', '0.13', '397.86', '1491988075');
INSERT INTO `farm_user_profit` VALUES ('235', '71', '0.00', '1.08', '1492039922');
INSERT INTO `farm_user_profit` VALUES ('236', '74', '0.00', '1.09', '1492047735');
INSERT INTO `farm_user_profit` VALUES ('237', '77', '-0.15', '1.00', '1492048841');
INSERT INTO `farm_user_profit` VALUES ('238', '72', '0.00', '1.05', '1492050548');
INSERT INTO `farm_user_profit` VALUES ('239', '78', '0.05', '325.08', '1492051145');
INSERT INTO `farm_user_profit` VALUES ('240', '79', '0.05', '318.08', '1492054633');
INSERT INTO `farm_user_profit` VALUES ('241', '67', '0.13', '415.84', '1492084994');
INSERT INTO `farm_user_profit` VALUES ('242', '79', '0.05', '329.23', '1492158295');
INSERT INTO `farm_user_profit` VALUES ('243', '71', '0.00', '2.13', '1492342665');
INSERT INTO `farm_user_profit` VALUES ('244', '79', '0.05', '343.16', '1492398430');
INSERT INTO `farm_user_profit` VALUES ('245', '71', '0.00', '2.14', '1492484327');
INSERT INTO `farm_user_profit` VALUES ('246', '81', '0.01', '4.06', '1492561823');
INSERT INTO `farm_user_profit` VALUES ('247', '81', '0.01', '4.11', '1492668637');
INSERT INTO `farm_user_profit` VALUES ('248', '85', '0.00', '481.50', '1492674558');
INSERT INTO `farm_user_profit` VALUES ('249', '81', '0.00', '4.16', '1492736105');
INSERT INTO `farm_user_profit` VALUES ('250', '84', '0.00', '4.05', '1492738124');
INSERT INTO `farm_user_profit` VALUES ('251', '85', '0.00', '507.26', '1492753526');
INSERT INTO `farm_user_profit` VALUES ('252', '81', '0.00', '4.22', '1492826315');
INSERT INTO `farm_user_profit` VALUES ('253', '90', '0.00', '4.05', '1492989455');
INSERT INTO `farm_user_profit` VALUES ('254', '81', '0.00', '4.27', '1492989550');
INSERT INTO `farm_user_profit` VALUES ('255', '90', '0.00', '4.10', '1493082058');
INSERT INTO `farm_user_profit` VALUES ('256', '81', '0.00', '4.33', '1493103676');
INSERT INTO `farm_user_profit` VALUES ('257', '90', '0.00', '4.16', '1493306423');
INSERT INTO `farm_user_profit` VALUES ('258', '90', '0.00', '4.22', '1493442218');
INSERT INTO `farm_user_profit` VALUES ('259', '90', '0.00', '4.27', '1493567643');
INSERT INTO `farm_user_profit` VALUES ('260', '90', '0.00', '4.33', '1493605247');
INSERT INTO `farm_user_profit` VALUES ('261', '81', '0.00', '4.39', '1493687341');
INSERT INTO `farm_user_profit` VALUES ('262', '90', '0.00', '4.39', '1493687405');
INSERT INTO `farm_user_profit` VALUES ('263', '91', '0.00', '4.05', '1493763173');
INSERT INTO `farm_user_profit` VALUES ('264', '92', '0.00', '4.05', '1493775379');
INSERT INTO `farm_user_profit` VALUES ('265', '81', '0.00', '0.10', '1493777793');
INSERT INTO `farm_user_profit` VALUES ('266', '90', '0.00', '5.14', '1493780831');
INSERT INTO `farm_user_profit` VALUES ('267', '95', '0.00', '4.05', '1493800789');
INSERT INTO `farm_user_profit` VALUES ('268', '94', '0.00', '4.05', '1493805350');
INSERT INTO `farm_user_profit` VALUES ('269', '94', '0.00', '4.10', '1493847718');
INSERT INTO `farm_user_profit` VALUES ('270', '97', '0.00', '4.05', '1493849526');
INSERT INTO `farm_user_profit` VALUES ('271', '91', '0.00', '4.10', '1493849648');
INSERT INTO `farm_user_profit` VALUES ('272', '99', '0.00', '4.05', '1493849775');
INSERT INTO `farm_user_profit` VALUES ('273', '92', '0.00', '4.10', '1493851764');
INSERT INTO `farm_user_profit` VALUES ('274', '84', '0.00', '4.10', '1493860598');
INSERT INTO `farm_user_profit` VALUES ('275', '94', '0.00', '4.16', '1493936589');
INSERT INTO `farm_user_profit` VALUES ('276', '90', '0.00', '18.41', '1493938224');
INSERT INTO `farm_user_profit` VALUES ('277', '95', '0.00', '4.10', '1493938641');
INSERT INTO `farm_user_profit` VALUES ('278', '92', '0.00', '4.16', '1493940102');
INSERT INTO `farm_user_profit` VALUES ('279', '100', '0.00', '4.05', '1493940652');
INSERT INTO `farm_user_profit` VALUES ('280', '99', '0.00', '4.10', '1493941459');
INSERT INTO `farm_user_profit` VALUES ('281', '91', '0.00', '4.16', '1493943182');
INSERT INTO `farm_user_profit` VALUES ('282', '97', '0.00', '4.10', '1493943283');
INSERT INTO `farm_user_profit` VALUES ('283', '81', '0.00', '1487.45', '1493955705');
INSERT INTO `farm_user_profit` VALUES ('284', '94', '0.00', '7.25', '1494025983');
INSERT INTO `farm_user_profit` VALUES ('285', '100', '0.00', '7.05', '1494030344');
INSERT INTO `farm_user_profit` VALUES ('286', '97', '0.00', '7.15', '1494030393');
INSERT INTO `farm_user_profit` VALUES ('287', '90', '0.00', '144.99', '1494034584');
INSERT INTO `farm_user_profit` VALUES ('288', '92', '0.00', '7.26', '1494035685');
INSERT INTO `farm_user_profit` VALUES ('289', '81', '0.00', '3751.18', '1494049080');
INSERT INTO `farm_user_profit` VALUES ('290', '91', '0.00', '5.36', '1494111278');
INSERT INTO `farm_user_profit` VALUES ('291', '97', '0.00', '5.08', '1494111439');
INSERT INTO `farm_user_profit` VALUES ('292', '90', '0.00', '126.39', '1494113605');
INSERT INTO `farm_user_profit` VALUES ('293', '92', '0.00', '5.28', '1494114387');
INSERT INTO `farm_user_profit` VALUES ('294', '99', '0.00', '4.96', '1494114658');
INSERT INTO `farm_user_profit` VALUES ('295', '94', '0.00', '5.14', '1494123625');
INSERT INTO `farm_user_profit` VALUES ('296', '100', '0.00', '5.01', '1494149430');
INSERT INTO `farm_user_profit` VALUES ('297', '91', '0.00', '6.29', '1494196103');
INSERT INTO `farm_user_profit` VALUES ('298', '97', '0.00', '5.16', '1494196186');
INSERT INTO `farm_user_profit` VALUES ('299', '94', '0.00', '5.23', '1494198686');
INSERT INTO `farm_user_profit` VALUES ('300', '92', '0.00', '5.36', '1494201829');
INSERT INTO `farm_user_profit` VALUES ('301', '100', '0.00', '5.09', '1494202490');
INSERT INTO `farm_user_profit` VALUES ('302', '81', '0.00', '851.48', '1494209489');
INSERT INTO `farm_user_profit` VALUES ('303', '99', '0.00', '5.04', '1494211253');
INSERT INTO `farm_user_profit` VALUES ('304', '91', '0.00', '6.39', '1494286374');
INSERT INTO `farm_user_profit` VALUES ('305', '92', '0.00', '5.45', '1494286396');
INSERT INTO `farm_user_profit` VALUES ('306', '97', '0.00', '5.24', '1494286433');
INSERT INTO `farm_user_profit` VALUES ('307', '94', '0.00', '5.31', '1494286620');
INSERT INTO `farm_user_profit` VALUES ('308', '90', '0.00', '58.45', '1494286821');
INSERT INTO `farm_user_profit` VALUES ('309', '100', '0.00', '5.17', '1494289894');
INSERT INTO `farm_user_profit` VALUES ('310', '84', '0.00', '4.96', '1494293566');
