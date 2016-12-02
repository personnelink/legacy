<!--#include file="include/common.asp" -->
<%
If Session("admin") = False or IsNull(Session("admin")) = True then
	response.Redirect("login.asp?strMode=edit")
End If
%>
<%
Response.Buffer = True

Dim blog_id
Dim commento_id
Dim msg

commento_id = Request.querystring("commento_id")
blog_id = Request.querystring("blog_id")


strSQL = "Delete from commenti where commento_id ='"&commento_id&"';"
adoCon.Execute strSQL 

Set adoCon = Nothing
Set strCon = Nothing
msg = strLangInfoDelComment
response.Redirect("editallcommenti.asp?msg="& msg &"&blog_id=" & blog_id & "")
%>
