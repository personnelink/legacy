<%
'        $Log: owpreamble.asp,v $
'        Revision 1.238  2007/03/06 13:35:53  sansei
'        making version (20070306) for a pre alpha release - skins: default, default_left and evolution is installed - the other outdated skins are STILL avaiable in owskinning.asp
'
'        Revision 1.237  2007/01/30 14:30:20  sansei
'        Moved 'tag' settings from owtag.asp to owconfig_default.asp for userfriendlyness
'
'        Revision 1.236  2007/01/29 21:24:12  sansei
'        made new build number (in the straightening CVS process)
'
'        Revision 1.235  2007/01/07 11:24:40  piixiiees
'        gFS=Chr(222) due to problems working with Chr(179) in utf-8 and some files saved with encoding="utf-8"
'
'        Revision 1.234  2006/08/15 13:24:23  piixiiees
'        Transform OpenWikiNG to UTF-8 enconding:
'        1. ow/owconfig_default.asp
'        OPENWIKI_ENCODING = "UTF-8"
'        Unicode (UTF-8 with signature) - Codepage 65001
'        2. ow.asp and default.asp
'        Unicode (UTF-8 with signature) - Codepage 65001
'        3. (Pending) owadmin/deprecate.asp.htm
'        Unicode (UTF-8 with signature) - Codepage 65001
'        4. ow/plugins/owplugin_WYSIWYG.xsl
'        <?xml version="1.0" encoding="UTF-8"?>
'        5. ow/skins/default/ow.xsl ToDo? with all the skins
'        <?xml version="1.0" encoding="UTF-8"?>
'        Bug of broken symbols in preview windows fixed: sourceforge.net bug 1362452
'
'        Revision 1.233  2006/04/20 06:37:15  piixiiees
'        Temporary copy of skins/common/*.* to evolution skin to be able to modify the structure of the skin without impacting to other skins.
'        New style of BrogressBar; now printable the progress
'        New file macros.xsl to include the templates for the macros.
'
'        Revision 1.232  2006/04/10 08:59:29  gbamber
'        Build 20060407:
'
'        BugFix for Oracle:
'        When editing a page in invalid syntax was used to update attachments.
'        changes in:
'        owdb.asp
'
'        New Authorisation Subs for customizable Authorisation. New myauth.asp containing to the two new Subs.
'        changes in:
'        owall.asp
'        owplugin_viewrestrictions.asp
'        owplugin_editrestrictions.asp
'        myauth.asp
'
'        New Functions for more customizable wikify patterns.
'        changes in:
'        owpatterns.asp
'        mywikify.asp
'
'        New option cReadCategoriesFromDB. If its set to 1 then additional categories are read from the db.
'        changes in:
'        owconfig_default.asp
'        owpreamble.asp
'        owprocessor.asp
'
'        Note:
'        The values of KEY_CATEGORIES in OPENWIKI_CATEGORIES MUST MATCH their current entry !
'        e.g. last hardcoded categorie is No.22 "Protected View and Edit",
'        so the first entry in OPENWIKI_CATEGORIES must be 23 "whatever category" and the next 24 etc.
'
'        if you have any questions you can also mail me to vagabond@gmx.com.
'
'        Revision 1.232  2006/04/07 17:27:15  Vagabond
'        made build to num: 20060407 - for download
'	 gCategoryArray is now unlimited, new Option cReadCategoriesFromDB
'
'        Revision 1.231  2006/03/22 19:07:15  sansei
'        made build to num: 20060322 - for download
'
'        Revision 1.230  2006/03/22 01:46:47  piixiiees
'        - Small bugfix with the command Edit (link on top) when editing old revisions. Remove of blanks in the URL. Skins affected plastic and evolution.
'        - Extract the editing layout from the ow.xsl to a dedicated file editor.xsl
'
'        Revision 1.229  2006/03/19 23:00:41  piixiiees
'        New option cUseInterWikiIcons to use icons for interwiki links:
'         * cUseInterWikiIcons=0 Help:HelpEditing
'         * cUseInterWikiIcons=1 ? HelpEditing (where ? is a small icon)
'        Style for thumbs of ShowSharedImages splitted from ow.css. Now thumbs.css is available for evolution skin
'
'        Revision 1.228  2006/03/18 19:53:20  piixiiees
'        Point Update 20060304.4
'        MacroShowSharedImages updated
'         * cAllowImageLibrary checked
'         * SyntaxErrorMessage included
'         * parameters controlled
'         * gImageExtensions validated
'         * ow.css style updated: div.figure, div.figure p, img.scaled
'        Bug attachments fixed:
'         * CreateFolders routine duplicated. The one in owuploadimage.asp renamed as CreateImageFolder
'
'        Revision 1.227  2006/03/14 08:59:31  gbamber
'        Point Update: 20060304.3
'        Enhancement: ErrorStack now more configerable
'        BugFix: hardcoded pages now display correctly
'        Test: <showsharedimages(foobar)> shows the errorstack at work
'        BugFix: ShowErrors now clears the error stack when called
'
'        Revision 1.226  2006/03/13 20:48:15  piixiiees
'        Point update 20060304.2
'        owwikify.asp
'        New folder images in every skin. All the icons will be retrieved from the skin folder.
'        Change to use the link icons from this folder.
'        vLink = vLink & "<img src=""" & GetSkinDir() & "/images" & vImg & " border=""0"" hspace=""2"" alt=""""/>"
'
'        New macro ShowSharedImages to show all the files in the folder of shared images.
'        New styles included in ow.css files.
'
'        Revision 1.225  2006/03/11 16:44:44  gbamber
'        Added ErrorStack helpers in owprocessor.asp
'
'        Revision 1.223  2006/03/11 13:20:56  gbamber
'        Added owClsErrorStack to owall.asp
'
'        Revision 1.222  2006/03/04 12:02:21  sansei
'        Updated buildnumber to 20060304 for a beta release
'
'        Revision 1.221  2006/03/03 09:36:51  gbamber
'        Updated build with point update
'
'        Revision 1.220  2006/02/22 12:27:14  gbamber
'        Build 20060216.6
'        Bugfixes to ImageUpload and DeletePage
'        Hardcoded ImageUpload page into owdb.asp
'        Only if cAllowImageLibrary=1 will UploadImage work.
'
'        Revision 1.219  2006/02/22 11:26:03  gbamber
'        Build 20060216.5
'        ImageUpload now uses ActionView for it's result page.
'        Taken out some generic Requests so that we no longer have to use Response.Redirect to report an error to the user
'
'        Revision 1.218  2006/02/22 10:22:27  gbamber
'        Build 20060216.4
'
'        Revision 1.217  2006/02/22 10:17:12  gbamber
'        Build 20060216.4
'        Changed refs of local: to sharedimage:
'        Softcoded error and success page names
'        Surrounded frontpage var with <nowiki> tags
'        Restored DeletePageAndAttachments function in owdb
'
'        Revision 1.216  2006/02/20 09:00:27  gbamber
'        build 20060216.2
'        Restored defaukt cacheXSL=1
'        plastic skin now uses included bookmarks.xsl
'
'        Revision 1.215  2006/02/16 18:42:52  gbamber
'        Minor syntax error - ignore
'
'        Revision 1.214  2006/02/16 18:33:16  gbamber
'        General update:
'        Rename improved
'        local: now sharedimage:
'        New imageupload macro
'        added file uploadimage.asp
'        changed owall to fix #includes with attach.asp
'        new doctypes for google earth
'        new urltype skype
'        Userprefs has a password field
'        Reaname template updated
'
'        Revision 1.213  2006/02/16 17:01:30  sansei
'        Updated buildnumber in order to release a updated zip
'
'        Revision 1.212  2006/02/13 13:00:57  gbamber
'        Point update (rename/config)
'
'        Revision 1.211  2006/01/09 10:10:55  gbamber
'        Added #ALLOWVIEW directive
'        Changed filename 'accessrestrictions' to 'edfitrestrictions'
'        Added page name constants to owpreamble
'        Inactivated CAPTCHA plugin by default
'
'        Revision 1.210  2005/12/14 20:39:57  gbamber
'        BugFix:Updated hardcoded 'Help' link in editing window
'        BugFix:Updated gStrictLinkPattern to include underscores
'        BugFix:Changed scope of userprefs cookie
'        New:Action UpgradeFreelinks
'        New:Added Maintainance link to admin control panel
'        New:Added parameter to SuccessfulAction page
'        New:owdb function to upgrade freelink pages
'
'        Revision 1.209  2005/12/10 08:38:08  gbamber
'        BUILD 20051210
'        New: <RedirectPage>
'        New <CreateSubPage>
'        BugFix: CreatePage macro code
'        BugFix: Userprefs back link
'        BugFix: CAPTCHA now works
'        BugFic: cUseFreeLinks=0 option works correctly
'        BugFix: Page rename partly repaired
'        BugFix: forceusername uses persistent cookie
'        //Gordon//
'
'        Revision 1.208  2005/11/23 16:07:51  sansei
'        updated openwiking.mdb to use ONLINE help at HelpWiki - Either you have to press a link or if you allow rawhtml the help will redirect automagical
'
'        Revision 1.207  2005/11/08 16:34:40  sansei
'        WELCOME OPENWIKING 2005
'        Added new database (openwiking.mdb)
'        Easy access install (unzip-->webshare folder-->run)
'        New DB have updated InterWikis:
'             OpenWiking:
'             OpenWikingPage:
'             HelpWiki:
'             HelpWikiPage:
'             DevWiki:
'             DevWikiPage:
'        Flashlogo updated to openwiking.com
'        Automagical CreditsPage is updated slightly
'        In connection with this update the new site is up:
'        WWW.OPENWIKING.COM
'        Here you find everything openwiking
'
'        Please enjoy
'
'        /sEi
'
'        Revision 1.206  2005/11/07 23:51:56  sansei
'        removed references to openwiki.info
'
'        Revision 1.205  2005/04/16 17:34:26  casper_gasper
'        no message
'
'        Revision 1.204  2005/04/16 17:17:17  casper_gasper
'        added support for Firefox to the wikiedit.
'
'        Revision 1.203  2005/03/28 21:35:16  sansei
'        added simple/advanced optional flash-logo (to be set in mystyle.xsl)
'
'        Revision 1.202  2005/03/07 05:06:49  sansei
'        changed OPENWIKI_VERSION to "1 alpha"
'
'        Revision 1.201  2005/03/06 15:31:18  sansei
'        .
'
'        Revision 1.200  2005/03/06 15:27:32  sansei
'        NO VERSION CHANGE!
'
'        Revision 1.199  2005/03/05 03:40:43  sansei
'        updated Badge, owng-logo and PageTool - is now seperate sourceforge projects
'
'        Revision 1.198  2005/03/03 21:15     Casper
'        Changed owconfig_default.asp and SQL Server creation script.
'
'        Revision 1.197  2005/03/03 12:57:42  sansei
'        Added 'FlashLogo' - If AllowFlash then the page logo is displayed with a flash file (pt. default, default_left only) - You can disable any use of FlashLogo in myskin.xsl
'
'        Revision 1.196  2005/03/01 06:08:38  sansei
'        added OPTIONAL new syntax for PageBookmarks
'        If a * (star) is present in the macro data then use multible pagebookmarks syntax, if NOT then use single syntax.
'
'        Revision 1.195  2005/02/24 23:13:36  sansei
'        NEW PLUGIN: UseIncludes - To include userdefined data and expose it for the XSL.
'
'        Revision 1.194  2005/02/21 13:29:05  gbamber
'        BUGFIX: Error in rename function fixed
'
'        Revision 1.193  2005/02/20 11:10:06  gbamber
'        UPDATED: #NOW directive
'        ADDED: #NOWD and #NOWT directives
'        UPDATED: WYSIWYG Macro dropdown
'
'        Revision 1.192  2005/02/16 15:31:58  gbamber
'        UPDATED: Automatic CreditsPage code
'        FIXED: Duplicate SummarySearch entries
'
'        Revision 1.191  2005/02/11 21:10:44  sansei
'        Added changed logo graphics
'
'        Revision 1.190  2005/02/11 11:38:52  gbamber
'        Build 20050211
'        Added:
'        cShowOldEmoticons     = 1        ' 1 = Include OpenWiki0.78 syntax, 0 = Ignore old syntax
'        cTitleIndexIgnoreCase = 0        ' 1 = Ignore case when compiling the Title Index, 0 = Differenciate LC and UC
'
'        Revision 1.189  2005/02/09 02:48:00  dtremblay
'        Added const DB_FIREBIRD=5.
'
'        Revision 1.188  2005/01/24 00:13:38  casper_gasper
'        no message
'
'  Revision 1.188  2005/01/23 23:10     Casper
'  Bug fix for wikiedit and msxmlv4 (b0rked rendering on screen)
'  File uploading should now work with every DOM level 1 compliant browser.
'
'        Revision 1.187  2005/01/21 20:35:00  sansei
'        Fixed skin default_left: fullsearch result not truncating MAIN bookmarks
'        Fixed skin default_left: not showing pagebookmarks bold
'        TextSearch can now use truncate syntax (see other truncate demo)
'        SummarySearch can now use truncate syntax (see other truncate demo) 
' 
'        Revision 1.186  2005/01/21 15:49:21  sansei
'        reverted to previous version (before msxml4-fix) - Update had serious errors!
'
'        Revision 1.184  2005/01/18 15:28:38  sansei 
'        Added new PLUGIN macro: ShowFile
'        Allows dump of a file from the server.
'        Default setting allow to dump all files in 'owbase' BUT not 'owconfig_default.asp'
'        See settings in 'owpluginfunnel.asp'.
'
'        Revision 1.183  2005/01/18 13:37:04  sansei
'        Made so if AllowBadges = 0 then the editor doesnt show badges in the interface.
'
'        Revision 1.182  2005/01/17 18:05:44  sansei
'        EDITOR: added dropdown with 'installed badges' from badges.txt
'        PAGE: badge macro can now show list from badges.txt
'
'        Revision 1.181  2005/01/16 22:17:35  sansei
'        Changed syntax for 3rd parameter in complex syntax when truncating searches.
'        OLD = 'levels from right to keep'
'        NEW = 'levels to hide' (after parameter 1)

'        (changed in \ow\skins\common\ow_JScripts.xsl)
'
'        Revision 1.180  2005/01/16 13:38:03  sansei
'        Updated to the 'right' new wysiwyg-files - (previous was wrong ones!) - :)
'
'        Revision 1.179  2005/01/15 15:27:21  sansei
'        updated wysiwygeditor (from developer Prob)
'
'        Revision 1.178  2004/12/11 15:41:47  sansei
'        Added cDatePagenameFormat - Giving different date-pagename options
'
'        Revision 1.177  2004/11/07 15:07:24  gbamber
'        Added: cWikifyPageHeadings=1|0
'        Updated: Coloured text
'        Updated: UpdateDB functions
'        Added: default_css skin
'        Updated: Myrthful skin
'
'        Revision 1.176  2004/11/05 11:52:46  gbamber
'        Changed backgound colour styles in plastic skin
'        Added: new options in skinconfig.xsl
'
'        Revision 1.175  2004/11/03 16:59:05  gbamber
'        Added: new version of myrthful skin
'        Bugfix: Nested positions.  <position[ ]> changed to <positionrel( )>
'
'        Revision 1.174  2004/11/03 10:33:28  gbamber
'        BugFix: TextSearch
'        BugFix: <position>
'
'        Revision 1.173  2004/11/01 12:14:25  gbamber
'        NEW: Admin function 'Nuke deprecated pages older than:'
'
'        Revision 1.172  2004/10/31 21:11:08  gbamber
'        New admin functions - Delete old revisions (this page | All) for default skin only
'
'        Revision 1.171  2004/10/30 20:42:50  gbamber
'        Added gWikiAdministrator="Wikiadmin"
'        Added 'Delete this page' if using admin name and local IP
'        Changed FetchUsername function to owdb.asp
'        Added auto-success page
'
'        Revision 1.170  2004/10/30 13:06:52  gbamber
'        BugFixes
'        1 ) @tokens can now be escaped using syntax ~@token  {{{@token}}} removed.
'        2 ) Macro names now automatically added to StopWords list (if enabled)
'        3 ) <CreatePage> macro now defaults to current page as template
'        4 ) New option cSortCategories=1|0
'
'        Revision 1.169  2004/10/27 09:49:42  gbamber
'        Round-up of small changes and bugfixes
'
'        Revision 1.168  2004/10/22 10:07:25  gbamber
'        BUGFIX: Create MacroHelp table error
'
'        Revision 1.167  2004/10/21 21:42:29  gbamber
'        BUGFIX: Improved Rename facility
'
'        Revision 1.166  2004/10/20 18:30:28  gbamber
'        RenamePage now does entire SubPage trees
'        Some formatting improvements in owwikify
'
'        Revision 1.165  2004/10/19 12:35:14  gbamber
'        Massive serialising update.
'
'        Revision 1.164  2004/10/13 12:17:21  gbamber
'        Forced updates to make sure CVS reflects current work
'
'        Revision 1.163  2004/10/13 10:53:25  gbamber
'        Modified: <showlinks>
'        BugFix: SavePage for MSSQL server
'        Updated: default and default_left skins with summaries template
'
'        Revision 1.162  2004/10/13 00:18:01  gbamber
'        1 ) More debugging options (1,2 and 3)
'        2 ) <systeminfo(appname)>
'        3 ) OPENWIKI_FINDNAME = FindPage
'        4 ) TitleIndex shows summary text
'        5 ) Page links show summary text + Date changed
'        6 ) CategoryIndex shows page visits
'        7 ) More robust database autoupgrade
'
'        Revision 1.161  2004/10/11 12:53:38  gbamber
'        Added: <SummarySearch(PP)>
'        Modified: <ow:link> to show summaries
'
'        Revision 1.160  2004/10/10 22:47:42  gbamber
'        Massive update!
'        Added: Summaries
'        Added: Default pages built-in
'        Added: Auto-update from openwiki classic
'        Modified: Default plugin status
'        Modified: Default Page Names
'        Modified: Default MSAccess DB to openwikidist.mdb
'        BugFix: Many MSAccess bugs fixed
'        Modified: plastic skin to show Summary
'
'        Revision 1.159  2004/10/10 09:47:34  gbamber
'        plastic skin:
'        Added $showfurniture xsl variable in skinconfig
'        If !='yes' then display becomes minimal (just pagebody.bookmarks and edit link)
'
'        Revision 1.158  2004/10/09 22:38:40  gbamber
'        BugFix:: <position>  top,left now in the right order!
'        ADDED: <position(top%,left%)>
'
'        Revision 1.157  2004/10/09 20:00:36  gbamber
'        Added: macro <position>
'        '        // SYNTAX 1 (absolute): <position(top,left,width,height,z-order)>Text</position>
'        '        // SYNTAX 2 (relative): <position[top,left,width,height,z-order]>Text</position>
'        '        // SYNTAX 2 (absolute): <position(top,left,width,height)>Text</position>
'        '        // SYNTAX 3 (relative): <position[top,left,width,height]>Text</position>
'        '        // SYNTAX 4 (absolute) <position(top,left)>Text</position>
'        '        // SYNTAX 5 (relative) <position[top,left]>Text</position>
'        '        // SYNTAX 6 (error message) <position>
'
'        Revision 1.156  2004/10/09 13:51:07  gbamber
'        Bugfix: Error when deleting old revisions in line 62(n) (SavePage) of owdb.asp
'
'        Revision 1.155  2004/10/09 10:04:52  gbamber
'        Added:
'        1)  preformatted smileys
'        2) <style(stylestatement)>Some Text</style>
'
'        Revision 1.154  2004/10/07 18:00:51  gbamber
'        Added cDisableExecuteMacro  = 0                 ' 1 = Disable the <Execute> macro        0 = Allow the <execute> macro with gAdminPassword
'        BugFix: {{{@ttoken}}} now displays
'
'        Revision 1.153  2004/10/07 15:49:35  gbamber
'        Added <Execute(VBCommand,AdminPassword[|returnvalue])> to mymacros.asp
'
'        Revision 1.152  2004/10/07 14:27:30  gbamber
'        Added
'        cUseMultipleParents = 1|0 (default=1)
'        and ServerDown = 1|0 (default=0)
'
'        Revision 1.151  2004/10/06 09:49:19  gbamber
'        Added Accessibility for Macro Forms
'        Bugfix on page delete (owdb)
'
'        Revision 1.150  2004/10/05 13:58:55  sansei
'        Added 2 global variables OPENWIKING_URL, OPENWIKING_TITLE (owdb.asp) - Changed Powered by logo to say: Powered by OpenWikiNG
'
'        Revision 1.149  2004/10/05 12:06:40  sansei
'        Removed some DIM's from owconfig_default.asp to owpreamble.asp
'        Corrected some REM lines too! (in owconfig_default.asp)
'
'        Revision 1.148  2004/10/03 18:17:23  gbamber
'        Experimental.
'        New option cAllowAnyPageName in owconfig_default
'        When cAllowAnyPageName=0 then pages cannot contain
'        1 ) Spaces
'        2 ) + characters
'        3 ) underscores
'        4 )  lowercase(space)lowercase
'        In other words, the page names are 'cleaned up
'
'        Revision 1.147  2004/10/03 17:11:27  gbamber
'        When making a new pagename the following are deleted:
'        Any spaces
'        Any + characters
'        Any _ characters
'
'        Revision 1.146  2004/10/03 16:48:50  gbamber
'        Added <CreateHomePage(pageAsTemplate)>
'        Added waste:/ protocol
'        Updated macrohelp.csv
'
'        Revision 1.145  2004/10/03 15:32:15  gbamber
'        Cleaned up MSAccess OPENWIKI_DB code
'        Added owdebug.asp
'        Cleaned up owconfig_default a bit
'        New switch in owconfig_default to debug the MSAccess connection string
'
'        Revision 1.144  2004/10/03 10:58:31  sansei
'        Refactor and added truncation of long titles in aggregation
'
'        Revision 1.143  2004/10/03 10:51:34  gbamber
'        BugFixes for SSL implementations
'
'        Revision 1.142  2004/10/02 17:17:20  sansei
'        Added truncate to macro: TitleSearch (Same syntax as Fullsearch-truncate!)
'
'        Revision 1.141  2004/10/02 17:02:57  gbamber
'        BugFix: Macros that take a pagename as a parameter will now accept @tokens and ./ and / syntax
'
'        Revision 1.140  2004/10/02 16:25:09  sansei
'        Changed use of gTemp in Fullsearch-truncate to use new global 'private' variable: gFullsearchTemp (added gTitlesearchTemp also for future use!)
'
'        Revision 1.139  2004/10/02 12:02:50  sansei
'        Added Fullsearch truncate facillity (Fullsearch macro now accepts one parameter!)
'
'        Revision 1.138  2004/10/01 22:39:58  gbamber
'        BugFix: Fixed regex expression in <class(stylename)>text</class> markup.
'
'        Revision 1.137  2004/10/01 13:06:52  sansei
'        Added constant "cFullsearchHighlight" in config_default as user setting for allowing the Fullsearch-highlight. (other documents involved too!)
'
'        Revision 1.136  2004/10/01 11:35:19  gbamber
'        BugFix: <TitleHitIndex>
'
'        Revision 1.135  2004/09/29 21:59:15  sansei
'        Improved Fullsearch-Highlight (no settings in owconfig_default.asp anymore!)
'
'        Revision 1.134  2004/09/29 16:11:02  sansei
'        Made Highlight-fullsearch optional - added a "cFullsearchHighlight" in ow_config_default.asp for that purpose.
'
'        Revision 1.133  2004/09/29 10:32:07  gbamber
'        Bugfix:PageChanged macro
'        Updated my/mymacros docs
'        Bugfix: FirstnameLastname no-params
'
'        Revision 1.132  2004/09/29 09:45:09  gbamber
'        Page references fixed in owmacros
'
'        Revision 1.131  2004/09/29 01:37:53  sansei
'        Reverted "ow_macros.asp"  to : Revision 1.59 - Critical bug AND chainbroken! + wrong sticky date - All in all recent updates was very destructive - pls be more carefull :(
'
'        Revision 1.130  2004/09/28 16:02:08  gbamber
'        Lots of Error-trapping and BugFixes for when Macrohelp is disabled
'
'        Revision 1.129  2004/09/28 13:04:01  sansei
'        Fixed bug: Wiki title in aggregation wrong - Now displays OPENWIKI_TITLE
'
'        Revision 1.128  2004/09/27 22:20:30  gbamber
'        BugFix: /plugins/owplugin_pagehits.asp - incompatibility with owclassic database fixed
'
'        Revision 1.127  2004/09/27 17:11:01  gbamber
'        Added new skin 'plastic' for review
'
'        Revision 1.126  2004/09/27 13:20:48  sansei
'        added use of parameters in plugin macro: PageTool.
'        Current parameters:
'        * owvariables - Dump a list of 'safe' variables as html
'
'        Revision 1.125  2004/09/26 18:29:48  sansei
'        added some macro help and made some InterWikis:OpenWikiHelp, Help, Devwiki AND done some coding on plugin: InlineXml
'
'        Revision 1.124  2004/09/26 10:52:44  sansei
'        Added plugin: InlineXml (macro)
'
'        Revision 1.123  2004/09/26 09:33:20  gbamber
'        cAllowWebframe config variable added
'
'        Revision 1.122  2004/09/26 00:07:20  gbamber
'        Updated Categories and GoogleAds in default_left and default skins
'
'        Revision 1.121  2004/09/25 09:45:00  gbamber
'        Added Category display and edit dropdown to default_left
'
'        Revision 1.120  2004/09/24 17:07:56  sansei
'        Added dump of OW Variables functionality to Plugin: PageTool
'
'        Revision 1.119  2004/09/23 15:44:23  sansei
'        MAJOR update in skin: default (step 1) - fixed print page and stuff
'
'        Revision 1.118  2004/09/22 10:17:24  gbamber
'        Added parameter to <TableOfContents> macro
'
'        Revision 1.117  2004/09/21 09:41:03  gbamber
'        BugFix for MSAccess in /plugins/importmacrohelp.asp
'
'        Revision 1.116  2004/09/20 13:10:48  gbamber
'        Fixed export RSS bug (line 142)
'
'        Revision 1.115  2004/09/20 12:44:21  gbamber
'        macrohelp.csv - Updated with data for all 64 current Macros
'
'        Revision 1.114  2004/09/20 11:39:31  gbamber
'        Added <WebFrame> macro
'
'        Revision 1.113  2004/09/18 10:21:20  gbamber
'        Added <Highlight> macro
'
'        Revision 1.112  2004/09/17 09:27:29  gbamber
'        Bugfix for <CreatePage> and <GoTo> macros with no paramaters or textfield
'
'        Revision 1.111  2004/09/14 11:31:45  gbamber
'        Improved emoticon code.  Added <ListEmoticons> macro
'
'        Revision 1.110  2004/09/14 08:24:48  gbamber
'        Added help text and example code to /ow/my/myactions.asp
'
'        Revision 1.109  2004/09/13 21:15:28  gbamber
'        Updated with Help Text and 2 sample Macros:
'        <FirstNameLastName(text1,text2)>
'        DeprecatedPages(numDays)
'
'        Revision 1.108  2004/09/13 15:30:32  gbamber
'        Added Image,ImageList,Icon,IconList macros.
'        BugFixed other macros and error-trapping
'
'        Revision 1.107  2004/09/13 11:50:30  gbamber
'        Fixed Calendar bug
'        All macros now have a 'no parameter' version
'
'        Revision 1.106  2004/09/12 13:55:41  gbamber
'        RSS Export fixed
'
'        Revision 1.105  2004/09/12 09:51:49  gbamber
'        Fixed PageBookmark #anchor links
'
'        Revision 1.104  2004/09/11 09:35:37  gbamber
'        Various minor bugfixes
'
'        Revision 1.103  2004/09/10 23:50:20  gbamber
'        <AddBookmarks(@this#anchor1 @this#Anchor2, Anchor Links)> now possible in openwiki_grfx skin
'
'        Revision 1.102  2004/09/10 21:46:29  gbamber
'        Bugfix for integer overflow problem in owplugin_pagehits.asp
'
'        Revision 1.101  2004/09/10 12:43:08  gbamber
'        Added @grandparent and @greatgrandparent
'        Sorted multiple override permissions on SubPage trees
'
'        Revision 1.100  2004/09/09 12:11:47  gbamber
'        BugFixes for accessrestrictions plugin code
'
'        Revision 1.99  2004/09/07 11:32:40  gbamber
'        Updated with IncludeOpenWikiPage
'
'        Revision 1.98  2004/09/07 09:31:10  sansei
'        added HTML Scripting for the PageTool (using pagetool.js)
'
'        Revision 1.97  2004/09/06 15:15:50  gbamber
'        Fixed MSAccess bugs
'        MSAccess97 database for OpenWiki2004
'        macrohelp.csv Updated with Category macros
'
'        Revision 1.96  2004/09/05 23:21:46  sansei
'        Updated PLUG: Page Tool
'
'        Revision 1.95  2004/09/05 14:44:54  gbamber
'        Improved PageBookmarks code in openwiki_grfx
'
'        Revision 1.94  2004/09/05 14:24:32  sansei
'        added service to plugs. (plugins/owpluginfunnel.asp)
'        added plugin: PageTool tag.
'
'        Revision 1.93  2004/09/05 12:43:45  sansei
'        updated macriohelp list (.mdb/.csv) to contain macro: Badge
'
'        Revision 1.92  2004/09/05 11:04:19  sansei
'        removed 'last' experimental code and refactored the 'badge' macro a bit
'
'        Revision 1.91  2004/09/05 11:02:42  sansei
'        removed 'last' experimental code
'
'        Revision 1.90  2004/09/03 18:06:24  gbamber
'        Added Macro <CategorySearch>
'
'        Revision 1.89  2004/09/03 17:15:47  sansei
'        removed temporary code. added: cAllowFlash, cAllowBadge - And cleaned the order of appearence for some user settings. Put OPENWIKI_WELCOMEPAGE="" (better deafult setting!) and more..!
'
'        Revision 1.88  2004/09/03 05:33:20  sansei
'        Added Macro: Badge (FlashButton removed!)
'
'        Revision 1.87  2004/09/02 22:40:07  gbamber
'        FlashButton macro update
'
'        Revision 1.86  2004/09/02 21:03:45  gbamber
'        Added cAllowFlash and some more Categories
'
'        Revision 1.85  2004/09/02 21:00:36  gbamber
'        Updated with google_adsense (temporary)
'
'        Revision 1.84  2004/09/02 19:13:47  gbamber
'        Added <TitleCategoryIndex> macro
'
'        Revision 1.83  2004/09/02 16:15:46  gbamber
'        Refactored and improved Category code
'
'        Revision 1.82  2004/09/02 10:33:24  gbamber
'        Added improved Category code
'
'        Revision 1.81  2004/09/01 17:14:24  gbamber
'        Bugfix: Drop-down now reflects OPENWIKI_ACTIVESKIN if no UserPreferences have been set
'
'        Revision 1.80  2004/09/01 07:01:06  gbamber
'        Bugfix for horizontal lines and strikethrough
'
'        Revision 1.79  2004/08/31 16:00:55  gbamber
'        Updated BackLink to take a text parameter
'
'        Revision 1.78  2004/08/31 12:38:37  gbamber
'        Andy Kaplan's Skin
'
'        Revision 1.77  2004/08/31 11:41:52  gbamber
'        '        // USER-DEFINED FORMATTING
'        '        // Gordon Bamber 20040831
'        '        // Syntax 1: <class(classname)>Some text</class> = span
'        '        // Syntax 2: <class[classname]>Some text</class> = div
'
'        Revision 1.76  2004/08/30 12:47:50  sansei
'        Added sEimantics (cleanslash) to skins
'
'        Revision 1.75  2004/08/30 09:51:03  gbamber
'        Bugfix: IsNull fault fixed
'
'        Revision 1.74  2004/08/29 11:20:35  gbamber
'        WikiBadge code added
'
'        Revision 1.73  2004/08/28 01:09:20  gbamber
'        Build 20040828.1
'
'        Revision 1.72  2004/08/28 01:06:17  gbamber
'        Build 20040828.0
'
'        Revision 1.71  2004/08/28 01:03:57  gbamber
'        Added UserPreferences Skinning
'
'        Revision 1.70  2004/08/27 22:14:10  sansei
'        fixed minor bugs in skins: default, openwiki_info
'
'        Revision 1.69  2004/08/27 11:11:10  gbamber
'        Integrated the Google Ad-Sense module
'
'        Revision 1.68  2004/08/26 19:32:04  gbamber
'        Added gSystemSkin=OPENWIKI_ACTIVESKIN to owconfig_default
'        Fixed bug in <SystemInfo> macro
'
'        Revision 1.67  2004/08/26 13:02:34  gbamber
'        Added extra @this directives
'
'        Revision 1.66  2004/08/26 08:32:25  gbamber
'        This paragraph _
'        will display _
'        on three lines.
'
'        This paragraph +
'        will display +
'        on one line
'
'        Revision 1.65  2004/08/25 21:15:38  sansei
'        optimized page-bookmars in skin: graphical (NOT incremented build number)
'
'        Revision 1.64  2004/08/25 19:13:35  sansei
'        optimizing page bookmarks (skin: openwiki_grfx)
'
'        Revision 1.63  2004/08/25 10:55:24  gbamber
'        Cleaned up syntax for <addboomarks> display in graphical and openwiki_grfx skin xsls
'
'        Revision 1.62  2004/08/25 09:06:45  gbamber
'        Added 2nd optional parameter for <AddBookmarks(list,heading)>
'
'        Revision 1.61  2004/08/24 22:43:51  gbamber
'        Improved XSL for PageBookmarks
'
'        Revision 1.60  2004/08/24 22:11:40  gbamber
'        Coloured horizontal lines added:
'        --R- = Red line
'        --G- = Green line
'        --B- = Blue line
'        --#c0c0c0- = grey line
'
'        Revision 1.59  2004/08/24 21:34:11  gbamber
'        BugFix for access restrictions plugin code
'
'        Revision 1.58  2004/08/24 18:51:43  gbamber
'        <AddBookmarks()>
'
'        Revision 1.57  2004/08/24 10:57:32  gbamber
'        NEW: <ActiveSkin(SkinName[,1|2])> macro
'
'        Revision 1.56  2004/08/23 18:40:03  gbamber
'        Added :LOL emoticon
'
'        Revision 1.55  2004/08/23 14:42:42  gbamber
'        Updated to allow subpage inheritance
'
'        Revision 1.54  2004/08/23 12:24:14  sansei
'        added new skin: openwiki_info
'
'        Revision 1.53  2004/08/23 10:20:33  gbamber
'        Added: Lots of parameters for the <SystemInfo> macro.
'        see: <MacroHelp(systeminfo)>
'
'        Revision 1.52  2004/08/22 20:55:44  gbamber
'        Bugfix:  Fixed TitleIndex bug for MSAccess goving wrong wpg_hits ordering
'
'        Revision 1.51  2004/08/22 20:22:14  sansei
'        Fixed 'reappeared' bookmarks in top and bottom bug
'
'        Revision 1.50  2004/08/22 17:39:36  sansei
'        Optimized skinning procedure (TAG: NEW_SKIN_PROCEDURE)
'
'        Revision 1.49  2004/08/19 11:40:23  gbamber
'        Bugfix:  Changed syntax2 for paragraph alignment
'
'        Revision 1.48  2004/08/19 11:34:13  sansei
'        Fixed bookmarks showing up in 'changes' bug (/skins/graphical/ow.xsl)
'
'        Revision 1.47  2004/08/19 11:24:56  gbamber
'        Added syntax for externally-referenced images:
'        image:, imageleft:, imageright:, imagecenter:
'
'        Revision 1.46  2004/08/19 09:57:54  gbamber
'        ow/skins/graphical/ow.xsl - More bugfixes:
'        1) Enabled 'Show other Revisions'
'        2) Enabled attachments count
'        3) Fixed broken <include(1)> display
'
'        Revision 1.45  2004/08/19 09:31:05  gbamber
'        Paragraph Alignment:
'        1) Placed code earlier in wikify
'        2) Alternative syntax in place
'
'        Revision 1.44  2004/08/19 08:03:38  gbamber
'        Fixed Month(-1),Month(+1) macro code
'
'        Revision 1.43  2004/08/17 00:11:14  carlthewebmaste
'        Changes for new Image Library Upload.  Permits uploads to OPENWIKI_IMAGELIBRARY if cAllowImageLibrary = 1.
'
'        Note old OPENWIKI_IMAGEUPLOADDIR var renamed to OPENWIKI_IMAGELIBRARY.
'
'        Revision 1.42  2004/08/16 21:12:57  gbamber
'        Fixed Page Views.
'        Fixed Diff
'        Added Revisions
'        Added Edited By
'
'        Revision 1.41  2004/08/16 18:59:45  gbamber
'        Added bookmarkbullets to regionleft
'        /skins/graphical/ow.xsl
'
'        Revision 1.40  2004/08/16 17:31:15  gbamber
'        @parent token in a subpage is replaced by the parent page name.  Works alongside @this directive
'
'        Revision 1.39  2004/08/16 16:07:14  gbamber
'        Fixed Headings bug in WYSIWYG.xsl
'
'        Revision 1.38  2004/08/16 15:15:26  sansei
'        Just fixing the build number to reflect previous change!
'
'        Revision 1.37  2004/08/16 15:07:46  sansei
'        Fixed showing bookmarks on attachment page bug (skins/graphical/owattach.asp)
'
'        Revision 1.36  2004/08/16 05:00:46  oddible
'        Updated Build No. Graphical Skin Edit Fixed
'
'        Revision 1.35  2004/08/15 22:30:03  carlthewebmaste
'        Update Build to 20040815.2
'
'        Revision 1.34  2004/08/15 16:57:34  carlthewebmaste
'        Adding Upload Support, including fake progress bar.
'
'        Owpreamble:
'        Updated build to 20040815.1
'        Added constants for OPENWIKI_UPLOADMETHOD:
'        ' possible values for OPENWIKI_UPLOADMETHOD
'        Const UPLOADMETHOD_LEWISMOTEN         = 0
'        Const UPLOADMETHOD_ABCUPLOAD         = 1
'        Const UPLOADMETHOD_SAFILEUP                 = 2
'
'        owado.asp:
'        Added ado constants for owupload, owuploadfield.
'
'        owattach.asp:
'        Added support for uploads, script (lewis moten) and COM methods.
'
'        owconfig_default.asp:
'        added OPENWIKI_UPLOADMETHOD,
'        default = UPLOADMETHOD_LEWISMOTEN
'        NOTE: cAllowAttachments left at 0 for default
'
'        skins\\default\\owattach.xsl
'        skins\\graphical\\owattach.xsl
'        Added 'fake progress bar' capability to occupy user while upload is in progress.
'
'        images\\icons\\doc\\psd.gif - missing icon for psd filetype
'        images\\loading.swf - fake progressbar movie file
'        owupload.asp - Upload class for LewisMoten upload method
'        owuploadfield.asp - helper class for Upload
'
'        Revision 1.33  2004/08/15 12:12:59  sansei
'        Moved files from default, graphical to skins/common - In order to make the skinning a bit more easy.
'
'        Revision 1.32  2004/08/14 19:11:17  sansei
'        Fixed graphical skin 'Bookmark' bug
'
'        Revision 1.31  2004/08/13 21:31:32  sansei
'        Fixed cAutoComment bug in owactions.asp
'
'        Revision 1.30  2004/08/13 12:45:55  gbamber
'        Added local image syntax:
'        local: localleft: localright:
'        OPENWIKI_IMAGELIBRARY defined in owconfig_default
'
'        Revision 1.29  2004/08/13 07:34:57  gbamber
'        Updated Build No. to 20040813.1
'
'        Revision 1.28  2004/08/13 01:13:31  sansei
'        Forgot to increment build version, done now
'
'        Revision 1.27  2004/08/13 00:13:26  sansei
'        Adding Default Welcomepage Optional Feature
'
'        Revision 1.26  2004/08/12 17:14:42  gbamber
'        Made SQLSERVER different from MSACCESS
'
'
'        ' possible values for OPENWIKI_DB_SYNTAX
'        Const DB_ACCESS      = 0
'        Const DB_ORACLE      = 1
'        Const DB_MYSQL       = 2
'        Const DB_POSTGRESQL  = 3
'        Const DB_SQLSERVER   = 4
'        Const DB_FIREBIRD    = 5
'
'        Revision 1.25  2004/08/12 12:46:22  gbamber
'        Added Synonym Links
'
'        Revision 1.24  2004/08/12 12:22:07  gbamber
'        New Build number
'
'        Added optional parameter to <include> macro:
'        <include(pagename,SilentInclude=0|1)>
'
'        Added @SilentInclude attribute to vPage
'
'        Changed xsl section:
'        <xsl:template match="ow:body/ow:page">
'
'        Revision 1.23  2004/08/11 10:24:25  gbamber
'        Added new option in owdefault - cAutoComment.  Affects behaviour of edit mode:
'        1 = Comment field automatically filled in with username
'        0 = Blank comment field
'
'        Revision 1.22  2004/08/09 01:29:20  oddible
'        Skinning Framework - Build # and XML ver updated.
'
'        Revision 1.21  2004/08/07 10:00:39  gbamber
'        Added ProgressBar macro
'
'        Revision 1.20  2004/08/04 22:33:28  gbamber
'        Added MacroHelp plugin.  Working, but not fully tested!
'
'        Revision 1.19  2004/08/04 08:27:27  gbamber
'        Added Skin info to <systeminfo> macro.
'        Updated Build Number
'
'        Revision 1.18  2004/08/04 08:08:32  gbamber
'        Updated Build Number
'
'        Revision 1.17  2004/08/04 05:27:58  oddible
'        New Skinning - Added dynamic function for XSL & CSS
'        New directory for Skins.
'
'        Revision 1.16  2004/08/03 12:35:52  gbamber
'        Updated Build Number to 20040803.0
'
'        Revision 1.15  2004/08/03 11:40:46  gbamber
'        Updated Build Number to 20040803.0
'
'        Revision 1.14  2004/07/21 16:42:00  gbamber
'        Updated build number.
'
'        Revision 1.13  2004/07/21 12:39:15  gbamber
'        Updated build number.  Added Log
'
Const OPENWIKI_APPNAME     = "OpenWikiNG"
Const OPENWIKI_VERSION     = "1 alpha"
Const OPENWIKI_REVISION    = "owpreamble revision: $Revision: 1.238 $"
Const OPENWIKI_BUILD       = "20070306"
Const OPENWIKI_XMLVERSION  = "0.92"
Const OPENWIKI_NAMESPACE   = "http://openwiki.com/2001/OW/Wiki"
' NG
Const OPENWIKING_URL       = "http://www.openwiking.com/"
Const OPENWIKING_TITLE     = "OpenWikiNG"

' possible values for OPENWIKI_DB_SYNTAX
Const DB_ACCESS      = 0
Const DB_ORACLE      = 1
Const DB_MYSQL       = 2
Const DB_POSTGRESQL  = 3
Const DB_SQLSERVER   = 4
Const DB_FIREBIRD    = 5  'Use this option for Firebird/Interbase specific syntax

' possible values for OPENWIKI_UPLOADMETHOD
Const UPLOADMETHOD_LEWISMOTEN       = 0
Const UPLOADMETHOD_ABCUPLOAD        = 1
Const UPLOADMETHOD_SAFILEUP         = 2

' declare 'constants'
Dim OPENWIKI_WELCOMEPAGE, OPENWIKI_RCNAME, OPENWIKI_UPNAME, OPENWIKI_TINAME, OPENWIKI_HELPNAME, OPENWIKI_RPNAME, OPENWIKI_CINAME, OPENWIKI_FINDNAME
Dim OPENWIKI_ERRORPAGENAME,OPENWIKI_SUCCESSPAGENAME,OPENWIKI_EDITERRORPAGE,OPENWIKI_VIEWERRORPAGE,OPENWIKI_IMAGEUPLOADPAGE
Dim OPENWIKI_DB, OPENWIKI_DB_SYNTAX,OPENWIKING_UPDATEDB
Dim OPENWIKI_ICONPATH, OPENWIKI_IMAGEPATH, OPENWIKI_ENCODING, OPENWIKI_TITLE, OPENWIKI_FRONTPAGE
Dim OPENWIKI_SCRIPTNAME, OPENWIKI_MAXTEXT, OPENWIKI_MAXINCLUDELEVEL
Dim OPENWIKI_RCDAYS, OPENWIKI_MAXTRAIL, OPENWIKI_TEMPLATES
Dim OPENWIKI_TIMEZONE, OPENWIKI_MAXNROFAGGR, OPENWIKI_MAXWEBGETS, OPENWIKI_SCRIPTTIMEOUT
Dim OPENWIKI_DAYSTOKEEP
Dim OPENWIKI_STOPWORDS
Dim OPENWIKI_UPLOADDIR, OPENWIKI_MAXUPLOADSIZE, OPENWIKI_UPLOADTIMEOUT,OPENWIKI_IMAGELIBRARY
Dim OPENWIKI_UPLOADMETHOD 'Upload methods -- Script (Lewis Moten method) or COM object
Dim OPENWIKI_ACTIVESKIN
Dim OPENWIKI_SYNONYMLINKPAGE ' Holds the page where to find the synonymized links (if any)
Dim MSXML_VERSION,OPENWIKI_CAPTCHA_SERVERPAGE,OPENWIKI_CAPTCHA_ERRORPAGE

' declare options
Dim gReadPassword, gEditPassword, gAdminPassword, gDefaultBookmarks,gWikiAdministrator
Dim cReadOnly, cNakedView, cUseSubpage, cFreeLinks, cWikiLinks, cAcronymLinks, cTemplateLinking, cRawHtml, cMathML, cHtmlTags, cCacheXSL, cCacheXML, cDirectEdit, cEmbeddedMode
Dim cSimpleLinks, cNonEnglish, cNetworkFile, cBracketText, cBracketIndex, cHtmlLinks, cBracketWiki, cFreeUpper, cLinkImages, cUseHeadings, cUseLookup, cStripNTDomain, cMaskIPAddress, cOldSkool, cNewSkool, cNumTOC, cAllowCharRefs, cWikifyHeaders
Dim cEmoticons, cUseLinkIcons, cUseInterWikiIcons, cPrettyLinks, cExternalOut,cWikifyPageTitles
Dim cAllowRSSExport, cAllowNewSyndications, cAllowAggregations, cNTAuthentication, cShowBrackets
Dim cAllowAttachments,cAllowImageLibrary,cAutoComment,cUseParentRestrictions,cUseCategories
Dim cAllowFlash,cAllowBadge,cAllowWebFrame,cFullsearchHighlight,cAllowAnyPageName
Dim cUseAccessibility,AccessDebugTest,accesspath,ServerDown,cUseMultipleParents,cDisableExecuteMacro,cUseSummary
Dim cWriteHTML,cWriteHTMLFoldername,cWriteXML,cWriteXMLFoldername
Dim cShowGoogleAds,cSortCategories,cAllowRedirectPage,cShowRedirectPageloader
Dim cDatePagenameFormat,cShowOldEmoticons,cTitleIndexIgnoreCase
Dim gErrorPageText,gSuccessPageText
Dim cReadCategoriesFromDB
Dim cUseTags,cTagsSplit,cCacheTags,cTagSizeStyle,OPENWIKI_TagsName

' global variables
Dim gCategoryArray() '        // Array of categories
Dim gLinkPattern, gSubpagePattern, gStopWords, gTimestampPattern, gUrlProtocols
Dim gUrlPattern, gMailPattern, gInterSitePattern, gInterLinkPattern, gFreeLinkPattern
Dim gImageExtensions, gImagePattern, gDocExtensions, gNotAcceptedExtensions, gISBNPattern
Dim gHeaderPattern, gMacros,gUserSkin,gSystemSkin,gStrictLinkPattern
Dim gFS, gIndentLimit
Dim gsz_lastPage, gsz_lastreferer
Dim gFullsearchTemp, gTitlesearchTemp,gSerialisingInProgress
Dim gSynonymArray ' Cache of synonyms
Dim gDefaultPageBookmarks,gDefaultPageBookmarksHeading,gPageBookmarks
gFS = Chr(222)           ' The FS character is a superscript "3"
gIndentLimit = 20        ' maximum indent level for bulleted/numbered items

' incoming parameters
Dim gPage                ' page to be worked on
Dim gRevision            ' revision of page to be worked on
Dim gAction              ' action
Dim gTxt                 ' text value passed to input boxes

Dim gServerRoot          ' URL path to script
Dim gScriptName          ' Name of this script
Dim gTransformer         ' transformer of XML data
Dim gNamespace           ' namespace data
Dim gErrorStack		' error stack class
Dim gRaw                 ' vector or raw data used by Wikify function
Dim gBracketIndices      ' keep track of the bracketed indices
Dim gTOC                 ' table of contents
Dim gIncludeLevel        ' recursive level of included pages
Dim gCurrentWorkingPages ' stack of pages currently working on when including pages
Dim gIncludingAsTemplate ' including subpages as template
Dim gNrOfRSSRetrievals   ' nr of remote calls performed to retrieve an RSS feed
Dim gAggregateURLs       ' URL's to RSS feeds that need to be aggregated for this page
Dim gCookieHash          ' Hash value to use in cookie names
Dim gTemp                ' temporary value that may be used at all times
Dim gActionReturn        ' return value used by actions
Dim gMacroReturn         ' return value used by macros
Dim gOverrideIPArray(5)
'        // Private IP ranges as per RFC
'        // Range 172.16.x.x to 172.31.x.x could be added if needed
'        // These ranges will cover most intranets
gOverrideIPArray(0)="127.0.0.1"
gOverrideIPArray(1)="localhost"
gOverrideIPArray(2)="10."
gOverrideIPArray(3)="192.168."

' ************************************************************************************
'        // Change this to your editing machine IP address if you like.
'        // If your editing machine IP is 123.456.78.9, then replace the line below with:
'        // gOverrideIPArray(4)="123.456.78.9"
gOverrideIPArray(4)="172.16."
' ************************************************************************************

If (ScriptEngineMajorVersion < 5) Or (ScriptEngineMajorVersion = 5 And ScriptEngineMinorVersion < 5) Then
    Response.Write("<h2>Error: Missing VBScript v5.5</h2>")
    Response.Write("In order for this script to work correctly the component " _
                 & "VBScript v5.5 " _
                 & "or a higher version needs to be installed on the server. You can download this component from " _
                 & "<a href=""http://msdn.microsoft.com/scripting/"">http://msdn.microsoft.com/scripting/</a>.")
    Response.End
End If

'Dim c, i
'c = Request.ServerVariables.Count
'For i = 1 To c
'    Response.Write(Request.ServerVariables.Key(i) & " ==> " & Request.ServerVariables.Item(i) & "<br>")
'Next
'Response.End

%>
