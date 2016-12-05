<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->

<%
dim rsDelRes, sqlDelRes
' We don't physically delete so employers may still view these deleted resumes
sqlDelRes = "UPDATE tbl_resumes SET res_is_deleted = 1 WHERE res_id=" & request("id") & " AND mbr_id=" & session("mbrID")
Set rsDelRes = Connect.Execute(sqlDelRes)

Set rsDelRes = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("index.asp")
%>