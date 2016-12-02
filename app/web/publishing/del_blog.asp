<!--#include file="include/common.asp" -->
<%
If Session("admin") = False or IsNull(Session("admin")) = True then
	response.Redirect("login.asp?strMode=edit")
End If
%>
<%
Response.Buffer = True

Dim rsCount
Dim SQLCount
Dim rs
Dim blog_id
Dim numero_commenti
Dim i
Dim SQL
Dim rsdelete
Dim commento_id
Dim msg

blog_id = Request.querystring("blog_id")

strSQL = "Delete from blog where blog_id =" & blog_id
adoCon.Execute strSQL 

Set rs = Server.CreateObject("ADODB.Recordset")
strSQL = "Select * from commenti where blog_id =" & blog_id
rs.CursorType = 3
rs.Open strSQL, strCon
SQLCount = "SELECT COUNT(*) as numero_commenti FROM commenti"
set rsCount = adoCon.Execute(SQLCount) 
numero_commenti = rsCount("numero_commenti") 
rsCount.Close 
set rsCount=Nothing 
For i = 1 to numero_commenti
     If rs.EOF Then Exit For
     commento_id = rs("commento_id")
	 SQL="delete FROM commenti where commento_id=" & commento_id
     set rsdelete=adoCon.execute(SQL)
	 Set rsdelete = Nothing
	 rs.MoveNext  
Next
rs.Close
Set rs = Nothing

Set adoCon = Nothing
Set strCon = Nothing
msg = strLangInfoDelBlog
response.Redirect("editallblog.asp?msg="& msg &"")
%>
