<?xml version="1.0"?>
<!--
### TAG ###
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
  <!-- Tags ____________________________ -->
  <xsl:template name="tag_show">
    <!--TAG START by 1mmm-->
    <xsl:if test="/ow:wiki/ow:tag/@active='yes'">
      <!-- only proceed if cUseTags=1 -->
      <xsl:choose>
        <xsl:when test="../../../ow:body">
          <!-- don't show in an included page -->
        </xsl:when>
        <xsl:otherwise>
          <br/>
          <div class="Tags">
            <a  title="tags index,show tags cloud" href="?a=tagsindex" class="twikiLink">Tags</a>: <span class="tagMePlugin">
              <xsl:for-each select="/ow:wiki/ow:page/ow:change/ow:tags/ow:tag">
                <a title="show pages used this tag">
                  <xsl:attribute name="href">
                    <xsl:value-of select="/ow:wiki/ow:scriptname"/>?a=tagsearch&amp;txt=<xsl:value-of select="ow:urlencode(string(@name))"/>
                  </xsl:attribute>
                  <xsl:value-of select="@name"/>
                </a>,
              </xsl:for-each>
            </span>
          </div>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <!--TAG END-->
  </xsl:template>
  <!-- _____________________________________________________________ -->
  
  <xsl:template name="tag_edit">
		<!--TAG START by 1mmm-->
		<xsl:if test="/ow:wiki/ow:tag/@active='yes'"><!-- only proceed if cUseTags=1 -->
			<br/><font color="#ff0000">Tags: </font>
			<input type="text" name="edtTag" maxlength="100" size="50">
				<xsl:attribute name="value"><xsl:value-of select="ow:page/ow:change/ow:tags/@tags"/></xsl:attribute>
			</input>
			&#160;split by <xsl:value-of select="/ow:wiki/ow:tag/@split"/>(<a href="?help/tag" target="_blank">what is Tags?<img src="ow/images/popup.gif" width="15" height="9" border="0" alt=""/></a>)
		</xsl:if>	
		<!--TAG END-->			
  </xsl:template>
 
	<!-- #TagSEARCH added by 1mmm-->


	<!-- #TagsINDEX added by 1mmm-->
	

<!-- This template is for the macro <TagsIndex> -->
	<xsl:template match="ow:tagsindex">
		<h1>Tags Cloud (<xsl:value-of select="/ow:wiki/ow:page/ow:body/ow:tagsindex/@num"/>)</h1>
		<xsl:for-each select="/ow:wiki/ow:page/ow:body/ow:tagsindex/ow:tag">
			<a title="search it">
				<xsl:attribute name="href"><xsl:value-of select="ow:scriptname"/>?a=tagsearch&amp;txt=<xsl:value-of select="ow:urlencode(string(@name))"/></xsl:attribute><font>
				<xsl:attribute name="style">font-size:<xsl:value-of select="@size"/>;line-height:1em</xsl:attribute><xsl:value-of select="@name"/></font>
			</a><small><font style="color:#888">(<xsl:value-of select="@count"/>)</font></small>&#160;
		</xsl:for-each>

		<br/><br/>
	</xsl:template>


  <!-- This template is for the macro <TagSearch> -->
  <xsl:template match="ow:tagsearch">
    <ul>
      <xsl:for-each select="ow:page">
        <li>
          <xsl:if test="contains(@name, '/')">
            ....
          </xsl:if>
          <xsl:apply-templates select="ow:link"/>
          <xsl:if test="/ow:wiki/ow:summary/@active='yes'">
            <xsl:text> - </xsl:text>
            <small>
              <xsl:value-of select="ow:change/ow:summary/text()" />
            </small>
          </xsl:if>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>  
  
</xsl:stylesheet>

