<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="include/common.asp" -->
<!--#include file="include/calendario.asp" -->
<%
Response.Buffer = True
Dim iMonth, iYear
iMonth=Request ("month")
iYear=Request ("year")
if iMonth = "" then iMonth = Month(Now)
sMonth=NameFromMonth(iMonth)
if iYear = "" then iYear = Year(Now)
Dim blog_id
Dim rsblog
Dim blog_autore
Dim email
Dim blog_titolo
Dim blog_testo
Dim blnComments
Dim data
Dim ora
Dim giorno
Dim mese
Dim anno
Dim strMode
strMode = "new"
%>

<html>
<head>
<title><% = Ublogname %></title>
<!--#include file="include/metatag.inc" -->
<LINK href="include/styles.css" rel=stylesheet>
</head>
<!--#include file="include/header.asp" -->
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
<!--#include file="include/menu.asp" -->
  <tr> 
    <td colspan="2"><div class="hrgreen"><img src="immagini/spacer.gif"></div></td>
  </tr>
  <tr> 
    <td colspan="2" align="right"><u><% = strLangSelectNewBlog %></u> &nbsp;<img src="immagini/freccia.gif"><img src="immagini/freccia.gif">&nbsp;&nbsp;<font class="arancio"><b> 
      <% = Date() %>
      </b></font>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
</table>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" height="250">
  <tr> 
<!--#include file="include/layer_sx.asp" -->
    <td width="3" rowspan="2" background="immagini/punto.gif"><img src="immagini/bianco.gif"></td>
    <td valign="top" align="center">
	<% if Ublogtype = "open" then %>
	<!--#include file="form_blog.asp" -->
	<% elseif Session("admin") = False or IsNull(Session("admin")) = True then 
	      Response.Redirect"login.asp?strMode=" & strMode & ""
	   else %>
	<!--#include file="form_blog.asp" -->
	<% end if %>
	</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<% 
Set adoCon = Nothing
Set strCon = Nothing
%>
<!--#include file="include/footer.asp" -->
