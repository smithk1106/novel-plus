
-- ----------------------------
-- Records of crawl_config
-- ----------------------------
INSERT IGNORE INTO `crawl_config` (`id`, `config_key`, `config_value`)
VALUES (1, 'appConfig', '{"version":"1.0","language":"","sourceId":"1","manySourceId":"1,2,3","downloadPath":"download","extName":"db","searchLimit":20,"autoUpdate":0,"interactiveMode":1,"threads":-1,"minInterval":5000,"maxInterval":20000,"maxRetryAttempts":3,"preserveChapterCache":1,"showDownloadLog":1,"retryMinInterval":5000,"retryMaxInterval":20000,"proxyEnabled":0,"proxyHost":"proxy.example.com","proxyPort":8080}');

-- ----------------------------
-- Records of book_category
-- ----------------------------
INSERT INTO `book_category`(`id`, `work_direction`, `name`, `sort`, `create_user_id`, `create_time`, `update_user_id`, `update_time`)
VALUES
  ('1', '0', '玄幻奇幻', '10', null, null, null, null),
  ('2', '0', '武侠仙侠', '11', null, null, null, null),
  ('3', '0', '都市言情', '12', null, null, null, null),
  ('4', '0', '历史军事', '13', null, null, null, null),
  ('5', '0', '科幻灵异', '14', null, null, null, null),
  ('6', '0', '网游竞技', '15', null, null, null, null),
  ('7', '1', '女生频道', '16', null, null, null, null),
  ('8', '0', '体育竞技', '17', null, null, null, null),
  ('9', '0', '青春校园', '18', null, null, null, null),
  ('10', '0', '穿越重生', '19', null, null, null, null),
  ('11', '0', '恐怖悬疑', '20', null, null, null, null);

-- ----------------------------
-- Records of website_info
-- ----------------------------
INSERT INTO website_info (id, name, domain, keyword, description, qq, logo, logo_dark, create_time, create_user_id, update_time, update_user_id)
VALUES (1, '小说精品屋', 'www.xxyopen.com', '小说精品屋,小说,小说CMS,原创文学系统,开源小说系统,免费小说建站程序',
        '小说精品屋是一个多端（PC、WAP）阅读、功能完善的原创文学CMS系统，由前台门户系统、作家后台管理系统、平台后台管理系统、爬虫管理系统等多个子系统构成，支持会员充值、订阅模式、新闻发布和实时统计报表等功能，新书自动入库，老书自动更新。',
        '1179705413', 'https://youdoc.gitee.io/resource/images/logo/logo.png',
        'https://youdoc.gitee.io/resource/images/logo/logo_white.png', null, null, null, null);

-- ----------------------------
-- Records of friend_link
-- ----------------------------
INSERT INTO `friend_link`
VALUES ('1', '小说精品屋', 'https://novel.xxyopen.com', '11', '1', null, null, null, null);

-- ----------------------------
-- Records of news_category
-- ----------------------------
INSERT INTO `news_category`
VALUES ('1', '行业', '10', null, null, null, null);
INSERT INTO `news_category`
VALUES ('2', '资讯', '11', null, null, null, null);

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news`
VALUES ('1', '1', '行业', '未知', '阅文推“单本可选新合同”：授权分级、免费或付费自选',
        '阅文推“单本可选新合同”：授权分级、免费或付费自选', '2020-04-27 15:42:21', null,
        '2020-04-27 15:42:26', null);
INSERT INTO `news`
VALUES ('2', '2', '资讯', '全媒派公众号', 'AI小说悄然流行：人类特有的创作力，已经被AI复制？', 'AI小说悄然流行：人类特有的创作力，已经被AI复制？', '2020-04-28 15:44:07',
        null, '2020-04-28 15:44:12',
        null);

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict`
VALUES ('1', '正常', '0', 'del_flag', '删除标记', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('3', '显示', '1', 'show_hide', '显示/隐藏', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('4', '隐藏', '0', 'show_hide', '显示/隐藏', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('5', '是', '1', 'yes_no', '是/否', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('6', '否', '0', 'yes_no', '是/否', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('7', '红色', 'red', 'color', '颜色值', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('8', '绿色', 'green', 'color', '颜色值', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('9', '蓝色', 'blue', 'color', '颜色值', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('10', '黄色', 'yellow', 'color', '颜色值', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('11', '橙色', 'orange', 'color', '颜色值', '50', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('12', '默认主题', 'default', 'theme', '主题方案', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('13', '天蓝主题', 'cerulean', 'theme', '主题方案', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('14', '橙色主题', 'readable', 'theme', '主题方案', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('15', '红色主题', 'united', 'theme', '主题方案', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('16', 'Flat主题', 'flat', 'theme', '主题方案', '60', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('17', '国家', '1', 'sys_area_type', '区域类型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('18', '省份、直辖市', '2', 'sys_area_type', '区域类型', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('19', '地市', '3', 'sys_area_type', '区域类型', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('20', '区县', '4', 'sys_area_type', '区域类型', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('21', '公司', '1', 'sys_office_type', '机构类型', '60', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('22', '部门', '2', 'sys_office_type', '机构类型', '70', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('23', '小组', '3', 'sys_office_type', '机构类型', '80', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('24', '其它', '4', 'sys_office_type', '机构类型', '90', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('25', '综合部', '1', 'sys_office_common', '快捷通用部门', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('26', '开发部', '2', 'sys_office_common', '快捷通用部门', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('27', '人力部', '3', 'sys_office_common', '快捷通用部门', '50', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('28', '一级', '1', 'sys_office_grade', '机构等级', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('29', '二级', '2', 'sys_office_grade', '机构等级', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('30', '三级', '3', 'sys_office_grade', '机构等级', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('31', '四级', '4', 'sys_office_grade', '机构等级', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('32', '所有数据', '1', 'sys_data_scope', '数据范围', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('33', '所在公司及以下数据', '2', 'sys_data_scope', '数据范围', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('34', '所在公司数据', '3', 'sys_data_scope', '数据范围', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('35', '所在部门及以下数据', '4', 'sys_data_scope', '数据范围', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('36', '所在部门数据', '5', 'sys_data_scope', '数据范围', '50', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('37', '仅本人数据', '8', 'sys_data_scope', '数据范围', '90', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('38', '按明细设置', '9', 'sys_data_scope', '数据范围', '100', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('39', '系统管理', '1', 'sys_user_type', '用户类型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('40', '部门经理', '2', 'sys_user_type', '用户类型', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('41', '普通用户', '3', 'sys_user_type', '用户类型', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('42', '基础主题', 'basic', 'cms_theme', '站点主题', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('43', '蓝色主题', 'blue', 'cms_theme', '站点主题', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('44', '红色主题', 'red', 'cms_theme', '站点主题', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('45', '文章模型', 'article', 'cms_module', '栏目模型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('46', '图片模型', 'picture', 'cms_module', '栏目模型', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('47', '下载模型', 'download', 'cms_module', '栏目模型', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('48', '链接模型', 'link', 'cms_module', '栏目模型', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('49', '专题模型', 'special', 'cms_module', '栏目模型', '50', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('50', '默认展现方式', '0', 'cms_show_modes', '展现方式', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('51', '首栏目内容列表', '1', 'cms_show_modes', '展现方式', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('52', '栏目第一条内容', '2', 'cms_show_modes', '展现方式', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('53', '发布', '0', 'cms_del_flag', '内容状态', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('54', '删除', '1', 'cms_del_flag', '内容状态', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('55', '审核', '2', 'cms_del_flag', '内容状态', '15', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('56', '首页焦点图', '1', 'cms_posid', '推荐位', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('57', '栏目页文章推荐', '2', 'cms_posid', '推荐位', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('58', '咨询', '1', 'cms_guestbook', '留言板分类', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('59', '建议', '2', 'cms_guestbook', '留言板分类', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('60', '投诉', '3', 'cms_guestbook', '留言板分类', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('61', '其它', '4', 'cms_guestbook', '留言板分类', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('62', '公休', '1', 'oa_leave_type', '请假类型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('63', '病假', '2', 'oa_leave_type', '请假类型', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('64', '事假', '3', 'oa_leave_type', '请假类型', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('65', '调休', '4', 'oa_leave_type', '请假类型', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('66', '婚假', '5', 'oa_leave_type', '请假类型', '60', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('67', '接入日志', '1', 'sys_log_type', '日志类型', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('68', '异常日志', '2', 'sys_log_type', '日志类型', '40', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('69', '请假流程', 'leave', 'act_type', '流程类型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('70', '审批测试流程', 'test_audit', 'act_type', '流程类型', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('71', '分类1', '1', 'act_category', '流程分类', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('72', '分类2', '2', 'act_category', '流程分类', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('73', '增删改查', 'crud', 'gen_category', '代码生成分类', '10', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('74', '增删改查（包含从表）', 'crud_many', 'gen_category', '代码生成分类', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('75', '树结构', 'tree', 'gen_category', '代码生成分类', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('76', '=', '=', 'gen_query_type', '查询方式', '10', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('77', '!=', '!=', 'gen_query_type', '查询方式', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('78', '&gt;', '&gt;', 'gen_query_type', '查询方式', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('79', '&lt;', '&lt;', 'gen_query_type', '查询方式', '40', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('80', 'Between', 'between', 'gen_query_type', '查询方式', '50', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('81', 'Like', 'like', 'gen_query_type', '查询方式', '60', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('82', 'Left Like', 'left_like', 'gen_query_type', '查询方式', '70', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('83', 'Right Like', 'right_like', 'gen_query_type', '查询方式', '80', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('84', '文本框', 'input', 'gen_show_type', '字段生成方案', '10', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('85', '文本域', 'textarea', 'gen_show_type', '字段生成方案', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('86', '下拉框', 'select', 'gen_show_type', '字段生成方案', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('87', '复选框', 'checkbox', 'gen_show_type', '字段生成方案', '40', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('88', '单选框', 'radiobox', 'gen_show_type', '字段生成方案', '50', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('89', '日期选择', 'dateselect', 'gen_show_type', '字段生成方案', '60', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('90', '人员选择', 'userselect', 'gen_show_type', '字段生成方案', '70', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('91', '部门选择', 'officeselect', 'gen_show_type', '字段生成方案', '80', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('92', '区域选择', 'areaselect', 'gen_show_type', '字段生成方案', '90', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('93', 'String', 'String', 'gen_java_type', 'Java类型', '10', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('94', 'Long', 'Long', 'gen_java_type', 'Java类型', '20', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('95', '仅持久层', 'dao', 'gen_category', '代码生成分类', '40', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('96', '男', '1', 'sex', '性别', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('97', '女', '2', 'sex', '性别', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('98', 'Integer', 'Integer', 'gen_java_type', 'Java类型', '30', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('99', 'Double', 'Double', 'gen_java_type', 'Java类型', '40', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('100', 'Date', 'java.util.Date', 'gen_java_type', 'Java类型', '50', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('104', 'Custom', 'Custom', 'gen_java_type', 'Java类型', '90', '0', '1', null, '1', null, null, '1');
INSERT INTO `sys_dict`
VALUES ('105', '会议通告', '1', 'oa_notify_type', '通知通告类型', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('106', '奖惩通告', '2', 'oa_notify_type', '通知通告类型', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('107', '活动通告', '3', 'oa_notify_type', '通知通告类型', '30', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('108', '草稿', '0', 'oa_notify_status', '通知通告状态', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('109', '发布', '1', 'oa_notify_status', '通知通告状态', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('110', '未读', '0', 'oa_notify_read', '通知通告状态', '10', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('111', '已读', '1', 'oa_notify_read', '通知通告状态', '20', '0', '1', null, '1', null, null, '0');
INSERT INTO `sys_dict`
VALUES ('112', '草稿', '0', 'oa_notify_status', '通知通告状态', '10', '0', '1', null, '1', null, '', '0');
INSERT INTO `sys_dict`
VALUES ('113', '删除', '1', 'del_flag', '删除标记', null, null, null, null, null, null, '', '');
INSERT INTO `sys_dict`
VALUES ('121', '编码', 'code', 'hobby', '爱好', null, null, null, null, null, null, '', '');
INSERT INTO `sys_dict`
VALUES ('122', '绘画', 'painting', 'hobby', '爱好', null, null, null, null, null, null, '', '');
INSERT INTO `sys_dict`
VALUES ('123', 'Integer', 'Integer', 'java_type', 'Java数据类型', '1', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('124', 'Long', 'Long', 'java_type', 'Java数据类型', '2', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('125', 'Float', 'Float', 'java_type', 'Java数据类型', '3', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('126', 'Double', 'Double', 'java_type', 'Java数据类型', '4', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('127', 'BigDecimal', 'BigDecimal', 'java_type', 'Java数据类型', '5', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('128', 'Boolean', 'Boolean', 'java_type', 'Java数据类型', '6', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('129', 'String', 'String', 'java_type', 'Java数据类型', '7', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('130', 'Date', 'Date', 'java_type', 'Java数据类型', '8', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('131', '文本框', '1', 'page_type', '页面显示类型', '1', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('132', '下拉框', '2', 'page_type', '页面显示类型', '2', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('133', '数值', '3', 'page_type', '页面显示类型', '3', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('134', '日期', '4', 'page_type', '页面显示类型', '4', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('135', '文本域', '5', 'page_type', '页面显示类型', '5', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('136', '富文本', '6', 'page_type', '页面显示类型', '6', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('137', '上传图片【单文件】', '7', 'page_type', '页面显示类型', '7', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('138', '隐藏域', '11', 'page_type', '页面显示类型', '11', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('139', '不显示', '12', 'page_type', '页面显示类型', '12', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('140', '男频', '0', 'work_direction', '作品方向', '0', null, null, null, null, null, '', null);
INSERT INTO `sys_dict`
VALUES ('141', '女频', '1', 'work_direction', '作品方向', '1', null, null, null, null, null, '', null);
INSERT INTO `sys_dict` (name, value, type, description, sort, parent_id, create_by, create_date, update_by,update_date, remarks, del_flag)
VALUES ('轮播图', '0', 'book_rec_type', '小说推荐类型', 0, null, null, null, null, null, '', null);
INSERT INTO `sys_dict` (name, value, type, description, sort, parent_id, create_by, create_date, update_by,update_date, remarks, del_flag)
VALUES ('顶部小说栏', '1', 'book_rec_type', '小说推荐类型', 1, null, null, null, null, null, '', null);
INSERT INTO `sys_dict` (name, value, type, description, sort, parent_id, create_by, create_date, update_by,update_date, remarks, del_flag)
VALUES ('本周强推', '2', 'book_rec_type', '小说推荐类型', 2, null, null, null, null, null, '', null);
INSERT INTO `sys_dict` (name, value, type, description, sort, parent_id, create_by, create_date, update_by,update_date, remarks, del_flag)
VALUES ('热门推荐', '3', 'book_rec_type', '小说推荐类型', 3, null, null, null, null, null, '', null);
INSERT INTO `sys_dict` (name, value, type, description, sort, parent_id, create_by, create_date, update_by,update_date, remarks, del_flag)
VALUES ('精品推荐', '4', 'book_rec_type', '小说推荐类型', 4, null, null, null, null, null, '', null);

-- ----------------------------
-- Records of sys_gen_columns
-- ----------------------------
INSERT INTO `sys_gen_columns`
VALUES ('452', 'sys_user', 'username', 'varchar', 'String', '用户名', '2', '用户名', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('453', 'sys_user', 'name', 'varchar', 'String', '', '3', '真实姓名', '6', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('454', 'sys_user', 'password', 'varchar', 'String', '密码', '4', '密码', '3', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('455', 'sys_user', 'dept_id', 'bigint', 'Long', '', '5', '部门', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('456', 'sys_user', 'email', 'varchar', 'String', '邮箱', '6', '邮箱', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('457', 'sys_user', 'mobile', 'varchar', 'String', '手机号', '7', '手机号', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('458', 'sys_user', 'status', 'tinyint', 'Integer', '状态 0:禁用，1:正常', '8', '状态 0:禁用，1:正常', '2', '0', 'yes_no');
INSERT INTO `sys_gen_columns`
VALUES ('459', 'sys_user', 'user_id_create', 'bigint', 'Long', '创建用户id', '9', '创建用户id', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('460', 'sys_user', 'gmt_create', 'datetime', 'Date', '创建时间', '10', '创建时间', '4', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('461', 'sys_user', 'gmt_modified', 'datetime', 'Date', '修改时间', '11', '修改时间', '4', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('462', 'sys_user', 'sex', 'bigint', 'Long', '性别', '12', '性别', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('463', 'sys_user', 'birth', 'datetime', 'Date', '出身日期', '13', '出身日期', '4', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('464', 'sys_user', 'pic_id', 'bigint', 'Long', '', '14', '', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('465', 'sys_user', 'live_address', 'varchar', 'String', '现居住地', '50', '现居住地', '6', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('466', 'sys_user', 'hobby', 'varchar', 'String', '爱好', '16', '爱好', '7', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('467', 'sys_user', 'province', 'varchar', 'String', '省份', '17', '省份', '2', '0', 'theme');
INSERT INTO `sys_gen_columns`
VALUES ('468', 'sys_user', 'city', 'varchar', 'String', '所在城市', '18', '所在城市', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('469', 'sys_user', 'district', 'varchar', 'String', '所在地区', '19', '所在地区', '7', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('730', 'sys_role_data_perm', 'role_id', 'bigint', 'Long', '角色ID', '2', '角色ID', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('731', 'sys_role_data_perm', 'perm_id', 'bigint', 'Long', '权限ID', '3', '权限ID', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('732', 'sys_data_perm', 'name', 'varchar', 'String', '权限名称', '2', '权限名称', '1', '1', null);
INSERT INTO `sys_gen_columns`
VALUES ('733', 'sys_data_perm', 'table_name', 'varchar', 'String', '数据表名称', '3', '数据表名称', '1', '1', null);
INSERT INTO `sys_gen_columns`
VALUES ('734', 'sys_data_perm', 'module_name', 'varchar', 'String', '所属模块', '4', '所属模块', '1', '1', null);
INSERT INTO `sys_gen_columns`
VALUES ('735', 'sys_data_perm', 'crl_attr_name', 'varchar', 'String', '用户权限控制属性名', '5', '用户权限控制属性名', '1', '1', null);
INSERT INTO `sys_gen_columns`
VALUES ('736', 'sys_data_perm', 'crl_column_name', 'varchar', 'String', '数据表权限控制列名', '6', '数据表权限控制列名', '1', '1', null);
INSERT INTO `sys_gen_columns`
VALUES ('737', 'sys_data_perm', 'perm_code', 'varchar', 'String',
        '权限code，all_开头表示查看所有数据的权限，sup_开头表示查看下级数据的权限，own_开头表示查看本级数据的权限', '7', '权限code', '1', '1', null);
INSERT INTO `sys_gen_columns`
VALUES ('738', 'sys_data_perm', 'order_num', 'int', 'Integer', '排序', '8', '排序', '3', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('739', 'sys_data_perm', 'gmt_create', 'datetime', 'Date', '创建时间', '9', '创建时间', '12', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('740', 'sys_data_perm', 'gmt_modified', 'datetime', 'Date', '修改时间', '10', '修改时间', '12', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('771', 'fb_order', 'fb_merchant_code', 'varchar', 'String', '付呗商户号', '4', '付呗商户号', '1', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('772', 'fb_order', 'merchant_order_sn', 'varchar', 'String', '第三方商户的订单号', '5', '第三方商户的订单号', '1', '0',
        'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('773', 'fb_order', 'order_sn', 'varchar', 'String', '付呗订单号', '6', '付呗订单号', '2', '0', 'color');
INSERT INTO `sys_gen_columns`
VALUES ('774', 'fb_order', 'platform_order_no', 'varchar', 'String', '平台方订单号', '7', '平台方订单号', '2', '0',
        'oa_leave_type');
INSERT INTO `sys_gen_columns`
VALUES ('775', 'fb_order', 'trade_no', 'varchar', 'String', '商户单号', '8', '商户单号', '6', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('776', 'fb_order', 'order_state', 'tinyint', 'Integer', '订单状态，1：未支付，2：支付成功，3：支付失败，4：支付取消', '9',
        '订单状态，1：未支付，2：支付成功，3：支付失败，4：支付取消', '2', '0', 'yes_no');
INSERT INTO `sys_gen_columns`
VALUES ('777', 'fb_order', 'fn_coupon', 'decimal', 'Double', '蜂鸟优惠卷抵扣', '10', '蜂鸟优惠卷抵扣', '3', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('778', 'fb_order', 'red_packet', 'decimal', 'BigDecimal', '红包抵扣', '11', '红包抵扣', '3', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('779', 'fb_order', 'total_fee', 'decimal', 'BigDecimal', '实收金额(元)', '12', '实收金额(元)', '3', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('780', 'fb_order', 'order_price', 'decimal', 'BigDecimal', '订单金额', '13', '订单金额', '3', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('781', 'fb_order', 'fee', 'decimal', 'BigDecimal', '手续费(元)', '14', '手续费(元)', '3', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('782', 'fb_order', 'body', 'varchar', 'String', '对商品或交易的描述', '15', '对商品或交易的描述', '7', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('783', 'fb_order', 'attach', 'varchar', 'String', '附加数据', '16', '附加数据', '6', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('784', 'fb_order', 'store_id', 'bigint', 'Long', '付呗系统的门店id', '17', '付呗系统的门店id', '3', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('785', 'fb_order', 'cashier_id', 'bigint', 'Long', '付呗系统的收银员id', '18', '付呗系统的收银员id', '3', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('786', 'fb_order', 'device_no', 'varchar', 'String', '设备终端号', '19', '设备终端号', '1', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('787', 'fb_order', 'user_id', 'varchar', 'String', '微信顾客支付授权的“open_id”或者支付宝顾客的“buyer_user_id”', '20',
        '微信顾客支付授权的“open_id”或者支付宝顾客的“buyer_user_id”', '1', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('788', 'fb_order', 'user_logon_id', 'varchar', 'String', '支付宝顾客的账号', '21', '支付宝顾客的账号', '5', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('789', 'fb_order', 'pay_time', 'datetime', 'Date', '交易成功的时间', '22', '交易成功的时间', '4', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('790', 'fb_order', 'pay_channel', 'tinyint', 'Integer', '支付通道:1微信、2支付宝、3银联', '23', '支付通道:1微信、2支付宝、3银联', '2',
        '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('791', 'fb_order', 'no_cash_coupon_fee', 'decimal', 'BigDecimal', '免充值代金券金额(元)', '24', '免充值代金券金额(元)', '3', '0',
        'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('792', 'fb_order', 'cash_coupon_fee', 'decimal', 'BigDecimal', '预充值代金券金额(元)', '25', '预充值代金券金额(元)', '3', '0',
        'yes_no');
INSERT INTO `sys_gen_columns`
VALUES ('793', 'fb_order', 'cash_fee', 'decimal', 'BigDecimal', '顾客实际支付金额(元)', '26', '顾客实际支付金额(元)', '3', '0',
        'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('794', 'fb_order', 'sign', 'varchar', 'String', '签名', '27', '签名', '2', '0', 'theme');
INSERT INTO `sys_gen_columns`
VALUES ('795', 'fb_order', 'options', 'varchar', 'String', '其它选项', '28', '其它选项', '7', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('796', 'fb_order', 'create_time', 'datetime', 'Date', '创建时间', '29', '创建时间', '4', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('797', 'fb_order', 'push_time', 'datetime', 'Date', '推送时间', '30', '推送时间', '4', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('798', 'fb_order', 'push_ip', 'varchar', 'String', '推送IP', '31', '推送IP', '6', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('799', 'fb_order', 'mcht_id', 'bigint', 'BigDecimal', '商户id', '90', '商户id', '3', '0', 'theme');
INSERT INTO `sys_gen_columns`
VALUES ('800', 'fb_order', 'sn', 'char', 'String', 'QR编号', '100', 'QR编号', '1', '0', 'del_flag');
INSERT INTO `sys_gen_columns`
VALUES ('801', 'author', 'user_id', 'bigint', 'Long', '用户ID', '2', '用户ID', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('802', 'author', 'invite_code', 'varchar', 'String', '邀请码', '3', '邀请码', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('803', 'author', 'pen_name', 'varchar', 'String', '笔名', '4', '笔名', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('804', 'author', 'tel_phone', 'varchar', 'String', '手机号码', '5', '手机号码', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('805', 'author', 'chat_account', 'varchar', 'String', 'QQ或微信账号', '6', 'QQ或微信账号', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('806', 'author', 'email', 'varchar', 'String', '电子邮箱', '7', '电子邮箱', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('807', 'author', 'work_direction', 'tinyint', 'Integer', '作品方向，0：男频，1：女频', '8', '作品方向，0：男频，1：女频', '2', '0',
        'work_direction');
INSERT INTO `sys_gen_columns`
VALUES ('808', 'author', 'status', 'tinyint', 'Integer', '0：正常，1：封禁', '10', '0：正常，1：封禁', '1', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('809', 'author', 'create_time', 'datetime', 'Date', '创建时间', '9', '入驻时间', '4', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('810', 'author_code', 'invite_code', 'varchar', 'String', '邀请码', '2', '邀请码', '1', '1', null);
INSERT INTO `sys_gen_columns`
VALUES ('811', 'author_code', 'validity_time', 'datetime', 'Date', '有效时间', '3', '有效时间', '4', '1', null);
INSERT INTO `sys_gen_columns`
VALUES ('812', 'author_code', 'is_use', 'tinyint', 'Integer', '是否使用过，0：未使用，1:使用过', '4', '是否使用过，0：未使用，1:使用过', '1', '0',
        null);
INSERT INTO `sys_gen_columns`
VALUES ('813', 'author_code', 'create_time', 'datetime', 'Date', '创建时间', '5', '创建时间', '4', '0', null);
INSERT INTO `sys_gen_columns`
VALUES ('814', 'author_code', 'create_user_id', 'bigint', 'Long', '创建人ID', '6', '创建人ID', '1', '0', null);

-- ----------------------------
-- Records of sys_gen_table
-- ----------------------------
INSERT INTO `sys_gen_table`
VALUES ('1', '表名', '1', '1', '0', null, null, null, null, null, null, null, null, '1', '2019-10-24 18:21:24', '1',
        '2019-10-24 18:21:35', null);

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu`
VALUES ('1', '0', '基础管理', '', '', '0', 'fa fa-bars', '0', '2017-08-09 22:49:47', null);
INSERT INTO `sys_menu`
VALUES ('2', '3', '系统菜单', 'sys/menu/', 'sys:menu:menu', '1', 'fa fa-th-list', '2', '2017-08-09 22:55:15', null);
INSERT INTO `sys_menu`
VALUES ('3', '0', '系统管理', null, null, '0', 'fa fa-desktop', '1', '2017-08-09 23:06:55', '2017-08-14 14:13:43');
INSERT INTO `sys_menu`
VALUES ('6', '3', '用户管理', 'sys/user/', 'sys:user:user', '1', 'fa fa-user', '0', '2017-08-10 14:12:11', null);
INSERT INTO `sys_menu`
VALUES ('7', '3', '角色管理', 'sys/role', 'sys:role:role', '1', 'fa fa-paw', '1', '2017-08-10 14:13:19', null);
INSERT INTO `sys_menu`
VALUES ('12', '6', '新增', '', 'sys:user:add', '2', '', '0', '2017-08-14 10:51:35', null);
INSERT INTO `sys_menu`
VALUES ('13', '6', '编辑', '', 'sys:user:edit', '2', '', '0', '2017-08-14 10:52:06', null);
INSERT INTO `sys_menu`
VALUES ('14', '6', '删除', null, 'sys:user:remove', '2', null, '0', '2017-08-14 10:52:24', null);
INSERT INTO `sys_menu`
VALUES ('15', '7', '新增', '', 'sys:role:add', '2', '', '0', '2017-08-14 10:56:37', null);
INSERT INTO `sys_menu`
VALUES ('20', '2', '新增', '', 'sys:menu:add', '2', '', '0', '2017-08-14 10:59:32', null);
INSERT INTO `sys_menu`
VALUES ('21', '2', '编辑', '', 'sys:menu:edit', '2', '', '0', '2017-08-14 10:59:56', null);
INSERT INTO `sys_menu`
VALUES ('22', '2', '删除', '', 'sys:menu:remove', '2', '', '0', '2017-08-14 11:00:26', null);
INSERT INTO `sys_menu`
VALUES ('24', '6', '批量删除', '', 'sys:user:batchRemove', '2', '', '0', '2017-08-14 17:27:18', null);
INSERT INTO `sys_menu`
VALUES ('25', '6', '停用', null, 'sys:user:disable', '2', null, '0', '2017-08-14 17:27:43', null);
INSERT INTO `sys_menu`
VALUES ('26', '6', '重置密码', '', 'sys:user:resetPwd', '2', '', '0', '2017-08-14 17:28:34', null);
INSERT INTO `sys_menu`
VALUES ('27', '91', '系统日志', 'common/log', 'common:log', '1', 'fa fa-warning', '0', '2017-08-14 22:11:53', null);
INSERT INTO `sys_menu`
VALUES ('28', '27', '刷新', null, 'sys:log:list', '2', null, '0', '2017-08-14 22:30:22', null);
INSERT INTO `sys_menu`
VALUES ('29', '27', '删除', null, 'sys:log:remove', '2', null, '0', '2017-08-14 22:30:43', null);
INSERT INTO `sys_menu`
VALUES ('30', '27', '清空', null, 'sys:log:clear', '2', null, '0', '2017-08-14 22:31:02', null);
INSERT INTO `sys_menu`
VALUES ('48', '77', '代码生成', 'common/generator', 'common:generator', '1', 'fa fa-code', '3', null, null);
INSERT INTO `sys_menu`
VALUES ('55', '7', '编辑', '', 'sys:role:edit', '2', '', null, null, null);
INSERT INTO `sys_menu`
VALUES ('56', '7', '删除', '', 'sys:role:remove', '2', null, null, null, null);
INSERT INTO `sys_menu`
VALUES ('57', '91', '运行监控', '/druid/index.html', '', '1', 'fa fa-caret-square-o-right', '1', null, null);
INSERT INTO `sys_menu`
VALUES ('61', '2', '批量删除', '', 'sys:menu:batchRemove', '2', null, null, null, null);
INSERT INTO `sys_menu`
VALUES ('62', '7', '批量删除', '', 'sys:role:batchRemove', '2', null, null, null, null);
INSERT INTO `sys_menu`
VALUES ('71', '1', '文件管理', '/common/sysFile', 'common:sysFile:sysFile', '1', 'fa fa-folder-open', '2', null, null);
INSERT INTO `sys_menu`
VALUES ('73', '3', '部门管理', '/system/sysDept', 'system:sysDept:sysDept', '1', 'fa fa-users', '3', null, null);
INSERT INTO `sys_menu`
VALUES ('74', '73', '增加', '/system/sysDept/add', 'system:sysDept:add', '2', null, '1', null, null);
INSERT INTO `sys_menu`
VALUES ('75', '73', '刪除', 'system/sysDept/remove', 'system:sysDept:remove', '2', null, '2', null, null);
INSERT INTO `sys_menu`
VALUES ('76', '73', '编辑', '/system/sysDept/edit', 'system:sysDept:edit', '2', null, '3', null, null);
INSERT INTO `sys_menu`
VALUES ('77', '0', '研发工具', '', '', '0', 'fa fa-gear', '5', null, null);
INSERT INTO `sys_menu`
VALUES ('78', '1', '数据字典', '/common/dict', 'common:dict:dict', '1', 'fa fa-book', '1', null, null);
INSERT INTO `sys_menu`
VALUES ('79', '78', '增加', '/common/dict/add', 'common:dict:add', '2', null, '2', null, null);
INSERT INTO `sys_menu`
VALUES ('80', '78', '编辑', '/common/dict/edit', 'common:dict:edit', '2', null, '2', null, null);
INSERT INTO `sys_menu`
VALUES ('81', '78', '删除', '/common/dict/remove', 'common:dict:remove', '2', '', '3', null, null);
INSERT INTO `sys_menu`
VALUES ('83', '78', '批量删除', '/common/dict/batchRemove', 'common:dict:batchRemove', '2', '', '4', null, null);
INSERT INTO `sys_menu`
VALUES ('91', '0', '系统监控', '', '', '0', 'fa fa-video-camera', '4', null, null);
INSERT INTO `sys_menu`
VALUES ('92', '91', '在线用户', 'sys/online', '', '1', 'fa fa-user', null, null, null);
INSERT INTO `sys_menu`
VALUES ('104', '77', 'swagger', '/swagger-ui.html', '', '1', '', null, null, null);
INSERT INTO `sys_menu`
VALUES ('202', '0', '测试管理', '', '', '0', 'fa fa-s15', '12', null, null);
INSERT INTO `sys_menu`
VALUES ('203', '202', '订单管理', 'test/order', 'test:order:order', '1', '', '1', null, null);
INSERT INTO `sys_menu`
VALUES ('204', '203', '新增', '', 'test:order:add', '2', '', null, null, null);
INSERT INTO `sys_menu`
VALUES ('205', '203', '编辑', '', 'test:order:edit', '2', '', null, null, null);
INSERT INTO `sys_menu`
VALUES ('206', '203', '删除', '', 'test:order:remove', '2', '', null, null, null);
INSERT INTO `sys_menu`
VALUES ('207', '203', '批量删除', '', 'test:order:batchRemove', '2', '', null, null, null);
INSERT INTO `sys_menu`
VALUES ('208', '203', '详情', '', 'test:order:detail', '2', '', '0', null, null);
INSERT INTO `sys_menu`
VALUES ('209', '3', '数据权限', 'system/dataPerm', 'system:dataPerm:dataPerm', '1', 'fa', '6', null, null);
INSERT INTO `sys_menu`
VALUES ('210', '209', '查看', null, 'system:dataPerm:detail', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('211', '209', '新增', null, 'system:dataPerm:add', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('212', '209', '修改', null, 'system:dataPerm:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('213', '209', '删除', null, 'system:dataPerm:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('214', '209', '批量删除', null, 'system:dataPerm:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('221', '0', '作家管理', '', '', '0', 'fa fa-user-o', '10', null, null);
INSERT INTO `sys_menu`
VALUES ('222', '221', '作者列表', 'novel/author', 'novel:author:author', '1', 'fa', '6', null, null);
INSERT INTO `sys_menu`
VALUES ('223', '222', '查看', null, 'novel:author:detail', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('224', '222', '新增', null, 'novel:author:add', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('225', '222', '修改', null, 'novel:author:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('226', '222', '删除', null, 'novel:author:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('227', '222', '批量删除', null, 'novel:author:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('228', '221', '邀请码管理', 'novel/authorCode', 'novel:authorCode:authorCode', '1', 'fa', '3', null, null);
INSERT INTO `sys_menu`
VALUES ('229', '228', '查看', null, 'novel:authorCode:detail', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('230', '228', '新增', null, 'novel:authorCode:add', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('231', '228', '修改', null, 'novel:authorCode:edit', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('232', '228', '删除', null, 'novel:authorCode:remove', '2', null, '6', null, null);
INSERT INTO `sys_menu`
VALUES ('233', '228', '批量删除', null, 'novel:authorCode:batchRemove', '2', null, '6', null, null);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (246, 241, '批量删除', NULL, 'novel:news:batchRemove', 2, NULL, 6, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (245, 241, '删除', NULL, 'novel:news:remove', 2, NULL, 6, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (244, 241, '修改', NULL, 'novel:news:edit', 2, NULL, 6, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (243, 241, '新增', NULL, 'novel:news:add', 2, NULL, 6, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (242, 241, '查看', NULL, 'novel:news:detail', 2, NULL, 6, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (241, 234, '新闻列表', 'novel/news', 'novel:news:news', 1, 'fa', 8, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (240, 235, '批量删除', NULL, 'novel:category:batchRemove', 2, NULL, 6, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (239, 235, '删除', NULL, 'novel:category:remove', 2, NULL, 6, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (238, 235, '修改', NULL, 'novel:category:edit', 2, NULL, 6, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (237, 235, '新增', NULL, 'novel:category:add', 2, NULL, 6, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (236, 235, '查看', NULL, 'novel:category:detail', 2, NULL, 6, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (235, 234, '类别管理', 'novel/category', 'novel:category:category', 1, 'fa', 6, NULL, NULL);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`)
VALUES (234, 0, '新闻管理', '', '', 0, 'fa fa-newspaper-o', 8, NULL, NULL);
INSERT INTO `sys_menu` (menu_id, parent_id, name, url, perms, type, icon, order_num, gmt_create, gmt_modified)
VALUES (300, 0, '网站管理', '', '', 0, 'fa fa-television', 6, null, null);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (301, 300, '网站信息', 'novel/websiteInfo', 'novel:websiteInfo:websiteInfo', '1', 'fa', '6');
INSERT INTO `sys_menu` (menu_id, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (310, 300, '友情链接', 'novel/friendLink', 'novel:friendLink:friendLink', '1', 'fa', '16');
INSERT INTO `sys_menu` (menu_id, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (311, 310, '查看', null, 'novel:friendLink:detail', '2', null, '6');
INSERT INTO `sys_menu` (menu_id, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (312, 310, '新增', null, 'novel:friendLink:add', '2', null, '6');
INSERT INTO `sys_menu` (menu_id, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (313, 310, '修改', null, 'novel:friendLink:edit', '2', null, '6');
INSERT INTO `sys_menu` (menu_id, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (314, 310, '删除', null, 'novel:friendLink:remove', '2', null, '6');
INSERT INTO `sys_menu` (menu_id, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (315, 310, '批量删除', null, 'novel:friendLink:batchRemove', '2', null, '6');
INSERT INTO `sys_menu` (menu_id, parent_id, name, url, perms, type, icon, order_num, gmt_create, gmt_modified)
VALUES (400, 0, '会员管理', '', '', 0, 'fa fa-vcard', 9, null, null);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (401, 400, '会员列表', 'novel/user', 'novel:user:user', '1', 'fa', '6');
INSERT INTO `sys_menu` (menu_id, parent_id, name, url, perms, type, icon, order_num, gmt_create, gmt_modified)
VALUES (500, 0, '订单管理', '', '', 0, 'fa fa-money', 19, null, null);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (501, 500, '订单列表', 'novel/pay', 'novel:pay:pay', '1', 'fa', '6');
INSERT INTO `sys_menu` (menu_id, parent_id, name, url, perms, type, icon, order_num, gmt_create, gmt_modified)
VALUES (600, 0, '小说管理', '', '', 0, 'fa fa-book', 15, null, null);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (601, 600, '小说列表', 'novel/book', 'novel:book:book', '1', 'fa', '6');
INSERT INTO `sys_menu` (menu_id, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (602, 601, '删除', null, 'novel:book:remove', '2', null, '6');
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (603, 600, '评论管理', 'novel/bookComment', 'novel:bookComment:bookComment', '1', 'fa', '10');
INSERT INTO `sys_menu` (menu_id, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (604, 603, '删除', null, 'novel:bookComment:remove', '2', null, '6');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (320, '300', '小说推荐', 'novel/bookSetting', 'novel:bookSetting:bookSetting', '1', 'fa', '6');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (321, '320', '查看', null, 'novel:bookSetting:detail', '2', null, '6');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (322, '320', '新增', null, 'novel:bookSetting:add', '2', null, '6');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (323, '320', '修改', null, 'novel:bookSetting:edit', '2', null, '6');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (324, '320', '删除', null, 'novel:bookSetting:remove', '2', null, '6');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (325, '320', '批量删除', null, 'novel:bookSetting:batchRemove', '2', null, '6');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (410, '400', '会员反馈', 'novel/userFeedback', 'novel:userFeedback:userFeedback', '1', 'fa', '16');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`)
VALUES (305, '301', '修改', null, 'novel:websiteInfo:edit', '2', null, '6');

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role`
VALUES ('1', '超级用户角色', 'admin', '拥有最高权限', '2', '2017-08-12 00:43:52', '2017-08-12 19:14:59');

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu`
VALUES ('4764', '1', '227');
INSERT INTO `sys_role_menu`
VALUES ('4765', '1', '226');
INSERT INTO `sys_role_menu`
VALUES ('4766', '1', '225');
INSERT INTO `sys_role_menu`
VALUES ('4767', '1', '224');
INSERT INTO `sys_role_menu`
VALUES ('4768', '1', '223');
INSERT INTO `sys_role_menu`
VALUES ('4769', '1', '208');
INSERT INTO `sys_role_menu`
VALUES ('4770', '1', '207');
INSERT INTO `sys_role_menu`
VALUES ('4771', '1', '206');
INSERT INTO `sys_role_menu`
VALUES ('4772', '1', '205');
INSERT INTO `sys_role_menu`
VALUES ('4773', '1', '204');
INSERT INTO `sys_role_menu`
VALUES ('4774', '1', '92');
INSERT INTO `sys_role_menu`
VALUES ('4775', '1', '57');
INSERT INTO `sys_role_menu`
VALUES ('4776', '1', '30');
INSERT INTO `sys_role_menu`
VALUES ('4777', '1', '29');
INSERT INTO `sys_role_menu`
VALUES ('4778', '1', '28');
INSERT INTO `sys_role_menu`
VALUES ('4779', '1', '104');
INSERT INTO `sys_role_menu`
VALUES ('4780', '1', '48');
INSERT INTO `sys_role_menu`
VALUES ('4781', '1', '214');
INSERT INTO `sys_role_menu`
VALUES ('4782', '1', '213');
INSERT INTO `sys_role_menu`
VALUES ('4783', '1', '212');
INSERT INTO `sys_role_menu`
VALUES ('4784', '1', '211');
INSERT INTO `sys_role_menu`
VALUES ('4785', '1', '210');
INSERT INTO `sys_role_menu`
VALUES ('4786', '1', '76');
INSERT INTO `sys_role_menu`
VALUES ('4787', '1', '75');
INSERT INTO `sys_role_menu`
VALUES ('4788', '1', '74');
INSERT INTO `sys_role_menu`
VALUES ('4789', '1', '62');
INSERT INTO `sys_role_menu`
VALUES ('4790', '1', '56');
INSERT INTO `sys_role_menu`
VALUES ('4791', '1', '55');
INSERT INTO `sys_role_menu`
VALUES ('4792', '1', '15');
INSERT INTO `sys_role_menu`
VALUES ('4793', '1', '26');
INSERT INTO `sys_role_menu`
VALUES ('4794', '1', '25');
INSERT INTO `sys_role_menu`
VALUES ('4795', '1', '24');
INSERT INTO `sys_role_menu`
VALUES ('4796', '1', '14');
INSERT INTO `sys_role_menu`
VALUES ('4797', '1', '13');
INSERT INTO `sys_role_menu`
VALUES ('4798', '1', '12');
INSERT INTO `sys_role_menu`
VALUES ('4799', '1', '61');
INSERT INTO `sys_role_menu`
VALUES ('4800', '1', '22');
INSERT INTO `sys_role_menu`
VALUES ('4801', '1', '21');
INSERT INTO `sys_role_menu`
VALUES ('4802', '1', '20');
INSERT INTO `sys_role_menu`
VALUES ('4803', '1', '83');
INSERT INTO `sys_role_menu`
VALUES ('4804', '1', '81');
INSERT INTO `sys_role_menu`
VALUES ('4805', '1', '80');
INSERT INTO `sys_role_menu`
VALUES ('4806', '1', '79');
INSERT INTO `sys_role_menu`
VALUES ('4807', '1', '71');
INSERT INTO `sys_role_menu`
VALUES ('4808', '1', '222');
INSERT INTO `sys_role_menu`
VALUES ('4809', '1', '203');
INSERT INTO `sys_role_menu`
VALUES ('4810', '1', '202');
INSERT INTO `sys_role_menu`
VALUES ('4811', '1', '27');
INSERT INTO `sys_role_menu`
VALUES ('4812', '1', '91');
INSERT INTO `sys_role_menu`
VALUES ('4813', '1', '77');
INSERT INTO `sys_role_menu`
VALUES ('4814', '1', '209');
INSERT INTO `sys_role_menu`
VALUES ('4815', '1', '73');
INSERT INTO `sys_role_menu`
VALUES ('4816', '1', '7');
INSERT INTO `sys_role_menu`
VALUES ('4817', '1', '6');
INSERT INTO `sys_role_menu`
VALUES ('4818', '1', '2');
INSERT INTO `sys_role_menu`
VALUES ('4819', '1', '3');
INSERT INTO `sys_role_menu`
VALUES ('4820', '1', '78');
INSERT INTO `sys_role_menu`
VALUES ('4821', '1', '1');
INSERT INTO `sys_role_menu`
VALUES ('4822', '1', '228');
INSERT INTO `sys_role_menu`
VALUES ('4823', '1', '233');
INSERT INTO `sys_role_menu`
VALUES ('4824', '1', '232');
INSERT INTO `sys_role_menu`
VALUES ('4825', '1', '231');
INSERT INTO `sys_role_menu`
VALUES ('4826', '1', '230');
INSERT INTO `sys_role_menu`
VALUES ('4827', '1', '229');
INSERT INTO `sys_role_menu`
VALUES ('4828', '1', '221');
INSERT INTO `sys_role_menu`
VALUES ('4829', '1', '-1');
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4889, 1, 246);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4890, 1, 245);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4891, 1, 244);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4892, 1, 243);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4893, 1, 242);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4899, 1, 241);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4894, 1, 240);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4895, 1, 239);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4896, 1, 238);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4897, 1, 237);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4898, 1, 236);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4900, 1, 235);
INSERT INTO `sys_role_menu`(`id`, `role_id`, `menu_id`)
VALUES (4888, 1, 234);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 300);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 301);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 310);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 311);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 312);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 313);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 314);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 315);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 400);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 401);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 410);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 500);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 501);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 600);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 601);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 602);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 603);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 604);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 602);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 305);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 320);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 321);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 322);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 323);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 324);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 325);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 410);
INSERT INTO `sys_role_menu` (role_id, menu_id)
VALUES (1, 305);

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '0', '系统管理部', '10', '1');
INSERT INTO `sys_dept` VALUES ('2', '1', '测试部', '1', '1');

-- ----------------------------
-- Records of sys_data_perm
-- ----------------------------
INSERT INTO `sys_data_perm`
VALUES ('1', '查看用户表全部数据', 'sys_user', '用户管理', 'deptId', 'dept_id', 'all_dept_sys_user', '1', null, null);
INSERT INTO `sys_data_perm`
VALUES ('2', '查看用户表下级部门数据', 'sys_user', '用户管理', 'deptId', 'dept_id', 'sup_dept_sys_user', '2', null, null);
INSERT INTO `sys_data_perm`
VALUES ('3', '查看用户表本部门数据', 'sys_user', '用户管理', 'deptId', 'dept_id', 'own_dept_sys_user', '3', null, null);
INSERT INTO `sys_data_perm`
VALUES ('4', '查看用户表个人数据', 'sys_user', '用户管理', 'userId', 'user_id', 'own_user_sys_user', '4', null, null);
INSERT INTO `sys_data_perm`
VALUES ('5', '查看下级部门订单数据', 'fb_order', '订单管理', 'deptId', 'dept_id', 'sup_dept_fb_order', '2', null, null);
INSERT INTO `sys_data_perm`
VALUES ('6', '查看本部门订单数据', 'fb_order', '订单管理', 'deptId', 'dept_id', 'own_dept_fb_order', '3', null, null);

-- ----------------------------
-- Records of sys_role_data_perm
-- ----------------------------
INSERT INTO `sys_role_data_perm` VALUES ('1', '1', '1');
INSERT INTO `sys_role_data_perm` VALUES ('2', '1', '2');
INSERT INTO `sys_role_data_perm` VALUES ('3', '1', '3');
INSERT INTO `sys_role_data_perm` VALUES ('4', '1', '4');
INSERT INTO `sys_role_data_perm` VALUES ('5', '1', '5');
INSERT INTO `sys_role_data_perm` VALUES ('6', '1', '6');

-- ----------------------------
-- Records of sys_user
-- ----------------------------
-- admin / novel_admin
INSERT INTO `sys_user`
VALUES ('1', 'admin', '超级管理员', 'd656b543bd0f964cd32132fd472d6637', '1', 'admin@example.com', '17699999999', '1', '1',
        '2017-08-15 21:40:39', '2017-08-15 21:41:00', '96', '2017-12-14 00:00:00', '148', 'ccc', '122;121;', '北京市',
        '北京市市辖区', '东城区');

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role`
VALUES ('1', '1', '1');

-- ----------------------------
-- Records of crawl_source
-- ----------------------------
INSERT INTO `crawl_source`
VALUES ('2', '百书斋',
        '{\r\n	\"bookListUrl\": \"https://m.baishuzhai.com/blhb/{catId}/{page}.html\",\r\n	\"catIdRule\": {\r\n		\"catId1\": \"1\",\r\n		\"catId2\": \"2\",\r\n		\"catId3\": \"3\",\r\n		\"catId4\": \"4\",\r\n		\"catId5\": \"5\",\r\n		\"catId6\": \"6\",\r\n		\"catId7\": \"7\"\r\n	},\r\n	\"bookIdPatten\": \"href=\\\"/ibook/(\\\\d+/\\\\d+)/\\\"\",\r\n	\"pagePatten\": \"value=\\\"(\\\\d+)/\\\\d+\\\"\",\r\n	\"totalPagePatten\": \"value=\\\"\\\\d+/(\\\\d+)\\\"\",\r\n	\"bookDetailUrl\": \"https://m.baishuzhai.com/ibook/{bookId}/\",\r\n	\"bookNamePatten\": \"<span class=\\\"title\\\">([^/]+)</span>\",\r\n	\"authorNamePatten\": \">作者：([^/]+)<\",\r\n	\"picUrlPatten\": \"<img src=\\\"([^>]+)\\\"\\\\s+onerror=\\\"this.src=\",\r\n	\"statusPatten\": \"状态：([^/]+)</li>\",\r\n	\"bookStatusRule\": {\r\n		\"连载\": 0,\r\n		\"完成\": 1\r\n	},\r\n	\"scorePatten\": \"<em>([^<]+)</em>\",\r\n	\"descStart\": \"<p class=\\\"review\\\">\",\r\n	\"descEnd\": \"</p>\",\r\n	\"upadateTimePatten\": \"更新：(\\\\d+-\\\\d+-\\\\d+)</li>\",\r\n	\"upadateTimeFormatPatten\": \"yy-MM-dd\",\r\n	\"bookIndexUrl\": \"https://m.baishuzhai.com/ibook/{bookId}/all.html\",\r\n	\"indexIdPatten\": \"<a\\\\s+style=\\\"\\\"\\\\s+href=\\\"/ibook/\\\\d+/\\\\d+/(\\\\d+)\\\\.html\\\">[^/]+</a>\",\r\n	\"indexNamePatten\": \"<a\\\\s+style=\\\"\\\"\\\\s+href=\\\"/ibook/\\\\d+/\\\\d+/\\\\d+\\\\.html\\\">([^/]+)</a>\",\r\n	\"bookContentUrl\": \"https://baishuzhai.com/ibook/{bookId}/{indexId}.html\",\r\n	\"contentStart\": \"id=\\\"content\\\">\",\r\n	\"contentEnd\": \"<script>\"\r\n}',
        '0', '2020-05-01 14:22:50', '2020-05-01 14:22:50');
INSERT INTO `crawl_source`
VALUES ('3', '书包网',
        '{\r\n	\"bookListUrl\": \"https://www.bookbao8.com/booklist-p_{page}-c_{catId}-t_0-o_0.html\",\r\n	\"catIdRule\": {\r\n		\"catId1\": \"5\",\r\n		\"catId2\": \"4\",\r\n		\"catId3\": \"8\",\r\n		\"catId4\": \"9\",\r\n		\"catId5\": \"3\",\r\n		\"catId6\": \"7\"\r\n	},\r\n	\"bookIdPatten\": \"href=\\\"/book/(\\\\d+/\\\\d+/id_[^.]+).html\\\"\",\r\n	\"pagePatten\": \"<span\\\\s+class=\\\"current\\\">([^<]+)</span>\",\r\n	\"totalPagePatten\": \"/共(\\\\d+)页\",\r\n	\"bookDetailUrl\": \"https://www.bookbao8.com/book/{bookId}.html\",\r\n	\"bookNamePatten\": \"<div\\\\s+id=\\\"info\\\">\\\\s*<h1>([^<]+)</h1>\",\r\n	\"authorNamePatten\": \"<p>作者：<a\\\\s+href=\\\"/Search/[^\\\"]+\\\"\\\\s+target=\\\"_blank\\\">([^<]+)</a></p>\",\r\n	\"picUrlPatten\": \"<div\\\\s+id=\\\"fmimg\\\">\\\\s*<img\\\\s+alt=\\\"[^\\\"]+\\\"\\\\s+src=\\\"([^\\\"]+)\\\"\",\r\n	\"statusPatten\": \"<p>状态：([^<]+)</p>\",\r\n	\"bookStatusRule\": {\r\n		\"连载中\": 0,\r\n		\"已完结\": 1\r\n	},\r\n	\"visitCountPatten\": \"<em\\\\s+id=\\\"hits\\\">(\\\\d+)</em>\",\r\n	\"descStart\": \"<div class=\\\"infocontent\\\">\",\r\n	\"descEnd\": \"</div>\",\r\n	\"upadateTimePatten\": \"<p>更新时间：(\\\\d+-\\\\d+-\\\\d+\\\\s\\\\d+:\\\\d+:\\\\d+)</p>\",\r\n	\"upadateTimeFormatPatten\": \"yyyy-MM-dd HH:mm:ss\",\r\n	\"bookIndexUrl\": \"https://www.bookbao8.com/book/{bookId}.html\",\r\n	\"indexIdPatten\": \"<li>\\\\s*<a\\\\s+href=\\\"/views/\\\\d+/\\\\d+/id_[^_]+_(\\\\d+).html\\\"\\\\s+target=\\\"_blank\\\">\",\r\n	\"indexNamePatten\": \"<li>\\\\s*<a\\\\s+href=\\\"/views/\\\\d+/\\\\d+/id_[^_]+_\\\\d+.html\\\"\\\\s+target=\\\"_blank\\\">([^<]+)</a>\",\r\n	\"bookContentUrl\": \"https://www.bookbao8.com/views/{bookId}_{indexId}.html\",\r\n	\"contentStart\": \"<dd id=\\\"contents\\\">\",\r\n	\"contentEnd\": \"</dd>\"\r\n}',
        '0', '2020-05-04 17:42:22', '2020-05-04 17:42:22');
INSERT INTO `crawl_source`
VALUES ('4', '书趣阁',
        '{\r\n	\"bookListUrl\": \"http://m.shuquge.com/sort/{catId}/0_{page}.html\",\r\n	\"catIdRule\": {\r\n		\"catId1\": \"1\",\r\n		\"catId2\": \"2\",\r\n		\"catId3\": \"3\",\r\n		\"catId4\": \"4\",\r\n		\"catId5\": \"7\",\r\n		\"catId6\": \"6\",\r\n		\"catId7\": \"8\"\r\n	},\r\n	\"bookIdPatten\": \"href=\\\"/s/(\\\\d+)\\\\.html\\\"\",\r\n	\"pagePatten\": \"第(\\\\d+)/\\\\d+页\",\r\n	\"totalPagePatten\": \"第\\\\d+/(\\\\d+)页\",\r\n	\"bookDetailUrl\": \"http://m.shuquge.com/s/{bookId}.html\",\r\n	\"bookNamePatten\": \"<a\\\\s+href=\\\"/s/\\\\d+\\\\.html\\\"><h2>([^/]+)</h2></a>\",\r\n	\"authorNamePatten\": \"<p>作者：([^/]+)</p>\",\r\n	\"picUrlPatten\": \"src=\\\"(http://www.shuquge.com/files/article/image/\\\\d+/\\\\d+/\\\\d+s\\\\.jpg)\\\"\",\r\n	\"statusPatten\": \"<p>状态：([^/]+)</p>\",\r\n	\"bookStatusRule\": {\r\n		\"连载中\": 0,\r\n		\"完本\": 1\r\n	},\r\n	\"descStart\": \"<div class=\\\"intro_info\\\">\",\r\n	\"descEnd\": \"最新章节推荐地址\",\r\n	\"bookIndexUrl\": \"http://www.shuquge.com/txt/{bookId}/index.html\",\r\n	\"bookIndexStart\": \"》正文\",\r\n	\"indexIdPatten\": \"<dd><a\\\\s+href=\\\"(\\\\d+)\\\\.html\\\">[^/]+</a></dd>\",\r\n	\"indexNamePatten\": \"<dd><a\\\\s+href=\\\"\\\\d+\\\\.html\\\">([^/]+)</a></dd>\",\r\n	\"bookContentUrl\": \"http://www.shuquge.com/txt/{bookId}/{indexId}.html\",\r\n	\"contentStart\": \"<div id=\\\"content\\\" class=\\\"showtxt\\\">\",\r\n	\"contentEnd\": \"http://www.shuquge.com\"\r\n}',
        '1', '2020-05-18 12:02:34', '2020-05-18 12:02:34');
INSERT INTO `crawl_source` (`id`, `source_name`, `crawl_rule`, `source_status`, `create_time`, `update_time`)
VALUES ('5', '笔趣阁',
        '{\"bookListUrl\":\"http://m.mcmssc.com/xclass/{catId}/{page}.html\",\"catIdRule\":{\"catId1\":\"1\",\"catId2\":\"2\",\"catId3\":\"3\",\"catId4\":\"4\",\"catId5\":\"5\",\"catId6\":\"6\",\"catId7\":\"7\"},\"bookIdPatten\":\"href=\\\"/(\\\\d+_\\\\d+)/\\\"\",\"pagePatten\":\"class=\\\"page_txt\\\"\\\\s+value=\\\"(\\\\d+)/\\\\d+\\\"\\\\s+size=\",\"totalPagePatten\":\"class=\\\"page_txt\\\"\\\\s+value=\\\"\\\\d+/(\\\\d+)\\\"\\\\s+size=\",\"bookDetailUrl\":\"http://m.mcmssc.com/{bookId}/\",\"bookNamePatten\":\"<span\\\\s+class=\\\"title\\\">([^/]+)</span>\",\"authorNamePatten\":\"<a\\\\s+href=\\\"/author/\\\\d+/\\\">([^/]+)</a>\",\"picUrlPatten\":\"<img\\\\s+src=\\\"([^>]+)\\\"\\\\s+onerror=\",\"picUrlPrefix\":\"http://m.mcmssc.com/\",\"statusPatten\":\">状态：([^/]+)<\",\"bookStatusRule\":{\"连载\":0,\"全本\":1},\"visitCountPatten\":\">点击：(\\\\d+)<\",\"descStart\":\"<p class=\\\"review\\\">\",\"descEnd\":\"</p>\",\"bookIndexUrl\":\"http://m.mcmssc.com/{bookId}/all.html\",\"indexIdPatten\":\"<a\\\\s+href=\\\"/\\\\d+_\\\\d+/(\\\\d+)\\\\.html\\\">[^/]+</a>\",\"indexNamePatten\":\"<a\\\\s+href=\\\"/\\\\d+_\\\\d+/\\\\d+\\\\.html\\\">([^/]+)</a>\",\"bookContentUrl\":\"http://www.mcmssc.com/{bookId}/{indexId}.html\",\"contentStart\":\"</p>\",\"contentEnd\":\"<div align=\\\"center\\\">\"}',
        '1', '2020-05-18 15:57:41', '2020-05-18 15:57:41');
INSERT INTO crawl_source(`id`, `source_name`, `crawl_rule`, `source_status`, `create_time`, `update_time`)
VALUES (16, 'i笔趣阁',
        '{\"bookListUrl\":\"http://m.ibiquge.net/xclass/{catId}/{page}.html\",\"catIdRule\":{\"catId1\":\"1\",\"catId2\":\"2\",\"catId3\":\"3\",\"catId4\":\"4\",\"catId5\":\"6\",\"catId6\":\"5\",\"catId7\":\"7\"},\"bookIdPatten\":\"href=\\\"/(\\\\d+_\\\\d+)/\\\"\",\"pagePatten\":\"value=\\\"(\\\\d+)/\\\\d+\\\"\",\"totalPagePatten\":\"value=\\\"\\\\d+/(\\\\d+)\\\"\",\"bookDetailUrl\":\"http://m.ibiquge.net/{bookId}/\",\"bookNamePatten\":\"<span class=\\\"title\\\">([^/]+)</span>\",\"authorNamePatten\":\"<a href=\\\"/author/\\\\d+/\\\">([^/]+)</a>\",\"picUrlPatten\":\"<img src=\\\"([^>]+)\\\"\\\\s+onerror=\\\"this.src=\",\"picUrlPrefix\":\"http://m.ibiquge.net\",\"statusPatten\":\">状态：([^/]+)</li>\",\"bookStatusRule\":{\"连载\":0,\"完结\":1},\"visitCountPatten\":\">点击：(\\\\d+)</li>\",\"descStart\":\"<p class=\\\"review\\\">\",\"descEnd\":\"</p>\",\"bookIndexUrl\":\"http://www.ibiquge.net/{bookId}/\",\"bookIndexStart\":\"正文</dt>\",\"indexIdPatten\":\"<a\\\\s+style=\\\"\\\"\\\\s+href=\\\"/\\\\d+_\\\\d+/(\\\\d+)\\\\.html\\\">[^/]+</a>\",\"indexNamePatten\":\"<a\\\\s+style=\\\"\\\"\\\\s+href=\\\"/\\\\d+_\\\\d+/\\\\d+\\\\.html\\\">([^/]+)</a>\",\"bookContentUrl\":\"http://www.ibiquge.net/{bookId}/{indexId}.html\",\"contentStart\":\"</p>\",\"contentEnd\":\"<div align=\\\"center\\\">\"}',
        0, '2021-02-04 21:31:23', '2021-02-04 21:31:23');
INSERT INTO crawl_source (source_name, crawl_rule, source_status, create_time, update_time)
VALUES ('香书小说网', '{
  "bookListUrl": "http://www.xbiqugu.net/fenlei/{catId}_{page}.html",
  "catIdRule": {
    "catId1": "1",
    "catId2": "2",
    "catId3": "3",
    "catId4": "4",
    "catId5": "6",
    "catId6": "5"
  },
  "bookIdPatten": "<a\\\\s+href=\\"http://www.xbiqugu.net/(\\\\d+/\\\\d+)/\\"\\\\s+target=\\"_blank\\">",
  "pagePatten": "<em\\\\s+id=\\"pagestats\\">(\\\\d+)/\\\\d+</em>",
  "totalPagePatten": "<em\\\\s+id=\\"pagestats\\">\\\\d+/(\\\\d+)</em>",
  "bookDetailUrl": "http://www.xbiqugu.net/{bookId}/",
  "bookNamePatten": "<h1>([^/]+)</h1>",
  "authorNamePatten": "者：([^/]+)</p>",
  "picUrlPatten": "src=\\"(http://www.xbiqugu.net/files/article/image/\\\\d+/\\\\d+/\\\\d+s\\\\.jpg)\\"",
  "bookStatusRule": {},
  "descStart": "<div id=\\"intro\\">",
  "descEnd": "</div>",
  "upadateTimePatten": "<p>最后更新：(\\\\d+-\\\\d+-\\\\d+\\\\s\\\\d+:\\\\d+:\\\\d+)</p>",
  "upadateTimeFormatPatten": "yyyy-MM-dd HH:mm:ss",
  "bookIndexUrl": "http://www.xbiqugu.net/{bookId}/",
  "indexIdPatten": "<a\\\\s+href=''/\\\\d+/\\\\d+/(\\\\d+)\\\\.html''\\\\s+>[^/]+</a>",
  "indexNamePatten": "<a\\\\s+href=''/\\\\d+/\\\\d+/\\\\d+\\\\.html''\\\\s+>([^/]+)</a>",
  "bookContentUrl": "http://www.xbiqugu.net/{bookId}/{indexId}.html",
  "contentStart": "<div id=\\"content\\">",
  "contentEnd": "<p>",
  "filterContent":"<div\\\\s+id=\\"content_tip\\">\\\\s*<b>([^/]+)</b>\\\\s*</div>"
}', 0, '2024-06-01 10:11:39', '2024-06-01 10:11:39');
