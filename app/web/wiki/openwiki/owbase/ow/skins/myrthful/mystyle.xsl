<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
	<!--VARIABLES-->
	<xsl:variable name="bookmark_cleanslash" select="1">
	</xsl:variable>
	<xsl:variable name="pagebookmark_cleanslash" select="1"/>
	<xsl:variable name="title_cleanslash" select="1"/>
	<xsl:variable name="trail_cleanslash" select="2"/>
	<xsl:variable name="brandingText">OpenWiking, the post-it note of the web.</xsl:variable>
	<xsl:variable name="displayValidatorbuttons" select="0"/>
	<!--TEMPLATES-->
	<xsl:template name="head">
		<head>
                        <meta http-equiv="Content-Type" content="text/html; charset={@encoding};"/>
                        <meta name="keywords">
                                <xsl:attribute name="content"><xsl:value-of select="$pagekeywords"/></xsl:attribute>
                        </meta>
                        <meta name="description">
                                <xsl:attribute name="content"><xsl:value-of select="$pagedescription"/></xsl:attribute>
                        </meta>
                        <meta name="ROBOTS">
                                <xsl:choose>
                                        <xsl:when test="$indexpages='yes'">
                                                <xsl:attribute name="content">INDEX,FOLLOW</xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <xsl:attribute name="content">NOINDEX,NOFOLLOW</xsl:attribute>
                                        </xsl:otherwise>
                                </xsl:choose>
                        </meta>
			<meta name="MSSmartTagsPreventParsing" content="true"/>
			<title>
				<xsl:value-of select="ow:title"/> - <xsl:value-of select="ow:page/ow:link"/>
			</title>
			<link rel="stylesheet" type="text/css" href="{/ow:wiki/ow:skinpath}/ow.css" />
			<link rel="stylesheet" type="text/css" href="{/ow:wiki/ow:skinpath}/skin.css" media="screen"/>
			<link rel="stylesheet" type="text/css" href="{/ow:wiki/ow:skinpath}/skinprint.css" media="print"/>
			<link rel="stylesheet" type="text/css" href="{/ow:wiki/ow:skinpath}/wysiwyg.css" media="screen"/>
		</head>
	</xsl:template>
	<xsl:template name="brandingImage">
		<a href="{/ow:wiki/ow:frontpage/@href}">
			<img src="{/ow:wiki/ow:imagepath}/logo.gif" border="0" alt="OpenWiki" style="display: block; margin-left: auto; margin-right: auto;"/>
		</a>
	</xsl:template>
	<xsl:template name="poweredBy">
		<a href="{//ow:openwiking_url}">
			<img src="{/ow:wiki/ow:imagepath}/poweredby.gif" width="88" height="31" border="0" alt=""/>
		</a>
	</xsl:template>
	<xsl:template name="mainmenu_title">
		<strong style="text-decoration:underline;">MAIN MENU:</strong>
	</xsl:template>
	<!-- SKINNING HELP VARIABLES -->
	<!-- Showborders: 0 = No borders 1=All tables have borders -->
	<xsl:variable name="Showborders" select="0"/>
</xsl:stylesheet>
