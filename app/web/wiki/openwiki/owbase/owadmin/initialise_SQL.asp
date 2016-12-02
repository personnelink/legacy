<%@ Language=VBScript EnableSessionState=False %>
<!-- #include virtual="/ow/owpreamble.asp" //-->
<!-- #include virtual="/ow/owconfig_default.asp" //-->
<!-- #include virtual="/ow/owado.asp" //-->
<%
' ***************************************************************************************************************
' $Log: initialise_SQL.asp,v $
' Revision 1.6  2006/03/08 02:11:53  gbamber
' Added warning
'
' Revision 1.5  2006/03/08 02:07:20  gbamber
' #includes changed to virtual
'
' Revision 1.4  2004/08/04 22:31:03  gbamber
' Added openwiki_macrohelp table
'
' Revision 1.3  2004/07/21 12:26:52  gbamber
' Added BadLinkList table
'
' Revision 1.2  2004/07/21 11:49:10  gbamber
' Tested and bugfixed for SQL Server
'
' ***************************************************************************************************************
' gAdminPassword is set in owconfig_default.asp
Dim Success
Success=False '	// Default to fail
Dim conn
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open OPENWIKI_DB
Function ExecuteSQL(sz_DML)
'	// Nice code from owdeprecate - altered by Gordon to include SQL Transactions
	On Error GoTo 0
    if OPENWIKI_DB_SYNTAX = DB_SQLSERVER then conn.BeginTrans()
    conn.Execute sz_DML
    if OPENWIKI_DB_SYNTAX = DB_SQLSERVER then 
		If conn.errors.count=0 then
			conn.CommitTrans()
			ExecuteSQL=True
		Else	
			conn.RollbackTrans()
			ExecuteSQL=False
		End If
	else
		ExecuteSQL=True
	end if		
End Function

If Request.Form("submitted")="yes" then
	If (Request.Form("pw")=gAdminPassword) OR (gAdminPassword="") then
'	// DROP TABLES IF PRESENT

		 Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_openwiki_revisions_openwiki_pages]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)" &_
"ALTER TABLE [dbo].[openwiki_revisions] DROP CONSTRAINT FK_openwiki_revisions_openwiki_pages")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_openwiki_attachments_openwiki_revisions]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)" &_
"ALTER TABLE [dbo].[openwiki_attachments] DROP CONSTRAINT FK_openwiki_attachments_openwiki_revisions")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_openwiki_attachments_log_openwiki_revisions]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)" &_
"ALTER TABLE [dbo].[openwiki_attachments_log] DROP CONSTRAINT FK_openwiki_attachments_log_openwiki_revisions")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_attachments]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_attachments]")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_attachments_log]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_attachments_log]")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_cache]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_cache]")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_categories]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_categories]")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_interwikis]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_interwikis]")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_pages]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_pages]")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_referers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_referers]")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_revisions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_revisions]")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_rss]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_rss]")
		 If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_rss_aggregations]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_rss_aggregations]")
         If Success then Success=ExecuteSQL("if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_badlinklist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_badlinklist];")

		 If Success then Success=ExecuteSQL("CREATE TABLE [dbo].[openwiki_attachments] (" &_
	"[att_wrv_name] [nvarchar] (128) NOT NULL PRIMARY KEY," &_
	"[att_wrv_revision] [int] NOT NULL ," &_
	"[att_name] [nvarchar] (255) NOT NULL," &_
	"[att_revision] [int] NOT NULL," &_
	"[att_hidden] [int] NOT NULL ," &_
	"[att_deprecated] [int] NOT NULL ," &_
	"[att_filename] [nvarchar] (255) NOT NULL ," &_
	"[att_timestamp] [datetime] NOT NULL ," &_
	"[att_filesize] [int] NOT NULL ," &_
	"[att_host] [nvarchar] (128) NULL ," &_
	"[att_agent] [nvarchar] (255) NULL ," &_
	"[att_by] [nvarchar] (128) NULL ," &_
	"[att_byalias] [nvarchar] (128) NULL ," &_
	"[att_comment] [text] NULL" &_ 
") ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]")


	 If Success then Success=ExecuteSQL("CREATE TABLE [dbo].[openwiki_attachments_log] (" &_
	"[ath_wrv_name] [nvarchar] (128) NOT NULL," &_
	"[ath_wrv_revision] [int] NOT NULL ," &_
	"[ath_name] [nvarchar] (255) NOT NULL ," &_
	"[ath_revision] [int] NOT NULL ," &_
	"[ath_timestamp] [datetime] NOT NULL ," &_
	"[ath_agent] [nvarchar] (255) NULL ," &_
	"[ath_by] [nvarchar] (128) NULL ," &_
	"[ath_byalias] [nvarchar] (128) NULL ," &_
	"[ath_action] [nvarchar] (20) NOT NULL" &_ 
") ON [PRIMARY]")

		 If Success then Success=ExecuteSQL("CREATE TABLE [dbo].[openwiki_cache] (" &_
	"[chc_name] [nvarchar] (128) NOT NULL ," &_
	"[chc_hash] [int] NOT NULL ," &_
	"[chc_xmlisland] [text] NOT NULL" &_ 
") ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]")

		 If Success then Success=ExecuteSQL("CREATE TABLE [dbo].[openwiki_categories] (" &_
	"[key_categories] [int] IDENTITY (1, 1) NOT NULL PRIMARY KEY ," &_
	"[categories_name] [varchar] (255) NOT NULL DEFAULT ('default')" &_ 
") ON [PRIMARY]")

		 If Success then Success=ExecuteSQL("CREATE TABLE [dbo].[openwiki_interwikis] (" &_
	"[wik_name] [nvarchar] (128) NOT NULL ," &_
	"[wik_url] [nvarchar] (255) NOT NULL" &_ 
") ON [PRIMARY]")

		 If Success then Success=ExecuteSQL("CREATE TABLE [dbo].[openwiki_pages] (" &_
	"[wpg_name] [nvarchar] (128) NOT NULL ," &_
	"[wpg_lastmajor] [int] NOT NULL ," &_
	"[wpg_lastminor] [int] NOT NULL ," &_
	"[wpg_changes] [int] NOT NULL ," &_
	"[wpg_Hits] [bigint] NOT NULL DEFAULT (0)," &_
	"[wpg_FCategories] [int] NULL DEFAULT (0)" &_ 
") ON [PRIMARY]")

		 If Success then Success=ExecuteSQL("CREATE TABLE [dbo].[openwiki_referers] (" &_ 
	"[rfr_name] [varchar] (255) NULL ," &_ 
	"[rfr_date] [datetime] NOT NULL DEFAULT GETDATE()" &_  
") ON [PRIMARY]")

		 If Success then Success=ExecuteSQL("CREATE TABLE [dbo].[openwiki_revisions] (" &_ 
	"[wrv_name] [nvarchar] (128) NOT NULL ," &_ 
	"[wrv_revision] [int] NOT NULL ," &_ 
	"[wrv_current] [int] NOT NULL ," &_ 
	"[wrv_status] [int] NOT NULL ," &_ 
	"[wrv_timestamp] [datetime] NOT NULL ," &_ 
	"[wrv_minoredit] [int] NOT NULL ," &_ 
	"[wrv_host] [nvarchar] (128) NULL ," &_ 
	"[wrv_agent] [nvarchar] (255) NULL ," &_ 
	"[wrv_by] [nvarchar] (128) NULL ," &_ 
	"[wrv_byalias] [nvarchar] (128) NULL ," &_ 
	"[wrv_comment] [nvarchar] (1024) NULL ," &_ 
	"[wrv_text] [ntext] NULL " &_ 
") ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]")

		 If Success then Success=ExecuteSQL("CREATE TABLE [dbo].[openwiki_rss] (" &_ 
	"[rss_url] [nvarchar] (256) NOT NULL PRIMARY KEY ," &_ 
	"[rss_last] [datetime] NOT NULL ," &_ 
	"[rss_next] [datetime] NOT NULL ," &_ 
	"[rss_refreshrate] [int] NOT NULL ," &_ 
	"[rss_cache] [ntext] NOT NULL " &_ 
") ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]")

		 If Success then Success=ExecuteSQL("CREATE TABLE [dbo].[openwiki_rss_aggregations] (" &_ 
	"[agr_feed] [nvarchar] (200) NOT NULL PRIMARY KEY," &_ 
	"[agr_resource] [nvarchar] (200) NOT NULL ," &_ 
	"[agr_rsslink] [nvarchar] (200) NULL ," &_ 
	"[agr_timestamp] [datetime] NOT NULL ," &_ 
	"[agr_dcdate] [nvarchar] (25) NULL ," &_ 
	"[agr_xmlisland] [ntext] NOT NULL " &_ 
") ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]")

        If Success then Success=ExecuteSQL("CREATE TABLE [dbo].[openwiki_badlinklist] (" &_
        "[bll_name] [varchar] (255) NOT NULL PRIMARY KEY ," &_
        "[bll_comment] [varchar] (255) NULL DEFAULT 'Spam Link'" &_
") ON [PRIMARY]")

        If Success then Success=ExecuteSQL("INSERT INTO openwiki_badlinklist (bll_name,bll_comment)" &_
        " VALUES ('http://www.spam.com','Spam link');")

         If Success then Success=ExecuteSQL("CREATE TABLE openwiki_macrohelp (" &_
         "macro_name [varchar] (255) NOT NULL PRIMARY KEY," &_
		 "macro_builtin [int] NULL DEFAULT 1," &_
		 "macro_numparams [int] NULL DEFAULT 0," &_
		 "macro_description [varchar] (255) NULL DEFAULT 'No description available'," &_
		 "macro_param1 [varchar] (255) NULL DEFAULT 'None'," &_
		 "macro_param2 [varchar] (255) NULL DEFAULT 'None'," &_
		 "macro_param3 [varchar] (255) NULL DEFAULT 'None'," &_
		 "macro_comment [varchar] (255) NULL DEFAULT 'None'" &_
		 ") ON [PRIMARY]")


'	// NEED SYNTAX HERE TO CREATE THE CASCADE DELETES AND UPDATES! //	
'		 If Success then Success=ExecuteSQL("ALTER TABLE [dbo].[openwiki_attachments] ADD" &_ 
'	"CONSTRAINT [FK_openwiki_attachments_openwiki_revisions] FOREIGN KEY" &_
'	"(" &_
'		"[att_wrv_name]," &_
'		"[att_wrv_revision]" &_
'	") REFERENCES [dbo].[openwiki_revisions] (" &_
'		"[wrv_name]," &_
'		"[wrv_revision]" &_
'	") ON DELETE CASCADE  ON UPDATE CASCADE")
'	
'		 If Success then Success=ExecuteSQL("ALTER TABLE [dbo].[openwiki_attachments_log] ADD" &_ 
'	"CONSTRAINT [FK_openwiki_attachments_log_openwiki_revisions] FOREIGN KEY " &_
'	"(" &_
'		"[ath_wrv_name]," &_
'		"[ath_wrv_revision]" &_
'	") REFERENCES [dbo].[openwiki_revisions] (" &_
'		"[wrv_name]," &_
'		"[wrv_revision]" &_
'	") ON DELETE CASCADE  ON UPDATE CASCADE")
'	
'			 If Success then Success=ExecuteSQL("ALTER TABLE [dbo].[openwiki_revisions] ADD" &_ 
'	"CONSTRAINT [FK_openwiki_revisions_openwiki_pages] FOREIGN KEY" &_ 
'	"(" &_
'		"[wrv_name]" &_
'	") REFERENCES [dbo].[openwiki_pages] (" &_
'		"[wpg_name]" &_
'	") ON DELETE CASCADE  ON UPDATE CASCADE")
'

'		 If Success then Success=ExecuteSQL("")
	Else '	// Bad Password
		Response.Write("Incorrect or missing Administration password.  Unable to proceed")
	End If	
End If
%>
<html>
<head><title>Initialise <%=OPENWIKI_TITLE%> Database</title></head>
<body>
<%
If Success = False then
	Set conn = Nothing
%>
	<h2>Initialise <%=OPENWIKI_TITLE%> Database Schema (SQL Server/MSDE)</h2>
	<h3>WARNING! This will delete any existing <%=OPENWIKI_TITLE%> existing database!</h3>
	<hr />
	<form method="POST" name="postform">
		<input type="hidden" name="submitted" value="yes" />
		Administrator password: <input type="password" size="16" name="pw" value="" /> (or leave blank)
		<br />
	<input type="submit" name="doit" value="Initialise Database" />
	</form>
	<hr />
<%
Else
	Set conn = Nothing
%>
	<h2>Initialisation Successful!</h2>
	Congratulations! You have successfully installed the <%=OPENWIKI_TITLE%>  database.
<%End If%>
</body>
</html>