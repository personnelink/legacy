<?xml version="1.0" encoding="UTF-8"?>
<!-- Style RSS so that it is readable. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:domain="https://ninjacoder.net/rss/" version="1.0">
  <xsl:output method="html"/>
  <xsl:template match="/rss/channel">
    <xsl:variable name="description" select="description"/>
<html>
	<head>
		<title>RSS Feed</title>			
    <script type="text/javascript">
      // Fix for browsers that don't support disable-output-escaping
      
      function decode_xml_doey_fix() {
        if (!document.getElementById || !document.getElementsByName) // Needed bits of DOM present?
          return;
        var testDiv = document.getElementById("doey_test");
        if (!testDiv || !('textContent' in testDiv))                 // Test value on the page?
          return;
        var testText = testDiv.textContent;
        if (!testText || testText == '' || testText == '\x26')       // Is decoding needed?
          return;
        var decodeElems = document.getElementsByName('doey_decode');
        if (!decodeElems || decodeElems.length == 0 || !("innerHTML" in decodeElems[0]) || !("textContent" in decodeElems[0]))
          return;
        for (var i = decodeElems.length - 1; i >= 0; i--)
          decodeElems[i].innerHTML = decodeElems[i].textContent;
      }
    </script>
    <link rel="alternate" type="application/rss+xml" title="{title}" href="{link}" />
		<style type="text/css">
			body { margin: 2.5em; font-family: Segoe UI, Arial, sans-serif; font-size: 80%; line-height: 1.45em; } 
      table { font-size: 100%; }
      .indent { margin-left: 1.25em; }
			.heading { font-family: Cambria, Georgia, serif; font-weight: bold; color: #000099; font-size: 180%; padding-top: 0.25em; margin-top: 2em; border-top: solid 3px #ccccee; }
			.title { font-family: Cambria, Georgia, serif; font-weight: bold; color: darkred; font-size: 160%; padding-top: 0.25em; margin-top: 2em; border-top: solid 3px #ccccee; }

		</style>
	</head>
	<body onload="decode_xml_doey_fix();">
    <div id="doey_test" style="display: none"><xsl:text disable-output-escaping="yes">&amp;amp;</xsl:text></div>
    <p class="heading">RSS Information</p>
    <p class="indent">
      You are viewing the RSS feed for: <strong name="doey_decode"><xsl:value-of select="title" disable-output-escaping="yes"/></strong>. <br />
      <strong>Subscribe your news reader to <a href="{link}"><xsl:value-of select="link"/></a> </strong>
<br /><br />
      WikiAsp RSS 2.0 generator by Elrey Ronald Vel.
    </p>
	  <p class="heading">Feed Description</p>
	  <p class="indent" name="doey_decode"><xsl:value-of select="description" disable-output-escaping="yes"/></p>
    <p class="heading">Feed Items</p>
    <xsl:choose>
      <xsl:when test="item"><xsl:apply-templates select="item"/></xsl:when>
      <xsl:otherwise><div class="indent">There are no entries in this RSS feed yet.</div></xsl:otherwise>
    </xsl:choose>
	</body>
</html>
  </xsl:template>
  <xsl:template match="item">
    <div class="indent" style="margin-bottom: 2em;">
      <hr style="color: silver;background-color: silver;height: 9px;" />
      <p>
        <table cellpadding="0" cellspacing="0" border="0">
          <tr>
            <td><strong>Title: </strong></td>
            <td width="10px"></td>
            <td><a class="title" href="{link}" name="doey_decode"><xsl:value-of select="title" disable-output-escaping="yes"/></a></td>
          </tr>
          <tr>
            <td><strong>Author: </strong></td>
            <td width="10px"></td>
            <td><span name="doey_decode"><xsl:value-of select="author"/></span></td>
          </tr>
          <tr>
            <td><strong>Date: </strong></td>
            <td width="10px"></td>
            <td><xsl:value-of select="pubDate"/></td>
          </tr>
        </table>
      </p>
      <div class="indent" name="doey_decode"><xsl:value-of select="description" disable-output-escaping="yes"/></div>
    </div>
  </xsl:template>
  <xsl:template match="category">
		<xsl:value-of select="."/> |  
  </xsl:template>
</xsl:stylesheet>