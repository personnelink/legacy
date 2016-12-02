<?xml version="1.0"?>
<!-- edited with XMLSPY v5 rel. 4 U (http://www.xmlspy.com) by abc (abc) -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
	<!--VARIABLES-->
	<xsl:variable name="bookmark_cleanslash" select="1">
	</xsl:variable>
	<xsl:variable name="pagebookmark_cleanslash" select="1"/>
	<xsl:variable name="title_cleanslash" select="1"/>
	<xsl:variable name="trail_cleanslash" select="2"/>
	<xsl:variable name="brandingText">OpenWikiNG, the post-it note of the web.</xsl:variable>
	<xsl:variable name="displayValidatorbuttons" select="0"/>
	<!--TEMPLATES-->
	
  <xsl:template name="head">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset={@encoding};"/>
			<meta name="keywords" content="wiki, openwiki, wikiwiki, wiki wiki, interwiki, post-it note, collaborative web, open source, ASP, IIS, XML, XHTML, RSS, dotnet, weblog, log"/>
			<meta name="description" content="OpenWiki - The post-it note of the web."/>
			<meta name="ROBOTS" content="INDEX,FOLLOW"/>
			<meta name="MSSmartTagsPreventParsing" content="true"/>
			<title>
				<xsl:value-of select="ow:title"/> - <xsl:value-of select="ow:page/ow:link"/>
			</title>
			<link rel="stylesheet" type="text/css" href="{/ow:wiki/ow:skinpath}/ow.css"/>
			<link rel="stylesheet" type="text/css" href="{/ow:wiki/ow:skinpath}/wysiwyg.css"/>
      <link rel="stylesheet" type="text/css" href="{/ow:wiki/ow:skinpath}/blogger.css"/>
		</head>
	</xsl:template>
	
  <xsl:template name="brandingImage">
		<xsl:choose>
			<xsl:when test="(boolean($AllowFlash) = 1) and (1 = 2)">
				<!--
(1 = 1) If you want to use FlashLogo if Flash is allowed
(1 = 2) if you dont want FlashLogo even if Flash is allowed
-->
				<!--Use advanced or Simple flash logo (uncomment the desired template)-->
				<xsl:call-template name="FlashLogoAdvanced"/>
				<!--<xsl:call-template name="FlashLogoSimple"/>-->
			</xsl:when>
			<xsl:otherwise>
				<a href="{/ow:wiki/ow:frontpage/@href}">
					<!-- <img src="{/ow:wiki/ow:imagepath}/logo.gif" align="right" border="0" alt="OpenWiki"/> -->
				</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
  
	<xsl:template name="poweredBy">
		<a href="{//ow:openwiking_url}">
			<!-- <img src="{/ow:wiki/ow:imagepath}/poweredby.gif" width="88" height="31" border="0" alt=""/> -->
		</a>
	</xsl:template>
  
	<xsl:template name="mainmenu_title">
    <xsl:if test="string($bookmarkmenutext)">
      <strong class="bookmarks">
        <xsl:value-of select="string($bookmarkmenutext)"/>
      </strong>
    </xsl:if>
	</xsl:template>
  
	<!-- SKINNING HELP VARIABLES -->
	<!-- Showborders: 0 = No borders 1=All tables have borders -->
	<xsl:variable name="Showborders" select="0"/>
</xsl:stylesheet>
