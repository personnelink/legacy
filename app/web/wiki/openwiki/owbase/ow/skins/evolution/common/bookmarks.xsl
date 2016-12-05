<?xml version="1.0" encoding="utf-8"?>
<!--
### Evolution skin ###
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
  <!-- Title for user default bookmarks ____________________________ -->
  <xsl:template name="mainmenu_title">
    <xsl:if test="$showbookmarkmenutext='yes'">
      <strong>
        <xsl:value-of select="$bookmarkmenutext"/>
      </strong>
    </xsl:if>
  </xsl:template>
  <!-- _____________________________________________________________ -->
  
  <!-- Bookmarks template __________________________________________ -->
  <xsl:template name="bookmarks">
    
    <!-- Default-bookmarks -->
    <!-- <AddBookmarks(WikiPage1 WikiPage2, Mybookmarks)/> -->
    <xsl:call-template name="mainmenu_title"/>
    <xsl:for-each select="ow:link">
      <a class="bookmarks" href="{@href}">
        <xsl:call-template name="cleanslash">
          <xsl:with-param name="runmode" select="string($bookmark_cleanslash)"/>
          <xsl:with-param name="thetext" select="string(text())"/>
        </xsl:call-template>
      </a>
      <xsl:if test="not(position()=last())">
        <xsl:value-of select="$separatorcharacter"/>
      </xsl:if>
    </xsl:for-each>
    <xsl:if test="$showfurniture='yes'">
      <xsl:if test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
        <xsl:choose>
          <xsl:when test="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading">
            <br/>
            <strong>
              <xsl:value-of select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/@heading"/>:
            </strong>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$separatorcharacter"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:for-each select="/ow:wiki/ow:userpreferences/ow:pagebookmarks/ow:link">
          <xsl:choose>
            <xsl:when test="@name='----'">
              <br/>
            </xsl:when>
            <xsl:otherwise>
              <a class="bookmarks" href="{@href}">
                <xsl:call-template name="cleanslash">
                  <xsl:with-param name="runmode" select="string($pagebookmark_cleanslash)"/>
                  <xsl:with-param name="thetext" select="string(text())"/>
                </xsl:call-template>
              </a>
              <xsl:if test="not (position()=last())">
                <xsl:value-of select="$separatorcharacter"/>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:if>
    </xsl:if>

    <!-- Page-bookmarks -->
    <!-- <AddBookmarks(*WikiPage1 WikiPage2, Mybookmarks)/> -->
    <xsl:if test="/ow:wiki/ow:pagebookmarks/pagebookmarks">
      <xsl:for-each select="/ow:wiki/ow:pagebookmarks/pagebookmarks">
        <xsl:choose>
          <xsl:when test="@heading"><br/>
            <strong><xsl:value-of select="@heading"/>:</strong>
          </xsl:when>
          <xsl:otherwise> | </xsl:otherwise>
        </xsl:choose>
        <xsl:for-each select="ow:link">
          <xsl:choose>
            <xsl:when test="@name='----'"><br/>
            </xsl:when>
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
  <!-- _____________________________________________________________ -->
  
</xsl:stylesheet>

