<?xml version="1.0" encoding="utf-8"?>
<!--
** SUMMARIES TEMPLATE FOR INCLUSION **
** Code by Gordon Bamber 2004 **
$Log: summaries.xsl,v $
Revision 1.2  2007/01/07 11:24:41  piixiiees
gFS=Chr(222) due to problems working with Chr(179) in utf-8 and some files saved with encoding="utf-8"

Revision 1.1  2006/04/20 01:00:26  piixiiees
Temporary copy of skins/common/*.* to evolution skin to be able to modify the structure of the skin without impacting to other skins.
New style of BrogressBar; now printable.
New file macros.xsl to include the templates for the macros.

Revision 1.6  2006/01/31 03:45:27  piixiiees
It is more clear not to show the 'edit precis'. To edit the summary edit the page

Revision 1.5  2006/01/24 01:13:40  piixiiees
Included new entry for english-language lang_027=Precis.
This will allow to personalize the text of the summary label of the wiki pages
The include to the lang-en.xsl has been added as well to the default skin.

Revision 1.4  2004/10/20 18:31:57  gbamber
Improved formatting and BugFixes in XSL

Revision 1.3  2004/10/19 12:40:12  gbamber
Massive serialising update.

Revision 1.2  2004/10/13 12:18:59  gbamber
Forced updates to make sure CVS reflects current work

Revision 1.1  2004/10/13 11:10:18  gbamber
Updated Summaries in default and default_left

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
        <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>


<!-- This template goes in the mode=@edit editing window -->
<xsl:template name="summaryeditdisplay">
        <xsl:if test="/ow:wiki/ow:summary/@active='yes'">
        <!-- only proceed if cUseSummary=1 -->
                <div align="left" style="border-top: silver 1px solid;margin:5px;">Page summary (max 255 characters)</div>
                <div align="left" style="border-bottom: silver 1px solid;padding:5px;">
                        <input type="text" name="summary" style="color:#333333;" maxlength="255">
                                <xsl:attribute name="size"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:cols"/></xsl:attribute>
                                <xsl:attribute name="value"><xsl:value-of select="ow:page/ow:change/ow:summary/text()"/></xsl:attribute>
                                <xsl:attribute name="style">font-family: monospace</xsl:attribute>
                        </input>
                </div>
        </xsl:if>
</xsl:template>

<!-- This template goes somewhere on the visible part of the page -->
<xsl:template name="summarypagedisplay">
        <xsl:if test="/ow:wiki/ow:summary/@active='yes'"><!-- only proceed if cUseSummary=1 -->
                <xsl:choose>
                        <xsl:when test="../../../ow:body"> <!-- don't show in an included page -->
                        </xsl:when>
                        <!-- If text is there, then show it -->
                        <xsl:when test="/ow:wiki/ow:page/ow:change/ow:summary/text()">
                                <br />
                                <hr noshade="1" color="#FF0000" size="0" />
                                <!-- lang_027:Summary -->
                          		<small><xsl:value-of select="$lang_027"/> : <strong><xsl:value-of select="/ow:wiki/ow:page/ow:change/ow:summary/text()"/></strong></small>
                        </xsl:when>
                        <!-- Otherwise show an edit page link --> 
                        <!-- It is more clear not to show the edit precis. To edit the summary edit the page -->
                        <!-- <xsl:otherwise>
                                <br />
                                <hr noshade="1" color="#FF0000" size="0" />
                                <a class="same">
                                <xsl:attribute name="title">Edit this <xsl:value-of select="$lang_027"/></xsl:attribute>
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit
                                        <xsl:if test="@revision">
                                                &amp;revision=<xsl:value-of select="@revision"/></xsl:if></xsl:attribute>
                                Edit <xsl:value-of select="$lang_027"/>:</a>
                             </xsl:otherwise> -->
                </xsl:choose>
        </xsl:if>
</xsl:template>

<xsl:template name="summaryrecentchanges">
        <xsl:if test="ow:change/ow:summary/text()">
                <tr class="rc">
                        <td align="left" colspan="2">&#160;</td>
                        <td align="left" colspan="2">
                                <small><span style="color:#ff0000"><xsl:value-of select="ow:change/ow:summary/text()" /></span></small>
                        </td>
                </tr>
        </xsl:if>
</xsl:template>

<!-- This template is for the result of <SummarySearch> -->
<xsl:template match="/ow:wiki" mode="summarysearch">
        <xsl:call-template name="brandingImage"/>
        <h1>Summary search for "<xsl:value-of select="ow:summarysearch/@value"/>"</h1>
        <xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
        <hr size="1"/>
<!--        // Include the breadcrumb trail -->
        <xsl:apply-templates select="ow:trail"/>
        <xsl:apply-templates select="ow:summarysearch"/>
        <xsl:value-of select="count(ow:summarysearch/ow:page)"/> hits out of
        <xsl:value-of select="ow:summarysearch/@pagecount"/> pages searched.
        <form name="f" method="get">
                <xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
                <hr size="1"/>
                <xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
                <br/>
                <input type="hidden" name="a" value="fullsearch"/>
                <input type="text" name="txt" size="30">
                        <xsl:attribute name="value"><xsl:value-of select="ow:titlesearch/@value"/></xsl:attribute>
                </input>
                <input type="submit" value="Search"/>
        </form>
</xsl:template>

<!-- This template is for the macro <SummarySearch> -->
        <xsl:template match="ow:summarysearch">
                <xsl:variable name="summarysearchterm"><xsl:value-of select="@value"/></xsl:variable>
                <xsl:if test="string-length(@value) > 0">
                        <h4>Pages that contain the term '<xsl:value-of select="@value"/>' in the summary</h4>
                </xsl:if>
                <ul>
                        <xsl:for-each select="ow:page">
                                <li>
                                        <xsl:if test="contains(@name, '/')">
                                        ....
                                        </xsl:if>
                                <xsl:apply-templates select="ow:link"/>
                                </li>
                        </xsl:for-each>
                </ul>
        </xsl:template>

</xsl:stylesheet>