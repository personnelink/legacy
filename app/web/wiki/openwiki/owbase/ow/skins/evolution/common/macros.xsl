<?xml version="1.0" encoding="utf-8"?>
<!--
### Common layout for macro displays ###
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
  <!-- New layout for the progressbar macro ____________________________ -->
  <xsl:template match="ow:progressbar">
    <div>
      <xsl:attribute name="style">
        width: <xsl:value-of select="@pbWidth"/>px; height: 20px; border-right: gray 1px solid; border-top: gray 1px solid; border-left: gray 1px solid; border-bottom: gray 1px solid;
      </xsl:attribute>
      <img src="{/ow:wiki/ow:skinpath}/images/progress.jpg" height="20px">
        <xsl:attribute name="width">
          <xsl:value-of select="@pbWidthPercent"/>px
        </xsl:attribute>
      </img>
    </div>
    <div>
      <xsl:attribute name="style">
        left: <xsl:value-of select="@pbWidth"/>px; height: 20px; background-color: transparent; position: relative; top: -20px;
      </xsl:attribute>
      <xsl:value-of select="@pbPercent"/>%
    </div>
  </xsl:template>
  <!-- _____________________________________________________________ -->
  
  
</xsl:stylesheet>

