<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
** DEFAULT_LEFT SKIN **
$Log: ow.xsl,v $
Revision 1.25  2007/01/30 19:33:41  sansei
Implemented TAGS, TagCloud into the skin

Revision 1.24  2007/01/30 15:33:06  sansei
Added TAGS functionality to this skin (general functionality needs tweaking for optimal implementation in all skins)

Revision 1.23  2006/02/20 20:31:25  piixiiees
Include the language file in default_css and default_left skins:
<xsl:include href="../common/lang-en.xsl"/>

Revision 1.22  2005/03/03 12:57:43  sansei
Added 'FlashLogo' - If AllowFlash then the page logo is displayed with a flash file (pt. default, default_left only) - You can disable any use of FlashLogo in myskin.xsl

Revision 1.21  2005/03/01 06:08:39  sansei
added OPTIONAL new syntax for PageBookmarks
If a * (star) is present in the macro data then use multible pagebookmarks syntax, if NOT then use single syntax.

Revision 1.20  2005/02/23 20:29:12  sansei
forgot to remove some redundant code in last update

Revision 1.19  2005/02/23 05:02:33  sansei
fixed bookmark issues bug when attaching files mode

Revision 1.18  2005/01/21 20:35:00  sansei
Fixed skin default_left: fullsearch result not truncating MAIN bookmarks
Fixed skin default_left: not showing pagebookmarks bold
TextSearch can now use truncate syntax (see other truncate demo)
SummarySearch can now use truncate syntax (see other truncate demo)

Revision 1.17  2004/11/03 10:35:52  gbamber
BugFix: TextSearch

Revision 1.16  2004/11/01 12:18:19  gbamber
NEW: Admin function 'Nuke deprecated pages older than:'

Revision 1.15  2004/10/30 20:48:37  gbamber
1 ) You can use <xsl:value-of select="$adminpassword"/> as a parameter for a form
2 ) To test for a Wikiadmin: <xsl:if test="/ow:wiki/ow:userip='local' and /ow:wiki/ow:usertype='admin'">

Revision 1.14  2004/10/30 13:12:27  gbamber
Bold Bug Fixed

Revision 1.13  2004/10/21 21:44:29  gbamber
Moved rename template to ow_common.xsl

Revision 1.12  2004/10/19 12:41:20  gbamber
Massive serialising update.

Revision 1.11  2004/10/13 12:22:16  gbamber
Forced updates to make sure CVS reflects current work

Revision 1.10  2004/10/13 11:11:42  gbamber
Updated Summaries in default and default_left

Revision 1.9  2004/10/01 13:09:30  sansei
Added constant "cFullsearchHighlight" in config_default as user setting for allowing the Fullsearch-highlight. (other documents involved too!)

Revision 1.8  2004/09/29 21:58:12  sansei
Improved Fullsearch-Highlight

Revision 1.7  2004/09/27 22:52:00  gbamber
BugFix: categorysearch mode was missing

Revision 1.6  2004/09/26 00:03:27  gbamber
Updated Categories and GoogleAds in default_left and default skins

Revision 1.5  2004/09/25 09:23:27  gbamber
Added Category display and edit dropdown

Revision 1.4  2004/09/25 04:09:47  sansei
Fixed some (not all) small bugs

Revision 1.3  2004/09/25 02:05:19  sansei
Added a vertical line in the layout

Revision 1.2  2004/09/24 19:01:40  sansei
Fixed cleanslashbug

Revision 1.1  2004/09/23 17:19:05  sansei
New skin based on skin: default (bookmarks left layout!)

Based on skin: default - sEi'2004

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
	<xsl:include href="../common/lang-en.xsl"/>
	<xsl:include href="../common/owconfig.xsl"/>
	<xsl:include href="skinconfig.xsl"/>
	<xsl:include href="../common/ow_common.xsl"/>
	<xsl:include href="../common/owinc.xsl"/>
	<xsl:include href="../common/categories.xsl"/>
	<xsl:include href="../common/summaries.xsl"/>
	<xsl:include href="../common/google_adsense.xsl"/>
	<xsl:include href="../common/owplugins.xsl"/>
	<xsl:include href="../common/tag.xsl"/>
	<xsl:include href="owattach.xsl"/>
	<xsl:include href="mystyle.xsl"/>
	<xsl:variable name="nbsp">&amp;nbsp;</xsl:variable>
	<xsl:template match="/ow:wiki">
		<xsl:call-template name="pi"/>
		<html>
			<xsl:call-template name="head"/>
			<body onload="window.defaultStatus='{$brandingText}'">
				<table border="{$Showborders}" class="regions">
					<tr valign="top">
						<td class="regionheader" valign="top">
							<xsl:call-template name="regionheader"/>
						</td>
					</tr>
					<tr valign="top">
						<td valign="top">
							<table valign="top" border="{$Showborders}" class="regionmiddle">
								<tr valign="top">
									<td class="regionleft" valign="top">
										<xsl:call-template name="regionleft"/>
									</td>
									<td class="regioncenter" valign="top">
										<xsl:call-template name="regioncenter"/>
									</td>
									<td class="regionright" valign="top">
										<xsl:call-template name="regionright"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr valign="top">
						<td class="regionfooter" valign="top">
							<xsl:call-template name="regionfooter"/>
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="regionheader">
		<xsl:call-template name="google_Top"/>
	</xsl:template>
	<xsl:template name="regionfooter">

        </xsl:template>
	<xsl:template name="regionleft">

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
			<xsl:when test="@mode='categorysearch'">
				<xsl:apply-templates select="." mode="categorysearch"/>
			</xsl:when>
			<!-- #SUMMARY START#-->
			<xsl:when test="@mode='summarysearch'">
				<xsl:apply-templates select="." mode="summarysearch"/>
			</xsl:when>
			<!-- #SUMMARY END#-->
			<xsl:when test="@mode='fullsearch'">
				<xsl:apply-templates select="." mode="fullsearch"/>
			</xsl:when>
			<xsl:when test="@mode='textsearch'">
				<xsl:apply-templates select="." mode="textsearch"/>
			</xsl:when>
			<xsl:when test="@mode='login'">
				<xsl:apply-templates select="." mode="login"/>
			</xsl:when>
			<xsl:when test="@mode='attach'">
				<xsl:call-template name="attachpage"/>
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
	<!-- ## SERIALISE MODE ## -->
	<xsl:template match="/ow:wiki" mode="serialise">
		<xsl:apply-templates select="ow:page"/>
	</xsl:template>
	<xsl:template match="/ow:wiki" mode="view">
		<xsl:attribute name="ondblclick">location.href='<xsl:value-of select="ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="ow:page/@revision">&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if>'</xsl:attribute>
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
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr valign="top">
				<td valign="top">
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
				</td>
				<td valign="top" align="right">
					<xsl:call-template name="brandingImage"/>
				</td>
			</tr>
		</table>
		<xsl:apply-templates select="ow:page"/>
	</xsl:template>
	<xsl:template match="/ow:wiki" mode="print">
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
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr valign="top">
				<td valign="top">
					<xsl:if test="(contains(ow:page/ow:link/text(), '/')) and ($title_cleanslash &gt; 0)">
						<xsl:value-of select="ow:page/ow:link/text()"/>
					</xsl:if>
					<h1>
						<xsl:value-of select="$shorttitle"/>
					</h1>
				</td>
				<td valign="top" align="right">
					<xsl:call-template name="brandingImage"/>
				</td>
			</tr>
		</table>
		<hr noshade="noshade" size="1"/>
		<xsl:if test="//ow:redirectedfrom">
			<p>
				<b>Redirected from: <xsl:value-of select="//ow:redirectedfrom/text()"/>
				</b>
			</p>
		</xsl:if>
		<xsl:if test="@revision">
			<b>Showing revision <xsl:value-of select="@revision"/>
			</b>
		</xsl:if>
		<xsl:apply-templates select="//ow:body"/>
		<hr noshade="noshade" size="1"/>
		<table cellspacing="0" cellpadding="0" border="{$Showborders}" width="100%">
			<tr>
				<td align="left" class="n">
					<xsl:if test="/ow:wiki/ow:allowattachments">Attachments (<xsl:value-of select="count(//ow:attachments/ow:attachment[@deprecated='false'])"/>)
            </xsl:if>
					<xsl:if test="//@hits">
                                | Page views: <b>
							<xsl:value-of select="//@hits"/>
						</b>
					</xsl:if>
					<xsl:if test="not(//@changes='0')"> | Page Revisions: <b>
							<xsl:value-of select="//@changes"/>
						</b>| Last Edited: <xsl:value-of select="ow:formatLongDate(string(//ow:change/ow:date))"/>
						<xsl:text> </xsl:text>
						<xsl:if test="//ow:change/ow:by/@alias"> by <xsl:value-of select="//ow:change/ow:by/@alias"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<br/>
					</xsl:if>
					<p>
						<a class="functions">
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>
							<strong>Exit print view</strong>
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
	<!-- #################################-->
	<xsl:template match="ow:page">
		<xsl:apply-templates select="../ow:trail"/>
		<hr noshade="noshade" size="1"/>
		<table border="{$Showborders}" width="100%">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<!-- START CATEGORY DISPLAY -->
						<tr>
							<td valign="top" height="20" colspan="2">
								<strong>
									<xsl:call-template name="categorydisplay"/>
									<xsl:text> </xsl:text>
								</strong>
							</td>
						</tr>
						<!-- END CATEGORY DISPLAY -->
						<tr>
							<td valign="top" height="18" colspan="2" class="bookmarks">
								<xsl:call-template name="mainmenu_title"/>
							</td>
						</tr>
						<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:bookmarks/ow:link">
							<tr>
								<td valign="top" height="18" width="16">
									<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
								</td>
								<td nowrap="nowrap" valign="top" height="18" width="100%">
									<a class="bookmarks" href="{@href}">
										<xsl:call-template name="cleanslash">
											<xsl:with-param name="runmode" select="string($bookmark_cleanslash)"/>
											<xsl:with-param name="thetext" select="string(text())"/>
										</xsl:call-template>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
					<xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
						<br/>
						<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td nowrap="nowrap" valign="top" height="18" colspan="2">
									<strong>
										<xsl:choose>
											<xsl:when test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading">
												<xsl:value-of select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading"/>
												<xsl:text>:</xsl:text>
											</xsl:when>
											<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</strong>
								</td>
							</tr>
							<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
								<xsl:choose>
									<xsl:when test="@name='----'">
										<tr>
											<td valign="top" height="18" width="16"/>
											<td valign="top" height="18" width="100%"/>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td valign="top" height="18" width="16">
												<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
											</td>
											<td nowrap="nowrap" valign="top" height="18" width="100%">
												<b>
													<a href="{@href}">
														<xsl:call-template name="cleanslash">
															<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
															<xsl:with-param name="thetext" select="string(text())"/>
														</xsl:call-template>
													</a>
												</b>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</table>
					</xsl:if>
					<xsl:if test="/ow:wiki/ow:pagebookmarks/pagebookmarks">
						<xsl:for-each select="/ow:wiki/ow:pagebookmarks/pagebookmarks">
							<br/>
							<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td nowrap="nowrap" valign="top" height="18" colspan="2">
										<strong>
											<xsl:choose>
												<xsl:when test="@heading">
													<xsl:value-of select="@heading"/>
													<xsl:text>:</xsl:text>
												</xsl:when>
												<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</strong>
									</td>
								</tr>
								<xsl:for-each select="ow:link">
									<xsl:choose>
										<xsl:when test="@name='----'">
											<tr>
												<td valign="top" height="18" width="16"/>
												<td valign="top" height="18" width="100%"/>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td valign="top" height="18" width="16">
													<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
												</td>
												<td nowrap="nowrap" valign="top" height="18" width="100%">
													<b>
														<a href="{@href}">
															<xsl:call-template name="cleanslash">
																<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
																<xsl:with-param name="thetext" select="string(text())"/>
															</xsl:call-template>
														</a>
													</b>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</table>
						</xsl:for-each>
					</xsl:if>
				</td>
				<td width="6" background="{/ow:wiki/ow:skinpath}/images/vertical_line.gif">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td valign="top" width="100%">
					<xsl:if test="../ow:redirectedfrom">
						<b>Redirected from <a title="Edit this page">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?a=edit&amp;p=<xsl:value-of select="ow:urlencode(string(../ow:redirectedfrom/@name))"/></xsl:attribute>
								<xsl:value-of select="../ow:redirectedfrom/text()"/>
							</a>
						</b>
						<p/>
					</xsl:if>
					<xsl:if test="@revision">
						<b>Showing revision <xsl:value-of select="@revision"/>
						</b>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="contains($name, '/')">
							<a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:page/ow:wiki/ow:scriptname"/>?p=<xsl:call-template name="TrimLastWordPart"><xsl:with-param name="WikiWordPart" select="$name"/></xsl:call-template></xsl:attribute>
                                Up a level
                        </a> |
                </xsl:when>
						<xsl:otherwise>
            </xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates select="ow:body"/>
				</td>
			</tr>
		</table>
		<hr noshade="noshade" size="1"/>
		<table cellspacing="0" cellpadding="0" border="{$Showborders}" width="100%">
			<xsl:if test="not(/ow:wiki/ow:userpreferences/ow:bookmarks='None')">
				<tr>
					<td align="left" class="n">
						<a class="functions">
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="@revision">&amp;revision=<xsl:value-of select="@revision"/></xsl:if></xsl:attribute>Edit <xsl:if test="@revision">revision <xsl:value-of select="@revision"/> of</xsl:if> this page</a>
						<!-- Added for rename capability -->
                | <a class="functions">
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=rename&amp;step=first</xsl:attribute>Rename this page</a>
						<xsl:if test="@revision or (ow:change and not(ow:change/@revision = 1))">
                |
                <a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute>View other revisions</a>
						</xsl:if>
						<xsl:if test="@revision">
                |
                <a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>View current revision</a>
						</xsl:if>
						<xsl:if test="/ow:wiki/ow:allowattachments">
                |
                <a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=attach</xsl:attribute>Attachments</a> (<xsl:value-of select="count(ow:attachments/ow:attachment[@deprecated='false'])"/>)
            </xsl:if>
                |
                <a class="functions">
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:change/@revision"/></xsl:attribute>Print this page</a>
                                |
            <a class="functions">
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=xml&amp;revision=<xsl:value-of select="ow:change/@revision"/></xsl:attribute>View XML</a>
						<!-- START HITS CODE -->
						<xsl:if test="@hits">
                                | Page views: <b>
								<xsl:value-of select="@hits"/>
							</b>
						</xsl:if>
						<!-- END HITS CODE -->
						<br/>
						<a class="functions">
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=FindPage&amp;txt=<xsl:value-of select="$name"/></xsl:attribute>Find page</a> by browsing, searching or an index
                                        <xsl:if test="not(@changes='0')">
                                        | Page Revisions: <b>
								<xsl:value-of select="@changes"/>
							</b>
							<br/>
                                        Last Edited <xsl:value-of select="ow:formatLongDate(string(ow:change/ow:date))"/>
							<xsl:text> </xsl:text>
							<xsl:if test="ow:change/ow:by/@alias">
                                                by <xsl:value-of select="ow:change/ow:by/@alias"/>
								<xsl:text> </xsl:text>
							</xsl:if>
							<a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/><xsl:if test="ow:change/@revision">&amp;difffrom=<xsl:value-of select="ow:change/@revision - 1"/></xsl:if>&amp;a=diff</xsl:attribute>(diff)</a>
							<br/>
						</xsl:if>
						<xsl:if test="/ow:wiki/ow:userip='local' and /ow:wiki/ow:usertype='admin'">
							<xsl:call-template name="adminfunctions"/>
						</xsl:if>
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
	<xsl:template match="ow:body">
		<xsl:if test=".='' and not(/ow:wiki/@mode='embedded')">
			<br/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit</xsl:attribute>Describe <xsl:value-of select="../ow:link/text()"/> here</a>
			<xsl:apply-templates select="../../ow:templates"/>
		</xsl:if>
		<xsl:if test="starts-with(text(), '#DEPRECATED')">
			<font color="#ff0000">
				<b>This page will be permanently destroyed.</b>
			</font>
			<p/>
		</xsl:if>
		<xsl:if test='$FullsearchHighlight = "1"'>
			<xsl:if test="$hido = 0">
				<p>
					<small>
						<xsl:text>HIGHLIGHT: </xsl:text>
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
						<strong>
							<a href="{ow:scriptname}?p={$name}&amp;hido=0&amp;hiterm={$hiterm}">
								<xsl:text>HIGHLIGHT OFF</xsl:text>
							</a>
						</strong>
					</small>
				</p>
			</xsl:if>
		</xsl:if>
		<xsl:apply-templates select="text() | *"/>
		<!-- #SUMMARY PAGE DISPLAY START# -->
		<xsl:call-template name="summarypagedisplay"/>
		<!-- #SUMMARY PAGE DISPLAY END# -->
		<xsl:apply-templates select="../ow:attachments">
			<xsl:with-param name="showhidden">false</xsl:with-param>
			<xsl:with-param name="showactions">false</xsl:with-param>
		</xsl:apply-templates>
		<xsl:call-template name="tag_show"/>
	</xsl:template>
	<!-- #################################-->
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
	<xsl:template match="/ow:wiki" mode="diff">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr valign="top">
				<td valign="top">
					<h1>
						<a class="same" href="{ow:scriptname}?a=fullsearch&amp;txt={$name}&amp;fromtitle=true" title="Do a full text search for {ow:page/ow:link/text()}">
							<xsl:value-of select="ow:page/ow:link/text()"/>
						</a>
					</h1>
				</td>
				<td valign="top" align="right">
					<xsl:call-template name="brandingImage"/>
				</td>
			</tr>
		</table>
		<xsl:apply-templates select="//ow:trail"/>
		<hr noshade="noshade" size="1"/>
		<table border="{$Showborders}" width="100%">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top" height="18" colspan="2">
								<strong>Menu:</strong>
							</td>
						</tr>
						<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:bookmarks/ow:link">
							<tr>
								<td valign="top" height="18" width="16">
									<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
								</td>
								<td nowrap="nowrap" valign="top" height="18" width="100%">
									<a href="{@href}">
										<xsl:value-of select="text()"/>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
					<xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
						<br/>
						<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td nowrap="nowrap" valign="top" height="18" colspan="2">
									<strong>
										<xsl:choose>
											<xsl:when test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading">
												<xsl:value-of select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading"/>
												<xsl:text>:</xsl:text>
											</xsl:when>
											<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</strong>
								</td>
							</tr>
							<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
								<xsl:choose>
									<xsl:when test="@name='----'">
										<tr>
											<td valign="top" height="18" width="16"/>
											<td valign="top" height="18" width="100%"/>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td valign="top" height="18" width="16">
												<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
											</td>
											<td nowrap="nowrap" valign="top" height="18" width="100%">
												<b>
													<a href="{@href}">
														<xsl:call-template name="cleanslash">
															<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
															<xsl:with-param name="thetext" select="string(text())"/>
														</xsl:call-template>
													</a>
												</b>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</table>
					</xsl:if>
					<xsl:if test="/ow:wiki/ow:pagebookmarks/pagebookmarks">
						<xsl:for-each select="/ow:wiki/ow:pagebookmarks/pagebookmarks">
							<br/>
							<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td nowrap="nowrap" valign="top" height="18" colspan="2">
										<strong>
											<xsl:choose>
												<xsl:when test="@heading">
													<xsl:value-of select="@heading"/>
													<xsl:text>:</xsl:text>
												</xsl:when>
												<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</strong>
									</td>
								</tr>
								<xsl:for-each select="ow:link">
									<xsl:choose>
										<xsl:when test="@name='----'">
											<tr>
												<td valign="top" height="18" width="16"/>
												<td valign="top" height="18" width="100%"/>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td valign="top" height="18" width="16">
													<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
												</td>
												<td nowrap="nowrap" valign="top" height="18" width="100%">
													<b>
														<a href="{@href}">
															<xsl:call-template name="cleanslash">
																<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
																<xsl:with-param name="thetext" select="string(text())"/>
															</xsl:call-template>
														</a>
													</b>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</table>
						</xsl:for-each>
					</xsl:if>
				</td>
				<td background="{/ow:wiki/ow:skinpath}/images/vertical_line.gif" width="6">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td valign="top" width="100%">
					<xsl:if test="../ow:redirectedfrom">
						<b>Redirected from <a title="Edit this page">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?a=edit&amp;p=<xsl:value-of select="ow:urlencode(string(../ow:redirectedfrom/@name))"/></xsl:attribute>
								<xsl:value-of select="../ow:redirectedfrom/text()"/>
							</a>
						</b>
						<p/>
					</xsl:if>
					<xsl:if test="@revision">
						<b>Showing revision <xsl:value-of select="@revision"/>
						</b>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="contains($name, '/')">
							<a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:page/ow:wiki/ow:scriptname"/>?p=<xsl:call-template name="TrimLastWordPart"><xsl:with-param name="WikiWordPart" select="$name"/></xsl:call-template></xsl:attribute>
                                Up a level
                        </a> |
                </xsl:when>
						<xsl:otherwise>
            </xsl:otherwise>
					</xsl:choose>
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
				</td>
			</tr>
		</table>
		<form name="f" method="get">
			<xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
			<hr noshade="noshade" size="1"/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="ow:page/@revision">&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if></xsl:attribute>Edit <xsl:if test="ow:page/@revision">revision <xsl:value-of select="ow:page/@revision"/> of</xsl:if> this page</a>
			<xsl:if test="ow:page/@revision or (ow:page/ow:change and not(ow:page/ow:change/@revision = 1))">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute>View other revisions</a>
			</xsl:if>
			<xsl:if test="ow:page/@revision">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>View current revision</a>
			</xsl:if>
			<br/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:page/ow:change/@revision"/></xsl:attribute>Print this page</a>
    |
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
	<xsl:template match="ow:wiki" mode="changes">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr valign="top">
				<td valign="top">
					<h1>History of "<xsl:value-of select="ow:page/ow:link/text()"/>"</h1>
				</td>
				<td valign="top" align="right">
					<xsl:call-template name="brandingImage"/>
				</td>
			</tr>
		</table>
		<xsl:apply-templates select="//ow:trail"/>
		<hr noshade="noshade" size="1"/>
		<table border="{$Showborders}" width="100%">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top" height="18" colspan="2">
								<strong>Menu:</strong>
							</td>
						</tr>
						<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:bookmarks/ow:link">
							<tr>
								<td valign="top" height="18" width="16">
									<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
								</td>
								<td nowrap="nowrap" valign="top" height="18" width="100%">
									<a href="{@href}">
										<xsl:value-of select="text()"/>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
					<xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
						<br/>
						<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td nowrap="nowrap" valign="top" height="18" colspan="2">
									<strong>
										<xsl:choose>
											<xsl:when test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading">
												<xsl:value-of select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading"/>
												<xsl:text>:</xsl:text>
											</xsl:when>
											<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</strong>
								</td>
							</tr>
							<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
								<xsl:choose>
									<xsl:when test="@name='----'">
										<tr>
											<td valign="top" height="18" width="16"/>
											<td valign="top" height="18" width="100%"/>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td valign="top" height="18" width="16">
												<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
											</td>
											<td nowrap="nowrap" valign="top" height="18" width="100%">
												<b>
													<a href="{@href}">
														<xsl:call-template name="cleanslash">
															<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
															<xsl:with-param name="thetext" select="string(text())"/>
														</xsl:call-template>
													</a>
												</b>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</table>
					</xsl:if>
					<xsl:if test="/ow:wiki/ow:pagebookmarks/pagebookmarks">
						<xsl:for-each select="/ow:wiki/ow:pagebookmarks/pagebookmarks">
							<br/>
							<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td nowrap="nowrap" valign="top" height="18" colspan="2">
										<strong>
											<xsl:choose>
												<xsl:when test="@heading">
													<xsl:value-of select="@heading"/>
													<xsl:text>:</xsl:text>
												</xsl:when>
												<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</strong>
									</td>
								</tr>
								<xsl:for-each select="ow:link">
									<xsl:choose>
										<xsl:when test="@name='----'">
											<tr>
												<td valign="top" height="18" width="16"/>
												<td valign="top" height="18" width="100%"/>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td valign="top" height="18" width="16">
													<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
												</td>
												<td nowrap="nowrap" valign="top" height="18" width="100%">
													<b>
														<a href="{@href}">
															<xsl:call-template name="cleanslash">
																<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
																<xsl:with-param name="thetext" select="string(text())"/>
															</xsl:call-template>
														</a>
													</b>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</table>
						</xsl:for-each>
					</xsl:if>
				</td>
				<td background="{/ow:wiki/ow:skinpath}/images/vertical_line.gif" width="6">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td valign="top" width="100%">
					<xsl:if test="../ow:redirectedfrom">
						<b>Redirected from <a title="Edit this page">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?a=edit&amp;p=<xsl:value-of select="ow:urlencode(string(../ow:redirectedfrom/@name))"/></xsl:attribute>
								<xsl:value-of select="../ow:redirectedfrom/text()"/>
							</a>
						</b>
						<p/>
					</xsl:if>
					<xsl:if test="@revision">
						<b>Showing revision <xsl:value-of select="@revision"/>
						</b>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="contains($name, '/')">
							<a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:page/ow:wiki/ow:scriptname"/>?p=<xsl:call-template name="TrimLastWordPart"><xsl:with-param name="WikiWordPart" select="$name"/></xsl:call-template></xsl:attribute>
                                Up a level
                        </a> |
                </xsl:when>
						<xsl:otherwise>
            </xsl:otherwise>
					</xsl:choose>
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
				</td>
			</tr>
		</table>
		<form name="f" method="get">
			<xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
			<hr noshade="noshade" size="1"/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="ow:page/@revision">&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if></xsl:attribute>Edit <xsl:if test="ow:page/@revision">revision <xsl:value-of select="ow:page/@revision"/> of</xsl:if> this page</a>
			<xsl:if test="ow:page/@revision or (ow:page/ow:change and not(ow:page/ow:change/@revision = 1))">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute>View other revisions</a>
			</xsl:if>
			<xsl:if test="ow:page/@revision">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>View current revision</a>
			</xsl:if>
			<br/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:page/ow:change/@revision"/></xsl:attribute>Print this page</a>
    |
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
	<xsl:template match="/ow:wiki" mode="titlesearch">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr valign="top">
				<td valign="top">
					<h1>Title search for "<xsl:value-of select="ow:titlesearch/@value"/>"</h1>
				</td>
				<td valign="top" align="right">
					<xsl:call-template name="brandingImage"/>
				</td>
			</tr>
		</table>
		<xsl:apply-templates select="//ow:trail"/>
		<hr noshade="noshade" size="1"/>
		<table border="{$Showborders}" width="100%">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top" height="18" colspan="2">
								<strong>Menu:</strong>
							</td>
						</tr>
						<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:bookmarks/ow:link">
							<tr>
								<td valign="top" height="18" width="16">
									<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
								</td>
								<td nowrap="nowrap" valign="top" height="18" width="100%">
									<a href="{@href}">
										<xsl:value-of select="text()"/>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
					<xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
						<br/>
						<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td nowrap="nowrap" valign="top" height="18" colspan="2">
									<strong>
										<xsl:choose>
											<xsl:when test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading">
												<xsl:value-of select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading"/>
												<xsl:text>:</xsl:text>
											</xsl:when>
											<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</strong>
								</td>
							</tr>
							<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
								<xsl:choose>
									<xsl:when test="@name='----'">
										<tr>
											<td valign="top" height="18" width="16"/>
											<td valign="top" height="18" width="100%"/>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td valign="top" height="18" width="16">
												<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
											</td>
											<td nowrap="nowrap" valign="top" height="18" width="100%">
												<b>
													<a href="{@href}">
														<xsl:call-template name="cleanslash">
															<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
															<xsl:with-param name="thetext" select="string(text())"/>
														</xsl:call-template>
													</a>
												</b>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</table>
					</xsl:if>
					<xsl:if test="/ow:wiki/ow:pagebookmarks/pagebookmarks">
						<xsl:for-each select="/ow:wiki/ow:pagebookmarks/pagebookmarks">
							<br/>
							<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td nowrap="nowrap" valign="top" height="18" colspan="2">
										<strong>
											<xsl:choose>
												<xsl:when test="@heading">
													<xsl:value-of select="@heading"/>
													<xsl:text>:</xsl:text>
												</xsl:when>
												<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</strong>
									</td>
								</tr>
								<xsl:for-each select="ow:link">
									<xsl:choose>
										<xsl:when test="@name='----'">
											<tr>
												<td valign="top" height="18" width="16"/>
												<td valign="top" height="18" width="100%"/>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td valign="top" height="18" width="16">
													<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
												</td>
												<td nowrap="nowrap" valign="top" height="18" width="100%">
													<b>
														<a href="{@href}">
															<xsl:call-template name="cleanslash">
																<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
																<xsl:with-param name="thetext" select="string(text())"/>
															</xsl:call-template>
														</a>
													</b>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</table>
						</xsl:for-each>
					</xsl:if>
				</td>
				<td background="{/ow:wiki/ow:skinpath}/images/vertical_line.gif" width="6">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td valign="top" width="100%">
					<xsl:if test="../ow:redirectedfrom">
						<b>Redirected from <a title="Edit this page">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?a=edit&amp;p=<xsl:value-of select="ow:urlencode(string(../ow:redirectedfrom/@name))"/></xsl:attribute>
								<xsl:value-of select="../ow:redirectedfrom/text()"/>
							</a>
						</b>
						<p/>
					</xsl:if>
					<xsl:if test="@revision">
						<b>Showing revision <xsl:value-of select="@revision"/>
						</b>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="contains($name, '/')">
							<a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:page/ow:wiki/ow:scriptname"/>?p=<xsl:call-template name="TrimLastWordPart"><xsl:with-param name="WikiWordPart" select="$name"/></xsl:call-template></xsl:attribute>
                                Up a level
                        </a> |
                </xsl:when>
						<xsl:otherwise>
            </xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates select="ow:titlesearch"/>
					<xsl:value-of select="count(ow:titlesearch/ow:page)"/> hits out of
    <xsl:value-of select="ow:titlesearch/@pagecount"/> pages searched.

    </td>
			</tr>
		</table>
		<form name="f" method="get">
			<xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
			<hr noshade="noshade" size="1"/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="ow:page/@revision">&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if></xsl:attribute>Edit <xsl:if test="ow:page/@revision">revision <xsl:value-of select="ow:page/@revision"/> of</xsl:if> this page</a>
			<xsl:if test="ow:page/@revision or (ow:page/ow:change and not(ow:page/ow:change/@revision = 1))">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute>View other revisions</a>
			</xsl:if>
			<xsl:if test="ow:page/@revision">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>View current revision</a>
			</xsl:if>
			<br/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:page/ow:change/@revision"/></xsl:attribute>Print this page</a>
    |
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
			<input type="text" name="txt" size="30">
				<xsl:attribute name="value"><xsl:value-of select="ow:titlesearch/@value"/></xsl:attribute>
			</input>
			<input type="submit" value="Search"/>
		</form>
	</xsl:template>
	<!-- #FULLSEARCH -->
	<xsl:template match="/ow:wiki" mode="fullsearch">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr valign="top">
				<td valign="top">
					<h1>Full text search for "<xsl:value-of select="ow:fullsearch/@value"/>"</h1>
				</td>
				<td valign="top" align="right">
					<xsl:call-template name="brandingImage"/>
				</td>
			</tr>
		</table>
		<xsl:apply-templates select="//ow:trail"/>
		<hr noshade="noshade" size="1"/>
		<table border="{$Showborders}" width="100%">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top" height="18" colspan="2">
								<strong>Menu:</strong>
							</td>
						</tr>
						<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:bookmarks/ow:link">
							<tr>
								<td valign="top" height="18" width="16">
									<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
								</td>
								<td nowrap="nowrap" valign="top" height="18" width="100%">
									<a href="{@href}">
										<b>
											<xsl:call-template name="cleanslash">
												<xsl:with-param name="runmode" select="string($bookmark_cleanslash)"/>
												<xsl:with-param name="thetext" select="string(text())"/>
											</xsl:call-template>
										</b>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
					<xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
						<br/>
						<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td nowrap="nowrap" valign="top" height="18" colspan="2">
									<strong>
										<xsl:choose>
											<xsl:when test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading">
												<xsl:value-of select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading"/>
												<xsl:text>:</xsl:text>
											</xsl:when>
											<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</strong>
								</td>
							</tr>
							<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
								<xsl:choose>
									<xsl:when test="@name='----'">
										<tr>
											<td valign="top" height="18" width="16"/>
											<td valign="top" height="18" width="100%"/>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td valign="top" height="18" width="16">
												<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
											</td>
											<td nowrap="nowrap" valign="top" height="18" width="100%">
												<b>
													<a href="{@href}">
														<xsl:call-template name="cleanslash">
															<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
															<xsl:with-param name="thetext" select="string(text())"/>
														</xsl:call-template>
													</a>
												</b>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</table>
					</xsl:if>
					<xsl:if test="/ow:wiki/ow:pagebookmarks/pagebookmarks">
						<xsl:for-each select="/ow:wiki/ow:pagebookmarks/pagebookmarks">
							<br/>
							<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td nowrap="nowrap" valign="top" height="18" colspan="2">
										<strong>
											<xsl:choose>
												<xsl:when test="@heading">
													<xsl:value-of select="@heading"/>
													<xsl:text>:</xsl:text>
												</xsl:when>
												<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</strong>
									</td>
								</tr>
								<xsl:for-each select="ow:link">
									<xsl:choose>
										<xsl:when test="@name='----'">
											<tr>
												<td valign="top" height="18" width="16"/>
												<td valign="top" height="18" width="100%"/>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td valign="top" height="18" width="16">
													<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
												</td>
												<td nowrap="nowrap" valign="top" height="18" width="100%">
													<b>
														<a href="{@href}">
															<xsl:call-template name="cleanslash">
																<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
																<xsl:with-param name="thetext" select="string(text())"/>
															</xsl:call-template>
														</a>
													</b>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</table>
						</xsl:for-each>
					</xsl:if>
				</td>
				<td background="{/ow:wiki/ow:skinpath}/images/vertical_line.gif" width="6">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td valign="top" width="100%">
					<xsl:if test="../ow:redirectedfrom">
						<b>Redirected from <a title="Edit this page">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?a=edit&amp;p=<xsl:value-of select="ow:urlencode(string(../ow:redirectedfrom/@name))"/></xsl:attribute>
								<xsl:value-of select="../ow:redirectedfrom/text()"/>
							</a>
						</b>
						<p/>
					</xsl:if>
					<xsl:if test="@revision">
						<b>Showing revision <xsl:value-of select="@revision"/>
						</b>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="contains($name, '/')">
							<a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:page/ow:wiki/ow:scriptname"/>?p=<xsl:call-template name="TrimLastWordPart"><xsl:with-param name="WikiWordPart" select="$name"/></xsl:call-template></xsl:attribute>
                                Up a level
                        </a> |
                </xsl:when>
						<xsl:otherwise>
            </xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates select="ow:fullsearch"/>
					<xsl:value-of select="count(ow:fullsearch/ow:page)"/> hits out of
    <xsl:value-of select="ow:fullsearch/@pagecount"/> pages searched.

    </td>
			</tr>
		</table>
		<form name="f" method="get">
			<xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
			<hr noshade="noshade" size="1"/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="ow:page/@revision">&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if></xsl:attribute>Edit <xsl:if test="ow:page/@revision">revision <xsl:value-of select="ow:page/@revision"/> of</xsl:if> this page</a>
			<xsl:if test="ow:page/@revision or (ow:page/ow:change and not(ow:page/ow:change/@revision = 1))">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute>View other revisions</a>
			</xsl:if>
			<xsl:if test="ow:page/@revision">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>View current revision</a>
			</xsl:if>
			<br/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:page/ow:change/@revision"/></xsl:attribute>Print this page</a>
    |
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
			<input type="text" name="txt" size="30">
				<xsl:attribute name="value"><xsl:value-of select="ow:fullsearch/@value"/></xsl:attribute>
			</input>
			<input type="submit" value="Search"/>
		</form>
	</xsl:template>
	<!-- ###-->
	<!-- #TEXTSEARCH -->
	<xsl:template match="/ow:wiki" mode="textsearch">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr valign="top">
				<td valign="top">
					<h1>Text search for "<xsl:value-of select="ow:textsearch/@value"/>"</h1>
				</td>
				<td valign="top" align="right">
					<xsl:call-template name="brandingImage"/>
				</td>
			</tr>
		</table>
		<xsl:apply-templates select="//ow:trail"/>
		<hr noshade="noshade" size="1"/>
		<table border="{$Showborders}" width="100%">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top" height="18" colspan="2">
								<strong>Menu:</strong>
							</td>
						</tr>
						<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:bookmarks/ow:link">
							<tr>
								<td valign="top" height="18" width="16">
									<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
								</td>
								<td nowrap="nowrap" valign="top" height="18" width="100%">
									<a href="{@href}">
										<xsl:value-of select="text()"/>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
					<xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
						<br/>
						<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td nowrap="nowrap" valign="top" height="18" colspan="2">
									<strong>
										<xsl:choose>
											<xsl:when test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading">
												<xsl:value-of select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading"/>
												<xsl:text>:</xsl:text>
											</xsl:when>
											<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</strong>
								</td>
							</tr>
							<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
								<xsl:choose>
									<xsl:when test="@name='----'">
										<tr>
											<td valign="top" height="18" width="16"/>
											<td valign="top" height="18" width="100%"/>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td valign="top" height="18" width="16">
												<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
											</td>
											<td nowrap="nowrap" valign="top" height="18" width="100%">
												<b>
													<a href="{@href}">
														<xsl:call-template name="cleanslash">
															<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
															<xsl:with-param name="thetext" select="string(text())"/>
														</xsl:call-template>
													</a>
												</b>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</table>
					</xsl:if>
					<xsl:if test="/ow:wiki/ow:pagebookmarks/pagebookmarks">
						<xsl:for-each select="/ow:wiki/ow:pagebookmarks/pagebookmarks">
							<br/>
							<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td nowrap="nowrap" valign="top" height="18" colspan="2">
										<strong>
											<xsl:choose>
												<xsl:when test="@heading">
													<xsl:value-of select="@heading"/>
													<xsl:text>:</xsl:text>
												</xsl:when>
												<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</strong>
									</td>
								</tr>
								<xsl:for-each select="ow:link">
									<xsl:choose>
										<xsl:when test="@name='----'">
											<tr>
												<td valign="top" height="18" width="16"/>
												<td valign="top" height="18" width="100%"/>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td valign="top" height="18" width="16">
													<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
												</td>
												<td nowrap="nowrap" valign="top" height="18" width="100%">
													<b>
														<a href="{@href}">
															<xsl:call-template name="cleanslash">
																<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
																<xsl:with-param name="thetext" select="string(text())"/>
															</xsl:call-template>
														</a>
													</b>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</table>
						</xsl:for-each>
					</xsl:if>
				</td>
				<td background="{/ow:wiki/ow:skinpath}/images/vertical_line.gif" width="6">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td valign="top" width="100%">
					<xsl:if test="../ow:redirectedfrom">
						<b>Redirected from <a title="Edit this page">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?a=edit&amp;p=<xsl:value-of select="ow:urlencode(string(../ow:redirectedfrom/@name))"/></xsl:attribute>
								<xsl:value-of select="../ow:redirectedfrom/text()"/>
							</a>
						</b>
						<p/>
					</xsl:if>
					<xsl:if test="@revision">
						<b>Showing revision <xsl:value-of select="@revision"/>
						</b>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="contains($name, '/')">
							<a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:page/ow:wiki/ow:scriptname"/>?p=<xsl:call-template name="TrimLastWordPart"><xsl:with-param name="WikiWordPart" select="$name"/></xsl:call-template></xsl:attribute>
                                Up a level
                        </a> |
                </xsl:when>
						<xsl:otherwise>
            </xsl:otherwise>
					</xsl:choose>
					<xsl:apply-templates select="ow:textsearch"/>
					<xsl:value-of select="count(ow:textsearch/ow:page)"/> hits out of
    <xsl:value-of select="ow:textsearch/@pagecount"/> pages searched.

    </td>
			</tr>
		</table>
		<form name="f" method="get">
			<xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
			<hr noshade="noshade" size="1"/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="ow:page/@revision">&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if></xsl:attribute>Edit <xsl:if test="ow:page/@revision">revision <xsl:value-of select="ow:page/@revision"/> of</xsl:if> this page</a>
			<xsl:if test="ow:page/@revision or (ow:page/ow:change and not(ow:page/ow:change/@revision = 1))">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute>View other revisions</a>
			</xsl:if>
			<xsl:if test="ow:page/@revision">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>View current revision</a>
			</xsl:if>
			<br/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:page/ow:change/@revision"/></xsl:attribute>Print this page</a>
    |
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
			<input type="hidden" name="a" value="textsearch"/>
			<input type="text" name="txt" size="30">
				<xsl:attribute name="value"><xsl:value-of select="ow:textsearch/@value"/></xsl:attribute>
			</input>
			<input type="submit" value="Search"/>
		</form>
	</xsl:template>
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
            if ((document.all)&amp;&amp;(9==event.keyCode)) {
                el.selection=document.selection.createRange();
                // el.selection.text=String.fromCharCode(9)
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
		<a class="helpon" href="{/ow:wiki/ow:scriptname}?p=Help" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=Help&amp;a=print'); return false;">Help</a>
		<a class="helpon" href="{/ow:wiki/ow:scriptname}?p=Help" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=Help&amp;a=print'); return false;">
			<img src="ow/images/popup.gif" width="15" height="9" border="0" alt=""/>
		</a>
    |
    <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpOnFormatting" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpOnFormatting&amp;a=print'); return false;">Help On Formatting</a>
		<a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpOnFormatting" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpOnFormatting&amp;a=print'); return false;">
			<img src="ow/images/popup.gif" width="15" height="9" border="0" alt=""/>
		</a>
    |
    <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpOnEditing" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpOnEditing&amp;a=print'); return false;">Help On Editing</a>
		<a class="helpon" href="{/ow:wiki/ow:scriptname}?p=HelpOnEditing" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=HelpOnEditing&amp;a=print'); return false;">
			<img src="ow/images/popup.gif" width="15" height="9" border="0" alt=""/>
		</a>
    |
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
			<input type="submit" name="save" value="Save"/>
        &#160;
        <input type="button" name="prev1" value="Preview" onclick="javascript:preview();"/>
			<!-- <input type="submit" name="preview" value="Preview" /> -->
        &#160;
        <input type="button" name="cancel" value="Cancel" onClick="javascript:window.location='{/ow:wiki/ow:scriptname}?p={$name}';"/>
			<!-- START AUTODEPRECATE CODE -->
        &#160;
        <input type="checkbox" name="deprecate" value="0"/> Deprecate this Page
                <!-- END AUTODEPRECATE CODE -->
			<!-- START #CATEGORIES CODE -->
			<xsl:call-template name="categorydropdown"/>
			<!-- END #CATEGORIES CODE -->
			<br/>
			<!-- #SUMMARY EDIT MODE START# -->
			<xsl:call-template name="summaryeditdisplay"/>
			<!-- #SUMMARY EDIT MODE END# -->
			<xsl:if test="ow:page/@wysiwyg='1'">
				<xsl:call-template name="ow:wysiwyg"/>
			</xsl:if>
			<textarea id="text" name="text" wrap="virtual" onfocus="saveText(this.value)" onkeydown="CheckTab(this);saveDocumentCheck(event);" ondblclick="event.cancelBubble=true;">
				<xsl:attribute name="rows"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:rows"/></xsl:attribute>
				<xsl:attribute name="cols"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:cols"/></xsl:attribute>
				<xsl:attribute name="style">font-family: monospace</xsl:attribute>
				<xsl:value-of select="ow:page/ow:raw/text()"/>
			</textarea>
			<br/>
			<xsl:call-template name="tag_edit"/>
			<br/>
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
        <br/>
			<br/>
        Optional comment about this change:
        <br/>
			<input type="text" name="comment" style="color:#333333; width:100%" maxlength="1000">
				<xsl:attribute name="size"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:cols"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="ow:page/ow:change/ow:comment/text()"/></xsl:attribute>
			</input>
			<br/>
			<input type="hidden" name="revision" value="{ow:page/@revision}"/>
			<input type="hidden" name="newrev" value="{ow:page/ow:change/@revision}"/>
			<input type="hidden" name="p" value="{$name}"/>
			<input type="submit" name="save" value="Save"/>
        &#160;
        <input type="button" name="prev2" value="Preview" onclick="javascript:preview();"/>
			<!-- <input type="submit" name="preview" value="Preview" /> -->
        &#160;
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
	<xsl:template match="ow:trail">
		<xsl:if test="count(ow:link) &gt; 1 and ../ow:userpreferences/ow:trailontop">
			<small>
				<xsl:for-each select="ow:link">
					<xsl:choose>
						<xsl:when test="../../ow:page/ow:link/@href=@href">
                        &#187; <xsl:call-template name="cleanslash">
								<xsl:with-param name="runmode" select="string($trail_cleanslash)"/>
								<xsl:with-param name="thetext" select="string(text())"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
                        &#187; <a class="trail" href="{@href}">
								<xsl:call-template name="cleanslash">
									<xsl:with-param name="runmode" select="string($trail_cleanslash)"/>
									<xsl:with-param name="thetext" select="string(text())"/>
								</xsl:call-template>
							</a>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</small>
		</xsl:if>
	</xsl:template>
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
	<xsl:template name="attachpage">
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
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr valign="top">
				<td valign="top">
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
				</td>
				<td valign="top" align="right">
					<xsl:call-template name="brandingImage"/>
				</td>
			</tr>
		</table>
		<xsl:apply-templates select="../ow:trail"/>
		<hr noshade="noshade" size="1"/>
		<table border="{$Showborders}" width="100%">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<!-- START CATEGORY DISPLAY -->
						<tr>
							<td valign="top" height="20" colspan="2">
								<strong>
									<xsl:call-template name="categorydisplay"/>
									<xsl:text> </xsl:text>
								</strong>
							</td>
						</tr>
						<!-- END CATEGORY DISPLAY -->
						<tr>
							<td valign="top" height="18" colspan="2" class="bookmarks">
								<xsl:call-template name="mainmenu_title"/>
							</td>
						</tr>
						<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:bookmarks/ow:link">
							<tr>
								<td valign="top" height="18" width="16">
									<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
								</td>
								<td nowrap="nowrap" valign="top" height="18" width="100%">
									<a class="bookmarks" href="{@href}">
										<xsl:call-template name="cleanslash">
											<xsl:with-param name="runmode" select="string($bookmark_cleanslash)"/>
											<xsl:with-param name="thetext" select="string(text())"/>
										</xsl:call-template>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
					<xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
						<br/>
						<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td nowrap="nowrap" valign="top" height="18" colspan="2">
									<strong>
										<xsl:choose>
											<xsl:when test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading">
												<xsl:value-of select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading"/>
												<xsl:text>:</xsl:text>
											</xsl:when>
											<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</strong>
								</td>
							</tr>
							<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
								<xsl:choose>
									<xsl:when test="@name='----'">
										<tr>
											<td valign="top" height="18" width="16"/>
											<td valign="top" height="18" width="100%"/>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td valign="top" height="18" width="16">
												<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
											</td>
											<td nowrap="nowrap" valign="top" height="18" width="100%">
												<b>
													<a href="{@href}">
														<xsl:call-template name="cleanslash">
															<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
															<xsl:with-param name="thetext" select="string(text())"/>
														</xsl:call-template>
													</a>
												</b>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</table>
					</xsl:if>
					<xsl:if test="/ow:wiki/ow:pagebookmarks/pagebookmarks">
						<xsl:for-each select="/ow:wiki/ow:pagebookmarks/pagebookmarks">
							<br/>
							<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td nowrap="nowrap" valign="top" height="18" colspan="2">
										<strong>
											<xsl:choose>
												<xsl:when test="@heading">
													<xsl:value-of select="@heading"/>
													<xsl:text>:</xsl:text>
												</xsl:when>
												<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</strong>
									</td>
								</tr>
								<xsl:for-each select="ow:link">
									<xsl:choose>
										<xsl:when test="@name='----'">
											<tr>
												<td valign="top" height="18" width="16"/>
												<td valign="top" height="18" width="100%"/>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td valign="top" height="18" width="16">
													<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
												</td>
												<td nowrap="nowrap" valign="top" height="18" width="100%">
													<b>
														<a href="{@href}">
															<xsl:call-template name="cleanslash">
																<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
																<xsl:with-param name="thetext" select="string(text())"/>
															</xsl:call-template>
														</a>
													</b>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</table>
						</xsl:for-each>
					</xsl:if>
				</td>
				<td width="6" background="{/ow:wiki/ow:skinpath}/images/vertical_line.gif">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td valign="top" width="100%">
					<xsl:call-template name="attachbody"/>
				</td>
			</tr>
		</table>
		<hr noshade="noshade" size="1"/>
		<table cellspacing="0" cellpadding="0" border="{$Showborders}" width="100%">
			<xsl:if test="not(/ow:wiki/ow:userpreferences/ow:bookmarks='None')">
				<tr>
					<td align="left" class="n">
						<a class="functions">
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="@revision">&amp;revision=<xsl:value-of select="@revision"/></xsl:if></xsl:attribute>Edit <xsl:if test="@revision">revision <xsl:value-of select="@revision"/> of</xsl:if> this page</a>
						<!-- Added for rename capability -->
                | <a class="functions">
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=rename&amp;step=first</xsl:attribute>Rename this page</a>
						<xsl:if test="@revision or (ow:change and not(ow:change/@revision = 1))">
                |
                <a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute>View other revisions</a>
						</xsl:if>
						<xsl:if test="@revision">
                |
                <a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>View current revision</a>
						</xsl:if>
						<xsl:if test="/ow:wiki/ow:allowattachments">
                |
                <a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=attach</xsl:attribute>Attachments</a> (<xsl:value-of select="count(ow:attachments/ow:attachment[@deprecated='false'])"/>)
            </xsl:if>
                |
                <a class="functions">
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:change/@revision"/></xsl:attribute>Print this page</a>
                                |
            <a class="functions">
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=xml&amp;revision=<xsl:value-of select="ow:change/@revision"/></xsl:attribute>View XML</a>
						<!-- START HITS CODE -->
						<xsl:if test="@hits">
                                | Page views: <b>
								<xsl:value-of select="@hits"/>
							</b>
						</xsl:if>
						<!-- END HITS CODE -->
						<br/>
						<a class="functions">
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=FindPage&amp;txt=<xsl:value-of select="$name"/></xsl:attribute>Find page</a> by browsing, searching or an index
                                        <xsl:if test="not(@changes='0')">
                                        | Page Revisions: <b>
								<xsl:value-of select="@changes"/>
							</b>
							<br/>
                                        Last Edited <xsl:value-of select="ow:formatLongDate(string(ow:change/ow:date))"/>
							<xsl:text> </xsl:text>
							<xsl:if test="ow:change/ow:by/@alias">
                                                by <xsl:value-of select="ow:change/ow:by/@alias"/>
								<xsl:text> </xsl:text>
							</xsl:if>
							<a class="functions">
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/><xsl:if test="ow:change/@revision">&amp;difffrom=<xsl:value-of select="ow:change/@revision - 1"/></xsl:if>&amp;a=diff</xsl:attribute>(diff)</a>
							<br/>
						</xsl:if>
						<xsl:if test="/ow:wiki/ow:userip='local' and /ow:wiki/ow:usertype='admin'">
							<xsl:call-template name="adminfunctions"/>
						</xsl:if>
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
	<!-- #TAG TEMPLATES-->
	<xsl:template match="/ow:wiki" mode="tagsearch">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr valign="top">
				<td valign="top">
					<h1>Tag search for "<xsl:value-of select="ow:tagsearch/@value"/>"</h1>
				</td>
				<td valign="top" align="right">
					<xsl:call-template name="brandingImage"/>
				</td>
			</tr>
		</table>
		<xsl:apply-templates select="//ow:trail"/>
		<hr noshade="noshade" size="1"/>
		<table border="{$Showborders}" width="100%">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top" height="18" colspan="2">
								<strong>Menu:</strong>
							</td>
						</tr>
						<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:bookmarks/ow:link">
							<tr>
								<td valign="top" height="18" width="16">
									<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
								</td>
								<td nowrap="nowrap" valign="top" height="18" width="100%">
									<a href="{@href}">
										<b>
											<xsl:call-template name="cleanslash">
												<xsl:with-param name="runmode" select="string($bookmark_cleanslash)"/>
												<xsl:with-param name="thetext" select="string(text())"/>
											</xsl:call-template>
										</b>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
					<xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
						<br/>
						<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td nowrap="nowrap" valign="top" height="18" colspan="2">
									<strong>
										<xsl:choose>
											<xsl:when test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading">
												<xsl:value-of select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading"/>
												<xsl:text>:</xsl:text>
											</xsl:when>
											<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</strong>
								</td>
							</tr>
							<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
								<xsl:choose>
									<xsl:when test="@name='----'">
										<tr>
											<td valign="top" height="18" width="16"/>
											<td valign="top" height="18" width="100%"/>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td valign="top" height="18" width="16">
												<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
											</td>
											<td nowrap="nowrap" valign="top" height="18" width="100%">
												<b>
													<a href="{@href}">
														<xsl:call-template name="cleanslash">
															<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
															<xsl:with-param name="thetext" select="string(text())"/>
														</xsl:call-template>
													</a>
												</b>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</table>
					</xsl:if>
					<xsl:if test="/ow:wiki/ow:pagebookmarks/pagebookmarks">
						<xsl:for-each select="/ow:wiki/ow:pagebookmarks/pagebookmarks">
							<br/>
							<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td nowrap="nowrap" valign="top" height="18" colspan="2">
										<strong>
											<xsl:choose>
												<xsl:when test="@heading">
													<xsl:value-of select="@heading"/>
													<xsl:text>:</xsl:text>
												</xsl:when>
												<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</strong>
									</td>
								</tr>
								<xsl:for-each select="ow:link">
									<xsl:choose>
										<xsl:when test="@name='----'">
											<tr>
												<td valign="top" height="18" width="16"/>
												<td valign="top" height="18" width="100%"/>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td valign="top" height="18" width="16">
													<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
												</td>
												<td nowrap="nowrap" valign="top" height="18" width="100%">
													<b>
														<a href="{@href}">
															<xsl:call-template name="cleanslash">
																<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
																<xsl:with-param name="thetext" select="string(text())"/>
															</xsl:call-template>
														</a>
													</b>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</table>
						</xsl:for-each>
					</xsl:if>
				</td>
				<td background="{/ow:wiki/ow:skinpath}/images/vertical_line.gif" width="6">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td valign="top" width="100%">
					<ul>
						<xsl:for-each select="ow:tagsearch/ow:page">
							<li>
								<xsl:apply-templates select="ow:link"/>
								<xsl:text> - </xsl:text>
								<small>
									<xsl:value-of select="ow:change/ow:tags/@tags"/>
								</small>
							</li>
						</xsl:for-each>
					</ul>
					<xsl:value-of select="count(ow:tagsearch/ow:page)"/> pages searched.

    </td>
			</tr>
		</table>
		<form name="f" method="get">
			<xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
			<hr noshade="noshade" size="1"/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="ow:page/@revision">&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if></xsl:attribute>Edit <xsl:if test="ow:page/@revision">revision <xsl:value-of select="ow:page/@revision"/> of</xsl:if> this page</a>
			<xsl:if test="ow:page/@revision or (ow:page/ow:change and not(ow:page/ow:change/@revision = 1))">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute>View other revisions</a>
			</xsl:if>
			<xsl:if test="ow:page/@revision">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>View current revision</a>
			</xsl:if>
			<br/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:page/ow:change/@revision"/></xsl:attribute>Print this page</a>
    |
    <a class="same">
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=diff&amp;revision=<xsl:value-of select="ow:change/@revision"/>&amp;xml=1</xsl:attribute>View XML</a>
			<br/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=FindPage&amp;txt=<xsl:value-of select="$name"/></xsl:attribute>Find page</a> by browsing, searching or an index
    <br/>
			<input type="hidden" name="a" value="fullsearch"/>
			<input type="text" name="txt" size="30">
				<xsl:attribute name="value"><xsl:value-of select="ow:fullsearch/@value"/></xsl:attribute>
			</input>
			<input type="submit" value="Search"/>
		</form>
	</xsl:template>
	<xsl:template match="/ow:wiki" mode="tagsindex">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr valign="top">
				<td valign="top">
					<h1>Tags Cloud</h1>
				</td>
				<td valign="top" align="right">
					<xsl:call-template name="brandingImage"/>
				</td>
			</tr>
		</table>
		<xsl:apply-templates select="//ow:trail"/>
		<hr noshade="noshade" size="1"/>
		<table border="{$Showborders}" width="100%">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top" height="18" colspan="2">
								<strong>Menu:</strong>
							</td>
						</tr>
						<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:bookmarks/ow:link">
							<tr>
								<td valign="top" height="18" width="16">
									<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
								</td>
								<td nowrap="nowrap" valign="top" height="18" width="100%">
									<a href="{@href}">
										<b>
											<xsl:call-template name="cleanslash">
												<xsl:with-param name="runmode" select="string($bookmark_cleanslash)"/>
												<xsl:with-param name="thetext" select="string(text())"/>
											</xsl:call-template>
										</b>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
					<xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
						<br/>
						<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td nowrap="nowrap" valign="top" height="18" colspan="2">
									<strong>
										<xsl:choose>
											<xsl:when test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading">
												<xsl:value-of select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading"/>
												<xsl:text>:</xsl:text>
											</xsl:when>
											<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</strong>
								</td>
							</tr>
							<xsl:for-each select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
								<xsl:choose>
									<xsl:when test="@name='----'">
										<tr>
											<td valign="top" height="18" width="16"/>
											<td valign="top" height="18" width="100%"/>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td valign="top" height="18" width="16">
												<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
											</td>
											<td nowrap="nowrap" valign="top" height="18" width="100%">
												<b>
													<a href="{@href}">
														<xsl:call-template name="cleanslash">
															<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
															<xsl:with-param name="thetext" select="string(text())"/>
														</xsl:call-template>
													</a>
												</b>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</table>
					</xsl:if>
					<xsl:if test="/ow:wiki/ow:pagebookmarks/pagebookmarks">
						<xsl:for-each select="/ow:wiki/ow:pagebookmarks/pagebookmarks">
							<br/>
							<table nowrap="nowrap" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td nowrap="nowrap" valign="top" height="18" colspan="2">
										<strong>
											<xsl:choose>
												<xsl:when test="@heading">
													<xsl:value-of select="@heading"/>
													<xsl:text>:</xsl:text>
												</xsl:when>
												<xsl:otherwise>Page Bookmarks<xsl:text>:</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</strong>
									</td>
								</tr>
								<xsl:for-each select="ow:link">
									<xsl:choose>
										<xsl:when test="@name='----'">
											<tr>
												<td valign="top" height="18" width="16"/>
												<td valign="top" height="18" width="100%"/>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td valign="top" height="18" width="16">
													<img src="{/ow:wiki/ow:skinpath}/images/bookmark_dot.gif"/>
												</td>
												<td nowrap="nowrap" valign="top" height="18" width="100%">
													<b>
														<a href="{@href}">
															<xsl:call-template name="cleanslash">
																<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
																<xsl:with-param name="thetext" select="string(text())"/>
															</xsl:call-template>
														</a>
													</b>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</table>
						</xsl:for-each>
					</xsl:if>
				</td>
				<td background="{/ow:wiki/ow:skinpath}/images/vertical_line.gif" width="6">
					<xsl:value-of select="$nbsp" disable-output-escaping="yes"/>
				</td>
				<td valign="top" width="100%">
					<xsl:for-each select="ow:tagsindex/ow:tag">
						<a title="search it">
							<xsl:attribute name="href"><xsl:value-of select="ow:scriptname"/>?a=tagsearch&amp;txt=<xsl:value-of select="ow:urlencode(string(@name))"/></xsl:attribute>
							<font>
								<xsl:attribute name="style">font-size:<xsl:value-of select="@size"/>;line-height:1em</xsl:attribute>
								<xsl:value-of select="@name"/>
							</font>
						</a>
						<small>
							<font style="color:#888">(<xsl:value-of select="@count"/>)</font>
						</small>&#160;
		</xsl:for-each>
					<br/>
					<br/>
					<xsl:value-of select="ow:tagsindex/@num"/> results.<br/>
				</td>
			</tr>
		</table>
		<form name="f" method="get">
			<xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
			<hr noshade="noshade" size="1"/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="ow:page/@revision">&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if></xsl:attribute>Edit <xsl:if test="ow:page/@revision">revision <xsl:value-of select="ow:page/@revision"/> of</xsl:if> this page</a>
			<xsl:if test="ow:page/@revision or (ow:page/ow:change and not(ow:page/ow:change/@revision = 1))">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute>View other revisions</a>
			</xsl:if>
			<xsl:if test="ow:page/@revision">
        |
        <a>
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>View current revision</a>
			</xsl:if>
			<br/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:page/ow:change/@revision"/></xsl:attribute>Print this page</a>
    |
    <a class="same">
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=diff&amp;revision=<xsl:value-of select="ow:change/@revision"/>&amp;xml=1</xsl:attribute>View XML</a>
			<br/>
			<a>
				<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=FindPage&amp;txt=<xsl:value-of select="$name"/></xsl:attribute>Find page</a> by browsing, searching or an index
    <br/>
			<input type="hidden" name="a" value="fullsearch"/>
			<input type="text" name="txt" size="30">
				<xsl:attribute name="value"><xsl:value-of select="ow:fullsearch/@value"/></xsl:attribute>
			</input>
			<input type="submit" value="Search"/>
		</form>
	</xsl:template>
</xsl:stylesheet>
