-- MySQL dump 10.13  Distrib 8.0.43, for Linux (aarch64)
--
-- Host: localhost    Database: novel_plus
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE database if NOT EXISTS `novel_plus` default character set utf8mb4 collate utf8mb4_unicode_ci;
use `novel_plus`;
SET NAMES utf8mb4;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `author` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `invite_code` varchar(20) DEFAULT NULL COMMENT '邀请码',
  `pen_name` varchar(20) DEFAULT NULL COMMENT '笔名',
  `tel_phone` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `chat_account` varchar(50) DEFAULT NULL COMMENT 'QQ或微信账号',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `work_direction` tinyint DEFAULT NULL COMMENT '作品方向，0：男频，1：女频',
  `status` tinyint DEFAULT '0' COMMENT '0：正常，1：封禁',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='作者表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_code`
--

DROP TABLE IF EXISTS `author_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `author_code` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `invite_code` varchar(100) DEFAULT NULL COMMENT '邀请码',
  `validity_time` datetime DEFAULT NULL COMMENT '有效时间',
  `is_use` tinyint(1) DEFAULT '0' COMMENT '是否使用过，0：未使用，1:使用过',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '创建人ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_code` (`invite_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='作家邀请码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_income`
--

DROP TABLE IF EXISTS `author_income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `author_income` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `author_id` bigint NOT NULL COMMENT '作家ID',
  `book_id` bigint NOT NULL COMMENT '作品ID',
  `income_month` date NOT NULL COMMENT '收入月份',
  `pre_tax_income` bigint NOT NULL DEFAULT '0' COMMENT '税前收入（分）',
  `after_tax_income` bigint NOT NULL DEFAULT '0' COMMENT '税后收入（分）',
  `pay_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '支付状态，0：待支付，1：已支付',
  `confirm_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '稿费确认状态，0：待确认，1：已确认',
  `detail` varchar(255) DEFAULT NULL COMMENT '详情',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='稿费收入统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_income_detail`
--

DROP TABLE IF EXISTS `author_income_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `author_income_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `author_id` bigint NOT NULL COMMENT '作家ID',
  `book_id` bigint NOT NULL DEFAULT '0' COMMENT '作品ID,0表示全部作品',
  `income_date` date NOT NULL COMMENT '收入日期',
  `income_account` int NOT NULL DEFAULT '0' COMMENT '订阅总额',
  `income_count` int NOT NULL DEFAULT '0' COMMENT '订阅次数',
  `income_number` int NOT NULL DEFAULT '0' COMMENT '订阅人数',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='稿费收入明细统计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `work_direction` tinyint(1) DEFAULT NULL COMMENT '作品方向，0：男频，1：女频''',
  `cat_id` int DEFAULT NULL COMMENT '分类ID',
  `cat_name` varchar(50) DEFAULT NULL COMMENT '分类名',
  `pic_url` varchar(200) NOT NULL COMMENT '小说封面',
  `book_name` varchar(50) NOT NULL COMMENT '小说名',
  `book_name_alias` varchar(200) DEFAULT NULL COMMENT '小说别名',
  `author_id` bigint DEFAULT NULL COMMENT '作者id',
  `author_name` varchar(50) NOT NULL COMMENT '作者名',
  `book_desc` varchar(2000) NOT NULL COMMENT '书籍描述',
  `score` float NOT NULL COMMENT '评分，预留字段',
  `book_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '书籍状态，0：连载中，1：已完结',
  `visit_count` bigint DEFAULT '103' COMMENT '点击量',
  `word_count` int DEFAULT NULL COMMENT '总字数',
  `comment_count` int DEFAULT '0' COMMENT '评论数',
  `yesterday_buy` int DEFAULT '0' COMMENT '昨日订阅数',
  `last_index_id` bigint DEFAULT NULL COMMENT '最新目录ID',
  `last_index_name` varchar(50) DEFAULT NULL COMMENT '最新目录名',
  `last_index_update_time` datetime DEFAULT NULL COMMENT '最新目录更新时间',
  `is_vip` tinyint(1) DEFAULT '0' COMMENT '是否收费，1：收费，0：免费',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态，0：入库，1：上架',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `crawl_source_id` int DEFAULT NULL COMMENT '爬虫源站ID',
  `crawl_book_id` varchar(32) DEFAULT NULL COMMENT '抓取的源站小说ID',
  `crawl_book_url` varchar(250) DEFAULT NULL COMMENT '抓取的源站小说URL',
  `crawl_last_time` datetime DEFAULT NULL COMMENT '最后一次的抓取时间',
  `crawl_is_stop` tinyint(1) DEFAULT '0' COMMENT '是否已停止更新，0：未停止，1：已停止',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_bookName_authorName` (`book_name`,`author_name`) USING BTREE,
  KEY `key_lastIndexUpdateTime` (`last_index_update_time`) USING BTREE,
  KEY `key_createTime` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_author`
--

DROP TABLE IF EXISTS `book_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_author` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `invite_code` varchar(20) DEFAULT NULL COMMENT '邀请码',
  `pen_name` varchar(20) DEFAULT NULL COMMENT '笔名',
  `tel_phone` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `chat_account` varchar(50) DEFAULT NULL COMMENT 'QQ或微信账号',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `work_direction` tinyint DEFAULT NULL COMMENT '作品方向，0：男频，1：女频',
  `status` tinyint DEFAULT NULL COMMENT '0：待审核，1：审核通过，正常，2：审核不通过',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '申请人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='作者表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_category`
--

DROP TABLE IF EXISTS `book_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `work_direction` tinyint(1) DEFAULT NULL COMMENT '作品方向，0：男频，1：女频''',
  `name` varchar(20) NOT NULL COMMENT '分类名',
  `sort` tinyint NOT NULL DEFAULT '10' COMMENT '排序',
  `create_user_id` bigint DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_user_id` bigint DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说类别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_comment`
--

DROP TABLE IF EXISTS `book_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `book_id` bigint DEFAULT NULL COMMENT '小说ID',
  `comment_content` varchar(512) DEFAULT NULL COMMENT '评价内容',
  `location` varchar(50) DEFAULT NULL COMMENT '地理位置',
  `reply_count` int DEFAULT '0' COMMENT '回复数量',
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '审核状态，0：待审核，1：审核通过，2：审核不通过',
  `create_time` datetime DEFAULT NULL COMMENT '评价时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '评价人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_bookid_userid` (`book_id`,`create_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_comment_reply`
--

DROP TABLE IF EXISTS `book_comment_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_comment_reply` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `comment_id` bigint DEFAULT NULL COMMENT '评论ID',
  `reply_content` varchar(512) DEFAULT NULL COMMENT '回复内容',
  `location` varchar(50) DEFAULT NULL COMMENT '地理位置',
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '审核状态，0：待审核，1：审核通过，2：审核不通过',
  `create_time` datetime DEFAULT NULL COMMENT '回复用户ID',
  `create_user_id` bigint DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说评论回复表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_content`
--

DROP TABLE IF EXISTS `book_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_content` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext COMMENT '小说章节内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_content0`
--

DROP TABLE IF EXISTS `book_content0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_content0` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext COMMENT '小说章节内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_content1`
--

DROP TABLE IF EXISTS `book_content1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_content1` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext COMMENT '小说章节内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_content2`
--

DROP TABLE IF EXISTS `book_content2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_content2` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext COMMENT '小说章节内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_content3`
--

DROP TABLE IF EXISTS `book_content3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_content3` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext COMMENT '小说章节内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_content4`
--

DROP TABLE IF EXISTS `book_content4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_content4` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext COMMENT '小说章节内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_content5`
--

DROP TABLE IF EXISTS `book_content5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_content5` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext COMMENT '小说章节内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_content6`
--

DROP TABLE IF EXISTS `book_content6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_content6` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext COMMENT '小说章节内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_content7`
--

DROP TABLE IF EXISTS `book_content7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_content7` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext COMMENT '小说章节内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_content8`
--

DROP TABLE IF EXISTS `book_content8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_content8` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext COMMENT '小说章节内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_content9`
--

DROP TABLE IF EXISTS `book_content9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_content9` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext COMMENT '小说章节内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_index`
--

DROP TABLE IF EXISTS `book_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_index` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `book_id` bigint NOT NULL COMMENT '小说ID',
  `index_num` int NOT NULL COMMENT '目录号',
  `index_name` varchar(100) DEFAULT NULL COMMENT '目录名',
  `word_count` int DEFAULT NULL COMMENT '字数',
  `is_vip` tinyint DEFAULT '0' COMMENT '是否收费，1：收费，0：免费',
  `book_price` int DEFAULT '0' COMMENT '章节费用（屋币）',
  `storage_type` varchar(10) NOT NULL DEFAULT 'db' COMMENT '存储方式',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_bookId_indexNum` (`book_id`,`index_num`) USING BTREE,
  KEY `key_bookId` (`book_id`) USING BTREE,
  KEY `key_indexNum` (`index_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说目录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_screen_bullet`
--

DROP TABLE IF EXISTS `book_screen_bullet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_screen_bullet` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content_id` bigint NOT NULL COMMENT '小说内容ID',
  `screen_bullet` varchar(512) NOT NULL COMMENT '小说弹幕内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `key_contentId` (`content_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='小说弹幕表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_setting`
--

DROP TABLE IF EXISTS `book_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `book_setting` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `book_id` bigint DEFAULT NULL COMMENT '小说ID',
  `sort` tinyint DEFAULT NULL COMMENT '排序号',
  `type` tinyint(1) DEFAULT NULL COMMENT '类型，0：轮播图，1：顶部小说栏设置，2：本周强推，3：热门推荐，4：精品推荐',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='首页小说设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `friend_link`
--

DROP TABLE IF EXISTS `friend_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `friend_link` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `link_name` varchar(50) NOT NULL COMMENT '链接名',
  `link_url` varchar(100) NOT NULL COMMENT '链接url',
  `sort` tinyint NOT NULL DEFAULT '11' COMMENT '排序号',
  `is_open` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开启，0：不开启，1：开启',
  `create_user_id` bigint DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '更新者用户id',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `news` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cat_id` int DEFAULT NULL COMMENT '类别ID',
  `cat_name` varchar(50) DEFAULT NULL COMMENT '分类名',
  `source_name` varchar(50) DEFAULT NULL COMMENT '来源',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `read_count` bigint NOT NULL DEFAULT '0' COMMENT '阅读量',
  `create_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '发布人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='新闻表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news_category`
--

DROP TABLE IF EXISTS `news_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `news_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) NOT NULL COMMENT '分类名',
  `sort` tinyint NOT NULL DEFAULT '10' COMMENT '排序',
  `create_user_id` bigint DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_user_id` bigint DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='新闻类别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_pay`
--

DROP TABLE IF EXISTS `order_pay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `order_pay` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `out_trade_no` bigint NOT NULL COMMENT '商户订单号',
  `trade_no` varchar(64) DEFAULT NULL COMMENT '支付宝/微信交易号',
  `pay_channel` tinyint(1) NOT NULL DEFAULT '1' COMMENT '支付渠道，1：支付宝，2：微信',
  `total_amount` int NOT NULL COMMENT '交易金额(单位元)',
  `user_id` bigint NOT NULL COMMENT '支付用户ID',
  `pay_status` tinyint(1) DEFAULT '2' COMMENT '支付状态：0：支付失败，1：支付成功，2：待支付',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='充值订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_data_perm`
--

DROP TABLE IF EXISTS `sys_data_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_data_perm` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '权限名称',
  `table_name` varchar(50) DEFAULT NULL COMMENT '数据表名称',
  `module_name` varchar(50) DEFAULT NULL COMMENT '所属模块',
  `crl_attr_name` varchar(50) DEFAULT NULL COMMENT '用户权限控制属性名',
  `crl_column_name` varchar(50) DEFAULT NULL COMMENT '数据表权限控制列名',
  `perm_code` varchar(50) DEFAULT NULL COMMENT '权限code，all_开头表示查看所有数据的权限，sup_开头表示查看下级数据的权限，own_开头表示查看本级数据的权限',
  `order_num` int DEFAULT NULL COMMENT '排序',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='数据权限管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint DEFAULT NULL COMMENT '上级部门ID，一级部门为0',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `order_num` int DEFAULT NULL COMMENT '排序',
  `del_flag` tinyint DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='部门管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_dict`
--

DROP TABLE IF EXISTS `sys_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_dict` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '标签名',
  `value` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '数据值',
  `type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '类型',
  `description` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `parent_id` bigint DEFAULT '0' COMMENT '父级编号',
  `create_by` int DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`name`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_file`
--

DROP TABLE IF EXISTS `sys_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_file` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` int DEFAULT NULL COMMENT '文件类型',
  `url` varchar(200) DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='文件上传';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_gen_columns`
--

DROP TABLE IF EXISTS `sys_gen_columns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_gen_columns` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `table_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '表名',
  `column_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '列名',
  `column_type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '映射java类型',
  `column_comment` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '列注释',
  `column_sort` tinyint DEFAULT NULL COMMENT '列排序（升序）',
  `column_label` varchar(64) DEFAULT NULL COMMENT '鍒楁爣绛惧悕',
  `page_type` tinyint DEFAULT '1' COMMENT '页面显示类型：1、文本框 2、下拉框 3、数值4、日期 5、文本域6、富文本 7、上传图片【单文件】 8、上传图片【多文件】9、上传文件【单文件】 10、上传文件【多文件】11、隐藏域 12、不显示',
  `is_required` tinyint(1) DEFAULT NULL COMMENT '是否必填',
  `dict_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '页面显示为下拉时使用，字典类型从字典表中取出',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_gen_table`
--

DROP TABLE IF EXISTS `sys_gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_gen_table` (
  `id` bigint NOT NULL COMMENT '主键',
  `table_name` varchar(64) NOT NULL COMMENT '表名',
  `class_name` varchar(100) NOT NULL COMMENT '实体类名称',
  `comments` varchar(500) NOT NULL COMMENT '表说明',
  `category` tinyint(1) NOT NULL DEFAULT '0' COMMENT '分类：0：数据表，1：树表',
  `package_name` varchar(500) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(200) DEFAULT NULL COMMENT '生成功能名，用于类描述',
  `function_name_simple` varchar(50) DEFAULT NULL COMMENT '生成功能名（简写），用于功能提示，如“保存xx成功”',
  `author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `src_dir` varchar(1000) DEFAULT NULL COMMENT 'src目录',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` bigint NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='代码生成表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_gen_table_column`
--

DROP TABLE IF EXISTS `sys_gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_gen_table_column` (
  `id` bigint NOT NULL COMMENT '主键',
  `table_id` bigint NOT NULL COMMENT '表id',
  `column_name` varchar(64) NOT NULL COMMENT '列名',
  `column_sort` decimal(10,0) DEFAULT NULL COMMENT '列排序（升序）',
  `column_type` varchar(100) NOT NULL COMMENT '类型',
  `column_label` varchar(50) DEFAULT NULL COMMENT '列标签名',
  `comments` varchar(500) NOT NULL COMMENT '列备注说明',
  `attr_name` varchar(200) NOT NULL COMMENT '类的属性名',
  `attr_type` varchar(200) NOT NULL COMMENT '类的属性类型',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键',
  `is_null` char(1) DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否插入字段',
  `is_update` char(1) DEFAULT NULL COMMENT '是否更新字段',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) DEFAULT NULL COMMENT '查询方式',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段',
  `show_type` varchar(200) DEFAULT NULL COMMENT '表单类型',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  PRIMARY KEY (`id`),
  KEY `idx_gen_table_column_tn` (`table_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='代码生成表列';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `time` int DEFAULT NULL COMMENT '响应时间',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='系统日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `order_num` int DEFAULT NULL COMMENT '排序',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='菜单管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `role_sign` varchar(100) DEFAULT NULL COMMENT '角色标识',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `user_id_create` bigint DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='角色';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_role_data_perm`
--

DROP TABLE IF EXISTS `sys_role_data_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_role_data_perm` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `perm_id` bigint DEFAULT NULL COMMENT '权限ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='角色与数据权限对应关系';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_role_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='角色与菜单对应关系';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `name` varchar(100) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `dept_id` bigint DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `status` tinyint DEFAULT NULL COMMENT '状态 0:禁用，1:正常',
  `user_id_create` bigint DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `sex` bigint DEFAULT NULL COMMENT '性别',
  `birth` datetime DEFAULT NULL COMMENT '出身日期',
  `pic_id` bigint DEFAULT NULL,
  `live_address` varchar(500) DEFAULT NULL COMMENT '现居住地',
  `hobby` varchar(255) DEFAULT NULL COMMENT '爱好',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '所在城市',
  `district` varchar(255) DEFAULT NULL COMMENT '所在地区',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `sys_user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='用户与角色对应关系';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(50) NOT NULL COMMENT '登录名',
  `password` varchar(100) NOT NULL COMMENT '登录密码',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '昵称',
  `user_photo` varchar(100) DEFAULT NULL COMMENT '用户头像',
  `user_sex` tinyint(1) DEFAULT NULL COMMENT '用户性别，0：男，1：女',
  `account_balance` bigint NOT NULL DEFAULT '0' COMMENT '账户余额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态，0：正常',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_bookshelf`
--

DROP TABLE IF EXISTS `user_bookshelf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_bookshelf` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `book_id` bigint NOT NULL COMMENT '小说ID',
  `pre_content_id` bigint DEFAULT NULL COMMENT '上一次阅读的章节内容表ID',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_userid_bookid` (`user_id`,`book_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户书架表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_buy_record`
--

DROP TABLE IF EXISTS `user_buy_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_buy_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `book_id` bigint DEFAULT NULL COMMENT '购买的小说ID',
  `book_name` varchar(50) DEFAULT NULL COMMENT '购买的小说名',
  `book_index_id` bigint DEFAULT NULL COMMENT '购买的章节ID',
  `book_index_name` varchar(100) DEFAULT NULL COMMENT '购买的章节名',
  `buy_amount` int DEFAULT NULL COMMENT '购买使用的屋币数量',
  `create_time` datetime DEFAULT NULL COMMENT '购买时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_userId_indexId` (`user_id`,`book_index_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户消费记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_feedback`
--

DROP TABLE IF EXISTS `user_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `content` varchar(512) DEFAULT NULL COMMENT '反馈内容',
  `create_time` datetime DEFAULT NULL COMMENT '反馈时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_read_history`
--

DROP TABLE IF EXISTS `user_read_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `user_read_history` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `book_id` bigint NOT NULL COMMENT '小说ID',
  `pre_content_id` bigint DEFAULT NULL COMMENT '上一次阅读的章节内容表ID',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_uq_userid_bookid` (`user_id`,`book_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户阅读记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `website_info`
--

DROP TABLE IF EXISTS `website_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `website_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '网站名',
  `domain` varchar(50) NOT NULL COMMENT '网站域名',
  `keyword` varchar(50) NOT NULL COMMENT 'SEO关键词',
  `description` varchar(512) NOT NULL COMMENT '网站描述',
  `qq` varchar(20) NOT NULL COMMENT '站长QQ',
  `logo` varchar(200) NOT NULL COMMENT '网站logo图片（默认）',
  `logo_dark` varchar(200) NOT NULL COMMENT '网站logo图片（深色）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='网站信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `crawl_batch_task`
--
DROP TABLE IF EXISTS `crawl_batch_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crawl_batch_task` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_id` int DEFAULT NULL COMMENT '爬虫源ID',
  `crawl_count_success` int DEFAULT NULL COMMENT '成功抓取数量',
  `crawl_count_target` int DEFAULT NULL COMMENT '目标抓取数量',
  `task_status` tinyint(1) DEFAULT '1' COMMENT '任务状态，1：正在运行，0已停止',
  `start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='批量抓取任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `crawl_single_task`
--
DROP TABLE IF EXISTS `crawl_single_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crawl_single_task` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_id` int DEFAULT NULL COMMENT '爬虫源ID',
  `source_name` varchar(50) DEFAULT NULL COMMENT '爬虫源名',
  `source_book_id` varchar(255) DEFAULT NULL COMMENT '源站小说ID',
  `cat_id` int DEFAULT NULL COMMENT '分类ID',
  `book_name` varchar(50) DEFAULT NULL COMMENT '爬取的小说名',
  `author_name` varchar(50) DEFAULT NULL COMMENT '爬取的小说作者名',
  `task_status` tinyint(1) DEFAULT '2' COMMENT '任务状态，0：失败，1：成功，2；未执行',
  `exc_count` tinyint DEFAULT '0' COMMENT '已经执行次数，最多执行5次',
  `crawl_chapters` int DEFAULT '0' COMMENT '采集章节数量',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抓取单本小说任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `crawl_source`
--
DROP TABLE IF EXISTS `crawl_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `crawl_source` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_name` varchar(50) DEFAULT NULL COMMENT '源站名',
  `crawl_rule` text COMMENT '爬取规则（json串）',
  `source_status` tinyint(1) DEFAULT '0' COMMENT '爬虫源状态，0：关闭，1：开启',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='爬虫源表';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `crawl_config`
--
CREATE TABLE IF NOT EXISTS `crawl_config` (
  `id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键ID',
  `config_key` VARCHAR(100) DEFAULT NULL COMMENT '设定键',
  `config_value` VARCHAR(2500) COMMENT '设定值',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  COMMENT ='Crawl Config';

--
-- Table structure for table `search_result`
--
CREATE TABLE IF NOT EXISTS `search_result` (
  `id` BIGINT AUTO_INCREMENT NOT NULL COMMENT '主键ID',
  `source_id` VARCHAR(100) COMMENT '书源id',
  `content` VARCHAR(2500) COMMENT 'result',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  COMMENT ='Search result';


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-15  5:13:23
