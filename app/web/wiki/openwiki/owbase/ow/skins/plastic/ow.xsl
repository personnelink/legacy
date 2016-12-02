<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
#PLASTIC SKIN
$Log: ow.xsl,v $
Revision 1.23  2006/03/22 01:03:41  piixiiees
Small bugfix with the command Edit (link on top) when editing old revisions. Remove of blanks in the URL. Skins affected plastic and evolution.

Revision 1.22  2006/03/03 09:20:28  gbamber
added placeholder #TITLE for future mod

Revision 1.21  2006/02/20 09:00:47  gbamber
build 20060216.2
Restored defaukt cacheXSL=1
plastic skin now uses included bookmarks.xsl

Revision 1.20  2005/12/14 20:30:27  gbamber
Updated hardcoded 'Help' link in editing window

Revision 1.19  2005/12/10 08:40:38  gbamber
Minor updates

Revision 1.18  2004/11/05 11:51:05  gbamber
Changed backgound colour styles

Revision 1.17  2004/11/03 10:36:27  gbamber
BugFix: TextSearch

Revision 1.16  2004/11/01 12:19:05  gbamber
NEW: Admin function 'Nuke deprecated pages older than:'

Revision 1.15  2004/10/30 20:49:32  gbamber
1 ) You can use <xsl:value-of select="$adminpassword"/> as a parameter for a form
2 ) To test for a Wikiadmin: <xsl:if test="/ow:wiki/ow:userip='local' and /ow:wiki/ow:usertype='admin'">

Revision 1.14  2004/10/30 13:13:27  gbamber
Bold Bug Fixed

Revision 1.13  2004/10/21 21:45:00  gbamber
Moved rename template to ow_common.xsl

Revision 1.12  2004/10/20 18:32:38  gbamber
Improved formatting and BugFixes in XSL

Revision 1.11  2004/10/19 12:41:52  gbamber
Massive serialising update.

Revision 1.10  2004/10/13 12:23:20  gbamber
Forced updates to make sure CVS reflects current work

Revision 1.9  2004/10/13 11:12:36  gbamber
Updated Summaries

Revision 1.8  2004/10/11 12:55:18  gbamber
Added: <SummarySearch(PP)>
Improved:CategorySearch

Revision 1.7  2004/10/10 22:50:45  gbamber
Massive update!
Added: Summaries
Added: Default pages built-in
Added: Auto-update from openwiki classic
Modified: Default plugin status
Modified: Default Page Names
Modified: Default MSAccess DB to openwikidist.mdb
BugFix: Many MSAccess bugs fixed
Modified: plastic skin to show Summary

Revision 1.6  2004/10/10 09:46:08  gbamber
Added $showfurniture xsl variable in skinconfig
If !='yes' then display becomes minimal (just pagebody.bookmarks and edit link)

Revision 1.5  2004/10/05 13:56:31  sansei
added link on powered by logo: OPENWIKING_URL

Revision 1.4  2004/10/01 13:40:02  sansei
Added Fullsearch-highlight functionality

Revision 1.3  2004/09/27 22:52:37  gbamber
BugFix: categorysearch mode was missing

Revision 1.2  2004/09/27 20:09:16  gbamber
Incremental update.  No new build

Revision 1.1  2004/09/27 17:07:58  gbamber
Plastic Skin stuff

Revision 1.16  2004/09/26 00:13:36  gbamber
Category dropdown added

Revision 1.15  2004/09/26 00:04:19  gbamber
Updated Categories and GoogleAds in default_left and default skins

Revision 1.14  2004/09/23 15:40:44  sansei
MAJOR update - fixing Print page - and assorted other stuff

Remake of skin: default (step 1)

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
        <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
         <xsl:include href="../common/lang-en.xsl"/>
        <xsl:include href="skinconfig.xsl"/>
        <xsl:include href="../common/owconfig.xsl"/>
        <xsl:include href="../common/ow_common.xsl"/>
        <xsl:include href="../common/owinc.xsl"/>
        <xsl:include href="../common/summaries.xsl"/>
        <xsl:include href="../common/categories.xsl"/>
        <xsl:include href="../common/google_adsense.xsl"/>
        <xsl:include href="../common/owplugins.xsl"/>
        <xsl:include href="../common/bookmarks.xsl"/>
        <xsl:include href="owattach.xsl"/>
        <xsl:template match="/ow:wiki">
                <xsl:call-template name="pi"/>
                <html>
                        <xsl:call-template name="head"/>
                        <body bgcolor="{$bodybackgroundcolour}" onload="window.defaultStatus='{$brandingText}'">
							<xsl:if test="$showfurniture='no'">
								<xsl:attribute name="topmargin"><xsl:value-of select="$bodymarginsize"/></xsl:attribute>
								<xsl:attribute name="leftmargin"><xsl:value-of select="$bodymarginsize"/></xsl:attribute>
							</xsl:if>
                                <table border="{$Showborders}" class="regions">
                                        <tr valign="top">
                                                <td class="regionheader" valign="top">
                                                        <xsl:if test="$showfurniture='yes'">
                                                                <xsl:call-template name="regionheader"/>
                                                        </xsl:if>
                                                </td>
                                        </tr>
                                        <tr valign="top">
                                                <td valign="top">
                                                        <table valign="top" border="{$Showborders}" class="regionmiddle">
                                                                <tr valign="top">
                                                                        <td class="regionleft" valign="top">
                                                                                <xsl:if test="$showfurniture='yes'">
                                                                                        <xsl:call-template name="regionleft"/>
                                                                                </xsl:if>
                                                                        </td>
                                                                        <td class="regioncenter" valign="top">
                                                                                <xsl:call-template name="regioncenter"/>
                                                                        </td>
                                                                        <td class="regionright" valign="top">
                                                                                <xsl:if test="$showfurniture='yes'">
                                                                                                <xsl:call-template name="regionright"/>
                                                                                </xsl:if>
                                                                        </td>
                                                                </tr>
                                                        </table>
                                                </td>
                                        </tr>
                                        <tr valign="top">
                                                <td class="regionfooter" valign="top">
                                                        <xsl:if test="$showfurniture='yes'">
                                                                <xsl:call-template name="regionfooter"/>
                                                </xsl:if>
                                                </td>
                                        </tr>
                                </table>
                        </body>
                </html>
        </xsl:template>

<xsl:template name="regionheader">
 <!-- Put stuff in here that appears as a heading strap -->
</xsl:template>

<xsl:template name="regionfooter">
 <!-- Put stuff in here that appears as a footer strap -->
</xsl:template>

<xsl:template name="regionleft">
 <!-- Put stuff here that appears as a left-hand column -->
</xsl:template>

        <xsl:template name="regioncenter">
                <xsl:choose>
                        <xsl:when test="@mode='view'">
                                <xsl:apply-templates select="." mode="view"/>
                        </xsl:when>
                        <xsl:when test="@mode='edit'">
                                <xsl:apply-templates select="." mode="edit"/>
                        </xsl:when>
                        <xsl:when test="@mode='print'">
                                <xsl:apply-templates select="." mode="print"/>
                        </xsl:when>
<!-- #SERIALISE MODE -->
                        <xsl:when test="@mode='serialise'">
                                <xsl:apply-templates select="." mode="serialise"/>
                        </xsl:when>
                        <xsl:when test="@mode='naked'">
                                <xsl:apply-templates select="." mode="naked"/>
                        </xsl:when>
                        <xsl:when test="@mode='diff'">
                                <xsl:apply-templates select="." mode="diff"/>
                        </xsl:when>
                        <xsl:when test="@mode='changes'">
                                <xsl:apply-templates select="." mode="changes"/>
                        </xsl:when>
                        <xsl:when test="@mode='titlesearch'">
                                <xsl:apply-templates select="." mode="titlesearch"/>
                        </xsl:when>
                        <xsl:when test="@mode='fullsearch'">
                                <xsl:apply-templates select="." mode="fullsearch"/>
                        </xsl:when>
<!-- #CATEGORY START#-->
                        <xsl:when test="@mode='categorysearch'">
                                <xsl:apply-templates select="." mode="categorysearch"/>
                        </xsl:when>
<!-- #CATEGORY END#-->
<!-- #SUMMARY START#-->
                        <xsl:when test="@mode='summarysearch'">
                                <xsl:apply-templates select="." mode="summarysearch"/>
                        </xsl:when>
<!-- #SUMMARY END#-->
                        <xsl:when test="@mode='textsearch'">
                                <xsl:apply-templates select="." mode="textsearch"/>
                        </xsl:when>
                        <xsl:when test="@mode='login'">
                                <xsl:apply-templates select="." mode="login"/>
                        </xsl:when>
                        <xsl:when test="@mode='attach'">
                                <xsl:apply-templates select="." mode="attach"/>
                        </xsl:when>
                        <xsl:when test="@mode='attachchanges'">
                                <xsl:apply-templates select="." mode="attachchanges"/>
                        </xsl:when>
                        <xsl:when test="@mode='embedded'">
                                <xsl:apply-templates select="." mode="embedded"/>
                        </xsl:when>
                        <xsl:when test="@mode='rename'">
                                <xsl:apply-templates select="." mode="rename"/>
                        </xsl:when>
                </xsl:choose>
        </xsl:template>
        <xsl:template name="regionright">
                <xsl:call-template name="google_Right"/>
        </xsl:template>
        <xsl:template name="google_Right">
                <xsl:if test="$google='yes'">
                        <xsl:if test="$googleplacement='right'">
                                <xsl:call-template name="google_TallTower"/>
                        </xsl:if>
                </xsl:if>
        </xsl:template>
        <xsl:template name="google_Top">
                <xsl:if test="$google='yes'">
                        <xsl:if test="$googleplacement='top'">
                                <xsl:call-template name="google_HalfBanner"/>
                        </xsl:if>
                </xsl:if>
        </xsl:template>

<!-- #SERIALISE MODE -->
<xsl:template match="/ow:wiki" mode="serialise">
                <xsl:apply-templates select="ow:page"/>
</xsl:template>


<!-- #VIEW MODE -->
        <xsl:template match="/ow:wiki" mode="view">
                                <xsl:attribute name="ondblclick">location.href='<xsl:value-of select="ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="ow:page/@revision">&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if>'</xsl:attribute>
                <xsl:if test="$showfurniture='yes'">
                                <xsl:call-template name="brandingImage"/>
                </xsl:if>
                        <xsl:variable name="shorttitle">
                                <xsl:call-template name="cleanslash">
                                        <xsl:with-param name="runmode" select="string($title_cleanslash)"/>
                                        <xsl:with-param name="thetext" select="string(ow:page/ow:link/text())"/>
                                </xsl:call-template>
                        </xsl:variable>
                        <xsl:variable name="shortname">
                                <xsl:call-template name="cleanslash">
                                        <xsl:with-param name="runmode" select="$title_cleanslash"/>
                                        <xsl:with-param name="thetext" select="$name"/>
                                </xsl:call-template>
                        </xsl:variable>
                                <xsl:if test="(contains(ow:page/ow:link/text(), '/')) and ($title_cleanslash &gt; 0)">
                                        <a class="same" href="{ow:scriptname}?a=fullsearch&amp;txt={$name}&amp;fromtitle=true" title="Do a full text search for {ow:page/ow:link/text()}">
                                                <xsl:value-of select="ow:page/ow:link/text()"/>
                                        </a>
                                </xsl:if>
                        <h1>

<!-- #TITLE -->                                <a class="same" href="{ow:scriptname}?a=fullsearch&amp;txt={$shortname}&amp;fromtitle=true" title="Do a full text search for {$shortname}">
                                        <xsl:value-of select="$shorttitle"/>
                                </a>

                        </h1>

                <xsl:apply-templates select="ow:page"/>
        </xsl:template>

<!-- #PRINT MODE -->
        <xsl:template match="/ow:wiki" mode="print">
                <xsl:call-template name="brandingImage"/>
                <xsl:variable name="shorttitle">
                        <xsl:call-template name="cleanslash">
                                <xsl:with-param name="runmode" select="string($title_cleanslash)"/>
                                <xsl:with-param name="thetext" select="string(ow:page/ow:link/text())"/>
                        </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="shortname">
                        <xsl:call-template name="cleanslash">
                                <xsl:with-param name="runmode" select="$title_cleanslash"/>
                                <xsl:with-param name="thetext" select="$name"/>
                        </xsl:call-template>
                </xsl:variable>
                <xsl:if test="(contains(ow:page/ow:link/text(), '/')) and ($title_cleanslash &gt; 0)">
                        <xsl:value-of select="ow:page/ow:link/text()"/>
                </xsl:if>
                <h1>
                        <xsl:value-of select="$shorttitle"/>
                </h1>
                <hr noshade="noshade" size="1"/>
                <xsl:if test="//ow:redirectedfrom">
                        <p>
                                <!-- lang001:Redirected from -->
                                <b>
                                        <xsl:value-of select="$lang_001"/>: <xsl:value-of select="//ow:redirectedfrom/text()"/>
                                </b>
                        </p>
                </xsl:if>
                <xsl:if test="@revision">
                        <!-- lang002:Showing revision -->
                        <b>
                                <xsl:value-of select="$lang_002"/>
                                <xsl:value-of select="@revision"/>
                        </b>
                </xsl:if>
                <xsl:apply-templates select="//ow:body"/>

                <hr noshade="noshade" size="1"/>
                <table cellspacing="0" cellpadding="0" border="{$Showborders}" width="100%">
                        <tr>
                                <td align="left" class="n">
                                        <!-- lang003:Attachments -->
                                        <xsl:if test="/ow:wiki/ow:allowattachments">
                                                <xsl:value-of select="$lang_003"/> (<xsl:value-of select="count(//ow:attachments/ow:attachment[@deprecated='false'])"/>)
            </xsl:if>
                                        <xsl:if test="$displayhits='yes'">
                                                <xsl:if test="//@hits">
                                                        <!-- lang004:Page views -->
                                                        <xsl:value-of select="$separatorcharacter"/>
                                                        <xsl:value-of select="$lang_004"/>: <b>
                                                                <xsl:value-of select="//@hits"/>
                                                        </b>
                                                </xsl:if>
                                        </xsl:if>
                                        <!-- lang005:Page Revisions -->
                                        <xsl:if test="not(//@changes='0')">
                                                <xsl:value-of select="$separatorcharacter"/>
                                                <xsl:value-of select="$lang_005"/>: <b>
                                                        <xsl:value-of select="//@changes"/>
                                                        <!-- lang006:Last Edited -->
                                                </b>
                                                <xsl:value-of select="$separatorcharacter"/>
                                                <xsl:value-of select="$lang_006"/>: <xsl:value-of select="ow:formatLongDate(string(//ow:change/ow:date))"/>
                                                <xsl:text> </xsl:text>
                                                <xsl:if test="//ow:change/ow:by/@alias"> by <xsl:value-of select="//ow:change/ow:by/@alias"/>
                                                        <xsl:text> </xsl:text>
                                                </xsl:if>
                                                <br/>
                                        </xsl:if>
                                        <p>
                                                <a class="functions">
                                                        <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>
                                                        <!-- lang007:Exit print view -->
                                                        <strong>
                                                                <xsl:value-of select="$lang_007"/>
                                                        </strong>
                                                </a>
                                        </p>
                                </td>

                                <td align="right" rowspan="2" valign="bottom">
                                        <xsl:call-template name="poweredBy"/>
                                        <br/>
                                        <xsl:call-template name="validatorButtons"/>
                                </td>
                        </tr>
                </table>
        </xsl:template>


<!-- #PAGE -->
<xsl:template match="ow:page">
 <xsl:choose>
        <xsl:when test="$showfurniture='yes'">
                <xsl:if test="$displaycategory='yes'">
                        <!-- START CATEGORY DISPLAY -->
                        <strong>
                                <xsl:call-template name="categorydisplay"/><xsl:text> </xsl:text>
                        </strong>
                        <br/>
                        <!-- END CATEGORY DISPLAY -->
                </xsl:if>
                <xsl:choose>
                        <xsl:when test="contains($name, '/')">
                                <a class="functions">
                                        <xsl:attribute name="href"><xsl:value-of select="/ow:page/ow:wiki/ow:scriptname"/>?p=<xsl:call-template name="TrimLastWordPart"><xsl:with-param name="WikiWordPart" select="$name"/></xsl:call-template></xsl:attribute>
                                        <!-- lang008:Up a level -->
                                        <xsl:value-of select="$lang_008"/>
                                </a>
                                <xsl:value-of select="$separatorcharacter"/>
                        </xsl:when>
                        <xsl:otherwise>
						</xsl:otherwise>
                </xsl:choose>
                <xsl:if test="/ow:wiki/ow:userpreferences/ow:editlinkontop">
                        <a class="same">
                                <xsl:attribute name="title"><!-- lang009:Edit --><!-- lang010:this page --><xsl:value-of select="$lang_009"/><xsl:text> </xsl:text><xsl:value-of select="$lang_010"/></xsl:attribute>
                                <!-- lang009:Edit -->
                                <!-- lang010:this page -->
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="@revision">&amp;revision=<xsl:value-of select="@revision"/></xsl:if></xsl:attribute><xsl:value-of select="$lang_009"/>
                        </a>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="$lang_010"/>
                        <xsl:if test="not(@changes='0')">
                                <!-- lang006:Last Edited -->
                                <font size="-2"> (<xsl:value-of select="$lang_006"/>
                                        <xsl:value-of select="ow:formatLongDate(string(ow:change/ow:date))"/>)</font>
                        </xsl:if>
                        <br/>
                </xsl:if>
                <xsl:if test="/ow:wiki/ow:userpreferences/ow:bookmarksontop">
                        <xsl:if test="not(/ow:wiki/ow:userpreferences/ow:bookmarks='None')">
                                <xsl:apply-templates select="/ow:wiki/ow:userpreferences/ow:bookmarks"/>
                        </xsl:if>
                </xsl:if>
                <hr noshade="noshade" size="1"/>
                <xsl:apply-templates select="../ow:trail"/>
                <xsl:if test="../ow:redirectedfrom">
                        <!-- lang001:Redirected from -->
                        <xsl:value-of select="$lang_001"/>
                </xsl:if>
                <br/>
                <b>
                        <a>
                                <!-- lang009:Edit -->
                                <!-- lang010:this page -->
                                <xsl:attribute name="title"><xsl:value-of select="$lang_009"/><xsl:value-of select="$lang_010"/></xsl:attribute>
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?a=edit&amp;p=<xsl:value-of select="ow:urlencode(string(../ow:redirectedfrom/@name))"/></xsl:attribute>
                                <xsl:value-of select="../ow:redirectedfrom/text()"/>
                        </a>
                </b>
                <p/>
                <xsl:if test="@revision">
                                                <!-- lang002:Showing revision -->
                        <b><xsl:value-of select="$lang_002"/> <xsl:value-of select="@revision"/>
                        </b>
                </xsl:if>
                <xsl:apply-templates select="ow:body"/>
                <hr noshade="noshade" size="1"/>
                <table cellspacing="0" cellpadding="0" border="{$Showborders}" width="100%">
                        <xsl:if test="not(/ow:wiki/ow:userpreferences/ow:bookmarks='None')">
                                <tr>
                                        <td align="left" class="n">
                                                <xsl:apply-templates select="/ow:wiki/ow:userpreferences/ow:bookmarks"/>
                                                <br/>
                                                <xsl:if test="$displayeditlink='yes'">
                                                        <a class="functions">
                                                        <!-- lang009:Edit --><!-- lang011:revision --><!-- lang010:this page -->
                                                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="@revision">&amp;revision=<xsl:value-of select="@revision"/></xsl:if></xsl:attribute><xsl:value-of select="$lang_009"/><xsl:text> </xsl:text>
                                                                <xsl:if test="@revision"><xsl:value-of select="$lang_011"/><xsl:text> </xsl:text><xsl:value-of select="@revision"/> of</xsl:if> <xsl:value-of select="$lang_010"/></a>
                                                        <!-- Added for rename capability -->
                                                </xsl:if>
                                                <xsl:if test="$displayrename='yes'">
                                                        <xsl:value-of select="$separatorcharacter"/>
                                                        <a class="functions">
                                                        <!-- lang012:Rename this page -->
                                                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=rename&amp;step=first</xsl:attribute><xsl:value-of select="$lang_012"/></a>
                                                        <xsl:if test="@revision or (ow:change and not(ow:change/@revision = 1))">
                                                 </xsl:if>
                                                 <xsl:if test="$displayviewrevisions='yes'">
                                                                <xsl:value-of select="$separatorcharacter"/>
                                                                <a class="functions">
                                                                <!-- lang013:View other revisions -->
                                                                        <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute><xsl:value-of select="$lang_013"/></a>
                                                 </xsl:if>
                                                        <xsl:if test="@revision">
                                                                <xsl:value-of select="$separatorcharacter"/>
                                                                <a class="functions">
                                                                <!-- lang014:View current revision -->
                                                                        <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute><xsl:value-of select="$lang_014"/></a>
                                                        </xsl:if>
                                                        <xsl:if test="/ow:wiki/ow:allowattachments">
                                                                                                                </xsl:if>
                                                 <xsl:if test="$displayattachments='yes'">
                                                                <xsl:value-of select="$separatorcharacter"/>
                                                                <a class="functions">
                                                                <!-- lang003:Attachments -->
                                                                        <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=attach</xsl:attribute><xsl:value-of select="$lang_003"/></a> (<xsl:value-of select="count(ow:attachments/ow:attachment[@deprecated='false'])"/>)
                                                                                                 </xsl:if>
                                                 </xsl:if>
                                                 <xsl:if test="$displayprint='yes'">
                                                        <xsl:value-of select="$separatorcharacter"/>
                                                        <a class="functions">
                                                        <!-- lang015:Print this page -->
                                                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:change/@revision"/></xsl:attribute><xsl:value-of select="$lang_015"/></a>
                                                 </xsl:if>
                                                 <xsl:if test="$displayxml='yes'">
                                                        <xsl:value-of select="$separatorcharacter"/>
                                                        <a class="functions">
                                                        <!-- lang016:View XML -->
                                                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=xml&amp;revision=<xsl:value-of select="ow:change/@revision"/></xsl:attribute><xsl:value-of select="$lang_016"/></a>
                                                 </xsl:if>
                                                <!-- START HITS CODE -->
                                                 <xsl:if test="$displayhits='yes'">
                                                        <xsl:if test="@hits">
                                                                <xsl:value-of select="$separatorcharacter"/>
                                                                <!-- lang004:Page views -->
                                                                        <xsl:value-of select="$lang_004"/>: <b>
                                                                        <xsl:value-of select="@hits"/>
                                                                </b>
                                                        </xsl:if>
                                                 </xsl:if>
                                                 <!-- END HITS CODE -->
                                                 <br/>
                                                 <xsl:if test="$displayfind='yes'">
                                                        <a class="functions">
                                                        <!-- lang017:Find page --><!-- lang018:by browsing, searching or an index -->
                                                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=FindPage&amp;txt=<xsl:value-of select="$name"/></xsl:attribute><xsl:value-of select="$lang_017"/></a><xsl:text> </xsl:text><xsl:value-of select="$lang_018"/>
                                                                                                </xsl:if>
                                                <xsl:if test="$displayrevisions='yes'">
                                                        <xsl:if test="not(@changes='0')">
                                                                <xsl:value-of select="$separatorcharacter"/>
                                                                <!-- lang005:Page Revisions -->
                                                <xsl:value-of select="$lang_005"/>: <b>
                                                                        <xsl:value-of select="@changes"/>
                                                                </b>
                                                        </xsl:if>
                                                        <xsl:if test="$displaylastedited='yes'">
                                                                <br/><!-- lang019:Last edited --><!-- lang020:by -->
                                                                                                                                <xsl:value-of select="$lang_019"/><xsl:text> </xsl:text><xsl:value-of select="ow:formatLongDate(string(ow:change/ow:date))"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:if test="ow:change/ow:by/@alias">
                                                                                                                                                <xsl:value-of select="$lang_020"/><xsl:text> </xsl:text><xsl:value-of select="ow:change/ow:by/@alias"/>
                                                                        <xsl:text> </xsl:text>
                                                                </xsl:if>
                                                        </xsl:if>
                                                        <xsl:value-of select="$separatorcharacter"/>
                                                        <a class="functions">
                                                        <!-- lang021:diff -->
                                                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/><xsl:if test="ow:change/@revision">&amp;difffrom=<xsl:value-of select="ow:change/@revision - 1"/></xsl:if>&amp;a=diff</xsl:attribute>(<xsl:value-of select="$lang_021"/>)</a>
                                                        <br/>
                                                </xsl:if>
                                                                                                <xsl:if test="/ow:wiki/ow:userip='local' and /ow:wiki/ow:usertype='admin'">
                                                                                                                <xsl:call-template name="adminfunctions"/>
                                                                                                </xsl:if>
                                                <xsl:if test="$displaysearchbox='yes'">
                                                        <xsl:call-template name="searchbox"/>
                                                </xsl:if>
                                        </td>
                                        <td align="right" rowspan="2" valign="bottom">
                                                <xsl:call-template name="poweredBy"/>
                                                <br/>
                                                <xsl:call-template name="validatorButtons"/>
                                        </td>
                                </tr>
                        </xsl:if>
                </table>
        </xsl:when>
        <xsl:otherwise>
        <div style="position:realtive;top=0px;left=0px;z-order=98;">
                        <xsl:apply-templates select="ow:body"/>
                <div style="position:relative;top=0px;left=10px;z-order=99;">
                <hr height="1" color="#ff0000"/>
                                <xsl:if test="not(/ow:wiki/ow:userpreferences/ow:bookmarks='None')">
                                        <xsl:apply-templates select="/ow:wiki/ow:userpreferences/ow:bookmarks"/>
                                </xsl:if>
                <xsl:if test="/ow:wiki/ow:userpreferences/ow:editlinkontop">
                <br />
                        <a class="same">
                                <xsl:attribute name="title"><!-- lang009:Edit --><!-- lang010:this page --><xsl:value-of select="$lang_009"/><xsl:text> </xsl:text><xsl:value-of select="$lang_010"/></xsl:attribute>
                                <!-- lang009:Edit --> <!-- lang010:this page -->
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="@revision">&amp;revision=<xsl:value-of select="@revision"/></xsl:if>
                                </xsl:attribute><xsl:text> </xsl:text><xsl:value-of select="$lang_009"/>
                        </a>
                        <xsl:text> </xsl:text><xsl:value-of select="$lang_010"/>
                        <xsl:if test="not(@changes='0')"> <!-- lang006:Last Edited -->
                                <font size="-2"> (<xsl:value-of select="$lang_006"/>
                                        <xsl:value-of select="ow:formatLongDate(string(ow:change/ow:date))"/>)</font>
                        </xsl:if>
                        <br/>
                </xsl:if>
                </div>
        </div>
        </xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- #BODY OF PAGE -->
        <xsl:template match="ow:body">
                <xsl:if test=".='' and not(/ow:wiki/@mode='embedded')">
                        <br/>
                        <a>
                        <!-- lang022:Describe --><!-- lang023:here -->
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit</xsl:attribute><xsl:value-of select="$lang_022"/><xsl:text> '</xsl:text><xsl:value-of select="../ow:link/text()"/><xsl:text>' </xsl:text><xsl:value-of select="$lang_023"/></a>
                        <xsl:apply-templates select="../../ow:templates"/>
                </xsl:if>
                <xsl:if test="starts-with(text(), '#DEPRECATED')">
                        <font color="#ff0000">
                        <!-- lang024:This page will be permanently destroyed -->
                                <b><xsl:value-of select="$lang_024"/>.</b>
                        </font>
                        <p/>
                </xsl:if>
                <xsl:if test='$FullsearchHighlight = "1"'>
                        <xsl:if test="$hido = 0">
                                <p>
                                        <small><!-- lang025:HIGHLIGHT -->
                                                <xsl:value-of select="$lang_025"/>:
                                                <strong>
                                                        <a href="{ow:scriptname}?p={$name}&amp;highlight={$hiterm}&amp;hido=1&amp;hiterm={$hiterm}">
                                                                <xsl:value-of select="$hiterm"/>
                                                        </a>
                                                </strong>
                                        </small>
                                </p>
                        </xsl:if>
                        <xsl:if test="$hido = 1">
                                <p>
                                        <small>
                                                <strong><!-- lang026:HIGHLIGHT OFF -->
                                                        <a href="{ow:scriptname}?p={$name}&amp;hido=0&amp;hiterm={$hiterm}">
                                                                <xsl:value-of select="$lang_026"/>
                                                        </a>
                                                </strong>
                                        </small>
                                </p>
                        </xsl:if>
                </xsl:if>
                <xsl:apply-templates select="text() | *"/>
<!-- #SUMMARY PAGE DISPLAY START# -->
                <xsl:call-template name="summarypagedisplay" />
<!-- #SUMMARY PAGE DISPLAY END# -->
                <xsl:apply-templates select="../ow:attachments">
                        <xsl:with-param name="showhidden">false</xsl:with-param>
                        <xsl:with-param name="showactions">false</xsl:with-param>
                </xsl:apply-templates>
        </xsl:template>
<!-- #VALIDATOR -->
        <xsl:template name="validatorButtons">
                <xsl:if test="$displayValidatorbuttons &gt; 0">
                        <a href="http://validator.w3.org/check/referer">
                                <img src="{/ow:wiki/ow:imagepath}/valid-xhtml10.gif" alt="Valid XHTML 1.0!" width="88" height="31" border="0"/>
                        </a>
                        <a href="http://jigsaw.w3.org/css-validator/validator?uri={/ow:wiki/ow:location}ow.css">
                                <img src="{/ow:wiki/ow:imagepath}/valid-css.gif" alt="Valid CSS!" width="88" height="31" border="0"/>
                        </a>
                </xsl:if>
        </xsl:template>

<!-- #DIFF MODE -->
        <xsl:template match="/ow:wiki" mode="diff">
                <xsl:call-template name="brandingImage"/>
                <xsl:if test="displaypagetitle='yes'">
                        <h1>
                                <xsl:choose>
                                        <xsl:when test="linkpagetitle='yes'">
                                                <a class="same" href="{ow:scriptname}?a=fullsearch&amp;txt={$name}&amp;fromtitle=true" title="Do a full text search for {ow:page/ow:link/text()}">
                                                        <xsl:value-of select="ow:page/ow:link/text()"/>
                                                </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <xsl:value-of select="ow:page/ow:link/text()"/>
                                        </xsl:otherwise>
                                </xsl:choose>
                        </h1>
                </xsl:if>
                <xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
                <hr noshade="noshade" size="1"/>
                <xsl:choose>
                        <xsl:when test="ow:diff = ''">
                                <b>No difference available. This is the first <xsl:value-of select="ow:diff/@type"/> revision.</b>
                                <hr noshade="noshade" size="1"/>
                                <xsl:apply-templates select="ow:trail"/>
                                <xsl:if test="ow:page/@revision">
                                        <b>Showing revision <xsl:value-of select="ow:page/@revision"/>
                                        </b>
                                        <p/>
                                </xsl:if>
                                <xsl:apply-templates select="ow:page/ow:body"/>
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:if test="not(ow:diff/@type='selected')">
                                        <b>Difference from prior <xsl:value-of select="ow:diff/@type"/>
                revision<xsl:if test="not(ow:diff/@to = ow:page/@lastminor)"> relative to revision
                <xsl:value-of select="ow:diff/@to"/>
                                                </xsl:if>.</b>
                                </xsl:if>
                                <xsl:if test="ow:diff/@type='selected'">
                                        <b>Difference from revision <xsl:value-of select="ow:diff/@from"/> to
                <xsl:choose>
                                                        <xsl:when test="ow:diff/@to = ow:page/@lastminor">
                        the current revision.
                    </xsl:when>
                                                        <xsl:otherwise>
                        revision <xsl:value-of select="ow:diff/@to"/>.
                    </xsl:otherwise>
                                                </xsl:choose>
                                        </b>
                                </xsl:if>
                                <br/>
                                <xsl:if test="not(ow:diff/@type='major')">
                                        <a>
                                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=diff</xsl:attribute>major diff</a>
                                        <xsl:text> </xsl:text>
                                </xsl:if>
                                <xsl:if test="not(ow:diff/@type='minor')">
                                        <a>
                                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=diff&amp;diff=1</xsl:attribute>minor diff</a>
                                        <xsl:text> </xsl:text>
                                </xsl:if>
                                <xsl:if test="not(ow:diff/@type='author')">
                                        <a>
                                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=diff&amp;diff=2</xsl:attribute>author diff</a>
                                        <xsl:text> </xsl:text>
                                </xsl:if>
                                <a>
                                        <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/><xsl:if test="ow:diff/@to">&amp;revision=<xsl:value-of select="ow:diff/@to"/></xsl:if></xsl:attribute>hide diff</a>
                                <p/>
                                <xsl:apply-templates select="ow:diff"/>
                        </xsl:otherwise>
                </xsl:choose>
                <form name="f" method="get">
                        <xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
                        <hr size="1"/>
                        <xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
                        <br/>
                        <a>
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="ow:page/@revision">&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if></xsl:attribute>Edit <xsl:if test="ow:page/@revision">revision <xsl:value-of select="ow:page/@revision"/> of</xsl:if> this page</a>
                        <xsl:if test="ow:page/@revision or (ow:page/ow:change and not(ow:page/ow:change/@revision = 1))">
                                <xsl:value-of select="$separatorcharacter"/>
                                <a>
                                        <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute>View other revisions</a>
                        </xsl:if>
                        <xsl:if test="ow:page/@revision">
                                <xsl:value-of select="$separatorcharacter"/>
                                <a>
                                        <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>View current revision</a>
                        </xsl:if>
                        <br/>
                        <a>
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:page/ow:change/@revision"/></xsl:attribute>Print this page</a>
                        <xsl:value-of select="$separatorcharacter"/>
                        <a class="same">
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=diff&amp;revision=<xsl:value-of select="ow:change/@revision"/>&amp;xml=1</xsl:attribute>View XML</a>
                        <br/>
                        <a>
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=FindPage&amp;txt=<xsl:value-of select="$name"/></xsl:attribute>Find page</a> by browsing, searching or an index
    <br/>
                        <xsl:if test="not(ow:page/@changes='0')">
        Edited <xsl:value-of select="ow:formatLongDate(string(ow:page/ow:change/ow:date))"/>
                                <xsl:text> </xsl:text>
                                <a>
                                        <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/><xsl:if test="ow:diff/@to">&amp;revision=<xsl:value-of select="ow:diff/@to"/></xsl:if></xsl:attribute>(hide diff)</a>
                                <br/>
                        </xsl:if>
                        <input type="hidden" name="a" value="fullsearch"/>
                        <input type="text" name="txt" size="30"/>
                        <input type="submit" value="Search"/>
                </form>
        </xsl:template>

        <!-- ## CHANGES MODE ## -->
        <xsl:template match="ow:wiki" mode="changes">
                <xsl:call-template name="brandingImage"/>
                <h1>History of "<xsl:value-of select="ow:page/ow:link/text()"/>"</h1>
                <xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
                <hr size="1"/>
                <ul>
                        <xsl:for-each select="ow:page/ow:change">
                                <li>
            Revision:
            <xsl:value-of select="@revision"/>
            . .
            <xsl:value-of select="ow:formatLongDate(string(ow:date))"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="ow:formatTime(string(ow:date))"/>
                                        <xsl:text> </xsl:text>
                                        <a>
                                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;revision=<xsl:value-of select="@revision"/></xsl:attribute>View</a>
                                        <xsl:if test="position() > 1">
                (<a>
                                                        <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=diff&amp;difffrom=<xsl:value-of select="@revision"/></xsl:attribute>diff</a>)
            </xsl:if>
            . . . . . .
            <xsl:choose>
                                                <xsl:when test="ow:by/@alias">
                                                        <a>
                                                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?<xsl:value-of select="ow:urlencode(string(ow:by/@alias))"/></xsl:attribute>
                                                                <xsl:value-of select="ow:by/text()"/>
                                                        </a>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                        <xsl:value-of select="ow:by/@name"/>
                                                </xsl:otherwise>
                                        </xsl:choose>
                                        <xsl:if test="ow:comment">
                                                <br/>
                                                <xsl:text> </xsl:text>
                                                <span class="comment">
                                                        <xsl:value-of select="ow:comment"/>
                                                </span>
                                        </xsl:if>
                                </li>
                        </xsl:for-each>
                </ul>
                <hr size="1"/>
                <table cellspacing="0" cellpadding="0" border="{$Showborders}" width="100%">
                        <xsl:if test="not(/ow:wiki/ow:userpreferences/ow:bookmarks='None')">
                                <tr>
                                        <td align="left" class="n">
                                                <xsl:apply-templates select="/ow:wiki/ow:userpreferences/ow:bookmarks"/>
                                                <br/>
                                                <a class="functions">
                                                        <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=FindPage&amp;txt=<xsl:value-of select="$name"/></xsl:attribute>Find page</a> by browsing, searching or an index
                                        <xsl:call-template name="searchbox"/>
                                        </td>
                                        <td align="right" rowspan="2" valign="bottom">
                                                <xsl:call-template name="poweredBy"/>
                                                <br/>
                                                <xsl:call-template name="validatorButtons"/>
                                        </td>
                                </tr>
                        </xsl:if>
                </table>
        </xsl:template>

<!-- #TITLESEARCH MODE -->
        <xsl:template match="/ow:wiki" mode="titlesearch">
                <xsl:call-template name="brandingImage"/>
                <h1>Title search for "<xsl:value-of select="ow:titlesearch/@value"/>"</h1>
                <xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
                <hr size="1"/>
<!--        // Include the breadcrumb trail -->
                <xsl:apply-templates select="ow:trail"/>
                <xsl:apply-templates select="ow:titlesearch"/>
                <xsl:value-of select="count(ow:titlesearch/ow:page)"/> hits out of
    <xsl:value-of select="ow:titlesearch/@pagecount"/> pages searched.

    <form name="f" method="get">
                        <xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
                        <hr size="1"/>
                        <xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
                        <br/>
                        <input type="hidden" name="a" value="titlesearch"/>
                        <input type="text" name="txt" size="30">
                                <xsl:attribute name="value"><xsl:value-of select="ow:titlesearch/@value"/></xsl:attribute>
                        </input>
                        <input type="submit" value="Search"/>
                </form>
        </xsl:template>


<!-- #TEXTSEARCH -->
        <xsl:template match="/ow:wiki" mode="textsearch">
                <xsl:call-template name="brandingImage"/>
                <h1>Text search for "<xsl:value-of select="ow:textsearch/@value"/>"</h1>
                <xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
                <hr size="1"/>
                <xsl:apply-templates select="ow:textsearch"/>
                <xsl:value-of select="count(ow:textsearch/ow:page)"/> hits out of
                <xsl:value-of select="ow:textsearch/@pagecount"/> pages searched.

                <form name="f" method="get">
                        <xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
                        <hr size="1"/>
                        <xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
                        <br/>
                        <input type="hidden" name="a" value="textsearch"/>
                        <input type="text" name="txt" size="30">
                                <xsl:attribute name="value"><xsl:value-of select="ow:textsearch/@value"/></xsl:attribute>
                        </input>
                        <input type="submit" value="Search"/>
                </form>
        </xsl:template>


<!-- #FULLSEARCH MODE -->
        <xsl:template match="/ow:wiki" mode="fullsearch">
                <xsl:call-template name="brandingImage"/>
                <h1>Full text search for "<xsl:value-of select="ow:fullsearch/@value"/>"</h1>
                <xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
                <hr size="1"/>
                <xsl:apply-templates select="ow:fullsearch"/>
                <xsl:value-of select="count(ow:fullsearch/ow:page)"/> hits out of
    <xsl:value-of select="ow:fullsearch/@pagecount"/> pages searched.

    <form name="f" method="get">
                        <xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
                        <hr size="1"/>
                        <xsl:apply-templates select="ow:userpreferences/ow:bookmarks"/>
                        <br/>
                        <input type="hidden" name="a" value="fullsearch"/>
                        <input type="text" name="txt" size="30">
                                <xsl:attribute name="value"><xsl:value-of select="ow:fullsearch/@value"/></xsl:attribute>
                        </input>
                        <input type="submit" value="Search"/>
                </form>
        </xsl:template>

<!--#LOGIN -->
        <xsl:template match="/ow:wiki" mode="login">
                <!--body bgcolor="#ffffff" onload="this.document.f.pwd.focus();"-->
                <table width="100%" border="{$Showborders}" height="100%">
                        <tr>
                                <td align="center" valign="center">
                                        <table border="{$Showborders}" cellspacing="0" cellpadding="70" bgcolor="#eeeeee">
                                                <tr>
                                                        <td>
                                                                <xsl:if test="ow:login/@mode='edit'">
                                                                        <b>Enter password to edit content</b>
                                                                        <br/>
                                                                        <br/>
                                                                </xsl:if>
                                                                <xsl:apply-templates select="ow:error"/>
                                                                <table border="{$Showborders}">
                                                                        <form name="f" method="post" action="{/ow:wiki/ow:scriptname}?a=login&amp;mode={ow:login/@mode}">
                                                                                <tr>
                                                                                        <td>password</td>
                                                                                        <td>
                                                                                                <input type="password" name="pwd" size="10"/>
                                                                                                <xsl:text> </xsl:text>
                                                                                                <input type="submit" name="submit" value="let me in!"/>
                                                                                        </td>
                                                                                </tr>
                                                                                <tr>
                                                                                        <td>&#160;</td>
                                                                                        <td>
                                                                                                <input type="checkbox" name="r" value="1">
                                                                                                        <xsl:if test="ow:login/ow:rememberme='false'">
                                                                                                                <xsl:attribute name="checked">checked</xsl:attribute>
                                                                                                        </xsl:if>
                                                                                                </input>
                Remember me
                </td>
                                                                                </tr>
                                                                                <input type="hidden" name="backlink">
                                                                                        <xsl:attribute name="value"><xsl:value-of select="ow:login/ow:backlink"/></xsl:attribute>
                                                                                </input>
                                                                        </form>
                                                                </table>
                                                        </td>
                                                </tr>
                                        </table>
                                </td>
                        </tr>
                </table>
        </xsl:template>


<!-- #EDIT MODE -->
        <xsl:template match="/ow:wiki" mode="edit">
                <xsl:attribute name="onload">document.frmEdit.text.focus();</xsl:attribute>
    <script language="javascript" type="text/javascript" charset="{@encoding}">
        <xsl:text disable-output-escaping="yes">&lt;!--
        function openw(pURL)
        {
            var w = window.open(pURL, "openw", "width=680,height=560,resizable=1,statusbar=1,scrollbars=1");
            w.focus();
        }

        function preview()
        {
            var w = window.open("", "preview", "width=680,height=560,resizable=1,statusbar=1,scrollbars=1");
            w.focus();

            var body = '&lt;html&gt;&lt;head&gt;&lt;meta http-equiv="Content-Type" content="text/html; charset=</xsl:text>
                        <xsl:value-of select="@encoding"/>
                        <xsl:text disable-output-escaping="yes">;" />&lt;/head&gt;&lt;body&gt;&lt;form name="pvw" method="post" action="</xsl:text>
                        <xsl:value-of select="/ow:wiki/ow:location"/>
                        <xsl:value-of select="/ow:wiki/ow:scriptname"/>
                        <xsl:text disable-output-escaping="yes">" /&gt;';
            body += '&lt;input type="hidden" name="a" value="preview" /&gt;';
            body += '&lt;input type="hidden" name="p" value="</xsl:text>
                        <xsl:value-of select="$name"/>
                        <xsl:text disable-output-escaping="yes">" /&gt;';
            body += '&lt;input id="text" type="hidden" name="text"/&gt;&lt;/form&gt;&lt;/body&gt;&lt;/html&gt;';

            w.document.open();
            w.document.write(body);
            w.document.close();

            w.document.forms[0].elements['text'].value = window.document.forms[0].elements['text'].value;
            w.document.forms[0].submit();
        }
        function CheckTab(el) {
            if ((document.all)&amp;&amp;(9==event.keyCode))
                        {
                el.selection=document.selection.createRange();
                el.selection.text='  '
                event.returnValue=false
            }
        }

        function saveDocumentCheck(evt) {
                var desiredKeyState = evt.ctrlKey &amp;&amp; !evt.altKey &amp;&amp; !evt.shiftKey;
                var key = evt.keyCode;
                var charS = 83;
                if ( desiredKeyState &amp;&amp; key == charS ) {
                        window.document.forms[0].elements['save'][0].click();
                        evt.returnValue = false;
                }
        }

        function theTextAreaValue() {
            return window.document.forms[0].elements['text'].value;
        }

        savedValue = 'Empty';
        function checkChanged() {
                currentValue = theTextAreaValue();
                if (currentValue != savedValue) {
                        event.returnValue = 'Text changed without saving.';
                }
        }
        function saveText(v) {
                if (savedValue == 'Empty') {
                        setText(v);
                }
                window.onbeforeunload = checkChanged;
        }
        function setText(v) {
                savedValue = v;
        }

        //--&gt;</xsl:text>
        </script>

                <h1>Editing <xsl:if test="ow:page/@revision">revision <xsl:value-of select="ow:page/@revision"/> of </xsl:if>
                        <xsl:value-of select="ow:page/@name"/>
                </h1>
                <hr size="1"/>
                <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpPage" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpPage&amp;a=print'); return false;">Help</a>
                <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpPage" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpPage&amp;a=print'); return false;">
                        <img src="ow/images/popup.gif" width="15" height="9" border="0" alt=""/>
                </a>
                <xsl:value-of select="$separatorcharacter"/>
                <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpOnFormatting" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpOnFormatting&amp;a=print'); return false;">Help On Formatting</a>
                <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpOnFormatting" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpOnFormatting&amp;a=print'); return false;">
                        <img src="ow/images/popup.gif" width="15" height="9" border="0" alt=""/>
                </a>
                <xsl:value-of select="$separatorcharacter"/>
                <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpOnEditing" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpOnEditing&amp;a=print'); return false;">Help On Editing</a>
                <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpOnEditing" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpOnEditing&amp;a=print'); return false;">
                        <img src="ow/images/popup.gif" width="15" height="9" border="0" alt=""/>
                </a>
                <xsl:value-of select="$separatorcharacter"/>
                <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpOnEmoticons" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpOnEmoticons&amp;a=print'); return false;">Help On Emoticons</a>
                <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpOnEmoticons" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpOnEmoticons&amp;a=print'); return false;">
                        <img src="ow/images/popup.gif" width="15" height="9" border="0" alt=""/>
                </a>
                <br/>
                <br/>
                <xsl:if test="ow:page/@revision">
                        <b>Editing old revision <xsl:value-of select="ow:page/@revision"/>. Saving this page will replace the latest revision with this text.</b>
                </xsl:if>
                <xsl:apply-templates select="ow:error"/>
                                <xsl:if test="ow:textedits">
                                        <p>
                                                The text you edited is shown below.
                                                The text in the textarea box shows the latest version of this page.
                                        </p>
                                        <hr size="1"/>
                                        <pre>
                                                <xsl:value-of select="ow:textedits"/>
                                        </pre>
                                        <hr size="1"/>
                                </xsl:if>

                <form name="frmEdit" method="post" onsubmit="setText(theTextAreaValue()); return true;">
                                        <xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?a=edit#preview</xsl:attribute>
<!-- Save button 1 -->
                    <input type="submit" name="save" value="Save"/>
                                        &#160;
<!-- Preview button 1 -->
                                        <input type="button" name="prev1" value="Preview" onclick="javascript:preview();"/>
                                        &#160;
<!-- Cancel button 1 -->
                                        <input type="button" name="cancel" value="Cancel" onClick="javascript:window.location='{/ow:wiki/ow:scriptname}?p={$name}';"/>
<!-- Deprecate checkbox -->
                                        &#160;
                                        <input type="checkbox" name="deprecate" value="0"/> Deprecate this Page
<!-- Categories dropdown list -->
                    <xsl:call-template name="categorydropdown"/>
                    <br/>
<!-- Precis input text -->
                                        <xsl:call-template name="summaryeditdisplay" />
<!-- WYSIWYG toolbar -->
                                        <xsl:if test="ow:page/@wysiwyg='1'">
                                                        <xsl:call-template name="ow:wysiwyg"/>
                                        </xsl:if>
<!-- Text editing window -->
                                        <textarea id="text" name="text" wrap="virtual" onfocus="saveText(this.value)" onkeydown="CheckTab(this);saveDocumentCheck(event);" ondblclick="event.cancelBubble=true;">
                                                        <xsl:attribute name="rows"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:rows"/></xsl:attribute>
                                                        <xsl:attribute name="cols"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:cols"/></xsl:attribute>
                                                        <xsl:attribute name="style">font-family: monospace</xsl:attribute>
                                                        <xsl:value-of select="ow:page/ow:raw/text()"/>
                                        </textarea>
                                        <br/>
<!-- Include in Recent Changes checkbox -->
                                        <input type="checkbox" name="rc" value="1">
                                                        <xsl:if test="ow:page/ow:change/@minor='false' and not(starts-with(ow:page/ow:raw/text(), '#MINOREDIT'))">
                                                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                                        </xsl:if>
                                        </input>
                                        Include page in
                                        <a href="{/ow:wiki/ow:scriptname}?p=RecentChanges" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=RecentChanges&amp;a=print'); return false;">Recent Changes</a>
                                        <a href="{/ow:wiki/ow:scriptname}?p=RecentChanges" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=RecentChanges&amp;a=print'); return false;">
                                        <img src="ow/images/popup.gif" width="15" height="9" border="0" alt=""/>
                                        </a>
                                        list.
<!-- Comment text -->
                                        <br/>Optional comment about this change:
                                        <br/>
                                        <input type="text" name="comment" style="color:#333333;" maxlength="1000">
                                                        <xsl:attribute name="size"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:cols"/></xsl:attribute>
                                                        <xsl:attribute name="value"><xsl:value-of select="ow:page/ow:change/ow:comment/text()"/></xsl:attribute>
                                                        <xsl:attribute name="style">font-family: monospace</xsl:attribute>
                                        </input>
                                        <br/>
                                        <input type="hidden" name="revision" value="{ow:page/@revision}"/>
                                        <input type="hidden" name="newrev" value="{ow:page/ow:change/@revision}"/>
                                        <input type="hidden" name="p" value="{$name}"/>
<!-- Save button 2 -->
                                        <input type="submit" name="save" value="Save"/>
                                        &#160;
<!-- Preview button 2 -->
                                        <input type="button" name="prev2" value="Preview" onclick="javascript:preview();"/>
                                        &#160;
<!-- Cancel button 2 -->
                                        <input type="button" name="cancel" value="Cancel" onClick="javascript:window.location='{/ow:wiki/ow:scriptname}?p={$name}';"/>
                </form>

                <xsl:if test="ow:page/ow:body">
                        <!-- this shows the preview, pre 0.74 versions -->
                        <a name="preview"/>
                        <hr size="1"/>
                        <h1>Preview</h1>
                        <hr size="1"/>
                        <xsl:apply-templates select="ow:page/ow:body"/>
                        <hr size="1"/>
                        <!-- end preview -->
                </xsl:if>
        </xsl:template>
        <!-- #################################-->
    <!-- Match BOOKMARKS and call to external template bookmarks on bookmarks.xsl -->
  <xsl:template match="ow:bookmarks">
    <xsl:call-template name="bookmarks"/>
  </xsl:template>
  <!-- ________________________________________________________________________ -->

	<!-- ## Shows when UserPreferences 'trail on top' is selected ## -->
        <xsl:template match="ow:trail">
                <xsl:if test="count(ow:link) &gt; 1 and ../ow:userpreferences/ow:trailontop">
                        <small>
                                <xsl:for-each select="ow:link">
                                        <xsl:choose>
                                                <xsl:when test="../../ow:page/ow:link/@href=@href">
                                                        <xsl:choose>
                                                                <xsl:when test="$trailcharacter">
                                                                        <xsl:value-of select="$trailcharacter"/>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                        <xsl:text> &#187; </xsl:text>
                                                                </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:call-template name="cleanslash">
                                                                <xsl:with-param name="runmode" select="string($trail_cleanslash)"/>
                                                                <xsl:with-param name="thetext" select="string(text())"/>
                                                        </xsl:call-template>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                        <xsl:choose>
                                                                <xsl:when test="$trailcharacter">
                                                                        <xsl:value-of select="$trailcharacter"/>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                        <xsl:text> &#187; </xsl:text>
                                                                </xsl:otherwise>
                                                        </xsl:choose>
                                                        <a class="trail" href="{@href}">
                                                                <xsl:call-template name="cleanslash">
                                                                        <xsl:with-param name="runmode" select="string($trail_cleanslash)"/>
                                                                        <xsl:with-param name="thetext" select="string(text())"/>
                                                                </xsl:call-template>
                                                        </a>
                                                </xsl:otherwise>
                                        </xsl:choose>
                                </xsl:for-each>
                        </small>
                        <hr noshade="noshade" size="1"/>
                </xsl:if>
        </xsl:template>
        <!-- ## Shows when a page is unknown and 1 or more templates exist -->
        <xsl:template match="ow:templates">
                <p/>
                <br/>
                <br/>
    Alternatively, create this page using one of these templates:
    <ul>
                        <xsl:apply-templates select="ow:page"/>
                </ul>
    To create your own template add a page with a name ending in Template.
</xsl:template>
        <xsl:template match="ow:templates/ow:page">
                <li>
                        <a>
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit&amp;template=<xsl:value-of select="ow:urlencode(string(@name))"/></xsl:attribute>
                                <xsl:value-of select="ow:link/text()"/>
                        </a>
      &#160;
      (<a target="_blank">
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?<xsl:value-of select="ow:urlencode(string(@name))"/></xsl:attribute>view template</a>
                        <a target="_blank">
                                <xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?<xsl:value-of select="ow:urlencode(string(@name))"/></xsl:attribute>
                                <img src="ow/images/popup.gif" width="15" height="9" border="0" alt=""/>
                        </a>)
    </li>
        </xsl:template>
        <!-- ## Header of every page ## -->
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
                        <link rel="stylesheet" type="text/css" href="{/ow:wiki/ow:skinpath}/ow.css"/>
                        <link rel="stylesheet" type="text/css" href="{/ow:wiki/ow:skinpath}/wysiwyg.css"/>
                </head>
        </xsl:template>

        <xsl:template name="brandingImage">
                <xsl:if test="$showlogo='yes'">
                        <a href="{/ow:wiki/ow:frontpage/@href}">
                                <img src="{/ow:wiki/ow:imagepath}/logo.gif" align="right" border="0" alt="OpenWiki"/>
                        </a>
                </xsl:if>
        </xsl:template>

        <xsl:template name="poweredBy">
                <xsl:if test="$showpoweredby='yes'">
                        <a href="{//ow:openwiking_url}">
                                <img src="{/ow:wiki/ow:imagepath}/poweredby.gif" width="88" height="31" border="0" alt=""/>
                        </a>
                </xsl:if>
        </xsl:template>
</xsl:stylesheet>