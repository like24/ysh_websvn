

 --------------------------- 随心所欲数据结构定义  ------------------------------

 -- 注意：开发人员修改了其中的字段，请记得更新修改历史
 -- 修改历史:
 --            01. 2015-02-11   harry   创建   
 --  ----------------------------------------------------------------------

-- 角色信息表  --
DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role` (
	  `id` int(11)     NOT NULL     AUTO_INCREMENT COMMENT '角色id',
	  `role_name`      varchar(50)  DEFAULT NULL COMMENT '角色名称',
	  `role_chomd`     varchar(100) DEFAULT NULL COMMENT '角色权限',
	  `create_time`    datetime     DEFAULT NULL COMMENT '创建时间',
	  `create_user`    varchar(50)  DEFAULT NULL COMMENT '维护人',
	  `venueid`	       int(4)       DEFAULT '0'  COMMENT '0：随心瑜',
	  `flag`           int(4)       DEFAULT '0'  COMMENT '0:随心瑜 1：系统默认2：场馆自定义',
	  `delete_flag`    int(11)      DEFAULT '0'  COMMENT '删除状态0正常1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=gbk COMMENT='角色信息';



-- 权限信息表   --
DROP TABLE IF EXISTS `system_column`;
CREATE TABLE `system_column` (
	  `id` 			 int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
	  `chomd_name`   varchar(50)  DEFAULT NULL   COMMENT '权限名称',
	  `menu_name`    varchar(100) DEFAULT NULL   COMMENT '菜单名称',
	  `create_time`  datetime     DEFAULT NULL   COMMENT '创建时间',
	  `create_user`  varchar(50)  DEFAULT NULL   COMMENT '维护人',
	  `flag`         int(4)       DEFAULT '1'    COMMENT '主菜单排序',
	  `delete_flag`  int(11)      DEFAULT '0'    COMMENT '删除状态0正常1删除',
	  `url`          varchar(100) DEFAULT 'Null' COMMENT '链接地址',
	  `maxmenu`      varchar(20)  DEFAULT 'Null' COMMENT '主菜单的属性',
	  `minmenu`      varchar(20)  DEFAULT NULL   COMMENT '菜单选中属性',
	  `imageclass`   varchar(20)  DEFAULT 'Null' COMMENT '菜单icon',
	  `sort`         int(4)       DEFAULT '1'    COMMENT '二级菜单排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='权限信息';




-- 系统用户信息表  --
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user` (
	  `id` int(11)  NOT NULL     AUTO_INCREMENT  COMMENT '用户id',
	  `username`    varchar(20)  DEFAULT ''    COMMENT '登录帐号',
	  `password`    varchar(32)  DEFAULT ''    COMMENT '密码',
	  `name`        varchar(20)  DEFAULT ''    COMMENT '真实姓名',
	  `email`       varchar(30)  DEFAULT ''    COMMENT '邮箱',
	  `phone`       varchar(20)  DEFAULT ''    COMMENT '手机号',
	  `telphone`    varchar(20)  DEFAULT ''    COMMENT '座机号码',
	  `work`        int(1)       DEFAULT '0'   COMMENT '是否离职：0在职，1离职',
	  `sex`         int(1)       DEFAULT '0'   COMMENT '性别：0：女，1：男',
	  `status`      int(3)       DEFAULT '1'   COMMENT '状态(0：使用 1：注销)',
	  `venue_id`    int(11)      DEFAULT '0'   COMMENT '场馆id',
	  `subtime`     datetime     DEFAULT NULL  COMMENT '注册时间',
	  `update_time` datetime     DEFAULT NULL  COMMENT '修改时间',
	  `login_time`  datetime     DEFAULT NULL  COMMENT '登录最后时间',
	  `cardinfo`    varchar(50)  DEFAULT ''    COMMENT '身份证',
	  `role_id`     int(11)      DEFAULT '0'   COMMENT '角色id(职位id)',
	  `create_user` varchar(20)  DEFAULT ''    COMMENT '维护人',
	  `remark`      varchar(512) DEFAULT ''    COMMENT '备注',
	  `delete_flag` int(11)      DEFAULT '0'   COMMENT '删除状态 0:正常1:删除',
	  `birthday`    date         DEFAULT NULL  COMMENT '生日',
	  `address`     varchar(100) DEFAULT ''    COMMENT '详细地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='系统用户信息';


-- 系统发送的短信列表   --
DROP TABLE IF EXISTS `system_msg_code`;
CREATE TABLE `system_msg_code` (
  `id`           bigint(20)   unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `mobile`       varchar(11)  DEFAULT ''   COMMENT '手机号',
  `type`         int(1)       DEFAULT '0'  COMMENT '验证码类型 0:注册 1:重置密码',
  `code`         varchar(255) DEFAULT ''   COMMENT '验证码',
  `createtime`   datetime     DEFAULT NULL COMMENT '创建时间',
  `status`       int(3)       DEFAULT '0'  COMMENT '0 正常 1 已使用',
  `content`      varchar(512) DEFAULT ''   COMMENT '短信内容',
  `mtype`        int(1)       DEFAULT '0'  COMMENT '客户端类型 1:Android 2:Ios 3:Desktop 4:Web 5:Win phone 6:Symbian',
  PRIMARY KEY (`id`),
  KEY `index_mobile` (`mobile`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='短信验证码';



-- 注册微信用户  --
DROP TABLE IF EXISTS `weixin_blog_user`;
CREATE TABLE `weixin_blog_user` (
  `id`               bigint(20)     unsigned  NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `nickname`         varchar(32)    CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''   COMMENT '昵称',
  `password`         varchar(32)    DEFAULT ''   COMMENT '密码，MD5，32位',
  `sex`              int(1)         DEFAULT '0'  COMMENT '1男 2女',
  `note`             varchar(64)    DEFAULT ''   COMMENT '签名',
  `mobile`           varchar(256)   DEFAULT ''   COMMENT '电话',
  `level`            int(2)         DEFAULT '0'  COMMENT '用户等级',
  `last_longitude`   decimal(15,12) DEFAULT '0.00' COMMENT '上次访问位置的经度',
  `last_lantitude`   decimal(15,12) DEFAULT '0.00' COMMENT '上次访问位置的纬度',
  `last_access_time`  datetime      DEFAULT NULL COMMENT '上次访问时间',
  `limit_access_time` datetime      DEFAULT NULL COMMENT '限制时间',
  `file_path`        varchar(256)   DEFAULT ''   COMMENT '头像路径',
  `point`            int(11)        DEFAULT '0'  COMMENT '积分',
  `up_count`         int(11)        DEFAULT '0'  COMMENT '被赞次数',
  `fensi_count`      int(11)        DEFAULT '0'  COMMENT '粉丝数', 
  `course_count`     int(11)        DEFAULT '0'  COMMENT '课程数', 
  `ask_count`        int(11)        DEFAULT '0'  COMMENT '回答问题的数量',
  `guanzhu_count`    int(11)        DEFAULT '0'  COMMENT '关注数',
  `recommend`        int(1)         DEFAULT '0'  COMMENT '是否推荐',
  `status`           int(1)         DEFAULT '0'  COMMENT '0正常，1封停,99删除',
  `vid`              bigint(10)     DEFAULT '0'  COMMENT '场馆ID',
  `birthday`         datetime       DEFAULT NULL COMMENT '生日',
  `createtime`       datetime       DEFAULT NULL COMMENT '创建时间',
  `registrationid`   varchar(40)    DEFAULT ''   COMMENT 'JPush RegistrationID',
  `wxid`             varchar(28)    DEFAULT ''   COMMENT '微信用户openid',
  `area`             varchar(128)   DEFAULT ''   COMMENT '所在地区',
  `signature`        varchar(256)   CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''   COMMENT '个性签名',
  `remark`           TEXT           CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '老师介绍',
  `shortremark`      varchar(512)   CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''   COMMENT '老师简介',
  `isauth`           int(1)         DEFAULT  '0'  COMMENT '是否认证 0：未认证 1：已认证',
  `isteacher`        int(1)         DEFAULT  '0'  COMMENT '是否是老师 0：不是 1：是',
  `cancelfollow`     int(1)         DEFAULT  '0'  COMMENT '是否是取消了关注 0：不是 1：是',
  `canceltime`       datetime       DEFAULT  NULL COMMENT '取消关注的时间',
  `seqindex`         int(11)        DEFAULT  '0'  COMMENT '老师的显示序号',
  `auth_time`        datetime       DEFAULT  NULL COMMENT '认证时间',
  `isteaching`       int(1)         DEFAULT  '0'  COMMENT '是否在授课中 0:否 1：是',
  `unionid`          varchar(512)   DEFAULT  ''   COMMENT '微信平台UNIONID',
  `isfirst`          int(1)         DEFAULT  '0'  COMMENT '是否首次登录 0:否 1：是',
  `fcbl`             varchar(16)    DEFAULT  '0'  COMMENT '分成比例 3/7,4/6',
  `line_fcbl`        varchar(16)    DEFAULT  '0'  COMMENT '线下课程分成比例 3/7,4/6',
  `taglist`          varchar(512)   DEFAULT  ''   COMMENT '标签列表,多个之间，号分割',
  `userpost`         varchar(512)   DEFAULT  ''   COMMENT '个人职务',
  `askmoney`         varchar(16)    DEFAULT  '0'  COMMENT '朝我提问的价格设置',
  `taglist`          varchar(512)   DEFAULT  '0'  COMMENT '标签',
  `isacceptask`      int(1)         DEFAULT  '0'  COMMENT '接受的业务类型，0全部 1只接受提问  2只售卖课程',
  `applysubask`      int(1)         DEFAULT  '0'  COMMENT '是否接受追问，0不接受 1接受',
  `hide`      		 int(1)         DEFAULT  '0'  COMMENT '显隐状态，0显示 1隐藏',
  `istop`      		 int(1)         DEFAULT  '0'  COMMENT '是否置顶首页 0：否，1：是',
  `toptime`      	 datetime       DEFAULT  NULL COMMENT '置顶时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `wxid` (`wxid`),
  UNIQUE KEY `unionid` (`unionid`),
  KEY `index_wxid` (`wxid`),
  KEY `index_unionid` (`unionid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='注册微信用户';

 
	


-- 微社区板块分类  -- 
DROP TABLE IF EXISTS `weixin_blog_content_class`;
CREATE TABLE `weixin_blog_content_class` (
	  `id`                  int(11) NOT NULL AUTO_INCREMENT  COMMENT 'id自增',
	  `cname`               varchar(256) DEFAULT ''          COMMENT '板块名称',
	  `sort`         		int(10)      DEFAULT '1'         COMMENT '板块序号', 
	  `status`              int(10)      DEFAULT '0'         COMMENT '板块状态 0：待审 1：正常 2：下线',
	  `icon`                varchar(128) DEFAULT ''          COMMENT '板块logo，预留',
	  `createtime`       	datetime     DEFAULT NULL        COMMENT '创建时间',
	  `uid`                 int(10)      DEFAULT '0'         COMMENT '创建人ID',
	  `mid`                 int(10)      DEFAULT '0'         COMMENT '修改人ID',
	  `count`               int(10)      DEFAULT '0'         COMMENT '下属内容数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='微社区板块分类 ';
 

 
-- 微社区内容列表  -- 
DROP TABLE IF EXISTS `weixin_blog_content`;
CREATE TABLE `weixin_blog_content` (
	  `id`                  int(11)      AUTO_INCREMENT      COMMENT 'id自增',
	  `title`               varchar(256) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''          COMMENT '标题',
	  `icon`                varchar(256) DEFAULT ''          COMMENT '帖子缩略图',
	  `status`         		int(10)      DEFAULT '1'         COMMENT '帖子状态 0：待审 1：通过 2：下线',
	  `type`         		int(1)       DEFAULT '0'         COMMENT '帖子类型 0：文本 1：图片 2：视频',
	  `dflag`         		int(1)       DEFAULT '0'         COMMENT '删除标志 0：正常 1：删除',
	  `cid`          		int(11)      DEFAULT '0'         COMMENT '分类ID',
	  `circleid`          	int(11)      DEFAULT '0'         COMMENT '圈子ID',
	  `wid`         		int(10)      DEFAULT '0'         COMMENT '发帖人ID',
	  `uid`         		int(11)      DEFAULT '0'         COMMENT '操作人ID',
	  `content`             LONGTEXT     CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL        COMMENT '帖子内容', 
	  `synopsis`            TEXT         CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL        COMMENT '帖子简介',
	  `up_count`            int(11)      DEFAULT '0'         COMMENT '被赞次数',
	  `play_count`          int(11)      DEFAULT '0'         COMMENT '播放次数',
      `favorite_count`      int(11)      DEFAULT '0'         COMMENT '被收藏次数',
      `commentcount`        int(11)      DEFAULT '0'         COMMENT '评论次数',
      `read_count`          int(11)      DEFAULT '0'         COMMENT '阅读量',
	  `createtime`       	datetime     DEFAULT NULL        COMMENT '创建时间', 
	  `modifytime`       	datetime     DEFAULT NULL        COMMENT '修改时间', 
	  `recommend`           int(1)       DEFAULT '0'         COMMENT '是否置为推荐 0：否 1：是',
	  `videopath`           varchar(256) DEFAULT ''          COMMENT '视频地址',
	  `address`             varchar(512) DEFAULT ''          COMMENT '发布位置',
	  `musicpath`           varchar(256) DEFAULT ''          COMMENT '音频地址',
	  `image1`              varchar(256) DEFAULT ''          COMMENT '图片Image1',
	  `image2`              varchar(256) DEFAULT ''          COMMENT '图片Image2',
	  `image3`              varchar(256) DEFAULT ''          COMMENT '图片Image3',
	  `image4`              varchar(256) DEFAULT ''          COMMENT '图片Image4',
	  `image5`              varchar(256) DEFAULT ''          COMMENT '图片Image5',
	  `image6`              varchar(256) DEFAULT ''          COMMENT '图片Image6',
	  `image7`              varchar(256) DEFAULT ''          COMMENT '图片Image7',
	  `image8`              varchar(256) DEFAULT ''          COMMENT '图片Image8',
	  `image9`              varchar(256) DEFAULT ''          COMMENT '图片Image9',
	  `serverid`            varchar(512) DEFAULT ''          COMMENT '微信serverId',
	  `cdnname`             varchar(256) DEFAULT ''          COMMENT 'CDNName',
	  `askid`         		int(11)      DEFAULT '0'         COMMENT '被提问人的ID',
	  `hasanswer`           int(1)       DEFAULT '0'         COMMENT '是否已经答复 0：未答复 1：已答复 2:已过期',
	  `isopen`              int(1)       DEFAULT '0'         COMMENT '是否公开0：公开 1：不公开',
	  `taglist`             varchar(512) DEFAULT ''          COMMENT '标签列表,多个之间，号分割',
	  `asktlong`         	varchar(512) DEFAULT ''          COMMENT '回答的录音时长',
	  `mp3path`         	varchar(512) DEFAULT ''          COMMENT '回答录音的存储地址',
	  `askmoney`            varchar(16)  DEFAULT '0.0'       COMMENT '本条提问的价格',
	  `loggerid`     		int(11)      DEFAULT '0'         COMMENT '操作日志ID',
	  `orderid`     		int(11)      DEFAULT '0'         COMMENT '对应订单ID',
	  `isrefund`            int(1)       DEFAULT '0'         COMMENT '是否已经退款0：未退款 1：已退款',
	  `ordernumber`         varchar(256) DEFAULT ''          COMMENT '订单编号',
	  `subcontent`          varchar(200) DEFAULT ''          COMMENT '追问问题',
	  `submp3path`          varchar(128) DEFAULT ''          COMMENT '追问答案MP3路径',
	  `subasktlong`         varchar(6)   DEFAULT '00:00'     COMMENT '追问回答时长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='微社区内容详情 ';



-- 内容评论列表  -- 
DROP TABLE IF EXISTS `weixin_blog_content_comment`;
CREATE TABLE `weixin_blog_content_comment` (
	  `id`                  int(11)        AUTO_INCREMENT      COMMENT 'id自增',
	  `content`             varchar(1024)  CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''          COMMENT '评论内容',
	  `cid`          		int(10)        DEFAULT '0'         COMMENT '评论内容ID',
	  `wid`          		int(10)        DEFAULT '0'         COMMENT '评论人ID',
	  `createtime`       	datetime       DEFAULT NULL        COMMENT '评论时间',
	  `status`              int(1)         DEFAULT '0'         COMMENT '0正常，1封停',
	  `ctype`               int(1)         DEFAULT '0'         COMMENT '评论类型 0社区，1课程',
	  `mp3path`         	varchar(512)   DEFAULT ''          COMMENT '回答录音的存储地址',
	  `asktlong`         	varchar(512)   DEFAULT ''          COMMENT '回答的录音时长',
	  `askmoney`            varchar(16)    DEFAULT '0.0'        COMMENT '本条提问的价格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='评论内容 ';



-- 用户收藏列表  -- 
DROP TABLE IF EXISTS `weixin_blog_content_collection`;
CREATE TABLE `weixin_blog_content_collection` (
	  `id`                  int(11)        AUTO_INCREMENT      COMMENT 'id自增',
	  `wid`                 int(11)        DEFAULT '0'         COMMENT '收藏人ID',
	  `cid`          		int(10)        DEFAULT '0'         COMMENT '收藏的内容ID',
	  `type`          		int(10)        DEFAULT '0'         COMMENT '类型： 1：问题  2：课程',
	  `createtime`       	datetime       DEFAULT NULL        COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `wid_cid` (`wid`,`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户收藏列表 ';


-- 微社区圈子板块  -- 
DROP TABLE IF EXISTS `weixin_blog_circle`;
CREATE TABLE `weixin_blog_circle` (
	  `id`                  int(11) NOT NULL AUTO_INCREMENT  COMMENT 'id自增',
	  `cname`               varchar(256) DEFAULT ''          COMMENT '圈子名称', 
	  `dflag`         		int(1)       DEFAULT '0'         COMMENT '删除标志 0：正常 1：删除',
	  `icon`                varchar(128) DEFAULT ''          COMMENT '板块logo，预留',
      `fcount`              int(11)      DEFAULT '0'         COMMENT '阅读次数',
	  `createtime`       	datetime     DEFAULT NULL        COMMENT '创建时间',
	  `uid`                 int(10)      DEFAULT '0'         COMMENT '创建人ID',
	  `mid`                 int(10)      DEFAULT '0'         COMMENT '修改人ID',
	  `count`               int(10)      DEFAULT '0'         COMMENT '下属内容数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='微社区圈子板块';
 

-- 微社区Banner-- 
DROP TABLE IF EXISTS `weixin_blog_banner`;
CREATE TABLE `weixin_blog_banner` (
	  `id`                  int(11) NOT NULL AUTO_INCREMENT  COMMENT 'id自增',
	  `cname`               varchar(256) DEFAULT ''          COMMENT '名称', 
	  `dflag`         		int(1)       DEFAULT '0'         COMMENT '删除标志 0：正常 1：删除',
	  `post`         		int(1)       DEFAULT '0'         COMMENT 'Banner位置1：名师 2：社区',
	  `sort`         		int(10)      DEFAULT '0'         COMMENT 'banner排序，越大越靠前',
	  `icon`                varchar(128) DEFAULT ''          COMMENT 'logo，预留',
	  `createtime`       	datetime     DEFAULT NULL        COMMENT '创建时间',
	  `url`                 varchar(512) DEFAULT ''          COMMENT 'URL', 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='微社区轮播图';



-- 用户发送的上行信息-- 
DROP TABLE IF EXISTS `weixin_blog_user_msg`;
CREATE TABLE `weixin_blog_user_msg` (
	  `id`                  int(11) NOT NULL AUTO_INCREMENT   COMMENT 'id自增',
	  `content`             TEXT          CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL        COMMENT '内容', 
	  `msgtype`             varchar(128)  DEFAULT ''          COMMENT '内容形式：text,shortvideo,location',
	  `picurl`              varchar(512)  DEFAULT ''          COMMENT 'PicUrl',
	  `scale`               varchar(512)  DEFAULT ''          COMMENT '缩放比例',
	  `label`               varchar(512)  DEFAULT ''          COMMENT '位置信息',
	  `location_x`          varchar(512)  DEFAULT ''          COMMENT '经度',
	  `location_y`          varchar(512)  DEFAULT ''          COMMENT '纬度',
	  `mediaid`             varchar(512)  DEFAULT ''          COMMENT 'MediaID',
	  `thumbmediaid`        varchar(512)  DEFAULT ''          COMMENT 'ThumbMediaID',
	  `createtime`       	datetime      DEFAULT NULL        COMMENT '创建时间',
	  `wxid`                varchar(28)   DEFAULT ''          COMMENT '微信用户openid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='平台收到的用户上行内容';





-- 自动回复关键词  -- 
DROP TABLE IF EXISTS `weixin_blog_keyword`;
CREATE TABLE `weixin_blog_keyword` (
	  `id`                  int(11) NOT NULL AUTO_INCREMENT   COMMENT 'id自增',
	  `content`             varchar(256)  DEFAULT ''          COMMENT '内容',  
	  `ctype`               int(10)       DEFAULT '0'         COMMENT '内容形式  1：列表 2：文字', 
	  `keyword`             varchar(256)  DEFAULT ''          COMMENT '关键词',  
	  `uid`                 int(10)       DEFAULT '0'         COMMENT '创建人ID', 
	  `createtime`       	datetime      DEFAULT NULL        COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='自动回复关键词';




-- 自动回复内容列表-- 
DROP TABLE IF EXISTS `weixin_blog_keyword_clist`;
CREATE TABLE `weixin_blog_keyword_clist` (
	  `id`                  int(11) NOT NULL AUTO_INCREMENT   COMMENT 'id自增',
	  `createtime`       	datetime      DEFAULT NULL        COMMENT '创建时间',
	  `uid`                 int(10)       DEFAULT '0'         COMMENT '创建人ID', 
	  `kid`         		int(10)       DEFAULT '0'         COMMENT '关键词ID',
	  `sort`         		int(10)       DEFAULT '0'         COMMENT '排序序号',
	  `url`                 varchar(256)  DEFAULT ''          COMMENT '帖子URL',  
	  `img`                 varchar(256)  DEFAULT ''          COMMENT '帖子缩略图', 
	  `title`               varchar(256)  DEFAULT ''          COMMENT '帖子标题', 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='自动回复内容列表';




-- 意见反馈信息表   --
DROP TABLE IF EXISTS `weixin_blog_feedback`;
CREATE TABLE `weixin_blog_feedback` (
  `id`           bigint(20)   unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `mobile`       varchar(11)   DEFAULT ''   COMMENT '联系电话', 
  `question`     varchar(1024) DEFAULT ''   COMMENT '问题',
  `createtime`   datetime      DEFAULT NULL COMMENT '创建时间', 
  `content`      varchar(512)  CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''   COMMENT '反馈内容',
  `uid`          int(11)       DEFAULT '0'  COMMENT '反馈人ID',
  `questiontype` int(1)        DEFAULT '0'  COMMENT '1:课程相关 2:问题相关 3:导师相关 0:其它',
  `status`       int(3)        DEFAULT '0'  COMMENT '0 未回复  1：已回复',
  `rid`          int(11)       DEFAULT '0'  COMMENT '答复人ID',
  `rcontent`     varchar(1024) DEFAULT ''   COMMENT '答复内容',
  `uname`        varchar(256)  CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''   COMMENT '反馈人名称',
  PRIMARY KEY (`id`),
  KEY `index_mobile` (`mobile`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='意见反馈信息表';

 


-- 用户粉丝列表  -- 
DROP TABLE IF EXISTS `weixin_blog_follow`;
CREATE TABLE `weixin_blog_follow` (
	  `id`                  int(11)        AUTO_INCREMENT      COMMENT 'id自增',
	  `wid`                 int(11)        DEFAULT '0'         COMMENT '关注人ID',
	  `wwid`          		int(10)        DEFAULT '0'         COMMENT '被关注人的ID',
	  `createtime`       	datetime       DEFAULT NULL        COMMENT '关注时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `wid` (`wid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户粉丝列表 ';


-- 老师的课程专题维护-- 
DROP TABLE IF EXISTS `weixin_blog_teacher_course_special`;
CREATE TABLE `weixin_blog_teacher_course_special` (
	  `id`                  int(11) NOT NULL AUTO_INCREMENT  COMMENT 'id自增',
	  `name`                varchar(256) DEFAULT ''          COMMENT '专题名称',
	  `parentid`            int(11) 	 NOT NULL   		 COMMENT '父分类ID',
	  `parentname` 			varchar(256) DEFAULT ''          COMMENT '父分类名称',
	  `createtime`       	datetime     DEFAULT NULL        COMMENT '创建时间',
	  `seqindex`       		int(10)      DEFAULT '0'         COMMENT '前台序号，越大越靠前',
	  `remark`              text         DEFAULT NULL        COMMENT '专题介绍',
	  `course_count`        int(11)      DEFAULT '0'         COMMENT '下属课程数量',
	  `logo` 				varchar(128) DEFAULT ''          COMMENT '类别LOGO',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='课程专题 ';

-- 老师的课程管理  -- 
DROP TABLE IF EXISTS `weixin_blog_teacher_course`;
CREATE TABLE `weixin_blog_teacher_course` (
	  `id`                  int(11) NOT NULL AUTO_INCREMENT  COMMENT 'id自增',
	  `cname`               varchar(256)  CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''  COMMENT '课程名称',  
	  `remark`              varchar(1024) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''  COMMENT '课程简介', 
	  `content`             text          CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''  COMMENT '课程详细介绍', 
	  `icon`                varchar(128)  DEFAULT ''          COMMENT '课程LOGO',
	  `longtime`            varchar(128)  DEFAULT ''          COMMENT '播放时长',
      `playcount`           int(11)       DEFAULT '0'         COMMENT '播放次数',
      `zancount`            int(11)       DEFAULT '0'         COMMENT '点赞次数',
      `buycount`            int(11)       DEFAULT '0'         COMMENT '购买次数',
      `followcount`         int(11)       DEFAULT '0'         COMMENT '收藏次数',
      `commentcount`        int(11)       DEFAULT '0'         COMMENT '评论次数',
	  `createtime`       	datetime      DEFAULT NULL        COMMENT '创建时间',
	  `uid`                 int(10)       DEFAULT '0'         COMMENT '创建人ID',  
	  `filepath`            varchar(256)  DEFAULT ''          COMMENT '文件地址', 
	  `password`            varchar(256)  DEFAULT ''          COMMENT '课程密码', 
	  `money`               varchar(256)  DEFAULT '0'         COMMENT '课程价格', 
	  `pers`                int(11)       DEFAULT '0'         COMMENT '限定上课人数', 
	  `issystem`            int(1)        DEFAULT '0'         COMMENT '是否系统课程 0:不是 1：是',
	  `stauts`              int(1)        DEFAULT '0'         COMMENT '课程状态 -1待上线  0：正常 1：下线',
	  `taglist`             varchar(256)  DEFAULT ''          COMMENT '课程标签，多个，号分割', 
	  `specialid`           varchar(256)  DEFAULT ''          COMMENT '一级分类ID,多个,号分割', 
	  `specialid2`          varchar(256)  DEFAULT ''          COMMENT '二级分类ID,多个,号分割', 
	  `consumer`            varchar(256)  DEFAULT ''          COMMENT '适合人群ID,多个,号分割', 
	  `ctype`               int(1)        DEFAULT '0'         COMMENT '课程类型 0:音频 1:视频', 
	  `issystemtop`         int(1)        DEFAULT '0'         COMMENT '在系统中的显示序号：排序条件',
	  `realfilepath`        varchar(256)  DEFAULT ''          COMMENT '真实文件地址', 
	  `recommend`           int(1)        DEFAULT '0'         COMMENT '是否推荐到首页  0：否  1：是', 
	  `belong`              int(1)        DEFAULT '0'         COMMENT '课程归属 0：老师 1：平台',
	  `property`            int(1)        DEFAULT '0'         COMMENT '课程属性  0：普通课程  1：目录课程',
	  `expiretime`          datetime      DEFAULT null        COMMENT '过期时间',
	  `istop`               int(1)        DEFAULT '0'         COMMENT '是否推荐到精选课程 0：否 1：是',
	  `logo`                varchar(128)   DEFAULT ''         COMMENT '课程列表LOGO',
	  `fcbl`                varchar(128)   DEFAULT ''         COMMENT '课程分成比例 5/2/3，平台/老师/分销',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='老师的课程管理';
 


-- 老师的课程明细  -- 
DROP TABLE IF EXISTS `weixin_blog_teacher_course_item`;
CREATE TABLE `weixin_blog_teacher_course_item` (
	  `id`                  int(11) NOT NULL AUTO_INCREMENT  COMMENT 'id自增',
      `cid`                 int(11)      DEFAULT '0'         COMMENT '主课程ID',
      `type`                int(11)      DEFAULT '0'         COMMENT '课程内容形式  1：文字  2:图片 3：录音 4：视频',
	  `createtime`       	datetime     DEFAULT NULL        COMMENT '创建时间',
	  `filepath`            varchar(256) DEFAULT ''          COMMENT '文件地址',
	  `num`                 int(11)      DEFAULT '0'         COMMENT '前台显示序号，显示序号，越小越靠前',
	  `name`                varchar(256) DEFAULT ''          COMMENT '子课程名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='老师的课程明细 ';



-- 课程评论列表  -- 
DROP TABLE IF EXISTS `weixin_blog_teacher_course_comment`;
CREATE TABLE `weixin_blog_teacher_course_comment` (
	  `id`                  int(11)        AUTO_INCREMENT      COMMENT 'id自增',
	  `content`             varchar(1024)  CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''          COMMENT '评论内容',
	  `cid`          		int(10)        DEFAULT '0'          COMMENT '评论内容ID',
	  `wid`          		int(10)        DEFAULT '0'          COMMENT '评论人ID',
	  `createtime`       	datetime       DEFAULT NULL         COMMENT '评论时间',
	  `status`              int(1)         DEFAULT '0'          COMMENT '0正常，1封停',
	  `ctype`               int(1)         DEFAULT '0'          COMMENT '评论类型 0社区，1课程',
	  `mp3path`         	varchar(512)   DEFAULT ''           COMMENT '回答录音的存储地址',
	  `asktlong`         	varchar(512)   DEFAULT ''           COMMENT '回答的录音时长',
	  `askmoney`            varchar(16)    DEFAULT '0.0'        COMMENT '本条提问的价格',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='课程评论列表 ';



 
DROP TABLE IF EXISTS `weixin_blog_teacher_order_buffer`;
CREATE TABLE `weixin_blog_teacher_order_buffer` (
	  `id`                  int(11)        AUTO_INCREMENT       COMMENT 'id自增',
	  `cid`          		int(10)        DEFAULT '0'          COMMENT '内容ID',
	  `cname`          	    varchar(1024)  CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''   COMMENT '内容标题',
	  `wid`          		int(10)        DEFAULT '0'          COMMENT '付费用户ID',
	  `tid`          		int(10)        DEFAULT '0'          COMMENT '回答用户ID',
	  `createtime`       	datetime       DEFAULT NULL         COMMENT '付费时间',
	  `isbalance`           int(1)         DEFAULT '0'          COMMENT '是否已经结算 0：未结算 1：已结算',
	  `type`                int(1)         DEFAULT '0'          COMMENT '付费类型 0：问答 1：课程',
	  `wxid`          	    varchar(64)    DEFAULT ''           COMMENT '付费用户wxid',
	  `twxid`          	    varchar(64)    DEFAULT ''           COMMENT '老师的wxid',
	  `balancetime`       	datetime       DEFAULT NULL         COMMENT '结算时间',
	  `tmoney`              varchar(64)    DEFAULT '0.0'        COMMENT '本条总付款价格',
	  `profit`              varchar(64)    DEFAULT '0.0'        COMMENT '平台利润',
	  `money`               varchar(64)    DEFAULT '0.0'        COMMENT '本次结算价格',
	  `saleid`              int(11)        DEFAULT '0'          COMMENT '销售人员ID',
	  `salemoney`           varchar(64)    DEFAULT '0.0'        COMMENT '销售人员提成',
	  `fcbl`          	    varchar(64)    DEFAULT ''           COMMENT '当时下单的分成比例',
	  `loggerid`     		int(11)        DEFAULT '0'          COMMENT '操作日志ID',
	  `refundnumber`        varchar(64)    DEFAULT ''           COMMENT '退款序号',
	  `ordernumber`         varchar(64)    DEFAULT ''           COMMENT '订单编号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='临时退款表';




-- 订单   -- 
DROP TABLE IF EXISTS `weixin_blog_teacher_order`;
CREATE TABLE `weixin_blog_teacher_order` (
	  `id`                  int(11)        AUTO_INCREMENT       COMMENT 'id自增',
	  `cid`          		int(10)        DEFAULT '0'          COMMENT '内容ID',
	  `cname`          	    varchar(1024)  CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''   COMMENT '内容标题',
	  `wid`          		int(10)        DEFAULT '0'          COMMENT '付费用户ID',
	  `tid`          		int(10)        DEFAULT '0'          COMMENT '回答用户ID',
	  `createtime`       	datetime       DEFAULT NULL         COMMENT '付费时间',
	  `isbalance`           int(1)         DEFAULT '0'          COMMENT '是否已经结算 0：未结算 1：已结算',
	  `type`                int(1)         DEFAULT '0'          COMMENT '付费类型 0：问答 1：课程 2:直播间 3：线下课程 4：活动',
	  `wxid`          	    varchar(64)    DEFAULT ''           COMMENT '付费用户wxid',
	  `twxid`          	    varchar(64)    DEFAULT ''           COMMENT '老师的wxid',
	  `xwxid`          	    varchar(64)    DEFAULT ''           COMMENT '分销人员的wxid',
	  `balancetime`       	datetime       DEFAULT NULL         COMMENT '结算时间',
	  `tmoney`              varchar(64)    DEFAULT '0.0'        COMMENT '本条总付款价格',
	  `profit`              varchar(64)    DEFAULT '0.0'        COMMENT '平台利润',
	  `money`               varchar(64)    DEFAULT '0.0'        COMMENT '老师的价格',
	  `saleid`              int(11)        DEFAULT '0'          COMMENT '销售人员ID',
	  `salemoney`           varchar(64)    DEFAULT '0.0'        COMMENT '分销人员收入',
	  `fcbl`          	    varchar(64)    DEFAULT ''           COMMENT '当时下单的分成比例',
	  `loggerid`     		int(11)        DEFAULT '0'          COMMENT '操作日志ID',
	  `refundnumber`        varchar(64)    DEFAULT ''           COMMENT '退款序号',
	  `ordernumber`         varchar(64)    DEFAULT ''           COMMENT '订单编号',
	  `isexpose`            int(1)         DEFAULT '0'          COMMENT '是否已经清算 0：未清算 1：已清算',
	  `exposetime`       	datetime       DEFAULT NULL         COMMENT '清算时间',
	  `expirationtime`      datetime       DEFAULT NULL         COMMENT '课程有效时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique-ordernumber` (`ordernumber`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='订单';




-- 历史订单   -- 
DROP TABLE IF EXISTS `weixin_blog_teacher_order_history`;
CREATE TABLE `weixin_blog_teacher_order_history` (
	  `id`                  int(11)        AUTO_INCREMENT       COMMENT 'id自增',
	  `cid`          		int(10)        DEFAULT '0'          COMMENT '内容ID',
	  `cname`          	    varchar(1024)  CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''   COMMENT '内容标题',
	  `wid`          		int(10)        DEFAULT '0'          COMMENT '付费用户ID',
	  `tid`          		int(10)        DEFAULT '0'          COMMENT '回答用户ID',
	  `createtime`       	datetime       DEFAULT NULL         COMMENT '付费时间',
	  `isbalance`           int(1)         DEFAULT '0'          COMMENT '是否已经结算 0：未结算 1：已结算',
	  `type`                int(1)         DEFAULT '0'          COMMENT '付费类型 0：问答 1：课程',
	  `wxid`          	    varchar(64)    DEFAULT ''           COMMENT '付费用户wxid',
	  `twxid`          	    varchar(64)    DEFAULT ''           COMMENT '老师的wxid',
	  `balancetime`       	datetime       DEFAULT NULL         COMMENT '结算时间',
	  `tmoney`              varchar(64)    DEFAULT '0.0'        COMMENT '本条总付款价格',
	  `profit`              varchar(64)    DEFAULT '0.0'        COMMENT '平台利润',
	  `money`               varchar(64)    DEFAULT '0.0'        COMMENT '本次结算价格',
	  `saleid`              int(11)        DEFAULT '0'          COMMENT '销售人员ID',
	  `salemoney`           varchar(64)    DEFAULT '0.0'        COMMENT '销售人员提成',
	  `fcbl`          	    varchar(64)    DEFAULT ''           COMMENT '当时下单的分成比例',
	  `loggerid`     		int(11)        DEFAULT '0'          COMMENT '操作日志ID',
	  `refundnumber`        varchar(64)    DEFAULT ''           COMMENT '退款序号',
	  `ordernumber`         varchar(64)    DEFAULT ''           COMMENT '订单编号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='历史订单';


-- 过期退还用户的订单   -- 
DROP TABLE IF EXISTS `weixin_blog_teacher_order_expire`;
CREATE TABLE `weixin_blog_teacher_order_expire` (
	  `id`                  int(11)        AUTO_INCREMENT       COMMENT 'id自增',
	  `cid`          		int(10)        DEFAULT '0'          COMMENT '内容ID',
	  `cname`          	    varchar(1024)  CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''   COMMENT '内容标题',
	  `wid`          		int(10)        DEFAULT '0'          COMMENT '付费用户ID',
	  `tid`          		int(10)        DEFAULT '0'          COMMENT '回答用户ID',
	  `createtime`       	datetime       DEFAULT NULL         COMMENT '付费时间',
	  `isbalance`           int(1)         DEFAULT '0'          COMMENT '是否已经结算 0：未结算 1：已结算',
	  `type`                int(1)         DEFAULT '0'          COMMENT '付费类型 0：问答 1：课程',
	  `wxid`          	    varchar(64)    DEFAULT ''           COMMENT '付费用户wxid',
	  `twxid`          	    varchar(64)    DEFAULT ''           COMMENT '老师的wxid',
	  `balancetime`       	datetime       DEFAULT NULL         COMMENT '结算时间',
	  `tmoney`              varchar(64)    DEFAULT '0.0'        COMMENT '本条总付款价格',
	  `profit`              varchar(64)    DEFAULT '0.0'        COMMENT '平台利润',
	  `money`               varchar(64)    DEFAULT '0.0'        COMMENT '本次结算价格',
	  `saleid`              int(11)        DEFAULT '0'          COMMENT '销售人员ID',
	  `salemoney`           varchar(64)    DEFAULT '0.0'        COMMENT '销售人员提成',
	  `fcbl`          	    varchar(64)    DEFAULT ''           COMMENT '当时下单的分成比例',
	  `loggerid`     		int(11)        DEFAULT '0'          COMMENT '操作日志ID',
	  `refundnumber`        varchar(64)    DEFAULT ''           COMMENT '退款序号',
	  `ordernumber`         varchar(64)    DEFAULT ''           COMMENT '订单编号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='过期退还用户的订单';




-- 前台用户行为日志  -- 
DROP TABLE IF EXISTS `weixin_blog_user_logger`;
CREATE TABLE `weixin_blog_user_logger` (
	  `id`                  int(11)        AUTO_INCREMENT       COMMENT 'id自增',
	  `cid`          		int(10)        DEFAULT '0'          COMMENT '关联内容ID',
	  `cname`          	    varchar(512)   DEFAULT ''           COMMENT '行为标题',
	  `wid`          		int(10)        DEFAULT '0'          COMMENT '用户ID',
	  `createtime`       	datetime       DEFAULT NULL         COMMENT '行为时间',
	  `type`                int(1)         DEFAULT '0'          COMMENT '行为类型 1：向老师提问 2：购买课程 ',
	  `wxid`          	    varchar(16)    DEFAULT ''           COMMENT '用户wxid',
	  `isgiveup`            int(1)         DEFAULT '0'          COMMENT '是否放弃付款 0是  1否',
	  `tmoney`              varchar(16)    DEFAULT '0.0'        COMMENT '付款总额',
	  `ordernumber`         varchar(128)   DEFAULT ''        	COMMENT '付款总额',
 	  `smoney`              varchar(16)    DEFAULT '0.0'        COMMENT '分销产品价格',
	  `sdmoney`             varchar(16)    DEFAULT '0.0'        COMMENT '分销代理商收益',
	  `stmoney`             varchar(16)    DEFAULT '0.0'        COMMENT '分销老师收益',
	  `swid`                int(11)        DEFAULT '0'          COMMENT '分销代理商id',
	  `updatetime` 			datetime 	   DEFAULT NULL 		COMMENT '更新时间',                                                          
	  `isopen` 				int(1)         DEFAULT 0 			COMMENT '是否公开0：公开 1：不公开 ',                                                
	  `wxordernum` 			varchar(100)   DEFAULT '' 			COMMENT '微信订单号',                                          
	  `content` 			longtext       CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '内容', 
	  `contentid` 			int DEFAULT 0 comment '内容id';                                                        
	  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='前台用户行为日志';


 

-- 暖冬资料  -- 
DROP TABLE IF EXISTS `weixin_blog_data`;
CREATE TABLE `weixin_blog_data` (
  `id` 						int(11) NOT NULL AUTO_INCREMENT  COMMENT 'id',
  `datename` 				varchar(20)  DEFAULT '' 		 COMMENT '资料名称',
  `url` 					varchar(512) NOT NULL DEFAULT '' COMMENT 'URL',
  `remark` 					varchar(512) DEFAULT NULL        COMMENT '备注',
  `createtime` 				datetime     DEFAULT NULL        COMMENT '上传时间',
  `update_time` 			datetime     DEFAULT NULL        COMMENT '修改时间',
  `dflag` 					int(1)       DEFAULT '0'         COMMENT '删除标志 0：正常 1：删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='社区资料信息';



-- 聊天内容列表  -- 
DROP TABLE IF EXISTS `weixin_blog_room_msg`;
CREATE TABLE `weixin_blog_room_msg` (
  `id` 						int(11)      NOT NULL AUTO_INCREMENT  COMMENT 'id',
  `nickname` 				varchar(128) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' 		  COMMENT '发言人昵称',
  `header` 					varchar(512) DEFAULT ''           COMMENT '发言人头像',
  `content` 				varchar(512) CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''           COMMENT '内容', 
  `t` 					    int(1)       DEFAULT '0'          COMMENT '发言类型  0：学生 1：老师',
  `wid` 					int(11)      DEFAULT '0'          COMMENT '发言人ID',
  `roomid` 					int(11)      DEFAULT '0'          COMMENT '聊天室ID',
  `talktime` 				int(20)      DEFAULT '0'          COMMENT '聊天时间',
  `serverId` 				varchar(512) DEFAULT ''           COMMENT 'serverId', 
  `mp3time` 				varchar(512) DEFAULT ''           COMMENT '录音时长', 
  `createtime` 				datetime     DEFAULT NULL         COMMENT '上传时间',
  `type` 				    int(1)       DEFAULT '0'          COMMENT '消息类型 1|文字  2|图片  3|语音 4|视频',
  `mp3path` 				varchar(512) DEFAULT ''           COMMENT 'mp3路径', 
  `realname` 				varchar(32)  DEFAULT ''           COMMENT '真是姓名', 
  PRIMARY KEY (`id`),
  KEY `index_roomid` (`roomid`,`t`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='聊天内容列表';



-- 系统数据字典  -- 
DROP TABLE IF EXISTS `weixin_blog_sysdic`;
CREATE TABLE `weixin_blog_sysdic` (
  `id` 						int(11)      NOT NULL AUTO_INCREMENT  COMMENT 'id',
  `type` 		    	    int(11)      DEFAULT '0'          COMMENT '字典类型',
  `value` 					varchar(512) DEFAULT ''           COMMENT 'value值',
  `name`  					varchar(512) DEFAULT '0'          COMMENT '显示值',
  `value1` 					varchar(512) DEFAULT ''           COMMENT 'value1值',
  `value2` 					varchar(512) DEFAULT ''           COMMENT 'value2值',
  `value3` 					varchar(512) DEFAULT ''           COMMENT 'value3值',
  `createtime` 				datetime     DEFAULT NULL         COMMENT '创建时间',
  `dflag` 		    	    int(1)       DEFAULT NULL         COMMENT '删除标识：0正常 1删除',
  PRIMARY KEY (`id`),
  KEY `index_type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='系统数据字典';




-- 系统统计按日  -- 
DROP TABLE IF EXISTS `weixin_blog_stat_day`;
CREATE TABLE `weixin_blog_stat_day` (
  `id` 						int(11)      NOT NULL AUTO_INCREMENT  COMMENT 'id',
  `newuser` 		        int(11)      DEFAULT '0'          COMMENT '每日新增用户',
  `totaluser` 		        int(11)      DEFAULT '0'          COMMENT '总用户数',
  `aticleuser` 		        int(11)      DEFAULT '0'          COMMENT '每日活跃用户数',
  `newaticle` 		        int(11)      DEFAULT '0'          COMMENT '每日新增提问数',
  `totalaticle` 		    int(11)      DEFAULT '0'          COMMENT '总提问数量', 
  `cancelfollowcount` 	    int(11)      DEFAULT '0'          COMMENT '取消关注数量', 
  `createtime` 				date         DEFAULT NULL         COMMENT '创建时间',
  `openquestioncount`       int(11)      DEFAULT '0'          COMMENT '公开提问数量', 
  `noopenquestioncount`     int(11)      DEFAULT '0'          COMMENT '非公开提问数量', 
  `okanswercount`           int(11)      DEFAULT '0'          COMMENT '已回答数量', 
  `noanswercount`           int(11)      DEFAULT '0'          COMMENT '未回答数量', 
  `gqanswercount`           int(11)      DEFAULT '0'          COMMENT '未过期数量', 
  `searchcount`             int(11)      DEFAULT '0'          COMMENT '搜索次数',
  `freelistencount`         int(11)      DEFAULT '0'          COMMENT '免费听次数',
  `submitquestioncount`     int(11)      DEFAULT '0'          COMMENT '提交问题点击次数',
  `buybuttoncount`          int(11)      DEFAULT '0'          COMMENT '购买课程次数',
  `lookatcount`             int(11)      DEFAULT '0'          COMMENT '试看次数',
  `collectioncount`         int(11)      DEFAULT '0'          COMMENT '收藏次数',
  `sharecount`              int(11)      DEFAULT '0'          COMMENT '分享次数',
  `commentcount`            int(11)      DEFAULT '0'          COMMENT '评论次数',
  PRIMARY KEY (`id`),
  KEY `index_createtime` (`createtime`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='系统统计按日';

 
 
-- 老师结算表   -- 
DROP TABLE IF EXISTS `weixin_blog_teacher_balance`;
CREATE TABLE `weixin_blog_teacher_balance` (
  `id` 			 int(11)       NOT NULL AUTO_INCREMENT  COMMENT 'id',
  `tid`          varchar(128)  DEFAULT  ''     COMMENT '老师ID',
  `createtime` 	 datetime      DEFAULT  NULL   COMMENT '操作时间',
  `money`        float(10,2)   DEFAULT '0.00'  COMMENT '待结算金额',
  `money_`       float(10,2)   DEFAULT '0.00'  COMMENT '已结算金额',
  `once`         int(11)       DEFAULT '0'     COMMENT '结算次数',
  `recordlist`   text          DEFAULT  null   COMMENT '结算对应实体ID',
  `updatetime` 	 datetime      DEFAULT  NULL   COMMENT '清算时间',
  `wxid`         varchar(128)  DEFAULT  ''     COMMENT 'wxid',
  PRIMARY KEY (`id`),
  KEY `index_tid` (`tid`),
  UNIQUE KEY `tid` (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='老师结算表';




-- 老师结算历史   -- 
DROP TABLE IF EXISTS `weixin_blog_teacher_balance_history`;
CREATE TABLE `weixin_blog_teacher_balance_history` (
  `id` 			 int(11)       NOT NULL AUTO_INCREMENT  COMMENT 'id',
  `tid`          varchar(128)  DEFAULT  ''     COMMENT '老师ID',
  `puid`         varchar(128)  DEFAULT  ''     COMMENT '付款人ID',
  `puname`       varchar(128)  DEFAULT  ''     COMMENT '付款人姓名',
  `createtime` 	 datetime      DEFAULT  NULL   COMMENT '结算时间',
  `money`        float(10,2)   DEFAULT '0.00'  COMMENT '待结算金额',
  `money_`       float(10,2)   DEFAULT '0.00'  COMMENT '已结算金额',
  `once`         int(11)       DEFAULT '0'     COMMENT '结算次数',
  `recordlist`   text          DEFAULT  null   COMMENT '结算对应实体ID',
  `wxid`         varchar(128)  DEFAULT  ''     COMMENT 'wxid',
  PRIMARY KEY (`id`),
  KEY `index_tid` (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='老师结算历史';



-- 系统操作日志  -- 
DROP TABLE IF EXISTS `weixin_system_logger`;
CREATE TABLE `weixin_system_logger` (
  `id` 			 int(11)       NOT NULL AUTO_INCREMENT  COMMENT 'id',
  `createtime` 	 datetime      DEFAULT  NULL   COMMENT '操作时间',
  `maxmenu`      varchar(128)  DEFAULT  ''     COMMENT '大菜单栏目名称',
  `minmenu`      varchar(128)  DEFAULT  ''     COMMENT '小菜单栏目名称',
  `remark`       varchar(1024) DEFAULT  ''     COMMENT '日志记录描述',
  `glob`         longtext      DEFAULT  null   COMMENT '内容实体vo',
  `tid`       	 int(11)       DEFAULT '0'     COMMENT '收款人ID',
  `userid`       int(11)       DEFAULT '0'     COMMENT '操作人ID来自system_user表的ID',
  `uasername`    varchar(128)  DEFAULT  ''     COMMENT '操作人姓名',
  `functionname` varchar(128)  DEFAULT  ''     COMMENT '方法号',
  `type` 		 int(11)       DEFAULT '0'     COMMENT '日志类型 1:财务支付 2：删除操作  3：新增操作  4：修改操作 5：登录操作 6：修改分成比例和金额',
  PRIMARY KEY (`id`),
  KEY `index_type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='系统日志';




-- 活动页面  -- 
DROP TABLE IF EXISTS `weixin_blog_activity`;
CREATE TABLE `weixin_blog_activity` (
  `id` 			 int(11)       NOT NULL AUTO_INCREMENT  COMMENT 'id',
  `createtime` 	 datetime      DEFAULT  NULL   COMMENT '创建时间',
  `name`         varchar(512)  DEFAULT  ''     COMMENT '活动名称', 
  `logo`         varchar(512)  DEFAULT  ''     COMMENT '活动LOGO', 
  `remark`       longtext      DEFAULT  null   COMMENT '活动介绍',
  `shortremark`  varchar(512)  CHARACTER SET   utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''   COMMENT '活动简介',
  `showstatus`   int(1)        DEFAULT '0'     COMMENT '前台是否显示 0：不显示  1：显示',
  `status` 		 int(1)        DEFAULT '0'     COMMENT '活动状态 0：未开始  1：进行中 2:已结束',
  `url`          varchar(512)  DEFAULT  ''     COMMENT '站内URL', 
  `istop` 		 int(1)        DEFAULT '0'     COMMENT '置顶状态 0否 1是',
  `toptime` 	 datetime      DEFAULT  NULL   COMMENT '置顶时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='活动页面';



-- 使用帮助  -- 
DROP TABLE IF EXISTS `weixin_blog_help`;
CREATE TABLE `weixin_blog_help` (
  `id` 			 int(11)       NOT NULL AUTO_INCREMENT  COMMENT 'id',
  `createtime` 	 datetime      DEFAULT  NULL   COMMENT '创建时间',
  `name`         varchar(512)  DEFAULT  ''     COMMENT '帮助名称',  
  `remark`       text          DEFAULT  NULL   COMMENT '具体内容，富文本编辑器', 
  `sort` 		 int(11)       DEFAULT '0'     COMMENT '前台显示序号',
  `type` 		 int(1)        DEFAULT '0'     COMMENT '类型 1：帮助 2：协议',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='使用帮助';



-- 2016理疗活动集训营  -- 
DROP TABLE IF EXISTS `weixin_phy_activity`;
CREATE TABLE `weixin_phy_activity` (
  `id` 			 int(11)       NOT NULL AUTO_INCREMENT   COMMENT 'id',
  `createtime` 	 datetime      DEFAULT  NULL   COMMENT   '创建时间',
  `opentime` 	 datetime      DEFAULT  NULL   COMMENT   '开始时间',
  `name`         varchar(512)  DEFAULT  ''     COMMENT   '课程名称',   
  `sort` 		 int(11)       DEFAULT '0'     COMMENT   '前台显示序号',
  `status` 		 int(1)        DEFAULT '0'     COMMENT   '状态 0：未开始  1：已开始 2：已结束', 
  `aid`          int(11)       DEFAULT '0'     COMMENT   '活动ID',
  `cid`          int(11)       DEFAULT '0'     COMMENT   '普通课程ID',
  `title`        varchar(512)  DEFAULT  ''     COMMENT   '片花文件地址',    
  `code`         varchar(128)  DEFAULT  ''     COMMENT   '课程邀请码',
  `tid`          int(11)       DEFAULT '0'     COMMENT   '老师ID',
  `taglist`      varchar(256)  DEFAULT ''      COMMENT   '课程标签，多个，号分割',
  `remark`       varchar(1024) CHARACTER SET   utf8mb4   COLLATE utf8mb4_unicode_ci  DEFAULT ''  COMMENT '课程简介',
  `mamagerid`    int(11)       DEFAULT '0'     COMMENT   '',
  `numbers`      int(6)        DEFAULT '0'     COMMENT   '',
  `counts`       int(8)        DEFAULT '0'     COMMENT   '',
  `teacherids`   varchar(128)  DEFAULT ''      COMMENT   '活动老师',
  `holderids`    varchar(128)  DEFAULT ''      COMMENT   '活动多支持人',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='2016理疗活动集训营';




-- 聊天内容  -- 
DROP TABLE IF EXISTS `weixin_phy_activity_msg`;
CREATE TABLE `weixin_phy_activity_msg` (
  `id` 			 int(11)       NOT NULL AUTO_INCREMENT   COMMENT 'id',
  `createtime` 	 datetime      DEFAULT  NULL   COMMENT   '创建时间',
  `content`      varchar(512)   CHARACTER SET  utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT ''   COMMENT '聊天内容',
  `uid`          varchar(128)  DEFAULT  ''     COMMENT   '聊天内容ID', 
  `mp3`          varchar(512)  DEFAULT  ''     COMMENT   'MP3文件地址',  
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='聊天内容';

-- 老师回答内容  -- 
DROP TABLE IF EXISTS weixin_blog_answer;
CREATE TABLE weixin_blog_answer (
	id			int(11)			primary key auto_increment,
	cid			int(11)			not null			 comment '问题id',
	serverid	varchar(128)	not null			 comment '微信资源ID',
	mp3path		varchar(128)	not null default ''	 comment 'MP3资源地址',
	timelong	int(3)			not null default 0	 comment '录音时长', 
	createtime	datetime							 comment '创建时间'
	type        tinyint(4)      NOT NULL DEFAULT '0' COMMENT '类型，0首次答案，1追问答案',
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='老师回答内容';


-- 课程标签管理 --
DROP TABLE IF EXISTS weixin_blog_teacher_course_taglist;
CREATE TABLE weixin_blog_teacher_course_taglist (
    id		    int(11)       NOT NULL  AUTO_INCREMENT  COMMENT 'id',
    taglist     varchar(256)  DEFAULT ''                COMMENT '标签',
    status      int(1)        DEFAULT '0' 				COMMENT '状态 0:启用 1:禁用',
    createtime 	datetime      DEFAULT  NULL             COMMENT   '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=962 DEFAULT CHARSET=utf8 COMMENT='课程标签库';



-- 经销商信息表  --
DROP TABLE IF EXISTS `weixin_blog_distributor`;
CREATE TABLE `weixin_blog_distributor` (
  `id` 				int(11) 		NOT NULL 		AUTO_INCREMENT 		COMMENT 'id',
  `cname` 			varchar(256) 	DEFAULT '' 		COMMENT '经销商名称',
  `idcard` 			varchar(20) 	DEFAULT '0' 	COMMENT '身份证号',
  `status` 			int(1) 			DEFAULT '0' 	COMMENT '经销商状态 0:启用 1:禁用',
  `createtime` 		datetime 		DEFAULT NULL 	COMMENT '创建时间',
  `mobile` 			varchar(256) 	DEFAULT '' 		COMMENT '经销商手机号',
  `remark` 			varchar(256) 	DEFAULT '' 		COMMENT '经销商信息',
  `bankcard` 		varchar(256) 	DEFAULT '' 		COMMENT '银行卡账户',
  `bankaccount` 	varchar(256) 	DEFAULT '' 		COMMENT '开户行',
  `bankaddress` 	varchar(256) 	DEFAULT '' 		COMMENT '开户行支行名称',
  `fcbl` 			varchar(256) 	DEFAULT '' 		COMMENT '分成比例，相加必须为10',
  `money` 			varchar(256) 	DEFAULT '' 		COMMENT '待结算金额',
  `salecount` 		int(11) 		DEFAULT '0' 	COMMENT '售卖数量',
  `wid` 			int(11) 		DEFAULT '0' 	COMMENT '经销商ID',
  `wxid` 			varchar(256) 	DEFAULT '' 		COMMENT '经销商WXID',
  `uuid` 			varchar(256) 	DEFAULT '' 		COMMENT '生成的唯一码 ',
  `filepath` 		varchar(256) 	DEFAULT '' 		COMMENT '二维码路径',
  `saleid` 			int(11) 		DEFAULT '0' 	COMMENT '渠道负责人id',
  `salename` 		varchar(100) 	DEFAULT '0' 	COMMENT '渠道负责人id',
  `idfile1id` 		varchar(128) 	DEFAULT '',
  `idfile1`		 	varchar(128) 	DEFAULT '',
  `idfile2id` 		varchar(128) 	DEFAULT '',
  `idfile2`			varchar(128) 	DEFAULT '',
  `acttype` 		int(11) 		DEFAULT '0' 	COMMENT '活动类型',
  `actname` 		varchar(128) 	DEFAULT '' 		COMMENT '活动名称',
  `checked` 		tinyint(4) 		DEFAULT '0',
  `logo` 			varchar(256) 	DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique-uuid` (`uuid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='经销商信息表'

-- 分销订单表  --
DROP TABLE IF EXISTS `weixin_blog_distributor_signup`;
CREATE TABLE `weixin_blog_distributor_signup` (
  `id` 				int(11) 		NOT NULL 	AUTO_INCREMENT 		COMMENT 'id',
  `cname` 			varchar(256) 	DEFAULT '' 						COMMENT '报名用户名称',
  `createtime` 		datetime 		DEFAULT NULL 					COMMENT '创建时间',
  `mobile` 			varchar(256) 	DEFAULT '' 						COMMENT '手机号',
  `remark` 			varchar(256) 	DEFAULT '' 						COMMENT '报名用户信息',
  `money` 			varchar(256) 	DEFAULT '' 						COMMENT '报名费用',
  `wid` 			int(11) 		DEFAULT '0' 					COMMENT '报名用户ID',
  `wxid` 			varchar(256) 	DEFAULT '' 						COMMENT '报名用户WXID',
  `did` 			int(11) 		DEFAULT '0' 					COMMENT '经销商ID',
  `mid` 			int(11) 		DEFAULT '0' 					COMMENT '后台用户ID',
  `dname` 			varchar(256) 	DEFAULT '' 						COMMENT '经销商姓名',
  `fcbl` 			varchar(256) 	DEFAULT '' 						COMMENT '分成比例，相加必须为10',
  `refund` 			int(1) 			DEFAULT '0' 					COMMENT '是否退款 0：正常  1：退款',
  `ccname` 			varchar(256) 	DEFAULT '' 						COMMENT '课程名称',
  `dmoney` 			varchar(512) 	DEFAULT '0' 					COMMENT '经销商金额',
  `pmoney` 			varchar(512) 	DEFAULT '0' 					COMMENT '平台金额',
  `ordernumber` 	varchar(64) 	NOT NULL 	DEFAULT '' 			COMMENT '微信支付流水号',
  `del` 			int(1) 			DEFAULT '0' 					COMMENT '删除 0：正常，1：删除',
  `acttype` 		int(11) 		DEFAULT '0' 					COMMENT '活动类型',
  `disregister` 	int(1) 			DEFAULT '0' 					COMMENT '是否注册 0：没注册，1：注册',
  `unionid` 		varchar(128) 	DEFAULT '' 						COMMENT 'unionid',
  `tradestate` 		varchar(20)	 	DEFAULT '' 						COMMENT '支付返回code',
  `wxordernum` 		varchar(128)	DEFAULT '' 						COMMENT '微信支付订单号',
  `checked` 		int(1) 			DEFAULT '0' 					COMMENT '是否检查：0未检查，1已检查',
  `occupation` 		varchar(128) 	DEFAULT '' 						COMMENT '职业',
  `loggerid` 		int(11) 		DEFAULT '0' 					COMMENT '日志ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ordernumber` (`ordernumber`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='经销商信息表'

-- 2016-09-07 中秋活动参与及投票记录
DROP TABLE IF EXISTS `weixin_blog_activity_actor`;
CREATE TABLE `weixin_blog_activity_actor` (
	  `id`           int(11)     NOT NULL     AUTO_INCREMENT COMMENT '活动参与记录id',
	  `wxid`         varchar(50)  DEFAULT NULL COMMENT '参与者用户openid',
	  `uid`	         int(11)     DEFAULT '0'  COMMENT '参与者用户id',
	  `nickname`     varchar(50) DEFAULT NULL COMMENT '参与者微信昵称',
	  `activityid`	  int(11)       DEFAULT '0'  COMMENT '活动id,暂时不使用',
	  `vote_count`    int(11)      DEFAULT '0'  COMMENT '投票数',
	  `create_time`   datetime     DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='活动参与记录';

--活动投票记录--
DROP TABLE IF EXISTS `weixin_blog_activity_voter`;
CREATE TABLE `weixin_blog_activity_voter` (
	  `id` 			int(11)  	 NOT NULL     AUTO_INCREMENT COMMENT '活动投票记录id',
	  `actorid`	    int(11)      DEFAULT '0'  COMMENT '活动参与者记录id',
	  `fromuid`	    int(11)      DEFAULT '0'  COMMENT '分享来源用户id',
	  `touid`	    int(11)      DEFAULT '0'  COMMENT '被分享用户id',
	  `wxid`   	    varchar(50)  DEFAULT NULL COMMENT '投票者微信id',
	  `nickname`    varchar(50)  DEFAULT NULL COMMENT '投票者微信昵称',
	  `file_path`   varchar(300) DEFAULT NULL COMMENT '投票者微信头像',
	  `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
	  `status`	    int(2)    	 DEFAULT '0'  COMMENT '投票状态成功状态：0，未投票，1已投票',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='活动投票记录';

-- 渠道负责人表 --
DROP TABLE IF EXISTS `weixin_blog_distributor_sale`;
CREATE TABLE `weixin_blog_distributor_sale` (
  `id` 				int(11) 	NOT NULL AUTO_INCREMENT 	COMMENT '渠道负责人id',
  `salename` 		varchar(50) DEFAULT NULL 				COMMENT '渠道负责人',
  `status` 			int(4) 		DEFAULT '0' 				COMMENT '状态：0正常，1禁用',
  `create_time` 	datetime 	DEFAULT NULL 				COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='渠道负责人表';
 

-- 运营管理，推广活动  --
DROP TABLE IF EXISTS weixin_blog_marketing;
CREATE TABLE weixin_blog_marketing (
    `id`		  	 	int(11)      	NOT NULL  AUTO_INCREMENT    COMMENT 'id',
    `title`           	varchar(512) 	DEFAULT ''                  COMMENT '消息标题',
    `coursename`      	varchar(512) 	DEFAULT ''                  COMMENT '课程名称',
    `teachername`      	varchar(512) 	DEFAULT ''                  COMMENT '老师名称',
    `remark`            varchar(512)    DEFAULT '' 			   	    COMMENT '描述',
    `url`  			    varchar(512)    DEFAULT '' 				    COMMENT '活动链接URL',
    `checkcount`		int(11) 		DEFAULT '0' 				COMMENT '点击次数',
    `noticecount`		int(11) 		DEFAULT '0' 				COMMENT '通知次数',
    `createtime` 		datetime 	    DEFAULT NULL 		        COMMENT '创建时间', 
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='运营管理，推广活动';



-- 运营管理，课程通知  --
DROP TABLE IF EXISTS weixin_blog_marketing_course_notice;
CREATE TABLE weixin_blog_marketing_course_notice (
    `id`		  	 	int(11)      	NOT NULL  AUTO_INCREMENT    COMMENT 'id',
    `title`           	varchar(512) 	DEFAULT ''                  COMMENT '消息标题',
    `coursename`      	varchar(512) 	DEFAULT ''                  COMMENT '课程名称',
    `teachername`      	varchar(512) 	DEFAULT ''                  COMMENT '老师名称',
    `opentime`      	varchar(512) 	DEFAULT ''                  COMMENT '开课时间',
    `remark`            varchar(512)    DEFAULT '' 			   	    COMMENT '描述',
    `msgcontent`        varchar(512)    DEFAULT '' 			   	    COMMENT '短信内容',
    `url`  			    varchar(512)    DEFAULT '' 				    COMMENT '活动链接URL',
    `ismsg`	        	int(11) 		DEFAULT '0' 				COMMENT '是否同是发送短信 0：否 1：是',
    `dicid`	        	int(11) 		DEFAULT '0' 				COMMENT '活动ID,对应数据字典ID',
    `noticecount`		int(11) 		DEFAULT '0' 				COMMENT '通知次数',
    `msgcount`	     	int(11) 		DEFAULT '0' 				COMMENT '短信发送次数',
    `createtime` 		datetime 	    DEFAULT NULL 		        COMMENT '创建时间', 
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='运营管理,课程通知';




-- 分销业务员 --
DROP TABLE IF EXISTS weixin_blog_saler;
CREATE TABLE weixin_blog_saler (
    `id`		  	 	int(11)      	NOT NULL  AUTO_INCREMENT    COMMENT 'id',
    `salerid`	     	int(11) 		DEFAULT '0' 				COMMENT '销售员ID,对应User表ID',
    `salename`         	varchar(512) 	DEFAULT ''                  COMMENT '销售员姓名',
    `salerwxid`         varchar(512) 	DEFAULT ''                  COMMENT '分销员wxid',
    `mobile`         	varchar(512) 	DEFAULT ''                  COMMENT '联系手机号(需要短信验证)',
    `salecount`	     	int(11) 		DEFAULT '0' 				COMMENT '销售数量',
    `totlemoney`        varchar(512) 	DEFAULT ''                  COMMENT '销售总金额',
    `paymoney`          varchar(512) 	DEFAULT ''                  COMMENT '已结金额',
    `money`         	varchar(512) 	DEFAULT ''                  COMMENT '未结金额',
    `createtime` 		datetime 	    DEFAULT NULL 		        COMMENT '创建时间', 
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique-salerid` (`salerid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='分销业务员';




-- 分销商品管理 --
DROP TABLE IF EXISTS weixin_blog_saler_product;
CREATE TABLE weixin_blog_saler_product (
    `id`		  	 	int(11)      	NOT NULL  AUTO_INCREMENT    COMMENT 'id',
    `productname`     	varchar(512) 	DEFAULT ''                  COMMENT '产品名称',
    `producttype`	  	int(1) 		    DEFAULT '0' 				COMMENT '产品类型 1：课程 2：活动',
    `productid`	    	int(1) 		    DEFAULT '0' 				COMMENT '产品ID，课程ID或活动ID',
    `status`	    	int(1) 		    DEFAULT '0' 				COMMENT '产品状态：1：分销中 2：下线 ',
    `money`        	    int(11)     	DEFAULT '0'                 COMMENT '产品价格',
    `fcbl`              varchar(512)    DEFAULT '' 			   	    COMMENT '分成比例', 
    `level`	        	int(11) 		DEFAULT '0' 				COMMENT '商品级别,决定销售员是否可以销售此商品',
    `createtime` 		datetime 	    DEFAULT NULL 		        COMMENT '创建时间', 
    `rowid`	            varchar(512)    DEFAULT '' 			     	COMMENT 'ROWID',
    `logo`	            varchar(128)    DEFAULT '' 			     	COMMENT 'LOGO',
    `title`	            varchar(128)    DEFAULT '' 			     	COMMENT '标题',
    `remark`	        varchar(256)    DEFAULT '' 			     	COMMENT '简介',
    `allnumber`	        int(11) 		DEFAULT '0' 				COMMENT '产品总量',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='分销商品';


 
-- 用户购买的商品关联关系表  --
DROP TABLE IF EXISTS weixin_blog_saler_order;
CREATE TABLE weixin_blog_saler_order (
    `id`		  	 	int(11)      	NOT NULL  AUTO_INCREMENT    COMMENT 'id',
    `productname`     	varchar(512) 	DEFAULT ''                  COMMENT '产品名称',
    `producttype`	  	int(1) 		    DEFAULT '0' 				COMMENT '产品类型 1：录播课程 2：直播课程',
    `productid`	    	int(1) 		    DEFAULT '0' 				COMMENT '产品ID',
    `salerid`		    int(11) 		DEFAULT '0' 				COMMENT '销售员ID，对应user表ID',
    `salername`     	varchar(512) 	DEFAULT ''                  COMMENT '销售员名称',
    `salerwxid`        	varchar(512) 	DEFAULT ''                  COMMENT '销售员微信ID,用于发送通知',
    `buyerid`		    int(11) 		DEFAULT '0' 				COMMENT '购买人ID，对应user表ID',
    `buyername`     	varchar(512) 	DEFAULT ''                  COMMENT '购买人名称',
    `buywxid`        	varchar(512) 	DEFAULT ''                  COMMENT '购买人微信ID',
    `money`        	    varchar(512)    DEFAULT ''                  COMMENT '产品价格',
    `fcbl`              varchar(512)    DEFAULT '' 			   	    COMMENT '分成比例',  
    `money_`        	varchar(512)    DEFAULT ''              	COMMENT '销售员分成金额',
    `ordernumber`       varchar(64) 	DEFAULT ''                  COMMENT '支付订单号',
    `createtime` 		datetime 	    DEFAULT NULL 		        COMMENT '创建时间', 
	`loggerid` 		int(11) 		DEFAULT '0' 					COMMENT '日志ID',
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique-ordernumber` (`ordernumber`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户购买的商品关联关系表 ';




-- 分销员结算数据  --
DROP TABLE IF EXISTS weixin_blog_saler_balance;
CREATE TABLE weixin_blog_saler_balance (
    `id`		  	 	int(11)      	NOT NULL  AUTO_INCREMENT    COMMENT 'id',
    `salerid`		    int(11) 		DEFAULT '0' 				COMMENT '销售员ID，对应user表ID',
    `salername`     	varchar(512) 	DEFAULT ''                  COMMENT '销售员名称',
    `money`         	varchar(512) 	DEFAULT ''                  COMMENT '结算金额',
    `money_`            varchar(512)    DEFAULT '' 			   	    COMMENT '总结算金额',
    `once`	          	int(11) 		DEFAULT '0' 				COMMENT '结算次数',
    `recordlist`		text     		DEFAULT NULL   				COMMENT '关联订单ID',
    `createtime` 		datetime 	    DEFAULT NULL 		        COMMENT '创建时间', 
    `exposetime` 		datetime 	    DEFAULT NULL 		        COMMENT '最新的清算时间', 
    `rowid`	            varchar(512)    DEFAULT '' 			     	COMMENT 'ROWID',
    PRIMARY KEY (`id`), 
    UNIQUE KEY `unique-salerid` (`salerid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='分销员结算数据 ';


-- 分销员结算数据历史  --
DROP TABLE IF EXISTS weixin_blog_saler_balance_history;
CREATE TABLE weixin_blog_saler_balance_history (
    `id`		  	 	int(11)      	NOT NULL  AUTO_INCREMENT    COMMENT 'id',
    `salerid`		    int(11) 		DEFAULT '0' 				COMMENT '销售员ID，对应user表ID',
    `salername`     	varchar(512) 	DEFAULT ''                  COMMENT '销售员名称',
    `money`         	varchar(512) 	DEFAULT ''                  COMMENT '结算金额',
    `money_`            varchar(512)    DEFAULT '' 			   	    COMMENT '总结算金额',
    `once`	          	int(11) 		DEFAULT '0' 				COMMENT '结算次数',
    `recordlist`		text     		DEFAULT NULL   				COMMENT '关联订单ID',
    `createtime` 		datetime 	    DEFAULT NULL 		        COMMENT '创建时间', 
    `exposetime` 		datetime 	    DEFAULT NULL 		        COMMENT '最新的清算时间', 
    `rowid`	            varchar(512)    DEFAULT '' 			     	COMMENT 'ROWID',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='分销员结算数据历史 ';



-- 基本数据销售走势  --
DROP TABLE IF EXISTS weixin_blog_saler_report_base;
CREATE TABLE weixin_blog_saler_report_base (
    `id`		  	 	int(11)      	NOT NULL  AUTO_INCREMENT    COMMENT 'id',
    `money`           	varchar(512) 	DEFAULT ''                  COMMENT '每日分销的总金额',
    `count`	        	int(11) 		DEFAULT '0' 				COMMENT '每日分销笔数',
    `createtime` 		date 	        DEFAULT NULL 		        COMMENT '创建时间', 
    `rowid`	            varchar(512)    DEFAULT '' 			     	COMMENT 'ROWID',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='基本数据销售走势  ';




-- 分销员每日销售走势  --
DROP TABLE IF EXISTS weixin_blog_saler_report_day;
CREATE TABLE weixin_blog_saler_report_day (
    `id`		  	 	int(11)      	NOT NULL  AUTO_INCREMENT    COMMENT 'id',
    `salerid`		    int(11) 		DEFAULT '0' 				COMMENT '销售员ID，对应user表ID',
    `salername`     	varchar(512) 	DEFAULT ''                  COMMENT '销售员名称',
    `money`           	varchar(512) 	DEFAULT ''                  COMMENT '每日分销的总金额',
    `count`	        	int(11) 		DEFAULT '0' 				COMMENT '每日分销笔数', 
    `createtime` 		datetime 	    DEFAULT NULL 		        COMMENT '创建时间', 
    `rowid`	            varchar(512)    DEFAULT '' 			     	COMMENT 'ROWID',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='分销员每日销售走势';

 
 
-- 线下课程 --
DROP TABLE IF EXISTS `weixin_blog_teacher_course_line`;
CREATE TABLE `weixin_blog_teacher_course_line` (
  `id` 					int(11) 		NOT NULL AUTO_INCREMENT 				COMMENT 'id自增',
  `cname` 				varchar(256) 	CHARACTER SET  							COMMENT '课程名称',
  `remark` 				varchar(1024) 	CHARACTER SET  							COMMENT '课程简介',
  `content` 			longtext 		CHARACTER SET 							COMMENT '课程详细介绍',
  `icon` 				varchar(128) 	DEFAULT '' 								COMMENT '课程LOGO',
  `buycount` 			int(11) 		DEFAULT '0' 							COMMENT '购买次数',
  `createtime` 			datetime 		DEFAULT NULL 							COMMENT '创建时间',
  `enroltime_start` 	datetime 		DEFAULT NULL 							COMMENT '报名开始时间',
  `enroltime_end` 		datetime 		DEFAULT NULL 							COMMENT '报名结束时间',
  `coursetime_start` 	datetime 		DEFAULT NULL 							COMMENT '课程开始时间',
  `coursetime_end` 		datetime 		DEFAULT NULL 							COMMENT '课程结束时间',
  `uid` 				int(10) 		DEFAULT '0' 							COMMENT '课程老师ID',
  `money` 				varchar(256) 	DEFAULT '0' 							COMMENT '课程价格',
  `pers` 				int(11) 		DEFAULT '0' 							COMMENT '限定上课人数',
  `taglist` 			varchar(256) 	DEFAULT '' 								COMMENT '课程标签，多个，号分割',
  `specialid` 			varchar(256) 	DEFAULT '' 								COMMENT '一级分类id，逗号间隔',
  `specialid2` 			varchar(256) 	DEFAULT '' 								COMMENT '二级分类id，逗号间隔',
  `status` 				int(1) 			DEFAULT '2' 							COMMENT '课程状态 0：正常 1：已下架，2待上架',
  `belong` 				int(1) 			DEFAULT '0' 							COMMENT '课程归属 0：老师 1：平台',
  `address` 			varchar(256) 	DEFAULT '' 								COMMENT '活动地址',
  `followcount` 		int(11) 		DEFAULT '0' 							COMMENT '收藏数',
  `consumer` 			varchar(256) 	DEFAULT '' 								COMMENT '适合人群',
  `istop` 				int(1) 			DEFAULT '0' 							COMMENT '是否置顶：0否 1是',
  `toptime` 			datetime 		DEFAULT NULL 							COMMENT '置顶时间',
  `fcbl`                varchar(128)    DEFAULT ''                              COMMENT '课程分成比例 5/2/3，平台/老师/分销',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=348 DEFAULT CHARSET=utf8 COMMENT='线下课程管理'


-- 线下课程价格表 --
DROP TABLE IF EXISTS `weixin_blog_teacher_course_line_money`;
CREATE TABLE `weixin_blog_teacher_course_line_money` (
	  `id` 					int(11) 		NOT NULL  AUTO_INCREMENT 	COMMENT 'id自增',
	  `cname` 				varchar(256) 	CHARACTER SET utf8mb4 		COLLATE utf8mb4_unicode_ci 	DEFAULT '' 	COMMENT '价格介绍',
	  `cid` 				int(10) 		DEFAULT '0' 				COMMENT '线下课程ID',
	  `createtime` 			datetime 		DEFAULT NULL 				COMMENT '创建时间',
	  `money` 				varchar(256) 	DEFAULT '0' 				COMMENT '课程价格',
	  `maxsales` 			int(11) 		DEFAULT '0' 				COMMENT '限量：0：不限量',
	  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='线下课程价格'


-- 线下课程报名用户 --
DROP TABLE IF EXISTS `weixin_blog_teacher_course_line_buyer`;
CREATE TABLE `weixin_blog_teacher_course_line_buyer` (
	  `id` 					int(11) 		NOT NULL 					AUTO_INCREMENT 								COMMENT 'id自增',
	  `cid` 				int(10) 		DEFAULT '0' 															COMMENT '课程ID',
	  `cname` 				varchar(1024) 	CHARACTER SET utf8mb4 		COLLATE utf8mb4_unicode_ci 		DEFAULT '' 	COMMENT '课程名称',
	  `uid` 				int(10) 		DEFAULT '0' 				COMMENT '报名用户ID',
	  `tid` 				int(10) 		DEFAULT '0' 				COMMENT '老师ID',
	  `mid` 				int(10) 		DEFAULT '0' 				COMMENT '子套餐id',
	  `money` 				int(10) 		DEFAULT '0' 				COMMENT '报名价格',
	  `createtime` 			datetime 		DEFAULT NULL 				COMMENT '报名时间',
	  `type` 				int(1) 			DEFAULT '0' 				COMMENT '付费类型 0：问答 1：课程',
	  `wxid` 				varchar(64) 	DEFAULT '' 					COMMENT '付费用户wxid',
	  `twxid` 				varchar(64) 	DEFAULT '' 					COMMENT '老师的wxid',
	  `phone` 				varchar(512) 	DEFAULT '' 					COMMENT '报名用户电话',
	  `realname` 			varchar(512) 	DEFAULT '' 					COMMENT '用户真实姓名',
	  PRIMARY KEY (`id`)
	) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='线下课程报名用户'
	
-- 用户专属奖励 --
DROP TABLE IF EXISTS `weixin_blog_user_exclusive_award`;
CREATE TABLE `weixin_blog_user_exclusive_award` (
  `id` 					int(11) 		NOT NULL AUTO_INCREMENT 	COMMENT 'id自增',
  `cid` 				int(11) 		DEFAULT '0' 				COMMENT '课程ID',
  `wid` 				int(11) 		DEFAULT '0' 				COMMENT '用户ID',
  `createtime` 			datetime 		DEFAULT NULL 				COMMENT '创建时间',
  `awardres` 			varchar(128) 	DEFAULT '0' 				COMMENT '奖励原因',
  `ctype` 				int(1) 			DEFAULT '0' 				COMMENT '奖品类型:1课程，2',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户专属奖励 '
		
	

-- 此次要发送的消息列表 --
DROP TABLE IF EXISTS `weixin_blog_user_notice`;
CREATE TABLE `weixin_blog_user_notice` (
  `id` 					int(11) 		NOT NULL AUTO_INCREMENT 	COMMENT 'id自增',
  `cid` 				int(11) 		DEFAULT '0' 				COMMENT '课程ID',
  `wxid` 		    	varchar(128) 	DEFAULT '0' 				COMMENT '微信ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='此次要发送的消息列表'


-- 搜索热词列表 --
DROP TABLE IF EXISTS `weixin_blog_user_search`;
CREATE TABLE `weixin_blog_user_search` (
  `id` 					int(11) 			NOT NULL AUTO_INCREMENT 	COMMENT 'id自增',
  `sname` 				varchar(128) 		DEFAULT '0' 				COMMENT '搜索词',
  `number` 		    	int(11) 			DEFAULT '0' 				COMMENT '搜索次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='搜索热词列表'
		

-- 直播管理 --
DROP TABLE IF EXISTS `weixin_blog_zhibo`;
CREATE TABLE `weixin_blog_zhibo` (
  `id` 			int(11) 		NOT NULL 											AUTO_INCREMENT 	COMMENT 'id自增',
  `cname` 		varchar(256) 	CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci 	DEFAULT '' 		COMMENT '直播名称',
  `remark` 		varchar(1024) 	CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci 	DEFAULT '' 		COMMENT '直播简介',
  `content` 	longtext 		CHARACTER SET utf8mb4 												COMMENT '直播详情',
  `logo` 		varchar(128) 														DEFAULT '' 		COMMENT '直播LOGO',
  `buycount` 	int(11) 															DEFAULT '0' 	COMMENT '报名人数',
  `createtime` 	datetime 															DEFAULT NULL 	COMMENT '创建时间',
  `starttime` 	datetime 															DEFAULT NULL 	COMMENT '开始时间',
  `endtime` 	datetime 															DEFAULT NULL	COMMENT '结束时间',
  `money` 		varchar(256) 														DEFAULT '0' 	COMMENT '价格',
  `fcbl` 		varchar(128) 														DEFAULT '' 		COMMENT '适合人群',
  `consumer` 	varchar(256) 														DEFAULT '' 		COMMENT '分成比例： 平台/老师/分销商',
  `ctype` 		int(1) 																DEFAULT '0' 	COMMENT '类型 0：音频1：视频',
  `status` 		int(1) 																DEFAULT '0' 	COMMENT '直播状态 0：未开始 1：直播中 2：已结束',
  `istop` 		int(1) 																DEFAULT '0' 	COMMENT '是否置顶 0：否 1：是',
  `toptime` 	datetime 															DEFAULT NULL 	COMMENT '置顶时间',
  PRIMARY KEY (`id`),
  KEY `index_money` (`money`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='直播管理';

-- 直播子目录 --
DROP TABLE IF EXISTS `weixin_blog_zhibo_item`;
CREATE TABLE `weixin_blog_zhibo_item` (
  `id`            	int(11) 		NOT NULL AUTO_INCREMENT 										COMMENT 'id自增',
  `name`          	varchar(256) 	DEFAULT '' 														COMMENT '子名称',
  `remark` 			varchar(1024) 	CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci 	DEFAULT '' 	COMMENT '子直播简介',
  `logo` 			varchar(128) 	DEFAULT '' 														COMMENT '子直播LOGO',
  `zid` 			int(11) 		DEFAULT '0' 													COMMENT '直播ID',
  `type` 			int(11) 		DEFAULT '0' 													COMMENT '课程内容形式  1：文字  2:图片 3：录音 4：视频',
  `people` 			int(11) 		DEFAULT '0' 													COMMENT '观看人数',
  `playnum` 		int(11) 		DEFAULT '0' 													COMMENT '播放次数',
  `status` 			int(1) 			DEFAULT '0' 													COMMENT '直播状态 0：未开始 1：直播中 2：已结束',
  `createtime` 		datetime 		DEFAULT NULL 													COMMENT '创建时间',
  `starttime` 		datetime 		DEFAULT NULL 													COMMENT '开始时间',
  `endtime` 		datetime 		DEFAULT NULL													COMMENT '结束时间',
  `filepath` 		varchar(256) 	DEFAULT '' 														COMMENT '文件地址',
  `sort` 			int(11) 		DEFAULT '0' 													COMMENT '前台显示序号，显示序号，越小越靠前',
  `tid` 			int(11) 		DEFAULT '0' 													COMMENT '老师ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=728 DEFAULT CHARSET=utf8 COMMENT='子直播管理 ';


-- 分销订单退款表  --
DROP TABLE IF EXISTS `weixin_blog_distributor_signup_return`;
CREATE TABLE `weixin_blog_distributor_signup_return` (
  `id` 				int(11) 		NOT NULL 	AUTO_INCREMENT 		COMMENT 'id',
  `cname` 			varchar(256) 	DEFAULT '' 						COMMENT '报名用户名称',
  `createtime` 		datetime 		DEFAULT NULL 					COMMENT '创建时间',
  `mobile` 			varchar(256) 	DEFAULT '' 						COMMENT '手机号',
  `remark` 			varchar(256) 	DEFAULT '' 						COMMENT '报名用户信息',
  `money` 			varchar(256) 	DEFAULT '' 						COMMENT '报名费用',
  `wid` 			int(11) 		DEFAULT '0' 					COMMENT '报名用户ID',
  `wxid` 			varchar(256) 	DEFAULT '' 						COMMENT '报名用户WXID',
  `did` 			int(11) 		DEFAULT '0' 					COMMENT '经销商ID',
  `mid` 			int(11) 		DEFAULT '0' 					COMMENT '后台用户ID',
  `dname` 			varchar(256) 	DEFAULT '' 						COMMENT '经销商姓名',
  `fcbl` 			varchar(256) 	DEFAULT '' 						COMMENT '分成比例，相加必须为10',
  `refund` 			int(1) 			DEFAULT '0' 					COMMENT '是否退款 0：正常  1：退款',
  `ccname` 			varchar(256) 	DEFAULT '' 						COMMENT '课程名称',
  `dmoney` 			varchar(512) 	DEFAULT '0' 					COMMENT '经销商金额',
  `pmoney` 			varchar(512) 	DEFAULT '0' 					COMMENT '平台金额',
  `ordernumber` 	varchar(64) 	NOT NULL 	DEFAULT '' 			COMMENT '微信支付流水号',
  `del` 			int(1) 			DEFAULT '0' 					COMMENT '删除 0：正常，1：删除',
  `acttype` 		int(11) 		DEFAULT '0' 					COMMENT '活动类型',
  `disregister` 	int(1) 			DEFAULT '0' 					COMMENT '是否注册 0：没注册，1：注册',
  `unionid` 		varchar(128) 	DEFAULT '' 						COMMENT 'unionid',
  `tradestate` 		varchar(20)	 	DEFAULT '' 						COMMENT '支付返回code',
  `wxordernum` 		varchar(128)	DEFAULT '' 						COMMENT '微信支付订单号',
  `checked` 		int(1) 			DEFAULT '0' 					COMMENT '是否检查：0未检查，1已检查',
  `occupation` 		varchar(128) 	DEFAULT '' 						COMMENT '职业',
  `loggerid` 		int(11) 		DEFAULT '0' 					COMMENT '日志ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ordernumber` (`ordernumber`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='分销订单退款表'

-- 分销订单未付款表  --
DROP TABLE IF EXISTS `weixin_blog_distributor_signup_nopay`;
CREATE TABLE `weixin_blog_distributor_signup_nopay` (
  `id` 				int(11) 		NOT NULL 	AUTO_INCREMENT 		COMMENT 'id',
  `cname` 			varchar(256) 	DEFAULT '' 						COMMENT '报名用户名称',
  `createtime` 		datetime 		DEFAULT NULL 					COMMENT '创建时间',
  `mobile` 			varchar(256) 	DEFAULT '' 						COMMENT '手机号',
  `remark` 			varchar(256) 	DEFAULT '' 						COMMENT '报名用户信息',
  `money` 			varchar(256) 	DEFAULT '' 						COMMENT '报名费用',
  `wid` 			int(11) 		DEFAULT '0' 					COMMENT '报名用户ID',
  `wxid` 			varchar(256) 	DEFAULT '' 						COMMENT '报名用户WXID',
  `did` 			int(11) 		DEFAULT '0' 					COMMENT '经销商ID',
  `mid` 			int(11) 		DEFAULT '0' 					COMMENT '后台用户ID',
  `dname` 			varchar(256) 	DEFAULT '' 						COMMENT '经销商姓名',
  `fcbl` 			varchar(256) 	DEFAULT '' 						COMMENT '分成比例，相加必须为10',
  `refund` 			int(1) 			DEFAULT '0' 					COMMENT '是否退款 0：正常  1：退款',
  `ccname` 			varchar(256) 	DEFAULT '' 						COMMENT '课程名称',
  `dmoney` 			varchar(512) 	DEFAULT '0' 					COMMENT '经销商金额',
  `pmoney` 			varchar(512) 	DEFAULT '0' 					COMMENT '平台金额',
  `ordernumber` 	varchar(64) 	NOT NULL 	DEFAULT '' 			COMMENT '微信支付流水号',
  `del` 			int(1) 			DEFAULT '0' 					COMMENT '删除 0：正常，1：删除',
  `acttype` 		int(11) 		DEFAULT '0' 					COMMENT '活动类型',
  `disregister` 	int(1) 			DEFAULT '0' 					COMMENT '是否注册 0：没注册，1：注册',
  `unionid` 		varchar(128) 	DEFAULT '' 						COMMENT 'unionid',
  `tradestate` 		varchar(20)	 	DEFAULT '' 						COMMENT '支付返回code',
  `wxordernum` 		varchar(128)	DEFAULT '' 						COMMENT '微信支付订单号',
  `checked` 		int(1) 			DEFAULT '0' 					COMMENT '是否检查：0未检查，1已检查',
  `occupation` 		varchar(128) 	DEFAULT '' 						COMMENT '职业',
  `loggerid` 		int(11) 		DEFAULT '0' 					COMMENT '日志ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ordernumber` (`ordernumber`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='分销订单未付款表'

-- 已结经销商表  --
DROP TABLE IF EXISTS `weixin_blog_distributor_payment`;
CREATE TABLE `weixin_blog_distributor_payment` (
  `id` 				int(11) 		NOT NULL 		AUTO_INCREMENT 		COMMENT 'id',
  `cname` 			varchar(256) 	DEFAULT '' 		COMMENT '经销商名称',
  `mobile` 			varchar(256) 	DEFAULT '' 		COMMENT '经销商手机号',
  `salecount` 		int(11) 		DEFAULT '0' 	COMMENT '售卖数量',
  `money` 			varchar(256) 	DEFAULT '' 		COMMENT '结款金额',
  `wid` 			int(11) 		DEFAULT '0' 	COMMENT '经销商ID',
  `wxid` 			varchar(256) 	DEFAULT '' 		COMMENT '经销商WXID',
  `saleid` 			int(11) 		DEFAULT '0' 	COMMENT '渠道负责人id',
  `salename` 		varchar(100) 	DEFAULT '0' 	COMMENT '渠道负责人姓名',
  `createtime` 		datetime 		DEFAULT NULL 	COMMENT '创建时间',
  `acttype` 		int(11) 		DEFAULT '0' 	COMMENT '活动类型',
  `actname` 		varchar(128) 	DEFAULT '' 		COMMENT '活动名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='已结经销商表'
	
	