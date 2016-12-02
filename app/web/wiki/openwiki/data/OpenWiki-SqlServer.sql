/* Updated SQL Server 2000 Scripts

  Do not run this script if you are trying to upgrade an existing OpenWiki database.
  
  All existing data in your database will be dropped.  Make a backup first or
  extract the data to csv or MS Access.
  All tables are now owned by dbo.

  Added drop statements for tables that already exist to avoid name collisions.
  Added openwiki_badlinklist table.
  Added openwiki_categories table.
  Added openwiki_config table.
  Added openwiki_macrohelp table.
  Added openwiki_referers table.

  openwiki_pages.wpg_Hits and openwiki_config.ow_maxuploadsize are integers.
  All text fields are now ntext (what's the point of mixing nvarchars and text?)
  
  Removed the foreign key contraint between revisions and pages, so that we
  can rename pages.  A trigger now enforces data integrity.
  
*/

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_attachments]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_attachments]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_attachments_log]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_attachments_log]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_badlinklist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_badlinklist]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_cache]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_cache]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_categories]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_categories]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_config]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_config]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_interwikis]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_interwikis]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_macrohelp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_macrohelp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_pages]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_pages]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_referers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_referers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_revisions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_revisions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_rss]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_rss]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_rss_aggregations]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[openwiki_rss_aggregations]
GO

CREATE TABLE [dbo].[openwiki_attachments] (
    [att_wrv_name] [nvarchar] (128) NOT NULL ,
    [att_wrv_revision] [int] NOT NULL ,
    [att_name] [nvarchar] (255) NOT NULL ,
    [att_revision] [int] NOT NULL ,
    [att_hidden] [int] NOT NULL ,
    [att_deprecated] [int] NOT NULL ,
    [att_filename] [nvarchar] (255) NOT NULL ,
    [att_timestamp] [datetime] NOT NULL ,
    [att_filesize] [int] NOT NULL ,
    [att_host] [nvarchar] (128) NULL ,
    [att_agent] [nvarchar] (255) NULL ,
    [att_by] [nvarchar] (128) NULL ,
    [att_byalias] [nvarchar] (128) NULL ,
    [att_comment] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_attachments_log] (
    [ath_wrv_name] [nvarchar] (128) NOT NULL ,
    [ath_wrv_revision] [int] NOT NULL ,
    [ath_name] [nvarchar] (255) NOT NULL ,
    [ath_revision] [int] NOT NULL ,
    [ath_timestamp] [datetime] NOT NULL ,
    [ath_agent] [nvarchar] (255) NULL ,
    [ath_by] [nvarchar] (128) NULL ,
    [ath_byalias] [nvarchar] (128) NULL ,
    [ath_action] [nvarchar] (20) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_badlinklist] (
	[bll_name] [nvarchar] (255) NOT NULL ,
	[bll_comment] [nvarchar] (255) NULL DEFAULT ('Spam Link')
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_cache] (
    [chc_name] [nvarchar] (128) NOT NULL ,
    [chc_hash] [int] NOT NULL ,
    [chc_xmlisland] [ntext] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_categories] (
	[key_categories] [int] IDENTITY (1, 1) NOT NULL ,
	[categories_name] [nvarchar] (255) NOT NULL DEFAULT ('default')
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_config] (
	[pk_ow] [int] IDENTITY (1, 1) NOT NULL ,
	[ow_version] [nvarchar] (50) NOT NULL DEFAULT ('1.0'),
	[ow_buildnumber] [nvarchar] (50) NOT NULL DEFAULT ('20040101'),
	[ow_imagepath] [nvarchar] (255) NOT NULL DEFAULT ('ow/images'),
	[ow_iconpath] [nvarchar] (255) NOT NULL DEFAULT ('ow/images/icons'),
	[ow_encoding] [nvarchar] (50) NOT NULL DEFAULT ('ISO-8859-1'),
	[ow_title] [nvarchar] (255) NOT NULL DEFAULT ('OpenWiki 2004'),
	[ow_frontpage] [nvarchar] (255) NOT NULL DEFAULT ('FrontPage'),
	[ow_welcomepage] [nvarchar] (255) NOT NULL DEFAULT ('FrontPage'),
	[ow_scriptname] [nvarchar] (50) NOT NULL DEFAULT ('ow.asp'),
	[ow_maxtext] [int] NOT NULL DEFAULT (204800),
	[ow_maxincludelevel] [int] NOT NULL DEFAULT (5),
	[ow_rcname] [nvarchar] (255) NOT NULL DEFAULT ('RecentChanges'),
	[ow_rcdays] [int] NOT NULL DEFAULT (30),
	[ow_maxtrail] [int] NOT NULL DEFAULT (5),
	[ow_stopwords] [nvarchar] (255) NOT NULL DEFAULT ('StopWords'),
	[ow_templates] [nvarchar] (255) NOT NULL DEFAULT ('Template$'),
	[ow_timezone] [nvarchar] (255) NOT NULL DEFAULT ('+01:00'),
	[ow_maxnrofaggr] [int] NOT NULL DEFAULT (150),
	[ow_maxwebgets] [int] NOT NULL DEFAULT (3),
	[ow_scripttimeout] [int] NOT NULL DEFAULT (120),
	[ow_daystokeep] [int] NOT NULL DEFAULT (30),
	[ow_uploadmethod] [int] NOT NULL DEFAULT (0),
	[ow_uploaddir] [nvarchar] (255) NOT NULL DEFAULT ('attachments/'),
	[ow_uploadimagelibrary] [nvarchar] (255) NOT NULL DEFAULT ('attachments/images/'),
	[ow_maxuploadsize] [int] NOT NULL DEFAULT (8388608),
	[ow_uploadtimeout] [int] NOT NULL DEFAULT (300),
	[ow_activeskin] [nvarchar] (128) NOT NULL DEFAULT (''),
	[ow_synonymlinkpage] [nvarchar] (128) NOT NULL DEFAULT ('SynonymLinks'),
	[ow_msxml_version] [int] NOT NULL DEFAULT (3),
	[ow_readpassword] [nvarchar] (50) NOT NULL DEFAULT (''),
	[ow_editpassword] [nvarchar] (50) NOT NULL DEFAULT (''),
	[ow_adminpassword] [nvarchar] (50) NOT NULL DEFAULT ('adminpw'),
	[ow_uploadpassword] [nvarchar] (50) NOT NULL DEFAULT (''),
	[ow_defaultbookmarks] [nvarchar] (255) NOT NULL DEFAULT (' RecentChanges TitleIndex UserPreferences RandomPage Help'),
	[ow_writehtml] [bit] NOT NULL DEFAULT (0),
	[ow_readonly] [bit] NOT NULL DEFAULT (0),
	[ow_nakedview] [bit] NOT NULL DEFAULT (0),
	[ow_usesubpage] [bit] NOT NULL DEFAULT (1),
	[ow_freelinks] [bit] NOT NULL DEFAULT (1),
	[ow_wikilinks] [bit] NOT NULL DEFAULT (1),
	[ow_acronymlinks] [bit] NOT NULL DEFAULT (0),
	[ow_templatelinking] [bit] NOT NULL DEFAULT (1),
	[ow_rawhtml] [bit] NOT NULL DEFAULT (0),
	[ow_mathml] [bit] NOT NULL DEFAULT (0),
	[ow_cachexsl] [bit] NOT NULL DEFAULT (0),
	[ow_cachexml] [bit] NOT NULL DEFAULT (0),
	[ow_allowrssexport] [bit] NOT NULL DEFAULT (1),
	[ow_allownewsyndications] [bit] NOT NULL DEFAULT (1),
	[ow_allowaggregations] [bit] NOT NULL DEFAULT (1),
	[ow_embeddedmode] [bit] NOT NULL DEFAULT (0),
	[ow_allowattachments] [bit] NOT NULL DEFAULT (0),
	[ow_simplelinks] [bit] NOT NULL DEFAULT (1),
	[ow_nonenglish] [bit] NOT NULL DEFAULT (1),
	[ow_networkfile] [bit] NOT NULL DEFAULT (0),
	[ow_brackettext] [bit] NOT NULL DEFAULT (1),
	[ow_htmllinks] [bit] NOT NULL DEFAULT (1),
	[ow_bracketwiki] [bit] NOT NULL DEFAULT (1),
	[ow_showbrackets] [bit] NOT NULL DEFAULT (0),
	[ow_freeupper] [bit] NOT NULL DEFAULT (1),
	[ow_linkimages] [bit] NOT NULL DEFAULT (1),
	[ow_useheadings] [bit] NOT NULL DEFAULT (1),
	[ow_uselookup] [bit] NOT NULL DEFAULT (1),
	[ow_stripntdomain] [bit] NOT NULL DEFAULT (1),
	[ow_maskipaddress] [bit] NOT NULL DEFAULT (1),
	[ow_oldskool] [bit] NOT NULL DEFAULT (1),
	[ow_newskool] [bit] NOT NULL DEFAULT (1),
	[ow_numtoc] [bit] NOT NULL DEFAULT (0),
	[ow_ntauthentication] [bit] NOT NULL DEFAULT (1),
	[ow_directedit] [bit] NOT NULL DEFAULT (1),
	[ow_allowcharrefs] [bit] NOT NULL DEFAULT (1),
	[ow_wikifyheaders] [bit] NOT NULL DEFAULT (0),
	[ow_emoticons] [bit] NOT NULL DEFAULT (1),
	[ow_uselinkicons] [bit] NOT NULL DEFAULT (0),
	[ow_prettylinks] [bit] NOT NULL DEFAULT (1),
	[ow_externalout] [bit] NOT NULL DEFAULT (1),
	[ow_autocomment] [bit] NOT NULL DEFAULT (1),
	[ow_allowflash] [bit] NOT NULL DEFAULT (1),
	[ow_allowbadge] [bit] NOT NULL DEFAULT (1),
	[ow_usecategories] [bit] NOT NULL DEFAULT (1),
	[ow_toggle1] [bit] NULL DEFAULT (0),
	[ow_toggle2] [bit] NULL DEFAULT (0),
	[ow_toggle3] [bit] NULL DEFAULT (0),
	[ow_toggle4] [bit] NULL DEFAULT (0),
	[ow_toggle5] [bit] NULL DEFAULT (0),
	[ow_string1] [nvarchar] (50) NULL DEFAULT ('("")'),
	[ow_string2] [nvarchar] (50) NULL DEFAULT ('("")'),
	[ow_string3] [nvarchar] (50) NULL DEFAULT ('("")'),
	[ow_int1] [int] NULL DEFAULT (0),
	[ow_int2] [int] NULL DEFAULT (0),
	[ow_int3] [int] NULL DEFAULT (0)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_interwikis] (
    [wik_name] [nvarchar] (128) NOT NULL ,
    [wik_url] [nvarchar] (255) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_macrohelp] (
	[macro_name] [nvarchar] (255) NOT NULL ,
	[macro_builtin] [int] NULL DEFAULT (1),
	[macro_numparams] [int] NULL DEFAULT (0),
	[macro_description] [nvarchar] (255) NULL DEFAULT ('No description available'),
	[macro_param1] [nvarchar] (255) NULL DEFAULT ('None'),
	[macro_param2] [nvarchar] (255) NULL DEFAULT ('None'),
	[macro_param3] [nvarchar] (255) NULL DEFAULT ('None'),
	[macro_comment] [nvarchar] (255) NULL DEFAULT ('None')
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_pages] (
    [wpg_name] [nvarchar] (128) NOT NULL ,
    [wpg_lastmajor] [int] NOT NULL ,
    [wpg_lastminor] [int] NOT NULL ,
    [wpg_changes] [int] NOT NULL,
	[wpg_Hits] [int] NOT NULL DEFAULT (0),
	[wpg_FCategories] [int] NULL DEFAULT (0)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_referers] (
	[rfr_name] [nvarchar] (255) NULL ,
	[rfr_date] [datetime] NOT NULL DEFAULT (getdate())
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_revisions] (
    [wrv_name] [nvarchar] (128) NOT NULL ,
    [wrv_revision] [int] NOT NULL ,
    [wrv_current] [int] NOT NULL ,
    [wrv_status] [int] NOT NULL ,
    [wrv_timestamp] [datetime] NOT NULL ,
    [wrv_minoredit] [int] NOT NULL ,
    [wrv_host] [nvarchar] (128) NULL ,
    [wrv_agent] [nvarchar] (255) NULL ,
    [wrv_by] [nvarchar] (128) NULL ,
    [wrv_byalias] [nvarchar] (128) NULL ,
    [wrv_comment] [nvarchar] (1024) NULL ,
    [wrv_text] [ntext] NULL,
    [wrv_summary] [nvarchar] (255)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_rss] (
    [rss_url] [nvarchar] (256) NOT NULL ,
    [rss_last] [datetime] NOT NULL ,
    [rss_next] [datetime] NOT NULL ,
    [rss_refreshrate] [int] NOT NULL ,
    [rss_cache] [ntext] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[openwiki_rss_aggregations] (
    [agr_feed] [nvarchar] (200) NOT NULL ,
    [agr_resource] [nvarchar] (200) NOT NULL ,
    [agr_rsslink] [nvarchar] (200) NULL ,
    [agr_timestamp] [datetime] NOT NULL ,
    [agr_dcdate] [nvarchar] (25) NULL ,
    [agr_xmlisland] [ntext] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[openwiki_categories] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[key_categories]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[openwiki_config] WITH NOCHECK ADD 
	CONSTRAINT [PK__openwiki_config__0EF836A4] PRIMARY KEY  CLUSTERED 
	(
		[pk_ow]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[openwiki_macrohelp] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[macro_name]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[openwiki_pages] WITH NOCHECK ADD
    CONSTRAINT [PK_openwiki_pages] PRIMARY KEY  CLUSTERED
    (
        [wpg_name]
    ) WITH  FILLFACTOR = 90  ON [PRIMARY]
GO

ALTER TABLE [dbo].[openwiki_revisions] WITH NOCHECK ADD
    CONSTRAINT [PK_openwiki_revisions] PRIMARY KEY  CLUSTERED
    (
        [wrv_name],
        [wrv_revision]
    ) WITH  FILLFACTOR = 90  ON [PRIMARY]
GO

ALTER TABLE [dbo].[openwiki_attachments] WITH NOCHECK ADD
    CONSTRAINT [PK_openwiki_attachments] PRIMARY KEY  NONCLUSTERED
    (
        [att_wrv_name],
        [att_name],
        [att_revision]
    ) WITH  FILLFACTOR = 90  ON [PRIMARY]
GO

ALTER TABLE [dbo].[openwiki_cache] WITH NOCHECK ADD
    CONSTRAINT [PK_openwiki_cache] PRIMARY KEY  NONCLUSTERED
    (
        [chc_name],
        [chc_hash]
    ) WITH  FILLFACTOR = 90  ON [PRIMARY]
GO

ALTER TABLE [dbo].[openwiki_interwikis] WITH NOCHECK ADD
    CONSTRAINT [PK_openwiki_interwikis] PRIMARY KEY  NONCLUSTERED
    (
        [wik_name]
    ) WITH  FILLFACTOR = 90  ON [PRIMARY]
GO

ALTER TABLE [dbo].[openwiki_rss] WITH NOCHECK ADD
    CONSTRAINT [PK_openwiki_rss] PRIMARY KEY  NONCLUSTERED
    (
        [rss_url]
    ) WITH  FILLFACTOR = 90  ON [PRIMARY]
GO

ALTER TABLE [dbo].[openwiki_rss_aggregations] WITH NOCHECK ADD
    CONSTRAINT [PK_openwiki_rss_aggregations] PRIMARY KEY  NONCLUSTERED
    (
        [agr_feed],
        [agr_resource]
    ) WITH  FILLFACTOR = 90  ON [PRIMARY]
GO

ALTER TABLE [dbo].[openwiki_attachments] ADD
    CONSTRAINT [FK_openwiki_attachments_openwiki_revisions] FOREIGN KEY
    (
        [att_wrv_name],
        [att_wrv_revision]
    ) REFERENCES [openwiki_revisions] (
        [wrv_name],
        [wrv_revision]
    )
GO

ALTER TABLE [dbo].[openwiki_attachments_log] ADD
    CONSTRAINT [FK_openwiki_attachments_log_openwiki_revisions] FOREIGN KEY
    (
        [ath_wrv_name],
        [ath_wrv_revision]
    ) REFERENCES [openwiki_revisions] (
        [wrv_name],
        [wrv_revision]
    )
GO

/* This constraint prevents us from renaming pages so, we replaced it with a trigger.
ALTER TABLE [openwiki_revisions] ADD
    CONSTRAINT [FK_openwiki_revisions_openwiki_pages] FOREIGN KEY
    (
        [wrv_name]
    ) REFERENCES [openwiki_pages] (
        [wpg_name]
    )
GO */

CREATE TRIGGER [dbo].[trig_update_revisions] ON [dbo].[openwiki_pages]
FOR UPDATE
AS
  IF UPDATE([wpg_name])
  BEGIN
    DECLARE @old_name NVARCHAR(128)
    DECLARE @new_name NVARCHAR(128)
    SELECT @old_name = (SELECT wpg_name FROM Deleted);
    SELECT @new_name = (SELECT wpg_name FROM Inserted);
    UPDATE [openwiki_revisions]
      SET wrv_name = @new_name
    FROM [openwiki_pages]
    WHERE wrv_name = @old_name;
  END
GO
