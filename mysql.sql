
DROP TABLE IF EXISTS `blogs`;
CREATE TABLE IF NOT EXISTS `blogs` (
    `blog_id` int unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL DEFAULT '',
    `title` varchar(255) NOT NULL DEFAULT '',
    `posts` int NOT NULL DEFAULT 0,
    `url` varchar(255) NOT NULL DEFAULT '',
    `updated` int unsigned NOT NULL DEFAULT 0,
    `description` varchar(255) NOT NULL DEFAULT '',
    `ask` tinyint(1) NOT NULL DEFAULT 0,
    `ask_anon` tinyint(1) NOT NULL DEFAULT 0,
    `likes` int unsigned NOT NULL DEFAULT 0,
    PRIMARY KEY (`blog_id`),
    UNIQUE KEY (`url`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
    `post_id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `blog_name` varchar(255) NOT NULL DEFAULT '',
    `post_url` varchar(255) NOT NULL DEFAULT '',
    `slug` varchar(255) NOT NULL DEFAULT '',
    `type` varchar(255) NOT NULL DEFAULT '',
    `date` varchar(255) NOT NULL DEFAULT '',
    `timestamp` int unsigned NOT NULL DEFAULT 0,
    `state` varchar(255) NOT NULL DEFAULT '',
    `format` varchar(255) NOT NULL DEFAULT '',
    `reblog_key` varchar(255) NOT NULL DEFAULT '',
    `note_count` int unsigned NOT NULL DEFAULT 0,
    `bookmarklet` tinyint(1) NOT NULL DEFAULT 0,
    `mobile` tinyint(1) NOT NULL DEFAULT 0,
    `source_url` varchar(255) NOT NULL DEFAULT '',
    `source_title` varchar(255) NOT NULL DEFAULT '',
    PRIMARY KEY (`post_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
    `tag_id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `post_id` bigint unsigned NOT NULL DEFAULT 0,
    `tag` varchar(255) NOT NULL DEFAULT '',
    PRIMARY KEY (`tag_id`),
    UNIQUE KEY `unitag` (`post_id`,`tag`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `texts`;
CREATE TABLE IF NOT EXISTS `texts` (
    `post_id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `title` varchar(255) NOT NULL DEFAULT '',
    `body` varchar(255) NOT NULL DEFAULT '',
    PRIMARY KEY (`post_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `photosets`;
CREATE TABLE IF NOT EXISTS `photosets` (
    `post_id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `caption` varchar(255) NOT NULL DEFAULT '',
    `photoset_layout` int unsigned NOT NULL DEFAULT 0,
    PRIMARY KEY (`post_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `photos`;
CREATE TABLE IF NOT EXISTS `photos` (
    `photo_id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `post_id` bigint unsigned NOT NULL DEFAULT 0,
    `caption` varchar(255) NOT NULL DEFAULT '',
    `original_size` tinyint(1) NOT NULL DEFAULT 0,
    `width` int unsigned NOT NULL DEFAULT 0,
    `heigh` int unsigned NOT NULL DEFAULT 0,
    `url` varchar(255) NOT NULL DEFAULT '',
    PRIMARY KEY (`photo_id`),
    UNIQUE KEY `unipho` (`post_id`,`original_size`,`url`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

