<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
	<xsl:template name="pagebody">
		<body onload="window.defaultStatus='{$brandingText}'">
			<table class="regions">
				<tr valign="top">
					<td class="regionheader" valign="top">
						<xsl:call-template name="regionheader"/>
					</td>
				</tr>
				<tr valign="top">
					<td valign="top">
						<table valign="top" class="regionmiddle">
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
	</xsl:template>
</xsl:stylesheet>
