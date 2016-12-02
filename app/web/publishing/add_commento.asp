<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="include/common.asp" -->
<!--#include file="include/calendario.asp" -->
<!--#include file="include/funzioni_filtro.asp" -->
<%
Response.Buffer = True
Dim iMonth, iYear, giorno, archivio
iMonth=Request ("month")
iYear=Request ("year")
if iMonth = "" then iMonth = Month(Now)
sMonth=NameFromMonth(iMonth)
if iYear = "" then iYear = Year(Now)
giorno=request.QueryString("giorno")
archivio=request.QueryString("archivio")

Dim commento_autore
Dim commento_email
Dim commento_testo
Dim blog_id
Dim strEmailSubject
Dim strEmailBody
Dim blnAlreadyPostsed
Dim errore
Dim rs_blog
Dim titolo


If isNull(Request.QueryString("blog_id")) = True Or isNumeric(Request.QueryString("blog_id")) = False Then
	Response.redirect "index.asp?month=" & iMonth &"&year=" & iYear &"&giorno=" & giorno & "&archivio="& archivio &""
Else
	blog_id = CLng(Request.QueryString("blog_id"))
	
End If
errore = false
If Trim(Request.form("nome")) = "" Or Trim(Request.form("commento")) = "" Then
	 errore = true
End If

commento_autore = Request.Form("nome")
commento_email = Request.Form("email")
commento_testo = Request.Form("commento")

'remove html tags
commento_autore = removeAllTags(commento_autore)
commento_email = removeAllTags(commento_email)
commento_testo = removeAllTags(commento_testo)

' UBB code
commento_testo = Replace(commento_testo, "[B]", "<b>", 1, -1, 1)
commento_testo = Replace(commento_testo, "[/B]", "</b>", 1, -1, 1)
commento_testo = Replace(commento_testo, "[I]", "<i>", 1, -1, 1)
commento_testo = Replace(commento_testo, "[/I]", "</i>", 1, -1, 1)
commento_testo = Replace(commento_testo, "[U]", "<u>", 1, -1, 1)
commento_testo = Replace(commento_testo, "[/U]", "</u>", 1, -1, 1)


' link
commento_testo = SPLIT(commento_testo,VbCrLf)
FOR m=0 TO ubound(commento_testo)
parola = SPLIT(commento_testo(m)," ")

FOR i=0 TO ubound(parola)
IF Mid (parola(i),1,7) = "http://" THEN
parola(i)="<a href="""&parola(i)&""" target=""_blank"">"&parola(i)&"</a>"
END IF

IF Mid (parola(i),1,4) = "www." THEN
parola(i)="<a href=""http://"&parola(i)&""" target=""_blank"">"&parola(i)&"</a>"
END IF

IF (InStr(parola(i),"@") <> 0) AND (InStr(parola(i),".") <> 0) THEN
parola(i)="<a href=""mailto:"&parola(i)&""">"&parola(i)&"</a>"
END IF

NEXT
commento_testo(m)=JOIN(parola," ")
NEXT
commento_testo = JOIN(commento_testo,VbCrLf)

commento_testo = Replace(commento_testo, vbCrLf, "<br>")
' fine format

If blnCookieSet = True Then
	If CBool(Request.Cookies("Ublog")("Commenti" & blog_id)) = True Then blnAlreadyPostsed = True
End If

If blnAlreadyPostsed = False AND errore = False Then
    
    strSQL = "INSERT INTO commenti (blog_id,commento_autore,commento_email,data,commento_testo) VALUES ('"&blog_id&"','"&commento_autore&"','"&commento_email&"','"&Now()&"','"&commento_testo&"');"
	adoCon.Execute strSQL

	If blnCookieSet = True Then
		Response.Cookies("Ublog")("Commenti" & blog_id) = True
		Response.Cookies("Ublog").Expires = DateAdd("n", 30, Now())
	End If
		
	If blnEmail = True Then
	    set rs_blog = adoCon.execute("SELECT blog_titolo FROM blog WHERE blog_id = " & blog_id & ";")
		if not(rs_blog.eof) then
			titolo = rs_blog("blog_titolo")
		end if
		rs_blog.close
        set rs_blog= nothing

		strEmailSubject = strLangSubjectEmailNewComment
		strEmailBody = strLangEmailHi
		strEmailBody = strEmailBody & "<br><br>" & strLangEmailBodyBlog1 & ""
		strEmailBody = strEmailBody & "<br>" & strLangEmailBodyComment & " " & titolo & ": -"
		strEmailBody = strEmailBody & "<br><br><b>" & strLangFormAuthor & ": </b>" & commento_autore
		strEmailBody = strEmailBody & "<br><b>" & strLangFormEmail & ": </b>" & commento_email
		strEmailBody = strEmailBody & "<br><b>" & strLangFormComment & ":</b><br>" & commento_testo
		
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
	
	Set adoCon = Nothing
	Set strCon = Nothing
	
	Response.Redirect "blog_commento.asp?blog_id=" & blog_id & "&month=" & iMonth &"&year=" & iYear &"&giorno=" & giorno & "&archivio="& archivio &""

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
    <td colspan="2" align="right"><u><% = strLangNavAddComment %></u> &nbsp;<img src="immagini/freccia.gif"><img src="immagini/freccia.gif">&nbsp;&nbsp;<font class="arancio"><b> 
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
    <td valign="top" align="center"><br><br><br>
      <% If blnAlreadyPostsed = True Then %>
     <% = strLangErrorMessageOnlyOneCom %><br>
      <br>
<a href="blog_commento.asp?blog_id=<% = blog_id %>&month=<% = iMonth %>&year=<% = iYear %>&giorno=<% = giorno %>&archivio=<% =archivio %>"><% = strLangNavBackPrevPage %></a><br>
<% Else %>
      <% = strLangErrorMessageNeedAuthorText %><br>
      <br>
<a href="blog_commento.asp?blog_id=<% = blog_id %>&month=<% = iMonth %>&year=<% = iYear %>&giorno=<% = giorno %>&archivio=<% =archivio %>"><% = strLangNavBackPrevPage %></a><br>
<% End If %>
	
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
