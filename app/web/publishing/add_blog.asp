<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="include/common.asp" -->
<!--#include file="include/calendario.asp" -->
<!--#include file="include/funzioni_filtro.asp" -->
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
Dim blog_email
Dim blog_titolo
Dim blog_testo
Dim blnComments
Dim strMode
Dim strEmailSubject
Dim strEmailBody
Dim msg
Dim errore
Dim data
Dim ora
Dim giorno
Dim mese
Dim anno
errore = false
strMode = Request.Form("strMode")

if Ublogtype = "closed" then
If Session("admin") = False or IsNull(Session("admin")) = True then
	Response.Redirect"login.asp?strMode=" & strMode & ""
End If
end if

If strMode = "edit" Then blog_id = CLng(Request.Form("blog_id"))


If Trim(Request.form("blog_autore")) = "" Or Trim(Request.form("blog_titolo")) = "" Or Trim(Request.form("blog_testo")) = "" Then
	 errore = true
End If


blog_autore = Request.Form("blog_autore")
blog_email = Request.Form("email")
blog_titolo = Request.Form("blog_titolo")
blog_testo = Request.Form("blog_testo")

' format input user and remove html tag
blog_autore = removeAllTags(blog_autore)
blog_email = removeAllTags(blog_email)
blog_titolo = removeAllTags(blog_titolo)

If strMode = "new" AND Ublogtype = "open" Then
blog_testo = removeAllTags(blog_testo)
blog_testo = UBBcode(blog_testo)
else
blog_testo = removemaligno(blog_testo)
End if
blog_testo = Replace(blog_testo, VbCrLf, "<br>")

data = Request.Form("data")
ora = Request.Form("ora")
blnComments = Request.Form("comments")
giorno = Request.form("giorno")
mese = Request.Form("mese")
anno = Request.Form("anno")


If blnComments = "" Then 
blnComments = "False"
end if


If data = "" Then 
data = Date()
end if

If ora = "" Then 
ora = Time()
end if

If giorno = "" then
giorno = Right(CStr(100+Day(Date)), 2)
else
giorno = Right(CStr(100+giorno), 2)
end if

If mese = "" then
mese = Right(CStr(100+Month(Date)), 2)
else
mese =Right(CStr(100+mese), 2)
end if

If anno = "" then
anno = Year(Date)
end if

	
Set rsblog = Server.CreateObject("ADODB.Recordset")

If errore = false then
   If strMode = "edit" Then
       strSQL = "UPDATE blog SET blog_titolo = '"&blog_titolo&"', blog_testo = '"&blog_testo&"', blog_autore = '"&blog_autore&"', blog_email = '"&blog_email&"', data = '"&data&"', ora = '"&ora&"', giorno = '"&giorno&"', mese = '"&mese&"', anno = '"&anno&"', commenti = '"&blnComments&"' WHERE blog_id = " & blog_id & ";"
   Else
	   strSQL = "INSERT INTO blog (blog_titolo,blog_testo,blog_autore,blog_email,data,ora,giorno,mese,anno,commenti) VALUES ('"&blog_titolo&"','"&blog_testo&"','"&blog_autore&"','"&blog_email&"','"&data&"','"&ora&"','"&giorno&"','"&mese&"','"&anno&"','"&blnComments&"');"
   End If
   adoCon.Execute strSQL

	If blnEmail = True AND strMode <> "edit" Then
		strEmailSubject = strLangSubjectEmailNewBlog

		strEmailBody = strLangEmailHi
		strEmailBody = strEmailBody & "<br><br>" & strLangEmailBodyBlog1 & ""
		strEmailBody = strEmailBody & "<br>" & strLangEmailBodyBlog2 & ""
		strEmailBody = strEmailBody & "<br><br><b>" & strLangFormTitle & ": </b>" & blog_titolo
		strEmailBody = strEmailBody & "<br><br><b>" & strLangFormAuthor & ": </b>" & blog_autore
		strEmailBody = strEmailBody & "<br><b>" & strLangFormEmail & ": </b>" & email
		strEmailBody = strEmailBody & "<br><b>" & strLangFormText & ":</b><br>" & blog_testo
		
       	Dim objCDOMail
		Set objCDOMail = Server.CreateObject("CDONTS.NewMail")
		objCDOMail.From = Ublogname & " <" & emailamministratore & ">"
		objCDOMail.To = "<" & emailamministratore & ">"
        objCDOMail.Subject = strEmailSubject
		objCDOMail.Body = strEmailBody
		objCDOMail.BodyFormat = 0
		objCDOMail.MailFormat = 0
		objCDOMail.Importance = 1 
		objCDOMail.Send
		Set objCDOMail = Nothing
	
	End If

   If strMode = "edit" then
   msg = strLangInfoEditBlog
      Response.Redirect "editallblog.asp?msg="& msg &""
   Elseif Ublogtype ="open" then
      Response.Redirect "index.asp"
   Else
      msg = strLangInfoInsertBlog
      Response.Redirect "editallblog.asp?msg="& msg &""
   End If
   
End If
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
    <td colspan="2" align="right"><% if strMode= "edit" then %><u><% = strLangNavEditBlog %></u> &nbsp;<img src="immagini/freccia.gif"><img src="immagini/freccia.gif">&nbsp;&nbsp;<font class="arancio"><b> 
      <% = data %><% else %><u><% = strLangSelectNewBlog %></u> &nbsp;<img src="immagini/freccia.gif"><img src="immagini/freccia.gif">&nbsp;&nbsp;<font class="arancio"><b> 
      <% = Date() %><% end if %>
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
    <td valign="top" align="center"><br><br><br>
      <% If errore = True Then %>
     <% = strLangErrorMessageNeedAuthorTitleText %><br>
      <br>
          <% if strMode = "new" then %>	  
              <a href="newblog.asp"><% = strLangNavBackPrevPage %></a><br>
          <% else %>
              <a href="edit_blog.asp?blog_id=<% = blog_id %>"><% = strLangNavBackPrevPage %></a><br>
      <%     End If
	     End If %>
	
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
