<?xml version="1.0" encoding="utf-8"?>
<!--
~~~~~~ Evolution skin #EDIT MODE ~~~~~~

$Log: editor.xsl,v $
Revision 1.3  2007/02/02 02:39:39  piixiiees
Upgrade to tags in evolution

Revision 1.2  2007/01/07 11:24:40  piixiiees
gFS=Chr(222) due to problems working with Chr(179) in utf-8 and some files saved with encoding="utf-8"

Revision 1.1  2006/04/20 01:00:26  piixiiees
Temporary copy of skins/common/*.* to evolution skin to be able to modify the structure of the skin without impacting to other skins.
New style of BrogressBar; now printable.
New file macros.xsl to include the templates for the macros.

Revision 1.1  2006/03/22 01:46:47  piixiiees
- Small bugfix with the command Edit (link on top) when editing old revisions. Remove of blanks in the URL. Skins affected plastic and evolution.
- Extract the editing layout from the ow.xsl to a dedicated file editor.xsl


-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
  xmlns:ow="http://openwiki.com/2001/OW/Wiki" 
  xmlns="http://www.w3.org/1999/xhtml" 
  extension-element-prefixes="msxsl ow" 
  exclude-result-prefixes="" version="1.0">

  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <!-- VARIABLES -->
  
  <!-- TEMPLATES -->  
  <!-- Editor template __________________________________________ -->

  <xsl:template name="editor">
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

    <h1>
      Editing <xsl:if test="ow:page/@revision">
        revision <xsl:value-of select="ow:page/@revision"/> of
      </xsl:if>
      <xsl:value-of select="ow:page/@name"/>
    </h1>
    <!--
    <hr size="1"/>
    <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=Help" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=Help&amp;a=print'); return false;">Help</a>
    <a class="helpon" href="{/ow:wiki/ow:scriptname}?p=Help" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=Help&amp;a=print'); return false;">
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
    -->
    <xsl:if test="ow:page/@revision">
      <b>
        Editing old revision <xsl:value-of select="ow:page/@revision"/>. Saving this page will replace the latest revision with this text.
      </b>
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
      <xsl:attribute name="action">
        <xsl:value-of select="/ow:wiki/ow:scriptname"/>?a=edit#preview
      </xsl:attribute>
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
      
      <!-- Precis input text. Template included in summaries.xsl -->
      <xsl:call-template name="summaryeditdisplay" />
      
      <!-- WYSIWYG toolbar -->
      <xsl:if test="ow:page/@wysiwyg='1'">
        <xsl:call-template name="ow:wysiwyg"/>
      </xsl:if>
      <!-- Text editing window -->
      <textarea id="text" name="text" wrap="virtual" onfocus="saveText(this.value)" onkeydown="CheckTab(this);saveDocumentCheck(event);" ondblclick="event.cancelBubble=true;">
        <xsl:attribute name="rows">
          <xsl:value-of select="/ow:wiki/ow:userpreferences/ow:rows"/>
        </xsl:attribute>
        <xsl:attribute name="cols">
          <xsl:value-of select="/ow:wiki/ow:userpreferences/ow:cols"/>
        </xsl:attribute>
        <xsl:attribute name="style">font-family: monospace</xsl:attribute>
        <xsl:value-of select="ow:page/ow:raw/text()"/>
      </textarea>

      <!-- #tag  START added by 1mmm# -->
      <br/><xsl:call-template name="tag_edit"/>
      <!-- #tag  END# -->
      
      <br/>
      <!-- Include in Recent Changes checkbox -->
      <input type="checkbox" name="rc" value="1">
        <xsl:if test="ow:page/ow:change/@minor='false' and not(starts-with(ow:page/ow:raw/text(), '#MINOREDIT'))">
          <xsl:attribute name="checked">checked</xsl:attribute>
        </xsl:if>
      </input>
      Include page in
      <a href="{/ow:wiki/ow:scriptname}?p=RecentChanges" onclick="javascript:openw('{/ow:wiki/ow:scriptname}?p=RecentChanges&amp;a=print'); return false;">Recent Changes</a>
      <img src="{/ow:wiki/ow:skinpath}/images/wiki-http.gif" border="0" hspace="4="/>
      list.
      <!-- Comment text -->
      <br/>Optional comment about this change:
      <br/>
      <input type="text" name="comment" style="color:#333333;" maxlength="1000">
        <xsl:attribute name="size">
          <xsl:value-of select="/ow:wiki/ow:userpreferences/ow:cols"/>
        </xsl:attribute>
        <xsl:attribute name="value">
          <xsl:value-of select="ow:page/ow:change/ow:comment/text()"/>
        </xsl:attribute>
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
      <br/>
      <br/>
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
  <!-- _____________________________________________________________ -->

</xsl:stylesheet>

