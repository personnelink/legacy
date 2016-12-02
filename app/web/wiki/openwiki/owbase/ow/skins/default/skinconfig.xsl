<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
<!--
 $Log: skinconfig.xsl,v $
 Revision 1.3  2006/02/13 03:41:47  piixiiees
 Added variable bookmarkmenutext in 'default' skin

 Revision 1.2  2004/10/30 13:11:26  gbamber
 Bold Bug Fixed

 Revision 1.1  2004/09/26 00:04:20  gbamber
 Updated Categories and GoogleAds in default_left and default skins

 Revision 1.1  2004/09/25 09:24:20  gbamber
 Added Category display and edit dropdown

-->
        <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>

        <!--CATEGORY VARIABLES-->
<!-- category_displaytype = text|image -->
        <xsl:variable name="category_displaytype">text</xsl:variable>
<!-- category_prefixtext = "Text to display before the category name" -->
        <xsl:variable name="category_prefixtext">Page Type:</xsl:variable>
<!-- category_textclass = CSS class of Text to display -->
        <xsl:variable name="category_textclass">darkbluetext</xsl:variable>

<!-- category_imageprefix = {skinpath}/images/(imageprefix)(1-n) -->
        <xsl:variable name="category_imageprefix">wikibadge</xsl:variable>
<!-- category_imagetype = jpg|gif|(otherfiletype) -->
        <xsl:variable name="category_imagetype">jpg</xsl:variable>
<!-- category_listshow = yes|no -->
        <xsl:variable name="category_listshow">no</xsl:variable>
<!-- **********************************************
        The value below can be:
        top = Show Google Ad at the top of the page
        right = Show Google Ad at the right of the page
-->
        <xsl:variable name="googleplacement">right</xsl:variable>
<!-- ********************************************** -->

<!-- Label to be showed before the Default User Bookmarks -->
<!-- Allowed values: any text -->
  <xsl:variable name="bookmarkmenutext">Bookmarks: </xsl:variable>

</xsl:stylesheet>