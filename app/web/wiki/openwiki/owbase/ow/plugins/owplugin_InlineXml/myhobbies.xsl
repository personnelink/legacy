<?xml version="1.0"?>
<!-- edited with XMLSPY v5 rel. 4 U (http://www.xmlspy.com) by abc (abc) -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns="http://www.w3.org/TR/REC-html40">
	<xsl:output method="html" indent="no"/>
	<xsl:template match="/">
		<span>
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="doc">
		<table border="0" cellspacing="0" cellpadding="6">
			<tr>
				<td bgcolor="#000000">
					<font color="#FFFFFF">
						<strong>
							<xsl:value-of select="label"/>
						</strong>
						<br/>
						<i>
							<xsl:value-of select="title"/>
						</i>
					</font>
				</td>
			</tr>
			<xsl:for-each select="pages/page">
				<tr bgcolor="#ffffff">
					<td width="100%" height="100%" valign="middle" onMouseOver="this.style.background='#eeeeee'" onMouseOut="this.style.background='#ffffff'">
						<a onFocus="this.blur();" style="width=100%" href="#">
							<xsl:attribute name="title"><xsl:value-of select="title"/></xsl:attribute>
							<xsl:value-of select="label"/>
						</a>
					</td>
				</tr>
			</xsl:for-each>
			<tr>
				<td>The above links lead nowhere - but try to hoover over them.</td>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>
