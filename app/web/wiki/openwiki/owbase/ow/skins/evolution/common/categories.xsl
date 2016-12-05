<?xml version="1.0" encoding="utf-8"?>
<!--
$Log: categories.xsl,v $
Revision 1.2  2007/01/07 11:24:40  piixiiees
gFS=Chr(222) due to problems working with Chr(179) in utf-8 and some files saved with encoding="utf-8"

Revision 1.1  2006/04/20 01:00:26  piixiiees
Temporary copy of skins/common/*.* to evolution skin to be able to modify the structure of the skin without impacting to other skins.
New style of BrogressBar; now printable.
New file macros.xsl to include the templates for the macros.

Revision 1.7  2004/10/13 12:18:59  gbamber
Forced updates to make sure CVS reflects current work

Revision 1.6  2004/10/13 00:18:30  gbamber
1 ) More debugging options (1,2 and 3)
2 ) <systeminfo(appname)>
3 ) OPENWIKI_FINDNAME = FindPage
4 ) TitleIndex shows summary text
5 ) Page links show summary text + Date changed
6 ) CategoryIndex shows page visits
7 ) More robust database autoupgrade

Revision 1.5  2004/10/11 12:54:39  gbamber
Added: <SummarySearch(PP)>
Improved:CategorySearch

Revision 1.4  2004/10/10 22:50:06  gbamber
Massive update!
Added: Summaries
Added: Default pages built-in
Added: Auto-update from openwiki classic
Modified: Default plugin status
Modified: Default Page Names
Modified: Default MSAccess DB to openwikidist.mdb
BugFix: Many MSAccess bugs fixed
Modified: plastic skin to show Summary

Revision 1.3  2004/09/08 08:32:50  gbamber
Added categorysearch template

Revision 1.2  2004/09/02 19:15:26  gbamber
Added <TitleCategoryIndex> macro

Revision 1.1  2004/09/02 16:13:51  gbamber
Refactored and improved Category code

Revision 1.1  2004/09/02 10:36:11  gbamber
Added improved Category code

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>


<!-- This template goes in the mode=@edit editing window -->
<xsl:template name="categorydropdown">
<!-- Displays a drop-down list of categories defined in owconfig_default.asp/gCategoryArray() -->
	<xsl:if test="/ow:wiki/ow:categories/@active='yes'"><!-- only proceed if cUseCategories=1 -->
        <xsl:text>&#160;</xsl:text>
        <LABEL ACCESSKEY="C">
        <select name="categories" id="categorysel">
            <option name="copt" value="0">No Category</option><!-- Hardcoded category=0 (because position() function is 1-based) -->
			<xsl:for-each select="/ow:wiki/ow:categories/ow:category">
				<option>
					<xsl:attribute name="name">copt</xsl:attribute>
					<xsl:attribute name="value"><xsl:number value="position()" format="1" /></xsl:attribute>
					<xsl:if test="(/ow:wiki/ow:page/@category=position())">
						<xsl:attribute name="selected">1</xsl:attribute><!-- Select only if page category <> 0 -->
					</xsl:if>
					<xsl:value-of select="@name"/>
				</option>
			</xsl:for-each>
		</select>
		</LABEL>
	</xsl:if>	
	</xsl:template>

<!-- This template goes somewhere on the visible part of the page -->
<!-- 
	// The type of display is determined by:
	// 1) If cAllowCategories is set to 0 or 1
	// 2) In skinconfig.xsl, the values of one or more of:
	//	a) category_displaytype = text|image
	//	b) category_prefixtext = "Text to display before the category name"
	//	c) category_textclass = CSS classname of text to display
	//	d) category_imageprefix = /images/(imageprefix)(1-n)
	//	e)	category_imagetype = jpg|gif|(otherfiletype)
--> 
	<xsl:template name="categorydisplay">
	  <xsl:if test="/ow:wiki/ow:categories/@active='yes'"><!-- only proceed if cUseCategories=1 -->
		<xsl:for-each select="/ow:wiki/ow:categories/ow:category">
			<xsl:choose>
				<xsl:when test="(/ow:wiki/ow:page/@category=position())"><!-- Bingo! this page has a matching category number -->
					<xsl:choose>
						<xsl:when test="$category_displaytype='text'"><!-- Display text according to variables -->
							<span>
								<xsl:if test="$category_textclass">
									<xsl:attribute name="class">
										<xsl:value-of select="$category_textclass" />
									</xsl:attribute>
								</xsl:if>
							<xsl:value-of select="$category_prefixtext" /><xsl:text>&#160;</xsl:text><xsl:value-of select="@name" />
							</span>
						</xsl:when>	
						<xsl:when test="$category_displaytype='image'"><!-- Display image according to variables -->
							<a href="{/ow:wiki/ow:scriptname}?p={/ow:wiki/ow:page/@name}&amp;a=edit">
								<img border="0">
									<xsl:attribute name="src">
										<xsl:value-of select="/ow:wiki/ow:skinpath"/>/images/
										<xsl:value-of select="$category_imageprefix"/><xsl:value-of select="position()"/>.<xsl:value-of select="$category_imagetype"/>
									</xsl:attribute>
								</img>	
							</a>	
						</xsl:when>	
					</xsl:choose>
				</xsl:when>
			</xsl:choose>	
		</xsl:for-each>
	  </xsl:if>	
	</xsl:template>


<!-- This template is for the macro <TitleCategoryIndex> -->
	<!--
	// In skinconfig.xsl: category_listshow = yes|no
	-->
	<xsl:template match="ow:categoryindex">
		<xsl:if test="$category_listshow='yes'">
			<hr />
				Active Categories: (total=<xsl:value-of select="count(/ow:wiki/ow:categories/ow:category)"/>)
					<ol>
					<xsl:for-each select="/ow:wiki/ow:categories/ow:category">
						<li><xsl:value-of select="@name"/></li>
					</xsl:for-each>	
					</ol>
				<em>Only pages with categories other than 'No Category' are listed below</em>
			<hr />
		</xsl:if>	
		<xsl:for-each select="ow:page">
			<xsl:if test="not(./preceding-sibling::*[position()=1]/@category = @category)">
				<!-- New Category found -->
				<xsl:variable name="newcat" select="@category"/>
				<xsl:for-each select="/ow:wiki/ow:categories/ow:category">
					<xsl:if test="($newcat=position())">
						<br/>
						Category:
						<b>
							<xsl:value-of select="@name"/>
						</b>
						<br/>
					</xsl:if>
				</xsl:for-each>

			</xsl:if>
			<xsl:apply-templates select="ow:link"/>
			<xsl:if test="/ow:wiki/ow:summary/@active='yes'">
			<!-- only proceed if cUseSummary=1 -->
				<xsl:if test="ow:change/ow:summary/text()">
					<!-- only display summary is there is one -->
					<small><span style="color:#ff0000"><xsl:text> - </xsl:text><xsl:value-of select="ow:change/ow:summary/text()"/></span></small>
				</xsl:if>	
			</xsl:if>
			<xsl:if test="@hits">
                        - page views: <b><xsl:value-of select="@hits"/></b>
			</xsl:if>

			<br/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="/ow:wiki" mode="categorysearch">
		<xsl:call-template name="brandingImage"/>
		<h1>Category search for "<xsl:value-of select="ow:categorysearch/@category"/>"</h1>
		<xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
		<hr size="1"/>
	<!--	// Include the breadcrumb trail -->
		<xsl:apply-templates select="ow:trail"/>

		<xsl:if test="/ow:wiki/ow:categories/@active='yes'"><!-- only proceed if cUseCategories=1 -->
			<h2>Search for category "<xsl:value-of select="ow:categorysearch/@category"/>" pages</h2>
			<hr size="1"/>
			<xsl:apply-templates select="ow:categorysearch"/>
			<xsl:value-of select="count(ow:categorysearch/ow:page)"/> hits out of
			<xsl:value-of select="ow:categorysearch/@pagecount"/> pages searched.
			<hr size="1"/>
		</xsl:if>
    </xsl:template>

</xsl:stylesheet>
