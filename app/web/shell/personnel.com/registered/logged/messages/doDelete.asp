<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->

<%

dim rsDelMsg, sqlDelMsg
sqlDelMsg = "DELETE FROM tbl_member_messages WHERE msg_id =" & request("id") & " AND mbr_id = " & session("mbrID")
Set rsDelMsg = Connect.Execute(sqlDelMsg)

set rsDelMsg = Nothing
response.redirect("index.asp")
%>