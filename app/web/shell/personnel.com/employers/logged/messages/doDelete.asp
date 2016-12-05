<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpAuth.asp' -->

<%
set rsMessages = Server.CreateObject("ADODB.RecordSet")
rsMessages.CursorLocation = 3
rsMessages.Open "DELETE FROM tbl_employer_messages WHERE emp_id= " & session("empID") & " AND msg_id= " & request("ID"),Connect

Set rsMessages = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("index.asp")
%>