<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
<!--
 $Log: lang-en.xsl,v $
 Revision 1.6  2006/01/31 03:45:27  piixiiees
 It is more clear not to show the 'edit precis'. To edit the summary edit the page

 Revision 1.5  2006/01/24 01:13:39  piixiiees
 Included new entry for english-language lang_027=Precis.
 This will allow to personalize the text of the summary label of the wiki pages
 The include to the lang-en.xsl has been added as well to the default skin.

 Revision 1.4  2004/11/03 10:34:32  gbamber
 BugFix: TextSearch
 Added: More english-language entries

 Revision 1.3  2004/10/13 12:18:59  gbamber
 Forced updates to make sure CVS reflects current work

 Revision 1.2  2004/09/27 20:09:34  gbamber
 Incremental update.  No new build

 Revision 1.1  2004/09/27 17:05:34  gbamber
 Plastic Skin stuff

-->
<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
<xsl:variable name="lang_001">Redirected from</xsl:variable>
<xsl:variable name="lang_002">Showing revision</xsl:variable>
<xsl:variable name="lang_003">Attachments</xsl:variable>
<xsl:variable name="lang_004">Page views</xsl:variable>
<xsl:variable name="lang_005">Page Revisions</xsl:variable>
<xsl:variable name="lang_006">last edited</xsl:variable>
<xsl:variable name="lang_007">Exit print view</xsl:variable>
<xsl:variable name="lang_008">Up a level</xsl:variable>
<xsl:variable name="lang_009">Edit</xsl:variable>
<xsl:variable name="lang_010">this page</xsl:variable>
<xsl:variable name="lang_011">revision</xsl:variable>
<xsl:variable name="lang_012">Rename this page</xsl:variable>
<xsl:variable name="lang_013">View other revisions</xsl:variable>
<xsl:variable name="lang_014">View current revision</xsl:variable>
<xsl:variable name="lang_015">Print this page</xsl:variable>
<xsl:variable name="lang_016">View XML</xsl:variable>
<xsl:variable name="lang_017">Find page</xsl:variable>
<xsl:variable name="lang_018">by browsing, searching or an index</xsl:variable>
<xsl:variable name="lang_019">Last Edited</xsl:variable>
<xsl:variable name="lang_020">by</xsl:variable>
<xsl:variable name="lang_021">diff</xsl:variable>
<xsl:variable name="lang_022">Describe</xsl:variable>
<xsl:variable name="lang_023">here</xsl:variable>
<xsl:variable name="lang_024">This page will be permanently destroyed</xsl:variable>
<xsl:variable name="lang_025">HIGHLIGHT</xsl:variable>
<xsl:variable name="lang_026">HIGHLIGHT OFF</xsl:variable>
<xsl:variable name="lang_027">Summary</xsl:variable>  
<!-- lang020:Showing revision -->
<!--
<xsl:value-of select="$lang_020"/>
-->
</xsl:stylesheet>
