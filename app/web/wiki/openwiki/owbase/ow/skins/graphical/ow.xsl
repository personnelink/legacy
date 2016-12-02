<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- 
$Log: ow.xsl,v $
Revision 1.28  2004/10/21 21:47:17  gbamber
Moved rename template to ow_common.xsl

Revision 1.27  2004/10/06 09:58:28  gbamber
CategorySearch fixed

Revision 1.26  2004/09/02 19:18:30  gbamber
Added <TitleCategoryIndex> macro

Revision 1.25  2004/08/30 12:45:10  sansei
Added sEimantics (cleanslash)

Revision 1.24  2004/08/26 19:59:39  gbamber
Kludge for print view added

Revision 1.23  2004/08/26 00:42:14  sansei
(fixed a minor bug)

Revision 1.22  2004/08/25 21:45:02  sansei
removed debugcode from last revision (sorry)

Revision 1.21  2004/08/25 21:10:13  sansei
optimizing page bookmarks (skin: graphical)

Revision 1.20  2004/08/25 10:54:24  gbamber
Cleaned up syntax for <addboomarks> display

Revision 1.19  2004/08/24 22:44:14  gbamber
Improved XSL for PageBookmarks

Revision 1.18  2004/08/24 18:38:02  gbamber
<AddBookmarks()>

Revision 1.17  2004/08/22 20:17:58  sansei
Fixed 'reappeared' bookmarks in top and bottom bug

Revision 1.16  2004/08/22 17:27:32  sansei
Optimized skinning procedure

Revision 1.6  2004/08/16 23:29:02  gbamber
Fixed Page Views.
Fixed Diff
Added Revisions
Added Edited By

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
	<xsl:include href="../common/ow_common.xsl"/>
	<xsl:include href="myPageBody.xsl"/>
	<xsl:include href="../common/owinc.xsl"/>
	<xsl:include href="../common/owplugins.xsl"/>
	<xsl:include href="owattach.xsl"/>
	<xsl:include href="mystyle.xsl"/>
	<xsl:template match="/ow:wiki">
		<xsl:call-template name="pi"/>
		<html>
			<xsl:call-template name="head"/>
			<xsl:call-template name="pagebody"/>
		</html>
	</xsl:template>

	<xsl:template match="ow:categoryindex">
	Not Implemented in this skin
	</xsl:template>
	
	<xsl:template name="regionheader">
		<table width="100%" height="100%">
			<tr>
				<td style="padding-left:10px">
					<xsl:call-template name="brandingImage"/>
				</td>
				<td align="right">
					<xsl:call-template name="searchbox"/>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template name="regionfooter">
	</xsl:template>
	<xsl:template name="bookmarksbullets">
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
					<td valign="top" height="18" width="100%">
						<a href="{@href}">
							<xsl:value-of select="text()"/>
						</a>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
			<br/>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" height="18" colspan="2">
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
								<td valign="top" height="18" width="100%">
									<a href="{@href}">
										<xsl:call-template name="cleanslash">
											<xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
											<xsl:with-param name="thetext" select="string(text())"/>
										</xsl:call-template>
									</a>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template name="regionleft">
		<table height="100%" width="100%">
			<tr>
				<td height="*" valign="top">
					<xsl:if test="not(/ow:wiki/ow:userpreferences/ow:bookmarks='None')">
						<!-- <xsl:apply-templates select="/ow:wiki/ow:userpreferences/ow:bookmarks"/> -->
						<xsl:call-template name="bookmarksbullets"/>
					</xsl:if>
					<hr noshade="noshade" size="1"/>
					<a class="same">
						<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="@revision">&amp;revision=<xsl:value-of select="@revision"/></xsl:if></xsl:attribute>Edit</a> this page
						<xsl:if test="not(@changes='0')">
						<br/>
						<font size="-2">(last edited <xsl:value-of select="ow:formatLongDate(string(ow:page/ow:change/ow:date))"/>)</font>
					</xsl:if>
				</td>
			</tr>
			<tr>
				<td height="125" valign="bottom">
					<xsl:call-template name="validatorButtons"/>
					<br/>
					<p align="center">
						<xsl:call-template name="poweredBy"/>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template name="regioncenter">
		<xsl:if test="ow:userpreferences/ow:trailontop">
			<xsl:apply-templates select="ow:trail"/>
		</xsl:if>
		<table class="regionCenterWrapper" height="*">
			<xsl:attribute name="ondblclick">location.href='<xsl:value-of select="ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="ow:page/@revision">&amp;revision=<xsl:value-of select="ow:page/@revision"/></xsl:if>'</xsl:attribute>
			<tr>
				<td height="*" valign="top" style="padding-bottom:5px">
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
						<xsl:when test="@mode='categorysearch'">
							<xsl:apply-templates select="." mode="categorysearch"/>
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
				</td>
			</tr>
			<tr>
				<td height="85" valign="bottom">
					<hr noshade="noshade" size="1"/>
					<table cellspacing="0" cellpadding="0" border="0" width="100%">
						<tr>
							<td align="left" class="n">
								<a class="functions">
									<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="@revision">&amp;revision=<xsl:value-of select="@revision"/></xsl:if></xsl:attribute>Edit <xsl:if test="@revision">revision <xsl:value-of select="@revision"/> of</xsl:if> this page</a>
								<!-- Added for rename capability -->
							| <a class="functions">
									<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=rename&amp;step=first</xsl:attribute>Rename this page</a>
								<xsl:if test="ow:page/ow:change/@revision or (ow:page/ow:change and not(ow:page/ow:change/@revision = 1))">
							|
							<a class="functions">
										<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=changes</xsl:attribute>View other revisions</a>
								</xsl:if>
								<xsl:if test="not(ow:page/ow:change/@revision=ow:page/@changes)">
							|
							<a class="functions">
										<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>View current revision</a>
								</xsl:if>
								<xsl:if test="/ow:wiki/ow:allowattachments">
							|
							<a class="functions">
										<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=attach</xsl:attribute>Attachments</a> (<xsl:value-of select="count(ow:page/ow:attachments/ow:attachment[@deprecated='false'])"/>)
							</xsl:if>
							</td>
						</tr>
						<tr>
							<td align="left" class="n">
								<xsl:choose>
									<xsl:when test="@mode='print'">
										<a class="functions">
											<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/></xsl:attribute>
											<strong>Exit print view</strong>
										</a>
									</xsl:when>
									<xsl:otherwise>
										<a class="functions">
											<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=print&amp;revision=<xsl:value-of select="ow:change/@revision"/></xsl:attribute>Print this page</a>
									</xsl:otherwise>
								</xsl:choose>
								|
								<a class="functions">
									<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=xml&amp;revision=<xsl:value-of select="ow:change/@revision"/></xsl:attribute>View XML</a>
								<!-- START HITS CODE -->
								<xsl:if test="ow:page/@hits">
								| Page views: <b>
										<xsl:value-of select="ow:page/@hits"/>
									</b>
								</xsl:if>
								<!-- END HITS CODE -->
								<br/>
								<a class="functions">
									<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=FindPage&amp;txt=<xsl:value-of select="$name"/></xsl:attribute>Find page</a> by browsing, searching or an index
								<xsl:if test="not(ow:page/@changes='0')">
								| Page Revisions: <b>
										<xsl:value-of select="ow:page/@changes"/>
									</b>
									<br/>
								Last Edited <xsl:value-of select="ow:formatLongDate(string(ow:page/ow:change/ow:date))"/>
									<xsl:text> </xsl:text>
									<xsl:if test="ow:page/ow:change/ow:by/@alias">
									by <xsl:value-of select="ow:page/ow:change/ow:by/@alias"/>
										<xsl:text> </xsl:text>
									</xsl:if>
									<a class="functions">
										<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/><xsl:if test="ow:page/ow:change/@revision">&amp;difffrom=<xsl:value-of select="ow:page/ow:change/@revision - 1"/></xsl:if>&amp;a=diff</xsl:attribute>(diff)</a>
									<br/>
								</xsl:if>
							</td>
							<td align="right">
			            
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

            w.document.forms[0].elements['text'].value = window.document.forms["frmEdit"].elements['text'].value;
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
                        window.document.forms["frmEdit"].elements['save'][0].click();
                        evt.returnValue = false;
                }
        }

        function theTextAreaValue() {
            return window.document.forms["frmEdit"].elements['text'].value;
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
        function cancelEdit(v){
			window.location = v;
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
        <input type="button" name="cancel" value="Cancel" onClick="javascript:cancelEdit('{/ow:wiki/ow:scriptname}?p={$name}');"/>
			<!-- START AUTODEPRECATE CODE -->
        &#160;
        <input type="checkbox" name="deprecate" value="0"/> Deprecate this Page
		<!-- END AUTODEPRECATE CODE -->
			<!-- START CATEGORIES CODE -->
        &#160;
        <select name="categories">
				<option name="copt" value="0">
					<xsl:if test="ow:page/@category=0">
						<xsl:attribute name="selected"/>
					</xsl:if>Normal</option>
				<option name="copt" value="1">
					<xsl:if test="ow:page/@category=1">
						<xsl:attribute name="selected"/>
					</xsl:if>Restore Me</option>
				<option name="copt" value="2">
					<xsl:if test="ow:page/@category=2">
						<xsl:attribute name="selected"/>
					</xsl:if>Please Comment</option>
				<option name="copt" value="3">
					<xsl:if test="ow:page/@category=3">
						<xsl:attribute name="selected"/>
					</xsl:if>Answer Me</option>
				<option name="copt" value="4">
					<xsl:if test="ow:page/@category=4">
						<xsl:attribute name="selected"/>
					</xsl:if>Refactor Me</option>
				<option name="copt" value="5">
					<xsl:if test="ow:page/@category=5">
						<xsl:attribute name="selected"/>
					</xsl:if>Delete Me</option>
			</select>
			<!-- END CATEGORIES CODE -->
			<br/>
			<br/>
			<xsl:if test="ow:page/@wysiwyg='1'">
				<xsl:call-template name="ow:wysiwyg"/>
			</xsl:if>
			<textarea id="text" name="text" wrap="virtual" onfocus="saveText(this.value)" onkeydown="CheckTab(this);saveDocumentCheck(event);">
				<xsl:attribute name="rows"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:rows"/></xsl:attribute>
				<xsl:attribute name="cols"><xsl:value-of select="/ow:wiki/ow:userpreferences/ow:cols"/></xsl:attribute>
				<xsl:value-of select="ow:page/ow:raw/text()"/>
			</textarea>
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
        <input type="button" name="cancel" value="Cancel" onClick="javascript:cancelEdit('{/ow:wiki/ow:scriptname}?p={$name}');"/>
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
	<xsl:template name="regionright">

</xsl:template>
	<xsl:template match="/ow:wiki" mode="view">
		<xsl:variable name="shorttitle">
			<xsl:call-template name="cleanslash">
				<xsl:with-param name="runmode" select="string($title_cleanslash)"/>
				<xsl:with-param name="thetext" select="string(ow:page/ow:link/text())"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="shortname">
			<xsl:call-template name="cleanslash">
				<xsl:with-param name="runmode" select="string($title_cleanslash)"/>
				<xsl:with-param name="thetext" select="string($name)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$title_cleanslash &gt; 0">
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
	<xsl:template match="ow:page">
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
		<xsl:if test="/ow:wiki/ow:userpreferences/ow:editlinkontop">
			<!--a class="same"><xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="$name"/>&amp;a=edit<xsl:if test="@revision">&amp;revision=<xsl:value-of select="@revision"/></xsl:if></xsl:attribute>Edit</a> this page
        <xsl:if test="not(@changes='0')">
            <font size="-2">(last edited <xsl:value-of select="ow:formatLongDate(string(ow:change/ow:date))"/>)</font>
        </xsl:if>
        <br /-->
		</xsl:if>
		<xsl:if test="../ow:redirectedfrom">
			<b>Redirected from <a title="Edit this page">
					<xsl:attribute name="href"><xsl:value-of select="/ow:wiki/ow:scriptname"/>?a=edit&amp;p=<xsl:value-of select="ow:urlencode(string(../ow:redirectedfrom/@name))"/></xsl:attribute>
					<xsl:value-of select="../ow:redirectedfrom/text()"/>
				</a>
			</b>
			<p/>
		</xsl:if>
		<xsl:if test="ow:page/@revision">
			<b>Showing revision <xsl:value-of select="ow:page/@revision"/>
			</b>
		</xsl:if>
		<xsl:apply-templates select="ow:body"/>
	</xsl:template>
	<!-- #### Is somehow the pagebody design-->
	<xsl:template match="/ow:wiki" mode="diff">
		<h1>
			<a class="same" href="{ow:scriptname}?a=fullsearch&amp;txt={$name}&amp;fromtitle=true" title="Do a full text search for {ow:page/ow:link/text()}">
				<xsl:value-of select="ow:page/ow:link/text()"/>
			</a>
		</h1>
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
	</xsl:template>
	<xsl:template match="ow:wiki" mode="changes">
		<h1>History of "<xsl:value-of select="ow:page/ow:link/text()"/>"</h1>
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
	</xsl:template>
	<xsl:template match="/ow:wiki" mode="titlesearch">
		<h1>Title search for "<xsl:value-of select="ow:titlesearch/@value"/>"</h1>
		<hr size="1"/>
		<xsl:apply-templates select="ow:titlesearch"/>
		<xsl:value-of select="count(ow:titlesearch/ow:page)"/> hits out of
    <xsl:value-of select="ow:titlesearch/@pagecount"/> pages searched.

    </xsl:template>
	<xsl:template match="/ow:wiki" mode="fullsearch">
		<h1>Full text search for "<xsl:value-of select="ow:fullsearch/@value"/>"</h1>
		<hr size="1"/>
		<xsl:apply-templates select="ow:fullsearch"/>
		<xsl:value-of select="count(ow:fullsearch/ow:page)"/> hits out of
    <xsl:value-of select="ow:fullsearch/@pagecount"/> pages searched.

    </xsl:template>
	<!-- ####-->
	<!-- ==================== bookmarks from the user preferences ==================== -->
	<xsl:template match="ow:bookmarks">
		<xsl:for-each select="ow:link">
			<a class="bookmarks" href="{@href}">
				<xsl:value-of select="text()"/>
			</a>
			<xsl:if test="not(position()=last())"> | </xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- ==================== the trail, the last visited wiki pages ==================== -->
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
			<hr noshade="noshade" size="1"/>
		</xsl:if>
	</xsl:template>
	<!-- ==================== actual body of a page ==================== -->
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
		<xsl:apply-templates select="text() | *"/>
		<xsl:apply-templates select="../ow:attachments">
			<xsl:with-param name="showhidden">false</xsl:with-param>
			<xsl:with-param name="showactions">false</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<!-- ==================== templates one can use to create a new page ==================== -->
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
	<!-- ==================== template one can use to create a new page ==================== -->
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
	<xsl:template match="/ow:wiki" mode="login">
		<!--body bgcolor="#ffffff" onload="this.document.f.pwd.focus();"-->
		<table width="100%" height="100%">
			<tr>
				<td align="center" valign="center">
					<table border="0" cellspacing="0" cellpadding="70" bgcolor="#eeeeee">
						<tr>
							<td>
								<xsl:if test="ow:login/@mode='edit'">
									<b>Enter password to edit content</b>
									<br/>
									<br/>
								</xsl:if>
								<xsl:apply-templates select="ow:error"/>
								<table>
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
</xsl:stylesheet>
