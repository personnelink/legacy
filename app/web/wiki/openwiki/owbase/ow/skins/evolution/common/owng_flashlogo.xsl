<?xml version="1.0" encoding="utf-8"?>
<!-- edited with XMLSPY v5 rel. 4 U (http://www.xmlspy.com) by abc (abc) -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
	<xsl:template name="FlashLogoSimple">
		<xsl:variable name="FlashLogoPath">
			<xsl:text>ow/flash/owng_logo.swf?SiteName=</xsl:text>
			<xsl:value-of select="//ow:wiki/ow:title"/>
			<xsl:text>&amp;myUrl=ow.asp?</xsl:text>
			<xsl:value-of select="//ow:wiki/ow:frontpage/@name"/>
			<xsl:text>&amp;PageName=</xsl:text>
			<xsl:value-of select="//ow:wiki/ow:page/@name"/>
			<xsl:text>&amp;username=</xsl:text>
			<xsl:value-of select="//ow:wiki/ow:userpreferences/ow:username"/>
			<xsl:text>&amp;ACount=</xsl:text>
			<xsl:value-of select="count(//ow:attachments/ow:attachment[@deprecated='false'])"/>
			<xsl:text>&amp;owbuild=</xsl:text>
			<xsl:value-of select="//ow:wiki/ow:build"/>
		</xsl:variable>
		<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" width="112" height="42" id="owng_logo" align="middle">
			<param name="allowScriptAccess" value="sameDomain"/>
			<param name="movie">
				<xsl:attribute name="value"><xsl:value-of select="$FlashLogoPath"/></xsl:attribute>
			</param>
			<param name="quality" value="high"/>
			<param name="wmode" value="transparent"/>
			<param name="bgcolor" value="#18255c"/>
			<embed quality="high" wmode="transparent" bgcolor="#18255c" width="112" height="42" name="owng_logo" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
				<xsl:attribute name="src"><xsl:value-of select="$FlashLogoPath"/></xsl:attribute>
			</embed>
		</object>
	</xsl:template>
	<xsl:template name="FlashLogoAdvanced">
		<xsl:variable name="FlashLogoPath">
			<xsl:text>ow/flash/ADVANCED_owng_logo.swf?SiteName=</xsl:text>
			<xsl:value-of select="//ow:wiki/ow:title"/>
			<xsl:text>&amp;myUrl=ow.asp?</xsl:text>
			<xsl:value-of select="//ow:wiki/ow:frontpage/@name"/>
			<xsl:text>&amp;PageName=</xsl:text>
			<xsl:value-of select="//ow:wiki/ow:page/@name"/>
			<xsl:text>&amp;username=</xsl:text>
			<xsl:value-of select="//ow:wiki/ow:userpreferences/ow:username"/>
			<xsl:text>&amp;ACount=</xsl:text>
			<xsl:value-of select="count(//ow:attachments/ow:attachment[@deprecated='false'])"/>
			<xsl:text>&amp;owbuild=</xsl:text>
			<xsl:value-of select="//ow:wiki/ow:build"/>
		</xsl:variable>
		<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" width="112" height="42" id="owng_logo" align="middle">
			<param name="allowScriptAccess" value="sameDomain"/>
			<param name="movie">
				<xsl:attribute name="value"><xsl:value-of select="$FlashLogoPath"/></xsl:attribute>
			</param>
			<param name="quality" value="high"/>
			<param name="wmode" value="transparent"/>
			<param name="bgcolor" value="#18255c"/>
			<embed quality="high" wmode="transparent" bgcolor="#18255c" width="112" height="42" name="owng_logo" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
				<xsl:attribute name="src"><xsl:value-of select="$FlashLogoPath"/></xsl:attribute>
			</embed>
		</object>
	</xsl:template>
</xsl:stylesheet>
