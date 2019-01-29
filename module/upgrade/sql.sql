-- phpMyAdmin SQL Dump
-- version 2.11.9.4
-- http://www.phpmyadmin.net
--
-- ����: mysql.baze.lleo.aha.ru:64256
-- ����� ��������: ��� 19 2010 �., 11:06
-- ������ �������: 5.0.87
-- ������ PHP: 5.1.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- ���� ������: `lleoblog`
--

-- --------------------------------------------------------

--
-- ��������� ������� `mailbox`
--

CREATE TABLE IF NOT EXISTS `mailbox` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `answerid` int(10) unsigned NOT NULL COMMENT '����� ��',
  `unicfrom` int(10) unsigned NOT NULL COMMENT 'id �����������',
  `unicto` int(10) unsigned NOT NULL COMMENT 'id ����������',
  `timecreate` int(11) unsigned NOT NULL default '0' COMMENT '����� ��������',
  `timeview` int(11) unsigned NOT NULL default '0' COMMENT '����� ������� ���������',
  `timeread` int(11) unsigned NOT NULL default '0' COMMENT '����� ������������� ���������',
  `text` text NOT NULL COMMENT '����� ������',
  `IPN` int(10) unsigned NOT NULL COMMENT 'IP � �����',
  `BRO` varchar(1024) NOT NULL COMMENT '������� ���-���� �������?',
  `whois` varchar(128) NOT NULL COMMENT '����������� ������',
  PRIMARY KEY  (`id`),
  KEY `new` (`unicto`,`timeread`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 COMMENT='����� �����������' AUTO_INCREMENT=0 ;

----------------------------------------------------------
--
-- ��������� ������� `socialmedias`
--
CREATE TABLE IF NOT EXISTS `socialmedias` (
  `i` int(10) unsigned NOT NULL auto_increment COMMENT '����� ������',
  `acn` int(10) unsigned NOT NULL COMMENT '����� �������',
  `num` int(10) unsigned NOT NULL COMMENT '����� �������',
  `net` varchar(64) NOT NULL COMMENT '�������:����',
  `url` varchar(128) NOT NULL COMMENT 'url �������, ������������ � ������� - url �����, ��� �������, data �������',
  `cap_sha1` varchar(40) NOT NULL COMMENT 'sha1-��� ������� ��� ������������ ���������',
  `id` varchar(256) NOT NULL COMMENT '���������� id',
  `type` enum('post','vk_album','vk_foto','vk_note','fb_album','fb_foto','ya_album','ya_foto','instagramm_foto') NOT NULL COMMENT '��� ���������',
  PRIMARY KEY (`i`),
    KEY `new` (`acn`,`num`,`net`(64)),
    KEY `url` (`url`),
    KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='���� �������� ������� ���������';

--   KEY `id` (`id`),

----------------------------------------------------------
--
-- ��������� ������� `socialmedia`
--
--CREATE TABLE IF NOT EXISTS `socialmedia` (
--  `acn` int(10) unsigned NOT NULL COMMENT '����� �������',
--  `num` int(10) unsigned NOT NULL COMMENT '����� �������',
--  `net` varchar(64) NOT NULL COMMENT '�������� �������, ���� ��� �������',
--  `url` varchar(256) NOT NULL COMMENT '������������� ����� � ������� (url)',
--  PRIMARY KEY (`acn`,`num`,`net`(64))
--) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='���� ������� ���������';
--
--    `from` int(10) unsigned NOT NULL COMMENT '������ IP-���������',
--    `to` int(10) unsigned NOT NULL COMMENT '����� IP-���������',
--
----------------------------------------------------------
--
-- ��������� ������� `geoip`
--
CREATE TABLE IF NOT EXISTS `geoip` (
    `from` VARBINARY(16) NOT NULL COMMENT '������ IP-���������',
    `to` VARBINARY(16) NOT NULL COMMENT '����� IP-���������',
    `i` int(10) unsigned NOT NULL COMMENT '������������� ���������� � geoipd',
  PRIMARY KEY (`from`),
  KEY `to` (`to`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='���� IP-������� ����';

----------------------------------------------------------
--
-- ��������� ������� `geoipd`
--
CREATE TABLE IF NOT EXISTS `geoipd` (
    `i` int(10) unsigned NOT NULL auto_increment COMMENT '����� ������',
    `country` char(5) NOT NULL COMMENT '��� ������',
    `city` varchar(160) NOT NULL COMMENT '�����',
    PRIMARY KEY (`i`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='���������� ��� geoip';

----------------------------------------------------------
--
-- ��������� ������� `golosovalka`
--
CREATE TABLE IF NOT EXISTS `golosovalka` (
  `unic` int(10) unsigned NOT NULL COMMENT 'id �����������',
  `acn` int(10) unsigned NOT NULL COMMENT 'id �������',
  `gid` int(10) unsigned NOT NULL default '0' COMMENT 'id ������',
  `vid` tinyint(3) unsigned NOT NULL COMMENT '����� �������',
  `vad` tinyint(3) unsigned NOT NULL COMMENT '������� ������',
  PRIMARY KEY  (`unic`,`acn`,`gid`,`vid`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='�����������';


----------------------------------------------------------
--
-- ��������� ������� `userdata`
--
CREATE TABLE IF NOT EXISTS `userdata` (
  `acn` int(10) unsigned NOT NULL auto_increment COMMENT '����� �������',
  `basa` varchar(32) NOT NULL COMMENT '����',
  `name` varchar(32) NOT NULL COMMENT '���',
  `data` text NOT NULL COMMENT '������',
  `dostup` enum('all','adm') NOT NULL default 'adm' COMMENT '������: ������ ��� ����',
  PRIMARY KEY (`acn`,`basa`(32),`name`(32)),
  KEY `key` (`acn`,`basa`(32))
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='���������������� ������';

----------------------------------------------------------
--
-- ��������� ������� `unic`
--
CREATE TABLE IF NOT EXISTS `unic` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT '������ ����� �� ����',
  `realname` varchar(64) NOT NULL COMMENT '���/��� (��������������� ���-�������)',
  `openid` varchar(128) NOT NULL COMMENT 'inf-url',
  `login` varchar(32) NOT NULL,
    `teddyid` int(11) NOT NULL default '0' COMMENT '��������� ����� https://teddyid.com',
  `password` varchar(32) NOT NULL,
  `mail` varchar(64) NOT NULL COMMENT 'mail ��� ����������� - ������ ������� �������',
  `mailw` varchar(64) NOT NULL COMMENT '����������� mail (���������� ���������)',
  `tel` varchar(16) NOT NULL COMMENT '��������� ��� ����������� - ������ ������� �������',
  `telw` varchar(16) NOT NULL COMMENT '����������� ��������� (���������� ���������)',
  `img` varchar(180) NOT NULL COMMENT '������ �� �����.jpg',
  `mail_comment` enum('1','0') NOT NULL default '1' COMMENT '������: ���������� �� ����������� �� email?',
  `site` varchar(128) NOT NULL,
  `birth` date NOT NULL COMMENT '������: ���� ��������',
  `admin` enum('user','podzamok') NOT NULL,
  `ipn` int(10) unsigned NOT NULL COMMENT 'ip ��� ��������� �������������� ������ ��������',
  `time_reg` int(11) NOT NULL default '0' COMMENT '����� �����������',
  `timelast` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT '����� ���������� ���������� ������ ��������',
  `capcha` enum('yes','no') NOT NULL default 'no',
  `capchakarma` tinyint(3) unsigned NOT NULL default '0' COMMENT '�����-����� ������ �������',
  `opt` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 COMMENT='������ �����������' AUTO_INCREMENT=0 ;
--   `login` varchar(64) NOT NULL COMMENT 'vasya ���� vasya@openid.site',
--   `password` varchar(32) NOT NULL,
--   `realname` varchar(128) NOT NULL COMMENT '������: ���',
--   `aboutme` varchar(2048) NOT NULL COMMENT '������: � ����',

--
-- ��������� ������� `jur`
--
CREATE TABLE IF NOT EXISTS `jur` (
  `acn` int(10) unsigned NOT NULL COMMENT '����� �������',
  `acc` varchar(32) NOT NULL COMMENT '��� �������',
  `unic` int(10) unsigned NOT NULL COMMENT '��������',
  `time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT '����� ���������� ���������� �������',
   PRIMARY KEY (`acn`,`unic`),
   KEY `acc` (`acc`(32))
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='���� ��������' AUTO_INCREMENT=0 ;


--
-- ��������� ������� `unijur`
--
-- CREATE TABLE IF NOT EXISTS `unijur` (
--   `jur` int(10) unsigned NOT NULL COMMENT '����� �������',
--   `uni` int(10) unsigned NOT NULL COMMENT '����� unic ������������',
--   `capchakarma` tinyint(3) unsigned NOT NULL default '0' COMMENT '�����-�����',
--   `dostup` enum('user','podzamok','mudak','writer','admin') NOT NULL,
--   `abouthim` varchar(2048) NOT NULL COMMENT '� ���',
--    PRIMARY KEY (`jur`,`uni`)
-- ) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='��������� ����������� ��� ������ �������' AUTO_INCREMENT=0 ;


-- --------------------------------------------------------

--
-- ��������� ������� `dnevnik_comm`
--

CREATE TABLE IF NOT EXISTS `dnevnik_comm` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `unic` int(10) unsigned NOT NULL COMMENT 'id ������',
  `DateID` int(10) NOT NULL COMMENT '� ����� ������� ���������',
  `Name` varchar(128) NOT NULL COMMENT '�����',
  `Mail` varchar(128) NOT NULL COMMENT 'email',
  `Text` text NOT NULL COMMENT '����� �����������',
  `Parent` int(10) unsigned NOT NULL default '0' COMMENT '�� ��� �����',
  `Time` int(11) unsigned NOT NULL default '0' COMMENT '����� �����������',
  `IPN` int(10) unsigned NOT NULL COMMENT 'IP � �����',
  `BRO` varchar(1024) NOT NULL COMMENT '������� ���-���� �������?',
  `whois` varchar(128) NOT NULL COMMENT '����������� ������',
  `scr` enum('1','0') NOT NULL default '0' COMMENT '��������, �������',
  `rul` enum('1','0') NOT NULL default '0' COMMENT '������',
  `ans` enum('1','0','u') NOT NULL default 'u' COMMENT '��������� �� ��������� ����������� � ����?',
  `group` tinyint(3) unsigned NOT NULL COMMENT '������ ��� ��������� ������ ������. 0 - ���, 1 - �����, 2... ��, ��������, Topbot',
  `golos_plu` int(10) unsigned NOT NULL default '0' COMMENT '����������� �������',
  `golos_min` int(10) unsigned NOT NULL default '0' COMMENT '����������� ��������',
  PRIMARY KEY  (`id`),
  KEY `DateID` (`DateID`),
  KEY `poset` (`unic`,`scr`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 COMMENT='����������� �����������' AUTO_INCREMENT=0 ;

-- --------------------------------------------------------
-- ��������� ������� `yablogs_count`
--

CREATE TABLE IF NOT EXISTS `yablogs_count` (
  `num` int(10) NOT NULL,
  `count` int(10) NOT NULL,
  `time` int(11) unsigned NOT NULL default '0' COMMENT '����� ���������� ����������',
  PRIMARY KEY (`num`),
  KEY `timeupdate` (`time`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 COMMENT='������ �� ������� �� �������' AUTO_INCREMENT=0 ;
-- --------------------------------------------------------

-- ��������� ������� `dnevnik_link`
--

CREATE TABLE IF NOT EXISTS `dnevnik_link` (
  `n` bigint(20) NOT NULL auto_increment,
  `link` varchar(2048) NOT NULL,
  `count` int(10) NOT NULL,
  `datetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `DateID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`n`),
  KEY `DateID` (`DateID`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 COMMENT='������ �� �������' AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

--
-- ��������� ������� `dnevnik_plusiki`
--

CREATE TABLE IF NOT EXISTS `dnevnik_plusiki` (
  `unic` int(10) unsigned NOT NULL,
  `commentID` int(10) unsigned NOT NULL,
  `var` enum('plus','minus') NOT NULL,
  PRIMARY KEY  (`unic`,`commentID`),
  KEY `url` (`commentID`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

-- --------------------------------------------------------

--
-- ��������� ������� `dnevnik_posetil`
--

CREATE TABLE IF NOT EXISTS `dnevnik_posetil` (
  `unic` int(10) unsigned NOT NULL,
  `url` int(10) unsigned NOT NULL,
  `date` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`unic`,`url`),
  KEY `url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

-- --------------------------------------------------------

--
-- ��������� ������� `dnevnik_search`
--

CREATE TABLE IF NOT EXISTS `dnevnik_search` (
  `n` bigint(20) NOT NULL auto_increment,
  `poiskovik` varchar(32) NOT NULL,
  `link` varchar(2048) NOT NULL,
  `search` varchar(2048) NOT NULL,
  `count` int(10) NOT NULL,
  `datetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `DateID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`n`),
  KEY `link` (`link`(1000))
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 COMMENT='��������� ������' AUTO_INCREMENT=0 ;

-- --------------------------------------------------------
--
-- ��������� ������� `dnevnik_zapisi`

CREATE TABLE IF NOT EXISTS `dnevnik_zapisi` (
  `Date` varchar(128) NOT NULL,
  `Header` varchar(255) NOT NULL default '',
  `Body` mediumtext NOT NULL,
  `Access` enum('all','podzamok','admin') NOT NULL default 'admin',
  `visible` enum('1','0') NOT NULL default '1',
  `DateUpdate` int(10) unsigned NOT NULL default '0',
  `view_counter` int(10) unsigned NOT NULL default '0',
  `num` int(10) unsigned NOT NULL auto_increment,
  `DateDatetime` int(11) NOT NULL default '0',
  `DateDate` int(11) NOT NULL default '0',
  `opt` text NOT NULL,
  `acn` int(10) unsigned NOT NULL default '0' COMMENT '����� �������',
  UNIQUE KEY `num` (`num`),
  KEY `acn` (`acn`),
  KEY `Date` (`Date`(128)),
  KEY `Access` (`Access`),
  KEY `DateDatetime` (`DateDatetime`),
  KEY `DateDate` (`DateDate`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 COMMENT='������� �����' AUTO_INCREMENT=0 ;

-- --------------------------------------------------------
--
-- ��������� ������� `dnevnik_autopost`

CREATE TABLE IF NOT EXISTS `dnevnik_autopost` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `Header` varchar(255) NOT NULL default '',
  `Body` mediumtext NOT NULL,
  `tag` varchar(64) NOT NULL default '',
  `postmode` enum('is_date','silent','silent_priority','day','tag_interval') NOT NULL,
  `randmode` enum('num','random') NOT NULL,
  `dat` int(11) NOT NULL default '0',
  `opt` text NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `dat` (`dat`),
  KEY `postmode` (`postmode`),
  KEY `randmode` (`randmode`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 COMMENT='��� ������������' AUTO_INCREMENT=0 ;

-- --------------------------------------------------------
--
--  `sc` varchar(32) NOT NULL,
--  `login` varchar(128) NOT NULL,
--  `ipbro` varchar(255) NOT NULL,
--  `lju` varchar(128) NOT NULL,
--  `Name` varchar(255) NOT NULL,
--  `Mail` varchar(255) NOT NULL,
--
-- ��������� ������� `pravki`
--

CREATE TABLE IF NOT EXISTS `pravki` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `Date` varchar(255) NOT NULL,
  `DateTime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `acn` int(10) unsigned NOT NULL default '0' COMMENT '����� �������',
  `unic` int(10) unsigned NOT NULL,
  `text` text NOT NULL,
  `textnew` text NOT NULL,
  `stdprav` text NOT NULL,
  `Answer` text NOT NULL,
  `metka` enum('new','submit','discard') NOT NULL default 'new',
  PRIMARY KEY  (`id`),
  KEY `Date` (`Date`(255)),
  KEY `metka` (`metka`),
  KEY `unic` (`unic`),
  KEY `acn` (`acn`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 COMMENT='������ �����' AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

--
-- ��������� ������� `rekomenda`
--
--   `acn` int(10) unsigned NOT NULL default '0' COMMENT '����� �������', �������� acn!!!

CREATE TABLE IF NOT EXISTS `rekomenda` (
  `n` int(10) NOT NULL auto_increment,
  `datetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `link` varchar(2048) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`n`),
  KEY `datetime` (`datetime`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 COMMENT='������� ������ ���' AUTO_INCREMENT=0 ;

-- --------------------------------------------------------

--
-- ��������� ������� `site`
--
-- `Access` enum('all','podzamok','admin') NOT NULL default 'admin' COMMENT '��������� �������',
-- `type` enum('page','design','news','pageplain','photo') NOT NULL default 'page',
-- `id` int(10) unsigned NOT NULL auto_increment,
-- KEY `type` (`type`)

CREATE TABLE IF NOT EXISTS `site` (
  `name` varchar(128) NOT NULL,
  `text` text NOT NULL,
  `acn` int(10) unsigned NOT NULL default '0' COMMENT '����� �������',
  PRIMARY KEY (`acn`,`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 COMMENT='������� �����' AUTO_INCREMENT=0 ;


-- --------------------------------------------------------
--
-- ��������� ������� `unictemp`
--

CREATE TABLE IF NOT EXISTS `unictemp` (
  `unic` int(10) unsigned NOT NULL,
  `text` text NOT NULL,
  `timelast` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`unic`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='��������� ������ ������������';


-- --------------------------------------------------------
--
-- ��������� ������� `golosovanie_golosa`
--
CREATE TABLE IF NOT EXISTS `golosovanie_golosa` (
  `golosid` int(10) unsigned NOT NULL COMMENT 'id �����������',
  `unic` int(10) unsigned NOT NULL COMMENT 'id �����������',
  `time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `value` text NOT NULL,
  PRIMARY KEY  (`golosid`,`unic`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='�����������: ������';

-- --------------------------------------------------------
--
-- ��������� ������� `golosovanie_result`
--
CREATE TABLE IF NOT EXISTS `golosovanie_result` (
  `golosid` int(10) unsigned NOT NULL auto_increment COMMENT 'id �����������',
  `golosname` varchar(32) NOT NULL COMMENT '��� �����������',
  `n` int(10) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`golosid`),
  KEY `golosname` (`golosname`(32))
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='�����������: ����������';


-- --------------------------------------------------------
--
-- ��������� ������� `dnevnik_tags`
--
-- ,`tag`(128)

CREATE TABLE IF NOT EXISTS `dnevnik_tags` (
  `num` int(10) unsigned NOT NULL COMMENT 'id �������',
  `tag` varchar(128) NOT NULL COMMENT '��� ����',
  `acn` int(10) unsigned NOT NULL default '0' COMMENT '����� �������',
  KEY `num` (`num`),
  KEY `acn` (`acn`),
  KEY `tag` (`tag`(128))
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;


-- --------------------------------------------------------
--
-- ��������� ������� `lastcomm`
--

CREATE TABLE IF NOT EXISTS `lastcomm` (
  `unic` int(10) unsigned NOT NULL,
  `acn` int(10) unsigned NOT NULL default '0' COMMENT '����� �������',
  `time` int(11) NOT NULL default '0',
  PRIMARY KEY (`unic`,`acn`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COMMENT='���� ��������� ����������� ���������';


------------------------------------------------------------


