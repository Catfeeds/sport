/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50027
Source Host           : 127.0.0.1:3306
Source Database       : moveup

Target Server Type    : MYSQL
Target Server Version : 50027
File Encoding         : 65001

Date: 2015-11-08 14:48:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for acount
-- ----------------------------
DROP TABLE IF EXISTS `acount`;
CREATE TABLE `acount` (
  `id` int(11) NOT NULL auto_increment,
  `acountType` int(11) NOT NULL,
  `beginDate` date default NULL,
  `date` datetime default NULL,
  `endDate` date default NULL,
  `payedDate` datetime default NULL,
  `status` int(11) default NULL,
  `totalFee` float default NULL,
  `coach_id` int(11) default NULL,
  `company_id` int(11) default NULL,
  `site_id` bigint(20) default NULL,
  `lastOrderDate` datetime default NULL,
  `latestAcount_id` int(11) default NULL,
  `payedTotalFee` float default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK7492516EDF1E28B` (`company_id`),
  KEY `FK7492516EBAB16809` (`site_id`),
  KEY `FK7492516E396AD9AB` (`coach_id`),
  KEY `FK7492516E1A8C9F42` (`latestAcount_id`),
  CONSTRAINT `FK7492516E1A8C9F42` FOREIGN KEY (`latestAcount_id`) REFERENCES `acount` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK7492516E396AD9AB` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK7492516EBAB16809` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK7492516EDF1E28B` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of acount
-- ----------------------------
INSERT INTO `acount` VALUES ('3', '0', '0010-12-15', null, '2015-10-29', '2015-10-29 10:40:26', '2', '0', null, null, '2', null, null, '0');
INSERT INTO `acount` VALUES ('7', '0', '2015-10-15', null, '2015-10-29', '2015-10-29 20:12:50', '2', '0', null, '1', null, null, null, '560');
INSERT INTO `acount` VALUES ('8', '0', '2015-10-15', null, '2015-10-29', '2015-10-29 21:32:10', '2', '0', null, null, '1', null, null, '150');

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(11) NOT NULL auto_increment,
  `addressName` varchar(255) default NULL,
  `grade` int(11) NOT NULL,
  `introduction` varchar(255) default NULL,
  `leaf` bit(1) NOT NULL,
  `parentAddress_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK1ED033D443B75755` (`parentAddress_id`),
  CONSTRAINT `FK1ED033D443B75755` FOREIGN KEY (`parentAddress_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('1', '湖南', '0', '', '\0', null);
INSERT INTO `address` VALUES ('2', '岳阳', '1', '', '\0', '1');
INSERT INTO `address` VALUES ('3', '湖北', '0', '', '\0', null);
INSERT INTO `address` VALUES ('4', '长沙', '1', '', '\0', '1');
INSERT INTO `address` VALUES ('5', '理工学院', '2', '', '', '2');
INSERT INTO `address` VALUES ('6', '郭镇', '2', '', '', '2');
INSERT INTO `address` VALUES ('7', '平江', '2', '', '', '2');
INSERT INTO `address` VALUES ('8', '6368社区', '2', '', '', '2');
INSERT INTO `address` VALUES ('9', '橘子洲', '2', '', '', '4');
INSERT INTO `address` VALUES ('10', '岳麓山', '2', '', '', '4');
INSERT INTO `address` VALUES ('13', '湖北市', '1', '', '\0', '3');
INSERT INTO `address` VALUES ('14', '武汉大学', '2', '', '', '13');
INSERT INTO `address` VALUES ('15', '火车东站', '2', '', '', '13');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` bigint(20) NOT NULL auto_increment,
  `content` longtext,
  `date` datetime default NULL,
  `grade` int(11) NOT NULL,
  `hasReport` bit(1) NOT NULL,
  `leaf` bit(1) NOT NULL,
  `reportCause` longtext,
  `supportNumber` int(11) NOT NULL,
  `title` varchar(255) default NULL,
  `forum_id` int(11) default NULL,
  `parentArticle_id` bigint(20) default NULL,
  `responser_person_id` int(11) default NULL,
  `rootArticle_id` bigint(20) default NULL,
  `talker_person_id` int(11) default NULL,
  `image_id` int(11) default NULL,
  `articleType` int(11) NOT NULL,
  `childArticleNumber` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK379164D65C087B23` (`talker_person_id`),
  KEY `FK379164D6165EA015` (`parentArticle_id`),
  KEY `FK379164D6B33A324D` (`rootArticle_id`),
  KEY `FK379164D65751131B` (`responser_person_id`),
  KEY `FK379164D68F3B384B` (`forum_id`),
  KEY `FK379164D63F70160B` (`image_id`),
  CONSTRAINT `FK379164D6165EA015` FOREIGN KEY (`parentArticle_id`) REFERENCES `article` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK379164D63F70160B` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`),
  CONSTRAINT `FK379164D65751131B` FOREIGN KEY (`responser_person_id`) REFERENCES `person` (`person_id`) ON DELETE SET NULL,
  CONSTRAINT `FK379164D65C087B23` FOREIGN KEY (`talker_person_id`) REFERENCES `person` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `FK379164D68F3B384B` FOREIGN KEY (`forum_id`) REFERENCES `forum` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK379164D6B33A324D` FOREIGN KEY (`rootArticle_id`) REFERENCES `article` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('66', '大是打发斯蒂芬', '2015-11-05 20:24:06', '0', '\0', '\0', null, '0', '的飞电风扇的', '4', null, null, null, '1', null, '1', '5');
INSERT INTO `article` VALUES ('75', '非广东省分公司东风公司的风格四到', '2015-11-05 20:28:05', '0', '\0', '\0', null, '0', '啥都给第三方鬼地方鬼地方广东省', '4', null, null, null, '1', null, '1', '2');
INSERT INTO `article` VALUES ('76', '第三方给第三方过水电费贵', '2015-11-05 20:28:14', '0', '\0', '\0', null, '2', '给给第三方贵电风扇', '4', null, null, null, '1', null, '2', '2');
INSERT INTO `article` VALUES ('77', '投入特温柔他娃儿委托人为v', '2015-11-05 20:28:35', '1', '\0', '', null, '0', null, '4', '76', null, '76', '1', null, '0', '0');
INSERT INTO `article` VALUES ('78', '非广东省分公司大范甘迪发', '2015-11-05 20:29:25', '1', '\0', '', null, '0', null, '4', '76', null, '76', '1', null, '0', '0');
INSERT INTO `article` VALUES ('79', '过水电费给第三方贵第三方给第三方', '2015-11-05 20:29:36', '0', '\0', '\0', null, '2', '发给鬼地方鬼地方给第三方', '4', null, null, null, '1', null, '1', '6');
INSERT INTO `article` VALUES ('80', '三个东风公司的风格三东风公司的风格发送到\r\n', '2015-11-05 20:29:51', '1', '\0', '\0', null, '0', null, '4', '66', null, '66', '1', null, '0', '12');
INSERT INTO `article` VALUES ('81', '啊啊啊', '2015-11-05 22:05:41', '1', '\0', '', null, '0', null, '4', '66', null, '66', '1', null, '0', '0');
INSERT INTO `article` VALUES ('82', '大概的鬼地方', '2015-11-05 22:06:06', '1', '\0', '\0', null, '0', null, '4', '66', null, '66', '1', null, '0', '1');
INSERT INTO `article` VALUES ('83', 'oooo', '2015-11-05 22:09:16', '1', '\0', '\0', null, '0', null, '4', '66', null, '66', '1', null, '0', '29');
INSERT INTO `article` VALUES ('84', 'oooosdfdsf', '2015-11-05 22:10:35', '1', '\0', '', null, '0', null, '4', '66', null, '66', '2', null, '0', '0');
INSERT INTO `article` VALUES ('85', 'xfsfsdffs', '2015-11-06 08:44:04', '1', '\0', '', null, '0', null, '4', '75', null, '75', '2', null, '0', '0');
INSERT INTO `article` VALUES ('86', 'dsfgdfgdfsgdfg', '2015-11-06 09:00:55', '1', '\0', '', null, '0', null, '4', '75', null, '75', '2', null, '0', '0');
INSERT INTO `article` VALUES ('87', 'dsfgdsfdsfds', '2015-11-06 09:03:52', '0', '\0', '', null, '0', 'dsfsdfdsaf', '4', null, null, null, '2', null, '0', '0');
INSERT INTO `article` VALUES ('88', 'dsfgdsfdsfds', '2015-11-06 09:05:18', '0', '\0', '', null, '0', 'dsfsdfdsaf', '4', null, null, null, '2', null, '0', '0');
INSERT INTO `article` VALUES ('89', 'dsfsdfsds', '2015-11-06 09:06:42', '0', '\0', '', null, '0', 'dsfgdsfsd', '4', null, null, null, '2', null, '0', '0');
INSERT INTO `article` VALUES ('90', 'dsfsdfsds', '2015-11-06 09:09:08', '0', '\0', '', null, '0', 'dsfgdsfsd', '4', null, null, null, '2', null, '0', '0');
INSERT INTO `article` VALUES ('91', 'fghgjgjg', '2015-11-06 09:12:39', '0', '\0', '', null, '0', 'xcgfgdf', '4', null, null, null, '2', null, '0', '0');
INSERT INTO `article` VALUES ('92', 'fghgjgjg', '2015-11-06 09:16:15', '0', '\0', '', null, '0', 'xcgfgdf', '4', null, null, null, '2', null, '0', '0');
INSERT INTO `article` VALUES ('93', 'fghgjgjg', '2015-11-06 09:19:33', '0', '\0', '', null, '0', 'xcgfgdf', '4', null, null, null, '2', null, '0', '0');
INSERT INTO `article` VALUES ('94', 'fghgjgjg', '2015-11-06 09:20:10', '0', '\0', '', null, '0', 'xcgfgdf', '4', null, null, null, '2', null, '0', '0');
INSERT INTO `article` VALUES ('95', '测试', '2015-11-06 09:22:59', '0', '\0', '', null, '0', '重定向测试', '4', null, null, null, '2', null, '0', '0');
INSERT INTO `article` VALUES ('96', 'ertererter', '2015-11-06 09:24:59', '1', '\0', '', null, '0', null, '4', '79', null, '79', '2', null, '0', '0');
INSERT INTO `article` VALUES ('97', 'ertererter', '2015-11-06 09:27:46', '1', '\0', '', null, '0', null, '4', '79', null, '79', '2', null, '0', '0');
INSERT INTO `article` VALUES ('98', 'ddddddd', '2015-11-06 09:30:59', '1', '\0', '', null, '0', null, '4', '79', null, '79', '2', null, '0', '0');
INSERT INTO `article` VALUES ('99', 'fghfghgh', '2015-11-06 09:35:15', '1', '\0', '', null, '0', null, '4', '79', null, '79', '2', null, '0', '0');
INSERT INTO `article` VALUES ('100', 'hhhhhhh', '2015-11-06 09:35:27', '1', '\0', '', null, '0', null, '4', '79', null, '79', '2', null, '0', '0');
INSERT INTO `article` VALUES ('101', 'ggggggggg', '2015-11-06 09:35:38', '1', '\0', '', null, '0', null, '4', '79', null, '79', '2', null, '0', '0');
INSERT INTO `article` VALUES ('102', 'fghfghfghfghfg', '2015-11-06 09:38:04', '0', '\0', '', null, '0', 'fgfghfhfgh', '4', null, null, null, '2', null, '0', '0');
INSERT INTO `article` VALUES ('103', 'fghfghfgh', '2015-11-06 09:43:00', '0', '\0', '\0', null, '0', 'dfgdfgdgd', '4', null, null, null, '2', null, '1', '4');
INSERT INTO `article` VALUES ('104', 'dfgdfgdfgdfgf', '2015-11-06 09:43:09', '1', '\0', '\0', null, '0', null, '4', '103', null, '103', '2', null, '1', '1');
INSERT INTO `article` VALUES ('105', 'gmgghjfgjfghfghdh', '2015-11-06 09:43:15', '1', '\0', '', null, '0', null, '4', '103', null, '103', '2', null, '1', '0');
INSERT INTO `article` VALUES ('106', 'lkdfjldksjfldsjds', '2015-11-06 09:49:53', '1', '\0', '', null, '0', null, '4', '103', null, '103', '2', null, '1', '0');
INSERT INTO `article` VALUES ('107', '', '2015-11-06 09:59:20', '1', '\0', '', null, '0', null, '4', '103', null, '103', '2', '218', '1', '0');
INSERT INTO `article` VALUES ('108', '\n											李佳兴 回复： 李佳兴，你好！', '2015-11-06 12:12:03', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '2', null, '0', '0');
INSERT INTO `article` VALUES ('109', '回复:张俊：dfgdfgdfgdfdgdgf', '2015-11-06 12:29:06', '2', '\0', '', null, '0', null, '4', '83', '2', '83', '2', null, '0', '0');
INSERT INTO `article` VALUES ('110', '回复:张俊：你好啊，淡远', '2015-11-06 12:29:47', '2', '\0', '', null, '0', null, '4', '83', '2', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('124', '回复:张俊：nihao', '2015-11-06 19:22:17', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('125', '回复:张俊：nihaome', '2015-11-06 19:31:40', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('126', '回复:张俊：nihaoa ', '2015-11-06 20:11:43', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('127', '回复:张俊：nihaoa ', '2015-11-06 20:11:46', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('128', '回复:张俊：nihaoa ', '2015-11-06 20:11:48', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('129', '回复:张俊：nihaoa ', '2015-11-06 20:11:50', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('130', '回复:张俊：nihaoa ', '2015-11-06 20:11:52', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('131', '回复:张俊：nihaoa ', '2015-11-06 20:12:01', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('132', '回复:张俊：nihaoa ', '2015-11-06 20:12:03', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('133', '回复:张俊：nihaoa ', '2015-11-06 20:12:04', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('134', 'nihao', '2015-11-06 20:14:53', '2', '\0', '', null, '0', null, '4', '82', '1', '82', '1', null, '0', '0');
INSERT INTO `article` VALUES ('135', '回复:李佳兴：dsfsdf', '2015-11-06 20:17:29', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('136', '回复:李佳兴：dsfsdf', '2015-11-06 20:20:07', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('137', '回复:李佳兴：dsfsdf', '2015-11-06 20:23:50', '2', '\0', '', null, '0', null, '4', '83', '1', '83', '1', null, '0', '0');
INSERT INTO `article` VALUES ('138', '你好啊', '2015-11-06 20:34:39', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('139', '你好啊', '2015-11-06 20:34:41', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('140', '你好啊', '2015-11-06 20:34:42', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('141', '你好啊', '2015-11-06 20:34:47', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('142', '你好啊', '2015-11-06 20:34:49', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('143', '你好啊', '2015-11-06 20:34:51', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('144', '你好啊', '2015-11-06 20:34:52', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('145', '你好啊', '2015-11-06 20:34:54', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('146', '你好啊', '2015-11-06 20:34:56', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('147', '你好啊', '2015-11-06 20:34:57', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('148', '你好啊', '2015-11-06 20:34:59', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('149', '你好啊', '2015-11-06 20:35:00', '2', '\0', '', null, '0', null, '4', '80', '1', '80', '1', null, '0', '0');
INSERT INTO `article` VALUES ('150', '傻逼', '2015-11-07 11:26:16', '0', '\0', '\0', null, '0', '李佳兴是傻逼', '4', null, null, null, '2', '219', '1', '1');
INSERT INTO `article` VALUES ('151', '恩呢，是的，就是傻逼。。。。。', '2015-11-07 11:26:46', '1', '\0', '\0', null, '0', null, '4', '150', null, '150', '2', '220', '1', '2');
INSERT INTO `article` VALUES ('152', '我靠，真尼玛傻！', '2015-11-07 11:27:05', '2', '\0', '', null, '0', null, '4', '151', '2', '151', '2', null, '0', '0');
INSERT INTO `article` VALUES ('153', '回复:张俊：嗯嗯，我也觉得佳兴是傻逼呢。。。。。。', '2015-11-07 11:28:00', '2', '\0', '', null, '0', null, '4', '151', '2', '151', '2', null, '0', '0');
INSERT INTO `article` VALUES ('154', '主意啦，公告贴哦。。。。。。。', '2015-11-07 19:01:54', '0', '\0', '', null, '0', '大家好，这是公告贴哦！', '4', null, null, null, '1', '221', '2', '0');
INSERT INTO `article` VALUES ('155', '你好啊。。。。。', '2015-11-07 19:04:32', '2', '\0', '', null, '0', null, '4', '104', '2', '104', '1', null, '0', '0');
INSERT INTO `article` VALUES ('156', '鬼地方三个地方三个地方', '2015-11-07 19:23:19', '0', '\0', '', null, '0', '大范甘迪发送给电风扇', '4', null, null, null, '1', null, '1', '0');
INSERT INTO `article` VALUES ('157', '三鬼地方三个地方三个的', '2015-11-07 19:23:26', '0', '\0', '', null, '0', '大范甘迪发送给电风扇给', '4', null, null, null, '1', null, '1', '0');
INSERT INTO `article` VALUES ('158', '鬼地方三个大范甘迪发送给费点', '2015-11-07 19:23:33', '0', '\0', '', null, '0', '地方鬼地方三个地方三个地方', '4', null, null, null, '1', null, '1', '0');
INSERT INTO `article` VALUES ('159', '鬼地方三个地方三个地方', '2015-11-07 19:23:41', '0', '\0', '', null, '0', '第三方鬼地方三个地方三个地方三', '4', null, null, null, '1', null, '1', '0');
INSERT INTO `article` VALUES ('160', '这里是帖子内容哦。。。。', '2015-11-07 19:52:37', '0', '\0', '\0', null, '7', '微信端发布帖子哦', '4', null, null, null, '2', '222', '1', '12');
INSERT INTO `article` VALUES ('161', '我在微信端回复你哦。。。。', '2015-11-07 20:24:21', '1', '\0', '\0', null, '0', null, '4', '160', null, '160', '2', null, '1', '7');
INSERT INTO `article` VALUES ('162', '2我在微信端回复你哦。。。。', '2015-11-07 20:24:46', '1', '\0', '', null, '0', null, '4', '160', null, '160', '2', null, '1', '0');
INSERT INTO `article` VALUES ('163', '1微信', '2015-11-07 20:25:50', '1', '\0', '', null, '0', null, '4', '160', null, '160', '2', null, '1', '0');
INSERT INTO `article` VALUES ('164', '2微信', '2015-11-07 20:26:02', '1', '\0', '', null, '0', null, '4', '160', null, '160', '2', null, '1', '0');
INSERT INTO `article` VALUES ('165', '3微信', '2015-11-07 20:26:09', '1', '\0', '', null, '0', null, '4', '160', null, '160', '2', null, '1', '0');
INSERT INTO `article` VALUES ('166', '4微信', '2015-11-07 20:26:14', '1', '\0', '', null, '0', null, '4', '160', null, '160', '2', null, '1', '0');
INSERT INTO `article` VALUES ('167', '5微信', '2015-11-07 20:26:19', '1', '\0', '', null, '0', null, '4', '160', null, '160', '2', null, '1', '0');
INSERT INTO `article` VALUES ('168', '6微信', '2015-11-07 20:26:25', '1', '\0', '', null, '0', null, '4', '160', null, '160', '2', null, '1', '0');
INSERT INTO `article` VALUES ('169', '6微信', '2015-11-07 20:26:31', '1', '\0', '', null, '0', null, '4', '160', null, '160', '2', null, '1', '0');
INSERT INTO `article` VALUES ('170', '7微信', '2015-11-07 20:26:37', '1', '\0', '', null, '0', null, '4', '160', null, '160', '2', null, '1', '0');
INSERT INTO `article` VALUES ('171', '你好啊', '2015-11-07 20:48:47', '2', '\0', '\0', null, '0', null, '4', '161', null, '161', '2', null, '1', '1');
INSERT INTO `article` VALUES ('172', '你妹啊', '2015-11-07 20:49:13', '3', '\0', '', null, '0', null, '4', '171', null, '171', '2', null, '1', '0');
INSERT INTO `article` VALUES ('173', '你妹啊啊啊', '2015-11-07 20:50:16', '2', '\0', '', null, '0', null, '4', '161', null, '161', '2', null, '1', '0');
INSERT INTO `article` VALUES ('174', '你好啊', '2015-11-07 20:56:20', '2', '\0', '', null, '0', null, '4', '161', null, '161', '2', null, '1', '0');
INSERT INTO `article` VALUES ('175', 'aaa', '2015-11-07 21:04:39', '2', '\0', '', null, '0', null, '4', '161', null, '161', '2', null, '1', '0');
INSERT INTO `article` VALUES ('176', 'dfgdfgdfg', '2015-11-07 21:08:08', '1', '\0', '', null, '0', null, '4', '160', null, '160', '2', null, '1', '0');
INSERT INTO `article` VALUES ('177', '你好啊', '2015-11-07 21:47:38', '2', '\0', '', null, '0', null, '4', '161', null, '161', '2', null, '1', '0');
INSERT INTO `article` VALUES ('178', 'nihao', '2015-11-07 21:53:28', '2', '\0', '', null, '0', null, '4', '161', null, '161', '2', null, '1', '0');
INSERT INTO `article` VALUES ('179', 'aaaa', '2015-11-07 22:10:20', '2', '\0', '', null, '0', null, '4', '161', null, '161', '2', null, '1', '0');
INSERT INTO `article` VALUES ('180', 'dvddf', '2015-11-07 22:11:09', '1', '\0', '', null, '0', null, '4', '160', null, '160', '2', null, '1', '0');
INSERT INTO `article` VALUES ('181', 'dfgdfsgdfsgdfsgd', '2015-11-08 09:05:52', '0', '\0', '', null, '0', 'dfdfgdfsg', '5', null, null, null, '2', '223', '1', '0');
INSERT INTO `article` VALUES ('182', '加香妹子，哈哈哈哈哈哈哈哈。。。。下面附图一张。。。。。', '2015-11-08 09:07:02', '0', '\0', '', null, '0', '大家好，我叫李佳兴，大家可以叫我加香妹子。。。。', '5', null, null, null, '2', '224', '1', '0');

-- ----------------------------
-- Table structure for coach
-- ----------------------------
DROP TABLE IF EXISTS `coach`;
CREATE TABLE `coach` (
  `dayJobTime` varchar(255) default NULL,
  `introduction` longtext,
  `registerDate` datetime default NULL,
  `score` bigint(20) default NULL,
  `totalSoldNumber` bigint(20) default NULL,
  `weekJobTime` varchar(255) default NULL,
  `id` int(11) NOT NULL,
  `company_id` int(11) default NULL,
  `skillType_id` int(11) default NULL,
  `employNumber` int(11) NOT NULL,
  `basePrice` float NOT NULL,
  `topValue` int(11) NOT NULL,
  `baseCostPrice` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK3E4147AEE6E885F` (`id`),
  KEY `FK3E4147ADF1E28B` (`company_id`),
  KEY `FK3E4147A13DE8709` (`skillType_id`),
  CONSTRAINT `FK3E4147A13DE8709` FOREIGN KEY (`skillType_id`) REFERENCES `producttype` (`id`),
  CONSTRAINT `FK3E4147ADF1E28B` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `FK3E4147AEE6E885F` FOREIGN KEY (`id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of coach
-- ----------------------------
INSERT INTO `coach` VALUES ('1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,0,0,0,0,0,0', null, null, '5', '0', '1,1,1,1,1,1,1', '83', '1', '5', '11', '12', '0', '11.0,22.0,33.0,113.0');
INSERT INTO `coach` VALUES ('1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,1,0,0', null, null, '5', '0', '1,1,1,1,1,1,1', '84', '1', '5', '12', '11', '0', '11.0,22.0,11.0,33.0');
INSERT INTO `coach` VALUES ('1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0', null, null, '5', '0', '1,1,1,1,1,1,1', '85', '1', '5', '12', '22', '0', '11.0,22.0,33.0,55.0');

-- ----------------------------
-- Table structure for coachcost
-- ----------------------------
DROP TABLE IF EXISTS `coachcost`;
CREATE TABLE `coachcost` (
  `id` int(11) NOT NULL auto_increment,
  `introduction` longtext,
  `timePrice` varchar(255) default NULL,
  `coach_id` int(11) default NULL,
  `product_id` int(11) default NULL,
  `employNumber` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK92916B67A67D9A0F` (`product_id`),
  KEY `FK92916B67396AD9AB` (`coach_id`),
  CONSTRAINT `FK92916B67396AD9AB` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`id`) ON DELETE CASCADE ON UPDATE SET NULL,
  CONSTRAINT `FK92916B67A67D9A0F` FOREIGN KEY (`product_id`) REFERENCES `coachproduct` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of coachcost
-- ----------------------------
INSERT INTO `coachcost` VALUES ('127', null, '11,22,33,11', '83', '12', '0');
INSERT INTO `coachcost` VALUES ('128', null, '11,22,11,55', '84', '12', '0');

-- ----------------------------
-- Table structure for coachpreorder
-- ----------------------------
DROP TABLE IF EXISTS `coachpreorder`;
CREATE TABLE `coachpreorder` (
  `id` int(11) NOT NULL auto_increment,
  `orderInfo` longtext,
  `coach_id` int(11) default NULL,
  `date` date default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK96F97105396AD9AB` (`coach_id`),
  CONSTRAINT `FK96F97105396AD9AB` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of coachpreorder
-- ----------------------------
INSERT INTO `coachpreorder` VALUES ('1185', '11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11', '83', '2015-11-05');
INSERT INTO `coachpreorder` VALUES ('1186', '11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11', '83', '2015-11-06');
INSERT INTO `coachpreorder` VALUES ('1187', '11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11', '83', '2015-11-07');
INSERT INTO `coachpreorder` VALUES ('1188', '0,11,11,0,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11', '83', '2015-11-08');
INSERT INTO `coachpreorder` VALUES ('1189', '11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11', '83', '2015-11-09');
INSERT INTO `coachpreorder` VALUES ('1190', '11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11', '83', '2015-11-10');
INSERT INTO `coachpreorder` VALUES ('1191', '11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11', '83', '2015-11-11');
INSERT INTO `coachpreorder` VALUES ('1192', '11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11', '83', '2015-11-12');
INSERT INTO `coachpreorder` VALUES ('1193', '11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11', '83', '2015-11-13');
INSERT INTO `coachpreorder` VALUES ('1194', '11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11', '83', '2015-11-14');
INSERT INTO `coachpreorder` VALUES ('1195', '0,12,12,0,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '84', '2015-11-08');
INSERT INTO `coachpreorder` VALUES ('1196', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '84', '2015-11-09');
INSERT INTO `coachpreorder` VALUES ('1197', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '84', '2015-11-10');
INSERT INTO `coachpreorder` VALUES ('1198', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '84', '2015-11-11');
INSERT INTO `coachpreorder` VALUES ('1199', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '84', '2015-11-12');
INSERT INTO `coachpreorder` VALUES ('1200', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '84', '2015-11-13');
INSERT INTO `coachpreorder` VALUES ('1201', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '84', '2015-11-14');
INSERT INTO `coachpreorder` VALUES ('1202', '0,12,12,0,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '85', '2015-11-08');
INSERT INTO `coachpreorder` VALUES ('1203', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '85', '2015-11-09');
INSERT INTO `coachpreorder` VALUES ('1204', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '85', '2015-11-10');
INSERT INTO `coachpreorder` VALUES ('1205', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '85', '2015-11-11');
INSERT INTO `coachpreorder` VALUES ('1206', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '85', '2015-11-12');
INSERT INTO `coachpreorder` VALUES ('1207', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '85', '2015-11-13');
INSERT INTO `coachpreorder` VALUES ('1208', '12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12', '85', '2015-11-14');

-- ----------------------------
-- Table structure for coachproduct
-- ----------------------------
DROP TABLE IF EXISTS `coachproduct`;
CREATE TABLE `coachproduct` (
  `id` int(11) NOT NULL,
  `employNumber` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKFD333315F55EF7FB` (`id`),
  CONSTRAINT `FKFD333315F55EF7FB` FOREIGN KEY (`id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of coachproduct
-- ----------------------------
INSERT INTO `coachproduct` VALUES ('6', '5');
INSERT INTO `coachproduct` VALUES ('12', '22');
INSERT INTO `coachproduct` VALUES ('13', '22');

-- ----------------------------
-- Table structure for coachproduct_company
-- ----------------------------
DROP TABLE IF EXISTS `coachproduct_company`;
CREATE TABLE `coachproduct_company` (
  `CoachProduct_id` int(11) NOT NULL,
  `companys_id` int(11) NOT NULL,
  KEY `FKE5CC9332BC32629` (`CoachProduct_id`),
  KEY `FKE5CC9332238C8D2` (`companys_id`),
  CONSTRAINT `FKE5CC9332238C8D2` FOREIGN KEY (`companys_id`) REFERENCES `company` (`id`),
  CONSTRAINT `FKE5CC9332BC32629` FOREIGN KEY (`CoachProduct_id`) REFERENCES `coachproduct` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of coachproduct_company
-- ----------------------------

-- ----------------------------
-- Table structure for coachproduct_site
-- ----------------------------
DROP TABLE IF EXISTS `coachproduct_site`;
CREATE TABLE `coachproduct_site` (
  `coachProducts_id` int(11) NOT NULL,
  `sites_id` bigint(20) NOT NULL,
  KEY `FK7B0C7E5165D28B24` (`sites_id`),
  KEY `FK7B0C7E518923CA0` (`coachProducts_id`),
  CONSTRAINT `FK7B0C7E5165D28B24` FOREIGN KEY (`sites_id`) REFERENCES `site` (`id`),
  CONSTRAINT `FK7B0C7E518923CA0` FOREIGN KEY (`coachProducts_id`) REFERENCES `coachproduct` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of coachproduct_site
-- ----------------------------

-- ----------------------------
-- Table structure for coach_address
-- ----------------------------
DROP TABLE IF EXISTS `coach_address`;
CREATE TABLE `coach_address` (
  `Coach_id` int(11) NOT NULL,
  `addrs_id` int(11) NOT NULL,
  KEY `FK8C8CD50F7ACAADBD` (`addrs_id`),
  KEY `FK8C8CD50F396AD9AB` (`Coach_id`),
  KEY `addrs_id` USING BTREE (`addrs_id`),
  CONSTRAINT `FK8C8CD50F396AD9AB` FOREIGN KEY (`Coach_id`) REFERENCES `coach` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK8C8CD50F7ACAADBD` FOREIGN KEY (`addrs_id`) REFERENCES `address` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of coach_address
-- ----------------------------
INSERT INTO `coach_address` VALUES ('83', '5');
INSERT INTO `coach_address` VALUES ('84', '5');

-- ----------------------------
-- Table structure for coach_coachproduct
-- ----------------------------
DROP TABLE IF EXISTS `coach_coachproduct`;
CREATE TABLE `coach_coachproduct` (
  `Coach_id` int(11) NOT NULL,
  `coachProducts_id` int(11) NOT NULL,
  KEY `FKE5E11EBA8923CA0` (`coachProducts_id`),
  KEY `FKE5E11EBA396AD9AB` (`Coach_id`),
  KEY `coachProducts_id` USING BTREE (`coachProducts_id`),
  CONSTRAINT `FKE5E11EBA396AD9AB` FOREIGN KEY (`Coach_id`) REFERENCES `coach` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKE5E11EBA8923CA0` FOREIGN KEY (`coachProducts_id`) REFERENCES `coachproduct` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of coach_coachproduct
-- ----------------------------
INSERT INTO `coach_coachproduct` VALUES ('83', '12');
INSERT INTO `coach_coachproduct` VALUES ('84', '12');

-- ----------------------------
-- Table structure for coach_image
-- ----------------------------
DROP TABLE IF EXISTS `coach_image`;
CREATE TABLE `coach_image` (
  `Coach_id` int(11) NOT NULL,
  `photoes_id` int(11) default NULL,
  `certificates_id` int(11) default NULL,
  UNIQUE KEY `photoes_id` (`photoes_id`),
  UNIQUE KEY `certificates_id` (`certificates_id`),
  KEY `FK61916D3654BF5EE6` (`photoes_id`),
  KEY `FK61916D363C08E60A` (`certificates_id`),
  KEY `FK61916D36396AD9AB` (`Coach_id`),
  CONSTRAINT `FK61916D36396AD9AB` FOREIGN KEY (`Coach_id`) REFERENCES `coach` (`id`),
  CONSTRAINT `FK61916D363C08E60A` FOREIGN KEY (`certificates_id`) REFERENCES `image` (`id`),
  CONSTRAINT `FK61916D3654BF5EE6` FOREIGN KEY (`photoes_id`) REFERENCES `image` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of coach_image
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL auto_increment,
  `detail` longtext,
  `hasReply` bit(1) NOT NULL,
  `hasReport` bit(1) NOT NULL,
  `replyContent` longtext,
  `reportCause` longtext,
  `score` int(11) NOT NULL,
  `time` datetime default NULL,
  `company_id` int(11) default NULL,
  `product_product_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `coach_id` int(11) default NULL,
  `site_id` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK9BDE863FDF1E28B` (`company_id`),
  KEY `FK9BDE863F65AE229B` (`product_product_id`),
  KEY `FK9BDE863F34C1E989` (`user_id`),
  KEY `FK9BDE863F396AD9AB` (`coach_id`),
  KEY `FK9BDE863FBAB16809` (`site_id`),
  CONSTRAINT `FK9BDE863F34C1E989` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK9BDE863F396AD9AB` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK9BDE863F65AE229B` FOREIGN KEY (`product_product_id`) REFERENCES `product` (`product_id`) ON DELETE SET NULL,
  CONSTRAINT `FK9BDE863FBAB16809` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK9BDE863FDF1E28B` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('5', '场地环境很好，服务也不错', '\0', '\0', null, null, '4', '2015-10-06 21:17:05', '1', '2', '2', null, null);
INSERT INTO `comment` VALUES ('6', '很好很好，环境很优美、服务很周到。。。。', '\0', '\0', null, null, '5', '2015-10-06 21:18:26', '1', '2', '2', null, null);
INSERT INTO `comment` VALUES ('7', '环境优美，服务周到', '\0', '\0', null, null, '5', '2015-10-06 21:22:40', '1', '2', '2', null, null);
INSERT INTO `comment` VALUES ('8', '很好很好', '\0', '\0', null, null, '5', '2015-10-06 21:31:23', '1', '2', '2', null, null);
INSERT INTO `comment` VALUES ('9', '很好很好', '\0', '\0', null, null, '5', '2015-10-06 21:37:44', '1', '2', '2', null, null);
INSERT INTO `comment` VALUES ('10', '很好很好', '\0', '\0', null, null, '5', '2015-10-06 21:37:52', '1', '2', '2', null, null);
INSERT INTO `comment` VALUES ('11', '很好很好', '\0', '\0', null, null, '5', '2015-10-06 21:38:00', '1', '2', '2', null, null);
INSERT INTO `comment` VALUES ('12', '很好很好', '\0', '\0', null, null, '5', '2015-10-06 21:38:14', '1', '2', '2', null, null);
INSERT INTO `comment` VALUES ('13', '很好很好', '\0', '\0', null, null, '5', '2015-10-06 22:03:57', '1', '2', '2', null, null);
INSERT INTO `comment` VALUES ('14', '很好很好', '\0', '\0', null, null, '4', '2015-10-21 19:21:55', '1', null, '2', null, null);
INSERT INTO `comment` VALUES ('15', '还好，还好哦！', '\0', '\0', null, null, '4', '2015-10-21 19:32:05', '1', null, '2', null, null);
INSERT INTO `comment` VALUES ('18', '很好很好！', '', '\0', 'dsfgsgsdfgdafsf', null, '5', '2015-10-21 21:25:19', '1', '2', '2', null, null);

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` int(11) NOT NULL auto_increment,
  `addressDetail` varchar(255) default NULL,
  `companyName` varchar(255) default NULL,
  `companyUrl` varchar(255) default NULL,
  `date` datetime default NULL,
  `detail` longtext,
  `email` varchar(255) default NULL,
  `flag` bit(1) NOT NULL,
  `host` bit(1) NOT NULL,
  `introduction` longtext,
  `phone` varchar(255) default NULL,
  `registerDate` datetime default NULL,
  `address_id` int(11) default NULL,
  `logoImage_id` int(11) default NULL,
  `proofFile_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK9BDFD45DA0C400B6` (`logoImage_id`),
  KEY `FK9BDFD45D13579B2B` (`address_id`),
  KEY `FK9BDFD45D84824C86` (`proofFile_id`),
  CONSTRAINT `FK9BDFD45D13579B2B` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `FK9BDFD45D84824C86` FOREIGN KEY (`proofFile_id`) REFERENCES `image` (`id`),
  CONSTRAINT `FK9BDFD45DA0C400B6` FOREIGN KEY (`logoImage_id`) REFERENCES `image` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES ('1', null, '木鸢工作室', null, null, '', '', '', '', '<p>我们是一家提供网站应用、微信应用、手机APP开发的工作室。</p>', '15200292390', null, '5', '100', '1');
INSERT INTO `company` VALUES ('5', null, 'elm', null, null, null, null, '', '\0', 'safasd', '15200228232', '2015-10-30 23:13:23', '6', null, '164');
INSERT INTO `company` VALUES ('6', null, 'aaa', null, null, '', '', '\0', '\0', '<p>adfadsfasdf</p>', '11111111222', null, '5', '173', '172');
INSERT INTO `company` VALUES ('7', null, 'bbb', null, null, null, null, '\0', '\0', 'adfadsfasdf', '11111111222', '2015-10-31 23:51:24', '6', null, '174');
INSERT INTO `company` VALUES ('8', null, 'ccc', null, null, null, null, '\0', '\0', 'adfadsfasdf', '11111111222', '2015-10-31 23:55:07', '7', null, '175');
INSERT INTO `company` VALUES ('10', null, 'sdfssf', null, null, null, null, '\0', '\0', 'dfgvdgdfg', '13434324', '2015-11-02 20:41:42', '6', null, '179');

-- ----------------------------
-- Table structure for discount
-- ----------------------------
DROP TABLE IF EXISTS `discount`;
CREATE TABLE `discount` (
  `id` int(11) NOT NULL auto_increment,
  `beginDate` datetime default NULL,
  `detail` longtext,
  `endDate` datetime default NULL,
  `introduction` longtext,
  `title` varchar(255) default NULL,
  `coach_id` int(11) default NULL,
  `preViewImg_id` int(11) default NULL,
  `site_id` bigint(20) default NULL,
  `discountStatus` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK1422D961BAB16809` (`site_id`),
  KEY `FK1422D961396AD9AB` (`coach_id`),
  KEY `FK1422D961AD7A9C6B` (`preViewImg_id`),
  CONSTRAINT `FK1422D961396AD9AB` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK1422D961AD7A9C6B` FOREIGN KEY (`preViewImg_id`) REFERENCES `image` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK1422D961BAB16809` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of discount
-- ----------------------------
INSERT INTO `discount` VALUES ('27', '2015-11-01 00:00:00', '<p>zxcvzxcvx<br/></p>', '2015-11-11 00:00:00', 'xzvcxzvv', 'dfgdfsgdfs', null, '165', null, '1', '2');
INSERT INTO `discount` VALUES ('28', '2015-11-10 00:00:00', '<p>asfadsfadsf<br/></p>', '2015-11-27 00:00:00', 'asfadsfdsfdsf', 'xcfvdsfdsf', null, '166', null, '1', '1');
INSERT INTO `discount` VALUES ('29', '2015-11-01 00:00:00', '<p>afdsfdas<br/></p>', '2015-11-26 00:00:00', 'sdfdsfdsf', 'asdfdasfdsaf', null, '167', null, '1', '1');
INSERT INTO `discount` VALUES ('30', '2015-10-31 00:00:00', null, '2015-11-17 00:00:00', null, 'asdfadsf', null, '180', null, '0', '1');
INSERT INTO `discount` VALUES ('31', '2015-10-31 00:00:00', null, '2015-11-26 00:00:00', null, 'sdfdsfdas', null, '181', null, '0', '1');
INSERT INTO `discount` VALUES ('32', '2015-10-31 00:00:00', '<p>dsfgsdfgsd<img src=\"ueditor/jsp/upload/image/20151031/1446294865485099150.jpg\" title=\"1446294865485099150.jpg\" alt=\"aea0e20e718efff56ebf18a4cfd90b2d.jpg\"/></p>', '2015-11-19 00:00:00', 'fgfdsgdfs', 'dsfgdfsgds', null, '170', null, '0', '2');
INSERT INTO `discount` VALUES ('33', '2015-10-31 00:00:00', '<p>sdfgdfsgd<br/></p>', '2015-11-19 00:00:00', 'sdfgfdsgdfgf', 'sdfgdfgdfs', null, '171', null, '0', '2');

-- ----------------------------
-- Table structure for event
-- ----------------------------
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
  `id` int(11) NOT NULL auto_increment,
  `author` varchar(255) default NULL,
  `event_content` longtext,
  `event_title` varchar(255) default NULL,
  `img_path` varchar(255) default NULL,
  `time` datetime default NULL,
  `image_id` int(11) default NULL,
  `person_person_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK403827A3F70160B` (`image_id`),
  KEY `FK403827AF5D7451F` (`person_person_id`),
  CONSTRAINT `FK403827AF5D7451F` FOREIGN KEY (`person_person_id`) REFERENCES `person` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `FK403827A3F70160B` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of event
-- ----------------------------
INSERT INTO `event` VALUES ('1', 'dd', 'sfdsafdasf', 'dsf', '/upload/file/companyInfo/companyRegisterFile/logo14469629231731446962923172index.gif', '2015-11-18 00:00:00', '233', null);
INSERT INTO `event` VALUES ('2', 'sfdds', 'sfdsfds', 'sfds', '/upload/file/companyInfo/companyRegisterFile/logo14469640386381446964038636index.gif', '2015-11-03 00:00:00', '234', null);
INSERT INTO `event` VALUES ('3', 'sdfds', 'sdfdsf', 'sdfs', null, '2015-11-20 00:00:00', null, null);
INSERT INTO `event` VALUES ('4', 'sfds', 'sdfdsfds', 'sfds', null, '2015-11-18 00:00:00', null, null);
INSERT INTO `event` VALUES ('5', 'sdfs', 'sdfdsfs', 'sfds', null, '2015-11-11 00:00:00', null, null);
INSERT INTO `event` VALUES ('6', 'sdf', 'sdfdsfs', 'sdfds', null, '2015-11-18 00:00:00', null, null);
INSERT INTO `event` VALUES ('7', 'sdf', 'sdfsdfs', 'sdfs', null, '2015-11-11 00:00:00', null, null);
INSERT INTO `event` VALUES ('11', 'sdf', 'sdfdsfds', 'sdf', null, '2015-11-11 00:00:00', null, null);
INSERT INTO `event` VALUES ('12', 'sdfsd', 'sdfdsf', 'sdfsd', null, '2015-11-17 00:00:00', null, null);
INSERT INTO `event` VALUES ('13', 'sdfs', '啊飒飒大师的', '足球赛哦', '/upload/file/companyInfo/companyRegisterFile/logo1446965241391服务器工作原理(张俊).png', '2015-11-17 00:00:00', '236', null);

-- ----------------------------
-- Table structure for forum
-- ----------------------------
DROP TABLE IF EXISTS `forum`;
CREATE TABLE `forum` (
  `id` int(11) NOT NULL auto_increment,
  `classType` varchar(255) default NULL,
  `createDate` datetime default NULL,
  `forumName` varchar(255) default NULL,
  `introduction` longtext,
  `logoImage_id` int(11) default NULL,
  `owner_person_id` int(11) default NULL,
  `type_id` int(11) default NULL,
  `articleNumber` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK40E9D01A0C400B6` (`logoImage_id`),
  KEY `FK40E9D01D17D5E7A` (`type_id`),
  KEY `FK40E9D0190007EFD` (`owner_person_id`),
  CONSTRAINT `FK40E9D0190007EFD` FOREIGN KEY (`owner_person_id`) REFERENCES `person` (`person_id`) ON DELETE CASCADE,
  CONSTRAINT `FK40E9D01A0C400B6` FOREIGN KEY (`logoImage_id`) REFERENCES `image` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK40E9D01D17D5E7A` FOREIGN KEY (`type_id`) REFERENCES `producttype` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of forum
-- ----------------------------
INSERT INTO `forum` VALUES ('2', '3', '2015-11-03 21:15:41', '羽毛球', '羽毛球', '192', '1', '5', '0');
INSERT INTO `forum` VALUES ('3', '2', '2015-11-03 21:17:17', '减脂塑形', '爱运动，爱生活', '191', '1', '18', '19');
INSERT INTO `forum` VALUES ('4', '1', '2015-11-03 21:30:56', '淡远', '似懂非懂沙发', '190', '1', '16', '161');
INSERT INTO `forum` VALUES ('5', '4', '2015-11-03 22:12:29', '足球爱好者', '爱好足球', '189', '1', '11', '7');
INSERT INTO `forum` VALUES ('6', '1', '2015-11-08 09:18:19', '老王八', '松岛枫第三方', '226', '1', '5', '0');

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image` (
  `id` int(11) NOT NULL auto_increment,
  `companyIdStr` varchar(255) default NULL,
  `diskName` varchar(255) default NULL,
  `fileExt` varchar(255) default NULL,
  `name` varchar(255) NOT NULL,
  `parentDir` varchar(255) default NULL,
  `pathName` varchar(255) default NULL,
  `picNumber` int(11) NOT NULL,
  `type` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `pathName` (`pathName`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES ('1', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\壁纸20140412153428.jpg1443194773107', '.jpg1443194773107', '壁纸20140412153428.jpg1443194773107', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/壁纸20140412153428.jpg1443194773107', '0', 'file');
INSERT INTO `image` VALUES ('2', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443248891440.jpg', '.jpg', '11443248891440.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443248891440.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('3', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443248891952.jpg', '.jpg', '11443248891952.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443248891952.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('4', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443248891955.jpg', '.jpg', '11443248891955.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443248891955.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('5', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14432512239991443251401861.jpg', '.jpg', '14432512239991443251401861.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14432512239991443251401861.jpg', '3', 'midpic');
INSERT INTO `image` VALUES ('6', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14432512239991443251401863.jpg', '.jpg', '14432512239991443251401863.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14432512239991443251401863.jpg', '2', 'midpic');
INSERT INTO `image` VALUES ('7', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14432512239991443251401860.jpg', '.jpg', '14432512239991443251401860.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14432512239991443251401860.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('8', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14432519312651443252012127.jpg', '.jpg', '14432519312651443252012127.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14432519312651443252012127.jpg', '3', 'midpic');
INSERT INTO `image` VALUES ('9', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14432519312651443252012281.jpg', '.jpg', '14432519312651443252012281.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14432519312651443252012281.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('10', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14432519312651443252012283.jpg', '.jpg', '14432519312651443252012283.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14432519312651443252012283.jpg', '2', 'midpic');
INSERT INTO `image` VALUES ('11', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443253008881.jpg', '.jpg', '11443253008881.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443253008881.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('12', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443253009245.jpg', '.jpg', '11443253009245.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443253009245.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('13', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443253009263.jpg', '.jpg', '11443253009263.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443253009263.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('14', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14432531169701443253156317.jpg', '.jpg', '14432531169701443253156317.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14432531169701443253156317.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('15', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14432531169701443253156341.jpg', '.jpg', '14432531169701443253156341.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14432531169701443253156341.jpg', '3', 'midpic');
INSERT INTO `image` VALUES ('16', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14432531169701443253156347.jpg', '.jpg', '14432531169701443253156347.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14432531169701443253156347.jpg', '2', 'midpic');
INSERT INTO `image` VALUES ('17', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14434896135431443489708651.jpg', '.jpg', '14434896135431443489708651.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14434896135431443489708651.jpg', '2', 'midpic');
INSERT INTO `image` VALUES ('18', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14434896135431443489708811.jpg', '.jpg', '14434896135431443489708811.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14434896135431443489708811.jpg', '3', 'midpic');
INSERT INTO `image` VALUES ('19', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14434896135431443489708821.jpg', '.jpg', '14434896135431443489708821.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14434896135431443489708821.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('20', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443613714209.jpg', '.jpg', '11443613714209.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443613714209.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('21', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443613714545.jpg', '.jpg', '11443613714545.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443613714545.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('22', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443613714549.jpg', '.jpg', '11443613714549.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443613714549.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('23', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443613913074.jpg', '.jpg', '11443613913074.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443613913074.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('24', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443613913081.jpg', '.jpg', '11443613913081.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443613913081.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('25', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443613913087.jpg', '.jpg', '11443613913087.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443613913087.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('26', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443613947162.jpg', '.jpg', '11443613947162.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443613947162.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('27', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443613947170.jpg', '.jpg', '11443613947170.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443613947170.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('28', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11443613947181.jpg', '.jpg', '11443613947181.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11443613947181.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('29', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14436139614371443614068546.jpg', '.jpg', '14436139614371443614068546.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14436139614371443614068546.jpg', '3', 'midpic');
INSERT INTO `image` VALUES ('30', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14436139614371443614068537.jpg', '.jpg', '14436139614371443614068537.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14436139614371443614068537.jpg', '2', 'midpic');
INSERT INTO `image` VALUES ('31', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14436139614371443614068550.jpg', '.jpg', '14436139614371443614068550.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14436139614371443614068550.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('32', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14436140805221443614103230.jpg', '.jpg', '14436140805221443614103230.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14436140805221443614103230.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('33', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14436140805221443614103224.jpg', '.jpg', '14436140805221443614103224.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14436140805221443614103224.jpg', '2', 'midpic');
INSERT INTO `image` VALUES ('34', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14436140805221443614103235.jpg', '.jpg', '14436140805221443614103235.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14436140805221443614103235.jpg', '3', 'midpic');
INSERT INTO `image` VALUES ('35', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14436141792581443614193156.jpg', '.jpg', '14436141792581443614193156.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14436141792581443614193156.jpg', '2', 'midpic');
INSERT INTO `image` VALUES ('36', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14436141792581443614193164.jpg', '.jpg', '14436141792581443614193164.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14436141792581443614193164.jpg', '3', 'midpic');
INSERT INTO `image` VALUES ('37', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\14436141792581443614239178.jpg', '.jpg', '14436141792581443614239178.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/14436141792581443614239178.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('38', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1443882744164羽毛球.png1443882744161', '.png1443882744161', 'logo1443882744164羽毛球.png1443882744161', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1443882744164羽毛球.png1443882744161', '0', 'file');
INSERT INTO `image` VALUES ('39', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1443882775862足球.png1443882775860', '.png1443882775860', 'logo1443882775862足球.png1443882775860', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1443882775862足球.png1443882775860', '0', 'file');
INSERT INTO `image` VALUES ('40', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1443882791429桌球.png1443882791427', '.png1443882791427', 'logo1443882791429桌球.png1443882791427', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1443882791429桌球.png1443882791427', '0', 'file');
INSERT INTO `image` VALUES ('41', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1443882808624保龄球.png1443882808621', '.png1443882808621', 'logo1443882808624保龄球.png1443882808621', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1443882808624保龄球.png1443882808621', '0', 'file');
INSERT INTO `image` VALUES ('42', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1443882825038网球.png1443882825036', '.png1443882825036', 'logo1443882825038网球.png1443882825036', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1443882825038网球.png1443882825036', '0', 'file');
INSERT INTO `image` VALUES ('43', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1443882857053游泳.png1443882857051', '.png1443882857051', 'logo1443882857053游泳.png1443882857051', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1443882857053游泳.png1443882857051', '0', 'file');
INSERT INTO `image` VALUES ('44', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1443882969197健身.png1443882969195', '.png1443882969195', 'logo1443882969197健身.png1443882969195', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1443882969197健身.png1443882969195', '0', 'file');
INSERT INTO `image` VALUES ('45', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1443883196652田径.png1443883196650', '.png1443883196650', 'logo1443883196652田径.png1443883196650', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1443883196652田径.png1443883196650', '0', 'file');
INSERT INTO `image` VALUES ('46', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\11443969204392.png', '.png', '11443969204392.png', '/upload/img/products/', '/upload/img/products/midpic/1/11443969204392.png', '1', 'midpic');
INSERT INTO `image` VALUES ('47', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg1444034799282qrcode_for_gh_5bf89de74d78_430.jpg', '.jpg', 'headImg1444034799282qrcode_for_gh_5bf89de74d78_430.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg1444034799282qrcode_for_gh_5bf89de74d78_430.jpg', '0', 'file');
INSERT INTO `image` VALUES ('48', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg1444042725858qrcode_for_gh_5bf89de74d78_430.jpg', '.jpg', 'headImg1444042725858qrcode_for_gh_5bf89de74d78_430.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg1444042725858qrcode_for_gh_5bf89de74d78_430.jpg', '0', 'file');
INSERT INTO `image` VALUES ('49', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg1444044054068qrcode_for_gh_5bf89de74d78_430.jpg', '.jpg', 'headImg1444044054068qrcode_for_gh_5bf89de74d78_430.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg1444044054068qrcode_for_gh_5bf89de74d78_430.jpg', '0', 'file');
INSERT INTO `image` VALUES ('50', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg1444044082050qrcode_for_gh_5bf89de74d78_430.jpg', '.jpg', 'headImg1444044082050qrcode_for_gh_5bf89de74d78_430.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg1444044082050qrcode_for_gh_5bf89de74d78_430.jpg', '0', 'file');
INSERT INTO `image` VALUES ('51', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg1444044102281qrcode_for_gh_5bf89de74d78_430.jpg', '.jpg', 'headImg1444044102281qrcode_for_gh_5bf89de74d78_430.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg1444044102281qrcode_for_gh_5bf89de74d78_430.jpg', '0', 'file');
INSERT INTO `image` VALUES ('52', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg1444044402367qrcode_for_gh_5bf89de74d78_430.jpg', '.jpg', 'headImg1444044402367qrcode_for_gh_5bf89de74d78_430.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg1444044402367qrcode_for_gh_5bf89de74d78_430.jpg', '0', 'file');
INSERT INTO `image` VALUES ('53', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg1444044698412二维码1437716428980.png', '.png', 'headImg1444044698412二维码1437716428980.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg1444044698412二维码1437716428980.png', '0', 'file');
INSERT INTO `image` VALUES ('54', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg1444044704257qrcode_for_gh_5bf89de74d78_430.jpg', '.jpg', 'headImg1444044704257qrcode_for_gh_5bf89de74d78_430.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg1444044704257qrcode_for_gh_5bf89de74d78_430.jpg', '0', 'file');
INSERT INTO `image` VALUES ('55', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\11444146213242.jpg', '.jpg', '11444146213242.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/11444146213242.jpg', '2', 'midpic');
INSERT INTO `image` VALUES ('56', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\11444146213476.jpg', '.jpg', '11444146213476.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/11444146213476.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('57', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\11444146213492.jpg', '.jpg', '11444146213492.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/11444146213492.jpg', '3', 'midpic');
INSERT INTO `image` VALUES ('58', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1444212705599羽毛球.png1444212705566', '.png1444212705566', 'logo1444212705599羽毛球.png1444212705566', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1444212705599羽毛球.png1444212705566', '0', 'file');
INSERT INTO `image` VALUES ('59', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1444226085382羽毛球.png1444226085379', '.png1444226085379', 'logo1444226085382羽毛球.png1444226085379', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1444226085382羽毛球.png1444226085379', '0', 'file');
INSERT INTO `image` VALUES ('60', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14442261568581444226156816羽毛球.png', '.png', 'logo14442261568581444226156816羽毛球.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14442261568581444226156816羽毛球.png', '0', 'file');
INSERT INTO `image` VALUES ('61', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\11444287035426.jpg', '.jpg', '11444287035426.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/11444287035426.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('62', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\11444287067655.jpg', '.jpg', '11444287067655.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/11444287067655.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('63', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\11444287067666.jpg', '.jpg', '11444287067666.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/11444287067666.jpg', '2', 'midpic');
INSERT INTO `image` VALUES ('64', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\11444293307850.jpg', '.jpg', '11444293307850.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/11444293307850.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('65', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\midpic\\1\\11444293458589.jpg', '.jpg', '11444293458589.jpg', '/upload/img/products/', '/upload/img/products/midpic/1/11444293458589.jpg', '1', 'midpic');
INSERT INTO `image` VALUES ('66', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560389.jpg', '.jpg', '11444296560389.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560389.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('67', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560399.jpg', '.jpg', '11444296560399.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560399.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('68', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560409.jpg', '.jpg', '11444296560409.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560409.jpg', '5', 'bigpic');
INSERT INTO `image` VALUES ('69', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560412.jpg', '.jpg', '11444296560412.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560412.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('70', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560411.jpg', '.jpg', '11444296560411.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560411.jpg', '6', 'bigpic');
INSERT INTO `image` VALUES ('71', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560420.jpg', '.jpg', '11444296560420.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560420.jpg', '4', 'bigpic');
INSERT INTO `image` VALUES ('72', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560529.jpg', '.jpg', '11444296560529.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560529.jpg', '7', 'bigpic');
INSERT INTO `image` VALUES ('73', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560673.jpg', '.jpg', '11444296560673.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560673.jpg', '8', 'bigpic');
INSERT INTO `image` VALUES ('74', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560788.gif', '.gif', '11444296560788.gif', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560788.gif', '9', 'bigpic');
INSERT INTO `image` VALUES ('75', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560846.jpg', '.jpg', '11444296560846.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560846.jpg', '11', 'bigpic');
INSERT INTO `image` VALUES ('76', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560862.jpg', '.jpg', '11444296560862.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560862.jpg', '13', 'bigpic');
INSERT INTO `image` VALUES ('77', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560865.jpg', '.jpg', '11444296560865.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560865.jpg', '12', 'bigpic');
INSERT INTO `image` VALUES ('78', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560848.jpg', '.jpg', '11444296560848.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560848.jpg', '10', 'bigpic');
INSERT INTO `image` VALUES ('79', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296560926.jpg', '.jpg', '11444296560926.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296560926.jpg', '14', 'bigpic');
INSERT INTO `image` VALUES ('80', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296561066.jpg', '.jpg', '11444296561066.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296561066.jpg', '15', 'bigpic');
INSERT INTO `image` VALUES ('81', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296561180.jpg', '.jpg', '11444296561180.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296561180.jpg', '17', 'bigpic');
INSERT INTO `image` VALUES ('82', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296561189.jpg', '.jpg', '11444296561189.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296561189.jpg', '16', 'bigpic');
INSERT INTO `image` VALUES ('83', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296561218.jpg', '.jpg', '11444296561218.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296561218.jpg', '18', 'bigpic');
INSERT INTO `image` VALUES ('84', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296561229.jpg', '.jpg', '11444296561229.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296561229.jpg', '19', 'bigpic');
INSERT INTO `image` VALUES ('85', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296561272.jpg', '.jpg', '11444296561272.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296561272.jpg', '20', 'bigpic');
INSERT INTO `image` VALUES ('86', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296561273.jpg', '.jpg', '11444296561273.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296561273.jpg', '21', 'bigpic');
INSERT INTO `image` VALUES ('87', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444296561344.jpg', '.jpg', '11444296561344.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444296561344.jpg', '22', 'bigpic');
INSERT INTO `image` VALUES ('88', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444398194317.jpg', '.jpg', '11444398194317.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444398194317.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('89', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444398194807.jpg', '.jpg', '11444398194807.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444398194807.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('90', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444398204828.jpg', '.jpg', '11444398204828.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444398204828.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('91', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444400653445.jpg', '.jpg', '11444400653445.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444400653445.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('92', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444400654103.jpg', '.jpg', '11444400654103.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444400654103.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('93', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444400654116.jpg', '.jpg', '11444400654116.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444400654116.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('94', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444401223775.jpg', '.jpg', '11444401223775.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444401223775.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('95', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444401224162.jpg', '.jpg', '11444401224162.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444401224162.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('96', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444401224171.jpg', '.jpg', '11444401224171.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444401224171.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('100', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1444479182167qrcode_for_gh_5bf89de74d78_430.jpg1444479182134', '.jpg1444479182134', 'logo1444479182167qrcode_for_gh_5bf89de74d78_430.jpg1444479182134', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1444479182167qrcode_for_gh_5bf89de74d78_430.jpg1444479182134', '0', 'file');
INSERT INTO `image` VALUES ('101', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14444842819601444484281924羽毛球.png', '.png', 'logo14444842819601444484281924羽毛球.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14444842819601444484281924羽毛球.png', '0', 'file');
INSERT INTO `image` VALUES ('102', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14444843123101444484312308足球.png', '.png', 'logo14444843123101444484312308足球.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14444843123101444484312308足球.png', '0', 'file');
INSERT INTO `image` VALUES ('103', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14444843243961444484324394桌球.png', '.png', 'logo14444843243961444484324394桌球.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14444843243961444484324394桌球.png', '0', 'file');
INSERT INTO `image` VALUES ('104', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14444843372981444484337295保龄球.png', '.png', 'logo14444843372981444484337295保龄球.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14444843372981444484337295保龄球.png', '0', 'file');
INSERT INTO `image` VALUES ('105', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14444843504421444484350440网球.png', '.png', 'logo14444843504421444484350440网球.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14444843504421444484350440网球.png', '0', 'file');
INSERT INTO `image` VALUES ('106', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14444843604081444484360391游泳.png', '.png', 'logo14444843604081444484360391游泳.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14444843604081444484360391游泳.png', '0', 'file');
INSERT INTO `image` VALUES ('107', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14444843736381444484373636健身.png', '.png', 'logo14444843736381444484373636健身.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14444843736381444484373636健身.png', '0', 'file');
INSERT INTO `image` VALUES ('108', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14444843848901444484384888田径.png', '.png', 'logo14444843848901444484384888田径.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14444843848901444484384888田径.png', '0', 'file');
INSERT INTO `image` VALUES ('110', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444578858641.jpg', '.jpg', '11444578858641.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444578858641.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('111', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444578859662.jpg', '.jpg', '11444578859662.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444578859662.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('112', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444578859663.jpg', '.jpg', '11444578859663.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444578859663.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('113', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444579053690.jpg', '.jpg', '11444579053690.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444579053690.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('114', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444579053689.jpg', '.jpg', '11444579053689.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444579053689.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('115', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444579053701.jpg', '.jpg', '11444579053701.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444579053701.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('116', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444579068453.jpg', '.jpg', '11444579068453.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444579068453.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('117', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444579068468.jpg', '.jpg', '11444579068468.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444579068468.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('118', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444579085257.jpg', '.jpg', '11444579085257.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444579085257.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('119', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444579085275.jpg', '.jpg', '11444579085275.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444579085275.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('120', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444579085268.jpg', '.jpg', '11444579085268.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444579085268.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('121', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444579101843.jpg', '.jpg', '11444579101843.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444579101843.jpg', '2', 'bigpic');
INSERT INTO `image` VALUES ('122', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444579101862.jpg', '.jpg', '11444579101862.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444579101862.jpg', '1', 'bigpic');
INSERT INTO `image` VALUES ('123', '1', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\products\\bigpic\\1\\11444579101879.jpg', '.jpg', '11444579101879.jpg', '/upload/img/products/', '/upload/img/products/bigpic/1/11444579101879.jpg', '3', 'bigpic');
INSERT INTO `image` VALUES ('139', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\qrcode_for_gh_5bf89de74d78_430.jpg1445867156627', '.jpg1445867156627', 'qrcode_for_gh_5bf89de74d78_430.jpg1445867156627', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/qrcode_for_gh_5bf89de74d78_430.jpg1445867156627', '0', 'file');
INSERT INTO `image` VALUES ('140', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1445867290847', '.jpg1445867290847', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1445867290847', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1445867290847', '0', 'file');
INSERT INTO `image` VALUES ('141', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1445867762118', '.gif1445867762118', 'index.gif1445867762118', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1445867762118', '0', 'file');
INSERT INTO `image` VALUES ('142', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1445867917735', '.jpg1445867917735', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1445867917735', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1445867917735', '0', 'file');
INSERT INTO `image` VALUES ('143', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1445868725481', '.jpg1445868725481', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1445868725481', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1445868725481', '0', 'file');
INSERT INTO `image` VALUES ('144', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1445869057026', '.gif1445869057026', 'index.gif1445869057026', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1445869057026', '0', 'file');
INSERT INTO `image` VALUES ('145', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1445869076770', '.jpg1445869076770', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1445869076770', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1445869076770', '0', 'file');
INSERT INTO `image` VALUES ('146', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1445869169785', '.jpg1445869169785', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1445869169785', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1445869169785', '0', 'file');
INSERT INTO `image` VALUES ('147', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1445869186098', '.gif1445869186098', 'index.gif1445869186098', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1445869186098', '0', 'file');
INSERT INTO `image` VALUES ('148', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1445869204730', '.gif1445869204730', 'index.gif1445869204730', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1445869204730', '0', 'file');
INSERT INTO `image` VALUES ('149', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1445870032548', '.gif1445870032548', 'index.gif1445870032548', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1445870032548', '0', 'file');
INSERT INTO `image` VALUES ('150', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\二维码1437716428980.png1445904751874', '.png1445904751874', '二维码1437716428980.png1445904751874', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/二维码1437716428980.png1445904751874', '0', 'file');
INSERT INTO `image` VALUES ('151', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1445906463928', '.gif1445906463928', 'index.gif1445906463928', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1445906463928', '0', 'file');
INSERT INTO `image` VALUES ('152', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1445908965039', '.jpg1445908965039', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1445908965039', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1445908965039', '0', 'file');
INSERT INTO `image` VALUES ('153', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1446204955303', '.jpg1446204955303', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1446204955303', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1446204955303', '0', 'file');
INSERT INTO `image` VALUES ('154', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1446205348460', '.jpg1446205348460', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1446205348460', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1446205348460', '0', 'file');
INSERT INTO `image` VALUES ('155', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1446206259037', '.gif1446206259037', 'index.gif1446206259037', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1446206259037', '0', 'file');
INSERT INTO `image` VALUES ('156', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1446206311524', '.jpg1446206311524', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1446206311524', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1446206311524', '0', 'file');
INSERT INTO `image` VALUES ('157', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\服务器工作原理(张俊).png1446206333235', '.png1446206333235', '服务器工作原理(张俊).png1446206333235', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/服务器工作原理(张俊).png1446206333235', '0', 'file');
INSERT INTO `image` VALUES ('158', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1446206368479', '.jpg1446206368479', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1446206368479', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1446206368479', '0', 'file');
INSERT INTO `image` VALUES ('159', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1446206384923', '.gif1446206384923', 'index.gif1446206384923', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1446206384923', '0', 'file');
INSERT INTO `image` VALUES ('160', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1446206404650', '.gif1446206404650', 'index.gif1446206404650', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1446206404650', '0', 'file');
INSERT INTO `image` VALUES ('161', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1446217286459', '.gif1446217286459', 'index.gif1446217286459', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1446217286459', '0', 'file');
INSERT INTO `image` VALUES ('163', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1446217908879', '.gif1446217908879', 'index.gif1446217908879', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1446217908879', '0', 'file');
INSERT INTO `image` VALUES ('164', '5', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1446218003104', '.gif1446218003104', 'index.gif1446218003104', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1446218003104', '0', 'file');
INSERT INTO `image` VALUES ('165', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1446293313429', '.jpg1446293313429', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1446293313429', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1446293313429', '0', 'file');
INSERT INTO `image` VALUES ('166', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1446293413834', '.gif1446293413834', 'index.gif1446293413834', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1446293413834', '0', 'file');
INSERT INTO `image` VALUES ('167', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\qrcode_for_gh_5bf89de74d78_430.jpg1446293709853', '.jpg1446293709853', 'qrcode_for_gh_5bf89de74d78_430.jpg1446293709853', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/qrcode_for_gh_5bf89de74d78_430.jpg1446293709853', '0', 'file');
INSERT INTO `image` VALUES ('168', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\aea0e20e718efff56ebf18a4cfd90b2d.jpg1446294447147', '.jpg1446294447147', 'aea0e20e718efff56ebf18a4cfd90b2d.jpg1446294447147', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/aea0e20e718efff56ebf18a4cfd90b2d.jpg1446294447147', '0', 'file');
INSERT INTO `image` VALUES ('169', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1446294664225', '.gif1446294664225', 'index.gif1446294664225', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1446294664225', '0', 'file');
INSERT INTO `image` VALUES ('170', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\服务器工作原理(张俊).png1446294867833', '.png1446294867833', '服务器工作原理(张俊).png1446294867833', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/服务器工作原理(张俊).png1446294867833', '0', 'file');
INSERT INTO `image` VALUES ('171', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\二维码1437716428980.png1446294886363', '.png1446294886363', '二维码1437716428980.png1446294886363', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/二维码1437716428980.png1446294886363', '0', 'file');
INSERT INTO `image` VALUES ('172', '6', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\index.gif1446306211925', '.gif1446306211925', 'index.gif1446306211925', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/index.gif1446306211925', '0', 'file');
INSERT INTO `image` VALUES ('173', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1446306533219index.gif1446306533187', '.gif1446306533187', 'logo1446306533219index.gif1446306533187', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1446306533219index.gif1446306533187', '0', 'file');
INSERT INTO `image` VALUES ('174', '7', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\1446306684691index.gif', '.gif', '1446306684691index.gif', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/1446306684691index.gif', '0', 'file');
INSERT INTO `image` VALUES ('175', '8', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\1446306907392orderDetail.zip', '.zip', '1446306907392orderDetail.zip', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/1446306907392orderDetail.zip', '0', 'file');
INSERT INTO `image` VALUES ('178', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\1446465589883QQ图片20151031153353.jpg', '.jpg', '1446465589883QQ图片20151031153353.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/1446465589883QQ图片20151031153353.jpg', '0', 'file');
INSERT INTO `image` VALUES ('179', '10', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\1446468101943QQ图片20151031153353.jpg', '.jpg', '1446468101943QQ图片20151031153353.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/1446468101943QQ图片20151031153353.jpg', '0', 'file');
INSERT INTO `image` VALUES ('180', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\二维码1437716428980.png1446539415118', '.png1446539415118', '二维码1437716428980.png1446539415118', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/二维码1437716428980.png1446539415118', '0', 'file');
INSERT INTO `image` VALUES ('181', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\qrcode_for_gh_5bf89de74d78_430.jpg1446539455670', '.jpg1446539455670', 'qrcode_for_gh_5bf89de74d78_430.jpg1446539455670', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/qrcode_for_gh_5bf89de74d78_430.jpg1446539455670', '0', 'file');
INSERT INTO `image` VALUES ('182', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1446557456221qrcode_for_gh_5bf89de74d78_430.jpg', '.jpg', 'logo1446557456221qrcode_for_gh_5bf89de74d78_430.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1446557456221qrcode_for_gh_5bf89de74d78_430.jpg', '0', 'file');
INSERT INTO `image` VALUES ('183', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14465575979111446557597829QQ图片20151031153413.jpg', '.jpg', 'logo14465575979111446557597829QQ图片20151031153413.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14465575979111446557597829QQ图片20151031153413.jpg', '0', 'file');
INSERT INTO `image` VALUES ('184', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14465588845211446558884521index.gif', '.gif', 'logo14465588845211446558884521index.gif', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14465588845211446558884521index.gif', '0', 'file');
INSERT INTO `image` VALUES ('185', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14465596881191446559688072qrcode_for_gh_5bf89de74d78_430.jpg', '.jpg', 'logo14465596881191446559688072qrcode_for_gh_5bf89de74d78_430.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14465596881191446559688072qrcode_for_gh_5bf89de74d78_430.jpg', '0', 'file');
INSERT INTO `image` VALUES ('186', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo144655972884014465597288371.png', '.png', 'logo144655972884014465597288371.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo144655972884014465597288371.png', '0', 'file');
INSERT INTO `image` VALUES ('187', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14465597902481446559790243badminton.png', '.png', 'logo14465597902481446559790243badminton.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14465597902481446559790243badminton.png', '0', 'file');
INSERT INTO `image` VALUES ('188', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1446559949302more.png', '.png', 'logo1446559949302more.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1446559949302more.png', '0', 'file');
INSERT INTO `image` VALUES ('189', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14466266394901446626639417soccer.png', '.png', 'logo14466266394901446626639417soccer.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14466266394901446626639417soccer.png', '0', 'file');
INSERT INTO `image` VALUES ('190', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14466266617981446626661795tennis.png', '.png', 'logo14466266617981446626661795tennis.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14466266617981446626661795tennis.png', '0', 'file');
INSERT INTO `image` VALUES ('191', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo144662667299614466266729921.png', '.png', 'logo144662667299614466266729921.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo144662667299614466266729921.png', '0', 'file');
INSERT INTO `image` VALUES ('192', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14466266841441446626684139badminton.png', '.png', 'logo14466266841441446626684139badminton.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14466266841441446626684139badminton.png', '0', 'file');
INSERT INTO `image` VALUES ('193', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446630305708服务器工作原理(张俊).png', '.png', 'article1446630305708服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446630305708服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('194', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446632515446QQ图片20151031153413.jpg', '.jpg', 'article1446632515446QQ图片20151031153413.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446632515446QQ图片20151031153413.jpg', '0', 'file');
INSERT INTO `image` VALUES ('195', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446632525993QQ图片20151031153413.jpg', '.jpg', 'article1446632525993QQ图片20151031153413.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446632525993QQ图片20151031153413.jpg', '0', 'file');
INSERT INTO `image` VALUES ('196', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg1446636165470qrcode_for_gh_5bf89de74d78_430.jpg', '.jpg', 'headImg1446636165470qrcode_for_gh_5bf89de74d78_430.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg1446636165470qrcode_for_gh_5bf89de74d78_430.jpg', '0', 'file');
INSERT INTO `image` VALUES ('197', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg1446638798659qrcode_for_gh_5bf89de74d78_430.jpg', '.jpg', 'headImg1446638798659qrcode_for_gh_5bf89de74d78_430.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg1446638798659qrcode_for_gh_5bf89de74d78_430.jpg', '0', 'file');
INSERT INTO `image` VALUES ('198', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446648296184QQ图片20151031153413.jpg', '.jpg', 'article1446648296184QQ图片20151031153413.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446648296184QQ图片20151031153413.jpg', '0', 'file');
INSERT INTO `image` VALUES ('199', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446688651868服务器工作原理(张俊).png', '.png', 'article1446688651868服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446688651868服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('200', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446689141857服务器工作原理(张俊).png', '.png', 'article1446689141857服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446689141857服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('201', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446689520176服务器工作原理(张俊).png', '.png', 'article1446689520176服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446689520176服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('202', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446689589030服务器工作原理(张俊).png', '.png', 'article1446689589030服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446689589030服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('203', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446689705532aea0e20e718efff56ebf18a4cfd90b2d.jpg', '.jpg', 'article1446689705532aea0e20e718efff56ebf18a4cfd90b2d.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446689705532aea0e20e718efff56ebf18a4cfd90b2d.jpg', '0', 'file');
INSERT INTO `image` VALUES ('204', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446689834512服务器工作原理(张俊).png', '.png', 'article1446689834512服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446689834512服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('205', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446689861724服务器工作原理(张俊).png', '.png', 'article1446689861724服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446689861724服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('206', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg14466938790931.png', '.png', 'headImg14466938790931.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg14466938790931.png', '0', 'file');
INSERT INTO `image` VALUES ('207', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446694296867aea0e20e718efff56ebf18a4cfd90b2d.jpg', '.jpg', 'article1446694296867aea0e20e718efff56ebf18a4cfd90b2d.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446694296867aea0e20e718efff56ebf18a4cfd90b2d.jpg', '0', 'file');
INSERT INTO `image` VALUES ('208', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446695029338aea0e20e718efff56ebf18a4cfd90b2d.jpg', '.jpg', 'article1446695029338aea0e20e718efff56ebf18a4cfd90b2d.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446695029338aea0e20e718efff56ebf18a4cfd90b2d.jpg', '0', 'file');
INSERT INTO `image` VALUES ('209', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446695170545aea0e20e718efff56ebf18a4cfd90b2d.jpg', '.jpg', 'article1446695170545aea0e20e718efff56ebf18a4cfd90b2d.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446695170545aea0e20e718efff56ebf18a4cfd90b2d.jpg', '0', 'file');
INSERT INTO `image` VALUES ('210', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446705755544服务器工作原理(张俊).png', '.png', 'article1446705755544服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446705755544服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('211', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446710089488服务器工作原理(张俊).png', '.png', 'article1446710089488服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446710089488服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('212', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446710112146服务器工作原理(张俊).png', '.png', 'article1446710112146服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446710112146服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('213', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446711246295服务器工作原理(张俊).png', '.png', 'article1446711246295服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446711246295服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('214', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446711288481sport.png', '.png', 'article1446711288481sport.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446711288481sport.png', '0', 'file');
INSERT INTO `image` VALUES ('215', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446717445200sport.png', '.png', 'article1446717445200sport.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446717445200sport.png', '0', 'file');
INSERT INTO `image` VALUES ('216', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446717668816sport.png', '.png', 'article1446717668816sport.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446717668816sport.png', '0', 'file');
INSERT INTO `image` VALUES ('217', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446717847370sport.png', '.png', 'article1446717847370sport.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446717847370sport.png', '0', 'file');
INSERT INTO `image` VALUES ('218', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446775159637服务器工作原理(张俊).png', '.png', 'article1446775159637服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446775159637服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('219', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446866775817我为岳阳代言.jpg', '.jpg', 'article1446866775817我为岳阳代言.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446866775817我为岳阳代言.jpg', '0', 'file');
INSERT INTO `image` VALUES ('220', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446866806086李佳兴.jpg', '.jpg', 'article1446866806086李佳兴.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446866806086李佳兴.jpg', '0', 'file');
INSERT INTO `image` VALUES ('221', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446894114598我为岳阳代言.jpg', '.jpg', 'article1446894114598我为岳阳代言.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446894114598我为岳阳代言.jpg', '0', 'file');
INSERT INTO `image` VALUES ('222', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446897156786李佳兴.jpg', '.jpg', 'article1446897156786李佳兴.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446897156786李佳兴.jpg', '0', 'file');
INSERT INTO `image` VALUES ('223', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446944752442服务器工作原理(张俊).png', '.png', 'article1446944752442服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446944752442服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('224', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum\\companyRegisterFile\\article1446944822301我为岳阳代言.jpg', '.jpg', 'article1446944822301我为岳阳代言.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\forum', '/upload/img/forum/companyRegisterFile/article1446944822301我为岳阳代言.jpg', '0', 'file');
INSERT INTO `image` VALUES ('225', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes\\companyRegisterFile\\headImg1446944855695李佳兴.jpg', '.jpg', 'headImg1446944855695李佳兴.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\img\\photoes', '/upload/img/photoes/companyRegisterFile/headImg1446944855695李佳兴.jpg', '0', 'file');
INSERT INTO `image` VALUES ('226', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1446945499362王子军.jpg', '.jpg', 'logo1446945499362王子军.jpg', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1446945499362王子军.jpg', '0', 'file');
INSERT INTO `image` VALUES ('227', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1446958758224index.gif', '.gif', 'logo1446958758224index.gif', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1446958758224index.gif', '0', 'file');
INSERT INTO `image` VALUES ('228', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1446960771178index.gif', '.gif', 'logo1446960771178index.gif', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1446960771178index.gif', '0', 'file');
INSERT INTO `image` VALUES ('229', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1446960834833index.gif', '.gif', 'logo1446960834833index.gif', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1446960834833index.gif', '0', 'file');
INSERT INTO `image` VALUES ('230', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1446961034880二维码1437716428980.png', '.png', 'logo1446961034880二维码1437716428980.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1446961034880二维码1437716428980.png', '0', 'file');
INSERT INTO `image` VALUES ('231', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1446961293360index.gif', '.gif', 'logo1446961293360index.gif', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1446961293360index.gif', '0', 'file');
INSERT INTO `image` VALUES ('232', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14469628853201446962885319二维码1437716428980.png', '.png', 'logo14469628853201446962885319二维码1437716428980.png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14469628853201446962885319二维码1437716428980.png', '0', 'file');
INSERT INTO `image` VALUES ('233', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14469629231731446962923172index.gif', '.gif', 'logo14469629231731446962923172index.gif', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14469629231731446962923172index.gif', '0', 'file');
INSERT INTO `image` VALUES ('234', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14469640386381446964038636index.gif', '.gif', 'logo14469640386381446964038636index.gif', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14469640386381446964038636index.gif', '0', 'file');
INSERT INTO `image` VALUES ('235', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo14469641703931446964170392服务器工作原理(张俊).png', '.png', 'logo14469641703931446964170392服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo14469641703931446964170392服务器工作原理(张俊).png', '0', 'file');
INSERT INTO `image` VALUES ('236', 'companyRegisterFile', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo\\companyRegisterFile\\logo1446965241391服务器工作原理(张俊).png', '.png', 'logo1446965241391服务器工作原理(张俊).png', 'D:\\MyEclipseWorkspace\\.metadata\\.me_tcat\\webapps\\MoveUp\\upload\\file\\companyInfo', '/upload/file/companyInfo/companyRegisterFile/logo1446965241391服务器工作原理(张俊).png', '0', 'file');

-- ----------------------------
-- Table structure for level
-- ----------------------------
DROP TABLE IF EXISTS `level`;
CREATE TABLE `level` (
  `id` int(11) NOT NULL auto_increment,
  `flag` int(11) NOT NULL,
  `introduction` longtext,
  `levelName` varchar(255) default NULL,
  `type_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK45EAB64D17D5E7A` (`type_id`),
  CONSTRAINT `FK45EAB64D17D5E7A` FOREIGN KEY (`type_id`) REFERENCES `producttype` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of level
-- ----------------------------

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `levelPosition` varchar(255) default NULL,
  `id` int(11) NOT NULL,
  `company_id` int(11) default NULL,
  `hasSuper` bit(1) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK9501A78DEE6E885F` (`id`),
  KEY `FK9501A78DDF1E28B` (`company_id`),
  CONSTRAINT `FK9501A78DDF1E28B` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `FK9501A78DEE6E885F` FOREIGN KEY (`id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (null, '1', '1', '\0');
INSERT INTO `manager` VALUES (null, '38', '5', '\0');
INSERT INTO `manager` VALUES (null, '51', '1', '\0');
INSERT INTO `manager` VALUES (null, '52', '1', '\0');
INSERT INTO `manager` VALUES (null, '53', '1', '\0');
INSERT INTO `manager` VALUES (null, '54', '1', '\0');
INSERT INTO `manager` VALUES (null, '55', '6', '');
INSERT INTO `manager` VALUES (null, '56', '7', '');
INSERT INTO `manager` VALUES (null, '57', '8', '');
INSERT INTO `manager` VALUES (null, '75', '10', '');

-- ----------------------------
-- Table structure for manager_right
-- ----------------------------
DROP TABLE IF EXISTS `manager_right`;
CREATE TABLE `manager_right` (
  `id` int(11) NOT NULL auto_increment,
  `detail` varchar(255) default NULL,
  `rightName` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `rightName` (`rightName`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of manager_right
-- ----------------------------
INSERT INTO `manager_right` VALUES ('1', '管理：管理员信息', 'manager:*');
INSERT INTO `manager_right` VALUES ('2', '管理：公司信息', 'company:*');
INSERT INTO `manager_right` VALUES ('3', '管理：场馆信息', 'site:*');
INSERT INTO `manager_right` VALUES ('4', '管理：会员信息', 'user:*');
INSERT INTO `manager_right` VALUES ('5', '管理：分类信息', 'productType:*');
INSERT INTO `manager_right` VALUES ('6', '管理：地区信息', 'address:*');
INSERT INTO `manager_right` VALUES ('7', '管理：等级信息', 'level:*');
INSERT INTO `manager_right` VALUES ('8', '管理：教练信息', 'coach:*');
INSERT INTO `manager_right` VALUES ('9', '管理：优惠活动', 'discount:*');
INSERT INTO `manager_right` VALUES ('10', '管理：退款信息', 'refound:*');
INSERT INTO `manager_right` VALUES ('11', '管理：账单信息', 'acount:*');
INSERT INTO `manager_right` VALUES ('12', '管理：社交圈', 'forum:*');
INSERT INTO `manager_right` VALUES ('13', '管理：赛事管理', 'match:*');
INSERT INTO `manager_right` VALUES ('14', '管理：订单', 'order:*');
INSERT INTO `manager_right` VALUES ('16', '查看：账单信息', 'acount:view');
INSERT INTO `manager_right` VALUES ('19', '管理：排名信息', 'top:*');

-- ----------------------------
-- Table structure for orderitem
-- ----------------------------
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem` (
  `id` int(11) NOT NULL auto_increment,
  `discount` float NOT NULL,
  `price` float NOT NULL,
  `time` int(11) NOT NULL,
  `coach_id` int(11) default NULL,
  `coachPreOrder_id` int(11) default NULL,
  `comment_id` int(11) default NULL,
  `order_id` int(11) default NULL,
  `place_id` int(11) default NULL,
  `placePreOrder_id` int(11) default NULL,
  `product_product_id` int(11) default NULL,
  `useDate` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK60163F61E125E9AB` (`placePreOrder_id`),
  KEY `FK60163F61E1DBE68B` (`place_id`),
  KEY `FK60163F61489FBCCB` (`coachPreOrder_id`),
  KEY `FK60163F6165AE229B` (`product_product_id`),
  KEY `FK60163F61BC956D2B` (`order_id`),
  KEY `FK60163F61760EFF4B` (`comment_id`),
  KEY `FK60163F61396AD9AB` (`coach_id`),
  CONSTRAINT `FK60163F61396AD9AB` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK60163F61489FBCCB` FOREIGN KEY (`coachPreOrder_id`) REFERENCES `coachpreorder` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK60163F6165AE229B` FOREIGN KEY (`product_product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `FK60163F61760EFF4B` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK60163F61BC956D2B` FOREIGN KEY (`order_id`) REFERENCES `user_order` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK60163F61E125E9AB` FOREIGN KEY (`placePreOrder_id`) REFERENCES `placepreorder` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK60163F61E1DBE68B` FOREIGN KEY (`place_id`) REFERENCES `place` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of orderitem
-- ----------------------------
INSERT INTO `orderitem` VALUES ('397', '2', '25', '12', null, null, null, '150', '52', '2924', '11', '2015-11-03 00:00:00');
INSERT INTO `orderitem` VALUES ('402', '3', '25', '17', null, null, null, '155', '45', '2884', '2', '2015-11-05 00:00:00');
INSERT INTO `orderitem` VALUES ('403', '3', '25', '14', null, null, null, '156', '45', '2884', '2', '2015-11-05 00:00:00');
INSERT INTO `orderitem` VALUES ('404', '3', '25', '15', null, null, null, '156', '45', '2884', '2', '2015-11-05 00:00:00');
INSERT INTO `orderitem` VALUES ('407', '3', '25', '19', null, null, null, '159', '45', '2886', '2', '2015-11-07 00:00:00');

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `person_id` int(11) NOT NULL auto_increment,
  `birthday` datetime default NULL,
  `detail` longtext,
  `email` varchar(255) default NULL,
  `nationality` varchar(255) default NULL,
  `password` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `postcode` varchar(255) default NULL,
  `realName` varchar(255) default NULL,
  `sex` varchar(255) default NULL,
  `telephone` varchar(255) default NULL,
  `userName` varchar(255) default NULL,
  `weixin` varchar(255) default NULL,
  `image_id` int(11) default NULL,
  `addressName` varchar(255) default NULL,
  `homeAddress_id` int(11) default NULL,
  PRIMARY KEY  (`person_id`),
  UNIQUE KEY `userName` (`userName`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `weixin` (`weixin`),
  KEY `FK8E4887753F70160B` (`image_id`),
  KEY `FK8E488775451F454A` (`homeAddress_id`),
  CONSTRAINT `FK8E4887753F70160B` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`),
  CONSTRAINT `FK8E488775451F454A` FOREIGN KEY (`homeAddress_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES ('1', null, null, null, null, '123', null, null, '李佳兴', '男', null, 'danyuan', null, '206', null, null);
INSERT INTO `person` VALUES ('2', '1992-11-16 00:00:00', '大家好', '2849321181@qq.com', null, '1234', '15256767786', null, '张俊', '男', null, 'danyuandefine', null, '225', null, null);
INSERT INTO `person` VALUES ('38', null, null, null, null, 'elm', null, null, 'elm', null, null, 'elm', null, null, null, null);
INSERT INTO `person` VALUES ('40', null, '', '', null, '123456', '15200292390', null, '张威', '女', null, 'u1446297528138', null, null, null, null);
INSERT INTO `person` VALUES ('51', '2015-10-20 00:00:00', '', '', '中国', 'aaaaaa', '15233332222', '', 'dsfdsf', '男', '', 'sfdasf', null, null, null, null);
INSERT INTO `person` VALUES ('52', '2015-10-06 00:00:00', '', '', '中国', 'aaaaaa', '11233333333', '', 'dsfds', '男', '', 'dsfghh', null, null, null, null);
INSERT INTO `person` VALUES ('53', '2015-10-28 00:00:00', '', '', '中国', 'aaaaaa', '11111122233', '', 'gdfsfds', '男', '', 'aaasss', null, null, null, null);
INSERT INTO `person` VALUES ('54', '2015-10-21 00:00:00', '', '', '中国', '111111', '12322223333', '', 'dsgdsff', '男', '', 'sfasd', null, null, null, null);
INSERT INTO `person` VALUES ('55', null, null, null, null, 'bbbbbb', null, null, 'sdfasfs', null, null, 'bbb', null, null, null, null);
INSERT INTO `person` VALUES ('56', null, null, null, null, '123456', null, null, 'sdfasfssdfsd', null, null, 'ccc', null, null, null, null);
INSERT INTO `person` VALUES ('57', null, null, null, null, 'aaaaaa', null, null, 'sdfasfssdfsddsd', null, null, 'ddd', null, null, null, null);
INSERT INTO `person` VALUES ('75', null, null, null, null, '123', null, null, 'sdfdsf', null, null, '345554645dfgdf', null, null, null, null);
INSERT INTO `person` VALUES ('83', '2015-11-17 00:00:00', '', '', null, 'aaaaaa', '12332112311', '', 'aaa', '男', '', 'aaa', null, null, 'sfdsfdsf', '5');
INSERT INTO `person` VALUES ('84', '2015-11-25 00:00:00', '', '', null, 'aaaaaa', '12322111211', '', '东方闪电', '男', '', '啊啊啊', null, null, '', '6');
INSERT INTO `person` VALUES ('85', '2015-11-02 00:00:00', '', '', null, 'aaaaaa', '12344322111', '', '啊啊啊', '男', '', '啊啊啊啊啊啊', null, null, '', '5');

-- ----------------------------
-- Table structure for person_forum
-- ----------------------------
DROP TABLE IF EXISTS `person_forum`;
CREATE TABLE `person_forum` (
  `Person_person_id` int(11) NOT NULL,
  `careForums_id` int(11) NOT NULL,
  KEY `FKF4EB5BB7C299A869` (`careForums_id`),
  KEY `FKF4EB5BB7F5D7451F` (`Person_person_id`),
  KEY `careForums_id` USING BTREE (`careForums_id`),
  CONSTRAINT `FKF4EB5BB7C299A869` FOREIGN KEY (`careForums_id`) REFERENCES `forum` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKF4EB5BB7F5D7451F` FOREIGN KEY (`Person_person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of person_forum
-- ----------------------------
INSERT INTO `person_forum` VALUES ('1', '4');
INSERT INTO `person_forum` VALUES ('1', '4');
INSERT INTO `person_forum` VALUES ('1', '4');
INSERT INTO `person_forum` VALUES ('1', '4');
INSERT INTO `person_forum` VALUES ('1', '4');
INSERT INTO `person_forum` VALUES ('1', '4');
INSERT INTO `person_forum` VALUES ('2', '5');
INSERT INTO `person_forum` VALUES ('2', '2');

-- ----------------------------
-- Table structure for person_image
-- ----------------------------
DROP TABLE IF EXISTS `person_image`;
CREATE TABLE `person_image` (
  `Person_person_id` int(11) NOT NULL,
  `images_id` int(11) NOT NULL,
  UNIQUE KEY `images_id` (`images_id`),
  KEY `FKF51477F13E62CBCE` (`images_id`),
  KEY `FKF51477F1F5D7451F` (`Person_person_id`),
  CONSTRAINT `FKF51477F13E62CBCE` FOREIGN KEY (`images_id`) REFERENCES `image` (`id`),
  CONSTRAINT `FKF51477F1F5D7451F` FOREIGN KEY (`Person_person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of person_image
-- ----------------------------

-- ----------------------------
-- Table structure for person_manager_right
-- ----------------------------
DROP TABLE IF EXISTS `person_manager_right`;
CREATE TABLE `person_manager_right` (
  `Person_person_id` int(11) NOT NULL,
  `rights_id` int(11) NOT NULL,
  KEY `FK6491A7C015B0B4D0` (`rights_id`),
  KEY `FK6491A7C0F5D7451F` (`Person_person_id`),
  KEY `rights_id` USING BTREE (`rights_id`),
  CONSTRAINT `FK6491A7C015B0B4D0` FOREIGN KEY (`rights_id`) REFERENCES `manager_right` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK6491A7C0F5D7451F` FOREIGN KEY (`Person_person_id`) REFERENCES `person` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of person_manager_right
-- ----------------------------
INSERT INTO `person_manager_right` VALUES ('52', '1');
INSERT INTO `person_manager_right` VALUES ('52', '2');
INSERT INTO `person_manager_right` VALUES ('52', '3');
INSERT INTO `person_manager_right` VALUES ('52', '4');
INSERT INTO `person_manager_right` VALUES ('52', '5');
INSERT INTO `person_manager_right` VALUES ('52', '6');
INSERT INTO `person_manager_right` VALUES ('52', '7');
INSERT INTO `person_manager_right` VALUES ('52', '8');
INSERT INTO `person_manager_right` VALUES ('52', '9');
INSERT INTO `person_manager_right` VALUES ('52', '10');
INSERT INTO `person_manager_right` VALUES ('52', '11');
INSERT INTO `person_manager_right` VALUES ('52', '12');
INSERT INTO `person_manager_right` VALUES ('52', '13');
INSERT INTO `person_manager_right` VALUES ('52', '14');
INSERT INTO `person_manager_right` VALUES ('52', '16');
INSERT INTO `person_manager_right` VALUES ('53', '6');
INSERT INTO `person_manager_right` VALUES ('53', '3');
INSERT INTO `person_manager_right` VALUES ('53', '8');
INSERT INTO `person_manager_right` VALUES ('54', '5');
INSERT INTO `person_manager_right` VALUES ('54', '7');
INSERT INTO `person_manager_right` VALUES ('1', '1');
INSERT INTO `person_manager_right` VALUES ('1', '2');
INSERT INTO `person_manager_right` VALUES ('1', '3');
INSERT INTO `person_manager_right` VALUES ('1', '4');
INSERT INTO `person_manager_right` VALUES ('1', '5');
INSERT INTO `person_manager_right` VALUES ('1', '6');
INSERT INTO `person_manager_right` VALUES ('1', '7');
INSERT INTO `person_manager_right` VALUES ('1', '8');
INSERT INTO `person_manager_right` VALUES ('1', '9');
INSERT INTO `person_manager_right` VALUES ('1', '10');
INSERT INTO `person_manager_right` VALUES ('1', '11');
INSERT INTO `person_manager_right` VALUES ('1', '12');
INSERT INTO `person_manager_right` VALUES ('1', '13');
INSERT INTO `person_manager_right` VALUES ('1', '14');
INSERT INTO `person_manager_right` VALUES ('1', '16');
INSERT INTO `person_manager_right` VALUES ('1', '19');

-- ----------------------------
-- Table structure for person_role
-- ----------------------------
DROP TABLE IF EXISTS `person_role`;
CREATE TABLE `person_role` (
  `Person_person_id` int(11) NOT NULL,
  `roles_id` int(11) NOT NULL,
  KEY `FK49FC87202DAF9E02` (`roles_id`),
  KEY `FK49FC8720F5D7451F` (`Person_person_id`),
  KEY `roles_id` USING BTREE (`roles_id`),
  CONSTRAINT `FK49FC87202DAF9E02` FOREIGN KEY (`roles_id`) REFERENCES `role` (`id`),
  CONSTRAINT `FK49FC8720F5D7451F` FOREIGN KEY (`Person_person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of person_role
-- ----------------------------
INSERT INTO `person_role` VALUES ('1', '2');
INSERT INTO `person_role` VALUES ('38', '2');
INSERT INTO `person_role` VALUES ('83', '3');
INSERT INTO `person_role` VALUES ('84', '3');
INSERT INTO `person_role` VALUES ('85', '3');

-- ----------------------------
-- Table structure for place
-- ----------------------------
DROP TABLE IF EXISTS `place`;
CREATE TABLE `place` (
  `id` int(11) NOT NULL auto_increment,
  `discountInfo` varchar(255) default NULL,
  `introduction` longtext,
  `placeName` varchar(255) default NULL,
  `placeNumber` varchar(255) default NULL,
  `timePrice` longtext,
  `product_id` int(11) default NULL,
  `site_id` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK499E8E7BAB16809` (`site_id`),
  KEY `FK499E8E714316102` (`product_id`),
  CONSTRAINT `FK499E8E714316102` FOREIGN KEY (`product_id`) REFERENCES `placeproduct` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK499E8E7BAB16809` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of place
-- ----------------------------
INSERT INTO `place` VALUES ('3', null, null, '游泳池1', null, '-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,22.0,22.0,22.0,22.0,22.0,22.0,22.0,22.0,22.0,22.0,22.0,22.0,-1.0,-1.0,-1.0', null, null);
INSERT INTO `place` VALUES ('7', null, null, '103', null, '-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,122.0,122.0,122.0,122.0,-1.0,-1.0,122.0,122.0,122.0,122.0,122.0,122.0,122.0,122.0,-1.0,-1.0', null, null);
INSERT INTO `place` VALUES ('9', null, null, '111', null, '-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,228.0,228.0,228.0,228.0,-1.0,-1.0,228.0,228.0,228.0,228.0,228.0,228.0,228.0,-1.0,-1.0,-1.0', '5', '1');
INSERT INTO `place` VALUES ('38', null, null, '1', '2', '25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25', '3', '2');
INSERT INTO `place` VALUES ('39', null, null, '2', null, '25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0', '3', '2');
INSERT INTO `place` VALUES ('45', null, null, '1', null, '25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0', '2', '1');
INSERT INTO `place` VALUES ('51', null, null, '1', null, '25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0', '5', '1');
INSERT INTO `place` VALUES ('52', null, null, '1', null, '25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0,25.0', '11', '1');
INSERT INTO `place` VALUES ('57', null, null, '1', '1', '25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25', '14', '13');
INSERT INTO `place` VALUES ('58', null, null, '1', '2', '25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25', '14', '13');

-- ----------------------------
-- Table structure for placepreorder
-- ----------------------------
DROP TABLE IF EXISTS `placepreorder`;
CREATE TABLE `placepreorder` (
  `id` int(11) NOT NULL auto_increment,
  `orderInfo` longtext,
  `date` date default NULL,
  `place_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKDFBE88721A81BDEA` (`place_id`),
  CONSTRAINT `FKDFBE8872E1DBE68B` FOREIGN KEY (`place_id`) REFERENCES `place` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of placepreorder
-- ----------------------------
INSERT INTO `placepreorder` VALUES ('2412', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-21', '3');
INSERT INTO `placepreorder` VALUES ('2413', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-22', '3');
INSERT INTO `placepreorder` VALUES ('2414', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-23', '3');
INSERT INTO `placepreorder` VALUES ('2415', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-24', '3');
INSERT INTO `placepreorder` VALUES ('2416', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-25', '3');
INSERT INTO `placepreorder` VALUES ('2417', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1', '2015-10-26', '3');
INSERT INTO `placepreorder` VALUES ('2418', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-27', '3');
INSERT INTO `placepreorder` VALUES ('2433', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-21', '7');
INSERT INTO `placepreorder` VALUES ('2434', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-22', '7');
INSERT INTO `placepreorder` VALUES ('2435', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-23', '7');
INSERT INTO `placepreorder` VALUES ('2436', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-24', '7');
INSERT INTO `placepreorder` VALUES ('2437', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-25', '7');
INSERT INTO `placepreorder` VALUES ('2438', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1', '2015-10-26', '7');
INSERT INTO `placepreorder` VALUES ('2439', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-27', '7');
INSERT INTO `placepreorder` VALUES ('2440', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-21', '9');
INSERT INTO `placepreorder` VALUES ('2441', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-22', '9');
INSERT INTO `placepreorder` VALUES ('2442', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-23', '9');
INSERT INTO `placepreorder` VALUES ('2443', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-24', '9');
INSERT INTO `placepreorder` VALUES ('2444', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-25', '9');
INSERT INTO `placepreorder` VALUES ('2445', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1', '2015-10-26', '9');
INSERT INTO `placepreorder` VALUES ('2446', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-27', '9');
INSERT INTO `placepreorder` VALUES ('2566', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-21', '38');
INSERT INTO `placepreorder` VALUES ('2567', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-22', '38');
INSERT INTO `placepreorder` VALUES ('2568', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-23', '38');
INSERT INTO `placepreorder` VALUES ('2569', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-24', '38');
INSERT INTO `placepreorder` VALUES ('2570', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-25', '38');
INSERT INTO `placepreorder` VALUES ('2571', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1', '2015-10-26', '38');
INSERT INTO `placepreorder` VALUES ('2572', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-27', '38');
INSERT INTO `placepreorder` VALUES ('2573', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-21', '39');
INSERT INTO `placepreorder` VALUES ('2574', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-22', '39');
INSERT INTO `placepreorder` VALUES ('2575', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-23', '39');
INSERT INTO `placepreorder` VALUES ('2576', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-24', '39');
INSERT INTO `placepreorder` VALUES ('2577', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-25', '39');
INSERT INTO `placepreorder` VALUES ('2578', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1', '2015-10-26', '39');
INSERT INTO `placepreorder` VALUES ('2579', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-27', '39');
INSERT INTO `placepreorder` VALUES ('2580', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-28', '3');
INSERT INTO `placepreorder` VALUES ('2583', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-28', '7');
INSERT INTO `placepreorder` VALUES ('2584', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-28', '9');
INSERT INTO `placepreorder` VALUES ('2602', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-28', '38');
INSERT INTO `placepreorder` VALUES ('2603', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-28', '39');
INSERT INTO `placepreorder` VALUES ('2604', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-29', '3');
INSERT INTO `placepreorder` VALUES ('2607', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-29', '7');
INSERT INTO `placepreorder` VALUES ('2608', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-29', '9');
INSERT INTO `placepreorder` VALUES ('2626', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-29', '38');
INSERT INTO `placepreorder` VALUES ('2627', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-10-29', '39');
INSERT INTO `placepreorder` VALUES ('2628', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1', '2015-10-30', '3');
INSERT INTO `placepreorder` VALUES ('2631', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1', '2015-10-30', '7');
INSERT INTO `placepreorder` VALUES ('2632', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1', '2015-10-30', '9');
INSERT INTO `placepreorder` VALUES ('2650', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1', '2015-10-30', '38');
INSERT INTO `placepreorder` VALUES ('2651', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1', '2015-10-30', '39');
INSERT INTO `placepreorder` VALUES ('2652', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1', '2015-10-31', '3');
INSERT INTO `placepreorder` VALUES ('2655', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1', '2015-10-31', '7');
INSERT INTO `placepreorder` VALUES ('2656', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1', '2015-10-31', '9');
INSERT INTO `placepreorder` VALUES ('2674', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1', '2015-10-31', '38');
INSERT INTO `placepreorder` VALUES ('2675', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1', '2015-10-31', '39');
INSERT INTO `placepreorder` VALUES ('2676', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-01', '3');
INSERT INTO `placepreorder` VALUES ('2679', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-01', '7');
INSERT INTO `placepreorder` VALUES ('2680', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-01', '9');
INSERT INTO `placepreorder` VALUES ('2698', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-01', '38');
INSERT INTO `placepreorder` VALUES ('2699', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-01', '39');
INSERT INTO `placepreorder` VALUES ('2700', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2015-11-02', '3');
INSERT INTO `placepreorder` VALUES ('2703', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2015-11-02', '7');
INSERT INTO `placepreorder` VALUES ('2704', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2015-11-02', '9');
INSERT INTO `placepreorder` VALUES ('2722', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2015-11-02', '38');
INSERT INTO `placepreorder` VALUES ('2723', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2015-11-02', '39');
INSERT INTO `placepreorder` VALUES ('2724', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-03', '3');
INSERT INTO `placepreorder` VALUES ('2727', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-03', '7');
INSERT INTO `placepreorder` VALUES ('2728', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-03', '9');
INSERT INTO `placepreorder` VALUES ('2746', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-03', '38');
INSERT INTO `placepreorder` VALUES ('2747', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-03', '39');
INSERT INTO `placepreorder` VALUES ('2748', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-04', '3');
INSERT INTO `placepreorder` VALUES ('2751', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-04', '7');
INSERT INTO `placepreorder` VALUES ('2752', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-04', '9');
INSERT INTO `placepreorder` VALUES ('2770', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-04', '38');
INSERT INTO `placepreorder` VALUES ('2771', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-04', '39');
INSERT INTO `placepreorder` VALUES ('2772', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-05', '3');
INSERT INTO `placepreorder` VALUES ('2775', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-05', '7');
INSERT INTO `placepreorder` VALUES ('2776', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-05', '9');
INSERT INTO `placepreorder` VALUES ('2794', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-05', '38');
INSERT INTO `placepreorder` VALUES ('2795', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-05', '39');
INSERT INTO `placepreorder` VALUES ('2796', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-06', '3');
INSERT INTO `placepreorder` VALUES ('2799', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-06', '7');
INSERT INTO `placepreorder` VALUES ('2800', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-06', '9');
INSERT INTO `placepreorder` VALUES ('2818', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-06', '38');
INSERT INTO `placepreorder` VALUES ('2819', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-06', '39');
INSERT INTO `placepreorder` VALUES ('2848', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-07', '3');
INSERT INTO `placepreorder` VALUES ('2851', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-07', '7');
INSERT INTO `placepreorder` VALUES ('2852', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-07', '9');
INSERT INTO `placepreorder` VALUES ('2870', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-07', '38');
INSERT INTO `placepreorder` VALUES ('2871', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-07', '39');
INSERT INTO `placepreorder` VALUES ('2880', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-01', '45');
INSERT INTO `placepreorder` VALUES ('2881', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2015-11-02', '45');
INSERT INTO `placepreorder` VALUES ('2882', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-03', '45');
INSERT INTO `placepreorder` VALUES ('2883', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-04', '45');
INSERT INTO `placepreorder` VALUES ('2884', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-05', '45');
INSERT INTO `placepreorder` VALUES ('2885', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-06', '45');
INSERT INTO `placepreorder` VALUES ('2886', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-07', '45');
INSERT INTO `placepreorder` VALUES ('2915', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-01', '51');
INSERT INTO `placepreorder` VALUES ('2916', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2015-11-02', '51');
INSERT INTO `placepreorder` VALUES ('2917', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-03', '51');
INSERT INTO `placepreorder` VALUES ('2918', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-04', '51');
INSERT INTO `placepreorder` VALUES ('2919', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-05', '51');
INSERT INTO `placepreorder` VALUES ('2920', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-06', '51');
INSERT INTO `placepreorder` VALUES ('2921', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-07', '51');
INSERT INTO `placepreorder` VALUES ('2922', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-01', '52');
INSERT INTO `placepreorder` VALUES ('2923', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0', '2015-11-02', '52');
INSERT INTO `placepreorder` VALUES ('2924', '1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-03', '52');
INSERT INTO `placepreorder` VALUES ('2925', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-04', '52');
INSERT INTO `placepreorder` VALUES ('2926', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-05', '52');
INSERT INTO `placepreorder` VALUES ('2927', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-06', '52');
INSERT INTO `placepreorder` VALUES ('2928', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-07', '52');
INSERT INTO `placepreorder` VALUES ('2929', '0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-08', '3');
INSERT INTO `placepreorder` VALUES ('2930', '0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-08', '7');
INSERT INTO `placepreorder` VALUES ('2931', '0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-08', '9');
INSERT INTO `placepreorder` VALUES ('2932', '0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-08', '38');
INSERT INTO `placepreorder` VALUES ('2933', '0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-08', '39');
INSERT INTO `placepreorder` VALUES ('2934', '0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-08', '45');
INSERT INTO `placepreorder` VALUES ('2939', '0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-08', '51');
INSERT INTO `placepreorder` VALUES ('2940', '0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-08', '52');
INSERT INTO `placepreorder` VALUES ('2941', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-09', '3');
INSERT INTO `placepreorder` VALUES ('2942', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-09', '7');
INSERT INTO `placepreorder` VALUES ('2943', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-09', '9');
INSERT INTO `placepreorder` VALUES ('2944', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-09', '38');
INSERT INTO `placepreorder` VALUES ('2945', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-09', '39');
INSERT INTO `placepreorder` VALUES ('2946', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-09', '45');
INSERT INTO `placepreorder` VALUES ('2951', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-09', '51');
INSERT INTO `placepreorder` VALUES ('2952', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-09', '52');
INSERT INTO `placepreorder` VALUES ('2953', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-10', '3');
INSERT INTO `placepreorder` VALUES ('2954', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-10', '7');
INSERT INTO `placepreorder` VALUES ('2955', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-10', '9');
INSERT INTO `placepreorder` VALUES ('2956', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-10', '38');
INSERT INTO `placepreorder` VALUES ('2957', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-10', '39');
INSERT INTO `placepreorder` VALUES ('2958', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-10', '45');
INSERT INTO `placepreorder` VALUES ('2959', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-10', '51');
INSERT INTO `placepreorder` VALUES ('2960', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-10', '52');
INSERT INTO `placepreorder` VALUES ('2961', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-11', '3');
INSERT INTO `placepreorder` VALUES ('2962', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-11', '7');
INSERT INTO `placepreorder` VALUES ('2963', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-11', '9');
INSERT INTO `placepreorder` VALUES ('2964', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-11', '38');
INSERT INTO `placepreorder` VALUES ('2965', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-11', '39');
INSERT INTO `placepreorder` VALUES ('2966', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-11', '45');
INSERT INTO `placepreorder` VALUES ('2967', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-11', '51');
INSERT INTO `placepreorder` VALUES ('2968', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-11', '52');
INSERT INTO `placepreorder` VALUES ('2969', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-12', '3');
INSERT INTO `placepreorder` VALUES ('2970', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-12', '7');
INSERT INTO `placepreorder` VALUES ('2971', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-12', '9');
INSERT INTO `placepreorder` VALUES ('2972', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-12', '38');
INSERT INTO `placepreorder` VALUES ('2973', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-12', '39');
INSERT INTO `placepreorder` VALUES ('2974', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-12', '45');
INSERT INTO `placepreorder` VALUES ('2975', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-12', '51');
INSERT INTO `placepreorder` VALUES ('2976', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-12', '52');
INSERT INTO `placepreorder` VALUES ('2977', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-13', '3');
INSERT INTO `placepreorder` VALUES ('2978', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-13', '7');
INSERT INTO `placepreorder` VALUES ('2979', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-13', '9');
INSERT INTO `placepreorder` VALUES ('2980', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-13', '38');
INSERT INTO `placepreorder` VALUES ('2981', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-13', '39');
INSERT INTO `placepreorder` VALUES ('2982', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-13', '45');
INSERT INTO `placepreorder` VALUES ('2983', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-13', '51');
INSERT INTO `placepreorder` VALUES ('2984', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-13', '52');
INSERT INTO `placepreorder` VALUES ('2985', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-14', '3');
INSERT INTO `placepreorder` VALUES ('2986', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-14', '7');
INSERT INTO `placepreorder` VALUES ('2987', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-14', '9');
INSERT INTO `placepreorder` VALUES ('2988', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-14', '38');
INSERT INTO `placepreorder` VALUES ('2989', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-14', '39');
INSERT INTO `placepreorder` VALUES ('2990', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-14', '45');
INSERT INTO `placepreorder` VALUES ('2991', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-14', '51');
INSERT INTO `placepreorder` VALUES ('2992', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-14', '52');
INSERT INTO `placepreorder` VALUES ('3021', '0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-08', '57');
INSERT INTO `placepreorder` VALUES ('3022', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-09', '57');
INSERT INTO `placepreorder` VALUES ('3023', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-10', '57');
INSERT INTO `placepreorder` VALUES ('3024', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-11', '57');
INSERT INTO `placepreorder` VALUES ('3025', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-12', '57');
INSERT INTO `placepreorder` VALUES ('3026', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-13', '57');
INSERT INTO `placepreorder` VALUES ('3027', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-14', '57');
INSERT INTO `placepreorder` VALUES ('3028', '0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-08', '58');
INSERT INTO `placepreorder` VALUES ('3029', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-09', '58');
INSERT INTO `placepreorder` VALUES ('3030', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-10', '58');
INSERT INTO `placepreorder` VALUES ('3031', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-11', '58');
INSERT INTO `placepreorder` VALUES ('3032', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-12', '58');
INSERT INTO `placepreorder` VALUES ('3033', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-13', '58');
INSERT INTO `placepreorder` VALUES ('3034', '1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1', '2015-11-14', '58');

-- ----------------------------
-- Table structure for placeproduct
-- ----------------------------
DROP TABLE IF EXISTS `placeproduct`;
CREATE TABLE `placeproduct` (
  `id` int(11) NOT NULL,
  `site_id` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK6AE6FA08F55EF7FB` (`id`),
  KEY `FK6AE6FA08BAB16809` (`site_id`),
  CONSTRAINT `FK6AE6FA08BAB16809` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK6AE6FA08F55EF7FB` FOREIGN KEY (`id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of placeproduct
-- ----------------------------
INSERT INTO `placeproduct` VALUES ('2', '1');
INSERT INTO `placeproduct` VALUES ('5', '1');
INSERT INTO `placeproduct` VALUES ('11', '1');
INSERT INTO `placeproduct` VALUES ('3', '2');
INSERT INTO `placeproduct` VALUES ('14', '13');

-- ----------------------------
-- Table structure for placeproduct_placepreorder
-- ----------------------------
DROP TABLE IF EXISTS `placeproduct_placepreorder`;
CREATE TABLE `placeproduct_placepreorder` (
  `PlaceProduct_id` int(11) NOT NULL,
  `preOrders_id` int(11) NOT NULL,
  UNIQUE KEY `preOrders_id` (`preOrders_id`),
  KEY `FK2611267BADE4FB35` (`preOrders_id`),
  KEY `FK2611267BC553DD49` (`PlaceProduct_id`),
  CONSTRAINT `FK2611267BADE4FB35` FOREIGN KEY (`preOrders_id`) REFERENCES `placepreorder` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK2611267BC553DD49` FOREIGN KEY (`PlaceProduct_id`) REFERENCES `placeproduct` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of placeproduct_placepreorder
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `product_id` int(11) NOT NULL auto_increment,
  `bargainPrice` float NOT NULL,
  `detail` longtext,
  `hasBargin` bit(1) NOT NULL,
  `hasBegin` bit(1) NOT NULL,
  `hasTop` bit(1) NOT NULL,
  `introduction` varchar(255) default NULL,
  `normalPrice` float NOT NULL,
  `productName` varchar(255) default NULL,
  `score` int(11) NOT NULL,
  `totalSoldNumber` int(11) NOT NULL,
  `company_id` int(11) default NULL,
  `currentImage_id` int(11) default NULL,
  `level_id` int(11) default NULL,
  `type_id` int(11) default NULL,
  PRIMARY KEY  (`product_id`),
  KEY `FK50C664CFDF1E28B` (`company_id`),
  KEY `FK50C664CFF3C5796B` (`level_id`),
  KEY `FK50C664CFD17D5E7A` (`type_id`),
  KEY `FK50C664CFC1E74A84` (`currentImage_id`),
  CONSTRAINT `FK50C664CFC1E74A84` FOREIGN KEY (`currentImage_id`) REFERENCES `image` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK50C664CFD17D5E7A` FOREIGN KEY (`type_id`) REFERENCES `producttype` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK50C664CFDF1E28B` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK50C664CFF3C5796B` FOREIGN KEY (`level_id`) REFERENCES `level` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('2', '22', '<p>羽毛球场<br/></p>', '\0', '', '\0', '羽毛球场', '28', '羽毛球场', '5', '220', '1', '29', null, '5');
INSERT INTO `product` VALUES ('3', '21', '<p>游泳池<br/></p>', '\0', '', '', '游泳池', '22', '游泳池', '5', '0', '1', '32', null, '12');
INSERT INTO `product` VALUES ('5', '268', '<p>踢足球哦。。。。<br/></p>', '\0', '', '', '足球场', '288', '足球场', '5', '9', '1', '35', null, '11');
INSERT INTO `product` VALUES ('6', '22', '<p>足球教练<br/></p>', '\0', '', '\0', '足球教练', '23', '足球教练', '5', '0', '1', '55', null, '11');
INSERT INTO `product` VALUES ('9', '33', '<p>werwer<br/></p>', '\0', '\0', '', 'sdfsdfsds', '33', 'fdfasdfas', '5', '0', '1', null, null, '11');
INSERT INTO `product` VALUES ('10', '22', '<p>zsdfdsfdsfds<br/></p>', '\0', '\0', '', 'afasdads', '22', 'safasdfs', '5', '0', '5', null, null, '11');
INSERT INTO `product` VALUES ('11', '22', '<p>sadfsdfsd<br/></p>', '\0', '', '', 'asfasdfas', '23', 'asdfs', '5', '8', '1', null, null, '5');
INSERT INTO `product` VALUES ('12', '22', '<p>fasdfsf<br/></p>', '\0', '\0', '', 'sdfasdfdsf', '22', 'sfasfdsa', '5', '0', '1', null, null, '5');
INSERT INTO `product` VALUES ('13', '12', '<p>sdfsdfasdff<br/></p>', '\0', '\0', '', 'dfgdfsgdsf', '22', 'dgssdfd', '5', '0', '1', null, null, '11');
INSERT INTO `product` VALUES ('14', '11', '<p>第三方第三方范德萨<br/></p>', '\0', '\0', '', '阿是飞洒打底衫', '22', '第三方第三方顾得上', '5', '0', '1', null, null, '18');

-- ----------------------------
-- Table structure for producttype
-- ----------------------------
DROP TABLE IF EXISTS `producttype`;
CREATE TABLE `producttype` (
  `id` int(11) NOT NULL auto_increment,
  `grade` int(11) NOT NULL,
  `introduction` longtext,
  `leaf` bit(1) NOT NULL,
  `typeName` varchar(255) default NULL,
  `parentProductType_id` int(11) default NULL,
  `image_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `typeName` (`typeName`),
  KEY `FKA8168A9AABC8DD5` (`parentProductType_id`),
  KEY `FKA8168A93F70160B` (`image_id`),
  CONSTRAINT `FKA8168A93F70160B` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FKA8168A9AABC8DD5` FOREIGN KEY (`parentProductType_id`) REFERENCES `producttype` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of producttype
-- ----------------------------
INSERT INTO `producttype` VALUES ('1', '0', '', '\0', '球类运动', null, null);
INSERT INTO `producttype` VALUES ('2', '0', '', '\0', '室内运动', null, null);
INSERT INTO `producttype` VALUES ('5', '1', '', '', '羽毛球', '1', '101');
INSERT INTO `producttype` VALUES ('11', '1', '', '', '足球', '1', '102');
INSERT INTO `producttype` VALUES ('12', '1', '', '', '游泳', '2', '106');
INSERT INTO `producttype` VALUES ('13', '1', '', '', '桌球', '1', '103');
INSERT INTO `producttype` VALUES ('15', '1', '', '', '保龄球', '1', '104');
INSERT INTO `producttype` VALUES ('16', '1', '', '', '网球', '1', '105');
INSERT INTO `producttype` VALUES ('18', '1', '', '', '健身房', '2', '107');
INSERT INTO `producttype` VALUES ('19', '1', '', '', '舞蹈', '1', null);
INSERT INTO `producttype` VALUES ('20', '1', '', '', '瑜伽', '1', null);

-- ----------------------------
-- Table structure for product_image
-- ----------------------------
DROP TABLE IF EXISTS `product_image`;
CREATE TABLE `product_image` (
  `Product_product_id` int(11) NOT NULL,
  `smallImages_id` int(11) default NULL,
  `midImages_id` int(11) default NULL,
  `bigImages_id` int(11) default NULL,
  KEY `FK7FE969CBC94EEA7` (`smallImages_id`),
  KEY `FK7FE969CB383B686` (`midImages_id`),
  KEY `FK7FE969CB65AE229B` (`Product_product_id`),
  KEY `FK7FE969CB8BBDEECE` (`bigImages_id`),
  CONSTRAINT `FK7FE969CB383B686` FOREIGN KEY (`midImages_id`) REFERENCES `image` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK7FE969CB65AE229B` FOREIGN KEY (`Product_product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `FK7FE969CB8BBDEECE` FOREIGN KEY (`bigImages_id`) REFERENCES `image` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK7FE969CBC94EEA7` FOREIGN KEY (`smallImages_id`) REFERENCES `image` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of product_image
-- ----------------------------
INSERT INTO `product_image` VALUES ('3', null, '32', null);
INSERT INTO `product_image` VALUES ('3', null, '34', null);
INSERT INTO `product_image` VALUES ('3', null, '33', null);
INSERT INTO `product_image` VALUES ('5', null, '35', null);
INSERT INTO `product_image` VALUES ('5', null, '36', null);
INSERT INTO `product_image` VALUES ('5', null, '37', null);
INSERT INTO `product_image` VALUES ('2', null, '29', null);
INSERT INTO `product_image` VALUES ('2', null, '30', null);
INSERT INTO `product_image` VALUES ('2', null, '31', null);
INSERT INTO `product_image` VALUES ('2', null, '46', null);
INSERT INTO `product_image` VALUES ('6', null, '55', null);
INSERT INTO `product_image` VALUES ('6', null, '56', null);
INSERT INTO `product_image` VALUES ('6', null, '57', null);

-- ----------------------------
-- Table structure for refound
-- ----------------------------
DROP TABLE IF EXISTS `refound`;
CREATE TABLE `refound` (
  `id` int(11) NOT NULL auto_increment,
  `applyTime` datetime default NULL,
  `hasRefound` bit(1) NOT NULL,
  `phone` varchar(255) default NULL,
  `realName` varchar(255) default NULL,
  `reason` longtext,
  `refoundedTime` datetime default NULL,
  `weixinAcount` varchar(255) default NULL,
  `zifubaoAcount` varchar(255) default NULL,
  `order_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKA3EA090F34C1E989` (`user_id`),
  KEY `FKA3EA090FBC956D2B` (`order_id`),
  CONSTRAINT `FKA3EA090F34C1E989` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FKA3EA090FBC956D2B` FOREIGN KEY (`order_id`) REFERENCES `user_order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of refound
-- ----------------------------
INSERT INTO `refound` VALUES ('6', '2015-10-25 22:54:51', '\0', 'dcdgsdg', 'fdgdfsg', 'dgfsdfg\r\n', null, 'dsgsdfg', 'sdgdfsg', '65', '2');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL auto_increment,
  `detail` longtext,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '平台超级管理员', 'superManager');
INSERT INTO `role` VALUES ('2', '入驻商家最高权限管理员', 'joinedSuperManager');
INSERT INTO `role` VALUES ('3', '平台教练用户', 'coachRole');

-- ----------------------------
-- Table structure for role_manager_right
-- ----------------------------
DROP TABLE IF EXISTS `role_manager_right`;
CREATE TABLE `role_manager_right` (
  `Role_id` int(11) NOT NULL,
  `rights_id` int(11) NOT NULL,
  KEY `FK3B7607218F9725A9` (`Role_id`),
  KEY `FK3B76072115B0B4D0` (`rights_id`),
  KEY `rights_id` USING BTREE (`rights_id`),
  CONSTRAINT `FK3B76072115B0B4D0` FOREIGN KEY (`rights_id`) REFERENCES `manager_right` (`id`),
  CONSTRAINT `FK3B7607218F9725A9` FOREIGN KEY (`Role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of role_manager_right
-- ----------------------------
INSERT INTO `role_manager_right` VALUES ('1', '1');
INSERT INTO `role_manager_right` VALUES ('1', '2');
INSERT INTO `role_manager_right` VALUES ('1', '3');
INSERT INTO `role_manager_right` VALUES ('1', '4');
INSERT INTO `role_manager_right` VALUES ('1', '5');
INSERT INTO `role_manager_right` VALUES ('1', '6');
INSERT INTO `role_manager_right` VALUES ('1', '7');
INSERT INTO `role_manager_right` VALUES ('1', '8');
INSERT INTO `role_manager_right` VALUES ('1', '9');
INSERT INTO `role_manager_right` VALUES ('1', '10');
INSERT INTO `role_manager_right` VALUES ('1', '11');
INSERT INTO `role_manager_right` VALUES ('1', '12');
INSERT INTO `role_manager_right` VALUES ('1', '13');
INSERT INTO `role_manager_right` VALUES ('2', '1');
INSERT INTO `role_manager_right` VALUES ('2', '3');
INSERT INTO `role_manager_right` VALUES ('2', '16');
INSERT INTO `role_manager_right` VALUES ('2', '14');
INSERT INTO `role_manager_right` VALUES ('3', '14');
INSERT INTO `role_manager_right` VALUES ('3', '16');

-- ----------------------------
-- Table structure for site
-- ----------------------------
DROP TABLE IF EXISTS `site`;
CREATE TABLE `site` (
  `id` bigint(20) NOT NULL auto_increment,
  `XAddr` float default NULL,
  `YAddr` float default NULL,
  `dayJobTime` longtext,
  `detail` longtext,
  `route` varchar(255) default NULL,
  `sellProducts` varchar(255) default NULL,
  `service` longtext,
  `siteAddress` varchar(255) default NULL,
  `siteName` varchar(255) default NULL,
  `sitePhone` varchar(255) default NULL,
  `weekJobTime` longtext,
  `address_id` int(11) default NULL,
  `company_id` int(11) default NULL,
  `topValue` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK275367DF1E28B` (`company_id`),
  KEY `FK27536713579B2B` (`address_id`),
  CONSTRAINT `FK27536713579B2B` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK275367DF1E28B` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of site
-- ----------------------------
INSERT INTO `site` VALUES ('1', '0', '0', '0,0,0,0,0,0,1,1,1,1,1,1,0,0,1,1,1,1,0,1,1,1,1,0', '<p>位于南湖大道（邮政编码414000）的岳阳市体育馆主要经营提供训练场地与相关服务。促进体育事业发展。训练场地提供与管理、场体器材管理、体育培训比赛组织、相关产业经营，注册资本30万元人民币<br/>\r\n &nbsp;\r\n &nbsp; &nbsp;	\r\n	 </p><p>&nbsp;	\r\n	</p><table bgcolor=\"#eee\" border=\"0\" cellpadding=\"6\" cellspacing=\"1\" width=\"98%\"><tbody><tr class=\"firstRow\"><td bgcolor=\"#FFFFFF\" valign=\"top\" width=\"100\">主要经营</td><td bgcolor=\"#FFFFFF\">提供训练场地与相关服务。促进体育事业发展。训练场地提供与管理、场体器材管理、体育培训比赛组织、相关产业经营</td></tr><tr><td bgcolor=\"#FFFFFF\" valign=\"top\" width=\"100\">营业范围</td><td bgcolor=\"#FFFFFF\"><br/></td></tr><tr><td bgcolor=\"#FFFFFF\" valign=\"top\" width=\"100\">法人代表</td><td bgcolor=\"#FFFFFF\"><br/></td></tr><tr><td bgcolor=\"#FFFFFF\" valign=\"top\" width=\"100\">经营模式</td><td bgcolor=\"#FFFFFF\"><br/></td></tr><tr><td bgcolor=\"#FFFFFF\" valign=\"top\" width=\"100\">地址</td><td bgcolor=\"#FFFFFF\">南湖大道</td></tr><tr><td bgcolor=\"#FFFFFF\" valign=\"top\" width=\"100\">行政区号</td><td bgcolor=\"#FFFFFF\">430602</td></tr><tr><td bgcolor=\"#FFFFFF\" valign=\"top\" width=\"100\">注册资金</td><td bgcolor=\"#FFFFFF\">30万元人民币</td></tr><tr><td bgcolor=\"#FFFFFF\" valign=\"top\" width=\"100\">网址</td><td bgcolor=\"#FFFFFF\">http://yueyang02501.11467.com</td></tr></tbody></table>', '5路、31路、7路、游2路', null, 'dfgdsfgsdfgdfs', '岳阳楼区学院路湖南理工学院西院希望门', '岳阳体育馆', '456345546', '0,1,0,1,1,1,1', '5', '1', '5');
INSERT INTO `site` VALUES ('2', '0', '0', '0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0', '<p>郭镇游泳馆<br/></p>', '31路公交', '冷饮、零食等', null, '郭镇和平路向里面直走200米', '郭镇游泳馆', '4634546', '1,1,1,1,1,1,1', '6', '1', '3');
INSERT INTO `site` VALUES ('9', '0', '0', '0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0', '<p>asfasfasdf<br/></p>', 'sdfdsfsdf', 'sfasdfasdfas', 'sdfasdf', 'fssdffsdfsdfds', 'dfadsfds', '11111111111', '1,1,1,1,1,1,1', '5', '5', '4');
INSERT INTO `site` VALUES ('10', '0', '0', '0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0', '<p>afasdfasdfs<br/></p>', 'asfadsfasdfa', 'afasdfadsf', 'asfdasfas', 'fsdfsdfasdfasdf', 'sdfasdfasd', '12323235434343', '1,1,1,1,1,1,1', '5', '5', '0');
INSERT INTO `site` VALUES ('11', '0', '0', '0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0', '<p>sfasfasfsf<br/></p>', 'sadfasfas', 'sfasdfdsaf', 'sfadsfasd', 'sfdsfsdfs', 'asdfadsfas', 'fdsfsfdsf', '1,1,1,1,1,1,1', '5', '5', '0');
INSERT INTO `site` VALUES ('12', '0', '0', '0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0', '<p>dsgsdfgdfg<br/></p>', 'dsgsdfgdf', null, 'sdgdfsgsdf', 'dsgdfsgdfsgdfsgdfsg', 'dsfds', '132253432432', '1,1,1,1,1,1,1', '5', '1', '0');
INSERT INTO `site` VALUES ('13', '0', '0', '0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0', '<p>第三方贵的发生过史蒂夫干的<br/></p>', '是的大哥大范甘迪发送给', null, '鬼地方三个地方闪光灯', '4一台4645的风格的风格打三国杀', '是电风扇的咖啡机', '2435345', '1,0,0,1,1,1,1', '5', '1', '0');

-- ----------------------------
-- Table structure for site_coach
-- ----------------------------
DROP TABLE IF EXISTS `site_coach`;
CREATE TABLE `site_coach` (
  `sites_id` bigint(20) NOT NULL,
  `coachs_id` int(11) NOT NULL,
  KEY `FK9ABF61A28D8DCACC` (`coachs_id`),
  KEY `FK9ABF61A265D28B24` (`sites_id`),
  CONSTRAINT `FK9ABF61A28D8DCACC` FOREIGN KEY (`coachs_id`) REFERENCES `coach` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of site_coach
-- ----------------------------

-- ----------------------------
-- Table structure for site_image
-- ----------------------------
DROP TABLE IF EXISTS `site_image`;
CREATE TABLE `site_image` (
  `Site_id` bigint(20) NOT NULL,
  `images_id` int(11) NOT NULL,
  UNIQUE KEY `images_id` (`images_id`),
  KEY `FK9B1306633E62CBCE` (`images_id`),
  KEY `FK9B130663BAB16809` (`Site_id`),
  CONSTRAINT `FK9B1306633E62CBCE` FOREIGN KEY (`images_id`) REFERENCES `image` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK9B130663BAB16809` FOREIGN KEY (`Site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of site_image
-- ----------------------------
INSERT INTO `site_image` VALUES ('1', '20');
INSERT INTO `site_image` VALUES ('1', '21');
INSERT INTO `site_image` VALUES ('1', '22');
INSERT INTO `site_image` VALUES ('2', '26');
INSERT INTO `site_image` VALUES ('2', '27');
INSERT INTO `site_image` VALUES ('2', '28');

-- ----------------------------
-- Table structure for updateprogress
-- ----------------------------
DROP TABLE IF EXISTS `updateprogress`;
CREATE TABLE `updateprogress` (
  `id` int(11) NOT NULL auto_increment,
  `date` date default NULL,
  `updateDayNumber` int(11) NOT NULL,
  `updateNumber` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of updateprogress
-- ----------------------------
INSERT INTO `updateprogress` VALUES ('1', '2015-11-08', '7', '494');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `experience` bigint(20) NOT NULL,
  `integration` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `registerDate` datetime default NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK285FEBEE6E885F` (`id`),
  CONSTRAINT `FK285FEBEE6E885F` FOREIGN KEY (`id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('16', '0', '1', '2015-09-29 12:03:14', '2');
INSERT INTO `user` VALUES ('0', '0', '1', '2015-10-31 21:18:48', '40');

-- ----------------------------
-- Table structure for user_order
-- ----------------------------
DROP TABLE IF EXISTS `user_order`;
CREATE TABLE `user_order` (
  `id` int(11) NOT NULL auto_increment,
  `deliveredTime` datetime default NULL,
  `hasDelivered` bit(1) NOT NULL,
  `hasPay` bit(1) NOT NULL,
  `hasRead` bit(1) NOT NULL,
  `hasSubmit` bit(1) NOT NULL,
  `hasUse` bit(1) NOT NULL,
  `hasUseless` bit(1) NOT NULL,
  `orderNumber` varchar(255) default NULL,
  `orderStatus` int(11) NOT NULL,
  `payTime` datetime default NULL,
  `receiverName` varchar(255) default NULL,
  `receiverPhone` varchar(255) default NULL,
  `submitTime` datetime default NULL,
  `totalAcount` float NOT NULL,
  `tradeNumber` varchar(255) default NULL,
  `useTime` datetime default NULL,
  `buyer_id` int(11) default NULL,
  `company_id` int(11) default NULL,
  `createTime` datetime default NULL,
  `preOrderTime` datetime default NULL,
  `coach_id` int(11) default NULL,
  `jsPayParams` varchar(255) default NULL,
  `nativePayUrl` varchar(255) default NULL,
  `payingBeginTime` datetime default NULL,
  `refoundAplyTime` datetime default NULL,
  `site_id` bigint(20) default NULL,
  `phone` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `orderNumber` (`orderNumber`),
  UNIQUE KEY `tradeNumber` (`tradeNumber`),
  KEY `FK731991DA3322AA1` (`buyer_id`),
  KEY `FK731991DADF1E28B` (`company_id`),
  KEY `FK731991DA396AD9AB` (`coach_id`),
  KEY `FK731991DABAB16809` (`site_id`),
  CONSTRAINT `FK731991DA3322AA1` FOREIGN KEY (`buyer_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK731991DA396AD9AB` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK731991DABAB16809` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK731991DADF1E28B` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user_order
-- ----------------------------
INSERT INTO `user_order` VALUES ('15', null, '\0', '', '\0', '', '', '\0', '1445433885765', '4', '2015-10-21 21:24:56', null, null, '2015-10-21 21:24:51', '50', null, '2015-10-21 21:25:08', '2', '1', '2015-10-21 21:24:45', '2015-10-21 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('17', null, '\0', '', '\0', '', '', '\0', '1445504970392', '4', '2015-10-22 17:10:25', null, null, '2015-10-22 17:09:34', '75', null, '2015-10-29 20:07:53', '2', '1', '2015-10-22 17:09:30', '2015-10-22 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('18', null, '\0', '\0', '\0', '', '\0', '\0', '1445511951198', '5', null, null, null, '2015-10-22 19:06:01', '75', null, null, null, '1', '2015-10-22 19:05:51', '2015-10-22 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('19', null, '\0', '\0', '\0', '', '\0', '\0', '1445517023954', '5', null, null, null, '2015-10-22 20:30:30', '75', null, null, null, '1', '2015-10-22 20:30:23', '2015-10-22 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('20', null, '\0', '\0', '\0', '', '\0', '\0', '1445518014825', '5', null, null, null, '2015-10-22 20:47:02', '50', null, null, null, '1', '2015-10-22 20:46:54', '2015-10-22 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('21', null, '\0', '\0', '\0', '', '\0', '\0', '1445518479141', '5', null, null, null, '2015-10-22 20:54:42', '50', null, null, null, '1', '2015-10-22 20:54:39', '2015-10-22 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('22', null, '\0', '\0', '\0', '', '\0', '\0', '1445518541664', '5', null, null, null, '2015-10-22 20:55:45', '50', null, null, null, '1', '2015-10-22 20:55:41', '2015-10-23 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('23', null, '\0', '\0', '\0', '', '\0', '\0', '1445519742625', '5', null, null, null, '2015-10-22 21:15:46', '50', null, null, null, '1', '2015-10-22 21:15:42', '2015-10-23 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('24', null, '\0', '\0', '\0', '', '\0', '\0', '1445561786351', '5', null, null, null, '2015-10-23 08:56:31', '50', null, null, null, '1', '2015-10-23 08:56:26', '2015-10-23 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('25', null, '\0', '\0', '\0', '', '\0', '\0', '1445562170684', '5', null, null, null, '2015-10-23 09:02:55', '50', null, null, null, '1', '2015-10-23 09:02:50', '2015-10-23 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('26', null, '\0', '\0', '\0', '\0', '\0', '\0', '1445565806919', '5', null, null, null, null, '25', null, null, null, '1', '2015-10-23 10:03:26', '2015-10-23 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('27', null, '\0', '\0', '\0', '', '\0', '\0', '1445565811803', '5', null, null, null, '2015-10-23 10:03:53', '25', null, null, null, '1', '2015-10-23 10:03:31', '2015-10-23 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('28', null, '\0', '\0', '\0', '', '\0', '\0', '1445565873192', '5', null, null, null, '2015-10-23 10:04:47', '50', null, null, null, '1', '2015-10-23 10:04:33', '2015-10-23 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('29', null, '\0', '\0', '\0', '', '\0', '\0', '1445566077778', '5', null, null, null, '2015-10-23 10:08:01', '50', null, null, null, '1', '2015-10-23 10:07:57', '2015-10-23 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('30', null, '\0', '\0', '\0', '', '\0', '\0', '1445567414466', '5', null, null, null, '2015-10-23 10:30:25', '25', null, null, null, '1', '2015-10-23 10:30:14', '2015-10-23 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('31', null, '\0', '', '\0', '', '', '\0', '1445568190382', '4', '2015-10-23 10:43:33', null, null, '2015-10-23 10:43:12', '25', null, '2015-10-29 20:07:52', null, '1', '2015-10-23 10:43:10', '2015-10-24 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('36', null, '\0', '\0', '\0', '', '\0', '\0', '1445603890112', '5', null, null, null, '2015-10-23 20:38:16', '25', null, null, null, '1', '2015-10-23 20:38:10', '2015-10-23 00:00:00', null, '\"appId\":\"wx7019cdad52c69a47\",\"timeStamp\":\"1445603931\",\"nonceStr\":\"2038516321\",\"package\":\"prepay_id=wx20151023203852b422e86cda0419093359\",\"signType\" : \"MD5\",\"paySign\":\"190792169F4EFD590844194F566AC77C\"', null, '2015-10-23 20:38:51', null, '1', null);
INSERT INTO `user_order` VALUES ('40', null, '\0', '\0', '\0', '', '\0', '\0', '1445652916348', '5', null, null, null, '2015-10-24 10:15:20', '25', null, null, null, '1', '2015-10-24 10:15:16', '2015-10-24 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('63', null, '\0', '', '\0', '', '\0', '\0', '1445781545364', '9', '2015-10-25 21:59:23', null, null, '2015-10-25 21:59:10', '50', null, null, '2', '1', '2015-10-25 21:59:05', '2015-10-27 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('65', null, '\0', '', '\0', '', '\0', '\0', '1445784861925', '8', '2015-10-25 22:54:33', null, null, '2015-10-25 22:54:24', '50', null, null, '2', '1', '2015-10-25 22:54:21', '2015-10-27 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('66', null, '\0', '\0', '\0', '', '\0', '\0', '1446111083935', '5', null, null, null, '2015-10-29 17:31:28', '100', null, null, '2', '1', '2015-10-29 17:31:23', '2015-10-29 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('67', null, '\0', '', '\0', '', '', '\0', '1446111102075', '4', '2015-10-29 17:32:56', null, null, '2015-10-29 17:32:04', '250', null, '2015-10-29 20:07:43', '2', '1', '2015-10-29 17:31:42', '2015-10-29 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('81', null, '\0', '', '\0', '', '\0', '\0', '1446204185418', '3', '2015-10-30 19:27:22', null, null, '2015-10-30 19:27:06', '175', null, null, '2', '1', '2015-10-30 19:23:05', '2015-10-31 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('97', null, '\0', '\0', '\0', '', '\0', '\0', '1446295218328', '5', null, null, null, '2015-10-31 20:40:19', '25', null, null, '2', '1', '2015-10-31 20:40:18', '2015-10-31 00:00:00', null, null, 'weixin://wxpay/bizpayurl?pr=x5eJLwT', '2015-10-31 20:40:25', null, '1', null);
INSERT INTO `user_order` VALUES ('115', null, '\0', '\0', '\0', '', '\0', '\0', '1446355585218', '5', null, null, null, '2015-11-01 13:26:26', '25', null, null, '2', '1', '2015-11-01 13:26:25', '2015-11-01 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('117', null, '\0', '\0', '\0', '', '\0', '\0', '1446355727924', '5', null, null, null, '2015-11-01 13:28:52', '50', null, null, '2', '1', '2015-11-01 13:28:47', '2015-11-02 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('150', null, '\0', '\0', '\0', '', '\0', '\0', '1446452450934', '5', null, null, null, '2015-11-02 16:20:56', '25', null, null, '2', '1', '2015-11-02 16:20:50', '2015-11-03 00:00:00', null, null, null, null, null, '1', null);
INSERT INTO `user_order` VALUES ('155', null, '\0', '\0', '\0', '', '\0', '\0', '1446618093964', '5', null, null, null, '2015-11-04 14:21:35', '25', null, null, '2', '1', '2015-11-04 14:21:33', '2015-11-05 00:00:00', null, '\"appId\":\"wx7019cdad52c69a47\",\"timeStamp\":\"1446618157\",\"nonceStr\":\"1422357850\",\"package\":\"prepay_id=\",\"signType\" : \"MD5\",\"paySign\":\"3A58B1CB577137659AD3006C84363BB8\"', null, '2015-11-04 14:22:37', null, '1', '15200292390');
INSERT INTO `user_order` VALUES ('156', null, '\0', '\0', '\0', '', '\0', '\0', '1446618237608', '5', null, null, null, '2015-11-04 14:24:00', '50', null, null, '2', '1', '2015-11-04 14:23:57', '2015-11-05 00:00:00', null, null, null, null, null, '1', '15200292390');
INSERT INTO `user_order` VALUES ('159', null, '\0', '\0', '\0', '', '\0', '\0', '1446897280106', '5', null, null, null, '2015-11-07 19:54:41', '25', null, null, '2', '1', '2015-11-07 19:54:40', '2015-11-07 00:00:00', null, null, null, null, null, '1', null);

-- ----------------------------
-- Table structure for user_product
-- ----------------------------
DROP TABLE IF EXISTS `user_product`;
CREATE TABLE `user_product` (
  `User_id` int(11) NOT NULL,
  `careProducts_product_id` int(11) NOT NULL,
  UNIQUE KEY `careProducts_product_id` (`careProducts_product_id`),
  KEY `FKB581507B34C1E989` (`User_id`),
  KEY `FKB581507BD3E71455` (`careProducts_product_id`),
  CONSTRAINT `FKB581507B34C1E989` FOREIGN KEY (`User_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKB581507BD3E71455` FOREIGN KEY (`careProducts_product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user_product
-- ----------------------------

-- ----------------------------
-- Table structure for user_producttype
-- ----------------------------
DROP TABLE IF EXISTS `user_producttype`;
CREATE TABLE `user_producttype` (
  `User_id` int(11) NOT NULL,
  `types_id` int(11) NOT NULL,
  UNIQUE KEY `types_id` (`types_id`),
  KEY `FK7B469E55DC1498DB` (`types_id`),
  KEY `FK7B469E5534C1E989` (`User_id`),
  CONSTRAINT `FK7B469E5534C1E989` FOREIGN KEY (`User_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK7B469E55DC1498DB` FOREIGN KEY (`types_id`) REFERENCES `producttype` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of user_producttype
-- ----------------------------
