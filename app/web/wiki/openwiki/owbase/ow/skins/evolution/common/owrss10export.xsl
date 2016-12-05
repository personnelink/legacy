<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://purl.org/rss/1.0/" xmlns:msxsl="urn:schemas-microsoft-com:xslt" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
	<xsl:include href="../common/owinc.xsl"/>
	<xsl:template match="/ow:wiki">
		<xsl:text disable-output-escaping="yes">&lt;?xml version="1.0" encoding="</xsl:text>
		<xsl:value-of select="@encoding"/>
		<xsl:text disable-output-escaping="yes">"?>
&lt;!-- RSS v1.0 generated by OpenWiki -->
</xsl:text>
		<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:wiki="http://purl.org/rss/1.0/modules/wiki/" xmlns:ti="http://purl.org/rss/1.0/modules/textinput/" xmlns="http://purl.org/rss/1.0/">
			<channel rdf:about="{ow:about}">
				<title>
					<xsl:value-of select="ow:title"/>
				</title>
				<link>
					<xsl:value-of select="ow:location"/>
					<xsl:value-of select="ow:scriptname"/>
				</link>
				<description>The post-it note of the web</description>
				<image rdf:resource="{ow:location}ow/images/logo_tiny.gif"/>
				<dc:language>en-us</dc:language>
				<dc:rights>Copyright 2005 - openWiking</dc:rights>
				<dc:date>
					<xsl:value-of select="ow:page/ow:body/*/ow:page/ow:change/ow:date"/>
				</dc:date>
				<dc:publisher>OpenWiking</dc:publisher>
				<dc:contributor>The readers of this openWiking site</dc:contributor>
				<wiki:interwiki>
					<rdf:Description link="{ow:location}">
						<rdf:value>
							<xsl:value-of select="ow:title"/>
						</rdf:value>
					</rdf:Description>
				</wiki:interwiki>
				<items>
					<rdf:Seq>
						<xsl:for-each select="ow:page/ow:body/*/ow:page">
							<rdf:li rdf:resource="{/ow:wiki/ow:location}{ow:link/@href}#{ow:change/@revision}"/>
						</xsl:for-each>
					</rdf:Seq>
				</items>
				<textinput rdf:resource="{/ow:wiki/ow:location}"/>
			</channel>
			<image rdf:about="{ow:location}ow/images/logo_tiny.gif">
				<title>
					<xsl:value-of select="ow:title"/>
				</title>
				<link>
					<xsl:value-of select="ow:location"/>
					<xsl:value-of select="ow:scriptname"/>
				</link>
				<url>
					<xsl:value-of select="ow:location"/>ow/images/logo_tiny.gif</url>
			</image>
			<xsl:for-each select="ow:page/ow:body/*/ow:page">
				<item rdf:about="{/ow:wiki/ow:location}{ow:link/@href}#{ow:change/@revision}">
					<title>
						<xsl:value-of select="ow:link/text()"/>
					</title>
					<description>
						<xsl:choose>
							<xsl:when test="ow:change/ow:summary/text()">
								<xsl:value-of select="ow:change/ow:summary/text()"/>
							</xsl:when>	
							<xsl:otherwise>
								<xsl:value-of select="ow:change/ow:comment"/>
							</xsl:otherwise>
						</xsl:choose>		
					</description>
					<link>
						<xsl:value-of select="/ow:wiki/ow:location"/>
						<xsl:value-of select="ow:link/@href"/>
					</link>
					<dc:date>
						<xsl:value-of select="ow:change/ow:date"/>
					</dc:date>
					<dc:contributor>
						<rdf:Description wiki:host="{ow:change/ow:by/@name}">
							<xsl:if test="ow:change/ow:by/@alias">
								<xsl:attribute name="link"><xsl:value-of select="/ow:wiki/ow:location"/><xsl:value-of select="/ow:wiki/ow:scriptname"/>?<xsl:value-of select="ow:change/ow:by/@alias"/></xsl:attribute>
							</xsl:if>
							<rdf:value>
								<xsl:value-of select="ow:change/ow:by/text()"/>
							</rdf:value>
						</rdf:Description>
					</dc:contributor>
					<wiki:version>
						<xsl:value-of select="ow:change/@revision"/>
					</wiki:version>
					<wiki:status>
						<xsl:value-of select="ow:change/@status"/>
					</wiki:status>
					<xsl:choose>
						<xsl:when test="@minor='true'">
							<wiki:importance>minor</wiki:importance>
						</xsl:when>
						<xsl:otherwise>
							<wiki:importance>major</wiki:importance>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="@changes &gt; 1">
						<wiki:diff>
							<xsl:value-of select="/ow:wiki/ow:location"/>
							<xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="ow:urlencode(string(ow:link/@name))"/>&amp;a=diff</wiki:diff>
						<wiki:history>
							<xsl:value-of select="/ow:wiki/ow:location"/>
							<xsl:value-of select="/ow:wiki/ow:scriptname"/>?p=<xsl:value-of select="ow:urlencode(string(ow:link/@name))"/>&amp;a=changes</wiki:history>
					</xsl:if>
				</item>
			</xsl:for-each>
			<textinput rdf:about="{/ow:wiki/ow:location}">
				<title>Search <xsl:value-of select="ow:title"/>
				</title>
				<description>Search <xsl:value-of select="ow:title"/>
				</description>
				<name>txt</name>
				<link>
					<xsl:value-of select="ow:location"/>
					<xsl:value-of select="ow:scriptname"/>?a=fullsearch</link>
				<ti:function>search</ti:function>
				<ti:inputType>regex</ti:inputType>
			</textinput>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>
