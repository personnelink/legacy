<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
<!--
 $Log: owconfig.xsl,v $
 Revision 1.6  2005/11/12 00:06:33  sansei
 Translated text:openwiki2004 into OpenWiking in several documents
 New default access DB (OpenWikiNG.mdb) (added in an earlier CVS session)

 Revision 1.5  2004/10/20 18:31:57  gbamber
 Improved formatting and BugFixes in XSL

 Revision 1.4  2004/10/19 12:40:12  gbamber
 Massive serialising update.

 Revision 1.3  2004/09/27 17:05:34  gbamber
 Plastic Skin stuff

 Revision 1.2  2004/09/26 10:47:32  sansei
 Set default = NO

 Revision 1.1  2004/09/26 00:02:39  gbamber
 Updated Categories and GoogleAds in default_left and default skins

-->
<!-- **********************************************
        The value below can be:
        yes = Show Google Ads
        no = Don't show google ads
-->
<!--        <xsl:variable name="google">yes</xsl:variable> -->
<!-- Here it is set via the cShowGoogleAds = 0|1 -->
<xsl:param name="google" select='no'/>

<!-- ********************************************** -->

<!-- META values -->
<!-- Allowed values: any text -->
<xsl:variable name="pagekeywords">openwiking,openwiki,wiki,ASP,XSL</xsl:variable>
<!-- Allowed values: any text -->
<xsl:variable name="pagedescription">OpenWiking</xsl:variable>
<!-- Allowed values: yes|no -->
<xsl:variable name="indexpages">no</xsl:variable>

</xsl:stylesheet>