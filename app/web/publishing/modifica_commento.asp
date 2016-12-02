<!--#include file="include/common.asp" -->
<!--#include file="include/funzioni_filtro.asp" -->
<%
Response.Buffer = True
Dim blog_id
Dim commento_autore
Dim commento_email
Dim commento_testo
Dim commento_id
Dim data
Dim msg


If Session("admin") = False or IsNull(Session("admin")) = True then
	Response.Redirect"login.asp?strMode=edit"
End If

commento_id = CLng(Request.Form("commento_id"))
blog_id = CLng(Request.Form("blog_id"))
data = Request.Form("data")
commento_autore = Request.Form("nome")
commento_email = Request.Form("email")
commento_testo = Request.Form("commento")

' remove tags
commento_autore = removemaligno(commento_autore)
commento_email = removemaligno(commento_email)
commento_testo = removemaligno(commento_testo)

commento_testo = Replace(commento_testo, vbCrLf, "<br>")

strSQL = "UPDATE commenti SET blog_id = '"&blog_id&"', commento_autore = '"&commento_autore&"', commento_email = '"&commento_email&"', data = '"&data&"', commento_testo = '"&commento_testo&"' WHERE commento_id = " & commento_id & ";"
adoCon.Execute strSQL

Set adoCon = Nothing
Set strCon = Nothing


msg = strLangInfoEditComment
Response.Redirect "editallcommenti.asp?blog_id=" & blog_id & "&msg="& msg &""
%>
