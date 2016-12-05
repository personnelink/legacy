<!--#include file="include/common.asp" -->
<!--#include file="include/funzioni_filtro.asp" -->
<%
Dim blog_autore
Dim blog_titolo
Dim blog_testo
Dim blog_modo 
Dim blog_data
Dim blog_ora

blog_autore = Request.Cookies("Blog_Autore")
blog_titolo = Request.Cookies("Blog_Titolo")
blog_testo = Request.Cookies("Blog_Testo")
blog_modo = Request.Cookies("Blog_Modo")
blog_data = Request.Cookies("Blog_Data")
blog_ora = Request.Cookies("Blog_Ora")

If blog_autore = "" Then blog_autore = "Boh"
If blog_titolo = "" Then blog_titolo = "Boh"

If blog_modo = "new" Then
blog_testo = UBBcode(blog_testo)
End if
blog_testo = Replace(blog_testo, Chr(10), "<br>", 1, -1, 1)
If blog_data = "" Then blog_data = Date()
If blog_ora = "" Then blog_ora = Time()
If blog_testo = "" OR IsNull(blog_testo) Then
	blog_testo = "<br><br><div align=""center"">" & strLangErrorPreview & "</div><br><br>"
End If

%>
<html>
<head>
<title>Blog preview</title>
<!--#include file="include/metatag.inc" -->
<LINK href="include/styles.css" rel=stylesheet>
</head>
<body>
<table width="95%" border="0" cellspacing="0" cellpadding="1" align="center" height="53">
  <tr> 
    <td align="center" height="17"><font class="green"><b>BLOG PREVIEW</b></font></td>
  </tr>
  <tr>
    <td align="center" height="39"><a href="JavaScript:onClick=window.close()"><% = strLangSelectCloseWindow %></a></td>
  </tr>
</table>
      <table width="95%" border="0" cellspacing="0" cellpadding="0" class="tablemenu" align="center">
        <tr> 
          <td width="70%"><b><% = UCase(blog_titolo) %></b>&nbsp;&nbsp;<% = strLangGlobBy %>&nbsp;<b><% = blog_autore %></b></td>
          <td align="right"> <% = FormatDateTime(blog_data, vbShortDate) %>&nbsp;<% = strLangGlobAt %>&nbsp;<% = FormatDateTime(blog_ora,vbShortTime) %>
              </tr>
        <tr> 
          <td colspan="2">&nbsp;
          </td>
        </tr>
        <tr> 
          <td colspan="2"> 
            <div class="hrgreen"><img src="immagini/spacer.gif"></div>
          </td>
        </tr>
        <tr> 
          <td ALIGN="JUSTIFY" colspan="2"><% = blog_testo %>
          </td>
        </tr>
        <tr>
          <td colspan="2"> 
           <div class="hrgreen"><img src="immagini/spacer.gif"></div>
          </td>
        </tr>
        <tr> 
          <td colspan="2">&nbsp;
          </td>
        </tr>
      </table>

<table width="95%" border="0" cellspacing="0" cellpadding="1" align="center">
  <tr>
    <td align="center" height="39"><a href="JavaScript:onClick=window.close()"><% = strLangSelectCloseWindow %></a></td>
  </tr>
</table>
</body>
</html>