<?xml version="1.0" encoding="utf-8"?>
<!--
### Evolution skin ###

$Log: ow.xsl,v $
Revision 1.7  2007/02/02 00:48:03  piixiiees
Bug FIXED: included pages gives an extra TAGS list (but only tags from the current page). The tags (link) is not showed from included pages.
evolution skin upgraded with tags feature

Revision 1.6  2006/08/15 14:53:46  piixiiees
Transform OpenWikiNG to UTF-8 enconding:
1. ow/owconfig_default.asp
OPENWIKI_ENCODING = "UTF-8"
Unicode (UTF-8 with signature) - Codepage 65001
2. ow.asp and default.asp
Unicode (UTF-8 with signature) - Codepage 65001
3. (Pending) owadmin/deprecate.asp.htm
Unicode (UTF-8 with signature) - Codepage 65001
4. ow/plugins/owplugin_WYSIWYG.xsl
<?xml version="1.0" encoding="UTF-8"?>
5. ow/skins/default/ow.xsl ToDo? with all the skins
<?xml version="1.0" encoding="UTF-8"?>
Bug of broken symbols in preview windows fixed: sourceforge.net bug 1362452

Revision 1.5  2006/04/20 01:00:25  piixiiees
Temporary copy of skins/common/*.* to evolution skin to be able to modify the structure of the skin without impacting to other skins.
New style of BrogressBar; now printable.
New file macros.xsl to include the templates for the macros.

Revision 1.4  2006/03/22 01:46:47  piixiiees
- Small bugfix with the command Edit (link on top) when editing old revisions. Remove of blanks in the URL. Skins affected plastic and evolution.
- Extract the editing layout from the ow.xsl to a dedicated file editor.xsl

Revision 1.3  2006/03/22 01:03:40  piixiiees
Small bugfix with the command Edit (link on top) when editing old revisions. Remove of blanks in the URL. Skins affected plastic and evolution.


-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <xsl:include href="common/lang-en.xsl"/>
  <xsl:include href="skinconfig.xsl"/>
  <xsl:include href="common/owconfig.xsl"/>
  <xsl:include href="common/ow_common.xsl"/>
  <xsl:include href="common/owinc.xsl"/>
  <xsl:include href="common/summaries.xsl"/>
  <xsl:include href="common/categories.xsl"/>
  <xsl:include href="common/google_adsense.xsl"/>
  <xsl:include href="common/owplugins.xsl"/>
  <xsl:include href="owattach.xsl"/>
  <xsl:include href="common/editor.xsl"/>
  <xsl:include href="common/tag.xsl"/>

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
      <!-- #SUMMARY START#-->
      <xsl:when test="@mode='summarysearch'">
              <xsl:apply-templates select="." mode="summarysearch"/>
      </xsl:when>
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
      <!-- #SERIALISE MODE -->
      <xsl:when test="@mode='serialise'">
        <xsl:apply-templates select="." mode="serialise"/>
      </xsl:when>    
      <!-- #TAGS MODE -->
      <xsl:when test="@mode='tagsearch'">
        <xsl:apply-templates select="." mode="tagsearch"/>
      </xsl:when>
      <xsl:when test="@mode='tagsindex'">
        <xsl:apply-templates select="." mode="tagsindex"/>
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
                                <a class="same" href="{ow:scriptname}?a=fullsearch&amp;txt={$shortname}&amp;fromtitle=true" title="Do a full text search for {$shortname}">
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
                                <!-- lang009:Edit --> <!-- lang010:this page -->
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
                <xsl:if test="@revision">
                  <!-- lang002:Showing revision -->
                  <b><xsl:value-of select="$lang_002"/> <xsl:value-of select="@revision"/><br/><br/></b>
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
              <a href="{ow:scriptname}?p={$name}&amp;highlight={$hiterm}&amp;hido=1&amp;hiterm={$hiterm}"><xsl:value-of select="$hiterm"/></a>
            </strong>
          </small>
        </p>
    </xsl:if>
    <xsl:if test="$hido = 1">
        <p>
          <small>
            <strong><!-- lang026:HIGHLIGHT OFF -->
              <a href="{ow:scriptname}?p={$name}&amp;hido=0&amp;hiterm={$hiterm}"><xsl:value-of select="$lang_026"/></a>
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
  <!-- #tag DISPLAY START added by 1mmm# -->
  <xsl:call-template name="tag_show"/>
  <!-- #tag PAGE DISPLAY END# -->
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

  <!-- ~~~~~~ Call to external template editor on editor.xsl ~~~~~~ -->
  <xsl:template match="/ow:wiki" mode="edit"><!-- #EDIT MODE -->
    <xsl:call-template name="editor"/>
  </xsl:template>
  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

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
                        <link rel="stylesheet" type="text/css" href="{/ow:wiki/ow:skinpath}/thumbs.css"/>
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