<!--#include file="include/common.asp" -->
<%
Dim rs
Dim strUserName 	
Dim strUserPassword
Dim strMode
strMode = request.form("strMode")
strUserName = Replace(Request.Form("txtUserName"),"'","''")
strUserPassword = Replace(Request.Form("txtUserPass"),"'","''")

Set rs = Server.CreateObject("ADODB.Recordset")
strSQL = "SELECT configurazione.password, configurazione.username "
strSQL = strSQL & "FROM configurazione "
strSQL = strSQL & "WHERE configurazione.username ='" & strUserName & "'"
rs.Open strSQL, strCon

If NOT rs.EOF Then
	If strUserPassword = rs("password") Then
	
		Session("admin") = True
		Session.Timeout=40
		Set rs = Nothing
		Set strCon = Nothing
		Set adoCon = Nothing
		
		If strMode = "new" then
		Response.Redirect "newblog.asp"
		elseif strMode = "config" then
		Response.Redirect "configura.asp"
		else
		Response.Redirect "editallblog.asp"
		end if
		
	End If
End If
		
rs.Close
Set rs = Nothing
Set strCon = Nothing
Set adoCon = Nothing
	
Session("admin") = False
Response.Redirect("login.asp?strMode=" & strMode & "&msg=" & Server.URLEncode("<u>" & strLangErrorMessageLogin & "</u>"))
%>



