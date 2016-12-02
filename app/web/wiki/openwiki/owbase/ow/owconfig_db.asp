<%

' $Log: owconfig_db.asp,v $
' Revision 1.1  2004/08/06 20:48:21  gbamber
' To be included in owall.asp.  Reassigns variables from openwiki_config table
'
' "The Truth about MS Access" : http://www.15seconds.com/Issue/010514.htm
' OPENWIKI_DB = "Driver={Microsoft Access Driver (*.mdb)};DBQ=e:\data\openwiki\OpenWiki.mdb"
' OPENWIKI_DB = "Driver={SQL Server};server=mymachine;uid=openwiki;pwd=openwiki;database=OpenWiki"
' OPENWIKI_DB = "Driver={Microsoft ODBC for Oracle};Server=OW;Uid=laurens;Pwd=aphex2twin;"
' OPENWIKI_DB = "MySystemDSName"
' OPENWIKI_DB = "MySQLOpenWiki"
' OPENWIKI_DB = "PostgreSQLOpenWiki"
OPENWIKI_DB = "openwiking"
'OPENWIKI_DB_SYNTAX = DB_ACCESS               ' see owpreamble.asp for possible values

Dim cConn,cRs,sz_cSQL
Set cConn = Server.CreateObject("ADODB.Connection")
Set cRS = Server.CreateObject("ADODB.Recordset")
cConn.Open OPENWIKI_DB
sz_cSQL="SELECT * FROM openwiki_config;"
cConn.BeginTrans()
cRS.Open sz_cSQL, cConn, 0 '	//adOpenForwardOnly
If (cRS.BOF <> cRS.EOF) THEN '	// we have a record in the table
	OPENWIKI_IMAGEPATH       = cRs.Fields("ow_imagepath") '			Default="ow/images"        ' path to images directory
	OPENWIKI_ICONPATH        = cRs.Fields("ow_iconpath") '			Default="ow/images/icons"  ' path to icons directory
	OPENWIKI_ENCODING        = cRs.Fields("ow_encoding") '			Default=""ISO-8859-1"       ' character encoding to use
	OPENWIKI_TITLE           = cRs.Fields("ow_title") '			Default="OpenWiki 2004"  ' title of your wiki
	OPENWIKI_FRONTPAGE       = cRs.Fields("ow_frontpage") '			Default="HomePage"        ' name of your front page.
	OPENWIKI_SCRIPTNAME      = cRs.Fields("ow_scriptname") '			Default="ow.asp"           ' "mydir/ow.asp" : in case the auto-detected scriptname isn't correct
	OPENWIKI_MAXTEXT         = Clng(cRs.Fields("ow_maxtext")) '	Default=204800             ' Maximum 200K texts
	OPENWIKI_MAXINCLUDELEVEL = CInt(cRs.Fields("ow_maxincludelevel")) '	Default=5                  ' Maximum depth of Include's
	OPENWIKI_RCNAME          = cRs.Fields("ow_rcname") '			Default="RecentChanges"    ' Name of recent changes page (change space to _)
	OPENWIKI_RCDAYS          = CInt(cRs.Fields("ow_rcdays")) '	Default=30                 ' Default number of RecentChanges days
	OPENWIKI_MAXTRAIL        = CInt(cRs.Fields("ow_maxtrail")) '	Default=5                  ' Maximum number of links in the trail
	OPENWIKI_STOPWORDS       = cRs.Fields("ow_stopwords") '			Default="StopWords"        ' Name of page containing stop words (change space to _). Stop words are words that won't be hyperlinked. Use empty string "" if you do not want to support stop words.
	OPENWIKI_TEMPLATES       = cRs.Fields("ow_templates") '			Default="Template$"        ' Pattern for templates usable when creating a new page
	OPENWIKI_TIMEZONE        = cRs.Fields("ow_timezone") '			Default="+01:00"           ' Timezone of the server running this wiki, valid values are e.g. "+04:00", "-09:00", etc.
	OPENWIKI_MAXNROFAGGR     = CInt(cRs.Fields("ow_maxnrofaggr")) '	Default=150                ' Maximum number of rows to show in an aggregated feed
	OPENWIKI_MAXWEBGETS      = CInt(cRs.Fields("ow_maxwebgets")) '	Default=3                  ' Maximum number of RSS feeds that may be refreshed from a remote server for one user request.
	OPENWIKI_SCRIPTTIMEOUT   = CInt(cRs.Fields("ow_scripttimeout")) '	Default=120                ' Maximum amount of seconds to wait for RSS feeds to be syndicated, if set to 0 the default timeout value of ASP is used.
	OPENWIKI_DAYSTOKEEP      = CInt(cRs.Fields("ow_daystokeep")) '	Default=30                 ' Number of days to keep old revisions
	OPENWIKI_UPLOADDIR       = cRs.Fields("ow_uploaddir") '			Default="attachments/"     ' The virtual directory where uploads are stored
	OPENWIKI_MAXUPLOADSIZE   = Clng(cRs.Fields("ow_maxuploadsize")) '	Default=8388608            ' Use to limit the size of uploads, in bytes (default = 8,388,608)
	OPENWIKI_UPLOADTIMEOUT   = CInt(cRs.Fields("ow_uploadtimeout")) '	Default=300                ' Timeout in seconds (upload must succeed within this time limit)
	OPENWIKI_ACTIVESKIN		 = "" & cRs.Fields("ow_activeskin") '			Default=""				  ' Set to the directory under /skins that you want to use.
	
	MSXML_VERSION = CInt(cRs.Fields("ow_msxml_version")) '	Default=3   ' use 4 if you've installed MSXML v4.0
	
	gReadPassword = "" & cRs.Fields("ow_readpassword") '			Default=""    ' use empty string "" if anyone may read
	gEditPassword = "" & cRs.Fields("ow_editpassword") '			Default=""    ' use empty string "" if anyone may edit
	gAdminPassword ="" & cRs.Fields("ow_adminpassword") '			Default="adminpw"   ' use empty string "" if anyone may administer this Wiki
	' In case you want more sophisticated security, then you should
	' rely on the Integrated Windows authentication feature of IIS.
	
	gDefaultBookmarks = OPENWIKI_FRONTPAGE & cRs.Fields("ow_") '			Default=" RecentChanges TitleIndex UserPreferences RandomPage Help"
	
	' Major system options
	cWriteHTML			  = 0 + Cint(cRs.Fields("ow_writehtml")) '			Default=0		 ' 1 = serialise Wiki Pages  0 = no serialise	
	cReadOnly             = 0 + Cint(cRs.Fields("ow_readonly")) '			Default=0        ' 1 = readonly wiki         0 = editable wiki
	cNakedView            = 0 + Cint(cRs.Fields("ow_nakedview")) '			Default=0        ' 1 = run in naked mode     0 = show headers/footers
	cUseSubpage           = 0 + Cint(cRs.Fields("ow_usesubpage")) '			Default=1        ' 1 = use /subpages         0 = do not use /subpages
	cFreeLinks            = 0 + Cint(cRs.Fields("ow_freelinks")) '			Default=1        ' 1 = use [[word]] links    0 = LinkPattern only
	cWikiLinks            = 0 + Cint(cRs.Fields("ow_wikilinks")) '			Default=1        ' 1 = use LinkPattern       0 = possibly allow [[word]] only
	cAcronymLinks         = 0 + Cint(cRs.Fields("ow_acronymlinks")) '			Default=0        ' 1 = link acronyms         0 = do not link 3 or more capitalized characters
	cTemplateLinking      = 0 + Cint(cRs.Fields("ow_templatelinking")) '			Default=1        ' 1 = allow TemplateName->WikiLink   0 = don't do template linking
	cRawHtml              = 0 + Cint(cRs.Fields("ow_rawhtml")) '			Default=0        ' 1 = allow <html> tag      0 = no raw HTML in pages
	cMathML               = 0 + Cint(cRs.Fields("ow_mathml")) '			Default=0        ' 1 = allow <math> tag      0 = no raw math in pages
	cHtmlTags             = 0 + Cint(cRs.Fields("ow_htmltags")) '			Default=0        ' 1 = "unsafe" HTML tags    0 = only minimal tags
	cCacheXSL             = 0 + Cint(cRs.Fields("ow_cachexsl")) '			Default=0        ' 1 = cache stylesheet      0 = don't cache stylesheet
	cCacheXML             = 0 + Cint(cRs.Fields("ow_cachexml")) '			Default=0        ' 1 = cache partial results 0 = do not cache partial results
	cAllowRSSExport       = 0 + Cint(cRs.Fields("ow_allowrssexport")) '			Default=1        ' 1 = allow RSS feed        0 = do not export your pages to RSS
	cAllowNewSyndications = 0 + Cint(cRs.Fields("ow_allownewsyndications")) '			Default=1        ' 1 = allow new URLs to be syndicated    0 = only allow syndication of the URLs in the database table openwiki_rss
	cAllowAggregations    = 0 + Cint(cRs.Fields("ow_allowaggregations")) '			Default=1        ' 1 = allow aggregation of syndications (note: you MUST use MSXML v3 sp2 for this to work)   0 = do not allow aggregrations
	cEmbeddedMode         = 0 + Cint(cRs.Fields("ow_embeddedmode")) '			Default=0        ' 1 = embed the wiki into another app    0 = process browser request
	cAllowAttachments     = 0 + Cint(cRs.Fields("ow_allowattatchments")) '			Default=0        ' 1 = allow attachments     0 = do not allow attachments (WARNING: Allowing attachments poses a security risk!! See file owattach.asp)
	
	' Minor system options
	cSimpleLinks          = 0 + Cint(cRs.Fields("ow_simplelinks")) '			Default=1        ' 1 = only letters,         0 = allow _ and numbers
	cNonEnglish           = 0 + Cint(cRs.Fields("ow_nonenglish")) '			Default=1        ' 1 = extra link chars,     0 = only A-Za-z chars
	cNetworkFile          = 0 + Cint(cRs.Fields("ow_networkfile")) '			Default=0        ' 1 = allow remote file:    0 = no file:// links
	cBracketText          = 0 + Cint(cRs.Fields("ow_brackettext")) '			Default=1        ' 1 = allow [URL text]      0 = no link descriptions
	cBracketIndex         = 0 + Cint(cRs.Fields("ow_bracketindex")) '			Default=1        ' 1 = [URL] -> [<index>]    0 = [URL] -> [URL]
	cHtmlLinks            = 0 + Cint(cRs.Fields("ow_htmllinks")) '			Default=1        ' 1 = allow A HREF links    0 = no raw HTML links
	cBracketWiki          = 0 + Cint(cRs.Fields("ow_bracketwiki")) '			Default=1        ' 1 = [WikiLnk txt] link    0 = no local descriptions
	cShowBrackets         = 0 + Cint(cRs.Fields("ow_showbrackets")) '			Default=0        ' 1 = keep brackets         0 = remove brackets when it's an external link
	cFreeUpper            = 0 + Cint(cRs.Fields("ow_freeupper")) '			Default=1        ' 1 = force upper case      0 = do not force case for free links
	cLinkImages           = 0 + Cint(cRs.Fields("ow_linkimages")) '			Default=1        ' 1 = display image         0 = display link to image
	cUseHeadings          = 0 + Cint(cRs.Fields("ow_useheadings")) '			Default=1        ' 1 = allow = h1 text =     0 = no header formatting
	cUseLookup            = 0 + Cint(cRs.Fields("ow_uselookup")) '			Default=1        ' 1 = lookup host names     0 = skip lookup (IP only)
	cStripNTDomain        = 0 + Cint(cRs.Fields("ow_stripdomain")) '			Default=1        ' 1 = strip NT domainname   0 = keep NT domainname in remote username
	cMaskIPAddress        = 0 + Cint(cRs.Fields("ow_maskipaddress")) '			Default=1        ' 1 = mask last part of IP  0 = show full IP address in RecentChanges list, etc.
	cOldSkool             = 0 + Cint(cRs.Fields("ow_oldskool")) '			Default=1        ' 1 = use '' and '''        0 = don't use '' and ''' for italic and bold, and use Wiki''''''Link to escape WikiLink
	cNewSkool             = 0 + Cint(cRs.Fields("ow_newskool")) '			Default=1        ' 1 = use //, **, -- and __ 0 = don't use //, **, -- and __ for italic, bold, strikethrough and underline and use ~WikiLink to escape WikiLink
	cNumTOC               = 0 + Cint(cRs.Fields("ow_numtoc")) '			Default=0        ' 1 = TOC numbered          0 = TOC just indented text
	cNTAuthentication     = 0 + Cint(cRs.Fields("ow_ntauthentication")) '			Default=1        ' 1 = Use NT username       0 = blank username in preferences
	cDirectEdit           = 0 + Cint(cRs.Fields("ow_directedit")) '			Default=1        ' 1 = go direct to edit     0 = go to blank page first
	cAllowCharRefs        = 0 + Cint(cRs.Fields("ow_allowcharrefs")) '			Default=1        ' 1 = allow char refs       0 = no character references allowed (like &copy; or &#151;)
	cWikifyHeaders        = 0 + Cint(cRs.Fields("ow_wikifyheaders")) '			Default=0        ' 1 = wikify headers        0 = do not apply wiki formatting within headers
	
	' User options
	cEmoticons            = 0 + Cint(cRs.Fields("ow_emoticons")) '			Default=1        ' 1 = use emoticons         0 = don't show feelings
	cUseLinkIcons         = 0 + Cint(cRs.Fields("ow_uselinkicons")) '			Default=0        ' 1 = icons for ext links   0 = no icon images for external links
	cPrettyLinks          = 0 + Cint(cRs.Fields("ow_prettylinks")) '			Default=1        ' 1 = display Words Smashed Together     0 = display WordsSmashedTogether
	cExternalOut          = 0 + Cint(cRs.Fields("ow_externalout")) '			Default=1        ' 1 = external links open in new window, 0 = open in same window
	
End If
cRS.Close
If cConn.Errors.Count=0 then
		cConn.CommitTrans()
Else
		cConn.RollbackTrans()
End If

set cConn = Nothing
set cRs = Nothing

%>
