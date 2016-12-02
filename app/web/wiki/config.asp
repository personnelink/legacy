<%
' ------------------------------------------------------------------------------------------------
'
' THE PURPOSE OF THIS FILE IS TO OVERRIDE THE SETTINGS IN THE MAIN FILE --> WIKI.ASP
'
' This file becomes the effective settings in a particular website.   I separated these
' settings to avoid re-entering the values everytime there is an update in wiki.asp
'
' That means, if there is a new Wiki.asp,  your settings will be preserved by this file.
'
' ------------------------------------------------------------------------------------------------

gMdbExtension      = ".mdb"
gBlackListedIpsRE  =  "^89\.149\.195.*"
gDisableSave       =  false                           ' Set to true if you have to fully disable save.
gRemoveHtml        =  false                           ' Set to true if  HTML input in wiki will be enabled.
gLoginFlag         =  "log"                           ' The default enable login flag ( must be overriden by config.asp).
gIsOpenWiki        =  true                           ' Allow editing or Password Protect Editing?
gHideWikiSource    =  false                           ' Allow viewing of unformatted wiki text when loggin in.
gHideWikiFooter    =  false                           ' Show or Hide the whole wiki footer
gHideLogin         =  false                           ' Enable/Disable double-click or Edit. This can be overriden by &log
gHideLastEditor    =  false                           ' Show/Hide in  the footer the info about last edit
gEditPassword      = "password"                       ' password  for editing the site
gPassword          = "pass"                           ' password  for editing and delete and db creation.
gHttpDomain        = "auto"                           ' URL for RSS links to work. default is AUTO Override in config.asp . Set to "" to remove rss footer links
gDefaultIcon       = "icon.png"                       ' This default. Maybe overridden if your site has icon.gif, icon.jpg or xxxx.gif and if FSO is working.
gDefaultHomePage   = "WikiAsp"                        ' modify your start page here. this may be overridden by .ini file. The .ini file is same dir as mdb file
gDataSourceDir     = "db"                             ' MSAccess folder. this is normally `db`
gDocRootDir        = ""                               ' physical absolute path of root (e.g. c:/dc2/mysite.com)  make it blank if `gDataSourceDir` is relative to wiki.asp
gSearchLabel       = "Look for:"                      ' Text to show on top search box
gRssStyle          = "<?xml-stylesheet type=""text/xsl"" href=""rss.xsl"" ?>"   'This is to make RSS xml readable File rss.xsl should exist
gBlackListedIps    = ""
gPersistPassword   = false
gWikiBodyPrefix    = "|!{bigger}DOUBLE-CLICK page or Click Edit below.  Enjoy!  - Elrey {/bigger}"
gPasswordLabel    = " Enter the secret word <b>'password'</b> : "
gFooterHtml        = "</body></html><div id='ads'><XML><noscript><div><span><iframe><style>"  'This hides footer ads for this site.
%>
























































