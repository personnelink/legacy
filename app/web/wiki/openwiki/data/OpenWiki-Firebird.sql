CREATE DOMAIN BIT INTEGER DEFAULT 0;

CREATE TABLE openwiki_attachments (
  att_wrv_name varchar(128) NOT NULL ,
  att_wrv_revision integer NOT NULL ,
  att_name varchar(255) NOT NULL ,
  att_revision integer NOT NULL ,
  att_hidden integer NOT NULL ,
  att_deprecated integer NOT NULL ,
  att_filename varchar(255) NOT NULL ,
  att_timestamp date NOT NULL ,
  att_filesize integer NOT NULL ,
  att_host varchar(128) ,
  att_agent varchar(255) ,
  att_by varchar(128) ,
  att_byalias varchar(128) ,
  att_comment blob sub_type 1
);

CREATE TABLE openwiki_attachments_log (
  ath_wrv_name varchar(128) NOT NULL ,
  ath_wrv_revision integer NOT NULL ,
  ath_name varchar(255) NOT NULL ,
  ath_revision integer NOT NULL ,
  ath_timestamp date NOT NULL ,
  ath_agent varchar(255) ,
  ath_by varchar(128) ,
  ath_byalias varchar(128) ,
  ath_action varchar(20) NOT NULL
);

CREATE TABLE openwiki_badlinklist (
	bll_name varchar(255) NOT NULL ,
	bll_comment varchar(255) default 'Spam Link'
); 

CREATE TABLE openwiki_cache (
  chc_name varchar(128) NOT NULL ,
  chc_hash integer NOT NULL ,
  chc_xmlisland blob sub_type 1 NOT NULL
);

CREATE TABLE openwiki_categories (
	key_categories int NOT NULL ,
	categories_name varchar(255) default 'default' NOT NULL 
);

CREATE TABLE openwiki_config (
  pk_ow int NOT NULL PRIMARY KEY  ,
  ow_version varchar(50) DEFAULT '1.0' NOT NULL,
  ow_buildnumber varchar(50) DEFAULT '20040101' NOT NULL,
  ow_imagepath varchar(255) DEFAULT 'ow/images' NOT NULL,
  ow_iconpath varchar(255) DEFAULT 'ow/images/icons' NOT NULL,
  ow_encoding varchar(50) DEFAULT 'ISO-8859-1'  NOT NULL,
  ow_title varchar(255) DEFAULT 'OpenWiki 2004'  NOT NULL,
  ow_frontpage varchar(255) DEFAULT 'FrontPage'  NOT NULL,
  ow_welcomepage varchar(255) DEFAULT 'FrontPage'  NOT NULL,
  ow_scriptname varchar(50) DEFAULT 'ow.asp'  NOT NULL,
  ow_maxtext int DEFAULT 204800 NOT NULL,
  ow_maxincludelevel int DEFAULT 5  NOT NULL,
  ow_rcname varchar(255) DEFAULT 'RecentChanges'  NOT NULL,
  ow_rcdays int DEFAULT 30 NOT NULL,
  ow_maxtrail int DEFAULT 5  NOT NULL,
  ow_stopwords varchar(255) DEFAULT 'StopWords'  NOT NULL,
  ow_templates varchar(255) DEFAULT 'Template$'  NOT NULL,
  ow_timezone varchar(255) DEFAULT '+01:00'  NOT NULL,
  ow_maxnrofaggr int DEFAULT 150  NOT NULL,
  ow_maxwebgets int DEFAULT 3  NOT NULL,
  ow_scripttimeout int DEFAULT 120  NOT NULL,
  ow_daystokeep int DEFAULT 30  NOT NULL,
  ow_uploaddir varchar(255) DEFAULT 'attachments/'  NOT NULL,
  ow_maxuploadsize bigint DEFAULT 8388608  NOT NULL,
  ow_uploadtimeout int DEFAULT 300  NOT NULL,
  ow_activeskin varchar(255) DEFAULT ''  NOT NULL,
  ow_msxml_version int DEFAULT 3  NOT NULL,
  ow_readpassword varchar(50) DEFAULT ''  NOT NULL,
  ow_editpassword varchar(50) DEFAULT ''  NOT NULL,
  ow_adminpassword varchar(50) DEFAULT 'adminpw'  NOT NULL,
  ow_defaultbookmarks varchar(255) DEFAULT ' RecentChanges TitleIndex UserPreferences RandomPage Help'  NOT NULL,
  ow_writehtml bit DEFAULT 0 NOT NULL,
  ow_readonly bit DEFAULT 0  NOT NULL,
  ow_nakedview bit DEFAULT 0  NOT NULL,
  ow_usesubpage bit DEFAULT 1  NOT NULL,
  ow_freelinks bit DEFAULT 1  NOT NULL,
  ow_wikilinks bit  DEFAULT 1  NOT NULL,
  ow_acronymlinks bit DEFAULT 0  NOT NULL,
  ow_templatelinking bit DEFAULT 1  NOT NULL,
  ow_rawhtml bit DEFAULT 0  NOT NULL,
  ow_mathml bit DEFAULT 0  NOT NULL,
  ow_cachexsl bit DEFAULT 0  NOT NULL,
  ow_cachexml bit DEFAULT 0  NOT NULL,
  ow_allowrssexport bit DEFAULT 1  NOT NULL,
  ow_allownewsyndications bit DEFAULT 1  NOT NULL,
  ow_allowaggregations bit DEFAULT 1  NOT NULL,
  ow_embeddedmode bit DEFAULT 0  NOT NULL,
  ow_allowattachments bit DEFAULT 0  NOT NULL,
  ow_simplelinks bit DEFAULT 1  NOT NULL,
  ow_nonenglish bit DEFAULT 1  NOT NULL,
  ow_networkfile bit DEFAULT 0  NOT NULL,
  ow_brackettext bit DEFAULT 1  NOT NULL,
  ow_htmllinks bit DEFAULT 1  NOT NULL,
  ow_bracketwiki bit DEFAULT 1  NOT NULL,
  ow_showbrackets bit DEFAULT 0  NOT NULL,
  ow_freeupper bit DEFAULT 1  NOT NULL,
  ow_linkimages bit DEFAULT 1  NOT NULL,
  ow_useheadings bit DEFAULT 1  NOT NULL,
  ow_uselookup bit DEFAULT 1  NOT NULL,
  ow_stripntdomain bit DEFAULT 1  NOT NULL,
  ow_maskipaddress bit DEFAULT 1  NOT NULL,
  ow_oldskool bit DEFAULT 1  NOT NULL,
  ow_newskool bit DEFAULT 1  NOT NULL,
  ow_numtoc bit DEFAULT 0  NOT NULL,
  ow_ntauthentication bit DEFAULT 1  NOT NULL,
  ow_directedit bit DEFAULT 1  NOT NULL,
  ow_allowcharrefs bit DEFAULT 1  NOT NULL,
  ow_wikifyheaders bit DEFAULT 0  NOT NULL,
  ow_emoticons bit DEFAULT 1  NOT NULL,
  ow_uselinkicons bit DEFAULT 0  NOT NULL,
  ow_prettylinks bit DEFAULT 1  NOT NULL,
  ow_externalout bit DEFAULT 1 NOT NULL
);

CREATE TABLE openwiki_interwikis (
    wik_name varchar(128) NOT NULL ,
    wik_url varchar(255) NOT NULL
);

CREATE TABLE openwiki_macrohelp (
	macro_name varchar (255) NOT NULL,
	macro_builtin int default 1,
	macro_numparams int default 0,
	macro_description varchar(255) default 'No description available',
	macro_param1 varchar(255) default 'None',
	macro_param2 varchar(255) default 'None',
	macro_param3 varchar(255) default 'None',
	macro_comment varchar(255) default 'None' 
);

CREATE TABLE openwiki_pages (
    wpg_name varchar(128) NOT NULL ,
    wpg_lastmajor integer NOT NULL ,
    wpg_lastminor integer NOT NULL ,
    wpg_changes integer NOT NULL,
    wpg_Hits bigint default 0 NOT NULL,
	  wpg_FCategories int default 0
);

CREATE TABLE openwiki_referers (
	rfr_name varchar(255) ,
	rfr_date timestamp default current_timestamp  NOT NULL
);

CREATE TABLE openwiki_revisions (
    wrv_name varchar(128) NOT NULL ,
    wrv_revision integer NOT NULL ,
    wrv_current integer NOT NULL ,
    wrv_status integer NOT NULL ,
    wrv_timestamp timestamp NOT NULL ,
    wrv_minoredit integer NOT NULL ,
    wrv_host varchar(128) ,
    wrv_agent varchar(255) ,
    wrv_by varchar(128) ,
    wrv_byalias varchar(128) ,
    wrv_comment varchar(1024) ,
    wrv_text blob sub_type 1,
    wrv_summary varchar(255)
);

CREATE TABLE openwiki_rss (
    rss_url varchar(256) NOT NULL ,
    rss_last timestamp NOT NULL ,
    rss_next timestamp NOT NULL ,
    rss_refreshrate integer NOT NULL ,
    rss_cache blob sub_type 1 NOT NULL
);

CREATE TABLE openwiki_rss_aggregations (
    agr_feed varchar(200) NOT NULL ,
    agr_resource varchar(200) NOT NULL ,
    agr_rsslink varchar(200) ,
    agr_timestamp timestamp NOT NULL ,
    agr_dcdate varchar(25) ,
    agr_xmlisland blob sub_type 1 NOT NULL
);


/* Generators for the identity fields */
CREATE GENERATOR OW_CATEGORIES_KEY;
CREATE GENERATOR OW_CONFIG_KEY;

ALTER TABLE openwiki_pages ADD
  CONSTRAINT PK_openwiki_pages PRIMARY KEY
  (
      wpg_name
  );

ALTER TABLE openwiki_revisions ADD
  CONSTRAINT PK_openwiki_revisions PRIMARY KEY
  (
      wrv_name,
      wrv_revision
  );

ALTER TABLE openwiki_cache ADD
  CONSTRAINT PK_openwiki_cache PRIMARY KEY
  (
      chc_name,
      chc_hash
  );

ALTER TABLE openwiki_interwikis ADD
  CONSTRAINT PK_openwiki_interwikis PRIMARY KEY
  (
      wik_name
  );

ALTER TABLE openwiki_attachments ADD
  CONSTRAINT FK_ow_attachments_ow_revisions FOREIGN KEY
  (
      att_wrv_name,
      att_wrv_revision
  ) REFERENCES openwiki_revisions (
      wrv_name,
      wrv_revision
  );

ALTER TABLE openwiki_attachments_log ADD
  CONSTRAINT FK_ow_att_log_ow_revisions FOREIGN KEY
  (
      ath_wrv_name,
      ath_wrv_revision
  ) REFERENCES openwiki_revisions (
      wrv_name,
      wrv_revision
  );

ALTER TABLE openwiki_revisions ADD
  CONSTRAINT FK_ow_revisions_ow_pages FOREIGN KEY
  (
      wrv_name
  ) REFERENCES openwiki_pages (
      wpg_name
  );

/* This constraint is too large for IB/FB
ALTER TABLE openwiki_attachments ADD
  CONSTRAINT PK_openwiki_attachments PRIMARY KEY
  (
      att_wrv_name,
      att_name,
      att_revision
  );*/

/* This constraint is too large for IB/FB
ALTER TABLE openwiki_rss ADD
  CONSTRAINT PK_openwiki_rss PRIMARY KEY
  (
      rss_url
  );*/

/* This constraint is too large for IB/FB
ALTER TABLE openwiki_rss_aggregations ADD
  CONSTRAINT PK_openwiki_rss_aggregations PRIMARY KEY
  (
      agr_feed,
      agr_resource
  );*/

/* Triggers for generators */
SET TERM ^;
create trigger trg_OW_CATEGORIES 
for OPENWIKI_CATEGORIES
BEFORE INSERT 
as
begin
  IF (NEW.key_categories IS NULL) THEN
  BEGIN
    NEW.key_categories =  GEN_ID(OW_CATEGORIES_KEY, 1);
  END
end^

create trigger trg_OW_CONFIG 
for OPENWIKI_CONFIG
BEFORE INSERT 
as
begin
  IF (NEW.pk_ow IS NULL) THEN
  BEGIN
    NEW.pk_ow = GEN_ID(OW_CONFIG_KEY, 1);
  END
end^
