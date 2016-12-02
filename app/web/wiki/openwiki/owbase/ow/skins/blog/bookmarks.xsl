<?xml version="1.0"?>
<!-- edited with NotePad -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
  <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
  <!-- VARIABLES -->
  
  <!-- TEMPLATES -->
  <xsl:template name="bookmarks">
    <!-- bookmarkmenutext define the label to be showed before the Default User Bookmarks -->
    <xsl:if test="string($bookmarkmenutext)">
      <strong class="bookmarks">
        <xsl:value-of select="string($bookmarkmenutext)"/>
      </strong>
    </xsl:if>
    <xsl:for-each select="ow:link">
      <a class="bookmarks" href="{@href}">
        <xsl:call-template name="cleanslash">
          <xsl:with-param name="runmode" select="string($bookmark_cleanslash)"/>
          <xsl:with-param name="thetext" select="string(text())"/>
        </xsl:call-template>
      </a>
      <xsl:if test="not(position()=last())"> | </xsl:if>
    </xsl:for-each>

    <!-- default-bookmarks -->
    <!-- <AddBookmarks(SandBox1 SandBox2 SandBox3, Default Bookmarks)/> -->
    <xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
      <xsl:choose>
        <xsl:when test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading">
          <br/>
          <strong>
            <xsl:value-of select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading"/>:
          </strong>
        </xsl:when>
        <xsl:otherwise> | </xsl:otherwise>
      </xsl:choose>
      <xsl:for-each select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
        <xsl:choose>
          <xsl:when test="@name='----'"></xsl:when>
          <xsl:otherwise>
            <a class="bookmarks" href="{@href}">
              <xsl:call-template name="cleanslash">
                <xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
                <xsl:with-param name="thetext" select="string(text())"/>
              </xsl:call-template>
            </a>
            <xsl:if test="not (position()=last())"> | </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:if>

    <!-- page-bookmarks -->
    <!-- <AddBookmarks(*SandBox1 SandBox2 SandBox3, Page Bookmarks)/> -->
    <xsl:if test="/ow:wiki/ow:pagebookmarks/pagebookmarks">
      <xsl:for-each select="/ow:wiki/ow:pagebookmarks/pagebookmarks">
        <xsl:choose>
          <xsl:when test="@heading">
            <br/>
            <strong><xsl:value-of select="@heading"/>: </strong>
          </xsl:when>
          <xsl:otherwise> | </xsl:otherwise>
        </xsl:choose>
        <xsl:for-each select="ow:link">
          <xsl:choose>
            <xsl:when test="@name='----'"></xsl:when>
            <xsl:otherwise>
              <a class="bookmarks" href="{@href}">
                <xsl:call-template name="cleanslash">
                  <xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
                  <xsl:with-param name="thetext" select="string(text())"/>
                </xsl:call-template>
              </a>
              <xsl:if test="not (position()=last())"> | </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:if>

  </xsl:template>

</xsl:stylesheet>
