<?xml version="1.0"?>
<!--
' $Log: ow_common.xsl,v $
' Revision 1.47  2007/01/29 23:54:59  sansei
' Added parameter AllowImageLibrary for use in wysiwyg editor
'
' Revision 1.46  2007/01/29 23:10:40  sansei
' Added parameter AllowAttachments for use in wysiwyg editor
'
' Revision 1.45  2006/02/19 19:47:24  piixiiees
' Added the condition <xsl:if test="/ow:wiki/ow:summary/@active='yes'">
' in TextSearch, FullSearch and TitleSearch to show the precis/summary after the filename page name in the results.
'
' Revision 1.44  2006/02/19 14:52:31  galleyslave
' TextSearch and FullSearch now show the precis after the filename page name in the results
'
' Revision 1.43  2006/02/16 18:36:03  gbamber
' General update:
' Rename improved
' local: now sharedimage:
' New imageupload macro
' added file uploadimage.asp
' changed owall to fix #includes with attach.asp
' new doctypes for google earth
' new urltype skype
' Userprefs has a password field
' Reaname template updated
'
' Revision 1.40  2005/12/15 06:26:22  gbamber
' no message
'
' Revision 1.39  2005/12/14 20:40:40  gbamber
' BugFix:Updated hardcoded 'Help' link in editing window
' BugFix:Updated gStrictLinkPattern to include underscores
' BugFix:Changed scope of userprefs cookie
' New:Action UpgradeFreelinks
' New:Added Maintainance link to admin control panel
' New:Added parameter to SuccessfulAction page
' New:owdb function to upgrade freelink pages
'
' Revision 1.38  2005/03/06 13:42:39  sansei
' pulled this template out of ow_common.xsl - as it is maintained 'outside' owng CVS
'
' Revision 1.37  2005/03/05 09:02:43  sansei
' added SiteName - flashlogo now display the Wiki's name IF <13  and >0 chars. - in 3 sizes (7-10-13)
'
' Revision 1.36  2005/03/03 15:59:22  sansei
' fixed minor bug
'
' Revision 1.35  2005/03/03 12:57:42  sansei
' Added 'FlashLogo' - If AllowFlash then the page logo is displayed with a flash file (pt. default, default_left only) - You can disable any use of FlashLogo in myskin.xsl
'
' Revision 1.34  2005/01/22 11:48:39  sansei
' added: InlineXml to the editor (IF plugin is active)
'
' Revision 1.33  2005/01/21 20:35:00  sansei
' Fixed skin default_left: fullsearch result not truncating MAIN bookmarks
' Fixed skin default_left: not showing pagebookmarks bold
' TextSearch can now use truncate syntax (see other truncate demo)
' SummarySearch can now use truncate syntax (see other truncate demo)
'
' Revision 1.32  2005/01/18 18:43:31  sansei
' added so PLUGIN macro: ShowFile is present in the editor (Macros/other...) IF the ShowFile plugin is ON.
'
' Revision 1.31  2005/01/18 13:37:05  sansei
' Made so if AllowBadges = 0 then the editor doesnt show badges in the interface.
'
' Revision 1.30  2004/11/03 10:34:32  gbamber
' BugFix: TextSearch
' Added: More english-language entries
'
' Revision 1.29  2004/11/01 12:15:24  gbamber
' NEW: Admin function 'Nuke deprecated pages older than:'
'
' Revision 1.28  2004/10/31 21:11:56  gbamber
' New admin functions - Delete old revisions (this page | All) for default skin only
'
' Revision 1.27  2004/10/30 20:45:24  gbamber
' Added $adminpassword
'
' Revision 1.26  2004/10/27 09:53:43  gbamber
' Round-up of small changes and bugfixes
'
' Revision 1.25  2004/10/21 21:43:29  gbamber
' Moved rename template to ow_common.xsl
'
' Revision 1.24  2004/10/20 18:31:57  gbamber
' Improved formatting and BugFixes in XSL
'
' Revision 1.23  2004/10/19 12:40:12  gbamber
' Massive serialising update.
'
' Revision 1.22  2004/10/13 12:18:59  gbamber
' Forced updates to make sure CVS reflects current work
'
' Revision 1.21  2004/10/13 11:09:01  gbamber
' Updated Summaries in default and default_left
'
' Revision 1.20  2004/10/13 00:18:30  gbamber
' 1 ) More debugging options (1,2 and 3)
' 2 ) <systeminfo(appname)>
' 3 ) OPENWIKI_FINDNAME = FindPage
' 4 ) TitleIndex shows summary text
' 5 ) Page links show summary text + Date changed
' 6 ) CategoryIndex shows page visits
' 7 ) More robust database autoupgrade
'
' Revision 1.19  2004/10/12 15:00:46  gbamber
' Truncate now working
'
' Revision 1.18  2004/10/11 12:54:39  gbamber
' Added: <SummarySearch(PP)>
' Improved:CategorySearch
'
' Revision 1.17  2004/10/10 22:50:06  gbamber
' Massive update!
' Added: Summaries
' Added: Default pages built-in
' Added: Auto-update from openwiki classic
' Modified: Default plugin status
' Modified: Default Page Names
' Modified: Default MSAccess DB to openwikidist.mdb
' BugFix: Many MSAccess bugs fixed
' Modified: plastic skin to show Summary
'
' Revision 1.16  2004/10/02 12:01:32  sansei
' Added Fullsearch truncate facillity (Fullsearch macro now accepts one parameter!)
'
' Log added by sEi - 20041001
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns:html="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow html" exclude-result-prefixes="" version="1.0">
	<xsl:include href="ow_JScripts.xsl"/>
	<xsl:include href="owng_flashlogo.xsl"/>
	<xsl:variable name="name" select="ow:urlencode(string(/ow:wiki/ow:page/@name))"/>
	<xsl:param name="FullsearchHighlight"/>
	<xsl:param name="AllowFlash"/>
	<xsl:param name="AllowImageLibrary"/>
	<xsl:param name="AllowAttachments"/>
	<xsl:param name="AllowBadges"/>
	<xsl:param name="AllowShowFile"/>
	<xsl:param name="InlineXml"/>
	<xsl:param name="hido"/>
	<xsl:param name="hiterm"/>
	<xsl:param name="adminpassword"/>
	<xsl:variable name="online" select="/ow:wiki/ow:online/text()"/>
	<!-- ridiculous! IE processes <br></br> differently compared to <br /> ! -->
	<xsl:template name="truncatethis">
		<xsl:param name="thetext"/>
		<xsl:param name="syntax"/>
		<xsl:choose>
			<xsl:when test="(contains($thetext, '/')) and (string-length($syntax) &gt; 0)">
				<xsl:value-of select="ow:TruncateThis($thetext,$syntax)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$thetext"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="adminfunctions">
		<p style="color:#ff0000">
			<strong>Admin functions : <a class="functions">
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=deletepage&amp;adminpassword=<xsl:value-of select="$adminpassword"/></xsl:attribute>Delete this page</a>
                        | Delete old revisions: <a class="functions">
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=deleterevisions&amp;page=<xsl:value-of select="$name"/></xsl:attribute>This page</a>
                        | <a class="functions">
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=deleterevisions</xsl:attribute>all pages</a>
			<br/>Nuke deprecated pages older than :
			<a class="functions">
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=nukedeprecatedPages&amp;adminpassword=<xsl:value-of select="$adminpassword"/>&amp;days=0</xsl:attribute>0 days (all)</a>
                        | <a class="functions">
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=nukedeprecatedPages&amp;adminpassword=<xsl:value-of select="$adminpassword"/>&amp;days=5</xsl:attribute>5 days</a>
                        | <a class="functions">
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=nukedeprecatedPages&amp;adminpassword=<xsl:value-of select="$adminpassword"/>&amp;days=10</xsl:attribute>10 days</a>
                        | <a class="functions">
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=nukedeprecatedPages&amp;adminpassword=<xsl:value-of select="$adminpassword"/>&amp;days=20</xsl:attribute>20 days</a>
                        | <a class="functions">
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=nukedeprecatedPages&amp;adminpassword=<xsl:value-of select="$adminpassword"/>&amp;days=30</xsl:attribute>30 days</a>
			<br/>Maintainance: 
			<a class="functions">
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=UpgradeFreelinks</xsl:attribute>Update Free Links</a>
<!--			<br/>Online: <xsl:value-of select="$online"/> -->
			</strong>
		</p>
	</xsl:template>
	<xsl:template name="cleanslash">
		<xsl:param name="runmode"/>
		<xsl:param name="thetext"/>
		<xsl:choose>
			<xsl:when test="(contains($thetext, '/')) and ($runmode &gt; 0)">
				<xsl:value-of select="ow:CleanSlash($thetext,$runmode)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$thetext"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="ow:xslinfo">
                  Your version of <xsl:value-of select="system-property('xsl:vendor')"/> MSXML is
                  <xsl:value-of select="system-property('xsl:version')"/>
	</xsl:template>
	<xsl:template match="br">
		<br/>
	</xsl:template>
	<xsl:template match="big">
		<b>
			<big>
				<xsl:apply-templates/>
			</big>
		</b>
	</xsl:template>
	<xsl:template match="*">
		<xsl:element name="{name()}">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<!-- ==================== used to do client-side transformation ==================== -->
	<xsl:template match="processing-instruction()|comment()|text()">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<!--xsl:template match="table">
  <table cellspacing="0" cellpadding="2" border="1" width="100%">
    <xsl:apply-templates/>
  </table>
</xsl:template-->
	<xsl:template name="pi">
		<xsl:text disable-output-escaping="yes">&lt;?xml version="1.0" encoding="</xsl:text>
		<xsl:value-of select="@encoding"/>
		<xsl:text disable-output-escaping="yes">"?>&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd"></xsl:text>
	</xsl:template>
	<xsl:template name="TrimLastWordPart">
		<xsl:param name="WikiWordPart"/>
		<xsl:if test="contains($WikiWordPart, '/')">
			<xsl:variable name="first" select="substring-before($WikiWordPart, '/')"/>
			<xsl:variable name="rest" select="substring-after($WikiWordPart, '/')"/>
			<xsl:value-of select="$first"/>
			<xsl:if test="contains($rest, '/')">
				<xsl:text>/</xsl:text>
			</xsl:if>
			<xsl:call-template name="TrimLastWordPart">
				<xsl:with-param name="WikiWordPart" select="$rest"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- ==================== handles the openwiki-html element ==================== -->
	<xsl:template match="ow:html">
		<xsl:value-of select="." disable-output-escaping="yes"/>
	</xsl:template>
	<!-- ==================== handles the openwiki-math element ==================== -->
	<xsl:template match="ow:math">
		<math xmlns="http://www.w3.org/1998/Math/MathML">
			<xsl:value-of select="." disable-output-escaping="yes"/>
		</math>
	</xsl:template>
	<!-- ==================== show an RSS feed ==================== -->
	<xsl:template match="ow:feed">
		<xsl:apply-templates/>
		<small>
			<br/>
    last update: <xsl:value-of select="ow:formatLongDateTime(string(@last))"/>
			<br/>
			<a href="{@href}" target="_blank">
				<img src="ow/images/xml.gif" width="36" height="14" border="0" alt=""/>
			</a> |
    <a href="{/ow:wiki/ow:scriptname}?p={/ow:wiki/ow:page/ow:link/@name}&amp;a=refresh&amp;refreshurl={ow:urlencode(string(@href))}">refresh</a> |
    <a href="{/ow:wiki/ow:scriptname}?p={/ow:wiki/ow:page/ow:link/@name}&amp;a=refresh">refresh all</a>
		</small>
	</xsl:template>
	<!-- ==================== show an aggregated RSS feed ==================== -->
	<xsl:template match="ow:aggregation">
		<xsl:apply-templates/>
		<small>
			<br/>
    last update: <xsl:value-of select="ow:formatLongDateTime(string(@last))"/>
			<br/>
			<a href="{@href}" target="_blank">
				<img src="ow/images/xml.gif" width="36" height="14" border="0" alt=""/>
			</a> |
    <a href="{@refreshURL}">refresh</a>
		</small>
	</xsl:template>
	<xsl:template match="ow:interlinks">
		<script language="javascript" type="text/javascript" charset="{/ow:wiki/@encoding}">
			<xsl:text disable-output-escaping="yes">&lt;!--
        function ask(pURL) {
            var x = prompt("Enter the word you're searching for:", "");
            if (x != null) {
                var pos = pURL.indexOf("$1");
                if (pos > 0) {
                    top.location.assign(pURL.substring(0, pos) + x + pURL.substring(pos + 2, pURL.length));
                } else {
                    top.location.assign(pURL + x);
                }
            }
        }
    //--&gt;</xsl:text>
		</script>
		<table cellspacing="0" cellpadding="2" border="0">
			<xsl:for-each select="ow:interlink">
				<tr>
					<td class="n">
						<li>
							<xsl:value-of select="text()"/>
						</li> &#160;&#160;</td>
					<td class="n">
						<a href="#" onclick="javascript:ask('{@href}');">
							<xsl:value-of select="@href"/>
						</a>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template name="searchbox">
		<table class="searchbox">
			<tr>
				<td>
					<form name="f" method="get">
						<xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
						<input type="hidden" name="a" value="fullsearch"/>
						<input type="text" name="txt" size="30" ondblclick="event.cancelBubble=true;"/>
						<input type="submit" value="Search"/>
					</form>
				</td>
			</tr>
		</table>
	</xsl:template>
	<!-- ==================== wiki link to an existing page (with summary text display)==================== -->
	<xsl:template match="ow:link">
		<xsl:choose>
			<xsl:when test="@date">
				<xsl:choose>
					<xsl:when test="../ow:change/ow:summary/text()">
						<a href="{@href}{@anchor}">
							<xsl:attribute name="title"><xsl:value-of select="../ow:change/ow:summary/text()"/>
Last changed: <xsl:value-of select="ow:formatLongDate(string(@date))"/></xsl:attribute>
							<xsl:choose>
								<xsl:when test="string-length(../../@truncate)>0">
									<xsl:call-template name="truncatethis">
										<xsl:with-param name="thetext" select="string(text())"/>
										<xsl:with-param name="syntax" select="string(../../@truncate)"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="text()"/>
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<a href="{@href}{@anchor}">
							<xsl:attribute name="title">Last changed: <xsl:value-of select="ow:formatLongDate(string(@date))"/></xsl:attribute>
							<xsl:choose>
								<xsl:when test="string-length(../../@truncate)>0">
									<xsl:call-template name="truncatethis">
										<xsl:with-param name="thetext" select="string(text())"/>
										<xsl:with-param name="syntax" select="string(../../@truncate)"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="text()"/>
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="text()"/>
				<a class="nonexistent" href="{@href}" title="Describe this page">?</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ==================== inclusion of another wikipage in this wikipage ==================== -->
	<xsl:template match="ow:body/ow:page">
		<xsl:apply-templates select="ow:body"/>
		<xsl:if test="not(@SilentInclude=1)">
			<div align="right">
				<small>[goto <xsl:apply-templates select="ow:link"/>]</small>
			</div>
			<p/>
		</xsl:if>
	</xsl:template>
	<!-- ==================== shows an error message ==================== -->
	<xsl:template match="ow:error">
		<li>
			<font color="red">
				<xsl:value-of select="."/>
			</font>
		</li>
	</xsl:template>
	<xsl:template match="/ow:wiki" mode="print">
		<h2>
			<a name="h0" class="same">
				<xsl:value-of select="ow:page/ow:link"/>
			</a>
		</h2>
		<xsl:apply-templates select="ow:page/ow:body"/>
	</xsl:template>
	<xsl:template match="/ow:wiki" mode="naked">
		<!--xsl:attribute name="ondblclick">location.href='<xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test='ow:page/@revision'>&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if>'</xsl:attribute-->
		<h2>
			<a name="h0" class="same">
				<xsl:value-of select="ow:page/ow:link"/>
			</a>
		</h2>
		<xsl:apply-templates select="ow:page/ow:body"/>
	</xsl:template>
	<xsl:template match="/ow:wiki" mode="embedded">
		<xsl:apply-templates select="ow:page/ow:body"/>
	</xsl:template>
	<!-- ==================== shows footnotes ==================== -->
	<xsl:template match="ow:footnotes">
		<p/>
    ____
    <xsl:apply-templates select="ow:footnote"/>
	</xsl:template>
	<xsl:template match="ow:footnote">
		<br/>
		<a name="#footnote{@index}"/>
		<sup>&#160;&#160;&#160;<xsl:value-of select="@index"/>&#160;</sup>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="ow:diff">
		<pre class="diff">
			<xsl:apply-templates/>
		</pre>
	</xsl:template>
	<xsl:template match="ow:recentchanges" mode="shortversion">
		<table cellspacing="0" cellpadding="2" border="0">
			<xsl:for-each select="ow:page">
				<tr>
					<xsl:choose>
						<xsl:when test='not(substring-before(./preceding-sibling::*[position()=1]/ow:change/ow:date, "T") = substring-before(ow:change/ow:date, "T"))'>
							<td width="1%" class="rc" nowrap="nowrap">
								<xsl:value-of select="ow:formatShortDate(string(ow:change/ow:date))"/>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td width="1%" class="rc">&#160;</td>
						</xsl:otherwise>
					</xsl:choose>
					<td class="rc">
						<xsl:value-of select="ow:formatTime(string(ow:change/ow:date))"/>
        -
        <xsl:apply-templates select="ow:link"/>&#160;<xsl:if test="ow:change/@status='new'">
							<span class="new">new</span>
						</xsl:if>
						<xsl:if test="ow:change/@status='deleted'">
							<span class="deprecated">deprecated</span>
						</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template match="ow:recentchanges">
		<xsl:choose>
			<xsl:when test="@short='true'">
				<xsl:apply-templates select="." mode="shortversion"/>
			</xsl:when>
			<xsl:otherwise>
				<table cellspacing="0" cellpadding="2" width="100%" border="0">
					<xsl:for-each select="ow:page">
						<xsl:if test='not(substring-before(./preceding-sibling::*[position()=1]/ow:change/ow:date, "T") = substring-before(ow:change/ow:date, "T"))'>
							<tr class="rc">
								<td colspan="4">&#160;</td>
							</tr>
							<tr class="rc">
								<td colspan="4">
									<b>
										<xsl:value-of select="ow:formatLongDate(string(ow:change/ow:date))"/>
									</b>
								</td>
							</tr>
						</xsl:if>
						<tr class="rc">
							<td align="left" width="1%">
								<xsl:value-of select="ow:formatTime(string(ow:change/ow:date))"/>
							</td>
							<td align="left" width="25%" nowrap="nowrap">
								<xsl:if test="@changes > 1">[<a>
										<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="ow:urlencode(string(@name))"/>&amp;a=diff</xsl:attribute>diff</a>] <xsl:text> </xsl:text> [<xsl:value-of select="@changes"/>&#160;<a>
										<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="ow:urlencode(string(@name))"/>&amp;a=changes</xsl:attribute>changes</a>]</xsl:if>&#160;</td>
							<td align="left">
								<a>
									<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?<xsl:value-of select="ow:urlencode(string(@name))"/></xsl:attribute>
									<xsl:value-of select="ow:link/text()"/>
								</a>&#160;<xsl:if test="ow:change/@status='new'">
									<span class="new">new</span>
								</xsl:if>
								<xsl:if test="ow:change/@status='deleted'">
									<span class="deprecated">deprecated</span>
								</xsl:if>
							</td>
							<xsl:choose>
								<xsl:when test="ow:change/ow:by/@alias">
									<td align="left">
										<a>
											<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?<xsl:value-of select="ow:urlencode(string(ow:change/ow:by/@alias))"/></xsl:attribute>
											<xsl:value-of select="ow:change/ow:by/text()"/>
										</a>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<td align="left">
										<xsl:value-of select="ow:change/ow:by/@name"/>
									</td>
								</xsl:otherwise>
							</xsl:choose>
						</tr>
						<xsl:call-template name="summaryrecentchanges"/>
						<xsl:if test="ow:change/ow:comment">
							<tr class="rc">
								<td align="left" colspan="2">&#160;</td>
								<td align="left" colspan="2" class="comment">
									<xsl:value-of select="ow:change/ow:comment"/>
								</td>
							</tr>
						</xsl:if>
						<xsl:for-each select="ow:change/ow:attachmentchange">
							<tr class="rc">
								<td colspan="4">
									<xsl:apply-templates select="."/>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:for-each>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="ow:recentchanges_original">
		<ul>
			<xsl:for-each select="ow:page">
				<xsl:if test='not(substring-before(./preceding-sibling::*[position()=1]/ow:change/ow:date, "T") = substring-before(ow:change/ow:date, "T"))'>
					<xsl:text disable-output-escaping="yes">&lt;/ul&gt;</xsl:text>
					<b>
						<xsl:value-of select="ow:formatLongDate(string(ow:change/ow:date))"/>
					</b>
					<xsl:text disable-output-escaping="yes">&lt;ul&gt;</xsl:text>
				</xsl:if>
				<li>
					<xsl:value-of select="ow:formatTime(string(ow:change/ow:date))"/>
            -
            <a>
						<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?<xsl:value-of select="@name"/></xsl:attribute>
						<xsl:value-of select="ow:link/text()"/>
					</a>
					<xsl:if test="ow:change/@status='new'">
						<xsl:text> </xsl:text>
						<span class="new">new</span>
					</xsl:if>
					<xsl:text> </xsl:text>
					<xsl:if test="@changes > 1">
                (<a>
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="@name"/>&amp;a=diff</xsl:attribute>diff</a>)
                (<xsl:value-of select="@changes"/>&#160;<a>
							<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="@name"/>&amp;a=changes</xsl:attribute>changes</a>)
            </xsl:if>
					<xsl:if test="ow:change/ow:comment">
						<xsl:text> </xsl:text>
						<b>[<xsl:value-of select="ow:change/ow:comment"/>]</b>
					</xsl:if>
            . . . . . .
            <xsl:choose>
						<xsl:when test="ow:change/ow:by/@alias">
							<a>
								<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?<xsl:value-of select="ow:change/ow:by/@alias"/></xsl:attribute>
								<xsl:value-of select="ow:change/ow:by/text()"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="ow:change/ow:by/@name"/>
						</xsl:otherwise>
					</xsl:choose>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	<xsl:template match="ow:titleindex">
		<center>
			<xsl:for-each select="ow:page">
				<xsl:if test="not(substring(./preceding-sibling::*[position()=1]/@name, 1, 1) = substring(@name, 1, 1))">
					<a>
						<xsl:attribute name="href">#<xsl:value-of select="substring(@name, 1, 1)"/></xsl:attribute>
						<xsl:value-of select="substring(@name, 1, 1)"/>
					</a>
					<xsl:text> </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</center>
		<xsl:for-each select="ow:page">
			<xsl:if test="not(substring(./preceding-sibling::*[position()=1]/@name, 1, 1) = substring(@name, 1, 1))">
				<br/>
				<a>
					<xsl:attribute name="name"><xsl:value-of select="substring(@name, 1, 1)"/></xsl:attribute>
				</a>
				<b>
					<xsl:value-of select="substring(@name, 1, 1)"/>
				</b>
				<br/>
			</xsl:if>
			<xsl:apply-templates select="ow:link"/>
			<xsl:if test="/ow:wiki/ow:summary/@active='yes'">
				<xsl:if test="ow:change/ow:summary/text()">
					<!-- only display summary is there is one -->
					<small>
						<span style="color:#ff0000">
							<xsl:text> - </xsl:text>
							<xsl:value-of select="ow:change/ow:summary/text()"/>
						</span>
					</small>
				</xsl:if>
			</xsl:if>
			<xsl:if test="@hits">
                        - page views: <b>
					<xsl:value-of select="@hits"/>
				</b>
			</xsl:if>
			<br/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="ow:titlehitindex">
		<ol>
			<xsl:for-each select="ow:page">
				<li>
					<xsl:apply-templates select="ow:link"/>
					<xsl:if test="@hits">
						<b> (<xsl:value-of select="@hits"/>)</b>
					</xsl:if>
				</li>
			</xsl:for-each>
		</ol>
	</xsl:template>
	<xsl:template match="ow:wordindex">
		<center>
			<xsl:for-each select="ow:word">
				<xsl:if test="not(substring(./preceding-sibling::*[position()=1]/@value, 1, 1) = substring(@value, 1, 1))">
					<a>
						<xsl:attribute name="href">#<xsl:value-of select="substring(@value, 1, 1)"/></xsl:attribute>
						<xsl:value-of select="substring(@value, 1, 1)"/>
					</a>
				</xsl:if>
				<xsl:text> </xsl:text>
			</xsl:for-each>
		</center>
		<xsl:text disable-output-escaping="yes">&lt;ul&gt;</xsl:text>
		<xsl:for-each select="ow:word">
			<xsl:if test="not(substring(./preceding-sibling::*[position()=1]/@value, 1, 1) = substring(@value, 1, 1))">
				<xsl:text disable-output-escaping="yes">&lt;/ul&gt;</xsl:text>
				<a>
					<xsl:attribute name="name"><xsl:value-of select="substring(@value, 1, 1)"/></xsl:attribute>
				</a>
				<b>
					<xsl:value-of select="substring(@value, 1, 1)"/>
				</b>
				<xsl:text disable-output-escaping="yes">&lt;ul&gt;</xsl:text>
			</xsl:if>
			<xsl:if test="not(./preceding-sibling::*[position()=1]/@value = @value)">
				<xsl:text disable-output-escaping="yes">&lt;/ul&gt;</xsl:text>
				<b>
					<xsl:value-of select="@value"/>
				</b>
				<xsl:text disable-output-escaping="yes">&lt;ul&gt;</xsl:text>
			</xsl:if>
			<li>
				<xsl:apply-templates select="ow:page/ow:link"/>
			</li>
		</xsl:for-each>
		<xsl:text disable-output-escaping="yes">&lt;/ul&gt;</xsl:text>
	</xsl:template>
	<xsl:template match="ow:randompages">
		<xsl:choose>
			<xsl:when test="count(ow:page)=1">
				<xsl:apply-templates select="ow:page/ow:link"/>
			</xsl:when>
			<xsl:otherwise>
				<ul>
					<xsl:for-each select="ow:page">
						<li>
							<xsl:apply-templates select="ow:link"/>
						</li>
					</xsl:for-each>
				</ul>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- #TITLESEARCH -->
	<xsl:template match="ow:titlesearch">
		<ul>
			<xsl:for-each select="ow:page">
				<li>
					<xsl:if test="contains(@name, '/')">
            ....
        </xsl:if>
					<xsl:apply-templates select="ow:link"/>
            <xsl:if test="/ow:wiki/ow:summary/@active='yes'">
              <xsl:text> - </xsl:text>
              <small>
              <xsl:value-of select="ow:change/ow:summary/text()" />
              </small>
            </xsl:if>
        </li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	<!-- #CATEGORYSEARCH -->
	<xsl:template match="ow:categorysearch">
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
	<!-- #FULLSEARCH -->
	<xsl:template match="ow:fullsearch">
		<ul>
			<xsl:for-each select="ow:page">
				<li>
					<xsl:if test="contains(@name, '/')">
            ....
        </xsl:if>
					<xsl:apply-templates select="ow:link"/>
					<xsl:if test='$FullsearchHighlight = "1"'>
						<xsl:if test="string-length(../@value)>0">
							<xsl:text> </xsl:text>
							<small class="markerpentext">
								<a href="{ow:link/@href}{ow:link/@anchor}&amp;p=&amp;highlight={../@value}&amp;hido=1&amp;hiterm={../@value}" title="Highlight: {../@value}">
									<xsl:text>H</xsl:text>
								</a>
							</small>
						</xsl:if>
					</xsl:if>
          <xsl:if test="/ow:wiki/ow:summary/@active='yes'">
            <xsl:text> - </xsl:text>
            <small>
              <xsl:value-of select="ow:change/ow:summary/text()" />
            </small>
          </xsl:if>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	<!-- #TEXTSEARCH -->
	<xsl:template match="ow:textsearch">
		<ul>
			<xsl:for-each select="ow:page">
				<li>
					<xsl:if test="contains(@name, '/')">
            ....
        </xsl:if>
					<xsl:apply-templates select="ow:link"/>
					<xsl:if test='$FullsearchHighlight = "1"'>
						<xsl:if test="string-length(../@value)>0">
							<xsl:text> </xsl:text>
							<small class="markerpentext">
								<a href="{ow:link/@href}{ow:link/@anchor}&amp;p=&amp;highlight={../@value}&amp;hido=1&amp;hiterm={../@value}" title="Highlight: {../@value}">
									<xsl:text>H</xsl:text>
								</a>
							</small>
						</xsl:if>
					</xsl:if>
					<xsl:text> - </xsl:text>
					<small>
            <xsl:if test="/ow:wiki/ow:summary/@active='yes'">
              <xsl:value-of select="ow:change/ow:summary/text()" />
            </xsl:if>
					</small>					
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	<xsl:template match="ow:month">
		<xsl:if test="/ow:wiki/@mode='view'">
			<table border="0" bgcolor="#000000" cellspacing="1" cellpadding="2">
				<tr bgcolor="#DDDDDD">
					<td colspan="7" align="center">
						<b>
							<xsl:value-of select="@title"/>
						</b>
					</td>
				</tr>
				<tr bgcolor="#CCCCCC">
					<td>Sun</td>
					<td>Mon</td>
					<td>Tue</td>
					<td>Wed</td>
					<td>Thu</td>
					<td>Fri</td>
					<td>Sat</td>
				</tr>
				<xsl:apply-templates/>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template match="ow:week">
		<tr bgcolor="#EEEEEE">
			<xsl:apply-templates/>
		</tr>
	</xsl:template>
	<xsl:template match="ow:day">
		<td>
			<xsl:apply-templates/>
		</td>
	</xsl:template>
	<xsl:template match="ow:message">
		<xsl:if test="@code='userpreferences_saved'">
			<b>User preferences saved successfully.</b>
		</xsl:if>
		<xsl:if test="@code='userpreferences_cleared'">
			<b>User preferences cleared successfully.</b>
		</xsl:if>
		<xsl:if test="@code='userpreferences_blankpassword'">
			<b>You cannot use a blank password.  Please try again..</b>
		</xsl:if>
	</xsl:template>
	<xsl:template match="ow:userpreferences">
		<form name="f" method="post">
			<xsl:attribute name="action"><xsl:value-of select="/ow:wiki/ow:scriptname"/></xsl:attribute>
			<table>
				<tr>
					<td>Username:</td>
					<td>
						<input type="text" name="username" ondblclick="event.cancelBubble=true;">
							<xsl:attribute name="value"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:username"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>Password:</td>
					<td>
						<input type="password" name="userpassword" ondblclick="event.cancelBubble=true;">
							<xsl:attribute name="value"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:userpassword"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td>Preferred Skin:</td>
					<td>
						<SELECT name="skin" ondblclick="event.cancelBubble=true;">
							<xsl:for-each select="/ow:wiki/ow:availableskins/ow:skin">
								<xsl:sort select="@name" order="ascending"/>
								<OPTION>
									<xsl:attribute name="name">opt</xsl:attribute>
									<xsl:attribute name="value"><xsl:value-of select="@name"/></xsl:attribute>
									<xsl:if test="(/ow:wiki/ow:userpreferences/ow:userskin=@name)">
										<xsl:attribute name="selected">1</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="@name"/>
								</OPTION>
							</xsl:for-each>
						</SELECT>
						<!-- OLD TEXTBOX CODE
                                                <input type="text" name="skin" ondblclick="event.cancelBubble=true;">
                                                        <xsl:attribute name="value"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:userskin"/></xsl:attribute>
                                                </input>
-->
					</td>
				</tr>
				<tr>
					<td>Bookmarks:</td>
					<td>
						<input type="text" name="bookmarks" size="60" ondblclick="event.cancelBubble=true;">
							<xsl:attribute name="value"><xsl:for-each select="/ow:wiki/ow:userpreferences/ow:bookmarks/ow:link"><xsl:value-of select="@name"/><xsl:text> </xsl:text></xsl:for-each></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td colspan="2">Edit form columns: <input type="text" name="cols" size="3" ondblclick="event.cancelBubble=true;">
							<xsl:attribute name="value"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:cols"/></xsl:attribute>
						</input> rows: <input type="text" name="rows" size="3" ondblclick="event.cancelBubble=true;">
							<xsl:attribute name="value"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:rows"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="checkbox" name="prettywikilinks" value="1">
							<xsl:if test="/ow:wiki/ow:userpreferences/ow:prettywikilinks">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
            Show pretty wiki links
          </td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="checkbox" name="bookmarksontop" value="1">
							<xsl:if test="/ow:wiki/ow:userpreferences/ow:bookmarksontop">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
            Show bookmarks on top
          </td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="checkbox" name="editlinkontop" value="1">
							<xsl:if test="/ow:wiki/ow:userpreferences/ow:editlinkontop">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
            Show edit link on top
          </td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="checkbox" name="trailontop" value="1">
							<xsl:if test="/ow:wiki/ow:userpreferences/ow:trailontop">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
            Show trail on top
          </td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="checkbox" name="opennew" value="1">
							<xsl:if test="/ow:wiki/ow:userpreferences/ow:opennew">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
            Open external links in new window
          </td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="checkbox" name="emoticons" value="1">
							<xsl:if test="/ow:wiki/ow:userpreferences/ow:emoticons">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
            Show emoticons in text <small>(goto <a href="?HelpOnEmoticons">HelpOnEmoticons</a>)</small>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" name="save" value="Save Preferences"/>
            &#160;&#160;
            <input type="submit" name="clear" value="Clear Preferences"/>
					</td>
				</tr>
			</table>
			<input type="hidden" name="p">
				<xsl:attribute name="value"><xsl:value-of select="/ow:wiki/ow:page/@name"/></xsl:attribute>
			</input>
			<input type="hidden" name="a" value="userpreferences"/>
		</form>
	</xsl:template>
	<!--
 Code by PerNilson
  A 200 pts wide progressbar filled 30%:<br>
  <ProgressBar(200,30)>
-->
	<xsl:template match="ow:progressbar">
		<table border="1" cellpadding="0" cellspacing="0">
			<xsl:attribute name="width"><xsl:value-of select="@pbWidth"/></xsl:attribute>
			<tr>
				<td height="10" bgColor="#0000ff">
					<xsl:attribute name="width"><xsl:value-of select="@pbPercent"/>%</xsl:attribute>
				</td>
				<xsl:if test="@pbPercentLeft!=0">
					<td height="10" bgColor="#ffffff">
						<xsl:attribute name="width"><xsl:value-of select="@pbPercentLeft"/>%</xsl:attribute>
					</td>
				</xsl:if>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="/ow:wiki" mode="rename">
		<table width="100%" border="{$Showborders}" height="100%">
			<tr>
				<td align="center" valign="center">
					<h2>Renaming <b>
							<xsl:value-of select="ow:rename/@page"/>
						</b>
					</h2>
					<table border="{$Showborders}" cellspacing="0" cellpadding="70" bgcolor="#eeeeee">
						<tr>
							<td>
								<xsl:apply-templates select="ow:error"/>
								<table border="{$Showborders}">
								<FIELDSET STYLE="padding-left=5;padding-top=10;padding-bottom=20;" LANG="en" TITLE="Rename Page Form">
										<form name="renameform" method="post" action="{/ow:wiki/ow:scriptname}?p={ow:rename/@page}&amp;a=rename&amp;step=process">
										<tr>
											<td>
												<a href="{/ow:wiki/ow:scriptname}?p={ow:rename/@page}">
                                                                                                Return to <xsl:value-of select="ow:rename/@page"/>
												</a>
											</td>
											<td>
												<xsl:text> </xsl:text>
											</td>
										</tr>
										<tr>
											<td align="right">Rename <xsl:value-of select="ow:rename/@page"/> to: </td>
											<td>
												<input type="text" name="newName" value="{ow:rename/@page}" size="30"/>
											</td>
										</tr>
										<tr>
											<td>
												<xsl:text> </xsl:text>
											</td>
											<td>
											<i>
											<ul>
											<li>You can only rename one page at once</li>
											<li>System pages can only be renamed in the config file</li>
											</ul>
											</i>
											</td>
										</tr>
										<tr>
											<td>
												<xsl:text> </xsl:text>
											</td>
											<td>
												<input type="submit" name="submit" value="Rename"/>
												<xsl:text> </xsl:text>
												<input type="submit" name="cancel" value="Cancel"/>
											</td>
										</tr>
										<tr>
											<td>
												<xsl:text> </xsl:text>
                                                                                        </td>
											<td>
												<hr/>
	                                                                                        <input type="checkbox" name="renamelinks"/>
												<xsl:text> </xsl:text>Rename links to the new page name in <b>all</b> other pages?
												<br/><span class="redtext"><b>WARNING!</b> this is a radical action and could take a long time</span>
	                                                                                        <hr/><input type="checkbox" name="searchhardcodedpages"/>
												<xsl:text> </xsl:text>Also change links in hard-coded (system) pages?
												<br/><i>(This option has no effect unless the 'rename links' option is checked)</i>
												<hr/>
											</td>
										</tr>
									</form>
									</FIELDSET>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>
