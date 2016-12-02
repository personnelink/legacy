CREATE TABLE `blog` (
  `blog_id` int(10) unsigned NOT NULL auto_increment,
  `blog_titolo` varchar(80) default NULL,
  `blog_testo` text,
  `blog_autore` varchar(50) default NULL,
  `blog_email` varchar(50) default NULL,
  `data` varchar(50) default NULL,
  `ora` varchar(50) default NULL,
  `giorno` varchar(50) default NULL,
  `mese` varchar(50) default NULL,
  `anno` varchar(50) default NULL,
  `commenti` varchar(50) default NULL,
  PRIMARY KEY  (`blog_id`)
) TYPE=MyISAM;
CREATE TABLE `commenti` (
  `commento_id` int(10) unsigned NOT NULL auto_increment,
  `blog_id` int(11) default NULL,
  `commento_autore` varchar(50) default NULL,
  `commento_email` varchar(50) default NULL,
  `data` varchar(50) default NULL,
  `commento_testo` text,
  PRIMARY KEY  (`commento_id`)
) TYPE=MyISAM;
CREATE TABLE `configurazione` (
  `username` varchar(30) default NULL,
  `password` varchar(30) default NULL,
  `nomeblog` varchar(255) default NULL,
  `email_address` varchar(50) default NULL,
  `email_notify` varchar(50) default NULL,
  `n_record` smallint(6) default NULL,
  `cookie` varchar(50) default NULL,
  `tipologia` varchar(50) default NULL
) TYPE=MyISAM;
INSERT INTO configurazione (username, password, nomeblog, email_address, email_notify, n_record, cookie, tipologia) VALUES('admin', 'admin', 'Ublog - blog opensource', 'webmaster@tuosito.com', 'True', 8, 'True', 'closed');