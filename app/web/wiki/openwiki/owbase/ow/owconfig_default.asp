<%
'        $Log: owconfig_default.asp,v $
'        Revision 1.66  2007/01/30 14:30:20  sansei
'        Moved 'tag' settings from owtag.asp to owconfig_default.asp for userfriendlyness
'
'        Revision 1.65  2007/01/29 23:50:27  sansei
'        moved line: "If cAllowImageLibrary...." to bottom for better overview
'        Defaults are: cAllowImageLibrary = 0, cAllowAttachments=0
'
'        Revision 1.64  2007/01/29 23:05:10  sansei
'        made AllowFlash = 1, AllowAttachments = 0 (last for a secure default installation)
'
'        Revision 1.63  2007/01/29 18:45:53  sansei
'        added that CVS changes are (again) logged in this file
'
'
' ********************************************************************
ServerDown = 0 '        // Possible values 0|1
' If you want the server to display a "Down for Maintainance message"
' whilst you do a backup, then Set ServerDown = 1 and the database
' will not be accessed, and the users session terminated
' ********************************************************************
if ServerDown then DoServerDownForMaintainance
' Following are all the configuration items with default values set.
' Override them if you want in a separate file, see e.g. /web1/ow.asp.
'        // ***********************************************************************
'        // *                   ** CONFIGURATION FILE **
'        // *
'        // * Any line in this file that starts with an apostrophe (') is a comment
'        // * To ""uncomment" a line, delete the starting apostrophe
'        // * To ""comment"" a line, insert an apostrophe at the start of it
'        // *
'        // * Commented code lines will be ignored by the Wiki processor
'        // ***********************************************************************

' ============ START MSACCESS SECTION =================
'        // HERE ARE THE VALUES FOR AN ACCESS INSTALL OF OPENWIKING
AccessDebugTest = 0 '        // Possible values 0|1|2|3  (=0 turns testing off)
'        // Run the tests in sequence: 1, then 2 then 3 etc.
'        // Each test is more comprehensive than the last.
'        // If you set AccessDebugTest = 1
'        // then you can troubleshoot whether
'        // the values for C_WIKIROOT and C_VIRTUALACCESSPATH
'        // are set correctly for your server
'                 // AccessDebugTest=1 is ONLY FOR MSAccess FILE DSN DATABASES
'                 // AccessDebugTest=2 opens and closes the database connection
'                 // AccessDebugTest=3 attempts to write, then read a value into the database

'        // If your data folder is at the same level as the ow and owadmin folder, then C_WIKIROOT
'        // will be (slash)wikifolder
'        // IN ALL CASES, C_WIKIROOT WILL NEVER END IN A FORWARD SLASH
'        // Example: /openwiking
'        // If your data folder is off the server root (so as users cannot see or access it through http) then wikiroot
'        // will be blank
'        // IN MOST CASES, C_VIRTUALACCESSPATH WILL START WITH A FORWARD SLASH,
CONST C_WIKIROOT = ""  ' // An empty string (""), OR whatever folder the ow folder is installed under
'        // It must NOT end in a slash character
'        // WARNING! IF C_WIKIROOT IS NON-BLANK, THEN USERS COULD POTENTIALLY DOWNLOAD
'        // YOUR WIKI DATABASE.  IF THIS IS DESIRABLE (for downloadable backups, for instance) THEN
'        // YOU SHOULD PUT YOUR MDB FILE IN THE openwiking/data FOLDER AND SET C_WIKIROOT TO "/openwiking"
'		 // If you run your wiki as the root page, leave it as an empty string.

CONST C_VIRTUALACCESSPATH = "data/OpenWikiNG.mdb"  ' // The web path to your access file on your server
' TO TEST THESE SETTINGS, SET AccessDebugTest to 1, 2 or 3.
' You can avoid setting all this stuff by using an ODBD DSN name for your connection (see below)
OPENWIKI_DB_SYNTAX = DB_ACCESS '        // Possible alternative values in owpreamble.asp
accesspath=Server.MapPath(C_WIKIROOT & C_VIRTUALACCESSPATH)
 '        // accesspath = the windows path on the server for the MSAccess database mdb file

'        // MSAccess SYNTAX #1 (Native MSAccess OLEDB JET driver)
OPENWIKI_DB = "Provider=Microsoft.Jet.OLEDB.4.0;Data source=" & accessPath & ";User ID=admin;Password=;"
'        // MSAccess SYNTAX #2 (Generic Access driver)
' OPENWIKI_DB = "Driver={Microsoft Access Driver (*.mdb)};DBQ=" & accesspath & ";"
' ============ END MSACCESS SECTION =================

' ============ START FIREBIRD SECTION ===============
'OPENWIKI_DB_SYNTAX = DB_FIREBIRD ' Override
'OPENWIKI_DB = "Provider=IBOLE.Provider.v4;data source=MYSERVER:openwiki.fdb;uid=<USER>;password=<PASSWORD>"
' ============ END FIREBIRD SECTION  ================
' ****************************************************************************

' ****************************************************************************
' // ODBC DSN - THE BEST WAY TO CONNECT TO THE DATABASE! //
' // If you have set up an ODBC DSN connection, put the name of it here
'OPENWIKI_DB = "openwiking" ' Override earlier setting
' ****************************************************************************

' ****************************************************************************
' SQL Server (best with an ODBC connection, but you can set the connection string here)
'OPENWIKI_DB = "Driver={SQL Server};server=mymachine;uid=openwiki;pwd=openwiki;database=OpenWiki"
' or OPENWIKI_DB = "Provider=SQLOLEDB; Data Source=sql_server; Initial Catalog=sql_database;User Id=username; Password=password;"
'OPENWIKI_DB_SYNTAX = DB_SQLSERVER ' Override earlier setting
' ****************************************************************************

OPENWIKING_UPDATEDB = 1 '        // Change this to 0 once the Wiki is running OK

'        // Alternative values for other Databases
' OPENWIKI_DB = "MySystemDSName"
' OPENWIKI_DB = "MySQLOpenWiki"
' OPENWIKI_DB = "PostgreSQLOpenWiki"
' ****************************************************************************

'        // DEBUG TESTS START
If OPENWIKI_DB_SYNTAX = DB_ACCESS then
        If AccessDebugTest = 1 then Call DoAccessDebugTest1'        // only called if AccessDebugTest=1
End If
If AccessDebugTest = 2 then Call DoDBDebugTest2
If AccessDebugTest = 3 then Call DoDBDebugTest3
Server.ScriptTimeout=30 ' 30 seconds before script errors make the server give up
'        // DEBUG TESTS END

' // BRANDING //
OPENWIKI_TITLE           = "OpenWikiNG"       ' title of your wiki
OPENWIKI_FRONTPAGE       = "FrontPage"        ' name of your front page.
OPENWIKI_WELCOMEPAGE     = ""                 ' name of your welcome page - use empty string "" if you do not want to use a welcomepage.
OPENWIKI_ACTIVESKIN      = ""                 ' Set to the directory under /skins that you want to use. (NOT directory "common"!)

' // SYSTEM //
OPENWIKI_SCRIPTNAME      = "ow.asp"           ' "mydir/ow.asp" : in case the auto-detected scriptname isn't correct
OPENWIKI_MAXTEXT         = 204800             ' Maximum 200K texts
OPENWIKI_MAXINCLUDELEVEL = 5                  ' Maximum depth of Include's
OPENWIKI_ENCODING        = "UTF-8"       ' character encoding to use
OPENWIKI_IMAGEPATH       = "ow/images"        ' path to images directory
OPENWIKI_ICONPATH        = "ow/images/icons"  ' path to icons directory
OPENWIKI_RCDAYS          = 30                 ' Default number of RecentChanges days
OPENWIKI_MAXTRAIL        = 5                  ' Maximum number of links in the trail
OPENWIKI_TEMPLATES       = "Template$"        ' Pattern for templates usable when creating a new page
OPENWIKI_TIMEZONE        = "+01:00"           ' Timezone of the server running this wiki, valid values are e.g. "+04:00", "-09:00", etc.
OPENWIKI_MAXNROFAGGR     = 150                ' Maximum number of rows to show in an aggregated feed
OPENWIKI_MAXWEBGETS      = 3                  ' Maximum number of RSS feeds that may be refreshed from a remote server for one user request.
OPENWIKI_SCRIPTTIMEOUT   = 120                ' Maximum amount of seconds to wait for RSS feeds to be syndicated, if set to 0 the default timeout value of ASP is used.
OPENWIKI_DAYSTOKEEP      = 30                 ' Number of days to keep old revisions
                                                                                          ' IMPORTANT: Anonymous IIS user (IUSR_machinename) - or authenticated user in intranet setup -
                                                                                          '            must have "write" access to this location!
' // ATTATCHMENTS //
OPENWIKI_UPLOADDIR       = "attachments/"     ' The virtual directory where uploads are stored
OPENWIKI_IMAGELIBRARY    = "attachments/images/"     ' The virtual directory where wiki-wide image files (local:) are stored (relative to owbase!!)
OPENWIKI_UPLOADMETHOD = UPLOADMETHOD_LEWISMOTEN 'These methods are defined in owpreamble.asp.  Select the one that matches
' or OPENWIKI_UPLOADMETHOD = UPLOADMETHOD_ABCUPLOAD ' the method, COM component or default script-only upload, you wish to use.
' or OPENWIKI_UPLOADMETHOD = UPLOADMETHOD_SAFILEUP
OPENWIKI_MAXUPLOADSIZE   = 8388608            ' Use to limit the size of uploads, in bytes (default = 8,388,608)
OPENWIKI_UPLOADTIMEOUT   = 300                ' Timeout in seconds (upload must succeed within this time limit)

MSXML_VERSION = 3   ' use 4 if you've installed MSXML v4.0

'	// Default error/success page names
OPENWIKI_ERRORPAGENAME = "ErrorPage"
OPENWIKI_SUCCESSPAGENAME = "SuccessfulAction"
gErrorPageText="There has been an unexpected error which is not your fault."
gSuccessPageText="The operation was successful."


' // SECURITY //
gReadPassword = ""    ' use empty string "" if anyone may read
gEditPassword = ""    ' use empty string "" if anyone may edit
' // CHANGE THE FOLLOWING 2 OPTIONS!! //
gAdminPassword = "adminpw"   ' use empty string "" if anyone may administer this Wiki
gWikiAdministrator = "Wikiadmin" ' username for special admin functions
' // This will only apply if you have a local IP to the server (10.x.x.x for example)
' Or you have added your IP to the array in owpreamble.asp
' // In case you want more sophisticated security, then you should
' rely on the Integrated Windows authentication feature of IIS.

' // BOOKMARKS //
' // These names correspond to the openWiking disttribution pages, but you can change them
OPENWIKI_RCNAME          = "RecentChanges"    ' Name of recent changes page (change space to _)
OPENWIKI_UPNAME          = "UserPreferences"  ' Name of user preferences page (change space to _)
OPENWIKI_TINAME          = "TitleIndex"       ' Name of title index (change space to _)
OPENWIKI_CINAME          = "CategoryIndex"    ' Name of category index (change space to _)
OPENWIKI_HELPNAME        = "HelpPage"         ' Name of Help Page (change space to _)
OPENWIKI_RPNAME          = "RandomPages"      ' Name of RandomPages Page (change space to _)
OPENWIKI_FINDNAME        = "FindPage"         ' Name of Find Page page
OPENWIKI_STOPWORDS       = "StopWords"        ' Name of page containing stop words (change space to _). Stop words are words that won't be hyperlinked. Use empty string "" if you do not want to support stop words.
OPENWIKI_SYNONYMLINKPAGE = "SynonymLinks"           ' The page where to find the synonymized links

gDefaultBookmarks = OPENWIKI_FRONTPAGE & " " &_
OPENWIKI_RCNAME & " " &_
OPENWIKI_TINAME & " " &_
OPENWIKI_CINAME & " " &_
OPENWIKI_UPNAME & " " &_
OPENWIKI_RPNAME & " " &_
OPENWIKI_FINDNAME & " " &_
OPENWIKI_HELPNAME
gDefaultPageBookmarks="SandBox" ' Fixed extra page bookmarks on every page? (cannot be overridden by UserPreferences)
gDefaultPageBookmarksHeading="" ' With a heading?

'	// Default error/success page text
gErrorPageText="There has been an unexpected error which is not your fault."
gSuccessPageText="The operation was successful."

'	// Default edit/view restrictions
OPENWIKI_EDITERRORPAGE="EditError"
OPENWIKI_VIEWERRORPAGE="ViewError"

' //Shared image Upload page name//
OPENWIKI_IMAGEUPLOADPAGE="ImageUpload"
' // Note: if cAllowImageLibrary=0 then it is disabled//

' // CAPTCHA //
OPENWIKI_CAPTCHA_ERRORPAGE="CaptchaError"	' Page usere are redirected to on a failed CAPTCHA attempt
OPENWIKI_CAPTCHA_SERVERPAGE="http://www.bamber.com/capcha/index.asp"
'	// If the above server is down, substitute from the URLs below
' OPENWIKI_CAPTCHA_SERVERPAGE="http://www.openwiking.com/develop/captcha/index.asp"

' Archiving Options (for serialiseXML|HTML.asp and rolling saves)
cWriteXML             = 0        ' 1 = serialise Wiki Pages to XML 0 = no serialise
cWriteXMLFoldername   = "savedxml" ' Folder off /owbase in which to save XML files into. MUST BE WRITEABLE!
cWriteHTML            = 0        ' 1 = serialise Wiki Pages to HTML 0 = no serialise
cWriteHTMLFoldername  = "savedhtml" ' Folder off /owbase in which to save XML files into. MUST BE WRITEABLE!

' Major system options
cReadOnly             = 0        ' 1 = readonly wiki         0 = editable wiki
cNakedView            = 0        ' 1 = run in naked mode     0 = show headers/footers
cUseSubpage           = 1        ' 1 = use /subpages         0 = do not use /subpages
cFreeLinks            = 1        ' 1 = use [[word]] links    0 = LinkPattern only
cWikiLinks            = 1        ' 1 = use LinkPattern       0 = possibly allow [[word]] only
cAcronymLinks         = 0        ' 1 = link acronyms         0 = do not link 3 or more capitalized characters
cTemplateLinking      = 1        ' 1 = allow TemplateName->WikiLink   0 = don't do template linking
cRawHtml              = 0        ' 1 = allow <html> tag      0 = no raw HTML in pages
cMathML               = 0        ' 1 = allow <math> tag      0 = no raw math in pages
cHtmlTags             = 0        ' 1 = "unsafe" HTML tags    0 = only minimal tags
cCacheXSL             = 1        ' 1 = cache stylesheet      0 = don't cache stylesheet
cCacheXML             = 0        ' 1 = cache partial results 0 = do not cache partial results
cEmbeddedMode         = 0        ' 1 = embed the wiki into another app    0 = process browser request
cAllowRSSExport       = 1        ' 1 = allow RSS feed        0 = do not export your pages to RSS
cAllowNewSyndications = 1        ' 1 = allow new URLs to be syndicated    0 = only allow syndication of the URLs in the database table openwiki_rss
cAllowAggregations    = 1        ' 1 = allow aggregation of syndications (note: you MUST use MSXML v3 sp2 for this to work)   0 = do not allow aggregrations
cAllowAttachments     = 0        ' 1 = allow attachments     0 = do not allow attachments (WARNING: Allowing attachments poses a security risk!! See file owattach.asp)
cAllowImageLibrary    = 0        ' 1 = allow Image Library   0 = do not Image Library (WARNING: Allowing attachments poses a security risk!! See file owattach.asp)
cAllowFlash           = 1        ' 1 = allow Flash movies    0 = do not allow Flash movies
cAllowBadge           = 1        ' 1 = Allow Flash Badge     0 = Don't allow Flash Badge
cAllowWebframe        = 1        ' 1 = Allow Webframe macro  0 = Don't allow Webframe macro
cAllowAnyPageName     = 1        ' 1 = No Restrictions                 0 = Capitalise, Remove spaces, + and _ chrarcters
cDisableExecuteMacro  = 1        ' 1 = Disable the <Execute> macro        0 = Allow the <execute> macro with gAdminPassword
cAllowRedirectPage    = 1        ' 1 = Allow the RedirectPage macro		0= Disallow the RedirectPage macro
cShowRedirectPageloader=1		 ' 1 = Show dialog when executing RedirectPage macro	0 = Don't show dialog
cUseSummary           = 1        ' 1 = Use Summary         0 = Don''t use Summaries
cShowGoogleAds        = 0        ' 1 = Show Google Ads on each page 0 = Don't show Google Ads on each page

cUseTags              = 1        ' 1 = Use Tags and TagCloud system. 0 = disable Tags and TagCloud system
cTagsSplit            = 1        ' 1=" ",split by blank.; 0=",", premise  " " in tag
cCacheTags            = 0        ' 1=Cache Tagsxml,update when act; 0=update only a new day
cTagSizeStyle         = 1        ' 1="px";0="%"
OPENWIKI_TagsName     = "tags"   ' Name to display for this functionality (Tag, TagCloud...)


' Minor system options
cDatePagenameFormat   = 1        ' 0 = Default date-pagenames ('Date'Day month-name YYYY)
                                 ' 1 = Sortable long ('Date'YYYY-MM-DD)
                                 ' 2 = Sortable medium ('Date'YYYYMMDD)
                                 ' 3 = Sortable short (YYYY-MM-DD)
                                 ' 4 = Sortable mini (YYYYMMDD)
cUseMultipleParents   = 1        ' 1 = use @parent/@parent../@parent syntax 0 = Use @parent,@grandparent,@greatgrandparent syntax
cFullsearchHighlight  = 1        ' 1 = Do Fullsearch Highlight 0 = Do not Fullsearch Highlight
cSimpleLinks          = 1        ' 1 = only letters,           0 = allow _ and numbers
cNonEnglish           = 1        ' 1 = extra link chars,       0 = only A-Za-z chars
cNetworkFile          = 0        ' 1 = allow remote file:      0 = no file:// links
cBracketText          = 1        ' 1 = allow [URL text]        0 = no link descriptions
cBracketIndex         = 1        ' 1 = [URL] -> [<index>]      0 = [URL] -> [URL]
cHtmlLinks            = 1        ' 1 = allow A HREF links      0 = no raw HTML links
cBracketWiki          = 1        ' 1 = [WikiLnk txt] link      0 = no local descriptions
cShowBrackets         = 0        ' 1 = keep brackets           0 = remove brackets when it's an external link
cFreeUpper            = 1        ' 1 = force upper case        0 = do not force case for free links
cLinkImages           = 1        ' 1 = display image           0 = display link to image
cUseHeadings          = 1        ' 1 = allow = h1 text =       0 = no header formatting
cUseLookup            = 1        ' 1 = lookup host names       0 = skip lookup (IP only)
cStripNTDomain        = 1        ' 1 = strip NT domainname     0 = keep NT domainname in remote username
cMaskIPAddress        = 1        ' 1 = mask last part of IP    0 = show full IP address in RecentChanges list, etc.
cOldSkool             = 1        ' 1 = use '' and '''          0 = don't use '' and ''' for italic and bold, and use Wiki''''''Link to escape WikiLink
cNewSkool             = 1        ' 1 = use //, **, -- and __   0 = don't use //, **, -- and __ for italic, bold, strikethrough and underline and use ~WikiLink to escape WikiLink
cNumTOC               = 0        ' 1 = TOC numbered            0 = TOC just indented text
cNTAuthentication     = 1        ' 1 = Use NT username         0 = blank username in preferences
cDirectEdit           = 1        ' 1 = go direct to edit       0 = go to blank page first
cAllowCharRefs        = 1        ' 1 = allow char refs         0 = no character references allowed (like &copy; or &#151;)
cWikifyHeaders        = 1        ' 1 = wikify headers          0 = do not apply wiki formatting within headers
cWikifyPageTitles     = 1        ' 1 = wikify page titles          0 = do not apply wiki formatting to page titles
' User options
cEmoticons            = 1        ' 1 = use emoticons         0 = don't show feelings
cUseLinkIcons         = 1        ' 1 = icons for ext links   0 = no icon images for external links
cUseInterWikiIcons    = 0        ' 1 = icons for interwiki links      0 = no icon images for interwikis
cPrettyLinks          = 1        ' 1 = display Words Smashed Together     0 = display WordsSmashedTogether
cExternalOut          = 1        ' 1 = external links open in new window, 0 = open in same window
cAutoComment          = 1        ' 1 = Fill in comment field in edit mode, 0 = Leave comment field blank
cUseAccessibility     = 1        ' 1 = Turn on accessibility fratures, 0 = Do not use accessibility features

cShowOldEmoticons     = 1        ' 1 = Include OpenWiki0.78 syntax, 0 = Ignore old syntax
cTitleIndexIgnoreCase = 0        ' 1 = Ignore case when compiling the Title Index, 0 = Differenciate LC and UC
'        // PAGE TYPES
cUseCategories        = 1         ' 1 = Use Page Types, 0 = Don''t use Page Types
cReadCategoriesFromDB = 0	  ' 1 = all categories are read from the db, 0 = use hardcoded categories ( see below )
cSortCategories       = 0         ' 1 = Sort Page Types alphabetically, 0=Leave the order alone

' next line moved here for better overview /sEi
If cAllowImageLibrary then gDefaultPageBookmarks=gDefaultPageBookmarks & " " & OPENWIKI_IMAGEUPLOADPAGE

if cReadCategoriesFromDB = 0 then
	' // Change these entries to your way of classifying page types
	' // == Warning == If you have already classified your content, then
	' //                changes here will re-classify existing pages!
	' // Note: Set the upper bound of the array first !
	Redim PRESERVE gCategoryArray( 22 )
	gCategoryArray(1)="Unfinished"
	gCategoryArray(2)="Article"
	gCategoryArray(3)="Testing Page"
	gCategoryArray(4)="Help Page"
	gCategoryArray(5)="Menu Page"
	gCategoryArray(6)="Webframe Page"
	gCategoryArray(7)="Demo Page"
	gCategoryArray(8)="Included Page"
	gCategoryArray(9)="System Page" ' Leave this one alone at #9
	gCategoryArray(10)="Temporary Page"
	gCategoryArray(11)="RSS Feed Page"
	gCategoryArray(12)="Aggregate Page"
	gCategoryArray(13)="Calendar Page"
	gCategoryArray(14)="Bookmarks Page"
	gCategoryArray(15)="Admin edit only"
	gCategoryArray(16)="User Home Page"
	gCategoryArray(17)="Redirect Page"
	gCategoryArray(18)="Root Page"
	gCategoryArray(19)="Subroot Page"
	gCategoryArray(20)="Protected Edit"
	gCategoryArray(21)="Protected View"
	gCategoryArray(22)="Protected View and Edit"
end if


' ============================================================================
'        // END OF USER VARIABLES
' ============================================================================
%>
