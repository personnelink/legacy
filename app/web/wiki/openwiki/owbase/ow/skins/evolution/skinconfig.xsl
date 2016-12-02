<?xml version="1.0" encoding="utf-8"?>
<!-- 
### Evolution skin ###
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">

	<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>

<xsl:variable name="bodybackgroundcolour">#DFDFFF</xsl:variable>
<!--
<xsl:variable name="bodybackgroundcolour">#FAFAFF</xsl:variable>
-->


<!-- Status line -->
<!-- Allowed values: any text -->
<xsl:variable name="brandingText">OpenWiking, the next generation.</xsl:variable>

<!-- THIS CAN SET A SPARSE DISPLAY -->
<!-- Allowed values: yes|no -->
<xsl:variable name="showfurniture">yes</xsl:variable>
<!-- With showfuriture=no, the body's margin size can be set -->
<xsl:variable name="bodymarginsize">20</xsl:variable>

<!-- START CLEANSLASH VARIABLES-->
	<xsl:variable name="bookmark_cleanslash" select="1" />
	<xsl:variable name="pagebookmark_cleanslash" select="1"/>
	<xsl:variable name="title_cleanslash" select="1"/>
	<xsl:variable name="trail_cleanslash" select="2"/>
<!-- END CLEANSLASH VARIABLES-->
	
<!-- START CATEGORY VARIABLES-->
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
	<xsl:variable name="category_listshow">yes</xsl:variable>
<!-- END CATEGORY VARIABLES-->
<!-- **********************************************
	The value below can be:
	top = Show Google Ad at the top of the page
	right = Show Google Ad at the right of the page
-->
<xsl:variable name="googleplacement">right</xsl:variable>
<!-- ********************************************** -->

<!-- Allowed values 0|1 -->
<xsl:variable name="displayValidatorbuttons">1</xsl:variable>

<!-- Showborders: 0 = No borders 1=All tables have borders -->
<!-- Allowed values 0|1 -->
<xsl:variable name="Showborders">0</xsl:variable>

<!-- http://www.bamber.com/openwiking/ow.asp?SandBox%2FOpenWiki2004Macros%2FInclude%2FSiblingTest1Allowed values: yes|no -->
<xsl:variable name="showbookmarkmenutext">yes</xsl:variable>
<!-- Allowed values: any text -->
<xsl:variable name="bookmarkmenutext">Bookmarks1: </xsl:variable>

<!-- Allowed values: yes|no -->
<xsl:variable name="showpoweredby">yes</xsl:variable>
<xsl:variable name="showlogo">yes</xsl:variable>

<!-- ********************************************** -->
<!-- Top and Bottom displays -->
<!-- ********************************************** -->
<!-- Allowed values: any character -->
<!-- Used for bookmarks as well as bottom links -->
<xsl:variable name="separatorcharacter"> | </xsl:variable>

<!-- if empty, then ASCII(187) is used -->
<xsl:variable name="trailcharacter"></xsl:variable>

<!-- Allowed values: yes|no -->
<xsl:variable name="displayeditlink">yes</xsl:variable>
<xsl:variable name="displayrename">yes</xsl:variable>
<xsl:variable name="displayviewrevisions">yes</xsl:variable>
<xsl:variable name="displayattachments">yes</xsl:variable>
<xsl:variable name="displayprint">yes</xsl:variable>
<xsl:variable name="displayxml">yes</xsl:variable>
<xsl:variable name="displayhits">yes</xsl:variable>
<xsl:variable name="displayfind">yes</xsl:variable>
<xsl:variable name="displayrevisions">yes</xsl:variable>
<xsl:variable name="displaylastedited">yes</xsl:variable>
<xsl:variable name="displaysearchbox">yes</xsl:variable>

<!-- for mode=diff only -->
<xsl:variable name="displaypagetitle">yes</xsl:variable>
<xsl:variable name="linkpagetitle">yes</xsl:variable>

<xsl:variable name="displaycategory">yes</xsl:variable>

</xsl:stylesheet>
